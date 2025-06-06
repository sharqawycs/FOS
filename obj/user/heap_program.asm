
obj/user/heap_program:     file format elf32-i386


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
  800031:	e8 f3 01 00 00       	call   800229 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 5c             	sub    $0x5c,%esp
	int kilo = 1024;
  800041:	c7 45 d8 00 04 00 00 	movl   $0x400,-0x28(%ebp)
	int Mega = 1024*1024;
  800048:	c7 45 d4 00 00 10 00 	movl   $0x100000,-0x2c(%ebp)

	/// testing freeHeap()
	{
		uint32 size = 13*Mega;
  80004f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800052:	89 d0                	mov    %edx,%eax
  800054:	01 c0                	add    %eax,%eax
  800056:	01 d0                	add    %edx,%eax
  800058:	c1 e0 02             	shl    $0x2,%eax
  80005b:	01 d0                	add    %edx,%eax
  80005d:	89 45 d0             	mov    %eax,-0x30(%ebp)
		char *x = malloc(sizeof( char)*size) ;
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	ff 75 d0             	pushl  -0x30(%ebp)
  800066:	e8 38 13 00 00       	call   8013a3 <malloc>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	89 45 cc             	mov    %eax,-0x34(%ebp)

		char *y = malloc(sizeof( char)*size) ;
  800071:	83 ec 0c             	sub    $0xc,%esp
  800074:	ff 75 d0             	pushl  -0x30(%ebp)
  800077:	e8 27 13 00 00       	call   8013a3 <malloc>
  80007c:	83 c4 10             	add    $0x10,%esp
  80007f:	89 45 c8             	mov    %eax,-0x38(%ebp)


		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800082:	e8 61 17 00 00       	call   8017e8 <sys_pf_calculate_allocated_pages>
  800087:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		x[1]=-1;
  80008a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80008d:	40                   	inc    %eax
  80008e:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega]=-1;
  800091:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800094:	89 d0                	mov    %edx,%eax
  800096:	c1 e0 02             	shl    $0x2,%eax
  800099:	01 d0                	add    %edx,%eax
  80009b:	89 c2                	mov    %eax,%edx
  80009d:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000a0:	01 d0                	add    %edx,%eax
  8000a2:	c6 00 ff             	movb   $0xff,(%eax)

		x[8*Mega] = -1;
  8000a5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000a8:	c1 e0 03             	shl    $0x3,%eax
  8000ab:	89 c2                	mov    %eax,%edx
  8000ad:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000b0:	01 d0                	add    %edx,%eax
  8000b2:	c6 00 ff             	movb   $0xff,(%eax)

		x[12*Mega]=-1;
  8000b5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8000b8:	89 d0                	mov    %edx,%eax
  8000ba:	01 c0                	add    %eax,%eax
  8000bc:	01 d0                	add    %edx,%eax
  8000be:	c1 e0 02             	shl    $0x2,%eax
  8000c1:	89 c2                	mov    %eax,%edx
  8000c3:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000c6:	01 d0                	add    %edx,%eax
  8000c8:	c6 00 ff             	movb   $0xff,(%eax)

		//int usedDiskPages = sys_pf_calculate_allocated_pages() ;

		free(x);
  8000cb:	83 ec 0c             	sub    $0xc,%esp
  8000ce:	ff 75 cc             	pushl  -0x34(%ebp)
  8000d1:	e8 ee 13 00 00       	call   8014c4 <free>
  8000d6:	83 c4 10             	add    $0x10,%esp
		free(y);
  8000d9:	83 ec 0c             	sub    $0xc,%esp
  8000dc:	ff 75 c8             	pushl  -0x38(%ebp)
  8000df:	e8 e0 13 00 00       	call   8014c4 <free>
  8000e4:	83 c4 10             	add    $0x10,%esp

		///		cprintf("%d\n",sys_pf_calculate_allocated_pages() - usedDiskPages);
		///assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 5 ); //4 pages + 1 table, that was not in WS

		int freePages = sys_calculate_free_frames();
  8000e7:	e8 79 16 00 00       	call   801765 <sys_calculate_free_frames>
  8000ec:	89 45 c0             	mov    %eax,-0x40(%ebp)

		x = malloc(sizeof(char)*size) ;
  8000ef:	83 ec 0c             	sub    $0xc,%esp
  8000f2:	ff 75 d0             	pushl  -0x30(%ebp)
  8000f5:	e8 a9 12 00 00       	call   8013a3 <malloc>
  8000fa:	83 c4 10             	add    $0x10,%esp
  8000fd:	89 45 cc             	mov    %eax,-0x34(%ebp)

		x[1]=-2;
  800100:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800103:	40                   	inc    %eax
  800104:	c6 00 fe             	movb   $0xfe,(%eax)

		x[5*Mega]=-2;
  800107:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80010a:	89 d0                	mov    %edx,%eax
  80010c:	c1 e0 02             	shl    $0x2,%eax
  80010f:	01 d0                	add    %edx,%eax
  800111:	89 c2                	mov    %eax,%edx
  800113:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800116:	01 d0                	add    %edx,%eax
  800118:	c6 00 fe             	movb   $0xfe,(%eax)

		x[8*Mega] = -2;
  80011b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80011e:	c1 e0 03             	shl    $0x3,%eax
  800121:	89 c2                	mov    %eax,%edx
  800123:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800126:	01 d0                	add    %edx,%eax
  800128:	c6 00 fe             	movb   $0xfe,(%eax)

		x[12*Mega]=-2;
  80012b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80012e:	89 d0                	mov    %edx,%eax
  800130:	01 c0                	add    %eax,%eax
  800132:	01 d0                	add    %edx,%eax
  800134:	c1 e0 02             	shl    $0x2,%eax
  800137:	89 c2                	mov    %eax,%edx
  800139:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	c6 00 fe             	movb   $0xfe,(%eax)

		uint32 pageWSEntries[8] = {0x802000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0x801000, 0x800000, 0xeebfd000};
  800141:	8d 45 9c             	lea    -0x64(%ebp),%eax
  800144:	bb 40 1f 80 00       	mov    $0x801f40,%ebx
  800149:	ba 08 00 00 00       	mov    $0x8,%edx
  80014e:	89 c7                	mov    %eax,%edi
  800150:	89 de                	mov    %ebx,%esi
  800152:	89 d1                	mov    %edx,%ecx
  800154:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

		int i = 0, j ;
  800156:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (; i < (myEnv->page_WS_max_size); i++)
  80015d:	eb 79                	jmp    8001d8 <_main+0x1a0>
		{
			int found = 0 ;
  80015f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  800166:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80016d:	eb 3d                	jmp    8001ac <_main+0x174>
			{
				if (pageWSEntries[i] == ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address,PAGE_SIZE) )
  80016f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800172:	8b 4c 85 9c          	mov    -0x64(%ebp,%eax,4),%ecx
  800176:	a1 20 30 80 00       	mov    0x803020,%eax
  80017b:	8b 98 34 03 00 00    	mov    0x334(%eax),%ebx
  800181:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800184:	89 d0                	mov    %edx,%eax
  800186:	01 c0                	add    %eax,%eax
  800188:	01 d0                	add    %edx,%eax
  80018a:	c1 e0 02             	shl    $0x2,%eax
  80018d:	01 d8                	add    %ebx,%eax
  80018f:	8b 00                	mov    (%eax),%eax
  800191:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800194:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800197:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019c:	39 c1                	cmp    %eax,%ecx
  80019e:	75 09                	jne    8001a9 <_main+0x171>
				{
					found = 1 ;
  8001a0:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
					break;
  8001a7:	eb 12                	jmp    8001bb <_main+0x183>

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
		{
			int found = 0 ;
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  8001a9:	ff 45 e0             	incl   -0x20(%ebp)
  8001ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b1:	8b 50 74             	mov    0x74(%eax),%edx
  8001b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001b7:	39 c2                	cmp    %eax,%edx
  8001b9:	77 b4                	ja     80016f <_main+0x137>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  8001bb:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001bf:	75 14                	jne    8001d5 <_main+0x19d>
				panic("PAGE Placement algorithm failed after applying freeHeap");
  8001c1:	83 ec 04             	sub    $0x4,%esp
  8001c4:	68 80 1e 80 00       	push   $0x801e80
  8001c9:	6a 41                	push   $0x41
  8001cb:	68 b8 1e 80 00       	push   $0x801eb8
  8001d0:	e8 56 01 00 00       	call   80032b <_panic>
		x[12*Mega]=-2;

		uint32 pageWSEntries[8] = {0x802000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0x801000, 0x800000, 0xeebfd000};

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
  8001d5:	ff 45 e4             	incl   -0x1c(%ebp)
  8001d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001dd:	8b 50 74             	mov    0x74(%eax),%edx
  8001e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001e3:	39 c2                	cmp    %eax,%edx
  8001e5:	0f 87 74 ff ff ff    	ja     80015f <_main+0x127>
			if (!found)
				panic("PAGE Placement algorithm failed after applying freeHeap");
		}


		if( (freePages - sys_calculate_free_frames() ) != 8 ) panic("Extra/Less memory are wrongly allocated");
  8001eb:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  8001ee:	e8 72 15 00 00       	call   801765 <sys_calculate_free_frames>
  8001f3:	29 c3                	sub    %eax,%ebx
  8001f5:	89 d8                	mov    %ebx,%eax
  8001f7:	83 f8 08             	cmp    $0x8,%eax
  8001fa:	74 14                	je     800210 <_main+0x1d8>
  8001fc:	83 ec 04             	sub    $0x4,%esp
  8001ff:	68 cc 1e 80 00       	push   $0x801ecc
  800204:	6a 45                	push   $0x45
  800206:	68 b8 1e 80 00       	push   $0x801eb8
  80020b:	e8 1b 01 00 00       	call   80032b <_panic>
	}

	cprintf("Congratulations!! test HEAP_PROGRAM completed successfully.\n");
  800210:	83 ec 0c             	sub    $0xc,%esp
  800213:	68 f4 1e 80 00       	push   $0x801ef4
  800218:	e8 c2 03 00 00       	call   8005df <cprintf>
  80021d:	83 c4 10             	add    $0x10,%esp


	return;
  800220:	90                   	nop
}
  800221:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800224:	5b                   	pop    %ebx
  800225:	5e                   	pop    %esi
  800226:	5f                   	pop    %edi
  800227:	5d                   	pop    %ebp
  800228:	c3                   	ret    

00800229 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800229:	55                   	push   %ebp
  80022a:	89 e5                	mov    %esp,%ebp
  80022c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80022f:	e8 66 14 00 00       	call   80169a <sys_getenvindex>
  800234:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800237:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80023a:	89 d0                	mov    %edx,%eax
  80023c:	01 c0                	add    %eax,%eax
  80023e:	01 d0                	add    %edx,%eax
  800240:	c1 e0 02             	shl    $0x2,%eax
  800243:	01 d0                	add    %edx,%eax
  800245:	c1 e0 06             	shl    $0x6,%eax
  800248:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80024d:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800252:	a1 20 30 80 00       	mov    0x803020,%eax
  800257:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80025d:	84 c0                	test   %al,%al
  80025f:	74 0f                	je     800270 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800261:	a1 20 30 80 00       	mov    0x803020,%eax
  800266:	05 f4 02 00 00       	add    $0x2f4,%eax
  80026b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800270:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800274:	7e 0a                	jle    800280 <libmain+0x57>
		binaryname = argv[0];
  800276:	8b 45 0c             	mov    0xc(%ebp),%eax
  800279:	8b 00                	mov    (%eax),%eax
  80027b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800280:	83 ec 08             	sub    $0x8,%esp
  800283:	ff 75 0c             	pushl  0xc(%ebp)
  800286:	ff 75 08             	pushl  0x8(%ebp)
  800289:	e8 aa fd ff ff       	call   800038 <_main>
  80028e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800291:	e8 9f 15 00 00       	call   801835 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800296:	83 ec 0c             	sub    $0xc,%esp
  800299:	68 78 1f 80 00       	push   $0x801f78
  80029e:	e8 3c 03 00 00       	call   8005df <cprintf>
  8002a3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ab:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8002b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b6:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8002bc:	83 ec 04             	sub    $0x4,%esp
  8002bf:	52                   	push   %edx
  8002c0:	50                   	push   %eax
  8002c1:	68 a0 1f 80 00       	push   $0x801fa0
  8002c6:	e8 14 03 00 00       	call   8005df <cprintf>
  8002cb:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d3:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8002d9:	83 ec 08             	sub    $0x8,%esp
  8002dc:	50                   	push   %eax
  8002dd:	68 c5 1f 80 00       	push   $0x801fc5
  8002e2:	e8 f8 02 00 00       	call   8005df <cprintf>
  8002e7:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002ea:	83 ec 0c             	sub    $0xc,%esp
  8002ed:	68 78 1f 80 00       	push   $0x801f78
  8002f2:	e8 e8 02 00 00       	call   8005df <cprintf>
  8002f7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002fa:	e8 50 15 00 00       	call   80184f <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002ff:	e8 19 00 00 00       	call   80031d <exit>
}
  800304:	90                   	nop
  800305:	c9                   	leave  
  800306:	c3                   	ret    

00800307 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800307:	55                   	push   %ebp
  800308:	89 e5                	mov    %esp,%ebp
  80030a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80030d:	83 ec 0c             	sub    $0xc,%esp
  800310:	6a 00                	push   $0x0
  800312:	e8 4f 13 00 00       	call   801666 <sys_env_destroy>
  800317:	83 c4 10             	add    $0x10,%esp
}
  80031a:	90                   	nop
  80031b:	c9                   	leave  
  80031c:	c3                   	ret    

0080031d <exit>:

void
exit(void)
{
  80031d:	55                   	push   %ebp
  80031e:	89 e5                	mov    %esp,%ebp
  800320:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800323:	e8 a4 13 00 00       	call   8016cc <sys_env_exit>
}
  800328:	90                   	nop
  800329:	c9                   	leave  
  80032a:	c3                   	ret    

0080032b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80032b:	55                   	push   %ebp
  80032c:	89 e5                	mov    %esp,%ebp
  80032e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800331:	8d 45 10             	lea    0x10(%ebp),%eax
  800334:	83 c0 04             	add    $0x4,%eax
  800337:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80033a:	a1 30 30 80 00       	mov    0x803030,%eax
  80033f:	85 c0                	test   %eax,%eax
  800341:	74 16                	je     800359 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800343:	a1 30 30 80 00       	mov    0x803030,%eax
  800348:	83 ec 08             	sub    $0x8,%esp
  80034b:	50                   	push   %eax
  80034c:	68 dc 1f 80 00       	push   $0x801fdc
  800351:	e8 89 02 00 00       	call   8005df <cprintf>
  800356:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800359:	a1 00 30 80 00       	mov    0x803000,%eax
  80035e:	ff 75 0c             	pushl  0xc(%ebp)
  800361:	ff 75 08             	pushl  0x8(%ebp)
  800364:	50                   	push   %eax
  800365:	68 e1 1f 80 00       	push   $0x801fe1
  80036a:	e8 70 02 00 00       	call   8005df <cprintf>
  80036f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800372:	8b 45 10             	mov    0x10(%ebp),%eax
  800375:	83 ec 08             	sub    $0x8,%esp
  800378:	ff 75 f4             	pushl  -0xc(%ebp)
  80037b:	50                   	push   %eax
  80037c:	e8 f3 01 00 00       	call   800574 <vcprintf>
  800381:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800384:	83 ec 08             	sub    $0x8,%esp
  800387:	6a 00                	push   $0x0
  800389:	68 fd 1f 80 00       	push   $0x801ffd
  80038e:	e8 e1 01 00 00       	call   800574 <vcprintf>
  800393:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800396:	e8 82 ff ff ff       	call   80031d <exit>

	// should not return here
	while (1) ;
  80039b:	eb fe                	jmp    80039b <_panic+0x70>

