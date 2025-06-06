
obj/user/MidTermEx_ProcessA:     file format elf32-i386


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
  800031:	e8 36 01 00 00       	call   80016c <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 38             	sub    $0x38,%esp
	int32 parentenvID = sys_getparentenvid();
  80003e:	e8 d3 13 00 00       	call   801416 <sys_getparentenvid>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int delay;

	/*[1] GET SHARED VARIABLE, SEMAPHORE SEL, check-finishing counter*/
	int *X = sget(parentenvID, "X") ;
  800046:	83 ec 08             	sub    $0x8,%esp
  800049:	68 80 1e 80 00       	push   $0x801e80
  80004e:	ff 75 f4             	pushl  -0xc(%ebp)
  800051:	e8 96 10 00 00       	call   8010ec <sget>
  800056:	83 c4 10             	add    $0x10,%esp
  800059:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int *useSem = sget(parentenvID, "useSem") ;
  80005c:	83 ec 08             	sub    $0x8,%esp
  80005f:	68 82 1e 80 00       	push   $0x801e82
  800064:	ff 75 f4             	pushl  -0xc(%ebp)
  800067:	e8 80 10 00 00       	call   8010ec <sget>
  80006c:	83 c4 10             	add    $0x10,%esp
  80006f:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int *finishedCount = sget(parentenvID, "finishedCount") ;
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 89 1e 80 00       	push   $0x801e89
  80007a:	ff 75 f4             	pushl  -0xc(%ebp)
  80007d:	e8 6a 10 00 00       	call   8010ec <sget>
  800082:	83 c4 10             	add    $0x10,%esp
  800085:	89 45 e8             	mov    %eax,-0x18(%ebp)

	/*[2] DO THE JOB*/
	int Y ;
	//random delay
	delay = RAND(2000, 10000);
  800088:	8d 45 c8             	lea    -0x38(%ebp),%eax
  80008b:	83 ec 0c             	sub    $0xc,%esp
  80008e:	50                   	push   %eax
  80008f:	e8 de 16 00 00       	call   801772 <sys_get_virtual_time>
  800094:	83 c4 0c             	add    $0xc,%esp
  800097:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80009a:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  80009f:	ba 00 00 00 00       	mov    $0x0,%edx
  8000a4:	f7 f1                	div    %ecx
  8000a6:	89 d0                	mov    %edx,%eax
  8000a8:	05 d0 07 00 00       	add    $0x7d0,%eax
  8000ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	env_sleep(delay);
  8000b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000b3:	83 ec 0c             	sub    $0xc,%esp
  8000b6:	50                   	push   %eax
  8000b7:	e8 ba 18 00 00       	call   801976 <env_sleep>
  8000bc:	83 c4 10             	add    $0x10,%esp
//	cprintf("delay = %d\n", delay);

	Y = (*X) * 2 ;
  8000bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c2:	8b 00                	mov    (%eax),%eax
  8000c4:	01 c0                	add    %eax,%eax
  8000c6:	89 45 e0             	mov    %eax,-0x20(%ebp)

	//random delay
	delay = RAND(2000, 10000);
  8000c9:	8d 45 d0             	lea    -0x30(%ebp),%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 9d 16 00 00       	call   801772 <sys_get_virtual_time>
  8000d5:	83 c4 0c             	add    $0xc,%esp
  8000d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000db:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  8000e0:	ba 00 00 00 00       	mov    $0x0,%edx
  8000e5:	f7 f1                	div    %ecx
  8000e7:	89 d0                	mov    %edx,%eax
  8000e9:	05 d0 07 00 00       	add    $0x7d0,%eax
  8000ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	env_sleep(delay);
  8000f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f4:	83 ec 0c             	sub    $0xc,%esp
  8000f7:	50                   	push   %eax
  8000f8:	e8 79 18 00 00       	call   801976 <env_sleep>
  8000fd:	83 c4 10             	add    $0x10,%esp
//	cprintf("delay = %d\n", delay);

	(*X) = Y ;
  800100:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800103:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800106:	89 10                	mov    %edx,(%eax)

	//random delay
	delay = RAND(2000, 10000);
  800108:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	50                   	push   %eax
  80010f:	e8 5e 16 00 00       	call   801772 <sys_get_virtual_time>
  800114:	83 c4 0c             	add    $0xc,%esp
  800117:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80011a:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  80011f:	ba 00 00 00 00       	mov    $0x0,%edx
  800124:	f7 f1                	div    %ecx
  800126:	89 d0                	mov    %edx,%eax
  800128:	05 d0 07 00 00       	add    $0x7d0,%eax
  80012d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	env_sleep(delay);
  800130:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800133:	83 ec 0c             	sub    $0xc,%esp
  800136:	50                   	push   %eax
  800137:	e8 3a 18 00 00       	call   801976 <env_sleep>
  80013c:	83 c4 10             	add    $0x10,%esp
//	cprintf("delay = %d\n", delay);

	if (*useSem == 1)
  80013f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800142:	8b 00                	mov    (%eax),%eax
  800144:	83 f8 01             	cmp    $0x1,%eax
  800147:	75 13                	jne    80015c <_main+0x124>
	{
		sys_signalSemaphore(parentenvID, "T") ;
  800149:	83 ec 08             	sub    $0x8,%esp
  80014c:	68 97 1e 80 00       	push   $0x801e97
  800151:	ff 75 f4             	pushl  -0xc(%ebp)
  800154:	e8 0a 15 00 00       	call   801663 <sys_signalSemaphore>
  800159:	83 c4 10             	add    $0x10,%esp
	}

	/*[3] DECLARE FINISHING*/
	(*finishedCount)++ ;
  80015c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80015f:	8b 00                	mov    (%eax),%eax
  800161:	8d 50 01             	lea    0x1(%eax),%edx
  800164:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800167:	89 10                	mov    %edx,(%eax)

}
  800169:	90                   	nop
  80016a:	c9                   	leave  
  80016b:	c3                   	ret    

0080016c <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80016c:	55                   	push   %ebp
  80016d:	89 e5                	mov    %esp,%ebp
  80016f:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800172:	e8 86 12 00 00       	call   8013fd <sys_getenvindex>
  800177:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80017a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80017d:	89 d0                	mov    %edx,%eax
  80017f:	01 c0                	add    %eax,%eax
  800181:	01 d0                	add    %edx,%eax
  800183:	c1 e0 02             	shl    $0x2,%eax
  800186:	01 d0                	add    %edx,%eax
  800188:	c1 e0 06             	shl    $0x6,%eax
  80018b:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800190:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800195:	a1 20 30 80 00       	mov    0x803020,%eax
  80019a:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8001a0:	84 c0                	test   %al,%al
  8001a2:	74 0f                	je     8001b3 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8001a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a9:	05 f4 02 00 00       	add    $0x2f4,%eax
  8001ae:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001b3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001b7:	7e 0a                	jle    8001c3 <libmain+0x57>
		binaryname = argv[0];
  8001b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001bc:	8b 00                	mov    (%eax),%eax
  8001be:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001c3:	83 ec 08             	sub    $0x8,%esp
  8001c6:	ff 75 0c             	pushl  0xc(%ebp)
  8001c9:	ff 75 08             	pushl  0x8(%ebp)
  8001cc:	e8 67 fe ff ff       	call   800038 <_main>
  8001d1:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001d4:	e8 bf 13 00 00       	call   801598 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001d9:	83 ec 0c             	sub    $0xc,%esp
  8001dc:	68 b4 1e 80 00       	push   $0x801eb4
  8001e1:	e8 5c 01 00 00       	call   800342 <cprintf>
  8001e6:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ee:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f9:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001ff:	83 ec 04             	sub    $0x4,%esp
  800202:	52                   	push   %edx
  800203:	50                   	push   %eax
  800204:	68 dc 1e 80 00       	push   $0x801edc
  800209:	e8 34 01 00 00       	call   800342 <cprintf>
  80020e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800211:	a1 20 30 80 00       	mov    0x803020,%eax
  800216:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80021c:	83 ec 08             	sub    $0x8,%esp
  80021f:	50                   	push   %eax
  800220:	68 01 1f 80 00       	push   $0x801f01
  800225:	e8 18 01 00 00       	call   800342 <cprintf>
  80022a:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80022d:	83 ec 0c             	sub    $0xc,%esp
  800230:	68 b4 1e 80 00       	push   $0x801eb4
  800235:	e8 08 01 00 00       	call   800342 <cprintf>
  80023a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80023d:	e8 70 13 00 00       	call   8015b2 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800242:	e8 19 00 00 00       	call   800260 <exit>
}
  800247:	90                   	nop
  800248:	c9                   	leave  
  800249:	c3                   	ret    

0080024a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80024a:	55                   	push   %ebp
  80024b:	89 e5                	mov    %esp,%ebp
  80024d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800250:	83 ec 0c             	sub    $0xc,%esp
  800253:	6a 00                	push   $0x0
  800255:	e8 6f 11 00 00       	call   8013c9 <sys_env_destroy>
  80025a:	83 c4 10             	add    $0x10,%esp
}
  80025d:	90                   	nop
  80025e:	c9                   	leave  
  80025f:	c3                   	ret    

00800260 <exit>:

void
exit(void)
{
  800260:	55                   	push   %ebp
  800261:	89 e5                	mov    %esp,%ebp
  800263:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800266:	e8 c4 11 00 00       	call   80142f <sys_env_exit>
}
  80026b:	90                   	nop
  80026c:	c9                   	leave  
  80026d:	c3                   	ret    

0080026e <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80026e:	55                   	push   %ebp
  80026f:	89 e5                	mov    %esp,%ebp
  800271:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800274:	8b 45 0c             	mov    0xc(%ebp),%eax
  800277:	8b 00                	mov    (%eax),%eax
  800279:	8d 48 01             	lea    0x1(%eax),%ecx
  80027c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80027f:	89 0a                	mov    %ecx,(%edx)
  800281:	8b 55 08             	mov    0x8(%ebp),%edx
  800284:	88 d1                	mov    %dl,%cl
  800286:	8b 55 0c             	mov    0xc(%ebp),%edx
  800289:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80028d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800290:	8b 00                	mov    (%eax),%eax
  800292:	3d ff 00 00 00       	cmp    $0xff,%eax
  800297:	75 2c                	jne    8002c5 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800299:	a0 24 30 80 00       	mov    0x803024,%al
  80029e:	0f b6 c0             	movzbl %al,%eax
  8002a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002a4:	8b 12                	mov    (%edx),%edx
  8002a6:	89 d1                	mov    %edx,%ecx
  8002a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002ab:	83 c2 08             	add    $0x8,%edx
  8002ae:	83 ec 04             	sub    $0x4,%esp
  8002b1:	50                   	push   %eax
  8002b2:	51                   	push   %ecx
  8002b3:	52                   	push   %edx
  8002b4:	e8 ce 10 00 00       	call   801387 <sys_cputs>
  8002b9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002bf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c8:	8b 40 04             	mov    0x4(%eax),%eax
  8002cb:	8d 50 01             	lea    0x1(%eax),%edx
  8002ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002d1:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002d4:	90                   	nop
  8002d5:	c9                   	leave  
  8002d6:	c3                   	ret    

008002d7 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002d7:	55                   	push   %ebp
  8002d8:	89 e5                	mov    %esp,%ebp
  8002da:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002e0:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002e7:	00 00 00 
	b.cnt = 0;
  8002ea:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002f1:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002f4:	ff 75 0c             	pushl  0xc(%ebp)
  8002f7:	ff 75 08             	pushl  0x8(%ebp)
  8002fa:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800300:	50                   	push   %eax
  800301:	68 6e 02 80 00       	push   $0x80026e
  800306:	e8 11 02 00 00       	call   80051c <vprintfmt>
  80030b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80030e:	a0 24 30 80 00       	mov    0x803024,%al
  800313:	0f b6 c0             	movzbl %al,%eax
  800316:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80031c:	83 ec 04             	sub    $0x4,%esp
  80031f:	50                   	push   %eax
  800320:	52                   	push   %edx
  800321:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800327:	83 c0 08             	add    $0x8,%eax
  80032a:	50                   	push   %eax
  80032b:	e8 57 10 00 00       	call   801387 <sys_cputs>
  800330:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800333:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80033a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800340:	c9                   	leave  
  800341:	c3                   	ret    

00800342 <cprintf>:

int cprintf(const char *fmt, ...) {
  800342:	55                   	push   %ebp
  800343:	89 e5                	mov    %esp,%ebp
  800345:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800348:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80034f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800352:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800355:	8b 45 08             	mov    0x8(%ebp),%eax
  800358:	83 ec 08             	sub    $0x8,%esp
  80035b:	ff 75 f4             	pushl  -0xc(%ebp)
  80035e:	50                   	push   %eax
  80035f:	e8 73 ff ff ff       	call   8002d7 <vcprintf>
  800364:	83 c4 10             	add    $0x10,%esp
  800367:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80036a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80036d:	c9                   	leave  
  80036e:	c3                   	ret    

0080036f <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80036f:	55                   	push   %ebp
  800370:	89 e5                	mov    %esp,%ebp
  800372:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800375:	e8 1e 12 00 00       	call   801598 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80037a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80037d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800380:	8b 45 08             	mov    0x8(%ebp),%eax
  800383:	83 ec 08             	sub    $0x8,%esp
  800386:	ff 75 f4             	pushl  -0xc(%ebp)
  800389:	50                   	push   %eax
  80038a:	e8 48 ff ff ff       	call   8002d7 <vcprintf>
  80038f:	83 c4 10             	add    $0x10,%esp
  800392:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800395:	e8 18 12 00 00       	call   8015b2 <sys_enable_interrupt>
	return cnt;
  80039a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80039d:	c9                   	leave  
  80039e:	c3                   	ret    

0080039f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80039f:	55                   	push   %ebp
  8003a0:	89 e5                	mov    %esp,%ebp
  8003a2:	53                   	push   %ebx
  8003a3:	83 ec 14             	sub    $0x14,%esp
  8003a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8003a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8003ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8003af:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003b2:	8b 45 18             	mov    0x18(%ebp),%eax
  8003b5:	ba 00 00 00 00       	mov    $0x0,%edx
  8003ba:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003bd:	77 55                	ja     800414 <printnum+0x75>
  8003bf:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003c2:	72 05                	jb     8003c9 <printnum+0x2a>
  8003c4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003c7:	77 4b                	ja     800414 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003c9:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003cc:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003cf:	8b 45 18             	mov    0x18(%ebp),%eax
  8003d2:	ba 00 00 00 00       	mov    $0x0,%edx
  8003d7:	52                   	push   %edx
  8003d8:	50                   	push   %eax
  8003d9:	ff 75 f4             	pushl  -0xc(%ebp)
  8003dc:	ff 75 f0             	pushl  -0x10(%ebp)
  8003df:	e8 28 18 00 00       	call   801c0c <__udivdi3>
  8003e4:	83 c4 10             	add    $0x10,%esp
  8003e7:	83 ec 04             	sub    $0x4,%esp
  8003ea:	ff 75 20             	pushl  0x20(%ebp)
  8003ed:	53                   	push   %ebx
  8003ee:	ff 75 18             	pushl  0x18(%ebp)
  8003f1:	52                   	push   %edx
  8003f2:	50                   	push   %eax
  8003f3:	ff 75 0c             	pushl  0xc(%ebp)
  8003f6:	ff 75 08             	pushl  0x8(%ebp)
  8003f9:	e8 a1 ff ff ff       	call   80039f <printnum>
  8003fe:	83 c4 20             	add    $0x20,%esp
  800401:	eb 1a                	jmp    80041d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800403:	83 ec 08             	sub    $0x8,%esp
  800406:	ff 75 0c             	pushl  0xc(%ebp)
  800409:	ff 75 20             	pushl  0x20(%ebp)
  80040c:	8b 45 08             	mov    0x8(%ebp),%eax
  80040f:	ff d0                	call   *%eax
  800411:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800414:	ff 4d 1c             	decl   0x1c(%ebp)
  800417:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80041b:	7f e6                	jg     800403 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80041d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800420:	bb 00 00 00 00       	mov    $0x0,%ebx
  800425:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800428:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80042b:	53                   	push   %ebx
  80042c:	51                   	push   %ecx
  80042d:	52                   	push   %edx
  80042e:	50                   	push   %eax
  80042f:	e8 e8 18 00 00       	call   801d1c <__umoddi3>
  800434:	83 c4 10             	add    $0x10,%esp
  800437:	05 34 21 80 00       	add    $0x802134,%eax
  80043c:	8a 00                	mov    (%eax),%al
  80043e:	0f be c0             	movsbl %al,%eax
  800441:	83 ec 08             	sub    $0x8,%esp
  800444:	ff 75 0c             	pushl  0xc(%ebp)
  800447:	50                   	push   %eax
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	ff d0                	call   *%eax
  80044d:	83 c4 10             	add    $0x10,%esp
}
  800450:	90                   	nop
  800451:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800454:	c9                   	leave  
  800455:	c3                   	ret    

