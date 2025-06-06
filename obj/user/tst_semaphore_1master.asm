
obj/user/tst_semaphore_1master:     file format elf32-i386


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
  800031:	e8 6c 01 00 00       	call   8001a2 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Master program: create the semaphores, run slaves and wait them to finish
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int envID = sys_getenvid();
  80003e:	e8 47 11 00 00       	call   80118a <sys_getenvid>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)

	sys_createSemaphore("cs1", 1);
  800046:	83 ec 08             	sub    $0x8,%esp
  800049:	6a 01                	push   $0x1
  80004b:	68 80 19 80 00       	push   $0x801980
  800050:	e8 5d 13 00 00       	call   8013b2 <sys_createSemaphore>
  800055:	83 c4 10             	add    $0x10,%esp

	sys_createSemaphore("depend1", 0);
  800058:	83 ec 08             	sub    $0x8,%esp
  80005b:	6a 00                	push   $0x0
  80005d:	68 84 19 80 00       	push   $0x801984
  800062:	e8 4b 13 00 00       	call   8013b2 <sys_createSemaphore>
  800067:	83 c4 10             	add    $0x10,%esp

	int id1, id2, id3;
	id1 = sys_create_env("sem1Slave", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80006a:	a1 04 20 80 00       	mov    0x802004,%eax
  80006f:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800075:	a1 04 20 80 00       	mov    0x802004,%eax
  80007a:	8b 40 74             	mov    0x74(%eax),%eax
  80007d:	83 ec 04             	sub    $0x4,%esp
  800080:	52                   	push   %edx
  800081:	50                   	push   %eax
  800082:	68 8c 19 80 00       	push   $0x80198c
  800087:	e8 37 14 00 00       	call   8014c3 <sys_create_env>
  80008c:	83 c4 10             	add    $0x10,%esp
  80008f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	id2 = sys_create_env("sem1Slave", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800092:	a1 04 20 80 00       	mov    0x802004,%eax
  800097:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  80009d:	a1 04 20 80 00       	mov    0x802004,%eax
  8000a2:	8b 40 74             	mov    0x74(%eax),%eax
  8000a5:	83 ec 04             	sub    $0x4,%esp
  8000a8:	52                   	push   %edx
  8000a9:	50                   	push   %eax
  8000aa:	68 8c 19 80 00       	push   $0x80198c
  8000af:	e8 0f 14 00 00       	call   8014c3 <sys_create_env>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
	id3 = sys_create_env("sem1Slave", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000ba:	a1 04 20 80 00       	mov    0x802004,%eax
  8000bf:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8000c5:	a1 04 20 80 00       	mov    0x802004,%eax
  8000ca:	8b 40 74             	mov    0x74(%eax),%eax
  8000cd:	83 ec 04             	sub    $0x4,%esp
  8000d0:	52                   	push   %edx
  8000d1:	50                   	push   %eax
  8000d2:	68 8c 19 80 00       	push   $0x80198c
  8000d7:	e8 e7 13 00 00       	call   8014c3 <sys_create_env>
  8000dc:	83 c4 10             	add    $0x10,%esp
  8000df:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sys_run_env(id1);
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	ff 75 f0             	pushl  -0x10(%ebp)
  8000e8:	e8 f3 13 00 00       	call   8014e0 <sys_run_env>
  8000ed:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id2);
  8000f0:	83 ec 0c             	sub    $0xc,%esp
  8000f3:	ff 75 ec             	pushl  -0x14(%ebp)
  8000f6:	e8 e5 13 00 00       	call   8014e0 <sys_run_env>
  8000fb:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id3);
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	ff 75 e8             	pushl  -0x18(%ebp)
  800104:	e8 d7 13 00 00       	call   8014e0 <sys_run_env>
  800109:	83 c4 10             	add    $0x10,%esp

	sys_waitSemaphore(envID, "depend1") ;
  80010c:	83 ec 08             	sub    $0x8,%esp
  80010f:	68 84 19 80 00       	push   $0x801984
  800114:	ff 75 f4             	pushl  -0xc(%ebp)
  800117:	e8 cf 12 00 00       	call   8013eb <sys_waitSemaphore>
  80011c:	83 c4 10             	add    $0x10,%esp
	sys_waitSemaphore(envID, "depend1") ;
  80011f:	83 ec 08             	sub    $0x8,%esp
  800122:	68 84 19 80 00       	push   $0x801984
  800127:	ff 75 f4             	pushl  -0xc(%ebp)
  80012a:	e8 bc 12 00 00       	call   8013eb <sys_waitSemaphore>
  80012f:	83 c4 10             	add    $0x10,%esp
	sys_waitSemaphore(envID, "depend1") ;
  800132:	83 ec 08             	sub    $0x8,%esp
  800135:	68 84 19 80 00       	push   $0x801984
  80013a:	ff 75 f4             	pushl  -0xc(%ebp)
  80013d:	e8 a9 12 00 00       	call   8013eb <sys_waitSemaphore>
  800142:	83 c4 10             	add    $0x10,%esp

	int sem1val = sys_getSemaphoreValue(envID, "cs1");
  800145:	83 ec 08             	sub    $0x8,%esp
  800148:	68 80 19 80 00       	push   $0x801980
  80014d:	ff 75 f4             	pushl  -0xc(%ebp)
  800150:	e8 79 12 00 00       	call   8013ce <sys_getSemaphoreValue>
  800155:	83 c4 10             	add    $0x10,%esp
  800158:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int sem2val = sys_getSemaphoreValue(envID, "depend1");
  80015b:	83 ec 08             	sub    $0x8,%esp
  80015e:	68 84 19 80 00       	push   $0x801984
  800163:	ff 75 f4             	pushl  -0xc(%ebp)
  800166:	e8 63 12 00 00       	call   8013ce <sys_getSemaphoreValue>
  80016b:	83 c4 10             	add    $0x10,%esp
  80016e:	89 45 e0             	mov    %eax,-0x20(%ebp)
	if (sem2val == 0 && sem1val == 1)
  800171:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800175:	75 18                	jne    80018f <_main+0x157>
  800177:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  80017b:	75 12                	jne    80018f <_main+0x157>
		cprintf("Congratulations!! Test of Semaphores [1] completed successfully!!\n\n\n");
  80017d:	83 ec 0c             	sub    $0xc,%esp
  800180:	68 98 19 80 00       	push   $0x801998
  800185:	e8 ee 01 00 00       	call   800378 <cprintf>
  80018a:	83 c4 10             	add    $0x10,%esp
  80018d:	eb 10                	jmp    80019f <_main+0x167>
	else
		cprintf("Error: wrong semaphore value... please review your semaphore code again...");
  80018f:	83 ec 0c             	sub    $0xc,%esp
  800192:	68 e0 19 80 00       	push   $0x8019e0
  800197:	e8 dc 01 00 00       	call   800378 <cprintf>
  80019c:	83 c4 10             	add    $0x10,%esp

	return;
  80019f:	90                   	nop
}
  8001a0:	c9                   	leave  
  8001a1:	c3                   	ret    

008001a2 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001a2:	55                   	push   %ebp
  8001a3:	89 e5                	mov    %esp,%ebp
  8001a5:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001a8:	e8 f6 0f 00 00       	call   8011a3 <sys_getenvindex>
  8001ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001b3:	89 d0                	mov    %edx,%eax
  8001b5:	01 c0                	add    %eax,%eax
  8001b7:	01 d0                	add    %edx,%eax
  8001b9:	c1 e0 02             	shl    $0x2,%eax
  8001bc:	01 d0                	add    %edx,%eax
  8001be:	c1 e0 06             	shl    $0x6,%eax
  8001c1:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8001c6:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001cb:	a1 04 20 80 00       	mov    0x802004,%eax
  8001d0:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8001d6:	84 c0                	test   %al,%al
  8001d8:	74 0f                	je     8001e9 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8001da:	a1 04 20 80 00       	mov    0x802004,%eax
  8001df:	05 f4 02 00 00       	add    $0x2f4,%eax
  8001e4:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001e9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001ed:	7e 0a                	jle    8001f9 <libmain+0x57>
		binaryname = argv[0];
  8001ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f2:	8b 00                	mov    (%eax),%eax
  8001f4:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8001f9:	83 ec 08             	sub    $0x8,%esp
  8001fc:	ff 75 0c             	pushl  0xc(%ebp)
  8001ff:	ff 75 08             	pushl  0x8(%ebp)
  800202:	e8 31 fe ff ff       	call   800038 <_main>
  800207:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80020a:	e8 2f 11 00 00       	call   80133e <sys_disable_interrupt>
	cprintf("**************************************\n");
  80020f:	83 ec 0c             	sub    $0xc,%esp
  800212:	68 44 1a 80 00       	push   $0x801a44
  800217:	e8 5c 01 00 00       	call   800378 <cprintf>
  80021c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80021f:	a1 04 20 80 00       	mov    0x802004,%eax
  800224:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80022a:	a1 04 20 80 00       	mov    0x802004,%eax
  80022f:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800235:	83 ec 04             	sub    $0x4,%esp
  800238:	52                   	push   %edx
  800239:	50                   	push   %eax
  80023a:	68 6c 1a 80 00       	push   $0x801a6c
  80023f:	e8 34 01 00 00       	call   800378 <cprintf>
  800244:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800247:	a1 04 20 80 00       	mov    0x802004,%eax
  80024c:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800252:	83 ec 08             	sub    $0x8,%esp
  800255:	50                   	push   %eax
  800256:	68 91 1a 80 00       	push   $0x801a91
  80025b:	e8 18 01 00 00       	call   800378 <cprintf>
  800260:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800263:	83 ec 0c             	sub    $0xc,%esp
  800266:	68 44 1a 80 00       	push   $0x801a44
  80026b:	e8 08 01 00 00       	call   800378 <cprintf>
  800270:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800273:	e8 e0 10 00 00       	call   801358 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800278:	e8 19 00 00 00       	call   800296 <exit>
}
  80027d:	90                   	nop
  80027e:	c9                   	leave  
  80027f:	c3                   	ret    

00800280 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800280:	55                   	push   %ebp
  800281:	89 e5                	mov    %esp,%ebp
  800283:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800286:	83 ec 0c             	sub    $0xc,%esp
  800289:	6a 00                	push   $0x0
  80028b:	e8 df 0e 00 00       	call   80116f <sys_env_destroy>
  800290:	83 c4 10             	add    $0x10,%esp
}
  800293:	90                   	nop
  800294:	c9                   	leave  
  800295:	c3                   	ret    

00800296 <exit>:

void
exit(void)
{
  800296:	55                   	push   %ebp
  800297:	89 e5                	mov    %esp,%ebp
  800299:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80029c:	e8 34 0f 00 00       	call   8011d5 <sys_env_exit>
}
  8002a1:	90                   	nop
  8002a2:	c9                   	leave  
  8002a3:	c3                   	ret    

008002a4 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8002a4:	55                   	push   %ebp
  8002a5:	89 e5                	mov    %esp,%ebp
  8002a7:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8002aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ad:	8b 00                	mov    (%eax),%eax
  8002af:	8d 48 01             	lea    0x1(%eax),%ecx
  8002b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002b5:	89 0a                	mov    %ecx,(%edx)
  8002b7:	8b 55 08             	mov    0x8(%ebp),%edx
  8002ba:	88 d1                	mov    %dl,%cl
  8002bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002bf:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8002c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c6:	8b 00                	mov    (%eax),%eax
  8002c8:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002cd:	75 2c                	jne    8002fb <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8002cf:	a0 08 20 80 00       	mov    0x802008,%al
  8002d4:	0f b6 c0             	movzbl %al,%eax
  8002d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002da:	8b 12                	mov    (%edx),%edx
  8002dc:	89 d1                	mov    %edx,%ecx
  8002de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002e1:	83 c2 08             	add    $0x8,%edx
  8002e4:	83 ec 04             	sub    $0x4,%esp
  8002e7:	50                   	push   %eax
  8002e8:	51                   	push   %ecx
  8002e9:	52                   	push   %edx
  8002ea:	e8 3e 0e 00 00       	call   80112d <sys_cputs>
  8002ef:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002fe:	8b 40 04             	mov    0x4(%eax),%eax
  800301:	8d 50 01             	lea    0x1(%eax),%edx
  800304:	8b 45 0c             	mov    0xc(%ebp),%eax
  800307:	89 50 04             	mov    %edx,0x4(%eax)
}
  80030a:	90                   	nop
  80030b:	c9                   	leave  
  80030c:	c3                   	ret    

0080030d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80030d:	55                   	push   %ebp
  80030e:	89 e5                	mov    %esp,%ebp
  800310:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800316:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80031d:	00 00 00 
	b.cnt = 0;
  800320:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800327:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80032a:	ff 75 0c             	pushl  0xc(%ebp)
  80032d:	ff 75 08             	pushl  0x8(%ebp)
  800330:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800336:	50                   	push   %eax
  800337:	68 a4 02 80 00       	push   $0x8002a4
  80033c:	e8 11 02 00 00       	call   800552 <vprintfmt>
  800341:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800344:	a0 08 20 80 00       	mov    0x802008,%al
  800349:	0f b6 c0             	movzbl %al,%eax
  80034c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800352:	83 ec 04             	sub    $0x4,%esp
  800355:	50                   	push   %eax
  800356:	52                   	push   %edx
  800357:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80035d:	83 c0 08             	add    $0x8,%eax
  800360:	50                   	push   %eax
  800361:	e8 c7 0d 00 00       	call   80112d <sys_cputs>
  800366:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800369:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800370:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800376:	c9                   	leave  
  800377:	c3                   	ret    

00800378 <cprintf>:

int cprintf(const char *fmt, ...) {
  800378:	55                   	push   %ebp
  800379:	89 e5                	mov    %esp,%ebp
  80037b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80037e:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  800385:	8d 45 0c             	lea    0xc(%ebp),%eax
  800388:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80038b:	8b 45 08             	mov    0x8(%ebp),%eax
  80038e:	83 ec 08             	sub    $0x8,%esp
  800391:	ff 75 f4             	pushl  -0xc(%ebp)
  800394:	50                   	push   %eax
  800395:	e8 73 ff ff ff       	call   80030d <vcprintf>
  80039a:	83 c4 10             	add    $0x10,%esp
  80039d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8003a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003a3:	c9                   	leave  
  8003a4:	c3                   	ret    

008003a5 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8003a5:	55                   	push   %ebp
  8003a6:	89 e5                	mov    %esp,%ebp
  8003a8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8003ab:	e8 8e 0f 00 00       	call   80133e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8003b0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b9:	83 ec 08             	sub    $0x8,%esp
  8003bc:	ff 75 f4             	pushl  -0xc(%ebp)
  8003bf:	50                   	push   %eax
  8003c0:	e8 48 ff ff ff       	call   80030d <vcprintf>
  8003c5:	83 c4 10             	add    $0x10,%esp
  8003c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8003cb:	e8 88 0f 00 00       	call   801358 <sys_enable_interrupt>
	return cnt;
  8003d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003d3:	c9                   	leave  
  8003d4:	c3                   	ret    

008003d5 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8003d5:	55                   	push   %ebp
  8003d6:	89 e5                	mov    %esp,%ebp
  8003d8:	53                   	push   %ebx
  8003d9:	83 ec 14             	sub    $0x14,%esp
  8003dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8003df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8003e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8003e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003e8:	8b 45 18             	mov    0x18(%ebp),%eax
  8003eb:	ba 00 00 00 00       	mov    $0x0,%edx
  8003f0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003f3:	77 55                	ja     80044a <printnum+0x75>
  8003f5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003f8:	72 05                	jb     8003ff <printnum+0x2a>
  8003fa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003fd:	77 4b                	ja     80044a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003ff:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800402:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800405:	8b 45 18             	mov    0x18(%ebp),%eax
  800408:	ba 00 00 00 00       	mov    $0x0,%edx
  80040d:	52                   	push   %edx
  80040e:	50                   	push   %eax
  80040f:	ff 75 f4             	pushl  -0xc(%ebp)
  800412:	ff 75 f0             	pushl  -0x10(%ebp)
  800415:	e8 02 13 00 00       	call   80171c <__udivdi3>
  80041a:	83 c4 10             	add    $0x10,%esp
  80041d:	83 ec 04             	sub    $0x4,%esp
  800420:	ff 75 20             	pushl  0x20(%ebp)
  800423:	53                   	push   %ebx
  800424:	ff 75 18             	pushl  0x18(%ebp)
  800427:	52                   	push   %edx
  800428:	50                   	push   %eax
  800429:	ff 75 0c             	pushl  0xc(%ebp)
  80042c:	ff 75 08             	pushl  0x8(%ebp)
  80042f:	e8 a1 ff ff ff       	call   8003d5 <printnum>
  800434:	83 c4 20             	add    $0x20,%esp
  800437:	eb 1a                	jmp    800453 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800439:	83 ec 08             	sub    $0x8,%esp
  80043c:	ff 75 0c             	pushl  0xc(%ebp)
  80043f:	ff 75 20             	pushl  0x20(%ebp)
  800442:	8b 45 08             	mov    0x8(%ebp),%eax
  800445:	ff d0                	call   *%eax
  800447:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80044a:	ff 4d 1c             	decl   0x1c(%ebp)
  80044d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800451:	7f e6                	jg     800439 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800453:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800456:	bb 00 00 00 00       	mov    $0x0,%ebx
  80045b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80045e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800461:	53                   	push   %ebx
  800462:	51                   	push   %ecx
  800463:	52                   	push   %edx
  800464:	50                   	push   %eax
  800465:	e8 c2 13 00 00       	call   80182c <__umoddi3>
  80046a:	83 c4 10             	add    $0x10,%esp
  80046d:	05 d4 1c 80 00       	add    $0x801cd4,%eax
  800472:	8a 00                	mov    (%eax),%al
  800474:	0f be c0             	movsbl %al,%eax
  800477:	83 ec 08             	sub    $0x8,%esp
  80047a:	ff 75 0c             	pushl  0xc(%ebp)
  80047d:	50                   	push   %eax
  80047e:	8b 45 08             	mov    0x8(%ebp),%eax
  800481:	ff d0                	call   *%eax
  800483:	83 c4 10             	add    $0x10,%esp
}
  800486:	90                   	nop
  800487:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80048a:	c9                   	leave  
  80048b:	c3                   	ret    

0080048c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80048c:	55                   	push   %ebp
  80048d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80048f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800493:	7e 1c                	jle    8004b1 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800495:	8b 45 08             	mov    0x8(%ebp),%eax
  800498:	8b 00                	mov    (%eax),%eax
  80049a:	8d 50 08             	lea    0x8(%eax),%edx
  80049d:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a0:	89 10                	mov    %edx,(%eax)
  8004a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a5:	8b 00                	mov    (%eax),%eax
  8004a7:	83 e8 08             	sub    $0x8,%eax
  8004aa:	8b 50 04             	mov    0x4(%eax),%edx
  8004ad:	8b 00                	mov    (%eax),%eax
  8004af:	eb 40                	jmp    8004f1 <getuint+0x65>
	else if (lflag)
  8004b1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004b5:	74 1e                	je     8004d5 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8004b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ba:	8b 00                	mov    (%eax),%eax
  8004bc:	8d 50 04             	lea    0x4(%eax),%edx
  8004bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c2:	89 10                	mov    %edx,(%eax)
  8004c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c7:	8b 00                	mov    (%eax),%eax
  8004c9:	83 e8 04             	sub    $0x4,%eax
  8004cc:	8b 00                	mov    (%eax),%eax
  8004ce:	ba 00 00 00 00       	mov    $0x0,%edx
  8004d3:	eb 1c                	jmp    8004f1 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8004d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d8:	8b 00                	mov    (%eax),%eax
  8004da:	8d 50 04             	lea    0x4(%eax),%edx
  8004dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e0:	89 10                	mov    %edx,(%eax)
  8004e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e5:	8b 00                	mov    (%eax),%eax
  8004e7:	83 e8 04             	sub    $0x4,%eax
  8004ea:	8b 00                	mov    (%eax),%eax
  8004ec:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004f1:	5d                   	pop    %ebp
  8004f2:	c3                   	ret    

008004f3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004f3:	55                   	push   %ebp
  8004f4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004f6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004fa:	7e 1c                	jle    800518 <getint+0x25>
		return va_arg(*ap, long long);
  8004fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ff:	8b 00                	mov    (%eax),%eax
  800501:	8d 50 08             	lea    0x8(%eax),%edx
  800504:	8b 45 08             	mov    0x8(%ebp),%eax
  800507:	89 10                	mov    %edx,(%eax)
  800509:	8b 45 08             	mov    0x8(%ebp),%eax
  80050c:	8b 00                	mov    (%eax),%eax
  80050e:	83 e8 08             	sub    $0x8,%eax
  800511:	8b 50 04             	mov    0x4(%eax),%edx
  800514:	8b 00                	mov    (%eax),%eax
  800516:	eb 38                	jmp    800550 <getint+0x5d>
	else if (lflag)
  800518:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80051c:	74 1a                	je     800538 <getint+0x45>
		return va_arg(*ap, long);
  80051e:	8b 45 08             	mov    0x8(%ebp),%eax
  800521:	8b 00                	mov    (%eax),%eax
  800523:	8d 50 04             	lea    0x4(%eax),%edx
  800526:	8b 45 08             	mov    0x8(%ebp),%eax
  800529:	89 10                	mov    %edx,(%eax)
  80052b:	8b 45 08             	mov    0x8(%ebp),%eax
  80052e:	8b 00                	mov    (%eax),%eax
  800530:	83 e8 04             	sub    $0x4,%eax
  800533:	8b 00                	mov    (%eax),%eax
  800535:	99                   	cltd   
  800536:	eb 18                	jmp    800550 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800538:	8b 45 08             	mov    0x8(%ebp),%eax
  80053b:	8b 00                	mov    (%eax),%eax
  80053d:	8d 50 04             	lea    0x4(%eax),%edx
  800540:	8b 45 08             	mov    0x8(%ebp),%eax
  800543:	89 10                	mov    %edx,(%eax)
  800545:	8b 45 08             	mov    0x8(%ebp),%eax
  800548:	8b 00                	mov    (%eax),%eax
  80054a:	83 e8 04             	sub    $0x4,%eax
  80054d:	8b 00                	mov    (%eax),%eax
  80054f:	99                   	cltd   
}
  800550:	5d                   	pop    %ebp
  800551:	c3                   	ret    

