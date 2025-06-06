
obj/user/quicksort1:     file format elf32-i386


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
  800031:	e8 c9 05 00 00       	call   8005ff <libmain>
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
	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[255] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800049:	e8 f3 1c 00 00       	call   801d41 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 05 1d 00 00       	call   801d5a <sys_calculate_modified_frames>
  800055:	01 d8                	add    %ebx,%eax
  800057:	89 45 f0             	mov    %eax,-0x10(%ebp)

		Iteration++ ;
  80005a:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

	sys_disable_interrupt();
  80005d:	e8 af 1d 00 00       	call   801e11 <sys_disable_interrupt>
		readline("Enter the number of elements: ", Line);
  800062:	83 ec 08             	sub    $0x8,%esp
  800065:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  80006b:	50                   	push   %eax
  80006c:	68 60 24 80 00       	push   $0x802460
  800071:	e8 c1 0f 00 00       	call   801037 <readline>
  800076:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800079:	83 ec 04             	sub    $0x4,%esp
  80007c:	6a 0a                	push   $0xa
  80007e:	6a 00                	push   $0x0
  800080:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800086:	50                   	push   %eax
  800087:	e8 11 15 00 00       	call   80159d <strtol>
  80008c:	83 c4 10             	add    $0x10,%esp
  80008f:	89 45 ec             	mov    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800092:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800095:	c1 e0 02             	shl    $0x2,%eax
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	50                   	push   %eax
  80009c:	e8 de 18 00 00       	call   80197f <malloc>
  8000a1:	83 c4 10             	add    $0x10,%esp
  8000a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
		Elements[NumOfElements] = 10 ;
  8000a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000b4:	01 d0                	add    %edx,%eax
  8000b6:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000bc:	83 ec 0c             	sub    $0xc,%esp
  8000bf:	68 80 24 80 00       	push   $0x802480
  8000c4:	e8 ec 08 00 00       	call   8009b5 <cprintf>
  8000c9:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	68 a3 24 80 00       	push   $0x8024a3
  8000d4:	e8 dc 08 00 00       	call   8009b5 <cprintf>
  8000d9:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000dc:	83 ec 0c             	sub    $0xc,%esp
  8000df:	68 b1 24 80 00       	push   $0x8024b1
  8000e4:	e8 cc 08 00 00       	call   8009b5 <cprintf>
  8000e9:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\nSelect: ") ;
  8000ec:	83 ec 0c             	sub    $0xc,%esp
  8000ef:	68 c0 24 80 00       	push   $0x8024c0
  8000f4:	e8 bc 08 00 00       	call   8009b5 <cprintf>
  8000f9:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  8000fc:	e8 a6 04 00 00       	call   8005a7 <getchar>
  800101:	88 45 e7             	mov    %al,-0x19(%ebp)
		cputchar(Chose);
  800104:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	50                   	push   %eax
  80010c:	e8 4e 04 00 00       	call   80055f <cputchar>
  800111:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	6a 0a                	push   $0xa
  800119:	e8 41 04 00 00       	call   80055f <cputchar>
  80011e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800121:	e8 05 1d 00 00       	call   801e2b <sys_enable_interrupt>
		int  i ;
		switch (Chose)
  800126:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80012a:	83 f8 62             	cmp    $0x62,%eax
  80012d:	74 1d                	je     80014c <_main+0x114>
  80012f:	83 f8 63             	cmp    $0x63,%eax
  800132:	74 2b                	je     80015f <_main+0x127>
  800134:	83 f8 61             	cmp    $0x61,%eax
  800137:	75 39                	jne    800172 <_main+0x13a>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800139:	83 ec 08             	sub    $0x8,%esp
  80013c:	ff 75 ec             	pushl  -0x14(%ebp)
  80013f:	ff 75 e8             	pushl  -0x18(%ebp)
  800142:	e8 e0 02 00 00       	call   800427 <InitializeAscending>
  800147:	83 c4 10             	add    $0x10,%esp
			break ;
  80014a:	eb 37                	jmp    800183 <_main+0x14b>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80014c:	83 ec 08             	sub    $0x8,%esp
  80014f:	ff 75 ec             	pushl  -0x14(%ebp)
  800152:	ff 75 e8             	pushl  -0x18(%ebp)
  800155:	e8 fe 02 00 00       	call   800458 <InitializeDescending>
  80015a:	83 c4 10             	add    $0x10,%esp
			break ;
  80015d:	eb 24                	jmp    800183 <_main+0x14b>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80015f:	83 ec 08             	sub    $0x8,%esp
  800162:	ff 75 ec             	pushl  -0x14(%ebp)
  800165:	ff 75 e8             	pushl  -0x18(%ebp)
  800168:	e8 20 03 00 00       	call   80048d <InitializeSemiRandom>
  80016d:	83 c4 10             	add    $0x10,%esp
			break ;
  800170:	eb 11                	jmp    800183 <_main+0x14b>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800172:	83 ec 08             	sub    $0x8,%esp
  800175:	ff 75 ec             	pushl  -0x14(%ebp)
  800178:	ff 75 e8             	pushl  -0x18(%ebp)
  80017b:	e8 0d 03 00 00       	call   80048d <InitializeSemiRandom>
  800180:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800183:	83 ec 08             	sub    $0x8,%esp
  800186:	ff 75 ec             	pushl  -0x14(%ebp)
  800189:	ff 75 e8             	pushl  -0x18(%ebp)
  80018c:	e8 db 00 00 00       	call   80026c <QuickSort>
  800191:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800194:	83 ec 08             	sub    $0x8,%esp
  800197:	ff 75 ec             	pushl  -0x14(%ebp)
  80019a:	ff 75 e8             	pushl  -0x18(%ebp)
  80019d:	e8 db 01 00 00       	call   80037d <CheckSorted>
  8001a2:	83 c4 10             	add    $0x10,%esp
  8001a5:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001a8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8001ac:	75 14                	jne    8001c2 <_main+0x18a>
  8001ae:	83 ec 04             	sub    $0x4,%esp
  8001b1:	68 d8 24 80 00       	push   $0x8024d8
  8001b6:	6a 42                	push   $0x42
  8001b8:	68 fa 24 80 00       	push   $0x8024fa
  8001bd:	e8 3f 05 00 00       	call   800701 <_panic>
		else
		{ 
			cprintf("\n===============================================\n") ;
  8001c2:	83 ec 0c             	sub    $0xc,%esp
  8001c5:	68 0c 25 80 00       	push   $0x80250c
  8001ca:	e8 e6 07 00 00       	call   8009b5 <cprintf>
  8001cf:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001d2:	83 ec 0c             	sub    $0xc,%esp
  8001d5:	68 40 25 80 00       	push   $0x802540
  8001da:	e8 d6 07 00 00       	call   8009b5 <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  8001e2:	83 ec 0c             	sub    $0xc,%esp
  8001e5:	68 74 25 80 00       	push   $0x802574
  8001ea:	e8 c6 07 00 00       	call   8009b5 <cprintf>
  8001ef:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  8001f2:	83 ec 0c             	sub    $0xc,%esp
  8001f5:	68 a6 25 80 00       	push   $0x8025a6
  8001fa:	e8 b6 07 00 00       	call   8009b5 <cprintf>
  8001ff:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  800202:	83 ec 0c             	sub    $0xc,%esp
  800205:	ff 75 e8             	pushl  -0x18(%ebp)
  800208:	e8 93 18 00 00       	call   801aa0 <free>
  80020d:	83 c4 10             	add    $0x10,%esp

		///========================================================================
	sys_disable_interrupt();
  800210:	e8 fc 1b 00 00       	call   801e11 <sys_disable_interrupt>
		cprintf("Do you want to repeat (y/n): ") ;
  800215:	83 ec 0c             	sub    $0xc,%esp
  800218:	68 bc 25 80 00       	push   $0x8025bc
  80021d:	e8 93 07 00 00       	call   8009b5 <cprintf>
  800222:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  800225:	e8 7d 03 00 00       	call   8005a7 <getchar>
  80022a:	88 45 e7             	mov    %al,-0x19(%ebp)
		cputchar(Chose);
  80022d:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800231:	83 ec 0c             	sub    $0xc,%esp
  800234:	50                   	push   %eax
  800235:	e8 25 03 00 00       	call   80055f <cputchar>
  80023a:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80023d:	83 ec 0c             	sub    $0xc,%esp
  800240:	6a 0a                	push   $0xa
  800242:	e8 18 03 00 00       	call   80055f <cputchar>
  800247:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	6a 0a                	push   $0xa
  80024f:	e8 0b 03 00 00       	call   80055f <cputchar>
  800254:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800257:	e8 cf 1b 00 00       	call   801e2b <sys_enable_interrupt>

	} while (Chose == 'y');
  80025c:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800260:	0f 84 e3 fd ff ff    	je     800049 <_main+0x11>

}
  800266:	90                   	nop
  800267:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80026a:	c9                   	leave  
  80026b:	c3                   	ret    

0080026c <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  80026c:	55                   	push   %ebp
  80026d:	89 e5                	mov    %esp,%ebp
  80026f:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800272:	8b 45 0c             	mov    0xc(%ebp),%eax
  800275:	48                   	dec    %eax
  800276:	50                   	push   %eax
  800277:	6a 00                	push   $0x0
  800279:	ff 75 0c             	pushl  0xc(%ebp)
  80027c:	ff 75 08             	pushl  0x8(%ebp)
  80027f:	e8 06 00 00 00       	call   80028a <QSort>
  800284:	83 c4 10             	add    $0x10,%esp
}
  800287:	90                   	nop
  800288:	c9                   	leave  
  800289:	c3                   	ret    

0080028a <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  80028a:	55                   	push   %ebp
  80028b:	89 e5                	mov    %esp,%ebp
  80028d:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800290:	8b 45 10             	mov    0x10(%ebp),%eax
  800293:	3b 45 14             	cmp    0x14(%ebp),%eax
  800296:	0f 8d de 00 00 00    	jge    80037a <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  80029c:	8b 45 10             	mov    0x10(%ebp),%eax
  80029f:	40                   	inc    %eax
  8002a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8002a6:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002a9:	e9 80 00 00 00       	jmp    80032e <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002ae:	ff 45 f4             	incl   -0xc(%ebp)
  8002b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002b4:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002b7:	7f 2b                	jg     8002e4 <QSort+0x5a>
  8002b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8002bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c6:	01 d0                	add    %edx,%eax
  8002c8:	8b 10                	mov    (%eax),%edx
  8002ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d7:	01 c8                	add    %ecx,%eax
  8002d9:	8b 00                	mov    (%eax),%eax
  8002db:	39 c2                	cmp    %eax,%edx
  8002dd:	7d cf                	jge    8002ae <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002df:	eb 03                	jmp    8002e4 <QSort+0x5a>
  8002e1:	ff 4d f0             	decl   -0x10(%ebp)
  8002e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002e7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002ea:	7e 26                	jle    800312 <QSort+0x88>
  8002ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 d0                	add    %edx,%eax
  8002fb:	8b 10                	mov    (%eax),%edx
  8002fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800300:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800307:	8b 45 08             	mov    0x8(%ebp),%eax
  80030a:	01 c8                	add    %ecx,%eax
  80030c:	8b 00                	mov    (%eax),%eax
  80030e:	39 c2                	cmp    %eax,%edx
  800310:	7e cf                	jle    8002e1 <QSort+0x57>

		if (i <= j)
  800312:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800315:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800318:	7f 14                	jg     80032e <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80031a:	83 ec 04             	sub    $0x4,%esp
  80031d:	ff 75 f0             	pushl  -0x10(%ebp)
  800320:	ff 75 f4             	pushl  -0xc(%ebp)
  800323:	ff 75 08             	pushl  0x8(%ebp)
  800326:	e8 a9 00 00 00       	call   8003d4 <Swap>
  80032b:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  80032e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800331:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800334:	0f 8e 77 ff ff ff    	jle    8002b1 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80033a:	83 ec 04             	sub    $0x4,%esp
  80033d:	ff 75 f0             	pushl  -0x10(%ebp)
  800340:	ff 75 10             	pushl  0x10(%ebp)
  800343:	ff 75 08             	pushl  0x8(%ebp)
  800346:	e8 89 00 00 00       	call   8003d4 <Swap>
  80034b:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80034e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800351:	48                   	dec    %eax
  800352:	50                   	push   %eax
  800353:	ff 75 10             	pushl  0x10(%ebp)
  800356:	ff 75 0c             	pushl  0xc(%ebp)
  800359:	ff 75 08             	pushl  0x8(%ebp)
  80035c:	e8 29 ff ff ff       	call   80028a <QSort>
  800361:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800364:	ff 75 14             	pushl  0x14(%ebp)
  800367:	ff 75 f4             	pushl  -0xc(%ebp)
  80036a:	ff 75 0c             	pushl  0xc(%ebp)
  80036d:	ff 75 08             	pushl  0x8(%ebp)
  800370:	e8 15 ff ff ff       	call   80028a <QSort>
  800375:	83 c4 10             	add    $0x10,%esp
  800378:	eb 01                	jmp    80037b <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  80037a:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  80037b:	c9                   	leave  
  80037c:	c3                   	ret    

0080037d <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80037d:	55                   	push   %ebp
  80037e:	89 e5                	mov    %esp,%ebp
  800380:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800383:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80038a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800391:	eb 33                	jmp    8003c6 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800393:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800396:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80039d:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a0:	01 d0                	add    %edx,%eax
  8003a2:	8b 10                	mov    (%eax),%edx
  8003a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003a7:	40                   	inc    %eax
  8003a8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003af:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b2:	01 c8                	add    %ecx,%eax
  8003b4:	8b 00                	mov    (%eax),%eax
  8003b6:	39 c2                	cmp    %eax,%edx
  8003b8:	7e 09                	jle    8003c3 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003c1:	eb 0c                	jmp    8003cf <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003c3:	ff 45 f8             	incl   -0x8(%ebp)
  8003c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c9:	48                   	dec    %eax
  8003ca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003cd:	7f c4                	jg     800393 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
  8003d7:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e7:	01 d0                	add    %edx,%eax
  8003e9:	8b 00                	mov    (%eax),%eax
  8003eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fb:	01 c2                	add    %eax,%edx
  8003fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800400:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800407:	8b 45 08             	mov    0x8(%ebp),%eax
  80040a:	01 c8                	add    %ecx,%eax
  80040c:	8b 00                	mov    (%eax),%eax
  80040e:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800410:	8b 45 10             	mov    0x10(%ebp),%eax
  800413:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	01 c2                	add    %eax,%edx
  80041f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800422:	89 02                	mov    %eax,(%edx)
}
  800424:	90                   	nop
  800425:	c9                   	leave  
  800426:	c3                   	ret    

00800427 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800427:	55                   	push   %ebp
  800428:	89 e5                	mov    %esp,%ebp
  80042a:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80042d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800434:	eb 17                	jmp    80044d <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800436:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800439:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	01 c2                	add    %eax,%edx
  800445:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800448:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80044a:	ff 45 fc             	incl   -0x4(%ebp)
  80044d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800450:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800453:	7c e1                	jl     800436 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800455:	90                   	nop
  800456:	c9                   	leave  
  800457:	c3                   	ret    

00800458 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800458:	55                   	push   %ebp
  800459:	89 e5                	mov    %esp,%ebp
  80045b:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80045e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800465:	eb 1b                	jmp    800482 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800467:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80046a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800471:	8b 45 08             	mov    0x8(%ebp),%eax
  800474:	01 c2                	add    %eax,%edx
  800476:	8b 45 0c             	mov    0xc(%ebp),%eax
  800479:	2b 45 fc             	sub    -0x4(%ebp),%eax
  80047c:	48                   	dec    %eax
  80047d:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80047f:	ff 45 fc             	incl   -0x4(%ebp)
  800482:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800485:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800488:	7c dd                	jl     800467 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  80048a:	90                   	nop
  80048b:	c9                   	leave  
  80048c:	c3                   	ret    

0080048d <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80048d:	55                   	push   %ebp
  80048e:	89 e5                	mov    %esp,%ebp
  800490:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800493:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800496:	b8 56 55 55 55       	mov    $0x55555556,%eax
  80049b:	f7 e9                	imul   %ecx
  80049d:	c1 f9 1f             	sar    $0x1f,%ecx
  8004a0:	89 d0                	mov    %edx,%eax
  8004a2:	29 c8                	sub    %ecx,%eax
  8004a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004ae:	eb 1e                	jmp    8004ce <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bd:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c3:	99                   	cltd   
  8004c4:	f7 7d f8             	idivl  -0x8(%ebp)
  8004c7:	89 d0                	mov    %edx,%eax
  8004c9:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004cb:	ff 45 fc             	incl   -0x4(%ebp)
  8004ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004d1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004d4:	7c da                	jl     8004b0 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004d6:	90                   	nop
  8004d7:	c9                   	leave  
  8004d8:	c3                   	ret    

008004d9 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004d9:	55                   	push   %ebp
  8004da:	89 e5                	mov    %esp,%ebp
  8004dc:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8004df:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004ed:	eb 42                	jmp    800531 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8004ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004f2:	99                   	cltd   
  8004f3:	f7 7d f0             	idivl  -0x10(%ebp)
  8004f6:	89 d0                	mov    %edx,%eax
  8004f8:	85 c0                	test   %eax,%eax
  8004fa:	75 10                	jne    80050c <PrintElements+0x33>
			cprintf("\n");
  8004fc:	83 ec 0c             	sub    $0xc,%esp
  8004ff:	68 da 25 80 00       	push   $0x8025da
  800504:	e8 ac 04 00 00       	call   8009b5 <cprintf>
  800509:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  80050c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80050f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800516:	8b 45 08             	mov    0x8(%ebp),%eax
  800519:	01 d0                	add    %edx,%eax
  80051b:	8b 00                	mov    (%eax),%eax
  80051d:	83 ec 08             	sub    $0x8,%esp
  800520:	50                   	push   %eax
  800521:	68 dc 25 80 00       	push   $0x8025dc
  800526:	e8 8a 04 00 00       	call   8009b5 <cprintf>
  80052b:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80052e:	ff 45 f4             	incl   -0xc(%ebp)
  800531:	8b 45 0c             	mov    0xc(%ebp),%eax
  800534:	48                   	dec    %eax
  800535:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800538:	7f b5                	jg     8004ef <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80053a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80053d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800544:	8b 45 08             	mov    0x8(%ebp),%eax
  800547:	01 d0                	add    %edx,%eax
  800549:	8b 00                	mov    (%eax),%eax
  80054b:	83 ec 08             	sub    $0x8,%esp
  80054e:	50                   	push   %eax
  80054f:	68 e1 25 80 00       	push   $0x8025e1
  800554:	e8 5c 04 00 00       	call   8009b5 <cprintf>
  800559:	83 c4 10             	add    $0x10,%esp

}
  80055c:	90                   	nop
  80055d:	c9                   	leave  
  80055e:	c3                   	ret    

