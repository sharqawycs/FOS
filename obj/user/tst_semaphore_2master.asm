
obj/user/tst_semaphore_2master:     file format elf32-i386


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
  800031:	e8 69 01 00 00       	call   80019f <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Master program: take user input, create the semaphores, run slaves and wait them to finish
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 28 01 00 00    	sub    $0x128,%esp
	int envID = sys_getenvid();
  800041:	e8 47 13 00 00       	call   80138d <sys_getenvid>
  800046:	89 45 f0             	mov    %eax,-0x10(%ebp)
	char line[256] ;
	readline("Enter total number of customers: ", line) ;
  800049:	83 ec 08             	sub    $0x8,%esp
  80004c:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  800052:	50                   	push   %eax
  800053:	68 40 1c 80 00       	push   $0x801c40
  800058:	e8 9a 09 00 00       	call   8009f7 <readline>
  80005d:	83 c4 10             	add    $0x10,%esp
	int totalNumOfCusts = strtol(line, NULL, 10);
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	6a 0a                	push   $0xa
  800065:	6a 00                	push   $0x0
  800067:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  80006d:	50                   	push   %eax
  80006e:	e8 ea 0e 00 00       	call   800f5d <strtol>
  800073:	83 c4 10             	add    $0x10,%esp
  800076:	89 45 ec             	mov    %eax,-0x14(%ebp)
	readline("Enter shop capacity: ", line) ;
  800079:	83 ec 08             	sub    $0x8,%esp
  80007c:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  800082:	50                   	push   %eax
  800083:	68 62 1c 80 00       	push   $0x801c62
  800088:	e8 6a 09 00 00       	call   8009f7 <readline>
  80008d:	83 c4 10             	add    $0x10,%esp
	int shopCapacity = strtol(line, NULL, 10);
  800090:	83 ec 04             	sub    $0x4,%esp
  800093:	6a 0a                	push   $0xa
  800095:	6a 00                	push   $0x0
  800097:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  80009d:	50                   	push   %eax
  80009e:	e8 ba 0e 00 00       	call   800f5d <strtol>
  8000a3:	83 c4 10             	add    $0x10,%esp
  8000a6:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sys_createSemaphore("shopCapacity", shopCapacity);
  8000a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000ac:	83 ec 08             	sub    $0x8,%esp
  8000af:	50                   	push   %eax
  8000b0:	68 78 1c 80 00       	push   $0x801c78
  8000b5:	e8 fb 14 00 00       	call   8015b5 <sys_createSemaphore>
  8000ba:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore("depend", 0);
  8000bd:	83 ec 08             	sub    $0x8,%esp
  8000c0:	6a 00                	push   $0x0
  8000c2:	68 85 1c 80 00       	push   $0x801c85
  8000c7:	e8 e9 14 00 00       	call   8015b5 <sys_createSemaphore>
  8000cc:	83 c4 10             	add    $0x10,%esp

	int i = 0 ;
  8000cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int id ;
	for (; i<totalNumOfCusts; i++)
  8000d6:	eb 39                	jmp    800111 <_main+0xd9>
	{
		id = sys_create_env("sem2Slave", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000d8:	a1 04 30 80 00       	mov    0x803004,%eax
  8000dd:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8000e3:	a1 04 30 80 00       	mov    0x803004,%eax
  8000e8:	8b 40 74             	mov    0x74(%eax),%eax
  8000eb:	83 ec 04             	sub    $0x4,%esp
  8000ee:	52                   	push   %edx
  8000ef:	50                   	push   %eax
  8000f0:	68 8c 1c 80 00       	push   $0x801c8c
  8000f5:	e8 cc 15 00 00       	call   8016c6 <sys_create_env>
  8000fa:	83 c4 10             	add    $0x10,%esp
  8000fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		sys_run_env(id) ;
  800100:	83 ec 0c             	sub    $0xc,%esp
  800103:	ff 75 e4             	pushl  -0x1c(%ebp)
  800106:	e8 d8 15 00 00       	call   8016e3 <sys_run_env>
  80010b:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore("shopCapacity", shopCapacity);
	sys_createSemaphore("depend", 0);

	int i = 0 ;
	int id ;
	for (; i<totalNumOfCusts; i++)
  80010e:	ff 45 f4             	incl   -0xc(%ebp)
  800111:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800114:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800117:	7c bf                	jl     8000d8 <_main+0xa0>
	{
		id = sys_create_env("sem2Slave", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(id) ;
	}

	for (i = 0 ; i<totalNumOfCusts; i++)
  800119:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800120:	eb 16                	jmp    800138 <_main+0x100>
	{
		sys_waitSemaphore(envID, "depend") ;
  800122:	83 ec 08             	sub    $0x8,%esp
  800125:	68 85 1c 80 00       	push   $0x801c85
  80012a:	ff 75 f0             	pushl  -0x10(%ebp)
  80012d:	e8 bc 14 00 00       	call   8015ee <sys_waitSemaphore>
  800132:	83 c4 10             	add    $0x10,%esp
	{
		id = sys_create_env("sem2Slave", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(id) ;
	}

	for (i = 0 ; i<totalNumOfCusts; i++)
  800135:	ff 45 f4             	incl   -0xc(%ebp)
  800138:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80013b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80013e:	7c e2                	jl     800122 <_main+0xea>
	{
		sys_waitSemaphore(envID, "depend") ;
	}
	int sem1val = sys_getSemaphoreValue(envID, "shopCapacity");
  800140:	83 ec 08             	sub    $0x8,%esp
  800143:	68 78 1c 80 00       	push   $0x801c78
  800148:	ff 75 f0             	pushl  -0x10(%ebp)
  80014b:	e8 81 14 00 00       	call   8015d1 <sys_getSemaphoreValue>
  800150:	83 c4 10             	add    $0x10,%esp
  800153:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int sem2val = sys_getSemaphoreValue(envID, "depend");
  800156:	83 ec 08             	sub    $0x8,%esp
  800159:	68 85 1c 80 00       	push   $0x801c85
  80015e:	ff 75 f0             	pushl  -0x10(%ebp)
  800161:	e8 6b 14 00 00       	call   8015d1 <sys_getSemaphoreValue>
  800166:	83 c4 10             	add    $0x10,%esp
  800169:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if (sem2val == 0 && sem1val == shopCapacity)
  80016c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800170:	75 1a                	jne    80018c <_main+0x154>
  800172:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800175:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  800178:	75 12                	jne    80018c <_main+0x154>
		cprintf("Congratulations!! Test of Semaphores [2] completed successfully!!\n\n\n");
  80017a:	83 ec 0c             	sub    $0xc,%esp
  80017d:	68 98 1c 80 00       	push   $0x801c98
  800182:	e8 ee 01 00 00       	call   800375 <cprintf>
  800187:	83 c4 10             	add    $0x10,%esp
  80018a:	eb 10                	jmp    80019c <_main+0x164>
	else
		cprintf("Error: wrong semaphore value... please review your semaphore code again...");
  80018c:	83 ec 0c             	sub    $0xc,%esp
  80018f:	68 e0 1c 80 00       	push   $0x801ce0
  800194:	e8 dc 01 00 00       	call   800375 <cprintf>
  800199:	83 c4 10             	add    $0x10,%esp

	return;
  80019c:	90                   	nop
}
  80019d:	c9                   	leave  
  80019e:	c3                   	ret    

0080019f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80019f:	55                   	push   %ebp
  8001a0:	89 e5                	mov    %esp,%ebp
  8001a2:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001a5:	e8 fc 11 00 00       	call   8013a6 <sys_getenvindex>
  8001aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001b0:	89 d0                	mov    %edx,%eax
  8001b2:	01 c0                	add    %eax,%eax
  8001b4:	01 d0                	add    %edx,%eax
  8001b6:	c1 e0 02             	shl    $0x2,%eax
  8001b9:	01 d0                	add    %edx,%eax
  8001bb:	c1 e0 06             	shl    $0x6,%eax
  8001be:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8001c3:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001c8:	a1 04 30 80 00       	mov    0x803004,%eax
  8001cd:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8001d3:	84 c0                	test   %al,%al
  8001d5:	74 0f                	je     8001e6 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8001d7:	a1 04 30 80 00       	mov    0x803004,%eax
  8001dc:	05 f4 02 00 00       	add    $0x2f4,%eax
  8001e1:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001e6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001ea:	7e 0a                	jle    8001f6 <libmain+0x57>
		binaryname = argv[0];
  8001ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ef:	8b 00                	mov    (%eax),%eax
  8001f1:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001f6:	83 ec 08             	sub    $0x8,%esp
  8001f9:	ff 75 0c             	pushl  0xc(%ebp)
  8001fc:	ff 75 08             	pushl  0x8(%ebp)
  8001ff:	e8 34 fe ff ff       	call   800038 <_main>
  800204:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800207:	e8 35 13 00 00       	call   801541 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80020c:	83 ec 0c             	sub    $0xc,%esp
  80020f:	68 44 1d 80 00       	push   $0x801d44
  800214:	e8 5c 01 00 00       	call   800375 <cprintf>
  800219:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80021c:	a1 04 30 80 00       	mov    0x803004,%eax
  800221:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800227:	a1 04 30 80 00       	mov    0x803004,%eax
  80022c:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800232:	83 ec 04             	sub    $0x4,%esp
  800235:	52                   	push   %edx
  800236:	50                   	push   %eax
  800237:	68 6c 1d 80 00       	push   $0x801d6c
  80023c:	e8 34 01 00 00       	call   800375 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800244:	a1 04 30 80 00       	mov    0x803004,%eax
  800249:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80024f:	83 ec 08             	sub    $0x8,%esp
  800252:	50                   	push   %eax
  800253:	68 91 1d 80 00       	push   $0x801d91
  800258:	e8 18 01 00 00       	call   800375 <cprintf>
  80025d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800260:	83 ec 0c             	sub    $0xc,%esp
  800263:	68 44 1d 80 00       	push   $0x801d44
  800268:	e8 08 01 00 00       	call   800375 <cprintf>
  80026d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800270:	e8 e6 12 00 00       	call   80155b <sys_enable_interrupt>

	// exit gracefully
	exit();
  800275:	e8 19 00 00 00       	call   800293 <exit>
}
  80027a:	90                   	nop
  80027b:	c9                   	leave  
  80027c:	c3                   	ret    

0080027d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80027d:	55                   	push   %ebp
  80027e:	89 e5                	mov    %esp,%ebp
  800280:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800283:	83 ec 0c             	sub    $0xc,%esp
  800286:	6a 00                	push   $0x0
  800288:	e8 e5 10 00 00       	call   801372 <sys_env_destroy>
  80028d:	83 c4 10             	add    $0x10,%esp
}
  800290:	90                   	nop
  800291:	c9                   	leave  
  800292:	c3                   	ret    

00800293 <exit>:

void
exit(void)
{
  800293:	55                   	push   %ebp
  800294:	89 e5                	mov    %esp,%ebp
  800296:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800299:	e8 3a 11 00 00       	call   8013d8 <sys_env_exit>
}
  80029e:	90                   	nop
  80029f:	c9                   	leave  
  8002a0:	c3                   	ret    

008002a1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8002a1:	55                   	push   %ebp
  8002a2:	89 e5                	mov    %esp,%ebp
  8002a4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8002a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002aa:	8b 00                	mov    (%eax),%eax
  8002ac:	8d 48 01             	lea    0x1(%eax),%ecx
  8002af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002b2:	89 0a                	mov    %ecx,(%edx)
  8002b4:	8b 55 08             	mov    0x8(%ebp),%edx
  8002b7:	88 d1                	mov    %dl,%cl
  8002b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002bc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8002c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c3:	8b 00                	mov    (%eax),%eax
  8002c5:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002ca:	75 2c                	jne    8002f8 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8002cc:	a0 08 30 80 00       	mov    0x803008,%al
  8002d1:	0f b6 c0             	movzbl %al,%eax
  8002d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002d7:	8b 12                	mov    (%edx),%edx
  8002d9:	89 d1                	mov    %edx,%ecx
  8002db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002de:	83 c2 08             	add    $0x8,%edx
  8002e1:	83 ec 04             	sub    $0x4,%esp
  8002e4:	50                   	push   %eax
  8002e5:	51                   	push   %ecx
  8002e6:	52                   	push   %edx
  8002e7:	e8 44 10 00 00       	call   801330 <sys_cputs>
  8002ec:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002fb:	8b 40 04             	mov    0x4(%eax),%eax
  8002fe:	8d 50 01             	lea    0x1(%eax),%edx
  800301:	8b 45 0c             	mov    0xc(%ebp),%eax
  800304:	89 50 04             	mov    %edx,0x4(%eax)
}
  800307:	90                   	nop
  800308:	c9                   	leave  
  800309:	c3                   	ret    

0080030a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80030a:	55                   	push   %ebp
  80030b:	89 e5                	mov    %esp,%ebp
  80030d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800313:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80031a:	00 00 00 
	b.cnt = 0;
  80031d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800324:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800327:	ff 75 0c             	pushl  0xc(%ebp)
  80032a:	ff 75 08             	pushl  0x8(%ebp)
  80032d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800333:	50                   	push   %eax
  800334:	68 a1 02 80 00       	push   $0x8002a1
  800339:	e8 11 02 00 00       	call   80054f <vprintfmt>
  80033e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800341:	a0 08 30 80 00       	mov    0x803008,%al
  800346:	0f b6 c0             	movzbl %al,%eax
  800349:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80034f:	83 ec 04             	sub    $0x4,%esp
  800352:	50                   	push   %eax
  800353:	52                   	push   %edx
  800354:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80035a:	83 c0 08             	add    $0x8,%eax
  80035d:	50                   	push   %eax
  80035e:	e8 cd 0f 00 00       	call   801330 <sys_cputs>
  800363:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800366:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  80036d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800373:	c9                   	leave  
  800374:	c3                   	ret    

00800375 <cprintf>:

int cprintf(const char *fmt, ...) {
  800375:	55                   	push   %ebp
  800376:	89 e5                	mov    %esp,%ebp
  800378:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80037b:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800382:	8d 45 0c             	lea    0xc(%ebp),%eax
  800385:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800388:	8b 45 08             	mov    0x8(%ebp),%eax
  80038b:	83 ec 08             	sub    $0x8,%esp
  80038e:	ff 75 f4             	pushl  -0xc(%ebp)
  800391:	50                   	push   %eax
  800392:	e8 73 ff ff ff       	call   80030a <vcprintf>
  800397:	83 c4 10             	add    $0x10,%esp
  80039a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80039d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003a0:	c9                   	leave  
  8003a1:	c3                   	ret    

008003a2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8003a2:	55                   	push   %ebp
  8003a3:	89 e5                	mov    %esp,%ebp
  8003a5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8003a8:	e8 94 11 00 00       	call   801541 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8003ad:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b6:	83 ec 08             	sub    $0x8,%esp
  8003b9:	ff 75 f4             	pushl  -0xc(%ebp)
  8003bc:	50                   	push   %eax
  8003bd:	e8 48 ff ff ff       	call   80030a <vcprintf>
  8003c2:	83 c4 10             	add    $0x10,%esp
  8003c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8003c8:	e8 8e 11 00 00       	call   80155b <sys_enable_interrupt>
	return cnt;
  8003cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003d0:	c9                   	leave  
  8003d1:	c3                   	ret    

008003d2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8003d2:	55                   	push   %ebp
  8003d3:	89 e5                	mov    %esp,%ebp
  8003d5:	53                   	push   %ebx
  8003d6:	83 ec 14             	sub    $0x14,%esp
  8003d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8003dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8003df:	8b 45 14             	mov    0x14(%ebp),%eax
  8003e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003e5:	8b 45 18             	mov    0x18(%ebp),%eax
  8003e8:	ba 00 00 00 00       	mov    $0x0,%edx
  8003ed:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003f0:	77 55                	ja     800447 <printnum+0x75>
  8003f2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003f5:	72 05                	jb     8003fc <printnum+0x2a>
  8003f7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003fa:	77 4b                	ja     800447 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003fc:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003ff:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800402:	8b 45 18             	mov    0x18(%ebp),%eax
  800405:	ba 00 00 00 00       	mov    $0x0,%edx
  80040a:	52                   	push   %edx
  80040b:	50                   	push   %eax
  80040c:	ff 75 f4             	pushl  -0xc(%ebp)
  80040f:	ff 75 f0             	pushl  -0x10(%ebp)
  800412:	e8 a9 15 00 00       	call   8019c0 <__udivdi3>
  800417:	83 c4 10             	add    $0x10,%esp
  80041a:	83 ec 04             	sub    $0x4,%esp
  80041d:	ff 75 20             	pushl  0x20(%ebp)
  800420:	53                   	push   %ebx
  800421:	ff 75 18             	pushl  0x18(%ebp)
  800424:	52                   	push   %edx
  800425:	50                   	push   %eax
  800426:	ff 75 0c             	pushl  0xc(%ebp)
  800429:	ff 75 08             	pushl  0x8(%ebp)
  80042c:	e8 a1 ff ff ff       	call   8003d2 <printnum>
  800431:	83 c4 20             	add    $0x20,%esp
  800434:	eb 1a                	jmp    800450 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800436:	83 ec 08             	sub    $0x8,%esp
  800439:	ff 75 0c             	pushl  0xc(%ebp)
  80043c:	ff 75 20             	pushl  0x20(%ebp)
  80043f:	8b 45 08             	mov    0x8(%ebp),%eax
  800442:	ff d0                	call   *%eax
  800444:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800447:	ff 4d 1c             	decl   0x1c(%ebp)
  80044a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80044e:	7f e6                	jg     800436 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800450:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800453:	bb 00 00 00 00       	mov    $0x0,%ebx
  800458:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80045b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80045e:	53                   	push   %ebx
  80045f:	51                   	push   %ecx
  800460:	52                   	push   %edx
  800461:	50                   	push   %eax
  800462:	e8 69 16 00 00       	call   801ad0 <__umoddi3>
  800467:	83 c4 10             	add    $0x10,%esp
  80046a:	05 d4 1f 80 00       	add    $0x801fd4,%eax
  80046f:	8a 00                	mov    (%eax),%al
  800471:	0f be c0             	movsbl %al,%eax
  800474:	83 ec 08             	sub    $0x8,%esp
  800477:	ff 75 0c             	pushl  0xc(%ebp)
  80047a:	50                   	push   %eax
  80047b:	8b 45 08             	mov    0x8(%ebp),%eax
  80047e:	ff d0                	call   *%eax
  800480:	83 c4 10             	add    $0x10,%esp
}
  800483:	90                   	nop
  800484:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800487:	c9                   	leave  
  800488:	c3                   	ret    

00800489 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800489:	55                   	push   %ebp
  80048a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80048c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800490:	7e 1c                	jle    8004ae <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800492:	8b 45 08             	mov    0x8(%ebp),%eax
  800495:	8b 00                	mov    (%eax),%eax
  800497:	8d 50 08             	lea    0x8(%eax),%edx
  80049a:	8b 45 08             	mov    0x8(%ebp),%eax
  80049d:	89 10                	mov    %edx,(%eax)
  80049f:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a2:	8b 00                	mov    (%eax),%eax
  8004a4:	83 e8 08             	sub    $0x8,%eax
  8004a7:	8b 50 04             	mov    0x4(%eax),%edx
  8004aa:	8b 00                	mov    (%eax),%eax
  8004ac:	eb 40                	jmp    8004ee <getuint+0x65>
	else if (lflag)
  8004ae:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004b2:	74 1e                	je     8004d2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8004b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b7:	8b 00                	mov    (%eax),%eax
  8004b9:	8d 50 04             	lea    0x4(%eax),%edx
  8004bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bf:	89 10                	mov    %edx,(%eax)
  8004c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c4:	8b 00                	mov    (%eax),%eax
  8004c6:	83 e8 04             	sub    $0x4,%eax
  8004c9:	8b 00                	mov    (%eax),%eax
  8004cb:	ba 00 00 00 00       	mov    $0x0,%edx
  8004d0:	eb 1c                	jmp    8004ee <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8004d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d5:	8b 00                	mov    (%eax),%eax
  8004d7:	8d 50 04             	lea    0x4(%eax),%edx
  8004da:	8b 45 08             	mov    0x8(%ebp),%eax
  8004dd:	89 10                	mov    %edx,(%eax)
  8004df:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e2:	8b 00                	mov    (%eax),%eax
  8004e4:	83 e8 04             	sub    $0x4,%eax
  8004e7:	8b 00                	mov    (%eax),%eax
  8004e9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004ee:	5d                   	pop    %ebp
  8004ef:	c3                   	ret    

008004f0 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004f0:	55                   	push   %ebp
  8004f1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004f3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004f7:	7e 1c                	jle    800515 <getint+0x25>
		return va_arg(*ap, long long);
  8004f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fc:	8b 00                	mov    (%eax),%eax
  8004fe:	8d 50 08             	lea    0x8(%eax),%edx
  800501:	8b 45 08             	mov    0x8(%ebp),%eax
  800504:	89 10                	mov    %edx,(%eax)
  800506:	8b 45 08             	mov    0x8(%ebp),%eax
  800509:	8b 00                	mov    (%eax),%eax
  80050b:	83 e8 08             	sub    $0x8,%eax
  80050e:	8b 50 04             	mov    0x4(%eax),%edx
  800511:	8b 00                	mov    (%eax),%eax
  800513:	eb 38                	jmp    80054d <getint+0x5d>
	else if (lflag)
  800515:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800519:	74 1a                	je     800535 <getint+0x45>
		return va_arg(*ap, long);
  80051b:	8b 45 08             	mov    0x8(%ebp),%eax
  80051e:	8b 00                	mov    (%eax),%eax
  800520:	8d 50 04             	lea    0x4(%eax),%edx
  800523:	8b 45 08             	mov    0x8(%ebp),%eax
  800526:	89 10                	mov    %edx,(%eax)
  800528:	8b 45 08             	mov    0x8(%ebp),%eax
  80052b:	8b 00                	mov    (%eax),%eax
  80052d:	83 e8 04             	sub    $0x4,%eax
  800530:	8b 00                	mov    (%eax),%eax
  800532:	99                   	cltd   
  800533:	eb 18                	jmp    80054d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800535:	8b 45 08             	mov    0x8(%ebp),%eax
  800538:	8b 00                	mov    (%eax),%eax
  80053a:	8d 50 04             	lea    0x4(%eax),%edx
  80053d:	8b 45 08             	mov    0x8(%ebp),%eax
  800540:	89 10                	mov    %edx,(%eax)
  800542:	8b 45 08             	mov    0x8(%ebp),%eax
  800545:	8b 00                	mov    (%eax),%eax
  800547:	83 e8 04             	sub    $0x4,%eax
  80054a:	8b 00                	mov    (%eax),%eax
  80054c:	99                   	cltd   
}
  80054d:	5d                   	pop    %ebp
  80054e:	c3                   	ret    

