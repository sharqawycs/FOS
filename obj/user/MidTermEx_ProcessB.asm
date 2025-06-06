
obj/user/MidTermEx_ProcessB:     file format elf32-i386


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
  800031:	e8 35 01 00 00       	call   80016b <libmain>
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
  80003e:	e8 d2 13 00 00       	call   801415 <sys_getparentenvid>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int delay;

	/*[1] GET SHARED VARIABLE, SEMAPHORE SEL, check-finishing counter*/
	int *X = sget(parentenvID, "X") ;
  800046:	83 ec 08             	sub    $0x8,%esp
  800049:	68 80 1e 80 00       	push   $0x801e80
  80004e:	ff 75 f4             	pushl  -0xc(%ebp)
  800051:	e8 95 10 00 00       	call   8010eb <sget>
  800056:	83 c4 10             	add    $0x10,%esp
  800059:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int *useSem = sget(parentenvID, "useSem") ;
  80005c:	83 ec 08             	sub    $0x8,%esp
  80005f:	68 82 1e 80 00       	push   $0x801e82
  800064:	ff 75 f4             	pushl  -0xc(%ebp)
  800067:	e8 7f 10 00 00       	call   8010eb <sget>
  80006c:	83 c4 10             	add    $0x10,%esp
  80006f:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int *finishedCount = sget(parentenvID, "finishedCount") ;
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 89 1e 80 00       	push   $0x801e89
  80007a:	ff 75 f4             	pushl  -0xc(%ebp)
  80007d:	e8 69 10 00 00       	call   8010eb <sget>
  800082:	83 c4 10             	add    $0x10,%esp
  800085:	89 45 e8             	mov    %eax,-0x18(%ebp)

	/*[2] DO THE JOB*/
	int Z ;
	if (*useSem == 1)
  800088:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80008b:	8b 00                	mov    (%eax),%eax
  80008d:	83 f8 01             	cmp    $0x1,%eax
  800090:	75 13                	jne    8000a5 <_main+0x6d>
	{
		sys_waitSemaphore(parentenvID, "T") ;
  800092:	83 ec 08             	sub    $0x8,%esp
  800095:	68 97 1e 80 00       	push   $0x801e97
  80009a:	ff 75 f4             	pushl  -0xc(%ebp)
  80009d:	e8 a2 15 00 00       	call   801644 <sys_waitSemaphore>
  8000a2:	83 c4 10             	add    $0x10,%esp
	}

	//random delay
	delay = RAND(2000, 10000);
  8000a5:	8d 45 c8             	lea    -0x38(%ebp),%eax
  8000a8:	83 ec 0c             	sub    $0xc,%esp
  8000ab:	50                   	push   %eax
  8000ac:	e8 c0 16 00 00       	call   801771 <sys_get_virtual_time>
  8000b1:	83 c4 0c             	add    $0xc,%esp
  8000b4:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8000b7:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  8000bc:	ba 00 00 00 00       	mov    $0x0,%edx
  8000c1:	f7 f1                	div    %ecx
  8000c3:	89 d0                	mov    %edx,%eax
  8000c5:	05 d0 07 00 00       	add    $0x7d0,%eax
  8000ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	env_sleep(delay);
  8000cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	50                   	push   %eax
  8000d4:	e8 9c 18 00 00       	call   801975 <env_sleep>
  8000d9:	83 c4 10             	add    $0x10,%esp
//	cprintf("delay = %d\n", delay);

	Z = (*X) + 1 ;
  8000dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000df:	8b 00                	mov    (%eax),%eax
  8000e1:	40                   	inc    %eax
  8000e2:	89 45 e0             	mov    %eax,-0x20(%ebp)

	//random delay
	delay = RAND(2000, 10000);
  8000e5:	8d 45 d0             	lea    -0x30(%ebp),%eax
  8000e8:	83 ec 0c             	sub    $0xc,%esp
  8000eb:	50                   	push   %eax
  8000ec:	e8 80 16 00 00       	call   801771 <sys_get_virtual_time>
  8000f1:	83 c4 0c             	add    $0xc,%esp
  8000f4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f7:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  8000fc:	ba 00 00 00 00       	mov    $0x0,%edx
  800101:	f7 f1                	div    %ecx
  800103:	89 d0                	mov    %edx,%eax
  800105:	05 d0 07 00 00       	add    $0x7d0,%eax
  80010a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	env_sleep(delay);
  80010d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800110:	83 ec 0c             	sub    $0xc,%esp
  800113:	50                   	push   %eax
  800114:	e8 5c 18 00 00       	call   801975 <env_sleep>
  800119:	83 c4 10             	add    $0x10,%esp
//	cprintf("delay = %d\n", delay);

	(*X) = Z ;
  80011c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80011f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800122:	89 10                	mov    %edx,(%eax)

	//random delay
	delay = RAND(2000, 10000);
  800124:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800127:	83 ec 0c             	sub    $0xc,%esp
  80012a:	50                   	push   %eax
  80012b:	e8 41 16 00 00       	call   801771 <sys_get_virtual_time>
  800130:	83 c4 0c             	add    $0xc,%esp
  800133:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800136:	b9 40 1f 00 00       	mov    $0x1f40,%ecx
  80013b:	ba 00 00 00 00       	mov    $0x0,%edx
  800140:	f7 f1                	div    %ecx
  800142:	89 d0                	mov    %edx,%eax
  800144:	05 d0 07 00 00       	add    $0x7d0,%eax
  800149:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	env_sleep(delay);
  80014c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80014f:	83 ec 0c             	sub    $0xc,%esp
  800152:	50                   	push   %eax
  800153:	e8 1d 18 00 00       	call   801975 <env_sleep>
  800158:	83 c4 10             	add    $0x10,%esp
//	cprintf("delay = %d\n", delay);

	/*[3] DECLARE FINISHING*/
	(*finishedCount)++ ;
  80015b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80015e:	8b 00                	mov    (%eax),%eax
  800160:	8d 50 01             	lea    0x1(%eax),%edx
  800163:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800166:	89 10                	mov    %edx,(%eax)

}
  800168:	90                   	nop
  800169:	c9                   	leave  
  80016a:	c3                   	ret    

0080016b <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80016b:	55                   	push   %ebp
  80016c:	89 e5                	mov    %esp,%ebp
  80016e:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800171:	e8 86 12 00 00       	call   8013fc <sys_getenvindex>
  800176:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800179:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80017c:	89 d0                	mov    %edx,%eax
  80017e:	01 c0                	add    %eax,%eax
  800180:	01 d0                	add    %edx,%eax
  800182:	c1 e0 02             	shl    $0x2,%eax
  800185:	01 d0                	add    %edx,%eax
  800187:	c1 e0 06             	shl    $0x6,%eax
  80018a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80018f:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800194:	a1 20 30 80 00       	mov    0x803020,%eax
  800199:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80019f:	84 c0                	test   %al,%al
  8001a1:	74 0f                	je     8001b2 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8001a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a8:	05 f4 02 00 00       	add    $0x2f4,%eax
  8001ad:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001b2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001b6:	7e 0a                	jle    8001c2 <libmain+0x57>
		binaryname = argv[0];
  8001b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001bb:	8b 00                	mov    (%eax),%eax
  8001bd:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001c2:	83 ec 08             	sub    $0x8,%esp
  8001c5:	ff 75 0c             	pushl  0xc(%ebp)
  8001c8:	ff 75 08             	pushl  0x8(%ebp)
  8001cb:	e8 68 fe ff ff       	call   800038 <_main>
  8001d0:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001d3:	e8 bf 13 00 00       	call   801597 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001d8:	83 ec 0c             	sub    $0xc,%esp
  8001db:	68 b4 1e 80 00       	push   $0x801eb4
  8001e0:	e8 5c 01 00 00       	call   800341 <cprintf>
  8001e5:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ed:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001f3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f8:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001fe:	83 ec 04             	sub    $0x4,%esp
  800201:	52                   	push   %edx
  800202:	50                   	push   %eax
  800203:	68 dc 1e 80 00       	push   $0x801edc
  800208:	e8 34 01 00 00       	call   800341 <cprintf>
  80020d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800210:	a1 20 30 80 00       	mov    0x803020,%eax
  800215:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80021b:	83 ec 08             	sub    $0x8,%esp
  80021e:	50                   	push   %eax
  80021f:	68 01 1f 80 00       	push   $0x801f01
  800224:	e8 18 01 00 00       	call   800341 <cprintf>
  800229:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80022c:	83 ec 0c             	sub    $0xc,%esp
  80022f:	68 b4 1e 80 00       	push   $0x801eb4
  800234:	e8 08 01 00 00       	call   800341 <cprintf>
  800239:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80023c:	e8 70 13 00 00       	call   8015b1 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800241:	e8 19 00 00 00       	call   80025f <exit>
}
  800246:	90                   	nop
  800247:	c9                   	leave  
  800248:	c3                   	ret    

00800249 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800249:	55                   	push   %ebp
  80024a:	89 e5                	mov    %esp,%ebp
  80024c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80024f:	83 ec 0c             	sub    $0xc,%esp
  800252:	6a 00                	push   $0x0
  800254:	e8 6f 11 00 00       	call   8013c8 <sys_env_destroy>
  800259:	83 c4 10             	add    $0x10,%esp
}
  80025c:	90                   	nop
  80025d:	c9                   	leave  
  80025e:	c3                   	ret    

0080025f <exit>:

void
exit(void)
{
  80025f:	55                   	push   %ebp
  800260:	89 e5                	mov    %esp,%ebp
  800262:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800265:	e8 c4 11 00 00       	call   80142e <sys_env_exit>
}
  80026a:	90                   	nop
  80026b:	c9                   	leave  
  80026c:	c3                   	ret    

0080026d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80026d:	55                   	push   %ebp
  80026e:	89 e5                	mov    %esp,%ebp
  800270:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800273:	8b 45 0c             	mov    0xc(%ebp),%eax
  800276:	8b 00                	mov    (%eax),%eax
  800278:	8d 48 01             	lea    0x1(%eax),%ecx
  80027b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80027e:	89 0a                	mov    %ecx,(%edx)
  800280:	8b 55 08             	mov    0x8(%ebp),%edx
  800283:	88 d1                	mov    %dl,%cl
  800285:	8b 55 0c             	mov    0xc(%ebp),%edx
  800288:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80028c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80028f:	8b 00                	mov    (%eax),%eax
  800291:	3d ff 00 00 00       	cmp    $0xff,%eax
  800296:	75 2c                	jne    8002c4 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800298:	a0 24 30 80 00       	mov    0x803024,%al
  80029d:	0f b6 c0             	movzbl %al,%eax
  8002a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002a3:	8b 12                	mov    (%edx),%edx
  8002a5:	89 d1                	mov    %edx,%ecx
  8002a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002aa:	83 c2 08             	add    $0x8,%edx
  8002ad:	83 ec 04             	sub    $0x4,%esp
  8002b0:	50                   	push   %eax
  8002b1:	51                   	push   %ecx
  8002b2:	52                   	push   %edx
  8002b3:	e8 ce 10 00 00       	call   801386 <sys_cputs>
  8002b8:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c7:	8b 40 04             	mov    0x4(%eax),%eax
  8002ca:	8d 50 01             	lea    0x1(%eax),%edx
  8002cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002d0:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002d3:	90                   	nop
  8002d4:	c9                   	leave  
  8002d5:	c3                   	ret    

008002d6 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002d6:	55                   	push   %ebp
  8002d7:	89 e5                	mov    %esp,%ebp
  8002d9:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002df:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002e6:	00 00 00 
	b.cnt = 0;
  8002e9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002f0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002f3:	ff 75 0c             	pushl  0xc(%ebp)
  8002f6:	ff 75 08             	pushl  0x8(%ebp)
  8002f9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002ff:	50                   	push   %eax
  800300:	68 6d 02 80 00       	push   $0x80026d
  800305:	e8 11 02 00 00       	call   80051b <vprintfmt>
  80030a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80030d:	a0 24 30 80 00       	mov    0x803024,%al
  800312:	0f b6 c0             	movzbl %al,%eax
  800315:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80031b:	83 ec 04             	sub    $0x4,%esp
  80031e:	50                   	push   %eax
  80031f:	52                   	push   %edx
  800320:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800326:	83 c0 08             	add    $0x8,%eax
  800329:	50                   	push   %eax
  80032a:	e8 57 10 00 00       	call   801386 <sys_cputs>
  80032f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800332:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800339:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80033f:	c9                   	leave  
  800340:	c3                   	ret    

00800341 <cprintf>:

int cprintf(const char *fmt, ...) {
  800341:	55                   	push   %ebp
  800342:	89 e5                	mov    %esp,%ebp
  800344:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800347:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80034e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800351:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800354:	8b 45 08             	mov    0x8(%ebp),%eax
  800357:	83 ec 08             	sub    $0x8,%esp
  80035a:	ff 75 f4             	pushl  -0xc(%ebp)
  80035d:	50                   	push   %eax
  80035e:	e8 73 ff ff ff       	call   8002d6 <vcprintf>
  800363:	83 c4 10             	add    $0x10,%esp
  800366:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800369:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80036c:	c9                   	leave  
  80036d:	c3                   	ret    

0080036e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80036e:	55                   	push   %ebp
  80036f:	89 e5                	mov    %esp,%ebp
  800371:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800374:	e8 1e 12 00 00       	call   801597 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800379:	8d 45 0c             	lea    0xc(%ebp),%eax
  80037c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80037f:	8b 45 08             	mov    0x8(%ebp),%eax
  800382:	83 ec 08             	sub    $0x8,%esp
  800385:	ff 75 f4             	pushl  -0xc(%ebp)
  800388:	50                   	push   %eax
  800389:	e8 48 ff ff ff       	call   8002d6 <vcprintf>
  80038e:	83 c4 10             	add    $0x10,%esp
  800391:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800394:	e8 18 12 00 00       	call   8015b1 <sys_enable_interrupt>
	return cnt;
  800399:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80039c:	c9                   	leave  
  80039d:	c3                   	ret    

0080039e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80039e:	55                   	push   %ebp
  80039f:	89 e5                	mov    %esp,%ebp
  8003a1:	53                   	push   %ebx
  8003a2:	83 ec 14             	sub    $0x14,%esp
  8003a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8003a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8003ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8003ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003b1:	8b 45 18             	mov    0x18(%ebp),%eax
  8003b4:	ba 00 00 00 00       	mov    $0x0,%edx
  8003b9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003bc:	77 55                	ja     800413 <printnum+0x75>
  8003be:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003c1:	72 05                	jb     8003c8 <printnum+0x2a>
  8003c3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003c6:	77 4b                	ja     800413 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003c8:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003cb:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003ce:	8b 45 18             	mov    0x18(%ebp),%eax
  8003d1:	ba 00 00 00 00       	mov    $0x0,%edx
  8003d6:	52                   	push   %edx
  8003d7:	50                   	push   %eax
  8003d8:	ff 75 f4             	pushl  -0xc(%ebp)
  8003db:	ff 75 f0             	pushl  -0x10(%ebp)
  8003de:	e8 29 18 00 00       	call   801c0c <__udivdi3>
  8003e3:	83 c4 10             	add    $0x10,%esp
  8003e6:	83 ec 04             	sub    $0x4,%esp
  8003e9:	ff 75 20             	pushl  0x20(%ebp)
  8003ec:	53                   	push   %ebx
  8003ed:	ff 75 18             	pushl  0x18(%ebp)
  8003f0:	52                   	push   %edx
  8003f1:	50                   	push   %eax
  8003f2:	ff 75 0c             	pushl  0xc(%ebp)
  8003f5:	ff 75 08             	pushl  0x8(%ebp)
  8003f8:	e8 a1 ff ff ff       	call   80039e <printnum>
  8003fd:	83 c4 20             	add    $0x20,%esp
  800400:	eb 1a                	jmp    80041c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800402:	83 ec 08             	sub    $0x8,%esp
  800405:	ff 75 0c             	pushl  0xc(%ebp)
  800408:	ff 75 20             	pushl  0x20(%ebp)
  80040b:	8b 45 08             	mov    0x8(%ebp),%eax
  80040e:	ff d0                	call   *%eax
  800410:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800413:	ff 4d 1c             	decl   0x1c(%ebp)
  800416:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80041a:	7f e6                	jg     800402 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80041c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80041f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800424:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800427:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80042a:	53                   	push   %ebx
  80042b:	51                   	push   %ecx
  80042c:	52                   	push   %edx
  80042d:	50                   	push   %eax
  80042e:	e8 e9 18 00 00       	call   801d1c <__umoddi3>
  800433:	83 c4 10             	add    $0x10,%esp
  800436:	05 34 21 80 00       	add    $0x802134,%eax
  80043b:	8a 00                	mov    (%eax),%al
  80043d:	0f be c0             	movsbl %al,%eax
  800440:	83 ec 08             	sub    $0x8,%esp
  800443:	ff 75 0c             	pushl  0xc(%ebp)
  800446:	50                   	push   %eax
  800447:	8b 45 08             	mov    0x8(%ebp),%eax
  80044a:	ff d0                	call   *%eax
  80044c:	83 c4 10             	add    $0x10,%esp
}
  80044f:	90                   	nop
  800450:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800453:	c9                   	leave  
  800454:	c3                   	ret    

00800455 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800455:	55                   	push   %ebp
  800456:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800458:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80045c:	7e 1c                	jle    80047a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80045e:	8b 45 08             	mov    0x8(%ebp),%eax
  800461:	8b 00                	mov    (%eax),%eax
  800463:	8d 50 08             	lea    0x8(%eax),%edx
  800466:	8b 45 08             	mov    0x8(%ebp),%eax
  800469:	89 10                	mov    %edx,(%eax)
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	8b 00                	mov    (%eax),%eax
  800470:	83 e8 08             	sub    $0x8,%eax
  800473:	8b 50 04             	mov    0x4(%eax),%edx
  800476:	8b 00                	mov    (%eax),%eax
  800478:	eb 40                	jmp    8004ba <getuint+0x65>
	else if (lflag)
  80047a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80047e:	74 1e                	je     80049e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800480:	8b 45 08             	mov    0x8(%ebp),%eax
  800483:	8b 00                	mov    (%eax),%eax
  800485:	8d 50 04             	lea    0x4(%eax),%edx
  800488:	8b 45 08             	mov    0x8(%ebp),%eax
  80048b:	89 10                	mov    %edx,(%eax)
  80048d:	8b 45 08             	mov    0x8(%ebp),%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	83 e8 04             	sub    $0x4,%eax
  800495:	8b 00                	mov    (%eax),%eax
  800497:	ba 00 00 00 00       	mov    $0x0,%edx
  80049c:	eb 1c                	jmp    8004ba <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80049e:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a1:	8b 00                	mov    (%eax),%eax
  8004a3:	8d 50 04             	lea    0x4(%eax),%edx
  8004a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a9:	89 10                	mov    %edx,(%eax)
  8004ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ae:	8b 00                	mov    (%eax),%eax
  8004b0:	83 e8 04             	sub    $0x4,%eax
  8004b3:	8b 00                	mov    (%eax),%eax
  8004b5:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004ba:	5d                   	pop    %ebp
  8004bb:	c3                   	ret    

008004bc <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004bc:	55                   	push   %ebp
  8004bd:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004bf:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004c3:	7e 1c                	jle    8004e1 <getint+0x25>
		return va_arg(*ap, long long);
  8004c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c8:	8b 00                	mov    (%eax),%eax
  8004ca:	8d 50 08             	lea    0x8(%eax),%edx
  8004cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d0:	89 10                	mov    %edx,(%eax)
  8004d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d5:	8b 00                	mov    (%eax),%eax
  8004d7:	83 e8 08             	sub    $0x8,%eax
  8004da:	8b 50 04             	mov    0x4(%eax),%edx
  8004dd:	8b 00                	mov    (%eax),%eax
  8004df:	eb 38                	jmp    800519 <getint+0x5d>
	else if (lflag)
  8004e1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004e5:	74 1a                	je     800501 <getint+0x45>
		return va_arg(*ap, long);
  8004e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ea:	8b 00                	mov    (%eax),%eax
  8004ec:	8d 50 04             	lea    0x4(%eax),%edx
  8004ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f2:	89 10                	mov    %edx,(%eax)
  8004f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f7:	8b 00                	mov    (%eax),%eax
  8004f9:	83 e8 04             	sub    $0x4,%eax
  8004fc:	8b 00                	mov    (%eax),%eax
  8004fe:	99                   	cltd   
  8004ff:	eb 18                	jmp    800519 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800501:	8b 45 08             	mov    0x8(%ebp),%eax
  800504:	8b 00                	mov    (%eax),%eax
  800506:	8d 50 04             	lea    0x4(%eax),%edx
  800509:	8b 45 08             	mov    0x8(%ebp),%eax
  80050c:	89 10                	mov    %edx,(%eax)
  80050e:	8b 45 08             	mov    0x8(%ebp),%eax
  800511:	8b 00                	mov    (%eax),%eax
  800513:	83 e8 04             	sub    $0x4,%eax
  800516:	8b 00                	mov    (%eax),%eax
  800518:	99                   	cltd   
}
  800519:	5d                   	pop    %ebp
  80051a:	c3                   	ret    