0080039d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80039d:	55                   	push   %ebp
  80039e:	89 e5                	mov    %esp,%ebp
  8003a0:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8003a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a8:	8b 50 74             	mov    0x74(%eax),%edx
  8003ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ae:	39 c2                	cmp    %eax,%edx
  8003b0:	74 14                	je     8003c6 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8003b2:	83 ec 04             	sub    $0x4,%esp
  8003b5:	68 00 20 80 00       	push   $0x802000
  8003ba:	6a 26                	push   $0x26
  8003bc:	68 4c 20 80 00       	push   $0x80204c
  8003c1:	e8 65 ff ff ff       	call   80032b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003cd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003d4:	e9 c2 00 00 00       	jmp    80049b <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8003d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	01 d0                	add    %edx,%eax
  8003e8:	8b 00                	mov    (%eax),%eax
  8003ea:	85 c0                	test   %eax,%eax
  8003ec:	75 08                	jne    8003f6 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003ee:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003f1:	e9 a2 00 00 00       	jmp    800498 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8003f6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003fd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800404:	eb 69                	jmp    80046f <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800406:	a1 20 30 80 00       	mov    0x803020,%eax
  80040b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800411:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800414:	89 d0                	mov    %edx,%eax
  800416:	01 c0                	add    %eax,%eax
  800418:	01 d0                	add    %edx,%eax
  80041a:	c1 e0 02             	shl    $0x2,%eax
  80041d:	01 c8                	add    %ecx,%eax
  80041f:	8a 40 04             	mov    0x4(%eax),%al
  800422:	84 c0                	test   %al,%al
  800424:	75 46                	jne    80046c <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800426:	a1 20 30 80 00       	mov    0x803020,%eax
  80042b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800431:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800434:	89 d0                	mov    %edx,%eax
  800436:	01 c0                	add    %eax,%eax
  800438:	01 d0                	add    %edx,%eax
  80043a:	c1 e0 02             	shl    $0x2,%eax
  80043d:	01 c8                	add    %ecx,%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800444:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800447:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80044c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80044e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800451:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800458:	8b 45 08             	mov    0x8(%ebp),%eax
  80045b:	01 c8                	add    %ecx,%eax
  80045d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80045f:	39 c2                	cmp    %eax,%edx
  800461:	75 09                	jne    80046c <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800463:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80046a:	eb 12                	jmp    80047e <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80046c:	ff 45 e8             	incl   -0x18(%ebp)
  80046f:	a1 20 30 80 00       	mov    0x803020,%eax
  800474:	8b 50 74             	mov    0x74(%eax),%edx
  800477:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80047a:	39 c2                	cmp    %eax,%edx
  80047c:	77 88                	ja     800406 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80047e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800482:	75 14                	jne    800498 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800484:	83 ec 04             	sub    $0x4,%esp
  800487:	68 58 20 80 00       	push   $0x802058
  80048c:	6a 3a                	push   $0x3a
  80048e:	68 4c 20 80 00       	push   $0x80204c
  800493:	e8 93 fe ff ff       	call   80032b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800498:	ff 45 f0             	incl   -0x10(%ebp)
  80049b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80049e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004a1:	0f 8c 32 ff ff ff    	jl     8003d9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8004a7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004ae:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004b5:	eb 26                	jmp    8004dd <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8004b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8004bc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004c2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004c5:	89 d0                	mov    %edx,%eax
  8004c7:	01 c0                	add    %eax,%eax
  8004c9:	01 d0                	add    %edx,%eax
  8004cb:	c1 e0 02             	shl    $0x2,%eax
  8004ce:	01 c8                	add    %ecx,%eax
  8004d0:	8a 40 04             	mov    0x4(%eax),%al
  8004d3:	3c 01                	cmp    $0x1,%al
  8004d5:	75 03                	jne    8004da <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8004d7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004da:	ff 45 e0             	incl   -0x20(%ebp)
  8004dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8004e2:	8b 50 74             	mov    0x74(%eax),%edx
  8004e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004e8:	39 c2                	cmp    %eax,%edx
  8004ea:	77 cb                	ja     8004b7 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004ef:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004f2:	74 14                	je     800508 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8004f4:	83 ec 04             	sub    $0x4,%esp
  8004f7:	68 ac 20 80 00       	push   $0x8020ac
  8004fc:	6a 44                	push   $0x44
  8004fe:	68 4c 20 80 00       	push   $0x80204c
  800503:	e8 23 fe ff ff       	call   80032b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800508:	90                   	nop
  800509:	c9                   	leave  
  80050a:	c3                   	ret    

0080050b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80050b:	55                   	push   %ebp
  80050c:	89 e5                	mov    %esp,%ebp
  80050e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800511:	8b 45 0c             	mov    0xc(%ebp),%eax
  800514:	8b 00                	mov    (%eax),%eax
  800516:	8d 48 01             	lea    0x1(%eax),%ecx
  800519:	8b 55 0c             	mov    0xc(%ebp),%edx
  80051c:	89 0a                	mov    %ecx,(%edx)
  80051e:	8b 55 08             	mov    0x8(%ebp),%edx
  800521:	88 d1                	mov    %dl,%cl
  800523:	8b 55 0c             	mov    0xc(%ebp),%edx
  800526:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80052a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052d:	8b 00                	mov    (%eax),%eax
  80052f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800534:	75 2c                	jne    800562 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800536:	a0 24 30 80 00       	mov    0x803024,%al
  80053b:	0f b6 c0             	movzbl %al,%eax
  80053e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800541:	8b 12                	mov    (%edx),%edx
  800543:	89 d1                	mov    %edx,%ecx
  800545:	8b 55 0c             	mov    0xc(%ebp),%edx
  800548:	83 c2 08             	add    $0x8,%edx
  80054b:	83 ec 04             	sub    $0x4,%esp
  80054e:	50                   	push   %eax
  80054f:	51                   	push   %ecx
  800550:	52                   	push   %edx
  800551:	e8 ce 10 00 00       	call   801624 <sys_cputs>
  800556:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800559:	8b 45 0c             	mov    0xc(%ebp),%eax
  80055c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800562:	8b 45 0c             	mov    0xc(%ebp),%eax
  800565:	8b 40 04             	mov    0x4(%eax),%eax
  800568:	8d 50 01             	lea    0x1(%eax),%edx
  80056b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80056e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800571:	90                   	nop
  800572:	c9                   	leave  
  800573:	c3                   	ret    

00800574 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800574:	55                   	push   %ebp
  800575:	89 e5                	mov    %esp,%ebp
  800577:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80057d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800584:	00 00 00 
	b.cnt = 0;
  800587:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80058e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800591:	ff 75 0c             	pushl  0xc(%ebp)
  800594:	ff 75 08             	pushl  0x8(%ebp)
  800597:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80059d:	50                   	push   %eax
  80059e:	68 0b 05 80 00       	push   $0x80050b
  8005a3:	e8 11 02 00 00       	call   8007b9 <vprintfmt>
  8005a8:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8005ab:	a0 24 30 80 00       	mov    0x803024,%al
  8005b0:	0f b6 c0             	movzbl %al,%eax
  8005b3:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005b9:	83 ec 04             	sub    $0x4,%esp
  8005bc:	50                   	push   %eax
  8005bd:	52                   	push   %edx
  8005be:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005c4:	83 c0 08             	add    $0x8,%eax
  8005c7:	50                   	push   %eax
  8005c8:	e8 57 10 00 00       	call   801624 <sys_cputs>
  8005cd:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005d0:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8005d7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005dd:	c9                   	leave  
  8005de:	c3                   	ret    

008005df <cprintf>:

int cprintf(const char *fmt, ...) {
  8005df:	55                   	push   %ebp
  8005e0:	89 e5                	mov    %esp,%ebp
  8005e2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005e5:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005ec:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f5:	83 ec 08             	sub    $0x8,%esp
  8005f8:	ff 75 f4             	pushl  -0xc(%ebp)
  8005fb:	50                   	push   %eax
  8005fc:	e8 73 ff ff ff       	call   800574 <vcprintf>
  800601:	83 c4 10             	add    $0x10,%esp
  800604:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800607:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80060a:	c9                   	leave  
  80060b:	c3                   	ret    

0080060c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80060c:	55                   	push   %ebp
  80060d:	89 e5                	mov    %esp,%ebp
  80060f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800612:	e8 1e 12 00 00       	call   801835 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800617:	8d 45 0c             	lea    0xc(%ebp),%eax
  80061a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80061d:	8b 45 08             	mov    0x8(%ebp),%eax
  800620:	83 ec 08             	sub    $0x8,%esp
  800623:	ff 75 f4             	pushl  -0xc(%ebp)
  800626:	50                   	push   %eax
  800627:	e8 48 ff ff ff       	call   800574 <vcprintf>
  80062c:	83 c4 10             	add    $0x10,%esp
  80062f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800632:	e8 18 12 00 00       	call   80184f <sys_enable_interrupt>
	return cnt;
  800637:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80063a:	c9                   	leave  
  80063b:	c3                   	ret    

0080063c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80063c:	55                   	push   %ebp
  80063d:	89 e5                	mov    %esp,%ebp
  80063f:	53                   	push   %ebx
  800640:	83 ec 14             	sub    $0x14,%esp
  800643:	8b 45 10             	mov    0x10(%ebp),%eax
  800646:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800649:	8b 45 14             	mov    0x14(%ebp),%eax
  80064c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80064f:	8b 45 18             	mov    0x18(%ebp),%eax
  800652:	ba 00 00 00 00       	mov    $0x0,%edx
  800657:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80065a:	77 55                	ja     8006b1 <printnum+0x75>
  80065c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80065f:	72 05                	jb     800666 <printnum+0x2a>
  800661:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800664:	77 4b                	ja     8006b1 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800666:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800669:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80066c:	8b 45 18             	mov    0x18(%ebp),%eax
  80066f:	ba 00 00 00 00       	mov    $0x0,%edx
  800674:	52                   	push   %edx
  800675:	50                   	push   %eax
  800676:	ff 75 f4             	pushl  -0xc(%ebp)
  800679:	ff 75 f0             	pushl  -0x10(%ebp)
  80067c:	e8 93 15 00 00       	call   801c14 <__udivdi3>
  800681:	83 c4 10             	add    $0x10,%esp
  800684:	83 ec 04             	sub    $0x4,%esp
  800687:	ff 75 20             	pushl  0x20(%ebp)
  80068a:	53                   	push   %ebx
  80068b:	ff 75 18             	pushl  0x18(%ebp)
  80068e:	52                   	push   %edx
  80068f:	50                   	push   %eax
  800690:	ff 75 0c             	pushl  0xc(%ebp)
  800693:	ff 75 08             	pushl  0x8(%ebp)
  800696:	e8 a1 ff ff ff       	call   80063c <printnum>
  80069b:	83 c4 20             	add    $0x20,%esp
  80069e:	eb 1a                	jmp    8006ba <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006a0:	83 ec 08             	sub    $0x8,%esp
  8006a3:	ff 75 0c             	pushl  0xc(%ebp)
  8006a6:	ff 75 20             	pushl  0x20(%ebp)
  8006a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ac:	ff d0                	call   *%eax
  8006ae:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006b1:	ff 4d 1c             	decl   0x1c(%ebp)
  8006b4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006b8:	7f e6                	jg     8006a0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006ba:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006bd:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006c8:	53                   	push   %ebx
  8006c9:	51                   	push   %ecx
  8006ca:	52                   	push   %edx
  8006cb:	50                   	push   %eax
  8006cc:	e8 53 16 00 00       	call   801d24 <__umoddi3>
  8006d1:	83 c4 10             	add    $0x10,%esp
  8006d4:	05 14 23 80 00       	add    $0x802314,%eax
  8006d9:	8a 00                	mov    (%eax),%al
  8006db:	0f be c0             	movsbl %al,%eax
  8006de:	83 ec 08             	sub    $0x8,%esp
  8006e1:	ff 75 0c             	pushl  0xc(%ebp)
  8006e4:	50                   	push   %eax
  8006e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e8:	ff d0                	call   *%eax
  8006ea:	83 c4 10             	add    $0x10,%esp
}
  8006ed:	90                   	nop
  8006ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006f1:	c9                   	leave  
  8006f2:	c3                   	ret    

008006f3 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006f3:	55                   	push   %ebp
  8006f4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006f6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006fa:	7e 1c                	jle    800718 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ff:	8b 00                	mov    (%eax),%eax
  800701:	8d 50 08             	lea    0x8(%eax),%edx
  800704:	8b 45 08             	mov    0x8(%ebp),%eax
  800707:	89 10                	mov    %edx,(%eax)
  800709:	8b 45 08             	mov    0x8(%ebp),%eax
  80070c:	8b 00                	mov    (%eax),%eax
  80070e:	83 e8 08             	sub    $0x8,%eax
  800711:	8b 50 04             	mov    0x4(%eax),%edx
  800714:	8b 00                	mov    (%eax),%eax
  800716:	eb 40                	jmp    800758 <getuint+0x65>
	else if (lflag)
  800718:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80071c:	74 1e                	je     80073c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80071e:	8b 45 08             	mov    0x8(%ebp),%eax
  800721:	8b 00                	mov    (%eax),%eax
  800723:	8d 50 04             	lea    0x4(%eax),%edx
  800726:	8b 45 08             	mov    0x8(%ebp),%eax
  800729:	89 10                	mov    %edx,(%eax)
  80072b:	8b 45 08             	mov    0x8(%ebp),%eax
  80072e:	8b 00                	mov    (%eax),%eax
  800730:	83 e8 04             	sub    $0x4,%eax
  800733:	8b 00                	mov    (%eax),%eax
  800735:	ba 00 00 00 00       	mov    $0x0,%edx
  80073a:	eb 1c                	jmp    800758 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80073c:	8b 45 08             	mov    0x8(%ebp),%eax
  80073f:	8b 00                	mov    (%eax),%eax
  800741:	8d 50 04             	lea    0x4(%eax),%edx
  800744:	8b 45 08             	mov    0x8(%ebp),%eax
  800747:	89 10                	mov    %edx,(%eax)
  800749:	8b 45 08             	mov    0x8(%ebp),%eax
  80074c:	8b 00                	mov    (%eax),%eax
  80074e:	83 e8 04             	sub    $0x4,%eax
  800751:	8b 00                	mov    (%eax),%eax
  800753:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800758:	5d                   	pop    %ebp
  800759:	c3                   	ret    

0080075a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80075a:	55                   	push   %ebp
  80075b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80075d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800761:	7e 1c                	jle    80077f <getint+0x25>
		return va_arg(*ap, long long);
  800763:	8b 45 08             	mov    0x8(%ebp),%eax
  800766:	8b 00                	mov    (%eax),%eax
  800768:	8d 50 08             	lea    0x8(%eax),%edx
  80076b:	8b 45 08             	mov    0x8(%ebp),%eax
  80076e:	89 10                	mov    %edx,(%eax)
  800770:	8b 45 08             	mov    0x8(%ebp),%eax
  800773:	8b 00                	mov    (%eax),%eax
  800775:	83 e8 08             	sub    $0x8,%eax
  800778:	8b 50 04             	mov    0x4(%eax),%edx
  80077b:	8b 00                	mov    (%eax),%eax
  80077d:	eb 38                	jmp    8007b7 <getint+0x5d>
	else if (lflag)
  80077f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800783:	74 1a                	je     80079f <getint+0x45>
		return va_arg(*ap, long);
  800785:	8b 45 08             	mov    0x8(%ebp),%eax
  800788:	8b 00                	mov    (%eax),%eax
  80078a:	8d 50 04             	lea    0x4(%eax),%edx
  80078d:	8b 45 08             	mov    0x8(%ebp),%eax
  800790:	89 10                	mov    %edx,(%eax)
  800792:	8b 45 08             	mov    0x8(%ebp),%eax
  800795:	8b 00                	mov    (%eax),%eax
  800797:	83 e8 04             	sub    $0x4,%eax
  80079a:	8b 00                	mov    (%eax),%eax
  80079c:	99                   	cltd   
  80079d:	eb 18                	jmp    8007b7 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80079f:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a2:	8b 00                	mov    (%eax),%eax
  8007a4:	8d 50 04             	lea    0x4(%eax),%edx
  8007a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007aa:	89 10                	mov    %edx,(%eax)
  8007ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8007af:	8b 00                	mov    (%eax),%eax
  8007b1:	83 e8 04             	sub    $0x4,%eax
  8007b4:	8b 00                	mov    (%eax),%eax
  8007b6:	99                   	cltd   
}
  8007b7:	5d                   	pop    %ebp
  8007b8:	c3                   	ret    

