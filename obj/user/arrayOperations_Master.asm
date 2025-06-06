
obj/user/arrayOperations_Master:     file format elf32-i386


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
  800031:	e8 e4 06 00 00       	call   80071a <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
uint32 CheckSorted(int *Elements, int NumOfElements);
void ArrayStats(int *Elements, int NumOfElements, int *mean, int *var);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 88 00 00 00    	sub    $0x88,%esp
	/*[1] CREATE SHARED ARRAY*/
	int ret;
	char Chose;
	char Line[30];
	//2012: lock the interrupt
	sys_disable_interrupt();
  800041:	e8 e6 1e 00 00       	call   801f2c <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 80 25 80 00       	push   $0x802580
  80004e:	e8 7d 0a 00 00       	call   800ad0 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 82 25 80 00       	push   $0x802582
  80005e:	e8 6d 0a 00 00       	call   800ad0 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   ARRAY OOERATIONS   !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 a0 25 80 00       	push   $0x8025a0
  80006e:	e8 5d 0a 00 00       	call   800ad0 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 82 25 80 00       	push   $0x802582
  80007e:	e8 4d 0a 00 00       	call   800ad0 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 80 25 80 00       	push   $0x802580
  80008e:	e8 3d 0a 00 00       	call   800ad0 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 45 82             	lea    -0x7e(%ebp),%eax
  80009c:	50                   	push   %eax
  80009d:	68 c0 25 80 00       	push   $0x8025c0
  8000a2:	e8 ab 10 00 00       	call   801152 <readline>
  8000a7:	83 c4 10             	add    $0x10,%esp

		//Create the shared array & its size
		int *arrSize = smalloc("arrSize", sizeof(int) , 0) ;
  8000aa:	83 ec 04             	sub    $0x4,%esp
  8000ad:	6a 00                	push   $0x0
  8000af:	6a 04                	push   $0x4
  8000b1:	68 df 25 80 00       	push   $0x8025df
  8000b6:	e8 a5 19 00 00       	call   801a60 <smalloc>
  8000bb:	83 c4 10             	add    $0x10,%esp
  8000be:	89 45 f4             	mov    %eax,-0xc(%ebp)
		*arrSize = strtol(Line, NULL, 10) ;
  8000c1:	83 ec 04             	sub    $0x4,%esp
  8000c4:	6a 0a                	push   $0xa
  8000c6:	6a 00                	push   $0x0
  8000c8:	8d 45 82             	lea    -0x7e(%ebp),%eax
  8000cb:	50                   	push   %eax
  8000cc:	e8 e7 15 00 00       	call   8016b8 <strtol>
  8000d1:	83 c4 10             	add    $0x10,%esp
  8000d4:	89 c2                	mov    %eax,%edx
  8000d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000d9:	89 10                	mov    %edx,(%eax)
		int NumOfElements = *arrSize;
  8000db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000de:	8b 00                	mov    (%eax),%eax
  8000e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = smalloc("arr", sizeof(int) * NumOfElements , 0) ;
  8000e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000e6:	c1 e0 02             	shl    $0x2,%eax
  8000e9:	83 ec 04             	sub    $0x4,%esp
  8000ec:	6a 00                	push   $0x0
  8000ee:	50                   	push   %eax
  8000ef:	68 e7 25 80 00       	push   $0x8025e7
  8000f4:	e8 67 19 00 00       	call   801a60 <smalloc>
  8000f9:	83 c4 10             	add    $0x10,%esp
  8000fc:	89 45 ec             	mov    %eax,-0x14(%ebp)

		cprintf("Chose the initialization method:\n") ;
  8000ff:	83 ec 0c             	sub    $0xc,%esp
  800102:	68 ec 25 80 00       	push   $0x8025ec
  800107:	e8 c4 09 00 00       	call   800ad0 <cprintf>
  80010c:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  80010f:	83 ec 0c             	sub    $0xc,%esp
  800112:	68 0e 26 80 00       	push   $0x80260e
  800117:	e8 b4 09 00 00       	call   800ad0 <cprintf>
  80011c:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  80011f:	83 ec 0c             	sub    $0xc,%esp
  800122:	68 1c 26 80 00       	push   $0x80261c
  800127:	e8 a4 09 00 00       	call   800ad0 <cprintf>
  80012c:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80012f:	83 ec 0c             	sub    $0xc,%esp
  800132:	68 2b 26 80 00       	push   $0x80262b
  800137:	e8 94 09 00 00       	call   800ad0 <cprintf>
  80013c:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80013f:	83 ec 0c             	sub    $0xc,%esp
  800142:	68 3b 26 80 00       	push   $0x80263b
  800147:	e8 84 09 00 00       	call   800ad0 <cprintf>
  80014c:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80014f:	e8 6e 05 00 00       	call   8006c2 <getchar>
  800154:	88 45 eb             	mov    %al,-0x15(%ebp)
			cputchar(Chose);
  800157:	0f be 45 eb          	movsbl -0x15(%ebp),%eax
  80015b:	83 ec 0c             	sub    $0xc,%esp
  80015e:	50                   	push   %eax
  80015f:	e8 16 05 00 00       	call   80067a <cputchar>
  800164:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800167:	83 ec 0c             	sub    $0xc,%esp
  80016a:	6a 0a                	push   $0xa
  80016c:	e8 09 05 00 00       	call   80067a <cputchar>
  800171:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800174:	80 7d eb 61          	cmpb   $0x61,-0x15(%ebp)
  800178:	74 0c                	je     800186 <_main+0x14e>
  80017a:	80 7d eb 62          	cmpb   $0x62,-0x15(%ebp)
  80017e:	74 06                	je     800186 <_main+0x14e>
  800180:	80 7d eb 63          	cmpb   $0x63,-0x15(%ebp)
  800184:	75 b9                	jne    80013f <_main+0x107>

	//2012: unlock the interrupt
	sys_enable_interrupt();
  800186:	e8 bb 1d 00 00       	call   801f46 <sys_enable_interrupt>

	int  i ;
	switch (Chose)
  80018b:	0f be 45 eb          	movsbl -0x15(%ebp),%eax
  80018f:	83 f8 62             	cmp    $0x62,%eax
  800192:	74 1d                	je     8001b1 <_main+0x179>
  800194:	83 f8 63             	cmp    $0x63,%eax
  800197:	74 2b                	je     8001c4 <_main+0x18c>
  800199:	83 f8 61             	cmp    $0x61,%eax
  80019c:	75 39                	jne    8001d7 <_main+0x19f>
	{
	case 'a':
		InitializeAscending(Elements, NumOfElements);
  80019e:	83 ec 08             	sub    $0x8,%esp
  8001a1:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a7:	e8 54 03 00 00       	call   800500 <InitializeAscending>
  8001ac:	83 c4 10             	add    $0x10,%esp
		break ;
  8001af:	eb 37                	jmp    8001e8 <_main+0x1b0>
	case 'b':
		InitializeDescending(Elements, NumOfElements);
  8001b1:	83 ec 08             	sub    $0x8,%esp
  8001b4:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001ba:	e8 72 03 00 00       	call   800531 <InitializeDescending>
  8001bf:	83 c4 10             	add    $0x10,%esp
		break ;
  8001c2:	eb 24                	jmp    8001e8 <_main+0x1b0>
	case 'c':
		InitializeSemiRandom(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	e8 94 03 00 00       	call   800566 <InitializeSemiRandom>
  8001d2:	83 c4 10             	add    $0x10,%esp
		break ;
  8001d5:	eb 11                	jmp    8001e8 <_main+0x1b0>
	default:
		InitializeSemiRandom(Elements, NumOfElements);
  8001d7:	83 ec 08             	sub    $0x8,%esp
  8001da:	ff 75 f0             	pushl  -0x10(%ebp)
  8001dd:	ff 75 ec             	pushl  -0x14(%ebp)
  8001e0:	e8 81 03 00 00       	call   800566 <InitializeSemiRandom>
  8001e5:	83 c4 10             	add    $0x10,%esp
	}

	//Create the check-finishing counter
	int numOfSlaveProgs = 3 ;
  8001e8:	c7 45 e4 03 00 00 00 	movl   $0x3,-0x1c(%ebp)
	int *numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  8001ef:	83 ec 04             	sub    $0x4,%esp
  8001f2:	6a 01                	push   $0x1
  8001f4:	6a 04                	push   $0x4
  8001f6:	68 44 26 80 00       	push   $0x802644
  8001fb:	e8 60 18 00 00       	call   801a60 <smalloc>
  800200:	83 c4 10             	add    $0x10,%esp
  800203:	89 45 e0             	mov    %eax,-0x20(%ebp)
	*numOfFinished = 0 ;
  800206:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800209:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	/*[2] RUN THE SLAVES PROGRAMS*/
	int32 envIdQuickSort = sys_create_env("slave_qs", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80020f:	a1 20 30 80 00       	mov    0x803020,%eax
  800214:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  80021a:	a1 20 30 80 00       	mov    0x803020,%eax
  80021f:	8b 40 74             	mov    0x74(%eax),%eax
  800222:	83 ec 04             	sub    $0x4,%esp
  800225:	52                   	push   %edx
  800226:	50                   	push   %eax
  800227:	68 52 26 80 00       	push   $0x802652
  80022c:	e8 80 1e 00 00       	call   8020b1 <sys_create_env>
  800231:	83 c4 10             	add    $0x10,%esp
  800234:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int32 envIdMergeSort = sys_create_env("slave_ms", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800237:	a1 20 30 80 00       	mov    0x803020,%eax
  80023c:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800242:	a1 20 30 80 00       	mov    0x803020,%eax
  800247:	8b 40 74             	mov    0x74(%eax),%eax
  80024a:	83 ec 04             	sub    $0x4,%esp
  80024d:	52                   	push   %edx
  80024e:	50                   	push   %eax
  80024f:	68 5b 26 80 00       	push   $0x80265b
  800254:	e8 58 1e 00 00       	call   8020b1 <sys_create_env>
  800259:	83 c4 10             	add    $0x10,%esp
  80025c:	89 45 d8             	mov    %eax,-0x28(%ebp)
	int32 envIdStats = sys_create_env("slave_stats", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80025f:	a1 20 30 80 00       	mov    0x803020,%eax
  800264:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  80026a:	a1 20 30 80 00       	mov    0x803020,%eax
  80026f:	8b 40 74             	mov    0x74(%eax),%eax
  800272:	83 ec 04             	sub    $0x4,%esp
  800275:	52                   	push   %edx
  800276:	50                   	push   %eax
  800277:	68 64 26 80 00       	push   $0x802664
  80027c:	e8 30 1e 00 00       	call   8020b1 <sys_create_env>
  800281:	83 c4 10             	add    $0x10,%esp
  800284:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	sys_run_env(envIdQuickSort);
  800287:	83 ec 0c             	sub    $0xc,%esp
  80028a:	ff 75 dc             	pushl  -0x24(%ebp)
  80028d:	e8 3c 1e 00 00       	call   8020ce <sys_run_env>
  800292:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdMergeSort);
  800295:	83 ec 0c             	sub    $0xc,%esp
  800298:	ff 75 d8             	pushl  -0x28(%ebp)
  80029b:	e8 2e 1e 00 00       	call   8020ce <sys_run_env>
  8002a0:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdStats);
  8002a3:	83 ec 0c             	sub    $0xc,%esp
  8002a6:	ff 75 d4             	pushl  -0x2c(%ebp)
  8002a9:	e8 20 1e 00 00       	call   8020ce <sys_run_env>
  8002ae:	83 c4 10             	add    $0x10,%esp

	/*[3] BUSY-WAIT TILL FINISHING THEM*/
	while (*numOfFinished != numOfSlaveProgs) ;
  8002b1:	90                   	nop
  8002b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002b5:	8b 00                	mov    (%eax),%eax
  8002b7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8002ba:	75 f6                	jne    8002b2 <_main+0x27a>

	/*[4] GET THEIR RESULTS*/
	int *quicksortedArr = NULL;
  8002bc:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
	int *mergesortedArr = NULL;
  8002c3:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
	int *mean = NULL;
  8002ca:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
	int *var = NULL;
  8002d1:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
	int *min = NULL;
  8002d8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
	int *max = NULL;
  8002df:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
	int *med = NULL;
  8002e6:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
	quicksortedArr = sget(envIdQuickSort, "quicksortedArr") ;
  8002ed:	83 ec 08             	sub    $0x8,%esp
  8002f0:	68 70 26 80 00       	push   $0x802670
  8002f5:	ff 75 dc             	pushl  -0x24(%ebp)
  8002f8:	e8 83 17 00 00       	call   801a80 <sget>
  8002fd:	83 c4 10             	add    $0x10,%esp
  800300:	89 45 d0             	mov    %eax,-0x30(%ebp)
	mergesortedArr = sget(envIdMergeSort, "mergesortedArr") ;
  800303:	83 ec 08             	sub    $0x8,%esp
  800306:	68 7f 26 80 00       	push   $0x80267f
  80030b:	ff 75 d8             	pushl  -0x28(%ebp)
  80030e:	e8 6d 17 00 00       	call   801a80 <sget>
  800313:	83 c4 10             	add    $0x10,%esp
  800316:	89 45 cc             	mov    %eax,-0x34(%ebp)
	mean = sget(envIdStats, "mean") ;
  800319:	83 ec 08             	sub    $0x8,%esp
  80031c:	68 8e 26 80 00       	push   $0x80268e
  800321:	ff 75 d4             	pushl  -0x2c(%ebp)
  800324:	e8 57 17 00 00       	call   801a80 <sget>
  800329:	83 c4 10             	add    $0x10,%esp
  80032c:	89 45 c8             	mov    %eax,-0x38(%ebp)
	var = sget(envIdStats,"var") ;
  80032f:	83 ec 08             	sub    $0x8,%esp
  800332:	68 93 26 80 00       	push   $0x802693
  800337:	ff 75 d4             	pushl  -0x2c(%ebp)
  80033a:	e8 41 17 00 00       	call   801a80 <sget>
  80033f:	83 c4 10             	add    $0x10,%esp
  800342:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	min = sget(envIdStats,"min") ;
  800345:	83 ec 08             	sub    $0x8,%esp
  800348:	68 97 26 80 00       	push   $0x802697
  80034d:	ff 75 d4             	pushl  -0x2c(%ebp)
  800350:	e8 2b 17 00 00       	call   801a80 <sget>
  800355:	83 c4 10             	add    $0x10,%esp
  800358:	89 45 c0             	mov    %eax,-0x40(%ebp)
	max = sget(envIdStats,"max") ;
  80035b:	83 ec 08             	sub    $0x8,%esp
  80035e:	68 9b 26 80 00       	push   $0x80269b
  800363:	ff 75 d4             	pushl  -0x2c(%ebp)
  800366:	e8 15 17 00 00       	call   801a80 <sget>
  80036b:	83 c4 10             	add    $0x10,%esp
  80036e:	89 45 bc             	mov    %eax,-0x44(%ebp)
	med = sget(envIdStats,"med") ;
  800371:	83 ec 08             	sub    $0x8,%esp
  800374:	68 9f 26 80 00       	push   $0x80269f
  800379:	ff 75 d4             	pushl  -0x2c(%ebp)
  80037c:	e8 ff 16 00 00       	call   801a80 <sget>
  800381:	83 c4 10             	add    $0x10,%esp
  800384:	89 45 b8             	mov    %eax,-0x48(%ebp)

	/*[5] VALIDATE THE RESULTS*/
	uint32 sorted = CheckSorted(quicksortedArr, NumOfElements);
  800387:	83 ec 08             	sub    $0x8,%esp
  80038a:	ff 75 f0             	pushl  -0x10(%ebp)
  80038d:	ff 75 d0             	pushl  -0x30(%ebp)
  800390:	e8 14 01 00 00       	call   8004a9 <CheckSorted>
  800395:	83 c4 10             	add    $0x10,%esp
  800398:	89 45 b4             	mov    %eax,-0x4c(%ebp)
	if(sorted == 0) panic("The array is NOT quick-sorted correctly") ;
  80039b:	83 7d b4 00          	cmpl   $0x0,-0x4c(%ebp)
  80039f:	75 14                	jne    8003b5 <_main+0x37d>
  8003a1:	83 ec 04             	sub    $0x4,%esp
  8003a4:	68 a4 26 80 00       	push   $0x8026a4
  8003a9:	6a 62                	push   $0x62
  8003ab:	68 cc 26 80 00       	push   $0x8026cc
  8003b0:	e8 67 04 00 00       	call   80081c <_panic>
	sorted = CheckSorted(mergesortedArr, NumOfElements);
  8003b5:	83 ec 08             	sub    $0x8,%esp
  8003b8:	ff 75 f0             	pushl  -0x10(%ebp)
  8003bb:	ff 75 cc             	pushl  -0x34(%ebp)
  8003be:	e8 e6 00 00 00       	call   8004a9 <CheckSorted>
  8003c3:	83 c4 10             	add    $0x10,%esp
  8003c6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
	if(sorted == 0) panic("The array is NOT merge-sorted correctly") ;
  8003c9:	83 7d b4 00          	cmpl   $0x0,-0x4c(%ebp)
  8003cd:	75 14                	jne    8003e3 <_main+0x3ab>
  8003cf:	83 ec 04             	sub    $0x4,%esp
  8003d2:	68 ec 26 80 00       	push   $0x8026ec
  8003d7:	6a 64                	push   $0x64
  8003d9:	68 cc 26 80 00       	push   $0x8026cc
  8003de:	e8 39 04 00 00       	call   80081c <_panic>
	int correctMean, correctVar ;
	ArrayStats(Elements, NumOfElements, &correctMean , &correctVar);
  8003e3:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
  8003e9:	50                   	push   %eax
  8003ea:	8d 85 7c ff ff ff    	lea    -0x84(%ebp),%eax
  8003f0:	50                   	push   %eax
  8003f1:	ff 75 f0             	pushl  -0x10(%ebp)
  8003f4:	ff 75 ec             	pushl  -0x14(%ebp)
  8003f7:	e8 b6 01 00 00       	call   8005b2 <ArrayStats>
  8003fc:	83 c4 10             	add    $0x10,%esp
	int correctMin = quicksortedArr[0];
  8003ff:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800402:	8b 00                	mov    (%eax),%eax
  800404:	89 45 b0             	mov    %eax,-0x50(%ebp)
	int last = NumOfElements-1;
  800407:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80040a:	48                   	dec    %eax
  80040b:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int middle = (NumOfElements-1)/2;
  80040e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800411:	48                   	dec    %eax
  800412:	89 c2                	mov    %eax,%edx
  800414:	c1 ea 1f             	shr    $0x1f,%edx
  800417:	01 d0                	add    %edx,%eax
  800419:	d1 f8                	sar    %eax
  80041b:	89 45 a8             	mov    %eax,-0x58(%ebp)
	int correctMax = quicksortedArr[last];
  80041e:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800421:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800428:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80042b:	01 d0                	add    %edx,%eax
  80042d:	8b 00                	mov    (%eax),%eax
  80042f:	89 45 a4             	mov    %eax,-0x5c(%ebp)
	int correctMed = quicksortedArr[middle];
  800432:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800435:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80043f:	01 d0                	add    %edx,%eax
  800441:	8b 00                	mov    (%eax),%eax
  800443:	89 45 a0             	mov    %eax,-0x60(%ebp)
	//cprintf("Array is correctly sorted\n");
	//cprintf("mean = %d, var = %d\nmin = %d, max = %d, med = %d\n", *mean, *var, *min, *max, *med);
	//cprintf("mean = %d, var = %d\nmin = %d, max = %d, med = %d\n", correctMean, correctVar, correctMin, correctMax, correctMed);

	if(*mean != correctMean || *var != correctVar|| *min != correctMin || *max != correctMax || *med != correctMed)
  800446:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800449:	8b 10                	mov    (%eax),%edx
  80044b:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800451:	39 c2                	cmp    %eax,%edx
  800453:	75 2d                	jne    800482 <_main+0x44a>
  800455:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800458:	8b 10                	mov    (%eax),%edx
  80045a:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800460:	39 c2                	cmp    %eax,%edx
  800462:	75 1e                	jne    800482 <_main+0x44a>
  800464:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800467:	8b 00                	mov    (%eax),%eax
  800469:	3b 45 b0             	cmp    -0x50(%ebp),%eax
  80046c:	75 14                	jne    800482 <_main+0x44a>
  80046e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800471:	8b 00                	mov    (%eax),%eax
  800473:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
  800476:	75 0a                	jne    800482 <_main+0x44a>
  800478:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80047b:	8b 00                	mov    (%eax),%eax
  80047d:	3b 45 a0             	cmp    -0x60(%ebp),%eax
  800480:	74 14                	je     800496 <_main+0x45e>
		panic("The array STATS are NOT calculated correctly") ;
  800482:	83 ec 04             	sub    $0x4,%esp
  800485:	68 14 27 80 00       	push   $0x802714
  80048a:	6a 71                	push   $0x71
  80048c:	68 cc 26 80 00       	push   $0x8026cc
  800491:	e8 86 03 00 00       	call   80081c <_panic>

	cprintf("Congratulations!! Scenario of Using the Shared Variables [Create & Get] completed successfully!!\n\n\n");
  800496:	83 ec 0c             	sub    $0xc,%esp
  800499:	68 44 27 80 00       	push   $0x802744
  80049e:	e8 2d 06 00 00       	call   800ad0 <cprintf>
  8004a3:	83 c4 10             	add    $0x10,%esp

	return;
  8004a6:	90                   	nop
}
  8004a7:	c9                   	leave  
  8004a8:	c3                   	ret    

008004a9 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8004a9:	55                   	push   %ebp
  8004aa:	89 e5                	mov    %esp,%ebp
  8004ac:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8004af:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8004b6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8004bd:	eb 33                	jmp    8004f2 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8004bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8004c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cc:	01 d0                	add    %edx,%eax
  8004ce:	8b 10                	mov    (%eax),%edx
  8004d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8004d3:	40                   	inc    %eax
  8004d4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004db:	8b 45 08             	mov    0x8(%ebp),%eax
  8004de:	01 c8                	add    %ecx,%eax
  8004e0:	8b 00                	mov    (%eax),%eax
  8004e2:	39 c2                	cmp    %eax,%edx
  8004e4:	7e 09                	jle    8004ef <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8004e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8004ed:	eb 0c                	jmp    8004fb <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8004ef:	ff 45 f8             	incl   -0x8(%ebp)
  8004f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f5:	48                   	dec    %eax
  8004f6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8004f9:	7f c4                	jg     8004bf <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8004fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8004fe:	c9                   	leave  
  8004ff:	c3                   	ret    

00800500 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800500:	55                   	push   %ebp
  800501:	89 e5                	mov    %esp,%ebp
  800503:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800506:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80050d:	eb 17                	jmp    800526 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80050f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800512:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800519:	8b 45 08             	mov    0x8(%ebp),%eax
  80051c:	01 c2                	add    %eax,%edx
  80051e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800521:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800523:	ff 45 fc             	incl   -0x4(%ebp)
  800526:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800529:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80052c:	7c e1                	jl     80050f <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80052e:	90                   	nop
  80052f:	c9                   	leave  
  800530:	c3                   	ret    

00800531 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800531:	55                   	push   %ebp
  800532:	89 e5                	mov    %esp,%ebp
  800534:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800537:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80053e:	eb 1b                	jmp    80055b <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800540:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800543:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80054a:	8b 45 08             	mov    0x8(%ebp),%eax
  80054d:	01 c2                	add    %eax,%edx
  80054f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800552:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800555:	48                   	dec    %eax
  800556:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800558:	ff 45 fc             	incl   -0x4(%ebp)
  80055b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80055e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800561:	7c dd                	jl     800540 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800563:	90                   	nop
  800564:	c9                   	leave  
  800565:	c3                   	ret    

00800566 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800566:	55                   	push   %ebp
  800567:	89 e5                	mov    %esp,%ebp
  800569:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80056c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80056f:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800574:	f7 e9                	imul   %ecx
  800576:	c1 f9 1f             	sar    $0x1f,%ecx
  800579:	89 d0                	mov    %edx,%eax
  80057b:	29 c8                	sub    %ecx,%eax
  80057d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800580:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800587:	eb 1e                	jmp    8005a7 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800589:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80058c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800593:	8b 45 08             	mov    0x8(%ebp),%eax
  800596:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800599:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80059c:	99                   	cltd   
  80059d:	f7 7d f8             	idivl  -0x8(%ebp)
  8005a0:	89 d0                	mov    %edx,%eax
  8005a2:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8005a4:	ff 45 fc             	incl   -0x4(%ebp)
  8005a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8005aa:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005ad:	7c da                	jl     800589 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//cprintf("Elements[%d] = %d\n",i, Elements[i]);
	}

}
  8005af:	90                   	nop
  8005b0:	c9                   	leave  
  8005b1:	c3                   	ret    

