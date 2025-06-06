
obj/user/tst_sharing_5_slaveB2:     file format elf32-i386


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
  800031:	e8 3e 01 00 00       	call   800174 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the free of shared variables
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80003e:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800042:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800049:	eb 29                	jmp    800074 <_main+0x3c>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004b:	a1 20 30 80 00       	mov    0x803020,%eax
  800050:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800056:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800059:	89 d0                	mov    %edx,%eax
  80005b:	01 c0                	add    %eax,%eax
  80005d:	01 d0                	add    %edx,%eax
  80005f:	c1 e0 02             	shl    $0x2,%eax
  800062:	01 c8                	add    %ecx,%eax
  800064:	8a 40 04             	mov    0x4(%eax),%al
  800067:	84 c0                	test   %al,%al
  800069:	74 06                	je     800071 <_main+0x39>
			{
				fullWS = 0;
  80006b:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80006f:	eb 12                	jmp    800083 <_main+0x4b>
_main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800071:	ff 45 f0             	incl   -0x10(%ebp)
  800074:	a1 20 30 80 00       	mov    0x803020,%eax
  800079:	8b 50 74             	mov    0x74(%eax),%edx
  80007c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007f:	39 c2                	cmp    %eax,%edx
  800081:	77 c8                	ja     80004b <_main+0x13>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800083:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800087:	74 14                	je     80009d <_main+0x65>
  800089:	83 ec 04             	sub    $0x4,%esp
  80008c:	68 80 1e 80 00       	push   $0x801e80
  800091:	6a 12                	push   $0x12
  800093:	68 9c 1e 80 00       	push   $0x801e9c
  800098:	e8 d9 01 00 00       	call   800276 <_panic>
	}
	uint32 *z;
	z = sget(sys_getparentenvid(),"z");
  80009d:	e8 5c 15 00 00       	call   8015fe <sys_getparentenvid>
  8000a2:	83 ec 08             	sub    $0x8,%esp
  8000a5:	68 b9 1e 80 00       	push   $0x801eb9
  8000aa:	50                   	push   %eax
  8000ab:	e8 24 12 00 00       	call   8012d4 <sget>
  8000b0:	83 c4 10             	add    $0x10,%esp
  8000b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
	cprintf("Slave B2 env used z (getSharedObject)\n");
  8000b6:	83 ec 0c             	sub    $0xc,%esp
  8000b9:	68 bc 1e 80 00       	push   $0x801ebc
  8000be:	e8 67 04 00 00       	call   80052a <cprintf>
  8000c3:	83 c4 10             	add    $0x10,%esp

	cprintf("Slave B2 please be patient ...\n");
  8000c6:	83 ec 0c             	sub    $0xc,%esp
  8000c9:	68 e4 1e 80 00       	push   $0x801ee4
  8000ce:	e8 57 04 00 00       	call   80052a <cprintf>
  8000d3:	83 c4 10             	add    $0x10,%esp

	env_sleep(9000);
  8000d6:	83 ec 0c             	sub    $0xc,%esp
  8000d9:	68 28 23 00 00       	push   $0x2328
  8000de:	e8 7b 1a 00 00       	call   801b5e <env_sleep>
  8000e3:	83 c4 10             	add    $0x10,%esp
	int freeFrames = sys_calculate_free_frames() ;
  8000e6:	e8 c5 15 00 00       	call   8016b0 <sys_calculate_free_frames>
  8000eb:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sfree(z);
  8000ee:	83 ec 0c             	sub    $0xc,%esp
  8000f1:	ff 75 ec             	pushl  -0x14(%ebp)
  8000f4:	e8 11 14 00 00       	call   80150a <sfree>
  8000f9:	83 c4 10             	add    $0x10,%esp
	cprintf("Slave B2 env removed z\n");
  8000fc:	83 ec 0c             	sub    $0xc,%esp
  8000ff:	68 04 1f 80 00       	push   $0x801f04
  800104:	e8 21 04 00 00       	call   80052a <cprintf>
  800109:	83 c4 10             	add    $0x10,%esp

	if ((sys_calculate_free_frames() - freeFrames) !=  4) panic("wrong free: frames removed not equal 4 !, correct frames to be removed are 4:\nfrom the env: 1 table + 1 frame for z\nframes_storage of z: should be cleared now\n");
  80010c:	e8 9f 15 00 00       	call   8016b0 <sys_calculate_free_frames>
  800111:	89 c2                	mov    %eax,%edx
  800113:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800116:	29 c2                	sub    %eax,%edx
  800118:	89 d0                	mov    %edx,%eax
  80011a:	83 f8 04             	cmp    $0x4,%eax
  80011d:	74 14                	je     800133 <_main+0xfb>
  80011f:	83 ec 04             	sub    $0x4,%esp
  800122:	68 1c 1f 80 00       	push   $0x801f1c
  800127:	6a 20                	push   $0x20
  800129:	68 9c 1e 80 00       	push   $0x801e9c
  80012e:	e8 43 01 00 00       	call   800276 <_panic>

	//to ensure that the other environments completed successfully
	if (gettst()!=2) panic("test failed");
  800133:	e8 2e 19 00 00       	call   801a66 <gettst>
  800138:	83 f8 02             	cmp    $0x2,%eax
  80013b:	74 14                	je     800151 <_main+0x119>
  80013d:	83 ec 04             	sub    $0x4,%esp
  800140:	68 bc 1f 80 00       	push   $0x801fbc
  800145:	6a 23                	push   $0x23
  800147:	68 9c 1e 80 00       	push   $0x801e9c
  80014c:	e8 25 01 00 00       	call   800276 <_panic>

	cprintf("Step B completed successfully!!\n\n\n");
  800151:	83 ec 0c             	sub    $0xc,%esp
  800154:	68 c8 1f 80 00       	push   $0x801fc8
  800159:	e8 cc 03 00 00       	call   80052a <cprintf>
  80015e:	83 c4 10             	add    $0x10,%esp
	cprintf("Congratulations!! Test of freeSharedObjects [5] completed successfully!!\n\n\n");
  800161:	83 ec 0c             	sub    $0xc,%esp
  800164:	68 ec 1f 80 00       	push   $0x801fec
  800169:	e8 bc 03 00 00       	call   80052a <cprintf>
  80016e:	83 c4 10             	add    $0x10,%esp

	return;
  800171:	90                   	nop
}
  800172:	c9                   	leave  
  800173:	c3                   	ret    

00800174 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800174:	55                   	push   %ebp
  800175:	89 e5                	mov    %esp,%ebp
  800177:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80017a:	e8 66 14 00 00       	call   8015e5 <sys_getenvindex>
  80017f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800182:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800185:	89 d0                	mov    %edx,%eax
  800187:	01 c0                	add    %eax,%eax
  800189:	01 d0                	add    %edx,%eax
  80018b:	c1 e0 02             	shl    $0x2,%eax
  80018e:	01 d0                	add    %edx,%eax
  800190:	c1 e0 06             	shl    $0x6,%eax
  800193:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800198:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80019d:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a2:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8001a8:	84 c0                	test   %al,%al
  8001aa:	74 0f                	je     8001bb <libmain+0x47>
		binaryname = myEnv->prog_name;
  8001ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b1:	05 f4 02 00 00       	add    $0x2f4,%eax
  8001b6:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001bb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001bf:	7e 0a                	jle    8001cb <libmain+0x57>
		binaryname = argv[0];
  8001c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c4:	8b 00                	mov    (%eax),%eax
  8001c6:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001cb:	83 ec 08             	sub    $0x8,%esp
  8001ce:	ff 75 0c             	pushl  0xc(%ebp)
  8001d1:	ff 75 08             	pushl  0x8(%ebp)
  8001d4:	e8 5f fe ff ff       	call   800038 <_main>
  8001d9:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001dc:	e8 9f 15 00 00       	call   801780 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001e1:	83 ec 0c             	sub    $0xc,%esp
  8001e4:	68 50 20 80 00       	push   $0x802050
  8001e9:	e8 3c 03 00 00       	call   80052a <cprintf>
  8001ee:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f6:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800201:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800207:	83 ec 04             	sub    $0x4,%esp
  80020a:	52                   	push   %edx
  80020b:	50                   	push   %eax
  80020c:	68 78 20 80 00       	push   $0x802078
  800211:	e8 14 03 00 00       	call   80052a <cprintf>
  800216:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800219:	a1 20 30 80 00       	mov    0x803020,%eax
  80021e:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800224:	83 ec 08             	sub    $0x8,%esp
  800227:	50                   	push   %eax
  800228:	68 9d 20 80 00       	push   $0x80209d
  80022d:	e8 f8 02 00 00       	call   80052a <cprintf>
  800232:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800235:	83 ec 0c             	sub    $0xc,%esp
  800238:	68 50 20 80 00       	push   $0x802050
  80023d:	e8 e8 02 00 00       	call   80052a <cprintf>
  800242:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800245:	e8 50 15 00 00       	call   80179a <sys_enable_interrupt>

	// exit gracefully
	exit();
  80024a:	e8 19 00 00 00       	call   800268 <exit>
}
  80024f:	90                   	nop
  800250:	c9                   	leave  
  800251:	c3                   	ret    

00800252 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800252:	55                   	push   %ebp
  800253:	89 e5                	mov    %esp,%ebp
  800255:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800258:	83 ec 0c             	sub    $0xc,%esp
  80025b:	6a 00                	push   $0x0
  80025d:	e8 4f 13 00 00       	call   8015b1 <sys_env_destroy>
  800262:	83 c4 10             	add    $0x10,%esp
}
  800265:	90                   	nop
  800266:	c9                   	leave  
  800267:	c3                   	ret    

00800268 <exit>:

void
exit(void)
{
  800268:	55                   	push   %ebp
  800269:	89 e5                	mov    %esp,%ebp
  80026b:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80026e:	e8 a4 13 00 00       	call   801617 <sys_env_exit>
}
  800273:	90                   	nop
  800274:	c9                   	leave  
  800275:	c3                   	ret    

00800276 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800276:	55                   	push   %ebp
  800277:	89 e5                	mov    %esp,%ebp
  800279:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80027c:	8d 45 10             	lea    0x10(%ebp),%eax
  80027f:	83 c0 04             	add    $0x4,%eax
  800282:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800285:	a1 30 30 80 00       	mov    0x803030,%eax
  80028a:	85 c0                	test   %eax,%eax
  80028c:	74 16                	je     8002a4 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80028e:	a1 30 30 80 00       	mov    0x803030,%eax
  800293:	83 ec 08             	sub    $0x8,%esp
  800296:	50                   	push   %eax
  800297:	68 b4 20 80 00       	push   $0x8020b4
  80029c:	e8 89 02 00 00       	call   80052a <cprintf>
  8002a1:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002a4:	a1 00 30 80 00       	mov    0x803000,%eax
  8002a9:	ff 75 0c             	pushl  0xc(%ebp)
  8002ac:	ff 75 08             	pushl  0x8(%ebp)
  8002af:	50                   	push   %eax
  8002b0:	68 b9 20 80 00       	push   $0x8020b9
  8002b5:	e8 70 02 00 00       	call   80052a <cprintf>
  8002ba:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8002c0:	83 ec 08             	sub    $0x8,%esp
  8002c3:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c6:	50                   	push   %eax
  8002c7:	e8 f3 01 00 00       	call   8004bf <vcprintf>
  8002cc:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002cf:	83 ec 08             	sub    $0x8,%esp
  8002d2:	6a 00                	push   $0x0
  8002d4:	68 d5 20 80 00       	push   $0x8020d5
  8002d9:	e8 e1 01 00 00       	call   8004bf <vcprintf>
  8002de:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002e1:	e8 82 ff ff ff       	call   800268 <exit>

	// should not return here
	while (1) ;
  8002e6:	eb fe                	jmp    8002e6 <_panic+0x70>