0080055f <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80055f:	55                   	push   %ebp
  800560:	89 e5                	mov    %esp,%ebp
  800562:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800565:	8b 45 08             	mov    0x8(%ebp),%eax
  800568:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80056b:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80056f:	83 ec 0c             	sub    $0xc,%esp
  800572:	50                   	push   %eax
  800573:	e8 cd 18 00 00       	call   801e45 <sys_cputc>
  800578:	83 c4 10             	add    $0x10,%esp
}
  80057b:	90                   	nop
  80057c:	c9                   	leave  
  80057d:	c3                   	ret    

0080057e <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80057e:	55                   	push   %ebp
  80057f:	89 e5                	mov    %esp,%ebp
  800581:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800584:	e8 88 18 00 00       	call   801e11 <sys_disable_interrupt>
	char c = ch;
  800589:	8b 45 08             	mov    0x8(%ebp),%eax
  80058c:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80058f:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800593:	83 ec 0c             	sub    $0xc,%esp
  800596:	50                   	push   %eax
  800597:	e8 a9 18 00 00       	call   801e45 <sys_cputc>
  80059c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80059f:	e8 87 18 00 00       	call   801e2b <sys_enable_interrupt>
}
  8005a4:	90                   	nop
  8005a5:	c9                   	leave  
  8005a6:	c3                   	ret    

008005a7 <getchar>:

int
getchar(void)
{
  8005a7:	55                   	push   %ebp
  8005a8:	89 e5                	mov    %esp,%ebp
  8005aa:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005b4:	eb 08                	jmp    8005be <getchar+0x17>
	{
		c = sys_cgetc();
  8005b6:	e8 6e 16 00 00       	call   801c29 <sys_cgetc>
  8005bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005c2:	74 f2                	je     8005b6 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005c7:	c9                   	leave  
  8005c8:	c3                   	ret    

008005c9 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005c9:	55                   	push   %ebp
  8005ca:	89 e5                	mov    %esp,%ebp
  8005cc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005cf:	e8 3d 18 00 00       	call   801e11 <sys_disable_interrupt>
	int c=0;
  8005d4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005db:	eb 08                	jmp    8005e5 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005dd:	e8 47 16 00 00       	call   801c29 <sys_cgetc>
  8005e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005e9:	74 f2                	je     8005dd <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005eb:	e8 3b 18 00 00       	call   801e2b <sys_enable_interrupt>
	return c;
  8005f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005f3:	c9                   	leave  
  8005f4:	c3                   	ret    

008005f5 <iscons>:

int iscons(int fdnum)
{
  8005f5:	55                   	push   %ebp
  8005f6:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005f8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005fd:	5d                   	pop    %ebp
  8005fe:	c3                   	ret    

008005ff <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005ff:	55                   	push   %ebp
  800600:	89 e5                	mov    %esp,%ebp
  800602:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800605:	e8 6c 16 00 00       	call   801c76 <sys_getenvindex>
  80060a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80060d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800610:	89 d0                	mov    %edx,%eax
  800612:	01 c0                	add    %eax,%eax
  800614:	01 d0                	add    %edx,%eax
  800616:	c1 e0 02             	shl    $0x2,%eax
  800619:	01 d0                	add    %edx,%eax
  80061b:	c1 e0 06             	shl    $0x6,%eax
  80061e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800623:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800628:	a1 24 30 80 00       	mov    0x803024,%eax
  80062d:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800633:	84 c0                	test   %al,%al
  800635:	74 0f                	je     800646 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800637:	a1 24 30 80 00       	mov    0x803024,%eax
  80063c:	05 f4 02 00 00       	add    $0x2f4,%eax
  800641:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800646:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80064a:	7e 0a                	jle    800656 <libmain+0x57>
		binaryname = argv[0];
  80064c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80064f:	8b 00                	mov    (%eax),%eax
  800651:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800656:	83 ec 08             	sub    $0x8,%esp
  800659:	ff 75 0c             	pushl  0xc(%ebp)
  80065c:	ff 75 08             	pushl  0x8(%ebp)
  80065f:	e8 d4 f9 ff ff       	call   800038 <_main>
  800664:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800667:	e8 a5 17 00 00       	call   801e11 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80066c:	83 ec 0c             	sub    $0xc,%esp
  80066f:	68 00 26 80 00       	push   $0x802600
  800674:	e8 3c 03 00 00       	call   8009b5 <cprintf>
  800679:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80067c:	a1 24 30 80 00       	mov    0x803024,%eax
  800681:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800687:	a1 24 30 80 00       	mov    0x803024,%eax
  80068c:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800692:	83 ec 04             	sub    $0x4,%esp
  800695:	52                   	push   %edx
  800696:	50                   	push   %eax
  800697:	68 28 26 80 00       	push   $0x802628
  80069c:	e8 14 03 00 00       	call   8009b5 <cprintf>
  8006a1:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006a4:	a1 24 30 80 00       	mov    0x803024,%eax
  8006a9:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8006af:	83 ec 08             	sub    $0x8,%esp
  8006b2:	50                   	push   %eax
  8006b3:	68 4d 26 80 00       	push   $0x80264d
  8006b8:	e8 f8 02 00 00       	call   8009b5 <cprintf>
  8006bd:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006c0:	83 ec 0c             	sub    $0xc,%esp
  8006c3:	68 00 26 80 00       	push   $0x802600
  8006c8:	e8 e8 02 00 00       	call   8009b5 <cprintf>
  8006cd:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006d0:	e8 56 17 00 00       	call   801e2b <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006d5:	e8 19 00 00 00       	call   8006f3 <exit>
}
  8006da:	90                   	nop
  8006db:	c9                   	leave  
  8006dc:	c3                   	ret    

008006dd <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006dd:	55                   	push   %ebp
  8006de:	89 e5                	mov    %esp,%ebp
  8006e0:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006e3:	83 ec 0c             	sub    $0xc,%esp
  8006e6:	6a 00                	push   $0x0
  8006e8:	e8 55 15 00 00       	call   801c42 <sys_env_destroy>
  8006ed:	83 c4 10             	add    $0x10,%esp
}
  8006f0:	90                   	nop
  8006f1:	c9                   	leave  
  8006f2:	c3                   	ret    

008006f3 <exit>:

void
exit(void)
{
  8006f3:	55                   	push   %ebp
  8006f4:	89 e5                	mov    %esp,%ebp
  8006f6:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006f9:	e8 aa 15 00 00       	call   801ca8 <sys_env_exit>
}
  8006fe:	90                   	nop
  8006ff:	c9                   	leave  
  800700:	c3                   	ret    

00800701 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800701:	55                   	push   %ebp
  800702:	89 e5                	mov    %esp,%ebp
  800704:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800707:	8d 45 10             	lea    0x10(%ebp),%eax
  80070a:	83 c0 04             	add    $0x4,%eax
  80070d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800710:	a1 34 30 80 00       	mov    0x803034,%eax
  800715:	85 c0                	test   %eax,%eax
  800717:	74 16                	je     80072f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800719:	a1 34 30 80 00       	mov    0x803034,%eax
  80071e:	83 ec 08             	sub    $0x8,%esp
  800721:	50                   	push   %eax
  800722:	68 64 26 80 00       	push   $0x802664
  800727:	e8 89 02 00 00       	call   8009b5 <cprintf>
  80072c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80072f:	a1 00 30 80 00       	mov    0x803000,%eax
  800734:	ff 75 0c             	pushl  0xc(%ebp)
  800737:	ff 75 08             	pushl  0x8(%ebp)
  80073a:	50                   	push   %eax
  80073b:	68 69 26 80 00       	push   $0x802669
  800740:	e8 70 02 00 00       	call   8009b5 <cprintf>
  800745:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800748:	8b 45 10             	mov    0x10(%ebp),%eax
  80074b:	83 ec 08             	sub    $0x8,%esp
  80074e:	ff 75 f4             	pushl  -0xc(%ebp)
  800751:	50                   	push   %eax
  800752:	e8 f3 01 00 00       	call   80094a <vcprintf>
  800757:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80075a:	83 ec 08             	sub    $0x8,%esp
  80075d:	6a 00                	push   $0x0
  80075f:	68 85 26 80 00       	push   $0x802685
  800764:	e8 e1 01 00 00       	call   80094a <vcprintf>
  800769:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80076c:	e8 82 ff ff ff       	call   8006f3 <exit>

	// should not return here
	while (1) ;
  800771:	eb fe                	jmp    800771 <_panic+0x70>

00800773 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800773:	55                   	push   %ebp
  800774:	89 e5                	mov    %esp,%ebp
  800776:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800779:	a1 24 30 80 00       	mov    0x803024,%eax
  80077e:	8b 50 74             	mov    0x74(%eax),%edx
  800781:	8b 45 0c             	mov    0xc(%ebp),%eax
  800784:	39 c2                	cmp    %eax,%edx
  800786:	74 14                	je     80079c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800788:	83 ec 04             	sub    $0x4,%esp
  80078b:	68 88 26 80 00       	push   $0x802688
  800790:	6a 26                	push   $0x26
  800792:	68 d4 26 80 00       	push   $0x8026d4
  800797:	e8 65 ff ff ff       	call   800701 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80079c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007aa:	e9 c2 00 00 00       	jmp    800871 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8007af:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007b2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bc:	01 d0                	add    %edx,%eax
  8007be:	8b 00                	mov    (%eax),%eax
  8007c0:	85 c0                	test   %eax,%eax
  8007c2:	75 08                	jne    8007cc <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007c4:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007c7:	e9 a2 00 00 00       	jmp    80086e <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007cc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007d3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007da:	eb 69                	jmp    800845 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007dc:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e1:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007e7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ea:	89 d0                	mov    %edx,%eax
  8007ec:	01 c0                	add    %eax,%eax
  8007ee:	01 d0                	add    %edx,%eax
  8007f0:	c1 e0 02             	shl    $0x2,%eax
  8007f3:	01 c8                	add    %ecx,%eax
  8007f5:	8a 40 04             	mov    0x4(%eax),%al
  8007f8:	84 c0                	test   %al,%al
  8007fa:	75 46                	jne    800842 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007fc:	a1 24 30 80 00       	mov    0x803024,%eax
  800801:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800807:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80080a:	89 d0                	mov    %edx,%eax
  80080c:	01 c0                	add    %eax,%eax
  80080e:	01 d0                	add    %edx,%eax
  800810:	c1 e0 02             	shl    $0x2,%eax
  800813:	01 c8                	add    %ecx,%eax
  800815:	8b 00                	mov    (%eax),%eax
  800817:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80081a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80081d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800822:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800824:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800827:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80082e:	8b 45 08             	mov    0x8(%ebp),%eax
  800831:	01 c8                	add    %ecx,%eax
  800833:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800835:	39 c2                	cmp    %eax,%edx
  800837:	75 09                	jne    800842 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800839:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800840:	eb 12                	jmp    800854 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800842:	ff 45 e8             	incl   -0x18(%ebp)
  800845:	a1 24 30 80 00       	mov    0x803024,%eax
  80084a:	8b 50 74             	mov    0x74(%eax),%edx
  80084d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800850:	39 c2                	cmp    %eax,%edx
  800852:	77 88                	ja     8007dc <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800854:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800858:	75 14                	jne    80086e <CheckWSWithoutLastIndex+0xfb>
			panic(
  80085a:	83 ec 04             	sub    $0x4,%esp
  80085d:	68 e0 26 80 00       	push   $0x8026e0
  800862:	6a 3a                	push   $0x3a
  800864:	68 d4 26 80 00       	push   $0x8026d4
  800869:	e8 93 fe ff ff       	call   800701 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80086e:	ff 45 f0             	incl   -0x10(%ebp)
  800871:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800874:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800877:	0f 8c 32 ff ff ff    	jl     8007af <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80087d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800884:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80088b:	eb 26                	jmp    8008b3 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80088d:	a1 24 30 80 00       	mov    0x803024,%eax
  800892:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800898:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80089b:	89 d0                	mov    %edx,%eax
  80089d:	01 c0                	add    %eax,%eax
  80089f:	01 d0                	add    %edx,%eax
  8008a1:	c1 e0 02             	shl    $0x2,%eax
  8008a4:	01 c8                	add    %ecx,%eax
  8008a6:	8a 40 04             	mov    0x4(%eax),%al
  8008a9:	3c 01                	cmp    $0x1,%al
  8008ab:	75 03                	jne    8008b0 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8008ad:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008b0:	ff 45 e0             	incl   -0x20(%ebp)
  8008b3:	a1 24 30 80 00       	mov    0x803024,%eax
  8008b8:	8b 50 74             	mov    0x74(%eax),%edx
  8008bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008be:	39 c2                	cmp    %eax,%edx
  8008c0:	77 cb                	ja     80088d <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008c5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008c8:	74 14                	je     8008de <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008ca:	83 ec 04             	sub    $0x4,%esp
  8008cd:	68 34 27 80 00       	push   $0x802734
  8008d2:	6a 44                	push   $0x44
  8008d4:	68 d4 26 80 00       	push   $0x8026d4
  8008d9:	e8 23 fe ff ff       	call   800701 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008de:	90                   	nop
  8008df:	c9                   	leave  
  8008e0:	c3                   	ret    

008008e1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008e1:	55                   	push   %ebp
  8008e2:	89 e5                	mov    %esp,%ebp
  8008e4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ea:	8b 00                	mov    (%eax),%eax
  8008ec:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f2:	89 0a                	mov    %ecx,(%edx)
  8008f4:	8b 55 08             	mov    0x8(%ebp),%edx
  8008f7:	88 d1                	mov    %dl,%cl
  8008f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008fc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800900:	8b 45 0c             	mov    0xc(%ebp),%eax
  800903:	8b 00                	mov    (%eax),%eax
  800905:	3d ff 00 00 00       	cmp    $0xff,%eax
  80090a:	75 2c                	jne    800938 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80090c:	a0 28 30 80 00       	mov    0x803028,%al
  800911:	0f b6 c0             	movzbl %al,%eax
  800914:	8b 55 0c             	mov    0xc(%ebp),%edx
  800917:	8b 12                	mov    (%edx),%edx
  800919:	89 d1                	mov    %edx,%ecx
  80091b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091e:	83 c2 08             	add    $0x8,%edx
  800921:	83 ec 04             	sub    $0x4,%esp
  800924:	50                   	push   %eax
  800925:	51                   	push   %ecx
  800926:	52                   	push   %edx
  800927:	e8 d4 12 00 00       	call   801c00 <sys_cputs>
  80092c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80092f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800932:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800938:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093b:	8b 40 04             	mov    0x4(%eax),%eax
  80093e:	8d 50 01             	lea    0x1(%eax),%edx
  800941:	8b 45 0c             	mov    0xc(%ebp),%eax
  800944:	89 50 04             	mov    %edx,0x4(%eax)
}
  800947:	90                   	nop
  800948:	c9                   	leave  
  800949:	c3                   	ret    

0080094a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80094a:	55                   	push   %ebp
  80094b:	89 e5                	mov    %esp,%ebp
  80094d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800953:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80095a:	00 00 00 
	b.cnt = 0;
  80095d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800964:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800967:	ff 75 0c             	pushl  0xc(%ebp)
  80096a:	ff 75 08             	pushl  0x8(%ebp)
  80096d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800973:	50                   	push   %eax
  800974:	68 e1 08 80 00       	push   $0x8008e1
  800979:	e8 11 02 00 00       	call   800b8f <vprintfmt>
  80097e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800981:	a0 28 30 80 00       	mov    0x803028,%al
  800986:	0f b6 c0             	movzbl %al,%eax
  800989:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80098f:	83 ec 04             	sub    $0x4,%esp
  800992:	50                   	push   %eax
  800993:	52                   	push   %edx
  800994:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80099a:	83 c0 08             	add    $0x8,%eax
  80099d:	50                   	push   %eax
  80099e:	e8 5d 12 00 00       	call   801c00 <sys_cputs>
  8009a3:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009a6:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009ad:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009b3:	c9                   	leave  
  8009b4:	c3                   	ret    

008009b5 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009b5:	55                   	push   %ebp
  8009b6:	89 e5                	mov    %esp,%ebp
  8009b8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009bb:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009c2:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cb:	83 ec 08             	sub    $0x8,%esp
  8009ce:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d1:	50                   	push   %eax
  8009d2:	e8 73 ff ff ff       	call   80094a <vcprintf>
  8009d7:	83 c4 10             	add    $0x10,%esp
  8009da:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009e0:	c9                   	leave  
  8009e1:	c3                   	ret    

008009e2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009e2:	55                   	push   %ebp
  8009e3:	89 e5                	mov    %esp,%ebp
  8009e5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009e8:	e8 24 14 00 00       	call   801e11 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009ed:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f6:	83 ec 08             	sub    $0x8,%esp
  8009f9:	ff 75 f4             	pushl  -0xc(%ebp)
  8009fc:	50                   	push   %eax
  8009fd:	e8 48 ff ff ff       	call   80094a <vcprintf>
  800a02:	83 c4 10             	add    $0x10,%esp
  800a05:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a08:	e8 1e 14 00 00       	call   801e2b <sys_enable_interrupt>
	return cnt;
  800a0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a10:	c9                   	leave  
  800a11:	c3                   	ret    

00800a12 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a12:	55                   	push   %ebp
  800a13:	89 e5                	mov    %esp,%ebp
  800a15:	53                   	push   %ebx
  800a16:	83 ec 14             	sub    $0x14,%esp
  800a19:	8b 45 10             	mov    0x10(%ebp),%eax
  800a1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a1f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a22:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a25:	8b 45 18             	mov    0x18(%ebp),%eax
  800a28:	ba 00 00 00 00       	mov    $0x0,%edx
  800a2d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a30:	77 55                	ja     800a87 <printnum+0x75>
  800a32:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a35:	72 05                	jb     800a3c <printnum+0x2a>
  800a37:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a3a:	77 4b                	ja     800a87 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a3c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a3f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a42:	8b 45 18             	mov    0x18(%ebp),%eax
  800a45:	ba 00 00 00 00       	mov    $0x0,%edx
  800a4a:	52                   	push   %edx
  800a4b:	50                   	push   %eax
  800a4c:	ff 75 f4             	pushl  -0xc(%ebp)
  800a4f:	ff 75 f0             	pushl  -0x10(%ebp)
  800a52:	e8 99 17 00 00       	call   8021f0 <__udivdi3>
  800a57:	83 c4 10             	add    $0x10,%esp
  800a5a:	83 ec 04             	sub    $0x4,%esp
  800a5d:	ff 75 20             	pushl  0x20(%ebp)
  800a60:	53                   	push   %ebx
  800a61:	ff 75 18             	pushl  0x18(%ebp)
  800a64:	52                   	push   %edx
  800a65:	50                   	push   %eax
  800a66:	ff 75 0c             	pushl  0xc(%ebp)
  800a69:	ff 75 08             	pushl  0x8(%ebp)
  800a6c:	e8 a1 ff ff ff       	call   800a12 <printnum>
  800a71:	83 c4 20             	add    $0x20,%esp
  800a74:	eb 1a                	jmp    800a90 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a76:	83 ec 08             	sub    $0x8,%esp
  800a79:	ff 75 0c             	pushl  0xc(%ebp)
  800a7c:	ff 75 20             	pushl  0x20(%ebp)
  800a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a82:	ff d0                	call   *%eax
  800a84:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a87:	ff 4d 1c             	decl   0x1c(%ebp)
  800a8a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a8e:	7f e6                	jg     800a76 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a90:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a93:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a98:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a9b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a9e:	53                   	push   %ebx
  800a9f:	51                   	push   %ecx
  800aa0:	52                   	push   %edx
  800aa1:	50                   	push   %eax
  800aa2:	e8 59 18 00 00       	call   802300 <__umoddi3>
  800aa7:	83 c4 10             	add    $0x10,%esp
  800aaa:	05 94 29 80 00       	add    $0x802994,%eax
  800aaf:	8a 00                	mov    (%eax),%al
  800ab1:	0f be c0             	movsbl %al,%eax
  800ab4:	83 ec 08             	sub    $0x8,%esp
  800ab7:	ff 75 0c             	pushl  0xc(%ebp)
  800aba:	50                   	push   %eax
  800abb:	8b 45 08             	mov    0x8(%ebp),%eax
  800abe:	ff d0                	call   *%eax
  800ac0:	83 c4 10             	add    $0x10,%esp
}
  800ac3:	90                   	nop
  800ac4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ac7:	c9                   	leave  
  800ac8:	c3                   	ret    

