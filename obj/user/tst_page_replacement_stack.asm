
obj/user/tst_page_replacement_stack:     file format elf32-i386


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
  800031:	e8 f9 00 00 00       	call   80012f <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 14 a0 00 00    	sub    $0xa014,%esp
	char arr[PAGE_SIZE*10];

	uint32 kilo = 1024;
  800042:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)

//	cprintf("envID = %d\n",envID);

	int freePages = sys_calculate_free_frames();
  800049:	e8 8d 13 00 00       	call   8013db <sys_calculate_free_frames>
  80004e:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  800051:	e8 08 14 00 00       	call   80145e <sys_pf_calculate_allocated_pages>
  800056:	89 45 e8             	mov    %eax,-0x18(%ebp)

	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800059:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800060:	eb 15                	jmp    800077 <_main+0x3f>
		arr[i] = -1 ;
  800062:	8d 95 e8 5f ff ff    	lea    -0xa018(%ebp),%edx
  800068:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80006b:	01 d0                	add    %edx,%eax
  80006d:	c6 00 ff             	movb   $0xff,(%eax)

	int freePages = sys_calculate_free_frames();
	int usedDiskPages = sys_pf_calculate_allocated_pages();

	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800070:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800077:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  80007e:	7e e2                	jle    800062 <_main+0x2a>
		arr[i] = -1 ;


	cprintf("checking REPLACEMENT fault handling of STACK pages... \n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 00 1b 80 00       	push   $0x801b00
  800088:	e8 58 04 00 00       	call   8004e5 <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800090:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800097:	eb 2c                	jmp    8000c5 <_main+0x8d>
			if( arr[i] != -1) panic("modified stack page(s) not restored correctly");
  800099:	8d 95 e8 5f ff ff    	lea    -0xa018(%ebp),%edx
  80009f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000a2:	01 d0                	add    %edx,%eax
  8000a4:	8a 00                	mov    (%eax),%al
  8000a6:	3c ff                	cmp    $0xff,%al
  8000a8:	74 14                	je     8000be <_main+0x86>
  8000aa:	83 ec 04             	sub    $0x4,%esp
  8000ad:	68 38 1b 80 00       	push   $0x801b38
  8000b2:	6a 1a                	push   $0x1a
  8000b4:	68 68 1b 80 00       	push   $0x801b68
  8000b9:	e8 73 01 00 00       	call   800231 <_panic>
		arr[i] = -1 ;


	cprintf("checking REPLACEMENT fault handling of STACK pages... \n");
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8000be:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8000c5:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  8000cc:	7e cb                	jle    800099 <_main+0x61>
			if( arr[i] != -1) panic("modified stack page(s) not restored correctly");

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  9) panic("Unexpected extra/less pages have been added to page file");
  8000ce:	e8 8b 13 00 00       	call   80145e <sys_pf_calculate_allocated_pages>
  8000d3:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000d6:	83 f8 09             	cmp    $0x9,%eax
  8000d9:	74 14                	je     8000ef <_main+0xb7>
  8000db:	83 ec 04             	sub    $0x4,%esp
  8000de:	68 8c 1b 80 00       	push   $0x801b8c
  8000e3:	6a 1c                	push   $0x1c
  8000e5:	68 68 1b 80 00       	push   $0x801b68
  8000ea:	e8 42 01 00 00       	call   800231 <_panic>

		if( (freePages - (sys_calculate_free_frames() + sys_calculate_modified_frames())) != 0 ) panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  8000ef:	e8 e7 12 00 00       	call   8013db <sys_calculate_free_frames>
  8000f4:	89 c3                	mov    %eax,%ebx
  8000f6:	e8 f9 12 00 00       	call   8013f4 <sys_calculate_modified_frames>
  8000fb:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  8000fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800101:	39 c2                	cmp    %eax,%edx
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 c8 1b 80 00       	push   $0x801bc8
  80010d:	6a 1e                	push   $0x1e
  80010f:	68 68 1b 80 00       	push   $0x801b68
  800114:	e8 18 01 00 00       	call   800231 <_panic>
	}

	cprintf("Congratulations: stack pages created, modified and read successfully!\n\n");
  800119:	83 ec 0c             	sub    $0xc,%esp
  80011c:	68 2c 1c 80 00       	push   $0x801c2c
  800121:	e8 bf 03 00 00       	call   8004e5 <cprintf>
  800126:	83 c4 10             	add    $0x10,%esp


	return;
  800129:	90                   	nop
}
  80012a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80012d:	c9                   	leave  
  80012e:	c3                   	ret    

0080012f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80012f:	55                   	push   %ebp
  800130:	89 e5                	mov    %esp,%ebp
  800132:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800135:	e8 d6 11 00 00       	call   801310 <sys_getenvindex>
  80013a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80013d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800140:	89 d0                	mov    %edx,%eax
  800142:	01 c0                	add    %eax,%eax
  800144:	01 d0                	add    %edx,%eax
  800146:	c1 e0 02             	shl    $0x2,%eax
  800149:	01 d0                	add    %edx,%eax
  80014b:	c1 e0 06             	shl    $0x6,%eax
  80014e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800153:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800158:	a1 04 30 80 00       	mov    0x803004,%eax
  80015d:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800163:	84 c0                	test   %al,%al
  800165:	74 0f                	je     800176 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800167:	a1 04 30 80 00       	mov    0x803004,%eax
  80016c:	05 f4 02 00 00       	add    $0x2f4,%eax
  800171:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800176:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80017a:	7e 0a                	jle    800186 <libmain+0x57>
		binaryname = argv[0];
  80017c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80017f:	8b 00                	mov    (%eax),%eax
  800181:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800186:	83 ec 08             	sub    $0x8,%esp
  800189:	ff 75 0c             	pushl  0xc(%ebp)
  80018c:	ff 75 08             	pushl  0x8(%ebp)
  80018f:	e8 a4 fe ff ff       	call   800038 <_main>
  800194:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800197:	e8 0f 13 00 00       	call   8014ab <sys_disable_interrupt>
	cprintf("**************************************\n");
  80019c:	83 ec 0c             	sub    $0xc,%esp
  80019f:	68 8c 1c 80 00       	push   $0x801c8c
  8001a4:	e8 3c 03 00 00       	call   8004e5 <cprintf>
  8001a9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001ac:	a1 04 30 80 00       	mov    0x803004,%eax
  8001b1:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001b7:	a1 04 30 80 00       	mov    0x803004,%eax
  8001bc:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001c2:	83 ec 04             	sub    $0x4,%esp
  8001c5:	52                   	push   %edx
  8001c6:	50                   	push   %eax
  8001c7:	68 b4 1c 80 00       	push   $0x801cb4
  8001cc:	e8 14 03 00 00       	call   8004e5 <cprintf>
  8001d1:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001d4:	a1 04 30 80 00       	mov    0x803004,%eax
  8001d9:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8001df:	83 ec 08             	sub    $0x8,%esp
  8001e2:	50                   	push   %eax
  8001e3:	68 d9 1c 80 00       	push   $0x801cd9
  8001e8:	e8 f8 02 00 00       	call   8004e5 <cprintf>
  8001ed:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001f0:	83 ec 0c             	sub    $0xc,%esp
  8001f3:	68 8c 1c 80 00       	push   $0x801c8c
  8001f8:	e8 e8 02 00 00       	call   8004e5 <cprintf>
  8001fd:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800200:	e8 c0 12 00 00       	call   8014c5 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800205:	e8 19 00 00 00       	call   800223 <exit>
}
  80020a:	90                   	nop
  80020b:	c9                   	leave  
  80020c:	c3                   	ret    

0080020d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80020d:	55                   	push   %ebp
  80020e:	89 e5                	mov    %esp,%ebp
  800210:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800213:	83 ec 0c             	sub    $0xc,%esp
  800216:	6a 00                	push   $0x0
  800218:	e8 bf 10 00 00       	call   8012dc <sys_env_destroy>
  80021d:	83 c4 10             	add    $0x10,%esp
}
  800220:	90                   	nop
  800221:	c9                   	leave  
  800222:	c3                   	ret    

00800223 <exit>:

void
exit(void)
{
  800223:	55                   	push   %ebp
  800224:	89 e5                	mov    %esp,%ebp
  800226:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800229:	e8 14 11 00 00       	call   801342 <sys_env_exit>
}
  80022e:	90                   	nop
  80022f:	c9                   	leave  
  800230:	c3                   	ret    

00800231 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800231:	55                   	push   %ebp
  800232:	89 e5                	mov    %esp,%ebp
  800234:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800237:	8d 45 10             	lea    0x10(%ebp),%eax
  80023a:	83 c0 04             	add    $0x4,%eax
  80023d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800240:	a1 14 30 80 00       	mov    0x803014,%eax
  800245:	85 c0                	test   %eax,%eax
  800247:	74 16                	je     80025f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800249:	a1 14 30 80 00       	mov    0x803014,%eax
  80024e:	83 ec 08             	sub    $0x8,%esp
  800251:	50                   	push   %eax
  800252:	68 f0 1c 80 00       	push   $0x801cf0
  800257:	e8 89 02 00 00       	call   8004e5 <cprintf>
  80025c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80025f:	a1 00 30 80 00       	mov    0x803000,%eax
  800264:	ff 75 0c             	pushl  0xc(%ebp)
  800267:	ff 75 08             	pushl  0x8(%ebp)
  80026a:	50                   	push   %eax
  80026b:	68 f5 1c 80 00       	push   $0x801cf5
  800270:	e8 70 02 00 00       	call   8004e5 <cprintf>
  800275:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800278:	8b 45 10             	mov    0x10(%ebp),%eax
  80027b:	83 ec 08             	sub    $0x8,%esp
  80027e:	ff 75 f4             	pushl  -0xc(%ebp)
  800281:	50                   	push   %eax
  800282:	e8 f3 01 00 00       	call   80047a <vcprintf>
  800287:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80028a:	83 ec 08             	sub    $0x8,%esp
  80028d:	6a 00                	push   $0x0
  80028f:	68 11 1d 80 00       	push   $0x801d11
  800294:	e8 e1 01 00 00       	call   80047a <vcprintf>
  800299:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80029c:	e8 82 ff ff ff       	call   800223 <exit>

	// should not return here
	while (1) ;
  8002a1:	eb fe                	jmp    8002a1 <_panic+0x70>