00800552 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800552:	55                   	push   %ebp
  800553:	89 e5                	mov    %esp,%ebp
  800555:	56                   	push   %esi
  800556:	53                   	push   %ebx
  800557:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80055a:	eb 17                	jmp    800573 <vprintfmt+0x21>
			if (ch == '\0')
  80055c:	85 db                	test   %ebx,%ebx
  80055e:	0f 84 af 03 00 00    	je     800913 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800564:	83 ec 08             	sub    $0x8,%esp
  800567:	ff 75 0c             	pushl  0xc(%ebp)
  80056a:	53                   	push   %ebx
  80056b:	8b 45 08             	mov    0x8(%ebp),%eax
  80056e:	ff d0                	call   *%eax
  800570:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800573:	8b 45 10             	mov    0x10(%ebp),%eax
  800576:	8d 50 01             	lea    0x1(%eax),%edx
  800579:	89 55 10             	mov    %edx,0x10(%ebp)
  80057c:	8a 00                	mov    (%eax),%al
  80057e:	0f b6 d8             	movzbl %al,%ebx
  800581:	83 fb 25             	cmp    $0x25,%ebx
  800584:	75 d6                	jne    80055c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800586:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80058a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800591:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800598:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80059f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8005a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8005a9:	8d 50 01             	lea    0x1(%eax),%edx
  8005ac:	89 55 10             	mov    %edx,0x10(%ebp)
  8005af:	8a 00                	mov    (%eax),%al
  8005b1:	0f b6 d8             	movzbl %al,%ebx
  8005b4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8005b7:	83 f8 55             	cmp    $0x55,%eax
  8005ba:	0f 87 2b 03 00 00    	ja     8008eb <vprintfmt+0x399>
  8005c0:	8b 04 85 f8 1c 80 00 	mov    0x801cf8(,%eax,4),%eax
  8005c7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8005c9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8005cd:	eb d7                	jmp    8005a6 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8005cf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8005d3:	eb d1                	jmp    8005a6 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005d5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8005dc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005df:	89 d0                	mov    %edx,%eax
  8005e1:	c1 e0 02             	shl    $0x2,%eax
  8005e4:	01 d0                	add    %edx,%eax
  8005e6:	01 c0                	add    %eax,%eax
  8005e8:	01 d8                	add    %ebx,%eax
  8005ea:	83 e8 30             	sub    $0x30,%eax
  8005ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8005f3:	8a 00                	mov    (%eax),%al
  8005f5:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8005f8:	83 fb 2f             	cmp    $0x2f,%ebx
  8005fb:	7e 3e                	jle    80063b <vprintfmt+0xe9>
  8005fd:	83 fb 39             	cmp    $0x39,%ebx
  800600:	7f 39                	jg     80063b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800602:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800605:	eb d5                	jmp    8005dc <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800607:	8b 45 14             	mov    0x14(%ebp),%eax
  80060a:	83 c0 04             	add    $0x4,%eax
  80060d:	89 45 14             	mov    %eax,0x14(%ebp)
  800610:	8b 45 14             	mov    0x14(%ebp),%eax
  800613:	83 e8 04             	sub    $0x4,%eax
  800616:	8b 00                	mov    (%eax),%eax
  800618:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80061b:	eb 1f                	jmp    80063c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80061d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800621:	79 83                	jns    8005a6 <vprintfmt+0x54>
				width = 0;
  800623:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80062a:	e9 77 ff ff ff       	jmp    8005a6 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80062f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800636:	e9 6b ff ff ff       	jmp    8005a6 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80063b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80063c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800640:	0f 89 60 ff ff ff    	jns    8005a6 <vprintfmt+0x54>
				width = precision, precision = -1;
  800646:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800649:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80064c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800653:	e9 4e ff ff ff       	jmp    8005a6 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800658:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80065b:	e9 46 ff ff ff       	jmp    8005a6 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800660:	8b 45 14             	mov    0x14(%ebp),%eax
  800663:	83 c0 04             	add    $0x4,%eax
  800666:	89 45 14             	mov    %eax,0x14(%ebp)
  800669:	8b 45 14             	mov    0x14(%ebp),%eax
  80066c:	83 e8 04             	sub    $0x4,%eax
  80066f:	8b 00                	mov    (%eax),%eax
  800671:	83 ec 08             	sub    $0x8,%esp
  800674:	ff 75 0c             	pushl  0xc(%ebp)
  800677:	50                   	push   %eax
  800678:	8b 45 08             	mov    0x8(%ebp),%eax
  80067b:	ff d0                	call   *%eax
  80067d:	83 c4 10             	add    $0x10,%esp
			break;
  800680:	e9 89 02 00 00       	jmp    80090e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800685:	8b 45 14             	mov    0x14(%ebp),%eax
  800688:	83 c0 04             	add    $0x4,%eax
  80068b:	89 45 14             	mov    %eax,0x14(%ebp)
  80068e:	8b 45 14             	mov    0x14(%ebp),%eax
  800691:	83 e8 04             	sub    $0x4,%eax
  800694:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800696:	85 db                	test   %ebx,%ebx
  800698:	79 02                	jns    80069c <vprintfmt+0x14a>
				err = -err;
  80069a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80069c:	83 fb 64             	cmp    $0x64,%ebx
  80069f:	7f 0b                	jg     8006ac <vprintfmt+0x15a>
  8006a1:	8b 34 9d 40 1b 80 00 	mov    0x801b40(,%ebx,4),%esi
  8006a8:	85 f6                	test   %esi,%esi
  8006aa:	75 19                	jne    8006c5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8006ac:	53                   	push   %ebx
  8006ad:	68 e5 1c 80 00       	push   $0x801ce5
  8006b2:	ff 75 0c             	pushl  0xc(%ebp)
  8006b5:	ff 75 08             	pushl  0x8(%ebp)
  8006b8:	e8 5e 02 00 00       	call   80091b <printfmt>
  8006bd:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8006c0:	e9 49 02 00 00       	jmp    80090e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8006c5:	56                   	push   %esi
  8006c6:	68 ee 1c 80 00       	push   $0x801cee
  8006cb:	ff 75 0c             	pushl  0xc(%ebp)
  8006ce:	ff 75 08             	pushl  0x8(%ebp)
  8006d1:	e8 45 02 00 00       	call   80091b <printfmt>
  8006d6:	83 c4 10             	add    $0x10,%esp
			break;
  8006d9:	e9 30 02 00 00       	jmp    80090e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8006de:	8b 45 14             	mov    0x14(%ebp),%eax
  8006e1:	83 c0 04             	add    $0x4,%eax
  8006e4:	89 45 14             	mov    %eax,0x14(%ebp)
  8006e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ea:	83 e8 04             	sub    $0x4,%eax
  8006ed:	8b 30                	mov    (%eax),%esi
  8006ef:	85 f6                	test   %esi,%esi
  8006f1:	75 05                	jne    8006f8 <vprintfmt+0x1a6>
				p = "(null)";
  8006f3:	be f1 1c 80 00       	mov    $0x801cf1,%esi
			if (width > 0 && padc != '-')
  8006f8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006fc:	7e 6d                	jle    80076b <vprintfmt+0x219>
  8006fe:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800702:	74 67                	je     80076b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800704:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800707:	83 ec 08             	sub    $0x8,%esp
  80070a:	50                   	push   %eax
  80070b:	56                   	push   %esi
  80070c:	e8 0c 03 00 00       	call   800a1d <strnlen>
  800711:	83 c4 10             	add    $0x10,%esp
  800714:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800717:	eb 16                	jmp    80072f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800719:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80071d:	83 ec 08             	sub    $0x8,%esp
  800720:	ff 75 0c             	pushl  0xc(%ebp)
  800723:	50                   	push   %eax
  800724:	8b 45 08             	mov    0x8(%ebp),%eax
  800727:	ff d0                	call   *%eax
  800729:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80072c:	ff 4d e4             	decl   -0x1c(%ebp)
  80072f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800733:	7f e4                	jg     800719 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800735:	eb 34                	jmp    80076b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800737:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80073b:	74 1c                	je     800759 <vprintfmt+0x207>
  80073d:	83 fb 1f             	cmp    $0x1f,%ebx
  800740:	7e 05                	jle    800747 <vprintfmt+0x1f5>
  800742:	83 fb 7e             	cmp    $0x7e,%ebx
  800745:	7e 12                	jle    800759 <vprintfmt+0x207>
					putch('?', putdat);
  800747:	83 ec 08             	sub    $0x8,%esp
  80074a:	ff 75 0c             	pushl  0xc(%ebp)
  80074d:	6a 3f                	push   $0x3f
  80074f:	8b 45 08             	mov    0x8(%ebp),%eax
  800752:	ff d0                	call   *%eax
  800754:	83 c4 10             	add    $0x10,%esp
  800757:	eb 0f                	jmp    800768 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800759:	83 ec 08             	sub    $0x8,%esp
  80075c:	ff 75 0c             	pushl  0xc(%ebp)
  80075f:	53                   	push   %ebx
  800760:	8b 45 08             	mov    0x8(%ebp),%eax
  800763:	ff d0                	call   *%eax
  800765:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800768:	ff 4d e4             	decl   -0x1c(%ebp)
  80076b:	89 f0                	mov    %esi,%eax
  80076d:	8d 70 01             	lea    0x1(%eax),%esi
  800770:	8a 00                	mov    (%eax),%al
  800772:	0f be d8             	movsbl %al,%ebx
  800775:	85 db                	test   %ebx,%ebx
  800777:	74 24                	je     80079d <vprintfmt+0x24b>
  800779:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80077d:	78 b8                	js     800737 <vprintfmt+0x1e5>
  80077f:	ff 4d e0             	decl   -0x20(%ebp)
  800782:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800786:	79 af                	jns    800737 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800788:	eb 13                	jmp    80079d <vprintfmt+0x24b>
				putch(' ', putdat);
  80078a:	83 ec 08             	sub    $0x8,%esp
  80078d:	ff 75 0c             	pushl  0xc(%ebp)
  800790:	6a 20                	push   $0x20
  800792:	8b 45 08             	mov    0x8(%ebp),%eax
  800795:	ff d0                	call   *%eax
  800797:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80079a:	ff 4d e4             	decl   -0x1c(%ebp)
  80079d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007a1:	7f e7                	jg     80078a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8007a3:	e9 66 01 00 00       	jmp    80090e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8007a8:	83 ec 08             	sub    $0x8,%esp
  8007ab:	ff 75 e8             	pushl  -0x18(%ebp)
  8007ae:	8d 45 14             	lea    0x14(%ebp),%eax
  8007b1:	50                   	push   %eax
  8007b2:	e8 3c fd ff ff       	call   8004f3 <getint>
  8007b7:	83 c4 10             	add    $0x10,%esp
  8007ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007bd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8007c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007c6:	85 d2                	test   %edx,%edx
  8007c8:	79 23                	jns    8007ed <vprintfmt+0x29b>
				putch('-', putdat);
  8007ca:	83 ec 08             	sub    $0x8,%esp
  8007cd:	ff 75 0c             	pushl  0xc(%ebp)
  8007d0:	6a 2d                	push   $0x2d
  8007d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d5:	ff d0                	call   *%eax
  8007d7:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8007da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007e0:	f7 d8                	neg    %eax
  8007e2:	83 d2 00             	adc    $0x0,%edx
  8007e5:	f7 da                	neg    %edx
  8007e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007ed:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007f4:	e9 bc 00 00 00       	jmp    8008b5 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8007f9:	83 ec 08             	sub    $0x8,%esp
  8007fc:	ff 75 e8             	pushl  -0x18(%ebp)
  8007ff:	8d 45 14             	lea    0x14(%ebp),%eax
  800802:	50                   	push   %eax
  800803:	e8 84 fc ff ff       	call   80048c <getuint>
  800808:	83 c4 10             	add    $0x10,%esp
  80080b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80080e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800811:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800818:	e9 98 00 00 00       	jmp    8008b5 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80081d:	83 ec 08             	sub    $0x8,%esp
  800820:	ff 75 0c             	pushl  0xc(%ebp)
  800823:	6a 58                	push   $0x58
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	ff d0                	call   *%eax
  80082a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80082d:	83 ec 08             	sub    $0x8,%esp
  800830:	ff 75 0c             	pushl  0xc(%ebp)
  800833:	6a 58                	push   $0x58
  800835:	8b 45 08             	mov    0x8(%ebp),%eax
  800838:	ff d0                	call   *%eax
  80083a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80083d:	83 ec 08             	sub    $0x8,%esp
  800840:	ff 75 0c             	pushl  0xc(%ebp)
  800843:	6a 58                	push   $0x58
  800845:	8b 45 08             	mov    0x8(%ebp),%eax
  800848:	ff d0                	call   *%eax
  80084a:	83 c4 10             	add    $0x10,%esp
			break;
  80084d:	e9 bc 00 00 00       	jmp    80090e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800852:	83 ec 08             	sub    $0x8,%esp
  800855:	ff 75 0c             	pushl  0xc(%ebp)
  800858:	6a 30                	push   $0x30
  80085a:	8b 45 08             	mov    0x8(%ebp),%eax
  80085d:	ff d0                	call   *%eax
  80085f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800862:	83 ec 08             	sub    $0x8,%esp
  800865:	ff 75 0c             	pushl  0xc(%ebp)
  800868:	6a 78                	push   $0x78
  80086a:	8b 45 08             	mov    0x8(%ebp),%eax
  80086d:	ff d0                	call   *%eax
  80086f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800872:	8b 45 14             	mov    0x14(%ebp),%eax
  800875:	83 c0 04             	add    $0x4,%eax
  800878:	89 45 14             	mov    %eax,0x14(%ebp)
  80087b:	8b 45 14             	mov    0x14(%ebp),%eax
  80087e:	83 e8 04             	sub    $0x4,%eax
  800881:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800883:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800886:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80088d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800894:	eb 1f                	jmp    8008b5 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800896:	83 ec 08             	sub    $0x8,%esp
  800899:	ff 75 e8             	pushl  -0x18(%ebp)
  80089c:	8d 45 14             	lea    0x14(%ebp),%eax
  80089f:	50                   	push   %eax
  8008a0:	e8 e7 fb ff ff       	call   80048c <getuint>
  8008a5:	83 c4 10             	add    $0x10,%esp
  8008a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008ab:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8008ae:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8008b5:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8008b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008bc:	83 ec 04             	sub    $0x4,%esp
  8008bf:	52                   	push   %edx
  8008c0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8008c3:	50                   	push   %eax
  8008c4:	ff 75 f4             	pushl  -0xc(%ebp)
  8008c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8008ca:	ff 75 0c             	pushl  0xc(%ebp)
  8008cd:	ff 75 08             	pushl  0x8(%ebp)
  8008d0:	e8 00 fb ff ff       	call   8003d5 <printnum>
  8008d5:	83 c4 20             	add    $0x20,%esp
			break;
  8008d8:	eb 34                	jmp    80090e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8008da:	83 ec 08             	sub    $0x8,%esp
  8008dd:	ff 75 0c             	pushl  0xc(%ebp)
  8008e0:	53                   	push   %ebx
  8008e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e4:	ff d0                	call   *%eax
  8008e6:	83 c4 10             	add    $0x10,%esp
			break;
  8008e9:	eb 23                	jmp    80090e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008eb:	83 ec 08             	sub    $0x8,%esp
  8008ee:	ff 75 0c             	pushl  0xc(%ebp)
  8008f1:	6a 25                	push   $0x25
  8008f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f6:	ff d0                	call   *%eax
  8008f8:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008fb:	ff 4d 10             	decl   0x10(%ebp)
  8008fe:	eb 03                	jmp    800903 <vprintfmt+0x3b1>
  800900:	ff 4d 10             	decl   0x10(%ebp)
  800903:	8b 45 10             	mov    0x10(%ebp),%eax
  800906:	48                   	dec    %eax
  800907:	8a 00                	mov    (%eax),%al
  800909:	3c 25                	cmp    $0x25,%al
  80090b:	75 f3                	jne    800900 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80090d:	90                   	nop
		}
	}
  80090e:	e9 47 fc ff ff       	jmp    80055a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800913:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800914:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800917:	5b                   	pop    %ebx
  800918:	5e                   	pop    %esi
  800919:	5d                   	pop    %ebp
  80091a:	c3                   	ret    

0080091b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80091b:	55                   	push   %ebp
  80091c:	89 e5                	mov    %esp,%ebp
  80091e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800921:	8d 45 10             	lea    0x10(%ebp),%eax
  800924:	83 c0 04             	add    $0x4,%eax
  800927:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80092a:	8b 45 10             	mov    0x10(%ebp),%eax
  80092d:	ff 75 f4             	pushl  -0xc(%ebp)
  800930:	50                   	push   %eax
  800931:	ff 75 0c             	pushl  0xc(%ebp)
  800934:	ff 75 08             	pushl  0x8(%ebp)
  800937:	e8 16 fc ff ff       	call   800552 <vprintfmt>
  80093c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80093f:	90                   	nop
  800940:	c9                   	leave  
  800941:	c3                   	ret    

00800942 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800942:	55                   	push   %ebp
  800943:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800945:	8b 45 0c             	mov    0xc(%ebp),%eax
  800948:	8b 40 08             	mov    0x8(%eax),%eax
  80094b:	8d 50 01             	lea    0x1(%eax),%edx
  80094e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800951:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800954:	8b 45 0c             	mov    0xc(%ebp),%eax
  800957:	8b 10                	mov    (%eax),%edx
  800959:	8b 45 0c             	mov    0xc(%ebp),%eax
  80095c:	8b 40 04             	mov    0x4(%eax),%eax
  80095f:	39 c2                	cmp    %eax,%edx
  800961:	73 12                	jae    800975 <sprintputch+0x33>
		*b->buf++ = ch;
  800963:	8b 45 0c             	mov    0xc(%ebp),%eax
  800966:	8b 00                	mov    (%eax),%eax
  800968:	8d 48 01             	lea    0x1(%eax),%ecx
  80096b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096e:	89 0a                	mov    %ecx,(%edx)
  800970:	8b 55 08             	mov    0x8(%ebp),%edx
  800973:	88 10                	mov    %dl,(%eax)
}
  800975:	90                   	nop
  800976:	5d                   	pop    %ebp
  800977:	c3                   	ret    

00800978 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800978:	55                   	push   %ebp
  800979:	89 e5                	mov    %esp,%ebp
  80097b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80097e:	8b 45 08             	mov    0x8(%ebp),%eax
  800981:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800984:	8b 45 0c             	mov    0xc(%ebp),%eax
  800987:	8d 50 ff             	lea    -0x1(%eax),%edx
  80098a:	8b 45 08             	mov    0x8(%ebp),%eax
  80098d:	01 d0                	add    %edx,%eax
  80098f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800992:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800999:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80099d:	74 06                	je     8009a5 <vsnprintf+0x2d>
  80099f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009a3:	7f 07                	jg     8009ac <vsnprintf+0x34>
		return -E_INVAL;
  8009a5:	b8 03 00 00 00       	mov    $0x3,%eax
  8009aa:	eb 20                	jmp    8009cc <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8009ac:	ff 75 14             	pushl  0x14(%ebp)
  8009af:	ff 75 10             	pushl  0x10(%ebp)
  8009b2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8009b5:	50                   	push   %eax
  8009b6:	68 42 09 80 00       	push   $0x800942
  8009bb:	e8 92 fb ff ff       	call   800552 <vprintfmt>
  8009c0:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8009c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009c6:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8009c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8009cc:	c9                   	leave  
  8009cd:	c3                   	ret    

