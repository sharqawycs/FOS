
obj/user/tst_page_replacement_free_scarce_mem_master_2:     file format elf32-i386


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
  800031:	e8 5a 01 00 00       	call   800190 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 74 20 00 00    	sub    $0x2074,%esp
	int IDs[20];

	// Create & run the slave environments
	IDs[0] = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800042:	a1 04 30 80 00       	mov    0x803004,%eax
  800047:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  80004d:	a1 04 30 80 00       	mov    0x803004,%eax
  800052:	8b 40 74             	mov    0x74(%eax),%eax
  800055:	83 ec 04             	sub    $0x4,%esp
  800058:	52                   	push   %edx
  800059:	50                   	push   %eax
  80005a:	68 20 1c 80 00       	push   $0x801c20
  80005f:	e8 2d 16 00 00       	call   801691 <sys_create_env>
  800064:	83 c4 10             	add    $0x10,%esp
  800067:	89 45 94             	mov    %eax,-0x6c(%ebp)
	sys_run_env(IDs[0]);
  80006a:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80006d:	83 ec 0c             	sub    $0xc,%esp
  800070:	50                   	push   %eax
  800071:	e8 38 16 00 00       	call   8016ae <sys_run_env>
  800076:	83 c4 10             	add    $0x10,%esp
	for(int i = 1; i < 10; ++i)
  800079:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  800080:	eb 44                	jmp    8000c6 <_main+0x8e>
	{
		IDs[i] = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800082:	a1 04 30 80 00       	mov    0x803004,%eax
  800087:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  80008d:	a1 04 30 80 00       	mov    0x803004,%eax
  800092:	8b 40 74             	mov    0x74(%eax),%eax
  800095:	83 ec 04             	sub    $0x4,%esp
  800098:	52                   	push   %edx
  800099:	50                   	push   %eax
  80009a:	68 2f 1c 80 00       	push   $0x801c2f
  80009f:	e8 ed 15 00 00       	call   801691 <sys_create_env>
  8000a4:	83 c4 10             	add    $0x10,%esp
  8000a7:	89 c2                	mov    %eax,%edx
  8000a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000ac:	89 54 85 94          	mov    %edx,-0x6c(%ebp,%eax,4)
		sys_run_env(IDs[i]);
  8000b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b3:	8b 44 85 94          	mov    -0x6c(%ebp,%eax,4),%eax
  8000b7:	83 ec 0c             	sub    $0xc,%esp
  8000ba:	50                   	push   %eax
  8000bb:	e8 ee 15 00 00       	call   8016ae <sys_run_env>
  8000c0:	83 c4 10             	add    $0x10,%esp
	int IDs[20];

	// Create & run the slave environments
	IDs[0] = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
	sys_run_env(IDs[0]);
	for(int i = 1; i < 10; ++i)
  8000c3:	ff 45 f4             	incl   -0xc(%ebp)
  8000c6:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
  8000ca:	7e b6                	jle    800082 <_main+0x4a>
		IDs[i] = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(IDs[i]);
	}

	// To check that the slave environments completed successfully
	rsttst();
  8000cc:	e8 a7 16 00 00       	call   801778 <rsttst>

	env_sleep(3000);
  8000d1:	83 ec 0c             	sub    $0xc,%esp
  8000d4:	68 b8 0b 00 00       	push   $0xbb8
  8000d9:	e8 0c 18 00 00       	call   8018ea <env_sleep>
  8000de:	83 c4 10             	add    $0x10,%esp
	sys_scarce_memory();
  8000e1:	e8 0c 14 00 00       	call   8014f2 <sys_scarce_memory>
	uint32 freePagesBefore = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  8000e6:	e8 51 13 00 00       	call   80143c <sys_calculate_free_frames>
  8000eb:	89 c3                	mov    %eax,%ebx
  8000ed:	e8 63 13 00 00       	call   801455 <sys_calculate_modified_frames>
  8000f2:	01 d8                	add    %ebx,%eax
  8000f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 usedDiskPagesBefore = sys_pf_calculate_allocated_pages();
  8000f7:	e8 c3 13 00 00       	call   8014bf <sys_pf_calculate_allocated_pages>
  8000fc:	89 45 ec             	mov    %eax,-0x14(%ebp)

	// Check the number of pages shall be deleted with the first fault after scarce the memory
	int pagesToBeDeletedCount = sys_calculate_pages_tobe_removed_ready_exit(1);
  8000ff:	83 ec 0c             	sub    $0xc,%esp
  800102:	6a 01                	push   $0x1
  800104:	e8 cf 13 00 00       	call   8014d8 <sys_calculate_pages_tobe_removed_ready_exit>
  800109:	83 c4 10             	add    $0x10,%esp
  80010c:	89 45 e8             	mov    %eax,-0x18(%ebp)

	char arr[PAGE_SIZE*2];
	// Access the created array in STACK to FAULT and Free SCARCE MEM
	arr[1*PAGE_SIZE] = -1;
  80010f:	c6 85 94 ef ff ff ff 	movb   $0xff,-0x106c(%ebp)

	//cprintf("Checking Allocation in Mem & Page File... \n");
	//AFTER freeing MEMORY
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPagesBefore) !=  1) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  800116:	e8 a4 13 00 00       	call   8014bf <sys_pf_calculate_allocated_pages>
  80011b:	2b 45 ec             	sub    -0x14(%ebp),%eax
  80011e:	83 f8 01             	cmp    $0x1,%eax
  800121:	74 14                	je     800137 <_main+0xff>
  800123:	83 ec 04             	sub    $0x4,%esp
  800126:	68 40 1c 80 00       	push   $0x801c40
  80012b:	6a 22                	push   $0x22
  80012d:	68 ac 1c 80 00       	push   $0x801cac
  800132:	e8 5b 01 00 00       	call   800292 <_panic>
		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  800137:	e8 00 13 00 00       	call   80143c <sys_calculate_free_frames>
  80013c:	89 c3                	mov    %eax,%ebx
  80013e:	e8 12 13 00 00       	call   801455 <sys_calculate_modified_frames>
  800143:	01 d8                	add    %ebx,%eax
  800145:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		if( (freePagesBefore + pagesToBeDeletedCount - 1) != freePagesAfter )
  800148:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80014b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80014e:	01 d0                	add    %edx,%eax
  800150:	48                   	dec    %eax
  800151:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800154:	74 14                	je     80016a <_main+0x132>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
  800156:	83 ec 04             	sub    $0x4,%esp
  800159:	68 e4 1c 80 00       	push   $0x801ce4
  80015e:	6a 25                	push   $0x25
  800160:	68 ac 1c 80 00       	push   $0x801cac
  800165:	e8 28 01 00 00       	call   800292 <_panic>
	}

	env_sleep(80000);
  80016a:	83 ec 0c             	sub    $0xc,%esp
  80016d:	68 80 38 01 00       	push   $0x13880
  800172:	e8 73 17 00 00       	call   8018ea <env_sleep>
  800177:	83 c4 10             	add    $0x10,%esp
	// To ensure that the slave environments completed successfully
	cprintf("Congratulations!! test PAGE replacement [FREEING SCARCE MEMORY 2] is completed successfully.\n");
  80017a:	83 ec 0c             	sub    $0xc,%esp
  80017d:	68 60 1d 80 00       	push   $0x801d60
  800182:	e8 bf 03 00 00       	call   800546 <cprintf>
  800187:	83 c4 10             	add    $0x10,%esp
}
  80018a:	90                   	nop
  80018b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80018e:	c9                   	leave  
  80018f:	c3                   	ret    

00800190 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800190:	55                   	push   %ebp
  800191:	89 e5                	mov    %esp,%ebp
  800193:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800196:	e8 d6 11 00 00       	call   801371 <sys_getenvindex>
  80019b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80019e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001a1:	89 d0                	mov    %edx,%eax
  8001a3:	01 c0                	add    %eax,%eax
  8001a5:	01 d0                	add    %edx,%eax
  8001a7:	c1 e0 02             	shl    $0x2,%eax
  8001aa:	01 d0                	add    %edx,%eax
  8001ac:	c1 e0 06             	shl    $0x6,%eax
  8001af:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8001b4:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001b9:	a1 04 30 80 00       	mov    0x803004,%eax
  8001be:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8001c4:	84 c0                	test   %al,%al
  8001c6:	74 0f                	je     8001d7 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8001c8:	a1 04 30 80 00       	mov    0x803004,%eax
  8001cd:	05 f4 02 00 00       	add    $0x2f4,%eax
  8001d2:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001d7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001db:	7e 0a                	jle    8001e7 <libmain+0x57>
		binaryname = argv[0];
  8001dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e0:	8b 00                	mov    (%eax),%eax
  8001e2:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001e7:	83 ec 08             	sub    $0x8,%esp
  8001ea:	ff 75 0c             	pushl  0xc(%ebp)
  8001ed:	ff 75 08             	pushl  0x8(%ebp)
  8001f0:	e8 43 fe ff ff       	call   800038 <_main>
  8001f5:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001f8:	e8 0f 13 00 00       	call   80150c <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001fd:	83 ec 0c             	sub    $0xc,%esp
  800200:	68 d8 1d 80 00       	push   $0x801dd8
  800205:	e8 3c 03 00 00       	call   800546 <cprintf>
  80020a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80020d:	a1 04 30 80 00       	mov    0x803004,%eax
  800212:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800218:	a1 04 30 80 00       	mov    0x803004,%eax
  80021d:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800223:	83 ec 04             	sub    $0x4,%esp
  800226:	52                   	push   %edx
  800227:	50                   	push   %eax
  800228:	68 00 1e 80 00       	push   $0x801e00
  80022d:	e8 14 03 00 00       	call   800546 <cprintf>
  800232:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800235:	a1 04 30 80 00       	mov    0x803004,%eax
  80023a:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800240:	83 ec 08             	sub    $0x8,%esp
  800243:	50                   	push   %eax
  800244:	68 25 1e 80 00       	push   $0x801e25
  800249:	e8 f8 02 00 00       	call   800546 <cprintf>
  80024e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800251:	83 ec 0c             	sub    $0xc,%esp
  800254:	68 d8 1d 80 00       	push   $0x801dd8
  800259:	e8 e8 02 00 00       	call   800546 <cprintf>
  80025e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800261:	e8 c0 12 00 00       	call   801526 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800266:	e8 19 00 00 00       	call   800284 <exit>
}
  80026b:	90                   	nop
  80026c:	c9                   	leave  
  80026d:	c3                   	ret    

0080026e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80026e:	55                   	push   %ebp
  80026f:	89 e5                	mov    %esp,%ebp
  800271:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800274:	83 ec 0c             	sub    $0xc,%esp
  800277:	6a 00                	push   $0x0
  800279:	e8 bf 10 00 00       	call   80133d <sys_env_destroy>
  80027e:	83 c4 10             	add    $0x10,%esp
}
  800281:	90                   	nop
  800282:	c9                   	leave  
  800283:	c3                   	ret    

00800284 <exit>:

void
exit(void)
{
  800284:	55                   	push   %ebp
  800285:	89 e5                	mov    %esp,%ebp
  800287:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80028a:	e8 14 11 00 00       	call   8013a3 <sys_env_exit>
}
  80028f:	90                   	nop
  800290:	c9                   	leave  
  800291:	c3                   	ret    

00800292 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800292:	55                   	push   %ebp
  800293:	89 e5                	mov    %esp,%ebp
  800295:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800298:	8d 45 10             	lea    0x10(%ebp),%eax
  80029b:	83 c0 04             	add    $0x4,%eax
  80029e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002a1:	a1 14 30 80 00       	mov    0x803014,%eax
  8002a6:	85 c0                	test   %eax,%eax
  8002a8:	74 16                	je     8002c0 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002aa:	a1 14 30 80 00       	mov    0x803014,%eax
  8002af:	83 ec 08             	sub    $0x8,%esp
  8002b2:	50                   	push   %eax
  8002b3:	68 3c 1e 80 00       	push   $0x801e3c
  8002b8:	e8 89 02 00 00       	call   800546 <cprintf>
  8002bd:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002c0:	a1 00 30 80 00       	mov    0x803000,%eax
  8002c5:	ff 75 0c             	pushl  0xc(%ebp)
  8002c8:	ff 75 08             	pushl  0x8(%ebp)
  8002cb:	50                   	push   %eax
  8002cc:	68 41 1e 80 00       	push   $0x801e41
  8002d1:	e8 70 02 00 00       	call   800546 <cprintf>
  8002d6:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8002dc:	83 ec 08             	sub    $0x8,%esp
  8002df:	ff 75 f4             	pushl  -0xc(%ebp)
  8002e2:	50                   	push   %eax
  8002e3:	e8 f3 01 00 00       	call   8004db <vcprintf>
  8002e8:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002eb:	83 ec 08             	sub    $0x8,%esp
  8002ee:	6a 00                	push   $0x0
  8002f0:	68 5d 1e 80 00       	push   $0x801e5d
  8002f5:	e8 e1 01 00 00       	call   8004db <vcprintf>
  8002fa:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002fd:	e8 82 ff ff ff       	call   800284 <exit>

	// should not return here
	while (1) ;
  800302:	eb fe                	jmp    800302 <_panic+0x70>