008005b2 <ArrayStats>:

void ArrayStats(int *Elements, int NumOfElements, int *mean, int *var)
{
  8005b2:	55                   	push   %ebp
  8005b3:	89 e5                	mov    %esp,%ebp
  8005b5:	53                   	push   %ebx
  8005b6:	83 ec 10             	sub    $0x10,%esp
	int i ;
	*mean =0 ;
  8005b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8005bc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	for (i = 0 ; i < NumOfElements ; i++)
  8005c2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8005c9:	eb 20                	jmp    8005eb <ArrayStats+0x39>
	{
		*mean += Elements[i];
  8005cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8005ce:	8b 10                	mov    (%eax),%edx
  8005d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8005d3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005da:	8b 45 08             	mov    0x8(%ebp),%eax
  8005dd:	01 c8                	add    %ecx,%eax
  8005df:	8b 00                	mov    (%eax),%eax
  8005e1:	01 c2                	add    %eax,%edx
  8005e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8005e6:	89 10                	mov    %edx,(%eax)

void ArrayStats(int *Elements, int NumOfElements, int *mean, int *var)
{
	int i ;
	*mean =0 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8005e8:	ff 45 f8             	incl   -0x8(%ebp)
  8005eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8005ee:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005f1:	7c d8                	jl     8005cb <ArrayStats+0x19>
	{
		*mean += Elements[i];
	}
	*mean /= NumOfElements;
  8005f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8005f6:	8b 00                	mov    (%eax),%eax
  8005f8:	99                   	cltd   
  8005f9:	f7 7d 0c             	idivl  0xc(%ebp)
  8005fc:	89 c2                	mov    %eax,%edx
  8005fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800601:	89 10                	mov    %edx,(%eax)
	*var = 0;
  800603:	8b 45 14             	mov    0x14(%ebp),%eax
  800606:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	for (i = 0 ; i < NumOfElements ; i++)
  80060c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800613:	eb 46                	jmp    80065b <ArrayStats+0xa9>
	{
		*var += (Elements[i] - *mean)*(Elements[i] - *mean);
  800615:	8b 45 14             	mov    0x14(%ebp),%eax
  800618:	8b 10                	mov    (%eax),%edx
  80061a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80061d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800624:	8b 45 08             	mov    0x8(%ebp),%eax
  800627:	01 c8                	add    %ecx,%eax
  800629:	8b 08                	mov    (%eax),%ecx
  80062b:	8b 45 10             	mov    0x10(%ebp),%eax
  80062e:	8b 00                	mov    (%eax),%eax
  800630:	89 cb                	mov    %ecx,%ebx
  800632:	29 c3                	sub    %eax,%ebx
  800634:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800637:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80063e:	8b 45 08             	mov    0x8(%ebp),%eax
  800641:	01 c8                	add    %ecx,%eax
  800643:	8b 08                	mov    (%eax),%ecx
  800645:	8b 45 10             	mov    0x10(%ebp),%eax
  800648:	8b 00                	mov    (%eax),%eax
  80064a:	29 c1                	sub    %eax,%ecx
  80064c:	89 c8                	mov    %ecx,%eax
  80064e:	0f af c3             	imul   %ebx,%eax
  800651:	01 c2                	add    %eax,%edx
  800653:	8b 45 14             	mov    0x14(%ebp),%eax
  800656:	89 10                	mov    %edx,(%eax)
	{
		*mean += Elements[i];
	}
	*mean /= NumOfElements;
	*var = 0;
	for (i = 0 ; i < NumOfElements ; i++)
  800658:	ff 45 f8             	incl   -0x8(%ebp)
  80065b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80065e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800661:	7c b2                	jl     800615 <ArrayStats+0x63>
	{
		*var += (Elements[i] - *mean)*(Elements[i] - *mean);
	}
	*var /= NumOfElements;
  800663:	8b 45 14             	mov    0x14(%ebp),%eax
  800666:	8b 00                	mov    (%eax),%eax
  800668:	99                   	cltd   
  800669:	f7 7d 0c             	idivl  0xc(%ebp)
  80066c:	89 c2                	mov    %eax,%edx
  80066e:	8b 45 14             	mov    0x14(%ebp),%eax
  800671:	89 10                	mov    %edx,(%eax)
}
  800673:	90                   	nop
  800674:	83 c4 10             	add    $0x10,%esp
  800677:	5b                   	pop    %ebx
  800678:	5d                   	pop    %ebp
  800679:	c3                   	ret    

0080067a <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80067a:	55                   	push   %ebp
  80067b:	89 e5                	mov    %esp,%ebp
  80067d:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800680:	8b 45 08             	mov    0x8(%ebp),%eax
  800683:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800686:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80068a:	83 ec 0c             	sub    $0xc,%esp
  80068d:	50                   	push   %eax
  80068e:	e8 cd 18 00 00       	call   801f60 <sys_cputc>
  800693:	83 c4 10             	add    $0x10,%esp
}
  800696:	90                   	nop
  800697:	c9                   	leave  
  800698:	c3                   	ret    

00800699 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800699:	55                   	push   %ebp
  80069a:	89 e5                	mov    %esp,%ebp
  80069c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80069f:	e8 88 18 00 00       	call   801f2c <sys_disable_interrupt>
	char c = ch;
  8006a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a7:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8006aa:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8006ae:	83 ec 0c             	sub    $0xc,%esp
  8006b1:	50                   	push   %eax
  8006b2:	e8 a9 18 00 00       	call   801f60 <sys_cputc>
  8006b7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006ba:	e8 87 18 00 00       	call   801f46 <sys_enable_interrupt>
}
  8006bf:	90                   	nop
  8006c0:	c9                   	leave  
  8006c1:	c3                   	ret    

008006c2 <getchar>:

int
getchar(void)
{
  8006c2:	55                   	push   %ebp
  8006c3:	89 e5                	mov    %esp,%ebp
  8006c5:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8006c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8006cf:	eb 08                	jmp    8006d9 <getchar+0x17>
	{
		c = sys_cgetc();
  8006d1:	e8 6e 16 00 00       	call   801d44 <sys_cgetc>
  8006d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8006d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8006dd:	74 f2                	je     8006d1 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8006df:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8006e2:	c9                   	leave  
  8006e3:	c3                   	ret    

008006e4 <atomic_getchar>:

int
atomic_getchar(void)
{
  8006e4:	55                   	push   %ebp
  8006e5:	89 e5                	mov    %esp,%ebp
  8006e7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006ea:	e8 3d 18 00 00       	call   801f2c <sys_disable_interrupt>
	int c=0;
  8006ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8006f6:	eb 08                	jmp    800700 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8006f8:	e8 47 16 00 00       	call   801d44 <sys_cgetc>
  8006fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800700:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800704:	74 f2                	je     8006f8 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800706:	e8 3b 18 00 00       	call   801f46 <sys_enable_interrupt>
	return c;
  80070b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80070e:	c9                   	leave  
  80070f:	c3                   	ret    

00800710 <iscons>:

int iscons(int fdnum)
{
  800710:	55                   	push   %ebp
  800711:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800713:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800718:	5d                   	pop    %ebp
  800719:	c3                   	ret    

0080071a <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80071a:	55                   	push   %ebp
  80071b:	89 e5                	mov    %esp,%ebp
  80071d:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800720:	e8 6c 16 00 00       	call   801d91 <sys_getenvindex>
  800725:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800728:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80072b:	89 d0                	mov    %edx,%eax
  80072d:	01 c0                	add    %eax,%eax
  80072f:	01 d0                	add    %edx,%eax
  800731:	c1 e0 02             	shl    $0x2,%eax
  800734:	01 d0                	add    %edx,%eax
  800736:	c1 e0 06             	shl    $0x6,%eax
  800739:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80073e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800743:	a1 20 30 80 00       	mov    0x803020,%eax
  800748:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80074e:	84 c0                	test   %al,%al
  800750:	74 0f                	je     800761 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800752:	a1 20 30 80 00       	mov    0x803020,%eax
  800757:	05 f4 02 00 00       	add    $0x2f4,%eax
  80075c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800761:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800765:	7e 0a                	jle    800771 <libmain+0x57>
		binaryname = argv[0];
  800767:	8b 45 0c             	mov    0xc(%ebp),%eax
  80076a:	8b 00                	mov    (%eax),%eax
  80076c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800771:	83 ec 08             	sub    $0x8,%esp
  800774:	ff 75 0c             	pushl  0xc(%ebp)
  800777:	ff 75 08             	pushl  0x8(%ebp)
  80077a:	e8 b9 f8 ff ff       	call   800038 <_main>
  80077f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800782:	e8 a5 17 00 00       	call   801f2c <sys_disable_interrupt>
	cprintf("**************************************\n");
  800787:	83 ec 0c             	sub    $0xc,%esp
  80078a:	68 c0 27 80 00       	push   $0x8027c0
  80078f:	e8 3c 03 00 00       	call   800ad0 <cprintf>
  800794:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800797:	a1 20 30 80 00       	mov    0x803020,%eax
  80079c:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8007a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8007a7:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8007ad:	83 ec 04             	sub    $0x4,%esp
  8007b0:	52                   	push   %edx
  8007b1:	50                   	push   %eax
  8007b2:	68 e8 27 80 00       	push   $0x8027e8
  8007b7:	e8 14 03 00 00       	call   800ad0 <cprintf>
  8007bc:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8007bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8007c4:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8007ca:	83 ec 08             	sub    $0x8,%esp
  8007cd:	50                   	push   %eax
  8007ce:	68 0d 28 80 00       	push   $0x80280d
  8007d3:	e8 f8 02 00 00       	call   800ad0 <cprintf>
  8007d8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8007db:	83 ec 0c             	sub    $0xc,%esp
  8007de:	68 c0 27 80 00       	push   $0x8027c0
  8007e3:	e8 e8 02 00 00       	call   800ad0 <cprintf>
  8007e8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007eb:	e8 56 17 00 00       	call   801f46 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8007f0:	e8 19 00 00 00       	call   80080e <exit>
}
  8007f5:	90                   	nop
  8007f6:	c9                   	leave  
  8007f7:	c3                   	ret    

008007f8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007f8:	55                   	push   %ebp
  8007f9:	89 e5                	mov    %esp,%ebp
  8007fb:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007fe:	83 ec 0c             	sub    $0xc,%esp
  800801:	6a 00                	push   $0x0
  800803:	e8 55 15 00 00       	call   801d5d <sys_env_destroy>
  800808:	83 c4 10             	add    $0x10,%esp
}
  80080b:	90                   	nop
  80080c:	c9                   	leave  
  80080d:	c3                   	ret    

0080080e <exit>:

void
exit(void)
{
  80080e:	55                   	push   %ebp
  80080f:	89 e5                	mov    %esp,%ebp
  800811:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800814:	e8 aa 15 00 00       	call   801dc3 <sys_env_exit>
}
  800819:	90                   	nop
  80081a:	c9                   	leave  
  80081b:	c3                   	ret    

0080081c <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80081c:	55                   	push   %ebp
  80081d:	89 e5                	mov    %esp,%ebp
  80081f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800822:	8d 45 10             	lea    0x10(%ebp),%eax
  800825:	83 c0 04             	add    $0x4,%eax
  800828:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80082b:	a1 30 30 80 00       	mov    0x803030,%eax
  800830:	85 c0                	test   %eax,%eax
  800832:	74 16                	je     80084a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800834:	a1 30 30 80 00       	mov    0x803030,%eax
  800839:	83 ec 08             	sub    $0x8,%esp
  80083c:	50                   	push   %eax
  80083d:	68 24 28 80 00       	push   $0x802824
  800842:	e8 89 02 00 00       	call   800ad0 <cprintf>
  800847:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80084a:	a1 00 30 80 00       	mov    0x803000,%eax
  80084f:	ff 75 0c             	pushl  0xc(%ebp)
  800852:	ff 75 08             	pushl  0x8(%ebp)
  800855:	50                   	push   %eax
  800856:	68 29 28 80 00       	push   $0x802829
  80085b:	e8 70 02 00 00       	call   800ad0 <cprintf>
  800860:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800863:	8b 45 10             	mov    0x10(%ebp),%eax
  800866:	83 ec 08             	sub    $0x8,%esp
  800869:	ff 75 f4             	pushl  -0xc(%ebp)
  80086c:	50                   	push   %eax
  80086d:	e8 f3 01 00 00       	call   800a65 <vcprintf>
  800872:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800875:	83 ec 08             	sub    $0x8,%esp
  800878:	6a 00                	push   $0x0
  80087a:	68 45 28 80 00       	push   $0x802845
  80087f:	e8 e1 01 00 00       	call   800a65 <vcprintf>
  800884:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800887:	e8 82 ff ff ff       	call   80080e <exit>

	// should not return here
	while (1) ;
  80088c:	eb fe                	jmp    80088c <_panic+0x70>

0080088e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80088e:	55                   	push   %ebp
  80088f:	89 e5                	mov    %esp,%ebp
  800891:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800894:	a1 20 30 80 00       	mov    0x803020,%eax
  800899:	8b 50 74             	mov    0x74(%eax),%edx
  80089c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089f:	39 c2                	cmp    %eax,%edx
  8008a1:	74 14                	je     8008b7 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8008a3:	83 ec 04             	sub    $0x4,%esp
  8008a6:	68 48 28 80 00       	push   $0x802848
  8008ab:	6a 26                	push   $0x26
  8008ad:	68 94 28 80 00       	push   $0x802894
  8008b2:	e8 65 ff ff ff       	call   80081c <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8008b7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8008be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8008c5:	e9 c2 00 00 00       	jmp    80098c <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8008ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d7:	01 d0                	add    %edx,%eax
  8008d9:	8b 00                	mov    (%eax),%eax
  8008db:	85 c0                	test   %eax,%eax
  8008dd:	75 08                	jne    8008e7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8008df:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008e2:	e9 a2 00 00 00       	jmp    800989 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8008e7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ee:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8008f5:	eb 69                	jmp    800960 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8008f7:	a1 20 30 80 00       	mov    0x803020,%eax
  8008fc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800902:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800905:	89 d0                	mov    %edx,%eax
  800907:	01 c0                	add    %eax,%eax
  800909:	01 d0                	add    %edx,%eax
  80090b:	c1 e0 02             	shl    $0x2,%eax
  80090e:	01 c8                	add    %ecx,%eax
  800910:	8a 40 04             	mov    0x4(%eax),%al
  800913:	84 c0                	test   %al,%al
  800915:	75 46                	jne    80095d <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800917:	a1 20 30 80 00       	mov    0x803020,%eax
  80091c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800922:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800925:	89 d0                	mov    %edx,%eax
  800927:	01 c0                	add    %eax,%eax
  800929:	01 d0                	add    %edx,%eax
  80092b:	c1 e0 02             	shl    $0x2,%eax
  80092e:	01 c8                	add    %ecx,%eax
  800930:	8b 00                	mov    (%eax),%eax
  800932:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800935:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800938:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80093d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80093f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800942:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800949:	8b 45 08             	mov    0x8(%ebp),%eax
  80094c:	01 c8                	add    %ecx,%eax
  80094e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800950:	39 c2                	cmp    %eax,%edx
  800952:	75 09                	jne    80095d <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800954:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80095b:	eb 12                	jmp    80096f <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80095d:	ff 45 e8             	incl   -0x18(%ebp)
  800960:	a1 20 30 80 00       	mov    0x803020,%eax
  800965:	8b 50 74             	mov    0x74(%eax),%edx
  800968:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80096b:	39 c2                	cmp    %eax,%edx
  80096d:	77 88                	ja     8008f7 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80096f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800973:	75 14                	jne    800989 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800975:	83 ec 04             	sub    $0x4,%esp
  800978:	68 a0 28 80 00       	push   $0x8028a0
  80097d:	6a 3a                	push   $0x3a
  80097f:	68 94 28 80 00       	push   $0x802894
  800984:	e8 93 fe ff ff       	call   80081c <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800989:	ff 45 f0             	incl   -0x10(%ebp)
  80098c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80098f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800992:	0f 8c 32 ff ff ff    	jl     8008ca <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800998:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80099f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8009a6:	eb 26                	jmp    8009ce <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8009a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8009ad:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009b3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009b6:	89 d0                	mov    %edx,%eax
  8009b8:	01 c0                	add    %eax,%eax
  8009ba:	01 d0                	add    %edx,%eax
  8009bc:	c1 e0 02             	shl    $0x2,%eax
  8009bf:	01 c8                	add    %ecx,%eax
  8009c1:	8a 40 04             	mov    0x4(%eax),%al
  8009c4:	3c 01                	cmp    $0x1,%al
  8009c6:	75 03                	jne    8009cb <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8009c8:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009cb:	ff 45 e0             	incl   -0x20(%ebp)
  8009ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8009d3:	8b 50 74             	mov    0x74(%eax),%edx
  8009d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009d9:	39 c2                	cmp    %eax,%edx
  8009db:	77 cb                	ja     8009a8 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009e0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009e3:	74 14                	je     8009f9 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8009e5:	83 ec 04             	sub    $0x4,%esp
  8009e8:	68 f4 28 80 00       	push   $0x8028f4
  8009ed:	6a 44                	push   $0x44
  8009ef:	68 94 28 80 00       	push   $0x802894
  8009f4:	e8 23 fe ff ff       	call   80081c <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8009f9:	90                   	nop
  8009fa:	c9                   	leave  
  8009fb:	c3                   	ret    

008009fc <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009fc:	55                   	push   %ebp
  8009fd:	89 e5                	mov    %esp,%ebp
  8009ff:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800a02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a05:	8b 00                	mov    (%eax),%eax
  800a07:	8d 48 01             	lea    0x1(%eax),%ecx
  800a0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a0d:	89 0a                	mov    %ecx,(%edx)
  800a0f:	8b 55 08             	mov    0x8(%ebp),%edx
  800a12:	88 d1                	mov    %dl,%cl
  800a14:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a17:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1e:	8b 00                	mov    (%eax),%eax
  800a20:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a25:	75 2c                	jne    800a53 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a27:	a0 24 30 80 00       	mov    0x803024,%al
  800a2c:	0f b6 c0             	movzbl %al,%eax
  800a2f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a32:	8b 12                	mov    (%edx),%edx
  800a34:	89 d1                	mov    %edx,%ecx
  800a36:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a39:	83 c2 08             	add    $0x8,%edx
  800a3c:	83 ec 04             	sub    $0x4,%esp
  800a3f:	50                   	push   %eax
  800a40:	51                   	push   %ecx
  800a41:	52                   	push   %edx
  800a42:	e8 d4 12 00 00       	call   801d1b <sys_cputs>
  800a47:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a56:	8b 40 04             	mov    0x4(%eax),%eax
  800a59:	8d 50 01             	lea    0x1(%eax),%edx
  800a5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a62:	90                   	nop
  800a63:	c9                   	leave  
  800a64:	c3                   	ret    

00800a65 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a65:	55                   	push   %ebp
  800a66:	89 e5                	mov    %esp,%ebp
  800a68:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a6e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a75:	00 00 00 
	b.cnt = 0;
  800a78:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a7f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a82:	ff 75 0c             	pushl  0xc(%ebp)
  800a85:	ff 75 08             	pushl  0x8(%ebp)
  800a88:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a8e:	50                   	push   %eax
  800a8f:	68 fc 09 80 00       	push   $0x8009fc
  800a94:	e8 11 02 00 00       	call   800caa <vprintfmt>
  800a99:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a9c:	a0 24 30 80 00       	mov    0x803024,%al
  800aa1:	0f b6 c0             	movzbl %al,%eax
  800aa4:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800aaa:	83 ec 04             	sub    $0x4,%esp
  800aad:	50                   	push   %eax
  800aae:	52                   	push   %edx
  800aaf:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ab5:	83 c0 08             	add    $0x8,%eax
  800ab8:	50                   	push   %eax
  800ab9:	e8 5d 12 00 00       	call   801d1b <sys_cputs>
  800abe:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800ac1:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800ac8:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800ace:	c9                   	leave  
  800acf:	c3                   	ret    

00800ad0 <cprintf>:

int cprintf(const char *fmt, ...) {
  800ad0:	55                   	push   %ebp
  800ad1:	89 e5                	mov    %esp,%ebp
  800ad3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ad6:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800add:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ae0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	83 ec 08             	sub    $0x8,%esp
  800ae9:	ff 75 f4             	pushl  -0xc(%ebp)
  800aec:	50                   	push   %eax
  800aed:	e8 73 ff ff ff       	call   800a65 <vcprintf>
  800af2:	83 c4 10             	add    $0x10,%esp
  800af5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800af8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800afb:	c9                   	leave  
  800afc:	c3                   	ret    

00800afd <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800afd:	55                   	push   %ebp
  800afe:	89 e5                	mov    %esp,%ebp
  800b00:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800b03:	e8 24 14 00 00       	call   801f2c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800b08:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b11:	83 ec 08             	sub    $0x8,%esp
  800b14:	ff 75 f4             	pushl  -0xc(%ebp)
  800b17:	50                   	push   %eax
  800b18:	e8 48 ff ff ff       	call   800a65 <vcprintf>
  800b1d:	83 c4 10             	add    $0x10,%esp
  800b20:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800b23:	e8 1e 14 00 00       	call   801f46 <sys_enable_interrupt>
	return cnt;
  800b28:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b2b:	c9                   	leave  
  800b2c:	c3                   	ret    

00800b2d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b2d:	55                   	push   %ebp
  800b2e:	89 e5                	mov    %esp,%ebp
  800b30:	53                   	push   %ebx
  800b31:	83 ec 14             	sub    $0x14,%esp
  800b34:	8b 45 10             	mov    0x10(%ebp),%eax
  800b37:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b3a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b40:	8b 45 18             	mov    0x18(%ebp),%eax
  800b43:	ba 00 00 00 00       	mov    $0x0,%edx
  800b48:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b4b:	77 55                	ja     800ba2 <printnum+0x75>
  800b4d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b50:	72 05                	jb     800b57 <printnum+0x2a>
  800b52:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b55:	77 4b                	ja     800ba2 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b57:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b5a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b5d:	8b 45 18             	mov    0x18(%ebp),%eax
  800b60:	ba 00 00 00 00       	mov    $0x0,%edx
  800b65:	52                   	push   %edx
  800b66:	50                   	push   %eax
  800b67:	ff 75 f4             	pushl  -0xc(%ebp)
  800b6a:	ff 75 f0             	pushl  -0x10(%ebp)
  800b6d:	e8 9a 17 00 00       	call   80230c <__udivdi3>
  800b72:	83 c4 10             	add    $0x10,%esp
  800b75:	83 ec 04             	sub    $0x4,%esp
  800b78:	ff 75 20             	pushl  0x20(%ebp)
  800b7b:	53                   	push   %ebx
  800b7c:	ff 75 18             	pushl  0x18(%ebp)
  800b7f:	52                   	push   %edx
  800b80:	50                   	push   %eax
  800b81:	ff 75 0c             	pushl  0xc(%ebp)
  800b84:	ff 75 08             	pushl  0x8(%ebp)
  800b87:	e8 a1 ff ff ff       	call   800b2d <printnum>
  800b8c:	83 c4 20             	add    $0x20,%esp
  800b8f:	eb 1a                	jmp    800bab <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b91:	83 ec 08             	sub    $0x8,%esp
  800b94:	ff 75 0c             	pushl  0xc(%ebp)
  800b97:	ff 75 20             	pushl  0x20(%ebp)
  800b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9d:	ff d0                	call   *%eax
  800b9f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ba2:	ff 4d 1c             	decl   0x1c(%ebp)
  800ba5:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800ba9:	7f e6                	jg     800b91 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800bab:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800bae:	bb 00 00 00 00       	mov    $0x0,%ebx
  800bb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bb6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bb9:	53                   	push   %ebx
  800bba:	51                   	push   %ecx
  800bbb:	52                   	push   %edx
  800bbc:	50                   	push   %eax
  800bbd:	e8 5a 18 00 00       	call   80241c <__umoddi3>
  800bc2:	83 c4 10             	add    $0x10,%esp
  800bc5:	05 54 2b 80 00       	add    $0x802b54,%eax
  800bca:	8a 00                	mov    (%eax),%al
  800bcc:	0f be c0             	movsbl %al,%eax
  800bcf:	83 ec 08             	sub    $0x8,%esp
  800bd2:	ff 75 0c             	pushl  0xc(%ebp)
  800bd5:	50                   	push   %eax
  800bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd9:	ff d0                	call   *%eax
  800bdb:	83 c4 10             	add    $0x10,%esp
}
  800bde:	90                   	nop
  800bdf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800be2:	c9                   	leave  
  800be3:	c3                   	ret    

00800be4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800be4:	55                   	push   %ebp
  800be5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800be7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800beb:	7e 1c                	jle    800c09 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bed:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf0:	8b 00                	mov    (%eax),%eax
  800bf2:	8d 50 08             	lea    0x8(%eax),%edx
  800bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf8:	89 10                	mov    %edx,(%eax)
  800bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfd:	8b 00                	mov    (%eax),%eax
  800bff:	83 e8 08             	sub    $0x8,%eax
  800c02:	8b 50 04             	mov    0x4(%eax),%edx
  800c05:	8b 00                	mov    (%eax),%eax
  800c07:	eb 40                	jmp    800c49 <getuint+0x65>
	else if (lflag)
  800c09:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c0d:	74 1e                	je     800c2d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c12:	8b 00                	mov    (%eax),%eax
  800c14:	8d 50 04             	lea    0x4(%eax),%edx
  800c17:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1a:	89 10                	mov    %edx,(%eax)
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1f:	8b 00                	mov    (%eax),%eax
  800c21:	83 e8 04             	sub    $0x4,%eax
  800c24:	8b 00                	mov    (%eax),%eax
  800c26:	ba 00 00 00 00       	mov    $0x0,%edx
  800c2b:	eb 1c                	jmp    800c49 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c30:	8b 00                	mov    (%eax),%eax
  800c32:	8d 50 04             	lea    0x4(%eax),%edx
  800c35:	8b 45 08             	mov    0x8(%ebp),%eax
  800c38:	89 10                	mov    %edx,(%eax)
  800c3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3d:	8b 00                	mov    (%eax),%eax
  800c3f:	83 e8 04             	sub    $0x4,%eax
  800c42:	8b 00                	mov    (%eax),%eax
  800c44:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c49:	5d                   	pop    %ebp
  800c4a:	c3                   	ret    

00800c4b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c4b:	55                   	push   %ebp
  800c4c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c4e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c52:	7e 1c                	jle    800c70 <getint+0x25>
		return va_arg(*ap, long long);
  800c54:	8b 45 08             	mov    0x8(%ebp),%eax
  800c57:	8b 00                	mov    (%eax),%eax
  800c59:	8d 50 08             	lea    0x8(%eax),%edx
  800c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5f:	89 10                	mov    %edx,(%eax)
  800c61:	8b 45 08             	mov    0x8(%ebp),%eax
  800c64:	8b 00                	mov    (%eax),%eax
  800c66:	83 e8 08             	sub    $0x8,%eax
  800c69:	8b 50 04             	mov    0x4(%eax),%edx
  800c6c:	8b 00                	mov    (%eax),%eax
  800c6e:	eb 38                	jmp    800ca8 <getint+0x5d>
	else if (lflag)
  800c70:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c74:	74 1a                	je     800c90 <getint+0x45>
		return va_arg(*ap, long);
  800c76:	8b 45 08             	mov    0x8(%ebp),%eax
  800c79:	8b 00                	mov    (%eax),%eax
  800c7b:	8d 50 04             	lea    0x4(%eax),%edx
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	89 10                	mov    %edx,(%eax)
  800c83:	8b 45 08             	mov    0x8(%ebp),%eax
  800c86:	8b 00                	mov    (%eax),%eax
  800c88:	83 e8 04             	sub    $0x4,%eax
  800c8b:	8b 00                	mov    (%eax),%eax
  800c8d:	99                   	cltd   
  800c8e:	eb 18                	jmp    800ca8 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
  800c93:	8b 00                	mov    (%eax),%eax
  800c95:	8d 50 04             	lea    0x4(%eax),%edx
  800c98:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9b:	89 10                	mov    %edx,(%eax)
  800c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca0:	8b 00                	mov    (%eax),%eax
  800ca2:	83 e8 04             	sub    $0x4,%eax
  800ca5:	8b 00                	mov    (%eax),%eax
  800ca7:	99                   	cltd   
}
  800ca8:	5d                   	pop    %ebp
  800ca9:	c3                   	ret    

00800caa <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800caa:	55                   	push   %ebp
  800cab:	89 e5                	mov    %esp,%ebp
  800cad:	56                   	push   %esi
  800cae:	53                   	push   %ebx
  800caf:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800cb2:	eb 17                	jmp    800ccb <vprintfmt+0x21>
			if (ch == '\0')
  800cb4:	85 db                	test   %ebx,%ebx
  800cb6:	0f 84 af 03 00 00    	je     80106b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800cbc:	83 ec 08             	sub    $0x8,%esp
  800cbf:	ff 75 0c             	pushl  0xc(%ebp)
  800cc2:	53                   	push   %ebx
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	ff d0                	call   *%eax
  800cc8:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ccb:	8b 45 10             	mov    0x10(%ebp),%eax
  800cce:	8d 50 01             	lea    0x1(%eax),%edx
  800cd1:	89 55 10             	mov    %edx,0x10(%ebp)
  800cd4:	8a 00                	mov    (%eax),%al
  800cd6:	0f b6 d8             	movzbl %al,%ebx
  800cd9:	83 fb 25             	cmp    $0x25,%ebx
  800cdc:	75 d6                	jne    800cb4 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800cde:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ce2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ce9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cf0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800cf7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800cfe:	8b 45 10             	mov    0x10(%ebp),%eax
  800d01:	8d 50 01             	lea    0x1(%eax),%edx
  800d04:	89 55 10             	mov    %edx,0x10(%ebp)
  800d07:	8a 00                	mov    (%eax),%al
  800d09:	0f b6 d8             	movzbl %al,%ebx
  800d0c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800d0f:	83 f8 55             	cmp    $0x55,%eax
  800d12:	0f 87 2b 03 00 00    	ja     801043 <vprintfmt+0x399>
  800d18:	8b 04 85 78 2b 80 00 	mov    0x802b78(,%eax,4),%eax
  800d1f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d21:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d25:	eb d7                	jmp    800cfe <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d27:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d2b:	eb d1                	jmp    800cfe <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d2d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d34:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d37:	89 d0                	mov    %edx,%eax
  800d39:	c1 e0 02             	shl    $0x2,%eax
  800d3c:	01 d0                	add    %edx,%eax
  800d3e:	01 c0                	add    %eax,%eax
  800d40:	01 d8                	add    %ebx,%eax
  800d42:	83 e8 30             	sub    $0x30,%eax
  800d45:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d48:	8b 45 10             	mov    0x10(%ebp),%eax
  800d4b:	8a 00                	mov    (%eax),%al
  800d4d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d50:	83 fb 2f             	cmp    $0x2f,%ebx
  800d53:	7e 3e                	jle    800d93 <vprintfmt+0xe9>
  800d55:	83 fb 39             	cmp    $0x39,%ebx
  800d58:	7f 39                	jg     800d93 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d5a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d5d:	eb d5                	jmp    800d34 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d5f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d62:	83 c0 04             	add    $0x4,%eax
  800d65:	89 45 14             	mov    %eax,0x14(%ebp)
  800d68:	8b 45 14             	mov    0x14(%ebp),%eax
  800d6b:	83 e8 04             	sub    $0x4,%eax
  800d6e:	8b 00                	mov    (%eax),%eax
  800d70:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d73:	eb 1f                	jmp    800d94 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d75:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d79:	79 83                	jns    800cfe <vprintfmt+0x54>
				width = 0;
  800d7b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d82:	e9 77 ff ff ff       	jmp    800cfe <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d87:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d8e:	e9 6b ff ff ff       	jmp    800cfe <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d93:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d94:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d98:	0f 89 60 ff ff ff    	jns    800cfe <vprintfmt+0x54>
				width = precision, precision = -1;
  800d9e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800da1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800da4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800dab:	e9 4e ff ff ff       	jmp    800cfe <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800db0:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800db3:	e9 46 ff ff ff       	jmp    800cfe <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800db8:	8b 45 14             	mov    0x14(%ebp),%eax
  800dbb:	83 c0 04             	add    $0x4,%eax
  800dbe:	89 45 14             	mov    %eax,0x14(%ebp)
  800dc1:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc4:	83 e8 04             	sub    $0x4,%eax
  800dc7:	8b 00                	mov    (%eax),%eax
  800dc9:	83 ec 08             	sub    $0x8,%esp
  800dcc:	ff 75 0c             	pushl  0xc(%ebp)
  800dcf:	50                   	push   %eax
  800dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd3:	ff d0                	call   *%eax
  800dd5:	83 c4 10             	add    $0x10,%esp
			break;
  800dd8:	e9 89 02 00 00       	jmp    801066 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ddd:	8b 45 14             	mov    0x14(%ebp),%eax
  800de0:	83 c0 04             	add    $0x4,%eax
  800de3:	89 45 14             	mov    %eax,0x14(%ebp)
  800de6:	8b 45 14             	mov    0x14(%ebp),%eax
  800de9:	83 e8 04             	sub    $0x4,%eax
  800dec:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800dee:	85 db                	test   %ebx,%ebx
  800df0:	79 02                	jns    800df4 <vprintfmt+0x14a>
				err = -err;
  800df2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800df4:	83 fb 64             	cmp    $0x64,%ebx
  800df7:	7f 0b                	jg     800e04 <vprintfmt+0x15a>
  800df9:	8b 34 9d c0 29 80 00 	mov    0x8029c0(,%ebx,4),%esi
  800e00:	85 f6                	test   %esi,%esi
  800e02:	75 19                	jne    800e1d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800e04:	53                   	push   %ebx
  800e05:	68 65 2b 80 00       	push   $0x802b65
  800e0a:	ff 75 0c             	pushl  0xc(%ebp)
  800e0d:	ff 75 08             	pushl  0x8(%ebp)
  800e10:	e8 5e 02 00 00       	call   801073 <printfmt>
  800e15:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800e18:	e9 49 02 00 00       	jmp    801066 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e1d:	56                   	push   %esi
  800e1e:	68 6e 2b 80 00       	push   $0x802b6e
  800e23:	ff 75 0c             	pushl  0xc(%ebp)
  800e26:	ff 75 08             	pushl  0x8(%ebp)
  800e29:	e8 45 02 00 00       	call   801073 <printfmt>
  800e2e:	83 c4 10             	add    $0x10,%esp
			break;
  800e31:	e9 30 02 00 00       	jmp    801066 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e36:	8b 45 14             	mov    0x14(%ebp),%eax
  800e39:	83 c0 04             	add    $0x4,%eax
  800e3c:	89 45 14             	mov    %eax,0x14(%ebp)
  800e3f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e42:	83 e8 04             	sub    $0x4,%eax
  800e45:	8b 30                	mov    (%eax),%esi
  800e47:	85 f6                	test   %esi,%esi
  800e49:	75 05                	jne    800e50 <vprintfmt+0x1a6>
				p = "(null)";
  800e4b:	be 71 2b 80 00       	mov    $0x802b71,%esi
			if (width > 0 && padc != '-')
  800e50:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e54:	7e 6d                	jle    800ec3 <vprintfmt+0x219>
  800e56:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e5a:	74 67                	je     800ec3 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e5c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e5f:	83 ec 08             	sub    $0x8,%esp
  800e62:	50                   	push   %eax
  800e63:	56                   	push   %esi
  800e64:	e8 12 05 00 00       	call   80137b <strnlen>
  800e69:	83 c4 10             	add    $0x10,%esp
  800e6c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e6f:	eb 16                	jmp    800e87 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e71:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e75:	83 ec 08             	sub    $0x8,%esp
  800e78:	ff 75 0c             	pushl  0xc(%ebp)
  800e7b:	50                   	push   %eax
  800e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7f:	ff d0                	call   *%eax
  800e81:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e84:	ff 4d e4             	decl   -0x1c(%ebp)
  800e87:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e8b:	7f e4                	jg     800e71 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e8d:	eb 34                	jmp    800ec3 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e8f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e93:	74 1c                	je     800eb1 <vprintfmt+0x207>
  800e95:	83 fb 1f             	cmp    $0x1f,%ebx
  800e98:	7e 05                	jle    800e9f <vprintfmt+0x1f5>
  800e9a:	83 fb 7e             	cmp    $0x7e,%ebx
  800e9d:	7e 12                	jle    800eb1 <vprintfmt+0x207>
					putch('?', putdat);
  800e9f:	83 ec 08             	sub    $0x8,%esp
  800ea2:	ff 75 0c             	pushl  0xc(%ebp)
  800ea5:	6a 3f                	push   $0x3f
  800ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaa:	ff d0                	call   *%eax
  800eac:	83 c4 10             	add    $0x10,%esp
  800eaf:	eb 0f                	jmp    800ec0 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800eb1:	83 ec 08             	sub    $0x8,%esp
  800eb4:	ff 75 0c             	pushl  0xc(%ebp)
  800eb7:	53                   	push   %ebx
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	ff d0                	call   *%eax
  800ebd:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ec0:	ff 4d e4             	decl   -0x1c(%ebp)
  800ec3:	89 f0                	mov    %esi,%eax
  800ec5:	8d 70 01             	lea    0x1(%eax),%esi
  800ec8:	8a 00                	mov    (%eax),%al
  800eca:	0f be d8             	movsbl %al,%ebx
  800ecd:	85 db                	test   %ebx,%ebx
  800ecf:	74 24                	je     800ef5 <vprintfmt+0x24b>
  800ed1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ed5:	78 b8                	js     800e8f <vprintfmt+0x1e5>
  800ed7:	ff 4d e0             	decl   -0x20(%ebp)
  800eda:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ede:	79 af                	jns    800e8f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ee0:	eb 13                	jmp    800ef5 <vprintfmt+0x24b>
				putch(' ', putdat);
  800ee2:	83 ec 08             	sub    $0x8,%esp
  800ee5:	ff 75 0c             	pushl  0xc(%ebp)
  800ee8:	6a 20                	push   $0x20
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	ff d0                	call   *%eax
  800eef:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ef2:	ff 4d e4             	decl   -0x1c(%ebp)
  800ef5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ef9:	7f e7                	jg     800ee2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800efb:	e9 66 01 00 00       	jmp    801066 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f00:	83 ec 08             	sub    $0x8,%esp
  800f03:	ff 75 e8             	pushl  -0x18(%ebp)
  800f06:	8d 45 14             	lea    0x14(%ebp),%eax
  800f09:	50                   	push   %eax
  800f0a:	e8 3c fd ff ff       	call   800c4b <getint>
  800f0f:	83 c4 10             	add    $0x10,%esp
  800f12:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f15:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800f18:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f1b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1e:	85 d2                	test   %edx,%edx
  800f20:	79 23                	jns    800f45 <vprintfmt+0x29b>
				putch('-', putdat);
  800f22:	83 ec 08             	sub    $0x8,%esp
  800f25:	ff 75 0c             	pushl  0xc(%ebp)
  800f28:	6a 2d                	push   $0x2d
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	ff d0                	call   *%eax
  800f2f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f32:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f35:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f38:	f7 d8                	neg    %eax
  800f3a:	83 d2 00             	adc    $0x0,%edx
  800f3d:	f7 da                	neg    %edx
  800f3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f42:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f45:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f4c:	e9 bc 00 00 00       	jmp    80100d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f51:	83 ec 08             	sub    $0x8,%esp
  800f54:	ff 75 e8             	pushl  -0x18(%ebp)
  800f57:	8d 45 14             	lea    0x14(%ebp),%eax
  800f5a:	50                   	push   %eax
  800f5b:	e8 84 fc ff ff       	call   800be4 <getuint>
  800f60:	83 c4 10             	add    $0x10,%esp
  800f63:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f66:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f69:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f70:	e9 98 00 00 00       	jmp    80100d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f75:	83 ec 08             	sub    $0x8,%esp
  800f78:	ff 75 0c             	pushl  0xc(%ebp)
  800f7b:	6a 58                	push   $0x58
  800f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f80:	ff d0                	call   *%eax
  800f82:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f85:	83 ec 08             	sub    $0x8,%esp
  800f88:	ff 75 0c             	pushl  0xc(%ebp)
  800f8b:	6a 58                	push   $0x58
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	ff d0                	call   *%eax
  800f92:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f95:	83 ec 08             	sub    $0x8,%esp
  800f98:	ff 75 0c             	pushl  0xc(%ebp)
  800f9b:	6a 58                	push   $0x58
  800f9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa0:	ff d0                	call   *%eax
  800fa2:	83 c4 10             	add    $0x10,%esp
			break;
  800fa5:	e9 bc 00 00 00       	jmp    801066 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800faa:	83 ec 08             	sub    $0x8,%esp
  800fad:	ff 75 0c             	pushl  0xc(%ebp)
  800fb0:	6a 30                	push   $0x30
  800fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb5:	ff d0                	call   *%eax
  800fb7:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800fba:	83 ec 08             	sub    $0x8,%esp
  800fbd:	ff 75 0c             	pushl  0xc(%ebp)
  800fc0:	6a 78                	push   $0x78
  800fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc5:	ff d0                	call   *%eax
  800fc7:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800fca:	8b 45 14             	mov    0x14(%ebp),%eax
  800fcd:	83 c0 04             	add    $0x4,%eax
  800fd0:	89 45 14             	mov    %eax,0x14(%ebp)
  800fd3:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd6:	83 e8 04             	sub    $0x4,%eax
  800fd9:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fdb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fde:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fe5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800fec:	eb 1f                	jmp    80100d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fee:	83 ec 08             	sub    $0x8,%esp
  800ff1:	ff 75 e8             	pushl  -0x18(%ebp)
  800ff4:	8d 45 14             	lea    0x14(%ebp),%eax
  800ff7:	50                   	push   %eax
  800ff8:	e8 e7 fb ff ff       	call   800be4 <getuint>
  800ffd:	83 c4 10             	add    $0x10,%esp
  801000:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801003:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801006:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80100d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801011:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801014:	83 ec 04             	sub    $0x4,%esp
  801017:	52                   	push   %edx
  801018:	ff 75 e4             	pushl  -0x1c(%ebp)
  80101b:	50                   	push   %eax
  80101c:	ff 75 f4             	pushl  -0xc(%ebp)
  80101f:	ff 75 f0             	pushl  -0x10(%ebp)
  801022:	ff 75 0c             	pushl  0xc(%ebp)
  801025:	ff 75 08             	pushl  0x8(%ebp)
  801028:	e8 00 fb ff ff       	call   800b2d <printnum>
  80102d:	83 c4 20             	add    $0x20,%esp
			break;
  801030:	eb 34                	jmp    801066 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801032:	83 ec 08             	sub    $0x8,%esp
  801035:	ff 75 0c             	pushl  0xc(%ebp)
  801038:	53                   	push   %ebx
  801039:	8b 45 08             	mov    0x8(%ebp),%eax
  80103c:	ff d0                	call   *%eax
  80103e:	83 c4 10             	add    $0x10,%esp
			break;
  801041:	eb 23                	jmp    801066 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801043:	83 ec 08             	sub    $0x8,%esp
  801046:	ff 75 0c             	pushl  0xc(%ebp)
  801049:	6a 25                	push   $0x25
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
  80104e:	ff d0                	call   *%eax
  801050:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801053:	ff 4d 10             	decl   0x10(%ebp)
  801056:	eb 03                	jmp    80105b <vprintfmt+0x3b1>
  801058:	ff 4d 10             	decl   0x10(%ebp)
  80105b:	8b 45 10             	mov    0x10(%ebp),%eax
  80105e:	48                   	dec    %eax
  80105f:	8a 00                	mov    (%eax),%al
  801061:	3c 25                	cmp    $0x25,%al
  801063:	75 f3                	jne    801058 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801065:	90                   	nop
		}
	}
  801066:	e9 47 fc ff ff       	jmp    800cb2 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80106b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80106c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80106f:	5b                   	pop    %ebx
  801070:	5e                   	pop    %esi
  801071:	5d                   	pop    %ebp
  801072:	c3                   	ret    