00800456 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800456:	55                   	push   %ebp
  800457:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800459:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80045d:	7e 1c                	jle    80047b <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	8d 50 08             	lea    0x8(%eax),%edx
  800467:	8b 45 08             	mov    0x8(%ebp),%eax
  80046a:	89 10                	mov    %edx,(%eax)
  80046c:	8b 45 08             	mov    0x8(%ebp),%eax
  80046f:	8b 00                	mov    (%eax),%eax
  800471:	83 e8 08             	sub    $0x8,%eax
  800474:	8b 50 04             	mov    0x4(%eax),%edx
  800477:	8b 00                	mov    (%eax),%eax
  800479:	eb 40                	jmp    8004bb <getuint+0x65>
	else if (lflag)
  80047b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80047f:	74 1e                	je     80049f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800481:	8b 45 08             	mov    0x8(%ebp),%eax
  800484:	8b 00                	mov    (%eax),%eax
  800486:	8d 50 04             	lea    0x4(%eax),%edx
  800489:	8b 45 08             	mov    0x8(%ebp),%eax
  80048c:	89 10                	mov    %edx,(%eax)
  80048e:	8b 45 08             	mov    0x8(%ebp),%eax
  800491:	8b 00                	mov    (%eax),%eax
  800493:	83 e8 04             	sub    $0x4,%eax
  800496:	8b 00                	mov    (%eax),%eax
  800498:	ba 00 00 00 00       	mov    $0x0,%edx
  80049d:	eb 1c                	jmp    8004bb <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80049f:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a2:	8b 00                	mov    (%eax),%eax
  8004a4:	8d 50 04             	lea    0x4(%eax),%edx
  8004a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004aa:	89 10                	mov    %edx,(%eax)
  8004ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8004af:	8b 00                	mov    (%eax),%eax
  8004b1:	83 e8 04             	sub    $0x4,%eax
  8004b4:	8b 00                	mov    (%eax),%eax
  8004b6:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004bb:	5d                   	pop    %ebp
  8004bc:	c3                   	ret    

008004bd <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004bd:	55                   	push   %ebp
  8004be:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004c0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004c4:	7e 1c                	jle    8004e2 <getint+0x25>
		return va_arg(*ap, long long);
  8004c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c9:	8b 00                	mov    (%eax),%eax
  8004cb:	8d 50 08             	lea    0x8(%eax),%edx
  8004ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d1:	89 10                	mov    %edx,(%eax)
  8004d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d6:	8b 00                	mov    (%eax),%eax
  8004d8:	83 e8 08             	sub    $0x8,%eax
  8004db:	8b 50 04             	mov    0x4(%eax),%edx
  8004de:	8b 00                	mov    (%eax),%eax
  8004e0:	eb 38                	jmp    80051a <getint+0x5d>
	else if (lflag)
  8004e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004e6:	74 1a                	je     800502 <getint+0x45>
		return va_arg(*ap, long);
  8004e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004eb:	8b 00                	mov    (%eax),%eax
  8004ed:	8d 50 04             	lea    0x4(%eax),%edx
  8004f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f3:	89 10                	mov    %edx,(%eax)
  8004f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f8:	8b 00                	mov    (%eax),%eax
  8004fa:	83 e8 04             	sub    $0x4,%eax
  8004fd:	8b 00                	mov    (%eax),%eax
  8004ff:	99                   	cltd   
  800500:	eb 18                	jmp    80051a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800502:	8b 45 08             	mov    0x8(%ebp),%eax
  800505:	8b 00                	mov    (%eax),%eax
  800507:	8d 50 04             	lea    0x4(%eax),%edx
  80050a:	8b 45 08             	mov    0x8(%ebp),%eax
  80050d:	89 10                	mov    %edx,(%eax)
  80050f:	8b 45 08             	mov    0x8(%ebp),%eax
  800512:	8b 00                	mov    (%eax),%eax
  800514:	83 e8 04             	sub    $0x4,%eax
  800517:	8b 00                	mov    (%eax),%eax
  800519:	99                   	cltd   
}
  80051a:	5d                   	pop    %ebp
  80051b:	c3                   	ret    

0080051c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80051c:	55                   	push   %ebp
  80051d:	89 e5                	mov    %esp,%ebp
  80051f:	56                   	push   %esi
  800520:	53                   	push   %ebx
  800521:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800524:	eb 17                	jmp    80053d <vprintfmt+0x21>
			if (ch == '\0')
  800526:	85 db                	test   %ebx,%ebx
  800528:	0f 84 af 03 00 00    	je     8008dd <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80052e:	83 ec 08             	sub    $0x8,%esp
  800531:	ff 75 0c             	pushl  0xc(%ebp)
  800534:	53                   	push   %ebx
  800535:	8b 45 08             	mov    0x8(%ebp),%eax
  800538:	ff d0                	call   *%eax
  80053a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80053d:	8b 45 10             	mov    0x10(%ebp),%eax
  800540:	8d 50 01             	lea    0x1(%eax),%edx
  800543:	89 55 10             	mov    %edx,0x10(%ebp)
  800546:	8a 00                	mov    (%eax),%al
  800548:	0f b6 d8             	movzbl %al,%ebx
  80054b:	83 fb 25             	cmp    $0x25,%ebx
  80054e:	75 d6                	jne    800526 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800550:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800554:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80055b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800562:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800569:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800570:	8b 45 10             	mov    0x10(%ebp),%eax
  800573:	8d 50 01             	lea    0x1(%eax),%edx
  800576:	89 55 10             	mov    %edx,0x10(%ebp)
  800579:	8a 00                	mov    (%eax),%al
  80057b:	0f b6 d8             	movzbl %al,%ebx
  80057e:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800581:	83 f8 55             	cmp    $0x55,%eax
  800584:	0f 87 2b 03 00 00    	ja     8008b5 <vprintfmt+0x399>
  80058a:	8b 04 85 58 21 80 00 	mov    0x802158(,%eax,4),%eax
  800591:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800593:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800597:	eb d7                	jmp    800570 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800599:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80059d:	eb d1                	jmp    800570 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80059f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8005a6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005a9:	89 d0                	mov    %edx,%eax
  8005ab:	c1 e0 02             	shl    $0x2,%eax
  8005ae:	01 d0                	add    %edx,%eax
  8005b0:	01 c0                	add    %eax,%eax
  8005b2:	01 d8                	add    %ebx,%eax
  8005b4:	83 e8 30             	sub    $0x30,%eax
  8005b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8005bd:	8a 00                	mov    (%eax),%al
  8005bf:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8005c2:	83 fb 2f             	cmp    $0x2f,%ebx
  8005c5:	7e 3e                	jle    800605 <vprintfmt+0xe9>
  8005c7:	83 fb 39             	cmp    $0x39,%ebx
  8005ca:	7f 39                	jg     800605 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005cc:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005cf:	eb d5                	jmp    8005a6 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d4:	83 c0 04             	add    $0x4,%eax
  8005d7:	89 45 14             	mov    %eax,0x14(%ebp)
  8005da:	8b 45 14             	mov    0x14(%ebp),%eax
  8005dd:	83 e8 04             	sub    $0x4,%eax
  8005e0:	8b 00                	mov    (%eax),%eax
  8005e2:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005e5:	eb 1f                	jmp    800606 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005e7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005eb:	79 83                	jns    800570 <vprintfmt+0x54>
				width = 0;
  8005ed:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005f4:	e9 77 ff ff ff       	jmp    800570 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005f9:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800600:	e9 6b ff ff ff       	jmp    800570 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800605:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800606:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80060a:	0f 89 60 ff ff ff    	jns    800570 <vprintfmt+0x54>
				width = precision, precision = -1;
  800610:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800613:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800616:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80061d:	e9 4e ff ff ff       	jmp    800570 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800622:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800625:	e9 46 ff ff ff       	jmp    800570 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80062a:	8b 45 14             	mov    0x14(%ebp),%eax
  80062d:	83 c0 04             	add    $0x4,%eax
  800630:	89 45 14             	mov    %eax,0x14(%ebp)
  800633:	8b 45 14             	mov    0x14(%ebp),%eax
  800636:	83 e8 04             	sub    $0x4,%eax
  800639:	8b 00                	mov    (%eax),%eax
  80063b:	83 ec 08             	sub    $0x8,%esp
  80063e:	ff 75 0c             	pushl  0xc(%ebp)
  800641:	50                   	push   %eax
  800642:	8b 45 08             	mov    0x8(%ebp),%eax
  800645:	ff d0                	call   *%eax
  800647:	83 c4 10             	add    $0x10,%esp
			break;
  80064a:	e9 89 02 00 00       	jmp    8008d8 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80064f:	8b 45 14             	mov    0x14(%ebp),%eax
  800652:	83 c0 04             	add    $0x4,%eax
  800655:	89 45 14             	mov    %eax,0x14(%ebp)
  800658:	8b 45 14             	mov    0x14(%ebp),%eax
  80065b:	83 e8 04             	sub    $0x4,%eax
  80065e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800660:	85 db                	test   %ebx,%ebx
  800662:	79 02                	jns    800666 <vprintfmt+0x14a>
				err = -err;
  800664:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800666:	83 fb 64             	cmp    $0x64,%ebx
  800669:	7f 0b                	jg     800676 <vprintfmt+0x15a>
  80066b:	8b 34 9d a0 1f 80 00 	mov    0x801fa0(,%ebx,4),%esi
  800672:	85 f6                	test   %esi,%esi
  800674:	75 19                	jne    80068f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800676:	53                   	push   %ebx
  800677:	68 45 21 80 00       	push   $0x802145
  80067c:	ff 75 0c             	pushl  0xc(%ebp)
  80067f:	ff 75 08             	pushl  0x8(%ebp)
  800682:	e8 5e 02 00 00       	call   8008e5 <printfmt>
  800687:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80068a:	e9 49 02 00 00       	jmp    8008d8 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80068f:	56                   	push   %esi
  800690:	68 4e 21 80 00       	push   $0x80214e
  800695:	ff 75 0c             	pushl  0xc(%ebp)
  800698:	ff 75 08             	pushl  0x8(%ebp)
  80069b:	e8 45 02 00 00       	call   8008e5 <printfmt>
  8006a0:	83 c4 10             	add    $0x10,%esp
			break;
  8006a3:	e9 30 02 00 00       	jmp    8008d8 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8006a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ab:	83 c0 04             	add    $0x4,%eax
  8006ae:	89 45 14             	mov    %eax,0x14(%ebp)
  8006b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8006b4:	83 e8 04             	sub    $0x4,%eax
  8006b7:	8b 30                	mov    (%eax),%esi
  8006b9:	85 f6                	test   %esi,%esi
  8006bb:	75 05                	jne    8006c2 <vprintfmt+0x1a6>
				p = "(null)";
  8006bd:	be 51 21 80 00       	mov    $0x802151,%esi
			if (width > 0 && padc != '-')
  8006c2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006c6:	7e 6d                	jle    800735 <vprintfmt+0x219>
  8006c8:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006cc:	74 67                	je     800735 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006d1:	83 ec 08             	sub    $0x8,%esp
  8006d4:	50                   	push   %eax
  8006d5:	56                   	push   %esi
  8006d6:	e8 0c 03 00 00       	call   8009e7 <strnlen>
  8006db:	83 c4 10             	add    $0x10,%esp
  8006de:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006e1:	eb 16                	jmp    8006f9 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006e3:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006e7:	83 ec 08             	sub    $0x8,%esp
  8006ea:	ff 75 0c             	pushl  0xc(%ebp)
  8006ed:	50                   	push   %eax
  8006ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f1:	ff d0                	call   *%eax
  8006f3:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006f6:	ff 4d e4             	decl   -0x1c(%ebp)
  8006f9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006fd:	7f e4                	jg     8006e3 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006ff:	eb 34                	jmp    800735 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800701:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800705:	74 1c                	je     800723 <vprintfmt+0x207>
  800707:	83 fb 1f             	cmp    $0x1f,%ebx
  80070a:	7e 05                	jle    800711 <vprintfmt+0x1f5>
  80070c:	83 fb 7e             	cmp    $0x7e,%ebx
  80070f:	7e 12                	jle    800723 <vprintfmt+0x207>
					putch('?', putdat);
  800711:	83 ec 08             	sub    $0x8,%esp
  800714:	ff 75 0c             	pushl  0xc(%ebp)
  800717:	6a 3f                	push   $0x3f
  800719:	8b 45 08             	mov    0x8(%ebp),%eax
  80071c:	ff d0                	call   *%eax
  80071e:	83 c4 10             	add    $0x10,%esp
  800721:	eb 0f                	jmp    800732 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800723:	83 ec 08             	sub    $0x8,%esp
  800726:	ff 75 0c             	pushl  0xc(%ebp)
  800729:	53                   	push   %ebx
  80072a:	8b 45 08             	mov    0x8(%ebp),%eax
  80072d:	ff d0                	call   *%eax
  80072f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800732:	ff 4d e4             	decl   -0x1c(%ebp)
  800735:	89 f0                	mov    %esi,%eax
  800737:	8d 70 01             	lea    0x1(%eax),%esi
  80073a:	8a 00                	mov    (%eax),%al
  80073c:	0f be d8             	movsbl %al,%ebx
  80073f:	85 db                	test   %ebx,%ebx
  800741:	74 24                	je     800767 <vprintfmt+0x24b>
  800743:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800747:	78 b8                	js     800701 <vprintfmt+0x1e5>
  800749:	ff 4d e0             	decl   -0x20(%ebp)
  80074c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800750:	79 af                	jns    800701 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800752:	eb 13                	jmp    800767 <vprintfmt+0x24b>
				putch(' ', putdat);
  800754:	83 ec 08             	sub    $0x8,%esp
  800757:	ff 75 0c             	pushl  0xc(%ebp)
  80075a:	6a 20                	push   $0x20
  80075c:	8b 45 08             	mov    0x8(%ebp),%eax
  80075f:	ff d0                	call   *%eax
  800761:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800764:	ff 4d e4             	decl   -0x1c(%ebp)
  800767:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80076b:	7f e7                	jg     800754 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80076d:	e9 66 01 00 00       	jmp    8008d8 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800772:	83 ec 08             	sub    $0x8,%esp
  800775:	ff 75 e8             	pushl  -0x18(%ebp)
  800778:	8d 45 14             	lea    0x14(%ebp),%eax
  80077b:	50                   	push   %eax
  80077c:	e8 3c fd ff ff       	call   8004bd <getint>
  800781:	83 c4 10             	add    $0x10,%esp
  800784:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800787:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80078a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80078d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800790:	85 d2                	test   %edx,%edx
  800792:	79 23                	jns    8007b7 <vprintfmt+0x29b>
				putch('-', putdat);
  800794:	83 ec 08             	sub    $0x8,%esp
  800797:	ff 75 0c             	pushl  0xc(%ebp)
  80079a:	6a 2d                	push   $0x2d
  80079c:	8b 45 08             	mov    0x8(%ebp),%eax
  80079f:	ff d0                	call   *%eax
  8007a1:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8007a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007aa:	f7 d8                	neg    %eax
  8007ac:	83 d2 00             	adc    $0x0,%edx
  8007af:	f7 da                	neg    %edx
  8007b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007b7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007be:	e9 bc 00 00 00       	jmp    80087f <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8007c3:	83 ec 08             	sub    $0x8,%esp
  8007c6:	ff 75 e8             	pushl  -0x18(%ebp)
  8007c9:	8d 45 14             	lea    0x14(%ebp),%eax
  8007cc:	50                   	push   %eax
  8007cd:	e8 84 fc ff ff       	call   800456 <getuint>
  8007d2:	83 c4 10             	add    $0x10,%esp
  8007d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007d8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007db:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007e2:	e9 98 00 00 00       	jmp    80087f <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007e7:	83 ec 08             	sub    $0x8,%esp
  8007ea:	ff 75 0c             	pushl  0xc(%ebp)
  8007ed:	6a 58                	push   $0x58
  8007ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f2:	ff d0                	call   *%eax
  8007f4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007f7:	83 ec 08             	sub    $0x8,%esp
  8007fa:	ff 75 0c             	pushl  0xc(%ebp)
  8007fd:	6a 58                	push   $0x58
  8007ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800802:	ff d0                	call   *%eax
  800804:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800807:	83 ec 08             	sub    $0x8,%esp
  80080a:	ff 75 0c             	pushl  0xc(%ebp)
  80080d:	6a 58                	push   $0x58
  80080f:	8b 45 08             	mov    0x8(%ebp),%eax
  800812:	ff d0                	call   *%eax
  800814:	83 c4 10             	add    $0x10,%esp
			break;
  800817:	e9 bc 00 00 00       	jmp    8008d8 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80081c:	83 ec 08             	sub    $0x8,%esp
  80081f:	ff 75 0c             	pushl  0xc(%ebp)
  800822:	6a 30                	push   $0x30
  800824:	8b 45 08             	mov    0x8(%ebp),%eax
  800827:	ff d0                	call   *%eax
  800829:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80082c:	83 ec 08             	sub    $0x8,%esp
  80082f:	ff 75 0c             	pushl  0xc(%ebp)
  800832:	6a 78                	push   $0x78
  800834:	8b 45 08             	mov    0x8(%ebp),%eax
  800837:	ff d0                	call   *%eax
  800839:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80083c:	8b 45 14             	mov    0x14(%ebp),%eax
  80083f:	83 c0 04             	add    $0x4,%eax
  800842:	89 45 14             	mov    %eax,0x14(%ebp)
  800845:	8b 45 14             	mov    0x14(%ebp),%eax
  800848:	83 e8 04             	sub    $0x4,%eax
  80084b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80084d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800850:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800857:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80085e:	eb 1f                	jmp    80087f <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800860:	83 ec 08             	sub    $0x8,%esp
  800863:	ff 75 e8             	pushl  -0x18(%ebp)
  800866:	8d 45 14             	lea    0x14(%ebp),%eax
  800869:	50                   	push   %eax
  80086a:	e8 e7 fb ff ff       	call   800456 <getuint>
  80086f:	83 c4 10             	add    $0x10,%esp
  800872:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800875:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800878:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80087f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800883:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800886:	83 ec 04             	sub    $0x4,%esp
  800889:	52                   	push   %edx
  80088a:	ff 75 e4             	pushl  -0x1c(%ebp)
  80088d:	50                   	push   %eax
  80088e:	ff 75 f4             	pushl  -0xc(%ebp)
  800891:	ff 75 f0             	pushl  -0x10(%ebp)
  800894:	ff 75 0c             	pushl  0xc(%ebp)
  800897:	ff 75 08             	pushl  0x8(%ebp)
  80089a:	e8 00 fb ff ff       	call   80039f <printnum>
  80089f:	83 c4 20             	add    $0x20,%esp
			break;
  8008a2:	eb 34                	jmp    8008d8 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8008a4:	83 ec 08             	sub    $0x8,%esp
  8008a7:	ff 75 0c             	pushl  0xc(%ebp)
  8008aa:	53                   	push   %ebx
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	ff d0                	call   *%eax
  8008b0:	83 c4 10             	add    $0x10,%esp
			break;
  8008b3:	eb 23                	jmp    8008d8 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008b5:	83 ec 08             	sub    $0x8,%esp
  8008b8:	ff 75 0c             	pushl  0xc(%ebp)
  8008bb:	6a 25                	push   $0x25
  8008bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c0:	ff d0                	call   *%eax
  8008c2:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008c5:	ff 4d 10             	decl   0x10(%ebp)
  8008c8:	eb 03                	jmp    8008cd <vprintfmt+0x3b1>
  8008ca:	ff 4d 10             	decl   0x10(%ebp)
  8008cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8008d0:	48                   	dec    %eax
  8008d1:	8a 00                	mov    (%eax),%al
  8008d3:	3c 25                	cmp    $0x25,%al
  8008d5:	75 f3                	jne    8008ca <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008d7:	90                   	nop
		}
	}
  8008d8:	e9 47 fc ff ff       	jmp    800524 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008dd:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008de:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008e1:	5b                   	pop    %ebx
  8008e2:	5e                   	pop    %esi
  8008e3:	5d                   	pop    %ebp
  8008e4:	c3                   	ret    