008007b9 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007b9:	55                   	push   %ebp
  8007ba:	89 e5                	mov    %esp,%ebp
  8007bc:	56                   	push   %esi
  8007bd:	53                   	push   %ebx
  8007be:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007c1:	eb 17                	jmp    8007da <vprintfmt+0x21>
			if (ch == '\0')
  8007c3:	85 db                	test   %ebx,%ebx
  8007c5:	0f 84 af 03 00 00    	je     800b7a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007cb:	83 ec 08             	sub    $0x8,%esp
  8007ce:	ff 75 0c             	pushl  0xc(%ebp)
  8007d1:	53                   	push   %ebx
  8007d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d5:	ff d0                	call   *%eax
  8007d7:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007da:	8b 45 10             	mov    0x10(%ebp),%eax
  8007dd:	8d 50 01             	lea    0x1(%eax),%edx
  8007e0:	89 55 10             	mov    %edx,0x10(%ebp)
  8007e3:	8a 00                	mov    (%eax),%al
  8007e5:	0f b6 d8             	movzbl %al,%ebx
  8007e8:	83 fb 25             	cmp    $0x25,%ebx
  8007eb:	75 d6                	jne    8007c3 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007ed:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007f1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007f8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007ff:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800806:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80080d:	8b 45 10             	mov    0x10(%ebp),%eax
  800810:	8d 50 01             	lea    0x1(%eax),%edx
  800813:	89 55 10             	mov    %edx,0x10(%ebp)
  800816:	8a 00                	mov    (%eax),%al
  800818:	0f b6 d8             	movzbl %al,%ebx
  80081b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80081e:	83 f8 55             	cmp    $0x55,%eax
  800821:	0f 87 2b 03 00 00    	ja     800b52 <vprintfmt+0x399>
  800827:	8b 04 85 38 23 80 00 	mov    0x802338(,%eax,4),%eax
  80082e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800830:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800834:	eb d7                	jmp    80080d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800836:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80083a:	eb d1                	jmp    80080d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80083c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800843:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800846:	89 d0                	mov    %edx,%eax
  800848:	c1 e0 02             	shl    $0x2,%eax
  80084b:	01 d0                	add    %edx,%eax
  80084d:	01 c0                	add    %eax,%eax
  80084f:	01 d8                	add    %ebx,%eax
  800851:	83 e8 30             	sub    $0x30,%eax
  800854:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800857:	8b 45 10             	mov    0x10(%ebp),%eax
  80085a:	8a 00                	mov    (%eax),%al
  80085c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80085f:	83 fb 2f             	cmp    $0x2f,%ebx
  800862:	7e 3e                	jle    8008a2 <vprintfmt+0xe9>
  800864:	83 fb 39             	cmp    $0x39,%ebx
  800867:	7f 39                	jg     8008a2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800869:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80086c:	eb d5                	jmp    800843 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80086e:	8b 45 14             	mov    0x14(%ebp),%eax
  800871:	83 c0 04             	add    $0x4,%eax
  800874:	89 45 14             	mov    %eax,0x14(%ebp)
  800877:	8b 45 14             	mov    0x14(%ebp),%eax
  80087a:	83 e8 04             	sub    $0x4,%eax
  80087d:	8b 00                	mov    (%eax),%eax
  80087f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800882:	eb 1f                	jmp    8008a3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800884:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800888:	79 83                	jns    80080d <vprintfmt+0x54>
				width = 0;
  80088a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800891:	e9 77 ff ff ff       	jmp    80080d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800896:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80089d:	e9 6b ff ff ff       	jmp    80080d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008a2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008a3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008a7:	0f 89 60 ff ff ff    	jns    80080d <vprintfmt+0x54>
				width = precision, precision = -1;
  8008ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008b3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008ba:	e9 4e ff ff ff       	jmp    80080d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008bf:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008c2:	e9 46 ff ff ff       	jmp    80080d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ca:	83 c0 04             	add    $0x4,%eax
  8008cd:	89 45 14             	mov    %eax,0x14(%ebp)
  8008d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d3:	83 e8 04             	sub    $0x4,%eax
  8008d6:	8b 00                	mov    (%eax),%eax
  8008d8:	83 ec 08             	sub    $0x8,%esp
  8008db:	ff 75 0c             	pushl  0xc(%ebp)
  8008de:	50                   	push   %eax
  8008df:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e2:	ff d0                	call   *%eax
  8008e4:	83 c4 10             	add    $0x10,%esp
			break;
  8008e7:	e9 89 02 00 00       	jmp    800b75 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ef:	83 c0 04             	add    $0x4,%eax
  8008f2:	89 45 14             	mov    %eax,0x14(%ebp)
  8008f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f8:	83 e8 04             	sub    $0x4,%eax
  8008fb:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008fd:	85 db                	test   %ebx,%ebx
  8008ff:	79 02                	jns    800903 <vprintfmt+0x14a>
				err = -err;
  800901:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800903:	83 fb 64             	cmp    $0x64,%ebx
  800906:	7f 0b                	jg     800913 <vprintfmt+0x15a>
  800908:	8b 34 9d 80 21 80 00 	mov    0x802180(,%ebx,4),%esi
  80090f:	85 f6                	test   %esi,%esi
  800911:	75 19                	jne    80092c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800913:	53                   	push   %ebx
  800914:	68 25 23 80 00       	push   $0x802325
  800919:	ff 75 0c             	pushl  0xc(%ebp)
  80091c:	ff 75 08             	pushl  0x8(%ebp)
  80091f:	e8 5e 02 00 00       	call   800b82 <printfmt>
  800924:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800927:	e9 49 02 00 00       	jmp    800b75 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80092c:	56                   	push   %esi
  80092d:	68 2e 23 80 00       	push   $0x80232e
  800932:	ff 75 0c             	pushl  0xc(%ebp)
  800935:	ff 75 08             	pushl  0x8(%ebp)
  800938:	e8 45 02 00 00       	call   800b82 <printfmt>
  80093d:	83 c4 10             	add    $0x10,%esp
			break;
  800940:	e9 30 02 00 00       	jmp    800b75 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800945:	8b 45 14             	mov    0x14(%ebp),%eax
  800948:	83 c0 04             	add    $0x4,%eax
  80094b:	89 45 14             	mov    %eax,0x14(%ebp)
  80094e:	8b 45 14             	mov    0x14(%ebp),%eax
  800951:	83 e8 04             	sub    $0x4,%eax
  800954:	8b 30                	mov    (%eax),%esi
  800956:	85 f6                	test   %esi,%esi
  800958:	75 05                	jne    80095f <vprintfmt+0x1a6>
				p = "(null)";
  80095a:	be 31 23 80 00       	mov    $0x802331,%esi
			if (width > 0 && padc != '-')
  80095f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800963:	7e 6d                	jle    8009d2 <vprintfmt+0x219>
  800965:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800969:	74 67                	je     8009d2 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80096b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80096e:	83 ec 08             	sub    $0x8,%esp
  800971:	50                   	push   %eax
  800972:	56                   	push   %esi
  800973:	e8 0c 03 00 00       	call   800c84 <strnlen>
  800978:	83 c4 10             	add    $0x10,%esp
  80097b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80097e:	eb 16                	jmp    800996 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800980:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800984:	83 ec 08             	sub    $0x8,%esp
  800987:	ff 75 0c             	pushl  0xc(%ebp)
  80098a:	50                   	push   %eax
  80098b:	8b 45 08             	mov    0x8(%ebp),%eax
  80098e:	ff d0                	call   *%eax
  800990:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800993:	ff 4d e4             	decl   -0x1c(%ebp)
  800996:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80099a:	7f e4                	jg     800980 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80099c:	eb 34                	jmp    8009d2 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80099e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009a2:	74 1c                	je     8009c0 <vprintfmt+0x207>
  8009a4:	83 fb 1f             	cmp    $0x1f,%ebx
  8009a7:	7e 05                	jle    8009ae <vprintfmt+0x1f5>
  8009a9:	83 fb 7e             	cmp    $0x7e,%ebx
  8009ac:	7e 12                	jle    8009c0 <vprintfmt+0x207>
					putch('?', putdat);
  8009ae:	83 ec 08             	sub    $0x8,%esp
  8009b1:	ff 75 0c             	pushl  0xc(%ebp)
  8009b4:	6a 3f                	push   $0x3f
  8009b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b9:	ff d0                	call   *%eax
  8009bb:	83 c4 10             	add    $0x10,%esp
  8009be:	eb 0f                	jmp    8009cf <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009c0:	83 ec 08             	sub    $0x8,%esp
  8009c3:	ff 75 0c             	pushl  0xc(%ebp)
  8009c6:	53                   	push   %ebx
  8009c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ca:	ff d0                	call   *%eax
  8009cc:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009cf:	ff 4d e4             	decl   -0x1c(%ebp)
  8009d2:	89 f0                	mov    %esi,%eax
  8009d4:	8d 70 01             	lea    0x1(%eax),%esi
  8009d7:	8a 00                	mov    (%eax),%al
  8009d9:	0f be d8             	movsbl %al,%ebx
  8009dc:	85 db                	test   %ebx,%ebx
  8009de:	74 24                	je     800a04 <vprintfmt+0x24b>
  8009e0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009e4:	78 b8                	js     80099e <vprintfmt+0x1e5>
  8009e6:	ff 4d e0             	decl   -0x20(%ebp)
  8009e9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009ed:	79 af                	jns    80099e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009ef:	eb 13                	jmp    800a04 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009f1:	83 ec 08             	sub    $0x8,%esp
  8009f4:	ff 75 0c             	pushl  0xc(%ebp)
  8009f7:	6a 20                	push   $0x20
  8009f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fc:	ff d0                	call   *%eax
  8009fe:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a01:	ff 4d e4             	decl   -0x1c(%ebp)
  800a04:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a08:	7f e7                	jg     8009f1 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a0a:	e9 66 01 00 00       	jmp    800b75 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a0f:	83 ec 08             	sub    $0x8,%esp
  800a12:	ff 75 e8             	pushl  -0x18(%ebp)
  800a15:	8d 45 14             	lea    0x14(%ebp),%eax
  800a18:	50                   	push   %eax
  800a19:	e8 3c fd ff ff       	call   80075a <getint>
  800a1e:	83 c4 10             	add    $0x10,%esp
  800a21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a24:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a2d:	85 d2                	test   %edx,%edx
  800a2f:	79 23                	jns    800a54 <vprintfmt+0x29b>
				putch('-', putdat);
  800a31:	83 ec 08             	sub    $0x8,%esp
  800a34:	ff 75 0c             	pushl  0xc(%ebp)
  800a37:	6a 2d                	push   $0x2d
  800a39:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3c:	ff d0                	call   *%eax
  800a3e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a41:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a44:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a47:	f7 d8                	neg    %eax
  800a49:	83 d2 00             	adc    $0x0,%edx
  800a4c:	f7 da                	neg    %edx
  800a4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a51:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a54:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a5b:	e9 bc 00 00 00       	jmp    800b1c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a60:	83 ec 08             	sub    $0x8,%esp
  800a63:	ff 75 e8             	pushl  -0x18(%ebp)
  800a66:	8d 45 14             	lea    0x14(%ebp),%eax
  800a69:	50                   	push   %eax
  800a6a:	e8 84 fc ff ff       	call   8006f3 <getuint>
  800a6f:	83 c4 10             	add    $0x10,%esp
  800a72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a75:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a78:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a7f:	e9 98 00 00 00       	jmp    800b1c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a84:	83 ec 08             	sub    $0x8,%esp
  800a87:	ff 75 0c             	pushl  0xc(%ebp)
  800a8a:	6a 58                	push   $0x58
  800a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8f:	ff d0                	call   *%eax
  800a91:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a94:	83 ec 08             	sub    $0x8,%esp
  800a97:	ff 75 0c             	pushl  0xc(%ebp)
  800a9a:	6a 58                	push   $0x58
  800a9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9f:	ff d0                	call   *%eax
  800aa1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800aa4:	83 ec 08             	sub    $0x8,%esp
  800aa7:	ff 75 0c             	pushl  0xc(%ebp)
  800aaa:	6a 58                	push   $0x58
  800aac:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaf:	ff d0                	call   *%eax
  800ab1:	83 c4 10             	add    $0x10,%esp
			break;
  800ab4:	e9 bc 00 00 00       	jmp    800b75 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ab9:	83 ec 08             	sub    $0x8,%esp
  800abc:	ff 75 0c             	pushl  0xc(%ebp)
  800abf:	6a 30                	push   $0x30
  800ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac4:	ff d0                	call   *%eax
  800ac6:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ac9:	83 ec 08             	sub    $0x8,%esp
  800acc:	ff 75 0c             	pushl  0xc(%ebp)
  800acf:	6a 78                	push   $0x78
  800ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad4:	ff d0                	call   *%eax
  800ad6:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ad9:	8b 45 14             	mov    0x14(%ebp),%eax
  800adc:	83 c0 04             	add    $0x4,%eax
  800adf:	89 45 14             	mov    %eax,0x14(%ebp)
  800ae2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae5:	83 e8 04             	sub    $0x4,%eax
  800ae8:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800aea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800af4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800afb:	eb 1f                	jmp    800b1c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800afd:	83 ec 08             	sub    $0x8,%esp
  800b00:	ff 75 e8             	pushl  -0x18(%ebp)
  800b03:	8d 45 14             	lea    0x14(%ebp),%eax
  800b06:	50                   	push   %eax
  800b07:	e8 e7 fb ff ff       	call   8006f3 <getuint>
  800b0c:	83 c4 10             	add    $0x10,%esp
  800b0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b12:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b15:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b1c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b20:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b23:	83 ec 04             	sub    $0x4,%esp
  800b26:	52                   	push   %edx
  800b27:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b2a:	50                   	push   %eax
  800b2b:	ff 75 f4             	pushl  -0xc(%ebp)
  800b2e:	ff 75 f0             	pushl  -0x10(%ebp)
  800b31:	ff 75 0c             	pushl  0xc(%ebp)
  800b34:	ff 75 08             	pushl  0x8(%ebp)
  800b37:	e8 00 fb ff ff       	call   80063c <printnum>
  800b3c:	83 c4 20             	add    $0x20,%esp
			break;
  800b3f:	eb 34                	jmp    800b75 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b41:	83 ec 08             	sub    $0x8,%esp
  800b44:	ff 75 0c             	pushl  0xc(%ebp)
  800b47:	53                   	push   %ebx
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	ff d0                	call   *%eax
  800b4d:	83 c4 10             	add    $0x10,%esp
			break;
  800b50:	eb 23                	jmp    800b75 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b52:	83 ec 08             	sub    $0x8,%esp
  800b55:	ff 75 0c             	pushl  0xc(%ebp)
  800b58:	6a 25                	push   $0x25
  800b5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5d:	ff d0                	call   *%eax
  800b5f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b62:	ff 4d 10             	decl   0x10(%ebp)
  800b65:	eb 03                	jmp    800b6a <vprintfmt+0x3b1>
  800b67:	ff 4d 10             	decl   0x10(%ebp)
  800b6a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b6d:	48                   	dec    %eax
  800b6e:	8a 00                	mov    (%eax),%al
  800b70:	3c 25                	cmp    $0x25,%al
  800b72:	75 f3                	jne    800b67 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b74:	90                   	nop
		}
	}
  800b75:	e9 47 fc ff ff       	jmp    8007c1 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b7a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b7b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b7e:	5b                   	pop    %ebx
  800b7f:	5e                   	pop    %esi
  800b80:	5d                   	pop    %ebp
  800b81:	c3                   	ret    