008002a3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002a3:	55                   	push   %ebp
  8002a4:	89 e5                	mov    %esp,%ebp
  8002a6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002a9:	a1 04 30 80 00       	mov    0x803004,%eax
  8002ae:	8b 50 74             	mov    0x74(%eax),%edx
  8002b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002b4:	39 c2                	cmp    %eax,%edx
  8002b6:	74 14                	je     8002cc <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002b8:	83 ec 04             	sub    $0x4,%esp
  8002bb:	68 14 1d 80 00       	push   $0x801d14
  8002c0:	6a 26                	push   $0x26
  8002c2:	68 60 1d 80 00       	push   $0x801d60
  8002c7:	e8 65 ff ff ff       	call   800231 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002da:	e9 c2 00 00 00       	jmp    8003a1 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8002df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ec:	01 d0                	add    %edx,%eax
  8002ee:	8b 00                	mov    (%eax),%eax
  8002f0:	85 c0                	test   %eax,%eax
  8002f2:	75 08                	jne    8002fc <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8002f4:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8002f7:	e9 a2 00 00 00       	jmp    80039e <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8002fc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800303:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80030a:	eb 69                	jmp    800375 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80030c:	a1 04 30 80 00       	mov    0x803004,%eax
  800311:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800317:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80031a:	89 d0                	mov    %edx,%eax
  80031c:	01 c0                	add    %eax,%eax
  80031e:	01 d0                	add    %edx,%eax
  800320:	c1 e0 02             	shl    $0x2,%eax
  800323:	01 c8                	add    %ecx,%eax
  800325:	8a 40 04             	mov    0x4(%eax),%al
  800328:	84 c0                	test   %al,%al
  80032a:	75 46                	jne    800372 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80032c:	a1 04 30 80 00       	mov    0x803004,%eax
  800331:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800337:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80033a:	89 d0                	mov    %edx,%eax
  80033c:	01 c0                	add    %eax,%eax
  80033e:	01 d0                	add    %edx,%eax
  800340:	c1 e0 02             	shl    $0x2,%eax
  800343:	01 c8                	add    %ecx,%eax
  800345:	8b 00                	mov    (%eax),%eax
  800347:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80034a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80034d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800352:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800354:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800357:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035e:	8b 45 08             	mov    0x8(%ebp),%eax
  800361:	01 c8                	add    %ecx,%eax
  800363:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800365:	39 c2                	cmp    %eax,%edx
  800367:	75 09                	jne    800372 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800369:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800370:	eb 12                	jmp    800384 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800372:	ff 45 e8             	incl   -0x18(%ebp)
  800375:	a1 04 30 80 00       	mov    0x803004,%eax
  80037a:	8b 50 74             	mov    0x74(%eax),%edx
  80037d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800380:	39 c2                	cmp    %eax,%edx
  800382:	77 88                	ja     80030c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800384:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800388:	75 14                	jne    80039e <CheckWSWithoutLastIndex+0xfb>
			panic(
  80038a:	83 ec 04             	sub    $0x4,%esp
  80038d:	68 6c 1d 80 00       	push   $0x801d6c
  800392:	6a 3a                	push   $0x3a
  800394:	68 60 1d 80 00       	push   $0x801d60
  800399:	e8 93 fe ff ff       	call   800231 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80039e:	ff 45 f0             	incl   -0x10(%ebp)
  8003a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003a7:	0f 8c 32 ff ff ff    	jl     8002df <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003b4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003bb:	eb 26                	jmp    8003e3 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003bd:	a1 04 30 80 00       	mov    0x803004,%eax
  8003c2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003c8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003cb:	89 d0                	mov    %edx,%eax
  8003cd:	01 c0                	add    %eax,%eax
  8003cf:	01 d0                	add    %edx,%eax
  8003d1:	c1 e0 02             	shl    $0x2,%eax
  8003d4:	01 c8                	add    %ecx,%eax
  8003d6:	8a 40 04             	mov    0x4(%eax),%al
  8003d9:	3c 01                	cmp    $0x1,%al
  8003db:	75 03                	jne    8003e0 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8003dd:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003e0:	ff 45 e0             	incl   -0x20(%ebp)
  8003e3:	a1 04 30 80 00       	mov    0x803004,%eax
  8003e8:	8b 50 74             	mov    0x74(%eax),%edx
  8003eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003ee:	39 c2                	cmp    %eax,%edx
  8003f0:	77 cb                	ja     8003bd <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8003f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003f5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8003f8:	74 14                	je     80040e <CheckWSWithoutLastIndex+0x16b>
		panic(
  8003fa:	83 ec 04             	sub    $0x4,%esp
  8003fd:	68 c0 1d 80 00       	push   $0x801dc0
  800402:	6a 44                	push   $0x44
  800404:	68 60 1d 80 00       	push   $0x801d60
  800409:	e8 23 fe ff ff       	call   800231 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80040e:	90                   	nop
  80040f:	c9                   	leave  
  800410:	c3                   	ret    

00800411 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800411:	55                   	push   %ebp
  800412:	89 e5                	mov    %esp,%ebp
  800414:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800417:	8b 45 0c             	mov    0xc(%ebp),%eax
  80041a:	8b 00                	mov    (%eax),%eax
  80041c:	8d 48 01             	lea    0x1(%eax),%ecx
  80041f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800422:	89 0a                	mov    %ecx,(%edx)
  800424:	8b 55 08             	mov    0x8(%ebp),%edx
  800427:	88 d1                	mov    %dl,%cl
  800429:	8b 55 0c             	mov    0xc(%ebp),%edx
  80042c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800430:	8b 45 0c             	mov    0xc(%ebp),%eax
  800433:	8b 00                	mov    (%eax),%eax
  800435:	3d ff 00 00 00       	cmp    $0xff,%eax
  80043a:	75 2c                	jne    800468 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80043c:	a0 08 30 80 00       	mov    0x803008,%al
  800441:	0f b6 c0             	movzbl %al,%eax
  800444:	8b 55 0c             	mov    0xc(%ebp),%edx
  800447:	8b 12                	mov    (%edx),%edx
  800449:	89 d1                	mov    %edx,%ecx
  80044b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80044e:	83 c2 08             	add    $0x8,%edx
  800451:	83 ec 04             	sub    $0x4,%esp
  800454:	50                   	push   %eax
  800455:	51                   	push   %ecx
  800456:	52                   	push   %edx
  800457:	e8 3e 0e 00 00       	call   80129a <sys_cputs>
  80045c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80045f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800462:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800468:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046b:	8b 40 04             	mov    0x4(%eax),%eax
  80046e:	8d 50 01             	lea    0x1(%eax),%edx
  800471:	8b 45 0c             	mov    0xc(%ebp),%eax
  800474:	89 50 04             	mov    %edx,0x4(%eax)
}
  800477:	90                   	nop
  800478:	c9                   	leave  
  800479:	c3                   	ret    

0080047a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80047a:	55                   	push   %ebp
  80047b:	89 e5                	mov    %esp,%ebp
  80047d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800483:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80048a:	00 00 00 
	b.cnt = 0;
  80048d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800494:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800497:	ff 75 0c             	pushl  0xc(%ebp)
  80049a:	ff 75 08             	pushl  0x8(%ebp)
  80049d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004a3:	50                   	push   %eax
  8004a4:	68 11 04 80 00       	push   $0x800411
  8004a9:	e8 11 02 00 00       	call   8006bf <vprintfmt>
  8004ae:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004b1:	a0 08 30 80 00       	mov    0x803008,%al
  8004b6:	0f b6 c0             	movzbl %al,%eax
  8004b9:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004bf:	83 ec 04             	sub    $0x4,%esp
  8004c2:	50                   	push   %eax
  8004c3:	52                   	push   %edx
  8004c4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004ca:	83 c0 08             	add    $0x8,%eax
  8004cd:	50                   	push   %eax
  8004ce:	e8 c7 0d 00 00       	call   80129a <sys_cputs>
  8004d3:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004d6:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  8004dd:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004e3:	c9                   	leave  
  8004e4:	c3                   	ret    

008004e5 <cprintf>:

int cprintf(const char *fmt, ...) {
  8004e5:	55                   	push   %ebp
  8004e6:	89 e5                	mov    %esp,%ebp
  8004e8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004eb:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  8004f2:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fb:	83 ec 08             	sub    $0x8,%esp
  8004fe:	ff 75 f4             	pushl  -0xc(%ebp)
  800501:	50                   	push   %eax
  800502:	e8 73 ff ff ff       	call   80047a <vcprintf>
  800507:	83 c4 10             	add    $0x10,%esp
  80050a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80050d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800510:	c9                   	leave  
  800511:	c3                   	ret    

00800512 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800512:	55                   	push   %ebp
  800513:	89 e5                	mov    %esp,%ebp
  800515:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800518:	e8 8e 0f 00 00       	call   8014ab <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80051d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800520:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800523:	8b 45 08             	mov    0x8(%ebp),%eax
  800526:	83 ec 08             	sub    $0x8,%esp
  800529:	ff 75 f4             	pushl  -0xc(%ebp)
  80052c:	50                   	push   %eax
  80052d:	e8 48 ff ff ff       	call   80047a <vcprintf>
  800532:	83 c4 10             	add    $0x10,%esp
  800535:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800538:	e8 88 0f 00 00       	call   8014c5 <sys_enable_interrupt>
	return cnt;
  80053d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800540:	c9                   	leave  
  800541:	c3                   	ret    

00800542 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800542:	55                   	push   %ebp
  800543:	89 e5                	mov    %esp,%ebp
  800545:	53                   	push   %ebx
  800546:	83 ec 14             	sub    $0x14,%esp
  800549:	8b 45 10             	mov    0x10(%ebp),%eax
  80054c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80054f:	8b 45 14             	mov    0x14(%ebp),%eax
  800552:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800555:	8b 45 18             	mov    0x18(%ebp),%eax
  800558:	ba 00 00 00 00       	mov    $0x0,%edx
  80055d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800560:	77 55                	ja     8005b7 <printnum+0x75>
  800562:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800565:	72 05                	jb     80056c <printnum+0x2a>
  800567:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80056a:	77 4b                	ja     8005b7 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80056c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80056f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800572:	8b 45 18             	mov    0x18(%ebp),%eax
  800575:	ba 00 00 00 00       	mov    $0x0,%edx
  80057a:	52                   	push   %edx
  80057b:	50                   	push   %eax
  80057c:	ff 75 f4             	pushl  -0xc(%ebp)
  80057f:	ff 75 f0             	pushl  -0x10(%ebp)
  800582:	e8 05 13 00 00       	call   80188c <__udivdi3>
  800587:	83 c4 10             	add    $0x10,%esp
  80058a:	83 ec 04             	sub    $0x4,%esp
  80058d:	ff 75 20             	pushl  0x20(%ebp)
  800590:	53                   	push   %ebx
  800591:	ff 75 18             	pushl  0x18(%ebp)
  800594:	52                   	push   %edx
  800595:	50                   	push   %eax
  800596:	ff 75 0c             	pushl  0xc(%ebp)
  800599:	ff 75 08             	pushl  0x8(%ebp)
  80059c:	e8 a1 ff ff ff       	call   800542 <printnum>
  8005a1:	83 c4 20             	add    $0x20,%esp
  8005a4:	eb 1a                	jmp    8005c0 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005a6:	83 ec 08             	sub    $0x8,%esp
  8005a9:	ff 75 0c             	pushl  0xc(%ebp)
  8005ac:	ff 75 20             	pushl  0x20(%ebp)
  8005af:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b2:	ff d0                	call   *%eax
  8005b4:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005b7:	ff 4d 1c             	decl   0x1c(%ebp)
  8005ba:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005be:	7f e6                	jg     8005a6 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005c0:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005c3:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005ce:	53                   	push   %ebx
  8005cf:	51                   	push   %ecx
  8005d0:	52                   	push   %edx
  8005d1:	50                   	push   %eax
  8005d2:	e8 c5 13 00 00       	call   80199c <__umoddi3>
  8005d7:	83 c4 10             	add    $0x10,%esp
  8005da:	05 34 20 80 00       	add    $0x802034,%eax
  8005df:	8a 00                	mov    (%eax),%al
  8005e1:	0f be c0             	movsbl %al,%eax
  8005e4:	83 ec 08             	sub    $0x8,%esp
  8005e7:	ff 75 0c             	pushl  0xc(%ebp)
  8005ea:	50                   	push   %eax
  8005eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ee:	ff d0                	call   *%eax
  8005f0:	83 c4 10             	add    $0x10,%esp
}
  8005f3:	90                   	nop
  8005f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005f7:	c9                   	leave  
  8005f8:	c3                   	ret    

008005f9 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8005f9:	55                   	push   %ebp
  8005fa:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005fc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800600:	7e 1c                	jle    80061e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800602:	8b 45 08             	mov    0x8(%ebp),%eax
  800605:	8b 00                	mov    (%eax),%eax
  800607:	8d 50 08             	lea    0x8(%eax),%edx
  80060a:	8b 45 08             	mov    0x8(%ebp),%eax
  80060d:	89 10                	mov    %edx,(%eax)
  80060f:	8b 45 08             	mov    0x8(%ebp),%eax
  800612:	8b 00                	mov    (%eax),%eax
  800614:	83 e8 08             	sub    $0x8,%eax
  800617:	8b 50 04             	mov    0x4(%eax),%edx
  80061a:	8b 00                	mov    (%eax),%eax
  80061c:	eb 40                	jmp    80065e <getuint+0x65>
	else if (lflag)
  80061e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800622:	74 1e                	je     800642 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800624:	8b 45 08             	mov    0x8(%ebp),%eax
  800627:	8b 00                	mov    (%eax),%eax
  800629:	8d 50 04             	lea    0x4(%eax),%edx
  80062c:	8b 45 08             	mov    0x8(%ebp),%eax
  80062f:	89 10                	mov    %edx,(%eax)
  800631:	8b 45 08             	mov    0x8(%ebp),%eax
  800634:	8b 00                	mov    (%eax),%eax
  800636:	83 e8 04             	sub    $0x4,%eax
  800639:	8b 00                	mov    (%eax),%eax
  80063b:	ba 00 00 00 00       	mov    $0x0,%edx
  800640:	eb 1c                	jmp    80065e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800642:	8b 45 08             	mov    0x8(%ebp),%eax
  800645:	8b 00                	mov    (%eax),%eax
  800647:	8d 50 04             	lea    0x4(%eax),%edx
  80064a:	8b 45 08             	mov    0x8(%ebp),%eax
  80064d:	89 10                	mov    %edx,(%eax)
  80064f:	8b 45 08             	mov    0x8(%ebp),%eax
  800652:	8b 00                	mov    (%eax),%eax
  800654:	83 e8 04             	sub    $0x4,%eax
  800657:	8b 00                	mov    (%eax),%eax
  800659:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80065e:	5d                   	pop    %ebp
  80065f:	c3                   	ret    

00800660 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800660:	55                   	push   %ebp
  800661:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800663:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800667:	7e 1c                	jle    800685 <getint+0x25>
		return va_arg(*ap, long long);
  800669:	8b 45 08             	mov    0x8(%ebp),%eax
  80066c:	8b 00                	mov    (%eax),%eax
  80066e:	8d 50 08             	lea    0x8(%eax),%edx
  800671:	8b 45 08             	mov    0x8(%ebp),%eax
  800674:	89 10                	mov    %edx,(%eax)
  800676:	8b 45 08             	mov    0x8(%ebp),%eax
  800679:	8b 00                	mov    (%eax),%eax
  80067b:	83 e8 08             	sub    $0x8,%eax
  80067e:	8b 50 04             	mov    0x4(%eax),%edx
  800681:	8b 00                	mov    (%eax),%eax
  800683:	eb 38                	jmp    8006bd <getint+0x5d>
	else if (lflag)
  800685:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800689:	74 1a                	je     8006a5 <getint+0x45>
		return va_arg(*ap, long);
  80068b:	8b 45 08             	mov    0x8(%ebp),%eax
  80068e:	8b 00                	mov    (%eax),%eax
  800690:	8d 50 04             	lea    0x4(%eax),%edx
  800693:	8b 45 08             	mov    0x8(%ebp),%eax
  800696:	89 10                	mov    %edx,(%eax)
  800698:	8b 45 08             	mov    0x8(%ebp),%eax
  80069b:	8b 00                	mov    (%eax),%eax
  80069d:	83 e8 04             	sub    $0x4,%eax
  8006a0:	8b 00                	mov    (%eax),%eax
  8006a2:	99                   	cltd   
  8006a3:	eb 18                	jmp    8006bd <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a8:	8b 00                	mov    (%eax),%eax
  8006aa:	8d 50 04             	lea    0x4(%eax),%edx
  8006ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b0:	89 10                	mov    %edx,(%eax)
  8006b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b5:	8b 00                	mov    (%eax),%eax
  8006b7:	83 e8 04             	sub    $0x4,%eax
  8006ba:	8b 00                	mov    (%eax),%eax
  8006bc:	99                   	cltd   
}
  8006bd:	5d                   	pop    %ebp
  8006be:	c3                   	ret    