008008e5 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008e5:	55                   	push   %ebp
  8008e6:	89 e5                	mov    %esp,%ebp
  8008e8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008eb:	8d 45 10             	lea    0x10(%ebp),%eax
  8008ee:	83 c0 04             	add    $0x4,%eax
  8008f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8008f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8008fa:	50                   	push   %eax
  8008fb:	ff 75 0c             	pushl  0xc(%ebp)
  8008fe:	ff 75 08             	pushl  0x8(%ebp)
  800901:	e8 16 fc ff ff       	call   80051c <vprintfmt>
  800906:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800909:	90                   	nop
  80090a:	c9                   	leave  
  80090b:	c3                   	ret    

0080090c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80090c:	55                   	push   %ebp
  80090d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80090f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800912:	8b 40 08             	mov    0x8(%eax),%eax
  800915:	8d 50 01             	lea    0x1(%eax),%edx
  800918:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80091e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800921:	8b 10                	mov    (%eax),%edx
  800923:	8b 45 0c             	mov    0xc(%ebp),%eax
  800926:	8b 40 04             	mov    0x4(%eax),%eax
  800929:	39 c2                	cmp    %eax,%edx
  80092b:	73 12                	jae    80093f <sprintputch+0x33>
		*b->buf++ = ch;
  80092d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800930:	8b 00                	mov    (%eax),%eax
  800932:	8d 48 01             	lea    0x1(%eax),%ecx
  800935:	8b 55 0c             	mov    0xc(%ebp),%edx
  800938:	89 0a                	mov    %ecx,(%edx)
  80093a:	8b 55 08             	mov    0x8(%ebp),%edx
  80093d:	88 10                	mov    %dl,(%eax)
}
  80093f:	90                   	nop
  800940:	5d                   	pop    %ebp
  800941:	c3                   	ret    

00800942 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800942:	55                   	push   %ebp
  800943:	89 e5                	mov    %esp,%ebp
  800945:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800948:	8b 45 08             	mov    0x8(%ebp),%eax
  80094b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80094e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800951:	8d 50 ff             	lea    -0x1(%eax),%edx
  800954:	8b 45 08             	mov    0x8(%ebp),%eax
  800957:	01 d0                	add    %edx,%eax
  800959:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80095c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800963:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800967:	74 06                	je     80096f <vsnprintf+0x2d>
  800969:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80096d:	7f 07                	jg     800976 <vsnprintf+0x34>
		return -E_INVAL;
  80096f:	b8 03 00 00 00       	mov    $0x3,%eax
  800974:	eb 20                	jmp    800996 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800976:	ff 75 14             	pushl  0x14(%ebp)
  800979:	ff 75 10             	pushl  0x10(%ebp)
  80097c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80097f:	50                   	push   %eax
  800980:	68 0c 09 80 00       	push   $0x80090c
  800985:	e8 92 fb ff ff       	call   80051c <vprintfmt>
  80098a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80098d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800990:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800993:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800996:	c9                   	leave  
  800997:	c3                   	ret    

00800998 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800998:	55                   	push   %ebp
  800999:	89 e5                	mov    %esp,%ebp
  80099b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80099e:	8d 45 10             	lea    0x10(%ebp),%eax
  8009a1:	83 c0 04             	add    $0x4,%eax
  8009a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8009a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8009aa:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ad:	50                   	push   %eax
  8009ae:	ff 75 0c             	pushl  0xc(%ebp)
  8009b1:	ff 75 08             	pushl  0x8(%ebp)
  8009b4:	e8 89 ff ff ff       	call   800942 <vsnprintf>
  8009b9:	83 c4 10             	add    $0x10,%esp
  8009bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009c2:	c9                   	leave  
  8009c3:	c3                   	ret    

008009c4 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8009c4:	55                   	push   %ebp
  8009c5:	89 e5                	mov    %esp,%ebp
  8009c7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009d1:	eb 06                	jmp    8009d9 <strlen+0x15>
		n++;
  8009d3:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009d6:	ff 45 08             	incl   0x8(%ebp)
  8009d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dc:	8a 00                	mov    (%eax),%al
  8009de:	84 c0                	test   %al,%al
  8009e0:	75 f1                	jne    8009d3 <strlen+0xf>
		n++;
	return n;
  8009e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009e5:	c9                   	leave  
  8009e6:	c3                   	ret    

008009e7 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009e7:	55                   	push   %ebp
  8009e8:	89 e5                	mov    %esp,%ebp
  8009ea:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009f4:	eb 09                	jmp    8009ff <strnlen+0x18>
		n++;
  8009f6:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009f9:	ff 45 08             	incl   0x8(%ebp)
  8009fc:	ff 4d 0c             	decl   0xc(%ebp)
  8009ff:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a03:	74 09                	je     800a0e <strnlen+0x27>
  800a05:	8b 45 08             	mov    0x8(%ebp),%eax
  800a08:	8a 00                	mov    (%eax),%al
  800a0a:	84 c0                	test   %al,%al
  800a0c:	75 e8                	jne    8009f6 <strnlen+0xf>
		n++;
	return n;
  800a0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a11:	c9                   	leave  
  800a12:	c3                   	ret    

00800a13 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a13:	55                   	push   %ebp
  800a14:	89 e5                	mov    %esp,%ebp
  800a16:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a19:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a1f:	90                   	nop
  800a20:	8b 45 08             	mov    0x8(%ebp),%eax
  800a23:	8d 50 01             	lea    0x1(%eax),%edx
  800a26:	89 55 08             	mov    %edx,0x8(%ebp)
  800a29:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a2c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a2f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a32:	8a 12                	mov    (%edx),%dl
  800a34:	88 10                	mov    %dl,(%eax)
  800a36:	8a 00                	mov    (%eax),%al
  800a38:	84 c0                	test   %al,%al
  800a3a:	75 e4                	jne    800a20 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a3f:	c9                   	leave  
  800a40:	c3                   	ret    

00800a41 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a41:	55                   	push   %ebp
  800a42:	89 e5                	mov    %esp,%ebp
  800a44:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a47:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a4d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a54:	eb 1f                	jmp    800a75 <strncpy+0x34>
		*dst++ = *src;
  800a56:	8b 45 08             	mov    0x8(%ebp),%eax
  800a59:	8d 50 01             	lea    0x1(%eax),%edx
  800a5c:	89 55 08             	mov    %edx,0x8(%ebp)
  800a5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a62:	8a 12                	mov    (%edx),%dl
  800a64:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a69:	8a 00                	mov    (%eax),%al
  800a6b:	84 c0                	test   %al,%al
  800a6d:	74 03                	je     800a72 <strncpy+0x31>
			src++;
  800a6f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a72:	ff 45 fc             	incl   -0x4(%ebp)
  800a75:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a78:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a7b:	72 d9                	jb     800a56 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a7d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a80:	c9                   	leave  
  800a81:	c3                   	ret    

00800a82 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a82:	55                   	push   %ebp
  800a83:	89 e5                	mov    %esp,%ebp
  800a85:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a88:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a8e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a92:	74 30                	je     800ac4 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a94:	eb 16                	jmp    800aac <strlcpy+0x2a>
			*dst++ = *src++;
  800a96:	8b 45 08             	mov    0x8(%ebp),%eax
  800a99:	8d 50 01             	lea    0x1(%eax),%edx
  800a9c:	89 55 08             	mov    %edx,0x8(%ebp)
  800a9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aa2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800aa5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800aa8:	8a 12                	mov    (%edx),%dl
  800aaa:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800aac:	ff 4d 10             	decl   0x10(%ebp)
  800aaf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ab3:	74 09                	je     800abe <strlcpy+0x3c>
  800ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab8:	8a 00                	mov    (%eax),%al
  800aba:	84 c0                	test   %al,%al
  800abc:	75 d8                	jne    800a96 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800abe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac1:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ac4:	8b 55 08             	mov    0x8(%ebp),%edx
  800ac7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800aca:	29 c2                	sub    %eax,%edx
  800acc:	89 d0                	mov    %edx,%eax
}
  800ace:	c9                   	leave  
  800acf:	c3                   	ret    

00800ad0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ad0:	55                   	push   %ebp
  800ad1:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ad3:	eb 06                	jmp    800adb <strcmp+0xb>
		p++, q++;
  800ad5:	ff 45 08             	incl   0x8(%ebp)
  800ad8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800adb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ade:	8a 00                	mov    (%eax),%al
  800ae0:	84 c0                	test   %al,%al
  800ae2:	74 0e                	je     800af2 <strcmp+0x22>
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae7:	8a 10                	mov    (%eax),%dl
  800ae9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aec:	8a 00                	mov    (%eax),%al
  800aee:	38 c2                	cmp    %al,%dl
  800af0:	74 e3                	je     800ad5 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800af2:	8b 45 08             	mov    0x8(%ebp),%eax
  800af5:	8a 00                	mov    (%eax),%al
  800af7:	0f b6 d0             	movzbl %al,%edx
  800afa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afd:	8a 00                	mov    (%eax),%al
  800aff:	0f b6 c0             	movzbl %al,%eax
  800b02:	29 c2                	sub    %eax,%edx
  800b04:	89 d0                	mov    %edx,%eax
}
  800b06:	5d                   	pop    %ebp
  800b07:	c3                   	ret    

