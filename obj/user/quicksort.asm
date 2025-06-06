
obj/user/quicksort:     file format elf32-i386


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
  800031:	e8 a0 05 00 00       	call   8005d6 <libmain>
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
  800049:	e8 ca 1c 00 00       	call   801d18 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 dc 1c 00 00       	call   801d31 <sys_calculate_modified_frames>
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
  800067:	68 40 24 80 00       	push   $0x802440
  80006c:	e8 9d 0f 00 00       	call   80100e <readline>
  800071:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  800074:	83 ec 04             	sub    $0x4,%esp
  800077:	6a 0a                	push   $0xa
  800079:	6a 00                	push   $0x0
  80007b:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 ed 14 00 00       	call   801574 <strtol>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 ec             	mov    %eax,-0x14(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80008d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 ba 18 00 00       	call   801956 <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 60 24 80 00       	push   $0x802460
  8000aa:	e8 dd 08 00 00       	call   80098c <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 83 24 80 00       	push   $0x802483
  8000ba:	e8 cd 08 00 00       	call   80098c <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 91 24 80 00       	push   $0x802491
  8000ca:	e8 bd 08 00 00       	call   80098c <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\nSelect: ") ;
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 a0 24 80 00       	push   $0x8024a0
  8000da:	e8 ad 08 00 00       	call   80098c <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8000e2:	e8 97 04 00 00       	call   80057e <getchar>
  8000e7:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  8000ea:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8000ee:	83 ec 0c             	sub    $0xc,%esp
  8000f1:	50                   	push   %eax
  8000f2:	e8 3f 04 00 00       	call   800536 <cputchar>
  8000f7:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8000fa:	83 ec 0c             	sub    $0xc,%esp
  8000fd:	6a 0a                	push   $0xa
  8000ff:	e8 32 04 00 00       	call   800536 <cputchar>
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
  800123:	e8 d6 02 00 00       	call   8003fe <InitializeAscending>
  800128:	83 c4 10             	add    $0x10,%esp
			break ;
  80012b:	eb 37                	jmp    800164 <_main+0x12c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80012d:	83 ec 08             	sub    $0x8,%esp
  800130:	ff 75 ec             	pushl  -0x14(%ebp)
  800133:	ff 75 e8             	pushl  -0x18(%ebp)
  800136:	e8 f4 02 00 00       	call   80042f <InitializeDescending>
  80013b:	83 c4 10             	add    $0x10,%esp
			break ;
  80013e:	eb 24                	jmp    800164 <_main+0x12c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800140:	83 ec 08             	sub    $0x8,%esp
  800143:	ff 75 ec             	pushl  -0x14(%ebp)
  800146:	ff 75 e8             	pushl  -0x18(%ebp)
  800149:	e8 16 03 00 00       	call   800464 <InitializeSemiRandom>
  80014e:	83 c4 10             	add    $0x10,%esp
			break ;
  800151:	eb 11                	jmp    800164 <_main+0x12c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800153:	83 ec 08             	sub    $0x8,%esp
  800156:	ff 75 ec             	pushl  -0x14(%ebp)
  800159:	ff 75 e8             	pushl  -0x18(%ebp)
  80015c:	e8 03 03 00 00       	call   800464 <InitializeSemiRandom>
  800161:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800164:	83 ec 08             	sub    $0x8,%esp
  800167:	ff 75 ec             	pushl  -0x14(%ebp)
  80016a:	ff 75 e8             	pushl  -0x18(%ebp)
  80016d:	e8 d1 00 00 00       	call   800243 <QuickSort>
  800172:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800175:	83 ec 08             	sub    $0x8,%esp
  800178:	ff 75 ec             	pushl  -0x14(%ebp)
  80017b:	ff 75 e8             	pushl  -0x18(%ebp)
  80017e:	e8 d1 01 00 00       	call   800354 <CheckSorted>
  800183:	83 c4 10             	add    $0x10,%esp
  800186:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800189:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80018d:	75 14                	jne    8001a3 <_main+0x16b>
  80018f:	83 ec 04             	sub    $0x4,%esp
  800192:	68 b8 24 80 00       	push   $0x8024b8
  800197:	6a 41                	push   $0x41
  800199:	68 da 24 80 00       	push   $0x8024da
  80019e:	e8 35 05 00 00       	call   8006d8 <_panic>
		else
		{ 
				cprintf("\n===============================================\n") ;
  8001a3:	83 ec 0c             	sub    $0xc,%esp
  8001a6:	68 ec 24 80 00       	push   $0x8024ec
  8001ab:	e8 dc 07 00 00       	call   80098c <cprintf>
  8001b0:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001b3:	83 ec 0c             	sub    $0xc,%esp
  8001b6:	68 20 25 80 00       	push   $0x802520
  8001bb:	e8 cc 07 00 00       	call   80098c <cprintf>
  8001c0:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  8001c3:	83 ec 0c             	sub    $0xc,%esp
  8001c6:	68 54 25 80 00       	push   $0x802554
  8001cb:	e8 bc 07 00 00       	call   80098c <cprintf>
  8001d0:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

			cprintf("Freeing the Heap...\n\n") ;
  8001d3:	83 ec 0c             	sub    $0xc,%esp
  8001d6:	68 86 25 80 00       	push   $0x802586
  8001db:	e8 ac 07 00 00       	call   80098c <cprintf>
  8001e0:	83 c4 10             	add    $0x10,%esp

			free(Elements) ;
  8001e3:	83 ec 0c             	sub    $0xc,%esp
  8001e6:	ff 75 e8             	pushl  -0x18(%ebp)
  8001e9:	e8 89 18 00 00       	call   801a77 <free>
  8001ee:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
			cprintf("Do you want to repeat (y/n): ") ;
  8001f1:	83 ec 0c             	sub    $0xc,%esp
  8001f4:	68 9c 25 80 00       	push   $0x80259c
  8001f9:	e8 8e 07 00 00       	call   80098c <cprintf>
  8001fe:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800201:	e8 78 03 00 00       	call   80057e <getchar>
  800206:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  800209:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80020d:	83 ec 0c             	sub    $0xc,%esp
  800210:	50                   	push   %eax
  800211:	e8 20 03 00 00       	call   800536 <cputchar>
  800216:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800219:	83 ec 0c             	sub    $0xc,%esp
  80021c:	6a 0a                	push   $0xa
  80021e:	e8 13 03 00 00       	call   800536 <cputchar>
  800223:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800226:	83 ec 0c             	sub    $0xc,%esp
  800229:	6a 0a                	push   $0xa
  80022b:	e8 06 03 00 00       	call   800536 <cputchar>
  800230:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();

	} while (Chose == 'y');
  800233:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800237:	0f 84 0c fe ff ff    	je     800049 <_main+0x11>

}
  80023d:	90                   	nop
  80023e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800241:	c9                   	leave  
  800242:	c3                   	ret    

00800243 <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  800243:	55                   	push   %ebp
  800244:	89 e5                	mov    %esp,%ebp
  800246:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800249:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024c:	48                   	dec    %eax
  80024d:	50                   	push   %eax
  80024e:	6a 00                	push   $0x0
  800250:	ff 75 0c             	pushl  0xc(%ebp)
  800253:	ff 75 08             	pushl  0x8(%ebp)
  800256:	e8 06 00 00 00       	call   800261 <QSort>
  80025b:	83 c4 10             	add    $0x10,%esp
}
  80025e:	90                   	nop
  80025f:	c9                   	leave  
  800260:	c3                   	ret    

00800261 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800261:	55                   	push   %ebp
  800262:	89 e5                	mov    %esp,%ebp
  800264:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800267:	8b 45 10             	mov    0x10(%ebp),%eax
  80026a:	3b 45 14             	cmp    0x14(%ebp),%eax
  80026d:	0f 8d de 00 00 00    	jge    800351 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800273:	8b 45 10             	mov    0x10(%ebp),%eax
  800276:	40                   	inc    %eax
  800277:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80027a:	8b 45 14             	mov    0x14(%ebp),%eax
  80027d:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800280:	e9 80 00 00 00       	jmp    800305 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800285:	ff 45 f4             	incl   -0xc(%ebp)
  800288:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80028b:	3b 45 14             	cmp    0x14(%ebp),%eax
  80028e:	7f 2b                	jg     8002bb <QSort+0x5a>
  800290:	8b 45 10             	mov    0x10(%ebp),%eax
  800293:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80029a:	8b 45 08             	mov    0x8(%ebp),%eax
  80029d:	01 d0                	add    %edx,%eax
  80029f:	8b 10                	mov    (%eax),%edx
  8002a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002a4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ae:	01 c8                	add    %ecx,%eax
  8002b0:	8b 00                	mov    (%eax),%eax
  8002b2:	39 c2                	cmp    %eax,%edx
  8002b4:	7d cf                	jge    800285 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002b6:	eb 03                	jmp    8002bb <QSort+0x5a>
  8002b8:	ff 4d f0             	decl   -0x10(%ebp)
  8002bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002be:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002c1:	7e 26                	jle    8002e9 <QSort+0x88>
  8002c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8002c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d0:	01 d0                	add    %edx,%eax
  8002d2:	8b 10                	mov    (%eax),%edx
  8002d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002d7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002de:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e1:	01 c8                	add    %ecx,%eax
  8002e3:	8b 00                	mov    (%eax),%eax
  8002e5:	39 c2                	cmp    %eax,%edx
  8002e7:	7e cf                	jle    8002b8 <QSort+0x57>

		if (i <= j)
  8002e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002ec:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002ef:	7f 14                	jg     800305 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8002f1:	83 ec 04             	sub    $0x4,%esp
  8002f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8002f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8002fa:	ff 75 08             	pushl  0x8(%ebp)
  8002fd:	e8 a9 00 00 00       	call   8003ab <Swap>
  800302:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800305:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800308:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80030b:	0f 8e 77 ff ff ff    	jle    800288 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800311:	83 ec 04             	sub    $0x4,%esp
  800314:	ff 75 f0             	pushl  -0x10(%ebp)
  800317:	ff 75 10             	pushl  0x10(%ebp)
  80031a:	ff 75 08             	pushl  0x8(%ebp)
  80031d:	e8 89 00 00 00       	call   8003ab <Swap>
  800322:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800325:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800328:	48                   	dec    %eax
  800329:	50                   	push   %eax
  80032a:	ff 75 10             	pushl  0x10(%ebp)
  80032d:	ff 75 0c             	pushl  0xc(%ebp)
  800330:	ff 75 08             	pushl  0x8(%ebp)
  800333:	e8 29 ff ff ff       	call   800261 <QSort>
  800338:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80033b:	ff 75 14             	pushl  0x14(%ebp)
  80033e:	ff 75 f4             	pushl  -0xc(%ebp)
  800341:	ff 75 0c             	pushl  0xc(%ebp)
  800344:	ff 75 08             	pushl  0x8(%ebp)
  800347:	e8 15 ff ff ff       	call   800261 <QSort>
  80034c:	83 c4 10             	add    $0x10,%esp
  80034f:	eb 01                	jmp    800352 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800351:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800352:	c9                   	leave  
  800353:	c3                   	ret    

00800354 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800354:	55                   	push   %ebp
  800355:	89 e5                	mov    %esp,%ebp
  800357:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80035a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800361:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800368:	eb 33                	jmp    80039d <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80036a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80036d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800374:	8b 45 08             	mov    0x8(%ebp),%eax
  800377:	01 d0                	add    %edx,%eax
  800379:	8b 10                	mov    (%eax),%edx
  80037b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80037e:	40                   	inc    %eax
  80037f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800386:	8b 45 08             	mov    0x8(%ebp),%eax
  800389:	01 c8                	add    %ecx,%eax
  80038b:	8b 00                	mov    (%eax),%eax
  80038d:	39 c2                	cmp    %eax,%edx
  80038f:	7e 09                	jle    80039a <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800391:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800398:	eb 0c                	jmp    8003a6 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80039a:	ff 45 f8             	incl   -0x8(%ebp)
  80039d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a0:	48                   	dec    %eax
  8003a1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003a4:	7f c4                	jg     80036a <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003a9:	c9                   	leave  
  8003aa:	c3                   	ret    

008003ab <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003ab:	55                   	push   %ebp
  8003ac:	89 e5                	mov    %esp,%ebp
  8003ae:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003be:	01 d0                	add    %edx,%eax
  8003c0:	8b 00                	mov    (%eax),%eax
  8003c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d2:	01 c2                	add    %eax,%edx
  8003d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8003d7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003de:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e1:	01 c8                	add    %ecx,%eax
  8003e3:	8b 00                	mov    (%eax),%eax
  8003e5:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8003e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8003ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f4:	01 c2                	add    %eax,%edx
  8003f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003f9:	89 02                	mov    %eax,(%edx)
}
  8003fb:	90                   	nop
  8003fc:	c9                   	leave  
  8003fd:	c3                   	ret    

008003fe <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8003fe:	55                   	push   %ebp
  8003ff:	89 e5                	mov    %esp,%ebp
  800401:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800404:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80040b:	eb 17                	jmp    800424 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80040d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800410:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800417:	8b 45 08             	mov    0x8(%ebp),%eax
  80041a:	01 c2                	add    %eax,%edx
  80041c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80041f:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800421:	ff 45 fc             	incl   -0x4(%ebp)
  800424:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800427:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80042a:	7c e1                	jl     80040d <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80042c:	90                   	nop
  80042d:	c9                   	leave  
  80042e:	c3                   	ret    

0080042f <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80042f:	55                   	push   %ebp
  800430:	89 e5                	mov    %esp,%ebp
  800432:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800435:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80043c:	eb 1b                	jmp    800459 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  80043e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800441:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	01 c2                	add    %eax,%edx
  80044d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800450:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800453:	48                   	dec    %eax
  800454:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800456:	ff 45 fc             	incl   -0x4(%ebp)
  800459:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80045c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80045f:	7c dd                	jl     80043e <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800461:	90                   	nop
  800462:	c9                   	leave  
  800463:	c3                   	ret    

00800464 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800464:	55                   	push   %ebp
  800465:	89 e5                	mov    %esp,%ebp
  800467:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80046a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80046d:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800472:	f7 e9                	imul   %ecx
  800474:	c1 f9 1f             	sar    $0x1f,%ecx
  800477:	89 d0                	mov    %edx,%eax
  800479:	29 c8                	sub    %ecx,%eax
  80047b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  80047e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800485:	eb 1e                	jmp    8004a5 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800487:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800491:	8b 45 08             	mov    0x8(%ebp),%eax
  800494:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800497:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049a:	99                   	cltd   
  80049b:	f7 7d f8             	idivl  -0x8(%ebp)
  80049e:	89 d0                	mov    %edx,%eax
  8004a0:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a2:	ff 45 fc             	incl   -0x4(%ebp)
  8004a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004ab:	7c da                	jl     800487 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004ad:	90                   	nop
  8004ae:	c9                   	leave  
  8004af:	c3                   	ret    

008004b0 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004b0:	55                   	push   %ebp
  8004b1:	89 e5                	mov    %esp,%ebp
  8004b3:	83 ec 18             	sub    $0x18,%esp
		int i ;
		int NumsPerLine = 20 ;
  8004b6:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8004bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004c4:	eb 42                	jmp    800508 <PrintElements+0x58>
		{
			if (i%NumsPerLine == 0)
  8004c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004c9:	99                   	cltd   
  8004ca:	f7 7d f0             	idivl  -0x10(%ebp)
  8004cd:	89 d0                	mov    %edx,%eax
  8004cf:	85 c0                	test   %eax,%eax
  8004d1:	75 10                	jne    8004e3 <PrintElements+0x33>
				cprintf("\n");
  8004d3:	83 ec 0c             	sub    $0xc,%esp
  8004d6:	68 ba 25 80 00       	push   $0x8025ba
  8004db:	e8 ac 04 00 00       	call   80098c <cprintf>
  8004e0:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  8004e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f0:	01 d0                	add    %edx,%eax
  8004f2:	8b 00                	mov    (%eax),%eax
  8004f4:	83 ec 08             	sub    $0x8,%esp
  8004f7:	50                   	push   %eax
  8004f8:	68 bc 25 80 00       	push   $0x8025bc
  8004fd:	e8 8a 04 00 00       	call   80098c <cprintf>
  800502:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  800505:	ff 45 f4             	incl   -0xc(%ebp)
  800508:	8b 45 0c             	mov    0xc(%ebp),%eax
  80050b:	48                   	dec    %eax
  80050c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80050f:	7f b5                	jg     8004c6 <PrintElements+0x16>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  800511:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800514:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80051b:	8b 45 08             	mov    0x8(%ebp),%eax
  80051e:	01 d0                	add    %edx,%eax
  800520:	8b 00                	mov    (%eax),%eax
  800522:	83 ec 08             	sub    $0x8,%esp
  800525:	50                   	push   %eax
  800526:	68 c1 25 80 00       	push   $0x8025c1
  80052b:	e8 5c 04 00 00       	call   80098c <cprintf>
  800530:	83 c4 10             	add    $0x10,%esp
}
  800533:	90                   	nop
  800534:	c9                   	leave  
  800535:	c3                   	ret    

00800536 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800536:	55                   	push   %ebp
  800537:	89 e5                	mov    %esp,%ebp
  800539:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80053c:	8b 45 08             	mov    0x8(%ebp),%eax
  80053f:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800542:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800546:	83 ec 0c             	sub    $0xc,%esp
  800549:	50                   	push   %eax
  80054a:	e8 cd 18 00 00       	call   801e1c <sys_cputc>
  80054f:	83 c4 10             	add    $0x10,%esp
}
  800552:	90                   	nop
  800553:	c9                   	leave  
  800554:	c3                   	ret    

00800555 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800555:	55                   	push   %ebp
  800556:	89 e5                	mov    %esp,%ebp
  800558:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80055b:	e8 88 18 00 00       	call   801de8 <sys_disable_interrupt>
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
  80056e:	e8 a9 18 00 00       	call   801e1c <sys_cputc>
  800573:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800576:	e8 87 18 00 00       	call   801e02 <sys_enable_interrupt>
}
  80057b:	90                   	nop
  80057c:	c9                   	leave  
  80057d:	c3                   	ret    

0080057e <getchar>:

