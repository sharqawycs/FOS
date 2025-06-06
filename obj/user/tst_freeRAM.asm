
obj/user/tst_freeRAM:     file format elf32-i386


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
  800031:	e8 4a 14 00 00       	call   801480 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

char arr[PAGE_SIZE*12];
uint32 WSEntries_before[1000];

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 8c 01 00 00    	sub    $0x18c,%esp
	vcprintf("\n\n===============================================================\n", NULL);
  800044:	83 ec 08             	sub    $0x8,%esp
  800047:	6a 00                	push   $0x0
  800049:	68 00 2f 80 00       	push   $0x802f00
  80004e:	e8 78 17 00 00       	call   8017cb <vcprintf>
  800053:	83 c4 10             	add    $0x10,%esp
	vcprintf("MAKE SURE to have a FRESH RUN for EACH SCENARIO of this test\n(i.e. don't run any program/test/multiple scenarios before it)\n", NULL);
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	6a 00                	push   $0x0
  80005b:	68 44 2f 80 00       	push   $0x802f44
  800060:	e8 66 17 00 00       	call   8017cb <vcprintf>
  800065:	83 c4 10             	add    $0x10,%esp
	vcprintf("===============================================================\n\n\n", NULL);
  800068:	83 ec 08             	sub    $0x8,%esp
  80006b:	6a 00                	push   $0x0
  80006d:	68 c4 2f 80 00       	push   $0x802fc4
  800072:	e8 54 17 00 00       	call   8017cb <vcprintf>
  800077:	83 c4 10             	add    $0x10,%esp

	uint32 testCase;
	if (myEnv->page_WS_max_size == 1000)
  80007a:	a1 20 40 80 00       	mov    0x804020,%eax
  80007f:	8b 40 74             	mov    0x74(%eax),%eax
  800082:	3d e8 03 00 00       	cmp    $0x3e8,%eax
  800087:	75 09                	jne    800092 <_main+0x5a>
	{
		//EVALUATION [40%]
		testCase = 1 ;
  800089:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  800090:	eb 2a                	jmp    8000bc <_main+0x84>
	}
	else if (myEnv->page_WS_max_size == 10)
  800092:	a1 20 40 80 00       	mov    0x804020,%eax
  800097:	8b 40 74             	mov    0x74(%eax),%eax
  80009a:	83 f8 0a             	cmp    $0xa,%eax
  80009d:	75 09                	jne    8000a8 <_main+0x70>
	{
		//EVALUATION [30%]
		testCase = 2 ;
  80009f:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%ebp)
  8000a6:	eb 14                	jmp    8000bc <_main+0x84>
	}
	else if (myEnv->page_WS_max_size == 26)
  8000a8:	a1 20 40 80 00       	mov    0x804020,%eax
  8000ad:	8b 40 74             	mov    0x74(%eax),%eax
  8000b0:	83 f8 1a             	cmp    $0x1a,%eax
  8000b3:	75 07                	jne    8000bc <_main+0x84>
	{
		//EVALUATION [30%]
		testCase = 3 ;
  8000b5:	c7 45 e4 03 00 00 00 	movl   $0x3,-0x1c(%ebp)
	}
	int32 envIdFib, envIdHelloWorld, helloWorldFrames;
	{
		//CASE1: free the exited env only
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
  8000bc:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  8000c0:	74 0a                	je     8000cc <_main+0x94>
  8000c2:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8000c6:	0f 85 45 01 00 00    	jne    800211 <_main+0x1d9>
		{
			//Load "fib" & "fos_helloWorld" programs into RAM
			cprintf("Loading Fib & fos_helloWorld programs into RAM...");
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	68 08 30 80 00       	push   $0x803008
  8000d4:	e8 5d 17 00 00       	call   801836 <cprintf>
  8000d9:	83 c4 10             	add    $0x10,%esp
			envIdFib = sys_create_env("fib", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000dc:	a1 20 40 80 00       	mov    0x804020,%eax
  8000e1:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8000e7:	a1 20 40 80 00       	mov    0x804020,%eax
  8000ec:	8b 40 74             	mov    0x74(%eax),%eax
  8000ef:	83 ec 04             	sub    $0x4,%esp
  8000f2:	52                   	push   %edx
  8000f3:	50                   	push   %eax
  8000f4:	68 3a 30 80 00       	push   $0x80303a
  8000f9:	e8 83 28 00 00       	call   802981 <sys_create_env>
  8000fe:	83 c4 10             	add    $0x10,%esp
  800101:	89 45 e0             	mov    %eax,-0x20(%ebp)
			int freeFrames = sys_calculate_free_frames() ;
  800104:	e8 23 26 00 00       	call   80272c <sys_calculate_free_frames>
  800109:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
			envIdHelloWorld = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80010f:	a1 20 40 80 00       	mov    0x804020,%eax
  800114:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  80011a:	a1 20 40 80 00       	mov    0x804020,%eax
  80011f:	8b 40 74             	mov    0x74(%eax),%eax
  800122:	83 ec 04             	sub    $0x4,%esp
  800125:	52                   	push   %edx
  800126:	50                   	push   %eax
  800127:	68 3e 30 80 00       	push   $0x80303e
  80012c:	e8 50 28 00 00       	call   802981 <sys_create_env>
  800131:	83 c4 10             	add    $0x10,%esp
  800134:	89 45 dc             	mov    %eax,-0x24(%ebp)
			helloWorldFrames = freeFrames - sys_calculate_free_frames() ;
  800137:	8b 9d 7c ff ff ff    	mov    -0x84(%ebp),%ebx
  80013d:	e8 ea 25 00 00       	call   80272c <sys_calculate_free_frames>
  800142:	29 c3                	sub    %eax,%ebx
  800144:	89 d8                	mov    %ebx,%eax
  800146:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
			env_sleep(2000);
  80014c:	83 ec 0c             	sub    $0xc,%esp
  80014f:	68 d0 07 00 00       	push   $0x7d0
  800154:	e8 81 2a 00 00       	call   802bda <env_sleep>
  800159:	83 c4 10             	add    $0x10,%esp
			vcprintf("[DONE]\n\n", NULL);
  80015c:	83 ec 08             	sub    $0x8,%esp
  80015f:	6a 00                	push   $0x0
  800161:	68 4d 30 80 00       	push   $0x80304d
  800166:	e8 60 16 00 00       	call   8017cb <vcprintf>
  80016b:	83 c4 10             	add    $0x10,%esp

			//Load and run "fos_add"
			cprintf("Loading fos_add program into RAM...");
  80016e:	83 ec 0c             	sub    $0xc,%esp
  800171:	68 58 30 80 00       	push   $0x803058
  800176:	e8 bb 16 00 00       	call   801836 <cprintf>
  80017b:	83 c4 10             	add    $0x10,%esp
			int32 envIdFOSAdd= sys_create_env("fos_add", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80017e:	a1 20 40 80 00       	mov    0x804020,%eax
  800183:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800189:	a1 20 40 80 00       	mov    0x804020,%eax
  80018e:	8b 40 74             	mov    0x74(%eax),%eax
  800191:	83 ec 04             	sub    $0x4,%esp
  800194:	52                   	push   %edx
  800195:	50                   	push   %eax
  800196:	68 7c 30 80 00       	push   $0x80307c
  80019b:	e8 e1 27 00 00       	call   802981 <sys_create_env>
  8001a0:	83 c4 10             	add    $0x10,%esp
  8001a3:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
			env_sleep(2000);
  8001a9:	83 ec 0c             	sub    $0xc,%esp
  8001ac:	68 d0 07 00 00       	push   $0x7d0
  8001b1:	e8 24 2a 00 00       	call   802bda <env_sleep>
  8001b6:	83 c4 10             	add    $0x10,%esp
			vcprintf("[DONE]\n\n", NULL);
  8001b9:	83 ec 08             	sub    $0x8,%esp
  8001bc:	6a 00                	push   $0x0
  8001be:	68 4d 30 80 00       	push   $0x80304d
  8001c3:	e8 03 16 00 00       	call   8017cb <vcprintf>
  8001c8:	83 c4 10             	add    $0x10,%esp

			cprintf("running fos_add program...\n\n");
  8001cb:	83 ec 0c             	sub    $0xc,%esp
  8001ce:	68 84 30 80 00       	push   $0x803084
  8001d3:	e8 5e 16 00 00       	call   801836 <cprintf>
  8001d8:	83 c4 10             	add    $0x10,%esp
			sys_run_env(envIdFOSAdd);
  8001db:	83 ec 0c             	sub    $0xc,%esp
  8001de:	ff b5 74 ff ff ff    	pushl  -0x8c(%ebp)
  8001e4:	e8 b5 27 00 00       	call   80299e <sys_run_env>
  8001e9:	83 c4 10             	add    $0x10,%esp

			cprintf("please be patient ...\n");
  8001ec:	83 ec 0c             	sub    $0xc,%esp
  8001ef:	68 a1 30 80 00       	push   $0x8030a1
  8001f4:	e8 3d 16 00 00       	call   801836 <cprintf>
  8001f9:	83 c4 10             	add    $0x10,%esp
			env_sleep(5000);
  8001fc:	83 ec 0c             	sub    $0xc,%esp
  8001ff:	68 88 13 00 00       	push   $0x1388
  800204:	e8 d1 29 00 00       	call   802bda <env_sleep>
  800209:	83 c4 10             	add    $0x10,%esp
	int32 envIdFib, envIdHelloWorld, helloWorldFrames;
	{
		//CASE1: free the exited env only
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
		{
  80020c:	e9 47 02 00 00       	jmp    800458 <_main+0x420>
				if( myEnv->page_last_WS_index !=  0)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
			}
		}
		 */
		//CASE2: free the WS ONLY using FIFO algorithm
		else if (testCase == 2)
  800211:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  800215:	0f 85 3d 02 00 00    	jne    800458 <_main+0x420>
		{
			//("STEP 0: checking InitialWSError2: INITIAL WS entries ...\n");
			{
				if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x804000)  	panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80021b:	a1 20 40 80 00       	mov    0x804020,%eax
  800220:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800226:	8b 00                	mov    (%eax),%eax
  800228:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  80022b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80022e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800233:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800238:	74 14                	je     80024e <_main+0x216>
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	68 b8 30 80 00       	push   $0x8030b8
  800242:	6a 57                	push   $0x57
  800244:	68 0a 31 80 00       	push   $0x80310a
  800249:	e8 34 13 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80024e:	a1 20 40 80 00       	mov    0x804020,%eax
  800253:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800259:	83 c0 0c             	add    $0xc,%eax
  80025c:	8b 00                	mov    (%eax),%eax
  80025e:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800261:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800264:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800269:	3d 00 10 20 00       	cmp    $0x201000,%eax
  80026e:	74 14                	je     800284 <_main+0x24c>
  800270:	83 ec 04             	sub    $0x4,%esp
  800273:	68 b8 30 80 00       	push   $0x8030b8
  800278:	6a 58                	push   $0x58
  80027a:	68 0a 31 80 00       	push   $0x80310a
  80027f:	e8 fe 12 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800284:	a1 20 40 80 00       	mov    0x804020,%eax
  800289:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80028f:	83 c0 18             	add    $0x18,%eax
  800292:	8b 00                	mov    (%eax),%eax
  800294:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800297:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80029a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80029f:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8002a4:	74 14                	je     8002ba <_main+0x282>
  8002a6:	83 ec 04             	sub    $0x4,%esp
  8002a9:	68 b8 30 80 00       	push   $0x8030b8
  8002ae:	6a 59                	push   $0x59
  8002b0:	68 0a 31 80 00       	push   $0x80310a
  8002b5:	e8 c8 12 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002ba:	a1 20 40 80 00       	mov    0x804020,%eax
  8002bf:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002c5:	83 c0 24             	add    $0x24,%eax
  8002c8:	8b 00                	mov    (%eax),%eax
  8002ca:	89 45 98             	mov    %eax,-0x68(%ebp)
  8002cd:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002d5:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8002da:	74 14                	je     8002f0 <_main+0x2b8>
  8002dc:	83 ec 04             	sub    $0x4,%esp
  8002df:	68 b8 30 80 00       	push   $0x8030b8
  8002e4:	6a 5a                	push   $0x5a
  8002e6:	68 0a 31 80 00       	push   $0x80310a
  8002eb:	e8 92 12 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002f0:	a1 20 40 80 00       	mov    0x804020,%eax
  8002f5:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002fb:	83 c0 30             	add    $0x30,%eax
  8002fe:	8b 00                	mov    (%eax),%eax
  800300:	89 45 94             	mov    %eax,-0x6c(%ebp)
  800303:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800306:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80030b:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800310:	74 14                	je     800326 <_main+0x2ee>
  800312:	83 ec 04             	sub    $0x4,%esp
  800315:	68 b8 30 80 00       	push   $0x8030b8
  80031a:	6a 5b                	push   $0x5b
  80031c:	68 0a 31 80 00       	push   $0x80310a
  800321:	e8 5c 12 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800326:	a1 20 40 80 00       	mov    0x804020,%eax
  80032b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800331:	83 c0 3c             	add    $0x3c,%eax
  800334:	8b 00                	mov    (%eax),%eax
  800336:	89 45 90             	mov    %eax,-0x70(%ebp)
  800339:	8b 45 90             	mov    -0x70(%ebp),%eax
  80033c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800341:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800346:	74 14                	je     80035c <_main+0x324>
  800348:	83 ec 04             	sub    $0x4,%esp
  80034b:	68 b8 30 80 00       	push   $0x8030b8
  800350:	6a 5c                	push   $0x5c
  800352:	68 0a 31 80 00       	push   $0x80310a
  800357:	e8 26 12 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80035c:	a1 20 40 80 00       	mov    0x804020,%eax
  800361:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800367:	83 c0 48             	add    $0x48,%eax
  80036a:	8b 00                	mov    (%eax),%eax
  80036c:	89 45 8c             	mov    %eax,-0x74(%ebp)
  80036f:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800372:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800377:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80037c:	74 14                	je     800392 <_main+0x35a>
  80037e:	83 ec 04             	sub    $0x4,%esp
  800381:	68 b8 30 80 00       	push   $0x8030b8
  800386:	6a 5d                	push   $0x5d
  800388:	68 0a 31 80 00       	push   $0x80310a
  80038d:	e8 f0 11 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800392:	a1 20 40 80 00       	mov    0x804020,%eax
  800397:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80039d:	83 c0 54             	add    $0x54,%eax
  8003a0:	8b 00                	mov    (%eax),%eax
  8003a2:	89 45 88             	mov    %eax,-0x78(%ebp)
  8003a5:	8b 45 88             	mov    -0x78(%ebp),%eax
  8003a8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003ad:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8003b2:	74 14                	je     8003c8 <_main+0x390>
  8003b4:	83 ec 04             	sub    $0x4,%esp
  8003b7:	68 b8 30 80 00       	push   $0x8030b8
  8003bc:	6a 5e                	push   $0x5e
  8003be:	68 0a 31 80 00       	push   $0x80310a
  8003c3:	e8 ba 11 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8003c8:	a1 20 40 80 00       	mov    0x804020,%eax
  8003cd:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003d3:	83 c0 60             	add    $0x60,%eax
  8003d6:	8b 00                	mov    (%eax),%eax
  8003d8:	89 45 84             	mov    %eax,-0x7c(%ebp)
  8003db:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8003de:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003e3:	3d 00 20 80 00       	cmp    $0x802000,%eax
  8003e8:	74 14                	je     8003fe <_main+0x3c6>
  8003ea:	83 ec 04             	sub    $0x4,%esp
  8003ed:	68 b8 30 80 00       	push   $0x8030b8
  8003f2:	6a 5f                	push   $0x5f
  8003f4:	68 0a 31 80 00       	push   $0x80310a
  8003f9:	e8 84 11 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8003fe:	a1 20 40 80 00       	mov    0x804020,%eax
  800403:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800409:	83 c0 6c             	add    $0x6c,%eax
  80040c:	8b 00                	mov    (%eax),%eax
  80040e:	89 45 80             	mov    %eax,-0x80(%ebp)
  800411:	8b 45 80             	mov    -0x80(%ebp),%eax
  800414:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800419:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80041e:	74 14                	je     800434 <_main+0x3fc>
  800420:	83 ec 04             	sub    $0x4,%esp
  800423:	68 b8 30 80 00       	push   $0x8030b8
  800428:	6a 60                	push   $0x60
  80042a:	68 0a 31 80 00       	push   $0x80310a
  80042f:	e8 4e 11 00 00       	call   801582 <_panic>
				if( myEnv->page_last_WS_index !=  1)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800434:	a1 20 40 80 00       	mov    0x804020,%eax
  800439:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  80043f:	83 f8 01             	cmp    $0x1,%eax
  800442:	74 14                	je     800458 <_main+0x420>
  800444:	83 ec 04             	sub    $0x4,%esp
  800447:	68 20 31 80 00       	push   $0x803120
  80044c:	6a 61                	push   $0x61
  80044e:	68 0a 31 80 00       	push   $0x80310a
  800453:	e8 2a 11 00 00       	call   801582 <_panic>
			}
		}

		//Reading (Not Modified)
		char garbage1 = arr[PAGE_SIZE*10-1] ;
  800458:	a0 3f e0 80 00       	mov    0x80e03f,%al
  80045d:	88 85 73 ff ff ff    	mov    %al,-0x8d(%ebp)
		char garbage2 = arr[PAGE_SIZE*11-1] ;
  800463:	a0 3f f0 80 00       	mov    0x80f03f,%al
  800468:	88 85 72 ff ff ff    	mov    %al,-0x8e(%ebp)
		char garbage3 = arr[PAGE_SIZE*12-1] ;
  80046e:	a0 3f 00 81 00       	mov    0x81003f,%al
  800473:	88 85 71 ff ff ff    	mov    %al,-0x8f(%ebp)

		char garbage4, garbage5 ;
		//Writing (Modified)
		int i ;
		for (i = 0 ; i < PAGE_SIZE*4 ; i+=PAGE_SIZE/2)
  800479:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  800480:	eb 26                	jmp    8004a8 <_main+0x470>
		{
			arr[i] = -1 ;
  800482:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800485:	05 40 40 80 00       	add    $0x804040,%eax
  80048a:	c6 00 ff             	movb   $0xff,(%eax)
			//always use pages at 0x801000 and 0x804000
			garbage4 = *ptr ;
  80048d:	a1 00 40 80 00       	mov    0x804000,%eax
  800492:	8a 00                	mov    (%eax),%al
  800494:	88 45 db             	mov    %al,-0x25(%ebp)
			garbage5 = *ptr2 ;
  800497:	a1 04 40 80 00       	mov    0x804004,%eax
  80049c:	8a 00                	mov    (%eax),%al
  80049e:	88 45 da             	mov    %al,-0x26(%ebp)
		char garbage3 = arr[PAGE_SIZE*12-1] ;

		char garbage4, garbage5 ;
		//Writing (Modified)
		int i ;
		for (i = 0 ; i < PAGE_SIZE*4 ; i+=PAGE_SIZE/2)
  8004a1:	81 45 d4 00 08 00 00 	addl   $0x800,-0x2c(%ebp)
  8004a8:	81 7d d4 ff 3f 00 00 	cmpl   $0x3fff,-0x2c(%ebp)
  8004af:	7e d1                	jle    800482 <_main+0x44a>

		//===================

		//CASE1: free the exited env only
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
  8004b1:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  8004b5:	74 0a                	je     8004c1 <_main+0x489>
  8004b7:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8004bb:	0f 85 92 00 00 00    	jne    800553 <_main+0x51b>
		{
			int i = 0;
  8004c1:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
			numOfExistPages = 0;
  8004c8:	c7 05 40 00 81 00 00 	movl   $0x0,0x810040
  8004cf:	00 00 00 
			for (i = 0; i < myEnv->page_WS_max_size; ++i)
  8004d2:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  8004d9:	eb 64                	jmp    80053f <_main+0x507>
			{
				if (!myEnv->__uptr_pws[i].empty)
  8004db:	a1 20 40 80 00       	mov    0x804020,%eax
  8004e0:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004e6:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8004e9:	89 d0                	mov    %edx,%eax
  8004eb:	01 c0                	add    %eax,%eax
  8004ed:	01 d0                	add    %edx,%eax
  8004ef:	c1 e0 02             	shl    $0x2,%eax
  8004f2:	01 c8                	add    %ecx,%eax
  8004f4:	8a 40 04             	mov    0x4(%eax),%al
  8004f7:	84 c0                	test   %al,%al
  8004f9:	75 41                	jne    80053c <_main+0x504>
				{
					WSEntries_before[numOfExistPages++] = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address, PAGE_SIZE);
  8004fb:	8b 15 40 00 81 00    	mov    0x810040,%edx
  800501:	8d 42 01             	lea    0x1(%edx),%eax
  800504:	a3 40 00 81 00       	mov    %eax,0x810040
  800509:	a1 20 40 80 00       	mov    0x804020,%eax
  80050e:	8b 98 34 03 00 00    	mov    0x334(%eax),%ebx
  800514:	8b 4d d0             	mov    -0x30(%ebp),%ecx
  800517:	89 c8                	mov    %ecx,%eax
  800519:	01 c0                	add    %eax,%eax
  80051b:	01 c8                	add    %ecx,%eax
  80051d:	c1 e0 02             	shl    $0x2,%eax
  800520:	01 d8                	add    %ebx,%eax
  800522:	8b 00                	mov    (%eax),%eax
  800524:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  80052a:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800530:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800535:	89 04 95 60 00 81 00 	mov    %eax,0x810060(,%edx,4)
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
		{
			int i = 0;
			numOfExistPages = 0;
			for (i = 0; i < myEnv->page_WS_max_size; ++i)
  80053c:	ff 45 d0             	incl   -0x30(%ebp)
  80053f:	a1 20 40 80 00       	mov    0x804020,%eax
  800544:	8b 50 74             	mov    0x74(%eax),%edx
  800547:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80054a:	39 c2                	cmp    %eax,%edx
  80054c:	77 8d                	ja     8004db <_main+0x4a3>
		//===================

		//CASE1: free the exited env only
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
		{
  80054e:	e9 a4 02 00 00       	jmp    8007f7 <_main+0x7bf>
				if(myEnv->page_last_WS_index != 9) panic("wrong PAGE WS pointer location");
			}
		}
		 */
		//CASE2: free the WS ONLY using FIFO algorithm
		else if (testCase == 2)
  800553:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  800557:	0f 85 9a 02 00 00    	jne    8007f7 <_main+0x7bf>
		{
			//cprintf("Checking PAGE FIFO algorithm... \n");
			{
				if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80055d:	a1 20 40 80 00       	mov    0x804020,%eax
  800562:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800568:	8b 00                	mov    (%eax),%eax
  80056a:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  800570:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800576:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80057b:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800580:	74 17                	je     800599 <_main+0x561>
  800582:	83 ec 04             	sub    $0x4,%esp
  800585:	68 78 31 80 00       	push   $0x803178
  80058a:	68 9e 00 00 00       	push   $0x9e
  80058f:	68 0a 31 80 00       	push   $0x80310a
  800594:	e8 e9 0f 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80e000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800599:	a1 20 40 80 00       	mov    0x804020,%eax
  80059e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8005a4:	83 c0 0c             	add    $0xc,%eax
  8005a7:	8b 00                	mov    (%eax),%eax
  8005a9:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  8005af:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  8005b5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005ba:	3d 00 e0 80 00       	cmp    $0x80e000,%eax
  8005bf:	74 17                	je     8005d8 <_main+0x5a0>
  8005c1:	83 ec 04             	sub    $0x4,%esp
  8005c4:	68 78 31 80 00       	push   $0x803178
  8005c9:	68 9f 00 00 00       	push   $0x9f
  8005ce:	68 0a 31 80 00       	push   $0x80310a
  8005d3:	e8 aa 0f 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x80f000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8005d8:	a1 20 40 80 00       	mov    0x804020,%eax
  8005dd:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8005e3:	83 c0 18             	add    $0x18,%eax
  8005e6:	8b 00                	mov    (%eax),%eax
  8005e8:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  8005ee:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  8005f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005f9:	3d 00 f0 80 00       	cmp    $0x80f000,%eax
  8005fe:	74 17                	je     800617 <_main+0x5df>
  800600:	83 ec 04             	sub    $0x4,%esp
  800603:	68 78 31 80 00       	push   $0x803178
  800608:	68 a0 00 00 00       	push   $0xa0
  80060d:	68 0a 31 80 00       	push   $0x80310a
  800612:	e8 6b 0f 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x810000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800617:	a1 20 40 80 00       	mov    0x804020,%eax
  80061c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800622:	83 c0 24             	add    $0x24,%eax
  800625:	8b 00                	mov    (%eax),%eax
  800627:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  80062d:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800633:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800638:	3d 00 00 81 00       	cmp    $0x810000,%eax
  80063d:	74 17                	je     800656 <_main+0x61e>
  80063f:	83 ec 04             	sub    $0x4,%esp
  800642:	68 78 31 80 00       	push   $0x803178
  800647:	68 a1 00 00 00       	push   $0xa1
  80064c:	68 0a 31 80 00       	push   $0x80310a
  800651:	e8 2c 0f 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x805000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800656:	a1 20 40 80 00       	mov    0x804020,%eax
  80065b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800661:	83 c0 30             	add    $0x30,%eax
  800664:	8b 00                	mov    (%eax),%eax
  800666:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  80066c:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800672:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800677:	3d 00 50 80 00       	cmp    $0x805000,%eax
  80067c:	74 17                	je     800695 <_main+0x65d>
  80067e:	83 ec 04             	sub    $0x4,%esp
  800681:	68 78 31 80 00       	push   $0x803178
  800686:	68 a2 00 00 00       	push   $0xa2
  80068b:	68 0a 31 80 00       	push   $0x80310a
  800690:	e8 ed 0e 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x806000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800695:	a1 20 40 80 00       	mov    0x804020,%eax
  80069a:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8006a0:	83 c0 3c             	add    $0x3c,%eax
  8006a3:	8b 00                	mov    (%eax),%eax
  8006a5:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  8006ab:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  8006b1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006b6:	3d 00 60 80 00       	cmp    $0x806000,%eax
  8006bb:	74 17                	je     8006d4 <_main+0x69c>
  8006bd:	83 ec 04             	sub    $0x4,%esp
  8006c0:	68 78 31 80 00       	push   $0x803178
  8006c5:	68 a3 00 00 00       	push   $0xa3
  8006ca:	68 0a 31 80 00       	push   $0x80310a
  8006cf:	e8 ae 0e 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x807000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8006d4:	a1 20 40 80 00       	mov    0x804020,%eax
  8006d9:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8006df:	83 c0 48             	add    $0x48,%eax
  8006e2:	8b 00                	mov    (%eax),%eax
  8006e4:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  8006ea:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  8006f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006f5:	3d 00 70 80 00       	cmp    $0x807000,%eax
  8006fa:	74 17                	je     800713 <_main+0x6db>
  8006fc:	83 ec 04             	sub    $0x4,%esp
  8006ff:	68 78 31 80 00       	push   $0x803178
  800704:	68 a4 00 00 00       	push   $0xa4
  800709:	68 0a 31 80 00       	push   $0x80310a
  80070e:	e8 6f 0e 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800713:	a1 20 40 80 00       	mov    0x804020,%eax
  800718:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80071e:	83 c0 54             	add    $0x54,%eax
  800721:	8b 00                	mov    (%eax),%eax
  800723:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800729:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  80072f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800734:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800739:	74 17                	je     800752 <_main+0x71a>
  80073b:	83 ec 04             	sub    $0x4,%esp
  80073e:	68 78 31 80 00       	push   $0x803178
  800743:	68 a5 00 00 00       	push   $0xa5
  800748:	68 0a 31 80 00       	push   $0x80310a
  80074d:	e8 30 0e 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800752:	a1 20 40 80 00       	mov    0x804020,%eax
  800757:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80075d:	83 c0 60             	add    $0x60,%eax
  800760:	8b 00                	mov    (%eax),%eax
  800762:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800768:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  80076e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800773:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800778:	74 17                	je     800791 <_main+0x759>
  80077a:	83 ec 04             	sub    $0x4,%esp
  80077d:	68 78 31 80 00       	push   $0x803178
  800782:	68 a6 00 00 00       	push   $0xa6
  800787:	68 0a 31 80 00       	push   $0x80310a
  80078c:	e8 f1 0d 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800791:	a1 20 40 80 00       	mov    0x804020,%eax
  800796:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80079c:	83 c0 6c             	add    $0x6c,%eax
  80079f:	8b 00                	mov    (%eax),%eax
  8007a1:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  8007a7:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  8007ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007b2:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8007b7:	74 17                	je     8007d0 <_main+0x798>
  8007b9:	83 ec 04             	sub    $0x4,%esp
  8007bc:	68 78 31 80 00       	push   $0x803178
  8007c1:	68 a7 00 00 00       	push   $0xa7
  8007c6:	68 0a 31 80 00       	push   $0x80310a
  8007cb:	e8 b2 0d 00 00       	call   801582 <_panic>

				if(myEnv->page_last_WS_index != 9) panic("wrong PAGE WS pointer location");
  8007d0:	a1 20 40 80 00       	mov    0x804020,%eax
  8007d5:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  8007db:	83 f8 09             	cmp    $0x9,%eax
  8007de:	74 17                	je     8007f7 <_main+0x7bf>
  8007e0:	83 ec 04             	sub    $0x4,%esp
  8007e3:	68 c4 31 80 00       	push   $0x8031c4
  8007e8:	68 a9 00 00 00       	push   $0xa9
  8007ed:	68 0a 31 80 00       	push   $0x80310a
  8007f2:	e8 8b 0d 00 00       	call   801582 <_panic>
			}
		}

		//=========================================================//
		//Clear the FFL
		sys_clear_ffl();
  8007f7:	e8 5a 20 00 00       	call   802856 <sys_clear_ffl>
		//=========================================================//

		//Writing (Modified) after freeing the entire FFL:
		//	3 frames should be allocated (stack page, mem table, page file table)
		*ptr3 = garbage1 ;
  8007fc:	a1 08 40 80 00       	mov    0x804008,%eax
  800801:	8a 95 73 ff ff ff    	mov    -0x8d(%ebp),%dl
  800807:	88 10                	mov    %dl,(%eax)
		//always use pages at 0x801000 and 0x804000
		garbage4 = *ptr ;
  800809:	a1 00 40 80 00       	mov    0x804000,%eax
  80080e:	8a 00                	mov    (%eax),%al
  800810:	88 45 db             	mov    %al,-0x25(%ebp)
		garbage5 = *ptr2 ;
  800813:	a1 04 40 80 00       	mov    0x804004,%eax
  800818:	8a 00                	mov    (%eax),%al
  80081a:	88 45 da             	mov    %al,-0x26(%ebp)

		//CASE1: free the exited env's ONLY
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
  80081d:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  800821:	74 0a                	je     80082d <_main+0x7f5>
  800823:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800827:	0f 85 99 00 00 00    	jne    8008c6 <_main+0x88e>
		{
			//Add the last reference to our WS
			WSEntries_before[numOfExistPages++] = ROUNDDOWN((uint32)(ptr3), PAGE_SIZE);
  80082d:	a1 40 00 81 00       	mov    0x810040,%eax
  800832:	8d 50 01             	lea    0x1(%eax),%edx
  800835:	89 15 40 00 81 00    	mov    %edx,0x810040
  80083b:	8b 15 08 40 80 00    	mov    0x804008,%edx
  800841:	89 95 3c ff ff ff    	mov    %edx,-0xc4(%ebp)
  800847:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
  80084d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  800853:	89 14 85 60 00 81 00 	mov    %edx,0x810060(,%eax,4)

			//Make sure that WS is not affected
			for (i = 0; i < numOfExistPages; ++i)
  80085a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  800861:	eb 54                	jmp    8008b7 <_main+0x87f>
			{
				if (WSEntries_before[i] != ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address, PAGE_SIZE))
  800863:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800866:	8b 0c 85 60 00 81 00 	mov    0x810060(,%eax,4),%ecx
  80086d:	a1 20 40 80 00       	mov    0x804020,%eax
  800872:	8b 98 34 03 00 00    	mov    0x334(%eax),%ebx
  800878:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80087b:	89 d0                	mov    %edx,%eax
  80087d:	01 c0                	add    %eax,%eax
  80087f:	01 d0                	add    %edx,%eax
  800881:	c1 e0 02             	shl    $0x2,%eax
  800884:	01 d8                	add    %ebx,%eax
  800886:	8b 00                	mov    (%eax),%eax
  800888:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
  80088e:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800894:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800899:	39 c1                	cmp    %eax,%ecx
  80089b:	74 17                	je     8008b4 <_main+0x87c>
					panic("FreeRAM.Scenario1 or 3: WS is changed while not expected to!");
  80089d:	83 ec 04             	sub    $0x4,%esp
  8008a0:	68 e4 31 80 00       	push   $0x8031e4
  8008a5:	68 c4 00 00 00       	push   $0xc4
  8008aa:	68 0a 31 80 00       	push   $0x80310a
  8008af:	e8 ce 0c 00 00       	call   801582 <_panic>
		{
			//Add the last reference to our WS
			WSEntries_before[numOfExistPages++] = ROUNDDOWN((uint32)(ptr3), PAGE_SIZE);

			//Make sure that WS is not affected
			for (i = 0; i < numOfExistPages; ++i)
  8008b4:	ff 45 d4             	incl   -0x2c(%ebp)
  8008b7:	a1 40 00 81 00       	mov    0x810040,%eax
  8008bc:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  8008bf:	7c a2                	jl     800863 <_main+0x82b>
		garbage4 = *ptr ;
		garbage5 = *ptr2 ;

		//CASE1: free the exited env's ONLY
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
  8008c1:	e9 45 01 00 00       	jmp    800a0b <_main+0x9d3>
				if (WSEntries_before[i] != ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address, PAGE_SIZE))
					panic("FreeRAM.Scenario1 or 3: WS is changed while not expected to!");
			}
		}
		//Case2: free the WS ONLY by clock algorithm
		else if (testCase == 2)
  8008c6:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  8008ca:	0f 85 3b 01 00 00    	jne    800a0b <_main+0x9d3>
			}
			 */

			//Check the WS after FIFO algorithm

			if (garbage4 != *ptr || garbage5 != *ptr2) panic("test failed!");
  8008d0:	a1 00 40 80 00       	mov    0x804000,%eax
  8008d5:	8a 00                	mov    (%eax),%al
  8008d7:	3a 45 db             	cmp    -0x25(%ebp),%al
  8008da:	75 0c                	jne    8008e8 <_main+0x8b0>
  8008dc:	a1 04 40 80 00       	mov    0x804004,%eax
  8008e1:	8a 00                	mov    (%eax),%al
  8008e3:	3a 45 da             	cmp    -0x26(%ebp),%al
  8008e6:	74 17                	je     8008ff <_main+0x8c7>
  8008e8:	83 ec 04             	sub    $0x4,%esp
  8008eb:	68 21 32 80 00       	push   $0x803221
  8008f0:	68 d7 00 00 00       	push   $0xd7
  8008f5:	68 0a 31 80 00       	push   $0x80310a
  8008fa:	e8 83 0c 00 00       	call   801582 <_panic>

			//There should be two empty locations that are freed for the two tables (mem table and page file table)
			int numOfEmptyLocs = 0 ;
  8008ff:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  800906:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  80090d:	eb 26                	jmp    800935 <_main+0x8fd>
			{
				if (myEnv->__uptr_pws[i].empty)
  80090f:	a1 20 40 80 00       	mov    0x804020,%eax
  800914:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80091a:	8b 55 c8             	mov    -0x38(%ebp),%edx
  80091d:	89 d0                	mov    %edx,%eax
  80091f:	01 c0                	add    %eax,%eax
  800921:	01 d0                	add    %edx,%eax
  800923:	c1 e0 02             	shl    $0x2,%eax
  800926:	01 c8                	add    %ecx,%eax
  800928:	8a 40 04             	mov    0x4(%eax),%al
  80092b:	84 c0                	test   %al,%al
  80092d:	74 03                	je     800932 <_main+0x8fa>
					numOfEmptyLocs++ ;
  80092f:	ff 45 cc             	incl   -0x34(%ebp)

			if (garbage4 != *ptr || garbage5 != *ptr2) panic("test failed!");

			//There should be two empty locations that are freed for the two tables (mem table and page file table)
			int numOfEmptyLocs = 0 ;
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  800932:	ff 45 c8             	incl   -0x38(%ebp)
  800935:	a1 20 40 80 00       	mov    0x804020,%eax
  80093a:	8b 50 74             	mov    0x74(%eax),%edx
  80093d:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800940:	39 c2                	cmp    %eax,%edx
  800942:	77 cb                	ja     80090f <_main+0x8d7>
			{
				if (myEnv->__uptr_pws[i].empty)
					numOfEmptyLocs++ ;
			}
			if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");
  800944:	83 7d cc 02          	cmpl   $0x2,-0x34(%ebp)
  800948:	74 17                	je     800961 <_main+0x929>
  80094a:	83 ec 04             	sub    $0x4,%esp
  80094d:	68 30 32 80 00       	push   $0x803230
  800952:	68 e0 00 00 00       	push   $0xe0
  800957:	68 0a 31 80 00       	push   $0x80310a
  80095c:	e8 21 0c 00 00       	call   801582 <_panic>

			uint32 expectedAddresses[8] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x807000,0xee7fe000,0xeebfd000} ;
  800961:	8d 85 6c fe ff ff    	lea    -0x194(%ebp),%eax
  800967:	bb 40 33 80 00       	mov    $0x803340,%ebx
  80096c:	ba 08 00 00 00       	mov    $0x8,%edx
  800971:	89 c7                	mov    %eax,%edi
  800973:	89 de                	mov    %ebx,%esi
  800975:	89 d1                	mov    %edx,%ecx
  800977:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
			int numOfFoundedAddresses = 0;
  800979:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
			for (int j = 0; j < 8; j++)
  800980:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
  800987:	eb 5f                	jmp    8009e8 <_main+0x9b0>
			{
				for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  800989:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  800990:	eb 44                	jmp    8009d6 <_main+0x99e>
				{
					if (ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == expectedAddresses[j])
  800992:	a1 20 40 80 00       	mov    0x804020,%eax
  800997:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80099d:	8b 55 bc             	mov    -0x44(%ebp),%edx
  8009a0:	89 d0                	mov    %edx,%eax
  8009a2:	01 c0                	add    %eax,%eax
  8009a4:	01 d0                	add    %edx,%eax
  8009a6:	c1 e0 02             	shl    $0x2,%eax
  8009a9:	01 c8                	add    %ecx,%eax
  8009ab:	8b 00                	mov    (%eax),%eax
  8009ad:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  8009b3:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  8009b9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009be:	89 c2                	mov    %eax,%edx
  8009c0:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8009c3:	8b 84 85 6c fe ff ff 	mov    -0x194(%ebp,%eax,4),%eax
  8009ca:	39 c2                	cmp    %eax,%edx
  8009cc:	75 05                	jne    8009d3 <_main+0x99b>
					{
						numOfFoundedAddresses++;
  8009ce:	ff 45 c4             	incl   -0x3c(%ebp)
						break;
  8009d1:	eb 12                	jmp    8009e5 <_main+0x9ad>

			uint32 expectedAddresses[8] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x807000,0xee7fe000,0xeebfd000} ;
			int numOfFoundedAddresses = 0;
			for (int j = 0; j < 8; j++)
			{
				for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8009d3:	ff 45 bc             	incl   -0x44(%ebp)
  8009d6:	a1 20 40 80 00       	mov    0x804020,%eax
  8009db:	8b 50 74             	mov    0x74(%eax),%edx
  8009de:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8009e1:	39 c2                	cmp    %eax,%edx
  8009e3:	77 ad                	ja     800992 <_main+0x95a>
			}
			if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");

			uint32 expectedAddresses[8] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x807000,0xee7fe000,0xeebfd000} ;
			int numOfFoundedAddresses = 0;
			for (int j = 0; j < 8; j++)
  8009e5:	ff 45 c0             	incl   -0x40(%ebp)
  8009e8:	83 7d c0 07          	cmpl   $0x7,-0x40(%ebp)
  8009ec:	7e 9b                	jle    800989 <_main+0x951>
						numOfFoundedAddresses++;
						break;
					}
				}
			}
			if (numOfFoundedAddresses != 8) panic("test failed! either wrong victim or victim is not removed from WS");
  8009ee:	83 7d c4 08          	cmpl   $0x8,-0x3c(%ebp)
  8009f2:	74 17                	je     800a0b <_main+0x9d3>
  8009f4:	83 ec 04             	sub    $0x4,%esp
  8009f7:	68 30 32 80 00       	push   $0x803230
  8009fc:	68 ef 00 00 00       	push   $0xef
  800a01:	68 0a 31 80 00       	push   $0x80310a
  800a06:	e8 77 0b 00 00       	call   801582 <_panic>

		}


		//Case1: free the exited env's ONLY
		if (testCase ==1)
  800a0b:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  800a0f:	0f 85 81 00 00 00    	jne    800a96 <_main+0xa5e>
		{
			cprintf("running fos_helloWorld program...\n\n");
  800a15:	83 ec 0c             	sub    $0xc,%esp
  800a18:	68 74 32 80 00       	push   $0x803274
  800a1d:	e8 14 0e 00 00       	call   801836 <cprintf>
  800a22:	83 c4 10             	add    $0x10,%esp
			sys_run_env(envIdHelloWorld);
  800a25:	83 ec 0c             	sub    $0xc,%esp
  800a28:	ff 75 dc             	pushl  -0x24(%ebp)
  800a2b:	e8 6e 1f 00 00       	call   80299e <sys_run_env>
  800a30:	83 c4 10             	add    $0x10,%esp
			cprintf("please be patient ...\n");
  800a33:	83 ec 0c             	sub    $0xc,%esp
  800a36:	68 a1 30 80 00       	push   $0x8030a1
  800a3b:	e8 f6 0d 00 00       	call   801836 <cprintf>
  800a40:	83 c4 10             	add    $0x10,%esp
			env_sleep(3000);
  800a43:	83 ec 0c             	sub    $0xc,%esp
  800a46:	68 b8 0b 00 00       	push   $0xbb8
  800a4b:	e8 8a 21 00 00       	call   802bda <env_sleep>
  800a50:	83 c4 10             	add    $0x10,%esp

			cprintf("running fos_fib program...\n\n");
  800a53:	83 ec 0c             	sub    $0xc,%esp
  800a56:	68 98 32 80 00       	push   $0x803298
  800a5b:	e8 d6 0d 00 00       	call   801836 <cprintf>
  800a60:	83 c4 10             	add    $0x10,%esp
			sys_run_env(envIdFib);
  800a63:	83 ec 0c             	sub    $0xc,%esp
  800a66:	ff 75 e0             	pushl  -0x20(%ebp)
  800a69:	e8 30 1f 00 00       	call   80299e <sys_run_env>
  800a6e:	83 c4 10             	add    $0x10,%esp
			cprintf("please be patient ...\n");
  800a71:	83 ec 0c             	sub    $0xc,%esp
  800a74:	68 a1 30 80 00       	push   $0x8030a1
  800a79:	e8 b8 0d 00 00       	call   801836 <cprintf>
  800a7e:	83 c4 10             	add    $0x10,%esp
			env_sleep(5000);
  800a81:	83 ec 0c             	sub    $0xc,%esp
  800a84:	68 88 13 00 00       	push   $0x1388
  800a89:	e8 4c 21 00 00       	call   802bda <env_sleep>
  800a8e:	83 c4 10             	add    $0x10,%esp
  800a91:	e9 56 08 00 00       	jmp    8012ec <_main+0x12b4>
		}
		//CASE3: free BOTH exited env's and WS
		else if (testCase ==3)
  800a96:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800a9a:	0f 85 4c 08 00 00    	jne    8012ec <_main+0x12b4>
				if( ROUNDDOWN(myEnv->__uptr_pws[24].virtual_address,PAGE_SIZE) !=   0xee7fe000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
				if( myEnv->page_last_WS_index !=  0)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
			}
			 */

			cprintf("Checking PAGE FIFO algorithm... \n");
  800aa0:	83 ec 0c             	sub    $0xc,%esp
  800aa3:	68 b8 32 80 00       	push   $0x8032b8
  800aa8:	e8 89 0d 00 00       	call   801836 <cprintf>
  800aad:	83 c4 10             	add    $0x10,%esp
			{
				if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800ab0:	a1 20 40 80 00       	mov    0x804020,%eax
  800ab5:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800abb:	8b 00                	mov    (%eax),%eax
  800abd:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800ac3:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800ac9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ace:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800ad3:	74 17                	je     800aec <_main+0xab4>
  800ad5:	83 ec 04             	sub    $0x4,%esp
  800ad8:	68 b8 30 80 00       	push   $0x8030b8
  800add:	68 25 01 00 00       	push   $0x125
  800ae2:	68 0a 31 80 00       	push   $0x80310a
  800ae7:	e8 96 0a 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800aec:	a1 20 40 80 00       	mov    0x804020,%eax
  800af1:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800af7:	83 c0 0c             	add    $0xc,%eax
  800afa:	8b 00                	mov    (%eax),%eax
  800afc:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800b02:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800b08:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b0d:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800b12:	74 17                	je     800b2b <_main+0xaf3>
  800b14:	83 ec 04             	sub    $0x4,%esp
  800b17:	68 b8 30 80 00       	push   $0x8030b8
  800b1c:	68 26 01 00 00       	push   $0x126
  800b21:	68 0a 31 80 00       	push   $0x80310a
  800b26:	e8 57 0a 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800b2b:	a1 20 40 80 00       	mov    0x804020,%eax
  800b30:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800b36:	83 c0 18             	add    $0x18,%eax
  800b39:	8b 00                	mov    (%eax),%eax
  800b3b:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800b41:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800b47:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b4c:	3d 00 20 20 00       	cmp    $0x202000,%eax
  800b51:	74 17                	je     800b6a <_main+0xb32>
  800b53:	83 ec 04             	sub    $0x4,%esp
  800b56:	68 b8 30 80 00       	push   $0x8030b8
  800b5b:	68 27 01 00 00       	push   $0x127
  800b60:	68 0a 31 80 00       	push   $0x80310a
  800b65:	e8 18 0a 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800b6a:	a1 20 40 80 00       	mov    0x804020,%eax
  800b6f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800b75:	83 c0 24             	add    $0x24,%eax
  800b78:	8b 00                	mov    (%eax),%eax
  800b7a:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  800b80:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  800b86:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b8b:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800b90:	74 17                	je     800ba9 <_main+0xb71>
  800b92:	83 ec 04             	sub    $0x4,%esp
  800b95:	68 b8 30 80 00       	push   $0x8030b8
  800b9a:	68 28 01 00 00       	push   $0x128
  800b9f:	68 0a 31 80 00       	push   $0x80310a
  800ba4:	e8 d9 09 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800ba9:	a1 20 40 80 00       	mov    0x804020,%eax
  800bae:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800bb4:	83 c0 30             	add    $0x30,%eax
  800bb7:	8b 00                	mov    (%eax),%eax
  800bb9:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
  800bbf:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  800bc5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bca:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800bcf:	74 17                	je     800be8 <_main+0xbb0>
  800bd1:	83 ec 04             	sub    $0x4,%esp
  800bd4:	68 b8 30 80 00       	push   $0x8030b8
  800bd9:	68 29 01 00 00       	push   $0x129
  800bde:	68 0a 31 80 00       	push   $0x80310a
  800be3:	e8 9a 09 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800be8:	a1 20 40 80 00       	mov    0x804020,%eax
  800bed:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800bf3:	83 c0 3c             	add    $0x3c,%eax
  800bf6:	8b 00                	mov    (%eax),%eax
  800bf8:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
  800bfe:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800c04:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c09:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800c0e:	74 17                	je     800c27 <_main+0xbef>
  800c10:	83 ec 04             	sub    $0x4,%esp
  800c13:	68 b8 30 80 00       	push   $0x8030b8
  800c18:	68 2a 01 00 00       	push   $0x12a
  800c1d:	68 0a 31 80 00       	push   $0x80310a
  800c22:	e8 5b 09 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800c27:	a1 20 40 80 00       	mov    0x804020,%eax
  800c2c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800c32:	83 c0 48             	add    $0x48,%eax
  800c35:	8b 00                	mov    (%eax),%eax
  800c37:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
  800c3d:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
  800c43:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c48:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800c4d:	74 17                	je     800c66 <_main+0xc2e>
  800c4f:	83 ec 04             	sub    $0x4,%esp
  800c52:	68 b8 30 80 00       	push   $0x8030b8
  800c57:	68 2b 01 00 00       	push   $0x12b
  800c5c:	68 0a 31 80 00       	push   $0x80310a
  800c61:	e8 1c 09 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800c66:	a1 20 40 80 00       	mov    0x804020,%eax
  800c6b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800c71:	83 c0 54             	add    $0x54,%eax
  800c74:	8b 00                	mov    (%eax),%eax
  800c76:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
  800c7c:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  800c82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c87:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800c8c:	74 17                	je     800ca5 <_main+0xc6d>
  800c8e:	83 ec 04             	sub    $0x4,%esp
  800c91:	68 b8 30 80 00       	push   $0x8030b8
  800c96:	68 2c 01 00 00       	push   $0x12c
  800c9b:	68 0a 31 80 00       	push   $0x80310a
  800ca0:	e8 dd 08 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800ca5:	a1 20 40 80 00       	mov    0x804020,%eax
  800caa:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800cb0:	83 c0 60             	add    $0x60,%eax
  800cb3:	8b 00                	mov    (%eax),%eax
  800cb5:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  800cbb:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
  800cc1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800cc6:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800ccb:	74 17                	je     800ce4 <_main+0xcac>
  800ccd:	83 ec 04             	sub    $0x4,%esp
  800cd0:	68 b8 30 80 00       	push   $0x8030b8
  800cd5:	68 2d 01 00 00       	push   $0x12d
  800cda:	68 0a 31 80 00       	push   $0x80310a
  800cdf:	e8 9e 08 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800ce4:	a1 20 40 80 00       	mov    0x804020,%eax
  800ce9:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800cef:	83 c0 6c             	add    $0x6c,%eax
  800cf2:	8b 00                	mov    (%eax),%eax
  800cf4:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
  800cfa:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  800d00:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d05:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800d0a:	74 17                	je     800d23 <_main+0xceb>
  800d0c:	83 ec 04             	sub    $0x4,%esp
  800d0f:	68 b8 30 80 00       	push   $0x8030b8
  800d14:	68 2e 01 00 00       	push   $0x12e
  800d19:	68 0a 31 80 00       	push   $0x80310a
  800d1e:	e8 5f 08 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x804000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800d23:	a1 20 40 80 00       	mov    0x804020,%eax
  800d28:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800d2e:	83 c0 78             	add    $0x78,%eax
  800d31:	8b 00                	mov    (%eax),%eax
  800d33:	89 85 0c ff ff ff    	mov    %eax,-0xf4(%ebp)
  800d39:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  800d3f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d44:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800d49:	74 17                	je     800d62 <_main+0xd2a>
  800d4b:	83 ec 04             	sub    $0x4,%esp
  800d4e:	68 b8 30 80 00       	push   $0x8030b8
  800d53:	68 2f 01 00 00       	push   $0x12f
  800d58:	68 0a 31 80 00       	push   $0x80310a
  800d5d:	e8 20 08 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0x805000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800d62:	a1 20 40 80 00       	mov    0x804020,%eax
  800d67:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800d6d:	05 84 00 00 00       	add    $0x84,%eax
  800d72:	8b 00                	mov    (%eax),%eax
  800d74:	89 85 08 ff ff ff    	mov    %eax,-0xf8(%ebp)
  800d7a:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
  800d80:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d85:	3d 00 50 80 00       	cmp    $0x805000,%eax
  800d8a:	74 17                	je     800da3 <_main+0xd6b>
  800d8c:	83 ec 04             	sub    $0x4,%esp
  800d8f:	68 b8 30 80 00       	push   $0x8030b8
  800d94:	68 30 01 00 00       	push   $0x130
  800d99:	68 0a 31 80 00       	push   $0x80310a
  800d9e:	e8 df 07 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[12].virtual_address,PAGE_SIZE) !=   0x806000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800da3:	a1 20 40 80 00       	mov    0x804020,%eax
  800da8:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800dae:	05 90 00 00 00       	add    $0x90,%eax
  800db3:	8b 00                	mov    (%eax),%eax
  800db5:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
  800dbb:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
  800dc1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dc6:	3d 00 60 80 00       	cmp    $0x806000,%eax
  800dcb:	74 17                	je     800de4 <_main+0xdac>
  800dcd:	83 ec 04             	sub    $0x4,%esp
  800dd0:	68 b8 30 80 00       	push   $0x8030b8
  800dd5:	68 31 01 00 00       	push   $0x131
  800dda:	68 0a 31 80 00       	push   $0x80310a
  800ddf:	e8 9e 07 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[13].virtual_address,PAGE_SIZE) !=   0x807000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800de4:	a1 20 40 80 00       	mov    0x804020,%eax
  800de9:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800def:	05 9c 00 00 00       	add    $0x9c,%eax
  800df4:	8b 00                	mov    (%eax),%eax
  800df6:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
  800dfc:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
  800e02:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e07:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800e0c:	74 17                	je     800e25 <_main+0xded>
  800e0e:	83 ec 04             	sub    $0x4,%esp
  800e11:	68 b8 30 80 00       	push   $0x8030b8
  800e16:	68 32 01 00 00       	push   $0x132
  800e1b:	68 0a 31 80 00       	push   $0x80310a
  800e20:	e8 5d 07 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[14].virtual_address,PAGE_SIZE) !=   0x808000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800e25:	a1 20 40 80 00       	mov    0x804020,%eax
  800e2a:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800e30:	05 a8 00 00 00       	add    $0xa8,%eax
  800e35:	8b 00                	mov    (%eax),%eax
  800e37:	89 85 fc fe ff ff    	mov    %eax,-0x104(%ebp)
  800e3d:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
  800e43:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e48:	3d 00 80 80 00       	cmp    $0x808000,%eax
  800e4d:	74 17                	je     800e66 <_main+0xe2e>
  800e4f:	83 ec 04             	sub    $0x4,%esp
  800e52:	68 b8 30 80 00       	push   $0x8030b8
  800e57:	68 33 01 00 00       	push   $0x133
  800e5c:	68 0a 31 80 00       	push   $0x80310a
  800e61:	e8 1c 07 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=   0x809000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800e66:	a1 20 40 80 00       	mov    0x804020,%eax
  800e6b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800e71:	05 b4 00 00 00       	add    $0xb4,%eax
  800e76:	8b 00                	mov    (%eax),%eax
  800e78:	89 85 f8 fe ff ff    	mov    %eax,-0x108(%ebp)
  800e7e:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  800e84:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e89:	3d 00 90 80 00       	cmp    $0x809000,%eax
  800e8e:	74 17                	je     800ea7 <_main+0xe6f>
  800e90:	83 ec 04             	sub    $0x4,%esp
  800e93:	68 b8 30 80 00       	push   $0x8030b8
  800e98:	68 34 01 00 00       	push   $0x134
  800e9d:	68 0a 31 80 00       	push   $0x80310a
  800ea2:	e8 db 06 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[16].virtual_address,PAGE_SIZE) !=   0x80A000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800ea7:	a1 20 40 80 00       	mov    0x804020,%eax
  800eac:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800eb2:	05 c0 00 00 00       	add    $0xc0,%eax
  800eb7:	8b 00                	mov    (%eax),%eax
  800eb9:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
  800ebf:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  800ec5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800eca:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  800ecf:	74 17                	je     800ee8 <_main+0xeb0>
  800ed1:	83 ec 04             	sub    $0x4,%esp
  800ed4:	68 b8 30 80 00       	push   $0x8030b8
  800ed9:	68 35 01 00 00       	push   $0x135
  800ede:	68 0a 31 80 00       	push   $0x80310a
  800ee3:	e8 9a 06 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[17].virtual_address,PAGE_SIZE) !=   0x80B000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800ee8:	a1 20 40 80 00       	mov    0x804020,%eax
  800eed:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800ef3:	05 cc 00 00 00       	add    $0xcc,%eax
  800ef8:	8b 00                	mov    (%eax),%eax
  800efa:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
  800f00:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  800f06:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f0b:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  800f10:	74 17                	je     800f29 <_main+0xef1>
  800f12:	83 ec 04             	sub    $0x4,%esp
  800f15:	68 b8 30 80 00       	push   $0x8030b8
  800f1a:	68 36 01 00 00       	push   $0x136
  800f1f:	68 0a 31 80 00       	push   $0x80310a
  800f24:	e8 59 06 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[18].virtual_address,PAGE_SIZE) !=   0x80C000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800f29:	a1 20 40 80 00       	mov    0x804020,%eax
  800f2e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800f34:	05 d8 00 00 00       	add    $0xd8,%eax
  800f39:	8b 00                	mov    (%eax),%eax
  800f3b:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
  800f41:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  800f47:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f4c:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  800f51:	74 17                	je     800f6a <_main+0xf32>
  800f53:	83 ec 04             	sub    $0x4,%esp
  800f56:	68 b8 30 80 00       	push   $0x8030b8
  800f5b:	68 37 01 00 00       	push   $0x137
  800f60:	68 0a 31 80 00       	push   $0x80310a
  800f65:	e8 18 06 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[19].virtual_address,PAGE_SIZE) !=   0x80D000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800f6a:	a1 20 40 80 00       	mov    0x804020,%eax
  800f6f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800f75:	05 e4 00 00 00       	add    $0xe4,%eax
  800f7a:	8b 00                	mov    (%eax),%eax
  800f7c:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
  800f82:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  800f88:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f8d:	3d 00 d0 80 00       	cmp    $0x80d000,%eax
  800f92:	74 17                	je     800fab <_main+0xf73>
  800f94:	83 ec 04             	sub    $0x4,%esp
  800f97:	68 b8 30 80 00       	push   $0x8030b8
  800f9c:	68 38 01 00 00       	push   $0x138
  800fa1:	68 0a 31 80 00       	push   $0x80310a
  800fa6:	e8 d7 05 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[20].virtual_address,PAGE_SIZE) !=   0x80E000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800fab:	a1 20 40 80 00       	mov    0x804020,%eax
  800fb0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800fb6:	05 f0 00 00 00       	add    $0xf0,%eax
  800fbb:	8b 00                	mov    (%eax),%eax
  800fbd:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
  800fc3:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800fc9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800fce:	3d 00 e0 80 00       	cmp    $0x80e000,%eax
  800fd3:	74 17                	je     800fec <_main+0xfb4>
  800fd5:	83 ec 04             	sub    $0x4,%esp
  800fd8:	68 b8 30 80 00       	push   $0x8030b8
  800fdd:	68 39 01 00 00       	push   $0x139
  800fe2:	68 0a 31 80 00       	push   $0x80310a
  800fe7:	e8 96 05 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[21].virtual_address,PAGE_SIZE) !=   0x80F000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800fec:	a1 20 40 80 00       	mov    0x804020,%eax
  800ff1:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800ff7:	05 fc 00 00 00       	add    $0xfc,%eax
  800ffc:	8b 00                	mov    (%eax),%eax
  800ffe:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
  801004:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  80100a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80100f:	3d 00 f0 80 00       	cmp    $0x80f000,%eax
  801014:	74 17                	je     80102d <_main+0xff5>
  801016:	83 ec 04             	sub    $0x4,%esp
  801019:	68 b8 30 80 00       	push   $0x8030b8
  80101e:	68 3a 01 00 00       	push   $0x13a
  801023:	68 0a 31 80 00       	push   $0x80310a
  801028:	e8 55 05 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[22].virtual_address,PAGE_SIZE) !=   0x810000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80102d:	a1 20 40 80 00       	mov    0x804020,%eax
  801032:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  801038:	05 08 01 00 00       	add    $0x108,%eax
  80103d:	8b 00                	mov    (%eax),%eax
  80103f:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
  801045:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  80104b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801050:	3d 00 00 81 00       	cmp    $0x810000,%eax
  801055:	74 17                	je     80106e <_main+0x1036>
  801057:	83 ec 04             	sub    $0x4,%esp
  80105a:	68 b8 30 80 00       	push   $0x8030b8
  80105f:	68 3b 01 00 00       	push   $0x13b
  801064:	68 0a 31 80 00       	push   $0x80310a
  801069:	e8 14 05 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[23].virtual_address,PAGE_SIZE) !=   0x811000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80106e:	a1 20 40 80 00       	mov    0x804020,%eax
  801073:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  801079:	05 14 01 00 00       	add    $0x114,%eax
  80107e:	8b 00                	mov    (%eax),%eax
  801080:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
  801086:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  80108c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801091:	3d 00 10 81 00       	cmp    $0x811000,%eax
  801096:	74 17                	je     8010af <_main+0x1077>
  801098:	83 ec 04             	sub    $0x4,%esp
  80109b:	68 b8 30 80 00       	push   $0x8030b8
  8010a0:	68 3c 01 00 00       	push   $0x13c
  8010a5:	68 0a 31 80 00       	push   $0x80310a
  8010aa:	e8 d3 04 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[24].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8010af:	a1 20 40 80 00       	mov    0x804020,%eax
  8010b4:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8010ba:	05 20 01 00 00       	add    $0x120,%eax
  8010bf:	8b 00                	mov    (%eax),%eax
  8010c1:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
  8010c7:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  8010cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010d2:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8010d7:	74 17                	je     8010f0 <_main+0x10b8>
  8010d9:	83 ec 04             	sub    $0x4,%esp
  8010dc:	68 b8 30 80 00       	push   $0x8030b8
  8010e1:	68 3d 01 00 00       	push   $0x13d
  8010e6:	68 0a 31 80 00       	push   $0x80310a
  8010eb:	e8 92 04 00 00       	call   801582 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[25].virtual_address,PAGE_SIZE) !=   0xee7fe000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8010f0:	a1 20 40 80 00       	mov    0x804020,%eax
  8010f5:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8010fb:	05 2c 01 00 00       	add    $0x12c,%eax
  801100:	8b 00                	mov    (%eax),%eax
  801102:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
  801108:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  80110e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801113:	3d 00 e0 7f ee       	cmp    $0xee7fe000,%eax
  801118:	74 17                	je     801131 <_main+0x10f9>
  80111a:	83 ec 04             	sub    $0x4,%esp
  80111d:	68 b8 30 80 00       	push   $0x8030b8
  801122:	68 3e 01 00 00       	push   $0x13e
  801127:	68 0a 31 80 00       	push   $0x80310a
  80112c:	e8 51 04 00 00       	call   801582 <_panic>
				if( myEnv->page_last_WS_index !=  0)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  801131:	a1 20 40 80 00       	mov    0x804020,%eax
  801136:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  80113c:	85 c0                	test   %eax,%eax
  80113e:	74 17                	je     801157 <_main+0x111f>
  801140:	83 ec 04             	sub    $0x4,%esp
  801143:	68 20 31 80 00       	push   $0x803120
  801148:	68 3f 01 00 00       	push   $0x13f
  80114d:	68 0a 31 80 00       	push   $0x80310a
  801152:	e8 2b 04 00 00       	call   801582 <_panic>
			}

			//=========================================================//
			//Clear the FFL
			sys_clear_ffl();
  801157:	e8 fa 16 00 00       	call   802856 <sys_clear_ffl>

			//NOW: it should take from WS

			//Writing (Modified) after freeing the entire FFL:
			//	3 frames should be allocated (stack page, mem table, page file table)
			*ptr4 = garbage2 ;
  80115c:	a1 0c 40 80 00       	mov    0x80400c,%eax
  801161:	8a 95 72 ff ff ff    	mov    -0x8e(%ebp),%dl
  801167:	88 10                	mov    %dl,(%eax)
			//always use pages at 0x801000 and 0x804000
			//			if (garbage4 != *ptr) panic("test failed!");
			//			if (garbage5 != *ptr2) panic("test failed!");

			garbage4 = *ptr ;
  801169:	a1 00 40 80 00       	mov    0x804000,%eax
  80116e:	8a 00                	mov    (%eax),%al
  801170:	88 45 db             	mov    %al,-0x25(%ebp)
			garbage5 = *ptr2 ;
  801173:	a1 04 40 80 00       	mov    0x804004,%eax
  801178:	8a 00                	mov    (%eax),%al
  80117a:	88 45 da             	mov    %al,-0x26(%ebp)

			//Writing (Modified) after freeing the entire FFL:
			//	4 frames should be allocated (4 stack pages)
			*(ptr4+1*PAGE_SIZE) = 'A';
  80117d:	a1 0c 40 80 00       	mov    0x80400c,%eax
  801182:	05 00 10 00 00       	add    $0x1000,%eax
  801187:	c6 00 41             	movb   $0x41,(%eax)
			*(ptr4+2*PAGE_SIZE) = 'B';
  80118a:	a1 0c 40 80 00       	mov    0x80400c,%eax
  80118f:	05 00 20 00 00       	add    $0x2000,%eax
  801194:	c6 00 42             	movb   $0x42,(%eax)
			*(ptr4+3*PAGE_SIZE) = 'C';
  801197:	a1 0c 40 80 00       	mov    0x80400c,%eax
  80119c:	05 00 30 00 00       	add    $0x3000,%eax
  8011a1:	c6 00 43             	movb   $0x43,(%eax)
			*(ptr4+4*PAGE_SIZE) = 'D';
  8011a4:	a1 0c 40 80 00       	mov    0x80400c,%eax
  8011a9:	05 00 40 00 00       	add    $0x4000,%eax
  8011ae:	c6 00 44             	movb   $0x44,(%eax)
						ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ==  0x802000)
					panic("test failed! either wrong victim or victim is not removed from WS");
			}
			 */
			//Check the WS after FIFO algorithm
			if (garbage4 != *ptr || garbage5 != *ptr2) panic("test failed!");
  8011b1:	a1 00 40 80 00       	mov    0x804000,%eax
  8011b6:	8a 00                	mov    (%eax),%al
  8011b8:	3a 45 db             	cmp    -0x25(%ebp),%al
  8011bb:	75 0c                	jne    8011c9 <_main+0x1191>
  8011bd:	a1 04 40 80 00       	mov    0x804004,%eax
  8011c2:	8a 00                	mov    (%eax),%al
  8011c4:	3a 45 da             	cmp    -0x26(%ebp),%al
  8011c7:	74 17                	je     8011e0 <_main+0x11a8>
  8011c9:	83 ec 04             	sub    $0x4,%esp
  8011cc:	68 21 32 80 00       	push   $0x803221
  8011d1:	68 69 01 00 00       	push   $0x169
  8011d6:	68 0a 31 80 00       	push   $0x80310a
  8011db:	e8 a2 03 00 00       	call   801582 <_panic>

			//There should be two empty locations that are freed for the two tables (mem table and page file table)
			int numOfEmptyLocs = 0 ;
  8011e0:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8011e7:	c7 45 b4 00 00 00 00 	movl   $0x0,-0x4c(%ebp)
  8011ee:	eb 26                	jmp    801216 <_main+0x11de>
			{
				if (myEnv->__uptr_pws[i].empty)
  8011f0:	a1 20 40 80 00       	mov    0x804020,%eax
  8011f5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8011fb:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  8011fe:	89 d0                	mov    %edx,%eax
  801200:	01 c0                	add    %eax,%eax
  801202:	01 d0                	add    %edx,%eax
  801204:	c1 e0 02             	shl    $0x2,%eax
  801207:	01 c8                	add    %ecx,%eax
  801209:	8a 40 04             	mov    0x4(%eax),%al
  80120c:	84 c0                	test   %al,%al
  80120e:	74 03                	je     801213 <_main+0x11db>
					numOfEmptyLocs++ ;
  801210:	ff 45 b8             	incl   -0x48(%ebp)
			//Check the WS after FIFO algorithm
			if (garbage4 != *ptr || garbage5 != *ptr2) panic("test failed!");

			//There should be two empty locations that are freed for the two tables (mem table and page file table)
			int numOfEmptyLocs = 0 ;
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  801213:	ff 45 b4             	incl   -0x4c(%ebp)
  801216:	a1 20 40 80 00       	mov    0x804020,%eax
  80121b:	8b 50 74             	mov    0x74(%eax),%edx
  80121e:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801221:	39 c2                	cmp    %eax,%edx
  801223:	77 cb                	ja     8011f0 <_main+0x11b8>
			{
				if (myEnv->__uptr_pws[i].empty)
					numOfEmptyLocs++ ;
			}
			if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");
  801225:	83 7d b8 02          	cmpl   $0x2,-0x48(%ebp)
  801229:	74 17                	je     801242 <_main+0x120a>
  80122b:	83 ec 04             	sub    $0x4,%esp
  80122e:	68 30 32 80 00       	push   $0x803230
  801233:	68 72 01 00 00       	push   $0x172
  801238:	68 0a 31 80 00       	push   $0x80310a
  80123d:	e8 40 03 00 00       	call   801582 <_panic>

			uint32 expectedAddresses[24] = {0x801000,0x802000,0x803000,0x804000,0x805000,0x806000,0x807000,0x808000,0x809000,0x80a000,0x80b000,0x80c000,0x80d000,0x80e000,0x80f000,0x810000,0x811000,
  801242:	8d 85 6c fe ff ff    	lea    -0x194(%ebp),%eax
  801248:	bb 60 33 80 00       	mov    $0x803360,%ebx
  80124d:	ba 18 00 00 00       	mov    $0x18,%edx
  801252:	89 c7                	mov    %eax,%edi
  801254:	89 de                	mov    %ebx,%esi
  801256:	89 d1                	mov    %edx,%ecx
  801258:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
					0xee3f9000,0xee3fa000,0xee3fb000,0xee3fc000,0xee3fd000,0xee7fe000,0xeebfd000} ;

			int numOfFoundedAddresses = 0;
  80125a:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
			for (int j = 0; j < 24; j++)
  801261:	c7 45 ac 00 00 00 00 	movl   $0x0,-0x54(%ebp)
  801268:	eb 5f                	jmp    8012c9 <_main+0x1291>
			{
				for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  80126a:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%ebp)
  801271:	eb 44                	jmp    8012b7 <_main+0x127f>
				{
					if (ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == expectedAddresses[j])
  801273:	a1 20 40 80 00       	mov    0x804020,%eax
  801278:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80127e:	8b 55 a8             	mov    -0x58(%ebp),%edx
  801281:	89 d0                	mov    %edx,%eax
  801283:	01 c0                	add    %eax,%eax
  801285:	01 d0                	add    %edx,%eax
  801287:	c1 e0 02             	shl    $0x2,%eax
  80128a:	01 c8                	add    %ecx,%eax
  80128c:	8b 00                	mov    (%eax),%eax
  80128e:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
  801294:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  80129a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80129f:	89 c2                	mov    %eax,%edx
  8012a1:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8012a4:	8b 84 85 6c fe ff ff 	mov    -0x194(%ebp,%eax,4),%eax
  8012ab:	39 c2                	cmp    %eax,%edx
  8012ad:	75 05                	jne    8012b4 <_main+0x127c>
					{
						numOfFoundedAddresses++;
  8012af:	ff 45 b0             	incl   -0x50(%ebp)
						break;
  8012b2:	eb 12                	jmp    8012c6 <_main+0x128e>
					0xee3f9000,0xee3fa000,0xee3fb000,0xee3fc000,0xee3fd000,0xee7fe000,0xeebfd000} ;

			int numOfFoundedAddresses = 0;
			for (int j = 0; j < 24; j++)
			{
				for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8012b4:	ff 45 a8             	incl   -0x58(%ebp)
  8012b7:	a1 20 40 80 00       	mov    0x804020,%eax
  8012bc:	8b 50 74             	mov    0x74(%eax),%edx
  8012bf:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8012c2:	39 c2                	cmp    %eax,%edx
  8012c4:	77 ad                	ja     801273 <_main+0x123b>

			uint32 expectedAddresses[24] = {0x801000,0x802000,0x803000,0x804000,0x805000,0x806000,0x807000,0x808000,0x809000,0x80a000,0x80b000,0x80c000,0x80d000,0x80e000,0x80f000,0x810000,0x811000,
					0xee3f9000,0xee3fa000,0xee3fb000,0xee3fc000,0xee3fd000,0xee7fe000,0xeebfd000} ;

			int numOfFoundedAddresses = 0;
			for (int j = 0; j < 24; j++)
  8012c6:	ff 45 ac             	incl   -0x54(%ebp)
  8012c9:	83 7d ac 17          	cmpl   $0x17,-0x54(%ebp)
  8012cd:	7e 9b                	jle    80126a <_main+0x1232>
						numOfFoundedAddresses++;
						break;
					}
				}
			}
			if (numOfFoundedAddresses != 24) panic("test failed! either wrong victim or victim is not removed from WS");
  8012cf:	83 7d b0 18          	cmpl   $0x18,-0x50(%ebp)
  8012d3:	74 17                	je     8012ec <_main+0x12b4>
  8012d5:	83 ec 04             	sub    $0x4,%esp
  8012d8:	68 30 32 80 00       	push   $0x803230
  8012dd:	68 83 01 00 00       	push   $0x183
  8012e2:	68 0a 31 80 00       	push   $0x80310a
  8012e7:	e8 96 02 00 00       	call   801582 <_panic>

		}


		//Check that the values are successfully stored
		for (i = 0 ; i < PAGE_SIZE*4 ; i+=PAGE_SIZE/2)
  8012ec:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8012f3:	eb 2c                	jmp    801321 <_main+0x12e9>
		{
			//cprintf("i = %x, address = %x, arr[i] = %d\n", i, &(arr[i]), arr[i]);
			if (arr[i] != -1) panic("test failed!");
  8012f5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8012f8:	05 40 40 80 00       	add    $0x804040,%eax
  8012fd:	8a 00                	mov    (%eax),%al
  8012ff:	3c ff                	cmp    $0xff,%al
  801301:	74 17                	je     80131a <_main+0x12e2>
  801303:	83 ec 04             	sub    $0x4,%esp
  801306:	68 21 32 80 00       	push   $0x803221
  80130b:	68 8d 01 00 00       	push   $0x18d
  801310:	68 0a 31 80 00       	push   $0x80310a
  801315:	e8 68 02 00 00       	call   801582 <_panic>

		}


		//Check that the values are successfully stored
		for (i = 0 ; i < PAGE_SIZE*4 ; i+=PAGE_SIZE/2)
  80131a:	81 45 d4 00 08 00 00 	addl   $0x800,-0x2c(%ebp)
  801321:	81 7d d4 ff 3f 00 00 	cmpl   $0x3fff,-0x2c(%ebp)
  801328:	7e cb                	jle    8012f5 <_main+0x12bd>
		{
			//cprintf("i = %x, address = %x, arr[i] = %d\n", i, &(arr[i]), arr[i]);
			if (arr[i] != -1) panic("test failed!");
		}
		if (*ptr3 != arr[PAGE_SIZE*10-1]) panic("test failed!");
  80132a:	a1 08 40 80 00       	mov    0x804008,%eax
  80132f:	8a 10                	mov    (%eax),%dl
  801331:	a0 3f e0 80 00       	mov    0x80e03f,%al
  801336:	38 c2                	cmp    %al,%dl
  801338:	74 17                	je     801351 <_main+0x1319>
  80133a:	83 ec 04             	sub    $0x4,%esp
  80133d:	68 21 32 80 00       	push   $0x803221
  801342:	68 8f 01 00 00       	push   $0x18f
  801347:	68 0a 31 80 00       	push   $0x80310a
  80134c:	e8 31 02 00 00       	call   801582 <_panic>


		if (testCase ==3)
  801351:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  801355:	0f 85 09 01 00 00    	jne    801464 <_main+0x142c>
		{
			//			cprintf("garbage4 = %d, *ptr = %d\n",garbage4, *ptr);
			if (garbage4 != *ptr) panic("test failed!");
  80135b:	a1 00 40 80 00       	mov    0x804000,%eax
  801360:	8a 00                	mov    (%eax),%al
  801362:	3a 45 db             	cmp    -0x25(%ebp),%al
  801365:	74 17                	je     80137e <_main+0x1346>
  801367:	83 ec 04             	sub    $0x4,%esp
  80136a:	68 21 32 80 00       	push   $0x803221
  80136f:	68 95 01 00 00       	push   $0x195
  801374:	68 0a 31 80 00       	push   $0x80310a
  801379:	e8 04 02 00 00       	call   801582 <_panic>
			if (garbage5 != *ptr2) panic("test failed!");
  80137e:	a1 04 40 80 00       	mov    0x804004,%eax
  801383:	8a 00                	mov    (%eax),%al
  801385:	3a 45 da             	cmp    -0x26(%ebp),%al
  801388:	74 17                	je     8013a1 <_main+0x1369>
  80138a:	83 ec 04             	sub    $0x4,%esp
  80138d:	68 21 32 80 00       	push   $0x803221
  801392:	68 96 01 00 00       	push   $0x196
  801397:	68 0a 31 80 00       	push   $0x80310a
  80139c:	e8 e1 01 00 00       	call   801582 <_panic>

			if (*ptr4 != arr[PAGE_SIZE*11-1]) panic("test failed!");
  8013a1:	a1 0c 40 80 00       	mov    0x80400c,%eax
  8013a6:	8a 10                	mov    (%eax),%dl
  8013a8:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8013ad:	38 c2                	cmp    %al,%dl
  8013af:	74 17                	je     8013c8 <_main+0x1390>
  8013b1:	83 ec 04             	sub    $0x4,%esp
  8013b4:	68 21 32 80 00       	push   $0x803221
  8013b9:	68 98 01 00 00       	push   $0x198
  8013be:	68 0a 31 80 00       	push   $0x80310a
  8013c3:	e8 ba 01 00 00       	call   801582 <_panic>
			if (*(ptr4+1*PAGE_SIZE) != 'A') panic("test failed!");
  8013c8:	a1 0c 40 80 00       	mov    0x80400c,%eax
  8013cd:	05 00 10 00 00       	add    $0x1000,%eax
  8013d2:	8a 00                	mov    (%eax),%al
  8013d4:	3c 41                	cmp    $0x41,%al
  8013d6:	74 17                	je     8013ef <_main+0x13b7>
  8013d8:	83 ec 04             	sub    $0x4,%esp
  8013db:	68 21 32 80 00       	push   $0x803221
  8013e0:	68 99 01 00 00       	push   $0x199
  8013e5:	68 0a 31 80 00       	push   $0x80310a
  8013ea:	e8 93 01 00 00       	call   801582 <_panic>
			if (*(ptr4+2*PAGE_SIZE) != 'B') panic("test failed!");
  8013ef:	a1 0c 40 80 00       	mov    0x80400c,%eax
  8013f4:	05 00 20 00 00       	add    $0x2000,%eax
  8013f9:	8a 00                	mov    (%eax),%al
  8013fb:	3c 42                	cmp    $0x42,%al
  8013fd:	74 17                	je     801416 <_main+0x13de>
  8013ff:	83 ec 04             	sub    $0x4,%esp
  801402:	68 21 32 80 00       	push   $0x803221
  801407:	68 9a 01 00 00       	push   $0x19a
  80140c:	68 0a 31 80 00       	push   $0x80310a
  801411:	e8 6c 01 00 00       	call   801582 <_panic>
			if (*(ptr4+3*PAGE_SIZE) != 'C') panic("test failed!");
  801416:	a1 0c 40 80 00       	mov    0x80400c,%eax
  80141b:	05 00 30 00 00       	add    $0x3000,%eax
  801420:	8a 00                	mov    (%eax),%al
  801422:	3c 43                	cmp    $0x43,%al
  801424:	74 17                	je     80143d <_main+0x1405>
  801426:	83 ec 04             	sub    $0x4,%esp
  801429:	68 21 32 80 00       	push   $0x803221
  80142e:	68 9b 01 00 00       	push   $0x19b
  801433:	68 0a 31 80 00       	push   $0x80310a
  801438:	e8 45 01 00 00       	call   801582 <_panic>
			if (*(ptr4+4*PAGE_SIZE) != 'D') panic("test failed!");
  80143d:	a1 0c 40 80 00       	mov    0x80400c,%eax
  801442:	05 00 40 00 00       	add    $0x4000,%eax
  801447:	8a 00                	mov    (%eax),%al
  801449:	3c 44                	cmp    $0x44,%al
  80144b:	74 17                	je     801464 <_main+0x142c>
  80144d:	83 ec 04             	sub    $0x4,%esp
  801450:	68 21 32 80 00       	push   $0x803221
  801455:	68 9c 01 00 00       	push   $0x19c
  80145a:	68 0a 31 80 00       	push   $0x80310a
  80145f:	e8 1e 01 00 00       	call   801582 <_panic>
		}
	}

	cprintf("Congratulations!! test freeRAM (Scenario# %d) completed successfully.\n", testCase);
  801464:	83 ec 08             	sub    $0x8,%esp
  801467:	ff 75 e4             	pushl  -0x1c(%ebp)
  80146a:	68 dc 32 80 00       	push   $0x8032dc
  80146f:	e8 c2 03 00 00       	call   801836 <cprintf>
  801474:	83 c4 10             	add    $0x10,%esp

	return;
  801477:	90                   	nop
}
  801478:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80147b:	5b                   	pop    %ebx
  80147c:	5e                   	pop    %esi
  80147d:	5f                   	pop    %edi
  80147e:	5d                   	pop    %ebp
  80147f:	c3                   	ret    

