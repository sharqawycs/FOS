
obj/user/quicksort_interrupt:     file format elf32-i386


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
  800031:	e8 c4 05 00 00       	call   8005fa <libmain>
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
  800049:	e8 ee 1c 00 00       	call   801d3c <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 00 1d 00 00       	call   801d55 <sys_calculate_modified_frames>
  800055:	01 d8                	add    %ebx,%eax
  800057:	89 45 f0             	mov    %eax,-0x10(%ebp)

		Iteration++ ;
  80005a:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();

		sys_disable_interrupt();
  80005d:	e8 aa 1d 00 00       	call   801e0c <sys_disable_interrupt>
			readline("Enter the number of elements: ", Line);
  800062:	83 ec 08             	sub    $0x8,%esp
  800065:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  80006b:	50                   	push   %eax
  80006c:	68 60 24 80 00       	push   $0x802460
  800071:	e8 bc 0f 00 00       	call   801032 <readline>
  800076:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  800079:	83 ec 04             	sub    $0x4,%esp
  80007c:	6a 0a                	push   $0xa
  80007e:	6a 00                	push   $0x0
  800080:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800086:	50                   	push   %eax
  800087:	e8 0c 15 00 00       	call   801598 <strtol>
  80008c:	83 c4 10             	add    $0x10,%esp
  80008f:	89 45 ec             	mov    %eax,-0x14(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800092:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800095:	c1 e0 02             	shl    $0x2,%eax
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	50                   	push   %eax
  80009c:	e8 d9 18 00 00       	call   80197a <malloc>
  8000a1:	83 c4 10             	add    $0x10,%esp
  8000a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000a7:	83 ec 0c             	sub    $0xc,%esp
  8000aa:	68 80 24 80 00       	push   $0x802480
  8000af:	e8 fc 08 00 00       	call   8009b0 <cprintf>
  8000b4:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000b7:	83 ec 0c             	sub    $0xc,%esp
  8000ba:	68 a3 24 80 00       	push   $0x8024a3
  8000bf:	e8 ec 08 00 00       	call   8009b0 <cprintf>
  8000c4:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000c7:	83 ec 0c             	sub    $0xc,%esp
  8000ca:	68 b1 24 80 00       	push   $0x8024b1
  8000cf:	e8 dc 08 00 00       	call   8009b0 <cprintf>
  8000d4:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\nSelect: ") ;
  8000d7:	83 ec 0c             	sub    $0xc,%esp
  8000da:	68 c0 24 80 00       	push   $0x8024c0
  8000df:	e8 cc 08 00 00       	call   8009b0 <cprintf>
  8000e4:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8000e7:	e8 b6 04 00 00       	call   8005a2 <getchar>
  8000ec:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  8000ef:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8000f3:	83 ec 0c             	sub    $0xc,%esp
  8000f6:	50                   	push   %eax
  8000f7:	e8 5e 04 00 00       	call   80055a <cputchar>
  8000fc:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8000ff:	83 ec 0c             	sub    $0xc,%esp
  800102:	6a 0a                	push   $0xa
  800104:	e8 51 04 00 00       	call   80055a <cputchar>
  800109:	83 c4 10             	add    $0x10,%esp
		sys_enable_interrupt();
  80010c:	e8 15 1d 00 00       	call   801e26 <sys_enable_interrupt>
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800111:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800115:	83 f8 62             	cmp    $0x62,%eax
  800118:	74 1d                	je     800137 <_main+0xff>
  80011a:	83 f8 63             	cmp    $0x63,%eax
  80011d:	74 2b                	je     80014a <_main+0x112>
  80011f:	83 f8 61             	cmp    $0x61,%eax
  800122:	75 39                	jne    80015d <_main+0x125>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800124:	83 ec 08             	sub    $0x8,%esp
  800127:	ff 75 ec             	pushl  -0x14(%ebp)
  80012a:	ff 75 e8             	pushl  -0x18(%ebp)
  80012d:	e8 e6 02 00 00       	call   800418 <InitializeAscending>
  800132:	83 c4 10             	add    $0x10,%esp
			break ;
  800135:	eb 37                	jmp    80016e <_main+0x136>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  800137:	83 ec 08             	sub    $0x8,%esp
  80013a:	ff 75 ec             	pushl  -0x14(%ebp)
  80013d:	ff 75 e8             	pushl  -0x18(%ebp)
  800140:	e8 04 03 00 00       	call   800449 <InitializeDescending>
  800145:	83 c4 10             	add    $0x10,%esp
			break ;
  800148:	eb 24                	jmp    80016e <_main+0x136>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80014a:	83 ec 08             	sub    $0x8,%esp
  80014d:	ff 75 ec             	pushl  -0x14(%ebp)
  800150:	ff 75 e8             	pushl  -0x18(%ebp)
  800153:	e8 26 03 00 00       	call   80047e <InitializeSemiRandom>
  800158:	83 c4 10             	add    $0x10,%esp
			break ;
  80015b:	eb 11                	jmp    80016e <_main+0x136>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  80015d:	83 ec 08             	sub    $0x8,%esp
  800160:	ff 75 ec             	pushl  -0x14(%ebp)
  800163:	ff 75 e8             	pushl  -0x18(%ebp)
  800166:	e8 13 03 00 00       	call   80047e <InitializeSemiRandom>
  80016b:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  80016e:	83 ec 08             	sub    $0x8,%esp
  800171:	ff 75 ec             	pushl  -0x14(%ebp)
  800174:	ff 75 e8             	pushl  -0x18(%ebp)
  800177:	e8 e1 00 00 00       	call   80025d <QuickSort>
  80017c:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  80017f:	83 ec 08             	sub    $0x8,%esp
  800182:	ff 75 ec             	pushl  -0x14(%ebp)
  800185:	ff 75 e8             	pushl  -0x18(%ebp)
  800188:	e8 e1 01 00 00       	call   80036e <CheckSorted>
  80018d:	83 c4 10             	add    $0x10,%esp
  800190:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800193:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800197:	75 14                	jne    8001ad <_main+0x175>
  800199:	83 ec 04             	sub    $0x4,%esp
  80019c:	68 d8 24 80 00       	push   $0x8024d8
  8001a1:	6a 42                	push   $0x42
  8001a3:	68 fa 24 80 00       	push   $0x8024fa
  8001a8:	e8 4f 05 00 00       	call   8006fc <_panic>
		else
		{ 
			sys_disable_interrupt();
  8001ad:	e8 5a 1c 00 00       	call   801e0c <sys_disable_interrupt>
				cprintf("\n===============================================\n") ;
  8001b2:	83 ec 0c             	sub    $0xc,%esp
  8001b5:	68 18 25 80 00       	push   $0x802518
  8001ba:	e8 f1 07 00 00       	call   8009b0 <cprintf>
  8001bf:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001c2:	83 ec 0c             	sub    $0xc,%esp
  8001c5:	68 4c 25 80 00       	push   $0x80254c
  8001ca:	e8 e1 07 00 00       	call   8009b0 <cprintf>
  8001cf:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  8001d2:	83 ec 0c             	sub    $0xc,%esp
  8001d5:	68 80 25 80 00       	push   $0x802580
  8001da:	e8 d1 07 00 00       	call   8009b0 <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8001e2:	e8 3f 1c 00 00       	call   801e26 <sys_enable_interrupt>
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_disable_interrupt();
  8001e7:	e8 20 1c 00 00       	call   801e0c <sys_disable_interrupt>
			cprintf("Freeing the Heap...\n\n") ;
  8001ec:	83 ec 0c             	sub    $0xc,%esp
  8001ef:	68 b2 25 80 00       	push   $0x8025b2
  8001f4:	e8 b7 07 00 00       	call   8009b0 <cprintf>
  8001f9:	83 c4 10             	add    $0x10,%esp
		sys_enable_interrupt();
  8001fc:	e8 25 1c 00 00       	call   801e26 <sys_enable_interrupt>

		//freeHeap() ;

		///========================================================================
	//sys_disable_interrupt();
		sys_disable_interrupt();
  800201:	e8 06 1c 00 00       	call   801e0c <sys_disable_interrupt>
			cprintf("Do you want to repeat (y/n): ") ;
  800206:	83 ec 0c             	sub    $0xc,%esp
  800209:	68 c8 25 80 00       	push   $0x8025c8
  80020e:	e8 9d 07 00 00       	call   8009b0 <cprintf>
  800213:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800216:	e8 87 03 00 00       	call   8005a2 <getchar>
  80021b:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  80021e:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	50                   	push   %eax
  800226:	e8 2f 03 00 00       	call   80055a <cputchar>
  80022b:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80022e:	83 ec 0c             	sub    $0xc,%esp
  800231:	6a 0a                	push   $0xa
  800233:	e8 22 03 00 00       	call   80055a <cputchar>
  800238:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80023b:	83 ec 0c             	sub    $0xc,%esp
  80023e:	6a 0a                	push   $0xa
  800240:	e8 15 03 00 00       	call   80055a <cputchar>
  800245:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_enable_interrupt();
  800248:	e8 d9 1b 00 00       	call   801e26 <sys_enable_interrupt>

	} while (Chose == 'y');
  80024d:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800251:	0f 84 f2 fd ff ff    	je     800049 <_main+0x11>

}
  800257:	90                   	nop
  800258:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80025b:	c9                   	leave  
  80025c:	c3                   	ret    

0080025d <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  80025d:	55                   	push   %ebp
  80025e:	89 e5                	mov    %esp,%ebp
  800260:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800263:	8b 45 0c             	mov    0xc(%ebp),%eax
  800266:	48                   	dec    %eax
  800267:	50                   	push   %eax
  800268:	6a 00                	push   $0x0
  80026a:	ff 75 0c             	pushl  0xc(%ebp)
  80026d:	ff 75 08             	pushl  0x8(%ebp)
  800270:	e8 06 00 00 00       	call   80027b <QSort>
  800275:	83 c4 10             	add    $0x10,%esp
}
  800278:	90                   	nop
  800279:	c9                   	leave  
  80027a:	c3                   	ret    

0080027b <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  80027b:	55                   	push   %ebp
  80027c:	89 e5                	mov    %esp,%ebp
  80027e:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800281:	8b 45 10             	mov    0x10(%ebp),%eax
  800284:	3b 45 14             	cmp    0x14(%ebp),%eax
  800287:	0f 8d de 00 00 00    	jge    80036b <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  80028d:	8b 45 10             	mov    0x10(%ebp),%eax
  800290:	40                   	inc    %eax
  800291:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800294:	8b 45 14             	mov    0x14(%ebp),%eax
  800297:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  80029a:	e9 80 00 00 00       	jmp    80031f <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  80029f:	ff 45 f4             	incl   -0xc(%ebp)
  8002a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002a5:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002a8:	7f 2b                	jg     8002d5 <QSort+0x5a>
  8002aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b7:	01 d0                	add    %edx,%eax
  8002b9:	8b 10                	mov    (%eax),%edx
  8002bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002be:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c8:	01 c8                	add    %ecx,%eax
  8002ca:	8b 00                	mov    (%eax),%eax
  8002cc:	39 c2                	cmp    %eax,%edx
  8002ce:	7d cf                	jge    80029f <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002d0:	eb 03                	jmp    8002d5 <QSort+0x5a>
  8002d2:	ff 4d f0             	decl   -0x10(%ebp)
  8002d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002d8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002db:	7e 26                	jle    800303 <QSort+0x88>
  8002dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ea:	01 d0                	add    %edx,%eax
  8002ec:	8b 10                	mov    (%eax),%edx
  8002ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002f1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8002fb:	01 c8                	add    %ecx,%eax
  8002fd:	8b 00                	mov    (%eax),%eax
  8002ff:	39 c2                	cmp    %eax,%edx
  800301:	7e cf                	jle    8002d2 <QSort+0x57>

		if (i <= j)
  800303:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800306:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800309:	7f 14                	jg     80031f <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80030b:	83 ec 04             	sub    $0x4,%esp
  80030e:	ff 75 f0             	pushl  -0x10(%ebp)
  800311:	ff 75 f4             	pushl  -0xc(%ebp)
  800314:	ff 75 08             	pushl  0x8(%ebp)
  800317:	e8 a9 00 00 00       	call   8003c5 <Swap>
  80031c:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  80031f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800322:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800325:	0f 8e 77 ff ff ff    	jle    8002a2 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80032b:	83 ec 04             	sub    $0x4,%esp
  80032e:	ff 75 f0             	pushl  -0x10(%ebp)
  800331:	ff 75 10             	pushl  0x10(%ebp)
  800334:	ff 75 08             	pushl  0x8(%ebp)
  800337:	e8 89 00 00 00       	call   8003c5 <Swap>
  80033c:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80033f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800342:	48                   	dec    %eax
  800343:	50                   	push   %eax
  800344:	ff 75 10             	pushl  0x10(%ebp)
  800347:	ff 75 0c             	pushl  0xc(%ebp)
  80034a:	ff 75 08             	pushl  0x8(%ebp)
  80034d:	e8 29 ff ff ff       	call   80027b <QSort>
  800352:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800355:	ff 75 14             	pushl  0x14(%ebp)
  800358:	ff 75 f4             	pushl  -0xc(%ebp)
  80035b:	ff 75 0c             	pushl  0xc(%ebp)
  80035e:	ff 75 08             	pushl  0x8(%ebp)
  800361:	e8 15 ff ff ff       	call   80027b <QSort>
  800366:	83 c4 10             	add    $0x10,%esp
  800369:	eb 01                	jmp    80036c <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  80036b:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  80036c:	c9                   	leave  
  80036d:	c3                   	ret    

0080036e <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80036e:	55                   	push   %ebp
  80036f:	89 e5                	mov    %esp,%ebp
  800371:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800374:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80037b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800382:	eb 33                	jmp    8003b7 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800384:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800387:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80038e:	8b 45 08             	mov    0x8(%ebp),%eax
  800391:	01 d0                	add    %edx,%eax
  800393:	8b 10                	mov    (%eax),%edx
  800395:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800398:	40                   	inc    %eax
  800399:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a3:	01 c8                	add    %ecx,%eax
  8003a5:	8b 00                	mov    (%eax),%eax
  8003a7:	39 c2                	cmp    %eax,%edx
  8003a9:	7e 09                	jle    8003b4 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003ab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003b2:	eb 0c                	jmp    8003c0 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003b4:	ff 45 f8             	incl   -0x8(%ebp)
  8003b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ba:	48                   	dec    %eax
  8003bb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003be:	7f c4                	jg     800384 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003c3:	c9                   	leave  
  8003c4:	c3                   	ret    

008003c5 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003c5:	55                   	push   %ebp
  8003c6:	89 e5                	mov    %esp,%ebp
  8003c8:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d8:	01 d0                	add    %edx,%eax
  8003da:	8b 00                	mov    (%eax),%eax
  8003dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ec:	01 c2                	add    %eax,%edx
  8003ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8003f1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fb:	01 c8                	add    %ecx,%eax
  8003fd:	8b 00                	mov    (%eax),%eax
  8003ff:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800401:	8b 45 10             	mov    0x10(%ebp),%eax
  800404:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040b:	8b 45 08             	mov    0x8(%ebp),%eax
  80040e:	01 c2                	add    %eax,%edx
  800410:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800413:	89 02                	mov    %eax,(%edx)
}
  800415:	90                   	nop
  800416:	c9                   	leave  
  800417:	c3                   	ret    

00800418 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800418:	55                   	push   %ebp
  800419:	89 e5                	mov    %esp,%ebp
  80041b:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80041e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800425:	eb 17                	jmp    80043e <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800427:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80042a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800431:	8b 45 08             	mov    0x8(%ebp),%eax
  800434:	01 c2                	add    %eax,%edx
  800436:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800439:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80043b:	ff 45 fc             	incl   -0x4(%ebp)
  80043e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800441:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800444:	7c e1                	jl     800427 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800446:	90                   	nop
  800447:	c9                   	leave  
  800448:	c3                   	ret    

00800449 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800449:	55                   	push   %ebp
  80044a:	89 e5                	mov    %esp,%ebp
  80044c:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80044f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800456:	eb 1b                	jmp    800473 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800458:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80045b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800462:	8b 45 08             	mov    0x8(%ebp),%eax
  800465:	01 c2                	add    %eax,%edx
  800467:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046a:	2b 45 fc             	sub    -0x4(%ebp),%eax
  80046d:	48                   	dec    %eax
  80046e:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800470:	ff 45 fc             	incl   -0x4(%ebp)
  800473:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800476:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800479:	7c dd                	jl     800458 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  80047b:	90                   	nop
  80047c:	c9                   	leave  
  80047d:	c3                   	ret    

0080047e <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80047e:	55                   	push   %ebp
  80047f:	89 e5                	mov    %esp,%ebp
  800481:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800484:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800487:	b8 56 55 55 55       	mov    $0x55555556,%eax
  80048c:	f7 e9                	imul   %ecx
  80048e:	c1 f9 1f             	sar    $0x1f,%ecx
  800491:	89 d0                	mov    %edx,%eax
  800493:	29 c8                	sub    %ecx,%eax
  800495:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800498:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80049f:	eb 1e                	jmp    8004bf <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ae:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004b4:	99                   	cltd   
  8004b5:	f7 7d f8             	idivl  -0x8(%ebp)
  8004b8:	89 d0                	mov    %edx,%eax
  8004ba:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004bc:	ff 45 fc             	incl   -0x4(%ebp)
  8004bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004c5:	7c da                	jl     8004a1 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004c7:	90                   	nop
  8004c8:	c9                   	leave  
  8004c9:	c3                   	ret    

