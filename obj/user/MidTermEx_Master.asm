
obj/user/MidTermEx_Master:     file format elf32-i386


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
  800031:	e8 fe 01 00 00       	call   800234 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests the usage of shared variables
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	/*[1] CREATE SHARED VARIABLE & INITIALIZE IT*/
	int *X = smalloc("X", sizeof(int) , 1) ;
  80003e:	83 ec 04             	sub    $0x4,%esp
  800041:	6a 01                	push   $0x1
  800043:	6a 04                	push   $0x4
  800045:	68 a0 1e 80 00       	push   $0x801ea0
  80004a:	e8 45 11 00 00       	call   801194 <smalloc>
  80004f:	83 c4 10             	add    $0x10,%esp
  800052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*X = 5 ;
  800055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800058:	c7 00 05 00 00 00    	movl   $0x5,(%eax)

	/*[2] SPECIFY WHETHER TO USE SEMAPHORE OR NOT*/
	cprintf("Do you want to use semaphore (y/n)? ") ;
  80005e:	83 ec 0c             	sub    $0xc,%esp
  800061:	68 a4 1e 80 00       	push   $0x801ea4
  800066:	e8 9f 03 00 00       	call   80040a <cprintf>
  80006b:	83 c4 10             	add    $0x10,%esp
	char select = getchar() ;
  80006e:	e8 69 01 00 00       	call   8001dc <getchar>
  800073:	88 45 f3             	mov    %al,-0xd(%ebp)
	cputchar(select);
  800076:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  80007a:	83 ec 0c             	sub    $0xc,%esp
  80007d:	50                   	push   %eax
  80007e:	e8 11 01 00 00       	call   800194 <cputchar>
  800083:	83 c4 10             	add    $0x10,%esp
	cputchar('\n');
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	6a 0a                	push   $0xa
  80008b:	e8 04 01 00 00       	call   800194 <cputchar>
  800090:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THIS SELECTION WITH OTHER PROCESSES*/
	int *useSem = smalloc("useSem", sizeof(int) , 0) ;
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	6a 00                	push   $0x0
  800098:	6a 04                	push   $0x4
  80009a:	68 c9 1e 80 00       	push   $0x801ec9
  80009f:	e8 f0 10 00 00       	call   801194 <smalloc>
  8000a4:	83 c4 10             	add    $0x10,%esp
  8000a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
	*useSem = 0 ;
  8000aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ad:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	if (select == 'Y' || select == 'y')
  8000b3:	80 7d f3 59          	cmpb   $0x59,-0xd(%ebp)
  8000b7:	74 06                	je     8000bf <_main+0x87>
  8000b9:	80 7d f3 79          	cmpb   $0x79,-0xd(%ebp)
  8000bd:	75 09                	jne    8000c8 <_main+0x90>
		*useSem = 1 ;
  8000bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000c2:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

	if (*useSem == 1)
  8000c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000cb:	8b 00                	mov    (%eax),%eax
  8000cd:	83 f8 01             	cmp    $0x1,%eax
  8000d0:	75 12                	jne    8000e4 <_main+0xac>
	{
		sys_createSemaphore("T", 0);
  8000d2:	83 ec 08             	sub    $0x8,%esp
  8000d5:	6a 00                	push   $0x0
  8000d7:	68 d0 1e 80 00       	push   $0x801ed0
  8000dc:	e8 f3 15 00 00       	call   8016d4 <sys_createSemaphore>
  8000e1:	83 c4 10             	add    $0x10,%esp
	}

	/*[4] CREATE AND RUN ProcessA & ProcessB*/

	//Create the check-finishing counter
	int *numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  8000e4:	83 ec 04             	sub    $0x4,%esp
  8000e7:	6a 01                	push   $0x1
  8000e9:	6a 04                	push   $0x4
  8000eb:	68 d2 1e 80 00       	push   $0x801ed2
  8000f0:	e8 9f 10 00 00       	call   801194 <smalloc>
  8000f5:	83 c4 10             	add    $0x10,%esp
  8000f8:	89 45 e8             	mov    %eax,-0x18(%ebp)
	*numOfFinished = 0 ;
  8000fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000fe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	//Create the 2 processes
	int32 envIdProcessA = sys_create_env("midterm_a", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800104:	a1 20 30 80 00       	mov    0x803020,%eax
  800109:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  80010f:	a1 20 30 80 00       	mov    0x803020,%eax
  800114:	8b 40 74             	mov    0x74(%eax),%eax
  800117:	83 ec 04             	sub    $0x4,%esp
  80011a:	52                   	push   %edx
  80011b:	50                   	push   %eax
  80011c:	68 e0 1e 80 00       	push   $0x801ee0
  800121:	e8 bf 16 00 00       	call   8017e5 <sys_create_env>
  800126:	83 c4 10             	add    $0x10,%esp
  800129:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int32 envIdProcessB = sys_create_env("midterm_b", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80012c:	a1 20 30 80 00       	mov    0x803020,%eax
  800131:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800137:	a1 20 30 80 00       	mov    0x803020,%eax
  80013c:	8b 40 74             	mov    0x74(%eax),%eax
  80013f:	83 ec 04             	sub    $0x4,%esp
  800142:	52                   	push   %edx
  800143:	50                   	push   %eax
  800144:	68 ea 1e 80 00       	push   $0x801eea
  800149:	e8 97 16 00 00       	call   8017e5 <sys_create_env>
  80014e:	83 c4 10             	add    $0x10,%esp
  800151:	89 45 e0             	mov    %eax,-0x20(%ebp)

	//Run the 2 processes
	sys_run_env(envIdProcessA);
  800154:	83 ec 0c             	sub    $0xc,%esp
  800157:	ff 75 e4             	pushl  -0x1c(%ebp)
  80015a:	e8 a3 16 00 00       	call   801802 <sys_run_env>
  80015f:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  800162:	83 ec 0c             	sub    $0xc,%esp
  800165:	ff 75 e0             	pushl  -0x20(%ebp)
  800168:	e8 95 16 00 00       	call   801802 <sys_run_env>
  80016d:	83 c4 10             	add    $0x10,%esp

	/*[5] BUSY-WAIT TILL FINISHING BOTH PROCESSES*/
	while (*numOfFinished != 2) ;
  800170:	90                   	nop
  800171:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800174:	8b 00                	mov    (%eax),%eax
  800176:	83 f8 02             	cmp    $0x2,%eax
  800179:	75 f6                	jne    800171 <_main+0x139>

	/*[6] PRINT X*/
	cprintf("Final value of X = %d\n", *X);
  80017b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80017e:	8b 00                	mov    (%eax),%eax
  800180:	83 ec 08             	sub    $0x8,%esp
  800183:	50                   	push   %eax
  800184:	68 f4 1e 80 00       	push   $0x801ef4
  800189:	e8 7c 02 00 00       	call   80040a <cprintf>
  80018e:	83 c4 10             	add    $0x10,%esp

	return;
  800191:	90                   	nop
}
  800192:	c9                   	leave  
  800193:	c3                   	ret    

00800194 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800194:	55                   	push   %ebp
  800195:	89 e5                	mov    %esp,%ebp
  800197:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80019a:	8b 45 08             	mov    0x8(%ebp),%eax
  80019d:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8001a0:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8001a4:	83 ec 0c             	sub    $0xc,%esp
  8001a7:	50                   	push   %eax
  8001a8:	e8 e7 14 00 00       	call   801694 <sys_cputc>
  8001ad:	83 c4 10             	add    $0x10,%esp
}
  8001b0:	90                   	nop
  8001b1:	c9                   	leave  
  8001b2:	c3                   	ret    

008001b3 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8001b3:	55                   	push   %ebp
  8001b4:	89 e5                	mov    %esp,%ebp
  8001b6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8001b9:	e8 a2 14 00 00       	call   801660 <sys_disable_interrupt>
	char c = ch;
  8001be:	8b 45 08             	mov    0x8(%ebp),%eax
  8001c1:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8001c4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8001c8:	83 ec 0c             	sub    $0xc,%esp
  8001cb:	50                   	push   %eax
  8001cc:	e8 c3 14 00 00       	call   801694 <sys_cputc>
  8001d1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001d4:	e8 a1 14 00 00       	call   80167a <sys_enable_interrupt>
}
  8001d9:	90                   	nop
  8001da:	c9                   	leave  
  8001db:	c3                   	ret    

008001dc <getchar>:

int
getchar(void)
{
  8001dc:	55                   	push   %ebp
  8001dd:	89 e5                	mov    %esp,%ebp
  8001df:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8001e2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8001e9:	eb 08                	jmp    8001f3 <getchar+0x17>
	{
		c = sys_cgetc();
  8001eb:	e8 88 12 00 00       	call   801478 <sys_cgetc>
  8001f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8001f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8001f7:	74 f2                	je     8001eb <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8001f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8001fc:	c9                   	leave  
  8001fd:	c3                   	ret    

008001fe <atomic_getchar>:

int
atomic_getchar(void)
{
  8001fe:	55                   	push   %ebp
  8001ff:	89 e5                	mov    %esp,%ebp
  800201:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800204:	e8 57 14 00 00       	call   801660 <sys_disable_interrupt>
	int c=0;
  800209:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800210:	eb 08                	jmp    80021a <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800212:	e8 61 12 00 00       	call   801478 <sys_cgetc>
  800217:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80021a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80021e:	74 f2                	je     800212 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800220:	e8 55 14 00 00       	call   80167a <sys_enable_interrupt>
	return c;
  800225:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800228:	c9                   	leave  
  800229:	c3                   	ret    

0080022a <iscons>:

int iscons(int fdnum)
{
  80022a:	55                   	push   %ebp
  80022b:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80022d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800232:	5d                   	pop    %ebp
  800233:	c3                   	ret    

00800234 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800234:	55                   	push   %ebp
  800235:	89 e5                	mov    %esp,%ebp
  800237:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80023a:	e8 86 12 00 00       	call   8014c5 <sys_getenvindex>
  80023f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800242:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800245:	89 d0                	mov    %edx,%eax
  800247:	01 c0                	add    %eax,%eax
  800249:	01 d0                	add    %edx,%eax
  80024b:	c1 e0 02             	shl    $0x2,%eax
  80024e:	01 d0                	add    %edx,%eax
  800250:	c1 e0 06             	shl    $0x6,%eax
  800253:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800258:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80025d:	a1 20 30 80 00       	mov    0x803020,%eax
  800262:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800268:	84 c0                	test   %al,%al
  80026a:	74 0f                	je     80027b <libmain+0x47>
		binaryname = myEnv->prog_name;
  80026c:	a1 20 30 80 00       	mov    0x803020,%eax
  800271:	05 f4 02 00 00       	add    $0x2f4,%eax
  800276:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80027b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80027f:	7e 0a                	jle    80028b <libmain+0x57>
		binaryname = argv[0];
  800281:	8b 45 0c             	mov    0xc(%ebp),%eax
  800284:	8b 00                	mov    (%eax),%eax
  800286:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80028b:	83 ec 08             	sub    $0x8,%esp
  80028e:	ff 75 0c             	pushl  0xc(%ebp)
  800291:	ff 75 08             	pushl  0x8(%ebp)
  800294:	e8 9f fd ff ff       	call   800038 <_main>
  800299:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80029c:	e8 bf 13 00 00       	call   801660 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8002a1:	83 ec 0c             	sub    $0xc,%esp
  8002a4:	68 24 1f 80 00       	push   $0x801f24
  8002a9:	e8 5c 01 00 00       	call   80040a <cprintf>
  8002ae:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b6:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8002bc:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c1:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8002c7:	83 ec 04             	sub    $0x4,%esp
  8002ca:	52                   	push   %edx
  8002cb:	50                   	push   %eax
  8002cc:	68 4c 1f 80 00       	push   $0x801f4c
  8002d1:	e8 34 01 00 00       	call   80040a <cprintf>
  8002d6:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8002de:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8002e4:	83 ec 08             	sub    $0x8,%esp
  8002e7:	50                   	push   %eax
  8002e8:	68 71 1f 80 00       	push   $0x801f71
  8002ed:	e8 18 01 00 00       	call   80040a <cprintf>
  8002f2:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002f5:	83 ec 0c             	sub    $0xc,%esp
  8002f8:	68 24 1f 80 00       	push   $0x801f24
  8002fd:	e8 08 01 00 00       	call   80040a <cprintf>
  800302:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800305:	e8 70 13 00 00       	call   80167a <sys_enable_interrupt>

	// exit gracefully
	exit();
  80030a:	e8 19 00 00 00       	call   800328 <exit>
}
  80030f:	90                   	nop
  800310:	c9                   	leave  
  800311:	c3                   	ret    

00800312 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800312:	55                   	push   %ebp
  800313:	89 e5                	mov    %esp,%ebp
  800315:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800318:	83 ec 0c             	sub    $0xc,%esp
  80031b:	6a 00                	push   $0x0
  80031d:	e8 6f 11 00 00       	call   801491 <sys_env_destroy>
  800322:	83 c4 10             	add    $0x10,%esp
}
  800325:	90                   	nop
  800326:	c9                   	leave  
  800327:	c3                   	ret    

00800328 <exit>:

void
exit(void)
{
  800328:	55                   	push   %ebp
  800329:	89 e5                	mov    %esp,%ebp
  80032b:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80032e:	e8 c4 11 00 00       	call   8014f7 <sys_env_exit>
}
  800333:	90                   	nop
  800334:	c9                   	leave  
  800335:	c3                   	ret    

00800336 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800336:	55                   	push   %ebp
  800337:	89 e5                	mov    %esp,%ebp
  800339:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80033c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80033f:	8b 00                	mov    (%eax),%eax
  800341:	8d 48 01             	lea    0x1(%eax),%ecx
  800344:	8b 55 0c             	mov    0xc(%ebp),%edx
  800347:	89 0a                	mov    %ecx,(%edx)
  800349:	8b 55 08             	mov    0x8(%ebp),%edx
  80034c:	88 d1                	mov    %dl,%cl
  80034e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800351:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800355:	8b 45 0c             	mov    0xc(%ebp),%eax
  800358:	8b 00                	mov    (%eax),%eax
  80035a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80035f:	75 2c                	jne    80038d <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800361:	a0 24 30 80 00       	mov    0x803024,%al
  800366:	0f b6 c0             	movzbl %al,%eax
  800369:	8b 55 0c             	mov    0xc(%ebp),%edx
  80036c:	8b 12                	mov    (%edx),%edx
  80036e:	89 d1                	mov    %edx,%ecx
  800370:	8b 55 0c             	mov    0xc(%ebp),%edx
  800373:	83 c2 08             	add    $0x8,%edx
  800376:	83 ec 04             	sub    $0x4,%esp
  800379:	50                   	push   %eax
  80037a:	51                   	push   %ecx
  80037b:	52                   	push   %edx
  80037c:	e8 ce 10 00 00       	call   80144f <sys_cputs>
  800381:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800384:	8b 45 0c             	mov    0xc(%ebp),%eax
  800387:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80038d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800390:	8b 40 04             	mov    0x4(%eax),%eax
  800393:	8d 50 01             	lea    0x1(%eax),%edx
  800396:	8b 45 0c             	mov    0xc(%ebp),%eax
  800399:	89 50 04             	mov    %edx,0x4(%eax)
}
  80039c:	90                   	nop
  80039d:	c9                   	leave  
  80039e:	c3                   	ret    

0080039f <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80039f:	55                   	push   %ebp
  8003a0:	89 e5                	mov    %esp,%ebp
  8003a2:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003a8:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8003af:	00 00 00 
	b.cnt = 0;
  8003b2:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8003b9:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8003bc:	ff 75 0c             	pushl  0xc(%ebp)
  8003bf:	ff 75 08             	pushl  0x8(%ebp)
  8003c2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003c8:	50                   	push   %eax
  8003c9:	68 36 03 80 00       	push   $0x800336
  8003ce:	e8 11 02 00 00       	call   8005e4 <vprintfmt>
  8003d3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8003d6:	a0 24 30 80 00       	mov    0x803024,%al
  8003db:	0f b6 c0             	movzbl %al,%eax
  8003de:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8003e4:	83 ec 04             	sub    $0x4,%esp
  8003e7:	50                   	push   %eax
  8003e8:	52                   	push   %edx
  8003e9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003ef:	83 c0 08             	add    $0x8,%eax
  8003f2:	50                   	push   %eax
  8003f3:	e8 57 10 00 00       	call   80144f <sys_cputs>
  8003f8:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8003fb:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800402:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800408:	c9                   	leave  
  800409:	c3                   	ret    

0080040a <cprintf>:

int cprintf(const char *fmt, ...) {
  80040a:	55                   	push   %ebp
  80040b:	89 e5                	mov    %esp,%ebp
  80040d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800410:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800417:	8d 45 0c             	lea    0xc(%ebp),%eax
  80041a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80041d:	8b 45 08             	mov    0x8(%ebp),%eax
  800420:	83 ec 08             	sub    $0x8,%esp
  800423:	ff 75 f4             	pushl  -0xc(%ebp)
  800426:	50                   	push   %eax
  800427:	e8 73 ff ff ff       	call   80039f <vcprintf>
  80042c:	83 c4 10             	add    $0x10,%esp
  80042f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800432:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800435:	c9                   	leave  
  800436:	c3                   	ret    

00800437 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800437:	55                   	push   %ebp
  800438:	89 e5                	mov    %esp,%ebp
  80043a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80043d:	e8 1e 12 00 00       	call   801660 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800442:	8d 45 0c             	lea    0xc(%ebp),%eax
  800445:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	83 ec 08             	sub    $0x8,%esp
  80044e:	ff 75 f4             	pushl  -0xc(%ebp)
  800451:	50                   	push   %eax
  800452:	e8 48 ff ff ff       	call   80039f <vcprintf>
  800457:	83 c4 10             	add    $0x10,%esp
  80045a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80045d:	e8 18 12 00 00       	call   80167a <sys_enable_interrupt>
	return cnt;
  800462:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800465:	c9                   	leave  
  800466:	c3                   	ret    

00800467 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800467:	55                   	push   %ebp
  800468:	89 e5                	mov    %esp,%ebp
  80046a:	53                   	push   %ebx
  80046b:	83 ec 14             	sub    $0x14,%esp
  80046e:	8b 45 10             	mov    0x10(%ebp),%eax
  800471:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800474:	8b 45 14             	mov    0x14(%ebp),%eax
  800477:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80047a:	8b 45 18             	mov    0x18(%ebp),%eax
  80047d:	ba 00 00 00 00       	mov    $0x0,%edx
  800482:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800485:	77 55                	ja     8004dc <printnum+0x75>
  800487:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80048a:	72 05                	jb     800491 <printnum+0x2a>
  80048c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80048f:	77 4b                	ja     8004dc <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800491:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800494:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800497:	8b 45 18             	mov    0x18(%ebp),%eax
  80049a:	ba 00 00 00 00       	mov    $0x0,%edx
  80049f:	52                   	push   %edx
  8004a0:	50                   	push   %eax
  8004a1:	ff 75 f4             	pushl  -0xc(%ebp)
  8004a4:	ff 75 f0             	pushl  -0x10(%ebp)
  8004a7:	e8 74 17 00 00       	call   801c20 <__udivdi3>
  8004ac:	83 c4 10             	add    $0x10,%esp
  8004af:	83 ec 04             	sub    $0x4,%esp
  8004b2:	ff 75 20             	pushl  0x20(%ebp)
  8004b5:	53                   	push   %ebx
  8004b6:	ff 75 18             	pushl  0x18(%ebp)
  8004b9:	52                   	push   %edx
  8004ba:	50                   	push   %eax
  8004bb:	ff 75 0c             	pushl  0xc(%ebp)
  8004be:	ff 75 08             	pushl  0x8(%ebp)
  8004c1:	e8 a1 ff ff ff       	call   800467 <printnum>
  8004c6:	83 c4 20             	add    $0x20,%esp
  8004c9:	eb 1a                	jmp    8004e5 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8004cb:	83 ec 08             	sub    $0x8,%esp
  8004ce:	ff 75 0c             	pushl  0xc(%ebp)
  8004d1:	ff 75 20             	pushl  0x20(%ebp)
  8004d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d7:	ff d0                	call   *%eax
  8004d9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8004dc:	ff 4d 1c             	decl   0x1c(%ebp)
  8004df:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8004e3:	7f e6                	jg     8004cb <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8004e5:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8004e8:	bb 00 00 00 00       	mov    $0x0,%ebx
  8004ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8004f3:	53                   	push   %ebx
  8004f4:	51                   	push   %ecx
  8004f5:	52                   	push   %edx
  8004f6:	50                   	push   %eax
  8004f7:	e8 34 18 00 00       	call   801d30 <__umoddi3>
  8004fc:	83 c4 10             	add    $0x10,%esp
  8004ff:	05 b4 21 80 00       	add    $0x8021b4,%eax
  800504:	8a 00                	mov    (%eax),%al
  800506:	0f be c0             	movsbl %al,%eax
  800509:	83 ec 08             	sub    $0x8,%esp
  80050c:	ff 75 0c             	pushl  0xc(%ebp)
  80050f:	50                   	push   %eax
  800510:	8b 45 08             	mov    0x8(%ebp),%eax
  800513:	ff d0                	call   *%eax
  800515:	83 c4 10             	add    $0x10,%esp
}
  800518:	90                   	nop
  800519:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80051c:	c9                   	leave  
  80051d:	c3                   	ret    

0080051e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80051e:	55                   	push   %ebp
  80051f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800521:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800525:	7e 1c                	jle    800543 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800527:	8b 45 08             	mov    0x8(%ebp),%eax
  80052a:	8b 00                	mov    (%eax),%eax
  80052c:	8d 50 08             	lea    0x8(%eax),%edx
  80052f:	8b 45 08             	mov    0x8(%ebp),%eax
  800532:	89 10                	mov    %edx,(%eax)
  800534:	8b 45 08             	mov    0x8(%ebp),%eax
  800537:	8b 00                	mov    (%eax),%eax
  800539:	83 e8 08             	sub    $0x8,%eax
  80053c:	8b 50 04             	mov    0x4(%eax),%edx
  80053f:	8b 00                	mov    (%eax),%eax
  800541:	eb 40                	jmp    800583 <getuint+0x65>
	else if (lflag)
  800543:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800547:	74 1e                	je     800567 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800549:	8b 45 08             	mov    0x8(%ebp),%eax
  80054c:	8b 00                	mov    (%eax),%eax
  80054e:	8d 50 04             	lea    0x4(%eax),%edx
  800551:	8b 45 08             	mov    0x8(%ebp),%eax
  800554:	89 10                	mov    %edx,(%eax)
  800556:	8b 45 08             	mov    0x8(%ebp),%eax
  800559:	8b 00                	mov    (%eax),%eax
  80055b:	83 e8 04             	sub    $0x4,%eax
  80055e:	8b 00                	mov    (%eax),%eax
  800560:	ba 00 00 00 00       	mov    $0x0,%edx
  800565:	eb 1c                	jmp    800583 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800567:	8b 45 08             	mov    0x8(%ebp),%eax
  80056a:	8b 00                	mov    (%eax),%eax
  80056c:	8d 50 04             	lea    0x4(%eax),%edx
  80056f:	8b 45 08             	mov    0x8(%ebp),%eax
  800572:	89 10                	mov    %edx,(%eax)
  800574:	8b 45 08             	mov    0x8(%ebp),%eax
  800577:	8b 00                	mov    (%eax),%eax
  800579:	83 e8 04             	sub    $0x4,%eax
  80057c:	8b 00                	mov    (%eax),%eax
  80057e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800583:	5d                   	pop    %ebp
  800584:	c3                   	ret    

00800585 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800585:	55                   	push   %ebp
  800586:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800588:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80058c:	7e 1c                	jle    8005aa <getint+0x25>
		return va_arg(*ap, long long);
  80058e:	8b 45 08             	mov    0x8(%ebp),%eax
  800591:	8b 00                	mov    (%eax),%eax
  800593:	8d 50 08             	lea    0x8(%eax),%edx
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	89 10                	mov    %edx,(%eax)
  80059b:	8b 45 08             	mov    0x8(%ebp),%eax
  80059e:	8b 00                	mov    (%eax),%eax
  8005a0:	83 e8 08             	sub    $0x8,%eax
  8005a3:	8b 50 04             	mov    0x4(%eax),%edx
  8005a6:	8b 00                	mov    (%eax),%eax
  8005a8:	eb 38                	jmp    8005e2 <getint+0x5d>
	else if (lflag)
  8005aa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005ae:	74 1a                	je     8005ca <getint+0x45>
		return va_arg(*ap, long);
  8005b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b3:	8b 00                	mov    (%eax),%eax
  8005b5:	8d 50 04             	lea    0x4(%eax),%edx
  8005b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bb:	89 10                	mov    %edx,(%eax)
  8005bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c0:	8b 00                	mov    (%eax),%eax
  8005c2:	83 e8 04             	sub    $0x4,%eax
  8005c5:	8b 00                	mov    (%eax),%eax
  8005c7:	99                   	cltd   
  8005c8:	eb 18                	jmp    8005e2 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8005ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8005cd:	8b 00                	mov    (%eax),%eax
  8005cf:	8d 50 04             	lea    0x4(%eax),%edx
  8005d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d5:	89 10                	mov    %edx,(%eax)
  8005d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005da:	8b 00                	mov    (%eax),%eax
  8005dc:	83 e8 04             	sub    $0x4,%eax
  8005df:	8b 00                	mov    (%eax),%eax
  8005e1:	99                   	cltd   
}
  8005e2:	5d                   	pop    %ebp
  8005e3:	c3                   	ret    