00800b82 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b82:	55                   	push   %ebp
  800b83:	89 e5                	mov    %esp,%ebp
  800b85:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b88:	8d 45 10             	lea    0x10(%ebp),%eax
  800b8b:	83 c0 04             	add    $0x4,%eax
  800b8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b91:	8b 45 10             	mov    0x10(%ebp),%eax
  800b94:	ff 75 f4             	pushl  -0xc(%ebp)
  800b97:	50                   	push   %eax
  800b98:	ff 75 0c             	pushl  0xc(%ebp)
  800b9b:	ff 75 08             	pushl  0x8(%ebp)
  800b9e:	e8 16 fc ff ff       	call   8007b9 <vprintfmt>
  800ba3:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ba6:	90                   	nop
  800ba7:	c9                   	leave  
  800ba8:	c3                   	ret    

00800ba9 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ba9:	55                   	push   %ebp
  800baa:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800baf:	8b 40 08             	mov    0x8(%eax),%eax
  800bb2:	8d 50 01             	lea    0x1(%eax),%edx
  800bb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb8:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800bbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbe:	8b 10                	mov    (%eax),%edx
  800bc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc3:	8b 40 04             	mov    0x4(%eax),%eax
  800bc6:	39 c2                	cmp    %eax,%edx
  800bc8:	73 12                	jae    800bdc <sprintputch+0x33>
		*b->buf++ = ch;
  800bca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bcd:	8b 00                	mov    (%eax),%eax
  800bcf:	8d 48 01             	lea    0x1(%eax),%ecx
  800bd2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bd5:	89 0a                	mov    %ecx,(%edx)
  800bd7:	8b 55 08             	mov    0x8(%ebp),%edx
  800bda:	88 10                	mov    %dl,(%eax)
}
  800bdc:	90                   	nop
  800bdd:	5d                   	pop    %ebp
  800bde:	c3                   	ret    

00800bdf <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bdf:	55                   	push   %ebp
  800be0:	89 e5                	mov    %esp,%ebp
  800be2:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800be5:	8b 45 08             	mov    0x8(%ebp),%eax
  800be8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800beb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bee:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf4:	01 d0                	add    %edx,%eax
  800bf6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c00:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c04:	74 06                	je     800c0c <vsnprintf+0x2d>
  800c06:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c0a:	7f 07                	jg     800c13 <vsnprintf+0x34>
		return -E_INVAL;
  800c0c:	b8 03 00 00 00       	mov    $0x3,%eax
  800c11:	eb 20                	jmp    800c33 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c13:	ff 75 14             	pushl  0x14(%ebp)
  800c16:	ff 75 10             	pushl  0x10(%ebp)
  800c19:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c1c:	50                   	push   %eax
  800c1d:	68 a9 0b 80 00       	push   $0x800ba9
  800c22:	e8 92 fb ff ff       	call   8007b9 <vprintfmt>
  800c27:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c2a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c2d:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c30:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c33:	c9                   	leave  
  800c34:	c3                   	ret    

00800c35 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c35:	55                   	push   %ebp
  800c36:	89 e5                	mov    %esp,%ebp
  800c38:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c3b:	8d 45 10             	lea    0x10(%ebp),%eax
  800c3e:	83 c0 04             	add    $0x4,%eax
  800c41:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c44:	8b 45 10             	mov    0x10(%ebp),%eax
  800c47:	ff 75 f4             	pushl  -0xc(%ebp)
  800c4a:	50                   	push   %eax
  800c4b:	ff 75 0c             	pushl  0xc(%ebp)
  800c4e:	ff 75 08             	pushl  0x8(%ebp)
  800c51:	e8 89 ff ff ff       	call   800bdf <vsnprintf>
  800c56:	83 c4 10             	add    $0x10,%esp
  800c59:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c5f:	c9                   	leave  
  800c60:	c3                   	ret    

00800c61 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c61:	55                   	push   %ebp
  800c62:	89 e5                	mov    %esp,%ebp
  800c64:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c67:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c6e:	eb 06                	jmp    800c76 <strlen+0x15>
		n++;
  800c70:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c73:	ff 45 08             	incl   0x8(%ebp)
  800c76:	8b 45 08             	mov    0x8(%ebp),%eax
  800c79:	8a 00                	mov    (%eax),%al
  800c7b:	84 c0                	test   %al,%al
  800c7d:	75 f1                	jne    800c70 <strlen+0xf>
		n++;
	return n;
  800c7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c82:	c9                   	leave  
  800c83:	c3                   	ret    

00800c84 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c84:	55                   	push   %ebp
  800c85:	89 e5                	mov    %esp,%ebp
  800c87:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c8a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c91:	eb 09                	jmp    800c9c <strnlen+0x18>
		n++;
  800c93:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c96:	ff 45 08             	incl   0x8(%ebp)
  800c99:	ff 4d 0c             	decl   0xc(%ebp)
  800c9c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ca0:	74 09                	je     800cab <strnlen+0x27>
  800ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca5:	8a 00                	mov    (%eax),%al
  800ca7:	84 c0                	test   %al,%al
  800ca9:	75 e8                	jne    800c93 <strnlen+0xf>
		n++;
	return n;
  800cab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cae:	c9                   	leave  
  800caf:	c3                   	ret    

00800cb0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800cb0:	55                   	push   %ebp
  800cb1:	89 e5                	mov    %esp,%ebp
  800cb3:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800cbc:	90                   	nop
  800cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc0:	8d 50 01             	lea    0x1(%eax),%edx
  800cc3:	89 55 08             	mov    %edx,0x8(%ebp)
  800cc6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cc9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ccc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ccf:	8a 12                	mov    (%edx),%dl
  800cd1:	88 10                	mov    %dl,(%eax)
  800cd3:	8a 00                	mov    (%eax),%al
  800cd5:	84 c0                	test   %al,%al
  800cd7:	75 e4                	jne    800cbd <strcpy+0xd>
		/* do nothing */;
	return ret;
  800cd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cdc:	c9                   	leave  
  800cdd:	c3                   	ret    

00800cde <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800cde:	55                   	push   %ebp
  800cdf:	89 e5                	mov    %esp,%ebp
  800ce1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800cea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cf1:	eb 1f                	jmp    800d12 <strncpy+0x34>
		*dst++ = *src;
  800cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf6:	8d 50 01             	lea    0x1(%eax),%edx
  800cf9:	89 55 08             	mov    %edx,0x8(%ebp)
  800cfc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cff:	8a 12                	mov    (%edx),%dl
  800d01:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d06:	8a 00                	mov    (%eax),%al
  800d08:	84 c0                	test   %al,%al
  800d0a:	74 03                	je     800d0f <strncpy+0x31>
			src++;
  800d0c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d0f:	ff 45 fc             	incl   -0x4(%ebp)
  800d12:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d15:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d18:	72 d9                	jb     800cf3 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d1a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d1d:	c9                   	leave  
  800d1e:	c3                   	ret    

00800d1f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d1f:	55                   	push   %ebp
  800d20:	89 e5                	mov    %esp,%ebp
  800d22:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d2b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d2f:	74 30                	je     800d61 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d31:	eb 16                	jmp    800d49 <strlcpy+0x2a>
			*dst++ = *src++;
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	8d 50 01             	lea    0x1(%eax),%edx
  800d39:	89 55 08             	mov    %edx,0x8(%ebp)
  800d3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d3f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d42:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d45:	8a 12                	mov    (%edx),%dl
  800d47:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d49:	ff 4d 10             	decl   0x10(%ebp)
  800d4c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d50:	74 09                	je     800d5b <strlcpy+0x3c>
  800d52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d55:	8a 00                	mov    (%eax),%al
  800d57:	84 c0                	test   %al,%al
  800d59:	75 d8                	jne    800d33 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d61:	8b 55 08             	mov    0x8(%ebp),%edx
  800d64:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d67:	29 c2                	sub    %eax,%edx
  800d69:	89 d0                	mov    %edx,%eax
}
  800d6b:	c9                   	leave  
  800d6c:	c3                   	ret    

00800d6d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d6d:	55                   	push   %ebp
  800d6e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d70:	eb 06                	jmp    800d78 <strcmp+0xb>
		p++, q++;
  800d72:	ff 45 08             	incl   0x8(%ebp)
  800d75:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	8a 00                	mov    (%eax),%al
  800d7d:	84 c0                	test   %al,%al
  800d7f:	74 0e                	je     800d8f <strcmp+0x22>
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
  800d84:	8a 10                	mov    (%eax),%dl
  800d86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d89:	8a 00                	mov    (%eax),%al
  800d8b:	38 c2                	cmp    %al,%dl
  800d8d:	74 e3                	je     800d72 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d92:	8a 00                	mov    (%eax),%al
  800d94:	0f b6 d0             	movzbl %al,%edx
  800d97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9a:	8a 00                	mov    (%eax),%al
  800d9c:	0f b6 c0             	movzbl %al,%eax
  800d9f:	29 c2                	sub    %eax,%edx
  800da1:	89 d0                	mov    %edx,%eax
}
  800da3:	5d                   	pop    %ebp
  800da4:	c3                   	ret    

00800da5 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800da5:	55                   	push   %ebp
  800da6:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800da8:	eb 09                	jmp    800db3 <strncmp+0xe>
		n--, p++, q++;
  800daa:	ff 4d 10             	decl   0x10(%ebp)
  800dad:	ff 45 08             	incl   0x8(%ebp)
  800db0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800db3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800db7:	74 17                	je     800dd0 <strncmp+0x2b>
  800db9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbc:	8a 00                	mov    (%eax),%al
  800dbe:	84 c0                	test   %al,%al
  800dc0:	74 0e                	je     800dd0 <strncmp+0x2b>
  800dc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc5:	8a 10                	mov    (%eax),%dl
  800dc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dca:	8a 00                	mov    (%eax),%al
  800dcc:	38 c2                	cmp    %al,%dl
  800dce:	74 da                	je     800daa <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800dd0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dd4:	75 07                	jne    800ddd <strncmp+0x38>
		return 0;
  800dd6:	b8 00 00 00 00       	mov    $0x0,%eax
  800ddb:	eb 14                	jmp    800df1 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  800de0:	8a 00                	mov    (%eax),%al
  800de2:	0f b6 d0             	movzbl %al,%edx
  800de5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de8:	8a 00                	mov    (%eax),%al
  800dea:	0f b6 c0             	movzbl %al,%eax
  800ded:	29 c2                	sub    %eax,%edx
  800def:	89 d0                	mov    %edx,%eax
}
  800df1:	5d                   	pop    %ebp
  800df2:	c3                   	ret    

00800df3 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800df3:	55                   	push   %ebp
  800df4:	89 e5                	mov    %esp,%ebp
  800df6:	83 ec 04             	sub    $0x4,%esp
  800df9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dfc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dff:	eb 12                	jmp    800e13 <strchr+0x20>
		if (*s == c)
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
  800e04:	8a 00                	mov    (%eax),%al
  800e06:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e09:	75 05                	jne    800e10 <strchr+0x1d>
			return (char *) s;
  800e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0e:	eb 11                	jmp    800e21 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e10:	ff 45 08             	incl   0x8(%ebp)
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	8a 00                	mov    (%eax),%al
  800e18:	84 c0                	test   %al,%al
  800e1a:	75 e5                	jne    800e01 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e1c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e21:	c9                   	leave  
  800e22:	c3                   	ret    

00800e23 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e23:	55                   	push   %ebp
  800e24:	89 e5                	mov    %esp,%ebp
  800e26:	83 ec 04             	sub    $0x4,%esp
  800e29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e2f:	eb 0d                	jmp    800e3e <strfind+0x1b>
		if (*s == c)
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	8a 00                	mov    (%eax),%al
  800e36:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e39:	74 0e                	je     800e49 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e3b:	ff 45 08             	incl   0x8(%ebp)
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	84 c0                	test   %al,%al
  800e45:	75 ea                	jne    800e31 <strfind+0xe>
  800e47:	eb 01                	jmp    800e4a <strfind+0x27>
		if (*s == c)
			break;
  800e49:	90                   	nop
	return (char *) s;
  800e4a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e4d:	c9                   	leave  
  800e4e:	c3                   	ret    

00800e4f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e4f:	55                   	push   %ebp
  800e50:	89 e5                	mov    %esp,%ebp
  800e52:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e55:	8b 45 08             	mov    0x8(%ebp),%eax
  800e58:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e5b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e61:	eb 0e                	jmp    800e71 <memset+0x22>
		*p++ = c;
  800e63:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e66:	8d 50 01             	lea    0x1(%eax),%edx
  800e69:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e6f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e71:	ff 4d f8             	decl   -0x8(%ebp)
  800e74:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e78:	79 e9                	jns    800e63 <memset+0x14>
		*p++ = c;

	return v;
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e7d:	c9                   	leave  
  800e7e:	c3                   	ret    

00800e7f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e7f:	55                   	push   %ebp
  800e80:	89 e5                	mov    %esp,%ebp
  800e82:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e88:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e91:	eb 16                	jmp    800ea9 <memcpy+0x2a>
		*d++ = *s++;
  800e93:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e96:	8d 50 01             	lea    0x1(%eax),%edx
  800e99:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e9c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e9f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ea2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ea5:	8a 12                	mov    (%edx),%dl
  800ea7:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ea9:	8b 45 10             	mov    0x10(%ebp),%eax
  800eac:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eaf:	89 55 10             	mov    %edx,0x10(%ebp)
  800eb2:	85 c0                	test   %eax,%eax
  800eb4:	75 dd                	jne    800e93 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800eb6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eb9:	c9                   	leave  
  800eba:	c3                   	ret    

00800ebb <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ebb:	55                   	push   %ebp
  800ebc:	89 e5                	mov    %esp,%ebp
  800ebe:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800ec1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ec7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eca:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ecd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ed0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ed3:	73 50                	jae    800f25 <memmove+0x6a>
  800ed5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ed8:	8b 45 10             	mov    0x10(%ebp),%eax
  800edb:	01 d0                	add    %edx,%eax
  800edd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ee0:	76 43                	jbe    800f25 <memmove+0x6a>
		s += n;
  800ee2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ee8:	8b 45 10             	mov    0x10(%ebp),%eax
  800eeb:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800eee:	eb 10                	jmp    800f00 <memmove+0x45>
			*--d = *--s;
  800ef0:	ff 4d f8             	decl   -0x8(%ebp)
  800ef3:	ff 4d fc             	decl   -0x4(%ebp)
  800ef6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef9:	8a 10                	mov    (%eax),%dl
  800efb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800efe:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f00:	8b 45 10             	mov    0x10(%ebp),%eax
  800f03:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f06:	89 55 10             	mov    %edx,0x10(%ebp)
  800f09:	85 c0                	test   %eax,%eax
  800f0b:	75 e3                	jne    800ef0 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f0d:	eb 23                	jmp    800f32 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f0f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f12:	8d 50 01             	lea    0x1(%eax),%edx
  800f15:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f18:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f1b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f1e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f21:	8a 12                	mov    (%edx),%dl
  800f23:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f25:	8b 45 10             	mov    0x10(%ebp),%eax
  800f28:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f2b:	89 55 10             	mov    %edx,0x10(%ebp)
  800f2e:	85 c0                	test   %eax,%eax
  800f30:	75 dd                	jne    800f0f <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f35:	c9                   	leave  
  800f36:	c3                   	ret    