00800ac9 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ac9:	55                   	push   %ebp
  800aca:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800acc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ad0:	7e 1c                	jle    800aee <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad5:	8b 00                	mov    (%eax),%eax
  800ad7:	8d 50 08             	lea    0x8(%eax),%edx
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	89 10                	mov    %edx,(%eax)
  800adf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae2:	8b 00                	mov    (%eax),%eax
  800ae4:	83 e8 08             	sub    $0x8,%eax
  800ae7:	8b 50 04             	mov    0x4(%eax),%edx
  800aea:	8b 00                	mov    (%eax),%eax
  800aec:	eb 40                	jmp    800b2e <getuint+0x65>
	else if (lflag)
  800aee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800af2:	74 1e                	je     800b12 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800af4:	8b 45 08             	mov    0x8(%ebp),%eax
  800af7:	8b 00                	mov    (%eax),%eax
  800af9:	8d 50 04             	lea    0x4(%eax),%edx
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	89 10                	mov    %edx,(%eax)
  800b01:	8b 45 08             	mov    0x8(%ebp),%eax
  800b04:	8b 00                	mov    (%eax),%eax
  800b06:	83 e8 04             	sub    $0x4,%eax
  800b09:	8b 00                	mov    (%eax),%eax
  800b0b:	ba 00 00 00 00       	mov    $0x0,%edx
  800b10:	eb 1c                	jmp    800b2e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	8b 00                	mov    (%eax),%eax
  800b17:	8d 50 04             	lea    0x4(%eax),%edx
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	89 10                	mov    %edx,(%eax)
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	8b 00                	mov    (%eax),%eax
  800b24:	83 e8 04             	sub    $0x4,%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b2e:	5d                   	pop    %ebp
  800b2f:	c3                   	ret    

00800b30 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b30:	55                   	push   %ebp
  800b31:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b33:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b37:	7e 1c                	jle    800b55 <getint+0x25>
		return va_arg(*ap, long long);
  800b39:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3c:	8b 00                	mov    (%eax),%eax
  800b3e:	8d 50 08             	lea    0x8(%eax),%edx
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
  800b44:	89 10                	mov    %edx,(%eax)
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
  800b49:	8b 00                	mov    (%eax),%eax
  800b4b:	83 e8 08             	sub    $0x8,%eax
  800b4e:	8b 50 04             	mov    0x4(%eax),%edx
  800b51:	8b 00                	mov    (%eax),%eax
  800b53:	eb 38                	jmp    800b8d <getint+0x5d>
	else if (lflag)
  800b55:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b59:	74 1a                	je     800b75 <getint+0x45>
		return va_arg(*ap, long);
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	8b 00                	mov    (%eax),%eax
  800b60:	8d 50 04             	lea    0x4(%eax),%edx
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	89 10                	mov    %edx,(%eax)
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	8b 00                	mov    (%eax),%eax
  800b6d:	83 e8 04             	sub    $0x4,%eax
  800b70:	8b 00                	mov    (%eax),%eax
  800b72:	99                   	cltd   
  800b73:	eb 18                	jmp    800b8d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	8b 00                	mov    (%eax),%eax
  800b7a:	8d 50 04             	lea    0x4(%eax),%edx
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	89 10                	mov    %edx,(%eax)
  800b82:	8b 45 08             	mov    0x8(%ebp),%eax
  800b85:	8b 00                	mov    (%eax),%eax
  800b87:	83 e8 04             	sub    $0x4,%eax
  800b8a:	8b 00                	mov    (%eax),%eax
  800b8c:	99                   	cltd   
}
  800b8d:	5d                   	pop    %ebp
  800b8e:	c3                   	ret    

00800b8f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b8f:	55                   	push   %ebp
  800b90:	89 e5                	mov    %esp,%ebp
  800b92:	56                   	push   %esi
  800b93:	53                   	push   %ebx
  800b94:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b97:	eb 17                	jmp    800bb0 <vprintfmt+0x21>
			if (ch == '\0')
  800b99:	85 db                	test   %ebx,%ebx
  800b9b:	0f 84 af 03 00 00    	je     800f50 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ba1:	83 ec 08             	sub    $0x8,%esp
  800ba4:	ff 75 0c             	pushl  0xc(%ebp)
  800ba7:	53                   	push   %ebx
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	ff d0                	call   *%eax
  800bad:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb3:	8d 50 01             	lea    0x1(%eax),%edx
  800bb6:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb9:	8a 00                	mov    (%eax),%al
  800bbb:	0f b6 d8             	movzbl %al,%ebx
  800bbe:	83 fb 25             	cmp    $0x25,%ebx
  800bc1:	75 d6                	jne    800b99 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bc3:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bc7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bce:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bd5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bdc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800be3:	8b 45 10             	mov    0x10(%ebp),%eax
  800be6:	8d 50 01             	lea    0x1(%eax),%edx
  800be9:	89 55 10             	mov    %edx,0x10(%ebp)
  800bec:	8a 00                	mov    (%eax),%al
  800bee:	0f b6 d8             	movzbl %al,%ebx
  800bf1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bf4:	83 f8 55             	cmp    $0x55,%eax
  800bf7:	0f 87 2b 03 00 00    	ja     800f28 <vprintfmt+0x399>
  800bfd:	8b 04 85 b8 29 80 00 	mov    0x8029b8(,%eax,4),%eax
  800c04:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c06:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c0a:	eb d7                	jmp    800be3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c0c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c10:	eb d1                	jmp    800be3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c12:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c19:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c1c:	89 d0                	mov    %edx,%eax
  800c1e:	c1 e0 02             	shl    $0x2,%eax
  800c21:	01 d0                	add    %edx,%eax
  800c23:	01 c0                	add    %eax,%eax
  800c25:	01 d8                	add    %ebx,%eax
  800c27:	83 e8 30             	sub    $0x30,%eax
  800c2a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c30:	8a 00                	mov    (%eax),%al
  800c32:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c35:	83 fb 2f             	cmp    $0x2f,%ebx
  800c38:	7e 3e                	jle    800c78 <vprintfmt+0xe9>
  800c3a:	83 fb 39             	cmp    $0x39,%ebx
  800c3d:	7f 39                	jg     800c78 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c3f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c42:	eb d5                	jmp    800c19 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c44:	8b 45 14             	mov    0x14(%ebp),%eax
  800c47:	83 c0 04             	add    $0x4,%eax
  800c4a:	89 45 14             	mov    %eax,0x14(%ebp)
  800c4d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c50:	83 e8 04             	sub    $0x4,%eax
  800c53:	8b 00                	mov    (%eax),%eax
  800c55:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c58:	eb 1f                	jmp    800c79 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c5a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c5e:	79 83                	jns    800be3 <vprintfmt+0x54>
				width = 0;
  800c60:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c67:	e9 77 ff ff ff       	jmp    800be3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c6c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c73:	e9 6b ff ff ff       	jmp    800be3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c78:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c79:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c7d:	0f 89 60 ff ff ff    	jns    800be3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c83:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c86:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c89:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c90:	e9 4e ff ff ff       	jmp    800be3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c95:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c98:	e9 46 ff ff ff       	jmp    800be3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c9d:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca0:	83 c0 04             	add    $0x4,%eax
  800ca3:	89 45 14             	mov    %eax,0x14(%ebp)
  800ca6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca9:	83 e8 04             	sub    $0x4,%eax
  800cac:	8b 00                	mov    (%eax),%eax
  800cae:	83 ec 08             	sub    $0x8,%esp
  800cb1:	ff 75 0c             	pushl  0xc(%ebp)
  800cb4:	50                   	push   %eax
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	ff d0                	call   *%eax
  800cba:	83 c4 10             	add    $0x10,%esp
			break;
  800cbd:	e9 89 02 00 00       	jmp    800f4b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cc2:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc5:	83 c0 04             	add    $0x4,%eax
  800cc8:	89 45 14             	mov    %eax,0x14(%ebp)
  800ccb:	8b 45 14             	mov    0x14(%ebp),%eax
  800cce:	83 e8 04             	sub    $0x4,%eax
  800cd1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cd3:	85 db                	test   %ebx,%ebx
  800cd5:	79 02                	jns    800cd9 <vprintfmt+0x14a>
				err = -err;
  800cd7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cd9:	83 fb 64             	cmp    $0x64,%ebx
  800cdc:	7f 0b                	jg     800ce9 <vprintfmt+0x15a>
  800cde:	8b 34 9d 00 28 80 00 	mov    0x802800(,%ebx,4),%esi
  800ce5:	85 f6                	test   %esi,%esi
  800ce7:	75 19                	jne    800d02 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ce9:	53                   	push   %ebx
  800cea:	68 a5 29 80 00       	push   $0x8029a5
  800cef:	ff 75 0c             	pushl  0xc(%ebp)
  800cf2:	ff 75 08             	pushl  0x8(%ebp)
  800cf5:	e8 5e 02 00 00       	call   800f58 <printfmt>
  800cfa:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cfd:	e9 49 02 00 00       	jmp    800f4b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d02:	56                   	push   %esi
  800d03:	68 ae 29 80 00       	push   $0x8029ae
  800d08:	ff 75 0c             	pushl  0xc(%ebp)
  800d0b:	ff 75 08             	pushl  0x8(%ebp)
  800d0e:	e8 45 02 00 00       	call   800f58 <printfmt>
  800d13:	83 c4 10             	add    $0x10,%esp
			break;
  800d16:	e9 30 02 00 00       	jmp    800f4b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d1b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1e:	83 c0 04             	add    $0x4,%eax
  800d21:	89 45 14             	mov    %eax,0x14(%ebp)
  800d24:	8b 45 14             	mov    0x14(%ebp),%eax
  800d27:	83 e8 04             	sub    $0x4,%eax
  800d2a:	8b 30                	mov    (%eax),%esi
  800d2c:	85 f6                	test   %esi,%esi
  800d2e:	75 05                	jne    800d35 <vprintfmt+0x1a6>
				p = "(null)";
  800d30:	be b1 29 80 00       	mov    $0x8029b1,%esi
			if (width > 0 && padc != '-')
  800d35:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d39:	7e 6d                	jle    800da8 <vprintfmt+0x219>
  800d3b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d3f:	74 67                	je     800da8 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d41:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d44:	83 ec 08             	sub    $0x8,%esp
  800d47:	50                   	push   %eax
  800d48:	56                   	push   %esi
  800d49:	e8 12 05 00 00       	call   801260 <strnlen>
  800d4e:	83 c4 10             	add    $0x10,%esp
  800d51:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d54:	eb 16                	jmp    800d6c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d56:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d5a:	83 ec 08             	sub    $0x8,%esp
  800d5d:	ff 75 0c             	pushl  0xc(%ebp)
  800d60:	50                   	push   %eax
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	ff d0                	call   *%eax
  800d66:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d69:	ff 4d e4             	decl   -0x1c(%ebp)
  800d6c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d70:	7f e4                	jg     800d56 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d72:	eb 34                	jmp    800da8 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d74:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d78:	74 1c                	je     800d96 <vprintfmt+0x207>
  800d7a:	83 fb 1f             	cmp    $0x1f,%ebx
  800d7d:	7e 05                	jle    800d84 <vprintfmt+0x1f5>
  800d7f:	83 fb 7e             	cmp    $0x7e,%ebx
  800d82:	7e 12                	jle    800d96 <vprintfmt+0x207>
					putch('?', putdat);
  800d84:	83 ec 08             	sub    $0x8,%esp
  800d87:	ff 75 0c             	pushl  0xc(%ebp)
  800d8a:	6a 3f                	push   $0x3f
  800d8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8f:	ff d0                	call   *%eax
  800d91:	83 c4 10             	add    $0x10,%esp
  800d94:	eb 0f                	jmp    800da5 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d96:	83 ec 08             	sub    $0x8,%esp
  800d99:	ff 75 0c             	pushl  0xc(%ebp)
  800d9c:	53                   	push   %ebx
  800d9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800da0:	ff d0                	call   *%eax
  800da2:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800da5:	ff 4d e4             	decl   -0x1c(%ebp)
  800da8:	89 f0                	mov    %esi,%eax
  800daa:	8d 70 01             	lea    0x1(%eax),%esi
  800dad:	8a 00                	mov    (%eax),%al
  800daf:	0f be d8             	movsbl %al,%ebx
  800db2:	85 db                	test   %ebx,%ebx
  800db4:	74 24                	je     800dda <vprintfmt+0x24b>
  800db6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dba:	78 b8                	js     800d74 <vprintfmt+0x1e5>
  800dbc:	ff 4d e0             	decl   -0x20(%ebp)
  800dbf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dc3:	79 af                	jns    800d74 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dc5:	eb 13                	jmp    800dda <vprintfmt+0x24b>
				putch(' ', putdat);
  800dc7:	83 ec 08             	sub    $0x8,%esp
  800dca:	ff 75 0c             	pushl  0xc(%ebp)
  800dcd:	6a 20                	push   $0x20
  800dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd2:	ff d0                	call   *%eax
  800dd4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dd7:	ff 4d e4             	decl   -0x1c(%ebp)
  800dda:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dde:	7f e7                	jg     800dc7 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800de0:	e9 66 01 00 00       	jmp    800f4b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800de5:	83 ec 08             	sub    $0x8,%esp
  800de8:	ff 75 e8             	pushl  -0x18(%ebp)
  800deb:	8d 45 14             	lea    0x14(%ebp),%eax
  800dee:	50                   	push   %eax
  800def:	e8 3c fd ff ff       	call   800b30 <getint>
  800df4:	83 c4 10             	add    $0x10,%esp
  800df7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dfa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dfd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e00:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e03:	85 d2                	test   %edx,%edx
  800e05:	79 23                	jns    800e2a <vprintfmt+0x29b>
				putch('-', putdat);
  800e07:	83 ec 08             	sub    $0x8,%esp
  800e0a:	ff 75 0c             	pushl  0xc(%ebp)
  800e0d:	6a 2d                	push   $0x2d
  800e0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e12:	ff d0                	call   *%eax
  800e14:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e17:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e1d:	f7 d8                	neg    %eax
  800e1f:	83 d2 00             	adc    $0x0,%edx
  800e22:	f7 da                	neg    %edx
  800e24:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e27:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e2a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e31:	e9 bc 00 00 00       	jmp    800ef2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e36:	83 ec 08             	sub    $0x8,%esp
  800e39:	ff 75 e8             	pushl  -0x18(%ebp)
  800e3c:	8d 45 14             	lea    0x14(%ebp),%eax
  800e3f:	50                   	push   %eax
  800e40:	e8 84 fc ff ff       	call   800ac9 <getuint>
  800e45:	83 c4 10             	add    $0x10,%esp
  800e48:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e4b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e4e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e55:	e9 98 00 00 00       	jmp    800ef2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e5a:	83 ec 08             	sub    $0x8,%esp
  800e5d:	ff 75 0c             	pushl  0xc(%ebp)
  800e60:	6a 58                	push   $0x58
  800e62:	8b 45 08             	mov    0x8(%ebp),%eax
  800e65:	ff d0                	call   *%eax
  800e67:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e6a:	83 ec 08             	sub    $0x8,%esp
  800e6d:	ff 75 0c             	pushl  0xc(%ebp)
  800e70:	6a 58                	push   $0x58
  800e72:	8b 45 08             	mov    0x8(%ebp),%eax
  800e75:	ff d0                	call   *%eax
  800e77:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e7a:	83 ec 08             	sub    $0x8,%esp
  800e7d:	ff 75 0c             	pushl  0xc(%ebp)
  800e80:	6a 58                	push   $0x58
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	ff d0                	call   *%eax
  800e87:	83 c4 10             	add    $0x10,%esp
			break;
  800e8a:	e9 bc 00 00 00       	jmp    800f4b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e8f:	83 ec 08             	sub    $0x8,%esp
  800e92:	ff 75 0c             	pushl  0xc(%ebp)
  800e95:	6a 30                	push   $0x30
  800e97:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9a:	ff d0                	call   *%eax
  800e9c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e9f:	83 ec 08             	sub    $0x8,%esp
  800ea2:	ff 75 0c             	pushl  0xc(%ebp)
  800ea5:	6a 78                	push   $0x78
  800ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaa:	ff d0                	call   *%eax
  800eac:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800eaf:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb2:	83 c0 04             	add    $0x4,%eax
  800eb5:	89 45 14             	mov    %eax,0x14(%ebp)
  800eb8:	8b 45 14             	mov    0x14(%ebp),%eax
  800ebb:	83 e8 04             	sub    $0x4,%eax
  800ebe:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ec0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ec3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800eca:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ed1:	eb 1f                	jmp    800ef2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ed3:	83 ec 08             	sub    $0x8,%esp
  800ed6:	ff 75 e8             	pushl  -0x18(%ebp)
  800ed9:	8d 45 14             	lea    0x14(%ebp),%eax
  800edc:	50                   	push   %eax
  800edd:	e8 e7 fb ff ff       	call   800ac9 <getuint>
  800ee2:	83 c4 10             	add    $0x10,%esp
  800ee5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ee8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800eeb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ef2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ef6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ef9:	83 ec 04             	sub    $0x4,%esp
  800efc:	52                   	push   %edx
  800efd:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f00:	50                   	push   %eax
  800f01:	ff 75 f4             	pushl  -0xc(%ebp)
  800f04:	ff 75 f0             	pushl  -0x10(%ebp)
  800f07:	ff 75 0c             	pushl  0xc(%ebp)
  800f0a:	ff 75 08             	pushl  0x8(%ebp)
  800f0d:	e8 00 fb ff ff       	call   800a12 <printnum>
  800f12:	83 c4 20             	add    $0x20,%esp
			break;
  800f15:	eb 34                	jmp    800f4b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f17:	83 ec 08             	sub    $0x8,%esp
  800f1a:	ff 75 0c             	pushl  0xc(%ebp)
  800f1d:	53                   	push   %ebx
  800f1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f21:	ff d0                	call   *%eax
  800f23:	83 c4 10             	add    $0x10,%esp
			break;
  800f26:	eb 23                	jmp    800f4b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f28:	83 ec 08             	sub    $0x8,%esp
  800f2b:	ff 75 0c             	pushl  0xc(%ebp)
  800f2e:	6a 25                	push   $0x25
  800f30:	8b 45 08             	mov    0x8(%ebp),%eax
  800f33:	ff d0                	call   *%eax
  800f35:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f38:	ff 4d 10             	decl   0x10(%ebp)
  800f3b:	eb 03                	jmp    800f40 <vprintfmt+0x3b1>
  800f3d:	ff 4d 10             	decl   0x10(%ebp)
  800f40:	8b 45 10             	mov    0x10(%ebp),%eax
  800f43:	48                   	dec    %eax
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	3c 25                	cmp    $0x25,%al
  800f48:	75 f3                	jne    800f3d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f4a:	90                   	nop
		}
	}
  800f4b:	e9 47 fc ff ff       	jmp    800b97 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f50:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f51:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f54:	5b                   	pop    %ebx
  800f55:	5e                   	pop    %esi
  800f56:	5d                   	pop    %ebp
  800f57:	c3                   	ret    

