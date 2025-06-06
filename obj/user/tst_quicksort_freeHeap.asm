
obj/user/tst_quicksort_freeHeap:     file format elf32-i386


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
  800031:	e8 20 08 00 00       	call   800856 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
uint32 CheckSorted(int *Elements, int NumOfElements);

int CheckAndCountEmptyLocInWS(volatile struct Env *myEnv);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 34 01 00 00    	sub    $0x134,%esp


	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[255] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	do
	{

		Iteration++ ;
  800049:	ff 45 f0             	incl   -0x10(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

	sys_disable_interrupt();
  80004c:	e8 17 20 00 00       	call   802068 <sys_disable_interrupt>
		readline("Enter the number of elements: ", Line);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	8d 85 c9 fe ff ff    	lea    -0x137(%ebp),%eax
  80005a:	50                   	push   %eax
  80005b:	68 c0 26 80 00       	push   $0x8026c0
  800060:	e8 29 12 00 00       	call   80128e <readline>
  800065:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800068:	83 ec 04             	sub    $0x4,%esp
  80006b:	6a 0a                	push   $0xa
  80006d:	6a 00                	push   $0x0
  80006f:	8d 85 c9 fe ff ff    	lea    -0x137(%ebp),%eax
  800075:	50                   	push   %eax
  800076:	e8 79 17 00 00       	call   8017f4 <strtol>
  80007b:	83 c4 10             	add    $0x10,%esp
  80007e:	89 45 ec             	mov    %eax,-0x14(%ebp)

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800081:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800084:	c1 e0 02             	shl    $0x2,%eax
  800087:	83 ec 0c             	sub    $0xc,%esp
  80008a:	50                   	push   %eax
  80008b:	e8 46 1b 00 00       	call   801bd6 <malloc>
  800090:	83 c4 10             	add    $0x10,%esp
  800093:	89 45 e8             	mov    %eax,-0x18(%ebp)

		int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800096:	a1 24 30 80 00       	mov    0x803024,%eax
  80009b:	83 ec 0c             	sub    $0xc,%esp
  80009e:	50                   	push   %eax
  80009f:	e8 7f 03 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  8000a4:	83 c4 10             	add    $0x10,%esp
  8000a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS ;
  8000aa:	e8 e9 1e 00 00       	call   801f98 <sys_calculate_free_frames>
  8000af:	89 c3                	mov    %eax,%ebx
  8000b1:	e8 fb 1e 00 00       	call   801fb1 <sys_calculate_modified_frames>
  8000b6:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  8000b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000bc:	29 c2                	sub    %eax,%edx
  8000be:	89 d0                	mov    %edx,%eax
  8000c0:	89 45 e0             	mov    %eax,-0x20(%ebp)

		Elements[NumOfElements] = 10 ;
  8000c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000d0:	01 d0                	add    %edx,%eax
  8000d2:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000d8:	83 ec 0c             	sub    $0xc,%esp
  8000db:	68 e0 26 80 00       	push   $0x8026e0
  8000e0:	e8 27 0b 00 00       	call   800c0c <cprintf>
  8000e5:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000e8:	83 ec 0c             	sub    $0xc,%esp
  8000eb:	68 03 27 80 00       	push   $0x802703
  8000f0:	e8 17 0b 00 00       	call   800c0c <cprintf>
  8000f5:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000f8:	83 ec 0c             	sub    $0xc,%esp
  8000fb:	68 11 27 80 00       	push   $0x802711
  800100:	e8 07 0b 00 00       	call   800c0c <cprintf>
  800105:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n") ;
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	68 20 27 80 00       	push   $0x802720
  800110:	e8 f7 0a 00 00       	call   800c0c <cprintf>
  800115:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800118:	83 ec 0c             	sub    $0xc,%esp
  80011b:	68 30 27 80 00       	push   $0x802730
  800120:	e8 e7 0a 00 00       	call   800c0c <cprintf>
  800125:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800128:	e8 d1 06 00 00       	call   8007fe <getchar>
  80012d:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800130:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	50                   	push   %eax
  800138:	e8 79 06 00 00       	call   8007b6 <cputchar>
  80013d:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800140:	83 ec 0c             	sub    $0xc,%esp
  800143:	6a 0a                	push   $0xa
  800145:	e8 6c 06 00 00       	call   8007b6 <cputchar>
  80014a:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  80014d:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800151:	74 0c                	je     80015f <_main+0x127>
  800153:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800157:	74 06                	je     80015f <_main+0x127>
  800159:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  80015d:	75 b9                	jne    800118 <_main+0xe0>
	sys_enable_interrupt();
  80015f:	e8 1e 1f 00 00       	call   802082 <sys_enable_interrupt>
		int  i ;
		switch (Chose)
  800164:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800168:	83 f8 62             	cmp    $0x62,%eax
  80016b:	74 1d                	je     80018a <_main+0x152>
  80016d:	83 f8 63             	cmp    $0x63,%eax
  800170:	74 2b                	je     80019d <_main+0x165>
  800172:	83 f8 61             	cmp    $0x61,%eax
  800175:	75 39                	jne    8001b0 <_main+0x178>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800177:	83 ec 08             	sub    $0x8,%esp
  80017a:	ff 75 ec             	pushl  -0x14(%ebp)
  80017d:	ff 75 e8             	pushl  -0x18(%ebp)
  800180:	e8 f9 04 00 00       	call   80067e <InitializeAscending>
  800185:	83 c4 10             	add    $0x10,%esp
			break ;
  800188:	eb 37                	jmp    8001c1 <_main+0x189>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018a:	83 ec 08             	sub    $0x8,%esp
  80018d:	ff 75 ec             	pushl  -0x14(%ebp)
  800190:	ff 75 e8             	pushl  -0x18(%ebp)
  800193:	e8 17 05 00 00       	call   8006af <InitializeDescending>
  800198:	83 c4 10             	add    $0x10,%esp
			break ;
  80019b:	eb 24                	jmp    8001c1 <_main+0x189>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80019d:	83 ec 08             	sub    $0x8,%esp
  8001a0:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a3:	ff 75 e8             	pushl  -0x18(%ebp)
  8001a6:	e8 39 05 00 00       	call   8006e4 <InitializeSemiRandom>
  8001ab:	83 c4 10             	add    $0x10,%esp
			break ;
  8001ae:	eb 11                	jmp    8001c1 <_main+0x189>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b0:	83 ec 08             	sub    $0x8,%esp
  8001b3:	ff 75 ec             	pushl  -0x14(%ebp)
  8001b6:	ff 75 e8             	pushl  -0x18(%ebp)
  8001b9:	e8 26 05 00 00       	call   8006e4 <InitializeSemiRandom>
  8001be:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c1:	83 ec 08             	sub    $0x8,%esp
  8001c4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001c7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001ca:	e8 f4 02 00 00       	call   8004c3 <QuickSort>
  8001cf:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001d2:	83 ec 08             	sub    $0x8,%esp
  8001d5:	ff 75 ec             	pushl  -0x14(%ebp)
  8001d8:	ff 75 e8             	pushl  -0x18(%ebp)
  8001db:	e8 f4 03 00 00       	call   8005d4 <CheckSorted>
  8001e0:	83 c4 10             	add    $0x10,%esp
  8001e3:	89 45 dc             	mov    %eax,-0x24(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001e6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001ea:	75 14                	jne    800200 <_main+0x1c8>
  8001ec:	83 ec 04             	sub    $0x4,%esp
  8001ef:	68 3c 27 80 00       	push   $0x80273c
  8001f4:	6a 57                	push   $0x57
  8001f6:	68 5e 27 80 00       	push   $0x80275e
  8001fb:	e8 58 07 00 00       	call   800958 <_panic>
		else
		{
			cprintf("===============================================\n") ;
  800200:	83 ec 0c             	sub    $0xc,%esp
  800203:	68 7c 27 80 00       	push   $0x80277c
  800208:	e8 ff 09 00 00       	call   800c0c <cprintf>
  80020d:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800210:	83 ec 0c             	sub    $0xc,%esp
  800213:	68 b0 27 80 00       	push   $0x8027b0
  800218:	e8 ef 09 00 00       	call   800c0c <cprintf>
  80021d:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800220:	83 ec 0c             	sub    $0xc,%esp
  800223:	68 e4 27 80 00       	push   $0x8027e4
  800228:	e8 df 09 00 00       	call   800c0c <cprintf>
  80022d:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  800230:	83 ec 0c             	sub    $0xc,%esp
  800233:	68 16 28 80 00       	push   $0x802816
  800238:	e8 cf 09 00 00       	call   800c0c <cprintf>
  80023d:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	ff 75 e8             	pushl  -0x18(%ebp)
  800246:	e8 ac 1a 00 00       	call   801cf7 <free>
  80024b:	83 c4 10             	add    $0x10,%esp


		///Testing the freeHeap according to the specified scenario
		if (Iteration == 1)
  80024e:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  800252:	75 72                	jne    8002c6 <_main+0x28e>
		{
			if (!(NumOfElements == 1000 && Chose == 'a'))
  800254:	81 7d ec e8 03 00 00 	cmpl   $0x3e8,-0x14(%ebp)
  80025b:	75 06                	jne    800263 <_main+0x22b>
  80025d:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800261:	74 14                	je     800277 <_main+0x23f>
				panic("Please ensure the number of elements and the initialization method of this test");
  800263:	83 ec 04             	sub    $0x4,%esp
  800266:	68 2c 28 80 00       	push   $0x80282c
  80026b:	6a 69                	push   $0x69
  80026d:	68 5e 27 80 00       	push   $0x80275e
  800272:	e8 e1 06 00 00       	call   800958 <_panic>

			numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800277:	a1 24 30 80 00       	mov    0x803024,%eax
  80027c:	83 ec 0c             	sub    $0xc,%esp
  80027f:	50                   	push   %eax
  800280:	e8 9e 01 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  800285:	83 c4 10             	add    $0x10,%esp
  800288:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  80028b:	e8 08 1d 00 00       	call   801f98 <sys_calculate_free_frames>
  800290:	89 c3                	mov    %eax,%ebx
  800292:	e8 1a 1d 00 00       	call   801fb1 <sys_calculate_modified_frames>
  800297:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  80029a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80029d:	29 c2                	sub    %eax,%edx
  80029f:	89 d0                	mov    %edx,%eax
  8002a1:	89 45 d8             	mov    %eax,-0x28(%ebp)
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  8002a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002a7:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8002aa:	0f 84 05 01 00 00    	je     8003b5 <_main+0x37d>
  8002b0:	68 7c 28 80 00       	push   $0x80287c
  8002b5:	68 a1 28 80 00       	push   $0x8028a1
  8002ba:	6a 6d                	push   $0x6d
  8002bc:	68 5e 27 80 00       	push   $0x80275e
  8002c1:	e8 92 06 00 00       	call   800958 <_panic>
		}
		else if (Iteration == 2 )
  8002c6:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8002ca:	75 72                	jne    80033e <_main+0x306>
		{
			if (!(NumOfElements == 5000 && Chose == 'b'))
  8002cc:	81 7d ec 88 13 00 00 	cmpl   $0x1388,-0x14(%ebp)
  8002d3:	75 06                	jne    8002db <_main+0x2a3>
  8002d5:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  8002d9:	74 14                	je     8002ef <_main+0x2b7>
				panic("Please ensure the number of elements and the initialization method of this test");
  8002db:	83 ec 04             	sub    $0x4,%esp
  8002de:	68 2c 28 80 00       	push   $0x80282c
  8002e3:	6a 72                	push   $0x72
  8002e5:	68 5e 27 80 00       	push   $0x80275e
  8002ea:	e8 69 06 00 00       	call   800958 <_panic>

			int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  8002ef:	a1 24 30 80 00       	mov    0x803024,%eax
  8002f4:	83 ec 0c             	sub    $0xc,%esp
  8002f7:	50                   	push   %eax
  8002f8:	e8 26 01 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  8002fd:	83 c4 10             	add    $0x10,%esp
  800300:	89 45 d4             	mov    %eax,-0x2c(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  800303:	e8 90 1c 00 00       	call   801f98 <sys_calculate_free_frames>
  800308:	89 c3                	mov    %eax,%ebx
  80030a:	e8 a2 1c 00 00       	call   801fb1 <sys_calculate_modified_frames>
  80030f:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  800312:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800315:	29 c2                	sub    %eax,%edx
  800317:	89 d0                	mov    %edx,%eax
  800319:	89 45 d0             	mov    %eax,-0x30(%ebp)
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  80031c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80031f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800322:	0f 84 8d 00 00 00    	je     8003b5 <_main+0x37d>
  800328:	68 7c 28 80 00       	push   $0x80287c
  80032d:	68 a1 28 80 00       	push   $0x8028a1
  800332:	6a 76                	push   $0x76
  800334:	68 5e 27 80 00       	push   $0x80275e
  800339:	e8 1a 06 00 00       	call   800958 <_panic>
		}
		else if (Iteration == 3 )
  80033e:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
  800342:	75 71                	jne    8003b5 <_main+0x37d>
		{
			if (!(NumOfElements == 300000 && Chose == 'c'))
  800344:	81 7d ec e0 93 04 00 	cmpl   $0x493e0,-0x14(%ebp)
  80034b:	75 06                	jne    800353 <_main+0x31b>
  80034d:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800351:	74 14                	je     800367 <_main+0x32f>
				panic("Please ensure the number of elements and the initialization method of this test");
  800353:	83 ec 04             	sub    $0x4,%esp
  800356:	68 2c 28 80 00       	push   $0x80282c
  80035b:	6a 7b                	push   $0x7b
  80035d:	68 5e 27 80 00       	push   $0x80275e
  800362:	e8 f1 05 00 00       	call   800958 <_panic>

			int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800367:	a1 24 30 80 00       	mov    0x803024,%eax
  80036c:	83 ec 0c             	sub    $0xc,%esp
  80036f:	50                   	push   %eax
  800370:	e8 ae 00 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  800375:	83 c4 10             	add    $0x10,%esp
  800378:	89 45 cc             	mov    %eax,-0x34(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  80037b:	e8 18 1c 00 00       	call   801f98 <sys_calculate_free_frames>
  800380:	89 c3                	mov    %eax,%ebx
  800382:	e8 2a 1c 00 00       	call   801fb1 <sys_calculate_modified_frames>
  800387:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  80038a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80038d:	29 c2                	sub    %eax,%edx
  80038f:	89 d0                	mov    %edx,%eax
  800391:	89 45 c8             	mov    %eax,-0x38(%ebp)
			//cprintf("numOFEmptyLocInWS = %d\n", numOFEmptyLocInWS );
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  800394:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800397:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80039a:	74 19                	je     8003b5 <_main+0x37d>
  80039c:	68 7c 28 80 00       	push   $0x80287c
  8003a1:	68 a1 28 80 00       	push   $0x8028a1
  8003a6:	68 80 00 00 00       	push   $0x80
  8003ab:	68 5e 27 80 00       	push   $0x80275e
  8003b0:	e8 a3 05 00 00       	call   800958 <_panic>
		}
		///========================================================================
	sys_disable_interrupt();
  8003b5:	e8 ae 1c 00 00       	call   802068 <sys_disable_interrupt>
		Chose = 0 ;
  8003ba:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		while (Chose != 'y' && Chose != 'n')
  8003be:	eb 42                	jmp    800402 <_main+0x3ca>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  8003c0:	83 ec 0c             	sub    $0xc,%esp
  8003c3:	68 b6 28 80 00       	push   $0x8028b6
  8003c8:	e8 3f 08 00 00       	call   800c0c <cprintf>
  8003cd:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8003d0:	e8 29 04 00 00       	call   8007fe <getchar>
  8003d5:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  8003d8:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8003dc:	83 ec 0c             	sub    $0xc,%esp
  8003df:	50                   	push   %eax
  8003e0:	e8 d1 03 00 00       	call   8007b6 <cputchar>
  8003e5:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8003e8:	83 ec 0c             	sub    $0xc,%esp
  8003eb:	6a 0a                	push   $0xa
  8003ed:	e8 c4 03 00 00       	call   8007b6 <cputchar>
  8003f2:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8003f5:	83 ec 0c             	sub    $0xc,%esp
  8003f8:	6a 0a                	push   $0xa
  8003fa:	e8 b7 03 00 00       	call   8007b6 <cputchar>
  8003ff:	83 c4 10             	add    $0x10,%esp
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
		}
		///========================================================================
	sys_disable_interrupt();
		Chose = 0 ;
		while (Chose != 'y' && Chose != 'n')
  800402:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800406:	74 06                	je     80040e <_main+0x3d6>
  800408:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  80040c:	75 b2                	jne    8003c0 <_main+0x388>
			Chose = getchar() ;
			cputchar(Chose);
			cputchar('\n');
			cputchar('\n');
		}
	sys_enable_interrupt();
  80040e:	e8 6f 1c 00 00       	call   802082 <sys_enable_interrupt>

	} while (Chose == 'y');
  800413:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800417:	0f 84 2c fc ff ff    	je     800049 <_main+0x11>
}
  80041d:	90                   	nop
  80041e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800421:	c9                   	leave  
  800422:	c3                   	ret    

00800423 <CheckAndCountEmptyLocInWS>:

int CheckAndCountEmptyLocInWS(volatile struct Env *myEnv)
{
  800423:	55                   	push   %ebp
  800424:	89 e5                	mov    %esp,%ebp
  800426:	83 ec 18             	sub    $0x18,%esp
	int numOFEmptyLocInWS = 0, i;
  800429:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  800430:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800437:	eb 74                	jmp    8004ad <CheckAndCountEmptyLocInWS+0x8a>
	{
		if (myEnv->__uptr_pws[i].empty)
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800442:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800445:	89 d0                	mov    %edx,%eax
  800447:	01 c0                	add    %eax,%eax
  800449:	01 d0                	add    %edx,%eax
  80044b:	c1 e0 02             	shl    $0x2,%eax
  80044e:	01 c8                	add    %ecx,%eax
  800450:	8a 40 04             	mov    0x4(%eax),%al
  800453:	84 c0                	test   %al,%al
  800455:	74 05                	je     80045c <CheckAndCountEmptyLocInWS+0x39>
		{
			numOFEmptyLocInWS++;
  800457:	ff 45 f4             	incl   -0xc(%ebp)
  80045a:	eb 4e                	jmp    8004aa <CheckAndCountEmptyLocInWS+0x87>
		}
		else
		{
			uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800465:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800468:	89 d0                	mov    %edx,%eax
  80046a:	01 c0                	add    %eax,%eax
  80046c:	01 d0                	add    %edx,%eax
  80046e:	c1 e0 02             	shl    $0x2,%eax
  800471:	01 c8                	add    %ecx,%eax
  800473:	8b 00                	mov    (%eax),%eax
  800475:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800478:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80047b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800480:	89 45 e8             	mov    %eax,-0x18(%ebp)
			if (va >= USER_HEAP_START && va < (USER_HEAP_MAX))
  800483:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800486:	85 c0                	test   %eax,%eax
  800488:	79 20                	jns    8004aa <CheckAndCountEmptyLocInWS+0x87>
  80048a:	81 7d e8 ff ff ff 9f 	cmpl   $0x9fffffff,-0x18(%ebp)
  800491:	77 17                	ja     8004aa <CheckAndCountEmptyLocInWS+0x87>
				panic("freeMem didn't remove its page(s) from the WS");
  800493:	83 ec 04             	sub    $0x4,%esp
  800496:	68 d4 28 80 00       	push   $0x8028d4
  80049b:	68 9f 00 00 00       	push   $0x9f
  8004a0:	68 5e 27 80 00       	push   $0x80275e
  8004a5:	e8 ae 04 00 00       	call   800958 <_panic>
}

int CheckAndCountEmptyLocInWS(volatile struct Env *myEnv)
{
	int numOFEmptyLocInWS = 0, i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  8004aa:	ff 45 f0             	incl   -0x10(%ebp)
  8004ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b0:	8b 50 74             	mov    0x74(%eax),%edx
  8004b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004b6:	39 c2                	cmp    %eax,%edx
  8004b8:	0f 87 7b ff ff ff    	ja     800439 <CheckAndCountEmptyLocInWS+0x16>
			uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
			if (va >= USER_HEAP_START && va < (USER_HEAP_MAX))
				panic("freeMem didn't remove its page(s) from the WS");
		}
	}
	return numOFEmptyLocInWS;
  8004be:	8b 45 f4             	mov    -0xc(%ebp),%eax

}
  8004c1:	c9                   	leave  
  8004c2:	c3                   	ret    

008004c3 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8004c3:	55                   	push   %ebp
  8004c4:	89 e5                	mov    %esp,%ebp
  8004c6:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8004c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004cc:	48                   	dec    %eax
  8004cd:	50                   	push   %eax
  8004ce:	6a 00                	push   $0x0
  8004d0:	ff 75 0c             	pushl  0xc(%ebp)
  8004d3:	ff 75 08             	pushl  0x8(%ebp)
  8004d6:	e8 06 00 00 00       	call   8004e1 <QSort>
  8004db:	83 c4 10             	add    $0x10,%esp
}
  8004de:	90                   	nop
  8004df:	c9                   	leave  
  8004e0:	c3                   	ret    

008004e1 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8004e1:	55                   	push   %ebp
  8004e2:	89 e5                	mov    %esp,%ebp
  8004e4:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8004e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ea:	3b 45 14             	cmp    0x14(%ebp),%eax
  8004ed:	0f 8d de 00 00 00    	jge    8005d1 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8004f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f6:	40                   	inc    %eax
  8004f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8004fa:	8b 45 14             	mov    0x14(%ebp),%eax
  8004fd:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800500:	e9 80 00 00 00       	jmp    800585 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800505:	ff 45 f4             	incl   -0xc(%ebp)
  800508:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80050b:	3b 45 14             	cmp    0x14(%ebp),%eax
  80050e:	7f 2b                	jg     80053b <QSort+0x5a>
  800510:	8b 45 10             	mov    0x10(%ebp),%eax
  800513:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80051a:	8b 45 08             	mov    0x8(%ebp),%eax
  80051d:	01 d0                	add    %edx,%eax
  80051f:	8b 10                	mov    (%eax),%edx
  800521:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800524:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80052b:	8b 45 08             	mov    0x8(%ebp),%eax
  80052e:	01 c8                	add    %ecx,%eax
  800530:	8b 00                	mov    (%eax),%eax
  800532:	39 c2                	cmp    %eax,%edx
  800534:	7d cf                	jge    800505 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800536:	eb 03                	jmp    80053b <QSort+0x5a>
  800538:	ff 4d f0             	decl   -0x10(%ebp)
  80053b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80053e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800541:	7e 26                	jle    800569 <QSort+0x88>
  800543:	8b 45 10             	mov    0x10(%ebp),%eax
  800546:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80054d:	8b 45 08             	mov    0x8(%ebp),%eax
  800550:	01 d0                	add    %edx,%eax
  800552:	8b 10                	mov    (%eax),%edx
  800554:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800557:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80055e:	8b 45 08             	mov    0x8(%ebp),%eax
  800561:	01 c8                	add    %ecx,%eax
  800563:	8b 00                	mov    (%eax),%eax
  800565:	39 c2                	cmp    %eax,%edx
  800567:	7e cf                	jle    800538 <QSort+0x57>

		if (i <= j)
  800569:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80056c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80056f:	7f 14                	jg     800585 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800571:	83 ec 04             	sub    $0x4,%esp
  800574:	ff 75 f0             	pushl  -0x10(%ebp)
  800577:	ff 75 f4             	pushl  -0xc(%ebp)
  80057a:	ff 75 08             	pushl  0x8(%ebp)
  80057d:	e8 a9 00 00 00       	call   80062b <Swap>
  800582:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800585:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800588:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80058b:	0f 8e 77 ff ff ff    	jle    800508 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800591:	83 ec 04             	sub    $0x4,%esp
  800594:	ff 75 f0             	pushl  -0x10(%ebp)
  800597:	ff 75 10             	pushl  0x10(%ebp)
  80059a:	ff 75 08             	pushl  0x8(%ebp)
  80059d:	e8 89 00 00 00       	call   80062b <Swap>
  8005a2:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8005a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005a8:	48                   	dec    %eax
  8005a9:	50                   	push   %eax
  8005aa:	ff 75 10             	pushl  0x10(%ebp)
  8005ad:	ff 75 0c             	pushl  0xc(%ebp)
  8005b0:	ff 75 08             	pushl  0x8(%ebp)
  8005b3:	e8 29 ff ff ff       	call   8004e1 <QSort>
  8005b8:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8005bb:	ff 75 14             	pushl  0x14(%ebp)
  8005be:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c1:	ff 75 0c             	pushl  0xc(%ebp)
  8005c4:	ff 75 08             	pushl  0x8(%ebp)
  8005c7:	e8 15 ff ff ff       	call   8004e1 <QSort>
  8005cc:	83 c4 10             	add    $0x10,%esp
  8005cf:	eb 01                	jmp    8005d2 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8005d1:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  8005d2:	c9                   	leave  
  8005d3:	c3                   	ret    

008005d4 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8005d4:	55                   	push   %ebp
  8005d5:	89 e5                	mov    %esp,%ebp
  8005d7:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8005da:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8005e1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8005e8:	eb 33                	jmp    80061d <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8005ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8005ed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f7:	01 d0                	add    %edx,%eax
  8005f9:	8b 10                	mov    (%eax),%edx
  8005fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8005fe:	40                   	inc    %eax
  8005ff:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800606:	8b 45 08             	mov    0x8(%ebp),%eax
  800609:	01 c8                	add    %ecx,%eax
  80060b:	8b 00                	mov    (%eax),%eax
  80060d:	39 c2                	cmp    %eax,%edx
  80060f:	7e 09                	jle    80061a <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800611:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800618:	eb 0c                	jmp    800626 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80061a:	ff 45 f8             	incl   -0x8(%ebp)
  80061d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800620:	48                   	dec    %eax
  800621:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800624:	7f c4                	jg     8005ea <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800626:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800629:	c9                   	leave  
  80062a:	c3                   	ret    

0080062b <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80062b:	55                   	push   %ebp
  80062c:	89 e5                	mov    %esp,%ebp
  80062e:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800631:	8b 45 0c             	mov    0xc(%ebp),%eax
  800634:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80063b:	8b 45 08             	mov    0x8(%ebp),%eax
  80063e:	01 d0                	add    %edx,%eax
  800640:	8b 00                	mov    (%eax),%eax
  800642:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800645:	8b 45 0c             	mov    0xc(%ebp),%eax
  800648:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80064f:	8b 45 08             	mov    0x8(%ebp),%eax
  800652:	01 c2                	add    %eax,%edx
  800654:	8b 45 10             	mov    0x10(%ebp),%eax
  800657:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80065e:	8b 45 08             	mov    0x8(%ebp),%eax
  800661:	01 c8                	add    %ecx,%eax
  800663:	8b 00                	mov    (%eax),%eax
  800665:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800667:	8b 45 10             	mov    0x10(%ebp),%eax
  80066a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800671:	8b 45 08             	mov    0x8(%ebp),%eax
  800674:	01 c2                	add    %eax,%edx
  800676:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800679:	89 02                	mov    %eax,(%edx)
}
  80067b:	90                   	nop
  80067c:	c9                   	leave  
  80067d:	c3                   	ret    