00800f37 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f37:	55                   	push   %ebp
  800f38:	89 e5                	mov    %esp,%ebp
  800f3a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f40:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f46:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f49:	eb 2a                	jmp    800f75 <memcmp+0x3e>
		if (*s1 != *s2)
  800f4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f4e:	8a 10                	mov    (%eax),%dl
  800f50:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f53:	8a 00                	mov    (%eax),%al
  800f55:	38 c2                	cmp    %al,%dl
  800f57:	74 16                	je     800f6f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f59:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f5c:	8a 00                	mov    (%eax),%al
  800f5e:	0f b6 d0             	movzbl %al,%edx
  800f61:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f64:	8a 00                	mov    (%eax),%al
  800f66:	0f b6 c0             	movzbl %al,%eax
  800f69:	29 c2                	sub    %eax,%edx
  800f6b:	89 d0                	mov    %edx,%eax
  800f6d:	eb 18                	jmp    800f87 <memcmp+0x50>
		s1++, s2++;
  800f6f:	ff 45 fc             	incl   -0x4(%ebp)
  800f72:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f75:	8b 45 10             	mov    0x10(%ebp),%eax
  800f78:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f7b:	89 55 10             	mov    %edx,0x10(%ebp)
  800f7e:	85 c0                	test   %eax,%eax
  800f80:	75 c9                	jne    800f4b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f82:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f87:	c9                   	leave  
  800f88:	c3                   	ret    

00800f89 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f89:	55                   	push   %ebp
  800f8a:	89 e5                	mov    %esp,%ebp
  800f8c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f8f:	8b 55 08             	mov    0x8(%ebp),%edx
  800f92:	8b 45 10             	mov    0x10(%ebp),%eax
  800f95:	01 d0                	add    %edx,%eax
  800f97:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f9a:	eb 15                	jmp    800fb1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	8a 00                	mov    (%eax),%al
  800fa1:	0f b6 d0             	movzbl %al,%edx
  800fa4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa7:	0f b6 c0             	movzbl %al,%eax
  800faa:	39 c2                	cmp    %eax,%edx
  800fac:	74 0d                	je     800fbb <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800fae:	ff 45 08             	incl   0x8(%ebp)
  800fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fb7:	72 e3                	jb     800f9c <memfind+0x13>
  800fb9:	eb 01                	jmp    800fbc <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fbb:	90                   	nop
	return (void *) s;
  800fbc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fbf:	c9                   	leave  
  800fc0:	c3                   	ret    

00800fc1 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800fc1:	55                   	push   %ebp
  800fc2:	89 e5                	mov    %esp,%ebp
  800fc4:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800fc7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800fce:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fd5:	eb 03                	jmp    800fda <strtol+0x19>
		s++;
  800fd7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	3c 20                	cmp    $0x20,%al
  800fe1:	74 f4                	je     800fd7 <strtol+0x16>
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	3c 09                	cmp    $0x9,%al
  800fea:	74 eb                	je     800fd7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	8a 00                	mov    (%eax),%al
  800ff1:	3c 2b                	cmp    $0x2b,%al
  800ff3:	75 05                	jne    800ffa <strtol+0x39>
		s++;
  800ff5:	ff 45 08             	incl   0x8(%ebp)
  800ff8:	eb 13                	jmp    80100d <strtol+0x4c>
	else if (*s == '-')
  800ffa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffd:	8a 00                	mov    (%eax),%al
  800fff:	3c 2d                	cmp    $0x2d,%al
  801001:	75 0a                	jne    80100d <strtol+0x4c>
		s++, neg = 1;
  801003:	ff 45 08             	incl   0x8(%ebp)
  801006:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80100d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801011:	74 06                	je     801019 <strtol+0x58>
  801013:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801017:	75 20                	jne    801039 <strtol+0x78>
  801019:	8b 45 08             	mov    0x8(%ebp),%eax
  80101c:	8a 00                	mov    (%eax),%al
  80101e:	3c 30                	cmp    $0x30,%al
  801020:	75 17                	jne    801039 <strtol+0x78>
  801022:	8b 45 08             	mov    0x8(%ebp),%eax
  801025:	40                   	inc    %eax
  801026:	8a 00                	mov    (%eax),%al
  801028:	3c 78                	cmp    $0x78,%al
  80102a:	75 0d                	jne    801039 <strtol+0x78>
		s += 2, base = 16;
  80102c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801030:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801037:	eb 28                	jmp    801061 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801039:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80103d:	75 15                	jne    801054 <strtol+0x93>
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	8a 00                	mov    (%eax),%al
  801044:	3c 30                	cmp    $0x30,%al
  801046:	75 0c                	jne    801054 <strtol+0x93>
		s++, base = 8;
  801048:	ff 45 08             	incl   0x8(%ebp)
  80104b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801052:	eb 0d                	jmp    801061 <strtol+0xa0>
	else if (base == 0)
  801054:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801058:	75 07                	jne    801061 <strtol+0xa0>
		base = 10;
  80105a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801061:	8b 45 08             	mov    0x8(%ebp),%eax
  801064:	8a 00                	mov    (%eax),%al
  801066:	3c 2f                	cmp    $0x2f,%al
  801068:	7e 19                	jle    801083 <strtol+0xc2>
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	8a 00                	mov    (%eax),%al
  80106f:	3c 39                	cmp    $0x39,%al
  801071:	7f 10                	jg     801083 <strtol+0xc2>
			dig = *s - '0';
  801073:	8b 45 08             	mov    0x8(%ebp),%eax
  801076:	8a 00                	mov    (%eax),%al
  801078:	0f be c0             	movsbl %al,%eax
  80107b:	83 e8 30             	sub    $0x30,%eax
  80107e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801081:	eb 42                	jmp    8010c5 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801083:	8b 45 08             	mov    0x8(%ebp),%eax
  801086:	8a 00                	mov    (%eax),%al
  801088:	3c 60                	cmp    $0x60,%al
  80108a:	7e 19                	jle    8010a5 <strtol+0xe4>
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	8a 00                	mov    (%eax),%al
  801091:	3c 7a                	cmp    $0x7a,%al
  801093:	7f 10                	jg     8010a5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801095:	8b 45 08             	mov    0x8(%ebp),%eax
  801098:	8a 00                	mov    (%eax),%al
  80109a:	0f be c0             	movsbl %al,%eax
  80109d:	83 e8 57             	sub    $0x57,%eax
  8010a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010a3:	eb 20                	jmp    8010c5 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a8:	8a 00                	mov    (%eax),%al
  8010aa:	3c 40                	cmp    $0x40,%al
  8010ac:	7e 39                	jle    8010e7 <strtol+0x126>
  8010ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b1:	8a 00                	mov    (%eax),%al
  8010b3:	3c 5a                	cmp    $0x5a,%al
  8010b5:	7f 30                	jg     8010e7 <strtol+0x126>
			dig = *s - 'A' + 10;
  8010b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ba:	8a 00                	mov    (%eax),%al
  8010bc:	0f be c0             	movsbl %al,%eax
  8010bf:	83 e8 37             	sub    $0x37,%eax
  8010c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010c8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010cb:	7d 19                	jge    8010e6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010cd:	ff 45 08             	incl   0x8(%ebp)
  8010d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d3:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010d7:	89 c2                	mov    %eax,%edx
  8010d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010dc:	01 d0                	add    %edx,%eax
  8010de:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010e1:	e9 7b ff ff ff       	jmp    801061 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010e6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010e7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010eb:	74 08                	je     8010f5 <strtol+0x134>
		*endptr = (char *) s;
  8010ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f0:	8b 55 08             	mov    0x8(%ebp),%edx
  8010f3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010f5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010f9:	74 07                	je     801102 <strtol+0x141>
  8010fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010fe:	f7 d8                	neg    %eax
  801100:	eb 03                	jmp    801105 <strtol+0x144>
  801102:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801105:	c9                   	leave  
  801106:	c3                   	ret    

00801107 <ltostr>:

void
ltostr(long value, char *str)
{
  801107:	55                   	push   %ebp
  801108:	89 e5                	mov    %esp,%ebp
  80110a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80110d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801114:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80111b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80111f:	79 13                	jns    801134 <ltostr+0x2d>
	{
		neg = 1;
  801121:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801128:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80112e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801131:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801134:	8b 45 08             	mov    0x8(%ebp),%eax
  801137:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80113c:	99                   	cltd   
  80113d:	f7 f9                	idiv   %ecx
  80113f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801142:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801145:	8d 50 01             	lea    0x1(%eax),%edx
  801148:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80114b:	89 c2                	mov    %eax,%edx
  80114d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801150:	01 d0                	add    %edx,%eax
  801152:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801155:	83 c2 30             	add    $0x30,%edx
  801158:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80115a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80115d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801162:	f7 e9                	imul   %ecx
  801164:	c1 fa 02             	sar    $0x2,%edx
  801167:	89 c8                	mov    %ecx,%eax
  801169:	c1 f8 1f             	sar    $0x1f,%eax
  80116c:	29 c2                	sub    %eax,%edx
  80116e:	89 d0                	mov    %edx,%eax
  801170:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801173:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801176:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80117b:	f7 e9                	imul   %ecx
  80117d:	c1 fa 02             	sar    $0x2,%edx
  801180:	89 c8                	mov    %ecx,%eax
  801182:	c1 f8 1f             	sar    $0x1f,%eax
  801185:	29 c2                	sub    %eax,%edx
  801187:	89 d0                	mov    %edx,%eax
  801189:	c1 e0 02             	shl    $0x2,%eax
  80118c:	01 d0                	add    %edx,%eax
  80118e:	01 c0                	add    %eax,%eax
  801190:	29 c1                	sub    %eax,%ecx
  801192:	89 ca                	mov    %ecx,%edx
  801194:	85 d2                	test   %edx,%edx
  801196:	75 9c                	jne    801134 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801198:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80119f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a2:	48                   	dec    %eax
  8011a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8011a6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011aa:	74 3d                	je     8011e9 <ltostr+0xe2>
		start = 1 ;
  8011ac:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011b3:	eb 34                	jmp    8011e9 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bb:	01 d0                	add    %edx,%eax
  8011bd:	8a 00                	mov    (%eax),%al
  8011bf:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c8:	01 c2                	add    %eax,%edx
  8011ca:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d0:	01 c8                	add    %ecx,%eax
  8011d2:	8a 00                	mov    (%eax),%al
  8011d4:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011d6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dc:	01 c2                	add    %eax,%edx
  8011de:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011e1:	88 02                	mov    %al,(%edx)
		start++ ;
  8011e3:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011e6:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011ec:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011ef:	7c c4                	jl     8011b5 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011f1:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f7:	01 d0                	add    %edx,%eax
  8011f9:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011fc:	90                   	nop
  8011fd:	c9                   	leave  
  8011fe:	c3                   	ret    

008011ff <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011ff:	55                   	push   %ebp
  801200:	89 e5                	mov    %esp,%ebp
  801202:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801205:	ff 75 08             	pushl  0x8(%ebp)
  801208:	e8 54 fa ff ff       	call   800c61 <strlen>
  80120d:	83 c4 04             	add    $0x4,%esp
  801210:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801213:	ff 75 0c             	pushl  0xc(%ebp)
  801216:	e8 46 fa ff ff       	call   800c61 <strlen>
  80121b:	83 c4 04             	add    $0x4,%esp
  80121e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801221:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801228:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80122f:	eb 17                	jmp    801248 <strcconcat+0x49>
		final[s] = str1[s] ;
  801231:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801234:	8b 45 10             	mov    0x10(%ebp),%eax
  801237:	01 c2                	add    %eax,%edx
  801239:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80123c:	8b 45 08             	mov    0x8(%ebp),%eax
  80123f:	01 c8                	add    %ecx,%eax
  801241:	8a 00                	mov    (%eax),%al
  801243:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801245:	ff 45 fc             	incl   -0x4(%ebp)
  801248:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80124b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80124e:	7c e1                	jl     801231 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801250:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801257:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80125e:	eb 1f                	jmp    80127f <strcconcat+0x80>
		final[s++] = str2[i] ;
  801260:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801263:	8d 50 01             	lea    0x1(%eax),%edx
  801266:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801269:	89 c2                	mov    %eax,%edx
  80126b:	8b 45 10             	mov    0x10(%ebp),%eax
  80126e:	01 c2                	add    %eax,%edx
  801270:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801273:	8b 45 0c             	mov    0xc(%ebp),%eax
  801276:	01 c8                	add    %ecx,%eax
  801278:	8a 00                	mov    (%eax),%al
  80127a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80127c:	ff 45 f8             	incl   -0x8(%ebp)
  80127f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801282:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801285:	7c d9                	jl     801260 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801287:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80128a:	8b 45 10             	mov    0x10(%ebp),%eax
  80128d:	01 d0                	add    %edx,%eax
  80128f:	c6 00 00             	movb   $0x0,(%eax)
}
  801292:	90                   	nop
  801293:	c9                   	leave  
  801294:	c3                   	ret    

00801295 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801295:	55                   	push   %ebp
  801296:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801298:	8b 45 14             	mov    0x14(%ebp),%eax
  80129b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8012a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a4:	8b 00                	mov    (%eax),%eax
  8012a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b0:	01 d0                	add    %edx,%eax
  8012b2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012b8:	eb 0c                	jmp    8012c6 <strsplit+0x31>
			*string++ = 0;
  8012ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bd:	8d 50 01             	lea    0x1(%eax),%edx
  8012c0:	89 55 08             	mov    %edx,0x8(%ebp)
  8012c3:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c9:	8a 00                	mov    (%eax),%al
  8012cb:	84 c0                	test   %al,%al
  8012cd:	74 18                	je     8012e7 <strsplit+0x52>
  8012cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d2:	8a 00                	mov    (%eax),%al
  8012d4:	0f be c0             	movsbl %al,%eax
  8012d7:	50                   	push   %eax
  8012d8:	ff 75 0c             	pushl  0xc(%ebp)
  8012db:	e8 13 fb ff ff       	call   800df3 <strchr>
  8012e0:	83 c4 08             	add    $0x8,%esp
  8012e3:	85 c0                	test   %eax,%eax
  8012e5:	75 d3                	jne    8012ba <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8012e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ea:	8a 00                	mov    (%eax),%al
  8012ec:	84 c0                	test   %al,%al
  8012ee:	74 5a                	je     80134a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8012f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8012f3:	8b 00                	mov    (%eax),%eax
  8012f5:	83 f8 0f             	cmp    $0xf,%eax
  8012f8:	75 07                	jne    801301 <strsplit+0x6c>
		{
			return 0;
  8012fa:	b8 00 00 00 00       	mov    $0x0,%eax
  8012ff:	eb 66                	jmp    801367 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801301:	8b 45 14             	mov    0x14(%ebp),%eax
  801304:	8b 00                	mov    (%eax),%eax
  801306:	8d 48 01             	lea    0x1(%eax),%ecx
  801309:	8b 55 14             	mov    0x14(%ebp),%edx
  80130c:	89 0a                	mov    %ecx,(%edx)
  80130e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801315:	8b 45 10             	mov    0x10(%ebp),%eax
  801318:	01 c2                	add    %eax,%edx
  80131a:	8b 45 08             	mov    0x8(%ebp),%eax
  80131d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80131f:	eb 03                	jmp    801324 <strsplit+0x8f>
			string++;
  801321:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801324:	8b 45 08             	mov    0x8(%ebp),%eax
  801327:	8a 00                	mov    (%eax),%al
  801329:	84 c0                	test   %al,%al
  80132b:	74 8b                	je     8012b8 <strsplit+0x23>
  80132d:	8b 45 08             	mov    0x8(%ebp),%eax
  801330:	8a 00                	mov    (%eax),%al
  801332:	0f be c0             	movsbl %al,%eax
  801335:	50                   	push   %eax
  801336:	ff 75 0c             	pushl  0xc(%ebp)
  801339:	e8 b5 fa ff ff       	call   800df3 <strchr>
  80133e:	83 c4 08             	add    $0x8,%esp
  801341:	85 c0                	test   %eax,%eax
  801343:	74 dc                	je     801321 <strsplit+0x8c>
			string++;
	}
  801345:	e9 6e ff ff ff       	jmp    8012b8 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80134a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80134b:	8b 45 14             	mov    0x14(%ebp),%eax
  80134e:	8b 00                	mov    (%eax),%eax
  801350:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801357:	8b 45 10             	mov    0x10(%ebp),%eax
  80135a:	01 d0                	add    %edx,%eax
  80135c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801362:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801367:	c9                   	leave  
  801368:	c3                   	ret    

00801369 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801369:	55                   	push   %ebp
  80136a:	89 e5                	mov    %esp,%ebp
  80136c:	83 ec 18             	sub    $0x18,%esp
  80136f:	8b 45 10             	mov    0x10(%ebp),%eax
  801372:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801375:	83 ec 04             	sub    $0x4,%esp
  801378:	68 90 24 80 00       	push   $0x802490
  80137d:	6a 17                	push   $0x17
  80137f:	68 af 24 80 00       	push   $0x8024af
  801384:	e8 a2 ef ff ff       	call   80032b <_panic>

00801389 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801389:	55                   	push   %ebp
  80138a:	89 e5                	mov    %esp,%ebp
  80138c:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  80138f:	83 ec 04             	sub    $0x4,%esp
  801392:	68 bb 24 80 00       	push   $0x8024bb
  801397:	6a 2f                	push   $0x2f
  801399:	68 af 24 80 00       	push   $0x8024af
  80139e:	e8 88 ef ff ff       	call   80032b <_panic>

008013a3 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8013a3:	55                   	push   %ebp
  8013a4:	89 e5                	mov    %esp,%ebp
  8013a6:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8013a9:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8013b0:	8b 55 08             	mov    0x8(%ebp),%edx
  8013b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013b6:	01 d0                	add    %edx,%eax
  8013b8:	48                   	dec    %eax
  8013b9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8013bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8013bf:	ba 00 00 00 00       	mov    $0x0,%edx
  8013c4:	f7 75 ec             	divl   -0x14(%ebp)
  8013c7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8013ca:	29 d0                	sub    %edx,%eax
  8013cc:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8013cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d2:	c1 e8 0c             	shr    $0xc,%eax
  8013d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8013d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8013df:	e9 c8 00 00 00       	jmp    8014ac <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8013e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8013eb:	eb 27                	jmp    801414 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8013ed:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013f3:	01 c2                	add    %eax,%edx
  8013f5:	89 d0                	mov    %edx,%eax
  8013f7:	01 c0                	add    %eax,%eax
  8013f9:	01 d0                	add    %edx,%eax
  8013fb:	c1 e0 02             	shl    $0x2,%eax
  8013fe:	05 48 30 80 00       	add    $0x803048,%eax
  801403:	8b 00                	mov    (%eax),%eax
  801405:	85 c0                	test   %eax,%eax
  801407:	74 08                	je     801411 <malloc+0x6e>
            	i += j;
  801409:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80140c:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  80140f:	eb 0b                	jmp    80141c <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801411:	ff 45 f0             	incl   -0x10(%ebp)
  801414:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801417:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80141a:	72 d1                	jb     8013ed <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  80141c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80141f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801422:	0f 85 81 00 00 00    	jne    8014a9 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801428:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80142b:	05 00 00 08 00       	add    $0x80000,%eax
  801430:	c1 e0 0c             	shl    $0xc,%eax
  801433:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801436:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80143d:	eb 1f                	jmp    80145e <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  80143f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801442:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801445:	01 c2                	add    %eax,%edx
  801447:	89 d0                	mov    %edx,%eax
  801449:	01 c0                	add    %eax,%eax
  80144b:	01 d0                	add    %edx,%eax
  80144d:	c1 e0 02             	shl    $0x2,%eax
  801450:	05 48 30 80 00       	add    $0x803048,%eax
  801455:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80145b:	ff 45 f0             	incl   -0x10(%ebp)
  80145e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801461:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801464:	72 d9                	jb     80143f <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801466:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801469:	89 d0                	mov    %edx,%eax
  80146b:	01 c0                	add    %eax,%eax
  80146d:	01 d0                	add    %edx,%eax
  80146f:	c1 e0 02             	shl    $0x2,%eax
  801472:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801478:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80147b:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  80147d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801480:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801483:	89 c8                	mov    %ecx,%eax
  801485:	01 c0                	add    %eax,%eax
  801487:	01 c8                	add    %ecx,%eax
  801489:	c1 e0 02             	shl    $0x2,%eax
  80148c:	05 44 30 80 00       	add    $0x803044,%eax
  801491:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801493:	83 ec 08             	sub    $0x8,%esp
  801496:	ff 75 08             	pushl  0x8(%ebp)
  801499:	ff 75 e0             	pushl  -0x20(%ebp)
  80149c:	e8 2b 03 00 00       	call   8017cc <sys_allocateMem>
  8014a1:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8014a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8014a7:	eb 19                	jmp    8014c2 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8014a9:	ff 45 f4             	incl   -0xc(%ebp)
  8014ac:	a1 04 30 80 00       	mov    0x803004,%eax
  8014b1:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8014b4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014b7:	0f 83 27 ff ff ff    	jae    8013e4 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8014bd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014c2:	c9                   	leave  
  8014c3:	c3                   	ret    

008014c4 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8014c4:	55                   	push   %ebp
  8014c5:	89 e5                	mov    %esp,%ebp
  8014c7:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8014ca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014ce:	0f 84 e5 00 00 00    	je     8015b9 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8014d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8014da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014dd:	05 00 00 00 80       	add    $0x80000000,%eax
  8014e2:	c1 e8 0c             	shr    $0xc,%eax
  8014e5:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8014e8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014eb:	89 d0                	mov    %edx,%eax
  8014ed:	01 c0                	add    %eax,%eax
  8014ef:	01 d0                	add    %edx,%eax
  8014f1:	c1 e0 02             	shl    $0x2,%eax
  8014f4:	05 40 30 80 00       	add    $0x803040,%eax
  8014f9:	8b 00                	mov    (%eax),%eax
  8014fb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014fe:	0f 85 b8 00 00 00    	jne    8015bc <free+0xf8>
  801504:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801507:	89 d0                	mov    %edx,%eax
  801509:	01 c0                	add    %eax,%eax
  80150b:	01 d0                	add    %edx,%eax
  80150d:	c1 e0 02             	shl    $0x2,%eax
  801510:	05 48 30 80 00       	add    $0x803048,%eax
  801515:	8b 00                	mov    (%eax),%eax
  801517:	85 c0                	test   %eax,%eax
  801519:	0f 84 9d 00 00 00    	je     8015bc <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  80151f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801522:	89 d0                	mov    %edx,%eax
  801524:	01 c0                	add    %eax,%eax
  801526:	01 d0                	add    %edx,%eax
  801528:	c1 e0 02             	shl    $0x2,%eax
  80152b:	05 44 30 80 00       	add    $0x803044,%eax
  801530:	8b 00                	mov    (%eax),%eax
  801532:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801535:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801538:	c1 e0 0c             	shl    $0xc,%eax
  80153b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  80153e:	83 ec 08             	sub    $0x8,%esp
  801541:	ff 75 e4             	pushl  -0x1c(%ebp)
  801544:	ff 75 f0             	pushl  -0x10(%ebp)
  801547:	e8 64 02 00 00       	call   8017b0 <sys_freeMem>
  80154c:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80154f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801556:	eb 57                	jmp    8015af <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801558:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80155b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80155e:	01 c2                	add    %eax,%edx
  801560:	89 d0                	mov    %edx,%eax
  801562:	01 c0                	add    %eax,%eax
  801564:	01 d0                	add    %edx,%eax
  801566:	c1 e0 02             	shl    $0x2,%eax
  801569:	05 48 30 80 00       	add    $0x803048,%eax
  80156e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801574:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801577:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80157a:	01 c2                	add    %eax,%edx
  80157c:	89 d0                	mov    %edx,%eax
  80157e:	01 c0                	add    %eax,%eax
  801580:	01 d0                	add    %edx,%eax
  801582:	c1 e0 02             	shl    $0x2,%eax
  801585:	05 40 30 80 00       	add    $0x803040,%eax
  80158a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801590:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801593:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801596:	01 c2                	add    %eax,%edx
  801598:	89 d0                	mov    %edx,%eax
  80159a:	01 c0                	add    %eax,%eax
  80159c:	01 d0                	add    %edx,%eax
  80159e:	c1 e0 02             	shl    $0x2,%eax
  8015a1:	05 44 30 80 00       	add    $0x803044,%eax
  8015a6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8015ac:	ff 45 f4             	incl   -0xc(%ebp)
  8015af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015b2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8015b5:	7c a1                	jl     801558 <free+0x94>
  8015b7:	eb 04                	jmp    8015bd <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8015b9:	90                   	nop
  8015ba:	eb 01                	jmp    8015bd <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8015bc:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8015bd:	c9                   	leave  
  8015be:	c3                   	ret    

008015bf <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8015bf:	55                   	push   %ebp
  8015c0:	89 e5                	mov    %esp,%ebp
  8015c2:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8015c5:	83 ec 04             	sub    $0x4,%esp
  8015c8:	68 d8 24 80 00       	push   $0x8024d8
  8015cd:	68 ae 00 00 00       	push   $0xae
  8015d2:	68 af 24 80 00       	push   $0x8024af
  8015d7:	e8 4f ed ff ff       	call   80032b <_panic>

008015dc <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8015dc:	55                   	push   %ebp
  8015dd:	89 e5                	mov    %esp,%ebp
  8015df:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8015e2:	83 ec 04             	sub    $0x4,%esp
  8015e5:	68 f8 24 80 00       	push   $0x8024f8
  8015ea:	68 ca 00 00 00       	push   $0xca
  8015ef:	68 af 24 80 00       	push   $0x8024af
  8015f4:	e8 32 ed ff ff       	call   80032b <_panic>

008015f9 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8015f9:	55                   	push   %ebp
  8015fa:	89 e5                	mov    %esp,%ebp
  8015fc:	57                   	push   %edi
  8015fd:	56                   	push   %esi
  8015fe:	53                   	push   %ebx
  8015ff:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801602:	8b 45 08             	mov    0x8(%ebp),%eax
  801605:	8b 55 0c             	mov    0xc(%ebp),%edx
  801608:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80160b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80160e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801611:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801614:	cd 30                	int    $0x30
  801616:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801619:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80161c:	83 c4 10             	add    $0x10,%esp
  80161f:	5b                   	pop    %ebx
  801620:	5e                   	pop    %esi
  801621:	5f                   	pop    %edi
  801622:	5d                   	pop    %ebp
  801623:	c3                   	ret    

00801624 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801624:	55                   	push   %ebp
  801625:	89 e5                	mov    %esp,%ebp
  801627:	83 ec 04             	sub    $0x4,%esp
  80162a:	8b 45 10             	mov    0x10(%ebp),%eax
  80162d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801630:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801634:	8b 45 08             	mov    0x8(%ebp),%eax
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	52                   	push   %edx
  80163c:	ff 75 0c             	pushl  0xc(%ebp)
  80163f:	50                   	push   %eax
  801640:	6a 00                	push   $0x0
  801642:	e8 b2 ff ff ff       	call   8015f9 <syscall>
  801647:	83 c4 18             	add    $0x18,%esp
}
  80164a:	90                   	nop
  80164b:	c9                   	leave  
  80164c:	c3                   	ret    

0080164d <sys_cgetc>:

int
sys_cgetc(void)
{
  80164d:	55                   	push   %ebp
  80164e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	6a 01                	push   $0x1
  80165c:	e8 98 ff ff ff       	call   8015f9 <syscall>
  801661:	83 c4 18             	add    $0x18,%esp
}
  801664:	c9                   	leave  
  801665:	c3                   	ret    

00801666 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801669:	8b 45 08             	mov    0x8(%ebp),%eax
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	50                   	push   %eax
  801675:	6a 05                	push   $0x5
  801677:	e8 7d ff ff ff       	call   8015f9 <syscall>
  80167c:	83 c4 18             	add    $0x18,%esp
}
  80167f:	c9                   	leave  
  801680:	c3                   	ret    

00801681 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801681:	55                   	push   %ebp
  801682:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 02                	push   $0x2
  801690:	e8 64 ff ff ff       	call   8015f9 <syscall>
  801695:	83 c4 18             	add    $0x18,%esp
}
  801698:	c9                   	leave  
  801699:	c3                   	ret    

0080169a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80169a:	55                   	push   %ebp
  80169b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80169d:	6a 00                	push   $0x0
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 03                	push   $0x3
  8016a9:	e8 4b ff ff ff       	call   8015f9 <syscall>
  8016ae:	83 c4 18             	add    $0x18,%esp
}
  8016b1:	c9                   	leave  
  8016b2:	c3                   	ret    

008016b3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8016b3:	55                   	push   %ebp
  8016b4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 04                	push   $0x4
  8016c2:	e8 32 ff ff ff       	call   8015f9 <syscall>
  8016c7:	83 c4 18             	add    $0x18,%esp
}
  8016ca:	c9                   	leave  
  8016cb:	c3                   	ret    

008016cc <sys_env_exit>:


void sys_env_exit(void)
{
  8016cc:	55                   	push   %ebp
  8016cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8016cf:	6a 00                	push   $0x0
  8016d1:	6a 00                	push   $0x0
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 06                	push   $0x6
  8016db:	e8 19 ff ff ff       	call   8015f9 <syscall>
  8016e0:	83 c4 18             	add    $0x18,%esp
}
  8016e3:	90                   	nop
  8016e4:	c9                   	leave  
  8016e5:	c3                   	ret    

008016e6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016e6:	55                   	push   %ebp
  8016e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	52                   	push   %edx
  8016f6:	50                   	push   %eax
  8016f7:	6a 07                	push   $0x7
  8016f9:	e8 fb fe ff ff       	call   8015f9 <syscall>
  8016fe:	83 c4 18             	add    $0x18,%esp
}
  801701:	c9                   	leave  
  801702:	c3                   	ret    

00801703 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801703:	55                   	push   %ebp
  801704:	89 e5                	mov    %esp,%ebp
  801706:	56                   	push   %esi
  801707:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801708:	8b 75 18             	mov    0x18(%ebp),%esi
  80170b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80170e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801711:	8b 55 0c             	mov    0xc(%ebp),%edx
  801714:	8b 45 08             	mov    0x8(%ebp),%eax
  801717:	56                   	push   %esi
  801718:	53                   	push   %ebx
  801719:	51                   	push   %ecx
  80171a:	52                   	push   %edx
  80171b:	50                   	push   %eax
  80171c:	6a 08                	push   $0x8
  80171e:	e8 d6 fe ff ff       	call   8015f9 <syscall>
  801723:	83 c4 18             	add    $0x18,%esp
}
  801726:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801729:	5b                   	pop    %ebx
  80172a:	5e                   	pop    %esi
  80172b:	5d                   	pop    %ebp
  80172c:	c3                   	ret    

0080172d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80172d:	55                   	push   %ebp
  80172e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801730:	8b 55 0c             	mov    0xc(%ebp),%edx
  801733:	8b 45 08             	mov    0x8(%ebp),%eax
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	52                   	push   %edx
  80173d:	50                   	push   %eax
  80173e:	6a 09                	push   $0x9
  801740:	e8 b4 fe ff ff       	call   8015f9 <syscall>
  801745:	83 c4 18             	add    $0x18,%esp
}
  801748:	c9                   	leave  
  801749:	c3                   	ret    

0080174a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80174a:	55                   	push   %ebp
  80174b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	ff 75 0c             	pushl  0xc(%ebp)
  801756:	ff 75 08             	pushl  0x8(%ebp)
  801759:	6a 0a                	push   $0xa
  80175b:	e8 99 fe ff ff       	call   8015f9 <syscall>
  801760:	83 c4 18             	add    $0x18,%esp
}
  801763:	c9                   	leave  
  801764:	c3                   	ret    

00801765 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801765:	55                   	push   %ebp
  801766:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	6a 00                	push   $0x0
  801772:	6a 0b                	push   $0xb
  801774:	e8 80 fe ff ff       	call   8015f9 <syscall>
  801779:	83 c4 18             	add    $0x18,%esp
}
  80177c:	c9                   	leave  
  80177d:	c3                   	ret    

0080177e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80177e:	55                   	push   %ebp
  80177f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 0c                	push   $0xc
  80178d:	e8 67 fe ff ff       	call   8015f9 <syscall>
  801792:	83 c4 18             	add    $0x18,%esp
}
  801795:	c9                   	leave  
  801796:	c3                   	ret    

