
obj/user/quicksort_freeheap:     file format elf32-i386


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
  800031:	e8 92 05 00 00       	call   8005c8 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);
uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 24 01 00 00    	sub    $0x124,%esp
	char Chose ;
	char Line[255] ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800049:	e8 bc 1c 00 00       	call   801d0a <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 ce 1c 00 00       	call   801d23 <sys_calculate_modified_frames>
  800055:	01 d8                	add    %ebx,%eax
  800057:	89 45 f0             	mov    %eax,-0x10(%ebp)

		Iteration++ ;
  80005a:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();

			readline("Enter the number of elements: ", Line);
  80005d:	83 ec 08             	sub    $0x8,%esp
  800060:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800066:	50                   	push   %eax
  800067:	68 20 24 80 00       	push   $0x802420
  80006c:	e8 8f 0f 00 00       	call   801000 <readline>
  800071:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  800074:	83 ec 04             	sub    $0x4,%esp
  800077:	6a 0a                	push   $0xa
  800079:	6a 00                	push   $0x0
  80007b:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 df 14 00 00       	call   801566 <strtol>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 ec             	mov    %eax,-0x14(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80008d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 ac 18 00 00       	call   801948 <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 40 24 80 00       	push   $0x802440
  8000aa:	e8 cf 08 00 00       	call   80097e <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 63 24 80 00       	push   $0x802463
  8000ba:	e8 bf 08 00 00       	call   80097e <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 71 24 80 00       	push   $0x802471
  8000ca:	e8 af 08 00 00       	call   80097e <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\nSelect: ") ;
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 80 24 80 00       	push   $0x802480
  8000da:	e8 9f 08 00 00       	call   80097e <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8000e2:	e8 89 04 00 00       	call   800570 <getchar>
  8000e7:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  8000ea:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8000ee:	83 ec 0c             	sub    $0xc,%esp
  8000f1:	50                   	push   %eax
  8000f2:	e8 31 04 00 00       	call   800528 <cputchar>
  8000f7:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8000fa:	83 ec 0c             	sub    $0xc,%esp
  8000fd:	6a 0a                	push   $0xa
  8000ff:	e8 24 04 00 00       	call   800528 <cputchar>
  800104:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800107:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80010b:	83 f8 62             	cmp    $0x62,%eax
  80010e:	74 1d                	je     80012d <_main+0xf5>
  800110:	83 f8 63             	cmp    $0x63,%eax
  800113:	74 2b                	je     800140 <_main+0x108>
  800115:	83 f8 61             	cmp    $0x61,%eax
  800118:	75 39                	jne    800153 <_main+0x11b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80011a:	83 ec 08             	sub    $0x8,%esp
  80011d:	ff 75 ec             	pushl  -0x14(%ebp)
  800120:	ff 75 e8             	pushl  -0x18(%ebp)
  800123:	e8 c8 02 00 00       	call   8003f0 <InitializeAscending>
  800128:	83 c4 10             	add    $0x10,%esp
			break ;
  80012b:	eb 37                	jmp    800164 <_main+0x12c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80012d:	83 ec 08             	sub    $0x8,%esp
  800130:	ff 75 ec             	pushl  -0x14(%ebp)
  800133:	ff 75 e8             	pushl  -0x18(%ebp)
  800136:	e8 e6 02 00 00       	call   800421 <InitializeDescending>
  80013b:	83 c4 10             	add    $0x10,%esp
			break ;
  80013e:	eb 24                	jmp    800164 <_main+0x12c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800140:	83 ec 08             	sub    $0x8,%esp
  800143:	ff 75 ec             	pushl  -0x14(%ebp)
  800146:	ff 75 e8             	pushl  -0x18(%ebp)
  800149:	e8 08 03 00 00       	call   800456 <InitializeSemiRandom>
  80014e:	83 c4 10             	add    $0x10,%esp
			break ;
  800151:	eb 11                	jmp    800164 <_main+0x12c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800153:	83 ec 08             	sub    $0x8,%esp
  800156:	ff 75 ec             	pushl  -0x14(%ebp)
  800159:	ff 75 e8             	pushl  -0x18(%ebp)
  80015c:	e8 f5 02 00 00       	call   800456 <InitializeSemiRandom>
  800161:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800164:	83 ec 08             	sub    $0x8,%esp
  800167:	ff 75 ec             	pushl  -0x14(%ebp)
  80016a:	ff 75 e8             	pushl  -0x18(%ebp)
  80016d:	e8 c3 00 00 00       	call   800235 <QuickSort>
  800172:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800175:	83 ec 08             	sub    $0x8,%esp
  800178:	ff 75 ec             	pushl  -0x14(%ebp)
  80017b:	ff 75 e8             	pushl  -0x18(%ebp)
  80017e:	e8 c3 01 00 00       	call   800346 <CheckSorted>
  800183:	83 c4 10             	add    $0x10,%esp
  800186:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800189:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80018d:	75 14                	jne    8001a3 <_main+0x16b>
  80018f:	83 ec 04             	sub    $0x4,%esp
  800192:	68 98 24 80 00       	push   $0x802498
  800197:	6a 41                	push   $0x41
  800199:	68 ba 24 80 00       	push   $0x8024ba
  80019e:	e8 27 05 00 00       	call   8006ca <_panic>
		else
		{ 
				cprintf("===============================================\n") ;
  8001a3:	83 ec 0c             	sub    $0xc,%esp
  8001a6:	68 d4 24 80 00       	push   $0x8024d4
  8001ab:	e8 ce 07 00 00       	call   80097e <cprintf>
  8001b0:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001b3:	83 ec 0c             	sub    $0xc,%esp
  8001b6:	68 08 25 80 00       	push   $0x802508
  8001bb:	e8 be 07 00 00       	call   80097e <cprintf>
  8001c0:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  8001c3:	83 ec 0c             	sub    $0xc,%esp
  8001c6:	68 3c 25 80 00       	push   $0x80253c
  8001cb:	e8 ae 07 00 00       	call   80097e <cprintf>
  8001d0:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

			cprintf("Freeing the Heap...\n\n") ;
  8001d3:	83 ec 0c             	sub    $0xc,%esp
  8001d6:	68 6e 25 80 00       	push   $0x80256e
  8001db:	e8 9e 07 00 00       	call   80097e <cprintf>
  8001e0:	83 c4 10             	add    $0x10,%esp

		//freeHeap() ;

		///========================================================================
	//sys_disable_interrupt();
			cprintf("Do you want to repeat (y/n): ") ;
  8001e3:	83 ec 0c             	sub    $0xc,%esp
  8001e6:	68 84 25 80 00       	push   $0x802584
  8001eb:	e8 8e 07 00 00       	call   80097e <cprintf>
  8001f0:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8001f3:	e8 78 03 00 00       	call   800570 <getchar>
  8001f8:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  8001fb:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8001ff:	83 ec 0c             	sub    $0xc,%esp
  800202:	50                   	push   %eax
  800203:	e8 20 03 00 00       	call   800528 <cputchar>
  800208:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80020b:	83 ec 0c             	sub    $0xc,%esp
  80020e:	6a 0a                	push   $0xa
  800210:	e8 13 03 00 00       	call   800528 <cputchar>
  800215:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800218:	83 ec 0c             	sub    $0xc,%esp
  80021b:	6a 0a                	push   $0xa
  80021d:	e8 06 03 00 00       	call   800528 <cputchar>
  800222:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();

	} while (Chose == 'y');
  800225:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800229:	0f 84 1a fe ff ff    	je     800049 <_main+0x11>

}
  80022f:	90                   	nop
  800230:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800233:	c9                   	leave  
  800234:	c3                   	ret    

00800235 <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  800235:	55                   	push   %ebp
  800236:	89 e5                	mov    %esp,%ebp
  800238:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80023b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023e:	48                   	dec    %eax
  80023f:	50                   	push   %eax
  800240:	6a 00                	push   $0x0
  800242:	ff 75 0c             	pushl  0xc(%ebp)
  800245:	ff 75 08             	pushl  0x8(%ebp)
  800248:	e8 06 00 00 00       	call   800253 <QSort>
  80024d:	83 c4 10             	add    $0x10,%esp
}
  800250:	90                   	nop
  800251:	c9                   	leave  
  800252:	c3                   	ret    

00800253 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800253:	55                   	push   %ebp
  800254:	89 e5                	mov    %esp,%ebp
  800256:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800259:	8b 45 10             	mov    0x10(%ebp),%eax
  80025c:	3b 45 14             	cmp    0x14(%ebp),%eax
  80025f:	0f 8d de 00 00 00    	jge    800343 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800265:	8b 45 10             	mov    0x10(%ebp),%eax
  800268:	40                   	inc    %eax
  800269:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80026c:	8b 45 14             	mov    0x14(%ebp),%eax
  80026f:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800272:	e9 80 00 00 00       	jmp    8002f7 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800277:	ff 45 f4             	incl   -0xc(%ebp)
  80027a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80027d:	3b 45 14             	cmp    0x14(%ebp),%eax
  800280:	7f 2b                	jg     8002ad <QSort+0x5a>
  800282:	8b 45 10             	mov    0x10(%ebp),%eax
  800285:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80028c:	8b 45 08             	mov    0x8(%ebp),%eax
  80028f:	01 d0                	add    %edx,%eax
  800291:	8b 10                	mov    (%eax),%edx
  800293:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800296:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80029d:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a0:	01 c8                	add    %ecx,%eax
  8002a2:	8b 00                	mov    (%eax),%eax
  8002a4:	39 c2                	cmp    %eax,%edx
  8002a6:	7d cf                	jge    800277 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002a8:	eb 03                	jmp    8002ad <QSort+0x5a>
  8002aa:	ff 4d f0             	decl   -0x10(%ebp)
  8002ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002b0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002b3:	7e 26                	jle    8002db <QSort+0x88>
  8002b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c2:	01 d0                	add    %edx,%eax
  8002c4:	8b 10                	mov    (%eax),%edx
  8002c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002c9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d3:	01 c8                	add    %ecx,%eax
  8002d5:	8b 00                	mov    (%eax),%eax
  8002d7:	39 c2                	cmp    %eax,%edx
  8002d9:	7e cf                	jle    8002aa <QSort+0x57>

		if (i <= j)
  8002db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002e1:	7f 14                	jg     8002f7 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8002e3:	83 ec 04             	sub    $0x4,%esp
  8002e6:	ff 75 f0             	pushl  -0x10(%ebp)
  8002e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ec:	ff 75 08             	pushl  0x8(%ebp)
  8002ef:	e8 a9 00 00 00       	call   80039d <Swap>
  8002f4:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8002f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002fa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002fd:	0f 8e 77 ff ff ff    	jle    80027a <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800303:	83 ec 04             	sub    $0x4,%esp
  800306:	ff 75 f0             	pushl  -0x10(%ebp)
  800309:	ff 75 10             	pushl  0x10(%ebp)
  80030c:	ff 75 08             	pushl  0x8(%ebp)
  80030f:	e8 89 00 00 00       	call   80039d <Swap>
  800314:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800317:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80031a:	48                   	dec    %eax
  80031b:	50                   	push   %eax
  80031c:	ff 75 10             	pushl  0x10(%ebp)
  80031f:	ff 75 0c             	pushl  0xc(%ebp)
  800322:	ff 75 08             	pushl  0x8(%ebp)
  800325:	e8 29 ff ff ff       	call   800253 <QSort>
  80032a:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80032d:	ff 75 14             	pushl  0x14(%ebp)
  800330:	ff 75 f4             	pushl  -0xc(%ebp)
  800333:	ff 75 0c             	pushl  0xc(%ebp)
  800336:	ff 75 08             	pushl  0x8(%ebp)
  800339:	e8 15 ff ff ff       	call   800253 <QSort>
  80033e:	83 c4 10             	add    $0x10,%esp
  800341:	eb 01                	jmp    800344 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800343:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800344:	c9                   	leave  
  800345:	c3                   	ret    

00800346 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800346:	55                   	push   %ebp
  800347:	89 e5                	mov    %esp,%ebp
  800349:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80034c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800353:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80035a:	eb 33                	jmp    80038f <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80035c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80035f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800366:	8b 45 08             	mov    0x8(%ebp),%eax
  800369:	01 d0                	add    %edx,%eax
  80036b:	8b 10                	mov    (%eax),%edx
  80036d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800370:	40                   	inc    %eax
  800371:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800378:	8b 45 08             	mov    0x8(%ebp),%eax
  80037b:	01 c8                	add    %ecx,%eax
  80037d:	8b 00                	mov    (%eax),%eax
  80037f:	39 c2                	cmp    %eax,%edx
  800381:	7e 09                	jle    80038c <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800383:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80038a:	eb 0c                	jmp    800398 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80038c:	ff 45 f8             	incl   -0x8(%ebp)
  80038f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800392:	48                   	dec    %eax
  800393:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800396:	7f c4                	jg     80035c <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800398:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80039b:	c9                   	leave  
  80039c:	c3                   	ret    

0080039d <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80039d:	55                   	push   %ebp
  80039e:	89 e5                	mov    %esp,%ebp
  8003a0:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b0:	01 d0                	add    %edx,%eax
  8003b2:	8b 00                	mov    (%eax),%eax
  8003b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c4:	01 c2                	add    %eax,%edx
  8003c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8003c9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d3:	01 c8                	add    %ecx,%eax
  8003d5:	8b 00                	mov    (%eax),%eax
  8003d7:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8003d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8003dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	01 c2                	add    %eax,%edx
  8003e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003eb:	89 02                	mov    %eax,(%edx)
}
  8003ed:	90                   	nop
  8003ee:	c9                   	leave  
  8003ef:	c3                   	ret    

008003f0 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8003f0:	55                   	push   %ebp
  8003f1:	89 e5                	mov    %esp,%ebp
  8003f3:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003fd:	eb 17                	jmp    800416 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8003ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800402:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800409:	8b 45 08             	mov    0x8(%ebp),%eax
  80040c:	01 c2                	add    %eax,%edx
  80040e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800411:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800413:	ff 45 fc             	incl   -0x4(%ebp)
  800416:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800419:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80041c:	7c e1                	jl     8003ff <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80041e:	90                   	nop
  80041f:	c9                   	leave  
  800420:	c3                   	ret    

00800421 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800421:	55                   	push   %ebp
  800422:	89 e5                	mov    %esp,%ebp
  800424:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800427:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80042e:	eb 1b                	jmp    80044b <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800430:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800433:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	01 c2                	add    %eax,%edx
  80043f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800442:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800445:	48                   	dec    %eax
  800446:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800448:	ff 45 fc             	incl   -0x4(%ebp)
  80044b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80044e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800451:	7c dd                	jl     800430 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800453:	90                   	nop
  800454:	c9                   	leave  
  800455:	c3                   	ret    

00800456 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800456:	55                   	push   %ebp
  800457:	89 e5                	mov    %esp,%ebp
  800459:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80045c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80045f:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800464:	f7 e9                	imul   %ecx
  800466:	c1 f9 1f             	sar    $0x1f,%ecx
  800469:	89 d0                	mov    %edx,%eax
  80046b:	29 c8                	sub    %ecx,%eax
  80046d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800470:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800477:	eb 1e                	jmp    800497 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800479:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80047c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800483:	8b 45 08             	mov    0x8(%ebp),%eax
  800486:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800489:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048c:	99                   	cltd   
  80048d:	f7 7d f8             	idivl  -0x8(%ebp)
  800490:	89 d0                	mov    %edx,%eax
  800492:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800494:	ff 45 fc             	incl   -0x4(%ebp)
  800497:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80049d:	7c da                	jl     800479 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  80049f:	90                   	nop
  8004a0:	c9                   	leave  
  8004a1:	c3                   	ret    

008004a2 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004a2:	55                   	push   %ebp
  8004a3:	89 e5                	mov    %esp,%ebp
  8004a5:	83 ec 18             	sub    $0x18,%esp
		int i ;
		int NumsPerLine = 20 ;
  8004a8:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8004af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004b6:	eb 42                	jmp    8004fa <PrintElements+0x58>
		{
			if (i%NumsPerLine == 0)
  8004b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004bb:	99                   	cltd   
  8004bc:	f7 7d f0             	idivl  -0x10(%ebp)
  8004bf:	89 d0                	mov    %edx,%eax
  8004c1:	85 c0                	test   %eax,%eax
  8004c3:	75 10                	jne    8004d5 <PrintElements+0x33>
				cprintf("\n");
  8004c5:	83 ec 0c             	sub    $0xc,%esp
  8004c8:	68 a2 25 80 00       	push   $0x8025a2
  8004cd:	e8 ac 04 00 00       	call   80097e <cprintf>
  8004d2:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  8004d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004d8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004df:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e2:	01 d0                	add    %edx,%eax
  8004e4:	8b 00                	mov    (%eax),%eax
  8004e6:	83 ec 08             	sub    $0x8,%esp
  8004e9:	50                   	push   %eax
  8004ea:	68 a4 25 80 00       	push   $0x8025a4
  8004ef:	e8 8a 04 00 00       	call   80097e <cprintf>
  8004f4:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8004f7:	ff 45 f4             	incl   -0xc(%ebp)
  8004fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004fd:	48                   	dec    %eax
  8004fe:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800501:	7f b5                	jg     8004b8 <PrintElements+0x16>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  800503:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800506:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	01 d0                	add    %edx,%eax
  800512:	8b 00                	mov    (%eax),%eax
  800514:	83 ec 08             	sub    $0x8,%esp
  800517:	50                   	push   %eax
  800518:	68 a9 25 80 00       	push   $0x8025a9
  80051d:	e8 5c 04 00 00       	call   80097e <cprintf>
  800522:	83 c4 10             	add    $0x10,%esp
}
  800525:	90                   	nop
  800526:	c9                   	leave  
  800527:	c3                   	ret    

00800528 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800528:	55                   	push   %ebp
  800529:	89 e5                	mov    %esp,%ebp
  80052b:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80052e:	8b 45 08             	mov    0x8(%ebp),%eax
  800531:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800534:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800538:	83 ec 0c             	sub    $0xc,%esp
  80053b:	50                   	push   %eax
  80053c:	e8 cd 18 00 00       	call   801e0e <sys_cputc>
  800541:	83 c4 10             	add    $0x10,%esp
}
  800544:	90                   	nop
  800545:	c9                   	leave  
  800546:	c3                   	ret    