int
getchar(void)
{
  80057e:	55                   	push   %ebp
  80057f:	89 e5                	mov    %esp,%ebp
  800581:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800584:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80058b:	eb 08                	jmp    800595 <getchar+0x17>
	{
		c = sys_cgetc();
  80058d:	e8 6e 16 00 00       	call   801c00 <sys_cgetc>
  800592:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800595:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800599:	74 f2                	je     80058d <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80059b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80059e:	c9                   	leave  
  80059f:	c3                   	ret    

008005a0 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005a0:	55                   	push   %ebp
  8005a1:	89 e5                	mov    %esp,%ebp
  8005a3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005a6:	e8 3d 18 00 00       	call   801de8 <sys_disable_interrupt>
	int c=0;
  8005ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005b2:	eb 08                	jmp    8005bc <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005b4:	e8 47 16 00 00       	call   801c00 <sys_cgetc>
  8005b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005c0:	74 f2                	je     8005b4 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005c2:	e8 3b 18 00 00       	call   801e02 <sys_enable_interrupt>
	return c;
  8005c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005ca:	c9                   	leave  
  8005cb:	c3                   	ret    

008005cc <iscons>:

int iscons(int fdnum)
{
  8005cc:	55                   	push   %ebp
  8005cd:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005cf:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005d4:	5d                   	pop    %ebp
  8005d5:	c3                   	ret    

008005d6 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005d6:	55                   	push   %ebp
  8005d7:	89 e5                	mov    %esp,%ebp
  8005d9:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005dc:	e8 6c 16 00 00       	call   801c4d <sys_getenvindex>
  8005e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005e7:	89 d0                	mov    %edx,%eax
  8005e9:	01 c0                	add    %eax,%eax
  8005eb:	01 d0                	add    %edx,%eax
  8005ed:	c1 e0 02             	shl    $0x2,%eax
  8005f0:	01 d0                	add    %edx,%eax
  8005f2:	c1 e0 06             	shl    $0x6,%eax
  8005f5:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005fa:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005ff:	a1 24 30 80 00       	mov    0x803024,%eax
  800604:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80060a:	84 c0                	test   %al,%al
  80060c:	74 0f                	je     80061d <libmain+0x47>
		binaryname = myEnv->prog_name;
  80060e:	a1 24 30 80 00       	mov    0x803024,%eax
  800613:	05 f4 02 00 00       	add    $0x2f4,%eax
  800618:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80061d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800621:	7e 0a                	jle    80062d <libmain+0x57>
		binaryname = argv[0];
  800623:	8b 45 0c             	mov    0xc(%ebp),%eax
  800626:	8b 00                	mov    (%eax),%eax
  800628:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80062d:	83 ec 08             	sub    $0x8,%esp
  800630:	ff 75 0c             	pushl  0xc(%ebp)
  800633:	ff 75 08             	pushl  0x8(%ebp)
  800636:	e8 fd f9 ff ff       	call   800038 <_main>
  80063b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80063e:	e8 a5 17 00 00       	call   801de8 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800643:	83 ec 0c             	sub    $0xc,%esp
  800646:	68 e0 25 80 00       	push   $0x8025e0
  80064b:	e8 3c 03 00 00       	call   80098c <cprintf>
  800650:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800653:	a1 24 30 80 00       	mov    0x803024,%eax
  800658:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80065e:	a1 24 30 80 00       	mov    0x803024,%eax
  800663:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800669:	83 ec 04             	sub    $0x4,%esp
  80066c:	52                   	push   %edx
  80066d:	50                   	push   %eax
  80066e:	68 08 26 80 00       	push   $0x802608
  800673:	e8 14 03 00 00       	call   80098c <cprintf>
  800678:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80067b:	a1 24 30 80 00       	mov    0x803024,%eax
  800680:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800686:	83 ec 08             	sub    $0x8,%esp
  800689:	50                   	push   %eax
  80068a:	68 2d 26 80 00       	push   $0x80262d
  80068f:	e8 f8 02 00 00       	call   80098c <cprintf>
  800694:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800697:	83 ec 0c             	sub    $0xc,%esp
  80069a:	68 e0 25 80 00       	push   $0x8025e0
  80069f:	e8 e8 02 00 00       	call   80098c <cprintf>
  8006a4:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006a7:	e8 56 17 00 00       	call   801e02 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006ac:	e8 19 00 00 00       	call   8006ca <exit>
}
  8006b1:	90                   	nop
  8006b2:	c9                   	leave  
  8006b3:	c3                   	ret    

008006b4 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006b4:	55                   	push   %ebp
  8006b5:	89 e5                	mov    %esp,%ebp
  8006b7:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006ba:	83 ec 0c             	sub    $0xc,%esp
  8006bd:	6a 00                	push   $0x0
  8006bf:	e8 55 15 00 00       	call   801c19 <sys_env_destroy>
  8006c4:	83 c4 10             	add    $0x10,%esp
}
  8006c7:	90                   	nop
  8006c8:	c9                   	leave  
  8006c9:	c3                   	ret    

008006ca <exit>:

void
exit(void)
{
  8006ca:	55                   	push   %ebp
  8006cb:	89 e5                	mov    %esp,%ebp
  8006cd:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006d0:	e8 aa 15 00 00       	call   801c7f <sys_env_exit>
}
  8006d5:	90                   	nop
  8006d6:	c9                   	leave  
  8006d7:	c3                   	ret    

008006d8 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006d8:	55                   	push   %ebp
  8006d9:	89 e5                	mov    %esp,%ebp
  8006db:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006de:	8d 45 10             	lea    0x10(%ebp),%eax
  8006e1:	83 c0 04             	add    $0x4,%eax
  8006e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006e7:	a1 34 30 80 00       	mov    0x803034,%eax
  8006ec:	85 c0                	test   %eax,%eax
  8006ee:	74 16                	je     800706 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006f0:	a1 34 30 80 00       	mov    0x803034,%eax
  8006f5:	83 ec 08             	sub    $0x8,%esp
  8006f8:	50                   	push   %eax
  8006f9:	68 44 26 80 00       	push   $0x802644
  8006fe:	e8 89 02 00 00       	call   80098c <cprintf>
  800703:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800706:	a1 00 30 80 00       	mov    0x803000,%eax
  80070b:	ff 75 0c             	pushl  0xc(%ebp)
  80070e:	ff 75 08             	pushl  0x8(%ebp)
  800711:	50                   	push   %eax
  800712:	68 49 26 80 00       	push   $0x802649
  800717:	e8 70 02 00 00       	call   80098c <cprintf>
  80071c:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80071f:	8b 45 10             	mov    0x10(%ebp),%eax
  800722:	83 ec 08             	sub    $0x8,%esp
  800725:	ff 75 f4             	pushl  -0xc(%ebp)
  800728:	50                   	push   %eax
  800729:	e8 f3 01 00 00       	call   800921 <vcprintf>
  80072e:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800731:	83 ec 08             	sub    $0x8,%esp
  800734:	6a 00                	push   $0x0
  800736:	68 65 26 80 00       	push   $0x802665
  80073b:	e8 e1 01 00 00       	call   800921 <vcprintf>
  800740:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800743:	e8 82 ff ff ff       	call   8006ca <exit>

	// should not return here
	while (1) ;
  800748:	eb fe                	jmp    800748 <_panic+0x70>

0080074a <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80074a:	55                   	push   %ebp
  80074b:	89 e5                	mov    %esp,%ebp
  80074d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800750:	a1 24 30 80 00       	mov    0x803024,%eax
  800755:	8b 50 74             	mov    0x74(%eax),%edx
  800758:	8b 45 0c             	mov    0xc(%ebp),%eax
  80075b:	39 c2                	cmp    %eax,%edx
  80075d:	74 14                	je     800773 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80075f:	83 ec 04             	sub    $0x4,%esp
  800762:	68 68 26 80 00       	push   $0x802668
  800767:	6a 26                	push   $0x26
  800769:	68 b4 26 80 00       	push   $0x8026b4
  80076e:	e8 65 ff ff ff       	call   8006d8 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800773:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80077a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800781:	e9 c2 00 00 00       	jmp    800848 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800786:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800789:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800790:	8b 45 08             	mov    0x8(%ebp),%eax
  800793:	01 d0                	add    %edx,%eax
  800795:	8b 00                	mov    (%eax),%eax
  800797:	85 c0                	test   %eax,%eax
  800799:	75 08                	jne    8007a3 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80079b:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80079e:	e9 a2 00 00 00       	jmp    800845 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007a3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007aa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007b1:	eb 69                	jmp    80081c <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007b3:	a1 24 30 80 00       	mov    0x803024,%eax
  8007b8:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007be:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007c1:	89 d0                	mov    %edx,%eax
  8007c3:	01 c0                	add    %eax,%eax
  8007c5:	01 d0                	add    %edx,%eax
  8007c7:	c1 e0 02             	shl    $0x2,%eax
  8007ca:	01 c8                	add    %ecx,%eax
  8007cc:	8a 40 04             	mov    0x4(%eax),%al
  8007cf:	84 c0                	test   %al,%al
  8007d1:	75 46                	jne    800819 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007d3:	a1 24 30 80 00       	mov    0x803024,%eax
  8007d8:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007de:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007e1:	89 d0                	mov    %edx,%eax
  8007e3:	01 c0                	add    %eax,%eax
  8007e5:	01 d0                	add    %edx,%eax
  8007e7:	c1 e0 02             	shl    $0x2,%eax
  8007ea:	01 c8                	add    %ecx,%eax
  8007ec:	8b 00                	mov    (%eax),%eax
  8007ee:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007f1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007f9:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007fe:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800805:	8b 45 08             	mov    0x8(%ebp),%eax
  800808:	01 c8                	add    %ecx,%eax
  80080a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80080c:	39 c2                	cmp    %eax,%edx
  80080e:	75 09                	jne    800819 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800810:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800817:	eb 12                	jmp    80082b <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800819:	ff 45 e8             	incl   -0x18(%ebp)
  80081c:	a1 24 30 80 00       	mov    0x803024,%eax
  800821:	8b 50 74             	mov    0x74(%eax),%edx
  800824:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800827:	39 c2                	cmp    %eax,%edx
  800829:	77 88                	ja     8007b3 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80082b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80082f:	75 14                	jne    800845 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800831:	83 ec 04             	sub    $0x4,%esp
  800834:	68 c0 26 80 00       	push   $0x8026c0
  800839:	6a 3a                	push   $0x3a
  80083b:	68 b4 26 80 00       	push   $0x8026b4
  800840:	e8 93 fe ff ff       	call   8006d8 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800845:	ff 45 f0             	incl   -0x10(%ebp)
  800848:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80084b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80084e:	0f 8c 32 ff ff ff    	jl     800786 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800854:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80085b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800862:	eb 26                	jmp    80088a <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800864:	a1 24 30 80 00       	mov    0x803024,%eax
  800869:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80086f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800872:	89 d0                	mov    %edx,%eax
  800874:	01 c0                	add    %eax,%eax
  800876:	01 d0                	add    %edx,%eax
  800878:	c1 e0 02             	shl    $0x2,%eax
  80087b:	01 c8                	add    %ecx,%eax
  80087d:	8a 40 04             	mov    0x4(%eax),%al
  800880:	3c 01                	cmp    $0x1,%al
  800882:	75 03                	jne    800887 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800884:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800887:	ff 45 e0             	incl   -0x20(%ebp)
  80088a:	a1 24 30 80 00       	mov    0x803024,%eax
  80088f:	8b 50 74             	mov    0x74(%eax),%edx
  800892:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800895:	39 c2                	cmp    %eax,%edx
  800897:	77 cb                	ja     800864 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800899:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80089c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80089f:	74 14                	je     8008b5 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008a1:	83 ec 04             	sub    $0x4,%esp
  8008a4:	68 14 27 80 00       	push   $0x802714
  8008a9:	6a 44                	push   $0x44
  8008ab:	68 b4 26 80 00       	push   $0x8026b4
  8008b0:	e8 23 fe ff ff       	call   8006d8 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008b5:	90                   	nop
  8008b6:	c9                   	leave  
  8008b7:	c3                   	ret    

008008b8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008b8:	55                   	push   %ebp
  8008b9:	89 e5                	mov    %esp,%ebp
  8008bb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c1:	8b 00                	mov    (%eax),%eax
  8008c3:	8d 48 01             	lea    0x1(%eax),%ecx
  8008c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c9:	89 0a                	mov    %ecx,(%edx)
  8008cb:	8b 55 08             	mov    0x8(%ebp),%edx
  8008ce:	88 d1                	mov    %dl,%cl
  8008d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008da:	8b 00                	mov    (%eax),%eax
  8008dc:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008e1:	75 2c                	jne    80090f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008e3:	a0 28 30 80 00       	mov    0x803028,%al
  8008e8:	0f b6 c0             	movzbl %al,%eax
  8008eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ee:	8b 12                	mov    (%edx),%edx
  8008f0:	89 d1                	mov    %edx,%ecx
  8008f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f5:	83 c2 08             	add    $0x8,%edx
  8008f8:	83 ec 04             	sub    $0x4,%esp
  8008fb:	50                   	push   %eax
  8008fc:	51                   	push   %ecx
  8008fd:	52                   	push   %edx
  8008fe:	e8 d4 12 00 00       	call   801bd7 <sys_cputs>
  800903:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800906:	8b 45 0c             	mov    0xc(%ebp),%eax
  800909:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80090f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800912:	8b 40 04             	mov    0x4(%eax),%eax
  800915:	8d 50 01             	lea    0x1(%eax),%edx
  800918:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80091e:	90                   	nop
  80091f:	c9                   	leave  
  800920:	c3                   	ret    

00800921 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800921:	55                   	push   %ebp
  800922:	89 e5                	mov    %esp,%ebp
  800924:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80092a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800931:	00 00 00 
	b.cnt = 0;
  800934:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80093b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80093e:	ff 75 0c             	pushl  0xc(%ebp)
  800941:	ff 75 08             	pushl  0x8(%ebp)
  800944:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80094a:	50                   	push   %eax
  80094b:	68 b8 08 80 00       	push   $0x8008b8
  800950:	e8 11 02 00 00       	call   800b66 <vprintfmt>
  800955:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800958:	a0 28 30 80 00       	mov    0x803028,%al
  80095d:	0f b6 c0             	movzbl %al,%eax
  800960:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800966:	83 ec 04             	sub    $0x4,%esp
  800969:	50                   	push   %eax
  80096a:	52                   	push   %edx
  80096b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800971:	83 c0 08             	add    $0x8,%eax
  800974:	50                   	push   %eax
  800975:	e8 5d 12 00 00       	call   801bd7 <sys_cputs>
  80097a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80097d:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800984:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80098a:	c9                   	leave  
  80098b:	c3                   	ret    

0080098c <cprintf>:

int cprintf(const char *fmt, ...) {
  80098c:	55                   	push   %ebp
  80098d:	89 e5                	mov    %esp,%ebp
  80098f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800992:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800999:	8d 45 0c             	lea    0xc(%ebp),%eax
  80099c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80099f:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a2:	83 ec 08             	sub    $0x8,%esp
  8009a5:	ff 75 f4             	pushl  -0xc(%ebp)
  8009a8:	50                   	push   %eax
  8009a9:	e8 73 ff ff ff       	call   800921 <vcprintf>
  8009ae:	83 c4 10             	add    $0x10,%esp
  8009b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009b7:	c9                   	leave  
  8009b8:	c3                   	ret    

008009b9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009b9:	55                   	push   %ebp
  8009ba:	89 e5                	mov    %esp,%ebp
  8009bc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009bf:	e8 24 14 00 00       	call   801de8 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009c4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cd:	83 ec 08             	sub    $0x8,%esp
  8009d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d3:	50                   	push   %eax
  8009d4:	e8 48 ff ff ff       	call   800921 <vcprintf>
  8009d9:	83 c4 10             	add    $0x10,%esp
  8009dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009df:	e8 1e 14 00 00       	call   801e02 <sys_enable_interrupt>
	return cnt;
  8009e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009e7:	c9                   	leave  
  8009e8:	c3                   	ret    

008009e9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009e9:	55                   	push   %ebp
  8009ea:	89 e5                	mov    %esp,%ebp
  8009ec:	53                   	push   %ebx
  8009ed:	83 ec 14             	sub    $0x14,%esp
  8009f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009fc:	8b 45 18             	mov    0x18(%ebp),%eax
  8009ff:	ba 00 00 00 00       	mov    $0x0,%edx
  800a04:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a07:	77 55                	ja     800a5e <printnum+0x75>
  800a09:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a0c:	72 05                	jb     800a13 <printnum+0x2a>
  800a0e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a11:	77 4b                	ja     800a5e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a13:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a16:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a19:	8b 45 18             	mov    0x18(%ebp),%eax
  800a1c:	ba 00 00 00 00       	mov    $0x0,%edx
  800a21:	52                   	push   %edx
  800a22:	50                   	push   %eax
  800a23:	ff 75 f4             	pushl  -0xc(%ebp)
  800a26:	ff 75 f0             	pushl  -0x10(%ebp)
  800a29:	e8 9a 17 00 00       	call   8021c8 <__udivdi3>
  800a2e:	83 c4 10             	add    $0x10,%esp
  800a31:	83 ec 04             	sub    $0x4,%esp
  800a34:	ff 75 20             	pushl  0x20(%ebp)
  800a37:	53                   	push   %ebx
  800a38:	ff 75 18             	pushl  0x18(%ebp)
  800a3b:	52                   	push   %edx
  800a3c:	50                   	push   %eax
  800a3d:	ff 75 0c             	pushl  0xc(%ebp)
  800a40:	ff 75 08             	pushl  0x8(%ebp)
  800a43:	e8 a1 ff ff ff       	call   8009e9 <printnum>
  800a48:	83 c4 20             	add    $0x20,%esp
  800a4b:	eb 1a                	jmp    800a67 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a4d:	83 ec 08             	sub    $0x8,%esp
  800a50:	ff 75 0c             	pushl  0xc(%ebp)
  800a53:	ff 75 20             	pushl  0x20(%ebp)
  800a56:	8b 45 08             	mov    0x8(%ebp),%eax
  800a59:	ff d0                	call   *%eax
  800a5b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a5e:	ff 4d 1c             	decl   0x1c(%ebp)
  800a61:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a65:	7f e6                	jg     800a4d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a67:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a6a:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a72:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a75:	53                   	push   %ebx
  800a76:	51                   	push   %ecx
  800a77:	52                   	push   %edx
  800a78:	50                   	push   %eax
  800a79:	e8 5a 18 00 00       	call   8022d8 <__umoddi3>
  800a7e:	83 c4 10             	add    $0x10,%esp
  800a81:	05 74 29 80 00       	add    $0x802974,%eax
  800a86:	8a 00                	mov    (%eax),%al
  800a88:	0f be c0             	movsbl %al,%eax
  800a8b:	83 ec 08             	sub    $0x8,%esp
  800a8e:	ff 75 0c             	pushl  0xc(%ebp)
  800a91:	50                   	push   %eax
  800a92:	8b 45 08             	mov    0x8(%ebp),%eax
  800a95:	ff d0                	call   *%eax
  800a97:	83 c4 10             	add    $0x10,%esp
}
  800a9a:	90                   	nop
  800a9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a9e:	c9                   	leave  
  800a9f:	c3                   	ret    

00800aa0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800aa0:	55                   	push   %ebp
  800aa1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800aa3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800aa7:	7e 1c                	jle    800ac5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aac:	8b 00                	mov    (%eax),%eax
  800aae:	8d 50 08             	lea    0x8(%eax),%edx
  800ab1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab4:	89 10                	mov    %edx,(%eax)
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	8b 00                	mov    (%eax),%eax
  800abb:	83 e8 08             	sub    $0x8,%eax
  800abe:	8b 50 04             	mov    0x4(%eax),%edx
  800ac1:	8b 00                	mov    (%eax),%eax
  800ac3:	eb 40                	jmp    800b05 <getuint+0x65>
	else if (lflag)
  800ac5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ac9:	74 1e                	je     800ae9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	8b 00                	mov    (%eax),%eax
  800ad0:	8d 50 04             	lea    0x4(%eax),%edx
  800ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad6:	89 10                	mov    %edx,(%eax)
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8b 00                	mov    (%eax),%eax
  800add:	83 e8 04             	sub    $0x4,%eax
  800ae0:	8b 00                	mov    (%eax),%eax
  800ae2:	ba 00 00 00 00       	mov    $0x0,%edx
  800ae7:	eb 1c                	jmp    800b05 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aec:	8b 00                	mov    (%eax),%eax
  800aee:	8d 50 04             	lea    0x4(%eax),%edx
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	89 10                	mov    %edx,(%eax)
  800af6:	8b 45 08             	mov    0x8(%ebp),%eax
  800af9:	8b 00                	mov    (%eax),%eax
  800afb:	83 e8 04             	sub    $0x4,%eax
  800afe:	8b 00                	mov    (%eax),%eax
  800b00:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b05:	5d                   	pop    %ebp
  800b06:	c3                   	ret    

00800b07 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b07:	55                   	push   %ebp
  800b08:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b0a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b0e:	7e 1c                	jle    800b2c <getint+0x25>
		return va_arg(*ap, long long);
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	8b 00                	mov    (%eax),%eax
  800b15:	8d 50 08             	lea    0x8(%eax),%edx
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	89 10                	mov    %edx,(%eax)
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	8b 00                	mov    (%eax),%eax
  800b22:	83 e8 08             	sub    $0x8,%eax
  800b25:	8b 50 04             	mov    0x4(%eax),%edx
  800b28:	8b 00                	mov    (%eax),%eax
  800b2a:	eb 38                	jmp    800b64 <getint+0x5d>
	else if (lflag)
  800b2c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b30:	74 1a                	je     800b4c <getint+0x45>
		return va_arg(*ap, long);
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	8b 00                	mov    (%eax),%eax
  800b37:	8d 50 04             	lea    0x4(%eax),%edx
  800b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3d:	89 10                	mov    %edx,(%eax)
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	8b 00                	mov    (%eax),%eax
  800b44:	83 e8 04             	sub    $0x4,%eax
  800b47:	8b 00                	mov    (%eax),%eax
  800b49:	99                   	cltd   
  800b4a:	eb 18                	jmp    800b64 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	8b 00                	mov    (%eax),%eax
  800b51:	8d 50 04             	lea    0x4(%eax),%edx
  800b54:	8b 45 08             	mov    0x8(%ebp),%eax
  800b57:	89 10                	mov    %edx,(%eax)
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5c:	8b 00                	mov    (%eax),%eax
  800b5e:	83 e8 04             	sub    $0x4,%eax
  800b61:	8b 00                	mov    (%eax),%eax
  800b63:	99                   	cltd   
}
  800b64:	5d                   	pop    %ebp
  800b65:	c3                   	ret    

