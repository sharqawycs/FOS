
obj/user/tst_page_replacement_free_scarce_mem_slave_3_2:     file format elf32-i386


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
  800031:	e8 03 01 00 00       	call   800139 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 24 20 00 00    	sub    $0x2024,%esp
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800049:	eb 39                	jmp    800084 <_main+0x4c>
	{
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80004b:	a1 04 30 80 00       	mov    0x803004,%eax
  800050:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800056:	a1 04 30 80 00       	mov    0x803004,%eax
  80005b:	8b 40 74             	mov    0x74(%eax),%eax
  80005e:	83 ec 04             	sub    $0x4,%esp
  800061:	52                   	push   %edx
  800062:	50                   	push   %eax
  800063:	68 c0 1b 80 00       	push   $0x801bc0
  800068:	e8 cd 15 00 00       	call   80163a <sys_create_env>
  80006d:	83 c4 10             	add    $0x10,%esp
  800070:	89 45 f0             	mov    %eax,-0x10(%ebp)
		sys_run_env(ID);
  800073:	83 ec 0c             	sub    $0xc,%esp
  800076:	ff 75 f0             	pushl  -0x10(%ebp)
  800079:	e8 d9 15 00 00       	call   801657 <sys_run_env>
  80007e:	83 c4 10             	add    $0x10,%esp

void _main(void)
{
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  800081:	ff 45 f4             	incl   -0xc(%ebp)
  800084:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  800088:	7e c1                	jle    80004b <_main+0x13>
	{
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(ID);
	}

	sys_scarce_memory();
  80008a:	e8 0c 14 00 00       	call   80149b <sys_scarce_memory>

	uint32 freePagesBefore = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  80008f:	e8 51 13 00 00       	call   8013e5 <sys_calculate_free_frames>
  800094:	89 c3                	mov    %eax,%ebx
  800096:	e8 63 13 00 00       	call   8013fe <sys_calculate_modified_frames>
  80009b:	01 d8                	add    %ebx,%eax
  80009d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	uint32 usedDiskPagesBefore = sys_pf_calculate_allocated_pages();
  8000a0:	e8 c3 13 00 00       	call   801468 <sys_pf_calculate_allocated_pages>
  8000a5:	89 45 e8             	mov    %eax,-0x18(%ebp)

	// Check the number of pages shall be deleted with the first fault after scarce the memory
	int pagesToBeDeletedCount = sys_calculate_pages_tobe_removed_ready_exit(1);
  8000a8:	83 ec 0c             	sub    $0xc,%esp
  8000ab:	6a 01                	push   $0x1
  8000ad:	e8 cf 13 00 00       	call   801481 <sys_calculate_pages_tobe_removed_ready_exit>
  8000b2:	83 c4 10             	add    $0x10,%esp
  8000b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	char arr[PAGE_SIZE*2];
	// Access the created array in STACK to FAULT and Free SCARCE MEM
	arr[1*PAGE_SIZE] = -1;
  8000b8:	c6 85 e0 ef ff ff ff 	movb   $0xff,-0x1020(%ebp)

	//cprintf("Checking Allocation in Mem & Page File... \n");
	//AFTER freeing MEMORY
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPagesBefore) !=  1) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  8000bf:	e8 a4 13 00 00       	call   801468 <sys_pf_calculate_allocated_pages>
  8000c4:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000c7:	83 f8 01             	cmp    $0x1,%eax
  8000ca:	74 14                	je     8000e0 <_main+0xa8>
  8000cc:	83 ec 04             	sub    $0x4,%esp
  8000cf:	68 d0 1b 80 00       	push   $0x801bd0
  8000d4:	6a 1c                	push   $0x1c
  8000d6:	68 3c 1c 80 00       	push   $0x801c3c
  8000db:	e8 5b 01 00 00       	call   80023b <_panic>
		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  8000e0:	e8 00 13 00 00       	call   8013e5 <sys_calculate_free_frames>
  8000e5:	89 c3                	mov    %eax,%ebx
  8000e7:	e8 12 13 00 00       	call   8013fe <sys_calculate_modified_frames>
  8000ec:	01 d8                	add    %ebx,%eax
  8000ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
		if( (freePagesBefore + pagesToBeDeletedCount - 1) != freePagesAfter )
  8000f1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8000f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000f7:	01 d0                	add    %edx,%eax
  8000f9:	48                   	dec    %eax
  8000fa:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 74 1c 80 00       	push   $0x801c74
  800107:	6a 1f                	push   $0x1f
  800109:	68 3c 1c 80 00       	push   $0x801c3c
  80010e:	e8 28 01 00 00       	call   80023b <_panic>
	}

	env_sleep(100000);
  800113:	83 ec 0c             	sub    $0xc,%esp
  800116:	68 a0 86 01 00       	push   $0x186a0
  80011b:	e8 73 17 00 00       	call   801893 <env_sleep>
  800120:	83 c4 10             	add    $0x10,%esp
	// To ensure that the slave environments completed successfully
	cprintf("Congratulations!! test PAGE replacement [FREEING SCARCE MEMORY 3] is completed successfully.\n");
  800123:	83 ec 0c             	sub    $0xc,%esp
  800126:	68 f0 1c 80 00       	push   $0x801cf0
  80012b:	e8 bf 03 00 00       	call   8004ef <cprintf>
  800130:	83 c4 10             	add    $0x10,%esp

	return;
  800133:	90                   	nop
}
  800134:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800137:	c9                   	leave  
  800138:	c3                   	ret    

00800139 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800139:	55                   	push   %ebp
  80013a:	89 e5                	mov    %esp,%ebp
  80013c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80013f:	e8 d6 11 00 00       	call   80131a <sys_getenvindex>
  800144:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800147:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80014a:	89 d0                	mov    %edx,%eax
  80014c:	01 c0                	add    %eax,%eax
  80014e:	01 d0                	add    %edx,%eax
  800150:	c1 e0 02             	shl    $0x2,%eax
  800153:	01 d0                	add    %edx,%eax
  800155:	c1 e0 06             	shl    $0x6,%eax
  800158:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80015d:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800162:	a1 04 30 80 00       	mov    0x803004,%eax
  800167:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80016d:	84 c0                	test   %al,%al
  80016f:	74 0f                	je     800180 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800171:	a1 04 30 80 00       	mov    0x803004,%eax
  800176:	05 f4 02 00 00       	add    $0x2f4,%eax
  80017b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800180:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800184:	7e 0a                	jle    800190 <libmain+0x57>
		binaryname = argv[0];
  800186:	8b 45 0c             	mov    0xc(%ebp),%eax
  800189:	8b 00                	mov    (%eax),%eax
  80018b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800190:	83 ec 08             	sub    $0x8,%esp
  800193:	ff 75 0c             	pushl  0xc(%ebp)
  800196:	ff 75 08             	pushl  0x8(%ebp)
  800199:	e8 9a fe ff ff       	call   800038 <_main>
  80019e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001a1:	e8 0f 13 00 00       	call   8014b5 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001a6:	83 ec 0c             	sub    $0xc,%esp
  8001a9:	68 68 1d 80 00       	push   $0x801d68
  8001ae:	e8 3c 03 00 00       	call   8004ef <cprintf>
  8001b3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001b6:	a1 04 30 80 00       	mov    0x803004,%eax
  8001bb:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001c1:	a1 04 30 80 00       	mov    0x803004,%eax
  8001c6:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001cc:	83 ec 04             	sub    $0x4,%esp
  8001cf:	52                   	push   %edx
  8001d0:	50                   	push   %eax
  8001d1:	68 90 1d 80 00       	push   $0x801d90
  8001d6:	e8 14 03 00 00       	call   8004ef <cprintf>
  8001db:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001de:	a1 04 30 80 00       	mov    0x803004,%eax
  8001e3:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8001e9:	83 ec 08             	sub    $0x8,%esp
  8001ec:	50                   	push   %eax
  8001ed:	68 b5 1d 80 00       	push   $0x801db5
  8001f2:	e8 f8 02 00 00       	call   8004ef <cprintf>
  8001f7:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001fa:	83 ec 0c             	sub    $0xc,%esp
  8001fd:	68 68 1d 80 00       	push   $0x801d68
  800202:	e8 e8 02 00 00       	call   8004ef <cprintf>
  800207:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80020a:	e8 c0 12 00 00       	call   8014cf <sys_enable_interrupt>

	// exit gracefully
	exit();
  80020f:	e8 19 00 00 00       	call   80022d <exit>
}
  800214:	90                   	nop
  800215:	c9                   	leave  
  800216:	c3                   	ret    

00800217 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800217:	55                   	push   %ebp
  800218:	89 e5                	mov    %esp,%ebp
  80021a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80021d:	83 ec 0c             	sub    $0xc,%esp
  800220:	6a 00                	push   $0x0
  800222:	e8 bf 10 00 00       	call   8012e6 <sys_env_destroy>
  800227:	83 c4 10             	add    $0x10,%esp
}
  80022a:	90                   	nop
  80022b:	c9                   	leave  
  80022c:	c3                   	ret    

0080022d <exit>:

void
exit(void)
{
  80022d:	55                   	push   %ebp
  80022e:	89 e5                	mov    %esp,%ebp
  800230:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800233:	e8 14 11 00 00       	call   80134c <sys_env_exit>
}
  800238:	90                   	nop
  800239:	c9                   	leave  
  80023a:	c3                   	ret    

0080023b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80023b:	55                   	push   %ebp
  80023c:	89 e5                	mov    %esp,%ebp
  80023e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800241:	8d 45 10             	lea    0x10(%ebp),%eax
  800244:	83 c0 04             	add    $0x4,%eax
  800247:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80024a:	a1 14 30 80 00       	mov    0x803014,%eax
  80024f:	85 c0                	test   %eax,%eax
  800251:	74 16                	je     800269 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800253:	a1 14 30 80 00       	mov    0x803014,%eax
  800258:	83 ec 08             	sub    $0x8,%esp
  80025b:	50                   	push   %eax
  80025c:	68 cc 1d 80 00       	push   $0x801dcc
  800261:	e8 89 02 00 00       	call   8004ef <cprintf>
  800266:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800269:	a1 00 30 80 00       	mov    0x803000,%eax
  80026e:	ff 75 0c             	pushl  0xc(%ebp)
  800271:	ff 75 08             	pushl  0x8(%ebp)
  800274:	50                   	push   %eax
  800275:	68 d1 1d 80 00       	push   $0x801dd1
  80027a:	e8 70 02 00 00       	call   8004ef <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800282:	8b 45 10             	mov    0x10(%ebp),%eax
  800285:	83 ec 08             	sub    $0x8,%esp
  800288:	ff 75 f4             	pushl  -0xc(%ebp)
  80028b:	50                   	push   %eax
  80028c:	e8 f3 01 00 00       	call   800484 <vcprintf>
  800291:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800294:	83 ec 08             	sub    $0x8,%esp
  800297:	6a 00                	push   $0x0
  800299:	68 ed 1d 80 00       	push   $0x801ded
  80029e:	e8 e1 01 00 00       	call   800484 <vcprintf>
  8002a3:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002a6:	e8 82 ff ff ff       	call   80022d <exit>

	// should not return here
	while (1) ;
  8002ab:	eb fe                	jmp    8002ab <_panic+0x70>

008002ad <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002ad:	55                   	push   %ebp
  8002ae:	89 e5                	mov    %esp,%ebp
  8002b0:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002b3:	a1 04 30 80 00       	mov    0x803004,%eax
  8002b8:	8b 50 74             	mov    0x74(%eax),%edx
  8002bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002be:	39 c2                	cmp    %eax,%edx
  8002c0:	74 14                	je     8002d6 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002c2:	83 ec 04             	sub    $0x4,%esp
  8002c5:	68 f0 1d 80 00       	push   $0x801df0
  8002ca:	6a 26                	push   $0x26
  8002cc:	68 3c 1e 80 00       	push   $0x801e3c
  8002d1:	e8 65 ff ff ff       	call   80023b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002e4:	e9 c2 00 00 00       	jmp    8003ab <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8002e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f6:	01 d0                	add    %edx,%eax
  8002f8:	8b 00                	mov    (%eax),%eax
  8002fa:	85 c0                	test   %eax,%eax
  8002fc:	75 08                	jne    800306 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8002fe:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800301:	e9 a2 00 00 00       	jmp    8003a8 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800306:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80030d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800314:	eb 69                	jmp    80037f <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800316:	a1 04 30 80 00       	mov    0x803004,%eax
  80031b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800321:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800324:	89 d0                	mov    %edx,%eax
  800326:	01 c0                	add    %eax,%eax
  800328:	01 d0                	add    %edx,%eax
  80032a:	c1 e0 02             	shl    $0x2,%eax
  80032d:	01 c8                	add    %ecx,%eax
  80032f:	8a 40 04             	mov    0x4(%eax),%al
  800332:	84 c0                	test   %al,%al
  800334:	75 46                	jne    80037c <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800336:	a1 04 30 80 00       	mov    0x803004,%eax
  80033b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800341:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800344:	89 d0                	mov    %edx,%eax
  800346:	01 c0                	add    %eax,%eax
  800348:	01 d0                	add    %edx,%eax
  80034a:	c1 e0 02             	shl    $0x2,%eax
  80034d:	01 c8                	add    %ecx,%eax
  80034f:	8b 00                	mov    (%eax),%eax
  800351:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800354:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800357:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80035c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80035e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800361:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800368:	8b 45 08             	mov    0x8(%ebp),%eax
  80036b:	01 c8                	add    %ecx,%eax
  80036d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80036f:	39 c2                	cmp    %eax,%edx
  800371:	75 09                	jne    80037c <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800373:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80037a:	eb 12                	jmp    80038e <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80037c:	ff 45 e8             	incl   -0x18(%ebp)
  80037f:	a1 04 30 80 00       	mov    0x803004,%eax
  800384:	8b 50 74             	mov    0x74(%eax),%edx
  800387:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80038a:	39 c2                	cmp    %eax,%edx
  80038c:	77 88                	ja     800316 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80038e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800392:	75 14                	jne    8003a8 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800394:	83 ec 04             	sub    $0x4,%esp
  800397:	68 48 1e 80 00       	push   $0x801e48
  80039c:	6a 3a                	push   $0x3a
  80039e:	68 3c 1e 80 00       	push   $0x801e3c
  8003a3:	e8 93 fe ff ff       	call   80023b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003a8:	ff 45 f0             	incl   -0x10(%ebp)
  8003ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003ae:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003b1:	0f 8c 32 ff ff ff    	jl     8002e9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003b7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003be:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003c5:	eb 26                	jmp    8003ed <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003c7:	a1 04 30 80 00       	mov    0x803004,%eax
  8003cc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003d2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003d5:	89 d0                	mov    %edx,%eax
  8003d7:	01 c0                	add    %eax,%eax
  8003d9:	01 d0                	add    %edx,%eax
  8003db:	c1 e0 02             	shl    $0x2,%eax
  8003de:	01 c8                	add    %ecx,%eax
  8003e0:	8a 40 04             	mov    0x4(%eax),%al
  8003e3:	3c 01                	cmp    $0x1,%al
  8003e5:	75 03                	jne    8003ea <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8003e7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003ea:	ff 45 e0             	incl   -0x20(%ebp)
  8003ed:	a1 04 30 80 00       	mov    0x803004,%eax
  8003f2:	8b 50 74             	mov    0x74(%eax),%edx
  8003f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003f8:	39 c2                	cmp    %eax,%edx
  8003fa:	77 cb                	ja     8003c7 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8003fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ff:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800402:	74 14                	je     800418 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800404:	83 ec 04             	sub    $0x4,%esp
  800407:	68 9c 1e 80 00       	push   $0x801e9c
  80040c:	6a 44                	push   $0x44
  80040e:	68 3c 1e 80 00       	push   $0x801e3c
  800413:	e8 23 fe ff ff       	call   80023b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800418:	90                   	nop
  800419:	c9                   	leave  
  80041a:	c3                   	ret    