008005e4 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8005e4:	55                   	push   %ebp
  8005e5:	89 e5                	mov    %esp,%ebp
  8005e7:	56                   	push   %esi
  8005e8:	53                   	push   %ebx
  8005e9:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005ec:	eb 17                	jmp    800605 <vprintfmt+0x21>
			if (ch == '\0')
  8005ee:	85 db                	test   %ebx,%ebx
  8005f0:	0f 84 af 03 00 00    	je     8009a5 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8005f6:	83 ec 08             	sub    $0x8,%esp
  8005f9:	ff 75 0c             	pushl  0xc(%ebp)
  8005fc:	53                   	push   %ebx
  8005fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800600:	ff d0                	call   *%eax
  800602:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800605:	8b 45 10             	mov    0x10(%ebp),%eax
  800608:	8d 50 01             	lea    0x1(%eax),%edx
  80060b:	89 55 10             	mov    %edx,0x10(%ebp)
  80060e:	8a 00                	mov    (%eax),%al
  800610:	0f b6 d8             	movzbl %al,%ebx
  800613:	83 fb 25             	cmp    $0x25,%ebx
  800616:	75 d6                	jne    8005ee <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800618:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80061c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800623:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80062a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800631:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800638:	8b 45 10             	mov    0x10(%ebp),%eax
  80063b:	8d 50 01             	lea    0x1(%eax),%edx
  80063e:	89 55 10             	mov    %edx,0x10(%ebp)
  800641:	8a 00                	mov    (%eax),%al
  800643:	0f b6 d8             	movzbl %al,%ebx
  800646:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800649:	83 f8 55             	cmp    $0x55,%eax
  80064c:	0f 87 2b 03 00 00    	ja     80097d <vprintfmt+0x399>
  800652:	8b 04 85 d8 21 80 00 	mov    0x8021d8(,%eax,4),%eax
  800659:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80065b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80065f:	eb d7                	jmp    800638 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800661:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800665:	eb d1                	jmp    800638 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800667:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80066e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800671:	89 d0                	mov    %edx,%eax
  800673:	c1 e0 02             	shl    $0x2,%eax
  800676:	01 d0                	add    %edx,%eax
  800678:	01 c0                	add    %eax,%eax
  80067a:	01 d8                	add    %ebx,%eax
  80067c:	83 e8 30             	sub    $0x30,%eax
  80067f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800682:	8b 45 10             	mov    0x10(%ebp),%eax
  800685:	8a 00                	mov    (%eax),%al
  800687:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80068a:	83 fb 2f             	cmp    $0x2f,%ebx
  80068d:	7e 3e                	jle    8006cd <vprintfmt+0xe9>
  80068f:	83 fb 39             	cmp    $0x39,%ebx
  800692:	7f 39                	jg     8006cd <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800694:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800697:	eb d5                	jmp    80066e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800699:	8b 45 14             	mov    0x14(%ebp),%eax
  80069c:	83 c0 04             	add    $0x4,%eax
  80069f:	89 45 14             	mov    %eax,0x14(%ebp)
  8006a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8006a5:	83 e8 04             	sub    $0x4,%eax
  8006a8:	8b 00                	mov    (%eax),%eax
  8006aa:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8006ad:	eb 1f                	jmp    8006ce <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8006af:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006b3:	79 83                	jns    800638 <vprintfmt+0x54>
				width = 0;
  8006b5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8006bc:	e9 77 ff ff ff       	jmp    800638 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8006c1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8006c8:	e9 6b ff ff ff       	jmp    800638 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8006cd:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8006ce:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006d2:	0f 89 60 ff ff ff    	jns    800638 <vprintfmt+0x54>
				width = precision, precision = -1;
  8006d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8006de:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8006e5:	e9 4e ff ff ff       	jmp    800638 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8006ea:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8006ed:	e9 46 ff ff ff       	jmp    800638 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8006f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f5:	83 c0 04             	add    $0x4,%eax
  8006f8:	89 45 14             	mov    %eax,0x14(%ebp)
  8006fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8006fe:	83 e8 04             	sub    $0x4,%eax
  800701:	8b 00                	mov    (%eax),%eax
  800703:	83 ec 08             	sub    $0x8,%esp
  800706:	ff 75 0c             	pushl  0xc(%ebp)
  800709:	50                   	push   %eax
  80070a:	8b 45 08             	mov    0x8(%ebp),%eax
  80070d:	ff d0                	call   *%eax
  80070f:	83 c4 10             	add    $0x10,%esp
			break;
  800712:	e9 89 02 00 00       	jmp    8009a0 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800717:	8b 45 14             	mov    0x14(%ebp),%eax
  80071a:	83 c0 04             	add    $0x4,%eax
  80071d:	89 45 14             	mov    %eax,0x14(%ebp)
  800720:	8b 45 14             	mov    0x14(%ebp),%eax
  800723:	83 e8 04             	sub    $0x4,%eax
  800726:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800728:	85 db                	test   %ebx,%ebx
  80072a:	79 02                	jns    80072e <vprintfmt+0x14a>
				err = -err;
  80072c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80072e:	83 fb 64             	cmp    $0x64,%ebx
  800731:	7f 0b                	jg     80073e <vprintfmt+0x15a>
  800733:	8b 34 9d 20 20 80 00 	mov    0x802020(,%ebx,4),%esi
  80073a:	85 f6                	test   %esi,%esi
  80073c:	75 19                	jne    800757 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80073e:	53                   	push   %ebx
  80073f:	68 c5 21 80 00       	push   $0x8021c5
  800744:	ff 75 0c             	pushl  0xc(%ebp)
  800747:	ff 75 08             	pushl  0x8(%ebp)
  80074a:	e8 5e 02 00 00       	call   8009ad <printfmt>
  80074f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800752:	e9 49 02 00 00       	jmp    8009a0 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800757:	56                   	push   %esi
  800758:	68 ce 21 80 00       	push   $0x8021ce
  80075d:	ff 75 0c             	pushl  0xc(%ebp)
  800760:	ff 75 08             	pushl  0x8(%ebp)
  800763:	e8 45 02 00 00       	call   8009ad <printfmt>
  800768:	83 c4 10             	add    $0x10,%esp
			break;
  80076b:	e9 30 02 00 00       	jmp    8009a0 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800770:	8b 45 14             	mov    0x14(%ebp),%eax
  800773:	83 c0 04             	add    $0x4,%eax
  800776:	89 45 14             	mov    %eax,0x14(%ebp)
  800779:	8b 45 14             	mov    0x14(%ebp),%eax
  80077c:	83 e8 04             	sub    $0x4,%eax
  80077f:	8b 30                	mov    (%eax),%esi
  800781:	85 f6                	test   %esi,%esi
  800783:	75 05                	jne    80078a <vprintfmt+0x1a6>
				p = "(null)";
  800785:	be d1 21 80 00       	mov    $0x8021d1,%esi
			if (width > 0 && padc != '-')
  80078a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80078e:	7e 6d                	jle    8007fd <vprintfmt+0x219>
  800790:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800794:	74 67                	je     8007fd <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800796:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800799:	83 ec 08             	sub    $0x8,%esp
  80079c:	50                   	push   %eax
  80079d:	56                   	push   %esi
  80079e:	e8 0c 03 00 00       	call   800aaf <strnlen>
  8007a3:	83 c4 10             	add    $0x10,%esp
  8007a6:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8007a9:	eb 16                	jmp    8007c1 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8007ab:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8007af:	83 ec 08             	sub    $0x8,%esp
  8007b2:	ff 75 0c             	pushl  0xc(%ebp)
  8007b5:	50                   	push   %eax
  8007b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b9:	ff d0                	call   *%eax
  8007bb:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8007be:	ff 4d e4             	decl   -0x1c(%ebp)
  8007c1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007c5:	7f e4                	jg     8007ab <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007c7:	eb 34                	jmp    8007fd <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8007c9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8007cd:	74 1c                	je     8007eb <vprintfmt+0x207>
  8007cf:	83 fb 1f             	cmp    $0x1f,%ebx
  8007d2:	7e 05                	jle    8007d9 <vprintfmt+0x1f5>
  8007d4:	83 fb 7e             	cmp    $0x7e,%ebx
  8007d7:	7e 12                	jle    8007eb <vprintfmt+0x207>
					putch('?', putdat);
  8007d9:	83 ec 08             	sub    $0x8,%esp
  8007dc:	ff 75 0c             	pushl  0xc(%ebp)
  8007df:	6a 3f                	push   $0x3f
  8007e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e4:	ff d0                	call   *%eax
  8007e6:	83 c4 10             	add    $0x10,%esp
  8007e9:	eb 0f                	jmp    8007fa <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8007eb:	83 ec 08             	sub    $0x8,%esp
  8007ee:	ff 75 0c             	pushl  0xc(%ebp)
  8007f1:	53                   	push   %ebx
  8007f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f5:	ff d0                	call   *%eax
  8007f7:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007fa:	ff 4d e4             	decl   -0x1c(%ebp)
  8007fd:	89 f0                	mov    %esi,%eax
  8007ff:	8d 70 01             	lea    0x1(%eax),%esi
  800802:	8a 00                	mov    (%eax),%al
  800804:	0f be d8             	movsbl %al,%ebx
  800807:	85 db                	test   %ebx,%ebx
  800809:	74 24                	je     80082f <vprintfmt+0x24b>
  80080b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80080f:	78 b8                	js     8007c9 <vprintfmt+0x1e5>
  800811:	ff 4d e0             	decl   -0x20(%ebp)
  800814:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800818:	79 af                	jns    8007c9 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80081a:	eb 13                	jmp    80082f <vprintfmt+0x24b>
				putch(' ', putdat);
  80081c:	83 ec 08             	sub    $0x8,%esp
  80081f:	ff 75 0c             	pushl  0xc(%ebp)
  800822:	6a 20                	push   $0x20
  800824:	8b 45 08             	mov    0x8(%ebp),%eax
  800827:	ff d0                	call   *%eax
  800829:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80082c:	ff 4d e4             	decl   -0x1c(%ebp)
  80082f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800833:	7f e7                	jg     80081c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800835:	e9 66 01 00 00       	jmp    8009a0 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80083a:	83 ec 08             	sub    $0x8,%esp
  80083d:	ff 75 e8             	pushl  -0x18(%ebp)
  800840:	8d 45 14             	lea    0x14(%ebp),%eax
  800843:	50                   	push   %eax
  800844:	e8 3c fd ff ff       	call   800585 <getint>
  800849:	83 c4 10             	add    $0x10,%esp
  80084c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80084f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800852:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800855:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800858:	85 d2                	test   %edx,%edx
  80085a:	79 23                	jns    80087f <vprintfmt+0x29b>
				putch('-', putdat);
  80085c:	83 ec 08             	sub    $0x8,%esp
  80085f:	ff 75 0c             	pushl  0xc(%ebp)
  800862:	6a 2d                	push   $0x2d
  800864:	8b 45 08             	mov    0x8(%ebp),%eax
  800867:	ff d0                	call   *%eax
  800869:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80086c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80086f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800872:	f7 d8                	neg    %eax
  800874:	83 d2 00             	adc    $0x0,%edx
  800877:	f7 da                	neg    %edx
  800879:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80087c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80087f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800886:	e9 bc 00 00 00       	jmp    800947 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80088b:	83 ec 08             	sub    $0x8,%esp
  80088e:	ff 75 e8             	pushl  -0x18(%ebp)
  800891:	8d 45 14             	lea    0x14(%ebp),%eax
  800894:	50                   	push   %eax
  800895:	e8 84 fc ff ff       	call   80051e <getuint>
  80089a:	83 c4 10             	add    $0x10,%esp
  80089d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008a0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8008a3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008aa:	e9 98 00 00 00       	jmp    800947 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8008af:	83 ec 08             	sub    $0x8,%esp
  8008b2:	ff 75 0c             	pushl  0xc(%ebp)
  8008b5:	6a 58                	push   $0x58
  8008b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ba:	ff d0                	call   *%eax
  8008bc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008bf:	83 ec 08             	sub    $0x8,%esp
  8008c2:	ff 75 0c             	pushl  0xc(%ebp)
  8008c5:	6a 58                	push   $0x58
  8008c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ca:	ff d0                	call   *%eax
  8008cc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008cf:	83 ec 08             	sub    $0x8,%esp
  8008d2:	ff 75 0c             	pushl  0xc(%ebp)
  8008d5:	6a 58                	push   $0x58
  8008d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008da:	ff d0                	call   *%eax
  8008dc:	83 c4 10             	add    $0x10,%esp
			break;
  8008df:	e9 bc 00 00 00       	jmp    8009a0 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8008e4:	83 ec 08             	sub    $0x8,%esp
  8008e7:	ff 75 0c             	pushl  0xc(%ebp)
  8008ea:	6a 30                	push   $0x30
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	ff d0                	call   *%eax
  8008f1:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8008f4:	83 ec 08             	sub    $0x8,%esp
  8008f7:	ff 75 0c             	pushl  0xc(%ebp)
  8008fa:	6a 78                	push   $0x78
  8008fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ff:	ff d0                	call   *%eax
  800901:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800904:	8b 45 14             	mov    0x14(%ebp),%eax
  800907:	83 c0 04             	add    $0x4,%eax
  80090a:	89 45 14             	mov    %eax,0x14(%ebp)
  80090d:	8b 45 14             	mov    0x14(%ebp),%eax
  800910:	83 e8 04             	sub    $0x4,%eax
  800913:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800915:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800918:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80091f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800926:	eb 1f                	jmp    800947 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800928:	83 ec 08             	sub    $0x8,%esp
  80092b:	ff 75 e8             	pushl  -0x18(%ebp)
  80092e:	8d 45 14             	lea    0x14(%ebp),%eax
  800931:	50                   	push   %eax
  800932:	e8 e7 fb ff ff       	call   80051e <getuint>
  800937:	83 c4 10             	add    $0x10,%esp
  80093a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80093d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800940:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800947:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80094b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80094e:	83 ec 04             	sub    $0x4,%esp
  800951:	52                   	push   %edx
  800952:	ff 75 e4             	pushl  -0x1c(%ebp)
  800955:	50                   	push   %eax
  800956:	ff 75 f4             	pushl  -0xc(%ebp)
  800959:	ff 75 f0             	pushl  -0x10(%ebp)
  80095c:	ff 75 0c             	pushl  0xc(%ebp)
  80095f:	ff 75 08             	pushl  0x8(%ebp)
  800962:	e8 00 fb ff ff       	call   800467 <printnum>
  800967:	83 c4 20             	add    $0x20,%esp
			break;
  80096a:	eb 34                	jmp    8009a0 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80096c:	83 ec 08             	sub    $0x8,%esp
  80096f:	ff 75 0c             	pushl  0xc(%ebp)
  800972:	53                   	push   %ebx
  800973:	8b 45 08             	mov    0x8(%ebp),%eax
  800976:	ff d0                	call   *%eax
  800978:	83 c4 10             	add    $0x10,%esp
			break;
  80097b:	eb 23                	jmp    8009a0 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80097d:	83 ec 08             	sub    $0x8,%esp
  800980:	ff 75 0c             	pushl  0xc(%ebp)
  800983:	6a 25                	push   $0x25
  800985:	8b 45 08             	mov    0x8(%ebp),%eax
  800988:	ff d0                	call   *%eax
  80098a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80098d:	ff 4d 10             	decl   0x10(%ebp)
  800990:	eb 03                	jmp    800995 <vprintfmt+0x3b1>
  800992:	ff 4d 10             	decl   0x10(%ebp)
  800995:	8b 45 10             	mov    0x10(%ebp),%eax
  800998:	48                   	dec    %eax
  800999:	8a 00                	mov    (%eax),%al
  80099b:	3c 25                	cmp    $0x25,%al
  80099d:	75 f3                	jne    800992 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80099f:	90                   	nop
		}
	}
  8009a0:	e9 47 fc ff ff       	jmp    8005ec <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8009a5:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8009a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8009a9:	5b                   	pop    %ebx
  8009aa:	5e                   	pop    %esi
  8009ab:	5d                   	pop    %ebp
  8009ac:	c3                   	ret    

008009ad <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8009ad:	55                   	push   %ebp
  8009ae:	89 e5                	mov    %esp,%ebp
  8009b0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8009b3:	8d 45 10             	lea    0x10(%ebp),%eax
  8009b6:	83 c0 04             	add    $0x4,%eax
  8009b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8009bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8009bf:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c2:	50                   	push   %eax
  8009c3:	ff 75 0c             	pushl  0xc(%ebp)
  8009c6:	ff 75 08             	pushl  0x8(%ebp)
  8009c9:	e8 16 fc ff ff       	call   8005e4 <vprintfmt>
  8009ce:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8009d1:	90                   	nop
  8009d2:	c9                   	leave  
  8009d3:	c3                   	ret    

008009d4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8009d4:	55                   	push   %ebp
  8009d5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8009d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009da:	8b 40 08             	mov    0x8(%eax),%eax
  8009dd:	8d 50 01             	lea    0x1(%eax),%edx
  8009e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e3:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8009e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e9:	8b 10                	mov    (%eax),%edx
  8009eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ee:	8b 40 04             	mov    0x4(%eax),%eax
  8009f1:	39 c2                	cmp    %eax,%edx
  8009f3:	73 12                	jae    800a07 <sprintputch+0x33>
		*b->buf++ = ch;
  8009f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f8:	8b 00                	mov    (%eax),%eax
  8009fa:	8d 48 01             	lea    0x1(%eax),%ecx
  8009fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a00:	89 0a                	mov    %ecx,(%edx)
  800a02:	8b 55 08             	mov    0x8(%ebp),%edx
  800a05:	88 10                	mov    %dl,(%eax)
}
  800a07:	90                   	nop
  800a08:	5d                   	pop    %ebp
  800a09:	c3                   	ret    

00800a0a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a0a:	55                   	push   %ebp
  800a0b:	89 e5                	mov    %esp,%ebp
  800a0d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a10:	8b 45 08             	mov    0x8(%ebp),%eax
  800a13:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a19:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	01 d0                	add    %edx,%eax
  800a21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a24:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a2b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a2f:	74 06                	je     800a37 <vsnprintf+0x2d>
  800a31:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a35:	7f 07                	jg     800a3e <vsnprintf+0x34>
		return -E_INVAL;
  800a37:	b8 03 00 00 00       	mov    $0x3,%eax
  800a3c:	eb 20                	jmp    800a5e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a3e:	ff 75 14             	pushl  0x14(%ebp)
  800a41:	ff 75 10             	pushl  0x10(%ebp)
  800a44:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a47:	50                   	push   %eax
  800a48:	68 d4 09 80 00       	push   $0x8009d4
  800a4d:	e8 92 fb ff ff       	call   8005e4 <vprintfmt>
  800a52:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a55:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a58:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a5e:	c9                   	leave  
  800a5f:	c3                   	ret    

00800a60 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a60:	55                   	push   %ebp
  800a61:	89 e5                	mov    %esp,%ebp
  800a63:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a66:	8d 45 10             	lea    0x10(%ebp),%eax
  800a69:	83 c0 04             	add    $0x4,%eax
  800a6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800a6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800a72:	ff 75 f4             	pushl  -0xc(%ebp)
  800a75:	50                   	push   %eax
  800a76:	ff 75 0c             	pushl  0xc(%ebp)
  800a79:	ff 75 08             	pushl  0x8(%ebp)
  800a7c:	e8 89 ff ff ff       	call   800a0a <vsnprintf>
  800a81:	83 c4 10             	add    $0x10,%esp
  800a84:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a87:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a8a:	c9                   	leave  
  800a8b:	c3                   	ret    

00800a8c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800a8c:	55                   	push   %ebp
  800a8d:	89 e5                	mov    %esp,%ebp
  800a8f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a92:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a99:	eb 06                	jmp    800aa1 <strlen+0x15>
		n++;
  800a9b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a9e:	ff 45 08             	incl   0x8(%ebp)
  800aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa4:	8a 00                	mov    (%eax),%al
  800aa6:	84 c0                	test   %al,%al
  800aa8:	75 f1                	jne    800a9b <strlen+0xf>
		n++;
	return n;
  800aaa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800aad:	c9                   	leave  
  800aae:	c3                   	ret    

00800aaf <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800aaf:	55                   	push   %ebp
  800ab0:	89 e5                	mov    %esp,%ebp
  800ab2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ab5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800abc:	eb 09                	jmp    800ac7 <strnlen+0x18>
		n++;
  800abe:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ac1:	ff 45 08             	incl   0x8(%ebp)
  800ac4:	ff 4d 0c             	decl   0xc(%ebp)
  800ac7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800acb:	74 09                	je     800ad6 <strnlen+0x27>
  800acd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad0:	8a 00                	mov    (%eax),%al
  800ad2:	84 c0                	test   %al,%al
  800ad4:	75 e8                	jne    800abe <strnlen+0xf>
		n++;
	return n;
  800ad6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ad9:	c9                   	leave  
  800ada:	c3                   	ret    

00800adb <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800adb:	55                   	push   %ebp
  800adc:	89 e5                	mov    %esp,%ebp
  800ade:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ae7:	90                   	nop
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	8d 50 01             	lea    0x1(%eax),%edx
  800aee:	89 55 08             	mov    %edx,0x8(%ebp)
  800af1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800af7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800afa:	8a 12                	mov    (%edx),%dl
  800afc:	88 10                	mov    %dl,(%eax)
  800afe:	8a 00                	mov    (%eax),%al
  800b00:	84 c0                	test   %al,%al
  800b02:	75 e4                	jne    800ae8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b04:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b07:	c9                   	leave  
  800b08:	c3                   	ret    