0080067e <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80067e:	55                   	push   %ebp
  80067f:	89 e5                	mov    %esp,%ebp
  800681:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800684:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80068b:	eb 17                	jmp    8006a4 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80068d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800690:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	01 c2                	add    %eax,%edx
  80069c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80069f:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8006a1:	ff 45 fc             	incl   -0x4(%ebp)
  8006a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006a7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006aa:	7c e1                	jl     80068d <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8006ac:	90                   	nop
  8006ad:	c9                   	leave  
  8006ae:	c3                   	ret    

008006af <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8006af:	55                   	push   %ebp
  8006b0:	89 e5                	mov    %esp,%ebp
  8006b2:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8006b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8006bc:	eb 1b                	jmp    8006d9 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8006be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	01 c2                	add    %eax,%edx
  8006cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d0:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8006d3:	48                   	dec    %eax
  8006d4:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8006d6:	ff 45 fc             	incl   -0x4(%ebp)
  8006d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006dc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006df:	7c dd                	jl     8006be <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8006e1:	90                   	nop
  8006e2:	c9                   	leave  
  8006e3:	c3                   	ret    

008006e4 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8006e4:	55                   	push   %ebp
  8006e5:	89 e5                	mov    %esp,%ebp
  8006e7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8006ea:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8006ed:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8006f2:	f7 e9                	imul   %ecx
  8006f4:	c1 f9 1f             	sar    $0x1f,%ecx
  8006f7:	89 d0                	mov    %edx,%eax
  8006f9:	29 c8                	sub    %ecx,%eax
  8006fb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8006fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800705:	eb 1e                	jmp    800725 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800707:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80070a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800711:	8b 45 08             	mov    0x8(%ebp),%eax
  800714:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800717:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80071a:	99                   	cltd   
  80071b:	f7 7d f8             	idivl  -0x8(%ebp)
  80071e:	89 d0                	mov    %edx,%eax
  800720:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800722:	ff 45 fc             	incl   -0x4(%ebp)
  800725:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800728:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80072b:	7c da                	jl     800707 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  80072d:	90                   	nop
  80072e:	c9                   	leave  
  80072f:	c3                   	ret    

00800730 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800730:	55                   	push   %ebp
  800731:	89 e5                	mov    %esp,%ebp
  800733:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800736:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80073d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800744:	eb 42                	jmp    800788 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800746:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800749:	99                   	cltd   
  80074a:	f7 7d f0             	idivl  -0x10(%ebp)
  80074d:	89 d0                	mov    %edx,%eax
  80074f:	85 c0                	test   %eax,%eax
  800751:	75 10                	jne    800763 <PrintElements+0x33>
			cprintf("\n");
  800753:	83 ec 0c             	sub    $0xc,%esp
  800756:	68 02 29 80 00       	push   $0x802902
  80075b:	e8 ac 04 00 00       	call   800c0c <cprintf>
  800760:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800763:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800766:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80076d:	8b 45 08             	mov    0x8(%ebp),%eax
  800770:	01 d0                	add    %edx,%eax
  800772:	8b 00                	mov    (%eax),%eax
  800774:	83 ec 08             	sub    $0x8,%esp
  800777:	50                   	push   %eax
  800778:	68 04 29 80 00       	push   $0x802904
  80077d:	e8 8a 04 00 00       	call   800c0c <cprintf>
  800782:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800785:	ff 45 f4             	incl   -0xc(%ebp)
  800788:	8b 45 0c             	mov    0xc(%ebp),%eax
  80078b:	48                   	dec    %eax
  80078c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80078f:	7f b5                	jg     800746 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800791:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800794:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80079b:	8b 45 08             	mov    0x8(%ebp),%eax
  80079e:	01 d0                	add    %edx,%eax
  8007a0:	8b 00                	mov    (%eax),%eax
  8007a2:	83 ec 08             	sub    $0x8,%esp
  8007a5:	50                   	push   %eax
  8007a6:	68 09 29 80 00       	push   $0x802909
  8007ab:	e8 5c 04 00 00       	call   800c0c <cprintf>
  8007b0:	83 c4 10             	add    $0x10,%esp

}
  8007b3:	90                   	nop
  8007b4:	c9                   	leave  
  8007b5:	c3                   	ret    

008007b6 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8007b6:	55                   	push   %ebp
  8007b7:	89 e5                	mov    %esp,%ebp
  8007b9:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8007bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bf:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8007c2:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8007c6:	83 ec 0c             	sub    $0xc,%esp
  8007c9:	50                   	push   %eax
  8007ca:	e8 cd 18 00 00       	call   80209c <sys_cputc>
  8007cf:	83 c4 10             	add    $0x10,%esp
}
  8007d2:	90                   	nop
  8007d3:	c9                   	leave  
  8007d4:	c3                   	ret    

008007d5 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8007d5:	55                   	push   %ebp
  8007d6:	89 e5                	mov    %esp,%ebp
  8007d8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007db:	e8 88 18 00 00       	call   802068 <sys_disable_interrupt>
	char c = ch;
  8007e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e3:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8007e6:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8007ea:	83 ec 0c             	sub    $0xc,%esp
  8007ed:	50                   	push   %eax
  8007ee:	e8 a9 18 00 00       	call   80209c <sys_cputc>
  8007f3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007f6:	e8 87 18 00 00       	call   802082 <sys_enable_interrupt>
}
  8007fb:	90                   	nop
  8007fc:	c9                   	leave  
  8007fd:	c3                   	ret    

008007fe <getchar>:

int
getchar(void)
{
  8007fe:	55                   	push   %ebp
  8007ff:	89 e5                	mov    %esp,%ebp
  800801:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800804:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80080b:	eb 08                	jmp    800815 <getchar+0x17>
	{
		c = sys_cgetc();
  80080d:	e8 6e 16 00 00       	call   801e80 <sys_cgetc>
  800812:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800815:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800819:	74 f2                	je     80080d <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80081b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80081e:	c9                   	leave  
  80081f:	c3                   	ret    

00800820 <atomic_getchar>:

int
atomic_getchar(void)
{
  800820:	55                   	push   %ebp
  800821:	89 e5                	mov    %esp,%ebp
  800823:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800826:	e8 3d 18 00 00       	call   802068 <sys_disable_interrupt>
	int c=0;
  80082b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800832:	eb 08                	jmp    80083c <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800834:	e8 47 16 00 00       	call   801e80 <sys_cgetc>
  800839:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80083c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800840:	74 f2                	je     800834 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800842:	e8 3b 18 00 00       	call   802082 <sys_enable_interrupt>
	return c;
  800847:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80084a:	c9                   	leave  
  80084b:	c3                   	ret    

0080084c <iscons>:

int iscons(int fdnum)
{
  80084c:	55                   	push   %ebp
  80084d:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80084f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800854:	5d                   	pop    %ebp
  800855:	c3                   	ret    

00800856 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800856:	55                   	push   %ebp
  800857:	89 e5                	mov    %esp,%ebp
  800859:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80085c:	e8 6c 16 00 00       	call   801ecd <sys_getenvindex>
  800861:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800864:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800867:	89 d0                	mov    %edx,%eax
  800869:	01 c0                	add    %eax,%eax
  80086b:	01 d0                	add    %edx,%eax
  80086d:	c1 e0 02             	shl    $0x2,%eax
  800870:	01 d0                	add    %edx,%eax
  800872:	c1 e0 06             	shl    $0x6,%eax
  800875:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80087a:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80087f:	a1 24 30 80 00       	mov    0x803024,%eax
  800884:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80088a:	84 c0                	test   %al,%al
  80088c:	74 0f                	je     80089d <libmain+0x47>
		binaryname = myEnv->prog_name;
  80088e:	a1 24 30 80 00       	mov    0x803024,%eax
  800893:	05 f4 02 00 00       	add    $0x2f4,%eax
  800898:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80089d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008a1:	7e 0a                	jle    8008ad <libmain+0x57>
		binaryname = argv[0];
  8008a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a6:	8b 00                	mov    (%eax),%eax
  8008a8:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8008ad:	83 ec 08             	sub    $0x8,%esp
  8008b0:	ff 75 0c             	pushl  0xc(%ebp)
  8008b3:	ff 75 08             	pushl  0x8(%ebp)
  8008b6:	e8 7d f7 ff ff       	call   800038 <_main>
  8008bb:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8008be:	e8 a5 17 00 00       	call   802068 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8008c3:	83 ec 0c             	sub    $0xc,%esp
  8008c6:	68 28 29 80 00       	push   $0x802928
  8008cb:	e8 3c 03 00 00       	call   800c0c <cprintf>
  8008d0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8008d3:	a1 24 30 80 00       	mov    0x803024,%eax
  8008d8:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8008de:	a1 24 30 80 00       	mov    0x803024,%eax
  8008e3:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8008e9:	83 ec 04             	sub    $0x4,%esp
  8008ec:	52                   	push   %edx
  8008ed:	50                   	push   %eax
  8008ee:	68 50 29 80 00       	push   $0x802950
  8008f3:	e8 14 03 00 00       	call   800c0c <cprintf>
  8008f8:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8008fb:	a1 24 30 80 00       	mov    0x803024,%eax
  800900:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800906:	83 ec 08             	sub    $0x8,%esp
  800909:	50                   	push   %eax
  80090a:	68 75 29 80 00       	push   $0x802975
  80090f:	e8 f8 02 00 00       	call   800c0c <cprintf>
  800914:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800917:	83 ec 0c             	sub    $0xc,%esp
  80091a:	68 28 29 80 00       	push   $0x802928
  80091f:	e8 e8 02 00 00       	call   800c0c <cprintf>
  800924:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800927:	e8 56 17 00 00       	call   802082 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80092c:	e8 19 00 00 00       	call   80094a <exit>
}
  800931:	90                   	nop
  800932:	c9                   	leave  
  800933:	c3                   	ret    

00800934 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800934:	55                   	push   %ebp
  800935:	89 e5                	mov    %esp,%ebp
  800937:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80093a:	83 ec 0c             	sub    $0xc,%esp
  80093d:	6a 00                	push   $0x0
  80093f:	e8 55 15 00 00       	call   801e99 <sys_env_destroy>
  800944:	83 c4 10             	add    $0x10,%esp
}
  800947:	90                   	nop
  800948:	c9                   	leave  
  800949:	c3                   	ret    

0080094a <exit>:

void
exit(void)
{
  80094a:	55                   	push   %ebp
  80094b:	89 e5                	mov    %esp,%ebp
  80094d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800950:	e8 aa 15 00 00       	call   801eff <sys_env_exit>
}
  800955:	90                   	nop
  800956:	c9                   	leave  
  800957:	c3                   	ret    

00800958 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800958:	55                   	push   %ebp
  800959:	89 e5                	mov    %esp,%ebp
  80095b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80095e:	8d 45 10             	lea    0x10(%ebp),%eax
  800961:	83 c0 04             	add    $0x4,%eax
  800964:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800967:	a1 34 30 80 00       	mov    0x803034,%eax
  80096c:	85 c0                	test   %eax,%eax
  80096e:	74 16                	je     800986 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800970:	a1 34 30 80 00       	mov    0x803034,%eax
  800975:	83 ec 08             	sub    $0x8,%esp
  800978:	50                   	push   %eax
  800979:	68 8c 29 80 00       	push   $0x80298c
  80097e:	e8 89 02 00 00       	call   800c0c <cprintf>
  800983:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800986:	a1 00 30 80 00       	mov    0x803000,%eax
  80098b:	ff 75 0c             	pushl  0xc(%ebp)
  80098e:	ff 75 08             	pushl  0x8(%ebp)
  800991:	50                   	push   %eax
  800992:	68 91 29 80 00       	push   $0x802991
  800997:	e8 70 02 00 00       	call   800c0c <cprintf>
  80099c:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80099f:	8b 45 10             	mov    0x10(%ebp),%eax
  8009a2:	83 ec 08             	sub    $0x8,%esp
  8009a5:	ff 75 f4             	pushl  -0xc(%ebp)
  8009a8:	50                   	push   %eax
  8009a9:	e8 f3 01 00 00       	call   800ba1 <vcprintf>
  8009ae:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8009b1:	83 ec 08             	sub    $0x8,%esp
  8009b4:	6a 00                	push   $0x0
  8009b6:	68 ad 29 80 00       	push   $0x8029ad
  8009bb:	e8 e1 01 00 00       	call   800ba1 <vcprintf>
  8009c0:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8009c3:	e8 82 ff ff ff       	call   80094a <exit>

	// should not return here
	while (1) ;
  8009c8:	eb fe                	jmp    8009c8 <_panic+0x70>

008009ca <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8009ca:	55                   	push   %ebp
  8009cb:	89 e5                	mov    %esp,%ebp
  8009cd:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8009d0:	a1 24 30 80 00       	mov    0x803024,%eax
  8009d5:	8b 50 74             	mov    0x74(%eax),%edx
  8009d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009db:	39 c2                	cmp    %eax,%edx
  8009dd:	74 14                	je     8009f3 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8009df:	83 ec 04             	sub    $0x4,%esp
  8009e2:	68 b0 29 80 00       	push   $0x8029b0
  8009e7:	6a 26                	push   $0x26
  8009e9:	68 fc 29 80 00       	push   $0x8029fc
  8009ee:	e8 65 ff ff ff       	call   800958 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8009f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8009fa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a01:	e9 c2 00 00 00       	jmp    800ac8 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800a06:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a09:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a10:	8b 45 08             	mov    0x8(%ebp),%eax
  800a13:	01 d0                	add    %edx,%eax
  800a15:	8b 00                	mov    (%eax),%eax
  800a17:	85 c0                	test   %eax,%eax
  800a19:	75 08                	jne    800a23 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800a1b:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a1e:	e9 a2 00 00 00       	jmp    800ac5 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800a23:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a2a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a31:	eb 69                	jmp    800a9c <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a33:	a1 24 30 80 00       	mov    0x803024,%eax
  800a38:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800a3e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a41:	89 d0                	mov    %edx,%eax
  800a43:	01 c0                	add    %eax,%eax
  800a45:	01 d0                	add    %edx,%eax
  800a47:	c1 e0 02             	shl    $0x2,%eax
  800a4a:	01 c8                	add    %ecx,%eax
  800a4c:	8a 40 04             	mov    0x4(%eax),%al
  800a4f:	84 c0                	test   %al,%al
  800a51:	75 46                	jne    800a99 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a53:	a1 24 30 80 00       	mov    0x803024,%eax
  800a58:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800a5e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a61:	89 d0                	mov    %edx,%eax
  800a63:	01 c0                	add    %eax,%eax
  800a65:	01 d0                	add    %edx,%eax
  800a67:	c1 e0 02             	shl    $0x2,%eax
  800a6a:	01 c8                	add    %ecx,%eax
  800a6c:	8b 00                	mov    (%eax),%eax
  800a6e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a71:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a74:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a79:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a7e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a85:	8b 45 08             	mov    0x8(%ebp),%eax
  800a88:	01 c8                	add    %ecx,%eax
  800a8a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a8c:	39 c2                	cmp    %eax,%edx
  800a8e:	75 09                	jne    800a99 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800a90:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a97:	eb 12                	jmp    800aab <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a99:	ff 45 e8             	incl   -0x18(%ebp)
  800a9c:	a1 24 30 80 00       	mov    0x803024,%eax
  800aa1:	8b 50 74             	mov    0x74(%eax),%edx
  800aa4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800aa7:	39 c2                	cmp    %eax,%edx
  800aa9:	77 88                	ja     800a33 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800aab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800aaf:	75 14                	jne    800ac5 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800ab1:	83 ec 04             	sub    $0x4,%esp
  800ab4:	68 08 2a 80 00       	push   $0x802a08
  800ab9:	6a 3a                	push   $0x3a
  800abb:	68 fc 29 80 00       	push   $0x8029fc
  800ac0:	e8 93 fe ff ff       	call   800958 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800ac5:	ff 45 f0             	incl   -0x10(%ebp)
  800ac8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800acb:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800ace:	0f 8c 32 ff ff ff    	jl     800a06 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800ad4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800adb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800ae2:	eb 26                	jmp    800b0a <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800ae4:	a1 24 30 80 00       	mov    0x803024,%eax
  800ae9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800aef:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800af2:	89 d0                	mov    %edx,%eax
  800af4:	01 c0                	add    %eax,%eax
  800af6:	01 d0                	add    %edx,%eax
  800af8:	c1 e0 02             	shl    $0x2,%eax
  800afb:	01 c8                	add    %ecx,%eax
  800afd:	8a 40 04             	mov    0x4(%eax),%al
  800b00:	3c 01                	cmp    $0x1,%al
  800b02:	75 03                	jne    800b07 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800b04:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b07:	ff 45 e0             	incl   -0x20(%ebp)
  800b0a:	a1 24 30 80 00       	mov    0x803024,%eax
  800b0f:	8b 50 74             	mov    0x74(%eax),%edx
  800b12:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b15:	39 c2                	cmp    %eax,%edx
  800b17:	77 cb                	ja     800ae4 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b1c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b1f:	74 14                	je     800b35 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800b21:	83 ec 04             	sub    $0x4,%esp
  800b24:	68 5c 2a 80 00       	push   $0x802a5c
  800b29:	6a 44                	push   $0x44
  800b2b:	68 fc 29 80 00       	push   $0x8029fc
  800b30:	e8 23 fe ff ff       	call   800958 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800b35:	90                   	nop
  800b36:	c9                   	leave  
  800b37:	c3                   	ret    

00800b38 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800b38:	55                   	push   %ebp
  800b39:	89 e5                	mov    %esp,%ebp
  800b3b:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800b3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b41:	8b 00                	mov    (%eax),%eax
  800b43:	8d 48 01             	lea    0x1(%eax),%ecx
  800b46:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b49:	89 0a                	mov    %ecx,(%edx)
  800b4b:	8b 55 08             	mov    0x8(%ebp),%edx
  800b4e:	88 d1                	mov    %dl,%cl
  800b50:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b53:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800b57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5a:	8b 00                	mov    (%eax),%eax
  800b5c:	3d ff 00 00 00       	cmp    $0xff,%eax
  800b61:	75 2c                	jne    800b8f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800b63:	a0 28 30 80 00       	mov    0x803028,%al
  800b68:	0f b6 c0             	movzbl %al,%eax
  800b6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b6e:	8b 12                	mov    (%edx),%edx
  800b70:	89 d1                	mov    %edx,%ecx
  800b72:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b75:	83 c2 08             	add    $0x8,%edx
  800b78:	83 ec 04             	sub    $0x4,%esp
  800b7b:	50                   	push   %eax
  800b7c:	51                   	push   %ecx
  800b7d:	52                   	push   %edx
  800b7e:	e8 d4 12 00 00       	call   801e57 <sys_cputs>
  800b83:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b89:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b92:	8b 40 04             	mov    0x4(%eax),%eax
  800b95:	8d 50 01             	lea    0x1(%eax),%edx
  800b98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9b:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b9e:	90                   	nop
  800b9f:	c9                   	leave  
  800ba0:	c3                   	ret    

00800ba1 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800ba1:	55                   	push   %ebp
  800ba2:	89 e5                	mov    %esp,%ebp
  800ba4:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800baa:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800bb1:	00 00 00 
	b.cnt = 0;
  800bb4:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800bbb:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800bbe:	ff 75 0c             	pushl  0xc(%ebp)
  800bc1:	ff 75 08             	pushl  0x8(%ebp)
  800bc4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800bca:	50                   	push   %eax
  800bcb:	68 38 0b 80 00       	push   $0x800b38
  800bd0:	e8 11 02 00 00       	call   800de6 <vprintfmt>
  800bd5:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800bd8:	a0 28 30 80 00       	mov    0x803028,%al
  800bdd:	0f b6 c0             	movzbl %al,%eax
  800be0:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800be6:	83 ec 04             	sub    $0x4,%esp
  800be9:	50                   	push   %eax
  800bea:	52                   	push   %edx
  800beb:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800bf1:	83 c0 08             	add    $0x8,%eax
  800bf4:	50                   	push   %eax
  800bf5:	e8 5d 12 00 00       	call   801e57 <sys_cputs>
  800bfa:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800bfd:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800c04:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c0a:	c9                   	leave  
  800c0b:	c3                   	ret    

00800c0c <cprintf>:

int cprintf(const char *fmt, ...) {
  800c0c:	55                   	push   %ebp
  800c0d:	89 e5                	mov    %esp,%ebp
  800c0f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c12:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800c19:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c22:	83 ec 08             	sub    $0x8,%esp
  800c25:	ff 75 f4             	pushl  -0xc(%ebp)
  800c28:	50                   	push   %eax
  800c29:	e8 73 ff ff ff       	call   800ba1 <vcprintf>
  800c2e:	83 c4 10             	add    $0x10,%esp
  800c31:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800c34:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c37:	c9                   	leave  
  800c38:	c3                   	ret    

00800c39 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800c39:	55                   	push   %ebp
  800c3a:	89 e5                	mov    %esp,%ebp
  800c3c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800c3f:	e8 24 14 00 00       	call   802068 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800c44:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c47:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	83 ec 08             	sub    $0x8,%esp
  800c50:	ff 75 f4             	pushl  -0xc(%ebp)
  800c53:	50                   	push   %eax
  800c54:	e8 48 ff ff ff       	call   800ba1 <vcprintf>
  800c59:	83 c4 10             	add    $0x10,%esp
  800c5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800c5f:	e8 1e 14 00 00       	call   802082 <sys_enable_interrupt>
	return cnt;
  800c64:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c67:	c9                   	leave  
  800c68:	c3                   	ret    

00800c69 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800c69:	55                   	push   %ebp
  800c6a:	89 e5                	mov    %esp,%ebp
  800c6c:	53                   	push   %ebx
  800c6d:	83 ec 14             	sub    $0x14,%esp
  800c70:	8b 45 10             	mov    0x10(%ebp),%eax
  800c73:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c76:	8b 45 14             	mov    0x14(%ebp),%eax
  800c79:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c7c:	8b 45 18             	mov    0x18(%ebp),%eax
  800c7f:	ba 00 00 00 00       	mov    $0x0,%edx
  800c84:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c87:	77 55                	ja     800cde <printnum+0x75>
  800c89:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c8c:	72 05                	jb     800c93 <printnum+0x2a>
  800c8e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c91:	77 4b                	ja     800cde <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c93:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c96:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c99:	8b 45 18             	mov    0x18(%ebp),%eax
  800c9c:	ba 00 00 00 00       	mov    $0x0,%edx
  800ca1:	52                   	push   %edx
  800ca2:	50                   	push   %eax
  800ca3:	ff 75 f4             	pushl  -0xc(%ebp)
  800ca6:	ff 75 f0             	pushl  -0x10(%ebp)
  800ca9:	e8 9a 17 00 00       	call   802448 <__udivdi3>
  800cae:	83 c4 10             	add    $0x10,%esp
  800cb1:	83 ec 04             	sub    $0x4,%esp
  800cb4:	ff 75 20             	pushl  0x20(%ebp)
  800cb7:	53                   	push   %ebx
  800cb8:	ff 75 18             	pushl  0x18(%ebp)
  800cbb:	52                   	push   %edx
  800cbc:	50                   	push   %eax
  800cbd:	ff 75 0c             	pushl  0xc(%ebp)
  800cc0:	ff 75 08             	pushl  0x8(%ebp)
  800cc3:	e8 a1 ff ff ff       	call   800c69 <printnum>
  800cc8:	83 c4 20             	add    $0x20,%esp
  800ccb:	eb 1a                	jmp    800ce7 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ccd:	83 ec 08             	sub    $0x8,%esp
  800cd0:	ff 75 0c             	pushl  0xc(%ebp)
  800cd3:	ff 75 20             	pushl  0x20(%ebp)
  800cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd9:	ff d0                	call   *%eax
  800cdb:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800cde:	ff 4d 1c             	decl   0x1c(%ebp)
  800ce1:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800ce5:	7f e6                	jg     800ccd <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800ce7:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800cea:	bb 00 00 00 00       	mov    $0x0,%ebx
  800cef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cf2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cf5:	53                   	push   %ebx
  800cf6:	51                   	push   %ecx
  800cf7:	52                   	push   %edx
  800cf8:	50                   	push   %eax
  800cf9:	e8 5a 18 00 00       	call   802558 <__umoddi3>
  800cfe:	83 c4 10             	add    $0x10,%esp
  800d01:	05 d4 2c 80 00       	add    $0x802cd4,%eax
  800d06:	8a 00                	mov    (%eax),%al
  800d08:	0f be c0             	movsbl %al,%eax
  800d0b:	83 ec 08             	sub    $0x8,%esp
  800d0e:	ff 75 0c             	pushl  0xc(%ebp)
  800d11:	50                   	push   %eax
  800d12:	8b 45 08             	mov    0x8(%ebp),%eax
  800d15:	ff d0                	call   *%eax
  800d17:	83 c4 10             	add    $0x10,%esp
}
  800d1a:	90                   	nop
  800d1b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800d1e:	c9                   	leave  
  800d1f:	c3                   	ret    

00800d20 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800d20:	55                   	push   %ebp
  800d21:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d23:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d27:	7e 1c                	jle    800d45 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	8b 00                	mov    (%eax),%eax
  800d2e:	8d 50 08             	lea    0x8(%eax),%edx
  800d31:	8b 45 08             	mov    0x8(%ebp),%eax
  800d34:	89 10                	mov    %edx,(%eax)
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	8b 00                	mov    (%eax),%eax
  800d3b:	83 e8 08             	sub    $0x8,%eax
  800d3e:	8b 50 04             	mov    0x4(%eax),%edx
  800d41:	8b 00                	mov    (%eax),%eax
  800d43:	eb 40                	jmp    800d85 <getuint+0x65>
	else if (lflag)
  800d45:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d49:	74 1e                	je     800d69 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4e:	8b 00                	mov    (%eax),%eax
  800d50:	8d 50 04             	lea    0x4(%eax),%edx
  800d53:	8b 45 08             	mov    0x8(%ebp),%eax
  800d56:	89 10                	mov    %edx,(%eax)
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	8b 00                	mov    (%eax),%eax
  800d5d:	83 e8 04             	sub    $0x4,%eax
  800d60:	8b 00                	mov    (%eax),%eax
  800d62:	ba 00 00 00 00       	mov    $0x0,%edx
  800d67:	eb 1c                	jmp    800d85 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800d69:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6c:	8b 00                	mov    (%eax),%eax
  800d6e:	8d 50 04             	lea    0x4(%eax),%edx
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
  800d74:	89 10                	mov    %edx,(%eax)
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
  800d79:	8b 00                	mov    (%eax),%eax
  800d7b:	83 e8 04             	sub    $0x4,%eax
  800d7e:	8b 00                	mov    (%eax),%eax
  800d80:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d85:	5d                   	pop    %ebp
  800d86:	c3                   	ret    

00800d87 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d87:	55                   	push   %ebp
  800d88:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d8a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d8e:	7e 1c                	jle    800dac <getint+0x25>
		return va_arg(*ap, long long);
  800d90:	8b 45 08             	mov    0x8(%ebp),%eax
  800d93:	8b 00                	mov    (%eax),%eax
  800d95:	8d 50 08             	lea    0x8(%eax),%edx
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	89 10                	mov    %edx,(%eax)
  800d9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800da0:	8b 00                	mov    (%eax),%eax
  800da2:	83 e8 08             	sub    $0x8,%eax
  800da5:	8b 50 04             	mov    0x4(%eax),%edx
  800da8:	8b 00                	mov    (%eax),%eax
  800daa:	eb 38                	jmp    800de4 <getint+0x5d>
	else if (lflag)
  800dac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800db0:	74 1a                	je     800dcc <getint+0x45>
		return va_arg(*ap, long);
  800db2:	8b 45 08             	mov    0x8(%ebp),%eax
  800db5:	8b 00                	mov    (%eax),%eax
  800db7:	8d 50 04             	lea    0x4(%eax),%edx
  800dba:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbd:	89 10                	mov    %edx,(%eax)
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	8b 00                	mov    (%eax),%eax
  800dc4:	83 e8 04             	sub    $0x4,%eax
  800dc7:	8b 00                	mov    (%eax),%eax
  800dc9:	99                   	cltd   
  800dca:	eb 18                	jmp    800de4 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800dcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcf:	8b 00                	mov    (%eax),%eax
  800dd1:	8d 50 04             	lea    0x4(%eax),%edx
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd7:	89 10                	mov    %edx,(%eax)
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	8b 00                	mov    (%eax),%eax
  800dde:	83 e8 04             	sub    $0x4,%eax
  800de1:	8b 00                	mov    (%eax),%eax
  800de3:	99                   	cltd   
}
  800de4:	5d                   	pop    %ebp
  800de5:	c3                   	ret    

00800de6 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800de6:	55                   	push   %ebp
  800de7:	89 e5                	mov    %esp,%ebp
  800de9:	56                   	push   %esi
  800dea:	53                   	push   %ebx
  800deb:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800dee:	eb 17                	jmp    800e07 <vprintfmt+0x21>
			if (ch == '\0')
  800df0:	85 db                	test   %ebx,%ebx
  800df2:	0f 84 af 03 00 00    	je     8011a7 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800df8:	83 ec 08             	sub    $0x8,%esp
  800dfb:	ff 75 0c             	pushl  0xc(%ebp)
  800dfe:	53                   	push   %ebx
  800dff:	8b 45 08             	mov    0x8(%ebp),%eax
  800e02:	ff d0                	call   *%eax
  800e04:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e07:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0a:	8d 50 01             	lea    0x1(%eax),%edx
  800e0d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e10:	8a 00                	mov    (%eax),%al
  800e12:	0f b6 d8             	movzbl %al,%ebx
  800e15:	83 fb 25             	cmp    $0x25,%ebx
  800e18:	75 d6                	jne    800df0 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800e1a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800e1e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800e25:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800e2c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800e33:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800e3a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e3d:	8d 50 01             	lea    0x1(%eax),%edx
  800e40:	89 55 10             	mov    %edx,0x10(%ebp)
  800e43:	8a 00                	mov    (%eax),%al
  800e45:	0f b6 d8             	movzbl %al,%ebx
  800e48:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800e4b:	83 f8 55             	cmp    $0x55,%eax
  800e4e:	0f 87 2b 03 00 00    	ja     80117f <vprintfmt+0x399>
  800e54:	8b 04 85 f8 2c 80 00 	mov    0x802cf8(,%eax,4),%eax
  800e5b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800e5d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800e61:	eb d7                	jmp    800e3a <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800e63:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800e67:	eb d1                	jmp    800e3a <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e69:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e70:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e73:	89 d0                	mov    %edx,%eax
  800e75:	c1 e0 02             	shl    $0x2,%eax
  800e78:	01 d0                	add    %edx,%eax
  800e7a:	01 c0                	add    %eax,%eax
  800e7c:	01 d8                	add    %ebx,%eax
  800e7e:	83 e8 30             	sub    $0x30,%eax
  800e81:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e84:	8b 45 10             	mov    0x10(%ebp),%eax
  800e87:	8a 00                	mov    (%eax),%al
  800e89:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e8c:	83 fb 2f             	cmp    $0x2f,%ebx
  800e8f:	7e 3e                	jle    800ecf <vprintfmt+0xe9>
  800e91:	83 fb 39             	cmp    $0x39,%ebx
  800e94:	7f 39                	jg     800ecf <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e96:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e99:	eb d5                	jmp    800e70 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e9b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e9e:	83 c0 04             	add    $0x4,%eax
  800ea1:	89 45 14             	mov    %eax,0x14(%ebp)
  800ea4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea7:	83 e8 04             	sub    $0x4,%eax
  800eaa:	8b 00                	mov    (%eax),%eax
  800eac:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800eaf:	eb 1f                	jmp    800ed0 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800eb1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800eb5:	79 83                	jns    800e3a <vprintfmt+0x54>
				width = 0;
  800eb7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ebe:	e9 77 ff ff ff       	jmp    800e3a <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ec3:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800eca:	e9 6b ff ff ff       	jmp    800e3a <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ecf:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ed0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ed4:	0f 89 60 ff ff ff    	jns    800e3a <vprintfmt+0x54>
				width = precision, precision = -1;
  800eda:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800edd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ee0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ee7:	e9 4e ff ff ff       	jmp    800e3a <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800eec:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800eef:	e9 46 ff ff ff       	jmp    800e3a <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ef4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef7:	83 c0 04             	add    $0x4,%eax
  800efa:	89 45 14             	mov    %eax,0x14(%ebp)
  800efd:	8b 45 14             	mov    0x14(%ebp),%eax
  800f00:	83 e8 04             	sub    $0x4,%eax
  800f03:	8b 00                	mov    (%eax),%eax
  800f05:	83 ec 08             	sub    $0x8,%esp
  800f08:	ff 75 0c             	pushl  0xc(%ebp)
  800f0b:	50                   	push   %eax
  800f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0f:	ff d0                	call   *%eax
  800f11:	83 c4 10             	add    $0x10,%esp
			break;
  800f14:	e9 89 02 00 00       	jmp    8011a2 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800f19:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1c:	83 c0 04             	add    $0x4,%eax
  800f1f:	89 45 14             	mov    %eax,0x14(%ebp)
  800f22:	8b 45 14             	mov    0x14(%ebp),%eax
  800f25:	83 e8 04             	sub    $0x4,%eax
  800f28:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800f2a:	85 db                	test   %ebx,%ebx
  800f2c:	79 02                	jns    800f30 <vprintfmt+0x14a>
				err = -err;
  800f2e:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800f30:	83 fb 64             	cmp    $0x64,%ebx
  800f33:	7f 0b                	jg     800f40 <vprintfmt+0x15a>
  800f35:	8b 34 9d 40 2b 80 00 	mov    0x802b40(,%ebx,4),%esi
  800f3c:	85 f6                	test   %esi,%esi
  800f3e:	75 19                	jne    800f59 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800f40:	53                   	push   %ebx
  800f41:	68 e5 2c 80 00       	push   $0x802ce5
  800f46:	ff 75 0c             	pushl  0xc(%ebp)
  800f49:	ff 75 08             	pushl  0x8(%ebp)
  800f4c:	e8 5e 02 00 00       	call   8011af <printfmt>
  800f51:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800f54:	e9 49 02 00 00       	jmp    8011a2 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800f59:	56                   	push   %esi
  800f5a:	68 ee 2c 80 00       	push   $0x802cee
  800f5f:	ff 75 0c             	pushl  0xc(%ebp)
  800f62:	ff 75 08             	pushl  0x8(%ebp)
  800f65:	e8 45 02 00 00       	call   8011af <printfmt>
  800f6a:	83 c4 10             	add    $0x10,%esp
			break;
  800f6d:	e9 30 02 00 00       	jmp    8011a2 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f72:	8b 45 14             	mov    0x14(%ebp),%eax
  800f75:	83 c0 04             	add    $0x4,%eax
  800f78:	89 45 14             	mov    %eax,0x14(%ebp)
  800f7b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f7e:	83 e8 04             	sub    $0x4,%eax
  800f81:	8b 30                	mov    (%eax),%esi
  800f83:	85 f6                	test   %esi,%esi
  800f85:	75 05                	jne    800f8c <vprintfmt+0x1a6>
				p = "(null)";
  800f87:	be f1 2c 80 00       	mov    $0x802cf1,%esi
			if (width > 0 && padc != '-')
  800f8c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f90:	7e 6d                	jle    800fff <vprintfmt+0x219>
  800f92:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f96:	74 67                	je     800fff <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f98:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f9b:	83 ec 08             	sub    $0x8,%esp
  800f9e:	50                   	push   %eax
  800f9f:	56                   	push   %esi
  800fa0:	e8 12 05 00 00       	call   8014b7 <strnlen>
  800fa5:	83 c4 10             	add    $0x10,%esp
  800fa8:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800fab:	eb 16                	jmp    800fc3 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800fad:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800fb1:	83 ec 08             	sub    $0x8,%esp
  800fb4:	ff 75 0c             	pushl  0xc(%ebp)
  800fb7:	50                   	push   %eax
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	ff d0                	call   *%eax
  800fbd:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800fc0:	ff 4d e4             	decl   -0x1c(%ebp)
  800fc3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fc7:	7f e4                	jg     800fad <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800fc9:	eb 34                	jmp    800fff <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800fcb:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800fcf:	74 1c                	je     800fed <vprintfmt+0x207>
  800fd1:	83 fb 1f             	cmp    $0x1f,%ebx
  800fd4:	7e 05                	jle    800fdb <vprintfmt+0x1f5>
  800fd6:	83 fb 7e             	cmp    $0x7e,%ebx
  800fd9:	7e 12                	jle    800fed <vprintfmt+0x207>
					putch('?', putdat);
  800fdb:	83 ec 08             	sub    $0x8,%esp
  800fde:	ff 75 0c             	pushl  0xc(%ebp)
  800fe1:	6a 3f                	push   $0x3f
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	ff d0                	call   *%eax
  800fe8:	83 c4 10             	add    $0x10,%esp
  800feb:	eb 0f                	jmp    800ffc <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800fed:	83 ec 08             	sub    $0x8,%esp
  800ff0:	ff 75 0c             	pushl  0xc(%ebp)
  800ff3:	53                   	push   %ebx
  800ff4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff7:	ff d0                	call   *%eax
  800ff9:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ffc:	ff 4d e4             	decl   -0x1c(%ebp)
  800fff:	89 f0                	mov    %esi,%eax
  801001:	8d 70 01             	lea    0x1(%eax),%esi
  801004:	8a 00                	mov    (%eax),%al
  801006:	0f be d8             	movsbl %al,%ebx
  801009:	85 db                	test   %ebx,%ebx
  80100b:	74 24                	je     801031 <vprintfmt+0x24b>
  80100d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801011:	78 b8                	js     800fcb <vprintfmt+0x1e5>
  801013:	ff 4d e0             	decl   -0x20(%ebp)
  801016:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80101a:	79 af                	jns    800fcb <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80101c:	eb 13                	jmp    801031 <vprintfmt+0x24b>
				putch(' ', putdat);
  80101e:	83 ec 08             	sub    $0x8,%esp
  801021:	ff 75 0c             	pushl  0xc(%ebp)
  801024:	6a 20                	push   $0x20
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	ff d0                	call   *%eax
  80102b:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80102e:	ff 4d e4             	decl   -0x1c(%ebp)
  801031:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801035:	7f e7                	jg     80101e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801037:	e9 66 01 00 00       	jmp    8011a2 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80103c:	83 ec 08             	sub    $0x8,%esp
  80103f:	ff 75 e8             	pushl  -0x18(%ebp)
  801042:	8d 45 14             	lea    0x14(%ebp),%eax
  801045:	50                   	push   %eax
  801046:	e8 3c fd ff ff       	call   800d87 <getint>
  80104b:	83 c4 10             	add    $0x10,%esp
  80104e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801051:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801054:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801057:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80105a:	85 d2                	test   %edx,%edx
  80105c:	79 23                	jns    801081 <vprintfmt+0x29b>
				putch('-', putdat);
  80105e:	83 ec 08             	sub    $0x8,%esp
  801061:	ff 75 0c             	pushl  0xc(%ebp)
  801064:	6a 2d                	push   $0x2d
  801066:	8b 45 08             	mov    0x8(%ebp),%eax
  801069:	ff d0                	call   *%eax
  80106b:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80106e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801071:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801074:	f7 d8                	neg    %eax
  801076:	83 d2 00             	adc    $0x0,%edx
  801079:	f7 da                	neg    %edx
  80107b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80107e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801081:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801088:	e9 bc 00 00 00       	jmp    801149 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80108d:	83 ec 08             	sub    $0x8,%esp
  801090:	ff 75 e8             	pushl  -0x18(%ebp)
  801093:	8d 45 14             	lea    0x14(%ebp),%eax
  801096:	50                   	push   %eax
  801097:	e8 84 fc ff ff       	call   800d20 <getuint>
  80109c:	83 c4 10             	add    $0x10,%esp
  80109f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010a2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8010a5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8010ac:	e9 98 00 00 00       	jmp    801149 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8010b1:	83 ec 08             	sub    $0x8,%esp
  8010b4:	ff 75 0c             	pushl  0xc(%ebp)
  8010b7:	6a 58                	push   $0x58
  8010b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bc:	ff d0                	call   *%eax
  8010be:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8010c1:	83 ec 08             	sub    $0x8,%esp
  8010c4:	ff 75 0c             	pushl  0xc(%ebp)
  8010c7:	6a 58                	push   $0x58
  8010c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cc:	ff d0                	call   *%eax
  8010ce:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8010d1:	83 ec 08             	sub    $0x8,%esp
  8010d4:	ff 75 0c             	pushl  0xc(%ebp)
  8010d7:	6a 58                	push   $0x58
  8010d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010dc:	ff d0                	call   *%eax
  8010de:	83 c4 10             	add    $0x10,%esp
			break;
  8010e1:	e9 bc 00 00 00       	jmp    8011a2 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8010e6:	83 ec 08             	sub    $0x8,%esp
  8010e9:	ff 75 0c             	pushl  0xc(%ebp)
  8010ec:	6a 30                	push   $0x30
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f1:	ff d0                	call   *%eax
  8010f3:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8010f6:	83 ec 08             	sub    $0x8,%esp
  8010f9:	ff 75 0c             	pushl  0xc(%ebp)
  8010fc:	6a 78                	push   $0x78
  8010fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801101:	ff d0                	call   *%eax
  801103:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801106:	8b 45 14             	mov    0x14(%ebp),%eax
  801109:	83 c0 04             	add    $0x4,%eax
  80110c:	89 45 14             	mov    %eax,0x14(%ebp)
  80110f:	8b 45 14             	mov    0x14(%ebp),%eax
  801112:	83 e8 04             	sub    $0x4,%eax
  801115:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801117:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80111a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801121:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801128:	eb 1f                	jmp    801149 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80112a:	83 ec 08             	sub    $0x8,%esp
  80112d:	ff 75 e8             	pushl  -0x18(%ebp)
  801130:	8d 45 14             	lea    0x14(%ebp),%eax
  801133:	50                   	push   %eax
  801134:	e8 e7 fb ff ff       	call   800d20 <getuint>
  801139:	83 c4 10             	add    $0x10,%esp
  80113c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80113f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801142:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801149:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80114d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801150:	83 ec 04             	sub    $0x4,%esp
  801153:	52                   	push   %edx
  801154:	ff 75 e4             	pushl  -0x1c(%ebp)
  801157:	50                   	push   %eax
  801158:	ff 75 f4             	pushl  -0xc(%ebp)
  80115b:	ff 75 f0             	pushl  -0x10(%ebp)
  80115e:	ff 75 0c             	pushl  0xc(%ebp)
  801161:	ff 75 08             	pushl  0x8(%ebp)
  801164:	e8 00 fb ff ff       	call   800c69 <printnum>
  801169:	83 c4 20             	add    $0x20,%esp
			break;
  80116c:	eb 34                	jmp    8011a2 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80116e:	83 ec 08             	sub    $0x8,%esp
  801171:	ff 75 0c             	pushl  0xc(%ebp)
  801174:	53                   	push   %ebx
  801175:	8b 45 08             	mov    0x8(%ebp),%eax
  801178:	ff d0                	call   *%eax
  80117a:	83 c4 10             	add    $0x10,%esp
			break;
  80117d:	eb 23                	jmp    8011a2 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80117f:	83 ec 08             	sub    $0x8,%esp
  801182:	ff 75 0c             	pushl  0xc(%ebp)
  801185:	6a 25                	push   $0x25
  801187:	8b 45 08             	mov    0x8(%ebp),%eax
  80118a:	ff d0                	call   *%eax
  80118c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80118f:	ff 4d 10             	decl   0x10(%ebp)
  801192:	eb 03                	jmp    801197 <vprintfmt+0x3b1>
  801194:	ff 4d 10             	decl   0x10(%ebp)
  801197:	8b 45 10             	mov    0x10(%ebp),%eax
  80119a:	48                   	dec    %eax
  80119b:	8a 00                	mov    (%eax),%al
  80119d:	3c 25                	cmp    $0x25,%al
  80119f:	75 f3                	jne    801194 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8011a1:	90                   	nop
		}
	}
  8011a2:	e9 47 fc ff ff       	jmp    800dee <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8011a7:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8011a8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8011ab:	5b                   	pop    %ebx
  8011ac:	5e                   	pop    %esi
  8011ad:	5d                   	pop    %ebp
  8011ae:	c3                   	ret    