00801797 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801797:	55                   	push   %ebp
  801798:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 0d                	push   $0xd
  8017a6:	e8 4e fe ff ff       	call   8015f9 <syscall>
  8017ab:	83 c4 18             	add    $0x18,%esp
}
  8017ae:	c9                   	leave  
  8017af:	c3                   	ret    

008017b0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8017b0:	55                   	push   %ebp
  8017b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	ff 75 0c             	pushl  0xc(%ebp)
  8017bc:	ff 75 08             	pushl  0x8(%ebp)
  8017bf:	6a 11                	push   $0x11
  8017c1:	e8 33 fe ff ff       	call   8015f9 <syscall>
  8017c6:	83 c4 18             	add    $0x18,%esp
	return;
  8017c9:	90                   	nop
}
  8017ca:	c9                   	leave  
  8017cb:	c3                   	ret    

008017cc <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8017cc:	55                   	push   %ebp
  8017cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	ff 75 0c             	pushl  0xc(%ebp)
  8017d8:	ff 75 08             	pushl  0x8(%ebp)
  8017db:	6a 12                	push   $0x12
  8017dd:	e8 17 fe ff ff       	call   8015f9 <syscall>
  8017e2:	83 c4 18             	add    $0x18,%esp
	return ;
  8017e5:	90                   	nop
}
  8017e6:	c9                   	leave  
  8017e7:	c3                   	ret    

008017e8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017e8:	55                   	push   %ebp
  8017e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 0e                	push   $0xe
  8017f7:	e8 fd fd ff ff       	call   8015f9 <syscall>
  8017fc:	83 c4 18             	add    $0x18,%esp
}
  8017ff:	c9                   	leave  
  801800:	c3                   	ret    

00801801 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801801:	55                   	push   %ebp
  801802:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	ff 75 08             	pushl  0x8(%ebp)
  80180f:	6a 0f                	push   $0xf
  801811:	e8 e3 fd ff ff       	call   8015f9 <syscall>
  801816:	83 c4 18             	add    $0x18,%esp
}
  801819:	c9                   	leave  
  80181a:	c3                   	ret    

0080181b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80181b:	55                   	push   %ebp
  80181c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 10                	push   $0x10
  80182a:	e8 ca fd ff ff       	call   8015f9 <syscall>
  80182f:	83 c4 18             	add    $0x18,%esp
}
  801832:	90                   	nop
  801833:	c9                   	leave  
  801834:	c3                   	ret    

00801835 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801835:	55                   	push   %ebp
  801836:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	6a 14                	push   $0x14
  801844:	e8 b0 fd ff ff       	call   8015f9 <syscall>
  801849:	83 c4 18             	add    $0x18,%esp
}
  80184c:	90                   	nop
  80184d:	c9                   	leave  
  80184e:	c3                   	ret    

0080184f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80184f:	55                   	push   %ebp
  801850:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	6a 15                	push   $0x15
  80185e:	e8 96 fd ff ff       	call   8015f9 <syscall>
  801863:	83 c4 18             	add    $0x18,%esp
}
  801866:	90                   	nop
  801867:	c9                   	leave  
  801868:	c3                   	ret    

00801869 <sys_cputc>:


void
sys_cputc(const char c)
{
  801869:	55                   	push   %ebp
  80186a:	89 e5                	mov    %esp,%ebp
  80186c:	83 ec 04             	sub    $0x4,%esp
  80186f:	8b 45 08             	mov    0x8(%ebp),%eax
  801872:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801875:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	50                   	push   %eax
  801882:	6a 16                	push   $0x16
  801884:	e8 70 fd ff ff       	call   8015f9 <syscall>
  801889:	83 c4 18             	add    $0x18,%esp
}
  80188c:	90                   	nop
  80188d:	c9                   	leave  
  80188e:	c3                   	ret    

0080188f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80188f:	55                   	push   %ebp
  801890:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 17                	push   $0x17
  80189e:	e8 56 fd ff ff       	call   8015f9 <syscall>
  8018a3:	83 c4 18             	add    $0x18,%esp
}
  8018a6:	90                   	nop
  8018a7:	c9                   	leave  
  8018a8:	c3                   	ret    

008018a9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8018a9:	55                   	push   %ebp
  8018aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8018ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	ff 75 0c             	pushl  0xc(%ebp)
  8018b8:	50                   	push   %eax
  8018b9:	6a 18                	push   $0x18
  8018bb:	e8 39 fd ff ff       	call   8015f9 <syscall>
  8018c0:	83 c4 18             	add    $0x18,%esp
}
  8018c3:	c9                   	leave  
  8018c4:	c3                   	ret    

008018c5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8018c5:	55                   	push   %ebp
  8018c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	52                   	push   %edx
  8018d5:	50                   	push   %eax
  8018d6:	6a 1b                	push   $0x1b
  8018d8:	e8 1c fd ff ff       	call   8015f9 <syscall>
  8018dd:	83 c4 18             	add    $0x18,%esp
}
  8018e0:	c9                   	leave  
  8018e1:	c3                   	ret    

008018e2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018e2:	55                   	push   %ebp
  8018e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	52                   	push   %edx
  8018f2:	50                   	push   %eax
  8018f3:	6a 19                	push   $0x19
  8018f5:	e8 ff fc ff ff       	call   8015f9 <syscall>
  8018fa:	83 c4 18             	add    $0x18,%esp
}
  8018fd:	90                   	nop
  8018fe:	c9                   	leave  
  8018ff:	c3                   	ret    

00801900 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801900:	55                   	push   %ebp
  801901:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801903:	8b 55 0c             	mov    0xc(%ebp),%edx
  801906:	8b 45 08             	mov    0x8(%ebp),%eax
  801909:	6a 00                	push   $0x0
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	52                   	push   %edx
  801910:	50                   	push   %eax
  801911:	6a 1a                	push   $0x1a
  801913:	e8 e1 fc ff ff       	call   8015f9 <syscall>
  801918:	83 c4 18             	add    $0x18,%esp
}
  80191b:	90                   	nop
  80191c:	c9                   	leave  
  80191d:	c3                   	ret    

0080191e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80191e:	55                   	push   %ebp
  80191f:	89 e5                	mov    %esp,%ebp
  801921:	83 ec 04             	sub    $0x4,%esp
  801924:	8b 45 10             	mov    0x10(%ebp),%eax
  801927:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80192a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80192d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801931:	8b 45 08             	mov    0x8(%ebp),%eax
  801934:	6a 00                	push   $0x0
  801936:	51                   	push   %ecx
  801937:	52                   	push   %edx
  801938:	ff 75 0c             	pushl  0xc(%ebp)
  80193b:	50                   	push   %eax
  80193c:	6a 1c                	push   $0x1c
  80193e:	e8 b6 fc ff ff       	call   8015f9 <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
}
  801946:	c9                   	leave  
  801947:	c3                   	ret    

00801948 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801948:	55                   	push   %ebp
  801949:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80194b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80194e:	8b 45 08             	mov    0x8(%ebp),%eax
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	6a 00                	push   $0x0
  801957:	52                   	push   %edx
  801958:	50                   	push   %eax
  801959:	6a 1d                	push   $0x1d
  80195b:	e8 99 fc ff ff       	call   8015f9 <syscall>
  801960:	83 c4 18             	add    $0x18,%esp
}
  801963:	c9                   	leave  
  801964:	c3                   	ret    

00801965 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801965:	55                   	push   %ebp
  801966:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801968:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80196b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80196e:	8b 45 08             	mov    0x8(%ebp),%eax
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	51                   	push   %ecx
  801976:	52                   	push   %edx
  801977:	50                   	push   %eax
  801978:	6a 1e                	push   $0x1e
  80197a:	e8 7a fc ff ff       	call   8015f9 <syscall>
  80197f:	83 c4 18             	add    $0x18,%esp
}
  801982:	c9                   	leave  
  801983:	c3                   	ret    

00801984 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801984:	55                   	push   %ebp
  801985:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801987:	8b 55 0c             	mov    0xc(%ebp),%edx
  80198a:	8b 45 08             	mov    0x8(%ebp),%eax
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	52                   	push   %edx
  801994:	50                   	push   %eax
  801995:	6a 1f                	push   $0x1f
  801997:	e8 5d fc ff ff       	call   8015f9 <syscall>
  80199c:	83 c4 18             	add    $0x18,%esp
}
  80199f:	c9                   	leave  
  8019a0:	c3                   	ret    

008019a1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8019a1:	55                   	push   %ebp
  8019a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 20                	push   $0x20
  8019b0:	e8 44 fc ff ff       	call   8015f9 <syscall>
  8019b5:	83 c4 18             	add    $0x18,%esp
}
  8019b8:	c9                   	leave  
  8019b9:	c3                   	ret    

008019ba <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8019ba:	55                   	push   %ebp
  8019bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8019bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	ff 75 10             	pushl  0x10(%ebp)
  8019c7:	ff 75 0c             	pushl  0xc(%ebp)
  8019ca:	50                   	push   %eax
  8019cb:	6a 21                	push   $0x21
  8019cd:	e8 27 fc ff ff       	call   8015f9 <syscall>
  8019d2:	83 c4 18             	add    $0x18,%esp
}
  8019d5:	c9                   	leave  
  8019d6:	c3                   	ret    

008019d7 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8019d7:	55                   	push   %ebp
  8019d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8019da:	8b 45 08             	mov    0x8(%ebp),%eax
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	50                   	push   %eax
  8019e6:	6a 22                	push   $0x22
  8019e8:	e8 0c fc ff ff       	call   8015f9 <syscall>
  8019ed:	83 c4 18             	add    $0x18,%esp
}
  8019f0:	90                   	nop
  8019f1:	c9                   	leave  
  8019f2:	c3                   	ret    

008019f3 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8019f3:	55                   	push   %ebp
  8019f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8019f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	50                   	push   %eax
  801a02:	6a 23                	push   $0x23
  801a04:	e8 f0 fb ff ff       	call   8015f9 <syscall>
  801a09:	83 c4 18             	add    $0x18,%esp
}
  801a0c:	90                   	nop
  801a0d:	c9                   	leave  
  801a0e:	c3                   	ret    

00801a0f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801a0f:	55                   	push   %ebp
  801a10:	89 e5                	mov    %esp,%ebp
  801a12:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801a15:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a18:	8d 50 04             	lea    0x4(%eax),%edx
  801a1b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	52                   	push   %edx
  801a25:	50                   	push   %eax
  801a26:	6a 24                	push   $0x24
  801a28:	e8 cc fb ff ff       	call   8015f9 <syscall>
  801a2d:	83 c4 18             	add    $0x18,%esp
	return result;
  801a30:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a33:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a36:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a39:	89 01                	mov    %eax,(%ecx)
  801a3b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a41:	c9                   	leave  
  801a42:	c2 04 00             	ret    $0x4

00801a45 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a45:	55                   	push   %ebp
  801a46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	ff 75 10             	pushl  0x10(%ebp)
  801a4f:	ff 75 0c             	pushl  0xc(%ebp)
  801a52:	ff 75 08             	pushl  0x8(%ebp)
  801a55:	6a 13                	push   $0x13
  801a57:	e8 9d fb ff ff       	call   8015f9 <syscall>
  801a5c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a5f:	90                   	nop
}
  801a60:	c9                   	leave  
  801a61:	c3                   	ret    

00801a62 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a62:	55                   	push   %ebp
  801a63:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 25                	push   $0x25
  801a71:	e8 83 fb ff ff       	call   8015f9 <syscall>
  801a76:	83 c4 18             	add    $0x18,%esp
}
  801a79:	c9                   	leave  
  801a7a:	c3                   	ret    

00801a7b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a7b:	55                   	push   %ebp
  801a7c:	89 e5                	mov    %esp,%ebp
  801a7e:	83 ec 04             	sub    $0x4,%esp
  801a81:	8b 45 08             	mov    0x8(%ebp),%eax
  801a84:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a87:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	50                   	push   %eax
  801a94:	6a 26                	push   $0x26
  801a96:	e8 5e fb ff ff       	call   8015f9 <syscall>
  801a9b:	83 c4 18             	add    $0x18,%esp
	return ;
  801a9e:	90                   	nop
}
  801a9f:	c9                   	leave  
  801aa0:	c3                   	ret    

00801aa1 <rsttst>:
void rsttst()
{
  801aa1:	55                   	push   %ebp
  801aa2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 00                	push   $0x0
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 28                	push   $0x28
  801ab0:	e8 44 fb ff ff       	call   8015f9 <syscall>
  801ab5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ab8:	90                   	nop
}
  801ab9:	c9                   	leave  
  801aba:	c3                   	ret    

00801abb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801abb:	55                   	push   %ebp
  801abc:	89 e5                	mov    %esp,%ebp
  801abe:	83 ec 04             	sub    $0x4,%esp
  801ac1:	8b 45 14             	mov    0x14(%ebp),%eax
  801ac4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ac7:	8b 55 18             	mov    0x18(%ebp),%edx
  801aca:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ace:	52                   	push   %edx
  801acf:	50                   	push   %eax
  801ad0:	ff 75 10             	pushl  0x10(%ebp)
  801ad3:	ff 75 0c             	pushl  0xc(%ebp)
  801ad6:	ff 75 08             	pushl  0x8(%ebp)
  801ad9:	6a 27                	push   $0x27
  801adb:	e8 19 fb ff ff       	call   8015f9 <syscall>
  801ae0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ae3:	90                   	nop
}
  801ae4:	c9                   	leave  
  801ae5:	c3                   	ret    

00801ae6 <chktst>:
void chktst(uint32 n)
{
  801ae6:	55                   	push   %ebp
  801ae7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	ff 75 08             	pushl  0x8(%ebp)
  801af4:	6a 29                	push   $0x29
  801af6:	e8 fe fa ff ff       	call   8015f9 <syscall>
  801afb:	83 c4 18             	add    $0x18,%esp
	return ;
  801afe:	90                   	nop
}
  801aff:	c9                   	leave  
  801b00:	c3                   	ret    

00801b01 <inctst>:

void inctst()
{
  801b01:	55                   	push   %ebp
  801b02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801b04:	6a 00                	push   $0x0
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 00                	push   $0x0
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 2a                	push   $0x2a
  801b10:	e8 e4 fa ff ff       	call   8015f9 <syscall>
  801b15:	83 c4 18             	add    $0x18,%esp
	return ;
  801b18:	90                   	nop
}
  801b19:	c9                   	leave  
  801b1a:	c3                   	ret    

00801b1b <gettst>:
uint32 gettst()
{
  801b1b:	55                   	push   %ebp
  801b1c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	6a 2b                	push   $0x2b
  801b2a:	e8 ca fa ff ff       	call   8015f9 <syscall>
  801b2f:	83 c4 18             	add    $0x18,%esp
}
  801b32:	c9                   	leave  
  801b33:	c3                   	ret    

00801b34 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b34:	55                   	push   %ebp
  801b35:	89 e5                	mov    %esp,%ebp
  801b37:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 00                	push   $0x0
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	6a 2c                	push   $0x2c
  801b46:	e8 ae fa ff ff       	call   8015f9 <syscall>
  801b4b:	83 c4 18             	add    $0x18,%esp
  801b4e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b51:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b55:	75 07                	jne    801b5e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b57:	b8 01 00 00 00       	mov    $0x1,%eax
  801b5c:	eb 05                	jmp    801b63 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b5e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b63:	c9                   	leave  
  801b64:	c3                   	ret    

00801b65 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b65:	55                   	push   %ebp
  801b66:	89 e5                	mov    %esp,%ebp
  801b68:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	6a 00                	push   $0x0
  801b75:	6a 2c                	push   $0x2c
  801b77:	e8 7d fa ff ff       	call   8015f9 <syscall>
  801b7c:	83 c4 18             	add    $0x18,%esp
  801b7f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b82:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b86:	75 07                	jne    801b8f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b88:	b8 01 00 00 00       	mov    $0x1,%eax
  801b8d:	eb 05                	jmp    801b94 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b8f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b94:	c9                   	leave  
  801b95:	c3                   	ret    