00800547 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800547:	55                   	push   %ebp
  800548:	89 e5                	mov    %esp,%ebp
  80054a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80054d:	e8 88 18 00 00       	call   801dda <sys_disable_interrupt>
	char c = ch;
  800552:	8b 45 08             	mov    0x8(%ebp),%eax
  800555:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800558:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80055c:	83 ec 0c             	sub    $0xc,%esp
  80055f:	50                   	push   %eax
  800560:	e8 a9 18 00 00       	call   801e0e <sys_cputc>
  800565:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800568:	e8 87 18 00 00       	call   801df4 <sys_enable_interrupt>
}
  80056d:	90                   	nop
  80056e:	c9                   	leave  
  80056f:	c3                   	ret    

00800570 <getchar>:

int
getchar(void)
{
  800570:	55                   	push   %ebp
  800571:	89 e5                	mov    %esp,%ebp
  800573:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800576:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80057d:	eb 08                	jmp    800587 <getchar+0x17>
	{
		c = sys_cgetc();
  80057f:	e8 6e 16 00 00       	call   801bf2 <sys_cgetc>
  800584:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800587:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80058b:	74 f2                	je     80057f <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80058d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800590:	c9                   	leave  
  800591:	c3                   	ret    

00800592 <atomic_getchar>:

int
atomic_getchar(void)
{
  800592:	55                   	push   %ebp
  800593:	89 e5                	mov    %esp,%ebp
  800595:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800598:	e8 3d 18 00 00       	call   801dda <sys_disable_interrupt>
	int c=0;
  80059d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005a4:	eb 08                	jmp    8005ae <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005a6:	e8 47 16 00 00       	call   801bf2 <sys_cgetc>
  8005ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005b2:	74 f2                	je     8005a6 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005b4:	e8 3b 18 00 00       	call   801df4 <sys_enable_interrupt>
	return c;
  8005b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005bc:	c9                   	leave  
  8005bd:	c3                   	ret    

008005be <iscons>:

int iscons(int fdnum)
{
  8005be:	55                   	push   %ebp
  8005bf:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005c1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005c6:	5d                   	pop    %ebp
  8005c7:	c3                   	ret    

008005c8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005c8:	55                   	push   %ebp
  8005c9:	89 e5                	mov    %esp,%ebp
  8005cb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005ce:	e8 6c 16 00 00       	call   801c3f <sys_getenvindex>
  8005d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005d9:	89 d0                	mov    %edx,%eax
  8005db:	01 c0                	add    %eax,%eax
  8005dd:	01 d0                	add    %edx,%eax
  8005df:	c1 e0 02             	shl    $0x2,%eax
  8005e2:	01 d0                	add    %edx,%eax
  8005e4:	c1 e0 06             	shl    $0x6,%eax
  8005e7:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005ec:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005f1:	a1 24 30 80 00       	mov    0x803024,%eax
  8005f6:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8005fc:	84 c0                	test   %al,%al
  8005fe:	74 0f                	je     80060f <libmain+0x47>
		binaryname = myEnv->prog_name;
  800600:	a1 24 30 80 00       	mov    0x803024,%eax
  800605:	05 f4 02 00 00       	add    $0x2f4,%eax
  80060a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80060f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800613:	7e 0a                	jle    80061f <libmain+0x57>
		binaryname = argv[0];
  800615:	8b 45 0c             	mov    0xc(%ebp),%eax
  800618:	8b 00                	mov    (%eax),%eax
  80061a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80061f:	83 ec 08             	sub    $0x8,%esp
  800622:	ff 75 0c             	pushl  0xc(%ebp)
  800625:	ff 75 08             	pushl  0x8(%ebp)
  800628:	e8 0b fa ff ff       	call   800038 <_main>
  80062d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800630:	e8 a5 17 00 00       	call   801dda <sys_disable_interrupt>
	cprintf("**************************************\n");
  800635:	83 ec 0c             	sub    $0xc,%esp
  800638:	68 c8 25 80 00       	push   $0x8025c8
  80063d:	e8 3c 03 00 00       	call   80097e <cprintf>
  800642:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800645:	a1 24 30 80 00       	mov    0x803024,%eax
  80064a:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800650:	a1 24 30 80 00       	mov    0x803024,%eax
  800655:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80065b:	83 ec 04             	sub    $0x4,%esp
  80065e:	52                   	push   %edx
  80065f:	50                   	push   %eax
  800660:	68 f0 25 80 00       	push   $0x8025f0
  800665:	e8 14 03 00 00       	call   80097e <cprintf>
  80066a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80066d:	a1 24 30 80 00       	mov    0x803024,%eax
  800672:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800678:	83 ec 08             	sub    $0x8,%esp
  80067b:	50                   	push   %eax
  80067c:	68 15 26 80 00       	push   $0x802615
  800681:	e8 f8 02 00 00       	call   80097e <cprintf>
  800686:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800689:	83 ec 0c             	sub    $0xc,%esp
  80068c:	68 c8 25 80 00       	push   $0x8025c8
  800691:	e8 e8 02 00 00       	call   80097e <cprintf>
  800696:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800699:	e8 56 17 00 00       	call   801df4 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80069e:	e8 19 00 00 00       	call   8006bc <exit>
}
  8006a3:	90                   	nop
  8006a4:	c9                   	leave  
  8006a5:	c3                   	ret    

008006a6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006a6:	55                   	push   %ebp
  8006a7:	89 e5                	mov    %esp,%ebp
  8006a9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006ac:	83 ec 0c             	sub    $0xc,%esp
  8006af:	6a 00                	push   $0x0
  8006b1:	e8 55 15 00 00       	call   801c0b <sys_env_destroy>
  8006b6:	83 c4 10             	add    $0x10,%esp
}
  8006b9:	90                   	nop
  8006ba:	c9                   	leave  
  8006bb:	c3                   	ret    

008006bc <exit>:

void
exit(void)
{
  8006bc:	55                   	push   %ebp
  8006bd:	89 e5                	mov    %esp,%ebp
  8006bf:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006c2:	e8 aa 15 00 00       	call   801c71 <sys_env_exit>
}
  8006c7:	90                   	nop
  8006c8:	c9                   	leave  
  8006c9:	c3                   	ret    

008006ca <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006ca:	55                   	push   %ebp
  8006cb:	89 e5                	mov    %esp,%ebp
  8006cd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006d0:	8d 45 10             	lea    0x10(%ebp),%eax
  8006d3:	83 c0 04             	add    $0x4,%eax
  8006d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006d9:	a1 34 30 80 00       	mov    0x803034,%eax
  8006de:	85 c0                	test   %eax,%eax
  8006e0:	74 16                	je     8006f8 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006e2:	a1 34 30 80 00       	mov    0x803034,%eax
  8006e7:	83 ec 08             	sub    $0x8,%esp
  8006ea:	50                   	push   %eax
  8006eb:	68 2c 26 80 00       	push   $0x80262c
  8006f0:	e8 89 02 00 00       	call   80097e <cprintf>
  8006f5:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006f8:	a1 00 30 80 00       	mov    0x803000,%eax
  8006fd:	ff 75 0c             	pushl  0xc(%ebp)
  800700:	ff 75 08             	pushl  0x8(%ebp)
  800703:	50                   	push   %eax
  800704:	68 31 26 80 00       	push   $0x802631
  800709:	e8 70 02 00 00       	call   80097e <cprintf>
  80070e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800711:	8b 45 10             	mov    0x10(%ebp),%eax
  800714:	83 ec 08             	sub    $0x8,%esp
  800717:	ff 75 f4             	pushl  -0xc(%ebp)
  80071a:	50                   	push   %eax
  80071b:	e8 f3 01 00 00       	call   800913 <vcprintf>
  800720:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800723:	83 ec 08             	sub    $0x8,%esp
  800726:	6a 00                	push   $0x0
  800728:	68 4d 26 80 00       	push   $0x80264d
  80072d:	e8 e1 01 00 00       	call   800913 <vcprintf>
  800732:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800735:	e8 82 ff ff ff       	call   8006bc <exit>

	// should not return here
	while (1) ;
  80073a:	eb fe                	jmp    80073a <_panic+0x70>

0080073c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80073c:	55                   	push   %ebp
  80073d:	89 e5                	mov    %esp,%ebp
  80073f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800742:	a1 24 30 80 00       	mov    0x803024,%eax
  800747:	8b 50 74             	mov    0x74(%eax),%edx
  80074a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80074d:	39 c2                	cmp    %eax,%edx
  80074f:	74 14                	je     800765 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800751:	83 ec 04             	sub    $0x4,%esp
  800754:	68 50 26 80 00       	push   $0x802650
  800759:	6a 26                	push   $0x26
  80075b:	68 9c 26 80 00       	push   $0x80269c
  800760:	e8 65 ff ff ff       	call   8006ca <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800765:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80076c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800773:	e9 c2 00 00 00       	jmp    80083a <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800778:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80077b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800782:	8b 45 08             	mov    0x8(%ebp),%eax
  800785:	01 d0                	add    %edx,%eax
  800787:	8b 00                	mov    (%eax),%eax
  800789:	85 c0                	test   %eax,%eax
  80078b:	75 08                	jne    800795 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80078d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800790:	e9 a2 00 00 00       	jmp    800837 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800795:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80079c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007a3:	eb 69                	jmp    80080e <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007a5:	a1 24 30 80 00       	mov    0x803024,%eax
  8007aa:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007b0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007b3:	89 d0                	mov    %edx,%eax
  8007b5:	01 c0                	add    %eax,%eax
  8007b7:	01 d0                	add    %edx,%eax
  8007b9:	c1 e0 02             	shl    $0x2,%eax
  8007bc:	01 c8                	add    %ecx,%eax
  8007be:	8a 40 04             	mov    0x4(%eax),%al
  8007c1:	84 c0                	test   %al,%al
  8007c3:	75 46                	jne    80080b <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007c5:	a1 24 30 80 00       	mov    0x803024,%eax
  8007ca:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007d0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007d3:	89 d0                	mov    %edx,%eax
  8007d5:	01 c0                	add    %eax,%eax
  8007d7:	01 d0                	add    %edx,%eax
  8007d9:	c1 e0 02             	shl    $0x2,%eax
  8007dc:	01 c8                	add    %ecx,%eax
  8007de:	8b 00                	mov    (%eax),%eax
  8007e0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007e3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007e6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007eb:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007f0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fa:	01 c8                	add    %ecx,%eax
  8007fc:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007fe:	39 c2                	cmp    %eax,%edx
  800800:	75 09                	jne    80080b <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800802:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800809:	eb 12                	jmp    80081d <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80080b:	ff 45 e8             	incl   -0x18(%ebp)
  80080e:	a1 24 30 80 00       	mov    0x803024,%eax
  800813:	8b 50 74             	mov    0x74(%eax),%edx
  800816:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800819:	39 c2                	cmp    %eax,%edx
  80081b:	77 88                	ja     8007a5 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80081d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800821:	75 14                	jne    800837 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800823:	83 ec 04             	sub    $0x4,%esp
  800826:	68 a8 26 80 00       	push   $0x8026a8
  80082b:	6a 3a                	push   $0x3a
  80082d:	68 9c 26 80 00       	push   $0x80269c
  800832:	e8 93 fe ff ff       	call   8006ca <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800837:	ff 45 f0             	incl   -0x10(%ebp)
  80083a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80083d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800840:	0f 8c 32 ff ff ff    	jl     800778 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800846:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80084d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800854:	eb 26                	jmp    80087c <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800856:	a1 24 30 80 00       	mov    0x803024,%eax
  80085b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800861:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800864:	89 d0                	mov    %edx,%eax
  800866:	01 c0                	add    %eax,%eax
  800868:	01 d0                	add    %edx,%eax
  80086a:	c1 e0 02             	shl    $0x2,%eax
  80086d:	01 c8                	add    %ecx,%eax
  80086f:	8a 40 04             	mov    0x4(%eax),%al
  800872:	3c 01                	cmp    $0x1,%al
  800874:	75 03                	jne    800879 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800876:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800879:	ff 45 e0             	incl   -0x20(%ebp)
  80087c:	a1 24 30 80 00       	mov    0x803024,%eax
  800881:	8b 50 74             	mov    0x74(%eax),%edx
  800884:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800887:	39 c2                	cmp    %eax,%edx
  800889:	77 cb                	ja     800856 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80088b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80088e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800891:	74 14                	je     8008a7 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800893:	83 ec 04             	sub    $0x4,%esp
  800896:	68 fc 26 80 00       	push   $0x8026fc
  80089b:	6a 44                	push   $0x44
  80089d:	68 9c 26 80 00       	push   $0x80269c
  8008a2:	e8 23 fe ff ff       	call   8006ca <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008a7:	90                   	nop
  8008a8:	c9                   	leave  
  8008a9:	c3                   	ret    

008008aa <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008aa:	55                   	push   %ebp
  8008ab:	89 e5                	mov    %esp,%ebp
  8008ad:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b3:	8b 00                	mov    (%eax),%eax
  8008b5:	8d 48 01             	lea    0x1(%eax),%ecx
  8008b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008bb:	89 0a                	mov    %ecx,(%edx)
  8008bd:	8b 55 08             	mov    0x8(%ebp),%edx
  8008c0:	88 d1                	mov    %dl,%cl
  8008c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008cc:	8b 00                	mov    (%eax),%eax
  8008ce:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008d3:	75 2c                	jne    800901 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008d5:	a0 28 30 80 00       	mov    0x803028,%al
  8008da:	0f b6 c0             	movzbl %al,%eax
  8008dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e0:	8b 12                	mov    (%edx),%edx
  8008e2:	89 d1                	mov    %edx,%ecx
  8008e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e7:	83 c2 08             	add    $0x8,%edx
  8008ea:	83 ec 04             	sub    $0x4,%esp
  8008ed:	50                   	push   %eax
  8008ee:	51                   	push   %ecx
  8008ef:	52                   	push   %edx
  8008f0:	e8 d4 12 00 00       	call   801bc9 <sys_cputs>
  8008f5:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800901:	8b 45 0c             	mov    0xc(%ebp),%eax
  800904:	8b 40 04             	mov    0x4(%eax),%eax
  800907:	8d 50 01             	lea    0x1(%eax),%edx
  80090a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800910:	90                   	nop
  800911:	c9                   	leave  
  800912:	c3                   	ret    

00800913 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800913:	55                   	push   %ebp
  800914:	89 e5                	mov    %esp,%ebp
  800916:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80091c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800923:	00 00 00 
	b.cnt = 0;
  800926:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80092d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800930:	ff 75 0c             	pushl  0xc(%ebp)
  800933:	ff 75 08             	pushl  0x8(%ebp)
  800936:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80093c:	50                   	push   %eax
  80093d:	68 aa 08 80 00       	push   $0x8008aa
  800942:	e8 11 02 00 00       	call   800b58 <vprintfmt>
  800947:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80094a:	a0 28 30 80 00       	mov    0x803028,%al
  80094f:	0f b6 c0             	movzbl %al,%eax
  800952:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800958:	83 ec 04             	sub    $0x4,%esp
  80095b:	50                   	push   %eax
  80095c:	52                   	push   %edx
  80095d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800963:	83 c0 08             	add    $0x8,%eax
  800966:	50                   	push   %eax
  800967:	e8 5d 12 00 00       	call   801bc9 <sys_cputs>
  80096c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80096f:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800976:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80097c:	c9                   	leave  
  80097d:	c3                   	ret    

0080097e <cprintf>:

int cprintf(const char *fmt, ...) {
  80097e:	55                   	push   %ebp
  80097f:	89 e5                	mov    %esp,%ebp
  800981:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800984:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  80098b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80098e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800991:	8b 45 08             	mov    0x8(%ebp),%eax
  800994:	83 ec 08             	sub    $0x8,%esp
  800997:	ff 75 f4             	pushl  -0xc(%ebp)
  80099a:	50                   	push   %eax
  80099b:	e8 73 ff ff ff       	call   800913 <vcprintf>
  8009a0:	83 c4 10             	add    $0x10,%esp
  8009a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009a9:	c9                   	leave  
  8009aa:	c3                   	ret    

008009ab <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009ab:	55                   	push   %ebp
  8009ac:	89 e5                	mov    %esp,%ebp
  8009ae:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009b1:	e8 24 14 00 00       	call   801dda <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009b6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bf:	83 ec 08             	sub    $0x8,%esp
  8009c2:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c5:	50                   	push   %eax
  8009c6:	e8 48 ff ff ff       	call   800913 <vcprintf>
  8009cb:	83 c4 10             	add    $0x10,%esp
  8009ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009d1:	e8 1e 14 00 00       	call   801df4 <sys_enable_interrupt>
	return cnt;
  8009d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009d9:	c9                   	leave  
  8009da:	c3                   	ret    

008009db <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009db:	55                   	push   %ebp
  8009dc:	89 e5                	mov    %esp,%ebp
  8009de:	53                   	push   %ebx
  8009df:	83 ec 14             	sub    $0x14,%esp
  8009e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8009e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009ee:	8b 45 18             	mov    0x18(%ebp),%eax
  8009f1:	ba 00 00 00 00       	mov    $0x0,%edx
  8009f6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009f9:	77 55                	ja     800a50 <printnum+0x75>
  8009fb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009fe:	72 05                	jb     800a05 <printnum+0x2a>
  800a00:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a03:	77 4b                	ja     800a50 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a05:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a08:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a0b:	8b 45 18             	mov    0x18(%ebp),%eax
  800a0e:	ba 00 00 00 00       	mov    $0x0,%edx
  800a13:	52                   	push   %edx
  800a14:	50                   	push   %eax
  800a15:	ff 75 f4             	pushl  -0xc(%ebp)
  800a18:	ff 75 f0             	pushl  -0x10(%ebp)
  800a1b:	e8 98 17 00 00       	call   8021b8 <__udivdi3>
  800a20:	83 c4 10             	add    $0x10,%esp
  800a23:	83 ec 04             	sub    $0x4,%esp
  800a26:	ff 75 20             	pushl  0x20(%ebp)
  800a29:	53                   	push   %ebx
  800a2a:	ff 75 18             	pushl  0x18(%ebp)
  800a2d:	52                   	push   %edx
  800a2e:	50                   	push   %eax
  800a2f:	ff 75 0c             	pushl  0xc(%ebp)
  800a32:	ff 75 08             	pushl  0x8(%ebp)
  800a35:	e8 a1 ff ff ff       	call   8009db <printnum>
  800a3a:	83 c4 20             	add    $0x20,%esp
  800a3d:	eb 1a                	jmp    800a59 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a3f:	83 ec 08             	sub    $0x8,%esp
  800a42:	ff 75 0c             	pushl  0xc(%ebp)
  800a45:	ff 75 20             	pushl  0x20(%ebp)
  800a48:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4b:	ff d0                	call   *%eax
  800a4d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a50:	ff 4d 1c             	decl   0x1c(%ebp)
  800a53:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a57:	7f e6                	jg     800a3f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a59:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a5c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a61:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a64:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a67:	53                   	push   %ebx
  800a68:	51                   	push   %ecx
  800a69:	52                   	push   %edx
  800a6a:	50                   	push   %eax
  800a6b:	e8 58 18 00 00       	call   8022c8 <__umoddi3>
  800a70:	83 c4 10             	add    $0x10,%esp
  800a73:	05 74 29 80 00       	add    $0x802974,%eax
  800a78:	8a 00                	mov    (%eax),%al
  800a7a:	0f be c0             	movsbl %al,%eax
  800a7d:	83 ec 08             	sub    $0x8,%esp
  800a80:	ff 75 0c             	pushl  0xc(%ebp)
  800a83:	50                   	push   %eax
  800a84:	8b 45 08             	mov    0x8(%ebp),%eax
  800a87:	ff d0                	call   *%eax
  800a89:	83 c4 10             	add    $0x10,%esp
}
  800a8c:	90                   	nop
  800a8d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a90:	c9                   	leave  
  800a91:	c3                   	ret    

00800a92 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a92:	55                   	push   %ebp
  800a93:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a95:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a99:	7e 1c                	jle    800ab7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9e:	8b 00                	mov    (%eax),%eax
  800aa0:	8d 50 08             	lea    0x8(%eax),%edx
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	89 10                	mov    %edx,(%eax)
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aab:	8b 00                	mov    (%eax),%eax
  800aad:	83 e8 08             	sub    $0x8,%eax
  800ab0:	8b 50 04             	mov    0x4(%eax),%edx
  800ab3:	8b 00                	mov    (%eax),%eax
  800ab5:	eb 40                	jmp    800af7 <getuint+0x65>
	else if (lflag)
  800ab7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800abb:	74 1e                	je     800adb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800abd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac0:	8b 00                	mov    (%eax),%eax
  800ac2:	8d 50 04             	lea    0x4(%eax),%edx
  800ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac8:	89 10                	mov    %edx,(%eax)
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	8b 00                	mov    (%eax),%eax
  800acf:	83 e8 04             	sub    $0x4,%eax
  800ad2:	8b 00                	mov    (%eax),%eax
  800ad4:	ba 00 00 00 00       	mov    $0x0,%edx
  800ad9:	eb 1c                	jmp    800af7 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800adb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ade:	8b 00                	mov    (%eax),%eax
  800ae0:	8d 50 04             	lea    0x4(%eax),%edx
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	89 10                	mov    %edx,(%eax)
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	8b 00                	mov    (%eax),%eax
  800aed:	83 e8 04             	sub    $0x4,%eax
  800af0:	8b 00                	mov    (%eax),%eax
  800af2:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800af7:	5d                   	pop    %ebp
  800af8:	c3                   	ret    

00800af9 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800af9:	55                   	push   %ebp
  800afa:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800afc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b00:	7e 1c                	jle    800b1e <getint+0x25>
		return va_arg(*ap, long long);
  800b02:	8b 45 08             	mov    0x8(%ebp),%eax
  800b05:	8b 00                	mov    (%eax),%eax
  800b07:	8d 50 08             	lea    0x8(%eax),%edx
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	89 10                	mov    %edx,(%eax)
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	8b 00                	mov    (%eax),%eax
  800b14:	83 e8 08             	sub    $0x8,%eax
  800b17:	8b 50 04             	mov    0x4(%eax),%edx
  800b1a:	8b 00                	mov    (%eax),%eax
  800b1c:	eb 38                	jmp    800b56 <getint+0x5d>
	else if (lflag)
  800b1e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b22:	74 1a                	je     800b3e <getint+0x45>
		return va_arg(*ap, long);
  800b24:	8b 45 08             	mov    0x8(%ebp),%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	8d 50 04             	lea    0x4(%eax),%edx
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2f:	89 10                	mov    %edx,(%eax)
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	8b 00                	mov    (%eax),%eax
  800b36:	83 e8 04             	sub    $0x4,%eax
  800b39:	8b 00                	mov    (%eax),%eax
  800b3b:	99                   	cltd   
  800b3c:	eb 18                	jmp    800b56 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	8b 00                	mov    (%eax),%eax
  800b43:	8d 50 04             	lea    0x4(%eax),%edx
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
  800b49:	89 10                	mov    %edx,(%eax)
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	8b 00                	mov    (%eax),%eax
  800b50:	83 e8 04             	sub    $0x4,%eax
  800b53:	8b 00                	mov    (%eax),%eax
  800b55:	99                   	cltd   
}
  800b56:	5d                   	pop    %ebp
  800b57:	c3                   	ret    

00800b58 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b58:	55                   	push   %ebp
  800b59:	89 e5                	mov    %esp,%ebp
  800b5b:	56                   	push   %esi
  800b5c:	53                   	push   %ebx
  800b5d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b60:	eb 17                	jmp    800b79 <vprintfmt+0x21>
			if (ch == '\0')
  800b62:	85 db                	test   %ebx,%ebx
  800b64:	0f 84 af 03 00 00    	je     800f19 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b6a:	83 ec 08             	sub    $0x8,%esp
  800b6d:	ff 75 0c             	pushl  0xc(%ebp)
  800b70:	53                   	push   %ebx
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	ff d0                	call   *%eax
  800b76:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b79:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7c:	8d 50 01             	lea    0x1(%eax),%edx
  800b7f:	89 55 10             	mov    %edx,0x10(%ebp)
  800b82:	8a 00                	mov    (%eax),%al
  800b84:	0f b6 d8             	movzbl %al,%ebx
  800b87:	83 fb 25             	cmp    $0x25,%ebx
  800b8a:	75 d6                	jne    800b62 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b8c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b90:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b97:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b9e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ba5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bac:	8b 45 10             	mov    0x10(%ebp),%eax
  800baf:	8d 50 01             	lea    0x1(%eax),%edx
  800bb2:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb5:	8a 00                	mov    (%eax),%al
  800bb7:	0f b6 d8             	movzbl %al,%ebx
  800bba:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bbd:	83 f8 55             	cmp    $0x55,%eax
  800bc0:	0f 87 2b 03 00 00    	ja     800ef1 <vprintfmt+0x399>
  800bc6:	8b 04 85 98 29 80 00 	mov    0x802998(,%eax,4),%eax
  800bcd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bcf:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bd3:	eb d7                	jmp    800bac <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bd5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bd9:	eb d1                	jmp    800bac <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bdb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800be2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800be5:	89 d0                	mov    %edx,%eax
  800be7:	c1 e0 02             	shl    $0x2,%eax
  800bea:	01 d0                	add    %edx,%eax
  800bec:	01 c0                	add    %eax,%eax
  800bee:	01 d8                	add    %ebx,%eax
  800bf0:	83 e8 30             	sub    $0x30,%eax
  800bf3:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bf6:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf9:	8a 00                	mov    (%eax),%al
  800bfb:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bfe:	83 fb 2f             	cmp    $0x2f,%ebx
  800c01:	7e 3e                	jle    800c41 <vprintfmt+0xe9>
  800c03:	83 fb 39             	cmp    $0x39,%ebx
  800c06:	7f 39                	jg     800c41 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c08:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c0b:	eb d5                	jmp    800be2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c0d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c10:	83 c0 04             	add    $0x4,%eax
  800c13:	89 45 14             	mov    %eax,0x14(%ebp)
  800c16:	8b 45 14             	mov    0x14(%ebp),%eax
  800c19:	83 e8 04             	sub    $0x4,%eax
  800c1c:	8b 00                	mov    (%eax),%eax
  800c1e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c21:	eb 1f                	jmp    800c42 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c23:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c27:	79 83                	jns    800bac <vprintfmt+0x54>
				width = 0;
  800c29:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c30:	e9 77 ff ff ff       	jmp    800bac <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c35:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c3c:	e9 6b ff ff ff       	jmp    800bac <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c41:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c42:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c46:	0f 89 60 ff ff ff    	jns    800bac <vprintfmt+0x54>
				width = precision, precision = -1;
  800c4c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c4f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c52:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c59:	e9 4e ff ff ff       	jmp    800bac <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c5e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c61:	e9 46 ff ff ff       	jmp    800bac <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c66:	8b 45 14             	mov    0x14(%ebp),%eax
  800c69:	83 c0 04             	add    $0x4,%eax
  800c6c:	89 45 14             	mov    %eax,0x14(%ebp)
  800c6f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c72:	83 e8 04             	sub    $0x4,%eax
  800c75:	8b 00                	mov    (%eax),%eax
  800c77:	83 ec 08             	sub    $0x8,%esp
  800c7a:	ff 75 0c             	pushl  0xc(%ebp)
  800c7d:	50                   	push   %eax
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	ff d0                	call   *%eax
  800c83:	83 c4 10             	add    $0x10,%esp
			break;
  800c86:	e9 89 02 00 00       	jmp    800f14 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c8b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8e:	83 c0 04             	add    $0x4,%eax
  800c91:	89 45 14             	mov    %eax,0x14(%ebp)
  800c94:	8b 45 14             	mov    0x14(%ebp),%eax
  800c97:	83 e8 04             	sub    $0x4,%eax
  800c9a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c9c:	85 db                	test   %ebx,%ebx
  800c9e:	79 02                	jns    800ca2 <vprintfmt+0x14a>
				err = -err;
  800ca0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ca2:	83 fb 64             	cmp    $0x64,%ebx
  800ca5:	7f 0b                	jg     800cb2 <vprintfmt+0x15a>
  800ca7:	8b 34 9d e0 27 80 00 	mov    0x8027e0(,%ebx,4),%esi
  800cae:	85 f6                	test   %esi,%esi
  800cb0:	75 19                	jne    800ccb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cb2:	53                   	push   %ebx
  800cb3:	68 85 29 80 00       	push   $0x802985
  800cb8:	ff 75 0c             	pushl  0xc(%ebp)
  800cbb:	ff 75 08             	pushl  0x8(%ebp)
  800cbe:	e8 5e 02 00 00       	call   800f21 <printfmt>
  800cc3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cc6:	e9 49 02 00 00       	jmp    800f14 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ccb:	56                   	push   %esi
  800ccc:	68 8e 29 80 00       	push   $0x80298e
  800cd1:	ff 75 0c             	pushl  0xc(%ebp)
  800cd4:	ff 75 08             	pushl  0x8(%ebp)
  800cd7:	e8 45 02 00 00       	call   800f21 <printfmt>
  800cdc:	83 c4 10             	add    $0x10,%esp
			break;
  800cdf:	e9 30 02 00 00       	jmp    800f14 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ce4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce7:	83 c0 04             	add    $0x4,%eax
  800cea:	89 45 14             	mov    %eax,0x14(%ebp)
  800ced:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf0:	83 e8 04             	sub    $0x4,%eax
  800cf3:	8b 30                	mov    (%eax),%esi
  800cf5:	85 f6                	test   %esi,%esi
  800cf7:	75 05                	jne    800cfe <vprintfmt+0x1a6>
				p = "(null)";
  800cf9:	be 91 29 80 00       	mov    $0x802991,%esi
			if (width > 0 && padc != '-')
  800cfe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d02:	7e 6d                	jle    800d71 <vprintfmt+0x219>
  800d04:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d08:	74 67                	je     800d71 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d0d:	83 ec 08             	sub    $0x8,%esp
  800d10:	50                   	push   %eax
  800d11:	56                   	push   %esi
  800d12:	e8 12 05 00 00       	call   801229 <strnlen>
  800d17:	83 c4 10             	add    $0x10,%esp
  800d1a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d1d:	eb 16                	jmp    800d35 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d1f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d23:	83 ec 08             	sub    $0x8,%esp
  800d26:	ff 75 0c             	pushl  0xc(%ebp)
  800d29:	50                   	push   %eax
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	ff d0                	call   *%eax
  800d2f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d32:	ff 4d e4             	decl   -0x1c(%ebp)
  800d35:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d39:	7f e4                	jg     800d1f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d3b:	eb 34                	jmp    800d71 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d3d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d41:	74 1c                	je     800d5f <vprintfmt+0x207>
  800d43:	83 fb 1f             	cmp    $0x1f,%ebx
  800d46:	7e 05                	jle    800d4d <vprintfmt+0x1f5>
  800d48:	83 fb 7e             	cmp    $0x7e,%ebx
  800d4b:	7e 12                	jle    800d5f <vprintfmt+0x207>
					putch('?', putdat);
  800d4d:	83 ec 08             	sub    $0x8,%esp
  800d50:	ff 75 0c             	pushl  0xc(%ebp)
  800d53:	6a 3f                	push   $0x3f
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	ff d0                	call   *%eax
  800d5a:	83 c4 10             	add    $0x10,%esp
  800d5d:	eb 0f                	jmp    800d6e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d5f:	83 ec 08             	sub    $0x8,%esp
  800d62:	ff 75 0c             	pushl  0xc(%ebp)
  800d65:	53                   	push   %ebx
  800d66:	8b 45 08             	mov    0x8(%ebp),%eax
  800d69:	ff d0                	call   *%eax
  800d6b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d6e:	ff 4d e4             	decl   -0x1c(%ebp)
  800d71:	89 f0                	mov    %esi,%eax
  800d73:	8d 70 01             	lea    0x1(%eax),%esi
  800d76:	8a 00                	mov    (%eax),%al
  800d78:	0f be d8             	movsbl %al,%ebx
  800d7b:	85 db                	test   %ebx,%ebx
  800d7d:	74 24                	je     800da3 <vprintfmt+0x24b>
  800d7f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d83:	78 b8                	js     800d3d <vprintfmt+0x1e5>
  800d85:	ff 4d e0             	decl   -0x20(%ebp)
  800d88:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d8c:	79 af                	jns    800d3d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d8e:	eb 13                	jmp    800da3 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d90:	83 ec 08             	sub    $0x8,%esp
  800d93:	ff 75 0c             	pushl  0xc(%ebp)
  800d96:	6a 20                	push   $0x20
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	ff d0                	call   *%eax
  800d9d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800da0:	ff 4d e4             	decl   -0x1c(%ebp)
  800da3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da7:	7f e7                	jg     800d90 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800da9:	e9 66 01 00 00       	jmp    800f14 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dae:	83 ec 08             	sub    $0x8,%esp
  800db1:	ff 75 e8             	pushl  -0x18(%ebp)
  800db4:	8d 45 14             	lea    0x14(%ebp),%eax
  800db7:	50                   	push   %eax
  800db8:	e8 3c fd ff ff       	call   800af9 <getint>
  800dbd:	83 c4 10             	add    $0x10,%esp
  800dc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dc3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dcc:	85 d2                	test   %edx,%edx
  800dce:	79 23                	jns    800df3 <vprintfmt+0x29b>
				putch('-', putdat);
  800dd0:	83 ec 08             	sub    $0x8,%esp
  800dd3:	ff 75 0c             	pushl  0xc(%ebp)
  800dd6:	6a 2d                	push   $0x2d
  800dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddb:	ff d0                	call   *%eax
  800ddd:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800de0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800de3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800de6:	f7 d8                	neg    %eax
  800de8:	83 d2 00             	adc    $0x0,%edx
  800deb:	f7 da                	neg    %edx
  800ded:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800df0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800df3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800dfa:	e9 bc 00 00 00       	jmp    800ebb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800dff:	83 ec 08             	sub    $0x8,%esp
  800e02:	ff 75 e8             	pushl  -0x18(%ebp)
  800e05:	8d 45 14             	lea    0x14(%ebp),%eax
  800e08:	50                   	push   %eax
  800e09:	e8 84 fc ff ff       	call   800a92 <getuint>
  800e0e:	83 c4 10             	add    $0x10,%esp
  800e11:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e14:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e17:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e1e:	e9 98 00 00 00       	jmp    800ebb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e23:	83 ec 08             	sub    $0x8,%esp
  800e26:	ff 75 0c             	pushl  0xc(%ebp)
  800e29:	6a 58                	push   $0x58
  800e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2e:	ff d0                	call   *%eax
  800e30:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e33:	83 ec 08             	sub    $0x8,%esp
  800e36:	ff 75 0c             	pushl  0xc(%ebp)
  800e39:	6a 58                	push   $0x58
  800e3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3e:	ff d0                	call   *%eax
  800e40:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e43:	83 ec 08             	sub    $0x8,%esp
  800e46:	ff 75 0c             	pushl  0xc(%ebp)
  800e49:	6a 58                	push   $0x58
  800e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4e:	ff d0                	call   *%eax
  800e50:	83 c4 10             	add    $0x10,%esp
			break;
  800e53:	e9 bc 00 00 00       	jmp    800f14 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e58:	83 ec 08             	sub    $0x8,%esp
  800e5b:	ff 75 0c             	pushl  0xc(%ebp)
  800e5e:	6a 30                	push   $0x30
  800e60:	8b 45 08             	mov    0x8(%ebp),%eax
  800e63:	ff d0                	call   *%eax
  800e65:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e68:	83 ec 08             	sub    $0x8,%esp
  800e6b:	ff 75 0c             	pushl  0xc(%ebp)
  800e6e:	6a 78                	push   $0x78
  800e70:	8b 45 08             	mov    0x8(%ebp),%eax
  800e73:	ff d0                	call   *%eax
  800e75:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e78:	8b 45 14             	mov    0x14(%ebp),%eax
  800e7b:	83 c0 04             	add    $0x4,%eax
  800e7e:	89 45 14             	mov    %eax,0x14(%ebp)
  800e81:	8b 45 14             	mov    0x14(%ebp),%eax
  800e84:	83 e8 04             	sub    $0x4,%eax
  800e87:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e93:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e9a:	eb 1f                	jmp    800ebb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e9c:	83 ec 08             	sub    $0x8,%esp
  800e9f:	ff 75 e8             	pushl  -0x18(%ebp)
  800ea2:	8d 45 14             	lea    0x14(%ebp),%eax
  800ea5:	50                   	push   %eax
  800ea6:	e8 e7 fb ff ff       	call   800a92 <getuint>
  800eab:	83 c4 10             	add    $0x10,%esp
  800eae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eb1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800eb4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ebb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ebf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ec2:	83 ec 04             	sub    $0x4,%esp
  800ec5:	52                   	push   %edx
  800ec6:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ec9:	50                   	push   %eax
  800eca:	ff 75 f4             	pushl  -0xc(%ebp)
  800ecd:	ff 75 f0             	pushl  -0x10(%ebp)
  800ed0:	ff 75 0c             	pushl  0xc(%ebp)
  800ed3:	ff 75 08             	pushl  0x8(%ebp)
  800ed6:	e8 00 fb ff ff       	call   8009db <printnum>
  800edb:	83 c4 20             	add    $0x20,%esp
			break;
  800ede:	eb 34                	jmp    800f14 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ee0:	83 ec 08             	sub    $0x8,%esp
  800ee3:	ff 75 0c             	pushl  0xc(%ebp)
  800ee6:	53                   	push   %ebx
  800ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eea:	ff d0                	call   *%eax
  800eec:	83 c4 10             	add    $0x10,%esp
			break;
  800eef:	eb 23                	jmp    800f14 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ef1:	83 ec 08             	sub    $0x8,%esp
  800ef4:	ff 75 0c             	pushl  0xc(%ebp)
  800ef7:	6a 25                	push   $0x25
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	ff d0                	call   *%eax
  800efe:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f01:	ff 4d 10             	decl   0x10(%ebp)
  800f04:	eb 03                	jmp    800f09 <vprintfmt+0x3b1>
  800f06:	ff 4d 10             	decl   0x10(%ebp)
  800f09:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0c:	48                   	dec    %eax
  800f0d:	8a 00                	mov    (%eax),%al
  800f0f:	3c 25                	cmp    $0x25,%al
  800f11:	75 f3                	jne    800f06 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f13:	90                   	nop
		}
	}
  800f14:	e9 47 fc ff ff       	jmp    800b60 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f19:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f1a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f1d:	5b                   	pop    %ebx
  800f1e:	5e                   	pop    %esi
  800f1f:	5d                   	pop    %ebp
  800f20:	c3                   	ret    