00800b66 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b66:	55                   	push   %ebp
  800b67:	89 e5                	mov    %esp,%ebp
  800b69:	56                   	push   %esi
  800b6a:	53                   	push   %ebx
  800b6b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b6e:	eb 17                	jmp    800b87 <vprintfmt+0x21>
			if (ch == '\0')
  800b70:	85 db                	test   %ebx,%ebx
  800b72:	0f 84 af 03 00 00    	je     800f27 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b78:	83 ec 08             	sub    $0x8,%esp
  800b7b:	ff 75 0c             	pushl  0xc(%ebp)
  800b7e:	53                   	push   %ebx
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	ff d0                	call   *%eax
  800b84:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b87:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8a:	8d 50 01             	lea    0x1(%eax),%edx
  800b8d:	89 55 10             	mov    %edx,0x10(%ebp)
  800b90:	8a 00                	mov    (%eax),%al
  800b92:	0f b6 d8             	movzbl %al,%ebx
  800b95:	83 fb 25             	cmp    $0x25,%ebx
  800b98:	75 d6                	jne    800b70 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b9a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b9e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ba5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bac:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bb3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bba:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbd:	8d 50 01             	lea    0x1(%eax),%edx
  800bc0:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc3:	8a 00                	mov    (%eax),%al
  800bc5:	0f b6 d8             	movzbl %al,%ebx
  800bc8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bcb:	83 f8 55             	cmp    $0x55,%eax
  800bce:	0f 87 2b 03 00 00    	ja     800eff <vprintfmt+0x399>
  800bd4:	8b 04 85 98 29 80 00 	mov    0x802998(,%eax,4),%eax
  800bdb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bdd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800be1:	eb d7                	jmp    800bba <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800be3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800be7:	eb d1                	jmp    800bba <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800be9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bf0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bf3:	89 d0                	mov    %edx,%eax
  800bf5:	c1 e0 02             	shl    $0x2,%eax
  800bf8:	01 d0                	add    %edx,%eax
  800bfa:	01 c0                	add    %eax,%eax
  800bfc:	01 d8                	add    %ebx,%eax
  800bfe:	83 e8 30             	sub    $0x30,%eax
  800c01:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c04:	8b 45 10             	mov    0x10(%ebp),%eax
  800c07:	8a 00                	mov    (%eax),%al
  800c09:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c0c:	83 fb 2f             	cmp    $0x2f,%ebx
  800c0f:	7e 3e                	jle    800c4f <vprintfmt+0xe9>
  800c11:	83 fb 39             	cmp    $0x39,%ebx
  800c14:	7f 39                	jg     800c4f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c16:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c19:	eb d5                	jmp    800bf0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c1b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c1e:	83 c0 04             	add    $0x4,%eax
  800c21:	89 45 14             	mov    %eax,0x14(%ebp)
  800c24:	8b 45 14             	mov    0x14(%ebp),%eax
  800c27:	83 e8 04             	sub    $0x4,%eax
  800c2a:	8b 00                	mov    (%eax),%eax
  800c2c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c2f:	eb 1f                	jmp    800c50 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c31:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c35:	79 83                	jns    800bba <vprintfmt+0x54>
				width = 0;
  800c37:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c3e:	e9 77 ff ff ff       	jmp    800bba <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c43:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c4a:	e9 6b ff ff ff       	jmp    800bba <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c4f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c50:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c54:	0f 89 60 ff ff ff    	jns    800bba <vprintfmt+0x54>
				width = precision, precision = -1;
  800c5a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c5d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c60:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c67:	e9 4e ff ff ff       	jmp    800bba <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c6c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c6f:	e9 46 ff ff ff       	jmp    800bba <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c74:	8b 45 14             	mov    0x14(%ebp),%eax
  800c77:	83 c0 04             	add    $0x4,%eax
  800c7a:	89 45 14             	mov    %eax,0x14(%ebp)
  800c7d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c80:	83 e8 04             	sub    $0x4,%eax
  800c83:	8b 00                	mov    (%eax),%eax
  800c85:	83 ec 08             	sub    $0x8,%esp
  800c88:	ff 75 0c             	pushl  0xc(%ebp)
  800c8b:	50                   	push   %eax
  800c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8f:	ff d0                	call   *%eax
  800c91:	83 c4 10             	add    $0x10,%esp
			break;
  800c94:	e9 89 02 00 00       	jmp    800f22 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c99:	8b 45 14             	mov    0x14(%ebp),%eax
  800c9c:	83 c0 04             	add    $0x4,%eax
  800c9f:	89 45 14             	mov    %eax,0x14(%ebp)
  800ca2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca5:	83 e8 04             	sub    $0x4,%eax
  800ca8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800caa:	85 db                	test   %ebx,%ebx
  800cac:	79 02                	jns    800cb0 <vprintfmt+0x14a>
				err = -err;
  800cae:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cb0:	83 fb 64             	cmp    $0x64,%ebx
  800cb3:	7f 0b                	jg     800cc0 <vprintfmt+0x15a>
  800cb5:	8b 34 9d e0 27 80 00 	mov    0x8027e0(,%ebx,4),%esi
  800cbc:	85 f6                	test   %esi,%esi
  800cbe:	75 19                	jne    800cd9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cc0:	53                   	push   %ebx
  800cc1:	68 85 29 80 00       	push   $0x802985
  800cc6:	ff 75 0c             	pushl  0xc(%ebp)
  800cc9:	ff 75 08             	pushl  0x8(%ebp)
  800ccc:	e8 5e 02 00 00       	call   800f2f <printfmt>
  800cd1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cd4:	e9 49 02 00 00       	jmp    800f22 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cd9:	56                   	push   %esi
  800cda:	68 8e 29 80 00       	push   $0x80298e
  800cdf:	ff 75 0c             	pushl  0xc(%ebp)
  800ce2:	ff 75 08             	pushl  0x8(%ebp)
  800ce5:	e8 45 02 00 00       	call   800f2f <printfmt>
  800cea:	83 c4 10             	add    $0x10,%esp
			break;
  800ced:	e9 30 02 00 00       	jmp    800f22 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cf2:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf5:	83 c0 04             	add    $0x4,%eax
  800cf8:	89 45 14             	mov    %eax,0x14(%ebp)
  800cfb:	8b 45 14             	mov    0x14(%ebp),%eax
  800cfe:	83 e8 04             	sub    $0x4,%eax
  800d01:	8b 30                	mov    (%eax),%esi
  800d03:	85 f6                	test   %esi,%esi
  800d05:	75 05                	jne    800d0c <vprintfmt+0x1a6>
				p = "(null)";
  800d07:	be 91 29 80 00       	mov    $0x802991,%esi
			if (width > 0 && padc != '-')
  800d0c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d10:	7e 6d                	jle    800d7f <vprintfmt+0x219>
  800d12:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d16:	74 67                	je     800d7f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d18:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d1b:	83 ec 08             	sub    $0x8,%esp
  800d1e:	50                   	push   %eax
  800d1f:	56                   	push   %esi
  800d20:	e8 12 05 00 00       	call   801237 <strnlen>
  800d25:	83 c4 10             	add    $0x10,%esp
  800d28:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d2b:	eb 16                	jmp    800d43 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d2d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d31:	83 ec 08             	sub    $0x8,%esp
  800d34:	ff 75 0c             	pushl  0xc(%ebp)
  800d37:	50                   	push   %eax
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	ff d0                	call   *%eax
  800d3d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d40:	ff 4d e4             	decl   -0x1c(%ebp)
  800d43:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d47:	7f e4                	jg     800d2d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d49:	eb 34                	jmp    800d7f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d4b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d4f:	74 1c                	je     800d6d <vprintfmt+0x207>
  800d51:	83 fb 1f             	cmp    $0x1f,%ebx
  800d54:	7e 05                	jle    800d5b <vprintfmt+0x1f5>
  800d56:	83 fb 7e             	cmp    $0x7e,%ebx
  800d59:	7e 12                	jle    800d6d <vprintfmt+0x207>
					putch('?', putdat);
  800d5b:	83 ec 08             	sub    $0x8,%esp
  800d5e:	ff 75 0c             	pushl  0xc(%ebp)
  800d61:	6a 3f                	push   $0x3f
  800d63:	8b 45 08             	mov    0x8(%ebp),%eax
  800d66:	ff d0                	call   *%eax
  800d68:	83 c4 10             	add    $0x10,%esp
  800d6b:	eb 0f                	jmp    800d7c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d6d:	83 ec 08             	sub    $0x8,%esp
  800d70:	ff 75 0c             	pushl  0xc(%ebp)
  800d73:	53                   	push   %ebx
  800d74:	8b 45 08             	mov    0x8(%ebp),%eax
  800d77:	ff d0                	call   *%eax
  800d79:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d7c:	ff 4d e4             	decl   -0x1c(%ebp)
  800d7f:	89 f0                	mov    %esi,%eax
  800d81:	8d 70 01             	lea    0x1(%eax),%esi
  800d84:	8a 00                	mov    (%eax),%al
  800d86:	0f be d8             	movsbl %al,%ebx
  800d89:	85 db                	test   %ebx,%ebx
  800d8b:	74 24                	je     800db1 <vprintfmt+0x24b>
  800d8d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d91:	78 b8                	js     800d4b <vprintfmt+0x1e5>
  800d93:	ff 4d e0             	decl   -0x20(%ebp)
  800d96:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d9a:	79 af                	jns    800d4b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d9c:	eb 13                	jmp    800db1 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d9e:	83 ec 08             	sub    $0x8,%esp
  800da1:	ff 75 0c             	pushl  0xc(%ebp)
  800da4:	6a 20                	push   $0x20
  800da6:	8b 45 08             	mov    0x8(%ebp),%eax
  800da9:	ff d0                	call   *%eax
  800dab:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dae:	ff 4d e4             	decl   -0x1c(%ebp)
  800db1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800db5:	7f e7                	jg     800d9e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800db7:	e9 66 01 00 00       	jmp    800f22 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dbc:	83 ec 08             	sub    $0x8,%esp
  800dbf:	ff 75 e8             	pushl  -0x18(%ebp)
  800dc2:	8d 45 14             	lea    0x14(%ebp),%eax
  800dc5:	50                   	push   %eax
  800dc6:	e8 3c fd ff ff       	call   800b07 <getint>
  800dcb:	83 c4 10             	add    $0x10,%esp
  800dce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dd1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dd7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dda:	85 d2                	test   %edx,%edx
  800ddc:	79 23                	jns    800e01 <vprintfmt+0x29b>
				putch('-', putdat);
  800dde:	83 ec 08             	sub    $0x8,%esp
  800de1:	ff 75 0c             	pushl  0xc(%ebp)
  800de4:	6a 2d                	push   $0x2d
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	ff d0                	call   *%eax
  800deb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800df1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800df4:	f7 d8                	neg    %eax
  800df6:	83 d2 00             	adc    $0x0,%edx
  800df9:	f7 da                	neg    %edx
  800dfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dfe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e01:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e08:	e9 bc 00 00 00       	jmp    800ec9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e0d:	83 ec 08             	sub    $0x8,%esp
  800e10:	ff 75 e8             	pushl  -0x18(%ebp)
  800e13:	8d 45 14             	lea    0x14(%ebp),%eax
  800e16:	50                   	push   %eax
  800e17:	e8 84 fc ff ff       	call   800aa0 <getuint>
  800e1c:	83 c4 10             	add    $0x10,%esp
  800e1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e22:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e25:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e2c:	e9 98 00 00 00       	jmp    800ec9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e31:	83 ec 08             	sub    $0x8,%esp
  800e34:	ff 75 0c             	pushl  0xc(%ebp)
  800e37:	6a 58                	push   $0x58
  800e39:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3c:	ff d0                	call   *%eax
  800e3e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e41:	83 ec 08             	sub    $0x8,%esp
  800e44:	ff 75 0c             	pushl  0xc(%ebp)
  800e47:	6a 58                	push   $0x58
  800e49:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4c:	ff d0                	call   *%eax
  800e4e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e51:	83 ec 08             	sub    $0x8,%esp
  800e54:	ff 75 0c             	pushl  0xc(%ebp)
  800e57:	6a 58                	push   $0x58
  800e59:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5c:	ff d0                	call   *%eax
  800e5e:	83 c4 10             	add    $0x10,%esp
			break;
  800e61:	e9 bc 00 00 00       	jmp    800f22 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e66:	83 ec 08             	sub    $0x8,%esp
  800e69:	ff 75 0c             	pushl  0xc(%ebp)
  800e6c:	6a 30                	push   $0x30
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	ff d0                	call   *%eax
  800e73:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e76:	83 ec 08             	sub    $0x8,%esp
  800e79:	ff 75 0c             	pushl  0xc(%ebp)
  800e7c:	6a 78                	push   $0x78
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e81:	ff d0                	call   *%eax
  800e83:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e86:	8b 45 14             	mov    0x14(%ebp),%eax
  800e89:	83 c0 04             	add    $0x4,%eax
  800e8c:	89 45 14             	mov    %eax,0x14(%ebp)
  800e8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e92:	83 e8 04             	sub    $0x4,%eax
  800e95:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e97:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e9a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ea1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ea8:	eb 1f                	jmp    800ec9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800eaa:	83 ec 08             	sub    $0x8,%esp
  800ead:	ff 75 e8             	pushl  -0x18(%ebp)
  800eb0:	8d 45 14             	lea    0x14(%ebp),%eax
  800eb3:	50                   	push   %eax
  800eb4:	e8 e7 fb ff ff       	call   800aa0 <getuint>
  800eb9:	83 c4 10             	add    $0x10,%esp
  800ebc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ebf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ec2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ec9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ecd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ed0:	83 ec 04             	sub    $0x4,%esp
  800ed3:	52                   	push   %edx
  800ed4:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ed7:	50                   	push   %eax
  800ed8:	ff 75 f4             	pushl  -0xc(%ebp)
  800edb:	ff 75 f0             	pushl  -0x10(%ebp)
  800ede:	ff 75 0c             	pushl  0xc(%ebp)
  800ee1:	ff 75 08             	pushl  0x8(%ebp)
  800ee4:	e8 00 fb ff ff       	call   8009e9 <printnum>
  800ee9:	83 c4 20             	add    $0x20,%esp
			break;
  800eec:	eb 34                	jmp    800f22 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800eee:	83 ec 08             	sub    $0x8,%esp
  800ef1:	ff 75 0c             	pushl  0xc(%ebp)
  800ef4:	53                   	push   %ebx
  800ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef8:	ff d0                	call   *%eax
  800efa:	83 c4 10             	add    $0x10,%esp
			break;
  800efd:	eb 23                	jmp    800f22 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800eff:	83 ec 08             	sub    $0x8,%esp
  800f02:	ff 75 0c             	pushl  0xc(%ebp)
  800f05:	6a 25                	push   $0x25
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0a:	ff d0                	call   *%eax
  800f0c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f0f:	ff 4d 10             	decl   0x10(%ebp)
  800f12:	eb 03                	jmp    800f17 <vprintfmt+0x3b1>
  800f14:	ff 4d 10             	decl   0x10(%ebp)
  800f17:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1a:	48                   	dec    %eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	3c 25                	cmp    $0x25,%al
  800f1f:	75 f3                	jne    800f14 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f21:	90                   	nop
		}
	}
  800f22:	e9 47 fc ff ff       	jmp    800b6e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f27:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f28:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f2b:	5b                   	pop    %ebx
  800f2c:	5e                   	pop    %esi
  800f2d:	5d                   	pop    %ebp
  800f2e:	c3                   	ret    