008004ca <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004ca:	55                   	push   %ebp
  8004cb:	89 e5                	mov    %esp,%ebp
  8004cd:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8004d0:	e8 37 19 00 00       	call   801e0c <sys_disable_interrupt>
		int i ;
		int NumsPerLine = 20 ;
  8004d5:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8004dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004e3:	eb 42                	jmp    800527 <PrintElements+0x5d>
		{
			if (i%NumsPerLine == 0)
  8004e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004e8:	99                   	cltd   
  8004e9:	f7 7d f0             	idivl  -0x10(%ebp)
  8004ec:	89 d0                	mov    %edx,%eax
  8004ee:	85 c0                	test   %eax,%eax
  8004f0:	75 10                	jne    800502 <PrintElements+0x38>
				cprintf("\n");
  8004f2:	83 ec 0c             	sub    $0xc,%esp
  8004f5:	68 e6 25 80 00       	push   $0x8025e6
  8004fa:	e8 b1 04 00 00       	call   8009b0 <cprintf>
  8004ff:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  800502:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800505:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050c:	8b 45 08             	mov    0x8(%ebp),%eax
  80050f:	01 d0                	add    %edx,%eax
  800511:	8b 00                	mov    (%eax),%eax
  800513:	83 ec 08             	sub    $0x8,%esp
  800516:	50                   	push   %eax
  800517:	68 e8 25 80 00       	push   $0x8025e8
  80051c:	e8 8f 04 00 00       	call   8009b0 <cprintf>
  800521:	83 c4 10             	add    $0x10,%esp
void PrintElements(int *Elements, int NumOfElements)
{
	sys_disable_interrupt();
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  800524:	ff 45 f4             	incl   -0xc(%ebp)
  800527:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052a:	48                   	dec    %eax
  80052b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80052e:	7f b5                	jg     8004e5 <PrintElements+0x1b>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  800530:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800533:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80053a:	8b 45 08             	mov    0x8(%ebp),%eax
  80053d:	01 d0                	add    %edx,%eax
  80053f:	8b 00                	mov    (%eax),%eax
  800541:	83 ec 08             	sub    $0x8,%esp
  800544:	50                   	push   %eax
  800545:	68 ed 25 80 00       	push   $0x8025ed
  80054a:	e8 61 04 00 00       	call   8009b0 <cprintf>
  80054f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800552:	e8 cf 18 00 00       	call   801e26 <sys_enable_interrupt>
}
  800557:	90                   	nop
  800558:	c9                   	leave  
  800559:	c3                   	ret    

0080055a <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80055a:	55                   	push   %ebp
  80055b:	89 e5                	mov    %esp,%ebp
  80055d:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800560:	8b 45 08             	mov    0x8(%ebp),%eax
  800563:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800566:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80056a:	83 ec 0c             	sub    $0xc,%esp
  80056d:	50                   	push   %eax
  80056e:	e8 cd 18 00 00       	call   801e40 <sys_cputc>
  800573:	83 c4 10             	add    $0x10,%esp
}
  800576:	90                   	nop
  800577:	c9                   	leave  
  800578:	c3                   	ret    

00800579 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800579:	55                   	push   %ebp
  80057a:	89 e5                	mov    %esp,%ebp
  80057c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80057f:	e8 88 18 00 00       	call   801e0c <sys_disable_interrupt>
	char c = ch;
  800584:	8b 45 08             	mov    0x8(%ebp),%eax
  800587:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80058a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80058e:	83 ec 0c             	sub    $0xc,%esp
  800591:	50                   	push   %eax
  800592:	e8 a9 18 00 00       	call   801e40 <sys_cputc>
  800597:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80059a:	e8 87 18 00 00       	call   801e26 <sys_enable_interrupt>
}
  80059f:	90                   	nop
  8005a0:	c9                   	leave  
  8005a1:	c3                   	ret    

008005a2 <getchar>:

int
getchar(void)
{
  8005a2:	55                   	push   %ebp
  8005a3:	89 e5                	mov    %esp,%ebp
  8005a5:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005af:	eb 08                	jmp    8005b9 <getchar+0x17>
	{
		c = sys_cgetc();
  8005b1:	e8 6e 16 00 00       	call   801c24 <sys_cgetc>
  8005b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005bd:	74 f2                	je     8005b1 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005c2:	c9                   	leave  
  8005c3:	c3                   	ret    

008005c4 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005c4:	55                   	push   %ebp
  8005c5:	89 e5                	mov    %esp,%ebp
  8005c7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005ca:	e8 3d 18 00 00       	call   801e0c <sys_disable_interrupt>
	int c=0;
  8005cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005d6:	eb 08                	jmp    8005e0 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005d8:	e8 47 16 00 00       	call   801c24 <sys_cgetc>
  8005dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005e4:	74 f2                	je     8005d8 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005e6:	e8 3b 18 00 00       	call   801e26 <sys_enable_interrupt>
	return c;
  8005eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005ee:	c9                   	leave  
  8005ef:	c3                   	ret    

008005f0 <iscons>:

int iscons(int fdnum)
{
  8005f0:	55                   	push   %ebp
  8005f1:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005f3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005f8:	5d                   	pop    %ebp
  8005f9:	c3                   	ret    

008005fa <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005fa:	55                   	push   %ebp
  8005fb:	89 e5                	mov    %esp,%ebp
  8005fd:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800600:	e8 6c 16 00 00       	call   801c71 <sys_getenvindex>
  800605:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800608:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80060b:	89 d0                	mov    %edx,%eax
  80060d:	01 c0                	add    %eax,%eax
  80060f:	01 d0                	add    %edx,%eax
  800611:	c1 e0 02             	shl    $0x2,%eax
  800614:	01 d0                	add    %edx,%eax
  800616:	c1 e0 06             	shl    $0x6,%eax
  800619:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80061e:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800623:	a1 24 30 80 00       	mov    0x803024,%eax
  800628:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80062e:	84 c0                	test   %al,%al
  800630:	74 0f                	je     800641 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800632:	a1 24 30 80 00       	mov    0x803024,%eax
  800637:	05 f4 02 00 00       	add    $0x2f4,%eax
  80063c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800641:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800645:	7e 0a                	jle    800651 <libmain+0x57>
		binaryname = argv[0];
  800647:	8b 45 0c             	mov    0xc(%ebp),%eax
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800651:	83 ec 08             	sub    $0x8,%esp
  800654:	ff 75 0c             	pushl  0xc(%ebp)
  800657:	ff 75 08             	pushl  0x8(%ebp)
  80065a:	e8 d9 f9 ff ff       	call   800038 <_main>
  80065f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800662:	e8 a5 17 00 00       	call   801e0c <sys_disable_interrupt>
	cprintf("**************************************\n");
  800667:	83 ec 0c             	sub    $0xc,%esp
  80066a:	68 0c 26 80 00       	push   $0x80260c
  80066f:	e8 3c 03 00 00       	call   8009b0 <cprintf>
  800674:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800677:	a1 24 30 80 00       	mov    0x803024,%eax
  80067c:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800682:	a1 24 30 80 00       	mov    0x803024,%eax
  800687:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80068d:	83 ec 04             	sub    $0x4,%esp
  800690:	52                   	push   %edx
  800691:	50                   	push   %eax
  800692:	68 34 26 80 00       	push   $0x802634
  800697:	e8 14 03 00 00       	call   8009b0 <cprintf>
  80069c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80069f:	a1 24 30 80 00       	mov    0x803024,%eax
  8006a4:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8006aa:	83 ec 08             	sub    $0x8,%esp
  8006ad:	50                   	push   %eax
  8006ae:	68 59 26 80 00       	push   $0x802659
  8006b3:	e8 f8 02 00 00       	call   8009b0 <cprintf>
  8006b8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006bb:	83 ec 0c             	sub    $0xc,%esp
  8006be:	68 0c 26 80 00       	push   $0x80260c
  8006c3:	e8 e8 02 00 00       	call   8009b0 <cprintf>
  8006c8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006cb:	e8 56 17 00 00       	call   801e26 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006d0:	e8 19 00 00 00       	call   8006ee <exit>
}
  8006d5:	90                   	nop
  8006d6:	c9                   	leave  
  8006d7:	c3                   	ret    

008006d8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006d8:	55                   	push   %ebp
  8006d9:	89 e5                	mov    %esp,%ebp
  8006db:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006de:	83 ec 0c             	sub    $0xc,%esp
  8006e1:	6a 00                	push   $0x0
  8006e3:	e8 55 15 00 00       	call   801c3d <sys_env_destroy>
  8006e8:	83 c4 10             	add    $0x10,%esp
}
  8006eb:	90                   	nop
  8006ec:	c9                   	leave  
  8006ed:	c3                   	ret    

008006ee <exit>:

void
exit(void)
{
  8006ee:	55                   	push   %ebp
  8006ef:	89 e5                	mov    %esp,%ebp
  8006f1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006f4:	e8 aa 15 00 00       	call   801ca3 <sys_env_exit>
}
  8006f9:	90                   	nop
  8006fa:	c9                   	leave  
  8006fb:	c3                   	ret    

008006fc <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006fc:	55                   	push   %ebp
  8006fd:	89 e5                	mov    %esp,%ebp
  8006ff:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800702:	8d 45 10             	lea    0x10(%ebp),%eax
  800705:	83 c0 04             	add    $0x4,%eax
  800708:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80070b:	a1 34 30 80 00       	mov    0x803034,%eax
  800710:	85 c0                	test   %eax,%eax
  800712:	74 16                	je     80072a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800714:	a1 34 30 80 00       	mov    0x803034,%eax
  800719:	83 ec 08             	sub    $0x8,%esp
  80071c:	50                   	push   %eax
  80071d:	68 70 26 80 00       	push   $0x802670
  800722:	e8 89 02 00 00       	call   8009b0 <cprintf>
  800727:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80072a:	a1 00 30 80 00       	mov    0x803000,%eax
  80072f:	ff 75 0c             	pushl  0xc(%ebp)
  800732:	ff 75 08             	pushl  0x8(%ebp)
  800735:	50                   	push   %eax
  800736:	68 75 26 80 00       	push   $0x802675
  80073b:	e8 70 02 00 00       	call   8009b0 <cprintf>
  800740:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800743:	8b 45 10             	mov    0x10(%ebp),%eax
  800746:	83 ec 08             	sub    $0x8,%esp
  800749:	ff 75 f4             	pushl  -0xc(%ebp)
  80074c:	50                   	push   %eax
  80074d:	e8 f3 01 00 00       	call   800945 <vcprintf>
  800752:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800755:	83 ec 08             	sub    $0x8,%esp
  800758:	6a 00                	push   $0x0
  80075a:	68 91 26 80 00       	push   $0x802691
  80075f:	e8 e1 01 00 00       	call   800945 <vcprintf>
  800764:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800767:	e8 82 ff ff ff       	call   8006ee <exit>

	// should not return here
	while (1) ;
  80076c:	eb fe                	jmp    80076c <_panic+0x70>

0080076e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80076e:	55                   	push   %ebp
  80076f:	89 e5                	mov    %esp,%ebp
  800771:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800774:	a1 24 30 80 00       	mov    0x803024,%eax
  800779:	8b 50 74             	mov    0x74(%eax),%edx
  80077c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80077f:	39 c2                	cmp    %eax,%edx
  800781:	74 14                	je     800797 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800783:	83 ec 04             	sub    $0x4,%esp
  800786:	68 94 26 80 00       	push   $0x802694
  80078b:	6a 26                	push   $0x26
  80078d:	68 e0 26 80 00       	push   $0x8026e0
  800792:	e8 65 ff ff ff       	call   8006fc <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800797:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80079e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007a5:	e9 c2 00 00 00       	jmp    80086c <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8007aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007ad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b7:	01 d0                	add    %edx,%eax
  8007b9:	8b 00                	mov    (%eax),%eax
  8007bb:	85 c0                	test   %eax,%eax
  8007bd:	75 08                	jne    8007c7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007bf:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007c2:	e9 a2 00 00 00       	jmp    800869 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007c7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007ce:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007d5:	eb 69                	jmp    800840 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007d7:	a1 24 30 80 00       	mov    0x803024,%eax
  8007dc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007e2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007e5:	89 d0                	mov    %edx,%eax
  8007e7:	01 c0                	add    %eax,%eax
  8007e9:	01 d0                	add    %edx,%eax
  8007eb:	c1 e0 02             	shl    $0x2,%eax
  8007ee:	01 c8                	add    %ecx,%eax
  8007f0:	8a 40 04             	mov    0x4(%eax),%al
  8007f3:	84 c0                	test   %al,%al
  8007f5:	75 46                	jne    80083d <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007f7:	a1 24 30 80 00       	mov    0x803024,%eax
  8007fc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800802:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800805:	89 d0                	mov    %edx,%eax
  800807:	01 c0                	add    %eax,%eax
  800809:	01 d0                	add    %edx,%eax
  80080b:	c1 e0 02             	shl    $0x2,%eax
  80080e:	01 c8                	add    %ecx,%eax
  800810:	8b 00                	mov    (%eax),%eax
  800812:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800815:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800818:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80081d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80081f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800822:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800829:	8b 45 08             	mov    0x8(%ebp),%eax
  80082c:	01 c8                	add    %ecx,%eax
  80082e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800830:	39 c2                	cmp    %eax,%edx
  800832:	75 09                	jne    80083d <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800834:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80083b:	eb 12                	jmp    80084f <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80083d:	ff 45 e8             	incl   -0x18(%ebp)
  800840:	a1 24 30 80 00       	mov    0x803024,%eax
  800845:	8b 50 74             	mov    0x74(%eax),%edx
  800848:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80084b:	39 c2                	cmp    %eax,%edx
  80084d:	77 88                	ja     8007d7 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80084f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800853:	75 14                	jne    800869 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800855:	83 ec 04             	sub    $0x4,%esp
  800858:	68 ec 26 80 00       	push   $0x8026ec
  80085d:	6a 3a                	push   $0x3a
  80085f:	68 e0 26 80 00       	push   $0x8026e0
  800864:	e8 93 fe ff ff       	call   8006fc <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800869:	ff 45 f0             	incl   -0x10(%ebp)
  80086c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80086f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800872:	0f 8c 32 ff ff ff    	jl     8007aa <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800878:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80087f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800886:	eb 26                	jmp    8008ae <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800888:	a1 24 30 80 00       	mov    0x803024,%eax
  80088d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800893:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800896:	89 d0                	mov    %edx,%eax
  800898:	01 c0                	add    %eax,%eax
  80089a:	01 d0                	add    %edx,%eax
  80089c:	c1 e0 02             	shl    $0x2,%eax
  80089f:	01 c8                	add    %ecx,%eax
  8008a1:	8a 40 04             	mov    0x4(%eax),%al
  8008a4:	3c 01                	cmp    $0x1,%al
  8008a6:	75 03                	jne    8008ab <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8008a8:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ab:	ff 45 e0             	incl   -0x20(%ebp)
  8008ae:	a1 24 30 80 00       	mov    0x803024,%eax
  8008b3:	8b 50 74             	mov    0x74(%eax),%edx
  8008b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008b9:	39 c2                	cmp    %eax,%edx
  8008bb:	77 cb                	ja     800888 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008c0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008c3:	74 14                	je     8008d9 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008c5:	83 ec 04             	sub    $0x4,%esp
  8008c8:	68 40 27 80 00       	push   $0x802740
  8008cd:	6a 44                	push   $0x44
  8008cf:	68 e0 26 80 00       	push   $0x8026e0
  8008d4:	e8 23 fe ff ff       	call   8006fc <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008d9:	90                   	nop
  8008da:	c9                   	leave  
  8008db:	c3                   	ret    

008008dc <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008dc:	55                   	push   %ebp
  8008dd:	89 e5                	mov    %esp,%ebp
  8008df:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e5:	8b 00                	mov    (%eax),%eax
  8008e7:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ed:	89 0a                	mov    %ecx,(%edx)
  8008ef:	8b 55 08             	mov    0x8(%ebp),%edx
  8008f2:	88 d1                	mov    %dl,%cl
  8008f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fe:	8b 00                	mov    (%eax),%eax
  800900:	3d ff 00 00 00       	cmp    $0xff,%eax
  800905:	75 2c                	jne    800933 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800907:	a0 28 30 80 00       	mov    0x803028,%al
  80090c:	0f b6 c0             	movzbl %al,%eax
  80090f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800912:	8b 12                	mov    (%edx),%edx
  800914:	89 d1                	mov    %edx,%ecx
  800916:	8b 55 0c             	mov    0xc(%ebp),%edx
  800919:	83 c2 08             	add    $0x8,%edx
  80091c:	83 ec 04             	sub    $0x4,%esp
  80091f:	50                   	push   %eax
  800920:	51                   	push   %ecx
  800921:	52                   	push   %edx
  800922:	e8 d4 12 00 00       	call   801bfb <sys_cputs>
  800927:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80092a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800933:	8b 45 0c             	mov    0xc(%ebp),%eax
  800936:	8b 40 04             	mov    0x4(%eax),%eax
  800939:	8d 50 01             	lea    0x1(%eax),%edx
  80093c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800942:	90                   	nop
  800943:	c9                   	leave  
  800944:	c3                   	ret    

00800945 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800945:	55                   	push   %ebp
  800946:	89 e5                	mov    %esp,%ebp
  800948:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80094e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800955:	00 00 00 
	b.cnt = 0;
  800958:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80095f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800962:	ff 75 0c             	pushl  0xc(%ebp)
  800965:	ff 75 08             	pushl  0x8(%ebp)
  800968:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80096e:	50                   	push   %eax
  80096f:	68 dc 08 80 00       	push   $0x8008dc
  800974:	e8 11 02 00 00       	call   800b8a <vprintfmt>
  800979:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80097c:	a0 28 30 80 00       	mov    0x803028,%al
  800981:	0f b6 c0             	movzbl %al,%eax
  800984:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80098a:	83 ec 04             	sub    $0x4,%esp
  80098d:	50                   	push   %eax
  80098e:	52                   	push   %edx
  80098f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800995:	83 c0 08             	add    $0x8,%eax
  800998:	50                   	push   %eax
  800999:	e8 5d 12 00 00       	call   801bfb <sys_cputs>
  80099e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009a1:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009a8:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009ae:	c9                   	leave  
  8009af:	c3                   	ret    

008009b0 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009b0:	55                   	push   %ebp
  8009b1:	89 e5                	mov    %esp,%ebp
  8009b3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009b6:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009bd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c6:	83 ec 08             	sub    $0x8,%esp
  8009c9:	ff 75 f4             	pushl  -0xc(%ebp)
  8009cc:	50                   	push   %eax
  8009cd:	e8 73 ff ff ff       	call   800945 <vcprintf>
  8009d2:	83 c4 10             	add    $0x10,%esp
  8009d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009db:	c9                   	leave  
  8009dc:	c3                   	ret    

008009dd <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009dd:	55                   	push   %ebp
  8009de:	89 e5                	mov    %esp,%ebp
  8009e0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009e3:	e8 24 14 00 00       	call   801e0c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009e8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f1:	83 ec 08             	sub    $0x8,%esp
  8009f4:	ff 75 f4             	pushl  -0xc(%ebp)
  8009f7:	50                   	push   %eax
  8009f8:	e8 48 ff ff ff       	call   800945 <vcprintf>
  8009fd:	83 c4 10             	add    $0x10,%esp
  800a00:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a03:	e8 1e 14 00 00       	call   801e26 <sys_enable_interrupt>
	return cnt;
  800a08:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a0b:	c9                   	leave  
  800a0c:	c3                   	ret    

00800a0d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a0d:	55                   	push   %ebp
  800a0e:	89 e5                	mov    %esp,%ebp
  800a10:	53                   	push   %ebx
  800a11:	83 ec 14             	sub    $0x14,%esp
  800a14:	8b 45 10             	mov    0x10(%ebp),%eax
  800a17:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a1a:	8b 45 14             	mov    0x14(%ebp),%eax
  800a1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a20:	8b 45 18             	mov    0x18(%ebp),%eax
  800a23:	ba 00 00 00 00       	mov    $0x0,%edx
  800a28:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a2b:	77 55                	ja     800a82 <printnum+0x75>
  800a2d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a30:	72 05                	jb     800a37 <printnum+0x2a>
  800a32:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a35:	77 4b                	ja     800a82 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a37:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a3a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a3d:	8b 45 18             	mov    0x18(%ebp),%eax
  800a40:	ba 00 00 00 00       	mov    $0x0,%edx
  800a45:	52                   	push   %edx
  800a46:	50                   	push   %eax
  800a47:	ff 75 f4             	pushl  -0xc(%ebp)
  800a4a:	ff 75 f0             	pushl  -0x10(%ebp)
  800a4d:	e8 9a 17 00 00       	call   8021ec <__udivdi3>
  800a52:	83 c4 10             	add    $0x10,%esp
  800a55:	83 ec 04             	sub    $0x4,%esp
  800a58:	ff 75 20             	pushl  0x20(%ebp)
  800a5b:	53                   	push   %ebx
  800a5c:	ff 75 18             	pushl  0x18(%ebp)
  800a5f:	52                   	push   %edx
  800a60:	50                   	push   %eax
  800a61:	ff 75 0c             	pushl  0xc(%ebp)
  800a64:	ff 75 08             	pushl  0x8(%ebp)
  800a67:	e8 a1 ff ff ff       	call   800a0d <printnum>
  800a6c:	83 c4 20             	add    $0x20,%esp
  800a6f:	eb 1a                	jmp    800a8b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a71:	83 ec 08             	sub    $0x8,%esp
  800a74:	ff 75 0c             	pushl  0xc(%ebp)
  800a77:	ff 75 20             	pushl  0x20(%ebp)
  800a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7d:	ff d0                	call   *%eax
  800a7f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a82:	ff 4d 1c             	decl   0x1c(%ebp)
  800a85:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a89:	7f e6                	jg     800a71 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a8b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a8e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a96:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a99:	53                   	push   %ebx
  800a9a:	51                   	push   %ecx
  800a9b:	52                   	push   %edx
  800a9c:	50                   	push   %eax
  800a9d:	e8 5a 18 00 00       	call   8022fc <__umoddi3>
  800aa2:	83 c4 10             	add    $0x10,%esp
  800aa5:	05 b4 29 80 00       	add    $0x8029b4,%eax
  800aaa:	8a 00                	mov    (%eax),%al
  800aac:	0f be c0             	movsbl %al,%eax
  800aaf:	83 ec 08             	sub    $0x8,%esp
  800ab2:	ff 75 0c             	pushl  0xc(%ebp)
  800ab5:	50                   	push   %eax
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	ff d0                	call   *%eax
  800abb:	83 c4 10             	add    $0x10,%esp
}
  800abe:	90                   	nop
  800abf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ac2:	c9                   	leave  
  800ac3:	c3                   	ret    