00800b09 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b09:	55                   	push   %ebp
  800b0a:	89 e5                	mov    %esp,%ebp
  800b0c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b15:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b1c:	eb 1f                	jmp    800b3d <strncpy+0x34>
		*dst++ = *src;
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	8d 50 01             	lea    0x1(%eax),%edx
  800b24:	89 55 08             	mov    %edx,0x8(%ebp)
  800b27:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b2a:	8a 12                	mov    (%edx),%dl
  800b2c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b31:	8a 00                	mov    (%eax),%al
  800b33:	84 c0                	test   %al,%al
  800b35:	74 03                	je     800b3a <strncpy+0x31>
			src++;
  800b37:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b3a:	ff 45 fc             	incl   -0x4(%ebp)
  800b3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b40:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b43:	72 d9                	jb     800b1e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b45:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b48:	c9                   	leave  
  800b49:	c3                   	ret    

00800b4a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b4a:	55                   	push   %ebp
  800b4b:	89 e5                	mov    %esp,%ebp
  800b4d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800b50:	8b 45 08             	mov    0x8(%ebp),%eax
  800b53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800b56:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b5a:	74 30                	je     800b8c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800b5c:	eb 16                	jmp    800b74 <strlcpy+0x2a>
			*dst++ = *src++;
  800b5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b61:	8d 50 01             	lea    0x1(%eax),%edx
  800b64:	89 55 08             	mov    %edx,0x8(%ebp)
  800b67:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b6a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b6d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b70:	8a 12                	mov    (%edx),%dl
  800b72:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800b74:	ff 4d 10             	decl   0x10(%ebp)
  800b77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b7b:	74 09                	je     800b86 <strlcpy+0x3c>
  800b7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b80:	8a 00                	mov    (%eax),%al
  800b82:	84 c0                	test   %al,%al
  800b84:	75 d8                	jne    800b5e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
  800b89:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800b8c:	8b 55 08             	mov    0x8(%ebp),%edx
  800b8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b92:	29 c2                	sub    %eax,%edx
  800b94:	89 d0                	mov    %edx,%eax
}
  800b96:	c9                   	leave  
  800b97:	c3                   	ret    

00800b98 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b98:	55                   	push   %ebp
  800b99:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b9b:	eb 06                	jmp    800ba3 <strcmp+0xb>
		p++, q++;
  800b9d:	ff 45 08             	incl   0x8(%ebp)
  800ba0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	8a 00                	mov    (%eax),%al
  800ba8:	84 c0                	test   %al,%al
  800baa:	74 0e                	je     800bba <strcmp+0x22>
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	8a 10                	mov    (%eax),%dl
  800bb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb4:	8a 00                	mov    (%eax),%al
  800bb6:	38 c2                	cmp    %al,%dl
  800bb8:	74 e3                	je     800b9d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800bba:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbd:	8a 00                	mov    (%eax),%al
  800bbf:	0f b6 d0             	movzbl %al,%edx
  800bc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc5:	8a 00                	mov    (%eax),%al
  800bc7:	0f b6 c0             	movzbl %al,%eax
  800bca:	29 c2                	sub    %eax,%edx
  800bcc:	89 d0                	mov    %edx,%eax
}
  800bce:	5d                   	pop    %ebp
  800bcf:	c3                   	ret    

00800bd0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800bd0:	55                   	push   %ebp
  800bd1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800bd3:	eb 09                	jmp    800bde <strncmp+0xe>
		n--, p++, q++;
  800bd5:	ff 4d 10             	decl   0x10(%ebp)
  800bd8:	ff 45 08             	incl   0x8(%ebp)
  800bdb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800bde:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800be2:	74 17                	je     800bfb <strncmp+0x2b>
  800be4:	8b 45 08             	mov    0x8(%ebp),%eax
  800be7:	8a 00                	mov    (%eax),%al
  800be9:	84 c0                	test   %al,%al
  800beb:	74 0e                	je     800bfb <strncmp+0x2b>
  800bed:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf0:	8a 10                	mov    (%eax),%dl
  800bf2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf5:	8a 00                	mov    (%eax),%al
  800bf7:	38 c2                	cmp    %al,%dl
  800bf9:	74 da                	je     800bd5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800bfb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bff:	75 07                	jne    800c08 <strncmp+0x38>
		return 0;
  800c01:	b8 00 00 00 00       	mov    $0x0,%eax
  800c06:	eb 14                	jmp    800c1c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c08:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0b:	8a 00                	mov    (%eax),%al
  800c0d:	0f b6 d0             	movzbl %al,%edx
  800c10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c13:	8a 00                	mov    (%eax),%al
  800c15:	0f b6 c0             	movzbl %al,%eax
  800c18:	29 c2                	sub    %eax,%edx
  800c1a:	89 d0                	mov    %edx,%eax
}
  800c1c:	5d                   	pop    %ebp
  800c1d:	c3                   	ret    

00800c1e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c1e:	55                   	push   %ebp
  800c1f:	89 e5                	mov    %esp,%ebp
  800c21:	83 ec 04             	sub    $0x4,%esp
  800c24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c27:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c2a:	eb 12                	jmp    800c3e <strchr+0x20>
		if (*s == c)
  800c2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2f:	8a 00                	mov    (%eax),%al
  800c31:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c34:	75 05                	jne    800c3b <strchr+0x1d>
			return (char *) s;
  800c36:	8b 45 08             	mov    0x8(%ebp),%eax
  800c39:	eb 11                	jmp    800c4c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c3b:	ff 45 08             	incl   0x8(%ebp)
  800c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c41:	8a 00                	mov    (%eax),%al
  800c43:	84 c0                	test   %al,%al
  800c45:	75 e5                	jne    800c2c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c47:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c4c:	c9                   	leave  
  800c4d:	c3                   	ret    

00800c4e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800c4e:	55                   	push   %ebp
  800c4f:	89 e5                	mov    %esp,%ebp
  800c51:	83 ec 04             	sub    $0x4,%esp
  800c54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c57:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c5a:	eb 0d                	jmp    800c69 <strfind+0x1b>
		if (*s == c)
  800c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5f:	8a 00                	mov    (%eax),%al
  800c61:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c64:	74 0e                	je     800c74 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c66:	ff 45 08             	incl   0x8(%ebp)
  800c69:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6c:	8a 00                	mov    (%eax),%al
  800c6e:	84 c0                	test   %al,%al
  800c70:	75 ea                	jne    800c5c <strfind+0xe>
  800c72:	eb 01                	jmp    800c75 <strfind+0x27>
		if (*s == c)
			break;
  800c74:	90                   	nop
	return (char *) s;
  800c75:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c78:	c9                   	leave  
  800c79:	c3                   	ret    

00800c7a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800c7a:	55                   	push   %ebp
  800c7b:	89 e5                	mov    %esp,%ebp
  800c7d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800c86:	8b 45 10             	mov    0x10(%ebp),%eax
  800c89:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800c8c:	eb 0e                	jmp    800c9c <memset+0x22>
		*p++ = c;
  800c8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c91:	8d 50 01             	lea    0x1(%eax),%edx
  800c94:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800c97:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c9a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800c9c:	ff 4d f8             	decl   -0x8(%ebp)
  800c9f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ca3:	79 e9                	jns    800c8e <memset+0x14>
		*p++ = c;

	return v;
  800ca5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ca8:	c9                   	leave  
  800ca9:	c3                   	ret    

00800caa <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800caa:	55                   	push   %ebp
  800cab:	89 e5                	mov    %esp,%ebp
  800cad:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800cb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800cbc:	eb 16                	jmp    800cd4 <memcpy+0x2a>
		*d++ = *s++;
  800cbe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cc1:	8d 50 01             	lea    0x1(%eax),%edx
  800cc4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800cc7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800cca:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ccd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800cd0:	8a 12                	mov    (%edx),%dl
  800cd2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800cd4:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cda:	89 55 10             	mov    %edx,0x10(%ebp)
  800cdd:	85 c0                	test   %eax,%eax
  800cdf:	75 dd                	jne    800cbe <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ce1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ce4:	c9                   	leave  
  800ce5:	c3                   	ret    

00800ce6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ce6:	55                   	push   %ebp
  800ce7:	89 e5                	mov    %esp,%ebp
  800ce9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800cec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800cf8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cfb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800cfe:	73 50                	jae    800d50 <memmove+0x6a>
  800d00:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d03:	8b 45 10             	mov    0x10(%ebp),%eax
  800d06:	01 d0                	add    %edx,%eax
  800d08:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d0b:	76 43                	jbe    800d50 <memmove+0x6a>
		s += n;
  800d0d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d10:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800d13:	8b 45 10             	mov    0x10(%ebp),%eax
  800d16:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d19:	eb 10                	jmp    800d2b <memmove+0x45>
			*--d = *--s;
  800d1b:	ff 4d f8             	decl   -0x8(%ebp)
  800d1e:	ff 4d fc             	decl   -0x4(%ebp)
  800d21:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d24:	8a 10                	mov    (%eax),%dl
  800d26:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d29:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800d2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d2e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d31:	89 55 10             	mov    %edx,0x10(%ebp)
  800d34:	85 c0                	test   %eax,%eax
  800d36:	75 e3                	jne    800d1b <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800d38:	eb 23                	jmp    800d5d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800d3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d3d:	8d 50 01             	lea    0x1(%eax),%edx
  800d40:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d43:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d46:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d49:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d4c:	8a 12                	mov    (%edx),%dl
  800d4e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800d50:	8b 45 10             	mov    0x10(%ebp),%eax
  800d53:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d56:	89 55 10             	mov    %edx,0x10(%ebp)
  800d59:	85 c0                	test   %eax,%eax
  800d5b:	75 dd                	jne    800d3a <memmove+0x54>
			*d++ = *s++;

	return dst;
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d60:	c9                   	leave  
  800d61:	c3                   	ret    

00800d62 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800d62:	55                   	push   %ebp
  800d63:	89 e5                	mov    %esp,%ebp
  800d65:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800d6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d71:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800d74:	eb 2a                	jmp    800da0 <memcmp+0x3e>
		if (*s1 != *s2)
  800d76:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d79:	8a 10                	mov    (%eax),%dl
  800d7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d7e:	8a 00                	mov    (%eax),%al
  800d80:	38 c2                	cmp    %al,%dl
  800d82:	74 16                	je     800d9a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800d84:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d87:	8a 00                	mov    (%eax),%al
  800d89:	0f b6 d0             	movzbl %al,%edx
  800d8c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d8f:	8a 00                	mov    (%eax),%al
  800d91:	0f b6 c0             	movzbl %al,%eax
  800d94:	29 c2                	sub    %eax,%edx
  800d96:	89 d0                	mov    %edx,%eax
  800d98:	eb 18                	jmp    800db2 <memcmp+0x50>
		s1++, s2++;
  800d9a:	ff 45 fc             	incl   -0x4(%ebp)
  800d9d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800da0:	8b 45 10             	mov    0x10(%ebp),%eax
  800da3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800da6:	89 55 10             	mov    %edx,0x10(%ebp)
  800da9:	85 c0                	test   %eax,%eax
  800dab:	75 c9                	jne    800d76 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800dad:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800db2:	c9                   	leave  
  800db3:	c3                   	ret    

00800db4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800db4:	55                   	push   %ebp
  800db5:	89 e5                	mov    %esp,%ebp
  800db7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800dba:	8b 55 08             	mov    0x8(%ebp),%edx
  800dbd:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc0:	01 d0                	add    %edx,%eax
  800dc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800dc5:	eb 15                	jmp    800ddc <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	8a 00                	mov    (%eax),%al
  800dcc:	0f b6 d0             	movzbl %al,%edx
  800dcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd2:	0f b6 c0             	movzbl %al,%eax
  800dd5:	39 c2                	cmp    %eax,%edx
  800dd7:	74 0d                	je     800de6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800dd9:	ff 45 08             	incl   0x8(%ebp)
  800ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800de2:	72 e3                	jb     800dc7 <memfind+0x13>
  800de4:	eb 01                	jmp    800de7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800de6:	90                   	nop
	return (void *) s;
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dea:	c9                   	leave  
  800deb:	c3                   	ret    

00800dec <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800dec:	55                   	push   %ebp
  800ded:	89 e5                	mov    %esp,%ebp
  800def:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800df2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800df9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e00:	eb 03                	jmp    800e05 <strtol+0x19>
		s++;
  800e02:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
  800e08:	8a 00                	mov    (%eax),%al
  800e0a:	3c 20                	cmp    $0x20,%al
  800e0c:	74 f4                	je     800e02 <strtol+0x16>
  800e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e11:	8a 00                	mov    (%eax),%al
  800e13:	3c 09                	cmp    $0x9,%al
  800e15:	74 eb                	je     800e02 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800e17:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1a:	8a 00                	mov    (%eax),%al
  800e1c:	3c 2b                	cmp    $0x2b,%al
  800e1e:	75 05                	jne    800e25 <strtol+0x39>
		s++;
  800e20:	ff 45 08             	incl   0x8(%ebp)
  800e23:	eb 13                	jmp    800e38 <strtol+0x4c>
	else if (*s == '-')
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	8a 00                	mov    (%eax),%al
  800e2a:	3c 2d                	cmp    $0x2d,%al
  800e2c:	75 0a                	jne    800e38 <strtol+0x4c>
		s++, neg = 1;
  800e2e:	ff 45 08             	incl   0x8(%ebp)
  800e31:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800e38:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e3c:	74 06                	je     800e44 <strtol+0x58>
  800e3e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800e42:	75 20                	jne    800e64 <strtol+0x78>
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	8a 00                	mov    (%eax),%al
  800e49:	3c 30                	cmp    $0x30,%al
  800e4b:	75 17                	jne    800e64 <strtol+0x78>
  800e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e50:	40                   	inc    %eax
  800e51:	8a 00                	mov    (%eax),%al
  800e53:	3c 78                	cmp    $0x78,%al
  800e55:	75 0d                	jne    800e64 <strtol+0x78>
		s += 2, base = 16;
  800e57:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800e5b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800e62:	eb 28                	jmp    800e8c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800e64:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e68:	75 15                	jne    800e7f <strtol+0x93>
  800e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6d:	8a 00                	mov    (%eax),%al
  800e6f:	3c 30                	cmp    $0x30,%al
  800e71:	75 0c                	jne    800e7f <strtol+0x93>
		s++, base = 8;
  800e73:	ff 45 08             	incl   0x8(%ebp)
  800e76:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800e7d:	eb 0d                	jmp    800e8c <strtol+0xa0>
	else if (base == 0)
  800e7f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e83:	75 07                	jne    800e8c <strtol+0xa0>
		base = 10;
  800e85:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8f:	8a 00                	mov    (%eax),%al
  800e91:	3c 2f                	cmp    $0x2f,%al
  800e93:	7e 19                	jle    800eae <strtol+0xc2>
  800e95:	8b 45 08             	mov    0x8(%ebp),%eax
  800e98:	8a 00                	mov    (%eax),%al
  800e9a:	3c 39                	cmp    $0x39,%al
  800e9c:	7f 10                	jg     800eae <strtol+0xc2>
			dig = *s - '0';
  800e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea1:	8a 00                	mov    (%eax),%al
  800ea3:	0f be c0             	movsbl %al,%eax
  800ea6:	83 e8 30             	sub    $0x30,%eax
  800ea9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800eac:	eb 42                	jmp    800ef0 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	8a 00                	mov    (%eax),%al
  800eb3:	3c 60                	cmp    $0x60,%al
  800eb5:	7e 19                	jle    800ed0 <strtol+0xe4>
  800eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eba:	8a 00                	mov    (%eax),%al
  800ebc:	3c 7a                	cmp    $0x7a,%al
  800ebe:	7f 10                	jg     800ed0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	8a 00                	mov    (%eax),%al
  800ec5:	0f be c0             	movsbl %al,%eax
  800ec8:	83 e8 57             	sub    $0x57,%eax
  800ecb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ece:	eb 20                	jmp    800ef0 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed3:	8a 00                	mov    (%eax),%al
  800ed5:	3c 40                	cmp    $0x40,%al
  800ed7:	7e 39                	jle    800f12 <strtol+0x126>
  800ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  800edc:	8a 00                	mov    (%eax),%al
  800ede:	3c 5a                	cmp    $0x5a,%al
  800ee0:	7f 30                	jg     800f12 <strtol+0x126>
			dig = *s - 'A' + 10;
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	8a 00                	mov    (%eax),%al
  800ee7:	0f be c0             	movsbl %al,%eax
  800eea:	83 e8 37             	sub    $0x37,%eax
  800eed:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800ef0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ef3:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ef6:	7d 19                	jge    800f11 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800ef8:	ff 45 08             	incl   0x8(%ebp)
  800efb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800efe:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f02:	89 c2                	mov    %eax,%edx
  800f04:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f07:	01 d0                	add    %edx,%eax
  800f09:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800f0c:	e9 7b ff ff ff       	jmp    800e8c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800f11:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800f12:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f16:	74 08                	je     800f20 <strtol+0x134>
		*endptr = (char *) s;
  800f18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1b:	8b 55 08             	mov    0x8(%ebp),%edx
  800f1e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800f20:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f24:	74 07                	je     800f2d <strtol+0x141>
  800f26:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f29:	f7 d8                	neg    %eax
  800f2b:	eb 03                	jmp    800f30 <strtol+0x144>
  800f2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f30:	c9                   	leave  
  800f31:	c3                   	ret    