008009ce <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8009ce:	55                   	push   %ebp
  8009cf:	89 e5                	mov    %esp,%ebp
  8009d1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8009d4:	8d 45 10             	lea    0x10(%ebp),%eax
  8009d7:	83 c0 04             	add    $0x4,%eax
  8009da:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8009dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8009e0:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e3:	50                   	push   %eax
  8009e4:	ff 75 0c             	pushl  0xc(%ebp)
  8009e7:	ff 75 08             	pushl  0x8(%ebp)
  8009ea:	e8 89 ff ff ff       	call   800978 <vsnprintf>
  8009ef:	83 c4 10             	add    $0x10,%esp
  8009f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009f8:	c9                   	leave  
  8009f9:	c3                   	ret    

008009fa <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8009fa:	55                   	push   %ebp
  8009fb:	89 e5                	mov    %esp,%ebp
  8009fd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a00:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a07:	eb 06                	jmp    800a0f <strlen+0x15>
		n++;
  800a09:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a0c:	ff 45 08             	incl   0x8(%ebp)
  800a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a12:	8a 00                	mov    (%eax),%al
  800a14:	84 c0                	test   %al,%al
  800a16:	75 f1                	jne    800a09 <strlen+0xf>
		n++;
	return n;
  800a18:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a1b:	c9                   	leave  
  800a1c:	c3                   	ret    

00800a1d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800a1d:	55                   	push   %ebp
  800a1e:	89 e5                	mov    %esp,%ebp
  800a20:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a23:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a2a:	eb 09                	jmp    800a35 <strnlen+0x18>
		n++;
  800a2c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a2f:	ff 45 08             	incl   0x8(%ebp)
  800a32:	ff 4d 0c             	decl   0xc(%ebp)
  800a35:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a39:	74 09                	je     800a44 <strnlen+0x27>
  800a3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3e:	8a 00                	mov    (%eax),%al
  800a40:	84 c0                	test   %al,%al
  800a42:	75 e8                	jne    800a2c <strnlen+0xf>
		n++;
	return n;
  800a44:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a47:	c9                   	leave  
  800a48:	c3                   	ret    

00800a49 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a49:	55                   	push   %ebp
  800a4a:	89 e5                	mov    %esp,%ebp
  800a4c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a52:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a55:	90                   	nop
  800a56:	8b 45 08             	mov    0x8(%ebp),%eax
  800a59:	8d 50 01             	lea    0x1(%eax),%edx
  800a5c:	89 55 08             	mov    %edx,0x8(%ebp)
  800a5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a62:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a65:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a68:	8a 12                	mov    (%edx),%dl
  800a6a:	88 10                	mov    %dl,(%eax)
  800a6c:	8a 00                	mov    (%eax),%al
  800a6e:	84 c0                	test   %al,%al
  800a70:	75 e4                	jne    800a56 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a72:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a75:	c9                   	leave  
  800a76:	c3                   	ret    

00800a77 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a77:	55                   	push   %ebp
  800a78:	89 e5                	mov    %esp,%ebp
  800a7a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a80:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a83:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a8a:	eb 1f                	jmp    800aab <strncpy+0x34>
		*dst++ = *src;
  800a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8f:	8d 50 01             	lea    0x1(%eax),%edx
  800a92:	89 55 08             	mov    %edx,0x8(%ebp)
  800a95:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a98:	8a 12                	mov    (%edx),%dl
  800a9a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9f:	8a 00                	mov    (%eax),%al
  800aa1:	84 c0                	test   %al,%al
  800aa3:	74 03                	je     800aa8 <strncpy+0x31>
			src++;
  800aa5:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800aa8:	ff 45 fc             	incl   -0x4(%ebp)
  800aab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800aae:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ab1:	72 d9                	jb     800a8c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ab3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ab6:	c9                   	leave  
  800ab7:	c3                   	ret    

00800ab8 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ab8:	55                   	push   %ebp
  800ab9:	89 e5                	mov    %esp,%ebp
  800abb:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800abe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ac4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ac8:	74 30                	je     800afa <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800aca:	eb 16                	jmp    800ae2 <strlcpy+0x2a>
			*dst++ = *src++;
  800acc:	8b 45 08             	mov    0x8(%ebp),%eax
  800acf:	8d 50 01             	lea    0x1(%eax),%edx
  800ad2:	89 55 08             	mov    %edx,0x8(%ebp)
  800ad5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ad8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800adb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ade:	8a 12                	mov    (%edx),%dl
  800ae0:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ae2:	ff 4d 10             	decl   0x10(%ebp)
  800ae5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ae9:	74 09                	je     800af4 <strlcpy+0x3c>
  800aeb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aee:	8a 00                	mov    (%eax),%al
  800af0:	84 c0                	test   %al,%al
  800af2:	75 d8                	jne    800acc <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800af4:	8b 45 08             	mov    0x8(%ebp),%eax
  800af7:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800afa:	8b 55 08             	mov    0x8(%ebp),%edx
  800afd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b00:	29 c2                	sub    %eax,%edx
  800b02:	89 d0                	mov    %edx,%eax
}
  800b04:	c9                   	leave  
  800b05:	c3                   	ret    

00800b06 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b06:	55                   	push   %ebp
  800b07:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b09:	eb 06                	jmp    800b11 <strcmp+0xb>
		p++, q++;
  800b0b:	ff 45 08             	incl   0x8(%ebp)
  800b0e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800b11:	8b 45 08             	mov    0x8(%ebp),%eax
  800b14:	8a 00                	mov    (%eax),%al
  800b16:	84 c0                	test   %al,%al
  800b18:	74 0e                	je     800b28 <strcmp+0x22>
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	8a 10                	mov    (%eax),%dl
  800b1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b22:	8a 00                	mov    (%eax),%al
  800b24:	38 c2                	cmp    %al,%dl
  800b26:	74 e3                	je     800b0b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800b28:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2b:	8a 00                	mov    (%eax),%al
  800b2d:	0f b6 d0             	movzbl %al,%edx
  800b30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b33:	8a 00                	mov    (%eax),%al
  800b35:	0f b6 c0             	movzbl %al,%eax
  800b38:	29 c2                	sub    %eax,%edx
  800b3a:	89 d0                	mov    %edx,%eax
}
  800b3c:	5d                   	pop    %ebp
  800b3d:	c3                   	ret    

00800b3e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800b3e:	55                   	push   %ebp
  800b3f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800b41:	eb 09                	jmp    800b4c <strncmp+0xe>
		n--, p++, q++;
  800b43:	ff 4d 10             	decl   0x10(%ebp)
  800b46:	ff 45 08             	incl   0x8(%ebp)
  800b49:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b4c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b50:	74 17                	je     800b69 <strncmp+0x2b>
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	8a 00                	mov    (%eax),%al
  800b57:	84 c0                	test   %al,%al
  800b59:	74 0e                	je     800b69 <strncmp+0x2b>
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	8a 10                	mov    (%eax),%dl
  800b60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b63:	8a 00                	mov    (%eax),%al
  800b65:	38 c2                	cmp    %al,%dl
  800b67:	74 da                	je     800b43 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b69:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b6d:	75 07                	jne    800b76 <strncmp+0x38>
		return 0;
  800b6f:	b8 00 00 00 00       	mov    $0x0,%eax
  800b74:	eb 14                	jmp    800b8a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b76:	8b 45 08             	mov    0x8(%ebp),%eax
  800b79:	8a 00                	mov    (%eax),%al
  800b7b:	0f b6 d0             	movzbl %al,%edx
  800b7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b81:	8a 00                	mov    (%eax),%al
  800b83:	0f b6 c0             	movzbl %al,%eax
  800b86:	29 c2                	sub    %eax,%edx
  800b88:	89 d0                	mov    %edx,%eax
}
  800b8a:	5d                   	pop    %ebp
  800b8b:	c3                   	ret    

00800b8c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b8c:	55                   	push   %ebp
  800b8d:	89 e5                	mov    %esp,%ebp
  800b8f:	83 ec 04             	sub    $0x4,%esp
  800b92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b95:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b98:	eb 12                	jmp    800bac <strchr+0x20>
		if (*s == c)
  800b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9d:	8a 00                	mov    (%eax),%al
  800b9f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ba2:	75 05                	jne    800ba9 <strchr+0x1d>
			return (char *) s;
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	eb 11                	jmp    800bba <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ba9:	ff 45 08             	incl   0x8(%ebp)
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	8a 00                	mov    (%eax),%al
  800bb1:	84 c0                	test   %al,%al
  800bb3:	75 e5                	jne    800b9a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800bb5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bba:	c9                   	leave  
  800bbb:	c3                   	ret    

00800bbc <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800bbc:	55                   	push   %ebp
  800bbd:	89 e5                	mov    %esp,%ebp
  800bbf:	83 ec 04             	sub    $0x4,%esp
  800bc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800bc8:	eb 0d                	jmp    800bd7 <strfind+0x1b>
		if (*s == c)
  800bca:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcd:	8a 00                	mov    (%eax),%al
  800bcf:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800bd2:	74 0e                	je     800be2 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800bd4:	ff 45 08             	incl   0x8(%ebp)
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	8a 00                	mov    (%eax),%al
  800bdc:	84 c0                	test   %al,%al
  800bde:	75 ea                	jne    800bca <strfind+0xe>
  800be0:	eb 01                	jmp    800be3 <strfind+0x27>
		if (*s == c)
			break;
  800be2:	90                   	nop
	return (char *) s;
  800be3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800be6:	c9                   	leave  
  800be7:	c3                   	ret    

00800be8 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800be8:	55                   	push   %ebp
  800be9:	89 e5                	mov    %esp,%ebp
  800beb:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800bee:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800bf4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800bfa:	eb 0e                	jmp    800c0a <memset+0x22>
		*p++ = c;
  800bfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bff:	8d 50 01             	lea    0x1(%eax),%edx
  800c02:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800c05:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c08:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800c0a:	ff 4d f8             	decl   -0x8(%ebp)
  800c0d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800c11:	79 e9                	jns    800bfc <memset+0x14>
		*p++ = c;

	return v;
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c16:	c9                   	leave  
  800c17:	c3                   	ret    

00800c18 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800c18:	55                   	push   %ebp
  800c19:	89 e5                	mov    %esp,%ebp
  800c1b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c21:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c24:	8b 45 08             	mov    0x8(%ebp),%eax
  800c27:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800c2a:	eb 16                	jmp    800c42 <memcpy+0x2a>
		*d++ = *s++;
  800c2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c2f:	8d 50 01             	lea    0x1(%eax),%edx
  800c32:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c35:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c38:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c3b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c3e:	8a 12                	mov    (%edx),%dl
  800c40:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800c42:	8b 45 10             	mov    0x10(%ebp),%eax
  800c45:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c48:	89 55 10             	mov    %edx,0x10(%ebp)
  800c4b:	85 c0                	test   %eax,%eax
  800c4d:	75 dd                	jne    800c2c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c52:	c9                   	leave  
  800c53:	c3                   	ret    

00800c54 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c54:	55                   	push   %ebp
  800c55:	89 e5                	mov    %esp,%ebp
  800c57:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800c5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c60:	8b 45 08             	mov    0x8(%ebp),%eax
  800c63:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c66:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c69:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c6c:	73 50                	jae    800cbe <memmove+0x6a>
  800c6e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c71:	8b 45 10             	mov    0x10(%ebp),%eax
  800c74:	01 d0                	add    %edx,%eax
  800c76:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c79:	76 43                	jbe    800cbe <memmove+0x6a>
		s += n;
  800c7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c7e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c81:	8b 45 10             	mov    0x10(%ebp),%eax
  800c84:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c87:	eb 10                	jmp    800c99 <memmove+0x45>
			*--d = *--s;
  800c89:	ff 4d f8             	decl   -0x8(%ebp)
  800c8c:	ff 4d fc             	decl   -0x4(%ebp)
  800c8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c92:	8a 10                	mov    (%eax),%dl
  800c94:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c97:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c99:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c9f:	89 55 10             	mov    %edx,0x10(%ebp)
  800ca2:	85 c0                	test   %eax,%eax
  800ca4:	75 e3                	jne    800c89 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ca6:	eb 23                	jmp    800ccb <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ca8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cab:	8d 50 01             	lea    0x1(%eax),%edx
  800cae:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800cb1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800cb4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cb7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800cba:	8a 12                	mov    (%edx),%dl
  800cbc:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800cbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cc4:	89 55 10             	mov    %edx,0x10(%ebp)
  800cc7:	85 c0                	test   %eax,%eax
  800cc9:	75 dd                	jne    800ca8 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cce:	c9                   	leave  
  800ccf:	c3                   	ret    

00800cd0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800cd0:	55                   	push   %ebp
  800cd1:	89 e5                	mov    %esp,%ebp
  800cd3:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800cdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cdf:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ce2:	eb 2a                	jmp    800d0e <memcmp+0x3e>
		if (*s1 != *s2)
  800ce4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ce7:	8a 10                	mov    (%eax),%dl
  800ce9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cec:	8a 00                	mov    (%eax),%al
  800cee:	38 c2                	cmp    %al,%dl
  800cf0:	74 16                	je     800d08 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800cf2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cf5:	8a 00                	mov    (%eax),%al
  800cf7:	0f b6 d0             	movzbl %al,%edx
  800cfa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cfd:	8a 00                	mov    (%eax),%al
  800cff:	0f b6 c0             	movzbl %al,%eax
  800d02:	29 c2                	sub    %eax,%edx
  800d04:	89 d0                	mov    %edx,%eax
  800d06:	eb 18                	jmp    800d20 <memcmp+0x50>
		s1++, s2++;
  800d08:	ff 45 fc             	incl   -0x4(%ebp)
  800d0b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800d0e:	8b 45 10             	mov    0x10(%ebp),%eax
  800d11:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d14:	89 55 10             	mov    %edx,0x10(%ebp)
  800d17:	85 c0                	test   %eax,%eax
  800d19:	75 c9                	jne    800ce4 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800d1b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d20:	c9                   	leave  
  800d21:	c3                   	ret    