00800ac4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ac4:	55                   	push   %ebp
  800ac5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ac7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800acb:	7e 1c                	jle    800ae9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800acd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad0:	8b 00                	mov    (%eax),%eax
  800ad2:	8d 50 08             	lea    0x8(%eax),%edx
  800ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad8:	89 10                	mov    %edx,(%eax)
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	8b 00                	mov    (%eax),%eax
  800adf:	83 e8 08             	sub    $0x8,%eax
  800ae2:	8b 50 04             	mov    0x4(%eax),%edx
  800ae5:	8b 00                	mov    (%eax),%eax
  800ae7:	eb 40                	jmp    800b29 <getuint+0x65>
	else if (lflag)
  800ae9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aed:	74 1e                	je     800b0d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800aef:	8b 45 08             	mov    0x8(%ebp),%eax
  800af2:	8b 00                	mov    (%eax),%eax
  800af4:	8d 50 04             	lea    0x4(%eax),%edx
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
  800afa:	89 10                	mov    %edx,(%eax)
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	8b 00                	mov    (%eax),%eax
  800b01:	83 e8 04             	sub    $0x4,%eax
  800b04:	8b 00                	mov    (%eax),%eax
  800b06:	ba 00 00 00 00       	mov    $0x0,%edx
  800b0b:	eb 1c                	jmp    800b29 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b10:	8b 00                	mov    (%eax),%eax
  800b12:	8d 50 04             	lea    0x4(%eax),%edx
  800b15:	8b 45 08             	mov    0x8(%ebp),%eax
  800b18:	89 10                	mov    %edx,(%eax)
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	8b 00                	mov    (%eax),%eax
  800b1f:	83 e8 04             	sub    $0x4,%eax
  800b22:	8b 00                	mov    (%eax),%eax
  800b24:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b29:	5d                   	pop    %ebp
  800b2a:	c3                   	ret    

00800b2b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b2b:	55                   	push   %ebp
  800b2c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b2e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b32:	7e 1c                	jle    800b50 <getint+0x25>
		return va_arg(*ap, long long);
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	8b 00                	mov    (%eax),%eax
  800b39:	8d 50 08             	lea    0x8(%eax),%edx
  800b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3f:	89 10                	mov    %edx,(%eax)
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
  800b44:	8b 00                	mov    (%eax),%eax
  800b46:	83 e8 08             	sub    $0x8,%eax
  800b49:	8b 50 04             	mov    0x4(%eax),%edx
  800b4c:	8b 00                	mov    (%eax),%eax
  800b4e:	eb 38                	jmp    800b88 <getint+0x5d>
	else if (lflag)
  800b50:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b54:	74 1a                	je     800b70 <getint+0x45>
		return va_arg(*ap, long);
  800b56:	8b 45 08             	mov    0x8(%ebp),%eax
  800b59:	8b 00                	mov    (%eax),%eax
  800b5b:	8d 50 04             	lea    0x4(%eax),%edx
  800b5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b61:	89 10                	mov    %edx,(%eax)
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	8b 00                	mov    (%eax),%eax
  800b68:	83 e8 04             	sub    $0x4,%eax
  800b6b:	8b 00                	mov    (%eax),%eax
  800b6d:	99                   	cltd   
  800b6e:	eb 18                	jmp    800b88 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b70:	8b 45 08             	mov    0x8(%ebp),%eax
  800b73:	8b 00                	mov    (%eax),%eax
  800b75:	8d 50 04             	lea    0x4(%eax),%edx
  800b78:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7b:	89 10                	mov    %edx,(%eax)
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	8b 00                	mov    (%eax),%eax
  800b82:	83 e8 04             	sub    $0x4,%eax
  800b85:	8b 00                	mov    (%eax),%eax
  800b87:	99                   	cltd   
}
  800b88:	5d                   	pop    %ebp
  800b89:	c3                   	ret    

00800b8a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b8a:	55                   	push   %ebp
  800b8b:	89 e5                	mov    %esp,%ebp
  800b8d:	56                   	push   %esi
  800b8e:	53                   	push   %ebx
  800b8f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b92:	eb 17                	jmp    800bab <vprintfmt+0x21>
			if (ch == '\0')
  800b94:	85 db                	test   %ebx,%ebx
  800b96:	0f 84 af 03 00 00    	je     800f4b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b9c:	83 ec 08             	sub    $0x8,%esp
  800b9f:	ff 75 0c             	pushl  0xc(%ebp)
  800ba2:	53                   	push   %ebx
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	ff d0                	call   *%eax
  800ba8:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bab:	8b 45 10             	mov    0x10(%ebp),%eax
  800bae:	8d 50 01             	lea    0x1(%eax),%edx
  800bb1:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb4:	8a 00                	mov    (%eax),%al
  800bb6:	0f b6 d8             	movzbl %al,%ebx
  800bb9:	83 fb 25             	cmp    $0x25,%ebx
  800bbc:	75 d6                	jne    800b94 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bbe:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bc2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bc9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bd0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bd7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bde:	8b 45 10             	mov    0x10(%ebp),%eax
  800be1:	8d 50 01             	lea    0x1(%eax),%edx
  800be4:	89 55 10             	mov    %edx,0x10(%ebp)
  800be7:	8a 00                	mov    (%eax),%al
  800be9:	0f b6 d8             	movzbl %al,%ebx
  800bec:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bef:	83 f8 55             	cmp    $0x55,%eax
  800bf2:	0f 87 2b 03 00 00    	ja     800f23 <vprintfmt+0x399>
  800bf8:	8b 04 85 d8 29 80 00 	mov    0x8029d8(,%eax,4),%eax
  800bff:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c01:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c05:	eb d7                	jmp    800bde <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c07:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c0b:	eb d1                	jmp    800bde <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c0d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c14:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c17:	89 d0                	mov    %edx,%eax
  800c19:	c1 e0 02             	shl    $0x2,%eax
  800c1c:	01 d0                	add    %edx,%eax
  800c1e:	01 c0                	add    %eax,%eax
  800c20:	01 d8                	add    %ebx,%eax
  800c22:	83 e8 30             	sub    $0x30,%eax
  800c25:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c28:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2b:	8a 00                	mov    (%eax),%al
  800c2d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c30:	83 fb 2f             	cmp    $0x2f,%ebx
  800c33:	7e 3e                	jle    800c73 <vprintfmt+0xe9>
  800c35:	83 fb 39             	cmp    $0x39,%ebx
  800c38:	7f 39                	jg     800c73 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c3a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c3d:	eb d5                	jmp    800c14 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c3f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c42:	83 c0 04             	add    $0x4,%eax
  800c45:	89 45 14             	mov    %eax,0x14(%ebp)
  800c48:	8b 45 14             	mov    0x14(%ebp),%eax
  800c4b:	83 e8 04             	sub    $0x4,%eax
  800c4e:	8b 00                	mov    (%eax),%eax
  800c50:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c53:	eb 1f                	jmp    800c74 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c55:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c59:	79 83                	jns    800bde <vprintfmt+0x54>
				width = 0;
  800c5b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c62:	e9 77 ff ff ff       	jmp    800bde <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c67:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c6e:	e9 6b ff ff ff       	jmp    800bde <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c73:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c74:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c78:	0f 89 60 ff ff ff    	jns    800bde <vprintfmt+0x54>
				width = precision, precision = -1;
  800c7e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c81:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c84:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c8b:	e9 4e ff ff ff       	jmp    800bde <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c90:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c93:	e9 46 ff ff ff       	jmp    800bde <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c98:	8b 45 14             	mov    0x14(%ebp),%eax
  800c9b:	83 c0 04             	add    $0x4,%eax
  800c9e:	89 45 14             	mov    %eax,0x14(%ebp)
  800ca1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca4:	83 e8 04             	sub    $0x4,%eax
  800ca7:	8b 00                	mov    (%eax),%eax
  800ca9:	83 ec 08             	sub    $0x8,%esp
  800cac:	ff 75 0c             	pushl  0xc(%ebp)
  800caf:	50                   	push   %eax
  800cb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb3:	ff d0                	call   *%eax
  800cb5:	83 c4 10             	add    $0x10,%esp
			break;
  800cb8:	e9 89 02 00 00       	jmp    800f46 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cbd:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc0:	83 c0 04             	add    $0x4,%eax
  800cc3:	89 45 14             	mov    %eax,0x14(%ebp)
  800cc6:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc9:	83 e8 04             	sub    $0x4,%eax
  800ccc:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cce:	85 db                	test   %ebx,%ebx
  800cd0:	79 02                	jns    800cd4 <vprintfmt+0x14a>
				err = -err;
  800cd2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cd4:	83 fb 64             	cmp    $0x64,%ebx
  800cd7:	7f 0b                	jg     800ce4 <vprintfmt+0x15a>
  800cd9:	8b 34 9d 20 28 80 00 	mov    0x802820(,%ebx,4),%esi
  800ce0:	85 f6                	test   %esi,%esi
  800ce2:	75 19                	jne    800cfd <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ce4:	53                   	push   %ebx
  800ce5:	68 c5 29 80 00       	push   $0x8029c5
  800cea:	ff 75 0c             	pushl  0xc(%ebp)
  800ced:	ff 75 08             	pushl  0x8(%ebp)
  800cf0:	e8 5e 02 00 00       	call   800f53 <printfmt>
  800cf5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cf8:	e9 49 02 00 00       	jmp    800f46 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cfd:	56                   	push   %esi
  800cfe:	68 ce 29 80 00       	push   $0x8029ce
  800d03:	ff 75 0c             	pushl  0xc(%ebp)
  800d06:	ff 75 08             	pushl  0x8(%ebp)
  800d09:	e8 45 02 00 00       	call   800f53 <printfmt>
  800d0e:	83 c4 10             	add    $0x10,%esp
			break;
  800d11:	e9 30 02 00 00       	jmp    800f46 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d16:	8b 45 14             	mov    0x14(%ebp),%eax
  800d19:	83 c0 04             	add    $0x4,%eax
  800d1c:	89 45 14             	mov    %eax,0x14(%ebp)
  800d1f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d22:	83 e8 04             	sub    $0x4,%eax
  800d25:	8b 30                	mov    (%eax),%esi
  800d27:	85 f6                	test   %esi,%esi
  800d29:	75 05                	jne    800d30 <vprintfmt+0x1a6>
				p = "(null)";
  800d2b:	be d1 29 80 00       	mov    $0x8029d1,%esi
			if (width > 0 && padc != '-')
  800d30:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d34:	7e 6d                	jle    800da3 <vprintfmt+0x219>
  800d36:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d3a:	74 67                	je     800da3 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d3c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d3f:	83 ec 08             	sub    $0x8,%esp
  800d42:	50                   	push   %eax
  800d43:	56                   	push   %esi
  800d44:	e8 12 05 00 00       	call   80125b <strnlen>
  800d49:	83 c4 10             	add    $0x10,%esp
  800d4c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d4f:	eb 16                	jmp    800d67 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d51:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d55:	83 ec 08             	sub    $0x8,%esp
  800d58:	ff 75 0c             	pushl  0xc(%ebp)
  800d5b:	50                   	push   %eax
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	ff d0                	call   *%eax
  800d61:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d64:	ff 4d e4             	decl   -0x1c(%ebp)
  800d67:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d6b:	7f e4                	jg     800d51 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d6d:	eb 34                	jmp    800da3 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d6f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d73:	74 1c                	je     800d91 <vprintfmt+0x207>
  800d75:	83 fb 1f             	cmp    $0x1f,%ebx
  800d78:	7e 05                	jle    800d7f <vprintfmt+0x1f5>
  800d7a:	83 fb 7e             	cmp    $0x7e,%ebx
  800d7d:	7e 12                	jle    800d91 <vprintfmt+0x207>
					putch('?', putdat);
  800d7f:	83 ec 08             	sub    $0x8,%esp
  800d82:	ff 75 0c             	pushl  0xc(%ebp)
  800d85:	6a 3f                	push   $0x3f
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	ff d0                	call   *%eax
  800d8c:	83 c4 10             	add    $0x10,%esp
  800d8f:	eb 0f                	jmp    800da0 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d91:	83 ec 08             	sub    $0x8,%esp
  800d94:	ff 75 0c             	pushl  0xc(%ebp)
  800d97:	53                   	push   %ebx
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	ff d0                	call   *%eax
  800d9d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800da0:	ff 4d e4             	decl   -0x1c(%ebp)
  800da3:	89 f0                	mov    %esi,%eax
  800da5:	8d 70 01             	lea    0x1(%eax),%esi
  800da8:	8a 00                	mov    (%eax),%al
  800daa:	0f be d8             	movsbl %al,%ebx
  800dad:	85 db                	test   %ebx,%ebx
  800daf:	74 24                	je     800dd5 <vprintfmt+0x24b>
  800db1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800db5:	78 b8                	js     800d6f <vprintfmt+0x1e5>
  800db7:	ff 4d e0             	decl   -0x20(%ebp)
  800dba:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dbe:	79 af                	jns    800d6f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dc0:	eb 13                	jmp    800dd5 <vprintfmt+0x24b>
				putch(' ', putdat);
  800dc2:	83 ec 08             	sub    $0x8,%esp
  800dc5:	ff 75 0c             	pushl  0xc(%ebp)
  800dc8:	6a 20                	push   $0x20
  800dca:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcd:	ff d0                	call   *%eax
  800dcf:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dd2:	ff 4d e4             	decl   -0x1c(%ebp)
  800dd5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dd9:	7f e7                	jg     800dc2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ddb:	e9 66 01 00 00       	jmp    800f46 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800de0:	83 ec 08             	sub    $0x8,%esp
  800de3:	ff 75 e8             	pushl  -0x18(%ebp)
  800de6:	8d 45 14             	lea    0x14(%ebp),%eax
  800de9:	50                   	push   %eax
  800dea:	e8 3c fd ff ff       	call   800b2b <getint>
  800def:	83 c4 10             	add    $0x10,%esp
  800df2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800df5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800df8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dfb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dfe:	85 d2                	test   %edx,%edx
  800e00:	79 23                	jns    800e25 <vprintfmt+0x29b>
				putch('-', putdat);
  800e02:	83 ec 08             	sub    $0x8,%esp
  800e05:	ff 75 0c             	pushl  0xc(%ebp)
  800e08:	6a 2d                	push   $0x2d
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0d:	ff d0                	call   *%eax
  800e0f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e12:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e15:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e18:	f7 d8                	neg    %eax
  800e1a:	83 d2 00             	adc    $0x0,%edx
  800e1d:	f7 da                	neg    %edx
  800e1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e22:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e25:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e2c:	e9 bc 00 00 00       	jmp    800eed <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e31:	83 ec 08             	sub    $0x8,%esp
  800e34:	ff 75 e8             	pushl  -0x18(%ebp)
  800e37:	8d 45 14             	lea    0x14(%ebp),%eax
  800e3a:	50                   	push   %eax
  800e3b:	e8 84 fc ff ff       	call   800ac4 <getuint>
  800e40:	83 c4 10             	add    $0x10,%esp
  800e43:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e46:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e49:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e50:	e9 98 00 00 00       	jmp    800eed <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e55:	83 ec 08             	sub    $0x8,%esp
  800e58:	ff 75 0c             	pushl  0xc(%ebp)
  800e5b:	6a 58                	push   $0x58
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	ff d0                	call   *%eax
  800e62:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e65:	83 ec 08             	sub    $0x8,%esp
  800e68:	ff 75 0c             	pushl  0xc(%ebp)
  800e6b:	6a 58                	push   $0x58
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	ff d0                	call   *%eax
  800e72:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e75:	83 ec 08             	sub    $0x8,%esp
  800e78:	ff 75 0c             	pushl  0xc(%ebp)
  800e7b:	6a 58                	push   $0x58
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e80:	ff d0                	call   *%eax
  800e82:	83 c4 10             	add    $0x10,%esp
			break;
  800e85:	e9 bc 00 00 00       	jmp    800f46 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e8a:	83 ec 08             	sub    $0x8,%esp
  800e8d:	ff 75 0c             	pushl  0xc(%ebp)
  800e90:	6a 30                	push   $0x30
  800e92:	8b 45 08             	mov    0x8(%ebp),%eax
  800e95:	ff d0                	call   *%eax
  800e97:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e9a:	83 ec 08             	sub    $0x8,%esp
  800e9d:	ff 75 0c             	pushl  0xc(%ebp)
  800ea0:	6a 78                	push   $0x78
  800ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea5:	ff d0                	call   *%eax
  800ea7:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800eaa:	8b 45 14             	mov    0x14(%ebp),%eax
  800ead:	83 c0 04             	add    $0x4,%eax
  800eb0:	89 45 14             	mov    %eax,0x14(%ebp)
  800eb3:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb6:	83 e8 04             	sub    $0x4,%eax
  800eb9:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ebb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ebe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ec5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ecc:	eb 1f                	jmp    800eed <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ece:	83 ec 08             	sub    $0x8,%esp
  800ed1:	ff 75 e8             	pushl  -0x18(%ebp)
  800ed4:	8d 45 14             	lea    0x14(%ebp),%eax
  800ed7:	50                   	push   %eax
  800ed8:	e8 e7 fb ff ff       	call   800ac4 <getuint>
  800edd:	83 c4 10             	add    $0x10,%esp
  800ee0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ee3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ee6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800eed:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ef1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ef4:	83 ec 04             	sub    $0x4,%esp
  800ef7:	52                   	push   %edx
  800ef8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800efb:	50                   	push   %eax
  800efc:	ff 75 f4             	pushl  -0xc(%ebp)
  800eff:	ff 75 f0             	pushl  -0x10(%ebp)
  800f02:	ff 75 0c             	pushl  0xc(%ebp)
  800f05:	ff 75 08             	pushl  0x8(%ebp)
  800f08:	e8 00 fb ff ff       	call   800a0d <printnum>
  800f0d:	83 c4 20             	add    $0x20,%esp
			break;
  800f10:	eb 34                	jmp    800f46 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f12:	83 ec 08             	sub    $0x8,%esp
  800f15:	ff 75 0c             	pushl  0xc(%ebp)
  800f18:	53                   	push   %ebx
  800f19:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1c:	ff d0                	call   *%eax
  800f1e:	83 c4 10             	add    $0x10,%esp
			break;
  800f21:	eb 23                	jmp    800f46 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f23:	83 ec 08             	sub    $0x8,%esp
  800f26:	ff 75 0c             	pushl  0xc(%ebp)
  800f29:	6a 25                	push   $0x25
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	ff d0                	call   *%eax
  800f30:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f33:	ff 4d 10             	decl   0x10(%ebp)
  800f36:	eb 03                	jmp    800f3b <vprintfmt+0x3b1>
  800f38:	ff 4d 10             	decl   0x10(%ebp)
  800f3b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3e:	48                   	dec    %eax
  800f3f:	8a 00                	mov    (%eax),%al
  800f41:	3c 25                	cmp    $0x25,%al
  800f43:	75 f3                	jne    800f38 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f45:	90                   	nop
		}
	}
  800f46:	e9 47 fc ff ff       	jmp    800b92 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f4b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f4c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f4f:	5b                   	pop    %ebx
  800f50:	5e                   	pop    %esi
  800f51:	5d                   	pop    %ebp
  800f52:	c3                   	ret    