00800304 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800304:	55                   	push   %ebp
  800305:	89 e5                	mov    %esp,%ebp
  800307:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80030a:	a1 04 30 80 00       	mov    0x803004,%eax
  80030f:	8b 50 74             	mov    0x74(%eax),%edx
  800312:	8b 45 0c             	mov    0xc(%ebp),%eax
  800315:	39 c2                	cmp    %eax,%edx
  800317:	74 14                	je     80032d <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800319:	83 ec 04             	sub    $0x4,%esp
  80031c:	68 60 1e 80 00       	push   $0x801e60
  800321:	6a 26                	push   $0x26
  800323:	68 ac 1e 80 00       	push   $0x801eac
  800328:	e8 65 ff ff ff       	call   800292 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80032d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800334:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80033b:	e9 c2 00 00 00       	jmp    800402 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800340:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800343:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034a:	8b 45 08             	mov    0x8(%ebp),%eax
  80034d:	01 d0                	add    %edx,%eax
  80034f:	8b 00                	mov    (%eax),%eax
  800351:	85 c0                	test   %eax,%eax
  800353:	75 08                	jne    80035d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800355:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800358:	e9 a2 00 00 00       	jmp    8003ff <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80035d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800364:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80036b:	eb 69                	jmp    8003d6 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80036d:	a1 04 30 80 00       	mov    0x803004,%eax
  800372:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800378:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80037b:	89 d0                	mov    %edx,%eax
  80037d:	01 c0                	add    %eax,%eax
  80037f:	01 d0                	add    %edx,%eax
  800381:	c1 e0 02             	shl    $0x2,%eax
  800384:	01 c8                	add    %ecx,%eax
  800386:	8a 40 04             	mov    0x4(%eax),%al
  800389:	84 c0                	test   %al,%al
  80038b:	75 46                	jne    8003d3 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80038d:	a1 04 30 80 00       	mov    0x803004,%eax
  800392:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800398:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80039b:	89 d0                	mov    %edx,%eax
  80039d:	01 c0                	add    %eax,%eax
  80039f:	01 d0                	add    %edx,%eax
  8003a1:	c1 e0 02             	shl    $0x2,%eax
  8003a4:	01 c8                	add    %ecx,%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8003ab:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003ae:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003b3:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8003b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c2:	01 c8                	add    %ecx,%eax
  8003c4:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003c6:	39 c2                	cmp    %eax,%edx
  8003c8:	75 09                	jne    8003d3 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8003ca:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003d1:	eb 12                	jmp    8003e5 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003d3:	ff 45 e8             	incl   -0x18(%ebp)
  8003d6:	a1 04 30 80 00       	mov    0x803004,%eax
  8003db:	8b 50 74             	mov    0x74(%eax),%edx
  8003de:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003e1:	39 c2                	cmp    %eax,%edx
  8003e3:	77 88                	ja     80036d <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003e5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003e9:	75 14                	jne    8003ff <CheckWSWithoutLastIndex+0xfb>
			panic(
  8003eb:	83 ec 04             	sub    $0x4,%esp
  8003ee:	68 b8 1e 80 00       	push   $0x801eb8
  8003f3:	6a 3a                	push   $0x3a
  8003f5:	68 ac 1e 80 00       	push   $0x801eac
  8003fa:	e8 93 fe ff ff       	call   800292 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003ff:	ff 45 f0             	incl   -0x10(%ebp)
  800402:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800405:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800408:	0f 8c 32 ff ff ff    	jl     800340 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80040e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800415:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80041c:	eb 26                	jmp    800444 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80041e:	a1 04 30 80 00       	mov    0x803004,%eax
  800423:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800429:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80042c:	89 d0                	mov    %edx,%eax
  80042e:	01 c0                	add    %eax,%eax
  800430:	01 d0                	add    %edx,%eax
  800432:	c1 e0 02             	shl    $0x2,%eax
  800435:	01 c8                	add    %ecx,%eax
  800437:	8a 40 04             	mov    0x4(%eax),%al
  80043a:	3c 01                	cmp    $0x1,%al
  80043c:	75 03                	jne    800441 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80043e:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800441:	ff 45 e0             	incl   -0x20(%ebp)
  800444:	a1 04 30 80 00       	mov    0x803004,%eax
  800449:	8b 50 74             	mov    0x74(%eax),%edx
  80044c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80044f:	39 c2                	cmp    %eax,%edx
  800451:	77 cb                	ja     80041e <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800453:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800456:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800459:	74 14                	je     80046f <CheckWSWithoutLastIndex+0x16b>
		panic(
  80045b:	83 ec 04             	sub    $0x4,%esp
  80045e:	68 0c 1f 80 00       	push   $0x801f0c
  800463:	6a 44                	push   $0x44
  800465:	68 ac 1e 80 00       	push   $0x801eac
  80046a:	e8 23 fe ff ff       	call   800292 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80046f:	90                   	nop
  800470:	c9                   	leave  
  800471:	c3                   	ret    

00800472 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800472:	55                   	push   %ebp
  800473:	89 e5                	mov    %esp,%ebp
  800475:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047b:	8b 00                	mov    (%eax),%eax
  80047d:	8d 48 01             	lea    0x1(%eax),%ecx
  800480:	8b 55 0c             	mov    0xc(%ebp),%edx
  800483:	89 0a                	mov    %ecx,(%edx)
  800485:	8b 55 08             	mov    0x8(%ebp),%edx
  800488:	88 d1                	mov    %dl,%cl
  80048a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80048d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800491:	8b 45 0c             	mov    0xc(%ebp),%eax
  800494:	8b 00                	mov    (%eax),%eax
  800496:	3d ff 00 00 00       	cmp    $0xff,%eax
  80049b:	75 2c                	jne    8004c9 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80049d:	a0 08 30 80 00       	mov    0x803008,%al
  8004a2:	0f b6 c0             	movzbl %al,%eax
  8004a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004a8:	8b 12                	mov    (%edx),%edx
  8004aa:	89 d1                	mov    %edx,%ecx
  8004ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004af:	83 c2 08             	add    $0x8,%edx
  8004b2:	83 ec 04             	sub    $0x4,%esp
  8004b5:	50                   	push   %eax
  8004b6:	51                   	push   %ecx
  8004b7:	52                   	push   %edx
  8004b8:	e8 3e 0e 00 00       	call   8012fb <sys_cputs>
  8004bd:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004cc:	8b 40 04             	mov    0x4(%eax),%eax
  8004cf:	8d 50 01             	lea    0x1(%eax),%edx
  8004d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d5:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004d8:	90                   	nop
  8004d9:	c9                   	leave  
  8004da:	c3                   	ret    

008004db <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004db:	55                   	push   %ebp
  8004dc:	89 e5                	mov    %esp,%ebp
  8004de:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004e4:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004eb:	00 00 00 
	b.cnt = 0;
  8004ee:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004f5:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004f8:	ff 75 0c             	pushl  0xc(%ebp)
  8004fb:	ff 75 08             	pushl  0x8(%ebp)
  8004fe:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800504:	50                   	push   %eax
  800505:	68 72 04 80 00       	push   $0x800472
  80050a:	e8 11 02 00 00       	call   800720 <vprintfmt>
  80050f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800512:	a0 08 30 80 00       	mov    0x803008,%al
  800517:	0f b6 c0             	movzbl %al,%eax
  80051a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800520:	83 ec 04             	sub    $0x4,%esp
  800523:	50                   	push   %eax
  800524:	52                   	push   %edx
  800525:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80052b:	83 c0 08             	add    $0x8,%eax
  80052e:	50                   	push   %eax
  80052f:	e8 c7 0d 00 00       	call   8012fb <sys_cputs>
  800534:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800537:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  80053e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800544:	c9                   	leave  
  800545:	c3                   	ret    

00800546 <cprintf>:

int cprintf(const char *fmt, ...) {
  800546:	55                   	push   %ebp
  800547:	89 e5                	mov    %esp,%ebp
  800549:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80054c:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800553:	8d 45 0c             	lea    0xc(%ebp),%eax
  800556:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800559:	8b 45 08             	mov    0x8(%ebp),%eax
  80055c:	83 ec 08             	sub    $0x8,%esp
  80055f:	ff 75 f4             	pushl  -0xc(%ebp)
  800562:	50                   	push   %eax
  800563:	e8 73 ff ff ff       	call   8004db <vcprintf>
  800568:	83 c4 10             	add    $0x10,%esp
  80056b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80056e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800571:	c9                   	leave  
  800572:	c3                   	ret    

00800573 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800573:	55                   	push   %ebp
  800574:	89 e5                	mov    %esp,%ebp
  800576:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800579:	e8 8e 0f 00 00       	call   80150c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80057e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800581:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800584:	8b 45 08             	mov    0x8(%ebp),%eax
  800587:	83 ec 08             	sub    $0x8,%esp
  80058a:	ff 75 f4             	pushl  -0xc(%ebp)
  80058d:	50                   	push   %eax
  80058e:	e8 48 ff ff ff       	call   8004db <vcprintf>
  800593:	83 c4 10             	add    $0x10,%esp
  800596:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800599:	e8 88 0f 00 00       	call   801526 <sys_enable_interrupt>
	return cnt;
  80059e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005a1:	c9                   	leave  
  8005a2:	c3                   	ret    

008005a3 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005a3:	55                   	push   %ebp
  8005a4:	89 e5                	mov    %esp,%ebp
  8005a6:	53                   	push   %ebx
  8005a7:	83 ec 14             	sub    $0x14,%esp
  8005aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8005ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8005b6:	8b 45 18             	mov    0x18(%ebp),%eax
  8005b9:	ba 00 00 00 00       	mov    $0x0,%edx
  8005be:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005c1:	77 55                	ja     800618 <printnum+0x75>
  8005c3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005c6:	72 05                	jb     8005cd <printnum+0x2a>
  8005c8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005cb:	77 4b                	ja     800618 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005cd:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005d0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005d3:	8b 45 18             	mov    0x18(%ebp),%eax
  8005d6:	ba 00 00 00 00       	mov    $0x0,%edx
  8005db:	52                   	push   %edx
  8005dc:	50                   	push   %eax
  8005dd:	ff 75 f4             	pushl  -0xc(%ebp)
  8005e0:	ff 75 f0             	pushl  -0x10(%ebp)
  8005e3:	e8 b8 13 00 00       	call   8019a0 <__udivdi3>
  8005e8:	83 c4 10             	add    $0x10,%esp
  8005eb:	83 ec 04             	sub    $0x4,%esp
  8005ee:	ff 75 20             	pushl  0x20(%ebp)
  8005f1:	53                   	push   %ebx
  8005f2:	ff 75 18             	pushl  0x18(%ebp)
  8005f5:	52                   	push   %edx
  8005f6:	50                   	push   %eax
  8005f7:	ff 75 0c             	pushl  0xc(%ebp)
  8005fa:	ff 75 08             	pushl  0x8(%ebp)
  8005fd:	e8 a1 ff ff ff       	call   8005a3 <printnum>
  800602:	83 c4 20             	add    $0x20,%esp
  800605:	eb 1a                	jmp    800621 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800607:	83 ec 08             	sub    $0x8,%esp
  80060a:	ff 75 0c             	pushl  0xc(%ebp)
  80060d:	ff 75 20             	pushl  0x20(%ebp)
  800610:	8b 45 08             	mov    0x8(%ebp),%eax
  800613:	ff d0                	call   *%eax
  800615:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800618:	ff 4d 1c             	decl   0x1c(%ebp)
  80061b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80061f:	7f e6                	jg     800607 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800621:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800624:	bb 00 00 00 00       	mov    $0x0,%ebx
  800629:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80062c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80062f:	53                   	push   %ebx
  800630:	51                   	push   %ecx
  800631:	52                   	push   %edx
  800632:	50                   	push   %eax
  800633:	e8 78 14 00 00       	call   801ab0 <__umoddi3>
  800638:	83 c4 10             	add    $0x10,%esp
  80063b:	05 74 21 80 00       	add    $0x802174,%eax
  800640:	8a 00                	mov    (%eax),%al
  800642:	0f be c0             	movsbl %al,%eax
  800645:	83 ec 08             	sub    $0x8,%esp
  800648:	ff 75 0c             	pushl  0xc(%ebp)
  80064b:	50                   	push   %eax
  80064c:	8b 45 08             	mov    0x8(%ebp),%eax
  80064f:	ff d0                	call   *%eax
  800651:	83 c4 10             	add    $0x10,%esp
}
  800654:	90                   	nop
  800655:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800658:	c9                   	leave  
  800659:	c3                   	ret    

0080065a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80065a:	55                   	push   %ebp
  80065b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80065d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800661:	7e 1c                	jle    80067f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800663:	8b 45 08             	mov    0x8(%ebp),%eax
  800666:	8b 00                	mov    (%eax),%eax
  800668:	8d 50 08             	lea    0x8(%eax),%edx
  80066b:	8b 45 08             	mov    0x8(%ebp),%eax
  80066e:	89 10                	mov    %edx,(%eax)
  800670:	8b 45 08             	mov    0x8(%ebp),%eax
  800673:	8b 00                	mov    (%eax),%eax
  800675:	83 e8 08             	sub    $0x8,%eax
  800678:	8b 50 04             	mov    0x4(%eax),%edx
  80067b:	8b 00                	mov    (%eax),%eax
  80067d:	eb 40                	jmp    8006bf <getuint+0x65>
	else if (lflag)
  80067f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800683:	74 1e                	je     8006a3 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800685:	8b 45 08             	mov    0x8(%ebp),%eax
  800688:	8b 00                	mov    (%eax),%eax
  80068a:	8d 50 04             	lea    0x4(%eax),%edx
  80068d:	8b 45 08             	mov    0x8(%ebp),%eax
  800690:	89 10                	mov    %edx,(%eax)
  800692:	8b 45 08             	mov    0x8(%ebp),%eax
  800695:	8b 00                	mov    (%eax),%eax
  800697:	83 e8 04             	sub    $0x4,%eax
  80069a:	8b 00                	mov    (%eax),%eax
  80069c:	ba 00 00 00 00       	mov    $0x0,%edx
  8006a1:	eb 1c                	jmp    8006bf <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a6:	8b 00                	mov    (%eax),%eax
  8006a8:	8d 50 04             	lea    0x4(%eax),%edx
  8006ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ae:	89 10                	mov    %edx,(%eax)
  8006b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b3:	8b 00                	mov    (%eax),%eax
  8006b5:	83 e8 04             	sub    $0x4,%eax
  8006b8:	8b 00                	mov    (%eax),%eax
  8006ba:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006bf:	5d                   	pop    %ebp
  8006c0:	c3                   	ret    

008006c1 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006c1:	55                   	push   %ebp
  8006c2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006c4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006c8:	7e 1c                	jle    8006e6 <getint+0x25>
		return va_arg(*ap, long long);
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	8b 00                	mov    (%eax),%eax
  8006cf:	8d 50 08             	lea    0x8(%eax),%edx
  8006d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d5:	89 10                	mov    %edx,(%eax)
  8006d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006da:	8b 00                	mov    (%eax),%eax
  8006dc:	83 e8 08             	sub    $0x8,%eax
  8006df:	8b 50 04             	mov    0x4(%eax),%edx
  8006e2:	8b 00                	mov    (%eax),%eax
  8006e4:	eb 38                	jmp    80071e <getint+0x5d>
	else if (lflag)
  8006e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006ea:	74 1a                	je     800706 <getint+0x45>
		return va_arg(*ap, long);
  8006ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ef:	8b 00                	mov    (%eax),%eax
  8006f1:	8d 50 04             	lea    0x4(%eax),%edx
  8006f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f7:	89 10                	mov    %edx,(%eax)
  8006f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fc:	8b 00                	mov    (%eax),%eax
  8006fe:	83 e8 04             	sub    $0x4,%eax
  800701:	8b 00                	mov    (%eax),%eax
  800703:	99                   	cltd   
  800704:	eb 18                	jmp    80071e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800706:	8b 45 08             	mov    0x8(%ebp),%eax
  800709:	8b 00                	mov    (%eax),%eax
  80070b:	8d 50 04             	lea    0x4(%eax),%edx
  80070e:	8b 45 08             	mov    0x8(%ebp),%eax
  800711:	89 10                	mov    %edx,(%eax)
  800713:	8b 45 08             	mov    0x8(%ebp),%eax
  800716:	8b 00                	mov    (%eax),%eax
  800718:	83 e8 04             	sub    $0x4,%eax
  80071b:	8b 00                	mov    (%eax),%eax
  80071d:	99                   	cltd   
}
  80071e:	5d                   	pop    %ebp
  80071f:	c3                   	ret    

00800720 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800720:	55                   	push   %ebp
  800721:	89 e5                	mov    %esp,%ebp
  800723:	56                   	push   %esi
  800724:	53                   	push   %ebx
  800725:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800728:	eb 17                	jmp    800741 <vprintfmt+0x21>
			if (ch == '\0')
  80072a:	85 db                	test   %ebx,%ebx
  80072c:	0f 84 af 03 00 00    	je     800ae1 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800732:	83 ec 08             	sub    $0x8,%esp
  800735:	ff 75 0c             	pushl  0xc(%ebp)
  800738:	53                   	push   %ebx
  800739:	8b 45 08             	mov    0x8(%ebp),%eax
  80073c:	ff d0                	call   *%eax
  80073e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800741:	8b 45 10             	mov    0x10(%ebp),%eax
  800744:	8d 50 01             	lea    0x1(%eax),%edx
  800747:	89 55 10             	mov    %edx,0x10(%ebp)
  80074a:	8a 00                	mov    (%eax),%al
  80074c:	0f b6 d8             	movzbl %al,%ebx
  80074f:	83 fb 25             	cmp    $0x25,%ebx
  800752:	75 d6                	jne    80072a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800754:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800758:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80075f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800766:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80076d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800774:	8b 45 10             	mov    0x10(%ebp),%eax
  800777:	8d 50 01             	lea    0x1(%eax),%edx
  80077a:	89 55 10             	mov    %edx,0x10(%ebp)
  80077d:	8a 00                	mov    (%eax),%al
  80077f:	0f b6 d8             	movzbl %al,%ebx
  800782:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800785:	83 f8 55             	cmp    $0x55,%eax
  800788:	0f 87 2b 03 00 00    	ja     800ab9 <vprintfmt+0x399>
  80078e:	8b 04 85 98 21 80 00 	mov    0x802198(,%eax,4),%eax
  800795:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800797:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80079b:	eb d7                	jmp    800774 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80079d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007a1:	eb d1                	jmp    800774 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007a3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8007aa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007ad:	89 d0                	mov    %edx,%eax
  8007af:	c1 e0 02             	shl    $0x2,%eax
  8007b2:	01 d0                	add    %edx,%eax
  8007b4:	01 c0                	add    %eax,%eax
  8007b6:	01 d8                	add    %ebx,%eax
  8007b8:	83 e8 30             	sub    $0x30,%eax
  8007bb:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007be:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c1:	8a 00                	mov    (%eax),%al
  8007c3:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007c6:	83 fb 2f             	cmp    $0x2f,%ebx
  8007c9:	7e 3e                	jle    800809 <vprintfmt+0xe9>
  8007cb:	83 fb 39             	cmp    $0x39,%ebx
  8007ce:	7f 39                	jg     800809 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007d0:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007d3:	eb d5                	jmp    8007aa <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d8:	83 c0 04             	add    $0x4,%eax
  8007db:	89 45 14             	mov    %eax,0x14(%ebp)
  8007de:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e1:	83 e8 04             	sub    $0x4,%eax
  8007e4:	8b 00                	mov    (%eax),%eax
  8007e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007e9:	eb 1f                	jmp    80080a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007eb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ef:	79 83                	jns    800774 <vprintfmt+0x54>
				width = 0;
  8007f1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007f8:	e9 77 ff ff ff       	jmp    800774 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007fd:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800804:	e9 6b ff ff ff       	jmp    800774 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800809:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80080a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80080e:	0f 89 60 ff ff ff    	jns    800774 <vprintfmt+0x54>
				width = precision, precision = -1;
  800814:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800817:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80081a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800821:	e9 4e ff ff ff       	jmp    800774 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800826:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800829:	e9 46 ff ff ff       	jmp    800774 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80082e:	8b 45 14             	mov    0x14(%ebp),%eax
  800831:	83 c0 04             	add    $0x4,%eax
  800834:	89 45 14             	mov    %eax,0x14(%ebp)
  800837:	8b 45 14             	mov    0x14(%ebp),%eax
  80083a:	83 e8 04             	sub    $0x4,%eax
  80083d:	8b 00                	mov    (%eax),%eax
  80083f:	83 ec 08             	sub    $0x8,%esp
  800842:	ff 75 0c             	pushl  0xc(%ebp)
  800845:	50                   	push   %eax
  800846:	8b 45 08             	mov    0x8(%ebp),%eax
  800849:	ff d0                	call   *%eax
  80084b:	83 c4 10             	add    $0x10,%esp
			break;
  80084e:	e9 89 02 00 00       	jmp    800adc <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800853:	8b 45 14             	mov    0x14(%ebp),%eax
  800856:	83 c0 04             	add    $0x4,%eax
  800859:	89 45 14             	mov    %eax,0x14(%ebp)
  80085c:	8b 45 14             	mov    0x14(%ebp),%eax
  80085f:	83 e8 04             	sub    $0x4,%eax
  800862:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800864:	85 db                	test   %ebx,%ebx
  800866:	79 02                	jns    80086a <vprintfmt+0x14a>
				err = -err;
  800868:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80086a:	83 fb 64             	cmp    $0x64,%ebx
  80086d:	7f 0b                	jg     80087a <vprintfmt+0x15a>
  80086f:	8b 34 9d e0 1f 80 00 	mov    0x801fe0(,%ebx,4),%esi
  800876:	85 f6                	test   %esi,%esi
  800878:	75 19                	jne    800893 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80087a:	53                   	push   %ebx
  80087b:	68 85 21 80 00       	push   $0x802185
  800880:	ff 75 0c             	pushl  0xc(%ebp)
  800883:	ff 75 08             	pushl  0x8(%ebp)
  800886:	e8 5e 02 00 00       	call   800ae9 <printfmt>
  80088b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80088e:	e9 49 02 00 00       	jmp    800adc <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800893:	56                   	push   %esi
  800894:	68 8e 21 80 00       	push   $0x80218e
  800899:	ff 75 0c             	pushl  0xc(%ebp)
  80089c:	ff 75 08             	pushl  0x8(%ebp)
  80089f:	e8 45 02 00 00       	call   800ae9 <printfmt>
  8008a4:	83 c4 10             	add    $0x10,%esp
			break;
  8008a7:	e9 30 02 00 00       	jmp    800adc <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8008af:	83 c0 04             	add    $0x4,%eax
  8008b2:	89 45 14             	mov    %eax,0x14(%ebp)
  8008b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b8:	83 e8 04             	sub    $0x4,%eax
  8008bb:	8b 30                	mov    (%eax),%esi
  8008bd:	85 f6                	test   %esi,%esi
  8008bf:	75 05                	jne    8008c6 <vprintfmt+0x1a6>
				p = "(null)";
  8008c1:	be 91 21 80 00       	mov    $0x802191,%esi
			if (width > 0 && padc != '-')
  8008c6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ca:	7e 6d                	jle    800939 <vprintfmt+0x219>
  8008cc:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008d0:	74 67                	je     800939 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008d2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008d5:	83 ec 08             	sub    $0x8,%esp
  8008d8:	50                   	push   %eax
  8008d9:	56                   	push   %esi
  8008da:	e8 0c 03 00 00       	call   800beb <strnlen>
  8008df:	83 c4 10             	add    $0x10,%esp
  8008e2:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008e5:	eb 16                	jmp    8008fd <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008e7:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008eb:	83 ec 08             	sub    $0x8,%esp
  8008ee:	ff 75 0c             	pushl  0xc(%ebp)
  8008f1:	50                   	push   %eax
  8008f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f5:	ff d0                	call   *%eax
  8008f7:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008fa:	ff 4d e4             	decl   -0x1c(%ebp)
  8008fd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800901:	7f e4                	jg     8008e7 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800903:	eb 34                	jmp    800939 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800905:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800909:	74 1c                	je     800927 <vprintfmt+0x207>
  80090b:	83 fb 1f             	cmp    $0x1f,%ebx
  80090e:	7e 05                	jle    800915 <vprintfmt+0x1f5>
  800910:	83 fb 7e             	cmp    $0x7e,%ebx
  800913:	7e 12                	jle    800927 <vprintfmt+0x207>
					putch('?', putdat);
  800915:	83 ec 08             	sub    $0x8,%esp
  800918:	ff 75 0c             	pushl  0xc(%ebp)
  80091b:	6a 3f                	push   $0x3f
  80091d:	8b 45 08             	mov    0x8(%ebp),%eax
  800920:	ff d0                	call   *%eax
  800922:	83 c4 10             	add    $0x10,%esp
  800925:	eb 0f                	jmp    800936 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800927:	83 ec 08             	sub    $0x8,%esp
  80092a:	ff 75 0c             	pushl  0xc(%ebp)
  80092d:	53                   	push   %ebx
  80092e:	8b 45 08             	mov    0x8(%ebp),%eax
  800931:	ff d0                	call   *%eax
  800933:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800936:	ff 4d e4             	decl   -0x1c(%ebp)
  800939:	89 f0                	mov    %esi,%eax
  80093b:	8d 70 01             	lea    0x1(%eax),%esi
  80093e:	8a 00                	mov    (%eax),%al
  800940:	0f be d8             	movsbl %al,%ebx
  800943:	85 db                	test   %ebx,%ebx
  800945:	74 24                	je     80096b <vprintfmt+0x24b>
  800947:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80094b:	78 b8                	js     800905 <vprintfmt+0x1e5>
  80094d:	ff 4d e0             	decl   -0x20(%ebp)
  800950:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800954:	79 af                	jns    800905 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800956:	eb 13                	jmp    80096b <vprintfmt+0x24b>
				putch(' ', putdat);
  800958:	83 ec 08             	sub    $0x8,%esp
  80095b:	ff 75 0c             	pushl  0xc(%ebp)
  80095e:	6a 20                	push   $0x20
  800960:	8b 45 08             	mov    0x8(%ebp),%eax
  800963:	ff d0                	call   *%eax
  800965:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800968:	ff 4d e4             	decl   -0x1c(%ebp)
  80096b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80096f:	7f e7                	jg     800958 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800971:	e9 66 01 00 00       	jmp    800adc <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800976:	83 ec 08             	sub    $0x8,%esp
  800979:	ff 75 e8             	pushl  -0x18(%ebp)
  80097c:	8d 45 14             	lea    0x14(%ebp),%eax
  80097f:	50                   	push   %eax
  800980:	e8 3c fd ff ff       	call   8006c1 <getint>
  800985:	83 c4 10             	add    $0x10,%esp
  800988:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80098b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80098e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800991:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800994:	85 d2                	test   %edx,%edx
  800996:	79 23                	jns    8009bb <vprintfmt+0x29b>
				putch('-', putdat);
  800998:	83 ec 08             	sub    $0x8,%esp
  80099b:	ff 75 0c             	pushl  0xc(%ebp)
  80099e:	6a 2d                	push   $0x2d
  8009a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a3:	ff d0                	call   *%eax
  8009a5:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009ae:	f7 d8                	neg    %eax
  8009b0:	83 d2 00             	adc    $0x0,%edx
  8009b3:	f7 da                	neg    %edx
  8009b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009b8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009bb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009c2:	e9 bc 00 00 00       	jmp    800a83 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009c7:	83 ec 08             	sub    $0x8,%esp
  8009ca:	ff 75 e8             	pushl  -0x18(%ebp)
  8009cd:	8d 45 14             	lea    0x14(%ebp),%eax
  8009d0:	50                   	push   %eax
  8009d1:	e8 84 fc ff ff       	call   80065a <getuint>
  8009d6:	83 c4 10             	add    $0x10,%esp
  8009d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009dc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009df:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009e6:	e9 98 00 00 00       	jmp    800a83 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009eb:	83 ec 08             	sub    $0x8,%esp
  8009ee:	ff 75 0c             	pushl  0xc(%ebp)
  8009f1:	6a 58                	push   $0x58
  8009f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f6:	ff d0                	call   *%eax
  8009f8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009fb:	83 ec 08             	sub    $0x8,%esp
  8009fe:	ff 75 0c             	pushl  0xc(%ebp)
  800a01:	6a 58                	push   $0x58
  800a03:	8b 45 08             	mov    0x8(%ebp),%eax
  800a06:	ff d0                	call   *%eax
  800a08:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a0b:	83 ec 08             	sub    $0x8,%esp
  800a0e:	ff 75 0c             	pushl  0xc(%ebp)
  800a11:	6a 58                	push   $0x58
  800a13:	8b 45 08             	mov    0x8(%ebp),%eax
  800a16:	ff d0                	call   *%eax
  800a18:	83 c4 10             	add    $0x10,%esp
			break;
  800a1b:	e9 bc 00 00 00       	jmp    800adc <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a20:	83 ec 08             	sub    $0x8,%esp
  800a23:	ff 75 0c             	pushl  0xc(%ebp)
  800a26:	6a 30                	push   $0x30
  800a28:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2b:	ff d0                	call   *%eax
  800a2d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a30:	83 ec 08             	sub    $0x8,%esp
  800a33:	ff 75 0c             	pushl  0xc(%ebp)
  800a36:	6a 78                	push   $0x78
  800a38:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3b:	ff d0                	call   *%eax
  800a3d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a40:	8b 45 14             	mov    0x14(%ebp),%eax
  800a43:	83 c0 04             	add    $0x4,%eax
  800a46:	89 45 14             	mov    %eax,0x14(%ebp)
  800a49:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4c:	83 e8 04             	sub    $0x4,%eax
  800a4f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a51:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a54:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a5b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a62:	eb 1f                	jmp    800a83 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a64:	83 ec 08             	sub    $0x8,%esp
  800a67:	ff 75 e8             	pushl  -0x18(%ebp)
  800a6a:	8d 45 14             	lea    0x14(%ebp),%eax
  800a6d:	50                   	push   %eax
  800a6e:	e8 e7 fb ff ff       	call   80065a <getuint>
  800a73:	83 c4 10             	add    $0x10,%esp
  800a76:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a79:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a7c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a83:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a87:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a8a:	83 ec 04             	sub    $0x4,%esp
  800a8d:	52                   	push   %edx
  800a8e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a91:	50                   	push   %eax
  800a92:	ff 75 f4             	pushl  -0xc(%ebp)
  800a95:	ff 75 f0             	pushl  -0x10(%ebp)
  800a98:	ff 75 0c             	pushl  0xc(%ebp)
  800a9b:	ff 75 08             	pushl  0x8(%ebp)
  800a9e:	e8 00 fb ff ff       	call   8005a3 <printnum>
  800aa3:	83 c4 20             	add    $0x20,%esp
			break;
  800aa6:	eb 34                	jmp    800adc <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800aa8:	83 ec 08             	sub    $0x8,%esp
  800aab:	ff 75 0c             	pushl  0xc(%ebp)
  800aae:	53                   	push   %ebx
  800aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab2:	ff d0                	call   *%eax
  800ab4:	83 c4 10             	add    $0x10,%esp
			break;
  800ab7:	eb 23                	jmp    800adc <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ab9:	83 ec 08             	sub    $0x8,%esp
  800abc:	ff 75 0c             	pushl  0xc(%ebp)
  800abf:	6a 25                	push   $0x25
  800ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac4:	ff d0                	call   *%eax
  800ac6:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ac9:	ff 4d 10             	decl   0x10(%ebp)
  800acc:	eb 03                	jmp    800ad1 <vprintfmt+0x3b1>
  800ace:	ff 4d 10             	decl   0x10(%ebp)
  800ad1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ad4:	48                   	dec    %eax
  800ad5:	8a 00                	mov    (%eax),%al
  800ad7:	3c 25                	cmp    $0x25,%al
  800ad9:	75 f3                	jne    800ace <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800adb:	90                   	nop
		}
	}
  800adc:	e9 47 fc ff ff       	jmp    800728 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ae1:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ae2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ae5:	5b                   	pop    %ebx
  800ae6:	5e                   	pop    %esi
  800ae7:	5d                   	pop    %ebp
  800ae8:	c3                   	ret    