0080041b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80041b:	55                   	push   %ebp
  80041c:	89 e5                	mov    %esp,%ebp
  80041e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800421:	8b 45 0c             	mov    0xc(%ebp),%eax
  800424:	8b 00                	mov    (%eax),%eax
  800426:	8d 48 01             	lea    0x1(%eax),%ecx
  800429:	8b 55 0c             	mov    0xc(%ebp),%edx
  80042c:	89 0a                	mov    %ecx,(%edx)
  80042e:	8b 55 08             	mov    0x8(%ebp),%edx
  800431:	88 d1                	mov    %dl,%cl
  800433:	8b 55 0c             	mov    0xc(%ebp),%edx
  800436:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80043a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80043d:	8b 00                	mov    (%eax),%eax
  80043f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800444:	75 2c                	jne    800472 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800446:	a0 08 30 80 00       	mov    0x803008,%al
  80044b:	0f b6 c0             	movzbl %al,%eax
  80044e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800451:	8b 12                	mov    (%edx),%edx
  800453:	89 d1                	mov    %edx,%ecx
  800455:	8b 55 0c             	mov    0xc(%ebp),%edx
  800458:	83 c2 08             	add    $0x8,%edx
  80045b:	83 ec 04             	sub    $0x4,%esp
  80045e:	50                   	push   %eax
  80045f:	51                   	push   %ecx
  800460:	52                   	push   %edx
  800461:	e8 3e 0e 00 00       	call   8012a4 <sys_cputs>
  800466:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800469:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800472:	8b 45 0c             	mov    0xc(%ebp),%eax
  800475:	8b 40 04             	mov    0x4(%eax),%eax
  800478:	8d 50 01             	lea    0x1(%eax),%edx
  80047b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800481:	90                   	nop
  800482:	c9                   	leave  
  800483:	c3                   	ret    

00800484 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800484:	55                   	push   %ebp
  800485:	89 e5                	mov    %esp,%ebp
  800487:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80048d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800494:	00 00 00 
	b.cnt = 0;
  800497:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80049e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004a1:	ff 75 0c             	pushl  0xc(%ebp)
  8004a4:	ff 75 08             	pushl  0x8(%ebp)
  8004a7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004ad:	50                   	push   %eax
  8004ae:	68 1b 04 80 00       	push   $0x80041b
  8004b3:	e8 11 02 00 00       	call   8006c9 <vprintfmt>
  8004b8:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004bb:	a0 08 30 80 00       	mov    0x803008,%al
  8004c0:	0f b6 c0             	movzbl %al,%eax
  8004c3:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004c9:	83 ec 04             	sub    $0x4,%esp
  8004cc:	50                   	push   %eax
  8004cd:	52                   	push   %edx
  8004ce:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004d4:	83 c0 08             	add    $0x8,%eax
  8004d7:	50                   	push   %eax
  8004d8:	e8 c7 0d 00 00       	call   8012a4 <sys_cputs>
  8004dd:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004e0:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  8004e7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004ed:	c9                   	leave  
  8004ee:	c3                   	ret    

008004ef <cprintf>:

int cprintf(const char *fmt, ...) {
  8004ef:	55                   	push   %ebp
  8004f0:	89 e5                	mov    %esp,%ebp
  8004f2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004f5:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  8004fc:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800502:	8b 45 08             	mov    0x8(%ebp),%eax
  800505:	83 ec 08             	sub    $0x8,%esp
  800508:	ff 75 f4             	pushl  -0xc(%ebp)
  80050b:	50                   	push   %eax
  80050c:	e8 73 ff ff ff       	call   800484 <vcprintf>
  800511:	83 c4 10             	add    $0x10,%esp
  800514:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800517:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80051a:	c9                   	leave  
  80051b:	c3                   	ret    

0080051c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80051c:	55                   	push   %ebp
  80051d:	89 e5                	mov    %esp,%ebp
  80051f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800522:	e8 8e 0f 00 00       	call   8014b5 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800527:	8d 45 0c             	lea    0xc(%ebp),%eax
  80052a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80052d:	8b 45 08             	mov    0x8(%ebp),%eax
  800530:	83 ec 08             	sub    $0x8,%esp
  800533:	ff 75 f4             	pushl  -0xc(%ebp)
  800536:	50                   	push   %eax
  800537:	e8 48 ff ff ff       	call   800484 <vcprintf>
  80053c:	83 c4 10             	add    $0x10,%esp
  80053f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800542:	e8 88 0f 00 00       	call   8014cf <sys_enable_interrupt>
	return cnt;
  800547:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80054a:	c9                   	leave  
  80054b:	c3                   	ret    

0080054c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80054c:	55                   	push   %ebp
  80054d:	89 e5                	mov    %esp,%ebp
  80054f:	53                   	push   %ebx
  800550:	83 ec 14             	sub    $0x14,%esp
  800553:	8b 45 10             	mov    0x10(%ebp),%eax
  800556:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800559:	8b 45 14             	mov    0x14(%ebp),%eax
  80055c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80055f:	8b 45 18             	mov    0x18(%ebp),%eax
  800562:	ba 00 00 00 00       	mov    $0x0,%edx
  800567:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80056a:	77 55                	ja     8005c1 <printnum+0x75>
  80056c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80056f:	72 05                	jb     800576 <printnum+0x2a>
  800571:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800574:	77 4b                	ja     8005c1 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800576:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800579:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80057c:	8b 45 18             	mov    0x18(%ebp),%eax
  80057f:	ba 00 00 00 00       	mov    $0x0,%edx
  800584:	52                   	push   %edx
  800585:	50                   	push   %eax
  800586:	ff 75 f4             	pushl  -0xc(%ebp)
  800589:	ff 75 f0             	pushl  -0x10(%ebp)
  80058c:	e8 b7 13 00 00       	call   801948 <__udivdi3>
  800591:	83 c4 10             	add    $0x10,%esp
  800594:	83 ec 04             	sub    $0x4,%esp
  800597:	ff 75 20             	pushl  0x20(%ebp)
  80059a:	53                   	push   %ebx
  80059b:	ff 75 18             	pushl  0x18(%ebp)
  80059e:	52                   	push   %edx
  80059f:	50                   	push   %eax
  8005a0:	ff 75 0c             	pushl  0xc(%ebp)
  8005a3:	ff 75 08             	pushl  0x8(%ebp)
  8005a6:	e8 a1 ff ff ff       	call   80054c <printnum>
  8005ab:	83 c4 20             	add    $0x20,%esp
  8005ae:	eb 1a                	jmp    8005ca <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005b0:	83 ec 08             	sub    $0x8,%esp
  8005b3:	ff 75 0c             	pushl  0xc(%ebp)
  8005b6:	ff 75 20             	pushl  0x20(%ebp)
  8005b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bc:	ff d0                	call   *%eax
  8005be:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005c1:	ff 4d 1c             	decl   0x1c(%ebp)
  8005c4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005c8:	7f e6                	jg     8005b0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005ca:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005cd:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005d8:	53                   	push   %ebx
  8005d9:	51                   	push   %ecx
  8005da:	52                   	push   %edx
  8005db:	50                   	push   %eax
  8005dc:	e8 77 14 00 00       	call   801a58 <__umoddi3>
  8005e1:	83 c4 10             	add    $0x10,%esp
  8005e4:	05 14 21 80 00       	add    $0x802114,%eax
  8005e9:	8a 00                	mov    (%eax),%al
  8005eb:	0f be c0             	movsbl %al,%eax
  8005ee:	83 ec 08             	sub    $0x8,%esp
  8005f1:	ff 75 0c             	pushl  0xc(%ebp)
  8005f4:	50                   	push   %eax
  8005f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f8:	ff d0                	call   *%eax
  8005fa:	83 c4 10             	add    $0x10,%esp
}
  8005fd:	90                   	nop
  8005fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800601:	c9                   	leave  
  800602:	c3                   	ret    

00800603 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800603:	55                   	push   %ebp
  800604:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800606:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80060a:	7e 1c                	jle    800628 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80060c:	8b 45 08             	mov    0x8(%ebp),%eax
  80060f:	8b 00                	mov    (%eax),%eax
  800611:	8d 50 08             	lea    0x8(%eax),%edx
  800614:	8b 45 08             	mov    0x8(%ebp),%eax
  800617:	89 10                	mov    %edx,(%eax)
  800619:	8b 45 08             	mov    0x8(%ebp),%eax
  80061c:	8b 00                	mov    (%eax),%eax
  80061e:	83 e8 08             	sub    $0x8,%eax
  800621:	8b 50 04             	mov    0x4(%eax),%edx
  800624:	8b 00                	mov    (%eax),%eax
  800626:	eb 40                	jmp    800668 <getuint+0x65>
	else if (lflag)
  800628:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80062c:	74 1e                	je     80064c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80062e:	8b 45 08             	mov    0x8(%ebp),%eax
  800631:	8b 00                	mov    (%eax),%eax
  800633:	8d 50 04             	lea    0x4(%eax),%edx
  800636:	8b 45 08             	mov    0x8(%ebp),%eax
  800639:	89 10                	mov    %edx,(%eax)
  80063b:	8b 45 08             	mov    0x8(%ebp),%eax
  80063e:	8b 00                	mov    (%eax),%eax
  800640:	83 e8 04             	sub    $0x4,%eax
  800643:	8b 00                	mov    (%eax),%eax
  800645:	ba 00 00 00 00       	mov    $0x0,%edx
  80064a:	eb 1c                	jmp    800668 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80064c:	8b 45 08             	mov    0x8(%ebp),%eax
  80064f:	8b 00                	mov    (%eax),%eax
  800651:	8d 50 04             	lea    0x4(%eax),%edx
  800654:	8b 45 08             	mov    0x8(%ebp),%eax
  800657:	89 10                	mov    %edx,(%eax)
  800659:	8b 45 08             	mov    0x8(%ebp),%eax
  80065c:	8b 00                	mov    (%eax),%eax
  80065e:	83 e8 04             	sub    $0x4,%eax
  800661:	8b 00                	mov    (%eax),%eax
  800663:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800668:	5d                   	pop    %ebp
  800669:	c3                   	ret    

0080066a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80066a:	55                   	push   %ebp
  80066b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80066d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800671:	7e 1c                	jle    80068f <getint+0x25>
		return va_arg(*ap, long long);
  800673:	8b 45 08             	mov    0x8(%ebp),%eax
  800676:	8b 00                	mov    (%eax),%eax
  800678:	8d 50 08             	lea    0x8(%eax),%edx
  80067b:	8b 45 08             	mov    0x8(%ebp),%eax
  80067e:	89 10                	mov    %edx,(%eax)
  800680:	8b 45 08             	mov    0x8(%ebp),%eax
  800683:	8b 00                	mov    (%eax),%eax
  800685:	83 e8 08             	sub    $0x8,%eax
  800688:	8b 50 04             	mov    0x4(%eax),%edx
  80068b:	8b 00                	mov    (%eax),%eax
  80068d:	eb 38                	jmp    8006c7 <getint+0x5d>
	else if (lflag)
  80068f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800693:	74 1a                	je     8006af <getint+0x45>
		return va_arg(*ap, long);
  800695:	8b 45 08             	mov    0x8(%ebp),%eax
  800698:	8b 00                	mov    (%eax),%eax
  80069a:	8d 50 04             	lea    0x4(%eax),%edx
  80069d:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a0:	89 10                	mov    %edx,(%eax)
  8006a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a5:	8b 00                	mov    (%eax),%eax
  8006a7:	83 e8 04             	sub    $0x4,%eax
  8006aa:	8b 00                	mov    (%eax),%eax
  8006ac:	99                   	cltd   
  8006ad:	eb 18                	jmp    8006c7 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006af:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b2:	8b 00                	mov    (%eax),%eax
  8006b4:	8d 50 04             	lea    0x4(%eax),%edx
  8006b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ba:	89 10                	mov    %edx,(%eax)
  8006bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bf:	8b 00                	mov    (%eax),%eax
  8006c1:	83 e8 04             	sub    $0x4,%eax
  8006c4:	8b 00                	mov    (%eax),%eax
  8006c6:	99                   	cltd   
}
  8006c7:	5d                   	pop    %ebp
  8006c8:	c3                   	ret    

