
obj/user/fos_alloc:     file format elf32-i386


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
  800031:	e8 02 01 00 00       	call   800138 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>


void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	//uint32 size = 2*1024*1024 +120*4096+1;
	//uint32 size = 1*1024*1024 + 256*1024;
	//uint32 size = 1*1024*1024;
	uint32 size = 100;
  80003e:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%ebp)

	unsigned char *x = malloc(sizeof(unsigned char)*size) ;
  800045:	83 ec 0c             	sub    $0xc,%esp
  800048:	ff 75 f0             	pushl  -0x10(%ebp)
  80004b:	e8 82 10 00 00       	call   8010d2 <malloc>
  800050:	83 c4 10             	add    $0x10,%esp
  800053:	89 45 ec             	mov    %eax,-0x14(%ebp)
	atomic_cprintf("x allocated at %x\n",x);
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	ff 75 ec             	pushl  -0x14(%ebp)
  80005c:	68 a0 1d 80 00       	push   $0x801da0
  800061:	e8 d5 02 00 00       	call   80033b <atomic_cprintf>
  800066:	83 c4 10             	add    $0x10,%esp

	//unsigned char *z = malloc(sizeof(unsigned char)*size) ;
	//cprintf("z allocated at %x\n",z);
	
	int i ;
	for (i = 0 ; i < size ; i++)
  800069:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800070:	eb 20                	jmp    800092 <_main+0x5a>
	{
		x[i] = i%256 ;
  800072:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800075:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800078:	01 c2                	add    %eax,%edx
  80007a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80007d:	25 ff 00 00 80       	and    $0x800000ff,%eax
  800082:	85 c0                	test   %eax,%eax
  800084:	79 07                	jns    80008d <_main+0x55>
  800086:	48                   	dec    %eax
  800087:	0d 00 ff ff ff       	or     $0xffffff00,%eax
  80008c:	40                   	inc    %eax
  80008d:	88 02                	mov    %al,(%edx)

	//unsigned char *z = malloc(sizeof(unsigned char)*size) ;
	//cprintf("z allocated at %x\n",z);
	
	int i ;
	for (i = 0 ; i < size ; i++)
  80008f:	ff 45 f4             	incl   -0xc(%ebp)
  800092:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800095:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800098:	72 d8                	jb     800072 <_main+0x3a>
		////z[i] = (int)(x[i]  * y[i]);
		////z[i] = i%256;
	}

	
	for (i = size-7 ; i < size ; i++)
  80009a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80009d:	83 e8 07             	sub    $0x7,%eax
  8000a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8000a3:	eb 24                	jmp    8000c9 <_main+0x91>
		atomic_cprintf("x[%d] = %d\n",i, x[i]);
  8000a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ab:	01 d0                	add    %edx,%eax
  8000ad:	8a 00                	mov    (%eax),%al
  8000af:	0f b6 c0             	movzbl %al,%eax
  8000b2:	83 ec 04             	sub    $0x4,%esp
  8000b5:	50                   	push   %eax
  8000b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8000b9:	68 b3 1d 80 00       	push   $0x801db3
  8000be:	e8 78 02 00 00       	call   80033b <atomic_cprintf>
  8000c3:	83 c4 10             	add    $0x10,%esp
		////z[i] = (int)(x[i]  * y[i]);
		////z[i] = i%256;
	}

	
	for (i = size-7 ; i < size ; i++)
  8000c6:	ff 45 f4             	incl   -0xc(%ebp)
  8000c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000cf:	72 d4                	jb     8000a5 <_main+0x6d>
		atomic_cprintf("x[%d] = %d\n",i, x[i]);
	
	free(x);
  8000d1:	83 ec 0c             	sub    $0xc,%esp
  8000d4:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d7:	e8 17 11 00 00       	call   8011f3 <free>
  8000dc:	83 c4 10             	add    $0x10,%esp

	x = malloc(sizeof(unsigned char)*size) ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	ff 75 f0             	pushl  -0x10(%ebp)
  8000e5:	e8 e8 0f 00 00       	call   8010d2 <malloc>
  8000ea:	83 c4 10             	add    $0x10,%esp
  8000ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
	
	for (i = size-7 ; i < size ; i++)
  8000f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000f3:	83 e8 07             	sub    $0x7,%eax
  8000f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8000f9:	eb 24                	jmp    80011f <_main+0xe7>
	{
		atomic_cprintf("x[%d] = %d\n",i,x[i]);
  8000fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800101:	01 d0                	add    %edx,%eax
  800103:	8a 00                	mov    (%eax),%al
  800105:	0f b6 c0             	movzbl %al,%eax
  800108:	83 ec 04             	sub    $0x4,%esp
  80010b:	50                   	push   %eax
  80010c:	ff 75 f4             	pushl  -0xc(%ebp)
  80010f:	68 b3 1d 80 00       	push   $0x801db3
  800114:	e8 22 02 00 00       	call   80033b <atomic_cprintf>
  800119:	83 c4 10             	add    $0x10,%esp
	
	free(x);

	x = malloc(sizeof(unsigned char)*size) ;
	
	for (i = size-7 ; i < size ; i++)
  80011c:	ff 45 f4             	incl   -0xc(%ebp)
  80011f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800122:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800125:	72 d4                	jb     8000fb <_main+0xc3>
	{
		atomic_cprintf("x[%d] = %d\n",i,x[i]);
	}

	free(x);
  800127:	83 ec 0c             	sub    $0xc,%esp
  80012a:	ff 75 ec             	pushl  -0x14(%ebp)
  80012d:	e8 c1 10 00 00       	call   8011f3 <free>
  800132:	83 c4 10             	add    $0x10,%esp
	
	return;	
  800135:	90                   	nop
}
  800136:	c9                   	leave  
  800137:	c3                   	ret    

00800138 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800138:	55                   	push   %ebp
  800139:	89 e5                	mov    %esp,%ebp
  80013b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80013e:	e8 86 12 00 00       	call   8013c9 <sys_getenvindex>
  800143:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800146:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800149:	89 d0                	mov    %edx,%eax
  80014b:	01 c0                	add    %eax,%eax
  80014d:	01 d0                	add    %edx,%eax
  80014f:	c1 e0 02             	shl    $0x2,%eax
  800152:	01 d0                	add    %edx,%eax
  800154:	c1 e0 06             	shl    $0x6,%eax
  800157:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80015c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800161:	a1 20 30 80 00       	mov    0x803020,%eax
  800166:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80016c:	84 c0                	test   %al,%al
  80016e:	74 0f                	je     80017f <libmain+0x47>
		binaryname = myEnv->prog_name;
  800170:	a1 20 30 80 00       	mov    0x803020,%eax
  800175:	05 f4 02 00 00       	add    $0x2f4,%eax
  80017a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80017f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800183:	7e 0a                	jle    80018f <libmain+0x57>
		binaryname = argv[0];
  800185:	8b 45 0c             	mov    0xc(%ebp),%eax
  800188:	8b 00                	mov    (%eax),%eax
  80018a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80018f:	83 ec 08             	sub    $0x8,%esp
  800192:	ff 75 0c             	pushl  0xc(%ebp)
  800195:	ff 75 08             	pushl  0x8(%ebp)
  800198:	e8 9b fe ff ff       	call   800038 <_main>
  80019d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001a0:	e8 bf 13 00 00       	call   801564 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001a5:	83 ec 0c             	sub    $0xc,%esp
  8001a8:	68 d8 1d 80 00       	push   $0x801dd8
  8001ad:	e8 5c 01 00 00       	call   80030e <cprintf>
  8001b2:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c5:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001cb:	83 ec 04             	sub    $0x4,%esp
  8001ce:	52                   	push   %edx
  8001cf:	50                   	push   %eax
  8001d0:	68 00 1e 80 00       	push   $0x801e00
  8001d5:	e8 34 01 00 00       	call   80030e <cprintf>
  8001da:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e2:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8001e8:	83 ec 08             	sub    $0x8,%esp
  8001eb:	50                   	push   %eax
  8001ec:	68 25 1e 80 00       	push   $0x801e25
  8001f1:	e8 18 01 00 00       	call   80030e <cprintf>
  8001f6:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001f9:	83 ec 0c             	sub    $0xc,%esp
  8001fc:	68 d8 1d 80 00       	push   $0x801dd8
  800201:	e8 08 01 00 00       	call   80030e <cprintf>
  800206:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800209:	e8 70 13 00 00       	call   80157e <sys_enable_interrupt>

	// exit gracefully
	exit();
  80020e:	e8 19 00 00 00       	call   80022c <exit>
}
  800213:	90                   	nop
  800214:	c9                   	leave  
  800215:	c3                   	ret    

00800216 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800216:	55                   	push   %ebp
  800217:	89 e5                	mov    %esp,%ebp
  800219:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80021c:	83 ec 0c             	sub    $0xc,%esp
  80021f:	6a 00                	push   $0x0
  800221:	e8 6f 11 00 00       	call   801395 <sys_env_destroy>
  800226:	83 c4 10             	add    $0x10,%esp
}
  800229:	90                   	nop
  80022a:	c9                   	leave  
  80022b:	c3                   	ret    

0080022c <exit>:

void
exit(void)
{
  80022c:	55                   	push   %ebp
  80022d:	89 e5                	mov    %esp,%ebp
  80022f:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800232:	e8 c4 11 00 00       	call   8013fb <sys_env_exit>
}
  800237:	90                   	nop
  800238:	c9                   	leave  
  800239:	c3                   	ret    

0080023a <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80023a:	55                   	push   %ebp
  80023b:	89 e5                	mov    %esp,%ebp
  80023d:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800240:	8b 45 0c             	mov    0xc(%ebp),%eax
  800243:	8b 00                	mov    (%eax),%eax
  800245:	8d 48 01             	lea    0x1(%eax),%ecx
  800248:	8b 55 0c             	mov    0xc(%ebp),%edx
  80024b:	89 0a                	mov    %ecx,(%edx)
  80024d:	8b 55 08             	mov    0x8(%ebp),%edx
  800250:	88 d1                	mov    %dl,%cl
  800252:	8b 55 0c             	mov    0xc(%ebp),%edx
  800255:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800259:	8b 45 0c             	mov    0xc(%ebp),%eax
  80025c:	8b 00                	mov    (%eax),%eax
  80025e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800263:	75 2c                	jne    800291 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800265:	a0 24 30 80 00       	mov    0x803024,%al
  80026a:	0f b6 c0             	movzbl %al,%eax
  80026d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800270:	8b 12                	mov    (%edx),%edx
  800272:	89 d1                	mov    %edx,%ecx
  800274:	8b 55 0c             	mov    0xc(%ebp),%edx
  800277:	83 c2 08             	add    $0x8,%edx
  80027a:	83 ec 04             	sub    $0x4,%esp
  80027d:	50                   	push   %eax
  80027e:	51                   	push   %ecx
  80027f:	52                   	push   %edx
  800280:	e8 ce 10 00 00       	call   801353 <sys_cputs>
  800285:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800288:	8b 45 0c             	mov    0xc(%ebp),%eax
  80028b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800291:	8b 45 0c             	mov    0xc(%ebp),%eax
  800294:	8b 40 04             	mov    0x4(%eax),%eax
  800297:	8d 50 01             	lea    0x1(%eax),%edx
  80029a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80029d:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002a0:	90                   	nop
  8002a1:	c9                   	leave  
  8002a2:	c3                   	ret    

008002a3 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002a3:	55                   	push   %ebp
  8002a4:	89 e5                	mov    %esp,%ebp
  8002a6:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002ac:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002b3:	00 00 00 
	b.cnt = 0;
  8002b6:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002bd:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002c0:	ff 75 0c             	pushl  0xc(%ebp)
  8002c3:	ff 75 08             	pushl  0x8(%ebp)
  8002c6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002cc:	50                   	push   %eax
  8002cd:	68 3a 02 80 00       	push   $0x80023a
  8002d2:	e8 11 02 00 00       	call   8004e8 <vprintfmt>
  8002d7:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002da:	a0 24 30 80 00       	mov    0x803024,%al
  8002df:	0f b6 c0             	movzbl %al,%eax
  8002e2:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002e8:	83 ec 04             	sub    $0x4,%esp
  8002eb:	50                   	push   %eax
  8002ec:	52                   	push   %edx
  8002ed:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002f3:	83 c0 08             	add    $0x8,%eax
  8002f6:	50                   	push   %eax
  8002f7:	e8 57 10 00 00       	call   801353 <sys_cputs>
  8002fc:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002ff:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800306:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80030c:	c9                   	leave  
  80030d:	c3                   	ret    

0080030e <cprintf>:

int cprintf(const char *fmt, ...) {
  80030e:	55                   	push   %ebp
  80030f:	89 e5                	mov    %esp,%ebp
  800311:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800314:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80031b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80031e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800321:	8b 45 08             	mov    0x8(%ebp),%eax
  800324:	83 ec 08             	sub    $0x8,%esp
  800327:	ff 75 f4             	pushl  -0xc(%ebp)
  80032a:	50                   	push   %eax
  80032b:	e8 73 ff ff ff       	call   8002a3 <vcprintf>
  800330:	83 c4 10             	add    $0x10,%esp
  800333:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800336:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800339:	c9                   	leave  
  80033a:	c3                   	ret    

0080033b <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80033b:	55                   	push   %ebp
  80033c:	89 e5                	mov    %esp,%ebp
  80033e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800341:	e8 1e 12 00 00       	call   801564 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800346:	8d 45 0c             	lea    0xc(%ebp),%eax
  800349:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	83 ec 08             	sub    $0x8,%esp
  800352:	ff 75 f4             	pushl  -0xc(%ebp)
  800355:	50                   	push   %eax
  800356:	e8 48 ff ff ff       	call   8002a3 <vcprintf>
  80035b:	83 c4 10             	add    $0x10,%esp
  80035e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800361:	e8 18 12 00 00       	call   80157e <sys_enable_interrupt>
	return cnt;
  800366:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800369:	c9                   	leave  
  80036a:	c3                   	ret    

0080036b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80036b:	55                   	push   %ebp
  80036c:	89 e5                	mov    %esp,%ebp
  80036e:	53                   	push   %ebx
  80036f:	83 ec 14             	sub    $0x14,%esp
  800372:	8b 45 10             	mov    0x10(%ebp),%eax
  800375:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800378:	8b 45 14             	mov    0x14(%ebp),%eax
  80037b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80037e:	8b 45 18             	mov    0x18(%ebp),%eax
  800381:	ba 00 00 00 00       	mov    $0x0,%edx
  800386:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800389:	77 55                	ja     8003e0 <printnum+0x75>
  80038b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80038e:	72 05                	jb     800395 <printnum+0x2a>
  800390:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800393:	77 4b                	ja     8003e0 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800395:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800398:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80039b:	8b 45 18             	mov    0x18(%ebp),%eax
  80039e:	ba 00 00 00 00       	mov    $0x0,%edx
  8003a3:	52                   	push   %edx
  8003a4:	50                   	push   %eax
  8003a5:	ff 75 f4             	pushl  -0xc(%ebp)
  8003a8:	ff 75 f0             	pushl  -0x10(%ebp)
  8003ab:	e8 74 17 00 00       	call   801b24 <__udivdi3>
  8003b0:	83 c4 10             	add    $0x10,%esp
  8003b3:	83 ec 04             	sub    $0x4,%esp
  8003b6:	ff 75 20             	pushl  0x20(%ebp)
  8003b9:	53                   	push   %ebx
  8003ba:	ff 75 18             	pushl  0x18(%ebp)
  8003bd:	52                   	push   %edx
  8003be:	50                   	push   %eax
  8003bf:	ff 75 0c             	pushl  0xc(%ebp)
  8003c2:	ff 75 08             	pushl  0x8(%ebp)
  8003c5:	e8 a1 ff ff ff       	call   80036b <printnum>
  8003ca:	83 c4 20             	add    $0x20,%esp
  8003cd:	eb 1a                	jmp    8003e9 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003cf:	83 ec 08             	sub    $0x8,%esp
  8003d2:	ff 75 0c             	pushl  0xc(%ebp)
  8003d5:	ff 75 20             	pushl  0x20(%ebp)
  8003d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003db:	ff d0                	call   *%eax
  8003dd:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003e0:	ff 4d 1c             	decl   0x1c(%ebp)
  8003e3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003e7:	7f e6                	jg     8003cf <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003e9:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003ec:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003f7:	53                   	push   %ebx
  8003f8:	51                   	push   %ecx
  8003f9:	52                   	push   %edx
  8003fa:	50                   	push   %eax
  8003fb:	e8 34 18 00 00       	call   801c34 <__umoddi3>
  800400:	83 c4 10             	add    $0x10,%esp
  800403:	05 54 20 80 00       	add    $0x802054,%eax
  800408:	8a 00                	mov    (%eax),%al
  80040a:	0f be c0             	movsbl %al,%eax
  80040d:	83 ec 08             	sub    $0x8,%esp
  800410:	ff 75 0c             	pushl  0xc(%ebp)
  800413:	50                   	push   %eax
  800414:	8b 45 08             	mov    0x8(%ebp),%eax
  800417:	ff d0                	call   *%eax
  800419:	83 c4 10             	add    $0x10,%esp
}
  80041c:	90                   	nop
  80041d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800420:	c9                   	leave  
  800421:	c3                   	ret    