00800f53 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f53:	55                   	push   %ebp
  800f54:	89 e5                	mov    %esp,%ebp
  800f56:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f59:	8d 45 10             	lea    0x10(%ebp),%eax
  800f5c:	83 c0 04             	add    $0x4,%eax
  800f5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f62:	8b 45 10             	mov    0x10(%ebp),%eax
  800f65:	ff 75 f4             	pushl  -0xc(%ebp)
  800f68:	50                   	push   %eax
  800f69:	ff 75 0c             	pushl  0xc(%ebp)
  800f6c:	ff 75 08             	pushl  0x8(%ebp)
  800f6f:	e8 16 fc ff ff       	call   800b8a <vprintfmt>
  800f74:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f77:	90                   	nop
  800f78:	c9                   	leave  
  800f79:	c3                   	ret    

00800f7a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f7a:	55                   	push   %ebp
  800f7b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f80:	8b 40 08             	mov    0x8(%eax),%eax
  800f83:	8d 50 01             	lea    0x1(%eax),%edx
  800f86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f89:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8f:	8b 10                	mov    (%eax),%edx
  800f91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f94:	8b 40 04             	mov    0x4(%eax),%eax
  800f97:	39 c2                	cmp    %eax,%edx
  800f99:	73 12                	jae    800fad <sprintputch+0x33>
		*b->buf++ = ch;
  800f9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9e:	8b 00                	mov    (%eax),%eax
  800fa0:	8d 48 01             	lea    0x1(%eax),%ecx
  800fa3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fa6:	89 0a                	mov    %ecx,(%edx)
  800fa8:	8b 55 08             	mov    0x8(%ebp),%edx
  800fab:	88 10                	mov    %dl,(%eax)
}
  800fad:	90                   	nop
  800fae:	5d                   	pop    %ebp
  800faf:	c3                   	ret    

00800fb0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fb0:	55                   	push   %ebp
  800fb1:	89 e5                	mov    %esp,%ebp
  800fb3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc5:	01 d0                	add    %edx,%eax
  800fc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fd1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fd5:	74 06                	je     800fdd <vsnprintf+0x2d>
  800fd7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fdb:	7f 07                	jg     800fe4 <vsnprintf+0x34>
		return -E_INVAL;
  800fdd:	b8 03 00 00 00       	mov    $0x3,%eax
  800fe2:	eb 20                	jmp    801004 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fe4:	ff 75 14             	pushl  0x14(%ebp)
  800fe7:	ff 75 10             	pushl  0x10(%ebp)
  800fea:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fed:	50                   	push   %eax
  800fee:	68 7a 0f 80 00       	push   $0x800f7a
  800ff3:	e8 92 fb ff ff       	call   800b8a <vprintfmt>
  800ff8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ffb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ffe:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801001:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801004:	c9                   	leave  
  801005:	c3                   	ret    

00801006 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801006:	55                   	push   %ebp
  801007:	89 e5                	mov    %esp,%ebp
  801009:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80100c:	8d 45 10             	lea    0x10(%ebp),%eax
  80100f:	83 c0 04             	add    $0x4,%eax
  801012:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801015:	8b 45 10             	mov    0x10(%ebp),%eax
  801018:	ff 75 f4             	pushl  -0xc(%ebp)
  80101b:	50                   	push   %eax
  80101c:	ff 75 0c             	pushl  0xc(%ebp)
  80101f:	ff 75 08             	pushl  0x8(%ebp)
  801022:	e8 89 ff ff ff       	call   800fb0 <vsnprintf>
  801027:	83 c4 10             	add    $0x10,%esp
  80102a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80102d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801030:	c9                   	leave  
  801031:	c3                   	ret    

00801032 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801032:	55                   	push   %ebp
  801033:	89 e5                	mov    %esp,%ebp
  801035:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801038:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80103c:	74 13                	je     801051 <readline+0x1f>
		cprintf("%s", prompt);
  80103e:	83 ec 08             	sub    $0x8,%esp
  801041:	ff 75 08             	pushl  0x8(%ebp)
  801044:	68 30 2b 80 00       	push   $0x802b30
  801049:	e8 62 f9 ff ff       	call   8009b0 <cprintf>
  80104e:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801051:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801058:	83 ec 0c             	sub    $0xc,%esp
  80105b:	6a 00                	push   $0x0
  80105d:	e8 8e f5 ff ff       	call   8005f0 <iscons>
  801062:	83 c4 10             	add    $0x10,%esp
  801065:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801068:	e8 35 f5 ff ff       	call   8005a2 <getchar>
  80106d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801070:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801074:	79 22                	jns    801098 <readline+0x66>
			if (c != -E_EOF)
  801076:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80107a:	0f 84 ad 00 00 00    	je     80112d <readline+0xfb>
				cprintf("read error: %e\n", c);
  801080:	83 ec 08             	sub    $0x8,%esp
  801083:	ff 75 ec             	pushl  -0x14(%ebp)
  801086:	68 33 2b 80 00       	push   $0x802b33
  80108b:	e8 20 f9 ff ff       	call   8009b0 <cprintf>
  801090:	83 c4 10             	add    $0x10,%esp
			return;
  801093:	e9 95 00 00 00       	jmp    80112d <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801098:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80109c:	7e 34                	jle    8010d2 <readline+0xa0>
  80109e:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010a5:	7f 2b                	jg     8010d2 <readline+0xa0>
			if (echoing)
  8010a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010ab:	74 0e                	je     8010bb <readline+0x89>
				cputchar(c);
  8010ad:	83 ec 0c             	sub    $0xc,%esp
  8010b0:	ff 75 ec             	pushl  -0x14(%ebp)
  8010b3:	e8 a2 f4 ff ff       	call   80055a <cputchar>
  8010b8:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010be:	8d 50 01             	lea    0x1(%eax),%edx
  8010c1:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010c4:	89 c2                	mov    %eax,%edx
  8010c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c9:	01 d0                	add    %edx,%eax
  8010cb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010ce:	88 10                	mov    %dl,(%eax)
  8010d0:	eb 56                	jmp    801128 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010d2:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010d6:	75 1f                	jne    8010f7 <readline+0xc5>
  8010d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010dc:	7e 19                	jle    8010f7 <readline+0xc5>
			if (echoing)
  8010de:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010e2:	74 0e                	je     8010f2 <readline+0xc0>
				cputchar(c);
  8010e4:	83 ec 0c             	sub    $0xc,%esp
  8010e7:	ff 75 ec             	pushl  -0x14(%ebp)
  8010ea:	e8 6b f4 ff ff       	call   80055a <cputchar>
  8010ef:	83 c4 10             	add    $0x10,%esp

			i--;
  8010f2:	ff 4d f4             	decl   -0xc(%ebp)
  8010f5:	eb 31                	jmp    801128 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8010f7:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8010fb:	74 0a                	je     801107 <readline+0xd5>
  8010fd:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801101:	0f 85 61 ff ff ff    	jne    801068 <readline+0x36>
			if (echoing)
  801107:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80110b:	74 0e                	je     80111b <readline+0xe9>
				cputchar(c);
  80110d:	83 ec 0c             	sub    $0xc,%esp
  801110:	ff 75 ec             	pushl  -0x14(%ebp)
  801113:	e8 42 f4 ff ff       	call   80055a <cputchar>
  801118:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80111b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80111e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801121:	01 d0                	add    %edx,%eax
  801123:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801126:	eb 06                	jmp    80112e <readline+0xfc>
		}
	}
  801128:	e9 3b ff ff ff       	jmp    801068 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  80112d:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80112e:	c9                   	leave  
  80112f:	c3                   	ret    

00801130 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801130:	55                   	push   %ebp
  801131:	89 e5                	mov    %esp,%ebp
  801133:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801136:	e8 d1 0c 00 00       	call   801e0c <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80113b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80113f:	74 13                	je     801154 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801141:	83 ec 08             	sub    $0x8,%esp
  801144:	ff 75 08             	pushl  0x8(%ebp)
  801147:	68 30 2b 80 00       	push   $0x802b30
  80114c:	e8 5f f8 ff ff       	call   8009b0 <cprintf>
  801151:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801154:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80115b:	83 ec 0c             	sub    $0xc,%esp
  80115e:	6a 00                	push   $0x0
  801160:	e8 8b f4 ff ff       	call   8005f0 <iscons>
  801165:	83 c4 10             	add    $0x10,%esp
  801168:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80116b:	e8 32 f4 ff ff       	call   8005a2 <getchar>
  801170:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801173:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801177:	79 23                	jns    80119c <atomic_readline+0x6c>
			if (c != -E_EOF)
  801179:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80117d:	74 13                	je     801192 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80117f:	83 ec 08             	sub    $0x8,%esp
  801182:	ff 75 ec             	pushl  -0x14(%ebp)
  801185:	68 33 2b 80 00       	push   $0x802b33
  80118a:	e8 21 f8 ff ff       	call   8009b0 <cprintf>
  80118f:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801192:	e8 8f 0c 00 00       	call   801e26 <sys_enable_interrupt>
			return;
  801197:	e9 9a 00 00 00       	jmp    801236 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80119c:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011a0:	7e 34                	jle    8011d6 <atomic_readline+0xa6>
  8011a2:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011a9:	7f 2b                	jg     8011d6 <atomic_readline+0xa6>
			if (echoing)
  8011ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011af:	74 0e                	je     8011bf <atomic_readline+0x8f>
				cputchar(c);
  8011b1:	83 ec 0c             	sub    $0xc,%esp
  8011b4:	ff 75 ec             	pushl  -0x14(%ebp)
  8011b7:	e8 9e f3 ff ff       	call   80055a <cputchar>
  8011bc:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011c2:	8d 50 01             	lea    0x1(%eax),%edx
  8011c5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011c8:	89 c2                	mov    %eax,%edx
  8011ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cd:	01 d0                	add    %edx,%eax
  8011cf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011d2:	88 10                	mov    %dl,(%eax)
  8011d4:	eb 5b                	jmp    801231 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011d6:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011da:	75 1f                	jne    8011fb <atomic_readline+0xcb>
  8011dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011e0:	7e 19                	jle    8011fb <atomic_readline+0xcb>
			if (echoing)
  8011e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011e6:	74 0e                	je     8011f6 <atomic_readline+0xc6>
				cputchar(c);
  8011e8:	83 ec 0c             	sub    $0xc,%esp
  8011eb:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ee:	e8 67 f3 ff ff       	call   80055a <cputchar>
  8011f3:	83 c4 10             	add    $0x10,%esp
			i--;
  8011f6:	ff 4d f4             	decl   -0xc(%ebp)
  8011f9:	eb 36                	jmp    801231 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8011fb:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011ff:	74 0a                	je     80120b <atomic_readline+0xdb>
  801201:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801205:	0f 85 60 ff ff ff    	jne    80116b <atomic_readline+0x3b>
			if (echoing)
  80120b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80120f:	74 0e                	je     80121f <atomic_readline+0xef>
				cputchar(c);
  801211:	83 ec 0c             	sub    $0xc,%esp
  801214:	ff 75 ec             	pushl  -0x14(%ebp)
  801217:	e8 3e f3 ff ff       	call   80055a <cputchar>
  80121c:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  80121f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801222:	8b 45 0c             	mov    0xc(%ebp),%eax
  801225:	01 d0                	add    %edx,%eax
  801227:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80122a:	e8 f7 0b 00 00       	call   801e26 <sys_enable_interrupt>
			return;
  80122f:	eb 05                	jmp    801236 <atomic_readline+0x106>
		}
	}
  801231:	e9 35 ff ff ff       	jmp    80116b <atomic_readline+0x3b>
}
  801236:	c9                   	leave  
  801237:	c3                   	ret    

00801238 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801238:	55                   	push   %ebp
  801239:	89 e5                	mov    %esp,%ebp
  80123b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80123e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801245:	eb 06                	jmp    80124d <strlen+0x15>
		n++;
  801247:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80124a:	ff 45 08             	incl   0x8(%ebp)
  80124d:	8b 45 08             	mov    0x8(%ebp),%eax
  801250:	8a 00                	mov    (%eax),%al
  801252:	84 c0                	test   %al,%al
  801254:	75 f1                	jne    801247 <strlen+0xf>
		n++;
	return n;
  801256:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801259:	c9                   	leave  
  80125a:	c3                   	ret    

0080125b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80125b:	55                   	push   %ebp
  80125c:	89 e5                	mov    %esp,%ebp
  80125e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801261:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801268:	eb 09                	jmp    801273 <strnlen+0x18>
		n++;
  80126a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80126d:	ff 45 08             	incl   0x8(%ebp)
  801270:	ff 4d 0c             	decl   0xc(%ebp)
  801273:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801277:	74 09                	je     801282 <strnlen+0x27>
  801279:	8b 45 08             	mov    0x8(%ebp),%eax
  80127c:	8a 00                	mov    (%eax),%al
  80127e:	84 c0                	test   %al,%al
  801280:	75 e8                	jne    80126a <strnlen+0xf>
		n++;
	return n;
  801282:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801285:	c9                   	leave  
  801286:	c3                   	ret    

00801287 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801287:	55                   	push   %ebp
  801288:	89 e5                	mov    %esp,%ebp
  80128a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80128d:	8b 45 08             	mov    0x8(%ebp),%eax
  801290:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801293:	90                   	nop
  801294:	8b 45 08             	mov    0x8(%ebp),%eax
  801297:	8d 50 01             	lea    0x1(%eax),%edx
  80129a:	89 55 08             	mov    %edx,0x8(%ebp)
  80129d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012a3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012a6:	8a 12                	mov    (%edx),%dl
  8012a8:	88 10                	mov    %dl,(%eax)
  8012aa:	8a 00                	mov    (%eax),%al
  8012ac:	84 c0                	test   %al,%al
  8012ae:	75 e4                	jne    801294 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012b3:	c9                   	leave  
  8012b4:	c3                   	ret    

008012b5 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012b5:	55                   	push   %ebp
  8012b6:	89 e5                	mov    %esp,%ebp
  8012b8:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012be:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012c8:	eb 1f                	jmp    8012e9 <strncpy+0x34>
		*dst++ = *src;
  8012ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cd:	8d 50 01             	lea    0x1(%eax),%edx
  8012d0:	89 55 08             	mov    %edx,0x8(%ebp)
  8012d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012d6:	8a 12                	mov    (%edx),%dl
  8012d8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012dd:	8a 00                	mov    (%eax),%al
  8012df:	84 c0                	test   %al,%al
  8012e1:	74 03                	je     8012e6 <strncpy+0x31>
			src++;
  8012e3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012e6:	ff 45 fc             	incl   -0x4(%ebp)
  8012e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ec:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012ef:	72 d9                	jb     8012ca <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012f4:	c9                   	leave  
  8012f5:	c3                   	ret    