00800ae9 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ae9:	55                   	push   %ebp
  800aea:	89 e5                	mov    %esp,%ebp
  800aec:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800aef:	8d 45 10             	lea    0x10(%ebp),%eax
  800af2:	83 c0 04             	add    $0x4,%eax
  800af5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800af8:	8b 45 10             	mov    0x10(%ebp),%eax
  800afb:	ff 75 f4             	pushl  -0xc(%ebp)
  800afe:	50                   	push   %eax
  800aff:	ff 75 0c             	pushl  0xc(%ebp)
  800b02:	ff 75 08             	pushl  0x8(%ebp)
  800b05:	e8 16 fc ff ff       	call   800720 <vprintfmt>
  800b0a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b0d:	90                   	nop
  800b0e:	c9                   	leave  
  800b0f:	c3                   	ret    

00800b10 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b10:	55                   	push   %ebp
  800b11:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b16:	8b 40 08             	mov    0x8(%eax),%eax
  800b19:	8d 50 01             	lea    0x1(%eax),%edx
  800b1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b25:	8b 10                	mov    (%eax),%edx
  800b27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2a:	8b 40 04             	mov    0x4(%eax),%eax
  800b2d:	39 c2                	cmp    %eax,%edx
  800b2f:	73 12                	jae    800b43 <sprintputch+0x33>
		*b->buf++ = ch;
  800b31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b34:	8b 00                	mov    (%eax),%eax
  800b36:	8d 48 01             	lea    0x1(%eax),%ecx
  800b39:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b3c:	89 0a                	mov    %ecx,(%edx)
  800b3e:	8b 55 08             	mov    0x8(%ebp),%edx
  800b41:	88 10                	mov    %dl,(%eax)
}
  800b43:	90                   	nop
  800b44:	5d                   	pop    %ebp
  800b45:	c3                   	ret    