00800f21 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f21:	55                   	push   %ebp
  800f22:	89 e5                	mov    %esp,%ebp
  800f24:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f27:	8d 45 10             	lea    0x10(%ebp),%eax
  800f2a:	83 c0 04             	add    $0x4,%eax
  800f2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f30:	8b 45 10             	mov    0x10(%ebp),%eax
  800f33:	ff 75 f4             	pushl  -0xc(%ebp)
  800f36:	50                   	push   %eax
  800f37:	ff 75 0c             	pushl  0xc(%ebp)
  800f3a:	ff 75 08             	pushl  0x8(%ebp)
  800f3d:	e8 16 fc ff ff       	call   800b58 <vprintfmt>
  800f42:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f45:	90                   	nop
  800f46:	c9                   	leave  
  800f47:	c3                   	ret    

00800f48 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f48:	55                   	push   %ebp
  800f49:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4e:	8b 40 08             	mov    0x8(%eax),%eax
  800f51:	8d 50 01             	lea    0x1(%eax),%edx
  800f54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f57:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5d:	8b 10                	mov    (%eax),%edx
  800f5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f62:	8b 40 04             	mov    0x4(%eax),%eax
  800f65:	39 c2                	cmp    %eax,%edx
  800f67:	73 12                	jae    800f7b <sprintputch+0x33>
		*b->buf++ = ch;
  800f69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6c:	8b 00                	mov    (%eax),%eax
  800f6e:	8d 48 01             	lea    0x1(%eax),%ecx
  800f71:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f74:	89 0a                	mov    %ecx,(%edx)
  800f76:	8b 55 08             	mov    0x8(%ebp),%edx
  800f79:	88 10                	mov    %dl,(%eax)
}
  800f7b:	90                   	nop
  800f7c:	5d                   	pop    %ebp
  800f7d:	c3                   	ret    