00801073 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801073:	55                   	push   %ebp
  801074:	89 e5                	mov    %esp,%ebp
  801076:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801079:	8d 45 10             	lea    0x10(%ebp),%eax
  80107c:	83 c0 04             	add    $0x4,%eax
  80107f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801082:	8b 45 10             	mov    0x10(%ebp),%eax
  801085:	ff 75 f4             	pushl  -0xc(%ebp)
  801088:	50                   	push   %eax
  801089:	ff 75 0c             	pushl  0xc(%ebp)
  80108c:	ff 75 08             	pushl  0x8(%ebp)
  80108f:	e8 16 fc ff ff       	call   800caa <vprintfmt>
  801094:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801097:	90                   	nop
  801098:	c9                   	leave  
  801099:	c3                   	ret    

0080109a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80109a:	55                   	push   %ebp
  80109b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80109d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a0:	8b 40 08             	mov    0x8(%eax),%eax
  8010a3:	8d 50 01             	lea    0x1(%eax),%edx
  8010a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a9:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8010ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010af:	8b 10                	mov    (%eax),%edx
  8010b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b4:	8b 40 04             	mov    0x4(%eax),%eax
  8010b7:	39 c2                	cmp    %eax,%edx
  8010b9:	73 12                	jae    8010cd <sprintputch+0x33>
		*b->buf++ = ch;
  8010bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010be:	8b 00                	mov    (%eax),%eax
  8010c0:	8d 48 01             	lea    0x1(%eax),%ecx
  8010c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c6:	89 0a                	mov    %ecx,(%edx)
  8010c8:	8b 55 08             	mov    0x8(%ebp),%edx
  8010cb:	88 10                	mov    %dl,(%eax)
}
  8010cd:	90                   	nop
  8010ce:	5d                   	pop    %ebp
  8010cf:	c3                   	ret    