00800b08 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800b08:	55                   	push   %ebp
  800b09:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800b0b:	eb 09                	jmp    800b16 <strncmp+0xe>
		n--, p++, q++;
  800b0d:	ff 4d 10             	decl   0x10(%ebp)
  800b10:	ff 45 08             	incl   0x8(%ebp)
  800b13:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b16:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b1a:	74 17                	je     800b33 <strncmp+0x2b>
  800b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1f:	8a 00                	mov    (%eax),%al
  800b21:	84 c0                	test   %al,%al
  800b23:	74 0e                	je     800b33 <strncmp+0x2b>
  800b25:	8b 45 08             	mov    0x8(%ebp),%eax
  800b28:	8a 10                	mov    (%eax),%dl
  800b2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2d:	8a 00                	mov    (%eax),%al
  800b2f:	38 c2                	cmp    %al,%dl
  800b31:	74 da                	je     800b0d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b33:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b37:	75 07                	jne    800b40 <strncmp+0x38>
		return 0;
  800b39:	b8 00 00 00 00       	mov    $0x0,%eax
  800b3e:	eb 14                	jmp    800b54 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b40:	8b 45 08             	mov    0x8(%ebp),%eax
  800b43:	8a 00                	mov    (%eax),%al
  800b45:	0f b6 d0             	movzbl %al,%edx
  800b48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4b:	8a 00                	mov    (%eax),%al
  800b4d:	0f b6 c0             	movzbl %al,%eax
  800b50:	29 c2                	sub    %eax,%edx
  800b52:	89 d0                	mov    %edx,%eax
}
  800b54:	5d                   	pop    %ebp
  800b55:	c3                   	ret    

00800b56 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b56:	55                   	push   %ebp
  800b57:	89 e5                	mov    %esp,%ebp
  800b59:	83 ec 04             	sub    $0x4,%esp
  800b5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b62:	eb 12                	jmp    800b76 <strchr+0x20>
		if (*s == c)
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	8a 00                	mov    (%eax),%al
  800b69:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b6c:	75 05                	jne    800b73 <strchr+0x1d>
			return (char *) s;
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	eb 11                	jmp    800b84 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b73:	ff 45 08             	incl   0x8(%ebp)
  800b76:	8b 45 08             	mov    0x8(%ebp),%eax
  800b79:	8a 00                	mov    (%eax),%al
  800b7b:	84 c0                	test   %al,%al
  800b7d:	75 e5                	jne    800b64 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b7f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b84:	c9                   	leave  
  800b85:	c3                   	ret    

00800b86 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b86:	55                   	push   %ebp
  800b87:	89 e5                	mov    %esp,%ebp
  800b89:	83 ec 04             	sub    $0x4,%esp
  800b8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b92:	eb 0d                	jmp    800ba1 <strfind+0x1b>
		if (*s == c)
  800b94:	8b 45 08             	mov    0x8(%ebp),%eax
  800b97:	8a 00                	mov    (%eax),%al
  800b99:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b9c:	74 0e                	je     800bac <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b9e:	ff 45 08             	incl   0x8(%ebp)
  800ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba4:	8a 00                	mov    (%eax),%al
  800ba6:	84 c0                	test   %al,%al
  800ba8:	75 ea                	jne    800b94 <strfind+0xe>
  800baa:	eb 01                	jmp    800bad <strfind+0x27>
		if (*s == c)
			break;
  800bac:	90                   	nop
	return (char *) s;
  800bad:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bb0:	c9                   	leave  
  800bb1:	c3                   	ret    

00800bb2 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800bb2:	55                   	push   %ebp
  800bb3:	89 e5                	mov    %esp,%ebp
  800bb5:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800bbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800bc4:	eb 0e                	jmp    800bd4 <memset+0x22>
		*p++ = c;
  800bc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc9:	8d 50 01             	lea    0x1(%eax),%edx
  800bcc:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800bcf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bd2:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800bd4:	ff 4d f8             	decl   -0x8(%ebp)
  800bd7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bdb:	79 e9                	jns    800bc6 <memset+0x14>
		*p++ = c;

	return v;
  800bdd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800be0:	c9                   	leave  
  800be1:	c3                   	ret    

00800be2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800be2:	55                   	push   %ebp
  800be3:	89 e5                	mov    %esp,%ebp
  800be5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800be8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800beb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bee:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800bf4:	eb 16                	jmp    800c0c <memcpy+0x2a>
		*d++ = *s++;
  800bf6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf9:	8d 50 01             	lea    0x1(%eax),%edx
  800bfc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bff:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c02:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c05:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c08:	8a 12                	mov    (%edx),%dl
  800c0a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800c0c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c0f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c12:	89 55 10             	mov    %edx,0x10(%ebp)
  800c15:	85 c0                	test   %eax,%eax
  800c17:	75 dd                	jne    800bf6 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c1c:	c9                   	leave  
  800c1d:	c3                   	ret    

00800c1e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c1e:	55                   	push   %ebp
  800c1f:	89 e5                	mov    %esp,%ebp
  800c21:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800c24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c27:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c30:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c33:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c36:	73 50                	jae    800c88 <memmove+0x6a>
  800c38:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c3b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3e:	01 d0                	add    %edx,%eax
  800c40:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c43:	76 43                	jbe    800c88 <memmove+0x6a>
		s += n;
  800c45:	8b 45 10             	mov    0x10(%ebp),%eax
  800c48:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c4b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c51:	eb 10                	jmp    800c63 <memmove+0x45>
			*--d = *--s;
  800c53:	ff 4d f8             	decl   -0x8(%ebp)
  800c56:	ff 4d fc             	decl   -0x4(%ebp)
  800c59:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c5c:	8a 10                	mov    (%eax),%dl
  800c5e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c61:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c63:	8b 45 10             	mov    0x10(%ebp),%eax
  800c66:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c69:	89 55 10             	mov    %edx,0x10(%ebp)
  800c6c:	85 c0                	test   %eax,%eax
  800c6e:	75 e3                	jne    800c53 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c70:	eb 23                	jmp    800c95 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c72:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c75:	8d 50 01             	lea    0x1(%eax),%edx
  800c78:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c7b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c7e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c81:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c84:	8a 12                	mov    (%edx),%dl
  800c86:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c88:	8b 45 10             	mov    0x10(%ebp),%eax
  800c8b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c8e:	89 55 10             	mov    %edx,0x10(%ebp)
  800c91:	85 c0                	test   %eax,%eax
  800c93:	75 dd                	jne    800c72 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c95:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c98:	c9                   	leave  
  800c99:	c3                   	ret    

00800c9a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c9a:	55                   	push   %ebp
  800c9b:	89 e5                	mov    %esp,%ebp
  800c9d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ca6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca9:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800cac:	eb 2a                	jmp    800cd8 <memcmp+0x3e>
		if (*s1 != *s2)
  800cae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb1:	8a 10                	mov    (%eax),%dl
  800cb3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cb6:	8a 00                	mov    (%eax),%al
  800cb8:	38 c2                	cmp    %al,%dl
  800cba:	74 16                	je     800cd2 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800cbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cbf:	8a 00                	mov    (%eax),%al
  800cc1:	0f b6 d0             	movzbl %al,%edx
  800cc4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cc7:	8a 00                	mov    (%eax),%al
  800cc9:	0f b6 c0             	movzbl %al,%eax
  800ccc:	29 c2                	sub    %eax,%edx
  800cce:	89 d0                	mov    %edx,%eax
  800cd0:	eb 18                	jmp    800cea <memcmp+0x50>
		s1++, s2++;
  800cd2:	ff 45 fc             	incl   -0x4(%ebp)
  800cd5:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800cd8:	8b 45 10             	mov    0x10(%ebp),%eax
  800cdb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cde:	89 55 10             	mov    %edx,0x10(%ebp)
  800ce1:	85 c0                	test   %eax,%eax
  800ce3:	75 c9                	jne    800cae <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ce5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cea:	c9                   	leave  
  800ceb:	c3                   	ret    

00800cec <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800cec:	55                   	push   %ebp
  800ced:	89 e5                	mov    %esp,%ebp
  800cef:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800cf2:	8b 55 08             	mov    0x8(%ebp),%edx
  800cf5:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf8:	01 d0                	add    %edx,%eax
  800cfa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800cfd:	eb 15                	jmp    800d14 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	8a 00                	mov    (%eax),%al
  800d04:	0f b6 d0             	movzbl %al,%edx
  800d07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0a:	0f b6 c0             	movzbl %al,%eax
  800d0d:	39 c2                	cmp    %eax,%edx
  800d0f:	74 0d                	je     800d1e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d11:	ff 45 08             	incl   0x8(%ebp)
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d1a:	72 e3                	jb     800cff <memfind+0x13>
  800d1c:	eb 01                	jmp    800d1f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d1e:	90                   	nop
	return (void *) s;
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d22:	c9                   	leave  
  800d23:	c3                   	ret    

00800d24 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d24:	55                   	push   %ebp
  800d25:	89 e5                	mov    %esp,%ebp
  800d27:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d2a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d31:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d38:	eb 03                	jmp    800d3d <strtol+0x19>
		s++;
  800d3a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d40:	8a 00                	mov    (%eax),%al
  800d42:	3c 20                	cmp    $0x20,%al
  800d44:	74 f4                	je     800d3a <strtol+0x16>
  800d46:	8b 45 08             	mov    0x8(%ebp),%eax
  800d49:	8a 00                	mov    (%eax),%al
  800d4b:	3c 09                	cmp    $0x9,%al
  800d4d:	74 eb                	je     800d3a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	3c 2b                	cmp    $0x2b,%al
  800d56:	75 05                	jne    800d5d <strtol+0x39>
		s++;
  800d58:	ff 45 08             	incl   0x8(%ebp)
  800d5b:	eb 13                	jmp    800d70 <strtol+0x4c>
	else if (*s == '-')
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d60:	8a 00                	mov    (%eax),%al
  800d62:	3c 2d                	cmp    $0x2d,%al
  800d64:	75 0a                	jne    800d70 <strtol+0x4c>
		s++, neg = 1;
  800d66:	ff 45 08             	incl   0x8(%ebp)
  800d69:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d70:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d74:	74 06                	je     800d7c <strtol+0x58>
  800d76:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d7a:	75 20                	jne    800d9c <strtol+0x78>
  800d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7f:	8a 00                	mov    (%eax),%al
  800d81:	3c 30                	cmp    $0x30,%al
  800d83:	75 17                	jne    800d9c <strtol+0x78>
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	40                   	inc    %eax
  800d89:	8a 00                	mov    (%eax),%al
  800d8b:	3c 78                	cmp    $0x78,%al
  800d8d:	75 0d                	jne    800d9c <strtol+0x78>
		s += 2, base = 16;
  800d8f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d93:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d9a:	eb 28                	jmp    800dc4 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d9c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800da0:	75 15                	jne    800db7 <strtol+0x93>
  800da2:	8b 45 08             	mov    0x8(%ebp),%eax
  800da5:	8a 00                	mov    (%eax),%al
  800da7:	3c 30                	cmp    $0x30,%al
  800da9:	75 0c                	jne    800db7 <strtol+0x93>
		s++, base = 8;
  800dab:	ff 45 08             	incl   0x8(%ebp)
  800dae:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800db5:	eb 0d                	jmp    800dc4 <strtol+0xa0>
	else if (base == 0)
  800db7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dbb:	75 07                	jne    800dc4 <strtol+0xa0>
		base = 10;
  800dbd:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800dc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc7:	8a 00                	mov    (%eax),%al
  800dc9:	3c 2f                	cmp    $0x2f,%al
  800dcb:	7e 19                	jle    800de6 <strtol+0xc2>
  800dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd0:	8a 00                	mov    (%eax),%al
  800dd2:	3c 39                	cmp    $0x39,%al
  800dd4:	7f 10                	jg     800de6 <strtol+0xc2>
			dig = *s - '0';
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	8a 00                	mov    (%eax),%al
  800ddb:	0f be c0             	movsbl %al,%eax
  800dde:	83 e8 30             	sub    $0x30,%eax
  800de1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800de4:	eb 42                	jmp    800e28 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	8a 00                	mov    (%eax),%al
  800deb:	3c 60                	cmp    $0x60,%al
  800ded:	7e 19                	jle    800e08 <strtol+0xe4>
  800def:	8b 45 08             	mov    0x8(%ebp),%eax
  800df2:	8a 00                	mov    (%eax),%al
  800df4:	3c 7a                	cmp    $0x7a,%al
  800df6:	7f 10                	jg     800e08 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	8a 00                	mov    (%eax),%al
  800dfd:	0f be c0             	movsbl %al,%eax
  800e00:	83 e8 57             	sub    $0x57,%eax
  800e03:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e06:	eb 20                	jmp    800e28 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	8a 00                	mov    (%eax),%al
  800e0d:	3c 40                	cmp    $0x40,%al
  800e0f:	7e 39                	jle    800e4a <strtol+0x126>
  800e11:	8b 45 08             	mov    0x8(%ebp),%eax
  800e14:	8a 00                	mov    (%eax),%al
  800e16:	3c 5a                	cmp    $0x5a,%al
  800e18:	7f 30                	jg     800e4a <strtol+0x126>
			dig = *s - 'A' + 10;
  800e1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1d:	8a 00                	mov    (%eax),%al
  800e1f:	0f be c0             	movsbl %al,%eax
  800e22:	83 e8 37             	sub    $0x37,%eax
  800e25:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e28:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e2b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e2e:	7d 19                	jge    800e49 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e30:	ff 45 08             	incl   0x8(%ebp)
  800e33:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e36:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e3a:	89 c2                	mov    %eax,%edx
  800e3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e3f:	01 d0                	add    %edx,%eax
  800e41:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e44:	e9 7b ff ff ff       	jmp    800dc4 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e49:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e4a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e4e:	74 08                	je     800e58 <strtol+0x134>
		*endptr = (char *) s;
  800e50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e53:	8b 55 08             	mov    0x8(%ebp),%edx
  800e56:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e58:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e5c:	74 07                	je     800e65 <strtol+0x141>
  800e5e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e61:	f7 d8                	neg    %eax
  800e63:	eb 03                	jmp    800e68 <strtol+0x144>
  800e65:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e68:	c9                   	leave  
  800e69:	c3                   	ret    

00800e6a <ltostr>:

void
ltostr(long value, char *str)
{
  800e6a:	55                   	push   %ebp
  800e6b:	89 e5                	mov    %esp,%ebp
  800e6d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e70:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e77:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e7e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e82:	79 13                	jns    800e97 <ltostr+0x2d>
	{
		neg = 1;
  800e84:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8e:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e91:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e94:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e97:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e9f:	99                   	cltd   
  800ea0:	f7 f9                	idiv   %ecx
  800ea2:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800ea5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea8:	8d 50 01             	lea    0x1(%eax),%edx
  800eab:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800eae:	89 c2                	mov    %eax,%edx
  800eb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb3:	01 d0                	add    %edx,%eax
  800eb5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800eb8:	83 c2 30             	add    $0x30,%edx
  800ebb:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800ebd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ec0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ec5:	f7 e9                	imul   %ecx
  800ec7:	c1 fa 02             	sar    $0x2,%edx
  800eca:	89 c8                	mov    %ecx,%eax
  800ecc:	c1 f8 1f             	sar    $0x1f,%eax
  800ecf:	29 c2                	sub    %eax,%edx
  800ed1:	89 d0                	mov    %edx,%eax
  800ed3:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ed6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ed9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ede:	f7 e9                	imul   %ecx
  800ee0:	c1 fa 02             	sar    $0x2,%edx
  800ee3:	89 c8                	mov    %ecx,%eax
  800ee5:	c1 f8 1f             	sar    $0x1f,%eax
  800ee8:	29 c2                	sub    %eax,%edx
  800eea:	89 d0                	mov    %edx,%eax
  800eec:	c1 e0 02             	shl    $0x2,%eax
  800eef:	01 d0                	add    %edx,%eax
  800ef1:	01 c0                	add    %eax,%eax
  800ef3:	29 c1                	sub    %eax,%ecx
  800ef5:	89 ca                	mov    %ecx,%edx
  800ef7:	85 d2                	test   %edx,%edx
  800ef9:	75 9c                	jne    800e97 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800efb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800f02:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f05:	48                   	dec    %eax
  800f06:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800f09:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f0d:	74 3d                	je     800f4c <ltostr+0xe2>
		start = 1 ;
  800f0f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f16:	eb 34                	jmp    800f4c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f18:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1e:	01 d0                	add    %edx,%eax
  800f20:	8a 00                	mov    (%eax),%al
  800f22:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f25:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2b:	01 c2                	add    %eax,%edx
  800f2d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f33:	01 c8                	add    %ecx,%eax
  800f35:	8a 00                	mov    (%eax),%al
  800f37:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f39:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3f:	01 c2                	add    %eax,%edx
  800f41:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f44:	88 02                	mov    %al,(%edx)
		start++ ;
  800f46:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f49:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f4f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f52:	7c c4                	jl     800f18 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f54:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5a:	01 d0                	add    %edx,%eax
  800f5c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f5f:	90                   	nop
  800f60:	c9                   	leave  
  800f61:	c3                   	ret    

00800f62 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f62:	55                   	push   %ebp
  800f63:	89 e5                	mov    %esp,%ebp
  800f65:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f68:	ff 75 08             	pushl  0x8(%ebp)
  800f6b:	e8 54 fa ff ff       	call   8009c4 <strlen>
  800f70:	83 c4 04             	add    $0x4,%esp
  800f73:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f76:	ff 75 0c             	pushl  0xc(%ebp)
  800f79:	e8 46 fa ff ff       	call   8009c4 <strlen>
  800f7e:	83 c4 04             	add    $0x4,%esp
  800f81:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f84:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f8b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f92:	eb 17                	jmp    800fab <strcconcat+0x49>
		final[s] = str1[s] ;
  800f94:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f97:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9a:	01 c2                	add    %eax,%edx
  800f9c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	01 c8                	add    %ecx,%eax
  800fa4:	8a 00                	mov    (%eax),%al
  800fa6:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800fa8:	ff 45 fc             	incl   -0x4(%ebp)
  800fab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fae:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800fb1:	7c e1                	jl     800f94 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800fb3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800fba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800fc1:	eb 1f                	jmp    800fe2 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800fc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fc6:	8d 50 01             	lea    0x1(%eax),%edx
  800fc9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fcc:	89 c2                	mov    %eax,%edx
  800fce:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd1:	01 c2                	add    %eax,%edx
  800fd3:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd9:	01 c8                	add    %ecx,%eax
  800fdb:	8a 00                	mov    (%eax),%al
  800fdd:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fdf:	ff 45 f8             	incl   -0x8(%ebp)
  800fe2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fe8:	7c d9                	jl     800fc3 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fea:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fed:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff0:	01 d0                	add    %edx,%eax
  800ff2:	c6 00 00             	movb   $0x0,(%eax)
}
  800ff5:	90                   	nop
  800ff6:	c9                   	leave  
  800ff7:	c3                   	ret    

00800ff8 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800ff8:	55                   	push   %ebp
  800ff9:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800ffb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ffe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801004:	8b 45 14             	mov    0x14(%ebp),%eax
  801007:	8b 00                	mov    (%eax),%eax
  801009:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801010:	8b 45 10             	mov    0x10(%ebp),%eax
  801013:	01 d0                	add    %edx,%eax
  801015:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80101b:	eb 0c                	jmp    801029 <strsplit+0x31>
			*string++ = 0;
  80101d:	8b 45 08             	mov    0x8(%ebp),%eax
  801020:	8d 50 01             	lea    0x1(%eax),%edx
  801023:	89 55 08             	mov    %edx,0x8(%ebp)
  801026:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801029:	8b 45 08             	mov    0x8(%ebp),%eax
  80102c:	8a 00                	mov    (%eax),%al
  80102e:	84 c0                	test   %al,%al
  801030:	74 18                	je     80104a <strsplit+0x52>
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	8a 00                	mov    (%eax),%al
  801037:	0f be c0             	movsbl %al,%eax
  80103a:	50                   	push   %eax
  80103b:	ff 75 0c             	pushl  0xc(%ebp)
  80103e:	e8 13 fb ff ff       	call   800b56 <strchr>
  801043:	83 c4 08             	add    $0x8,%esp
  801046:	85 c0                	test   %eax,%eax
  801048:	75 d3                	jne    80101d <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80104a:	8b 45 08             	mov    0x8(%ebp),%eax
  80104d:	8a 00                	mov    (%eax),%al
  80104f:	84 c0                	test   %al,%al
  801051:	74 5a                	je     8010ad <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801053:	8b 45 14             	mov    0x14(%ebp),%eax
  801056:	8b 00                	mov    (%eax),%eax
  801058:	83 f8 0f             	cmp    $0xf,%eax
  80105b:	75 07                	jne    801064 <strsplit+0x6c>
		{
			return 0;
  80105d:	b8 00 00 00 00       	mov    $0x0,%eax
  801062:	eb 66                	jmp    8010ca <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801064:	8b 45 14             	mov    0x14(%ebp),%eax
  801067:	8b 00                	mov    (%eax),%eax
  801069:	8d 48 01             	lea    0x1(%eax),%ecx
  80106c:	8b 55 14             	mov    0x14(%ebp),%edx
  80106f:	89 0a                	mov    %ecx,(%edx)
  801071:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801078:	8b 45 10             	mov    0x10(%ebp),%eax
  80107b:	01 c2                	add    %eax,%edx
  80107d:	8b 45 08             	mov    0x8(%ebp),%eax
  801080:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801082:	eb 03                	jmp    801087 <strsplit+0x8f>
			string++;
  801084:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801087:	8b 45 08             	mov    0x8(%ebp),%eax
  80108a:	8a 00                	mov    (%eax),%al
  80108c:	84 c0                	test   %al,%al
  80108e:	74 8b                	je     80101b <strsplit+0x23>
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	8a 00                	mov    (%eax),%al
  801095:	0f be c0             	movsbl %al,%eax
  801098:	50                   	push   %eax
  801099:	ff 75 0c             	pushl  0xc(%ebp)
  80109c:	e8 b5 fa ff ff       	call   800b56 <strchr>
  8010a1:	83 c4 08             	add    $0x8,%esp
  8010a4:	85 c0                	test   %eax,%eax
  8010a6:	74 dc                	je     801084 <strsplit+0x8c>
			string++;
	}
  8010a8:	e9 6e ff ff ff       	jmp    80101b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8010ad:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8010ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8010b1:	8b 00                	mov    (%eax),%eax
  8010b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8010bd:	01 d0                	add    %edx,%eax
  8010bf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8010c5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010ca:	c9                   	leave  
  8010cb:	c3                   	ret    

008010cc <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8010cc:	55                   	push   %ebp
  8010cd:	89 e5                	mov    %esp,%ebp
  8010cf:	83 ec 18             	sub    $0x18,%esp
  8010d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d5:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8010d8:	83 ec 04             	sub    $0x4,%esp
  8010db:	68 b0 22 80 00       	push   $0x8022b0
  8010e0:	6a 17                	push   $0x17
  8010e2:	68 cf 22 80 00       	push   $0x8022cf
  8010e7:	e8 3e 09 00 00       	call   801a2a <_panic>

008010ec <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8010ec:	55                   	push   %ebp
  8010ed:	89 e5                	mov    %esp,%ebp
  8010ef:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8010f2:	83 ec 04             	sub    $0x4,%esp
  8010f5:	68 db 22 80 00       	push   $0x8022db
  8010fa:	6a 2f                	push   $0x2f
  8010fc:	68 cf 22 80 00       	push   $0x8022cf
  801101:	e8 24 09 00 00       	call   801a2a <_panic>

00801106 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801106:	55                   	push   %ebp
  801107:	89 e5                	mov    %esp,%ebp
  801109:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80110c:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801113:	8b 55 08             	mov    0x8(%ebp),%edx
  801116:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801119:	01 d0                	add    %edx,%eax
  80111b:	48                   	dec    %eax
  80111c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  80111f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801122:	ba 00 00 00 00       	mov    $0x0,%edx
  801127:	f7 75 ec             	divl   -0x14(%ebp)
  80112a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80112d:	29 d0                	sub    %edx,%eax
  80112f:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	c1 e8 0c             	shr    $0xc,%eax
  801138:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80113b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801142:	e9 c8 00 00 00       	jmp    80120f <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801147:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80114e:	eb 27                	jmp    801177 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801150:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801153:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801156:	01 c2                	add    %eax,%edx
  801158:	89 d0                	mov    %edx,%eax
  80115a:	01 c0                	add    %eax,%eax
  80115c:	01 d0                	add    %edx,%eax
  80115e:	c1 e0 02             	shl    $0x2,%eax
  801161:	05 48 30 80 00       	add    $0x803048,%eax
  801166:	8b 00                	mov    (%eax),%eax
  801168:	85 c0                	test   %eax,%eax
  80116a:	74 08                	je     801174 <malloc+0x6e>
            	i += j;
  80116c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80116f:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801172:	eb 0b                	jmp    80117f <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801174:	ff 45 f0             	incl   -0x10(%ebp)
  801177:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80117a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80117d:	72 d1                	jb     801150 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  80117f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801182:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801185:	0f 85 81 00 00 00    	jne    80120c <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  80118b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80118e:	05 00 00 08 00       	add    $0x80000,%eax
  801193:	c1 e0 0c             	shl    $0xc,%eax
  801196:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801199:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8011a0:	eb 1f                	jmp    8011c1 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8011a2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011a8:	01 c2                	add    %eax,%edx
  8011aa:	89 d0                	mov    %edx,%eax
  8011ac:	01 c0                	add    %eax,%eax
  8011ae:	01 d0                	add    %edx,%eax
  8011b0:	c1 e0 02             	shl    $0x2,%eax
  8011b3:	05 48 30 80 00       	add    $0x803048,%eax
  8011b8:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8011be:	ff 45 f0             	incl   -0x10(%ebp)
  8011c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011c4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8011c7:	72 d9                	jb     8011a2 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  8011c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011cc:	89 d0                	mov    %edx,%eax
  8011ce:	01 c0                	add    %eax,%eax
  8011d0:	01 d0                	add    %edx,%eax
  8011d2:	c1 e0 02             	shl    $0x2,%eax
  8011d5:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  8011db:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8011de:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8011e0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8011e3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8011e6:	89 c8                	mov    %ecx,%eax
  8011e8:	01 c0                	add    %eax,%eax
  8011ea:	01 c8                	add    %ecx,%eax
  8011ec:	c1 e0 02             	shl    $0x2,%eax
  8011ef:	05 44 30 80 00       	add    $0x803044,%eax
  8011f4:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8011f6:	83 ec 08             	sub    $0x8,%esp
  8011f9:	ff 75 08             	pushl  0x8(%ebp)
  8011fc:	ff 75 e0             	pushl  -0x20(%ebp)
  8011ff:	e8 2b 03 00 00       	call   80152f <sys_allocateMem>
  801204:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801207:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80120a:	eb 19                	jmp    801225 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80120c:	ff 45 f4             	incl   -0xc(%ebp)
  80120f:	a1 04 30 80 00       	mov    0x803004,%eax
  801214:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801217:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80121a:	0f 83 27 ff ff ff    	jae    801147 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801220:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801225:	c9                   	leave  
  801226:	c3                   	ret    

00801227 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801227:	55                   	push   %ebp
  801228:	89 e5                	mov    %esp,%ebp
  80122a:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80122d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801231:	0f 84 e5 00 00 00    	je     80131c <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  80123d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801240:	05 00 00 00 80       	add    $0x80000000,%eax
  801245:	c1 e8 0c             	shr    $0xc,%eax
  801248:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  80124b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80124e:	89 d0                	mov    %edx,%eax
  801250:	01 c0                	add    %eax,%eax
  801252:	01 d0                	add    %edx,%eax
  801254:	c1 e0 02             	shl    $0x2,%eax
  801257:	05 40 30 80 00       	add    $0x803040,%eax
  80125c:	8b 00                	mov    (%eax),%eax
  80125e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801261:	0f 85 b8 00 00 00    	jne    80131f <free+0xf8>
  801267:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80126a:	89 d0                	mov    %edx,%eax
  80126c:	01 c0                	add    %eax,%eax
  80126e:	01 d0                	add    %edx,%eax
  801270:	c1 e0 02             	shl    $0x2,%eax
  801273:	05 48 30 80 00       	add    $0x803048,%eax
  801278:	8b 00                	mov    (%eax),%eax
  80127a:	85 c0                	test   %eax,%eax
  80127c:	0f 84 9d 00 00 00    	je     80131f <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801282:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801285:	89 d0                	mov    %edx,%eax
  801287:	01 c0                	add    %eax,%eax
  801289:	01 d0                	add    %edx,%eax
  80128b:	c1 e0 02             	shl    $0x2,%eax
  80128e:	05 44 30 80 00       	add    $0x803044,%eax
  801293:	8b 00                	mov    (%eax),%eax
  801295:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801298:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80129b:	c1 e0 0c             	shl    $0xc,%eax
  80129e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  8012a1:	83 ec 08             	sub    $0x8,%esp
  8012a4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8012a7:	ff 75 f0             	pushl  -0x10(%ebp)
  8012aa:	e8 64 02 00 00       	call   801513 <sys_freeMem>
  8012af:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8012b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8012b9:	eb 57                	jmp    801312 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8012bb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012c1:	01 c2                	add    %eax,%edx
  8012c3:	89 d0                	mov    %edx,%eax
  8012c5:	01 c0                	add    %eax,%eax
  8012c7:	01 d0                	add    %edx,%eax
  8012c9:	c1 e0 02             	shl    $0x2,%eax
  8012cc:	05 48 30 80 00       	add    $0x803048,%eax
  8012d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  8012d7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012dd:	01 c2                	add    %eax,%edx
  8012df:	89 d0                	mov    %edx,%eax
  8012e1:	01 c0                	add    %eax,%eax
  8012e3:	01 d0                	add    %edx,%eax
  8012e5:	c1 e0 02             	shl    $0x2,%eax
  8012e8:	05 40 30 80 00       	add    $0x803040,%eax
  8012ed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8012f3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012f9:	01 c2                	add    %eax,%edx
  8012fb:	89 d0                	mov    %edx,%eax
  8012fd:	01 c0                	add    %eax,%eax
  8012ff:	01 d0                	add    %edx,%eax
  801301:	c1 e0 02             	shl    $0x2,%eax
  801304:	05 44 30 80 00       	add    $0x803044,%eax
  801309:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80130f:	ff 45 f4             	incl   -0xc(%ebp)
  801312:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801315:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801318:	7c a1                	jl     8012bb <free+0x94>
  80131a:	eb 04                	jmp    801320 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80131c:	90                   	nop
  80131d:	eb 01                	jmp    801320 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  80131f:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801320:	c9                   	leave  
  801321:	c3                   	ret    

00801322 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801322:	55                   	push   %ebp
  801323:	89 e5                	mov    %esp,%ebp
  801325:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801328:	83 ec 04             	sub    $0x4,%esp
  80132b:	68 f8 22 80 00       	push   $0x8022f8
  801330:	68 ae 00 00 00       	push   $0xae
  801335:	68 cf 22 80 00       	push   $0x8022cf
  80133a:	e8 eb 06 00 00       	call   801a2a <_panic>

0080133f <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80133f:	55                   	push   %ebp
  801340:	89 e5                	mov    %esp,%ebp
  801342:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801345:	83 ec 04             	sub    $0x4,%esp
  801348:	68 18 23 80 00       	push   $0x802318
  80134d:	68 ca 00 00 00       	push   $0xca
  801352:	68 cf 22 80 00       	push   $0x8022cf
  801357:	e8 ce 06 00 00       	call   801a2a <_panic>

0080135c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80135c:	55                   	push   %ebp
  80135d:	89 e5                	mov    %esp,%ebp
  80135f:	57                   	push   %edi
  801360:	56                   	push   %esi
  801361:	53                   	push   %ebx
  801362:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801365:	8b 45 08             	mov    0x8(%ebp),%eax
  801368:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80136e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801371:	8b 7d 18             	mov    0x18(%ebp),%edi
  801374:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801377:	cd 30                	int    $0x30
  801379:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80137c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80137f:	83 c4 10             	add    $0x10,%esp
  801382:	5b                   	pop    %ebx
  801383:	5e                   	pop    %esi
  801384:	5f                   	pop    %edi
  801385:	5d                   	pop    %ebp
  801386:	c3                   	ret    

00801387 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801387:	55                   	push   %ebp
  801388:	89 e5                	mov    %esp,%ebp
  80138a:	83 ec 04             	sub    $0x4,%esp
  80138d:	8b 45 10             	mov    0x10(%ebp),%eax
  801390:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801393:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	52                   	push   %edx
  80139f:	ff 75 0c             	pushl  0xc(%ebp)
  8013a2:	50                   	push   %eax
  8013a3:	6a 00                	push   $0x0
  8013a5:	e8 b2 ff ff ff       	call   80135c <syscall>
  8013aa:	83 c4 18             	add    $0x18,%esp
}
  8013ad:	90                   	nop
  8013ae:	c9                   	leave  
  8013af:	c3                   	ret    