00800f2f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f2f:	55                   	push   %ebp
  800f30:	89 e5                	mov    %esp,%ebp
  800f32:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f35:	8d 45 10             	lea    0x10(%ebp),%eax
  800f38:	83 c0 04             	add    $0x4,%eax
  800f3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f41:	ff 75 f4             	pushl  -0xc(%ebp)
  800f44:	50                   	push   %eax
  800f45:	ff 75 0c             	pushl  0xc(%ebp)
  800f48:	ff 75 08             	pushl  0x8(%ebp)
  800f4b:	e8 16 fc ff ff       	call   800b66 <vprintfmt>
  800f50:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f53:	90                   	nop
  800f54:	c9                   	leave  
  800f55:	c3                   	ret    

00800f56 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f56:	55                   	push   %ebp
  800f57:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5c:	8b 40 08             	mov    0x8(%eax),%eax
  800f5f:	8d 50 01             	lea    0x1(%eax),%edx
  800f62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f65:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6b:	8b 10                	mov    (%eax),%edx
  800f6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f70:	8b 40 04             	mov    0x4(%eax),%eax
  800f73:	39 c2                	cmp    %eax,%edx
  800f75:	73 12                	jae    800f89 <sprintputch+0x33>
		*b->buf++ = ch;
  800f77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7a:	8b 00                	mov    (%eax),%eax
  800f7c:	8d 48 01             	lea    0x1(%eax),%ecx
  800f7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f82:	89 0a                	mov    %ecx,(%edx)
  800f84:	8b 55 08             	mov    0x8(%ebp),%edx
  800f87:	88 10                	mov    %dl,(%eax)
}
  800f89:	90                   	nop
  800f8a:	5d                   	pop    %ebp
  800f8b:	c3                   	ret    

00800f8c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f8c:	55                   	push   %ebp
  800f8d:	89 e5                	mov    %esp,%ebp
  800f8f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	01 d0                	add    %edx,%eax
  800fa3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fa6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fb1:	74 06                	je     800fb9 <vsnprintf+0x2d>
  800fb3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fb7:	7f 07                	jg     800fc0 <vsnprintf+0x34>
		return -E_INVAL;
  800fb9:	b8 03 00 00 00       	mov    $0x3,%eax
  800fbe:	eb 20                	jmp    800fe0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fc0:	ff 75 14             	pushl  0x14(%ebp)
  800fc3:	ff 75 10             	pushl  0x10(%ebp)
  800fc6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fc9:	50                   	push   %eax
  800fca:	68 56 0f 80 00       	push   $0x800f56
  800fcf:	e8 92 fb ff ff       	call   800b66 <vprintfmt>
  800fd4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fda:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fe0:	c9                   	leave  
  800fe1:	c3                   	ret    

00800fe2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fe2:	55                   	push   %ebp
  800fe3:	89 e5                	mov    %esp,%ebp
  800fe5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fe8:	8d 45 10             	lea    0x10(%ebp),%eax
  800feb:	83 c0 04             	add    $0x4,%eax
  800fee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ff1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ff7:	50                   	push   %eax
  800ff8:	ff 75 0c             	pushl  0xc(%ebp)
  800ffb:	ff 75 08             	pushl  0x8(%ebp)
  800ffe:	e8 89 ff ff ff       	call   800f8c <vsnprintf>
  801003:	83 c4 10             	add    $0x10,%esp
  801006:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801009:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80100c:	c9                   	leave  
  80100d:	c3                   	ret    

0080100e <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80100e:	55                   	push   %ebp
  80100f:	89 e5                	mov    %esp,%ebp
  801011:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801014:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801018:	74 13                	je     80102d <readline+0x1f>
		cprintf("%s", prompt);
  80101a:	83 ec 08             	sub    $0x8,%esp
  80101d:	ff 75 08             	pushl  0x8(%ebp)
  801020:	68 f0 2a 80 00       	push   $0x802af0
  801025:	e8 62 f9 ff ff       	call   80098c <cprintf>
  80102a:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80102d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801034:	83 ec 0c             	sub    $0xc,%esp
  801037:	6a 00                	push   $0x0
  801039:	e8 8e f5 ff ff       	call   8005cc <iscons>
  80103e:	83 c4 10             	add    $0x10,%esp
  801041:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801044:	e8 35 f5 ff ff       	call   80057e <getchar>
  801049:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80104c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801050:	79 22                	jns    801074 <readline+0x66>
			if (c != -E_EOF)
  801052:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801056:	0f 84 ad 00 00 00    	je     801109 <readline+0xfb>
				cprintf("read error: %e\n", c);
  80105c:	83 ec 08             	sub    $0x8,%esp
  80105f:	ff 75 ec             	pushl  -0x14(%ebp)
  801062:	68 f3 2a 80 00       	push   $0x802af3
  801067:	e8 20 f9 ff ff       	call   80098c <cprintf>
  80106c:	83 c4 10             	add    $0x10,%esp
			return;
  80106f:	e9 95 00 00 00       	jmp    801109 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801074:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801078:	7e 34                	jle    8010ae <readline+0xa0>
  80107a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801081:	7f 2b                	jg     8010ae <readline+0xa0>
			if (echoing)
  801083:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801087:	74 0e                	je     801097 <readline+0x89>
				cputchar(c);
  801089:	83 ec 0c             	sub    $0xc,%esp
  80108c:	ff 75 ec             	pushl  -0x14(%ebp)
  80108f:	e8 a2 f4 ff ff       	call   800536 <cputchar>
  801094:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801097:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80109a:	8d 50 01             	lea    0x1(%eax),%edx
  80109d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010a0:	89 c2                	mov    %eax,%edx
  8010a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a5:	01 d0                	add    %edx,%eax
  8010a7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010aa:	88 10                	mov    %dl,(%eax)
  8010ac:	eb 56                	jmp    801104 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010ae:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010b2:	75 1f                	jne    8010d3 <readline+0xc5>
  8010b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010b8:	7e 19                	jle    8010d3 <readline+0xc5>
			if (echoing)
  8010ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010be:	74 0e                	je     8010ce <readline+0xc0>
				cputchar(c);
  8010c0:	83 ec 0c             	sub    $0xc,%esp
  8010c3:	ff 75 ec             	pushl  -0x14(%ebp)
  8010c6:	e8 6b f4 ff ff       	call   800536 <cputchar>
  8010cb:	83 c4 10             	add    $0x10,%esp

			i--;
  8010ce:	ff 4d f4             	decl   -0xc(%ebp)
  8010d1:	eb 31                	jmp    801104 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8010d3:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8010d7:	74 0a                	je     8010e3 <readline+0xd5>
  8010d9:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8010dd:	0f 85 61 ff ff ff    	jne    801044 <readline+0x36>
			if (echoing)
  8010e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010e7:	74 0e                	je     8010f7 <readline+0xe9>
				cputchar(c);
  8010e9:	83 ec 0c             	sub    $0xc,%esp
  8010ec:	ff 75 ec             	pushl  -0x14(%ebp)
  8010ef:	e8 42 f4 ff ff       	call   800536 <cputchar>
  8010f4:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8010f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fd:	01 d0                	add    %edx,%eax
  8010ff:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801102:	eb 06                	jmp    80110a <readline+0xfc>
		}
	}
  801104:	e9 3b ff ff ff       	jmp    801044 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801109:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80110a:	c9                   	leave  
  80110b:	c3                   	ret    

0080110c <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  80110c:	55                   	push   %ebp
  80110d:	89 e5                	mov    %esp,%ebp
  80110f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801112:	e8 d1 0c 00 00       	call   801de8 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801117:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80111b:	74 13                	je     801130 <atomic_readline+0x24>
		cprintf("%s", prompt);
  80111d:	83 ec 08             	sub    $0x8,%esp
  801120:	ff 75 08             	pushl  0x8(%ebp)
  801123:	68 f0 2a 80 00       	push   $0x802af0
  801128:	e8 5f f8 ff ff       	call   80098c <cprintf>
  80112d:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801130:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801137:	83 ec 0c             	sub    $0xc,%esp
  80113a:	6a 00                	push   $0x0
  80113c:	e8 8b f4 ff ff       	call   8005cc <iscons>
  801141:	83 c4 10             	add    $0x10,%esp
  801144:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801147:	e8 32 f4 ff ff       	call   80057e <getchar>
  80114c:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80114f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801153:	79 23                	jns    801178 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801155:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801159:	74 13                	je     80116e <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80115b:	83 ec 08             	sub    $0x8,%esp
  80115e:	ff 75 ec             	pushl  -0x14(%ebp)
  801161:	68 f3 2a 80 00       	push   $0x802af3
  801166:	e8 21 f8 ff ff       	call   80098c <cprintf>
  80116b:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80116e:	e8 8f 0c 00 00       	call   801e02 <sys_enable_interrupt>
			return;
  801173:	e9 9a 00 00 00       	jmp    801212 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801178:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80117c:	7e 34                	jle    8011b2 <atomic_readline+0xa6>
  80117e:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801185:	7f 2b                	jg     8011b2 <atomic_readline+0xa6>
			if (echoing)
  801187:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80118b:	74 0e                	je     80119b <atomic_readline+0x8f>
				cputchar(c);
  80118d:	83 ec 0c             	sub    $0xc,%esp
  801190:	ff 75 ec             	pushl  -0x14(%ebp)
  801193:	e8 9e f3 ff ff       	call   800536 <cputchar>
  801198:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80119b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80119e:	8d 50 01             	lea    0x1(%eax),%edx
  8011a1:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011a4:	89 c2                	mov    %eax,%edx
  8011a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a9:	01 d0                	add    %edx,%eax
  8011ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011ae:	88 10                	mov    %dl,(%eax)
  8011b0:	eb 5b                	jmp    80120d <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011b2:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011b6:	75 1f                	jne    8011d7 <atomic_readline+0xcb>
  8011b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011bc:	7e 19                	jle    8011d7 <atomic_readline+0xcb>
			if (echoing)
  8011be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011c2:	74 0e                	je     8011d2 <atomic_readline+0xc6>
				cputchar(c);
  8011c4:	83 ec 0c             	sub    $0xc,%esp
  8011c7:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ca:	e8 67 f3 ff ff       	call   800536 <cputchar>
  8011cf:	83 c4 10             	add    $0x10,%esp
			i--;
  8011d2:	ff 4d f4             	decl   -0xc(%ebp)
  8011d5:	eb 36                	jmp    80120d <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8011d7:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011db:	74 0a                	je     8011e7 <atomic_readline+0xdb>
  8011dd:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011e1:	0f 85 60 ff ff ff    	jne    801147 <atomic_readline+0x3b>
			if (echoing)
  8011e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011eb:	74 0e                	je     8011fb <atomic_readline+0xef>
				cputchar(c);
  8011ed:	83 ec 0c             	sub    $0xc,%esp
  8011f0:	ff 75 ec             	pushl  -0x14(%ebp)
  8011f3:	e8 3e f3 ff ff       	call   800536 <cputchar>
  8011f8:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8011fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801201:	01 d0                	add    %edx,%eax
  801203:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801206:	e8 f7 0b 00 00       	call   801e02 <sys_enable_interrupt>
			return;
  80120b:	eb 05                	jmp    801212 <atomic_readline+0x106>
		}
	}
  80120d:	e9 35 ff ff ff       	jmp    801147 <atomic_readline+0x3b>
}
  801212:	c9                   	leave  
  801213:	c3                   	ret    

00801214 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801214:	55                   	push   %ebp
  801215:	89 e5                	mov    %esp,%ebp
  801217:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80121a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801221:	eb 06                	jmp    801229 <strlen+0x15>
		n++;
  801223:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801226:	ff 45 08             	incl   0x8(%ebp)
  801229:	8b 45 08             	mov    0x8(%ebp),%eax
  80122c:	8a 00                	mov    (%eax),%al
  80122e:	84 c0                	test   %al,%al
  801230:	75 f1                	jne    801223 <strlen+0xf>
		n++;
	return n;
  801232:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801235:	c9                   	leave  
  801236:	c3                   	ret    

00801237 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801237:	55                   	push   %ebp
  801238:	89 e5                	mov    %esp,%ebp
  80123a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80123d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801244:	eb 09                	jmp    80124f <strnlen+0x18>
		n++;
  801246:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801249:	ff 45 08             	incl   0x8(%ebp)
  80124c:	ff 4d 0c             	decl   0xc(%ebp)
  80124f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801253:	74 09                	je     80125e <strnlen+0x27>
  801255:	8b 45 08             	mov    0x8(%ebp),%eax
  801258:	8a 00                	mov    (%eax),%al
  80125a:	84 c0                	test   %al,%al
  80125c:	75 e8                	jne    801246 <strnlen+0xf>
		n++;
	return n;
  80125e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801261:	c9                   	leave  
  801262:	c3                   	ret    

00801263 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801263:	55                   	push   %ebp
  801264:	89 e5                	mov    %esp,%ebp
  801266:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801269:	8b 45 08             	mov    0x8(%ebp),%eax
  80126c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80126f:	90                   	nop
  801270:	8b 45 08             	mov    0x8(%ebp),%eax
  801273:	8d 50 01             	lea    0x1(%eax),%edx
  801276:	89 55 08             	mov    %edx,0x8(%ebp)
  801279:	8b 55 0c             	mov    0xc(%ebp),%edx
  80127c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80127f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801282:	8a 12                	mov    (%edx),%dl
  801284:	88 10                	mov    %dl,(%eax)
  801286:	8a 00                	mov    (%eax),%al
  801288:	84 c0                	test   %al,%al
  80128a:	75 e4                	jne    801270 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80128c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80128f:	c9                   	leave  
  801290:	c3                   	ret    

00801291 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801291:	55                   	push   %ebp
  801292:	89 e5                	mov    %esp,%ebp
  801294:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80129d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012a4:	eb 1f                	jmp    8012c5 <strncpy+0x34>
		*dst++ = *src;
  8012a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a9:	8d 50 01             	lea    0x1(%eax),%edx
  8012ac:	89 55 08             	mov    %edx,0x8(%ebp)
  8012af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b2:	8a 12                	mov    (%edx),%dl
  8012b4:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b9:	8a 00                	mov    (%eax),%al
  8012bb:	84 c0                	test   %al,%al
  8012bd:	74 03                	je     8012c2 <strncpy+0x31>
			src++;
  8012bf:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012c2:	ff 45 fc             	incl   -0x4(%ebp)
  8012c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012cb:	72 d9                	jb     8012a6 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012d0:	c9                   	leave  
  8012d1:	c3                   	ret    

008012d2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012d2:	55                   	push   %ebp
  8012d3:	89 e5                	mov    %esp,%ebp
  8012d5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012db:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012de:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012e2:	74 30                	je     801314 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012e4:	eb 16                	jmp    8012fc <strlcpy+0x2a>
			*dst++ = *src++;
  8012e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e9:	8d 50 01             	lea    0x1(%eax),%edx
  8012ec:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012f5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012f8:	8a 12                	mov    (%edx),%dl
  8012fa:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8012fc:	ff 4d 10             	decl   0x10(%ebp)
  8012ff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801303:	74 09                	je     80130e <strlcpy+0x3c>
  801305:	8b 45 0c             	mov    0xc(%ebp),%eax
  801308:	8a 00                	mov    (%eax),%al
  80130a:	84 c0                	test   %al,%al
  80130c:	75 d8                	jne    8012e6 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801314:	8b 55 08             	mov    0x8(%ebp),%edx
  801317:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80131a:	29 c2                	sub    %eax,%edx
  80131c:	89 d0                	mov    %edx,%eax
}
  80131e:	c9                   	leave  
  80131f:	c3                   	ret    

00801320 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801320:	55                   	push   %ebp
  801321:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801323:	eb 06                	jmp    80132b <strcmp+0xb>
		p++, q++;
  801325:	ff 45 08             	incl   0x8(%ebp)
  801328:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80132b:	8b 45 08             	mov    0x8(%ebp),%eax
  80132e:	8a 00                	mov    (%eax),%al
  801330:	84 c0                	test   %al,%al
  801332:	74 0e                	je     801342 <strcmp+0x22>
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	8a 10                	mov    (%eax),%dl
  801339:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133c:	8a 00                	mov    (%eax),%al
  80133e:	38 c2                	cmp    %al,%dl
  801340:	74 e3                	je     801325 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	8a 00                	mov    (%eax),%al
  801347:	0f b6 d0             	movzbl %al,%edx
  80134a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134d:	8a 00                	mov    (%eax),%al
  80134f:	0f b6 c0             	movzbl %al,%eax
  801352:	29 c2                	sub    %eax,%edx
  801354:	89 d0                	mov    %edx,%eax
}
  801356:	5d                   	pop    %ebp
  801357:	c3                   	ret    