00801480 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  801480:	55                   	push   %ebp
  801481:	89 e5                	mov    %esp,%ebp
  801483:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  801486:	e8 d6 11 00 00       	call   802661 <sys_getenvindex>
  80148b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80148e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801491:	89 d0                	mov    %edx,%eax
  801493:	01 c0                	add    %eax,%eax
  801495:	01 d0                	add    %edx,%eax
  801497:	c1 e0 02             	shl    $0x2,%eax
  80149a:	01 d0                	add    %edx,%eax
  80149c:	c1 e0 06             	shl    $0x6,%eax
  80149f:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8014a4:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8014a9:	a1 20 40 80 00       	mov    0x804020,%eax
  8014ae:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8014b4:	84 c0                	test   %al,%al
  8014b6:	74 0f                	je     8014c7 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8014b8:	a1 20 40 80 00       	mov    0x804020,%eax
  8014bd:	05 f4 02 00 00       	add    $0x2f4,%eax
  8014c2:	a3 10 40 80 00       	mov    %eax,0x804010

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8014c7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014cb:	7e 0a                	jle    8014d7 <libmain+0x57>
		binaryname = argv[0];
  8014cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d0:	8b 00                	mov    (%eax),%eax
  8014d2:	a3 10 40 80 00       	mov    %eax,0x804010

	// call user main routine
	_main(argc, argv);
  8014d7:	83 ec 08             	sub    $0x8,%esp
  8014da:	ff 75 0c             	pushl  0xc(%ebp)
  8014dd:	ff 75 08             	pushl  0x8(%ebp)
  8014e0:	e8 53 eb ff ff       	call   800038 <_main>
  8014e5:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8014e8:	e8 0f 13 00 00       	call   8027fc <sys_disable_interrupt>
	cprintf("**************************************\n");
  8014ed:	83 ec 0c             	sub    $0xc,%esp
  8014f0:	68 d8 33 80 00       	push   $0x8033d8
  8014f5:	e8 3c 03 00 00       	call   801836 <cprintf>
  8014fa:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8014fd:	a1 20 40 80 00       	mov    0x804020,%eax
  801502:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  801508:	a1 20 40 80 00       	mov    0x804020,%eax
  80150d:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  801513:	83 ec 04             	sub    $0x4,%esp
  801516:	52                   	push   %edx
  801517:	50                   	push   %eax
  801518:	68 00 34 80 00       	push   $0x803400
  80151d:	e8 14 03 00 00       	call   801836 <cprintf>
  801522:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801525:	a1 20 40 80 00       	mov    0x804020,%eax
  80152a:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  801530:	83 ec 08             	sub    $0x8,%esp
  801533:	50                   	push   %eax
  801534:	68 25 34 80 00       	push   $0x803425
  801539:	e8 f8 02 00 00       	call   801836 <cprintf>
  80153e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  801541:	83 ec 0c             	sub    $0xc,%esp
  801544:	68 d8 33 80 00       	push   $0x8033d8
  801549:	e8 e8 02 00 00       	call   801836 <cprintf>
  80154e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801551:	e8 c0 12 00 00       	call   802816 <sys_enable_interrupt>

	// exit gracefully
	exit();
  801556:	e8 19 00 00 00       	call   801574 <exit>
}
  80155b:	90                   	nop
  80155c:	c9                   	leave  
  80155d:	c3                   	ret    