008006bf <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006bf:	55                   	push   %ebp
  8006c0:	89 e5                	mov    %esp,%ebp
  8006c2:	56                   	push   %esi
  8006c3:	53                   	push   %ebx
  8006c4:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006c7:	eb 17                	jmp    8006e0 <vprintfmt+0x21>
			if (ch == '\0')
  8006c9:	85 db                	test   %ebx,%ebx
  8006cb:	0f 84 af 03 00 00    	je     800a80 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006d1:	83 ec 08             	sub    $0x8,%esp
  8006d4:	ff 75 0c             	pushl  0xc(%ebp)
  8006d7:	53                   	push   %ebx
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	ff d0                	call   *%eax
  8006dd:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8006e3:	8d 50 01             	lea    0x1(%eax),%edx
  8006e6:	89 55 10             	mov    %edx,0x10(%ebp)
  8006e9:	8a 00                	mov    (%eax),%al
  8006eb:	0f b6 d8             	movzbl %al,%ebx
  8006ee:	83 fb 25             	cmp    $0x25,%ebx
  8006f1:	75 d6                	jne    8006c9 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8006f3:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8006f7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8006fe:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800705:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80070c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800713:	8b 45 10             	mov    0x10(%ebp),%eax
  800716:	8d 50 01             	lea    0x1(%eax),%edx
  800719:	89 55 10             	mov    %edx,0x10(%ebp)
  80071c:	8a 00                	mov    (%eax),%al
  80071e:	0f b6 d8             	movzbl %al,%ebx
  800721:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800724:	83 f8 55             	cmp    $0x55,%eax
  800727:	0f 87 2b 03 00 00    	ja     800a58 <vprintfmt+0x399>
  80072d:	8b 04 85 58 20 80 00 	mov    0x802058(,%eax,4),%eax
  800734:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800736:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80073a:	eb d7                	jmp    800713 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80073c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800740:	eb d1                	jmp    800713 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800742:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800749:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80074c:	89 d0                	mov    %edx,%eax
  80074e:	c1 e0 02             	shl    $0x2,%eax
  800751:	01 d0                	add    %edx,%eax
  800753:	01 c0                	add    %eax,%eax
  800755:	01 d8                	add    %ebx,%eax
  800757:	83 e8 30             	sub    $0x30,%eax
  80075a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80075d:	8b 45 10             	mov    0x10(%ebp),%eax
  800760:	8a 00                	mov    (%eax),%al
  800762:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800765:	83 fb 2f             	cmp    $0x2f,%ebx
  800768:	7e 3e                	jle    8007a8 <vprintfmt+0xe9>
  80076a:	83 fb 39             	cmp    $0x39,%ebx
  80076d:	7f 39                	jg     8007a8 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80076f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800772:	eb d5                	jmp    800749 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800774:	8b 45 14             	mov    0x14(%ebp),%eax
  800777:	83 c0 04             	add    $0x4,%eax
  80077a:	89 45 14             	mov    %eax,0x14(%ebp)
  80077d:	8b 45 14             	mov    0x14(%ebp),%eax
  800780:	83 e8 04             	sub    $0x4,%eax
  800783:	8b 00                	mov    (%eax),%eax
  800785:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800788:	eb 1f                	jmp    8007a9 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80078a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80078e:	79 83                	jns    800713 <vprintfmt+0x54>
				width = 0;
  800790:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800797:	e9 77 ff ff ff       	jmp    800713 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80079c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007a3:	e9 6b ff ff ff       	jmp    800713 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007a8:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007a9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ad:	0f 89 60 ff ff ff    	jns    800713 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007b9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007c0:	e9 4e ff ff ff       	jmp    800713 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007c5:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007c8:	e9 46 ff ff ff       	jmp    800713 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d0:	83 c0 04             	add    $0x4,%eax
  8007d3:	89 45 14             	mov    %eax,0x14(%ebp)
  8007d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d9:	83 e8 04             	sub    $0x4,%eax
  8007dc:	8b 00                	mov    (%eax),%eax
  8007de:	83 ec 08             	sub    $0x8,%esp
  8007e1:	ff 75 0c             	pushl  0xc(%ebp)
  8007e4:	50                   	push   %eax
  8007e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e8:	ff d0                	call   *%eax
  8007ea:	83 c4 10             	add    $0x10,%esp
			break;
  8007ed:	e9 89 02 00 00       	jmp    800a7b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8007f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f5:	83 c0 04             	add    $0x4,%eax
  8007f8:	89 45 14             	mov    %eax,0x14(%ebp)
  8007fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8007fe:	83 e8 04             	sub    $0x4,%eax
  800801:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800803:	85 db                	test   %ebx,%ebx
  800805:	79 02                	jns    800809 <vprintfmt+0x14a>
				err = -err;
  800807:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800809:	83 fb 64             	cmp    $0x64,%ebx
  80080c:	7f 0b                	jg     800819 <vprintfmt+0x15a>
  80080e:	8b 34 9d a0 1e 80 00 	mov    0x801ea0(,%ebx,4),%esi
  800815:	85 f6                	test   %esi,%esi
  800817:	75 19                	jne    800832 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800819:	53                   	push   %ebx
  80081a:	68 45 20 80 00       	push   $0x802045
  80081f:	ff 75 0c             	pushl  0xc(%ebp)
  800822:	ff 75 08             	pushl  0x8(%ebp)
  800825:	e8 5e 02 00 00       	call   800a88 <printfmt>
  80082a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80082d:	e9 49 02 00 00       	jmp    800a7b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800832:	56                   	push   %esi
  800833:	68 4e 20 80 00       	push   $0x80204e
  800838:	ff 75 0c             	pushl  0xc(%ebp)
  80083b:	ff 75 08             	pushl  0x8(%ebp)
  80083e:	e8 45 02 00 00       	call   800a88 <printfmt>
  800843:	83 c4 10             	add    $0x10,%esp
			break;
  800846:	e9 30 02 00 00       	jmp    800a7b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80084b:	8b 45 14             	mov    0x14(%ebp),%eax
  80084e:	83 c0 04             	add    $0x4,%eax
  800851:	89 45 14             	mov    %eax,0x14(%ebp)
  800854:	8b 45 14             	mov    0x14(%ebp),%eax
  800857:	83 e8 04             	sub    $0x4,%eax
  80085a:	8b 30                	mov    (%eax),%esi
  80085c:	85 f6                	test   %esi,%esi
  80085e:	75 05                	jne    800865 <vprintfmt+0x1a6>
				p = "(null)";
  800860:	be 51 20 80 00       	mov    $0x802051,%esi
			if (width > 0 && padc != '-')
  800865:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800869:	7e 6d                	jle    8008d8 <vprintfmt+0x219>
  80086b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80086f:	74 67                	je     8008d8 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800871:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800874:	83 ec 08             	sub    $0x8,%esp
  800877:	50                   	push   %eax
  800878:	56                   	push   %esi
  800879:	e8 0c 03 00 00       	call   800b8a <strnlen>
  80087e:	83 c4 10             	add    $0x10,%esp
  800881:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800884:	eb 16                	jmp    80089c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800886:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80088a:	83 ec 08             	sub    $0x8,%esp
  80088d:	ff 75 0c             	pushl  0xc(%ebp)
  800890:	50                   	push   %eax
  800891:	8b 45 08             	mov    0x8(%ebp),%eax
  800894:	ff d0                	call   *%eax
  800896:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800899:	ff 4d e4             	decl   -0x1c(%ebp)
  80089c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008a0:	7f e4                	jg     800886 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008a2:	eb 34                	jmp    8008d8 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008a4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008a8:	74 1c                	je     8008c6 <vprintfmt+0x207>
  8008aa:	83 fb 1f             	cmp    $0x1f,%ebx
  8008ad:	7e 05                	jle    8008b4 <vprintfmt+0x1f5>
  8008af:	83 fb 7e             	cmp    $0x7e,%ebx
  8008b2:	7e 12                	jle    8008c6 <vprintfmt+0x207>
					putch('?', putdat);
  8008b4:	83 ec 08             	sub    $0x8,%esp
  8008b7:	ff 75 0c             	pushl  0xc(%ebp)
  8008ba:	6a 3f                	push   $0x3f
  8008bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bf:	ff d0                	call   *%eax
  8008c1:	83 c4 10             	add    $0x10,%esp
  8008c4:	eb 0f                	jmp    8008d5 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008c6:	83 ec 08             	sub    $0x8,%esp
  8008c9:	ff 75 0c             	pushl  0xc(%ebp)
  8008cc:	53                   	push   %ebx
  8008cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d0:	ff d0                	call   *%eax
  8008d2:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008d5:	ff 4d e4             	decl   -0x1c(%ebp)
  8008d8:	89 f0                	mov    %esi,%eax
  8008da:	8d 70 01             	lea    0x1(%eax),%esi
  8008dd:	8a 00                	mov    (%eax),%al
  8008df:	0f be d8             	movsbl %al,%ebx
  8008e2:	85 db                	test   %ebx,%ebx
  8008e4:	74 24                	je     80090a <vprintfmt+0x24b>
  8008e6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008ea:	78 b8                	js     8008a4 <vprintfmt+0x1e5>
  8008ec:	ff 4d e0             	decl   -0x20(%ebp)
  8008ef:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008f3:	79 af                	jns    8008a4 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008f5:	eb 13                	jmp    80090a <vprintfmt+0x24b>
				putch(' ', putdat);
  8008f7:	83 ec 08             	sub    $0x8,%esp
  8008fa:	ff 75 0c             	pushl  0xc(%ebp)
  8008fd:	6a 20                	push   $0x20
  8008ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800902:	ff d0                	call   *%eax
  800904:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800907:	ff 4d e4             	decl   -0x1c(%ebp)
  80090a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80090e:	7f e7                	jg     8008f7 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800910:	e9 66 01 00 00       	jmp    800a7b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800915:	83 ec 08             	sub    $0x8,%esp
  800918:	ff 75 e8             	pushl  -0x18(%ebp)
  80091b:	8d 45 14             	lea    0x14(%ebp),%eax
  80091e:	50                   	push   %eax
  80091f:	e8 3c fd ff ff       	call   800660 <getint>
  800924:	83 c4 10             	add    $0x10,%esp
  800927:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80092a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80092d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800930:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800933:	85 d2                	test   %edx,%edx
  800935:	79 23                	jns    80095a <vprintfmt+0x29b>
				putch('-', putdat);
  800937:	83 ec 08             	sub    $0x8,%esp
  80093a:	ff 75 0c             	pushl  0xc(%ebp)
  80093d:	6a 2d                	push   $0x2d
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	ff d0                	call   *%eax
  800944:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800947:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80094a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80094d:	f7 d8                	neg    %eax
  80094f:	83 d2 00             	adc    $0x0,%edx
  800952:	f7 da                	neg    %edx
  800954:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800957:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80095a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800961:	e9 bc 00 00 00       	jmp    800a22 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800966:	83 ec 08             	sub    $0x8,%esp
  800969:	ff 75 e8             	pushl  -0x18(%ebp)
  80096c:	8d 45 14             	lea    0x14(%ebp),%eax
  80096f:	50                   	push   %eax
  800970:	e8 84 fc ff ff       	call   8005f9 <getuint>
  800975:	83 c4 10             	add    $0x10,%esp
  800978:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80097b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80097e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800985:	e9 98 00 00 00       	jmp    800a22 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80098a:	83 ec 08             	sub    $0x8,%esp
  80098d:	ff 75 0c             	pushl  0xc(%ebp)
  800990:	6a 58                	push   $0x58
  800992:	8b 45 08             	mov    0x8(%ebp),%eax
  800995:	ff d0                	call   *%eax
  800997:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80099a:	83 ec 08             	sub    $0x8,%esp
  80099d:	ff 75 0c             	pushl  0xc(%ebp)
  8009a0:	6a 58                	push   $0x58
  8009a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a5:	ff d0                	call   *%eax
  8009a7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009aa:	83 ec 08             	sub    $0x8,%esp
  8009ad:	ff 75 0c             	pushl  0xc(%ebp)
  8009b0:	6a 58                	push   $0x58
  8009b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b5:	ff d0                	call   *%eax
  8009b7:	83 c4 10             	add    $0x10,%esp
			break;
  8009ba:	e9 bc 00 00 00       	jmp    800a7b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009bf:	83 ec 08             	sub    $0x8,%esp
  8009c2:	ff 75 0c             	pushl  0xc(%ebp)
  8009c5:	6a 30                	push   $0x30
  8009c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ca:	ff d0                	call   *%eax
  8009cc:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009cf:	83 ec 08             	sub    $0x8,%esp
  8009d2:	ff 75 0c             	pushl  0xc(%ebp)
  8009d5:	6a 78                	push   $0x78
  8009d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009da:	ff d0                	call   *%eax
  8009dc:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009df:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e2:	83 c0 04             	add    $0x4,%eax
  8009e5:	89 45 14             	mov    %eax,0x14(%ebp)
  8009e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009eb:	83 e8 04             	sub    $0x4,%eax
  8009ee:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8009f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8009fa:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a01:	eb 1f                	jmp    800a22 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a03:	83 ec 08             	sub    $0x8,%esp
  800a06:	ff 75 e8             	pushl  -0x18(%ebp)
  800a09:	8d 45 14             	lea    0x14(%ebp),%eax
  800a0c:	50                   	push   %eax
  800a0d:	e8 e7 fb ff ff       	call   8005f9 <getuint>
  800a12:	83 c4 10             	add    $0x10,%esp
  800a15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a18:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a1b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a22:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a26:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a29:	83 ec 04             	sub    $0x4,%esp
  800a2c:	52                   	push   %edx
  800a2d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a30:	50                   	push   %eax
  800a31:	ff 75 f4             	pushl  -0xc(%ebp)
  800a34:	ff 75 f0             	pushl  -0x10(%ebp)
  800a37:	ff 75 0c             	pushl  0xc(%ebp)
  800a3a:	ff 75 08             	pushl  0x8(%ebp)
  800a3d:	e8 00 fb ff ff       	call   800542 <printnum>
  800a42:	83 c4 20             	add    $0x20,%esp
			break;
  800a45:	eb 34                	jmp    800a7b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a47:	83 ec 08             	sub    $0x8,%esp
  800a4a:	ff 75 0c             	pushl  0xc(%ebp)
  800a4d:	53                   	push   %ebx
  800a4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a51:	ff d0                	call   *%eax
  800a53:	83 c4 10             	add    $0x10,%esp
			break;
  800a56:	eb 23                	jmp    800a7b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a58:	83 ec 08             	sub    $0x8,%esp
  800a5b:	ff 75 0c             	pushl  0xc(%ebp)
  800a5e:	6a 25                	push   $0x25
  800a60:	8b 45 08             	mov    0x8(%ebp),%eax
  800a63:	ff d0                	call   *%eax
  800a65:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a68:	ff 4d 10             	decl   0x10(%ebp)
  800a6b:	eb 03                	jmp    800a70 <vprintfmt+0x3b1>
  800a6d:	ff 4d 10             	decl   0x10(%ebp)
  800a70:	8b 45 10             	mov    0x10(%ebp),%eax
  800a73:	48                   	dec    %eax
  800a74:	8a 00                	mov    (%eax),%al
  800a76:	3c 25                	cmp    $0x25,%al
  800a78:	75 f3                	jne    800a6d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a7a:	90                   	nop
		}
	}
  800a7b:	e9 47 fc ff ff       	jmp    8006c7 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a80:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a81:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a84:	5b                   	pop    %ebx
  800a85:	5e                   	pop    %esi
  800a86:	5d                   	pop    %ebp
  800a87:	c3                   	ret    