008012f6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012f6:	55                   	push   %ebp
  8012f7:	89 e5                	mov    %esp,%ebp
  8012f9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801302:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801306:	74 30                	je     801338 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801308:	eb 16                	jmp    801320 <strlcpy+0x2a>
			*dst++ = *src++;
  80130a:	8b 45 08             	mov    0x8(%ebp),%eax
  80130d:	8d 50 01             	lea    0x1(%eax),%edx
  801310:	89 55 08             	mov    %edx,0x8(%ebp)
  801313:	8b 55 0c             	mov    0xc(%ebp),%edx
  801316:	8d 4a 01             	lea    0x1(%edx),%ecx
  801319:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80131c:	8a 12                	mov    (%edx),%dl
  80131e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801320:	ff 4d 10             	decl   0x10(%ebp)
  801323:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801327:	74 09                	je     801332 <strlcpy+0x3c>
  801329:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132c:	8a 00                	mov    (%eax),%al
  80132e:	84 c0                	test   %al,%al
  801330:	75 d8                	jne    80130a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801332:	8b 45 08             	mov    0x8(%ebp),%eax
  801335:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801338:	8b 55 08             	mov    0x8(%ebp),%edx
  80133b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80133e:	29 c2                	sub    %eax,%edx
  801340:	89 d0                	mov    %edx,%eax
}
  801342:	c9                   	leave  
  801343:	c3                   	ret    

00801344 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801344:	55                   	push   %ebp
  801345:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801347:	eb 06                	jmp    80134f <strcmp+0xb>
		p++, q++;
  801349:	ff 45 08             	incl   0x8(%ebp)
  80134c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	8a 00                	mov    (%eax),%al
  801354:	84 c0                	test   %al,%al
  801356:	74 0e                	je     801366 <strcmp+0x22>
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
  80135b:	8a 10                	mov    (%eax),%dl
  80135d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801360:	8a 00                	mov    (%eax),%al
  801362:	38 c2                	cmp    %al,%dl
  801364:	74 e3                	je     801349 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801366:	8b 45 08             	mov    0x8(%ebp),%eax
  801369:	8a 00                	mov    (%eax),%al
  80136b:	0f b6 d0             	movzbl %al,%edx
  80136e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801371:	8a 00                	mov    (%eax),%al
  801373:	0f b6 c0             	movzbl %al,%eax
  801376:	29 c2                	sub    %eax,%edx
  801378:	89 d0                	mov    %edx,%eax
}
  80137a:	5d                   	pop    %ebp
  80137b:	c3                   	ret    

0080137c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80137c:	55                   	push   %ebp
  80137d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80137f:	eb 09                	jmp    80138a <strncmp+0xe>
		n--, p++, q++;
  801381:	ff 4d 10             	decl   0x10(%ebp)
  801384:	ff 45 08             	incl   0x8(%ebp)
  801387:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80138a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80138e:	74 17                	je     8013a7 <strncmp+0x2b>
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	8a 00                	mov    (%eax),%al
  801395:	84 c0                	test   %al,%al
  801397:	74 0e                	je     8013a7 <strncmp+0x2b>
  801399:	8b 45 08             	mov    0x8(%ebp),%eax
  80139c:	8a 10                	mov    (%eax),%dl
  80139e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a1:	8a 00                	mov    (%eax),%al
  8013a3:	38 c2                	cmp    %al,%dl
  8013a5:	74 da                	je     801381 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ab:	75 07                	jne    8013b4 <strncmp+0x38>
		return 0;
  8013ad:	b8 00 00 00 00       	mov    $0x0,%eax
  8013b2:	eb 14                	jmp    8013c8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	8a 00                	mov    (%eax),%al
  8013b9:	0f b6 d0             	movzbl %al,%edx
  8013bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013bf:	8a 00                	mov    (%eax),%al
  8013c1:	0f b6 c0             	movzbl %al,%eax
  8013c4:	29 c2                	sub    %eax,%edx
  8013c6:	89 d0                	mov    %edx,%eax
}
  8013c8:	5d                   	pop    %ebp
  8013c9:	c3                   	ret    

008013ca <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013ca:	55                   	push   %ebp
  8013cb:	89 e5                	mov    %esp,%ebp
  8013cd:	83 ec 04             	sub    $0x4,%esp
  8013d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013d6:	eb 12                	jmp    8013ea <strchr+0x20>
		if (*s == c)
  8013d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013db:	8a 00                	mov    (%eax),%al
  8013dd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013e0:	75 05                	jne    8013e7 <strchr+0x1d>
			return (char *) s;
  8013e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e5:	eb 11                	jmp    8013f8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013e7:	ff 45 08             	incl   0x8(%ebp)
  8013ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ed:	8a 00                	mov    (%eax),%al
  8013ef:	84 c0                	test   %al,%al
  8013f1:	75 e5                	jne    8013d8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013f8:	c9                   	leave  
  8013f9:	c3                   	ret    

008013fa <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013fa:	55                   	push   %ebp
  8013fb:	89 e5                	mov    %esp,%ebp
  8013fd:	83 ec 04             	sub    $0x4,%esp
  801400:	8b 45 0c             	mov    0xc(%ebp),%eax
  801403:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801406:	eb 0d                	jmp    801415 <strfind+0x1b>
		if (*s == c)
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
  80140b:	8a 00                	mov    (%eax),%al
  80140d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801410:	74 0e                	je     801420 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801412:	ff 45 08             	incl   0x8(%ebp)
  801415:	8b 45 08             	mov    0x8(%ebp),%eax
  801418:	8a 00                	mov    (%eax),%al
  80141a:	84 c0                	test   %al,%al
  80141c:	75 ea                	jne    801408 <strfind+0xe>
  80141e:	eb 01                	jmp    801421 <strfind+0x27>
		if (*s == c)
			break;
  801420:	90                   	nop
	return (char *) s;
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801424:	c9                   	leave  
  801425:	c3                   	ret    

00801426 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801426:	55                   	push   %ebp
  801427:	89 e5                	mov    %esp,%ebp
  801429:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80142c:	8b 45 08             	mov    0x8(%ebp),%eax
  80142f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801432:	8b 45 10             	mov    0x10(%ebp),%eax
  801435:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801438:	eb 0e                	jmp    801448 <memset+0x22>
		*p++ = c;
  80143a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80143d:	8d 50 01             	lea    0x1(%eax),%edx
  801440:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801443:	8b 55 0c             	mov    0xc(%ebp),%edx
  801446:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801448:	ff 4d f8             	decl   -0x8(%ebp)
  80144b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80144f:	79 e9                	jns    80143a <memset+0x14>
		*p++ = c;

	return v;
  801451:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
  801459:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80145c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801468:	eb 16                	jmp    801480 <memcpy+0x2a>
		*d++ = *s++;
  80146a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80146d:	8d 50 01             	lea    0x1(%eax),%edx
  801470:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801473:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801476:	8d 4a 01             	lea    0x1(%edx),%ecx
  801479:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80147c:	8a 12                	mov    (%edx),%dl
  80147e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801480:	8b 45 10             	mov    0x10(%ebp),%eax
  801483:	8d 50 ff             	lea    -0x1(%eax),%edx
  801486:	89 55 10             	mov    %edx,0x10(%ebp)
  801489:	85 c0                	test   %eax,%eax
  80148b:	75 dd                	jne    80146a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801490:	c9                   	leave  
  801491:	c3                   	ret    

00801492 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801492:	55                   	push   %ebp
  801493:	89 e5                	mov    %esp,%ebp
  801495:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801498:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80149e:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014a7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014aa:	73 50                	jae    8014fc <memmove+0x6a>
  8014ac:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014af:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b2:	01 d0                	add    %edx,%eax
  8014b4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014b7:	76 43                	jbe    8014fc <memmove+0x6a>
		s += n;
  8014b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014bc:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c2:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014c5:	eb 10                	jmp    8014d7 <memmove+0x45>
			*--d = *--s;
  8014c7:	ff 4d f8             	decl   -0x8(%ebp)
  8014ca:	ff 4d fc             	decl   -0x4(%ebp)
  8014cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014d0:	8a 10                	mov    (%eax),%dl
  8014d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014da:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014dd:	89 55 10             	mov    %edx,0x10(%ebp)
  8014e0:	85 c0                	test   %eax,%eax
  8014e2:	75 e3                	jne    8014c7 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014e4:	eb 23                	jmp    801509 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e9:	8d 50 01             	lea    0x1(%eax),%edx
  8014ec:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014ef:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014f5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014f8:	8a 12                	mov    (%edx),%dl
  8014fa:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8014fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ff:	8d 50 ff             	lea    -0x1(%eax),%edx
  801502:	89 55 10             	mov    %edx,0x10(%ebp)
  801505:	85 c0                	test   %eax,%eax
  801507:	75 dd                	jne    8014e6 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801509:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80150c:	c9                   	leave  
  80150d:	c3                   	ret    

0080150e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80150e:	55                   	push   %ebp
  80150f:	89 e5                	mov    %esp,%ebp
  801511:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80151a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801520:	eb 2a                	jmp    80154c <memcmp+0x3e>
		if (*s1 != *s2)
  801522:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801525:	8a 10                	mov    (%eax),%dl
  801527:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80152a:	8a 00                	mov    (%eax),%al
  80152c:	38 c2                	cmp    %al,%dl
  80152e:	74 16                	je     801546 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801530:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801533:	8a 00                	mov    (%eax),%al
  801535:	0f b6 d0             	movzbl %al,%edx
  801538:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153b:	8a 00                	mov    (%eax),%al
  80153d:	0f b6 c0             	movzbl %al,%eax
  801540:	29 c2                	sub    %eax,%edx
  801542:	89 d0                	mov    %edx,%eax
  801544:	eb 18                	jmp    80155e <memcmp+0x50>
		s1++, s2++;
  801546:	ff 45 fc             	incl   -0x4(%ebp)
  801549:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80154c:	8b 45 10             	mov    0x10(%ebp),%eax
  80154f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801552:	89 55 10             	mov    %edx,0x10(%ebp)
  801555:	85 c0                	test   %eax,%eax
  801557:	75 c9                	jne    801522 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801559:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80155e:	c9                   	leave  
  80155f:	c3                   	ret    

00801560 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801560:	55                   	push   %ebp
  801561:	89 e5                	mov    %esp,%ebp
  801563:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801566:	8b 55 08             	mov    0x8(%ebp),%edx
  801569:	8b 45 10             	mov    0x10(%ebp),%eax
  80156c:	01 d0                	add    %edx,%eax
  80156e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801571:	eb 15                	jmp    801588 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801573:	8b 45 08             	mov    0x8(%ebp),%eax
  801576:	8a 00                	mov    (%eax),%al
  801578:	0f b6 d0             	movzbl %al,%edx
  80157b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157e:	0f b6 c0             	movzbl %al,%eax
  801581:	39 c2                	cmp    %eax,%edx
  801583:	74 0d                	je     801592 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801585:	ff 45 08             	incl   0x8(%ebp)
  801588:	8b 45 08             	mov    0x8(%ebp),%eax
  80158b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80158e:	72 e3                	jb     801573 <memfind+0x13>
  801590:	eb 01                	jmp    801593 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801592:	90                   	nop
	return (void *) s;
  801593:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801596:	c9                   	leave  
  801597:	c3                   	ret    

00801598 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801598:	55                   	push   %ebp
  801599:	89 e5                	mov    %esp,%ebp
  80159b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80159e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015a5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015ac:	eb 03                	jmp    8015b1 <strtol+0x19>
		s++;
  8015ae:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b4:	8a 00                	mov    (%eax),%al
  8015b6:	3c 20                	cmp    $0x20,%al
  8015b8:	74 f4                	je     8015ae <strtol+0x16>
  8015ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bd:	8a 00                	mov    (%eax),%al
  8015bf:	3c 09                	cmp    $0x9,%al
  8015c1:	74 eb                	je     8015ae <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c6:	8a 00                	mov    (%eax),%al
  8015c8:	3c 2b                	cmp    $0x2b,%al
  8015ca:	75 05                	jne    8015d1 <strtol+0x39>
		s++;
  8015cc:	ff 45 08             	incl   0x8(%ebp)
  8015cf:	eb 13                	jmp    8015e4 <strtol+0x4c>
	else if (*s == '-')
  8015d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d4:	8a 00                	mov    (%eax),%al
  8015d6:	3c 2d                	cmp    $0x2d,%al
  8015d8:	75 0a                	jne    8015e4 <strtol+0x4c>
		s++, neg = 1;
  8015da:	ff 45 08             	incl   0x8(%ebp)
  8015dd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015e4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015e8:	74 06                	je     8015f0 <strtol+0x58>
  8015ea:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015ee:	75 20                	jne    801610 <strtol+0x78>
  8015f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f3:	8a 00                	mov    (%eax),%al
  8015f5:	3c 30                	cmp    $0x30,%al
  8015f7:	75 17                	jne    801610 <strtol+0x78>
  8015f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fc:	40                   	inc    %eax
  8015fd:	8a 00                	mov    (%eax),%al
  8015ff:	3c 78                	cmp    $0x78,%al
  801601:	75 0d                	jne    801610 <strtol+0x78>
		s += 2, base = 16;
  801603:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801607:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80160e:	eb 28                	jmp    801638 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801610:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801614:	75 15                	jne    80162b <strtol+0x93>
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	8a 00                	mov    (%eax),%al
  80161b:	3c 30                	cmp    $0x30,%al
  80161d:	75 0c                	jne    80162b <strtol+0x93>
		s++, base = 8;
  80161f:	ff 45 08             	incl   0x8(%ebp)
  801622:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801629:	eb 0d                	jmp    801638 <strtol+0xa0>
	else if (base == 0)
  80162b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80162f:	75 07                	jne    801638 <strtol+0xa0>
		base = 10;
  801631:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801638:	8b 45 08             	mov    0x8(%ebp),%eax
  80163b:	8a 00                	mov    (%eax),%al
  80163d:	3c 2f                	cmp    $0x2f,%al
  80163f:	7e 19                	jle    80165a <strtol+0xc2>
  801641:	8b 45 08             	mov    0x8(%ebp),%eax
  801644:	8a 00                	mov    (%eax),%al
  801646:	3c 39                	cmp    $0x39,%al
  801648:	7f 10                	jg     80165a <strtol+0xc2>
			dig = *s - '0';
  80164a:	8b 45 08             	mov    0x8(%ebp),%eax
  80164d:	8a 00                	mov    (%eax),%al
  80164f:	0f be c0             	movsbl %al,%eax
  801652:	83 e8 30             	sub    $0x30,%eax
  801655:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801658:	eb 42                	jmp    80169c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	8a 00                	mov    (%eax),%al
  80165f:	3c 60                	cmp    $0x60,%al
  801661:	7e 19                	jle    80167c <strtol+0xe4>
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	8a 00                	mov    (%eax),%al
  801668:	3c 7a                	cmp    $0x7a,%al
  80166a:	7f 10                	jg     80167c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	8a 00                	mov    (%eax),%al
  801671:	0f be c0             	movsbl %al,%eax
  801674:	83 e8 57             	sub    $0x57,%eax
  801677:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80167a:	eb 20                	jmp    80169c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80167c:	8b 45 08             	mov    0x8(%ebp),%eax
  80167f:	8a 00                	mov    (%eax),%al
  801681:	3c 40                	cmp    $0x40,%al
  801683:	7e 39                	jle    8016be <strtol+0x126>
  801685:	8b 45 08             	mov    0x8(%ebp),%eax
  801688:	8a 00                	mov    (%eax),%al
  80168a:	3c 5a                	cmp    $0x5a,%al
  80168c:	7f 30                	jg     8016be <strtol+0x126>
			dig = *s - 'A' + 10;
  80168e:	8b 45 08             	mov    0x8(%ebp),%eax
  801691:	8a 00                	mov    (%eax),%al
  801693:	0f be c0             	movsbl %al,%eax
  801696:	83 e8 37             	sub    $0x37,%eax
  801699:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80169c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80169f:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016a2:	7d 19                	jge    8016bd <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016a4:	ff 45 08             	incl   0x8(%ebp)
  8016a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016aa:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016ae:	89 c2                	mov    %eax,%edx
  8016b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b3:	01 d0                	add    %edx,%eax
  8016b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016b8:	e9 7b ff ff ff       	jmp    801638 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016bd:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016be:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016c2:	74 08                	je     8016cc <strtol+0x134>
		*endptr = (char *) s;
  8016c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c7:	8b 55 08             	mov    0x8(%ebp),%edx
  8016ca:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016d0:	74 07                	je     8016d9 <strtol+0x141>
  8016d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d5:	f7 d8                	neg    %eax
  8016d7:	eb 03                	jmp    8016dc <strtol+0x144>
  8016d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <ltostr>:

void
ltostr(long value, char *str)
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
  8016e1:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016eb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016f2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016f6:	79 13                	jns    80170b <ltostr+0x2d>
	{
		neg = 1;
  8016f8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8016ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801702:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801705:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801708:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80170b:	8b 45 08             	mov    0x8(%ebp),%eax
  80170e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801713:	99                   	cltd   
  801714:	f7 f9                	idiv   %ecx
  801716:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801719:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80171c:	8d 50 01             	lea    0x1(%eax),%edx
  80171f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801722:	89 c2                	mov    %eax,%edx
  801724:	8b 45 0c             	mov    0xc(%ebp),%eax
  801727:	01 d0                	add    %edx,%eax
  801729:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80172c:	83 c2 30             	add    $0x30,%edx
  80172f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801731:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801734:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801739:	f7 e9                	imul   %ecx
  80173b:	c1 fa 02             	sar    $0x2,%edx
  80173e:	89 c8                	mov    %ecx,%eax
  801740:	c1 f8 1f             	sar    $0x1f,%eax
  801743:	29 c2                	sub    %eax,%edx
  801745:	89 d0                	mov    %edx,%eax
  801747:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80174a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80174d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801752:	f7 e9                	imul   %ecx
  801754:	c1 fa 02             	sar    $0x2,%edx
  801757:	89 c8                	mov    %ecx,%eax
  801759:	c1 f8 1f             	sar    $0x1f,%eax
  80175c:	29 c2                	sub    %eax,%edx
  80175e:	89 d0                	mov    %edx,%eax
  801760:	c1 e0 02             	shl    $0x2,%eax
  801763:	01 d0                	add    %edx,%eax
  801765:	01 c0                	add    %eax,%eax
  801767:	29 c1                	sub    %eax,%ecx
  801769:	89 ca                	mov    %ecx,%edx
  80176b:	85 d2                	test   %edx,%edx
  80176d:	75 9c                	jne    80170b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80176f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801776:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801779:	48                   	dec    %eax
  80177a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80177d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801781:	74 3d                	je     8017c0 <ltostr+0xe2>
		start = 1 ;
  801783:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80178a:	eb 34                	jmp    8017c0 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80178c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80178f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801792:	01 d0                	add    %edx,%eax
  801794:	8a 00                	mov    (%eax),%al
  801796:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801799:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80179c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179f:	01 c2                	add    %eax,%edx
  8017a1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a7:	01 c8                	add    %ecx,%eax
  8017a9:	8a 00                	mov    (%eax),%al
  8017ab:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017ad:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b3:	01 c2                	add    %eax,%edx
  8017b5:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017b8:	88 02                	mov    %al,(%edx)
		start++ ;
  8017ba:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017bd:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017c3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017c6:	7c c4                	jl     80178c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017c8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ce:	01 d0                	add    %edx,%eax
  8017d0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017d3:	90                   	nop
  8017d4:	c9                   	leave  
  8017d5:	c3                   	ret    

008017d6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017d6:	55                   	push   %ebp
  8017d7:	89 e5                	mov    %esp,%ebp
  8017d9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017dc:	ff 75 08             	pushl  0x8(%ebp)
  8017df:	e8 54 fa ff ff       	call   801238 <strlen>
  8017e4:	83 c4 04             	add    $0x4,%esp
  8017e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017ea:	ff 75 0c             	pushl  0xc(%ebp)
  8017ed:	e8 46 fa ff ff       	call   801238 <strlen>
  8017f2:	83 c4 04             	add    $0x4,%esp
  8017f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8017ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801806:	eb 17                	jmp    80181f <strcconcat+0x49>
		final[s] = str1[s] ;
  801808:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80180b:	8b 45 10             	mov    0x10(%ebp),%eax
  80180e:	01 c2                	add    %eax,%edx
  801810:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801813:	8b 45 08             	mov    0x8(%ebp),%eax
  801816:	01 c8                	add    %ecx,%eax
  801818:	8a 00                	mov    (%eax),%al
  80181a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80181c:	ff 45 fc             	incl   -0x4(%ebp)
  80181f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801822:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801825:	7c e1                	jl     801808 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801827:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80182e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801835:	eb 1f                	jmp    801856 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801837:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80183a:	8d 50 01             	lea    0x1(%eax),%edx
  80183d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801840:	89 c2                	mov    %eax,%edx
  801842:	8b 45 10             	mov    0x10(%ebp),%eax
  801845:	01 c2                	add    %eax,%edx
  801847:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80184a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184d:	01 c8                	add    %ecx,%eax
  80184f:	8a 00                	mov    (%eax),%al
  801851:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801853:	ff 45 f8             	incl   -0x8(%ebp)
  801856:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801859:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80185c:	7c d9                	jl     801837 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80185e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801861:	8b 45 10             	mov    0x10(%ebp),%eax
  801864:	01 d0                	add    %edx,%eax
  801866:	c6 00 00             	movb   $0x0,(%eax)
}
  801869:	90                   	nop
  80186a:	c9                   	leave  
  80186b:	c3                   	ret    