0080155e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80155e:	55                   	push   %ebp
  80155f:	89 e5                	mov    %esp,%ebp
  801561:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  801564:	83 ec 0c             	sub    $0xc,%esp
  801567:	6a 00                	push   $0x0
  801569:	e8 bf 10 00 00       	call   80262d <sys_env_destroy>
  80156e:	83 c4 10             	add    $0x10,%esp
}
  801571:	90                   	nop
  801572:	c9                   	leave  
  801573:	c3                   	ret    

00801574 <exit>:

void
exit(void)
{
  801574:	55                   	push   %ebp
  801575:	89 e5                	mov    %esp,%ebp
  801577:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80157a:	e8 14 11 00 00       	call   802693 <sys_env_exit>
}
  80157f:	90                   	nop
  801580:	c9                   	leave  
  801581:	c3                   	ret    

00801582 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
  801585:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801588:	8d 45 10             	lea    0x10(%ebp),%eax
  80158b:	83 c0 04             	add    $0x4,%eax
  80158e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801591:	a1 04 10 81 00       	mov    0x811004,%eax
  801596:	85 c0                	test   %eax,%eax
  801598:	74 16                	je     8015b0 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80159a:	a1 04 10 81 00       	mov    0x811004,%eax
  80159f:	83 ec 08             	sub    $0x8,%esp
  8015a2:	50                   	push   %eax
  8015a3:	68 3c 34 80 00       	push   $0x80343c
  8015a8:	e8 89 02 00 00       	call   801836 <cprintf>
  8015ad:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8015b0:	a1 10 40 80 00       	mov    0x804010,%eax
  8015b5:	ff 75 0c             	pushl  0xc(%ebp)
  8015b8:	ff 75 08             	pushl  0x8(%ebp)
  8015bb:	50                   	push   %eax
  8015bc:	68 41 34 80 00       	push   $0x803441
  8015c1:	e8 70 02 00 00       	call   801836 <cprintf>
  8015c6:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8015c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015cc:	83 ec 08             	sub    $0x8,%esp
  8015cf:	ff 75 f4             	pushl  -0xc(%ebp)
  8015d2:	50                   	push   %eax
  8015d3:	e8 f3 01 00 00       	call   8017cb <vcprintf>
  8015d8:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8015db:	83 ec 08             	sub    $0x8,%esp
  8015de:	6a 00                	push   $0x0
  8015e0:	68 5d 34 80 00       	push   $0x80345d
  8015e5:	e8 e1 01 00 00       	call   8017cb <vcprintf>
  8015ea:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8015ed:	e8 82 ff ff ff       	call   801574 <exit>

	// should not return here
	while (1) ;
  8015f2:	eb fe                	jmp    8015f2 <_panic+0x70>