008010d0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8010d0:	55                   	push   %ebp
  8010d1:	89 e5                	mov    %esp,%ebp
  8010d3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010df:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	01 d0                	add    %edx,%eax
  8010e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010f1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010f5:	74 06                	je     8010fd <vsnprintf+0x2d>
  8010f7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010fb:	7f 07                	jg     801104 <vsnprintf+0x34>
		return -E_INVAL;
  8010fd:	b8 03 00 00 00       	mov    $0x3,%eax
  801102:	eb 20                	jmp    801124 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801104:	ff 75 14             	pushl  0x14(%ebp)
  801107:	ff 75 10             	pushl  0x10(%ebp)
  80110a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80110d:	50                   	push   %eax
  80110e:	68 9a 10 80 00       	push   $0x80109a
  801113:	e8 92 fb ff ff       	call   800caa <vprintfmt>
  801118:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80111b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80111e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801121:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801124:	c9                   	leave  
  801125:	c3                   	ret    

00801126 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801126:	55                   	push   %ebp
  801127:	89 e5                	mov    %esp,%ebp
  801129:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80112c:	8d 45 10             	lea    0x10(%ebp),%eax
  80112f:	83 c0 04             	add    $0x4,%eax
  801132:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801135:	8b 45 10             	mov    0x10(%ebp),%eax
  801138:	ff 75 f4             	pushl  -0xc(%ebp)
  80113b:	50                   	push   %eax
  80113c:	ff 75 0c             	pushl  0xc(%ebp)
  80113f:	ff 75 08             	pushl  0x8(%ebp)
  801142:	e8 89 ff ff ff       	call   8010d0 <vsnprintf>
  801147:	83 c4 10             	add    $0x10,%esp
  80114a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80114d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801150:	c9                   	leave  
  801151:	c3                   	ret    

00801152 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801152:	55                   	push   %ebp
  801153:	89 e5                	mov    %esp,%ebp
  801155:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801158:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80115c:	74 13                	je     801171 <readline+0x1f>
		cprintf("%s", prompt);
  80115e:	83 ec 08             	sub    $0x8,%esp
  801161:	ff 75 08             	pushl  0x8(%ebp)
  801164:	68 d0 2c 80 00       	push   $0x802cd0
  801169:	e8 62 f9 ff ff       	call   800ad0 <cprintf>
  80116e:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801171:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801178:	83 ec 0c             	sub    $0xc,%esp
  80117b:	6a 00                	push   $0x0
  80117d:	e8 8e f5 ff ff       	call   800710 <iscons>
  801182:	83 c4 10             	add    $0x10,%esp
  801185:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801188:	e8 35 f5 ff ff       	call   8006c2 <getchar>
  80118d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801190:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801194:	79 22                	jns    8011b8 <readline+0x66>
			if (c != -E_EOF)
  801196:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80119a:	0f 84 ad 00 00 00    	je     80124d <readline+0xfb>
				cprintf("read error: %e\n", c);
  8011a0:	83 ec 08             	sub    $0x8,%esp
  8011a3:	ff 75 ec             	pushl  -0x14(%ebp)
  8011a6:	68 d3 2c 80 00       	push   $0x802cd3
  8011ab:	e8 20 f9 ff ff       	call   800ad0 <cprintf>
  8011b0:	83 c4 10             	add    $0x10,%esp
			return;
  8011b3:	e9 95 00 00 00       	jmp    80124d <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011b8:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011bc:	7e 34                	jle    8011f2 <readline+0xa0>
  8011be:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011c5:	7f 2b                	jg     8011f2 <readline+0xa0>
			if (echoing)
  8011c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011cb:	74 0e                	je     8011db <readline+0x89>
				cputchar(c);
  8011cd:	83 ec 0c             	sub    $0xc,%esp
  8011d0:	ff 75 ec             	pushl  -0x14(%ebp)
  8011d3:	e8 a2 f4 ff ff       	call   80067a <cputchar>
  8011d8:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011de:	8d 50 01             	lea    0x1(%eax),%edx
  8011e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011e4:	89 c2                	mov    %eax,%edx
  8011e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e9:	01 d0                	add    %edx,%eax
  8011eb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011ee:	88 10                	mov    %dl,(%eax)
  8011f0:	eb 56                	jmp    801248 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8011f2:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011f6:	75 1f                	jne    801217 <readline+0xc5>
  8011f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011fc:	7e 19                	jle    801217 <readline+0xc5>
			if (echoing)
  8011fe:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801202:	74 0e                	je     801212 <readline+0xc0>
				cputchar(c);
  801204:	83 ec 0c             	sub    $0xc,%esp
  801207:	ff 75 ec             	pushl  -0x14(%ebp)
  80120a:	e8 6b f4 ff ff       	call   80067a <cputchar>
  80120f:	83 c4 10             	add    $0x10,%esp

			i--;
  801212:	ff 4d f4             	decl   -0xc(%ebp)
  801215:	eb 31                	jmp    801248 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801217:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80121b:	74 0a                	je     801227 <readline+0xd5>
  80121d:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801221:	0f 85 61 ff ff ff    	jne    801188 <readline+0x36>
			if (echoing)
  801227:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80122b:	74 0e                	je     80123b <readline+0xe9>
				cputchar(c);
  80122d:	83 ec 0c             	sub    $0xc,%esp
  801230:	ff 75 ec             	pushl  -0x14(%ebp)
  801233:	e8 42 f4 ff ff       	call   80067a <cputchar>
  801238:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80123b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80123e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801241:	01 d0                	add    %edx,%eax
  801243:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801246:	eb 06                	jmp    80124e <readline+0xfc>
		}
	}
  801248:	e9 3b ff ff ff       	jmp    801188 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  80124d:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80124e:	c9                   	leave  
  80124f:	c3                   	ret    

00801250 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801250:	55                   	push   %ebp
  801251:	89 e5                	mov    %esp,%ebp
  801253:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801256:	e8 d1 0c 00 00       	call   801f2c <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80125b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80125f:	74 13                	je     801274 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801261:	83 ec 08             	sub    $0x8,%esp
  801264:	ff 75 08             	pushl  0x8(%ebp)
  801267:	68 d0 2c 80 00       	push   $0x802cd0
  80126c:	e8 5f f8 ff ff       	call   800ad0 <cprintf>
  801271:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801274:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80127b:	83 ec 0c             	sub    $0xc,%esp
  80127e:	6a 00                	push   $0x0
  801280:	e8 8b f4 ff ff       	call   800710 <iscons>
  801285:	83 c4 10             	add    $0x10,%esp
  801288:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80128b:	e8 32 f4 ff ff       	call   8006c2 <getchar>
  801290:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801293:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801297:	79 23                	jns    8012bc <atomic_readline+0x6c>
			if (c != -E_EOF)
  801299:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80129d:	74 13                	je     8012b2 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80129f:	83 ec 08             	sub    $0x8,%esp
  8012a2:	ff 75 ec             	pushl  -0x14(%ebp)
  8012a5:	68 d3 2c 80 00       	push   $0x802cd3
  8012aa:	e8 21 f8 ff ff       	call   800ad0 <cprintf>
  8012af:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8012b2:	e8 8f 0c 00 00       	call   801f46 <sys_enable_interrupt>
			return;
  8012b7:	e9 9a 00 00 00       	jmp    801356 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8012bc:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8012c0:	7e 34                	jle    8012f6 <atomic_readline+0xa6>
  8012c2:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8012c9:	7f 2b                	jg     8012f6 <atomic_readline+0xa6>
			if (echoing)
  8012cb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012cf:	74 0e                	je     8012df <atomic_readline+0x8f>
				cputchar(c);
  8012d1:	83 ec 0c             	sub    $0xc,%esp
  8012d4:	ff 75 ec             	pushl  -0x14(%ebp)
  8012d7:	e8 9e f3 ff ff       	call   80067a <cputchar>
  8012dc:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8012df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012e2:	8d 50 01             	lea    0x1(%eax),%edx
  8012e5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012e8:	89 c2                	mov    %eax,%edx
  8012ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ed:	01 d0                	add    %edx,%eax
  8012ef:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012f2:	88 10                	mov    %dl,(%eax)
  8012f4:	eb 5b                	jmp    801351 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8012f6:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012fa:	75 1f                	jne    80131b <atomic_readline+0xcb>
  8012fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801300:	7e 19                	jle    80131b <atomic_readline+0xcb>
			if (echoing)
  801302:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801306:	74 0e                	je     801316 <atomic_readline+0xc6>
				cputchar(c);
  801308:	83 ec 0c             	sub    $0xc,%esp
  80130b:	ff 75 ec             	pushl  -0x14(%ebp)
  80130e:	e8 67 f3 ff ff       	call   80067a <cputchar>
  801313:	83 c4 10             	add    $0x10,%esp
			i--;
  801316:	ff 4d f4             	decl   -0xc(%ebp)
  801319:	eb 36                	jmp    801351 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  80131b:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80131f:	74 0a                	je     80132b <atomic_readline+0xdb>
  801321:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801325:	0f 85 60 ff ff ff    	jne    80128b <atomic_readline+0x3b>
			if (echoing)
  80132b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80132f:	74 0e                	je     80133f <atomic_readline+0xef>
				cputchar(c);
  801331:	83 ec 0c             	sub    $0xc,%esp
  801334:	ff 75 ec             	pushl  -0x14(%ebp)
  801337:	e8 3e f3 ff ff       	call   80067a <cputchar>
  80133c:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  80133f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801342:	8b 45 0c             	mov    0xc(%ebp),%eax
  801345:	01 d0                	add    %edx,%eax
  801347:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80134a:	e8 f7 0b 00 00       	call   801f46 <sys_enable_interrupt>
			return;
  80134f:	eb 05                	jmp    801356 <atomic_readline+0x106>
		}
	}
  801351:	e9 35 ff ff ff       	jmp    80128b <atomic_readline+0x3b>
}
  801356:	c9                   	leave  
  801357:	c3                   	ret    