00800a88 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a88:	55                   	push   %ebp
  800a89:	89 e5                	mov    %esp,%ebp
  800a8b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a8e:	8d 45 10             	lea    0x10(%ebp),%eax
  800a91:	83 c0 04             	add    $0x4,%eax
  800a94:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a97:	8b 45 10             	mov    0x10(%ebp),%eax
  800a9a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a9d:	50                   	push   %eax
  800a9e:	ff 75 0c             	pushl  0xc(%ebp)
  800aa1:	ff 75 08             	pushl  0x8(%ebp)
  800aa4:	e8 16 fc ff ff       	call   8006bf <vprintfmt>
  800aa9:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800aac:	90                   	nop
  800aad:	c9                   	leave  
  800aae:	c3                   	ret    

00800aaf <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800aaf:	55                   	push   %ebp
  800ab0:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ab2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab5:	8b 40 08             	mov    0x8(%eax),%eax
  800ab8:	8d 50 01             	lea    0x1(%eax),%edx
  800abb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800abe:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ac1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac4:	8b 10                	mov    (%eax),%edx
  800ac6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac9:	8b 40 04             	mov    0x4(%eax),%eax
  800acc:	39 c2                	cmp    %eax,%edx
  800ace:	73 12                	jae    800ae2 <sprintputch+0x33>
		*b->buf++ = ch;
  800ad0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad3:	8b 00                	mov    (%eax),%eax
  800ad5:	8d 48 01             	lea    0x1(%eax),%ecx
  800ad8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800adb:	89 0a                	mov    %ecx,(%edx)
  800add:	8b 55 08             	mov    0x8(%ebp),%edx
  800ae0:	88 10                	mov    %dl,(%eax)
}
  800ae2:	90                   	nop
  800ae3:	5d                   	pop    %ebp
  800ae4:	c3                   	ret    

00800ae5 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ae5:	55                   	push   %ebp
  800ae6:	89 e5                	mov    %esp,%ebp
  800ae8:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800af1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
  800afa:	01 d0                	add    %edx,%eax
  800afc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b06:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b0a:	74 06                	je     800b12 <vsnprintf+0x2d>
  800b0c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b10:	7f 07                	jg     800b19 <vsnprintf+0x34>
		return -E_INVAL;
  800b12:	b8 03 00 00 00       	mov    $0x3,%eax
  800b17:	eb 20                	jmp    800b39 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b19:	ff 75 14             	pushl  0x14(%ebp)
  800b1c:	ff 75 10             	pushl  0x10(%ebp)
  800b1f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b22:	50                   	push   %eax
  800b23:	68 af 0a 80 00       	push   $0x800aaf
  800b28:	e8 92 fb ff ff       	call   8006bf <vprintfmt>
  800b2d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b30:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b33:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b36:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b39:	c9                   	leave  
  800b3a:	c3                   	ret    

00800b3b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b3b:	55                   	push   %ebp
  800b3c:	89 e5                	mov    %esp,%ebp
  800b3e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b41:	8d 45 10             	lea    0x10(%ebp),%eax
  800b44:	83 c0 04             	add    $0x4,%eax
  800b47:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b4a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b4d:	ff 75 f4             	pushl  -0xc(%ebp)
  800b50:	50                   	push   %eax
  800b51:	ff 75 0c             	pushl  0xc(%ebp)
  800b54:	ff 75 08             	pushl  0x8(%ebp)
  800b57:	e8 89 ff ff ff       	call   800ae5 <vsnprintf>
  800b5c:	83 c4 10             	add    $0x10,%esp
  800b5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b62:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b65:	c9                   	leave  
  800b66:	c3                   	ret    

00800b67 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b67:	55                   	push   %ebp
  800b68:	89 e5                	mov    %esp,%ebp
  800b6a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b6d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b74:	eb 06                	jmp    800b7c <strlen+0x15>
		n++;
  800b76:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b79:	ff 45 08             	incl   0x8(%ebp)
  800b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7f:	8a 00                	mov    (%eax),%al
  800b81:	84 c0                	test   %al,%al
  800b83:	75 f1                	jne    800b76 <strlen+0xf>
		n++;
	return n;
  800b85:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b88:	c9                   	leave  
  800b89:	c3                   	ret    

00800b8a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b8a:	55                   	push   %ebp
  800b8b:	89 e5                	mov    %esp,%ebp
  800b8d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b90:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b97:	eb 09                	jmp    800ba2 <strnlen+0x18>
		n++;
  800b99:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b9c:	ff 45 08             	incl   0x8(%ebp)
  800b9f:	ff 4d 0c             	decl   0xc(%ebp)
  800ba2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ba6:	74 09                	je     800bb1 <strnlen+0x27>
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	8a 00                	mov    (%eax),%al
  800bad:	84 c0                	test   %al,%al
  800baf:	75 e8                	jne    800b99 <strnlen+0xf>
		n++;
	return n;
  800bb1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bb4:	c9                   	leave  
  800bb5:	c3                   	ret    

00800bb6 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bb6:	55                   	push   %ebp
  800bb7:	89 e5                	mov    %esp,%ebp
  800bb9:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bc2:	90                   	nop
  800bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc6:	8d 50 01             	lea    0x1(%eax),%edx
  800bc9:	89 55 08             	mov    %edx,0x8(%ebp)
  800bcc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bcf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bd2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bd5:	8a 12                	mov    (%edx),%dl
  800bd7:	88 10                	mov    %dl,(%eax)
  800bd9:	8a 00                	mov    (%eax),%al
  800bdb:	84 c0                	test   %al,%al
  800bdd:	75 e4                	jne    800bc3 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bdf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800be2:	c9                   	leave  
  800be3:	c3                   	ret    

00800be4 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800be4:	55                   	push   %ebp
  800be5:	89 e5                	mov    %esp,%ebp
  800be7:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bea:	8b 45 08             	mov    0x8(%ebp),%eax
  800bed:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bf0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bf7:	eb 1f                	jmp    800c18 <strncpy+0x34>
		*dst++ = *src;
  800bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfc:	8d 50 01             	lea    0x1(%eax),%edx
  800bff:	89 55 08             	mov    %edx,0x8(%ebp)
  800c02:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c05:	8a 12                	mov    (%edx),%dl
  800c07:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0c:	8a 00                	mov    (%eax),%al
  800c0e:	84 c0                	test   %al,%al
  800c10:	74 03                	je     800c15 <strncpy+0x31>
			src++;
  800c12:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c15:	ff 45 fc             	incl   -0x4(%ebp)
  800c18:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c1b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c1e:	72 d9                	jb     800bf9 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c20:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c23:	c9                   	leave  
  800c24:	c3                   	ret    

00800c25 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c25:	55                   	push   %ebp
  800c26:	89 e5                	mov    %esp,%ebp
  800c28:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c31:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c35:	74 30                	je     800c67 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c37:	eb 16                	jmp    800c4f <strlcpy+0x2a>
			*dst++ = *src++;
  800c39:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3c:	8d 50 01             	lea    0x1(%eax),%edx
  800c3f:	89 55 08             	mov    %edx,0x8(%ebp)
  800c42:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c45:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c48:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c4b:	8a 12                	mov    (%edx),%dl
  800c4d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c4f:	ff 4d 10             	decl   0x10(%ebp)
  800c52:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c56:	74 09                	je     800c61 <strlcpy+0x3c>
  800c58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5b:	8a 00                	mov    (%eax),%al
  800c5d:	84 c0                	test   %al,%al
  800c5f:	75 d8                	jne    800c39 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c61:	8b 45 08             	mov    0x8(%ebp),%eax
  800c64:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c67:	8b 55 08             	mov    0x8(%ebp),%edx
  800c6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c6d:	29 c2                	sub    %eax,%edx
  800c6f:	89 d0                	mov    %edx,%eax
}
  800c71:	c9                   	leave  
  800c72:	c3                   	ret    

00800c73 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c73:	55                   	push   %ebp
  800c74:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c76:	eb 06                	jmp    800c7e <strcmp+0xb>
		p++, q++;
  800c78:	ff 45 08             	incl   0x8(%ebp)
  800c7b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	8a 00                	mov    (%eax),%al
  800c83:	84 c0                	test   %al,%al
  800c85:	74 0e                	je     800c95 <strcmp+0x22>
  800c87:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8a:	8a 10                	mov    (%eax),%dl
  800c8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8f:	8a 00                	mov    (%eax),%al
  800c91:	38 c2                	cmp    %al,%dl
  800c93:	74 e3                	je     800c78 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c95:	8b 45 08             	mov    0x8(%ebp),%eax
  800c98:	8a 00                	mov    (%eax),%al
  800c9a:	0f b6 d0             	movzbl %al,%edx
  800c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	0f b6 c0             	movzbl %al,%eax
  800ca5:	29 c2                	sub    %eax,%edx
  800ca7:	89 d0                	mov    %edx,%eax
}
  800ca9:	5d                   	pop    %ebp
  800caa:	c3                   	ret    

00800cab <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cab:	55                   	push   %ebp
  800cac:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cae:	eb 09                	jmp    800cb9 <strncmp+0xe>
		n--, p++, q++;
  800cb0:	ff 4d 10             	decl   0x10(%ebp)
  800cb3:	ff 45 08             	incl   0x8(%ebp)
  800cb6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cb9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cbd:	74 17                	je     800cd6 <strncmp+0x2b>
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	8a 00                	mov    (%eax),%al
  800cc4:	84 c0                	test   %al,%al
  800cc6:	74 0e                	je     800cd6 <strncmp+0x2b>
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	8a 10                	mov    (%eax),%dl
  800ccd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd0:	8a 00                	mov    (%eax),%al
  800cd2:	38 c2                	cmp    %al,%dl
  800cd4:	74 da                	je     800cb0 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cd6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cda:	75 07                	jne    800ce3 <strncmp+0x38>
		return 0;
  800cdc:	b8 00 00 00 00       	mov    $0x0,%eax
  800ce1:	eb 14                	jmp    800cf7 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	8a 00                	mov    (%eax),%al
  800ce8:	0f b6 d0             	movzbl %al,%edx
  800ceb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cee:	8a 00                	mov    (%eax),%al
  800cf0:	0f b6 c0             	movzbl %al,%eax
  800cf3:	29 c2                	sub    %eax,%edx
  800cf5:	89 d0                	mov    %edx,%eax
}
  800cf7:	5d                   	pop    %ebp
  800cf8:	c3                   	ret    

00800cf9 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cf9:	55                   	push   %ebp
  800cfa:	89 e5                	mov    %esp,%ebp
  800cfc:	83 ec 04             	sub    $0x4,%esp
  800cff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d02:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d05:	eb 12                	jmp    800d19 <strchr+0x20>
		if (*s == c)
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d0f:	75 05                	jne    800d16 <strchr+0x1d>
			return (char *) s;
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	eb 11                	jmp    800d27 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d16:	ff 45 08             	incl   0x8(%ebp)
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8a 00                	mov    (%eax),%al
  800d1e:	84 c0                	test   %al,%al
  800d20:	75 e5                	jne    800d07 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d22:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d27:	c9                   	leave  
  800d28:	c3                   	ret    

00800d29 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d29:	55                   	push   %ebp
  800d2a:	89 e5                	mov    %esp,%ebp
  800d2c:	83 ec 04             	sub    $0x4,%esp
  800d2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d32:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d35:	eb 0d                	jmp    800d44 <strfind+0x1b>
		if (*s == c)
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3a:	8a 00                	mov    (%eax),%al
  800d3c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d3f:	74 0e                	je     800d4f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d41:	ff 45 08             	incl   0x8(%ebp)
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	8a 00                	mov    (%eax),%al
  800d49:	84 c0                	test   %al,%al
  800d4b:	75 ea                	jne    800d37 <strfind+0xe>
  800d4d:	eb 01                	jmp    800d50 <strfind+0x27>
		if (*s == c)
			break;
  800d4f:	90                   	nop
	return (char *) s;
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d53:	c9                   	leave  
  800d54:	c3                   	ret    

00800d55 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d55:	55                   	push   %ebp
  800d56:	89 e5                	mov    %esp,%ebp
  800d58:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d61:	8b 45 10             	mov    0x10(%ebp),%eax
  800d64:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d67:	eb 0e                	jmp    800d77 <memset+0x22>
		*p++ = c;
  800d69:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d6c:	8d 50 01             	lea    0x1(%eax),%edx
  800d6f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d72:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d75:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d77:	ff 4d f8             	decl   -0x8(%ebp)
  800d7a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d7e:	79 e9                	jns    800d69 <memset+0x14>
		*p++ = c;

	return v;
  800d80:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d83:	c9                   	leave  
  800d84:	c3                   	ret    

00800d85 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d85:	55                   	push   %ebp
  800d86:	89 e5                	mov    %esp,%ebp
  800d88:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d97:	eb 16                	jmp    800daf <memcpy+0x2a>
		*d++ = *s++;
  800d99:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d9c:	8d 50 01             	lea    0x1(%eax),%edx
  800d9f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800da2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800da5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800da8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dab:	8a 12                	mov    (%edx),%dl
  800dad:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800daf:	8b 45 10             	mov    0x10(%ebp),%eax
  800db2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800db5:	89 55 10             	mov    %edx,0x10(%ebp)
  800db8:	85 c0                	test   %eax,%eax
  800dba:	75 dd                	jne    800d99 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dbc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dbf:	c9                   	leave  
  800dc0:	c3                   	ret    

