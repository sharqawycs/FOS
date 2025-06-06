
obj/user/test_trim1_a:     file format elf32-i386


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
  800031:	e8 21 01 00 00       	call   800157 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int first = 1;
uint32 ws_size_first=0;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	if(first == 1)
  80003e:	a1 00 20 80 00       	mov    0x802000,%eax
  800043:	83 f8 01             	cmp    $0x1,%eax
  800046:	0f 85 85 00 00 00    	jne    8000d1 <_main+0x99>
	{
		first = 0;
  80004c:	c7 05 00 20 80 00 00 	movl   $0x0,0x802000
  800053:	00 00 00 

		int envID = sys_getenvid();
  800056:	e8 e4 10 00 00       	call   80113f <sys_getenvid>
  80005b:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("envID = %d\n",envID);
  80005e:	83 ec 08             	sub    $0x8,%esp
  800061:	ff 75 e8             	pushl  -0x18(%ebp)
  800064:	68 40 19 80 00       	push   $0x801940
  800069:	e8 bf 02 00 00       	call   80032d <cprintf>
  80006e:	83 c4 10             	add    $0x10,%esp

		uint32 i=0;
  800071:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
			}
			cprintf("\n");
		}
*/

		cprintf("testing trim: hello from A\n");
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	68 4c 19 80 00       	push   $0x80194c
  800080:	e8 a8 02 00 00       	call   80032d <cprintf>
  800085:	83 c4 10             	add    $0x10,%esp
		i=0;
  800088:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for(; i< (myEnv->page_WS_max_size); i++)
  80008f:	eb 2e                	jmp    8000bf <_main+0x87>
		{
			if(myEnv->__uptr_pws[i].empty == 0)
  800091:	a1 0c 20 80 00       	mov    0x80200c,%eax
  800096:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80009c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80009f:	89 d0                	mov    %edx,%eax
  8000a1:	01 c0                	add    %eax,%eax
  8000a3:	01 d0                	add    %edx,%eax
  8000a5:	c1 e0 02             	shl    $0x2,%eax
  8000a8:	01 c8                	add    %ecx,%eax
  8000aa:	8a 40 04             	mov    0x4(%eax),%al
  8000ad:	84 c0                	test   %al,%al
  8000af:	75 0b                	jne    8000bc <_main+0x84>
			{
				ws_size_first++;
  8000b1:	a1 08 20 80 00       	mov    0x802008,%eax
  8000b6:	40                   	inc    %eax
  8000b7:	a3 08 20 80 00       	mov    %eax,0x802008
		}
*/

		cprintf("testing trim: hello from A\n");
		i=0;
		for(; i< (myEnv->page_WS_max_size); i++)
  8000bc:	ff 45 f4             	incl   -0xc(%ebp)
  8000bf:	a1 0c 20 80 00       	mov    0x80200c,%eax
  8000c4:	8b 40 74             	mov    0x74(%eax),%eax
  8000c7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000ca:	77 c5                	ja     800091 <_main+0x59>
		uint32 reduced_frames = ws_size_first-ws_size;
//		cprintf("ws_size_first = %d\n",ws_size_first);
		//cprintf("ws_size = %d\n",ws_size);
		cprintf("test trim 1 A: WS size after trimming is reduced by %d frames\n", reduced_frames);
	}
}
  8000cc:	e9 83 00 00 00       	jmp    800154 <_main+0x11c>
		}
		//cprintf("ws_size_first = %d\n",ws_size_first);
	}
	else
	{
		int envID = sys_getenvid();
  8000d1:	e8 69 10 00 00       	call   80113f <sys_getenvid>
  8000d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("envID = %d\n",envID);
  8000d9:	83 ec 08             	sub    $0x8,%esp
  8000dc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000df:	68 40 19 80 00       	push   $0x801940
  8000e4:	e8 44 02 00 00       	call   80032d <cprintf>
  8000e9:	83 c4 10             	add    $0x10,%esp

		uint32 i=0;
  8000ec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			}
			cprintf("\n");
		}
*/

		i=0;
  8000f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		uint32 ws_size=0;
  8000fa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(; i< (myEnv->page_WS_max_size); i++)
  800101:	eb 26                	jmp    800129 <_main+0xf1>
		{
			if(myEnv->__uptr_pws[i].empty == 0)
  800103:	a1 0c 20 80 00       	mov    0x80200c,%eax
  800108:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80010e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800111:	89 d0                	mov    %edx,%eax
  800113:	01 c0                	add    %eax,%eax
  800115:	01 d0                	add    %edx,%eax
  800117:	c1 e0 02             	shl    $0x2,%eax
  80011a:	01 c8                	add    %ecx,%eax
  80011c:	8a 40 04             	mov    0x4(%eax),%al
  80011f:	84 c0                	test   %al,%al
  800121:	75 03                	jne    800126 <_main+0xee>
			{
				ws_size++;
  800123:	ff 45 ec             	incl   -0x14(%ebp)
		}
*/

		i=0;
		uint32 ws_size=0;
		for(; i< (myEnv->page_WS_max_size); i++)
  800126:	ff 45 f0             	incl   -0x10(%ebp)
  800129:	a1 0c 20 80 00       	mov    0x80200c,%eax
  80012e:	8b 40 74             	mov    0x74(%eax),%eax
  800131:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800134:	77 cd                	ja     800103 <_main+0xcb>
			{
				ws_size++;
			}
		}

		uint32 reduced_frames = ws_size_first-ws_size;
  800136:	a1 08 20 80 00       	mov    0x802008,%eax
  80013b:	2b 45 ec             	sub    -0x14(%ebp),%eax
  80013e:	89 45 e0             	mov    %eax,-0x20(%ebp)
//		cprintf("ws_size_first = %d\n",ws_size_first);
		//cprintf("ws_size = %d\n",ws_size);
		cprintf("test trim 1 A: WS size after trimming is reduced by %d frames\n", reduced_frames);
  800141:	83 ec 08             	sub    $0x8,%esp
  800144:	ff 75 e0             	pushl  -0x20(%ebp)
  800147:	68 68 19 80 00       	push   $0x801968
  80014c:	e8 dc 01 00 00       	call   80032d <cprintf>
  800151:	83 c4 10             	add    $0x10,%esp
	}
}
  800154:	90                   	nop
  800155:	c9                   	leave  
  800156:	c3                   	ret    

00800157 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800157:	55                   	push   %ebp
  800158:	89 e5                	mov    %esp,%ebp
  80015a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80015d:	e8 f6 0f 00 00       	call   801158 <sys_getenvindex>
  800162:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800165:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800168:	89 d0                	mov    %edx,%eax
  80016a:	01 c0                	add    %eax,%eax
  80016c:	01 d0                	add    %edx,%eax
  80016e:	c1 e0 02             	shl    $0x2,%eax
  800171:	01 d0                	add    %edx,%eax
  800173:	c1 e0 06             	shl    $0x6,%eax
  800176:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80017b:	a3 0c 20 80 00       	mov    %eax,0x80200c

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800180:	a1 0c 20 80 00       	mov    0x80200c,%eax
  800185:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80018b:	84 c0                	test   %al,%al
  80018d:	74 0f                	je     80019e <libmain+0x47>
		binaryname = myEnv->prog_name;
  80018f:	a1 0c 20 80 00       	mov    0x80200c,%eax
  800194:	05 f4 02 00 00       	add    $0x2f4,%eax
  800199:	a3 04 20 80 00       	mov    %eax,0x802004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80019e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001a2:	7e 0a                	jle    8001ae <libmain+0x57>
		binaryname = argv[0];
  8001a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001a7:	8b 00                	mov    (%eax),%eax
  8001a9:	a3 04 20 80 00       	mov    %eax,0x802004

	// call user main routine
	_main(argc, argv);
  8001ae:	83 ec 08             	sub    $0x8,%esp
  8001b1:	ff 75 0c             	pushl  0xc(%ebp)
  8001b4:	ff 75 08             	pushl  0x8(%ebp)
  8001b7:	e8 7c fe ff ff       	call   800038 <_main>
  8001bc:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001bf:	e8 2f 11 00 00       	call   8012f3 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001c4:	83 ec 0c             	sub    $0xc,%esp
  8001c7:	68 c0 19 80 00       	push   $0x8019c0
  8001cc:	e8 5c 01 00 00       	call   80032d <cprintf>
  8001d1:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001d4:	a1 0c 20 80 00       	mov    0x80200c,%eax
  8001d9:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001df:	a1 0c 20 80 00       	mov    0x80200c,%eax
  8001e4:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001ea:	83 ec 04             	sub    $0x4,%esp
  8001ed:	52                   	push   %edx
  8001ee:	50                   	push   %eax
  8001ef:	68 e8 19 80 00       	push   $0x8019e8
  8001f4:	e8 34 01 00 00       	call   80032d <cprintf>
  8001f9:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001fc:	a1 0c 20 80 00       	mov    0x80200c,%eax
  800201:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800207:	83 ec 08             	sub    $0x8,%esp
  80020a:	50                   	push   %eax
  80020b:	68 0d 1a 80 00       	push   $0x801a0d
  800210:	e8 18 01 00 00       	call   80032d <cprintf>
  800215:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800218:	83 ec 0c             	sub    $0xc,%esp
  80021b:	68 c0 19 80 00       	push   $0x8019c0
  800220:	e8 08 01 00 00       	call   80032d <cprintf>
  800225:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800228:	e8 e0 10 00 00       	call   80130d <sys_enable_interrupt>

	// exit gracefully
	exit();
  80022d:	e8 19 00 00 00       	call   80024b <exit>
}
  800232:	90                   	nop
  800233:	c9                   	leave  
  800234:	c3                   	ret    

00800235 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800235:	55                   	push   %ebp
  800236:	89 e5                	mov    %esp,%ebp
  800238:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80023b:	83 ec 0c             	sub    $0xc,%esp
  80023e:	6a 00                	push   $0x0
  800240:	e8 df 0e 00 00       	call   801124 <sys_env_destroy>
  800245:	83 c4 10             	add    $0x10,%esp
}
  800248:	90                   	nop
  800249:	c9                   	leave  
  80024a:	c3                   	ret    

0080024b <exit>:

void
exit(void)
{
  80024b:	55                   	push   %ebp
  80024c:	89 e5                	mov    %esp,%ebp
  80024e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800251:	e8 34 0f 00 00       	call   80118a <sys_env_exit>
}
  800256:	90                   	nop
  800257:	c9                   	leave  
  800258:	c3                   	ret    

00800259 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800259:	55                   	push   %ebp
  80025a:	89 e5                	mov    %esp,%ebp
  80025c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80025f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800262:	8b 00                	mov    (%eax),%eax
  800264:	8d 48 01             	lea    0x1(%eax),%ecx
  800267:	8b 55 0c             	mov    0xc(%ebp),%edx
  80026a:	89 0a                	mov    %ecx,(%edx)
  80026c:	8b 55 08             	mov    0x8(%ebp),%edx
  80026f:	88 d1                	mov    %dl,%cl
  800271:	8b 55 0c             	mov    0xc(%ebp),%edx
  800274:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800278:	8b 45 0c             	mov    0xc(%ebp),%eax
  80027b:	8b 00                	mov    (%eax),%eax
  80027d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800282:	75 2c                	jne    8002b0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800284:	a0 10 20 80 00       	mov    0x802010,%al
  800289:	0f b6 c0             	movzbl %al,%eax
  80028c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80028f:	8b 12                	mov    (%edx),%edx
  800291:	89 d1                	mov    %edx,%ecx
  800293:	8b 55 0c             	mov    0xc(%ebp),%edx
  800296:	83 c2 08             	add    $0x8,%edx
  800299:	83 ec 04             	sub    $0x4,%esp
  80029c:	50                   	push   %eax
  80029d:	51                   	push   %ecx
  80029e:	52                   	push   %edx
  80029f:	e8 3e 0e 00 00       	call   8010e2 <sys_cputs>
  8002a4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002b3:	8b 40 04             	mov    0x4(%eax),%eax
  8002b6:	8d 50 01             	lea    0x1(%eax),%edx
  8002b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002bc:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002bf:	90                   	nop
  8002c0:	c9                   	leave  
  8002c1:	c3                   	ret    

008002c2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002c2:	55                   	push   %ebp
  8002c3:	89 e5                	mov    %esp,%ebp
  8002c5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002cb:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002d2:	00 00 00 
	b.cnt = 0;
  8002d5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002dc:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002df:	ff 75 0c             	pushl  0xc(%ebp)
  8002e2:	ff 75 08             	pushl  0x8(%ebp)
  8002e5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002eb:	50                   	push   %eax
  8002ec:	68 59 02 80 00       	push   $0x800259
  8002f1:	e8 11 02 00 00       	call   800507 <vprintfmt>
  8002f6:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002f9:	a0 10 20 80 00       	mov    0x802010,%al
  8002fe:	0f b6 c0             	movzbl %al,%eax
  800301:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800307:	83 ec 04             	sub    $0x4,%esp
  80030a:	50                   	push   %eax
  80030b:	52                   	push   %edx
  80030c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800312:	83 c0 08             	add    $0x8,%eax
  800315:	50                   	push   %eax
  800316:	e8 c7 0d 00 00       	call   8010e2 <sys_cputs>
  80031b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80031e:	c6 05 10 20 80 00 00 	movb   $0x0,0x802010
	return b.cnt;
  800325:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80032b:	c9                   	leave  
  80032c:	c3                   	ret    

0080032d <cprintf>:

int cprintf(const char *fmt, ...) {
  80032d:	55                   	push   %ebp
  80032e:	89 e5                	mov    %esp,%ebp
  800330:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800333:	c6 05 10 20 80 00 01 	movb   $0x1,0x802010
	va_start(ap, fmt);
  80033a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80033d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800340:	8b 45 08             	mov    0x8(%ebp),%eax
  800343:	83 ec 08             	sub    $0x8,%esp
  800346:	ff 75 f4             	pushl  -0xc(%ebp)
  800349:	50                   	push   %eax
  80034a:	e8 73 ff ff ff       	call   8002c2 <vcprintf>
  80034f:	83 c4 10             	add    $0x10,%esp
  800352:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800355:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800358:	c9                   	leave  
  800359:	c3                   	ret    

0080035a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80035a:	55                   	push   %ebp
  80035b:	89 e5                	mov    %esp,%ebp
  80035d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800360:	e8 8e 0f 00 00       	call   8012f3 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800365:	8d 45 0c             	lea    0xc(%ebp),%eax
  800368:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80036b:	8b 45 08             	mov    0x8(%ebp),%eax
  80036e:	83 ec 08             	sub    $0x8,%esp
  800371:	ff 75 f4             	pushl  -0xc(%ebp)
  800374:	50                   	push   %eax
  800375:	e8 48 ff ff ff       	call   8002c2 <vcprintf>
  80037a:	83 c4 10             	add    $0x10,%esp
  80037d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800380:	e8 88 0f 00 00       	call   80130d <sys_enable_interrupt>
	return cnt;
  800385:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800388:	c9                   	leave  
  800389:	c3                   	ret    

0080038a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80038a:	55                   	push   %ebp
  80038b:	89 e5                	mov    %esp,%ebp
  80038d:	53                   	push   %ebx
  80038e:	83 ec 14             	sub    $0x14,%esp
  800391:	8b 45 10             	mov    0x10(%ebp),%eax
  800394:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800397:	8b 45 14             	mov    0x14(%ebp),%eax
  80039a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80039d:	8b 45 18             	mov    0x18(%ebp),%eax
  8003a0:	ba 00 00 00 00       	mov    $0x0,%edx
  8003a5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003a8:	77 55                	ja     8003ff <printnum+0x75>
  8003aa:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003ad:	72 05                	jb     8003b4 <printnum+0x2a>
  8003af:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003b2:	77 4b                	ja     8003ff <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003b4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003b7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003ba:	8b 45 18             	mov    0x18(%ebp),%eax
  8003bd:	ba 00 00 00 00       	mov    $0x0,%edx
  8003c2:	52                   	push   %edx
  8003c3:	50                   	push   %eax
  8003c4:	ff 75 f4             	pushl  -0xc(%ebp)
  8003c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8003ca:	e8 05 13 00 00       	call   8016d4 <__udivdi3>
  8003cf:	83 c4 10             	add    $0x10,%esp
  8003d2:	83 ec 04             	sub    $0x4,%esp
  8003d5:	ff 75 20             	pushl  0x20(%ebp)
  8003d8:	53                   	push   %ebx
  8003d9:	ff 75 18             	pushl  0x18(%ebp)
  8003dc:	52                   	push   %edx
  8003dd:	50                   	push   %eax
  8003de:	ff 75 0c             	pushl  0xc(%ebp)
  8003e1:	ff 75 08             	pushl  0x8(%ebp)
  8003e4:	e8 a1 ff ff ff       	call   80038a <printnum>
  8003e9:	83 c4 20             	add    $0x20,%esp
  8003ec:	eb 1a                	jmp    800408 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003ee:	83 ec 08             	sub    $0x8,%esp
  8003f1:	ff 75 0c             	pushl  0xc(%ebp)
  8003f4:	ff 75 20             	pushl  0x20(%ebp)
  8003f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fa:	ff d0                	call   *%eax
  8003fc:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003ff:	ff 4d 1c             	decl   0x1c(%ebp)
  800402:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800406:	7f e6                	jg     8003ee <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800408:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80040b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800410:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800413:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800416:	53                   	push   %ebx
  800417:	51                   	push   %ecx
  800418:	52                   	push   %edx
  800419:	50                   	push   %eax
  80041a:	e8 c5 13 00 00       	call   8017e4 <__umoddi3>
  80041f:	83 c4 10             	add    $0x10,%esp
  800422:	05 54 1c 80 00       	add    $0x801c54,%eax
  800427:	8a 00                	mov    (%eax),%al
  800429:	0f be c0             	movsbl %al,%eax
  80042c:	83 ec 08             	sub    $0x8,%esp
  80042f:	ff 75 0c             	pushl  0xc(%ebp)
  800432:	50                   	push   %eax
  800433:	8b 45 08             	mov    0x8(%ebp),%eax
  800436:	ff d0                	call   *%eax
  800438:	83 c4 10             	add    $0x10,%esp
}
  80043b:	90                   	nop
  80043c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80043f:	c9                   	leave  
  800440:	c3                   	ret    

00800441 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800441:	55                   	push   %ebp
  800442:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800444:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800448:	7e 1c                	jle    800466 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80044a:	8b 45 08             	mov    0x8(%ebp),%eax
  80044d:	8b 00                	mov    (%eax),%eax
  80044f:	8d 50 08             	lea    0x8(%eax),%edx
  800452:	8b 45 08             	mov    0x8(%ebp),%eax
  800455:	89 10                	mov    %edx,(%eax)
  800457:	8b 45 08             	mov    0x8(%ebp),%eax
  80045a:	8b 00                	mov    (%eax),%eax
  80045c:	83 e8 08             	sub    $0x8,%eax
  80045f:	8b 50 04             	mov    0x4(%eax),%edx
  800462:	8b 00                	mov    (%eax),%eax
  800464:	eb 40                	jmp    8004a6 <getuint+0x65>
	else if (lflag)
  800466:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80046a:	74 1e                	je     80048a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80046c:	8b 45 08             	mov    0x8(%ebp),%eax
  80046f:	8b 00                	mov    (%eax),%eax
  800471:	8d 50 04             	lea    0x4(%eax),%edx
  800474:	8b 45 08             	mov    0x8(%ebp),%eax
  800477:	89 10                	mov    %edx,(%eax)
  800479:	8b 45 08             	mov    0x8(%ebp),%eax
  80047c:	8b 00                	mov    (%eax),%eax
  80047e:	83 e8 04             	sub    $0x4,%eax
  800481:	8b 00                	mov    (%eax),%eax
  800483:	ba 00 00 00 00       	mov    $0x0,%edx
  800488:	eb 1c                	jmp    8004a6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80048a:	8b 45 08             	mov    0x8(%ebp),%eax
  80048d:	8b 00                	mov    (%eax),%eax
  80048f:	8d 50 04             	lea    0x4(%eax),%edx
  800492:	8b 45 08             	mov    0x8(%ebp),%eax
  800495:	89 10                	mov    %edx,(%eax)
  800497:	8b 45 08             	mov    0x8(%ebp),%eax
  80049a:	8b 00                	mov    (%eax),%eax
  80049c:	83 e8 04             	sub    $0x4,%eax
  80049f:	8b 00                	mov    (%eax),%eax
  8004a1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004a6:	5d                   	pop    %ebp
  8004a7:	c3                   	ret    

008004a8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004a8:	55                   	push   %ebp
  8004a9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004ab:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004af:	7e 1c                	jle    8004cd <getint+0x25>
		return va_arg(*ap, long long);
  8004b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b4:	8b 00                	mov    (%eax),%eax
  8004b6:	8d 50 08             	lea    0x8(%eax),%edx
  8004b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bc:	89 10                	mov    %edx,(%eax)
  8004be:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c1:	8b 00                	mov    (%eax),%eax
  8004c3:	83 e8 08             	sub    $0x8,%eax
  8004c6:	8b 50 04             	mov    0x4(%eax),%edx
  8004c9:	8b 00                	mov    (%eax),%eax
  8004cb:	eb 38                	jmp    800505 <getint+0x5d>
	else if (lflag)
  8004cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004d1:	74 1a                	je     8004ed <getint+0x45>
		return va_arg(*ap, long);
  8004d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d6:	8b 00                	mov    (%eax),%eax
  8004d8:	8d 50 04             	lea    0x4(%eax),%edx
  8004db:	8b 45 08             	mov    0x8(%ebp),%eax
  8004de:	89 10                	mov    %edx,(%eax)
  8004e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e3:	8b 00                	mov    (%eax),%eax
  8004e5:	83 e8 04             	sub    $0x4,%eax
  8004e8:	8b 00                	mov    (%eax),%eax
  8004ea:	99                   	cltd   
  8004eb:	eb 18                	jmp    800505 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f0:	8b 00                	mov    (%eax),%eax
  8004f2:	8d 50 04             	lea    0x4(%eax),%edx
  8004f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f8:	89 10                	mov    %edx,(%eax)
  8004fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fd:	8b 00                	mov    (%eax),%eax
  8004ff:	83 e8 04             	sub    $0x4,%eax
  800502:	8b 00                	mov    (%eax),%eax
  800504:	99                   	cltd   
}
  800505:	5d                   	pop    %ebp
  800506:	c3                   	ret    