00800b46 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b46:	55                   	push   %ebp
  800b47:	89 e5                	mov    %esp,%ebp
  800b49:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b55:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	01 d0                	add    %edx,%eax
  800b5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b60:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b67:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b6b:	74 06                	je     800b73 <vsnprintf+0x2d>
  800b6d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b71:	7f 07                	jg     800b7a <vsnprintf+0x34>
		return -E_INVAL;
  800b73:	b8 03 00 00 00       	mov    $0x3,%eax
  800b78:	eb 20                	jmp    800b9a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b7a:	ff 75 14             	pushl  0x14(%ebp)
  800b7d:	ff 75 10             	pushl  0x10(%ebp)
  800b80:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b83:	50                   	push   %eax
  800b84:	68 10 0b 80 00       	push   $0x800b10
  800b89:	e8 92 fb ff ff       	call   800720 <vprintfmt>
  800b8e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b91:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b94:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b97:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b9a:	c9                   	leave  
  800b9b:	c3                   	ret    

00800b9c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b9c:	55                   	push   %ebp
  800b9d:	89 e5                	mov    %esp,%ebp
  800b9f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ba2:	8d 45 10             	lea    0x10(%ebp),%eax
  800ba5:	83 c0 04             	add    $0x4,%eax
  800ba8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800bab:	8b 45 10             	mov    0x10(%ebp),%eax
  800bae:	ff 75 f4             	pushl  -0xc(%ebp)
  800bb1:	50                   	push   %eax
  800bb2:	ff 75 0c             	pushl  0xc(%ebp)
  800bb5:	ff 75 08             	pushl  0x8(%ebp)
  800bb8:	e8 89 ff ff ff       	call   800b46 <vsnprintf>
  800bbd:	83 c4 10             	add    $0x10,%esp
  800bc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800bc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bc6:	c9                   	leave  
  800bc7:	c3                   	ret    

00800bc8 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bc8:	55                   	push   %ebp
  800bc9:	89 e5                	mov    %esp,%ebp
  800bcb:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bd5:	eb 06                	jmp    800bdd <strlen+0x15>
		n++;
  800bd7:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800bda:	ff 45 08             	incl   0x8(%ebp)
  800bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800be0:	8a 00                	mov    (%eax),%al
  800be2:	84 c0                	test   %al,%al
  800be4:	75 f1                	jne    800bd7 <strlen+0xf>
		n++;
	return n;
  800be6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800be9:	c9                   	leave  
  800bea:	c3                   	ret    

00800beb <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800beb:	55                   	push   %ebp
  800bec:	89 e5                	mov    %esp,%ebp
  800bee:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bf1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bf8:	eb 09                	jmp    800c03 <strnlen+0x18>
		n++;
  800bfa:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bfd:	ff 45 08             	incl   0x8(%ebp)
  800c00:	ff 4d 0c             	decl   0xc(%ebp)
  800c03:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c07:	74 09                	je     800c12 <strnlen+0x27>
  800c09:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0c:	8a 00                	mov    (%eax),%al
  800c0e:	84 c0                	test   %al,%al
  800c10:	75 e8                	jne    800bfa <strnlen+0xf>
		n++;
	return n;
  800c12:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c15:	c9                   	leave  
  800c16:	c3                   	ret    

00800c17 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c17:	55                   	push   %ebp
  800c18:	89 e5                	mov    %esp,%ebp
  800c1a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c20:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c23:	90                   	nop
  800c24:	8b 45 08             	mov    0x8(%ebp),%eax
  800c27:	8d 50 01             	lea    0x1(%eax),%edx
  800c2a:	89 55 08             	mov    %edx,0x8(%ebp)
  800c2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c30:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c33:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c36:	8a 12                	mov    (%edx),%dl
  800c38:	88 10                	mov    %dl,(%eax)
  800c3a:	8a 00                	mov    (%eax),%al
  800c3c:	84 c0                	test   %al,%al
  800c3e:	75 e4                	jne    800c24 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c40:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c43:	c9                   	leave  
  800c44:	c3                   	ret    

00800c45 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c45:	55                   	push   %ebp
  800c46:	89 e5                	mov    %esp,%ebp
  800c48:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c51:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c58:	eb 1f                	jmp    800c79 <strncpy+0x34>
		*dst++ = *src;
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	8d 50 01             	lea    0x1(%eax),%edx
  800c60:	89 55 08             	mov    %edx,0x8(%ebp)
  800c63:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c66:	8a 12                	mov    (%edx),%dl
  800c68:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6d:	8a 00                	mov    (%eax),%al
  800c6f:	84 c0                	test   %al,%al
  800c71:	74 03                	je     800c76 <strncpy+0x31>
			src++;
  800c73:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c76:	ff 45 fc             	incl   -0x4(%ebp)
  800c79:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c7c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c7f:	72 d9                	jb     800c5a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c81:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c84:	c9                   	leave  
  800c85:	c3                   	ret    

00800c86 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c86:	55                   	push   %ebp
  800c87:	89 e5                	mov    %esp,%ebp
  800c89:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c92:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c96:	74 30                	je     800cc8 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c98:	eb 16                	jmp    800cb0 <strlcpy+0x2a>
			*dst++ = *src++;
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	8d 50 01             	lea    0x1(%eax),%edx
  800ca0:	89 55 08             	mov    %edx,0x8(%ebp)
  800ca3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ca6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ca9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cac:	8a 12                	mov    (%edx),%dl
  800cae:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800cb0:	ff 4d 10             	decl   0x10(%ebp)
  800cb3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb7:	74 09                	je     800cc2 <strlcpy+0x3c>
  800cb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbc:	8a 00                	mov    (%eax),%al
  800cbe:	84 c0                	test   %al,%al
  800cc0:	75 d8                	jne    800c9a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cc8:	8b 55 08             	mov    0x8(%ebp),%edx
  800ccb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cce:	29 c2                	sub    %eax,%edx
  800cd0:	89 d0                	mov    %edx,%eax
}
  800cd2:	c9                   	leave  
  800cd3:	c3                   	ret    

00800cd4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cd4:	55                   	push   %ebp
  800cd5:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800cd7:	eb 06                	jmp    800cdf <strcmp+0xb>
		p++, q++;
  800cd9:	ff 45 08             	incl   0x8(%ebp)
  800cdc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce2:	8a 00                	mov    (%eax),%al
  800ce4:	84 c0                	test   %al,%al
  800ce6:	74 0e                	je     800cf6 <strcmp+0x22>
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ceb:	8a 10                	mov    (%eax),%dl
  800ced:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf0:	8a 00                	mov    (%eax),%al
  800cf2:	38 c2                	cmp    %al,%dl
  800cf4:	74 e3                	je     800cd9 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf9:	8a 00                	mov    (%eax),%al
  800cfb:	0f b6 d0             	movzbl %al,%edx
  800cfe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d01:	8a 00                	mov    (%eax),%al
  800d03:	0f b6 c0             	movzbl %al,%eax
  800d06:	29 c2                	sub    %eax,%edx
  800d08:	89 d0                	mov    %edx,%eax
}
  800d0a:	5d                   	pop    %ebp
  800d0b:	c3                   	ret    

00800d0c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d0c:	55                   	push   %ebp
  800d0d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d0f:	eb 09                	jmp    800d1a <strncmp+0xe>
		n--, p++, q++;
  800d11:	ff 4d 10             	decl   0x10(%ebp)
  800d14:	ff 45 08             	incl   0x8(%ebp)
  800d17:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d1a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d1e:	74 17                	je     800d37 <strncmp+0x2b>
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	8a 00                	mov    (%eax),%al
  800d25:	84 c0                	test   %al,%al
  800d27:	74 0e                	je     800d37 <strncmp+0x2b>
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	8a 10                	mov    (%eax),%dl
  800d2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d31:	8a 00                	mov    (%eax),%al
  800d33:	38 c2                	cmp    %al,%dl
  800d35:	74 da                	je     800d11 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d37:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d3b:	75 07                	jne    800d44 <strncmp+0x38>
		return 0;
  800d3d:	b8 00 00 00 00       	mov    $0x0,%eax
  800d42:	eb 14                	jmp    800d58 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	8a 00                	mov    (%eax),%al
  800d49:	0f b6 d0             	movzbl %al,%edx
  800d4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4f:	8a 00                	mov    (%eax),%al
  800d51:	0f b6 c0             	movzbl %al,%eax
  800d54:	29 c2                	sub    %eax,%edx
  800d56:	89 d0                	mov    %edx,%eax
}
  800d58:	5d                   	pop    %ebp
  800d59:	c3                   	ret    

00800d5a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d5a:	55                   	push   %ebp
  800d5b:	89 e5                	mov    %esp,%ebp
  800d5d:	83 ec 04             	sub    $0x4,%esp
  800d60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d63:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d66:	eb 12                	jmp    800d7a <strchr+0x20>
		if (*s == c)
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6b:	8a 00                	mov    (%eax),%al
  800d6d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d70:	75 05                	jne    800d77 <strchr+0x1d>
			return (char *) s;
  800d72:	8b 45 08             	mov    0x8(%ebp),%eax
  800d75:	eb 11                	jmp    800d88 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d77:	ff 45 08             	incl   0x8(%ebp)
  800d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7d:	8a 00                	mov    (%eax),%al
  800d7f:	84 c0                	test   %al,%al
  800d81:	75 e5                	jne    800d68 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d83:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d88:	c9                   	leave  
  800d89:	c3                   	ret    

00800d8a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d8a:	55                   	push   %ebp
  800d8b:	89 e5                	mov    %esp,%ebp
  800d8d:	83 ec 04             	sub    $0x4,%esp
  800d90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d93:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d96:	eb 0d                	jmp    800da5 <strfind+0x1b>
		if (*s == c)
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	8a 00                	mov    (%eax),%al
  800d9d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800da0:	74 0e                	je     800db0 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800da2:	ff 45 08             	incl   0x8(%ebp)
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	8a 00                	mov    (%eax),%al
  800daa:	84 c0                	test   %al,%al
  800dac:	75 ea                	jne    800d98 <strfind+0xe>
  800dae:	eb 01                	jmp    800db1 <strfind+0x27>
		if (*s == c)
			break;
  800db0:	90                   	nop
	return (char *) s;
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800db4:	c9                   	leave  
  800db5:	c3                   	ret    

00800db6 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800db6:	55                   	push   %ebp
  800db7:	89 e5                	mov    %esp,%ebp
  800db9:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800dbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800dc2:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800dc8:	eb 0e                	jmp    800dd8 <memset+0x22>
		*p++ = c;
  800dca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dcd:	8d 50 01             	lea    0x1(%eax),%edx
  800dd0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800dd3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dd6:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800dd8:	ff 4d f8             	decl   -0x8(%ebp)
  800ddb:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ddf:	79 e9                	jns    800dca <memset+0x14>
		*p++ = c;

	return v;
  800de1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800de4:	c9                   	leave  
  800de5:	c3                   	ret    

00800de6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800de6:	55                   	push   %ebp
  800de7:	89 e5                	mov    %esp,%ebp
  800de9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800def:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800df2:	8b 45 08             	mov    0x8(%ebp),%eax
  800df5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800df8:	eb 16                	jmp    800e10 <memcpy+0x2a>
		*d++ = *s++;
  800dfa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dfd:	8d 50 01             	lea    0x1(%eax),%edx
  800e00:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e03:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e06:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e09:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e0c:	8a 12                	mov    (%edx),%dl
  800e0e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e10:	8b 45 10             	mov    0x10(%ebp),%eax
  800e13:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e16:	89 55 10             	mov    %edx,0x10(%ebp)
  800e19:	85 c0                	test   %eax,%eax
  800e1b:	75 dd                	jne    800dfa <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e20:	c9                   	leave  
  800e21:	c3                   	ret    