00800422 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800422:	55                   	push   %ebp
  800423:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800425:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800429:	7e 1c                	jle    800447 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80042b:	8b 45 08             	mov    0x8(%ebp),%eax
  80042e:	8b 00                	mov    (%eax),%eax
  800430:	8d 50 08             	lea    0x8(%eax),%edx
  800433:	8b 45 08             	mov    0x8(%ebp),%eax
  800436:	89 10                	mov    %edx,(%eax)
  800438:	8b 45 08             	mov    0x8(%ebp),%eax
  80043b:	8b 00                	mov    (%eax),%eax
  80043d:	83 e8 08             	sub    $0x8,%eax
  800440:	8b 50 04             	mov    0x4(%eax),%edx
  800443:	8b 00                	mov    (%eax),%eax
  800445:	eb 40                	jmp    800487 <getuint+0x65>
	else if (lflag)
  800447:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80044b:	74 1e                	je     80046b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80044d:	8b 45 08             	mov    0x8(%ebp),%eax
  800450:	8b 00                	mov    (%eax),%eax
  800452:	8d 50 04             	lea    0x4(%eax),%edx
  800455:	8b 45 08             	mov    0x8(%ebp),%eax
  800458:	89 10                	mov    %edx,(%eax)
  80045a:	8b 45 08             	mov    0x8(%ebp),%eax
  80045d:	8b 00                	mov    (%eax),%eax
  80045f:	83 e8 04             	sub    $0x4,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	ba 00 00 00 00       	mov    $0x0,%edx
  800469:	eb 1c                	jmp    800487 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	8b 00                	mov    (%eax),%eax
  800470:	8d 50 04             	lea    0x4(%eax),%edx
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	89 10                	mov    %edx,(%eax)
  800478:	8b 45 08             	mov    0x8(%ebp),%eax
  80047b:	8b 00                	mov    (%eax),%eax
  80047d:	83 e8 04             	sub    $0x4,%eax
  800480:	8b 00                	mov    (%eax),%eax
  800482:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800487:	5d                   	pop    %ebp
  800488:	c3                   	ret    

00800489 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800489:	55                   	push   %ebp
  80048a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80048c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800490:	7e 1c                	jle    8004ae <getint+0x25>
		return va_arg(*ap, long long);
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
  8004ac:	eb 38                	jmp    8004e6 <getint+0x5d>
	else if (lflag)
  8004ae:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004b2:	74 1a                	je     8004ce <getint+0x45>
		return va_arg(*ap, long);
  8004b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b7:	8b 00                	mov    (%eax),%eax
  8004b9:	8d 50 04             	lea    0x4(%eax),%edx
  8004bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bf:	89 10                	mov    %edx,(%eax)
  8004c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c4:	8b 00                	mov    (%eax),%eax
  8004c6:	83 e8 04             	sub    $0x4,%eax
  8004c9:	8b 00                	mov    (%eax),%eax
  8004cb:	99                   	cltd   
  8004cc:	eb 18                	jmp    8004e6 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d1:	8b 00                	mov    (%eax),%eax
  8004d3:	8d 50 04             	lea    0x4(%eax),%edx
  8004d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d9:	89 10                	mov    %edx,(%eax)
  8004db:	8b 45 08             	mov    0x8(%ebp),%eax
  8004de:	8b 00                	mov    (%eax),%eax
  8004e0:	83 e8 04             	sub    $0x4,%eax
  8004e3:	8b 00                	mov    (%eax),%eax
  8004e5:	99                   	cltd   
}
  8004e6:	5d                   	pop    %ebp
  8004e7:	c3                   	ret    

008004e8 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004e8:	55                   	push   %ebp
  8004e9:	89 e5                	mov    %esp,%ebp
  8004eb:	56                   	push   %esi
  8004ec:	53                   	push   %ebx
  8004ed:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004f0:	eb 17                	jmp    800509 <vprintfmt+0x21>
			if (ch == '\0')
  8004f2:	85 db                	test   %ebx,%ebx
  8004f4:	0f 84 af 03 00 00    	je     8008a9 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004fa:	83 ec 08             	sub    $0x8,%esp
  8004fd:	ff 75 0c             	pushl  0xc(%ebp)
  800500:	53                   	push   %ebx
  800501:	8b 45 08             	mov    0x8(%ebp),%eax
  800504:	ff d0                	call   *%eax
  800506:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800509:	8b 45 10             	mov    0x10(%ebp),%eax
  80050c:	8d 50 01             	lea    0x1(%eax),%edx
  80050f:	89 55 10             	mov    %edx,0x10(%ebp)
  800512:	8a 00                	mov    (%eax),%al
  800514:	0f b6 d8             	movzbl %al,%ebx
  800517:	83 fb 25             	cmp    $0x25,%ebx
  80051a:	75 d6                	jne    8004f2 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80051c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800520:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800527:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80052e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800535:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80053c:	8b 45 10             	mov    0x10(%ebp),%eax
  80053f:	8d 50 01             	lea    0x1(%eax),%edx
  800542:	89 55 10             	mov    %edx,0x10(%ebp)
  800545:	8a 00                	mov    (%eax),%al
  800547:	0f b6 d8             	movzbl %al,%ebx
  80054a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80054d:	83 f8 55             	cmp    $0x55,%eax
  800550:	0f 87 2b 03 00 00    	ja     800881 <vprintfmt+0x399>
  800556:	8b 04 85 78 20 80 00 	mov    0x802078(,%eax,4),%eax
  80055d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80055f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800563:	eb d7                	jmp    80053c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800565:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800569:	eb d1                	jmp    80053c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80056b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800572:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800575:	89 d0                	mov    %edx,%eax
  800577:	c1 e0 02             	shl    $0x2,%eax
  80057a:	01 d0                	add    %edx,%eax
  80057c:	01 c0                	add    %eax,%eax
  80057e:	01 d8                	add    %ebx,%eax
  800580:	83 e8 30             	sub    $0x30,%eax
  800583:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800586:	8b 45 10             	mov    0x10(%ebp),%eax
  800589:	8a 00                	mov    (%eax),%al
  80058b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80058e:	83 fb 2f             	cmp    $0x2f,%ebx
  800591:	7e 3e                	jle    8005d1 <vprintfmt+0xe9>
  800593:	83 fb 39             	cmp    $0x39,%ebx
  800596:	7f 39                	jg     8005d1 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800598:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80059b:	eb d5                	jmp    800572 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80059d:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a0:	83 c0 04             	add    $0x4,%eax
  8005a3:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a9:	83 e8 04             	sub    $0x4,%eax
  8005ac:	8b 00                	mov    (%eax),%eax
  8005ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005b1:	eb 1f                	jmp    8005d2 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005b3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005b7:	79 83                	jns    80053c <vprintfmt+0x54>
				width = 0;
  8005b9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005c0:	e9 77 ff ff ff       	jmp    80053c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005c5:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005cc:	e9 6b ff ff ff       	jmp    80053c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005d1:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005d6:	0f 89 60 ff ff ff    	jns    80053c <vprintfmt+0x54>
				width = precision, precision = -1;
  8005dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005e2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005e9:	e9 4e ff ff ff       	jmp    80053c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005ee:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005f1:	e9 46 ff ff ff       	jmp    80053c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f9:	83 c0 04             	add    $0x4,%eax
  8005fc:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ff:	8b 45 14             	mov    0x14(%ebp),%eax
  800602:	83 e8 04             	sub    $0x4,%eax
  800605:	8b 00                	mov    (%eax),%eax
  800607:	83 ec 08             	sub    $0x8,%esp
  80060a:	ff 75 0c             	pushl  0xc(%ebp)
  80060d:	50                   	push   %eax
  80060e:	8b 45 08             	mov    0x8(%ebp),%eax
  800611:	ff d0                	call   *%eax
  800613:	83 c4 10             	add    $0x10,%esp
			break;
  800616:	e9 89 02 00 00       	jmp    8008a4 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80061b:	8b 45 14             	mov    0x14(%ebp),%eax
  80061e:	83 c0 04             	add    $0x4,%eax
  800621:	89 45 14             	mov    %eax,0x14(%ebp)
  800624:	8b 45 14             	mov    0x14(%ebp),%eax
  800627:	83 e8 04             	sub    $0x4,%eax
  80062a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80062c:	85 db                	test   %ebx,%ebx
  80062e:	79 02                	jns    800632 <vprintfmt+0x14a>
				err = -err;
  800630:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800632:	83 fb 64             	cmp    $0x64,%ebx
  800635:	7f 0b                	jg     800642 <vprintfmt+0x15a>
  800637:	8b 34 9d c0 1e 80 00 	mov    0x801ec0(,%ebx,4),%esi
  80063e:	85 f6                	test   %esi,%esi
  800640:	75 19                	jne    80065b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800642:	53                   	push   %ebx
  800643:	68 65 20 80 00       	push   $0x802065
  800648:	ff 75 0c             	pushl  0xc(%ebp)
  80064b:	ff 75 08             	pushl  0x8(%ebp)
  80064e:	e8 5e 02 00 00       	call   8008b1 <printfmt>
  800653:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800656:	e9 49 02 00 00       	jmp    8008a4 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80065b:	56                   	push   %esi
  80065c:	68 6e 20 80 00       	push   $0x80206e
  800661:	ff 75 0c             	pushl  0xc(%ebp)
  800664:	ff 75 08             	pushl  0x8(%ebp)
  800667:	e8 45 02 00 00       	call   8008b1 <printfmt>
  80066c:	83 c4 10             	add    $0x10,%esp
			break;
  80066f:	e9 30 02 00 00       	jmp    8008a4 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800674:	8b 45 14             	mov    0x14(%ebp),%eax
  800677:	83 c0 04             	add    $0x4,%eax
  80067a:	89 45 14             	mov    %eax,0x14(%ebp)
  80067d:	8b 45 14             	mov    0x14(%ebp),%eax
  800680:	83 e8 04             	sub    $0x4,%eax
  800683:	8b 30                	mov    (%eax),%esi
  800685:	85 f6                	test   %esi,%esi
  800687:	75 05                	jne    80068e <vprintfmt+0x1a6>
				p = "(null)";
  800689:	be 71 20 80 00       	mov    $0x802071,%esi
			if (width > 0 && padc != '-')
  80068e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800692:	7e 6d                	jle    800701 <vprintfmt+0x219>
  800694:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800698:	74 67                	je     800701 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80069a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80069d:	83 ec 08             	sub    $0x8,%esp
  8006a0:	50                   	push   %eax
  8006a1:	56                   	push   %esi
  8006a2:	e8 0c 03 00 00       	call   8009b3 <strnlen>
  8006a7:	83 c4 10             	add    $0x10,%esp
  8006aa:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006ad:	eb 16                	jmp    8006c5 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006af:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006b3:	83 ec 08             	sub    $0x8,%esp
  8006b6:	ff 75 0c             	pushl  0xc(%ebp)
  8006b9:	50                   	push   %eax
  8006ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bd:	ff d0                	call   *%eax
  8006bf:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006c2:	ff 4d e4             	decl   -0x1c(%ebp)
  8006c5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006c9:	7f e4                	jg     8006af <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006cb:	eb 34                	jmp    800701 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006cd:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006d1:	74 1c                	je     8006ef <vprintfmt+0x207>
  8006d3:	83 fb 1f             	cmp    $0x1f,%ebx
  8006d6:	7e 05                	jle    8006dd <vprintfmt+0x1f5>
  8006d8:	83 fb 7e             	cmp    $0x7e,%ebx
  8006db:	7e 12                	jle    8006ef <vprintfmt+0x207>
					putch('?', putdat);
  8006dd:	83 ec 08             	sub    $0x8,%esp
  8006e0:	ff 75 0c             	pushl  0xc(%ebp)
  8006e3:	6a 3f                	push   $0x3f
  8006e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e8:	ff d0                	call   *%eax
  8006ea:	83 c4 10             	add    $0x10,%esp
  8006ed:	eb 0f                	jmp    8006fe <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006ef:	83 ec 08             	sub    $0x8,%esp
  8006f2:	ff 75 0c             	pushl  0xc(%ebp)
  8006f5:	53                   	push   %ebx
  8006f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f9:	ff d0                	call   *%eax
  8006fb:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006fe:	ff 4d e4             	decl   -0x1c(%ebp)
  800701:	89 f0                	mov    %esi,%eax
  800703:	8d 70 01             	lea    0x1(%eax),%esi
  800706:	8a 00                	mov    (%eax),%al
  800708:	0f be d8             	movsbl %al,%ebx
  80070b:	85 db                	test   %ebx,%ebx
  80070d:	74 24                	je     800733 <vprintfmt+0x24b>
  80070f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800713:	78 b8                	js     8006cd <vprintfmt+0x1e5>
  800715:	ff 4d e0             	decl   -0x20(%ebp)
  800718:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80071c:	79 af                	jns    8006cd <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80071e:	eb 13                	jmp    800733 <vprintfmt+0x24b>
				putch(' ', putdat);
  800720:	83 ec 08             	sub    $0x8,%esp
  800723:	ff 75 0c             	pushl  0xc(%ebp)
  800726:	6a 20                	push   $0x20
  800728:	8b 45 08             	mov    0x8(%ebp),%eax
  80072b:	ff d0                	call   *%eax
  80072d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800730:	ff 4d e4             	decl   -0x1c(%ebp)
  800733:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800737:	7f e7                	jg     800720 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800739:	e9 66 01 00 00       	jmp    8008a4 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80073e:	83 ec 08             	sub    $0x8,%esp
  800741:	ff 75 e8             	pushl  -0x18(%ebp)
  800744:	8d 45 14             	lea    0x14(%ebp),%eax
  800747:	50                   	push   %eax
  800748:	e8 3c fd ff ff       	call   800489 <getint>
  80074d:	83 c4 10             	add    $0x10,%esp
  800750:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800753:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800756:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800759:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80075c:	85 d2                	test   %edx,%edx
  80075e:	79 23                	jns    800783 <vprintfmt+0x29b>
				putch('-', putdat);
  800760:	83 ec 08             	sub    $0x8,%esp
  800763:	ff 75 0c             	pushl  0xc(%ebp)
  800766:	6a 2d                	push   $0x2d
  800768:	8b 45 08             	mov    0x8(%ebp),%eax
  80076b:	ff d0                	call   *%eax
  80076d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800770:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800773:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800776:	f7 d8                	neg    %eax
  800778:	83 d2 00             	adc    $0x0,%edx
  80077b:	f7 da                	neg    %edx
  80077d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800780:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800783:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80078a:	e9 bc 00 00 00       	jmp    80084b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80078f:	83 ec 08             	sub    $0x8,%esp
  800792:	ff 75 e8             	pushl  -0x18(%ebp)
  800795:	8d 45 14             	lea    0x14(%ebp),%eax
  800798:	50                   	push   %eax
  800799:	e8 84 fc ff ff       	call   800422 <getuint>
  80079e:	83 c4 10             	add    $0x10,%esp
  8007a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007a7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007ae:	e9 98 00 00 00       	jmp    80084b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007b3:	83 ec 08             	sub    $0x8,%esp
  8007b6:	ff 75 0c             	pushl  0xc(%ebp)
  8007b9:	6a 58                	push   $0x58
  8007bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007be:	ff d0                	call   *%eax
  8007c0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007c3:	83 ec 08             	sub    $0x8,%esp
  8007c6:	ff 75 0c             	pushl  0xc(%ebp)
  8007c9:	6a 58                	push   $0x58
  8007cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ce:	ff d0                	call   *%eax
  8007d0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007d3:	83 ec 08             	sub    $0x8,%esp
  8007d6:	ff 75 0c             	pushl  0xc(%ebp)
  8007d9:	6a 58                	push   $0x58
  8007db:	8b 45 08             	mov    0x8(%ebp),%eax
  8007de:	ff d0                	call   *%eax
  8007e0:	83 c4 10             	add    $0x10,%esp
			break;
  8007e3:	e9 bc 00 00 00       	jmp    8008a4 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007e8:	83 ec 08             	sub    $0x8,%esp
  8007eb:	ff 75 0c             	pushl  0xc(%ebp)
  8007ee:	6a 30                	push   $0x30
  8007f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f3:	ff d0                	call   *%eax
  8007f5:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007f8:	83 ec 08             	sub    $0x8,%esp
  8007fb:	ff 75 0c             	pushl  0xc(%ebp)
  8007fe:	6a 78                	push   $0x78
  800800:	8b 45 08             	mov    0x8(%ebp),%eax
  800803:	ff d0                	call   *%eax
  800805:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800808:	8b 45 14             	mov    0x14(%ebp),%eax
  80080b:	83 c0 04             	add    $0x4,%eax
  80080e:	89 45 14             	mov    %eax,0x14(%ebp)
  800811:	8b 45 14             	mov    0x14(%ebp),%eax
  800814:	83 e8 04             	sub    $0x4,%eax
  800817:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800819:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80081c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800823:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80082a:	eb 1f                	jmp    80084b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80082c:	83 ec 08             	sub    $0x8,%esp
  80082f:	ff 75 e8             	pushl  -0x18(%ebp)
  800832:	8d 45 14             	lea    0x14(%ebp),%eax
  800835:	50                   	push   %eax
  800836:	e8 e7 fb ff ff       	call   800422 <getuint>
  80083b:	83 c4 10             	add    $0x10,%esp
  80083e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800841:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800844:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80084b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80084f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800852:	83 ec 04             	sub    $0x4,%esp
  800855:	52                   	push   %edx
  800856:	ff 75 e4             	pushl  -0x1c(%ebp)
  800859:	50                   	push   %eax
  80085a:	ff 75 f4             	pushl  -0xc(%ebp)
  80085d:	ff 75 f0             	pushl  -0x10(%ebp)
  800860:	ff 75 0c             	pushl  0xc(%ebp)
  800863:	ff 75 08             	pushl  0x8(%ebp)
  800866:	e8 00 fb ff ff       	call   80036b <printnum>
  80086b:	83 c4 20             	add    $0x20,%esp
			break;
  80086e:	eb 34                	jmp    8008a4 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800870:	83 ec 08             	sub    $0x8,%esp
  800873:	ff 75 0c             	pushl  0xc(%ebp)
  800876:	53                   	push   %ebx
  800877:	8b 45 08             	mov    0x8(%ebp),%eax
  80087a:	ff d0                	call   *%eax
  80087c:	83 c4 10             	add    $0x10,%esp
			break;
  80087f:	eb 23                	jmp    8008a4 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800881:	83 ec 08             	sub    $0x8,%esp
  800884:	ff 75 0c             	pushl  0xc(%ebp)
  800887:	6a 25                	push   $0x25
  800889:	8b 45 08             	mov    0x8(%ebp),%eax
  80088c:	ff d0                	call   *%eax
  80088e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800891:	ff 4d 10             	decl   0x10(%ebp)
  800894:	eb 03                	jmp    800899 <vprintfmt+0x3b1>
  800896:	ff 4d 10             	decl   0x10(%ebp)
  800899:	8b 45 10             	mov    0x10(%ebp),%eax
  80089c:	48                   	dec    %eax
  80089d:	8a 00                	mov    (%eax),%al
  80089f:	3c 25                	cmp    $0x25,%al
  8008a1:	75 f3                	jne    800896 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008a3:	90                   	nop
		}
	}
  8008a4:	e9 47 fc ff ff       	jmp    8004f0 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008a9:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008aa:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008ad:	5b                   	pop    %ebx
  8008ae:	5e                   	pop    %esi
  8008af:	5d                   	pop    %ebp
  8008b0:	c3                   	ret    