0080054f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80054f:	55                   	push   %ebp
  800550:	89 e5                	mov    %esp,%ebp
  800552:	56                   	push   %esi
  800553:	53                   	push   %ebx
  800554:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800557:	eb 17                	jmp    800570 <vprintfmt+0x21>
			if (ch == '\0')
  800559:	85 db                	test   %ebx,%ebx
  80055b:	0f 84 af 03 00 00    	je     800910 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800561:	83 ec 08             	sub    $0x8,%esp
  800564:	ff 75 0c             	pushl  0xc(%ebp)
  800567:	53                   	push   %ebx
  800568:	8b 45 08             	mov    0x8(%ebp),%eax
  80056b:	ff d0                	call   *%eax
  80056d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800570:	8b 45 10             	mov    0x10(%ebp),%eax
  800573:	8d 50 01             	lea    0x1(%eax),%edx
  800576:	89 55 10             	mov    %edx,0x10(%ebp)
  800579:	8a 00                	mov    (%eax),%al
  80057b:	0f b6 d8             	movzbl %al,%ebx
  80057e:	83 fb 25             	cmp    $0x25,%ebx
  800581:	75 d6                	jne    800559 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800583:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800587:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80058e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800595:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80059c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8005a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8005a6:	8d 50 01             	lea    0x1(%eax),%edx
  8005a9:	89 55 10             	mov    %edx,0x10(%ebp)
  8005ac:	8a 00                	mov    (%eax),%al
  8005ae:	0f b6 d8             	movzbl %al,%ebx
  8005b1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8005b4:	83 f8 55             	cmp    $0x55,%eax
  8005b7:	0f 87 2b 03 00 00    	ja     8008e8 <vprintfmt+0x399>
  8005bd:	8b 04 85 f8 1f 80 00 	mov    0x801ff8(,%eax,4),%eax
  8005c4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8005c6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8005ca:	eb d7                	jmp    8005a3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8005cc:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8005d0:	eb d1                	jmp    8005a3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005d2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8005d9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005dc:	89 d0                	mov    %edx,%eax
  8005de:	c1 e0 02             	shl    $0x2,%eax
  8005e1:	01 d0                	add    %edx,%eax
  8005e3:	01 c0                	add    %eax,%eax
  8005e5:	01 d8                	add    %ebx,%eax
  8005e7:	83 e8 30             	sub    $0x30,%eax
  8005ea:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8005f0:	8a 00                	mov    (%eax),%al
  8005f2:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8005f5:	83 fb 2f             	cmp    $0x2f,%ebx
  8005f8:	7e 3e                	jle    800638 <vprintfmt+0xe9>
  8005fa:	83 fb 39             	cmp    $0x39,%ebx
  8005fd:	7f 39                	jg     800638 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005ff:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800602:	eb d5                	jmp    8005d9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800604:	8b 45 14             	mov    0x14(%ebp),%eax
  800607:	83 c0 04             	add    $0x4,%eax
  80060a:	89 45 14             	mov    %eax,0x14(%ebp)
  80060d:	8b 45 14             	mov    0x14(%ebp),%eax
  800610:	83 e8 04             	sub    $0x4,%eax
  800613:	8b 00                	mov    (%eax),%eax
  800615:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800618:	eb 1f                	jmp    800639 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80061a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80061e:	79 83                	jns    8005a3 <vprintfmt+0x54>
				width = 0;
  800620:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800627:	e9 77 ff ff ff       	jmp    8005a3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80062c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800633:	e9 6b ff ff ff       	jmp    8005a3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800638:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800639:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80063d:	0f 89 60 ff ff ff    	jns    8005a3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800643:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800646:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800649:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800650:	e9 4e ff ff ff       	jmp    8005a3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800655:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800658:	e9 46 ff ff ff       	jmp    8005a3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80065d:	8b 45 14             	mov    0x14(%ebp),%eax
  800660:	83 c0 04             	add    $0x4,%eax
  800663:	89 45 14             	mov    %eax,0x14(%ebp)
  800666:	8b 45 14             	mov    0x14(%ebp),%eax
  800669:	83 e8 04             	sub    $0x4,%eax
  80066c:	8b 00                	mov    (%eax),%eax
  80066e:	83 ec 08             	sub    $0x8,%esp
  800671:	ff 75 0c             	pushl  0xc(%ebp)
  800674:	50                   	push   %eax
  800675:	8b 45 08             	mov    0x8(%ebp),%eax
  800678:	ff d0                	call   *%eax
  80067a:	83 c4 10             	add    $0x10,%esp
			break;
  80067d:	e9 89 02 00 00       	jmp    80090b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800682:	8b 45 14             	mov    0x14(%ebp),%eax
  800685:	83 c0 04             	add    $0x4,%eax
  800688:	89 45 14             	mov    %eax,0x14(%ebp)
  80068b:	8b 45 14             	mov    0x14(%ebp),%eax
  80068e:	83 e8 04             	sub    $0x4,%eax
  800691:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800693:	85 db                	test   %ebx,%ebx
  800695:	79 02                	jns    800699 <vprintfmt+0x14a>
				err = -err;
  800697:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800699:	83 fb 64             	cmp    $0x64,%ebx
  80069c:	7f 0b                	jg     8006a9 <vprintfmt+0x15a>
  80069e:	8b 34 9d 40 1e 80 00 	mov    0x801e40(,%ebx,4),%esi
  8006a5:	85 f6                	test   %esi,%esi
  8006a7:	75 19                	jne    8006c2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8006a9:	53                   	push   %ebx
  8006aa:	68 e5 1f 80 00       	push   $0x801fe5
  8006af:	ff 75 0c             	pushl  0xc(%ebp)
  8006b2:	ff 75 08             	pushl  0x8(%ebp)
  8006b5:	e8 5e 02 00 00       	call   800918 <printfmt>
  8006ba:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8006bd:	e9 49 02 00 00       	jmp    80090b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8006c2:	56                   	push   %esi
  8006c3:	68 ee 1f 80 00       	push   $0x801fee
  8006c8:	ff 75 0c             	pushl  0xc(%ebp)
  8006cb:	ff 75 08             	pushl  0x8(%ebp)
  8006ce:	e8 45 02 00 00       	call   800918 <printfmt>
  8006d3:	83 c4 10             	add    $0x10,%esp
			break;
  8006d6:	e9 30 02 00 00       	jmp    80090b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8006db:	8b 45 14             	mov    0x14(%ebp),%eax
  8006de:	83 c0 04             	add    $0x4,%eax
  8006e1:	89 45 14             	mov    %eax,0x14(%ebp)
  8006e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8006e7:	83 e8 04             	sub    $0x4,%eax
  8006ea:	8b 30                	mov    (%eax),%esi
  8006ec:	85 f6                	test   %esi,%esi
  8006ee:	75 05                	jne    8006f5 <vprintfmt+0x1a6>
				p = "(null)";
  8006f0:	be f1 1f 80 00       	mov    $0x801ff1,%esi
			if (width > 0 && padc != '-')
  8006f5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006f9:	7e 6d                	jle    800768 <vprintfmt+0x219>
  8006fb:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006ff:	74 67                	je     800768 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800701:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800704:	83 ec 08             	sub    $0x8,%esp
  800707:	50                   	push   %eax
  800708:	56                   	push   %esi
  800709:	e8 12 05 00 00       	call   800c20 <strnlen>
  80070e:	83 c4 10             	add    $0x10,%esp
  800711:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800714:	eb 16                	jmp    80072c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800716:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80071a:	83 ec 08             	sub    $0x8,%esp
  80071d:	ff 75 0c             	pushl  0xc(%ebp)
  800720:	50                   	push   %eax
  800721:	8b 45 08             	mov    0x8(%ebp),%eax
  800724:	ff d0                	call   *%eax
  800726:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800729:	ff 4d e4             	decl   -0x1c(%ebp)
  80072c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800730:	7f e4                	jg     800716 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800732:	eb 34                	jmp    800768 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800734:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800738:	74 1c                	je     800756 <vprintfmt+0x207>
  80073a:	83 fb 1f             	cmp    $0x1f,%ebx
  80073d:	7e 05                	jle    800744 <vprintfmt+0x1f5>
  80073f:	83 fb 7e             	cmp    $0x7e,%ebx
  800742:	7e 12                	jle    800756 <vprintfmt+0x207>
					putch('?', putdat);
  800744:	83 ec 08             	sub    $0x8,%esp
  800747:	ff 75 0c             	pushl  0xc(%ebp)
  80074a:	6a 3f                	push   $0x3f
  80074c:	8b 45 08             	mov    0x8(%ebp),%eax
  80074f:	ff d0                	call   *%eax
  800751:	83 c4 10             	add    $0x10,%esp
  800754:	eb 0f                	jmp    800765 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800756:	83 ec 08             	sub    $0x8,%esp
  800759:	ff 75 0c             	pushl  0xc(%ebp)
  80075c:	53                   	push   %ebx
  80075d:	8b 45 08             	mov    0x8(%ebp),%eax
  800760:	ff d0                	call   *%eax
  800762:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800765:	ff 4d e4             	decl   -0x1c(%ebp)
  800768:	89 f0                	mov    %esi,%eax
  80076a:	8d 70 01             	lea    0x1(%eax),%esi
  80076d:	8a 00                	mov    (%eax),%al
  80076f:	0f be d8             	movsbl %al,%ebx
  800772:	85 db                	test   %ebx,%ebx
  800774:	74 24                	je     80079a <vprintfmt+0x24b>
  800776:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80077a:	78 b8                	js     800734 <vprintfmt+0x1e5>
  80077c:	ff 4d e0             	decl   -0x20(%ebp)
  80077f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800783:	79 af                	jns    800734 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800785:	eb 13                	jmp    80079a <vprintfmt+0x24b>
				putch(' ', putdat);
  800787:	83 ec 08             	sub    $0x8,%esp
  80078a:	ff 75 0c             	pushl  0xc(%ebp)
  80078d:	6a 20                	push   $0x20
  80078f:	8b 45 08             	mov    0x8(%ebp),%eax
  800792:	ff d0                	call   *%eax
  800794:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800797:	ff 4d e4             	decl   -0x1c(%ebp)
  80079a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80079e:	7f e7                	jg     800787 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8007a0:	e9 66 01 00 00       	jmp    80090b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8007a5:	83 ec 08             	sub    $0x8,%esp
  8007a8:	ff 75 e8             	pushl  -0x18(%ebp)
  8007ab:	8d 45 14             	lea    0x14(%ebp),%eax
  8007ae:	50                   	push   %eax
  8007af:	e8 3c fd ff ff       	call   8004f0 <getint>
  8007b4:	83 c4 10             	add    $0x10,%esp
  8007b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ba:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8007bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007c3:	85 d2                	test   %edx,%edx
  8007c5:	79 23                	jns    8007ea <vprintfmt+0x29b>
				putch('-', putdat);
  8007c7:	83 ec 08             	sub    $0x8,%esp
  8007ca:	ff 75 0c             	pushl  0xc(%ebp)
  8007cd:	6a 2d                	push   $0x2d
  8007cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d2:	ff d0                	call   *%eax
  8007d4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8007d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007dd:	f7 d8                	neg    %eax
  8007df:	83 d2 00             	adc    $0x0,%edx
  8007e2:	f7 da                	neg    %edx
  8007e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007e7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007ea:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007f1:	e9 bc 00 00 00       	jmp    8008b2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8007f6:	83 ec 08             	sub    $0x8,%esp
  8007f9:	ff 75 e8             	pushl  -0x18(%ebp)
  8007fc:	8d 45 14             	lea    0x14(%ebp),%eax
  8007ff:	50                   	push   %eax
  800800:	e8 84 fc ff ff       	call   800489 <getuint>
  800805:	83 c4 10             	add    $0x10,%esp
  800808:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80080b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80080e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800815:	e9 98 00 00 00       	jmp    8008b2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80081a:	83 ec 08             	sub    $0x8,%esp
  80081d:	ff 75 0c             	pushl  0xc(%ebp)
  800820:	6a 58                	push   $0x58
  800822:	8b 45 08             	mov    0x8(%ebp),%eax
  800825:	ff d0                	call   *%eax
  800827:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80082a:	83 ec 08             	sub    $0x8,%esp
  80082d:	ff 75 0c             	pushl  0xc(%ebp)
  800830:	6a 58                	push   $0x58
  800832:	8b 45 08             	mov    0x8(%ebp),%eax
  800835:	ff d0                	call   *%eax
  800837:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80083a:	83 ec 08             	sub    $0x8,%esp
  80083d:	ff 75 0c             	pushl  0xc(%ebp)
  800840:	6a 58                	push   $0x58
  800842:	8b 45 08             	mov    0x8(%ebp),%eax
  800845:	ff d0                	call   *%eax
  800847:	83 c4 10             	add    $0x10,%esp
			break;
  80084a:	e9 bc 00 00 00       	jmp    80090b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80084f:	83 ec 08             	sub    $0x8,%esp
  800852:	ff 75 0c             	pushl  0xc(%ebp)
  800855:	6a 30                	push   $0x30
  800857:	8b 45 08             	mov    0x8(%ebp),%eax
  80085a:	ff d0                	call   *%eax
  80085c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80085f:	83 ec 08             	sub    $0x8,%esp
  800862:	ff 75 0c             	pushl  0xc(%ebp)
  800865:	6a 78                	push   $0x78
  800867:	8b 45 08             	mov    0x8(%ebp),%eax
  80086a:	ff d0                	call   *%eax
  80086c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80086f:	8b 45 14             	mov    0x14(%ebp),%eax
  800872:	83 c0 04             	add    $0x4,%eax
  800875:	89 45 14             	mov    %eax,0x14(%ebp)
  800878:	8b 45 14             	mov    0x14(%ebp),%eax
  80087b:	83 e8 04             	sub    $0x4,%eax
  80087e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800880:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800883:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80088a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800891:	eb 1f                	jmp    8008b2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800893:	83 ec 08             	sub    $0x8,%esp
  800896:	ff 75 e8             	pushl  -0x18(%ebp)
  800899:	8d 45 14             	lea    0x14(%ebp),%eax
  80089c:	50                   	push   %eax
  80089d:	e8 e7 fb ff ff       	call   800489 <getuint>
  8008a2:	83 c4 10             	add    $0x10,%esp
  8008a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008a8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8008ab:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8008b2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8008b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008b9:	83 ec 04             	sub    $0x4,%esp
  8008bc:	52                   	push   %edx
  8008bd:	ff 75 e4             	pushl  -0x1c(%ebp)
  8008c0:	50                   	push   %eax
  8008c1:	ff 75 f4             	pushl  -0xc(%ebp)
  8008c4:	ff 75 f0             	pushl  -0x10(%ebp)
  8008c7:	ff 75 0c             	pushl  0xc(%ebp)
  8008ca:	ff 75 08             	pushl  0x8(%ebp)
  8008cd:	e8 00 fb ff ff       	call   8003d2 <printnum>
  8008d2:	83 c4 20             	add    $0x20,%esp
			break;
  8008d5:	eb 34                	jmp    80090b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8008d7:	83 ec 08             	sub    $0x8,%esp
  8008da:	ff 75 0c             	pushl  0xc(%ebp)
  8008dd:	53                   	push   %ebx
  8008de:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e1:	ff d0                	call   *%eax
  8008e3:	83 c4 10             	add    $0x10,%esp
			break;
  8008e6:	eb 23                	jmp    80090b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008e8:	83 ec 08             	sub    $0x8,%esp
  8008eb:	ff 75 0c             	pushl  0xc(%ebp)
  8008ee:	6a 25                	push   $0x25
  8008f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f3:	ff d0                	call   *%eax
  8008f5:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008f8:	ff 4d 10             	decl   0x10(%ebp)
  8008fb:	eb 03                	jmp    800900 <vprintfmt+0x3b1>
  8008fd:	ff 4d 10             	decl   0x10(%ebp)
  800900:	8b 45 10             	mov    0x10(%ebp),%eax
  800903:	48                   	dec    %eax
  800904:	8a 00                	mov    (%eax),%al
  800906:	3c 25                	cmp    $0x25,%al
  800908:	75 f3                	jne    8008fd <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80090a:	90                   	nop
		}
	}
  80090b:	e9 47 fc ff ff       	jmp    800557 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800910:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800911:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800914:	5b                   	pop    %ebx
  800915:	5e                   	pop    %esi
  800916:	5d                   	pop    %ebp
  800917:	c3                   	ret    