00801358 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801358:	55                   	push   %ebp
  801359:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80135b:	eb 09                	jmp    801366 <strncmp+0xe>
		n--, p++, q++;
  80135d:	ff 4d 10             	decl   0x10(%ebp)
  801360:	ff 45 08             	incl   0x8(%ebp)
  801363:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801366:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80136a:	74 17                	je     801383 <strncmp+0x2b>
  80136c:	8b 45 08             	mov    0x8(%ebp),%eax
  80136f:	8a 00                	mov    (%eax),%al
  801371:	84 c0                	test   %al,%al
  801373:	74 0e                	je     801383 <strncmp+0x2b>
  801375:	8b 45 08             	mov    0x8(%ebp),%eax
  801378:	8a 10                	mov    (%eax),%dl
  80137a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137d:	8a 00                	mov    (%eax),%al
  80137f:	38 c2                	cmp    %al,%dl
  801381:	74 da                	je     80135d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801383:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801387:	75 07                	jne    801390 <strncmp+0x38>
		return 0;
  801389:	b8 00 00 00 00       	mov    $0x0,%eax
  80138e:	eb 14                	jmp    8013a4 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	8a 00                	mov    (%eax),%al
  801395:	0f b6 d0             	movzbl %al,%edx
  801398:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139b:	8a 00                	mov    (%eax),%al
  80139d:	0f b6 c0             	movzbl %al,%eax
  8013a0:	29 c2                	sub    %eax,%edx
  8013a2:	89 d0                	mov    %edx,%eax
}
  8013a4:	5d                   	pop    %ebp
  8013a5:	c3                   	ret    

008013a6 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013a6:	55                   	push   %ebp
  8013a7:	89 e5                	mov    %esp,%ebp
  8013a9:	83 ec 04             	sub    $0x4,%esp
  8013ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013af:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013b2:	eb 12                	jmp    8013c6 <strchr+0x20>
		if (*s == c)
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	8a 00                	mov    (%eax),%al
  8013b9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013bc:	75 05                	jne    8013c3 <strchr+0x1d>
			return (char *) s;
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	eb 11                	jmp    8013d4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013c3:	ff 45 08             	incl   0x8(%ebp)
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	8a 00                	mov    (%eax),%al
  8013cb:	84 c0                	test   %al,%al
  8013cd:	75 e5                	jne    8013b4 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013d4:	c9                   	leave  
  8013d5:	c3                   	ret    

008013d6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013d6:	55                   	push   %ebp
  8013d7:	89 e5                	mov    %esp,%ebp
  8013d9:	83 ec 04             	sub    $0x4,%esp
  8013dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013df:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013e2:	eb 0d                	jmp    8013f1 <strfind+0x1b>
		if (*s == c)
  8013e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e7:	8a 00                	mov    (%eax),%al
  8013e9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013ec:	74 0e                	je     8013fc <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013ee:	ff 45 08             	incl   0x8(%ebp)
  8013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f4:	8a 00                	mov    (%eax),%al
  8013f6:	84 c0                	test   %al,%al
  8013f8:	75 ea                	jne    8013e4 <strfind+0xe>
  8013fa:	eb 01                	jmp    8013fd <strfind+0x27>
		if (*s == c)
			break;
  8013fc:	90                   	nop
	return (char *) s;
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801400:	c9                   	leave  
  801401:	c3                   	ret    

00801402 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801402:	55                   	push   %ebp
  801403:	89 e5                	mov    %esp,%ebp
  801405:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
  80140b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80140e:	8b 45 10             	mov    0x10(%ebp),%eax
  801411:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801414:	eb 0e                	jmp    801424 <memset+0x22>
		*p++ = c;
  801416:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801419:	8d 50 01             	lea    0x1(%eax),%edx
  80141c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80141f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801422:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801424:	ff 4d f8             	decl   -0x8(%ebp)
  801427:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80142b:	79 e9                	jns    801416 <memset+0x14>
		*p++ = c;

	return v;
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801430:	c9                   	leave  
  801431:	c3                   	ret    

00801432 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801432:	55                   	push   %ebp
  801433:	89 e5                	mov    %esp,%ebp
  801435:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801438:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801444:	eb 16                	jmp    80145c <memcpy+0x2a>
		*d++ = *s++;
  801446:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801449:	8d 50 01             	lea    0x1(%eax),%edx
  80144c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80144f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801452:	8d 4a 01             	lea    0x1(%edx),%ecx
  801455:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801458:	8a 12                	mov    (%edx),%dl
  80145a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80145c:	8b 45 10             	mov    0x10(%ebp),%eax
  80145f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801462:	89 55 10             	mov    %edx,0x10(%ebp)
  801465:	85 c0                	test   %eax,%eax
  801467:	75 dd                	jne    801446 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801469:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80146c:	c9                   	leave  
  80146d:	c3                   	ret    

0080146e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80146e:	55                   	push   %ebp
  80146f:	89 e5                	mov    %esp,%ebp
  801471:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801474:	8b 45 0c             	mov    0xc(%ebp),%eax
  801477:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80147a:	8b 45 08             	mov    0x8(%ebp),%eax
  80147d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801480:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801483:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801486:	73 50                	jae    8014d8 <memmove+0x6a>
  801488:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80148b:	8b 45 10             	mov    0x10(%ebp),%eax
  80148e:	01 d0                	add    %edx,%eax
  801490:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801493:	76 43                	jbe    8014d8 <memmove+0x6a>
		s += n;
  801495:	8b 45 10             	mov    0x10(%ebp),%eax
  801498:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80149b:	8b 45 10             	mov    0x10(%ebp),%eax
  80149e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014a1:	eb 10                	jmp    8014b3 <memmove+0x45>
			*--d = *--s;
  8014a3:	ff 4d f8             	decl   -0x8(%ebp)
  8014a6:	ff 4d fc             	decl   -0x4(%ebp)
  8014a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ac:	8a 10                	mov    (%eax),%dl
  8014ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014b9:	89 55 10             	mov    %edx,0x10(%ebp)
  8014bc:	85 c0                	test   %eax,%eax
  8014be:	75 e3                	jne    8014a3 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014c0:	eb 23                	jmp    8014e5 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014c5:	8d 50 01             	lea    0x1(%eax),%edx
  8014c8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ce:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014d1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014d4:	8a 12                	mov    (%edx),%dl
  8014d6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8014d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014db:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014de:	89 55 10             	mov    %edx,0x10(%ebp)
  8014e1:	85 c0                	test   %eax,%eax
  8014e3:	75 dd                	jne    8014c2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014e8:	c9                   	leave  
  8014e9:	c3                   	ret    

008014ea <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
  8014ed:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8014f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8014f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f9:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8014fc:	eb 2a                	jmp    801528 <memcmp+0x3e>
		if (*s1 != *s2)
  8014fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801501:	8a 10                	mov    (%eax),%dl
  801503:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801506:	8a 00                	mov    (%eax),%al
  801508:	38 c2                	cmp    %al,%dl
  80150a:	74 16                	je     801522 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80150c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80150f:	8a 00                	mov    (%eax),%al
  801511:	0f b6 d0             	movzbl %al,%edx
  801514:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801517:	8a 00                	mov    (%eax),%al
  801519:	0f b6 c0             	movzbl %al,%eax
  80151c:	29 c2                	sub    %eax,%edx
  80151e:	89 d0                	mov    %edx,%eax
  801520:	eb 18                	jmp    80153a <memcmp+0x50>
		s1++, s2++;
  801522:	ff 45 fc             	incl   -0x4(%ebp)
  801525:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801528:	8b 45 10             	mov    0x10(%ebp),%eax
  80152b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80152e:	89 55 10             	mov    %edx,0x10(%ebp)
  801531:	85 c0                	test   %eax,%eax
  801533:	75 c9                	jne    8014fe <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801535:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80153a:	c9                   	leave  
  80153b:	c3                   	ret    

0080153c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80153c:	55                   	push   %ebp
  80153d:	89 e5                	mov    %esp,%ebp
  80153f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801542:	8b 55 08             	mov    0x8(%ebp),%edx
  801545:	8b 45 10             	mov    0x10(%ebp),%eax
  801548:	01 d0                	add    %edx,%eax
  80154a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80154d:	eb 15                	jmp    801564 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80154f:	8b 45 08             	mov    0x8(%ebp),%eax
  801552:	8a 00                	mov    (%eax),%al
  801554:	0f b6 d0             	movzbl %al,%edx
  801557:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155a:	0f b6 c0             	movzbl %al,%eax
  80155d:	39 c2                	cmp    %eax,%edx
  80155f:	74 0d                	je     80156e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801561:	ff 45 08             	incl   0x8(%ebp)
  801564:	8b 45 08             	mov    0x8(%ebp),%eax
  801567:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80156a:	72 e3                	jb     80154f <memfind+0x13>
  80156c:	eb 01                	jmp    80156f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80156e:	90                   	nop
	return (void *) s;
  80156f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801572:	c9                   	leave  
  801573:	c3                   	ret    

00801574 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801574:	55                   	push   %ebp
  801575:	89 e5                	mov    %esp,%ebp
  801577:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80157a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801581:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801588:	eb 03                	jmp    80158d <strtol+0x19>
		s++;
  80158a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80158d:	8b 45 08             	mov    0x8(%ebp),%eax
  801590:	8a 00                	mov    (%eax),%al
  801592:	3c 20                	cmp    $0x20,%al
  801594:	74 f4                	je     80158a <strtol+0x16>
  801596:	8b 45 08             	mov    0x8(%ebp),%eax
  801599:	8a 00                	mov    (%eax),%al
  80159b:	3c 09                	cmp    $0x9,%al
  80159d:	74 eb                	je     80158a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80159f:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a2:	8a 00                	mov    (%eax),%al
  8015a4:	3c 2b                	cmp    $0x2b,%al
  8015a6:	75 05                	jne    8015ad <strtol+0x39>
		s++;
  8015a8:	ff 45 08             	incl   0x8(%ebp)
  8015ab:	eb 13                	jmp    8015c0 <strtol+0x4c>
	else if (*s == '-')
  8015ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b0:	8a 00                	mov    (%eax),%al
  8015b2:	3c 2d                	cmp    $0x2d,%al
  8015b4:	75 0a                	jne    8015c0 <strtol+0x4c>
		s++, neg = 1;
  8015b6:	ff 45 08             	incl   0x8(%ebp)
  8015b9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015c4:	74 06                	je     8015cc <strtol+0x58>
  8015c6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015ca:	75 20                	jne    8015ec <strtol+0x78>
  8015cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cf:	8a 00                	mov    (%eax),%al
  8015d1:	3c 30                	cmp    $0x30,%al
  8015d3:	75 17                	jne    8015ec <strtol+0x78>
  8015d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d8:	40                   	inc    %eax
  8015d9:	8a 00                	mov    (%eax),%al
  8015db:	3c 78                	cmp    $0x78,%al
  8015dd:	75 0d                	jne    8015ec <strtol+0x78>
		s += 2, base = 16;
  8015df:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8015e3:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8015ea:	eb 28                	jmp    801614 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8015ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015f0:	75 15                	jne    801607 <strtol+0x93>
  8015f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f5:	8a 00                	mov    (%eax),%al
  8015f7:	3c 30                	cmp    $0x30,%al
  8015f9:	75 0c                	jne    801607 <strtol+0x93>
		s++, base = 8;
  8015fb:	ff 45 08             	incl   0x8(%ebp)
  8015fe:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801605:	eb 0d                	jmp    801614 <strtol+0xa0>
	else if (base == 0)
  801607:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80160b:	75 07                	jne    801614 <strtol+0xa0>
		base = 10;
  80160d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801614:	8b 45 08             	mov    0x8(%ebp),%eax
  801617:	8a 00                	mov    (%eax),%al
  801619:	3c 2f                	cmp    $0x2f,%al
  80161b:	7e 19                	jle    801636 <strtol+0xc2>
  80161d:	8b 45 08             	mov    0x8(%ebp),%eax
  801620:	8a 00                	mov    (%eax),%al
  801622:	3c 39                	cmp    $0x39,%al
  801624:	7f 10                	jg     801636 <strtol+0xc2>
			dig = *s - '0';
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	8a 00                	mov    (%eax),%al
  80162b:	0f be c0             	movsbl %al,%eax
  80162e:	83 e8 30             	sub    $0x30,%eax
  801631:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801634:	eb 42                	jmp    801678 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801636:	8b 45 08             	mov    0x8(%ebp),%eax
  801639:	8a 00                	mov    (%eax),%al
  80163b:	3c 60                	cmp    $0x60,%al
  80163d:	7e 19                	jle    801658 <strtol+0xe4>
  80163f:	8b 45 08             	mov    0x8(%ebp),%eax
  801642:	8a 00                	mov    (%eax),%al
  801644:	3c 7a                	cmp    $0x7a,%al
  801646:	7f 10                	jg     801658 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801648:	8b 45 08             	mov    0x8(%ebp),%eax
  80164b:	8a 00                	mov    (%eax),%al
  80164d:	0f be c0             	movsbl %al,%eax
  801650:	83 e8 57             	sub    $0x57,%eax
  801653:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801656:	eb 20                	jmp    801678 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801658:	8b 45 08             	mov    0x8(%ebp),%eax
  80165b:	8a 00                	mov    (%eax),%al
  80165d:	3c 40                	cmp    $0x40,%al
  80165f:	7e 39                	jle    80169a <strtol+0x126>
  801661:	8b 45 08             	mov    0x8(%ebp),%eax
  801664:	8a 00                	mov    (%eax),%al
  801666:	3c 5a                	cmp    $0x5a,%al
  801668:	7f 30                	jg     80169a <strtol+0x126>
			dig = *s - 'A' + 10;
  80166a:	8b 45 08             	mov    0x8(%ebp),%eax
  80166d:	8a 00                	mov    (%eax),%al
  80166f:	0f be c0             	movsbl %al,%eax
  801672:	83 e8 37             	sub    $0x37,%eax
  801675:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801678:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80167b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80167e:	7d 19                	jge    801699 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801680:	ff 45 08             	incl   0x8(%ebp)
  801683:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801686:	0f af 45 10          	imul   0x10(%ebp),%eax
  80168a:	89 c2                	mov    %eax,%edx
  80168c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80168f:	01 d0                	add    %edx,%eax
  801691:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801694:	e9 7b ff ff ff       	jmp    801614 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801699:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80169a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80169e:	74 08                	je     8016a8 <strtol+0x134>
		*endptr = (char *) s;
  8016a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a3:	8b 55 08             	mov    0x8(%ebp),%edx
  8016a6:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016a8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016ac:	74 07                	je     8016b5 <strtol+0x141>
  8016ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b1:	f7 d8                	neg    %eax
  8016b3:	eb 03                	jmp    8016b8 <strtol+0x144>
  8016b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016b8:	c9                   	leave  
  8016b9:	c3                   	ret    

008016ba <ltostr>:

void
ltostr(long value, char *str)
{
  8016ba:	55                   	push   %ebp
  8016bb:	89 e5                	mov    %esp,%ebp
  8016bd:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016c7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016ce:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016d2:	79 13                	jns    8016e7 <ltostr+0x2d>
	{
		neg = 1;
  8016d4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8016db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016de:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8016e1:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8016e4:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8016e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ea:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8016ef:	99                   	cltd   
  8016f0:	f7 f9                	idiv   %ecx
  8016f2:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8016f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f8:	8d 50 01             	lea    0x1(%eax),%edx
  8016fb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016fe:	89 c2                	mov    %eax,%edx
  801700:	8b 45 0c             	mov    0xc(%ebp),%eax
  801703:	01 d0                	add    %edx,%eax
  801705:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801708:	83 c2 30             	add    $0x30,%edx
  80170b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80170d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801710:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801715:	f7 e9                	imul   %ecx
  801717:	c1 fa 02             	sar    $0x2,%edx
  80171a:	89 c8                	mov    %ecx,%eax
  80171c:	c1 f8 1f             	sar    $0x1f,%eax
  80171f:	29 c2                	sub    %eax,%edx
  801721:	89 d0                	mov    %edx,%eax
  801723:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801726:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801729:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80172e:	f7 e9                	imul   %ecx
  801730:	c1 fa 02             	sar    $0x2,%edx
  801733:	89 c8                	mov    %ecx,%eax
  801735:	c1 f8 1f             	sar    $0x1f,%eax
  801738:	29 c2                	sub    %eax,%edx
  80173a:	89 d0                	mov    %edx,%eax
  80173c:	c1 e0 02             	shl    $0x2,%eax
  80173f:	01 d0                	add    %edx,%eax
  801741:	01 c0                	add    %eax,%eax
  801743:	29 c1                	sub    %eax,%ecx
  801745:	89 ca                	mov    %ecx,%edx
  801747:	85 d2                	test   %edx,%edx
  801749:	75 9c                	jne    8016e7 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80174b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801752:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801755:	48                   	dec    %eax
  801756:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801759:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80175d:	74 3d                	je     80179c <ltostr+0xe2>
		start = 1 ;
  80175f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801766:	eb 34                	jmp    80179c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801768:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80176b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176e:	01 d0                	add    %edx,%eax
  801770:	8a 00                	mov    (%eax),%al
  801772:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801775:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801778:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177b:	01 c2                	add    %eax,%edx
  80177d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801780:	8b 45 0c             	mov    0xc(%ebp),%eax
  801783:	01 c8                	add    %ecx,%eax
  801785:	8a 00                	mov    (%eax),%al
  801787:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801789:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80178c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178f:	01 c2                	add    %eax,%edx
  801791:	8a 45 eb             	mov    -0x15(%ebp),%al
  801794:	88 02                	mov    %al,(%edx)
		start++ ;
  801796:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801799:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80179c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80179f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017a2:	7c c4                	jl     801768 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017a4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017aa:	01 d0                	add    %edx,%eax
  8017ac:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017af:	90                   	nop
  8017b0:	c9                   	leave  
  8017b1:	c3                   	ret    

008017b2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017b2:	55                   	push   %ebp
  8017b3:	89 e5                	mov    %esp,%ebp
  8017b5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017b8:	ff 75 08             	pushl  0x8(%ebp)
  8017bb:	e8 54 fa ff ff       	call   801214 <strlen>
  8017c0:	83 c4 04             	add    $0x4,%esp
  8017c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017c6:	ff 75 0c             	pushl  0xc(%ebp)
  8017c9:	e8 46 fa ff ff       	call   801214 <strlen>
  8017ce:	83 c4 04             	add    $0x4,%esp
  8017d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017d4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8017db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8017e2:	eb 17                	jmp    8017fb <strcconcat+0x49>
		final[s] = str1[s] ;
  8017e4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ea:	01 c2                	add    %eax,%edx
  8017ec:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8017ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f2:	01 c8                	add    %ecx,%eax
  8017f4:	8a 00                	mov    (%eax),%al
  8017f6:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8017f8:	ff 45 fc             	incl   -0x4(%ebp)
  8017fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017fe:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801801:	7c e1                	jl     8017e4 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801803:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80180a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801811:	eb 1f                	jmp    801832 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801813:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801816:	8d 50 01             	lea    0x1(%eax),%edx
  801819:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80181c:	89 c2                	mov    %eax,%edx
  80181e:	8b 45 10             	mov    0x10(%ebp),%eax
  801821:	01 c2                	add    %eax,%edx
  801823:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801826:	8b 45 0c             	mov    0xc(%ebp),%eax
  801829:	01 c8                	add    %ecx,%eax
  80182b:	8a 00                	mov    (%eax),%al
  80182d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80182f:	ff 45 f8             	incl   -0x8(%ebp)
  801832:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801835:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801838:	7c d9                	jl     801813 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80183a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80183d:	8b 45 10             	mov    0x10(%ebp),%eax
  801840:	01 d0                	add    %edx,%eax
  801842:	c6 00 00             	movb   $0x0,(%eax)
}
  801845:	90                   	nop
  801846:	c9                   	leave  
  801847:	c3                   	ret    

00801848 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801848:	55                   	push   %ebp
  801849:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80184b:	8b 45 14             	mov    0x14(%ebp),%eax
  80184e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801854:	8b 45 14             	mov    0x14(%ebp),%eax
  801857:	8b 00                	mov    (%eax),%eax
  801859:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801860:	8b 45 10             	mov    0x10(%ebp),%eax
  801863:	01 d0                	add    %edx,%eax
  801865:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80186b:	eb 0c                	jmp    801879 <strsplit+0x31>
			*string++ = 0;
  80186d:	8b 45 08             	mov    0x8(%ebp),%eax
  801870:	8d 50 01             	lea    0x1(%eax),%edx
  801873:	89 55 08             	mov    %edx,0x8(%ebp)
  801876:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801879:	8b 45 08             	mov    0x8(%ebp),%eax
  80187c:	8a 00                	mov    (%eax),%al
  80187e:	84 c0                	test   %al,%al
  801880:	74 18                	je     80189a <strsplit+0x52>
  801882:	8b 45 08             	mov    0x8(%ebp),%eax
  801885:	8a 00                	mov    (%eax),%al
  801887:	0f be c0             	movsbl %al,%eax
  80188a:	50                   	push   %eax
  80188b:	ff 75 0c             	pushl  0xc(%ebp)
  80188e:	e8 13 fb ff ff       	call   8013a6 <strchr>
  801893:	83 c4 08             	add    $0x8,%esp
  801896:	85 c0                	test   %eax,%eax
  801898:	75 d3                	jne    80186d <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80189a:	8b 45 08             	mov    0x8(%ebp),%eax
  80189d:	8a 00                	mov    (%eax),%al
  80189f:	84 c0                	test   %al,%al
  8018a1:	74 5a                	je     8018fd <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8018a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8018a6:	8b 00                	mov    (%eax),%eax
  8018a8:	83 f8 0f             	cmp    $0xf,%eax
  8018ab:	75 07                	jne    8018b4 <strsplit+0x6c>
		{
			return 0;
  8018ad:	b8 00 00 00 00       	mov    $0x0,%eax
  8018b2:	eb 66                	jmp    80191a <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b7:	8b 00                	mov    (%eax),%eax
  8018b9:	8d 48 01             	lea    0x1(%eax),%ecx
  8018bc:	8b 55 14             	mov    0x14(%ebp),%edx
  8018bf:	89 0a                	mov    %ecx,(%edx)
  8018c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8018cb:	01 c2                	add    %eax,%edx
  8018cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018d2:	eb 03                	jmp    8018d7 <strsplit+0x8f>
			string++;
  8018d4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018da:	8a 00                	mov    (%eax),%al
  8018dc:	84 c0                	test   %al,%al
  8018de:	74 8b                	je     80186b <strsplit+0x23>
  8018e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e3:	8a 00                	mov    (%eax),%al
  8018e5:	0f be c0             	movsbl %al,%eax
  8018e8:	50                   	push   %eax
  8018e9:	ff 75 0c             	pushl  0xc(%ebp)
  8018ec:	e8 b5 fa ff ff       	call   8013a6 <strchr>
  8018f1:	83 c4 08             	add    $0x8,%esp
  8018f4:	85 c0                	test   %eax,%eax
  8018f6:	74 dc                	je     8018d4 <strsplit+0x8c>
			string++;
	}
  8018f8:	e9 6e ff ff ff       	jmp    80186b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8018fd:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8018fe:	8b 45 14             	mov    0x14(%ebp),%eax
  801901:	8b 00                	mov    (%eax),%eax
  801903:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80190a:	8b 45 10             	mov    0x10(%ebp),%eax
  80190d:	01 d0                	add    %edx,%eax
  80190f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801915:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80191a:	c9                   	leave  
  80191b:	c3                   	ret    

0080191c <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80191c:	55                   	push   %ebp
  80191d:	89 e5                	mov    %esp,%ebp
  80191f:	83 ec 18             	sub    $0x18,%esp
  801922:	8b 45 10             	mov    0x10(%ebp),%eax
  801925:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801928:	83 ec 04             	sub    $0x4,%esp
  80192b:	68 04 2b 80 00       	push   $0x802b04
  801930:	6a 17                	push   $0x17
  801932:	68 23 2b 80 00       	push   $0x802b23
  801937:	e8 9c ed ff ff       	call   8006d8 <_panic>

0080193c <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80193c:	55                   	push   %ebp
  80193d:	89 e5                	mov    %esp,%ebp
  80193f:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801942:	83 ec 04             	sub    $0x4,%esp
  801945:	68 2f 2b 80 00       	push   $0x802b2f
  80194a:	6a 2f                	push   $0x2f
  80194c:	68 23 2b 80 00       	push   $0x802b23
  801951:	e8 82 ed ff ff       	call   8006d8 <_panic>

00801956 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801956:	55                   	push   %ebp
  801957:	89 e5                	mov    %esp,%ebp
  801959:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80195c:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801963:	8b 55 08             	mov    0x8(%ebp),%edx
  801966:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801969:	01 d0                	add    %edx,%eax
  80196b:	48                   	dec    %eax
  80196c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  80196f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801972:	ba 00 00 00 00       	mov    $0x0,%edx
  801977:	f7 75 ec             	divl   -0x14(%ebp)
  80197a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80197d:	29 d0                	sub    %edx,%eax
  80197f:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801982:	8b 45 08             	mov    0x8(%ebp),%eax
  801985:	c1 e8 0c             	shr    $0xc,%eax
  801988:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80198b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801992:	e9 c8 00 00 00       	jmp    801a5f <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801997:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80199e:	eb 27                	jmp    8019c7 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8019a0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019a6:	01 c2                	add    %eax,%edx
  8019a8:	89 d0                	mov    %edx,%eax
  8019aa:	01 c0                	add    %eax,%eax
  8019ac:	01 d0                	add    %edx,%eax
  8019ae:	c1 e0 02             	shl    $0x2,%eax
  8019b1:	05 48 30 80 00       	add    $0x803048,%eax
  8019b6:	8b 00                	mov    (%eax),%eax
  8019b8:	85 c0                	test   %eax,%eax
  8019ba:	74 08                	je     8019c4 <malloc+0x6e>
            	i += j;
  8019bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019bf:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8019c2:	eb 0b                	jmp    8019cf <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8019c4:	ff 45 f0             	incl   -0x10(%ebp)
  8019c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019ca:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019cd:	72 d1                	jb     8019a0 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8019cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019d2:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019d5:	0f 85 81 00 00 00    	jne    801a5c <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8019db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019de:	05 00 00 08 00       	add    $0x80000,%eax
  8019e3:	c1 e0 0c             	shl    $0xc,%eax
  8019e6:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8019e9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019f0:	eb 1f                	jmp    801a11 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8019f2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019f8:	01 c2                	add    %eax,%edx
  8019fa:	89 d0                	mov    %edx,%eax
  8019fc:	01 c0                	add    %eax,%eax
  8019fe:	01 d0                	add    %edx,%eax
  801a00:	c1 e0 02             	shl    $0x2,%eax
  801a03:	05 48 30 80 00       	add    $0x803048,%eax
  801a08:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801a0e:	ff 45 f0             	incl   -0x10(%ebp)
  801a11:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a14:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a17:	72 d9                	jb     8019f2 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801a19:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a1c:	89 d0                	mov    %edx,%eax
  801a1e:	01 c0                	add    %eax,%eax
  801a20:	01 d0                	add    %edx,%eax
  801a22:	c1 e0 02             	shl    $0x2,%eax
  801a25:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801a2b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a2e:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801a30:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a33:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801a36:	89 c8                	mov    %ecx,%eax
  801a38:	01 c0                	add    %eax,%eax
  801a3a:	01 c8                	add    %ecx,%eax
  801a3c:	c1 e0 02             	shl    $0x2,%eax
  801a3f:	05 44 30 80 00       	add    $0x803044,%eax
  801a44:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801a46:	83 ec 08             	sub    $0x8,%esp
  801a49:	ff 75 08             	pushl  0x8(%ebp)
  801a4c:	ff 75 e0             	pushl  -0x20(%ebp)
  801a4f:	e8 2b 03 00 00       	call   801d7f <sys_allocateMem>
  801a54:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801a57:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a5a:	eb 19                	jmp    801a75 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801a5c:	ff 45 f4             	incl   -0xc(%ebp)
  801a5f:	a1 04 30 80 00       	mov    0x803004,%eax
  801a64:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801a67:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a6a:	0f 83 27 ff ff ff    	jae    801997 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801a70:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a75:	c9                   	leave  
  801a76:	c3                   	ret    

00801a77 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801a77:	55                   	push   %ebp
  801a78:	89 e5                	mov    %esp,%ebp
  801a7a:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801a7d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801a81:	0f 84 e5 00 00 00    	je     801b6c <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801a87:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801a8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a90:	05 00 00 00 80       	add    $0x80000000,%eax
  801a95:	c1 e8 0c             	shr    $0xc,%eax
  801a98:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801a9b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a9e:	89 d0                	mov    %edx,%eax
  801aa0:	01 c0                	add    %eax,%eax
  801aa2:	01 d0                	add    %edx,%eax
  801aa4:	c1 e0 02             	shl    $0x2,%eax
  801aa7:	05 40 30 80 00       	add    $0x803040,%eax
  801aac:	8b 00                	mov    (%eax),%eax
  801aae:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ab1:	0f 85 b8 00 00 00    	jne    801b6f <free+0xf8>
  801ab7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801aba:	89 d0                	mov    %edx,%eax
  801abc:	01 c0                	add    %eax,%eax
  801abe:	01 d0                	add    %edx,%eax
  801ac0:	c1 e0 02             	shl    $0x2,%eax
  801ac3:	05 48 30 80 00       	add    $0x803048,%eax
  801ac8:	8b 00                	mov    (%eax),%eax
  801aca:	85 c0                	test   %eax,%eax
  801acc:	0f 84 9d 00 00 00    	je     801b6f <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801ad2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ad5:	89 d0                	mov    %edx,%eax
  801ad7:	01 c0                	add    %eax,%eax
  801ad9:	01 d0                	add    %edx,%eax
  801adb:	c1 e0 02             	shl    $0x2,%eax
  801ade:	05 44 30 80 00       	add    $0x803044,%eax
  801ae3:	8b 00                	mov    (%eax),%eax
  801ae5:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801ae8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801aeb:	c1 e0 0c             	shl    $0xc,%eax
  801aee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801af1:	83 ec 08             	sub    $0x8,%esp
  801af4:	ff 75 e4             	pushl  -0x1c(%ebp)
  801af7:	ff 75 f0             	pushl  -0x10(%ebp)
  801afa:	e8 64 02 00 00       	call   801d63 <sys_freeMem>
  801aff:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801b02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b09:	eb 57                	jmp    801b62 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801b0b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b11:	01 c2                	add    %eax,%edx
  801b13:	89 d0                	mov    %edx,%eax
  801b15:	01 c0                	add    %eax,%eax
  801b17:	01 d0                	add    %edx,%eax
  801b19:	c1 e0 02             	shl    $0x2,%eax
  801b1c:	05 48 30 80 00       	add    $0x803048,%eax
  801b21:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801b27:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b2d:	01 c2                	add    %eax,%edx
  801b2f:	89 d0                	mov    %edx,%eax
  801b31:	01 c0                	add    %eax,%eax
  801b33:	01 d0                	add    %edx,%eax
  801b35:	c1 e0 02             	shl    $0x2,%eax
  801b38:	05 40 30 80 00       	add    $0x803040,%eax
  801b3d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801b43:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b46:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b49:	01 c2                	add    %eax,%edx
  801b4b:	89 d0                	mov    %edx,%eax
  801b4d:	01 c0                	add    %eax,%eax
  801b4f:	01 d0                	add    %edx,%eax
  801b51:	c1 e0 02             	shl    $0x2,%eax
  801b54:	05 44 30 80 00       	add    $0x803044,%eax
  801b59:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801b5f:	ff 45 f4             	incl   -0xc(%ebp)
  801b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b65:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b68:	7c a1                	jl     801b0b <free+0x94>
  801b6a:	eb 04                	jmp    801b70 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801b6c:	90                   	nop
  801b6d:	eb 01                	jmp    801b70 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801b6f:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801b70:	c9                   	leave  
  801b71:	c3                   	ret    

00801b72 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
  801b75:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801b78:	83 ec 04             	sub    $0x4,%esp
  801b7b:	68 4c 2b 80 00       	push   $0x802b4c
  801b80:	68 ae 00 00 00       	push   $0xae
  801b85:	68 23 2b 80 00       	push   $0x802b23
  801b8a:	e8 49 eb ff ff       	call   8006d8 <_panic>

00801b8f <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801b8f:	55                   	push   %ebp
  801b90:	89 e5                	mov    %esp,%ebp
  801b92:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801b95:	83 ec 04             	sub    $0x4,%esp
  801b98:	68 6c 2b 80 00       	push   $0x802b6c
  801b9d:	68 ca 00 00 00       	push   $0xca
  801ba2:	68 23 2b 80 00       	push   $0x802b23
  801ba7:	e8 2c eb ff ff       	call   8006d8 <_panic>

00801bac <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801bac:	55                   	push   %ebp
  801bad:	89 e5                	mov    %esp,%ebp
  801baf:	57                   	push   %edi
  801bb0:	56                   	push   %esi
  801bb1:	53                   	push   %ebx
  801bb2:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bbb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bbe:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bc1:	8b 7d 18             	mov    0x18(%ebp),%edi
  801bc4:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801bc7:	cd 30                	int    $0x30
  801bc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801bcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801bcf:	83 c4 10             	add    $0x10,%esp
  801bd2:	5b                   	pop    %ebx
  801bd3:	5e                   	pop    %esi
  801bd4:	5f                   	pop    %edi
  801bd5:	5d                   	pop    %ebp
  801bd6:	c3                   	ret    

00801bd7 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801bd7:	55                   	push   %ebp
  801bd8:	89 e5                	mov    %esp,%ebp
  801bda:	83 ec 04             	sub    $0x4,%esp
  801bdd:	8b 45 10             	mov    0x10(%ebp),%eax
  801be0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801be3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801be7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	52                   	push   %edx
  801bef:	ff 75 0c             	pushl  0xc(%ebp)
  801bf2:	50                   	push   %eax
  801bf3:	6a 00                	push   $0x0
  801bf5:	e8 b2 ff ff ff       	call   801bac <syscall>
  801bfa:	83 c4 18             	add    $0x18,%esp
}
  801bfd:	90                   	nop
  801bfe:	c9                   	leave  
  801bff:	c3                   	ret    

00801c00 <sys_cgetc>:

int
sys_cgetc(void)
{
  801c00:	55                   	push   %ebp
  801c01:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 00                	push   $0x0
  801c0d:	6a 01                	push   $0x1
  801c0f:	e8 98 ff ff ff       	call   801bac <syscall>
  801c14:	83 c4 18             	add    $0x18,%esp
}
  801c17:	c9                   	leave  
  801c18:	c3                   	ret    

00801c19 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c19:	55                   	push   %ebp
  801c1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	50                   	push   %eax
  801c28:	6a 05                	push   $0x5
  801c2a:	e8 7d ff ff ff       	call   801bac <syscall>
  801c2f:	83 c4 18             	add    $0x18,%esp
}
  801c32:	c9                   	leave  
  801c33:	c3                   	ret    

00801c34 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c34:	55                   	push   %ebp
  801c35:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 02                	push   $0x2
  801c43:	e8 64 ff ff ff       	call   801bac <syscall>
  801c48:	83 c4 18             	add    $0x18,%esp
}
  801c4b:	c9                   	leave  
  801c4c:	c3                   	ret    

00801c4d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c4d:	55                   	push   %ebp
  801c4e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 03                	push   $0x3
  801c5c:	e8 4b ff ff ff       	call   801bac <syscall>
  801c61:	83 c4 18             	add    $0x18,%esp
}
  801c64:	c9                   	leave  
  801c65:	c3                   	ret    

00801c66 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c66:	55                   	push   %ebp
  801c67:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 04                	push   $0x4
  801c75:	e8 32 ff ff ff       	call   801bac <syscall>
  801c7a:	83 c4 18             	add    $0x18,%esp
}
  801c7d:	c9                   	leave  
  801c7e:	c3                   	ret    

00801c7f <sys_env_exit>:


void sys_env_exit(void)
{
  801c7f:	55                   	push   %ebp
  801c80:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c82:	6a 00                	push   $0x0
  801c84:	6a 00                	push   $0x0
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 06                	push   $0x6
  801c8e:	e8 19 ff ff ff       	call   801bac <syscall>
  801c93:	83 c4 18             	add    $0x18,%esp
}
  801c96:	90                   	nop
  801c97:	c9                   	leave  
  801c98:	c3                   	ret    