00800e22 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e22:	55                   	push   %ebp
  800e23:	89 e5                	mov    %esp,%ebp
  800e25:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800e28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e34:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e37:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e3a:	73 50                	jae    800e8c <memmove+0x6a>
  800e3c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e3f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e42:	01 d0                	add    %edx,%eax
  800e44:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e47:	76 43                	jbe    800e8c <memmove+0x6a>
		s += n;
  800e49:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e52:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e55:	eb 10                	jmp    800e67 <memmove+0x45>
			*--d = *--s;
  800e57:	ff 4d f8             	decl   -0x8(%ebp)
  800e5a:	ff 4d fc             	decl   -0x4(%ebp)
  800e5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e60:	8a 10                	mov    (%eax),%dl
  800e62:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e65:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e67:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e6d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e70:	85 c0                	test   %eax,%eax
  800e72:	75 e3                	jne    800e57 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e74:	eb 23                	jmp    800e99 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e76:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e79:	8d 50 01             	lea    0x1(%eax),%edx
  800e7c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e7f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e82:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e85:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e88:	8a 12                	mov    (%edx),%dl
  800e8a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e92:	89 55 10             	mov    %edx,0x10(%ebp)
  800e95:	85 c0                	test   %eax,%eax
  800e97:	75 dd                	jne    800e76 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e99:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e9c:	c9                   	leave  
  800e9d:	c3                   	ret    

00800e9e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e9e:	55                   	push   %ebp
  800e9f:	89 e5                	mov    %esp,%ebp
  800ea1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ead:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800eb0:	eb 2a                	jmp    800edc <memcmp+0x3e>
		if (*s1 != *s2)
  800eb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb5:	8a 10                	mov    (%eax),%dl
  800eb7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eba:	8a 00                	mov    (%eax),%al
  800ebc:	38 c2                	cmp    %al,%dl
  800ebe:	74 16                	je     800ed6 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ec0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec3:	8a 00                	mov    (%eax),%al
  800ec5:	0f b6 d0             	movzbl %al,%edx
  800ec8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ecb:	8a 00                	mov    (%eax),%al
  800ecd:	0f b6 c0             	movzbl %al,%eax
  800ed0:	29 c2                	sub    %eax,%edx
  800ed2:	89 d0                	mov    %edx,%eax
  800ed4:	eb 18                	jmp    800eee <memcmp+0x50>
		s1++, s2++;
  800ed6:	ff 45 fc             	incl   -0x4(%ebp)
  800ed9:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800edc:	8b 45 10             	mov    0x10(%ebp),%eax
  800edf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ee2:	89 55 10             	mov    %edx,0x10(%ebp)
  800ee5:	85 c0                	test   %eax,%eax
  800ee7:	75 c9                	jne    800eb2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ee9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800eee:	c9                   	leave  
  800eef:	c3                   	ret    

00800ef0 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ef0:	55                   	push   %ebp
  800ef1:	89 e5                	mov    %esp,%ebp
  800ef3:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ef6:	8b 55 08             	mov    0x8(%ebp),%edx
  800ef9:	8b 45 10             	mov    0x10(%ebp),%eax
  800efc:	01 d0                	add    %edx,%eax
  800efe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f01:	eb 15                	jmp    800f18 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f03:	8b 45 08             	mov    0x8(%ebp),%eax
  800f06:	8a 00                	mov    (%eax),%al
  800f08:	0f b6 d0             	movzbl %al,%edx
  800f0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0e:	0f b6 c0             	movzbl %al,%eax
  800f11:	39 c2                	cmp    %eax,%edx
  800f13:	74 0d                	je     800f22 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f15:	ff 45 08             	incl   0x8(%ebp)
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f1e:	72 e3                	jb     800f03 <memfind+0x13>
  800f20:	eb 01                	jmp    800f23 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f22:	90                   	nop
	return (void *) s;
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f26:	c9                   	leave  
  800f27:	c3                   	ret    

00800f28 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f28:	55                   	push   %ebp
  800f29:	89 e5                	mov    %esp,%ebp
  800f2b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f2e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f35:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f3c:	eb 03                	jmp    800f41 <strtol+0x19>
		s++;
  800f3e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f41:	8b 45 08             	mov    0x8(%ebp),%eax
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	3c 20                	cmp    $0x20,%al
  800f48:	74 f4                	je     800f3e <strtol+0x16>
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	8a 00                	mov    (%eax),%al
  800f4f:	3c 09                	cmp    $0x9,%al
  800f51:	74 eb                	je     800f3e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
  800f56:	8a 00                	mov    (%eax),%al
  800f58:	3c 2b                	cmp    $0x2b,%al
  800f5a:	75 05                	jne    800f61 <strtol+0x39>
		s++;
  800f5c:	ff 45 08             	incl   0x8(%ebp)
  800f5f:	eb 13                	jmp    800f74 <strtol+0x4c>
	else if (*s == '-')
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	8a 00                	mov    (%eax),%al
  800f66:	3c 2d                	cmp    $0x2d,%al
  800f68:	75 0a                	jne    800f74 <strtol+0x4c>
		s++, neg = 1;
  800f6a:	ff 45 08             	incl   0x8(%ebp)
  800f6d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f74:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f78:	74 06                	je     800f80 <strtol+0x58>
  800f7a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f7e:	75 20                	jne    800fa0 <strtol+0x78>
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	8a 00                	mov    (%eax),%al
  800f85:	3c 30                	cmp    $0x30,%al
  800f87:	75 17                	jne    800fa0 <strtol+0x78>
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	40                   	inc    %eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	3c 78                	cmp    $0x78,%al
  800f91:	75 0d                	jne    800fa0 <strtol+0x78>
		s += 2, base = 16;
  800f93:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f97:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f9e:	eb 28                	jmp    800fc8 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fa0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa4:	75 15                	jne    800fbb <strtol+0x93>
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa9:	8a 00                	mov    (%eax),%al
  800fab:	3c 30                	cmp    $0x30,%al
  800fad:	75 0c                	jne    800fbb <strtol+0x93>
		s++, base = 8;
  800faf:	ff 45 08             	incl   0x8(%ebp)
  800fb2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fb9:	eb 0d                	jmp    800fc8 <strtol+0xa0>
	else if (base == 0)
  800fbb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fbf:	75 07                	jne    800fc8 <strtol+0xa0>
		base = 10;
  800fc1:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcb:	8a 00                	mov    (%eax),%al
  800fcd:	3c 2f                	cmp    $0x2f,%al
  800fcf:	7e 19                	jle    800fea <strtol+0xc2>
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	8a 00                	mov    (%eax),%al
  800fd6:	3c 39                	cmp    $0x39,%al
  800fd8:	7f 10                	jg     800fea <strtol+0xc2>
			dig = *s - '0';
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	0f be c0             	movsbl %al,%eax
  800fe2:	83 e8 30             	sub    $0x30,%eax
  800fe5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fe8:	eb 42                	jmp    80102c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fea:	8b 45 08             	mov    0x8(%ebp),%eax
  800fed:	8a 00                	mov    (%eax),%al
  800fef:	3c 60                	cmp    $0x60,%al
  800ff1:	7e 19                	jle    80100c <strtol+0xe4>
  800ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff6:	8a 00                	mov    (%eax),%al
  800ff8:	3c 7a                	cmp    $0x7a,%al
  800ffa:	7f 10                	jg     80100c <strtol+0xe4>
			dig = *s - 'a' + 10;
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	8a 00                	mov    (%eax),%al
  801001:	0f be c0             	movsbl %al,%eax
  801004:	83 e8 57             	sub    $0x57,%eax
  801007:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80100a:	eb 20                	jmp    80102c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80100c:	8b 45 08             	mov    0x8(%ebp),%eax
  80100f:	8a 00                	mov    (%eax),%al
  801011:	3c 40                	cmp    $0x40,%al
  801013:	7e 39                	jle    80104e <strtol+0x126>
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
  801018:	8a 00                	mov    (%eax),%al
  80101a:	3c 5a                	cmp    $0x5a,%al
  80101c:	7f 30                	jg     80104e <strtol+0x126>
			dig = *s - 'A' + 10;
  80101e:	8b 45 08             	mov    0x8(%ebp),%eax
  801021:	8a 00                	mov    (%eax),%al
  801023:	0f be c0             	movsbl %al,%eax
  801026:	83 e8 37             	sub    $0x37,%eax
  801029:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80102c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80102f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801032:	7d 19                	jge    80104d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801034:	ff 45 08             	incl   0x8(%ebp)
  801037:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80103a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80103e:	89 c2                	mov    %eax,%edx
  801040:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801043:	01 d0                	add    %edx,%eax
  801045:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801048:	e9 7b ff ff ff       	jmp    800fc8 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80104d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80104e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801052:	74 08                	je     80105c <strtol+0x134>
		*endptr = (char *) s;
  801054:	8b 45 0c             	mov    0xc(%ebp),%eax
  801057:	8b 55 08             	mov    0x8(%ebp),%edx
  80105a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80105c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801060:	74 07                	je     801069 <strtol+0x141>
  801062:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801065:	f7 d8                	neg    %eax
  801067:	eb 03                	jmp    80106c <strtol+0x144>
  801069:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80106c:	c9                   	leave  
  80106d:	c3                   	ret    

0080106e <ltostr>:

void
ltostr(long value, char *str)
{
  80106e:	55                   	push   %ebp
  80106f:	89 e5                	mov    %esp,%ebp
  801071:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801074:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80107b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801082:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801086:	79 13                	jns    80109b <ltostr+0x2d>
	{
		neg = 1;
  801088:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80108f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801092:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801095:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801098:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80109b:	8b 45 08             	mov    0x8(%ebp),%eax
  80109e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010a3:	99                   	cltd   
  8010a4:	f7 f9                	idiv   %ecx
  8010a6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ac:	8d 50 01             	lea    0x1(%eax),%edx
  8010af:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010b2:	89 c2                	mov    %eax,%edx
  8010b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b7:	01 d0                	add    %edx,%eax
  8010b9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010bc:	83 c2 30             	add    $0x30,%edx
  8010bf:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010c1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010c4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010c9:	f7 e9                	imul   %ecx
  8010cb:	c1 fa 02             	sar    $0x2,%edx
  8010ce:	89 c8                	mov    %ecx,%eax
  8010d0:	c1 f8 1f             	sar    $0x1f,%eax
  8010d3:	29 c2                	sub    %eax,%edx
  8010d5:	89 d0                	mov    %edx,%eax
  8010d7:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010da:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010dd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010e2:	f7 e9                	imul   %ecx
  8010e4:	c1 fa 02             	sar    $0x2,%edx
  8010e7:	89 c8                	mov    %ecx,%eax
  8010e9:	c1 f8 1f             	sar    $0x1f,%eax
  8010ec:	29 c2                	sub    %eax,%edx
  8010ee:	89 d0                	mov    %edx,%eax
  8010f0:	c1 e0 02             	shl    $0x2,%eax
  8010f3:	01 d0                	add    %edx,%eax
  8010f5:	01 c0                	add    %eax,%eax
  8010f7:	29 c1                	sub    %eax,%ecx
  8010f9:	89 ca                	mov    %ecx,%edx
  8010fb:	85 d2                	test   %edx,%edx
  8010fd:	75 9c                	jne    80109b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801106:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801109:	48                   	dec    %eax
  80110a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80110d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801111:	74 3d                	je     801150 <ltostr+0xe2>
		start = 1 ;
  801113:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80111a:	eb 34                	jmp    801150 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80111c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80111f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801122:	01 d0                	add    %edx,%eax
  801124:	8a 00                	mov    (%eax),%al
  801126:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801129:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80112c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112f:	01 c2                	add    %eax,%edx
  801131:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801134:	8b 45 0c             	mov    0xc(%ebp),%eax
  801137:	01 c8                	add    %ecx,%eax
  801139:	8a 00                	mov    (%eax),%al
  80113b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80113d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801140:	8b 45 0c             	mov    0xc(%ebp),%eax
  801143:	01 c2                	add    %eax,%edx
  801145:	8a 45 eb             	mov    -0x15(%ebp),%al
  801148:	88 02                	mov    %al,(%edx)
		start++ ;
  80114a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80114d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801150:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801153:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801156:	7c c4                	jl     80111c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801158:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80115b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115e:	01 d0                	add    %edx,%eax
  801160:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801163:	90                   	nop
  801164:	c9                   	leave  
  801165:	c3                   	ret    

00801166 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801166:	55                   	push   %ebp
  801167:	89 e5                	mov    %esp,%ebp
  801169:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80116c:	ff 75 08             	pushl  0x8(%ebp)
  80116f:	e8 54 fa ff ff       	call   800bc8 <strlen>
  801174:	83 c4 04             	add    $0x4,%esp
  801177:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80117a:	ff 75 0c             	pushl  0xc(%ebp)
  80117d:	e8 46 fa ff ff       	call   800bc8 <strlen>
  801182:	83 c4 04             	add    $0x4,%esp
  801185:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801188:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80118f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801196:	eb 17                	jmp    8011af <strcconcat+0x49>
		final[s] = str1[s] ;
  801198:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80119b:	8b 45 10             	mov    0x10(%ebp),%eax
  80119e:	01 c2                	add    %eax,%edx
  8011a0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a6:	01 c8                	add    %ecx,%eax
  8011a8:	8a 00                	mov    (%eax),%al
  8011aa:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011ac:	ff 45 fc             	incl   -0x4(%ebp)
  8011af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011b2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011b5:	7c e1                	jl     801198 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011b7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011be:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011c5:	eb 1f                	jmp    8011e6 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011ca:	8d 50 01             	lea    0x1(%eax),%edx
  8011cd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011d0:	89 c2                	mov    %eax,%edx
  8011d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d5:	01 c2                	add    %eax,%edx
  8011d7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dd:	01 c8                	add    %ecx,%eax
  8011df:	8a 00                	mov    (%eax),%al
  8011e1:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011e3:	ff 45 f8             	incl   -0x8(%ebp)
  8011e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011e9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011ec:	7c d9                	jl     8011c7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f4:	01 d0                	add    %edx,%eax
  8011f6:	c6 00 00             	movb   $0x0,(%eax)
}
  8011f9:	90                   	nop
  8011fa:	c9                   	leave  
  8011fb:	c3                   	ret    

008011fc <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011fc:	55                   	push   %ebp
  8011fd:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801202:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801208:	8b 45 14             	mov    0x14(%ebp),%eax
  80120b:	8b 00                	mov    (%eax),%eax
  80120d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801214:	8b 45 10             	mov    0x10(%ebp),%eax
  801217:	01 d0                	add    %edx,%eax
  801219:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80121f:	eb 0c                	jmp    80122d <strsplit+0x31>
			*string++ = 0;
  801221:	8b 45 08             	mov    0x8(%ebp),%eax
  801224:	8d 50 01             	lea    0x1(%eax),%edx
  801227:	89 55 08             	mov    %edx,0x8(%ebp)
  80122a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80122d:	8b 45 08             	mov    0x8(%ebp),%eax
  801230:	8a 00                	mov    (%eax),%al
  801232:	84 c0                	test   %al,%al
  801234:	74 18                	je     80124e <strsplit+0x52>
  801236:	8b 45 08             	mov    0x8(%ebp),%eax
  801239:	8a 00                	mov    (%eax),%al
  80123b:	0f be c0             	movsbl %al,%eax
  80123e:	50                   	push   %eax
  80123f:	ff 75 0c             	pushl  0xc(%ebp)
  801242:	e8 13 fb ff ff       	call   800d5a <strchr>
  801247:	83 c4 08             	add    $0x8,%esp
  80124a:	85 c0                	test   %eax,%eax
  80124c:	75 d3                	jne    801221 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80124e:	8b 45 08             	mov    0x8(%ebp),%eax
  801251:	8a 00                	mov    (%eax),%al
  801253:	84 c0                	test   %al,%al
  801255:	74 5a                	je     8012b1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801257:	8b 45 14             	mov    0x14(%ebp),%eax
  80125a:	8b 00                	mov    (%eax),%eax
  80125c:	83 f8 0f             	cmp    $0xf,%eax
  80125f:	75 07                	jne    801268 <strsplit+0x6c>
		{
			return 0;
  801261:	b8 00 00 00 00       	mov    $0x0,%eax
  801266:	eb 66                	jmp    8012ce <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801268:	8b 45 14             	mov    0x14(%ebp),%eax
  80126b:	8b 00                	mov    (%eax),%eax
  80126d:	8d 48 01             	lea    0x1(%eax),%ecx
  801270:	8b 55 14             	mov    0x14(%ebp),%edx
  801273:	89 0a                	mov    %ecx,(%edx)
  801275:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80127c:	8b 45 10             	mov    0x10(%ebp),%eax
  80127f:	01 c2                	add    %eax,%edx
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801286:	eb 03                	jmp    80128b <strsplit+0x8f>
			string++;
  801288:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80128b:	8b 45 08             	mov    0x8(%ebp),%eax
  80128e:	8a 00                	mov    (%eax),%al
  801290:	84 c0                	test   %al,%al
  801292:	74 8b                	je     80121f <strsplit+0x23>
  801294:	8b 45 08             	mov    0x8(%ebp),%eax
  801297:	8a 00                	mov    (%eax),%al
  801299:	0f be c0             	movsbl %al,%eax
  80129c:	50                   	push   %eax
  80129d:	ff 75 0c             	pushl  0xc(%ebp)
  8012a0:	e8 b5 fa ff ff       	call   800d5a <strchr>
  8012a5:	83 c4 08             	add    $0x8,%esp
  8012a8:	85 c0                	test   %eax,%eax
  8012aa:	74 dc                	je     801288 <strsplit+0x8c>
			string++;
	}
  8012ac:	e9 6e ff ff ff       	jmp    80121f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012b1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b5:	8b 00                	mov    (%eax),%eax
  8012b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012be:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c1:	01 d0                	add    %edx,%eax
  8012c3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012c9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012ce:	c9                   	leave  
  8012cf:	c3                   	ret    

008012d0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8012d0:	55                   	push   %ebp
  8012d1:	89 e5                	mov    %esp,%ebp
  8012d3:	57                   	push   %edi
  8012d4:	56                   	push   %esi
  8012d5:	53                   	push   %ebx
  8012d6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012df:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012e2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012e5:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012e8:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012eb:	cd 30                	int    $0x30
  8012ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012f3:	83 c4 10             	add    $0x10,%esp
  8012f6:	5b                   	pop    %ebx
  8012f7:	5e                   	pop    %esi
  8012f8:	5f                   	pop    %edi
  8012f9:	5d                   	pop    %ebp
  8012fa:	c3                   	ret    

008012fb <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012fb:	55                   	push   %ebp
  8012fc:	89 e5                	mov    %esp,%ebp
  8012fe:	83 ec 04             	sub    $0x4,%esp
  801301:	8b 45 10             	mov    0x10(%ebp),%eax
  801304:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801307:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	52                   	push   %edx
  801313:	ff 75 0c             	pushl  0xc(%ebp)
  801316:	50                   	push   %eax
  801317:	6a 00                	push   $0x0
  801319:	e8 b2 ff ff ff       	call   8012d0 <syscall>
  80131e:	83 c4 18             	add    $0x18,%esp
}
  801321:	90                   	nop
  801322:	c9                   	leave  
  801323:	c3                   	ret    