00800f32 <ltostr>:

void
ltostr(long value, char *str)
{
  800f32:	55                   	push   %ebp
  800f33:	89 e5                	mov    %esp,%ebp
  800f35:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800f38:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800f3f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800f46:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f4a:	79 13                	jns    800f5f <ltostr+0x2d>
	{
		neg = 1;
  800f4c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800f53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f56:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800f59:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800f5c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800f67:	99                   	cltd   
  800f68:	f7 f9                	idiv   %ecx
  800f6a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800f6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f70:	8d 50 01             	lea    0x1(%eax),%edx
  800f73:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f76:	89 c2                	mov    %eax,%edx
  800f78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7b:	01 d0                	add    %edx,%eax
  800f7d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800f80:	83 c2 30             	add    $0x30,%edx
  800f83:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800f85:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f88:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f8d:	f7 e9                	imul   %ecx
  800f8f:	c1 fa 02             	sar    $0x2,%edx
  800f92:	89 c8                	mov    %ecx,%eax
  800f94:	c1 f8 1f             	sar    $0x1f,%eax
  800f97:	29 c2                	sub    %eax,%edx
  800f99:	89 d0                	mov    %edx,%eax
  800f9b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800f9e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800fa1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800fa6:	f7 e9                	imul   %ecx
  800fa8:	c1 fa 02             	sar    $0x2,%edx
  800fab:	89 c8                	mov    %ecx,%eax
  800fad:	c1 f8 1f             	sar    $0x1f,%eax
  800fb0:	29 c2                	sub    %eax,%edx
  800fb2:	89 d0                	mov    %edx,%eax
  800fb4:	c1 e0 02             	shl    $0x2,%eax
  800fb7:	01 d0                	add    %edx,%eax
  800fb9:	01 c0                	add    %eax,%eax
  800fbb:	29 c1                	sub    %eax,%ecx
  800fbd:	89 ca                	mov    %ecx,%edx
  800fbf:	85 d2                	test   %edx,%edx
  800fc1:	75 9c                	jne    800f5f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800fc3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800fca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fcd:	48                   	dec    %eax
  800fce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800fd1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fd5:	74 3d                	je     801014 <ltostr+0xe2>
		start = 1 ;
  800fd7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800fde:	eb 34                	jmp    801014 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800fe0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe6:	01 d0                	add    %edx,%eax
  800fe8:	8a 00                	mov    (%eax),%al
  800fea:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800fed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff3:	01 c2                	add    %eax,%edx
  800ff5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800ff8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffb:	01 c8                	add    %ecx,%eax
  800ffd:	8a 00                	mov    (%eax),%al
  800fff:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801001:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801004:	8b 45 0c             	mov    0xc(%ebp),%eax
  801007:	01 c2                	add    %eax,%edx
  801009:	8a 45 eb             	mov    -0x15(%ebp),%al
  80100c:	88 02                	mov    %al,(%edx)
		start++ ;
  80100e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801011:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801014:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801017:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80101a:	7c c4                	jl     800fe0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80101c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80101f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801022:	01 d0                	add    %edx,%eax
  801024:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801027:	90                   	nop
  801028:	c9                   	leave  
  801029:	c3                   	ret    

0080102a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80102a:	55                   	push   %ebp
  80102b:	89 e5                	mov    %esp,%ebp
  80102d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801030:	ff 75 08             	pushl  0x8(%ebp)
  801033:	e8 54 fa ff ff       	call   800a8c <strlen>
  801038:	83 c4 04             	add    $0x4,%esp
  80103b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80103e:	ff 75 0c             	pushl  0xc(%ebp)
  801041:	e8 46 fa ff ff       	call   800a8c <strlen>
  801046:	83 c4 04             	add    $0x4,%esp
  801049:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80104c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801053:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80105a:	eb 17                	jmp    801073 <strcconcat+0x49>
		final[s] = str1[s] ;
  80105c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80105f:	8b 45 10             	mov    0x10(%ebp),%eax
  801062:	01 c2                	add    %eax,%edx
  801064:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801067:	8b 45 08             	mov    0x8(%ebp),%eax
  80106a:	01 c8                	add    %ecx,%eax
  80106c:	8a 00                	mov    (%eax),%al
  80106e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801070:	ff 45 fc             	incl   -0x4(%ebp)
  801073:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801076:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801079:	7c e1                	jl     80105c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80107b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801082:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801089:	eb 1f                	jmp    8010aa <strcconcat+0x80>
		final[s++] = str2[i] ;
  80108b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80108e:	8d 50 01             	lea    0x1(%eax),%edx
  801091:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801094:	89 c2                	mov    %eax,%edx
  801096:	8b 45 10             	mov    0x10(%ebp),%eax
  801099:	01 c2                	add    %eax,%edx
  80109b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80109e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a1:	01 c8                	add    %ecx,%eax
  8010a3:	8a 00                	mov    (%eax),%al
  8010a5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8010a7:	ff 45 f8             	incl   -0x8(%ebp)
  8010aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010b0:	7c d9                	jl     80108b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8010b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b8:	01 d0                	add    %edx,%eax
  8010ba:	c6 00 00             	movb   $0x0,(%eax)
}
  8010bd:	90                   	nop
  8010be:	c9                   	leave  
  8010bf:	c3                   	ret    

008010c0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8010c0:	55                   	push   %ebp
  8010c1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8010c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8010c6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8010cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8010cf:	8b 00                	mov    (%eax),%eax
  8010d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8010db:	01 d0                	add    %edx,%eax
  8010dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8010e3:	eb 0c                	jmp    8010f1 <strsplit+0x31>
			*string++ = 0;
  8010e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e8:	8d 50 01             	lea    0x1(%eax),%edx
  8010eb:	89 55 08             	mov    %edx,0x8(%ebp)
  8010ee:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8010f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f4:	8a 00                	mov    (%eax),%al
  8010f6:	84 c0                	test   %al,%al
  8010f8:	74 18                	je     801112 <strsplit+0x52>
  8010fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fd:	8a 00                	mov    (%eax),%al
  8010ff:	0f be c0             	movsbl %al,%eax
  801102:	50                   	push   %eax
  801103:	ff 75 0c             	pushl  0xc(%ebp)
  801106:	e8 13 fb ff ff       	call   800c1e <strchr>
  80110b:	83 c4 08             	add    $0x8,%esp
  80110e:	85 c0                	test   %eax,%eax
  801110:	75 d3                	jne    8010e5 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801112:	8b 45 08             	mov    0x8(%ebp),%eax
  801115:	8a 00                	mov    (%eax),%al
  801117:	84 c0                	test   %al,%al
  801119:	74 5a                	je     801175 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80111b:	8b 45 14             	mov    0x14(%ebp),%eax
  80111e:	8b 00                	mov    (%eax),%eax
  801120:	83 f8 0f             	cmp    $0xf,%eax
  801123:	75 07                	jne    80112c <strsplit+0x6c>
		{
			return 0;
  801125:	b8 00 00 00 00       	mov    $0x0,%eax
  80112a:	eb 66                	jmp    801192 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80112c:	8b 45 14             	mov    0x14(%ebp),%eax
  80112f:	8b 00                	mov    (%eax),%eax
  801131:	8d 48 01             	lea    0x1(%eax),%ecx
  801134:	8b 55 14             	mov    0x14(%ebp),%edx
  801137:	89 0a                	mov    %ecx,(%edx)
  801139:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801140:	8b 45 10             	mov    0x10(%ebp),%eax
  801143:	01 c2                	add    %eax,%edx
  801145:	8b 45 08             	mov    0x8(%ebp),%eax
  801148:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80114a:	eb 03                	jmp    80114f <strsplit+0x8f>
			string++;
  80114c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80114f:	8b 45 08             	mov    0x8(%ebp),%eax
  801152:	8a 00                	mov    (%eax),%al
  801154:	84 c0                	test   %al,%al
  801156:	74 8b                	je     8010e3 <strsplit+0x23>
  801158:	8b 45 08             	mov    0x8(%ebp),%eax
  80115b:	8a 00                	mov    (%eax),%al
  80115d:	0f be c0             	movsbl %al,%eax
  801160:	50                   	push   %eax
  801161:	ff 75 0c             	pushl  0xc(%ebp)
  801164:	e8 b5 fa ff ff       	call   800c1e <strchr>
  801169:	83 c4 08             	add    $0x8,%esp
  80116c:	85 c0                	test   %eax,%eax
  80116e:	74 dc                	je     80114c <strsplit+0x8c>
			string++;
	}
  801170:	e9 6e ff ff ff       	jmp    8010e3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801175:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801176:	8b 45 14             	mov    0x14(%ebp),%eax
  801179:	8b 00                	mov    (%eax),%eax
  80117b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801182:	8b 45 10             	mov    0x10(%ebp),%eax
  801185:	01 d0                	add    %edx,%eax
  801187:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80118d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801192:	c9                   	leave  
  801193:	c3                   	ret    

00801194 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801194:	55                   	push   %ebp
  801195:	89 e5                	mov    %esp,%ebp
  801197:	83 ec 18             	sub    $0x18,%esp
  80119a:	8b 45 10             	mov    0x10(%ebp),%eax
  80119d:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8011a0:	83 ec 04             	sub    $0x4,%esp
  8011a3:	68 30 23 80 00       	push   $0x802330
  8011a8:	6a 17                	push   $0x17
  8011aa:	68 4f 23 80 00       	push   $0x80234f
  8011af:	e8 8a 08 00 00       	call   801a3e <_panic>

008011b4 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8011b4:	55                   	push   %ebp
  8011b5:	89 e5                	mov    %esp,%ebp
  8011b7:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8011ba:	83 ec 04             	sub    $0x4,%esp
  8011bd:	68 5b 23 80 00       	push   $0x80235b
  8011c2:	6a 2f                	push   $0x2f
  8011c4:	68 4f 23 80 00       	push   $0x80234f
  8011c9:	e8 70 08 00 00       	call   801a3e <_panic>

008011ce <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8011ce:	55                   	push   %ebp
  8011cf:	89 e5                	mov    %esp,%ebp
  8011d1:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8011d4:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8011db:	8b 55 08             	mov    0x8(%ebp),%edx
  8011de:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011e1:	01 d0                	add    %edx,%eax
  8011e3:	48                   	dec    %eax
  8011e4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8011e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8011ea:	ba 00 00 00 00       	mov    $0x0,%edx
  8011ef:	f7 75 ec             	divl   -0x14(%ebp)
  8011f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8011f5:	29 d0                	sub    %edx,%eax
  8011f7:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	c1 e8 0c             	shr    $0xc,%eax
  801200:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801203:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80120a:	e9 c8 00 00 00       	jmp    8012d7 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  80120f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801216:	eb 27                	jmp    80123f <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801218:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80121b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80121e:	01 c2                	add    %eax,%edx
  801220:	89 d0                	mov    %edx,%eax
  801222:	01 c0                	add    %eax,%eax
  801224:	01 d0                	add    %edx,%eax
  801226:	c1 e0 02             	shl    $0x2,%eax
  801229:	05 48 30 80 00       	add    $0x803048,%eax
  80122e:	8b 00                	mov    (%eax),%eax
  801230:	85 c0                	test   %eax,%eax
  801232:	74 08                	je     80123c <malloc+0x6e>
            	i += j;
  801234:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801237:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  80123a:	eb 0b                	jmp    801247 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  80123c:	ff 45 f0             	incl   -0x10(%ebp)
  80123f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801242:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801245:	72 d1                	jb     801218 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801247:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80124a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80124d:	0f 85 81 00 00 00    	jne    8012d4 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801253:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801256:	05 00 00 08 00       	add    $0x80000,%eax
  80125b:	c1 e0 0c             	shl    $0xc,%eax
  80125e:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801261:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801268:	eb 1f                	jmp    801289 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  80126a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80126d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801270:	01 c2                	add    %eax,%edx
  801272:	89 d0                	mov    %edx,%eax
  801274:	01 c0                	add    %eax,%eax
  801276:	01 d0                	add    %edx,%eax
  801278:	c1 e0 02             	shl    $0x2,%eax
  80127b:	05 48 30 80 00       	add    $0x803048,%eax
  801280:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801286:	ff 45 f0             	incl   -0x10(%ebp)
  801289:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80128c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80128f:	72 d9                	jb     80126a <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801291:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801294:	89 d0                	mov    %edx,%eax
  801296:	01 c0                	add    %eax,%eax
  801298:	01 d0                	add    %edx,%eax
  80129a:	c1 e0 02             	shl    $0x2,%eax
  80129d:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  8012a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8012a6:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8012a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8012ab:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8012ae:	89 c8                	mov    %ecx,%eax
  8012b0:	01 c0                	add    %eax,%eax
  8012b2:	01 c8                	add    %ecx,%eax
  8012b4:	c1 e0 02             	shl    $0x2,%eax
  8012b7:	05 44 30 80 00       	add    $0x803044,%eax
  8012bc:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8012be:	83 ec 08             	sub    $0x8,%esp
  8012c1:	ff 75 08             	pushl  0x8(%ebp)
  8012c4:	ff 75 e0             	pushl  -0x20(%ebp)
  8012c7:	e8 2b 03 00 00       	call   8015f7 <sys_allocateMem>
  8012cc:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8012cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8012d2:	eb 19                	jmp    8012ed <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8012d4:	ff 45 f4             	incl   -0xc(%ebp)
  8012d7:	a1 04 30 80 00       	mov    0x803004,%eax
  8012dc:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8012df:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012e2:	0f 83 27 ff ff ff    	jae    80120f <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8012e8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012ed:	c9                   	leave  
  8012ee:	c3                   	ret    

008012ef <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8012ef:	55                   	push   %ebp
  8012f0:	89 e5                	mov    %esp,%ebp
  8012f2:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8012f5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012f9:	0f 84 e5 00 00 00    	je     8013e4 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8012ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801302:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801305:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801308:	05 00 00 00 80       	add    $0x80000000,%eax
  80130d:	c1 e8 0c             	shr    $0xc,%eax
  801310:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801313:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801316:	89 d0                	mov    %edx,%eax
  801318:	01 c0                	add    %eax,%eax
  80131a:	01 d0                	add    %edx,%eax
  80131c:	c1 e0 02             	shl    $0x2,%eax
  80131f:	05 40 30 80 00       	add    $0x803040,%eax
  801324:	8b 00                	mov    (%eax),%eax
  801326:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801329:	0f 85 b8 00 00 00    	jne    8013e7 <free+0xf8>
  80132f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801332:	89 d0                	mov    %edx,%eax
  801334:	01 c0                	add    %eax,%eax
  801336:	01 d0                	add    %edx,%eax
  801338:	c1 e0 02             	shl    $0x2,%eax
  80133b:	05 48 30 80 00       	add    $0x803048,%eax
  801340:	8b 00                	mov    (%eax),%eax
  801342:	85 c0                	test   %eax,%eax
  801344:	0f 84 9d 00 00 00    	je     8013e7 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  80134a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80134d:	89 d0                	mov    %edx,%eax
  80134f:	01 c0                	add    %eax,%eax
  801351:	01 d0                	add    %edx,%eax
  801353:	c1 e0 02             	shl    $0x2,%eax
  801356:	05 44 30 80 00       	add    $0x803044,%eax
  80135b:	8b 00                	mov    (%eax),%eax
  80135d:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801360:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801363:	c1 e0 0c             	shl    $0xc,%eax
  801366:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801369:	83 ec 08             	sub    $0x8,%esp
  80136c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80136f:	ff 75 f0             	pushl  -0x10(%ebp)
  801372:	e8 64 02 00 00       	call   8015db <sys_freeMem>
  801377:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80137a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801381:	eb 57                	jmp    8013da <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801383:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801386:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801389:	01 c2                	add    %eax,%edx
  80138b:	89 d0                	mov    %edx,%eax
  80138d:	01 c0                	add    %eax,%eax
  80138f:	01 d0                	add    %edx,%eax
  801391:	c1 e0 02             	shl    $0x2,%eax
  801394:	05 48 30 80 00       	add    $0x803048,%eax
  801399:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  80139f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013a5:	01 c2                	add    %eax,%edx
  8013a7:	89 d0                	mov    %edx,%eax
  8013a9:	01 c0                	add    %eax,%eax
  8013ab:	01 d0                	add    %edx,%eax
  8013ad:	c1 e0 02             	shl    $0x2,%eax
  8013b0:	05 40 30 80 00       	add    $0x803040,%eax
  8013b5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8013bb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013c1:	01 c2                	add    %eax,%edx
  8013c3:	89 d0                	mov    %edx,%eax
  8013c5:	01 c0                	add    %eax,%eax
  8013c7:	01 d0                	add    %edx,%eax
  8013c9:	c1 e0 02             	shl    $0x2,%eax
  8013cc:	05 44 30 80 00       	add    $0x803044,%eax
  8013d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8013d7:	ff 45 f4             	incl   -0xc(%ebp)
  8013da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013dd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8013e0:	7c a1                	jl     801383 <free+0x94>
  8013e2:	eb 04                	jmp    8013e8 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8013e4:	90                   	nop
  8013e5:	eb 01                	jmp    8013e8 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8013e7:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8013e8:	c9                   	leave  
  8013e9:	c3                   	ret    

008013ea <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8013ea:	55                   	push   %ebp
  8013eb:	89 e5                	mov    %esp,%ebp
  8013ed:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8013f0:	83 ec 04             	sub    $0x4,%esp
  8013f3:	68 78 23 80 00       	push   $0x802378
  8013f8:	68 ae 00 00 00       	push   $0xae
  8013fd:	68 4f 23 80 00       	push   $0x80234f
  801402:	e8 37 06 00 00       	call   801a3e <_panic>

00801407 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801407:	55                   	push   %ebp
  801408:	89 e5                	mov    %esp,%ebp
  80140a:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  80140d:	83 ec 04             	sub    $0x4,%esp
  801410:	68 98 23 80 00       	push   $0x802398
  801415:	68 ca 00 00 00       	push   $0xca
  80141a:	68 4f 23 80 00       	push   $0x80234f
  80141f:	e8 1a 06 00 00       	call   801a3e <_panic>

00801424 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801424:	55                   	push   %ebp
  801425:	89 e5                	mov    %esp,%ebp
  801427:	57                   	push   %edi
  801428:	56                   	push   %esi
  801429:	53                   	push   %ebx
  80142a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
  801430:	8b 55 0c             	mov    0xc(%ebp),%edx
  801433:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801436:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801439:	8b 7d 18             	mov    0x18(%ebp),%edi
  80143c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80143f:	cd 30                	int    $0x30
  801441:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801444:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801447:	83 c4 10             	add    $0x10,%esp
  80144a:	5b                   	pop    %ebx
  80144b:	5e                   	pop    %esi
  80144c:	5f                   	pop    %edi
  80144d:	5d                   	pop    %ebp
  80144e:	c3                   	ret    

0080144f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80144f:	55                   	push   %ebp
  801450:	89 e5                	mov    %esp,%ebp
  801452:	83 ec 04             	sub    $0x4,%esp
  801455:	8b 45 10             	mov    0x10(%ebp),%eax
  801458:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80145b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	52                   	push   %edx
  801467:	ff 75 0c             	pushl  0xc(%ebp)
  80146a:	50                   	push   %eax
  80146b:	6a 00                	push   $0x0
  80146d:	e8 b2 ff ff ff       	call   801424 <syscall>
  801472:	83 c4 18             	add    $0x18,%esp
}
  801475:	90                   	nop
  801476:	c9                   	leave  
  801477:	c3                   	ret    