008002e8 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002e8:	55                   	push   %ebp
  8002e9:	89 e5                	mov    %esp,%ebp
  8002eb:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f3:	8b 50 74             	mov    0x74(%eax),%edx
  8002f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f9:	39 c2                	cmp    %eax,%edx
  8002fb:	74 14                	je     800311 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002fd:	83 ec 04             	sub    $0x4,%esp
  800300:	68 d8 20 80 00       	push   $0x8020d8
  800305:	6a 26                	push   $0x26
  800307:	68 24 21 80 00       	push   $0x802124
  80030c:	e8 65 ff ff ff       	call   800276 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800311:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800318:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80031f:	e9 c2 00 00 00       	jmp    8003e6 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800324:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800327:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032e:	8b 45 08             	mov    0x8(%ebp),%eax
  800331:	01 d0                	add    %edx,%eax
  800333:	8b 00                	mov    (%eax),%eax
  800335:	85 c0                	test   %eax,%eax
  800337:	75 08                	jne    800341 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800339:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80033c:	e9 a2 00 00 00       	jmp    8003e3 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800341:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800348:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80034f:	eb 69                	jmp    8003ba <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800351:	a1 20 30 80 00       	mov    0x803020,%eax
  800356:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80035c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80035f:	89 d0                	mov    %edx,%eax
  800361:	01 c0                	add    %eax,%eax
  800363:	01 d0                	add    %edx,%eax
  800365:	c1 e0 02             	shl    $0x2,%eax
  800368:	01 c8                	add    %ecx,%eax
  80036a:	8a 40 04             	mov    0x4(%eax),%al
  80036d:	84 c0                	test   %al,%al
  80036f:	75 46                	jne    8003b7 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800371:	a1 20 30 80 00       	mov    0x803020,%eax
  800376:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80037c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80037f:	89 d0                	mov    %edx,%eax
  800381:	01 c0                	add    %eax,%eax
  800383:	01 d0                	add    %edx,%eax
  800385:	c1 e0 02             	shl    $0x2,%eax
  800388:	01 c8                	add    %ecx,%eax
  80038a:	8b 00                	mov    (%eax),%eax
  80038c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80038f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800392:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800397:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800399:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80039c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a6:	01 c8                	add    %ecx,%eax
  8003a8:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003aa:	39 c2                	cmp    %eax,%edx
  8003ac:	75 09                	jne    8003b7 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8003ae:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003b5:	eb 12                	jmp    8003c9 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003b7:	ff 45 e8             	incl   -0x18(%ebp)
  8003ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8003bf:	8b 50 74             	mov    0x74(%eax),%edx
  8003c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003c5:	39 c2                	cmp    %eax,%edx
  8003c7:	77 88                	ja     800351 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003c9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003cd:	75 14                	jne    8003e3 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8003cf:	83 ec 04             	sub    $0x4,%esp
  8003d2:	68 30 21 80 00       	push   $0x802130
  8003d7:	6a 3a                	push   $0x3a
  8003d9:	68 24 21 80 00       	push   $0x802124
  8003de:	e8 93 fe ff ff       	call   800276 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003e3:	ff 45 f0             	incl   -0x10(%ebp)
  8003e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003e9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003ec:	0f 8c 32 ff ff ff    	jl     800324 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003f2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003f9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800400:	eb 26                	jmp    800428 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800402:	a1 20 30 80 00       	mov    0x803020,%eax
  800407:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80040d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800410:	89 d0                	mov    %edx,%eax
  800412:	01 c0                	add    %eax,%eax
  800414:	01 d0                	add    %edx,%eax
  800416:	c1 e0 02             	shl    $0x2,%eax
  800419:	01 c8                	add    %ecx,%eax
  80041b:	8a 40 04             	mov    0x4(%eax),%al
  80041e:	3c 01                	cmp    $0x1,%al
  800420:	75 03                	jne    800425 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800422:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800425:	ff 45 e0             	incl   -0x20(%ebp)
  800428:	a1 20 30 80 00       	mov    0x803020,%eax
  80042d:	8b 50 74             	mov    0x74(%eax),%edx
  800430:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800433:	39 c2                	cmp    %eax,%edx
  800435:	77 cb                	ja     800402 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800437:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80043a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80043d:	74 14                	je     800453 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80043f:	83 ec 04             	sub    $0x4,%esp
  800442:	68 84 21 80 00       	push   $0x802184
  800447:	6a 44                	push   $0x44
  800449:	68 24 21 80 00       	push   $0x802124
  80044e:	e8 23 fe ff ff       	call   800276 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800453:	90                   	nop
  800454:	c9                   	leave  
  800455:	c3                   	ret    

00800456 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800456:	55                   	push   %ebp
  800457:	89 e5                	mov    %esp,%ebp
  800459:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80045c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80045f:	8b 00                	mov    (%eax),%eax
  800461:	8d 48 01             	lea    0x1(%eax),%ecx
  800464:	8b 55 0c             	mov    0xc(%ebp),%edx
  800467:	89 0a                	mov    %ecx,(%edx)
  800469:	8b 55 08             	mov    0x8(%ebp),%edx
  80046c:	88 d1                	mov    %dl,%cl
  80046e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800471:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800475:	8b 45 0c             	mov    0xc(%ebp),%eax
  800478:	8b 00                	mov    (%eax),%eax
  80047a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80047f:	75 2c                	jne    8004ad <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800481:	a0 24 30 80 00       	mov    0x803024,%al
  800486:	0f b6 c0             	movzbl %al,%eax
  800489:	8b 55 0c             	mov    0xc(%ebp),%edx
  80048c:	8b 12                	mov    (%edx),%edx
  80048e:	89 d1                	mov    %edx,%ecx
  800490:	8b 55 0c             	mov    0xc(%ebp),%edx
  800493:	83 c2 08             	add    $0x8,%edx
  800496:	83 ec 04             	sub    $0x4,%esp
  800499:	50                   	push   %eax
  80049a:	51                   	push   %ecx
  80049b:	52                   	push   %edx
  80049c:	e8 ce 10 00 00       	call   80156f <sys_cputs>
  8004a1:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b0:	8b 40 04             	mov    0x4(%eax),%eax
  8004b3:	8d 50 01             	lea    0x1(%eax),%edx
  8004b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b9:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004bc:	90                   	nop
  8004bd:	c9                   	leave  
  8004be:	c3                   	ret    

008004bf <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004bf:	55                   	push   %ebp
  8004c0:	89 e5                	mov    %esp,%ebp
  8004c2:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004c8:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004cf:	00 00 00 
	b.cnt = 0;
  8004d2:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004d9:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004dc:	ff 75 0c             	pushl  0xc(%ebp)
  8004df:	ff 75 08             	pushl  0x8(%ebp)
  8004e2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004e8:	50                   	push   %eax
  8004e9:	68 56 04 80 00       	push   $0x800456
  8004ee:	e8 11 02 00 00       	call   800704 <vprintfmt>
  8004f3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004f6:	a0 24 30 80 00       	mov    0x803024,%al
  8004fb:	0f b6 c0             	movzbl %al,%eax
  8004fe:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800504:	83 ec 04             	sub    $0x4,%esp
  800507:	50                   	push   %eax
  800508:	52                   	push   %edx
  800509:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80050f:	83 c0 08             	add    $0x8,%eax
  800512:	50                   	push   %eax
  800513:	e8 57 10 00 00       	call   80156f <sys_cputs>
  800518:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80051b:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800522:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800528:	c9                   	leave  
  800529:	c3                   	ret    

0080052a <cprintf>:

int cprintf(const char *fmt, ...) {
  80052a:	55                   	push   %ebp
  80052b:	89 e5                	mov    %esp,%ebp
  80052d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800530:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800537:	8d 45 0c             	lea    0xc(%ebp),%eax
  80053a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80053d:	8b 45 08             	mov    0x8(%ebp),%eax
  800540:	83 ec 08             	sub    $0x8,%esp
  800543:	ff 75 f4             	pushl  -0xc(%ebp)
  800546:	50                   	push   %eax
  800547:	e8 73 ff ff ff       	call   8004bf <vcprintf>
  80054c:	83 c4 10             	add    $0x10,%esp
  80054f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800552:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800555:	c9                   	leave  
  800556:	c3                   	ret    

00800557 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800557:	55                   	push   %ebp
  800558:	89 e5                	mov    %esp,%ebp
  80055a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80055d:	e8 1e 12 00 00       	call   801780 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800562:	8d 45 0c             	lea    0xc(%ebp),%eax
  800565:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800568:	8b 45 08             	mov    0x8(%ebp),%eax
  80056b:	83 ec 08             	sub    $0x8,%esp
  80056e:	ff 75 f4             	pushl  -0xc(%ebp)
  800571:	50                   	push   %eax
  800572:	e8 48 ff ff ff       	call   8004bf <vcprintf>
  800577:	83 c4 10             	add    $0x10,%esp
  80057a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80057d:	e8 18 12 00 00       	call   80179a <sys_enable_interrupt>
	return cnt;
  800582:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800585:	c9                   	leave  
  800586:	c3                   	ret    

00800587 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800587:	55                   	push   %ebp
  800588:	89 e5                	mov    %esp,%ebp
  80058a:	53                   	push   %ebx
  80058b:	83 ec 14             	sub    $0x14,%esp
  80058e:	8b 45 10             	mov    0x10(%ebp),%eax
  800591:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800594:	8b 45 14             	mov    0x14(%ebp),%eax
  800597:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80059a:	8b 45 18             	mov    0x18(%ebp),%eax
  80059d:	ba 00 00 00 00       	mov    $0x0,%edx
  8005a2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005a5:	77 55                	ja     8005fc <printnum+0x75>
  8005a7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005aa:	72 05                	jb     8005b1 <printnum+0x2a>
  8005ac:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005af:	77 4b                	ja     8005fc <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005b1:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005b4:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005b7:	8b 45 18             	mov    0x18(%ebp),%eax
  8005ba:	ba 00 00 00 00       	mov    $0x0,%edx
  8005bf:	52                   	push   %edx
  8005c0:	50                   	push   %eax
  8005c1:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c4:	ff 75 f0             	pushl  -0x10(%ebp)
  8005c7:	e8 48 16 00 00       	call   801c14 <__udivdi3>
  8005cc:	83 c4 10             	add    $0x10,%esp
  8005cf:	83 ec 04             	sub    $0x4,%esp
  8005d2:	ff 75 20             	pushl  0x20(%ebp)
  8005d5:	53                   	push   %ebx
  8005d6:	ff 75 18             	pushl  0x18(%ebp)
  8005d9:	52                   	push   %edx
  8005da:	50                   	push   %eax
  8005db:	ff 75 0c             	pushl  0xc(%ebp)
  8005de:	ff 75 08             	pushl  0x8(%ebp)
  8005e1:	e8 a1 ff ff ff       	call   800587 <printnum>
  8005e6:	83 c4 20             	add    $0x20,%esp
  8005e9:	eb 1a                	jmp    800605 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005eb:	83 ec 08             	sub    $0x8,%esp
  8005ee:	ff 75 0c             	pushl  0xc(%ebp)
  8005f1:	ff 75 20             	pushl  0x20(%ebp)
  8005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f7:	ff d0                	call   *%eax
  8005f9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005fc:	ff 4d 1c             	decl   0x1c(%ebp)
  8005ff:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800603:	7f e6                	jg     8005eb <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800605:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800608:	bb 00 00 00 00       	mov    $0x0,%ebx
  80060d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800610:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800613:	53                   	push   %ebx
  800614:	51                   	push   %ecx
  800615:	52                   	push   %edx
  800616:	50                   	push   %eax
  800617:	e8 08 17 00 00       	call   801d24 <__umoddi3>
  80061c:	83 c4 10             	add    $0x10,%esp
  80061f:	05 f4 23 80 00       	add    $0x8023f4,%eax
  800624:	8a 00                	mov    (%eax),%al
  800626:	0f be c0             	movsbl %al,%eax
  800629:	83 ec 08             	sub    $0x8,%esp
  80062c:	ff 75 0c             	pushl  0xc(%ebp)
  80062f:	50                   	push   %eax
  800630:	8b 45 08             	mov    0x8(%ebp),%eax
  800633:	ff d0                	call   *%eax
  800635:	83 c4 10             	add    $0x10,%esp
}
  800638:	90                   	nop
  800639:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80063c:	c9                   	leave  
  80063d:	c3                   	ret    

0080063e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80063e:	55                   	push   %ebp
  80063f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800641:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800645:	7e 1c                	jle    800663 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800647:	8b 45 08             	mov    0x8(%ebp),%eax
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	8d 50 08             	lea    0x8(%eax),%edx
  80064f:	8b 45 08             	mov    0x8(%ebp),%eax
  800652:	89 10                	mov    %edx,(%eax)
  800654:	8b 45 08             	mov    0x8(%ebp),%eax
  800657:	8b 00                	mov    (%eax),%eax
  800659:	83 e8 08             	sub    $0x8,%eax
  80065c:	8b 50 04             	mov    0x4(%eax),%edx
  80065f:	8b 00                	mov    (%eax),%eax
  800661:	eb 40                	jmp    8006a3 <getuint+0x65>
	else if (lflag)
  800663:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800667:	74 1e                	je     800687 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800669:	8b 45 08             	mov    0x8(%ebp),%eax
  80066c:	8b 00                	mov    (%eax),%eax
  80066e:	8d 50 04             	lea    0x4(%eax),%edx
  800671:	8b 45 08             	mov    0x8(%ebp),%eax
  800674:	89 10                	mov    %edx,(%eax)
  800676:	8b 45 08             	mov    0x8(%ebp),%eax
  800679:	8b 00                	mov    (%eax),%eax
  80067b:	83 e8 04             	sub    $0x4,%eax
  80067e:	8b 00                	mov    (%eax),%eax
  800680:	ba 00 00 00 00       	mov    $0x0,%edx
  800685:	eb 1c                	jmp    8006a3 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800687:	8b 45 08             	mov    0x8(%ebp),%eax
  80068a:	8b 00                	mov    (%eax),%eax
  80068c:	8d 50 04             	lea    0x4(%eax),%edx
  80068f:	8b 45 08             	mov    0x8(%ebp),%eax
  800692:	89 10                	mov    %edx,(%eax)
  800694:	8b 45 08             	mov    0x8(%ebp),%eax
  800697:	8b 00                	mov    (%eax),%eax
  800699:	83 e8 04             	sub    $0x4,%eax
  80069c:	8b 00                	mov    (%eax),%eax
  80069e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006a3:	5d                   	pop    %ebp
  8006a4:	c3                   	ret    

008006a5 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006a5:	55                   	push   %ebp
  8006a6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006a8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006ac:	7e 1c                	jle    8006ca <getint+0x25>
		return va_arg(*ap, long long);
  8006ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b1:	8b 00                	mov    (%eax),%eax
  8006b3:	8d 50 08             	lea    0x8(%eax),%edx
  8006b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b9:	89 10                	mov    %edx,(%eax)
  8006bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006be:	8b 00                	mov    (%eax),%eax
  8006c0:	83 e8 08             	sub    $0x8,%eax
  8006c3:	8b 50 04             	mov    0x4(%eax),%edx
  8006c6:	8b 00                	mov    (%eax),%eax
  8006c8:	eb 38                	jmp    800702 <getint+0x5d>
	else if (lflag)
  8006ca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006ce:	74 1a                	je     8006ea <getint+0x45>
		return va_arg(*ap, long);
  8006d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d3:	8b 00                	mov    (%eax),%eax
  8006d5:	8d 50 04             	lea    0x4(%eax),%edx
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	89 10                	mov    %edx,(%eax)
  8006dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e0:	8b 00                	mov    (%eax),%eax
  8006e2:	83 e8 04             	sub    $0x4,%eax
  8006e5:	8b 00                	mov    (%eax),%eax
  8006e7:	99                   	cltd   
  8006e8:	eb 18                	jmp    800702 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ed:	8b 00                	mov    (%eax),%eax
  8006ef:	8d 50 04             	lea    0x4(%eax),%edx
  8006f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f5:	89 10                	mov    %edx,(%eax)
  8006f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fa:	8b 00                	mov    (%eax),%eax
  8006fc:	83 e8 04             	sub    $0x4,%eax
  8006ff:	8b 00                	mov    (%eax),%eax
  800701:	99                   	cltd   
}
  800702:	5d                   	pop    %ebp
  800703:	c3                   	ret    