00801358 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801358:	55                   	push   %ebp
  801359:	89 e5                	mov    %esp,%ebp
  80135b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80135e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801365:	eb 06                	jmp    80136d <strlen+0x15>
		n++;
  801367:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80136a:	ff 45 08             	incl   0x8(%ebp)
  80136d:	8b 45 08             	mov    0x8(%ebp),%eax
  801370:	8a 00                	mov    (%eax),%al
  801372:	84 c0                	test   %al,%al
  801374:	75 f1                	jne    801367 <strlen+0xf>
		n++;
	return n;
  801376:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801379:	c9                   	leave  
  80137a:	c3                   	ret    

0080137b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
  80137e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801381:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801388:	eb 09                	jmp    801393 <strnlen+0x18>
		n++;
  80138a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80138d:	ff 45 08             	incl   0x8(%ebp)
  801390:	ff 4d 0c             	decl   0xc(%ebp)
  801393:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801397:	74 09                	je     8013a2 <strnlen+0x27>
  801399:	8b 45 08             	mov    0x8(%ebp),%eax
  80139c:	8a 00                	mov    (%eax),%al
  80139e:	84 c0                	test   %al,%al
  8013a0:	75 e8                	jne    80138a <strnlen+0xf>
		n++;
	return n;
  8013a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013a5:	c9                   	leave  
  8013a6:	c3                   	ret    

008013a7 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8013a7:	55                   	push   %ebp
  8013a8:	89 e5                	mov    %esp,%ebp
  8013aa:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8013ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8013b3:	90                   	nop
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	8d 50 01             	lea    0x1(%eax),%edx
  8013ba:	89 55 08             	mov    %edx,0x8(%ebp)
  8013bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013c3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013c6:	8a 12                	mov    (%edx),%dl
  8013c8:	88 10                	mov    %dl,(%eax)
  8013ca:	8a 00                	mov    (%eax),%al
  8013cc:	84 c0                	test   %al,%al
  8013ce:	75 e4                	jne    8013b4 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013d3:	c9                   	leave  
  8013d4:	c3                   	ret    

008013d5 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013d5:	55                   	push   %ebp
  8013d6:	89 e5                	mov    %esp,%ebp
  8013d8:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013db:	8b 45 08             	mov    0x8(%ebp),%eax
  8013de:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013e8:	eb 1f                	jmp    801409 <strncpy+0x34>
		*dst++ = *src;
  8013ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ed:	8d 50 01             	lea    0x1(%eax),%edx
  8013f0:	89 55 08             	mov    %edx,0x8(%ebp)
  8013f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013f6:	8a 12                	mov    (%edx),%dl
  8013f8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fd:	8a 00                	mov    (%eax),%al
  8013ff:	84 c0                	test   %al,%al
  801401:	74 03                	je     801406 <strncpy+0x31>
			src++;
  801403:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801406:	ff 45 fc             	incl   -0x4(%ebp)
  801409:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80140c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80140f:	72 d9                	jb     8013ea <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801411:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801414:	c9                   	leave  
  801415:	c3                   	ret    

00801416 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801416:	55                   	push   %ebp
  801417:	89 e5                	mov    %esp,%ebp
  801419:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80141c:	8b 45 08             	mov    0x8(%ebp),%eax
  80141f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801422:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801426:	74 30                	je     801458 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801428:	eb 16                	jmp    801440 <strlcpy+0x2a>
			*dst++ = *src++;
  80142a:	8b 45 08             	mov    0x8(%ebp),%eax
  80142d:	8d 50 01             	lea    0x1(%eax),%edx
  801430:	89 55 08             	mov    %edx,0x8(%ebp)
  801433:	8b 55 0c             	mov    0xc(%ebp),%edx
  801436:	8d 4a 01             	lea    0x1(%edx),%ecx
  801439:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80143c:	8a 12                	mov    (%edx),%dl
  80143e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801440:	ff 4d 10             	decl   0x10(%ebp)
  801443:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801447:	74 09                	je     801452 <strlcpy+0x3c>
  801449:	8b 45 0c             	mov    0xc(%ebp),%eax
  80144c:	8a 00                	mov    (%eax),%al
  80144e:	84 c0                	test   %al,%al
  801450:	75 d8                	jne    80142a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801452:	8b 45 08             	mov    0x8(%ebp),%eax
  801455:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801458:	8b 55 08             	mov    0x8(%ebp),%edx
  80145b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80145e:	29 c2                	sub    %eax,%edx
  801460:	89 d0                	mov    %edx,%eax
}
  801462:	c9                   	leave  
  801463:	c3                   	ret    

00801464 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801464:	55                   	push   %ebp
  801465:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801467:	eb 06                	jmp    80146f <strcmp+0xb>
		p++, q++;
  801469:	ff 45 08             	incl   0x8(%ebp)
  80146c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80146f:	8b 45 08             	mov    0x8(%ebp),%eax
  801472:	8a 00                	mov    (%eax),%al
  801474:	84 c0                	test   %al,%al
  801476:	74 0e                	je     801486 <strcmp+0x22>
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
  80147b:	8a 10                	mov    (%eax),%dl
  80147d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801480:	8a 00                	mov    (%eax),%al
  801482:	38 c2                	cmp    %al,%dl
  801484:	74 e3                	je     801469 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	8a 00                	mov    (%eax),%al
  80148b:	0f b6 d0             	movzbl %al,%edx
  80148e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801491:	8a 00                	mov    (%eax),%al
  801493:	0f b6 c0             	movzbl %al,%eax
  801496:	29 c2                	sub    %eax,%edx
  801498:	89 d0                	mov    %edx,%eax
}
  80149a:	5d                   	pop    %ebp
  80149b:	c3                   	ret    

0080149c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80149c:	55                   	push   %ebp
  80149d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80149f:	eb 09                	jmp    8014aa <strncmp+0xe>
		n--, p++, q++;
  8014a1:	ff 4d 10             	decl   0x10(%ebp)
  8014a4:	ff 45 08             	incl   0x8(%ebp)
  8014a7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8014aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014ae:	74 17                	je     8014c7 <strncmp+0x2b>
  8014b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b3:	8a 00                	mov    (%eax),%al
  8014b5:	84 c0                	test   %al,%al
  8014b7:	74 0e                	je     8014c7 <strncmp+0x2b>
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	8a 10                	mov    (%eax),%dl
  8014be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c1:	8a 00                	mov    (%eax),%al
  8014c3:	38 c2                	cmp    %al,%dl
  8014c5:	74 da                	je     8014a1 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014c7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014cb:	75 07                	jne    8014d4 <strncmp+0x38>
		return 0;
  8014cd:	b8 00 00 00 00       	mov    $0x0,%eax
  8014d2:	eb 14                	jmp    8014e8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d7:	8a 00                	mov    (%eax),%al
  8014d9:	0f b6 d0             	movzbl %al,%edx
  8014dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014df:	8a 00                	mov    (%eax),%al
  8014e1:	0f b6 c0             	movzbl %al,%eax
  8014e4:	29 c2                	sub    %eax,%edx
  8014e6:	89 d0                	mov    %edx,%eax
}
  8014e8:	5d                   	pop    %ebp
  8014e9:	c3                   	ret    

008014ea <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
  8014ed:	83 ec 04             	sub    $0x4,%esp
  8014f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014f6:	eb 12                	jmp    80150a <strchr+0x20>
		if (*s == c)
  8014f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fb:	8a 00                	mov    (%eax),%al
  8014fd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801500:	75 05                	jne    801507 <strchr+0x1d>
			return (char *) s;
  801502:	8b 45 08             	mov    0x8(%ebp),%eax
  801505:	eb 11                	jmp    801518 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801507:	ff 45 08             	incl   0x8(%ebp)
  80150a:	8b 45 08             	mov    0x8(%ebp),%eax
  80150d:	8a 00                	mov    (%eax),%al
  80150f:	84 c0                	test   %al,%al
  801511:	75 e5                	jne    8014f8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801513:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801518:	c9                   	leave  
  801519:	c3                   	ret    

0080151a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80151a:	55                   	push   %ebp
  80151b:	89 e5                	mov    %esp,%ebp
  80151d:	83 ec 04             	sub    $0x4,%esp
  801520:	8b 45 0c             	mov    0xc(%ebp),%eax
  801523:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801526:	eb 0d                	jmp    801535 <strfind+0x1b>
		if (*s == c)
  801528:	8b 45 08             	mov    0x8(%ebp),%eax
  80152b:	8a 00                	mov    (%eax),%al
  80152d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801530:	74 0e                	je     801540 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801532:	ff 45 08             	incl   0x8(%ebp)
  801535:	8b 45 08             	mov    0x8(%ebp),%eax
  801538:	8a 00                	mov    (%eax),%al
  80153a:	84 c0                	test   %al,%al
  80153c:	75 ea                	jne    801528 <strfind+0xe>
  80153e:	eb 01                	jmp    801541 <strfind+0x27>
		if (*s == c)
			break;
  801540:	90                   	nop
	return (char *) s;
  801541:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
  801549:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
  80154f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801552:	8b 45 10             	mov    0x10(%ebp),%eax
  801555:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801558:	eb 0e                	jmp    801568 <memset+0x22>
		*p++ = c;
  80155a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80155d:	8d 50 01             	lea    0x1(%eax),%edx
  801560:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801563:	8b 55 0c             	mov    0xc(%ebp),%edx
  801566:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801568:	ff 4d f8             	decl   -0x8(%ebp)
  80156b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80156f:	79 e9                	jns    80155a <memset+0x14>
		*p++ = c;

	return v;
  801571:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801574:	c9                   	leave  
  801575:	c3                   	ret    

00801576 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801576:	55                   	push   %ebp
  801577:	89 e5                	mov    %esp,%ebp
  801579:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80157c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801582:	8b 45 08             	mov    0x8(%ebp),%eax
  801585:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801588:	eb 16                	jmp    8015a0 <memcpy+0x2a>
		*d++ = *s++;
  80158a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80158d:	8d 50 01             	lea    0x1(%eax),%edx
  801590:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801593:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801596:	8d 4a 01             	lea    0x1(%edx),%ecx
  801599:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80159c:	8a 12                	mov    (%edx),%dl
  80159e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8015a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015a6:	89 55 10             	mov    %edx,0x10(%ebp)
  8015a9:	85 c0                	test   %eax,%eax
  8015ab:	75 dd                	jne    80158a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8015ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015b0:	c9                   	leave  
  8015b1:	c3                   	ret    

008015b2 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8015b2:	55                   	push   %ebp
  8015b3:	89 e5                	mov    %esp,%ebp
  8015b5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8015b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8015be:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8015c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015c7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015ca:	73 50                	jae    80161c <memmove+0x6a>
  8015cc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d2:	01 d0                	add    %edx,%eax
  8015d4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015d7:	76 43                	jbe    80161c <memmove+0x6a>
		s += n;
  8015d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015dc:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015df:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e2:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015e5:	eb 10                	jmp    8015f7 <memmove+0x45>
			*--d = *--s;
  8015e7:	ff 4d f8             	decl   -0x8(%ebp)
  8015ea:	ff 4d fc             	decl   -0x4(%ebp)
  8015ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015f0:	8a 10                	mov    (%eax),%dl
  8015f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015f5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015fa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015fd:	89 55 10             	mov    %edx,0x10(%ebp)
  801600:	85 c0                	test   %eax,%eax
  801602:	75 e3                	jne    8015e7 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801604:	eb 23                	jmp    801629 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801606:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801609:	8d 50 01             	lea    0x1(%eax),%edx
  80160c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80160f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801612:	8d 4a 01             	lea    0x1(%edx),%ecx
  801615:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801618:	8a 12                	mov    (%edx),%dl
  80161a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80161c:	8b 45 10             	mov    0x10(%ebp),%eax
  80161f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801622:	89 55 10             	mov    %edx,0x10(%ebp)
  801625:	85 c0                	test   %eax,%eax
  801627:	75 dd                	jne    801606 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801629:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80162c:	c9                   	leave  
  80162d:	c3                   	ret    

0080162e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80162e:	55                   	push   %ebp
  80162f:	89 e5                	mov    %esp,%ebp
  801631:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801634:	8b 45 08             	mov    0x8(%ebp),%eax
  801637:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80163a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80163d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801640:	eb 2a                	jmp    80166c <memcmp+0x3e>
		if (*s1 != *s2)
  801642:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801645:	8a 10                	mov    (%eax),%dl
  801647:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80164a:	8a 00                	mov    (%eax),%al
  80164c:	38 c2                	cmp    %al,%dl
  80164e:	74 16                	je     801666 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801650:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801653:	8a 00                	mov    (%eax),%al
  801655:	0f b6 d0             	movzbl %al,%edx
  801658:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80165b:	8a 00                	mov    (%eax),%al
  80165d:	0f b6 c0             	movzbl %al,%eax
  801660:	29 c2                	sub    %eax,%edx
  801662:	89 d0                	mov    %edx,%eax
  801664:	eb 18                	jmp    80167e <memcmp+0x50>
		s1++, s2++;
  801666:	ff 45 fc             	incl   -0x4(%ebp)
  801669:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80166c:	8b 45 10             	mov    0x10(%ebp),%eax
  80166f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801672:	89 55 10             	mov    %edx,0x10(%ebp)
  801675:	85 c0                	test   %eax,%eax
  801677:	75 c9                	jne    801642 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801679:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80167e:	c9                   	leave  
  80167f:	c3                   	ret    

00801680 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801680:	55                   	push   %ebp
  801681:	89 e5                	mov    %esp,%ebp
  801683:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801686:	8b 55 08             	mov    0x8(%ebp),%edx
  801689:	8b 45 10             	mov    0x10(%ebp),%eax
  80168c:	01 d0                	add    %edx,%eax
  80168e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801691:	eb 15                	jmp    8016a8 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	8a 00                	mov    (%eax),%al
  801698:	0f b6 d0             	movzbl %al,%edx
  80169b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80169e:	0f b6 c0             	movzbl %al,%eax
  8016a1:	39 c2                	cmp    %eax,%edx
  8016a3:	74 0d                	je     8016b2 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8016a5:	ff 45 08             	incl   0x8(%ebp)
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8016ae:	72 e3                	jb     801693 <memfind+0x13>
  8016b0:	eb 01                	jmp    8016b3 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8016b2:	90                   	nop
	return (void *) s;
  8016b3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016b6:	c9                   	leave  
  8016b7:	c3                   	ret    

008016b8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8016b8:	55                   	push   %ebp
  8016b9:	89 e5                	mov    %esp,%ebp
  8016bb:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8016be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8016c5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016cc:	eb 03                	jmp    8016d1 <strtol+0x19>
		s++;
  8016ce:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d4:	8a 00                	mov    (%eax),%al
  8016d6:	3c 20                	cmp    $0x20,%al
  8016d8:	74 f4                	je     8016ce <strtol+0x16>
  8016da:	8b 45 08             	mov    0x8(%ebp),%eax
  8016dd:	8a 00                	mov    (%eax),%al
  8016df:	3c 09                	cmp    $0x9,%al
  8016e1:	74 eb                	je     8016ce <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e6:	8a 00                	mov    (%eax),%al
  8016e8:	3c 2b                	cmp    $0x2b,%al
  8016ea:	75 05                	jne    8016f1 <strtol+0x39>
		s++;
  8016ec:	ff 45 08             	incl   0x8(%ebp)
  8016ef:	eb 13                	jmp    801704 <strtol+0x4c>
	else if (*s == '-')
  8016f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f4:	8a 00                	mov    (%eax),%al
  8016f6:	3c 2d                	cmp    $0x2d,%al
  8016f8:	75 0a                	jne    801704 <strtol+0x4c>
		s++, neg = 1;
  8016fa:	ff 45 08             	incl   0x8(%ebp)
  8016fd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801704:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801708:	74 06                	je     801710 <strtol+0x58>
  80170a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80170e:	75 20                	jne    801730 <strtol+0x78>
  801710:	8b 45 08             	mov    0x8(%ebp),%eax
  801713:	8a 00                	mov    (%eax),%al
  801715:	3c 30                	cmp    $0x30,%al
  801717:	75 17                	jne    801730 <strtol+0x78>
  801719:	8b 45 08             	mov    0x8(%ebp),%eax
  80171c:	40                   	inc    %eax
  80171d:	8a 00                	mov    (%eax),%al
  80171f:	3c 78                	cmp    $0x78,%al
  801721:	75 0d                	jne    801730 <strtol+0x78>
		s += 2, base = 16;
  801723:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801727:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80172e:	eb 28                	jmp    801758 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801730:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801734:	75 15                	jne    80174b <strtol+0x93>
  801736:	8b 45 08             	mov    0x8(%ebp),%eax
  801739:	8a 00                	mov    (%eax),%al
  80173b:	3c 30                	cmp    $0x30,%al
  80173d:	75 0c                	jne    80174b <strtol+0x93>
		s++, base = 8;
  80173f:	ff 45 08             	incl   0x8(%ebp)
  801742:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801749:	eb 0d                	jmp    801758 <strtol+0xa0>
	else if (base == 0)
  80174b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80174f:	75 07                	jne    801758 <strtol+0xa0>
		base = 10;
  801751:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801758:	8b 45 08             	mov    0x8(%ebp),%eax
  80175b:	8a 00                	mov    (%eax),%al
  80175d:	3c 2f                	cmp    $0x2f,%al
  80175f:	7e 19                	jle    80177a <strtol+0xc2>
  801761:	8b 45 08             	mov    0x8(%ebp),%eax
  801764:	8a 00                	mov    (%eax),%al
  801766:	3c 39                	cmp    $0x39,%al
  801768:	7f 10                	jg     80177a <strtol+0xc2>
			dig = *s - '0';
  80176a:	8b 45 08             	mov    0x8(%ebp),%eax
  80176d:	8a 00                	mov    (%eax),%al
  80176f:	0f be c0             	movsbl %al,%eax
  801772:	83 e8 30             	sub    $0x30,%eax
  801775:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801778:	eb 42                	jmp    8017bc <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80177a:	8b 45 08             	mov    0x8(%ebp),%eax
  80177d:	8a 00                	mov    (%eax),%al
  80177f:	3c 60                	cmp    $0x60,%al
  801781:	7e 19                	jle    80179c <strtol+0xe4>
  801783:	8b 45 08             	mov    0x8(%ebp),%eax
  801786:	8a 00                	mov    (%eax),%al
  801788:	3c 7a                	cmp    $0x7a,%al
  80178a:	7f 10                	jg     80179c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
  80178f:	8a 00                	mov    (%eax),%al
  801791:	0f be c0             	movsbl %al,%eax
  801794:	83 e8 57             	sub    $0x57,%eax
  801797:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80179a:	eb 20                	jmp    8017bc <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80179c:	8b 45 08             	mov    0x8(%ebp),%eax
  80179f:	8a 00                	mov    (%eax),%al
  8017a1:	3c 40                	cmp    $0x40,%al
  8017a3:	7e 39                	jle    8017de <strtol+0x126>
  8017a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a8:	8a 00                	mov    (%eax),%al
  8017aa:	3c 5a                	cmp    $0x5a,%al
  8017ac:	7f 30                	jg     8017de <strtol+0x126>
			dig = *s - 'A' + 10;
  8017ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b1:	8a 00                	mov    (%eax),%al
  8017b3:	0f be c0             	movsbl %al,%eax
  8017b6:	83 e8 37             	sub    $0x37,%eax
  8017b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8017bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017bf:	3b 45 10             	cmp    0x10(%ebp),%eax
  8017c2:	7d 19                	jge    8017dd <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8017c4:	ff 45 08             	incl   0x8(%ebp)
  8017c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ca:	0f af 45 10          	imul   0x10(%ebp),%eax
  8017ce:	89 c2                	mov    %eax,%edx
  8017d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017d3:	01 d0                	add    %edx,%eax
  8017d5:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017d8:	e9 7b ff ff ff       	jmp    801758 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017dd:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017de:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017e2:	74 08                	je     8017ec <strtol+0x134>
		*endptr = (char *) s;
  8017e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8017ea:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017ec:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017f0:	74 07                	je     8017f9 <strtol+0x141>
  8017f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017f5:	f7 d8                	neg    %eax
  8017f7:	eb 03                	jmp    8017fc <strtol+0x144>
  8017f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017fc:	c9                   	leave  
  8017fd:	c3                   	ret    