008011af <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8011af:	55                   	push   %ebp
  8011b0:	89 e5                	mov    %esp,%ebp
  8011b2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8011b5:	8d 45 10             	lea    0x10(%ebp),%eax
  8011b8:	83 c0 04             	add    $0x4,%eax
  8011bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8011be:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c1:	ff 75 f4             	pushl  -0xc(%ebp)
  8011c4:	50                   	push   %eax
  8011c5:	ff 75 0c             	pushl  0xc(%ebp)
  8011c8:	ff 75 08             	pushl  0x8(%ebp)
  8011cb:	e8 16 fc ff ff       	call   800de6 <vprintfmt>
  8011d0:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8011d3:	90                   	nop
  8011d4:	c9                   	leave  
  8011d5:	c3                   	ret    

008011d6 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8011d6:	55                   	push   %ebp
  8011d7:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8011d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dc:	8b 40 08             	mov    0x8(%eax),%eax
  8011df:	8d 50 01             	lea    0x1(%eax),%edx
  8011e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e5:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8011e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011eb:	8b 10                	mov    (%eax),%edx
  8011ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f0:	8b 40 04             	mov    0x4(%eax),%eax
  8011f3:	39 c2                	cmp    %eax,%edx
  8011f5:	73 12                	jae    801209 <sprintputch+0x33>
		*b->buf++ = ch;
  8011f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fa:	8b 00                	mov    (%eax),%eax
  8011fc:	8d 48 01             	lea    0x1(%eax),%ecx
  8011ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801202:	89 0a                	mov    %ecx,(%edx)
  801204:	8b 55 08             	mov    0x8(%ebp),%edx
  801207:	88 10                	mov    %dl,(%eax)
}
  801209:	90                   	nop
  80120a:	5d                   	pop    %ebp
  80120b:	c3                   	ret    

0080120c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80120c:	55                   	push   %ebp
  80120d:	89 e5                	mov    %esp,%ebp
  80120f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801212:	8b 45 08             	mov    0x8(%ebp),%eax
  801215:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801218:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80121e:	8b 45 08             	mov    0x8(%ebp),%eax
  801221:	01 d0                	add    %edx,%eax
  801223:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801226:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80122d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801231:	74 06                	je     801239 <vsnprintf+0x2d>
  801233:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801237:	7f 07                	jg     801240 <vsnprintf+0x34>
		return -E_INVAL;
  801239:	b8 03 00 00 00       	mov    $0x3,%eax
  80123e:	eb 20                	jmp    801260 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801240:	ff 75 14             	pushl  0x14(%ebp)
  801243:	ff 75 10             	pushl  0x10(%ebp)
  801246:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801249:	50                   	push   %eax
  80124a:	68 d6 11 80 00       	push   $0x8011d6
  80124f:	e8 92 fb ff ff       	call   800de6 <vprintfmt>
  801254:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801257:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80125a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80125d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801260:	c9                   	leave  
  801261:	c3                   	ret    

00801262 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801262:	55                   	push   %ebp
  801263:	89 e5                	mov    %esp,%ebp
  801265:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801268:	8d 45 10             	lea    0x10(%ebp),%eax
  80126b:	83 c0 04             	add    $0x4,%eax
  80126e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801271:	8b 45 10             	mov    0x10(%ebp),%eax
  801274:	ff 75 f4             	pushl  -0xc(%ebp)
  801277:	50                   	push   %eax
  801278:	ff 75 0c             	pushl  0xc(%ebp)
  80127b:	ff 75 08             	pushl  0x8(%ebp)
  80127e:	e8 89 ff ff ff       	call   80120c <vsnprintf>
  801283:	83 c4 10             	add    $0x10,%esp
  801286:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801289:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80128c:	c9                   	leave  
  80128d:	c3                   	ret    

0080128e <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80128e:	55                   	push   %ebp
  80128f:	89 e5                	mov    %esp,%ebp
  801291:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801294:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801298:	74 13                	je     8012ad <readline+0x1f>
		cprintf("%s", prompt);
  80129a:	83 ec 08             	sub    $0x8,%esp
  80129d:	ff 75 08             	pushl  0x8(%ebp)
  8012a0:	68 50 2e 80 00       	push   $0x802e50
  8012a5:	e8 62 f9 ff ff       	call   800c0c <cprintf>
  8012aa:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8012ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8012b4:	83 ec 0c             	sub    $0xc,%esp
  8012b7:	6a 00                	push   $0x0
  8012b9:	e8 8e f5 ff ff       	call   80084c <iscons>
  8012be:	83 c4 10             	add    $0x10,%esp
  8012c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8012c4:	e8 35 f5 ff ff       	call   8007fe <getchar>
  8012c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8012cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8012d0:	79 22                	jns    8012f4 <readline+0x66>
			if (c != -E_EOF)
  8012d2:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8012d6:	0f 84 ad 00 00 00    	je     801389 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8012dc:	83 ec 08             	sub    $0x8,%esp
  8012df:	ff 75 ec             	pushl  -0x14(%ebp)
  8012e2:	68 53 2e 80 00       	push   $0x802e53
  8012e7:	e8 20 f9 ff ff       	call   800c0c <cprintf>
  8012ec:	83 c4 10             	add    $0x10,%esp
			return;
  8012ef:	e9 95 00 00 00       	jmp    801389 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8012f4:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8012f8:	7e 34                	jle    80132e <readline+0xa0>
  8012fa:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801301:	7f 2b                	jg     80132e <readline+0xa0>
			if (echoing)
  801303:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801307:	74 0e                	je     801317 <readline+0x89>
				cputchar(c);
  801309:	83 ec 0c             	sub    $0xc,%esp
  80130c:	ff 75 ec             	pushl  -0x14(%ebp)
  80130f:	e8 a2 f4 ff ff       	call   8007b6 <cputchar>
  801314:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801317:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80131a:	8d 50 01             	lea    0x1(%eax),%edx
  80131d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801320:	89 c2                	mov    %eax,%edx
  801322:	8b 45 0c             	mov    0xc(%ebp),%eax
  801325:	01 d0                	add    %edx,%eax
  801327:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80132a:	88 10                	mov    %dl,(%eax)
  80132c:	eb 56                	jmp    801384 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80132e:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801332:	75 1f                	jne    801353 <readline+0xc5>
  801334:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801338:	7e 19                	jle    801353 <readline+0xc5>
			if (echoing)
  80133a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80133e:	74 0e                	je     80134e <readline+0xc0>
				cputchar(c);
  801340:	83 ec 0c             	sub    $0xc,%esp
  801343:	ff 75 ec             	pushl  -0x14(%ebp)
  801346:	e8 6b f4 ff ff       	call   8007b6 <cputchar>
  80134b:	83 c4 10             	add    $0x10,%esp

			i--;
  80134e:	ff 4d f4             	decl   -0xc(%ebp)
  801351:	eb 31                	jmp    801384 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801353:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801357:	74 0a                	je     801363 <readline+0xd5>
  801359:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80135d:	0f 85 61 ff ff ff    	jne    8012c4 <readline+0x36>
			if (echoing)
  801363:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801367:	74 0e                	je     801377 <readline+0xe9>
				cputchar(c);
  801369:	83 ec 0c             	sub    $0xc,%esp
  80136c:	ff 75 ec             	pushl  -0x14(%ebp)
  80136f:	e8 42 f4 ff ff       	call   8007b6 <cputchar>
  801374:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801377:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80137a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137d:	01 d0                	add    %edx,%eax
  80137f:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801382:	eb 06                	jmp    80138a <readline+0xfc>
		}
	}
  801384:	e9 3b ff ff ff       	jmp    8012c4 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801389:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80138a:	c9                   	leave  
  80138b:	c3                   	ret    

0080138c <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  80138c:	55                   	push   %ebp
  80138d:	89 e5                	mov    %esp,%ebp
  80138f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801392:	e8 d1 0c 00 00       	call   802068 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801397:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80139b:	74 13                	je     8013b0 <atomic_readline+0x24>
		cprintf("%s", prompt);
  80139d:	83 ec 08             	sub    $0x8,%esp
  8013a0:	ff 75 08             	pushl  0x8(%ebp)
  8013a3:	68 50 2e 80 00       	push   $0x802e50
  8013a8:	e8 5f f8 ff ff       	call   800c0c <cprintf>
  8013ad:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8013b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8013b7:	83 ec 0c             	sub    $0xc,%esp
  8013ba:	6a 00                	push   $0x0
  8013bc:	e8 8b f4 ff ff       	call   80084c <iscons>
  8013c1:	83 c4 10             	add    $0x10,%esp
  8013c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8013c7:	e8 32 f4 ff ff       	call   8007fe <getchar>
  8013cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8013cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8013d3:	79 23                	jns    8013f8 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8013d5:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8013d9:	74 13                	je     8013ee <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8013db:	83 ec 08             	sub    $0x8,%esp
  8013de:	ff 75 ec             	pushl  -0x14(%ebp)
  8013e1:	68 53 2e 80 00       	push   $0x802e53
  8013e6:	e8 21 f8 ff ff       	call   800c0c <cprintf>
  8013eb:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8013ee:	e8 8f 0c 00 00       	call   802082 <sys_enable_interrupt>
			return;
  8013f3:	e9 9a 00 00 00       	jmp    801492 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8013f8:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8013fc:	7e 34                	jle    801432 <atomic_readline+0xa6>
  8013fe:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801405:	7f 2b                	jg     801432 <atomic_readline+0xa6>
			if (echoing)
  801407:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80140b:	74 0e                	je     80141b <atomic_readline+0x8f>
				cputchar(c);
  80140d:	83 ec 0c             	sub    $0xc,%esp
  801410:	ff 75 ec             	pushl  -0x14(%ebp)
  801413:	e8 9e f3 ff ff       	call   8007b6 <cputchar>
  801418:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80141b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80141e:	8d 50 01             	lea    0x1(%eax),%edx
  801421:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801424:	89 c2                	mov    %eax,%edx
  801426:	8b 45 0c             	mov    0xc(%ebp),%eax
  801429:	01 d0                	add    %edx,%eax
  80142b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80142e:	88 10                	mov    %dl,(%eax)
  801430:	eb 5b                	jmp    80148d <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801432:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801436:	75 1f                	jne    801457 <atomic_readline+0xcb>
  801438:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80143c:	7e 19                	jle    801457 <atomic_readline+0xcb>
			if (echoing)
  80143e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801442:	74 0e                	je     801452 <atomic_readline+0xc6>
				cputchar(c);
  801444:	83 ec 0c             	sub    $0xc,%esp
  801447:	ff 75 ec             	pushl  -0x14(%ebp)
  80144a:	e8 67 f3 ff ff       	call   8007b6 <cputchar>
  80144f:	83 c4 10             	add    $0x10,%esp
			i--;
  801452:	ff 4d f4             	decl   -0xc(%ebp)
  801455:	eb 36                	jmp    80148d <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801457:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80145b:	74 0a                	je     801467 <atomic_readline+0xdb>
  80145d:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801461:	0f 85 60 ff ff ff    	jne    8013c7 <atomic_readline+0x3b>
			if (echoing)
  801467:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80146b:	74 0e                	je     80147b <atomic_readline+0xef>
				cputchar(c);
  80146d:	83 ec 0c             	sub    $0xc,%esp
  801470:	ff 75 ec             	pushl  -0x14(%ebp)
  801473:	e8 3e f3 ff ff       	call   8007b6 <cputchar>
  801478:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  80147b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80147e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801481:	01 d0                	add    %edx,%eax
  801483:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801486:	e8 f7 0b 00 00       	call   802082 <sys_enable_interrupt>
			return;
  80148b:	eb 05                	jmp    801492 <atomic_readline+0x106>
		}
	}
  80148d:	e9 35 ff ff ff       	jmp    8013c7 <atomic_readline+0x3b>
}
  801492:	c9                   	leave  
  801493:	c3                   	ret    