00800918 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800918:	55                   	push   %ebp
  800919:	89 e5                	mov    %esp,%ebp
  80091b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80091e:	8d 45 10             	lea    0x10(%ebp),%eax
  800921:	83 c0 04             	add    $0x4,%eax
  800924:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800927:	8b 45 10             	mov    0x10(%ebp),%eax
  80092a:	ff 75 f4             	pushl  -0xc(%ebp)
  80092d:	50                   	push   %eax
  80092e:	ff 75 0c             	pushl  0xc(%ebp)
  800931:	ff 75 08             	pushl  0x8(%ebp)
  800934:	e8 16 fc ff ff       	call   80054f <vprintfmt>
  800939:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80093c:	90                   	nop
  80093d:	c9                   	leave  
  80093e:	c3                   	ret    

0080093f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80093f:	55                   	push   %ebp
  800940:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800942:	8b 45 0c             	mov    0xc(%ebp),%eax
  800945:	8b 40 08             	mov    0x8(%eax),%eax
  800948:	8d 50 01             	lea    0x1(%eax),%edx
  80094b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800951:	8b 45 0c             	mov    0xc(%ebp),%eax
  800954:	8b 10                	mov    (%eax),%edx
  800956:	8b 45 0c             	mov    0xc(%ebp),%eax
  800959:	8b 40 04             	mov    0x4(%eax),%eax
  80095c:	39 c2                	cmp    %eax,%edx
  80095e:	73 12                	jae    800972 <sprintputch+0x33>
		*b->buf++ = ch;
  800960:	8b 45 0c             	mov    0xc(%ebp),%eax
  800963:	8b 00                	mov    (%eax),%eax
  800965:	8d 48 01             	lea    0x1(%eax),%ecx
  800968:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096b:	89 0a                	mov    %ecx,(%edx)
  80096d:	8b 55 08             	mov    0x8(%ebp),%edx
  800970:	88 10                	mov    %dl,(%eax)
}
  800972:	90                   	nop
  800973:	5d                   	pop    %ebp
  800974:	c3                   	ret    

00800975 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800975:	55                   	push   %ebp
  800976:	89 e5                	mov    %esp,%ebp
  800978:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80097b:	8b 45 08             	mov    0x8(%ebp),%eax
  80097e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800981:	8b 45 0c             	mov    0xc(%ebp),%eax
  800984:	8d 50 ff             	lea    -0x1(%eax),%edx
  800987:	8b 45 08             	mov    0x8(%ebp),%eax
  80098a:	01 d0                	add    %edx,%eax
  80098c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80098f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800996:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80099a:	74 06                	je     8009a2 <vsnprintf+0x2d>
  80099c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009a0:	7f 07                	jg     8009a9 <vsnprintf+0x34>
		return -E_INVAL;
  8009a2:	b8 03 00 00 00       	mov    $0x3,%eax
  8009a7:	eb 20                	jmp    8009c9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8009a9:	ff 75 14             	pushl  0x14(%ebp)
  8009ac:	ff 75 10             	pushl  0x10(%ebp)
  8009af:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8009b2:	50                   	push   %eax
  8009b3:	68 3f 09 80 00       	push   $0x80093f
  8009b8:	e8 92 fb ff ff       	call   80054f <vprintfmt>
  8009bd:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8009c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009c3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8009c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8009c9:	c9                   	leave  
  8009ca:	c3                   	ret    

008009cb <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8009cb:	55                   	push   %ebp
  8009cc:	89 e5                	mov    %esp,%ebp
  8009ce:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8009d1:	8d 45 10             	lea    0x10(%ebp),%eax
  8009d4:	83 c0 04             	add    $0x4,%eax
  8009d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8009da:	8b 45 10             	mov    0x10(%ebp),%eax
  8009dd:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e0:	50                   	push   %eax
  8009e1:	ff 75 0c             	pushl  0xc(%ebp)
  8009e4:	ff 75 08             	pushl  0x8(%ebp)
  8009e7:	e8 89 ff ff ff       	call   800975 <vsnprintf>
  8009ec:	83 c4 10             	add    $0x10,%esp
  8009ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009f5:	c9                   	leave  
  8009f6:	c3                   	ret    