00800f7e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f7e:	55                   	push   %ebp
  800f7f:	89 e5                	mov    %esp,%ebp
  800f81:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
  800f93:	01 d0                	add    %edx,%eax
  800f95:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f9f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fa3:	74 06                	je     800fab <vsnprintf+0x2d>
  800fa5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fa9:	7f 07                	jg     800fb2 <vsnprintf+0x34>
		return -E_INVAL;
  800fab:	b8 03 00 00 00       	mov    $0x3,%eax
  800fb0:	eb 20                	jmp    800fd2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fb2:	ff 75 14             	pushl  0x14(%ebp)
  800fb5:	ff 75 10             	pushl  0x10(%ebp)
  800fb8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fbb:	50                   	push   %eax
  800fbc:	68 48 0f 80 00       	push   $0x800f48
  800fc1:	e8 92 fb ff ff       	call   800b58 <vprintfmt>
  800fc6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fc9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fcc:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fd2:	c9                   	leave  
  800fd3:	c3                   	ret    

00800fd4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fd4:	55                   	push   %ebp
  800fd5:	89 e5                	mov    %esp,%ebp
  800fd7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fda:	8d 45 10             	lea    0x10(%ebp),%eax
  800fdd:	83 c0 04             	add    $0x4,%eax
  800fe0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fe3:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe6:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe9:	50                   	push   %eax
  800fea:	ff 75 0c             	pushl  0xc(%ebp)
  800fed:	ff 75 08             	pushl  0x8(%ebp)
  800ff0:	e8 89 ff ff ff       	call   800f7e <vsnprintf>
  800ff5:	83 c4 10             	add    $0x10,%esp
  800ff8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ffb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ffe:	c9                   	leave  
  800fff:	c3                   	ret    

00801000 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801000:	55                   	push   %ebp
  801001:	89 e5                	mov    %esp,%ebp
  801003:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801006:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80100a:	74 13                	je     80101f <readline+0x1f>
		cprintf("%s", prompt);
  80100c:	83 ec 08             	sub    $0x8,%esp
  80100f:	ff 75 08             	pushl  0x8(%ebp)
  801012:	68 f0 2a 80 00       	push   $0x802af0
  801017:	e8 62 f9 ff ff       	call   80097e <cprintf>
  80101c:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80101f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801026:	83 ec 0c             	sub    $0xc,%esp
  801029:	6a 00                	push   $0x0
  80102b:	e8 8e f5 ff ff       	call   8005be <iscons>
  801030:	83 c4 10             	add    $0x10,%esp
  801033:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801036:	e8 35 f5 ff ff       	call   800570 <getchar>
  80103b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80103e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801042:	79 22                	jns    801066 <readline+0x66>
			if (c != -E_EOF)
  801044:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801048:	0f 84 ad 00 00 00    	je     8010fb <readline+0xfb>
				cprintf("read error: %e\n", c);
  80104e:	83 ec 08             	sub    $0x8,%esp
  801051:	ff 75 ec             	pushl  -0x14(%ebp)
  801054:	68 f3 2a 80 00       	push   $0x802af3
  801059:	e8 20 f9 ff ff       	call   80097e <cprintf>
  80105e:	83 c4 10             	add    $0x10,%esp
			return;
  801061:	e9 95 00 00 00       	jmp    8010fb <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801066:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80106a:	7e 34                	jle    8010a0 <readline+0xa0>
  80106c:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801073:	7f 2b                	jg     8010a0 <readline+0xa0>
			if (echoing)
  801075:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801079:	74 0e                	je     801089 <readline+0x89>
				cputchar(c);
  80107b:	83 ec 0c             	sub    $0xc,%esp
  80107e:	ff 75 ec             	pushl  -0x14(%ebp)
  801081:	e8 a2 f4 ff ff       	call   800528 <cputchar>
  801086:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801089:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80108c:	8d 50 01             	lea    0x1(%eax),%edx
  80108f:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801092:	89 c2                	mov    %eax,%edx
  801094:	8b 45 0c             	mov    0xc(%ebp),%eax
  801097:	01 d0                	add    %edx,%eax
  801099:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80109c:	88 10                	mov    %dl,(%eax)
  80109e:	eb 56                	jmp    8010f6 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010a0:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010a4:	75 1f                	jne    8010c5 <readline+0xc5>
  8010a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010aa:	7e 19                	jle    8010c5 <readline+0xc5>
			if (echoing)
  8010ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010b0:	74 0e                	je     8010c0 <readline+0xc0>
				cputchar(c);
  8010b2:	83 ec 0c             	sub    $0xc,%esp
  8010b5:	ff 75 ec             	pushl  -0x14(%ebp)
  8010b8:	e8 6b f4 ff ff       	call   800528 <cputchar>
  8010bd:	83 c4 10             	add    $0x10,%esp

			i--;
  8010c0:	ff 4d f4             	decl   -0xc(%ebp)
  8010c3:	eb 31                	jmp    8010f6 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8010c5:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8010c9:	74 0a                	je     8010d5 <readline+0xd5>
  8010cb:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8010cf:	0f 85 61 ff ff ff    	jne    801036 <readline+0x36>
			if (echoing)
  8010d5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010d9:	74 0e                	je     8010e9 <readline+0xe9>
				cputchar(c);
  8010db:	83 ec 0c             	sub    $0xc,%esp
  8010de:	ff 75 ec             	pushl  -0x14(%ebp)
  8010e1:	e8 42 f4 ff ff       	call   800528 <cputchar>
  8010e6:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8010e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ef:	01 d0                	add    %edx,%eax
  8010f1:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8010f4:	eb 06                	jmp    8010fc <readline+0xfc>
		}
	}
  8010f6:	e9 3b ff ff ff       	jmp    801036 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8010fb:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8010fc:	c9                   	leave  
  8010fd:	c3                   	ret    

008010fe <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8010fe:	55                   	push   %ebp
  8010ff:	89 e5                	mov    %esp,%ebp
  801101:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801104:	e8 d1 0c 00 00       	call   801dda <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801109:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80110d:	74 13                	je     801122 <atomic_readline+0x24>
		cprintf("%s", prompt);
  80110f:	83 ec 08             	sub    $0x8,%esp
  801112:	ff 75 08             	pushl  0x8(%ebp)
  801115:	68 f0 2a 80 00       	push   $0x802af0
  80111a:	e8 5f f8 ff ff       	call   80097e <cprintf>
  80111f:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801122:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801129:	83 ec 0c             	sub    $0xc,%esp
  80112c:	6a 00                	push   $0x0
  80112e:	e8 8b f4 ff ff       	call   8005be <iscons>
  801133:	83 c4 10             	add    $0x10,%esp
  801136:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801139:	e8 32 f4 ff ff       	call   800570 <getchar>
  80113e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801141:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801145:	79 23                	jns    80116a <atomic_readline+0x6c>
			if (c != -E_EOF)
  801147:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80114b:	74 13                	je     801160 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80114d:	83 ec 08             	sub    $0x8,%esp
  801150:	ff 75 ec             	pushl  -0x14(%ebp)
  801153:	68 f3 2a 80 00       	push   $0x802af3
  801158:	e8 21 f8 ff ff       	call   80097e <cprintf>
  80115d:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801160:	e8 8f 0c 00 00       	call   801df4 <sys_enable_interrupt>
			return;
  801165:	e9 9a 00 00 00       	jmp    801204 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80116a:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80116e:	7e 34                	jle    8011a4 <atomic_readline+0xa6>
  801170:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801177:	7f 2b                	jg     8011a4 <atomic_readline+0xa6>
			if (echoing)
  801179:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80117d:	74 0e                	je     80118d <atomic_readline+0x8f>
				cputchar(c);
  80117f:	83 ec 0c             	sub    $0xc,%esp
  801182:	ff 75 ec             	pushl  -0x14(%ebp)
  801185:	e8 9e f3 ff ff       	call   800528 <cputchar>
  80118a:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80118d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801190:	8d 50 01             	lea    0x1(%eax),%edx
  801193:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801196:	89 c2                	mov    %eax,%edx
  801198:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119b:	01 d0                	add    %edx,%eax
  80119d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011a0:	88 10                	mov    %dl,(%eax)
  8011a2:	eb 5b                	jmp    8011ff <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011a4:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011a8:	75 1f                	jne    8011c9 <atomic_readline+0xcb>
  8011aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011ae:	7e 19                	jle    8011c9 <atomic_readline+0xcb>
			if (echoing)
  8011b0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011b4:	74 0e                	je     8011c4 <atomic_readline+0xc6>
				cputchar(c);
  8011b6:	83 ec 0c             	sub    $0xc,%esp
  8011b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8011bc:	e8 67 f3 ff ff       	call   800528 <cputchar>
  8011c1:	83 c4 10             	add    $0x10,%esp
			i--;
  8011c4:	ff 4d f4             	decl   -0xc(%ebp)
  8011c7:	eb 36                	jmp    8011ff <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8011c9:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011cd:	74 0a                	je     8011d9 <atomic_readline+0xdb>
  8011cf:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011d3:	0f 85 60 ff ff ff    	jne    801139 <atomic_readline+0x3b>
			if (echoing)
  8011d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011dd:	74 0e                	je     8011ed <atomic_readline+0xef>
				cputchar(c);
  8011df:	83 ec 0c             	sub    $0xc,%esp
  8011e2:	ff 75 ec             	pushl  -0x14(%ebp)
  8011e5:	e8 3e f3 ff ff       	call   800528 <cputchar>
  8011ea:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8011ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f3:	01 d0                	add    %edx,%eax
  8011f5:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8011f8:	e8 f7 0b 00 00       	call   801df4 <sys_enable_interrupt>
			return;
  8011fd:	eb 05                	jmp    801204 <atomic_readline+0x106>
		}
	}
  8011ff:	e9 35 ff ff ff       	jmp    801139 <atomic_readline+0x3b>
}
  801204:	c9                   	leave  
  801205:	c3                   	ret    

00801206 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801206:	55                   	push   %ebp
  801207:	89 e5                	mov    %esp,%ebp
  801209:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80120c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801213:	eb 06                	jmp    80121b <strlen+0x15>
		n++;
  801215:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801218:	ff 45 08             	incl   0x8(%ebp)
  80121b:	8b 45 08             	mov    0x8(%ebp),%eax
  80121e:	8a 00                	mov    (%eax),%al
  801220:	84 c0                	test   %al,%al
  801222:	75 f1                	jne    801215 <strlen+0xf>
		n++;
	return n;
  801224:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801227:	c9                   	leave  
  801228:	c3                   	ret    

00801229 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801229:	55                   	push   %ebp
  80122a:	89 e5                	mov    %esp,%ebp
  80122c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80122f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801236:	eb 09                	jmp    801241 <strnlen+0x18>
		n++;
  801238:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80123b:	ff 45 08             	incl   0x8(%ebp)
  80123e:	ff 4d 0c             	decl   0xc(%ebp)
  801241:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801245:	74 09                	je     801250 <strnlen+0x27>
  801247:	8b 45 08             	mov    0x8(%ebp),%eax
  80124a:	8a 00                	mov    (%eax),%al
  80124c:	84 c0                	test   %al,%al
  80124e:	75 e8                	jne    801238 <strnlen+0xf>
		n++;
	return n;
  801250:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801253:	c9                   	leave  
  801254:	c3                   	ret    

00801255 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801255:	55                   	push   %ebp
  801256:	89 e5                	mov    %esp,%ebp
  801258:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80125b:	8b 45 08             	mov    0x8(%ebp),%eax
  80125e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801261:	90                   	nop
  801262:	8b 45 08             	mov    0x8(%ebp),%eax
  801265:	8d 50 01             	lea    0x1(%eax),%edx
  801268:	89 55 08             	mov    %edx,0x8(%ebp)
  80126b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80126e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801271:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801274:	8a 12                	mov    (%edx),%dl
  801276:	88 10                	mov    %dl,(%eax)
  801278:	8a 00                	mov    (%eax),%al
  80127a:	84 c0                	test   %al,%al
  80127c:	75 e4                	jne    801262 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80127e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801281:	c9                   	leave  
  801282:	c3                   	ret    

00801283 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801283:	55                   	push   %ebp
  801284:	89 e5                	mov    %esp,%ebp
  801286:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801289:	8b 45 08             	mov    0x8(%ebp),%eax
  80128c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80128f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801296:	eb 1f                	jmp    8012b7 <strncpy+0x34>
		*dst++ = *src;
  801298:	8b 45 08             	mov    0x8(%ebp),%eax
  80129b:	8d 50 01             	lea    0x1(%eax),%edx
  80129e:	89 55 08             	mov    %edx,0x8(%ebp)
  8012a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a4:	8a 12                	mov    (%edx),%dl
  8012a6:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ab:	8a 00                	mov    (%eax),%al
  8012ad:	84 c0                	test   %al,%al
  8012af:	74 03                	je     8012b4 <strncpy+0x31>
			src++;
  8012b1:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012b4:	ff 45 fc             	incl   -0x4(%ebp)
  8012b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ba:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012bd:	72 d9                	jb     801298 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012c2:	c9                   	leave  
  8012c3:	c3                   	ret    

008012c4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012c4:	55                   	push   %ebp
  8012c5:	89 e5                	mov    %esp,%ebp
  8012c7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012d0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012d4:	74 30                	je     801306 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012d6:	eb 16                	jmp    8012ee <strlcpy+0x2a>
			*dst++ = *src++;
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012db:	8d 50 01             	lea    0x1(%eax),%edx
  8012de:	89 55 08             	mov    %edx,0x8(%ebp)
  8012e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012e7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012ea:	8a 12                	mov    (%edx),%dl
  8012ec:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8012ee:	ff 4d 10             	decl   0x10(%ebp)
  8012f1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012f5:	74 09                	je     801300 <strlcpy+0x3c>
  8012f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fa:	8a 00                	mov    (%eax),%al
  8012fc:	84 c0                	test   %al,%al
  8012fe:	75 d8                	jne    8012d8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801300:	8b 45 08             	mov    0x8(%ebp),%eax
  801303:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801306:	8b 55 08             	mov    0x8(%ebp),%edx
  801309:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80130c:	29 c2                	sub    %eax,%edx
  80130e:	89 d0                	mov    %edx,%eax
}
  801310:	c9                   	leave  
  801311:	c3                   	ret    