0080186c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80186c:	55                   	push   %ebp
  80186d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80186f:	8b 45 14             	mov    0x14(%ebp),%eax
  801872:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801878:	8b 45 14             	mov    0x14(%ebp),%eax
  80187b:	8b 00                	mov    (%eax),%eax
  80187d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801884:	8b 45 10             	mov    0x10(%ebp),%eax
  801887:	01 d0                	add    %edx,%eax
  801889:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80188f:	eb 0c                	jmp    80189d <strsplit+0x31>
			*string++ = 0;
  801891:	8b 45 08             	mov    0x8(%ebp),%eax
  801894:	8d 50 01             	lea    0x1(%eax),%edx
  801897:	89 55 08             	mov    %edx,0x8(%ebp)
  80189a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80189d:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a0:	8a 00                	mov    (%eax),%al
  8018a2:	84 c0                	test   %al,%al
  8018a4:	74 18                	je     8018be <strsplit+0x52>
  8018a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a9:	8a 00                	mov    (%eax),%al
  8018ab:	0f be c0             	movsbl %al,%eax
  8018ae:	50                   	push   %eax
  8018af:	ff 75 0c             	pushl  0xc(%ebp)
  8018b2:	e8 13 fb ff ff       	call   8013ca <strchr>
  8018b7:	83 c4 08             	add    $0x8,%esp
  8018ba:	85 c0                	test   %eax,%eax
  8018bc:	75 d3                	jne    801891 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8018be:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c1:	8a 00                	mov    (%eax),%al
  8018c3:	84 c0                	test   %al,%al
  8018c5:	74 5a                	je     801921 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8018c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ca:	8b 00                	mov    (%eax),%eax
  8018cc:	83 f8 0f             	cmp    $0xf,%eax
  8018cf:	75 07                	jne    8018d8 <strsplit+0x6c>
		{
			return 0;
  8018d1:	b8 00 00 00 00       	mov    $0x0,%eax
  8018d6:	eb 66                	jmp    80193e <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8018db:	8b 00                	mov    (%eax),%eax
  8018dd:	8d 48 01             	lea    0x1(%eax),%ecx
  8018e0:	8b 55 14             	mov    0x14(%ebp),%edx
  8018e3:	89 0a                	mov    %ecx,(%edx)
  8018e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ef:	01 c2                	add    %eax,%edx
  8018f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018f6:	eb 03                	jmp    8018fb <strsplit+0x8f>
			string++;
  8018f8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fe:	8a 00                	mov    (%eax),%al
  801900:	84 c0                	test   %al,%al
  801902:	74 8b                	je     80188f <strsplit+0x23>
  801904:	8b 45 08             	mov    0x8(%ebp),%eax
  801907:	8a 00                	mov    (%eax),%al
  801909:	0f be c0             	movsbl %al,%eax
  80190c:	50                   	push   %eax
  80190d:	ff 75 0c             	pushl  0xc(%ebp)
  801910:	e8 b5 fa ff ff       	call   8013ca <strchr>
  801915:	83 c4 08             	add    $0x8,%esp
  801918:	85 c0                	test   %eax,%eax
  80191a:	74 dc                	je     8018f8 <strsplit+0x8c>
			string++;
	}
  80191c:	e9 6e ff ff ff       	jmp    80188f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801921:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801922:	8b 45 14             	mov    0x14(%ebp),%eax
  801925:	8b 00                	mov    (%eax),%eax
  801927:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80192e:	8b 45 10             	mov    0x10(%ebp),%eax
  801931:	01 d0                	add    %edx,%eax
  801933:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801939:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80193e:	c9                   	leave  
  80193f:	c3                   	ret    

00801940 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801940:	55                   	push   %ebp
  801941:	89 e5                	mov    %esp,%ebp
  801943:	83 ec 18             	sub    $0x18,%esp
  801946:	8b 45 10             	mov    0x10(%ebp),%eax
  801949:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80194c:	83 ec 04             	sub    $0x4,%esp
  80194f:	68 44 2b 80 00       	push   $0x802b44
  801954:	6a 17                	push   $0x17
  801956:	68 63 2b 80 00       	push   $0x802b63
  80195b:	e8 9c ed ff ff       	call   8006fc <_panic>

00801960 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801960:	55                   	push   %ebp
  801961:	89 e5                	mov    %esp,%ebp
  801963:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801966:	83 ec 04             	sub    $0x4,%esp
  801969:	68 6f 2b 80 00       	push   $0x802b6f
  80196e:	6a 2f                	push   $0x2f
  801970:	68 63 2b 80 00       	push   $0x802b63
  801975:	e8 82 ed ff ff       	call   8006fc <_panic>

0080197a <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  80197a:	55                   	push   %ebp
  80197b:	89 e5                	mov    %esp,%ebp
  80197d:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801980:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801987:	8b 55 08             	mov    0x8(%ebp),%edx
  80198a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80198d:	01 d0                	add    %edx,%eax
  80198f:	48                   	dec    %eax
  801990:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801993:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801996:	ba 00 00 00 00       	mov    $0x0,%edx
  80199b:	f7 75 ec             	divl   -0x14(%ebp)
  80199e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019a1:	29 d0                	sub    %edx,%eax
  8019a3:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8019a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a9:	c1 e8 0c             	shr    $0xc,%eax
  8019ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8019af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8019b6:	e9 c8 00 00 00       	jmp    801a83 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8019bb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019c2:	eb 27                	jmp    8019eb <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8019c4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019ca:	01 c2                	add    %eax,%edx
  8019cc:	89 d0                	mov    %edx,%eax
  8019ce:	01 c0                	add    %eax,%eax
  8019d0:	01 d0                	add    %edx,%eax
  8019d2:	c1 e0 02             	shl    $0x2,%eax
  8019d5:	05 48 30 80 00       	add    $0x803048,%eax
  8019da:	8b 00                	mov    (%eax),%eax
  8019dc:	85 c0                	test   %eax,%eax
  8019de:	74 08                	je     8019e8 <malloc+0x6e>
            	i += j;
  8019e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019e3:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8019e6:	eb 0b                	jmp    8019f3 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8019e8:	ff 45 f0             	incl   -0x10(%ebp)
  8019eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019ee:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019f1:	72 d1                	jb     8019c4 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8019f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019f6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019f9:	0f 85 81 00 00 00    	jne    801a80 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8019ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a02:	05 00 00 08 00       	add    $0x80000,%eax
  801a07:	c1 e0 0c             	shl    $0xc,%eax
  801a0a:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801a0d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a14:	eb 1f                	jmp    801a35 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801a16:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a1c:	01 c2                	add    %eax,%edx
  801a1e:	89 d0                	mov    %edx,%eax
  801a20:	01 c0                	add    %eax,%eax
  801a22:	01 d0                	add    %edx,%eax
  801a24:	c1 e0 02             	shl    $0x2,%eax
  801a27:	05 48 30 80 00       	add    $0x803048,%eax
  801a2c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801a32:	ff 45 f0             	incl   -0x10(%ebp)
  801a35:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a38:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a3b:	72 d9                	jb     801a16 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801a3d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a40:	89 d0                	mov    %edx,%eax
  801a42:	01 c0                	add    %eax,%eax
  801a44:	01 d0                	add    %edx,%eax
  801a46:	c1 e0 02             	shl    $0x2,%eax
  801a49:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801a4f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a52:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801a54:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a57:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801a5a:	89 c8                	mov    %ecx,%eax
  801a5c:	01 c0                	add    %eax,%eax
  801a5e:	01 c8                	add    %ecx,%eax
  801a60:	c1 e0 02             	shl    $0x2,%eax
  801a63:	05 44 30 80 00       	add    $0x803044,%eax
  801a68:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801a6a:	83 ec 08             	sub    $0x8,%esp
  801a6d:	ff 75 08             	pushl  0x8(%ebp)
  801a70:	ff 75 e0             	pushl  -0x20(%ebp)
  801a73:	e8 2b 03 00 00       	call   801da3 <sys_allocateMem>
  801a78:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801a7b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a7e:	eb 19                	jmp    801a99 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801a80:	ff 45 f4             	incl   -0xc(%ebp)
  801a83:	a1 04 30 80 00       	mov    0x803004,%eax
  801a88:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801a8b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a8e:	0f 83 27 ff ff ff    	jae    8019bb <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801a94:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a99:	c9                   	leave  
  801a9a:	c3                   	ret    

00801a9b <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801a9b:	55                   	push   %ebp
  801a9c:	89 e5                	mov    %esp,%ebp
  801a9e:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801aa1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801aa5:	0f 84 e5 00 00 00    	je     801b90 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801aab:	8b 45 08             	mov    0x8(%ebp),%eax
  801aae:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801ab1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ab4:	05 00 00 00 80       	add    $0x80000000,%eax
  801ab9:	c1 e8 0c             	shr    $0xc,%eax
  801abc:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801abf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ac2:	89 d0                	mov    %edx,%eax
  801ac4:	01 c0                	add    %eax,%eax
  801ac6:	01 d0                	add    %edx,%eax
  801ac8:	c1 e0 02             	shl    $0x2,%eax
  801acb:	05 40 30 80 00       	add    $0x803040,%eax
  801ad0:	8b 00                	mov    (%eax),%eax
  801ad2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ad5:	0f 85 b8 00 00 00    	jne    801b93 <free+0xf8>
  801adb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ade:	89 d0                	mov    %edx,%eax
  801ae0:	01 c0                	add    %eax,%eax
  801ae2:	01 d0                	add    %edx,%eax
  801ae4:	c1 e0 02             	shl    $0x2,%eax
  801ae7:	05 48 30 80 00       	add    $0x803048,%eax
  801aec:	8b 00                	mov    (%eax),%eax
  801aee:	85 c0                	test   %eax,%eax
  801af0:	0f 84 9d 00 00 00    	je     801b93 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801af6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801af9:	89 d0                	mov    %edx,%eax
  801afb:	01 c0                	add    %eax,%eax
  801afd:	01 d0                	add    %edx,%eax
  801aff:	c1 e0 02             	shl    $0x2,%eax
  801b02:	05 44 30 80 00       	add    $0x803044,%eax
  801b07:	8b 00                	mov    (%eax),%eax
  801b09:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801b0c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b0f:	c1 e0 0c             	shl    $0xc,%eax
  801b12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801b15:	83 ec 08             	sub    $0x8,%esp
  801b18:	ff 75 e4             	pushl  -0x1c(%ebp)
  801b1b:	ff 75 f0             	pushl  -0x10(%ebp)
  801b1e:	e8 64 02 00 00       	call   801d87 <sys_freeMem>
  801b23:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801b26:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b2d:	eb 57                	jmp    801b86 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801b2f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b32:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b35:	01 c2                	add    %eax,%edx
  801b37:	89 d0                	mov    %edx,%eax
  801b39:	01 c0                	add    %eax,%eax
  801b3b:	01 d0                	add    %edx,%eax
  801b3d:	c1 e0 02             	shl    $0x2,%eax
  801b40:	05 48 30 80 00       	add    $0x803048,%eax
  801b45:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801b4b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b51:	01 c2                	add    %eax,%edx
  801b53:	89 d0                	mov    %edx,%eax
  801b55:	01 c0                	add    %eax,%eax
  801b57:	01 d0                	add    %edx,%eax
  801b59:	c1 e0 02             	shl    $0x2,%eax
  801b5c:	05 40 30 80 00       	add    $0x803040,%eax
  801b61:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801b67:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b6d:	01 c2                	add    %eax,%edx
  801b6f:	89 d0                	mov    %edx,%eax
  801b71:	01 c0                	add    %eax,%eax
  801b73:	01 d0                	add    %edx,%eax
  801b75:	c1 e0 02             	shl    $0x2,%eax
  801b78:	05 44 30 80 00       	add    $0x803044,%eax
  801b7d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801b83:	ff 45 f4             	incl   -0xc(%ebp)
  801b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b89:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b8c:	7c a1                	jl     801b2f <free+0x94>
  801b8e:	eb 04                	jmp    801b94 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801b90:	90                   	nop
  801b91:	eb 01                	jmp    801b94 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801b93:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801b94:	c9                   	leave  
  801b95:	c3                   	ret    

00801b96 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801b96:	55                   	push   %ebp
  801b97:	89 e5                	mov    %esp,%ebp
  801b99:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801b9c:	83 ec 04             	sub    $0x4,%esp
  801b9f:	68 8c 2b 80 00       	push   $0x802b8c
  801ba4:	68 ae 00 00 00       	push   $0xae
  801ba9:	68 63 2b 80 00       	push   $0x802b63
  801bae:	e8 49 eb ff ff       	call   8006fc <_panic>

00801bb3 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801bb3:	55                   	push   %ebp
  801bb4:	89 e5                	mov    %esp,%ebp
  801bb6:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801bb9:	83 ec 04             	sub    $0x4,%esp
  801bbc:	68 ac 2b 80 00       	push   $0x802bac
  801bc1:	68 ca 00 00 00       	push   $0xca
  801bc6:	68 63 2b 80 00       	push   $0x802b63
  801bcb:	e8 2c eb ff ff       	call   8006fc <_panic>

00801bd0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801bd0:	55                   	push   %ebp
  801bd1:	89 e5                	mov    %esp,%ebp
  801bd3:	57                   	push   %edi
  801bd4:	56                   	push   %esi
  801bd5:	53                   	push   %ebx
  801bd6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bdf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801be2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801be5:	8b 7d 18             	mov    0x18(%ebp),%edi
  801be8:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801beb:	cd 30                	int    $0x30
  801bed:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801bf0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801bf3:	83 c4 10             	add    $0x10,%esp
  801bf6:	5b                   	pop    %ebx
  801bf7:	5e                   	pop    %esi
  801bf8:	5f                   	pop    %edi
  801bf9:	5d                   	pop    %ebp
  801bfa:	c3                   	ret    

00801bfb <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801bfb:	55                   	push   %ebp
  801bfc:	89 e5                	mov    %esp,%ebp
  801bfe:	83 ec 04             	sub    $0x4,%esp
  801c01:	8b 45 10             	mov    0x10(%ebp),%eax
  801c04:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c07:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	52                   	push   %edx
  801c13:	ff 75 0c             	pushl  0xc(%ebp)
  801c16:	50                   	push   %eax
  801c17:	6a 00                	push   $0x0
  801c19:	e8 b2 ff ff ff       	call   801bd0 <syscall>
  801c1e:	83 c4 18             	add    $0x18,%esp
}
  801c21:	90                   	nop
  801c22:	c9                   	leave  
  801c23:	c3                   	ret    

00801c24 <sys_cgetc>:

int
sys_cgetc(void)
{
  801c24:	55                   	push   %ebp
  801c25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 01                	push   $0x1
  801c33:	e8 98 ff ff ff       	call   801bd0 <syscall>
  801c38:	83 c4 18             	add    $0x18,%esp
}
  801c3b:	c9                   	leave  
  801c3c:	c3                   	ret    

00801c3d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c3d:	55                   	push   %ebp
  801c3e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c40:	8b 45 08             	mov    0x8(%ebp),%eax
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	50                   	push   %eax
  801c4c:	6a 05                	push   $0x5
  801c4e:	e8 7d ff ff ff       	call   801bd0 <syscall>
  801c53:	83 c4 18             	add    $0x18,%esp
}
  801c56:	c9                   	leave  
  801c57:	c3                   	ret    

00801c58 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c58:	55                   	push   %ebp
  801c59:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	6a 00                	push   $0x0
  801c65:	6a 02                	push   $0x2
  801c67:	e8 64 ff ff ff       	call   801bd0 <syscall>
  801c6c:	83 c4 18             	add    $0x18,%esp
}
  801c6f:	c9                   	leave  
  801c70:	c3                   	ret    

00801c71 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c71:	55                   	push   %ebp
  801c72:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 03                	push   $0x3
  801c80:	e8 4b ff ff ff       	call   801bd0 <syscall>
  801c85:	83 c4 18             	add    $0x18,%esp
}
  801c88:	c9                   	leave  
  801c89:	c3                   	ret    

00801c8a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c8a:	55                   	push   %ebp
  801c8b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 04                	push   $0x4
  801c99:	e8 32 ff ff ff       	call   801bd0 <syscall>
  801c9e:	83 c4 18             	add    $0x18,%esp
}
  801ca1:	c9                   	leave  
  801ca2:	c3                   	ret    

00801ca3 <sys_env_exit>:


void sys_env_exit(void)
{
  801ca3:	55                   	push   %ebp
  801ca4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 00                	push   $0x0
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 06                	push   $0x6
  801cb2:	e8 19 ff ff ff       	call   801bd0 <syscall>
  801cb7:	83 c4 18             	add    $0x18,%esp
}
  801cba:	90                   	nop
  801cbb:	c9                   	leave  
  801cbc:	c3                   	ret    

00801cbd <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801cbd:	55                   	push   %ebp
  801cbe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801cc0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	52                   	push   %edx
  801ccd:	50                   	push   %eax
  801cce:	6a 07                	push   $0x7
  801cd0:	e8 fb fe ff ff       	call   801bd0 <syscall>
  801cd5:	83 c4 18             	add    $0x18,%esp
}
  801cd8:	c9                   	leave  
  801cd9:	c3                   	ret    

00801cda <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801cda:	55                   	push   %ebp
  801cdb:	89 e5                	mov    %esp,%ebp
  801cdd:	56                   	push   %esi
  801cde:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801cdf:	8b 75 18             	mov    0x18(%ebp),%esi
  801ce2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ce5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ce8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cee:	56                   	push   %esi
  801cef:	53                   	push   %ebx
  801cf0:	51                   	push   %ecx
  801cf1:	52                   	push   %edx
  801cf2:	50                   	push   %eax
  801cf3:	6a 08                	push   $0x8
  801cf5:	e8 d6 fe ff ff       	call   801bd0 <syscall>
  801cfa:	83 c4 18             	add    $0x18,%esp
}
  801cfd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d00:	5b                   	pop    %ebx
  801d01:	5e                   	pop    %esi
  801d02:	5d                   	pop    %ebp
  801d03:	c3                   	ret    

00801d04 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d04:	55                   	push   %ebp
  801d05:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d07:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	52                   	push   %edx
  801d14:	50                   	push   %eax
  801d15:	6a 09                	push   $0x9
  801d17:	e8 b4 fe ff ff       	call   801bd0 <syscall>
  801d1c:	83 c4 18             	add    $0x18,%esp
}
  801d1f:	c9                   	leave  
  801d20:	c3                   	ret    

00801d21 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d21:	55                   	push   %ebp
  801d22:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	ff 75 0c             	pushl  0xc(%ebp)
  801d2d:	ff 75 08             	pushl  0x8(%ebp)
  801d30:	6a 0a                	push   $0xa
  801d32:	e8 99 fe ff ff       	call   801bd0 <syscall>
  801d37:	83 c4 18             	add    $0x18,%esp
}
  801d3a:	c9                   	leave  
  801d3b:	c3                   	ret    

00801d3c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d3c:	55                   	push   %ebp
  801d3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 0b                	push   $0xb
  801d4b:	e8 80 fe ff ff       	call   801bd0 <syscall>
  801d50:	83 c4 18             	add    $0x18,%esp
}
  801d53:	c9                   	leave  
  801d54:	c3                   	ret    

00801d55 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d55:	55                   	push   %ebp
  801d56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	6a 0c                	push   $0xc
  801d64:	e8 67 fe ff ff       	call   801bd0 <syscall>
  801d69:	83 c4 18             	add    $0x18,%esp
}
  801d6c:	c9                   	leave  
  801d6d:	c3                   	ret    

00801d6e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d6e:	55                   	push   %ebp
  801d6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 0d                	push   $0xd
  801d7d:	e8 4e fe ff ff       	call   801bd0 <syscall>
  801d82:	83 c4 18             	add    $0x18,%esp
}
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    

00801d87 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d87:	55                   	push   %ebp
  801d88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d8a:	6a 00                	push   $0x0
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 00                	push   $0x0
  801d90:	ff 75 0c             	pushl  0xc(%ebp)
  801d93:	ff 75 08             	pushl  0x8(%ebp)
  801d96:	6a 11                	push   $0x11
  801d98:	e8 33 fe ff ff       	call   801bd0 <syscall>
  801d9d:	83 c4 18             	add    $0x18,%esp
	return;
  801da0:	90                   	nop
}
  801da1:	c9                   	leave  
  801da2:	c3                   	ret    

00801da3 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801da3:	55                   	push   %ebp
  801da4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 00                	push   $0x0
  801dac:	ff 75 0c             	pushl  0xc(%ebp)
  801daf:	ff 75 08             	pushl  0x8(%ebp)
  801db2:	6a 12                	push   $0x12
  801db4:	e8 17 fe ff ff       	call   801bd0 <syscall>
  801db9:	83 c4 18             	add    $0x18,%esp
	return ;
  801dbc:	90                   	nop
}
  801dbd:	c9                   	leave  
  801dbe:	c3                   	ret    

00801dbf <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801dbf:	55                   	push   %ebp
  801dc0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 0e                	push   $0xe
  801dce:	e8 fd fd ff ff       	call   801bd0 <syscall>
  801dd3:	83 c4 18             	add    $0x18,%esp
}
  801dd6:	c9                   	leave  
  801dd7:	c3                   	ret    

00801dd8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801dd8:	55                   	push   %ebp
  801dd9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	ff 75 08             	pushl  0x8(%ebp)
  801de6:	6a 0f                	push   $0xf
  801de8:	e8 e3 fd ff ff       	call   801bd0 <syscall>
  801ded:	83 c4 18             	add    $0x18,%esp
}
  801df0:	c9                   	leave  
  801df1:	c3                   	ret    

00801df2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801df2:	55                   	push   %ebp
  801df3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 10                	push   $0x10
  801e01:	e8 ca fd ff ff       	call   801bd0 <syscall>
  801e06:	83 c4 18             	add    $0x18,%esp
}
  801e09:	90                   	nop
  801e0a:	c9                   	leave  
  801e0b:	c3                   	ret    

00801e0c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e0c:	55                   	push   %ebp
  801e0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 00                	push   $0x0
  801e13:	6a 00                	push   $0x0
  801e15:	6a 00                	push   $0x0
  801e17:	6a 00                	push   $0x0
  801e19:	6a 14                	push   $0x14
  801e1b:	e8 b0 fd ff ff       	call   801bd0 <syscall>
  801e20:	83 c4 18             	add    $0x18,%esp
}
  801e23:	90                   	nop
  801e24:	c9                   	leave  
  801e25:	c3                   	ret    

00801e26 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e26:	55                   	push   %ebp
  801e27:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	6a 15                	push   $0x15
  801e35:	e8 96 fd ff ff       	call   801bd0 <syscall>
  801e3a:	83 c4 18             	add    $0x18,%esp
}
  801e3d:	90                   	nop
  801e3e:	c9                   	leave  
  801e3f:	c3                   	ret    

00801e40 <sys_cputc>:


void
sys_cputc(const char c)
{
  801e40:	55                   	push   %ebp
  801e41:	89 e5                	mov    %esp,%ebp
  801e43:	83 ec 04             	sub    $0x4,%esp
  801e46:	8b 45 08             	mov    0x8(%ebp),%eax
  801e49:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e4c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	50                   	push   %eax
  801e59:	6a 16                	push   $0x16
  801e5b:	e8 70 fd ff ff       	call   801bd0 <syscall>
  801e60:	83 c4 18             	add    $0x18,%esp
}
  801e63:	90                   	nop
  801e64:	c9                   	leave  
  801e65:	c3                   	ret    

00801e66 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e66:	55                   	push   %ebp
  801e67:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 00                	push   $0x0
  801e73:	6a 17                	push   $0x17
  801e75:	e8 56 fd ff ff       	call   801bd0 <syscall>
  801e7a:	83 c4 18             	add    $0x18,%esp
}
  801e7d:	90                   	nop
  801e7e:	c9                   	leave  
  801e7f:	c3                   	ret    

00801e80 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e80:	55                   	push   %ebp
  801e81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e83:	8b 45 08             	mov    0x8(%ebp),%eax
  801e86:	6a 00                	push   $0x0
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 00                	push   $0x0
  801e8c:	ff 75 0c             	pushl  0xc(%ebp)
  801e8f:	50                   	push   %eax
  801e90:	6a 18                	push   $0x18
  801e92:	e8 39 fd ff ff       	call   801bd0 <syscall>
  801e97:	83 c4 18             	add    $0x18,%esp
}
  801e9a:	c9                   	leave  
  801e9b:	c3                   	ret    

00801e9c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e9c:	55                   	push   %ebp
  801e9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 00                	push   $0x0
  801eab:	52                   	push   %edx
  801eac:	50                   	push   %eax
  801ead:	6a 1b                	push   $0x1b
  801eaf:	e8 1c fd ff ff       	call   801bd0 <syscall>
  801eb4:	83 c4 18             	add    $0x18,%esp
}
  801eb7:	c9                   	leave  
  801eb8:	c3                   	ret    

00801eb9 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801eb9:	55                   	push   %ebp
  801eba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ebc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	52                   	push   %edx
  801ec9:	50                   	push   %eax
  801eca:	6a 19                	push   $0x19
  801ecc:	e8 ff fc ff ff       	call   801bd0 <syscall>
  801ed1:	83 c4 18             	add    $0x18,%esp
}
  801ed4:	90                   	nop
  801ed5:	c9                   	leave  
  801ed6:	c3                   	ret    

00801ed7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ed7:	55                   	push   %ebp
  801ed8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801eda:	8b 55 0c             	mov    0xc(%ebp),%edx
  801edd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee0:	6a 00                	push   $0x0
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 00                	push   $0x0
  801ee6:	52                   	push   %edx
  801ee7:	50                   	push   %eax
  801ee8:	6a 1a                	push   $0x1a
  801eea:	e8 e1 fc ff ff       	call   801bd0 <syscall>
  801eef:	83 c4 18             	add    $0x18,%esp
}
  801ef2:	90                   	nop
  801ef3:	c9                   	leave  
  801ef4:	c3                   	ret    

00801ef5 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ef5:	55                   	push   %ebp
  801ef6:	89 e5                	mov    %esp,%ebp
  801ef8:	83 ec 04             	sub    $0x4,%esp
  801efb:	8b 45 10             	mov    0x10(%ebp),%eax
  801efe:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f01:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f04:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f08:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0b:	6a 00                	push   $0x0
  801f0d:	51                   	push   %ecx
  801f0e:	52                   	push   %edx
  801f0f:	ff 75 0c             	pushl  0xc(%ebp)
  801f12:	50                   	push   %eax
  801f13:	6a 1c                	push   $0x1c
  801f15:	e8 b6 fc ff ff       	call   801bd0 <syscall>
  801f1a:	83 c4 18             	add    $0x18,%esp
}
  801f1d:	c9                   	leave  
  801f1e:	c3                   	ret    

00801f1f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f1f:	55                   	push   %ebp
  801f20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f22:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f25:	8b 45 08             	mov    0x8(%ebp),%eax
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 00                	push   $0x0
  801f2c:	6a 00                	push   $0x0
  801f2e:	52                   	push   %edx
  801f2f:	50                   	push   %eax
  801f30:	6a 1d                	push   $0x1d
  801f32:	e8 99 fc ff ff       	call   801bd0 <syscall>
  801f37:	83 c4 18             	add    $0x18,%esp
}
  801f3a:	c9                   	leave  
  801f3b:	c3                   	ret    

00801f3c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f3c:	55                   	push   %ebp
  801f3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f3f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f42:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f45:	8b 45 08             	mov    0x8(%ebp),%eax
  801f48:	6a 00                	push   $0x0
  801f4a:	6a 00                	push   $0x0
  801f4c:	51                   	push   %ecx
  801f4d:	52                   	push   %edx
  801f4e:	50                   	push   %eax
  801f4f:	6a 1e                	push   $0x1e
  801f51:	e8 7a fc ff ff       	call   801bd0 <syscall>
  801f56:	83 c4 18             	add    $0x18,%esp
}
  801f59:	c9                   	leave  
  801f5a:	c3                   	ret    

00801f5b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f5b:	55                   	push   %ebp
  801f5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f61:	8b 45 08             	mov    0x8(%ebp),%eax
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	52                   	push   %edx
  801f6b:	50                   	push   %eax
  801f6c:	6a 1f                	push   $0x1f
  801f6e:	e8 5d fc ff ff       	call   801bd0 <syscall>
  801f73:	83 c4 18             	add    $0x18,%esp
}
  801f76:	c9                   	leave  
  801f77:	c3                   	ret    

00801f78 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f78:	55                   	push   %ebp
  801f79:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	6a 00                	push   $0x0
  801f81:	6a 00                	push   $0x0
  801f83:	6a 00                	push   $0x0
  801f85:	6a 20                	push   $0x20
  801f87:	e8 44 fc ff ff       	call   801bd0 <syscall>
  801f8c:	83 c4 18             	add    $0x18,%esp
}
  801f8f:	c9                   	leave  
  801f90:	c3                   	ret    

00801f91 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801f91:	55                   	push   %ebp
  801f92:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801f94:	8b 45 08             	mov    0x8(%ebp),%eax
  801f97:	6a 00                	push   $0x0
  801f99:	6a 00                	push   $0x0
  801f9b:	ff 75 10             	pushl  0x10(%ebp)
  801f9e:	ff 75 0c             	pushl  0xc(%ebp)
  801fa1:	50                   	push   %eax
  801fa2:	6a 21                	push   $0x21
  801fa4:	e8 27 fc ff ff       	call   801bd0 <syscall>
  801fa9:	83 c4 18             	add    $0x18,%esp
}
  801fac:	c9                   	leave  
  801fad:	c3                   	ret    

00801fae <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801fae:	55                   	push   %ebp
  801faf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 00                	push   $0x0
  801fbc:	50                   	push   %eax
  801fbd:	6a 22                	push   $0x22
  801fbf:	e8 0c fc ff ff       	call   801bd0 <syscall>
  801fc4:	83 c4 18             	add    $0x18,%esp
}
  801fc7:	90                   	nop
  801fc8:	c9                   	leave  
  801fc9:	c3                   	ret    

00801fca <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801fca:	55                   	push   %ebp
  801fcb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801fcd:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd0:	6a 00                	push   $0x0
  801fd2:	6a 00                	push   $0x0
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 00                	push   $0x0
  801fd8:	50                   	push   %eax
  801fd9:	6a 23                	push   $0x23
  801fdb:	e8 f0 fb ff ff       	call   801bd0 <syscall>
  801fe0:	83 c4 18             	add    $0x18,%esp
}
  801fe3:	90                   	nop
  801fe4:	c9                   	leave  
  801fe5:	c3                   	ret    

00801fe6 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801fe6:	55                   	push   %ebp
  801fe7:	89 e5                	mov    %esp,%ebp
  801fe9:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801fec:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fef:	8d 50 04             	lea    0x4(%eax),%edx
  801ff2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	6a 00                	push   $0x0
  801ffb:	52                   	push   %edx
  801ffc:	50                   	push   %eax
  801ffd:	6a 24                	push   $0x24
  801fff:	e8 cc fb ff ff       	call   801bd0 <syscall>
  802004:	83 c4 18             	add    $0x18,%esp
	return result;
  802007:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80200a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80200d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802010:	89 01                	mov    %eax,(%ecx)
  802012:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802015:	8b 45 08             	mov    0x8(%ebp),%eax
  802018:	c9                   	leave  
  802019:	c2 04 00             	ret    $0x4

0080201c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80201c:	55                   	push   %ebp
  80201d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80201f:	6a 00                	push   $0x0
  802021:	6a 00                	push   $0x0
  802023:	ff 75 10             	pushl  0x10(%ebp)
  802026:	ff 75 0c             	pushl  0xc(%ebp)
  802029:	ff 75 08             	pushl  0x8(%ebp)
  80202c:	6a 13                	push   $0x13
  80202e:	e8 9d fb ff ff       	call   801bd0 <syscall>
  802033:	83 c4 18             	add    $0x18,%esp
	return ;
  802036:	90                   	nop
}
  802037:	c9                   	leave  
  802038:	c3                   	ret    

00802039 <sys_rcr2>:
uint32 sys_rcr2()
{
  802039:	55                   	push   %ebp
  80203a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80203c:	6a 00                	push   $0x0
  80203e:	6a 00                	push   $0x0
  802040:	6a 00                	push   $0x0
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	6a 25                	push   $0x25
  802048:	e8 83 fb ff ff       	call   801bd0 <syscall>
  80204d:	83 c4 18             	add    $0x18,%esp
}
  802050:	c9                   	leave  
  802051:	c3                   	ret    

00802052 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802052:	55                   	push   %ebp
  802053:	89 e5                	mov    %esp,%ebp
  802055:	83 ec 04             	sub    $0x4,%esp
  802058:	8b 45 08             	mov    0x8(%ebp),%eax
  80205b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80205e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	50                   	push   %eax
  80206b:	6a 26                	push   $0x26
  80206d:	e8 5e fb ff ff       	call   801bd0 <syscall>
  802072:	83 c4 18             	add    $0x18,%esp
	return ;
  802075:	90                   	nop
}
  802076:	c9                   	leave  
  802077:	c3                   	ret    

00802078 <rsttst>:
void rsttst()
{
  802078:	55                   	push   %ebp
  802079:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80207b:	6a 00                	push   $0x0
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	6a 00                	push   $0x0
  802083:	6a 00                	push   $0x0
  802085:	6a 28                	push   $0x28
  802087:	e8 44 fb ff ff       	call   801bd0 <syscall>
  80208c:	83 c4 18             	add    $0x18,%esp
	return ;
  80208f:	90                   	nop
}
  802090:	c9                   	leave  
  802091:	c3                   	ret    

00802092 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802092:	55                   	push   %ebp
  802093:	89 e5                	mov    %esp,%ebp
  802095:	83 ec 04             	sub    $0x4,%esp
  802098:	8b 45 14             	mov    0x14(%ebp),%eax
  80209b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80209e:	8b 55 18             	mov    0x18(%ebp),%edx
  8020a1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020a5:	52                   	push   %edx
  8020a6:	50                   	push   %eax
  8020a7:	ff 75 10             	pushl  0x10(%ebp)
  8020aa:	ff 75 0c             	pushl  0xc(%ebp)
  8020ad:	ff 75 08             	pushl  0x8(%ebp)
  8020b0:	6a 27                	push   $0x27
  8020b2:	e8 19 fb ff ff       	call   801bd0 <syscall>
  8020b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ba:	90                   	nop
}
  8020bb:	c9                   	leave  
  8020bc:	c3                   	ret    

008020bd <chktst>:
void chktst(uint32 n)
{
  8020bd:	55                   	push   %ebp
  8020be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8020c0:	6a 00                	push   $0x0
  8020c2:	6a 00                	push   $0x0
  8020c4:	6a 00                	push   $0x0
  8020c6:	6a 00                	push   $0x0
  8020c8:	ff 75 08             	pushl  0x8(%ebp)
  8020cb:	6a 29                	push   $0x29
  8020cd:	e8 fe fa ff ff       	call   801bd0 <syscall>
  8020d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8020d5:	90                   	nop
}
  8020d6:	c9                   	leave  
  8020d7:	c3                   	ret    