008008b1 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008b1:	55                   	push   %ebp
  8008b2:	89 e5                	mov    %esp,%ebp
  8008b4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008b7:	8d 45 10             	lea    0x10(%ebp),%eax
  8008ba:	83 c0 04             	add    $0x4,%eax
  8008bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c3:	ff 75 f4             	pushl  -0xc(%ebp)
  8008c6:	50                   	push   %eax
  8008c7:	ff 75 0c             	pushl  0xc(%ebp)
  8008ca:	ff 75 08             	pushl  0x8(%ebp)
  8008cd:	e8 16 fc ff ff       	call   8004e8 <vprintfmt>
  8008d2:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008d5:	90                   	nop
  8008d6:	c9                   	leave  
  8008d7:	c3                   	ret    

008008d8 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008d8:	55                   	push   %ebp
  8008d9:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008de:	8b 40 08             	mov    0x8(%eax),%eax
  8008e1:	8d 50 01             	lea    0x1(%eax),%edx
  8008e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e7:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ed:	8b 10                	mov    (%eax),%edx
  8008ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f2:	8b 40 04             	mov    0x4(%eax),%eax
  8008f5:	39 c2                	cmp    %eax,%edx
  8008f7:	73 12                	jae    80090b <sprintputch+0x33>
		*b->buf++ = ch;
  8008f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fc:	8b 00                	mov    (%eax),%eax
  8008fe:	8d 48 01             	lea    0x1(%eax),%ecx
  800901:	8b 55 0c             	mov    0xc(%ebp),%edx
  800904:	89 0a                	mov    %ecx,(%edx)
  800906:	8b 55 08             	mov    0x8(%ebp),%edx
  800909:	88 10                	mov    %dl,(%eax)
}
  80090b:	90                   	nop
  80090c:	5d                   	pop    %ebp
  80090d:	c3                   	ret    

0080090e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80090e:	55                   	push   %ebp
  80090f:	89 e5                	mov    %esp,%ebp
  800911:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800914:	8b 45 08             	mov    0x8(%ebp),%eax
  800917:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80091a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800920:	8b 45 08             	mov    0x8(%ebp),%eax
  800923:	01 d0                	add    %edx,%eax
  800925:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800928:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80092f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800933:	74 06                	je     80093b <vsnprintf+0x2d>
  800935:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800939:	7f 07                	jg     800942 <vsnprintf+0x34>
		return -E_INVAL;
  80093b:	b8 03 00 00 00       	mov    $0x3,%eax
  800940:	eb 20                	jmp    800962 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800942:	ff 75 14             	pushl  0x14(%ebp)
  800945:	ff 75 10             	pushl  0x10(%ebp)
  800948:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80094b:	50                   	push   %eax
  80094c:	68 d8 08 80 00       	push   $0x8008d8
  800951:	e8 92 fb ff ff       	call   8004e8 <vprintfmt>
  800956:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800959:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80095c:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80095f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800962:	c9                   	leave  
  800963:	c3                   	ret    

00800964 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800964:	55                   	push   %ebp
  800965:	89 e5                	mov    %esp,%ebp
  800967:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80096a:	8d 45 10             	lea    0x10(%ebp),%eax
  80096d:	83 c0 04             	add    $0x4,%eax
  800970:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800973:	8b 45 10             	mov    0x10(%ebp),%eax
  800976:	ff 75 f4             	pushl  -0xc(%ebp)
  800979:	50                   	push   %eax
  80097a:	ff 75 0c             	pushl  0xc(%ebp)
  80097d:	ff 75 08             	pushl  0x8(%ebp)
  800980:	e8 89 ff ff ff       	call   80090e <vsnprintf>
  800985:	83 c4 10             	add    $0x10,%esp
  800988:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80098b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80098e:	c9                   	leave  
  80098f:	c3                   	ret    

00800990 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800990:	55                   	push   %ebp
  800991:	89 e5                	mov    %esp,%ebp
  800993:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800996:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80099d:	eb 06                	jmp    8009a5 <strlen+0x15>
		n++;
  80099f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009a2:	ff 45 08             	incl   0x8(%ebp)
  8009a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a8:	8a 00                	mov    (%eax),%al
  8009aa:	84 c0                	test   %al,%al
  8009ac:	75 f1                	jne    80099f <strlen+0xf>
		n++;
	return n;
  8009ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009b1:	c9                   	leave  
  8009b2:	c3                   	ret    

008009b3 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009b3:	55                   	push   %ebp
  8009b4:	89 e5                	mov    %esp,%ebp
  8009b6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009c0:	eb 09                	jmp    8009cb <strnlen+0x18>
		n++;
  8009c2:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009c5:	ff 45 08             	incl   0x8(%ebp)
  8009c8:	ff 4d 0c             	decl   0xc(%ebp)
  8009cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009cf:	74 09                	je     8009da <strnlen+0x27>
  8009d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d4:	8a 00                	mov    (%eax),%al
  8009d6:	84 c0                	test   %al,%al
  8009d8:	75 e8                	jne    8009c2 <strnlen+0xf>
		n++;
	return n;
  8009da:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009dd:	c9                   	leave  
  8009de:	c3                   	ret    

008009df <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009df:	55                   	push   %ebp
  8009e0:	89 e5                	mov    %esp,%ebp
  8009e2:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8009e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8009eb:	90                   	nop
  8009ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ef:	8d 50 01             	lea    0x1(%eax),%edx
  8009f2:	89 55 08             	mov    %edx,0x8(%ebp)
  8009f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009fb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009fe:	8a 12                	mov    (%edx),%dl
  800a00:	88 10                	mov    %dl,(%eax)
  800a02:	8a 00                	mov    (%eax),%al
  800a04:	84 c0                	test   %al,%al
  800a06:	75 e4                	jne    8009ec <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a08:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a0b:	c9                   	leave  
  800a0c:	c3                   	ret    

00800a0d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a0d:	55                   	push   %ebp
  800a0e:	89 e5                	mov    %esp,%ebp
  800a10:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a13:	8b 45 08             	mov    0x8(%ebp),%eax
  800a16:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a19:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a20:	eb 1f                	jmp    800a41 <strncpy+0x34>
		*dst++ = *src;
  800a22:	8b 45 08             	mov    0x8(%ebp),%eax
  800a25:	8d 50 01             	lea    0x1(%eax),%edx
  800a28:	89 55 08             	mov    %edx,0x8(%ebp)
  800a2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a2e:	8a 12                	mov    (%edx),%dl
  800a30:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a35:	8a 00                	mov    (%eax),%al
  800a37:	84 c0                	test   %al,%al
  800a39:	74 03                	je     800a3e <strncpy+0x31>
			src++;
  800a3b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a3e:	ff 45 fc             	incl   -0x4(%ebp)
  800a41:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a44:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a47:	72 d9                	jb     800a22 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a49:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a4c:	c9                   	leave  
  800a4d:	c3                   	ret    

00800a4e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a4e:	55                   	push   %ebp
  800a4f:	89 e5                	mov    %esp,%ebp
  800a51:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a54:	8b 45 08             	mov    0x8(%ebp),%eax
  800a57:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a5a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a5e:	74 30                	je     800a90 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a60:	eb 16                	jmp    800a78 <strlcpy+0x2a>
			*dst++ = *src++;
  800a62:	8b 45 08             	mov    0x8(%ebp),%eax
  800a65:	8d 50 01             	lea    0x1(%eax),%edx
  800a68:	89 55 08             	mov    %edx,0x8(%ebp)
  800a6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a6e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a71:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a74:	8a 12                	mov    (%edx),%dl
  800a76:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a78:	ff 4d 10             	decl   0x10(%ebp)
  800a7b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a7f:	74 09                	je     800a8a <strlcpy+0x3c>
  800a81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a84:	8a 00                	mov    (%eax),%al
  800a86:	84 c0                	test   %al,%al
  800a88:	75 d8                	jne    800a62 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a90:	8b 55 08             	mov    0x8(%ebp),%edx
  800a93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a96:	29 c2                	sub    %eax,%edx
  800a98:	89 d0                	mov    %edx,%eax
}
  800a9a:	c9                   	leave  
  800a9b:	c3                   	ret    

00800a9c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a9c:	55                   	push   %ebp
  800a9d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a9f:	eb 06                	jmp    800aa7 <strcmp+0xb>
		p++, q++;
  800aa1:	ff 45 08             	incl   0x8(%ebp)
  800aa4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800aa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaa:	8a 00                	mov    (%eax),%al
  800aac:	84 c0                	test   %al,%al
  800aae:	74 0e                	je     800abe <strcmp+0x22>
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	8a 10                	mov    (%eax),%dl
  800ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab8:	8a 00                	mov    (%eax),%al
  800aba:	38 c2                	cmp    %al,%dl
  800abc:	74 e3                	je     800aa1 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800abe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac1:	8a 00                	mov    (%eax),%al
  800ac3:	0f b6 d0             	movzbl %al,%edx
  800ac6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac9:	8a 00                	mov    (%eax),%al
  800acb:	0f b6 c0             	movzbl %al,%eax
  800ace:	29 c2                	sub    %eax,%edx
  800ad0:	89 d0                	mov    %edx,%eax
}
  800ad2:	5d                   	pop    %ebp
  800ad3:	c3                   	ret    