008013b0 <sys_cgetc>:

int
sys_cgetc(void)
{
  8013b0:	55                   	push   %ebp
  8013b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 01                	push   $0x1
  8013bf:	e8 98 ff ff ff       	call   80135c <syscall>
  8013c4:	83 c4 18             	add    $0x18,%esp
}
  8013c7:	c9                   	leave  
  8013c8:	c3                   	ret    

008013c9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8013cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	50                   	push   %eax
  8013d8:	6a 05                	push   $0x5
  8013da:	e8 7d ff ff ff       	call   80135c <syscall>
  8013df:	83 c4 18             	add    $0x18,%esp
}
  8013e2:	c9                   	leave  
  8013e3:	c3                   	ret    

008013e4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013e4:	55                   	push   %ebp
  8013e5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 02                	push   $0x2
  8013f3:	e8 64 ff ff ff       	call   80135c <syscall>
  8013f8:	83 c4 18             	add    $0x18,%esp
}
  8013fb:	c9                   	leave  
  8013fc:	c3                   	ret    

008013fd <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013fd:	55                   	push   %ebp
  8013fe:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 03                	push   $0x3
  80140c:	e8 4b ff ff ff       	call   80135c <syscall>
  801411:	83 c4 18             	add    $0x18,%esp
}
  801414:	c9                   	leave  
  801415:	c3                   	ret    

00801416 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801416:	55                   	push   %ebp
  801417:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 04                	push   $0x4
  801425:	e8 32 ff ff ff       	call   80135c <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
}
  80142d:	c9                   	leave  
  80142e:	c3                   	ret    

0080142f <sys_env_exit>:


void sys_env_exit(void)
{
  80142f:	55                   	push   %ebp
  801430:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801432:	6a 00                	push   $0x0
  801434:	6a 00                	push   $0x0
  801436:	6a 00                	push   $0x0
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	6a 06                	push   $0x6
  80143e:	e8 19 ff ff ff       	call   80135c <syscall>
  801443:	83 c4 18             	add    $0x18,%esp
}
  801446:	90                   	nop
  801447:	c9                   	leave  
  801448:	c3                   	ret    

00801449 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80144c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80144f:	8b 45 08             	mov    0x8(%ebp),%eax
  801452:	6a 00                	push   $0x0
  801454:	6a 00                	push   $0x0
  801456:	6a 00                	push   $0x0
  801458:	52                   	push   %edx
  801459:	50                   	push   %eax
  80145a:	6a 07                	push   $0x7
  80145c:	e8 fb fe ff ff       	call   80135c <syscall>
  801461:	83 c4 18             	add    $0x18,%esp
}
  801464:	c9                   	leave  
  801465:	c3                   	ret    

00801466 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801466:	55                   	push   %ebp
  801467:	89 e5                	mov    %esp,%ebp
  801469:	56                   	push   %esi
  80146a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80146b:	8b 75 18             	mov    0x18(%ebp),%esi
  80146e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801471:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801474:	8b 55 0c             	mov    0xc(%ebp),%edx
  801477:	8b 45 08             	mov    0x8(%ebp),%eax
  80147a:	56                   	push   %esi
  80147b:	53                   	push   %ebx
  80147c:	51                   	push   %ecx
  80147d:	52                   	push   %edx
  80147e:	50                   	push   %eax
  80147f:	6a 08                	push   $0x8
  801481:	e8 d6 fe ff ff       	call   80135c <syscall>
  801486:	83 c4 18             	add    $0x18,%esp
}
  801489:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80148c:	5b                   	pop    %ebx
  80148d:	5e                   	pop    %esi
  80148e:	5d                   	pop    %ebp
  80148f:	c3                   	ret    

00801490 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801490:	55                   	push   %ebp
  801491:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801493:	8b 55 0c             	mov    0xc(%ebp),%edx
  801496:	8b 45 08             	mov    0x8(%ebp),%eax
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	52                   	push   %edx
  8014a0:	50                   	push   %eax
  8014a1:	6a 09                	push   $0x9
  8014a3:	e8 b4 fe ff ff       	call   80135c <syscall>
  8014a8:	83 c4 18             	add    $0x18,%esp
}
  8014ab:	c9                   	leave  
  8014ac:	c3                   	ret    

008014ad <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8014ad:	55                   	push   %ebp
  8014ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	ff 75 0c             	pushl  0xc(%ebp)
  8014b9:	ff 75 08             	pushl  0x8(%ebp)
  8014bc:	6a 0a                	push   $0xa
  8014be:	e8 99 fe ff ff       	call   80135c <syscall>
  8014c3:	83 c4 18             	add    $0x18,%esp
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 0b                	push   $0xb
  8014d7:	e8 80 fe ff ff       	call   80135c <syscall>
  8014dc:	83 c4 18             	add    $0x18,%esp
}
  8014df:	c9                   	leave  
  8014e0:	c3                   	ret    

008014e1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014e1:	55                   	push   %ebp
  8014e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 0c                	push   $0xc
  8014f0:	e8 67 fe ff ff       	call   80135c <syscall>
  8014f5:	83 c4 18             	add    $0x18,%esp
}
  8014f8:	c9                   	leave  
  8014f9:	c3                   	ret    

008014fa <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014fa:	55                   	push   %ebp
  8014fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	6a 0d                	push   $0xd
  801509:	e8 4e fe ff ff       	call   80135c <syscall>
  80150e:	83 c4 18             	add    $0x18,%esp
}
  801511:	c9                   	leave  
  801512:	c3                   	ret    

00801513 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801513:	55                   	push   %ebp
  801514:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	ff 75 0c             	pushl  0xc(%ebp)
  80151f:	ff 75 08             	pushl  0x8(%ebp)
  801522:	6a 11                	push   $0x11
  801524:	e8 33 fe ff ff       	call   80135c <syscall>
  801529:	83 c4 18             	add    $0x18,%esp
	return;
  80152c:	90                   	nop
}
  80152d:	c9                   	leave  
  80152e:	c3                   	ret    

0080152f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80152f:	55                   	push   %ebp
  801530:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	ff 75 0c             	pushl  0xc(%ebp)
  80153b:	ff 75 08             	pushl  0x8(%ebp)
  80153e:	6a 12                	push   $0x12
  801540:	e8 17 fe ff ff       	call   80135c <syscall>
  801545:	83 c4 18             	add    $0x18,%esp
	return ;
  801548:	90                   	nop
}
  801549:	c9                   	leave  
  80154a:	c3                   	ret    

0080154b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80154b:	55                   	push   %ebp
  80154c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 0e                	push   $0xe
  80155a:	e8 fd fd ff ff       	call   80135c <syscall>
  80155f:	83 c4 18             	add    $0x18,%esp
}
  801562:	c9                   	leave  
  801563:	c3                   	ret    

00801564 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801564:	55                   	push   %ebp
  801565:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	ff 75 08             	pushl  0x8(%ebp)
  801572:	6a 0f                	push   $0xf
  801574:	e8 e3 fd ff ff       	call   80135c <syscall>
  801579:	83 c4 18             	add    $0x18,%esp
}
  80157c:	c9                   	leave  
  80157d:	c3                   	ret    

0080157e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 10                	push   $0x10
  80158d:	e8 ca fd ff ff       	call   80135c <syscall>
  801592:	83 c4 18             	add    $0x18,%esp
}
  801595:	90                   	nop
  801596:	c9                   	leave  
  801597:	c3                   	ret    

00801598 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801598:	55                   	push   %ebp
  801599:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 14                	push   $0x14
  8015a7:	e8 b0 fd ff ff       	call   80135c <syscall>
  8015ac:	83 c4 18             	add    $0x18,%esp
}
  8015af:	90                   	nop
  8015b0:	c9                   	leave  
  8015b1:	c3                   	ret    

008015b2 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8015b2:	55                   	push   %ebp
  8015b3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 15                	push   $0x15
  8015c1:	e8 96 fd ff ff       	call   80135c <syscall>
  8015c6:	83 c4 18             	add    $0x18,%esp
}
  8015c9:	90                   	nop
  8015ca:	c9                   	leave  
  8015cb:	c3                   	ret    

008015cc <sys_cputc>:


void
sys_cputc(const char c)
{
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
  8015cf:	83 ec 04             	sub    $0x4,%esp
  8015d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8015d8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	50                   	push   %eax
  8015e5:	6a 16                	push   $0x16
  8015e7:	e8 70 fd ff ff       	call   80135c <syscall>
  8015ec:	83 c4 18             	add    $0x18,%esp
}
  8015ef:	90                   	nop
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 17                	push   $0x17
  801601:	e8 56 fd ff ff       	call   80135c <syscall>
  801606:	83 c4 18             	add    $0x18,%esp
}
  801609:	90                   	nop
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80160f:	8b 45 08             	mov    0x8(%ebp),%eax
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	ff 75 0c             	pushl  0xc(%ebp)
  80161b:	50                   	push   %eax
  80161c:	6a 18                	push   $0x18
  80161e:	e8 39 fd ff ff       	call   80135c <syscall>
  801623:	83 c4 18             	add    $0x18,%esp
}
  801626:	c9                   	leave  
  801627:	c3                   	ret    

00801628 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801628:	55                   	push   %ebp
  801629:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80162b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80162e:	8b 45 08             	mov    0x8(%ebp),%eax
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	52                   	push   %edx
  801638:	50                   	push   %eax
  801639:	6a 1b                	push   $0x1b
  80163b:	e8 1c fd ff ff       	call   80135c <syscall>
  801640:	83 c4 18             	add    $0x18,%esp
}
  801643:	c9                   	leave  
  801644:	c3                   	ret    

00801645 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801645:	55                   	push   %ebp
  801646:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801648:	8b 55 0c             	mov    0xc(%ebp),%edx
  80164b:	8b 45 08             	mov    0x8(%ebp),%eax
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	52                   	push   %edx
  801655:	50                   	push   %eax
  801656:	6a 19                	push   $0x19
  801658:	e8 ff fc ff ff       	call   80135c <syscall>
  80165d:	83 c4 18             	add    $0x18,%esp
}
  801660:	90                   	nop
  801661:	c9                   	leave  
  801662:	c3                   	ret    

00801663 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801663:	55                   	push   %ebp
  801664:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801666:	8b 55 0c             	mov    0xc(%ebp),%edx
  801669:	8b 45 08             	mov    0x8(%ebp),%eax
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	52                   	push   %edx
  801673:	50                   	push   %eax
  801674:	6a 1a                	push   $0x1a
  801676:	e8 e1 fc ff ff       	call   80135c <syscall>
  80167b:	83 c4 18             	add    $0x18,%esp
}
  80167e:	90                   	nop
  80167f:	c9                   	leave  
  801680:	c3                   	ret    

00801681 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801681:	55                   	push   %ebp
  801682:	89 e5                	mov    %esp,%ebp
  801684:	83 ec 04             	sub    $0x4,%esp
  801687:	8b 45 10             	mov    0x10(%ebp),%eax
  80168a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80168d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801690:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801694:	8b 45 08             	mov    0x8(%ebp),%eax
  801697:	6a 00                	push   $0x0
  801699:	51                   	push   %ecx
  80169a:	52                   	push   %edx
  80169b:	ff 75 0c             	pushl  0xc(%ebp)
  80169e:	50                   	push   %eax
  80169f:	6a 1c                	push   $0x1c
  8016a1:	e8 b6 fc ff ff       	call   80135c <syscall>
  8016a6:	83 c4 18             	add    $0x18,%esp
}
  8016a9:	c9                   	leave  
  8016aa:	c3                   	ret    

008016ab <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8016ab:	55                   	push   %ebp
  8016ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8016ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	52                   	push   %edx
  8016bb:	50                   	push   %eax
  8016bc:	6a 1d                	push   $0x1d
  8016be:	e8 99 fc ff ff       	call   80135c <syscall>
  8016c3:	83 c4 18             	add    $0x18,%esp
}
  8016c6:	c9                   	leave  
  8016c7:	c3                   	ret    

008016c8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8016c8:	55                   	push   %ebp
  8016c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8016cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	51                   	push   %ecx
  8016d9:	52                   	push   %edx
  8016da:	50                   	push   %eax
  8016db:	6a 1e                	push   $0x1e
  8016dd:	e8 7a fc ff ff       	call   80135c <syscall>
  8016e2:	83 c4 18             	add    $0x18,%esp
}
  8016e5:	c9                   	leave  
  8016e6:	c3                   	ret    

008016e7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016e7:	55                   	push   %ebp
  8016e8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	52                   	push   %edx
  8016f7:	50                   	push   %eax
  8016f8:	6a 1f                	push   $0x1f
  8016fa:	e8 5d fc ff ff       	call   80135c <syscall>
  8016ff:	83 c4 18             	add    $0x18,%esp
}
  801702:	c9                   	leave  
  801703:	c3                   	ret    

00801704 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801704:	55                   	push   %ebp
  801705:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801707:	6a 00                	push   $0x0
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 20                	push   $0x20
  801713:	e8 44 fc ff ff       	call   80135c <syscall>
  801718:	83 c4 18             	add    $0x18,%esp
}
  80171b:	c9                   	leave  
  80171c:	c3                   	ret    

0080171d <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80171d:	55                   	push   %ebp
  80171e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801720:	8b 45 08             	mov    0x8(%ebp),%eax
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	ff 75 10             	pushl  0x10(%ebp)
  80172a:	ff 75 0c             	pushl  0xc(%ebp)
  80172d:	50                   	push   %eax
  80172e:	6a 21                	push   $0x21
  801730:	e8 27 fc ff ff       	call   80135c <syscall>
  801735:	83 c4 18             	add    $0x18,%esp
}
  801738:	c9                   	leave  
  801739:	c3                   	ret    