008017fe <ltostr>:

void
ltostr(long value, char *str)
{
  8017fe:	55                   	push   %ebp
  8017ff:	89 e5                	mov    %esp,%ebp
  801801:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801804:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80180b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801812:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801816:	79 13                	jns    80182b <ltostr+0x2d>
	{
		neg = 1;
  801818:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80181f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801822:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801825:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801828:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80182b:	8b 45 08             	mov    0x8(%ebp),%eax
  80182e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801833:	99                   	cltd   
  801834:	f7 f9                	idiv   %ecx
  801836:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801839:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80183c:	8d 50 01             	lea    0x1(%eax),%edx
  80183f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801842:	89 c2                	mov    %eax,%edx
  801844:	8b 45 0c             	mov    0xc(%ebp),%eax
  801847:	01 d0                	add    %edx,%eax
  801849:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80184c:	83 c2 30             	add    $0x30,%edx
  80184f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801851:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801854:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801859:	f7 e9                	imul   %ecx
  80185b:	c1 fa 02             	sar    $0x2,%edx
  80185e:	89 c8                	mov    %ecx,%eax
  801860:	c1 f8 1f             	sar    $0x1f,%eax
  801863:	29 c2                	sub    %eax,%edx
  801865:	89 d0                	mov    %edx,%eax
  801867:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80186a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80186d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801872:	f7 e9                	imul   %ecx
  801874:	c1 fa 02             	sar    $0x2,%edx
  801877:	89 c8                	mov    %ecx,%eax
  801879:	c1 f8 1f             	sar    $0x1f,%eax
  80187c:	29 c2                	sub    %eax,%edx
  80187e:	89 d0                	mov    %edx,%eax
  801880:	c1 e0 02             	shl    $0x2,%eax
  801883:	01 d0                	add    %edx,%eax
  801885:	01 c0                	add    %eax,%eax
  801887:	29 c1                	sub    %eax,%ecx
  801889:	89 ca                	mov    %ecx,%edx
  80188b:	85 d2                	test   %edx,%edx
  80188d:	75 9c                	jne    80182b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80188f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801896:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801899:	48                   	dec    %eax
  80189a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80189d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018a1:	74 3d                	je     8018e0 <ltostr+0xe2>
		start = 1 ;
  8018a3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8018aa:	eb 34                	jmp    8018e0 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8018ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b2:	01 d0                	add    %edx,%eax
  8018b4:	8a 00                	mov    (%eax),%al
  8018b6:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8018b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018bf:	01 c2                	add    %eax,%edx
  8018c1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8018c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018c7:	01 c8                	add    %ecx,%eax
  8018c9:	8a 00                	mov    (%eax),%al
  8018cb:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8018cd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d3:	01 c2                	add    %eax,%edx
  8018d5:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018d8:	88 02                	mov    %al,(%edx)
		start++ ;
  8018da:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018dd:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018e3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018e6:	7c c4                	jl     8018ac <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018e8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ee:	01 d0                	add    %edx,%eax
  8018f0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018f3:	90                   	nop
  8018f4:	c9                   	leave  
  8018f5:	c3                   	ret    

008018f6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018f6:	55                   	push   %ebp
  8018f7:	89 e5                	mov    %esp,%ebp
  8018f9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018fc:	ff 75 08             	pushl  0x8(%ebp)
  8018ff:	e8 54 fa ff ff       	call   801358 <strlen>
  801904:	83 c4 04             	add    $0x4,%esp
  801907:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80190a:	ff 75 0c             	pushl  0xc(%ebp)
  80190d:	e8 46 fa ff ff       	call   801358 <strlen>
  801912:	83 c4 04             	add    $0x4,%esp
  801915:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801918:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80191f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801926:	eb 17                	jmp    80193f <strcconcat+0x49>
		final[s] = str1[s] ;
  801928:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80192b:	8b 45 10             	mov    0x10(%ebp),%eax
  80192e:	01 c2                	add    %eax,%edx
  801930:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801933:	8b 45 08             	mov    0x8(%ebp),%eax
  801936:	01 c8                	add    %ecx,%eax
  801938:	8a 00                	mov    (%eax),%al
  80193a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80193c:	ff 45 fc             	incl   -0x4(%ebp)
  80193f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801942:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801945:	7c e1                	jl     801928 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801947:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80194e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801955:	eb 1f                	jmp    801976 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801957:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80195a:	8d 50 01             	lea    0x1(%eax),%edx
  80195d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801960:	89 c2                	mov    %eax,%edx
  801962:	8b 45 10             	mov    0x10(%ebp),%eax
  801965:	01 c2                	add    %eax,%edx
  801967:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80196a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80196d:	01 c8                	add    %ecx,%eax
  80196f:	8a 00                	mov    (%eax),%al
  801971:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801973:	ff 45 f8             	incl   -0x8(%ebp)
  801976:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801979:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80197c:	7c d9                	jl     801957 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80197e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801981:	8b 45 10             	mov    0x10(%ebp),%eax
  801984:	01 d0                	add    %edx,%eax
  801986:	c6 00 00             	movb   $0x0,(%eax)
}
  801989:	90                   	nop
  80198a:	c9                   	leave  
  80198b:	c3                   	ret    

0080198c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80198f:	8b 45 14             	mov    0x14(%ebp),%eax
  801992:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801998:	8b 45 14             	mov    0x14(%ebp),%eax
  80199b:	8b 00                	mov    (%eax),%eax
  80199d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a7:	01 d0                	add    %edx,%eax
  8019a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8019af:	eb 0c                	jmp    8019bd <strsplit+0x31>
			*string++ = 0;
  8019b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b4:	8d 50 01             	lea    0x1(%eax),%edx
  8019b7:	89 55 08             	mov    %edx,0x8(%ebp)
  8019ba:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8019bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c0:	8a 00                	mov    (%eax),%al
  8019c2:	84 c0                	test   %al,%al
  8019c4:	74 18                	je     8019de <strsplit+0x52>
  8019c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c9:	8a 00                	mov    (%eax),%al
  8019cb:	0f be c0             	movsbl %al,%eax
  8019ce:	50                   	push   %eax
  8019cf:	ff 75 0c             	pushl  0xc(%ebp)
  8019d2:	e8 13 fb ff ff       	call   8014ea <strchr>
  8019d7:	83 c4 08             	add    $0x8,%esp
  8019da:	85 c0                	test   %eax,%eax
  8019dc:	75 d3                	jne    8019b1 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8019de:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e1:	8a 00                	mov    (%eax),%al
  8019e3:	84 c0                	test   %al,%al
  8019e5:	74 5a                	je     801a41 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8019e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8019ea:	8b 00                	mov    (%eax),%eax
  8019ec:	83 f8 0f             	cmp    $0xf,%eax
  8019ef:	75 07                	jne    8019f8 <strsplit+0x6c>
		{
			return 0;
  8019f1:	b8 00 00 00 00       	mov    $0x0,%eax
  8019f6:	eb 66                	jmp    801a5e <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8019fb:	8b 00                	mov    (%eax),%eax
  8019fd:	8d 48 01             	lea    0x1(%eax),%ecx
  801a00:	8b 55 14             	mov    0x14(%ebp),%edx
  801a03:	89 0a                	mov    %ecx,(%edx)
  801a05:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a0c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a0f:	01 c2                	add    %eax,%edx
  801a11:	8b 45 08             	mov    0x8(%ebp),%eax
  801a14:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a16:	eb 03                	jmp    801a1b <strsplit+0x8f>
			string++;
  801a18:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1e:	8a 00                	mov    (%eax),%al
  801a20:	84 c0                	test   %al,%al
  801a22:	74 8b                	je     8019af <strsplit+0x23>
  801a24:	8b 45 08             	mov    0x8(%ebp),%eax
  801a27:	8a 00                	mov    (%eax),%al
  801a29:	0f be c0             	movsbl %al,%eax
  801a2c:	50                   	push   %eax
  801a2d:	ff 75 0c             	pushl  0xc(%ebp)
  801a30:	e8 b5 fa ff ff       	call   8014ea <strchr>
  801a35:	83 c4 08             	add    $0x8,%esp
  801a38:	85 c0                	test   %eax,%eax
  801a3a:	74 dc                	je     801a18 <strsplit+0x8c>
			string++;
	}
  801a3c:	e9 6e ff ff ff       	jmp    8019af <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a41:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a42:	8b 45 14             	mov    0x14(%ebp),%eax
  801a45:	8b 00                	mov    (%eax),%eax
  801a47:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a4e:	8b 45 10             	mov    0x10(%ebp),%eax
  801a51:	01 d0                	add    %edx,%eax
  801a53:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a59:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a5e:	c9                   	leave  
  801a5f:	c3                   	ret    

00801a60 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a60:	55                   	push   %ebp
  801a61:	89 e5                	mov    %esp,%ebp
  801a63:	83 ec 18             	sub    $0x18,%esp
  801a66:	8b 45 10             	mov    0x10(%ebp),%eax
  801a69:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801a6c:	83 ec 04             	sub    $0x4,%esp
  801a6f:	68 e4 2c 80 00       	push   $0x802ce4
  801a74:	6a 17                	push   $0x17
  801a76:	68 03 2d 80 00       	push   $0x802d03
  801a7b:	e8 9c ed ff ff       	call   80081c <_panic>

00801a80 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a80:	55                   	push   %ebp
  801a81:	89 e5                	mov    %esp,%ebp
  801a83:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801a86:	83 ec 04             	sub    $0x4,%esp
  801a89:	68 0f 2d 80 00       	push   $0x802d0f
  801a8e:	6a 2f                	push   $0x2f
  801a90:	68 03 2d 80 00       	push   $0x802d03
  801a95:	e8 82 ed ff ff       	call   80081c <_panic>

00801a9a <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801a9a:	55                   	push   %ebp
  801a9b:	89 e5                	mov    %esp,%ebp
  801a9d:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801aa0:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801aa7:	8b 55 08             	mov    0x8(%ebp),%edx
  801aaa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801aad:	01 d0                	add    %edx,%eax
  801aaf:	48                   	dec    %eax
  801ab0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801ab3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ab6:	ba 00 00 00 00       	mov    $0x0,%edx
  801abb:	f7 75 ec             	divl   -0x14(%ebp)
  801abe:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ac1:	29 d0                	sub    %edx,%eax
  801ac3:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac9:	c1 e8 0c             	shr    $0xc,%eax
  801acc:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801acf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801ad6:	e9 c8 00 00 00       	jmp    801ba3 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801adb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ae2:	eb 27                	jmp    801b0b <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801ae4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801ae7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801aea:	01 c2                	add    %eax,%edx
  801aec:	89 d0                	mov    %edx,%eax
  801aee:	01 c0                	add    %eax,%eax
  801af0:	01 d0                	add    %edx,%eax
  801af2:	c1 e0 02             	shl    $0x2,%eax
  801af5:	05 48 30 80 00       	add    $0x803048,%eax
  801afa:	8b 00                	mov    (%eax),%eax
  801afc:	85 c0                	test   %eax,%eax
  801afe:	74 08                	je     801b08 <malloc+0x6e>
            	i += j;
  801b00:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b03:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801b06:	eb 0b                	jmp    801b13 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801b08:	ff 45 f0             	incl   -0x10(%ebp)
  801b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b0e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b11:	72 d1                	jb     801ae4 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801b13:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b16:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b19:	0f 85 81 00 00 00    	jne    801ba0 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b22:	05 00 00 08 00       	add    $0x80000,%eax
  801b27:	c1 e0 0c             	shl    $0xc,%eax
  801b2a:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801b2d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801b34:	eb 1f                	jmp    801b55 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801b36:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b3c:	01 c2                	add    %eax,%edx
  801b3e:	89 d0                	mov    %edx,%eax
  801b40:	01 c0                	add    %eax,%eax
  801b42:	01 d0                	add    %edx,%eax
  801b44:	c1 e0 02             	shl    $0x2,%eax
  801b47:	05 48 30 80 00       	add    $0x803048,%eax
  801b4c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801b52:	ff 45 f0             	incl   -0x10(%ebp)
  801b55:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b58:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b5b:	72 d9                	jb     801b36 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801b5d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b60:	89 d0                	mov    %edx,%eax
  801b62:	01 c0                	add    %eax,%eax
  801b64:	01 d0                	add    %edx,%eax
  801b66:	c1 e0 02             	shl    $0x2,%eax
  801b69:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801b6f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b72:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801b74:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801b77:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801b7a:	89 c8                	mov    %ecx,%eax
  801b7c:	01 c0                	add    %eax,%eax
  801b7e:	01 c8                	add    %ecx,%eax
  801b80:	c1 e0 02             	shl    $0x2,%eax
  801b83:	05 44 30 80 00       	add    $0x803044,%eax
  801b88:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801b8a:	83 ec 08             	sub    $0x8,%esp
  801b8d:	ff 75 08             	pushl  0x8(%ebp)
  801b90:	ff 75 e0             	pushl  -0x20(%ebp)
  801b93:	e8 2b 03 00 00       	call   801ec3 <sys_allocateMem>
  801b98:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801b9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b9e:	eb 19                	jmp    801bb9 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801ba0:	ff 45 f4             	incl   -0xc(%ebp)
  801ba3:	a1 04 30 80 00       	mov    0x803004,%eax
  801ba8:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801bab:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801bae:	0f 83 27 ff ff ff    	jae    801adb <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801bb4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bb9:	c9                   	leave  
  801bba:	c3                   	ret    

00801bbb <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801bbb:	55                   	push   %ebp
  801bbc:	89 e5                	mov    %esp,%ebp
  801bbe:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801bc1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801bc5:	0f 84 e5 00 00 00    	je     801cb0 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801bd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bd4:	05 00 00 00 80       	add    $0x80000000,%eax
  801bd9:	c1 e8 0c             	shr    $0xc,%eax
  801bdc:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801bdf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801be2:	89 d0                	mov    %edx,%eax
  801be4:	01 c0                	add    %eax,%eax
  801be6:	01 d0                	add    %edx,%eax
  801be8:	c1 e0 02             	shl    $0x2,%eax
  801beb:	05 40 30 80 00       	add    $0x803040,%eax
  801bf0:	8b 00                	mov    (%eax),%eax
  801bf2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bf5:	0f 85 b8 00 00 00    	jne    801cb3 <free+0xf8>
  801bfb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801bfe:	89 d0                	mov    %edx,%eax
  801c00:	01 c0                	add    %eax,%eax
  801c02:	01 d0                	add    %edx,%eax
  801c04:	c1 e0 02             	shl    $0x2,%eax
  801c07:	05 48 30 80 00       	add    $0x803048,%eax
  801c0c:	8b 00                	mov    (%eax),%eax
  801c0e:	85 c0                	test   %eax,%eax
  801c10:	0f 84 9d 00 00 00    	je     801cb3 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801c16:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c19:	89 d0                	mov    %edx,%eax
  801c1b:	01 c0                	add    %eax,%eax
  801c1d:	01 d0                	add    %edx,%eax
  801c1f:	c1 e0 02             	shl    $0x2,%eax
  801c22:	05 44 30 80 00       	add    $0x803044,%eax
  801c27:	8b 00                	mov    (%eax),%eax
  801c29:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801c2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c2f:	c1 e0 0c             	shl    $0xc,%eax
  801c32:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801c35:	83 ec 08             	sub    $0x8,%esp
  801c38:	ff 75 e4             	pushl  -0x1c(%ebp)
  801c3b:	ff 75 f0             	pushl  -0x10(%ebp)
  801c3e:	e8 64 02 00 00       	call   801ea7 <sys_freeMem>
  801c43:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801c46:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801c4d:	eb 57                	jmp    801ca6 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801c4f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c52:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c55:	01 c2                	add    %eax,%edx
  801c57:	89 d0                	mov    %edx,%eax
  801c59:	01 c0                	add    %eax,%eax
  801c5b:	01 d0                	add    %edx,%eax
  801c5d:	c1 e0 02             	shl    $0x2,%eax
  801c60:	05 48 30 80 00       	add    $0x803048,%eax
  801c65:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801c6b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c71:	01 c2                	add    %eax,%edx
  801c73:	89 d0                	mov    %edx,%eax
  801c75:	01 c0                	add    %eax,%eax
  801c77:	01 d0                	add    %edx,%eax
  801c79:	c1 e0 02             	shl    $0x2,%eax
  801c7c:	05 40 30 80 00       	add    $0x803040,%eax
  801c81:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801c87:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c8d:	01 c2                	add    %eax,%edx
  801c8f:	89 d0                	mov    %edx,%eax
  801c91:	01 c0                	add    %eax,%eax
  801c93:	01 d0                	add    %edx,%eax
  801c95:	c1 e0 02             	shl    $0x2,%eax
  801c98:	05 44 30 80 00       	add    $0x803044,%eax
  801c9d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801ca3:	ff 45 f4             	incl   -0xc(%ebp)
  801ca6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ca9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801cac:	7c a1                	jl     801c4f <free+0x94>
  801cae:	eb 04                	jmp    801cb4 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801cb0:	90                   	nop
  801cb1:	eb 01                	jmp    801cb4 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801cb3:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801cb4:	c9                   	leave  
  801cb5:	c3                   	ret    

00801cb6 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801cb6:	55                   	push   %ebp
  801cb7:	89 e5                	mov    %esp,%ebp
  801cb9:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801cbc:	83 ec 04             	sub    $0x4,%esp
  801cbf:	68 2c 2d 80 00       	push   $0x802d2c
  801cc4:	68 ae 00 00 00       	push   $0xae
  801cc9:	68 03 2d 80 00       	push   $0x802d03
  801cce:	e8 49 eb ff ff       	call   80081c <_panic>

00801cd3 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801cd3:	55                   	push   %ebp
  801cd4:	89 e5                	mov    %esp,%ebp
  801cd6:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801cd9:	83 ec 04             	sub    $0x4,%esp
  801cdc:	68 4c 2d 80 00       	push   $0x802d4c
  801ce1:	68 ca 00 00 00       	push   $0xca
  801ce6:	68 03 2d 80 00       	push   $0x802d03
  801ceb:	e8 2c eb ff ff       	call   80081c <_panic>

00801cf0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801cf0:	55                   	push   %ebp
  801cf1:	89 e5                	mov    %esp,%ebp
  801cf3:	57                   	push   %edi
  801cf4:	56                   	push   %esi
  801cf5:	53                   	push   %ebx
  801cf6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cff:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d02:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d05:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d08:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d0b:	cd 30                	int    $0x30
  801d0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d10:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d13:	83 c4 10             	add    $0x10,%esp
  801d16:	5b                   	pop    %ebx
  801d17:	5e                   	pop    %esi
  801d18:	5f                   	pop    %edi
  801d19:	5d                   	pop    %ebp
  801d1a:	c3                   	ret    

00801d1b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d1b:	55                   	push   %ebp
  801d1c:	89 e5                	mov    %esp,%ebp
  801d1e:	83 ec 04             	sub    $0x4,%esp
  801d21:	8b 45 10             	mov    0x10(%ebp),%eax
  801d24:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d27:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	52                   	push   %edx
  801d33:	ff 75 0c             	pushl  0xc(%ebp)
  801d36:	50                   	push   %eax
  801d37:	6a 00                	push   $0x0
  801d39:	e8 b2 ff ff ff       	call   801cf0 <syscall>
  801d3e:	83 c4 18             	add    $0x18,%esp
}
  801d41:	90                   	nop
  801d42:	c9                   	leave  
  801d43:	c3                   	ret    

00801d44 <sys_cgetc>:

int
sys_cgetc(void)
{
  801d44:	55                   	push   %ebp
  801d45:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d47:	6a 00                	push   $0x0
  801d49:	6a 00                	push   $0x0
  801d4b:	6a 00                	push   $0x0
  801d4d:	6a 00                	push   $0x0
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 01                	push   $0x1
  801d53:	e8 98 ff ff ff       	call   801cf0 <syscall>
  801d58:	83 c4 18             	add    $0x18,%esp
}
  801d5b:	c9                   	leave  
  801d5c:	c3                   	ret    