008006c9 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006c9:	55                   	push   %ebp
  8006ca:	89 e5                	mov    %esp,%ebp
  8006cc:	56                   	push   %esi
  8006cd:	53                   	push   %ebx
  8006ce:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006d1:	eb 17                	jmp    8006ea <vprintfmt+0x21>
			if (ch == '\0')
  8006d3:	85 db                	test   %ebx,%ebx
  8006d5:	0f 84 af 03 00 00    	je     800a8a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006db:	83 ec 08             	sub    $0x8,%esp
  8006de:	ff 75 0c             	pushl  0xc(%ebp)
  8006e1:	53                   	push   %ebx
  8006e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e5:	ff d0                	call   *%eax
  8006e7:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8006ed:	8d 50 01             	lea    0x1(%eax),%edx
  8006f0:	89 55 10             	mov    %edx,0x10(%ebp)
  8006f3:	8a 00                	mov    (%eax),%al
  8006f5:	0f b6 d8             	movzbl %al,%ebx
  8006f8:	83 fb 25             	cmp    $0x25,%ebx
  8006fb:	75 d6                	jne    8006d3 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8006fd:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800701:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800708:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80070f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800716:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80071d:	8b 45 10             	mov    0x10(%ebp),%eax
  800720:	8d 50 01             	lea    0x1(%eax),%edx
  800723:	89 55 10             	mov    %edx,0x10(%ebp)
  800726:	8a 00                	mov    (%eax),%al
  800728:	0f b6 d8             	movzbl %al,%ebx
  80072b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80072e:	83 f8 55             	cmp    $0x55,%eax
  800731:	0f 87 2b 03 00 00    	ja     800a62 <vprintfmt+0x399>
  800737:	8b 04 85 38 21 80 00 	mov    0x802138(,%eax,4),%eax
  80073e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800740:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800744:	eb d7                	jmp    80071d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800746:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80074a:	eb d1                	jmp    80071d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80074c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800753:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800756:	89 d0                	mov    %edx,%eax
  800758:	c1 e0 02             	shl    $0x2,%eax
  80075b:	01 d0                	add    %edx,%eax
  80075d:	01 c0                	add    %eax,%eax
  80075f:	01 d8                	add    %ebx,%eax
  800761:	83 e8 30             	sub    $0x30,%eax
  800764:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800767:	8b 45 10             	mov    0x10(%ebp),%eax
  80076a:	8a 00                	mov    (%eax),%al
  80076c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80076f:	83 fb 2f             	cmp    $0x2f,%ebx
  800772:	7e 3e                	jle    8007b2 <vprintfmt+0xe9>
  800774:	83 fb 39             	cmp    $0x39,%ebx
  800777:	7f 39                	jg     8007b2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800779:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80077c:	eb d5                	jmp    800753 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80077e:	8b 45 14             	mov    0x14(%ebp),%eax
  800781:	83 c0 04             	add    $0x4,%eax
  800784:	89 45 14             	mov    %eax,0x14(%ebp)
  800787:	8b 45 14             	mov    0x14(%ebp),%eax
  80078a:	83 e8 04             	sub    $0x4,%eax
  80078d:	8b 00                	mov    (%eax),%eax
  80078f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800792:	eb 1f                	jmp    8007b3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800794:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800798:	79 83                	jns    80071d <vprintfmt+0x54>
				width = 0;
  80079a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007a1:	e9 77 ff ff ff       	jmp    80071d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007a6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007ad:	e9 6b ff ff ff       	jmp    80071d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007b2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007b3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007b7:	0f 89 60 ff ff ff    	jns    80071d <vprintfmt+0x54>
				width = precision, precision = -1;
  8007bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007c3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007ca:	e9 4e ff ff ff       	jmp    80071d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007cf:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007d2:	e9 46 ff ff ff       	jmp    80071d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8007da:	83 c0 04             	add    $0x4,%eax
  8007dd:	89 45 14             	mov    %eax,0x14(%ebp)
  8007e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e3:	83 e8 04             	sub    $0x4,%eax
  8007e6:	8b 00                	mov    (%eax),%eax
  8007e8:	83 ec 08             	sub    $0x8,%esp
  8007eb:	ff 75 0c             	pushl  0xc(%ebp)
  8007ee:	50                   	push   %eax
  8007ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f2:	ff d0                	call   *%eax
  8007f4:	83 c4 10             	add    $0x10,%esp
			break;
  8007f7:	e9 89 02 00 00       	jmp    800a85 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8007fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ff:	83 c0 04             	add    $0x4,%eax
  800802:	89 45 14             	mov    %eax,0x14(%ebp)
  800805:	8b 45 14             	mov    0x14(%ebp),%eax
  800808:	83 e8 04             	sub    $0x4,%eax
  80080b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80080d:	85 db                	test   %ebx,%ebx
  80080f:	79 02                	jns    800813 <vprintfmt+0x14a>
				err = -err;
  800811:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800813:	83 fb 64             	cmp    $0x64,%ebx
  800816:	7f 0b                	jg     800823 <vprintfmt+0x15a>
  800818:	8b 34 9d 80 1f 80 00 	mov    0x801f80(,%ebx,4),%esi
  80081f:	85 f6                	test   %esi,%esi
  800821:	75 19                	jne    80083c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800823:	53                   	push   %ebx
  800824:	68 25 21 80 00       	push   $0x802125
  800829:	ff 75 0c             	pushl  0xc(%ebp)
  80082c:	ff 75 08             	pushl  0x8(%ebp)
  80082f:	e8 5e 02 00 00       	call   800a92 <printfmt>
  800834:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800837:	e9 49 02 00 00       	jmp    800a85 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80083c:	56                   	push   %esi
  80083d:	68 2e 21 80 00       	push   $0x80212e
  800842:	ff 75 0c             	pushl  0xc(%ebp)
  800845:	ff 75 08             	pushl  0x8(%ebp)
  800848:	e8 45 02 00 00       	call   800a92 <printfmt>
  80084d:	83 c4 10             	add    $0x10,%esp
			break;
  800850:	e9 30 02 00 00       	jmp    800a85 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800855:	8b 45 14             	mov    0x14(%ebp),%eax
  800858:	83 c0 04             	add    $0x4,%eax
  80085b:	89 45 14             	mov    %eax,0x14(%ebp)
  80085e:	8b 45 14             	mov    0x14(%ebp),%eax
  800861:	83 e8 04             	sub    $0x4,%eax
  800864:	8b 30                	mov    (%eax),%esi
  800866:	85 f6                	test   %esi,%esi
  800868:	75 05                	jne    80086f <vprintfmt+0x1a6>
				p = "(null)";
  80086a:	be 31 21 80 00       	mov    $0x802131,%esi
			if (width > 0 && padc != '-')
  80086f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800873:	7e 6d                	jle    8008e2 <vprintfmt+0x219>
  800875:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800879:	74 67                	je     8008e2 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80087b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80087e:	83 ec 08             	sub    $0x8,%esp
  800881:	50                   	push   %eax
  800882:	56                   	push   %esi
  800883:	e8 0c 03 00 00       	call   800b94 <strnlen>
  800888:	83 c4 10             	add    $0x10,%esp
  80088b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80088e:	eb 16                	jmp    8008a6 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800890:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800894:	83 ec 08             	sub    $0x8,%esp
  800897:	ff 75 0c             	pushl  0xc(%ebp)
  80089a:	50                   	push   %eax
  80089b:	8b 45 08             	mov    0x8(%ebp),%eax
  80089e:	ff d0                	call   *%eax
  8008a0:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008a3:	ff 4d e4             	decl   -0x1c(%ebp)
  8008a6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008aa:	7f e4                	jg     800890 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008ac:	eb 34                	jmp    8008e2 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008ae:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008b2:	74 1c                	je     8008d0 <vprintfmt+0x207>
  8008b4:	83 fb 1f             	cmp    $0x1f,%ebx
  8008b7:	7e 05                	jle    8008be <vprintfmt+0x1f5>
  8008b9:	83 fb 7e             	cmp    $0x7e,%ebx
  8008bc:	7e 12                	jle    8008d0 <vprintfmt+0x207>
					putch('?', putdat);
  8008be:	83 ec 08             	sub    $0x8,%esp
  8008c1:	ff 75 0c             	pushl  0xc(%ebp)
  8008c4:	6a 3f                	push   $0x3f
  8008c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c9:	ff d0                	call   *%eax
  8008cb:	83 c4 10             	add    $0x10,%esp
  8008ce:	eb 0f                	jmp    8008df <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008d0:	83 ec 08             	sub    $0x8,%esp
  8008d3:	ff 75 0c             	pushl  0xc(%ebp)
  8008d6:	53                   	push   %ebx
  8008d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008da:	ff d0                	call   *%eax
  8008dc:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008df:	ff 4d e4             	decl   -0x1c(%ebp)
  8008e2:	89 f0                	mov    %esi,%eax
  8008e4:	8d 70 01             	lea    0x1(%eax),%esi
  8008e7:	8a 00                	mov    (%eax),%al
  8008e9:	0f be d8             	movsbl %al,%ebx
  8008ec:	85 db                	test   %ebx,%ebx
  8008ee:	74 24                	je     800914 <vprintfmt+0x24b>
  8008f0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008f4:	78 b8                	js     8008ae <vprintfmt+0x1e5>
  8008f6:	ff 4d e0             	decl   -0x20(%ebp)
  8008f9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008fd:	79 af                	jns    8008ae <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008ff:	eb 13                	jmp    800914 <vprintfmt+0x24b>
				putch(' ', putdat);
  800901:	83 ec 08             	sub    $0x8,%esp
  800904:	ff 75 0c             	pushl  0xc(%ebp)
  800907:	6a 20                	push   $0x20
  800909:	8b 45 08             	mov    0x8(%ebp),%eax
  80090c:	ff d0                	call   *%eax
  80090e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800911:	ff 4d e4             	decl   -0x1c(%ebp)
  800914:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800918:	7f e7                	jg     800901 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80091a:	e9 66 01 00 00       	jmp    800a85 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80091f:	83 ec 08             	sub    $0x8,%esp
  800922:	ff 75 e8             	pushl  -0x18(%ebp)
  800925:	8d 45 14             	lea    0x14(%ebp),%eax
  800928:	50                   	push   %eax
  800929:	e8 3c fd ff ff       	call   80066a <getint>
  80092e:	83 c4 10             	add    $0x10,%esp
  800931:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800934:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800937:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80093a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80093d:	85 d2                	test   %edx,%edx
  80093f:	79 23                	jns    800964 <vprintfmt+0x29b>
				putch('-', putdat);
  800941:	83 ec 08             	sub    $0x8,%esp
  800944:	ff 75 0c             	pushl  0xc(%ebp)
  800947:	6a 2d                	push   $0x2d
  800949:	8b 45 08             	mov    0x8(%ebp),%eax
  80094c:	ff d0                	call   *%eax
  80094e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800951:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800954:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800957:	f7 d8                	neg    %eax
  800959:	83 d2 00             	adc    $0x0,%edx
  80095c:	f7 da                	neg    %edx
  80095e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800961:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800964:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80096b:	e9 bc 00 00 00       	jmp    800a2c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800970:	83 ec 08             	sub    $0x8,%esp
  800973:	ff 75 e8             	pushl  -0x18(%ebp)
  800976:	8d 45 14             	lea    0x14(%ebp),%eax
  800979:	50                   	push   %eax
  80097a:	e8 84 fc ff ff       	call   800603 <getuint>
  80097f:	83 c4 10             	add    $0x10,%esp
  800982:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800985:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800988:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80098f:	e9 98 00 00 00       	jmp    800a2c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800994:	83 ec 08             	sub    $0x8,%esp
  800997:	ff 75 0c             	pushl  0xc(%ebp)
  80099a:	6a 58                	push   $0x58
  80099c:	8b 45 08             	mov    0x8(%ebp),%eax
  80099f:	ff d0                	call   *%eax
  8009a1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009a4:	83 ec 08             	sub    $0x8,%esp
  8009a7:	ff 75 0c             	pushl  0xc(%ebp)
  8009aa:	6a 58                	push   $0x58
  8009ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8009af:	ff d0                	call   *%eax
  8009b1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009b4:	83 ec 08             	sub    $0x8,%esp
  8009b7:	ff 75 0c             	pushl  0xc(%ebp)
  8009ba:	6a 58                	push   $0x58
  8009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bf:	ff d0                	call   *%eax
  8009c1:	83 c4 10             	add    $0x10,%esp
			break;
  8009c4:	e9 bc 00 00 00       	jmp    800a85 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009c9:	83 ec 08             	sub    $0x8,%esp
  8009cc:	ff 75 0c             	pushl  0xc(%ebp)
  8009cf:	6a 30                	push   $0x30
  8009d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d4:	ff d0                	call   *%eax
  8009d6:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009d9:	83 ec 08             	sub    $0x8,%esp
  8009dc:	ff 75 0c             	pushl  0xc(%ebp)
  8009df:	6a 78                	push   $0x78
  8009e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e4:	ff d0                	call   *%eax
  8009e6:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009e9:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ec:	83 c0 04             	add    $0x4,%eax
  8009ef:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f5:	83 e8 04             	sub    $0x4,%eax
  8009f8:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8009fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a04:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a0b:	eb 1f                	jmp    800a2c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a0d:	83 ec 08             	sub    $0x8,%esp
  800a10:	ff 75 e8             	pushl  -0x18(%ebp)
  800a13:	8d 45 14             	lea    0x14(%ebp),%eax
  800a16:	50                   	push   %eax
  800a17:	e8 e7 fb ff ff       	call   800603 <getuint>
  800a1c:	83 c4 10             	add    $0x10,%esp
  800a1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a22:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a25:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a2c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a30:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a33:	83 ec 04             	sub    $0x4,%esp
  800a36:	52                   	push   %edx
  800a37:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a3a:	50                   	push   %eax
  800a3b:	ff 75 f4             	pushl  -0xc(%ebp)
  800a3e:	ff 75 f0             	pushl  -0x10(%ebp)
  800a41:	ff 75 0c             	pushl  0xc(%ebp)
  800a44:	ff 75 08             	pushl  0x8(%ebp)
  800a47:	e8 00 fb ff ff       	call   80054c <printnum>
  800a4c:	83 c4 20             	add    $0x20,%esp
			break;
  800a4f:	eb 34                	jmp    800a85 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a51:	83 ec 08             	sub    $0x8,%esp
  800a54:	ff 75 0c             	pushl  0xc(%ebp)
  800a57:	53                   	push   %ebx
  800a58:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5b:	ff d0                	call   *%eax
  800a5d:	83 c4 10             	add    $0x10,%esp
			break;
  800a60:	eb 23                	jmp    800a85 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a62:	83 ec 08             	sub    $0x8,%esp
  800a65:	ff 75 0c             	pushl  0xc(%ebp)
  800a68:	6a 25                	push   $0x25
  800a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6d:	ff d0                	call   *%eax
  800a6f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a72:	ff 4d 10             	decl   0x10(%ebp)
  800a75:	eb 03                	jmp    800a7a <vprintfmt+0x3b1>
  800a77:	ff 4d 10             	decl   0x10(%ebp)
  800a7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800a7d:	48                   	dec    %eax
  800a7e:	8a 00                	mov    (%eax),%al
  800a80:	3c 25                	cmp    $0x25,%al
  800a82:	75 f3                	jne    800a77 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a84:	90                   	nop
		}
	}
  800a85:	e9 47 fc ff ff       	jmp    8006d1 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a8a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a8b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a8e:	5b                   	pop    %ebx
  800a8f:	5e                   	pop    %esi
  800a90:	5d                   	pop    %ebp
  800a91:	c3                   	ret    