00801c99 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c99:	55                   	push   %ebp
  801c9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	52                   	push   %edx
  801ca9:	50                   	push   %eax
  801caa:	6a 07                	push   $0x7
  801cac:	e8 fb fe ff ff       	call   801bac <syscall>
  801cb1:	83 c4 18             	add    $0x18,%esp
}
  801cb4:	c9                   	leave  
  801cb5:	c3                   	ret    

00801cb6 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801cb6:	55                   	push   %ebp
  801cb7:	89 e5                	mov    %esp,%ebp
  801cb9:	56                   	push   %esi
  801cba:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801cbb:	8b 75 18             	mov    0x18(%ebp),%esi
  801cbe:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cc1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cc4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cca:	56                   	push   %esi
  801ccb:	53                   	push   %ebx
  801ccc:	51                   	push   %ecx
  801ccd:	52                   	push   %edx
  801cce:	50                   	push   %eax
  801ccf:	6a 08                	push   $0x8
  801cd1:	e8 d6 fe ff ff       	call   801bac <syscall>
  801cd6:	83 c4 18             	add    $0x18,%esp
}
  801cd9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801cdc:	5b                   	pop    %ebx
  801cdd:	5e                   	pop    %esi
  801cde:	5d                   	pop    %ebp
  801cdf:	c3                   	ret    

00801ce0 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ce0:	55                   	push   %ebp
  801ce1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801ce3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ce6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	52                   	push   %edx
  801cf0:	50                   	push   %eax
  801cf1:	6a 09                	push   $0x9
  801cf3:	e8 b4 fe ff ff       	call   801bac <syscall>
  801cf8:	83 c4 18             	add    $0x18,%esp
}
  801cfb:	c9                   	leave  
  801cfc:	c3                   	ret    

00801cfd <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801cfd:	55                   	push   %ebp
  801cfe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	ff 75 0c             	pushl  0xc(%ebp)
  801d09:	ff 75 08             	pushl  0x8(%ebp)
  801d0c:	6a 0a                	push   $0xa
  801d0e:	e8 99 fe ff ff       	call   801bac <syscall>
  801d13:	83 c4 18             	add    $0x18,%esp
}
  801d16:	c9                   	leave  
  801d17:	c3                   	ret    

00801d18 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d18:	55                   	push   %ebp
  801d19:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	6a 00                	push   $0x0
  801d25:	6a 0b                	push   $0xb
  801d27:	e8 80 fe ff ff       	call   801bac <syscall>
  801d2c:	83 c4 18             	add    $0x18,%esp
}
  801d2f:	c9                   	leave  
  801d30:	c3                   	ret    

00801d31 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d31:	55                   	push   %ebp
  801d32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d34:	6a 00                	push   $0x0
  801d36:	6a 00                	push   $0x0
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 0c                	push   $0xc
  801d40:	e8 67 fe ff ff       	call   801bac <syscall>
  801d45:	83 c4 18             	add    $0x18,%esp
}
  801d48:	c9                   	leave  
  801d49:	c3                   	ret    

00801d4a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d4a:	55                   	push   %ebp
  801d4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d4d:	6a 00                	push   $0x0
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	6a 0d                	push   $0xd
  801d59:	e8 4e fe ff ff       	call   801bac <syscall>
  801d5e:	83 c4 18             	add    $0x18,%esp
}
  801d61:	c9                   	leave  
  801d62:	c3                   	ret    

00801d63 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d63:	55                   	push   %ebp
  801d64:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	ff 75 0c             	pushl  0xc(%ebp)
  801d6f:	ff 75 08             	pushl  0x8(%ebp)
  801d72:	6a 11                	push   $0x11
  801d74:	e8 33 fe ff ff       	call   801bac <syscall>
  801d79:	83 c4 18             	add    $0x18,%esp
	return;
  801d7c:	90                   	nop
}
  801d7d:	c9                   	leave  
  801d7e:	c3                   	ret    

00801d7f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d7f:	55                   	push   %ebp
  801d80:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d82:	6a 00                	push   $0x0
  801d84:	6a 00                	push   $0x0
  801d86:	6a 00                	push   $0x0
  801d88:	ff 75 0c             	pushl  0xc(%ebp)
  801d8b:	ff 75 08             	pushl  0x8(%ebp)
  801d8e:	6a 12                	push   $0x12
  801d90:	e8 17 fe ff ff       	call   801bac <syscall>
  801d95:	83 c4 18             	add    $0x18,%esp
	return ;
  801d98:	90                   	nop
}
  801d99:	c9                   	leave  
  801d9a:	c3                   	ret    

00801d9b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d9b:	55                   	push   %ebp
  801d9c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 0e                	push   $0xe
  801daa:	e8 fd fd ff ff       	call   801bac <syscall>
  801daf:	83 c4 18             	add    $0x18,%esp
}
  801db2:	c9                   	leave  
  801db3:	c3                   	ret    

00801db4 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801db4:	55                   	push   %ebp
  801db5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801db7:	6a 00                	push   $0x0
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	ff 75 08             	pushl  0x8(%ebp)
  801dc2:	6a 0f                	push   $0xf
  801dc4:	e8 e3 fd ff ff       	call   801bac <syscall>
  801dc9:	83 c4 18             	add    $0x18,%esp
}
  801dcc:	c9                   	leave  
  801dcd:	c3                   	ret    

00801dce <sys_scarce_memory>:

void sys_scarce_memory()
{
  801dce:	55                   	push   %ebp
  801dcf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 10                	push   $0x10
  801ddd:	e8 ca fd ff ff       	call   801bac <syscall>
  801de2:	83 c4 18             	add    $0x18,%esp
}
  801de5:	90                   	nop
  801de6:	c9                   	leave  
  801de7:	c3                   	ret    

00801de8 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801de8:	55                   	push   %ebp
  801de9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801deb:	6a 00                	push   $0x0
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 14                	push   $0x14
  801df7:	e8 b0 fd ff ff       	call   801bac <syscall>
  801dfc:	83 c4 18             	add    $0x18,%esp
}
  801dff:	90                   	nop
  801e00:	c9                   	leave  
  801e01:	c3                   	ret    

00801e02 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e02:	55                   	push   %ebp
  801e03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e05:	6a 00                	push   $0x0
  801e07:	6a 00                	push   $0x0
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 15                	push   $0x15
  801e11:	e8 96 fd ff ff       	call   801bac <syscall>
  801e16:	83 c4 18             	add    $0x18,%esp
}
  801e19:	90                   	nop
  801e1a:	c9                   	leave  
  801e1b:	c3                   	ret    

00801e1c <sys_cputc>:


void
sys_cputc(const char c)
{
  801e1c:	55                   	push   %ebp
  801e1d:	89 e5                	mov    %esp,%ebp
  801e1f:	83 ec 04             	sub    $0x4,%esp
  801e22:	8b 45 08             	mov    0x8(%ebp),%eax
  801e25:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e28:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	50                   	push   %eax
  801e35:	6a 16                	push   $0x16
  801e37:	e8 70 fd ff ff       	call   801bac <syscall>
  801e3c:	83 c4 18             	add    $0x18,%esp
}
  801e3f:	90                   	nop
  801e40:	c9                   	leave  
  801e41:	c3                   	ret    

00801e42 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e42:	55                   	push   %ebp
  801e43:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 17                	push   $0x17
  801e51:	e8 56 fd ff ff       	call   801bac <syscall>
  801e56:	83 c4 18             	add    $0x18,%esp
}
  801e59:	90                   	nop
  801e5a:	c9                   	leave  
  801e5b:	c3                   	ret    

00801e5c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e5c:	55                   	push   %ebp
  801e5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	ff 75 0c             	pushl  0xc(%ebp)
  801e6b:	50                   	push   %eax
  801e6c:	6a 18                	push   $0x18
  801e6e:	e8 39 fd ff ff       	call   801bac <syscall>
  801e73:	83 c4 18             	add    $0x18,%esp
}
  801e76:	c9                   	leave  
  801e77:	c3                   	ret    

00801e78 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e78:	55                   	push   %ebp
  801e79:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e81:	6a 00                	push   $0x0
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	52                   	push   %edx
  801e88:	50                   	push   %eax
  801e89:	6a 1b                	push   $0x1b
  801e8b:	e8 1c fd ff ff       	call   801bac <syscall>
  801e90:	83 c4 18             	add    $0x18,%esp
}
  801e93:	c9                   	leave  
  801e94:	c3                   	ret    

00801e95 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e95:	55                   	push   %ebp
  801e96:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e98:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	52                   	push   %edx
  801ea5:	50                   	push   %eax
  801ea6:	6a 19                	push   $0x19
  801ea8:	e8 ff fc ff ff       	call   801bac <syscall>
  801ead:	83 c4 18             	add    $0x18,%esp
}
  801eb0:	90                   	nop
  801eb1:	c9                   	leave  
  801eb2:	c3                   	ret    

00801eb3 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801eb3:	55                   	push   %ebp
  801eb4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801eb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	52                   	push   %edx
  801ec3:	50                   	push   %eax
  801ec4:	6a 1a                	push   $0x1a
  801ec6:	e8 e1 fc ff ff       	call   801bac <syscall>
  801ecb:	83 c4 18             	add    $0x18,%esp
}
  801ece:	90                   	nop
  801ecf:	c9                   	leave  
  801ed0:	c3                   	ret    

00801ed1 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ed1:	55                   	push   %ebp
  801ed2:	89 e5                	mov    %esp,%ebp
  801ed4:	83 ec 04             	sub    $0x4,%esp
  801ed7:	8b 45 10             	mov    0x10(%ebp),%eax
  801eda:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801edd:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ee0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee7:	6a 00                	push   $0x0
  801ee9:	51                   	push   %ecx
  801eea:	52                   	push   %edx
  801eeb:	ff 75 0c             	pushl  0xc(%ebp)
  801eee:	50                   	push   %eax
  801eef:	6a 1c                	push   $0x1c
  801ef1:	e8 b6 fc ff ff       	call   801bac <syscall>
  801ef6:	83 c4 18             	add    $0x18,%esp
}
  801ef9:	c9                   	leave  
  801efa:	c3                   	ret    

00801efb <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801efb:	55                   	push   %ebp
  801efc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801efe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f01:	8b 45 08             	mov    0x8(%ebp),%eax
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	52                   	push   %edx
  801f0b:	50                   	push   %eax
  801f0c:	6a 1d                	push   $0x1d
  801f0e:	e8 99 fc ff ff       	call   801bac <syscall>
  801f13:	83 c4 18             	add    $0x18,%esp
}
  801f16:	c9                   	leave  
  801f17:	c3                   	ret    

00801f18 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f18:	55                   	push   %ebp
  801f19:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f1b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f1e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f21:	8b 45 08             	mov    0x8(%ebp),%eax
  801f24:	6a 00                	push   $0x0
  801f26:	6a 00                	push   $0x0
  801f28:	51                   	push   %ecx
  801f29:	52                   	push   %edx
  801f2a:	50                   	push   %eax
  801f2b:	6a 1e                	push   $0x1e
  801f2d:	e8 7a fc ff ff       	call   801bac <syscall>
  801f32:	83 c4 18             	add    $0x18,%esp
}
  801f35:	c9                   	leave  
  801f36:	c3                   	ret    

00801f37 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f37:	55                   	push   %ebp
  801f38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f40:	6a 00                	push   $0x0
  801f42:	6a 00                	push   $0x0
  801f44:	6a 00                	push   $0x0
  801f46:	52                   	push   %edx
  801f47:	50                   	push   %eax
  801f48:	6a 1f                	push   $0x1f
  801f4a:	e8 5d fc ff ff       	call   801bac <syscall>
  801f4f:	83 c4 18             	add    $0x18,%esp
}
  801f52:	c9                   	leave  
  801f53:	c3                   	ret    

00801f54 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f54:	55                   	push   %ebp
  801f55:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 00                	push   $0x0
  801f5f:	6a 00                	push   $0x0
  801f61:	6a 20                	push   $0x20
  801f63:	e8 44 fc ff ff       	call   801bac <syscall>
  801f68:	83 c4 18             	add    $0x18,%esp
}
  801f6b:	c9                   	leave  
  801f6c:	c3                   	ret    

00801f6d <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801f6d:	55                   	push   %ebp
  801f6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801f70:	8b 45 08             	mov    0x8(%ebp),%eax
  801f73:	6a 00                	push   $0x0
  801f75:	6a 00                	push   $0x0
  801f77:	ff 75 10             	pushl  0x10(%ebp)
  801f7a:	ff 75 0c             	pushl  0xc(%ebp)
  801f7d:	50                   	push   %eax
  801f7e:	6a 21                	push   $0x21
  801f80:	e8 27 fc ff ff       	call   801bac <syscall>
  801f85:	83 c4 18             	add    $0x18,%esp
}
  801f88:	c9                   	leave  
  801f89:	c3                   	ret    

00801f8a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801f8a:	55                   	push   %ebp
  801f8b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 00                	push   $0x0
  801f98:	50                   	push   %eax
  801f99:	6a 22                	push   $0x22
  801f9b:	e8 0c fc ff ff       	call   801bac <syscall>
  801fa0:	83 c4 18             	add    $0x18,%esp
}
  801fa3:	90                   	nop
  801fa4:	c9                   	leave  
  801fa5:	c3                   	ret    

00801fa6 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801fa6:	55                   	push   %ebp
  801fa7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801fa9:	8b 45 08             	mov    0x8(%ebp),%eax
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	50                   	push   %eax
  801fb5:	6a 23                	push   $0x23
  801fb7:	e8 f0 fb ff ff       	call   801bac <syscall>
  801fbc:	83 c4 18             	add    $0x18,%esp
}
  801fbf:	90                   	nop
  801fc0:	c9                   	leave  
  801fc1:	c3                   	ret    

00801fc2 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801fc2:	55                   	push   %ebp
  801fc3:	89 e5                	mov    %esp,%ebp
  801fc5:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801fc8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fcb:	8d 50 04             	lea    0x4(%eax),%edx
  801fce:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	52                   	push   %edx
  801fd8:	50                   	push   %eax
  801fd9:	6a 24                	push   $0x24
  801fdb:	e8 cc fb ff ff       	call   801bac <syscall>
  801fe0:	83 c4 18             	add    $0x18,%esp
	return result;
  801fe3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801fe6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801fe9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801fec:	89 01                	mov    %eax,(%ecx)
  801fee:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801ff1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff4:	c9                   	leave  
  801ff5:	c2 04 00             	ret    $0x4

00801ff8 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ff8:	55                   	push   %ebp
  801ff9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	ff 75 10             	pushl  0x10(%ebp)
  802002:	ff 75 0c             	pushl  0xc(%ebp)
  802005:	ff 75 08             	pushl  0x8(%ebp)
  802008:	6a 13                	push   $0x13
  80200a:	e8 9d fb ff ff       	call   801bac <syscall>
  80200f:	83 c4 18             	add    $0x18,%esp
	return ;
  802012:	90                   	nop
}
  802013:	c9                   	leave  
  802014:	c3                   	ret    

00802015 <sys_rcr2>:
uint32 sys_rcr2()
{
  802015:	55                   	push   %ebp
  802016:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 25                	push   $0x25
  802024:	e8 83 fb ff ff       	call   801bac <syscall>
  802029:	83 c4 18             	add    $0x18,%esp
}
  80202c:	c9                   	leave  
  80202d:	c3                   	ret    

0080202e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80202e:	55                   	push   %ebp
  80202f:	89 e5                	mov    %esp,%ebp
  802031:	83 ec 04             	sub    $0x4,%esp
  802034:	8b 45 08             	mov    0x8(%ebp),%eax
  802037:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80203a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80203e:	6a 00                	push   $0x0
  802040:	6a 00                	push   $0x0
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	50                   	push   %eax
  802047:	6a 26                	push   $0x26
  802049:	e8 5e fb ff ff       	call   801bac <syscall>
  80204e:	83 c4 18             	add    $0x18,%esp
	return ;
  802051:	90                   	nop
}
  802052:	c9                   	leave  
  802053:	c3                   	ret    

00802054 <rsttst>:
void rsttst()
{
  802054:	55                   	push   %ebp
  802055:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802057:	6a 00                	push   $0x0
  802059:	6a 00                	push   $0x0
  80205b:	6a 00                	push   $0x0
  80205d:	6a 00                	push   $0x0
  80205f:	6a 00                	push   $0x0
  802061:	6a 28                	push   $0x28
  802063:	e8 44 fb ff ff       	call   801bac <syscall>
  802068:	83 c4 18             	add    $0x18,%esp
	return ;
  80206b:	90                   	nop
}
  80206c:	c9                   	leave  
  80206d:	c3                   	ret    

0080206e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80206e:	55                   	push   %ebp
  80206f:	89 e5                	mov    %esp,%ebp
  802071:	83 ec 04             	sub    $0x4,%esp
  802074:	8b 45 14             	mov    0x14(%ebp),%eax
  802077:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80207a:	8b 55 18             	mov    0x18(%ebp),%edx
  80207d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802081:	52                   	push   %edx
  802082:	50                   	push   %eax
  802083:	ff 75 10             	pushl  0x10(%ebp)
  802086:	ff 75 0c             	pushl  0xc(%ebp)
  802089:	ff 75 08             	pushl  0x8(%ebp)
  80208c:	6a 27                	push   $0x27
  80208e:	e8 19 fb ff ff       	call   801bac <syscall>
  802093:	83 c4 18             	add    $0x18,%esp
	return ;
  802096:	90                   	nop
}
  802097:	c9                   	leave  
  802098:	c3                   	ret    

00802099 <chktst>:
void chktst(uint32 n)
{
  802099:	55                   	push   %ebp
  80209a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	ff 75 08             	pushl  0x8(%ebp)
  8020a7:	6a 29                	push   $0x29
  8020a9:	e8 fe fa ff ff       	call   801bac <syscall>
  8020ae:	83 c4 18             	add    $0x18,%esp
	return ;
  8020b1:	90                   	nop
}
  8020b2:	c9                   	leave  
  8020b3:	c3                   	ret    

008020b4 <inctst>:

void inctst()
{
  8020b4:	55                   	push   %ebp
  8020b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	6a 2a                	push   $0x2a
  8020c3:	e8 e4 fa ff ff       	call   801bac <syscall>
  8020c8:	83 c4 18             	add    $0x18,%esp
	return ;
  8020cb:	90                   	nop
}
  8020cc:	c9                   	leave  
  8020cd:	c3                   	ret    

008020ce <gettst>:
uint32 gettst()
{
  8020ce:	55                   	push   %ebp
  8020cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 00                	push   $0x0
  8020db:	6a 2b                	push   $0x2b
  8020dd:	e8 ca fa ff ff       	call   801bac <syscall>
  8020e2:	83 c4 18             	add    $0x18,%esp
}
  8020e5:	c9                   	leave  
  8020e6:	c3                   	ret    

008020e7 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8020e7:	55                   	push   %ebp
  8020e8:	89 e5                	mov    %esp,%ebp
  8020ea:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 00                	push   $0x0
  8020f3:	6a 00                	push   $0x0
  8020f5:	6a 00                	push   $0x0
  8020f7:	6a 2c                	push   $0x2c
  8020f9:	e8 ae fa ff ff       	call   801bac <syscall>
  8020fe:	83 c4 18             	add    $0x18,%esp
  802101:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802104:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802108:	75 07                	jne    802111 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80210a:	b8 01 00 00 00       	mov    $0x1,%eax
  80210f:	eb 05                	jmp    802116 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802111:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802116:	c9                   	leave  
  802117:	c3                   	ret    

00802118 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802118:	55                   	push   %ebp
  802119:	89 e5                	mov    %esp,%ebp
  80211b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80211e:	6a 00                	push   $0x0
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	6a 00                	push   $0x0
  802126:	6a 00                	push   $0x0
  802128:	6a 2c                	push   $0x2c
  80212a:	e8 7d fa ff ff       	call   801bac <syscall>
  80212f:	83 c4 18             	add    $0x18,%esp
  802132:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802135:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802139:	75 07                	jne    802142 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80213b:	b8 01 00 00 00       	mov    $0x1,%eax
  802140:	eb 05                	jmp    802147 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802142:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802147:	c9                   	leave  
  802148:	c3                   	ret    

00802149 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802149:	55                   	push   %ebp
  80214a:	89 e5                	mov    %esp,%ebp
  80214c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80214f:	6a 00                	push   $0x0
  802151:	6a 00                	push   $0x0
  802153:	6a 00                	push   $0x0
  802155:	6a 00                	push   $0x0
  802157:	6a 00                	push   $0x0
  802159:	6a 2c                	push   $0x2c
  80215b:	e8 4c fa ff ff       	call   801bac <syscall>
  802160:	83 c4 18             	add    $0x18,%esp
  802163:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802166:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80216a:	75 07                	jne    802173 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80216c:	b8 01 00 00 00       	mov    $0x1,%eax
  802171:	eb 05                	jmp    802178 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802173:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802178:	c9                   	leave  
  802179:	c3                   	ret    

0080217a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80217a:	55                   	push   %ebp
  80217b:	89 e5                	mov    %esp,%ebp
  80217d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	6a 00                	push   $0x0
  802186:	6a 00                	push   $0x0
  802188:	6a 00                	push   $0x0
  80218a:	6a 2c                	push   $0x2c
  80218c:	e8 1b fa ff ff       	call   801bac <syscall>
  802191:	83 c4 18             	add    $0x18,%esp
  802194:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802197:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80219b:	75 07                	jne    8021a4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80219d:	b8 01 00 00 00       	mov    $0x1,%eax
  8021a2:	eb 05                	jmp    8021a9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8021a4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021a9:	c9                   	leave  
  8021aa:	c3                   	ret    

008021ab <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8021ab:	55                   	push   %ebp
  8021ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021ae:	6a 00                	push   $0x0
  8021b0:	6a 00                	push   $0x0
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	ff 75 08             	pushl  0x8(%ebp)
  8021b9:	6a 2d                	push   $0x2d
  8021bb:	e8 ec f9 ff ff       	call   801bac <syscall>
  8021c0:	83 c4 18             	add    $0x18,%esp
	return ;
  8021c3:	90                   	nop
}
  8021c4:	c9                   	leave  
  8021c5:	c3                   	ret    
  8021c6:	66 90                	xchg   %ax,%ax

008021c8 <__udivdi3>:
  8021c8:	55                   	push   %ebp
  8021c9:	57                   	push   %edi
  8021ca:	56                   	push   %esi
  8021cb:	53                   	push   %ebx
  8021cc:	83 ec 1c             	sub    $0x1c,%esp
  8021cf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021d3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021db:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021df:	89 ca                	mov    %ecx,%edx
  8021e1:	89 f8                	mov    %edi,%eax
  8021e3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021e7:	85 f6                	test   %esi,%esi
  8021e9:	75 2d                	jne    802218 <__udivdi3+0x50>
  8021eb:	39 cf                	cmp    %ecx,%edi
  8021ed:	77 65                	ja     802254 <__udivdi3+0x8c>
  8021ef:	89 fd                	mov    %edi,%ebp
  8021f1:	85 ff                	test   %edi,%edi
  8021f3:	75 0b                	jne    802200 <__udivdi3+0x38>
  8021f5:	b8 01 00 00 00       	mov    $0x1,%eax
  8021fa:	31 d2                	xor    %edx,%edx
  8021fc:	f7 f7                	div    %edi
  8021fe:	89 c5                	mov    %eax,%ebp
  802200:	31 d2                	xor    %edx,%edx
  802202:	89 c8                	mov    %ecx,%eax
  802204:	f7 f5                	div    %ebp
  802206:	89 c1                	mov    %eax,%ecx
  802208:	89 d8                	mov    %ebx,%eax
  80220a:	f7 f5                	div    %ebp
  80220c:	89 cf                	mov    %ecx,%edi
  80220e:	89 fa                	mov    %edi,%edx
  802210:	83 c4 1c             	add    $0x1c,%esp
  802213:	5b                   	pop    %ebx
  802214:	5e                   	pop    %esi
  802215:	5f                   	pop    %edi
  802216:	5d                   	pop    %ebp
  802217:	c3                   	ret    
  802218:	39 ce                	cmp    %ecx,%esi
  80221a:	77 28                	ja     802244 <__udivdi3+0x7c>
  80221c:	0f bd fe             	bsr    %esi,%edi
  80221f:	83 f7 1f             	xor    $0x1f,%edi
  802222:	75 40                	jne    802264 <__udivdi3+0x9c>
  802224:	39 ce                	cmp    %ecx,%esi
  802226:	72 0a                	jb     802232 <__udivdi3+0x6a>
  802228:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80222c:	0f 87 9e 00 00 00    	ja     8022d0 <__udivdi3+0x108>
  802232:	b8 01 00 00 00       	mov    $0x1,%eax
  802237:	89 fa                	mov    %edi,%edx
  802239:	83 c4 1c             	add    $0x1c,%esp
  80223c:	5b                   	pop    %ebx
  80223d:	5e                   	pop    %esi
  80223e:	5f                   	pop    %edi
  80223f:	5d                   	pop    %ebp
  802240:	c3                   	ret    
  802241:	8d 76 00             	lea    0x0(%esi),%esi
  802244:	31 ff                	xor    %edi,%edi
  802246:	31 c0                	xor    %eax,%eax
  802248:	89 fa                	mov    %edi,%edx
  80224a:	83 c4 1c             	add    $0x1c,%esp
  80224d:	5b                   	pop    %ebx
  80224e:	5e                   	pop    %esi
  80224f:	5f                   	pop    %edi
  802250:	5d                   	pop    %ebp
  802251:	c3                   	ret    
  802252:	66 90                	xchg   %ax,%ax
  802254:	89 d8                	mov    %ebx,%eax
  802256:	f7 f7                	div    %edi
  802258:	31 ff                	xor    %edi,%edi
  80225a:	89 fa                	mov    %edi,%edx
  80225c:	83 c4 1c             	add    $0x1c,%esp
  80225f:	5b                   	pop    %ebx
  802260:	5e                   	pop    %esi
  802261:	5f                   	pop    %edi
  802262:	5d                   	pop    %ebp
  802263:	c3                   	ret    
  802264:	bd 20 00 00 00       	mov    $0x20,%ebp
  802269:	89 eb                	mov    %ebp,%ebx
  80226b:	29 fb                	sub    %edi,%ebx
  80226d:	89 f9                	mov    %edi,%ecx
  80226f:	d3 e6                	shl    %cl,%esi
  802271:	89 c5                	mov    %eax,%ebp
  802273:	88 d9                	mov    %bl,%cl
  802275:	d3 ed                	shr    %cl,%ebp
  802277:	89 e9                	mov    %ebp,%ecx
  802279:	09 f1                	or     %esi,%ecx
  80227b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80227f:	89 f9                	mov    %edi,%ecx
  802281:	d3 e0                	shl    %cl,%eax
  802283:	89 c5                	mov    %eax,%ebp
  802285:	89 d6                	mov    %edx,%esi
  802287:	88 d9                	mov    %bl,%cl
  802289:	d3 ee                	shr    %cl,%esi
  80228b:	89 f9                	mov    %edi,%ecx
  80228d:	d3 e2                	shl    %cl,%edx
  80228f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802293:	88 d9                	mov    %bl,%cl
  802295:	d3 e8                	shr    %cl,%eax
  802297:	09 c2                	or     %eax,%edx
  802299:	89 d0                	mov    %edx,%eax
  80229b:	89 f2                	mov    %esi,%edx
  80229d:	f7 74 24 0c          	divl   0xc(%esp)
  8022a1:	89 d6                	mov    %edx,%esi
  8022a3:	89 c3                	mov    %eax,%ebx
  8022a5:	f7 e5                	mul    %ebp
  8022a7:	39 d6                	cmp    %edx,%esi
  8022a9:	72 19                	jb     8022c4 <__udivdi3+0xfc>
  8022ab:	74 0b                	je     8022b8 <__udivdi3+0xf0>
  8022ad:	89 d8                	mov    %ebx,%eax
  8022af:	31 ff                	xor    %edi,%edi
  8022b1:	e9 58 ff ff ff       	jmp    80220e <__udivdi3+0x46>
  8022b6:	66 90                	xchg   %ax,%ax
  8022b8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022bc:	89 f9                	mov    %edi,%ecx
  8022be:	d3 e2                	shl    %cl,%edx
  8022c0:	39 c2                	cmp    %eax,%edx
  8022c2:	73 e9                	jae    8022ad <__udivdi3+0xe5>
  8022c4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022c7:	31 ff                	xor    %edi,%edi
  8022c9:	e9 40 ff ff ff       	jmp    80220e <__udivdi3+0x46>
  8022ce:	66 90                	xchg   %ax,%ax
  8022d0:	31 c0                	xor    %eax,%eax
  8022d2:	e9 37 ff ff ff       	jmp    80220e <__udivdi3+0x46>
  8022d7:	90                   	nop

008022d8 <__umoddi3>:
  8022d8:	55                   	push   %ebp
  8022d9:	57                   	push   %edi
  8022da:	56                   	push   %esi
  8022db:	53                   	push   %ebx
  8022dc:	83 ec 1c             	sub    $0x1c,%esp
  8022df:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022e3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022e7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022eb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022ef:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022f3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022f7:	89 f3                	mov    %esi,%ebx
  8022f9:	89 fa                	mov    %edi,%edx
  8022fb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022ff:	89 34 24             	mov    %esi,(%esp)
  802302:	85 c0                	test   %eax,%eax
  802304:	75 1a                	jne    802320 <__umoddi3+0x48>
  802306:	39 f7                	cmp    %esi,%edi
  802308:	0f 86 a2 00 00 00    	jbe    8023b0 <__umoddi3+0xd8>
  80230e:	89 c8                	mov    %ecx,%eax
  802310:	89 f2                	mov    %esi,%edx
  802312:	f7 f7                	div    %edi
  802314:	89 d0                	mov    %edx,%eax
  802316:	31 d2                	xor    %edx,%edx
  802318:	83 c4 1c             	add    $0x1c,%esp
  80231b:	5b                   	pop    %ebx
  80231c:	5e                   	pop    %esi
  80231d:	5f                   	pop    %edi
  80231e:	5d                   	pop    %ebp
  80231f:	c3                   	ret    
  802320:	39 f0                	cmp    %esi,%eax
  802322:	0f 87 ac 00 00 00    	ja     8023d4 <__umoddi3+0xfc>
  802328:	0f bd e8             	bsr    %eax,%ebp
  80232b:	83 f5 1f             	xor    $0x1f,%ebp
  80232e:	0f 84 ac 00 00 00    	je     8023e0 <__umoddi3+0x108>
  802334:	bf 20 00 00 00       	mov    $0x20,%edi
  802339:	29 ef                	sub    %ebp,%edi
  80233b:	89 fe                	mov    %edi,%esi
  80233d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802341:	89 e9                	mov    %ebp,%ecx
  802343:	d3 e0                	shl    %cl,%eax
  802345:	89 d7                	mov    %edx,%edi
  802347:	89 f1                	mov    %esi,%ecx
  802349:	d3 ef                	shr    %cl,%edi
  80234b:	09 c7                	or     %eax,%edi
  80234d:	89 e9                	mov    %ebp,%ecx
  80234f:	d3 e2                	shl    %cl,%edx
  802351:	89 14 24             	mov    %edx,(%esp)
  802354:	89 d8                	mov    %ebx,%eax
  802356:	d3 e0                	shl    %cl,%eax
  802358:	89 c2                	mov    %eax,%edx
  80235a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80235e:	d3 e0                	shl    %cl,%eax
  802360:	89 44 24 04          	mov    %eax,0x4(%esp)
  802364:	8b 44 24 08          	mov    0x8(%esp),%eax
  802368:	89 f1                	mov    %esi,%ecx
  80236a:	d3 e8                	shr    %cl,%eax
  80236c:	09 d0                	or     %edx,%eax
  80236e:	d3 eb                	shr    %cl,%ebx
  802370:	89 da                	mov    %ebx,%edx
  802372:	f7 f7                	div    %edi
  802374:	89 d3                	mov    %edx,%ebx
  802376:	f7 24 24             	mull   (%esp)
  802379:	89 c6                	mov    %eax,%esi
  80237b:	89 d1                	mov    %edx,%ecx
  80237d:	39 d3                	cmp    %edx,%ebx
  80237f:	0f 82 87 00 00 00    	jb     80240c <__umoddi3+0x134>
  802385:	0f 84 91 00 00 00    	je     80241c <__umoddi3+0x144>
  80238b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80238f:	29 f2                	sub    %esi,%edx
  802391:	19 cb                	sbb    %ecx,%ebx
  802393:	89 d8                	mov    %ebx,%eax
  802395:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802399:	d3 e0                	shl    %cl,%eax
  80239b:	89 e9                	mov    %ebp,%ecx
  80239d:	d3 ea                	shr    %cl,%edx
  80239f:	09 d0                	or     %edx,%eax
  8023a1:	89 e9                	mov    %ebp,%ecx
  8023a3:	d3 eb                	shr    %cl,%ebx
  8023a5:	89 da                	mov    %ebx,%edx
  8023a7:	83 c4 1c             	add    $0x1c,%esp
  8023aa:	5b                   	pop    %ebx
  8023ab:	5e                   	pop    %esi
  8023ac:	5f                   	pop    %edi
  8023ad:	5d                   	pop    %ebp
  8023ae:	c3                   	ret    
  8023af:	90                   	nop
  8023b0:	89 fd                	mov    %edi,%ebp
  8023b2:	85 ff                	test   %edi,%edi
  8023b4:	75 0b                	jne    8023c1 <__umoddi3+0xe9>
  8023b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8023bb:	31 d2                	xor    %edx,%edx
  8023bd:	f7 f7                	div    %edi
  8023bf:	89 c5                	mov    %eax,%ebp
  8023c1:	89 f0                	mov    %esi,%eax
  8023c3:	31 d2                	xor    %edx,%edx
  8023c5:	f7 f5                	div    %ebp
  8023c7:	89 c8                	mov    %ecx,%eax
  8023c9:	f7 f5                	div    %ebp
  8023cb:	89 d0                	mov    %edx,%eax
  8023cd:	e9 44 ff ff ff       	jmp    802316 <__umoddi3+0x3e>
  8023d2:	66 90                	xchg   %ax,%ax
  8023d4:	89 c8                	mov    %ecx,%eax
  8023d6:	89 f2                	mov    %esi,%edx
  8023d8:	83 c4 1c             	add    $0x1c,%esp
  8023db:	5b                   	pop    %ebx
  8023dc:	5e                   	pop    %esi
  8023dd:	5f                   	pop    %edi
  8023de:	5d                   	pop    %ebp
  8023df:	c3                   	ret    
  8023e0:	3b 04 24             	cmp    (%esp),%eax
  8023e3:	72 06                	jb     8023eb <__umoddi3+0x113>
  8023e5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023e9:	77 0f                	ja     8023fa <__umoddi3+0x122>
  8023eb:	89 f2                	mov    %esi,%edx
  8023ed:	29 f9                	sub    %edi,%ecx
  8023ef:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023f3:	89 14 24             	mov    %edx,(%esp)
  8023f6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023fa:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023fe:	8b 14 24             	mov    (%esp),%edx
  802401:	83 c4 1c             	add    $0x1c,%esp
  802404:	5b                   	pop    %ebx
  802405:	5e                   	pop    %esi
  802406:	5f                   	pop    %edi
  802407:	5d                   	pop    %ebp
  802408:	c3                   	ret    
  802409:	8d 76 00             	lea    0x0(%esi),%esi
  80240c:	2b 04 24             	sub    (%esp),%eax
  80240f:	19 fa                	sbb    %edi,%edx
  802411:	89 d1                	mov    %edx,%ecx
  802413:	89 c6                	mov    %eax,%esi
  802415:	e9 71 ff ff ff       	jmp    80238b <__umoddi3+0xb3>
  80241a:	66 90                	xchg   %ax,%ax
  80241c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802420:	72 ea                	jb     80240c <__umoddi3+0x134>
  802422:	89 d9                	mov    %ebx,%ecx
  802424:	e9 62 ff ff ff       	jmp    80238b <__umoddi3+0xb3>