00800f58 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f58:	55                   	push   %ebp
  800f59:	89 e5                	mov    %esp,%ebp
  800f5b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f5e:	8d 45 10             	lea    0x10(%ebp),%eax
  800f61:	83 c0 04             	add    $0x4,%eax
  800f64:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f67:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6a:	ff 75 f4             	pushl  -0xc(%ebp)
  800f6d:	50                   	push   %eax
  800f6e:	ff 75 0c             	pushl  0xc(%ebp)
  800f71:	ff 75 08             	pushl  0x8(%ebp)
  800f74:	e8 16 fc ff ff       	call   800b8f <vprintfmt>
  800f79:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f7c:	90                   	nop
  800f7d:	c9                   	leave  
  800f7e:	c3                   	ret    

00800f7f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f7f:	55                   	push   %ebp
  800f80:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f85:	8b 40 08             	mov    0x8(%eax),%eax
  800f88:	8d 50 01             	lea    0x1(%eax),%edx
  800f8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f94:	8b 10                	mov    (%eax),%edx
  800f96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f99:	8b 40 04             	mov    0x4(%eax),%eax
  800f9c:	39 c2                	cmp    %eax,%edx
  800f9e:	73 12                	jae    800fb2 <sprintputch+0x33>
		*b->buf++ = ch;
  800fa0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa3:	8b 00                	mov    (%eax),%eax
  800fa5:	8d 48 01             	lea    0x1(%eax),%ecx
  800fa8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fab:	89 0a                	mov    %ecx,(%edx)
  800fad:	8b 55 08             	mov    0x8(%ebp),%edx
  800fb0:	88 10                	mov    %dl,(%eax)
}
  800fb2:	90                   	nop
  800fb3:	5d                   	pop    %ebp
  800fb4:	c3                   	ret    

00800fb5 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fb5:	55                   	push   %ebp
  800fb6:	89 e5                	mov    %esp,%ebp
  800fb8:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	01 d0                	add    %edx,%eax
  800fcc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fcf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fd6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fda:	74 06                	je     800fe2 <vsnprintf+0x2d>
  800fdc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fe0:	7f 07                	jg     800fe9 <vsnprintf+0x34>
		return -E_INVAL;
  800fe2:	b8 03 00 00 00       	mov    $0x3,%eax
  800fe7:	eb 20                	jmp    801009 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fe9:	ff 75 14             	pushl  0x14(%ebp)
  800fec:	ff 75 10             	pushl  0x10(%ebp)
  800fef:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ff2:	50                   	push   %eax
  800ff3:	68 7f 0f 80 00       	push   $0x800f7f
  800ff8:	e8 92 fb ff ff       	call   800b8f <vprintfmt>
  800ffd:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801000:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801003:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801006:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801009:	c9                   	leave  
  80100a:	c3                   	ret    

0080100b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80100b:	55                   	push   %ebp
  80100c:	89 e5                	mov    %esp,%ebp
  80100e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801011:	8d 45 10             	lea    0x10(%ebp),%eax
  801014:	83 c0 04             	add    $0x4,%eax
  801017:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80101a:	8b 45 10             	mov    0x10(%ebp),%eax
  80101d:	ff 75 f4             	pushl  -0xc(%ebp)
  801020:	50                   	push   %eax
  801021:	ff 75 0c             	pushl  0xc(%ebp)
  801024:	ff 75 08             	pushl  0x8(%ebp)
  801027:	e8 89 ff ff ff       	call   800fb5 <vsnprintf>
  80102c:	83 c4 10             	add    $0x10,%esp
  80102f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801032:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801035:	c9                   	leave  
  801036:	c3                   	ret    

00801037 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801037:	55                   	push   %ebp
  801038:	89 e5                	mov    %esp,%ebp
  80103a:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80103d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801041:	74 13                	je     801056 <readline+0x1f>
		cprintf("%s", prompt);
  801043:	83 ec 08             	sub    $0x8,%esp
  801046:	ff 75 08             	pushl  0x8(%ebp)
  801049:	68 10 2b 80 00       	push   $0x802b10
  80104e:	e8 62 f9 ff ff       	call   8009b5 <cprintf>
  801053:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801056:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80105d:	83 ec 0c             	sub    $0xc,%esp
  801060:	6a 00                	push   $0x0
  801062:	e8 8e f5 ff ff       	call   8005f5 <iscons>
  801067:	83 c4 10             	add    $0x10,%esp
  80106a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80106d:	e8 35 f5 ff ff       	call   8005a7 <getchar>
  801072:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801075:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801079:	79 22                	jns    80109d <readline+0x66>
			if (c != -E_EOF)
  80107b:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80107f:	0f 84 ad 00 00 00    	je     801132 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801085:	83 ec 08             	sub    $0x8,%esp
  801088:	ff 75 ec             	pushl  -0x14(%ebp)
  80108b:	68 13 2b 80 00       	push   $0x802b13
  801090:	e8 20 f9 ff ff       	call   8009b5 <cprintf>
  801095:	83 c4 10             	add    $0x10,%esp
			return;
  801098:	e9 95 00 00 00       	jmp    801132 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80109d:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010a1:	7e 34                	jle    8010d7 <readline+0xa0>
  8010a3:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010aa:	7f 2b                	jg     8010d7 <readline+0xa0>
			if (echoing)
  8010ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010b0:	74 0e                	je     8010c0 <readline+0x89>
				cputchar(c);
  8010b2:	83 ec 0c             	sub    $0xc,%esp
  8010b5:	ff 75 ec             	pushl  -0x14(%ebp)
  8010b8:	e8 a2 f4 ff ff       	call   80055f <cputchar>
  8010bd:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010c3:	8d 50 01             	lea    0x1(%eax),%edx
  8010c6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010c9:	89 c2                	mov    %eax,%edx
  8010cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ce:	01 d0                	add    %edx,%eax
  8010d0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010d3:	88 10                	mov    %dl,(%eax)
  8010d5:	eb 56                	jmp    80112d <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010d7:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010db:	75 1f                	jne    8010fc <readline+0xc5>
  8010dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010e1:	7e 19                	jle    8010fc <readline+0xc5>
			if (echoing)
  8010e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010e7:	74 0e                	je     8010f7 <readline+0xc0>
				cputchar(c);
  8010e9:	83 ec 0c             	sub    $0xc,%esp
  8010ec:	ff 75 ec             	pushl  -0x14(%ebp)
  8010ef:	e8 6b f4 ff ff       	call   80055f <cputchar>
  8010f4:	83 c4 10             	add    $0x10,%esp

			i--;
  8010f7:	ff 4d f4             	decl   -0xc(%ebp)
  8010fa:	eb 31                	jmp    80112d <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8010fc:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801100:	74 0a                	je     80110c <readline+0xd5>
  801102:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801106:	0f 85 61 ff ff ff    	jne    80106d <readline+0x36>
			if (echoing)
  80110c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801110:	74 0e                	je     801120 <readline+0xe9>
				cputchar(c);
  801112:	83 ec 0c             	sub    $0xc,%esp
  801115:	ff 75 ec             	pushl  -0x14(%ebp)
  801118:	e8 42 f4 ff ff       	call   80055f <cputchar>
  80111d:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801120:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801123:	8b 45 0c             	mov    0xc(%ebp),%eax
  801126:	01 d0                	add    %edx,%eax
  801128:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80112b:	eb 06                	jmp    801133 <readline+0xfc>
		}
	}
  80112d:	e9 3b ff ff ff       	jmp    80106d <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801132:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801133:	c9                   	leave  
  801134:	c3                   	ret    

00801135 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801135:	55                   	push   %ebp
  801136:	89 e5                	mov    %esp,%ebp
  801138:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80113b:	e8 d1 0c 00 00       	call   801e11 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801140:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801144:	74 13                	je     801159 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801146:	83 ec 08             	sub    $0x8,%esp
  801149:	ff 75 08             	pushl  0x8(%ebp)
  80114c:	68 10 2b 80 00       	push   $0x802b10
  801151:	e8 5f f8 ff ff       	call   8009b5 <cprintf>
  801156:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801159:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801160:	83 ec 0c             	sub    $0xc,%esp
  801163:	6a 00                	push   $0x0
  801165:	e8 8b f4 ff ff       	call   8005f5 <iscons>
  80116a:	83 c4 10             	add    $0x10,%esp
  80116d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801170:	e8 32 f4 ff ff       	call   8005a7 <getchar>
  801175:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801178:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80117c:	79 23                	jns    8011a1 <atomic_readline+0x6c>
			if (c != -E_EOF)
  80117e:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801182:	74 13                	je     801197 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801184:	83 ec 08             	sub    $0x8,%esp
  801187:	ff 75 ec             	pushl  -0x14(%ebp)
  80118a:	68 13 2b 80 00       	push   $0x802b13
  80118f:	e8 21 f8 ff ff       	call   8009b5 <cprintf>
  801194:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801197:	e8 8f 0c 00 00       	call   801e2b <sys_enable_interrupt>
			return;
  80119c:	e9 9a 00 00 00       	jmp    80123b <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011a1:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011a5:	7e 34                	jle    8011db <atomic_readline+0xa6>
  8011a7:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011ae:	7f 2b                	jg     8011db <atomic_readline+0xa6>
			if (echoing)
  8011b0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011b4:	74 0e                	je     8011c4 <atomic_readline+0x8f>
				cputchar(c);
  8011b6:	83 ec 0c             	sub    $0xc,%esp
  8011b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8011bc:	e8 9e f3 ff ff       	call   80055f <cputchar>
  8011c1:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011c7:	8d 50 01             	lea    0x1(%eax),%edx
  8011ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011cd:	89 c2                	mov    %eax,%edx
  8011cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d2:	01 d0                	add    %edx,%eax
  8011d4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011d7:	88 10                	mov    %dl,(%eax)
  8011d9:	eb 5b                	jmp    801236 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011db:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011df:	75 1f                	jne    801200 <atomic_readline+0xcb>
  8011e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011e5:	7e 19                	jle    801200 <atomic_readline+0xcb>
			if (echoing)
  8011e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011eb:	74 0e                	je     8011fb <atomic_readline+0xc6>
				cputchar(c);
  8011ed:	83 ec 0c             	sub    $0xc,%esp
  8011f0:	ff 75 ec             	pushl  -0x14(%ebp)
  8011f3:	e8 67 f3 ff ff       	call   80055f <cputchar>
  8011f8:	83 c4 10             	add    $0x10,%esp
			i--;
  8011fb:	ff 4d f4             	decl   -0xc(%ebp)
  8011fe:	eb 36                	jmp    801236 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801200:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801204:	74 0a                	je     801210 <atomic_readline+0xdb>
  801206:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80120a:	0f 85 60 ff ff ff    	jne    801170 <atomic_readline+0x3b>
			if (echoing)
  801210:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801214:	74 0e                	je     801224 <atomic_readline+0xef>
				cputchar(c);
  801216:	83 ec 0c             	sub    $0xc,%esp
  801219:	ff 75 ec             	pushl  -0x14(%ebp)
  80121c:	e8 3e f3 ff ff       	call   80055f <cputchar>
  801221:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801224:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801227:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122a:	01 d0                	add    %edx,%eax
  80122c:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80122f:	e8 f7 0b 00 00       	call   801e2b <sys_enable_interrupt>
			return;
  801234:	eb 05                	jmp    80123b <atomic_readline+0x106>
		}
	}
  801236:	e9 35 ff ff ff       	jmp    801170 <atomic_readline+0x3b>
}
  80123b:	c9                   	leave  
  80123c:	c3                   	ret    

0080123d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80123d:	55                   	push   %ebp
  80123e:	89 e5                	mov    %esp,%ebp
  801240:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801243:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80124a:	eb 06                	jmp    801252 <strlen+0x15>
		n++;
  80124c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80124f:	ff 45 08             	incl   0x8(%ebp)
  801252:	8b 45 08             	mov    0x8(%ebp),%eax
  801255:	8a 00                	mov    (%eax),%al
  801257:	84 c0                	test   %al,%al
  801259:	75 f1                	jne    80124c <strlen+0xf>
		n++;
	return n;
  80125b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80125e:	c9                   	leave  
  80125f:	c3                   	ret    

00801260 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801260:	55                   	push   %ebp
  801261:	89 e5                	mov    %esp,%ebp
  801263:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801266:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80126d:	eb 09                	jmp    801278 <strnlen+0x18>
		n++;
  80126f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801272:	ff 45 08             	incl   0x8(%ebp)
  801275:	ff 4d 0c             	decl   0xc(%ebp)
  801278:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80127c:	74 09                	je     801287 <strnlen+0x27>
  80127e:	8b 45 08             	mov    0x8(%ebp),%eax
  801281:	8a 00                	mov    (%eax),%al
  801283:	84 c0                	test   %al,%al
  801285:	75 e8                	jne    80126f <strnlen+0xf>
		n++;
	return n;
  801287:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80128a:	c9                   	leave  
  80128b:	c3                   	ret    

0080128c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80128c:	55                   	push   %ebp
  80128d:	89 e5                	mov    %esp,%ebp
  80128f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801292:	8b 45 08             	mov    0x8(%ebp),%eax
  801295:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801298:	90                   	nop
  801299:	8b 45 08             	mov    0x8(%ebp),%eax
  80129c:	8d 50 01             	lea    0x1(%eax),%edx
  80129f:	89 55 08             	mov    %edx,0x8(%ebp)
  8012a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012a8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012ab:	8a 12                	mov    (%edx),%dl
  8012ad:	88 10                	mov    %dl,(%eax)
  8012af:	8a 00                	mov    (%eax),%al
  8012b1:	84 c0                	test   %al,%al
  8012b3:	75 e4                	jne    801299 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012b8:	c9                   	leave  
  8012b9:	c3                   	ret    

008012ba <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
  8012bd:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012cd:	eb 1f                	jmp    8012ee <strncpy+0x34>
		*dst++ = *src;
  8012cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d2:	8d 50 01             	lea    0x1(%eax),%edx
  8012d5:	89 55 08             	mov    %edx,0x8(%ebp)
  8012d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012db:	8a 12                	mov    (%edx),%dl
  8012dd:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e2:	8a 00                	mov    (%eax),%al
  8012e4:	84 c0                	test   %al,%al
  8012e6:	74 03                	je     8012eb <strncpy+0x31>
			src++;
  8012e8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012eb:	ff 45 fc             	incl   -0x4(%ebp)
  8012ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012f4:	72 d9                	jb     8012cf <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012f9:	c9                   	leave  
  8012fa:	c3                   	ret    

008012fb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012fb:	55                   	push   %ebp
  8012fc:	89 e5                	mov    %esp,%ebp
  8012fe:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801301:	8b 45 08             	mov    0x8(%ebp),%eax
  801304:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801307:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80130b:	74 30                	je     80133d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80130d:	eb 16                	jmp    801325 <strlcpy+0x2a>
			*dst++ = *src++;
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	8d 50 01             	lea    0x1(%eax),%edx
  801315:	89 55 08             	mov    %edx,0x8(%ebp)
  801318:	8b 55 0c             	mov    0xc(%ebp),%edx
  80131b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80131e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801321:	8a 12                	mov    (%edx),%dl
  801323:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801325:	ff 4d 10             	decl   0x10(%ebp)
  801328:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80132c:	74 09                	je     801337 <strlcpy+0x3c>
  80132e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801331:	8a 00                	mov    (%eax),%al
  801333:	84 c0                	test   %al,%al
  801335:	75 d8                	jne    80130f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801337:	8b 45 08             	mov    0x8(%ebp),%eax
  80133a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80133d:	8b 55 08             	mov    0x8(%ebp),%edx
  801340:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801343:	29 c2                	sub    %eax,%edx
  801345:	89 d0                	mov    %edx,%eax
}
  801347:	c9                   	leave  
  801348:	c3                   	ret    