00800a92 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a92:	55                   	push   %ebp
  800a93:	89 e5                	mov    %esp,%ebp
  800a95:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a98:	8d 45 10             	lea    0x10(%ebp),%eax
  800a9b:	83 c0 04             	add    $0x4,%eax
  800a9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800aa1:	8b 45 10             	mov    0x10(%ebp),%eax
  800aa4:	ff 75 f4             	pushl  -0xc(%ebp)
  800aa7:	50                   	push   %eax
  800aa8:	ff 75 0c             	pushl  0xc(%ebp)
  800aab:	ff 75 08             	pushl  0x8(%ebp)
  800aae:	e8 16 fc ff ff       	call   8006c9 <vprintfmt>
  800ab3:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ab6:	90                   	nop
  800ab7:	c9                   	leave  
  800ab8:	c3                   	ret    

00800ab9 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ab9:	55                   	push   %ebp
  800aba:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800abc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800abf:	8b 40 08             	mov    0x8(%eax),%eax
  800ac2:	8d 50 01             	lea    0x1(%eax),%edx
  800ac5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac8:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800acb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ace:	8b 10                	mov    (%eax),%edx
  800ad0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad3:	8b 40 04             	mov    0x4(%eax),%eax
  800ad6:	39 c2                	cmp    %eax,%edx
  800ad8:	73 12                	jae    800aec <sprintputch+0x33>
		*b->buf++ = ch;
  800ada:	8b 45 0c             	mov    0xc(%ebp),%eax
  800add:	8b 00                	mov    (%eax),%eax
  800adf:	8d 48 01             	lea    0x1(%eax),%ecx
  800ae2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae5:	89 0a                	mov    %ecx,(%edx)
  800ae7:	8b 55 08             	mov    0x8(%ebp),%edx
  800aea:	88 10                	mov    %dl,(%eax)
}
  800aec:	90                   	nop
  800aed:	5d                   	pop    %ebp
  800aee:	c3                   	ret    

00800aef <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800aef:	55                   	push   %ebp
  800af0:	89 e5                	mov    %esp,%ebp
  800af2:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800afb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afe:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b01:	8b 45 08             	mov    0x8(%ebp),%eax
  800b04:	01 d0                	add    %edx,%eax
  800b06:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b09:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b10:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b14:	74 06                	je     800b1c <vsnprintf+0x2d>
  800b16:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b1a:	7f 07                	jg     800b23 <vsnprintf+0x34>
		return -E_INVAL;
  800b1c:	b8 03 00 00 00       	mov    $0x3,%eax
  800b21:	eb 20                	jmp    800b43 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b23:	ff 75 14             	pushl  0x14(%ebp)
  800b26:	ff 75 10             	pushl  0x10(%ebp)
  800b29:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b2c:	50                   	push   %eax
  800b2d:	68 b9 0a 80 00       	push   $0x800ab9
  800b32:	e8 92 fb ff ff       	call   8006c9 <vprintfmt>
  800b37:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b3d:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b40:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b43:	c9                   	leave  
  800b44:	c3                   	ret    

00800b45 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b45:	55                   	push   %ebp
  800b46:	89 e5                	mov    %esp,%ebp
  800b48:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b4b:	8d 45 10             	lea    0x10(%ebp),%eax
  800b4e:	83 c0 04             	add    $0x4,%eax
  800b51:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b54:	8b 45 10             	mov    0x10(%ebp),%eax
  800b57:	ff 75 f4             	pushl  -0xc(%ebp)
  800b5a:	50                   	push   %eax
  800b5b:	ff 75 0c             	pushl  0xc(%ebp)
  800b5e:	ff 75 08             	pushl  0x8(%ebp)
  800b61:	e8 89 ff ff ff       	call   800aef <vsnprintf>
  800b66:	83 c4 10             	add    $0x10,%esp
  800b69:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b6f:	c9                   	leave  
  800b70:	c3                   	ret    

00800b71 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b71:	55                   	push   %ebp
  800b72:	89 e5                	mov    %esp,%ebp
  800b74:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b7e:	eb 06                	jmp    800b86 <strlen+0x15>
		n++;
  800b80:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b83:	ff 45 08             	incl   0x8(%ebp)
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
  800b89:	8a 00                	mov    (%eax),%al
  800b8b:	84 c0                	test   %al,%al
  800b8d:	75 f1                	jne    800b80 <strlen+0xf>
		n++;
	return n;
  800b8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b92:	c9                   	leave  
  800b93:	c3                   	ret    

00800b94 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b94:	55                   	push   %ebp
  800b95:	89 e5                	mov    %esp,%ebp
  800b97:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b9a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ba1:	eb 09                	jmp    800bac <strnlen+0x18>
		n++;
  800ba3:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ba6:	ff 45 08             	incl   0x8(%ebp)
  800ba9:	ff 4d 0c             	decl   0xc(%ebp)
  800bac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bb0:	74 09                	je     800bbb <strnlen+0x27>
  800bb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb5:	8a 00                	mov    (%eax),%al
  800bb7:	84 c0                	test   %al,%al
  800bb9:	75 e8                	jne    800ba3 <strnlen+0xf>
		n++;
	return n;
  800bbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bbe:	c9                   	leave  
  800bbf:	c3                   	ret    

00800bc0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bc0:	55                   	push   %ebp
  800bc1:	89 e5                	mov    %esp,%ebp
  800bc3:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bcc:	90                   	nop
  800bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd0:	8d 50 01             	lea    0x1(%eax),%edx
  800bd3:	89 55 08             	mov    %edx,0x8(%ebp)
  800bd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bd9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bdc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bdf:	8a 12                	mov    (%edx),%dl
  800be1:	88 10                	mov    %dl,(%eax)
  800be3:	8a 00                	mov    (%eax),%al
  800be5:	84 c0                	test   %al,%al
  800be7:	75 e4                	jne    800bcd <strcpy+0xd>
		/* do nothing */;
	return ret;
  800be9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bec:	c9                   	leave  
  800bed:	c3                   	ret    

00800bee <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bee:	55                   	push   %ebp
  800bef:	89 e5                	mov    %esp,%ebp
  800bf1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bfa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c01:	eb 1f                	jmp    800c22 <strncpy+0x34>
		*dst++ = *src;
  800c03:	8b 45 08             	mov    0x8(%ebp),%eax
  800c06:	8d 50 01             	lea    0x1(%eax),%edx
  800c09:	89 55 08             	mov    %edx,0x8(%ebp)
  800c0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c0f:	8a 12                	mov    (%edx),%dl
  800c11:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c16:	8a 00                	mov    (%eax),%al
  800c18:	84 c0                	test   %al,%al
  800c1a:	74 03                	je     800c1f <strncpy+0x31>
			src++;
  800c1c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c1f:	ff 45 fc             	incl   -0x4(%ebp)
  800c22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c25:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c28:	72 d9                	jb     800c03 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c2d:	c9                   	leave  
  800c2e:	c3                   	ret    

00800c2f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c2f:	55                   	push   %ebp
  800c30:	89 e5                	mov    %esp,%ebp
  800c32:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c35:	8b 45 08             	mov    0x8(%ebp),%eax
  800c38:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c3b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c3f:	74 30                	je     800c71 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c41:	eb 16                	jmp    800c59 <strlcpy+0x2a>
			*dst++ = *src++;
  800c43:	8b 45 08             	mov    0x8(%ebp),%eax
  800c46:	8d 50 01             	lea    0x1(%eax),%edx
  800c49:	89 55 08             	mov    %edx,0x8(%ebp)
  800c4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c4f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c52:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c55:	8a 12                	mov    (%edx),%dl
  800c57:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c59:	ff 4d 10             	decl   0x10(%ebp)
  800c5c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c60:	74 09                	je     800c6b <strlcpy+0x3c>
  800c62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c65:	8a 00                	mov    (%eax),%al
  800c67:	84 c0                	test   %al,%al
  800c69:	75 d8                	jne    800c43 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c71:	8b 55 08             	mov    0x8(%ebp),%edx
  800c74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c77:	29 c2                	sub    %eax,%edx
  800c79:	89 d0                	mov    %edx,%eax
}
  800c7b:	c9                   	leave  
  800c7c:	c3                   	ret    

00800c7d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c7d:	55                   	push   %ebp
  800c7e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c80:	eb 06                	jmp    800c88 <strcmp+0xb>
		p++, q++;
  800c82:	ff 45 08             	incl   0x8(%ebp)
  800c85:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c88:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8b:	8a 00                	mov    (%eax),%al
  800c8d:	84 c0                	test   %al,%al
  800c8f:	74 0e                	je     800c9f <strcmp+0x22>
  800c91:	8b 45 08             	mov    0x8(%ebp),%eax
  800c94:	8a 10                	mov    (%eax),%dl
  800c96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c99:	8a 00                	mov    (%eax),%al
  800c9b:	38 c2                	cmp    %al,%dl
  800c9d:	74 e3                	je     800c82 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca2:	8a 00                	mov    (%eax),%al
  800ca4:	0f b6 d0             	movzbl %al,%edx
  800ca7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800caa:	8a 00                	mov    (%eax),%al
  800cac:	0f b6 c0             	movzbl %al,%eax
  800caf:	29 c2                	sub    %eax,%edx
  800cb1:	89 d0                	mov    %edx,%eax
}
  800cb3:	5d                   	pop    %ebp
  800cb4:	c3                   	ret    

00800cb5 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cb5:	55                   	push   %ebp
  800cb6:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cb8:	eb 09                	jmp    800cc3 <strncmp+0xe>
		n--, p++, q++;
  800cba:	ff 4d 10             	decl   0x10(%ebp)
  800cbd:	ff 45 08             	incl   0x8(%ebp)
  800cc0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cc3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc7:	74 17                	je     800ce0 <strncmp+0x2b>
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	8a 00                	mov    (%eax),%al
  800cce:	84 c0                	test   %al,%al
  800cd0:	74 0e                	je     800ce0 <strncmp+0x2b>
  800cd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd5:	8a 10                	mov    (%eax),%dl
  800cd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cda:	8a 00                	mov    (%eax),%al
  800cdc:	38 c2                	cmp    %al,%dl
  800cde:	74 da                	je     800cba <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ce0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce4:	75 07                	jne    800ced <strncmp+0x38>
		return 0;
  800ce6:	b8 00 00 00 00       	mov    $0x0,%eax
  800ceb:	eb 14                	jmp    800d01 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	8a 00                	mov    (%eax),%al
  800cf2:	0f b6 d0             	movzbl %al,%edx
  800cf5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf8:	8a 00                	mov    (%eax),%al
  800cfa:	0f b6 c0             	movzbl %al,%eax
  800cfd:	29 c2                	sub    %eax,%edx
  800cff:	89 d0                	mov    %edx,%eax
}
  800d01:	5d                   	pop    %ebp
  800d02:	c3                   	ret    

00800d03 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d03:	55                   	push   %ebp
  800d04:	89 e5                	mov    %esp,%ebp
  800d06:	83 ec 04             	sub    $0x4,%esp
  800d09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d0f:	eb 12                	jmp    800d23 <strchr+0x20>
		if (*s == c)
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	8a 00                	mov    (%eax),%al
  800d16:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d19:	75 05                	jne    800d20 <strchr+0x1d>
			return (char *) s;
  800d1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1e:	eb 11                	jmp    800d31 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d20:	ff 45 08             	incl   0x8(%ebp)
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	84 c0                	test   %al,%al
  800d2a:	75 e5                	jne    800d11 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d2c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d31:	c9                   	leave  
  800d32:	c3                   	ret    

00800d33 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d33:	55                   	push   %ebp
  800d34:	89 e5                	mov    %esp,%ebp
  800d36:	83 ec 04             	sub    $0x4,%esp
  800d39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d3f:	eb 0d                	jmp    800d4e <strfind+0x1b>
		if (*s == c)
  800d41:	8b 45 08             	mov    0x8(%ebp),%eax
  800d44:	8a 00                	mov    (%eax),%al
  800d46:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d49:	74 0e                	je     800d59 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d4b:	ff 45 08             	incl   0x8(%ebp)
  800d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d51:	8a 00                	mov    (%eax),%al
  800d53:	84 c0                	test   %al,%al
  800d55:	75 ea                	jne    800d41 <strfind+0xe>
  800d57:	eb 01                	jmp    800d5a <strfind+0x27>
		if (*s == c)
			break;
  800d59:	90                   	nop
	return (char *) s;
  800d5a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d5d:	c9                   	leave  
  800d5e:	c3                   	ret    

00800d5f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d5f:	55                   	push   %ebp
  800d60:	89 e5                	mov    %esp,%ebp
  800d62:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d71:	eb 0e                	jmp    800d81 <memset+0x22>
		*p++ = c;
  800d73:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d76:	8d 50 01             	lea    0x1(%eax),%edx
  800d79:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d7f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d81:	ff 4d f8             	decl   -0x8(%ebp)
  800d84:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d88:	79 e9                	jns    800d73 <memset+0x14>
		*p++ = c;

	return v;
  800d8a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d8d:	c9                   	leave  
  800d8e:	c3                   	ret    

00800d8f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d8f:	55                   	push   %ebp
  800d90:	89 e5                	mov    %esp,%ebp
  800d92:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d98:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800da1:	eb 16                	jmp    800db9 <memcpy+0x2a>
		*d++ = *s++;
  800da3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da6:	8d 50 01             	lea    0x1(%eax),%edx
  800da9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dac:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800daf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800db2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800db5:	8a 12                	mov    (%edx),%dl
  800db7:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800db9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dbf:	89 55 10             	mov    %edx,0x10(%ebp)
  800dc2:	85 c0                	test   %eax,%eax
  800dc4:	75 dd                	jne    800da3 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dc9:	c9                   	leave  
  800dca:	c3                   	ret    