00800d22 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800d22:	55                   	push   %ebp
  800d23:	89 e5                	mov    %esp,%ebp
  800d25:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800d28:	8b 55 08             	mov    0x8(%ebp),%edx
  800d2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d2e:	01 d0                	add    %edx,%eax
  800d30:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800d33:	eb 15                	jmp    800d4a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8a 00                	mov    (%eax),%al
  800d3a:	0f b6 d0             	movzbl %al,%edx
  800d3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d40:	0f b6 c0             	movzbl %al,%eax
  800d43:	39 c2                	cmp    %eax,%edx
  800d45:	74 0d                	je     800d54 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d47:	ff 45 08             	incl   0x8(%ebp)
  800d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d50:	72 e3                	jb     800d35 <memfind+0x13>
  800d52:	eb 01                	jmp    800d55 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d54:	90                   	nop
	return (void *) s;
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d58:	c9                   	leave  
  800d59:	c3                   	ret    

00800d5a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d5a:	55                   	push   %ebp
  800d5b:	89 e5                	mov    %esp,%ebp
  800d5d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d60:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d67:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d6e:	eb 03                	jmp    800d73 <strtol+0x19>
		s++;
  800d70:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
  800d76:	8a 00                	mov    (%eax),%al
  800d78:	3c 20                	cmp    $0x20,%al
  800d7a:	74 f4                	je     800d70 <strtol+0x16>
  800d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7f:	8a 00                	mov    (%eax),%al
  800d81:	3c 09                	cmp    $0x9,%al
  800d83:	74 eb                	je     800d70 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	8a 00                	mov    (%eax),%al
  800d8a:	3c 2b                	cmp    $0x2b,%al
  800d8c:	75 05                	jne    800d93 <strtol+0x39>
		s++;
  800d8e:	ff 45 08             	incl   0x8(%ebp)
  800d91:	eb 13                	jmp    800da6 <strtol+0x4c>
	else if (*s == '-')
  800d93:	8b 45 08             	mov    0x8(%ebp),%eax
  800d96:	8a 00                	mov    (%eax),%al
  800d98:	3c 2d                	cmp    $0x2d,%al
  800d9a:	75 0a                	jne    800da6 <strtol+0x4c>
		s++, neg = 1;
  800d9c:	ff 45 08             	incl   0x8(%ebp)
  800d9f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800da6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800daa:	74 06                	je     800db2 <strtol+0x58>
  800dac:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800db0:	75 20                	jne    800dd2 <strtol+0x78>
  800db2:	8b 45 08             	mov    0x8(%ebp),%eax
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	3c 30                	cmp    $0x30,%al
  800db9:	75 17                	jne    800dd2 <strtol+0x78>
  800dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbe:	40                   	inc    %eax
  800dbf:	8a 00                	mov    (%eax),%al
  800dc1:	3c 78                	cmp    $0x78,%al
  800dc3:	75 0d                	jne    800dd2 <strtol+0x78>
		s += 2, base = 16;
  800dc5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800dc9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800dd0:	eb 28                	jmp    800dfa <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800dd2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dd6:	75 15                	jne    800ded <strtol+0x93>
  800dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddb:	8a 00                	mov    (%eax),%al
  800ddd:	3c 30                	cmp    $0x30,%al
  800ddf:	75 0c                	jne    800ded <strtol+0x93>
		s++, base = 8;
  800de1:	ff 45 08             	incl   0x8(%ebp)
  800de4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800deb:	eb 0d                	jmp    800dfa <strtol+0xa0>
	else if (base == 0)
  800ded:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800df1:	75 07                	jne    800dfa <strtol+0xa0>
		base = 10;
  800df3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfd:	8a 00                	mov    (%eax),%al
  800dff:	3c 2f                	cmp    $0x2f,%al
  800e01:	7e 19                	jle    800e1c <strtol+0xc2>
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	8a 00                	mov    (%eax),%al
  800e08:	3c 39                	cmp    $0x39,%al
  800e0a:	7f 10                	jg     800e1c <strtol+0xc2>
			dig = *s - '0';
  800e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0f:	8a 00                	mov    (%eax),%al
  800e11:	0f be c0             	movsbl %al,%eax
  800e14:	83 e8 30             	sub    $0x30,%eax
  800e17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e1a:	eb 42                	jmp    800e5e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1f:	8a 00                	mov    (%eax),%al
  800e21:	3c 60                	cmp    $0x60,%al
  800e23:	7e 19                	jle    800e3e <strtol+0xe4>
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	8a 00                	mov    (%eax),%al
  800e2a:	3c 7a                	cmp    $0x7a,%al
  800e2c:	7f 10                	jg     800e3e <strtol+0xe4>
			dig = *s - 'a' + 10;
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	8a 00                	mov    (%eax),%al
  800e33:	0f be c0             	movsbl %al,%eax
  800e36:	83 e8 57             	sub    $0x57,%eax
  800e39:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e3c:	eb 20                	jmp    800e5e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	3c 40                	cmp    $0x40,%al
  800e45:	7e 39                	jle    800e80 <strtol+0x126>
  800e47:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	3c 5a                	cmp    $0x5a,%al
  800e4e:	7f 30                	jg     800e80 <strtol+0x126>
			dig = *s - 'A' + 10;
  800e50:	8b 45 08             	mov    0x8(%ebp),%eax
  800e53:	8a 00                	mov    (%eax),%al
  800e55:	0f be c0             	movsbl %al,%eax
  800e58:	83 e8 37             	sub    $0x37,%eax
  800e5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e61:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e64:	7d 19                	jge    800e7f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e66:	ff 45 08             	incl   0x8(%ebp)
  800e69:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e6c:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e70:	89 c2                	mov    %eax,%edx
  800e72:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e75:	01 d0                	add    %edx,%eax
  800e77:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e7a:	e9 7b ff ff ff       	jmp    800dfa <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e7f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e80:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e84:	74 08                	je     800e8e <strtol+0x134>
		*endptr = (char *) s;
  800e86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e89:	8b 55 08             	mov    0x8(%ebp),%edx
  800e8c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e8e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e92:	74 07                	je     800e9b <strtol+0x141>
  800e94:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e97:	f7 d8                	neg    %eax
  800e99:	eb 03                	jmp    800e9e <strtol+0x144>
  800e9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e9e:	c9                   	leave  
  800e9f:	c3                   	ret    

00800ea0 <ltostr>:

void
ltostr(long value, char *str)
{
  800ea0:	55                   	push   %ebp
  800ea1:	89 e5                	mov    %esp,%ebp
  800ea3:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800ea6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800ead:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800eb4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800eb8:	79 13                	jns    800ecd <ltostr+0x2d>
	{
		neg = 1;
  800eba:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800ec1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec4:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800ec7:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800eca:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800ed5:	99                   	cltd   
  800ed6:	f7 f9                	idiv   %ecx
  800ed8:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800edb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ede:	8d 50 01             	lea    0x1(%eax),%edx
  800ee1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ee4:	89 c2                	mov    %eax,%edx
  800ee6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee9:	01 d0                	add    %edx,%eax
  800eeb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800eee:	83 c2 30             	add    $0x30,%edx
  800ef1:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800ef3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ef6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800efb:	f7 e9                	imul   %ecx
  800efd:	c1 fa 02             	sar    $0x2,%edx
  800f00:	89 c8                	mov    %ecx,%eax
  800f02:	c1 f8 1f             	sar    $0x1f,%eax
  800f05:	29 c2                	sub    %eax,%edx
  800f07:	89 d0                	mov    %edx,%eax
  800f09:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800f0c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f0f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f14:	f7 e9                	imul   %ecx
  800f16:	c1 fa 02             	sar    $0x2,%edx
  800f19:	89 c8                	mov    %ecx,%eax
  800f1b:	c1 f8 1f             	sar    $0x1f,%eax
  800f1e:	29 c2                	sub    %eax,%edx
  800f20:	89 d0                	mov    %edx,%eax
  800f22:	c1 e0 02             	shl    $0x2,%eax
  800f25:	01 d0                	add    %edx,%eax
  800f27:	01 c0                	add    %eax,%eax
  800f29:	29 c1                	sub    %eax,%ecx
  800f2b:	89 ca                	mov    %ecx,%edx
  800f2d:	85 d2                	test   %edx,%edx
  800f2f:	75 9c                	jne    800ecd <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800f31:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800f38:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f3b:	48                   	dec    %eax
  800f3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800f3f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f43:	74 3d                	je     800f82 <ltostr+0xe2>
		start = 1 ;
  800f45:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f4c:	eb 34                	jmp    800f82 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f54:	01 d0                	add    %edx,%eax
  800f56:	8a 00                	mov    (%eax),%al
  800f58:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f5b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f61:	01 c2                	add    %eax,%edx
  800f63:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f69:	01 c8                	add    %ecx,%eax
  800f6b:	8a 00                	mov    (%eax),%al
  800f6d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f6f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f75:	01 c2                	add    %eax,%edx
  800f77:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f7a:	88 02                	mov    %al,(%edx)
		start++ ;
  800f7c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f7f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f82:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f85:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f88:	7c c4                	jl     800f4e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f8a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f90:	01 d0                	add    %edx,%eax
  800f92:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f95:	90                   	nop
  800f96:	c9                   	leave  
  800f97:	c3                   	ret    

00800f98 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f98:	55                   	push   %ebp
  800f99:	89 e5                	mov    %esp,%ebp
  800f9b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f9e:	ff 75 08             	pushl  0x8(%ebp)
  800fa1:	e8 54 fa ff ff       	call   8009fa <strlen>
  800fa6:	83 c4 04             	add    $0x4,%esp
  800fa9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800fac:	ff 75 0c             	pushl  0xc(%ebp)
  800faf:	e8 46 fa ff ff       	call   8009fa <strlen>
  800fb4:	83 c4 04             	add    $0x4,%esp
  800fb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800fba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800fc1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fc8:	eb 17                	jmp    800fe1 <strcconcat+0x49>
		final[s] = str1[s] ;
  800fca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fcd:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd0:	01 c2                	add    %eax,%edx
  800fd2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd8:	01 c8                	add    %ecx,%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800fde:	ff 45 fc             	incl   -0x4(%ebp)
  800fe1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800fe7:	7c e1                	jl     800fca <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800fe9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ff0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ff7:	eb 1f                	jmp    801018 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ff9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ffc:	8d 50 01             	lea    0x1(%eax),%edx
  800fff:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801002:	89 c2                	mov    %eax,%edx
  801004:	8b 45 10             	mov    0x10(%ebp),%eax
  801007:	01 c2                	add    %eax,%edx
  801009:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80100c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100f:	01 c8                	add    %ecx,%eax
  801011:	8a 00                	mov    (%eax),%al
  801013:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801015:	ff 45 f8             	incl   -0x8(%ebp)
  801018:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80101e:	7c d9                	jl     800ff9 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801020:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801023:	8b 45 10             	mov    0x10(%ebp),%eax
  801026:	01 d0                	add    %edx,%eax
  801028:	c6 00 00             	movb   $0x0,(%eax)
}
  80102b:	90                   	nop
  80102c:	c9                   	leave  
  80102d:	c3                   	ret    

0080102e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80102e:	55                   	push   %ebp
  80102f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801031:	8b 45 14             	mov    0x14(%ebp),%eax
  801034:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80103a:	8b 45 14             	mov    0x14(%ebp),%eax
  80103d:	8b 00                	mov    (%eax),%eax
  80103f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801046:	8b 45 10             	mov    0x10(%ebp),%eax
  801049:	01 d0                	add    %edx,%eax
  80104b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801051:	eb 0c                	jmp    80105f <strsplit+0x31>
			*string++ = 0;
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	8d 50 01             	lea    0x1(%eax),%edx
  801059:	89 55 08             	mov    %edx,0x8(%ebp)
  80105c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80105f:	8b 45 08             	mov    0x8(%ebp),%eax
  801062:	8a 00                	mov    (%eax),%al
  801064:	84 c0                	test   %al,%al
  801066:	74 18                	je     801080 <strsplit+0x52>
  801068:	8b 45 08             	mov    0x8(%ebp),%eax
  80106b:	8a 00                	mov    (%eax),%al
  80106d:	0f be c0             	movsbl %al,%eax
  801070:	50                   	push   %eax
  801071:	ff 75 0c             	pushl  0xc(%ebp)
  801074:	e8 13 fb ff ff       	call   800b8c <strchr>
  801079:	83 c4 08             	add    $0x8,%esp
  80107c:	85 c0                	test   %eax,%eax
  80107e:	75 d3                	jne    801053 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	8a 00                	mov    (%eax),%al
  801085:	84 c0                	test   %al,%al
  801087:	74 5a                	je     8010e3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801089:	8b 45 14             	mov    0x14(%ebp),%eax
  80108c:	8b 00                	mov    (%eax),%eax
  80108e:	83 f8 0f             	cmp    $0xf,%eax
  801091:	75 07                	jne    80109a <strsplit+0x6c>
		{
			return 0;
  801093:	b8 00 00 00 00       	mov    $0x0,%eax
  801098:	eb 66                	jmp    801100 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80109a:	8b 45 14             	mov    0x14(%ebp),%eax
  80109d:	8b 00                	mov    (%eax),%eax
  80109f:	8d 48 01             	lea    0x1(%eax),%ecx
  8010a2:	8b 55 14             	mov    0x14(%ebp),%edx
  8010a5:	89 0a                	mov    %ecx,(%edx)
  8010a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b1:	01 c2                	add    %eax,%edx
  8010b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010b8:	eb 03                	jmp    8010bd <strsplit+0x8f>
			string++;
  8010ba:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c0:	8a 00                	mov    (%eax),%al
  8010c2:	84 c0                	test   %al,%al
  8010c4:	74 8b                	je     801051 <strsplit+0x23>
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	8a 00                	mov    (%eax),%al
  8010cb:	0f be c0             	movsbl %al,%eax
  8010ce:	50                   	push   %eax
  8010cf:	ff 75 0c             	pushl  0xc(%ebp)
  8010d2:	e8 b5 fa ff ff       	call   800b8c <strchr>
  8010d7:	83 c4 08             	add    $0x8,%esp
  8010da:	85 c0                	test   %eax,%eax
  8010dc:	74 dc                	je     8010ba <strsplit+0x8c>
			string++;
	}
  8010de:	e9 6e ff ff ff       	jmp    801051 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8010e3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8010e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8010e7:	8b 00                	mov    (%eax),%eax
  8010e9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f3:	01 d0                	add    %edx,%eax
  8010f5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8010fb:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801100:	c9                   	leave  
  801101:	c3                   	ret    

00801102 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801102:	55                   	push   %ebp
  801103:	89 e5                	mov    %esp,%ebp
  801105:	57                   	push   %edi
  801106:	56                   	push   %esi
  801107:	53                   	push   %ebx
  801108:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80110b:	8b 45 08             	mov    0x8(%ebp),%eax
  80110e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801111:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801114:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801117:	8b 7d 18             	mov    0x18(%ebp),%edi
  80111a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80111d:	cd 30                	int    $0x30
  80111f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801122:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801125:	83 c4 10             	add    $0x10,%esp
  801128:	5b                   	pop    %ebx
  801129:	5e                   	pop    %esi
  80112a:	5f                   	pop    %edi
  80112b:	5d                   	pop    %ebp
  80112c:	c3                   	ret    

0080112d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80112d:	55                   	push   %ebp
  80112e:	89 e5                	mov    %esp,%ebp
  801130:	83 ec 04             	sub    $0x4,%esp
  801133:	8b 45 10             	mov    0x10(%ebp),%eax
  801136:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801139:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80113d:	8b 45 08             	mov    0x8(%ebp),%eax
  801140:	6a 00                	push   $0x0
  801142:	6a 00                	push   $0x0
  801144:	52                   	push   %edx
  801145:	ff 75 0c             	pushl  0xc(%ebp)
  801148:	50                   	push   %eax
  801149:	6a 00                	push   $0x0
  80114b:	e8 b2 ff ff ff       	call   801102 <syscall>
  801150:	83 c4 18             	add    $0x18,%esp
}
  801153:	90                   	nop
  801154:	c9                   	leave  
  801155:	c3                   	ret    