008015f4 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8015f4:	55                   	push   %ebp
  8015f5:	89 e5                	mov    %esp,%ebp
  8015f7:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8015fa:	a1 20 40 80 00       	mov    0x804020,%eax
  8015ff:	8b 50 74             	mov    0x74(%eax),%edx
  801602:	8b 45 0c             	mov    0xc(%ebp),%eax
  801605:	39 c2                	cmp    %eax,%edx
  801607:	74 14                	je     80161d <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801609:	83 ec 04             	sub    $0x4,%esp
  80160c:	68 60 34 80 00       	push   $0x803460
  801611:	6a 26                	push   $0x26
  801613:	68 ac 34 80 00       	push   $0x8034ac
  801618:	e8 65 ff ff ff       	call   801582 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80161d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801624:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80162b:	e9 c2 00 00 00       	jmp    8016f2 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801630:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801633:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80163a:	8b 45 08             	mov    0x8(%ebp),%eax
  80163d:	01 d0                	add    %edx,%eax
  80163f:	8b 00                	mov    (%eax),%eax
  801641:	85 c0                	test   %eax,%eax
  801643:	75 08                	jne    80164d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801645:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801648:	e9 a2 00 00 00       	jmp    8016ef <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80164d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801654:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80165b:	eb 69                	jmp    8016c6 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80165d:	a1 20 40 80 00       	mov    0x804020,%eax
  801662:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801668:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80166b:	89 d0                	mov    %edx,%eax
  80166d:	01 c0                	add    %eax,%eax
  80166f:	01 d0                	add    %edx,%eax
  801671:	c1 e0 02             	shl    $0x2,%eax
  801674:	01 c8                	add    %ecx,%eax
  801676:	8a 40 04             	mov    0x4(%eax),%al
  801679:	84 c0                	test   %al,%al
  80167b:	75 46                	jne    8016c3 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80167d:	a1 20 40 80 00       	mov    0x804020,%eax
  801682:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801688:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80168b:	89 d0                	mov    %edx,%eax
  80168d:	01 c0                	add    %eax,%eax
  80168f:	01 d0                	add    %edx,%eax
  801691:	c1 e0 02             	shl    $0x2,%eax
  801694:	01 c8                	add    %ecx,%eax
  801696:	8b 00                	mov    (%eax),%eax
  801698:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80169b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80169e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8016a3:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8016a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016a8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8016af:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b2:	01 c8                	add    %ecx,%eax
  8016b4:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8016b6:	39 c2                	cmp    %eax,%edx
  8016b8:	75 09                	jne    8016c3 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8016ba:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8016c1:	eb 12                	jmp    8016d5 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8016c3:	ff 45 e8             	incl   -0x18(%ebp)
  8016c6:	a1 20 40 80 00       	mov    0x804020,%eax
  8016cb:	8b 50 74             	mov    0x74(%eax),%edx
  8016ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016d1:	39 c2                	cmp    %eax,%edx
  8016d3:	77 88                	ja     80165d <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8016d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8016d9:	75 14                	jne    8016ef <CheckWSWithoutLastIndex+0xfb>
			panic(
  8016db:	83 ec 04             	sub    $0x4,%esp
  8016de:	68 b8 34 80 00       	push   $0x8034b8
  8016e3:	6a 3a                	push   $0x3a
  8016e5:	68 ac 34 80 00       	push   $0x8034ac
  8016ea:	e8 93 fe ff ff       	call   801582 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8016ef:	ff 45 f0             	incl   -0x10(%ebp)
  8016f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016f5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8016f8:	0f 8c 32 ff ff ff    	jl     801630 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8016fe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801705:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80170c:	eb 26                	jmp    801734 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80170e:	a1 20 40 80 00       	mov    0x804020,%eax
  801713:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801719:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80171c:	89 d0                	mov    %edx,%eax
  80171e:	01 c0                	add    %eax,%eax
  801720:	01 d0                	add    %edx,%eax
  801722:	c1 e0 02             	shl    $0x2,%eax
  801725:	01 c8                	add    %ecx,%eax
  801727:	8a 40 04             	mov    0x4(%eax),%al
  80172a:	3c 01                	cmp    $0x1,%al
  80172c:	75 03                	jne    801731 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80172e:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801731:	ff 45 e0             	incl   -0x20(%ebp)
  801734:	a1 20 40 80 00       	mov    0x804020,%eax
  801739:	8b 50 74             	mov    0x74(%eax),%edx
  80173c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80173f:	39 c2                	cmp    %eax,%edx
  801741:	77 cb                	ja     80170e <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801743:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801746:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801749:	74 14                	je     80175f <CheckWSWithoutLastIndex+0x16b>
		panic(
  80174b:	83 ec 04             	sub    $0x4,%esp
  80174e:	68 0c 35 80 00       	push   $0x80350c
  801753:	6a 44                	push   $0x44
  801755:	68 ac 34 80 00       	push   $0x8034ac
  80175a:	e8 23 fe ff ff       	call   801582 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80175f:	90                   	nop
  801760:	c9                   	leave  
  801761:	c3                   	ret    

00801762 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801762:	55                   	push   %ebp
  801763:	89 e5                	mov    %esp,%ebp
  801765:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801768:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176b:	8b 00                	mov    (%eax),%eax
  80176d:	8d 48 01             	lea    0x1(%eax),%ecx
  801770:	8b 55 0c             	mov    0xc(%ebp),%edx
  801773:	89 0a                	mov    %ecx,(%edx)
  801775:	8b 55 08             	mov    0x8(%ebp),%edx
  801778:	88 d1                	mov    %dl,%cl
  80177a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801781:	8b 45 0c             	mov    0xc(%ebp),%eax
  801784:	8b 00                	mov    (%eax),%eax
  801786:	3d ff 00 00 00       	cmp    $0xff,%eax
  80178b:	75 2c                	jne    8017b9 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80178d:	a0 24 40 80 00       	mov    0x804024,%al
  801792:	0f b6 c0             	movzbl %al,%eax
  801795:	8b 55 0c             	mov    0xc(%ebp),%edx
  801798:	8b 12                	mov    (%edx),%edx
  80179a:	89 d1                	mov    %edx,%ecx
  80179c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80179f:	83 c2 08             	add    $0x8,%edx
  8017a2:	83 ec 04             	sub    $0x4,%esp
  8017a5:	50                   	push   %eax
  8017a6:	51                   	push   %ecx
  8017a7:	52                   	push   %edx
  8017a8:	e8 3e 0e 00 00       	call   8025eb <sys_cputs>
  8017ad:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8017b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8017b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bc:	8b 40 04             	mov    0x4(%eax),%eax
  8017bf:	8d 50 01             	lea    0x1(%eax),%edx
  8017c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c5:	89 50 04             	mov    %edx,0x4(%eax)
}
  8017c8:	90                   	nop
  8017c9:	c9                   	leave  
  8017ca:	c3                   	ret    

008017cb <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8017cb:	55                   	push   %ebp
  8017cc:	89 e5                	mov    %esp,%ebp
  8017ce:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8017d4:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8017db:	00 00 00 
	b.cnt = 0;
  8017de:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8017e5:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8017e8:	ff 75 0c             	pushl  0xc(%ebp)
  8017eb:	ff 75 08             	pushl  0x8(%ebp)
  8017ee:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8017f4:	50                   	push   %eax
  8017f5:	68 62 17 80 00       	push   $0x801762
  8017fa:	e8 11 02 00 00       	call   801a10 <vprintfmt>
  8017ff:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  801802:	a0 24 40 80 00       	mov    0x804024,%al
  801807:	0f b6 c0             	movzbl %al,%eax
  80180a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801810:	83 ec 04             	sub    $0x4,%esp
  801813:	50                   	push   %eax
  801814:	52                   	push   %edx
  801815:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80181b:	83 c0 08             	add    $0x8,%eax
  80181e:	50                   	push   %eax
  80181f:	e8 c7 0d 00 00       	call   8025eb <sys_cputs>
  801824:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801827:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  80182e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801834:	c9                   	leave  
  801835:	c3                   	ret    

00801836 <cprintf>:

int cprintf(const char *fmt, ...) {
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
  801839:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80183c:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801843:	8d 45 0c             	lea    0xc(%ebp),%eax
  801846:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801849:	8b 45 08             	mov    0x8(%ebp),%eax
  80184c:	83 ec 08             	sub    $0x8,%esp
  80184f:	ff 75 f4             	pushl  -0xc(%ebp)
  801852:	50                   	push   %eax
  801853:	e8 73 ff ff ff       	call   8017cb <vcprintf>
  801858:	83 c4 10             	add    $0x10,%esp
  80185b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80185e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801861:	c9                   	leave  
  801862:	c3                   	ret    

00801863 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801863:	55                   	push   %ebp
  801864:	89 e5                	mov    %esp,%ebp
  801866:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801869:	e8 8e 0f 00 00       	call   8027fc <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80186e:	8d 45 0c             	lea    0xc(%ebp),%eax
  801871:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801874:	8b 45 08             	mov    0x8(%ebp),%eax
  801877:	83 ec 08             	sub    $0x8,%esp
  80187a:	ff 75 f4             	pushl  -0xc(%ebp)
  80187d:	50                   	push   %eax
  80187e:	e8 48 ff ff ff       	call   8017cb <vcprintf>
  801883:	83 c4 10             	add    $0x10,%esp
  801886:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801889:	e8 88 0f 00 00       	call   802816 <sys_enable_interrupt>
	return cnt;
  80188e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801891:	c9                   	leave  
  801892:	c3                   	ret    

00801893 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801893:	55                   	push   %ebp
  801894:	89 e5                	mov    %esp,%ebp
  801896:	53                   	push   %ebx
  801897:	83 ec 14             	sub    $0x14,%esp
  80189a:	8b 45 10             	mov    0x10(%ebp),%eax
  80189d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8018a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8018a6:	8b 45 18             	mov    0x18(%ebp),%eax
  8018a9:	ba 00 00 00 00       	mov    $0x0,%edx
  8018ae:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8018b1:	77 55                	ja     801908 <printnum+0x75>
  8018b3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8018b6:	72 05                	jb     8018bd <printnum+0x2a>
  8018b8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018bb:	77 4b                	ja     801908 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8018bd:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8018c0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8018c3:	8b 45 18             	mov    0x18(%ebp),%eax
  8018c6:	ba 00 00 00 00       	mov    $0x0,%edx
  8018cb:	52                   	push   %edx
  8018cc:	50                   	push   %eax
  8018cd:	ff 75 f4             	pushl  -0xc(%ebp)
  8018d0:	ff 75 f0             	pushl  -0x10(%ebp)
  8018d3:	e8 b8 13 00 00       	call   802c90 <__udivdi3>
  8018d8:	83 c4 10             	add    $0x10,%esp
  8018db:	83 ec 04             	sub    $0x4,%esp
  8018de:	ff 75 20             	pushl  0x20(%ebp)
  8018e1:	53                   	push   %ebx
  8018e2:	ff 75 18             	pushl  0x18(%ebp)
  8018e5:	52                   	push   %edx
  8018e6:	50                   	push   %eax
  8018e7:	ff 75 0c             	pushl  0xc(%ebp)
  8018ea:	ff 75 08             	pushl  0x8(%ebp)
  8018ed:	e8 a1 ff ff ff       	call   801893 <printnum>
  8018f2:	83 c4 20             	add    $0x20,%esp
  8018f5:	eb 1a                	jmp    801911 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8018f7:	83 ec 08             	sub    $0x8,%esp
  8018fa:	ff 75 0c             	pushl  0xc(%ebp)
  8018fd:	ff 75 20             	pushl  0x20(%ebp)
  801900:	8b 45 08             	mov    0x8(%ebp),%eax
  801903:	ff d0                	call   *%eax
  801905:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801908:	ff 4d 1c             	decl   0x1c(%ebp)
  80190b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80190f:	7f e6                	jg     8018f7 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801911:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801914:	bb 00 00 00 00       	mov    $0x0,%ebx
  801919:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80191c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80191f:	53                   	push   %ebx
  801920:	51                   	push   %ecx
  801921:	52                   	push   %edx
  801922:	50                   	push   %eax
  801923:	e8 78 14 00 00       	call   802da0 <__umoddi3>
  801928:	83 c4 10             	add    $0x10,%esp
  80192b:	05 74 37 80 00       	add    $0x803774,%eax
  801930:	8a 00                	mov    (%eax),%al
  801932:	0f be c0             	movsbl %al,%eax
  801935:	83 ec 08             	sub    $0x8,%esp
  801938:	ff 75 0c             	pushl  0xc(%ebp)
  80193b:	50                   	push   %eax
  80193c:	8b 45 08             	mov    0x8(%ebp),%eax
  80193f:	ff d0                	call   *%eax
  801941:	83 c4 10             	add    $0x10,%esp
}
  801944:	90                   	nop
  801945:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801948:	c9                   	leave  
  801949:	c3                   	ret    

0080194a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80194a:	55                   	push   %ebp
  80194b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80194d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801951:	7e 1c                	jle    80196f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801953:	8b 45 08             	mov    0x8(%ebp),%eax
  801956:	8b 00                	mov    (%eax),%eax
  801958:	8d 50 08             	lea    0x8(%eax),%edx
  80195b:	8b 45 08             	mov    0x8(%ebp),%eax
  80195e:	89 10                	mov    %edx,(%eax)
  801960:	8b 45 08             	mov    0x8(%ebp),%eax
  801963:	8b 00                	mov    (%eax),%eax
  801965:	83 e8 08             	sub    $0x8,%eax
  801968:	8b 50 04             	mov    0x4(%eax),%edx
  80196b:	8b 00                	mov    (%eax),%eax
  80196d:	eb 40                	jmp    8019af <getuint+0x65>
	else if (lflag)
  80196f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801973:	74 1e                	je     801993 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801975:	8b 45 08             	mov    0x8(%ebp),%eax
  801978:	8b 00                	mov    (%eax),%eax
  80197a:	8d 50 04             	lea    0x4(%eax),%edx
  80197d:	8b 45 08             	mov    0x8(%ebp),%eax
  801980:	89 10                	mov    %edx,(%eax)
  801982:	8b 45 08             	mov    0x8(%ebp),%eax
  801985:	8b 00                	mov    (%eax),%eax
  801987:	83 e8 04             	sub    $0x4,%eax
  80198a:	8b 00                	mov    (%eax),%eax
  80198c:	ba 00 00 00 00       	mov    $0x0,%edx
  801991:	eb 1c                	jmp    8019af <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801993:	8b 45 08             	mov    0x8(%ebp),%eax
  801996:	8b 00                	mov    (%eax),%eax
  801998:	8d 50 04             	lea    0x4(%eax),%edx
  80199b:	8b 45 08             	mov    0x8(%ebp),%eax
  80199e:	89 10                	mov    %edx,(%eax)
  8019a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a3:	8b 00                	mov    (%eax),%eax
  8019a5:	83 e8 04             	sub    $0x4,%eax
  8019a8:	8b 00                	mov    (%eax),%eax
  8019aa:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8019af:	5d                   	pop    %ebp
  8019b0:	c3                   	ret    

008019b1 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8019b1:	55                   	push   %ebp
  8019b2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8019b4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8019b8:	7e 1c                	jle    8019d6 <getint+0x25>
		return va_arg(*ap, long long);
  8019ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bd:	8b 00                	mov    (%eax),%eax
  8019bf:	8d 50 08             	lea    0x8(%eax),%edx
  8019c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c5:	89 10                	mov    %edx,(%eax)
  8019c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ca:	8b 00                	mov    (%eax),%eax
  8019cc:	83 e8 08             	sub    $0x8,%eax
  8019cf:	8b 50 04             	mov    0x4(%eax),%edx
  8019d2:	8b 00                	mov    (%eax),%eax
  8019d4:	eb 38                	jmp    801a0e <getint+0x5d>
	else if (lflag)
  8019d6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8019da:	74 1a                	je     8019f6 <getint+0x45>
		return va_arg(*ap, long);
  8019dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019df:	8b 00                	mov    (%eax),%eax
  8019e1:	8d 50 04             	lea    0x4(%eax),%edx
  8019e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e7:	89 10                	mov    %edx,(%eax)
  8019e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ec:	8b 00                	mov    (%eax),%eax
  8019ee:	83 e8 04             	sub    $0x4,%eax
  8019f1:	8b 00                	mov    (%eax),%eax
  8019f3:	99                   	cltd   
  8019f4:	eb 18                	jmp    801a0e <getint+0x5d>
	else
		return va_arg(*ap, int);
  8019f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f9:	8b 00                	mov    (%eax),%eax
  8019fb:	8d 50 04             	lea    0x4(%eax),%edx
  8019fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801a01:	89 10                	mov    %edx,(%eax)
  801a03:	8b 45 08             	mov    0x8(%ebp),%eax
  801a06:	8b 00                	mov    (%eax),%eax
  801a08:	83 e8 04             	sub    $0x4,%eax
  801a0b:	8b 00                	mov    (%eax),%eax
  801a0d:	99                   	cltd   
}
  801a0e:	5d                   	pop    %ebp
  801a0f:	c3                   	ret    