00801349 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801349:	55                   	push   %ebp
  80134a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80134c:	eb 06                	jmp    801354 <strcmp+0xb>
		p++, q++;
  80134e:	ff 45 08             	incl   0x8(%ebp)
  801351:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
  801357:	8a 00                	mov    (%eax),%al
  801359:	84 c0                	test   %al,%al
  80135b:	74 0e                	je     80136b <strcmp+0x22>
  80135d:	8b 45 08             	mov    0x8(%ebp),%eax
  801360:	8a 10                	mov    (%eax),%dl
  801362:	8b 45 0c             	mov    0xc(%ebp),%eax
  801365:	8a 00                	mov    (%eax),%al
  801367:	38 c2                	cmp    %al,%dl
  801369:	74 e3                	je     80134e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	8a 00                	mov    (%eax),%al
  801370:	0f b6 d0             	movzbl %al,%edx
  801373:	8b 45 0c             	mov    0xc(%ebp),%eax
  801376:	8a 00                	mov    (%eax),%al
  801378:	0f b6 c0             	movzbl %al,%eax
  80137b:	29 c2                	sub    %eax,%edx
  80137d:	89 d0                	mov    %edx,%eax
}
  80137f:	5d                   	pop    %ebp
  801380:	c3                   	ret    

00801381 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801381:	55                   	push   %ebp
  801382:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801384:	eb 09                	jmp    80138f <strncmp+0xe>
		n--, p++, q++;
  801386:	ff 4d 10             	decl   0x10(%ebp)
  801389:	ff 45 08             	incl   0x8(%ebp)
  80138c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80138f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801393:	74 17                	je     8013ac <strncmp+0x2b>
  801395:	8b 45 08             	mov    0x8(%ebp),%eax
  801398:	8a 00                	mov    (%eax),%al
  80139a:	84 c0                	test   %al,%al
  80139c:	74 0e                	je     8013ac <strncmp+0x2b>
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	8a 10                	mov    (%eax),%dl
  8013a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a6:	8a 00                	mov    (%eax),%al
  8013a8:	38 c2                	cmp    %al,%dl
  8013aa:	74 da                	je     801386 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013b0:	75 07                	jne    8013b9 <strncmp+0x38>
		return 0;
  8013b2:	b8 00 00 00 00       	mov    $0x0,%eax
  8013b7:	eb 14                	jmp    8013cd <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bc:	8a 00                	mov    (%eax),%al
  8013be:	0f b6 d0             	movzbl %al,%edx
  8013c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c4:	8a 00                	mov    (%eax),%al
  8013c6:	0f b6 c0             	movzbl %al,%eax
  8013c9:	29 c2                	sub    %eax,%edx
  8013cb:	89 d0                	mov    %edx,%eax
}
  8013cd:	5d                   	pop    %ebp
  8013ce:	c3                   	ret    

008013cf <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013cf:	55                   	push   %ebp
  8013d0:	89 e5                	mov    %esp,%ebp
  8013d2:	83 ec 04             	sub    $0x4,%esp
  8013d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013db:	eb 12                	jmp    8013ef <strchr+0x20>
		if (*s == c)
  8013dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e0:	8a 00                	mov    (%eax),%al
  8013e2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013e5:	75 05                	jne    8013ec <strchr+0x1d>
			return (char *) s;
  8013e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ea:	eb 11                	jmp    8013fd <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013ec:	ff 45 08             	incl   0x8(%ebp)
  8013ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f2:	8a 00                	mov    (%eax),%al
  8013f4:	84 c0                	test   %al,%al
  8013f6:	75 e5                	jne    8013dd <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013fd:	c9                   	leave  
  8013fe:	c3                   	ret    

008013ff <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013ff:	55                   	push   %ebp
  801400:	89 e5                	mov    %esp,%ebp
  801402:	83 ec 04             	sub    $0x4,%esp
  801405:	8b 45 0c             	mov    0xc(%ebp),%eax
  801408:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80140b:	eb 0d                	jmp    80141a <strfind+0x1b>
		if (*s == c)
  80140d:	8b 45 08             	mov    0x8(%ebp),%eax
  801410:	8a 00                	mov    (%eax),%al
  801412:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801415:	74 0e                	je     801425 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801417:	ff 45 08             	incl   0x8(%ebp)
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	8a 00                	mov    (%eax),%al
  80141f:	84 c0                	test   %al,%al
  801421:	75 ea                	jne    80140d <strfind+0xe>
  801423:	eb 01                	jmp    801426 <strfind+0x27>
		if (*s == c)
			break;
  801425:	90                   	nop
	return (char *) s;
  801426:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801429:	c9                   	leave  
  80142a:	c3                   	ret    

0080142b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80142b:	55                   	push   %ebp
  80142c:	89 e5                	mov    %esp,%ebp
  80142e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801431:	8b 45 08             	mov    0x8(%ebp),%eax
  801434:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801437:	8b 45 10             	mov    0x10(%ebp),%eax
  80143a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80143d:	eb 0e                	jmp    80144d <memset+0x22>
		*p++ = c;
  80143f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801442:	8d 50 01             	lea    0x1(%eax),%edx
  801445:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801448:	8b 55 0c             	mov    0xc(%ebp),%edx
  80144b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80144d:	ff 4d f8             	decl   -0x8(%ebp)
  801450:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801454:	79 e9                	jns    80143f <memset+0x14>
		*p++ = c;

	return v;
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801459:	c9                   	leave  
  80145a:	c3                   	ret    

0080145b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80145b:	55                   	push   %ebp
  80145c:	89 e5                	mov    %esp,%ebp
  80145e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801461:	8b 45 0c             	mov    0xc(%ebp),%eax
  801464:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801467:	8b 45 08             	mov    0x8(%ebp),%eax
  80146a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80146d:	eb 16                	jmp    801485 <memcpy+0x2a>
		*d++ = *s++;
  80146f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801472:	8d 50 01             	lea    0x1(%eax),%edx
  801475:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801478:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80147b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80147e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801481:	8a 12                	mov    (%edx),%dl
  801483:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801485:	8b 45 10             	mov    0x10(%ebp),%eax
  801488:	8d 50 ff             	lea    -0x1(%eax),%edx
  80148b:	89 55 10             	mov    %edx,0x10(%ebp)
  80148e:	85 c0                	test   %eax,%eax
  801490:	75 dd                	jne    80146f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801492:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801495:	c9                   	leave  
  801496:	c3                   	ret    

00801497 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
  80149a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80149d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014af:	73 50                	jae    801501 <memmove+0x6a>
  8014b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b7:	01 d0                	add    %edx,%eax
  8014b9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014bc:	76 43                	jbe    801501 <memmove+0x6a>
		s += n;
  8014be:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c1:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c7:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014ca:	eb 10                	jmp    8014dc <memmove+0x45>
			*--d = *--s;
  8014cc:	ff 4d f8             	decl   -0x8(%ebp)
  8014cf:	ff 4d fc             	decl   -0x4(%ebp)
  8014d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014d5:	8a 10                	mov    (%eax),%dl
  8014d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014da:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8014df:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014e2:	89 55 10             	mov    %edx,0x10(%ebp)
  8014e5:	85 c0                	test   %eax,%eax
  8014e7:	75 e3                	jne    8014cc <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014e9:	eb 23                	jmp    80150e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ee:	8d 50 01             	lea    0x1(%eax),%edx
  8014f1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014fa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014fd:	8a 12                	mov    (%edx),%dl
  8014ff:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801501:	8b 45 10             	mov    0x10(%ebp),%eax
  801504:	8d 50 ff             	lea    -0x1(%eax),%edx
  801507:	89 55 10             	mov    %edx,0x10(%ebp)
  80150a:	85 c0                	test   %eax,%eax
  80150c:	75 dd                	jne    8014eb <memmove+0x54>
			*d++ = *s++;

	return dst;
  80150e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801511:	c9                   	leave  
  801512:	c3                   	ret    

00801513 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801513:	55                   	push   %ebp
  801514:	89 e5                	mov    %esp,%ebp
  801516:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801519:	8b 45 08             	mov    0x8(%ebp),%eax
  80151c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80151f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801522:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801525:	eb 2a                	jmp    801551 <memcmp+0x3e>
		if (*s1 != *s2)
  801527:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80152a:	8a 10                	mov    (%eax),%dl
  80152c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80152f:	8a 00                	mov    (%eax),%al
  801531:	38 c2                	cmp    %al,%dl
  801533:	74 16                	je     80154b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801535:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801538:	8a 00                	mov    (%eax),%al
  80153a:	0f b6 d0             	movzbl %al,%edx
  80153d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801540:	8a 00                	mov    (%eax),%al
  801542:	0f b6 c0             	movzbl %al,%eax
  801545:	29 c2                	sub    %eax,%edx
  801547:	89 d0                	mov    %edx,%eax
  801549:	eb 18                	jmp    801563 <memcmp+0x50>
		s1++, s2++;
  80154b:	ff 45 fc             	incl   -0x4(%ebp)
  80154e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801551:	8b 45 10             	mov    0x10(%ebp),%eax
  801554:	8d 50 ff             	lea    -0x1(%eax),%edx
  801557:	89 55 10             	mov    %edx,0x10(%ebp)
  80155a:	85 c0                	test   %eax,%eax
  80155c:	75 c9                	jne    801527 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80155e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801563:	c9                   	leave  
  801564:	c3                   	ret    

00801565 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801565:	55                   	push   %ebp
  801566:	89 e5                	mov    %esp,%ebp
  801568:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80156b:	8b 55 08             	mov    0x8(%ebp),%edx
  80156e:	8b 45 10             	mov    0x10(%ebp),%eax
  801571:	01 d0                	add    %edx,%eax
  801573:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801576:	eb 15                	jmp    80158d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801578:	8b 45 08             	mov    0x8(%ebp),%eax
  80157b:	8a 00                	mov    (%eax),%al
  80157d:	0f b6 d0             	movzbl %al,%edx
  801580:	8b 45 0c             	mov    0xc(%ebp),%eax
  801583:	0f b6 c0             	movzbl %al,%eax
  801586:	39 c2                	cmp    %eax,%edx
  801588:	74 0d                	je     801597 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80158a:	ff 45 08             	incl   0x8(%ebp)
  80158d:	8b 45 08             	mov    0x8(%ebp),%eax
  801590:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801593:	72 e3                	jb     801578 <memfind+0x13>
  801595:	eb 01                	jmp    801598 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801597:	90                   	nop
	return (void *) s;
  801598:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80159b:	c9                   	leave  
  80159c:	c3                   	ret    

0080159d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
  8015a0:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015aa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015b1:	eb 03                	jmp    8015b6 <strtol+0x19>
		s++;
  8015b3:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b9:	8a 00                	mov    (%eax),%al
  8015bb:	3c 20                	cmp    $0x20,%al
  8015bd:	74 f4                	je     8015b3 <strtol+0x16>
  8015bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c2:	8a 00                	mov    (%eax),%al
  8015c4:	3c 09                	cmp    $0x9,%al
  8015c6:	74 eb                	je     8015b3 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cb:	8a 00                	mov    (%eax),%al
  8015cd:	3c 2b                	cmp    $0x2b,%al
  8015cf:	75 05                	jne    8015d6 <strtol+0x39>
		s++;
  8015d1:	ff 45 08             	incl   0x8(%ebp)
  8015d4:	eb 13                	jmp    8015e9 <strtol+0x4c>
	else if (*s == '-')
  8015d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d9:	8a 00                	mov    (%eax),%al
  8015db:	3c 2d                	cmp    $0x2d,%al
  8015dd:	75 0a                	jne    8015e9 <strtol+0x4c>
		s++, neg = 1;
  8015df:	ff 45 08             	incl   0x8(%ebp)
  8015e2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015ed:	74 06                	je     8015f5 <strtol+0x58>
  8015ef:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015f3:	75 20                	jne    801615 <strtol+0x78>
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f8:	8a 00                	mov    (%eax),%al
  8015fa:	3c 30                	cmp    $0x30,%al
  8015fc:	75 17                	jne    801615 <strtol+0x78>
  8015fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801601:	40                   	inc    %eax
  801602:	8a 00                	mov    (%eax),%al
  801604:	3c 78                	cmp    $0x78,%al
  801606:	75 0d                	jne    801615 <strtol+0x78>
		s += 2, base = 16;
  801608:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80160c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801613:	eb 28                	jmp    80163d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801615:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801619:	75 15                	jne    801630 <strtol+0x93>
  80161b:	8b 45 08             	mov    0x8(%ebp),%eax
  80161e:	8a 00                	mov    (%eax),%al
  801620:	3c 30                	cmp    $0x30,%al
  801622:	75 0c                	jne    801630 <strtol+0x93>
		s++, base = 8;
  801624:	ff 45 08             	incl   0x8(%ebp)
  801627:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80162e:	eb 0d                	jmp    80163d <strtol+0xa0>
	else if (base == 0)
  801630:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801634:	75 07                	jne    80163d <strtol+0xa0>
		base = 10;
  801636:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80163d:	8b 45 08             	mov    0x8(%ebp),%eax
  801640:	8a 00                	mov    (%eax),%al
  801642:	3c 2f                	cmp    $0x2f,%al
  801644:	7e 19                	jle    80165f <strtol+0xc2>
  801646:	8b 45 08             	mov    0x8(%ebp),%eax
  801649:	8a 00                	mov    (%eax),%al
  80164b:	3c 39                	cmp    $0x39,%al
  80164d:	7f 10                	jg     80165f <strtol+0xc2>
			dig = *s - '0';
  80164f:	8b 45 08             	mov    0x8(%ebp),%eax
  801652:	8a 00                	mov    (%eax),%al
  801654:	0f be c0             	movsbl %al,%eax
  801657:	83 e8 30             	sub    $0x30,%eax
  80165a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80165d:	eb 42                	jmp    8016a1 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	8a 00                	mov    (%eax),%al
  801664:	3c 60                	cmp    $0x60,%al
  801666:	7e 19                	jle    801681 <strtol+0xe4>
  801668:	8b 45 08             	mov    0x8(%ebp),%eax
  80166b:	8a 00                	mov    (%eax),%al
  80166d:	3c 7a                	cmp    $0x7a,%al
  80166f:	7f 10                	jg     801681 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	0f be c0             	movsbl %al,%eax
  801679:	83 e8 57             	sub    $0x57,%eax
  80167c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80167f:	eb 20                	jmp    8016a1 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801681:	8b 45 08             	mov    0x8(%ebp),%eax
  801684:	8a 00                	mov    (%eax),%al
  801686:	3c 40                	cmp    $0x40,%al
  801688:	7e 39                	jle    8016c3 <strtol+0x126>
  80168a:	8b 45 08             	mov    0x8(%ebp),%eax
  80168d:	8a 00                	mov    (%eax),%al
  80168f:	3c 5a                	cmp    $0x5a,%al
  801691:	7f 30                	jg     8016c3 <strtol+0x126>
			dig = *s - 'A' + 10;
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	8a 00                	mov    (%eax),%al
  801698:	0f be c0             	movsbl %al,%eax
  80169b:	83 e8 37             	sub    $0x37,%eax
  80169e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016a4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016a7:	7d 19                	jge    8016c2 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016a9:	ff 45 08             	incl   0x8(%ebp)
  8016ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016af:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016b3:	89 c2                	mov    %eax,%edx
  8016b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b8:	01 d0                	add    %edx,%eax
  8016ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016bd:	e9 7b ff ff ff       	jmp    80163d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016c2:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016c3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016c7:	74 08                	je     8016d1 <strtol+0x134>
		*endptr = (char *) s;
  8016c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016cc:	8b 55 08             	mov    0x8(%ebp),%edx
  8016cf:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016d5:	74 07                	je     8016de <strtol+0x141>
  8016d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016da:	f7 d8                	neg    %eax
  8016dc:	eb 03                	jmp    8016e1 <strtol+0x144>
  8016de:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016e1:	c9                   	leave  
  8016e2:	c3                   	ret    

008016e3 <ltostr>:

void
ltostr(long value, char *str)
{
  8016e3:	55                   	push   %ebp
  8016e4:	89 e5                	mov    %esp,%ebp
  8016e6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016f0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016f7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016fb:	79 13                	jns    801710 <ltostr+0x2d>
	{
		neg = 1;
  8016fd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801704:	8b 45 0c             	mov    0xc(%ebp),%eax
  801707:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80170a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80170d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801710:	8b 45 08             	mov    0x8(%ebp),%eax
  801713:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801718:	99                   	cltd   
  801719:	f7 f9                	idiv   %ecx
  80171b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80171e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801721:	8d 50 01             	lea    0x1(%eax),%edx
  801724:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801727:	89 c2                	mov    %eax,%edx
  801729:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172c:	01 d0                	add    %edx,%eax
  80172e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801731:	83 c2 30             	add    $0x30,%edx
  801734:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801736:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801739:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80173e:	f7 e9                	imul   %ecx
  801740:	c1 fa 02             	sar    $0x2,%edx
  801743:	89 c8                	mov    %ecx,%eax
  801745:	c1 f8 1f             	sar    $0x1f,%eax
  801748:	29 c2                	sub    %eax,%edx
  80174a:	89 d0                	mov    %edx,%eax
  80174c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80174f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801752:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801757:	f7 e9                	imul   %ecx
  801759:	c1 fa 02             	sar    $0x2,%edx
  80175c:	89 c8                	mov    %ecx,%eax
  80175e:	c1 f8 1f             	sar    $0x1f,%eax
  801761:	29 c2                	sub    %eax,%edx
  801763:	89 d0                	mov    %edx,%eax
  801765:	c1 e0 02             	shl    $0x2,%eax
  801768:	01 d0                	add    %edx,%eax
  80176a:	01 c0                	add    %eax,%eax
  80176c:	29 c1                	sub    %eax,%ecx
  80176e:	89 ca                	mov    %ecx,%edx
  801770:	85 d2                	test   %edx,%edx
  801772:	75 9c                	jne    801710 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801774:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80177b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80177e:	48                   	dec    %eax
  80177f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801782:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801786:	74 3d                	je     8017c5 <ltostr+0xe2>
		start = 1 ;
  801788:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80178f:	eb 34                	jmp    8017c5 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801791:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801794:	8b 45 0c             	mov    0xc(%ebp),%eax
  801797:	01 d0                	add    %edx,%eax
  801799:	8a 00                	mov    (%eax),%al
  80179b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80179e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a4:	01 c2                	add    %eax,%edx
  8017a6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ac:	01 c8                	add    %ecx,%eax
  8017ae:	8a 00                	mov    (%eax),%al
  8017b0:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017b2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b8:	01 c2                	add    %eax,%edx
  8017ba:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017bd:	88 02                	mov    %al,(%edx)
		start++ ;
  8017bf:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017c2:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017c8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017cb:	7c c4                	jl     801791 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017cd:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d3:	01 d0                	add    %edx,%eax
  8017d5:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017d8:	90                   	nop
  8017d9:	c9                   	leave  
  8017da:	c3                   	ret    

008017db <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017db:	55                   	push   %ebp
  8017dc:	89 e5                	mov    %esp,%ebp
  8017de:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017e1:	ff 75 08             	pushl  0x8(%ebp)
  8017e4:	e8 54 fa ff ff       	call   80123d <strlen>
  8017e9:	83 c4 04             	add    $0x4,%esp
  8017ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017ef:	ff 75 0c             	pushl  0xc(%ebp)
  8017f2:	e8 46 fa ff ff       	call   80123d <strlen>
  8017f7:	83 c4 04             	add    $0x4,%esp
  8017fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801804:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80180b:	eb 17                	jmp    801824 <strcconcat+0x49>
		final[s] = str1[s] ;
  80180d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801810:	8b 45 10             	mov    0x10(%ebp),%eax
  801813:	01 c2                	add    %eax,%edx
  801815:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801818:	8b 45 08             	mov    0x8(%ebp),%eax
  80181b:	01 c8                	add    %ecx,%eax
  80181d:	8a 00                	mov    (%eax),%al
  80181f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801821:	ff 45 fc             	incl   -0x4(%ebp)
  801824:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801827:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80182a:	7c e1                	jl     80180d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80182c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801833:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80183a:	eb 1f                	jmp    80185b <strcconcat+0x80>
		final[s++] = str2[i] ;
  80183c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80183f:	8d 50 01             	lea    0x1(%eax),%edx
  801842:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801845:	89 c2                	mov    %eax,%edx
  801847:	8b 45 10             	mov    0x10(%ebp),%eax
  80184a:	01 c2                	add    %eax,%edx
  80184c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80184f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801852:	01 c8                	add    %ecx,%eax
  801854:	8a 00                	mov    (%eax),%al
  801856:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801858:	ff 45 f8             	incl   -0x8(%ebp)
  80185b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80185e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801861:	7c d9                	jl     80183c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801863:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801866:	8b 45 10             	mov    0x10(%ebp),%eax
  801869:	01 d0                	add    %edx,%eax
  80186b:	c6 00 00             	movb   $0x0,(%eax)
}
  80186e:	90                   	nop
  80186f:	c9                   	leave  
  801870:	c3                   	ret    

00801871 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801871:	55                   	push   %ebp
  801872:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801874:	8b 45 14             	mov    0x14(%ebp),%eax
  801877:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80187d:	8b 45 14             	mov    0x14(%ebp),%eax
  801880:	8b 00                	mov    (%eax),%eax
  801882:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801889:	8b 45 10             	mov    0x10(%ebp),%eax
  80188c:	01 d0                	add    %edx,%eax
  80188e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801894:	eb 0c                	jmp    8018a2 <strsplit+0x31>
			*string++ = 0;
  801896:	8b 45 08             	mov    0x8(%ebp),%eax
  801899:	8d 50 01             	lea    0x1(%eax),%edx
  80189c:	89 55 08             	mov    %edx,0x8(%ebp)
  80189f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a5:	8a 00                	mov    (%eax),%al
  8018a7:	84 c0                	test   %al,%al
  8018a9:	74 18                	je     8018c3 <strsplit+0x52>
  8018ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ae:	8a 00                	mov    (%eax),%al
  8018b0:	0f be c0             	movsbl %al,%eax
  8018b3:	50                   	push   %eax
  8018b4:	ff 75 0c             	pushl  0xc(%ebp)
  8018b7:	e8 13 fb ff ff       	call   8013cf <strchr>
  8018bc:	83 c4 08             	add    $0x8,%esp
  8018bf:	85 c0                	test   %eax,%eax
  8018c1:	75 d3                	jne    801896 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8018c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c6:	8a 00                	mov    (%eax),%al
  8018c8:	84 c0                	test   %al,%al
  8018ca:	74 5a                	je     801926 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8018cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8018cf:	8b 00                	mov    (%eax),%eax
  8018d1:	83 f8 0f             	cmp    $0xf,%eax
  8018d4:	75 07                	jne    8018dd <strsplit+0x6c>
		{
			return 0;
  8018d6:	b8 00 00 00 00       	mov    $0x0,%eax
  8018db:	eb 66                	jmp    801943 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e0:	8b 00                	mov    (%eax),%eax
  8018e2:	8d 48 01             	lea    0x1(%eax),%ecx
  8018e5:	8b 55 14             	mov    0x14(%ebp),%edx
  8018e8:	89 0a                	mov    %ecx,(%edx)
  8018ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f4:	01 c2                	add    %eax,%edx
  8018f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018fb:	eb 03                	jmp    801900 <strsplit+0x8f>
			string++;
  8018fd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801900:	8b 45 08             	mov    0x8(%ebp),%eax
  801903:	8a 00                	mov    (%eax),%al
  801905:	84 c0                	test   %al,%al
  801907:	74 8b                	je     801894 <strsplit+0x23>
  801909:	8b 45 08             	mov    0x8(%ebp),%eax
  80190c:	8a 00                	mov    (%eax),%al
  80190e:	0f be c0             	movsbl %al,%eax
  801911:	50                   	push   %eax
  801912:	ff 75 0c             	pushl  0xc(%ebp)
  801915:	e8 b5 fa ff ff       	call   8013cf <strchr>
  80191a:	83 c4 08             	add    $0x8,%esp
  80191d:	85 c0                	test   %eax,%eax
  80191f:	74 dc                	je     8018fd <strsplit+0x8c>
			string++;
	}
  801921:	e9 6e ff ff ff       	jmp    801894 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801926:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801927:	8b 45 14             	mov    0x14(%ebp),%eax
  80192a:	8b 00                	mov    (%eax),%eax
  80192c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801933:	8b 45 10             	mov    0x10(%ebp),%eax
  801936:	01 d0                	add    %edx,%eax
  801938:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80193e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801943:	c9                   	leave  
  801944:	c3                   	ret    

00801945 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801945:	55                   	push   %ebp
  801946:	89 e5                	mov    %esp,%ebp
  801948:	83 ec 18             	sub    $0x18,%esp
  80194b:	8b 45 10             	mov    0x10(%ebp),%eax
  80194e:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801951:	83 ec 04             	sub    $0x4,%esp
  801954:	68 24 2b 80 00       	push   $0x802b24
  801959:	6a 17                	push   $0x17
  80195b:	68 43 2b 80 00       	push   $0x802b43
  801960:	e8 9c ed ff ff       	call   800701 <_panic>

00801965 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801965:	55                   	push   %ebp
  801966:	89 e5                	mov    %esp,%ebp
  801968:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  80196b:	83 ec 04             	sub    $0x4,%esp
  80196e:	68 4f 2b 80 00       	push   $0x802b4f
  801973:	6a 2f                	push   $0x2f
  801975:	68 43 2b 80 00       	push   $0x802b43
  80197a:	e8 82 ed ff ff       	call   800701 <_panic>

0080197f <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
  801982:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801985:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  80198c:	8b 55 08             	mov    0x8(%ebp),%edx
  80198f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801992:	01 d0                	add    %edx,%eax
  801994:	48                   	dec    %eax
  801995:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801998:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80199b:	ba 00 00 00 00       	mov    $0x0,%edx
  8019a0:	f7 75 ec             	divl   -0x14(%ebp)
  8019a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019a6:	29 d0                	sub    %edx,%eax
  8019a8:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8019ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ae:	c1 e8 0c             	shr    $0xc,%eax
  8019b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8019b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8019bb:	e9 c8 00 00 00       	jmp    801a88 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8019c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019c7:	eb 27                	jmp    8019f0 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8019c9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019cf:	01 c2                	add    %eax,%edx
  8019d1:	89 d0                	mov    %edx,%eax
  8019d3:	01 c0                	add    %eax,%eax
  8019d5:	01 d0                	add    %edx,%eax
  8019d7:	c1 e0 02             	shl    $0x2,%eax
  8019da:	05 48 30 80 00       	add    $0x803048,%eax
  8019df:	8b 00                	mov    (%eax),%eax
  8019e1:	85 c0                	test   %eax,%eax
  8019e3:	74 08                	je     8019ed <malloc+0x6e>
            	i += j;
  8019e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019e8:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8019eb:	eb 0b                	jmp    8019f8 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8019ed:	ff 45 f0             	incl   -0x10(%ebp)
  8019f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019f3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019f6:	72 d1                	jb     8019c9 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8019f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019fb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019fe:	0f 85 81 00 00 00    	jne    801a85 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801a04:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a07:	05 00 00 08 00       	add    $0x80000,%eax
  801a0c:	c1 e0 0c             	shl    $0xc,%eax
  801a0f:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801a12:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a19:	eb 1f                	jmp    801a3a <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801a1b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a21:	01 c2                	add    %eax,%edx
  801a23:	89 d0                	mov    %edx,%eax
  801a25:	01 c0                	add    %eax,%eax
  801a27:	01 d0                	add    %edx,%eax
  801a29:	c1 e0 02             	shl    $0x2,%eax
  801a2c:	05 48 30 80 00       	add    $0x803048,%eax
  801a31:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801a37:	ff 45 f0             	incl   -0x10(%ebp)
  801a3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a3d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a40:	72 d9                	jb     801a1b <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801a42:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a45:	89 d0                	mov    %edx,%eax
  801a47:	01 c0                	add    %eax,%eax
  801a49:	01 d0                	add    %edx,%eax
  801a4b:	c1 e0 02             	shl    $0x2,%eax
  801a4e:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801a54:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a57:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801a59:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a5c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801a5f:	89 c8                	mov    %ecx,%eax
  801a61:	01 c0                	add    %eax,%eax
  801a63:	01 c8                	add    %ecx,%eax
  801a65:	c1 e0 02             	shl    $0x2,%eax
  801a68:	05 44 30 80 00       	add    $0x803044,%eax
  801a6d:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801a6f:	83 ec 08             	sub    $0x8,%esp
  801a72:	ff 75 08             	pushl  0x8(%ebp)
  801a75:	ff 75 e0             	pushl  -0x20(%ebp)
  801a78:	e8 2b 03 00 00       	call   801da8 <sys_allocateMem>
  801a7d:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801a80:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a83:	eb 19                	jmp    801a9e <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801a85:	ff 45 f4             	incl   -0xc(%ebp)
  801a88:	a1 04 30 80 00       	mov    0x803004,%eax
  801a8d:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801a90:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a93:	0f 83 27 ff ff ff    	jae    8019c0 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801a99:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a9e:	c9                   	leave  
  801a9f:	c3                   	ret    

00801aa0 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801aa0:	55                   	push   %ebp
  801aa1:	89 e5                	mov    %esp,%ebp
  801aa3:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801aa6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801aaa:	0f 84 e5 00 00 00    	je     801b95 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801ab6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ab9:	05 00 00 00 80       	add    $0x80000000,%eax
  801abe:	c1 e8 0c             	shr    $0xc,%eax
  801ac1:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801ac4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ac7:	89 d0                	mov    %edx,%eax
  801ac9:	01 c0                	add    %eax,%eax
  801acb:	01 d0                	add    %edx,%eax
  801acd:	c1 e0 02             	shl    $0x2,%eax
  801ad0:	05 40 30 80 00       	add    $0x803040,%eax
  801ad5:	8b 00                	mov    (%eax),%eax
  801ad7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ada:	0f 85 b8 00 00 00    	jne    801b98 <free+0xf8>
  801ae0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ae3:	89 d0                	mov    %edx,%eax
  801ae5:	01 c0                	add    %eax,%eax
  801ae7:	01 d0                	add    %edx,%eax
  801ae9:	c1 e0 02             	shl    $0x2,%eax
  801aec:	05 48 30 80 00       	add    $0x803048,%eax
  801af1:	8b 00                	mov    (%eax),%eax
  801af3:	85 c0                	test   %eax,%eax
  801af5:	0f 84 9d 00 00 00    	je     801b98 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801afb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801afe:	89 d0                	mov    %edx,%eax
  801b00:	01 c0                	add    %eax,%eax
  801b02:	01 d0                	add    %edx,%eax
  801b04:	c1 e0 02             	shl    $0x2,%eax
  801b07:	05 44 30 80 00       	add    $0x803044,%eax
  801b0c:	8b 00                	mov    (%eax),%eax
  801b0e:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801b11:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b14:	c1 e0 0c             	shl    $0xc,%eax
  801b17:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801b1a:	83 ec 08             	sub    $0x8,%esp
  801b1d:	ff 75 e4             	pushl  -0x1c(%ebp)
  801b20:	ff 75 f0             	pushl  -0x10(%ebp)
  801b23:	e8 64 02 00 00       	call   801d8c <sys_freeMem>
  801b28:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801b2b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b32:	eb 57                	jmp    801b8b <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801b34:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b37:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b3a:	01 c2                	add    %eax,%edx
  801b3c:	89 d0                	mov    %edx,%eax
  801b3e:	01 c0                	add    %eax,%eax
  801b40:	01 d0                	add    %edx,%eax
  801b42:	c1 e0 02             	shl    $0x2,%eax
  801b45:	05 48 30 80 00       	add    $0x803048,%eax
  801b4a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801b50:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b56:	01 c2                	add    %eax,%edx
  801b58:	89 d0                	mov    %edx,%eax
  801b5a:	01 c0                	add    %eax,%eax
  801b5c:	01 d0                	add    %edx,%eax
  801b5e:	c1 e0 02             	shl    $0x2,%eax
  801b61:	05 40 30 80 00       	add    $0x803040,%eax
  801b66:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801b6c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b72:	01 c2                	add    %eax,%edx
  801b74:	89 d0                	mov    %edx,%eax
  801b76:	01 c0                	add    %eax,%eax
  801b78:	01 d0                	add    %edx,%eax
  801b7a:	c1 e0 02             	shl    $0x2,%eax
  801b7d:	05 44 30 80 00       	add    $0x803044,%eax
  801b82:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801b88:	ff 45 f4             	incl   -0xc(%ebp)
  801b8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b8e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b91:	7c a1                	jl     801b34 <free+0x94>
  801b93:	eb 04                	jmp    801b99 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801b95:	90                   	nop
  801b96:	eb 01                	jmp    801b99 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801b98:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801b99:	c9                   	leave  
  801b9a:	c3                   	ret    

00801b9b <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801b9b:	55                   	push   %ebp
  801b9c:	89 e5                	mov    %esp,%ebp
  801b9e:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801ba1:	83 ec 04             	sub    $0x4,%esp
  801ba4:	68 6c 2b 80 00       	push   $0x802b6c
  801ba9:	68 ae 00 00 00       	push   $0xae
  801bae:	68 43 2b 80 00       	push   $0x802b43
  801bb3:	e8 49 eb ff ff       	call   800701 <_panic>

00801bb8 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801bb8:	55                   	push   %ebp
  801bb9:	89 e5                	mov    %esp,%ebp
  801bbb:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801bbe:	83 ec 04             	sub    $0x4,%esp
  801bc1:	68 8c 2b 80 00       	push   $0x802b8c
  801bc6:	68 ca 00 00 00       	push   $0xca
  801bcb:	68 43 2b 80 00       	push   $0x802b43
  801bd0:	e8 2c eb ff ff       	call   800701 <_panic>

00801bd5 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801bd5:	55                   	push   %ebp
  801bd6:	89 e5                	mov    %esp,%ebp
  801bd8:	57                   	push   %edi
  801bd9:	56                   	push   %esi
  801bda:	53                   	push   %ebx
  801bdb:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801bde:	8b 45 08             	mov    0x8(%ebp),%eax
  801be1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801be4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801be7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bea:	8b 7d 18             	mov    0x18(%ebp),%edi
  801bed:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801bf0:	cd 30                	int    $0x30
  801bf2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801bf5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801bf8:	83 c4 10             	add    $0x10,%esp
  801bfb:	5b                   	pop    %ebx
  801bfc:	5e                   	pop    %esi
  801bfd:	5f                   	pop    %edi
  801bfe:	5d                   	pop    %ebp
  801bff:	c3                   	ret    

00801c00 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c00:	55                   	push   %ebp
  801c01:	89 e5                	mov    %esp,%ebp
  801c03:	83 ec 04             	sub    $0x4,%esp
  801c06:	8b 45 10             	mov    0x10(%ebp),%eax
  801c09:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c0c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c10:	8b 45 08             	mov    0x8(%ebp),%eax
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	52                   	push   %edx
  801c18:	ff 75 0c             	pushl  0xc(%ebp)
  801c1b:	50                   	push   %eax
  801c1c:	6a 00                	push   $0x0
  801c1e:	e8 b2 ff ff ff       	call   801bd5 <syscall>
  801c23:	83 c4 18             	add    $0x18,%esp
}
  801c26:	90                   	nop
  801c27:	c9                   	leave  
  801c28:	c3                   	ret    

00801c29 <sys_cgetc>:

int
sys_cgetc(void)
{
  801c29:	55                   	push   %ebp
  801c2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 01                	push   $0x1
  801c38:	e8 98 ff ff ff       	call   801bd5 <syscall>
  801c3d:	83 c4 18             	add    $0x18,%esp
}
  801c40:	c9                   	leave  
  801c41:	c3                   	ret    

00801c42 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c42:	55                   	push   %ebp
  801c43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c45:	8b 45 08             	mov    0x8(%ebp),%eax
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	50                   	push   %eax
  801c51:	6a 05                	push   $0x5
  801c53:	e8 7d ff ff ff       	call   801bd5 <syscall>
  801c58:	83 c4 18             	add    $0x18,%esp
}
  801c5b:	c9                   	leave  
  801c5c:	c3                   	ret    

00801c5d <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c5d:	55                   	push   %ebp
  801c5e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c60:	6a 00                	push   $0x0
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 02                	push   $0x2
  801c6c:	e8 64 ff ff ff       	call   801bd5 <syscall>
  801c71:	83 c4 18             	add    $0x18,%esp
}
  801c74:	c9                   	leave  
  801c75:	c3                   	ret    

00801c76 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c76:	55                   	push   %ebp
  801c77:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	6a 03                	push   $0x3
  801c85:	e8 4b ff ff ff       	call   801bd5 <syscall>
  801c8a:	83 c4 18             	add    $0x18,%esp
}
  801c8d:	c9                   	leave  
  801c8e:	c3                   	ret    

00801c8f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c8f:	55                   	push   %ebp
  801c90:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 00                	push   $0x0
  801c9c:	6a 04                	push   $0x4
  801c9e:	e8 32 ff ff ff       	call   801bd5 <syscall>
  801ca3:	83 c4 18             	add    $0x18,%esp
}
  801ca6:	c9                   	leave  
  801ca7:	c3                   	ret    