008009f7 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8009f7:	55                   	push   %ebp
  8009f8:	89 e5                	mov    %esp,%ebp
  8009fa:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8009fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a01:	74 13                	je     800a16 <readline+0x1f>
		cprintf("%s", prompt);
  800a03:	83 ec 08             	sub    $0x8,%esp
  800a06:	ff 75 08             	pushl  0x8(%ebp)
  800a09:	68 50 21 80 00       	push   $0x802150
  800a0e:	e8 62 f9 ff ff       	call   800375 <cprintf>
  800a13:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a16:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a1d:	83 ec 0c             	sub    $0xc,%esp
  800a20:	6a 00                	push   $0x0
  800a22:	e8 8e 0f 00 00       	call   8019b5 <iscons>
  800a27:	83 c4 10             	add    $0x10,%esp
  800a2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a2d:	e8 35 0f 00 00       	call   801967 <getchar>
  800a32:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a35:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a39:	79 22                	jns    800a5d <readline+0x66>
			if (c != -E_EOF)
  800a3b:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800a3f:	0f 84 ad 00 00 00    	je     800af2 <readline+0xfb>
				cprintf("read error: %e\n", c);
  800a45:	83 ec 08             	sub    $0x8,%esp
  800a48:	ff 75 ec             	pushl  -0x14(%ebp)
  800a4b:	68 53 21 80 00       	push   $0x802153
  800a50:	e8 20 f9 ff ff       	call   800375 <cprintf>
  800a55:	83 c4 10             	add    $0x10,%esp
			return;
  800a58:	e9 95 00 00 00       	jmp    800af2 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800a5d:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800a61:	7e 34                	jle    800a97 <readline+0xa0>
  800a63:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800a6a:	7f 2b                	jg     800a97 <readline+0xa0>
			if (echoing)
  800a6c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a70:	74 0e                	je     800a80 <readline+0x89>
				cputchar(c);
  800a72:	83 ec 0c             	sub    $0xc,%esp
  800a75:	ff 75 ec             	pushl  -0x14(%ebp)
  800a78:	e8 a2 0e 00 00       	call   80191f <cputchar>
  800a7d:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800a80:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a83:	8d 50 01             	lea    0x1(%eax),%edx
  800a86:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800a89:	89 c2                	mov    %eax,%edx
  800a8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8e:	01 d0                	add    %edx,%eax
  800a90:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800a93:	88 10                	mov    %dl,(%eax)
  800a95:	eb 56                	jmp    800aed <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  800a97:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800a9b:	75 1f                	jne    800abc <readline+0xc5>
  800a9d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800aa1:	7e 19                	jle    800abc <readline+0xc5>
			if (echoing)
  800aa3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800aa7:	74 0e                	je     800ab7 <readline+0xc0>
				cputchar(c);
  800aa9:	83 ec 0c             	sub    $0xc,%esp
  800aac:	ff 75 ec             	pushl  -0x14(%ebp)
  800aaf:	e8 6b 0e 00 00       	call   80191f <cputchar>
  800ab4:	83 c4 10             	add    $0x10,%esp

			i--;
  800ab7:	ff 4d f4             	decl   -0xc(%ebp)
  800aba:	eb 31                	jmp    800aed <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800abc:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800ac0:	74 0a                	je     800acc <readline+0xd5>
  800ac2:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800ac6:	0f 85 61 ff ff ff    	jne    800a2d <readline+0x36>
			if (echoing)
  800acc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ad0:	74 0e                	je     800ae0 <readline+0xe9>
				cputchar(c);
  800ad2:	83 ec 0c             	sub    $0xc,%esp
  800ad5:	ff 75 ec             	pushl  -0x14(%ebp)
  800ad8:	e8 42 0e 00 00       	call   80191f <cputchar>
  800add:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800ae0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ae3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae6:	01 d0                	add    %edx,%eax
  800ae8:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800aeb:	eb 06                	jmp    800af3 <readline+0xfc>
		}
	}
  800aed:	e9 3b ff ff ff       	jmp    800a2d <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800af2:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800af3:	c9                   	leave  
  800af4:	c3                   	ret    

00800af5 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800af5:	55                   	push   %ebp
  800af6:	89 e5                	mov    %esp,%ebp
  800af8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800afb:	e8 41 0a 00 00       	call   801541 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800b00:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b04:	74 13                	je     800b19 <atomic_readline+0x24>
		cprintf("%s", prompt);
  800b06:	83 ec 08             	sub    $0x8,%esp
  800b09:	ff 75 08             	pushl  0x8(%ebp)
  800b0c:	68 50 21 80 00       	push   $0x802150
  800b11:	e8 5f f8 ff ff       	call   800375 <cprintf>
  800b16:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800b19:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800b20:	83 ec 0c             	sub    $0xc,%esp
  800b23:	6a 00                	push   $0x0
  800b25:	e8 8b 0e 00 00       	call   8019b5 <iscons>
  800b2a:	83 c4 10             	add    $0x10,%esp
  800b2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800b30:	e8 32 0e 00 00       	call   801967 <getchar>
  800b35:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800b38:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b3c:	79 23                	jns    800b61 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800b3e:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800b42:	74 13                	je     800b57 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800b44:	83 ec 08             	sub    $0x8,%esp
  800b47:	ff 75 ec             	pushl  -0x14(%ebp)
  800b4a:	68 53 21 80 00       	push   $0x802153
  800b4f:	e8 21 f8 ff ff       	call   800375 <cprintf>
  800b54:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800b57:	e8 ff 09 00 00       	call   80155b <sys_enable_interrupt>
			return;
  800b5c:	e9 9a 00 00 00       	jmp    800bfb <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800b61:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800b65:	7e 34                	jle    800b9b <atomic_readline+0xa6>
  800b67:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800b6e:	7f 2b                	jg     800b9b <atomic_readline+0xa6>
			if (echoing)
  800b70:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b74:	74 0e                	je     800b84 <atomic_readline+0x8f>
				cputchar(c);
  800b76:	83 ec 0c             	sub    $0xc,%esp
  800b79:	ff 75 ec             	pushl  -0x14(%ebp)
  800b7c:	e8 9e 0d 00 00       	call   80191f <cputchar>
  800b81:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800b84:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b87:	8d 50 01             	lea    0x1(%eax),%edx
  800b8a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800b8d:	89 c2                	mov    %eax,%edx
  800b8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b92:	01 d0                	add    %edx,%eax
  800b94:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b97:	88 10                	mov    %dl,(%eax)
  800b99:	eb 5b                	jmp    800bf6 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800b9b:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800b9f:	75 1f                	jne    800bc0 <atomic_readline+0xcb>
  800ba1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800ba5:	7e 19                	jle    800bc0 <atomic_readline+0xcb>
			if (echoing)
  800ba7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800bab:	74 0e                	je     800bbb <atomic_readline+0xc6>
				cputchar(c);
  800bad:	83 ec 0c             	sub    $0xc,%esp
  800bb0:	ff 75 ec             	pushl  -0x14(%ebp)
  800bb3:	e8 67 0d 00 00       	call   80191f <cputchar>
  800bb8:	83 c4 10             	add    $0x10,%esp
			i--;
  800bbb:	ff 4d f4             	decl   -0xc(%ebp)
  800bbe:	eb 36                	jmp    800bf6 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800bc0:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800bc4:	74 0a                	je     800bd0 <atomic_readline+0xdb>
  800bc6:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800bca:	0f 85 60 ff ff ff    	jne    800b30 <atomic_readline+0x3b>
			if (echoing)
  800bd0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800bd4:	74 0e                	je     800be4 <atomic_readline+0xef>
				cputchar(c);
  800bd6:	83 ec 0c             	sub    $0xc,%esp
  800bd9:	ff 75 ec             	pushl  -0x14(%ebp)
  800bdc:	e8 3e 0d 00 00       	call   80191f <cputchar>
  800be1:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800be4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800be7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bea:	01 d0                	add    %edx,%eax
  800bec:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800bef:	e8 67 09 00 00       	call   80155b <sys_enable_interrupt>
			return;
  800bf4:	eb 05                	jmp    800bfb <atomic_readline+0x106>
		}
	}
  800bf6:	e9 35 ff ff ff       	jmp    800b30 <atomic_readline+0x3b>
}
  800bfb:	c9                   	leave  
  800bfc:	c3                   	ret    

00800bfd <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bfd:	55                   	push   %ebp
  800bfe:	89 e5                	mov    %esp,%ebp
  800c00:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c03:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c0a:	eb 06                	jmp    800c12 <strlen+0x15>
		n++;
  800c0c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c0f:	ff 45 08             	incl   0x8(%ebp)
  800c12:	8b 45 08             	mov    0x8(%ebp),%eax
  800c15:	8a 00                	mov    (%eax),%al
  800c17:	84 c0                	test   %al,%al
  800c19:	75 f1                	jne    800c0c <strlen+0xf>
		n++;
	return n;
  800c1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c1e:	c9                   	leave  
  800c1f:	c3                   	ret    

00800c20 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c20:	55                   	push   %ebp
  800c21:	89 e5                	mov    %esp,%ebp
  800c23:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c26:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c2d:	eb 09                	jmp    800c38 <strnlen+0x18>
		n++;
  800c2f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c32:	ff 45 08             	incl   0x8(%ebp)
  800c35:	ff 4d 0c             	decl   0xc(%ebp)
  800c38:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c3c:	74 09                	je     800c47 <strnlen+0x27>
  800c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c41:	8a 00                	mov    (%eax),%al
  800c43:	84 c0                	test   %al,%al
  800c45:	75 e8                	jne    800c2f <strnlen+0xf>
		n++;
	return n;
  800c47:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c4a:	c9                   	leave  
  800c4b:	c3                   	ret    

00800c4c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c4c:	55                   	push   %ebp
  800c4d:	89 e5                	mov    %esp,%ebp
  800c4f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c58:	90                   	nop
  800c59:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5c:	8d 50 01             	lea    0x1(%eax),%edx
  800c5f:	89 55 08             	mov    %edx,0x8(%ebp)
  800c62:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c65:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c68:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c6b:	8a 12                	mov    (%edx),%dl
  800c6d:	88 10                	mov    %dl,(%eax)
  800c6f:	8a 00                	mov    (%eax),%al
  800c71:	84 c0                	test   %al,%al
  800c73:	75 e4                	jne    800c59 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c75:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c78:	c9                   	leave  
  800c79:	c3                   	ret    

00800c7a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c7a:	55                   	push   %ebp
  800c7b:	89 e5                	mov    %esp,%ebp
  800c7d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c86:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c8d:	eb 1f                	jmp    800cae <strncpy+0x34>
		*dst++ = *src;
  800c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c92:	8d 50 01             	lea    0x1(%eax),%edx
  800c95:	89 55 08             	mov    %edx,0x8(%ebp)
  800c98:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c9b:	8a 12                	mov    (%edx),%dl
  800c9d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca2:	8a 00                	mov    (%eax),%al
  800ca4:	84 c0                	test   %al,%al
  800ca6:	74 03                	je     800cab <strncpy+0x31>
			src++;
  800ca8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800cab:	ff 45 fc             	incl   -0x4(%ebp)
  800cae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb1:	3b 45 10             	cmp    0x10(%ebp),%eax
  800cb4:	72 d9                	jb     800c8f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800cb6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800cb9:	c9                   	leave  
  800cba:	c3                   	ret    

00800cbb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800cbb:	55                   	push   %ebp
  800cbc:	89 e5                	mov    %esp,%ebp
  800cbe:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cc7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ccb:	74 30                	je     800cfd <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ccd:	eb 16                	jmp    800ce5 <strlcpy+0x2a>
			*dst++ = *src++;
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	8d 50 01             	lea    0x1(%eax),%edx
  800cd5:	89 55 08             	mov    %edx,0x8(%ebp)
  800cd8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cdb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cde:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ce1:	8a 12                	mov    (%edx),%dl
  800ce3:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ce5:	ff 4d 10             	decl   0x10(%ebp)
  800ce8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cec:	74 09                	je     800cf7 <strlcpy+0x3c>
  800cee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf1:	8a 00                	mov    (%eax),%al
  800cf3:	84 c0                	test   %al,%al
  800cf5:	75 d8                	jne    800ccf <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cfd:	8b 55 08             	mov    0x8(%ebp),%edx
  800d00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d03:	29 c2                	sub    %eax,%edx
  800d05:	89 d0                	mov    %edx,%eax
}
  800d07:	c9                   	leave  
  800d08:	c3                   	ret    

00800d09 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d09:	55                   	push   %ebp
  800d0a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d0c:	eb 06                	jmp    800d14 <strcmp+0xb>
		p++, q++;
  800d0e:	ff 45 08             	incl   0x8(%ebp)
  800d11:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	8a 00                	mov    (%eax),%al
  800d19:	84 c0                	test   %al,%al
  800d1b:	74 0e                	je     800d2b <strcmp+0x22>
  800d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d20:	8a 10                	mov    (%eax),%dl
  800d22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d25:	8a 00                	mov    (%eax),%al
  800d27:	38 c2                	cmp    %al,%dl
  800d29:	74 e3                	je     800d0e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	8a 00                	mov    (%eax),%al
  800d30:	0f b6 d0             	movzbl %al,%edx
  800d33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d36:	8a 00                	mov    (%eax),%al
  800d38:	0f b6 c0             	movzbl %al,%eax
  800d3b:	29 c2                	sub    %eax,%edx
  800d3d:	89 d0                	mov    %edx,%eax
}
  800d3f:	5d                   	pop    %ebp
  800d40:	c3                   	ret    

00800d41 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d41:	55                   	push   %ebp
  800d42:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d44:	eb 09                	jmp    800d4f <strncmp+0xe>
		n--, p++, q++;
  800d46:	ff 4d 10             	decl   0x10(%ebp)
  800d49:	ff 45 08             	incl   0x8(%ebp)
  800d4c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d4f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d53:	74 17                	je     800d6c <strncmp+0x2b>
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8a 00                	mov    (%eax),%al
  800d5a:	84 c0                	test   %al,%al
  800d5c:	74 0e                	je     800d6c <strncmp+0x2b>
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8a 10                	mov    (%eax),%dl
  800d63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d66:	8a 00                	mov    (%eax),%al
  800d68:	38 c2                	cmp    %al,%dl
  800d6a:	74 da                	je     800d46 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d6c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d70:	75 07                	jne    800d79 <strncmp+0x38>
		return 0;
  800d72:	b8 00 00 00 00       	mov    $0x0,%eax
  800d77:	eb 14                	jmp    800d8d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d79:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7c:	8a 00                	mov    (%eax),%al
  800d7e:	0f b6 d0             	movzbl %al,%edx
  800d81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d84:	8a 00                	mov    (%eax),%al
  800d86:	0f b6 c0             	movzbl %al,%eax
  800d89:	29 c2                	sub    %eax,%edx
  800d8b:	89 d0                	mov    %edx,%eax
}
  800d8d:	5d                   	pop    %ebp
  800d8e:	c3                   	ret    

00800d8f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d8f:	55                   	push   %ebp
  800d90:	89 e5                	mov    %esp,%ebp
  800d92:	83 ec 04             	sub    $0x4,%esp
  800d95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d98:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d9b:	eb 12                	jmp    800daf <strchr+0x20>
		if (*s == c)
  800d9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800da0:	8a 00                	mov    (%eax),%al
  800da2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800da5:	75 05                	jne    800dac <strchr+0x1d>
			return (char *) s;
  800da7:	8b 45 08             	mov    0x8(%ebp),%eax
  800daa:	eb 11                	jmp    800dbd <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800dac:	ff 45 08             	incl   0x8(%ebp)
  800daf:	8b 45 08             	mov    0x8(%ebp),%eax
  800db2:	8a 00                	mov    (%eax),%al
  800db4:	84 c0                	test   %al,%al
  800db6:	75 e5                	jne    800d9d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800db8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800dbd:	c9                   	leave  
  800dbe:	c3                   	ret    