00801494 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801494:	55                   	push   %ebp
  801495:	89 e5                	mov    %esp,%ebp
  801497:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80149a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014a1:	eb 06                	jmp    8014a9 <strlen+0x15>
		n++;
  8014a3:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8014a6:	ff 45 08             	incl   0x8(%ebp)
  8014a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ac:	8a 00                	mov    (%eax),%al
  8014ae:	84 c0                	test   %al,%al
  8014b0:	75 f1                	jne    8014a3 <strlen+0xf>
		n++;
	return n;
  8014b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014b5:	c9                   	leave  
  8014b6:	c3                   	ret    

008014b7 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8014b7:	55                   	push   %ebp
  8014b8:	89 e5                	mov    %esp,%ebp
  8014ba:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8014bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014c4:	eb 09                	jmp    8014cf <strnlen+0x18>
		n++;
  8014c6:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8014c9:	ff 45 08             	incl   0x8(%ebp)
  8014cc:	ff 4d 0c             	decl   0xc(%ebp)
  8014cf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014d3:	74 09                	je     8014de <strnlen+0x27>
  8014d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d8:	8a 00                	mov    (%eax),%al
  8014da:	84 c0                	test   %al,%al
  8014dc:	75 e8                	jne    8014c6 <strnlen+0xf>
		n++;
	return n;
  8014de:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014e1:	c9                   	leave  
  8014e2:	c3                   	ret    

008014e3 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8014e3:	55                   	push   %ebp
  8014e4:	89 e5                	mov    %esp,%ebp
  8014e6:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8014e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8014ef:	90                   	nop
  8014f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f3:	8d 50 01             	lea    0x1(%eax),%edx
  8014f6:	89 55 08             	mov    %edx,0x8(%ebp)
  8014f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014fc:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014ff:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801502:	8a 12                	mov    (%edx),%dl
  801504:	88 10                	mov    %dl,(%eax)
  801506:	8a 00                	mov    (%eax),%al
  801508:	84 c0                	test   %al,%al
  80150a:	75 e4                	jne    8014f0 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80150c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80150f:	c9                   	leave  
  801510:	c3                   	ret    

00801511 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801511:	55                   	push   %ebp
  801512:	89 e5                	mov    %esp,%ebp
  801514:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801517:	8b 45 08             	mov    0x8(%ebp),%eax
  80151a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80151d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801524:	eb 1f                	jmp    801545 <strncpy+0x34>
		*dst++ = *src;
  801526:	8b 45 08             	mov    0x8(%ebp),%eax
  801529:	8d 50 01             	lea    0x1(%eax),%edx
  80152c:	89 55 08             	mov    %edx,0x8(%ebp)
  80152f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801532:	8a 12                	mov    (%edx),%dl
  801534:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801536:	8b 45 0c             	mov    0xc(%ebp),%eax
  801539:	8a 00                	mov    (%eax),%al
  80153b:	84 c0                	test   %al,%al
  80153d:	74 03                	je     801542 <strncpy+0x31>
			src++;
  80153f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801542:	ff 45 fc             	incl   -0x4(%ebp)
  801545:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801548:	3b 45 10             	cmp    0x10(%ebp),%eax
  80154b:	72 d9                	jb     801526 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80154d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801550:	c9                   	leave  
  801551:	c3                   	ret    

00801552 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801552:	55                   	push   %ebp
  801553:	89 e5                	mov    %esp,%ebp
  801555:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801558:	8b 45 08             	mov    0x8(%ebp),%eax
  80155b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80155e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801562:	74 30                	je     801594 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801564:	eb 16                	jmp    80157c <strlcpy+0x2a>
			*dst++ = *src++;
  801566:	8b 45 08             	mov    0x8(%ebp),%eax
  801569:	8d 50 01             	lea    0x1(%eax),%edx
  80156c:	89 55 08             	mov    %edx,0x8(%ebp)
  80156f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801572:	8d 4a 01             	lea    0x1(%edx),%ecx
  801575:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801578:	8a 12                	mov    (%edx),%dl
  80157a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80157c:	ff 4d 10             	decl   0x10(%ebp)
  80157f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801583:	74 09                	je     80158e <strlcpy+0x3c>
  801585:	8b 45 0c             	mov    0xc(%ebp),%eax
  801588:	8a 00                	mov    (%eax),%al
  80158a:	84 c0                	test   %al,%al
  80158c:	75 d8                	jne    801566 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80158e:	8b 45 08             	mov    0x8(%ebp),%eax
  801591:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801594:	8b 55 08             	mov    0x8(%ebp),%edx
  801597:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80159a:	29 c2                	sub    %eax,%edx
  80159c:	89 d0                	mov    %edx,%eax
}
  80159e:	c9                   	leave  
  80159f:	c3                   	ret    

008015a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8015a0:	55                   	push   %ebp
  8015a1:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8015a3:	eb 06                	jmp    8015ab <strcmp+0xb>
		p++, q++;
  8015a5:	ff 45 08             	incl   0x8(%ebp)
  8015a8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8015ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ae:	8a 00                	mov    (%eax),%al
  8015b0:	84 c0                	test   %al,%al
  8015b2:	74 0e                	je     8015c2 <strcmp+0x22>
  8015b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b7:	8a 10                	mov    (%eax),%dl
  8015b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015bc:	8a 00                	mov    (%eax),%al
  8015be:	38 c2                	cmp    %al,%dl
  8015c0:	74 e3                	je     8015a5 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	8a 00                	mov    (%eax),%al
  8015c7:	0f b6 d0             	movzbl %al,%edx
  8015ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015cd:	8a 00                	mov    (%eax),%al
  8015cf:	0f b6 c0             	movzbl %al,%eax
  8015d2:	29 c2                	sub    %eax,%edx
  8015d4:	89 d0                	mov    %edx,%eax
}
  8015d6:	5d                   	pop    %ebp
  8015d7:	c3                   	ret    

008015d8 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8015d8:	55                   	push   %ebp
  8015d9:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8015db:	eb 09                	jmp    8015e6 <strncmp+0xe>
		n--, p++, q++;
  8015dd:	ff 4d 10             	decl   0x10(%ebp)
  8015e0:	ff 45 08             	incl   0x8(%ebp)
  8015e3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8015e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015ea:	74 17                	je     801603 <strncmp+0x2b>
  8015ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ef:	8a 00                	mov    (%eax),%al
  8015f1:	84 c0                	test   %al,%al
  8015f3:	74 0e                	je     801603 <strncmp+0x2b>
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f8:	8a 10                	mov    (%eax),%dl
  8015fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015fd:	8a 00                	mov    (%eax),%al
  8015ff:	38 c2                	cmp    %al,%dl
  801601:	74 da                	je     8015dd <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801603:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801607:	75 07                	jne    801610 <strncmp+0x38>
		return 0;
  801609:	b8 00 00 00 00       	mov    $0x0,%eax
  80160e:	eb 14                	jmp    801624 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801610:	8b 45 08             	mov    0x8(%ebp),%eax
  801613:	8a 00                	mov    (%eax),%al
  801615:	0f b6 d0             	movzbl %al,%edx
  801618:	8b 45 0c             	mov    0xc(%ebp),%eax
  80161b:	8a 00                	mov    (%eax),%al
  80161d:	0f b6 c0             	movzbl %al,%eax
  801620:	29 c2                	sub    %eax,%edx
  801622:	89 d0                	mov    %edx,%eax
}
  801624:	5d                   	pop    %ebp
  801625:	c3                   	ret    

00801626 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801626:	55                   	push   %ebp
  801627:	89 e5                	mov    %esp,%ebp
  801629:	83 ec 04             	sub    $0x4,%esp
  80162c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80162f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801632:	eb 12                	jmp    801646 <strchr+0x20>
		if (*s == c)
  801634:	8b 45 08             	mov    0x8(%ebp),%eax
  801637:	8a 00                	mov    (%eax),%al
  801639:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80163c:	75 05                	jne    801643 <strchr+0x1d>
			return (char *) s;
  80163e:	8b 45 08             	mov    0x8(%ebp),%eax
  801641:	eb 11                	jmp    801654 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801643:	ff 45 08             	incl   0x8(%ebp)
  801646:	8b 45 08             	mov    0x8(%ebp),%eax
  801649:	8a 00                	mov    (%eax),%al
  80164b:	84 c0                	test   %al,%al
  80164d:	75 e5                	jne    801634 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80164f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
  801659:	83 ec 04             	sub    $0x4,%esp
  80165c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80165f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801662:	eb 0d                	jmp    801671 <strfind+0x1b>
		if (*s == c)
  801664:	8b 45 08             	mov    0x8(%ebp),%eax
  801667:	8a 00                	mov    (%eax),%al
  801669:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80166c:	74 0e                	je     80167c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80166e:	ff 45 08             	incl   0x8(%ebp)
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	84 c0                	test   %al,%al
  801678:	75 ea                	jne    801664 <strfind+0xe>
  80167a:	eb 01                	jmp    80167d <strfind+0x27>
		if (*s == c)
			break;
  80167c:	90                   	nop
	return (char *) s;
  80167d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801680:	c9                   	leave  
  801681:	c3                   	ret    

00801682 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801682:	55                   	push   %ebp
  801683:	89 e5                	mov    %esp,%ebp
  801685:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801688:	8b 45 08             	mov    0x8(%ebp),%eax
  80168b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80168e:	8b 45 10             	mov    0x10(%ebp),%eax
  801691:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801694:	eb 0e                	jmp    8016a4 <memset+0x22>
		*p++ = c;
  801696:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801699:	8d 50 01             	lea    0x1(%eax),%edx
  80169c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80169f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016a2:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8016a4:	ff 4d f8             	decl   -0x8(%ebp)
  8016a7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8016ab:	79 e9                	jns    801696 <memset+0x14>
		*p++ = c;

	return v;
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016b0:	c9                   	leave  
  8016b1:	c3                   	ret    

008016b2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8016b2:	55                   	push   %ebp
  8016b3:	89 e5                	mov    %esp,%ebp
  8016b5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8016b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8016be:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8016c4:	eb 16                	jmp    8016dc <memcpy+0x2a>
		*d++ = *s++;
  8016c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c9:	8d 50 01             	lea    0x1(%eax),%edx
  8016cc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016d2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016d5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016d8:	8a 12                	mov    (%edx),%dl
  8016da:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8016dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8016df:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016e2:	89 55 10             	mov    %edx,0x10(%ebp)
  8016e5:	85 c0                	test   %eax,%eax
  8016e7:	75 dd                	jne    8016c6 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016ec:	c9                   	leave  
  8016ed:	c3                   	ret    

008016ee <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8016ee:	55                   	push   %ebp
  8016ef:	89 e5                	mov    %esp,%ebp
  8016f1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8016f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8016fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801700:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801703:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801706:	73 50                	jae    801758 <memmove+0x6a>
  801708:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80170b:	8b 45 10             	mov    0x10(%ebp),%eax
  80170e:	01 d0                	add    %edx,%eax
  801710:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801713:	76 43                	jbe    801758 <memmove+0x6a>
		s += n;
  801715:	8b 45 10             	mov    0x10(%ebp),%eax
  801718:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80171b:	8b 45 10             	mov    0x10(%ebp),%eax
  80171e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801721:	eb 10                	jmp    801733 <memmove+0x45>
			*--d = *--s;
  801723:	ff 4d f8             	decl   -0x8(%ebp)
  801726:	ff 4d fc             	decl   -0x4(%ebp)
  801729:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80172c:	8a 10                	mov    (%eax),%dl
  80172e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801731:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801733:	8b 45 10             	mov    0x10(%ebp),%eax
  801736:	8d 50 ff             	lea    -0x1(%eax),%edx
  801739:	89 55 10             	mov    %edx,0x10(%ebp)
  80173c:	85 c0                	test   %eax,%eax
  80173e:	75 e3                	jne    801723 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801740:	eb 23                	jmp    801765 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801742:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801745:	8d 50 01             	lea    0x1(%eax),%edx
  801748:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80174b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80174e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801751:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801754:	8a 12                	mov    (%edx),%dl
  801756:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801758:	8b 45 10             	mov    0x10(%ebp),%eax
  80175b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80175e:	89 55 10             	mov    %edx,0x10(%ebp)
  801761:	85 c0                	test   %eax,%eax
  801763:	75 dd                	jne    801742 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801765:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
  80176d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801770:	8b 45 08             	mov    0x8(%ebp),%eax
  801773:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801776:	8b 45 0c             	mov    0xc(%ebp),%eax
  801779:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80177c:	eb 2a                	jmp    8017a8 <memcmp+0x3e>
		if (*s1 != *s2)
  80177e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801781:	8a 10                	mov    (%eax),%dl
  801783:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801786:	8a 00                	mov    (%eax),%al
  801788:	38 c2                	cmp    %al,%dl
  80178a:	74 16                	je     8017a2 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80178c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80178f:	8a 00                	mov    (%eax),%al
  801791:	0f b6 d0             	movzbl %al,%edx
  801794:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801797:	8a 00                	mov    (%eax),%al
  801799:	0f b6 c0             	movzbl %al,%eax
  80179c:	29 c2                	sub    %eax,%edx
  80179e:	89 d0                	mov    %edx,%eax
  8017a0:	eb 18                	jmp    8017ba <memcmp+0x50>
		s1++, s2++;
  8017a2:	ff 45 fc             	incl   -0x4(%ebp)
  8017a5:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8017a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ab:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017ae:	89 55 10             	mov    %edx,0x10(%ebp)
  8017b1:	85 c0                	test   %eax,%eax
  8017b3:	75 c9                	jne    80177e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8017b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
  8017bf:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8017c2:	8b 55 08             	mov    0x8(%ebp),%edx
  8017c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8017c8:	01 d0                	add    %edx,%eax
  8017ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8017cd:	eb 15                	jmp    8017e4 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8017cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d2:	8a 00                	mov    (%eax),%al
  8017d4:	0f b6 d0             	movzbl %al,%edx
  8017d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017da:	0f b6 c0             	movzbl %al,%eax
  8017dd:	39 c2                	cmp    %eax,%edx
  8017df:	74 0d                	je     8017ee <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8017e1:	ff 45 08             	incl   0x8(%ebp)
  8017e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8017ea:	72 e3                	jb     8017cf <memfind+0x13>
  8017ec:	eb 01                	jmp    8017ef <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8017ee:	90                   	nop
	return (void *) s;
  8017ef:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
  8017f7:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8017fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801801:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801808:	eb 03                	jmp    80180d <strtol+0x19>
		s++;
  80180a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80180d:	8b 45 08             	mov    0x8(%ebp),%eax
  801810:	8a 00                	mov    (%eax),%al
  801812:	3c 20                	cmp    $0x20,%al
  801814:	74 f4                	je     80180a <strtol+0x16>
  801816:	8b 45 08             	mov    0x8(%ebp),%eax
  801819:	8a 00                	mov    (%eax),%al
  80181b:	3c 09                	cmp    $0x9,%al
  80181d:	74 eb                	je     80180a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80181f:	8b 45 08             	mov    0x8(%ebp),%eax
  801822:	8a 00                	mov    (%eax),%al
  801824:	3c 2b                	cmp    $0x2b,%al
  801826:	75 05                	jne    80182d <strtol+0x39>
		s++;
  801828:	ff 45 08             	incl   0x8(%ebp)
  80182b:	eb 13                	jmp    801840 <strtol+0x4c>
	else if (*s == '-')
  80182d:	8b 45 08             	mov    0x8(%ebp),%eax
  801830:	8a 00                	mov    (%eax),%al
  801832:	3c 2d                	cmp    $0x2d,%al
  801834:	75 0a                	jne    801840 <strtol+0x4c>
		s++, neg = 1;
  801836:	ff 45 08             	incl   0x8(%ebp)
  801839:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801840:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801844:	74 06                	je     80184c <strtol+0x58>
  801846:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80184a:	75 20                	jne    80186c <strtol+0x78>
  80184c:	8b 45 08             	mov    0x8(%ebp),%eax
  80184f:	8a 00                	mov    (%eax),%al
  801851:	3c 30                	cmp    $0x30,%al
  801853:	75 17                	jne    80186c <strtol+0x78>
  801855:	8b 45 08             	mov    0x8(%ebp),%eax
  801858:	40                   	inc    %eax
  801859:	8a 00                	mov    (%eax),%al
  80185b:	3c 78                	cmp    $0x78,%al
  80185d:	75 0d                	jne    80186c <strtol+0x78>
		s += 2, base = 16;
  80185f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801863:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80186a:	eb 28                	jmp    801894 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80186c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801870:	75 15                	jne    801887 <strtol+0x93>
  801872:	8b 45 08             	mov    0x8(%ebp),%eax
  801875:	8a 00                	mov    (%eax),%al
  801877:	3c 30                	cmp    $0x30,%al
  801879:	75 0c                	jne    801887 <strtol+0x93>
		s++, base = 8;
  80187b:	ff 45 08             	incl   0x8(%ebp)
  80187e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801885:	eb 0d                	jmp    801894 <strtol+0xa0>
	else if (base == 0)
  801887:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80188b:	75 07                	jne    801894 <strtol+0xa0>
		base = 10;
  80188d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801894:	8b 45 08             	mov    0x8(%ebp),%eax
  801897:	8a 00                	mov    (%eax),%al
  801899:	3c 2f                	cmp    $0x2f,%al
  80189b:	7e 19                	jle    8018b6 <strtol+0xc2>
  80189d:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a0:	8a 00                	mov    (%eax),%al
  8018a2:	3c 39                	cmp    $0x39,%al
  8018a4:	7f 10                	jg     8018b6 <strtol+0xc2>
			dig = *s - '0';
  8018a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a9:	8a 00                	mov    (%eax),%al
  8018ab:	0f be c0             	movsbl %al,%eax
  8018ae:	83 e8 30             	sub    $0x30,%eax
  8018b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018b4:	eb 42                	jmp    8018f8 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8018b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b9:	8a 00                	mov    (%eax),%al
  8018bb:	3c 60                	cmp    $0x60,%al
  8018bd:	7e 19                	jle    8018d8 <strtol+0xe4>
  8018bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c2:	8a 00                	mov    (%eax),%al
  8018c4:	3c 7a                	cmp    $0x7a,%al
  8018c6:	7f 10                	jg     8018d8 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8018c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cb:	8a 00                	mov    (%eax),%al
  8018cd:	0f be c0             	movsbl %al,%eax
  8018d0:	83 e8 57             	sub    $0x57,%eax
  8018d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018d6:	eb 20                	jmp    8018f8 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8018d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018db:	8a 00                	mov    (%eax),%al
  8018dd:	3c 40                	cmp    $0x40,%al
  8018df:	7e 39                	jle    80191a <strtol+0x126>
  8018e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e4:	8a 00                	mov    (%eax),%al
  8018e6:	3c 5a                	cmp    $0x5a,%al
  8018e8:	7f 30                	jg     80191a <strtol+0x126>
			dig = *s - 'A' + 10;
  8018ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ed:	8a 00                	mov    (%eax),%al
  8018ef:	0f be c0             	movsbl %al,%eax
  8018f2:	83 e8 37             	sub    $0x37,%eax
  8018f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8018f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018fb:	3b 45 10             	cmp    0x10(%ebp),%eax
  8018fe:	7d 19                	jge    801919 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801900:	ff 45 08             	incl   0x8(%ebp)
  801903:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801906:	0f af 45 10          	imul   0x10(%ebp),%eax
  80190a:	89 c2                	mov    %eax,%edx
  80190c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80190f:	01 d0                	add    %edx,%eax
  801911:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801914:	e9 7b ff ff ff       	jmp    801894 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801919:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80191a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80191e:	74 08                	je     801928 <strtol+0x134>
		*endptr = (char *) s;
  801920:	8b 45 0c             	mov    0xc(%ebp),%eax
  801923:	8b 55 08             	mov    0x8(%ebp),%edx
  801926:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801928:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80192c:	74 07                	je     801935 <strtol+0x141>
  80192e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801931:	f7 d8                	neg    %eax
  801933:	eb 03                	jmp    801938 <strtol+0x144>
  801935:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801938:	c9                   	leave  
  801939:	c3                   	ret    

0080193a <ltostr>:

void
ltostr(long value, char *str)
{
  80193a:	55                   	push   %ebp
  80193b:	89 e5                	mov    %esp,%ebp
  80193d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801940:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801947:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80194e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801952:	79 13                	jns    801967 <ltostr+0x2d>
	{
		neg = 1;
  801954:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80195b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80195e:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801961:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801964:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801967:	8b 45 08             	mov    0x8(%ebp),%eax
  80196a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80196f:	99                   	cltd   
  801970:	f7 f9                	idiv   %ecx
  801972:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801975:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801978:	8d 50 01             	lea    0x1(%eax),%edx
  80197b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80197e:	89 c2                	mov    %eax,%edx
  801980:	8b 45 0c             	mov    0xc(%ebp),%eax
  801983:	01 d0                	add    %edx,%eax
  801985:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801988:	83 c2 30             	add    $0x30,%edx
  80198b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80198d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801990:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801995:	f7 e9                	imul   %ecx
  801997:	c1 fa 02             	sar    $0x2,%edx
  80199a:	89 c8                	mov    %ecx,%eax
  80199c:	c1 f8 1f             	sar    $0x1f,%eax
  80199f:	29 c2                	sub    %eax,%edx
  8019a1:	89 d0                	mov    %edx,%eax
  8019a3:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8019a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019a9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8019ae:	f7 e9                	imul   %ecx
  8019b0:	c1 fa 02             	sar    $0x2,%edx
  8019b3:	89 c8                	mov    %ecx,%eax
  8019b5:	c1 f8 1f             	sar    $0x1f,%eax
  8019b8:	29 c2                	sub    %eax,%edx
  8019ba:	89 d0                	mov    %edx,%eax
  8019bc:	c1 e0 02             	shl    $0x2,%eax
  8019bf:	01 d0                	add    %edx,%eax
  8019c1:	01 c0                	add    %eax,%eax
  8019c3:	29 c1                	sub    %eax,%ecx
  8019c5:	89 ca                	mov    %ecx,%edx
  8019c7:	85 d2                	test   %edx,%edx
  8019c9:	75 9c                	jne    801967 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8019cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8019d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019d5:	48                   	dec    %eax
  8019d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8019d9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8019dd:	74 3d                	je     801a1c <ltostr+0xe2>
		start = 1 ;
  8019df:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8019e6:	eb 34                	jmp    801a1c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8019e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019ee:	01 d0                	add    %edx,%eax
  8019f0:	8a 00                	mov    (%eax),%al
  8019f2:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8019f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019fb:	01 c2                	add    %eax,%edx
  8019fd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801a00:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a03:	01 c8                	add    %ecx,%eax
  801a05:	8a 00                	mov    (%eax),%al
  801a07:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801a09:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a0f:	01 c2                	add    %eax,%edx
  801a11:	8a 45 eb             	mov    -0x15(%ebp),%al
  801a14:	88 02                	mov    %al,(%edx)
		start++ ;
  801a16:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801a19:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801a1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a1f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a22:	7c c4                	jl     8019e8 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801a24:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801a27:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a2a:	01 d0                	add    %edx,%eax
  801a2c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801a2f:	90                   	nop
  801a30:	c9                   	leave  
  801a31:	c3                   	ret    

00801a32 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801a32:	55                   	push   %ebp
  801a33:	89 e5                	mov    %esp,%ebp
  801a35:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801a38:	ff 75 08             	pushl  0x8(%ebp)
  801a3b:	e8 54 fa ff ff       	call   801494 <strlen>
  801a40:	83 c4 04             	add    $0x4,%esp
  801a43:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801a46:	ff 75 0c             	pushl  0xc(%ebp)
  801a49:	e8 46 fa ff ff       	call   801494 <strlen>
  801a4e:	83 c4 04             	add    $0x4,%esp
  801a51:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801a54:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801a5b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a62:	eb 17                	jmp    801a7b <strcconcat+0x49>
		final[s] = str1[s] ;
  801a64:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a67:	8b 45 10             	mov    0x10(%ebp),%eax
  801a6a:	01 c2                	add    %eax,%edx
  801a6c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a72:	01 c8                	add    %ecx,%eax
  801a74:	8a 00                	mov    (%eax),%al
  801a76:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a78:	ff 45 fc             	incl   -0x4(%ebp)
  801a7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a7e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a81:	7c e1                	jl     801a64 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a83:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a8a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a91:	eb 1f                	jmp    801ab2 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a96:	8d 50 01             	lea    0x1(%eax),%edx
  801a99:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a9c:	89 c2                	mov    %eax,%edx
  801a9e:	8b 45 10             	mov    0x10(%ebp),%eax
  801aa1:	01 c2                	add    %eax,%edx
  801aa3:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801aa6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aa9:	01 c8                	add    %ecx,%eax
  801aab:	8a 00                	mov    (%eax),%al
  801aad:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801aaf:	ff 45 f8             	incl   -0x8(%ebp)
  801ab2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ab5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ab8:	7c d9                	jl     801a93 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801aba:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801abd:	8b 45 10             	mov    0x10(%ebp),%eax
  801ac0:	01 d0                	add    %edx,%eax
  801ac2:	c6 00 00             	movb   $0x0,(%eax)
}
  801ac5:	90                   	nop
  801ac6:	c9                   	leave  
  801ac7:	c3                   	ret    

00801ac8 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801ac8:	55                   	push   %ebp
  801ac9:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801acb:	8b 45 14             	mov    0x14(%ebp),%eax
  801ace:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801ad4:	8b 45 14             	mov    0x14(%ebp),%eax
  801ad7:	8b 00                	mov    (%eax),%eax
  801ad9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ae0:	8b 45 10             	mov    0x10(%ebp),%eax
  801ae3:	01 d0                	add    %edx,%eax
  801ae5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801aeb:	eb 0c                	jmp    801af9 <strsplit+0x31>
			*string++ = 0;
  801aed:	8b 45 08             	mov    0x8(%ebp),%eax
  801af0:	8d 50 01             	lea    0x1(%eax),%edx
  801af3:	89 55 08             	mov    %edx,0x8(%ebp)
  801af6:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801af9:	8b 45 08             	mov    0x8(%ebp),%eax
  801afc:	8a 00                	mov    (%eax),%al
  801afe:	84 c0                	test   %al,%al
  801b00:	74 18                	je     801b1a <strsplit+0x52>
  801b02:	8b 45 08             	mov    0x8(%ebp),%eax
  801b05:	8a 00                	mov    (%eax),%al
  801b07:	0f be c0             	movsbl %al,%eax
  801b0a:	50                   	push   %eax
  801b0b:	ff 75 0c             	pushl  0xc(%ebp)
  801b0e:	e8 13 fb ff ff       	call   801626 <strchr>
  801b13:	83 c4 08             	add    $0x8,%esp
  801b16:	85 c0                	test   %eax,%eax
  801b18:	75 d3                	jne    801aed <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1d:	8a 00                	mov    (%eax),%al
  801b1f:	84 c0                	test   %al,%al
  801b21:	74 5a                	je     801b7d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801b23:	8b 45 14             	mov    0x14(%ebp),%eax
  801b26:	8b 00                	mov    (%eax),%eax
  801b28:	83 f8 0f             	cmp    $0xf,%eax
  801b2b:	75 07                	jne    801b34 <strsplit+0x6c>
		{
			return 0;
  801b2d:	b8 00 00 00 00       	mov    $0x0,%eax
  801b32:	eb 66                	jmp    801b9a <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801b34:	8b 45 14             	mov    0x14(%ebp),%eax
  801b37:	8b 00                	mov    (%eax),%eax
  801b39:	8d 48 01             	lea    0x1(%eax),%ecx
  801b3c:	8b 55 14             	mov    0x14(%ebp),%edx
  801b3f:	89 0a                	mov    %ecx,(%edx)
  801b41:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b48:	8b 45 10             	mov    0x10(%ebp),%eax
  801b4b:	01 c2                	add    %eax,%edx
  801b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b50:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b52:	eb 03                	jmp    801b57 <strsplit+0x8f>
			string++;
  801b54:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b57:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5a:	8a 00                	mov    (%eax),%al
  801b5c:	84 c0                	test   %al,%al
  801b5e:	74 8b                	je     801aeb <strsplit+0x23>
  801b60:	8b 45 08             	mov    0x8(%ebp),%eax
  801b63:	8a 00                	mov    (%eax),%al
  801b65:	0f be c0             	movsbl %al,%eax
  801b68:	50                   	push   %eax
  801b69:	ff 75 0c             	pushl  0xc(%ebp)
  801b6c:	e8 b5 fa ff ff       	call   801626 <strchr>
  801b71:	83 c4 08             	add    $0x8,%esp
  801b74:	85 c0                	test   %eax,%eax
  801b76:	74 dc                	je     801b54 <strsplit+0x8c>
			string++;
	}
  801b78:	e9 6e ff ff ff       	jmp    801aeb <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b7d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b7e:	8b 45 14             	mov    0x14(%ebp),%eax
  801b81:	8b 00                	mov    (%eax),%eax
  801b83:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b8a:	8b 45 10             	mov    0x10(%ebp),%eax
  801b8d:	01 d0                	add    %edx,%eax
  801b8f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b95:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b9a:	c9                   	leave  
  801b9b:	c3                   	ret    

00801b9c <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b9c:	55                   	push   %ebp
  801b9d:	89 e5                	mov    %esp,%ebp
  801b9f:	83 ec 18             	sub    $0x18,%esp
  801ba2:	8b 45 10             	mov    0x10(%ebp),%eax
  801ba5:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801ba8:	83 ec 04             	sub    $0x4,%esp
  801bab:	68 64 2e 80 00       	push   $0x802e64
  801bb0:	6a 17                	push   $0x17
  801bb2:	68 83 2e 80 00       	push   $0x802e83
  801bb7:	e8 9c ed ff ff       	call   800958 <_panic>

00801bbc <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801bbc:	55                   	push   %ebp
  801bbd:	89 e5                	mov    %esp,%ebp
  801bbf:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801bc2:	83 ec 04             	sub    $0x4,%esp
  801bc5:	68 8f 2e 80 00       	push   $0x802e8f
  801bca:	6a 2f                	push   $0x2f
  801bcc:	68 83 2e 80 00       	push   $0x802e83
  801bd1:	e8 82 ed ff ff       	call   800958 <_panic>

00801bd6 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801bd6:	55                   	push   %ebp
  801bd7:	89 e5                	mov    %esp,%ebp
  801bd9:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801bdc:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801be3:	8b 55 08             	mov    0x8(%ebp),%edx
  801be6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801be9:	01 d0                	add    %edx,%eax
  801beb:	48                   	dec    %eax
  801bec:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801bef:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801bf2:	ba 00 00 00 00       	mov    $0x0,%edx
  801bf7:	f7 75 ec             	divl   -0x14(%ebp)
  801bfa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801bfd:	29 d0                	sub    %edx,%eax
  801bff:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801c02:	8b 45 08             	mov    0x8(%ebp),%eax
  801c05:	c1 e8 0c             	shr    $0xc,%eax
  801c08:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801c0b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801c12:	e9 c8 00 00 00       	jmp    801cdf <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801c17:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801c1e:	eb 27                	jmp    801c47 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801c20:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801c23:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c26:	01 c2                	add    %eax,%edx
  801c28:	89 d0                	mov    %edx,%eax
  801c2a:	01 c0                	add    %eax,%eax
  801c2c:	01 d0                	add    %edx,%eax
  801c2e:	c1 e0 02             	shl    $0x2,%eax
  801c31:	05 48 30 80 00       	add    $0x803048,%eax
  801c36:	8b 00                	mov    (%eax),%eax
  801c38:	85 c0                	test   %eax,%eax
  801c3a:	74 08                	je     801c44 <malloc+0x6e>
            	i += j;
  801c3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c3f:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801c42:	eb 0b                	jmp    801c4f <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801c44:	ff 45 f0             	incl   -0x10(%ebp)
  801c47:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c4a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801c4d:	72 d1                	jb     801c20 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801c4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c52:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801c55:	0f 85 81 00 00 00    	jne    801cdc <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801c5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c5e:	05 00 00 08 00       	add    $0x80000,%eax
  801c63:	c1 e0 0c             	shl    $0xc,%eax
  801c66:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801c69:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801c70:	eb 1f                	jmp    801c91 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801c72:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801c75:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c78:	01 c2                	add    %eax,%edx
  801c7a:	89 d0                	mov    %edx,%eax
  801c7c:	01 c0                	add    %eax,%eax
  801c7e:	01 d0                	add    %edx,%eax
  801c80:	c1 e0 02             	shl    $0x2,%eax
  801c83:	05 48 30 80 00       	add    $0x803048,%eax
  801c88:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801c8e:	ff 45 f0             	incl   -0x10(%ebp)
  801c91:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c94:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801c97:	72 d9                	jb     801c72 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801c99:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c9c:	89 d0                	mov    %edx,%eax
  801c9e:	01 c0                	add    %eax,%eax
  801ca0:	01 d0                	add    %edx,%eax
  801ca2:	c1 e0 02             	shl    $0x2,%eax
  801ca5:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801cab:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801cae:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801cb0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801cb3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801cb6:	89 c8                	mov    %ecx,%eax
  801cb8:	01 c0                	add    %eax,%eax
  801cba:	01 c8                	add    %ecx,%eax
  801cbc:	c1 e0 02             	shl    $0x2,%eax
  801cbf:	05 44 30 80 00       	add    $0x803044,%eax
  801cc4:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801cc6:	83 ec 08             	sub    $0x8,%esp
  801cc9:	ff 75 08             	pushl  0x8(%ebp)
  801ccc:	ff 75 e0             	pushl  -0x20(%ebp)
  801ccf:	e8 2b 03 00 00       	call   801fff <sys_allocateMem>
  801cd4:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801cd7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801cda:	eb 19                	jmp    801cf5 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801cdc:	ff 45 f4             	incl   -0xc(%ebp)
  801cdf:	a1 04 30 80 00       	mov    0x803004,%eax
  801ce4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801ce7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801cea:	0f 83 27 ff ff ff    	jae    801c17 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801cf0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cf5:	c9                   	leave  
  801cf6:	c3                   	ret    

00801cf7 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801cf7:	55                   	push   %ebp
  801cf8:	89 e5                	mov    %esp,%ebp
  801cfa:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801cfd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801d01:	0f 84 e5 00 00 00    	je     801dec <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801d07:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801d0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d10:	05 00 00 00 80       	add    $0x80000000,%eax
  801d15:	c1 e8 0c             	shr    $0xc,%eax
  801d18:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801d1b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d1e:	89 d0                	mov    %edx,%eax
  801d20:	01 c0                	add    %eax,%eax
  801d22:	01 d0                	add    %edx,%eax
  801d24:	c1 e0 02             	shl    $0x2,%eax
  801d27:	05 40 30 80 00       	add    $0x803040,%eax
  801d2c:	8b 00                	mov    (%eax),%eax
  801d2e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801d31:	0f 85 b8 00 00 00    	jne    801def <free+0xf8>
  801d37:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d3a:	89 d0                	mov    %edx,%eax
  801d3c:	01 c0                	add    %eax,%eax
  801d3e:	01 d0                	add    %edx,%eax
  801d40:	c1 e0 02             	shl    $0x2,%eax
  801d43:	05 48 30 80 00       	add    $0x803048,%eax
  801d48:	8b 00                	mov    (%eax),%eax
  801d4a:	85 c0                	test   %eax,%eax
  801d4c:	0f 84 9d 00 00 00    	je     801def <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801d52:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d55:	89 d0                	mov    %edx,%eax
  801d57:	01 c0                	add    %eax,%eax
  801d59:	01 d0                	add    %edx,%eax
  801d5b:	c1 e0 02             	shl    $0x2,%eax
  801d5e:	05 44 30 80 00       	add    $0x803044,%eax
  801d63:	8b 00                	mov    (%eax),%eax
  801d65:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801d68:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d6b:	c1 e0 0c             	shl    $0xc,%eax
  801d6e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801d71:	83 ec 08             	sub    $0x8,%esp
  801d74:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d77:	ff 75 f0             	pushl  -0x10(%ebp)
  801d7a:	e8 64 02 00 00       	call   801fe3 <sys_freeMem>
  801d7f:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801d82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801d89:	eb 57                	jmp    801de2 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801d8b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d91:	01 c2                	add    %eax,%edx
  801d93:	89 d0                	mov    %edx,%eax
  801d95:	01 c0                	add    %eax,%eax
  801d97:	01 d0                	add    %edx,%eax
  801d99:	c1 e0 02             	shl    $0x2,%eax
  801d9c:	05 48 30 80 00       	add    $0x803048,%eax
  801da1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801da7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801daa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801dad:	01 c2                	add    %eax,%edx
  801daf:	89 d0                	mov    %edx,%eax
  801db1:	01 c0                	add    %eax,%eax
  801db3:	01 d0                	add    %edx,%eax
  801db5:	c1 e0 02             	shl    $0x2,%eax
  801db8:	05 40 30 80 00       	add    $0x803040,%eax
  801dbd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801dc3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801dc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801dc9:	01 c2                	add    %eax,%edx
  801dcb:	89 d0                	mov    %edx,%eax
  801dcd:	01 c0                	add    %eax,%eax
  801dcf:	01 d0                	add    %edx,%eax
  801dd1:	c1 e0 02             	shl    $0x2,%eax
  801dd4:	05 44 30 80 00       	add    $0x803044,%eax
  801dd9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801ddf:	ff 45 f4             	incl   -0xc(%ebp)
  801de2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801de5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801de8:	7c a1                	jl     801d8b <free+0x94>
  801dea:	eb 04                	jmp    801df0 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801dec:	90                   	nop
  801ded:	eb 01                	jmp    801df0 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801def:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801df0:	c9                   	leave  
  801df1:	c3                   	ret    

00801df2 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801df2:	55                   	push   %ebp
  801df3:	89 e5                	mov    %esp,%ebp
  801df5:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801df8:	83 ec 04             	sub    $0x4,%esp
  801dfb:	68 ac 2e 80 00       	push   $0x802eac
  801e00:	68 ae 00 00 00       	push   $0xae
  801e05:	68 83 2e 80 00       	push   $0x802e83
  801e0a:	e8 49 eb ff ff       	call   800958 <_panic>

00801e0f <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801e0f:	55                   	push   %ebp
  801e10:	89 e5                	mov    %esp,%ebp
  801e12:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801e15:	83 ec 04             	sub    $0x4,%esp
  801e18:	68 cc 2e 80 00       	push   $0x802ecc
  801e1d:	68 ca 00 00 00       	push   $0xca
  801e22:	68 83 2e 80 00       	push   $0x802e83
  801e27:	e8 2c eb ff ff       	call   800958 <_panic>

00801e2c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801e2c:	55                   	push   %ebp
  801e2d:	89 e5                	mov    %esp,%ebp
  801e2f:	57                   	push   %edi
  801e30:	56                   	push   %esi
  801e31:	53                   	push   %ebx
  801e32:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801e35:	8b 45 08             	mov    0x8(%ebp),%eax
  801e38:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e3b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e3e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e41:	8b 7d 18             	mov    0x18(%ebp),%edi
  801e44:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801e47:	cd 30                	int    $0x30
  801e49:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801e4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801e4f:	83 c4 10             	add    $0x10,%esp
  801e52:	5b                   	pop    %ebx
  801e53:	5e                   	pop    %esi
  801e54:	5f                   	pop    %edi
  801e55:	5d                   	pop    %ebp
  801e56:	c3                   	ret    

00801e57 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801e57:	55                   	push   %ebp
  801e58:	89 e5                	mov    %esp,%ebp
  801e5a:	83 ec 04             	sub    $0x4,%esp
  801e5d:	8b 45 10             	mov    0x10(%ebp),%eax
  801e60:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801e63:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e67:	8b 45 08             	mov    0x8(%ebp),%eax
  801e6a:	6a 00                	push   $0x0
  801e6c:	6a 00                	push   $0x0
  801e6e:	52                   	push   %edx
  801e6f:	ff 75 0c             	pushl  0xc(%ebp)
  801e72:	50                   	push   %eax
  801e73:	6a 00                	push   $0x0
  801e75:	e8 b2 ff ff ff       	call   801e2c <syscall>
  801e7a:	83 c4 18             	add    $0x18,%esp
}
  801e7d:	90                   	nop
  801e7e:	c9                   	leave  
  801e7f:	c3                   	ret    

00801e80 <sys_cgetc>:

int
sys_cgetc(void)
{
  801e80:	55                   	push   %ebp
  801e81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	6a 00                	push   $0x0
  801e8b:	6a 00                	push   $0x0
  801e8d:	6a 01                	push   $0x1
  801e8f:	e8 98 ff ff ff       	call   801e2c <syscall>
  801e94:	83 c4 18             	add    $0x18,%esp
}
  801e97:	c9                   	leave  
  801e98:	c3                   	ret    