00800dc1 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800dc1:	55                   	push   %ebp
  800dc2:	89 e5                	mov    %esp,%ebp
  800dc4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800dc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dd3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dd6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dd9:	73 50                	jae    800e2b <memmove+0x6a>
  800ddb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dde:	8b 45 10             	mov    0x10(%ebp),%eax
  800de1:	01 d0                	add    %edx,%eax
  800de3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800de6:	76 43                	jbe    800e2b <memmove+0x6a>
		s += n;
  800de8:	8b 45 10             	mov    0x10(%ebp),%eax
  800deb:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dee:	8b 45 10             	mov    0x10(%ebp),%eax
  800df1:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800df4:	eb 10                	jmp    800e06 <memmove+0x45>
			*--d = *--s;
  800df6:	ff 4d f8             	decl   -0x8(%ebp)
  800df9:	ff 4d fc             	decl   -0x4(%ebp)
  800dfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dff:	8a 10                	mov    (%eax),%dl
  800e01:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e04:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e06:	8b 45 10             	mov    0x10(%ebp),%eax
  800e09:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e0c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e0f:	85 c0                	test   %eax,%eax
  800e11:	75 e3                	jne    800df6 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e13:	eb 23                	jmp    800e38 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e15:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e18:	8d 50 01             	lea    0x1(%eax),%edx
  800e1b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e1e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e21:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e24:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e27:	8a 12                	mov    (%edx),%dl
  800e29:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e2e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e31:	89 55 10             	mov    %edx,0x10(%ebp)
  800e34:	85 c0                	test   %eax,%eax
  800e36:	75 dd                	jne    800e15 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e38:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e3b:	c9                   	leave  
  800e3c:	c3                   	ret    

00800e3d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e3d:	55                   	push   %ebp
  800e3e:	89 e5                	mov    %esp,%ebp
  800e40:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e4f:	eb 2a                	jmp    800e7b <memcmp+0x3e>
		if (*s1 != *s2)
  800e51:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e54:	8a 10                	mov    (%eax),%dl
  800e56:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e59:	8a 00                	mov    (%eax),%al
  800e5b:	38 c2                	cmp    %al,%dl
  800e5d:	74 16                	je     800e75 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e62:	8a 00                	mov    (%eax),%al
  800e64:	0f b6 d0             	movzbl %al,%edx
  800e67:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e6a:	8a 00                	mov    (%eax),%al
  800e6c:	0f b6 c0             	movzbl %al,%eax
  800e6f:	29 c2                	sub    %eax,%edx
  800e71:	89 d0                	mov    %edx,%eax
  800e73:	eb 18                	jmp    800e8d <memcmp+0x50>
		s1++, s2++;
  800e75:	ff 45 fc             	incl   -0x4(%ebp)
  800e78:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e7e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e81:	89 55 10             	mov    %edx,0x10(%ebp)
  800e84:	85 c0                	test   %eax,%eax
  800e86:	75 c9                	jne    800e51 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e88:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e8d:	c9                   	leave  
  800e8e:	c3                   	ret    

00800e8f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e8f:	55                   	push   %ebp
  800e90:	89 e5                	mov    %esp,%ebp
  800e92:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e95:	8b 55 08             	mov    0x8(%ebp),%edx
  800e98:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9b:	01 d0                	add    %edx,%eax
  800e9d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ea0:	eb 15                	jmp    800eb7 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea5:	8a 00                	mov    (%eax),%al
  800ea7:	0f b6 d0             	movzbl %al,%edx
  800eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ead:	0f b6 c0             	movzbl %al,%eax
  800eb0:	39 c2                	cmp    %eax,%edx
  800eb2:	74 0d                	je     800ec1 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800eb4:	ff 45 08             	incl   0x8(%ebp)
  800eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ebd:	72 e3                	jb     800ea2 <memfind+0x13>
  800ebf:	eb 01                	jmp    800ec2 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ec1:	90                   	nop
	return (void *) s;
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ec5:	c9                   	leave  
  800ec6:	c3                   	ret    

00800ec7 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ec7:	55                   	push   %ebp
  800ec8:	89 e5                	mov    %esp,%ebp
  800eca:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ecd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ed4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800edb:	eb 03                	jmp    800ee0 <strtol+0x19>
		s++;
  800edd:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ee0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee3:	8a 00                	mov    (%eax),%al
  800ee5:	3c 20                	cmp    $0x20,%al
  800ee7:	74 f4                	je     800edd <strtol+0x16>
  800ee9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eec:	8a 00                	mov    (%eax),%al
  800eee:	3c 09                	cmp    $0x9,%al
  800ef0:	74 eb                	je     800edd <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef5:	8a 00                	mov    (%eax),%al
  800ef7:	3c 2b                	cmp    $0x2b,%al
  800ef9:	75 05                	jne    800f00 <strtol+0x39>
		s++;
  800efb:	ff 45 08             	incl   0x8(%ebp)
  800efe:	eb 13                	jmp    800f13 <strtol+0x4c>
	else if (*s == '-')
  800f00:	8b 45 08             	mov    0x8(%ebp),%eax
  800f03:	8a 00                	mov    (%eax),%al
  800f05:	3c 2d                	cmp    $0x2d,%al
  800f07:	75 0a                	jne    800f13 <strtol+0x4c>
		s++, neg = 1;
  800f09:	ff 45 08             	incl   0x8(%ebp)
  800f0c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f13:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f17:	74 06                	je     800f1f <strtol+0x58>
  800f19:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f1d:	75 20                	jne    800f3f <strtol+0x78>
  800f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f22:	8a 00                	mov    (%eax),%al
  800f24:	3c 30                	cmp    $0x30,%al
  800f26:	75 17                	jne    800f3f <strtol+0x78>
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	40                   	inc    %eax
  800f2c:	8a 00                	mov    (%eax),%al
  800f2e:	3c 78                	cmp    $0x78,%al
  800f30:	75 0d                	jne    800f3f <strtol+0x78>
		s += 2, base = 16;
  800f32:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f36:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f3d:	eb 28                	jmp    800f67 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f3f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f43:	75 15                	jne    800f5a <strtol+0x93>
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
  800f48:	8a 00                	mov    (%eax),%al
  800f4a:	3c 30                	cmp    $0x30,%al
  800f4c:	75 0c                	jne    800f5a <strtol+0x93>
		s++, base = 8;
  800f4e:	ff 45 08             	incl   0x8(%ebp)
  800f51:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f58:	eb 0d                	jmp    800f67 <strtol+0xa0>
	else if (base == 0)
  800f5a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5e:	75 07                	jne    800f67 <strtol+0xa0>
		base = 10;
  800f60:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f67:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6a:	8a 00                	mov    (%eax),%al
  800f6c:	3c 2f                	cmp    $0x2f,%al
  800f6e:	7e 19                	jle    800f89 <strtol+0xc2>
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	8a 00                	mov    (%eax),%al
  800f75:	3c 39                	cmp    $0x39,%al
  800f77:	7f 10                	jg     800f89 <strtol+0xc2>
			dig = *s - '0';
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	0f be c0             	movsbl %al,%eax
  800f81:	83 e8 30             	sub    $0x30,%eax
  800f84:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f87:	eb 42                	jmp    800fcb <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	8a 00                	mov    (%eax),%al
  800f8e:	3c 60                	cmp    $0x60,%al
  800f90:	7e 19                	jle    800fab <strtol+0xe4>
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	8a 00                	mov    (%eax),%al
  800f97:	3c 7a                	cmp    $0x7a,%al
  800f99:	7f 10                	jg     800fab <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9e:	8a 00                	mov    (%eax),%al
  800fa0:	0f be c0             	movsbl %al,%eax
  800fa3:	83 e8 57             	sub    $0x57,%eax
  800fa6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fa9:	eb 20                	jmp    800fcb <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	8a 00                	mov    (%eax),%al
  800fb0:	3c 40                	cmp    $0x40,%al
  800fb2:	7e 39                	jle    800fed <strtol+0x126>
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	8a 00                	mov    (%eax),%al
  800fb9:	3c 5a                	cmp    $0x5a,%al
  800fbb:	7f 30                	jg     800fed <strtol+0x126>
			dig = *s - 'A' + 10;
  800fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc0:	8a 00                	mov    (%eax),%al
  800fc2:	0f be c0             	movsbl %al,%eax
  800fc5:	83 e8 37             	sub    $0x37,%eax
  800fc8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fce:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fd1:	7d 19                	jge    800fec <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fd3:	ff 45 08             	incl   0x8(%ebp)
  800fd6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd9:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fdd:	89 c2                	mov    %eax,%edx
  800fdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fe2:	01 d0                	add    %edx,%eax
  800fe4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fe7:	e9 7b ff ff ff       	jmp    800f67 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fec:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fed:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ff1:	74 08                	je     800ffb <strtol+0x134>
		*endptr = (char *) s;
  800ff3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff6:	8b 55 08             	mov    0x8(%ebp),%edx
  800ff9:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800ffb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fff:	74 07                	je     801008 <strtol+0x141>
  801001:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801004:	f7 d8                	neg    %eax
  801006:	eb 03                	jmp    80100b <strtol+0x144>
  801008:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80100b:	c9                   	leave  
  80100c:	c3                   	ret    

0080100d <ltostr>:

void
ltostr(long value, char *str)
{
  80100d:	55                   	push   %ebp
  80100e:	89 e5                	mov    %esp,%ebp
  801010:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801013:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80101a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801021:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801025:	79 13                	jns    80103a <ltostr+0x2d>
	{
		neg = 1;
  801027:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80102e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801031:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801034:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801037:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80103a:	8b 45 08             	mov    0x8(%ebp),%eax
  80103d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801042:	99                   	cltd   
  801043:	f7 f9                	idiv   %ecx
  801045:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801048:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80104b:	8d 50 01             	lea    0x1(%eax),%edx
  80104e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801051:	89 c2                	mov    %eax,%edx
  801053:	8b 45 0c             	mov    0xc(%ebp),%eax
  801056:	01 d0                	add    %edx,%eax
  801058:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80105b:	83 c2 30             	add    $0x30,%edx
  80105e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801060:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801063:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801068:	f7 e9                	imul   %ecx
  80106a:	c1 fa 02             	sar    $0x2,%edx
  80106d:	89 c8                	mov    %ecx,%eax
  80106f:	c1 f8 1f             	sar    $0x1f,%eax
  801072:	29 c2                	sub    %eax,%edx
  801074:	89 d0                	mov    %edx,%eax
  801076:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801079:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80107c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801081:	f7 e9                	imul   %ecx
  801083:	c1 fa 02             	sar    $0x2,%edx
  801086:	89 c8                	mov    %ecx,%eax
  801088:	c1 f8 1f             	sar    $0x1f,%eax
  80108b:	29 c2                	sub    %eax,%edx
  80108d:	89 d0                	mov    %edx,%eax
  80108f:	c1 e0 02             	shl    $0x2,%eax
  801092:	01 d0                	add    %edx,%eax
  801094:	01 c0                	add    %eax,%eax
  801096:	29 c1                	sub    %eax,%ecx
  801098:	89 ca                	mov    %ecx,%edx
  80109a:	85 d2                	test   %edx,%edx
  80109c:	75 9c                	jne    80103a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80109e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010a8:	48                   	dec    %eax
  8010a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010ac:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010b0:	74 3d                	je     8010ef <ltostr+0xe2>
		start = 1 ;
  8010b2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010b9:	eb 34                	jmp    8010ef <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c1:	01 d0                	add    %edx,%eax
  8010c3:	8a 00                	mov    (%eax),%al
  8010c5:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010c8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ce:	01 c2                	add    %eax,%edx
  8010d0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d6:	01 c8                	add    %ecx,%eax
  8010d8:	8a 00                	mov    (%eax),%al
  8010da:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010dc:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e2:	01 c2                	add    %eax,%edx
  8010e4:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010e7:	88 02                	mov    %al,(%edx)
		start++ ;
  8010e9:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010ec:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010f2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010f5:	7c c4                	jl     8010bb <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010f7:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fd:	01 d0                	add    %edx,%eax
  8010ff:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801102:	90                   	nop
  801103:	c9                   	leave  
  801104:	c3                   	ret    

00801105 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801105:	55                   	push   %ebp
  801106:	89 e5                	mov    %esp,%ebp
  801108:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80110b:	ff 75 08             	pushl  0x8(%ebp)
  80110e:	e8 54 fa ff ff       	call   800b67 <strlen>
  801113:	83 c4 04             	add    $0x4,%esp
  801116:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801119:	ff 75 0c             	pushl  0xc(%ebp)
  80111c:	e8 46 fa ff ff       	call   800b67 <strlen>
  801121:	83 c4 04             	add    $0x4,%esp
  801124:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801127:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80112e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801135:	eb 17                	jmp    80114e <strcconcat+0x49>
		final[s] = str1[s] ;
  801137:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80113a:	8b 45 10             	mov    0x10(%ebp),%eax
  80113d:	01 c2                	add    %eax,%edx
  80113f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801142:	8b 45 08             	mov    0x8(%ebp),%eax
  801145:	01 c8                	add    %ecx,%eax
  801147:	8a 00                	mov    (%eax),%al
  801149:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80114b:	ff 45 fc             	incl   -0x4(%ebp)
  80114e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801151:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801154:	7c e1                	jl     801137 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801156:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80115d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801164:	eb 1f                	jmp    801185 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801166:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801169:	8d 50 01             	lea    0x1(%eax),%edx
  80116c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80116f:	89 c2                	mov    %eax,%edx
  801171:	8b 45 10             	mov    0x10(%ebp),%eax
  801174:	01 c2                	add    %eax,%edx
  801176:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801179:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117c:	01 c8                	add    %ecx,%eax
  80117e:	8a 00                	mov    (%eax),%al
  801180:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801182:	ff 45 f8             	incl   -0x8(%ebp)
  801185:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801188:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80118b:	7c d9                	jl     801166 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80118d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801190:	8b 45 10             	mov    0x10(%ebp),%eax
  801193:	01 d0                	add    %edx,%eax
  801195:	c6 00 00             	movb   $0x0,(%eax)
}
  801198:	90                   	nop
  801199:	c9                   	leave  
  80119a:	c3                   	ret    

0080119b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80119b:	55                   	push   %ebp
  80119c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80119e:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8011aa:	8b 00                	mov    (%eax),%eax
  8011ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b6:	01 d0                	add    %edx,%eax
  8011b8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011be:	eb 0c                	jmp    8011cc <strsplit+0x31>
			*string++ = 0;
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	8d 50 01             	lea    0x1(%eax),%edx
  8011c6:	89 55 08             	mov    %edx,0x8(%ebp)
  8011c9:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cf:	8a 00                	mov    (%eax),%al
  8011d1:	84 c0                	test   %al,%al
  8011d3:	74 18                	je     8011ed <strsplit+0x52>
  8011d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d8:	8a 00                	mov    (%eax),%al
  8011da:	0f be c0             	movsbl %al,%eax
  8011dd:	50                   	push   %eax
  8011de:	ff 75 0c             	pushl  0xc(%ebp)
  8011e1:	e8 13 fb ff ff       	call   800cf9 <strchr>
  8011e6:	83 c4 08             	add    $0x8,%esp
  8011e9:	85 c0                	test   %eax,%eax
  8011eb:	75 d3                	jne    8011c0 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8011ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f0:	8a 00                	mov    (%eax),%al
  8011f2:	84 c0                	test   %al,%al
  8011f4:	74 5a                	je     801250 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8011f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f9:	8b 00                	mov    (%eax),%eax
  8011fb:	83 f8 0f             	cmp    $0xf,%eax
  8011fe:	75 07                	jne    801207 <strsplit+0x6c>
		{
			return 0;
  801200:	b8 00 00 00 00       	mov    $0x0,%eax
  801205:	eb 66                	jmp    80126d <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801207:	8b 45 14             	mov    0x14(%ebp),%eax
  80120a:	8b 00                	mov    (%eax),%eax
  80120c:	8d 48 01             	lea    0x1(%eax),%ecx
  80120f:	8b 55 14             	mov    0x14(%ebp),%edx
  801212:	89 0a                	mov    %ecx,(%edx)
  801214:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80121b:	8b 45 10             	mov    0x10(%ebp),%eax
  80121e:	01 c2                	add    %eax,%edx
  801220:	8b 45 08             	mov    0x8(%ebp),%eax
  801223:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801225:	eb 03                	jmp    80122a <strsplit+0x8f>
			string++;
  801227:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80122a:	8b 45 08             	mov    0x8(%ebp),%eax
  80122d:	8a 00                	mov    (%eax),%al
  80122f:	84 c0                	test   %al,%al
  801231:	74 8b                	je     8011be <strsplit+0x23>
  801233:	8b 45 08             	mov    0x8(%ebp),%eax
  801236:	8a 00                	mov    (%eax),%al
  801238:	0f be c0             	movsbl %al,%eax
  80123b:	50                   	push   %eax
  80123c:	ff 75 0c             	pushl  0xc(%ebp)
  80123f:	e8 b5 fa ff ff       	call   800cf9 <strchr>
  801244:	83 c4 08             	add    $0x8,%esp
  801247:	85 c0                	test   %eax,%eax
  801249:	74 dc                	je     801227 <strsplit+0x8c>
			string++;
	}
  80124b:	e9 6e ff ff ff       	jmp    8011be <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801250:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801251:	8b 45 14             	mov    0x14(%ebp),%eax
  801254:	8b 00                	mov    (%eax),%eax
  801256:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80125d:	8b 45 10             	mov    0x10(%ebp),%eax
  801260:	01 d0                	add    %edx,%eax
  801262:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801268:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80126d:	c9                   	leave  
  80126e:	c3                   	ret    

0080126f <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80126f:	55                   	push   %ebp
  801270:	89 e5                	mov    %esp,%ebp
  801272:	57                   	push   %edi
  801273:	56                   	push   %esi
  801274:	53                   	push   %ebx
  801275:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80127e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801281:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801284:	8b 7d 18             	mov    0x18(%ebp),%edi
  801287:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80128a:	cd 30                	int    $0x30
  80128c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80128f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801292:	83 c4 10             	add    $0x10,%esp
  801295:	5b                   	pop    %ebx
  801296:	5e                   	pop    %esi
  801297:	5f                   	pop    %edi
  801298:	5d                   	pop    %ebp
  801299:	c3                   	ret    

0080129a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80129a:	55                   	push   %ebp
  80129b:	89 e5                	mov    %esp,%ebp
  80129d:	83 ec 04             	sub    $0x4,%esp
  8012a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012a6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ad:	6a 00                	push   $0x0
  8012af:	6a 00                	push   $0x0
  8012b1:	52                   	push   %edx
  8012b2:	ff 75 0c             	pushl  0xc(%ebp)
  8012b5:	50                   	push   %eax
  8012b6:	6a 00                	push   $0x0
  8012b8:	e8 b2 ff ff ff       	call   80126f <syscall>
  8012bd:	83 c4 18             	add    $0x18,%esp
}
  8012c0:	90                   	nop
  8012c1:	c9                   	leave  
  8012c2:	c3                   	ret    

008012c3 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012c3:	55                   	push   %ebp
  8012c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012c6:	6a 00                	push   $0x0
  8012c8:	6a 00                	push   $0x0
  8012ca:	6a 00                	push   $0x0
  8012cc:	6a 00                	push   $0x0
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 01                	push   $0x1
  8012d2:	e8 98 ff ff ff       	call   80126f <syscall>
  8012d7:	83 c4 18             	add    $0x18,%esp
}
  8012da:	c9                   	leave  
  8012db:	c3                   	ret    

008012dc <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012dc:	55                   	push   %ebp
  8012dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012df:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e2:	6a 00                	push   $0x0
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	50                   	push   %eax
  8012eb:	6a 05                	push   $0x5
  8012ed:	e8 7d ff ff ff       	call   80126f <syscall>
  8012f2:	83 c4 18             	add    $0x18,%esp
}
  8012f5:	c9                   	leave  
  8012f6:	c3                   	ret    

008012f7 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012f7:	55                   	push   %ebp
  8012f8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	6a 00                	push   $0x0
  801304:	6a 02                	push   $0x2
  801306:	e8 64 ff ff ff       	call   80126f <syscall>
  80130b:	83 c4 18             	add    $0x18,%esp
}
  80130e:	c9                   	leave  
  80130f:	c3                   	ret    

00801310 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801310:	55                   	push   %ebp
  801311:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801313:	6a 00                	push   $0x0
  801315:	6a 00                	push   $0x0
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	6a 03                	push   $0x3
  80131f:	e8 4b ff ff ff       	call   80126f <syscall>
  801324:	83 c4 18             	add    $0x18,%esp
}
  801327:	c9                   	leave  
  801328:	c3                   	ret    

00801329 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801329:	55                   	push   %ebp
  80132a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	6a 00                	push   $0x0
  801336:	6a 04                	push   $0x4
  801338:	e8 32 ff ff ff       	call   80126f <syscall>
  80133d:	83 c4 18             	add    $0x18,%esp
}
  801340:	c9                   	leave  
  801341:	c3                   	ret    

00801342 <sys_env_exit>:


void sys_env_exit(void)
{
  801342:	55                   	push   %ebp
  801343:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801345:	6a 00                	push   $0x0
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	6a 00                	push   $0x0
  80134d:	6a 00                	push   $0x0
  80134f:	6a 06                	push   $0x6
  801351:	e8 19 ff ff ff       	call   80126f <syscall>
  801356:	83 c4 18             	add    $0x18,%esp
}
  801359:	90                   	nop
  80135a:	c9                   	leave  
  80135b:	c3                   	ret    

0080135c <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80135c:	55                   	push   %ebp
  80135d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80135f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	6a 00                	push   $0x0
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	52                   	push   %edx
  80136c:	50                   	push   %eax
  80136d:	6a 07                	push   $0x7
  80136f:	e8 fb fe ff ff       	call   80126f <syscall>
  801374:	83 c4 18             	add    $0x18,%esp
}
  801377:	c9                   	leave  
  801378:	c3                   	ret    

00801379 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801379:	55                   	push   %ebp
  80137a:	89 e5                	mov    %esp,%ebp
  80137c:	56                   	push   %esi
  80137d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80137e:	8b 75 18             	mov    0x18(%ebp),%esi
  801381:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801384:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801387:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138a:	8b 45 08             	mov    0x8(%ebp),%eax
  80138d:	56                   	push   %esi
  80138e:	53                   	push   %ebx
  80138f:	51                   	push   %ecx
  801390:	52                   	push   %edx
  801391:	50                   	push   %eax
  801392:	6a 08                	push   $0x8
  801394:	e8 d6 fe ff ff       	call   80126f <syscall>
  801399:	83 c4 18             	add    $0x18,%esp
}
  80139c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80139f:	5b                   	pop    %ebx
  8013a0:	5e                   	pop    %esi
  8013a1:	5d                   	pop    %ebp
  8013a2:	c3                   	ret    

008013a3 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013a3:	55                   	push   %ebp
  8013a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ac:	6a 00                	push   $0x0
  8013ae:	6a 00                	push   $0x0
  8013b0:	6a 00                	push   $0x0
  8013b2:	52                   	push   %edx
  8013b3:	50                   	push   %eax
  8013b4:	6a 09                	push   $0x9
  8013b6:	e8 b4 fe ff ff       	call   80126f <syscall>
  8013bb:	83 c4 18             	add    $0x18,%esp
}
  8013be:	c9                   	leave  
  8013bf:	c3                   	ret    

008013c0 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013c0:	55                   	push   %ebp
  8013c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	6a 00                	push   $0x0
  8013c9:	ff 75 0c             	pushl  0xc(%ebp)
  8013cc:	ff 75 08             	pushl  0x8(%ebp)
  8013cf:	6a 0a                	push   $0xa
  8013d1:	e8 99 fe ff ff       	call   80126f <syscall>
  8013d6:	83 c4 18             	add    $0x18,%esp
}
  8013d9:	c9                   	leave  
  8013da:	c3                   	ret    

008013db <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013db:	55                   	push   %ebp
  8013dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 0b                	push   $0xb
  8013ea:	e8 80 fe ff ff       	call   80126f <syscall>
  8013ef:	83 c4 18             	add    $0x18,%esp
}
  8013f2:	c9                   	leave  
  8013f3:	c3                   	ret    

008013f4 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013f4:	55                   	push   %ebp
  8013f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 0c                	push   $0xc
  801403:	e8 67 fe ff ff       	call   80126f <syscall>
  801408:	83 c4 18             	add    $0x18,%esp
}
  80140b:	c9                   	leave  
  80140c:	c3                   	ret    

0080140d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80140d:	55                   	push   %ebp
  80140e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	6a 00                	push   $0x0
  80141a:	6a 0d                	push   $0xd
  80141c:	e8 4e fe ff ff       	call   80126f <syscall>
  801421:	83 c4 18             	add    $0x18,%esp
}
  801424:	c9                   	leave  
  801425:	c3                   	ret    

00801426 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801426:	55                   	push   %ebp
  801427:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	6a 00                	push   $0x0
  80142f:	ff 75 0c             	pushl  0xc(%ebp)
  801432:	ff 75 08             	pushl  0x8(%ebp)
  801435:	6a 11                	push   $0x11
  801437:	e8 33 fe ff ff       	call   80126f <syscall>
  80143c:	83 c4 18             	add    $0x18,%esp
	return;
  80143f:	90                   	nop
}
  801440:	c9                   	leave  
  801441:	c3                   	ret    

00801442 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801442:	55                   	push   %ebp
  801443:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801445:	6a 00                	push   $0x0
  801447:	6a 00                	push   $0x0
  801449:	6a 00                	push   $0x0
  80144b:	ff 75 0c             	pushl  0xc(%ebp)
  80144e:	ff 75 08             	pushl  0x8(%ebp)
  801451:	6a 12                	push   $0x12
  801453:	e8 17 fe ff ff       	call   80126f <syscall>
  801458:	83 c4 18             	add    $0x18,%esp
	return ;
  80145b:	90                   	nop
}
  80145c:	c9                   	leave  
  80145d:	c3                   	ret    

0080145e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80145e:	55                   	push   %ebp
  80145f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801461:	6a 00                	push   $0x0
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	6a 00                	push   $0x0
  80146b:	6a 0e                	push   $0xe
  80146d:	e8 fd fd ff ff       	call   80126f <syscall>
  801472:	83 c4 18             	add    $0x18,%esp
}
  801475:	c9                   	leave  
  801476:	c3                   	ret    

00801477 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	ff 75 08             	pushl  0x8(%ebp)
  801485:	6a 0f                	push   $0xf
  801487:	e8 e3 fd ff ff       	call   80126f <syscall>
  80148c:	83 c4 18             	add    $0x18,%esp
}
  80148f:	c9                   	leave  
  801490:	c3                   	ret    

00801491 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801491:	55                   	push   %ebp
  801492:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	6a 10                	push   $0x10
  8014a0:	e8 ca fd ff ff       	call   80126f <syscall>
  8014a5:	83 c4 18             	add    $0x18,%esp
}
  8014a8:	90                   	nop
  8014a9:	c9                   	leave  
  8014aa:	c3                   	ret    

008014ab <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014ab:	55                   	push   %ebp
  8014ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 14                	push   $0x14
  8014ba:	e8 b0 fd ff ff       	call   80126f <syscall>
  8014bf:	83 c4 18             	add    $0x18,%esp
}
  8014c2:	90                   	nop
  8014c3:	c9                   	leave  
  8014c4:	c3                   	ret    

008014c5 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 15                	push   $0x15
  8014d4:	e8 96 fd ff ff       	call   80126f <syscall>
  8014d9:	83 c4 18             	add    $0x18,%esp
}
  8014dc:	90                   	nop
  8014dd:	c9                   	leave  
  8014de:	c3                   	ret    

008014df <sys_cputc>:


void
sys_cputc(const char c)
{
  8014df:	55                   	push   %ebp
  8014e0:	89 e5                	mov    %esp,%ebp
  8014e2:	83 ec 04             	sub    $0x4,%esp
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014eb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	50                   	push   %eax
  8014f8:	6a 16                	push   $0x16
  8014fa:	e8 70 fd ff ff       	call   80126f <syscall>
  8014ff:	83 c4 18             	add    $0x18,%esp
}
  801502:	90                   	nop
  801503:	c9                   	leave  
  801504:	c3                   	ret    

00801505 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801505:	55                   	push   %ebp
  801506:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801508:	6a 00                	push   $0x0
  80150a:	6a 00                	push   $0x0
  80150c:	6a 00                	push   $0x0
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 17                	push   $0x17
  801514:	e8 56 fd ff ff       	call   80126f <syscall>
  801519:	83 c4 18             	add    $0x18,%esp
}
  80151c:	90                   	nop
  80151d:	c9                   	leave  
  80151e:	c3                   	ret    

0080151f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80151f:	55                   	push   %ebp
  801520:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801522:	8b 45 08             	mov    0x8(%ebp),%eax
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	ff 75 0c             	pushl  0xc(%ebp)
  80152e:	50                   	push   %eax
  80152f:	6a 18                	push   $0x18
  801531:	e8 39 fd ff ff       	call   80126f <syscall>
  801536:	83 c4 18             	add    $0x18,%esp
}
  801539:	c9                   	leave  
  80153a:	c3                   	ret    

0080153b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80153b:	55                   	push   %ebp
  80153c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80153e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801541:	8b 45 08             	mov    0x8(%ebp),%eax
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	52                   	push   %edx
  80154b:	50                   	push   %eax
  80154c:	6a 1b                	push   $0x1b
  80154e:	e8 1c fd ff ff       	call   80126f <syscall>
  801553:	83 c4 18             	add    $0x18,%esp
}
  801556:	c9                   	leave  
  801557:	c3                   	ret    

00801558 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801558:	55                   	push   %ebp
  801559:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80155b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155e:	8b 45 08             	mov    0x8(%ebp),%eax
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	52                   	push   %edx
  801568:	50                   	push   %eax
  801569:	6a 19                	push   $0x19
  80156b:	e8 ff fc ff ff       	call   80126f <syscall>
  801570:	83 c4 18             	add    $0x18,%esp
}
  801573:	90                   	nop
  801574:	c9                   	leave  
  801575:	c3                   	ret    

00801576 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801576:	55                   	push   %ebp
  801577:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801579:	8b 55 0c             	mov    0xc(%ebp),%edx
  80157c:	8b 45 08             	mov    0x8(%ebp),%eax
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	52                   	push   %edx
  801586:	50                   	push   %eax
  801587:	6a 1a                	push   $0x1a
  801589:	e8 e1 fc ff ff       	call   80126f <syscall>
  80158e:	83 c4 18             	add    $0x18,%esp
}
  801591:	90                   	nop
  801592:	c9                   	leave  
  801593:	c3                   	ret    

00801594 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801594:	55                   	push   %ebp
  801595:	89 e5                	mov    %esp,%ebp
  801597:	83 ec 04             	sub    $0x4,%esp
  80159a:	8b 45 10             	mov    0x10(%ebp),%eax
  80159d:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015a0:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015a3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015aa:	6a 00                	push   $0x0
  8015ac:	51                   	push   %ecx
  8015ad:	52                   	push   %edx
  8015ae:	ff 75 0c             	pushl  0xc(%ebp)
  8015b1:	50                   	push   %eax
  8015b2:	6a 1c                	push   $0x1c
  8015b4:	e8 b6 fc ff ff       	call   80126f <syscall>
  8015b9:	83 c4 18             	add    $0x18,%esp
}
  8015bc:	c9                   	leave  
  8015bd:	c3                   	ret    

008015be <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015be:	55                   	push   %ebp
  8015bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 00                	push   $0x0
  8015cd:	52                   	push   %edx
  8015ce:	50                   	push   %eax
  8015cf:	6a 1d                	push   $0x1d
  8015d1:	e8 99 fc ff ff       	call   80126f <syscall>
  8015d6:	83 c4 18             	add    $0x18,%esp
}
  8015d9:	c9                   	leave  
  8015da:	c3                   	ret    

008015db <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015db:	55                   	push   %ebp
  8015dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015de:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	51                   	push   %ecx
  8015ec:	52                   	push   %edx
  8015ed:	50                   	push   %eax
  8015ee:	6a 1e                	push   $0x1e
  8015f0:	e8 7a fc ff ff       	call   80126f <syscall>
  8015f5:	83 c4 18             	add    $0x18,%esp
}
  8015f8:	c9                   	leave  
  8015f9:	c3                   	ret    

008015fa <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015fa:	55                   	push   %ebp
  8015fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801600:	8b 45 08             	mov    0x8(%ebp),%eax
  801603:	6a 00                	push   $0x0
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	52                   	push   %edx
  80160a:	50                   	push   %eax
  80160b:	6a 1f                	push   $0x1f
  80160d:	e8 5d fc ff ff       	call   80126f <syscall>
  801612:	83 c4 18             	add    $0x18,%esp
}
  801615:	c9                   	leave  
  801616:	c3                   	ret    

00801617 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801617:	55                   	push   %ebp
  801618:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	6a 00                	push   $0x0
  801624:	6a 20                	push   $0x20
  801626:	e8 44 fc ff ff       	call   80126f <syscall>
  80162b:	83 c4 18             	add    $0x18,%esp
}
  80162e:	c9                   	leave  
  80162f:	c3                   	ret    

00801630 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801630:	55                   	push   %ebp
  801631:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801633:	8b 45 08             	mov    0x8(%ebp),%eax
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	ff 75 10             	pushl  0x10(%ebp)
  80163d:	ff 75 0c             	pushl  0xc(%ebp)
  801640:	50                   	push   %eax
  801641:	6a 21                	push   $0x21
  801643:	e8 27 fc ff ff       	call   80126f <syscall>
  801648:	83 c4 18             	add    $0x18,%esp
}
  80164b:	c9                   	leave  
  80164c:	c3                   	ret    

0080164d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80164d:	55                   	push   %ebp
  80164e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	6a 00                	push   $0x0
  801655:	6a 00                	push   $0x0
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	50                   	push   %eax
  80165c:	6a 22                	push   $0x22
  80165e:	e8 0c fc ff ff       	call   80126f <syscall>
  801663:	83 c4 18             	add    $0x18,%esp
}
  801666:	90                   	nop
  801667:	c9                   	leave  
  801668:	c3                   	ret    

00801669 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801669:	55                   	push   %ebp
  80166a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	50                   	push   %eax
  801678:	6a 23                	push   $0x23
  80167a:	e8 f0 fb ff ff       	call   80126f <syscall>
  80167f:	83 c4 18             	add    $0x18,%esp
}
  801682:	90                   	nop
  801683:	c9                   	leave  
  801684:	c3                   	ret    

00801685 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801685:	55                   	push   %ebp
  801686:	89 e5                	mov    %esp,%ebp
  801688:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80168b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80168e:	8d 50 04             	lea    0x4(%eax),%edx
  801691:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	52                   	push   %edx
  80169b:	50                   	push   %eax
  80169c:	6a 24                	push   $0x24
  80169e:	e8 cc fb ff ff       	call   80126f <syscall>
  8016a3:	83 c4 18             	add    $0x18,%esp
	return result;
  8016a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ac:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016af:	89 01                	mov    %eax,(%ecx)
  8016b1:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b7:	c9                   	leave  
  8016b8:	c2 04 00             	ret    $0x4

008016bb <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016bb:	55                   	push   %ebp
  8016bc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	ff 75 10             	pushl  0x10(%ebp)
  8016c5:	ff 75 0c             	pushl  0xc(%ebp)
  8016c8:	ff 75 08             	pushl  0x8(%ebp)
  8016cb:	6a 13                	push   $0x13
  8016cd:	e8 9d fb ff ff       	call   80126f <syscall>
  8016d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8016d5:	90                   	nop
}
  8016d6:	c9                   	leave  
  8016d7:	c3                   	ret    

008016d8 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016d8:	55                   	push   %ebp
  8016d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 25                	push   $0x25
  8016e7:	e8 83 fb ff ff       	call   80126f <syscall>
  8016ec:	83 c4 18             	add    $0x18,%esp
}
  8016ef:	c9                   	leave  
  8016f0:	c3                   	ret    

008016f1 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016f1:	55                   	push   %ebp
  8016f2:	89 e5                	mov    %esp,%ebp
  8016f4:	83 ec 04             	sub    $0x4,%esp
  8016f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016fd:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	50                   	push   %eax
  80170a:	6a 26                	push   $0x26
  80170c:	e8 5e fb ff ff       	call   80126f <syscall>
  801711:	83 c4 18             	add    $0x18,%esp
	return ;
  801714:	90                   	nop
}
  801715:	c9                   	leave  
  801716:	c3                   	ret    

00801717 <rsttst>:
void rsttst()
{
  801717:	55                   	push   %ebp
  801718:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	6a 28                	push   $0x28
  801726:	e8 44 fb ff ff       	call   80126f <syscall>
  80172b:	83 c4 18             	add    $0x18,%esp
	return ;
  80172e:	90                   	nop
}
  80172f:	c9                   	leave  
  801730:	c3                   	ret    

00801731 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801731:	55                   	push   %ebp
  801732:	89 e5                	mov    %esp,%ebp
  801734:	83 ec 04             	sub    $0x4,%esp
  801737:	8b 45 14             	mov    0x14(%ebp),%eax
  80173a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80173d:	8b 55 18             	mov    0x18(%ebp),%edx
  801740:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801744:	52                   	push   %edx
  801745:	50                   	push   %eax
  801746:	ff 75 10             	pushl  0x10(%ebp)
  801749:	ff 75 0c             	pushl  0xc(%ebp)
  80174c:	ff 75 08             	pushl  0x8(%ebp)
  80174f:	6a 27                	push   $0x27
  801751:	e8 19 fb ff ff       	call   80126f <syscall>
  801756:	83 c4 18             	add    $0x18,%esp
	return ;
  801759:	90                   	nop
}
  80175a:	c9                   	leave  
  80175b:	c3                   	ret    

0080175c <chktst>:
void chktst(uint32 n)
{
  80175c:	55                   	push   %ebp
  80175d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	ff 75 08             	pushl  0x8(%ebp)
  80176a:	6a 29                	push   $0x29
  80176c:	e8 fe fa ff ff       	call   80126f <syscall>
  801771:	83 c4 18             	add    $0x18,%esp
	return ;
  801774:	90                   	nop
}
  801775:	c9                   	leave  
  801776:	c3                   	ret    

00801777 <inctst>:

void inctst()
{
  801777:	55                   	push   %ebp
  801778:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 2a                	push   $0x2a
  801786:	e8 e4 fa ff ff       	call   80126f <syscall>
  80178b:	83 c4 18             	add    $0x18,%esp
	return ;
  80178e:	90                   	nop
}
  80178f:	c9                   	leave  
  801790:	c3                   	ret    

00801791 <gettst>:
uint32 gettst()
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 2b                	push   $0x2b
  8017a0:	e8 ca fa ff ff       	call   80126f <syscall>
  8017a5:	83 c4 18             	add    $0x18,%esp
}
  8017a8:	c9                   	leave  
  8017a9:	c3                   	ret    

008017aa <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017aa:	55                   	push   %ebp
  8017ab:	89 e5                	mov    %esp,%ebp
  8017ad:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 2c                	push   $0x2c
  8017bc:	e8 ae fa ff ff       	call   80126f <syscall>
  8017c1:	83 c4 18             	add    $0x18,%esp
  8017c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017c7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017cb:	75 07                	jne    8017d4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017cd:	b8 01 00 00 00       	mov    $0x1,%eax
  8017d2:	eb 05                	jmp    8017d9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017d9:	c9                   	leave  
  8017da:	c3                   	ret    

008017db <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017db:	55                   	push   %ebp
  8017dc:	89 e5                	mov    %esp,%ebp
  8017de:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 2c                	push   $0x2c
  8017ed:	e8 7d fa ff ff       	call   80126f <syscall>
  8017f2:	83 c4 18             	add    $0x18,%esp
  8017f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017f8:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017fc:	75 07                	jne    801805 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017fe:	b8 01 00 00 00       	mov    $0x1,%eax
  801803:	eb 05                	jmp    80180a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801805:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80180a:	c9                   	leave  
  80180b:	c3                   	ret    

0080180c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80180c:	55                   	push   %ebp
  80180d:	89 e5                	mov    %esp,%ebp
  80180f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 2c                	push   $0x2c
  80181e:	e8 4c fa ff ff       	call   80126f <syscall>
  801823:	83 c4 18             	add    $0x18,%esp
  801826:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801829:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80182d:	75 07                	jne    801836 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80182f:	b8 01 00 00 00       	mov    $0x1,%eax
  801834:	eb 05                	jmp    80183b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801836:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80183b:	c9                   	leave  
  80183c:	c3                   	ret    

0080183d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80183d:	55                   	push   %ebp
  80183e:	89 e5                	mov    %esp,%ebp
  801840:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	6a 2c                	push   $0x2c
  80184f:	e8 1b fa ff ff       	call   80126f <syscall>
  801854:	83 c4 18             	add    $0x18,%esp
  801857:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80185a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80185e:	75 07                	jne    801867 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801860:	b8 01 00 00 00       	mov    $0x1,%eax
  801865:	eb 05                	jmp    80186c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801867:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80186c:	c9                   	leave  
  80186d:	c3                   	ret    

0080186e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80186e:	55                   	push   %ebp
  80186f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	ff 75 08             	pushl  0x8(%ebp)
  80187c:	6a 2d                	push   $0x2d
  80187e:	e8 ec f9 ff ff       	call   80126f <syscall>
  801883:	83 c4 18             	add    $0x18,%esp
	return ;
  801886:	90                   	nop
}
  801887:	c9                   	leave  
  801888:	c3                   	ret    
  801889:	66 90                	xchg   %ax,%ax
  80188b:	90                   	nop