00801ca8 <sys_env_exit>:


void sys_env_exit(void)
{
  801ca8:	55                   	push   %ebp
  801ca9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 06                	push   $0x6
  801cb7:	e8 19 ff ff ff       	call   801bd5 <syscall>
  801cbc:	83 c4 18             	add    $0x18,%esp
}
  801cbf:	90                   	nop
  801cc0:	c9                   	leave  
  801cc1:	c3                   	ret    

00801cc2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801cc2:	55                   	push   %ebp
  801cc3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801cc5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	52                   	push   %edx
  801cd2:	50                   	push   %eax
  801cd3:	6a 07                	push   $0x7
  801cd5:	e8 fb fe ff ff       	call   801bd5 <syscall>
  801cda:	83 c4 18             	add    $0x18,%esp
}
  801cdd:	c9                   	leave  
  801cde:	c3                   	ret    

00801cdf <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801cdf:	55                   	push   %ebp
  801ce0:	89 e5                	mov    %esp,%ebp
  801ce2:	56                   	push   %esi
  801ce3:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801ce4:	8b 75 18             	mov    0x18(%ebp),%esi
  801ce7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cea:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ced:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf3:	56                   	push   %esi
  801cf4:	53                   	push   %ebx
  801cf5:	51                   	push   %ecx
  801cf6:	52                   	push   %edx
  801cf7:	50                   	push   %eax
  801cf8:	6a 08                	push   $0x8
  801cfa:	e8 d6 fe ff ff       	call   801bd5 <syscall>
  801cff:	83 c4 18             	add    $0x18,%esp
}
  801d02:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d05:	5b                   	pop    %ebx
  801d06:	5e                   	pop    %esi
  801d07:	5d                   	pop    %ebp
  801d08:	c3                   	ret    

00801d09 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d09:	55                   	push   %ebp
  801d0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	52                   	push   %edx
  801d19:	50                   	push   %eax
  801d1a:	6a 09                	push   $0x9
  801d1c:	e8 b4 fe ff ff       	call   801bd5 <syscall>
  801d21:	83 c4 18             	add    $0x18,%esp
}
  801d24:	c9                   	leave  
  801d25:	c3                   	ret    

00801d26 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d26:	55                   	push   %ebp
  801d27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	ff 75 0c             	pushl  0xc(%ebp)
  801d32:	ff 75 08             	pushl  0x8(%ebp)
  801d35:	6a 0a                	push   $0xa
  801d37:	e8 99 fe ff ff       	call   801bd5 <syscall>
  801d3c:	83 c4 18             	add    $0x18,%esp
}
  801d3f:	c9                   	leave  
  801d40:	c3                   	ret    

00801d41 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d41:	55                   	push   %ebp
  801d42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d44:	6a 00                	push   $0x0
  801d46:	6a 00                	push   $0x0
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 0b                	push   $0xb
  801d50:	e8 80 fe ff ff       	call   801bd5 <syscall>
  801d55:	83 c4 18             	add    $0x18,%esp
}
  801d58:	c9                   	leave  
  801d59:	c3                   	ret    

00801d5a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d5a:	55                   	push   %ebp
  801d5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 00                	push   $0x0
  801d63:	6a 00                	push   $0x0
  801d65:	6a 00                	push   $0x0
  801d67:	6a 0c                	push   $0xc
  801d69:	e8 67 fe ff ff       	call   801bd5 <syscall>
  801d6e:	83 c4 18             	add    $0x18,%esp
}
  801d71:	c9                   	leave  
  801d72:	c3                   	ret    

00801d73 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d73:	55                   	push   %ebp
  801d74:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 00                	push   $0x0
  801d7c:	6a 00                	push   $0x0
  801d7e:	6a 00                	push   $0x0
  801d80:	6a 0d                	push   $0xd
  801d82:	e8 4e fe ff ff       	call   801bd5 <syscall>
  801d87:	83 c4 18             	add    $0x18,%esp
}
  801d8a:	c9                   	leave  
  801d8b:	c3                   	ret    

00801d8c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d8c:	55                   	push   %ebp
  801d8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	ff 75 0c             	pushl  0xc(%ebp)
  801d98:	ff 75 08             	pushl  0x8(%ebp)
  801d9b:	6a 11                	push   $0x11
  801d9d:	e8 33 fe ff ff       	call   801bd5 <syscall>
  801da2:	83 c4 18             	add    $0x18,%esp
	return;
  801da5:	90                   	nop
}
  801da6:	c9                   	leave  
  801da7:	c3                   	ret    

00801da8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801da8:	55                   	push   %ebp
  801da9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801dab:	6a 00                	push   $0x0
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	ff 75 0c             	pushl  0xc(%ebp)
  801db4:	ff 75 08             	pushl  0x8(%ebp)
  801db7:	6a 12                	push   $0x12
  801db9:	e8 17 fe ff ff       	call   801bd5 <syscall>
  801dbe:	83 c4 18             	add    $0x18,%esp
	return ;
  801dc1:	90                   	nop
}
  801dc2:	c9                   	leave  
  801dc3:	c3                   	ret    

00801dc4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801dc4:	55                   	push   %ebp
  801dc5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 0e                	push   $0xe
  801dd3:	e8 fd fd ff ff       	call   801bd5 <syscall>
  801dd8:	83 c4 18             	add    $0x18,%esp
}
  801ddb:	c9                   	leave  
  801ddc:	c3                   	ret    

00801ddd <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ddd:	55                   	push   %ebp
  801dde:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	6a 00                	push   $0x0
  801de6:	6a 00                	push   $0x0
  801de8:	ff 75 08             	pushl  0x8(%ebp)
  801deb:	6a 0f                	push   $0xf
  801ded:	e8 e3 fd ff ff       	call   801bd5 <syscall>
  801df2:	83 c4 18             	add    $0x18,%esp
}
  801df5:	c9                   	leave  
  801df6:	c3                   	ret    

00801df7 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801df7:	55                   	push   %ebp
  801df8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 10                	push   $0x10
  801e06:	e8 ca fd ff ff       	call   801bd5 <syscall>
  801e0b:	83 c4 18             	add    $0x18,%esp
}
  801e0e:	90                   	nop
  801e0f:	c9                   	leave  
  801e10:	c3                   	ret    

00801e11 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e11:	55                   	push   %ebp
  801e12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 14                	push   $0x14
  801e20:	e8 b0 fd ff ff       	call   801bd5 <syscall>
  801e25:	83 c4 18             	add    $0x18,%esp
}
  801e28:	90                   	nop
  801e29:	c9                   	leave  
  801e2a:	c3                   	ret    

00801e2b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e2b:	55                   	push   %ebp
  801e2c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 15                	push   $0x15
  801e3a:	e8 96 fd ff ff       	call   801bd5 <syscall>
  801e3f:	83 c4 18             	add    $0x18,%esp
}
  801e42:	90                   	nop
  801e43:	c9                   	leave  
  801e44:	c3                   	ret    

00801e45 <sys_cputc>:


void
sys_cputc(const char c)
{
  801e45:	55                   	push   %ebp
  801e46:	89 e5                	mov    %esp,%ebp
  801e48:	83 ec 04             	sub    $0x4,%esp
  801e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e51:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	50                   	push   %eax
  801e5e:	6a 16                	push   $0x16
  801e60:	e8 70 fd ff ff       	call   801bd5 <syscall>
  801e65:	83 c4 18             	add    $0x18,%esp
}
  801e68:	90                   	nop
  801e69:	c9                   	leave  
  801e6a:	c3                   	ret    

00801e6b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e6b:	55                   	push   %ebp
  801e6c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	6a 00                	push   $0x0
  801e78:	6a 17                	push   $0x17
  801e7a:	e8 56 fd ff ff       	call   801bd5 <syscall>
  801e7f:	83 c4 18             	add    $0x18,%esp
}
  801e82:	90                   	nop
  801e83:	c9                   	leave  
  801e84:	c3                   	ret    

00801e85 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e85:	55                   	push   %ebp
  801e86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e88:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8b:	6a 00                	push   $0x0
  801e8d:	6a 00                	push   $0x0
  801e8f:	6a 00                	push   $0x0
  801e91:	ff 75 0c             	pushl  0xc(%ebp)
  801e94:	50                   	push   %eax
  801e95:	6a 18                	push   $0x18
  801e97:	e8 39 fd ff ff       	call   801bd5 <syscall>
  801e9c:	83 c4 18             	add    $0x18,%esp
}
  801e9f:	c9                   	leave  
  801ea0:	c3                   	ret    

00801ea1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ea1:	55                   	push   %ebp
  801ea2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ea4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eaa:	6a 00                	push   $0x0
  801eac:	6a 00                	push   $0x0
  801eae:	6a 00                	push   $0x0
  801eb0:	52                   	push   %edx
  801eb1:	50                   	push   %eax
  801eb2:	6a 1b                	push   $0x1b
  801eb4:	e8 1c fd ff ff       	call   801bd5 <syscall>
  801eb9:	83 c4 18             	add    $0x18,%esp
}
  801ebc:	c9                   	leave  
  801ebd:	c3                   	ret    

00801ebe <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ebe:	55                   	push   %ebp
  801ebf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ec1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ec4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 00                	push   $0x0
  801ecb:	6a 00                	push   $0x0
  801ecd:	52                   	push   %edx
  801ece:	50                   	push   %eax
  801ecf:	6a 19                	push   $0x19
  801ed1:	e8 ff fc ff ff       	call   801bd5 <syscall>
  801ed6:	83 c4 18             	add    $0x18,%esp
}
  801ed9:	90                   	nop
  801eda:	c9                   	leave  
  801edb:	c3                   	ret    

00801edc <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801edc:	55                   	push   %ebp
  801edd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801edf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	52                   	push   %edx
  801eec:	50                   	push   %eax
  801eed:	6a 1a                	push   $0x1a
  801eef:	e8 e1 fc ff ff       	call   801bd5 <syscall>
  801ef4:	83 c4 18             	add    $0x18,%esp
}
  801ef7:	90                   	nop
  801ef8:	c9                   	leave  
  801ef9:	c3                   	ret    

00801efa <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801efa:	55                   	push   %ebp
  801efb:	89 e5                	mov    %esp,%ebp
  801efd:	83 ec 04             	sub    $0x4,%esp
  801f00:	8b 45 10             	mov    0x10(%ebp),%eax
  801f03:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f06:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f09:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f10:	6a 00                	push   $0x0
  801f12:	51                   	push   %ecx
  801f13:	52                   	push   %edx
  801f14:	ff 75 0c             	pushl  0xc(%ebp)
  801f17:	50                   	push   %eax
  801f18:	6a 1c                	push   $0x1c
  801f1a:	e8 b6 fc ff ff       	call   801bd5 <syscall>
  801f1f:	83 c4 18             	add    $0x18,%esp
}
  801f22:	c9                   	leave  
  801f23:	c3                   	ret    

00801f24 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f24:	55                   	push   %ebp
  801f25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f27:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	52                   	push   %edx
  801f34:	50                   	push   %eax
  801f35:	6a 1d                	push   $0x1d
  801f37:	e8 99 fc ff ff       	call   801bd5 <syscall>
  801f3c:	83 c4 18             	add    $0x18,%esp
}
  801f3f:	c9                   	leave  
  801f40:	c3                   	ret    

00801f41 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f41:	55                   	push   %ebp
  801f42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f44:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f47:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	51                   	push   %ecx
  801f52:	52                   	push   %edx
  801f53:	50                   	push   %eax
  801f54:	6a 1e                	push   $0x1e
  801f56:	e8 7a fc ff ff       	call   801bd5 <syscall>
  801f5b:	83 c4 18             	add    $0x18,%esp
}
  801f5e:	c9                   	leave  
  801f5f:	c3                   	ret    

00801f60 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f60:	55                   	push   %ebp
  801f61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f63:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f66:	8b 45 08             	mov    0x8(%ebp),%eax
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	52                   	push   %edx
  801f70:	50                   	push   %eax
  801f71:	6a 1f                	push   $0x1f
  801f73:	e8 5d fc ff ff       	call   801bd5 <syscall>
  801f78:	83 c4 18             	add    $0x18,%esp
}
  801f7b:	c9                   	leave  
  801f7c:	c3                   	ret    

00801f7d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f7d:	55                   	push   %ebp
  801f7e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	6a 00                	push   $0x0
  801f88:	6a 00                	push   $0x0
  801f8a:	6a 20                	push   $0x20
  801f8c:	e8 44 fc ff ff       	call   801bd5 <syscall>
  801f91:	83 c4 18             	add    $0x18,%esp
}
  801f94:	c9                   	leave  
  801f95:	c3                   	ret    

00801f96 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801f96:	55                   	push   %ebp
  801f97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801f99:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9c:	6a 00                	push   $0x0
  801f9e:	6a 00                	push   $0x0
  801fa0:	ff 75 10             	pushl  0x10(%ebp)
  801fa3:	ff 75 0c             	pushl  0xc(%ebp)
  801fa6:	50                   	push   %eax
  801fa7:	6a 21                	push   $0x21
  801fa9:	e8 27 fc ff ff       	call   801bd5 <syscall>
  801fae:	83 c4 18             	add    $0x18,%esp
}
  801fb1:	c9                   	leave  
  801fb2:	c3                   	ret    

00801fb3 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801fb3:	55                   	push   %ebp
  801fb4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	50                   	push   %eax
  801fc2:	6a 22                	push   $0x22
  801fc4:	e8 0c fc ff ff       	call   801bd5 <syscall>
  801fc9:	83 c4 18             	add    $0x18,%esp
}
  801fcc:	90                   	nop
  801fcd:	c9                   	leave  
  801fce:	c3                   	ret    

00801fcf <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801fcf:	55                   	push   %ebp
  801fd0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801fd2:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 00                	push   $0x0
  801fdb:	6a 00                	push   $0x0
  801fdd:	50                   	push   %eax
  801fde:	6a 23                	push   $0x23
  801fe0:	e8 f0 fb ff ff       	call   801bd5 <syscall>
  801fe5:	83 c4 18             	add    $0x18,%esp
}
  801fe8:	90                   	nop
  801fe9:	c9                   	leave  
  801fea:	c3                   	ret    

00801feb <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801feb:	55                   	push   %ebp
  801fec:	89 e5                	mov    %esp,%ebp
  801fee:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ff1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ff4:	8d 50 04             	lea    0x4(%eax),%edx
  801ff7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ffa:	6a 00                	push   $0x0
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 00                	push   $0x0
  802000:	52                   	push   %edx
  802001:	50                   	push   %eax
  802002:	6a 24                	push   $0x24
  802004:	e8 cc fb ff ff       	call   801bd5 <syscall>
  802009:	83 c4 18             	add    $0x18,%esp
	return result;
  80200c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80200f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802012:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802015:	89 01                	mov    %eax,(%ecx)
  802017:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80201a:	8b 45 08             	mov    0x8(%ebp),%eax
  80201d:	c9                   	leave  
  80201e:	c2 04 00             	ret    $0x4

00802021 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802021:	55                   	push   %ebp
  802022:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	ff 75 10             	pushl  0x10(%ebp)
  80202b:	ff 75 0c             	pushl  0xc(%ebp)
  80202e:	ff 75 08             	pushl  0x8(%ebp)
  802031:	6a 13                	push   $0x13
  802033:	e8 9d fb ff ff       	call   801bd5 <syscall>
  802038:	83 c4 18             	add    $0x18,%esp
	return ;
  80203b:	90                   	nop
}
  80203c:	c9                   	leave  
  80203d:	c3                   	ret    

0080203e <sys_rcr2>:
uint32 sys_rcr2()
{
  80203e:	55                   	push   %ebp
  80203f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	6a 00                	push   $0x0
  802047:	6a 00                	push   $0x0
  802049:	6a 00                	push   $0x0
  80204b:	6a 25                	push   $0x25
  80204d:	e8 83 fb ff ff       	call   801bd5 <syscall>
  802052:	83 c4 18             	add    $0x18,%esp
}
  802055:	c9                   	leave  
  802056:	c3                   	ret    

00802057 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802057:	55                   	push   %ebp
  802058:	89 e5                	mov    %esp,%ebp
  80205a:	83 ec 04             	sub    $0x4,%esp
  80205d:	8b 45 08             	mov    0x8(%ebp),%eax
  802060:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802063:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802067:	6a 00                	push   $0x0
  802069:	6a 00                	push   $0x0
  80206b:	6a 00                	push   $0x0
  80206d:	6a 00                	push   $0x0
  80206f:	50                   	push   %eax
  802070:	6a 26                	push   $0x26
  802072:	e8 5e fb ff ff       	call   801bd5 <syscall>
  802077:	83 c4 18             	add    $0x18,%esp
	return ;
  80207a:	90                   	nop
}
  80207b:	c9                   	leave  
  80207c:	c3                   	ret    

0080207d <rsttst>:
void rsttst()
{
  80207d:	55                   	push   %ebp
  80207e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	6a 28                	push   $0x28
  80208c:	e8 44 fb ff ff       	call   801bd5 <syscall>
  802091:	83 c4 18             	add    $0x18,%esp
	return ;
  802094:	90                   	nop
}
  802095:	c9                   	leave  
  802096:	c3                   	ret    

00802097 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802097:	55                   	push   %ebp
  802098:	89 e5                	mov    %esp,%ebp
  80209a:	83 ec 04             	sub    $0x4,%esp
  80209d:	8b 45 14             	mov    0x14(%ebp),%eax
  8020a0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8020a3:	8b 55 18             	mov    0x18(%ebp),%edx
  8020a6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020aa:	52                   	push   %edx
  8020ab:	50                   	push   %eax
  8020ac:	ff 75 10             	pushl  0x10(%ebp)
  8020af:	ff 75 0c             	pushl  0xc(%ebp)
  8020b2:	ff 75 08             	pushl  0x8(%ebp)
  8020b5:	6a 27                	push   $0x27
  8020b7:	e8 19 fb ff ff       	call   801bd5 <syscall>
  8020bc:	83 c4 18             	add    $0x18,%esp
	return ;
  8020bf:	90                   	nop
}
  8020c0:	c9                   	leave  
  8020c1:	c3                   	ret    

008020c2 <chktst>:
void chktst(uint32 n)
{
  8020c2:	55                   	push   %ebp
  8020c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	ff 75 08             	pushl  0x8(%ebp)
  8020d0:	6a 29                	push   $0x29
  8020d2:	e8 fe fa ff ff       	call   801bd5 <syscall>
  8020d7:	83 c4 18             	add    $0x18,%esp
	return ;
  8020da:	90                   	nop
}
  8020db:	c9                   	leave  
  8020dc:	c3                   	ret    