0080051b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80051b:	55                   	push   %ebp
  80051c:	89 e5                	mov    %esp,%ebp
  80051e:	56                   	push   %esi
  80051f:	53                   	push   %ebx
  800520:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800523:	eb 17                	jmp    80053c <vprintfmt+0x21>
			if (ch == '\0')
  800525:	85 db                	test   %ebx,%ebx
  800527:	0f 84 af 03 00 00    	je     8008dc <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80052d:	83 ec 08             	sub    $0x8,%esp
  800530:	ff 75 0c             	pushl  0xc(%ebp)
  800533:	53                   	push   %ebx
  800534:	8b 45 08             	mov    0x8(%ebp),%eax
  800537:	ff d0                	call   *%eax
  800539:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80053c:	8b 45 10             	mov    0x10(%ebp),%eax
  80053f:	8d 50 01             	lea    0x1(%eax),%edx
  800542:	89 55 10             	mov    %edx,0x10(%ebp)
  800545:	8a 00                	mov    (%eax),%al
  800547:	0f b6 d8             	movzbl %al,%ebx
  80054a:	83 fb 25             	cmp    $0x25,%ebx
  80054d:	75 d6                	jne    800525 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80054f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800553:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80055a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800561:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800568:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80056f:	8b 45 10             	mov    0x10(%ebp),%eax
  800572:	8d 50 01             	lea    0x1(%eax),%edx
  800575:	89 55 10             	mov    %edx,0x10(%ebp)
  800578:	8a 00                	mov    (%eax),%al
  80057a:	0f b6 d8             	movzbl %al,%ebx
  80057d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800580:	83 f8 55             	cmp    $0x55,%eax
  800583:	0f 87 2b 03 00 00    	ja     8008b4 <vprintfmt+0x399>
  800589:	8b 04 85 58 21 80 00 	mov    0x802158(,%eax,4),%eax
  800590:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800592:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800596:	eb d7                	jmp    80056f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800598:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80059c:	eb d1                	jmp    80056f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80059e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8005a5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005a8:	89 d0                	mov    %edx,%eax
  8005aa:	c1 e0 02             	shl    $0x2,%eax
  8005ad:	01 d0                	add    %edx,%eax
  8005af:	01 c0                	add    %eax,%eax
  8005b1:	01 d8                	add    %ebx,%eax
  8005b3:	83 e8 30             	sub    $0x30,%eax
  8005b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8005bc:	8a 00                	mov    (%eax),%al
  8005be:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8005c1:	83 fb 2f             	cmp    $0x2f,%ebx
  8005c4:	7e 3e                	jle    800604 <vprintfmt+0xe9>
  8005c6:	83 fb 39             	cmp    $0x39,%ebx
  8005c9:	7f 39                	jg     800604 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005cb:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005ce:	eb d5                	jmp    8005a5 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d3:	83 c0 04             	add    $0x4,%eax
  8005d6:	89 45 14             	mov    %eax,0x14(%ebp)
  8005d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005dc:	83 e8 04             	sub    $0x4,%eax
  8005df:	8b 00                	mov    (%eax),%eax
  8005e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005e4:	eb 1f                	jmp    800605 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005e6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005ea:	79 83                	jns    80056f <vprintfmt+0x54>
				width = 0;
  8005ec:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005f3:	e9 77 ff ff ff       	jmp    80056f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005f8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005ff:	e9 6b ff ff ff       	jmp    80056f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800604:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800605:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800609:	0f 89 60 ff ff ff    	jns    80056f <vprintfmt+0x54>
				width = precision, precision = -1;
  80060f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800612:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800615:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80061c:	e9 4e ff ff ff       	jmp    80056f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800621:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800624:	e9 46 ff ff ff       	jmp    80056f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800629:	8b 45 14             	mov    0x14(%ebp),%eax
  80062c:	83 c0 04             	add    $0x4,%eax
  80062f:	89 45 14             	mov    %eax,0x14(%ebp)
  800632:	8b 45 14             	mov    0x14(%ebp),%eax
  800635:	83 e8 04             	sub    $0x4,%eax
  800638:	8b 00                	mov    (%eax),%eax
  80063a:	83 ec 08             	sub    $0x8,%esp
  80063d:	ff 75 0c             	pushl  0xc(%ebp)
  800640:	50                   	push   %eax
  800641:	8b 45 08             	mov    0x8(%ebp),%eax
  800644:	ff d0                	call   *%eax
  800646:	83 c4 10             	add    $0x10,%esp
			break;
  800649:	e9 89 02 00 00       	jmp    8008d7 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80064e:	8b 45 14             	mov    0x14(%ebp),%eax
  800651:	83 c0 04             	add    $0x4,%eax
  800654:	89 45 14             	mov    %eax,0x14(%ebp)
  800657:	8b 45 14             	mov    0x14(%ebp),%eax
  80065a:	83 e8 04             	sub    $0x4,%eax
  80065d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80065f:	85 db                	test   %ebx,%ebx
  800661:	79 02                	jns    800665 <vprintfmt+0x14a>
				err = -err;
  800663:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800665:	83 fb 64             	cmp    $0x64,%ebx
  800668:	7f 0b                	jg     800675 <vprintfmt+0x15a>
  80066a:	8b 34 9d a0 1f 80 00 	mov    0x801fa0(,%ebx,4),%esi
  800671:	85 f6                	test   %esi,%esi
  800673:	75 19                	jne    80068e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800675:	53                   	push   %ebx
  800676:	68 45 21 80 00       	push   $0x802145
  80067b:	ff 75 0c             	pushl  0xc(%ebp)
  80067e:	ff 75 08             	pushl  0x8(%ebp)
  800681:	e8 5e 02 00 00       	call   8008e4 <printfmt>
  800686:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800689:	e9 49 02 00 00       	jmp    8008d7 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80068e:	56                   	push   %esi
  80068f:	68 4e 21 80 00       	push   $0x80214e
  800694:	ff 75 0c             	pushl  0xc(%ebp)
  800697:	ff 75 08             	pushl  0x8(%ebp)
  80069a:	e8 45 02 00 00       	call   8008e4 <printfmt>
  80069f:	83 c4 10             	add    $0x10,%esp
			break;
  8006a2:	e9 30 02 00 00       	jmp    8008d7 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8006a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8006aa:	83 c0 04             	add    $0x4,%eax
  8006ad:	89 45 14             	mov    %eax,0x14(%ebp)
  8006b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8006b3:	83 e8 04             	sub    $0x4,%eax
  8006b6:	8b 30                	mov    (%eax),%esi
  8006b8:	85 f6                	test   %esi,%esi
  8006ba:	75 05                	jne    8006c1 <vprintfmt+0x1a6>
				p = "(null)";
  8006bc:	be 51 21 80 00       	mov    $0x802151,%esi
			if (width > 0 && padc != '-')
  8006c1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006c5:	7e 6d                	jle    800734 <vprintfmt+0x219>
  8006c7:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006cb:	74 67                	je     800734 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006d0:	83 ec 08             	sub    $0x8,%esp
  8006d3:	50                   	push   %eax
  8006d4:	56                   	push   %esi
  8006d5:	e8 0c 03 00 00       	call   8009e6 <strnlen>
  8006da:	83 c4 10             	add    $0x10,%esp
  8006dd:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006e0:	eb 16                	jmp    8006f8 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006e2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006e6:	83 ec 08             	sub    $0x8,%esp
  8006e9:	ff 75 0c             	pushl  0xc(%ebp)
  8006ec:	50                   	push   %eax
  8006ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f0:	ff d0                	call   *%eax
  8006f2:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006f5:	ff 4d e4             	decl   -0x1c(%ebp)
  8006f8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006fc:	7f e4                	jg     8006e2 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006fe:	eb 34                	jmp    800734 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800700:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800704:	74 1c                	je     800722 <vprintfmt+0x207>
  800706:	83 fb 1f             	cmp    $0x1f,%ebx
  800709:	7e 05                	jle    800710 <vprintfmt+0x1f5>
  80070b:	83 fb 7e             	cmp    $0x7e,%ebx
  80070e:	7e 12                	jle    800722 <vprintfmt+0x207>
					putch('?', putdat);
  800710:	83 ec 08             	sub    $0x8,%esp
  800713:	ff 75 0c             	pushl  0xc(%ebp)
  800716:	6a 3f                	push   $0x3f
  800718:	8b 45 08             	mov    0x8(%ebp),%eax
  80071b:	ff d0                	call   *%eax
  80071d:	83 c4 10             	add    $0x10,%esp
  800720:	eb 0f                	jmp    800731 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800722:	83 ec 08             	sub    $0x8,%esp
  800725:	ff 75 0c             	pushl  0xc(%ebp)
  800728:	53                   	push   %ebx
  800729:	8b 45 08             	mov    0x8(%ebp),%eax
  80072c:	ff d0                	call   *%eax
  80072e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800731:	ff 4d e4             	decl   -0x1c(%ebp)
  800734:	89 f0                	mov    %esi,%eax
  800736:	8d 70 01             	lea    0x1(%eax),%esi
  800739:	8a 00                	mov    (%eax),%al
  80073b:	0f be d8             	movsbl %al,%ebx
  80073e:	85 db                	test   %ebx,%ebx
  800740:	74 24                	je     800766 <vprintfmt+0x24b>
  800742:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800746:	78 b8                	js     800700 <vprintfmt+0x1e5>
  800748:	ff 4d e0             	decl   -0x20(%ebp)
  80074b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80074f:	79 af                	jns    800700 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800751:	eb 13                	jmp    800766 <vprintfmt+0x24b>
				putch(' ', putdat);
  800753:	83 ec 08             	sub    $0x8,%esp
  800756:	ff 75 0c             	pushl  0xc(%ebp)
  800759:	6a 20                	push   $0x20
  80075b:	8b 45 08             	mov    0x8(%ebp),%eax
  80075e:	ff d0                	call   *%eax
  800760:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800763:	ff 4d e4             	decl   -0x1c(%ebp)
  800766:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80076a:	7f e7                	jg     800753 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80076c:	e9 66 01 00 00       	jmp    8008d7 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800771:	83 ec 08             	sub    $0x8,%esp
  800774:	ff 75 e8             	pushl  -0x18(%ebp)
  800777:	8d 45 14             	lea    0x14(%ebp),%eax
  80077a:	50                   	push   %eax
  80077b:	e8 3c fd ff ff       	call   8004bc <getint>
  800780:	83 c4 10             	add    $0x10,%esp
  800783:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800786:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800789:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80078c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80078f:	85 d2                	test   %edx,%edx
  800791:	79 23                	jns    8007b6 <vprintfmt+0x29b>
				putch('-', putdat);
  800793:	83 ec 08             	sub    $0x8,%esp
  800796:	ff 75 0c             	pushl  0xc(%ebp)
  800799:	6a 2d                	push   $0x2d
  80079b:	8b 45 08             	mov    0x8(%ebp),%eax
  80079e:	ff d0                	call   *%eax
  8007a0:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8007a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007a9:	f7 d8                	neg    %eax
  8007ab:	83 d2 00             	adc    $0x0,%edx
  8007ae:	f7 da                	neg    %edx
  8007b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007b6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007bd:	e9 bc 00 00 00       	jmp    80087e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8007c2:	83 ec 08             	sub    $0x8,%esp
  8007c5:	ff 75 e8             	pushl  -0x18(%ebp)
  8007c8:	8d 45 14             	lea    0x14(%ebp),%eax
  8007cb:	50                   	push   %eax
  8007cc:	e8 84 fc ff ff       	call   800455 <getuint>
  8007d1:	83 c4 10             	add    $0x10,%esp
  8007d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007da:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007e1:	e9 98 00 00 00       	jmp    80087e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007e6:	83 ec 08             	sub    $0x8,%esp
  8007e9:	ff 75 0c             	pushl  0xc(%ebp)
  8007ec:	6a 58                	push   $0x58
  8007ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f1:	ff d0                	call   *%eax
  8007f3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007f6:	83 ec 08             	sub    $0x8,%esp
  8007f9:	ff 75 0c             	pushl  0xc(%ebp)
  8007fc:	6a 58                	push   $0x58
  8007fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800801:	ff d0                	call   *%eax
  800803:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800806:	83 ec 08             	sub    $0x8,%esp
  800809:	ff 75 0c             	pushl  0xc(%ebp)
  80080c:	6a 58                	push   $0x58
  80080e:	8b 45 08             	mov    0x8(%ebp),%eax
  800811:	ff d0                	call   *%eax
  800813:	83 c4 10             	add    $0x10,%esp
			break;
  800816:	e9 bc 00 00 00       	jmp    8008d7 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80081b:	83 ec 08             	sub    $0x8,%esp
  80081e:	ff 75 0c             	pushl  0xc(%ebp)
  800821:	6a 30                	push   $0x30
  800823:	8b 45 08             	mov    0x8(%ebp),%eax
  800826:	ff d0                	call   *%eax
  800828:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80082b:	83 ec 08             	sub    $0x8,%esp
  80082e:	ff 75 0c             	pushl  0xc(%ebp)
  800831:	6a 78                	push   $0x78
  800833:	8b 45 08             	mov    0x8(%ebp),%eax
  800836:	ff d0                	call   *%eax
  800838:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80083b:	8b 45 14             	mov    0x14(%ebp),%eax
  80083e:	83 c0 04             	add    $0x4,%eax
  800841:	89 45 14             	mov    %eax,0x14(%ebp)
  800844:	8b 45 14             	mov    0x14(%ebp),%eax
  800847:	83 e8 04             	sub    $0x4,%eax
  80084a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80084c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80084f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800856:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80085d:	eb 1f                	jmp    80087e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80085f:	83 ec 08             	sub    $0x8,%esp
  800862:	ff 75 e8             	pushl  -0x18(%ebp)
  800865:	8d 45 14             	lea    0x14(%ebp),%eax
  800868:	50                   	push   %eax
  800869:	e8 e7 fb ff ff       	call   800455 <getuint>
  80086e:	83 c4 10             	add    $0x10,%esp
  800871:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800874:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800877:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80087e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800882:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800885:	83 ec 04             	sub    $0x4,%esp
  800888:	52                   	push   %edx
  800889:	ff 75 e4             	pushl  -0x1c(%ebp)
  80088c:	50                   	push   %eax
  80088d:	ff 75 f4             	pushl  -0xc(%ebp)
  800890:	ff 75 f0             	pushl  -0x10(%ebp)
  800893:	ff 75 0c             	pushl  0xc(%ebp)
  800896:	ff 75 08             	pushl  0x8(%ebp)
  800899:	e8 00 fb ff ff       	call   80039e <printnum>
  80089e:	83 c4 20             	add    $0x20,%esp
			break;
  8008a1:	eb 34                	jmp    8008d7 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8008a3:	83 ec 08             	sub    $0x8,%esp
  8008a6:	ff 75 0c             	pushl  0xc(%ebp)
  8008a9:	53                   	push   %ebx
  8008aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ad:	ff d0                	call   *%eax
  8008af:	83 c4 10             	add    $0x10,%esp
			break;
  8008b2:	eb 23                	jmp    8008d7 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008b4:	83 ec 08             	sub    $0x8,%esp
  8008b7:	ff 75 0c             	pushl  0xc(%ebp)
  8008ba:	6a 25                	push   $0x25
  8008bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bf:	ff d0                	call   *%eax
  8008c1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008c4:	ff 4d 10             	decl   0x10(%ebp)
  8008c7:	eb 03                	jmp    8008cc <vprintfmt+0x3b1>
  8008c9:	ff 4d 10             	decl   0x10(%ebp)
  8008cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8008cf:	48                   	dec    %eax
  8008d0:	8a 00                	mov    (%eax),%al
  8008d2:	3c 25                	cmp    $0x25,%al
  8008d4:	75 f3                	jne    8008c9 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008d6:	90                   	nop
		}
	}
  8008d7:	e9 47 fc ff ff       	jmp    800523 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008dc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008e0:	5b                   	pop    %ebx
  8008e1:	5e                   	pop    %esi
  8008e2:	5d                   	pop    %ebp
  8008e3:	c3                   	ret    

008008e4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008e4:	55                   	push   %ebp
  8008e5:	89 e5                	mov    %esp,%ebp
  8008e7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008ea:	8d 45 10             	lea    0x10(%ebp),%eax
  8008ed:	83 c0 04             	add    $0x4,%eax
  8008f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8008f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8008f9:	50                   	push   %eax
  8008fa:	ff 75 0c             	pushl  0xc(%ebp)
  8008fd:	ff 75 08             	pushl  0x8(%ebp)
  800900:	e8 16 fc ff ff       	call   80051b <vprintfmt>
  800905:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800908:	90                   	nop
  800909:	c9                   	leave  
  80090a:	c3                   	ret    

0080090b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80090b:	55                   	push   %ebp
  80090c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80090e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800911:	8b 40 08             	mov    0x8(%eax),%eax
  800914:	8d 50 01             	lea    0x1(%eax),%edx
  800917:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80091d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800920:	8b 10                	mov    (%eax),%edx
  800922:	8b 45 0c             	mov    0xc(%ebp),%eax
  800925:	8b 40 04             	mov    0x4(%eax),%eax
  800928:	39 c2                	cmp    %eax,%edx
  80092a:	73 12                	jae    80093e <sprintputch+0x33>
		*b->buf++ = ch;
  80092c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092f:	8b 00                	mov    (%eax),%eax
  800931:	8d 48 01             	lea    0x1(%eax),%ecx
  800934:	8b 55 0c             	mov    0xc(%ebp),%edx
  800937:	89 0a                	mov    %ecx,(%edx)
  800939:	8b 55 08             	mov    0x8(%ebp),%edx
  80093c:	88 10                	mov    %dl,(%eax)
}
  80093e:	90                   	nop
  80093f:	5d                   	pop    %ebp
  800940:	c3                   	ret    

00800941 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800941:	55                   	push   %ebp
  800942:	89 e5                	mov    %esp,%ebp
  800944:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800947:	8b 45 08             	mov    0x8(%ebp),%eax
  80094a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80094d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800950:	8d 50 ff             	lea    -0x1(%eax),%edx
  800953:	8b 45 08             	mov    0x8(%ebp),%eax
  800956:	01 d0                	add    %edx,%eax
  800958:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80095b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800962:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800966:	74 06                	je     80096e <vsnprintf+0x2d>
  800968:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80096c:	7f 07                	jg     800975 <vsnprintf+0x34>
		return -E_INVAL;
  80096e:	b8 03 00 00 00       	mov    $0x3,%eax
  800973:	eb 20                	jmp    800995 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800975:	ff 75 14             	pushl  0x14(%ebp)
  800978:	ff 75 10             	pushl  0x10(%ebp)
  80097b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80097e:	50                   	push   %eax
  80097f:	68 0b 09 80 00       	push   $0x80090b
  800984:	e8 92 fb ff ff       	call   80051b <vprintfmt>
  800989:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80098c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80098f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800992:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800995:	c9                   	leave  
  800996:	c3                   	ret    

00800997 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800997:	55                   	push   %ebp
  800998:	89 e5                	mov    %esp,%ebp
  80099a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80099d:	8d 45 10             	lea    0x10(%ebp),%eax
  8009a0:	83 c0 04             	add    $0x4,%eax
  8009a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8009a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8009a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ac:	50                   	push   %eax
  8009ad:	ff 75 0c             	pushl  0xc(%ebp)
  8009b0:	ff 75 08             	pushl  0x8(%ebp)
  8009b3:	e8 89 ff ff ff       	call   800941 <vsnprintf>
  8009b8:	83 c4 10             	add    $0x10,%esp
  8009bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009be:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009c1:	c9                   	leave  
  8009c2:	c3                   	ret    

008009c3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8009c3:	55                   	push   %ebp
  8009c4:	89 e5                	mov    %esp,%ebp
  8009c6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009d0:	eb 06                	jmp    8009d8 <strlen+0x15>
		n++;
  8009d2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009d5:	ff 45 08             	incl   0x8(%ebp)
  8009d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009db:	8a 00                	mov    (%eax),%al
  8009dd:	84 c0                	test   %al,%al
  8009df:	75 f1                	jne    8009d2 <strlen+0xf>
		n++;
	return n;
  8009e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009e4:	c9                   	leave  
  8009e5:	c3                   	ret    