00800ad4 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ad4:	55                   	push   %ebp
  800ad5:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ad7:	eb 09                	jmp    800ae2 <strncmp+0xe>
		n--, p++, q++;
  800ad9:	ff 4d 10             	decl   0x10(%ebp)
  800adc:	ff 45 08             	incl   0x8(%ebp)
  800adf:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ae2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ae6:	74 17                	je     800aff <strncmp+0x2b>
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	8a 00                	mov    (%eax),%al
  800aed:	84 c0                	test   %al,%al
  800aef:	74 0e                	je     800aff <strncmp+0x2b>
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	8a 10                	mov    (%eax),%dl
  800af6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af9:	8a 00                	mov    (%eax),%al
  800afb:	38 c2                	cmp    %al,%dl
  800afd:	74 da                	je     800ad9 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800aff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b03:	75 07                	jne    800b0c <strncmp+0x38>
		return 0;
  800b05:	b8 00 00 00 00       	mov    $0x0,%eax
  800b0a:	eb 14                	jmp    800b20 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0f:	8a 00                	mov    (%eax),%al
  800b11:	0f b6 d0             	movzbl %al,%edx
  800b14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b17:	8a 00                	mov    (%eax),%al
  800b19:	0f b6 c0             	movzbl %al,%eax
  800b1c:	29 c2                	sub    %eax,%edx
  800b1e:	89 d0                	mov    %edx,%eax
}
  800b20:	5d                   	pop    %ebp
  800b21:	c3                   	ret    

00800b22 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b22:	55                   	push   %ebp
  800b23:	89 e5                	mov    %esp,%ebp
  800b25:	83 ec 04             	sub    $0x4,%esp
  800b28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b2e:	eb 12                	jmp    800b42 <strchr+0x20>
		if (*s == c)
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	8a 00                	mov    (%eax),%al
  800b35:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b38:	75 05                	jne    800b3f <strchr+0x1d>
			return (char *) s;
  800b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3d:	eb 11                	jmp    800b50 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b3f:	ff 45 08             	incl   0x8(%ebp)
  800b42:	8b 45 08             	mov    0x8(%ebp),%eax
  800b45:	8a 00                	mov    (%eax),%al
  800b47:	84 c0                	test   %al,%al
  800b49:	75 e5                	jne    800b30 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b4b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b50:	c9                   	leave  
  800b51:	c3                   	ret    

00800b52 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b52:	55                   	push   %ebp
  800b53:	89 e5                	mov    %esp,%ebp
  800b55:	83 ec 04             	sub    $0x4,%esp
  800b58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b5e:	eb 0d                	jmp    800b6d <strfind+0x1b>
		if (*s == c)
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	8a 00                	mov    (%eax),%al
  800b65:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b68:	74 0e                	je     800b78 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b6a:	ff 45 08             	incl   0x8(%ebp)
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	8a 00                	mov    (%eax),%al
  800b72:	84 c0                	test   %al,%al
  800b74:	75 ea                	jne    800b60 <strfind+0xe>
  800b76:	eb 01                	jmp    800b79 <strfind+0x27>
		if (*s == c)
			break;
  800b78:	90                   	nop
	return (char *) s;
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b7c:	c9                   	leave  
  800b7d:	c3                   	ret    

00800b7e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b7e:	55                   	push   %ebp
  800b7f:	89 e5                	mov    %esp,%ebp
  800b81:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b84:	8b 45 08             	mov    0x8(%ebp),%eax
  800b87:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b8a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b90:	eb 0e                	jmp    800ba0 <memset+0x22>
		*p++ = c;
  800b92:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b95:	8d 50 01             	lea    0x1(%eax),%edx
  800b98:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b9e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ba0:	ff 4d f8             	decl   -0x8(%ebp)
  800ba3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ba7:	79 e9                	jns    800b92 <memset+0x14>
		*p++ = c;

	return v;
  800ba9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bac:	c9                   	leave  
  800bad:	c3                   	ret    

00800bae <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bae:	55                   	push   %ebp
  800baf:	89 e5                	mov    %esp,%ebp
  800bb1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bba:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800bc0:	eb 16                	jmp    800bd8 <memcpy+0x2a>
		*d++ = *s++;
  800bc2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc5:	8d 50 01             	lea    0x1(%eax),%edx
  800bc8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bcb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bce:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bd1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bd4:	8a 12                	mov    (%edx),%dl
  800bd6:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800bd8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bde:	89 55 10             	mov    %edx,0x10(%ebp)
  800be1:	85 c0                	test   %eax,%eax
  800be3:	75 dd                	jne    800bc2 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800be5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800be8:	c9                   	leave  
  800be9:	c3                   	ret    

00800bea <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800bea:	55                   	push   %ebp
  800beb:	89 e5                	mov    %esp,%ebp
  800bed:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800bf0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800bfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bff:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c02:	73 50                	jae    800c54 <memmove+0x6a>
  800c04:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c07:	8b 45 10             	mov    0x10(%ebp),%eax
  800c0a:	01 d0                	add    %edx,%eax
  800c0c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c0f:	76 43                	jbe    800c54 <memmove+0x6a>
		s += n;
  800c11:	8b 45 10             	mov    0x10(%ebp),%eax
  800c14:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c17:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c1d:	eb 10                	jmp    800c2f <memmove+0x45>
			*--d = *--s;
  800c1f:	ff 4d f8             	decl   -0x8(%ebp)
  800c22:	ff 4d fc             	decl   -0x4(%ebp)
  800c25:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c28:	8a 10                	mov    (%eax),%dl
  800c2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c2d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c32:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c35:	89 55 10             	mov    %edx,0x10(%ebp)
  800c38:	85 c0                	test   %eax,%eax
  800c3a:	75 e3                	jne    800c1f <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c3c:	eb 23                	jmp    800c61 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c41:	8d 50 01             	lea    0x1(%eax),%edx
  800c44:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c47:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c4a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c4d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c50:	8a 12                	mov    (%edx),%dl
  800c52:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c54:	8b 45 10             	mov    0x10(%ebp),%eax
  800c57:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c5a:	89 55 10             	mov    %edx,0x10(%ebp)
  800c5d:	85 c0                	test   %eax,%eax
  800c5f:	75 dd                	jne    800c3e <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c61:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c64:	c9                   	leave  
  800c65:	c3                   	ret    

00800c66 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c66:	55                   	push   %ebp
  800c67:	89 e5                	mov    %esp,%ebp
  800c69:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c75:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c78:	eb 2a                	jmp    800ca4 <memcmp+0x3e>
		if (*s1 != *s2)
  800c7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c7d:	8a 10                	mov    (%eax),%dl
  800c7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c82:	8a 00                	mov    (%eax),%al
  800c84:	38 c2                	cmp    %al,%dl
  800c86:	74 16                	je     800c9e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c88:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c8b:	8a 00                	mov    (%eax),%al
  800c8d:	0f b6 d0             	movzbl %al,%edx
  800c90:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c93:	8a 00                	mov    (%eax),%al
  800c95:	0f b6 c0             	movzbl %al,%eax
  800c98:	29 c2                	sub    %eax,%edx
  800c9a:	89 d0                	mov    %edx,%eax
  800c9c:	eb 18                	jmp    800cb6 <memcmp+0x50>
		s1++, s2++;
  800c9e:	ff 45 fc             	incl   -0x4(%ebp)
  800ca1:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ca4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800caa:	89 55 10             	mov    %edx,0x10(%ebp)
  800cad:	85 c0                	test   %eax,%eax
  800caf:	75 c9                	jne    800c7a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800cb1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cb6:	c9                   	leave  
  800cb7:	c3                   	ret    

00800cb8 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800cb8:	55                   	push   %ebp
  800cb9:	89 e5                	mov    %esp,%ebp
  800cbb:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800cbe:	8b 55 08             	mov    0x8(%ebp),%edx
  800cc1:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc4:	01 d0                	add    %edx,%eax
  800cc6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800cc9:	eb 15                	jmp    800ce0 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	8a 00                	mov    (%eax),%al
  800cd0:	0f b6 d0             	movzbl %al,%edx
  800cd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd6:	0f b6 c0             	movzbl %al,%eax
  800cd9:	39 c2                	cmp    %eax,%edx
  800cdb:	74 0d                	je     800cea <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800cdd:	ff 45 08             	incl   0x8(%ebp)
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ce6:	72 e3                	jb     800ccb <memfind+0x13>
  800ce8:	eb 01                	jmp    800ceb <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800cea:	90                   	nop
	return (void *) s;
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cee:	c9                   	leave  
  800cef:	c3                   	ret    

00800cf0 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800cf0:	55                   	push   %ebp
  800cf1:	89 e5                	mov    %esp,%ebp
  800cf3:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800cf6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800cfd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d04:	eb 03                	jmp    800d09 <strtol+0x19>
		s++;
  800d06:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	8a 00                	mov    (%eax),%al
  800d0e:	3c 20                	cmp    $0x20,%al
  800d10:	74 f4                	je     800d06 <strtol+0x16>
  800d12:	8b 45 08             	mov    0x8(%ebp),%eax
  800d15:	8a 00                	mov    (%eax),%al
  800d17:	3c 09                	cmp    $0x9,%al
  800d19:	74 eb                	je     800d06 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1e:	8a 00                	mov    (%eax),%al
  800d20:	3c 2b                	cmp    $0x2b,%al
  800d22:	75 05                	jne    800d29 <strtol+0x39>
		s++;
  800d24:	ff 45 08             	incl   0x8(%ebp)
  800d27:	eb 13                	jmp    800d3c <strtol+0x4c>
	else if (*s == '-')
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	8a 00                	mov    (%eax),%al
  800d2e:	3c 2d                	cmp    $0x2d,%al
  800d30:	75 0a                	jne    800d3c <strtol+0x4c>
		s++, neg = 1;
  800d32:	ff 45 08             	incl   0x8(%ebp)
  800d35:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d3c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d40:	74 06                	je     800d48 <strtol+0x58>
  800d42:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d46:	75 20                	jne    800d68 <strtol+0x78>
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	8a 00                	mov    (%eax),%al
  800d4d:	3c 30                	cmp    $0x30,%al
  800d4f:	75 17                	jne    800d68 <strtol+0x78>
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	40                   	inc    %eax
  800d55:	8a 00                	mov    (%eax),%al
  800d57:	3c 78                	cmp    $0x78,%al
  800d59:	75 0d                	jne    800d68 <strtol+0x78>
		s += 2, base = 16;
  800d5b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d5f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d66:	eb 28                	jmp    800d90 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d68:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d6c:	75 15                	jne    800d83 <strtol+0x93>
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	8a 00                	mov    (%eax),%al
  800d73:	3c 30                	cmp    $0x30,%al
  800d75:	75 0c                	jne    800d83 <strtol+0x93>
		s++, base = 8;
  800d77:	ff 45 08             	incl   0x8(%ebp)
  800d7a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d81:	eb 0d                	jmp    800d90 <strtol+0xa0>
	else if (base == 0)
  800d83:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d87:	75 07                	jne    800d90 <strtol+0xa0>
		base = 10;
  800d89:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d90:	8b 45 08             	mov    0x8(%ebp),%eax
  800d93:	8a 00                	mov    (%eax),%al
  800d95:	3c 2f                	cmp    $0x2f,%al
  800d97:	7e 19                	jle    800db2 <strtol+0xc2>
  800d99:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9c:	8a 00                	mov    (%eax),%al
  800d9e:	3c 39                	cmp    $0x39,%al
  800da0:	7f 10                	jg     800db2 <strtol+0xc2>
			dig = *s - '0';
  800da2:	8b 45 08             	mov    0x8(%ebp),%eax
  800da5:	8a 00                	mov    (%eax),%al
  800da7:	0f be c0             	movsbl %al,%eax
  800daa:	83 e8 30             	sub    $0x30,%eax
  800dad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800db0:	eb 42                	jmp    800df4 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800db2:	8b 45 08             	mov    0x8(%ebp),%eax
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	3c 60                	cmp    $0x60,%al
  800db9:	7e 19                	jle    800dd4 <strtol+0xe4>
  800dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbe:	8a 00                	mov    (%eax),%al
  800dc0:	3c 7a                	cmp    $0x7a,%al
  800dc2:	7f 10                	jg     800dd4 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800dc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc7:	8a 00                	mov    (%eax),%al
  800dc9:	0f be c0             	movsbl %al,%eax
  800dcc:	83 e8 57             	sub    $0x57,%eax
  800dcf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dd2:	eb 20                	jmp    800df4 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd7:	8a 00                	mov    (%eax),%al
  800dd9:	3c 40                	cmp    $0x40,%al
  800ddb:	7e 39                	jle    800e16 <strtol+0x126>
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  800de0:	8a 00                	mov    (%eax),%al
  800de2:	3c 5a                	cmp    $0x5a,%al
  800de4:	7f 30                	jg     800e16 <strtol+0x126>
			dig = *s - 'A' + 10;
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	8a 00                	mov    (%eax),%al
  800deb:	0f be c0             	movsbl %al,%eax
  800dee:	83 e8 37             	sub    $0x37,%eax
  800df1:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800df4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800df7:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dfa:	7d 19                	jge    800e15 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800dfc:	ff 45 08             	incl   0x8(%ebp)
  800dff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e02:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e06:	89 c2                	mov    %eax,%edx
  800e08:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e0b:	01 d0                	add    %edx,%eax
  800e0d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e10:	e9 7b ff ff ff       	jmp    800d90 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e15:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e16:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e1a:	74 08                	je     800e24 <strtol+0x134>
		*endptr = (char *) s;
  800e1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1f:	8b 55 08             	mov    0x8(%ebp),%edx
  800e22:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e24:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e28:	74 07                	je     800e31 <strtol+0x141>
  800e2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2d:	f7 d8                	neg    %eax
  800e2f:	eb 03                	jmp    800e34 <strtol+0x144>
  800e31:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e34:	c9                   	leave  
  800e35:	c3                   	ret    

00800e36 <ltostr>:

void
ltostr(long value, char *str)
{
  800e36:	55                   	push   %ebp
  800e37:	89 e5                	mov    %esp,%ebp
  800e39:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e3c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e43:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e4a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e4e:	79 13                	jns    800e63 <ltostr+0x2d>
	{
		neg = 1;
  800e50:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5a:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e5d:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e60:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e63:	8b 45 08             	mov    0x8(%ebp),%eax
  800e66:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e6b:	99                   	cltd   
  800e6c:	f7 f9                	idiv   %ecx
  800e6e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e74:	8d 50 01             	lea    0x1(%eax),%edx
  800e77:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e7a:	89 c2                	mov    %eax,%edx
  800e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7f:	01 d0                	add    %edx,%eax
  800e81:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e84:	83 c2 30             	add    $0x30,%edx
  800e87:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e89:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e8c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e91:	f7 e9                	imul   %ecx
  800e93:	c1 fa 02             	sar    $0x2,%edx
  800e96:	89 c8                	mov    %ecx,%eax
  800e98:	c1 f8 1f             	sar    $0x1f,%eax
  800e9b:	29 c2                	sub    %eax,%edx
  800e9d:	89 d0                	mov    %edx,%eax
  800e9f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ea2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ea5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800eaa:	f7 e9                	imul   %ecx
  800eac:	c1 fa 02             	sar    $0x2,%edx
  800eaf:	89 c8                	mov    %ecx,%eax
  800eb1:	c1 f8 1f             	sar    $0x1f,%eax
  800eb4:	29 c2                	sub    %eax,%edx
  800eb6:	89 d0                	mov    %edx,%eax
  800eb8:	c1 e0 02             	shl    $0x2,%eax
  800ebb:	01 d0                	add    %edx,%eax
  800ebd:	01 c0                	add    %eax,%eax
  800ebf:	29 c1                	sub    %eax,%ecx
  800ec1:	89 ca                	mov    %ecx,%edx
  800ec3:	85 d2                	test   %edx,%edx
  800ec5:	75 9c                	jne    800e63 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800ec7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800ece:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ed1:	48                   	dec    %eax
  800ed2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800ed5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ed9:	74 3d                	je     800f18 <ltostr+0xe2>
		start = 1 ;
  800edb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800ee2:	eb 34                	jmp    800f18 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800ee4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ee7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eea:	01 d0                	add    %edx,%eax
  800eec:	8a 00                	mov    (%eax),%al
  800eee:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800ef1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ef4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef7:	01 c2                	add    %eax,%edx
  800ef9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800efc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eff:	01 c8                	add    %ecx,%eax
  800f01:	8a 00                	mov    (%eax),%al
  800f03:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f05:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0b:	01 c2                	add    %eax,%edx
  800f0d:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f10:	88 02                	mov    %al,(%edx)
		start++ ;
  800f12:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f15:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f1b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f1e:	7c c4                	jl     800ee4 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f20:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f26:	01 d0                	add    %edx,%eax
  800f28:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f2b:	90                   	nop
  800f2c:	c9                   	leave  
  800f2d:	c3                   	ret    

00800f2e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f2e:	55                   	push   %ebp
  800f2f:	89 e5                	mov    %esp,%ebp
  800f31:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f34:	ff 75 08             	pushl  0x8(%ebp)
  800f37:	e8 54 fa ff ff       	call   800990 <strlen>
  800f3c:	83 c4 04             	add    $0x4,%esp
  800f3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f42:	ff 75 0c             	pushl  0xc(%ebp)
  800f45:	e8 46 fa ff ff       	call   800990 <strlen>
  800f4a:	83 c4 04             	add    $0x4,%esp
  800f4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f50:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f57:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f5e:	eb 17                	jmp    800f77 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f60:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f63:	8b 45 10             	mov    0x10(%ebp),%eax
  800f66:	01 c2                	add    %eax,%edx
  800f68:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6e:	01 c8                	add    %ecx,%eax
  800f70:	8a 00                	mov    (%eax),%al
  800f72:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f74:	ff 45 fc             	incl   -0x4(%ebp)
  800f77:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f7a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f7d:	7c e1                	jl     800f60 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f7f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f86:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f8d:	eb 1f                	jmp    800fae <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f92:	8d 50 01             	lea    0x1(%eax),%edx
  800f95:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f98:	89 c2                	mov    %eax,%edx
  800f9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9d:	01 c2                	add    %eax,%edx
  800f9f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fa2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa5:	01 c8                	add    %ecx,%eax
  800fa7:	8a 00                	mov    (%eax),%al
  800fa9:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fab:	ff 45 f8             	incl   -0x8(%ebp)
  800fae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fb4:	7c d9                	jl     800f8f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fb6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fb9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbc:	01 d0                	add    %edx,%eax
  800fbe:	c6 00 00             	movb   $0x0,(%eax)
}
  800fc1:	90                   	nop
  800fc2:	c9                   	leave  
  800fc3:	c3                   	ret    

00800fc4 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fc4:	55                   	push   %ebp
  800fc5:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800fc7:	8b 45 14             	mov    0x14(%ebp),%eax
  800fca:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800fd0:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd3:	8b 00                	mov    (%eax),%eax
  800fd5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdf:	01 d0                	add    %edx,%eax
  800fe1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fe7:	eb 0c                	jmp    800ff5 <strsplit+0x31>
			*string++ = 0;
  800fe9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fec:	8d 50 01             	lea    0x1(%eax),%edx
  800fef:	89 55 08             	mov    %edx,0x8(%ebp)
  800ff2:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff8:	8a 00                	mov    (%eax),%al
  800ffa:	84 c0                	test   %al,%al
  800ffc:	74 18                	je     801016 <strsplit+0x52>
  800ffe:	8b 45 08             	mov    0x8(%ebp),%eax
  801001:	8a 00                	mov    (%eax),%al
  801003:	0f be c0             	movsbl %al,%eax
  801006:	50                   	push   %eax
  801007:	ff 75 0c             	pushl  0xc(%ebp)
  80100a:	e8 13 fb ff ff       	call   800b22 <strchr>
  80100f:	83 c4 08             	add    $0x8,%esp
  801012:	85 c0                	test   %eax,%eax
  801014:	75 d3                	jne    800fe9 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801016:	8b 45 08             	mov    0x8(%ebp),%eax
  801019:	8a 00                	mov    (%eax),%al
  80101b:	84 c0                	test   %al,%al
  80101d:	74 5a                	je     801079 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80101f:	8b 45 14             	mov    0x14(%ebp),%eax
  801022:	8b 00                	mov    (%eax),%eax
  801024:	83 f8 0f             	cmp    $0xf,%eax
  801027:	75 07                	jne    801030 <strsplit+0x6c>
		{
			return 0;
  801029:	b8 00 00 00 00       	mov    $0x0,%eax
  80102e:	eb 66                	jmp    801096 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801030:	8b 45 14             	mov    0x14(%ebp),%eax
  801033:	8b 00                	mov    (%eax),%eax
  801035:	8d 48 01             	lea    0x1(%eax),%ecx
  801038:	8b 55 14             	mov    0x14(%ebp),%edx
  80103b:	89 0a                	mov    %ecx,(%edx)
  80103d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801044:	8b 45 10             	mov    0x10(%ebp),%eax
  801047:	01 c2                	add    %eax,%edx
  801049:	8b 45 08             	mov    0x8(%ebp),%eax
  80104c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80104e:	eb 03                	jmp    801053 <strsplit+0x8f>
			string++;
  801050:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	8a 00                	mov    (%eax),%al
  801058:	84 c0                	test   %al,%al
  80105a:	74 8b                	je     800fe7 <strsplit+0x23>
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	8a 00                	mov    (%eax),%al
  801061:	0f be c0             	movsbl %al,%eax
  801064:	50                   	push   %eax
  801065:	ff 75 0c             	pushl  0xc(%ebp)
  801068:	e8 b5 fa ff ff       	call   800b22 <strchr>
  80106d:	83 c4 08             	add    $0x8,%esp
  801070:	85 c0                	test   %eax,%eax
  801072:	74 dc                	je     801050 <strsplit+0x8c>
			string++;
	}
  801074:	e9 6e ff ff ff       	jmp    800fe7 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801079:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80107a:	8b 45 14             	mov    0x14(%ebp),%eax
  80107d:	8b 00                	mov    (%eax),%eax
  80107f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801086:	8b 45 10             	mov    0x10(%ebp),%eax
  801089:	01 d0                	add    %edx,%eax
  80108b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801091:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801096:	c9                   	leave  
  801097:	c3                   	ret    

00801098 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801098:	55                   	push   %ebp
  801099:	89 e5                	mov    %esp,%ebp
  80109b:	83 ec 18             	sub    $0x18,%esp
  80109e:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a1:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8010a4:	83 ec 04             	sub    $0x4,%esp
  8010a7:	68 d0 21 80 00       	push   $0x8021d0
  8010ac:	6a 17                	push   $0x17
  8010ae:	68 ef 21 80 00       	push   $0x8021ef
  8010b3:	e8 8a 08 00 00       	call   801942 <_panic>

008010b8 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8010b8:	55                   	push   %ebp
  8010b9:	89 e5                	mov    %esp,%ebp
  8010bb:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8010be:	83 ec 04             	sub    $0x4,%esp
  8010c1:	68 fb 21 80 00       	push   $0x8021fb
  8010c6:	6a 2f                	push   $0x2f
  8010c8:	68 ef 21 80 00       	push   $0x8021ef
  8010cd:	e8 70 08 00 00       	call   801942 <_panic>

008010d2 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8010d2:	55                   	push   %ebp
  8010d3:	89 e5                	mov    %esp,%ebp
  8010d5:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8010d8:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8010df:	8b 55 08             	mov    0x8(%ebp),%edx
  8010e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010e5:	01 d0                	add    %edx,%eax
  8010e7:	48                   	dec    %eax
  8010e8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8010eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010ee:	ba 00 00 00 00       	mov    $0x0,%edx
  8010f3:	f7 75 ec             	divl   -0x14(%ebp)
  8010f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010f9:	29 d0                	sub    %edx,%eax
  8010fb:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8010fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801101:	c1 e8 0c             	shr    $0xc,%eax
  801104:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801107:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80110e:	e9 c8 00 00 00       	jmp    8011db <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801113:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80111a:	eb 27                	jmp    801143 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  80111c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80111f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801122:	01 c2                	add    %eax,%edx
  801124:	89 d0                	mov    %edx,%eax
  801126:	01 c0                	add    %eax,%eax
  801128:	01 d0                	add    %edx,%eax
  80112a:	c1 e0 02             	shl    $0x2,%eax
  80112d:	05 48 30 80 00       	add    $0x803048,%eax
  801132:	8b 00                	mov    (%eax),%eax
  801134:	85 c0                	test   %eax,%eax
  801136:	74 08                	je     801140 <malloc+0x6e>
            	i += j;
  801138:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80113b:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  80113e:	eb 0b                	jmp    80114b <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801140:	ff 45 f0             	incl   -0x10(%ebp)
  801143:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801146:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801149:	72 d1                	jb     80111c <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  80114b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80114e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801151:	0f 85 81 00 00 00    	jne    8011d8 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801157:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80115a:	05 00 00 08 00       	add    $0x80000,%eax
  80115f:	c1 e0 0c             	shl    $0xc,%eax
  801162:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801165:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80116c:	eb 1f                	jmp    80118d <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  80116e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801171:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801174:	01 c2                	add    %eax,%edx
  801176:	89 d0                	mov    %edx,%eax
  801178:	01 c0                	add    %eax,%eax
  80117a:	01 d0                	add    %edx,%eax
  80117c:	c1 e0 02             	shl    $0x2,%eax
  80117f:	05 48 30 80 00       	add    $0x803048,%eax
  801184:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80118a:	ff 45 f0             	incl   -0x10(%ebp)
  80118d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801190:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801193:	72 d9                	jb     80116e <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801195:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801198:	89 d0                	mov    %edx,%eax
  80119a:	01 c0                	add    %eax,%eax
  80119c:	01 d0                	add    %edx,%eax
  80119e:	c1 e0 02             	shl    $0x2,%eax
  8011a1:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  8011a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8011aa:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8011ac:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8011af:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8011b2:	89 c8                	mov    %ecx,%eax
  8011b4:	01 c0                	add    %eax,%eax
  8011b6:	01 c8                	add    %ecx,%eax
  8011b8:	c1 e0 02             	shl    $0x2,%eax
  8011bb:	05 44 30 80 00       	add    $0x803044,%eax
  8011c0:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8011c2:	83 ec 08             	sub    $0x8,%esp
  8011c5:	ff 75 08             	pushl  0x8(%ebp)
  8011c8:	ff 75 e0             	pushl  -0x20(%ebp)
  8011cb:	e8 2b 03 00 00       	call   8014fb <sys_allocateMem>
  8011d0:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8011d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8011d6:	eb 19                	jmp    8011f1 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8011d8:	ff 45 f4             	incl   -0xc(%ebp)
  8011db:	a1 04 30 80 00       	mov    0x803004,%eax
  8011e0:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8011e3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011e6:	0f 83 27 ff ff ff    	jae    801113 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8011ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011f1:	c9                   	leave  
  8011f2:	c3                   	ret    

008011f3 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8011f3:	55                   	push   %ebp
  8011f4:	89 e5                	mov    %esp,%ebp
  8011f6:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8011f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011fd:	0f 84 e5 00 00 00    	je     8012e8 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801203:	8b 45 08             	mov    0x8(%ebp),%eax
  801206:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801209:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80120c:	05 00 00 00 80       	add    $0x80000000,%eax
  801211:	c1 e8 0c             	shr    $0xc,%eax
  801214:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801217:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80121a:	89 d0                	mov    %edx,%eax
  80121c:	01 c0                	add    %eax,%eax
  80121e:	01 d0                	add    %edx,%eax
  801220:	c1 e0 02             	shl    $0x2,%eax
  801223:	05 40 30 80 00       	add    $0x803040,%eax
  801228:	8b 00                	mov    (%eax),%eax
  80122a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80122d:	0f 85 b8 00 00 00    	jne    8012eb <free+0xf8>
  801233:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801236:	89 d0                	mov    %edx,%eax
  801238:	01 c0                	add    %eax,%eax
  80123a:	01 d0                	add    %edx,%eax
  80123c:	c1 e0 02             	shl    $0x2,%eax
  80123f:	05 48 30 80 00       	add    $0x803048,%eax
  801244:	8b 00                	mov    (%eax),%eax
  801246:	85 c0                	test   %eax,%eax
  801248:	0f 84 9d 00 00 00    	je     8012eb <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  80124e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801251:	89 d0                	mov    %edx,%eax
  801253:	01 c0                	add    %eax,%eax
  801255:	01 d0                	add    %edx,%eax
  801257:	c1 e0 02             	shl    $0x2,%eax
  80125a:	05 44 30 80 00       	add    $0x803044,%eax
  80125f:	8b 00                	mov    (%eax),%eax
  801261:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801264:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801267:	c1 e0 0c             	shl    $0xc,%eax
  80126a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  80126d:	83 ec 08             	sub    $0x8,%esp
  801270:	ff 75 e4             	pushl  -0x1c(%ebp)
  801273:	ff 75 f0             	pushl  -0x10(%ebp)
  801276:	e8 64 02 00 00       	call   8014df <sys_freeMem>
  80127b:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80127e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801285:	eb 57                	jmp    8012de <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801287:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80128a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80128d:	01 c2                	add    %eax,%edx
  80128f:	89 d0                	mov    %edx,%eax
  801291:	01 c0                	add    %eax,%eax
  801293:	01 d0                	add    %edx,%eax
  801295:	c1 e0 02             	shl    $0x2,%eax
  801298:	05 48 30 80 00       	add    $0x803048,%eax
  80129d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  8012a3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012a9:	01 c2                	add    %eax,%edx
  8012ab:	89 d0                	mov    %edx,%eax
  8012ad:	01 c0                	add    %eax,%eax
  8012af:	01 d0                	add    %edx,%eax
  8012b1:	c1 e0 02             	shl    $0x2,%eax
  8012b4:	05 40 30 80 00       	add    $0x803040,%eax
  8012b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8012bf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012c5:	01 c2                	add    %eax,%edx
  8012c7:	89 d0                	mov    %edx,%eax
  8012c9:	01 c0                	add    %eax,%eax
  8012cb:	01 d0                	add    %edx,%eax
  8012cd:	c1 e0 02             	shl    $0x2,%eax
  8012d0:	05 44 30 80 00       	add    $0x803044,%eax
  8012d5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8012db:	ff 45 f4             	incl   -0xc(%ebp)
  8012de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012e1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8012e4:	7c a1                	jl     801287 <free+0x94>
  8012e6:	eb 04                	jmp    8012ec <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8012e8:	90                   	nop
  8012e9:	eb 01                	jmp    8012ec <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8012eb:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8012ec:	c9                   	leave  
  8012ed:	c3                   	ret    

008012ee <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8012ee:	55                   	push   %ebp
  8012ef:	89 e5                	mov    %esp,%ebp
  8012f1:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8012f4:	83 ec 04             	sub    $0x4,%esp
  8012f7:	68 18 22 80 00       	push   $0x802218
  8012fc:	68 ae 00 00 00       	push   $0xae
  801301:	68 ef 21 80 00       	push   $0x8021ef
  801306:	e8 37 06 00 00       	call   801942 <_panic>

0080130b <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80130b:	55                   	push   %ebp
  80130c:	89 e5                	mov    %esp,%ebp
  80130e:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801311:	83 ec 04             	sub    $0x4,%esp
  801314:	68 38 22 80 00       	push   $0x802238
  801319:	68 ca 00 00 00       	push   $0xca
  80131e:	68 ef 21 80 00       	push   $0x8021ef
  801323:	e8 1a 06 00 00       	call   801942 <_panic>

00801328 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801328:	55                   	push   %ebp
  801329:	89 e5                	mov    %esp,%ebp
  80132b:	57                   	push   %edi
  80132c:	56                   	push   %esi
  80132d:	53                   	push   %ebx
  80132e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	8b 55 0c             	mov    0xc(%ebp),%edx
  801337:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80133a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80133d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801340:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801343:	cd 30                	int    $0x30
  801345:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801348:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80134b:	83 c4 10             	add    $0x10,%esp
  80134e:	5b                   	pop    %ebx
  80134f:	5e                   	pop    %esi
  801350:	5f                   	pop    %edi
  801351:	5d                   	pop    %ebp
  801352:	c3                   	ret    

00801353 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801353:	55                   	push   %ebp
  801354:	89 e5                	mov    %esp,%ebp
  801356:	83 ec 04             	sub    $0x4,%esp
  801359:	8b 45 10             	mov    0x10(%ebp),%eax
  80135c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80135f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801363:	8b 45 08             	mov    0x8(%ebp),%eax
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	52                   	push   %edx
  80136b:	ff 75 0c             	pushl  0xc(%ebp)
  80136e:	50                   	push   %eax
  80136f:	6a 00                	push   $0x0
  801371:	e8 b2 ff ff ff       	call   801328 <syscall>
  801376:	83 c4 18             	add    $0x18,%esp
}
  801379:	90                   	nop
  80137a:	c9                   	leave  
  80137b:	c3                   	ret    