00800507 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800507:	55                   	push   %ebp
  800508:	89 e5                	mov    %esp,%ebp
  80050a:	56                   	push   %esi
  80050b:	53                   	push   %ebx
  80050c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80050f:	eb 17                	jmp    800528 <vprintfmt+0x21>
			if (ch == '\0')
  800511:	85 db                	test   %ebx,%ebx
  800513:	0f 84 af 03 00 00    	je     8008c8 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800519:	83 ec 08             	sub    $0x8,%esp
  80051c:	ff 75 0c             	pushl  0xc(%ebp)
  80051f:	53                   	push   %ebx
  800520:	8b 45 08             	mov    0x8(%ebp),%eax
  800523:	ff d0                	call   *%eax
  800525:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800528:	8b 45 10             	mov    0x10(%ebp),%eax
  80052b:	8d 50 01             	lea    0x1(%eax),%edx
  80052e:	89 55 10             	mov    %edx,0x10(%ebp)
  800531:	8a 00                	mov    (%eax),%al
  800533:	0f b6 d8             	movzbl %al,%ebx
  800536:	83 fb 25             	cmp    $0x25,%ebx
  800539:	75 d6                	jne    800511 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80053b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80053f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800546:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80054d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800554:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80055b:	8b 45 10             	mov    0x10(%ebp),%eax
  80055e:	8d 50 01             	lea    0x1(%eax),%edx
  800561:	89 55 10             	mov    %edx,0x10(%ebp)
  800564:	8a 00                	mov    (%eax),%al
  800566:	0f b6 d8             	movzbl %al,%ebx
  800569:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80056c:	83 f8 55             	cmp    $0x55,%eax
  80056f:	0f 87 2b 03 00 00    	ja     8008a0 <vprintfmt+0x399>
  800575:	8b 04 85 78 1c 80 00 	mov    0x801c78(,%eax,4),%eax
  80057c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80057e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800582:	eb d7                	jmp    80055b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800584:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800588:	eb d1                	jmp    80055b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80058a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800591:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800594:	89 d0                	mov    %edx,%eax
  800596:	c1 e0 02             	shl    $0x2,%eax
  800599:	01 d0                	add    %edx,%eax
  80059b:	01 c0                	add    %eax,%eax
  80059d:	01 d8                	add    %ebx,%eax
  80059f:	83 e8 30             	sub    $0x30,%eax
  8005a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8005a8:	8a 00                	mov    (%eax),%al
  8005aa:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8005ad:	83 fb 2f             	cmp    $0x2f,%ebx
  8005b0:	7e 3e                	jle    8005f0 <vprintfmt+0xe9>
  8005b2:	83 fb 39             	cmp    $0x39,%ebx
  8005b5:	7f 39                	jg     8005f0 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005b7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005ba:	eb d5                	jmp    800591 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8005bf:	83 c0 04             	add    $0x4,%eax
  8005c2:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c8:	83 e8 04             	sub    $0x4,%eax
  8005cb:	8b 00                	mov    (%eax),%eax
  8005cd:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005d0:	eb 1f                	jmp    8005f1 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005d6:	79 83                	jns    80055b <vprintfmt+0x54>
				width = 0;
  8005d8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005df:	e9 77 ff ff ff       	jmp    80055b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005e4:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005eb:	e9 6b ff ff ff       	jmp    80055b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005f0:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005f1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005f5:	0f 89 60 ff ff ff    	jns    80055b <vprintfmt+0x54>
				width = precision, precision = -1;
  8005fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800601:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800608:	e9 4e ff ff ff       	jmp    80055b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80060d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800610:	e9 46 ff ff ff       	jmp    80055b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800615:	8b 45 14             	mov    0x14(%ebp),%eax
  800618:	83 c0 04             	add    $0x4,%eax
  80061b:	89 45 14             	mov    %eax,0x14(%ebp)
  80061e:	8b 45 14             	mov    0x14(%ebp),%eax
  800621:	83 e8 04             	sub    $0x4,%eax
  800624:	8b 00                	mov    (%eax),%eax
  800626:	83 ec 08             	sub    $0x8,%esp
  800629:	ff 75 0c             	pushl  0xc(%ebp)
  80062c:	50                   	push   %eax
  80062d:	8b 45 08             	mov    0x8(%ebp),%eax
  800630:	ff d0                	call   *%eax
  800632:	83 c4 10             	add    $0x10,%esp
			break;
  800635:	e9 89 02 00 00       	jmp    8008c3 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80063a:	8b 45 14             	mov    0x14(%ebp),%eax
  80063d:	83 c0 04             	add    $0x4,%eax
  800640:	89 45 14             	mov    %eax,0x14(%ebp)
  800643:	8b 45 14             	mov    0x14(%ebp),%eax
  800646:	83 e8 04             	sub    $0x4,%eax
  800649:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80064b:	85 db                	test   %ebx,%ebx
  80064d:	79 02                	jns    800651 <vprintfmt+0x14a>
				err = -err;
  80064f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800651:	83 fb 64             	cmp    $0x64,%ebx
  800654:	7f 0b                	jg     800661 <vprintfmt+0x15a>
  800656:	8b 34 9d c0 1a 80 00 	mov    0x801ac0(,%ebx,4),%esi
  80065d:	85 f6                	test   %esi,%esi
  80065f:	75 19                	jne    80067a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800661:	53                   	push   %ebx
  800662:	68 65 1c 80 00       	push   $0x801c65
  800667:	ff 75 0c             	pushl  0xc(%ebp)
  80066a:	ff 75 08             	pushl  0x8(%ebp)
  80066d:	e8 5e 02 00 00       	call   8008d0 <printfmt>
  800672:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800675:	e9 49 02 00 00       	jmp    8008c3 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80067a:	56                   	push   %esi
  80067b:	68 6e 1c 80 00       	push   $0x801c6e
  800680:	ff 75 0c             	pushl  0xc(%ebp)
  800683:	ff 75 08             	pushl  0x8(%ebp)
  800686:	e8 45 02 00 00       	call   8008d0 <printfmt>
  80068b:	83 c4 10             	add    $0x10,%esp
			break;
  80068e:	e9 30 02 00 00       	jmp    8008c3 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800693:	8b 45 14             	mov    0x14(%ebp),%eax
  800696:	83 c0 04             	add    $0x4,%eax
  800699:	89 45 14             	mov    %eax,0x14(%ebp)
  80069c:	8b 45 14             	mov    0x14(%ebp),%eax
  80069f:	83 e8 04             	sub    $0x4,%eax
  8006a2:	8b 30                	mov    (%eax),%esi
  8006a4:	85 f6                	test   %esi,%esi
  8006a6:	75 05                	jne    8006ad <vprintfmt+0x1a6>
				p = "(null)";
  8006a8:	be 71 1c 80 00       	mov    $0x801c71,%esi
			if (width > 0 && padc != '-')
  8006ad:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006b1:	7e 6d                	jle    800720 <vprintfmt+0x219>
  8006b3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006b7:	74 67                	je     800720 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006bc:	83 ec 08             	sub    $0x8,%esp
  8006bf:	50                   	push   %eax
  8006c0:	56                   	push   %esi
  8006c1:	e8 0c 03 00 00       	call   8009d2 <strnlen>
  8006c6:	83 c4 10             	add    $0x10,%esp
  8006c9:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006cc:	eb 16                	jmp    8006e4 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006ce:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006d2:	83 ec 08             	sub    $0x8,%esp
  8006d5:	ff 75 0c             	pushl  0xc(%ebp)
  8006d8:	50                   	push   %eax
  8006d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dc:	ff d0                	call   *%eax
  8006de:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006e1:	ff 4d e4             	decl   -0x1c(%ebp)
  8006e4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006e8:	7f e4                	jg     8006ce <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006ea:	eb 34                	jmp    800720 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006ec:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006f0:	74 1c                	je     80070e <vprintfmt+0x207>
  8006f2:	83 fb 1f             	cmp    $0x1f,%ebx
  8006f5:	7e 05                	jle    8006fc <vprintfmt+0x1f5>
  8006f7:	83 fb 7e             	cmp    $0x7e,%ebx
  8006fa:	7e 12                	jle    80070e <vprintfmt+0x207>
					putch('?', putdat);
  8006fc:	83 ec 08             	sub    $0x8,%esp
  8006ff:	ff 75 0c             	pushl  0xc(%ebp)
  800702:	6a 3f                	push   $0x3f
  800704:	8b 45 08             	mov    0x8(%ebp),%eax
  800707:	ff d0                	call   *%eax
  800709:	83 c4 10             	add    $0x10,%esp
  80070c:	eb 0f                	jmp    80071d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80070e:	83 ec 08             	sub    $0x8,%esp
  800711:	ff 75 0c             	pushl  0xc(%ebp)
  800714:	53                   	push   %ebx
  800715:	8b 45 08             	mov    0x8(%ebp),%eax
  800718:	ff d0                	call   *%eax
  80071a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80071d:	ff 4d e4             	decl   -0x1c(%ebp)
  800720:	89 f0                	mov    %esi,%eax
  800722:	8d 70 01             	lea    0x1(%eax),%esi
  800725:	8a 00                	mov    (%eax),%al
  800727:	0f be d8             	movsbl %al,%ebx
  80072a:	85 db                	test   %ebx,%ebx
  80072c:	74 24                	je     800752 <vprintfmt+0x24b>
  80072e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800732:	78 b8                	js     8006ec <vprintfmt+0x1e5>
  800734:	ff 4d e0             	decl   -0x20(%ebp)
  800737:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80073b:	79 af                	jns    8006ec <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80073d:	eb 13                	jmp    800752 <vprintfmt+0x24b>
				putch(' ', putdat);
  80073f:	83 ec 08             	sub    $0x8,%esp
  800742:	ff 75 0c             	pushl  0xc(%ebp)
  800745:	6a 20                	push   $0x20
  800747:	8b 45 08             	mov    0x8(%ebp),%eax
  80074a:	ff d0                	call   *%eax
  80074c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80074f:	ff 4d e4             	decl   -0x1c(%ebp)
  800752:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800756:	7f e7                	jg     80073f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800758:	e9 66 01 00 00       	jmp    8008c3 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80075d:	83 ec 08             	sub    $0x8,%esp
  800760:	ff 75 e8             	pushl  -0x18(%ebp)
  800763:	8d 45 14             	lea    0x14(%ebp),%eax
  800766:	50                   	push   %eax
  800767:	e8 3c fd ff ff       	call   8004a8 <getint>
  80076c:	83 c4 10             	add    $0x10,%esp
  80076f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800772:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800775:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800778:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80077b:	85 d2                	test   %edx,%edx
  80077d:	79 23                	jns    8007a2 <vprintfmt+0x29b>
				putch('-', putdat);
  80077f:	83 ec 08             	sub    $0x8,%esp
  800782:	ff 75 0c             	pushl  0xc(%ebp)
  800785:	6a 2d                	push   $0x2d
  800787:	8b 45 08             	mov    0x8(%ebp),%eax
  80078a:	ff d0                	call   *%eax
  80078c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80078f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800792:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800795:	f7 d8                	neg    %eax
  800797:	83 d2 00             	adc    $0x0,%edx
  80079a:	f7 da                	neg    %edx
  80079c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80079f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007a2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007a9:	e9 bc 00 00 00       	jmp    80086a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8007ae:	83 ec 08             	sub    $0x8,%esp
  8007b1:	ff 75 e8             	pushl  -0x18(%ebp)
  8007b4:	8d 45 14             	lea    0x14(%ebp),%eax
  8007b7:	50                   	push   %eax
  8007b8:	e8 84 fc ff ff       	call   800441 <getuint>
  8007bd:	83 c4 10             	add    $0x10,%esp
  8007c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007c6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007cd:	e9 98 00 00 00       	jmp    80086a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
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
			putch('X', putdat);
  8007f2:	83 ec 08             	sub    $0x8,%esp
  8007f5:	ff 75 0c             	pushl  0xc(%ebp)
  8007f8:	6a 58                	push   $0x58
  8007fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fd:	ff d0                	call   *%eax
  8007ff:	83 c4 10             	add    $0x10,%esp
			break;
  800802:	e9 bc 00 00 00       	jmp    8008c3 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800807:	83 ec 08             	sub    $0x8,%esp
  80080a:	ff 75 0c             	pushl  0xc(%ebp)
  80080d:	6a 30                	push   $0x30
  80080f:	8b 45 08             	mov    0x8(%ebp),%eax
  800812:	ff d0                	call   *%eax
  800814:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800817:	83 ec 08             	sub    $0x8,%esp
  80081a:	ff 75 0c             	pushl  0xc(%ebp)
  80081d:	6a 78                	push   $0x78
  80081f:	8b 45 08             	mov    0x8(%ebp),%eax
  800822:	ff d0                	call   *%eax
  800824:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800827:	8b 45 14             	mov    0x14(%ebp),%eax
  80082a:	83 c0 04             	add    $0x4,%eax
  80082d:	89 45 14             	mov    %eax,0x14(%ebp)
  800830:	8b 45 14             	mov    0x14(%ebp),%eax
  800833:	83 e8 04             	sub    $0x4,%eax
  800836:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800838:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80083b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800842:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800849:	eb 1f                	jmp    80086a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80084b:	83 ec 08             	sub    $0x8,%esp
  80084e:	ff 75 e8             	pushl  -0x18(%ebp)
  800851:	8d 45 14             	lea    0x14(%ebp),%eax
  800854:	50                   	push   %eax
  800855:	e8 e7 fb ff ff       	call   800441 <getuint>
  80085a:	83 c4 10             	add    $0x10,%esp
  80085d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800860:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800863:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80086a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80086e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800871:	83 ec 04             	sub    $0x4,%esp
  800874:	52                   	push   %edx
  800875:	ff 75 e4             	pushl  -0x1c(%ebp)
  800878:	50                   	push   %eax
  800879:	ff 75 f4             	pushl  -0xc(%ebp)
  80087c:	ff 75 f0             	pushl  -0x10(%ebp)
  80087f:	ff 75 0c             	pushl  0xc(%ebp)
  800882:	ff 75 08             	pushl  0x8(%ebp)
  800885:	e8 00 fb ff ff       	call   80038a <printnum>
  80088a:	83 c4 20             	add    $0x20,%esp
			break;
  80088d:	eb 34                	jmp    8008c3 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80088f:	83 ec 08             	sub    $0x8,%esp
  800892:	ff 75 0c             	pushl  0xc(%ebp)
  800895:	53                   	push   %ebx
  800896:	8b 45 08             	mov    0x8(%ebp),%eax
  800899:	ff d0                	call   *%eax
  80089b:	83 c4 10             	add    $0x10,%esp
			break;
  80089e:	eb 23                	jmp    8008c3 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008a0:	83 ec 08             	sub    $0x8,%esp
  8008a3:	ff 75 0c             	pushl  0xc(%ebp)
  8008a6:	6a 25                	push   $0x25
  8008a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ab:	ff d0                	call   *%eax
  8008ad:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008b0:	ff 4d 10             	decl   0x10(%ebp)
  8008b3:	eb 03                	jmp    8008b8 <vprintfmt+0x3b1>
  8008b5:	ff 4d 10             	decl   0x10(%ebp)
  8008b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8008bb:	48                   	dec    %eax
  8008bc:	8a 00                	mov    (%eax),%al
  8008be:	3c 25                	cmp    $0x25,%al
  8008c0:	75 f3                	jne    8008b5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008c2:	90                   	nop
		}
	}
  8008c3:	e9 47 fc ff ff       	jmp    80050f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008c8:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008c9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008cc:	5b                   	pop    %ebx
  8008cd:	5e                   	pop    %esi
  8008ce:	5d                   	pop    %ebp
  8008cf:	c3                   	ret    

008008d0 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008d0:	55                   	push   %ebp
  8008d1:	89 e5                	mov    %esp,%ebp
  8008d3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008d6:	8d 45 10             	lea    0x10(%ebp),%eax
  8008d9:	83 c0 04             	add    $0x4,%eax
  8008dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008df:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e2:	ff 75 f4             	pushl  -0xc(%ebp)
  8008e5:	50                   	push   %eax
  8008e6:	ff 75 0c             	pushl  0xc(%ebp)
  8008e9:	ff 75 08             	pushl  0x8(%ebp)
  8008ec:	e8 16 fc ff ff       	call   800507 <vprintfmt>
  8008f1:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008f4:	90                   	nop
  8008f5:	c9                   	leave  
  8008f6:	c3                   	ret    

008008f7 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008f7:	55                   	push   %ebp
  8008f8:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fd:	8b 40 08             	mov    0x8(%eax),%eax
  800900:	8d 50 01             	lea    0x1(%eax),%edx
  800903:	8b 45 0c             	mov    0xc(%ebp),%eax
  800906:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800909:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090c:	8b 10                	mov    (%eax),%edx
  80090e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800911:	8b 40 04             	mov    0x4(%eax),%eax
  800914:	39 c2                	cmp    %eax,%edx
  800916:	73 12                	jae    80092a <sprintputch+0x33>
		*b->buf++ = ch;
  800918:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091b:	8b 00                	mov    (%eax),%eax
  80091d:	8d 48 01             	lea    0x1(%eax),%ecx
  800920:	8b 55 0c             	mov    0xc(%ebp),%edx
  800923:	89 0a                	mov    %ecx,(%edx)
  800925:	8b 55 08             	mov    0x8(%ebp),%edx
  800928:	88 10                	mov    %dl,(%eax)
}
  80092a:	90                   	nop
  80092b:	5d                   	pop    %ebp
  80092c:	c3                   	ret    

0080092d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80092d:	55                   	push   %ebp
  80092e:	89 e5                	mov    %esp,%ebp
  800930:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800933:	8b 45 08             	mov    0x8(%ebp),%eax
  800936:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800939:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	01 d0                	add    %edx,%eax
  800944:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800947:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80094e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800952:	74 06                	je     80095a <vsnprintf+0x2d>
  800954:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800958:	7f 07                	jg     800961 <vsnprintf+0x34>
		return -E_INVAL;
  80095a:	b8 03 00 00 00       	mov    $0x3,%eax
  80095f:	eb 20                	jmp    800981 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800961:	ff 75 14             	pushl  0x14(%ebp)
  800964:	ff 75 10             	pushl  0x10(%ebp)
  800967:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80096a:	50                   	push   %eax
  80096b:	68 f7 08 80 00       	push   $0x8008f7
  800970:	e8 92 fb ff ff       	call   800507 <vprintfmt>
  800975:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800978:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80097b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80097e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800981:	c9                   	leave  
  800982:	c3                   	ret    

00800983 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800983:	55                   	push   %ebp
  800984:	89 e5                	mov    %esp,%ebp
  800986:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800989:	8d 45 10             	lea    0x10(%ebp),%eax
  80098c:	83 c0 04             	add    $0x4,%eax
  80098f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800992:	8b 45 10             	mov    0x10(%ebp),%eax
  800995:	ff 75 f4             	pushl  -0xc(%ebp)
  800998:	50                   	push   %eax
  800999:	ff 75 0c             	pushl  0xc(%ebp)
  80099c:	ff 75 08             	pushl  0x8(%ebp)
  80099f:	e8 89 ff ff ff       	call   80092d <vsnprintf>
  8009a4:	83 c4 10             	add    $0x10,%esp
  8009a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009ad:	c9                   	leave  
  8009ae:	c3                   	ret    