00801e99 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801e99:	55                   	push   %ebp
  801e9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	50                   	push   %eax
  801ea8:	6a 05                	push   $0x5
  801eaa:	e8 7d ff ff ff       	call   801e2c <syscall>
  801eaf:	83 c4 18             	add    $0x18,%esp
}
  801eb2:	c9                   	leave  
  801eb3:	c3                   	ret    

00801eb4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801eb4:	55                   	push   %ebp
  801eb5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801eb7:	6a 00                	push   $0x0
  801eb9:	6a 00                	push   $0x0
  801ebb:	6a 00                	push   $0x0
  801ebd:	6a 00                	push   $0x0
  801ebf:	6a 00                	push   $0x0
  801ec1:	6a 02                	push   $0x2
  801ec3:	e8 64 ff ff ff       	call   801e2c <syscall>
  801ec8:	83 c4 18             	add    $0x18,%esp
}
  801ecb:	c9                   	leave  
  801ecc:	c3                   	ret    

00801ecd <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ecd:	55                   	push   %ebp
  801ece:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ed0:	6a 00                	push   $0x0
  801ed2:	6a 00                	push   $0x0
  801ed4:	6a 00                	push   $0x0
  801ed6:	6a 00                	push   $0x0
  801ed8:	6a 00                	push   $0x0
  801eda:	6a 03                	push   $0x3
  801edc:	e8 4b ff ff ff       	call   801e2c <syscall>
  801ee1:	83 c4 18             	add    $0x18,%esp
}
  801ee4:	c9                   	leave  
  801ee5:	c3                   	ret    

00801ee6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ee6:	55                   	push   %ebp
  801ee7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	6a 00                	push   $0x0
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 00                	push   $0x0
  801ef3:	6a 04                	push   $0x4
  801ef5:	e8 32 ff ff ff       	call   801e2c <syscall>
  801efa:	83 c4 18             	add    $0x18,%esp
}
  801efd:	c9                   	leave  
  801efe:	c3                   	ret    

00801eff <sys_env_exit>:


void sys_env_exit(void)
{
  801eff:	55                   	push   %ebp
  801f00:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 00                	push   $0x0
  801f0c:	6a 06                	push   $0x6
  801f0e:	e8 19 ff ff ff       	call   801e2c <syscall>
  801f13:	83 c4 18             	add    $0x18,%esp
}
  801f16:	90                   	nop
  801f17:	c9                   	leave  
  801f18:	c3                   	ret    

00801f19 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801f19:	55                   	push   %ebp
  801f1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801f1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f22:	6a 00                	push   $0x0
  801f24:	6a 00                	push   $0x0
  801f26:	6a 00                	push   $0x0
  801f28:	52                   	push   %edx
  801f29:	50                   	push   %eax
  801f2a:	6a 07                	push   $0x7
  801f2c:	e8 fb fe ff ff       	call   801e2c <syscall>
  801f31:	83 c4 18             	add    $0x18,%esp
}
  801f34:	c9                   	leave  
  801f35:	c3                   	ret    

00801f36 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801f36:	55                   	push   %ebp
  801f37:	89 e5                	mov    %esp,%ebp
  801f39:	56                   	push   %esi
  801f3a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801f3b:	8b 75 18             	mov    0x18(%ebp),%esi
  801f3e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f41:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f44:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f47:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4a:	56                   	push   %esi
  801f4b:	53                   	push   %ebx
  801f4c:	51                   	push   %ecx
  801f4d:	52                   	push   %edx
  801f4e:	50                   	push   %eax
  801f4f:	6a 08                	push   $0x8
  801f51:	e8 d6 fe ff ff       	call   801e2c <syscall>
  801f56:	83 c4 18             	add    $0x18,%esp
}
  801f59:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801f5c:	5b                   	pop    %ebx
  801f5d:	5e                   	pop    %esi
  801f5e:	5d                   	pop    %ebp
  801f5f:	c3                   	ret    

00801f60 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801f60:	55                   	push   %ebp
  801f61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801f63:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f66:	8b 45 08             	mov    0x8(%ebp),%eax
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	52                   	push   %edx
  801f70:	50                   	push   %eax
  801f71:	6a 09                	push   $0x9
  801f73:	e8 b4 fe ff ff       	call   801e2c <syscall>
  801f78:	83 c4 18             	add    $0x18,%esp
}
  801f7b:	c9                   	leave  
  801f7c:	c3                   	ret    

00801f7d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801f7d:	55                   	push   %ebp
  801f7e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	ff 75 0c             	pushl  0xc(%ebp)
  801f89:	ff 75 08             	pushl  0x8(%ebp)
  801f8c:	6a 0a                	push   $0xa
  801f8e:	e8 99 fe ff ff       	call   801e2c <syscall>
  801f93:	83 c4 18             	add    $0x18,%esp
}
  801f96:	c9                   	leave  
  801f97:	c3                   	ret    

00801f98 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801f98:	55                   	push   %ebp
  801f99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 00                	push   $0x0
  801fa1:	6a 00                	push   $0x0
  801fa3:	6a 00                	push   $0x0
  801fa5:	6a 0b                	push   $0xb
  801fa7:	e8 80 fe ff ff       	call   801e2c <syscall>
  801fac:	83 c4 18             	add    $0x18,%esp
}
  801faf:	c9                   	leave  
  801fb0:	c3                   	ret    

00801fb1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801fb1:	55                   	push   %ebp
  801fb2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 00                	push   $0x0
  801fbe:	6a 0c                	push   $0xc
  801fc0:	e8 67 fe ff ff       	call   801e2c <syscall>
  801fc5:	83 c4 18             	add    $0x18,%esp
}
  801fc8:	c9                   	leave  
  801fc9:	c3                   	ret    

00801fca <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801fca:	55                   	push   %ebp
  801fcb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 0d                	push   $0xd
  801fd9:	e8 4e fe ff ff       	call   801e2c <syscall>
  801fde:	83 c4 18             	add    $0x18,%esp
}
  801fe1:	c9                   	leave  
  801fe2:	c3                   	ret    

00801fe3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801fe3:	55                   	push   %ebp
  801fe4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	ff 75 0c             	pushl  0xc(%ebp)
  801fef:	ff 75 08             	pushl  0x8(%ebp)
  801ff2:	6a 11                	push   $0x11
  801ff4:	e8 33 fe ff ff       	call   801e2c <syscall>
  801ff9:	83 c4 18             	add    $0x18,%esp
	return;
  801ffc:	90                   	nop
}
  801ffd:	c9                   	leave  
  801ffe:	c3                   	ret    

00801fff <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801fff:	55                   	push   %ebp
  802000:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	6a 00                	push   $0x0
  802008:	ff 75 0c             	pushl  0xc(%ebp)
  80200b:	ff 75 08             	pushl  0x8(%ebp)
  80200e:	6a 12                	push   $0x12
  802010:	e8 17 fe ff ff       	call   801e2c <syscall>
  802015:	83 c4 18             	add    $0x18,%esp
	return ;
  802018:	90                   	nop
}
  802019:	c9                   	leave  
  80201a:	c3                   	ret    

0080201b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80201b:	55                   	push   %ebp
  80201c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	6a 0e                	push   $0xe
  80202a:	e8 fd fd ff ff       	call   801e2c <syscall>
  80202f:	83 c4 18             	add    $0x18,%esp
}
  802032:	c9                   	leave  
  802033:	c3                   	ret    

00802034 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802034:	55                   	push   %ebp
  802035:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802037:	6a 00                	push   $0x0
  802039:	6a 00                	push   $0x0
  80203b:	6a 00                	push   $0x0
  80203d:	6a 00                	push   $0x0
  80203f:	ff 75 08             	pushl  0x8(%ebp)
  802042:	6a 0f                	push   $0xf
  802044:	e8 e3 fd ff ff       	call   801e2c <syscall>
  802049:	83 c4 18             	add    $0x18,%esp
}
  80204c:	c9                   	leave  
  80204d:	c3                   	ret    

0080204e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80204e:	55                   	push   %ebp
  80204f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802051:	6a 00                	push   $0x0
  802053:	6a 00                	push   $0x0
  802055:	6a 00                	push   $0x0
  802057:	6a 00                	push   $0x0
  802059:	6a 00                	push   $0x0
  80205b:	6a 10                	push   $0x10
  80205d:	e8 ca fd ff ff       	call   801e2c <syscall>
  802062:	83 c4 18             	add    $0x18,%esp
}
  802065:	90                   	nop
  802066:	c9                   	leave  
  802067:	c3                   	ret    

00802068 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802068:	55                   	push   %ebp
  802069:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80206b:	6a 00                	push   $0x0
  80206d:	6a 00                	push   $0x0
  80206f:	6a 00                	push   $0x0
  802071:	6a 00                	push   $0x0
  802073:	6a 00                	push   $0x0
  802075:	6a 14                	push   $0x14
  802077:	e8 b0 fd ff ff       	call   801e2c <syscall>
  80207c:	83 c4 18             	add    $0x18,%esp
}
  80207f:	90                   	nop
  802080:	c9                   	leave  
  802081:	c3                   	ret    

00802082 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802082:	55                   	push   %ebp
  802083:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802085:	6a 00                	push   $0x0
  802087:	6a 00                	push   $0x0
  802089:	6a 00                	push   $0x0
  80208b:	6a 00                	push   $0x0
  80208d:	6a 00                	push   $0x0
  80208f:	6a 15                	push   $0x15
  802091:	e8 96 fd ff ff       	call   801e2c <syscall>
  802096:	83 c4 18             	add    $0x18,%esp
}
  802099:	90                   	nop
  80209a:	c9                   	leave  
  80209b:	c3                   	ret    

0080209c <sys_cputc>:


void
sys_cputc(const char c)
{
  80209c:	55                   	push   %ebp
  80209d:	89 e5                	mov    %esp,%ebp
  80209f:	83 ec 04             	sub    $0x4,%esp
  8020a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020a5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8020a8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 00                	push   $0x0
  8020b4:	50                   	push   %eax
  8020b5:	6a 16                	push   $0x16
  8020b7:	e8 70 fd ff ff       	call   801e2c <syscall>
  8020bc:	83 c4 18             	add    $0x18,%esp
}
  8020bf:	90                   	nop
  8020c0:	c9                   	leave  
  8020c1:	c3                   	ret    

008020c2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8020c2:	55                   	push   %ebp
  8020c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 17                	push   $0x17
  8020d1:	e8 56 fd ff ff       	call   801e2c <syscall>
  8020d6:	83 c4 18             	add    $0x18,%esp
}
  8020d9:	90                   	nop
  8020da:	c9                   	leave  
  8020db:	c3                   	ret    

008020dc <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8020dc:	55                   	push   %ebp
  8020dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8020df:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e2:	6a 00                	push   $0x0
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 00                	push   $0x0
  8020e8:	ff 75 0c             	pushl  0xc(%ebp)
  8020eb:	50                   	push   %eax
  8020ec:	6a 18                	push   $0x18
  8020ee:	e8 39 fd ff ff       	call   801e2c <syscall>
  8020f3:	83 c4 18             	add    $0x18,%esp
}
  8020f6:	c9                   	leave  
  8020f7:	c3                   	ret    

008020f8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8020f8:	55                   	push   %ebp
  8020f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020fe:	8b 45 08             	mov    0x8(%ebp),%eax
  802101:	6a 00                	push   $0x0
  802103:	6a 00                	push   $0x0
  802105:	6a 00                	push   $0x0
  802107:	52                   	push   %edx
  802108:	50                   	push   %eax
  802109:	6a 1b                	push   $0x1b
  80210b:	e8 1c fd ff ff       	call   801e2c <syscall>
  802110:	83 c4 18             	add    $0x18,%esp
}
  802113:	c9                   	leave  
  802114:	c3                   	ret    

00802115 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802115:	55                   	push   %ebp
  802116:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802118:	8b 55 0c             	mov    0xc(%ebp),%edx
  80211b:	8b 45 08             	mov    0x8(%ebp),%eax
  80211e:	6a 00                	push   $0x0
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	52                   	push   %edx
  802125:	50                   	push   %eax
  802126:	6a 19                	push   $0x19
  802128:	e8 ff fc ff ff       	call   801e2c <syscall>
  80212d:	83 c4 18             	add    $0x18,%esp
}
  802130:	90                   	nop
  802131:	c9                   	leave  
  802132:	c3                   	ret    

00802133 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802133:	55                   	push   %ebp
  802134:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802136:	8b 55 0c             	mov    0xc(%ebp),%edx
  802139:	8b 45 08             	mov    0x8(%ebp),%eax
  80213c:	6a 00                	push   $0x0
  80213e:	6a 00                	push   $0x0
  802140:	6a 00                	push   $0x0
  802142:	52                   	push   %edx
  802143:	50                   	push   %eax
  802144:	6a 1a                	push   $0x1a
  802146:	e8 e1 fc ff ff       	call   801e2c <syscall>
  80214b:	83 c4 18             	add    $0x18,%esp
}
  80214e:	90                   	nop
  80214f:	c9                   	leave  
  802150:	c3                   	ret    

00802151 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802151:	55                   	push   %ebp
  802152:	89 e5                	mov    %esp,%ebp
  802154:	83 ec 04             	sub    $0x4,%esp
  802157:	8b 45 10             	mov    0x10(%ebp),%eax
  80215a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80215d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802160:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802164:	8b 45 08             	mov    0x8(%ebp),%eax
  802167:	6a 00                	push   $0x0
  802169:	51                   	push   %ecx
  80216a:	52                   	push   %edx
  80216b:	ff 75 0c             	pushl  0xc(%ebp)
  80216e:	50                   	push   %eax
  80216f:	6a 1c                	push   $0x1c
  802171:	e8 b6 fc ff ff       	call   801e2c <syscall>
  802176:	83 c4 18             	add    $0x18,%esp
}
  802179:	c9                   	leave  
  80217a:	c3                   	ret    

0080217b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80217b:	55                   	push   %ebp
  80217c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80217e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802181:	8b 45 08             	mov    0x8(%ebp),%eax
  802184:	6a 00                	push   $0x0
  802186:	6a 00                	push   $0x0
  802188:	6a 00                	push   $0x0
  80218a:	52                   	push   %edx
  80218b:	50                   	push   %eax
  80218c:	6a 1d                	push   $0x1d
  80218e:	e8 99 fc ff ff       	call   801e2c <syscall>
  802193:	83 c4 18             	add    $0x18,%esp
}
  802196:	c9                   	leave  
  802197:	c3                   	ret    

00802198 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802198:	55                   	push   %ebp
  802199:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80219b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80219e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	51                   	push   %ecx
  8021a9:	52                   	push   %edx
  8021aa:	50                   	push   %eax
  8021ab:	6a 1e                	push   $0x1e
  8021ad:	e8 7a fc ff ff       	call   801e2c <syscall>
  8021b2:	83 c4 18             	add    $0x18,%esp
}
  8021b5:	c9                   	leave  
  8021b6:	c3                   	ret    

008021b7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8021b7:	55                   	push   %ebp
  8021b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8021ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c0:	6a 00                	push   $0x0
  8021c2:	6a 00                	push   $0x0
  8021c4:	6a 00                	push   $0x0
  8021c6:	52                   	push   %edx
  8021c7:	50                   	push   %eax
  8021c8:	6a 1f                	push   $0x1f
  8021ca:	e8 5d fc ff ff       	call   801e2c <syscall>
  8021cf:	83 c4 18             	add    $0x18,%esp
}
  8021d2:	c9                   	leave  
  8021d3:	c3                   	ret    

008021d4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8021d4:	55                   	push   %ebp
  8021d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8021d7:	6a 00                	push   $0x0
  8021d9:	6a 00                	push   $0x0
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 20                	push   $0x20
  8021e3:	e8 44 fc ff ff       	call   801e2c <syscall>
  8021e8:	83 c4 18             	add    $0x18,%esp
}
  8021eb:	c9                   	leave  
  8021ec:	c3                   	ret    

008021ed <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8021ed:	55                   	push   %ebp
  8021ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8021f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021f3:	6a 00                	push   $0x0
  8021f5:	6a 00                	push   $0x0
  8021f7:	ff 75 10             	pushl  0x10(%ebp)
  8021fa:	ff 75 0c             	pushl  0xc(%ebp)
  8021fd:	50                   	push   %eax
  8021fe:	6a 21                	push   $0x21
  802200:	e8 27 fc ff ff       	call   801e2c <syscall>
  802205:	83 c4 18             	add    $0x18,%esp
}
  802208:	c9                   	leave  
  802209:	c3                   	ret    

0080220a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80220a:	55                   	push   %ebp
  80220b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80220d:	8b 45 08             	mov    0x8(%ebp),%eax
  802210:	6a 00                	push   $0x0
  802212:	6a 00                	push   $0x0
  802214:	6a 00                	push   $0x0
  802216:	6a 00                	push   $0x0
  802218:	50                   	push   %eax
  802219:	6a 22                	push   $0x22
  80221b:	e8 0c fc ff ff       	call   801e2c <syscall>
  802220:	83 c4 18             	add    $0x18,%esp
}
  802223:	90                   	nop
  802224:	c9                   	leave  
  802225:	c3                   	ret    

00802226 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802226:	55                   	push   %ebp
  802227:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802229:	8b 45 08             	mov    0x8(%ebp),%eax
  80222c:	6a 00                	push   $0x0
  80222e:	6a 00                	push   $0x0
  802230:	6a 00                	push   $0x0
  802232:	6a 00                	push   $0x0
  802234:	50                   	push   %eax
  802235:	6a 23                	push   $0x23
  802237:	e8 f0 fb ff ff       	call   801e2c <syscall>
  80223c:	83 c4 18             	add    $0x18,%esp
}
  80223f:	90                   	nop
  802240:	c9                   	leave  
  802241:	c3                   	ret    

00802242 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802242:	55                   	push   %ebp
  802243:	89 e5                	mov    %esp,%ebp
  802245:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802248:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80224b:	8d 50 04             	lea    0x4(%eax),%edx
  80224e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802251:	6a 00                	push   $0x0
  802253:	6a 00                	push   $0x0
  802255:	6a 00                	push   $0x0
  802257:	52                   	push   %edx
  802258:	50                   	push   %eax
  802259:	6a 24                	push   $0x24
  80225b:	e8 cc fb ff ff       	call   801e2c <syscall>
  802260:	83 c4 18             	add    $0x18,%esp
	return result;
  802263:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802266:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802269:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80226c:	89 01                	mov    %eax,(%ecx)
  80226e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802271:	8b 45 08             	mov    0x8(%ebp),%eax
  802274:	c9                   	leave  
  802275:	c2 04 00             	ret    $0x4

00802278 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802278:	55                   	push   %ebp
  802279:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80227b:	6a 00                	push   $0x0
  80227d:	6a 00                	push   $0x0
  80227f:	ff 75 10             	pushl  0x10(%ebp)
  802282:	ff 75 0c             	pushl  0xc(%ebp)
  802285:	ff 75 08             	pushl  0x8(%ebp)
  802288:	6a 13                	push   $0x13
  80228a:	e8 9d fb ff ff       	call   801e2c <syscall>
  80228f:	83 c4 18             	add    $0x18,%esp
	return ;
  802292:	90                   	nop
}
  802293:	c9                   	leave  
  802294:	c3                   	ret    

00802295 <sys_rcr2>:
uint32 sys_rcr2()
{
  802295:	55                   	push   %ebp
  802296:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802298:	6a 00                	push   $0x0
  80229a:	6a 00                	push   $0x0
  80229c:	6a 00                	push   $0x0
  80229e:	6a 00                	push   $0x0
  8022a0:	6a 00                	push   $0x0
  8022a2:	6a 25                	push   $0x25
  8022a4:	e8 83 fb ff ff       	call   801e2c <syscall>
  8022a9:	83 c4 18             	add    $0x18,%esp
}
  8022ac:	c9                   	leave  
  8022ad:	c3                   	ret    

008022ae <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8022ae:	55                   	push   %ebp
  8022af:	89 e5                	mov    %esp,%ebp
  8022b1:	83 ec 04             	sub    $0x4,%esp
  8022b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8022b7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8022ba:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8022be:	6a 00                	push   $0x0
  8022c0:	6a 00                	push   $0x0
  8022c2:	6a 00                	push   $0x0
  8022c4:	6a 00                	push   $0x0
  8022c6:	50                   	push   %eax
  8022c7:	6a 26                	push   $0x26
  8022c9:	e8 5e fb ff ff       	call   801e2c <syscall>
  8022ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8022d1:	90                   	nop
}
  8022d2:	c9                   	leave  
  8022d3:	c3                   	ret    

008022d4 <rsttst>:
void rsttst()
{
  8022d4:	55                   	push   %ebp
  8022d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8022d7:	6a 00                	push   $0x0
  8022d9:	6a 00                	push   $0x0
  8022db:	6a 00                	push   $0x0
  8022dd:	6a 00                	push   $0x0
  8022df:	6a 00                	push   $0x0
  8022e1:	6a 28                	push   $0x28
  8022e3:	e8 44 fb ff ff       	call   801e2c <syscall>
  8022e8:	83 c4 18             	add    $0x18,%esp
	return ;
  8022eb:	90                   	nop
}
  8022ec:	c9                   	leave  
  8022ed:	c3                   	ret    