00800dbf <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800dbf:	55                   	push   %ebp
  800dc0:	89 e5                	mov    %esp,%ebp
  800dc2:	83 ec 04             	sub    $0x4,%esp
  800dc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dcb:	eb 0d                	jmp    800dda <strfind+0x1b>
		if (*s == c)
  800dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd0:	8a 00                	mov    (%eax),%al
  800dd2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dd5:	74 0e                	je     800de5 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800dd7:	ff 45 08             	incl   0x8(%ebp)
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	8a 00                	mov    (%eax),%al
  800ddf:	84 c0                	test   %al,%al
  800de1:	75 ea                	jne    800dcd <strfind+0xe>
  800de3:	eb 01                	jmp    800de6 <strfind+0x27>
		if (*s == c)
			break;
  800de5:	90                   	nop
	return (char *) s;
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800de9:	c9                   	leave  
  800dea:	c3                   	ret    

00800deb <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800deb:	55                   	push   %ebp
  800dec:	89 e5                	mov    %esp,%ebp
  800dee:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800df1:	8b 45 08             	mov    0x8(%ebp),%eax
  800df4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800df7:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800dfd:	eb 0e                	jmp    800e0d <memset+0x22>
		*p++ = c;
  800dff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e02:	8d 50 01             	lea    0x1(%eax),%edx
  800e05:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e08:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e0b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e0d:	ff 4d f8             	decl   -0x8(%ebp)
  800e10:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e14:	79 e9                	jns    800dff <memset+0x14>
		*p++ = c;

	return v;
  800e16:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e19:	c9                   	leave  
  800e1a:	c3                   	ret    

00800e1b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e1b:	55                   	push   %ebp
  800e1c:	89 e5                	mov    %esp,%ebp
  800e1e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e24:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e27:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e2d:	eb 16                	jmp    800e45 <memcpy+0x2a>
		*d++ = *s++;
  800e2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e32:	8d 50 01             	lea    0x1(%eax),%edx
  800e35:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e38:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e3b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e3e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e41:	8a 12                	mov    (%edx),%dl
  800e43:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e45:	8b 45 10             	mov    0x10(%ebp),%eax
  800e48:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e4b:	89 55 10             	mov    %edx,0x10(%ebp)
  800e4e:	85 c0                	test   %eax,%eax
  800e50:	75 dd                	jne    800e2f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e52:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e55:	c9                   	leave  
  800e56:	c3                   	ret    

00800e57 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e57:	55                   	push   %ebp
  800e58:	89 e5                	mov    %esp,%ebp
  800e5a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800e5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e60:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e63:	8b 45 08             	mov    0x8(%ebp),%eax
  800e66:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e69:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e6f:	73 50                	jae    800ec1 <memmove+0x6a>
  800e71:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e74:	8b 45 10             	mov    0x10(%ebp),%eax
  800e77:	01 d0                	add    %edx,%eax
  800e79:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e7c:	76 43                	jbe    800ec1 <memmove+0x6a>
		s += n;
  800e7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e81:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e84:	8b 45 10             	mov    0x10(%ebp),%eax
  800e87:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e8a:	eb 10                	jmp    800e9c <memmove+0x45>
			*--d = *--s;
  800e8c:	ff 4d f8             	decl   -0x8(%ebp)
  800e8f:	ff 4d fc             	decl   -0x4(%ebp)
  800e92:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e95:	8a 10                	mov    (%eax),%dl
  800e97:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e9c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ea2:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea5:	85 c0                	test   %eax,%eax
  800ea7:	75 e3                	jne    800e8c <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ea9:	eb 23                	jmp    800ece <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800eab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eae:	8d 50 01             	lea    0x1(%eax),%edx
  800eb1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800eb4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eb7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eba:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ebd:	8a 12                	mov    (%edx),%dl
  800ebf:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ec1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec7:	89 55 10             	mov    %edx,0x10(%ebp)
  800eca:	85 c0                	test   %eax,%eax
  800ecc:	75 dd                	jne    800eab <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ed1:	c9                   	leave  
  800ed2:	c3                   	ret    

00800ed3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ed3:	55                   	push   %ebp
  800ed4:	89 e5                	mov    %esp,%ebp
  800ed6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  800edc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800edf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee2:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ee5:	eb 2a                	jmp    800f11 <memcmp+0x3e>
		if (*s1 != *s2)
  800ee7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eea:	8a 10                	mov    (%eax),%dl
  800eec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eef:	8a 00                	mov    (%eax),%al
  800ef1:	38 c2                	cmp    %al,%dl
  800ef3:	74 16                	je     800f0b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ef5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef8:	8a 00                	mov    (%eax),%al
  800efa:	0f b6 d0             	movzbl %al,%edx
  800efd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f00:	8a 00                	mov    (%eax),%al
  800f02:	0f b6 c0             	movzbl %al,%eax
  800f05:	29 c2                	sub    %eax,%edx
  800f07:	89 d0                	mov    %edx,%eax
  800f09:	eb 18                	jmp    800f23 <memcmp+0x50>
		s1++, s2++;
  800f0b:	ff 45 fc             	incl   -0x4(%ebp)
  800f0e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f11:	8b 45 10             	mov    0x10(%ebp),%eax
  800f14:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f17:	89 55 10             	mov    %edx,0x10(%ebp)
  800f1a:	85 c0                	test   %eax,%eax
  800f1c:	75 c9                	jne    800ee7 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f1e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f23:	c9                   	leave  
  800f24:	c3                   	ret    

00800f25 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f25:	55                   	push   %ebp
  800f26:	89 e5                	mov    %esp,%ebp
  800f28:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f2b:	8b 55 08             	mov    0x8(%ebp),%edx
  800f2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f31:	01 d0                	add    %edx,%eax
  800f33:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f36:	eb 15                	jmp    800f4d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	8a 00                	mov    (%eax),%al
  800f3d:	0f b6 d0             	movzbl %al,%edx
  800f40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f43:	0f b6 c0             	movzbl %al,%eax
  800f46:	39 c2                	cmp    %eax,%edx
  800f48:	74 0d                	je     800f57 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f4a:	ff 45 08             	incl   0x8(%ebp)
  800f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f50:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f53:	72 e3                	jb     800f38 <memfind+0x13>
  800f55:	eb 01                	jmp    800f58 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f57:	90                   	nop
	return (void *) s;
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f5b:	c9                   	leave  
  800f5c:	c3                   	ret    

00800f5d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f5d:	55                   	push   %ebp
  800f5e:	89 e5                	mov    %esp,%ebp
  800f60:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f63:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f6a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f71:	eb 03                	jmp    800f76 <strtol+0x19>
		s++;
  800f73:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	8a 00                	mov    (%eax),%al
  800f7b:	3c 20                	cmp    $0x20,%al
  800f7d:	74 f4                	je     800f73 <strtol+0x16>
  800f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f82:	8a 00                	mov    (%eax),%al
  800f84:	3c 09                	cmp    $0x9,%al
  800f86:	74 eb                	je     800f73 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f88:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8b:	8a 00                	mov    (%eax),%al
  800f8d:	3c 2b                	cmp    $0x2b,%al
  800f8f:	75 05                	jne    800f96 <strtol+0x39>
		s++;
  800f91:	ff 45 08             	incl   0x8(%ebp)
  800f94:	eb 13                	jmp    800fa9 <strtol+0x4c>
	else if (*s == '-')
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	8a 00                	mov    (%eax),%al
  800f9b:	3c 2d                	cmp    $0x2d,%al
  800f9d:	75 0a                	jne    800fa9 <strtol+0x4c>
		s++, neg = 1;
  800f9f:	ff 45 08             	incl   0x8(%ebp)
  800fa2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fa9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fad:	74 06                	je     800fb5 <strtol+0x58>
  800faf:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fb3:	75 20                	jne    800fd5 <strtol+0x78>
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb8:	8a 00                	mov    (%eax),%al
  800fba:	3c 30                	cmp    $0x30,%al
  800fbc:	75 17                	jne    800fd5 <strtol+0x78>
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	40                   	inc    %eax
  800fc2:	8a 00                	mov    (%eax),%al
  800fc4:	3c 78                	cmp    $0x78,%al
  800fc6:	75 0d                	jne    800fd5 <strtol+0x78>
		s += 2, base = 16;
  800fc8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fcc:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fd3:	eb 28                	jmp    800ffd <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fd5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fd9:	75 15                	jne    800ff0 <strtol+0x93>
  800fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fde:	8a 00                	mov    (%eax),%al
  800fe0:	3c 30                	cmp    $0x30,%al
  800fe2:	75 0c                	jne    800ff0 <strtol+0x93>
		s++, base = 8;
  800fe4:	ff 45 08             	incl   0x8(%ebp)
  800fe7:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fee:	eb 0d                	jmp    800ffd <strtol+0xa0>
	else if (base == 0)
  800ff0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ff4:	75 07                	jne    800ffd <strtol+0xa0>
		base = 10;
  800ff6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  801000:	8a 00                	mov    (%eax),%al
  801002:	3c 2f                	cmp    $0x2f,%al
  801004:	7e 19                	jle    80101f <strtol+0xc2>
  801006:	8b 45 08             	mov    0x8(%ebp),%eax
  801009:	8a 00                	mov    (%eax),%al
  80100b:	3c 39                	cmp    $0x39,%al
  80100d:	7f 10                	jg     80101f <strtol+0xc2>
			dig = *s - '0';
  80100f:	8b 45 08             	mov    0x8(%ebp),%eax
  801012:	8a 00                	mov    (%eax),%al
  801014:	0f be c0             	movsbl %al,%eax
  801017:	83 e8 30             	sub    $0x30,%eax
  80101a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80101d:	eb 42                	jmp    801061 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80101f:	8b 45 08             	mov    0x8(%ebp),%eax
  801022:	8a 00                	mov    (%eax),%al
  801024:	3c 60                	cmp    $0x60,%al
  801026:	7e 19                	jle    801041 <strtol+0xe4>
  801028:	8b 45 08             	mov    0x8(%ebp),%eax
  80102b:	8a 00                	mov    (%eax),%al
  80102d:	3c 7a                	cmp    $0x7a,%al
  80102f:	7f 10                	jg     801041 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
  801034:	8a 00                	mov    (%eax),%al
  801036:	0f be c0             	movsbl %al,%eax
  801039:	83 e8 57             	sub    $0x57,%eax
  80103c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80103f:	eb 20                	jmp    801061 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801041:	8b 45 08             	mov    0x8(%ebp),%eax
  801044:	8a 00                	mov    (%eax),%al
  801046:	3c 40                	cmp    $0x40,%al
  801048:	7e 39                	jle    801083 <strtol+0x126>
  80104a:	8b 45 08             	mov    0x8(%ebp),%eax
  80104d:	8a 00                	mov    (%eax),%al
  80104f:	3c 5a                	cmp    $0x5a,%al
  801051:	7f 30                	jg     801083 <strtol+0x126>
			dig = *s - 'A' + 10;
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	8a 00                	mov    (%eax),%al
  801058:	0f be c0             	movsbl %al,%eax
  80105b:	83 e8 37             	sub    $0x37,%eax
  80105e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801061:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801064:	3b 45 10             	cmp    0x10(%ebp),%eax
  801067:	7d 19                	jge    801082 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801069:	ff 45 08             	incl   0x8(%ebp)
  80106c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801073:	89 c2                	mov    %eax,%edx
  801075:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801078:	01 d0                	add    %edx,%eax
  80107a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80107d:	e9 7b ff ff ff       	jmp    800ffd <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801082:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801083:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801087:	74 08                	je     801091 <strtol+0x134>
		*endptr = (char *) s;
  801089:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108c:	8b 55 08             	mov    0x8(%ebp),%edx
  80108f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801091:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801095:	74 07                	je     80109e <strtol+0x141>
  801097:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109a:	f7 d8                	neg    %eax
  80109c:	eb 03                	jmp    8010a1 <strtol+0x144>
  80109e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010a1:	c9                   	leave  
  8010a2:	c3                   	ret    

008010a3 <ltostr>:

void
ltostr(long value, char *str)
{
  8010a3:	55                   	push   %ebp
  8010a4:	89 e5                	mov    %esp,%ebp
  8010a6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010b0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010b7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010bb:	79 13                	jns    8010d0 <ltostr+0x2d>
	{
		neg = 1;
  8010bd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c7:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010ca:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010cd:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010d8:	99                   	cltd   
  8010d9:	f7 f9                	idiv   %ecx
  8010db:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e1:	8d 50 01             	lea    0x1(%eax),%edx
  8010e4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010e7:	89 c2                	mov    %eax,%edx
  8010e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ec:	01 d0                	add    %edx,%eax
  8010ee:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010f1:	83 c2 30             	add    $0x30,%edx
  8010f4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010f9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010fe:	f7 e9                	imul   %ecx
  801100:	c1 fa 02             	sar    $0x2,%edx
  801103:	89 c8                	mov    %ecx,%eax
  801105:	c1 f8 1f             	sar    $0x1f,%eax
  801108:	29 c2                	sub    %eax,%edx
  80110a:	89 d0                	mov    %edx,%eax
  80110c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80110f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801112:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801117:	f7 e9                	imul   %ecx
  801119:	c1 fa 02             	sar    $0x2,%edx
  80111c:	89 c8                	mov    %ecx,%eax
  80111e:	c1 f8 1f             	sar    $0x1f,%eax
  801121:	29 c2                	sub    %eax,%edx
  801123:	89 d0                	mov    %edx,%eax
  801125:	c1 e0 02             	shl    $0x2,%eax
  801128:	01 d0                	add    %edx,%eax
  80112a:	01 c0                	add    %eax,%eax
  80112c:	29 c1                	sub    %eax,%ecx
  80112e:	89 ca                	mov    %ecx,%edx
  801130:	85 d2                	test   %edx,%edx
  801132:	75 9c                	jne    8010d0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801134:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80113b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80113e:	48                   	dec    %eax
  80113f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801142:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801146:	74 3d                	je     801185 <ltostr+0xe2>
		start = 1 ;
  801148:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80114f:	eb 34                	jmp    801185 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801151:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801154:	8b 45 0c             	mov    0xc(%ebp),%eax
  801157:	01 d0                	add    %edx,%eax
  801159:	8a 00                	mov    (%eax),%al
  80115b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80115e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801161:	8b 45 0c             	mov    0xc(%ebp),%eax
  801164:	01 c2                	add    %eax,%edx
  801166:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801169:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116c:	01 c8                	add    %ecx,%eax
  80116e:	8a 00                	mov    (%eax),%al
  801170:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801172:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801175:	8b 45 0c             	mov    0xc(%ebp),%eax
  801178:	01 c2                	add    %eax,%edx
  80117a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80117d:	88 02                	mov    %al,(%edx)
		start++ ;
  80117f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801182:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801185:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801188:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80118b:	7c c4                	jl     801151 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80118d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801190:	8b 45 0c             	mov    0xc(%ebp),%eax
  801193:	01 d0                	add    %edx,%eax
  801195:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801198:	90                   	nop
  801199:	c9                   	leave  
  80119a:	c3                   	ret    

0080119b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80119b:	55                   	push   %ebp
  80119c:	89 e5                	mov    %esp,%ebp
  80119e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011a1:	ff 75 08             	pushl  0x8(%ebp)
  8011a4:	e8 54 fa ff ff       	call   800bfd <strlen>
  8011a9:	83 c4 04             	add    $0x4,%esp
  8011ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011af:	ff 75 0c             	pushl  0xc(%ebp)
  8011b2:	e8 46 fa ff ff       	call   800bfd <strlen>
  8011b7:	83 c4 04             	add    $0x4,%esp
  8011ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011cb:	eb 17                	jmp    8011e4 <strcconcat+0x49>
		final[s] = str1[s] ;
  8011cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d3:	01 c2                	add    %eax,%edx
  8011d5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011db:	01 c8                	add    %ecx,%eax
  8011dd:	8a 00                	mov    (%eax),%al
  8011df:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011e1:	ff 45 fc             	incl   -0x4(%ebp)
  8011e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011e7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011ea:	7c e1                	jl     8011cd <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011f3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011fa:	eb 1f                	jmp    80121b <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011ff:	8d 50 01             	lea    0x1(%eax),%edx
  801202:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801205:	89 c2                	mov    %eax,%edx
  801207:	8b 45 10             	mov    0x10(%ebp),%eax
  80120a:	01 c2                	add    %eax,%edx
  80120c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80120f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801212:	01 c8                	add    %ecx,%eax
  801214:	8a 00                	mov    (%eax),%al
  801216:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801218:	ff 45 f8             	incl   -0x8(%ebp)
  80121b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80121e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801221:	7c d9                	jl     8011fc <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801223:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801226:	8b 45 10             	mov    0x10(%ebp),%eax
  801229:	01 d0                	add    %edx,%eax
  80122b:	c6 00 00             	movb   $0x0,(%eax)
}
  80122e:	90                   	nop
  80122f:	c9                   	leave  
  801230:	c3                   	ret    

00801231 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801231:	55                   	push   %ebp
  801232:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801234:	8b 45 14             	mov    0x14(%ebp),%eax
  801237:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80123d:	8b 45 14             	mov    0x14(%ebp),%eax
  801240:	8b 00                	mov    (%eax),%eax
  801242:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801249:	8b 45 10             	mov    0x10(%ebp),%eax
  80124c:	01 d0                	add    %edx,%eax
  80124e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801254:	eb 0c                	jmp    801262 <strsplit+0x31>
			*string++ = 0;
  801256:	8b 45 08             	mov    0x8(%ebp),%eax
  801259:	8d 50 01             	lea    0x1(%eax),%edx
  80125c:	89 55 08             	mov    %edx,0x8(%ebp)
  80125f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801262:	8b 45 08             	mov    0x8(%ebp),%eax
  801265:	8a 00                	mov    (%eax),%al
  801267:	84 c0                	test   %al,%al
  801269:	74 18                	je     801283 <strsplit+0x52>
  80126b:	8b 45 08             	mov    0x8(%ebp),%eax
  80126e:	8a 00                	mov    (%eax),%al
  801270:	0f be c0             	movsbl %al,%eax
  801273:	50                   	push   %eax
  801274:	ff 75 0c             	pushl  0xc(%ebp)
  801277:	e8 13 fb ff ff       	call   800d8f <strchr>
  80127c:	83 c4 08             	add    $0x8,%esp
  80127f:	85 c0                	test   %eax,%eax
  801281:	75 d3                	jne    801256 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801283:	8b 45 08             	mov    0x8(%ebp),%eax
  801286:	8a 00                	mov    (%eax),%al
  801288:	84 c0                	test   %al,%al
  80128a:	74 5a                	je     8012e6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80128c:	8b 45 14             	mov    0x14(%ebp),%eax
  80128f:	8b 00                	mov    (%eax),%eax
  801291:	83 f8 0f             	cmp    $0xf,%eax
  801294:	75 07                	jne    80129d <strsplit+0x6c>
		{
			return 0;
  801296:	b8 00 00 00 00       	mov    $0x0,%eax
  80129b:	eb 66                	jmp    801303 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80129d:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a0:	8b 00                	mov    (%eax),%eax
  8012a2:	8d 48 01             	lea    0x1(%eax),%ecx
  8012a5:	8b 55 14             	mov    0x14(%ebp),%edx
  8012a8:	89 0a                	mov    %ecx,(%edx)
  8012aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b4:	01 c2                	add    %eax,%edx
  8012b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012bb:	eb 03                	jmp    8012c0 <strsplit+0x8f>
			string++;
  8012bd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	8a 00                	mov    (%eax),%al
  8012c5:	84 c0                	test   %al,%al
  8012c7:	74 8b                	je     801254 <strsplit+0x23>
  8012c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cc:	8a 00                	mov    (%eax),%al
  8012ce:	0f be c0             	movsbl %al,%eax
  8012d1:	50                   	push   %eax
  8012d2:	ff 75 0c             	pushl  0xc(%ebp)
  8012d5:	e8 b5 fa ff ff       	call   800d8f <strchr>
  8012da:	83 c4 08             	add    $0x8,%esp
  8012dd:	85 c0                	test   %eax,%eax
  8012df:	74 dc                	je     8012bd <strsplit+0x8c>
			string++;
	}
  8012e1:	e9 6e ff ff ff       	jmp    801254 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012e6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8012ea:	8b 00                	mov    (%eax),%eax
  8012ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f6:	01 d0                	add    %edx,%eax
  8012f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012fe:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
  801308:	57                   	push   %edi
  801309:	56                   	push   %esi
  80130a:	53                   	push   %ebx
  80130b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	8b 55 0c             	mov    0xc(%ebp),%edx
  801314:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801317:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80131a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80131d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801320:	cd 30                	int    $0x30
  801322:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801325:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801328:	83 c4 10             	add    $0x10,%esp
  80132b:	5b                   	pop    %ebx
  80132c:	5e                   	pop    %esi
  80132d:	5f                   	pop    %edi
  80132e:	5d                   	pop    %ebp
  80132f:	c3                   	ret    

00801330 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801330:	55                   	push   %ebp
  801331:	89 e5                	mov    %esp,%ebp
  801333:	83 ec 04             	sub    $0x4,%esp
  801336:	8b 45 10             	mov    0x10(%ebp),%eax
  801339:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80133c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801340:	8b 45 08             	mov    0x8(%ebp),%eax
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	52                   	push   %edx
  801348:	ff 75 0c             	pushl  0xc(%ebp)
  80134b:	50                   	push   %eax
  80134c:	6a 00                	push   $0x0
  80134e:	e8 b2 ff ff ff       	call   801305 <syscall>
  801353:	83 c4 18             	add    $0x18,%esp
}
  801356:	90                   	nop
  801357:	c9                   	leave  
  801358:	c3                   	ret    

00801359 <sys_cgetc>:

int
sys_cgetc(void)
{
  801359:	55                   	push   %ebp
  80135a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80135c:	6a 00                	push   $0x0
  80135e:	6a 00                	push   $0x0
  801360:	6a 00                	push   $0x0
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	6a 01                	push   $0x1
  801368:	e8 98 ff ff ff       	call   801305 <syscall>
  80136d:	83 c4 18             	add    $0x18,%esp
}
  801370:	c9                   	leave  
  801371:	c3                   	ret    

00801372 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801375:	8b 45 08             	mov    0x8(%ebp),%eax
  801378:	6a 00                	push   $0x0
  80137a:	6a 00                	push   $0x0
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	50                   	push   %eax
  801381:	6a 05                	push   $0x5
  801383:	e8 7d ff ff ff       	call   801305 <syscall>
  801388:	83 c4 18             	add    $0x18,%esp
}
  80138b:	c9                   	leave  
  80138c:	c3                   	ret    

0080138d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80138d:	55                   	push   %ebp
  80138e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801390:	6a 00                	push   $0x0
  801392:	6a 00                	push   $0x0
  801394:	6a 00                	push   $0x0
  801396:	6a 00                	push   $0x0
  801398:	6a 00                	push   $0x0
  80139a:	6a 02                	push   $0x2
  80139c:	e8 64 ff ff ff       	call   801305 <syscall>
  8013a1:	83 c4 18             	add    $0x18,%esp
}
  8013a4:	c9                   	leave  
  8013a5:	c3                   	ret    

008013a6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013a6:	55                   	push   %ebp
  8013a7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013a9:	6a 00                	push   $0x0
  8013ab:	6a 00                	push   $0x0
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 03                	push   $0x3
  8013b5:	e8 4b ff ff ff       	call   801305 <syscall>
  8013ba:	83 c4 18             	add    $0x18,%esp
}
  8013bd:	c9                   	leave  
  8013be:	c3                   	ret    

008013bf <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013bf:	55                   	push   %ebp
  8013c0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8013c2:	6a 00                	push   $0x0
  8013c4:	6a 00                	push   $0x0
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 04                	push   $0x4
  8013ce:	e8 32 ff ff ff       	call   801305 <syscall>
  8013d3:	83 c4 18             	add    $0x18,%esp
}
  8013d6:	c9                   	leave  
  8013d7:	c3                   	ret    

008013d8 <sys_env_exit>:


void sys_env_exit(void)
{
  8013d8:	55                   	push   %ebp
  8013d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 06                	push   $0x6
  8013e7:	e8 19 ff ff ff       	call   801305 <syscall>
  8013ec:	83 c4 18             	add    $0x18,%esp
}
  8013ef:	90                   	nop
  8013f0:	c9                   	leave  
  8013f1:	c3                   	ret    

008013f2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8013f2:	55                   	push   %ebp
  8013f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8013f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	52                   	push   %edx
  801402:	50                   	push   %eax
  801403:	6a 07                	push   $0x7
  801405:	e8 fb fe ff ff       	call   801305 <syscall>
  80140a:	83 c4 18             	add    $0x18,%esp
}
  80140d:	c9                   	leave  
  80140e:	c3                   	ret    

0080140f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80140f:	55                   	push   %ebp
  801410:	89 e5                	mov    %esp,%ebp
  801412:	56                   	push   %esi
  801413:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801414:	8b 75 18             	mov    0x18(%ebp),%esi
  801417:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80141a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80141d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801420:	8b 45 08             	mov    0x8(%ebp),%eax
  801423:	56                   	push   %esi
  801424:	53                   	push   %ebx
  801425:	51                   	push   %ecx
  801426:	52                   	push   %edx
  801427:	50                   	push   %eax
  801428:	6a 08                	push   $0x8
  80142a:	e8 d6 fe ff ff       	call   801305 <syscall>
  80142f:	83 c4 18             	add    $0x18,%esp
}
  801432:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801435:	5b                   	pop    %ebx
  801436:	5e                   	pop    %esi
  801437:	5d                   	pop    %ebp
  801438:	c3                   	ret    

00801439 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801439:	55                   	push   %ebp
  80143a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80143c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80143f:	8b 45 08             	mov    0x8(%ebp),%eax
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	52                   	push   %edx
  801449:	50                   	push   %eax
  80144a:	6a 09                	push   $0x9
  80144c:	e8 b4 fe ff ff       	call   801305 <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
}
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	ff 75 0c             	pushl  0xc(%ebp)
  801462:	ff 75 08             	pushl  0x8(%ebp)
  801465:	6a 0a                	push   $0xa
  801467:	e8 99 fe ff ff       	call   801305 <syscall>
  80146c:	83 c4 18             	add    $0x18,%esp
}
  80146f:	c9                   	leave  
  801470:	c3                   	ret    

00801471 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801471:	55                   	push   %ebp
  801472:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801474:	6a 00                	push   $0x0
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	6a 0b                	push   $0xb
  801480:	e8 80 fe ff ff       	call   801305 <syscall>
  801485:	83 c4 18             	add    $0x18,%esp
}
  801488:	c9                   	leave  
  801489:	c3                   	ret    

0080148a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80148a:	55                   	push   %ebp
  80148b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 0c                	push   $0xc
  801499:	e8 67 fe ff ff       	call   801305 <syscall>
  80149e:	83 c4 18             	add    $0x18,%esp
}
  8014a1:	c9                   	leave  
  8014a2:	c3                   	ret    

008014a3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014a3:	55                   	push   %ebp
  8014a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 0d                	push   $0xd
  8014b2:	e8 4e fe ff ff       	call   801305 <syscall>
  8014b7:	83 c4 18             	add    $0x18,%esp
}
  8014ba:	c9                   	leave  
  8014bb:	c3                   	ret    

008014bc <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014bc:	55                   	push   %ebp
  8014bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	ff 75 0c             	pushl  0xc(%ebp)
  8014c8:	ff 75 08             	pushl  0x8(%ebp)
  8014cb:	6a 11                	push   $0x11
  8014cd:	e8 33 fe ff ff       	call   801305 <syscall>
  8014d2:	83 c4 18             	add    $0x18,%esp
	return;
  8014d5:	90                   	nop
}
  8014d6:	c9                   	leave  
  8014d7:	c3                   	ret    

008014d8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8014d8:	55                   	push   %ebp
  8014d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	ff 75 0c             	pushl  0xc(%ebp)
  8014e4:	ff 75 08             	pushl  0x8(%ebp)
  8014e7:	6a 12                	push   $0x12
  8014e9:	e8 17 fe ff ff       	call   801305 <syscall>
  8014ee:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f1:	90                   	nop
}
  8014f2:	c9                   	leave  
  8014f3:	c3                   	ret    

008014f4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8014f4:	55                   	push   %ebp
  8014f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 0e                	push   $0xe
  801503:	e8 fd fd ff ff       	call   801305 <syscall>
  801508:	83 c4 18             	add    $0x18,%esp
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	ff 75 08             	pushl  0x8(%ebp)
  80151b:	6a 0f                	push   $0xf
  80151d:	e8 e3 fd ff ff       	call   801305 <syscall>
  801522:	83 c4 18             	add    $0x18,%esp
}
  801525:	c9                   	leave  
  801526:	c3                   	ret    

00801527 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801527:	55                   	push   %ebp
  801528:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 10                	push   $0x10
  801536:	e8 ca fd ff ff       	call   801305 <syscall>
  80153b:	83 c4 18             	add    $0x18,%esp
}
  80153e:	90                   	nop
  80153f:	c9                   	leave  
  801540:	c3                   	ret    

00801541 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801541:	55                   	push   %ebp
  801542:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 14                	push   $0x14
  801550:	e8 b0 fd ff ff       	call   801305 <syscall>
  801555:	83 c4 18             	add    $0x18,%esp
}
  801558:	90                   	nop
  801559:	c9                   	leave  
  80155a:	c3                   	ret    

0080155b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80155b:	55                   	push   %ebp
  80155c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 15                	push   $0x15
  80156a:	e8 96 fd ff ff       	call   801305 <syscall>
  80156f:	83 c4 18             	add    $0x18,%esp
}
  801572:	90                   	nop
  801573:	c9                   	leave  
  801574:	c3                   	ret    

00801575 <sys_cputc>:


void
sys_cputc(const char c)
{
  801575:	55                   	push   %ebp
  801576:	89 e5                	mov    %esp,%ebp
  801578:	83 ec 04             	sub    $0x4,%esp
  80157b:	8b 45 08             	mov    0x8(%ebp),%eax
  80157e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801581:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	50                   	push   %eax
  80158e:	6a 16                	push   $0x16
  801590:	e8 70 fd ff ff       	call   801305 <syscall>
  801595:	83 c4 18             	add    $0x18,%esp
}
  801598:	90                   	nop
  801599:	c9                   	leave  
  80159a:	c3                   	ret    

0080159b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80159b:	55                   	push   %ebp
  80159c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 17                	push   $0x17
  8015aa:	e8 56 fd ff ff       	call   801305 <syscall>
  8015af:	83 c4 18             	add    $0x18,%esp
}
  8015b2:	90                   	nop
  8015b3:	c9                   	leave  
  8015b4:	c3                   	ret    

008015b5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8015b5:	55                   	push   %ebp
  8015b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	ff 75 0c             	pushl  0xc(%ebp)
  8015c4:	50                   	push   %eax
  8015c5:	6a 18                	push   $0x18
  8015c7:	e8 39 fd ff ff       	call   801305 <syscall>
  8015cc:	83 c4 18             	add    $0x18,%esp
}
  8015cf:	c9                   	leave  
  8015d0:	c3                   	ret    

008015d1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8015d1:	55                   	push   %ebp
  8015d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	52                   	push   %edx
  8015e1:	50                   	push   %eax
  8015e2:	6a 1b                	push   $0x1b
  8015e4:	e8 1c fd ff ff       	call   801305 <syscall>
  8015e9:	83 c4 18             	add    $0x18,%esp
}
  8015ec:	c9                   	leave  
  8015ed:	c3                   	ret    

008015ee <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015ee:	55                   	push   %ebp
  8015ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	52                   	push   %edx
  8015fe:	50                   	push   %eax
  8015ff:	6a 19                	push   $0x19
  801601:	e8 ff fc ff ff       	call   801305 <syscall>
  801606:	83 c4 18             	add    $0x18,%esp
}
  801609:	90                   	nop
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80160f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801612:	8b 45 08             	mov    0x8(%ebp),%eax
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	52                   	push   %edx
  80161c:	50                   	push   %eax
  80161d:	6a 1a                	push   $0x1a
  80161f:	e8 e1 fc ff ff       	call   801305 <syscall>
  801624:	83 c4 18             	add    $0x18,%esp
}
  801627:	90                   	nop
  801628:	c9                   	leave  
  801629:	c3                   	ret    

0080162a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80162a:	55                   	push   %ebp
  80162b:	89 e5                	mov    %esp,%ebp
  80162d:	83 ec 04             	sub    $0x4,%esp
  801630:	8b 45 10             	mov    0x10(%ebp),%eax
  801633:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801636:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801639:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80163d:	8b 45 08             	mov    0x8(%ebp),%eax
  801640:	6a 00                	push   $0x0
  801642:	51                   	push   %ecx
  801643:	52                   	push   %edx
  801644:	ff 75 0c             	pushl  0xc(%ebp)
  801647:	50                   	push   %eax
  801648:	6a 1c                	push   $0x1c
  80164a:	e8 b6 fc ff ff       	call   801305 <syscall>
  80164f:	83 c4 18             	add    $0x18,%esp
}
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801657:	8b 55 0c             	mov    0xc(%ebp),%edx
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	52                   	push   %edx
  801664:	50                   	push   %eax
  801665:	6a 1d                	push   $0x1d
  801667:	e8 99 fc ff ff       	call   801305 <syscall>
  80166c:	83 c4 18             	add    $0x18,%esp
}
  80166f:	c9                   	leave  
  801670:	c3                   	ret    

00801671 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801671:	55                   	push   %ebp
  801672:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801674:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801677:	8b 55 0c             	mov    0xc(%ebp),%edx
  80167a:	8b 45 08             	mov    0x8(%ebp),%eax
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	51                   	push   %ecx
  801682:	52                   	push   %edx
  801683:	50                   	push   %eax
  801684:	6a 1e                	push   $0x1e
  801686:	e8 7a fc ff ff       	call   801305 <syscall>
  80168b:	83 c4 18             	add    $0x18,%esp
}
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801693:	8b 55 0c             	mov    0xc(%ebp),%edx
  801696:	8b 45 08             	mov    0x8(%ebp),%eax
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 00                	push   $0x0
  80169f:	52                   	push   %edx
  8016a0:	50                   	push   %eax
  8016a1:	6a 1f                	push   $0x1f
  8016a3:	e8 5d fc ff ff       	call   801305 <syscall>
  8016a8:	83 c4 18             	add    $0x18,%esp
}
  8016ab:	c9                   	leave  
  8016ac:	c3                   	ret    

008016ad <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016ad:	55                   	push   %ebp
  8016ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 20                	push   $0x20
  8016bc:	e8 44 fc ff ff       	call   801305 <syscall>
  8016c1:	83 c4 18             	add    $0x18,%esp
}
  8016c4:	c9                   	leave  
  8016c5:	c3                   	ret    

008016c6 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8016c6:	55                   	push   %ebp
  8016c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8016c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	ff 75 10             	pushl  0x10(%ebp)
  8016d3:	ff 75 0c             	pushl  0xc(%ebp)
  8016d6:	50                   	push   %eax
  8016d7:	6a 21                	push   $0x21
  8016d9:	e8 27 fc ff ff       	call   801305 <syscall>
  8016de:	83 c4 18             	add    $0x18,%esp
}
  8016e1:	c9                   	leave  
  8016e2:	c3                   	ret    

008016e3 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8016e3:	55                   	push   %ebp
  8016e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	50                   	push   %eax
  8016f2:	6a 22                	push   $0x22
  8016f4:	e8 0c fc ff ff       	call   801305 <syscall>
  8016f9:	83 c4 18             	add    $0x18,%esp
}
  8016fc:	90                   	nop
  8016fd:	c9                   	leave  
  8016fe:	c3                   	ret    

008016ff <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801702:	8b 45 08             	mov    0x8(%ebp),%eax
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	50                   	push   %eax
  80170e:	6a 23                	push   $0x23
  801710:	e8 f0 fb ff ff       	call   801305 <syscall>
  801715:	83 c4 18             	add    $0x18,%esp
}
  801718:	90                   	nop
  801719:	c9                   	leave  
  80171a:	c3                   	ret    

0080171b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80171b:	55                   	push   %ebp
  80171c:	89 e5                	mov    %esp,%ebp
  80171e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801721:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801724:	8d 50 04             	lea    0x4(%eax),%edx
  801727:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	52                   	push   %edx
  801731:	50                   	push   %eax
  801732:	6a 24                	push   $0x24
  801734:	e8 cc fb ff ff       	call   801305 <syscall>
  801739:	83 c4 18             	add    $0x18,%esp
	return result;
  80173c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80173f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801742:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801745:	89 01                	mov    %eax,(%ecx)
  801747:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80174a:	8b 45 08             	mov    0x8(%ebp),%eax
  80174d:	c9                   	leave  
  80174e:	c2 04 00             	ret    $0x4

00801751 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801751:	55                   	push   %ebp
  801752:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801754:	6a 00                	push   $0x0
  801756:	6a 00                	push   $0x0
  801758:	ff 75 10             	pushl  0x10(%ebp)
  80175b:	ff 75 0c             	pushl  0xc(%ebp)
  80175e:	ff 75 08             	pushl  0x8(%ebp)
  801761:	6a 13                	push   $0x13
  801763:	e8 9d fb ff ff       	call   801305 <syscall>
  801768:	83 c4 18             	add    $0x18,%esp
	return ;
  80176b:	90                   	nop
}
  80176c:	c9                   	leave  
  80176d:	c3                   	ret    

0080176e <sys_rcr2>:
uint32 sys_rcr2()
{
  80176e:	55                   	push   %ebp
  80176f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 25                	push   $0x25
  80177d:	e8 83 fb ff ff       	call   801305 <syscall>
  801782:	83 c4 18             	add    $0x18,%esp
}
  801785:	c9                   	leave  
  801786:	c3                   	ret    

00801787 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801787:	55                   	push   %ebp
  801788:	89 e5                	mov    %esp,%ebp
  80178a:	83 ec 04             	sub    $0x4,%esp
  80178d:	8b 45 08             	mov    0x8(%ebp),%eax
  801790:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801793:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	50                   	push   %eax
  8017a0:	6a 26                	push   $0x26
  8017a2:	e8 5e fb ff ff       	call   801305 <syscall>
  8017a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8017aa:	90                   	nop
}
  8017ab:	c9                   	leave  
  8017ac:	c3                   	ret    

008017ad <rsttst>:
void rsttst()
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 28                	push   $0x28
  8017bc:	e8 44 fb ff ff       	call   801305 <syscall>
  8017c1:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c4:	90                   	nop
}
  8017c5:	c9                   	leave  
  8017c6:	c3                   	ret    

008017c7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8017c7:	55                   	push   %ebp
  8017c8:	89 e5                	mov    %esp,%ebp
  8017ca:	83 ec 04             	sub    $0x4,%esp
  8017cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8017d0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8017d3:	8b 55 18             	mov    0x18(%ebp),%edx
  8017d6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017da:	52                   	push   %edx
  8017db:	50                   	push   %eax
  8017dc:	ff 75 10             	pushl  0x10(%ebp)
  8017df:	ff 75 0c             	pushl  0xc(%ebp)
  8017e2:	ff 75 08             	pushl  0x8(%ebp)
  8017e5:	6a 27                	push   $0x27
  8017e7:	e8 19 fb ff ff       	call   801305 <syscall>
  8017ec:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ef:	90                   	nop
}
  8017f0:	c9                   	leave  
  8017f1:	c3                   	ret    

008017f2 <chktst>:
void chktst(uint32 n)
{
  8017f2:	55                   	push   %ebp
  8017f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	ff 75 08             	pushl  0x8(%ebp)
  801800:	6a 29                	push   $0x29
  801802:	e8 fe fa ff ff       	call   801305 <syscall>
  801807:	83 c4 18             	add    $0x18,%esp
	return ;
  80180a:	90                   	nop
}
  80180b:	c9                   	leave  
  80180c:	c3                   	ret    

0080180d <inctst>:

void inctst()
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 2a                	push   $0x2a
  80181c:	e8 e4 fa ff ff       	call   801305 <syscall>
  801821:	83 c4 18             	add    $0x18,%esp
	return ;
  801824:	90                   	nop
}
  801825:	c9                   	leave  
  801826:	c3                   	ret    

00801827 <gettst>:
uint32 gettst()
{
  801827:	55                   	push   %ebp
  801828:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 2b                	push   $0x2b
  801836:	e8 ca fa ff ff       	call   801305 <syscall>
  80183b:	83 c4 18             	add    $0x18,%esp
}
  80183e:	c9                   	leave  
  80183f:	c3                   	ret    

00801840 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801840:	55                   	push   %ebp
  801841:	89 e5                	mov    %esp,%ebp
  801843:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	6a 2c                	push   $0x2c
  801852:	e8 ae fa ff ff       	call   801305 <syscall>
  801857:	83 c4 18             	add    $0x18,%esp
  80185a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80185d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801861:	75 07                	jne    80186a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801863:	b8 01 00 00 00       	mov    $0x1,%eax
  801868:	eb 05                	jmp    80186f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80186a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80186f:	c9                   	leave  
  801870:	c3                   	ret    

00801871 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801871:	55                   	push   %ebp
  801872:	89 e5                	mov    %esp,%ebp
  801874:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 2c                	push   $0x2c
  801883:	e8 7d fa ff ff       	call   801305 <syscall>
  801888:	83 c4 18             	add    $0x18,%esp
  80188b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80188e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801892:	75 07                	jne    80189b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801894:	b8 01 00 00 00       	mov    $0x1,%eax
  801899:	eb 05                	jmp    8018a0 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80189b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
  8018a5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 2c                	push   $0x2c
  8018b4:	e8 4c fa ff ff       	call   801305 <syscall>
  8018b9:	83 c4 18             	add    $0x18,%esp
  8018bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018bf:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8018c3:	75 07                	jne    8018cc <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8018c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ca:	eb 05                	jmp    8018d1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8018cc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
  8018d6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 2c                	push   $0x2c
  8018e5:	e8 1b fa ff ff       	call   801305 <syscall>
  8018ea:	83 c4 18             	add    $0x18,%esp
  8018ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8018f0:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8018f4:	75 07                	jne    8018fd <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8018f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8018fb:	eb 05                	jmp    801902 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8018fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801902:	c9                   	leave  
  801903:	c3                   	ret    

00801904 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801904:	55                   	push   %ebp
  801905:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801907:	6a 00                	push   $0x0
  801909:	6a 00                	push   $0x0
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	ff 75 08             	pushl  0x8(%ebp)
  801912:	6a 2d                	push   $0x2d
  801914:	e8 ec f9 ff ff       	call   801305 <syscall>
  801919:	83 c4 18             	add    $0x18,%esp
	return ;
  80191c:	90                   	nop
}
  80191d:	c9                   	leave  
  80191e:	c3                   	ret    

0080191f <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80191f:	55                   	push   %ebp
  801920:	89 e5                	mov    %esp,%ebp
  801922:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801925:	8b 45 08             	mov    0x8(%ebp),%eax
  801928:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80192b:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80192f:	83 ec 0c             	sub    $0xc,%esp
  801932:	50                   	push   %eax
  801933:	e8 3d fc ff ff       	call   801575 <sys_cputc>
  801938:	83 c4 10             	add    $0x10,%esp
}
  80193b:	90                   	nop
  80193c:	c9                   	leave  
  80193d:	c3                   	ret    

0080193e <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80193e:	55                   	push   %ebp
  80193f:	89 e5                	mov    %esp,%ebp
  801941:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801944:	e8 f8 fb ff ff       	call   801541 <sys_disable_interrupt>
	char c = ch;
  801949:	8b 45 08             	mov    0x8(%ebp),%eax
  80194c:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80194f:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801953:	83 ec 0c             	sub    $0xc,%esp
  801956:	50                   	push   %eax
  801957:	e8 19 fc ff ff       	call   801575 <sys_cputc>
  80195c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80195f:	e8 f7 fb ff ff       	call   80155b <sys_enable_interrupt>
}
  801964:	90                   	nop
  801965:	c9                   	leave  
  801966:	c3                   	ret    

00801967 <getchar>:

int
getchar(void)
{
  801967:	55                   	push   %ebp
  801968:	89 e5                	mov    %esp,%ebp
  80196a:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80196d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801974:	eb 08                	jmp    80197e <getchar+0x17>
	{
		c = sys_cgetc();
  801976:	e8 de f9 ff ff       	call   801359 <sys_cgetc>
  80197b:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80197e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801982:	74 f2                	je     801976 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  801984:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801987:	c9                   	leave  
  801988:	c3                   	ret    

00801989 <atomic_getchar>:

int
atomic_getchar(void)
{
  801989:	55                   	push   %ebp
  80198a:	89 e5                	mov    %esp,%ebp
  80198c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80198f:	e8 ad fb ff ff       	call   801541 <sys_disable_interrupt>
	int c=0;
  801994:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80199b:	eb 08                	jmp    8019a5 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  80199d:	e8 b7 f9 ff ff       	call   801359 <sys_cgetc>
  8019a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8019a5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8019a9:	74 f2                	je     80199d <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8019ab:	e8 ab fb ff ff       	call   80155b <sys_enable_interrupt>
	return c;
  8019b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <iscons>:

int iscons(int fdnum)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8019b8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019bd:	5d                   	pop    %ebp
  8019be:	c3                   	ret    
  8019bf:	90                   	nop

008019c0 <__udivdi3>:
  8019c0:	55                   	push   %ebp
  8019c1:	57                   	push   %edi
  8019c2:	56                   	push   %esi
  8019c3:	53                   	push   %ebx
  8019c4:	83 ec 1c             	sub    $0x1c,%esp
  8019c7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019cb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019cf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019d3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019d7:	89 ca                	mov    %ecx,%edx
  8019d9:	89 f8                	mov    %edi,%eax
  8019db:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019df:	85 f6                	test   %esi,%esi
  8019e1:	75 2d                	jne    801a10 <__udivdi3+0x50>
  8019e3:	39 cf                	cmp    %ecx,%edi
  8019e5:	77 65                	ja     801a4c <__udivdi3+0x8c>
  8019e7:	89 fd                	mov    %edi,%ebp
  8019e9:	85 ff                	test   %edi,%edi
  8019eb:	75 0b                	jne    8019f8 <__udivdi3+0x38>
  8019ed:	b8 01 00 00 00       	mov    $0x1,%eax
  8019f2:	31 d2                	xor    %edx,%edx
  8019f4:	f7 f7                	div    %edi
  8019f6:	89 c5                	mov    %eax,%ebp
  8019f8:	31 d2                	xor    %edx,%edx
  8019fa:	89 c8                	mov    %ecx,%eax
  8019fc:	f7 f5                	div    %ebp
  8019fe:	89 c1                	mov    %eax,%ecx
  801a00:	89 d8                	mov    %ebx,%eax
  801a02:	f7 f5                	div    %ebp
  801a04:	89 cf                	mov    %ecx,%edi
  801a06:	89 fa                	mov    %edi,%edx
  801a08:	83 c4 1c             	add    $0x1c,%esp
  801a0b:	5b                   	pop    %ebx
  801a0c:	5e                   	pop    %esi
  801a0d:	5f                   	pop    %edi
  801a0e:	5d                   	pop    %ebp
  801a0f:	c3                   	ret    
  801a10:	39 ce                	cmp    %ecx,%esi
  801a12:	77 28                	ja     801a3c <__udivdi3+0x7c>
  801a14:	0f bd fe             	bsr    %esi,%edi
  801a17:	83 f7 1f             	xor    $0x1f,%edi
  801a1a:	75 40                	jne    801a5c <__udivdi3+0x9c>
  801a1c:	39 ce                	cmp    %ecx,%esi
  801a1e:	72 0a                	jb     801a2a <__udivdi3+0x6a>
  801a20:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a24:	0f 87 9e 00 00 00    	ja     801ac8 <__udivdi3+0x108>
  801a2a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a2f:	89 fa                	mov    %edi,%edx
  801a31:	83 c4 1c             	add    $0x1c,%esp
  801a34:	5b                   	pop    %ebx
  801a35:	5e                   	pop    %esi
  801a36:	5f                   	pop    %edi
  801a37:	5d                   	pop    %ebp
  801a38:	c3                   	ret    
  801a39:	8d 76 00             	lea    0x0(%esi),%esi
  801a3c:	31 ff                	xor    %edi,%edi
  801a3e:	31 c0                	xor    %eax,%eax
  801a40:	89 fa                	mov    %edi,%edx
  801a42:	83 c4 1c             	add    $0x1c,%esp
  801a45:	5b                   	pop    %ebx
  801a46:	5e                   	pop    %esi
  801a47:	5f                   	pop    %edi
  801a48:	5d                   	pop    %ebp
  801a49:	c3                   	ret    
  801a4a:	66 90                	xchg   %ax,%ax
  801a4c:	89 d8                	mov    %ebx,%eax
  801a4e:	f7 f7                	div    %edi
  801a50:	31 ff                	xor    %edi,%edi
  801a52:	89 fa                	mov    %edi,%edx
  801a54:	83 c4 1c             	add    $0x1c,%esp
  801a57:	5b                   	pop    %ebx
  801a58:	5e                   	pop    %esi
  801a59:	5f                   	pop    %edi
  801a5a:	5d                   	pop    %ebp
  801a5b:	c3                   	ret    
  801a5c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a61:	89 eb                	mov    %ebp,%ebx
  801a63:	29 fb                	sub    %edi,%ebx
  801a65:	89 f9                	mov    %edi,%ecx
  801a67:	d3 e6                	shl    %cl,%esi
  801a69:	89 c5                	mov    %eax,%ebp
  801a6b:	88 d9                	mov    %bl,%cl
  801a6d:	d3 ed                	shr    %cl,%ebp
  801a6f:	89 e9                	mov    %ebp,%ecx
  801a71:	09 f1                	or     %esi,%ecx
  801a73:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a77:	89 f9                	mov    %edi,%ecx
  801a79:	d3 e0                	shl    %cl,%eax
  801a7b:	89 c5                	mov    %eax,%ebp
  801a7d:	89 d6                	mov    %edx,%esi
  801a7f:	88 d9                	mov    %bl,%cl
  801a81:	d3 ee                	shr    %cl,%esi
  801a83:	89 f9                	mov    %edi,%ecx
  801a85:	d3 e2                	shl    %cl,%edx
  801a87:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a8b:	88 d9                	mov    %bl,%cl
  801a8d:	d3 e8                	shr    %cl,%eax
  801a8f:	09 c2                	or     %eax,%edx
  801a91:	89 d0                	mov    %edx,%eax
  801a93:	89 f2                	mov    %esi,%edx
  801a95:	f7 74 24 0c          	divl   0xc(%esp)
  801a99:	89 d6                	mov    %edx,%esi
  801a9b:	89 c3                	mov    %eax,%ebx
  801a9d:	f7 e5                	mul    %ebp
  801a9f:	39 d6                	cmp    %edx,%esi
  801aa1:	72 19                	jb     801abc <__udivdi3+0xfc>
  801aa3:	74 0b                	je     801ab0 <__udivdi3+0xf0>
  801aa5:	89 d8                	mov    %ebx,%eax
  801aa7:	31 ff                	xor    %edi,%edi
  801aa9:	e9 58 ff ff ff       	jmp    801a06 <__udivdi3+0x46>
  801aae:	66 90                	xchg   %ax,%ax
  801ab0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ab4:	89 f9                	mov    %edi,%ecx
  801ab6:	d3 e2                	shl    %cl,%edx
  801ab8:	39 c2                	cmp    %eax,%edx
  801aba:	73 e9                	jae    801aa5 <__udivdi3+0xe5>
  801abc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801abf:	31 ff                	xor    %edi,%edi
  801ac1:	e9 40 ff ff ff       	jmp    801a06 <__udivdi3+0x46>
  801ac6:	66 90                	xchg   %ax,%ax
  801ac8:	31 c0                	xor    %eax,%eax
  801aca:	e9 37 ff ff ff       	jmp    801a06 <__udivdi3+0x46>
  801acf:	90                   	nop

00801ad0 <__umoddi3>:
  801ad0:	55                   	push   %ebp
  801ad1:	57                   	push   %edi
  801ad2:	56                   	push   %esi
  801ad3:	53                   	push   %ebx
  801ad4:	83 ec 1c             	sub    $0x1c,%esp
  801ad7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801adb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801adf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ae3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ae7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801aeb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801aef:	89 f3                	mov    %esi,%ebx
  801af1:	89 fa                	mov    %edi,%edx
  801af3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801af7:	89 34 24             	mov    %esi,(%esp)
  801afa:	85 c0                	test   %eax,%eax
  801afc:	75 1a                	jne    801b18 <__umoddi3+0x48>
  801afe:	39 f7                	cmp    %esi,%edi
  801b00:	0f 86 a2 00 00 00    	jbe    801ba8 <__umoddi3+0xd8>
  801b06:	89 c8                	mov    %ecx,%eax
  801b08:	89 f2                	mov    %esi,%edx
  801b0a:	f7 f7                	div    %edi
  801b0c:	89 d0                	mov    %edx,%eax
  801b0e:	31 d2                	xor    %edx,%edx
  801b10:	83 c4 1c             	add    $0x1c,%esp
  801b13:	5b                   	pop    %ebx
  801b14:	5e                   	pop    %esi
  801b15:	5f                   	pop    %edi
  801b16:	5d                   	pop    %ebp
  801b17:	c3                   	ret    
  801b18:	39 f0                	cmp    %esi,%eax
  801b1a:	0f 87 ac 00 00 00    	ja     801bcc <__umoddi3+0xfc>
  801b20:	0f bd e8             	bsr    %eax,%ebp
  801b23:	83 f5 1f             	xor    $0x1f,%ebp
  801b26:	0f 84 ac 00 00 00    	je     801bd8 <__umoddi3+0x108>
  801b2c:	bf 20 00 00 00       	mov    $0x20,%edi
  801b31:	29 ef                	sub    %ebp,%edi
  801b33:	89 fe                	mov    %edi,%esi
  801b35:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b39:	89 e9                	mov    %ebp,%ecx
  801b3b:	d3 e0                	shl    %cl,%eax
  801b3d:	89 d7                	mov    %edx,%edi
  801b3f:	89 f1                	mov    %esi,%ecx
  801b41:	d3 ef                	shr    %cl,%edi
  801b43:	09 c7                	or     %eax,%edi
  801b45:	89 e9                	mov    %ebp,%ecx
  801b47:	d3 e2                	shl    %cl,%edx
  801b49:	89 14 24             	mov    %edx,(%esp)
  801b4c:	89 d8                	mov    %ebx,%eax
  801b4e:	d3 e0                	shl    %cl,%eax
  801b50:	89 c2                	mov    %eax,%edx
  801b52:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b56:	d3 e0                	shl    %cl,%eax
  801b58:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b5c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b60:	89 f1                	mov    %esi,%ecx
  801b62:	d3 e8                	shr    %cl,%eax
  801b64:	09 d0                	or     %edx,%eax
  801b66:	d3 eb                	shr    %cl,%ebx
  801b68:	89 da                	mov    %ebx,%edx
  801b6a:	f7 f7                	div    %edi
  801b6c:	89 d3                	mov    %edx,%ebx
  801b6e:	f7 24 24             	mull   (%esp)
  801b71:	89 c6                	mov    %eax,%esi
  801b73:	89 d1                	mov    %edx,%ecx
  801b75:	39 d3                	cmp    %edx,%ebx
  801b77:	0f 82 87 00 00 00    	jb     801c04 <__umoddi3+0x134>
  801b7d:	0f 84 91 00 00 00    	je     801c14 <__umoddi3+0x144>
  801b83:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b87:	29 f2                	sub    %esi,%edx
  801b89:	19 cb                	sbb    %ecx,%ebx
  801b8b:	89 d8                	mov    %ebx,%eax
  801b8d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b91:	d3 e0                	shl    %cl,%eax
  801b93:	89 e9                	mov    %ebp,%ecx
  801b95:	d3 ea                	shr    %cl,%edx
  801b97:	09 d0                	or     %edx,%eax
  801b99:	89 e9                	mov    %ebp,%ecx
  801b9b:	d3 eb                	shr    %cl,%ebx
  801b9d:	89 da                	mov    %ebx,%edx
  801b9f:	83 c4 1c             	add    $0x1c,%esp
  801ba2:	5b                   	pop    %ebx
  801ba3:	5e                   	pop    %esi
  801ba4:	5f                   	pop    %edi
  801ba5:	5d                   	pop    %ebp
  801ba6:	c3                   	ret    
  801ba7:	90                   	nop
  801ba8:	89 fd                	mov    %edi,%ebp
  801baa:	85 ff                	test   %edi,%edi
  801bac:	75 0b                	jne    801bb9 <__umoddi3+0xe9>
  801bae:	b8 01 00 00 00       	mov    $0x1,%eax
  801bb3:	31 d2                	xor    %edx,%edx
  801bb5:	f7 f7                	div    %edi
  801bb7:	89 c5                	mov    %eax,%ebp
  801bb9:	89 f0                	mov    %esi,%eax
  801bbb:	31 d2                	xor    %edx,%edx
  801bbd:	f7 f5                	div    %ebp
  801bbf:	89 c8                	mov    %ecx,%eax
  801bc1:	f7 f5                	div    %ebp
  801bc3:	89 d0                	mov    %edx,%eax
  801bc5:	e9 44 ff ff ff       	jmp    801b0e <__umoddi3+0x3e>
  801bca:	66 90                	xchg   %ax,%ax
  801bcc:	89 c8                	mov    %ecx,%eax
  801bce:	89 f2                	mov    %esi,%edx
  801bd0:	83 c4 1c             	add    $0x1c,%esp
  801bd3:	5b                   	pop    %ebx
  801bd4:	5e                   	pop    %esi
  801bd5:	5f                   	pop    %edi
  801bd6:	5d                   	pop    %ebp
  801bd7:	c3                   	ret    
  801bd8:	3b 04 24             	cmp    (%esp),%eax
  801bdb:	72 06                	jb     801be3 <__umoddi3+0x113>
  801bdd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801be1:	77 0f                	ja     801bf2 <__umoddi3+0x122>
  801be3:	89 f2                	mov    %esi,%edx
  801be5:	29 f9                	sub    %edi,%ecx
  801be7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801beb:	89 14 24             	mov    %edx,(%esp)
  801bee:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bf2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bf6:	8b 14 24             	mov    (%esp),%edx
  801bf9:	83 c4 1c             	add    $0x1c,%esp
  801bfc:	5b                   	pop    %ebx
  801bfd:	5e                   	pop    %esi
  801bfe:	5f                   	pop    %edi
  801bff:	5d                   	pop    %ebp
  801c00:	c3                   	ret    
  801c01:	8d 76 00             	lea    0x0(%esi),%esi
  801c04:	2b 04 24             	sub    (%esp),%eax
  801c07:	19 fa                	sbb    %edi,%edx
  801c09:	89 d1                	mov    %edx,%ecx
  801c0b:	89 c6                	mov    %eax,%esi
  801c0d:	e9 71 ff ff ff       	jmp    801b83 <__umoddi3+0xb3>
  801c12:	66 90                	xchg   %ax,%ax
  801c14:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c18:	72 ea                	jb     801c04 <__umoddi3+0x134>
  801c1a:	89 d9                	mov    %ebx,%ecx
  801c1c:	e9 62 ff ff ff       	jmp    801b83 <__umoddi3+0xb3>