00800704 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800704:	55                   	push   %ebp
  800705:	89 e5                	mov    %esp,%ebp
  800707:	56                   	push   %esi
  800708:	53                   	push   %ebx
  800709:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80070c:	eb 17                	jmp    800725 <vprintfmt+0x21>
			if (ch == '\0')
  80070e:	85 db                	test   %ebx,%ebx
  800710:	0f 84 af 03 00 00    	je     800ac5 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800716:	83 ec 08             	sub    $0x8,%esp
  800719:	ff 75 0c             	pushl  0xc(%ebp)
  80071c:	53                   	push   %ebx
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	ff d0                	call   *%eax
  800722:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800725:	8b 45 10             	mov    0x10(%ebp),%eax
  800728:	8d 50 01             	lea    0x1(%eax),%edx
  80072b:	89 55 10             	mov    %edx,0x10(%ebp)
  80072e:	8a 00                	mov    (%eax),%al
  800730:	0f b6 d8             	movzbl %al,%ebx
  800733:	83 fb 25             	cmp    $0x25,%ebx
  800736:	75 d6                	jne    80070e <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800738:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80073c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800743:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80074a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800751:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800758:	8b 45 10             	mov    0x10(%ebp),%eax
  80075b:	8d 50 01             	lea    0x1(%eax),%edx
  80075e:	89 55 10             	mov    %edx,0x10(%ebp)
  800761:	8a 00                	mov    (%eax),%al
  800763:	0f b6 d8             	movzbl %al,%ebx
  800766:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800769:	83 f8 55             	cmp    $0x55,%eax
  80076c:	0f 87 2b 03 00 00    	ja     800a9d <vprintfmt+0x399>
  800772:	8b 04 85 18 24 80 00 	mov    0x802418(,%eax,4),%eax
  800779:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80077b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80077f:	eb d7                	jmp    800758 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800781:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800785:	eb d1                	jmp    800758 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800787:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80078e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800791:	89 d0                	mov    %edx,%eax
  800793:	c1 e0 02             	shl    $0x2,%eax
  800796:	01 d0                	add    %edx,%eax
  800798:	01 c0                	add    %eax,%eax
  80079a:	01 d8                	add    %ebx,%eax
  80079c:	83 e8 30             	sub    $0x30,%eax
  80079f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a5:	8a 00                	mov    (%eax),%al
  8007a7:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007aa:	83 fb 2f             	cmp    $0x2f,%ebx
  8007ad:	7e 3e                	jle    8007ed <vprintfmt+0xe9>
  8007af:	83 fb 39             	cmp    $0x39,%ebx
  8007b2:	7f 39                	jg     8007ed <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007b4:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007b7:	eb d5                	jmp    80078e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007bc:	83 c0 04             	add    $0x4,%eax
  8007bf:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c5:	83 e8 04             	sub    $0x4,%eax
  8007c8:	8b 00                	mov    (%eax),%eax
  8007ca:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007cd:	eb 1f                	jmp    8007ee <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007cf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d3:	79 83                	jns    800758 <vprintfmt+0x54>
				width = 0;
  8007d5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007dc:	e9 77 ff ff ff       	jmp    800758 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007e1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007e8:	e9 6b ff ff ff       	jmp    800758 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007ed:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007ee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007f2:	0f 89 60 ff ff ff    	jns    800758 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007fe:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800805:	e9 4e ff ff ff       	jmp    800758 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80080a:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80080d:	e9 46 ff ff ff       	jmp    800758 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800812:	8b 45 14             	mov    0x14(%ebp),%eax
  800815:	83 c0 04             	add    $0x4,%eax
  800818:	89 45 14             	mov    %eax,0x14(%ebp)
  80081b:	8b 45 14             	mov    0x14(%ebp),%eax
  80081e:	83 e8 04             	sub    $0x4,%eax
  800821:	8b 00                	mov    (%eax),%eax
  800823:	83 ec 08             	sub    $0x8,%esp
  800826:	ff 75 0c             	pushl  0xc(%ebp)
  800829:	50                   	push   %eax
  80082a:	8b 45 08             	mov    0x8(%ebp),%eax
  80082d:	ff d0                	call   *%eax
  80082f:	83 c4 10             	add    $0x10,%esp
			break;
  800832:	e9 89 02 00 00       	jmp    800ac0 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800837:	8b 45 14             	mov    0x14(%ebp),%eax
  80083a:	83 c0 04             	add    $0x4,%eax
  80083d:	89 45 14             	mov    %eax,0x14(%ebp)
  800840:	8b 45 14             	mov    0x14(%ebp),%eax
  800843:	83 e8 04             	sub    $0x4,%eax
  800846:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800848:	85 db                	test   %ebx,%ebx
  80084a:	79 02                	jns    80084e <vprintfmt+0x14a>
				err = -err;
  80084c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80084e:	83 fb 64             	cmp    $0x64,%ebx
  800851:	7f 0b                	jg     80085e <vprintfmt+0x15a>
  800853:	8b 34 9d 60 22 80 00 	mov    0x802260(,%ebx,4),%esi
  80085a:	85 f6                	test   %esi,%esi
  80085c:	75 19                	jne    800877 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80085e:	53                   	push   %ebx
  80085f:	68 05 24 80 00       	push   $0x802405
  800864:	ff 75 0c             	pushl  0xc(%ebp)
  800867:	ff 75 08             	pushl  0x8(%ebp)
  80086a:	e8 5e 02 00 00       	call   800acd <printfmt>
  80086f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800872:	e9 49 02 00 00       	jmp    800ac0 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800877:	56                   	push   %esi
  800878:	68 0e 24 80 00       	push   $0x80240e
  80087d:	ff 75 0c             	pushl  0xc(%ebp)
  800880:	ff 75 08             	pushl  0x8(%ebp)
  800883:	e8 45 02 00 00       	call   800acd <printfmt>
  800888:	83 c4 10             	add    $0x10,%esp
			break;
  80088b:	e9 30 02 00 00       	jmp    800ac0 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800890:	8b 45 14             	mov    0x14(%ebp),%eax
  800893:	83 c0 04             	add    $0x4,%eax
  800896:	89 45 14             	mov    %eax,0x14(%ebp)
  800899:	8b 45 14             	mov    0x14(%ebp),%eax
  80089c:	83 e8 04             	sub    $0x4,%eax
  80089f:	8b 30                	mov    (%eax),%esi
  8008a1:	85 f6                	test   %esi,%esi
  8008a3:	75 05                	jne    8008aa <vprintfmt+0x1a6>
				p = "(null)";
  8008a5:	be 11 24 80 00       	mov    $0x802411,%esi
			if (width > 0 && padc != '-')
  8008aa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ae:	7e 6d                	jle    80091d <vprintfmt+0x219>
  8008b0:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008b4:	74 67                	je     80091d <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008b9:	83 ec 08             	sub    $0x8,%esp
  8008bc:	50                   	push   %eax
  8008bd:	56                   	push   %esi
  8008be:	e8 0c 03 00 00       	call   800bcf <strnlen>
  8008c3:	83 c4 10             	add    $0x10,%esp
  8008c6:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008c9:	eb 16                	jmp    8008e1 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008cb:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008cf:	83 ec 08             	sub    $0x8,%esp
  8008d2:	ff 75 0c             	pushl  0xc(%ebp)
  8008d5:	50                   	push   %eax
  8008d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d9:	ff d0                	call   *%eax
  8008db:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008de:	ff 4d e4             	decl   -0x1c(%ebp)
  8008e1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008e5:	7f e4                	jg     8008cb <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008e7:	eb 34                	jmp    80091d <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008e9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008ed:	74 1c                	je     80090b <vprintfmt+0x207>
  8008ef:	83 fb 1f             	cmp    $0x1f,%ebx
  8008f2:	7e 05                	jle    8008f9 <vprintfmt+0x1f5>
  8008f4:	83 fb 7e             	cmp    $0x7e,%ebx
  8008f7:	7e 12                	jle    80090b <vprintfmt+0x207>
					putch('?', putdat);
  8008f9:	83 ec 08             	sub    $0x8,%esp
  8008fc:	ff 75 0c             	pushl  0xc(%ebp)
  8008ff:	6a 3f                	push   $0x3f
  800901:	8b 45 08             	mov    0x8(%ebp),%eax
  800904:	ff d0                	call   *%eax
  800906:	83 c4 10             	add    $0x10,%esp
  800909:	eb 0f                	jmp    80091a <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80090b:	83 ec 08             	sub    $0x8,%esp
  80090e:	ff 75 0c             	pushl  0xc(%ebp)
  800911:	53                   	push   %ebx
  800912:	8b 45 08             	mov    0x8(%ebp),%eax
  800915:	ff d0                	call   *%eax
  800917:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80091a:	ff 4d e4             	decl   -0x1c(%ebp)
  80091d:	89 f0                	mov    %esi,%eax
  80091f:	8d 70 01             	lea    0x1(%eax),%esi
  800922:	8a 00                	mov    (%eax),%al
  800924:	0f be d8             	movsbl %al,%ebx
  800927:	85 db                	test   %ebx,%ebx
  800929:	74 24                	je     80094f <vprintfmt+0x24b>
  80092b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80092f:	78 b8                	js     8008e9 <vprintfmt+0x1e5>
  800931:	ff 4d e0             	decl   -0x20(%ebp)
  800934:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800938:	79 af                	jns    8008e9 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80093a:	eb 13                	jmp    80094f <vprintfmt+0x24b>
				putch(' ', putdat);
  80093c:	83 ec 08             	sub    $0x8,%esp
  80093f:	ff 75 0c             	pushl  0xc(%ebp)
  800942:	6a 20                	push   $0x20
  800944:	8b 45 08             	mov    0x8(%ebp),%eax
  800947:	ff d0                	call   *%eax
  800949:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80094c:	ff 4d e4             	decl   -0x1c(%ebp)
  80094f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800953:	7f e7                	jg     80093c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800955:	e9 66 01 00 00       	jmp    800ac0 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80095a:	83 ec 08             	sub    $0x8,%esp
  80095d:	ff 75 e8             	pushl  -0x18(%ebp)
  800960:	8d 45 14             	lea    0x14(%ebp),%eax
  800963:	50                   	push   %eax
  800964:	e8 3c fd ff ff       	call   8006a5 <getint>
  800969:	83 c4 10             	add    $0x10,%esp
  80096c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80096f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800972:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800975:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800978:	85 d2                	test   %edx,%edx
  80097a:	79 23                	jns    80099f <vprintfmt+0x29b>
				putch('-', putdat);
  80097c:	83 ec 08             	sub    $0x8,%esp
  80097f:	ff 75 0c             	pushl  0xc(%ebp)
  800982:	6a 2d                	push   $0x2d
  800984:	8b 45 08             	mov    0x8(%ebp),%eax
  800987:	ff d0                	call   *%eax
  800989:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80098c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80098f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800992:	f7 d8                	neg    %eax
  800994:	83 d2 00             	adc    $0x0,%edx
  800997:	f7 da                	neg    %edx
  800999:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80099f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009a6:	e9 bc 00 00 00       	jmp    800a67 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009ab:	83 ec 08             	sub    $0x8,%esp
  8009ae:	ff 75 e8             	pushl  -0x18(%ebp)
  8009b1:	8d 45 14             	lea    0x14(%ebp),%eax
  8009b4:	50                   	push   %eax
  8009b5:	e8 84 fc ff ff       	call   80063e <getuint>
  8009ba:	83 c4 10             	add    $0x10,%esp
  8009bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009c3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009ca:	e9 98 00 00 00       	jmp    800a67 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009cf:	83 ec 08             	sub    $0x8,%esp
  8009d2:	ff 75 0c             	pushl  0xc(%ebp)
  8009d5:	6a 58                	push   $0x58
  8009d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009da:	ff d0                	call   *%eax
  8009dc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009df:	83 ec 08             	sub    $0x8,%esp
  8009e2:	ff 75 0c             	pushl  0xc(%ebp)
  8009e5:	6a 58                	push   $0x58
  8009e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ea:	ff d0                	call   *%eax
  8009ec:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009ef:	83 ec 08             	sub    $0x8,%esp
  8009f2:	ff 75 0c             	pushl  0xc(%ebp)
  8009f5:	6a 58                	push   $0x58
  8009f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fa:	ff d0                	call   *%eax
  8009fc:	83 c4 10             	add    $0x10,%esp
			break;
  8009ff:	e9 bc 00 00 00       	jmp    800ac0 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a04:	83 ec 08             	sub    $0x8,%esp
  800a07:	ff 75 0c             	pushl  0xc(%ebp)
  800a0a:	6a 30                	push   $0x30
  800a0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0f:	ff d0                	call   *%eax
  800a11:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a14:	83 ec 08             	sub    $0x8,%esp
  800a17:	ff 75 0c             	pushl  0xc(%ebp)
  800a1a:	6a 78                	push   $0x78
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	ff d0                	call   *%eax
  800a21:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a24:	8b 45 14             	mov    0x14(%ebp),%eax
  800a27:	83 c0 04             	add    $0x4,%eax
  800a2a:	89 45 14             	mov    %eax,0x14(%ebp)
  800a2d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a30:	83 e8 04             	sub    $0x4,%eax
  800a33:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a35:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a38:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a3f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a46:	eb 1f                	jmp    800a67 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a48:	83 ec 08             	sub    $0x8,%esp
  800a4b:	ff 75 e8             	pushl  -0x18(%ebp)
  800a4e:	8d 45 14             	lea    0x14(%ebp),%eax
  800a51:	50                   	push   %eax
  800a52:	e8 e7 fb ff ff       	call   80063e <getuint>
  800a57:	83 c4 10             	add    $0x10,%esp
  800a5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a5d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a60:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a67:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a6b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a6e:	83 ec 04             	sub    $0x4,%esp
  800a71:	52                   	push   %edx
  800a72:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a75:	50                   	push   %eax
  800a76:	ff 75 f4             	pushl  -0xc(%ebp)
  800a79:	ff 75 f0             	pushl  -0x10(%ebp)
  800a7c:	ff 75 0c             	pushl  0xc(%ebp)
  800a7f:	ff 75 08             	pushl  0x8(%ebp)
  800a82:	e8 00 fb ff ff       	call   800587 <printnum>
  800a87:	83 c4 20             	add    $0x20,%esp
			break;
  800a8a:	eb 34                	jmp    800ac0 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a8c:	83 ec 08             	sub    $0x8,%esp
  800a8f:	ff 75 0c             	pushl  0xc(%ebp)
  800a92:	53                   	push   %ebx
  800a93:	8b 45 08             	mov    0x8(%ebp),%eax
  800a96:	ff d0                	call   *%eax
  800a98:	83 c4 10             	add    $0x10,%esp
			break;
  800a9b:	eb 23                	jmp    800ac0 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a9d:	83 ec 08             	sub    $0x8,%esp
  800aa0:	ff 75 0c             	pushl  0xc(%ebp)
  800aa3:	6a 25                	push   $0x25
  800aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa8:	ff d0                	call   *%eax
  800aaa:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800aad:	ff 4d 10             	decl   0x10(%ebp)
  800ab0:	eb 03                	jmp    800ab5 <vprintfmt+0x3b1>
  800ab2:	ff 4d 10             	decl   0x10(%ebp)
  800ab5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab8:	48                   	dec    %eax
  800ab9:	8a 00                	mov    (%eax),%al
  800abb:	3c 25                	cmp    $0x25,%al
  800abd:	75 f3                	jne    800ab2 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800abf:	90                   	nop
		}
	}
  800ac0:	e9 47 fc ff ff       	jmp    80070c <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ac5:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ac6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ac9:	5b                   	pop    %ebx
  800aca:	5e                   	pop    %esi
  800acb:	5d                   	pop    %ebp
  800acc:	c3                   	ret    