0080137c <sys_cgetc>:

int
sys_cgetc(void)
{
  80137c:	55                   	push   %ebp
  80137d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80137f:	6a 00                	push   $0x0
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	6a 00                	push   $0x0
  801387:	6a 00                	push   $0x0
  801389:	6a 01                	push   $0x1
  80138b:	e8 98 ff ff ff       	call   801328 <syscall>
  801390:	83 c4 18             	add    $0x18,%esp
}
  801393:	c9                   	leave  
  801394:	c3                   	ret    

00801395 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801398:	8b 45 08             	mov    0x8(%ebp),%eax
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	6a 00                	push   $0x0
  8013a1:	6a 00                	push   $0x0
  8013a3:	50                   	push   %eax
  8013a4:	6a 05                	push   $0x5
  8013a6:	e8 7d ff ff ff       	call   801328 <syscall>
  8013ab:	83 c4 18             	add    $0x18,%esp
}
  8013ae:	c9                   	leave  
  8013af:	c3                   	ret    

008013b0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013b0:	55                   	push   %ebp
  8013b1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 02                	push   $0x2
  8013bf:	e8 64 ff ff ff       	call   801328 <syscall>
  8013c4:	83 c4 18             	add    $0x18,%esp
}
  8013c7:	c9                   	leave  
  8013c8:	c3                   	ret    

008013c9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 03                	push   $0x3
  8013d8:	e8 4b ff ff ff       	call   801328 <syscall>
  8013dd:	83 c4 18             	add    $0x18,%esp
}
  8013e0:	c9                   	leave  
  8013e1:	c3                   	ret    

008013e2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 04                	push   $0x4
  8013f1:	e8 32 ff ff ff       	call   801328 <syscall>
  8013f6:	83 c4 18             	add    $0x18,%esp
}
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <sys_env_exit>:


void sys_env_exit(void)
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 06                	push   $0x6
  80140a:	e8 19 ff ff ff       	call   801328 <syscall>
  80140f:	83 c4 18             	add    $0x18,%esp
}
  801412:	90                   	nop
  801413:	c9                   	leave  
  801414:	c3                   	ret    

00801415 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801415:	55                   	push   %ebp
  801416:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801418:	8b 55 0c             	mov    0xc(%ebp),%edx
  80141b:	8b 45 08             	mov    0x8(%ebp),%eax
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	6a 00                	push   $0x0
  801424:	52                   	push   %edx
  801425:	50                   	push   %eax
  801426:	6a 07                	push   $0x7
  801428:	e8 fb fe ff ff       	call   801328 <syscall>
  80142d:	83 c4 18             	add    $0x18,%esp
}
  801430:	c9                   	leave  
  801431:	c3                   	ret    

00801432 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801432:	55                   	push   %ebp
  801433:	89 e5                	mov    %esp,%ebp
  801435:	56                   	push   %esi
  801436:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801437:	8b 75 18             	mov    0x18(%ebp),%esi
  80143a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80143d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801440:	8b 55 0c             	mov    0xc(%ebp),%edx
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	56                   	push   %esi
  801447:	53                   	push   %ebx
  801448:	51                   	push   %ecx
  801449:	52                   	push   %edx
  80144a:	50                   	push   %eax
  80144b:	6a 08                	push   $0x8
  80144d:	e8 d6 fe ff ff       	call   801328 <syscall>
  801452:	83 c4 18             	add    $0x18,%esp
}
  801455:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801458:	5b                   	pop    %ebx
  801459:	5e                   	pop    %esi
  80145a:	5d                   	pop    %ebp
  80145b:	c3                   	ret    

0080145c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80145c:	55                   	push   %ebp
  80145d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80145f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	6a 00                	push   $0x0
  80146b:	52                   	push   %edx
  80146c:	50                   	push   %eax
  80146d:	6a 09                	push   $0x9
  80146f:	e8 b4 fe ff ff       	call   801328 <syscall>
  801474:	83 c4 18             	add    $0x18,%esp
}
  801477:	c9                   	leave  
  801478:	c3                   	ret    

00801479 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801479:	55                   	push   %ebp
  80147a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	ff 75 0c             	pushl  0xc(%ebp)
  801485:	ff 75 08             	pushl  0x8(%ebp)
  801488:	6a 0a                	push   $0xa
  80148a:	e8 99 fe ff ff       	call   801328 <syscall>
  80148f:	83 c4 18             	add    $0x18,%esp
}
  801492:	c9                   	leave  
  801493:	c3                   	ret    

00801494 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801494:	55                   	push   %ebp
  801495:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 0b                	push   $0xb
  8014a3:	e8 80 fe ff ff       	call   801328 <syscall>
  8014a8:	83 c4 18             	add    $0x18,%esp
}
  8014ab:	c9                   	leave  
  8014ac:	c3                   	ret    

008014ad <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014ad:	55                   	push   %ebp
  8014ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 0c                	push   $0xc
  8014bc:	e8 67 fe ff ff       	call   801328 <syscall>
  8014c1:	83 c4 18             	add    $0x18,%esp
}
  8014c4:	c9                   	leave  
  8014c5:	c3                   	ret    

008014c6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014c6:	55                   	push   %ebp
  8014c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 0d                	push   $0xd
  8014d5:	e8 4e fe ff ff       	call   801328 <syscall>
  8014da:	83 c4 18             	add    $0x18,%esp
}
  8014dd:	c9                   	leave  
  8014de:	c3                   	ret    

008014df <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014df:	55                   	push   %ebp
  8014e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	ff 75 0c             	pushl  0xc(%ebp)
  8014eb:	ff 75 08             	pushl  0x8(%ebp)
  8014ee:	6a 11                	push   $0x11
  8014f0:	e8 33 fe ff ff       	call   801328 <syscall>
  8014f5:	83 c4 18             	add    $0x18,%esp
	return;
  8014f8:	90                   	nop
}
  8014f9:	c9                   	leave  
  8014fa:	c3                   	ret    

008014fb <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	ff 75 0c             	pushl  0xc(%ebp)
  801507:	ff 75 08             	pushl  0x8(%ebp)
  80150a:	6a 12                	push   $0x12
  80150c:	e8 17 fe ff ff       	call   801328 <syscall>
  801511:	83 c4 18             	add    $0x18,%esp
	return ;
  801514:	90                   	nop
}
  801515:	c9                   	leave  
  801516:	c3                   	ret    

00801517 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801517:	55                   	push   %ebp
  801518:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	6a 00                	push   $0x0
  801522:	6a 00                	push   $0x0
  801524:	6a 0e                	push   $0xe
  801526:	e8 fd fd ff ff       	call   801328 <syscall>
  80152b:	83 c4 18             	add    $0x18,%esp
}
  80152e:	c9                   	leave  
  80152f:	c3                   	ret    

00801530 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801530:	55                   	push   %ebp
  801531:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	ff 75 08             	pushl  0x8(%ebp)
  80153e:	6a 0f                	push   $0xf
  801540:	e8 e3 fd ff ff       	call   801328 <syscall>
  801545:	83 c4 18             	add    $0x18,%esp
}
  801548:	c9                   	leave  
  801549:	c3                   	ret    

0080154a <sys_scarce_memory>:

void sys_scarce_memory()
{
  80154a:	55                   	push   %ebp
  80154b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 10                	push   $0x10
  801559:	e8 ca fd ff ff       	call   801328 <syscall>
  80155e:	83 c4 18             	add    $0x18,%esp
}
  801561:	90                   	nop
  801562:	c9                   	leave  
  801563:	c3                   	ret    

00801564 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801564:	55                   	push   %ebp
  801565:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	6a 14                	push   $0x14
  801573:	e8 b0 fd ff ff       	call   801328 <syscall>
  801578:	83 c4 18             	add    $0x18,%esp
}
  80157b:	90                   	nop
  80157c:	c9                   	leave  
  80157d:	c3                   	ret    

0080157e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 15                	push   $0x15
  80158d:	e8 96 fd ff ff       	call   801328 <syscall>
  801592:	83 c4 18             	add    $0x18,%esp
}
  801595:	90                   	nop
  801596:	c9                   	leave  
  801597:	c3                   	ret    

00801598 <sys_cputc>:


void
sys_cputc(const char c)
{
  801598:	55                   	push   %ebp
  801599:	89 e5                	mov    %esp,%ebp
  80159b:	83 ec 04             	sub    $0x4,%esp
  80159e:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8015a4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	50                   	push   %eax
  8015b1:	6a 16                	push   $0x16
  8015b3:	e8 70 fd ff ff       	call   801328 <syscall>
  8015b8:	83 c4 18             	add    $0x18,%esp
}
  8015bb:	90                   	nop
  8015bc:	c9                   	leave  
  8015bd:	c3                   	ret    

008015be <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015be:	55                   	push   %ebp
  8015bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 17                	push   $0x17
  8015cd:	e8 56 fd ff ff       	call   801328 <syscall>
  8015d2:	83 c4 18             	add    $0x18,%esp
}
  8015d5:	90                   	nop
  8015d6:	c9                   	leave  
  8015d7:	c3                   	ret    

008015d8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8015d8:	55                   	push   %ebp
  8015d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	ff 75 0c             	pushl  0xc(%ebp)
  8015e7:	50                   	push   %eax
  8015e8:	6a 18                	push   $0x18
  8015ea:	e8 39 fd ff ff       	call   801328 <syscall>
  8015ef:	83 c4 18             	add    $0x18,%esp
}
  8015f2:	c9                   	leave  
  8015f3:	c3                   	ret    

008015f4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8015f4:	55                   	push   %ebp
  8015f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	52                   	push   %edx
  801604:	50                   	push   %eax
  801605:	6a 1b                	push   $0x1b
  801607:	e8 1c fd ff ff       	call   801328 <syscall>
  80160c:	83 c4 18             	add    $0x18,%esp
}
  80160f:	c9                   	leave  
  801610:	c3                   	ret    

00801611 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801611:	55                   	push   %ebp
  801612:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801614:	8b 55 0c             	mov    0xc(%ebp),%edx
  801617:	8b 45 08             	mov    0x8(%ebp),%eax
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	52                   	push   %edx
  801621:	50                   	push   %eax
  801622:	6a 19                	push   $0x19
  801624:	e8 ff fc ff ff       	call   801328 <syscall>
  801629:	83 c4 18             	add    $0x18,%esp
}
  80162c:	90                   	nop
  80162d:	c9                   	leave  
  80162e:	c3                   	ret    

0080162f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80162f:	55                   	push   %ebp
  801630:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801632:	8b 55 0c             	mov    0xc(%ebp),%edx
  801635:	8b 45 08             	mov    0x8(%ebp),%eax
  801638:	6a 00                	push   $0x0
  80163a:	6a 00                	push   $0x0
  80163c:	6a 00                	push   $0x0
  80163e:	52                   	push   %edx
  80163f:	50                   	push   %eax
  801640:	6a 1a                	push   $0x1a
  801642:	e8 e1 fc ff ff       	call   801328 <syscall>
  801647:	83 c4 18             	add    $0x18,%esp
}
  80164a:	90                   	nop
  80164b:	c9                   	leave  
  80164c:	c3                   	ret    

0080164d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80164d:	55                   	push   %ebp
  80164e:	89 e5                	mov    %esp,%ebp
  801650:	83 ec 04             	sub    $0x4,%esp
  801653:	8b 45 10             	mov    0x10(%ebp),%eax
  801656:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801659:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80165c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801660:	8b 45 08             	mov    0x8(%ebp),%eax
  801663:	6a 00                	push   $0x0
  801665:	51                   	push   %ecx
  801666:	52                   	push   %edx
  801667:	ff 75 0c             	pushl  0xc(%ebp)
  80166a:	50                   	push   %eax
  80166b:	6a 1c                	push   $0x1c
  80166d:	e8 b6 fc ff ff       	call   801328 <syscall>
  801672:	83 c4 18             	add    $0x18,%esp
}
  801675:	c9                   	leave  
  801676:	c3                   	ret    

00801677 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801677:	55                   	push   %ebp
  801678:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80167a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80167d:	8b 45 08             	mov    0x8(%ebp),%eax
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	52                   	push   %edx
  801687:	50                   	push   %eax
  801688:	6a 1d                	push   $0x1d
  80168a:	e8 99 fc ff ff       	call   801328 <syscall>
  80168f:	83 c4 18             	add    $0x18,%esp
}
  801692:	c9                   	leave  
  801693:	c3                   	ret    