0080188c <__udivdi3>:
  80188c:	55                   	push   %ebp
  80188d:	57                   	push   %edi
  80188e:	56                   	push   %esi
  80188f:	53                   	push   %ebx
  801890:	83 ec 1c             	sub    $0x1c,%esp
  801893:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801897:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80189b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80189f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8018a3:	89 ca                	mov    %ecx,%edx
  8018a5:	89 f8                	mov    %edi,%eax
  8018a7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8018ab:	85 f6                	test   %esi,%esi
  8018ad:	75 2d                	jne    8018dc <__udivdi3+0x50>
  8018af:	39 cf                	cmp    %ecx,%edi
  8018b1:	77 65                	ja     801918 <__udivdi3+0x8c>
  8018b3:	89 fd                	mov    %edi,%ebp
  8018b5:	85 ff                	test   %edi,%edi
  8018b7:	75 0b                	jne    8018c4 <__udivdi3+0x38>
  8018b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8018be:	31 d2                	xor    %edx,%edx
  8018c0:	f7 f7                	div    %edi
  8018c2:	89 c5                	mov    %eax,%ebp
  8018c4:	31 d2                	xor    %edx,%edx
  8018c6:	89 c8                	mov    %ecx,%eax
  8018c8:	f7 f5                	div    %ebp
  8018ca:	89 c1                	mov    %eax,%ecx
  8018cc:	89 d8                	mov    %ebx,%eax
  8018ce:	f7 f5                	div    %ebp
  8018d0:	89 cf                	mov    %ecx,%edi
  8018d2:	89 fa                	mov    %edi,%edx
  8018d4:	83 c4 1c             	add    $0x1c,%esp
  8018d7:	5b                   	pop    %ebx
  8018d8:	5e                   	pop    %esi
  8018d9:	5f                   	pop    %edi
  8018da:	5d                   	pop    %ebp
  8018db:	c3                   	ret    
  8018dc:	39 ce                	cmp    %ecx,%esi
  8018de:	77 28                	ja     801908 <__udivdi3+0x7c>
  8018e0:	0f bd fe             	bsr    %esi,%edi
  8018e3:	83 f7 1f             	xor    $0x1f,%edi
  8018e6:	75 40                	jne    801928 <__udivdi3+0x9c>
  8018e8:	39 ce                	cmp    %ecx,%esi
  8018ea:	72 0a                	jb     8018f6 <__udivdi3+0x6a>
  8018ec:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8018f0:	0f 87 9e 00 00 00    	ja     801994 <__udivdi3+0x108>
  8018f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8018fb:	89 fa                	mov    %edi,%edx
  8018fd:	83 c4 1c             	add    $0x1c,%esp
  801900:	5b                   	pop    %ebx
  801901:	5e                   	pop    %esi
  801902:	5f                   	pop    %edi
  801903:	5d                   	pop    %ebp
  801904:	c3                   	ret    
  801905:	8d 76 00             	lea    0x0(%esi),%esi
  801908:	31 ff                	xor    %edi,%edi
  80190a:	31 c0                	xor    %eax,%eax
  80190c:	89 fa                	mov    %edi,%edx
  80190e:	83 c4 1c             	add    $0x1c,%esp
  801911:	5b                   	pop    %ebx
  801912:	5e                   	pop    %esi
  801913:	5f                   	pop    %edi
  801914:	5d                   	pop    %ebp
  801915:	c3                   	ret    
  801916:	66 90                	xchg   %ax,%ax
  801918:	89 d8                	mov    %ebx,%eax
  80191a:	f7 f7                	div    %edi
  80191c:	31 ff                	xor    %edi,%edi
  80191e:	89 fa                	mov    %edi,%edx
  801920:	83 c4 1c             	add    $0x1c,%esp
  801923:	5b                   	pop    %ebx
  801924:	5e                   	pop    %esi
  801925:	5f                   	pop    %edi
  801926:	5d                   	pop    %ebp
  801927:	c3                   	ret    
  801928:	bd 20 00 00 00       	mov    $0x20,%ebp
  80192d:	89 eb                	mov    %ebp,%ebx
  80192f:	29 fb                	sub    %edi,%ebx
  801931:	89 f9                	mov    %edi,%ecx
  801933:	d3 e6                	shl    %cl,%esi
  801935:	89 c5                	mov    %eax,%ebp
  801937:	88 d9                	mov    %bl,%cl
  801939:	d3 ed                	shr    %cl,%ebp
  80193b:	89 e9                	mov    %ebp,%ecx
  80193d:	09 f1                	or     %esi,%ecx
  80193f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801943:	89 f9                	mov    %edi,%ecx
  801945:	d3 e0                	shl    %cl,%eax
  801947:	89 c5                	mov    %eax,%ebp
  801949:	89 d6                	mov    %edx,%esi
  80194b:	88 d9                	mov    %bl,%cl
  80194d:	d3 ee                	shr    %cl,%esi
  80194f:	89 f9                	mov    %edi,%ecx
  801951:	d3 e2                	shl    %cl,%edx
  801953:	8b 44 24 08          	mov    0x8(%esp),%eax
  801957:	88 d9                	mov    %bl,%cl
  801959:	d3 e8                	shr    %cl,%eax
  80195b:	09 c2                	or     %eax,%edx
  80195d:	89 d0                	mov    %edx,%eax
  80195f:	89 f2                	mov    %esi,%edx
  801961:	f7 74 24 0c          	divl   0xc(%esp)
  801965:	89 d6                	mov    %edx,%esi
  801967:	89 c3                	mov    %eax,%ebx
  801969:	f7 e5                	mul    %ebp
  80196b:	39 d6                	cmp    %edx,%esi
  80196d:	72 19                	jb     801988 <__udivdi3+0xfc>
  80196f:	74 0b                	je     80197c <__udivdi3+0xf0>
  801971:	89 d8                	mov    %ebx,%eax
  801973:	31 ff                	xor    %edi,%edi
  801975:	e9 58 ff ff ff       	jmp    8018d2 <__udivdi3+0x46>
  80197a:	66 90                	xchg   %ax,%ax
  80197c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801980:	89 f9                	mov    %edi,%ecx
  801982:	d3 e2                	shl    %cl,%edx
  801984:	39 c2                	cmp    %eax,%edx
  801986:	73 e9                	jae    801971 <__udivdi3+0xe5>
  801988:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80198b:	31 ff                	xor    %edi,%edi
  80198d:	e9 40 ff ff ff       	jmp    8018d2 <__udivdi3+0x46>
  801992:	66 90                	xchg   %ax,%ax
  801994:	31 c0                	xor    %eax,%eax
  801996:	e9 37 ff ff ff       	jmp    8018d2 <__udivdi3+0x46>
  80199b:	90                   	nop

0080199c <__umoddi3>:
  80199c:	55                   	push   %ebp
  80199d:	57                   	push   %edi
  80199e:	56                   	push   %esi
  80199f:	53                   	push   %ebx
  8019a0:	83 ec 1c             	sub    $0x1c,%esp
  8019a3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8019a7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8019ab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019af:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8019b3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8019b7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8019bb:	89 f3                	mov    %esi,%ebx
  8019bd:	89 fa                	mov    %edi,%edx
  8019bf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8019c3:	89 34 24             	mov    %esi,(%esp)
  8019c6:	85 c0                	test   %eax,%eax
  8019c8:	75 1a                	jne    8019e4 <__umoddi3+0x48>
  8019ca:	39 f7                	cmp    %esi,%edi
  8019cc:	0f 86 a2 00 00 00    	jbe    801a74 <__umoddi3+0xd8>
  8019d2:	89 c8                	mov    %ecx,%eax
  8019d4:	89 f2                	mov    %esi,%edx
  8019d6:	f7 f7                	div    %edi
  8019d8:	89 d0                	mov    %edx,%eax
  8019da:	31 d2                	xor    %edx,%edx
  8019dc:	83 c4 1c             	add    $0x1c,%esp
  8019df:	5b                   	pop    %ebx
  8019e0:	5e                   	pop    %esi
  8019e1:	5f                   	pop    %edi
  8019e2:	5d                   	pop    %ebp
  8019e3:	c3                   	ret    
  8019e4:	39 f0                	cmp    %esi,%eax
  8019e6:	0f 87 ac 00 00 00    	ja     801a98 <__umoddi3+0xfc>
  8019ec:	0f bd e8             	bsr    %eax,%ebp
  8019ef:	83 f5 1f             	xor    $0x1f,%ebp
  8019f2:	0f 84 ac 00 00 00    	je     801aa4 <__umoddi3+0x108>
  8019f8:	bf 20 00 00 00       	mov    $0x20,%edi
  8019fd:	29 ef                	sub    %ebp,%edi
  8019ff:	89 fe                	mov    %edi,%esi
  801a01:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801a05:	89 e9                	mov    %ebp,%ecx
  801a07:	d3 e0                	shl    %cl,%eax
  801a09:	89 d7                	mov    %edx,%edi
  801a0b:	89 f1                	mov    %esi,%ecx
  801a0d:	d3 ef                	shr    %cl,%edi
  801a0f:	09 c7                	or     %eax,%edi
  801a11:	89 e9                	mov    %ebp,%ecx
  801a13:	d3 e2                	shl    %cl,%edx
  801a15:	89 14 24             	mov    %edx,(%esp)
  801a18:	89 d8                	mov    %ebx,%eax
  801a1a:	d3 e0                	shl    %cl,%eax
  801a1c:	89 c2                	mov    %eax,%edx
  801a1e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a22:	d3 e0                	shl    %cl,%eax
  801a24:	89 44 24 04          	mov    %eax,0x4(%esp)
  801a28:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a2c:	89 f1                	mov    %esi,%ecx
  801a2e:	d3 e8                	shr    %cl,%eax
  801a30:	09 d0                	or     %edx,%eax
  801a32:	d3 eb                	shr    %cl,%ebx
  801a34:	89 da                	mov    %ebx,%edx
  801a36:	f7 f7                	div    %edi
  801a38:	89 d3                	mov    %edx,%ebx
  801a3a:	f7 24 24             	mull   (%esp)
  801a3d:	89 c6                	mov    %eax,%esi
  801a3f:	89 d1                	mov    %edx,%ecx
  801a41:	39 d3                	cmp    %edx,%ebx
  801a43:	0f 82 87 00 00 00    	jb     801ad0 <__umoddi3+0x134>
  801a49:	0f 84 91 00 00 00    	je     801ae0 <__umoddi3+0x144>
  801a4f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801a53:	29 f2                	sub    %esi,%edx
  801a55:	19 cb                	sbb    %ecx,%ebx
  801a57:	89 d8                	mov    %ebx,%eax
  801a59:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801a5d:	d3 e0                	shl    %cl,%eax
  801a5f:	89 e9                	mov    %ebp,%ecx
  801a61:	d3 ea                	shr    %cl,%edx
  801a63:	09 d0                	or     %edx,%eax
  801a65:	89 e9                	mov    %ebp,%ecx
  801a67:	d3 eb                	shr    %cl,%ebx
  801a69:	89 da                	mov    %ebx,%edx
  801a6b:	83 c4 1c             	add    $0x1c,%esp
  801a6e:	5b                   	pop    %ebx
  801a6f:	5e                   	pop    %esi
  801a70:	5f                   	pop    %edi
  801a71:	5d                   	pop    %ebp
  801a72:	c3                   	ret    
  801a73:	90                   	nop
  801a74:	89 fd                	mov    %edi,%ebp
  801a76:	85 ff                	test   %edi,%edi
  801a78:	75 0b                	jne    801a85 <__umoddi3+0xe9>
  801a7a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a7f:	31 d2                	xor    %edx,%edx
  801a81:	f7 f7                	div    %edi
  801a83:	89 c5                	mov    %eax,%ebp
  801a85:	89 f0                	mov    %esi,%eax
  801a87:	31 d2                	xor    %edx,%edx
  801a89:	f7 f5                	div    %ebp
  801a8b:	89 c8                	mov    %ecx,%eax
  801a8d:	f7 f5                	div    %ebp
  801a8f:	89 d0                	mov    %edx,%eax
  801a91:	e9 44 ff ff ff       	jmp    8019da <__umoddi3+0x3e>
  801a96:	66 90                	xchg   %ax,%ax
  801a98:	89 c8                	mov    %ecx,%eax
  801a9a:	89 f2                	mov    %esi,%edx
  801a9c:	83 c4 1c             	add    $0x1c,%esp
  801a9f:	5b                   	pop    %ebx
  801aa0:	5e                   	pop    %esi
  801aa1:	5f                   	pop    %edi
  801aa2:	5d                   	pop    %ebp
  801aa3:	c3                   	ret    
  801aa4:	3b 04 24             	cmp    (%esp),%eax
  801aa7:	72 06                	jb     801aaf <__umoddi3+0x113>
  801aa9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801aad:	77 0f                	ja     801abe <__umoddi3+0x122>
  801aaf:	89 f2                	mov    %esi,%edx
  801ab1:	29 f9                	sub    %edi,%ecx
  801ab3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ab7:	89 14 24             	mov    %edx,(%esp)
  801aba:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801abe:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ac2:	8b 14 24             	mov    (%esp),%edx
  801ac5:	83 c4 1c             	add    $0x1c,%esp
  801ac8:	5b                   	pop    %ebx
  801ac9:	5e                   	pop    %esi
  801aca:	5f                   	pop    %edi
  801acb:	5d                   	pop    %ebp
  801acc:	c3                   	ret    
  801acd:	8d 76 00             	lea    0x0(%esi),%esi
  801ad0:	2b 04 24             	sub    (%esp),%eax
  801ad3:	19 fa                	sbb    %edi,%edx
  801ad5:	89 d1                	mov    %edx,%ecx
  801ad7:	89 c6                	mov    %eax,%esi
  801ad9:	e9 71 ff ff ff       	jmp    801a4f <__umoddi3+0xb3>
  801ade:	66 90                	xchg   %ax,%ax
  801ae0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ae4:	72 ea                	jb     801ad0 <__umoddi3+0x134>
  801ae6:	89 d9                	mov    %ebx,%ecx
  801ae8:	e9 62 ff ff ff       	jmp    801a4f <__umoddi3+0xb3>