008020d8 <inctst>:

void inctst()
{
  8020d8:	55                   	push   %ebp
  8020d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8020db:	6a 00                	push   $0x0
  8020dd:	6a 00                	push   $0x0
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	6a 00                	push   $0x0
  8020e5:	6a 2a                	push   $0x2a
  8020e7:	e8 e4 fa ff ff       	call   801bd0 <syscall>
  8020ec:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ef:	90                   	nop
}
  8020f0:	c9                   	leave  
  8020f1:	c3                   	ret    

008020f2 <gettst>:
uint32 gettst()
{
  8020f2:	55                   	push   %ebp
  8020f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020f5:	6a 00                	push   $0x0
  8020f7:	6a 00                	push   $0x0
  8020f9:	6a 00                	push   $0x0
  8020fb:	6a 00                	push   $0x0
  8020fd:	6a 00                	push   $0x0
  8020ff:	6a 2b                	push   $0x2b
  802101:	e8 ca fa ff ff       	call   801bd0 <syscall>
  802106:	83 c4 18             	add    $0x18,%esp
}
  802109:	c9                   	leave  
  80210a:	c3                   	ret    

0080210b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80210b:	55                   	push   %ebp
  80210c:	89 e5                	mov    %esp,%ebp
  80210e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	6a 00                	push   $0x0
  802119:	6a 00                	push   $0x0
  80211b:	6a 2c                	push   $0x2c
  80211d:	e8 ae fa ff ff       	call   801bd0 <syscall>
  802122:	83 c4 18             	add    $0x18,%esp
  802125:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802128:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80212c:	75 07                	jne    802135 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80212e:	b8 01 00 00 00       	mov    $0x1,%eax
  802133:	eb 05                	jmp    80213a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802135:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80213a:	c9                   	leave  
  80213b:	c3                   	ret    

0080213c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80213c:	55                   	push   %ebp
  80213d:	89 e5                	mov    %esp,%ebp
  80213f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	6a 00                	push   $0x0
  80214c:	6a 2c                	push   $0x2c
  80214e:	e8 7d fa ff ff       	call   801bd0 <syscall>
  802153:	83 c4 18             	add    $0x18,%esp
  802156:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802159:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80215d:	75 07                	jne    802166 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80215f:	b8 01 00 00 00       	mov    $0x1,%eax
  802164:	eb 05                	jmp    80216b <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802166:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80216b:	c9                   	leave  
  80216c:	c3                   	ret    

0080216d <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80216d:	55                   	push   %ebp
  80216e:	89 e5                	mov    %esp,%ebp
  802170:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802173:	6a 00                	push   $0x0
  802175:	6a 00                	push   $0x0
  802177:	6a 00                	push   $0x0
  802179:	6a 00                	push   $0x0
  80217b:	6a 00                	push   $0x0
  80217d:	6a 2c                	push   $0x2c
  80217f:	e8 4c fa ff ff       	call   801bd0 <syscall>
  802184:	83 c4 18             	add    $0x18,%esp
  802187:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80218a:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80218e:	75 07                	jne    802197 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802190:	b8 01 00 00 00       	mov    $0x1,%eax
  802195:	eb 05                	jmp    80219c <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802197:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80219c:	c9                   	leave  
  80219d:	c3                   	ret    

0080219e <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80219e:	55                   	push   %ebp
  80219f:	89 e5                	mov    %esp,%ebp
  8021a1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	6a 00                	push   $0x0
  8021aa:	6a 00                	push   $0x0
  8021ac:	6a 00                	push   $0x0
  8021ae:	6a 2c                	push   $0x2c
  8021b0:	e8 1b fa ff ff       	call   801bd0 <syscall>
  8021b5:	83 c4 18             	add    $0x18,%esp
  8021b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8021bb:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8021bf:	75 07                	jne    8021c8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8021c1:	b8 01 00 00 00       	mov    $0x1,%eax
  8021c6:	eb 05                	jmp    8021cd <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8021c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021cd:	c9                   	leave  
  8021ce:	c3                   	ret    

008021cf <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8021cf:	55                   	push   %ebp
  8021d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021d2:	6a 00                	push   $0x0
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 00                	push   $0x0
  8021d8:	6a 00                	push   $0x0
  8021da:	ff 75 08             	pushl  0x8(%ebp)
  8021dd:	6a 2d                	push   $0x2d
  8021df:	e8 ec f9 ff ff       	call   801bd0 <syscall>
  8021e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e7:	90                   	nop
}
  8021e8:	c9                   	leave  
  8021e9:	c3                   	ret    
  8021ea:	66 90                	xchg   %ax,%ax

008021ec <__udivdi3>:
  8021ec:	55                   	push   %ebp
  8021ed:	57                   	push   %edi
  8021ee:	56                   	push   %esi
  8021ef:	53                   	push   %ebx
  8021f0:	83 ec 1c             	sub    $0x1c,%esp
  8021f3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021f7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021ff:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802203:	89 ca                	mov    %ecx,%edx
  802205:	89 f8                	mov    %edi,%eax
  802207:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80220b:	85 f6                	test   %esi,%esi
  80220d:	75 2d                	jne    80223c <__udivdi3+0x50>
  80220f:	39 cf                	cmp    %ecx,%edi
  802211:	77 65                	ja     802278 <__udivdi3+0x8c>
  802213:	89 fd                	mov    %edi,%ebp
  802215:	85 ff                	test   %edi,%edi
  802217:	75 0b                	jne    802224 <__udivdi3+0x38>
  802219:	b8 01 00 00 00       	mov    $0x1,%eax
  80221e:	31 d2                	xor    %edx,%edx
  802220:	f7 f7                	div    %edi
  802222:	89 c5                	mov    %eax,%ebp
  802224:	31 d2                	xor    %edx,%edx
  802226:	89 c8                	mov    %ecx,%eax
  802228:	f7 f5                	div    %ebp
  80222a:	89 c1                	mov    %eax,%ecx
  80222c:	89 d8                	mov    %ebx,%eax
  80222e:	f7 f5                	div    %ebp
  802230:	89 cf                	mov    %ecx,%edi
  802232:	89 fa                	mov    %edi,%edx
  802234:	83 c4 1c             	add    $0x1c,%esp
  802237:	5b                   	pop    %ebx
  802238:	5e                   	pop    %esi
  802239:	5f                   	pop    %edi
  80223a:	5d                   	pop    %ebp
  80223b:	c3                   	ret    
  80223c:	39 ce                	cmp    %ecx,%esi
  80223e:	77 28                	ja     802268 <__udivdi3+0x7c>
  802240:	0f bd fe             	bsr    %esi,%edi
  802243:	83 f7 1f             	xor    $0x1f,%edi
  802246:	75 40                	jne    802288 <__udivdi3+0x9c>
  802248:	39 ce                	cmp    %ecx,%esi
  80224a:	72 0a                	jb     802256 <__udivdi3+0x6a>
  80224c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802250:	0f 87 9e 00 00 00    	ja     8022f4 <__udivdi3+0x108>
  802256:	b8 01 00 00 00       	mov    $0x1,%eax
  80225b:	89 fa                	mov    %edi,%edx
  80225d:	83 c4 1c             	add    $0x1c,%esp
  802260:	5b                   	pop    %ebx
  802261:	5e                   	pop    %esi
  802262:	5f                   	pop    %edi
  802263:	5d                   	pop    %ebp
  802264:	c3                   	ret    
  802265:	8d 76 00             	lea    0x0(%esi),%esi
  802268:	31 ff                	xor    %edi,%edi
  80226a:	31 c0                	xor    %eax,%eax
  80226c:	89 fa                	mov    %edi,%edx
  80226e:	83 c4 1c             	add    $0x1c,%esp
  802271:	5b                   	pop    %ebx
  802272:	5e                   	pop    %esi
  802273:	5f                   	pop    %edi
  802274:	5d                   	pop    %ebp
  802275:	c3                   	ret    
  802276:	66 90                	xchg   %ax,%ax
  802278:	89 d8                	mov    %ebx,%eax
  80227a:	f7 f7                	div    %edi
  80227c:	31 ff                	xor    %edi,%edi
  80227e:	89 fa                	mov    %edi,%edx
  802280:	83 c4 1c             	add    $0x1c,%esp
  802283:	5b                   	pop    %ebx
  802284:	5e                   	pop    %esi
  802285:	5f                   	pop    %edi
  802286:	5d                   	pop    %ebp
  802287:	c3                   	ret    
  802288:	bd 20 00 00 00       	mov    $0x20,%ebp
  80228d:	89 eb                	mov    %ebp,%ebx
  80228f:	29 fb                	sub    %edi,%ebx
  802291:	89 f9                	mov    %edi,%ecx
  802293:	d3 e6                	shl    %cl,%esi
  802295:	89 c5                	mov    %eax,%ebp
  802297:	88 d9                	mov    %bl,%cl
  802299:	d3 ed                	shr    %cl,%ebp
  80229b:	89 e9                	mov    %ebp,%ecx
  80229d:	09 f1                	or     %esi,%ecx
  80229f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8022a3:	89 f9                	mov    %edi,%ecx
  8022a5:	d3 e0                	shl    %cl,%eax
  8022a7:	89 c5                	mov    %eax,%ebp
  8022a9:	89 d6                	mov    %edx,%esi
  8022ab:	88 d9                	mov    %bl,%cl
  8022ad:	d3 ee                	shr    %cl,%esi
  8022af:	89 f9                	mov    %edi,%ecx
  8022b1:	d3 e2                	shl    %cl,%edx
  8022b3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022b7:	88 d9                	mov    %bl,%cl
  8022b9:	d3 e8                	shr    %cl,%eax
  8022bb:	09 c2                	or     %eax,%edx
  8022bd:	89 d0                	mov    %edx,%eax
  8022bf:	89 f2                	mov    %esi,%edx
  8022c1:	f7 74 24 0c          	divl   0xc(%esp)
  8022c5:	89 d6                	mov    %edx,%esi
  8022c7:	89 c3                	mov    %eax,%ebx
  8022c9:	f7 e5                	mul    %ebp
  8022cb:	39 d6                	cmp    %edx,%esi
  8022cd:	72 19                	jb     8022e8 <__udivdi3+0xfc>
  8022cf:	74 0b                	je     8022dc <__udivdi3+0xf0>
  8022d1:	89 d8                	mov    %ebx,%eax
  8022d3:	31 ff                	xor    %edi,%edi
  8022d5:	e9 58 ff ff ff       	jmp    802232 <__udivdi3+0x46>
  8022da:	66 90                	xchg   %ax,%ax
  8022dc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022e0:	89 f9                	mov    %edi,%ecx
  8022e2:	d3 e2                	shl    %cl,%edx
  8022e4:	39 c2                	cmp    %eax,%edx
  8022e6:	73 e9                	jae    8022d1 <__udivdi3+0xe5>
  8022e8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022eb:	31 ff                	xor    %edi,%edi
  8022ed:	e9 40 ff ff ff       	jmp    802232 <__udivdi3+0x46>
  8022f2:	66 90                	xchg   %ax,%ax
  8022f4:	31 c0                	xor    %eax,%eax
  8022f6:	e9 37 ff ff ff       	jmp    802232 <__udivdi3+0x46>
  8022fb:	90                   	nop

008022fc <__umoddi3>:
  8022fc:	55                   	push   %ebp
  8022fd:	57                   	push   %edi
  8022fe:	56                   	push   %esi
  8022ff:	53                   	push   %ebx
  802300:	83 ec 1c             	sub    $0x1c,%esp
  802303:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802307:	8b 74 24 34          	mov    0x34(%esp),%esi
  80230b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80230f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802313:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802317:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80231b:	89 f3                	mov    %esi,%ebx
  80231d:	89 fa                	mov    %edi,%edx
  80231f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802323:	89 34 24             	mov    %esi,(%esp)
  802326:	85 c0                	test   %eax,%eax
  802328:	75 1a                	jne    802344 <__umoddi3+0x48>
  80232a:	39 f7                	cmp    %esi,%edi
  80232c:	0f 86 a2 00 00 00    	jbe    8023d4 <__umoddi3+0xd8>
  802332:	89 c8                	mov    %ecx,%eax
  802334:	89 f2                	mov    %esi,%edx
  802336:	f7 f7                	div    %edi
  802338:	89 d0                	mov    %edx,%eax
  80233a:	31 d2                	xor    %edx,%edx
  80233c:	83 c4 1c             	add    $0x1c,%esp
  80233f:	5b                   	pop    %ebx
  802340:	5e                   	pop    %esi
  802341:	5f                   	pop    %edi
  802342:	5d                   	pop    %ebp
  802343:	c3                   	ret    
  802344:	39 f0                	cmp    %esi,%eax
  802346:	0f 87 ac 00 00 00    	ja     8023f8 <__umoddi3+0xfc>
  80234c:	0f bd e8             	bsr    %eax,%ebp
  80234f:	83 f5 1f             	xor    $0x1f,%ebp
  802352:	0f 84 ac 00 00 00    	je     802404 <__umoddi3+0x108>
  802358:	bf 20 00 00 00       	mov    $0x20,%edi
  80235d:	29 ef                	sub    %ebp,%edi
  80235f:	89 fe                	mov    %edi,%esi
  802361:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802365:	89 e9                	mov    %ebp,%ecx
  802367:	d3 e0                	shl    %cl,%eax
  802369:	89 d7                	mov    %edx,%edi
  80236b:	89 f1                	mov    %esi,%ecx
  80236d:	d3 ef                	shr    %cl,%edi
  80236f:	09 c7                	or     %eax,%edi
  802371:	89 e9                	mov    %ebp,%ecx
  802373:	d3 e2                	shl    %cl,%edx
  802375:	89 14 24             	mov    %edx,(%esp)
  802378:	89 d8                	mov    %ebx,%eax
  80237a:	d3 e0                	shl    %cl,%eax
  80237c:	89 c2                	mov    %eax,%edx
  80237e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802382:	d3 e0                	shl    %cl,%eax
  802384:	89 44 24 04          	mov    %eax,0x4(%esp)
  802388:	8b 44 24 08          	mov    0x8(%esp),%eax
  80238c:	89 f1                	mov    %esi,%ecx
  80238e:	d3 e8                	shr    %cl,%eax
  802390:	09 d0                	or     %edx,%eax
  802392:	d3 eb                	shr    %cl,%ebx
  802394:	89 da                	mov    %ebx,%edx
  802396:	f7 f7                	div    %edi
  802398:	89 d3                	mov    %edx,%ebx
  80239a:	f7 24 24             	mull   (%esp)
  80239d:	89 c6                	mov    %eax,%esi
  80239f:	89 d1                	mov    %edx,%ecx
  8023a1:	39 d3                	cmp    %edx,%ebx
  8023a3:	0f 82 87 00 00 00    	jb     802430 <__umoddi3+0x134>
  8023a9:	0f 84 91 00 00 00    	je     802440 <__umoddi3+0x144>
  8023af:	8b 54 24 04          	mov    0x4(%esp),%edx
  8023b3:	29 f2                	sub    %esi,%edx
  8023b5:	19 cb                	sbb    %ecx,%ebx
  8023b7:	89 d8                	mov    %ebx,%eax
  8023b9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8023bd:	d3 e0                	shl    %cl,%eax
  8023bf:	89 e9                	mov    %ebp,%ecx
  8023c1:	d3 ea                	shr    %cl,%edx
  8023c3:	09 d0                	or     %edx,%eax
  8023c5:	89 e9                	mov    %ebp,%ecx
  8023c7:	d3 eb                	shr    %cl,%ebx
  8023c9:	89 da                	mov    %ebx,%edx
  8023cb:	83 c4 1c             	add    $0x1c,%esp
  8023ce:	5b                   	pop    %ebx
  8023cf:	5e                   	pop    %esi
  8023d0:	5f                   	pop    %edi
  8023d1:	5d                   	pop    %ebp
  8023d2:	c3                   	ret    
  8023d3:	90                   	nop
  8023d4:	89 fd                	mov    %edi,%ebp
  8023d6:	85 ff                	test   %edi,%edi
  8023d8:	75 0b                	jne    8023e5 <__umoddi3+0xe9>
  8023da:	b8 01 00 00 00       	mov    $0x1,%eax
  8023df:	31 d2                	xor    %edx,%edx
  8023e1:	f7 f7                	div    %edi
  8023e3:	89 c5                	mov    %eax,%ebp
  8023e5:	89 f0                	mov    %esi,%eax
  8023e7:	31 d2                	xor    %edx,%edx
  8023e9:	f7 f5                	div    %ebp
  8023eb:	89 c8                	mov    %ecx,%eax
  8023ed:	f7 f5                	div    %ebp
  8023ef:	89 d0                	mov    %edx,%eax
  8023f1:	e9 44 ff ff ff       	jmp    80233a <__umoddi3+0x3e>
  8023f6:	66 90                	xchg   %ax,%ax
  8023f8:	89 c8                	mov    %ecx,%eax
  8023fa:	89 f2                	mov    %esi,%edx
  8023fc:	83 c4 1c             	add    $0x1c,%esp
  8023ff:	5b                   	pop    %ebx
  802400:	5e                   	pop    %esi
  802401:	5f                   	pop    %edi
  802402:	5d                   	pop    %ebp
  802403:	c3                   	ret    
  802404:	3b 04 24             	cmp    (%esp),%eax
  802407:	72 06                	jb     80240f <__umoddi3+0x113>
  802409:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80240d:	77 0f                	ja     80241e <__umoddi3+0x122>
  80240f:	89 f2                	mov    %esi,%edx
  802411:	29 f9                	sub    %edi,%ecx
  802413:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802417:	89 14 24             	mov    %edx,(%esp)
  80241a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80241e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802422:	8b 14 24             	mov    (%esp),%edx
  802425:	83 c4 1c             	add    $0x1c,%esp
  802428:	5b                   	pop    %ebx
  802429:	5e                   	pop    %esi
  80242a:	5f                   	pop    %edi
  80242b:	5d                   	pop    %ebp
  80242c:	c3                   	ret    
  80242d:	8d 76 00             	lea    0x0(%esi),%esi
  802430:	2b 04 24             	sub    (%esp),%eax
  802433:	19 fa                	sbb    %edi,%edx
  802435:	89 d1                	mov    %edx,%ecx
  802437:	89 c6                	mov    %eax,%esi
  802439:	e9 71 ff ff ff       	jmp    8023af <__umoddi3+0xb3>
  80243e:	66 90                	xchg   %ax,%ax
  802440:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802444:	72 ea                	jb     802430 <__umoddi3+0x134>
  802446:	89 d9                	mov    %ebx,%ecx
  802448:	e9 62 ff ff ff       	jmp    8023af <__umoddi3+0xb3>