00801b96 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b96:	55                   	push   %ebp
  801b97:	89 e5                	mov    %esp,%ebp
  801b99:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 2c                	push   $0x2c
  801ba8:	e8 4c fa ff ff       	call   8015f9 <syscall>
  801bad:	83 c4 18             	add    $0x18,%esp
  801bb0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801bb3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801bb7:	75 07                	jne    801bc0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801bb9:	b8 01 00 00 00       	mov    $0x1,%eax
  801bbe:	eb 05                	jmp    801bc5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801bc0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bc5:	c9                   	leave  
  801bc6:	c3                   	ret    

00801bc7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801bc7:	55                   	push   %ebp
  801bc8:	89 e5                	mov    %esp,%ebp
  801bca:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bcd:	6a 00                	push   $0x0
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	6a 2c                	push   $0x2c
  801bd9:	e8 1b fa ff ff       	call   8015f9 <syscall>
  801bde:	83 c4 18             	add    $0x18,%esp
  801be1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801be4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801be8:	75 07                	jne    801bf1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801bea:	b8 01 00 00 00       	mov    $0x1,%eax
  801bef:	eb 05                	jmp    801bf6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801bf1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bf6:	c9                   	leave  
  801bf7:	c3                   	ret    

00801bf8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801bf8:	55                   	push   %ebp
  801bf9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	ff 75 08             	pushl  0x8(%ebp)
  801c06:	6a 2d                	push   $0x2d
  801c08:	e8 ec f9 ff ff       	call   8015f9 <syscall>
  801c0d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c10:	90                   	nop
}
  801c11:	c9                   	leave  
  801c12:	c3                   	ret    
  801c13:	90                   	nop

00801c14 <__udivdi3>:
  801c14:	55                   	push   %ebp
  801c15:	57                   	push   %edi
  801c16:	56                   	push   %esi
  801c17:	53                   	push   %ebx
  801c18:	83 ec 1c             	sub    $0x1c,%esp
  801c1b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c1f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c23:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c27:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c2b:	89 ca                	mov    %ecx,%edx
  801c2d:	89 f8                	mov    %edi,%eax
  801c2f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c33:	85 f6                	test   %esi,%esi
  801c35:	75 2d                	jne    801c64 <__udivdi3+0x50>
  801c37:	39 cf                	cmp    %ecx,%edi
  801c39:	77 65                	ja     801ca0 <__udivdi3+0x8c>
  801c3b:	89 fd                	mov    %edi,%ebp
  801c3d:	85 ff                	test   %edi,%edi
  801c3f:	75 0b                	jne    801c4c <__udivdi3+0x38>
  801c41:	b8 01 00 00 00       	mov    $0x1,%eax
  801c46:	31 d2                	xor    %edx,%edx
  801c48:	f7 f7                	div    %edi
  801c4a:	89 c5                	mov    %eax,%ebp
  801c4c:	31 d2                	xor    %edx,%edx
  801c4e:	89 c8                	mov    %ecx,%eax
  801c50:	f7 f5                	div    %ebp
  801c52:	89 c1                	mov    %eax,%ecx
  801c54:	89 d8                	mov    %ebx,%eax
  801c56:	f7 f5                	div    %ebp
  801c58:	89 cf                	mov    %ecx,%edi
  801c5a:	89 fa                	mov    %edi,%edx
  801c5c:	83 c4 1c             	add    $0x1c,%esp
  801c5f:	5b                   	pop    %ebx
  801c60:	5e                   	pop    %esi
  801c61:	5f                   	pop    %edi
  801c62:	5d                   	pop    %ebp
  801c63:	c3                   	ret    
  801c64:	39 ce                	cmp    %ecx,%esi
  801c66:	77 28                	ja     801c90 <__udivdi3+0x7c>
  801c68:	0f bd fe             	bsr    %esi,%edi
  801c6b:	83 f7 1f             	xor    $0x1f,%edi
  801c6e:	75 40                	jne    801cb0 <__udivdi3+0x9c>
  801c70:	39 ce                	cmp    %ecx,%esi
  801c72:	72 0a                	jb     801c7e <__udivdi3+0x6a>
  801c74:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c78:	0f 87 9e 00 00 00    	ja     801d1c <__udivdi3+0x108>
  801c7e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c83:	89 fa                	mov    %edi,%edx
  801c85:	83 c4 1c             	add    $0x1c,%esp
  801c88:	5b                   	pop    %ebx
  801c89:	5e                   	pop    %esi
  801c8a:	5f                   	pop    %edi
  801c8b:	5d                   	pop    %ebp
  801c8c:	c3                   	ret    
  801c8d:	8d 76 00             	lea    0x0(%esi),%esi
  801c90:	31 ff                	xor    %edi,%edi
  801c92:	31 c0                	xor    %eax,%eax
  801c94:	89 fa                	mov    %edi,%edx
  801c96:	83 c4 1c             	add    $0x1c,%esp
  801c99:	5b                   	pop    %ebx
  801c9a:	5e                   	pop    %esi
  801c9b:	5f                   	pop    %edi
  801c9c:	5d                   	pop    %ebp
  801c9d:	c3                   	ret    
  801c9e:	66 90                	xchg   %ax,%ax
  801ca0:	89 d8                	mov    %ebx,%eax
  801ca2:	f7 f7                	div    %edi
  801ca4:	31 ff                	xor    %edi,%edi
  801ca6:	89 fa                	mov    %edi,%edx
  801ca8:	83 c4 1c             	add    $0x1c,%esp
  801cab:	5b                   	pop    %ebx
  801cac:	5e                   	pop    %esi
  801cad:	5f                   	pop    %edi
  801cae:	5d                   	pop    %ebp
  801caf:	c3                   	ret    
  801cb0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801cb5:	89 eb                	mov    %ebp,%ebx
  801cb7:	29 fb                	sub    %edi,%ebx
  801cb9:	89 f9                	mov    %edi,%ecx
  801cbb:	d3 e6                	shl    %cl,%esi
  801cbd:	89 c5                	mov    %eax,%ebp
  801cbf:	88 d9                	mov    %bl,%cl
  801cc1:	d3 ed                	shr    %cl,%ebp
  801cc3:	89 e9                	mov    %ebp,%ecx
  801cc5:	09 f1                	or     %esi,%ecx
  801cc7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ccb:	89 f9                	mov    %edi,%ecx
  801ccd:	d3 e0                	shl    %cl,%eax
  801ccf:	89 c5                	mov    %eax,%ebp
  801cd1:	89 d6                	mov    %edx,%esi
  801cd3:	88 d9                	mov    %bl,%cl
  801cd5:	d3 ee                	shr    %cl,%esi
  801cd7:	89 f9                	mov    %edi,%ecx
  801cd9:	d3 e2                	shl    %cl,%edx
  801cdb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cdf:	88 d9                	mov    %bl,%cl
  801ce1:	d3 e8                	shr    %cl,%eax
  801ce3:	09 c2                	or     %eax,%edx
  801ce5:	89 d0                	mov    %edx,%eax
  801ce7:	89 f2                	mov    %esi,%edx
  801ce9:	f7 74 24 0c          	divl   0xc(%esp)
  801ced:	89 d6                	mov    %edx,%esi
  801cef:	89 c3                	mov    %eax,%ebx
  801cf1:	f7 e5                	mul    %ebp
  801cf3:	39 d6                	cmp    %edx,%esi
  801cf5:	72 19                	jb     801d10 <__udivdi3+0xfc>
  801cf7:	74 0b                	je     801d04 <__udivdi3+0xf0>
  801cf9:	89 d8                	mov    %ebx,%eax
  801cfb:	31 ff                	xor    %edi,%edi
  801cfd:	e9 58 ff ff ff       	jmp    801c5a <__udivdi3+0x46>
  801d02:	66 90                	xchg   %ax,%ax
  801d04:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d08:	89 f9                	mov    %edi,%ecx
  801d0a:	d3 e2                	shl    %cl,%edx
  801d0c:	39 c2                	cmp    %eax,%edx
  801d0e:	73 e9                	jae    801cf9 <__udivdi3+0xe5>
  801d10:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d13:	31 ff                	xor    %edi,%edi
  801d15:	e9 40 ff ff ff       	jmp    801c5a <__udivdi3+0x46>
  801d1a:	66 90                	xchg   %ax,%ax
  801d1c:	31 c0                	xor    %eax,%eax
  801d1e:	e9 37 ff ff ff       	jmp    801c5a <__udivdi3+0x46>
  801d23:	90                   	nop

00801d24 <__umoddi3>:
  801d24:	55                   	push   %ebp
  801d25:	57                   	push   %edi
  801d26:	56                   	push   %esi
  801d27:	53                   	push   %ebx
  801d28:	83 ec 1c             	sub    $0x1c,%esp
  801d2b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d2f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d33:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d37:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d3b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d3f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d43:	89 f3                	mov    %esi,%ebx
  801d45:	89 fa                	mov    %edi,%edx
  801d47:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d4b:	89 34 24             	mov    %esi,(%esp)
  801d4e:	85 c0                	test   %eax,%eax
  801d50:	75 1a                	jne    801d6c <__umoddi3+0x48>
  801d52:	39 f7                	cmp    %esi,%edi
  801d54:	0f 86 a2 00 00 00    	jbe    801dfc <__umoddi3+0xd8>
  801d5a:	89 c8                	mov    %ecx,%eax
  801d5c:	89 f2                	mov    %esi,%edx
  801d5e:	f7 f7                	div    %edi
  801d60:	89 d0                	mov    %edx,%eax
  801d62:	31 d2                	xor    %edx,%edx
  801d64:	83 c4 1c             	add    $0x1c,%esp
  801d67:	5b                   	pop    %ebx
  801d68:	5e                   	pop    %esi
  801d69:	5f                   	pop    %edi
  801d6a:	5d                   	pop    %ebp
  801d6b:	c3                   	ret    
  801d6c:	39 f0                	cmp    %esi,%eax
  801d6e:	0f 87 ac 00 00 00    	ja     801e20 <__umoddi3+0xfc>
  801d74:	0f bd e8             	bsr    %eax,%ebp
  801d77:	83 f5 1f             	xor    $0x1f,%ebp
  801d7a:	0f 84 ac 00 00 00    	je     801e2c <__umoddi3+0x108>
  801d80:	bf 20 00 00 00       	mov    $0x20,%edi
  801d85:	29 ef                	sub    %ebp,%edi
  801d87:	89 fe                	mov    %edi,%esi
  801d89:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d8d:	89 e9                	mov    %ebp,%ecx
  801d8f:	d3 e0                	shl    %cl,%eax
  801d91:	89 d7                	mov    %edx,%edi
  801d93:	89 f1                	mov    %esi,%ecx
  801d95:	d3 ef                	shr    %cl,%edi
  801d97:	09 c7                	or     %eax,%edi
  801d99:	89 e9                	mov    %ebp,%ecx
  801d9b:	d3 e2                	shl    %cl,%edx
  801d9d:	89 14 24             	mov    %edx,(%esp)
  801da0:	89 d8                	mov    %ebx,%eax
  801da2:	d3 e0                	shl    %cl,%eax
  801da4:	89 c2                	mov    %eax,%edx
  801da6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801daa:	d3 e0                	shl    %cl,%eax
  801dac:	89 44 24 04          	mov    %eax,0x4(%esp)
  801db0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801db4:	89 f1                	mov    %esi,%ecx
  801db6:	d3 e8                	shr    %cl,%eax
  801db8:	09 d0                	or     %edx,%eax
  801dba:	d3 eb                	shr    %cl,%ebx
  801dbc:	89 da                	mov    %ebx,%edx
  801dbe:	f7 f7                	div    %edi
  801dc0:	89 d3                	mov    %edx,%ebx
  801dc2:	f7 24 24             	mull   (%esp)
  801dc5:	89 c6                	mov    %eax,%esi
  801dc7:	89 d1                	mov    %edx,%ecx
  801dc9:	39 d3                	cmp    %edx,%ebx
  801dcb:	0f 82 87 00 00 00    	jb     801e58 <__umoddi3+0x134>
  801dd1:	0f 84 91 00 00 00    	je     801e68 <__umoddi3+0x144>
  801dd7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ddb:	29 f2                	sub    %esi,%edx
  801ddd:	19 cb                	sbb    %ecx,%ebx
  801ddf:	89 d8                	mov    %ebx,%eax
  801de1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801de5:	d3 e0                	shl    %cl,%eax
  801de7:	89 e9                	mov    %ebp,%ecx
  801de9:	d3 ea                	shr    %cl,%edx
  801deb:	09 d0                	or     %edx,%eax
  801ded:	89 e9                	mov    %ebp,%ecx
  801def:	d3 eb                	shr    %cl,%ebx
  801df1:	89 da                	mov    %ebx,%edx
  801df3:	83 c4 1c             	add    $0x1c,%esp
  801df6:	5b                   	pop    %ebx
  801df7:	5e                   	pop    %esi
  801df8:	5f                   	pop    %edi
  801df9:	5d                   	pop    %ebp
  801dfa:	c3                   	ret    
  801dfb:	90                   	nop
  801dfc:	89 fd                	mov    %edi,%ebp
  801dfe:	85 ff                	test   %edi,%edi
  801e00:	75 0b                	jne    801e0d <__umoddi3+0xe9>
  801e02:	b8 01 00 00 00       	mov    $0x1,%eax
  801e07:	31 d2                	xor    %edx,%edx
  801e09:	f7 f7                	div    %edi
  801e0b:	89 c5                	mov    %eax,%ebp
  801e0d:	89 f0                	mov    %esi,%eax
  801e0f:	31 d2                	xor    %edx,%edx
  801e11:	f7 f5                	div    %ebp
  801e13:	89 c8                	mov    %ecx,%eax
  801e15:	f7 f5                	div    %ebp
  801e17:	89 d0                	mov    %edx,%eax
  801e19:	e9 44 ff ff ff       	jmp    801d62 <__umoddi3+0x3e>
  801e1e:	66 90                	xchg   %ax,%ax
  801e20:	89 c8                	mov    %ecx,%eax
  801e22:	89 f2                	mov    %esi,%edx
  801e24:	83 c4 1c             	add    $0x1c,%esp
  801e27:	5b                   	pop    %ebx
  801e28:	5e                   	pop    %esi
  801e29:	5f                   	pop    %edi
  801e2a:	5d                   	pop    %ebp
  801e2b:	c3                   	ret    
  801e2c:	3b 04 24             	cmp    (%esp),%eax
  801e2f:	72 06                	jb     801e37 <__umoddi3+0x113>
  801e31:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e35:	77 0f                	ja     801e46 <__umoddi3+0x122>
  801e37:	89 f2                	mov    %esi,%edx
  801e39:	29 f9                	sub    %edi,%ecx
  801e3b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e3f:	89 14 24             	mov    %edx,(%esp)
  801e42:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e46:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e4a:	8b 14 24             	mov    (%esp),%edx
  801e4d:	83 c4 1c             	add    $0x1c,%esp
  801e50:	5b                   	pop    %ebx
  801e51:	5e                   	pop    %esi
  801e52:	5f                   	pop    %edi
  801e53:	5d                   	pop    %ebp
  801e54:	c3                   	ret    
  801e55:	8d 76 00             	lea    0x0(%esi),%esi
  801e58:	2b 04 24             	sub    (%esp),%eax
  801e5b:	19 fa                	sbb    %edi,%edx
  801e5d:	89 d1                	mov    %edx,%ecx
  801e5f:	89 c6                	mov    %eax,%esi
  801e61:	e9 71 ff ff ff       	jmp    801dd7 <__umoddi3+0xb3>
  801e66:	66 90                	xchg   %ax,%ax
  801e68:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e6c:	72 ea                	jb     801e58 <__umoddi3+0x134>
  801e6e:	89 d9                	mov    %ebx,%ecx
  801e70:	e9 62 ff ff ff       	jmp    801dd7 <__umoddi3+0xb3>