00801694 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801694:	55                   	push   %ebp
  801695:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801697:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80169a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	51                   	push   %ecx
  8016a5:	52                   	push   %edx
  8016a6:	50                   	push   %eax
  8016a7:	6a 1e                	push   $0x1e
  8016a9:	e8 7a fc ff ff       	call   801328 <syscall>
  8016ae:	83 c4 18             	add    $0x18,%esp
}
  8016b1:	c9                   	leave  
  8016b2:	c3                   	ret    

008016b3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016b3:	55                   	push   %ebp
  8016b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	52                   	push   %edx
  8016c3:	50                   	push   %eax
  8016c4:	6a 1f                	push   $0x1f
  8016c6:	e8 5d fc ff ff       	call   801328 <syscall>
  8016cb:	83 c4 18             	add    $0x18,%esp
}
  8016ce:	c9                   	leave  
  8016cf:	c3                   	ret    

008016d0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 20                	push   $0x20
  8016df:	e8 44 fc ff ff       	call   801328 <syscall>
  8016e4:	83 c4 18             	add    $0x18,%esp
}
  8016e7:	c9                   	leave  
  8016e8:	c3                   	ret    

008016e9 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8016e9:	55                   	push   %ebp
  8016ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8016ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	ff 75 10             	pushl  0x10(%ebp)
  8016f6:	ff 75 0c             	pushl  0xc(%ebp)
  8016f9:	50                   	push   %eax
  8016fa:	6a 21                	push   $0x21
  8016fc:	e8 27 fc ff ff       	call   801328 <syscall>
  801701:	83 c4 18             	add    $0x18,%esp
}
  801704:	c9                   	leave  
  801705:	c3                   	ret    

00801706 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801706:	55                   	push   %ebp
  801707:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801709:	8b 45 08             	mov    0x8(%ebp),%eax
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	50                   	push   %eax
  801715:	6a 22                	push   $0x22
  801717:	e8 0c fc ff ff       	call   801328 <syscall>
  80171c:	83 c4 18             	add    $0x18,%esp
}
  80171f:	90                   	nop
  801720:	c9                   	leave  
  801721:	c3                   	ret    

00801722 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801722:	55                   	push   %ebp
  801723:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	50                   	push   %eax
  801731:	6a 23                	push   $0x23
  801733:	e8 f0 fb ff ff       	call   801328 <syscall>
  801738:	83 c4 18             	add    $0x18,%esp
}
  80173b:	90                   	nop
  80173c:	c9                   	leave  
  80173d:	c3                   	ret    

0080173e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80173e:	55                   	push   %ebp
  80173f:	89 e5                	mov    %esp,%ebp
  801741:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801744:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801747:	8d 50 04             	lea    0x4(%eax),%edx
  80174a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	52                   	push   %edx
  801754:	50                   	push   %eax
  801755:	6a 24                	push   $0x24
  801757:	e8 cc fb ff ff       	call   801328 <syscall>
  80175c:	83 c4 18             	add    $0x18,%esp
	return result;
  80175f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801762:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801765:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801768:	89 01                	mov    %eax,(%ecx)
  80176a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	c9                   	leave  
  801771:	c2 04 00             	ret    $0x4

00801774 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801774:	55                   	push   %ebp
  801775:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	ff 75 10             	pushl  0x10(%ebp)
  80177e:	ff 75 0c             	pushl  0xc(%ebp)
  801781:	ff 75 08             	pushl  0x8(%ebp)
  801784:	6a 13                	push   $0x13
  801786:	e8 9d fb ff ff       	call   801328 <syscall>
  80178b:	83 c4 18             	add    $0x18,%esp
	return ;
  80178e:	90                   	nop
}
  80178f:	c9                   	leave  
  801790:	c3                   	ret    

00801791 <sys_rcr2>:
uint32 sys_rcr2()
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 25                	push   $0x25
  8017a0:	e8 83 fb ff ff       	call   801328 <syscall>
  8017a5:	83 c4 18             	add    $0x18,%esp
}
  8017a8:	c9                   	leave  
  8017a9:	c3                   	ret    

008017aa <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017aa:	55                   	push   %ebp
  8017ab:	89 e5                	mov    %esp,%ebp
  8017ad:	83 ec 04             	sub    $0x4,%esp
  8017b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017b6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	50                   	push   %eax
  8017c3:	6a 26                	push   $0x26
  8017c5:	e8 5e fb ff ff       	call   801328 <syscall>
  8017ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8017cd:	90                   	nop
}
  8017ce:	c9                   	leave  
  8017cf:	c3                   	ret    

008017d0 <rsttst>:
void rsttst()
{
  8017d0:	55                   	push   %ebp
  8017d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 28                	push   $0x28
  8017df:	e8 44 fb ff ff       	call   801328 <syscall>
  8017e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8017e7:	90                   	nop
}
  8017e8:	c9                   	leave  
  8017e9:	c3                   	ret    

008017ea <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8017ea:	55                   	push   %ebp
  8017eb:	89 e5                	mov    %esp,%ebp
  8017ed:	83 ec 04             	sub    $0x4,%esp
  8017f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8017f3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8017f6:	8b 55 18             	mov    0x18(%ebp),%edx
  8017f9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017fd:	52                   	push   %edx
  8017fe:	50                   	push   %eax
  8017ff:	ff 75 10             	pushl  0x10(%ebp)
  801802:	ff 75 0c             	pushl  0xc(%ebp)
  801805:	ff 75 08             	pushl  0x8(%ebp)
  801808:	6a 27                	push   $0x27
  80180a:	e8 19 fb ff ff       	call   801328 <syscall>
  80180f:	83 c4 18             	add    $0x18,%esp
	return ;
  801812:	90                   	nop
}
  801813:	c9                   	leave  
  801814:	c3                   	ret    

00801815 <chktst>:
void chktst(uint32 n)
{
  801815:	55                   	push   %ebp
  801816:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	ff 75 08             	pushl  0x8(%ebp)
  801823:	6a 29                	push   $0x29
  801825:	e8 fe fa ff ff       	call   801328 <syscall>
  80182a:	83 c4 18             	add    $0x18,%esp
	return ;
  80182d:	90                   	nop
}
  80182e:	c9                   	leave  
  80182f:	c3                   	ret    

00801830 <inctst>:

void inctst()
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 2a                	push   $0x2a
  80183f:	e8 e4 fa ff ff       	call   801328 <syscall>
  801844:	83 c4 18             	add    $0x18,%esp
	return ;
  801847:	90                   	nop
}
  801848:	c9                   	leave  
  801849:	c3                   	ret    

0080184a <gettst>:
uint32 gettst()
{
  80184a:	55                   	push   %ebp
  80184b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 2b                	push   $0x2b
  801859:	e8 ca fa ff ff       	call   801328 <syscall>
  80185e:	83 c4 18             	add    $0x18,%esp
}
  801861:	c9                   	leave  
  801862:	c3                   	ret    

00801863 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801863:	55                   	push   %ebp
  801864:	89 e5                	mov    %esp,%ebp
  801866:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 2c                	push   $0x2c
  801875:	e8 ae fa ff ff       	call   801328 <syscall>
  80187a:	83 c4 18             	add    $0x18,%esp
  80187d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801880:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801884:	75 07                	jne    80188d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801886:	b8 01 00 00 00       	mov    $0x1,%eax
  80188b:	eb 05                	jmp    801892 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80188d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801892:	c9                   	leave  
  801893:	c3                   	ret    

00801894 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801894:	55                   	push   %ebp
  801895:	89 e5                	mov    %esp,%ebp
  801897:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 2c                	push   $0x2c
  8018a6:	e8 7d fa ff ff       	call   801328 <syscall>
  8018ab:	83 c4 18             	add    $0x18,%esp
  8018ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018b1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018b5:	75 07                	jne    8018be <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018b7:	b8 01 00 00 00       	mov    $0x1,%eax
  8018bc:	eb 05                	jmp    8018c3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018be:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018c3:	c9                   	leave  
  8018c4:	c3                   	ret    

008018c5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018c5:	55                   	push   %ebp
  8018c6:	89 e5                	mov    %esp,%ebp
  8018c8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 2c                	push   $0x2c
  8018d7:	e8 4c fa ff ff       	call   801328 <syscall>
  8018dc:	83 c4 18             	add    $0x18,%esp
  8018df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018e2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8018e6:	75 07                	jne    8018ef <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8018e8:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ed:	eb 05                	jmp    8018f4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8018ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018f4:	c9                   	leave  
  8018f5:	c3                   	ret    

008018f6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8018f6:	55                   	push   %ebp
  8018f7:	89 e5                	mov    %esp,%ebp
  8018f9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	6a 2c                	push   $0x2c
  801908:	e8 1b fa ff ff       	call   801328 <syscall>
  80190d:	83 c4 18             	add    $0x18,%esp
  801910:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801913:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801917:	75 07                	jne    801920 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801919:	b8 01 00 00 00       	mov    $0x1,%eax
  80191e:	eb 05                	jmp    801925 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801920:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801925:	c9                   	leave  
  801926:	c3                   	ret    

00801927 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801927:	55                   	push   %ebp
  801928:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	ff 75 08             	pushl  0x8(%ebp)
  801935:	6a 2d                	push   $0x2d
  801937:	e8 ec f9 ff ff       	call   801328 <syscall>
  80193c:	83 c4 18             	add    $0x18,%esp
	return ;
  80193f:	90                   	nop
}
  801940:	c9                   	leave  
  801941:	c3                   	ret    

00801942 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801942:	55                   	push   %ebp
  801943:	89 e5                	mov    %esp,%ebp
  801945:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801948:	8d 45 10             	lea    0x10(%ebp),%eax
  80194b:	83 c0 04             	add    $0x4,%eax
  80194e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801951:	a1 40 30 98 00       	mov    0x983040,%eax
  801956:	85 c0                	test   %eax,%eax
  801958:	74 16                	je     801970 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80195a:	a1 40 30 98 00       	mov    0x983040,%eax
  80195f:	83 ec 08             	sub    $0x8,%esp
  801962:	50                   	push   %eax
  801963:	68 5c 22 80 00       	push   $0x80225c
  801968:	e8 a1 e9 ff ff       	call   80030e <cprintf>
  80196d:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801970:	a1 00 30 80 00       	mov    0x803000,%eax
  801975:	ff 75 0c             	pushl  0xc(%ebp)
  801978:	ff 75 08             	pushl  0x8(%ebp)
  80197b:	50                   	push   %eax
  80197c:	68 61 22 80 00       	push   $0x802261
  801981:	e8 88 e9 ff ff       	call   80030e <cprintf>
  801986:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801989:	8b 45 10             	mov    0x10(%ebp),%eax
  80198c:	83 ec 08             	sub    $0x8,%esp
  80198f:	ff 75 f4             	pushl  -0xc(%ebp)
  801992:	50                   	push   %eax
  801993:	e8 0b e9 ff ff       	call   8002a3 <vcprintf>
  801998:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80199b:	83 ec 08             	sub    $0x8,%esp
  80199e:	6a 00                	push   $0x0
  8019a0:	68 7d 22 80 00       	push   $0x80227d
  8019a5:	e8 f9 e8 ff ff       	call   8002a3 <vcprintf>
  8019aa:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8019ad:	e8 7a e8 ff ff       	call   80022c <exit>

	// should not return here
	while (1) ;
  8019b2:	eb fe                	jmp    8019b2 <_panic+0x70>