00801d5d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801d5d:	55                   	push   %ebp
  801d5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801d60:	8b 45 08             	mov    0x8(%ebp),%eax
  801d63:	6a 00                	push   $0x0
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	6a 00                	push   $0x0
  801d6b:	50                   	push   %eax
  801d6c:	6a 05                	push   $0x5
  801d6e:	e8 7d ff ff ff       	call   801cf0 <syscall>
  801d73:	83 c4 18             	add    $0x18,%esp
}
  801d76:	c9                   	leave  
  801d77:	c3                   	ret    

00801d78 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801d78:	55                   	push   %ebp
  801d79:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 02                	push   $0x2
  801d87:	e8 64 ff ff ff       	call   801cf0 <syscall>
  801d8c:	83 c4 18             	add    $0x18,%esp
}
  801d8f:	c9                   	leave  
  801d90:	c3                   	ret    

00801d91 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d91:	55                   	push   %ebp
  801d92:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 03                	push   $0x3
  801da0:	e8 4b ff ff ff       	call   801cf0 <syscall>
  801da5:	83 c4 18             	add    $0x18,%esp
}
  801da8:	c9                   	leave  
  801da9:	c3                   	ret    

00801daa <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801daa:	55                   	push   %ebp
  801dab:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 04                	push   $0x4
  801db9:	e8 32 ff ff ff       	call   801cf0 <syscall>
  801dbe:	83 c4 18             	add    $0x18,%esp
}
  801dc1:	c9                   	leave  
  801dc2:	c3                   	ret    

00801dc3 <sys_env_exit>:


void sys_env_exit(void)
{
  801dc3:	55                   	push   %ebp
  801dc4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 06                	push   $0x6
  801dd2:	e8 19 ff ff ff       	call   801cf0 <syscall>
  801dd7:	83 c4 18             	add    $0x18,%esp
}
  801dda:	90                   	nop
  801ddb:	c9                   	leave  
  801ddc:	c3                   	ret    

00801ddd <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801ddd:	55                   	push   %ebp
  801dde:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801de0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801de3:	8b 45 08             	mov    0x8(%ebp),%eax
  801de6:	6a 00                	push   $0x0
  801de8:	6a 00                	push   $0x0
  801dea:	6a 00                	push   $0x0
  801dec:	52                   	push   %edx
  801ded:	50                   	push   %eax
  801dee:	6a 07                	push   $0x7
  801df0:	e8 fb fe ff ff       	call   801cf0 <syscall>
  801df5:	83 c4 18             	add    $0x18,%esp
}
  801df8:	c9                   	leave  
  801df9:	c3                   	ret    

00801dfa <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801dfa:	55                   	push   %ebp
  801dfb:	89 e5                	mov    %esp,%ebp
  801dfd:	56                   	push   %esi
  801dfe:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801dff:	8b 75 18             	mov    0x18(%ebp),%esi
  801e02:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e05:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e08:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0e:	56                   	push   %esi
  801e0f:	53                   	push   %ebx
  801e10:	51                   	push   %ecx
  801e11:	52                   	push   %edx
  801e12:	50                   	push   %eax
  801e13:	6a 08                	push   $0x8
  801e15:	e8 d6 fe ff ff       	call   801cf0 <syscall>
  801e1a:	83 c4 18             	add    $0x18,%esp
}
  801e1d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e20:	5b                   	pop    %ebx
  801e21:	5e                   	pop    %esi
  801e22:	5d                   	pop    %ebp
  801e23:	c3                   	ret    

00801e24 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e24:	55                   	push   %ebp
  801e25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e27:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	52                   	push   %edx
  801e34:	50                   	push   %eax
  801e35:	6a 09                	push   $0x9
  801e37:	e8 b4 fe ff ff       	call   801cf0 <syscall>
  801e3c:	83 c4 18             	add    $0x18,%esp
}
  801e3f:	c9                   	leave  
  801e40:	c3                   	ret    

00801e41 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e41:	55                   	push   %ebp
  801e42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e44:	6a 00                	push   $0x0
  801e46:	6a 00                	push   $0x0
  801e48:	6a 00                	push   $0x0
  801e4a:	ff 75 0c             	pushl  0xc(%ebp)
  801e4d:	ff 75 08             	pushl  0x8(%ebp)
  801e50:	6a 0a                	push   $0xa
  801e52:	e8 99 fe ff ff       	call   801cf0 <syscall>
  801e57:	83 c4 18             	add    $0x18,%esp
}
  801e5a:	c9                   	leave  
  801e5b:	c3                   	ret    

00801e5c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e5c:	55                   	push   %ebp
  801e5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 0b                	push   $0xb
  801e6b:	e8 80 fe ff ff       	call   801cf0 <syscall>
  801e70:	83 c4 18             	add    $0x18,%esp
}
  801e73:	c9                   	leave  
  801e74:	c3                   	ret    

00801e75 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e75:	55                   	push   %ebp
  801e76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	6a 0c                	push   $0xc
  801e84:	e8 67 fe ff ff       	call   801cf0 <syscall>
  801e89:	83 c4 18             	add    $0x18,%esp
}
  801e8c:	c9                   	leave  
  801e8d:	c3                   	ret    

00801e8e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e8e:	55                   	push   %ebp
  801e8f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e91:	6a 00                	push   $0x0
  801e93:	6a 00                	push   $0x0
  801e95:	6a 00                	push   $0x0
  801e97:	6a 00                	push   $0x0
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 0d                	push   $0xd
  801e9d:	e8 4e fe ff ff       	call   801cf0 <syscall>
  801ea2:	83 c4 18             	add    $0x18,%esp
}
  801ea5:	c9                   	leave  
  801ea6:	c3                   	ret    

00801ea7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ea7:	55                   	push   %ebp
  801ea8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801eaa:	6a 00                	push   $0x0
  801eac:	6a 00                	push   $0x0
  801eae:	6a 00                	push   $0x0
  801eb0:	ff 75 0c             	pushl  0xc(%ebp)
  801eb3:	ff 75 08             	pushl  0x8(%ebp)
  801eb6:	6a 11                	push   $0x11
  801eb8:	e8 33 fe ff ff       	call   801cf0 <syscall>
  801ebd:	83 c4 18             	add    $0x18,%esp
	return;
  801ec0:	90                   	nop
}
  801ec1:	c9                   	leave  
  801ec2:	c3                   	ret    

00801ec3 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801ec3:	55                   	push   %ebp
  801ec4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	ff 75 0c             	pushl  0xc(%ebp)
  801ecf:	ff 75 08             	pushl  0x8(%ebp)
  801ed2:	6a 12                	push   $0x12
  801ed4:	e8 17 fe ff ff       	call   801cf0 <syscall>
  801ed9:	83 c4 18             	add    $0x18,%esp
	return ;
  801edc:	90                   	nop
}
  801edd:	c9                   	leave  
  801ede:	c3                   	ret    

00801edf <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801edf:	55                   	push   %ebp
  801ee0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 00                	push   $0x0
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 00                	push   $0x0
  801eec:	6a 0e                	push   $0xe
  801eee:	e8 fd fd ff ff       	call   801cf0 <syscall>
  801ef3:	83 c4 18             	add    $0x18,%esp
}
  801ef6:	c9                   	leave  
  801ef7:	c3                   	ret    

00801ef8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ef8:	55                   	push   %ebp
  801ef9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	6a 00                	push   $0x0
  801f03:	ff 75 08             	pushl  0x8(%ebp)
  801f06:	6a 0f                	push   $0xf
  801f08:	e8 e3 fd ff ff       	call   801cf0 <syscall>
  801f0d:	83 c4 18             	add    $0x18,%esp
}
  801f10:	c9                   	leave  
  801f11:	c3                   	ret    

00801f12 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f12:	55                   	push   %ebp
  801f13:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f15:	6a 00                	push   $0x0
  801f17:	6a 00                	push   $0x0
  801f19:	6a 00                	push   $0x0
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 10                	push   $0x10
  801f21:	e8 ca fd ff ff       	call   801cf0 <syscall>
  801f26:	83 c4 18             	add    $0x18,%esp
}
  801f29:	90                   	nop
  801f2a:	c9                   	leave  
  801f2b:	c3                   	ret    

00801f2c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f2c:	55                   	push   %ebp
  801f2d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	6a 14                	push   $0x14
  801f3b:	e8 b0 fd ff ff       	call   801cf0 <syscall>
  801f40:	83 c4 18             	add    $0x18,%esp
}
  801f43:	90                   	nop
  801f44:	c9                   	leave  
  801f45:	c3                   	ret    

00801f46 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801f46:	55                   	push   %ebp
  801f47:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	6a 15                	push   $0x15
  801f55:	e8 96 fd ff ff       	call   801cf0 <syscall>
  801f5a:	83 c4 18             	add    $0x18,%esp
}
  801f5d:	90                   	nop
  801f5e:	c9                   	leave  
  801f5f:	c3                   	ret    

00801f60 <sys_cputc>:


void
sys_cputc(const char c)
{
  801f60:	55                   	push   %ebp
  801f61:	89 e5                	mov    %esp,%ebp
  801f63:	83 ec 04             	sub    $0x4,%esp
  801f66:	8b 45 08             	mov    0x8(%ebp),%eax
  801f69:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f6c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	50                   	push   %eax
  801f79:	6a 16                	push   $0x16
  801f7b:	e8 70 fd ff ff       	call   801cf0 <syscall>
  801f80:	83 c4 18             	add    $0x18,%esp
}
  801f83:	90                   	nop
  801f84:	c9                   	leave  
  801f85:	c3                   	ret    

00801f86 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f86:	55                   	push   %ebp
  801f87:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 00                	push   $0x0
  801f91:	6a 00                	push   $0x0
  801f93:	6a 17                	push   $0x17
  801f95:	e8 56 fd ff ff       	call   801cf0 <syscall>
  801f9a:	83 c4 18             	add    $0x18,%esp
}
  801f9d:	90                   	nop
  801f9e:	c9                   	leave  
  801f9f:	c3                   	ret    

00801fa0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801fa0:	55                   	push   %ebp
  801fa1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	ff 75 0c             	pushl  0xc(%ebp)
  801faf:	50                   	push   %eax
  801fb0:	6a 18                	push   $0x18
  801fb2:	e8 39 fd ff ff       	call   801cf0 <syscall>
  801fb7:	83 c4 18             	add    $0x18,%esp
}
  801fba:	c9                   	leave  
  801fbb:	c3                   	ret    

00801fbc <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801fbc:	55                   	push   %ebp
  801fbd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fbf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	52                   	push   %edx
  801fcc:	50                   	push   %eax
  801fcd:	6a 1b                	push   $0x1b
  801fcf:	e8 1c fd ff ff       	call   801cf0 <syscall>
  801fd4:	83 c4 18             	add    $0x18,%esp
}
  801fd7:	c9                   	leave  
  801fd8:	c3                   	ret    

00801fd9 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801fd9:	55                   	push   %ebp
  801fda:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fdc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fdf:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	52                   	push   %edx
  801fe9:	50                   	push   %eax
  801fea:	6a 19                	push   $0x19
  801fec:	e8 ff fc ff ff       	call   801cf0 <syscall>
  801ff1:	83 c4 18             	add    $0x18,%esp
}
  801ff4:	90                   	nop
  801ff5:	c9                   	leave  
  801ff6:	c3                   	ret    

00801ff7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ff7:	55                   	push   %ebp
  801ff8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ffa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	52                   	push   %edx
  802007:	50                   	push   %eax
  802008:	6a 1a                	push   $0x1a
  80200a:	e8 e1 fc ff ff       	call   801cf0 <syscall>
  80200f:	83 c4 18             	add    $0x18,%esp
}
  802012:	90                   	nop
  802013:	c9                   	leave  
  802014:	c3                   	ret    

00802015 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802015:	55                   	push   %ebp
  802016:	89 e5                	mov    %esp,%ebp
  802018:	83 ec 04             	sub    $0x4,%esp
  80201b:	8b 45 10             	mov    0x10(%ebp),%eax
  80201e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802021:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802024:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802028:	8b 45 08             	mov    0x8(%ebp),%eax
  80202b:	6a 00                	push   $0x0
  80202d:	51                   	push   %ecx
  80202e:	52                   	push   %edx
  80202f:	ff 75 0c             	pushl  0xc(%ebp)
  802032:	50                   	push   %eax
  802033:	6a 1c                	push   $0x1c
  802035:	e8 b6 fc ff ff       	call   801cf0 <syscall>
  80203a:	83 c4 18             	add    $0x18,%esp
}
  80203d:	c9                   	leave  
  80203e:	c3                   	ret    

0080203f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80203f:	55                   	push   %ebp
  802040:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802042:	8b 55 0c             	mov    0xc(%ebp),%edx
  802045:	8b 45 08             	mov    0x8(%ebp),%eax
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	52                   	push   %edx
  80204f:	50                   	push   %eax
  802050:	6a 1d                	push   $0x1d
  802052:	e8 99 fc ff ff       	call   801cf0 <syscall>
  802057:	83 c4 18             	add    $0x18,%esp
}
  80205a:	c9                   	leave  
  80205b:	c3                   	ret    

0080205c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80205c:	55                   	push   %ebp
  80205d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80205f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802062:	8b 55 0c             	mov    0xc(%ebp),%edx
  802065:	8b 45 08             	mov    0x8(%ebp),%eax
  802068:	6a 00                	push   $0x0
  80206a:	6a 00                	push   $0x0
  80206c:	51                   	push   %ecx
  80206d:	52                   	push   %edx
  80206e:	50                   	push   %eax
  80206f:	6a 1e                	push   $0x1e
  802071:	e8 7a fc ff ff       	call   801cf0 <syscall>
  802076:	83 c4 18             	add    $0x18,%esp
}
  802079:	c9                   	leave  
  80207a:	c3                   	ret    

0080207b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80207b:	55                   	push   %ebp
  80207c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80207e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802081:	8b 45 08             	mov    0x8(%ebp),%eax
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	52                   	push   %edx
  80208b:	50                   	push   %eax
  80208c:	6a 1f                	push   $0x1f
  80208e:	e8 5d fc ff ff       	call   801cf0 <syscall>
  802093:	83 c4 18             	add    $0x18,%esp
}
  802096:	c9                   	leave  
  802097:	c3                   	ret    

00802098 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802098:	55                   	push   %ebp
  802099:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80209b:	6a 00                	push   $0x0
  80209d:	6a 00                	push   $0x0
  80209f:	6a 00                	push   $0x0
  8020a1:	6a 00                	push   $0x0
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 20                	push   $0x20
  8020a7:	e8 44 fc ff ff       	call   801cf0 <syscall>
  8020ac:	83 c4 18             	add    $0x18,%esp
}
  8020af:	c9                   	leave  
  8020b0:	c3                   	ret    

008020b1 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8020b1:	55                   	push   %ebp
  8020b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8020b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	ff 75 10             	pushl  0x10(%ebp)
  8020be:	ff 75 0c             	pushl  0xc(%ebp)
  8020c1:	50                   	push   %eax
  8020c2:	6a 21                	push   $0x21
  8020c4:	e8 27 fc ff ff       	call   801cf0 <syscall>
  8020c9:	83 c4 18             	add    $0x18,%esp
}
  8020cc:	c9                   	leave  
  8020cd:	c3                   	ret    

008020ce <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8020ce:	55                   	push   %ebp
  8020cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8020d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8020d4:	6a 00                	push   $0x0
  8020d6:	6a 00                	push   $0x0
  8020d8:	6a 00                	push   $0x0
  8020da:	6a 00                	push   $0x0
  8020dc:	50                   	push   %eax
  8020dd:	6a 22                	push   $0x22
  8020df:	e8 0c fc ff ff       	call   801cf0 <syscall>
  8020e4:	83 c4 18             	add    $0x18,%esp
}
  8020e7:	90                   	nop
  8020e8:	c9                   	leave  
  8020e9:	c3                   	ret    

008020ea <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8020ea:	55                   	push   %ebp
  8020eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8020ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f0:	6a 00                	push   $0x0
  8020f2:	6a 00                	push   $0x0
  8020f4:	6a 00                	push   $0x0
  8020f6:	6a 00                	push   $0x0
  8020f8:	50                   	push   %eax
  8020f9:	6a 23                	push   $0x23
  8020fb:	e8 f0 fb ff ff       	call   801cf0 <syscall>
  802100:	83 c4 18             	add    $0x18,%esp
}
  802103:	90                   	nop
  802104:	c9                   	leave  
  802105:	c3                   	ret    

00802106 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802106:	55                   	push   %ebp
  802107:	89 e5                	mov    %esp,%ebp
  802109:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80210c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80210f:	8d 50 04             	lea    0x4(%eax),%edx
  802112:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802115:	6a 00                	push   $0x0
  802117:	6a 00                	push   $0x0
  802119:	6a 00                	push   $0x0
  80211b:	52                   	push   %edx
  80211c:	50                   	push   %eax
  80211d:	6a 24                	push   $0x24
  80211f:	e8 cc fb ff ff       	call   801cf0 <syscall>
  802124:	83 c4 18             	add    $0x18,%esp
	return result;
  802127:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80212a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80212d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802130:	89 01                	mov    %eax,(%ecx)
  802132:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802135:	8b 45 08             	mov    0x8(%ebp),%eax
  802138:	c9                   	leave  
  802139:	c2 04 00             	ret    $0x4

0080213c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80213c:	55                   	push   %ebp
  80213d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80213f:	6a 00                	push   $0x0
  802141:	6a 00                	push   $0x0
  802143:	ff 75 10             	pushl  0x10(%ebp)
  802146:	ff 75 0c             	pushl  0xc(%ebp)
  802149:	ff 75 08             	pushl  0x8(%ebp)
  80214c:	6a 13                	push   $0x13
  80214e:	e8 9d fb ff ff       	call   801cf0 <syscall>
  802153:	83 c4 18             	add    $0x18,%esp
	return ;
  802156:	90                   	nop
}
  802157:	c9                   	leave  
  802158:	c3                   	ret    

00802159 <sys_rcr2>:
uint32 sys_rcr2()
{
  802159:	55                   	push   %ebp
  80215a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80215c:	6a 00                	push   $0x0
  80215e:	6a 00                	push   $0x0
  802160:	6a 00                	push   $0x0
  802162:	6a 00                	push   $0x0
  802164:	6a 00                	push   $0x0
  802166:	6a 25                	push   $0x25
  802168:	e8 83 fb ff ff       	call   801cf0 <syscall>
  80216d:	83 c4 18             	add    $0x18,%esp
}
  802170:	c9                   	leave  
  802171:	c3                   	ret    

00802172 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802172:	55                   	push   %ebp
  802173:	89 e5                	mov    %esp,%ebp
  802175:	83 ec 04             	sub    $0x4,%esp
  802178:	8b 45 08             	mov    0x8(%ebp),%eax
  80217b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80217e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802182:	6a 00                	push   $0x0
  802184:	6a 00                	push   $0x0
  802186:	6a 00                	push   $0x0
  802188:	6a 00                	push   $0x0
  80218a:	50                   	push   %eax
  80218b:	6a 26                	push   $0x26
  80218d:	e8 5e fb ff ff       	call   801cf0 <syscall>
  802192:	83 c4 18             	add    $0x18,%esp
	return ;
  802195:	90                   	nop
}
  802196:	c9                   	leave  
  802197:	c3                   	ret    

00802198 <rsttst>:
void rsttst()
{
  802198:	55                   	push   %ebp
  802199:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	6a 00                	push   $0x0
  8021a3:	6a 00                	push   $0x0
  8021a5:	6a 28                	push   $0x28
  8021a7:	e8 44 fb ff ff       	call   801cf0 <syscall>
  8021ac:	83 c4 18             	add    $0x18,%esp
	return ;
  8021af:	90                   	nop
}
  8021b0:	c9                   	leave  
  8021b1:	c3                   	ret    

008021b2 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8021b2:	55                   	push   %ebp
  8021b3:	89 e5                	mov    %esp,%ebp
  8021b5:	83 ec 04             	sub    $0x4,%esp
  8021b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8021bb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8021be:	8b 55 18             	mov    0x18(%ebp),%edx
  8021c1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021c5:	52                   	push   %edx
  8021c6:	50                   	push   %eax
  8021c7:	ff 75 10             	pushl  0x10(%ebp)
  8021ca:	ff 75 0c             	pushl  0xc(%ebp)
  8021cd:	ff 75 08             	pushl  0x8(%ebp)
  8021d0:	6a 27                	push   $0x27
  8021d2:	e8 19 fb ff ff       	call   801cf0 <syscall>
  8021d7:	83 c4 18             	add    $0x18,%esp
	return ;
  8021da:	90                   	nop
}
  8021db:	c9                   	leave  
  8021dc:	c3                   	ret    