008022ee <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8022ee:	55                   	push   %ebp
  8022ef:	89 e5                	mov    %esp,%ebp
  8022f1:	83 ec 04             	sub    $0x4,%esp
  8022f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8022f7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8022fa:	8b 55 18             	mov    0x18(%ebp),%edx
  8022fd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802301:	52                   	push   %edx
  802302:	50                   	push   %eax
  802303:	ff 75 10             	pushl  0x10(%ebp)
  802306:	ff 75 0c             	pushl  0xc(%ebp)
  802309:	ff 75 08             	pushl  0x8(%ebp)
  80230c:	6a 27                	push   $0x27
  80230e:	e8 19 fb ff ff       	call   801e2c <syscall>
  802313:	83 c4 18             	add    $0x18,%esp
	return ;
  802316:	90                   	nop
}
  802317:	c9                   	leave  
  802318:	c3                   	ret    

00802319 <chktst>:
void chktst(uint32 n)
{
  802319:	55                   	push   %ebp
  80231a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80231c:	6a 00                	push   $0x0
  80231e:	6a 00                	push   $0x0
  802320:	6a 00                	push   $0x0
  802322:	6a 00                	push   $0x0
  802324:	ff 75 08             	pushl  0x8(%ebp)
  802327:	6a 29                	push   $0x29
  802329:	e8 fe fa ff ff       	call   801e2c <syscall>
  80232e:	83 c4 18             	add    $0x18,%esp
	return ;
  802331:	90                   	nop
}
  802332:	c9                   	leave  
  802333:	c3                   	ret    

00802334 <inctst>:

void inctst()
{
  802334:	55                   	push   %ebp
  802335:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802337:	6a 00                	push   $0x0
  802339:	6a 00                	push   $0x0
  80233b:	6a 00                	push   $0x0
  80233d:	6a 00                	push   $0x0
  80233f:	6a 00                	push   $0x0
  802341:	6a 2a                	push   $0x2a
  802343:	e8 e4 fa ff ff       	call   801e2c <syscall>
  802348:	83 c4 18             	add    $0x18,%esp
	return ;
  80234b:	90                   	nop
}
  80234c:	c9                   	leave  
  80234d:	c3                   	ret    

0080234e <gettst>:
uint32 gettst()
{
  80234e:	55                   	push   %ebp
  80234f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802351:	6a 00                	push   $0x0
  802353:	6a 00                	push   $0x0
  802355:	6a 00                	push   $0x0
  802357:	6a 00                	push   $0x0
  802359:	6a 00                	push   $0x0
  80235b:	6a 2b                	push   $0x2b
  80235d:	e8 ca fa ff ff       	call   801e2c <syscall>
  802362:	83 c4 18             	add    $0x18,%esp
}
  802365:	c9                   	leave  
  802366:	c3                   	ret    

00802367 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802367:	55                   	push   %ebp
  802368:	89 e5                	mov    %esp,%ebp
  80236a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80236d:	6a 00                	push   $0x0
  80236f:	6a 00                	push   $0x0
  802371:	6a 00                	push   $0x0
  802373:	6a 00                	push   $0x0
  802375:	6a 00                	push   $0x0
  802377:	6a 2c                	push   $0x2c
  802379:	e8 ae fa ff ff       	call   801e2c <syscall>
  80237e:	83 c4 18             	add    $0x18,%esp
  802381:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802384:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802388:	75 07                	jne    802391 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80238a:	b8 01 00 00 00       	mov    $0x1,%eax
  80238f:	eb 05                	jmp    802396 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802391:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802396:	c9                   	leave  
  802397:	c3                   	ret    

00802398 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802398:	55                   	push   %ebp
  802399:	89 e5                	mov    %esp,%ebp
  80239b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80239e:	6a 00                	push   $0x0
  8023a0:	6a 00                	push   $0x0
  8023a2:	6a 00                	push   $0x0
  8023a4:	6a 00                	push   $0x0
  8023a6:	6a 00                	push   $0x0
  8023a8:	6a 2c                	push   $0x2c
  8023aa:	e8 7d fa ff ff       	call   801e2c <syscall>
  8023af:	83 c4 18             	add    $0x18,%esp
  8023b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8023b5:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8023b9:	75 07                	jne    8023c2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8023bb:	b8 01 00 00 00       	mov    $0x1,%eax
  8023c0:	eb 05                	jmp    8023c7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8023c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023c7:	c9                   	leave  
  8023c8:	c3                   	ret    

008023c9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8023c9:	55                   	push   %ebp
  8023ca:	89 e5                	mov    %esp,%ebp
  8023cc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023cf:	6a 00                	push   $0x0
  8023d1:	6a 00                	push   $0x0
  8023d3:	6a 00                	push   $0x0
  8023d5:	6a 00                	push   $0x0
  8023d7:	6a 00                	push   $0x0
  8023d9:	6a 2c                	push   $0x2c
  8023db:	e8 4c fa ff ff       	call   801e2c <syscall>
  8023e0:	83 c4 18             	add    $0x18,%esp
  8023e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8023e6:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8023ea:	75 07                	jne    8023f3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8023ec:	b8 01 00 00 00       	mov    $0x1,%eax
  8023f1:	eb 05                	jmp    8023f8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8023f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023f8:	c9                   	leave  
  8023f9:	c3                   	ret    

008023fa <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8023fa:	55                   	push   %ebp
  8023fb:	89 e5                	mov    %esp,%ebp
  8023fd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802400:	6a 00                	push   $0x0
  802402:	6a 00                	push   $0x0
  802404:	6a 00                	push   $0x0
  802406:	6a 00                	push   $0x0
  802408:	6a 00                	push   $0x0
  80240a:	6a 2c                	push   $0x2c
  80240c:	e8 1b fa ff ff       	call   801e2c <syscall>
  802411:	83 c4 18             	add    $0x18,%esp
  802414:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802417:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80241b:	75 07                	jne    802424 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80241d:	b8 01 00 00 00       	mov    $0x1,%eax
  802422:	eb 05                	jmp    802429 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802424:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802429:	c9                   	leave  
  80242a:	c3                   	ret    

0080242b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80242b:	55                   	push   %ebp
  80242c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80242e:	6a 00                	push   $0x0
  802430:	6a 00                	push   $0x0
  802432:	6a 00                	push   $0x0
  802434:	6a 00                	push   $0x0
  802436:	ff 75 08             	pushl  0x8(%ebp)
  802439:	6a 2d                	push   $0x2d
  80243b:	e8 ec f9 ff ff       	call   801e2c <syscall>
  802440:	83 c4 18             	add    $0x18,%esp
	return ;
  802443:	90                   	nop
}
  802444:	c9                   	leave  
  802445:	c3                   	ret    
  802446:	66 90                	xchg   %ax,%ax

00802448 <__udivdi3>:
  802448:	55                   	push   %ebp
  802449:	57                   	push   %edi
  80244a:	56                   	push   %esi
  80244b:	53                   	push   %ebx
  80244c:	83 ec 1c             	sub    $0x1c,%esp
  80244f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802453:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802457:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80245b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80245f:	89 ca                	mov    %ecx,%edx
  802461:	89 f8                	mov    %edi,%eax
  802463:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802467:	85 f6                	test   %esi,%esi
  802469:	75 2d                	jne    802498 <__udivdi3+0x50>
  80246b:	39 cf                	cmp    %ecx,%edi
  80246d:	77 65                	ja     8024d4 <__udivdi3+0x8c>
  80246f:	89 fd                	mov    %edi,%ebp
  802471:	85 ff                	test   %edi,%edi
  802473:	75 0b                	jne    802480 <__udivdi3+0x38>
  802475:	b8 01 00 00 00       	mov    $0x1,%eax
  80247a:	31 d2                	xor    %edx,%edx
  80247c:	f7 f7                	div    %edi
  80247e:	89 c5                	mov    %eax,%ebp
  802480:	31 d2                	xor    %edx,%edx
  802482:	89 c8                	mov    %ecx,%eax
  802484:	f7 f5                	div    %ebp
  802486:	89 c1                	mov    %eax,%ecx
  802488:	89 d8                	mov    %ebx,%eax
  80248a:	f7 f5                	div    %ebp
  80248c:	89 cf                	mov    %ecx,%edi
  80248e:	89 fa                	mov    %edi,%edx
  802490:	83 c4 1c             	add    $0x1c,%esp
  802493:	5b                   	pop    %ebx
  802494:	5e                   	pop    %esi
  802495:	5f                   	pop    %edi
  802496:	5d                   	pop    %ebp
  802497:	c3                   	ret    
  802498:	39 ce                	cmp    %ecx,%esi
  80249a:	77 28                	ja     8024c4 <__udivdi3+0x7c>
  80249c:	0f bd fe             	bsr    %esi,%edi
  80249f:	83 f7 1f             	xor    $0x1f,%edi
  8024a2:	75 40                	jne    8024e4 <__udivdi3+0x9c>
  8024a4:	39 ce                	cmp    %ecx,%esi
  8024a6:	72 0a                	jb     8024b2 <__udivdi3+0x6a>
  8024a8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8024ac:	0f 87 9e 00 00 00    	ja     802550 <__udivdi3+0x108>
  8024b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8024b7:	89 fa                	mov    %edi,%edx
  8024b9:	83 c4 1c             	add    $0x1c,%esp
  8024bc:	5b                   	pop    %ebx
  8024bd:	5e                   	pop    %esi
  8024be:	5f                   	pop    %edi
  8024bf:	5d                   	pop    %ebp
  8024c0:	c3                   	ret    
  8024c1:	8d 76 00             	lea    0x0(%esi),%esi
  8024c4:	31 ff                	xor    %edi,%edi
  8024c6:	31 c0                	xor    %eax,%eax
  8024c8:	89 fa                	mov    %edi,%edx
  8024ca:	83 c4 1c             	add    $0x1c,%esp
  8024cd:	5b                   	pop    %ebx
  8024ce:	5e                   	pop    %esi
  8024cf:	5f                   	pop    %edi
  8024d0:	5d                   	pop    %ebp
  8024d1:	c3                   	ret    
  8024d2:	66 90                	xchg   %ax,%ax
  8024d4:	89 d8                	mov    %ebx,%eax
  8024d6:	f7 f7                	div    %edi
  8024d8:	31 ff                	xor    %edi,%edi
  8024da:	89 fa                	mov    %edi,%edx
  8024dc:	83 c4 1c             	add    $0x1c,%esp
  8024df:	5b                   	pop    %ebx
  8024e0:	5e                   	pop    %esi
  8024e1:	5f                   	pop    %edi
  8024e2:	5d                   	pop    %ebp
  8024e3:	c3                   	ret    
  8024e4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8024e9:	89 eb                	mov    %ebp,%ebx
  8024eb:	29 fb                	sub    %edi,%ebx
  8024ed:	89 f9                	mov    %edi,%ecx
  8024ef:	d3 e6                	shl    %cl,%esi
  8024f1:	89 c5                	mov    %eax,%ebp
  8024f3:	88 d9                	mov    %bl,%cl
  8024f5:	d3 ed                	shr    %cl,%ebp
  8024f7:	89 e9                	mov    %ebp,%ecx
  8024f9:	09 f1                	or     %esi,%ecx
  8024fb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8024ff:	89 f9                	mov    %edi,%ecx
  802501:	d3 e0                	shl    %cl,%eax
  802503:	89 c5                	mov    %eax,%ebp
  802505:	89 d6                	mov    %edx,%esi
  802507:	88 d9                	mov    %bl,%cl
  802509:	d3 ee                	shr    %cl,%esi
  80250b:	89 f9                	mov    %edi,%ecx
  80250d:	d3 e2                	shl    %cl,%edx
  80250f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802513:	88 d9                	mov    %bl,%cl
  802515:	d3 e8                	shr    %cl,%eax
  802517:	09 c2                	or     %eax,%edx
  802519:	89 d0                	mov    %edx,%eax
  80251b:	89 f2                	mov    %esi,%edx
  80251d:	f7 74 24 0c          	divl   0xc(%esp)
  802521:	89 d6                	mov    %edx,%esi
  802523:	89 c3                	mov    %eax,%ebx
  802525:	f7 e5                	mul    %ebp
  802527:	39 d6                	cmp    %edx,%esi
  802529:	72 19                	jb     802544 <__udivdi3+0xfc>
  80252b:	74 0b                	je     802538 <__udivdi3+0xf0>
  80252d:	89 d8                	mov    %ebx,%eax
  80252f:	31 ff                	xor    %edi,%edi
  802531:	e9 58 ff ff ff       	jmp    80248e <__udivdi3+0x46>
  802536:	66 90                	xchg   %ax,%ax
  802538:	8b 54 24 08          	mov    0x8(%esp),%edx
  80253c:	89 f9                	mov    %edi,%ecx
  80253e:	d3 e2                	shl    %cl,%edx
  802540:	39 c2                	cmp    %eax,%edx
  802542:	73 e9                	jae    80252d <__udivdi3+0xe5>
  802544:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802547:	31 ff                	xor    %edi,%edi
  802549:	e9 40 ff ff ff       	jmp    80248e <__udivdi3+0x46>
  80254e:	66 90                	xchg   %ax,%ax
  802550:	31 c0                	xor    %eax,%eax
  802552:	e9 37 ff ff ff       	jmp    80248e <__udivdi3+0x46>
  802557:	90                   	nop

00802558 <__umoddi3>:
  802558:	55                   	push   %ebp
  802559:	57                   	push   %edi
  80255a:	56                   	push   %esi
  80255b:	53                   	push   %ebx
  80255c:	83 ec 1c             	sub    $0x1c,%esp
  80255f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802563:	8b 74 24 34          	mov    0x34(%esp),%esi
  802567:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80256b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80256f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802573:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802577:	89 f3                	mov    %esi,%ebx
  802579:	89 fa                	mov    %edi,%edx
  80257b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80257f:	89 34 24             	mov    %esi,(%esp)
  802582:	85 c0                	test   %eax,%eax
  802584:	75 1a                	jne    8025a0 <__umoddi3+0x48>
  802586:	39 f7                	cmp    %esi,%edi
  802588:	0f 86 a2 00 00 00    	jbe    802630 <__umoddi3+0xd8>
  80258e:	89 c8                	mov    %ecx,%eax
  802590:	89 f2                	mov    %esi,%edx
  802592:	f7 f7                	div    %edi
  802594:	89 d0                	mov    %edx,%eax
  802596:	31 d2                	xor    %edx,%edx
  802598:	83 c4 1c             	add    $0x1c,%esp
  80259b:	5b                   	pop    %ebx
  80259c:	5e                   	pop    %esi
  80259d:	5f                   	pop    %edi
  80259e:	5d                   	pop    %ebp
  80259f:	c3                   	ret    
  8025a0:	39 f0                	cmp    %esi,%eax
  8025a2:	0f 87 ac 00 00 00    	ja     802654 <__umoddi3+0xfc>
  8025a8:	0f bd e8             	bsr    %eax,%ebp
  8025ab:	83 f5 1f             	xor    $0x1f,%ebp
  8025ae:	0f 84 ac 00 00 00    	je     802660 <__umoddi3+0x108>
  8025b4:	bf 20 00 00 00       	mov    $0x20,%edi
  8025b9:	29 ef                	sub    %ebp,%edi
  8025bb:	89 fe                	mov    %edi,%esi
  8025bd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8025c1:	89 e9                	mov    %ebp,%ecx
  8025c3:	d3 e0                	shl    %cl,%eax
  8025c5:	89 d7                	mov    %edx,%edi
  8025c7:	89 f1                	mov    %esi,%ecx
  8025c9:	d3 ef                	shr    %cl,%edi
  8025cb:	09 c7                	or     %eax,%edi
  8025cd:	89 e9                	mov    %ebp,%ecx
  8025cf:	d3 e2                	shl    %cl,%edx
  8025d1:	89 14 24             	mov    %edx,(%esp)
  8025d4:	89 d8                	mov    %ebx,%eax
  8025d6:	d3 e0                	shl    %cl,%eax
  8025d8:	89 c2                	mov    %eax,%edx
  8025da:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025de:	d3 e0                	shl    %cl,%eax
  8025e0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8025e4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025e8:	89 f1                	mov    %esi,%ecx
  8025ea:	d3 e8                	shr    %cl,%eax
  8025ec:	09 d0                	or     %edx,%eax
  8025ee:	d3 eb                	shr    %cl,%ebx
  8025f0:	89 da                	mov    %ebx,%edx
  8025f2:	f7 f7                	div    %edi
  8025f4:	89 d3                	mov    %edx,%ebx
  8025f6:	f7 24 24             	mull   (%esp)
  8025f9:	89 c6                	mov    %eax,%esi
  8025fb:	89 d1                	mov    %edx,%ecx
  8025fd:	39 d3                	cmp    %edx,%ebx
  8025ff:	0f 82 87 00 00 00    	jb     80268c <__umoddi3+0x134>
  802605:	0f 84 91 00 00 00    	je     80269c <__umoddi3+0x144>
  80260b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80260f:	29 f2                	sub    %esi,%edx
  802611:	19 cb                	sbb    %ecx,%ebx
  802613:	89 d8                	mov    %ebx,%eax
  802615:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802619:	d3 e0                	shl    %cl,%eax
  80261b:	89 e9                	mov    %ebp,%ecx
  80261d:	d3 ea                	shr    %cl,%edx
  80261f:	09 d0                	or     %edx,%eax
  802621:	89 e9                	mov    %ebp,%ecx
  802623:	d3 eb                	shr    %cl,%ebx
  802625:	89 da                	mov    %ebx,%edx
  802627:	83 c4 1c             	add    $0x1c,%esp
  80262a:	5b                   	pop    %ebx
  80262b:	5e                   	pop    %esi
  80262c:	5f                   	pop    %edi
  80262d:	5d                   	pop    %ebp
  80262e:	c3                   	ret    
  80262f:	90                   	nop
  802630:	89 fd                	mov    %edi,%ebp
  802632:	85 ff                	test   %edi,%edi
  802634:	75 0b                	jne    802641 <__umoddi3+0xe9>
  802636:	b8 01 00 00 00       	mov    $0x1,%eax
  80263b:	31 d2                	xor    %edx,%edx
  80263d:	f7 f7                	div    %edi
  80263f:	89 c5                	mov    %eax,%ebp
  802641:	89 f0                	mov    %esi,%eax
  802643:	31 d2                	xor    %edx,%edx
  802645:	f7 f5                	div    %ebp
  802647:	89 c8                	mov    %ecx,%eax
  802649:	f7 f5                	div    %ebp
  80264b:	89 d0                	mov    %edx,%eax
  80264d:	e9 44 ff ff ff       	jmp    802596 <__umoddi3+0x3e>
  802652:	66 90                	xchg   %ax,%ax
  802654:	89 c8                	mov    %ecx,%eax
  802656:	89 f2                	mov    %esi,%edx
  802658:	83 c4 1c             	add    $0x1c,%esp
  80265b:	5b                   	pop    %ebx
  80265c:	5e                   	pop    %esi
  80265d:	5f                   	pop    %edi
  80265e:	5d                   	pop    %ebp
  80265f:	c3                   	ret    
  802660:	3b 04 24             	cmp    (%esp),%eax
  802663:	72 06                	jb     80266b <__umoddi3+0x113>
  802665:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802669:	77 0f                	ja     80267a <__umoddi3+0x122>
  80266b:	89 f2                	mov    %esi,%edx
  80266d:	29 f9                	sub    %edi,%ecx
  80266f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802673:	89 14 24             	mov    %edx,(%esp)
  802676:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80267a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80267e:	8b 14 24             	mov    (%esp),%edx
  802681:	83 c4 1c             	add    $0x1c,%esp
  802684:	5b                   	pop    %ebx
  802685:	5e                   	pop    %esi
  802686:	5f                   	pop    %edi
  802687:	5d                   	pop    %ebp
  802688:	c3                   	ret    
  802689:	8d 76 00             	lea    0x0(%esi),%esi
  80268c:	2b 04 24             	sub    (%esp),%eax
  80268f:	19 fa                	sbb    %edi,%edx
  802691:	89 d1                	mov    %edx,%ecx
  802693:	89 c6                	mov    %eax,%esi
  802695:	e9 71 ff ff ff       	jmp    80260b <__umoddi3+0xb3>
  80269a:	66 90                	xchg   %ax,%ax
  80269c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8026a0:	72 ea                	jb     80268c <__umoddi3+0x134>
  8026a2:	89 d9                	mov    %ebx,%ecx
  8026a4:	e9 62 ff ff ff       	jmp    80260b <__umoddi3+0xb3>