00801a10 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801a10:	55                   	push   %ebp
  801a11:	89 e5                	mov    %esp,%ebp
  801a13:	56                   	push   %esi
  801a14:	53                   	push   %ebx
  801a15:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801a18:	eb 17                	jmp    801a31 <vprintfmt+0x21>
			if (ch == '\0')
  801a1a:	85 db                	test   %ebx,%ebx
  801a1c:	0f 84 af 03 00 00    	je     801dd1 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801a22:	83 ec 08             	sub    $0x8,%esp
  801a25:	ff 75 0c             	pushl  0xc(%ebp)
  801a28:	53                   	push   %ebx
  801a29:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2c:	ff d0                	call   *%eax
  801a2e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801a31:	8b 45 10             	mov    0x10(%ebp),%eax
  801a34:	8d 50 01             	lea    0x1(%eax),%edx
  801a37:	89 55 10             	mov    %edx,0x10(%ebp)
  801a3a:	8a 00                	mov    (%eax),%al
  801a3c:	0f b6 d8             	movzbl %al,%ebx
  801a3f:	83 fb 25             	cmp    $0x25,%ebx
  801a42:	75 d6                	jne    801a1a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801a44:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801a48:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801a4f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801a56:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801a5d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801a64:	8b 45 10             	mov    0x10(%ebp),%eax
  801a67:	8d 50 01             	lea    0x1(%eax),%edx
  801a6a:	89 55 10             	mov    %edx,0x10(%ebp)
  801a6d:	8a 00                	mov    (%eax),%al
  801a6f:	0f b6 d8             	movzbl %al,%ebx
  801a72:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801a75:	83 f8 55             	cmp    $0x55,%eax
  801a78:	0f 87 2b 03 00 00    	ja     801da9 <vprintfmt+0x399>
  801a7e:	8b 04 85 98 37 80 00 	mov    0x803798(,%eax,4),%eax
  801a85:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801a87:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801a8b:	eb d7                	jmp    801a64 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801a8d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801a91:	eb d1                	jmp    801a64 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801a93:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801a9a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a9d:	89 d0                	mov    %edx,%eax
  801a9f:	c1 e0 02             	shl    $0x2,%eax
  801aa2:	01 d0                	add    %edx,%eax
  801aa4:	01 c0                	add    %eax,%eax
  801aa6:	01 d8                	add    %ebx,%eax
  801aa8:	83 e8 30             	sub    $0x30,%eax
  801aab:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801aae:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab1:	8a 00                	mov    (%eax),%al
  801ab3:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801ab6:	83 fb 2f             	cmp    $0x2f,%ebx
  801ab9:	7e 3e                	jle    801af9 <vprintfmt+0xe9>
  801abb:	83 fb 39             	cmp    $0x39,%ebx
  801abe:	7f 39                	jg     801af9 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801ac0:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801ac3:	eb d5                	jmp    801a9a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801ac5:	8b 45 14             	mov    0x14(%ebp),%eax
  801ac8:	83 c0 04             	add    $0x4,%eax
  801acb:	89 45 14             	mov    %eax,0x14(%ebp)
  801ace:	8b 45 14             	mov    0x14(%ebp),%eax
  801ad1:	83 e8 04             	sub    $0x4,%eax
  801ad4:	8b 00                	mov    (%eax),%eax
  801ad6:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801ad9:	eb 1f                	jmp    801afa <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801adb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801adf:	79 83                	jns    801a64 <vprintfmt+0x54>
				width = 0;
  801ae1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801ae8:	e9 77 ff ff ff       	jmp    801a64 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801aed:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801af4:	e9 6b ff ff ff       	jmp    801a64 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801af9:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801afa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801afe:	0f 89 60 ff ff ff    	jns    801a64 <vprintfmt+0x54>
				width = precision, precision = -1;
  801b04:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b07:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801b0a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801b11:	e9 4e ff ff ff       	jmp    801a64 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801b16:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801b19:	e9 46 ff ff ff       	jmp    801a64 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801b1e:	8b 45 14             	mov    0x14(%ebp),%eax
  801b21:	83 c0 04             	add    $0x4,%eax
  801b24:	89 45 14             	mov    %eax,0x14(%ebp)
  801b27:	8b 45 14             	mov    0x14(%ebp),%eax
  801b2a:	83 e8 04             	sub    $0x4,%eax
  801b2d:	8b 00                	mov    (%eax),%eax
  801b2f:	83 ec 08             	sub    $0x8,%esp
  801b32:	ff 75 0c             	pushl  0xc(%ebp)
  801b35:	50                   	push   %eax
  801b36:	8b 45 08             	mov    0x8(%ebp),%eax
  801b39:	ff d0                	call   *%eax
  801b3b:	83 c4 10             	add    $0x10,%esp
			break;
  801b3e:	e9 89 02 00 00       	jmp    801dcc <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801b43:	8b 45 14             	mov    0x14(%ebp),%eax
  801b46:	83 c0 04             	add    $0x4,%eax
  801b49:	89 45 14             	mov    %eax,0x14(%ebp)
  801b4c:	8b 45 14             	mov    0x14(%ebp),%eax
  801b4f:	83 e8 04             	sub    $0x4,%eax
  801b52:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801b54:	85 db                	test   %ebx,%ebx
  801b56:	79 02                	jns    801b5a <vprintfmt+0x14a>
				err = -err;
  801b58:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801b5a:	83 fb 64             	cmp    $0x64,%ebx
  801b5d:	7f 0b                	jg     801b6a <vprintfmt+0x15a>
  801b5f:	8b 34 9d e0 35 80 00 	mov    0x8035e0(,%ebx,4),%esi
  801b66:	85 f6                	test   %esi,%esi
  801b68:	75 19                	jne    801b83 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801b6a:	53                   	push   %ebx
  801b6b:	68 85 37 80 00       	push   $0x803785
  801b70:	ff 75 0c             	pushl  0xc(%ebp)
  801b73:	ff 75 08             	pushl  0x8(%ebp)
  801b76:	e8 5e 02 00 00       	call   801dd9 <printfmt>
  801b7b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801b7e:	e9 49 02 00 00       	jmp    801dcc <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801b83:	56                   	push   %esi
  801b84:	68 8e 37 80 00       	push   $0x80378e
  801b89:	ff 75 0c             	pushl  0xc(%ebp)
  801b8c:	ff 75 08             	pushl  0x8(%ebp)
  801b8f:	e8 45 02 00 00       	call   801dd9 <printfmt>
  801b94:	83 c4 10             	add    $0x10,%esp
			break;
  801b97:	e9 30 02 00 00       	jmp    801dcc <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801b9c:	8b 45 14             	mov    0x14(%ebp),%eax
  801b9f:	83 c0 04             	add    $0x4,%eax
  801ba2:	89 45 14             	mov    %eax,0x14(%ebp)
  801ba5:	8b 45 14             	mov    0x14(%ebp),%eax
  801ba8:	83 e8 04             	sub    $0x4,%eax
  801bab:	8b 30                	mov    (%eax),%esi
  801bad:	85 f6                	test   %esi,%esi
  801baf:	75 05                	jne    801bb6 <vprintfmt+0x1a6>
				p = "(null)";
  801bb1:	be 91 37 80 00       	mov    $0x803791,%esi
			if (width > 0 && padc != '-')
  801bb6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801bba:	7e 6d                	jle    801c29 <vprintfmt+0x219>
  801bbc:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801bc0:	74 67                	je     801c29 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801bc2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801bc5:	83 ec 08             	sub    $0x8,%esp
  801bc8:	50                   	push   %eax
  801bc9:	56                   	push   %esi
  801bca:	e8 0c 03 00 00       	call   801edb <strnlen>
  801bcf:	83 c4 10             	add    $0x10,%esp
  801bd2:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801bd5:	eb 16                	jmp    801bed <vprintfmt+0x1dd>
					putch(padc, putdat);
  801bd7:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801bdb:	83 ec 08             	sub    $0x8,%esp
  801bde:	ff 75 0c             	pushl  0xc(%ebp)
  801be1:	50                   	push   %eax
  801be2:	8b 45 08             	mov    0x8(%ebp),%eax
  801be5:	ff d0                	call   *%eax
  801be7:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801bea:	ff 4d e4             	decl   -0x1c(%ebp)
  801bed:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801bf1:	7f e4                	jg     801bd7 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801bf3:	eb 34                	jmp    801c29 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801bf5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801bf9:	74 1c                	je     801c17 <vprintfmt+0x207>
  801bfb:	83 fb 1f             	cmp    $0x1f,%ebx
  801bfe:	7e 05                	jle    801c05 <vprintfmt+0x1f5>
  801c00:	83 fb 7e             	cmp    $0x7e,%ebx
  801c03:	7e 12                	jle    801c17 <vprintfmt+0x207>
					putch('?', putdat);
  801c05:	83 ec 08             	sub    $0x8,%esp
  801c08:	ff 75 0c             	pushl  0xc(%ebp)
  801c0b:	6a 3f                	push   $0x3f
  801c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c10:	ff d0                	call   *%eax
  801c12:	83 c4 10             	add    $0x10,%esp
  801c15:	eb 0f                	jmp    801c26 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801c17:	83 ec 08             	sub    $0x8,%esp
  801c1a:	ff 75 0c             	pushl  0xc(%ebp)
  801c1d:	53                   	push   %ebx
  801c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c21:	ff d0                	call   *%eax
  801c23:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801c26:	ff 4d e4             	decl   -0x1c(%ebp)
  801c29:	89 f0                	mov    %esi,%eax
  801c2b:	8d 70 01             	lea    0x1(%eax),%esi
  801c2e:	8a 00                	mov    (%eax),%al
  801c30:	0f be d8             	movsbl %al,%ebx
  801c33:	85 db                	test   %ebx,%ebx
  801c35:	74 24                	je     801c5b <vprintfmt+0x24b>
  801c37:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801c3b:	78 b8                	js     801bf5 <vprintfmt+0x1e5>
  801c3d:	ff 4d e0             	decl   -0x20(%ebp)
  801c40:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801c44:	79 af                	jns    801bf5 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c46:	eb 13                	jmp    801c5b <vprintfmt+0x24b>
				putch(' ', putdat);
  801c48:	83 ec 08             	sub    $0x8,%esp
  801c4b:	ff 75 0c             	pushl  0xc(%ebp)
  801c4e:	6a 20                	push   $0x20
  801c50:	8b 45 08             	mov    0x8(%ebp),%eax
  801c53:	ff d0                	call   *%eax
  801c55:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c58:	ff 4d e4             	decl   -0x1c(%ebp)
  801c5b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801c5f:	7f e7                	jg     801c48 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801c61:	e9 66 01 00 00       	jmp    801dcc <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801c66:	83 ec 08             	sub    $0x8,%esp
  801c69:	ff 75 e8             	pushl  -0x18(%ebp)
  801c6c:	8d 45 14             	lea    0x14(%ebp),%eax
  801c6f:	50                   	push   %eax
  801c70:	e8 3c fd ff ff       	call   8019b1 <getint>
  801c75:	83 c4 10             	add    $0x10,%esp
  801c78:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c7b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801c7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c81:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c84:	85 d2                	test   %edx,%edx
  801c86:	79 23                	jns    801cab <vprintfmt+0x29b>
				putch('-', putdat);
  801c88:	83 ec 08             	sub    $0x8,%esp
  801c8b:	ff 75 0c             	pushl  0xc(%ebp)
  801c8e:	6a 2d                	push   $0x2d
  801c90:	8b 45 08             	mov    0x8(%ebp),%eax
  801c93:	ff d0                	call   *%eax
  801c95:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801c98:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c9b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c9e:	f7 d8                	neg    %eax
  801ca0:	83 d2 00             	adc    $0x0,%edx
  801ca3:	f7 da                	neg    %edx
  801ca5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ca8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801cab:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801cb2:	e9 bc 00 00 00       	jmp    801d73 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801cb7:	83 ec 08             	sub    $0x8,%esp
  801cba:	ff 75 e8             	pushl  -0x18(%ebp)
  801cbd:	8d 45 14             	lea    0x14(%ebp),%eax
  801cc0:	50                   	push   %eax
  801cc1:	e8 84 fc ff ff       	call   80194a <getuint>
  801cc6:	83 c4 10             	add    $0x10,%esp
  801cc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ccc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801ccf:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801cd6:	e9 98 00 00 00       	jmp    801d73 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801cdb:	83 ec 08             	sub    $0x8,%esp
  801cde:	ff 75 0c             	pushl  0xc(%ebp)
  801ce1:	6a 58                	push   $0x58
  801ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce6:	ff d0                	call   *%eax
  801ce8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801ceb:	83 ec 08             	sub    $0x8,%esp
  801cee:	ff 75 0c             	pushl  0xc(%ebp)
  801cf1:	6a 58                	push   $0x58
  801cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf6:	ff d0                	call   *%eax
  801cf8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801cfb:	83 ec 08             	sub    $0x8,%esp
  801cfe:	ff 75 0c             	pushl  0xc(%ebp)
  801d01:	6a 58                	push   $0x58
  801d03:	8b 45 08             	mov    0x8(%ebp),%eax
  801d06:	ff d0                	call   *%eax
  801d08:	83 c4 10             	add    $0x10,%esp
			break;
  801d0b:	e9 bc 00 00 00       	jmp    801dcc <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801d10:	83 ec 08             	sub    $0x8,%esp
  801d13:	ff 75 0c             	pushl  0xc(%ebp)
  801d16:	6a 30                	push   $0x30
  801d18:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1b:	ff d0                	call   *%eax
  801d1d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801d20:	83 ec 08             	sub    $0x8,%esp
  801d23:	ff 75 0c             	pushl  0xc(%ebp)
  801d26:	6a 78                	push   $0x78
  801d28:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2b:	ff d0                	call   *%eax
  801d2d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801d30:	8b 45 14             	mov    0x14(%ebp),%eax
  801d33:	83 c0 04             	add    $0x4,%eax
  801d36:	89 45 14             	mov    %eax,0x14(%ebp)
  801d39:	8b 45 14             	mov    0x14(%ebp),%eax
  801d3c:	83 e8 04             	sub    $0x4,%eax
  801d3f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801d41:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d44:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801d4b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801d52:	eb 1f                	jmp    801d73 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801d54:	83 ec 08             	sub    $0x8,%esp
  801d57:	ff 75 e8             	pushl  -0x18(%ebp)
  801d5a:	8d 45 14             	lea    0x14(%ebp),%eax
  801d5d:	50                   	push   %eax
  801d5e:	e8 e7 fb ff ff       	call   80194a <getuint>
  801d63:	83 c4 10             	add    $0x10,%esp
  801d66:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d69:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801d6c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801d73:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801d77:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d7a:	83 ec 04             	sub    $0x4,%esp
  801d7d:	52                   	push   %edx
  801d7e:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d81:	50                   	push   %eax
  801d82:	ff 75 f4             	pushl  -0xc(%ebp)
  801d85:	ff 75 f0             	pushl  -0x10(%ebp)
  801d88:	ff 75 0c             	pushl  0xc(%ebp)
  801d8b:	ff 75 08             	pushl  0x8(%ebp)
  801d8e:	e8 00 fb ff ff       	call   801893 <printnum>
  801d93:	83 c4 20             	add    $0x20,%esp
			break;
  801d96:	eb 34                	jmp    801dcc <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801d98:	83 ec 08             	sub    $0x8,%esp
  801d9b:	ff 75 0c             	pushl  0xc(%ebp)
  801d9e:	53                   	push   %ebx
  801d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801da2:	ff d0                	call   *%eax
  801da4:	83 c4 10             	add    $0x10,%esp
			break;
  801da7:	eb 23                	jmp    801dcc <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801da9:	83 ec 08             	sub    $0x8,%esp
  801dac:	ff 75 0c             	pushl  0xc(%ebp)
  801daf:	6a 25                	push   $0x25
  801db1:	8b 45 08             	mov    0x8(%ebp),%eax
  801db4:	ff d0                	call   *%eax
  801db6:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801db9:	ff 4d 10             	decl   0x10(%ebp)
  801dbc:	eb 03                	jmp    801dc1 <vprintfmt+0x3b1>
  801dbe:	ff 4d 10             	decl   0x10(%ebp)
  801dc1:	8b 45 10             	mov    0x10(%ebp),%eax
  801dc4:	48                   	dec    %eax
  801dc5:	8a 00                	mov    (%eax),%al
  801dc7:	3c 25                	cmp    $0x25,%al
  801dc9:	75 f3                	jne    801dbe <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801dcb:	90                   	nop
		}
	}
  801dcc:	e9 47 fc ff ff       	jmp    801a18 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801dd1:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801dd2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801dd5:	5b                   	pop    %ebx
  801dd6:	5e                   	pop    %esi
  801dd7:	5d                   	pop    %ebp
  801dd8:	c3                   	ret    

00801dd9 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801dd9:	55                   	push   %ebp
  801dda:	89 e5                	mov    %esp,%ebp
  801ddc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801ddf:	8d 45 10             	lea    0x10(%ebp),%eax
  801de2:	83 c0 04             	add    $0x4,%eax
  801de5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801de8:	8b 45 10             	mov    0x10(%ebp),%eax
  801deb:	ff 75 f4             	pushl  -0xc(%ebp)
  801dee:	50                   	push   %eax
  801def:	ff 75 0c             	pushl  0xc(%ebp)
  801df2:	ff 75 08             	pushl  0x8(%ebp)
  801df5:	e8 16 fc ff ff       	call   801a10 <vprintfmt>
  801dfa:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801dfd:	90                   	nop
  801dfe:	c9                   	leave  
  801dff:	c3                   	ret    

00801e00 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801e00:	55                   	push   %ebp
  801e01:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801e03:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e06:	8b 40 08             	mov    0x8(%eax),%eax
  801e09:	8d 50 01             	lea    0x1(%eax),%edx
  801e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e0f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801e12:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e15:	8b 10                	mov    (%eax),%edx
  801e17:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e1a:	8b 40 04             	mov    0x4(%eax),%eax
  801e1d:	39 c2                	cmp    %eax,%edx
  801e1f:	73 12                	jae    801e33 <sprintputch+0x33>
		*b->buf++ = ch;
  801e21:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e24:	8b 00                	mov    (%eax),%eax
  801e26:	8d 48 01             	lea    0x1(%eax),%ecx
  801e29:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e2c:	89 0a                	mov    %ecx,(%edx)
  801e2e:	8b 55 08             	mov    0x8(%ebp),%edx
  801e31:	88 10                	mov    %dl,(%eax)
}
  801e33:	90                   	nop
  801e34:	5d                   	pop    %ebp
  801e35:	c3                   	ret    

00801e36 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801e36:	55                   	push   %ebp
  801e37:	89 e5                	mov    %esp,%ebp
  801e39:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801e42:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e45:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e48:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4b:	01 d0                	add    %edx,%eax
  801e4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e50:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801e57:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801e5b:	74 06                	je     801e63 <vsnprintf+0x2d>
  801e5d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801e61:	7f 07                	jg     801e6a <vsnprintf+0x34>
		return -E_INVAL;
  801e63:	b8 03 00 00 00       	mov    $0x3,%eax
  801e68:	eb 20                	jmp    801e8a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801e6a:	ff 75 14             	pushl  0x14(%ebp)
  801e6d:	ff 75 10             	pushl  0x10(%ebp)
  801e70:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801e73:	50                   	push   %eax
  801e74:	68 00 1e 80 00       	push   $0x801e00
  801e79:	e8 92 fb ff ff       	call   801a10 <vprintfmt>
  801e7e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801e81:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e84:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801e87:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801e8a:	c9                   	leave  
  801e8b:	c3                   	ret    

00801e8c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801e8c:	55                   	push   %ebp
  801e8d:	89 e5                	mov    %esp,%ebp
  801e8f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801e92:	8d 45 10             	lea    0x10(%ebp),%eax
  801e95:	83 c0 04             	add    $0x4,%eax
  801e98:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801e9b:	8b 45 10             	mov    0x10(%ebp),%eax
  801e9e:	ff 75 f4             	pushl  -0xc(%ebp)
  801ea1:	50                   	push   %eax
  801ea2:	ff 75 0c             	pushl  0xc(%ebp)
  801ea5:	ff 75 08             	pushl  0x8(%ebp)
  801ea8:	e8 89 ff ff ff       	call   801e36 <vsnprintf>
  801ead:	83 c4 10             	add    $0x10,%esp
  801eb0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801eb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801eb6:	c9                   	leave  
  801eb7:	c3                   	ret    

00801eb8 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801eb8:	55                   	push   %ebp
  801eb9:	89 e5                	mov    %esp,%ebp
  801ebb:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801ebe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801ec5:	eb 06                	jmp    801ecd <strlen+0x15>
		n++;
  801ec7:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801eca:	ff 45 08             	incl   0x8(%ebp)
  801ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed0:	8a 00                	mov    (%eax),%al
  801ed2:	84 c0                	test   %al,%al
  801ed4:	75 f1                	jne    801ec7 <strlen+0xf>
		n++;
	return n;
  801ed6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ed9:	c9                   	leave  
  801eda:	c3                   	ret    

00801edb <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801edb:	55                   	push   %ebp
  801edc:	89 e5                	mov    %esp,%ebp
  801ede:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801ee1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801ee8:	eb 09                	jmp    801ef3 <strnlen+0x18>
		n++;
  801eea:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801eed:	ff 45 08             	incl   0x8(%ebp)
  801ef0:	ff 4d 0c             	decl   0xc(%ebp)
  801ef3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801ef7:	74 09                	je     801f02 <strnlen+0x27>
  801ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  801efc:	8a 00                	mov    (%eax),%al
  801efe:	84 c0                	test   %al,%al
  801f00:	75 e8                	jne    801eea <strnlen+0xf>
		n++;
	return n;
  801f02:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801f05:	c9                   	leave  
  801f06:	c3                   	ret    

00801f07 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801f07:	55                   	push   %ebp
  801f08:	89 e5                	mov    %esp,%ebp
  801f0a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f10:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801f13:	90                   	nop
  801f14:	8b 45 08             	mov    0x8(%ebp),%eax
  801f17:	8d 50 01             	lea    0x1(%eax),%edx
  801f1a:	89 55 08             	mov    %edx,0x8(%ebp)
  801f1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f20:	8d 4a 01             	lea    0x1(%edx),%ecx
  801f23:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801f26:	8a 12                	mov    (%edx),%dl
  801f28:	88 10                	mov    %dl,(%eax)
  801f2a:	8a 00                	mov    (%eax),%al
  801f2c:	84 c0                	test   %al,%al
  801f2e:	75 e4                	jne    801f14 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801f30:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801f33:	c9                   	leave  
  801f34:	c3                   	ret    

00801f35 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801f35:	55                   	push   %ebp
  801f36:	89 e5                	mov    %esp,%ebp
  801f38:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801f41:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801f48:	eb 1f                	jmp    801f69 <strncpy+0x34>
		*dst++ = *src;
  801f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4d:	8d 50 01             	lea    0x1(%eax),%edx
  801f50:	89 55 08             	mov    %edx,0x8(%ebp)
  801f53:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f56:	8a 12                	mov    (%edx),%dl
  801f58:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f5d:	8a 00                	mov    (%eax),%al
  801f5f:	84 c0                	test   %al,%al
  801f61:	74 03                	je     801f66 <strncpy+0x31>
			src++;
  801f63:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801f66:	ff 45 fc             	incl   -0x4(%ebp)
  801f69:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f6c:	3b 45 10             	cmp    0x10(%ebp),%eax
  801f6f:	72 d9                	jb     801f4a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801f71:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801f74:	c9                   	leave  
  801f75:	c3                   	ret    