008009af <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8009af:	55                   	push   %ebp
  8009b0:	89 e5                	mov    %esp,%ebp
  8009b2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009bc:	eb 06                	jmp    8009c4 <strlen+0x15>
		n++;
  8009be:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009c1:	ff 45 08             	incl   0x8(%ebp)
  8009c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c7:	8a 00                	mov    (%eax),%al
  8009c9:	84 c0                	test   %al,%al
  8009cb:	75 f1                	jne    8009be <strlen+0xf>
		n++;
	return n;
  8009cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009d0:	c9                   	leave  
  8009d1:	c3                   	ret    

008009d2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009d2:	55                   	push   %ebp
  8009d3:	89 e5                	mov    %esp,%ebp
  8009d5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009df:	eb 09                	jmp    8009ea <strnlen+0x18>
		n++;
  8009e1:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009e4:	ff 45 08             	incl   0x8(%ebp)
  8009e7:	ff 4d 0c             	decl   0xc(%ebp)
  8009ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009ee:	74 09                	je     8009f9 <strnlen+0x27>
  8009f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f3:	8a 00                	mov    (%eax),%al
  8009f5:	84 c0                	test   %al,%al
  8009f7:	75 e8                	jne    8009e1 <strnlen+0xf>
		n++;
	return n;
  8009f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009fc:	c9                   	leave  
  8009fd:	c3                   	ret    

008009fe <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009fe:	55                   	push   %ebp
  8009ff:	89 e5                	mov    %esp,%ebp
  800a01:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a04:	8b 45 08             	mov    0x8(%ebp),%eax
  800a07:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a0a:	90                   	nop
  800a0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0e:	8d 50 01             	lea    0x1(%eax),%edx
  800a11:	89 55 08             	mov    %edx,0x8(%ebp)
  800a14:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a17:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a1a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a1d:	8a 12                	mov    (%edx),%dl
  800a1f:	88 10                	mov    %dl,(%eax)
  800a21:	8a 00                	mov    (%eax),%al
  800a23:	84 c0                	test   %al,%al
  800a25:	75 e4                	jne    800a0b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a27:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a2a:	c9                   	leave  
  800a2b:	c3                   	ret    

00800a2c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a2c:	55                   	push   %ebp
  800a2d:	89 e5                	mov    %esp,%ebp
  800a2f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a32:	8b 45 08             	mov    0x8(%ebp),%eax
  800a35:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a38:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a3f:	eb 1f                	jmp    800a60 <strncpy+0x34>
		*dst++ = *src;
  800a41:	8b 45 08             	mov    0x8(%ebp),%eax
  800a44:	8d 50 01             	lea    0x1(%eax),%edx
  800a47:	89 55 08             	mov    %edx,0x8(%ebp)
  800a4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a4d:	8a 12                	mov    (%edx),%dl
  800a4f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a54:	8a 00                	mov    (%eax),%al
  800a56:	84 c0                	test   %al,%al
  800a58:	74 03                	je     800a5d <strncpy+0x31>
			src++;
  800a5a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a5d:	ff 45 fc             	incl   -0x4(%ebp)
  800a60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a63:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a66:	72 d9                	jb     800a41 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a68:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a6b:	c9                   	leave  
  800a6c:	c3                   	ret    

00800a6d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a6d:	55                   	push   %ebp
  800a6e:	89 e5                	mov    %esp,%ebp
  800a70:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a73:	8b 45 08             	mov    0x8(%ebp),%eax
  800a76:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a79:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a7d:	74 30                	je     800aaf <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a7f:	eb 16                	jmp    800a97 <strlcpy+0x2a>
			*dst++ = *src++;
  800a81:	8b 45 08             	mov    0x8(%ebp),%eax
  800a84:	8d 50 01             	lea    0x1(%eax),%edx
  800a87:	89 55 08             	mov    %edx,0x8(%ebp)
  800a8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a8d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a90:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a93:	8a 12                	mov    (%edx),%dl
  800a95:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a97:	ff 4d 10             	decl   0x10(%ebp)
  800a9a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a9e:	74 09                	je     800aa9 <strlcpy+0x3c>
  800aa0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa3:	8a 00                	mov    (%eax),%al
  800aa5:	84 c0                	test   %al,%al
  800aa7:	75 d8                	jne    800a81 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aac:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800aaf:	8b 55 08             	mov    0x8(%ebp),%edx
  800ab2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ab5:	29 c2                	sub    %eax,%edx
  800ab7:	89 d0                	mov    %edx,%eax
}
  800ab9:	c9                   	leave  
  800aba:	c3                   	ret    

00800abb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800abb:	55                   	push   %ebp
  800abc:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800abe:	eb 06                	jmp    800ac6 <strcmp+0xb>
		p++, q++;
  800ac0:	ff 45 08             	incl   0x8(%ebp)
  800ac3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	8a 00                	mov    (%eax),%al
  800acb:	84 c0                	test   %al,%al
  800acd:	74 0e                	je     800add <strcmp+0x22>
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad2:	8a 10                	mov    (%eax),%dl
  800ad4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad7:	8a 00                	mov    (%eax),%al
  800ad9:	38 c2                	cmp    %al,%dl
  800adb:	74 e3                	je     800ac0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800add:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae0:	8a 00                	mov    (%eax),%al
  800ae2:	0f b6 d0             	movzbl %al,%edx
  800ae5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae8:	8a 00                	mov    (%eax),%al
  800aea:	0f b6 c0             	movzbl %al,%eax
  800aed:	29 c2                	sub    %eax,%edx
  800aef:	89 d0                	mov    %edx,%eax
}
  800af1:	5d                   	pop    %ebp
  800af2:	c3                   	ret    

00800af3 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800af3:	55                   	push   %ebp
  800af4:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800af6:	eb 09                	jmp    800b01 <strncmp+0xe>
		n--, p++, q++;
  800af8:	ff 4d 10             	decl   0x10(%ebp)
  800afb:	ff 45 08             	incl   0x8(%ebp)
  800afe:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b01:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b05:	74 17                	je     800b1e <strncmp+0x2b>
  800b07:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0a:	8a 00                	mov    (%eax),%al
  800b0c:	84 c0                	test   %al,%al
  800b0e:	74 0e                	je     800b1e <strncmp+0x2b>
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	8a 10                	mov    (%eax),%dl
  800b15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b18:	8a 00                	mov    (%eax),%al
  800b1a:	38 c2                	cmp    %al,%dl
  800b1c:	74 da                	je     800af8 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b1e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b22:	75 07                	jne    800b2b <strncmp+0x38>
		return 0;
  800b24:	b8 00 00 00 00       	mov    $0x0,%eax
  800b29:	eb 14                	jmp    800b3f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	8a 00                	mov    (%eax),%al
  800b30:	0f b6 d0             	movzbl %al,%edx
  800b33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b36:	8a 00                	mov    (%eax),%al
  800b38:	0f b6 c0             	movzbl %al,%eax
  800b3b:	29 c2                	sub    %eax,%edx
  800b3d:	89 d0                	mov    %edx,%eax
}
  800b3f:	5d                   	pop    %ebp
  800b40:	c3                   	ret    

00800b41 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b41:	55                   	push   %ebp
  800b42:	89 e5                	mov    %esp,%ebp
  800b44:	83 ec 04             	sub    $0x4,%esp
  800b47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b4d:	eb 12                	jmp    800b61 <strchr+0x20>
		if (*s == c)
  800b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b52:	8a 00                	mov    (%eax),%al
  800b54:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b57:	75 05                	jne    800b5e <strchr+0x1d>
			return (char *) s;
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5c:	eb 11                	jmp    800b6f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b5e:	ff 45 08             	incl   0x8(%ebp)
  800b61:	8b 45 08             	mov    0x8(%ebp),%eax
  800b64:	8a 00                	mov    (%eax),%al
  800b66:	84 c0                	test   %al,%al
  800b68:	75 e5                	jne    800b4f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b6a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b6f:	c9                   	leave  
  800b70:	c3                   	ret    

00800b71 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b71:	55                   	push   %ebp
  800b72:	89 e5                	mov    %esp,%ebp
  800b74:	83 ec 04             	sub    $0x4,%esp
  800b77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b7d:	eb 0d                	jmp    800b8c <strfind+0x1b>
		if (*s == c)
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	8a 00                	mov    (%eax),%al
  800b84:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b87:	74 0e                	je     800b97 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b89:	ff 45 08             	incl   0x8(%ebp)
  800b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8f:	8a 00                	mov    (%eax),%al
  800b91:	84 c0                	test   %al,%al
  800b93:	75 ea                	jne    800b7f <strfind+0xe>
  800b95:	eb 01                	jmp    800b98 <strfind+0x27>
		if (*s == c)
			break;
  800b97:	90                   	nop
	return (char *) s;
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b9b:	c9                   	leave  
  800b9c:	c3                   	ret    

00800b9d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b9d:	55                   	push   %ebp
  800b9e:	89 e5                	mov    %esp,%ebp
  800ba0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ba9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bac:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800baf:	eb 0e                	jmp    800bbf <memset+0x22>
		*p++ = c;
  800bb1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb4:	8d 50 01             	lea    0x1(%eax),%edx
  800bb7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800bba:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bbd:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800bbf:	ff 4d f8             	decl   -0x8(%ebp)
  800bc2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bc6:	79 e9                	jns    800bb1 <memset+0x14>
		*p++ = c;

	return v;
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bcb:	c9                   	leave  
  800bcc:	c3                   	ret    

00800bcd <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bcd:	55                   	push   %ebp
  800bce:	89 e5                	mov    %esp,%ebp
  800bd0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800bdf:	eb 16                	jmp    800bf7 <memcpy+0x2a>
		*d++ = *s++;
  800be1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800be4:	8d 50 01             	lea    0x1(%eax),%edx
  800be7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bea:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bed:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bf0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bf3:	8a 12                	mov    (%edx),%dl
  800bf5:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800bf7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfa:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bfd:	89 55 10             	mov    %edx,0x10(%ebp)
  800c00:	85 c0                	test   %eax,%eax
  800c02:	75 dd                	jne    800be1 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c04:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c07:	c9                   	leave  
  800c08:	c3                   	ret    

00800c09 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c09:	55                   	push   %ebp
  800c0a:	89 e5                	mov    %esp,%ebp
  800c0c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800c0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c15:	8b 45 08             	mov    0x8(%ebp),%eax
  800c18:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c1e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c21:	73 50                	jae    800c73 <memmove+0x6a>
  800c23:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c26:	8b 45 10             	mov    0x10(%ebp),%eax
  800c29:	01 d0                	add    %edx,%eax
  800c2b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c2e:	76 43                	jbe    800c73 <memmove+0x6a>
		s += n;
  800c30:	8b 45 10             	mov    0x10(%ebp),%eax
  800c33:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c36:	8b 45 10             	mov    0x10(%ebp),%eax
  800c39:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c3c:	eb 10                	jmp    800c4e <memmove+0x45>
			*--d = *--s;
  800c3e:	ff 4d f8             	decl   -0x8(%ebp)
  800c41:	ff 4d fc             	decl   -0x4(%ebp)
  800c44:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c47:	8a 10                	mov    (%eax),%dl
  800c49:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c4c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c51:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c54:	89 55 10             	mov    %edx,0x10(%ebp)
  800c57:	85 c0                	test   %eax,%eax
  800c59:	75 e3                	jne    800c3e <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c5b:	eb 23                	jmp    800c80 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c60:	8d 50 01             	lea    0x1(%eax),%edx
  800c63:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c66:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c69:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c6c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c6f:	8a 12                	mov    (%edx),%dl
  800c71:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c73:	8b 45 10             	mov    0x10(%ebp),%eax
  800c76:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c79:	89 55 10             	mov    %edx,0x10(%ebp)
  800c7c:	85 c0                	test   %eax,%eax
  800c7e:	75 dd                	jne    800c5d <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c83:	c9                   	leave  
  800c84:	c3                   	ret    

00800c85 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c85:	55                   	push   %ebp
  800c86:	89 e5                	mov    %esp,%ebp
  800c88:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c94:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c97:	eb 2a                	jmp    800cc3 <memcmp+0x3e>
		if (*s1 != *s2)
  800c99:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c9c:	8a 10                	mov    (%eax),%dl
  800c9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ca1:	8a 00                	mov    (%eax),%al
  800ca3:	38 c2                	cmp    %al,%dl
  800ca5:	74 16                	je     800cbd <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ca7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800caa:	8a 00                	mov    (%eax),%al
  800cac:	0f b6 d0             	movzbl %al,%edx
  800caf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cb2:	8a 00                	mov    (%eax),%al
  800cb4:	0f b6 c0             	movzbl %al,%eax
  800cb7:	29 c2                	sub    %eax,%edx
  800cb9:	89 d0                	mov    %edx,%eax
  800cbb:	eb 18                	jmp    800cd5 <memcmp+0x50>
		s1++, s2++;
  800cbd:	ff 45 fc             	incl   -0x4(%ebp)
  800cc0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800cc3:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cc9:	89 55 10             	mov    %edx,0x10(%ebp)
  800ccc:	85 c0                	test   %eax,%eax
  800cce:	75 c9                	jne    800c99 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800cd0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cd5:	c9                   	leave  
  800cd6:	c3                   	ret    

00800cd7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800cd7:	55                   	push   %ebp
  800cd8:	89 e5                	mov    %esp,%ebp
  800cda:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800cdd:	8b 55 08             	mov    0x8(%ebp),%edx
  800ce0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce3:	01 d0                	add    %edx,%eax
  800ce5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ce8:	eb 15                	jmp    800cff <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	8a 00                	mov    (%eax),%al
  800cef:	0f b6 d0             	movzbl %al,%edx
  800cf2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf5:	0f b6 c0             	movzbl %al,%eax
  800cf8:	39 c2                	cmp    %eax,%edx
  800cfa:	74 0d                	je     800d09 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800cfc:	ff 45 08             	incl   0x8(%ebp)
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d05:	72 e3                	jb     800cea <memfind+0x13>
  800d07:	eb 01                	jmp    800d0a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d09:	90                   	nop
	return (void *) s;
  800d0a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d0d:	c9                   	leave  
  800d0e:	c3                   	ret    