00800acd <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800acd:	55                   	push   %ebp
  800ace:	89 e5                	mov    %esp,%ebp
  800ad0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ad3:	8d 45 10             	lea    0x10(%ebp),%eax
  800ad6:	83 c0 04             	add    $0x4,%eax
  800ad9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800adc:	8b 45 10             	mov    0x10(%ebp),%eax
  800adf:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae2:	50                   	push   %eax
  800ae3:	ff 75 0c             	pushl  0xc(%ebp)
  800ae6:	ff 75 08             	pushl  0x8(%ebp)
  800ae9:	e8 16 fc ff ff       	call   800704 <vprintfmt>
  800aee:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800af1:	90                   	nop
  800af2:	c9                   	leave  
  800af3:	c3                   	ret    

00800af4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800af4:	55                   	push   %ebp
  800af5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800af7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afa:	8b 40 08             	mov    0x8(%eax),%eax
  800afd:	8d 50 01             	lea    0x1(%eax),%edx
  800b00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b03:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b09:	8b 10                	mov    (%eax),%edx
  800b0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0e:	8b 40 04             	mov    0x4(%eax),%eax
  800b11:	39 c2                	cmp    %eax,%edx
  800b13:	73 12                	jae    800b27 <sprintputch+0x33>
		*b->buf++ = ch;
  800b15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b18:	8b 00                	mov    (%eax),%eax
  800b1a:	8d 48 01             	lea    0x1(%eax),%ecx
  800b1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b20:	89 0a                	mov    %ecx,(%edx)
  800b22:	8b 55 08             	mov    0x8(%ebp),%edx
  800b25:	88 10                	mov    %dl,(%eax)
}
  800b27:	90                   	nop
  800b28:	5d                   	pop    %ebp
  800b29:	c3                   	ret    

00800b2a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b2a:	55                   	push   %ebp
  800b2b:	89 e5                	mov    %esp,%ebp
  800b2d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b39:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3f:	01 d0                	add    %edx,%eax
  800b41:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b44:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b4b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b4f:	74 06                	je     800b57 <vsnprintf+0x2d>
  800b51:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b55:	7f 07                	jg     800b5e <vsnprintf+0x34>
		return -E_INVAL;
  800b57:	b8 03 00 00 00       	mov    $0x3,%eax
  800b5c:	eb 20                	jmp    800b7e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b5e:	ff 75 14             	pushl  0x14(%ebp)
  800b61:	ff 75 10             	pushl  0x10(%ebp)
  800b64:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b67:	50                   	push   %eax
  800b68:	68 f4 0a 80 00       	push   $0x800af4
  800b6d:	e8 92 fb ff ff       	call   800704 <vprintfmt>
  800b72:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b75:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b78:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b7e:	c9                   	leave  
  800b7f:	c3                   	ret    

00800b80 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b80:	55                   	push   %ebp
  800b81:	89 e5                	mov    %esp,%ebp
  800b83:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b86:	8d 45 10             	lea    0x10(%ebp),%eax
  800b89:	83 c0 04             	add    $0x4,%eax
  800b8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b92:	ff 75 f4             	pushl  -0xc(%ebp)
  800b95:	50                   	push   %eax
  800b96:	ff 75 0c             	pushl  0xc(%ebp)
  800b99:	ff 75 08             	pushl  0x8(%ebp)
  800b9c:	e8 89 ff ff ff       	call   800b2a <vsnprintf>
  800ba1:	83 c4 10             	add    $0x10,%esp
  800ba4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ba7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800baa:	c9                   	leave  
  800bab:	c3                   	ret    

00800bac <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bac:	55                   	push   %ebp
  800bad:	89 e5                	mov    %esp,%ebp
  800baf:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bb2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bb9:	eb 06                	jmp    800bc1 <strlen+0x15>
		n++;
  800bbb:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800bbe:	ff 45 08             	incl   0x8(%ebp)
  800bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc4:	8a 00                	mov    (%eax),%al
  800bc6:	84 c0                	test   %al,%al
  800bc8:	75 f1                	jne    800bbb <strlen+0xf>
		n++;
	return n;
  800bca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bcd:	c9                   	leave  
  800bce:	c3                   	ret    

00800bcf <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bcf:	55                   	push   %ebp
  800bd0:	89 e5                	mov    %esp,%ebp
  800bd2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bd5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bdc:	eb 09                	jmp    800be7 <strnlen+0x18>
		n++;
  800bde:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800be1:	ff 45 08             	incl   0x8(%ebp)
  800be4:	ff 4d 0c             	decl   0xc(%ebp)
  800be7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800beb:	74 09                	je     800bf6 <strnlen+0x27>
  800bed:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf0:	8a 00                	mov    (%eax),%al
  800bf2:	84 c0                	test   %al,%al
  800bf4:	75 e8                	jne    800bde <strnlen+0xf>
		n++;
	return n;
  800bf6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bf9:	c9                   	leave  
  800bfa:	c3                   	ret    

00800bfb <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bfb:	55                   	push   %ebp
  800bfc:	89 e5                	mov    %esp,%ebp
  800bfe:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c01:	8b 45 08             	mov    0x8(%ebp),%eax
  800c04:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c07:	90                   	nop
  800c08:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0b:	8d 50 01             	lea    0x1(%eax),%edx
  800c0e:	89 55 08             	mov    %edx,0x8(%ebp)
  800c11:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c14:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c17:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c1a:	8a 12                	mov    (%edx),%dl
  800c1c:	88 10                	mov    %dl,(%eax)
  800c1e:	8a 00                	mov    (%eax),%al
  800c20:	84 c0                	test   %al,%al
  800c22:	75 e4                	jne    800c08 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c24:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c27:	c9                   	leave  
  800c28:	c3                   	ret    

00800c29 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c29:	55                   	push   %ebp
  800c2a:	89 e5                	mov    %esp,%ebp
  800c2c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c32:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c35:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c3c:	eb 1f                	jmp    800c5d <strncpy+0x34>
		*dst++ = *src;
  800c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c41:	8d 50 01             	lea    0x1(%eax),%edx
  800c44:	89 55 08             	mov    %edx,0x8(%ebp)
  800c47:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c4a:	8a 12                	mov    (%edx),%dl
  800c4c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c51:	8a 00                	mov    (%eax),%al
  800c53:	84 c0                	test   %al,%al
  800c55:	74 03                	je     800c5a <strncpy+0x31>
			src++;
  800c57:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c5a:	ff 45 fc             	incl   -0x4(%ebp)
  800c5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c60:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c63:	72 d9                	jb     800c3e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c65:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c68:	c9                   	leave  
  800c69:	c3                   	ret    

00800c6a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c6a:	55                   	push   %ebp
  800c6b:	89 e5                	mov    %esp,%ebp
  800c6d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c70:	8b 45 08             	mov    0x8(%ebp),%eax
  800c73:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c76:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c7a:	74 30                	je     800cac <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c7c:	eb 16                	jmp    800c94 <strlcpy+0x2a>
			*dst++ = *src++;
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	8d 50 01             	lea    0x1(%eax),%edx
  800c84:	89 55 08             	mov    %edx,0x8(%ebp)
  800c87:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c8a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c8d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c90:	8a 12                	mov    (%edx),%dl
  800c92:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c94:	ff 4d 10             	decl   0x10(%ebp)
  800c97:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9b:	74 09                	je     800ca6 <strlcpy+0x3c>
  800c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	84 c0                	test   %al,%al
  800ca4:	75 d8                	jne    800c7e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cac:	8b 55 08             	mov    0x8(%ebp),%edx
  800caf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb2:	29 c2                	sub    %eax,%edx
  800cb4:	89 d0                	mov    %edx,%eax
}
  800cb6:	c9                   	leave  
  800cb7:	c3                   	ret    

00800cb8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cb8:	55                   	push   %ebp
  800cb9:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800cbb:	eb 06                	jmp    800cc3 <strcmp+0xb>
		p++, q++;
  800cbd:	ff 45 08             	incl   0x8(%ebp)
  800cc0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	8a 00                	mov    (%eax),%al
  800cc8:	84 c0                	test   %al,%al
  800cca:	74 0e                	je     800cda <strcmp+0x22>
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	8a 10                	mov    (%eax),%dl
  800cd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd4:	8a 00                	mov    (%eax),%al
  800cd6:	38 c2                	cmp    %al,%dl
  800cd8:	74 e3                	je     800cbd <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cda:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdd:	8a 00                	mov    (%eax),%al
  800cdf:	0f b6 d0             	movzbl %al,%edx
  800ce2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce5:	8a 00                	mov    (%eax),%al
  800ce7:	0f b6 c0             	movzbl %al,%eax
  800cea:	29 c2                	sub    %eax,%edx
  800cec:	89 d0                	mov    %edx,%eax
}
  800cee:	5d                   	pop    %ebp
  800cef:	c3                   	ret    

00800cf0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cf0:	55                   	push   %ebp
  800cf1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cf3:	eb 09                	jmp    800cfe <strncmp+0xe>
		n--, p++, q++;
  800cf5:	ff 4d 10             	decl   0x10(%ebp)
  800cf8:	ff 45 08             	incl   0x8(%ebp)
  800cfb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cfe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d02:	74 17                	je     800d1b <strncmp+0x2b>
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	8a 00                	mov    (%eax),%al
  800d09:	84 c0                	test   %al,%al
  800d0b:	74 0e                	je     800d1b <strncmp+0x2b>
  800d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d10:	8a 10                	mov    (%eax),%dl
  800d12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d15:	8a 00                	mov    (%eax),%al
  800d17:	38 c2                	cmp    %al,%dl
  800d19:	74 da                	je     800cf5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d1b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d1f:	75 07                	jne    800d28 <strncmp+0x38>
		return 0;
  800d21:	b8 00 00 00 00       	mov    $0x0,%eax
  800d26:	eb 14                	jmp    800d3c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	8a 00                	mov    (%eax),%al
  800d2d:	0f b6 d0             	movzbl %al,%edx
  800d30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d33:	8a 00                	mov    (%eax),%al
  800d35:	0f b6 c0             	movzbl %al,%eax
  800d38:	29 c2                	sub    %eax,%edx
  800d3a:	89 d0                	mov    %edx,%eax
}
  800d3c:	5d                   	pop    %ebp
  800d3d:	c3                   	ret    

00800d3e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d3e:	55                   	push   %ebp
  800d3f:	89 e5                	mov    %esp,%ebp
  800d41:	83 ec 04             	sub    $0x4,%esp
  800d44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d47:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d4a:	eb 12                	jmp    800d5e <strchr+0x20>
		if (*s == c)
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	8a 00                	mov    (%eax),%al
  800d51:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d54:	75 05                	jne    800d5b <strchr+0x1d>
			return (char *) s;
  800d56:	8b 45 08             	mov    0x8(%ebp),%eax
  800d59:	eb 11                	jmp    800d6c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d5b:	ff 45 08             	incl   0x8(%ebp)
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8a 00                	mov    (%eax),%al
  800d63:	84 c0                	test   %al,%al
  800d65:	75 e5                	jne    800d4c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d67:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d6c:	c9                   	leave  
  800d6d:	c3                   	ret    