00801f76 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801f76:	55                   	push   %ebp
  801f77:	89 e5                	mov    %esp,%ebp
  801f79:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801f82:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f86:	74 30                	je     801fb8 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801f88:	eb 16                	jmp    801fa0 <strlcpy+0x2a>
			*dst++ = *src++;
  801f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8d:	8d 50 01             	lea    0x1(%eax),%edx
  801f90:	89 55 08             	mov    %edx,0x8(%ebp)
  801f93:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f96:	8d 4a 01             	lea    0x1(%edx),%ecx
  801f99:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801f9c:	8a 12                	mov    (%edx),%dl
  801f9e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801fa0:	ff 4d 10             	decl   0x10(%ebp)
  801fa3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801fa7:	74 09                	je     801fb2 <strlcpy+0x3c>
  801fa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fac:	8a 00                	mov    (%eax),%al
  801fae:	84 c0                	test   %al,%al
  801fb0:	75 d8                	jne    801f8a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb5:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801fb8:	8b 55 08             	mov    0x8(%ebp),%edx
  801fbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801fbe:	29 c2                	sub    %eax,%edx
  801fc0:	89 d0                	mov    %edx,%eax
}
  801fc2:	c9                   	leave  
  801fc3:	c3                   	ret    

00801fc4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801fc4:	55                   	push   %ebp
  801fc5:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801fc7:	eb 06                	jmp    801fcf <strcmp+0xb>
		p++, q++;
  801fc9:	ff 45 08             	incl   0x8(%ebp)
  801fcc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd2:	8a 00                	mov    (%eax),%al
  801fd4:	84 c0                	test   %al,%al
  801fd6:	74 0e                	je     801fe6 <strcmp+0x22>
  801fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  801fdb:	8a 10                	mov    (%eax),%dl
  801fdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fe0:	8a 00                	mov    (%eax),%al
  801fe2:	38 c2                	cmp    %al,%dl
  801fe4:	74 e3                	je     801fc9 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801fe6:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe9:	8a 00                	mov    (%eax),%al
  801feb:	0f b6 d0             	movzbl %al,%edx
  801fee:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ff1:	8a 00                	mov    (%eax),%al
  801ff3:	0f b6 c0             	movzbl %al,%eax
  801ff6:	29 c2                	sub    %eax,%edx
  801ff8:	89 d0                	mov    %edx,%eax
}
  801ffa:	5d                   	pop    %ebp
  801ffb:	c3                   	ret    

00801ffc <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801ffc:	55                   	push   %ebp
  801ffd:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801fff:	eb 09                	jmp    80200a <strncmp+0xe>
		n--, p++, q++;
  802001:	ff 4d 10             	decl   0x10(%ebp)
  802004:	ff 45 08             	incl   0x8(%ebp)
  802007:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80200a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80200e:	74 17                	je     802027 <strncmp+0x2b>
  802010:	8b 45 08             	mov    0x8(%ebp),%eax
  802013:	8a 00                	mov    (%eax),%al
  802015:	84 c0                	test   %al,%al
  802017:	74 0e                	je     802027 <strncmp+0x2b>
  802019:	8b 45 08             	mov    0x8(%ebp),%eax
  80201c:	8a 10                	mov    (%eax),%dl
  80201e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802021:	8a 00                	mov    (%eax),%al
  802023:	38 c2                	cmp    %al,%dl
  802025:	74 da                	je     802001 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  802027:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80202b:	75 07                	jne    802034 <strncmp+0x38>
		return 0;
  80202d:	b8 00 00 00 00       	mov    $0x0,%eax
  802032:	eb 14                	jmp    802048 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  802034:	8b 45 08             	mov    0x8(%ebp),%eax
  802037:	8a 00                	mov    (%eax),%al
  802039:	0f b6 d0             	movzbl %al,%edx
  80203c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80203f:	8a 00                	mov    (%eax),%al
  802041:	0f b6 c0             	movzbl %al,%eax
  802044:	29 c2                	sub    %eax,%edx
  802046:	89 d0                	mov    %edx,%eax
}
  802048:	5d                   	pop    %ebp
  802049:	c3                   	ret    

0080204a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80204a:	55                   	push   %ebp
  80204b:	89 e5                	mov    %esp,%ebp
  80204d:	83 ec 04             	sub    $0x4,%esp
  802050:	8b 45 0c             	mov    0xc(%ebp),%eax
  802053:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802056:	eb 12                	jmp    80206a <strchr+0x20>
		if (*s == c)
  802058:	8b 45 08             	mov    0x8(%ebp),%eax
  80205b:	8a 00                	mov    (%eax),%al
  80205d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802060:	75 05                	jne    802067 <strchr+0x1d>
			return (char *) s;
  802062:	8b 45 08             	mov    0x8(%ebp),%eax
  802065:	eb 11                	jmp    802078 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  802067:	ff 45 08             	incl   0x8(%ebp)
  80206a:	8b 45 08             	mov    0x8(%ebp),%eax
  80206d:	8a 00                	mov    (%eax),%al
  80206f:	84 c0                	test   %al,%al
  802071:	75 e5                	jne    802058 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  802073:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802078:	c9                   	leave  
  802079:	c3                   	ret    

0080207a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80207a:	55                   	push   %ebp
  80207b:	89 e5                	mov    %esp,%ebp
  80207d:	83 ec 04             	sub    $0x4,%esp
  802080:	8b 45 0c             	mov    0xc(%ebp),%eax
  802083:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802086:	eb 0d                	jmp    802095 <strfind+0x1b>
		if (*s == c)
  802088:	8b 45 08             	mov    0x8(%ebp),%eax
  80208b:	8a 00                	mov    (%eax),%al
  80208d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802090:	74 0e                	je     8020a0 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  802092:	ff 45 08             	incl   0x8(%ebp)
  802095:	8b 45 08             	mov    0x8(%ebp),%eax
  802098:	8a 00                	mov    (%eax),%al
  80209a:	84 c0                	test   %al,%al
  80209c:	75 ea                	jne    802088 <strfind+0xe>
  80209e:	eb 01                	jmp    8020a1 <strfind+0x27>
		if (*s == c)
			break;
  8020a0:	90                   	nop
	return (char *) s;
  8020a1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8020a4:	c9                   	leave  
  8020a5:	c3                   	ret    

008020a6 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8020a6:	55                   	push   %ebp
  8020a7:	89 e5                	mov    %esp,%ebp
  8020a9:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8020ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8020af:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8020b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8020b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8020b8:	eb 0e                	jmp    8020c8 <memset+0x22>
		*p++ = c;
  8020ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020bd:	8d 50 01             	lea    0x1(%eax),%edx
  8020c0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8020c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020c6:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8020c8:	ff 4d f8             	decl   -0x8(%ebp)
  8020cb:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8020cf:	79 e9                	jns    8020ba <memset+0x14>
		*p++ = c;

	return v;
  8020d1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8020d4:	c9                   	leave  
  8020d5:	c3                   	ret    

008020d6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8020d6:	55                   	push   %ebp
  8020d7:	89 e5                	mov    %esp,%ebp
  8020d9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8020dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8020e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8020e8:	eb 16                	jmp    802100 <memcpy+0x2a>
		*d++ = *s++;
  8020ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020ed:	8d 50 01             	lea    0x1(%eax),%edx
  8020f0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8020f3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020f6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8020f9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8020fc:	8a 12                	mov    (%edx),%dl
  8020fe:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  802100:	8b 45 10             	mov    0x10(%ebp),%eax
  802103:	8d 50 ff             	lea    -0x1(%eax),%edx
  802106:	89 55 10             	mov    %edx,0x10(%ebp)
  802109:	85 c0                	test   %eax,%eax
  80210b:	75 dd                	jne    8020ea <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80210d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802110:	c9                   	leave  
  802111:	c3                   	ret    

00802112 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  802112:	55                   	push   %ebp
  802113:	89 e5                	mov    %esp,%ebp
  802115:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  802118:	8b 45 0c             	mov    0xc(%ebp),%eax
  80211b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80211e:	8b 45 08             	mov    0x8(%ebp),%eax
  802121:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  802124:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802127:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80212a:	73 50                	jae    80217c <memmove+0x6a>
  80212c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80212f:	8b 45 10             	mov    0x10(%ebp),%eax
  802132:	01 d0                	add    %edx,%eax
  802134:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802137:	76 43                	jbe    80217c <memmove+0x6a>
		s += n;
  802139:	8b 45 10             	mov    0x10(%ebp),%eax
  80213c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80213f:	8b 45 10             	mov    0x10(%ebp),%eax
  802142:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  802145:	eb 10                	jmp    802157 <memmove+0x45>
			*--d = *--s;
  802147:	ff 4d f8             	decl   -0x8(%ebp)
  80214a:	ff 4d fc             	decl   -0x4(%ebp)
  80214d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802150:	8a 10                	mov    (%eax),%dl
  802152:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802155:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  802157:	8b 45 10             	mov    0x10(%ebp),%eax
  80215a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80215d:	89 55 10             	mov    %edx,0x10(%ebp)
  802160:	85 c0                	test   %eax,%eax
  802162:	75 e3                	jne    802147 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  802164:	eb 23                	jmp    802189 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  802166:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802169:	8d 50 01             	lea    0x1(%eax),%edx
  80216c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80216f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802172:	8d 4a 01             	lea    0x1(%edx),%ecx
  802175:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802178:	8a 12                	mov    (%edx),%dl
  80217a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80217c:	8b 45 10             	mov    0x10(%ebp),%eax
  80217f:	8d 50 ff             	lea    -0x1(%eax),%edx
  802182:	89 55 10             	mov    %edx,0x10(%ebp)
  802185:	85 c0                	test   %eax,%eax
  802187:	75 dd                	jne    802166 <memmove+0x54>
			*d++ = *s++;

	return dst;
  802189:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80218c:	c9                   	leave  
  80218d:	c3                   	ret    

0080218e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80218e:	55                   	push   %ebp
  80218f:	89 e5                	mov    %esp,%ebp
  802191:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  802194:	8b 45 08             	mov    0x8(%ebp),%eax
  802197:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80219a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80219d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8021a0:	eb 2a                	jmp    8021cc <memcmp+0x3e>
		if (*s1 != *s2)
  8021a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021a5:	8a 10                	mov    (%eax),%dl
  8021a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021aa:	8a 00                	mov    (%eax),%al
  8021ac:	38 c2                	cmp    %al,%dl
  8021ae:	74 16                	je     8021c6 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8021b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021b3:	8a 00                	mov    (%eax),%al
  8021b5:	0f b6 d0             	movzbl %al,%edx
  8021b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021bb:	8a 00                	mov    (%eax),%al
  8021bd:	0f b6 c0             	movzbl %al,%eax
  8021c0:	29 c2                	sub    %eax,%edx
  8021c2:	89 d0                	mov    %edx,%eax
  8021c4:	eb 18                	jmp    8021de <memcmp+0x50>
		s1++, s2++;
  8021c6:	ff 45 fc             	incl   -0x4(%ebp)
  8021c9:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8021cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8021cf:	8d 50 ff             	lea    -0x1(%eax),%edx
  8021d2:	89 55 10             	mov    %edx,0x10(%ebp)
  8021d5:	85 c0                	test   %eax,%eax
  8021d7:	75 c9                	jne    8021a2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8021d9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021de:	c9                   	leave  
  8021df:	c3                   	ret    

008021e0 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8021e0:	55                   	push   %ebp
  8021e1:	89 e5                	mov    %esp,%ebp
  8021e3:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8021e6:	8b 55 08             	mov    0x8(%ebp),%edx
  8021e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8021ec:	01 d0                	add    %edx,%eax
  8021ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8021f1:	eb 15                	jmp    802208 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8021f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021f6:	8a 00                	mov    (%eax),%al
  8021f8:	0f b6 d0             	movzbl %al,%edx
  8021fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021fe:	0f b6 c0             	movzbl %al,%eax
  802201:	39 c2                	cmp    %eax,%edx
  802203:	74 0d                	je     802212 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  802205:	ff 45 08             	incl   0x8(%ebp)
  802208:	8b 45 08             	mov    0x8(%ebp),%eax
  80220b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80220e:	72 e3                	jb     8021f3 <memfind+0x13>
  802210:	eb 01                	jmp    802213 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  802212:	90                   	nop
	return (void *) s;
  802213:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802216:	c9                   	leave  
  802217:	c3                   	ret    

00802218 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  802218:	55                   	push   %ebp
  802219:	89 e5                	mov    %esp,%ebp
  80221b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80221e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  802225:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80222c:	eb 03                	jmp    802231 <strtol+0x19>
		s++;
  80222e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802231:	8b 45 08             	mov    0x8(%ebp),%eax
  802234:	8a 00                	mov    (%eax),%al
  802236:	3c 20                	cmp    $0x20,%al
  802238:	74 f4                	je     80222e <strtol+0x16>
  80223a:	8b 45 08             	mov    0x8(%ebp),%eax
  80223d:	8a 00                	mov    (%eax),%al
  80223f:	3c 09                	cmp    $0x9,%al
  802241:	74 eb                	je     80222e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  802243:	8b 45 08             	mov    0x8(%ebp),%eax
  802246:	8a 00                	mov    (%eax),%al
  802248:	3c 2b                	cmp    $0x2b,%al
  80224a:	75 05                	jne    802251 <strtol+0x39>
		s++;
  80224c:	ff 45 08             	incl   0x8(%ebp)
  80224f:	eb 13                	jmp    802264 <strtol+0x4c>
	else if (*s == '-')
  802251:	8b 45 08             	mov    0x8(%ebp),%eax
  802254:	8a 00                	mov    (%eax),%al
  802256:	3c 2d                	cmp    $0x2d,%al
  802258:	75 0a                	jne    802264 <strtol+0x4c>
		s++, neg = 1;
  80225a:	ff 45 08             	incl   0x8(%ebp)
  80225d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  802264:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802268:	74 06                	je     802270 <strtol+0x58>
  80226a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80226e:	75 20                	jne    802290 <strtol+0x78>
  802270:	8b 45 08             	mov    0x8(%ebp),%eax
  802273:	8a 00                	mov    (%eax),%al
  802275:	3c 30                	cmp    $0x30,%al
  802277:	75 17                	jne    802290 <strtol+0x78>
  802279:	8b 45 08             	mov    0x8(%ebp),%eax
  80227c:	40                   	inc    %eax
  80227d:	8a 00                	mov    (%eax),%al
  80227f:	3c 78                	cmp    $0x78,%al
  802281:	75 0d                	jne    802290 <strtol+0x78>
		s += 2, base = 16;
  802283:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  802287:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80228e:	eb 28                	jmp    8022b8 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  802290:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802294:	75 15                	jne    8022ab <strtol+0x93>
  802296:	8b 45 08             	mov    0x8(%ebp),%eax
  802299:	8a 00                	mov    (%eax),%al
  80229b:	3c 30                	cmp    $0x30,%al
  80229d:	75 0c                	jne    8022ab <strtol+0x93>
		s++, base = 8;
  80229f:	ff 45 08             	incl   0x8(%ebp)
  8022a2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8022a9:	eb 0d                	jmp    8022b8 <strtol+0xa0>
	else if (base == 0)
  8022ab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8022af:	75 07                	jne    8022b8 <strtol+0xa0>
		base = 10;
  8022b1:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8022b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8022bb:	8a 00                	mov    (%eax),%al
  8022bd:	3c 2f                	cmp    $0x2f,%al
  8022bf:	7e 19                	jle    8022da <strtol+0xc2>
  8022c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8022c4:	8a 00                	mov    (%eax),%al
  8022c6:	3c 39                	cmp    $0x39,%al
  8022c8:	7f 10                	jg     8022da <strtol+0xc2>
			dig = *s - '0';
  8022ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8022cd:	8a 00                	mov    (%eax),%al
  8022cf:	0f be c0             	movsbl %al,%eax
  8022d2:	83 e8 30             	sub    $0x30,%eax
  8022d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8022d8:	eb 42                	jmp    80231c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8022da:	8b 45 08             	mov    0x8(%ebp),%eax
  8022dd:	8a 00                	mov    (%eax),%al
  8022df:	3c 60                	cmp    $0x60,%al
  8022e1:	7e 19                	jle    8022fc <strtol+0xe4>
  8022e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e6:	8a 00                	mov    (%eax),%al
  8022e8:	3c 7a                	cmp    $0x7a,%al
  8022ea:	7f 10                	jg     8022fc <strtol+0xe4>
			dig = *s - 'a' + 10;
  8022ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ef:	8a 00                	mov    (%eax),%al
  8022f1:	0f be c0             	movsbl %al,%eax
  8022f4:	83 e8 57             	sub    $0x57,%eax
  8022f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8022fa:	eb 20                	jmp    80231c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8022fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ff:	8a 00                	mov    (%eax),%al
  802301:	3c 40                	cmp    $0x40,%al
  802303:	7e 39                	jle    80233e <strtol+0x126>
  802305:	8b 45 08             	mov    0x8(%ebp),%eax
  802308:	8a 00                	mov    (%eax),%al
  80230a:	3c 5a                	cmp    $0x5a,%al
  80230c:	7f 30                	jg     80233e <strtol+0x126>
			dig = *s - 'A' + 10;
  80230e:	8b 45 08             	mov    0x8(%ebp),%eax
  802311:	8a 00                	mov    (%eax),%al
  802313:	0f be c0             	movsbl %al,%eax
  802316:	83 e8 37             	sub    $0x37,%eax
  802319:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80231c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80231f:	3b 45 10             	cmp    0x10(%ebp),%eax
  802322:	7d 19                	jge    80233d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  802324:	ff 45 08             	incl   0x8(%ebp)
  802327:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80232a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80232e:	89 c2                	mov    %eax,%edx
  802330:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802333:	01 d0                	add    %edx,%eax
  802335:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  802338:	e9 7b ff ff ff       	jmp    8022b8 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80233d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80233e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802342:	74 08                	je     80234c <strtol+0x134>
		*endptr = (char *) s;
  802344:	8b 45 0c             	mov    0xc(%ebp),%eax
  802347:	8b 55 08             	mov    0x8(%ebp),%edx
  80234a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80234c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802350:	74 07                	je     802359 <strtol+0x141>
  802352:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802355:	f7 d8                	neg    %eax
  802357:	eb 03                	jmp    80235c <strtol+0x144>
  802359:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80235c:	c9                   	leave  
  80235d:	c3                   	ret    

0080235e <ltostr>:

void
ltostr(long value, char *str)
{
  80235e:	55                   	push   %ebp
  80235f:	89 e5                	mov    %esp,%ebp
  802361:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  802364:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80236b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  802372:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802376:	79 13                	jns    80238b <ltostr+0x2d>
	{
		neg = 1;
  802378:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80237f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802382:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  802385:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802388:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80238b:	8b 45 08             	mov    0x8(%ebp),%eax
  80238e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  802393:	99                   	cltd   
  802394:	f7 f9                	idiv   %ecx
  802396:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802399:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80239c:	8d 50 01             	lea    0x1(%eax),%edx
  80239f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8023a2:	89 c2                	mov    %eax,%edx
  8023a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023a7:	01 d0                	add    %edx,%eax
  8023a9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8023ac:	83 c2 30             	add    $0x30,%edx
  8023af:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8023b1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8023b4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8023b9:	f7 e9                	imul   %ecx
  8023bb:	c1 fa 02             	sar    $0x2,%edx
  8023be:	89 c8                	mov    %ecx,%eax
  8023c0:	c1 f8 1f             	sar    $0x1f,%eax
  8023c3:	29 c2                	sub    %eax,%edx
  8023c5:	89 d0                	mov    %edx,%eax
  8023c7:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8023ca:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8023cd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8023d2:	f7 e9                	imul   %ecx
  8023d4:	c1 fa 02             	sar    $0x2,%edx
  8023d7:	89 c8                	mov    %ecx,%eax
  8023d9:	c1 f8 1f             	sar    $0x1f,%eax
  8023dc:	29 c2                	sub    %eax,%edx
  8023de:	89 d0                	mov    %edx,%eax
  8023e0:	c1 e0 02             	shl    $0x2,%eax
  8023e3:	01 d0                	add    %edx,%eax
  8023e5:	01 c0                	add    %eax,%eax
  8023e7:	29 c1                	sub    %eax,%ecx
  8023e9:	89 ca                	mov    %ecx,%edx
  8023eb:	85 d2                	test   %edx,%edx
  8023ed:	75 9c                	jne    80238b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8023ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8023f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023f9:	48                   	dec    %eax
  8023fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8023fd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802401:	74 3d                	je     802440 <ltostr+0xe2>
		start = 1 ;
  802403:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80240a:	eb 34                	jmp    802440 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80240c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80240f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802412:	01 d0                	add    %edx,%eax
  802414:	8a 00                	mov    (%eax),%al
  802416:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  802419:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80241c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80241f:	01 c2                	add    %eax,%edx
  802421:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  802424:	8b 45 0c             	mov    0xc(%ebp),%eax
  802427:	01 c8                	add    %ecx,%eax
  802429:	8a 00                	mov    (%eax),%al
  80242b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80242d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802430:	8b 45 0c             	mov    0xc(%ebp),%eax
  802433:	01 c2                	add    %eax,%edx
  802435:	8a 45 eb             	mov    -0x15(%ebp),%al
  802438:	88 02                	mov    %al,(%edx)
		start++ ;
  80243a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80243d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  802440:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802443:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802446:	7c c4                	jl     80240c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  802448:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80244b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80244e:	01 d0                	add    %edx,%eax
  802450:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  802453:	90                   	nop
  802454:	c9                   	leave  
  802455:	c3                   	ret    

00802456 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802456:	55                   	push   %ebp
  802457:	89 e5                	mov    %esp,%ebp
  802459:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80245c:	ff 75 08             	pushl  0x8(%ebp)
  80245f:	e8 54 fa ff ff       	call   801eb8 <strlen>
  802464:	83 c4 04             	add    $0x4,%esp
  802467:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80246a:	ff 75 0c             	pushl  0xc(%ebp)
  80246d:	e8 46 fa ff ff       	call   801eb8 <strlen>
  802472:	83 c4 04             	add    $0x4,%esp
  802475:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802478:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80247f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802486:	eb 17                	jmp    80249f <strcconcat+0x49>
		final[s] = str1[s] ;
  802488:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80248b:	8b 45 10             	mov    0x10(%ebp),%eax
  80248e:	01 c2                	add    %eax,%edx
  802490:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  802493:	8b 45 08             	mov    0x8(%ebp),%eax
  802496:	01 c8                	add    %ecx,%eax
  802498:	8a 00                	mov    (%eax),%al
  80249a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80249c:	ff 45 fc             	incl   -0x4(%ebp)
  80249f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024a2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8024a5:	7c e1                	jl     802488 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8024a7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8024ae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8024b5:	eb 1f                	jmp    8024d6 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8024b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024ba:	8d 50 01             	lea    0x1(%eax),%edx
  8024bd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8024c0:	89 c2                	mov    %eax,%edx
  8024c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8024c5:	01 c2                	add    %eax,%edx
  8024c7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8024ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024cd:	01 c8                	add    %ecx,%eax
  8024cf:	8a 00                	mov    (%eax),%al
  8024d1:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8024d3:	ff 45 f8             	incl   -0x8(%ebp)
  8024d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8024d9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8024dc:	7c d9                	jl     8024b7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8024de:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8024e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8024e4:	01 d0                	add    %edx,%eax
  8024e6:	c6 00 00             	movb   $0x0,(%eax)
}
  8024e9:	90                   	nop
  8024ea:	c9                   	leave  
  8024eb:	c3                   	ret    

008024ec <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8024ec:	55                   	push   %ebp
  8024ed:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8024ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8024f2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8024f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8024fb:	8b 00                	mov    (%eax),%eax
  8024fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802504:	8b 45 10             	mov    0x10(%ebp),%eax
  802507:	01 d0                	add    %edx,%eax
  802509:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80250f:	eb 0c                	jmp    80251d <strsplit+0x31>
			*string++ = 0;
  802511:	8b 45 08             	mov    0x8(%ebp),%eax
  802514:	8d 50 01             	lea    0x1(%eax),%edx
  802517:	89 55 08             	mov    %edx,0x8(%ebp)
  80251a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80251d:	8b 45 08             	mov    0x8(%ebp),%eax
  802520:	8a 00                	mov    (%eax),%al
  802522:	84 c0                	test   %al,%al
  802524:	74 18                	je     80253e <strsplit+0x52>
  802526:	8b 45 08             	mov    0x8(%ebp),%eax
  802529:	8a 00                	mov    (%eax),%al
  80252b:	0f be c0             	movsbl %al,%eax
  80252e:	50                   	push   %eax
  80252f:	ff 75 0c             	pushl  0xc(%ebp)
  802532:	e8 13 fb ff ff       	call   80204a <strchr>
  802537:	83 c4 08             	add    $0x8,%esp
  80253a:	85 c0                	test   %eax,%eax
  80253c:	75 d3                	jne    802511 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80253e:	8b 45 08             	mov    0x8(%ebp),%eax
  802541:	8a 00                	mov    (%eax),%al
  802543:	84 c0                	test   %al,%al
  802545:	74 5a                	je     8025a1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  802547:	8b 45 14             	mov    0x14(%ebp),%eax
  80254a:	8b 00                	mov    (%eax),%eax
  80254c:	83 f8 0f             	cmp    $0xf,%eax
  80254f:	75 07                	jne    802558 <strsplit+0x6c>
		{
			return 0;
  802551:	b8 00 00 00 00       	mov    $0x0,%eax
  802556:	eb 66                	jmp    8025be <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  802558:	8b 45 14             	mov    0x14(%ebp),%eax
  80255b:	8b 00                	mov    (%eax),%eax
  80255d:	8d 48 01             	lea    0x1(%eax),%ecx
  802560:	8b 55 14             	mov    0x14(%ebp),%edx
  802563:	89 0a                	mov    %ecx,(%edx)
  802565:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80256c:	8b 45 10             	mov    0x10(%ebp),%eax
  80256f:	01 c2                	add    %eax,%edx
  802571:	8b 45 08             	mov    0x8(%ebp),%eax
  802574:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802576:	eb 03                	jmp    80257b <strsplit+0x8f>
			string++;
  802578:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80257b:	8b 45 08             	mov    0x8(%ebp),%eax
  80257e:	8a 00                	mov    (%eax),%al
  802580:	84 c0                	test   %al,%al
  802582:	74 8b                	je     80250f <strsplit+0x23>
  802584:	8b 45 08             	mov    0x8(%ebp),%eax
  802587:	8a 00                	mov    (%eax),%al
  802589:	0f be c0             	movsbl %al,%eax
  80258c:	50                   	push   %eax
  80258d:	ff 75 0c             	pushl  0xc(%ebp)
  802590:	e8 b5 fa ff ff       	call   80204a <strchr>
  802595:	83 c4 08             	add    $0x8,%esp
  802598:	85 c0                	test   %eax,%eax
  80259a:	74 dc                	je     802578 <strsplit+0x8c>
			string++;
	}
  80259c:	e9 6e ff ff ff       	jmp    80250f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8025a1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8025a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8025a5:	8b 00                	mov    (%eax),%eax
  8025a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8025ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8025b1:	01 d0                	add    %edx,%eax
  8025b3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8025b9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8025be:	c9                   	leave  
  8025bf:	c3                   	ret    

008025c0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8025c0:	55                   	push   %ebp
  8025c1:	89 e5                	mov    %esp,%ebp
  8025c3:	57                   	push   %edi
  8025c4:	56                   	push   %esi
  8025c5:	53                   	push   %ebx
  8025c6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8025c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8025cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8025cf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8025d2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8025d5:	8b 7d 18             	mov    0x18(%ebp),%edi
  8025d8:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8025db:	cd 30                	int    $0x30
  8025dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8025e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8025e3:	83 c4 10             	add    $0x10,%esp
  8025e6:	5b                   	pop    %ebx
  8025e7:	5e                   	pop    %esi
  8025e8:	5f                   	pop    %edi
  8025e9:	5d                   	pop    %ebp
  8025ea:	c3                   	ret    

008025eb <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8025eb:	55                   	push   %ebp
  8025ec:	89 e5                	mov    %esp,%ebp
  8025ee:	83 ec 04             	sub    $0x4,%esp
  8025f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8025f4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8025f7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8025fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8025fe:	6a 00                	push   $0x0
  802600:	6a 00                	push   $0x0
  802602:	52                   	push   %edx
  802603:	ff 75 0c             	pushl  0xc(%ebp)
  802606:	50                   	push   %eax
  802607:	6a 00                	push   $0x0
  802609:	e8 b2 ff ff ff       	call   8025c0 <syscall>
  80260e:	83 c4 18             	add    $0x18,%esp
}
  802611:	90                   	nop
  802612:	c9                   	leave  
  802613:	c3                   	ret    