00801478 <sys_cgetc>:

int
sys_cgetc(void)
{
  801478:	55                   	push   %ebp
  801479:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 01                	push   $0x1
  801487:	e8 98 ff ff ff       	call   801424 <syscall>
  80148c:	83 c4 18             	add    $0x18,%esp
}
  80148f:	c9                   	leave  
  801490:	c3                   	ret    

00801491 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801491:	55                   	push   %ebp
  801492:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801494:	8b 45 08             	mov    0x8(%ebp),%eax
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	50                   	push   %eax
  8014a0:	6a 05                	push   $0x5
  8014a2:	e8 7d ff ff ff       	call   801424 <syscall>
  8014a7:	83 c4 18             	add    $0x18,%esp
}
  8014aa:	c9                   	leave  
  8014ab:	c3                   	ret    

008014ac <sys_getenvid>:

int32 sys_getenvid(void)
{
  8014ac:	55                   	push   %ebp
  8014ad:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 02                	push   $0x2
  8014bb:	e8 64 ff ff ff       	call   801424 <syscall>
  8014c0:	83 c4 18             	add    $0x18,%esp
}
  8014c3:	c9                   	leave  
  8014c4:	c3                   	ret    

008014c5 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 03                	push   $0x3
  8014d4:	e8 4b ff ff ff       	call   801424 <syscall>
  8014d9:	83 c4 18             	add    $0x18,%esp
}
  8014dc:	c9                   	leave  
  8014dd:	c3                   	ret    

008014de <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8014de:	55                   	push   %ebp
  8014df:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 04                	push   $0x4
  8014ed:	e8 32 ff ff ff       	call   801424 <syscall>
  8014f2:	83 c4 18             	add    $0x18,%esp
}
  8014f5:	c9                   	leave  
  8014f6:	c3                   	ret    

008014f7 <sys_env_exit>:


void sys_env_exit(void)
{
  8014f7:	55                   	push   %ebp
  8014f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	6a 06                	push   $0x6
  801506:	e8 19 ff ff ff       	call   801424 <syscall>
  80150b:	83 c4 18             	add    $0x18,%esp
}
  80150e:	90                   	nop
  80150f:	c9                   	leave  
  801510:	c3                   	ret    

00801511 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801511:	55                   	push   %ebp
  801512:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801514:	8b 55 0c             	mov    0xc(%ebp),%edx
  801517:	8b 45 08             	mov    0x8(%ebp),%eax
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	52                   	push   %edx
  801521:	50                   	push   %eax
  801522:	6a 07                	push   $0x7
  801524:	e8 fb fe ff ff       	call   801424 <syscall>
  801529:	83 c4 18             	add    $0x18,%esp
}
  80152c:	c9                   	leave  
  80152d:	c3                   	ret    

0080152e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80152e:	55                   	push   %ebp
  80152f:	89 e5                	mov    %esp,%ebp
  801531:	56                   	push   %esi
  801532:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801533:	8b 75 18             	mov    0x18(%ebp),%esi
  801536:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801539:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80153c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	56                   	push   %esi
  801543:	53                   	push   %ebx
  801544:	51                   	push   %ecx
  801545:	52                   	push   %edx
  801546:	50                   	push   %eax
  801547:	6a 08                	push   $0x8
  801549:	e8 d6 fe ff ff       	call   801424 <syscall>
  80154e:	83 c4 18             	add    $0x18,%esp
}
  801551:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801554:	5b                   	pop    %ebx
  801555:	5e                   	pop    %esi
  801556:	5d                   	pop    %ebp
  801557:	c3                   	ret    

00801558 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801558:	55                   	push   %ebp
  801559:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80155b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155e:	8b 45 08             	mov    0x8(%ebp),%eax
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	52                   	push   %edx
  801568:	50                   	push   %eax
  801569:	6a 09                	push   $0x9
  80156b:	e8 b4 fe ff ff       	call   801424 <syscall>
  801570:	83 c4 18             	add    $0x18,%esp
}
  801573:	c9                   	leave  
  801574:	c3                   	ret    

00801575 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801575:	55                   	push   %ebp
  801576:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	ff 75 0c             	pushl  0xc(%ebp)
  801581:	ff 75 08             	pushl  0x8(%ebp)
  801584:	6a 0a                	push   $0xa
  801586:	e8 99 fe ff ff       	call   801424 <syscall>
  80158b:	83 c4 18             	add    $0x18,%esp
}
  80158e:	c9                   	leave  
  80158f:	c3                   	ret    

00801590 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801590:	55                   	push   %ebp
  801591:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 0b                	push   $0xb
  80159f:	e8 80 fe ff ff       	call   801424 <syscall>
  8015a4:	83 c4 18             	add    $0x18,%esp
}
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 0c                	push   $0xc
  8015b8:	e8 67 fe ff ff       	call   801424 <syscall>
  8015bd:	83 c4 18             	add    $0x18,%esp
}
  8015c0:	c9                   	leave  
  8015c1:	c3                   	ret    

008015c2 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015c2:	55                   	push   %ebp
  8015c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 0d                	push   $0xd
  8015d1:	e8 4e fe ff ff       	call   801424 <syscall>
  8015d6:	83 c4 18             	add    $0x18,%esp
}
  8015d9:	c9                   	leave  
  8015da:	c3                   	ret    

008015db <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015db:	55                   	push   %ebp
  8015dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	ff 75 0c             	pushl  0xc(%ebp)
  8015e7:	ff 75 08             	pushl  0x8(%ebp)
  8015ea:	6a 11                	push   $0x11
  8015ec:	e8 33 fe ff ff       	call   801424 <syscall>
  8015f1:	83 c4 18             	add    $0x18,%esp
	return;
  8015f4:	90                   	nop
}
  8015f5:	c9                   	leave  
  8015f6:	c3                   	ret    

008015f7 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8015f7:	55                   	push   %ebp
  8015f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	ff 75 0c             	pushl  0xc(%ebp)
  801603:	ff 75 08             	pushl  0x8(%ebp)
  801606:	6a 12                	push   $0x12
  801608:	e8 17 fe ff ff       	call   801424 <syscall>
  80160d:	83 c4 18             	add    $0x18,%esp
	return ;
  801610:	90                   	nop
}
  801611:	c9                   	leave  
  801612:	c3                   	ret    

00801613 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801613:	55                   	push   %ebp
  801614:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 0e                	push   $0xe
  801622:	e8 fd fd ff ff       	call   801424 <syscall>
  801627:	83 c4 18             	add    $0x18,%esp
}
  80162a:	c9                   	leave  
  80162b:	c3                   	ret    

0080162c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80162c:	55                   	push   %ebp
  80162d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	ff 75 08             	pushl  0x8(%ebp)
  80163a:	6a 0f                	push   $0xf
  80163c:	e8 e3 fd ff ff       	call   801424 <syscall>
  801641:	83 c4 18             	add    $0x18,%esp
}
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 10                	push   $0x10
  801655:	e8 ca fd ff ff       	call   801424 <syscall>
  80165a:	83 c4 18             	add    $0x18,%esp
}
  80165d:	90                   	nop
  80165e:	c9                   	leave  
  80165f:	c3                   	ret    

00801660 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801660:	55                   	push   %ebp
  801661:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 14                	push   $0x14
  80166f:	e8 b0 fd ff ff       	call   801424 <syscall>
  801674:	83 c4 18             	add    $0x18,%esp
}
  801677:	90                   	nop
  801678:	c9                   	leave  
  801679:	c3                   	ret    

0080167a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80167a:	55                   	push   %ebp
  80167b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 15                	push   $0x15
  801689:	e8 96 fd ff ff       	call   801424 <syscall>
  80168e:	83 c4 18             	add    $0x18,%esp
}
  801691:	90                   	nop
  801692:	c9                   	leave  
  801693:	c3                   	ret    

00801694 <sys_cputc>:


void
sys_cputc(const char c)
{
  801694:	55                   	push   %ebp
  801695:	89 e5                	mov    %esp,%ebp
  801697:	83 ec 04             	sub    $0x4,%esp
  80169a:	8b 45 08             	mov    0x8(%ebp),%eax
  80169d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016a0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 00                	push   $0x0
  8016ac:	50                   	push   %eax
  8016ad:	6a 16                	push   $0x16
  8016af:	e8 70 fd ff ff       	call   801424 <syscall>
  8016b4:	83 c4 18             	add    $0x18,%esp
}
  8016b7:	90                   	nop
  8016b8:	c9                   	leave  
  8016b9:	c3                   	ret    

008016ba <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016ba:	55                   	push   %ebp
  8016bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 17                	push   $0x17
  8016c9:	e8 56 fd ff ff       	call   801424 <syscall>
  8016ce:	83 c4 18             	add    $0x18,%esp
}
  8016d1:	90                   	nop
  8016d2:	c9                   	leave  
  8016d3:	c3                   	ret    

008016d4 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8016d4:	55                   	push   %ebp
  8016d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	ff 75 0c             	pushl  0xc(%ebp)
  8016e3:	50                   	push   %eax
  8016e4:	6a 18                	push   $0x18
  8016e6:	e8 39 fd ff ff       	call   801424 <syscall>
  8016eb:	83 c4 18             	add    $0x18,%esp
}
  8016ee:	c9                   	leave  
  8016ef:	c3                   	ret    

008016f0 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	52                   	push   %edx
  801700:	50                   	push   %eax
  801701:	6a 1b                	push   $0x1b
  801703:	e8 1c fd ff ff       	call   801424 <syscall>
  801708:	83 c4 18             	add    $0x18,%esp
}
  80170b:	c9                   	leave  
  80170c:	c3                   	ret    

0080170d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80170d:	55                   	push   %ebp
  80170e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801710:	8b 55 0c             	mov    0xc(%ebp),%edx
  801713:	8b 45 08             	mov    0x8(%ebp),%eax
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	52                   	push   %edx
  80171d:	50                   	push   %eax
  80171e:	6a 19                	push   $0x19
  801720:	e8 ff fc ff ff       	call   801424 <syscall>
  801725:	83 c4 18             	add    $0x18,%esp
}
  801728:	90                   	nop
  801729:	c9                   	leave  
  80172a:	c3                   	ret    

0080172b <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80172b:	55                   	push   %ebp
  80172c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80172e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801731:	8b 45 08             	mov    0x8(%ebp),%eax
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	52                   	push   %edx
  80173b:	50                   	push   %eax
  80173c:	6a 1a                	push   $0x1a
  80173e:	e8 e1 fc ff ff       	call   801424 <syscall>
  801743:	83 c4 18             	add    $0x18,%esp
}
  801746:	90                   	nop
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
  80174c:	83 ec 04             	sub    $0x4,%esp
  80174f:	8b 45 10             	mov    0x10(%ebp),%eax
  801752:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801755:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801758:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80175c:	8b 45 08             	mov    0x8(%ebp),%eax
  80175f:	6a 00                	push   $0x0
  801761:	51                   	push   %ecx
  801762:	52                   	push   %edx
  801763:	ff 75 0c             	pushl  0xc(%ebp)
  801766:	50                   	push   %eax
  801767:	6a 1c                	push   $0x1c
  801769:	e8 b6 fc ff ff       	call   801424 <syscall>
  80176e:	83 c4 18             	add    $0x18,%esp
}
  801771:	c9                   	leave  
  801772:	c3                   	ret    