0080173a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80173a:	55                   	push   %ebp
  80173b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80173d:	8b 45 08             	mov    0x8(%ebp),%eax
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	50                   	push   %eax
  801749:	6a 22                	push   $0x22
  80174b:	e8 0c fc ff ff       	call   80135c <syscall>
  801750:	83 c4 18             	add    $0x18,%esp
}
  801753:	90                   	nop
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801759:	8b 45 08             	mov    0x8(%ebp),%eax
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	50                   	push   %eax
  801765:	6a 23                	push   $0x23
  801767:	e8 f0 fb ff ff       	call   80135c <syscall>
  80176c:	83 c4 18             	add    $0x18,%esp
}
  80176f:	90                   	nop
  801770:	c9                   	leave  
  801771:	c3                   	ret    

00801772 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801772:	55                   	push   %ebp
  801773:	89 e5                	mov    %esp,%ebp
  801775:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801778:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80177b:	8d 50 04             	lea    0x4(%eax),%edx
  80177e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	52                   	push   %edx
  801788:	50                   	push   %eax
  801789:	6a 24                	push   $0x24
  80178b:	e8 cc fb ff ff       	call   80135c <syscall>
  801790:	83 c4 18             	add    $0x18,%esp
	return result;
  801793:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801796:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801799:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80179c:	89 01                	mov    %eax,(%ecx)
  80179e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8017a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a4:	c9                   	leave  
  8017a5:	c2 04 00             	ret    $0x4

008017a8 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8017a8:	55                   	push   %ebp
  8017a9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	ff 75 10             	pushl  0x10(%ebp)
  8017b2:	ff 75 0c             	pushl  0xc(%ebp)
  8017b5:	ff 75 08             	pushl  0x8(%ebp)
  8017b8:	6a 13                	push   $0x13
  8017ba:	e8 9d fb ff ff       	call   80135c <syscall>
  8017bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c2:	90                   	nop
}
  8017c3:	c9                   	leave  
  8017c4:	c3                   	ret    

008017c5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8017c5:	55                   	push   %ebp
  8017c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 25                	push   $0x25
  8017d4:	e8 83 fb ff ff       	call   80135c <syscall>
  8017d9:	83 c4 18             	add    $0x18,%esp
}
  8017dc:	c9                   	leave  
  8017dd:	c3                   	ret    

008017de <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017de:	55                   	push   %ebp
  8017df:	89 e5                	mov    %esp,%ebp
  8017e1:	83 ec 04             	sub    $0x4,%esp
  8017e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017ea:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	50                   	push   %eax
  8017f7:	6a 26                	push   $0x26
  8017f9:	e8 5e fb ff ff       	call   80135c <syscall>
  8017fe:	83 c4 18             	add    $0x18,%esp
	return ;
  801801:	90                   	nop
}
  801802:	c9                   	leave  
  801803:	c3                   	ret    

00801804 <rsttst>:
void rsttst()
{
  801804:	55                   	push   %ebp
  801805:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 28                	push   $0x28
  801813:	e8 44 fb ff ff       	call   80135c <syscall>
  801818:	83 c4 18             	add    $0x18,%esp
	return ;
  80181b:	90                   	nop
}
  80181c:	c9                   	leave  
  80181d:	c3                   	ret    

0080181e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80181e:	55                   	push   %ebp
  80181f:	89 e5                	mov    %esp,%ebp
  801821:	83 ec 04             	sub    $0x4,%esp
  801824:	8b 45 14             	mov    0x14(%ebp),%eax
  801827:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80182a:	8b 55 18             	mov    0x18(%ebp),%edx
  80182d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801831:	52                   	push   %edx
  801832:	50                   	push   %eax
  801833:	ff 75 10             	pushl  0x10(%ebp)
  801836:	ff 75 0c             	pushl  0xc(%ebp)
  801839:	ff 75 08             	pushl  0x8(%ebp)
  80183c:	6a 27                	push   $0x27
  80183e:	e8 19 fb ff ff       	call   80135c <syscall>
  801843:	83 c4 18             	add    $0x18,%esp
	return ;
  801846:	90                   	nop
}
  801847:	c9                   	leave  
  801848:	c3                   	ret    

00801849 <chktst>:
void chktst(uint32 n)
{
  801849:	55                   	push   %ebp
  80184a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	ff 75 08             	pushl  0x8(%ebp)
  801857:	6a 29                	push   $0x29
  801859:	e8 fe fa ff ff       	call   80135c <syscall>
  80185e:	83 c4 18             	add    $0x18,%esp
	return ;
  801861:	90                   	nop
}
  801862:	c9                   	leave  
  801863:	c3                   	ret    

00801864 <inctst>:

void inctst()
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 2a                	push   $0x2a
  801873:	e8 e4 fa ff ff       	call   80135c <syscall>
  801878:	83 c4 18             	add    $0x18,%esp
	return ;
  80187b:	90                   	nop
}
  80187c:	c9                   	leave  
  80187d:	c3                   	ret    

0080187e <gettst>:
uint32 gettst()
{
  80187e:	55                   	push   %ebp
  80187f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801881:	6a 00                	push   $0x0
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 2b                	push   $0x2b
  80188d:	e8 ca fa ff ff       	call   80135c <syscall>
  801892:	83 c4 18             	add    $0x18,%esp
}
  801895:	c9                   	leave  
  801896:	c3                   	ret    

00801897 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801897:	55                   	push   %ebp
  801898:	89 e5                	mov    %esp,%ebp
  80189a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 2c                	push   $0x2c
  8018a9:	e8 ae fa ff ff       	call   80135c <syscall>
  8018ae:	83 c4 18             	add    $0x18,%esp
  8018b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8018b4:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8018b8:	75 07                	jne    8018c1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8018ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8018bf:	eb 05                	jmp    8018c6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8018c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018c6:	c9                   	leave  
  8018c7:	c3                   	ret    

008018c8 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8018c8:	55                   	push   %ebp
  8018c9:	89 e5                	mov    %esp,%ebp
  8018cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 2c                	push   $0x2c
  8018da:	e8 7d fa ff ff       	call   80135c <syscall>
  8018df:	83 c4 18             	add    $0x18,%esp
  8018e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018e5:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018e9:	75 07                	jne    8018f2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8018f0:	eb 05                	jmp    8018f7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018f7:	c9                   	leave  
  8018f8:	c3                   	ret    

008018f9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018f9:	55                   	push   %ebp
  8018fa:	89 e5                	mov    %esp,%ebp
  8018fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	6a 00                	push   $0x0
  801905:	6a 00                	push   $0x0
  801907:	6a 00                	push   $0x0
  801909:	6a 2c                	push   $0x2c
  80190b:	e8 4c fa ff ff       	call   80135c <syscall>
  801910:	83 c4 18             	add    $0x18,%esp
  801913:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801916:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80191a:	75 07                	jne    801923 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80191c:	b8 01 00 00 00       	mov    $0x1,%eax
  801921:	eb 05                	jmp    801928 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801923:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801928:	c9                   	leave  
  801929:	c3                   	ret    

0080192a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80192a:	55                   	push   %ebp
  80192b:	89 e5                	mov    %esp,%ebp
  80192d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	6a 2c                	push   $0x2c
  80193c:	e8 1b fa ff ff       	call   80135c <syscall>
  801941:	83 c4 18             	add    $0x18,%esp
  801944:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801947:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80194b:	75 07                	jne    801954 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80194d:	b8 01 00 00 00       	mov    $0x1,%eax
  801952:	eb 05                	jmp    801959 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801954:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801959:	c9                   	leave  
  80195a:	c3                   	ret    

0080195b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80195b:	55                   	push   %ebp
  80195c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	ff 75 08             	pushl  0x8(%ebp)
  801969:	6a 2d                	push   $0x2d
  80196b:	e8 ec f9 ff ff       	call   80135c <syscall>
  801970:	83 c4 18             	add    $0x18,%esp
	return ;
  801973:	90                   	nop
}
  801974:	c9                   	leave  
  801975:	c3                   	ret    

00801976 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801976:	55                   	push   %ebp
  801977:	89 e5                	mov    %esp,%ebp
  801979:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80197c:	8b 55 08             	mov    0x8(%ebp),%edx
  80197f:	89 d0                	mov    %edx,%eax
  801981:	c1 e0 02             	shl    $0x2,%eax
  801984:	01 d0                	add    %edx,%eax
  801986:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80198d:	01 d0                	add    %edx,%eax
  80198f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801996:	01 d0                	add    %edx,%eax
  801998:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80199f:	01 d0                	add    %edx,%eax
  8019a1:	c1 e0 04             	shl    $0x4,%eax
  8019a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8019a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8019ae:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8019b1:	83 ec 0c             	sub    $0xc,%esp
  8019b4:	50                   	push   %eax
  8019b5:	e8 b8 fd ff ff       	call   801772 <sys_get_virtual_time>
  8019ba:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8019bd:	eb 41                	jmp    801a00 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8019bf:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8019c2:	83 ec 0c             	sub    $0xc,%esp
  8019c5:	50                   	push   %eax
  8019c6:	e8 a7 fd ff ff       	call   801772 <sys_get_virtual_time>
  8019cb:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8019ce:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019d4:	29 c2                	sub    %eax,%edx
  8019d6:	89 d0                	mov    %edx,%eax
  8019d8:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8019db:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8019de:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019e1:	89 d1                	mov    %edx,%ecx
  8019e3:	29 c1                	sub    %eax,%ecx
  8019e5:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8019e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019eb:	39 c2                	cmp    %eax,%edx
  8019ed:	0f 97 c0             	seta   %al
  8019f0:	0f b6 c0             	movzbl %al,%eax
  8019f3:	29 c1                	sub    %eax,%ecx
  8019f5:	89 c8                	mov    %ecx,%eax
  8019f7:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8019fa:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8019fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a00:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a03:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a06:	72 b7                	jb     8019bf <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801a08:	90                   	nop
  801a09:	c9                   	leave  
  801a0a:	c3                   	ret    

00801a0b <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801a0b:	55                   	push   %ebp
  801a0c:	89 e5                	mov    %esp,%ebp
  801a0e:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801a11:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801a18:	eb 03                	jmp    801a1d <busy_wait+0x12>
  801a1a:	ff 45 fc             	incl   -0x4(%ebp)
  801a1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a20:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a23:	72 f5                	jb     801a1a <busy_wait+0xf>
	return i;
  801a25:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801a28:	c9                   	leave  
  801a29:	c3                   	ret    

00801a2a <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
  801a2d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801a30:	8d 45 10             	lea    0x10(%ebp),%eax
  801a33:	83 c0 04             	add    $0x4,%eax
  801a36:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801a39:	a1 40 30 98 00       	mov    0x983040,%eax
  801a3e:	85 c0                	test   %eax,%eax
  801a40:	74 16                	je     801a58 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801a42:	a1 40 30 98 00       	mov    0x983040,%eax
  801a47:	83 ec 08             	sub    $0x8,%esp
  801a4a:	50                   	push   %eax
  801a4b:	68 3c 23 80 00       	push   $0x80233c
  801a50:	e8 ed e8 ff ff       	call   800342 <cprintf>
  801a55:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801a58:	a1 00 30 80 00       	mov    0x803000,%eax
  801a5d:	ff 75 0c             	pushl  0xc(%ebp)
  801a60:	ff 75 08             	pushl  0x8(%ebp)
  801a63:	50                   	push   %eax
  801a64:	68 41 23 80 00       	push   $0x802341
  801a69:	e8 d4 e8 ff ff       	call   800342 <cprintf>
  801a6e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801a71:	8b 45 10             	mov    0x10(%ebp),%eax
  801a74:	83 ec 08             	sub    $0x8,%esp
  801a77:	ff 75 f4             	pushl  -0xc(%ebp)
  801a7a:	50                   	push   %eax
  801a7b:	e8 57 e8 ff ff       	call   8002d7 <vcprintf>
  801a80:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801a83:	83 ec 08             	sub    $0x8,%esp
  801a86:	6a 00                	push   $0x0
  801a88:	68 5d 23 80 00       	push   $0x80235d
  801a8d:	e8 45 e8 ff ff       	call   8002d7 <vcprintf>
  801a92:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801a95:	e8 c6 e7 ff ff       	call   800260 <exit>

	// should not return here
	while (1) ;
  801a9a:	eb fe                	jmp    801a9a <_panic+0x70>

00801a9c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801a9c:	55                   	push   %ebp
  801a9d:	89 e5                	mov    %esp,%ebp
  801a9f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801aa2:	a1 20 30 80 00       	mov    0x803020,%eax
  801aa7:	8b 50 74             	mov    0x74(%eax),%edx
  801aaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aad:	39 c2                	cmp    %eax,%edx
  801aaf:	74 14                	je     801ac5 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801ab1:	83 ec 04             	sub    $0x4,%esp
  801ab4:	68 60 23 80 00       	push   $0x802360
  801ab9:	6a 26                	push   $0x26
  801abb:	68 ac 23 80 00       	push   $0x8023ac
  801ac0:	e8 65 ff ff ff       	call   801a2a <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801ac5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801acc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ad3:	e9 c2 00 00 00       	jmp    801b9a <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801ad8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801adb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae5:	01 d0                	add    %edx,%eax
  801ae7:	8b 00                	mov    (%eax),%eax
  801ae9:	85 c0                	test   %eax,%eax
  801aeb:	75 08                	jne    801af5 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801aed:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801af0:	e9 a2 00 00 00       	jmp    801b97 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801af5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801afc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801b03:	eb 69                	jmp    801b6e <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801b05:	a1 20 30 80 00       	mov    0x803020,%eax
  801b0a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801b10:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801b13:	89 d0                	mov    %edx,%eax
  801b15:	01 c0                	add    %eax,%eax
  801b17:	01 d0                	add    %edx,%eax
  801b19:	c1 e0 02             	shl    $0x2,%eax
  801b1c:	01 c8                	add    %ecx,%eax
  801b1e:	8a 40 04             	mov    0x4(%eax),%al
  801b21:	84 c0                	test   %al,%al
  801b23:	75 46                	jne    801b6b <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801b25:	a1 20 30 80 00       	mov    0x803020,%eax
  801b2a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801b30:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801b33:	89 d0                	mov    %edx,%eax
  801b35:	01 c0                	add    %eax,%eax
  801b37:	01 d0                	add    %edx,%eax
  801b39:	c1 e0 02             	shl    $0x2,%eax
  801b3c:	01 c8                	add    %ecx,%eax
  801b3e:	8b 00                	mov    (%eax),%eax
  801b40:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801b43:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b46:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801b4b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801b4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b50:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801b57:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5a:	01 c8                	add    %ecx,%eax
  801b5c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801b5e:	39 c2                	cmp    %eax,%edx
  801b60:	75 09                	jne    801b6b <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801b62:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801b69:	eb 12                	jmp    801b7d <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b6b:	ff 45 e8             	incl   -0x18(%ebp)
  801b6e:	a1 20 30 80 00       	mov    0x803020,%eax
  801b73:	8b 50 74             	mov    0x74(%eax),%edx
  801b76:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b79:	39 c2                	cmp    %eax,%edx
  801b7b:	77 88                	ja     801b05 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801b7d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801b81:	75 14                	jne    801b97 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801b83:	83 ec 04             	sub    $0x4,%esp
  801b86:	68 b8 23 80 00       	push   $0x8023b8
  801b8b:	6a 3a                	push   $0x3a
  801b8d:	68 ac 23 80 00       	push   $0x8023ac
  801b92:	e8 93 fe ff ff       	call   801a2a <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801b97:	ff 45 f0             	incl   -0x10(%ebp)
  801b9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b9d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801ba0:	0f 8c 32 ff ff ff    	jl     801ad8 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801ba6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bad:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801bb4:	eb 26                	jmp    801bdc <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801bb6:	a1 20 30 80 00       	mov    0x803020,%eax
  801bbb:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801bc1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801bc4:	89 d0                	mov    %edx,%eax
  801bc6:	01 c0                	add    %eax,%eax
  801bc8:	01 d0                	add    %edx,%eax
  801bca:	c1 e0 02             	shl    $0x2,%eax
  801bcd:	01 c8                	add    %ecx,%eax
  801bcf:	8a 40 04             	mov    0x4(%eax),%al
  801bd2:	3c 01                	cmp    $0x1,%al
  801bd4:	75 03                	jne    801bd9 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801bd6:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bd9:	ff 45 e0             	incl   -0x20(%ebp)
  801bdc:	a1 20 30 80 00       	mov    0x803020,%eax
  801be1:	8b 50 74             	mov    0x74(%eax),%edx
  801be4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801be7:	39 c2                	cmp    %eax,%edx
  801be9:	77 cb                	ja     801bb6 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801beb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bee:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801bf1:	74 14                	je     801c07 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801bf3:	83 ec 04             	sub    $0x4,%esp
  801bf6:	68 0c 24 80 00       	push   $0x80240c
  801bfb:	6a 44                	push   $0x44
  801bfd:	68 ac 23 80 00       	push   $0x8023ac
  801c02:	e8 23 fe ff ff       	call   801a2a <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801c07:	90                   	nop
  801c08:	c9                   	leave  
  801c09:	c3                   	ret    
  801c0a:	66 90                	xchg   %ax,%ax