00801156 <sys_cgetc>:

int
sys_cgetc(void)
{
  801156:	55                   	push   %ebp
  801157:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801159:	6a 00                	push   $0x0
  80115b:	6a 00                	push   $0x0
  80115d:	6a 00                	push   $0x0
  80115f:	6a 00                	push   $0x0
  801161:	6a 00                	push   $0x0
  801163:	6a 01                	push   $0x1
  801165:	e8 98 ff ff ff       	call   801102 <syscall>
  80116a:	83 c4 18             	add    $0x18,%esp
}
  80116d:	c9                   	leave  
  80116e:	c3                   	ret    

0080116f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80116f:	55                   	push   %ebp
  801170:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801172:	8b 45 08             	mov    0x8(%ebp),%eax
  801175:	6a 00                	push   $0x0
  801177:	6a 00                	push   $0x0
  801179:	6a 00                	push   $0x0
  80117b:	6a 00                	push   $0x0
  80117d:	50                   	push   %eax
  80117e:	6a 05                	push   $0x5
  801180:	e8 7d ff ff ff       	call   801102 <syscall>
  801185:	83 c4 18             	add    $0x18,%esp
}
  801188:	c9                   	leave  
  801189:	c3                   	ret    

0080118a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80118a:	55                   	push   %ebp
  80118b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80118d:	6a 00                	push   $0x0
  80118f:	6a 00                	push   $0x0
  801191:	6a 00                	push   $0x0
  801193:	6a 00                	push   $0x0
  801195:	6a 00                	push   $0x0
  801197:	6a 02                	push   $0x2
  801199:	e8 64 ff ff ff       	call   801102 <syscall>
  80119e:	83 c4 18             	add    $0x18,%esp
}
  8011a1:	c9                   	leave  
  8011a2:	c3                   	ret    

008011a3 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8011a3:	55                   	push   %ebp
  8011a4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8011a6:	6a 00                	push   $0x0
  8011a8:	6a 00                	push   $0x0
  8011aa:	6a 00                	push   $0x0
  8011ac:	6a 00                	push   $0x0
  8011ae:	6a 00                	push   $0x0
  8011b0:	6a 03                	push   $0x3
  8011b2:	e8 4b ff ff ff       	call   801102 <syscall>
  8011b7:	83 c4 18             	add    $0x18,%esp
}
  8011ba:	c9                   	leave  
  8011bb:	c3                   	ret    

008011bc <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8011bc:	55                   	push   %ebp
  8011bd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8011bf:	6a 00                	push   $0x0
  8011c1:	6a 00                	push   $0x0
  8011c3:	6a 00                	push   $0x0
  8011c5:	6a 00                	push   $0x0
  8011c7:	6a 00                	push   $0x0
  8011c9:	6a 04                	push   $0x4
  8011cb:	e8 32 ff ff ff       	call   801102 <syscall>
  8011d0:	83 c4 18             	add    $0x18,%esp
}
  8011d3:	c9                   	leave  
  8011d4:	c3                   	ret    

008011d5 <sys_env_exit>:


void sys_env_exit(void)
{
  8011d5:	55                   	push   %ebp
  8011d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8011d8:	6a 00                	push   $0x0
  8011da:	6a 00                	push   $0x0
  8011dc:	6a 00                	push   $0x0
  8011de:	6a 00                	push   $0x0
  8011e0:	6a 00                	push   $0x0
  8011e2:	6a 06                	push   $0x6
  8011e4:	e8 19 ff ff ff       	call   801102 <syscall>
  8011e9:	83 c4 18             	add    $0x18,%esp
}
  8011ec:	90                   	nop
  8011ed:	c9                   	leave  
  8011ee:	c3                   	ret    

008011ef <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8011ef:	55                   	push   %ebp
  8011f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8011f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	6a 00                	push   $0x0
  8011fa:	6a 00                	push   $0x0
  8011fc:	6a 00                	push   $0x0
  8011fe:	52                   	push   %edx
  8011ff:	50                   	push   %eax
  801200:	6a 07                	push   $0x7
  801202:	e8 fb fe ff ff       	call   801102 <syscall>
  801207:	83 c4 18             	add    $0x18,%esp
}
  80120a:	c9                   	leave  
  80120b:	c3                   	ret    

0080120c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80120c:	55                   	push   %ebp
  80120d:	89 e5                	mov    %esp,%ebp
  80120f:	56                   	push   %esi
  801210:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801211:	8b 75 18             	mov    0x18(%ebp),%esi
  801214:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801217:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80121a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80121d:	8b 45 08             	mov    0x8(%ebp),%eax
  801220:	56                   	push   %esi
  801221:	53                   	push   %ebx
  801222:	51                   	push   %ecx
  801223:	52                   	push   %edx
  801224:	50                   	push   %eax
  801225:	6a 08                	push   $0x8
  801227:	e8 d6 fe ff ff       	call   801102 <syscall>
  80122c:	83 c4 18             	add    $0x18,%esp
}
  80122f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801232:	5b                   	pop    %ebx
  801233:	5e                   	pop    %esi
  801234:	5d                   	pop    %ebp
  801235:	c3                   	ret    

00801236 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801236:	55                   	push   %ebp
  801237:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801239:	8b 55 0c             	mov    0xc(%ebp),%edx
  80123c:	8b 45 08             	mov    0x8(%ebp),%eax
  80123f:	6a 00                	push   $0x0
  801241:	6a 00                	push   $0x0
  801243:	6a 00                	push   $0x0
  801245:	52                   	push   %edx
  801246:	50                   	push   %eax
  801247:	6a 09                	push   $0x9
  801249:	e8 b4 fe ff ff       	call   801102 <syscall>
  80124e:	83 c4 18             	add    $0x18,%esp
}
  801251:	c9                   	leave  
  801252:	c3                   	ret    

00801253 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801253:	55                   	push   %ebp
  801254:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801256:	6a 00                	push   $0x0
  801258:	6a 00                	push   $0x0
  80125a:	6a 00                	push   $0x0
  80125c:	ff 75 0c             	pushl  0xc(%ebp)
  80125f:	ff 75 08             	pushl  0x8(%ebp)
  801262:	6a 0a                	push   $0xa
  801264:	e8 99 fe ff ff       	call   801102 <syscall>
  801269:	83 c4 18             	add    $0x18,%esp
}
  80126c:	c9                   	leave  
  80126d:	c3                   	ret    

0080126e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80126e:	55                   	push   %ebp
  80126f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	6a 00                	push   $0x0
  801279:	6a 00                	push   $0x0
  80127b:	6a 0b                	push   $0xb
  80127d:	e8 80 fe ff ff       	call   801102 <syscall>
  801282:	83 c4 18             	add    $0x18,%esp
}
  801285:	c9                   	leave  
  801286:	c3                   	ret    

00801287 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801287:	55                   	push   %ebp
  801288:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80128a:	6a 00                	push   $0x0
  80128c:	6a 00                	push   $0x0
  80128e:	6a 00                	push   $0x0
  801290:	6a 00                	push   $0x0
  801292:	6a 00                	push   $0x0
  801294:	6a 0c                	push   $0xc
  801296:	e8 67 fe ff ff       	call   801102 <syscall>
  80129b:	83 c4 18             	add    $0x18,%esp
}
  80129e:	c9                   	leave  
  80129f:	c3                   	ret    

008012a0 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 0d                	push   $0xd
  8012af:	e8 4e fe ff ff       	call   801102 <syscall>
  8012b4:	83 c4 18             	add    $0x18,%esp
}
  8012b7:	c9                   	leave  
  8012b8:	c3                   	ret    

008012b9 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8012b9:	55                   	push   %ebp
  8012ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 00                	push   $0x0
  8012c2:	ff 75 0c             	pushl  0xc(%ebp)
  8012c5:	ff 75 08             	pushl  0x8(%ebp)
  8012c8:	6a 11                	push   $0x11
  8012ca:	e8 33 fe ff ff       	call   801102 <syscall>
  8012cf:	83 c4 18             	add    $0x18,%esp
	return;
  8012d2:	90                   	nop
}
  8012d3:	c9                   	leave  
  8012d4:	c3                   	ret    

008012d5 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8012d5:	55                   	push   %ebp
  8012d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	6a 00                	push   $0x0
  8012de:	ff 75 0c             	pushl  0xc(%ebp)
  8012e1:	ff 75 08             	pushl  0x8(%ebp)
  8012e4:	6a 12                	push   $0x12
  8012e6:	e8 17 fe ff ff       	call   801102 <syscall>
  8012eb:	83 c4 18             	add    $0x18,%esp
	return ;
  8012ee:	90                   	nop
}
  8012ef:	c9                   	leave  
  8012f0:	c3                   	ret    

008012f1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8012f1:	55                   	push   %ebp
  8012f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 00                	push   $0x0
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 0e                	push   $0xe
  801300:	e8 fd fd ff ff       	call   801102 <syscall>
  801305:	83 c4 18             	add    $0x18,%esp
}
  801308:	c9                   	leave  
  801309:	c3                   	ret    

0080130a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80130a:	55                   	push   %ebp
  80130b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80130d:	6a 00                	push   $0x0
  80130f:	6a 00                	push   $0x0
  801311:	6a 00                	push   $0x0
  801313:	6a 00                	push   $0x0
  801315:	ff 75 08             	pushl  0x8(%ebp)
  801318:	6a 0f                	push   $0xf
  80131a:	e8 e3 fd ff ff       	call   801102 <syscall>
  80131f:	83 c4 18             	add    $0x18,%esp
}
  801322:	c9                   	leave  
  801323:	c3                   	ret    

00801324 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801324:	55                   	push   %ebp
  801325:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801327:	6a 00                	push   $0x0
  801329:	6a 00                	push   $0x0
  80132b:	6a 00                	push   $0x0
  80132d:	6a 00                	push   $0x0
  80132f:	6a 00                	push   $0x0
  801331:	6a 10                	push   $0x10
  801333:	e8 ca fd ff ff       	call   801102 <syscall>
  801338:	83 c4 18             	add    $0x18,%esp
}
  80133b:	90                   	nop
  80133c:	c9                   	leave  
  80133d:	c3                   	ret    

0080133e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80133e:	55                   	push   %ebp
  80133f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801341:	6a 00                	push   $0x0
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	6a 14                	push   $0x14
  80134d:	e8 b0 fd ff ff       	call   801102 <syscall>
  801352:	83 c4 18             	add    $0x18,%esp
}
  801355:	90                   	nop
  801356:	c9                   	leave  
  801357:	c3                   	ret    

00801358 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801358:	55                   	push   %ebp
  801359:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80135b:	6a 00                	push   $0x0
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	6a 00                	push   $0x0
  801365:	6a 15                	push   $0x15
  801367:	e8 96 fd ff ff       	call   801102 <syscall>
  80136c:	83 c4 18             	add    $0x18,%esp
}
  80136f:	90                   	nop
  801370:	c9                   	leave  
  801371:	c3                   	ret    

00801372 <sys_cputc>:


void
sys_cputc(const char c)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
  801375:	83 ec 04             	sub    $0x4,%esp
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80137e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	6a 00                	push   $0x0
  801388:	6a 00                	push   $0x0
  80138a:	50                   	push   %eax
  80138b:	6a 16                	push   $0x16
  80138d:	e8 70 fd ff ff       	call   801102 <syscall>
  801392:	83 c4 18             	add    $0x18,%esp
}
  801395:	90                   	nop
  801396:	c9                   	leave  
  801397:	c3                   	ret    

00801398 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801398:	55                   	push   %ebp
  801399:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	6a 00                	push   $0x0
  8013a1:	6a 00                	push   $0x0
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 17                	push   $0x17
  8013a7:	e8 56 fd ff ff       	call   801102 <syscall>
  8013ac:	83 c4 18             	add    $0x18,%esp
}
  8013af:	90                   	nop
  8013b0:	c9                   	leave  
  8013b1:	c3                   	ret    

008013b2 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8013b2:	55                   	push   %ebp
  8013b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8013b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	ff 75 0c             	pushl  0xc(%ebp)
  8013c1:	50                   	push   %eax
  8013c2:	6a 18                	push   $0x18
  8013c4:	e8 39 fd ff ff       	call   801102 <syscall>
  8013c9:	83 c4 18             	add    $0x18,%esp
}
  8013cc:	c9                   	leave  
  8013cd:	c3                   	ret    

008013ce <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8013ce:	55                   	push   %ebp
  8013cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d7:	6a 00                	push   $0x0
  8013d9:	6a 00                	push   $0x0
  8013db:	6a 00                	push   $0x0
  8013dd:	52                   	push   %edx
  8013de:	50                   	push   %eax
  8013df:	6a 1b                	push   $0x1b
  8013e1:	e8 1c fd ff ff       	call   801102 <syscall>
  8013e6:	83 c4 18             	add    $0x18,%esp
}
  8013e9:	c9                   	leave  
  8013ea:	c3                   	ret    

008013eb <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8013eb:	55                   	push   %ebp
  8013ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 00                	push   $0x0
  8013f8:	6a 00                	push   $0x0
  8013fa:	52                   	push   %edx
  8013fb:	50                   	push   %eax
  8013fc:	6a 19                	push   $0x19
  8013fe:	e8 ff fc ff ff       	call   801102 <syscall>
  801403:	83 c4 18             	add    $0x18,%esp
}
  801406:	90                   	nop
  801407:	c9                   	leave  
  801408:	c3                   	ret    

00801409 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801409:	55                   	push   %ebp
  80140a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80140c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	52                   	push   %edx
  801419:	50                   	push   %eax
  80141a:	6a 1a                	push   $0x1a
  80141c:	e8 e1 fc ff ff       	call   801102 <syscall>
  801421:	83 c4 18             	add    $0x18,%esp
}
  801424:	90                   	nop
  801425:	c9                   	leave  
  801426:	c3                   	ret    

00801427 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801427:	55                   	push   %ebp
  801428:	89 e5                	mov    %esp,%ebp
  80142a:	83 ec 04             	sub    $0x4,%esp
  80142d:	8b 45 10             	mov    0x10(%ebp),%eax
  801430:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801433:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801436:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80143a:	8b 45 08             	mov    0x8(%ebp),%eax
  80143d:	6a 00                	push   $0x0
  80143f:	51                   	push   %ecx
  801440:	52                   	push   %edx
  801441:	ff 75 0c             	pushl  0xc(%ebp)
  801444:	50                   	push   %eax
  801445:	6a 1c                	push   $0x1c
  801447:	e8 b6 fc ff ff       	call   801102 <syscall>
  80144c:	83 c4 18             	add    $0x18,%esp
}
  80144f:	c9                   	leave  
  801450:	c3                   	ret    

00801451 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801451:	55                   	push   %ebp
  801452:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801454:	8b 55 0c             	mov    0xc(%ebp),%edx
  801457:	8b 45 08             	mov    0x8(%ebp),%eax
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	52                   	push   %edx
  801461:	50                   	push   %eax
  801462:	6a 1d                	push   $0x1d
  801464:	e8 99 fc ff ff       	call   801102 <syscall>
  801469:	83 c4 18             	add    $0x18,%esp
}
  80146c:	c9                   	leave  
  80146d:	c3                   	ret    

0080146e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80146e:	55                   	push   %ebp
  80146f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801471:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801474:	8b 55 0c             	mov    0xc(%ebp),%edx
  801477:	8b 45 08             	mov    0x8(%ebp),%eax
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	51                   	push   %ecx
  80147f:	52                   	push   %edx
  801480:	50                   	push   %eax
  801481:	6a 1e                	push   $0x1e
  801483:	e8 7a fc ff ff       	call   801102 <syscall>
  801488:	83 c4 18             	add    $0x18,%esp
}
  80148b:	c9                   	leave  
  80148c:	c3                   	ret    

0080148d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80148d:	55                   	push   %ebp
  80148e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801490:	8b 55 0c             	mov    0xc(%ebp),%edx
  801493:	8b 45 08             	mov    0x8(%ebp),%eax
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	52                   	push   %edx
  80149d:	50                   	push   %eax
  80149e:	6a 1f                	push   $0x1f
  8014a0:	e8 5d fc ff ff       	call   801102 <syscall>
  8014a5:	83 c4 18             	add    $0x18,%esp
}
  8014a8:	c9                   	leave  
  8014a9:	c3                   	ret    

008014aa <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8014aa:	55                   	push   %ebp
  8014ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 20                	push   $0x20
  8014b9:	e8 44 fc ff ff       	call   801102 <syscall>
  8014be:	83 c4 18             	add    $0x18,%esp
}
  8014c1:	c9                   	leave  
  8014c2:	c3                   	ret    

008014c3 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8014c3:	55                   	push   %ebp
  8014c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8014c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	ff 75 10             	pushl  0x10(%ebp)
  8014d0:	ff 75 0c             	pushl  0xc(%ebp)
  8014d3:	50                   	push   %eax
  8014d4:	6a 21                	push   $0x21
  8014d6:	e8 27 fc ff ff       	call   801102 <syscall>
  8014db:	83 c4 18             	add    $0x18,%esp
}
  8014de:	c9                   	leave  
  8014df:	c3                   	ret    

008014e0 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8014e0:	55                   	push   %ebp
  8014e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8014e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	50                   	push   %eax
  8014ef:	6a 22                	push   $0x22
  8014f1:	e8 0c fc ff ff       	call   801102 <syscall>
  8014f6:	83 c4 18             	add    $0x18,%esp
}
  8014f9:	90                   	nop
  8014fa:	c9                   	leave  
  8014fb:	c3                   	ret    

008014fc <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8014fc:	55                   	push   %ebp
  8014fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8014ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	50                   	push   %eax
  80150b:	6a 23                	push   $0x23
  80150d:	e8 f0 fb ff ff       	call   801102 <syscall>
  801512:	83 c4 18             	add    $0x18,%esp
}
  801515:	90                   	nop
  801516:	c9                   	leave  
  801517:	c3                   	ret    

00801518 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801518:	55                   	push   %ebp
  801519:	89 e5                	mov    %esp,%ebp
  80151b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80151e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801521:	8d 50 04             	lea    0x4(%eax),%edx
  801524:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	52                   	push   %edx
  80152e:	50                   	push   %eax
  80152f:	6a 24                	push   $0x24
  801531:	e8 cc fb ff ff       	call   801102 <syscall>
  801536:	83 c4 18             	add    $0x18,%esp
	return result;
  801539:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80153c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801542:	89 01                	mov    %eax,(%ecx)
  801544:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801547:	8b 45 08             	mov    0x8(%ebp),%eax
  80154a:	c9                   	leave  
  80154b:	c2 04 00             	ret    $0x4

0080154e <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80154e:	55                   	push   %ebp
  80154f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	ff 75 10             	pushl  0x10(%ebp)
  801558:	ff 75 0c             	pushl  0xc(%ebp)
  80155b:	ff 75 08             	pushl  0x8(%ebp)
  80155e:	6a 13                	push   $0x13
  801560:	e8 9d fb ff ff       	call   801102 <syscall>
  801565:	83 c4 18             	add    $0x18,%esp
	return ;
  801568:	90                   	nop
}
  801569:	c9                   	leave  
  80156a:	c3                   	ret    

0080156b <sys_rcr2>:
uint32 sys_rcr2()
{
  80156b:	55                   	push   %ebp
  80156c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 25                	push   $0x25
  80157a:	e8 83 fb ff ff       	call   801102 <syscall>
  80157f:	83 c4 18             	add    $0x18,%esp
}
  801582:	c9                   	leave  
  801583:	c3                   	ret    

00801584 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801584:	55                   	push   %ebp
  801585:	89 e5                	mov    %esp,%ebp
  801587:	83 ec 04             	sub    $0x4,%esp
  80158a:	8b 45 08             	mov    0x8(%ebp),%eax
  80158d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801590:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	50                   	push   %eax
  80159d:	6a 26                	push   $0x26
  80159f:	e8 5e fb ff ff       	call   801102 <syscall>
  8015a4:	83 c4 18             	add    $0x18,%esp
	return ;
  8015a7:	90                   	nop
}
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <rsttst>:
void rsttst()
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 28                	push   $0x28
  8015b9:	e8 44 fb ff ff       	call   801102 <syscall>
  8015be:	83 c4 18             	add    $0x18,%esp
	return ;
  8015c1:	90                   	nop
}
  8015c2:	c9                   	leave  
  8015c3:	c3                   	ret    

008015c4 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8015c4:	55                   	push   %ebp
  8015c5:	89 e5                	mov    %esp,%ebp
  8015c7:	83 ec 04             	sub    $0x4,%esp
  8015ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8015cd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8015d0:	8b 55 18             	mov    0x18(%ebp),%edx
  8015d3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015d7:	52                   	push   %edx
  8015d8:	50                   	push   %eax
  8015d9:	ff 75 10             	pushl  0x10(%ebp)
  8015dc:	ff 75 0c             	pushl  0xc(%ebp)
  8015df:	ff 75 08             	pushl  0x8(%ebp)
  8015e2:	6a 27                	push   $0x27
  8015e4:	e8 19 fb ff ff       	call   801102 <syscall>
  8015e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8015ec:	90                   	nop
}
  8015ed:	c9                   	leave  
  8015ee:	c3                   	ret    

008015ef <chktst>:
void chktst(uint32 n)
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	ff 75 08             	pushl  0x8(%ebp)
  8015fd:	6a 29                	push   $0x29
  8015ff:	e8 fe fa ff ff       	call   801102 <syscall>
  801604:	83 c4 18             	add    $0x18,%esp
	return ;
  801607:	90                   	nop
}
  801608:	c9                   	leave  
  801609:	c3                   	ret    

0080160a <inctst>:

void inctst()
{
  80160a:	55                   	push   %ebp
  80160b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 2a                	push   $0x2a
  801619:	e8 e4 fa ff ff       	call   801102 <syscall>
  80161e:	83 c4 18             	add    $0x18,%esp
	return ;
  801621:	90                   	nop
}
  801622:	c9                   	leave  
  801623:	c3                   	ret    

00801624 <gettst>:
uint32 gettst()
{
  801624:	55                   	push   %ebp
  801625:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 2b                	push   $0x2b
  801633:	e8 ca fa ff ff       	call   801102 <syscall>
  801638:	83 c4 18             	add    $0x18,%esp
}
  80163b:	c9                   	leave  
  80163c:	c3                   	ret    

0080163d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80163d:	55                   	push   %ebp
  80163e:	89 e5                	mov    %esp,%ebp
  801640:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 2c                	push   $0x2c
  80164f:	e8 ae fa ff ff       	call   801102 <syscall>
  801654:	83 c4 18             	add    $0x18,%esp
  801657:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80165a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80165e:	75 07                	jne    801667 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801660:	b8 01 00 00 00       	mov    $0x1,%eax
  801665:	eb 05                	jmp    80166c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801667:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80166c:	c9                   	leave  
  80166d:	c3                   	ret    

0080166e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80166e:	55                   	push   %ebp
  80166f:	89 e5                	mov    %esp,%ebp
  801671:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 2c                	push   $0x2c
  801680:	e8 7d fa ff ff       	call   801102 <syscall>
  801685:	83 c4 18             	add    $0x18,%esp
  801688:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80168b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80168f:	75 07                	jne    801698 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801691:	b8 01 00 00 00       	mov    $0x1,%eax
  801696:	eb 05                	jmp    80169d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801698:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80169d:	c9                   	leave  
  80169e:	c3                   	ret    

0080169f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80169f:	55                   	push   %ebp
  8016a0:	89 e5                	mov    %esp,%ebp
  8016a2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 2c                	push   $0x2c
  8016b1:	e8 4c fa ff ff       	call   801102 <syscall>
  8016b6:	83 c4 18             	add    $0x18,%esp
  8016b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8016bc:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8016c0:	75 07                	jne    8016c9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8016c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8016c7:	eb 05                	jmp    8016ce <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8016c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016ce:	c9                   	leave  
  8016cf:	c3                   	ret    

008016d0 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
  8016d3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 2c                	push   $0x2c
  8016e2:	e8 1b fa ff ff       	call   801102 <syscall>
  8016e7:	83 c4 18             	add    $0x18,%esp
  8016ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8016ed:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8016f1:	75 07                	jne    8016fa <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8016f3:	b8 01 00 00 00       	mov    $0x1,%eax
  8016f8:	eb 05                	jmp    8016ff <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8016fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    

00801701 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	ff 75 08             	pushl  0x8(%ebp)
  80170f:	6a 2d                	push   $0x2d
  801711:	e8 ec f9 ff ff       	call   801102 <syscall>
  801716:	83 c4 18             	add    $0x18,%esp
	return ;
  801719:	90                   	nop
}
  80171a:	c9                   	leave  
  80171b:	c3                   	ret    