00800dcb <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800dcb:	55                   	push   %ebp
  800dcc:	89 e5                	mov    %esp,%ebp
  800dce:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800dd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dda:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ddd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800de3:	73 50                	jae    800e35 <memmove+0x6a>
  800de5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800de8:	8b 45 10             	mov    0x10(%ebp),%eax
  800deb:	01 d0                	add    %edx,%eax
  800ded:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800df0:	76 43                	jbe    800e35 <memmove+0x6a>
		s += n;
  800df2:	8b 45 10             	mov    0x10(%ebp),%eax
  800df5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800df8:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfb:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dfe:	eb 10                	jmp    800e10 <memmove+0x45>
			*--d = *--s;
  800e00:	ff 4d f8             	decl   -0x8(%ebp)
  800e03:	ff 4d fc             	decl   -0x4(%ebp)
  800e06:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e09:	8a 10                	mov    (%eax),%dl
  800e0b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e10:	8b 45 10             	mov    0x10(%ebp),%eax
  800e13:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e16:	89 55 10             	mov    %edx,0x10(%ebp)
  800e19:	85 c0                	test   %eax,%eax
  800e1b:	75 e3                	jne    800e00 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e1d:	eb 23                	jmp    800e42 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e22:	8d 50 01             	lea    0x1(%eax),%edx
  800e25:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e28:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e2b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e2e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e31:	8a 12                	mov    (%edx),%dl
  800e33:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e35:	8b 45 10             	mov    0x10(%ebp),%eax
  800e38:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e3b:	89 55 10             	mov    %edx,0x10(%ebp)
  800e3e:	85 c0                	test   %eax,%eax
  800e40:	75 dd                	jne    800e1f <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e42:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e45:	c9                   	leave  
  800e46:	c3                   	ret    

00800e47 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e47:	55                   	push   %ebp
  800e48:	89 e5                	mov    %esp,%ebp
  800e4a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e50:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e56:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e59:	eb 2a                	jmp    800e85 <memcmp+0x3e>
		if (*s1 != *s2)
  800e5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e5e:	8a 10                	mov    (%eax),%dl
  800e60:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e63:	8a 00                	mov    (%eax),%al
  800e65:	38 c2                	cmp    %al,%dl
  800e67:	74 16                	je     800e7f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e69:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6c:	8a 00                	mov    (%eax),%al
  800e6e:	0f b6 d0             	movzbl %al,%edx
  800e71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e74:	8a 00                	mov    (%eax),%al
  800e76:	0f b6 c0             	movzbl %al,%eax
  800e79:	29 c2                	sub    %eax,%edx
  800e7b:	89 d0                	mov    %edx,%eax
  800e7d:	eb 18                	jmp    800e97 <memcmp+0x50>
		s1++, s2++;
  800e7f:	ff 45 fc             	incl   -0x4(%ebp)
  800e82:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e85:	8b 45 10             	mov    0x10(%ebp),%eax
  800e88:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e8b:	89 55 10             	mov    %edx,0x10(%ebp)
  800e8e:	85 c0                	test   %eax,%eax
  800e90:	75 c9                	jne    800e5b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e92:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e97:	c9                   	leave  
  800e98:	c3                   	ret    

00800e99 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e99:	55                   	push   %ebp
  800e9a:	89 e5                	mov    %esp,%ebp
  800e9c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e9f:	8b 55 08             	mov    0x8(%ebp),%edx
  800ea2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea5:	01 d0                	add    %edx,%eax
  800ea7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800eaa:	eb 15                	jmp    800ec1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaf:	8a 00                	mov    (%eax),%al
  800eb1:	0f b6 d0             	movzbl %al,%edx
  800eb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb7:	0f b6 c0             	movzbl %al,%eax
  800eba:	39 c2                	cmp    %eax,%edx
  800ebc:	74 0d                	je     800ecb <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ebe:	ff 45 08             	incl   0x8(%ebp)
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ec7:	72 e3                	jb     800eac <memfind+0x13>
  800ec9:	eb 01                	jmp    800ecc <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ecb:	90                   	nop
	return (void *) s;
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ecf:	c9                   	leave  
  800ed0:	c3                   	ret    

00800ed1 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ed1:	55                   	push   %ebp
  800ed2:	89 e5                	mov    %esp,%ebp
  800ed4:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ed7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ede:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ee5:	eb 03                	jmp    800eea <strtol+0x19>
		s++;
  800ee7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	8a 00                	mov    (%eax),%al
  800eef:	3c 20                	cmp    $0x20,%al
  800ef1:	74 f4                	je     800ee7 <strtol+0x16>
  800ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef6:	8a 00                	mov    (%eax),%al
  800ef8:	3c 09                	cmp    $0x9,%al
  800efa:	74 eb                	je     800ee7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800efc:	8b 45 08             	mov    0x8(%ebp),%eax
  800eff:	8a 00                	mov    (%eax),%al
  800f01:	3c 2b                	cmp    $0x2b,%al
  800f03:	75 05                	jne    800f0a <strtol+0x39>
		s++;
  800f05:	ff 45 08             	incl   0x8(%ebp)
  800f08:	eb 13                	jmp    800f1d <strtol+0x4c>
	else if (*s == '-')
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	8a 00                	mov    (%eax),%al
  800f0f:	3c 2d                	cmp    $0x2d,%al
  800f11:	75 0a                	jne    800f1d <strtol+0x4c>
		s++, neg = 1;
  800f13:	ff 45 08             	incl   0x8(%ebp)
  800f16:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f21:	74 06                	je     800f29 <strtol+0x58>
  800f23:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f27:	75 20                	jne    800f49 <strtol+0x78>
  800f29:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2c:	8a 00                	mov    (%eax),%al
  800f2e:	3c 30                	cmp    $0x30,%al
  800f30:	75 17                	jne    800f49 <strtol+0x78>
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
  800f35:	40                   	inc    %eax
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	3c 78                	cmp    $0x78,%al
  800f3a:	75 0d                	jne    800f49 <strtol+0x78>
		s += 2, base = 16;
  800f3c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f40:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f47:	eb 28                	jmp    800f71 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f49:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f4d:	75 15                	jne    800f64 <strtol+0x93>
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	8a 00                	mov    (%eax),%al
  800f54:	3c 30                	cmp    $0x30,%al
  800f56:	75 0c                	jne    800f64 <strtol+0x93>
		s++, base = 8;
  800f58:	ff 45 08             	incl   0x8(%ebp)
  800f5b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f62:	eb 0d                	jmp    800f71 <strtol+0xa0>
	else if (base == 0)
  800f64:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f68:	75 07                	jne    800f71 <strtol+0xa0>
		base = 10;
  800f6a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	8a 00                	mov    (%eax),%al
  800f76:	3c 2f                	cmp    $0x2f,%al
  800f78:	7e 19                	jle    800f93 <strtol+0xc2>
  800f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7d:	8a 00                	mov    (%eax),%al
  800f7f:	3c 39                	cmp    $0x39,%al
  800f81:	7f 10                	jg     800f93 <strtol+0xc2>
			dig = *s - '0';
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	8a 00                	mov    (%eax),%al
  800f88:	0f be c0             	movsbl %al,%eax
  800f8b:	83 e8 30             	sub    $0x30,%eax
  800f8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f91:	eb 42                	jmp    800fd5 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	3c 60                	cmp    $0x60,%al
  800f9a:	7e 19                	jle    800fb5 <strtol+0xe4>
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	8a 00                	mov    (%eax),%al
  800fa1:	3c 7a                	cmp    $0x7a,%al
  800fa3:	7f 10                	jg     800fb5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa8:	8a 00                	mov    (%eax),%al
  800faa:	0f be c0             	movsbl %al,%eax
  800fad:	83 e8 57             	sub    $0x57,%eax
  800fb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fb3:	eb 20                	jmp    800fd5 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb8:	8a 00                	mov    (%eax),%al
  800fba:	3c 40                	cmp    $0x40,%al
  800fbc:	7e 39                	jle    800ff7 <strtol+0x126>
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	8a 00                	mov    (%eax),%al
  800fc3:	3c 5a                	cmp    $0x5a,%al
  800fc5:	7f 30                	jg     800ff7 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	8a 00                	mov    (%eax),%al
  800fcc:	0f be c0             	movsbl %al,%eax
  800fcf:	83 e8 37             	sub    $0x37,%eax
  800fd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fd8:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fdb:	7d 19                	jge    800ff6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fdd:	ff 45 08             	incl   0x8(%ebp)
  800fe0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe3:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fe7:	89 c2                	mov    %eax,%edx
  800fe9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fec:	01 d0                	add    %edx,%eax
  800fee:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800ff1:	e9 7b ff ff ff       	jmp    800f71 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800ff6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800ff7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ffb:	74 08                	je     801005 <strtol+0x134>
		*endptr = (char *) s;
  800ffd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801000:	8b 55 08             	mov    0x8(%ebp),%edx
  801003:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801005:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801009:	74 07                	je     801012 <strtol+0x141>
  80100b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80100e:	f7 d8                	neg    %eax
  801010:	eb 03                	jmp    801015 <strtol+0x144>
  801012:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801015:	c9                   	leave  
  801016:	c3                   	ret    

00801017 <ltostr>:

void
ltostr(long value, char *str)
{
  801017:	55                   	push   %ebp
  801018:	89 e5                	mov    %esp,%ebp
  80101a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80101d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801024:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80102b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80102f:	79 13                	jns    801044 <ltostr+0x2d>
	{
		neg = 1;
  801031:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801038:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80103e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801041:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80104c:	99                   	cltd   
  80104d:	f7 f9                	idiv   %ecx
  80104f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801052:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801055:	8d 50 01             	lea    0x1(%eax),%edx
  801058:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80105b:	89 c2                	mov    %eax,%edx
  80105d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801060:	01 d0                	add    %edx,%eax
  801062:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801065:	83 c2 30             	add    $0x30,%edx
  801068:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80106a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80106d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801072:	f7 e9                	imul   %ecx
  801074:	c1 fa 02             	sar    $0x2,%edx
  801077:	89 c8                	mov    %ecx,%eax
  801079:	c1 f8 1f             	sar    $0x1f,%eax
  80107c:	29 c2                	sub    %eax,%edx
  80107e:	89 d0                	mov    %edx,%eax
  801080:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801083:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801086:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80108b:	f7 e9                	imul   %ecx
  80108d:	c1 fa 02             	sar    $0x2,%edx
  801090:	89 c8                	mov    %ecx,%eax
  801092:	c1 f8 1f             	sar    $0x1f,%eax
  801095:	29 c2                	sub    %eax,%edx
  801097:	89 d0                	mov    %edx,%eax
  801099:	c1 e0 02             	shl    $0x2,%eax
  80109c:	01 d0                	add    %edx,%eax
  80109e:	01 c0                	add    %eax,%eax
  8010a0:	29 c1                	sub    %eax,%ecx
  8010a2:	89 ca                	mov    %ecx,%edx
  8010a4:	85 d2                	test   %edx,%edx
  8010a6:	75 9c                	jne    801044 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010af:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b2:	48                   	dec    %eax
  8010b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010b6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010ba:	74 3d                	je     8010f9 <ltostr+0xe2>
		start = 1 ;
  8010bc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010c3:	eb 34                	jmp    8010f9 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cb:	01 d0                	add    %edx,%eax
  8010cd:	8a 00                	mov    (%eax),%al
  8010cf:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d8:	01 c2                	add    %eax,%edx
  8010da:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e0:	01 c8                	add    %ecx,%eax
  8010e2:	8a 00                	mov    (%eax),%al
  8010e4:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010e6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ec:	01 c2                	add    %eax,%edx
  8010ee:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010f1:	88 02                	mov    %al,(%edx)
		start++ ;
  8010f3:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010f6:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010fc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010ff:	7c c4                	jl     8010c5 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801101:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801104:	8b 45 0c             	mov    0xc(%ebp),%eax
  801107:	01 d0                	add    %edx,%eax
  801109:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80110c:	90                   	nop
  80110d:	c9                   	leave  
  80110e:	c3                   	ret    

0080110f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80110f:	55                   	push   %ebp
  801110:	89 e5                	mov    %esp,%ebp
  801112:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801115:	ff 75 08             	pushl  0x8(%ebp)
  801118:	e8 54 fa ff ff       	call   800b71 <strlen>
  80111d:	83 c4 04             	add    $0x4,%esp
  801120:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801123:	ff 75 0c             	pushl  0xc(%ebp)
  801126:	e8 46 fa ff ff       	call   800b71 <strlen>
  80112b:	83 c4 04             	add    $0x4,%esp
  80112e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801131:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801138:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80113f:	eb 17                	jmp    801158 <strcconcat+0x49>
		final[s] = str1[s] ;
  801141:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801144:	8b 45 10             	mov    0x10(%ebp),%eax
  801147:	01 c2                	add    %eax,%edx
  801149:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80114c:	8b 45 08             	mov    0x8(%ebp),%eax
  80114f:	01 c8                	add    %ecx,%eax
  801151:	8a 00                	mov    (%eax),%al
  801153:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801155:	ff 45 fc             	incl   -0x4(%ebp)
  801158:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80115b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80115e:	7c e1                	jl     801141 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801160:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801167:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80116e:	eb 1f                	jmp    80118f <strcconcat+0x80>
		final[s++] = str2[i] ;
  801170:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801173:	8d 50 01             	lea    0x1(%eax),%edx
  801176:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801179:	89 c2                	mov    %eax,%edx
  80117b:	8b 45 10             	mov    0x10(%ebp),%eax
  80117e:	01 c2                	add    %eax,%edx
  801180:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801183:	8b 45 0c             	mov    0xc(%ebp),%eax
  801186:	01 c8                	add    %ecx,%eax
  801188:	8a 00                	mov    (%eax),%al
  80118a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80118c:	ff 45 f8             	incl   -0x8(%ebp)
  80118f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801192:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801195:	7c d9                	jl     801170 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801197:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80119a:	8b 45 10             	mov    0x10(%ebp),%eax
  80119d:	01 d0                	add    %edx,%eax
  80119f:	c6 00 00             	movb   $0x0,(%eax)
}
  8011a2:	90                   	nop
  8011a3:	c9                   	leave  
  8011a4:	c3                   	ret    

008011a5 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011a5:	55                   	push   %ebp
  8011a6:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ab:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b4:	8b 00                	mov    (%eax),%eax
  8011b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c0:	01 d0                	add    %edx,%eax
  8011c2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011c8:	eb 0c                	jmp    8011d6 <strsplit+0x31>
			*string++ = 0;
  8011ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cd:	8d 50 01             	lea    0x1(%eax),%edx
  8011d0:	89 55 08             	mov    %edx,0x8(%ebp)
  8011d3:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	8a 00                	mov    (%eax),%al
  8011db:	84 c0                	test   %al,%al
  8011dd:	74 18                	je     8011f7 <strsplit+0x52>
  8011df:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e2:	8a 00                	mov    (%eax),%al
  8011e4:	0f be c0             	movsbl %al,%eax
  8011e7:	50                   	push   %eax
  8011e8:	ff 75 0c             	pushl  0xc(%ebp)
  8011eb:	e8 13 fb ff ff       	call   800d03 <strchr>
  8011f0:	83 c4 08             	add    $0x8,%esp
  8011f3:	85 c0                	test   %eax,%eax
  8011f5:	75 d3                	jne    8011ca <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8011f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fa:	8a 00                	mov    (%eax),%al
  8011fc:	84 c0                	test   %al,%al
  8011fe:	74 5a                	je     80125a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801200:	8b 45 14             	mov    0x14(%ebp),%eax
  801203:	8b 00                	mov    (%eax),%eax
  801205:	83 f8 0f             	cmp    $0xf,%eax
  801208:	75 07                	jne    801211 <strsplit+0x6c>
		{
			return 0;
  80120a:	b8 00 00 00 00       	mov    $0x0,%eax
  80120f:	eb 66                	jmp    801277 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801211:	8b 45 14             	mov    0x14(%ebp),%eax
  801214:	8b 00                	mov    (%eax),%eax
  801216:	8d 48 01             	lea    0x1(%eax),%ecx
  801219:	8b 55 14             	mov    0x14(%ebp),%edx
  80121c:	89 0a                	mov    %ecx,(%edx)
  80121e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801225:	8b 45 10             	mov    0x10(%ebp),%eax
  801228:	01 c2                	add    %eax,%edx
  80122a:	8b 45 08             	mov    0x8(%ebp),%eax
  80122d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80122f:	eb 03                	jmp    801234 <strsplit+0x8f>
			string++;
  801231:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801234:	8b 45 08             	mov    0x8(%ebp),%eax
  801237:	8a 00                	mov    (%eax),%al
  801239:	84 c0                	test   %al,%al
  80123b:	74 8b                	je     8011c8 <strsplit+0x23>
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	8a 00                	mov    (%eax),%al
  801242:	0f be c0             	movsbl %al,%eax
  801245:	50                   	push   %eax
  801246:	ff 75 0c             	pushl  0xc(%ebp)
  801249:	e8 b5 fa ff ff       	call   800d03 <strchr>
  80124e:	83 c4 08             	add    $0x8,%esp
  801251:	85 c0                	test   %eax,%eax
  801253:	74 dc                	je     801231 <strsplit+0x8c>
			string++;
	}
  801255:	e9 6e ff ff ff       	jmp    8011c8 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80125a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80125b:	8b 45 14             	mov    0x14(%ebp),%eax
  80125e:	8b 00                	mov    (%eax),%eax
  801260:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801267:	8b 45 10             	mov    0x10(%ebp),%eax
  80126a:	01 d0                	add    %edx,%eax
  80126c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801272:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801277:	c9                   	leave  
  801278:	c3                   	ret    

00801279 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801279:	55                   	push   %ebp
  80127a:	89 e5                	mov    %esp,%ebp
  80127c:	57                   	push   %edi
  80127d:	56                   	push   %esi
  80127e:	53                   	push   %ebx
  80127f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801282:	8b 45 08             	mov    0x8(%ebp),%eax
  801285:	8b 55 0c             	mov    0xc(%ebp),%edx
  801288:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80128b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80128e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801291:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801294:	cd 30                	int    $0x30
  801296:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801299:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80129c:	83 c4 10             	add    $0x10,%esp
  80129f:	5b                   	pop    %ebx
  8012a0:	5e                   	pop    %esi
  8012a1:	5f                   	pop    %edi
  8012a2:	5d                   	pop    %ebp
  8012a3:	c3                   	ret    

008012a4 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012a4:	55                   	push   %ebp
  8012a5:	89 e5                	mov    %esp,%ebp
  8012a7:	83 ec 04             	sub    $0x4,%esp
  8012aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ad:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012b0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b7:	6a 00                	push   $0x0
  8012b9:	6a 00                	push   $0x0
  8012bb:	52                   	push   %edx
  8012bc:	ff 75 0c             	pushl  0xc(%ebp)
  8012bf:	50                   	push   %eax
  8012c0:	6a 00                	push   $0x0
  8012c2:	e8 b2 ff ff ff       	call   801279 <syscall>
  8012c7:	83 c4 18             	add    $0x18,%esp
}
  8012ca:	90                   	nop
  8012cb:	c9                   	leave  
  8012cc:	c3                   	ret    

008012cd <sys_cgetc>:

int
sys_cgetc(void)
{
  8012cd:	55                   	push   %ebp
  8012ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 01                	push   $0x1
  8012dc:	e8 98 ff ff ff       	call   801279 <syscall>
  8012e1:	83 c4 18             	add    $0x18,%esp
}
  8012e4:	c9                   	leave  
  8012e5:	c3                   	ret    

008012e6 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012e6:	55                   	push   %ebp
  8012e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	50                   	push   %eax
  8012f5:	6a 05                	push   $0x5
  8012f7:	e8 7d ff ff ff       	call   801279 <syscall>
  8012fc:	83 c4 18             	add    $0x18,%esp
}
  8012ff:	c9                   	leave  
  801300:	c3                   	ret    

00801301 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801301:	55                   	push   %ebp
  801302:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801304:	6a 00                	push   $0x0
  801306:	6a 00                	push   $0x0
  801308:	6a 00                	push   $0x0
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	6a 02                	push   $0x2
  801310:	e8 64 ff ff ff       	call   801279 <syscall>
  801315:	83 c4 18             	add    $0x18,%esp
}
  801318:	c9                   	leave  
  801319:	c3                   	ret    

0080131a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80131a:	55                   	push   %ebp
  80131b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	6a 03                	push   $0x3
  801329:	e8 4b ff ff ff       	call   801279 <syscall>
  80132e:	83 c4 18             	add    $0x18,%esp
}
  801331:	c9                   	leave  
  801332:	c3                   	ret    

00801333 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801333:	55                   	push   %ebp
  801334:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801336:	6a 00                	push   $0x0
  801338:	6a 00                	push   $0x0
  80133a:	6a 00                	push   $0x0
  80133c:	6a 00                	push   $0x0
  80133e:	6a 00                	push   $0x0
  801340:	6a 04                	push   $0x4
  801342:	e8 32 ff ff ff       	call   801279 <syscall>
  801347:	83 c4 18             	add    $0x18,%esp
}
  80134a:	c9                   	leave  
  80134b:	c3                   	ret    

0080134c <sys_env_exit>:


void sys_env_exit(void)
{
  80134c:	55                   	push   %ebp
  80134d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80134f:	6a 00                	push   $0x0
  801351:	6a 00                	push   $0x0
  801353:	6a 00                	push   $0x0
  801355:	6a 00                	push   $0x0
  801357:	6a 00                	push   $0x0
  801359:	6a 06                	push   $0x6
  80135b:	e8 19 ff ff ff       	call   801279 <syscall>
  801360:	83 c4 18             	add    $0x18,%esp
}
  801363:	90                   	nop
  801364:	c9                   	leave  
  801365:	c3                   	ret    

00801366 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801366:	55                   	push   %ebp
  801367:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801369:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136c:	8b 45 08             	mov    0x8(%ebp),%eax
  80136f:	6a 00                	push   $0x0
  801371:	6a 00                	push   $0x0
  801373:	6a 00                	push   $0x0
  801375:	52                   	push   %edx
  801376:	50                   	push   %eax
  801377:	6a 07                	push   $0x7
  801379:	e8 fb fe ff ff       	call   801279 <syscall>
  80137e:	83 c4 18             	add    $0x18,%esp
}
  801381:	c9                   	leave  
  801382:	c3                   	ret    

00801383 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801383:	55                   	push   %ebp
  801384:	89 e5                	mov    %esp,%ebp
  801386:	56                   	push   %esi
  801387:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801388:	8b 75 18             	mov    0x18(%ebp),%esi
  80138b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80138e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801391:	8b 55 0c             	mov    0xc(%ebp),%edx
  801394:	8b 45 08             	mov    0x8(%ebp),%eax
  801397:	56                   	push   %esi
  801398:	53                   	push   %ebx
  801399:	51                   	push   %ecx
  80139a:	52                   	push   %edx
  80139b:	50                   	push   %eax
  80139c:	6a 08                	push   $0x8
  80139e:	e8 d6 fe ff ff       	call   801279 <syscall>
  8013a3:	83 c4 18             	add    $0x18,%esp
}
  8013a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013a9:	5b                   	pop    %ebx
  8013aa:	5e                   	pop    %esi
  8013ab:	5d                   	pop    %ebp
  8013ac:	c3                   	ret    

008013ad <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013ad:	55                   	push   %ebp
  8013ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	52                   	push   %edx
  8013bd:	50                   	push   %eax
  8013be:	6a 09                	push   $0x9
  8013c0:	e8 b4 fe ff ff       	call   801279 <syscall>
  8013c5:	83 c4 18             	add    $0x18,%esp
}
  8013c8:	c9                   	leave  
  8013c9:	c3                   	ret    

008013ca <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013ca:	55                   	push   %ebp
  8013cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013cd:	6a 00                	push   $0x0
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	ff 75 0c             	pushl  0xc(%ebp)
  8013d6:	ff 75 08             	pushl  0x8(%ebp)
  8013d9:	6a 0a                	push   $0xa
  8013db:	e8 99 fe ff ff       	call   801279 <syscall>
  8013e0:	83 c4 18             	add    $0x18,%esp
}
  8013e3:	c9                   	leave  
  8013e4:	c3                   	ret    

008013e5 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013e5:	55                   	push   %ebp
  8013e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 0b                	push   $0xb
  8013f4:	e8 80 fe ff ff       	call   801279 <syscall>
  8013f9:	83 c4 18             	add    $0x18,%esp
}
  8013fc:	c9                   	leave  
  8013fd:	c3                   	ret    

008013fe <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	6a 0c                	push   $0xc
  80140d:	e8 67 fe ff ff       	call   801279 <syscall>
  801412:	83 c4 18             	add    $0x18,%esp
}
  801415:	c9                   	leave  
  801416:	c3                   	ret    

00801417 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801417:	55                   	push   %ebp
  801418:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	6a 00                	push   $0x0
  801424:	6a 0d                	push   $0xd
  801426:	e8 4e fe ff ff       	call   801279 <syscall>
  80142b:	83 c4 18             	add    $0x18,%esp
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	ff 75 0c             	pushl  0xc(%ebp)
  80143c:	ff 75 08             	pushl  0x8(%ebp)
  80143f:	6a 11                	push   $0x11
  801441:	e8 33 fe ff ff       	call   801279 <syscall>
  801446:	83 c4 18             	add    $0x18,%esp
	return;
  801449:	90                   	nop
}
  80144a:	c9                   	leave  
  80144b:	c3                   	ret    

0080144c <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80144c:	55                   	push   %ebp
  80144d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	ff 75 0c             	pushl  0xc(%ebp)
  801458:	ff 75 08             	pushl  0x8(%ebp)
  80145b:	6a 12                	push   $0x12
  80145d:	e8 17 fe ff ff       	call   801279 <syscall>
  801462:	83 c4 18             	add    $0x18,%esp
	return ;
  801465:	90                   	nop
}
  801466:	c9                   	leave  
  801467:	c3                   	ret    

00801468 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801468:	55                   	push   %ebp
  801469:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80146b:	6a 00                	push   $0x0
  80146d:	6a 00                	push   $0x0
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 0e                	push   $0xe
  801477:	e8 fd fd ff ff       	call   801279 <syscall>
  80147c:	83 c4 18             	add    $0x18,%esp
}
  80147f:	c9                   	leave  
  801480:	c3                   	ret    

00801481 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	ff 75 08             	pushl  0x8(%ebp)
  80148f:	6a 0f                	push   $0xf
  801491:	e8 e3 fd ff ff       	call   801279 <syscall>
  801496:	83 c4 18             	add    $0x18,%esp
}
  801499:	c9                   	leave  
  80149a:	c3                   	ret    

0080149b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80149b:	55                   	push   %ebp
  80149c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 10                	push   $0x10
  8014aa:	e8 ca fd ff ff       	call   801279 <syscall>
  8014af:	83 c4 18             	add    $0x18,%esp
}
  8014b2:	90                   	nop
  8014b3:	c9                   	leave  
  8014b4:	c3                   	ret    

008014b5 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014b5:	55                   	push   %ebp
  8014b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 14                	push   $0x14
  8014c4:	e8 b0 fd ff ff       	call   801279 <syscall>
  8014c9:	83 c4 18             	add    $0x18,%esp
}
  8014cc:	90                   	nop
  8014cd:	c9                   	leave  
  8014ce:	c3                   	ret    

008014cf <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014cf:	55                   	push   %ebp
  8014d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 15                	push   $0x15
  8014de:	e8 96 fd ff ff       	call   801279 <syscall>
  8014e3:	83 c4 18             	add    $0x18,%esp
}
  8014e6:	90                   	nop
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
  8014ec:	83 ec 04             	sub    $0x4,%esp
  8014ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014f5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	50                   	push   %eax
  801502:	6a 16                	push   $0x16
  801504:	e8 70 fd ff ff       	call   801279 <syscall>
  801509:	83 c4 18             	add    $0x18,%esp
}
  80150c:	90                   	nop
  80150d:	c9                   	leave  
  80150e:	c3                   	ret    