00800d6e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d6e:	55                   	push   %ebp
  800d6f:	89 e5                	mov    %esp,%ebp
  800d71:	83 ec 04             	sub    $0x4,%esp
  800d74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d77:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d7a:	eb 0d                	jmp    800d89 <strfind+0x1b>
		if (*s == c)
  800d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7f:	8a 00                	mov    (%eax),%al
  800d81:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d84:	74 0e                	je     800d94 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d86:	ff 45 08             	incl   0x8(%ebp)
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8c:	8a 00                	mov    (%eax),%al
  800d8e:	84 c0                	test   %al,%al
  800d90:	75 ea                	jne    800d7c <strfind+0xe>
  800d92:	eb 01                	jmp    800d95 <strfind+0x27>
		if (*s == c)
			break;
  800d94:	90                   	nop
	return (char *) s;
  800d95:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d98:	c9                   	leave  
  800d99:	c3                   	ret    

00800d9a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d9a:	55                   	push   %ebp
  800d9b:	89 e5                	mov    %esp,%ebp
  800d9d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800da6:	8b 45 10             	mov    0x10(%ebp),%eax
  800da9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800dac:	eb 0e                	jmp    800dbc <memset+0x22>
		*p++ = c;
  800dae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db1:	8d 50 01             	lea    0x1(%eax),%edx
  800db4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800db7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dba:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800dbc:	ff 4d f8             	decl   -0x8(%ebp)
  800dbf:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800dc3:	79 e9                	jns    800dae <memset+0x14>
		*p++ = c;

	return v;
  800dc5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dc8:	c9                   	leave  
  800dc9:	c3                   	ret    

00800dca <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800dca:	55                   	push   %ebp
  800dcb:	89 e5                	mov    %esp,%ebp
  800dcd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ddc:	eb 16                	jmp    800df4 <memcpy+0x2a>
		*d++ = *s++;
  800dde:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de1:	8d 50 01             	lea    0x1(%eax),%edx
  800de4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800de7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dea:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ded:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800df0:	8a 12                	mov    (%edx),%dl
  800df2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800df4:	8b 45 10             	mov    0x10(%ebp),%eax
  800df7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dfa:	89 55 10             	mov    %edx,0x10(%ebp)
  800dfd:	85 c0                	test   %eax,%eax
  800dff:	75 dd                	jne    800dde <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e04:	c9                   	leave  
  800e05:	c3                   	ret    

00800e06 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e06:	55                   	push   %ebp
  800e07:	89 e5                	mov    %esp,%ebp
  800e09:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e18:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e1e:	73 50                	jae    800e70 <memmove+0x6a>
  800e20:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e23:	8b 45 10             	mov    0x10(%ebp),%eax
  800e26:	01 d0                	add    %edx,%eax
  800e28:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e2b:	76 43                	jbe    800e70 <memmove+0x6a>
		s += n;
  800e2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e30:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e33:	8b 45 10             	mov    0x10(%ebp),%eax
  800e36:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e39:	eb 10                	jmp    800e4b <memmove+0x45>
			*--d = *--s;
  800e3b:	ff 4d f8             	decl   -0x8(%ebp)
  800e3e:	ff 4d fc             	decl   -0x4(%ebp)
  800e41:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e44:	8a 10                	mov    (%eax),%dl
  800e46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e49:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e4b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e51:	89 55 10             	mov    %edx,0x10(%ebp)
  800e54:	85 c0                	test   %eax,%eax
  800e56:	75 e3                	jne    800e3b <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e58:	eb 23                	jmp    800e7d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e5d:	8d 50 01             	lea    0x1(%eax),%edx
  800e60:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e63:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e66:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e69:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e6c:	8a 12                	mov    (%edx),%dl
  800e6e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e70:	8b 45 10             	mov    0x10(%ebp),%eax
  800e73:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e76:	89 55 10             	mov    %edx,0x10(%ebp)
  800e79:	85 c0                	test   %eax,%eax
  800e7b:	75 dd                	jne    800e5a <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e80:	c9                   	leave  
  800e81:	c3                   	ret    

00800e82 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e82:	55                   	push   %ebp
  800e83:	89 e5                	mov    %esp,%ebp
  800e85:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e91:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e94:	eb 2a                	jmp    800ec0 <memcmp+0x3e>
		if (*s1 != *s2)
  800e96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e99:	8a 10                	mov    (%eax),%dl
  800e9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9e:	8a 00                	mov    (%eax),%al
  800ea0:	38 c2                	cmp    %al,%dl
  800ea2:	74 16                	je     800eba <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ea4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea7:	8a 00                	mov    (%eax),%al
  800ea9:	0f b6 d0             	movzbl %al,%edx
  800eac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eaf:	8a 00                	mov    (%eax),%al
  800eb1:	0f b6 c0             	movzbl %al,%eax
  800eb4:	29 c2                	sub    %eax,%edx
  800eb6:	89 d0                	mov    %edx,%eax
  800eb8:	eb 18                	jmp    800ed2 <memcmp+0x50>
		s1++, s2++;
  800eba:	ff 45 fc             	incl   -0x4(%ebp)
  800ebd:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ec0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec6:	89 55 10             	mov    %edx,0x10(%ebp)
  800ec9:	85 c0                	test   %eax,%eax
  800ecb:	75 c9                	jne    800e96 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ecd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ed2:	c9                   	leave  
  800ed3:	c3                   	ret    

00800ed4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ed4:	55                   	push   %ebp
  800ed5:	89 e5                	mov    %esp,%ebp
  800ed7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800eda:	8b 55 08             	mov    0x8(%ebp),%edx
  800edd:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee0:	01 d0                	add    %edx,%eax
  800ee2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ee5:	eb 15                	jmp    800efc <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eea:	8a 00                	mov    (%eax),%al
  800eec:	0f b6 d0             	movzbl %al,%edx
  800eef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef2:	0f b6 c0             	movzbl %al,%eax
  800ef5:	39 c2                	cmp    %eax,%edx
  800ef7:	74 0d                	je     800f06 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ef9:	ff 45 08             	incl   0x8(%ebp)
  800efc:	8b 45 08             	mov    0x8(%ebp),%eax
  800eff:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f02:	72 e3                	jb     800ee7 <memfind+0x13>
  800f04:	eb 01                	jmp    800f07 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f06:	90                   	nop
	return (void *) s;
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f0a:	c9                   	leave  
  800f0b:	c3                   	ret    

00800f0c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f0c:	55                   	push   %ebp
  800f0d:	89 e5                	mov    %esp,%ebp
  800f0f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f12:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f19:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f20:	eb 03                	jmp    800f25 <strtol+0x19>
		s++;
  800f22:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
  800f28:	8a 00                	mov    (%eax),%al
  800f2a:	3c 20                	cmp    $0x20,%al
  800f2c:	74 f4                	je     800f22 <strtol+0x16>
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	8a 00                	mov    (%eax),%al
  800f33:	3c 09                	cmp    $0x9,%al
  800f35:	74 eb                	je     800f22 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f37:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3a:	8a 00                	mov    (%eax),%al
  800f3c:	3c 2b                	cmp    $0x2b,%al
  800f3e:	75 05                	jne    800f45 <strtol+0x39>
		s++;
  800f40:	ff 45 08             	incl   0x8(%ebp)
  800f43:	eb 13                	jmp    800f58 <strtol+0x4c>
	else if (*s == '-')
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
  800f48:	8a 00                	mov    (%eax),%al
  800f4a:	3c 2d                	cmp    $0x2d,%al
  800f4c:	75 0a                	jne    800f58 <strtol+0x4c>
		s++, neg = 1;
  800f4e:	ff 45 08             	incl   0x8(%ebp)
  800f51:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f58:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5c:	74 06                	je     800f64 <strtol+0x58>
  800f5e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f62:	75 20                	jne    800f84 <strtol+0x78>
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	8a 00                	mov    (%eax),%al
  800f69:	3c 30                	cmp    $0x30,%al
  800f6b:	75 17                	jne    800f84 <strtol+0x78>
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	40                   	inc    %eax
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	3c 78                	cmp    $0x78,%al
  800f75:	75 0d                	jne    800f84 <strtol+0x78>
		s += 2, base = 16;
  800f77:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f7b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f82:	eb 28                	jmp    800fac <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f84:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f88:	75 15                	jne    800f9f <strtol+0x93>
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	3c 30                	cmp    $0x30,%al
  800f91:	75 0c                	jne    800f9f <strtol+0x93>
		s++, base = 8;
  800f93:	ff 45 08             	incl   0x8(%ebp)
  800f96:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f9d:	eb 0d                	jmp    800fac <strtol+0xa0>
	else if (base == 0)
  800f9f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa3:	75 07                	jne    800fac <strtol+0xa0>
		base = 10;
  800fa5:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800fac:	8b 45 08             	mov    0x8(%ebp),%eax
  800faf:	8a 00                	mov    (%eax),%al
  800fb1:	3c 2f                	cmp    $0x2f,%al
  800fb3:	7e 19                	jle    800fce <strtol+0xc2>
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb8:	8a 00                	mov    (%eax),%al
  800fba:	3c 39                	cmp    $0x39,%al
  800fbc:	7f 10                	jg     800fce <strtol+0xc2>
			dig = *s - '0';
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	8a 00                	mov    (%eax),%al
  800fc3:	0f be c0             	movsbl %al,%eax
  800fc6:	83 e8 30             	sub    $0x30,%eax
  800fc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fcc:	eb 42                	jmp    801010 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	8a 00                	mov    (%eax),%al
  800fd3:	3c 60                	cmp    $0x60,%al
  800fd5:	7e 19                	jle    800ff0 <strtol+0xe4>
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	3c 7a                	cmp    $0x7a,%al
  800fde:	7f 10                	jg     800ff0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	8a 00                	mov    (%eax),%al
  800fe5:	0f be c0             	movsbl %al,%eax
  800fe8:	83 e8 57             	sub    $0x57,%eax
  800feb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fee:	eb 20                	jmp    801010 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800ff0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff3:	8a 00                	mov    (%eax),%al
  800ff5:	3c 40                	cmp    $0x40,%al
  800ff7:	7e 39                	jle    801032 <strtol+0x126>
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffc:	8a 00                	mov    (%eax),%al
  800ffe:	3c 5a                	cmp    $0x5a,%al
  801000:	7f 30                	jg     801032 <strtol+0x126>
			dig = *s - 'A' + 10;
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	8a 00                	mov    (%eax),%al
  801007:	0f be c0             	movsbl %al,%eax
  80100a:	83 e8 37             	sub    $0x37,%eax
  80100d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801010:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801013:	3b 45 10             	cmp    0x10(%ebp),%eax
  801016:	7d 19                	jge    801031 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801018:	ff 45 08             	incl   0x8(%ebp)
  80101b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101e:	0f af 45 10          	imul   0x10(%ebp),%eax
  801022:	89 c2                	mov    %eax,%edx
  801024:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801027:	01 d0                	add    %edx,%eax
  801029:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80102c:	e9 7b ff ff ff       	jmp    800fac <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801031:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801032:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801036:	74 08                	je     801040 <strtol+0x134>
		*endptr = (char *) s;
  801038:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103b:	8b 55 08             	mov    0x8(%ebp),%edx
  80103e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801040:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801044:	74 07                	je     80104d <strtol+0x141>
  801046:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801049:	f7 d8                	neg    %eax
  80104b:	eb 03                	jmp    801050 <strtol+0x144>
  80104d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801050:	c9                   	leave  
  801051:	c3                   	ret    

00801052 <ltostr>:

void
ltostr(long value, char *str)
{
  801052:	55                   	push   %ebp
  801053:	89 e5                	mov    %esp,%ebp
  801055:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801058:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80105f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801066:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80106a:	79 13                	jns    80107f <ltostr+0x2d>
	{
		neg = 1;
  80106c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801073:	8b 45 0c             	mov    0xc(%ebp),%eax
  801076:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801079:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80107c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801087:	99                   	cltd   
  801088:	f7 f9                	idiv   %ecx
  80108a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80108d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801090:	8d 50 01             	lea    0x1(%eax),%edx
  801093:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801096:	89 c2                	mov    %eax,%edx
  801098:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109b:	01 d0                	add    %edx,%eax
  80109d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010a0:	83 c2 30             	add    $0x30,%edx
  8010a3:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010a8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010ad:	f7 e9                	imul   %ecx
  8010af:	c1 fa 02             	sar    $0x2,%edx
  8010b2:	89 c8                	mov    %ecx,%eax
  8010b4:	c1 f8 1f             	sar    $0x1f,%eax
  8010b7:	29 c2                	sub    %eax,%edx
  8010b9:	89 d0                	mov    %edx,%eax
  8010bb:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010be:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010c1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010c6:	f7 e9                	imul   %ecx
  8010c8:	c1 fa 02             	sar    $0x2,%edx
  8010cb:	89 c8                	mov    %ecx,%eax
  8010cd:	c1 f8 1f             	sar    $0x1f,%eax
  8010d0:	29 c2                	sub    %eax,%edx
  8010d2:	89 d0                	mov    %edx,%eax
  8010d4:	c1 e0 02             	shl    $0x2,%eax
  8010d7:	01 d0                	add    %edx,%eax
  8010d9:	01 c0                	add    %eax,%eax
  8010db:	29 c1                	sub    %eax,%ecx
  8010dd:	89 ca                	mov    %ecx,%edx
  8010df:	85 d2                	test   %edx,%edx
  8010e1:	75 9c                	jne    80107f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ed:	48                   	dec    %eax
  8010ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010f1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010f5:	74 3d                	je     801134 <ltostr+0xe2>
		start = 1 ;
  8010f7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010fe:	eb 34                	jmp    801134 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801100:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801103:	8b 45 0c             	mov    0xc(%ebp),%eax
  801106:	01 d0                	add    %edx,%eax
  801108:	8a 00                	mov    (%eax),%al
  80110a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80110d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801110:	8b 45 0c             	mov    0xc(%ebp),%eax
  801113:	01 c2                	add    %eax,%edx
  801115:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801118:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111b:	01 c8                	add    %ecx,%eax
  80111d:	8a 00                	mov    (%eax),%al
  80111f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801121:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801124:	8b 45 0c             	mov    0xc(%ebp),%eax
  801127:	01 c2                	add    %eax,%edx
  801129:	8a 45 eb             	mov    -0x15(%ebp),%al
  80112c:	88 02                	mov    %al,(%edx)
		start++ ;
  80112e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801131:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801134:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801137:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80113a:	7c c4                	jl     801100 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80113c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80113f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801142:	01 d0                	add    %edx,%eax
  801144:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801147:	90                   	nop
  801148:	c9                   	leave  
  801149:	c3                   	ret    

0080114a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80114a:	55                   	push   %ebp
  80114b:	89 e5                	mov    %esp,%ebp
  80114d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801150:	ff 75 08             	pushl  0x8(%ebp)
  801153:	e8 54 fa ff ff       	call   800bac <strlen>
  801158:	83 c4 04             	add    $0x4,%esp
  80115b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80115e:	ff 75 0c             	pushl  0xc(%ebp)
  801161:	e8 46 fa ff ff       	call   800bac <strlen>
  801166:	83 c4 04             	add    $0x4,%esp
  801169:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80116c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801173:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80117a:	eb 17                	jmp    801193 <strcconcat+0x49>
		final[s] = str1[s] ;
  80117c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80117f:	8b 45 10             	mov    0x10(%ebp),%eax
  801182:	01 c2                	add    %eax,%edx
  801184:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801187:	8b 45 08             	mov    0x8(%ebp),%eax
  80118a:	01 c8                	add    %ecx,%eax
  80118c:	8a 00                	mov    (%eax),%al
  80118e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801190:	ff 45 fc             	incl   -0x4(%ebp)
  801193:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801196:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801199:	7c e1                	jl     80117c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80119b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011a2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011a9:	eb 1f                	jmp    8011ca <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011ae:	8d 50 01             	lea    0x1(%eax),%edx
  8011b1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011b4:	89 c2                	mov    %eax,%edx
  8011b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b9:	01 c2                	add    %eax,%edx
  8011bb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c1:	01 c8                	add    %ecx,%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011c7:	ff 45 f8             	incl   -0x8(%ebp)
  8011ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011cd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011d0:	7c d9                	jl     8011ab <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011d2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d8:	01 d0                	add    %edx,%eax
  8011da:	c6 00 00             	movb   $0x0,(%eax)
}
  8011dd:	90                   	nop
  8011de:	c9                   	leave  
  8011df:	c3                   	ret    

008011e0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011e0:	55                   	push   %ebp
  8011e1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ef:	8b 00                	mov    (%eax),%eax
  8011f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fb:	01 d0                	add    %edx,%eax
  8011fd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801203:	eb 0c                	jmp    801211 <strsplit+0x31>
			*string++ = 0;
  801205:	8b 45 08             	mov    0x8(%ebp),%eax
  801208:	8d 50 01             	lea    0x1(%eax),%edx
  80120b:	89 55 08             	mov    %edx,0x8(%ebp)
  80120e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	8a 00                	mov    (%eax),%al
  801216:	84 c0                	test   %al,%al
  801218:	74 18                	je     801232 <strsplit+0x52>
  80121a:	8b 45 08             	mov    0x8(%ebp),%eax
  80121d:	8a 00                	mov    (%eax),%al
  80121f:	0f be c0             	movsbl %al,%eax
  801222:	50                   	push   %eax
  801223:	ff 75 0c             	pushl  0xc(%ebp)
  801226:	e8 13 fb ff ff       	call   800d3e <strchr>
  80122b:	83 c4 08             	add    $0x8,%esp
  80122e:	85 c0                	test   %eax,%eax
  801230:	75 d3                	jne    801205 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801232:	8b 45 08             	mov    0x8(%ebp),%eax
  801235:	8a 00                	mov    (%eax),%al
  801237:	84 c0                	test   %al,%al
  801239:	74 5a                	je     801295 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80123b:	8b 45 14             	mov    0x14(%ebp),%eax
  80123e:	8b 00                	mov    (%eax),%eax
  801240:	83 f8 0f             	cmp    $0xf,%eax
  801243:	75 07                	jne    80124c <strsplit+0x6c>
		{
			return 0;
  801245:	b8 00 00 00 00       	mov    $0x0,%eax
  80124a:	eb 66                	jmp    8012b2 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80124c:	8b 45 14             	mov    0x14(%ebp),%eax
  80124f:	8b 00                	mov    (%eax),%eax
  801251:	8d 48 01             	lea    0x1(%eax),%ecx
  801254:	8b 55 14             	mov    0x14(%ebp),%edx
  801257:	89 0a                	mov    %ecx,(%edx)
  801259:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801260:	8b 45 10             	mov    0x10(%ebp),%eax
  801263:	01 c2                	add    %eax,%edx
  801265:	8b 45 08             	mov    0x8(%ebp),%eax
  801268:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80126a:	eb 03                	jmp    80126f <strsplit+0x8f>
			string++;
  80126c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80126f:	8b 45 08             	mov    0x8(%ebp),%eax
  801272:	8a 00                	mov    (%eax),%al
  801274:	84 c0                	test   %al,%al
  801276:	74 8b                	je     801203 <strsplit+0x23>
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	8a 00                	mov    (%eax),%al
  80127d:	0f be c0             	movsbl %al,%eax
  801280:	50                   	push   %eax
  801281:	ff 75 0c             	pushl  0xc(%ebp)
  801284:	e8 b5 fa ff ff       	call   800d3e <strchr>
  801289:	83 c4 08             	add    $0x8,%esp
  80128c:	85 c0                	test   %eax,%eax
  80128e:	74 dc                	je     80126c <strsplit+0x8c>
			string++;
	}
  801290:	e9 6e ff ff ff       	jmp    801203 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801295:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801296:	8b 45 14             	mov    0x14(%ebp),%eax
  801299:	8b 00                	mov    (%eax),%eax
  80129b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a5:	01 d0                	add    %edx,%eax
  8012a7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012ad:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012b2:	c9                   	leave  
  8012b3:	c3                   	ret    

008012b4 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8012b4:	55                   	push   %ebp
  8012b5:	89 e5                	mov    %esp,%ebp
  8012b7:	83 ec 18             	sub    $0x18,%esp
  8012ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bd:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8012c0:	83 ec 04             	sub    $0x4,%esp
  8012c3:	68 70 25 80 00       	push   $0x802570
  8012c8:	6a 17                	push   $0x17
  8012ca:	68 8f 25 80 00       	push   $0x80258f
  8012cf:	e8 a2 ef ff ff       	call   800276 <_panic>

008012d4 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8012d4:	55                   	push   %ebp
  8012d5:	89 e5                	mov    %esp,%ebp
  8012d7:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8012da:	83 ec 04             	sub    $0x4,%esp
  8012dd:	68 9b 25 80 00       	push   $0x80259b
  8012e2:	6a 2f                	push   $0x2f
  8012e4:	68 8f 25 80 00       	push   $0x80258f
  8012e9:	e8 88 ef ff ff       	call   800276 <_panic>

008012ee <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8012ee:	55                   	push   %ebp
  8012ef:	89 e5                	mov    %esp,%ebp
  8012f1:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8012f4:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8012fb:	8b 55 08             	mov    0x8(%ebp),%edx
  8012fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801301:	01 d0                	add    %edx,%eax
  801303:	48                   	dec    %eax
  801304:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801307:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80130a:	ba 00 00 00 00       	mov    $0x0,%edx
  80130f:	f7 75 ec             	divl   -0x14(%ebp)
  801312:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801315:	29 d0                	sub    %edx,%eax
  801317:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  80131a:	8b 45 08             	mov    0x8(%ebp),%eax
  80131d:	c1 e8 0c             	shr    $0xc,%eax
  801320:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801323:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80132a:	e9 c8 00 00 00       	jmp    8013f7 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  80132f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801336:	eb 27                	jmp    80135f <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801338:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80133b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80133e:	01 c2                	add    %eax,%edx
  801340:	89 d0                	mov    %edx,%eax
  801342:	01 c0                	add    %eax,%eax
  801344:	01 d0                	add    %edx,%eax
  801346:	c1 e0 02             	shl    $0x2,%eax
  801349:	05 48 30 80 00       	add    $0x803048,%eax
  80134e:	8b 00                	mov    (%eax),%eax
  801350:	85 c0                	test   %eax,%eax
  801352:	74 08                	je     80135c <malloc+0x6e>
            	i += j;
  801354:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801357:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  80135a:	eb 0b                	jmp    801367 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  80135c:	ff 45 f0             	incl   -0x10(%ebp)
  80135f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801362:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801365:	72 d1                	jb     801338 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801367:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80136a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80136d:	0f 85 81 00 00 00    	jne    8013f4 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801373:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801376:	05 00 00 08 00       	add    $0x80000,%eax
  80137b:	c1 e0 0c             	shl    $0xc,%eax
  80137e:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801381:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801388:	eb 1f                	jmp    8013a9 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  80138a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80138d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801390:	01 c2                	add    %eax,%edx
  801392:	89 d0                	mov    %edx,%eax
  801394:	01 c0                	add    %eax,%eax
  801396:	01 d0                	add    %edx,%eax
  801398:	c1 e0 02             	shl    $0x2,%eax
  80139b:	05 48 30 80 00       	add    $0x803048,%eax
  8013a0:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8013a6:	ff 45 f0             	incl   -0x10(%ebp)
  8013a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013ac:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8013af:	72 d9                	jb     80138a <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  8013b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013b4:	89 d0                	mov    %edx,%eax
  8013b6:	01 c0                	add    %eax,%eax
  8013b8:	01 d0                	add    %edx,%eax
  8013ba:	c1 e0 02             	shl    $0x2,%eax
  8013bd:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  8013c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8013c6:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8013c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8013cb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8013ce:	89 c8                	mov    %ecx,%eax
  8013d0:	01 c0                	add    %eax,%eax
  8013d2:	01 c8                	add    %ecx,%eax
  8013d4:	c1 e0 02             	shl    $0x2,%eax
  8013d7:	05 44 30 80 00       	add    $0x803044,%eax
  8013dc:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8013de:	83 ec 08             	sub    $0x8,%esp
  8013e1:	ff 75 08             	pushl  0x8(%ebp)
  8013e4:	ff 75 e0             	pushl  -0x20(%ebp)
  8013e7:	e8 2b 03 00 00       	call   801717 <sys_allocateMem>
  8013ec:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8013ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8013f2:	eb 19                	jmp    80140d <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8013f4:	ff 45 f4             	incl   -0xc(%ebp)
  8013f7:	a1 04 30 80 00       	mov    0x803004,%eax
  8013fc:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8013ff:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801402:	0f 83 27 ff ff ff    	jae    80132f <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801408:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80140d:	c9                   	leave  
  80140e:	c3                   	ret    

0080140f <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80140f:	55                   	push   %ebp
  801410:	89 e5                	mov    %esp,%ebp
  801412:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801415:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801419:	0f 84 e5 00 00 00    	je     801504 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801425:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801428:	05 00 00 00 80       	add    $0x80000000,%eax
  80142d:	c1 e8 0c             	shr    $0xc,%eax
  801430:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801433:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801436:	89 d0                	mov    %edx,%eax
  801438:	01 c0                	add    %eax,%eax
  80143a:	01 d0                	add    %edx,%eax
  80143c:	c1 e0 02             	shl    $0x2,%eax
  80143f:	05 40 30 80 00       	add    $0x803040,%eax
  801444:	8b 00                	mov    (%eax),%eax
  801446:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801449:	0f 85 b8 00 00 00    	jne    801507 <free+0xf8>
  80144f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801452:	89 d0                	mov    %edx,%eax
  801454:	01 c0                	add    %eax,%eax
  801456:	01 d0                	add    %edx,%eax
  801458:	c1 e0 02             	shl    $0x2,%eax
  80145b:	05 48 30 80 00       	add    $0x803048,%eax
  801460:	8b 00                	mov    (%eax),%eax
  801462:	85 c0                	test   %eax,%eax
  801464:	0f 84 9d 00 00 00    	je     801507 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  80146a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80146d:	89 d0                	mov    %edx,%eax
  80146f:	01 c0                	add    %eax,%eax
  801471:	01 d0                	add    %edx,%eax
  801473:	c1 e0 02             	shl    $0x2,%eax
  801476:	05 44 30 80 00       	add    $0x803044,%eax
  80147b:	8b 00                	mov    (%eax),%eax
  80147d:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801480:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801483:	c1 e0 0c             	shl    $0xc,%eax
  801486:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801489:	83 ec 08             	sub    $0x8,%esp
  80148c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80148f:	ff 75 f0             	pushl  -0x10(%ebp)
  801492:	e8 64 02 00 00       	call   8016fb <sys_freeMem>
  801497:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80149a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8014a1:	eb 57                	jmp    8014fa <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8014a3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014a9:	01 c2                	add    %eax,%edx
  8014ab:	89 d0                	mov    %edx,%eax
  8014ad:	01 c0                	add    %eax,%eax
  8014af:	01 d0                	add    %edx,%eax
  8014b1:	c1 e0 02             	shl    $0x2,%eax
  8014b4:	05 48 30 80 00       	add    $0x803048,%eax
  8014b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  8014bf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014c5:	01 c2                	add    %eax,%edx
  8014c7:	89 d0                	mov    %edx,%eax
  8014c9:	01 c0                	add    %eax,%eax
  8014cb:	01 d0                	add    %edx,%eax
  8014cd:	c1 e0 02             	shl    $0x2,%eax
  8014d0:	05 40 30 80 00       	add    $0x803040,%eax
  8014d5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8014db:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014e1:	01 c2                	add    %eax,%edx
  8014e3:	89 d0                	mov    %edx,%eax
  8014e5:	01 c0                	add    %eax,%eax
  8014e7:	01 d0                	add    %edx,%eax
  8014e9:	c1 e0 02             	shl    $0x2,%eax
  8014ec:	05 44 30 80 00       	add    $0x803044,%eax
  8014f1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8014f7:	ff 45 f4             	incl   -0xc(%ebp)
  8014fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014fd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801500:	7c a1                	jl     8014a3 <free+0x94>
  801502:	eb 04                	jmp    801508 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801504:	90                   	nop
  801505:	eb 01                	jmp    801508 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801507:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801508:	c9                   	leave  
  801509:	c3                   	ret    

0080150a <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  80150a:	55                   	push   %ebp
  80150b:	89 e5                	mov    %esp,%ebp
  80150d:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801510:	83 ec 04             	sub    $0x4,%esp
  801513:	68 b8 25 80 00       	push   $0x8025b8
  801518:	68 ae 00 00 00       	push   $0xae
  80151d:	68 8f 25 80 00       	push   $0x80258f
  801522:	e8 4f ed ff ff       	call   800276 <_panic>

00801527 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801527:	55                   	push   %ebp
  801528:	89 e5                	mov    %esp,%ebp
  80152a:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  80152d:	83 ec 04             	sub    $0x4,%esp
  801530:	68 d8 25 80 00       	push   $0x8025d8
  801535:	68 ca 00 00 00       	push   $0xca
  80153a:	68 8f 25 80 00       	push   $0x80258f
  80153f:	e8 32 ed ff ff       	call   800276 <_panic>

00801544 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801544:	55                   	push   %ebp
  801545:	89 e5                	mov    %esp,%ebp
  801547:	57                   	push   %edi
  801548:	56                   	push   %esi
  801549:	53                   	push   %ebx
  80154a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80154d:	8b 45 08             	mov    0x8(%ebp),%eax
  801550:	8b 55 0c             	mov    0xc(%ebp),%edx
  801553:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801556:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801559:	8b 7d 18             	mov    0x18(%ebp),%edi
  80155c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80155f:	cd 30                	int    $0x30
  801561:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801564:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801567:	83 c4 10             	add    $0x10,%esp
  80156a:	5b                   	pop    %ebx
  80156b:	5e                   	pop    %esi
  80156c:	5f                   	pop    %edi
  80156d:	5d                   	pop    %ebp
  80156e:	c3                   	ret    

0080156f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80156f:	55                   	push   %ebp
  801570:	89 e5                	mov    %esp,%ebp
  801572:	83 ec 04             	sub    $0x4,%esp
  801575:	8b 45 10             	mov    0x10(%ebp),%eax
  801578:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80157b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80157f:	8b 45 08             	mov    0x8(%ebp),%eax
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	52                   	push   %edx
  801587:	ff 75 0c             	pushl  0xc(%ebp)
  80158a:	50                   	push   %eax
  80158b:	6a 00                	push   $0x0
  80158d:	e8 b2 ff ff ff       	call   801544 <syscall>
  801592:	83 c4 18             	add    $0x18,%esp
}
  801595:	90                   	nop
  801596:	c9                   	leave  
  801597:	c3                   	ret    