00800d0f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d0f:	55                   	push   %ebp
  800d10:	89 e5                	mov    %esp,%ebp
  800d12:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d15:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d1c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d23:	eb 03                	jmp    800d28 <strtol+0x19>
		s++;
  800d25:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	8a 00                	mov    (%eax),%al
  800d2d:	3c 20                	cmp    $0x20,%al
  800d2f:	74 f4                	je     800d25 <strtol+0x16>
  800d31:	8b 45 08             	mov    0x8(%ebp),%eax
  800d34:	8a 00                	mov    (%eax),%al
  800d36:	3c 09                	cmp    $0x9,%al
  800d38:	74 eb                	je     800d25 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	8a 00                	mov    (%eax),%al
  800d3f:	3c 2b                	cmp    $0x2b,%al
  800d41:	75 05                	jne    800d48 <strtol+0x39>
		s++;
  800d43:	ff 45 08             	incl   0x8(%ebp)
  800d46:	eb 13                	jmp    800d5b <strtol+0x4c>
	else if (*s == '-')
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	8a 00                	mov    (%eax),%al
  800d4d:	3c 2d                	cmp    $0x2d,%al
  800d4f:	75 0a                	jne    800d5b <strtol+0x4c>
		s++, neg = 1;
  800d51:	ff 45 08             	incl   0x8(%ebp)
  800d54:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d5b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d5f:	74 06                	je     800d67 <strtol+0x58>
  800d61:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d65:	75 20                	jne    800d87 <strtol+0x78>
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6a:	8a 00                	mov    (%eax),%al
  800d6c:	3c 30                	cmp    $0x30,%al
  800d6e:	75 17                	jne    800d87 <strtol+0x78>
  800d70:	8b 45 08             	mov    0x8(%ebp),%eax
  800d73:	40                   	inc    %eax
  800d74:	8a 00                	mov    (%eax),%al
  800d76:	3c 78                	cmp    $0x78,%al
  800d78:	75 0d                	jne    800d87 <strtol+0x78>
		s += 2, base = 16;
  800d7a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d7e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d85:	eb 28                	jmp    800daf <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d87:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d8b:	75 15                	jne    800da2 <strtol+0x93>
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	8a 00                	mov    (%eax),%al
  800d92:	3c 30                	cmp    $0x30,%al
  800d94:	75 0c                	jne    800da2 <strtol+0x93>
		s++, base = 8;
  800d96:	ff 45 08             	incl   0x8(%ebp)
  800d99:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800da0:	eb 0d                	jmp    800daf <strtol+0xa0>
	else if (base == 0)
  800da2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800da6:	75 07                	jne    800daf <strtol+0xa0>
		base = 10;
  800da8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800daf:	8b 45 08             	mov    0x8(%ebp),%eax
  800db2:	8a 00                	mov    (%eax),%al
  800db4:	3c 2f                	cmp    $0x2f,%al
  800db6:	7e 19                	jle    800dd1 <strtol+0xc2>
  800db8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbb:	8a 00                	mov    (%eax),%al
  800dbd:	3c 39                	cmp    $0x39,%al
  800dbf:	7f 10                	jg     800dd1 <strtol+0xc2>
			dig = *s - '0';
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	8a 00                	mov    (%eax),%al
  800dc6:	0f be c0             	movsbl %al,%eax
  800dc9:	83 e8 30             	sub    $0x30,%eax
  800dcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dcf:	eb 42                	jmp    800e13 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd4:	8a 00                	mov    (%eax),%al
  800dd6:	3c 60                	cmp    $0x60,%al
  800dd8:	7e 19                	jle    800df3 <strtol+0xe4>
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	8a 00                	mov    (%eax),%al
  800ddf:	3c 7a                	cmp    $0x7a,%al
  800de1:	7f 10                	jg     800df3 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	8a 00                	mov    (%eax),%al
  800de8:	0f be c0             	movsbl %al,%eax
  800deb:	83 e8 57             	sub    $0x57,%eax
  800dee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800df1:	eb 20                	jmp    800e13 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	8a 00                	mov    (%eax),%al
  800df8:	3c 40                	cmp    $0x40,%al
  800dfa:	7e 39                	jle    800e35 <strtol+0x126>
  800dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dff:	8a 00                	mov    (%eax),%al
  800e01:	3c 5a                	cmp    $0x5a,%al
  800e03:	7f 30                	jg     800e35 <strtol+0x126>
			dig = *s - 'A' + 10;
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
  800e08:	8a 00                	mov    (%eax),%al
  800e0a:	0f be c0             	movsbl %al,%eax
  800e0d:	83 e8 37             	sub    $0x37,%eax
  800e10:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e13:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e16:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e19:	7d 19                	jge    800e34 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e1b:	ff 45 08             	incl   0x8(%ebp)
  800e1e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e21:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e25:	89 c2                	mov    %eax,%edx
  800e27:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e2a:	01 d0                	add    %edx,%eax
  800e2c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e2f:	e9 7b ff ff ff       	jmp    800daf <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e34:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e35:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e39:	74 08                	je     800e43 <strtol+0x134>
		*endptr = (char *) s;
  800e3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3e:	8b 55 08             	mov    0x8(%ebp),%edx
  800e41:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e43:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e47:	74 07                	je     800e50 <strtol+0x141>
  800e49:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e4c:	f7 d8                	neg    %eax
  800e4e:	eb 03                	jmp    800e53 <strtol+0x144>
  800e50:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e53:	c9                   	leave  
  800e54:	c3                   	ret    

00800e55 <ltostr>:

void
ltostr(long value, char *str)
{
  800e55:	55                   	push   %ebp
  800e56:	89 e5                	mov    %esp,%ebp
  800e58:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e5b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e62:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e69:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e6d:	79 13                	jns    800e82 <ltostr+0x2d>
	{
		neg = 1;
  800e6f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e79:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e7c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e7f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e8a:	99                   	cltd   
  800e8b:	f7 f9                	idiv   %ecx
  800e8d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e90:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e93:	8d 50 01             	lea    0x1(%eax),%edx
  800e96:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e99:	89 c2                	mov    %eax,%edx
  800e9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9e:	01 d0                	add    %edx,%eax
  800ea0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ea3:	83 c2 30             	add    $0x30,%edx
  800ea6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800ea8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800eab:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800eb0:	f7 e9                	imul   %ecx
  800eb2:	c1 fa 02             	sar    $0x2,%edx
  800eb5:	89 c8                	mov    %ecx,%eax
  800eb7:	c1 f8 1f             	sar    $0x1f,%eax
  800eba:	29 c2                	sub    %eax,%edx
  800ebc:	89 d0                	mov    %edx,%eax
  800ebe:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ec1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ec4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ec9:	f7 e9                	imul   %ecx
  800ecb:	c1 fa 02             	sar    $0x2,%edx
  800ece:	89 c8                	mov    %ecx,%eax
  800ed0:	c1 f8 1f             	sar    $0x1f,%eax
  800ed3:	29 c2                	sub    %eax,%edx
  800ed5:	89 d0                	mov    %edx,%eax
  800ed7:	c1 e0 02             	shl    $0x2,%eax
  800eda:	01 d0                	add    %edx,%eax
  800edc:	01 c0                	add    %eax,%eax
  800ede:	29 c1                	sub    %eax,%ecx
  800ee0:	89 ca                	mov    %ecx,%edx
  800ee2:	85 d2                	test   %edx,%edx
  800ee4:	75 9c                	jne    800e82 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800ee6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800eed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef0:	48                   	dec    %eax
  800ef1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800ef4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ef8:	74 3d                	je     800f37 <ltostr+0xe2>
		start = 1 ;
  800efa:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f01:	eb 34                	jmp    800f37 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f03:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f09:	01 d0                	add    %edx,%eax
  800f0b:	8a 00                	mov    (%eax),%al
  800f0d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f10:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f16:	01 c2                	add    %eax,%edx
  800f18:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1e:	01 c8                	add    %ecx,%eax
  800f20:	8a 00                	mov    (%eax),%al
  800f22:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f24:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2a:	01 c2                	add    %eax,%edx
  800f2c:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f2f:	88 02                	mov    %al,(%edx)
		start++ ;
  800f31:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f34:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f37:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f3a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f3d:	7c c4                	jl     800f03 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f3f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f45:	01 d0                	add    %edx,%eax
  800f47:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f4a:	90                   	nop
  800f4b:	c9                   	leave  
  800f4c:	c3                   	ret    

00800f4d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f4d:	55                   	push   %ebp
  800f4e:	89 e5                	mov    %esp,%ebp
  800f50:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f53:	ff 75 08             	pushl  0x8(%ebp)
  800f56:	e8 54 fa ff ff       	call   8009af <strlen>
  800f5b:	83 c4 04             	add    $0x4,%esp
  800f5e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f61:	ff 75 0c             	pushl  0xc(%ebp)
  800f64:	e8 46 fa ff ff       	call   8009af <strlen>
  800f69:	83 c4 04             	add    $0x4,%esp
  800f6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f6f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f76:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f7d:	eb 17                	jmp    800f96 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f7f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f82:	8b 45 10             	mov    0x10(%ebp),%eax
  800f85:	01 c2                	add    %eax,%edx
  800f87:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	01 c8                	add    %ecx,%eax
  800f8f:	8a 00                	mov    (%eax),%al
  800f91:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f93:	ff 45 fc             	incl   -0x4(%ebp)
  800f96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f99:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f9c:	7c e1                	jl     800f7f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f9e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800fa5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800fac:	eb 1f                	jmp    800fcd <strcconcat+0x80>
		final[s++] = str2[i] ;
  800fae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fb1:	8d 50 01             	lea    0x1(%eax),%edx
  800fb4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fb7:	89 c2                	mov    %eax,%edx
  800fb9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbc:	01 c2                	add    %eax,%edx
  800fbe:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc4:	01 c8                	add    %ecx,%eax
  800fc6:	8a 00                	mov    (%eax),%al
  800fc8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fca:	ff 45 f8             	incl   -0x8(%ebp)
  800fcd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fd3:	7c d9                	jl     800fae <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fd5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fd8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdb:	01 d0                	add    %edx,%eax
  800fdd:	c6 00 00             	movb   $0x0,(%eax)
}
  800fe0:	90                   	nop
  800fe1:	c9                   	leave  
  800fe2:	c3                   	ret    

00800fe3 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fe3:	55                   	push   %ebp
  800fe4:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800fe6:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800fef:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff2:	8b 00                	mov    (%eax),%eax
  800ff4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ffb:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffe:	01 d0                	add    %edx,%eax
  801000:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801006:	eb 0c                	jmp    801014 <strsplit+0x31>
			*string++ = 0;
  801008:	8b 45 08             	mov    0x8(%ebp),%eax
  80100b:	8d 50 01             	lea    0x1(%eax),%edx
  80100e:	89 55 08             	mov    %edx,0x8(%ebp)
  801011:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801014:	8b 45 08             	mov    0x8(%ebp),%eax
  801017:	8a 00                	mov    (%eax),%al
  801019:	84 c0                	test   %al,%al
  80101b:	74 18                	je     801035 <strsplit+0x52>
  80101d:	8b 45 08             	mov    0x8(%ebp),%eax
  801020:	8a 00                	mov    (%eax),%al
  801022:	0f be c0             	movsbl %al,%eax
  801025:	50                   	push   %eax
  801026:	ff 75 0c             	pushl  0xc(%ebp)
  801029:	e8 13 fb ff ff       	call   800b41 <strchr>
  80102e:	83 c4 08             	add    $0x8,%esp
  801031:	85 c0                	test   %eax,%eax
  801033:	75 d3                	jne    801008 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	8a 00                	mov    (%eax),%al
  80103a:	84 c0                	test   %al,%al
  80103c:	74 5a                	je     801098 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80103e:	8b 45 14             	mov    0x14(%ebp),%eax
  801041:	8b 00                	mov    (%eax),%eax
  801043:	83 f8 0f             	cmp    $0xf,%eax
  801046:	75 07                	jne    80104f <strsplit+0x6c>
		{
			return 0;
  801048:	b8 00 00 00 00       	mov    $0x0,%eax
  80104d:	eb 66                	jmp    8010b5 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80104f:	8b 45 14             	mov    0x14(%ebp),%eax
  801052:	8b 00                	mov    (%eax),%eax
  801054:	8d 48 01             	lea    0x1(%eax),%ecx
  801057:	8b 55 14             	mov    0x14(%ebp),%edx
  80105a:	89 0a                	mov    %ecx,(%edx)
  80105c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801063:	8b 45 10             	mov    0x10(%ebp),%eax
  801066:	01 c2                	add    %eax,%edx
  801068:	8b 45 08             	mov    0x8(%ebp),%eax
  80106b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80106d:	eb 03                	jmp    801072 <strsplit+0x8f>
			string++;
  80106f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801072:	8b 45 08             	mov    0x8(%ebp),%eax
  801075:	8a 00                	mov    (%eax),%al
  801077:	84 c0                	test   %al,%al
  801079:	74 8b                	je     801006 <strsplit+0x23>
  80107b:	8b 45 08             	mov    0x8(%ebp),%eax
  80107e:	8a 00                	mov    (%eax),%al
  801080:	0f be c0             	movsbl %al,%eax
  801083:	50                   	push   %eax
  801084:	ff 75 0c             	pushl  0xc(%ebp)
  801087:	e8 b5 fa ff ff       	call   800b41 <strchr>
  80108c:	83 c4 08             	add    $0x8,%esp
  80108f:	85 c0                	test   %eax,%eax
  801091:	74 dc                	je     80106f <strsplit+0x8c>
			string++;
	}
  801093:	e9 6e ff ff ff       	jmp    801006 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801098:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801099:	8b 45 14             	mov    0x14(%ebp),%eax
  80109c:	8b 00                	mov    (%eax),%eax
  80109e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a8:	01 d0                	add    %edx,%eax
  8010aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8010b0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010b5:	c9                   	leave  
  8010b6:	c3                   	ret    

008010b7 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8010b7:	55                   	push   %ebp
  8010b8:	89 e5                	mov    %esp,%ebp
  8010ba:	57                   	push   %edi
  8010bb:	56                   	push   %esi
  8010bc:	53                   	push   %ebx
  8010bd:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8010c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010c9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010cc:	8b 7d 18             	mov    0x18(%ebp),%edi
  8010cf:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8010d2:	cd 30                	int    $0x30
  8010d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8010d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010da:	83 c4 10             	add    $0x10,%esp
  8010dd:	5b                   	pop    %ebx
  8010de:	5e                   	pop    %esi
  8010df:	5f                   	pop    %edi
  8010e0:	5d                   	pop    %ebp
  8010e1:	c3                   	ret    

008010e2 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8010e2:	55                   	push   %ebp
  8010e3:	89 e5                	mov    %esp,%ebp
  8010e5:	83 ec 04             	sub    $0x4,%esp
  8010e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8010eb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8010ee:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8010f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f5:	6a 00                	push   $0x0
  8010f7:	6a 00                	push   $0x0
  8010f9:	52                   	push   %edx
  8010fa:	ff 75 0c             	pushl  0xc(%ebp)
  8010fd:	50                   	push   %eax
  8010fe:	6a 00                	push   $0x0
  801100:	e8 b2 ff ff ff       	call   8010b7 <syscall>
  801105:	83 c4 18             	add    $0x18,%esp
}
  801108:	90                   	nop
  801109:	c9                   	leave  
  80110a:	c3                   	ret    