00801324 <sys_cgetc>:

int
sys_cgetc(void)
{
  801324:	55                   	push   %ebp
  801325:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801327:	6a 00                	push   $0x0
  801329:	6a 00                	push   $0x0
  80132b:	6a 00                	push   $0x0
  80132d:	6a 00                	push   $0x0
  80132f:	6a 00                	push   $0x0
  801331:	6a 01                	push   $0x1
  801333:	e8 98 ff ff ff       	call   8012d0 <syscall>
  801338:	83 c4 18             	add    $0x18,%esp
}
  80133b:	c9                   	leave  
  80133c:	c3                   	ret    

0080133d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80133d:	55                   	push   %ebp
  80133e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801340:	8b 45 08             	mov    0x8(%ebp),%eax
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	50                   	push   %eax
  80134c:	6a 05                	push   $0x5
  80134e:	e8 7d ff ff ff       	call   8012d0 <syscall>
  801353:	83 c4 18             	add    $0x18,%esp
}
  801356:	c9                   	leave  
  801357:	c3                   	ret    

00801358 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801358:	55                   	push   %ebp
  801359:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80135b:	6a 00                	push   $0x0
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	6a 00                	push   $0x0
  801365:	6a 02                	push   $0x2
  801367:	e8 64 ff ff ff       	call   8012d0 <syscall>
  80136c:	83 c4 18             	add    $0x18,%esp
}
  80136f:	c9                   	leave  
  801370:	c3                   	ret    

00801371 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801371:	55                   	push   %ebp
  801372:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801374:	6a 00                	push   $0x0
  801376:	6a 00                	push   $0x0
  801378:	6a 00                	push   $0x0
  80137a:	6a 00                	push   $0x0
  80137c:	6a 00                	push   $0x0
  80137e:	6a 03                	push   $0x3
  801380:	e8 4b ff ff ff       	call   8012d0 <syscall>
  801385:	83 c4 18             	add    $0x18,%esp
}
  801388:	c9                   	leave  
  801389:	c3                   	ret    

0080138a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80138a:	55                   	push   %ebp
  80138b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80138d:	6a 00                	push   $0x0
  80138f:	6a 00                	push   $0x0
  801391:	6a 00                	push   $0x0
  801393:	6a 00                	push   $0x0
  801395:	6a 00                	push   $0x0
  801397:	6a 04                	push   $0x4
  801399:	e8 32 ff ff ff       	call   8012d0 <syscall>
  80139e:	83 c4 18             	add    $0x18,%esp
}
  8013a1:	c9                   	leave  
  8013a2:	c3                   	ret    

008013a3 <sys_env_exit>:


void sys_env_exit(void)
{
  8013a3:	55                   	push   %ebp
  8013a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8013a6:	6a 00                	push   $0x0
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 00                	push   $0x0
  8013ac:	6a 00                	push   $0x0
  8013ae:	6a 00                	push   $0x0
  8013b0:	6a 06                	push   $0x6
  8013b2:	e8 19 ff ff ff       	call   8012d0 <syscall>
  8013b7:	83 c4 18             	add    $0x18,%esp
}
  8013ba:	90                   	nop
  8013bb:	c9                   	leave  
  8013bc:	c3                   	ret    

008013bd <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8013bd:	55                   	push   %ebp
  8013be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8013c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 00                	push   $0x0
  8013cc:	52                   	push   %edx
  8013cd:	50                   	push   %eax
  8013ce:	6a 07                	push   $0x7
  8013d0:	e8 fb fe ff ff       	call   8012d0 <syscall>
  8013d5:	83 c4 18             	add    $0x18,%esp
}
  8013d8:	c9                   	leave  
  8013d9:	c3                   	ret    

008013da <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013da:	55                   	push   %ebp
  8013db:	89 e5                	mov    %esp,%ebp
  8013dd:	56                   	push   %esi
  8013de:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013df:	8b 75 18             	mov    0x18(%ebp),%esi
  8013e2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ee:	56                   	push   %esi
  8013ef:	53                   	push   %ebx
  8013f0:	51                   	push   %ecx
  8013f1:	52                   	push   %edx
  8013f2:	50                   	push   %eax
  8013f3:	6a 08                	push   $0x8
  8013f5:	e8 d6 fe ff ff       	call   8012d0 <syscall>
  8013fa:	83 c4 18             	add    $0x18,%esp
}
  8013fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801400:	5b                   	pop    %ebx
  801401:	5e                   	pop    %esi
  801402:	5d                   	pop    %ebp
  801403:	c3                   	ret    

00801404 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801404:	55                   	push   %ebp
  801405:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801407:	8b 55 0c             	mov    0xc(%ebp),%edx
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	6a 00                	push   $0x0
  80140f:	6a 00                	push   $0x0
  801411:	6a 00                	push   $0x0
  801413:	52                   	push   %edx
  801414:	50                   	push   %eax
  801415:	6a 09                	push   $0x9
  801417:	e8 b4 fe ff ff       	call   8012d0 <syscall>
  80141c:	83 c4 18             	add    $0x18,%esp
}
  80141f:	c9                   	leave  
  801420:	c3                   	ret    

00801421 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801421:	55                   	push   %ebp
  801422:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801424:	6a 00                	push   $0x0
  801426:	6a 00                	push   $0x0
  801428:	6a 00                	push   $0x0
  80142a:	ff 75 0c             	pushl  0xc(%ebp)
  80142d:	ff 75 08             	pushl  0x8(%ebp)
  801430:	6a 0a                	push   $0xa
  801432:	e8 99 fe ff ff       	call   8012d0 <syscall>
  801437:	83 c4 18             	add    $0x18,%esp
}
  80143a:	c9                   	leave  
  80143b:	c3                   	ret    

0080143c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80143c:	55                   	push   %ebp
  80143d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	6a 00                	push   $0x0
  801447:	6a 00                	push   $0x0
  801449:	6a 0b                	push   $0xb
  80144b:	e8 80 fe ff ff       	call   8012d0 <syscall>
  801450:	83 c4 18             	add    $0x18,%esp
}
  801453:	c9                   	leave  
  801454:	c3                   	ret    

00801455 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801455:	55                   	push   %ebp
  801456:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 00                	push   $0x0
  801462:	6a 0c                	push   $0xc
  801464:	e8 67 fe ff ff       	call   8012d0 <syscall>
  801469:	83 c4 18             	add    $0x18,%esp
}
  80146c:	c9                   	leave  
  80146d:	c3                   	ret    

0080146e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80146e:	55                   	push   %ebp
  80146f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	6a 0d                	push   $0xd
  80147d:	e8 4e fe ff ff       	call   8012d0 <syscall>
  801482:	83 c4 18             	add    $0x18,%esp
}
  801485:	c9                   	leave  
  801486:	c3                   	ret    

00801487 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801487:	55                   	push   %ebp
  801488:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	ff 75 0c             	pushl  0xc(%ebp)
  801493:	ff 75 08             	pushl  0x8(%ebp)
  801496:	6a 11                	push   $0x11
  801498:	e8 33 fe ff ff       	call   8012d0 <syscall>
  80149d:	83 c4 18             	add    $0x18,%esp
	return;
  8014a0:	90                   	nop
}
  8014a1:	c9                   	leave  
  8014a2:	c3                   	ret    

008014a3 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8014a3:	55                   	push   %ebp
  8014a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	ff 75 0c             	pushl  0xc(%ebp)
  8014af:	ff 75 08             	pushl  0x8(%ebp)
  8014b2:	6a 12                	push   $0x12
  8014b4:	e8 17 fe ff ff       	call   8012d0 <syscall>
  8014b9:	83 c4 18             	add    $0x18,%esp
	return ;
  8014bc:	90                   	nop
}
  8014bd:	c9                   	leave  
  8014be:	c3                   	ret    

008014bf <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8014bf:	55                   	push   %ebp
  8014c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 0e                	push   $0xe
  8014ce:	e8 fd fd ff ff       	call   8012d0 <syscall>
  8014d3:	83 c4 18             	add    $0x18,%esp
}
  8014d6:	c9                   	leave  
  8014d7:	c3                   	ret    

008014d8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8014d8:	55                   	push   %ebp
  8014d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	ff 75 08             	pushl  0x8(%ebp)
  8014e6:	6a 0f                	push   $0xf
  8014e8:	e8 e3 fd ff ff       	call   8012d0 <syscall>
  8014ed:	83 c4 18             	add    $0x18,%esp
}
  8014f0:	c9                   	leave  
  8014f1:	c3                   	ret    

008014f2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014f2:	55                   	push   %ebp
  8014f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 10                	push   $0x10
  801501:	e8 ca fd ff ff       	call   8012d0 <syscall>
  801506:	83 c4 18             	add    $0x18,%esp
}
  801509:	90                   	nop
  80150a:	c9                   	leave  
  80150b:	c3                   	ret    

0080150c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80150c:	55                   	push   %ebp
  80150d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 14                	push   $0x14
  80151b:	e8 b0 fd ff ff       	call   8012d0 <syscall>
  801520:	83 c4 18             	add    $0x18,%esp
}
  801523:	90                   	nop
  801524:	c9                   	leave  
  801525:	c3                   	ret    

00801526 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801526:	55                   	push   %ebp
  801527:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	6a 15                	push   $0x15
  801535:	e8 96 fd ff ff       	call   8012d0 <syscall>
  80153a:	83 c4 18             	add    $0x18,%esp
}
  80153d:	90                   	nop
  80153e:	c9                   	leave  
  80153f:	c3                   	ret    

00801540 <sys_cputc>:


void
sys_cputc(const char c)
{
  801540:	55                   	push   %ebp
  801541:	89 e5                	mov    %esp,%ebp
  801543:	83 ec 04             	sub    $0x4,%esp
  801546:	8b 45 08             	mov    0x8(%ebp),%eax
  801549:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80154c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	50                   	push   %eax
  801559:	6a 16                	push   $0x16
  80155b:	e8 70 fd ff ff       	call   8012d0 <syscall>
  801560:	83 c4 18             	add    $0x18,%esp
}
  801563:	90                   	nop
  801564:	c9                   	leave  
  801565:	c3                   	ret    

00801566 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801566:	55                   	push   %ebp
  801567:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	6a 17                	push   $0x17
  801575:	e8 56 fd ff ff       	call   8012d0 <syscall>
  80157a:	83 c4 18             	add    $0x18,%esp
}
  80157d:	90                   	nop
  80157e:	c9                   	leave  
  80157f:	c3                   	ret    