00801312 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801312:	55                   	push   %ebp
  801313:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801315:	eb 06                	jmp    80131d <strcmp+0xb>
		p++, q++;
  801317:	ff 45 08             	incl   0x8(%ebp)
  80131a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	8a 00                	mov    (%eax),%al
  801322:	84 c0                	test   %al,%al
  801324:	74 0e                	je     801334 <strcmp+0x22>
  801326:	8b 45 08             	mov    0x8(%ebp),%eax
  801329:	8a 10                	mov    (%eax),%dl
  80132b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132e:	8a 00                	mov    (%eax),%al
  801330:	38 c2                	cmp    %al,%dl
  801332:	74 e3                	je     801317 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	8a 00                	mov    (%eax),%al
  801339:	0f b6 d0             	movzbl %al,%edx
  80133c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133f:	8a 00                	mov    (%eax),%al
  801341:	0f b6 c0             	movzbl %al,%eax
  801344:	29 c2                	sub    %eax,%edx
  801346:	89 d0                	mov    %edx,%eax
}
  801348:	5d                   	pop    %ebp
  801349:	c3                   	ret    

0080134a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80134a:	55                   	push   %ebp
  80134b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80134d:	eb 09                	jmp    801358 <strncmp+0xe>
		n--, p++, q++;
  80134f:	ff 4d 10             	decl   0x10(%ebp)
  801352:	ff 45 08             	incl   0x8(%ebp)
  801355:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801358:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80135c:	74 17                	je     801375 <strncmp+0x2b>
  80135e:	8b 45 08             	mov    0x8(%ebp),%eax
  801361:	8a 00                	mov    (%eax),%al
  801363:	84 c0                	test   %al,%al
  801365:	74 0e                	je     801375 <strncmp+0x2b>
  801367:	8b 45 08             	mov    0x8(%ebp),%eax
  80136a:	8a 10                	mov    (%eax),%dl
  80136c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136f:	8a 00                	mov    (%eax),%al
  801371:	38 c2                	cmp    %al,%dl
  801373:	74 da                	je     80134f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801375:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801379:	75 07                	jne    801382 <strncmp+0x38>
		return 0;
  80137b:	b8 00 00 00 00       	mov    $0x0,%eax
  801380:	eb 14                	jmp    801396 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801382:	8b 45 08             	mov    0x8(%ebp),%eax
  801385:	8a 00                	mov    (%eax),%al
  801387:	0f b6 d0             	movzbl %al,%edx
  80138a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138d:	8a 00                	mov    (%eax),%al
  80138f:	0f b6 c0             	movzbl %al,%eax
  801392:	29 c2                	sub    %eax,%edx
  801394:	89 d0                	mov    %edx,%eax
}
  801396:	5d                   	pop    %ebp
  801397:	c3                   	ret    

00801398 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801398:	55                   	push   %ebp
  801399:	89 e5                	mov    %esp,%ebp
  80139b:	83 ec 04             	sub    $0x4,%esp
  80139e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013a4:	eb 12                	jmp    8013b8 <strchr+0x20>
		if (*s == c)
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a9:	8a 00                	mov    (%eax),%al
  8013ab:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013ae:	75 05                	jne    8013b5 <strchr+0x1d>
			return (char *) s;
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	eb 11                	jmp    8013c6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013b5:	ff 45 08             	incl   0x8(%ebp)
  8013b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bb:	8a 00                	mov    (%eax),%al
  8013bd:	84 c0                	test   %al,%al
  8013bf:	75 e5                	jne    8013a6 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013c6:	c9                   	leave  
  8013c7:	c3                   	ret    

008013c8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013c8:	55                   	push   %ebp
  8013c9:	89 e5                	mov    %esp,%ebp
  8013cb:	83 ec 04             	sub    $0x4,%esp
  8013ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013d4:	eb 0d                	jmp    8013e3 <strfind+0x1b>
		if (*s == c)
  8013d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d9:	8a 00                	mov    (%eax),%al
  8013db:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013de:	74 0e                	je     8013ee <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013e0:	ff 45 08             	incl   0x8(%ebp)
  8013e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e6:	8a 00                	mov    (%eax),%al
  8013e8:	84 c0                	test   %al,%al
  8013ea:	75 ea                	jne    8013d6 <strfind+0xe>
  8013ec:	eb 01                	jmp    8013ef <strfind+0x27>
		if (*s == c)
			break;
  8013ee:	90                   	nop
	return (char *) s;
  8013ef:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013f2:	c9                   	leave  
  8013f3:	c3                   	ret    

008013f4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8013f4:	55                   	push   %ebp
  8013f5:	89 e5                	mov    %esp,%ebp
  8013f7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8013fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801400:	8b 45 10             	mov    0x10(%ebp),%eax
  801403:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801406:	eb 0e                	jmp    801416 <memset+0x22>
		*p++ = c;
  801408:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80140b:	8d 50 01             	lea    0x1(%eax),%edx
  80140e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801411:	8b 55 0c             	mov    0xc(%ebp),%edx
  801414:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801416:	ff 4d f8             	decl   -0x8(%ebp)
  801419:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80141d:	79 e9                	jns    801408 <memset+0x14>
		*p++ = c;

	return v;
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801422:	c9                   	leave  
  801423:	c3                   	ret    

00801424 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801424:	55                   	push   %ebp
  801425:	89 e5                	mov    %esp,%ebp
  801427:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80142a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801430:	8b 45 08             	mov    0x8(%ebp),%eax
  801433:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801436:	eb 16                	jmp    80144e <memcpy+0x2a>
		*d++ = *s++;
  801438:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80143b:	8d 50 01             	lea    0x1(%eax),%edx
  80143e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801441:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801444:	8d 4a 01             	lea    0x1(%edx),%ecx
  801447:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80144a:	8a 12                	mov    (%edx),%dl
  80144c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80144e:	8b 45 10             	mov    0x10(%ebp),%eax
  801451:	8d 50 ff             	lea    -0x1(%eax),%edx
  801454:	89 55 10             	mov    %edx,0x10(%ebp)
  801457:	85 c0                	test   %eax,%eax
  801459:	75 dd                	jne    801438 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80145b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80145e:	c9                   	leave  
  80145f:	c3                   	ret    

00801460 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801460:	55                   	push   %ebp
  801461:	89 e5                	mov    %esp,%ebp
  801463:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801466:	8b 45 0c             	mov    0xc(%ebp),%eax
  801469:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801472:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801475:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801478:	73 50                	jae    8014ca <memmove+0x6a>
  80147a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80147d:	8b 45 10             	mov    0x10(%ebp),%eax
  801480:	01 d0                	add    %edx,%eax
  801482:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801485:	76 43                	jbe    8014ca <memmove+0x6a>
		s += n;
  801487:	8b 45 10             	mov    0x10(%ebp),%eax
  80148a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80148d:	8b 45 10             	mov    0x10(%ebp),%eax
  801490:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801493:	eb 10                	jmp    8014a5 <memmove+0x45>
			*--d = *--s;
  801495:	ff 4d f8             	decl   -0x8(%ebp)
  801498:	ff 4d fc             	decl   -0x4(%ebp)
  80149b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80149e:	8a 10                	mov    (%eax),%dl
  8014a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a3:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014ab:	89 55 10             	mov    %edx,0x10(%ebp)
  8014ae:	85 c0                	test   %eax,%eax
  8014b0:	75 e3                	jne    801495 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014b2:	eb 23                	jmp    8014d7 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b7:	8d 50 01             	lea    0x1(%eax),%edx
  8014ba:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014c0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014c3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014c6:	8a 12                	mov    (%edx),%dl
  8014c8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8014ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8014cd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014d0:	89 55 10             	mov    %edx,0x10(%ebp)
  8014d3:	85 c0                	test   %eax,%eax
  8014d5:	75 dd                	jne    8014b4 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8014d7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014da:	c9                   	leave  
  8014db:	c3                   	ret    

008014dc <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8014dc:	55                   	push   %ebp
  8014dd:	89 e5                	mov    %esp,%ebp
  8014df:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8014e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8014e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014eb:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8014ee:	eb 2a                	jmp    80151a <memcmp+0x3e>
		if (*s1 != *s2)
  8014f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014f3:	8a 10                	mov    (%eax),%dl
  8014f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f8:	8a 00                	mov    (%eax),%al
  8014fa:	38 c2                	cmp    %al,%dl
  8014fc:	74 16                	je     801514 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8014fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801501:	8a 00                	mov    (%eax),%al
  801503:	0f b6 d0             	movzbl %al,%edx
  801506:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801509:	8a 00                	mov    (%eax),%al
  80150b:	0f b6 c0             	movzbl %al,%eax
  80150e:	29 c2                	sub    %eax,%edx
  801510:	89 d0                	mov    %edx,%eax
  801512:	eb 18                	jmp    80152c <memcmp+0x50>
		s1++, s2++;
  801514:	ff 45 fc             	incl   -0x4(%ebp)
  801517:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80151a:	8b 45 10             	mov    0x10(%ebp),%eax
  80151d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801520:	89 55 10             	mov    %edx,0x10(%ebp)
  801523:	85 c0                	test   %eax,%eax
  801525:	75 c9                	jne    8014f0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801527:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80152c:	c9                   	leave  
  80152d:	c3                   	ret    

0080152e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80152e:	55                   	push   %ebp
  80152f:	89 e5                	mov    %esp,%ebp
  801531:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801534:	8b 55 08             	mov    0x8(%ebp),%edx
  801537:	8b 45 10             	mov    0x10(%ebp),%eax
  80153a:	01 d0                	add    %edx,%eax
  80153c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80153f:	eb 15                	jmp    801556 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801541:	8b 45 08             	mov    0x8(%ebp),%eax
  801544:	8a 00                	mov    (%eax),%al
  801546:	0f b6 d0             	movzbl %al,%edx
  801549:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154c:	0f b6 c0             	movzbl %al,%eax
  80154f:	39 c2                	cmp    %eax,%edx
  801551:	74 0d                	je     801560 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801553:	ff 45 08             	incl   0x8(%ebp)
  801556:	8b 45 08             	mov    0x8(%ebp),%eax
  801559:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80155c:	72 e3                	jb     801541 <memfind+0x13>
  80155e:	eb 01                	jmp    801561 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801560:	90                   	nop
	return (void *) s;
  801561:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801564:	c9                   	leave  
  801565:	c3                   	ret    

00801566 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801566:	55                   	push   %ebp
  801567:	89 e5                	mov    %esp,%ebp
  801569:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80156c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801573:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80157a:	eb 03                	jmp    80157f <strtol+0x19>
		s++;
  80157c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80157f:	8b 45 08             	mov    0x8(%ebp),%eax
  801582:	8a 00                	mov    (%eax),%al
  801584:	3c 20                	cmp    $0x20,%al
  801586:	74 f4                	je     80157c <strtol+0x16>
  801588:	8b 45 08             	mov    0x8(%ebp),%eax
  80158b:	8a 00                	mov    (%eax),%al
  80158d:	3c 09                	cmp    $0x9,%al
  80158f:	74 eb                	je     80157c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801591:	8b 45 08             	mov    0x8(%ebp),%eax
  801594:	8a 00                	mov    (%eax),%al
  801596:	3c 2b                	cmp    $0x2b,%al
  801598:	75 05                	jne    80159f <strtol+0x39>
		s++;
  80159a:	ff 45 08             	incl   0x8(%ebp)
  80159d:	eb 13                	jmp    8015b2 <strtol+0x4c>
	else if (*s == '-')
  80159f:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a2:	8a 00                	mov    (%eax),%al
  8015a4:	3c 2d                	cmp    $0x2d,%al
  8015a6:	75 0a                	jne    8015b2 <strtol+0x4c>
		s++, neg = 1;
  8015a8:	ff 45 08             	incl   0x8(%ebp)
  8015ab:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015b6:	74 06                	je     8015be <strtol+0x58>
  8015b8:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015bc:	75 20                	jne    8015de <strtol+0x78>
  8015be:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c1:	8a 00                	mov    (%eax),%al
  8015c3:	3c 30                	cmp    $0x30,%al
  8015c5:	75 17                	jne    8015de <strtol+0x78>
  8015c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ca:	40                   	inc    %eax
  8015cb:	8a 00                	mov    (%eax),%al
  8015cd:	3c 78                	cmp    $0x78,%al
  8015cf:	75 0d                	jne    8015de <strtol+0x78>
		s += 2, base = 16;
  8015d1:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8015d5:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8015dc:	eb 28                	jmp    801606 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8015de:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015e2:	75 15                	jne    8015f9 <strtol+0x93>
  8015e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e7:	8a 00                	mov    (%eax),%al
  8015e9:	3c 30                	cmp    $0x30,%al
  8015eb:	75 0c                	jne    8015f9 <strtol+0x93>
		s++, base = 8;
  8015ed:	ff 45 08             	incl   0x8(%ebp)
  8015f0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8015f7:	eb 0d                	jmp    801606 <strtol+0xa0>
	else if (base == 0)
  8015f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015fd:	75 07                	jne    801606 <strtol+0xa0>
		base = 10;
  8015ff:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801606:	8b 45 08             	mov    0x8(%ebp),%eax
  801609:	8a 00                	mov    (%eax),%al
  80160b:	3c 2f                	cmp    $0x2f,%al
  80160d:	7e 19                	jle    801628 <strtol+0xc2>
  80160f:	8b 45 08             	mov    0x8(%ebp),%eax
  801612:	8a 00                	mov    (%eax),%al
  801614:	3c 39                	cmp    $0x39,%al
  801616:	7f 10                	jg     801628 <strtol+0xc2>
			dig = *s - '0';
  801618:	8b 45 08             	mov    0x8(%ebp),%eax
  80161b:	8a 00                	mov    (%eax),%al
  80161d:	0f be c0             	movsbl %al,%eax
  801620:	83 e8 30             	sub    $0x30,%eax
  801623:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801626:	eb 42                	jmp    80166a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	8a 00                	mov    (%eax),%al
  80162d:	3c 60                	cmp    $0x60,%al
  80162f:	7e 19                	jle    80164a <strtol+0xe4>
  801631:	8b 45 08             	mov    0x8(%ebp),%eax
  801634:	8a 00                	mov    (%eax),%al
  801636:	3c 7a                	cmp    $0x7a,%al
  801638:	7f 10                	jg     80164a <strtol+0xe4>
			dig = *s - 'a' + 10;
  80163a:	8b 45 08             	mov    0x8(%ebp),%eax
  80163d:	8a 00                	mov    (%eax),%al
  80163f:	0f be c0             	movsbl %al,%eax
  801642:	83 e8 57             	sub    $0x57,%eax
  801645:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801648:	eb 20                	jmp    80166a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80164a:	8b 45 08             	mov    0x8(%ebp),%eax
  80164d:	8a 00                	mov    (%eax),%al
  80164f:	3c 40                	cmp    $0x40,%al
  801651:	7e 39                	jle    80168c <strtol+0x126>
  801653:	8b 45 08             	mov    0x8(%ebp),%eax
  801656:	8a 00                	mov    (%eax),%al
  801658:	3c 5a                	cmp    $0x5a,%al
  80165a:	7f 30                	jg     80168c <strtol+0x126>
			dig = *s - 'A' + 10;
  80165c:	8b 45 08             	mov    0x8(%ebp),%eax
  80165f:	8a 00                	mov    (%eax),%al
  801661:	0f be c0             	movsbl %al,%eax
  801664:	83 e8 37             	sub    $0x37,%eax
  801667:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80166a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80166d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801670:	7d 19                	jge    80168b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801672:	ff 45 08             	incl   0x8(%ebp)
  801675:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801678:	0f af 45 10          	imul   0x10(%ebp),%eax
  80167c:	89 c2                	mov    %eax,%edx
  80167e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801681:	01 d0                	add    %edx,%eax
  801683:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801686:	e9 7b ff ff ff       	jmp    801606 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80168b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80168c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801690:	74 08                	je     80169a <strtol+0x134>
		*endptr = (char *) s;
  801692:	8b 45 0c             	mov    0xc(%ebp),%eax
  801695:	8b 55 08             	mov    0x8(%ebp),%edx
  801698:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80169a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80169e:	74 07                	je     8016a7 <strtol+0x141>
  8016a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016a3:	f7 d8                	neg    %eax
  8016a5:	eb 03                	jmp    8016aa <strtol+0x144>
  8016a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016aa:	c9                   	leave  
  8016ab:	c3                   	ret    

008016ac <ltostr>:

void
ltostr(long value, char *str)
{
  8016ac:	55                   	push   %ebp
  8016ad:	89 e5                	mov    %esp,%ebp
  8016af:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016b9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016c0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016c4:	79 13                	jns    8016d9 <ltostr+0x2d>
	{
		neg = 1;
  8016c6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8016cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d0:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8016d3:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8016d6:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8016d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016dc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8016e1:	99                   	cltd   
  8016e2:	f7 f9                	idiv   %ecx
  8016e4:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8016e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ea:	8d 50 01             	lea    0x1(%eax),%edx
  8016ed:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016f0:	89 c2                	mov    %eax,%edx
  8016f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f5:	01 d0                	add    %edx,%eax
  8016f7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016fa:	83 c2 30             	add    $0x30,%edx
  8016fd:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8016ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801702:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801707:	f7 e9                	imul   %ecx
  801709:	c1 fa 02             	sar    $0x2,%edx
  80170c:	89 c8                	mov    %ecx,%eax
  80170e:	c1 f8 1f             	sar    $0x1f,%eax
  801711:	29 c2                	sub    %eax,%edx
  801713:	89 d0                	mov    %edx,%eax
  801715:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801718:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80171b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801720:	f7 e9                	imul   %ecx
  801722:	c1 fa 02             	sar    $0x2,%edx
  801725:	89 c8                	mov    %ecx,%eax
  801727:	c1 f8 1f             	sar    $0x1f,%eax
  80172a:	29 c2                	sub    %eax,%edx
  80172c:	89 d0                	mov    %edx,%eax
  80172e:	c1 e0 02             	shl    $0x2,%eax
  801731:	01 d0                	add    %edx,%eax
  801733:	01 c0                	add    %eax,%eax
  801735:	29 c1                	sub    %eax,%ecx
  801737:	89 ca                	mov    %ecx,%edx
  801739:	85 d2                	test   %edx,%edx
  80173b:	75 9c                	jne    8016d9 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80173d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801744:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801747:	48                   	dec    %eax
  801748:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80174b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80174f:	74 3d                	je     80178e <ltostr+0xe2>
		start = 1 ;
  801751:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801758:	eb 34                	jmp    80178e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80175a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80175d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801760:	01 d0                	add    %edx,%eax
  801762:	8a 00                	mov    (%eax),%al
  801764:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801767:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80176a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176d:	01 c2                	add    %eax,%edx
  80176f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801772:	8b 45 0c             	mov    0xc(%ebp),%eax
  801775:	01 c8                	add    %ecx,%eax
  801777:	8a 00                	mov    (%eax),%al
  801779:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80177b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80177e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801781:	01 c2                	add    %eax,%edx
  801783:	8a 45 eb             	mov    -0x15(%ebp),%al
  801786:	88 02                	mov    %al,(%edx)
		start++ ;
  801788:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80178b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80178e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801791:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801794:	7c c4                	jl     80175a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801796:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801799:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179c:	01 d0                	add    %edx,%eax
  80179e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017a1:	90                   	nop
  8017a2:	c9                   	leave  
  8017a3:	c3                   	ret    

008017a4 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017a4:	55                   	push   %ebp
  8017a5:	89 e5                	mov    %esp,%ebp
  8017a7:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017aa:	ff 75 08             	pushl  0x8(%ebp)
  8017ad:	e8 54 fa ff ff       	call   801206 <strlen>
  8017b2:	83 c4 04             	add    $0x4,%esp
  8017b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017b8:	ff 75 0c             	pushl  0xc(%ebp)
  8017bb:	e8 46 fa ff ff       	call   801206 <strlen>
  8017c0:	83 c4 04             	add    $0x4,%esp
  8017c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8017cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8017d4:	eb 17                	jmp    8017ed <strcconcat+0x49>
		final[s] = str1[s] ;
  8017d6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8017dc:	01 c2                	add    %eax,%edx
  8017de:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8017e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e4:	01 c8                	add    %ecx,%eax
  8017e6:	8a 00                	mov    (%eax),%al
  8017e8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8017ea:	ff 45 fc             	incl   -0x4(%ebp)
  8017ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017f0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8017f3:	7c e1                	jl     8017d6 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8017f5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8017fc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801803:	eb 1f                	jmp    801824 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801805:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801808:	8d 50 01             	lea    0x1(%eax),%edx
  80180b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80180e:	89 c2                	mov    %eax,%edx
  801810:	8b 45 10             	mov    0x10(%ebp),%eax
  801813:	01 c2                	add    %eax,%edx
  801815:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801818:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181b:	01 c8                	add    %ecx,%eax
  80181d:	8a 00                	mov    (%eax),%al
  80181f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801821:	ff 45 f8             	incl   -0x8(%ebp)
  801824:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801827:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80182a:	7c d9                	jl     801805 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80182c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80182f:	8b 45 10             	mov    0x10(%ebp),%eax
  801832:	01 d0                	add    %edx,%eax
  801834:	c6 00 00             	movb   $0x0,(%eax)
}
  801837:	90                   	nop
  801838:	c9                   	leave  
  801839:	c3                   	ret    

0080183a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80183a:	55                   	push   %ebp
  80183b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80183d:	8b 45 14             	mov    0x14(%ebp),%eax
  801840:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801846:	8b 45 14             	mov    0x14(%ebp),%eax
  801849:	8b 00                	mov    (%eax),%eax
  80184b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801852:	8b 45 10             	mov    0x10(%ebp),%eax
  801855:	01 d0                	add    %edx,%eax
  801857:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80185d:	eb 0c                	jmp    80186b <strsplit+0x31>
			*string++ = 0;
  80185f:	8b 45 08             	mov    0x8(%ebp),%eax
  801862:	8d 50 01             	lea    0x1(%eax),%edx
  801865:	89 55 08             	mov    %edx,0x8(%ebp)
  801868:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80186b:	8b 45 08             	mov    0x8(%ebp),%eax
  80186e:	8a 00                	mov    (%eax),%al
  801870:	84 c0                	test   %al,%al
  801872:	74 18                	je     80188c <strsplit+0x52>
  801874:	8b 45 08             	mov    0x8(%ebp),%eax
  801877:	8a 00                	mov    (%eax),%al
  801879:	0f be c0             	movsbl %al,%eax
  80187c:	50                   	push   %eax
  80187d:	ff 75 0c             	pushl  0xc(%ebp)
  801880:	e8 13 fb ff ff       	call   801398 <strchr>
  801885:	83 c4 08             	add    $0x8,%esp
  801888:	85 c0                	test   %eax,%eax
  80188a:	75 d3                	jne    80185f <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80188c:	8b 45 08             	mov    0x8(%ebp),%eax
  80188f:	8a 00                	mov    (%eax),%al
  801891:	84 c0                	test   %al,%al
  801893:	74 5a                	je     8018ef <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801895:	8b 45 14             	mov    0x14(%ebp),%eax
  801898:	8b 00                	mov    (%eax),%eax
  80189a:	83 f8 0f             	cmp    $0xf,%eax
  80189d:	75 07                	jne    8018a6 <strsplit+0x6c>
		{
			return 0;
  80189f:	b8 00 00 00 00       	mov    $0x0,%eax
  8018a4:	eb 66                	jmp    80190c <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8018a9:	8b 00                	mov    (%eax),%eax
  8018ab:	8d 48 01             	lea    0x1(%eax),%ecx
  8018ae:	8b 55 14             	mov    0x14(%ebp),%edx
  8018b1:	89 0a                	mov    %ecx,(%edx)
  8018b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8018bd:	01 c2                	add    %eax,%edx
  8018bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018c4:	eb 03                	jmp    8018c9 <strsplit+0x8f>
			string++;
  8018c6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cc:	8a 00                	mov    (%eax),%al
  8018ce:	84 c0                	test   %al,%al
  8018d0:	74 8b                	je     80185d <strsplit+0x23>
  8018d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d5:	8a 00                	mov    (%eax),%al
  8018d7:	0f be c0             	movsbl %al,%eax
  8018da:	50                   	push   %eax
  8018db:	ff 75 0c             	pushl  0xc(%ebp)
  8018de:	e8 b5 fa ff ff       	call   801398 <strchr>
  8018e3:	83 c4 08             	add    $0x8,%esp
  8018e6:	85 c0                	test   %eax,%eax
  8018e8:	74 dc                	je     8018c6 <strsplit+0x8c>
			string++;
	}
  8018ea:	e9 6e ff ff ff       	jmp    80185d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8018ef:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8018f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018f3:	8b 00                	mov    (%eax),%eax
  8018f5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ff:	01 d0                	add    %edx,%eax
  801901:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801907:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80190c:	c9                   	leave  
  80190d:	c3                   	ret    

0080190e <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80190e:	55                   	push   %ebp
  80190f:	89 e5                	mov    %esp,%ebp
  801911:	83 ec 18             	sub    $0x18,%esp
  801914:	8b 45 10             	mov    0x10(%ebp),%eax
  801917:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80191a:	83 ec 04             	sub    $0x4,%esp
  80191d:	68 04 2b 80 00       	push   $0x802b04
  801922:	6a 17                	push   $0x17
  801924:	68 23 2b 80 00       	push   $0x802b23
  801929:	e8 9c ed ff ff       	call   8006ca <_panic>

0080192e <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80192e:	55                   	push   %ebp
  80192f:	89 e5                	mov    %esp,%ebp
  801931:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801934:	83 ec 04             	sub    $0x4,%esp
  801937:	68 2f 2b 80 00       	push   $0x802b2f
  80193c:	6a 2f                	push   $0x2f
  80193e:	68 23 2b 80 00       	push   $0x802b23
  801943:	e8 82 ed ff ff       	call   8006ca <_panic>

00801948 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801948:	55                   	push   %ebp
  801949:	89 e5                	mov    %esp,%ebp
  80194b:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80194e:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801955:	8b 55 08             	mov    0x8(%ebp),%edx
  801958:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80195b:	01 d0                	add    %edx,%eax
  80195d:	48                   	dec    %eax
  80195e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801961:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801964:	ba 00 00 00 00       	mov    $0x0,%edx
  801969:	f7 75 ec             	divl   -0x14(%ebp)
  80196c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80196f:	29 d0                	sub    %edx,%eax
  801971:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801974:	8b 45 08             	mov    0x8(%ebp),%eax
  801977:	c1 e8 0c             	shr    $0xc,%eax
  80197a:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80197d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801984:	e9 c8 00 00 00       	jmp    801a51 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801989:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801990:	eb 27                	jmp    8019b9 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801992:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801995:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801998:	01 c2                	add    %eax,%edx
  80199a:	89 d0                	mov    %edx,%eax
  80199c:	01 c0                	add    %eax,%eax
  80199e:	01 d0                	add    %edx,%eax
  8019a0:	c1 e0 02             	shl    $0x2,%eax
  8019a3:	05 48 30 80 00       	add    $0x803048,%eax
  8019a8:	8b 00                	mov    (%eax),%eax
  8019aa:	85 c0                	test   %eax,%eax
  8019ac:	74 08                	je     8019b6 <malloc+0x6e>
            	i += j;
  8019ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019b1:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8019b4:	eb 0b                	jmp    8019c1 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8019b6:	ff 45 f0             	incl   -0x10(%ebp)
  8019b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019bc:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019bf:	72 d1                	jb     801992 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8019c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019c4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019c7:	0f 85 81 00 00 00    	jne    801a4e <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8019cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019d0:	05 00 00 08 00       	add    $0x80000,%eax
  8019d5:	c1 e0 0c             	shl    $0xc,%eax
  8019d8:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8019db:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019e2:	eb 1f                	jmp    801a03 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8019e4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019ea:	01 c2                	add    %eax,%edx
  8019ec:	89 d0                	mov    %edx,%eax
  8019ee:	01 c0                	add    %eax,%eax
  8019f0:	01 d0                	add    %edx,%eax
  8019f2:	c1 e0 02             	shl    $0x2,%eax
  8019f5:	05 48 30 80 00       	add    $0x803048,%eax
  8019fa:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801a00:	ff 45 f0             	incl   -0x10(%ebp)
  801a03:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a06:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a09:	72 d9                	jb     8019e4 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801a0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a0e:	89 d0                	mov    %edx,%eax
  801a10:	01 c0                	add    %eax,%eax
  801a12:	01 d0                	add    %edx,%eax
  801a14:	c1 e0 02             	shl    $0x2,%eax
  801a17:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801a1d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a20:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801a22:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a25:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801a28:	89 c8                	mov    %ecx,%eax
  801a2a:	01 c0                	add    %eax,%eax
  801a2c:	01 c8                	add    %ecx,%eax
  801a2e:	c1 e0 02             	shl    $0x2,%eax
  801a31:	05 44 30 80 00       	add    $0x803044,%eax
  801a36:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801a38:	83 ec 08             	sub    $0x8,%esp
  801a3b:	ff 75 08             	pushl  0x8(%ebp)
  801a3e:	ff 75 e0             	pushl  -0x20(%ebp)
  801a41:	e8 2b 03 00 00       	call   801d71 <sys_allocateMem>
  801a46:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801a49:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a4c:	eb 19                	jmp    801a67 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801a4e:	ff 45 f4             	incl   -0xc(%ebp)
  801a51:	a1 04 30 80 00       	mov    0x803004,%eax
  801a56:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801a59:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a5c:	0f 83 27 ff ff ff    	jae    801989 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801a62:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a67:	c9                   	leave  
  801a68:	c3                   	ret    

00801a69 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801a69:	55                   	push   %ebp
  801a6a:	89 e5                	mov    %esp,%ebp
  801a6c:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801a6f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801a73:	0f 84 e5 00 00 00    	je     801b5e <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801a79:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801a7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a82:	05 00 00 00 80       	add    $0x80000000,%eax
  801a87:	c1 e8 0c             	shr    $0xc,%eax
  801a8a:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801a8d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a90:	89 d0                	mov    %edx,%eax
  801a92:	01 c0                	add    %eax,%eax
  801a94:	01 d0                	add    %edx,%eax
  801a96:	c1 e0 02             	shl    $0x2,%eax
  801a99:	05 40 30 80 00       	add    $0x803040,%eax
  801a9e:	8b 00                	mov    (%eax),%eax
  801aa0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801aa3:	0f 85 b8 00 00 00    	jne    801b61 <free+0xf8>
  801aa9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801aac:	89 d0                	mov    %edx,%eax
  801aae:	01 c0                	add    %eax,%eax
  801ab0:	01 d0                	add    %edx,%eax
  801ab2:	c1 e0 02             	shl    $0x2,%eax
  801ab5:	05 48 30 80 00       	add    $0x803048,%eax
  801aba:	8b 00                	mov    (%eax),%eax
  801abc:	85 c0                	test   %eax,%eax
  801abe:	0f 84 9d 00 00 00    	je     801b61 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801ac4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ac7:	89 d0                	mov    %edx,%eax
  801ac9:	01 c0                	add    %eax,%eax
  801acb:	01 d0                	add    %edx,%eax
  801acd:	c1 e0 02             	shl    $0x2,%eax
  801ad0:	05 44 30 80 00       	add    $0x803044,%eax
  801ad5:	8b 00                	mov    (%eax),%eax
  801ad7:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801ada:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801add:	c1 e0 0c             	shl    $0xc,%eax
  801ae0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801ae3:	83 ec 08             	sub    $0x8,%esp
  801ae6:	ff 75 e4             	pushl  -0x1c(%ebp)
  801ae9:	ff 75 f0             	pushl  -0x10(%ebp)
  801aec:	e8 64 02 00 00       	call   801d55 <sys_freeMem>
  801af1:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801af4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801afb:	eb 57                	jmp    801b54 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801afd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b00:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b03:	01 c2                	add    %eax,%edx
  801b05:	89 d0                	mov    %edx,%eax
  801b07:	01 c0                	add    %eax,%eax
  801b09:	01 d0                	add    %edx,%eax
  801b0b:	c1 e0 02             	shl    $0x2,%eax
  801b0e:	05 48 30 80 00       	add    $0x803048,%eax
  801b13:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801b19:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b1f:	01 c2                	add    %eax,%edx
  801b21:	89 d0                	mov    %edx,%eax
  801b23:	01 c0                	add    %eax,%eax
  801b25:	01 d0                	add    %edx,%eax
  801b27:	c1 e0 02             	shl    $0x2,%eax
  801b2a:	05 40 30 80 00       	add    $0x803040,%eax
  801b2f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801b35:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b38:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b3b:	01 c2                	add    %eax,%edx
  801b3d:	89 d0                	mov    %edx,%eax
  801b3f:	01 c0                	add    %eax,%eax
  801b41:	01 d0                	add    %edx,%eax
  801b43:	c1 e0 02             	shl    $0x2,%eax
  801b46:	05 44 30 80 00       	add    $0x803044,%eax
  801b4b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801b51:	ff 45 f4             	incl   -0xc(%ebp)
  801b54:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b57:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b5a:	7c a1                	jl     801afd <free+0x94>
  801b5c:	eb 04                	jmp    801b62 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801b5e:	90                   	nop
  801b5f:	eb 01                	jmp    801b62 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801b61:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801b62:	c9                   	leave  
  801b63:	c3                   	ret    

00801b64 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801b64:	55                   	push   %ebp
  801b65:	89 e5                	mov    %esp,%ebp
  801b67:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801b6a:	83 ec 04             	sub    $0x4,%esp
  801b6d:	68 4c 2b 80 00       	push   $0x802b4c
  801b72:	68 ae 00 00 00       	push   $0xae
  801b77:	68 23 2b 80 00       	push   $0x802b23
  801b7c:	e8 49 eb ff ff       	call   8006ca <_panic>

00801b81 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801b81:	55                   	push   %ebp
  801b82:	89 e5                	mov    %esp,%ebp
  801b84:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801b87:	83 ec 04             	sub    $0x4,%esp
  801b8a:	68 6c 2b 80 00       	push   $0x802b6c
  801b8f:	68 ca 00 00 00       	push   $0xca
  801b94:	68 23 2b 80 00       	push   $0x802b23
  801b99:	e8 2c eb ff ff       	call   8006ca <_panic>

00801b9e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b9e:	55                   	push   %ebp
  801b9f:	89 e5                	mov    %esp,%ebp
  801ba1:	57                   	push   %edi
  801ba2:	56                   	push   %esi
  801ba3:	53                   	push   %ebx
  801ba4:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  801baa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bad:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bb0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bb3:	8b 7d 18             	mov    0x18(%ebp),%edi
  801bb6:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801bb9:	cd 30                	int    $0x30
  801bbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801bbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801bc1:	83 c4 10             	add    $0x10,%esp
  801bc4:	5b                   	pop    %ebx
  801bc5:	5e                   	pop    %esi
  801bc6:	5f                   	pop    %edi
  801bc7:	5d                   	pop    %ebp
  801bc8:	c3                   	ret    

00801bc9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801bc9:	55                   	push   %ebp
  801bca:	89 e5                	mov    %esp,%ebp
  801bcc:	83 ec 04             	sub    $0x4,%esp
  801bcf:	8b 45 10             	mov    0x10(%ebp),%eax
  801bd2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801bd5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	52                   	push   %edx
  801be1:	ff 75 0c             	pushl  0xc(%ebp)
  801be4:	50                   	push   %eax
  801be5:	6a 00                	push   $0x0
  801be7:	e8 b2 ff ff ff       	call   801b9e <syscall>
  801bec:	83 c4 18             	add    $0x18,%esp
}
  801bef:	90                   	nop
  801bf0:	c9                   	leave  
  801bf1:	c3                   	ret    

00801bf2 <sys_cgetc>:

int
sys_cgetc(void)
{
  801bf2:	55                   	push   %ebp
  801bf3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 01                	push   $0x1
  801c01:	e8 98 ff ff ff       	call   801b9e <syscall>
  801c06:	83 c4 18             	add    $0x18,%esp
}
  801c09:	c9                   	leave  
  801c0a:	c3                   	ret    

00801c0b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c0b:	55                   	push   %ebp
  801c0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	50                   	push   %eax
  801c1a:	6a 05                	push   $0x5
  801c1c:	e8 7d ff ff ff       	call   801b9e <syscall>
  801c21:	83 c4 18             	add    $0x18,%esp
}
  801c24:	c9                   	leave  
  801c25:	c3                   	ret    

00801c26 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c26:	55                   	push   %ebp
  801c27:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 02                	push   $0x2
  801c35:	e8 64 ff ff ff       	call   801b9e <syscall>
  801c3a:	83 c4 18             	add    $0x18,%esp
}
  801c3d:	c9                   	leave  
  801c3e:	c3                   	ret    