008021dd <chktst>:
void chktst(uint32 n)
{
  8021dd:	55                   	push   %ebp
  8021de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 00                	push   $0x0
  8021e4:	6a 00                	push   $0x0
  8021e6:	6a 00                	push   $0x0
  8021e8:	ff 75 08             	pushl  0x8(%ebp)
  8021eb:	6a 29                	push   $0x29
  8021ed:	e8 fe fa ff ff       	call   801cf0 <syscall>
  8021f2:	83 c4 18             	add    $0x18,%esp
	return ;
  8021f5:	90                   	nop
}
  8021f6:	c9                   	leave  
  8021f7:	c3                   	ret    

008021f8 <inctst>:

void inctst()
{
  8021f8:	55                   	push   %ebp
  8021f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8021fb:	6a 00                	push   $0x0
  8021fd:	6a 00                	push   $0x0
  8021ff:	6a 00                	push   $0x0
  802201:	6a 00                	push   $0x0
  802203:	6a 00                	push   $0x0
  802205:	6a 2a                	push   $0x2a
  802207:	e8 e4 fa ff ff       	call   801cf0 <syscall>
  80220c:	83 c4 18             	add    $0x18,%esp
	return ;
  80220f:	90                   	nop
}
  802210:	c9                   	leave  
  802211:	c3                   	ret    

00802212 <gettst>:
uint32 gettst()
{
  802212:	55                   	push   %ebp
  802213:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802215:	6a 00                	push   $0x0
  802217:	6a 00                	push   $0x0
  802219:	6a 00                	push   $0x0
  80221b:	6a 00                	push   $0x0
  80221d:	6a 00                	push   $0x0
  80221f:	6a 2b                	push   $0x2b
  802221:	e8 ca fa ff ff       	call   801cf0 <syscall>
  802226:	83 c4 18             	add    $0x18,%esp
}
  802229:	c9                   	leave  
  80222a:	c3                   	ret    

0080222b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80222b:	55                   	push   %ebp
  80222c:	89 e5                	mov    %esp,%ebp
  80222e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802231:	6a 00                	push   $0x0
  802233:	6a 00                	push   $0x0
  802235:	6a 00                	push   $0x0
  802237:	6a 00                	push   $0x0
  802239:	6a 00                	push   $0x0
  80223b:	6a 2c                	push   $0x2c
  80223d:	e8 ae fa ff ff       	call   801cf0 <syscall>
  802242:	83 c4 18             	add    $0x18,%esp
  802245:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802248:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80224c:	75 07                	jne    802255 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80224e:	b8 01 00 00 00       	mov    $0x1,%eax
  802253:	eb 05                	jmp    80225a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802255:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80225a:	c9                   	leave  
  80225b:	c3                   	ret    

0080225c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80225c:	55                   	push   %ebp
  80225d:	89 e5                	mov    %esp,%ebp
  80225f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802262:	6a 00                	push   $0x0
  802264:	6a 00                	push   $0x0
  802266:	6a 00                	push   $0x0
  802268:	6a 00                	push   $0x0
  80226a:	6a 00                	push   $0x0
  80226c:	6a 2c                	push   $0x2c
  80226e:	e8 7d fa ff ff       	call   801cf0 <syscall>
  802273:	83 c4 18             	add    $0x18,%esp
  802276:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802279:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80227d:	75 07                	jne    802286 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80227f:	b8 01 00 00 00       	mov    $0x1,%eax
  802284:	eb 05                	jmp    80228b <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802286:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80228b:	c9                   	leave  
  80228c:	c3                   	ret    

0080228d <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80228d:	55                   	push   %ebp
  80228e:	89 e5                	mov    %esp,%ebp
  802290:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802293:	6a 00                	push   $0x0
  802295:	6a 00                	push   $0x0
  802297:	6a 00                	push   $0x0
  802299:	6a 00                	push   $0x0
  80229b:	6a 00                	push   $0x0
  80229d:	6a 2c                	push   $0x2c
  80229f:	e8 4c fa ff ff       	call   801cf0 <syscall>
  8022a4:	83 c4 18             	add    $0x18,%esp
  8022a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8022aa:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8022ae:	75 07                	jne    8022b7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8022b0:	b8 01 00 00 00       	mov    $0x1,%eax
  8022b5:	eb 05                	jmp    8022bc <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8022b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022bc:	c9                   	leave  
  8022bd:	c3                   	ret    

008022be <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8022be:	55                   	push   %ebp
  8022bf:	89 e5                	mov    %esp,%ebp
  8022c1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022c4:	6a 00                	push   $0x0
  8022c6:	6a 00                	push   $0x0
  8022c8:	6a 00                	push   $0x0
  8022ca:	6a 00                	push   $0x0
  8022cc:	6a 00                	push   $0x0
  8022ce:	6a 2c                	push   $0x2c
  8022d0:	e8 1b fa ff ff       	call   801cf0 <syscall>
  8022d5:	83 c4 18             	add    $0x18,%esp
  8022d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8022db:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8022df:	75 07                	jne    8022e8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8022e1:	b8 01 00 00 00       	mov    $0x1,%eax
  8022e6:	eb 05                	jmp    8022ed <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8022e8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022ed:	c9                   	leave  
  8022ee:	c3                   	ret    

008022ef <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8022ef:	55                   	push   %ebp
  8022f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8022f2:	6a 00                	push   $0x0
  8022f4:	6a 00                	push   $0x0
  8022f6:	6a 00                	push   $0x0
  8022f8:	6a 00                	push   $0x0
  8022fa:	ff 75 08             	pushl  0x8(%ebp)
  8022fd:	6a 2d                	push   $0x2d
  8022ff:	e8 ec f9 ff ff       	call   801cf0 <syscall>
  802304:	83 c4 18             	add    $0x18,%esp
	return ;
  802307:	90                   	nop
}
  802308:	c9                   	leave  
  802309:	c3                   	ret    
  80230a:	66 90                	xchg   %ax,%ax

0080230c <__udivdi3>:
  80230c:	55                   	push   %ebp
  80230d:	57                   	push   %edi
  80230e:	56                   	push   %esi
  80230f:	53                   	push   %ebx
  802310:	83 ec 1c             	sub    $0x1c,%esp
  802313:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802317:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80231b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80231f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802323:	89 ca                	mov    %ecx,%edx
  802325:	89 f8                	mov    %edi,%eax
  802327:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80232b:	85 f6                	test   %esi,%esi
  80232d:	75 2d                	jne    80235c <__udivdi3+0x50>
  80232f:	39 cf                	cmp    %ecx,%edi
  802331:	77 65                	ja     802398 <__udivdi3+0x8c>
  802333:	89 fd                	mov    %edi,%ebp
  802335:	85 ff                	test   %edi,%edi
  802337:	75 0b                	jne    802344 <__udivdi3+0x38>
  802339:	b8 01 00 00 00       	mov    $0x1,%eax
  80233e:	31 d2                	xor    %edx,%edx
  802340:	f7 f7                	div    %edi
  802342:	89 c5                	mov    %eax,%ebp
  802344:	31 d2                	xor    %edx,%edx
  802346:	89 c8                	mov    %ecx,%eax
  802348:	f7 f5                	div    %ebp
  80234a:	89 c1                	mov    %eax,%ecx
  80234c:	89 d8                	mov    %ebx,%eax
  80234e:	f7 f5                	div    %ebp
  802350:	89 cf                	mov    %ecx,%edi
  802352:	89 fa                	mov    %edi,%edx
  802354:	83 c4 1c             	add    $0x1c,%esp
  802357:	5b                   	pop    %ebx
  802358:	5e                   	pop    %esi
  802359:	5f                   	pop    %edi
  80235a:	5d                   	pop    %ebp
  80235b:	c3                   	ret    
  80235c:	39 ce                	cmp    %ecx,%esi
  80235e:	77 28                	ja     802388 <__udivdi3+0x7c>
  802360:	0f bd fe             	bsr    %esi,%edi
  802363:	83 f7 1f             	xor    $0x1f,%edi
  802366:	75 40                	jne    8023a8 <__udivdi3+0x9c>
  802368:	39 ce                	cmp    %ecx,%esi
  80236a:	72 0a                	jb     802376 <__udivdi3+0x6a>
  80236c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802370:	0f 87 9e 00 00 00    	ja     802414 <__udivdi3+0x108>
  802376:	b8 01 00 00 00       	mov    $0x1,%eax
  80237b:	89 fa                	mov    %edi,%edx
  80237d:	83 c4 1c             	add    $0x1c,%esp
  802380:	5b                   	pop    %ebx
  802381:	5e                   	pop    %esi
  802382:	5f                   	pop    %edi
  802383:	5d                   	pop    %ebp
  802384:	c3                   	ret    
  802385:	8d 76 00             	lea    0x0(%esi),%esi
  802388:	31 ff                	xor    %edi,%edi
  80238a:	31 c0                	xor    %eax,%eax
  80238c:	89 fa                	mov    %edi,%edx
  80238e:	83 c4 1c             	add    $0x1c,%esp
  802391:	5b                   	pop    %ebx
  802392:	5e                   	pop    %esi
  802393:	5f                   	pop    %edi
  802394:	5d                   	pop    %ebp
  802395:	c3                   	ret    
  802396:	66 90                	xchg   %ax,%ax
  802398:	89 d8                	mov    %ebx,%eax
  80239a:	f7 f7                	div    %edi
  80239c:	31 ff                	xor    %edi,%edi
  80239e:	89 fa                	mov    %edi,%edx
  8023a0:	83 c4 1c             	add    $0x1c,%esp
  8023a3:	5b                   	pop    %ebx
  8023a4:	5e                   	pop    %esi
  8023a5:	5f                   	pop    %edi
  8023a6:	5d                   	pop    %ebp
  8023a7:	c3                   	ret    
  8023a8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8023ad:	89 eb                	mov    %ebp,%ebx
  8023af:	29 fb                	sub    %edi,%ebx
  8023b1:	89 f9                	mov    %edi,%ecx
  8023b3:	d3 e6                	shl    %cl,%esi
  8023b5:	89 c5                	mov    %eax,%ebp
  8023b7:	88 d9                	mov    %bl,%cl
  8023b9:	d3 ed                	shr    %cl,%ebp
  8023bb:	89 e9                	mov    %ebp,%ecx
  8023bd:	09 f1                	or     %esi,%ecx
  8023bf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8023c3:	89 f9                	mov    %edi,%ecx
  8023c5:	d3 e0                	shl    %cl,%eax
  8023c7:	89 c5                	mov    %eax,%ebp
  8023c9:	89 d6                	mov    %edx,%esi
  8023cb:	88 d9                	mov    %bl,%cl
  8023cd:	d3 ee                	shr    %cl,%esi
  8023cf:	89 f9                	mov    %edi,%ecx
  8023d1:	d3 e2                	shl    %cl,%edx
  8023d3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023d7:	88 d9                	mov    %bl,%cl
  8023d9:	d3 e8                	shr    %cl,%eax
  8023db:	09 c2                	or     %eax,%edx
  8023dd:	89 d0                	mov    %edx,%eax
  8023df:	89 f2                	mov    %esi,%edx
  8023e1:	f7 74 24 0c          	divl   0xc(%esp)
  8023e5:	89 d6                	mov    %edx,%esi
  8023e7:	89 c3                	mov    %eax,%ebx
  8023e9:	f7 e5                	mul    %ebp
  8023eb:	39 d6                	cmp    %edx,%esi
  8023ed:	72 19                	jb     802408 <__udivdi3+0xfc>
  8023ef:	74 0b                	je     8023fc <__udivdi3+0xf0>
  8023f1:	89 d8                	mov    %ebx,%eax
  8023f3:	31 ff                	xor    %edi,%edi
  8023f5:	e9 58 ff ff ff       	jmp    802352 <__udivdi3+0x46>
  8023fa:	66 90                	xchg   %ax,%ax
  8023fc:	8b 54 24 08          	mov    0x8(%esp),%edx
  802400:	89 f9                	mov    %edi,%ecx
  802402:	d3 e2                	shl    %cl,%edx
  802404:	39 c2                	cmp    %eax,%edx
  802406:	73 e9                	jae    8023f1 <__udivdi3+0xe5>
  802408:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80240b:	31 ff                	xor    %edi,%edi
  80240d:	e9 40 ff ff ff       	jmp    802352 <__udivdi3+0x46>
  802412:	66 90                	xchg   %ax,%ax
  802414:	31 c0                	xor    %eax,%eax
  802416:	e9 37 ff ff ff       	jmp    802352 <__udivdi3+0x46>
  80241b:	90                   	nop

0080241c <__umoddi3>:
  80241c:	55                   	push   %ebp
  80241d:	57                   	push   %edi
  80241e:	56                   	push   %esi
  80241f:	53                   	push   %ebx
  802420:	83 ec 1c             	sub    $0x1c,%esp
  802423:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802427:	8b 74 24 34          	mov    0x34(%esp),%esi
  80242b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80242f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802433:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802437:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80243b:	89 f3                	mov    %esi,%ebx
  80243d:	89 fa                	mov    %edi,%edx
  80243f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802443:	89 34 24             	mov    %esi,(%esp)
  802446:	85 c0                	test   %eax,%eax
  802448:	75 1a                	jne    802464 <__umoddi3+0x48>
  80244a:	39 f7                	cmp    %esi,%edi
  80244c:	0f 86 a2 00 00 00    	jbe    8024f4 <__umoddi3+0xd8>
  802452:	89 c8                	mov    %ecx,%eax
  802454:	89 f2                	mov    %esi,%edx
  802456:	f7 f7                	div    %edi
  802458:	89 d0                	mov    %edx,%eax
  80245a:	31 d2                	xor    %edx,%edx
  80245c:	83 c4 1c             	add    $0x1c,%esp
  80245f:	5b                   	pop    %ebx
  802460:	5e                   	pop    %esi
  802461:	5f                   	pop    %edi
  802462:	5d                   	pop    %ebp
  802463:	c3                   	ret    
  802464:	39 f0                	cmp    %esi,%eax
  802466:	0f 87 ac 00 00 00    	ja     802518 <__umoddi3+0xfc>
  80246c:	0f bd e8             	bsr    %eax,%ebp
  80246f:	83 f5 1f             	xor    $0x1f,%ebp
  802472:	0f 84 ac 00 00 00    	je     802524 <__umoddi3+0x108>
  802478:	bf 20 00 00 00       	mov    $0x20,%edi
  80247d:	29 ef                	sub    %ebp,%edi
  80247f:	89 fe                	mov    %edi,%esi
  802481:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802485:	89 e9                	mov    %ebp,%ecx
  802487:	d3 e0                	shl    %cl,%eax
  802489:	89 d7                	mov    %edx,%edi
  80248b:	89 f1                	mov    %esi,%ecx
  80248d:	d3 ef                	shr    %cl,%edi
  80248f:	09 c7                	or     %eax,%edi
  802491:	89 e9                	mov    %ebp,%ecx
  802493:	d3 e2                	shl    %cl,%edx
  802495:	89 14 24             	mov    %edx,(%esp)
  802498:	89 d8                	mov    %ebx,%eax
  80249a:	d3 e0                	shl    %cl,%eax
  80249c:	89 c2                	mov    %eax,%edx
  80249e:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024a2:	d3 e0                	shl    %cl,%eax
  8024a4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8024a8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024ac:	89 f1                	mov    %esi,%ecx
  8024ae:	d3 e8                	shr    %cl,%eax
  8024b0:	09 d0                	or     %edx,%eax
  8024b2:	d3 eb                	shr    %cl,%ebx
  8024b4:	89 da                	mov    %ebx,%edx
  8024b6:	f7 f7                	div    %edi
  8024b8:	89 d3                	mov    %edx,%ebx
  8024ba:	f7 24 24             	mull   (%esp)
  8024bd:	89 c6                	mov    %eax,%esi
  8024bf:	89 d1                	mov    %edx,%ecx
  8024c1:	39 d3                	cmp    %edx,%ebx
  8024c3:	0f 82 87 00 00 00    	jb     802550 <__umoddi3+0x134>
  8024c9:	0f 84 91 00 00 00    	je     802560 <__umoddi3+0x144>
  8024cf:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024d3:	29 f2                	sub    %esi,%edx
  8024d5:	19 cb                	sbb    %ecx,%ebx
  8024d7:	89 d8                	mov    %ebx,%eax
  8024d9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8024dd:	d3 e0                	shl    %cl,%eax
  8024df:	89 e9                	mov    %ebp,%ecx
  8024e1:	d3 ea                	shr    %cl,%edx
  8024e3:	09 d0                	or     %edx,%eax
  8024e5:	89 e9                	mov    %ebp,%ecx
  8024e7:	d3 eb                	shr    %cl,%ebx
  8024e9:	89 da                	mov    %ebx,%edx
  8024eb:	83 c4 1c             	add    $0x1c,%esp
  8024ee:	5b                   	pop    %ebx
  8024ef:	5e                   	pop    %esi
  8024f0:	5f                   	pop    %edi
  8024f1:	5d                   	pop    %ebp
  8024f2:	c3                   	ret    
  8024f3:	90                   	nop
  8024f4:	89 fd                	mov    %edi,%ebp
  8024f6:	85 ff                	test   %edi,%edi
  8024f8:	75 0b                	jne    802505 <__umoddi3+0xe9>
  8024fa:	b8 01 00 00 00       	mov    $0x1,%eax
  8024ff:	31 d2                	xor    %edx,%edx
  802501:	f7 f7                	div    %edi
  802503:	89 c5                	mov    %eax,%ebp
  802505:	89 f0                	mov    %esi,%eax
  802507:	31 d2                	xor    %edx,%edx
  802509:	f7 f5                	div    %ebp
  80250b:	89 c8                	mov    %ecx,%eax
  80250d:	f7 f5                	div    %ebp
  80250f:	89 d0                	mov    %edx,%eax
  802511:	e9 44 ff ff ff       	jmp    80245a <__umoddi3+0x3e>
  802516:	66 90                	xchg   %ax,%ax
  802518:	89 c8                	mov    %ecx,%eax
  80251a:	89 f2                	mov    %esi,%edx
  80251c:	83 c4 1c             	add    $0x1c,%esp
  80251f:	5b                   	pop    %ebx
  802520:	5e                   	pop    %esi
  802521:	5f                   	pop    %edi
  802522:	5d                   	pop    %ebp
  802523:	c3                   	ret    
  802524:	3b 04 24             	cmp    (%esp),%eax
  802527:	72 06                	jb     80252f <__umoddi3+0x113>
  802529:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80252d:	77 0f                	ja     80253e <__umoddi3+0x122>
  80252f:	89 f2                	mov    %esi,%edx
  802531:	29 f9                	sub    %edi,%ecx
  802533:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802537:	89 14 24             	mov    %edx,(%esp)
  80253a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80253e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802542:	8b 14 24             	mov    (%esp),%edx
  802545:	83 c4 1c             	add    $0x1c,%esp
  802548:	5b                   	pop    %ebx
  802549:	5e                   	pop    %esi
  80254a:	5f                   	pop    %edi
  80254b:	5d                   	pop    %ebp
  80254c:	c3                   	ret    
  80254d:	8d 76 00             	lea    0x0(%esi),%esi
  802550:	2b 04 24             	sub    (%esp),%eax
  802553:	19 fa                	sbb    %edi,%edx
  802555:	89 d1                	mov    %edx,%ecx
  802557:	89 c6                	mov    %eax,%esi
  802559:	e9 71 ff ff ff       	jmp    8024cf <__umoddi3+0xb3>
  80255e:	66 90                	xchg   %ax,%ax
  802560:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802564:	72 ea                	jb     802550 <__umoddi3+0x134>
  802566:	89 d9                	mov    %ebx,%ecx
  802568:	e9 62 ff ff ff       	jmp    8024cf <__umoddi3+0xb3>