0080150f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80150f:	55                   	push   %ebp
  801510:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	6a 17                	push   $0x17
  80151e:	e8 56 fd ff ff       	call   801279 <syscall>
  801523:	83 c4 18             	add    $0x18,%esp
}
  801526:	90                   	nop
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80152c:	8b 45 08             	mov    0x8(%ebp),%eax
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	ff 75 0c             	pushl  0xc(%ebp)
  801538:	50                   	push   %eax
  801539:	6a 18                	push   $0x18
  80153b:	e8 39 fd ff ff       	call   801279 <syscall>
  801540:	83 c4 18             	add    $0x18,%esp
}
  801543:	c9                   	leave  
  801544:	c3                   	ret    

00801545 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801545:	55                   	push   %ebp
  801546:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801548:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	52                   	push   %edx
  801555:	50                   	push   %eax
  801556:	6a 1b                	push   $0x1b
  801558:	e8 1c fd ff ff       	call   801279 <syscall>
  80155d:	83 c4 18             	add    $0x18,%esp
}
  801560:	c9                   	leave  
  801561:	c3                   	ret    

00801562 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801562:	55                   	push   %ebp
  801563:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801565:	8b 55 0c             	mov    0xc(%ebp),%edx
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	52                   	push   %edx
  801572:	50                   	push   %eax
  801573:	6a 19                	push   $0x19
  801575:	e8 ff fc ff ff       	call   801279 <syscall>
  80157a:	83 c4 18             	add    $0x18,%esp
}
  80157d:	90                   	nop
  80157e:	c9                   	leave  
  80157f:	c3                   	ret    

00801580 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801583:	8b 55 0c             	mov    0xc(%ebp),%edx
  801586:	8b 45 08             	mov    0x8(%ebp),%eax
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	52                   	push   %edx
  801590:	50                   	push   %eax
  801591:	6a 1a                	push   $0x1a
  801593:	e8 e1 fc ff ff       	call   801279 <syscall>
  801598:	83 c4 18             	add    $0x18,%esp
}
  80159b:	90                   	nop
  80159c:	c9                   	leave  
  80159d:	c3                   	ret    

0080159e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80159e:	55                   	push   %ebp
  80159f:	89 e5                	mov    %esp,%ebp
  8015a1:	83 ec 04             	sub    $0x4,%esp
  8015a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a7:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015aa:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015ad:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b4:	6a 00                	push   $0x0
  8015b6:	51                   	push   %ecx
  8015b7:	52                   	push   %edx
  8015b8:	ff 75 0c             	pushl  0xc(%ebp)
  8015bb:	50                   	push   %eax
  8015bc:	6a 1c                	push   $0x1c
  8015be:	e8 b6 fc ff ff       	call   801279 <syscall>
  8015c3:	83 c4 18             	add    $0x18,%esp
}
  8015c6:	c9                   	leave  
  8015c7:	c3                   	ret    

008015c8 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015c8:	55                   	push   %ebp
  8015c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	52                   	push   %edx
  8015d8:	50                   	push   %eax
  8015d9:	6a 1d                	push   $0x1d
  8015db:	e8 99 fc ff ff       	call   801279 <syscall>
  8015e0:	83 c4 18             	add    $0x18,%esp
}
  8015e3:	c9                   	leave  
  8015e4:	c3                   	ret    

008015e5 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015e5:	55                   	push   %ebp
  8015e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015e8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	51                   	push   %ecx
  8015f6:	52                   	push   %edx
  8015f7:	50                   	push   %eax
  8015f8:	6a 1e                	push   $0x1e
  8015fa:	e8 7a fc ff ff       	call   801279 <syscall>
  8015ff:	83 c4 18             	add    $0x18,%esp
}
  801602:	c9                   	leave  
  801603:	c3                   	ret    

00801604 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801604:	55                   	push   %ebp
  801605:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801607:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160a:	8b 45 08             	mov    0x8(%ebp),%eax
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	52                   	push   %edx
  801614:	50                   	push   %eax
  801615:	6a 1f                	push   $0x1f
  801617:	e8 5d fc ff ff       	call   801279 <syscall>
  80161c:	83 c4 18             	add    $0x18,%esp
}
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	6a 20                	push   $0x20
  801630:	e8 44 fc ff ff       	call   801279 <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
}
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80163d:	8b 45 08             	mov    0x8(%ebp),%eax
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	ff 75 10             	pushl  0x10(%ebp)
  801647:	ff 75 0c             	pushl  0xc(%ebp)
  80164a:	50                   	push   %eax
  80164b:	6a 21                	push   $0x21
  80164d:	e8 27 fc ff ff       	call   801279 <syscall>
  801652:	83 c4 18             	add    $0x18,%esp
}
  801655:	c9                   	leave  
  801656:	c3                   	ret    

00801657 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801657:	55                   	push   %ebp
  801658:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	50                   	push   %eax
  801666:	6a 22                	push   $0x22
  801668:	e8 0c fc ff ff       	call   801279 <syscall>
  80166d:	83 c4 18             	add    $0x18,%esp
}
  801670:	90                   	nop
  801671:	c9                   	leave  
  801672:	c3                   	ret    

00801673 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801673:	55                   	push   %ebp
  801674:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	50                   	push   %eax
  801682:	6a 23                	push   $0x23
  801684:	e8 f0 fb ff ff       	call   801279 <syscall>
  801689:	83 c4 18             	add    $0x18,%esp
}
  80168c:	90                   	nop
  80168d:	c9                   	leave  
  80168e:	c3                   	ret    

0080168f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80168f:	55                   	push   %ebp
  801690:	89 e5                	mov    %esp,%ebp
  801692:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801695:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801698:	8d 50 04             	lea    0x4(%eax),%edx
  80169b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	52                   	push   %edx
  8016a5:	50                   	push   %eax
  8016a6:	6a 24                	push   $0x24
  8016a8:	e8 cc fb ff ff       	call   801279 <syscall>
  8016ad:	83 c4 18             	add    $0x18,%esp
	return result;
  8016b0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016b9:	89 01                	mov    %eax,(%ecx)
  8016bb:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016be:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c1:	c9                   	leave  
  8016c2:	c2 04 00             	ret    $0x4

008016c5 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016c5:	55                   	push   %ebp
  8016c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	ff 75 10             	pushl  0x10(%ebp)
  8016cf:	ff 75 0c             	pushl  0xc(%ebp)
  8016d2:	ff 75 08             	pushl  0x8(%ebp)
  8016d5:	6a 13                	push   $0x13
  8016d7:	e8 9d fb ff ff       	call   801279 <syscall>
  8016dc:	83 c4 18             	add    $0x18,%esp
	return ;
  8016df:	90                   	nop
}
  8016e0:	c9                   	leave  
  8016e1:	c3                   	ret    

008016e2 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 25                	push   $0x25
  8016f1:	e8 83 fb ff ff       	call   801279 <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
}
  8016f9:	c9                   	leave  
  8016fa:	c3                   	ret    

008016fb <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016fb:	55                   	push   %ebp
  8016fc:	89 e5                	mov    %esp,%ebp
  8016fe:	83 ec 04             	sub    $0x4,%esp
  801701:	8b 45 08             	mov    0x8(%ebp),%eax
  801704:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801707:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	50                   	push   %eax
  801714:	6a 26                	push   $0x26
  801716:	e8 5e fb ff ff       	call   801279 <syscall>
  80171b:	83 c4 18             	add    $0x18,%esp
	return ;
  80171e:	90                   	nop
}
  80171f:	c9                   	leave  
  801720:	c3                   	ret    

00801721 <rsttst>:
void rsttst()
{
  801721:	55                   	push   %ebp
  801722:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 28                	push   $0x28
  801730:	e8 44 fb ff ff       	call   801279 <syscall>
  801735:	83 c4 18             	add    $0x18,%esp
	return ;
  801738:	90                   	nop
}
  801739:	c9                   	leave  
  80173a:	c3                   	ret    

0080173b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
  80173e:	83 ec 04             	sub    $0x4,%esp
  801741:	8b 45 14             	mov    0x14(%ebp),%eax
  801744:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801747:	8b 55 18             	mov    0x18(%ebp),%edx
  80174a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80174e:	52                   	push   %edx
  80174f:	50                   	push   %eax
  801750:	ff 75 10             	pushl  0x10(%ebp)
  801753:	ff 75 0c             	pushl  0xc(%ebp)
  801756:	ff 75 08             	pushl  0x8(%ebp)
  801759:	6a 27                	push   $0x27
  80175b:	e8 19 fb ff ff       	call   801279 <syscall>
  801760:	83 c4 18             	add    $0x18,%esp
	return ;
  801763:	90                   	nop
}
  801764:	c9                   	leave  
  801765:	c3                   	ret    

00801766 <chktst>:
void chktst(uint32 n)
{
  801766:	55                   	push   %ebp
  801767:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	ff 75 08             	pushl  0x8(%ebp)
  801774:	6a 29                	push   $0x29
  801776:	e8 fe fa ff ff       	call   801279 <syscall>
  80177b:	83 c4 18             	add    $0x18,%esp
	return ;
  80177e:	90                   	nop
}
  80177f:	c9                   	leave  
  801780:	c3                   	ret    

00801781 <inctst>:

void inctst()
{
  801781:	55                   	push   %ebp
  801782:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 2a                	push   $0x2a
  801790:	e8 e4 fa ff ff       	call   801279 <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
	return ;
  801798:	90                   	nop
}
  801799:	c9                   	leave  
  80179a:	c3                   	ret    

0080179b <gettst>:
uint32 gettst()
{
  80179b:	55                   	push   %ebp
  80179c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 2b                	push   $0x2b
  8017aa:	e8 ca fa ff ff       	call   801279 <syscall>
  8017af:	83 c4 18             	add    $0x18,%esp
}
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
  8017b7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 2c                	push   $0x2c
  8017c6:	e8 ae fa ff ff       	call   801279 <syscall>
  8017cb:	83 c4 18             	add    $0x18,%esp
  8017ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017d1:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017d5:	75 07                	jne    8017de <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017d7:	b8 01 00 00 00       	mov    $0x1,%eax
  8017dc:	eb 05                	jmp    8017e3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017de:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017e3:	c9                   	leave  
  8017e4:	c3                   	ret    

008017e5 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017e5:	55                   	push   %ebp
  8017e6:	89 e5                	mov    %esp,%ebp
  8017e8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 2c                	push   $0x2c
  8017f7:	e8 7d fa ff ff       	call   801279 <syscall>
  8017fc:	83 c4 18             	add    $0x18,%esp
  8017ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801802:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801806:	75 07                	jne    80180f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801808:	b8 01 00 00 00       	mov    $0x1,%eax
  80180d:	eb 05                	jmp    801814 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80180f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801814:	c9                   	leave  
  801815:	c3                   	ret    

00801816 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801816:	55                   	push   %ebp
  801817:	89 e5                	mov    %esp,%ebp
  801819:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 2c                	push   $0x2c
  801828:	e8 4c fa ff ff       	call   801279 <syscall>
  80182d:	83 c4 18             	add    $0x18,%esp
  801830:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801833:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801837:	75 07                	jne    801840 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801839:	b8 01 00 00 00       	mov    $0x1,%eax
  80183e:	eb 05                	jmp    801845 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801840:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801845:	c9                   	leave  
  801846:	c3                   	ret    

00801847 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801847:	55                   	push   %ebp
  801848:	89 e5                	mov    %esp,%ebp
  80184a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 2c                	push   $0x2c
  801859:	e8 1b fa ff ff       	call   801279 <syscall>
  80185e:	83 c4 18             	add    $0x18,%esp
  801861:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801864:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801868:	75 07                	jne    801871 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80186a:	b8 01 00 00 00       	mov    $0x1,%eax
  80186f:	eb 05                	jmp    801876 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801871:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801876:	c9                   	leave  
  801877:	c3                   	ret    

00801878 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801878:	55                   	push   %ebp
  801879:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	ff 75 08             	pushl  0x8(%ebp)
  801886:	6a 2d                	push   $0x2d
  801888:	e8 ec f9 ff ff       	call   801279 <syscall>
  80188d:	83 c4 18             	add    $0x18,%esp
	return ;
  801890:	90                   	nop
}
  801891:	c9                   	leave  
  801892:	c3                   	ret    

00801893 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801893:	55                   	push   %ebp
  801894:	89 e5                	mov    %esp,%ebp
  801896:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801899:	8b 55 08             	mov    0x8(%ebp),%edx
  80189c:	89 d0                	mov    %edx,%eax
  80189e:	c1 e0 02             	shl    $0x2,%eax
  8018a1:	01 d0                	add    %edx,%eax
  8018a3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018aa:	01 d0                	add    %edx,%eax
  8018ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018b3:	01 d0                	add    %edx,%eax
  8018b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018bc:	01 d0                	add    %edx,%eax
  8018be:	c1 e0 04             	shl    $0x4,%eax
  8018c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8018c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8018cb:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8018ce:	83 ec 0c             	sub    $0xc,%esp
  8018d1:	50                   	push   %eax
  8018d2:	e8 b8 fd ff ff       	call   80168f <sys_get_virtual_time>
  8018d7:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8018da:	eb 41                	jmp    80191d <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8018dc:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8018df:	83 ec 0c             	sub    $0xc,%esp
  8018e2:	50                   	push   %eax
  8018e3:	e8 a7 fd ff ff       	call   80168f <sys_get_virtual_time>
  8018e8:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8018eb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8018ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018f1:	29 c2                	sub    %eax,%edx
  8018f3:	89 d0                	mov    %edx,%eax
  8018f5:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8018f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8018fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8018fe:	89 d1                	mov    %edx,%ecx
  801900:	29 c1                	sub    %eax,%ecx
  801902:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801905:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801908:	39 c2                	cmp    %eax,%edx
  80190a:	0f 97 c0             	seta   %al
  80190d:	0f b6 c0             	movzbl %al,%eax
  801910:	29 c1                	sub    %eax,%ecx
  801912:	89 c8                	mov    %ecx,%eax
  801914:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801917:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80191a:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80191d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801920:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801923:	72 b7                	jb     8018dc <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801925:	90                   	nop
  801926:	c9                   	leave  
  801927:	c3                   	ret    

00801928 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801928:	55                   	push   %ebp
  801929:	89 e5                	mov    %esp,%ebp
  80192b:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80192e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801935:	eb 03                	jmp    80193a <busy_wait+0x12>
  801937:	ff 45 fc             	incl   -0x4(%ebp)
  80193a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80193d:	3b 45 08             	cmp    0x8(%ebp),%eax
  801940:	72 f5                	jb     801937 <busy_wait+0xf>
	return i;
  801942:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801945:	c9                   	leave  
  801946:	c3                   	ret    
  801947:	90                   	nop