00802614 <sys_cgetc>:

int
sys_cgetc(void)
{
  802614:	55                   	push   %ebp
  802615:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802617:	6a 00                	push   $0x0
  802619:	6a 00                	push   $0x0
  80261b:	6a 00                	push   $0x0
  80261d:	6a 00                	push   $0x0
  80261f:	6a 00                	push   $0x0
  802621:	6a 01                	push   $0x1
  802623:	e8 98 ff ff ff       	call   8025c0 <syscall>
  802628:	83 c4 18             	add    $0x18,%esp
}
  80262b:	c9                   	leave  
  80262c:	c3                   	ret    

0080262d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80262d:	55                   	push   %ebp
  80262e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802630:	8b 45 08             	mov    0x8(%ebp),%eax
  802633:	6a 00                	push   $0x0
  802635:	6a 00                	push   $0x0
  802637:	6a 00                	push   $0x0
  802639:	6a 00                	push   $0x0
  80263b:	50                   	push   %eax
  80263c:	6a 05                	push   $0x5
  80263e:	e8 7d ff ff ff       	call   8025c0 <syscall>
  802643:	83 c4 18             	add    $0x18,%esp
}
  802646:	c9                   	leave  
  802647:	c3                   	ret    

00802648 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802648:	55                   	push   %ebp
  802649:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80264b:	6a 00                	push   $0x0
  80264d:	6a 00                	push   $0x0
  80264f:	6a 00                	push   $0x0
  802651:	6a 00                	push   $0x0
  802653:	6a 00                	push   $0x0
  802655:	6a 02                	push   $0x2
  802657:	e8 64 ff ff ff       	call   8025c0 <syscall>
  80265c:	83 c4 18             	add    $0x18,%esp
}
  80265f:	c9                   	leave  
  802660:	c3                   	ret    

00802661 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802661:	55                   	push   %ebp
  802662:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802664:	6a 00                	push   $0x0
  802666:	6a 00                	push   $0x0
  802668:	6a 00                	push   $0x0
  80266a:	6a 00                	push   $0x0
  80266c:	6a 00                	push   $0x0
  80266e:	6a 03                	push   $0x3
  802670:	e8 4b ff ff ff       	call   8025c0 <syscall>
  802675:	83 c4 18             	add    $0x18,%esp
}
  802678:	c9                   	leave  
  802679:	c3                   	ret    

0080267a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80267a:	55                   	push   %ebp
  80267b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80267d:	6a 00                	push   $0x0
  80267f:	6a 00                	push   $0x0
  802681:	6a 00                	push   $0x0
  802683:	6a 00                	push   $0x0
  802685:	6a 00                	push   $0x0
  802687:	6a 04                	push   $0x4
  802689:	e8 32 ff ff ff       	call   8025c0 <syscall>
  80268e:	83 c4 18             	add    $0x18,%esp
}
  802691:	c9                   	leave  
  802692:	c3                   	ret    

00802693 <sys_env_exit>:


void sys_env_exit(void)
{
  802693:	55                   	push   %ebp
  802694:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802696:	6a 00                	push   $0x0
  802698:	6a 00                	push   $0x0
  80269a:	6a 00                	push   $0x0
  80269c:	6a 00                	push   $0x0
  80269e:	6a 00                	push   $0x0
  8026a0:	6a 06                	push   $0x6
  8026a2:	e8 19 ff ff ff       	call   8025c0 <syscall>
  8026a7:	83 c4 18             	add    $0x18,%esp
}
  8026aa:	90                   	nop
  8026ab:	c9                   	leave  
  8026ac:	c3                   	ret    

008026ad <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8026ad:	55                   	push   %ebp
  8026ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8026b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8026b6:	6a 00                	push   $0x0
  8026b8:	6a 00                	push   $0x0
  8026ba:	6a 00                	push   $0x0
  8026bc:	52                   	push   %edx
  8026bd:	50                   	push   %eax
  8026be:	6a 07                	push   $0x7
  8026c0:	e8 fb fe ff ff       	call   8025c0 <syscall>
  8026c5:	83 c4 18             	add    $0x18,%esp
}
  8026c8:	c9                   	leave  
  8026c9:	c3                   	ret    

008026ca <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8026ca:	55                   	push   %ebp
  8026cb:	89 e5                	mov    %esp,%ebp
  8026cd:	56                   	push   %esi
  8026ce:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8026cf:	8b 75 18             	mov    0x18(%ebp),%esi
  8026d2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8026d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8026d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026db:	8b 45 08             	mov    0x8(%ebp),%eax
  8026de:	56                   	push   %esi
  8026df:	53                   	push   %ebx
  8026e0:	51                   	push   %ecx
  8026e1:	52                   	push   %edx
  8026e2:	50                   	push   %eax
  8026e3:	6a 08                	push   $0x8
  8026e5:	e8 d6 fe ff ff       	call   8025c0 <syscall>
  8026ea:	83 c4 18             	add    $0x18,%esp
}
  8026ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8026f0:	5b                   	pop    %ebx
  8026f1:	5e                   	pop    %esi
  8026f2:	5d                   	pop    %ebp
  8026f3:	c3                   	ret    

008026f4 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8026f4:	55                   	push   %ebp
  8026f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8026f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8026fd:	6a 00                	push   $0x0
  8026ff:	6a 00                	push   $0x0
  802701:	6a 00                	push   $0x0
  802703:	52                   	push   %edx
  802704:	50                   	push   %eax
  802705:	6a 09                	push   $0x9
  802707:	e8 b4 fe ff ff       	call   8025c0 <syscall>
  80270c:	83 c4 18             	add    $0x18,%esp
}
  80270f:	c9                   	leave  
  802710:	c3                   	ret    

00802711 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802711:	55                   	push   %ebp
  802712:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802714:	6a 00                	push   $0x0
  802716:	6a 00                	push   $0x0
  802718:	6a 00                	push   $0x0
  80271a:	ff 75 0c             	pushl  0xc(%ebp)
  80271d:	ff 75 08             	pushl  0x8(%ebp)
  802720:	6a 0a                	push   $0xa
  802722:	e8 99 fe ff ff       	call   8025c0 <syscall>
  802727:	83 c4 18             	add    $0x18,%esp
}
  80272a:	c9                   	leave  
  80272b:	c3                   	ret    

0080272c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80272c:	55                   	push   %ebp
  80272d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80272f:	6a 00                	push   $0x0
  802731:	6a 00                	push   $0x0
  802733:	6a 00                	push   $0x0
  802735:	6a 00                	push   $0x0
  802737:	6a 00                	push   $0x0
  802739:	6a 0b                	push   $0xb
  80273b:	e8 80 fe ff ff       	call   8025c0 <syscall>
  802740:	83 c4 18             	add    $0x18,%esp
}
  802743:	c9                   	leave  
  802744:	c3                   	ret    

00802745 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802745:	55                   	push   %ebp
  802746:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802748:	6a 00                	push   $0x0
  80274a:	6a 00                	push   $0x0
  80274c:	6a 00                	push   $0x0
  80274e:	6a 00                	push   $0x0
  802750:	6a 00                	push   $0x0
  802752:	6a 0c                	push   $0xc
  802754:	e8 67 fe ff ff       	call   8025c0 <syscall>
  802759:	83 c4 18             	add    $0x18,%esp
}
  80275c:	c9                   	leave  
  80275d:	c3                   	ret    

0080275e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80275e:	55                   	push   %ebp
  80275f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802761:	6a 00                	push   $0x0
  802763:	6a 00                	push   $0x0
  802765:	6a 00                	push   $0x0
  802767:	6a 00                	push   $0x0
  802769:	6a 00                	push   $0x0
  80276b:	6a 0d                	push   $0xd
  80276d:	e8 4e fe ff ff       	call   8025c0 <syscall>
  802772:	83 c4 18             	add    $0x18,%esp
}
  802775:	c9                   	leave  
  802776:	c3                   	ret    

00802777 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802777:	55                   	push   %ebp
  802778:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80277a:	6a 00                	push   $0x0
  80277c:	6a 00                	push   $0x0
  80277e:	6a 00                	push   $0x0
  802780:	ff 75 0c             	pushl  0xc(%ebp)
  802783:	ff 75 08             	pushl  0x8(%ebp)
  802786:	6a 11                	push   $0x11
  802788:	e8 33 fe ff ff       	call   8025c0 <syscall>
  80278d:	83 c4 18             	add    $0x18,%esp
	return;
  802790:	90                   	nop
}
  802791:	c9                   	leave  
  802792:	c3                   	ret    

00802793 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802793:	55                   	push   %ebp
  802794:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802796:	6a 00                	push   $0x0
  802798:	6a 00                	push   $0x0
  80279a:	6a 00                	push   $0x0
  80279c:	ff 75 0c             	pushl  0xc(%ebp)
  80279f:	ff 75 08             	pushl  0x8(%ebp)
  8027a2:	6a 12                	push   $0x12
  8027a4:	e8 17 fe ff ff       	call   8025c0 <syscall>
  8027a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8027ac:	90                   	nop
}
  8027ad:	c9                   	leave  
  8027ae:	c3                   	ret    

008027af <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8027af:	55                   	push   %ebp
  8027b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8027b2:	6a 00                	push   $0x0
  8027b4:	6a 00                	push   $0x0
  8027b6:	6a 00                	push   $0x0
  8027b8:	6a 00                	push   $0x0
  8027ba:	6a 00                	push   $0x0
  8027bc:	6a 0e                	push   $0xe
  8027be:	e8 fd fd ff ff       	call   8025c0 <syscall>
  8027c3:	83 c4 18             	add    $0x18,%esp
}
  8027c6:	c9                   	leave  
  8027c7:	c3                   	ret    

008027c8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8027c8:	55                   	push   %ebp
  8027c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8027cb:	6a 00                	push   $0x0
  8027cd:	6a 00                	push   $0x0
  8027cf:	6a 00                	push   $0x0
  8027d1:	6a 00                	push   $0x0
  8027d3:	ff 75 08             	pushl  0x8(%ebp)
  8027d6:	6a 0f                	push   $0xf
  8027d8:	e8 e3 fd ff ff       	call   8025c0 <syscall>
  8027dd:	83 c4 18             	add    $0x18,%esp
}
  8027e0:	c9                   	leave  
  8027e1:	c3                   	ret    

008027e2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8027e2:	55                   	push   %ebp
  8027e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8027e5:	6a 00                	push   $0x0
  8027e7:	6a 00                	push   $0x0
  8027e9:	6a 00                	push   $0x0
  8027eb:	6a 00                	push   $0x0
  8027ed:	6a 00                	push   $0x0
  8027ef:	6a 10                	push   $0x10
  8027f1:	e8 ca fd ff ff       	call   8025c0 <syscall>
  8027f6:	83 c4 18             	add    $0x18,%esp
}
  8027f9:	90                   	nop
  8027fa:	c9                   	leave  
  8027fb:	c3                   	ret    

008027fc <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8027fc:	55                   	push   %ebp
  8027fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8027ff:	6a 00                	push   $0x0
  802801:	6a 00                	push   $0x0
  802803:	6a 00                	push   $0x0
  802805:	6a 00                	push   $0x0
  802807:	6a 00                	push   $0x0
  802809:	6a 14                	push   $0x14
  80280b:	e8 b0 fd ff ff       	call   8025c0 <syscall>
  802810:	83 c4 18             	add    $0x18,%esp
}
  802813:	90                   	nop
  802814:	c9                   	leave  
  802815:	c3                   	ret    

00802816 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802816:	55                   	push   %ebp
  802817:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802819:	6a 00                	push   $0x0
  80281b:	6a 00                	push   $0x0
  80281d:	6a 00                	push   $0x0
  80281f:	6a 00                	push   $0x0
  802821:	6a 00                	push   $0x0
  802823:	6a 15                	push   $0x15
  802825:	e8 96 fd ff ff       	call   8025c0 <syscall>
  80282a:	83 c4 18             	add    $0x18,%esp
}
  80282d:	90                   	nop
  80282e:	c9                   	leave  
  80282f:	c3                   	ret    

00802830 <sys_cputc>:


void
sys_cputc(const char c)
{
  802830:	55                   	push   %ebp
  802831:	89 e5                	mov    %esp,%ebp
  802833:	83 ec 04             	sub    $0x4,%esp
  802836:	8b 45 08             	mov    0x8(%ebp),%eax
  802839:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80283c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802840:	6a 00                	push   $0x0
  802842:	6a 00                	push   $0x0
  802844:	6a 00                	push   $0x0
  802846:	6a 00                	push   $0x0
  802848:	50                   	push   %eax
  802849:	6a 16                	push   $0x16
  80284b:	e8 70 fd ff ff       	call   8025c0 <syscall>
  802850:	83 c4 18             	add    $0x18,%esp
}
  802853:	90                   	nop
  802854:	c9                   	leave  
  802855:	c3                   	ret    

00802856 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802856:	55                   	push   %ebp
  802857:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802859:	6a 00                	push   $0x0
  80285b:	6a 00                	push   $0x0
  80285d:	6a 00                	push   $0x0
  80285f:	6a 00                	push   $0x0
  802861:	6a 00                	push   $0x0
  802863:	6a 17                	push   $0x17
  802865:	e8 56 fd ff ff       	call   8025c0 <syscall>
  80286a:	83 c4 18             	add    $0x18,%esp
}
  80286d:	90                   	nop
  80286e:	c9                   	leave  
  80286f:	c3                   	ret    

00802870 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802870:	55                   	push   %ebp
  802871:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802873:	8b 45 08             	mov    0x8(%ebp),%eax
  802876:	6a 00                	push   $0x0
  802878:	6a 00                	push   $0x0
  80287a:	6a 00                	push   $0x0
  80287c:	ff 75 0c             	pushl  0xc(%ebp)
  80287f:	50                   	push   %eax
  802880:	6a 18                	push   $0x18
  802882:	e8 39 fd ff ff       	call   8025c0 <syscall>
  802887:	83 c4 18             	add    $0x18,%esp
}
  80288a:	c9                   	leave  
  80288b:	c3                   	ret    

0080288c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80288c:	55                   	push   %ebp
  80288d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80288f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802892:	8b 45 08             	mov    0x8(%ebp),%eax
  802895:	6a 00                	push   $0x0
  802897:	6a 00                	push   $0x0
  802899:	6a 00                	push   $0x0
  80289b:	52                   	push   %edx
  80289c:	50                   	push   %eax
  80289d:	6a 1b                	push   $0x1b
  80289f:	e8 1c fd ff ff       	call   8025c0 <syscall>
  8028a4:	83 c4 18             	add    $0x18,%esp
}
  8028a7:	c9                   	leave  
  8028a8:	c3                   	ret    

008028a9 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8028a9:	55                   	push   %ebp
  8028aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8028ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8028af:	8b 45 08             	mov    0x8(%ebp),%eax
  8028b2:	6a 00                	push   $0x0
  8028b4:	6a 00                	push   $0x0
  8028b6:	6a 00                	push   $0x0
  8028b8:	52                   	push   %edx
  8028b9:	50                   	push   %eax
  8028ba:	6a 19                	push   $0x19
  8028bc:	e8 ff fc ff ff       	call   8025c0 <syscall>
  8028c1:	83 c4 18             	add    $0x18,%esp
}
  8028c4:	90                   	nop
  8028c5:	c9                   	leave  
  8028c6:	c3                   	ret    

008028c7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8028c7:	55                   	push   %ebp
  8028c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8028ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8028cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8028d0:	6a 00                	push   $0x0
  8028d2:	6a 00                	push   $0x0
  8028d4:	6a 00                	push   $0x0
  8028d6:	52                   	push   %edx
  8028d7:	50                   	push   %eax
  8028d8:	6a 1a                	push   $0x1a
  8028da:	e8 e1 fc ff ff       	call   8025c0 <syscall>
  8028df:	83 c4 18             	add    $0x18,%esp
}
  8028e2:	90                   	nop
  8028e3:	c9                   	leave  
  8028e4:	c3                   	ret    

008028e5 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8028e5:	55                   	push   %ebp
  8028e6:	89 e5                	mov    %esp,%ebp
  8028e8:	83 ec 04             	sub    $0x4,%esp
  8028eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8028ee:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8028f1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8028f4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8028f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8028fb:	6a 00                	push   $0x0
  8028fd:	51                   	push   %ecx
  8028fe:	52                   	push   %edx
  8028ff:	ff 75 0c             	pushl  0xc(%ebp)
  802902:	50                   	push   %eax
  802903:	6a 1c                	push   $0x1c
  802905:	e8 b6 fc ff ff       	call   8025c0 <syscall>
  80290a:	83 c4 18             	add    $0x18,%esp
}
  80290d:	c9                   	leave  
  80290e:	c3                   	ret    

0080290f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80290f:	55                   	push   %ebp
  802910:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802912:	8b 55 0c             	mov    0xc(%ebp),%edx
  802915:	8b 45 08             	mov    0x8(%ebp),%eax
  802918:	6a 00                	push   $0x0
  80291a:	6a 00                	push   $0x0
  80291c:	6a 00                	push   $0x0
  80291e:	52                   	push   %edx
  80291f:	50                   	push   %eax
  802920:	6a 1d                	push   $0x1d
  802922:	e8 99 fc ff ff       	call   8025c0 <syscall>
  802927:	83 c4 18             	add    $0x18,%esp
}
  80292a:	c9                   	leave  
  80292b:	c3                   	ret    

0080292c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80292c:	55                   	push   %ebp
  80292d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80292f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802932:	8b 55 0c             	mov    0xc(%ebp),%edx
  802935:	8b 45 08             	mov    0x8(%ebp),%eax
  802938:	6a 00                	push   $0x0
  80293a:	6a 00                	push   $0x0
  80293c:	51                   	push   %ecx
  80293d:	52                   	push   %edx
  80293e:	50                   	push   %eax
  80293f:	6a 1e                	push   $0x1e
  802941:	e8 7a fc ff ff       	call   8025c0 <syscall>
  802946:	83 c4 18             	add    $0x18,%esp
}
  802949:	c9                   	leave  
  80294a:	c3                   	ret    

0080294b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80294b:	55                   	push   %ebp
  80294c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80294e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802951:	8b 45 08             	mov    0x8(%ebp),%eax
  802954:	6a 00                	push   $0x0
  802956:	6a 00                	push   $0x0
  802958:	6a 00                	push   $0x0
  80295a:	52                   	push   %edx
  80295b:	50                   	push   %eax
  80295c:	6a 1f                	push   $0x1f
  80295e:	e8 5d fc ff ff       	call   8025c0 <syscall>
  802963:	83 c4 18             	add    $0x18,%esp
}
  802966:	c9                   	leave  
  802967:	c3                   	ret    

00802968 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802968:	55                   	push   %ebp
  802969:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80296b:	6a 00                	push   $0x0
  80296d:	6a 00                	push   $0x0
  80296f:	6a 00                	push   $0x0
  802971:	6a 00                	push   $0x0
  802973:	6a 00                	push   $0x0
  802975:	6a 20                	push   $0x20
  802977:	e8 44 fc ff ff       	call   8025c0 <syscall>
  80297c:	83 c4 18             	add    $0x18,%esp
}
  80297f:	c9                   	leave  
  802980:	c3                   	ret    

00802981 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802981:	55                   	push   %ebp
  802982:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802984:	8b 45 08             	mov    0x8(%ebp),%eax
  802987:	6a 00                	push   $0x0
  802989:	6a 00                	push   $0x0
  80298b:	ff 75 10             	pushl  0x10(%ebp)
  80298e:	ff 75 0c             	pushl  0xc(%ebp)
  802991:	50                   	push   %eax
  802992:	6a 21                	push   $0x21
  802994:	e8 27 fc ff ff       	call   8025c0 <syscall>
  802999:	83 c4 18             	add    $0x18,%esp
}
  80299c:	c9                   	leave  
  80299d:	c3                   	ret    

0080299e <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80299e:	55                   	push   %ebp
  80299f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8029a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8029a4:	6a 00                	push   $0x0
  8029a6:	6a 00                	push   $0x0
  8029a8:	6a 00                	push   $0x0
  8029aa:	6a 00                	push   $0x0
  8029ac:	50                   	push   %eax
  8029ad:	6a 22                	push   $0x22
  8029af:	e8 0c fc ff ff       	call   8025c0 <syscall>
  8029b4:	83 c4 18             	add    $0x18,%esp
}
  8029b7:	90                   	nop
  8029b8:	c9                   	leave  
  8029b9:	c3                   	ret    

008029ba <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8029ba:	55                   	push   %ebp
  8029bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8029bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8029c0:	6a 00                	push   $0x0
  8029c2:	6a 00                	push   $0x0
  8029c4:	6a 00                	push   $0x0
  8029c6:	6a 00                	push   $0x0
  8029c8:	50                   	push   %eax
  8029c9:	6a 23                	push   $0x23
  8029cb:	e8 f0 fb ff ff       	call   8025c0 <syscall>
  8029d0:	83 c4 18             	add    $0x18,%esp
}
  8029d3:	90                   	nop
  8029d4:	c9                   	leave  
  8029d5:	c3                   	ret    

008029d6 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8029d6:	55                   	push   %ebp
  8029d7:	89 e5                	mov    %esp,%ebp
  8029d9:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8029dc:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8029df:	8d 50 04             	lea    0x4(%eax),%edx
  8029e2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8029e5:	6a 00                	push   $0x0
  8029e7:	6a 00                	push   $0x0
  8029e9:	6a 00                	push   $0x0
  8029eb:	52                   	push   %edx
  8029ec:	50                   	push   %eax
  8029ed:	6a 24                	push   $0x24
  8029ef:	e8 cc fb ff ff       	call   8025c0 <syscall>
  8029f4:	83 c4 18             	add    $0x18,%esp
	return result;
  8029f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8029fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8029fd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802a00:	89 01                	mov    %eax,(%ecx)
  802a02:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802a05:	8b 45 08             	mov    0x8(%ebp),%eax
  802a08:	c9                   	leave  
  802a09:	c2 04 00             	ret    $0x4

00802a0c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802a0c:	55                   	push   %ebp
  802a0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802a0f:	6a 00                	push   $0x0
  802a11:	6a 00                	push   $0x0
  802a13:	ff 75 10             	pushl  0x10(%ebp)
  802a16:	ff 75 0c             	pushl  0xc(%ebp)
  802a19:	ff 75 08             	pushl  0x8(%ebp)
  802a1c:	6a 13                	push   $0x13
  802a1e:	e8 9d fb ff ff       	call   8025c0 <syscall>
  802a23:	83 c4 18             	add    $0x18,%esp
	return ;
  802a26:	90                   	nop
}
  802a27:	c9                   	leave  
  802a28:	c3                   	ret    

00802a29 <sys_rcr2>:
uint32 sys_rcr2()
{
  802a29:	55                   	push   %ebp
  802a2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802a2c:	6a 00                	push   $0x0
  802a2e:	6a 00                	push   $0x0
  802a30:	6a 00                	push   $0x0
  802a32:	6a 00                	push   $0x0
  802a34:	6a 00                	push   $0x0
  802a36:	6a 25                	push   $0x25
  802a38:	e8 83 fb ff ff       	call   8025c0 <syscall>
  802a3d:	83 c4 18             	add    $0x18,%esp
}
  802a40:	c9                   	leave  
  802a41:	c3                   	ret    