0080110b <sys_cgetc>:

int
sys_cgetc(void)
{
  80110b:	55                   	push   %ebp
  80110c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80110e:	6a 00                	push   $0x0
  801110:	6a 00                	push   $0x0
  801112:	6a 00                	push   $0x0
  801114:	6a 00                	push   $0x0
  801116:	6a 00                	push   $0x0
  801118:	6a 01                	push   $0x1
  80111a:	e8 98 ff ff ff       	call   8010b7 <syscall>
  80111f:	83 c4 18             	add    $0x18,%esp
}
  801122:	c9                   	leave  
  801123:	c3                   	ret    

00801124 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801124:	55                   	push   %ebp
  801125:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	6a 00                	push   $0x0
  80112c:	6a 00                	push   $0x0
  80112e:	6a 00                	push   $0x0
  801130:	6a 00                	push   $0x0
  801132:	50                   	push   %eax
  801133:	6a 05                	push   $0x5
  801135:	e8 7d ff ff ff       	call   8010b7 <syscall>
  80113a:	83 c4 18             	add    $0x18,%esp
}
  80113d:	c9                   	leave  
  80113e:	c3                   	ret    

0080113f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80113f:	55                   	push   %ebp
  801140:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801142:	6a 00                	push   $0x0
  801144:	6a 00                	push   $0x0
  801146:	6a 00                	push   $0x0
  801148:	6a 00                	push   $0x0
  80114a:	6a 00                	push   $0x0
  80114c:	6a 02                	push   $0x2
  80114e:	e8 64 ff ff ff       	call   8010b7 <syscall>
  801153:	83 c4 18             	add    $0x18,%esp
}
  801156:	c9                   	leave  
  801157:	c3                   	ret    

00801158 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801158:	55                   	push   %ebp
  801159:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80115b:	6a 00                	push   $0x0
  80115d:	6a 00                	push   $0x0
  80115f:	6a 00                	push   $0x0
  801161:	6a 00                	push   $0x0
  801163:	6a 00                	push   $0x0
  801165:	6a 03                	push   $0x3
  801167:	e8 4b ff ff ff       	call   8010b7 <syscall>
  80116c:	83 c4 18             	add    $0x18,%esp
}
  80116f:	c9                   	leave  
  801170:	c3                   	ret    

00801171 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801171:	55                   	push   %ebp
  801172:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801174:	6a 00                	push   $0x0
  801176:	6a 00                	push   $0x0
  801178:	6a 00                	push   $0x0
  80117a:	6a 00                	push   $0x0
  80117c:	6a 00                	push   $0x0
  80117e:	6a 04                	push   $0x4
  801180:	e8 32 ff ff ff       	call   8010b7 <syscall>
  801185:	83 c4 18             	add    $0x18,%esp
}
  801188:	c9                   	leave  
  801189:	c3                   	ret    

0080118a <sys_env_exit>:


void sys_env_exit(void)
{
  80118a:	55                   	push   %ebp
  80118b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80118d:	6a 00                	push   $0x0
  80118f:	6a 00                	push   $0x0
  801191:	6a 00                	push   $0x0
  801193:	6a 00                	push   $0x0
  801195:	6a 00                	push   $0x0
  801197:	6a 06                	push   $0x6
  801199:	e8 19 ff ff ff       	call   8010b7 <syscall>
  80119e:	83 c4 18             	add    $0x18,%esp
}
  8011a1:	90                   	nop
  8011a2:	c9                   	leave  
  8011a3:	c3                   	ret    

008011a4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8011a4:	55                   	push   %ebp
  8011a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8011a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ad:	6a 00                	push   $0x0
  8011af:	6a 00                	push   $0x0
  8011b1:	6a 00                	push   $0x0
  8011b3:	52                   	push   %edx
  8011b4:	50                   	push   %eax
  8011b5:	6a 07                	push   $0x7
  8011b7:	e8 fb fe ff ff       	call   8010b7 <syscall>
  8011bc:	83 c4 18             	add    $0x18,%esp
}
  8011bf:	c9                   	leave  
  8011c0:	c3                   	ret    

008011c1 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8011c1:	55                   	push   %ebp
  8011c2:	89 e5                	mov    %esp,%ebp
  8011c4:	56                   	push   %esi
  8011c5:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8011c6:	8b 75 18             	mov    0x18(%ebp),%esi
  8011c9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8011cc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8011cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d5:	56                   	push   %esi
  8011d6:	53                   	push   %ebx
  8011d7:	51                   	push   %ecx
  8011d8:	52                   	push   %edx
  8011d9:	50                   	push   %eax
  8011da:	6a 08                	push   $0x8
  8011dc:	e8 d6 fe ff ff       	call   8010b7 <syscall>
  8011e1:	83 c4 18             	add    $0x18,%esp
}
  8011e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8011e7:	5b                   	pop    %ebx
  8011e8:	5e                   	pop    %esi
  8011e9:	5d                   	pop    %ebp
  8011ea:	c3                   	ret    

008011eb <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8011eb:	55                   	push   %ebp
  8011ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8011ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f4:	6a 00                	push   $0x0
  8011f6:	6a 00                	push   $0x0
  8011f8:	6a 00                	push   $0x0
  8011fa:	52                   	push   %edx
  8011fb:	50                   	push   %eax
  8011fc:	6a 09                	push   $0x9
  8011fe:	e8 b4 fe ff ff       	call   8010b7 <syscall>
  801203:	83 c4 18             	add    $0x18,%esp
}
  801206:	c9                   	leave  
  801207:	c3                   	ret    

00801208 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801208:	55                   	push   %ebp
  801209:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80120b:	6a 00                	push   $0x0
  80120d:	6a 00                	push   $0x0
  80120f:	6a 00                	push   $0x0
  801211:	ff 75 0c             	pushl  0xc(%ebp)
  801214:	ff 75 08             	pushl  0x8(%ebp)
  801217:	6a 0a                	push   $0xa
  801219:	e8 99 fe ff ff       	call   8010b7 <syscall>
  80121e:	83 c4 18             	add    $0x18,%esp
}
  801221:	c9                   	leave  
  801222:	c3                   	ret    

00801223 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801223:	55                   	push   %ebp
  801224:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801226:	6a 00                	push   $0x0
  801228:	6a 00                	push   $0x0
  80122a:	6a 00                	push   $0x0
  80122c:	6a 00                	push   $0x0
  80122e:	6a 00                	push   $0x0
  801230:	6a 0b                	push   $0xb
  801232:	e8 80 fe ff ff       	call   8010b7 <syscall>
  801237:	83 c4 18             	add    $0x18,%esp
}
  80123a:	c9                   	leave  
  80123b:	c3                   	ret    

0080123c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80123c:	55                   	push   %ebp
  80123d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80123f:	6a 00                	push   $0x0
  801241:	6a 00                	push   $0x0
  801243:	6a 00                	push   $0x0
  801245:	6a 00                	push   $0x0
  801247:	6a 00                	push   $0x0
  801249:	6a 0c                	push   $0xc
  80124b:	e8 67 fe ff ff       	call   8010b7 <syscall>
  801250:	83 c4 18             	add    $0x18,%esp
}
  801253:	c9                   	leave  
  801254:	c3                   	ret    

00801255 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801255:	55                   	push   %ebp
  801256:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801258:	6a 00                	push   $0x0
  80125a:	6a 00                	push   $0x0
  80125c:	6a 00                	push   $0x0
  80125e:	6a 00                	push   $0x0
  801260:	6a 00                	push   $0x0
  801262:	6a 0d                	push   $0xd
  801264:	e8 4e fe ff ff       	call   8010b7 <syscall>
  801269:	83 c4 18             	add    $0x18,%esp
}
  80126c:	c9                   	leave  
  80126d:	c3                   	ret    

0080126e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80126e:	55                   	push   %ebp
  80126f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	ff 75 0c             	pushl  0xc(%ebp)
  80127a:	ff 75 08             	pushl  0x8(%ebp)
  80127d:	6a 11                	push   $0x11
  80127f:	e8 33 fe ff ff       	call   8010b7 <syscall>
  801284:	83 c4 18             	add    $0x18,%esp
	return;
  801287:	90                   	nop
}
  801288:	c9                   	leave  
  801289:	c3                   	ret    

0080128a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80128a:	55                   	push   %ebp
  80128b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80128d:	6a 00                	push   $0x0
  80128f:	6a 00                	push   $0x0
  801291:	6a 00                	push   $0x0
  801293:	ff 75 0c             	pushl  0xc(%ebp)
  801296:	ff 75 08             	pushl  0x8(%ebp)
  801299:	6a 12                	push   $0x12
  80129b:	e8 17 fe ff ff       	call   8010b7 <syscall>
  8012a0:	83 c4 18             	add    $0x18,%esp
	return ;
  8012a3:	90                   	nop
}
  8012a4:	c9                   	leave  
  8012a5:	c3                   	ret    

008012a6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8012a6:	55                   	push   %ebp
  8012a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 00                	push   $0x0
  8012af:	6a 00                	push   $0x0
  8012b1:	6a 00                	push   $0x0
  8012b3:	6a 0e                	push   $0xe
  8012b5:	e8 fd fd ff ff       	call   8010b7 <syscall>
  8012ba:	83 c4 18             	add    $0x18,%esp
}
  8012bd:	c9                   	leave  
  8012be:	c3                   	ret    

008012bf <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8012bf:	55                   	push   %ebp
  8012c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	6a 00                	push   $0x0
  8012c8:	6a 00                	push   $0x0
  8012ca:	ff 75 08             	pushl  0x8(%ebp)
  8012cd:	6a 0f                	push   $0xf
  8012cf:	e8 e3 fd ff ff       	call   8010b7 <syscall>
  8012d4:	83 c4 18             	add    $0x18,%esp
}
  8012d7:	c9                   	leave  
  8012d8:	c3                   	ret    

008012d9 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8012d9:	55                   	push   %ebp
  8012da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8012dc:	6a 00                	push   $0x0
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 00                	push   $0x0
  8012e2:	6a 00                	push   $0x0
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 10                	push   $0x10
  8012e8:	e8 ca fd ff ff       	call   8010b7 <syscall>
  8012ed:	83 c4 18             	add    $0x18,%esp
}
  8012f0:	90                   	nop
  8012f1:	c9                   	leave  
  8012f2:	c3                   	ret    

008012f3 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8012f3:	55                   	push   %ebp
  8012f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 00                	push   $0x0
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	6a 14                	push   $0x14
  801302:	e8 b0 fd ff ff       	call   8010b7 <syscall>
  801307:	83 c4 18             	add    $0x18,%esp
}
  80130a:	90                   	nop
  80130b:	c9                   	leave  
  80130c:	c3                   	ret    

0080130d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80130d:	55                   	push   %ebp
  80130e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801310:	6a 00                	push   $0x0
  801312:	6a 00                	push   $0x0
  801314:	6a 00                	push   $0x0
  801316:	6a 00                	push   $0x0
  801318:	6a 00                	push   $0x0
  80131a:	6a 15                	push   $0x15
  80131c:	e8 96 fd ff ff       	call   8010b7 <syscall>
  801321:	83 c4 18             	add    $0x18,%esp
}
  801324:	90                   	nop
  801325:	c9                   	leave  
  801326:	c3                   	ret    

00801327 <sys_cputc>:


void
sys_cputc(const char c)
{
  801327:	55                   	push   %ebp
  801328:	89 e5                	mov    %esp,%ebp
  80132a:	83 ec 04             	sub    $0x4,%esp
  80132d:	8b 45 08             	mov    0x8(%ebp),%eax
  801330:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801333:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801337:	6a 00                	push   $0x0
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	6a 00                	push   $0x0
  80133f:	50                   	push   %eax
  801340:	6a 16                	push   $0x16
  801342:	e8 70 fd ff ff       	call   8010b7 <syscall>
  801347:	83 c4 18             	add    $0x18,%esp
}
  80134a:	90                   	nop
  80134b:	c9                   	leave  
  80134c:	c3                   	ret    