008019b4 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8019b4:	55                   	push   %ebp
  8019b5:	89 e5                	mov    %esp,%ebp
  8019b7:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8019ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8019bf:	8b 50 74             	mov    0x74(%eax),%edx
  8019c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019c5:	39 c2                	cmp    %eax,%edx
  8019c7:	74 14                	je     8019dd <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8019c9:	83 ec 04             	sub    $0x4,%esp
  8019cc:	68 80 22 80 00       	push   $0x802280
  8019d1:	6a 26                	push   $0x26
  8019d3:	68 cc 22 80 00       	push   $0x8022cc
  8019d8:	e8 65 ff ff ff       	call   801942 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8019dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8019e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019eb:	e9 c2 00 00 00       	jmp    801ab2 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8019f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019f3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fd:	01 d0                	add    %edx,%eax
  8019ff:	8b 00                	mov    (%eax),%eax
  801a01:	85 c0                	test   %eax,%eax
  801a03:	75 08                	jne    801a0d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801a05:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801a08:	e9 a2 00 00 00       	jmp    801aaf <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801a0d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a14:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801a1b:	eb 69                	jmp    801a86 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801a1d:	a1 20 30 80 00       	mov    0x803020,%eax
  801a22:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a28:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a2b:	89 d0                	mov    %edx,%eax
  801a2d:	01 c0                	add    %eax,%eax
  801a2f:	01 d0                	add    %edx,%eax
  801a31:	c1 e0 02             	shl    $0x2,%eax
  801a34:	01 c8                	add    %ecx,%eax
  801a36:	8a 40 04             	mov    0x4(%eax),%al
  801a39:	84 c0                	test   %al,%al
  801a3b:	75 46                	jne    801a83 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801a3d:	a1 20 30 80 00       	mov    0x803020,%eax
  801a42:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a48:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a4b:	89 d0                	mov    %edx,%eax
  801a4d:	01 c0                	add    %eax,%eax
  801a4f:	01 d0                	add    %edx,%eax
  801a51:	c1 e0 02             	shl    $0x2,%eax
  801a54:	01 c8                	add    %ecx,%eax
  801a56:	8b 00                	mov    (%eax),%eax
  801a58:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801a5b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a5e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801a63:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801a65:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a68:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a72:	01 c8                	add    %ecx,%eax
  801a74:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801a76:	39 c2                	cmp    %eax,%edx
  801a78:	75 09                	jne    801a83 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801a7a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801a81:	eb 12                	jmp    801a95 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a83:	ff 45 e8             	incl   -0x18(%ebp)
  801a86:	a1 20 30 80 00       	mov    0x803020,%eax
  801a8b:	8b 50 74             	mov    0x74(%eax),%edx
  801a8e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a91:	39 c2                	cmp    %eax,%edx
  801a93:	77 88                	ja     801a1d <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801a95:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801a99:	75 14                	jne    801aaf <CheckWSWithoutLastIndex+0xfb>
			panic(
  801a9b:	83 ec 04             	sub    $0x4,%esp
  801a9e:	68 d8 22 80 00       	push   $0x8022d8
  801aa3:	6a 3a                	push   $0x3a
  801aa5:	68 cc 22 80 00       	push   $0x8022cc
  801aaa:	e8 93 fe ff ff       	call   801942 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801aaf:	ff 45 f0             	incl   -0x10(%ebp)
  801ab2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ab5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801ab8:	0f 8c 32 ff ff ff    	jl     8019f0 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801abe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ac5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801acc:	eb 26                	jmp    801af4 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801ace:	a1 20 30 80 00       	mov    0x803020,%eax
  801ad3:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801ad9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801adc:	89 d0                	mov    %edx,%eax
  801ade:	01 c0                	add    %eax,%eax
  801ae0:	01 d0                	add    %edx,%eax
  801ae2:	c1 e0 02             	shl    $0x2,%eax
  801ae5:	01 c8                	add    %ecx,%eax
  801ae7:	8a 40 04             	mov    0x4(%eax),%al
  801aea:	3c 01                	cmp    $0x1,%al
  801aec:	75 03                	jne    801af1 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801aee:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801af1:	ff 45 e0             	incl   -0x20(%ebp)
  801af4:	a1 20 30 80 00       	mov    0x803020,%eax
  801af9:	8b 50 74             	mov    0x74(%eax),%edx
  801afc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801aff:	39 c2                	cmp    %eax,%edx
  801b01:	77 cb                	ja     801ace <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b06:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b09:	74 14                	je     801b1f <CheckWSWithoutLastIndex+0x16b>
		panic(
  801b0b:	83 ec 04             	sub    $0x4,%esp
  801b0e:	68 2c 23 80 00       	push   $0x80232c
  801b13:	6a 44                	push   $0x44
  801b15:	68 cc 22 80 00       	push   $0x8022cc
  801b1a:	e8 23 fe ff ff       	call   801942 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801b1f:	90                   	nop
  801b20:	c9                   	leave  
  801b21:	c3                   	ret    
  801b22:	66 90                	xchg   %ax,%ax

00801b24 <__udivdi3>:
  801b24:	55                   	push   %ebp
  801b25:	57                   	push   %edi
  801b26:	56                   	push   %esi
  801b27:	53                   	push   %ebx
  801b28:	83 ec 1c             	sub    $0x1c,%esp
  801b2b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b2f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b33:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b37:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b3b:	89 ca                	mov    %ecx,%edx
  801b3d:	89 f8                	mov    %edi,%eax
  801b3f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b43:	85 f6                	test   %esi,%esi
  801b45:	75 2d                	jne    801b74 <__udivdi3+0x50>
  801b47:	39 cf                	cmp    %ecx,%edi
  801b49:	77 65                	ja     801bb0 <__udivdi3+0x8c>
  801b4b:	89 fd                	mov    %edi,%ebp
  801b4d:	85 ff                	test   %edi,%edi
  801b4f:	75 0b                	jne    801b5c <__udivdi3+0x38>
  801b51:	b8 01 00 00 00       	mov    $0x1,%eax
  801b56:	31 d2                	xor    %edx,%edx
  801b58:	f7 f7                	div    %edi
  801b5a:	89 c5                	mov    %eax,%ebp
  801b5c:	31 d2                	xor    %edx,%edx
  801b5e:	89 c8                	mov    %ecx,%eax
  801b60:	f7 f5                	div    %ebp
  801b62:	89 c1                	mov    %eax,%ecx
  801b64:	89 d8                	mov    %ebx,%eax
  801b66:	f7 f5                	div    %ebp
  801b68:	89 cf                	mov    %ecx,%edi
  801b6a:	89 fa                	mov    %edi,%edx
  801b6c:	83 c4 1c             	add    $0x1c,%esp
  801b6f:	5b                   	pop    %ebx
  801b70:	5e                   	pop    %esi
  801b71:	5f                   	pop    %edi
  801b72:	5d                   	pop    %ebp
  801b73:	c3                   	ret    
  801b74:	39 ce                	cmp    %ecx,%esi
  801b76:	77 28                	ja     801ba0 <__udivdi3+0x7c>
  801b78:	0f bd fe             	bsr    %esi,%edi
  801b7b:	83 f7 1f             	xor    $0x1f,%edi
  801b7e:	75 40                	jne    801bc0 <__udivdi3+0x9c>
  801b80:	39 ce                	cmp    %ecx,%esi
  801b82:	72 0a                	jb     801b8e <__udivdi3+0x6a>
  801b84:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b88:	0f 87 9e 00 00 00    	ja     801c2c <__udivdi3+0x108>
  801b8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b93:	89 fa                	mov    %edi,%edx
  801b95:	83 c4 1c             	add    $0x1c,%esp
  801b98:	5b                   	pop    %ebx
  801b99:	5e                   	pop    %esi
  801b9a:	5f                   	pop    %edi
  801b9b:	5d                   	pop    %ebp
  801b9c:	c3                   	ret    
  801b9d:	8d 76 00             	lea    0x0(%esi),%esi
  801ba0:	31 ff                	xor    %edi,%edi
  801ba2:	31 c0                	xor    %eax,%eax
  801ba4:	89 fa                	mov    %edi,%edx
  801ba6:	83 c4 1c             	add    $0x1c,%esp
  801ba9:	5b                   	pop    %ebx
  801baa:	5e                   	pop    %esi
  801bab:	5f                   	pop    %edi
  801bac:	5d                   	pop    %ebp
  801bad:	c3                   	ret    
  801bae:	66 90                	xchg   %ax,%ax
  801bb0:	89 d8                	mov    %ebx,%eax
  801bb2:	f7 f7                	div    %edi
  801bb4:	31 ff                	xor    %edi,%edi
  801bb6:	89 fa                	mov    %edi,%edx
  801bb8:	83 c4 1c             	add    $0x1c,%esp
  801bbb:	5b                   	pop    %ebx
  801bbc:	5e                   	pop    %esi
  801bbd:	5f                   	pop    %edi
  801bbe:	5d                   	pop    %ebp
  801bbf:	c3                   	ret    
  801bc0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801bc5:	89 eb                	mov    %ebp,%ebx
  801bc7:	29 fb                	sub    %edi,%ebx
  801bc9:	89 f9                	mov    %edi,%ecx
  801bcb:	d3 e6                	shl    %cl,%esi
  801bcd:	89 c5                	mov    %eax,%ebp
  801bcf:	88 d9                	mov    %bl,%cl
  801bd1:	d3 ed                	shr    %cl,%ebp
  801bd3:	89 e9                	mov    %ebp,%ecx
  801bd5:	09 f1                	or     %esi,%ecx
  801bd7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bdb:	89 f9                	mov    %edi,%ecx
  801bdd:	d3 e0                	shl    %cl,%eax
  801bdf:	89 c5                	mov    %eax,%ebp
  801be1:	89 d6                	mov    %edx,%esi
  801be3:	88 d9                	mov    %bl,%cl
  801be5:	d3 ee                	shr    %cl,%esi
  801be7:	89 f9                	mov    %edi,%ecx
  801be9:	d3 e2                	shl    %cl,%edx
  801beb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bef:	88 d9                	mov    %bl,%cl
  801bf1:	d3 e8                	shr    %cl,%eax
  801bf3:	09 c2                	or     %eax,%edx
  801bf5:	89 d0                	mov    %edx,%eax
  801bf7:	89 f2                	mov    %esi,%edx
  801bf9:	f7 74 24 0c          	divl   0xc(%esp)
  801bfd:	89 d6                	mov    %edx,%esi
  801bff:	89 c3                	mov    %eax,%ebx
  801c01:	f7 e5                	mul    %ebp
  801c03:	39 d6                	cmp    %edx,%esi
  801c05:	72 19                	jb     801c20 <__udivdi3+0xfc>
  801c07:	74 0b                	je     801c14 <__udivdi3+0xf0>
  801c09:	89 d8                	mov    %ebx,%eax
  801c0b:	31 ff                	xor    %edi,%edi
  801c0d:	e9 58 ff ff ff       	jmp    801b6a <__udivdi3+0x46>
  801c12:	66 90                	xchg   %ax,%ax
  801c14:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c18:	89 f9                	mov    %edi,%ecx
  801c1a:	d3 e2                	shl    %cl,%edx
  801c1c:	39 c2                	cmp    %eax,%edx
  801c1e:	73 e9                	jae    801c09 <__udivdi3+0xe5>
  801c20:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c23:	31 ff                	xor    %edi,%edi
  801c25:	e9 40 ff ff ff       	jmp    801b6a <__udivdi3+0x46>
  801c2a:	66 90                	xchg   %ax,%ax
  801c2c:	31 c0                	xor    %eax,%eax
  801c2e:	e9 37 ff ff ff       	jmp    801b6a <__udivdi3+0x46>
  801c33:	90                   	nop

00801c34 <__umoddi3>:
  801c34:	55                   	push   %ebp
  801c35:	57                   	push   %edi
  801c36:	56                   	push   %esi
  801c37:	53                   	push   %ebx
  801c38:	83 ec 1c             	sub    $0x1c,%esp
  801c3b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c3f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c47:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c4f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c53:	89 f3                	mov    %esi,%ebx
  801c55:	89 fa                	mov    %edi,%edx
  801c57:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c5b:	89 34 24             	mov    %esi,(%esp)
  801c5e:	85 c0                	test   %eax,%eax
  801c60:	75 1a                	jne    801c7c <__umoddi3+0x48>
  801c62:	39 f7                	cmp    %esi,%edi
  801c64:	0f 86 a2 00 00 00    	jbe    801d0c <__umoddi3+0xd8>
  801c6a:	89 c8                	mov    %ecx,%eax
  801c6c:	89 f2                	mov    %esi,%edx
  801c6e:	f7 f7                	div    %edi
  801c70:	89 d0                	mov    %edx,%eax
  801c72:	31 d2                	xor    %edx,%edx
  801c74:	83 c4 1c             	add    $0x1c,%esp
  801c77:	5b                   	pop    %ebx
  801c78:	5e                   	pop    %esi
  801c79:	5f                   	pop    %edi
  801c7a:	5d                   	pop    %ebp
  801c7b:	c3                   	ret    
  801c7c:	39 f0                	cmp    %esi,%eax
  801c7e:	0f 87 ac 00 00 00    	ja     801d30 <__umoddi3+0xfc>
  801c84:	0f bd e8             	bsr    %eax,%ebp
  801c87:	83 f5 1f             	xor    $0x1f,%ebp
  801c8a:	0f 84 ac 00 00 00    	je     801d3c <__umoddi3+0x108>
  801c90:	bf 20 00 00 00       	mov    $0x20,%edi
  801c95:	29 ef                	sub    %ebp,%edi
  801c97:	89 fe                	mov    %edi,%esi
  801c99:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c9d:	89 e9                	mov    %ebp,%ecx
  801c9f:	d3 e0                	shl    %cl,%eax
  801ca1:	89 d7                	mov    %edx,%edi
  801ca3:	89 f1                	mov    %esi,%ecx
  801ca5:	d3 ef                	shr    %cl,%edi
  801ca7:	09 c7                	or     %eax,%edi
  801ca9:	89 e9                	mov    %ebp,%ecx
  801cab:	d3 e2                	shl    %cl,%edx
  801cad:	89 14 24             	mov    %edx,(%esp)
  801cb0:	89 d8                	mov    %ebx,%eax
  801cb2:	d3 e0                	shl    %cl,%eax
  801cb4:	89 c2                	mov    %eax,%edx
  801cb6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cba:	d3 e0                	shl    %cl,%eax
  801cbc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801cc0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cc4:	89 f1                	mov    %esi,%ecx
  801cc6:	d3 e8                	shr    %cl,%eax
  801cc8:	09 d0                	or     %edx,%eax
  801cca:	d3 eb                	shr    %cl,%ebx
  801ccc:	89 da                	mov    %ebx,%edx
  801cce:	f7 f7                	div    %edi
  801cd0:	89 d3                	mov    %edx,%ebx
  801cd2:	f7 24 24             	mull   (%esp)
  801cd5:	89 c6                	mov    %eax,%esi
  801cd7:	89 d1                	mov    %edx,%ecx
  801cd9:	39 d3                	cmp    %edx,%ebx
  801cdb:	0f 82 87 00 00 00    	jb     801d68 <__umoddi3+0x134>
  801ce1:	0f 84 91 00 00 00    	je     801d78 <__umoddi3+0x144>
  801ce7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ceb:	29 f2                	sub    %esi,%edx
  801ced:	19 cb                	sbb    %ecx,%ebx
  801cef:	89 d8                	mov    %ebx,%eax
  801cf1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801cf5:	d3 e0                	shl    %cl,%eax
  801cf7:	89 e9                	mov    %ebp,%ecx
  801cf9:	d3 ea                	shr    %cl,%edx
  801cfb:	09 d0                	or     %edx,%eax
  801cfd:	89 e9                	mov    %ebp,%ecx
  801cff:	d3 eb                	shr    %cl,%ebx
  801d01:	89 da                	mov    %ebx,%edx
  801d03:	83 c4 1c             	add    $0x1c,%esp
  801d06:	5b                   	pop    %ebx
  801d07:	5e                   	pop    %esi
  801d08:	5f                   	pop    %edi
  801d09:	5d                   	pop    %ebp
  801d0a:	c3                   	ret    
  801d0b:	90                   	nop
  801d0c:	89 fd                	mov    %edi,%ebp
  801d0e:	85 ff                	test   %edi,%edi
  801d10:	75 0b                	jne    801d1d <__umoddi3+0xe9>
  801d12:	b8 01 00 00 00       	mov    $0x1,%eax
  801d17:	31 d2                	xor    %edx,%edx
  801d19:	f7 f7                	div    %edi
  801d1b:	89 c5                	mov    %eax,%ebp
  801d1d:	89 f0                	mov    %esi,%eax
  801d1f:	31 d2                	xor    %edx,%edx
  801d21:	f7 f5                	div    %ebp
  801d23:	89 c8                	mov    %ecx,%eax
  801d25:	f7 f5                	div    %ebp
  801d27:	89 d0                	mov    %edx,%eax
  801d29:	e9 44 ff ff ff       	jmp    801c72 <__umoddi3+0x3e>
  801d2e:	66 90                	xchg   %ax,%ax
  801d30:	89 c8                	mov    %ecx,%eax
  801d32:	89 f2                	mov    %esi,%edx
  801d34:	83 c4 1c             	add    $0x1c,%esp
  801d37:	5b                   	pop    %ebx
  801d38:	5e                   	pop    %esi
  801d39:	5f                   	pop    %edi
  801d3a:	5d                   	pop    %ebp
  801d3b:	c3                   	ret    
  801d3c:	3b 04 24             	cmp    (%esp),%eax
  801d3f:	72 06                	jb     801d47 <__umoddi3+0x113>
  801d41:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d45:	77 0f                	ja     801d56 <__umoddi3+0x122>
  801d47:	89 f2                	mov    %esi,%edx
  801d49:	29 f9                	sub    %edi,%ecx
  801d4b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d4f:	89 14 24             	mov    %edx,(%esp)
  801d52:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d56:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d5a:	8b 14 24             	mov    (%esp),%edx
  801d5d:	83 c4 1c             	add    $0x1c,%esp
  801d60:	5b                   	pop    %ebx
  801d61:	5e                   	pop    %esi
  801d62:	5f                   	pop    %edi
  801d63:	5d                   	pop    %ebp
  801d64:	c3                   	ret    
  801d65:	8d 76 00             	lea    0x0(%esi),%esi
  801d68:	2b 04 24             	sub    (%esp),%eax
  801d6b:	19 fa                	sbb    %edi,%edx
  801d6d:	89 d1                	mov    %edx,%ecx
  801d6f:	89 c6                	mov    %eax,%esi
  801d71:	e9 71 ff ff ff       	jmp    801ce7 <__umoddi3+0xb3>
  801d76:	66 90                	xchg   %ax,%ax
  801d78:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d7c:	72 ea                	jb     801d68 <__umoddi3+0x134>
  801d7e:	89 d9                	mov    %ebx,%ecx
  801d80:	e9 62 ff ff ff       	jmp    801ce7 <__umoddi3+0xb3>