00801c3f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c3f:	55                   	push   %ebp
  801c40:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 03                	push   $0x3
  801c4e:	e8 4b ff ff ff       	call   801b9e <syscall>
  801c53:	83 c4 18             	add    $0x18,%esp
}
  801c56:	c9                   	leave  
  801c57:	c3                   	ret    

00801c58 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c58:	55                   	push   %ebp
  801c59:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	6a 00                	push   $0x0
  801c65:	6a 04                	push   $0x4
  801c67:	e8 32 ff ff ff       	call   801b9e <syscall>
  801c6c:	83 c4 18             	add    $0x18,%esp
}
  801c6f:	c9                   	leave  
  801c70:	c3                   	ret    

00801c71 <sys_env_exit>:


void sys_env_exit(void)
{
  801c71:	55                   	push   %ebp
  801c72:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 06                	push   $0x6
  801c80:	e8 19 ff ff ff       	call   801b9e <syscall>
  801c85:	83 c4 18             	add    $0x18,%esp
}
  801c88:	90                   	nop
  801c89:	c9                   	leave  
  801c8a:	c3                   	ret    

00801c8b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c8b:	55                   	push   %ebp
  801c8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c91:	8b 45 08             	mov    0x8(%ebp),%eax
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 00                	push   $0x0
  801c9a:	52                   	push   %edx
  801c9b:	50                   	push   %eax
  801c9c:	6a 07                	push   $0x7
  801c9e:	e8 fb fe ff ff       	call   801b9e <syscall>
  801ca3:	83 c4 18             	add    $0x18,%esp
}
  801ca6:	c9                   	leave  
  801ca7:	c3                   	ret    

00801ca8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ca8:	55                   	push   %ebp
  801ca9:	89 e5                	mov    %esp,%ebp
  801cab:	56                   	push   %esi
  801cac:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801cad:	8b 75 18             	mov    0x18(%ebp),%esi
  801cb0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cb3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbc:	56                   	push   %esi
  801cbd:	53                   	push   %ebx
  801cbe:	51                   	push   %ecx
  801cbf:	52                   	push   %edx
  801cc0:	50                   	push   %eax
  801cc1:	6a 08                	push   $0x8
  801cc3:	e8 d6 fe ff ff       	call   801b9e <syscall>
  801cc8:	83 c4 18             	add    $0x18,%esp
}
  801ccb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801cce:	5b                   	pop    %ebx
  801ccf:	5e                   	pop    %esi
  801cd0:	5d                   	pop    %ebp
  801cd1:	c3                   	ret    

00801cd2 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801cd2:	55                   	push   %ebp
  801cd3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801cd5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	52                   	push   %edx
  801ce2:	50                   	push   %eax
  801ce3:	6a 09                	push   $0x9
  801ce5:	e8 b4 fe ff ff       	call   801b9e <syscall>
  801cea:	83 c4 18             	add    $0x18,%esp
}
  801ced:	c9                   	leave  
  801cee:	c3                   	ret    

00801cef <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801cef:	55                   	push   %ebp
  801cf0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	ff 75 0c             	pushl  0xc(%ebp)
  801cfb:	ff 75 08             	pushl  0x8(%ebp)
  801cfe:	6a 0a                	push   $0xa
  801d00:	e8 99 fe ff ff       	call   801b9e <syscall>
  801d05:	83 c4 18             	add    $0x18,%esp
}
  801d08:	c9                   	leave  
  801d09:	c3                   	ret    

00801d0a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d0a:	55                   	push   %ebp
  801d0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	6a 0b                	push   $0xb
  801d19:	e8 80 fe ff ff       	call   801b9e <syscall>
  801d1e:	83 c4 18             	add    $0x18,%esp
}
  801d21:	c9                   	leave  
  801d22:	c3                   	ret    

00801d23 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d23:	55                   	push   %ebp
  801d24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 0c                	push   $0xc
  801d32:	e8 67 fe ff ff       	call   801b9e <syscall>
  801d37:	83 c4 18             	add    $0x18,%esp
}
  801d3a:	c9                   	leave  
  801d3b:	c3                   	ret    

00801d3c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d3c:	55                   	push   %ebp
  801d3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 0d                	push   $0xd
  801d4b:	e8 4e fe ff ff       	call   801b9e <syscall>
  801d50:	83 c4 18             	add    $0x18,%esp
}
  801d53:	c9                   	leave  
  801d54:	c3                   	ret    

00801d55 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d55:	55                   	push   %ebp
  801d56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	ff 75 0c             	pushl  0xc(%ebp)
  801d61:	ff 75 08             	pushl  0x8(%ebp)
  801d64:	6a 11                	push   $0x11
  801d66:	e8 33 fe ff ff       	call   801b9e <syscall>
  801d6b:	83 c4 18             	add    $0x18,%esp
	return;
  801d6e:	90                   	nop
}
  801d6f:	c9                   	leave  
  801d70:	c3                   	ret    

00801d71 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d71:	55                   	push   %ebp
  801d72:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	ff 75 0c             	pushl  0xc(%ebp)
  801d7d:	ff 75 08             	pushl  0x8(%ebp)
  801d80:	6a 12                	push   $0x12
  801d82:	e8 17 fe ff ff       	call   801b9e <syscall>
  801d87:	83 c4 18             	add    $0x18,%esp
	return ;
  801d8a:	90                   	nop
}
  801d8b:	c9                   	leave  
  801d8c:	c3                   	ret    

00801d8d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d8d:	55                   	push   %ebp
  801d8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 0e                	push   $0xe
  801d9c:	e8 fd fd ff ff       	call   801b9e <syscall>
  801da1:	83 c4 18             	add    $0x18,%esp
}
  801da4:	c9                   	leave  
  801da5:	c3                   	ret    

00801da6 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801da6:	55                   	push   %ebp
  801da7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801da9:	6a 00                	push   $0x0
  801dab:	6a 00                	push   $0x0
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	ff 75 08             	pushl  0x8(%ebp)
  801db4:	6a 0f                	push   $0xf
  801db6:	e8 e3 fd ff ff       	call   801b9e <syscall>
  801dbb:	83 c4 18             	add    $0x18,%esp
}
  801dbe:	c9                   	leave  
  801dbf:	c3                   	ret    

00801dc0 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801dc0:	55                   	push   %ebp
  801dc1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 10                	push   $0x10
  801dcf:	e8 ca fd ff ff       	call   801b9e <syscall>
  801dd4:	83 c4 18             	add    $0x18,%esp
}
  801dd7:	90                   	nop
  801dd8:	c9                   	leave  
  801dd9:	c3                   	ret    

00801dda <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801dda:	55                   	push   %ebp
  801ddb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 14                	push   $0x14
  801de9:	e8 b0 fd ff ff       	call   801b9e <syscall>
  801dee:	83 c4 18             	add    $0x18,%esp
}
  801df1:	90                   	nop
  801df2:	c9                   	leave  
  801df3:	c3                   	ret    

00801df4 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801df4:	55                   	push   %ebp
  801df5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	6a 15                	push   $0x15
  801e03:	e8 96 fd ff ff       	call   801b9e <syscall>
  801e08:	83 c4 18             	add    $0x18,%esp
}
  801e0b:	90                   	nop
  801e0c:	c9                   	leave  
  801e0d:	c3                   	ret    

00801e0e <sys_cputc>:


void
sys_cputc(const char c)
{
  801e0e:	55                   	push   %ebp
  801e0f:	89 e5                	mov    %esp,%ebp
  801e11:	83 ec 04             	sub    $0x4,%esp
  801e14:	8b 45 08             	mov    0x8(%ebp),%eax
  801e17:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e1a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	50                   	push   %eax
  801e27:	6a 16                	push   $0x16
  801e29:	e8 70 fd ff ff       	call   801b9e <syscall>
  801e2e:	83 c4 18             	add    $0x18,%esp
}
  801e31:	90                   	nop
  801e32:	c9                   	leave  
  801e33:	c3                   	ret    

00801e34 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e34:	55                   	push   %ebp
  801e35:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e37:	6a 00                	push   $0x0
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 17                	push   $0x17
  801e43:	e8 56 fd ff ff       	call   801b9e <syscall>
  801e48:	83 c4 18             	add    $0x18,%esp
}
  801e4b:	90                   	nop
  801e4c:	c9                   	leave  
  801e4d:	c3                   	ret    

00801e4e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e4e:	55                   	push   %ebp
  801e4f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e51:	8b 45 08             	mov    0x8(%ebp),%eax
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	ff 75 0c             	pushl  0xc(%ebp)
  801e5d:	50                   	push   %eax
  801e5e:	6a 18                	push   $0x18
  801e60:	e8 39 fd ff ff       	call   801b9e <syscall>
  801e65:	83 c4 18             	add    $0x18,%esp
}
  801e68:	c9                   	leave  
  801e69:	c3                   	ret    

00801e6a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e6a:	55                   	push   %ebp
  801e6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e70:	8b 45 08             	mov    0x8(%ebp),%eax
  801e73:	6a 00                	push   $0x0
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	52                   	push   %edx
  801e7a:	50                   	push   %eax
  801e7b:	6a 1b                	push   $0x1b
  801e7d:	e8 1c fd ff ff       	call   801b9e <syscall>
  801e82:	83 c4 18             	add    $0x18,%esp
}
  801e85:	c9                   	leave  
  801e86:	c3                   	ret    

00801e87 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e87:	55                   	push   %ebp
  801e88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	52                   	push   %edx
  801e97:	50                   	push   %eax
  801e98:	6a 19                	push   $0x19
  801e9a:	e8 ff fc ff ff       	call   801b9e <syscall>
  801e9f:	83 c4 18             	add    $0x18,%esp
}
  801ea2:	90                   	nop
  801ea3:	c9                   	leave  
  801ea4:	c3                   	ret    

00801ea5 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ea5:	55                   	push   %ebp
  801ea6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ea8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eab:	8b 45 08             	mov    0x8(%ebp),%eax
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 00                	push   $0x0
  801eb2:	6a 00                	push   $0x0
  801eb4:	52                   	push   %edx
  801eb5:	50                   	push   %eax
  801eb6:	6a 1a                	push   $0x1a
  801eb8:	e8 e1 fc ff ff       	call   801b9e <syscall>
  801ebd:	83 c4 18             	add    $0x18,%esp
}
  801ec0:	90                   	nop
  801ec1:	c9                   	leave  
  801ec2:	c3                   	ret    

00801ec3 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ec3:	55                   	push   %ebp
  801ec4:	89 e5                	mov    %esp,%ebp
  801ec6:	83 ec 04             	sub    $0x4,%esp
  801ec9:	8b 45 10             	mov    0x10(%ebp),%eax
  801ecc:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801ecf:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ed2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ed6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed9:	6a 00                	push   $0x0
  801edb:	51                   	push   %ecx
  801edc:	52                   	push   %edx
  801edd:	ff 75 0c             	pushl  0xc(%ebp)
  801ee0:	50                   	push   %eax
  801ee1:	6a 1c                	push   $0x1c
  801ee3:	e8 b6 fc ff ff       	call   801b9e <syscall>
  801ee8:	83 c4 18             	add    $0x18,%esp
}
  801eeb:	c9                   	leave  
  801eec:	c3                   	ret    

00801eed <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801eed:	55                   	push   %ebp
  801eee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ef0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	52                   	push   %edx
  801efd:	50                   	push   %eax
  801efe:	6a 1d                	push   $0x1d
  801f00:	e8 99 fc ff ff       	call   801b9e <syscall>
  801f05:	83 c4 18             	add    $0x18,%esp
}
  801f08:	c9                   	leave  
  801f09:	c3                   	ret    

00801f0a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f0a:	55                   	push   %ebp
  801f0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f0d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f10:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f13:	8b 45 08             	mov    0x8(%ebp),%eax
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	51                   	push   %ecx
  801f1b:	52                   	push   %edx
  801f1c:	50                   	push   %eax
  801f1d:	6a 1e                	push   $0x1e
  801f1f:	e8 7a fc ff ff       	call   801b9e <syscall>
  801f24:	83 c4 18             	add    $0x18,%esp
}
  801f27:	c9                   	leave  
  801f28:	c3                   	ret    

00801f29 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f29:	55                   	push   %ebp
  801f2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	52                   	push   %edx
  801f39:	50                   	push   %eax
  801f3a:	6a 1f                	push   $0x1f
  801f3c:	e8 5d fc ff ff       	call   801b9e <syscall>
  801f41:	83 c4 18             	add    $0x18,%esp
}
  801f44:	c9                   	leave  
  801f45:	c3                   	ret    

00801f46 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f46:	55                   	push   %ebp
  801f47:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	6a 20                	push   $0x20
  801f55:	e8 44 fc ff ff       	call   801b9e <syscall>
  801f5a:	83 c4 18             	add    $0x18,%esp
}
  801f5d:	c9                   	leave  
  801f5e:	c3                   	ret    

00801f5f <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801f5f:	55                   	push   %ebp
  801f60:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801f62:	8b 45 08             	mov    0x8(%ebp),%eax
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	ff 75 10             	pushl  0x10(%ebp)
  801f6c:	ff 75 0c             	pushl  0xc(%ebp)
  801f6f:	50                   	push   %eax
  801f70:	6a 21                	push   $0x21
  801f72:	e8 27 fc ff ff       	call   801b9e <syscall>
  801f77:	83 c4 18             	add    $0x18,%esp
}
  801f7a:	c9                   	leave  
  801f7b:	c3                   	ret    

00801f7c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801f7c:	55                   	push   %ebp
  801f7d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	6a 00                	push   $0x0
  801f88:	6a 00                	push   $0x0
  801f8a:	50                   	push   %eax
  801f8b:	6a 22                	push   $0x22
  801f8d:	e8 0c fc ff ff       	call   801b9e <syscall>
  801f92:	83 c4 18             	add    $0x18,%esp
}
  801f95:	90                   	nop
  801f96:	c9                   	leave  
  801f97:	c3                   	ret    

00801f98 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f98:	55                   	push   %ebp
  801f99:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 00                	push   $0x0
  801fa2:	6a 00                	push   $0x0
  801fa4:	6a 00                	push   $0x0
  801fa6:	50                   	push   %eax
  801fa7:	6a 23                	push   $0x23
  801fa9:	e8 f0 fb ff ff       	call   801b9e <syscall>
  801fae:	83 c4 18             	add    $0x18,%esp
}
  801fb1:	90                   	nop
  801fb2:	c9                   	leave  
  801fb3:	c3                   	ret    

00801fb4 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801fb4:	55                   	push   %ebp
  801fb5:	89 e5                	mov    %esp,%ebp
  801fb7:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801fba:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fbd:	8d 50 04             	lea    0x4(%eax),%edx
  801fc0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	52                   	push   %edx
  801fca:	50                   	push   %eax
  801fcb:	6a 24                	push   $0x24
  801fcd:	e8 cc fb ff ff       	call   801b9e <syscall>
  801fd2:	83 c4 18             	add    $0x18,%esp
	return result;
  801fd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801fd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801fdb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801fde:	89 01                	mov    %eax,(%ecx)
  801fe0:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe6:	c9                   	leave  
  801fe7:	c2 04 00             	ret    $0x4

00801fea <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801fea:	55                   	push   %ebp
  801feb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	ff 75 10             	pushl  0x10(%ebp)
  801ff4:	ff 75 0c             	pushl  0xc(%ebp)
  801ff7:	ff 75 08             	pushl  0x8(%ebp)
  801ffa:	6a 13                	push   $0x13
  801ffc:	e8 9d fb ff ff       	call   801b9e <syscall>
  802001:	83 c4 18             	add    $0x18,%esp
	return ;
  802004:	90                   	nop
}
  802005:	c9                   	leave  
  802006:	c3                   	ret    

00802007 <sys_rcr2>:
uint32 sys_rcr2()
{
  802007:	55                   	push   %ebp
  802008:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	6a 25                	push   $0x25
  802016:	e8 83 fb ff ff       	call   801b9e <syscall>
  80201b:	83 c4 18             	add    $0x18,%esp
}
  80201e:	c9                   	leave  
  80201f:	c3                   	ret    

00802020 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802020:	55                   	push   %ebp
  802021:	89 e5                	mov    %esp,%ebp
  802023:	83 ec 04             	sub    $0x4,%esp
  802026:	8b 45 08             	mov    0x8(%ebp),%eax
  802029:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80202c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802030:	6a 00                	push   $0x0
  802032:	6a 00                	push   $0x0
  802034:	6a 00                	push   $0x0
  802036:	6a 00                	push   $0x0
  802038:	50                   	push   %eax
  802039:	6a 26                	push   $0x26
  80203b:	e8 5e fb ff ff       	call   801b9e <syscall>
  802040:	83 c4 18             	add    $0x18,%esp
	return ;
  802043:	90                   	nop
}
  802044:	c9                   	leave  
  802045:	c3                   	ret    

00802046 <rsttst>:
void rsttst()
{
  802046:	55                   	push   %ebp
  802047:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	6a 00                	push   $0x0
  802053:	6a 28                	push   $0x28
  802055:	e8 44 fb ff ff       	call   801b9e <syscall>
  80205a:	83 c4 18             	add    $0x18,%esp
	return ;
  80205d:	90                   	nop
}
  80205e:	c9                   	leave  
  80205f:	c3                   	ret    

00802060 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802060:	55                   	push   %ebp
  802061:	89 e5                	mov    %esp,%ebp
  802063:	83 ec 04             	sub    $0x4,%esp
  802066:	8b 45 14             	mov    0x14(%ebp),%eax
  802069:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80206c:	8b 55 18             	mov    0x18(%ebp),%edx
  80206f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802073:	52                   	push   %edx
  802074:	50                   	push   %eax
  802075:	ff 75 10             	pushl  0x10(%ebp)
  802078:	ff 75 0c             	pushl  0xc(%ebp)
  80207b:	ff 75 08             	pushl  0x8(%ebp)
  80207e:	6a 27                	push   $0x27
  802080:	e8 19 fb ff ff       	call   801b9e <syscall>
  802085:	83 c4 18             	add    $0x18,%esp
	return ;
  802088:	90                   	nop
}
  802089:	c9                   	leave  
  80208a:	c3                   	ret    