0080134d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80134d:	55                   	push   %ebp
  80134e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801350:	6a 00                	push   $0x0
  801352:	6a 00                	push   $0x0
  801354:	6a 00                	push   $0x0
  801356:	6a 00                	push   $0x0
  801358:	6a 00                	push   $0x0
  80135a:	6a 17                	push   $0x17
  80135c:	e8 56 fd ff ff       	call   8010b7 <syscall>
  801361:	83 c4 18             	add    $0x18,%esp
}
  801364:	90                   	nop
  801365:	c9                   	leave  
  801366:	c3                   	ret    

00801367 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801367:	55                   	push   %ebp
  801368:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	6a 00                	push   $0x0
  80136f:	6a 00                	push   $0x0
  801371:	6a 00                	push   $0x0
  801373:	ff 75 0c             	pushl  0xc(%ebp)
  801376:	50                   	push   %eax
  801377:	6a 18                	push   $0x18
  801379:	e8 39 fd ff ff       	call   8010b7 <syscall>
  80137e:	83 c4 18             	add    $0x18,%esp
}
  801381:	c9                   	leave  
  801382:	c3                   	ret    

00801383 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801383:	55                   	push   %ebp
  801384:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801386:	8b 55 0c             	mov    0xc(%ebp),%edx
  801389:	8b 45 08             	mov    0x8(%ebp),%eax
  80138c:	6a 00                	push   $0x0
  80138e:	6a 00                	push   $0x0
  801390:	6a 00                	push   $0x0
  801392:	52                   	push   %edx
  801393:	50                   	push   %eax
  801394:	6a 1b                	push   $0x1b
  801396:	e8 1c fd ff ff       	call   8010b7 <syscall>
  80139b:	83 c4 18             	add    $0x18,%esp
}
  80139e:	c9                   	leave  
  80139f:	c3                   	ret    

008013a0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8013a0:	55                   	push   %ebp
  8013a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a9:	6a 00                	push   $0x0
  8013ab:	6a 00                	push   $0x0
  8013ad:	6a 00                	push   $0x0
  8013af:	52                   	push   %edx
  8013b0:	50                   	push   %eax
  8013b1:	6a 19                	push   $0x19
  8013b3:	e8 ff fc ff ff       	call   8010b7 <syscall>
  8013b8:	83 c4 18             	add    $0x18,%esp
}
  8013bb:	90                   	nop
  8013bc:	c9                   	leave  
  8013bd:	c3                   	ret    

008013be <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8013be:	55                   	push   %ebp
  8013bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	52                   	push   %edx
  8013ce:	50                   	push   %eax
  8013cf:	6a 1a                	push   $0x1a
  8013d1:	e8 e1 fc ff ff       	call   8010b7 <syscall>
  8013d6:	83 c4 18             	add    $0x18,%esp
}
  8013d9:	90                   	nop
  8013da:	c9                   	leave  
  8013db:	c3                   	ret    

008013dc <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8013dc:	55                   	push   %ebp
  8013dd:	89 e5                	mov    %esp,%ebp
  8013df:	83 ec 04             	sub    $0x4,%esp
  8013e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8013e8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8013eb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8013ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f2:	6a 00                	push   $0x0
  8013f4:	51                   	push   %ecx
  8013f5:	52                   	push   %edx
  8013f6:	ff 75 0c             	pushl  0xc(%ebp)
  8013f9:	50                   	push   %eax
  8013fa:	6a 1c                	push   $0x1c
  8013fc:	e8 b6 fc ff ff       	call   8010b7 <syscall>
  801401:	83 c4 18             	add    $0x18,%esp
}
  801404:	c9                   	leave  
  801405:	c3                   	ret    

00801406 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801406:	55                   	push   %ebp
  801407:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801409:	8b 55 0c             	mov    0xc(%ebp),%edx
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	6a 00                	push   $0x0
  801411:	6a 00                	push   $0x0
  801413:	6a 00                	push   $0x0
  801415:	52                   	push   %edx
  801416:	50                   	push   %eax
  801417:	6a 1d                	push   $0x1d
  801419:	e8 99 fc ff ff       	call   8010b7 <syscall>
  80141e:	83 c4 18             	add    $0x18,%esp
}
  801421:	c9                   	leave  
  801422:	c3                   	ret    

00801423 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801423:	55                   	push   %ebp
  801424:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801426:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801429:	8b 55 0c             	mov    0xc(%ebp),%edx
  80142c:	8b 45 08             	mov    0x8(%ebp),%eax
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	51                   	push   %ecx
  801434:	52                   	push   %edx
  801435:	50                   	push   %eax
  801436:	6a 1e                	push   $0x1e
  801438:	e8 7a fc ff ff       	call   8010b7 <syscall>
  80143d:	83 c4 18             	add    $0x18,%esp
}
  801440:	c9                   	leave  
  801441:	c3                   	ret    

00801442 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801442:	55                   	push   %ebp
  801443:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801445:	8b 55 0c             	mov    0xc(%ebp),%edx
  801448:	8b 45 08             	mov    0x8(%ebp),%eax
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	52                   	push   %edx
  801452:	50                   	push   %eax
  801453:	6a 1f                	push   $0x1f
  801455:	e8 5d fc ff ff       	call   8010b7 <syscall>
  80145a:	83 c4 18             	add    $0x18,%esp
}
  80145d:	c9                   	leave  
  80145e:	c3                   	ret    

0080145f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80145f:	55                   	push   %ebp
  801460:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 20                	push   $0x20
  80146e:	e8 44 fc ff ff       	call   8010b7 <syscall>
  801473:	83 c4 18             	add    $0x18,%esp
}
  801476:	c9                   	leave  
  801477:	c3                   	ret    

00801478 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801478:	55                   	push   %ebp
  801479:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80147b:	8b 45 08             	mov    0x8(%ebp),%eax
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	ff 75 10             	pushl  0x10(%ebp)
  801485:	ff 75 0c             	pushl  0xc(%ebp)
  801488:	50                   	push   %eax
  801489:	6a 21                	push   $0x21
  80148b:	e8 27 fc ff ff       	call   8010b7 <syscall>
  801490:	83 c4 18             	add    $0x18,%esp
}
  801493:	c9                   	leave  
  801494:	c3                   	ret    

00801495 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801495:	55                   	push   %ebp
  801496:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801498:	8b 45 08             	mov    0x8(%ebp),%eax
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	50                   	push   %eax
  8014a4:	6a 22                	push   $0x22
  8014a6:	e8 0c fc ff ff       	call   8010b7 <syscall>
  8014ab:	83 c4 18             	add    $0x18,%esp
}
  8014ae:	90                   	nop
  8014af:	c9                   	leave  
  8014b0:	c3                   	ret    

008014b1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8014b1:	55                   	push   %ebp
  8014b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8014b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	50                   	push   %eax
  8014c0:	6a 23                	push   $0x23
  8014c2:	e8 f0 fb ff ff       	call   8010b7 <syscall>
  8014c7:	83 c4 18             	add    $0x18,%esp
}
  8014ca:	90                   	nop
  8014cb:	c9                   	leave  
  8014cc:	c3                   	ret    

008014cd <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
  8014d0:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8014d3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8014d6:	8d 50 04             	lea    0x4(%eax),%edx
  8014d9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8014dc:	6a 00                	push   $0x0
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	52                   	push   %edx
  8014e3:	50                   	push   %eax
  8014e4:	6a 24                	push   $0x24
  8014e6:	e8 cc fb ff ff       	call   8010b7 <syscall>
  8014eb:	83 c4 18             	add    $0x18,%esp
	return result;
  8014ee:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f7:	89 01                	mov    %eax,(%ecx)
  8014f9:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8014fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ff:	c9                   	leave  
  801500:	c2 04 00             	ret    $0x4

00801503 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801503:	55                   	push   %ebp
  801504:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	ff 75 10             	pushl  0x10(%ebp)
  80150d:	ff 75 0c             	pushl  0xc(%ebp)
  801510:	ff 75 08             	pushl  0x8(%ebp)
  801513:	6a 13                	push   $0x13
  801515:	e8 9d fb ff ff       	call   8010b7 <syscall>
  80151a:	83 c4 18             	add    $0x18,%esp
	return ;
  80151d:	90                   	nop
}
  80151e:	c9                   	leave  
  80151f:	c3                   	ret    

00801520 <sys_rcr2>:
uint32 sys_rcr2()
{
  801520:	55                   	push   %ebp
  801521:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 25                	push   $0x25
  80152f:	e8 83 fb ff ff       	call   8010b7 <syscall>
  801534:	83 c4 18             	add    $0x18,%esp
}
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
  80153c:	83 ec 04             	sub    $0x4,%esp
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801545:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	50                   	push   %eax
  801552:	6a 26                	push   $0x26
  801554:	e8 5e fb ff ff       	call   8010b7 <syscall>
  801559:	83 c4 18             	add    $0x18,%esp
	return ;
  80155c:	90                   	nop
}
  80155d:	c9                   	leave  
  80155e:	c3                   	ret    

0080155f <rsttst>:
void rsttst()
{
  80155f:	55                   	push   %ebp
  801560:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 28                	push   $0x28
  80156e:	e8 44 fb ff ff       	call   8010b7 <syscall>
  801573:	83 c4 18             	add    $0x18,%esp
	return ;
  801576:	90                   	nop
}
  801577:	c9                   	leave  
  801578:	c3                   	ret    

00801579 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801579:	55                   	push   %ebp
  80157a:	89 e5                	mov    %esp,%ebp
  80157c:	83 ec 04             	sub    $0x4,%esp
  80157f:	8b 45 14             	mov    0x14(%ebp),%eax
  801582:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801585:	8b 55 18             	mov    0x18(%ebp),%edx
  801588:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80158c:	52                   	push   %edx
  80158d:	50                   	push   %eax
  80158e:	ff 75 10             	pushl  0x10(%ebp)
  801591:	ff 75 0c             	pushl  0xc(%ebp)
  801594:	ff 75 08             	pushl  0x8(%ebp)
  801597:	6a 27                	push   $0x27
  801599:	e8 19 fb ff ff       	call   8010b7 <syscall>
  80159e:	83 c4 18             	add    $0x18,%esp
	return ;
  8015a1:	90                   	nop
}
  8015a2:	c9                   	leave  
  8015a3:	c3                   	ret    

008015a4 <chktst>:
void chktst(uint32 n)
{
  8015a4:	55                   	push   %ebp
  8015a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	ff 75 08             	pushl  0x8(%ebp)
  8015b2:	6a 29                	push   $0x29
  8015b4:	e8 fe fa ff ff       	call   8010b7 <syscall>
  8015b9:	83 c4 18             	add    $0x18,%esp
	return ;
  8015bc:	90                   	nop
}
  8015bd:	c9                   	leave  
  8015be:	c3                   	ret    

008015bf <inctst>:

void inctst()
{
  8015bf:	55                   	push   %ebp
  8015c0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 2a                	push   $0x2a
  8015ce:	e8 e4 fa ff ff       	call   8010b7 <syscall>
  8015d3:	83 c4 18             	add    $0x18,%esp
	return ;
  8015d6:	90                   	nop
}
  8015d7:	c9                   	leave  
  8015d8:	c3                   	ret    

008015d9 <gettst>:
uint32 gettst()
{
  8015d9:	55                   	push   %ebp
  8015da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 2b                	push   $0x2b
  8015e8:	e8 ca fa ff ff       	call   8010b7 <syscall>
  8015ed:	83 c4 18             	add    $0x18,%esp
}
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
  8015f5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	6a 00                	push   $0x0
  801602:	6a 2c                	push   $0x2c
  801604:	e8 ae fa ff ff       	call   8010b7 <syscall>
  801609:	83 c4 18             	add    $0x18,%esp
  80160c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80160f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801613:	75 07                	jne    80161c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801615:	b8 01 00 00 00       	mov    $0x1,%eax
  80161a:	eb 05                	jmp    801621 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80161c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801621:	c9                   	leave  
  801622:	c3                   	ret    

00801623 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801623:	55                   	push   %ebp
  801624:	89 e5                	mov    %esp,%ebp
  801626:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	6a 2c                	push   $0x2c
  801635:	e8 7d fa ff ff       	call   8010b7 <syscall>
  80163a:	83 c4 18             	add    $0x18,%esp
  80163d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801640:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801644:	75 07                	jne    80164d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801646:	b8 01 00 00 00       	mov    $0x1,%eax
  80164b:	eb 05                	jmp    801652 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80164d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
  801657:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 2c                	push   $0x2c
  801666:	e8 4c fa ff ff       	call   8010b7 <syscall>
  80166b:	83 c4 18             	add    $0x18,%esp
  80166e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801671:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801675:	75 07                	jne    80167e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801677:	b8 01 00 00 00       	mov    $0x1,%eax
  80167c:	eb 05                	jmp    801683 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80167e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801683:	c9                   	leave  
  801684:	c3                   	ret    

00801685 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801685:	55                   	push   %ebp
  801686:	89 e5                	mov    %esp,%ebp
  801688:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	6a 2c                	push   $0x2c
  801697:	e8 1b fa ff ff       	call   8010b7 <syscall>
  80169c:	83 c4 18             	add    $0x18,%esp
  80169f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8016a2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8016a6:	75 07                	jne    8016af <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8016a8:	b8 01 00 00 00       	mov    $0x1,%eax
  8016ad:	eb 05                	jmp    8016b4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8016af:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016b4:	c9                   	leave  
  8016b5:	c3                   	ret    

008016b6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8016b6:	55                   	push   %ebp
  8016b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	ff 75 08             	pushl  0x8(%ebp)
  8016c4:	6a 2d                	push   $0x2d
  8016c6:	e8 ec f9 ff ff       	call   8010b7 <syscall>
  8016cb:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ce:	90                   	nop
}
  8016cf:	c9                   	leave  
  8016d0:	c3                   	ret    
  8016d1:	66 90                	xchg   %ax,%ax
  8016d3:	90                   	nop