008009e6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009e6:	55                   	push   %ebp
  8009e7:	89 e5                	mov    %esp,%ebp
  8009e9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009f3:	eb 09                	jmp    8009fe <strnlen+0x18>
		n++;
  8009f5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009f8:	ff 45 08             	incl   0x8(%ebp)
  8009fb:	ff 4d 0c             	decl   0xc(%ebp)
  8009fe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a02:	74 09                	je     800a0d <strnlen+0x27>
  800a04:	8b 45 08             	mov    0x8(%ebp),%eax
  800a07:	8a 00                	mov    (%eax),%al
  800a09:	84 c0                	test   %al,%al
  800a0b:	75 e8                	jne    8009f5 <strnlen+0xf>
		n++;
	return n;
  800a0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a10:	c9                   	leave  
  800a11:	c3                   	ret    

00800a12 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a12:	55                   	push   %ebp
  800a13:	89 e5                	mov    %esp,%ebp
  800a15:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a18:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a1e:	90                   	nop
  800a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a22:	8d 50 01             	lea    0x1(%eax),%edx
  800a25:	89 55 08             	mov    %edx,0x8(%ebp)
  800a28:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a2b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a2e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a31:	8a 12                	mov    (%edx),%dl
  800a33:	88 10                	mov    %dl,(%eax)
  800a35:	8a 00                	mov    (%eax),%al
  800a37:	84 c0                	test   %al,%al
  800a39:	75 e4                	jne    800a1f <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a3e:	c9                   	leave  
  800a3f:	c3                   	ret    

00800a40 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a40:	55                   	push   %ebp
  800a41:	89 e5                	mov    %esp,%ebp
  800a43:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a46:	8b 45 08             	mov    0x8(%ebp),%eax
  800a49:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a4c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a53:	eb 1f                	jmp    800a74 <strncpy+0x34>
		*dst++ = *src;
  800a55:	8b 45 08             	mov    0x8(%ebp),%eax
  800a58:	8d 50 01             	lea    0x1(%eax),%edx
  800a5b:	89 55 08             	mov    %edx,0x8(%ebp)
  800a5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a61:	8a 12                	mov    (%edx),%dl
  800a63:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a68:	8a 00                	mov    (%eax),%al
  800a6a:	84 c0                	test   %al,%al
  800a6c:	74 03                	je     800a71 <strncpy+0x31>
			src++;
  800a6e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a71:	ff 45 fc             	incl   -0x4(%ebp)
  800a74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a77:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a7a:	72 d9                	jb     800a55 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a7f:	c9                   	leave  
  800a80:	c3                   	ret    

00800a81 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a81:	55                   	push   %ebp
  800a82:	89 e5                	mov    %esp,%ebp
  800a84:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a87:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a8d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a91:	74 30                	je     800ac3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a93:	eb 16                	jmp    800aab <strlcpy+0x2a>
			*dst++ = *src++;
  800a95:	8b 45 08             	mov    0x8(%ebp),%eax
  800a98:	8d 50 01             	lea    0x1(%eax),%edx
  800a9b:	89 55 08             	mov    %edx,0x8(%ebp)
  800a9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aa1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800aa4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800aa7:	8a 12                	mov    (%edx),%dl
  800aa9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800aab:	ff 4d 10             	decl   0x10(%ebp)
  800aae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ab2:	74 09                	je     800abd <strlcpy+0x3c>
  800ab4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab7:	8a 00                	mov    (%eax),%al
  800ab9:	84 c0                	test   %al,%al
  800abb:	75 d8                	jne    800a95 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800abd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ac3:	8b 55 08             	mov    0x8(%ebp),%edx
  800ac6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ac9:	29 c2                	sub    %eax,%edx
  800acb:	89 d0                	mov    %edx,%eax
}
  800acd:	c9                   	leave  
  800ace:	c3                   	ret    

00800acf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800acf:	55                   	push   %ebp
  800ad0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ad2:	eb 06                	jmp    800ada <strcmp+0xb>
		p++, q++;
  800ad4:	ff 45 08             	incl   0x8(%ebp)
  800ad7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	8a 00                	mov    (%eax),%al
  800adf:	84 c0                	test   %al,%al
  800ae1:	74 0e                	je     800af1 <strcmp+0x22>
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	8a 10                	mov    (%eax),%dl
  800ae8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aeb:	8a 00                	mov    (%eax),%al
  800aed:	38 c2                	cmp    %al,%dl
  800aef:	74 e3                	je     800ad4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	8a 00                	mov    (%eax),%al
  800af6:	0f b6 d0             	movzbl %al,%edx
  800af9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afc:	8a 00                	mov    (%eax),%al
  800afe:	0f b6 c0             	movzbl %al,%eax
  800b01:	29 c2                	sub    %eax,%edx
  800b03:	89 d0                	mov    %edx,%eax
}
  800b05:	5d                   	pop    %ebp
  800b06:	c3                   	ret    

00800b07 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800b07:	55                   	push   %ebp
  800b08:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800b0a:	eb 09                	jmp    800b15 <strncmp+0xe>
		n--, p++, q++;
  800b0c:	ff 4d 10             	decl   0x10(%ebp)
  800b0f:	ff 45 08             	incl   0x8(%ebp)
  800b12:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b19:	74 17                	je     800b32 <strncmp+0x2b>
  800b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1e:	8a 00                	mov    (%eax),%al
  800b20:	84 c0                	test   %al,%al
  800b22:	74 0e                	je     800b32 <strncmp+0x2b>
  800b24:	8b 45 08             	mov    0x8(%ebp),%eax
  800b27:	8a 10                	mov    (%eax),%dl
  800b29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2c:	8a 00                	mov    (%eax),%al
  800b2e:	38 c2                	cmp    %al,%dl
  800b30:	74 da                	je     800b0c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b32:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b36:	75 07                	jne    800b3f <strncmp+0x38>
		return 0;
  800b38:	b8 00 00 00 00       	mov    $0x0,%eax
  800b3d:	eb 14                	jmp    800b53 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	8a 00                	mov    (%eax),%al
  800b44:	0f b6 d0             	movzbl %al,%edx
  800b47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4a:	8a 00                	mov    (%eax),%al
  800b4c:	0f b6 c0             	movzbl %al,%eax
  800b4f:	29 c2                	sub    %eax,%edx
  800b51:	89 d0                	mov    %edx,%eax
}
  800b53:	5d                   	pop    %ebp
  800b54:	c3                   	ret    

00800b55 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b55:	55                   	push   %ebp
  800b56:	89 e5                	mov    %esp,%ebp
  800b58:	83 ec 04             	sub    $0x4,%esp
  800b5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b61:	eb 12                	jmp    800b75 <strchr+0x20>
		if (*s == c)
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	8a 00                	mov    (%eax),%al
  800b68:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b6b:	75 05                	jne    800b72 <strchr+0x1d>
			return (char *) s;
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	eb 11                	jmp    800b83 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b72:	ff 45 08             	incl   0x8(%ebp)
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	8a 00                	mov    (%eax),%al
  800b7a:	84 c0                	test   %al,%al
  800b7c:	75 e5                	jne    800b63 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b83:	c9                   	leave  
  800b84:	c3                   	ret    

00800b85 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b85:	55                   	push   %ebp
  800b86:	89 e5                	mov    %esp,%ebp
  800b88:	83 ec 04             	sub    $0x4,%esp
  800b8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b91:	eb 0d                	jmp    800ba0 <strfind+0x1b>
		if (*s == c)
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	8a 00                	mov    (%eax),%al
  800b98:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b9b:	74 0e                	je     800bab <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b9d:	ff 45 08             	incl   0x8(%ebp)
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	8a 00                	mov    (%eax),%al
  800ba5:	84 c0                	test   %al,%al
  800ba7:	75 ea                	jne    800b93 <strfind+0xe>
  800ba9:	eb 01                	jmp    800bac <strfind+0x27>
		if (*s == c)
			break;
  800bab:	90                   	nop
	return (char *) s;
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800baf:	c9                   	leave  
  800bb0:	c3                   	ret    

00800bb1 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800bb1:	55                   	push   %ebp
  800bb2:	89 e5                	mov    %esp,%ebp
  800bb4:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800bbd:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800bc3:	eb 0e                	jmp    800bd3 <memset+0x22>
		*p++ = c;
  800bc5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc8:	8d 50 01             	lea    0x1(%eax),%edx
  800bcb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800bce:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bd1:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800bd3:	ff 4d f8             	decl   -0x8(%ebp)
  800bd6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bda:	79 e9                	jns    800bc5 <memset+0x14>
		*p++ = c;

	return v;
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bdf:	c9                   	leave  
  800be0:	c3                   	ret    

00800be1 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800be1:	55                   	push   %ebp
  800be2:	89 e5                	mov    %esp,%ebp
  800be4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800be7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bed:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800bf3:	eb 16                	jmp    800c0b <memcpy+0x2a>
		*d++ = *s++;
  800bf5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf8:	8d 50 01             	lea    0x1(%eax),%edx
  800bfb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bfe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c01:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c04:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c07:	8a 12                	mov    (%edx),%dl
  800c09:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800c0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c0e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c11:	89 55 10             	mov    %edx,0x10(%ebp)
  800c14:	85 c0                	test   %eax,%eax
  800c16:	75 dd                	jne    800bf5 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c18:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c1b:	c9                   	leave  
  800c1c:	c3                   	ret    

00800c1d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c1d:	55                   	push   %ebp
  800c1e:	89 e5                	mov    %esp,%ebp
  800c20:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800c23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c26:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c29:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c32:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c35:	73 50                	jae    800c87 <memmove+0x6a>
  800c37:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c3a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3d:	01 d0                	add    %edx,%eax
  800c3f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c42:	76 43                	jbe    800c87 <memmove+0x6a>
		s += n;
  800c44:	8b 45 10             	mov    0x10(%ebp),%eax
  800c47:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c4a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c50:	eb 10                	jmp    800c62 <memmove+0x45>
			*--d = *--s;
  800c52:	ff 4d f8             	decl   -0x8(%ebp)
  800c55:	ff 4d fc             	decl   -0x4(%ebp)
  800c58:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c5b:	8a 10                	mov    (%eax),%dl
  800c5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c60:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c62:	8b 45 10             	mov    0x10(%ebp),%eax
  800c65:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c68:	89 55 10             	mov    %edx,0x10(%ebp)
  800c6b:	85 c0                	test   %eax,%eax
  800c6d:	75 e3                	jne    800c52 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c6f:	eb 23                	jmp    800c94 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c74:	8d 50 01             	lea    0x1(%eax),%edx
  800c77:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c7a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c7d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c80:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c83:	8a 12                	mov    (%edx),%dl
  800c85:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c87:	8b 45 10             	mov    0x10(%ebp),%eax
  800c8a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c8d:	89 55 10             	mov    %edx,0x10(%ebp)
  800c90:	85 c0                	test   %eax,%eax
  800c92:	75 dd                	jne    800c71 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c94:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c97:	c9                   	leave  
  800c98:	c3                   	ret    

00800c99 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c99:	55                   	push   %ebp
  800c9a:	89 e5                	mov    %esp,%ebp
  800c9c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ca5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca8:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800cab:	eb 2a                	jmp    800cd7 <memcmp+0x3e>
		if (*s1 != *s2)
  800cad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb0:	8a 10                	mov    (%eax),%dl
  800cb2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cb5:	8a 00                	mov    (%eax),%al
  800cb7:	38 c2                	cmp    %al,%dl
  800cb9:	74 16                	je     800cd1 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800cbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cbe:	8a 00                	mov    (%eax),%al
  800cc0:	0f b6 d0             	movzbl %al,%edx
  800cc3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cc6:	8a 00                	mov    (%eax),%al
  800cc8:	0f b6 c0             	movzbl %al,%eax
  800ccb:	29 c2                	sub    %eax,%edx
  800ccd:	89 d0                	mov    %edx,%eax
  800ccf:	eb 18                	jmp    800ce9 <memcmp+0x50>
		s1++, s2++;
  800cd1:	ff 45 fc             	incl   -0x4(%ebp)
  800cd4:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800cd7:	8b 45 10             	mov    0x10(%ebp),%eax
  800cda:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cdd:	89 55 10             	mov    %edx,0x10(%ebp)
  800ce0:	85 c0                	test   %eax,%eax
  800ce2:	75 c9                	jne    800cad <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ce4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ce9:	c9                   	leave  
  800cea:	c3                   	ret    

00800ceb <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ceb:	55                   	push   %ebp
  800cec:	89 e5                	mov    %esp,%ebp
  800cee:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800cf1:	8b 55 08             	mov    0x8(%ebp),%edx
  800cf4:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf7:	01 d0                	add    %edx,%eax
  800cf9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800cfc:	eb 15                	jmp    800d13 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	8a 00                	mov    (%eax),%al
  800d03:	0f b6 d0             	movzbl %al,%edx
  800d06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d09:	0f b6 c0             	movzbl %al,%eax
  800d0c:	39 c2                	cmp    %eax,%edx
  800d0e:	74 0d                	je     800d1d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d10:	ff 45 08             	incl   0x8(%ebp)
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d19:	72 e3                	jb     800cfe <memfind+0x13>
  800d1b:	eb 01                	jmp    800d1e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d1d:	90                   	nop
	return (void *) s;
  800d1e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d21:	c9                   	leave  
  800d22:	c3                   	ret    