00801598 <sys_cgetc>:

int
sys_cgetc(void)
{
  801598:	55                   	push   %ebp
  801599:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 01                	push   $0x1
  8015a7:	e8 98 ff ff ff       	call   801544 <syscall>
  8015ac:	83 c4 18             	add    $0x18,%esp
}
  8015af:	c9                   	leave  
  8015b0:	c3                   	ret    

008015b1 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8015b1:	55                   	push   %ebp
  8015b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8015b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	50                   	push   %eax
  8015c0:	6a 05                	push   $0x5
  8015c2:	e8 7d ff ff ff       	call   801544 <syscall>
  8015c7:	83 c4 18             	add    $0x18,%esp
}
  8015ca:	c9                   	leave  
  8015cb:	c3                   	ret    

008015cc <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 02                	push   $0x2
  8015db:	e8 64 ff ff ff       	call   801544 <syscall>
  8015e0:	83 c4 18             	add    $0x18,%esp
}
  8015e3:	c9                   	leave  
  8015e4:	c3                   	ret    

008015e5 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015e5:	55                   	push   %ebp
  8015e6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 03                	push   $0x3
  8015f4:	e8 4b ff ff ff       	call   801544 <syscall>
  8015f9:	83 c4 18             	add    $0x18,%esp
}
  8015fc:	c9                   	leave  
  8015fd:	c3                   	ret    

008015fe <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015fe:	55                   	push   %ebp
  8015ff:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	6a 04                	push   $0x4
  80160d:	e8 32 ff ff ff       	call   801544 <syscall>
  801612:	83 c4 18             	add    $0x18,%esp
}
  801615:	c9                   	leave  
  801616:	c3                   	ret    

00801617 <sys_env_exit>:


void sys_env_exit(void)
{
  801617:	55                   	push   %ebp
  801618:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	6a 00                	push   $0x0
  801624:	6a 06                	push   $0x6
  801626:	e8 19 ff ff ff       	call   801544 <syscall>
  80162b:	83 c4 18             	add    $0x18,%esp
}
  80162e:	90                   	nop
  80162f:	c9                   	leave  
  801630:	c3                   	ret    

00801631 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801631:	55                   	push   %ebp
  801632:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801634:	8b 55 0c             	mov    0xc(%ebp),%edx
  801637:	8b 45 08             	mov    0x8(%ebp),%eax
  80163a:	6a 00                	push   $0x0
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	52                   	push   %edx
  801641:	50                   	push   %eax
  801642:	6a 07                	push   $0x7
  801644:	e8 fb fe ff ff       	call   801544 <syscall>
  801649:	83 c4 18             	add    $0x18,%esp
}
  80164c:	c9                   	leave  
  80164d:	c3                   	ret    

0080164e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80164e:	55                   	push   %ebp
  80164f:	89 e5                	mov    %esp,%ebp
  801651:	56                   	push   %esi
  801652:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801653:	8b 75 18             	mov    0x18(%ebp),%esi
  801656:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801659:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80165c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	56                   	push   %esi
  801663:	53                   	push   %ebx
  801664:	51                   	push   %ecx
  801665:	52                   	push   %edx
  801666:	50                   	push   %eax
  801667:	6a 08                	push   $0x8
  801669:	e8 d6 fe ff ff       	call   801544 <syscall>
  80166e:	83 c4 18             	add    $0x18,%esp
}
  801671:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801674:	5b                   	pop    %ebx
  801675:	5e                   	pop    %esi
  801676:	5d                   	pop    %ebp
  801677:	c3                   	ret    

00801678 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801678:	55                   	push   %ebp
  801679:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80167b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	52                   	push   %edx
  801688:	50                   	push   %eax
  801689:	6a 09                	push   $0x9
  80168b:	e8 b4 fe ff ff       	call   801544 <syscall>
  801690:	83 c4 18             	add    $0x18,%esp
}
  801693:	c9                   	leave  
  801694:	c3                   	ret    

00801695 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801695:	55                   	push   %ebp
  801696:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	ff 75 0c             	pushl  0xc(%ebp)
  8016a1:	ff 75 08             	pushl  0x8(%ebp)
  8016a4:	6a 0a                	push   $0xa
  8016a6:	e8 99 fe ff ff       	call   801544 <syscall>
  8016ab:	83 c4 18             	add    $0x18,%esp
}
  8016ae:	c9                   	leave  
  8016af:	c3                   	ret    

008016b0 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8016b0:	55                   	push   %ebp
  8016b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 0b                	push   $0xb
  8016bf:	e8 80 fe ff ff       	call   801544 <syscall>
  8016c4:	83 c4 18             	add    $0x18,%esp
}
  8016c7:	c9                   	leave  
  8016c8:	c3                   	ret    

008016c9 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 0c                	push   $0xc
  8016d8:	e8 67 fe ff ff       	call   801544 <syscall>
  8016dd:	83 c4 18             	add    $0x18,%esp
}
  8016e0:	c9                   	leave  
  8016e1:	c3                   	ret    

008016e2 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 0d                	push   $0xd
  8016f1:	e8 4e fe ff ff       	call   801544 <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
}
  8016f9:	c9                   	leave  
  8016fa:	c3                   	ret    

008016fb <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8016fb:	55                   	push   %ebp
  8016fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	ff 75 0c             	pushl  0xc(%ebp)
  801707:	ff 75 08             	pushl  0x8(%ebp)
  80170a:	6a 11                	push   $0x11
  80170c:	e8 33 fe ff ff       	call   801544 <syscall>
  801711:	83 c4 18             	add    $0x18,%esp
	return;
  801714:	90                   	nop
}
  801715:	c9                   	leave  
  801716:	c3                   	ret    

00801717 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801717:	55                   	push   %ebp
  801718:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	ff 75 0c             	pushl  0xc(%ebp)
  801723:	ff 75 08             	pushl  0x8(%ebp)
  801726:	6a 12                	push   $0x12
  801728:	e8 17 fe ff ff       	call   801544 <syscall>
  80172d:	83 c4 18             	add    $0x18,%esp
	return ;
  801730:	90                   	nop
}
  801731:	c9                   	leave  
  801732:	c3                   	ret    

00801733 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801733:	55                   	push   %ebp
  801734:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 0e                	push   $0xe
  801742:	e8 fd fd ff ff       	call   801544 <syscall>
  801747:	83 c4 18             	add    $0x18,%esp
}
  80174a:	c9                   	leave  
  80174b:	c3                   	ret    

0080174c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80174c:	55                   	push   %ebp
  80174d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	6a 00                	push   $0x0
  801757:	ff 75 08             	pushl  0x8(%ebp)
  80175a:	6a 0f                	push   $0xf
  80175c:	e8 e3 fd ff ff       	call   801544 <syscall>
  801761:	83 c4 18             	add    $0x18,%esp
}
  801764:	c9                   	leave  
  801765:	c3                   	ret    

00801766 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801766:	55                   	push   %ebp
  801767:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 10                	push   $0x10
  801775:	e8 ca fd ff ff       	call   801544 <syscall>
  80177a:	83 c4 18             	add    $0x18,%esp
}
  80177d:	90                   	nop
  80177e:	c9                   	leave  
  80177f:	c3                   	ret    

00801780 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801780:	55                   	push   %ebp
  801781:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	6a 14                	push   $0x14
  80178f:	e8 b0 fd ff ff       	call   801544 <syscall>
  801794:	83 c4 18             	add    $0x18,%esp
}
  801797:	90                   	nop
  801798:	c9                   	leave  
  801799:	c3                   	ret    

0080179a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80179a:	55                   	push   %ebp
  80179b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 15                	push   $0x15
  8017a9:	e8 96 fd ff ff       	call   801544 <syscall>
  8017ae:	83 c4 18             	add    $0x18,%esp
}
  8017b1:	90                   	nop
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <sys_cputc>:


void
sys_cputc(const char c)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
  8017b7:	83 ec 04             	sub    $0x4,%esp
  8017ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017c0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	50                   	push   %eax
  8017cd:	6a 16                	push   $0x16
  8017cf:	e8 70 fd ff ff       	call   801544 <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
}
  8017d7:	90                   	nop
  8017d8:	c9                   	leave  
  8017d9:	c3                   	ret    

008017da <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017da:	55                   	push   %ebp
  8017db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 17                	push   $0x17
  8017e9:	e8 56 fd ff ff       	call   801544 <syscall>
  8017ee:	83 c4 18             	add    $0x18,%esp
}
  8017f1:	90                   	nop
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8017f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	ff 75 0c             	pushl  0xc(%ebp)
  801803:	50                   	push   %eax
  801804:	6a 18                	push   $0x18
  801806:	e8 39 fd ff ff       	call   801544 <syscall>
  80180b:	83 c4 18             	add    $0x18,%esp
}
  80180e:	c9                   	leave  
  80180f:	c3                   	ret    

00801810 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801810:	55                   	push   %ebp
  801811:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801813:	8b 55 0c             	mov    0xc(%ebp),%edx
  801816:	8b 45 08             	mov    0x8(%ebp),%eax
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	52                   	push   %edx
  801820:	50                   	push   %eax
  801821:	6a 1b                	push   $0x1b
  801823:	e8 1c fd ff ff       	call   801544 <syscall>
  801828:	83 c4 18             	add    $0x18,%esp
}
  80182b:	c9                   	leave  
  80182c:	c3                   	ret    

0080182d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80182d:	55                   	push   %ebp
  80182e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801830:	8b 55 0c             	mov    0xc(%ebp),%edx
  801833:	8b 45 08             	mov    0x8(%ebp),%eax
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	52                   	push   %edx
  80183d:	50                   	push   %eax
  80183e:	6a 19                	push   $0x19
  801840:	e8 ff fc ff ff       	call   801544 <syscall>
  801845:	83 c4 18             	add    $0x18,%esp
}
  801848:	90                   	nop
  801849:	c9                   	leave  
  80184a:	c3                   	ret    

0080184b <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80184b:	55                   	push   %ebp
  80184c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80184e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801851:	8b 45 08             	mov    0x8(%ebp),%eax
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	52                   	push   %edx
  80185b:	50                   	push   %eax
  80185c:	6a 1a                	push   $0x1a
  80185e:	e8 e1 fc ff ff       	call   801544 <syscall>
  801863:	83 c4 18             	add    $0x18,%esp
}
  801866:	90                   	nop
  801867:	c9                   	leave  
  801868:	c3                   	ret    