0080208b <chktst>:
void chktst(uint32 n)
{
  80208b:	55                   	push   %ebp
  80208c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	6a 00                	push   $0x0
  802094:	6a 00                	push   $0x0
  802096:	ff 75 08             	pushl  0x8(%ebp)
  802099:	6a 29                	push   $0x29
  80209b:	e8 fe fa ff ff       	call   801b9e <syscall>
  8020a0:	83 c4 18             	add    $0x18,%esp
	return ;
  8020a3:	90                   	nop
}
  8020a4:	c9                   	leave  
  8020a5:	c3                   	ret    

008020a6 <inctst>:

void inctst()
{
  8020a6:	55                   	push   %ebp
  8020a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8020a9:	6a 00                	push   $0x0
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 2a                	push   $0x2a
  8020b5:	e8 e4 fa ff ff       	call   801b9e <syscall>
  8020ba:	83 c4 18             	add    $0x18,%esp
	return ;
  8020bd:	90                   	nop
}
  8020be:	c9                   	leave  
  8020bf:	c3                   	ret    

008020c0 <gettst>:
uint32 gettst()
{
  8020c0:	55                   	push   %ebp
  8020c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 2b                	push   $0x2b
  8020cf:	e8 ca fa ff ff       	call   801b9e <syscall>
  8020d4:	83 c4 18             	add    $0x18,%esp
}
  8020d7:	c9                   	leave  
  8020d8:	c3                   	ret    

008020d9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8020d9:	55                   	push   %ebp
  8020da:	89 e5                	mov    %esp,%ebp
  8020dc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	6a 00                	push   $0x0
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 2c                	push   $0x2c
  8020eb:	e8 ae fa ff ff       	call   801b9e <syscall>
  8020f0:	83 c4 18             	add    $0x18,%esp
  8020f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8020f6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8020fa:	75 07                	jne    802103 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8020fc:	b8 01 00 00 00       	mov    $0x1,%eax
  802101:	eb 05                	jmp    802108 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802103:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802108:	c9                   	leave  
  802109:	c3                   	ret    

0080210a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80210a:	55                   	push   %ebp
  80210b:	89 e5                	mov    %esp,%ebp
  80210d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	6a 2c                	push   $0x2c
  80211c:	e8 7d fa ff ff       	call   801b9e <syscall>
  802121:	83 c4 18             	add    $0x18,%esp
  802124:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802127:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80212b:	75 07                	jne    802134 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80212d:	b8 01 00 00 00       	mov    $0x1,%eax
  802132:	eb 05                	jmp    802139 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802134:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802139:	c9                   	leave  
  80213a:	c3                   	ret    

0080213b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80213b:	55                   	push   %ebp
  80213c:	89 e5                	mov    %esp,%ebp
  80213e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802141:	6a 00                	push   $0x0
  802143:	6a 00                	push   $0x0
  802145:	6a 00                	push   $0x0
  802147:	6a 00                	push   $0x0
  802149:	6a 00                	push   $0x0
  80214b:	6a 2c                	push   $0x2c
  80214d:	e8 4c fa ff ff       	call   801b9e <syscall>
  802152:	83 c4 18             	add    $0x18,%esp
  802155:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802158:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80215c:	75 07                	jne    802165 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80215e:	b8 01 00 00 00       	mov    $0x1,%eax
  802163:	eb 05                	jmp    80216a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802165:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80216a:	c9                   	leave  
  80216b:	c3                   	ret    

0080216c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80216c:	55                   	push   %ebp
  80216d:	89 e5                	mov    %esp,%ebp
  80216f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 00                	push   $0x0
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	6a 2c                	push   $0x2c
  80217e:	e8 1b fa ff ff       	call   801b9e <syscall>
  802183:	83 c4 18             	add    $0x18,%esp
  802186:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802189:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80218d:	75 07                	jne    802196 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80218f:	b8 01 00 00 00       	mov    $0x1,%eax
  802194:	eb 05                	jmp    80219b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802196:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80219b:	c9                   	leave  
  80219c:	c3                   	ret    

0080219d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80219d:	55                   	push   %ebp
  80219e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021a0:	6a 00                	push   $0x0
  8021a2:	6a 00                	push   $0x0
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	ff 75 08             	pushl  0x8(%ebp)
  8021ab:	6a 2d                	push   $0x2d
  8021ad:	e8 ec f9 ff ff       	call   801b9e <syscall>
  8021b2:	83 c4 18             	add    $0x18,%esp
	return ;
  8021b5:	90                   	nop
}
  8021b6:	c9                   	leave  
  8021b7:	c3                   	ret    

008021b8 <__udivdi3>:
  8021b8:	55                   	push   %ebp
  8021b9:	57                   	push   %edi
  8021ba:	56                   	push   %esi
  8021bb:	53                   	push   %ebx
  8021bc:	83 ec 1c             	sub    $0x1c,%esp
  8021bf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021c3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021c7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021cb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021cf:	89 ca                	mov    %ecx,%edx
  8021d1:	89 f8                	mov    %edi,%eax
  8021d3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021d7:	85 f6                	test   %esi,%esi
  8021d9:	75 2d                	jne    802208 <__udivdi3+0x50>
  8021db:	39 cf                	cmp    %ecx,%edi
  8021dd:	77 65                	ja     802244 <__udivdi3+0x8c>
  8021df:	89 fd                	mov    %edi,%ebp
  8021e1:	85 ff                	test   %edi,%edi
  8021e3:	75 0b                	jne    8021f0 <__udivdi3+0x38>
  8021e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8021ea:	31 d2                	xor    %edx,%edx
  8021ec:	f7 f7                	div    %edi
  8021ee:	89 c5                	mov    %eax,%ebp
  8021f0:	31 d2                	xor    %edx,%edx
  8021f2:	89 c8                	mov    %ecx,%eax
  8021f4:	f7 f5                	div    %ebp
  8021f6:	89 c1                	mov    %eax,%ecx
  8021f8:	89 d8                	mov    %ebx,%eax
  8021fa:	f7 f5                	div    %ebp
  8021fc:	89 cf                	mov    %ecx,%edi
  8021fe:	89 fa                	mov    %edi,%edx
  802200:	83 c4 1c             	add    $0x1c,%esp
  802203:	5b                   	pop    %ebx
  802204:	5e                   	pop    %esi
  802205:	5f                   	pop    %edi
  802206:	5d                   	pop    %ebp
  802207:	c3                   	ret    
  802208:	39 ce                	cmp    %ecx,%esi
  80220a:	77 28                	ja     802234 <__udivdi3+0x7c>
  80220c:	0f bd fe             	bsr    %esi,%edi
  80220f:	83 f7 1f             	xor    $0x1f,%edi
  802212:	75 40                	jne    802254 <__udivdi3+0x9c>
  802214:	39 ce                	cmp    %ecx,%esi
  802216:	72 0a                	jb     802222 <__udivdi3+0x6a>
  802218:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80221c:	0f 87 9e 00 00 00    	ja     8022c0 <__udivdi3+0x108>
  802222:	b8 01 00 00 00       	mov    $0x1,%eax
  802227:	89 fa                	mov    %edi,%edx
  802229:	83 c4 1c             	add    $0x1c,%esp
  80222c:	5b                   	pop    %ebx
  80222d:	5e                   	pop    %esi
  80222e:	5f                   	pop    %edi
  80222f:	5d                   	pop    %ebp
  802230:	c3                   	ret    
  802231:	8d 76 00             	lea    0x0(%esi),%esi
  802234:	31 ff                	xor    %edi,%edi
  802236:	31 c0                	xor    %eax,%eax
  802238:	89 fa                	mov    %edi,%edx
  80223a:	83 c4 1c             	add    $0x1c,%esp
  80223d:	5b                   	pop    %ebx
  80223e:	5e                   	pop    %esi
  80223f:	5f                   	pop    %edi
  802240:	5d                   	pop    %ebp
  802241:	c3                   	ret    
  802242:	66 90                	xchg   %ax,%ax
  802244:	89 d8                	mov    %ebx,%eax
  802246:	f7 f7                	div    %edi
  802248:	31 ff                	xor    %edi,%edi
  80224a:	89 fa                	mov    %edi,%edx
  80224c:	83 c4 1c             	add    $0x1c,%esp
  80224f:	5b                   	pop    %ebx
  802250:	5e                   	pop    %esi
  802251:	5f                   	pop    %edi
  802252:	5d                   	pop    %ebp
  802253:	c3                   	ret    
  802254:	bd 20 00 00 00       	mov    $0x20,%ebp
  802259:	89 eb                	mov    %ebp,%ebx
  80225b:	29 fb                	sub    %edi,%ebx
  80225d:	89 f9                	mov    %edi,%ecx
  80225f:	d3 e6                	shl    %cl,%esi
  802261:	89 c5                	mov    %eax,%ebp
  802263:	88 d9                	mov    %bl,%cl
  802265:	d3 ed                	shr    %cl,%ebp
  802267:	89 e9                	mov    %ebp,%ecx
  802269:	09 f1                	or     %esi,%ecx
  80226b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80226f:	89 f9                	mov    %edi,%ecx
  802271:	d3 e0                	shl    %cl,%eax
  802273:	89 c5                	mov    %eax,%ebp
  802275:	89 d6                	mov    %edx,%esi
  802277:	88 d9                	mov    %bl,%cl
  802279:	d3 ee                	shr    %cl,%esi
  80227b:	89 f9                	mov    %edi,%ecx
  80227d:	d3 e2                	shl    %cl,%edx
  80227f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802283:	88 d9                	mov    %bl,%cl
  802285:	d3 e8                	shr    %cl,%eax
  802287:	09 c2                	or     %eax,%edx
  802289:	89 d0                	mov    %edx,%eax
  80228b:	89 f2                	mov    %esi,%edx
  80228d:	f7 74 24 0c          	divl   0xc(%esp)
  802291:	89 d6                	mov    %edx,%esi
  802293:	89 c3                	mov    %eax,%ebx
  802295:	f7 e5                	mul    %ebp
  802297:	39 d6                	cmp    %edx,%esi
  802299:	72 19                	jb     8022b4 <__udivdi3+0xfc>
  80229b:	74 0b                	je     8022a8 <__udivdi3+0xf0>
  80229d:	89 d8                	mov    %ebx,%eax
  80229f:	31 ff                	xor    %edi,%edi
  8022a1:	e9 58 ff ff ff       	jmp    8021fe <__udivdi3+0x46>
  8022a6:	66 90                	xchg   %ax,%ax
  8022a8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022ac:	89 f9                	mov    %edi,%ecx
  8022ae:	d3 e2                	shl    %cl,%edx
  8022b0:	39 c2                	cmp    %eax,%edx
  8022b2:	73 e9                	jae    80229d <__udivdi3+0xe5>
  8022b4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022b7:	31 ff                	xor    %edi,%edi
  8022b9:	e9 40 ff ff ff       	jmp    8021fe <__udivdi3+0x46>
  8022be:	66 90                	xchg   %ax,%ax
  8022c0:	31 c0                	xor    %eax,%eax
  8022c2:	e9 37 ff ff ff       	jmp    8021fe <__udivdi3+0x46>
  8022c7:	90                   	nop

008022c8 <__umoddi3>:
  8022c8:	55                   	push   %ebp
  8022c9:	57                   	push   %edi
  8022ca:	56                   	push   %esi
  8022cb:	53                   	push   %ebx
  8022cc:	83 ec 1c             	sub    $0x1c,%esp
  8022cf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022d3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022db:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022df:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022e3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022e7:	89 f3                	mov    %esi,%ebx
  8022e9:	89 fa                	mov    %edi,%edx
  8022eb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022ef:	89 34 24             	mov    %esi,(%esp)
  8022f2:	85 c0                	test   %eax,%eax
  8022f4:	75 1a                	jne    802310 <__umoddi3+0x48>
  8022f6:	39 f7                	cmp    %esi,%edi
  8022f8:	0f 86 a2 00 00 00    	jbe    8023a0 <__umoddi3+0xd8>
  8022fe:	89 c8                	mov    %ecx,%eax
  802300:	89 f2                	mov    %esi,%edx
  802302:	f7 f7                	div    %edi
  802304:	89 d0                	mov    %edx,%eax
  802306:	31 d2                	xor    %edx,%edx
  802308:	83 c4 1c             	add    $0x1c,%esp
  80230b:	5b                   	pop    %ebx
  80230c:	5e                   	pop    %esi
  80230d:	5f                   	pop    %edi
  80230e:	5d                   	pop    %ebp
  80230f:	c3                   	ret    
  802310:	39 f0                	cmp    %esi,%eax
  802312:	0f 87 ac 00 00 00    	ja     8023c4 <__umoddi3+0xfc>
  802318:	0f bd e8             	bsr    %eax,%ebp
  80231b:	83 f5 1f             	xor    $0x1f,%ebp
  80231e:	0f 84 ac 00 00 00    	je     8023d0 <__umoddi3+0x108>
  802324:	bf 20 00 00 00       	mov    $0x20,%edi
  802329:	29 ef                	sub    %ebp,%edi
  80232b:	89 fe                	mov    %edi,%esi
  80232d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802331:	89 e9                	mov    %ebp,%ecx
  802333:	d3 e0                	shl    %cl,%eax
  802335:	89 d7                	mov    %edx,%edi
  802337:	89 f1                	mov    %esi,%ecx
  802339:	d3 ef                	shr    %cl,%edi
  80233b:	09 c7                	or     %eax,%edi
  80233d:	89 e9                	mov    %ebp,%ecx
  80233f:	d3 e2                	shl    %cl,%edx
  802341:	89 14 24             	mov    %edx,(%esp)
  802344:	89 d8                	mov    %ebx,%eax
  802346:	d3 e0                	shl    %cl,%eax
  802348:	89 c2                	mov    %eax,%edx
  80234a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80234e:	d3 e0                	shl    %cl,%eax
  802350:	89 44 24 04          	mov    %eax,0x4(%esp)
  802354:	8b 44 24 08          	mov    0x8(%esp),%eax
  802358:	89 f1                	mov    %esi,%ecx
  80235a:	d3 e8                	shr    %cl,%eax
  80235c:	09 d0                	or     %edx,%eax
  80235e:	d3 eb                	shr    %cl,%ebx
  802360:	89 da                	mov    %ebx,%edx
  802362:	f7 f7                	div    %edi
  802364:	89 d3                	mov    %edx,%ebx
  802366:	f7 24 24             	mull   (%esp)
  802369:	89 c6                	mov    %eax,%esi
  80236b:	89 d1                	mov    %edx,%ecx
  80236d:	39 d3                	cmp    %edx,%ebx
  80236f:	0f 82 87 00 00 00    	jb     8023fc <__umoddi3+0x134>
  802375:	0f 84 91 00 00 00    	je     80240c <__umoddi3+0x144>
  80237b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80237f:	29 f2                	sub    %esi,%edx
  802381:	19 cb                	sbb    %ecx,%ebx
  802383:	89 d8                	mov    %ebx,%eax
  802385:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802389:	d3 e0                	shl    %cl,%eax
  80238b:	89 e9                	mov    %ebp,%ecx
  80238d:	d3 ea                	shr    %cl,%edx
  80238f:	09 d0                	or     %edx,%eax
  802391:	89 e9                	mov    %ebp,%ecx
  802393:	d3 eb                	shr    %cl,%ebx
  802395:	89 da                	mov    %ebx,%edx
  802397:	83 c4 1c             	add    $0x1c,%esp
  80239a:	5b                   	pop    %ebx
  80239b:	5e                   	pop    %esi
  80239c:	5f                   	pop    %edi
  80239d:	5d                   	pop    %ebp
  80239e:	c3                   	ret    
  80239f:	90                   	nop
  8023a0:	89 fd                	mov    %edi,%ebp
  8023a2:	85 ff                	test   %edi,%edi
  8023a4:	75 0b                	jne    8023b1 <__umoddi3+0xe9>
  8023a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8023ab:	31 d2                	xor    %edx,%edx
  8023ad:	f7 f7                	div    %edi
  8023af:	89 c5                	mov    %eax,%ebp
  8023b1:	89 f0                	mov    %esi,%eax
  8023b3:	31 d2                	xor    %edx,%edx
  8023b5:	f7 f5                	div    %ebp
  8023b7:	89 c8                	mov    %ecx,%eax
  8023b9:	f7 f5                	div    %ebp
  8023bb:	89 d0                	mov    %edx,%eax
  8023bd:	e9 44 ff ff ff       	jmp    802306 <__umoddi3+0x3e>
  8023c2:	66 90                	xchg   %ax,%ax
  8023c4:	89 c8                	mov    %ecx,%eax
  8023c6:	89 f2                	mov    %esi,%edx
  8023c8:	83 c4 1c             	add    $0x1c,%esp
  8023cb:	5b                   	pop    %ebx
  8023cc:	5e                   	pop    %esi
  8023cd:	5f                   	pop    %edi
  8023ce:	5d                   	pop    %ebp
  8023cf:	c3                   	ret    
  8023d0:	3b 04 24             	cmp    (%esp),%eax
  8023d3:	72 06                	jb     8023db <__umoddi3+0x113>
  8023d5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023d9:	77 0f                	ja     8023ea <__umoddi3+0x122>
  8023db:	89 f2                	mov    %esi,%edx
  8023dd:	29 f9                	sub    %edi,%ecx
  8023df:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023e3:	89 14 24             	mov    %edx,(%esp)
  8023e6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023ea:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023ee:	8b 14 24             	mov    (%esp),%edx
  8023f1:	83 c4 1c             	add    $0x1c,%esp
  8023f4:	5b                   	pop    %ebx
  8023f5:	5e                   	pop    %esi
  8023f6:	5f                   	pop    %edi
  8023f7:	5d                   	pop    %ebp
  8023f8:	c3                   	ret    
  8023f9:	8d 76 00             	lea    0x0(%esi),%esi
  8023fc:	2b 04 24             	sub    (%esp),%eax
  8023ff:	19 fa                	sbb    %edi,%edx
  802401:	89 d1                	mov    %edx,%ecx
  802403:	89 c6                	mov    %eax,%esi
  802405:	e9 71 ff ff ff       	jmp    80237b <__umoddi3+0xb3>
  80240a:	66 90                	xchg   %ax,%ax
  80240c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802410:	72 ea                	jb     8023fc <__umoddi3+0x134>
  802412:	89 d9                	mov    %ebx,%ecx
  802414:	e9 62 ff ff ff       	jmp    80237b <__umoddi3+0xb3>