00801c0c <__udivdi3>:
  801c0c:	55                   	push   %ebp
  801c0d:	57                   	push   %edi
  801c0e:	56                   	push   %esi
  801c0f:	53                   	push   %ebx
  801c10:	83 ec 1c             	sub    $0x1c,%esp
  801c13:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c17:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c1f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c23:	89 ca                	mov    %ecx,%edx
  801c25:	89 f8                	mov    %edi,%eax
  801c27:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c2b:	85 f6                	test   %esi,%esi
  801c2d:	75 2d                	jne    801c5c <__udivdi3+0x50>
  801c2f:	39 cf                	cmp    %ecx,%edi
  801c31:	77 65                	ja     801c98 <__udivdi3+0x8c>
  801c33:	89 fd                	mov    %edi,%ebp
  801c35:	85 ff                	test   %edi,%edi
  801c37:	75 0b                	jne    801c44 <__udivdi3+0x38>
  801c39:	b8 01 00 00 00       	mov    $0x1,%eax
  801c3e:	31 d2                	xor    %edx,%edx
  801c40:	f7 f7                	div    %edi
  801c42:	89 c5                	mov    %eax,%ebp
  801c44:	31 d2                	xor    %edx,%edx
  801c46:	89 c8                	mov    %ecx,%eax
  801c48:	f7 f5                	div    %ebp
  801c4a:	89 c1                	mov    %eax,%ecx
  801c4c:	89 d8                	mov    %ebx,%eax
  801c4e:	f7 f5                	div    %ebp
  801c50:	89 cf                	mov    %ecx,%edi
  801c52:	89 fa                	mov    %edi,%edx
  801c54:	83 c4 1c             	add    $0x1c,%esp
  801c57:	5b                   	pop    %ebx
  801c58:	5e                   	pop    %esi
  801c59:	5f                   	pop    %edi
  801c5a:	5d                   	pop    %ebp
  801c5b:	c3                   	ret    
  801c5c:	39 ce                	cmp    %ecx,%esi
  801c5e:	77 28                	ja     801c88 <__udivdi3+0x7c>
  801c60:	0f bd fe             	bsr    %esi,%edi
  801c63:	83 f7 1f             	xor    $0x1f,%edi
  801c66:	75 40                	jne    801ca8 <__udivdi3+0x9c>
  801c68:	39 ce                	cmp    %ecx,%esi
  801c6a:	72 0a                	jb     801c76 <__udivdi3+0x6a>
  801c6c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c70:	0f 87 9e 00 00 00    	ja     801d14 <__udivdi3+0x108>
  801c76:	b8 01 00 00 00       	mov    $0x1,%eax
  801c7b:	89 fa                	mov    %edi,%edx
  801c7d:	83 c4 1c             	add    $0x1c,%esp
  801c80:	5b                   	pop    %ebx
  801c81:	5e                   	pop    %esi
  801c82:	5f                   	pop    %edi
  801c83:	5d                   	pop    %ebp
  801c84:	c3                   	ret    
  801c85:	8d 76 00             	lea    0x0(%esi),%esi
  801c88:	31 ff                	xor    %edi,%edi
  801c8a:	31 c0                	xor    %eax,%eax
  801c8c:	89 fa                	mov    %edi,%edx
  801c8e:	83 c4 1c             	add    $0x1c,%esp
  801c91:	5b                   	pop    %ebx
  801c92:	5e                   	pop    %esi
  801c93:	5f                   	pop    %edi
  801c94:	5d                   	pop    %ebp
  801c95:	c3                   	ret    
  801c96:	66 90                	xchg   %ax,%ax
  801c98:	89 d8                	mov    %ebx,%eax
  801c9a:	f7 f7                	div    %edi
  801c9c:	31 ff                	xor    %edi,%edi
  801c9e:	89 fa                	mov    %edi,%edx
  801ca0:	83 c4 1c             	add    $0x1c,%esp
  801ca3:	5b                   	pop    %ebx
  801ca4:	5e                   	pop    %esi
  801ca5:	5f                   	pop    %edi
  801ca6:	5d                   	pop    %ebp
  801ca7:	c3                   	ret    
  801ca8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801cad:	89 eb                	mov    %ebp,%ebx
  801caf:	29 fb                	sub    %edi,%ebx
  801cb1:	89 f9                	mov    %edi,%ecx
  801cb3:	d3 e6                	shl    %cl,%esi
  801cb5:	89 c5                	mov    %eax,%ebp
  801cb7:	88 d9                	mov    %bl,%cl
  801cb9:	d3 ed                	shr    %cl,%ebp
  801cbb:	89 e9                	mov    %ebp,%ecx
  801cbd:	09 f1                	or     %esi,%ecx
  801cbf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801cc3:	89 f9                	mov    %edi,%ecx
  801cc5:	d3 e0                	shl    %cl,%eax
  801cc7:	89 c5                	mov    %eax,%ebp
  801cc9:	89 d6                	mov    %edx,%esi
  801ccb:	88 d9                	mov    %bl,%cl
  801ccd:	d3 ee                	shr    %cl,%esi
  801ccf:	89 f9                	mov    %edi,%ecx
  801cd1:	d3 e2                	shl    %cl,%edx
  801cd3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cd7:	88 d9                	mov    %bl,%cl
  801cd9:	d3 e8                	shr    %cl,%eax
  801cdb:	09 c2                	or     %eax,%edx
  801cdd:	89 d0                	mov    %edx,%eax
  801cdf:	89 f2                	mov    %esi,%edx
  801ce1:	f7 74 24 0c          	divl   0xc(%esp)
  801ce5:	89 d6                	mov    %edx,%esi
  801ce7:	89 c3                	mov    %eax,%ebx
  801ce9:	f7 e5                	mul    %ebp
  801ceb:	39 d6                	cmp    %edx,%esi
  801ced:	72 19                	jb     801d08 <__udivdi3+0xfc>
  801cef:	74 0b                	je     801cfc <__udivdi3+0xf0>
  801cf1:	89 d8                	mov    %ebx,%eax
  801cf3:	31 ff                	xor    %edi,%edi
  801cf5:	e9 58 ff ff ff       	jmp    801c52 <__udivdi3+0x46>
  801cfa:	66 90                	xchg   %ax,%ax
  801cfc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d00:	89 f9                	mov    %edi,%ecx
  801d02:	d3 e2                	shl    %cl,%edx
  801d04:	39 c2                	cmp    %eax,%edx
  801d06:	73 e9                	jae    801cf1 <__udivdi3+0xe5>
  801d08:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d0b:	31 ff                	xor    %edi,%edi
  801d0d:	e9 40 ff ff ff       	jmp    801c52 <__udivdi3+0x46>
  801d12:	66 90                	xchg   %ax,%ax
  801d14:	31 c0                	xor    %eax,%eax
  801d16:	e9 37 ff ff ff       	jmp    801c52 <__udivdi3+0x46>
  801d1b:	90                   	nop

00801d1c <__umoddi3>:
  801d1c:	55                   	push   %ebp
  801d1d:	57                   	push   %edi
  801d1e:	56                   	push   %esi
  801d1f:	53                   	push   %ebx
  801d20:	83 ec 1c             	sub    $0x1c,%esp
  801d23:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d27:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d2b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d2f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d33:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d37:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d3b:	89 f3                	mov    %esi,%ebx
  801d3d:	89 fa                	mov    %edi,%edx
  801d3f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d43:	89 34 24             	mov    %esi,(%esp)
  801d46:	85 c0                	test   %eax,%eax
  801d48:	75 1a                	jne    801d64 <__umoddi3+0x48>
  801d4a:	39 f7                	cmp    %esi,%edi
  801d4c:	0f 86 a2 00 00 00    	jbe    801df4 <__umoddi3+0xd8>
  801d52:	89 c8                	mov    %ecx,%eax
  801d54:	89 f2                	mov    %esi,%edx
  801d56:	f7 f7                	div    %edi
  801d58:	89 d0                	mov    %edx,%eax
  801d5a:	31 d2                	xor    %edx,%edx
  801d5c:	83 c4 1c             	add    $0x1c,%esp
  801d5f:	5b                   	pop    %ebx
  801d60:	5e                   	pop    %esi
  801d61:	5f                   	pop    %edi
  801d62:	5d                   	pop    %ebp
  801d63:	c3                   	ret    
  801d64:	39 f0                	cmp    %esi,%eax
  801d66:	0f 87 ac 00 00 00    	ja     801e18 <__umoddi3+0xfc>
  801d6c:	0f bd e8             	bsr    %eax,%ebp
  801d6f:	83 f5 1f             	xor    $0x1f,%ebp
  801d72:	0f 84 ac 00 00 00    	je     801e24 <__umoddi3+0x108>
  801d78:	bf 20 00 00 00       	mov    $0x20,%edi
  801d7d:	29 ef                	sub    %ebp,%edi
  801d7f:	89 fe                	mov    %edi,%esi
  801d81:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d85:	89 e9                	mov    %ebp,%ecx
  801d87:	d3 e0                	shl    %cl,%eax
  801d89:	89 d7                	mov    %edx,%edi
  801d8b:	89 f1                	mov    %esi,%ecx
  801d8d:	d3 ef                	shr    %cl,%edi
  801d8f:	09 c7                	or     %eax,%edi
  801d91:	89 e9                	mov    %ebp,%ecx
  801d93:	d3 e2                	shl    %cl,%edx
  801d95:	89 14 24             	mov    %edx,(%esp)
  801d98:	89 d8                	mov    %ebx,%eax
  801d9a:	d3 e0                	shl    %cl,%eax
  801d9c:	89 c2                	mov    %eax,%edx
  801d9e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801da2:	d3 e0                	shl    %cl,%eax
  801da4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801da8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dac:	89 f1                	mov    %esi,%ecx
  801dae:	d3 e8                	shr    %cl,%eax
  801db0:	09 d0                	or     %edx,%eax
  801db2:	d3 eb                	shr    %cl,%ebx
  801db4:	89 da                	mov    %ebx,%edx
  801db6:	f7 f7                	div    %edi
  801db8:	89 d3                	mov    %edx,%ebx
  801dba:	f7 24 24             	mull   (%esp)
  801dbd:	89 c6                	mov    %eax,%esi
  801dbf:	89 d1                	mov    %edx,%ecx
  801dc1:	39 d3                	cmp    %edx,%ebx
  801dc3:	0f 82 87 00 00 00    	jb     801e50 <__umoddi3+0x134>
  801dc9:	0f 84 91 00 00 00    	je     801e60 <__umoddi3+0x144>
  801dcf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801dd3:	29 f2                	sub    %esi,%edx
  801dd5:	19 cb                	sbb    %ecx,%ebx
  801dd7:	89 d8                	mov    %ebx,%eax
  801dd9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ddd:	d3 e0                	shl    %cl,%eax
  801ddf:	89 e9                	mov    %ebp,%ecx
  801de1:	d3 ea                	shr    %cl,%edx
  801de3:	09 d0                	or     %edx,%eax
  801de5:	89 e9                	mov    %ebp,%ecx
  801de7:	d3 eb                	shr    %cl,%ebx
  801de9:	89 da                	mov    %ebx,%edx
  801deb:	83 c4 1c             	add    $0x1c,%esp
  801dee:	5b                   	pop    %ebx
  801def:	5e                   	pop    %esi
  801df0:	5f                   	pop    %edi
  801df1:	5d                   	pop    %ebp
  801df2:	c3                   	ret    
  801df3:	90                   	nop
  801df4:	89 fd                	mov    %edi,%ebp
  801df6:	85 ff                	test   %edi,%edi
  801df8:	75 0b                	jne    801e05 <__umoddi3+0xe9>
  801dfa:	b8 01 00 00 00       	mov    $0x1,%eax
  801dff:	31 d2                	xor    %edx,%edx
  801e01:	f7 f7                	div    %edi
  801e03:	89 c5                	mov    %eax,%ebp
  801e05:	89 f0                	mov    %esi,%eax
  801e07:	31 d2                	xor    %edx,%edx
  801e09:	f7 f5                	div    %ebp
  801e0b:	89 c8                	mov    %ecx,%eax
  801e0d:	f7 f5                	div    %ebp
  801e0f:	89 d0                	mov    %edx,%eax
  801e11:	e9 44 ff ff ff       	jmp    801d5a <__umoddi3+0x3e>
  801e16:	66 90                	xchg   %ax,%ax
  801e18:	89 c8                	mov    %ecx,%eax
  801e1a:	89 f2                	mov    %esi,%edx
  801e1c:	83 c4 1c             	add    $0x1c,%esp
  801e1f:	5b                   	pop    %ebx
  801e20:	5e                   	pop    %esi
  801e21:	5f                   	pop    %edi
  801e22:	5d                   	pop    %ebp
  801e23:	c3                   	ret    
  801e24:	3b 04 24             	cmp    (%esp),%eax
  801e27:	72 06                	jb     801e2f <__umoddi3+0x113>
  801e29:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e2d:	77 0f                	ja     801e3e <__umoddi3+0x122>
  801e2f:	89 f2                	mov    %esi,%edx
  801e31:	29 f9                	sub    %edi,%ecx
  801e33:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e37:	89 14 24             	mov    %edx,(%esp)
  801e3a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e3e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e42:	8b 14 24             	mov    (%esp),%edx
  801e45:	83 c4 1c             	add    $0x1c,%esp
  801e48:	5b                   	pop    %ebx
  801e49:	5e                   	pop    %esi
  801e4a:	5f                   	pop    %edi
  801e4b:	5d                   	pop    %ebp
  801e4c:	c3                   	ret    
  801e4d:	8d 76 00             	lea    0x0(%esi),%esi
  801e50:	2b 04 24             	sub    (%esp),%eax
  801e53:	19 fa                	sbb    %edi,%edx
  801e55:	89 d1                	mov    %edx,%ecx
  801e57:	89 c6                	mov    %eax,%esi
  801e59:	e9 71 ff ff ff       	jmp    801dcf <__umoddi3+0xb3>
  801e5e:	66 90                	xchg   %ax,%ax
  801e60:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e64:	72 ea                	jb     801e50 <__umoddi3+0x134>
  801e66:	89 d9                	mov    %ebx,%ecx
  801e68:	e9 62 ff ff ff       	jmp    801dcf <__umoddi3+0xb3>