00801773 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801773:	55                   	push   %ebp
  801774:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801776:	8b 55 0c             	mov    0xc(%ebp),%edx
  801779:	8b 45 08             	mov    0x8(%ebp),%eax
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	52                   	push   %edx
  801783:	50                   	push   %eax
  801784:	6a 1d                	push   $0x1d
  801786:	e8 99 fc ff ff       	call   801424 <syscall>
  80178b:	83 c4 18             	add    $0x18,%esp
}
  80178e:	c9                   	leave  
  80178f:	c3                   	ret    

00801790 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801793:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801796:	8b 55 0c             	mov    0xc(%ebp),%edx
  801799:	8b 45 08             	mov    0x8(%ebp),%eax
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	51                   	push   %ecx
  8017a1:	52                   	push   %edx
  8017a2:	50                   	push   %eax
  8017a3:	6a 1e                	push   $0x1e
  8017a5:	e8 7a fc ff ff       	call   801424 <syscall>
  8017aa:	83 c4 18             	add    $0x18,%esp
}
  8017ad:	c9                   	leave  
  8017ae:	c3                   	ret    

008017af <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8017af:	55                   	push   %ebp
  8017b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8017b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	52                   	push   %edx
  8017bf:	50                   	push   %eax
  8017c0:	6a 1f                	push   $0x1f
  8017c2:	e8 5d fc ff ff       	call   801424 <syscall>
  8017c7:	83 c4 18             	add    $0x18,%esp
}
  8017ca:	c9                   	leave  
  8017cb:	c3                   	ret    

008017cc <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8017cc:	55                   	push   %ebp
  8017cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 20                	push   $0x20
  8017db:	e8 44 fc ff ff       	call   801424 <syscall>
  8017e0:	83 c4 18             	add    $0x18,%esp
}
  8017e3:	c9                   	leave  
  8017e4:	c3                   	ret    

008017e5 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8017e5:	55                   	push   %ebp
  8017e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8017e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	ff 75 10             	pushl  0x10(%ebp)
  8017f2:	ff 75 0c             	pushl  0xc(%ebp)
  8017f5:	50                   	push   %eax
  8017f6:	6a 21                	push   $0x21
  8017f8:	e8 27 fc ff ff       	call   801424 <syscall>
  8017fd:	83 c4 18             	add    $0x18,%esp
}
  801800:	c9                   	leave  
  801801:	c3                   	ret    

00801802 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801802:	55                   	push   %ebp
  801803:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801805:	8b 45 08             	mov    0x8(%ebp),%eax
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	50                   	push   %eax
  801811:	6a 22                	push   $0x22
  801813:	e8 0c fc ff ff       	call   801424 <syscall>
  801818:	83 c4 18             	add    $0x18,%esp
}
  80181b:	90                   	nop
  80181c:	c9                   	leave  
  80181d:	c3                   	ret    

0080181e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80181e:	55                   	push   %ebp
  80181f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801821:	8b 45 08             	mov    0x8(%ebp),%eax
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	50                   	push   %eax
  80182d:	6a 23                	push   $0x23
  80182f:	e8 f0 fb ff ff       	call   801424 <syscall>
  801834:	83 c4 18             	add    $0x18,%esp
}
  801837:	90                   	nop
  801838:	c9                   	leave  
  801839:	c3                   	ret    

0080183a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80183a:	55                   	push   %ebp
  80183b:	89 e5                	mov    %esp,%ebp
  80183d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801840:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801843:	8d 50 04             	lea    0x4(%eax),%edx
  801846:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	52                   	push   %edx
  801850:	50                   	push   %eax
  801851:	6a 24                	push   $0x24
  801853:	e8 cc fb ff ff       	call   801424 <syscall>
  801858:	83 c4 18             	add    $0x18,%esp
	return result;
  80185b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80185e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801861:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801864:	89 01                	mov    %eax,(%ecx)
  801866:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801869:	8b 45 08             	mov    0x8(%ebp),%eax
  80186c:	c9                   	leave  
  80186d:	c2 04 00             	ret    $0x4

00801870 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801870:	55                   	push   %ebp
  801871:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	ff 75 10             	pushl  0x10(%ebp)
  80187a:	ff 75 0c             	pushl  0xc(%ebp)
  80187d:	ff 75 08             	pushl  0x8(%ebp)
  801880:	6a 13                	push   $0x13
  801882:	e8 9d fb ff ff       	call   801424 <syscall>
  801887:	83 c4 18             	add    $0x18,%esp
	return ;
  80188a:	90                   	nop
}
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <sys_rcr2>:
uint32 sys_rcr2()
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 25                	push   $0x25
  80189c:	e8 83 fb ff ff       	call   801424 <syscall>
  8018a1:	83 c4 18             	add    $0x18,%esp
}
  8018a4:	c9                   	leave  
  8018a5:	c3                   	ret    

008018a6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8018a6:	55                   	push   %ebp
  8018a7:	89 e5                	mov    %esp,%ebp
  8018a9:	83 ec 04             	sub    $0x4,%esp
  8018ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8018af:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018b2:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	50                   	push   %eax
  8018bf:	6a 26                	push   $0x26
  8018c1:	e8 5e fb ff ff       	call   801424 <syscall>
  8018c6:	83 c4 18             	add    $0x18,%esp
	return ;
  8018c9:	90                   	nop
}
  8018ca:	c9                   	leave  
  8018cb:	c3                   	ret    

008018cc <rsttst>:
void rsttst()
{
  8018cc:	55                   	push   %ebp
  8018cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 28                	push   $0x28
  8018db:	e8 44 fb ff ff       	call   801424 <syscall>
  8018e0:	83 c4 18             	add    $0x18,%esp
	return ;
  8018e3:	90                   	nop
}
  8018e4:	c9                   	leave  
  8018e5:	c3                   	ret    

008018e6 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018e6:	55                   	push   %ebp
  8018e7:	89 e5                	mov    %esp,%ebp
  8018e9:	83 ec 04             	sub    $0x4,%esp
  8018ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ef:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018f2:	8b 55 18             	mov    0x18(%ebp),%edx
  8018f5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018f9:	52                   	push   %edx
  8018fa:	50                   	push   %eax
  8018fb:	ff 75 10             	pushl  0x10(%ebp)
  8018fe:	ff 75 0c             	pushl  0xc(%ebp)
  801901:	ff 75 08             	pushl  0x8(%ebp)
  801904:	6a 27                	push   $0x27
  801906:	e8 19 fb ff ff       	call   801424 <syscall>
  80190b:	83 c4 18             	add    $0x18,%esp
	return ;
  80190e:	90                   	nop
}
  80190f:	c9                   	leave  
  801910:	c3                   	ret    

00801911 <chktst>:
void chktst(uint32 n)
{
  801911:	55                   	push   %ebp
  801912:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	ff 75 08             	pushl  0x8(%ebp)
  80191f:	6a 29                	push   $0x29
  801921:	e8 fe fa ff ff       	call   801424 <syscall>
  801926:	83 c4 18             	add    $0x18,%esp
	return ;
  801929:	90                   	nop
}
  80192a:	c9                   	leave  
  80192b:	c3                   	ret    

0080192c <inctst>:

void inctst()
{
  80192c:	55                   	push   %ebp
  80192d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 2a                	push   $0x2a
  80193b:	e8 e4 fa ff ff       	call   801424 <syscall>
  801940:	83 c4 18             	add    $0x18,%esp
	return ;
  801943:	90                   	nop
}
  801944:	c9                   	leave  
  801945:	c3                   	ret    

00801946 <gettst>:
uint32 gettst()
{
  801946:	55                   	push   %ebp
  801947:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 2b                	push   $0x2b
  801955:	e8 ca fa ff ff       	call   801424 <syscall>
  80195a:	83 c4 18             	add    $0x18,%esp
}
  80195d:	c9                   	leave  
  80195e:	c3                   	ret    

0080195f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80195f:	55                   	push   %ebp
  801960:	89 e5                	mov    %esp,%ebp
  801962:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 2c                	push   $0x2c
  801971:	e8 ae fa ff ff       	call   801424 <syscall>
  801976:	83 c4 18             	add    $0x18,%esp
  801979:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80197c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801980:	75 07                	jne    801989 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801982:	b8 01 00 00 00       	mov    $0x1,%eax
  801987:	eb 05                	jmp    80198e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801989:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80198e:	c9                   	leave  
  80198f:	c3                   	ret    

00801990 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801990:	55                   	push   %ebp
  801991:	89 e5                	mov    %esp,%ebp
  801993:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 2c                	push   $0x2c
  8019a2:	e8 7d fa ff ff       	call   801424 <syscall>
  8019a7:	83 c4 18             	add    $0x18,%esp
  8019aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8019ad:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8019b1:	75 07                	jne    8019ba <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8019b3:	b8 01 00 00 00       	mov    $0x1,%eax
  8019b8:	eb 05                	jmp    8019bf <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8019ba:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019bf:	c9                   	leave  
  8019c0:	c3                   	ret    

008019c1 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8019c1:	55                   	push   %ebp
  8019c2:	89 e5                	mov    %esp,%ebp
  8019c4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 2c                	push   $0x2c
  8019d3:	e8 4c fa ff ff       	call   801424 <syscall>
  8019d8:	83 c4 18             	add    $0x18,%esp
  8019db:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8019de:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8019e2:	75 07                	jne    8019eb <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8019e4:	b8 01 00 00 00       	mov    $0x1,%eax
  8019e9:	eb 05                	jmp    8019f0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8019eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019f0:	c9                   	leave  
  8019f1:	c3                   	ret    

008019f2 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8019f2:	55                   	push   %ebp
  8019f3:	89 e5                	mov    %esp,%ebp
  8019f5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 2c                	push   $0x2c
  801a04:	e8 1b fa ff ff       	call   801424 <syscall>
  801a09:	83 c4 18             	add    $0x18,%esp
  801a0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a0f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a13:	75 07                	jne    801a1c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a15:	b8 01 00 00 00       	mov    $0x1,%eax
  801a1a:	eb 05                	jmp    801a21 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a1c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a21:	c9                   	leave  
  801a22:	c3                   	ret    

00801a23 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a23:	55                   	push   %ebp
  801a24:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	ff 75 08             	pushl  0x8(%ebp)
  801a31:	6a 2d                	push   $0x2d
  801a33:	e8 ec f9 ff ff       	call   801424 <syscall>
  801a38:	83 c4 18             	add    $0x18,%esp
	return ;
  801a3b:	90                   	nop
}
  801a3c:	c9                   	leave  
  801a3d:	c3                   	ret    

00801a3e <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801a3e:	55                   	push   %ebp
  801a3f:	89 e5                	mov    %esp,%ebp
  801a41:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801a44:	8d 45 10             	lea    0x10(%ebp),%eax
  801a47:	83 c0 04             	add    $0x4,%eax
  801a4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801a4d:	a1 40 30 98 00       	mov    0x983040,%eax
  801a52:	85 c0                	test   %eax,%eax
  801a54:	74 16                	je     801a6c <_panic+0x2e>
		cprintf("%s: ", argv0);
  801a56:	a1 40 30 98 00       	mov    0x983040,%eax
  801a5b:	83 ec 08             	sub    $0x8,%esp
  801a5e:	50                   	push   %eax
  801a5f:	68 bc 23 80 00       	push   $0x8023bc
  801a64:	e8 a1 e9 ff ff       	call   80040a <cprintf>
  801a69:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801a6c:	a1 00 30 80 00       	mov    0x803000,%eax
  801a71:	ff 75 0c             	pushl  0xc(%ebp)
  801a74:	ff 75 08             	pushl  0x8(%ebp)
  801a77:	50                   	push   %eax
  801a78:	68 c1 23 80 00       	push   $0x8023c1
  801a7d:	e8 88 e9 ff ff       	call   80040a <cprintf>
  801a82:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801a85:	8b 45 10             	mov    0x10(%ebp),%eax
  801a88:	83 ec 08             	sub    $0x8,%esp
  801a8b:	ff 75 f4             	pushl  -0xc(%ebp)
  801a8e:	50                   	push   %eax
  801a8f:	e8 0b e9 ff ff       	call   80039f <vcprintf>
  801a94:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801a97:	83 ec 08             	sub    $0x8,%esp
  801a9a:	6a 00                	push   $0x0
  801a9c:	68 dd 23 80 00       	push   $0x8023dd
  801aa1:	e8 f9 e8 ff ff       	call   80039f <vcprintf>
  801aa6:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801aa9:	e8 7a e8 ff ff       	call   800328 <exit>

	// should not return here
	while (1) ;
  801aae:	eb fe                	jmp    801aae <_panic+0x70>