00802a42 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802a42:	55                   	push   %ebp
  802a43:	89 e5                	mov    %esp,%ebp
  802a45:	83 ec 04             	sub    $0x4,%esp
  802a48:	8b 45 08             	mov    0x8(%ebp),%eax
  802a4b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802a4e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802a52:	6a 00                	push   $0x0
  802a54:	6a 00                	push   $0x0
  802a56:	6a 00                	push   $0x0
  802a58:	6a 00                	push   $0x0
  802a5a:	50                   	push   %eax
  802a5b:	6a 26                	push   $0x26
  802a5d:	e8 5e fb ff ff       	call   8025c0 <syscall>
  802a62:	83 c4 18             	add    $0x18,%esp
	return ;
  802a65:	90                   	nop
}
  802a66:	c9                   	leave  
  802a67:	c3                   	ret    

00802a68 <rsttst>:
void rsttst()
{
  802a68:	55                   	push   %ebp
  802a69:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802a6b:	6a 00                	push   $0x0
  802a6d:	6a 00                	push   $0x0
  802a6f:	6a 00                	push   $0x0
  802a71:	6a 00                	push   $0x0
  802a73:	6a 00                	push   $0x0
  802a75:	6a 28                	push   $0x28
  802a77:	e8 44 fb ff ff       	call   8025c0 <syscall>
  802a7c:	83 c4 18             	add    $0x18,%esp
	return ;
  802a7f:	90                   	nop
}
  802a80:	c9                   	leave  
  802a81:	c3                   	ret    

00802a82 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802a82:	55                   	push   %ebp
  802a83:	89 e5                	mov    %esp,%ebp
  802a85:	83 ec 04             	sub    $0x4,%esp
  802a88:	8b 45 14             	mov    0x14(%ebp),%eax
  802a8b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802a8e:	8b 55 18             	mov    0x18(%ebp),%edx
  802a91:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802a95:	52                   	push   %edx
  802a96:	50                   	push   %eax
  802a97:	ff 75 10             	pushl  0x10(%ebp)
  802a9a:	ff 75 0c             	pushl  0xc(%ebp)
  802a9d:	ff 75 08             	pushl  0x8(%ebp)
  802aa0:	6a 27                	push   $0x27
  802aa2:	e8 19 fb ff ff       	call   8025c0 <syscall>
  802aa7:	83 c4 18             	add    $0x18,%esp
	return ;
  802aaa:	90                   	nop
}
  802aab:	c9                   	leave  
  802aac:	c3                   	ret    

00802aad <chktst>:
void chktst(uint32 n)
{
  802aad:	55                   	push   %ebp
  802aae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802ab0:	6a 00                	push   $0x0
  802ab2:	6a 00                	push   $0x0
  802ab4:	6a 00                	push   $0x0
  802ab6:	6a 00                	push   $0x0
  802ab8:	ff 75 08             	pushl  0x8(%ebp)
  802abb:	6a 29                	push   $0x29
  802abd:	e8 fe fa ff ff       	call   8025c0 <syscall>
  802ac2:	83 c4 18             	add    $0x18,%esp
	return ;
  802ac5:	90                   	nop
}
  802ac6:	c9                   	leave  
  802ac7:	c3                   	ret    

00802ac8 <inctst>:

void inctst()
{
  802ac8:	55                   	push   %ebp
  802ac9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802acb:	6a 00                	push   $0x0
  802acd:	6a 00                	push   $0x0
  802acf:	6a 00                	push   $0x0
  802ad1:	6a 00                	push   $0x0
  802ad3:	6a 00                	push   $0x0
  802ad5:	6a 2a                	push   $0x2a
  802ad7:	e8 e4 fa ff ff       	call   8025c0 <syscall>
  802adc:	83 c4 18             	add    $0x18,%esp
	return ;
  802adf:	90                   	nop
}
  802ae0:	c9                   	leave  
  802ae1:	c3                   	ret    

00802ae2 <gettst>:
uint32 gettst()
{
  802ae2:	55                   	push   %ebp
  802ae3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802ae5:	6a 00                	push   $0x0
  802ae7:	6a 00                	push   $0x0
  802ae9:	6a 00                	push   $0x0
  802aeb:	6a 00                	push   $0x0
  802aed:	6a 00                	push   $0x0
  802aef:	6a 2b                	push   $0x2b
  802af1:	e8 ca fa ff ff       	call   8025c0 <syscall>
  802af6:	83 c4 18             	add    $0x18,%esp
}
  802af9:	c9                   	leave  
  802afa:	c3                   	ret    

00802afb <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802afb:	55                   	push   %ebp
  802afc:	89 e5                	mov    %esp,%ebp
  802afe:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b01:	6a 00                	push   $0x0
  802b03:	6a 00                	push   $0x0
  802b05:	6a 00                	push   $0x0
  802b07:	6a 00                	push   $0x0
  802b09:	6a 00                	push   $0x0
  802b0b:	6a 2c                	push   $0x2c
  802b0d:	e8 ae fa ff ff       	call   8025c0 <syscall>
  802b12:	83 c4 18             	add    $0x18,%esp
  802b15:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802b18:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802b1c:	75 07                	jne    802b25 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802b1e:	b8 01 00 00 00       	mov    $0x1,%eax
  802b23:	eb 05                	jmp    802b2a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802b25:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b2a:	c9                   	leave  
  802b2b:	c3                   	ret    

00802b2c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802b2c:	55                   	push   %ebp
  802b2d:	89 e5                	mov    %esp,%ebp
  802b2f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b32:	6a 00                	push   $0x0
  802b34:	6a 00                	push   $0x0
  802b36:	6a 00                	push   $0x0
  802b38:	6a 00                	push   $0x0
  802b3a:	6a 00                	push   $0x0
  802b3c:	6a 2c                	push   $0x2c
  802b3e:	e8 7d fa ff ff       	call   8025c0 <syscall>
  802b43:	83 c4 18             	add    $0x18,%esp
  802b46:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802b49:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802b4d:	75 07                	jne    802b56 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802b4f:	b8 01 00 00 00       	mov    $0x1,%eax
  802b54:	eb 05                	jmp    802b5b <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802b56:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b5b:	c9                   	leave  
  802b5c:	c3                   	ret    

00802b5d <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802b5d:	55                   	push   %ebp
  802b5e:	89 e5                	mov    %esp,%ebp
  802b60:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b63:	6a 00                	push   $0x0
  802b65:	6a 00                	push   $0x0
  802b67:	6a 00                	push   $0x0
  802b69:	6a 00                	push   $0x0
  802b6b:	6a 00                	push   $0x0
  802b6d:	6a 2c                	push   $0x2c
  802b6f:	e8 4c fa ff ff       	call   8025c0 <syscall>
  802b74:	83 c4 18             	add    $0x18,%esp
  802b77:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802b7a:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802b7e:	75 07                	jne    802b87 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802b80:	b8 01 00 00 00       	mov    $0x1,%eax
  802b85:	eb 05                	jmp    802b8c <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802b87:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b8c:	c9                   	leave  
  802b8d:	c3                   	ret    

00802b8e <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802b8e:	55                   	push   %ebp
  802b8f:	89 e5                	mov    %esp,%ebp
  802b91:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b94:	6a 00                	push   $0x0
  802b96:	6a 00                	push   $0x0
  802b98:	6a 00                	push   $0x0
  802b9a:	6a 00                	push   $0x0
  802b9c:	6a 00                	push   $0x0
  802b9e:	6a 2c                	push   $0x2c
  802ba0:	e8 1b fa ff ff       	call   8025c0 <syscall>
  802ba5:	83 c4 18             	add    $0x18,%esp
  802ba8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802bab:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802baf:	75 07                	jne    802bb8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802bb1:	b8 01 00 00 00       	mov    $0x1,%eax
  802bb6:	eb 05                	jmp    802bbd <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802bb8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802bbd:	c9                   	leave  
  802bbe:	c3                   	ret    

00802bbf <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802bbf:	55                   	push   %ebp
  802bc0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802bc2:	6a 00                	push   $0x0
  802bc4:	6a 00                	push   $0x0
  802bc6:	6a 00                	push   $0x0
  802bc8:	6a 00                	push   $0x0
  802bca:	ff 75 08             	pushl  0x8(%ebp)
  802bcd:	6a 2d                	push   $0x2d
  802bcf:	e8 ec f9 ff ff       	call   8025c0 <syscall>
  802bd4:	83 c4 18             	add    $0x18,%esp
	return ;
  802bd7:	90                   	nop
}
  802bd8:	c9                   	leave  
  802bd9:	c3                   	ret    

00802bda <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  802bda:	55                   	push   %ebp
  802bdb:	89 e5                	mov    %esp,%ebp
  802bdd:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  802be0:	8b 55 08             	mov    0x8(%ebp),%edx
  802be3:	89 d0                	mov    %edx,%eax
  802be5:	c1 e0 02             	shl    $0x2,%eax
  802be8:	01 d0                	add    %edx,%eax
  802bea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802bf1:	01 d0                	add    %edx,%eax
  802bf3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802bfa:	01 d0                	add    %edx,%eax
  802bfc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802c03:	01 d0                	add    %edx,%eax
  802c05:	c1 e0 04             	shl    $0x4,%eax
  802c08:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  802c0b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  802c12:	8d 45 e8             	lea    -0x18(%ebp),%eax
  802c15:	83 ec 0c             	sub    $0xc,%esp
  802c18:	50                   	push   %eax
  802c19:	e8 b8 fd ff ff       	call   8029d6 <sys_get_virtual_time>
  802c1e:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  802c21:	eb 41                	jmp    802c64 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  802c23:	8d 45 e0             	lea    -0x20(%ebp),%eax
  802c26:	83 ec 0c             	sub    $0xc,%esp
  802c29:	50                   	push   %eax
  802c2a:	e8 a7 fd ff ff       	call   8029d6 <sys_get_virtual_time>
  802c2f:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  802c32:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802c35:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802c38:	29 c2                	sub    %eax,%edx
  802c3a:	89 d0                	mov    %edx,%eax
  802c3c:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  802c3f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802c42:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802c45:	89 d1                	mov    %edx,%ecx
  802c47:	29 c1                	sub    %eax,%ecx
  802c49:	8b 55 d8             	mov    -0x28(%ebp),%edx
  802c4c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802c4f:	39 c2                	cmp    %eax,%edx
  802c51:	0f 97 c0             	seta   %al
  802c54:	0f b6 c0             	movzbl %al,%eax
  802c57:	29 c1                	sub    %eax,%ecx
  802c59:	89 c8                	mov    %ecx,%eax
  802c5b:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  802c5e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802c61:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  802c64:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802c67:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802c6a:	72 b7                	jb     802c23 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  802c6c:	90                   	nop
  802c6d:	c9                   	leave  
  802c6e:	c3                   	ret    

00802c6f <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  802c6f:	55                   	push   %ebp
  802c70:	89 e5                	mov    %esp,%ebp
  802c72:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  802c75:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  802c7c:	eb 03                	jmp    802c81 <busy_wait+0x12>
  802c7e:	ff 45 fc             	incl   -0x4(%ebp)
  802c81:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802c84:	3b 45 08             	cmp    0x8(%ebp),%eax
  802c87:	72 f5                	jb     802c7e <busy_wait+0xf>
	return i;
  802c89:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802c8c:	c9                   	leave  
  802c8d:	c3                   	ret    
  802c8e:	66 90                	xchg   %ax,%ax

00802c90 <__udivdi3>:
  802c90:	55                   	push   %ebp
  802c91:	57                   	push   %edi
  802c92:	56                   	push   %esi
  802c93:	53                   	push   %ebx
  802c94:	83 ec 1c             	sub    $0x1c,%esp
  802c97:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802c9b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802c9f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802ca3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802ca7:	89 ca                	mov    %ecx,%edx
  802ca9:	89 f8                	mov    %edi,%eax
  802cab:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802caf:	85 f6                	test   %esi,%esi
  802cb1:	75 2d                	jne    802ce0 <__udivdi3+0x50>
  802cb3:	39 cf                	cmp    %ecx,%edi
  802cb5:	77 65                	ja     802d1c <__udivdi3+0x8c>
  802cb7:	89 fd                	mov    %edi,%ebp
  802cb9:	85 ff                	test   %edi,%edi
  802cbb:	75 0b                	jne    802cc8 <__udivdi3+0x38>
  802cbd:	b8 01 00 00 00       	mov    $0x1,%eax
  802cc2:	31 d2                	xor    %edx,%edx
  802cc4:	f7 f7                	div    %edi
  802cc6:	89 c5                	mov    %eax,%ebp
  802cc8:	31 d2                	xor    %edx,%edx
  802cca:	89 c8                	mov    %ecx,%eax
  802ccc:	f7 f5                	div    %ebp
  802cce:	89 c1                	mov    %eax,%ecx
  802cd0:	89 d8                	mov    %ebx,%eax
  802cd2:	f7 f5                	div    %ebp
  802cd4:	89 cf                	mov    %ecx,%edi
  802cd6:	89 fa                	mov    %edi,%edx
  802cd8:	83 c4 1c             	add    $0x1c,%esp
  802cdb:	5b                   	pop    %ebx
  802cdc:	5e                   	pop    %esi
  802cdd:	5f                   	pop    %edi
  802cde:	5d                   	pop    %ebp
  802cdf:	c3                   	ret    
  802ce0:	39 ce                	cmp    %ecx,%esi
  802ce2:	77 28                	ja     802d0c <__udivdi3+0x7c>
  802ce4:	0f bd fe             	bsr    %esi,%edi
  802ce7:	83 f7 1f             	xor    $0x1f,%edi
  802cea:	75 40                	jne    802d2c <__udivdi3+0x9c>
  802cec:	39 ce                	cmp    %ecx,%esi
  802cee:	72 0a                	jb     802cfa <__udivdi3+0x6a>
  802cf0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802cf4:	0f 87 9e 00 00 00    	ja     802d98 <__udivdi3+0x108>
  802cfa:	b8 01 00 00 00       	mov    $0x1,%eax
  802cff:	89 fa                	mov    %edi,%edx
  802d01:	83 c4 1c             	add    $0x1c,%esp
  802d04:	5b                   	pop    %ebx
  802d05:	5e                   	pop    %esi
  802d06:	5f                   	pop    %edi
  802d07:	5d                   	pop    %ebp
  802d08:	c3                   	ret    
  802d09:	8d 76 00             	lea    0x0(%esi),%esi
  802d0c:	31 ff                	xor    %edi,%edi
  802d0e:	31 c0                	xor    %eax,%eax
  802d10:	89 fa                	mov    %edi,%edx
  802d12:	83 c4 1c             	add    $0x1c,%esp
  802d15:	5b                   	pop    %ebx
  802d16:	5e                   	pop    %esi
  802d17:	5f                   	pop    %edi
  802d18:	5d                   	pop    %ebp
  802d19:	c3                   	ret    
  802d1a:	66 90                	xchg   %ax,%ax
  802d1c:	89 d8                	mov    %ebx,%eax
  802d1e:	f7 f7                	div    %edi
  802d20:	31 ff                	xor    %edi,%edi
  802d22:	89 fa                	mov    %edi,%edx
  802d24:	83 c4 1c             	add    $0x1c,%esp
  802d27:	5b                   	pop    %ebx
  802d28:	5e                   	pop    %esi
  802d29:	5f                   	pop    %edi
  802d2a:	5d                   	pop    %ebp
  802d2b:	c3                   	ret    
  802d2c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802d31:	89 eb                	mov    %ebp,%ebx
  802d33:	29 fb                	sub    %edi,%ebx
  802d35:	89 f9                	mov    %edi,%ecx
  802d37:	d3 e6                	shl    %cl,%esi
  802d39:	89 c5                	mov    %eax,%ebp
  802d3b:	88 d9                	mov    %bl,%cl
  802d3d:	d3 ed                	shr    %cl,%ebp
  802d3f:	89 e9                	mov    %ebp,%ecx
  802d41:	09 f1                	or     %esi,%ecx
  802d43:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802d47:	89 f9                	mov    %edi,%ecx
  802d49:	d3 e0                	shl    %cl,%eax
  802d4b:	89 c5                	mov    %eax,%ebp
  802d4d:	89 d6                	mov    %edx,%esi
  802d4f:	88 d9                	mov    %bl,%cl
  802d51:	d3 ee                	shr    %cl,%esi
  802d53:	89 f9                	mov    %edi,%ecx
  802d55:	d3 e2                	shl    %cl,%edx
  802d57:	8b 44 24 08          	mov    0x8(%esp),%eax
  802d5b:	88 d9                	mov    %bl,%cl
  802d5d:	d3 e8                	shr    %cl,%eax
  802d5f:	09 c2                	or     %eax,%edx
  802d61:	89 d0                	mov    %edx,%eax
  802d63:	89 f2                	mov    %esi,%edx
  802d65:	f7 74 24 0c          	divl   0xc(%esp)
  802d69:	89 d6                	mov    %edx,%esi
  802d6b:	89 c3                	mov    %eax,%ebx
  802d6d:	f7 e5                	mul    %ebp
  802d6f:	39 d6                	cmp    %edx,%esi
  802d71:	72 19                	jb     802d8c <__udivdi3+0xfc>
  802d73:	74 0b                	je     802d80 <__udivdi3+0xf0>
  802d75:	89 d8                	mov    %ebx,%eax
  802d77:	31 ff                	xor    %edi,%edi
  802d79:	e9 58 ff ff ff       	jmp    802cd6 <__udivdi3+0x46>
  802d7e:	66 90                	xchg   %ax,%ax
  802d80:	8b 54 24 08          	mov    0x8(%esp),%edx
  802d84:	89 f9                	mov    %edi,%ecx
  802d86:	d3 e2                	shl    %cl,%edx
  802d88:	39 c2                	cmp    %eax,%edx
  802d8a:	73 e9                	jae    802d75 <__udivdi3+0xe5>
  802d8c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802d8f:	31 ff                	xor    %edi,%edi
  802d91:	e9 40 ff ff ff       	jmp    802cd6 <__udivdi3+0x46>
  802d96:	66 90                	xchg   %ax,%ax
  802d98:	31 c0                	xor    %eax,%eax
  802d9a:	e9 37 ff ff ff       	jmp    802cd6 <__udivdi3+0x46>
  802d9f:	90                   	nop

00802da0 <__umoddi3>:
  802da0:	55                   	push   %ebp
  802da1:	57                   	push   %edi
  802da2:	56                   	push   %esi
  802da3:	53                   	push   %ebx
  802da4:	83 ec 1c             	sub    $0x1c,%esp
  802da7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802dab:	8b 74 24 34          	mov    0x34(%esp),%esi
  802daf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802db3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802db7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802dbb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802dbf:	89 f3                	mov    %esi,%ebx
  802dc1:	89 fa                	mov    %edi,%edx
  802dc3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802dc7:	89 34 24             	mov    %esi,(%esp)
  802dca:	85 c0                	test   %eax,%eax
  802dcc:	75 1a                	jne    802de8 <__umoddi3+0x48>
  802dce:	39 f7                	cmp    %esi,%edi
  802dd0:	0f 86 a2 00 00 00    	jbe    802e78 <__umoddi3+0xd8>
  802dd6:	89 c8                	mov    %ecx,%eax
  802dd8:	89 f2                	mov    %esi,%edx
  802dda:	f7 f7                	div    %edi
  802ddc:	89 d0                	mov    %edx,%eax
  802dde:	31 d2                	xor    %edx,%edx
  802de0:	83 c4 1c             	add    $0x1c,%esp
  802de3:	5b                   	pop    %ebx
  802de4:	5e                   	pop    %esi
  802de5:	5f                   	pop    %edi
  802de6:	5d                   	pop    %ebp
  802de7:	c3                   	ret    
  802de8:	39 f0                	cmp    %esi,%eax
  802dea:	0f 87 ac 00 00 00    	ja     802e9c <__umoddi3+0xfc>
  802df0:	0f bd e8             	bsr    %eax,%ebp
  802df3:	83 f5 1f             	xor    $0x1f,%ebp
  802df6:	0f 84 ac 00 00 00    	je     802ea8 <__umoddi3+0x108>
  802dfc:	bf 20 00 00 00       	mov    $0x20,%edi
  802e01:	29 ef                	sub    %ebp,%edi
  802e03:	89 fe                	mov    %edi,%esi
  802e05:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802e09:	89 e9                	mov    %ebp,%ecx
  802e0b:	d3 e0                	shl    %cl,%eax
  802e0d:	89 d7                	mov    %edx,%edi
  802e0f:	89 f1                	mov    %esi,%ecx
  802e11:	d3 ef                	shr    %cl,%edi
  802e13:	09 c7                	or     %eax,%edi
  802e15:	89 e9                	mov    %ebp,%ecx
  802e17:	d3 e2                	shl    %cl,%edx
  802e19:	89 14 24             	mov    %edx,(%esp)
  802e1c:	89 d8                	mov    %ebx,%eax
  802e1e:	d3 e0                	shl    %cl,%eax
  802e20:	89 c2                	mov    %eax,%edx
  802e22:	8b 44 24 08          	mov    0x8(%esp),%eax
  802e26:	d3 e0                	shl    %cl,%eax
  802e28:	89 44 24 04          	mov    %eax,0x4(%esp)
  802e2c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802e30:	89 f1                	mov    %esi,%ecx
  802e32:	d3 e8                	shr    %cl,%eax
  802e34:	09 d0                	or     %edx,%eax
  802e36:	d3 eb                	shr    %cl,%ebx
  802e38:	89 da                	mov    %ebx,%edx
  802e3a:	f7 f7                	div    %edi
  802e3c:	89 d3                	mov    %edx,%ebx
  802e3e:	f7 24 24             	mull   (%esp)
  802e41:	89 c6                	mov    %eax,%esi
  802e43:	89 d1                	mov    %edx,%ecx
  802e45:	39 d3                	cmp    %edx,%ebx
  802e47:	0f 82 87 00 00 00    	jb     802ed4 <__umoddi3+0x134>
  802e4d:	0f 84 91 00 00 00    	je     802ee4 <__umoddi3+0x144>
  802e53:	8b 54 24 04          	mov    0x4(%esp),%edx
  802e57:	29 f2                	sub    %esi,%edx
  802e59:	19 cb                	sbb    %ecx,%ebx
  802e5b:	89 d8                	mov    %ebx,%eax
  802e5d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802e61:	d3 e0                	shl    %cl,%eax
  802e63:	89 e9                	mov    %ebp,%ecx
  802e65:	d3 ea                	shr    %cl,%edx
  802e67:	09 d0                	or     %edx,%eax
  802e69:	89 e9                	mov    %ebp,%ecx
  802e6b:	d3 eb                	shr    %cl,%ebx
  802e6d:	89 da                	mov    %ebx,%edx
  802e6f:	83 c4 1c             	add    $0x1c,%esp
  802e72:	5b                   	pop    %ebx
  802e73:	5e                   	pop    %esi
  802e74:	5f                   	pop    %edi
  802e75:	5d                   	pop    %ebp
  802e76:	c3                   	ret    
  802e77:	90                   	nop
  802e78:	89 fd                	mov    %edi,%ebp
  802e7a:	85 ff                	test   %edi,%edi
  802e7c:	75 0b                	jne    802e89 <__umoddi3+0xe9>
  802e7e:	b8 01 00 00 00       	mov    $0x1,%eax
  802e83:	31 d2                	xor    %edx,%edx
  802e85:	f7 f7                	div    %edi
  802e87:	89 c5                	mov    %eax,%ebp
  802e89:	89 f0                	mov    %esi,%eax
  802e8b:	31 d2                	xor    %edx,%edx
  802e8d:	f7 f5                	div    %ebp
  802e8f:	89 c8                	mov    %ecx,%eax
  802e91:	f7 f5                	div    %ebp
  802e93:	89 d0                	mov    %edx,%eax
  802e95:	e9 44 ff ff ff       	jmp    802dde <__umoddi3+0x3e>
  802e9a:	66 90                	xchg   %ax,%ax
  802e9c:	89 c8                	mov    %ecx,%eax
  802e9e:	89 f2                	mov    %esi,%edx
  802ea0:	83 c4 1c             	add    $0x1c,%esp
  802ea3:	5b                   	pop    %ebx
  802ea4:	5e                   	pop    %esi
  802ea5:	5f                   	pop    %edi
  802ea6:	5d                   	pop    %ebp
  802ea7:	c3                   	ret    
  802ea8:	3b 04 24             	cmp    (%esp),%eax
  802eab:	72 06                	jb     802eb3 <__umoddi3+0x113>
  802ead:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802eb1:	77 0f                	ja     802ec2 <__umoddi3+0x122>
  802eb3:	89 f2                	mov    %esi,%edx
  802eb5:	29 f9                	sub    %edi,%ecx
  802eb7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802ebb:	89 14 24             	mov    %edx,(%esp)
  802ebe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802ec2:	8b 44 24 04          	mov    0x4(%esp),%eax
  802ec6:	8b 14 24             	mov    (%esp),%edx
  802ec9:	83 c4 1c             	add    $0x1c,%esp
  802ecc:	5b                   	pop    %ebx
  802ecd:	5e                   	pop    %esi
  802ece:	5f                   	pop    %edi
  802ecf:	5d                   	pop    %ebp
  802ed0:	c3                   	ret    
  802ed1:	8d 76 00             	lea    0x0(%esi),%esi
  802ed4:	2b 04 24             	sub    (%esp),%eax
  802ed7:	19 fa                	sbb    %edi,%edx
  802ed9:	89 d1                	mov    %edx,%ecx
  802edb:	89 c6                	mov    %eax,%esi
  802edd:	e9 71 ff ff ff       	jmp    802e53 <__umoddi3+0xb3>
  802ee2:	66 90                	xchg   %ax,%ax
  802ee4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802ee8:	72 ea                	jb     802ed4 <__umoddi3+0x134>
  802eea:	89 d9                	mov    %ebx,%ecx
  802eec:	e9 62 ff ff ff       	jmp    802e53 <__umoddi3+0xb3>