0080171c <__udivdi3>:
  80171c:	55                   	push   %ebp
  80171d:	57                   	push   %edi
  80171e:	56                   	push   %esi
  80171f:	53                   	push   %ebx
  801720:	83 ec 1c             	sub    $0x1c,%esp
  801723:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801727:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80172b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80172f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801733:	89 ca                	mov    %ecx,%edx
  801735:	89 f8                	mov    %edi,%eax
  801737:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80173b:	85 f6                	test   %esi,%esi
  80173d:	75 2d                	jne    80176c <__udivdi3+0x50>
  80173f:	39 cf                	cmp    %ecx,%edi
  801741:	77 65                	ja     8017a8 <__udivdi3+0x8c>
  801743:	89 fd                	mov    %edi,%ebp
  801745:	85 ff                	test   %edi,%edi
  801747:	75 0b                	jne    801754 <__udivdi3+0x38>
  801749:	b8 01 00 00 00       	mov    $0x1,%eax
  80174e:	31 d2                	xor    %edx,%edx
  801750:	f7 f7                	div    %edi
  801752:	89 c5                	mov    %eax,%ebp
  801754:	31 d2                	xor    %edx,%edx
  801756:	89 c8                	mov    %ecx,%eax
  801758:	f7 f5                	div    %ebp
  80175a:	89 c1                	mov    %eax,%ecx
  80175c:	89 d8                	mov    %ebx,%eax
  80175e:	f7 f5                	div    %ebp
  801760:	89 cf                	mov    %ecx,%edi
  801762:	89 fa                	mov    %edi,%edx
  801764:	83 c4 1c             	add    $0x1c,%esp
  801767:	5b                   	pop    %ebx
  801768:	5e                   	pop    %esi
  801769:	5f                   	pop    %edi
  80176a:	5d                   	pop    %ebp
  80176b:	c3                   	ret    
  80176c:	39 ce                	cmp    %ecx,%esi
  80176e:	77 28                	ja     801798 <__udivdi3+0x7c>
  801770:	0f bd fe             	bsr    %esi,%edi
  801773:	83 f7 1f             	xor    $0x1f,%edi
  801776:	75 40                	jne    8017b8 <__udivdi3+0x9c>
  801778:	39 ce                	cmp    %ecx,%esi
  80177a:	72 0a                	jb     801786 <__udivdi3+0x6a>
  80177c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801780:	0f 87 9e 00 00 00    	ja     801824 <__udivdi3+0x108>
  801786:	b8 01 00 00 00       	mov    $0x1,%eax
  80178b:	89 fa                	mov    %edi,%edx
  80178d:	83 c4 1c             	add    $0x1c,%esp
  801790:	5b                   	pop    %ebx
  801791:	5e                   	pop    %esi
  801792:	5f                   	pop    %edi
  801793:	5d                   	pop    %ebp
  801794:	c3                   	ret    
  801795:	8d 76 00             	lea    0x0(%esi),%esi
  801798:	31 ff                	xor    %edi,%edi
  80179a:	31 c0                	xor    %eax,%eax
  80179c:	89 fa                	mov    %edi,%edx
  80179e:	83 c4 1c             	add    $0x1c,%esp
  8017a1:	5b                   	pop    %ebx
  8017a2:	5e                   	pop    %esi
  8017a3:	5f                   	pop    %edi
  8017a4:	5d                   	pop    %ebp
  8017a5:	c3                   	ret    
  8017a6:	66 90                	xchg   %ax,%ax
  8017a8:	89 d8                	mov    %ebx,%eax
  8017aa:	f7 f7                	div    %edi
  8017ac:	31 ff                	xor    %edi,%edi
  8017ae:	89 fa                	mov    %edi,%edx
  8017b0:	83 c4 1c             	add    $0x1c,%esp
  8017b3:	5b                   	pop    %ebx
  8017b4:	5e                   	pop    %esi
  8017b5:	5f                   	pop    %edi
  8017b6:	5d                   	pop    %ebp
  8017b7:	c3                   	ret    
  8017b8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8017bd:	89 eb                	mov    %ebp,%ebx
  8017bf:	29 fb                	sub    %edi,%ebx
  8017c1:	89 f9                	mov    %edi,%ecx
  8017c3:	d3 e6                	shl    %cl,%esi
  8017c5:	89 c5                	mov    %eax,%ebp
  8017c7:	88 d9                	mov    %bl,%cl
  8017c9:	d3 ed                	shr    %cl,%ebp
  8017cb:	89 e9                	mov    %ebp,%ecx
  8017cd:	09 f1                	or     %esi,%ecx
  8017cf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8017d3:	89 f9                	mov    %edi,%ecx
  8017d5:	d3 e0                	shl    %cl,%eax
  8017d7:	89 c5                	mov    %eax,%ebp
  8017d9:	89 d6                	mov    %edx,%esi
  8017db:	88 d9                	mov    %bl,%cl
  8017dd:	d3 ee                	shr    %cl,%esi
  8017df:	89 f9                	mov    %edi,%ecx
  8017e1:	d3 e2                	shl    %cl,%edx
  8017e3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017e7:	88 d9                	mov    %bl,%cl
  8017e9:	d3 e8                	shr    %cl,%eax
  8017eb:	09 c2                	or     %eax,%edx
  8017ed:	89 d0                	mov    %edx,%eax
  8017ef:	89 f2                	mov    %esi,%edx
  8017f1:	f7 74 24 0c          	divl   0xc(%esp)
  8017f5:	89 d6                	mov    %edx,%esi
  8017f7:	89 c3                	mov    %eax,%ebx
  8017f9:	f7 e5                	mul    %ebp
  8017fb:	39 d6                	cmp    %edx,%esi
  8017fd:	72 19                	jb     801818 <__udivdi3+0xfc>
  8017ff:	74 0b                	je     80180c <__udivdi3+0xf0>
  801801:	89 d8                	mov    %ebx,%eax
  801803:	31 ff                	xor    %edi,%edi
  801805:	e9 58 ff ff ff       	jmp    801762 <__udivdi3+0x46>
  80180a:	66 90                	xchg   %ax,%ax
  80180c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801810:	89 f9                	mov    %edi,%ecx
  801812:	d3 e2                	shl    %cl,%edx
  801814:	39 c2                	cmp    %eax,%edx
  801816:	73 e9                	jae    801801 <__udivdi3+0xe5>
  801818:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80181b:	31 ff                	xor    %edi,%edi
  80181d:	e9 40 ff ff ff       	jmp    801762 <__udivdi3+0x46>
  801822:	66 90                	xchg   %ax,%ax
  801824:	31 c0                	xor    %eax,%eax
  801826:	e9 37 ff ff ff       	jmp    801762 <__udivdi3+0x46>
  80182b:	90                   	nop

0080182c <__umoddi3>:
  80182c:	55                   	push   %ebp
  80182d:	57                   	push   %edi
  80182e:	56                   	push   %esi
  80182f:	53                   	push   %ebx
  801830:	83 ec 1c             	sub    $0x1c,%esp
  801833:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801837:	8b 74 24 34          	mov    0x34(%esp),%esi
  80183b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80183f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801843:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801847:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80184b:	89 f3                	mov    %esi,%ebx
  80184d:	89 fa                	mov    %edi,%edx
  80184f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801853:	89 34 24             	mov    %esi,(%esp)
  801856:	85 c0                	test   %eax,%eax
  801858:	75 1a                	jne    801874 <__umoddi3+0x48>
  80185a:	39 f7                	cmp    %esi,%edi
  80185c:	0f 86 a2 00 00 00    	jbe    801904 <__umoddi3+0xd8>
  801862:	89 c8                	mov    %ecx,%eax
  801864:	89 f2                	mov    %esi,%edx
  801866:	f7 f7                	div    %edi
  801868:	89 d0                	mov    %edx,%eax
  80186a:	31 d2                	xor    %edx,%edx
  80186c:	83 c4 1c             	add    $0x1c,%esp
  80186f:	5b                   	pop    %ebx
  801870:	5e                   	pop    %esi
  801871:	5f                   	pop    %edi
  801872:	5d                   	pop    %ebp
  801873:	c3                   	ret    
  801874:	39 f0                	cmp    %esi,%eax
  801876:	0f 87 ac 00 00 00    	ja     801928 <__umoddi3+0xfc>
  80187c:	0f bd e8             	bsr    %eax,%ebp
  80187f:	83 f5 1f             	xor    $0x1f,%ebp
  801882:	0f 84 ac 00 00 00    	je     801934 <__umoddi3+0x108>
  801888:	bf 20 00 00 00       	mov    $0x20,%edi
  80188d:	29 ef                	sub    %ebp,%edi
  80188f:	89 fe                	mov    %edi,%esi
  801891:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801895:	89 e9                	mov    %ebp,%ecx
  801897:	d3 e0                	shl    %cl,%eax
  801899:	89 d7                	mov    %edx,%edi
  80189b:	89 f1                	mov    %esi,%ecx
  80189d:	d3 ef                	shr    %cl,%edi
  80189f:	09 c7                	or     %eax,%edi
  8018a1:	89 e9                	mov    %ebp,%ecx
  8018a3:	d3 e2                	shl    %cl,%edx
  8018a5:	89 14 24             	mov    %edx,(%esp)
  8018a8:	89 d8                	mov    %ebx,%eax
  8018aa:	d3 e0                	shl    %cl,%eax
  8018ac:	89 c2                	mov    %eax,%edx
  8018ae:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018b2:	d3 e0                	shl    %cl,%eax
  8018b4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8018b8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018bc:	89 f1                	mov    %esi,%ecx
  8018be:	d3 e8                	shr    %cl,%eax
  8018c0:	09 d0                	or     %edx,%eax
  8018c2:	d3 eb                	shr    %cl,%ebx
  8018c4:	89 da                	mov    %ebx,%edx
  8018c6:	f7 f7                	div    %edi
  8018c8:	89 d3                	mov    %edx,%ebx
  8018ca:	f7 24 24             	mull   (%esp)
  8018cd:	89 c6                	mov    %eax,%esi
  8018cf:	89 d1                	mov    %edx,%ecx
  8018d1:	39 d3                	cmp    %edx,%ebx
  8018d3:	0f 82 87 00 00 00    	jb     801960 <__umoddi3+0x134>
  8018d9:	0f 84 91 00 00 00    	je     801970 <__umoddi3+0x144>
  8018df:	8b 54 24 04          	mov    0x4(%esp),%edx
  8018e3:	29 f2                	sub    %esi,%edx
  8018e5:	19 cb                	sbb    %ecx,%ebx
  8018e7:	89 d8                	mov    %ebx,%eax
  8018e9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8018ed:	d3 e0                	shl    %cl,%eax
  8018ef:	89 e9                	mov    %ebp,%ecx
  8018f1:	d3 ea                	shr    %cl,%edx
  8018f3:	09 d0                	or     %edx,%eax
  8018f5:	89 e9                	mov    %ebp,%ecx
  8018f7:	d3 eb                	shr    %cl,%ebx
  8018f9:	89 da                	mov    %ebx,%edx
  8018fb:	83 c4 1c             	add    $0x1c,%esp
  8018fe:	5b                   	pop    %ebx
  8018ff:	5e                   	pop    %esi
  801900:	5f                   	pop    %edi
  801901:	5d                   	pop    %ebp
  801902:	c3                   	ret    
  801903:	90                   	nop
  801904:	89 fd                	mov    %edi,%ebp
  801906:	85 ff                	test   %edi,%edi
  801908:	75 0b                	jne    801915 <__umoddi3+0xe9>
  80190a:	b8 01 00 00 00       	mov    $0x1,%eax
  80190f:	31 d2                	xor    %edx,%edx
  801911:	f7 f7                	div    %edi
  801913:	89 c5                	mov    %eax,%ebp
  801915:	89 f0                	mov    %esi,%eax
  801917:	31 d2                	xor    %edx,%edx
  801919:	f7 f5                	div    %ebp
  80191b:	89 c8                	mov    %ecx,%eax
  80191d:	f7 f5                	div    %ebp
  80191f:	89 d0                	mov    %edx,%eax
  801921:	e9 44 ff ff ff       	jmp    80186a <__umoddi3+0x3e>
  801926:	66 90                	xchg   %ax,%ax
  801928:	89 c8                	mov    %ecx,%eax
  80192a:	89 f2                	mov    %esi,%edx
  80192c:	83 c4 1c             	add    $0x1c,%esp
  80192f:	5b                   	pop    %ebx
  801930:	5e                   	pop    %esi
  801931:	5f                   	pop    %edi
  801932:	5d                   	pop    %ebp
  801933:	c3                   	ret    
  801934:	3b 04 24             	cmp    (%esp),%eax
  801937:	72 06                	jb     80193f <__umoddi3+0x113>
  801939:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80193d:	77 0f                	ja     80194e <__umoddi3+0x122>
  80193f:	89 f2                	mov    %esi,%edx
  801941:	29 f9                	sub    %edi,%ecx
  801943:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801947:	89 14 24             	mov    %edx,(%esp)
  80194a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80194e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801952:	8b 14 24             	mov    (%esp),%edx
  801955:	83 c4 1c             	add    $0x1c,%esp
  801958:	5b                   	pop    %ebx
  801959:	5e                   	pop    %esi
  80195a:	5f                   	pop    %edi
  80195b:	5d                   	pop    %ebp
  80195c:	c3                   	ret    
  80195d:	8d 76 00             	lea    0x0(%esi),%esi
  801960:	2b 04 24             	sub    (%esp),%eax
  801963:	19 fa                	sbb    %edi,%edx
  801965:	89 d1                	mov    %edx,%ecx
  801967:	89 c6                	mov    %eax,%esi
  801969:	e9 71 ff ff ff       	jmp    8018df <__umoddi3+0xb3>
  80196e:	66 90                	xchg   %ax,%ax
  801970:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801974:	72 ea                	jb     801960 <__umoddi3+0x134>
  801976:	89 d9                	mov    %ebx,%ecx
  801978:	e9 62 ff ff ff       	jmp    8018df <__umoddi3+0xb3>