00801948 <__udivdi3>:
  801948:	55                   	push   %ebp
  801949:	57                   	push   %edi
  80194a:	56                   	push   %esi
  80194b:	53                   	push   %ebx
  80194c:	83 ec 1c             	sub    $0x1c,%esp
  80194f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801953:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801957:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80195b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80195f:	89 ca                	mov    %ecx,%edx
  801961:	89 f8                	mov    %edi,%eax
  801963:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801967:	85 f6                	test   %esi,%esi
  801969:	75 2d                	jne    801998 <__udivdi3+0x50>
  80196b:	39 cf                	cmp    %ecx,%edi
  80196d:	77 65                	ja     8019d4 <__udivdi3+0x8c>
  80196f:	89 fd                	mov    %edi,%ebp
  801971:	85 ff                	test   %edi,%edi
  801973:	75 0b                	jne    801980 <__udivdi3+0x38>
  801975:	b8 01 00 00 00       	mov    $0x1,%eax
  80197a:	31 d2                	xor    %edx,%edx
  80197c:	f7 f7                	div    %edi
  80197e:	89 c5                	mov    %eax,%ebp
  801980:	31 d2                	xor    %edx,%edx
  801982:	89 c8                	mov    %ecx,%eax
  801984:	f7 f5                	div    %ebp
  801986:	89 c1                	mov    %eax,%ecx
  801988:	89 d8                	mov    %ebx,%eax
  80198a:	f7 f5                	div    %ebp
  80198c:	89 cf                	mov    %ecx,%edi
  80198e:	89 fa                	mov    %edi,%edx
  801990:	83 c4 1c             	add    $0x1c,%esp
  801993:	5b                   	pop    %ebx
  801994:	5e                   	pop    %esi
  801995:	5f                   	pop    %edi
  801996:	5d                   	pop    %ebp
  801997:	c3                   	ret    
  801998:	39 ce                	cmp    %ecx,%esi
  80199a:	77 28                	ja     8019c4 <__udivdi3+0x7c>
  80199c:	0f bd fe             	bsr    %esi,%edi
  80199f:	83 f7 1f             	xor    $0x1f,%edi
  8019a2:	75 40                	jne    8019e4 <__udivdi3+0x9c>
  8019a4:	39 ce                	cmp    %ecx,%esi
  8019a6:	72 0a                	jb     8019b2 <__udivdi3+0x6a>
  8019a8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019ac:	0f 87 9e 00 00 00    	ja     801a50 <__udivdi3+0x108>
  8019b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8019b7:	89 fa                	mov    %edi,%edx
  8019b9:	83 c4 1c             	add    $0x1c,%esp
  8019bc:	5b                   	pop    %ebx
  8019bd:	5e                   	pop    %esi
  8019be:	5f                   	pop    %edi
  8019bf:	5d                   	pop    %ebp
  8019c0:	c3                   	ret    
  8019c1:	8d 76 00             	lea    0x0(%esi),%esi
  8019c4:	31 ff                	xor    %edi,%edi
  8019c6:	31 c0                	xor    %eax,%eax
  8019c8:	89 fa                	mov    %edi,%edx
  8019ca:	83 c4 1c             	add    $0x1c,%esp
  8019cd:	5b                   	pop    %ebx
  8019ce:	5e                   	pop    %esi
  8019cf:	5f                   	pop    %edi
  8019d0:	5d                   	pop    %ebp
  8019d1:	c3                   	ret    
  8019d2:	66 90                	xchg   %ax,%ax
  8019d4:	89 d8                	mov    %ebx,%eax
  8019d6:	f7 f7                	div    %edi
  8019d8:	31 ff                	xor    %edi,%edi
  8019da:	89 fa                	mov    %edi,%edx
  8019dc:	83 c4 1c             	add    $0x1c,%esp
  8019df:	5b                   	pop    %ebx
  8019e0:	5e                   	pop    %esi
  8019e1:	5f                   	pop    %edi
  8019e2:	5d                   	pop    %ebp
  8019e3:	c3                   	ret    
  8019e4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8019e9:	89 eb                	mov    %ebp,%ebx
  8019eb:	29 fb                	sub    %edi,%ebx
  8019ed:	89 f9                	mov    %edi,%ecx
  8019ef:	d3 e6                	shl    %cl,%esi
  8019f1:	89 c5                	mov    %eax,%ebp
  8019f3:	88 d9                	mov    %bl,%cl
  8019f5:	d3 ed                	shr    %cl,%ebp
  8019f7:	89 e9                	mov    %ebp,%ecx
  8019f9:	09 f1                	or     %esi,%ecx
  8019fb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019ff:	89 f9                	mov    %edi,%ecx
  801a01:	d3 e0                	shl    %cl,%eax
  801a03:	89 c5                	mov    %eax,%ebp
  801a05:	89 d6                	mov    %edx,%esi
  801a07:	88 d9                	mov    %bl,%cl
  801a09:	d3 ee                	shr    %cl,%esi
  801a0b:	89 f9                	mov    %edi,%ecx
  801a0d:	d3 e2                	shl    %cl,%edx
  801a0f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a13:	88 d9                	mov    %bl,%cl
  801a15:	d3 e8                	shr    %cl,%eax
  801a17:	09 c2                	or     %eax,%edx
  801a19:	89 d0                	mov    %edx,%eax
  801a1b:	89 f2                	mov    %esi,%edx
  801a1d:	f7 74 24 0c          	divl   0xc(%esp)
  801a21:	89 d6                	mov    %edx,%esi
  801a23:	89 c3                	mov    %eax,%ebx
  801a25:	f7 e5                	mul    %ebp
  801a27:	39 d6                	cmp    %edx,%esi
  801a29:	72 19                	jb     801a44 <__udivdi3+0xfc>
  801a2b:	74 0b                	je     801a38 <__udivdi3+0xf0>
  801a2d:	89 d8                	mov    %ebx,%eax
  801a2f:	31 ff                	xor    %edi,%edi
  801a31:	e9 58 ff ff ff       	jmp    80198e <__udivdi3+0x46>
  801a36:	66 90                	xchg   %ax,%ax
  801a38:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a3c:	89 f9                	mov    %edi,%ecx
  801a3e:	d3 e2                	shl    %cl,%edx
  801a40:	39 c2                	cmp    %eax,%edx
  801a42:	73 e9                	jae    801a2d <__udivdi3+0xe5>
  801a44:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a47:	31 ff                	xor    %edi,%edi
  801a49:	e9 40 ff ff ff       	jmp    80198e <__udivdi3+0x46>
  801a4e:	66 90                	xchg   %ax,%ax
  801a50:	31 c0                	xor    %eax,%eax
  801a52:	e9 37 ff ff ff       	jmp    80198e <__udivdi3+0x46>
  801a57:	90                   	nop

00801a58 <__umoddi3>:
  801a58:	55                   	push   %ebp
  801a59:	57                   	push   %edi
  801a5a:	56                   	push   %esi
  801a5b:	53                   	push   %ebx
  801a5c:	83 ec 1c             	sub    $0x1c,%esp
  801a5f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a63:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a67:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a6b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a6f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a73:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a77:	89 f3                	mov    %esi,%ebx
  801a79:	89 fa                	mov    %edi,%edx
  801a7b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a7f:	89 34 24             	mov    %esi,(%esp)
  801a82:	85 c0                	test   %eax,%eax
  801a84:	75 1a                	jne    801aa0 <__umoddi3+0x48>
  801a86:	39 f7                	cmp    %esi,%edi
  801a88:	0f 86 a2 00 00 00    	jbe    801b30 <__umoddi3+0xd8>
  801a8e:	89 c8                	mov    %ecx,%eax
  801a90:	89 f2                	mov    %esi,%edx
  801a92:	f7 f7                	div    %edi
  801a94:	89 d0                	mov    %edx,%eax
  801a96:	31 d2                	xor    %edx,%edx
  801a98:	83 c4 1c             	add    $0x1c,%esp
  801a9b:	5b                   	pop    %ebx
  801a9c:	5e                   	pop    %esi
  801a9d:	5f                   	pop    %edi
  801a9e:	5d                   	pop    %ebp
  801a9f:	c3                   	ret    
  801aa0:	39 f0                	cmp    %esi,%eax
  801aa2:	0f 87 ac 00 00 00    	ja     801b54 <__umoddi3+0xfc>
  801aa8:	0f bd e8             	bsr    %eax,%ebp
  801aab:	83 f5 1f             	xor    $0x1f,%ebp
  801aae:	0f 84 ac 00 00 00    	je     801b60 <__umoddi3+0x108>
  801ab4:	bf 20 00 00 00       	mov    $0x20,%edi
  801ab9:	29 ef                	sub    %ebp,%edi
  801abb:	89 fe                	mov    %edi,%esi
  801abd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ac1:	89 e9                	mov    %ebp,%ecx
  801ac3:	d3 e0                	shl    %cl,%eax
  801ac5:	89 d7                	mov    %edx,%edi
  801ac7:	89 f1                	mov    %esi,%ecx
  801ac9:	d3 ef                	shr    %cl,%edi
  801acb:	09 c7                	or     %eax,%edi
  801acd:	89 e9                	mov    %ebp,%ecx
  801acf:	d3 e2                	shl    %cl,%edx
  801ad1:	89 14 24             	mov    %edx,(%esp)
  801ad4:	89 d8                	mov    %ebx,%eax
  801ad6:	d3 e0                	shl    %cl,%eax
  801ad8:	89 c2                	mov    %eax,%edx
  801ada:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ade:	d3 e0                	shl    %cl,%eax
  801ae0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ae4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ae8:	89 f1                	mov    %esi,%ecx
  801aea:	d3 e8                	shr    %cl,%eax
  801aec:	09 d0                	or     %edx,%eax
  801aee:	d3 eb                	shr    %cl,%ebx
  801af0:	89 da                	mov    %ebx,%edx
  801af2:	f7 f7                	div    %edi
  801af4:	89 d3                	mov    %edx,%ebx
  801af6:	f7 24 24             	mull   (%esp)
  801af9:	89 c6                	mov    %eax,%esi
  801afb:	89 d1                	mov    %edx,%ecx
  801afd:	39 d3                	cmp    %edx,%ebx
  801aff:	0f 82 87 00 00 00    	jb     801b8c <__umoddi3+0x134>
  801b05:	0f 84 91 00 00 00    	je     801b9c <__umoddi3+0x144>
  801b0b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b0f:	29 f2                	sub    %esi,%edx
  801b11:	19 cb                	sbb    %ecx,%ebx
  801b13:	89 d8                	mov    %ebx,%eax
  801b15:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b19:	d3 e0                	shl    %cl,%eax
  801b1b:	89 e9                	mov    %ebp,%ecx
  801b1d:	d3 ea                	shr    %cl,%edx
  801b1f:	09 d0                	or     %edx,%eax
  801b21:	89 e9                	mov    %ebp,%ecx
  801b23:	d3 eb                	shr    %cl,%ebx
  801b25:	89 da                	mov    %ebx,%edx
  801b27:	83 c4 1c             	add    $0x1c,%esp
  801b2a:	5b                   	pop    %ebx
  801b2b:	5e                   	pop    %esi
  801b2c:	5f                   	pop    %edi
  801b2d:	5d                   	pop    %ebp
  801b2e:	c3                   	ret    
  801b2f:	90                   	nop
  801b30:	89 fd                	mov    %edi,%ebp
  801b32:	85 ff                	test   %edi,%edi
  801b34:	75 0b                	jne    801b41 <__umoddi3+0xe9>
  801b36:	b8 01 00 00 00       	mov    $0x1,%eax
  801b3b:	31 d2                	xor    %edx,%edx
  801b3d:	f7 f7                	div    %edi
  801b3f:	89 c5                	mov    %eax,%ebp
  801b41:	89 f0                	mov    %esi,%eax
  801b43:	31 d2                	xor    %edx,%edx
  801b45:	f7 f5                	div    %ebp
  801b47:	89 c8                	mov    %ecx,%eax
  801b49:	f7 f5                	div    %ebp
  801b4b:	89 d0                	mov    %edx,%eax
  801b4d:	e9 44 ff ff ff       	jmp    801a96 <__umoddi3+0x3e>
  801b52:	66 90                	xchg   %ax,%ax
  801b54:	89 c8                	mov    %ecx,%eax
  801b56:	89 f2                	mov    %esi,%edx
  801b58:	83 c4 1c             	add    $0x1c,%esp
  801b5b:	5b                   	pop    %ebx
  801b5c:	5e                   	pop    %esi
  801b5d:	5f                   	pop    %edi
  801b5e:	5d                   	pop    %ebp
  801b5f:	c3                   	ret    
  801b60:	3b 04 24             	cmp    (%esp),%eax
  801b63:	72 06                	jb     801b6b <__umoddi3+0x113>
  801b65:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b69:	77 0f                	ja     801b7a <__umoddi3+0x122>
  801b6b:	89 f2                	mov    %esi,%edx
  801b6d:	29 f9                	sub    %edi,%ecx
  801b6f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b73:	89 14 24             	mov    %edx,(%esp)
  801b76:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b7a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b7e:	8b 14 24             	mov    (%esp),%edx
  801b81:	83 c4 1c             	add    $0x1c,%esp
  801b84:	5b                   	pop    %ebx
  801b85:	5e                   	pop    %esi
  801b86:	5f                   	pop    %edi
  801b87:	5d                   	pop    %ebp
  801b88:	c3                   	ret    
  801b89:	8d 76 00             	lea    0x0(%esi),%esi
  801b8c:	2b 04 24             	sub    (%esp),%eax
  801b8f:	19 fa                	sbb    %edi,%edx
  801b91:	89 d1                	mov    %edx,%ecx
  801b93:	89 c6                	mov    %eax,%esi
  801b95:	e9 71 ff ff ff       	jmp    801b0b <__umoddi3+0xb3>
  801b9a:	66 90                	xchg   %ax,%ax
  801b9c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ba0:	72 ea                	jb     801b8c <__umoddi3+0x134>
  801ba2:	89 d9                	mov    %ebx,%ecx
  801ba4:	e9 62 ff ff ff       	jmp    801b0b <__umoddi3+0xb3>