00800d23 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d23:	55                   	push   %ebp
  800d24:	89 e5                	mov    %esp,%ebp
  800d26:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d29:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d30:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d37:	eb 03                	jmp    800d3c <strtol+0x19>
		s++;
  800d39:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	8a 00                	mov    (%eax),%al
  800d41:	3c 20                	cmp    $0x20,%al
  800d43:	74 f4                	je     800d39 <strtol+0x16>
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	8a 00                	mov    (%eax),%al
  800d4a:	3c 09                	cmp    $0x9,%al
  800d4c:	74 eb                	je     800d39 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d51:	8a 00                	mov    (%eax),%al
  800d53:	3c 2b                	cmp    $0x2b,%al
  800d55:	75 05                	jne    800d5c <strtol+0x39>
		s++;
  800d57:	ff 45 08             	incl   0x8(%ebp)
  800d5a:	eb 13                	jmp    800d6f <strtol+0x4c>
	else if (*s == '-')
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	8a 00                	mov    (%eax),%al
  800d61:	3c 2d                	cmp    $0x2d,%al
  800d63:	75 0a                	jne    800d6f <strtol+0x4c>
		s++, neg = 1;
  800d65:	ff 45 08             	incl   0x8(%ebp)
  800d68:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d6f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d73:	74 06                	je     800d7b <strtol+0x58>
  800d75:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d79:	75 20                	jne    800d9b <strtol+0x78>
  800d7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7e:	8a 00                	mov    (%eax),%al
  800d80:	3c 30                	cmp    $0x30,%al
  800d82:	75 17                	jne    800d9b <strtol+0x78>
  800d84:	8b 45 08             	mov    0x8(%ebp),%eax
  800d87:	40                   	inc    %eax
  800d88:	8a 00                	mov    (%eax),%al
  800d8a:	3c 78                	cmp    $0x78,%al
  800d8c:	75 0d                	jne    800d9b <strtol+0x78>
		s += 2, base = 16;
  800d8e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d92:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d99:	eb 28                	jmp    800dc3 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d9b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d9f:	75 15                	jne    800db6 <strtol+0x93>
  800da1:	8b 45 08             	mov    0x8(%ebp),%eax
  800da4:	8a 00                	mov    (%eax),%al
  800da6:	3c 30                	cmp    $0x30,%al
  800da8:	75 0c                	jne    800db6 <strtol+0x93>
		s++, base = 8;
  800daa:	ff 45 08             	incl   0x8(%ebp)
  800dad:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800db4:	eb 0d                	jmp    800dc3 <strtol+0xa0>
	else if (base == 0)
  800db6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dba:	75 07                	jne    800dc3 <strtol+0xa0>
		base = 10;
  800dbc:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800dc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc6:	8a 00                	mov    (%eax),%al
  800dc8:	3c 2f                	cmp    $0x2f,%al
  800dca:	7e 19                	jle    800de5 <strtol+0xc2>
  800dcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcf:	8a 00                	mov    (%eax),%al
  800dd1:	3c 39                	cmp    $0x39,%al
  800dd3:	7f 10                	jg     800de5 <strtol+0xc2>
			dig = *s - '0';
  800dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd8:	8a 00                	mov    (%eax),%al
  800dda:	0f be c0             	movsbl %al,%eax
  800ddd:	83 e8 30             	sub    $0x30,%eax
  800de0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800de3:	eb 42                	jmp    800e27 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	8a 00                	mov    (%eax),%al
  800dea:	3c 60                	cmp    $0x60,%al
  800dec:	7e 19                	jle    800e07 <strtol+0xe4>
  800dee:	8b 45 08             	mov    0x8(%ebp),%eax
  800df1:	8a 00                	mov    (%eax),%al
  800df3:	3c 7a                	cmp    $0x7a,%al
  800df5:	7f 10                	jg     800e07 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800df7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfa:	8a 00                	mov    (%eax),%al
  800dfc:	0f be c0             	movsbl %al,%eax
  800dff:	83 e8 57             	sub    $0x57,%eax
  800e02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e05:	eb 20                	jmp    800e27 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0a:	8a 00                	mov    (%eax),%al
  800e0c:	3c 40                	cmp    $0x40,%al
  800e0e:	7e 39                	jle    800e49 <strtol+0x126>
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
  800e13:	8a 00                	mov    (%eax),%al
  800e15:	3c 5a                	cmp    $0x5a,%al
  800e17:	7f 30                	jg     800e49 <strtol+0x126>
			dig = *s - 'A' + 10;
  800e19:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1c:	8a 00                	mov    (%eax),%al
  800e1e:	0f be c0             	movsbl %al,%eax
  800e21:	83 e8 37             	sub    $0x37,%eax
  800e24:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e27:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e2a:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e2d:	7d 19                	jge    800e48 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e2f:	ff 45 08             	incl   0x8(%ebp)
  800e32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e35:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e39:	89 c2                	mov    %eax,%edx
  800e3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e3e:	01 d0                	add    %edx,%eax
  800e40:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e43:	e9 7b ff ff ff       	jmp    800dc3 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e48:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e49:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e4d:	74 08                	je     800e57 <strtol+0x134>
		*endptr = (char *) s;
  800e4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e52:	8b 55 08             	mov    0x8(%ebp),%edx
  800e55:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e57:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e5b:	74 07                	je     800e64 <strtol+0x141>
  800e5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e60:	f7 d8                	neg    %eax
  800e62:	eb 03                	jmp    800e67 <strtol+0x144>
  800e64:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e67:	c9                   	leave  
  800e68:	c3                   	ret    

00800e69 <ltostr>:

void
ltostr(long value, char *str)
{
  800e69:	55                   	push   %ebp
  800e6a:	89 e5                	mov    %esp,%ebp
  800e6c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e6f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e76:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e7d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e81:	79 13                	jns    800e96 <ltostr+0x2d>
	{
		neg = 1;
  800e83:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e90:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e93:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e96:	8b 45 08             	mov    0x8(%ebp),%eax
  800e99:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e9e:	99                   	cltd   
  800e9f:	f7 f9                	idiv   %ecx
  800ea1:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800ea4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea7:	8d 50 01             	lea    0x1(%eax),%edx
  800eaa:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ead:	89 c2                	mov    %eax,%edx
  800eaf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb2:	01 d0                	add    %edx,%eax
  800eb4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800eb7:	83 c2 30             	add    $0x30,%edx
  800eba:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800ebc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ebf:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ec4:	f7 e9                	imul   %ecx
  800ec6:	c1 fa 02             	sar    $0x2,%edx
  800ec9:	89 c8                	mov    %ecx,%eax
  800ecb:	c1 f8 1f             	sar    $0x1f,%eax
  800ece:	29 c2                	sub    %eax,%edx
  800ed0:	89 d0                	mov    %edx,%eax
  800ed2:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ed5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ed8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800edd:	f7 e9                	imul   %ecx
  800edf:	c1 fa 02             	sar    $0x2,%edx
  800ee2:	89 c8                	mov    %ecx,%eax
  800ee4:	c1 f8 1f             	sar    $0x1f,%eax
  800ee7:	29 c2                	sub    %eax,%edx
  800ee9:	89 d0                	mov    %edx,%eax
  800eeb:	c1 e0 02             	shl    $0x2,%eax
  800eee:	01 d0                	add    %edx,%eax
  800ef0:	01 c0                	add    %eax,%eax
  800ef2:	29 c1                	sub    %eax,%ecx
  800ef4:	89 ca                	mov    %ecx,%edx
  800ef6:	85 d2                	test   %edx,%edx
  800ef8:	75 9c                	jne    800e96 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800efa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800f01:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f04:	48                   	dec    %eax
  800f05:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800f08:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f0c:	74 3d                	je     800f4b <ltostr+0xe2>
		start = 1 ;
  800f0e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f15:	eb 34                	jmp    800f4b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f17:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1d:	01 d0                	add    %edx,%eax
  800f1f:	8a 00                	mov    (%eax),%al
  800f21:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f24:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2a:	01 c2                	add    %eax,%edx
  800f2c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f32:	01 c8                	add    %ecx,%eax
  800f34:	8a 00                	mov    (%eax),%al
  800f36:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f38:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3e:	01 c2                	add    %eax,%edx
  800f40:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f43:	88 02                	mov    %al,(%edx)
		start++ ;
  800f45:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f48:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f4e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f51:	7c c4                	jl     800f17 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f53:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f59:	01 d0                	add    %edx,%eax
  800f5b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f5e:	90                   	nop
  800f5f:	c9                   	leave  
  800f60:	c3                   	ret    

00800f61 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f61:	55                   	push   %ebp
  800f62:	89 e5                	mov    %esp,%ebp
  800f64:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f67:	ff 75 08             	pushl  0x8(%ebp)
  800f6a:	e8 54 fa ff ff       	call   8009c3 <strlen>
  800f6f:	83 c4 04             	add    $0x4,%esp
  800f72:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f75:	ff 75 0c             	pushl  0xc(%ebp)
  800f78:	e8 46 fa ff ff       	call   8009c3 <strlen>
  800f7d:	83 c4 04             	add    $0x4,%esp
  800f80:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f83:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f8a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f91:	eb 17                	jmp    800faa <strcconcat+0x49>
		final[s] = str1[s] ;
  800f93:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f96:	8b 45 10             	mov    0x10(%ebp),%eax
  800f99:	01 c2                	add    %eax,%edx
  800f9b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	01 c8                	add    %ecx,%eax
  800fa3:	8a 00                	mov    (%eax),%al
  800fa5:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800fa7:	ff 45 fc             	incl   -0x4(%ebp)
  800faa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fad:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800fb0:	7c e1                	jl     800f93 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800fb2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800fb9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800fc0:	eb 1f                	jmp    800fe1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800fc2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fc5:	8d 50 01             	lea    0x1(%eax),%edx
  800fc8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fcb:	89 c2                	mov    %eax,%edx
  800fcd:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd0:	01 c2                	add    %eax,%edx
  800fd2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fd5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd8:	01 c8                	add    %ecx,%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fde:	ff 45 f8             	incl   -0x8(%ebp)
  800fe1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fe7:	7c d9                	jl     800fc2 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fe9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fec:	8b 45 10             	mov    0x10(%ebp),%eax
  800fef:	01 d0                	add    %edx,%eax
  800ff1:	c6 00 00             	movb   $0x0,(%eax)
}
  800ff4:	90                   	nop
  800ff5:	c9                   	leave  
  800ff6:	c3                   	ret    

00800ff7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800ff7:	55                   	push   %ebp
  800ff8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800ffa:	8b 45 14             	mov    0x14(%ebp),%eax
  800ffd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801003:	8b 45 14             	mov    0x14(%ebp),%eax
  801006:	8b 00                	mov    (%eax),%eax
  801008:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80100f:	8b 45 10             	mov    0x10(%ebp),%eax
  801012:	01 d0                	add    %edx,%eax
  801014:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80101a:	eb 0c                	jmp    801028 <strsplit+0x31>
			*string++ = 0;
  80101c:	8b 45 08             	mov    0x8(%ebp),%eax
  80101f:	8d 50 01             	lea    0x1(%eax),%edx
  801022:	89 55 08             	mov    %edx,0x8(%ebp)
  801025:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801028:	8b 45 08             	mov    0x8(%ebp),%eax
  80102b:	8a 00                	mov    (%eax),%al
  80102d:	84 c0                	test   %al,%al
  80102f:	74 18                	je     801049 <strsplit+0x52>
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
  801034:	8a 00                	mov    (%eax),%al
  801036:	0f be c0             	movsbl %al,%eax
  801039:	50                   	push   %eax
  80103a:	ff 75 0c             	pushl  0xc(%ebp)
  80103d:	e8 13 fb ff ff       	call   800b55 <strchr>
  801042:	83 c4 08             	add    $0x8,%esp
  801045:	85 c0                	test   %eax,%eax
  801047:	75 d3                	jne    80101c <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801049:	8b 45 08             	mov    0x8(%ebp),%eax
  80104c:	8a 00                	mov    (%eax),%al
  80104e:	84 c0                	test   %al,%al
  801050:	74 5a                	je     8010ac <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801052:	8b 45 14             	mov    0x14(%ebp),%eax
  801055:	8b 00                	mov    (%eax),%eax
  801057:	83 f8 0f             	cmp    $0xf,%eax
  80105a:	75 07                	jne    801063 <strsplit+0x6c>
		{
			return 0;
  80105c:	b8 00 00 00 00       	mov    $0x0,%eax
  801061:	eb 66                	jmp    8010c9 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801063:	8b 45 14             	mov    0x14(%ebp),%eax
  801066:	8b 00                	mov    (%eax),%eax
  801068:	8d 48 01             	lea    0x1(%eax),%ecx
  80106b:	8b 55 14             	mov    0x14(%ebp),%edx
  80106e:	89 0a                	mov    %ecx,(%edx)
  801070:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801077:	8b 45 10             	mov    0x10(%ebp),%eax
  80107a:	01 c2                	add    %eax,%edx
  80107c:	8b 45 08             	mov    0x8(%ebp),%eax
  80107f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801081:	eb 03                	jmp    801086 <strsplit+0x8f>
			string++;
  801083:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	8a 00                	mov    (%eax),%al
  80108b:	84 c0                	test   %al,%al
  80108d:	74 8b                	je     80101a <strsplit+0x23>
  80108f:	8b 45 08             	mov    0x8(%ebp),%eax
  801092:	8a 00                	mov    (%eax),%al
  801094:	0f be c0             	movsbl %al,%eax
  801097:	50                   	push   %eax
  801098:	ff 75 0c             	pushl  0xc(%ebp)
  80109b:	e8 b5 fa ff ff       	call   800b55 <strchr>
  8010a0:	83 c4 08             	add    $0x8,%esp
  8010a3:	85 c0                	test   %eax,%eax
  8010a5:	74 dc                	je     801083 <strsplit+0x8c>
			string++;
	}
  8010a7:	e9 6e ff ff ff       	jmp    80101a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8010ac:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8010ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8010b0:	8b 00                	mov    (%eax),%eax
  8010b2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010bc:	01 d0                	add    %edx,%eax
  8010be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8010c4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010c9:	c9                   	leave  
  8010ca:	c3                   	ret    

008010cb <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8010cb:	55                   	push   %ebp
  8010cc:	89 e5                	mov    %esp,%ebp
  8010ce:	83 ec 18             	sub    $0x18,%esp
  8010d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d4:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8010d7:	83 ec 04             	sub    $0x4,%esp
  8010da:	68 b0 22 80 00       	push   $0x8022b0
  8010df:	6a 17                	push   $0x17
  8010e1:	68 cf 22 80 00       	push   $0x8022cf
  8010e6:	e8 3e 09 00 00       	call   801a29 <_panic>

008010eb <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8010eb:	55                   	push   %ebp
  8010ec:	89 e5                	mov    %esp,%ebp
  8010ee:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8010f1:	83 ec 04             	sub    $0x4,%esp
  8010f4:	68 db 22 80 00       	push   $0x8022db
  8010f9:	6a 2f                	push   $0x2f
  8010fb:	68 cf 22 80 00       	push   $0x8022cf
  801100:	e8 24 09 00 00       	call   801a29 <_panic>

00801105 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801105:	55                   	push   %ebp
  801106:	89 e5                	mov    %esp,%ebp
  801108:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80110b:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801112:	8b 55 08             	mov    0x8(%ebp),%edx
  801115:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801118:	01 d0                	add    %edx,%eax
  80111a:	48                   	dec    %eax
  80111b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  80111e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801121:	ba 00 00 00 00       	mov    $0x0,%edx
  801126:	f7 75 ec             	divl   -0x14(%ebp)
  801129:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80112c:	29 d0                	sub    %edx,%eax
  80112e:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801131:	8b 45 08             	mov    0x8(%ebp),%eax
  801134:	c1 e8 0c             	shr    $0xc,%eax
  801137:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80113a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801141:	e9 c8 00 00 00       	jmp    80120e <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801146:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80114d:	eb 27                	jmp    801176 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  80114f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801152:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801155:	01 c2                	add    %eax,%edx
  801157:	89 d0                	mov    %edx,%eax
  801159:	01 c0                	add    %eax,%eax
  80115b:	01 d0                	add    %edx,%eax
  80115d:	c1 e0 02             	shl    $0x2,%eax
  801160:	05 48 30 80 00       	add    $0x803048,%eax
  801165:	8b 00                	mov    (%eax),%eax
  801167:	85 c0                	test   %eax,%eax
  801169:	74 08                	je     801173 <malloc+0x6e>
            	i += j;
  80116b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80116e:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801171:	eb 0b                	jmp    80117e <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801173:	ff 45 f0             	incl   -0x10(%ebp)
  801176:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801179:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80117c:	72 d1                	jb     80114f <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  80117e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801181:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801184:	0f 85 81 00 00 00    	jne    80120b <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  80118a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80118d:	05 00 00 08 00       	add    $0x80000,%eax
  801192:	c1 e0 0c             	shl    $0xc,%eax
  801195:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801198:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80119f:	eb 1f                	jmp    8011c0 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8011a1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011a7:	01 c2                	add    %eax,%edx
  8011a9:	89 d0                	mov    %edx,%eax
  8011ab:	01 c0                	add    %eax,%eax
  8011ad:	01 d0                	add    %edx,%eax
  8011af:	c1 e0 02             	shl    $0x2,%eax
  8011b2:	05 48 30 80 00       	add    $0x803048,%eax
  8011b7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8011bd:	ff 45 f0             	incl   -0x10(%ebp)
  8011c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011c3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8011c6:	72 d9                	jb     8011a1 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  8011c8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011cb:	89 d0                	mov    %edx,%eax
  8011cd:	01 c0                	add    %eax,%eax
  8011cf:	01 d0                	add    %edx,%eax
  8011d1:	c1 e0 02             	shl    $0x2,%eax
  8011d4:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  8011da:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8011dd:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8011df:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8011e2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8011e5:	89 c8                	mov    %ecx,%eax
  8011e7:	01 c0                	add    %eax,%eax
  8011e9:	01 c8                	add    %ecx,%eax
  8011eb:	c1 e0 02             	shl    $0x2,%eax
  8011ee:	05 44 30 80 00       	add    $0x803044,%eax
  8011f3:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8011f5:	83 ec 08             	sub    $0x8,%esp
  8011f8:	ff 75 08             	pushl  0x8(%ebp)
  8011fb:	ff 75 e0             	pushl  -0x20(%ebp)
  8011fe:	e8 2b 03 00 00       	call   80152e <sys_allocateMem>
  801203:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801206:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801209:	eb 19                	jmp    801224 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80120b:	ff 45 f4             	incl   -0xc(%ebp)
  80120e:	a1 04 30 80 00       	mov    0x803004,%eax
  801213:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801216:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801219:	0f 83 27 ff ff ff    	jae    801146 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  80121f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801224:	c9                   	leave  
  801225:	c3                   	ret    

00801226 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801226:	55                   	push   %ebp
  801227:	89 e5                	mov    %esp,%ebp
  801229:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80122c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801230:	0f 84 e5 00 00 00    	je     80131b <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801236:	8b 45 08             	mov    0x8(%ebp),%eax
  801239:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  80123c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80123f:	05 00 00 00 80       	add    $0x80000000,%eax
  801244:	c1 e8 0c             	shr    $0xc,%eax
  801247:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  80124a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80124d:	89 d0                	mov    %edx,%eax
  80124f:	01 c0                	add    %eax,%eax
  801251:	01 d0                	add    %edx,%eax
  801253:	c1 e0 02             	shl    $0x2,%eax
  801256:	05 40 30 80 00       	add    $0x803040,%eax
  80125b:	8b 00                	mov    (%eax),%eax
  80125d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801260:	0f 85 b8 00 00 00    	jne    80131e <free+0xf8>
  801266:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801269:	89 d0                	mov    %edx,%eax
  80126b:	01 c0                	add    %eax,%eax
  80126d:	01 d0                	add    %edx,%eax
  80126f:	c1 e0 02             	shl    $0x2,%eax
  801272:	05 48 30 80 00       	add    $0x803048,%eax
  801277:	8b 00                	mov    (%eax),%eax
  801279:	85 c0                	test   %eax,%eax
  80127b:	0f 84 9d 00 00 00    	je     80131e <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801281:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801284:	89 d0                	mov    %edx,%eax
  801286:	01 c0                	add    %eax,%eax
  801288:	01 d0                	add    %edx,%eax
  80128a:	c1 e0 02             	shl    $0x2,%eax
  80128d:	05 44 30 80 00       	add    $0x803044,%eax
  801292:	8b 00                	mov    (%eax),%eax
  801294:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801297:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80129a:	c1 e0 0c             	shl    $0xc,%eax
  80129d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  8012a0:	83 ec 08             	sub    $0x8,%esp
  8012a3:	ff 75 e4             	pushl  -0x1c(%ebp)
  8012a6:	ff 75 f0             	pushl  -0x10(%ebp)
  8012a9:	e8 64 02 00 00       	call   801512 <sys_freeMem>
  8012ae:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8012b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8012b8:	eb 57                	jmp    801311 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8012ba:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012c0:	01 c2                	add    %eax,%edx
  8012c2:	89 d0                	mov    %edx,%eax
  8012c4:	01 c0                	add    %eax,%eax
  8012c6:	01 d0                	add    %edx,%eax
  8012c8:	c1 e0 02             	shl    $0x2,%eax
  8012cb:	05 48 30 80 00       	add    $0x803048,%eax
  8012d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  8012d6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012dc:	01 c2                	add    %eax,%edx
  8012de:	89 d0                	mov    %edx,%eax
  8012e0:	01 c0                	add    %eax,%eax
  8012e2:	01 d0                	add    %edx,%eax
  8012e4:	c1 e0 02             	shl    $0x2,%eax
  8012e7:	05 40 30 80 00       	add    $0x803040,%eax
  8012ec:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8012f2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012f8:	01 c2                	add    %eax,%edx
  8012fa:	89 d0                	mov    %edx,%eax
  8012fc:	01 c0                	add    %eax,%eax
  8012fe:	01 d0                	add    %edx,%eax
  801300:	c1 e0 02             	shl    $0x2,%eax
  801303:	05 44 30 80 00       	add    $0x803044,%eax
  801308:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80130e:	ff 45 f4             	incl   -0xc(%ebp)
  801311:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801314:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801317:	7c a1                	jl     8012ba <free+0x94>
  801319:	eb 04                	jmp    80131f <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80131b:	90                   	nop
  80131c:	eb 01                	jmp    80131f <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  80131e:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  80131f:	c9                   	leave  
  801320:	c3                   	ret    

00801321 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801321:	55                   	push   %ebp
  801322:	89 e5                	mov    %esp,%ebp
  801324:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801327:	83 ec 04             	sub    $0x4,%esp
  80132a:	68 f8 22 80 00       	push   $0x8022f8
  80132f:	68 ae 00 00 00       	push   $0xae
  801334:	68 cf 22 80 00       	push   $0x8022cf
  801339:	e8 eb 06 00 00       	call   801a29 <_panic>

0080133e <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80133e:	55                   	push   %ebp
  80133f:	89 e5                	mov    %esp,%ebp
  801341:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801344:	83 ec 04             	sub    $0x4,%esp
  801347:	68 18 23 80 00       	push   $0x802318
  80134c:	68 ca 00 00 00       	push   $0xca
  801351:	68 cf 22 80 00       	push   $0x8022cf
  801356:	e8 ce 06 00 00       	call   801a29 <_panic>

0080135b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80135b:	55                   	push   %ebp
  80135c:	89 e5                	mov    %esp,%ebp
  80135e:	57                   	push   %edi
  80135f:	56                   	push   %esi
  801360:	53                   	push   %ebx
  801361:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801364:	8b 45 08             	mov    0x8(%ebp),%eax
  801367:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80136d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801370:	8b 7d 18             	mov    0x18(%ebp),%edi
  801373:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801376:	cd 30                	int    $0x30
  801378:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80137b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80137e:	83 c4 10             	add    $0x10,%esp
  801381:	5b                   	pop    %ebx
  801382:	5e                   	pop    %esi
  801383:	5f                   	pop    %edi
  801384:	5d                   	pop    %ebp
  801385:	c3                   	ret    

00801386 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801386:	55                   	push   %ebp
  801387:	89 e5                	mov    %esp,%ebp
  801389:	83 ec 04             	sub    $0x4,%esp
  80138c:	8b 45 10             	mov    0x10(%ebp),%eax
  80138f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801392:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
  801399:	6a 00                	push   $0x0
  80139b:	6a 00                	push   $0x0
  80139d:	52                   	push   %edx
  80139e:	ff 75 0c             	pushl  0xc(%ebp)
  8013a1:	50                   	push   %eax
  8013a2:	6a 00                	push   $0x0
  8013a4:	e8 b2 ff ff ff       	call   80135b <syscall>
  8013a9:	83 c4 18             	add    $0x18,%esp
}
  8013ac:	90                   	nop
  8013ad:	c9                   	leave  
  8013ae:	c3                   	ret    

008013af <sys_cgetc>:

int
sys_cgetc(void)
{
  8013af:	55                   	push   %ebp
  8013b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 01                	push   $0x1
  8013be:	e8 98 ff ff ff       	call   80135b <syscall>
  8013c3:	83 c4 18             	add    $0x18,%esp
}
  8013c6:	c9                   	leave  
  8013c7:	c3                   	ret    

008013c8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8013c8:	55                   	push   %ebp
  8013c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8013cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	50                   	push   %eax
  8013d7:	6a 05                	push   $0x5
  8013d9:	e8 7d ff ff ff       	call   80135b <syscall>
  8013de:	83 c4 18             	add    $0x18,%esp
}
  8013e1:	c9                   	leave  
  8013e2:	c3                   	ret    

008013e3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013e3:	55                   	push   %ebp
  8013e4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 02                	push   $0x2
  8013f2:	e8 64 ff ff ff       	call   80135b <syscall>
  8013f7:	83 c4 18             	add    $0x18,%esp
}
  8013fa:	c9                   	leave  
  8013fb:	c3                   	ret    

008013fc <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013fc:	55                   	push   %ebp
  8013fd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	6a 03                	push   $0x3
  80140b:	e8 4b ff ff ff       	call   80135b <syscall>
  801410:	83 c4 18             	add    $0x18,%esp
}
  801413:	c9                   	leave  
  801414:	c3                   	ret    

00801415 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801415:	55                   	push   %ebp
  801416:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801418:	6a 00                	push   $0x0
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	6a 04                	push   $0x4
  801424:	e8 32 ff ff ff       	call   80135b <syscall>
  801429:	83 c4 18             	add    $0x18,%esp
}
  80142c:	c9                   	leave  
  80142d:	c3                   	ret    

0080142e <sys_env_exit>:


void sys_env_exit(void)
{
  80142e:	55                   	push   %ebp
  80142f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 06                	push   $0x6
  80143d:	e8 19 ff ff ff       	call   80135b <syscall>
  801442:	83 c4 18             	add    $0x18,%esp
}
  801445:	90                   	nop
  801446:	c9                   	leave  
  801447:	c3                   	ret    

00801448 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801448:	55                   	push   %ebp
  801449:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80144b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80144e:	8b 45 08             	mov    0x8(%ebp),%eax
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	6a 00                	push   $0x0
  801457:	52                   	push   %edx
  801458:	50                   	push   %eax
  801459:	6a 07                	push   $0x7
  80145b:	e8 fb fe ff ff       	call   80135b <syscall>
  801460:	83 c4 18             	add    $0x18,%esp
}
  801463:	c9                   	leave  
  801464:	c3                   	ret    

00801465 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
  801468:	56                   	push   %esi
  801469:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80146a:	8b 75 18             	mov    0x18(%ebp),%esi
  80146d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801470:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801473:	8b 55 0c             	mov    0xc(%ebp),%edx
  801476:	8b 45 08             	mov    0x8(%ebp),%eax
  801479:	56                   	push   %esi
  80147a:	53                   	push   %ebx
  80147b:	51                   	push   %ecx
  80147c:	52                   	push   %edx
  80147d:	50                   	push   %eax
  80147e:	6a 08                	push   $0x8
  801480:	e8 d6 fe ff ff       	call   80135b <syscall>
  801485:	83 c4 18             	add    $0x18,%esp
}
  801488:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80148b:	5b                   	pop    %ebx
  80148c:	5e                   	pop    %esi
  80148d:	5d                   	pop    %ebp
  80148e:	c3                   	ret    