00801580 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801583:	8b 45 08             	mov    0x8(%ebp),%eax
  801586:	6a 00                	push   $0x0
  801588:	6a 00                	push   $0x0
  80158a:	6a 00                	push   $0x0
  80158c:	ff 75 0c             	pushl  0xc(%ebp)
  80158f:	50                   	push   %eax
  801590:	6a 18                	push   $0x18
  801592:	e8 39 fd ff ff       	call   8012d0 <syscall>
  801597:	83 c4 18             	add    $0x18,%esp
}
  80159a:	c9                   	leave  
  80159b:	c3                   	ret    

0080159c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80159c:	55                   	push   %ebp
  80159d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80159f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	52                   	push   %edx
  8015ac:	50                   	push   %eax
  8015ad:	6a 1b                	push   $0x1b
  8015af:	e8 1c fd ff ff       	call   8012d0 <syscall>
  8015b4:	83 c4 18             	add    $0x18,%esp
}
  8015b7:	c9                   	leave  
  8015b8:	c3                   	ret    

008015b9 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	52                   	push   %edx
  8015c9:	50                   	push   %eax
  8015ca:	6a 19                	push   $0x19
  8015cc:	e8 ff fc ff ff       	call   8012d0 <syscall>
  8015d1:	83 c4 18             	add    $0x18,%esp
}
  8015d4:	90                   	nop
  8015d5:	c9                   	leave  
  8015d6:	c3                   	ret    

008015d7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015d7:	55                   	push   %ebp
  8015d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	52                   	push   %edx
  8015e7:	50                   	push   %eax
  8015e8:	6a 1a                	push   $0x1a
  8015ea:	e8 e1 fc ff ff       	call   8012d0 <syscall>
  8015ef:	83 c4 18             	add    $0x18,%esp
}
  8015f2:	90                   	nop
  8015f3:	c9                   	leave  
  8015f4:	c3                   	ret    

008015f5 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015f5:	55                   	push   %ebp
  8015f6:	89 e5                	mov    %esp,%ebp
  8015f8:	83 ec 04             	sub    $0x4,%esp
  8015fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8015fe:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801601:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801604:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801608:	8b 45 08             	mov    0x8(%ebp),%eax
  80160b:	6a 00                	push   $0x0
  80160d:	51                   	push   %ecx
  80160e:	52                   	push   %edx
  80160f:	ff 75 0c             	pushl  0xc(%ebp)
  801612:	50                   	push   %eax
  801613:	6a 1c                	push   $0x1c
  801615:	e8 b6 fc ff ff       	call   8012d0 <syscall>
  80161a:	83 c4 18             	add    $0x18,%esp
}
  80161d:	c9                   	leave  
  80161e:	c3                   	ret    

0080161f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80161f:	55                   	push   %ebp
  801620:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801622:	8b 55 0c             	mov    0xc(%ebp),%edx
  801625:	8b 45 08             	mov    0x8(%ebp),%eax
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	52                   	push   %edx
  80162f:	50                   	push   %eax
  801630:	6a 1d                	push   $0x1d
  801632:	e8 99 fc ff ff       	call   8012d0 <syscall>
  801637:	83 c4 18             	add    $0x18,%esp
}
  80163a:	c9                   	leave  
  80163b:	c3                   	ret    

0080163c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80163c:	55                   	push   %ebp
  80163d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80163f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801642:	8b 55 0c             	mov    0xc(%ebp),%edx
  801645:	8b 45 08             	mov    0x8(%ebp),%eax
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	51                   	push   %ecx
  80164d:	52                   	push   %edx
  80164e:	50                   	push   %eax
  80164f:	6a 1e                	push   $0x1e
  801651:	e8 7a fc ff ff       	call   8012d0 <syscall>
  801656:	83 c4 18             	add    $0x18,%esp
}
  801659:	c9                   	leave  
  80165a:	c3                   	ret    

0080165b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80165b:	55                   	push   %ebp
  80165c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80165e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801661:	8b 45 08             	mov    0x8(%ebp),%eax
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	52                   	push   %edx
  80166b:	50                   	push   %eax
  80166c:	6a 1f                	push   $0x1f
  80166e:	e8 5d fc ff ff       	call   8012d0 <syscall>
  801673:	83 c4 18             	add    $0x18,%esp
}
  801676:	c9                   	leave  
  801677:	c3                   	ret    

00801678 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801678:	55                   	push   %ebp
  801679:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 20                	push   $0x20
  801687:	e8 44 fc ff ff       	call   8012d0 <syscall>
  80168c:	83 c4 18             	add    $0x18,%esp
}
  80168f:	c9                   	leave  
  801690:	c3                   	ret    

00801691 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801691:	55                   	push   %ebp
  801692:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801694:	8b 45 08             	mov    0x8(%ebp),%eax
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	ff 75 10             	pushl  0x10(%ebp)
  80169e:	ff 75 0c             	pushl  0xc(%ebp)
  8016a1:	50                   	push   %eax
  8016a2:	6a 21                	push   $0x21
  8016a4:	e8 27 fc ff ff       	call   8012d0 <syscall>
  8016a9:	83 c4 18             	add    $0x18,%esp
}
  8016ac:	c9                   	leave  
  8016ad:	c3                   	ret    

008016ae <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8016ae:	55                   	push   %ebp
  8016af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8016b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 00                	push   $0x0
  8016bc:	50                   	push   %eax
  8016bd:	6a 22                	push   $0x22
  8016bf:	e8 0c fc ff ff       	call   8012d0 <syscall>
  8016c4:	83 c4 18             	add    $0x18,%esp
}
  8016c7:	90                   	nop
  8016c8:	c9                   	leave  
  8016c9:	c3                   	ret    

008016ca <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8016ca:	55                   	push   %ebp
  8016cb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8016cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	50                   	push   %eax
  8016d9:	6a 23                	push   $0x23
  8016db:	e8 f0 fb ff ff       	call   8012d0 <syscall>
  8016e0:	83 c4 18             	add    $0x18,%esp
}
  8016e3:	90                   	nop
  8016e4:	c9                   	leave  
  8016e5:	c3                   	ret    

008016e6 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016e6:	55                   	push   %ebp
  8016e7:	89 e5                	mov    %esp,%ebp
  8016e9:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016ec:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016ef:	8d 50 04             	lea    0x4(%eax),%edx
  8016f2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	52                   	push   %edx
  8016fc:	50                   	push   %eax
  8016fd:	6a 24                	push   $0x24
  8016ff:	e8 cc fb ff ff       	call   8012d0 <syscall>
  801704:	83 c4 18             	add    $0x18,%esp
	return result;
  801707:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80170a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80170d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801710:	89 01                	mov    %eax,(%ecx)
  801712:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801715:	8b 45 08             	mov    0x8(%ebp),%eax
  801718:	c9                   	leave  
  801719:	c2 04 00             	ret    $0x4

0080171c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80171c:	55                   	push   %ebp
  80171d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	ff 75 10             	pushl  0x10(%ebp)
  801726:	ff 75 0c             	pushl  0xc(%ebp)
  801729:	ff 75 08             	pushl  0x8(%ebp)
  80172c:	6a 13                	push   $0x13
  80172e:	e8 9d fb ff ff       	call   8012d0 <syscall>
  801733:	83 c4 18             	add    $0x18,%esp
	return ;
  801736:	90                   	nop
}
  801737:	c9                   	leave  
  801738:	c3                   	ret    

00801739 <sys_rcr2>:
uint32 sys_rcr2()
{
  801739:	55                   	push   %ebp
  80173a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 25                	push   $0x25
  801748:	e8 83 fb ff ff       	call   8012d0 <syscall>
  80174d:	83 c4 18             	add    $0x18,%esp
}
  801750:	c9                   	leave  
  801751:	c3                   	ret    

00801752 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801752:	55                   	push   %ebp
  801753:	89 e5                	mov    %esp,%ebp
  801755:	83 ec 04             	sub    $0x4,%esp
  801758:	8b 45 08             	mov    0x8(%ebp),%eax
  80175b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80175e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	6a 00                	push   $0x0
  80176a:	50                   	push   %eax
  80176b:	6a 26                	push   $0x26
  80176d:	e8 5e fb ff ff       	call   8012d0 <syscall>
  801772:	83 c4 18             	add    $0x18,%esp
	return ;
  801775:	90                   	nop
}
  801776:	c9                   	leave  
  801777:	c3                   	ret    

00801778 <rsttst>:
void rsttst()
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 28                	push   $0x28
  801787:	e8 44 fb ff ff       	call   8012d0 <syscall>
  80178c:	83 c4 18             	add    $0x18,%esp
	return ;
  80178f:	90                   	nop
}
  801790:	c9                   	leave  
  801791:	c3                   	ret    

00801792 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801792:	55                   	push   %ebp
  801793:	89 e5                	mov    %esp,%ebp
  801795:	83 ec 04             	sub    $0x4,%esp
  801798:	8b 45 14             	mov    0x14(%ebp),%eax
  80179b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80179e:	8b 55 18             	mov    0x18(%ebp),%edx
  8017a1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017a5:	52                   	push   %edx
  8017a6:	50                   	push   %eax
  8017a7:	ff 75 10             	pushl  0x10(%ebp)
  8017aa:	ff 75 0c             	pushl  0xc(%ebp)
  8017ad:	ff 75 08             	pushl  0x8(%ebp)
  8017b0:	6a 27                	push   $0x27
  8017b2:	e8 19 fb ff ff       	call   8012d0 <syscall>
  8017b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ba:	90                   	nop
}
  8017bb:	c9                   	leave  
  8017bc:	c3                   	ret    

008017bd <chktst>:
void chktst(uint32 n)
{
  8017bd:	55                   	push   %ebp
  8017be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	ff 75 08             	pushl  0x8(%ebp)
  8017cb:	6a 29                	push   $0x29
  8017cd:	e8 fe fa ff ff       	call   8012d0 <syscall>
  8017d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8017d5:	90                   	nop
}
  8017d6:	c9                   	leave  
  8017d7:	c3                   	ret    

008017d8 <inctst>:

void inctst()
{
  8017d8:	55                   	push   %ebp
  8017d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 2a                	push   $0x2a
  8017e7:	e8 e4 fa ff ff       	call   8012d0 <syscall>
  8017ec:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ef:	90                   	nop
}
  8017f0:	c9                   	leave  
  8017f1:	c3                   	ret    

008017f2 <gettst>:
uint32 gettst()
{
  8017f2:	55                   	push   %ebp
  8017f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 2b                	push   $0x2b
  801801:	e8 ca fa ff ff       	call   8012d0 <syscall>
  801806:	83 c4 18             	add    $0x18,%esp
}
  801809:	c9                   	leave  
  80180a:	c3                   	ret    

0080180b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80180b:	55                   	push   %ebp
  80180c:	89 e5                	mov    %esp,%ebp
  80180e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 2c                	push   $0x2c
  80181d:	e8 ae fa ff ff       	call   8012d0 <syscall>
  801822:	83 c4 18             	add    $0x18,%esp
  801825:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801828:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80182c:	75 07                	jne    801835 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80182e:	b8 01 00 00 00       	mov    $0x1,%eax
  801833:	eb 05                	jmp    80183a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801835:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80183a:	c9                   	leave  
  80183b:	c3                   	ret    

0080183c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80183c:	55                   	push   %ebp
  80183d:	89 e5                	mov    %esp,%ebp
  80183f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 2c                	push   $0x2c
  80184e:	e8 7d fa ff ff       	call   8012d0 <syscall>
  801853:	83 c4 18             	add    $0x18,%esp
  801856:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801859:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80185d:	75 07                	jne    801866 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80185f:	b8 01 00 00 00       	mov    $0x1,%eax
  801864:	eb 05                	jmp    80186b <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801866:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80186b:	c9                   	leave  
  80186c:	c3                   	ret    

0080186d <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
  801870:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 2c                	push   $0x2c
  80187f:	e8 4c fa ff ff       	call   8012d0 <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
  801887:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80188a:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80188e:	75 07                	jne    801897 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801890:	b8 01 00 00 00       	mov    $0x1,%eax
  801895:	eb 05                	jmp    80189c <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801897:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80189c:	c9                   	leave  
  80189d:	c3                   	ret    

0080189e <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80189e:	55                   	push   %ebp
  80189f:	89 e5                	mov    %esp,%ebp
  8018a1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 2c                	push   $0x2c
  8018b0:	e8 1b fa ff ff       	call   8012d0 <syscall>
  8018b5:	83 c4 18             	add    $0x18,%esp
  8018b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8018bb:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8018bf:	75 07                	jne    8018c8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8018c1:	b8 01 00 00 00       	mov    $0x1,%eax
  8018c6:	eb 05                	jmp    8018cd <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8018c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018cd:	c9                   	leave  
  8018ce:	c3                   	ret    

008018cf <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8018cf:	55                   	push   %ebp
  8018d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	ff 75 08             	pushl  0x8(%ebp)
  8018dd:	6a 2d                	push   $0x2d
  8018df:	e8 ec f9 ff ff       	call   8012d0 <syscall>
  8018e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8018e7:	90                   	nop
}
  8018e8:	c9                   	leave  
  8018e9:	c3                   	ret    

008018ea <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018ea:	55                   	push   %ebp
  8018eb:	89 e5                	mov    %esp,%ebp
  8018ed:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018f0:	8b 55 08             	mov    0x8(%ebp),%edx
  8018f3:	89 d0                	mov    %edx,%eax
  8018f5:	c1 e0 02             	shl    $0x2,%eax
  8018f8:	01 d0                	add    %edx,%eax
  8018fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801901:	01 d0                	add    %edx,%eax
  801903:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80190a:	01 d0                	add    %edx,%eax
  80190c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801913:	01 d0                	add    %edx,%eax
  801915:	c1 e0 04             	shl    $0x4,%eax
  801918:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  80191b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801922:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801925:	83 ec 0c             	sub    $0xc,%esp
  801928:	50                   	push   %eax
  801929:	e8 b8 fd ff ff       	call   8016e6 <sys_get_virtual_time>
  80192e:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801931:	eb 41                	jmp    801974 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801933:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801936:	83 ec 0c             	sub    $0xc,%esp
  801939:	50                   	push   %eax
  80193a:	e8 a7 fd ff ff       	call   8016e6 <sys_get_virtual_time>
  80193f:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801942:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801945:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801948:	29 c2                	sub    %eax,%edx
  80194a:	89 d0                	mov    %edx,%eax
  80194c:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  80194f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801952:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801955:	89 d1                	mov    %edx,%ecx
  801957:	29 c1                	sub    %eax,%ecx
  801959:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80195c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80195f:	39 c2                	cmp    %eax,%edx
  801961:	0f 97 c0             	seta   %al
  801964:	0f b6 c0             	movzbl %al,%eax
  801967:	29 c1                	sub    %eax,%ecx
  801969:	89 c8                	mov    %ecx,%eax
  80196b:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  80196e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801971:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801974:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801977:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80197a:	72 b7                	jb     801933 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  80197c:	90                   	nop
  80197d:	c9                   	leave  
  80197e:	c3                   	ret    