00801869 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801869:	55                   	push   %ebp
  80186a:	89 e5                	mov    %esp,%ebp
  80186c:	83 ec 04             	sub    $0x4,%esp
  80186f:	8b 45 10             	mov    0x10(%ebp),%eax
  801872:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801875:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801878:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80187c:	8b 45 08             	mov    0x8(%ebp),%eax
  80187f:	6a 00                	push   $0x0
  801881:	51                   	push   %ecx
  801882:	52                   	push   %edx
  801883:	ff 75 0c             	pushl  0xc(%ebp)
  801886:	50                   	push   %eax
  801887:	6a 1c                	push   $0x1c
  801889:	e8 b6 fc ff ff       	call   801544 <syscall>
  80188e:	83 c4 18             	add    $0x18,%esp
}
  801891:	c9                   	leave  
  801892:	c3                   	ret    

00801893 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801893:	55                   	push   %ebp
  801894:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801896:	8b 55 0c             	mov    0xc(%ebp),%edx
  801899:	8b 45 08             	mov    0x8(%ebp),%eax
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	52                   	push   %edx
  8018a3:	50                   	push   %eax
  8018a4:	6a 1d                	push   $0x1d
  8018a6:	e8 99 fc ff ff       	call   801544 <syscall>
  8018ab:	83 c4 18             	add    $0x18,%esp
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8018b3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	51                   	push   %ecx
  8018c1:	52                   	push   %edx
  8018c2:	50                   	push   %eax
  8018c3:	6a 1e                	push   $0x1e
  8018c5:	e8 7a fc ff ff       	call   801544 <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
}
  8018cd:	c9                   	leave  
  8018ce:	c3                   	ret    

008018cf <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8018cf:	55                   	push   %ebp
  8018d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8018d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	52                   	push   %edx
  8018df:	50                   	push   %eax
  8018e0:	6a 1f                	push   $0x1f
  8018e2:	e8 5d fc ff ff       	call   801544 <syscall>
  8018e7:	83 c4 18             	add    $0x18,%esp
}
  8018ea:	c9                   	leave  
  8018eb:	c3                   	ret    

008018ec <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8018ec:	55                   	push   %ebp
  8018ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 20                	push   $0x20
  8018fb:	e8 44 fc ff ff       	call   801544 <syscall>
  801900:	83 c4 18             	add    $0x18,%esp
}
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801908:	8b 45 08             	mov    0x8(%ebp),%eax
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	ff 75 10             	pushl  0x10(%ebp)
  801912:	ff 75 0c             	pushl  0xc(%ebp)
  801915:	50                   	push   %eax
  801916:	6a 21                	push   $0x21
  801918:	e8 27 fc ff ff       	call   801544 <syscall>
  80191d:	83 c4 18             	add    $0x18,%esp
}
  801920:	c9                   	leave  
  801921:	c3                   	ret    

00801922 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801922:	55                   	push   %ebp
  801923:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801925:	8b 45 08             	mov    0x8(%ebp),%eax
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	50                   	push   %eax
  801931:	6a 22                	push   $0x22
  801933:	e8 0c fc ff ff       	call   801544 <syscall>
  801938:	83 c4 18             	add    $0x18,%esp
}
  80193b:	90                   	nop
  80193c:	c9                   	leave  
  80193d:	c3                   	ret    

0080193e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80193e:	55                   	push   %ebp
  80193f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801941:	8b 45 08             	mov    0x8(%ebp),%eax
  801944:	6a 00                	push   $0x0
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	50                   	push   %eax
  80194d:	6a 23                	push   $0x23
  80194f:	e8 f0 fb ff ff       	call   801544 <syscall>
  801954:	83 c4 18             	add    $0x18,%esp
}
  801957:	90                   	nop
  801958:	c9                   	leave  
  801959:	c3                   	ret    

0080195a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80195a:	55                   	push   %ebp
  80195b:	89 e5                	mov    %esp,%ebp
  80195d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801960:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801963:	8d 50 04             	lea    0x4(%eax),%edx
  801966:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	52                   	push   %edx
  801970:	50                   	push   %eax
  801971:	6a 24                	push   $0x24
  801973:	e8 cc fb ff ff       	call   801544 <syscall>
  801978:	83 c4 18             	add    $0x18,%esp
	return result;
  80197b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80197e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801981:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801984:	89 01                	mov    %eax,(%ecx)
  801986:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801989:	8b 45 08             	mov    0x8(%ebp),%eax
  80198c:	c9                   	leave  
  80198d:	c2 04 00             	ret    $0x4

00801990 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801990:	55                   	push   %ebp
  801991:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	ff 75 10             	pushl  0x10(%ebp)
  80199a:	ff 75 0c             	pushl  0xc(%ebp)
  80199d:	ff 75 08             	pushl  0x8(%ebp)
  8019a0:	6a 13                	push   $0x13
  8019a2:	e8 9d fb ff ff       	call   801544 <syscall>
  8019a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8019aa:	90                   	nop
}
  8019ab:	c9                   	leave  
  8019ac:	c3                   	ret    

008019ad <sys_rcr2>:
uint32 sys_rcr2()
{
  8019ad:	55                   	push   %ebp
  8019ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 25                	push   $0x25
  8019bc:	e8 83 fb ff ff       	call   801544 <syscall>
  8019c1:	83 c4 18             	add    $0x18,%esp
}
  8019c4:	c9                   	leave  
  8019c5:	c3                   	ret    

008019c6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8019c6:	55                   	push   %ebp
  8019c7:	89 e5                	mov    %esp,%ebp
  8019c9:	83 ec 04             	sub    $0x4,%esp
  8019cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8019d2:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	50                   	push   %eax
  8019df:	6a 26                	push   $0x26
  8019e1:	e8 5e fb ff ff       	call   801544 <syscall>
  8019e6:	83 c4 18             	add    $0x18,%esp
	return ;
  8019e9:	90                   	nop
}
  8019ea:	c9                   	leave  
  8019eb:	c3                   	ret    

008019ec <rsttst>:
void rsttst()
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 28                	push   $0x28
  8019fb:	e8 44 fb ff ff       	call   801544 <syscall>
  801a00:	83 c4 18             	add    $0x18,%esp
	return ;
  801a03:	90                   	nop
}
  801a04:	c9                   	leave  
  801a05:	c3                   	ret    

00801a06 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a06:	55                   	push   %ebp
  801a07:	89 e5                	mov    %esp,%ebp
  801a09:	83 ec 04             	sub    $0x4,%esp
  801a0c:	8b 45 14             	mov    0x14(%ebp),%eax
  801a0f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a12:	8b 55 18             	mov    0x18(%ebp),%edx
  801a15:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a19:	52                   	push   %edx
  801a1a:	50                   	push   %eax
  801a1b:	ff 75 10             	pushl  0x10(%ebp)
  801a1e:	ff 75 0c             	pushl  0xc(%ebp)
  801a21:	ff 75 08             	pushl  0x8(%ebp)
  801a24:	6a 27                	push   $0x27
  801a26:	e8 19 fb ff ff       	call   801544 <syscall>
  801a2b:	83 c4 18             	add    $0x18,%esp
	return ;
  801a2e:	90                   	nop
}
  801a2f:	c9                   	leave  
  801a30:	c3                   	ret    

00801a31 <chktst>:
void chktst(uint32 n)
{
  801a31:	55                   	push   %ebp
  801a32:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a34:	6a 00                	push   $0x0
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	ff 75 08             	pushl  0x8(%ebp)
  801a3f:	6a 29                	push   $0x29
  801a41:	e8 fe fa ff ff       	call   801544 <syscall>
  801a46:	83 c4 18             	add    $0x18,%esp
	return ;
  801a49:	90                   	nop
}
  801a4a:	c9                   	leave  
  801a4b:	c3                   	ret    

00801a4c <inctst>:

void inctst()
{
  801a4c:	55                   	push   %ebp
  801a4d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 00                	push   $0x0
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	6a 2a                	push   $0x2a
  801a5b:	e8 e4 fa ff ff       	call   801544 <syscall>
  801a60:	83 c4 18             	add    $0x18,%esp
	return ;
  801a63:	90                   	nop
}
  801a64:	c9                   	leave  
  801a65:	c3                   	ret    

00801a66 <gettst>:
uint32 gettst()
{
  801a66:	55                   	push   %ebp
  801a67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 2b                	push   $0x2b
  801a75:	e8 ca fa ff ff       	call   801544 <syscall>
  801a7a:	83 c4 18             	add    $0x18,%esp
}
  801a7d:	c9                   	leave  
  801a7e:	c3                   	ret    

00801a7f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a7f:	55                   	push   %ebp
  801a80:	89 e5                	mov    %esp,%ebp
  801a82:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 2c                	push   $0x2c
  801a91:	e8 ae fa ff ff       	call   801544 <syscall>
  801a96:	83 c4 18             	add    $0x18,%esp
  801a99:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a9c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801aa0:	75 07                	jne    801aa9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801aa2:	b8 01 00 00 00       	mov    $0x1,%eax
  801aa7:	eb 05                	jmp    801aae <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801aa9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aae:	c9                   	leave  
  801aaf:	c3                   	ret    

00801ab0 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801ab0:	55                   	push   %ebp
  801ab1:	89 e5                	mov    %esp,%ebp
  801ab3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 2c                	push   $0x2c
  801ac2:	e8 7d fa ff ff       	call   801544 <syscall>
  801ac7:	83 c4 18             	add    $0x18,%esp
  801aca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801acd:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ad1:	75 07                	jne    801ada <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ad3:	b8 01 00 00 00       	mov    $0x1,%eax
  801ad8:	eb 05                	jmp    801adf <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ada:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801adf:	c9                   	leave  
  801ae0:	c3                   	ret    

00801ae1 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ae1:	55                   	push   %ebp
  801ae2:	89 e5                	mov    %esp,%ebp
  801ae4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 2c                	push   $0x2c
  801af3:	e8 4c fa ff ff       	call   801544 <syscall>
  801af8:	83 c4 18             	add    $0x18,%esp
  801afb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801afe:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b02:	75 07                	jne    801b0b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b04:	b8 01 00 00 00       	mov    $0x1,%eax
  801b09:	eb 05                	jmp    801b10 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b0b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b10:	c9                   	leave  
  801b11:	c3                   	ret    

00801b12 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b12:	55                   	push   %ebp
  801b13:	89 e5                	mov    %esp,%ebp
  801b15:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	6a 2c                	push   $0x2c
  801b24:	e8 1b fa ff ff       	call   801544 <syscall>
  801b29:	83 c4 18             	add    $0x18,%esp
  801b2c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b2f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b33:	75 07                	jne    801b3c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b35:	b8 01 00 00 00       	mov    $0x1,%eax
  801b3a:	eb 05                	jmp    801b41 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b3c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b41:	c9                   	leave  
  801b42:	c3                   	ret    

00801b43 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b43:	55                   	push   %ebp
  801b44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	ff 75 08             	pushl  0x8(%ebp)
  801b51:	6a 2d                	push   $0x2d
  801b53:	e8 ec f9 ff ff       	call   801544 <syscall>
  801b58:	83 c4 18             	add    $0x18,%esp
	return ;
  801b5b:	90                   	nop
}
  801b5c:	c9                   	leave  
  801b5d:	c3                   	ret    

00801b5e <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801b5e:	55                   	push   %ebp
  801b5f:	89 e5                	mov    %esp,%ebp
  801b61:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801b64:	8b 55 08             	mov    0x8(%ebp),%edx
  801b67:	89 d0                	mov    %edx,%eax
  801b69:	c1 e0 02             	shl    $0x2,%eax
  801b6c:	01 d0                	add    %edx,%eax
  801b6e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b75:	01 d0                	add    %edx,%eax
  801b77:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b7e:	01 d0                	add    %edx,%eax
  801b80:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b87:	01 d0                	add    %edx,%eax
  801b89:	c1 e0 04             	shl    $0x4,%eax
  801b8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801b8f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801b96:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801b99:	83 ec 0c             	sub    $0xc,%esp
  801b9c:	50                   	push   %eax
  801b9d:	e8 b8 fd ff ff       	call   80195a <sys_get_virtual_time>
  801ba2:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801ba5:	eb 41                	jmp    801be8 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801ba7:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801baa:	83 ec 0c             	sub    $0xc,%esp
  801bad:	50                   	push   %eax
  801bae:	e8 a7 fd ff ff       	call   80195a <sys_get_virtual_time>
  801bb3:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801bb6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801bb9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801bbc:	29 c2                	sub    %eax,%edx
  801bbe:	89 d0                	mov    %edx,%eax
  801bc0:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801bc3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801bc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801bc9:	89 d1                	mov    %edx,%ecx
  801bcb:	29 c1                	sub    %eax,%ecx
  801bcd:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801bd0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801bd3:	39 c2                	cmp    %eax,%edx
  801bd5:	0f 97 c0             	seta   %al
  801bd8:	0f b6 c0             	movzbl %al,%eax
  801bdb:	29 c1                	sub    %eax,%ecx
  801bdd:	89 c8                	mov    %ecx,%eax
  801bdf:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801be2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801be5:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801be8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801beb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bee:	72 b7                	jb     801ba7 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801bf0:	90                   	nop
  801bf1:	c9                   	leave  
  801bf2:	c3                   	ret    

00801bf3 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801bf3:	55                   	push   %ebp
  801bf4:	89 e5                	mov    %esp,%ebp
  801bf6:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801bf9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801c00:	eb 03                	jmp    801c05 <busy_wait+0x12>
  801c02:	ff 45 fc             	incl   -0x4(%ebp)
  801c05:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c08:	3b 45 08             	cmp    0x8(%ebp),%eax
  801c0b:	72 f5                	jb     801c02 <busy_wait+0xf>
	return i;
  801c0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801c10:	c9                   	leave  
  801c11:	c3                   	ret    
  801c12:	66 90                	xchg   %ax,%ax

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