0080148f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80148f:	55                   	push   %ebp
  801490:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801492:	8b 55 0c             	mov    0xc(%ebp),%edx
  801495:	8b 45 08             	mov    0x8(%ebp),%eax
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	52                   	push   %edx
  80149f:	50                   	push   %eax
  8014a0:	6a 09                	push   $0x9
  8014a2:	e8 b4 fe ff ff       	call   80135b <syscall>
  8014a7:	83 c4 18             	add    $0x18,%esp
}
  8014aa:	c9                   	leave  
  8014ab:	c3                   	ret    

008014ac <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8014ac:	55                   	push   %ebp
  8014ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	ff 75 0c             	pushl  0xc(%ebp)
  8014b8:	ff 75 08             	pushl  0x8(%ebp)
  8014bb:	6a 0a                	push   $0xa
  8014bd:	e8 99 fe ff ff       	call   80135b <syscall>
  8014c2:	83 c4 18             	add    $0x18,%esp
}
  8014c5:	c9                   	leave  
  8014c6:	c3                   	ret    

008014c7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8014c7:	55                   	push   %ebp
  8014c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 0b                	push   $0xb
  8014d6:	e8 80 fe ff ff       	call   80135b <syscall>
  8014db:	83 c4 18             	add    $0x18,%esp
}
  8014de:	c9                   	leave  
  8014df:	c3                   	ret    

008014e0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014e0:	55                   	push   %ebp
  8014e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 0c                	push   $0xc
  8014ef:	e8 67 fe ff ff       	call   80135b <syscall>
  8014f4:	83 c4 18             	add    $0x18,%esp
}
  8014f7:	c9                   	leave  
  8014f8:	c3                   	ret    

008014f9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014f9:	55                   	push   %ebp
  8014fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 0d                	push   $0xd
  801508:	e8 4e fe ff ff       	call   80135b <syscall>
  80150d:	83 c4 18             	add    $0x18,%esp
}
  801510:	c9                   	leave  
  801511:	c3                   	ret    

00801512 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801512:	55                   	push   %ebp
  801513:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	ff 75 0c             	pushl  0xc(%ebp)
  80151e:	ff 75 08             	pushl  0x8(%ebp)
  801521:	6a 11                	push   $0x11
  801523:	e8 33 fe ff ff       	call   80135b <syscall>
  801528:	83 c4 18             	add    $0x18,%esp
	return;
  80152b:	90                   	nop
}
  80152c:	c9                   	leave  
  80152d:	c3                   	ret    

0080152e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80152e:	55                   	push   %ebp
  80152f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	ff 75 0c             	pushl  0xc(%ebp)
  80153a:	ff 75 08             	pushl  0x8(%ebp)
  80153d:	6a 12                	push   $0x12
  80153f:	e8 17 fe ff ff       	call   80135b <syscall>
  801544:	83 c4 18             	add    $0x18,%esp
	return ;
  801547:	90                   	nop
}
  801548:	c9                   	leave  
  801549:	c3                   	ret    

0080154a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80154a:	55                   	push   %ebp
  80154b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 0e                	push   $0xe
  801559:	e8 fd fd ff ff       	call   80135b <syscall>
  80155e:	83 c4 18             	add    $0x18,%esp
}
  801561:	c9                   	leave  
  801562:	c3                   	ret    

00801563 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801563:	55                   	push   %ebp
  801564:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	ff 75 08             	pushl  0x8(%ebp)
  801571:	6a 0f                	push   $0xf
  801573:	e8 e3 fd ff ff       	call   80135b <syscall>
  801578:	83 c4 18             	add    $0x18,%esp
}
  80157b:	c9                   	leave  
  80157c:	c3                   	ret    

0080157d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80157d:	55                   	push   %ebp
  80157e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 00                	push   $0x0
  80158a:	6a 10                	push   $0x10
  80158c:	e8 ca fd ff ff       	call   80135b <syscall>
  801591:	83 c4 18             	add    $0x18,%esp
}
  801594:	90                   	nop
  801595:	c9                   	leave  
  801596:	c3                   	ret    

00801597 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801597:	55                   	push   %ebp
  801598:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80159a:	6a 00                	push   $0x0
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 14                	push   $0x14
  8015a6:	e8 b0 fd ff ff       	call   80135b <syscall>
  8015ab:	83 c4 18             	add    $0x18,%esp
}
  8015ae:	90                   	nop
  8015af:	c9                   	leave  
  8015b0:	c3                   	ret    

008015b1 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8015b1:	55                   	push   %ebp
  8015b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 15                	push   $0x15
  8015c0:	e8 96 fd ff ff       	call   80135b <syscall>
  8015c5:	83 c4 18             	add    $0x18,%esp
}
  8015c8:	90                   	nop
  8015c9:	c9                   	leave  
  8015ca:	c3                   	ret    

008015cb <sys_cputc>:


void
sys_cputc(const char c)
{
  8015cb:	55                   	push   %ebp
  8015cc:	89 e5                	mov    %esp,%ebp
  8015ce:	83 ec 04             	sub    $0x4,%esp
  8015d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8015d7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	50                   	push   %eax
  8015e4:	6a 16                	push   $0x16
  8015e6:	e8 70 fd ff ff       	call   80135b <syscall>
  8015eb:	83 c4 18             	add    $0x18,%esp
}
  8015ee:	90                   	nop
  8015ef:	c9                   	leave  
  8015f0:	c3                   	ret    

008015f1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015f1:	55                   	push   %ebp
  8015f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 17                	push   $0x17
  801600:	e8 56 fd ff ff       	call   80135b <syscall>
  801605:	83 c4 18             	add    $0x18,%esp
}
  801608:	90                   	nop
  801609:	c9                   	leave  
  80160a:	c3                   	ret    

0080160b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80160e:	8b 45 08             	mov    0x8(%ebp),%eax
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	ff 75 0c             	pushl  0xc(%ebp)
  80161a:	50                   	push   %eax
  80161b:	6a 18                	push   $0x18
  80161d:	e8 39 fd ff ff       	call   80135b <syscall>
  801622:	83 c4 18             	add    $0x18,%esp
}
  801625:	c9                   	leave  
  801626:	c3                   	ret    

00801627 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801627:	55                   	push   %ebp
  801628:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80162a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80162d:	8b 45 08             	mov    0x8(%ebp),%eax
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	52                   	push   %edx
  801637:	50                   	push   %eax
  801638:	6a 1b                	push   $0x1b
  80163a:	e8 1c fd ff ff       	call   80135b <syscall>
  80163f:	83 c4 18             	add    $0x18,%esp
}
  801642:	c9                   	leave  
  801643:	c3                   	ret    

00801644 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801644:	55                   	push   %ebp
  801645:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801647:	8b 55 0c             	mov    0xc(%ebp),%edx
  80164a:	8b 45 08             	mov    0x8(%ebp),%eax
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	52                   	push   %edx
  801654:	50                   	push   %eax
  801655:	6a 19                	push   $0x19
  801657:	e8 ff fc ff ff       	call   80135b <syscall>
  80165c:	83 c4 18             	add    $0x18,%esp
}
  80165f:	90                   	nop
  801660:	c9                   	leave  
  801661:	c3                   	ret    

00801662 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801662:	55                   	push   %ebp
  801663:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801665:	8b 55 0c             	mov    0xc(%ebp),%edx
  801668:	8b 45 08             	mov    0x8(%ebp),%eax
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	52                   	push   %edx
  801672:	50                   	push   %eax
  801673:	6a 1a                	push   $0x1a
  801675:	e8 e1 fc ff ff       	call   80135b <syscall>
  80167a:	83 c4 18             	add    $0x18,%esp
}
  80167d:	90                   	nop
  80167e:	c9                   	leave  
  80167f:	c3                   	ret    

00801680 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801680:	55                   	push   %ebp
  801681:	89 e5                	mov    %esp,%ebp
  801683:	83 ec 04             	sub    $0x4,%esp
  801686:	8b 45 10             	mov    0x10(%ebp),%eax
  801689:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80168c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80168f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	6a 00                	push   $0x0
  801698:	51                   	push   %ecx
  801699:	52                   	push   %edx
  80169a:	ff 75 0c             	pushl  0xc(%ebp)
  80169d:	50                   	push   %eax
  80169e:	6a 1c                	push   $0x1c
  8016a0:	e8 b6 fc ff ff       	call   80135b <syscall>
  8016a5:	83 c4 18             	add    $0x18,%esp
}
  8016a8:	c9                   	leave  
  8016a9:	c3                   	ret    

008016aa <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8016aa:	55                   	push   %ebp
  8016ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8016ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	52                   	push   %edx
  8016ba:	50                   	push   %eax
  8016bb:	6a 1d                	push   $0x1d
  8016bd:	e8 99 fc ff ff       	call   80135b <syscall>
  8016c2:	83 c4 18             	add    $0x18,%esp
}
  8016c5:	c9                   	leave  
  8016c6:	c3                   	ret    

008016c7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8016c7:	55                   	push   %ebp
  8016c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8016ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	51                   	push   %ecx
  8016d8:	52                   	push   %edx
  8016d9:	50                   	push   %eax
  8016da:	6a 1e                	push   $0x1e
  8016dc:	e8 7a fc ff ff       	call   80135b <syscall>
  8016e1:	83 c4 18             	add    $0x18,%esp
}
  8016e4:	c9                   	leave  
  8016e5:	c3                   	ret    

008016e6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016e6:	55                   	push   %ebp
  8016e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	52                   	push   %edx
  8016f6:	50                   	push   %eax
  8016f7:	6a 1f                	push   $0x1f
  8016f9:	e8 5d fc ff ff       	call   80135b <syscall>
  8016fe:	83 c4 18             	add    $0x18,%esp
}
  801701:	c9                   	leave  
  801702:	c3                   	ret    

00801703 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801703:	55                   	push   %ebp
  801704:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 20                	push   $0x20
  801712:	e8 44 fc ff ff       	call   80135b <syscall>
  801717:	83 c4 18             	add    $0x18,%esp
}
  80171a:	c9                   	leave  
  80171b:	c3                   	ret    

0080171c <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80171c:	55                   	push   %ebp
  80171d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80171f:	8b 45 08             	mov    0x8(%ebp),%eax
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	ff 75 10             	pushl  0x10(%ebp)
  801729:	ff 75 0c             	pushl  0xc(%ebp)
  80172c:	50                   	push   %eax
  80172d:	6a 21                	push   $0x21
  80172f:	e8 27 fc ff ff       	call   80135b <syscall>
  801734:	83 c4 18             	add    $0x18,%esp
}
  801737:	c9                   	leave  
  801738:	c3                   	ret    

00801739 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801739:	55                   	push   %ebp
  80173a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80173c:	8b 45 08             	mov    0x8(%ebp),%eax
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	50                   	push   %eax
  801748:	6a 22                	push   $0x22
  80174a:	e8 0c fc ff ff       	call   80135b <syscall>
  80174f:	83 c4 18             	add    $0x18,%esp
}
  801752:	90                   	nop
  801753:	c9                   	leave  
  801754:	c3                   	ret    

00801755 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801758:	8b 45 08             	mov    0x8(%ebp),%eax
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	50                   	push   %eax
  801764:	6a 23                	push   $0x23
  801766:	e8 f0 fb ff ff       	call   80135b <syscall>
  80176b:	83 c4 18             	add    $0x18,%esp
}
  80176e:	90                   	nop
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
  801774:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801777:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80177a:	8d 50 04             	lea    0x4(%eax),%edx
  80177d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	52                   	push   %edx
  801787:	50                   	push   %eax
  801788:	6a 24                	push   $0x24
  80178a:	e8 cc fb ff ff       	call   80135b <syscall>
  80178f:	83 c4 18             	add    $0x18,%esp
	return result;
  801792:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801795:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801798:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80179b:	89 01                	mov    %eax,(%ecx)
  80179d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8017a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a3:	c9                   	leave  
  8017a4:	c2 04 00             	ret    $0x4

008017a7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8017a7:	55                   	push   %ebp
  8017a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	ff 75 10             	pushl  0x10(%ebp)
  8017b1:	ff 75 0c             	pushl  0xc(%ebp)
  8017b4:	ff 75 08             	pushl  0x8(%ebp)
  8017b7:	6a 13                	push   $0x13
  8017b9:	e8 9d fb ff ff       	call   80135b <syscall>
  8017be:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c1:	90                   	nop
}
  8017c2:	c9                   	leave  
  8017c3:	c3                   	ret    

008017c4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8017c4:	55                   	push   %ebp
  8017c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 25                	push   $0x25
  8017d3:	e8 83 fb ff ff       	call   80135b <syscall>
  8017d8:	83 c4 18             	add    $0x18,%esp
}
  8017db:	c9                   	leave  
  8017dc:	c3                   	ret    

008017dd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017dd:	55                   	push   %ebp
  8017de:	89 e5                	mov    %esp,%ebp
  8017e0:	83 ec 04             	sub    $0x4,%esp
  8017e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017e9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	50                   	push   %eax
  8017f6:	6a 26                	push   $0x26
  8017f8:	e8 5e fb ff ff       	call   80135b <syscall>
  8017fd:	83 c4 18             	add    $0x18,%esp
	return ;
  801800:	90                   	nop
}
  801801:	c9                   	leave  
  801802:	c3                   	ret    

00801803 <rsttst>:
void rsttst()
{
  801803:	55                   	push   %ebp
  801804:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 28                	push   $0x28
  801812:	e8 44 fb ff ff       	call   80135b <syscall>
  801817:	83 c4 18             	add    $0x18,%esp
	return ;
  80181a:	90                   	nop
}
  80181b:	c9                   	leave  
  80181c:	c3                   	ret    