008020dd <inctst>:

void inctst()
{
  8020dd:	55                   	push   %ebp
  8020de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8020e0:	6a 00                	push   $0x0
  8020e2:	6a 00                	push   $0x0
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 00                	push   $0x0
  8020e8:	6a 00                	push   $0x0
  8020ea:	6a 2a                	push   $0x2a
  8020ec:	e8 e4 fa ff ff       	call   801bd5 <syscall>
  8020f1:	83 c4 18             	add    $0x18,%esp
	return ;
  8020f4:	90                   	nop
}
  8020f5:	c9                   	leave  
  8020f6:	c3                   	ret    

008020f7 <gettst>:
uint32 gettst()
{
  8020f7:	55                   	push   %ebp
  8020f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	6a 00                	push   $0x0
  802100:	6a 00                	push   $0x0
  802102:	6a 00                	push   $0x0
  802104:	6a 2b                	push   $0x2b
  802106:	e8 ca fa ff ff       	call   801bd5 <syscall>
  80210b:	83 c4 18             	add    $0x18,%esp
}
  80210e:	c9                   	leave  
  80210f:	c3                   	ret    

00802110 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802110:	55                   	push   %ebp
  802111:	89 e5                	mov    %esp,%ebp
  802113:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	6a 00                	push   $0x0
  80211c:	6a 00                	push   $0x0
  80211e:	6a 00                	push   $0x0
  802120:	6a 2c                	push   $0x2c
  802122:	e8 ae fa ff ff       	call   801bd5 <syscall>
  802127:	83 c4 18             	add    $0x18,%esp
  80212a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80212d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802131:	75 07                	jne    80213a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802133:	b8 01 00 00 00       	mov    $0x1,%eax
  802138:	eb 05                	jmp    80213f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80213a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80213f:	c9                   	leave  
  802140:	c3                   	ret    

00802141 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802141:	55                   	push   %ebp
  802142:	89 e5                	mov    %esp,%ebp
  802144:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802147:	6a 00                	push   $0x0
  802149:	6a 00                	push   $0x0
  80214b:	6a 00                	push   $0x0
  80214d:	6a 00                	push   $0x0
  80214f:	6a 00                	push   $0x0
  802151:	6a 2c                	push   $0x2c
  802153:	e8 7d fa ff ff       	call   801bd5 <syscall>
  802158:	83 c4 18             	add    $0x18,%esp
  80215b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80215e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802162:	75 07                	jne    80216b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802164:	b8 01 00 00 00       	mov    $0x1,%eax
  802169:	eb 05                	jmp    802170 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80216b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802170:	c9                   	leave  
  802171:	c3                   	ret    

00802172 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802172:	55                   	push   %ebp
  802173:	89 e5                	mov    %esp,%ebp
  802175:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	6a 00                	push   $0x0
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	6a 2c                	push   $0x2c
  802184:	e8 4c fa ff ff       	call   801bd5 <syscall>
  802189:	83 c4 18             	add    $0x18,%esp
  80218c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80218f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802193:	75 07                	jne    80219c <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802195:	b8 01 00 00 00       	mov    $0x1,%eax
  80219a:	eb 05                	jmp    8021a1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80219c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021a1:	c9                   	leave  
  8021a2:	c3                   	ret    

008021a3 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8021a3:	55                   	push   %ebp
  8021a4:	89 e5                	mov    %esp,%ebp
  8021a6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 00                	push   $0x0
  8021b1:	6a 00                	push   $0x0
  8021b3:	6a 2c                	push   $0x2c
  8021b5:	e8 1b fa ff ff       	call   801bd5 <syscall>
  8021ba:	83 c4 18             	add    $0x18,%esp
  8021bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8021c0:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8021c4:	75 07                	jne    8021cd <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8021c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8021cb:	eb 05                	jmp    8021d2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8021cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021d2:	c9                   	leave  
  8021d3:	c3                   	ret    

008021d4 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8021d4:	55                   	push   %ebp
  8021d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021d7:	6a 00                	push   $0x0
  8021d9:	6a 00                	push   $0x0
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 00                	push   $0x0
  8021df:	ff 75 08             	pushl  0x8(%ebp)
  8021e2:	6a 2d                	push   $0x2d
  8021e4:	e8 ec f9 ff ff       	call   801bd5 <syscall>
  8021e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8021ec:	90                   	nop
}
  8021ed:	c9                   	leave  
  8021ee:	c3                   	ret    
  8021ef:	90                   	nop

008021f0 <__udivdi3>:
  8021f0:	55                   	push   %ebp
  8021f1:	57                   	push   %edi
  8021f2:	56                   	push   %esi
  8021f3:	53                   	push   %ebx
  8021f4:	83 ec 1c             	sub    $0x1c,%esp
  8021f7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021fb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021ff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802203:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802207:	89 ca                	mov    %ecx,%edx
  802209:	89 f8                	mov    %edi,%eax
  80220b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80220f:	85 f6                	test   %esi,%esi
  802211:	75 2d                	jne    802240 <__udivdi3+0x50>
  802213:	39 cf                	cmp    %ecx,%edi
  802215:	77 65                	ja     80227c <__udivdi3+0x8c>
  802217:	89 fd                	mov    %edi,%ebp
  802219:	85 ff                	test   %edi,%edi
  80221b:	75 0b                	jne    802228 <__udivdi3+0x38>
  80221d:	b8 01 00 00 00       	mov    $0x1,%eax
  802222:	31 d2                	xor    %edx,%edx
  802224:	f7 f7                	div    %edi
  802226:	89 c5                	mov    %eax,%ebp
  802228:	31 d2                	xor    %edx,%edx
  80222a:	89 c8                	mov    %ecx,%eax
  80222c:	f7 f5                	div    %ebp
  80222e:	89 c1                	mov    %eax,%ecx
  802230:	89 d8                	mov    %ebx,%eax
  802232:	f7 f5                	div    %ebp
  802234:	89 cf                	mov    %ecx,%edi
  802236:	89 fa                	mov    %edi,%edx
  802238:	83 c4 1c             	add    $0x1c,%esp
  80223b:	5b                   	pop    %ebx
  80223c:	5e                   	pop    %esi
  80223d:	5f                   	pop    %edi
  80223e:	5d                   	pop    %ebp
  80223f:	c3                   	ret    
  802240:	39 ce                	cmp    %ecx,%esi
  802242:	77 28                	ja     80226c <__udivdi3+0x7c>
  802244:	0f bd fe             	bsr    %esi,%edi
  802247:	83 f7 1f             	xor    $0x1f,%edi
  80224a:	75 40                	jne    80228c <__udivdi3+0x9c>
  80224c:	39 ce                	cmp    %ecx,%esi
  80224e:	72 0a                	jb     80225a <__udivdi3+0x6a>
  802250:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802254:	0f 87 9e 00 00 00    	ja     8022f8 <__udivdi3+0x108>
  80225a:	b8 01 00 00 00       	mov    $0x1,%eax
  80225f:	89 fa                	mov    %edi,%edx
  802261:	83 c4 1c             	add    $0x1c,%esp
  802264:	5b                   	pop    %ebx
  802265:	5e                   	pop    %esi
  802266:	5f                   	pop    %edi
  802267:	5d                   	pop    %ebp
  802268:	c3                   	ret    
  802269:	8d 76 00             	lea    0x0(%esi),%esi
  80226c:	31 ff                	xor    %edi,%edi
  80226e:	31 c0                	xor    %eax,%eax
  802270:	89 fa                	mov    %edi,%edx
  802272:	83 c4 1c             	add    $0x1c,%esp
  802275:	5b                   	pop    %ebx
  802276:	5e                   	pop    %esi
  802277:	5f                   	pop    %edi
  802278:	5d                   	pop    %ebp
  802279:	c3                   	ret    
  80227a:	66 90                	xchg   %ax,%ax
  80227c:	89 d8                	mov    %ebx,%eax
  80227e:	f7 f7                	div    %edi
  802280:	31 ff                	xor    %edi,%edi
  802282:	89 fa                	mov    %edi,%edx
  802284:	83 c4 1c             	add    $0x1c,%esp
  802287:	5b                   	pop    %ebx
  802288:	5e                   	pop    %esi
  802289:	5f                   	pop    %edi
  80228a:	5d                   	pop    %ebp
  80228b:	c3                   	ret    
  80228c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802291:	89 eb                	mov    %ebp,%ebx
  802293:	29 fb                	sub    %edi,%ebx
  802295:	89 f9                	mov    %edi,%ecx
  802297:	d3 e6                	shl    %cl,%esi
  802299:	89 c5                	mov    %eax,%ebp
  80229b:	88 d9                	mov    %bl,%cl
  80229d:	d3 ed                	shr    %cl,%ebp
  80229f:	89 e9                	mov    %ebp,%ecx
  8022a1:	09 f1                	or     %esi,%ecx
  8022a3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8022a7:	89 f9                	mov    %edi,%ecx
  8022a9:	d3 e0                	shl    %cl,%eax
  8022ab:	89 c5                	mov    %eax,%ebp
  8022ad:	89 d6                	mov    %edx,%esi
  8022af:	88 d9                	mov    %bl,%cl
  8022b1:	d3 ee                	shr    %cl,%esi
  8022b3:	89 f9                	mov    %edi,%ecx
  8022b5:	d3 e2                	shl    %cl,%edx
  8022b7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022bb:	88 d9                	mov    %bl,%cl
  8022bd:	d3 e8                	shr    %cl,%eax
  8022bf:	09 c2                	or     %eax,%edx
  8022c1:	89 d0                	mov    %edx,%eax
  8022c3:	89 f2                	mov    %esi,%edx
  8022c5:	f7 74 24 0c          	divl   0xc(%esp)
  8022c9:	89 d6                	mov    %edx,%esi
  8022cb:	89 c3                	mov    %eax,%ebx
  8022cd:	f7 e5                	mul    %ebp
  8022cf:	39 d6                	cmp    %edx,%esi
  8022d1:	72 19                	jb     8022ec <__udivdi3+0xfc>
  8022d3:	74 0b                	je     8022e0 <__udivdi3+0xf0>
  8022d5:	89 d8                	mov    %ebx,%eax
  8022d7:	31 ff                	xor    %edi,%edi
  8022d9:	e9 58 ff ff ff       	jmp    802236 <__udivdi3+0x46>
  8022de:	66 90                	xchg   %ax,%ax
  8022e0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022e4:	89 f9                	mov    %edi,%ecx
  8022e6:	d3 e2                	shl    %cl,%edx
  8022e8:	39 c2                	cmp    %eax,%edx
  8022ea:	73 e9                	jae    8022d5 <__udivdi3+0xe5>
  8022ec:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022ef:	31 ff                	xor    %edi,%edi
  8022f1:	e9 40 ff ff ff       	jmp    802236 <__udivdi3+0x46>
  8022f6:	66 90                	xchg   %ax,%ax
  8022f8:	31 c0                	xor    %eax,%eax
  8022fa:	e9 37 ff ff ff       	jmp    802236 <__udivdi3+0x46>
  8022ff:	90                   	nop

00802300 <__umoddi3>:
  802300:	55                   	push   %ebp
  802301:	57                   	push   %edi
  802302:	56                   	push   %esi
  802303:	53                   	push   %ebx
  802304:	83 ec 1c             	sub    $0x1c,%esp
  802307:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80230b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80230f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802313:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802317:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80231b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80231f:	89 f3                	mov    %esi,%ebx
  802321:	89 fa                	mov    %edi,%edx
  802323:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802327:	89 34 24             	mov    %esi,(%esp)
  80232a:	85 c0                	test   %eax,%eax
  80232c:	75 1a                	jne    802348 <__umoddi3+0x48>
  80232e:	39 f7                	cmp    %esi,%edi
  802330:	0f 86 a2 00 00 00    	jbe    8023d8 <__umoddi3+0xd8>
  802336:	89 c8                	mov    %ecx,%eax
  802338:	89 f2                	mov    %esi,%edx
  80233a:	f7 f7                	div    %edi
  80233c:	89 d0                	mov    %edx,%eax
  80233e:	31 d2                	xor    %edx,%edx
  802340:	83 c4 1c             	add    $0x1c,%esp
  802343:	5b                   	pop    %ebx
  802344:	5e                   	pop    %esi
  802345:	5f                   	pop    %edi
  802346:	5d                   	pop    %ebp
  802347:	c3                   	ret    
  802348:	39 f0                	cmp    %esi,%eax
  80234a:	0f 87 ac 00 00 00    	ja     8023fc <__umoddi3+0xfc>
  802350:	0f bd e8             	bsr    %eax,%ebp
  802353:	83 f5 1f             	xor    $0x1f,%ebp
  802356:	0f 84 ac 00 00 00    	je     802408 <__umoddi3+0x108>
  80235c:	bf 20 00 00 00       	mov    $0x20,%edi
  802361:	29 ef                	sub    %ebp,%edi
  802363:	89 fe                	mov    %edi,%esi
  802365:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802369:	89 e9                	mov    %ebp,%ecx
  80236b:	d3 e0                	shl    %cl,%eax
  80236d:	89 d7                	mov    %edx,%edi
  80236f:	89 f1                	mov    %esi,%ecx
  802371:	d3 ef                	shr    %cl,%edi
  802373:	09 c7                	or     %eax,%edi
  802375:	89 e9                	mov    %ebp,%ecx
  802377:	d3 e2                	shl    %cl,%edx
  802379:	89 14 24             	mov    %edx,(%esp)
  80237c:	89 d8                	mov    %ebx,%eax
  80237e:	d3 e0                	shl    %cl,%eax
  802380:	89 c2                	mov    %eax,%edx
  802382:	8b 44 24 08          	mov    0x8(%esp),%eax
  802386:	d3 e0                	shl    %cl,%eax
  802388:	89 44 24 04          	mov    %eax,0x4(%esp)
  80238c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802390:	89 f1                	mov    %esi,%ecx
  802392:	d3 e8                	shr    %cl,%eax
  802394:	09 d0                	or     %edx,%eax
  802396:	d3 eb                	shr    %cl,%ebx
  802398:	89 da                	mov    %ebx,%edx
  80239a:	f7 f7                	div    %edi
  80239c:	89 d3                	mov    %edx,%ebx
  80239e:	f7 24 24             	mull   (%esp)
  8023a1:	89 c6                	mov    %eax,%esi
  8023a3:	89 d1                	mov    %edx,%ecx
  8023a5:	39 d3                	cmp    %edx,%ebx
  8023a7:	0f 82 87 00 00 00    	jb     802434 <__umoddi3+0x134>
  8023ad:	0f 84 91 00 00 00    	je     802444 <__umoddi3+0x144>
  8023b3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8023b7:	29 f2                	sub    %esi,%edx
  8023b9:	19 cb                	sbb    %ecx,%ebx
  8023bb:	89 d8                	mov    %ebx,%eax
  8023bd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8023c1:	d3 e0                	shl    %cl,%eax
  8023c3:	89 e9                	mov    %ebp,%ecx
  8023c5:	d3 ea                	shr    %cl,%edx
  8023c7:	09 d0                	or     %edx,%eax
  8023c9:	89 e9                	mov    %ebp,%ecx
  8023cb:	d3 eb                	shr    %cl,%ebx
  8023cd:	89 da                	mov    %ebx,%edx
  8023cf:	83 c4 1c             	add    $0x1c,%esp
  8023d2:	5b                   	pop    %ebx
  8023d3:	5e                   	pop    %esi
  8023d4:	5f                   	pop    %edi
  8023d5:	5d                   	pop    %ebp
  8023d6:	c3                   	ret    
  8023d7:	90                   	nop
  8023d8:	89 fd                	mov    %edi,%ebp
  8023da:	85 ff                	test   %edi,%edi
  8023dc:	75 0b                	jne    8023e9 <__umoddi3+0xe9>
  8023de:	b8 01 00 00 00       	mov    $0x1,%eax
  8023e3:	31 d2                	xor    %edx,%edx
  8023e5:	f7 f7                	div    %edi
  8023e7:	89 c5                	mov    %eax,%ebp
  8023e9:	89 f0                	mov    %esi,%eax
  8023eb:	31 d2                	xor    %edx,%edx
  8023ed:	f7 f5                	div    %ebp
  8023ef:	89 c8                	mov    %ecx,%eax
  8023f1:	f7 f5                	div    %ebp
  8023f3:	89 d0                	mov    %edx,%eax
  8023f5:	e9 44 ff ff ff       	jmp    80233e <__umoddi3+0x3e>
  8023fa:	66 90                	xchg   %ax,%ax
  8023fc:	89 c8                	mov    %ecx,%eax
  8023fe:	89 f2                	mov    %esi,%edx
  802400:	83 c4 1c             	add    $0x1c,%esp
  802403:	5b                   	pop    %ebx
  802404:	5e                   	pop    %esi
  802405:	5f                   	pop    %edi
  802406:	5d                   	pop    %ebp
  802407:	c3                   	ret    
  802408:	3b 04 24             	cmp    (%esp),%eax
  80240b:	72 06                	jb     802413 <__umoddi3+0x113>
  80240d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802411:	77 0f                	ja     802422 <__umoddi3+0x122>
  802413:	89 f2                	mov    %esi,%edx
  802415:	29 f9                	sub    %edi,%ecx
  802417:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80241b:	89 14 24             	mov    %edx,(%esp)
  80241e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802422:	8b 44 24 04          	mov    0x4(%esp),%eax
  802426:	8b 14 24             	mov    (%esp),%edx
  802429:	83 c4 1c             	add    $0x1c,%esp
  80242c:	5b                   	pop    %ebx
  80242d:	5e                   	pop    %esi
  80242e:	5f                   	pop    %edi
  80242f:	5d                   	pop    %ebp
  802430:	c3                   	ret    
  802431:	8d 76 00             	lea    0x0(%esi),%esi
  802434:	2b 04 24             	sub    (%esp),%eax
  802437:	19 fa                	sbb    %edi,%edx
  802439:	89 d1                	mov    %edx,%ecx
  80243b:	89 c6                	mov    %eax,%esi
  80243d:	e9 71 ff ff ff       	jmp    8023b3 <__umoddi3+0xb3>
  802442:	66 90                	xchg   %ax,%ax
  802444:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802448:	72 ea                	jb     802434 <__umoddi3+0x134>
  80244a:	89 d9                	mov    %ebx,%ecx
  80244c:	e9 62 ff ff ff       	jmp    8023b3 <__umoddi3+0xb3>