0080197f <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
  801982:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801985:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80198c:	eb 03                	jmp    801991 <busy_wait+0x12>
  80198e:	ff 45 fc             	incl   -0x4(%ebp)
  801991:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801994:	3b 45 08             	cmp    0x8(%ebp),%eax
  801997:	72 f5                	jb     80198e <busy_wait+0xf>
	return i;
  801999:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80199c:	c9                   	leave  
  80199d:	c3                   	ret    
  80199e:	66 90                	xchg   %ax,%ax

008019a0 <__udivdi3>:
  8019a0:	55                   	push   %ebp
  8019a1:	57                   	push   %edi
  8019a2:	56                   	push   %esi
  8019a3:	53                   	push   %ebx
  8019a4:	83 ec 1c             	sub    $0x1c,%esp
  8019a7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019ab:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019af:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019b3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019b7:	89 ca                	mov    %ecx,%edx
  8019b9:	89 f8                	mov    %edi,%eax
  8019bb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019bf:	85 f6                	test   %esi,%esi
  8019c1:	75 2d                	jne    8019f0 <__udivdi3+0x50>
  8019c3:	39 cf                	cmp    %ecx,%edi
  8019c5:	77 65                	ja     801a2c <__udivdi3+0x8c>
  8019c7:	89 fd                	mov    %edi,%ebp
  8019c9:	85 ff                	test   %edi,%edi
  8019cb:	75 0b                	jne    8019d8 <__udivdi3+0x38>
  8019cd:	b8 01 00 00 00       	mov    $0x1,%eax
  8019d2:	31 d2                	xor    %edx,%edx
  8019d4:	f7 f7                	div    %edi
  8019d6:	89 c5                	mov    %eax,%ebp
  8019d8:	31 d2                	xor    %edx,%edx
  8019da:	89 c8                	mov    %ecx,%eax
  8019dc:	f7 f5                	div    %ebp
  8019de:	89 c1                	mov    %eax,%ecx
  8019e0:	89 d8                	mov    %ebx,%eax
  8019e2:	f7 f5                	div    %ebp
  8019e4:	89 cf                	mov    %ecx,%edi
  8019e6:	89 fa                	mov    %edi,%edx
  8019e8:	83 c4 1c             	add    $0x1c,%esp
  8019eb:	5b                   	pop    %ebx
  8019ec:	5e                   	pop    %esi
  8019ed:	5f                   	pop    %edi
  8019ee:	5d                   	pop    %ebp
  8019ef:	c3                   	ret    
  8019f0:	39 ce                	cmp    %ecx,%esi
  8019f2:	77 28                	ja     801a1c <__udivdi3+0x7c>
  8019f4:	0f bd fe             	bsr    %esi,%edi
  8019f7:	83 f7 1f             	xor    $0x1f,%edi
  8019fa:	75 40                	jne    801a3c <__udivdi3+0x9c>
  8019fc:	39 ce                	cmp    %ecx,%esi
  8019fe:	72 0a                	jb     801a0a <__udivdi3+0x6a>
  801a00:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a04:	0f 87 9e 00 00 00    	ja     801aa8 <__udivdi3+0x108>
  801a0a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a0f:	89 fa                	mov    %edi,%edx
  801a11:	83 c4 1c             	add    $0x1c,%esp
  801a14:	5b                   	pop    %ebx
  801a15:	5e                   	pop    %esi
  801a16:	5f                   	pop    %edi
  801a17:	5d                   	pop    %ebp
  801a18:	c3                   	ret    
  801a19:	8d 76 00             	lea    0x0(%esi),%esi
  801a1c:	31 ff                	xor    %edi,%edi
  801a1e:	31 c0                	xor    %eax,%eax
  801a20:	89 fa                	mov    %edi,%edx
  801a22:	83 c4 1c             	add    $0x1c,%esp
  801a25:	5b                   	pop    %ebx
  801a26:	5e                   	pop    %esi
  801a27:	5f                   	pop    %edi
  801a28:	5d                   	pop    %ebp
  801a29:	c3                   	ret    
  801a2a:	66 90                	xchg   %ax,%ax
  801a2c:	89 d8                	mov    %ebx,%eax
  801a2e:	f7 f7                	div    %edi
  801a30:	31 ff                	xor    %edi,%edi
  801a32:	89 fa                	mov    %edi,%edx
  801a34:	83 c4 1c             	add    $0x1c,%esp
  801a37:	5b                   	pop    %ebx
  801a38:	5e                   	pop    %esi
  801a39:	5f                   	pop    %edi
  801a3a:	5d                   	pop    %ebp
  801a3b:	c3                   	ret    
  801a3c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a41:	89 eb                	mov    %ebp,%ebx
  801a43:	29 fb                	sub    %edi,%ebx
  801a45:	89 f9                	mov    %edi,%ecx
  801a47:	d3 e6                	shl    %cl,%esi
  801a49:	89 c5                	mov    %eax,%ebp
  801a4b:	88 d9                	mov    %bl,%cl
  801a4d:	d3 ed                	shr    %cl,%ebp
  801a4f:	89 e9                	mov    %ebp,%ecx
  801a51:	09 f1                	or     %esi,%ecx
  801a53:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a57:	89 f9                	mov    %edi,%ecx
  801a59:	d3 e0                	shl    %cl,%eax
  801a5b:	89 c5                	mov    %eax,%ebp
  801a5d:	89 d6                	mov    %edx,%esi
  801a5f:	88 d9                	mov    %bl,%cl
  801a61:	d3 ee                	shr    %cl,%esi
  801a63:	89 f9                	mov    %edi,%ecx
  801a65:	d3 e2                	shl    %cl,%edx
  801a67:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a6b:	88 d9                	mov    %bl,%cl
  801a6d:	d3 e8                	shr    %cl,%eax
  801a6f:	09 c2                	or     %eax,%edx
  801a71:	89 d0                	mov    %edx,%eax
  801a73:	89 f2                	mov    %esi,%edx
  801a75:	f7 74 24 0c          	divl   0xc(%esp)
  801a79:	89 d6                	mov    %edx,%esi
  801a7b:	89 c3                	mov    %eax,%ebx
  801a7d:	f7 e5                	mul    %ebp
  801a7f:	39 d6                	cmp    %edx,%esi
  801a81:	72 19                	jb     801a9c <__udivdi3+0xfc>
  801a83:	74 0b                	je     801a90 <__udivdi3+0xf0>
  801a85:	89 d8                	mov    %ebx,%eax
  801a87:	31 ff                	xor    %edi,%edi
  801a89:	e9 58 ff ff ff       	jmp    8019e6 <__udivdi3+0x46>
  801a8e:	66 90                	xchg   %ax,%ax
  801a90:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a94:	89 f9                	mov    %edi,%ecx
  801a96:	d3 e2                	shl    %cl,%edx
  801a98:	39 c2                	cmp    %eax,%edx
  801a9a:	73 e9                	jae    801a85 <__udivdi3+0xe5>
  801a9c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a9f:	31 ff                	xor    %edi,%edi
  801aa1:	e9 40 ff ff ff       	jmp    8019e6 <__udivdi3+0x46>
  801aa6:	66 90                	xchg   %ax,%ax
  801aa8:	31 c0                	xor    %eax,%eax
  801aaa:	e9 37 ff ff ff       	jmp    8019e6 <__udivdi3+0x46>
  801aaf:	90                   	nop

00801ab0 <__umoddi3>:
  801ab0:	55                   	push   %ebp
  801ab1:	57                   	push   %edi
  801ab2:	56                   	push   %esi
  801ab3:	53                   	push   %ebx
  801ab4:	83 ec 1c             	sub    $0x1c,%esp
  801ab7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801abb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801abf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ac3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ac7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801acb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801acf:	89 f3                	mov    %esi,%ebx
  801ad1:	89 fa                	mov    %edi,%edx
  801ad3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ad7:	89 34 24             	mov    %esi,(%esp)
  801ada:	85 c0                	test   %eax,%eax
  801adc:	75 1a                	jne    801af8 <__umoddi3+0x48>
  801ade:	39 f7                	cmp    %esi,%edi
  801ae0:	0f 86 a2 00 00 00    	jbe    801b88 <__umoddi3+0xd8>
  801ae6:	89 c8                	mov    %ecx,%eax
  801ae8:	89 f2                	mov    %esi,%edx
  801aea:	f7 f7                	div    %edi
  801aec:	89 d0                	mov    %edx,%eax
  801aee:	31 d2                	xor    %edx,%edx
  801af0:	83 c4 1c             	add    $0x1c,%esp
  801af3:	5b                   	pop    %ebx
  801af4:	5e                   	pop    %esi
  801af5:	5f                   	pop    %edi
  801af6:	5d                   	pop    %ebp
  801af7:	c3                   	ret    
  801af8:	39 f0                	cmp    %esi,%eax
  801afa:	0f 87 ac 00 00 00    	ja     801bac <__umoddi3+0xfc>
  801b00:	0f bd e8             	bsr    %eax,%ebp
  801b03:	83 f5 1f             	xor    $0x1f,%ebp
  801b06:	0f 84 ac 00 00 00    	je     801bb8 <__umoddi3+0x108>
  801b0c:	bf 20 00 00 00       	mov    $0x20,%edi
  801b11:	29 ef                	sub    %ebp,%edi
  801b13:	89 fe                	mov    %edi,%esi
  801b15:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b19:	89 e9                	mov    %ebp,%ecx
  801b1b:	d3 e0                	shl    %cl,%eax
  801b1d:	89 d7                	mov    %edx,%edi
  801b1f:	89 f1                	mov    %esi,%ecx
  801b21:	d3 ef                	shr    %cl,%edi
  801b23:	09 c7                	or     %eax,%edi
  801b25:	89 e9                	mov    %ebp,%ecx
  801b27:	d3 e2                	shl    %cl,%edx
  801b29:	89 14 24             	mov    %edx,(%esp)
  801b2c:	89 d8                	mov    %ebx,%eax
  801b2e:	d3 e0                	shl    %cl,%eax
  801b30:	89 c2                	mov    %eax,%edx
  801b32:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b36:	d3 e0                	shl    %cl,%eax
  801b38:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b3c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b40:	89 f1                	mov    %esi,%ecx
  801b42:	d3 e8                	shr    %cl,%eax
  801b44:	09 d0                	or     %edx,%eax
  801b46:	d3 eb                	shr    %cl,%ebx
  801b48:	89 da                	mov    %ebx,%edx
  801b4a:	f7 f7                	div    %edi
  801b4c:	89 d3                	mov    %edx,%ebx
  801b4e:	f7 24 24             	mull   (%esp)
  801b51:	89 c6                	mov    %eax,%esi
  801b53:	89 d1                	mov    %edx,%ecx
  801b55:	39 d3                	cmp    %edx,%ebx
  801b57:	0f 82 87 00 00 00    	jb     801be4 <__umoddi3+0x134>
  801b5d:	0f 84 91 00 00 00    	je     801bf4 <__umoddi3+0x144>
  801b63:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b67:	29 f2                	sub    %esi,%edx
  801b69:	19 cb                	sbb    %ecx,%ebx
  801b6b:	89 d8                	mov    %ebx,%eax
  801b6d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b71:	d3 e0                	shl    %cl,%eax
  801b73:	89 e9                	mov    %ebp,%ecx
  801b75:	d3 ea                	shr    %cl,%edx
  801b77:	09 d0                	or     %edx,%eax
  801b79:	89 e9                	mov    %ebp,%ecx
  801b7b:	d3 eb                	shr    %cl,%ebx
  801b7d:	89 da                	mov    %ebx,%edx
  801b7f:	83 c4 1c             	add    $0x1c,%esp
  801b82:	5b                   	pop    %ebx
  801b83:	5e                   	pop    %esi
  801b84:	5f                   	pop    %edi
  801b85:	5d                   	pop    %ebp
  801b86:	c3                   	ret    
  801b87:	90                   	nop
  801b88:	89 fd                	mov    %edi,%ebp
  801b8a:	85 ff                	test   %edi,%edi
  801b8c:	75 0b                	jne    801b99 <__umoddi3+0xe9>
  801b8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b93:	31 d2                	xor    %edx,%edx
  801b95:	f7 f7                	div    %edi
  801b97:	89 c5                	mov    %eax,%ebp
  801b99:	89 f0                	mov    %esi,%eax
  801b9b:	31 d2                	xor    %edx,%edx
  801b9d:	f7 f5                	div    %ebp
  801b9f:	89 c8                	mov    %ecx,%eax
  801ba1:	f7 f5                	div    %ebp
  801ba3:	89 d0                	mov    %edx,%eax
  801ba5:	e9 44 ff ff ff       	jmp    801aee <__umoddi3+0x3e>
  801baa:	66 90                	xchg   %ax,%ax
  801bac:	89 c8                	mov    %ecx,%eax
  801bae:	89 f2                	mov    %esi,%edx
  801bb0:	83 c4 1c             	add    $0x1c,%esp
  801bb3:	5b                   	pop    %ebx
  801bb4:	5e                   	pop    %esi
  801bb5:	5f                   	pop    %edi
  801bb6:	5d                   	pop    %ebp
  801bb7:	c3                   	ret    
  801bb8:	3b 04 24             	cmp    (%esp),%eax
  801bbb:	72 06                	jb     801bc3 <__umoddi3+0x113>
  801bbd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801bc1:	77 0f                	ja     801bd2 <__umoddi3+0x122>
  801bc3:	89 f2                	mov    %esi,%edx
  801bc5:	29 f9                	sub    %edi,%ecx
  801bc7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801bcb:	89 14 24             	mov    %edx,(%esp)
  801bce:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bd2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bd6:	8b 14 24             	mov    (%esp),%edx
  801bd9:	83 c4 1c             	add    $0x1c,%esp
  801bdc:	5b                   	pop    %ebx
  801bdd:	5e                   	pop    %esi
  801bde:	5f                   	pop    %edi
  801bdf:	5d                   	pop    %ebp
  801be0:	c3                   	ret    
  801be1:	8d 76 00             	lea    0x0(%esi),%esi
  801be4:	2b 04 24             	sub    (%esp),%eax
  801be7:	19 fa                	sbb    %edi,%edx
  801be9:	89 d1                	mov    %edx,%ecx
  801beb:	89 c6                	mov    %eax,%esi
  801bed:	e9 71 ff ff ff       	jmp    801b63 <__umoddi3+0xb3>
  801bf2:	66 90                	xchg   %ax,%ax
  801bf4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801bf8:	72 ea                	jb     801be4 <__umoddi3+0x134>
  801bfa:	89 d9                	mov    %ebx,%ecx
  801bfc:	e9 62 ff ff ff       	jmp    801b63 <__umoddi3+0xb3>