0080181d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80181d:	55                   	push   %ebp
  80181e:	89 e5                	mov    %esp,%ebp
  801820:	83 ec 04             	sub    $0x4,%esp
  801823:	8b 45 14             	mov    0x14(%ebp),%eax
  801826:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801829:	8b 55 18             	mov    0x18(%ebp),%edx
  80182c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801830:	52                   	push   %edx
  801831:	50                   	push   %eax
  801832:	ff 75 10             	pushl  0x10(%ebp)
  801835:	ff 75 0c             	pushl  0xc(%ebp)
  801838:	ff 75 08             	pushl  0x8(%ebp)
  80183b:	6a 27                	push   $0x27
  80183d:	e8 19 fb ff ff       	call   80135b <syscall>
  801842:	83 c4 18             	add    $0x18,%esp
	return ;
  801845:	90                   	nop
}
  801846:	c9                   	leave  
  801847:	c3                   	ret    

00801848 <chktst>:
void chktst(uint32 n)
{
  801848:	55                   	push   %ebp
  801849:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	ff 75 08             	pushl  0x8(%ebp)
  801856:	6a 29                	push   $0x29
  801858:	e8 fe fa ff ff       	call   80135b <syscall>
  80185d:	83 c4 18             	add    $0x18,%esp
	return ;
  801860:	90                   	nop
}
  801861:	c9                   	leave  
  801862:	c3                   	ret    

00801863 <inctst>:

void inctst()
{
  801863:	55                   	push   %ebp
  801864:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 2a                	push   $0x2a
  801872:	e8 e4 fa ff ff       	call   80135b <syscall>
  801877:	83 c4 18             	add    $0x18,%esp
	return ;
  80187a:	90                   	nop
}
  80187b:	c9                   	leave  
  80187c:	c3                   	ret    

0080187d <gettst>:
uint32 gettst()
{
  80187d:	55                   	push   %ebp
  80187e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 2b                	push   $0x2b
  80188c:	e8 ca fa ff ff       	call   80135b <syscall>
  801891:	83 c4 18             	add    $0x18,%esp
}
  801894:	c9                   	leave  
  801895:	c3                   	ret    

00801896 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801896:	55                   	push   %ebp
  801897:	89 e5                	mov    %esp,%ebp
  801899:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 2c                	push   $0x2c
  8018a8:	e8 ae fa ff ff       	call   80135b <syscall>
  8018ad:	83 c4 18             	add    $0x18,%esp
  8018b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8018b3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8018b7:	75 07                	jne    8018c0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8018b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8018be:	eb 05                	jmp    8018c5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8018c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018c5:	c9                   	leave  
  8018c6:	c3                   	ret    

008018c7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8018c7:	55                   	push   %ebp
  8018c8:	89 e5                	mov    %esp,%ebp
  8018ca:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 2c                	push   $0x2c
  8018d9:	e8 7d fa ff ff       	call   80135b <syscall>
  8018de:	83 c4 18             	add    $0x18,%esp
  8018e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018e4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018e8:	75 07                	jne    8018f1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ef:	eb 05                	jmp    8018f6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018f6:	c9                   	leave  
  8018f7:	c3                   	ret    

008018f8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018f8:	55                   	push   %ebp
  8018f9:	89 e5                	mov    %esp,%ebp
  8018fb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	6a 00                	push   $0x0
  801908:	6a 2c                	push   $0x2c
  80190a:	e8 4c fa ff ff       	call   80135b <syscall>
  80190f:	83 c4 18             	add    $0x18,%esp
  801912:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801915:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801919:	75 07                	jne    801922 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80191b:	b8 01 00 00 00       	mov    $0x1,%eax
  801920:	eb 05                	jmp    801927 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801922:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801927:	c9                   	leave  
  801928:	c3                   	ret    

00801929 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801929:	55                   	push   %ebp
  80192a:	89 e5                	mov    %esp,%ebp
  80192c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 2c                	push   $0x2c
  80193b:	e8 1b fa ff ff       	call   80135b <syscall>
  801940:	83 c4 18             	add    $0x18,%esp
  801943:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801946:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80194a:	75 07                	jne    801953 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80194c:	b8 01 00 00 00       	mov    $0x1,%eax
  801951:	eb 05                	jmp    801958 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801953:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801958:	c9                   	leave  
  801959:	c3                   	ret    

0080195a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80195a:	55                   	push   %ebp
  80195b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	ff 75 08             	pushl  0x8(%ebp)
  801968:	6a 2d                	push   $0x2d
  80196a:	e8 ec f9 ff ff       	call   80135b <syscall>
  80196f:	83 c4 18             	add    $0x18,%esp
	return ;
  801972:	90                   	nop
}
  801973:	c9                   	leave  
  801974:	c3                   	ret    

00801975 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801975:	55                   	push   %ebp
  801976:	89 e5                	mov    %esp,%ebp
  801978:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80197b:	8b 55 08             	mov    0x8(%ebp),%edx
  80197e:	89 d0                	mov    %edx,%eax
  801980:	c1 e0 02             	shl    $0x2,%eax
  801983:	01 d0                	add    %edx,%eax
  801985:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80198c:	01 d0                	add    %edx,%eax
  80198e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801995:	01 d0                	add    %edx,%eax
  801997:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80199e:	01 d0                	add    %edx,%eax
  8019a0:	c1 e0 04             	shl    $0x4,%eax
  8019a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8019a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8019ad:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8019b0:	83 ec 0c             	sub    $0xc,%esp
  8019b3:	50                   	push   %eax
  8019b4:	e8 b8 fd ff ff       	call   801771 <sys_get_virtual_time>
  8019b9:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8019bc:	eb 41                	jmp    8019ff <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8019be:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8019c1:	83 ec 0c             	sub    $0xc,%esp
  8019c4:	50                   	push   %eax
  8019c5:	e8 a7 fd ff ff       	call   801771 <sys_get_virtual_time>
  8019ca:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8019cd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019d3:	29 c2                	sub    %eax,%edx
  8019d5:	89 d0                	mov    %edx,%eax
  8019d7:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8019da:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8019dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019e0:	89 d1                	mov    %edx,%ecx
  8019e2:	29 c1                	sub    %eax,%ecx
  8019e4:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8019e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019ea:	39 c2                	cmp    %eax,%edx
  8019ec:	0f 97 c0             	seta   %al
  8019ef:	0f b6 c0             	movzbl %al,%eax
  8019f2:	29 c1                	sub    %eax,%ecx
  8019f4:	89 c8                	mov    %ecx,%eax
  8019f6:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8019f9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8019fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8019ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a02:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a05:	72 b7                	jb     8019be <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801a07:	90                   	nop
  801a08:	c9                   	leave  
  801a09:	c3                   	ret    

00801a0a <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801a0a:	55                   	push   %ebp
  801a0b:	89 e5                	mov    %esp,%ebp
  801a0d:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801a10:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801a17:	eb 03                	jmp    801a1c <busy_wait+0x12>
  801a19:	ff 45 fc             	incl   -0x4(%ebp)
  801a1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a1f:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a22:	72 f5                	jb     801a19 <busy_wait+0xf>
	return i;
  801a24:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801a27:	c9                   	leave  
  801a28:	c3                   	ret    

00801a29 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801a29:	55                   	push   %ebp
  801a2a:	89 e5                	mov    %esp,%ebp
  801a2c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801a2f:	8d 45 10             	lea    0x10(%ebp),%eax
  801a32:	83 c0 04             	add    $0x4,%eax
  801a35:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801a38:	a1 40 30 98 00       	mov    0x983040,%eax
  801a3d:	85 c0                	test   %eax,%eax
  801a3f:	74 16                	je     801a57 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801a41:	a1 40 30 98 00       	mov    0x983040,%eax
  801a46:	83 ec 08             	sub    $0x8,%esp
  801a49:	50                   	push   %eax
  801a4a:	68 3c 23 80 00       	push   $0x80233c
  801a4f:	e8 ed e8 ff ff       	call   800341 <cprintf>
  801a54:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801a57:	a1 00 30 80 00       	mov    0x803000,%eax
  801a5c:	ff 75 0c             	pushl  0xc(%ebp)
  801a5f:	ff 75 08             	pushl  0x8(%ebp)
  801a62:	50                   	push   %eax
  801a63:	68 41 23 80 00       	push   $0x802341
  801a68:	e8 d4 e8 ff ff       	call   800341 <cprintf>
  801a6d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801a70:	8b 45 10             	mov    0x10(%ebp),%eax
  801a73:	83 ec 08             	sub    $0x8,%esp
  801a76:	ff 75 f4             	pushl  -0xc(%ebp)
  801a79:	50                   	push   %eax
  801a7a:	e8 57 e8 ff ff       	call   8002d6 <vcprintf>
  801a7f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801a82:	83 ec 08             	sub    $0x8,%esp
  801a85:	6a 00                	push   $0x0
  801a87:	68 5d 23 80 00       	push   $0x80235d
  801a8c:	e8 45 e8 ff ff       	call   8002d6 <vcprintf>
  801a91:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801a94:	e8 c6 e7 ff ff       	call   80025f <exit>

	// should not return here
	while (1) ;
  801a99:	eb fe                	jmp    801a99 <_panic+0x70>

00801a9b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801a9b:	55                   	push   %ebp
  801a9c:	89 e5                	mov    %esp,%ebp
  801a9e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801aa1:	a1 20 30 80 00       	mov    0x803020,%eax
  801aa6:	8b 50 74             	mov    0x74(%eax),%edx
  801aa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aac:	39 c2                	cmp    %eax,%edx
  801aae:	74 14                	je     801ac4 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801ab0:	83 ec 04             	sub    $0x4,%esp
  801ab3:	68 60 23 80 00       	push   $0x802360
  801ab8:	6a 26                	push   $0x26
  801aba:	68 ac 23 80 00       	push   $0x8023ac
  801abf:	e8 65 ff ff ff       	call   801a29 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801ac4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801acb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ad2:	e9 c2 00 00 00       	jmp    801b99 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801ad7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ada:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae4:	01 d0                	add    %edx,%eax
  801ae6:	8b 00                	mov    (%eax),%eax
  801ae8:	85 c0                	test   %eax,%eax
  801aea:	75 08                	jne    801af4 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801aec:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801aef:	e9 a2 00 00 00       	jmp    801b96 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801af4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801afb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801b02:	eb 69                	jmp    801b6d <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801b04:	a1 20 30 80 00       	mov    0x803020,%eax
  801b09:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801b0f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801b12:	89 d0                	mov    %edx,%eax
  801b14:	01 c0                	add    %eax,%eax
  801b16:	01 d0                	add    %edx,%eax
  801b18:	c1 e0 02             	shl    $0x2,%eax
  801b1b:	01 c8                	add    %ecx,%eax
  801b1d:	8a 40 04             	mov    0x4(%eax),%al
  801b20:	84 c0                	test   %al,%al
  801b22:	75 46                	jne    801b6a <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801b24:	a1 20 30 80 00       	mov    0x803020,%eax
  801b29:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801b2f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801b32:	89 d0                	mov    %edx,%eax
  801b34:	01 c0                	add    %eax,%eax
  801b36:	01 d0                	add    %edx,%eax
  801b38:	c1 e0 02             	shl    $0x2,%eax
  801b3b:	01 c8                	add    %ecx,%eax
  801b3d:	8b 00                	mov    (%eax),%eax
  801b3f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801b42:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b45:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801b4a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801b4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b4f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801b56:	8b 45 08             	mov    0x8(%ebp),%eax
  801b59:	01 c8                	add    %ecx,%eax
  801b5b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801b5d:	39 c2                	cmp    %eax,%edx
  801b5f:	75 09                	jne    801b6a <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801b61:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801b68:	eb 12                	jmp    801b7c <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b6a:	ff 45 e8             	incl   -0x18(%ebp)
  801b6d:	a1 20 30 80 00       	mov    0x803020,%eax
  801b72:	8b 50 74             	mov    0x74(%eax),%edx
  801b75:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b78:	39 c2                	cmp    %eax,%edx
  801b7a:	77 88                	ja     801b04 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801b7c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801b80:	75 14                	jne    801b96 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801b82:	83 ec 04             	sub    $0x4,%esp
  801b85:	68 b8 23 80 00       	push   $0x8023b8
  801b8a:	6a 3a                	push   $0x3a
  801b8c:	68 ac 23 80 00       	push   $0x8023ac
  801b91:	e8 93 fe ff ff       	call   801a29 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801b96:	ff 45 f0             	incl   -0x10(%ebp)
  801b99:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b9c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801b9f:	0f 8c 32 ff ff ff    	jl     801ad7 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801ba5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bac:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801bb3:	eb 26                	jmp    801bdb <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801bb5:	a1 20 30 80 00       	mov    0x803020,%eax
  801bba:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801bc0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801bc3:	89 d0                	mov    %edx,%eax
  801bc5:	01 c0                	add    %eax,%eax
  801bc7:	01 d0                	add    %edx,%eax
  801bc9:	c1 e0 02             	shl    $0x2,%eax
  801bcc:	01 c8                	add    %ecx,%eax
  801bce:	8a 40 04             	mov    0x4(%eax),%al
  801bd1:	3c 01                	cmp    $0x1,%al
  801bd3:	75 03                	jne    801bd8 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801bd5:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bd8:	ff 45 e0             	incl   -0x20(%ebp)
  801bdb:	a1 20 30 80 00       	mov    0x803020,%eax
  801be0:	8b 50 74             	mov    0x74(%eax),%edx
  801be3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801be6:	39 c2                	cmp    %eax,%edx
  801be8:	77 cb                	ja     801bb5 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801bea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bed:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801bf0:	74 14                	je     801c06 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801bf2:	83 ec 04             	sub    $0x4,%esp
  801bf5:	68 0c 24 80 00       	push   $0x80240c
  801bfa:	6a 44                	push   $0x44
  801bfc:	68 ac 23 80 00       	push   $0x8023ac
  801c01:	e8 23 fe ff ff       	call   801a29 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801c06:	90                   	nop
  801c07:	c9                   	leave  
  801c08:	c3                   	ret    
  801c09:	66 90                	xchg   %ax,%ax
  801c0b:	90                   	nop

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