00801ab0 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801ab0:	55                   	push   %ebp
  801ab1:	89 e5                	mov    %esp,%ebp
  801ab3:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801ab6:	a1 20 30 80 00       	mov    0x803020,%eax
  801abb:	8b 50 74             	mov    0x74(%eax),%edx
  801abe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ac1:	39 c2                	cmp    %eax,%edx
  801ac3:	74 14                	je     801ad9 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801ac5:	83 ec 04             	sub    $0x4,%esp
  801ac8:	68 e0 23 80 00       	push   $0x8023e0
  801acd:	6a 26                	push   $0x26
  801acf:	68 2c 24 80 00       	push   $0x80242c
  801ad4:	e8 65 ff ff ff       	call   801a3e <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801ad9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801ae0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ae7:	e9 c2 00 00 00       	jmp    801bae <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801aec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801aef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801af6:	8b 45 08             	mov    0x8(%ebp),%eax
  801af9:	01 d0                	add    %edx,%eax
  801afb:	8b 00                	mov    (%eax),%eax
  801afd:	85 c0                	test   %eax,%eax
  801aff:	75 08                	jne    801b09 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801b01:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801b04:	e9 a2 00 00 00       	jmp    801bab <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801b09:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b10:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801b17:	eb 69                	jmp    801b82 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801b19:	a1 20 30 80 00       	mov    0x803020,%eax
  801b1e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801b24:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801b27:	89 d0                	mov    %edx,%eax
  801b29:	01 c0                	add    %eax,%eax
  801b2b:	01 d0                	add    %edx,%eax
  801b2d:	c1 e0 02             	shl    $0x2,%eax
  801b30:	01 c8                	add    %ecx,%eax
  801b32:	8a 40 04             	mov    0x4(%eax),%al
  801b35:	84 c0                	test   %al,%al
  801b37:	75 46                	jne    801b7f <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801b39:	a1 20 30 80 00       	mov    0x803020,%eax
  801b3e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801b44:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801b47:	89 d0                	mov    %edx,%eax
  801b49:	01 c0                	add    %eax,%eax
  801b4b:	01 d0                	add    %edx,%eax
  801b4d:	c1 e0 02             	shl    $0x2,%eax
  801b50:	01 c8                	add    %ecx,%eax
  801b52:	8b 00                	mov    (%eax),%eax
  801b54:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801b57:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b5a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801b5f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801b61:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b64:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801b6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6e:	01 c8                	add    %ecx,%eax
  801b70:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801b72:	39 c2                	cmp    %eax,%edx
  801b74:	75 09                	jne    801b7f <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801b76:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801b7d:	eb 12                	jmp    801b91 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b7f:	ff 45 e8             	incl   -0x18(%ebp)
  801b82:	a1 20 30 80 00       	mov    0x803020,%eax
  801b87:	8b 50 74             	mov    0x74(%eax),%edx
  801b8a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b8d:	39 c2                	cmp    %eax,%edx
  801b8f:	77 88                	ja     801b19 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801b91:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801b95:	75 14                	jne    801bab <CheckWSWithoutLastIndex+0xfb>
			panic(
  801b97:	83 ec 04             	sub    $0x4,%esp
  801b9a:	68 38 24 80 00       	push   $0x802438
  801b9f:	6a 3a                	push   $0x3a
  801ba1:	68 2c 24 80 00       	push   $0x80242c
  801ba6:	e8 93 fe ff ff       	call   801a3e <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801bab:	ff 45 f0             	incl   -0x10(%ebp)
  801bae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bb1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801bb4:	0f 8c 32 ff ff ff    	jl     801aec <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801bba:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bc1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801bc8:	eb 26                	jmp    801bf0 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801bca:	a1 20 30 80 00       	mov    0x803020,%eax
  801bcf:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801bd5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801bd8:	89 d0                	mov    %edx,%eax
  801bda:	01 c0                	add    %eax,%eax
  801bdc:	01 d0                	add    %edx,%eax
  801bde:	c1 e0 02             	shl    $0x2,%eax
  801be1:	01 c8                	add    %ecx,%eax
  801be3:	8a 40 04             	mov    0x4(%eax),%al
  801be6:	3c 01                	cmp    $0x1,%al
  801be8:	75 03                	jne    801bed <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801bea:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bed:	ff 45 e0             	incl   -0x20(%ebp)
  801bf0:	a1 20 30 80 00       	mov    0x803020,%eax
  801bf5:	8b 50 74             	mov    0x74(%eax),%edx
  801bf8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801bfb:	39 c2                	cmp    %eax,%edx
  801bfd:	77 cb                	ja     801bca <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801bff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c02:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801c05:	74 14                	je     801c1b <CheckWSWithoutLastIndex+0x16b>
		panic(
  801c07:	83 ec 04             	sub    $0x4,%esp
  801c0a:	68 8c 24 80 00       	push   $0x80248c
  801c0f:	6a 44                	push   $0x44
  801c11:	68 2c 24 80 00       	push   $0x80242c
  801c16:	e8 23 fe ff ff       	call   801a3e <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801c1b:	90                   	nop
  801c1c:	c9                   	leave  
  801c1d:	c3                   	ret    
  801c1e:	66 90                	xchg   %ax,%ax

00801c20 <__udivdi3>:
  801c20:	55                   	push   %ebp
  801c21:	57                   	push   %edi
  801c22:	56                   	push   %esi
  801c23:	53                   	push   %ebx
  801c24:	83 ec 1c             	sub    $0x1c,%esp
  801c27:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c2b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c2f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c33:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c37:	89 ca                	mov    %ecx,%edx
  801c39:	89 f8                	mov    %edi,%eax
  801c3b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c3f:	85 f6                	test   %esi,%esi
  801c41:	75 2d                	jne    801c70 <__udivdi3+0x50>
  801c43:	39 cf                	cmp    %ecx,%edi
  801c45:	77 65                	ja     801cac <__udivdi3+0x8c>
  801c47:	89 fd                	mov    %edi,%ebp
  801c49:	85 ff                	test   %edi,%edi
  801c4b:	75 0b                	jne    801c58 <__udivdi3+0x38>
  801c4d:	b8 01 00 00 00       	mov    $0x1,%eax
  801c52:	31 d2                	xor    %edx,%edx
  801c54:	f7 f7                	div    %edi
  801c56:	89 c5                	mov    %eax,%ebp
  801c58:	31 d2                	xor    %edx,%edx
  801c5a:	89 c8                	mov    %ecx,%eax
  801c5c:	f7 f5                	div    %ebp
  801c5e:	89 c1                	mov    %eax,%ecx
  801c60:	89 d8                	mov    %ebx,%eax
  801c62:	f7 f5                	div    %ebp
  801c64:	89 cf                	mov    %ecx,%edi
  801c66:	89 fa                	mov    %edi,%edx
  801c68:	83 c4 1c             	add    $0x1c,%esp
  801c6b:	5b                   	pop    %ebx
  801c6c:	5e                   	pop    %esi
  801c6d:	5f                   	pop    %edi
  801c6e:	5d                   	pop    %ebp
  801c6f:	c3                   	ret    
  801c70:	39 ce                	cmp    %ecx,%esi
  801c72:	77 28                	ja     801c9c <__udivdi3+0x7c>
  801c74:	0f bd fe             	bsr    %esi,%edi
  801c77:	83 f7 1f             	xor    $0x1f,%edi
  801c7a:	75 40                	jne    801cbc <__udivdi3+0x9c>
  801c7c:	39 ce                	cmp    %ecx,%esi
  801c7e:	72 0a                	jb     801c8a <__udivdi3+0x6a>
  801c80:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c84:	0f 87 9e 00 00 00    	ja     801d28 <__udivdi3+0x108>
  801c8a:	b8 01 00 00 00       	mov    $0x1,%eax
  801c8f:	89 fa                	mov    %edi,%edx
  801c91:	83 c4 1c             	add    $0x1c,%esp
  801c94:	5b                   	pop    %ebx
  801c95:	5e                   	pop    %esi
  801c96:	5f                   	pop    %edi
  801c97:	5d                   	pop    %ebp
  801c98:	c3                   	ret    
  801c99:	8d 76 00             	lea    0x0(%esi),%esi
  801c9c:	31 ff                	xor    %edi,%edi
  801c9e:	31 c0                	xor    %eax,%eax
  801ca0:	89 fa                	mov    %edi,%edx
  801ca2:	83 c4 1c             	add    $0x1c,%esp
  801ca5:	5b                   	pop    %ebx
  801ca6:	5e                   	pop    %esi
  801ca7:	5f                   	pop    %edi
  801ca8:	5d                   	pop    %ebp
  801ca9:	c3                   	ret    
  801caa:	66 90                	xchg   %ax,%ax
  801cac:	89 d8                	mov    %ebx,%eax
  801cae:	f7 f7                	div    %edi
  801cb0:	31 ff                	xor    %edi,%edi
  801cb2:	89 fa                	mov    %edi,%edx
  801cb4:	83 c4 1c             	add    $0x1c,%esp
  801cb7:	5b                   	pop    %ebx
  801cb8:	5e                   	pop    %esi
  801cb9:	5f                   	pop    %edi
  801cba:	5d                   	pop    %ebp
  801cbb:	c3                   	ret    
  801cbc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801cc1:	89 eb                	mov    %ebp,%ebx
  801cc3:	29 fb                	sub    %edi,%ebx
  801cc5:	89 f9                	mov    %edi,%ecx
  801cc7:	d3 e6                	shl    %cl,%esi
  801cc9:	89 c5                	mov    %eax,%ebp
  801ccb:	88 d9                	mov    %bl,%cl
  801ccd:	d3 ed                	shr    %cl,%ebp
  801ccf:	89 e9                	mov    %ebp,%ecx
  801cd1:	09 f1                	or     %esi,%ecx
  801cd3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801cd7:	89 f9                	mov    %edi,%ecx
  801cd9:	d3 e0                	shl    %cl,%eax
  801cdb:	89 c5                	mov    %eax,%ebp
  801cdd:	89 d6                	mov    %edx,%esi
  801cdf:	88 d9                	mov    %bl,%cl
  801ce1:	d3 ee                	shr    %cl,%esi
  801ce3:	89 f9                	mov    %edi,%ecx
  801ce5:	d3 e2                	shl    %cl,%edx
  801ce7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ceb:	88 d9                	mov    %bl,%cl
  801ced:	d3 e8                	shr    %cl,%eax
  801cef:	09 c2                	or     %eax,%edx
  801cf1:	89 d0                	mov    %edx,%eax
  801cf3:	89 f2                	mov    %esi,%edx
  801cf5:	f7 74 24 0c          	divl   0xc(%esp)
  801cf9:	89 d6                	mov    %edx,%esi
  801cfb:	89 c3                	mov    %eax,%ebx
  801cfd:	f7 e5                	mul    %ebp
  801cff:	39 d6                	cmp    %edx,%esi
  801d01:	72 19                	jb     801d1c <__udivdi3+0xfc>
  801d03:	74 0b                	je     801d10 <__udivdi3+0xf0>
  801d05:	89 d8                	mov    %ebx,%eax
  801d07:	31 ff                	xor    %edi,%edi
  801d09:	e9 58 ff ff ff       	jmp    801c66 <__udivdi3+0x46>
  801d0e:	66 90                	xchg   %ax,%ax
  801d10:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d14:	89 f9                	mov    %edi,%ecx
  801d16:	d3 e2                	shl    %cl,%edx
  801d18:	39 c2                	cmp    %eax,%edx
  801d1a:	73 e9                	jae    801d05 <__udivdi3+0xe5>
  801d1c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d1f:	31 ff                	xor    %edi,%edi
  801d21:	e9 40 ff ff ff       	jmp    801c66 <__udivdi3+0x46>
  801d26:	66 90                	xchg   %ax,%ax
  801d28:	31 c0                	xor    %eax,%eax
  801d2a:	e9 37 ff ff ff       	jmp    801c66 <__udivdi3+0x46>
  801d2f:	90                   	nop

00801d30 <__umoddi3>:
  801d30:	55                   	push   %ebp
  801d31:	57                   	push   %edi
  801d32:	56                   	push   %esi
  801d33:	53                   	push   %ebx
  801d34:	83 ec 1c             	sub    $0x1c,%esp
  801d37:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d3b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d3f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d43:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d47:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d4b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d4f:	89 f3                	mov    %esi,%ebx
  801d51:	89 fa                	mov    %edi,%edx
  801d53:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d57:	89 34 24             	mov    %esi,(%esp)
  801d5a:	85 c0                	test   %eax,%eax
  801d5c:	75 1a                	jne    801d78 <__umoddi3+0x48>
  801d5e:	39 f7                	cmp    %esi,%edi
  801d60:	0f 86 a2 00 00 00    	jbe    801e08 <__umoddi3+0xd8>
  801d66:	89 c8                	mov    %ecx,%eax
  801d68:	89 f2                	mov    %esi,%edx
  801d6a:	f7 f7                	div    %edi
  801d6c:	89 d0                	mov    %edx,%eax
  801d6e:	31 d2                	xor    %edx,%edx
  801d70:	83 c4 1c             	add    $0x1c,%esp
  801d73:	5b                   	pop    %ebx
  801d74:	5e                   	pop    %esi
  801d75:	5f                   	pop    %edi
  801d76:	5d                   	pop    %ebp
  801d77:	c3                   	ret    
  801d78:	39 f0                	cmp    %esi,%eax
  801d7a:	0f 87 ac 00 00 00    	ja     801e2c <__umoddi3+0xfc>
  801d80:	0f bd e8             	bsr    %eax,%ebp
  801d83:	83 f5 1f             	xor    $0x1f,%ebp
  801d86:	0f 84 ac 00 00 00    	je     801e38 <__umoddi3+0x108>
  801d8c:	bf 20 00 00 00       	mov    $0x20,%edi
  801d91:	29 ef                	sub    %ebp,%edi
  801d93:	89 fe                	mov    %edi,%esi
  801d95:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d99:	89 e9                	mov    %ebp,%ecx
  801d9b:	d3 e0                	shl    %cl,%eax
  801d9d:	89 d7                	mov    %edx,%edi
  801d9f:	89 f1                	mov    %esi,%ecx
  801da1:	d3 ef                	shr    %cl,%edi
  801da3:	09 c7                	or     %eax,%edi
  801da5:	89 e9                	mov    %ebp,%ecx
  801da7:	d3 e2                	shl    %cl,%edx
  801da9:	89 14 24             	mov    %edx,(%esp)
  801dac:	89 d8                	mov    %ebx,%eax
  801dae:	d3 e0                	shl    %cl,%eax
  801db0:	89 c2                	mov    %eax,%edx
  801db2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801db6:	d3 e0                	shl    %cl,%eax
  801db8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801dbc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dc0:	89 f1                	mov    %esi,%ecx
  801dc2:	d3 e8                	shr    %cl,%eax
  801dc4:	09 d0                	or     %edx,%eax
  801dc6:	d3 eb                	shr    %cl,%ebx
  801dc8:	89 da                	mov    %ebx,%edx
  801dca:	f7 f7                	div    %edi
  801dcc:	89 d3                	mov    %edx,%ebx
  801dce:	f7 24 24             	mull   (%esp)
  801dd1:	89 c6                	mov    %eax,%esi
  801dd3:	89 d1                	mov    %edx,%ecx
  801dd5:	39 d3                	cmp    %edx,%ebx
  801dd7:	0f 82 87 00 00 00    	jb     801e64 <__umoddi3+0x134>
  801ddd:	0f 84 91 00 00 00    	je     801e74 <__umoddi3+0x144>
  801de3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801de7:	29 f2                	sub    %esi,%edx
  801de9:	19 cb                	sbb    %ecx,%ebx
  801deb:	89 d8                	mov    %ebx,%eax
  801ded:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801df1:	d3 e0                	shl    %cl,%eax
  801df3:	89 e9                	mov    %ebp,%ecx
  801df5:	d3 ea                	shr    %cl,%edx
  801df7:	09 d0                	or     %edx,%eax
  801df9:	89 e9                	mov    %ebp,%ecx
  801dfb:	d3 eb                	shr    %cl,%ebx
  801dfd:	89 da                	mov    %ebx,%edx
  801dff:	83 c4 1c             	add    $0x1c,%esp
  801e02:	5b                   	pop    %ebx
  801e03:	5e                   	pop    %esi
  801e04:	5f                   	pop    %edi
  801e05:	5d                   	pop    %ebp
  801e06:	c3                   	ret    
  801e07:	90                   	nop
  801e08:	89 fd                	mov    %edi,%ebp
  801e0a:	85 ff                	test   %edi,%edi
  801e0c:	75 0b                	jne    801e19 <__umoddi3+0xe9>
  801e0e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e13:	31 d2                	xor    %edx,%edx
  801e15:	f7 f7                	div    %edi
  801e17:	89 c5                	mov    %eax,%ebp
  801e19:	89 f0                	mov    %esi,%eax
  801e1b:	31 d2                	xor    %edx,%edx
  801e1d:	f7 f5                	div    %ebp
  801e1f:	89 c8                	mov    %ecx,%eax
  801e21:	f7 f5                	div    %ebp
  801e23:	89 d0                	mov    %edx,%eax
  801e25:	e9 44 ff ff ff       	jmp    801d6e <__umoddi3+0x3e>
  801e2a:	66 90                	xchg   %ax,%ax
  801e2c:	89 c8                	mov    %ecx,%eax
  801e2e:	89 f2                	mov    %esi,%edx
  801e30:	83 c4 1c             	add    $0x1c,%esp
  801e33:	5b                   	pop    %ebx
  801e34:	5e                   	pop    %esi
  801e35:	5f                   	pop    %edi
  801e36:	5d                   	pop    %ebp
  801e37:	c3                   	ret    
  801e38:	3b 04 24             	cmp    (%esp),%eax
  801e3b:	72 06                	jb     801e43 <__umoddi3+0x113>
  801e3d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e41:	77 0f                	ja     801e52 <__umoddi3+0x122>
  801e43:	89 f2                	mov    %esi,%edx
  801e45:	29 f9                	sub    %edi,%ecx
  801e47:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e4b:	89 14 24             	mov    %edx,(%esp)
  801e4e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e52:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e56:	8b 14 24             	mov    (%esp),%edx
  801e59:	83 c4 1c             	add    $0x1c,%esp
  801e5c:	5b                   	pop    %ebx
  801e5d:	5e                   	pop    %esi
  801e5e:	5f                   	pop    %edi
  801e5f:	5d                   	pop    %ebp
  801e60:	c3                   	ret    
  801e61:	8d 76 00             	lea    0x0(%esi),%esi
  801e64:	2b 04 24             	sub    (%esp),%eax
  801e67:	19 fa                	sbb    %edi,%edx
  801e69:	89 d1                	mov    %edx,%ecx
  801e6b:	89 c6                	mov    %eax,%esi
  801e6d:	e9 71 ff ff ff       	jmp    801de3 <__umoddi3+0xb3>
  801e72:	66 90                	xchg   %ax,%ax
  801e74:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e78:	72 ea                	jb     801e64 <__umoddi3+0x134>
  801e7a:	89 d9                	mov    %ebx,%ecx
  801e7c:	e9 62 ff ff ff       	jmp    801de3 <__umoddi3+0xb3>