008016d4 <__udivdi3>:
  8016d4:	55                   	push   %ebp
  8016d5:	57                   	push   %edi
  8016d6:	56                   	push   %esi
  8016d7:	53                   	push   %ebx
  8016d8:	83 ec 1c             	sub    $0x1c,%esp
  8016db:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016df:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016e3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016e7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016eb:	89 ca                	mov    %ecx,%edx
  8016ed:	89 f8                	mov    %edi,%eax
  8016ef:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016f3:	85 f6                	test   %esi,%esi
  8016f5:	75 2d                	jne    801724 <__udivdi3+0x50>
  8016f7:	39 cf                	cmp    %ecx,%edi
  8016f9:	77 65                	ja     801760 <__udivdi3+0x8c>
  8016fb:	89 fd                	mov    %edi,%ebp
  8016fd:	85 ff                	test   %edi,%edi
  8016ff:	75 0b                	jne    80170c <__udivdi3+0x38>
  801701:	b8 01 00 00 00       	mov    $0x1,%eax
  801706:	31 d2                	xor    %edx,%edx
  801708:	f7 f7                	div    %edi
  80170a:	89 c5                	mov    %eax,%ebp
  80170c:	31 d2                	xor    %edx,%edx
  80170e:	89 c8                	mov    %ecx,%eax
  801710:	f7 f5                	div    %ebp
  801712:	89 c1                	mov    %eax,%ecx
  801714:	89 d8                	mov    %ebx,%eax
  801716:	f7 f5                	div    %ebp
  801718:	89 cf                	mov    %ecx,%edi
  80171a:	89 fa                	mov    %edi,%edx
  80171c:	83 c4 1c             	add    $0x1c,%esp
  80171f:	5b                   	pop    %ebx
  801720:	5e                   	pop    %esi
  801721:	5f                   	pop    %edi
  801722:	5d                   	pop    %ebp
  801723:	c3                   	ret    
  801724:	39 ce                	cmp    %ecx,%esi
  801726:	77 28                	ja     801750 <__udivdi3+0x7c>
  801728:	0f bd fe             	bsr    %esi,%edi
  80172b:	83 f7 1f             	xor    $0x1f,%edi
  80172e:	75 40                	jne    801770 <__udivdi3+0x9c>
  801730:	39 ce                	cmp    %ecx,%esi
  801732:	72 0a                	jb     80173e <__udivdi3+0x6a>
  801734:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801738:	0f 87 9e 00 00 00    	ja     8017dc <__udivdi3+0x108>
  80173e:	b8 01 00 00 00       	mov    $0x1,%eax
  801743:	89 fa                	mov    %edi,%edx
  801745:	83 c4 1c             	add    $0x1c,%esp
  801748:	5b                   	pop    %ebx
  801749:	5e                   	pop    %esi
  80174a:	5f                   	pop    %edi
  80174b:	5d                   	pop    %ebp
  80174c:	c3                   	ret    
  80174d:	8d 76 00             	lea    0x0(%esi),%esi
  801750:	31 ff                	xor    %edi,%edi
  801752:	31 c0                	xor    %eax,%eax
  801754:	89 fa                	mov    %edi,%edx
  801756:	83 c4 1c             	add    $0x1c,%esp
  801759:	5b                   	pop    %ebx
  80175a:	5e                   	pop    %esi
  80175b:	5f                   	pop    %edi
  80175c:	5d                   	pop    %ebp
  80175d:	c3                   	ret    
  80175e:	66 90                	xchg   %ax,%ax
  801760:	89 d8                	mov    %ebx,%eax
  801762:	f7 f7                	div    %edi
  801764:	31 ff                	xor    %edi,%edi
  801766:	89 fa                	mov    %edi,%edx
  801768:	83 c4 1c             	add    $0x1c,%esp
  80176b:	5b                   	pop    %ebx
  80176c:	5e                   	pop    %esi
  80176d:	5f                   	pop    %edi
  80176e:	5d                   	pop    %ebp
  80176f:	c3                   	ret    
  801770:	bd 20 00 00 00       	mov    $0x20,%ebp
  801775:	89 eb                	mov    %ebp,%ebx
  801777:	29 fb                	sub    %edi,%ebx
  801779:	89 f9                	mov    %edi,%ecx
  80177b:	d3 e6                	shl    %cl,%esi
  80177d:	89 c5                	mov    %eax,%ebp
  80177f:	88 d9                	mov    %bl,%cl
  801781:	d3 ed                	shr    %cl,%ebp
  801783:	89 e9                	mov    %ebp,%ecx
  801785:	09 f1                	or     %esi,%ecx
  801787:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80178b:	89 f9                	mov    %edi,%ecx
  80178d:	d3 e0                	shl    %cl,%eax
  80178f:	89 c5                	mov    %eax,%ebp
  801791:	89 d6                	mov    %edx,%esi
  801793:	88 d9                	mov    %bl,%cl
  801795:	d3 ee                	shr    %cl,%esi
  801797:	89 f9                	mov    %edi,%ecx
  801799:	d3 e2                	shl    %cl,%edx
  80179b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80179f:	88 d9                	mov    %bl,%cl
  8017a1:	d3 e8                	shr    %cl,%eax
  8017a3:	09 c2                	or     %eax,%edx
  8017a5:	89 d0                	mov    %edx,%eax
  8017a7:	89 f2                	mov    %esi,%edx
  8017a9:	f7 74 24 0c          	divl   0xc(%esp)
  8017ad:	89 d6                	mov    %edx,%esi
  8017af:	89 c3                	mov    %eax,%ebx
  8017b1:	f7 e5                	mul    %ebp
  8017b3:	39 d6                	cmp    %edx,%esi
  8017b5:	72 19                	jb     8017d0 <__udivdi3+0xfc>
  8017b7:	74 0b                	je     8017c4 <__udivdi3+0xf0>
  8017b9:	89 d8                	mov    %ebx,%eax
  8017bb:	31 ff                	xor    %edi,%edi
  8017bd:	e9 58 ff ff ff       	jmp    80171a <__udivdi3+0x46>
  8017c2:	66 90                	xchg   %ax,%ax
  8017c4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017c8:	89 f9                	mov    %edi,%ecx
  8017ca:	d3 e2                	shl    %cl,%edx
  8017cc:	39 c2                	cmp    %eax,%edx
  8017ce:	73 e9                	jae    8017b9 <__udivdi3+0xe5>
  8017d0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017d3:	31 ff                	xor    %edi,%edi
  8017d5:	e9 40 ff ff ff       	jmp    80171a <__udivdi3+0x46>
  8017da:	66 90                	xchg   %ax,%ax
  8017dc:	31 c0                	xor    %eax,%eax
  8017de:	e9 37 ff ff ff       	jmp    80171a <__udivdi3+0x46>
  8017e3:	90                   	nop

008017e4 <__umoddi3>:
  8017e4:	55                   	push   %ebp
  8017e5:	57                   	push   %edi
  8017e6:	56                   	push   %esi
  8017e7:	53                   	push   %ebx
  8017e8:	83 ec 1c             	sub    $0x1c,%esp
  8017eb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017ef:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017f3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017f7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017fb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017ff:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801803:	89 f3                	mov    %esi,%ebx
  801805:	89 fa                	mov    %edi,%edx
  801807:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80180b:	89 34 24             	mov    %esi,(%esp)
  80180e:	85 c0                	test   %eax,%eax
  801810:	75 1a                	jne    80182c <__umoddi3+0x48>
  801812:	39 f7                	cmp    %esi,%edi
  801814:	0f 86 a2 00 00 00    	jbe    8018bc <__umoddi3+0xd8>
  80181a:	89 c8                	mov    %ecx,%eax
  80181c:	89 f2                	mov    %esi,%edx
  80181e:	f7 f7                	div    %edi
  801820:	89 d0                	mov    %edx,%eax
  801822:	31 d2                	xor    %edx,%edx
  801824:	83 c4 1c             	add    $0x1c,%esp
  801827:	5b                   	pop    %ebx
  801828:	5e                   	pop    %esi
  801829:	5f                   	pop    %edi
  80182a:	5d                   	pop    %ebp
  80182b:	c3                   	ret    
  80182c:	39 f0                	cmp    %esi,%eax
  80182e:	0f 87 ac 00 00 00    	ja     8018e0 <__umoddi3+0xfc>
  801834:	0f bd e8             	bsr    %eax,%ebp
  801837:	83 f5 1f             	xor    $0x1f,%ebp
  80183a:	0f 84 ac 00 00 00    	je     8018ec <__umoddi3+0x108>
  801840:	bf 20 00 00 00       	mov    $0x20,%edi
  801845:	29 ef                	sub    %ebp,%edi
  801847:	89 fe                	mov    %edi,%esi
  801849:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80184d:	89 e9                	mov    %ebp,%ecx
  80184f:	d3 e0                	shl    %cl,%eax
  801851:	89 d7                	mov    %edx,%edi
  801853:	89 f1                	mov    %esi,%ecx
  801855:	d3 ef                	shr    %cl,%edi
  801857:	09 c7                	or     %eax,%edi
  801859:	89 e9                	mov    %ebp,%ecx
  80185b:	d3 e2                	shl    %cl,%edx
  80185d:	89 14 24             	mov    %edx,(%esp)
  801860:	89 d8                	mov    %ebx,%eax
  801862:	d3 e0                	shl    %cl,%eax
  801864:	89 c2                	mov    %eax,%edx
  801866:	8b 44 24 08          	mov    0x8(%esp),%eax
  80186a:	d3 e0                	shl    %cl,%eax
  80186c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801870:	8b 44 24 08          	mov    0x8(%esp),%eax
  801874:	89 f1                	mov    %esi,%ecx
  801876:	d3 e8                	shr    %cl,%eax
  801878:	09 d0                	or     %edx,%eax
  80187a:	d3 eb                	shr    %cl,%ebx
  80187c:	89 da                	mov    %ebx,%edx
  80187e:	f7 f7                	div    %edi
  801880:	89 d3                	mov    %edx,%ebx
  801882:	f7 24 24             	mull   (%esp)
  801885:	89 c6                	mov    %eax,%esi
  801887:	89 d1                	mov    %edx,%ecx
  801889:	39 d3                	cmp    %edx,%ebx
  80188b:	0f 82 87 00 00 00    	jb     801918 <__umoddi3+0x134>
  801891:	0f 84 91 00 00 00    	je     801928 <__umoddi3+0x144>
  801897:	8b 54 24 04          	mov    0x4(%esp),%edx
  80189b:	29 f2                	sub    %esi,%edx
  80189d:	19 cb                	sbb    %ecx,%ebx
  80189f:	89 d8                	mov    %ebx,%eax
  8018a1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8018a5:	d3 e0                	shl    %cl,%eax
  8018a7:	89 e9                	mov    %ebp,%ecx
  8018a9:	d3 ea                	shr    %cl,%edx
  8018ab:	09 d0                	or     %edx,%eax
  8018ad:	89 e9                	mov    %ebp,%ecx
  8018af:	d3 eb                	shr    %cl,%ebx
  8018b1:	89 da                	mov    %ebx,%edx
  8018b3:	83 c4 1c             	add    $0x1c,%esp
  8018b6:	5b                   	pop    %ebx
  8018b7:	5e                   	pop    %esi
  8018b8:	5f                   	pop    %edi
  8018b9:	5d                   	pop    %ebp
  8018ba:	c3                   	ret    
  8018bb:	90                   	nop
  8018bc:	89 fd                	mov    %edi,%ebp
  8018be:	85 ff                	test   %edi,%edi
  8018c0:	75 0b                	jne    8018cd <__umoddi3+0xe9>
  8018c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8018c7:	31 d2                	xor    %edx,%edx
  8018c9:	f7 f7                	div    %edi
  8018cb:	89 c5                	mov    %eax,%ebp
  8018cd:	89 f0                	mov    %esi,%eax
  8018cf:	31 d2                	xor    %edx,%edx
  8018d1:	f7 f5                	div    %ebp
  8018d3:	89 c8                	mov    %ecx,%eax
  8018d5:	f7 f5                	div    %ebp
  8018d7:	89 d0                	mov    %edx,%eax
  8018d9:	e9 44 ff ff ff       	jmp    801822 <__umoddi3+0x3e>
  8018de:	66 90                	xchg   %ax,%ax
  8018e0:	89 c8                	mov    %ecx,%eax
  8018e2:	89 f2                	mov    %esi,%edx
  8018e4:	83 c4 1c             	add    $0x1c,%esp
  8018e7:	5b                   	pop    %ebx
  8018e8:	5e                   	pop    %esi
  8018e9:	5f                   	pop    %edi
  8018ea:	5d                   	pop    %ebp
  8018eb:	c3                   	ret    
  8018ec:	3b 04 24             	cmp    (%esp),%eax
  8018ef:	72 06                	jb     8018f7 <__umoddi3+0x113>
  8018f1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018f5:	77 0f                	ja     801906 <__umoddi3+0x122>
  8018f7:	89 f2                	mov    %esi,%edx
  8018f9:	29 f9                	sub    %edi,%ecx
  8018fb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018ff:	89 14 24             	mov    %edx,(%esp)
  801902:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801906:	8b 44 24 04          	mov    0x4(%esp),%eax
  80190a:	8b 14 24             	mov    (%esp),%edx
  80190d:	83 c4 1c             	add    $0x1c,%esp
  801910:	5b                   	pop    %ebx
  801911:	5e                   	pop    %esi
  801912:	5f                   	pop    %edi
  801913:	5d                   	pop    %ebp
  801914:	c3                   	ret    
  801915:	8d 76 00             	lea    0x0(%esi),%esi
  801918:	2b 04 24             	sub    (%esp),%eax
  80191b:	19 fa                	sbb    %edi,%edx
  80191d:	89 d1                	mov    %edx,%ecx
  80191f:	89 c6                	mov    %eax,%esi
  801921:	e9 71 ff ff ff       	jmp    801897 <__umoddi3+0xb3>
  801926:	66 90                	xchg   %ax,%ax
  801928:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80192c:	72 ea                	jb     801918 <__umoddi3+0x134>
  80192e:	89 d9                	mov    %ebx,%ecx
  801930:	e9 62 ff ff ff       	jmp    801897 <__umoddi3+0xb3>
