
obj/user/quicksort_semaphore:     file format elf32-i386


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
  800031:	e8 72 06 00 00       	call   8006a8 <libmain>
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
	int envID = sys_getenvid();
  800042:	e8 bf 1c 00 00       	call   801d06 <sys_getenvid>
  800047:	89 45 f0             	mov    %eax,-0x10(%ebp)
	char Chose ;
	char Line[255] ;
	int Iteration = 0 ;
  80004a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	sys_createSemaphore("IO.CS", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 00 25 80 00       	push   $0x802500
  80005b:	e8 ce 1e 00 00       	call   801f2e <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 82 1d 00 00       	call   801dea <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 94 1d 00 00       	call   801e03 <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 ec             	mov    %eax,-0x14(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();

		sys_waitSemaphore(envID, "IO.CS");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 00 25 80 00       	push   $0x802500
  80007f:	ff 75 f0             	pushl  -0x10(%ebp)
  800082:	e8 e0 1e 00 00       	call   801f67 <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
			readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 dd fe ff ff    	lea    -0x123(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 08 25 80 00       	push   $0x802508
  800099:	e8 42 10 00 00       	call   8010e0 <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 dd fe ff ff    	lea    -0x123(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 92 15 00 00       	call   801646 <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e8             	mov    %eax,-0x18(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 5f 19 00 00       	call   801a28 <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 28 25 80 00       	push   $0x802528
  8000d7:	e8 82 09 00 00       	call   800a5e <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 4b 25 80 00       	push   $0x80254b
  8000e7:	e8 72 09 00 00       	call   800a5e <cprintf>
  8000ec:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000ef:	83 ec 0c             	sub    $0xc,%esp
  8000f2:	68 59 25 80 00       	push   $0x802559
  8000f7:	e8 62 09 00 00       	call   800a5e <cprintf>
  8000fc:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\nSelect: ") ;
  8000ff:	83 ec 0c             	sub    $0xc,%esp
  800102:	68 68 25 80 00       	push   $0x802568
  800107:	e8 52 09 00 00       	call   800a5e <cprintf>
  80010c:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80010f:	e8 3c 05 00 00       	call   800650 <getchar>
  800114:	88 45 e3             	mov    %al,-0x1d(%ebp)
			cputchar(Chose);
  800117:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	50                   	push   %eax
  80011f:	e8 e4 04 00 00       	call   800608 <cputchar>
  800124:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800127:	83 ec 0c             	sub    $0xc,%esp
  80012a:	6a 0a                	push   $0xa
  80012c:	e8 d7 04 00 00       	call   800608 <cputchar>
  800131:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID, "IO.CS");
  800134:	83 ec 08             	sub    $0x8,%esp
  800137:	68 00 25 80 00       	push   $0x802500
  80013c:	ff 75 f0             	pushl  -0x10(%ebp)
  80013f:	e8 41 1e 00 00       	call   801f85 <sys_signalSemaphore>
  800144:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800147:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  80014b:	83 f8 62             	cmp    $0x62,%eax
  80014e:	74 1d                	je     80016d <_main+0x135>
  800150:	83 f8 63             	cmp    $0x63,%eax
  800153:	74 2b                	je     800180 <_main+0x148>
  800155:	83 f8 61             	cmp    $0x61,%eax
  800158:	75 39                	jne    800193 <_main+0x15b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80015a:	83 ec 08             	sub    $0x8,%esp
  80015d:	ff 75 e8             	pushl  -0x18(%ebp)
  800160:	ff 75 e4             	pushl  -0x1c(%ebp)
  800163:	e8 3a 03 00 00       	call   8004a2 <InitializeAscending>
  800168:	83 c4 10             	add    $0x10,%esp
			break ;
  80016b:	eb 37                	jmp    8001a4 <_main+0x16c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80016d:	83 ec 08             	sub    $0x8,%esp
  800170:	ff 75 e8             	pushl  -0x18(%ebp)
  800173:	ff 75 e4             	pushl  -0x1c(%ebp)
  800176:	e8 58 03 00 00       	call   8004d3 <InitializeDescending>
  80017b:	83 c4 10             	add    $0x10,%esp
			break ;
  80017e:	eb 24                	jmp    8001a4 <_main+0x16c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800180:	83 ec 08             	sub    $0x8,%esp
  800183:	ff 75 e8             	pushl  -0x18(%ebp)
  800186:	ff 75 e4             	pushl  -0x1c(%ebp)
  800189:	e8 7a 03 00 00       	call   800508 <InitializeSemiRandom>
  80018e:	83 c4 10             	add    $0x10,%esp
			break ;
  800191:	eb 11                	jmp    8001a4 <_main+0x16c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800193:	83 ec 08             	sub    $0x8,%esp
  800196:	ff 75 e8             	pushl  -0x18(%ebp)
  800199:	ff 75 e4             	pushl  -0x1c(%ebp)
  80019c:	e8 67 03 00 00       	call   800508 <InitializeSemiRandom>
  8001a1:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001a4:	83 ec 08             	sub    $0x8,%esp
  8001a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001aa:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001ad:	e8 35 01 00 00       	call   8002e7 <QuickSort>
  8001b2:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001b5:	83 ec 08             	sub    $0x8,%esp
  8001b8:	ff 75 e8             	pushl  -0x18(%ebp)
  8001bb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001be:	e8 35 02 00 00       	call   8003f8 <CheckSorted>
  8001c3:	83 c4 10             	add    $0x10,%esp
  8001c6:	89 45 dc             	mov    %eax,-0x24(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001c9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001cd:	75 14                	jne    8001e3 <_main+0x1ab>
  8001cf:	83 ec 04             	sub    $0x4,%esp
  8001d2:	68 80 25 80 00       	push   $0x802580
  8001d7:	6a 45                	push   $0x45
  8001d9:	68 a2 25 80 00       	push   $0x8025a2
  8001de:	e8 c7 05 00 00       	call   8007aa <_panic>
		else
		{
			sys_waitSemaphore(envID, "IO.CS");
  8001e3:	83 ec 08             	sub    $0x8,%esp
  8001e6:	68 00 25 80 00       	push   $0x802500
  8001eb:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ee:	e8 74 1d 00 00       	call   801f67 <sys_waitSemaphore>
  8001f3:	83 c4 10             	add    $0x10,%esp
				cprintf("\n===============================================\n") ;
  8001f6:	83 ec 0c             	sub    $0xc,%esp
  8001f9:	68 c0 25 80 00       	push   $0x8025c0
  8001fe:	e8 5b 08 00 00       	call   800a5e <cprintf>
  800203:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  800206:	83 ec 0c             	sub    $0xc,%esp
  800209:	68 f4 25 80 00       	push   $0x8025f4
  80020e:	e8 4b 08 00 00       	call   800a5e <cprintf>
  800213:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  800216:	83 ec 0c             	sub    $0xc,%esp
  800219:	68 28 26 80 00       	push   $0x802628
  80021e:	e8 3b 08 00 00       	call   800a5e <cprintf>
  800223:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "IO.CS");
  800226:	83 ec 08             	sub    $0x8,%esp
  800229:	68 00 25 80 00       	push   $0x802500
  80022e:	ff 75 f0             	pushl  -0x10(%ebp)
  800231:	e8 4f 1d 00 00       	call   801f85 <sys_signalSemaphore>
  800236:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_waitSemaphore(envID, "IO.CS");
  800239:	83 ec 08             	sub    $0x8,%esp
  80023c:	68 00 25 80 00       	push   $0x802500
  800241:	ff 75 f0             	pushl  -0x10(%ebp)
  800244:	e8 1e 1d 00 00       	call   801f67 <sys_waitSemaphore>
  800249:	83 c4 10             	add    $0x10,%esp
			cprintf("Freeing the Heap...\n\n") ;
  80024c:	83 ec 0c             	sub    $0xc,%esp
  80024f:	68 5a 26 80 00       	push   $0x80265a
  800254:	e8 05 08 00 00       	call   800a5e <cprintf>
  800259:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID, "IO.CS");
  80025c:	83 ec 08             	sub    $0x8,%esp
  80025f:	68 00 25 80 00       	push   $0x802500
  800264:	ff 75 f0             	pushl  -0x10(%ebp)
  800267:	e8 19 1d 00 00       	call   801f85 <sys_signalSemaphore>
  80026c:	83 c4 10             	add    $0x10,%esp

		//freeHeap() ;

		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "IO.CS");
  80026f:	83 ec 08             	sub    $0x8,%esp
  800272:	68 00 25 80 00       	push   $0x802500
  800277:	ff 75 f0             	pushl  -0x10(%ebp)
  80027a:	e8 e8 1c 00 00       	call   801f67 <sys_waitSemaphore>
  80027f:	83 c4 10             	add    $0x10,%esp
			cprintf("Do you want to repeat (y/n): ") ;
  800282:	83 ec 0c             	sub    $0xc,%esp
  800285:	68 70 26 80 00       	push   $0x802670
  80028a:	e8 cf 07 00 00       	call   800a5e <cprintf>
  80028f:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800292:	e8 b9 03 00 00       	call   800650 <getchar>
  800297:	88 45 e3             	mov    %al,-0x1d(%ebp)
			cputchar(Chose);
  80029a:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  80029e:	83 ec 0c             	sub    $0xc,%esp
  8002a1:	50                   	push   %eax
  8002a2:	e8 61 03 00 00       	call   800608 <cputchar>
  8002a7:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002aa:	83 ec 0c             	sub    $0xc,%esp
  8002ad:	6a 0a                	push   $0xa
  8002af:	e8 54 03 00 00       	call   800608 <cputchar>
  8002b4:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002b7:	83 ec 0c             	sub    $0xc,%esp
  8002ba:	6a 0a                	push   $0xa
  8002bc:	e8 47 03 00 00       	call   800608 <cputchar>
  8002c1:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_signalSemaphore(envID, "IO.CS");
  8002c4:	83 ec 08             	sub    $0x8,%esp
  8002c7:	68 00 25 80 00       	push   $0x802500
  8002cc:	ff 75 f0             	pushl  -0x10(%ebp)
  8002cf:	e8 b1 1c 00 00       	call   801f85 <sys_signalSemaphore>
  8002d4:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  8002d7:	80 7d e3 79          	cmpb   $0x79,-0x1d(%ebp)
  8002db:	0f 84 82 fd ff ff    	je     800063 <_main+0x2b>

}
  8002e1:	90                   	nop
  8002e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8002e5:	c9                   	leave  
  8002e6:	c3                   	ret    

008002e7 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002e7:	55                   	push   %ebp
  8002e8:	89 e5                	mov    %esp,%ebp
  8002ea:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f0:	48                   	dec    %eax
  8002f1:	50                   	push   %eax
  8002f2:	6a 00                	push   $0x0
  8002f4:	ff 75 0c             	pushl  0xc(%ebp)
  8002f7:	ff 75 08             	pushl  0x8(%ebp)
  8002fa:	e8 06 00 00 00       	call   800305 <QSort>
  8002ff:	83 c4 10             	add    $0x10,%esp
}
  800302:	90                   	nop
  800303:	c9                   	leave  
  800304:	c3                   	ret    

00800305 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800305:	55                   	push   %ebp
  800306:	89 e5                	mov    %esp,%ebp
  800308:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80030b:	8b 45 10             	mov    0x10(%ebp),%eax
  80030e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800311:	0f 8d de 00 00 00    	jge    8003f5 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800317:	8b 45 10             	mov    0x10(%ebp),%eax
  80031a:	40                   	inc    %eax
  80031b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80031e:	8b 45 14             	mov    0x14(%ebp),%eax
  800321:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800324:	e9 80 00 00 00       	jmp    8003a9 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800329:	ff 45 f4             	incl   -0xc(%ebp)
  80032c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80032f:	3b 45 14             	cmp    0x14(%ebp),%eax
  800332:	7f 2b                	jg     80035f <QSort+0x5a>
  800334:	8b 45 10             	mov    0x10(%ebp),%eax
  800337:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033e:	8b 45 08             	mov    0x8(%ebp),%eax
  800341:	01 d0                	add    %edx,%eax
  800343:	8b 10                	mov    (%eax),%edx
  800345:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800348:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034f:	8b 45 08             	mov    0x8(%ebp),%eax
  800352:	01 c8                	add    %ecx,%eax
  800354:	8b 00                	mov    (%eax),%eax
  800356:	39 c2                	cmp    %eax,%edx
  800358:	7d cf                	jge    800329 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  80035a:	eb 03                	jmp    80035f <QSort+0x5a>
  80035c:	ff 4d f0             	decl   -0x10(%ebp)
  80035f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800362:	3b 45 10             	cmp    0x10(%ebp),%eax
  800365:	7e 26                	jle    80038d <QSort+0x88>
  800367:	8b 45 10             	mov    0x10(%ebp),%eax
  80036a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800371:	8b 45 08             	mov    0x8(%ebp),%eax
  800374:	01 d0                	add    %edx,%eax
  800376:	8b 10                	mov    (%eax),%edx
  800378:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80037b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800382:	8b 45 08             	mov    0x8(%ebp),%eax
  800385:	01 c8                	add    %ecx,%eax
  800387:	8b 00                	mov    (%eax),%eax
  800389:	39 c2                	cmp    %eax,%edx
  80038b:	7e cf                	jle    80035c <QSort+0x57>

		if (i <= j)
  80038d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800390:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800393:	7f 14                	jg     8003a9 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800395:	83 ec 04             	sub    $0x4,%esp
  800398:	ff 75 f0             	pushl  -0x10(%ebp)
  80039b:	ff 75 f4             	pushl  -0xc(%ebp)
  80039e:	ff 75 08             	pushl  0x8(%ebp)
  8003a1:	e8 a9 00 00 00       	call   80044f <Swap>
  8003a6:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8003a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ac:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003af:	0f 8e 77 ff ff ff    	jle    80032c <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  8003b5:	83 ec 04             	sub    $0x4,%esp
  8003b8:	ff 75 f0             	pushl  -0x10(%ebp)
  8003bb:	ff 75 10             	pushl  0x10(%ebp)
  8003be:	ff 75 08             	pushl  0x8(%ebp)
  8003c1:	e8 89 00 00 00       	call   80044f <Swap>
  8003c6:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003cc:	48                   	dec    %eax
  8003cd:	50                   	push   %eax
  8003ce:	ff 75 10             	pushl  0x10(%ebp)
  8003d1:	ff 75 0c             	pushl  0xc(%ebp)
  8003d4:	ff 75 08             	pushl  0x8(%ebp)
  8003d7:	e8 29 ff ff ff       	call   800305 <QSort>
  8003dc:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003df:	ff 75 14             	pushl  0x14(%ebp)
  8003e2:	ff 75 f4             	pushl  -0xc(%ebp)
  8003e5:	ff 75 0c             	pushl  0xc(%ebp)
  8003e8:	ff 75 08             	pushl  0x8(%ebp)
  8003eb:	e8 15 ff ff ff       	call   800305 <QSort>
  8003f0:	83 c4 10             	add    $0x10,%esp
  8003f3:	eb 01                	jmp    8003f6 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003f5:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  8003f6:	c9                   	leave  
  8003f7:	c3                   	ret    

008003f8 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003f8:	55                   	push   %ebp
  8003f9:	89 e5                	mov    %esp,%ebp
  8003fb:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003fe:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800405:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80040c:	eb 33                	jmp    800441 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80040e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800411:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800418:	8b 45 08             	mov    0x8(%ebp),%eax
  80041b:	01 d0                	add    %edx,%eax
  80041d:	8b 10                	mov    (%eax),%edx
  80041f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800422:	40                   	inc    %eax
  800423:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80042a:	8b 45 08             	mov    0x8(%ebp),%eax
  80042d:	01 c8                	add    %ecx,%eax
  80042f:	8b 00                	mov    (%eax),%eax
  800431:	39 c2                	cmp    %eax,%edx
  800433:	7e 09                	jle    80043e <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800435:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80043c:	eb 0c                	jmp    80044a <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80043e:	ff 45 f8             	incl   -0x8(%ebp)
  800441:	8b 45 0c             	mov    0xc(%ebp),%eax
  800444:	48                   	dec    %eax
  800445:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800448:	7f c4                	jg     80040e <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80044a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80044d:	c9                   	leave  
  80044e:	c3                   	ret    

0080044f <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80044f:	55                   	push   %ebp
  800450:	89 e5                	mov    %esp,%ebp
  800452:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800455:	8b 45 0c             	mov    0xc(%ebp),%eax
  800458:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	01 d0                	add    %edx,%eax
  800464:	8b 00                	mov    (%eax),%eax
  800466:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800469:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	01 c2                	add    %eax,%edx
  800478:	8b 45 10             	mov    0x10(%ebp),%eax
  80047b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800482:	8b 45 08             	mov    0x8(%ebp),%eax
  800485:	01 c8                	add    %ecx,%eax
  800487:	8b 00                	mov    (%eax),%eax
  800489:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80048b:	8b 45 10             	mov    0x10(%ebp),%eax
  80048e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800495:	8b 45 08             	mov    0x8(%ebp),%eax
  800498:	01 c2                	add    %eax,%edx
  80049a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049d:	89 02                	mov    %eax,(%edx)
}
  80049f:	90                   	nop
  8004a0:	c9                   	leave  
  8004a1:	c3                   	ret    

008004a2 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8004a2:	55                   	push   %ebp
  8004a3:	89 e5                	mov    %esp,%ebp
  8004a5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004af:	eb 17                	jmp    8004c8 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8004b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004be:	01 c2                	add    %eax,%edx
  8004c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c3:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004c5:	ff 45 fc             	incl   -0x4(%ebp)
  8004c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004cb:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004ce:	7c e1                	jl     8004b1 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8004d0:	90                   	nop
  8004d1:	c9                   	leave  
  8004d2:	c3                   	ret    

008004d3 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8004d3:	55                   	push   %ebp
  8004d4:	89 e5                	mov    %esp,%ebp
  8004d6:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004e0:	eb 1b                	jmp    8004fd <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ef:	01 c2                	add    %eax,%edx
  8004f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f4:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004f7:	48                   	dec    %eax
  8004f8:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004fa:	ff 45 fc             	incl   -0x4(%ebp)
  8004fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800500:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800503:	7c dd                	jl     8004e2 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800505:	90                   	nop
  800506:	c9                   	leave  
  800507:	c3                   	ret    

00800508 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800508:	55                   	push   %ebp
  800509:	89 e5                	mov    %esp,%ebp
  80050b:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80050e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800511:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800516:	f7 e9                	imul   %ecx
  800518:	c1 f9 1f             	sar    $0x1f,%ecx
  80051b:	89 d0                	mov    %edx,%eax
  80051d:	29 c8                	sub    %ecx,%eax
  80051f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800522:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800529:	eb 1e                	jmp    800549 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80052b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80052e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800535:	8b 45 08             	mov    0x8(%ebp),%eax
  800538:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80053b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80053e:	99                   	cltd   
  80053f:	f7 7d f8             	idivl  -0x8(%ebp)
  800542:	89 d0                	mov    %edx,%eax
  800544:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800546:	ff 45 fc             	incl   -0x4(%ebp)
  800549:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80054c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80054f:	7c da                	jl     80052b <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  800551:	90                   	nop
  800552:	c9                   	leave  
  800553:	c3                   	ret    

00800554 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800554:	55                   	push   %ebp
  800555:	89 e5                	mov    %esp,%ebp
  800557:	83 ec 18             	sub    $0x18,%esp
	int envID = sys_getenvid();
  80055a:	e8 a7 17 00 00       	call   801d06 <sys_getenvid>
  80055f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_waitSemaphore(envID, "IO.CS");
  800562:	83 ec 08             	sub    $0x8,%esp
  800565:	68 00 25 80 00       	push   $0x802500
  80056a:	ff 75 f0             	pushl  -0x10(%ebp)
  80056d:	e8 f5 19 00 00       	call   801f67 <sys_waitSemaphore>
  800572:	83 c4 10             	add    $0x10,%esp
		int i ;
		int NumsPerLine = 20 ;
  800575:	c7 45 ec 14 00 00 00 	movl   $0x14,-0x14(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  80057c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800583:	eb 42                	jmp    8005c7 <PrintElements+0x73>
		{
			if (i%NumsPerLine == 0)
  800585:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800588:	99                   	cltd   
  800589:	f7 7d ec             	idivl  -0x14(%ebp)
  80058c:	89 d0                	mov    %edx,%eax
  80058e:	85 c0                	test   %eax,%eax
  800590:	75 10                	jne    8005a2 <PrintElements+0x4e>
				cprintf("\n");
  800592:	83 ec 0c             	sub    $0xc,%esp
  800595:	68 8e 26 80 00       	push   $0x80268e
  80059a:	e8 bf 04 00 00       	call   800a5e <cprintf>
  80059f:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  8005a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8005af:	01 d0                	add    %edx,%eax
  8005b1:	8b 00                	mov    (%eax),%eax
  8005b3:	83 ec 08             	sub    $0x8,%esp
  8005b6:	50                   	push   %eax
  8005b7:	68 90 26 80 00       	push   $0x802690
  8005bc:	e8 9d 04 00 00       	call   800a5e <cprintf>
  8005c1:	83 c4 10             	add    $0x10,%esp
{
	int envID = sys_getenvid();
	sys_waitSemaphore(envID, "IO.CS");
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8005c4:	ff 45 f4             	incl   -0xc(%ebp)
  8005c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ca:	48                   	dec    %eax
  8005cb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8005ce:	7f b5                	jg     800585 <PrintElements+0x31>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  8005d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005d3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005da:	8b 45 08             	mov    0x8(%ebp),%eax
  8005dd:	01 d0                	add    %edx,%eax
  8005df:	8b 00                	mov    (%eax),%eax
  8005e1:	83 ec 08             	sub    $0x8,%esp
  8005e4:	50                   	push   %eax
  8005e5:	68 95 26 80 00       	push   $0x802695
  8005ea:	e8 6f 04 00 00       	call   800a5e <cprintf>
  8005ef:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(envID, "IO.CS");
  8005f2:	83 ec 08             	sub    $0x8,%esp
  8005f5:	68 00 25 80 00       	push   $0x802500
  8005fa:	ff 75 f0             	pushl  -0x10(%ebp)
  8005fd:	e8 83 19 00 00       	call   801f85 <sys_signalSemaphore>
  800602:	83 c4 10             	add    $0x10,%esp
}
  800605:	90                   	nop
  800606:	c9                   	leave  
  800607:	c3                   	ret    

00800608 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800608:	55                   	push   %ebp
  800609:	89 e5                	mov    %esp,%ebp
  80060b:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80060e:	8b 45 08             	mov    0x8(%ebp),%eax
  800611:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800614:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800618:	83 ec 0c             	sub    $0xc,%esp
  80061b:	50                   	push   %eax
  80061c:	e8 cd 18 00 00       	call   801eee <sys_cputc>
  800621:	83 c4 10             	add    $0x10,%esp
}
  800624:	90                   	nop
  800625:	c9                   	leave  
  800626:	c3                   	ret    

00800627 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800627:	55                   	push   %ebp
  800628:	89 e5                	mov    %esp,%ebp
  80062a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80062d:	e8 88 18 00 00       	call   801eba <sys_disable_interrupt>
	char c = ch;
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800638:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80063c:	83 ec 0c             	sub    $0xc,%esp
  80063f:	50                   	push   %eax
  800640:	e8 a9 18 00 00       	call   801eee <sys_cputc>
  800645:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800648:	e8 87 18 00 00       	call   801ed4 <sys_enable_interrupt>
}
  80064d:	90                   	nop
  80064e:	c9                   	leave  
  80064f:	c3                   	ret    

00800650 <getchar>:

int
getchar(void)
{
  800650:	55                   	push   %ebp
  800651:	89 e5                	mov    %esp,%ebp
  800653:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800656:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80065d:	eb 08                	jmp    800667 <getchar+0x17>
	{
		c = sys_cgetc();
  80065f:	e8 6e 16 00 00       	call   801cd2 <sys_cgetc>
  800664:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800667:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80066b:	74 f2                	je     80065f <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80066d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800670:	c9                   	leave  
  800671:	c3                   	ret    

00800672 <atomic_getchar>:

int
atomic_getchar(void)
{
  800672:	55                   	push   %ebp
  800673:	89 e5                	mov    %esp,%ebp
  800675:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800678:	e8 3d 18 00 00       	call   801eba <sys_disable_interrupt>
	int c=0;
  80067d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800684:	eb 08                	jmp    80068e <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800686:	e8 47 16 00 00       	call   801cd2 <sys_cgetc>
  80068b:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80068e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800692:	74 f2                	je     800686 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800694:	e8 3b 18 00 00       	call   801ed4 <sys_enable_interrupt>
	return c;
  800699:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80069c:	c9                   	leave  
  80069d:	c3                   	ret    

0080069e <iscons>:

int iscons(int fdnum)
{
  80069e:	55                   	push   %ebp
  80069f:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8006a1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8006a6:	5d                   	pop    %ebp
  8006a7:	c3                   	ret    

008006a8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006a8:	55                   	push   %ebp
  8006a9:	89 e5                	mov    %esp,%ebp
  8006ab:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006ae:	e8 6c 16 00 00       	call   801d1f <sys_getenvindex>
  8006b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006b9:	89 d0                	mov    %edx,%eax
  8006bb:	01 c0                	add    %eax,%eax
  8006bd:	01 d0                	add    %edx,%eax
  8006bf:	c1 e0 02             	shl    $0x2,%eax
  8006c2:	01 d0                	add    %edx,%eax
  8006c4:	c1 e0 06             	shl    $0x6,%eax
  8006c7:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006cc:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006d1:	a1 24 30 80 00       	mov    0x803024,%eax
  8006d6:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8006dc:	84 c0                	test   %al,%al
  8006de:	74 0f                	je     8006ef <libmain+0x47>
		binaryname = myEnv->prog_name;
  8006e0:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e5:	05 f4 02 00 00       	add    $0x2f4,%eax
  8006ea:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006ef:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006f3:	7e 0a                	jle    8006ff <libmain+0x57>
		binaryname = argv[0];
  8006f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006f8:	8b 00                	mov    (%eax),%eax
  8006fa:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006ff:	83 ec 08             	sub    $0x8,%esp
  800702:	ff 75 0c             	pushl  0xc(%ebp)
  800705:	ff 75 08             	pushl  0x8(%ebp)
  800708:	e8 2b f9 ff ff       	call   800038 <_main>
  80070d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800710:	e8 a5 17 00 00       	call   801eba <sys_disable_interrupt>
	cprintf("**************************************\n");
  800715:	83 ec 0c             	sub    $0xc,%esp
  800718:	68 b4 26 80 00       	push   $0x8026b4
  80071d:	e8 3c 03 00 00       	call   800a5e <cprintf>
  800722:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800725:	a1 24 30 80 00       	mov    0x803024,%eax
  80072a:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800730:	a1 24 30 80 00       	mov    0x803024,%eax
  800735:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80073b:	83 ec 04             	sub    $0x4,%esp
  80073e:	52                   	push   %edx
  80073f:	50                   	push   %eax
  800740:	68 dc 26 80 00       	push   $0x8026dc
  800745:	e8 14 03 00 00       	call   800a5e <cprintf>
  80074a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80074d:	a1 24 30 80 00       	mov    0x803024,%eax
  800752:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800758:	83 ec 08             	sub    $0x8,%esp
  80075b:	50                   	push   %eax
  80075c:	68 01 27 80 00       	push   $0x802701
  800761:	e8 f8 02 00 00       	call   800a5e <cprintf>
  800766:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800769:	83 ec 0c             	sub    $0xc,%esp
  80076c:	68 b4 26 80 00       	push   $0x8026b4
  800771:	e8 e8 02 00 00       	call   800a5e <cprintf>
  800776:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800779:	e8 56 17 00 00       	call   801ed4 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80077e:	e8 19 00 00 00       	call   80079c <exit>
}
  800783:	90                   	nop
  800784:	c9                   	leave  
  800785:	c3                   	ret    

00800786 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800786:	55                   	push   %ebp
  800787:	89 e5                	mov    %esp,%ebp
  800789:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80078c:	83 ec 0c             	sub    $0xc,%esp
  80078f:	6a 00                	push   $0x0
  800791:	e8 55 15 00 00       	call   801ceb <sys_env_destroy>
  800796:	83 c4 10             	add    $0x10,%esp
}
  800799:	90                   	nop
  80079a:	c9                   	leave  
  80079b:	c3                   	ret    

0080079c <exit>:

void
exit(void)
{
  80079c:	55                   	push   %ebp
  80079d:	89 e5                	mov    %esp,%ebp
  80079f:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007a2:	e8 aa 15 00 00       	call   801d51 <sys_env_exit>
}
  8007a7:	90                   	nop
  8007a8:	c9                   	leave  
  8007a9:	c3                   	ret    

008007aa <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007aa:	55                   	push   %ebp
  8007ab:	89 e5                	mov    %esp,%ebp
  8007ad:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007b0:	8d 45 10             	lea    0x10(%ebp),%eax
  8007b3:	83 c0 04             	add    $0x4,%eax
  8007b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8007b9:	a1 34 30 80 00       	mov    0x803034,%eax
  8007be:	85 c0                	test   %eax,%eax
  8007c0:	74 16                	je     8007d8 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8007c2:	a1 34 30 80 00       	mov    0x803034,%eax
  8007c7:	83 ec 08             	sub    $0x8,%esp
  8007ca:	50                   	push   %eax
  8007cb:	68 18 27 80 00       	push   $0x802718
  8007d0:	e8 89 02 00 00       	call   800a5e <cprintf>
  8007d5:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8007d8:	a1 00 30 80 00       	mov    0x803000,%eax
  8007dd:	ff 75 0c             	pushl  0xc(%ebp)
  8007e0:	ff 75 08             	pushl  0x8(%ebp)
  8007e3:	50                   	push   %eax
  8007e4:	68 1d 27 80 00       	push   $0x80271d
  8007e9:	e8 70 02 00 00       	call   800a5e <cprintf>
  8007ee:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f4:	83 ec 08             	sub    $0x8,%esp
  8007f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8007fa:	50                   	push   %eax
  8007fb:	e8 f3 01 00 00       	call   8009f3 <vcprintf>
  800800:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800803:	83 ec 08             	sub    $0x8,%esp
  800806:	6a 00                	push   $0x0
  800808:	68 39 27 80 00       	push   $0x802739
  80080d:	e8 e1 01 00 00       	call   8009f3 <vcprintf>
  800812:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800815:	e8 82 ff ff ff       	call   80079c <exit>

	// should not return here
	while (1) ;
  80081a:	eb fe                	jmp    80081a <_panic+0x70>

0080081c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80081c:	55                   	push   %ebp
  80081d:	89 e5                	mov    %esp,%ebp
  80081f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800822:	a1 24 30 80 00       	mov    0x803024,%eax
  800827:	8b 50 74             	mov    0x74(%eax),%edx
  80082a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082d:	39 c2                	cmp    %eax,%edx
  80082f:	74 14                	je     800845 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800831:	83 ec 04             	sub    $0x4,%esp
  800834:	68 3c 27 80 00       	push   $0x80273c
  800839:	6a 26                	push   $0x26
  80083b:	68 88 27 80 00       	push   $0x802788
  800840:	e8 65 ff ff ff       	call   8007aa <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800845:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80084c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800853:	e9 c2 00 00 00       	jmp    80091a <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800858:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80085b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800862:	8b 45 08             	mov    0x8(%ebp),%eax
  800865:	01 d0                	add    %edx,%eax
  800867:	8b 00                	mov    (%eax),%eax
  800869:	85 c0                	test   %eax,%eax
  80086b:	75 08                	jne    800875 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80086d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800870:	e9 a2 00 00 00       	jmp    800917 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800875:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80087c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800883:	eb 69                	jmp    8008ee <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800885:	a1 24 30 80 00       	mov    0x803024,%eax
  80088a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800890:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800893:	89 d0                	mov    %edx,%eax
  800895:	01 c0                	add    %eax,%eax
  800897:	01 d0                	add    %edx,%eax
  800899:	c1 e0 02             	shl    $0x2,%eax
  80089c:	01 c8                	add    %ecx,%eax
  80089e:	8a 40 04             	mov    0x4(%eax),%al
  8008a1:	84 c0                	test   %al,%al
  8008a3:	75 46                	jne    8008eb <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008a5:	a1 24 30 80 00       	mov    0x803024,%eax
  8008aa:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008b0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008b3:	89 d0                	mov    %edx,%eax
  8008b5:	01 c0                	add    %eax,%eax
  8008b7:	01 d0                	add    %edx,%eax
  8008b9:	c1 e0 02             	shl    $0x2,%eax
  8008bc:	01 c8                	add    %ecx,%eax
  8008be:	8b 00                	mov    (%eax),%eax
  8008c0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8008c3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008c6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008cb:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8008cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008da:	01 c8                	add    %ecx,%eax
  8008dc:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008de:	39 c2                	cmp    %eax,%edx
  8008e0:	75 09                	jne    8008eb <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8008e2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008e9:	eb 12                	jmp    8008fd <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008eb:	ff 45 e8             	incl   -0x18(%ebp)
  8008ee:	a1 24 30 80 00       	mov    0x803024,%eax
  8008f3:	8b 50 74             	mov    0x74(%eax),%edx
  8008f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008f9:	39 c2                	cmp    %eax,%edx
  8008fb:	77 88                	ja     800885 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008fd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800901:	75 14                	jne    800917 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800903:	83 ec 04             	sub    $0x4,%esp
  800906:	68 94 27 80 00       	push   $0x802794
  80090b:	6a 3a                	push   $0x3a
  80090d:	68 88 27 80 00       	push   $0x802788
  800912:	e8 93 fe ff ff       	call   8007aa <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800917:	ff 45 f0             	incl   -0x10(%ebp)
  80091a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80091d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800920:	0f 8c 32 ff ff ff    	jl     800858 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800926:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80092d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800934:	eb 26                	jmp    80095c <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800936:	a1 24 30 80 00       	mov    0x803024,%eax
  80093b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800941:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800944:	89 d0                	mov    %edx,%eax
  800946:	01 c0                	add    %eax,%eax
  800948:	01 d0                	add    %edx,%eax
  80094a:	c1 e0 02             	shl    $0x2,%eax
  80094d:	01 c8                	add    %ecx,%eax
  80094f:	8a 40 04             	mov    0x4(%eax),%al
  800952:	3c 01                	cmp    $0x1,%al
  800954:	75 03                	jne    800959 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800956:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800959:	ff 45 e0             	incl   -0x20(%ebp)
  80095c:	a1 24 30 80 00       	mov    0x803024,%eax
  800961:	8b 50 74             	mov    0x74(%eax),%edx
  800964:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800967:	39 c2                	cmp    %eax,%edx
  800969:	77 cb                	ja     800936 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80096b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80096e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800971:	74 14                	je     800987 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800973:	83 ec 04             	sub    $0x4,%esp
  800976:	68 e8 27 80 00       	push   $0x8027e8
  80097b:	6a 44                	push   $0x44
  80097d:	68 88 27 80 00       	push   $0x802788
  800982:	e8 23 fe ff ff       	call   8007aa <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800987:	90                   	nop
  800988:	c9                   	leave  
  800989:	c3                   	ret    

0080098a <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80098a:	55                   	push   %ebp
  80098b:	89 e5                	mov    %esp,%ebp
  80098d:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800990:	8b 45 0c             	mov    0xc(%ebp),%eax
  800993:	8b 00                	mov    (%eax),%eax
  800995:	8d 48 01             	lea    0x1(%eax),%ecx
  800998:	8b 55 0c             	mov    0xc(%ebp),%edx
  80099b:	89 0a                	mov    %ecx,(%edx)
  80099d:	8b 55 08             	mov    0x8(%ebp),%edx
  8009a0:	88 d1                	mov    %dl,%cl
  8009a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ac:	8b 00                	mov    (%eax),%eax
  8009ae:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009b3:	75 2c                	jne    8009e1 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009b5:	a0 28 30 80 00       	mov    0x803028,%al
  8009ba:	0f b6 c0             	movzbl %al,%eax
  8009bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c0:	8b 12                	mov    (%edx),%edx
  8009c2:	89 d1                	mov    %edx,%ecx
  8009c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c7:	83 c2 08             	add    $0x8,%edx
  8009ca:	83 ec 04             	sub    $0x4,%esp
  8009cd:	50                   	push   %eax
  8009ce:	51                   	push   %ecx
  8009cf:	52                   	push   %edx
  8009d0:	e8 d4 12 00 00       	call   801ca9 <sys_cputs>
  8009d5:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8009d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009db:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e4:	8b 40 04             	mov    0x4(%eax),%eax
  8009e7:	8d 50 01             	lea    0x1(%eax),%edx
  8009ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ed:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009f0:	90                   	nop
  8009f1:	c9                   	leave  
  8009f2:	c3                   	ret    

008009f3 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009f3:	55                   	push   %ebp
  8009f4:	89 e5                	mov    %esp,%ebp
  8009f6:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009fc:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a03:	00 00 00 
	b.cnt = 0;
  800a06:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a0d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a10:	ff 75 0c             	pushl  0xc(%ebp)
  800a13:	ff 75 08             	pushl  0x8(%ebp)
  800a16:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a1c:	50                   	push   %eax
  800a1d:	68 8a 09 80 00       	push   $0x80098a
  800a22:	e8 11 02 00 00       	call   800c38 <vprintfmt>
  800a27:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a2a:	a0 28 30 80 00       	mov    0x803028,%al
  800a2f:	0f b6 c0             	movzbl %al,%eax
  800a32:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a38:	83 ec 04             	sub    $0x4,%esp
  800a3b:	50                   	push   %eax
  800a3c:	52                   	push   %edx
  800a3d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a43:	83 c0 08             	add    $0x8,%eax
  800a46:	50                   	push   %eax
  800a47:	e8 5d 12 00 00       	call   801ca9 <sys_cputs>
  800a4c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a4f:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a56:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a5c:	c9                   	leave  
  800a5d:	c3                   	ret    

00800a5e <cprintf>:

int cprintf(const char *fmt, ...) {
  800a5e:	55                   	push   %ebp
  800a5f:	89 e5                	mov    %esp,%ebp
  800a61:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a64:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a6b:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a71:	8b 45 08             	mov    0x8(%ebp),%eax
  800a74:	83 ec 08             	sub    $0x8,%esp
  800a77:	ff 75 f4             	pushl  -0xc(%ebp)
  800a7a:	50                   	push   %eax
  800a7b:	e8 73 ff ff ff       	call   8009f3 <vcprintf>
  800a80:	83 c4 10             	add    $0x10,%esp
  800a83:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a86:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a89:	c9                   	leave  
  800a8a:	c3                   	ret    

00800a8b <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a8b:	55                   	push   %ebp
  800a8c:	89 e5                	mov    %esp,%ebp
  800a8e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a91:	e8 24 14 00 00       	call   801eba <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a96:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a99:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9f:	83 ec 08             	sub    $0x8,%esp
  800aa2:	ff 75 f4             	pushl  -0xc(%ebp)
  800aa5:	50                   	push   %eax
  800aa6:	e8 48 ff ff ff       	call   8009f3 <vcprintf>
  800aab:	83 c4 10             	add    $0x10,%esp
  800aae:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800ab1:	e8 1e 14 00 00       	call   801ed4 <sys_enable_interrupt>
	return cnt;
  800ab6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ab9:	c9                   	leave  
  800aba:	c3                   	ret    

00800abb <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800abb:	55                   	push   %ebp
  800abc:	89 e5                	mov    %esp,%ebp
  800abe:	53                   	push   %ebx
  800abf:	83 ec 14             	sub    $0x14,%esp
  800ac2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac8:	8b 45 14             	mov    0x14(%ebp),%eax
  800acb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800ace:	8b 45 18             	mov    0x18(%ebp),%eax
  800ad1:	ba 00 00 00 00       	mov    $0x0,%edx
  800ad6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ad9:	77 55                	ja     800b30 <printnum+0x75>
  800adb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ade:	72 05                	jb     800ae5 <printnum+0x2a>
  800ae0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ae3:	77 4b                	ja     800b30 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800ae5:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800ae8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800aeb:	8b 45 18             	mov    0x18(%ebp),%eax
  800aee:	ba 00 00 00 00       	mov    $0x0,%edx
  800af3:	52                   	push   %edx
  800af4:	50                   	push   %eax
  800af5:	ff 75 f4             	pushl  -0xc(%ebp)
  800af8:	ff 75 f0             	pushl  -0x10(%ebp)
  800afb:	e8 98 17 00 00       	call   802298 <__udivdi3>
  800b00:	83 c4 10             	add    $0x10,%esp
  800b03:	83 ec 04             	sub    $0x4,%esp
  800b06:	ff 75 20             	pushl  0x20(%ebp)
  800b09:	53                   	push   %ebx
  800b0a:	ff 75 18             	pushl  0x18(%ebp)
  800b0d:	52                   	push   %edx
  800b0e:	50                   	push   %eax
  800b0f:	ff 75 0c             	pushl  0xc(%ebp)
  800b12:	ff 75 08             	pushl  0x8(%ebp)
  800b15:	e8 a1 ff ff ff       	call   800abb <printnum>
  800b1a:	83 c4 20             	add    $0x20,%esp
  800b1d:	eb 1a                	jmp    800b39 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b1f:	83 ec 08             	sub    $0x8,%esp
  800b22:	ff 75 0c             	pushl  0xc(%ebp)
  800b25:	ff 75 20             	pushl  0x20(%ebp)
  800b28:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2b:	ff d0                	call   *%eax
  800b2d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b30:	ff 4d 1c             	decl   0x1c(%ebp)
  800b33:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b37:	7f e6                	jg     800b1f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b39:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b3c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b41:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b44:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b47:	53                   	push   %ebx
  800b48:	51                   	push   %ecx
  800b49:	52                   	push   %edx
  800b4a:	50                   	push   %eax
  800b4b:	e8 58 18 00 00       	call   8023a8 <__umoddi3>
  800b50:	83 c4 10             	add    $0x10,%esp
  800b53:	05 54 2a 80 00       	add    $0x802a54,%eax
  800b58:	8a 00                	mov    (%eax),%al
  800b5a:	0f be c0             	movsbl %al,%eax
  800b5d:	83 ec 08             	sub    $0x8,%esp
  800b60:	ff 75 0c             	pushl  0xc(%ebp)
  800b63:	50                   	push   %eax
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	ff d0                	call   *%eax
  800b69:	83 c4 10             	add    $0x10,%esp
}
  800b6c:	90                   	nop
  800b6d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b70:	c9                   	leave  
  800b71:	c3                   	ret    

00800b72 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b72:	55                   	push   %ebp
  800b73:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b75:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b79:	7e 1c                	jle    800b97 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7e:	8b 00                	mov    (%eax),%eax
  800b80:	8d 50 08             	lea    0x8(%eax),%edx
  800b83:	8b 45 08             	mov    0x8(%ebp),%eax
  800b86:	89 10                	mov    %edx,(%eax)
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	8b 00                	mov    (%eax),%eax
  800b8d:	83 e8 08             	sub    $0x8,%eax
  800b90:	8b 50 04             	mov    0x4(%eax),%edx
  800b93:	8b 00                	mov    (%eax),%eax
  800b95:	eb 40                	jmp    800bd7 <getuint+0x65>
	else if (lflag)
  800b97:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b9b:	74 1e                	je     800bbb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba0:	8b 00                	mov    (%eax),%eax
  800ba2:	8d 50 04             	lea    0x4(%eax),%edx
  800ba5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba8:	89 10                	mov    %edx,(%eax)
  800baa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bad:	8b 00                	mov    (%eax),%eax
  800baf:	83 e8 04             	sub    $0x4,%eax
  800bb2:	8b 00                	mov    (%eax),%eax
  800bb4:	ba 00 00 00 00       	mov    $0x0,%edx
  800bb9:	eb 1c                	jmp    800bd7 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbe:	8b 00                	mov    (%eax),%eax
  800bc0:	8d 50 04             	lea    0x4(%eax),%edx
  800bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc6:	89 10                	mov    %edx,(%eax)
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcb:	8b 00                	mov    (%eax),%eax
  800bcd:	83 e8 04             	sub    $0x4,%eax
  800bd0:	8b 00                	mov    (%eax),%eax
  800bd2:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800bd7:	5d                   	pop    %ebp
  800bd8:	c3                   	ret    

00800bd9 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800bd9:	55                   	push   %ebp
  800bda:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bdc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800be0:	7e 1c                	jle    800bfe <getint+0x25>
		return va_arg(*ap, long long);
  800be2:	8b 45 08             	mov    0x8(%ebp),%eax
  800be5:	8b 00                	mov    (%eax),%eax
  800be7:	8d 50 08             	lea    0x8(%eax),%edx
  800bea:	8b 45 08             	mov    0x8(%ebp),%eax
  800bed:	89 10                	mov    %edx,(%eax)
  800bef:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf2:	8b 00                	mov    (%eax),%eax
  800bf4:	83 e8 08             	sub    $0x8,%eax
  800bf7:	8b 50 04             	mov    0x4(%eax),%edx
  800bfa:	8b 00                	mov    (%eax),%eax
  800bfc:	eb 38                	jmp    800c36 <getint+0x5d>
	else if (lflag)
  800bfe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c02:	74 1a                	je     800c1e <getint+0x45>
		return va_arg(*ap, long);
  800c04:	8b 45 08             	mov    0x8(%ebp),%eax
  800c07:	8b 00                	mov    (%eax),%eax
  800c09:	8d 50 04             	lea    0x4(%eax),%edx
  800c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0f:	89 10                	mov    %edx,(%eax)
  800c11:	8b 45 08             	mov    0x8(%ebp),%eax
  800c14:	8b 00                	mov    (%eax),%eax
  800c16:	83 e8 04             	sub    $0x4,%eax
  800c19:	8b 00                	mov    (%eax),%eax
  800c1b:	99                   	cltd   
  800c1c:	eb 18                	jmp    800c36 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c21:	8b 00                	mov    (%eax),%eax
  800c23:	8d 50 04             	lea    0x4(%eax),%edx
  800c26:	8b 45 08             	mov    0x8(%ebp),%eax
  800c29:	89 10                	mov    %edx,(%eax)
  800c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2e:	8b 00                	mov    (%eax),%eax
  800c30:	83 e8 04             	sub    $0x4,%eax
  800c33:	8b 00                	mov    (%eax),%eax
  800c35:	99                   	cltd   
}
  800c36:	5d                   	pop    %ebp
  800c37:	c3                   	ret    

00800c38 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c38:	55                   	push   %ebp
  800c39:	89 e5                	mov    %esp,%ebp
  800c3b:	56                   	push   %esi
  800c3c:	53                   	push   %ebx
  800c3d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c40:	eb 17                	jmp    800c59 <vprintfmt+0x21>
			if (ch == '\0')
  800c42:	85 db                	test   %ebx,%ebx
  800c44:	0f 84 af 03 00 00    	je     800ff9 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c4a:	83 ec 08             	sub    $0x8,%esp
  800c4d:	ff 75 0c             	pushl  0xc(%ebp)
  800c50:	53                   	push   %ebx
  800c51:	8b 45 08             	mov    0x8(%ebp),%eax
  800c54:	ff d0                	call   *%eax
  800c56:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c59:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5c:	8d 50 01             	lea    0x1(%eax),%edx
  800c5f:	89 55 10             	mov    %edx,0x10(%ebp)
  800c62:	8a 00                	mov    (%eax),%al
  800c64:	0f b6 d8             	movzbl %al,%ebx
  800c67:	83 fb 25             	cmp    $0x25,%ebx
  800c6a:	75 d6                	jne    800c42 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c6c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c70:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c77:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c7e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c85:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c8f:	8d 50 01             	lea    0x1(%eax),%edx
  800c92:	89 55 10             	mov    %edx,0x10(%ebp)
  800c95:	8a 00                	mov    (%eax),%al
  800c97:	0f b6 d8             	movzbl %al,%ebx
  800c9a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c9d:	83 f8 55             	cmp    $0x55,%eax
  800ca0:	0f 87 2b 03 00 00    	ja     800fd1 <vprintfmt+0x399>
  800ca6:	8b 04 85 78 2a 80 00 	mov    0x802a78(,%eax,4),%eax
  800cad:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800caf:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cb3:	eb d7                	jmp    800c8c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800cb5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800cb9:	eb d1                	jmp    800c8c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cbb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800cc2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cc5:	89 d0                	mov    %edx,%eax
  800cc7:	c1 e0 02             	shl    $0x2,%eax
  800cca:	01 d0                	add    %edx,%eax
  800ccc:	01 c0                	add    %eax,%eax
  800cce:	01 d8                	add    %ebx,%eax
  800cd0:	83 e8 30             	sub    $0x30,%eax
  800cd3:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800cd6:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd9:	8a 00                	mov    (%eax),%al
  800cdb:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800cde:	83 fb 2f             	cmp    $0x2f,%ebx
  800ce1:	7e 3e                	jle    800d21 <vprintfmt+0xe9>
  800ce3:	83 fb 39             	cmp    $0x39,%ebx
  800ce6:	7f 39                	jg     800d21 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ce8:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ceb:	eb d5                	jmp    800cc2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ced:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf0:	83 c0 04             	add    $0x4,%eax
  800cf3:	89 45 14             	mov    %eax,0x14(%ebp)
  800cf6:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf9:	83 e8 04             	sub    $0x4,%eax
  800cfc:	8b 00                	mov    (%eax),%eax
  800cfe:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d01:	eb 1f                	jmp    800d22 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d03:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d07:	79 83                	jns    800c8c <vprintfmt+0x54>
				width = 0;
  800d09:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d10:	e9 77 ff ff ff       	jmp    800c8c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d15:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d1c:	e9 6b ff ff ff       	jmp    800c8c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d21:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d22:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d26:	0f 89 60 ff ff ff    	jns    800c8c <vprintfmt+0x54>
				width = precision, precision = -1;
  800d2c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d2f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d32:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d39:	e9 4e ff ff ff       	jmp    800c8c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d3e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d41:	e9 46 ff ff ff       	jmp    800c8c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d46:	8b 45 14             	mov    0x14(%ebp),%eax
  800d49:	83 c0 04             	add    $0x4,%eax
  800d4c:	89 45 14             	mov    %eax,0x14(%ebp)
  800d4f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d52:	83 e8 04             	sub    $0x4,%eax
  800d55:	8b 00                	mov    (%eax),%eax
  800d57:	83 ec 08             	sub    $0x8,%esp
  800d5a:	ff 75 0c             	pushl  0xc(%ebp)
  800d5d:	50                   	push   %eax
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	ff d0                	call   *%eax
  800d63:	83 c4 10             	add    $0x10,%esp
			break;
  800d66:	e9 89 02 00 00       	jmp    800ff4 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d6b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d6e:	83 c0 04             	add    $0x4,%eax
  800d71:	89 45 14             	mov    %eax,0x14(%ebp)
  800d74:	8b 45 14             	mov    0x14(%ebp),%eax
  800d77:	83 e8 04             	sub    $0x4,%eax
  800d7a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d7c:	85 db                	test   %ebx,%ebx
  800d7e:	79 02                	jns    800d82 <vprintfmt+0x14a>
				err = -err;
  800d80:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d82:	83 fb 64             	cmp    $0x64,%ebx
  800d85:	7f 0b                	jg     800d92 <vprintfmt+0x15a>
  800d87:	8b 34 9d c0 28 80 00 	mov    0x8028c0(,%ebx,4),%esi
  800d8e:	85 f6                	test   %esi,%esi
  800d90:	75 19                	jne    800dab <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d92:	53                   	push   %ebx
  800d93:	68 65 2a 80 00       	push   $0x802a65
  800d98:	ff 75 0c             	pushl  0xc(%ebp)
  800d9b:	ff 75 08             	pushl  0x8(%ebp)
  800d9e:	e8 5e 02 00 00       	call   801001 <printfmt>
  800da3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800da6:	e9 49 02 00 00       	jmp    800ff4 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800dab:	56                   	push   %esi
  800dac:	68 6e 2a 80 00       	push   $0x802a6e
  800db1:	ff 75 0c             	pushl  0xc(%ebp)
  800db4:	ff 75 08             	pushl  0x8(%ebp)
  800db7:	e8 45 02 00 00       	call   801001 <printfmt>
  800dbc:	83 c4 10             	add    $0x10,%esp
			break;
  800dbf:	e9 30 02 00 00       	jmp    800ff4 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800dc4:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc7:	83 c0 04             	add    $0x4,%eax
  800dca:	89 45 14             	mov    %eax,0x14(%ebp)
  800dcd:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd0:	83 e8 04             	sub    $0x4,%eax
  800dd3:	8b 30                	mov    (%eax),%esi
  800dd5:	85 f6                	test   %esi,%esi
  800dd7:	75 05                	jne    800dde <vprintfmt+0x1a6>
				p = "(null)";
  800dd9:	be 71 2a 80 00       	mov    $0x802a71,%esi
			if (width > 0 && padc != '-')
  800dde:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de2:	7e 6d                	jle    800e51 <vprintfmt+0x219>
  800de4:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800de8:	74 67                	je     800e51 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800dea:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ded:	83 ec 08             	sub    $0x8,%esp
  800df0:	50                   	push   %eax
  800df1:	56                   	push   %esi
  800df2:	e8 12 05 00 00       	call   801309 <strnlen>
  800df7:	83 c4 10             	add    $0x10,%esp
  800dfa:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800dfd:	eb 16                	jmp    800e15 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800dff:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e03:	83 ec 08             	sub    $0x8,%esp
  800e06:	ff 75 0c             	pushl  0xc(%ebp)
  800e09:	50                   	push   %eax
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0d:	ff d0                	call   *%eax
  800e0f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e12:	ff 4d e4             	decl   -0x1c(%ebp)
  800e15:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e19:	7f e4                	jg     800dff <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e1b:	eb 34                	jmp    800e51 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e1d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e21:	74 1c                	je     800e3f <vprintfmt+0x207>
  800e23:	83 fb 1f             	cmp    $0x1f,%ebx
  800e26:	7e 05                	jle    800e2d <vprintfmt+0x1f5>
  800e28:	83 fb 7e             	cmp    $0x7e,%ebx
  800e2b:	7e 12                	jle    800e3f <vprintfmt+0x207>
					putch('?', putdat);
  800e2d:	83 ec 08             	sub    $0x8,%esp
  800e30:	ff 75 0c             	pushl  0xc(%ebp)
  800e33:	6a 3f                	push   $0x3f
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	ff d0                	call   *%eax
  800e3a:	83 c4 10             	add    $0x10,%esp
  800e3d:	eb 0f                	jmp    800e4e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e3f:	83 ec 08             	sub    $0x8,%esp
  800e42:	ff 75 0c             	pushl  0xc(%ebp)
  800e45:	53                   	push   %ebx
  800e46:	8b 45 08             	mov    0x8(%ebp),%eax
  800e49:	ff d0                	call   *%eax
  800e4b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e4e:	ff 4d e4             	decl   -0x1c(%ebp)
  800e51:	89 f0                	mov    %esi,%eax
  800e53:	8d 70 01             	lea    0x1(%eax),%esi
  800e56:	8a 00                	mov    (%eax),%al
  800e58:	0f be d8             	movsbl %al,%ebx
  800e5b:	85 db                	test   %ebx,%ebx
  800e5d:	74 24                	je     800e83 <vprintfmt+0x24b>
  800e5f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e63:	78 b8                	js     800e1d <vprintfmt+0x1e5>
  800e65:	ff 4d e0             	decl   -0x20(%ebp)
  800e68:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e6c:	79 af                	jns    800e1d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e6e:	eb 13                	jmp    800e83 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e70:	83 ec 08             	sub    $0x8,%esp
  800e73:	ff 75 0c             	pushl  0xc(%ebp)
  800e76:	6a 20                	push   $0x20
  800e78:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7b:	ff d0                	call   *%eax
  800e7d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e80:	ff 4d e4             	decl   -0x1c(%ebp)
  800e83:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e87:	7f e7                	jg     800e70 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e89:	e9 66 01 00 00       	jmp    800ff4 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e8e:	83 ec 08             	sub    $0x8,%esp
  800e91:	ff 75 e8             	pushl  -0x18(%ebp)
  800e94:	8d 45 14             	lea    0x14(%ebp),%eax
  800e97:	50                   	push   %eax
  800e98:	e8 3c fd ff ff       	call   800bd9 <getint>
  800e9d:	83 c4 10             	add    $0x10,%esp
  800ea0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ea3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ea6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ea9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eac:	85 d2                	test   %edx,%edx
  800eae:	79 23                	jns    800ed3 <vprintfmt+0x29b>
				putch('-', putdat);
  800eb0:	83 ec 08             	sub    $0x8,%esp
  800eb3:	ff 75 0c             	pushl  0xc(%ebp)
  800eb6:	6a 2d                	push   $0x2d
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	ff d0                	call   *%eax
  800ebd:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ec0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ec3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ec6:	f7 d8                	neg    %eax
  800ec8:	83 d2 00             	adc    $0x0,%edx
  800ecb:	f7 da                	neg    %edx
  800ecd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ed3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800eda:	e9 bc 00 00 00       	jmp    800f9b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800edf:	83 ec 08             	sub    $0x8,%esp
  800ee2:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee5:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee8:	50                   	push   %eax
  800ee9:	e8 84 fc ff ff       	call   800b72 <getuint>
  800eee:	83 c4 10             	add    $0x10,%esp
  800ef1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ef7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800efe:	e9 98 00 00 00       	jmp    800f9b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f03:	83 ec 08             	sub    $0x8,%esp
  800f06:	ff 75 0c             	pushl  0xc(%ebp)
  800f09:	6a 58                	push   $0x58
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0e:	ff d0                	call   *%eax
  800f10:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f13:	83 ec 08             	sub    $0x8,%esp
  800f16:	ff 75 0c             	pushl  0xc(%ebp)
  800f19:	6a 58                	push   $0x58
  800f1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1e:	ff d0                	call   *%eax
  800f20:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f23:	83 ec 08             	sub    $0x8,%esp
  800f26:	ff 75 0c             	pushl  0xc(%ebp)
  800f29:	6a 58                	push   $0x58
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	ff d0                	call   *%eax
  800f30:	83 c4 10             	add    $0x10,%esp
			break;
  800f33:	e9 bc 00 00 00       	jmp    800ff4 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f38:	83 ec 08             	sub    $0x8,%esp
  800f3b:	ff 75 0c             	pushl  0xc(%ebp)
  800f3e:	6a 30                	push   $0x30
  800f40:	8b 45 08             	mov    0x8(%ebp),%eax
  800f43:	ff d0                	call   *%eax
  800f45:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f48:	83 ec 08             	sub    $0x8,%esp
  800f4b:	ff 75 0c             	pushl  0xc(%ebp)
  800f4e:	6a 78                	push   $0x78
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	ff d0                	call   *%eax
  800f55:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f58:	8b 45 14             	mov    0x14(%ebp),%eax
  800f5b:	83 c0 04             	add    $0x4,%eax
  800f5e:	89 45 14             	mov    %eax,0x14(%ebp)
  800f61:	8b 45 14             	mov    0x14(%ebp),%eax
  800f64:	83 e8 04             	sub    $0x4,%eax
  800f67:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f69:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f6c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f73:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f7a:	eb 1f                	jmp    800f9b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f7c:	83 ec 08             	sub    $0x8,%esp
  800f7f:	ff 75 e8             	pushl  -0x18(%ebp)
  800f82:	8d 45 14             	lea    0x14(%ebp),%eax
  800f85:	50                   	push   %eax
  800f86:	e8 e7 fb ff ff       	call   800b72 <getuint>
  800f8b:	83 c4 10             	add    $0x10,%esp
  800f8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f91:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f94:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f9b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fa2:	83 ec 04             	sub    $0x4,%esp
  800fa5:	52                   	push   %edx
  800fa6:	ff 75 e4             	pushl  -0x1c(%ebp)
  800fa9:	50                   	push   %eax
  800faa:	ff 75 f4             	pushl  -0xc(%ebp)
  800fad:	ff 75 f0             	pushl  -0x10(%ebp)
  800fb0:	ff 75 0c             	pushl  0xc(%ebp)
  800fb3:	ff 75 08             	pushl  0x8(%ebp)
  800fb6:	e8 00 fb ff ff       	call   800abb <printnum>
  800fbb:	83 c4 20             	add    $0x20,%esp
			break;
  800fbe:	eb 34                	jmp    800ff4 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800fc0:	83 ec 08             	sub    $0x8,%esp
  800fc3:	ff 75 0c             	pushl  0xc(%ebp)
  800fc6:	53                   	push   %ebx
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	ff d0                	call   *%eax
  800fcc:	83 c4 10             	add    $0x10,%esp
			break;
  800fcf:	eb 23                	jmp    800ff4 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800fd1:	83 ec 08             	sub    $0x8,%esp
  800fd4:	ff 75 0c             	pushl  0xc(%ebp)
  800fd7:	6a 25                	push   $0x25
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdc:	ff d0                	call   *%eax
  800fde:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fe1:	ff 4d 10             	decl   0x10(%ebp)
  800fe4:	eb 03                	jmp    800fe9 <vprintfmt+0x3b1>
  800fe6:	ff 4d 10             	decl   0x10(%ebp)
  800fe9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fec:	48                   	dec    %eax
  800fed:	8a 00                	mov    (%eax),%al
  800fef:	3c 25                	cmp    $0x25,%al
  800ff1:	75 f3                	jne    800fe6 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ff3:	90                   	nop
		}
	}
  800ff4:	e9 47 fc ff ff       	jmp    800c40 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ff9:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ffa:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ffd:	5b                   	pop    %ebx
  800ffe:	5e                   	pop    %esi
  800fff:	5d                   	pop    %ebp
  801000:	c3                   	ret    

00801001 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801001:	55                   	push   %ebp
  801002:	89 e5                	mov    %esp,%ebp
  801004:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801007:	8d 45 10             	lea    0x10(%ebp),%eax
  80100a:	83 c0 04             	add    $0x4,%eax
  80100d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801010:	8b 45 10             	mov    0x10(%ebp),%eax
  801013:	ff 75 f4             	pushl  -0xc(%ebp)
  801016:	50                   	push   %eax
  801017:	ff 75 0c             	pushl  0xc(%ebp)
  80101a:	ff 75 08             	pushl  0x8(%ebp)
  80101d:	e8 16 fc ff ff       	call   800c38 <vprintfmt>
  801022:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801025:	90                   	nop
  801026:	c9                   	leave  
  801027:	c3                   	ret    

00801028 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801028:	55                   	push   %ebp
  801029:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80102b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102e:	8b 40 08             	mov    0x8(%eax),%eax
  801031:	8d 50 01             	lea    0x1(%eax),%edx
  801034:	8b 45 0c             	mov    0xc(%ebp),%eax
  801037:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80103a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103d:	8b 10                	mov    (%eax),%edx
  80103f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801042:	8b 40 04             	mov    0x4(%eax),%eax
  801045:	39 c2                	cmp    %eax,%edx
  801047:	73 12                	jae    80105b <sprintputch+0x33>
		*b->buf++ = ch;
  801049:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104c:	8b 00                	mov    (%eax),%eax
  80104e:	8d 48 01             	lea    0x1(%eax),%ecx
  801051:	8b 55 0c             	mov    0xc(%ebp),%edx
  801054:	89 0a                	mov    %ecx,(%edx)
  801056:	8b 55 08             	mov    0x8(%ebp),%edx
  801059:	88 10                	mov    %dl,(%eax)
}
  80105b:	90                   	nop
  80105c:	5d                   	pop    %ebp
  80105d:	c3                   	ret    

0080105e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80105e:	55                   	push   %ebp
  80105f:	89 e5                	mov    %esp,%ebp
  801061:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80106a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801070:	8b 45 08             	mov    0x8(%ebp),%eax
  801073:	01 d0                	add    %edx,%eax
  801075:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801078:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80107f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801083:	74 06                	je     80108b <vsnprintf+0x2d>
  801085:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801089:	7f 07                	jg     801092 <vsnprintf+0x34>
		return -E_INVAL;
  80108b:	b8 03 00 00 00       	mov    $0x3,%eax
  801090:	eb 20                	jmp    8010b2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801092:	ff 75 14             	pushl  0x14(%ebp)
  801095:	ff 75 10             	pushl  0x10(%ebp)
  801098:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80109b:	50                   	push   %eax
  80109c:	68 28 10 80 00       	push   $0x801028
  8010a1:	e8 92 fb ff ff       	call   800c38 <vprintfmt>
  8010a6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010ac:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010af:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010b2:	c9                   	leave  
  8010b3:	c3                   	ret    

008010b4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010b4:	55                   	push   %ebp
  8010b5:	89 e5                	mov    %esp,%ebp
  8010b7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010ba:	8d 45 10             	lea    0x10(%ebp),%eax
  8010bd:	83 c0 04             	add    $0x4,%eax
  8010c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8010c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c6:	ff 75 f4             	pushl  -0xc(%ebp)
  8010c9:	50                   	push   %eax
  8010ca:	ff 75 0c             	pushl  0xc(%ebp)
  8010cd:	ff 75 08             	pushl  0x8(%ebp)
  8010d0:	e8 89 ff ff ff       	call   80105e <vsnprintf>
  8010d5:	83 c4 10             	add    $0x10,%esp
  8010d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010db:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010de:	c9                   	leave  
  8010df:	c3                   	ret    

008010e0 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010e0:	55                   	push   %ebp
  8010e1:	89 e5                	mov    %esp,%ebp
  8010e3:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010e6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010ea:	74 13                	je     8010ff <readline+0x1f>
		cprintf("%s", prompt);
  8010ec:	83 ec 08             	sub    $0x8,%esp
  8010ef:	ff 75 08             	pushl  0x8(%ebp)
  8010f2:	68 d0 2b 80 00       	push   $0x802bd0
  8010f7:	e8 62 f9 ff ff       	call   800a5e <cprintf>
  8010fc:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801106:	83 ec 0c             	sub    $0xc,%esp
  801109:	6a 00                	push   $0x0
  80110b:	e8 8e f5 ff ff       	call   80069e <iscons>
  801110:	83 c4 10             	add    $0x10,%esp
  801113:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801116:	e8 35 f5 ff ff       	call   800650 <getchar>
  80111b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80111e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801122:	79 22                	jns    801146 <readline+0x66>
			if (c != -E_EOF)
  801124:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801128:	0f 84 ad 00 00 00    	je     8011db <readline+0xfb>
				cprintf("read error: %e\n", c);
  80112e:	83 ec 08             	sub    $0x8,%esp
  801131:	ff 75 ec             	pushl  -0x14(%ebp)
  801134:	68 d3 2b 80 00       	push   $0x802bd3
  801139:	e8 20 f9 ff ff       	call   800a5e <cprintf>
  80113e:	83 c4 10             	add    $0x10,%esp
			return;
  801141:	e9 95 00 00 00       	jmp    8011db <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801146:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80114a:	7e 34                	jle    801180 <readline+0xa0>
  80114c:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801153:	7f 2b                	jg     801180 <readline+0xa0>
			if (echoing)
  801155:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801159:	74 0e                	je     801169 <readline+0x89>
				cputchar(c);
  80115b:	83 ec 0c             	sub    $0xc,%esp
  80115e:	ff 75 ec             	pushl  -0x14(%ebp)
  801161:	e8 a2 f4 ff ff       	call   800608 <cputchar>
  801166:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801169:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80116c:	8d 50 01             	lea    0x1(%eax),%edx
  80116f:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801172:	89 c2                	mov    %eax,%edx
  801174:	8b 45 0c             	mov    0xc(%ebp),%eax
  801177:	01 d0                	add    %edx,%eax
  801179:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80117c:	88 10                	mov    %dl,(%eax)
  80117e:	eb 56                	jmp    8011d6 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801180:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801184:	75 1f                	jne    8011a5 <readline+0xc5>
  801186:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80118a:	7e 19                	jle    8011a5 <readline+0xc5>
			if (echoing)
  80118c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801190:	74 0e                	je     8011a0 <readline+0xc0>
				cputchar(c);
  801192:	83 ec 0c             	sub    $0xc,%esp
  801195:	ff 75 ec             	pushl  -0x14(%ebp)
  801198:	e8 6b f4 ff ff       	call   800608 <cputchar>
  80119d:	83 c4 10             	add    $0x10,%esp

			i--;
  8011a0:	ff 4d f4             	decl   -0xc(%ebp)
  8011a3:	eb 31                	jmp    8011d6 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8011a5:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011a9:	74 0a                	je     8011b5 <readline+0xd5>
  8011ab:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011af:	0f 85 61 ff ff ff    	jne    801116 <readline+0x36>
			if (echoing)
  8011b5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011b9:	74 0e                	je     8011c9 <readline+0xe9>
				cputchar(c);
  8011bb:	83 ec 0c             	sub    $0xc,%esp
  8011be:	ff 75 ec             	pushl  -0x14(%ebp)
  8011c1:	e8 42 f4 ff ff       	call   800608 <cputchar>
  8011c6:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8011c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cf:	01 d0                	add    %edx,%eax
  8011d1:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8011d4:	eb 06                	jmp    8011dc <readline+0xfc>
		}
	}
  8011d6:	e9 3b ff ff ff       	jmp    801116 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8011db:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8011dc:	c9                   	leave  
  8011dd:	c3                   	ret    

008011de <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011de:	55                   	push   %ebp
  8011df:	89 e5                	mov    %esp,%ebp
  8011e1:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011e4:	e8 d1 0c 00 00       	call   801eba <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011e9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011ed:	74 13                	je     801202 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011ef:	83 ec 08             	sub    $0x8,%esp
  8011f2:	ff 75 08             	pushl  0x8(%ebp)
  8011f5:	68 d0 2b 80 00       	push   $0x802bd0
  8011fa:	e8 5f f8 ff ff       	call   800a5e <cprintf>
  8011ff:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801202:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801209:	83 ec 0c             	sub    $0xc,%esp
  80120c:	6a 00                	push   $0x0
  80120e:	e8 8b f4 ff ff       	call   80069e <iscons>
  801213:	83 c4 10             	add    $0x10,%esp
  801216:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801219:	e8 32 f4 ff ff       	call   800650 <getchar>
  80121e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801221:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801225:	79 23                	jns    80124a <atomic_readline+0x6c>
			if (c != -E_EOF)
  801227:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80122b:	74 13                	je     801240 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80122d:	83 ec 08             	sub    $0x8,%esp
  801230:	ff 75 ec             	pushl  -0x14(%ebp)
  801233:	68 d3 2b 80 00       	push   $0x802bd3
  801238:	e8 21 f8 ff ff       	call   800a5e <cprintf>
  80123d:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801240:	e8 8f 0c 00 00       	call   801ed4 <sys_enable_interrupt>
			return;
  801245:	e9 9a 00 00 00       	jmp    8012e4 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80124a:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80124e:	7e 34                	jle    801284 <atomic_readline+0xa6>
  801250:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801257:	7f 2b                	jg     801284 <atomic_readline+0xa6>
			if (echoing)
  801259:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80125d:	74 0e                	je     80126d <atomic_readline+0x8f>
				cputchar(c);
  80125f:	83 ec 0c             	sub    $0xc,%esp
  801262:	ff 75 ec             	pushl  -0x14(%ebp)
  801265:	e8 9e f3 ff ff       	call   800608 <cputchar>
  80126a:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80126d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801270:	8d 50 01             	lea    0x1(%eax),%edx
  801273:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801276:	89 c2                	mov    %eax,%edx
  801278:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127b:	01 d0                	add    %edx,%eax
  80127d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801280:	88 10                	mov    %dl,(%eax)
  801282:	eb 5b                	jmp    8012df <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801284:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801288:	75 1f                	jne    8012a9 <atomic_readline+0xcb>
  80128a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80128e:	7e 19                	jle    8012a9 <atomic_readline+0xcb>
			if (echoing)
  801290:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801294:	74 0e                	je     8012a4 <atomic_readline+0xc6>
				cputchar(c);
  801296:	83 ec 0c             	sub    $0xc,%esp
  801299:	ff 75 ec             	pushl  -0x14(%ebp)
  80129c:	e8 67 f3 ff ff       	call   800608 <cputchar>
  8012a1:	83 c4 10             	add    $0x10,%esp
			i--;
  8012a4:	ff 4d f4             	decl   -0xc(%ebp)
  8012a7:	eb 36                	jmp    8012df <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012a9:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012ad:	74 0a                	je     8012b9 <atomic_readline+0xdb>
  8012af:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012b3:	0f 85 60 ff ff ff    	jne    801219 <atomic_readline+0x3b>
			if (echoing)
  8012b9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012bd:	74 0e                	je     8012cd <atomic_readline+0xef>
				cputchar(c);
  8012bf:	83 ec 0c             	sub    $0xc,%esp
  8012c2:	ff 75 ec             	pushl  -0x14(%ebp)
  8012c5:	e8 3e f3 ff ff       	call   800608 <cputchar>
  8012ca:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8012cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d3:	01 d0                	add    %edx,%eax
  8012d5:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8012d8:	e8 f7 0b 00 00       	call   801ed4 <sys_enable_interrupt>
			return;
  8012dd:	eb 05                	jmp    8012e4 <atomic_readline+0x106>
		}
	}
  8012df:	e9 35 ff ff ff       	jmp    801219 <atomic_readline+0x3b>
}
  8012e4:	c9                   	leave  
  8012e5:	c3                   	ret    

008012e6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012e6:	55                   	push   %ebp
  8012e7:	89 e5                	mov    %esp,%ebp
  8012e9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012f3:	eb 06                	jmp    8012fb <strlen+0x15>
		n++;
  8012f5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012f8:	ff 45 08             	incl   0x8(%ebp)
  8012fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fe:	8a 00                	mov    (%eax),%al
  801300:	84 c0                	test   %al,%al
  801302:	75 f1                	jne    8012f5 <strlen+0xf>
		n++;
	return n;
  801304:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801307:	c9                   	leave  
  801308:	c3                   	ret    

00801309 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801309:	55                   	push   %ebp
  80130a:	89 e5                	mov    %esp,%ebp
  80130c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80130f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801316:	eb 09                	jmp    801321 <strnlen+0x18>
		n++;
  801318:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80131b:	ff 45 08             	incl   0x8(%ebp)
  80131e:	ff 4d 0c             	decl   0xc(%ebp)
  801321:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801325:	74 09                	je     801330 <strnlen+0x27>
  801327:	8b 45 08             	mov    0x8(%ebp),%eax
  80132a:	8a 00                	mov    (%eax),%al
  80132c:	84 c0                	test   %al,%al
  80132e:	75 e8                	jne    801318 <strnlen+0xf>
		n++;
	return n;
  801330:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801333:	c9                   	leave  
  801334:	c3                   	ret    

00801335 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801335:	55                   	push   %ebp
  801336:	89 e5                	mov    %esp,%ebp
  801338:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80133b:	8b 45 08             	mov    0x8(%ebp),%eax
  80133e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801341:	90                   	nop
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	8d 50 01             	lea    0x1(%eax),%edx
  801348:	89 55 08             	mov    %edx,0x8(%ebp)
  80134b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801351:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801354:	8a 12                	mov    (%edx),%dl
  801356:	88 10                	mov    %dl,(%eax)
  801358:	8a 00                	mov    (%eax),%al
  80135a:	84 c0                	test   %al,%al
  80135c:	75 e4                	jne    801342 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80135e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801361:	c9                   	leave  
  801362:	c3                   	ret    

00801363 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801363:	55                   	push   %ebp
  801364:	89 e5                	mov    %esp,%ebp
  801366:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801369:	8b 45 08             	mov    0x8(%ebp),%eax
  80136c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80136f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801376:	eb 1f                	jmp    801397 <strncpy+0x34>
		*dst++ = *src;
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	8d 50 01             	lea    0x1(%eax),%edx
  80137e:	89 55 08             	mov    %edx,0x8(%ebp)
  801381:	8b 55 0c             	mov    0xc(%ebp),%edx
  801384:	8a 12                	mov    (%edx),%dl
  801386:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801388:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138b:	8a 00                	mov    (%eax),%al
  80138d:	84 c0                	test   %al,%al
  80138f:	74 03                	je     801394 <strncpy+0x31>
			src++;
  801391:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801394:	ff 45 fc             	incl   -0x4(%ebp)
  801397:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80139a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80139d:	72 d9                	jb     801378 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80139f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013a2:	c9                   	leave  
  8013a3:	c3                   	ret    

008013a4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013a4:	55                   	push   %ebp
  8013a5:	89 e5                	mov    %esp,%ebp
  8013a7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013b0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013b4:	74 30                	je     8013e6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013b6:	eb 16                	jmp    8013ce <strlcpy+0x2a>
			*dst++ = *src++;
  8013b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bb:	8d 50 01             	lea    0x1(%eax),%edx
  8013be:	89 55 08             	mov    %edx,0x8(%ebp)
  8013c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013c7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013ca:	8a 12                	mov    (%edx),%dl
  8013cc:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013ce:	ff 4d 10             	decl   0x10(%ebp)
  8013d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d5:	74 09                	je     8013e0 <strlcpy+0x3c>
  8013d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013da:	8a 00                	mov    (%eax),%al
  8013dc:	84 c0                	test   %al,%al
  8013de:	75 d8                	jne    8013b8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013e6:	8b 55 08             	mov    0x8(%ebp),%edx
  8013e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ec:	29 c2                	sub    %eax,%edx
  8013ee:	89 d0                	mov    %edx,%eax
}
  8013f0:	c9                   	leave  
  8013f1:	c3                   	ret    

008013f2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013f2:	55                   	push   %ebp
  8013f3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013f5:	eb 06                	jmp    8013fd <strcmp+0xb>
		p++, q++;
  8013f7:	ff 45 08             	incl   0x8(%ebp)
  8013fa:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	8a 00                	mov    (%eax),%al
  801402:	84 c0                	test   %al,%al
  801404:	74 0e                	je     801414 <strcmp+0x22>
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	8a 10                	mov    (%eax),%dl
  80140b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140e:	8a 00                	mov    (%eax),%al
  801410:	38 c2                	cmp    %al,%dl
  801412:	74 e3                	je     8013f7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801414:	8b 45 08             	mov    0x8(%ebp),%eax
  801417:	8a 00                	mov    (%eax),%al
  801419:	0f b6 d0             	movzbl %al,%edx
  80141c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141f:	8a 00                	mov    (%eax),%al
  801421:	0f b6 c0             	movzbl %al,%eax
  801424:	29 c2                	sub    %eax,%edx
  801426:	89 d0                	mov    %edx,%eax
}
  801428:	5d                   	pop    %ebp
  801429:	c3                   	ret    

0080142a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80142a:	55                   	push   %ebp
  80142b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80142d:	eb 09                	jmp    801438 <strncmp+0xe>
		n--, p++, q++;
  80142f:	ff 4d 10             	decl   0x10(%ebp)
  801432:	ff 45 08             	incl   0x8(%ebp)
  801435:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801438:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80143c:	74 17                	je     801455 <strncmp+0x2b>
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	8a 00                	mov    (%eax),%al
  801443:	84 c0                	test   %al,%al
  801445:	74 0e                	je     801455 <strncmp+0x2b>
  801447:	8b 45 08             	mov    0x8(%ebp),%eax
  80144a:	8a 10                	mov    (%eax),%dl
  80144c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80144f:	8a 00                	mov    (%eax),%al
  801451:	38 c2                	cmp    %al,%dl
  801453:	74 da                	je     80142f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801455:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801459:	75 07                	jne    801462 <strncmp+0x38>
		return 0;
  80145b:	b8 00 00 00 00       	mov    $0x0,%eax
  801460:	eb 14                	jmp    801476 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	8a 00                	mov    (%eax),%al
  801467:	0f b6 d0             	movzbl %al,%edx
  80146a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146d:	8a 00                	mov    (%eax),%al
  80146f:	0f b6 c0             	movzbl %al,%eax
  801472:	29 c2                	sub    %eax,%edx
  801474:	89 d0                	mov    %edx,%eax
}
  801476:	5d                   	pop    %ebp
  801477:	c3                   	ret    

00801478 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801478:	55                   	push   %ebp
  801479:	89 e5                	mov    %esp,%ebp
  80147b:	83 ec 04             	sub    $0x4,%esp
  80147e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801481:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801484:	eb 12                	jmp    801498 <strchr+0x20>
		if (*s == c)
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	8a 00                	mov    (%eax),%al
  80148b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80148e:	75 05                	jne    801495 <strchr+0x1d>
			return (char *) s;
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	eb 11                	jmp    8014a6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801495:	ff 45 08             	incl   0x8(%ebp)
  801498:	8b 45 08             	mov    0x8(%ebp),%eax
  80149b:	8a 00                	mov    (%eax),%al
  80149d:	84 c0                	test   %al,%al
  80149f:	75 e5                	jne    801486 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014a6:	c9                   	leave  
  8014a7:	c3                   	ret    

008014a8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014a8:	55                   	push   %ebp
  8014a9:	89 e5                	mov    %esp,%ebp
  8014ab:	83 ec 04             	sub    $0x4,%esp
  8014ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014b4:	eb 0d                	jmp    8014c3 <strfind+0x1b>
		if (*s == c)
  8014b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b9:	8a 00                	mov    (%eax),%al
  8014bb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014be:	74 0e                	je     8014ce <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014c0:	ff 45 08             	incl   0x8(%ebp)
  8014c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c6:	8a 00                	mov    (%eax),%al
  8014c8:	84 c0                	test   %al,%al
  8014ca:	75 ea                	jne    8014b6 <strfind+0xe>
  8014cc:	eb 01                	jmp    8014cf <strfind+0x27>
		if (*s == c)
			break;
  8014ce:	90                   	nop
	return (char *) s;
  8014cf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014d2:	c9                   	leave  
  8014d3:	c3                   	ret    

008014d4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014d4:	55                   	push   %ebp
  8014d5:	89 e5                	mov    %esp,%ebp
  8014d7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014da:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014e6:	eb 0e                	jmp    8014f6 <memset+0x22>
		*p++ = c;
  8014e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014eb:	8d 50 01             	lea    0x1(%eax),%edx
  8014ee:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f4:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014f6:	ff 4d f8             	decl   -0x8(%ebp)
  8014f9:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014fd:	79 e9                	jns    8014e8 <memset+0x14>
		*p++ = c;

	return v;
  8014ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801502:	c9                   	leave  
  801503:	c3                   	ret    

00801504 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
  801507:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80150a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801510:	8b 45 08             	mov    0x8(%ebp),%eax
  801513:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801516:	eb 16                	jmp    80152e <memcpy+0x2a>
		*d++ = *s++;
  801518:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80151b:	8d 50 01             	lea    0x1(%eax),%edx
  80151e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801521:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801524:	8d 4a 01             	lea    0x1(%edx),%ecx
  801527:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80152a:	8a 12                	mov    (%edx),%dl
  80152c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80152e:	8b 45 10             	mov    0x10(%ebp),%eax
  801531:	8d 50 ff             	lea    -0x1(%eax),%edx
  801534:	89 55 10             	mov    %edx,0x10(%ebp)
  801537:	85 c0                	test   %eax,%eax
  801539:	75 dd                	jne    801518 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80153b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80153e:	c9                   	leave  
  80153f:	c3                   	ret    

00801540 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801540:	55                   	push   %ebp
  801541:	89 e5                	mov    %esp,%ebp
  801543:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801546:	8b 45 0c             	mov    0xc(%ebp),%eax
  801549:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
  80154f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801552:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801555:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801558:	73 50                	jae    8015aa <memmove+0x6a>
  80155a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80155d:	8b 45 10             	mov    0x10(%ebp),%eax
  801560:	01 d0                	add    %edx,%eax
  801562:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801565:	76 43                	jbe    8015aa <memmove+0x6a>
		s += n;
  801567:	8b 45 10             	mov    0x10(%ebp),%eax
  80156a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80156d:	8b 45 10             	mov    0x10(%ebp),%eax
  801570:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801573:	eb 10                	jmp    801585 <memmove+0x45>
			*--d = *--s;
  801575:	ff 4d f8             	decl   -0x8(%ebp)
  801578:	ff 4d fc             	decl   -0x4(%ebp)
  80157b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80157e:	8a 10                	mov    (%eax),%dl
  801580:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801583:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801585:	8b 45 10             	mov    0x10(%ebp),%eax
  801588:	8d 50 ff             	lea    -0x1(%eax),%edx
  80158b:	89 55 10             	mov    %edx,0x10(%ebp)
  80158e:	85 c0                	test   %eax,%eax
  801590:	75 e3                	jne    801575 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801592:	eb 23                	jmp    8015b7 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801594:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801597:	8d 50 01             	lea    0x1(%eax),%edx
  80159a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80159d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015a0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015a3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015a6:	8a 12                	mov    (%edx),%dl
  8015a8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ad:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015b0:	89 55 10             	mov    %edx,0x10(%ebp)
  8015b3:	85 c0                	test   %eax,%eax
  8015b5:	75 dd                	jne    801594 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
  8015bf:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015cb:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015ce:	eb 2a                	jmp    8015fa <memcmp+0x3e>
		if (*s1 != *s2)
  8015d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d3:	8a 10                	mov    (%eax),%dl
  8015d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d8:	8a 00                	mov    (%eax),%al
  8015da:	38 c2                	cmp    %al,%dl
  8015dc:	74 16                	je     8015f4 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015de:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e1:	8a 00                	mov    (%eax),%al
  8015e3:	0f b6 d0             	movzbl %al,%edx
  8015e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e9:	8a 00                	mov    (%eax),%al
  8015eb:	0f b6 c0             	movzbl %al,%eax
  8015ee:	29 c2                	sub    %eax,%edx
  8015f0:	89 d0                	mov    %edx,%eax
  8015f2:	eb 18                	jmp    80160c <memcmp+0x50>
		s1++, s2++;
  8015f4:	ff 45 fc             	incl   -0x4(%ebp)
  8015f7:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8015fd:	8d 50 ff             	lea    -0x1(%eax),%edx
  801600:	89 55 10             	mov    %edx,0x10(%ebp)
  801603:	85 c0                	test   %eax,%eax
  801605:	75 c9                	jne    8015d0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801607:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80160c:	c9                   	leave  
  80160d:	c3                   	ret    

0080160e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80160e:	55                   	push   %ebp
  80160f:	89 e5                	mov    %esp,%ebp
  801611:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801614:	8b 55 08             	mov    0x8(%ebp),%edx
  801617:	8b 45 10             	mov    0x10(%ebp),%eax
  80161a:	01 d0                	add    %edx,%eax
  80161c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80161f:	eb 15                	jmp    801636 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801621:	8b 45 08             	mov    0x8(%ebp),%eax
  801624:	8a 00                	mov    (%eax),%al
  801626:	0f b6 d0             	movzbl %al,%edx
  801629:	8b 45 0c             	mov    0xc(%ebp),%eax
  80162c:	0f b6 c0             	movzbl %al,%eax
  80162f:	39 c2                	cmp    %eax,%edx
  801631:	74 0d                	je     801640 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801633:	ff 45 08             	incl   0x8(%ebp)
  801636:	8b 45 08             	mov    0x8(%ebp),%eax
  801639:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80163c:	72 e3                	jb     801621 <memfind+0x13>
  80163e:	eb 01                	jmp    801641 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801640:	90                   	nop
	return (void *) s;
  801641:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
  801649:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80164c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801653:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80165a:	eb 03                	jmp    80165f <strtol+0x19>
		s++;
  80165c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	8a 00                	mov    (%eax),%al
  801664:	3c 20                	cmp    $0x20,%al
  801666:	74 f4                	je     80165c <strtol+0x16>
  801668:	8b 45 08             	mov    0x8(%ebp),%eax
  80166b:	8a 00                	mov    (%eax),%al
  80166d:	3c 09                	cmp    $0x9,%al
  80166f:	74 eb                	je     80165c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	3c 2b                	cmp    $0x2b,%al
  801678:	75 05                	jne    80167f <strtol+0x39>
		s++;
  80167a:	ff 45 08             	incl   0x8(%ebp)
  80167d:	eb 13                	jmp    801692 <strtol+0x4c>
	else if (*s == '-')
  80167f:	8b 45 08             	mov    0x8(%ebp),%eax
  801682:	8a 00                	mov    (%eax),%al
  801684:	3c 2d                	cmp    $0x2d,%al
  801686:	75 0a                	jne    801692 <strtol+0x4c>
		s++, neg = 1;
  801688:	ff 45 08             	incl   0x8(%ebp)
  80168b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801692:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801696:	74 06                	je     80169e <strtol+0x58>
  801698:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80169c:	75 20                	jne    8016be <strtol+0x78>
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	8a 00                	mov    (%eax),%al
  8016a3:	3c 30                	cmp    $0x30,%al
  8016a5:	75 17                	jne    8016be <strtol+0x78>
  8016a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016aa:	40                   	inc    %eax
  8016ab:	8a 00                	mov    (%eax),%al
  8016ad:	3c 78                	cmp    $0x78,%al
  8016af:	75 0d                	jne    8016be <strtol+0x78>
		s += 2, base = 16;
  8016b1:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016b5:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016bc:	eb 28                	jmp    8016e6 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016c2:	75 15                	jne    8016d9 <strtol+0x93>
  8016c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c7:	8a 00                	mov    (%eax),%al
  8016c9:	3c 30                	cmp    $0x30,%al
  8016cb:	75 0c                	jne    8016d9 <strtol+0x93>
		s++, base = 8;
  8016cd:	ff 45 08             	incl   0x8(%ebp)
  8016d0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016d7:	eb 0d                	jmp    8016e6 <strtol+0xa0>
	else if (base == 0)
  8016d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016dd:	75 07                	jne    8016e6 <strtol+0xa0>
		base = 10;
  8016df:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	8a 00                	mov    (%eax),%al
  8016eb:	3c 2f                	cmp    $0x2f,%al
  8016ed:	7e 19                	jle    801708 <strtol+0xc2>
  8016ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f2:	8a 00                	mov    (%eax),%al
  8016f4:	3c 39                	cmp    $0x39,%al
  8016f6:	7f 10                	jg     801708 <strtol+0xc2>
			dig = *s - '0';
  8016f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fb:	8a 00                	mov    (%eax),%al
  8016fd:	0f be c0             	movsbl %al,%eax
  801700:	83 e8 30             	sub    $0x30,%eax
  801703:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801706:	eb 42                	jmp    80174a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801708:	8b 45 08             	mov    0x8(%ebp),%eax
  80170b:	8a 00                	mov    (%eax),%al
  80170d:	3c 60                	cmp    $0x60,%al
  80170f:	7e 19                	jle    80172a <strtol+0xe4>
  801711:	8b 45 08             	mov    0x8(%ebp),%eax
  801714:	8a 00                	mov    (%eax),%al
  801716:	3c 7a                	cmp    $0x7a,%al
  801718:	7f 10                	jg     80172a <strtol+0xe4>
			dig = *s - 'a' + 10;
  80171a:	8b 45 08             	mov    0x8(%ebp),%eax
  80171d:	8a 00                	mov    (%eax),%al
  80171f:	0f be c0             	movsbl %al,%eax
  801722:	83 e8 57             	sub    $0x57,%eax
  801725:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801728:	eb 20                	jmp    80174a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80172a:	8b 45 08             	mov    0x8(%ebp),%eax
  80172d:	8a 00                	mov    (%eax),%al
  80172f:	3c 40                	cmp    $0x40,%al
  801731:	7e 39                	jle    80176c <strtol+0x126>
  801733:	8b 45 08             	mov    0x8(%ebp),%eax
  801736:	8a 00                	mov    (%eax),%al
  801738:	3c 5a                	cmp    $0x5a,%al
  80173a:	7f 30                	jg     80176c <strtol+0x126>
			dig = *s - 'A' + 10;
  80173c:	8b 45 08             	mov    0x8(%ebp),%eax
  80173f:	8a 00                	mov    (%eax),%al
  801741:	0f be c0             	movsbl %al,%eax
  801744:	83 e8 37             	sub    $0x37,%eax
  801747:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80174a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80174d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801750:	7d 19                	jge    80176b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801752:	ff 45 08             	incl   0x8(%ebp)
  801755:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801758:	0f af 45 10          	imul   0x10(%ebp),%eax
  80175c:	89 c2                	mov    %eax,%edx
  80175e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801761:	01 d0                	add    %edx,%eax
  801763:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801766:	e9 7b ff ff ff       	jmp    8016e6 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80176b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80176c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801770:	74 08                	je     80177a <strtol+0x134>
		*endptr = (char *) s;
  801772:	8b 45 0c             	mov    0xc(%ebp),%eax
  801775:	8b 55 08             	mov    0x8(%ebp),%edx
  801778:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80177a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80177e:	74 07                	je     801787 <strtol+0x141>
  801780:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801783:	f7 d8                	neg    %eax
  801785:	eb 03                	jmp    80178a <strtol+0x144>
  801787:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <ltostr>:

void
ltostr(long value, char *str)
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
  80178f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801792:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801799:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017a0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017a4:	79 13                	jns    8017b9 <ltostr+0x2d>
	{
		neg = 1;
  8017a6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b0:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017b3:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017b6:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017c1:	99                   	cltd   
  8017c2:	f7 f9                	idiv   %ecx
  8017c4:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ca:	8d 50 01             	lea    0x1(%eax),%edx
  8017cd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017d0:	89 c2                	mov    %eax,%edx
  8017d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d5:	01 d0                	add    %edx,%eax
  8017d7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017da:	83 c2 30             	add    $0x30,%edx
  8017dd:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017df:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017e2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017e7:	f7 e9                	imul   %ecx
  8017e9:	c1 fa 02             	sar    $0x2,%edx
  8017ec:	89 c8                	mov    %ecx,%eax
  8017ee:	c1 f8 1f             	sar    $0x1f,%eax
  8017f1:	29 c2                	sub    %eax,%edx
  8017f3:	89 d0                	mov    %edx,%eax
  8017f5:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017f8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017fb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801800:	f7 e9                	imul   %ecx
  801802:	c1 fa 02             	sar    $0x2,%edx
  801805:	89 c8                	mov    %ecx,%eax
  801807:	c1 f8 1f             	sar    $0x1f,%eax
  80180a:	29 c2                	sub    %eax,%edx
  80180c:	89 d0                	mov    %edx,%eax
  80180e:	c1 e0 02             	shl    $0x2,%eax
  801811:	01 d0                	add    %edx,%eax
  801813:	01 c0                	add    %eax,%eax
  801815:	29 c1                	sub    %eax,%ecx
  801817:	89 ca                	mov    %ecx,%edx
  801819:	85 d2                	test   %edx,%edx
  80181b:	75 9c                	jne    8017b9 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80181d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801824:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801827:	48                   	dec    %eax
  801828:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80182b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80182f:	74 3d                	je     80186e <ltostr+0xe2>
		start = 1 ;
  801831:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801838:	eb 34                	jmp    80186e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80183a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80183d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801840:	01 d0                	add    %edx,%eax
  801842:	8a 00                	mov    (%eax),%al
  801844:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801847:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80184a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184d:	01 c2                	add    %eax,%edx
  80184f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801852:	8b 45 0c             	mov    0xc(%ebp),%eax
  801855:	01 c8                	add    %ecx,%eax
  801857:	8a 00                	mov    (%eax),%al
  801859:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80185b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80185e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801861:	01 c2                	add    %eax,%edx
  801863:	8a 45 eb             	mov    -0x15(%ebp),%al
  801866:	88 02                	mov    %al,(%edx)
		start++ ;
  801868:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80186b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80186e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801871:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801874:	7c c4                	jl     80183a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801876:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801879:	8b 45 0c             	mov    0xc(%ebp),%eax
  80187c:	01 d0                	add    %edx,%eax
  80187e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801881:	90                   	nop
  801882:	c9                   	leave  
  801883:	c3                   	ret    

00801884 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801884:	55                   	push   %ebp
  801885:	89 e5                	mov    %esp,%ebp
  801887:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80188a:	ff 75 08             	pushl  0x8(%ebp)
  80188d:	e8 54 fa ff ff       	call   8012e6 <strlen>
  801892:	83 c4 04             	add    $0x4,%esp
  801895:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801898:	ff 75 0c             	pushl  0xc(%ebp)
  80189b:	e8 46 fa ff ff       	call   8012e6 <strlen>
  8018a0:	83 c4 04             	add    $0x4,%esp
  8018a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018b4:	eb 17                	jmp    8018cd <strcconcat+0x49>
		final[s] = str1[s] ;
  8018b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018bc:	01 c2                	add    %eax,%edx
  8018be:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c4:	01 c8                	add    %ecx,%eax
  8018c6:	8a 00                	mov    (%eax),%al
  8018c8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8018ca:	ff 45 fc             	incl   -0x4(%ebp)
  8018cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018d0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018d3:	7c e1                	jl     8018b6 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018d5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018e3:	eb 1f                	jmp    801904 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018e8:	8d 50 01             	lea    0x1(%eax),%edx
  8018eb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018ee:	89 c2                	mov    %eax,%edx
  8018f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f3:	01 c2                	add    %eax,%edx
  8018f5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018fb:	01 c8                	add    %ecx,%eax
  8018fd:	8a 00                	mov    (%eax),%al
  8018ff:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801901:	ff 45 f8             	incl   -0x8(%ebp)
  801904:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801907:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80190a:	7c d9                	jl     8018e5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80190c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80190f:	8b 45 10             	mov    0x10(%ebp),%eax
  801912:	01 d0                	add    %edx,%eax
  801914:	c6 00 00             	movb   $0x0,(%eax)
}
  801917:	90                   	nop
  801918:	c9                   	leave  
  801919:	c3                   	ret    

0080191a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80191a:	55                   	push   %ebp
  80191b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80191d:	8b 45 14             	mov    0x14(%ebp),%eax
  801920:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801926:	8b 45 14             	mov    0x14(%ebp),%eax
  801929:	8b 00                	mov    (%eax),%eax
  80192b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801932:	8b 45 10             	mov    0x10(%ebp),%eax
  801935:	01 d0                	add    %edx,%eax
  801937:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80193d:	eb 0c                	jmp    80194b <strsplit+0x31>
			*string++ = 0;
  80193f:	8b 45 08             	mov    0x8(%ebp),%eax
  801942:	8d 50 01             	lea    0x1(%eax),%edx
  801945:	89 55 08             	mov    %edx,0x8(%ebp)
  801948:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80194b:	8b 45 08             	mov    0x8(%ebp),%eax
  80194e:	8a 00                	mov    (%eax),%al
  801950:	84 c0                	test   %al,%al
  801952:	74 18                	je     80196c <strsplit+0x52>
  801954:	8b 45 08             	mov    0x8(%ebp),%eax
  801957:	8a 00                	mov    (%eax),%al
  801959:	0f be c0             	movsbl %al,%eax
  80195c:	50                   	push   %eax
  80195d:	ff 75 0c             	pushl  0xc(%ebp)
  801960:	e8 13 fb ff ff       	call   801478 <strchr>
  801965:	83 c4 08             	add    $0x8,%esp
  801968:	85 c0                	test   %eax,%eax
  80196a:	75 d3                	jne    80193f <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80196c:	8b 45 08             	mov    0x8(%ebp),%eax
  80196f:	8a 00                	mov    (%eax),%al
  801971:	84 c0                	test   %al,%al
  801973:	74 5a                	je     8019cf <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801975:	8b 45 14             	mov    0x14(%ebp),%eax
  801978:	8b 00                	mov    (%eax),%eax
  80197a:	83 f8 0f             	cmp    $0xf,%eax
  80197d:	75 07                	jne    801986 <strsplit+0x6c>
		{
			return 0;
  80197f:	b8 00 00 00 00       	mov    $0x0,%eax
  801984:	eb 66                	jmp    8019ec <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801986:	8b 45 14             	mov    0x14(%ebp),%eax
  801989:	8b 00                	mov    (%eax),%eax
  80198b:	8d 48 01             	lea    0x1(%eax),%ecx
  80198e:	8b 55 14             	mov    0x14(%ebp),%edx
  801991:	89 0a                	mov    %ecx,(%edx)
  801993:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80199a:	8b 45 10             	mov    0x10(%ebp),%eax
  80199d:	01 c2                	add    %eax,%edx
  80199f:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019a4:	eb 03                	jmp    8019a9 <strsplit+0x8f>
			string++;
  8019a6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ac:	8a 00                	mov    (%eax),%al
  8019ae:	84 c0                	test   %al,%al
  8019b0:	74 8b                	je     80193d <strsplit+0x23>
  8019b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b5:	8a 00                	mov    (%eax),%al
  8019b7:	0f be c0             	movsbl %al,%eax
  8019ba:	50                   	push   %eax
  8019bb:	ff 75 0c             	pushl  0xc(%ebp)
  8019be:	e8 b5 fa ff ff       	call   801478 <strchr>
  8019c3:	83 c4 08             	add    $0x8,%esp
  8019c6:	85 c0                	test   %eax,%eax
  8019c8:	74 dc                	je     8019a6 <strsplit+0x8c>
			string++;
	}
  8019ca:	e9 6e ff ff ff       	jmp    80193d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019cf:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8019d3:	8b 00                	mov    (%eax),%eax
  8019d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8019df:	01 d0                	add    %edx,%eax
  8019e1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019e7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019ec:	c9                   	leave  
  8019ed:	c3                   	ret    

008019ee <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8019ee:	55                   	push   %ebp
  8019ef:	89 e5                	mov    %esp,%ebp
  8019f1:	83 ec 18             	sub    $0x18,%esp
  8019f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f7:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8019fa:	83 ec 04             	sub    $0x4,%esp
  8019fd:	68 e4 2b 80 00       	push   $0x802be4
  801a02:	6a 17                	push   $0x17
  801a04:	68 03 2c 80 00       	push   $0x802c03
  801a09:	e8 9c ed ff ff       	call   8007aa <_panic>

00801a0e <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a0e:	55                   	push   %ebp
  801a0f:	89 e5                	mov    %esp,%ebp
  801a11:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801a14:	83 ec 04             	sub    $0x4,%esp
  801a17:	68 0f 2c 80 00       	push   $0x802c0f
  801a1c:	6a 2f                	push   $0x2f
  801a1e:	68 03 2c 80 00       	push   $0x802c03
  801a23:	e8 82 ed ff ff       	call   8007aa <_panic>

00801a28 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801a28:	55                   	push   %ebp
  801a29:	89 e5                	mov    %esp,%ebp
  801a2b:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801a2e:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801a35:	8b 55 08             	mov    0x8(%ebp),%edx
  801a38:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a3b:	01 d0                	add    %edx,%eax
  801a3d:	48                   	dec    %eax
  801a3e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801a41:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a44:	ba 00 00 00 00       	mov    $0x0,%edx
  801a49:	f7 75 ec             	divl   -0x14(%ebp)
  801a4c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a4f:	29 d0                	sub    %edx,%eax
  801a51:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801a54:	8b 45 08             	mov    0x8(%ebp),%eax
  801a57:	c1 e8 0c             	shr    $0xc,%eax
  801a5a:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801a5d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801a64:	e9 c8 00 00 00       	jmp    801b31 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801a69:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a70:	eb 27                	jmp    801a99 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801a72:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a75:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a78:	01 c2                	add    %eax,%edx
  801a7a:	89 d0                	mov    %edx,%eax
  801a7c:	01 c0                	add    %eax,%eax
  801a7e:	01 d0                	add    %edx,%eax
  801a80:	c1 e0 02             	shl    $0x2,%eax
  801a83:	05 48 30 80 00       	add    $0x803048,%eax
  801a88:	8b 00                	mov    (%eax),%eax
  801a8a:	85 c0                	test   %eax,%eax
  801a8c:	74 08                	je     801a96 <malloc+0x6e>
            	i += j;
  801a8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a91:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801a94:	eb 0b                	jmp    801aa1 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801a96:	ff 45 f0             	incl   -0x10(%ebp)
  801a99:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a9c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a9f:	72 d1                	jb     801a72 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801aa1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801aa4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801aa7:	0f 85 81 00 00 00    	jne    801b2e <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ab0:	05 00 00 08 00       	add    $0x80000,%eax
  801ab5:	c1 e0 0c             	shl    $0xc,%eax
  801ab8:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801abb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ac2:	eb 1f                	jmp    801ae3 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801ac4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801aca:	01 c2                	add    %eax,%edx
  801acc:	89 d0                	mov    %edx,%eax
  801ace:	01 c0                	add    %eax,%eax
  801ad0:	01 d0                	add    %edx,%eax
  801ad2:	c1 e0 02             	shl    $0x2,%eax
  801ad5:	05 48 30 80 00       	add    $0x803048,%eax
  801ada:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801ae0:	ff 45 f0             	incl   -0x10(%ebp)
  801ae3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ae6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801ae9:	72 d9                	jb     801ac4 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801aeb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801aee:	89 d0                	mov    %edx,%eax
  801af0:	01 c0                	add    %eax,%eax
  801af2:	01 d0                	add    %edx,%eax
  801af4:	c1 e0 02             	shl    $0x2,%eax
  801af7:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801afd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b00:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801b02:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801b05:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801b08:	89 c8                	mov    %ecx,%eax
  801b0a:	01 c0                	add    %eax,%eax
  801b0c:	01 c8                	add    %ecx,%eax
  801b0e:	c1 e0 02             	shl    $0x2,%eax
  801b11:	05 44 30 80 00       	add    $0x803044,%eax
  801b16:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801b18:	83 ec 08             	sub    $0x8,%esp
  801b1b:	ff 75 08             	pushl  0x8(%ebp)
  801b1e:	ff 75 e0             	pushl  -0x20(%ebp)
  801b21:	e8 2b 03 00 00       	call   801e51 <sys_allocateMem>
  801b26:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801b29:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b2c:	eb 19                	jmp    801b47 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801b2e:	ff 45 f4             	incl   -0xc(%ebp)
  801b31:	a1 04 30 80 00       	mov    0x803004,%eax
  801b36:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801b39:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b3c:	0f 83 27 ff ff ff    	jae    801a69 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801b42:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b47:	c9                   	leave  
  801b48:	c3                   	ret    

00801b49 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801b49:	55                   	push   %ebp
  801b4a:	89 e5                	mov    %esp,%ebp
  801b4c:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801b4f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801b53:	0f 84 e5 00 00 00    	je     801c3e <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801b59:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801b5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b62:	05 00 00 00 80       	add    $0x80000000,%eax
  801b67:	c1 e8 0c             	shr    $0xc,%eax
  801b6a:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801b6d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b70:	89 d0                	mov    %edx,%eax
  801b72:	01 c0                	add    %eax,%eax
  801b74:	01 d0                	add    %edx,%eax
  801b76:	c1 e0 02             	shl    $0x2,%eax
  801b79:	05 40 30 80 00       	add    $0x803040,%eax
  801b7e:	8b 00                	mov    (%eax),%eax
  801b80:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b83:	0f 85 b8 00 00 00    	jne    801c41 <free+0xf8>
  801b89:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b8c:	89 d0                	mov    %edx,%eax
  801b8e:	01 c0                	add    %eax,%eax
  801b90:	01 d0                	add    %edx,%eax
  801b92:	c1 e0 02             	shl    $0x2,%eax
  801b95:	05 48 30 80 00       	add    $0x803048,%eax
  801b9a:	8b 00                	mov    (%eax),%eax
  801b9c:	85 c0                	test   %eax,%eax
  801b9e:	0f 84 9d 00 00 00    	je     801c41 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801ba4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ba7:	89 d0                	mov    %edx,%eax
  801ba9:	01 c0                	add    %eax,%eax
  801bab:	01 d0                	add    %edx,%eax
  801bad:	c1 e0 02             	shl    $0x2,%eax
  801bb0:	05 44 30 80 00       	add    $0x803044,%eax
  801bb5:	8b 00                	mov    (%eax),%eax
  801bb7:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801bba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801bbd:	c1 e0 0c             	shl    $0xc,%eax
  801bc0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801bc3:	83 ec 08             	sub    $0x8,%esp
  801bc6:	ff 75 e4             	pushl  -0x1c(%ebp)
  801bc9:	ff 75 f0             	pushl  -0x10(%ebp)
  801bcc:	e8 64 02 00 00       	call   801e35 <sys_freeMem>
  801bd1:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801bd4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801bdb:	eb 57                	jmp    801c34 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801bdd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801be0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801be3:	01 c2                	add    %eax,%edx
  801be5:	89 d0                	mov    %edx,%eax
  801be7:	01 c0                	add    %eax,%eax
  801be9:	01 d0                	add    %edx,%eax
  801beb:	c1 e0 02             	shl    $0x2,%eax
  801bee:	05 48 30 80 00       	add    $0x803048,%eax
  801bf3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801bf9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bff:	01 c2                	add    %eax,%edx
  801c01:	89 d0                	mov    %edx,%eax
  801c03:	01 c0                	add    %eax,%eax
  801c05:	01 d0                	add    %edx,%eax
  801c07:	c1 e0 02             	shl    $0x2,%eax
  801c0a:	05 40 30 80 00       	add    $0x803040,%eax
  801c0f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801c15:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c1b:	01 c2                	add    %eax,%edx
  801c1d:	89 d0                	mov    %edx,%eax
  801c1f:	01 c0                	add    %eax,%eax
  801c21:	01 d0                	add    %edx,%eax
  801c23:	c1 e0 02             	shl    $0x2,%eax
  801c26:	05 44 30 80 00       	add    $0x803044,%eax
  801c2b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801c31:	ff 45 f4             	incl   -0xc(%ebp)
  801c34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c37:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c3a:	7c a1                	jl     801bdd <free+0x94>
  801c3c:	eb 04                	jmp    801c42 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801c3e:	90                   	nop
  801c3f:	eb 01                	jmp    801c42 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801c41:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801c42:	c9                   	leave  
  801c43:	c3                   	ret    

00801c44 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801c44:	55                   	push   %ebp
  801c45:	89 e5                	mov    %esp,%ebp
  801c47:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801c4a:	83 ec 04             	sub    $0x4,%esp
  801c4d:	68 2c 2c 80 00       	push   $0x802c2c
  801c52:	68 ae 00 00 00       	push   $0xae
  801c57:	68 03 2c 80 00       	push   $0x802c03
  801c5c:	e8 49 eb ff ff       	call   8007aa <_panic>

00801c61 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801c61:	55                   	push   %ebp
  801c62:	89 e5                	mov    %esp,%ebp
  801c64:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801c67:	83 ec 04             	sub    $0x4,%esp
  801c6a:	68 4c 2c 80 00       	push   $0x802c4c
  801c6f:	68 ca 00 00 00       	push   $0xca
  801c74:	68 03 2c 80 00       	push   $0x802c03
  801c79:	e8 2c eb ff ff       	call   8007aa <_panic>

00801c7e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c7e:	55                   	push   %ebp
  801c7f:	89 e5                	mov    %esp,%ebp
  801c81:	57                   	push   %edi
  801c82:	56                   	push   %esi
  801c83:	53                   	push   %ebx
  801c84:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c87:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c8d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c90:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c93:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c96:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c99:	cd 30                	int    $0x30
  801c9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ca1:	83 c4 10             	add    $0x10,%esp
  801ca4:	5b                   	pop    %ebx
  801ca5:	5e                   	pop    %esi
  801ca6:	5f                   	pop    %edi
  801ca7:	5d                   	pop    %ebp
  801ca8:	c3                   	ret    

00801ca9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801ca9:	55                   	push   %ebp
  801caa:	89 e5                	mov    %esp,%ebp
  801cac:	83 ec 04             	sub    $0x4,%esp
  801caf:	8b 45 10             	mov    0x10(%ebp),%eax
  801cb2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801cb5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	52                   	push   %edx
  801cc1:	ff 75 0c             	pushl  0xc(%ebp)
  801cc4:	50                   	push   %eax
  801cc5:	6a 00                	push   $0x0
  801cc7:	e8 b2 ff ff ff       	call   801c7e <syscall>
  801ccc:	83 c4 18             	add    $0x18,%esp
}
  801ccf:	90                   	nop
  801cd0:	c9                   	leave  
  801cd1:	c3                   	ret    

00801cd2 <sys_cgetc>:

int
sys_cgetc(void)
{
  801cd2:	55                   	push   %ebp
  801cd3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 01                	push   $0x1
  801ce1:	e8 98 ff ff ff       	call   801c7e <syscall>
  801ce6:	83 c4 18             	add    $0x18,%esp
}
  801ce9:	c9                   	leave  
  801cea:	c3                   	ret    

00801ceb <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ceb:	55                   	push   %ebp
  801cec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801cee:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 00                	push   $0x0
  801cf9:	50                   	push   %eax
  801cfa:	6a 05                	push   $0x5
  801cfc:	e8 7d ff ff ff       	call   801c7e <syscall>
  801d01:	83 c4 18             	add    $0x18,%esp
}
  801d04:	c9                   	leave  
  801d05:	c3                   	ret    

00801d06 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801d06:	55                   	push   %ebp
  801d07:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 02                	push   $0x2
  801d15:	e8 64 ff ff ff       	call   801c7e <syscall>
  801d1a:	83 c4 18             	add    $0x18,%esp
}
  801d1d:	c9                   	leave  
  801d1e:	c3                   	ret    

00801d1f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d1f:	55                   	push   %ebp
  801d20:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 03                	push   $0x3
  801d2e:	e8 4b ff ff ff       	call   801c7e <syscall>
  801d33:	83 c4 18             	add    $0x18,%esp
}
  801d36:	c9                   	leave  
  801d37:	c3                   	ret    

00801d38 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d38:	55                   	push   %ebp
  801d39:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 04                	push   $0x4
  801d47:	e8 32 ff ff ff       	call   801c7e <syscall>
  801d4c:	83 c4 18             	add    $0x18,%esp
}
  801d4f:	c9                   	leave  
  801d50:	c3                   	ret    

00801d51 <sys_env_exit>:


void sys_env_exit(void)
{
  801d51:	55                   	push   %ebp
  801d52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d54:	6a 00                	push   $0x0
  801d56:	6a 00                	push   $0x0
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 06                	push   $0x6
  801d60:	e8 19 ff ff ff       	call   801c7e <syscall>
  801d65:	83 c4 18             	add    $0x18,%esp
}
  801d68:	90                   	nop
  801d69:	c9                   	leave  
  801d6a:	c3                   	ret    

00801d6b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d6b:	55                   	push   %ebp
  801d6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d71:	8b 45 08             	mov    0x8(%ebp),%eax
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	52                   	push   %edx
  801d7b:	50                   	push   %eax
  801d7c:	6a 07                	push   $0x7
  801d7e:	e8 fb fe ff ff       	call   801c7e <syscall>
  801d83:	83 c4 18             	add    $0x18,%esp
}
  801d86:	c9                   	leave  
  801d87:	c3                   	ret    

00801d88 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d88:	55                   	push   %ebp
  801d89:	89 e5                	mov    %esp,%ebp
  801d8b:	56                   	push   %esi
  801d8c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d8d:	8b 75 18             	mov    0x18(%ebp),%esi
  801d90:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d93:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d96:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d99:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9c:	56                   	push   %esi
  801d9d:	53                   	push   %ebx
  801d9e:	51                   	push   %ecx
  801d9f:	52                   	push   %edx
  801da0:	50                   	push   %eax
  801da1:	6a 08                	push   $0x8
  801da3:	e8 d6 fe ff ff       	call   801c7e <syscall>
  801da8:	83 c4 18             	add    $0x18,%esp
}
  801dab:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801dae:	5b                   	pop    %ebx
  801daf:	5e                   	pop    %esi
  801db0:	5d                   	pop    %ebp
  801db1:	c3                   	ret    

00801db2 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801db2:	55                   	push   %ebp
  801db3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801db5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db8:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	52                   	push   %edx
  801dc2:	50                   	push   %eax
  801dc3:	6a 09                	push   $0x9
  801dc5:	e8 b4 fe ff ff       	call   801c7e <syscall>
  801dca:	83 c4 18             	add    $0x18,%esp
}
  801dcd:	c9                   	leave  
  801dce:	c3                   	ret    

00801dcf <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801dcf:	55                   	push   %ebp
  801dd0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	ff 75 0c             	pushl  0xc(%ebp)
  801ddb:	ff 75 08             	pushl  0x8(%ebp)
  801dde:	6a 0a                	push   $0xa
  801de0:	e8 99 fe ff ff       	call   801c7e <syscall>
  801de5:	83 c4 18             	add    $0x18,%esp
}
  801de8:	c9                   	leave  
  801de9:	c3                   	ret    

00801dea <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801dea:	55                   	push   %ebp
  801deb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 0b                	push   $0xb
  801df9:	e8 80 fe ff ff       	call   801c7e <syscall>
  801dfe:	83 c4 18             	add    $0x18,%esp
}
  801e01:	c9                   	leave  
  801e02:	c3                   	ret    

00801e03 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e03:	55                   	push   %ebp
  801e04:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e06:	6a 00                	push   $0x0
  801e08:	6a 00                	push   $0x0
  801e0a:	6a 00                	push   $0x0
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 0c                	push   $0xc
  801e12:	e8 67 fe ff ff       	call   801c7e <syscall>
  801e17:	83 c4 18             	add    $0x18,%esp
}
  801e1a:	c9                   	leave  
  801e1b:	c3                   	ret    

00801e1c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e1c:	55                   	push   %ebp
  801e1d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 0d                	push   $0xd
  801e2b:	e8 4e fe ff ff       	call   801c7e <syscall>
  801e30:	83 c4 18             	add    $0x18,%esp
}
  801e33:	c9                   	leave  
  801e34:	c3                   	ret    

00801e35 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e35:	55                   	push   %ebp
  801e36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	ff 75 0c             	pushl  0xc(%ebp)
  801e41:	ff 75 08             	pushl  0x8(%ebp)
  801e44:	6a 11                	push   $0x11
  801e46:	e8 33 fe ff ff       	call   801c7e <syscall>
  801e4b:	83 c4 18             	add    $0x18,%esp
	return;
  801e4e:	90                   	nop
}
  801e4f:	c9                   	leave  
  801e50:	c3                   	ret    

00801e51 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e51:	55                   	push   %ebp
  801e52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	ff 75 0c             	pushl  0xc(%ebp)
  801e5d:	ff 75 08             	pushl  0x8(%ebp)
  801e60:	6a 12                	push   $0x12
  801e62:	e8 17 fe ff ff       	call   801c7e <syscall>
  801e67:	83 c4 18             	add    $0x18,%esp
	return ;
  801e6a:	90                   	nop
}
  801e6b:	c9                   	leave  
  801e6c:	c3                   	ret    

00801e6d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e6d:	55                   	push   %ebp
  801e6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 0e                	push   $0xe
  801e7c:	e8 fd fd ff ff       	call   801c7e <syscall>
  801e81:	83 c4 18             	add    $0x18,%esp
}
  801e84:	c9                   	leave  
  801e85:	c3                   	ret    

00801e86 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e86:	55                   	push   %ebp
  801e87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e89:	6a 00                	push   $0x0
  801e8b:	6a 00                	push   $0x0
  801e8d:	6a 00                	push   $0x0
  801e8f:	6a 00                	push   $0x0
  801e91:	ff 75 08             	pushl  0x8(%ebp)
  801e94:	6a 0f                	push   $0xf
  801e96:	e8 e3 fd ff ff       	call   801c7e <syscall>
  801e9b:	83 c4 18             	add    $0x18,%esp
}
  801e9e:	c9                   	leave  
  801e9f:	c3                   	ret    

00801ea0 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ea0:	55                   	push   %ebp
  801ea1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 10                	push   $0x10
  801eaf:	e8 ca fd ff ff       	call   801c7e <syscall>
  801eb4:	83 c4 18             	add    $0x18,%esp
}
  801eb7:	90                   	nop
  801eb8:	c9                   	leave  
  801eb9:	c3                   	ret    

00801eba <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801eba:	55                   	push   %ebp
  801ebb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ebd:	6a 00                	push   $0x0
  801ebf:	6a 00                	push   $0x0
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	6a 00                	push   $0x0
  801ec7:	6a 14                	push   $0x14
  801ec9:	e8 b0 fd ff ff       	call   801c7e <syscall>
  801ece:	83 c4 18             	add    $0x18,%esp
}
  801ed1:	90                   	nop
  801ed2:	c9                   	leave  
  801ed3:	c3                   	ret    

00801ed4 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ed4:	55                   	push   %ebp
  801ed5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ed7:	6a 00                	push   $0x0
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 15                	push   $0x15
  801ee3:	e8 96 fd ff ff       	call   801c7e <syscall>
  801ee8:	83 c4 18             	add    $0x18,%esp
}
  801eeb:	90                   	nop
  801eec:	c9                   	leave  
  801eed:	c3                   	ret    

00801eee <sys_cputc>:


void
sys_cputc(const char c)
{
  801eee:	55                   	push   %ebp
  801eef:	89 e5                	mov    %esp,%ebp
  801ef1:	83 ec 04             	sub    $0x4,%esp
  801ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801efa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	50                   	push   %eax
  801f07:	6a 16                	push   $0x16
  801f09:	e8 70 fd ff ff       	call   801c7e <syscall>
  801f0e:	83 c4 18             	add    $0x18,%esp
}
  801f11:	90                   	nop
  801f12:	c9                   	leave  
  801f13:	c3                   	ret    

00801f14 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f14:	55                   	push   %ebp
  801f15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f17:	6a 00                	push   $0x0
  801f19:	6a 00                	push   $0x0
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 17                	push   $0x17
  801f23:	e8 56 fd ff ff       	call   801c7e <syscall>
  801f28:	83 c4 18             	add    $0x18,%esp
}
  801f2b:	90                   	nop
  801f2c:	c9                   	leave  
  801f2d:	c3                   	ret    

00801f2e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f2e:	55                   	push   %ebp
  801f2f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f31:	8b 45 08             	mov    0x8(%ebp),%eax
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	ff 75 0c             	pushl  0xc(%ebp)
  801f3d:	50                   	push   %eax
  801f3e:	6a 18                	push   $0x18
  801f40:	e8 39 fd ff ff       	call   801c7e <syscall>
  801f45:	83 c4 18             	add    $0x18,%esp
}
  801f48:	c9                   	leave  
  801f49:	c3                   	ret    

00801f4a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f4a:	55                   	push   %ebp
  801f4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f50:	8b 45 08             	mov    0x8(%ebp),%eax
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	52                   	push   %edx
  801f5a:	50                   	push   %eax
  801f5b:	6a 1b                	push   $0x1b
  801f5d:	e8 1c fd ff ff       	call   801c7e <syscall>
  801f62:	83 c4 18             	add    $0x18,%esp
}
  801f65:	c9                   	leave  
  801f66:	c3                   	ret    

00801f67 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f67:	55                   	push   %ebp
  801f68:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	52                   	push   %edx
  801f77:	50                   	push   %eax
  801f78:	6a 19                	push   $0x19
  801f7a:	e8 ff fc ff ff       	call   801c7e <syscall>
  801f7f:	83 c4 18             	add    $0x18,%esp
}
  801f82:	90                   	nop
  801f83:	c9                   	leave  
  801f84:	c3                   	ret    

00801f85 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f85:	55                   	push   %ebp
  801f86:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f88:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	52                   	push   %edx
  801f95:	50                   	push   %eax
  801f96:	6a 1a                	push   $0x1a
  801f98:	e8 e1 fc ff ff       	call   801c7e <syscall>
  801f9d:	83 c4 18             	add    $0x18,%esp
}
  801fa0:	90                   	nop
  801fa1:	c9                   	leave  
  801fa2:	c3                   	ret    

00801fa3 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801fa3:	55                   	push   %ebp
  801fa4:	89 e5                	mov    %esp,%ebp
  801fa6:	83 ec 04             	sub    $0x4,%esp
  801fa9:	8b 45 10             	mov    0x10(%ebp),%eax
  801fac:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801faf:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801fb2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb9:	6a 00                	push   $0x0
  801fbb:	51                   	push   %ecx
  801fbc:	52                   	push   %edx
  801fbd:	ff 75 0c             	pushl  0xc(%ebp)
  801fc0:	50                   	push   %eax
  801fc1:	6a 1c                	push   $0x1c
  801fc3:	e8 b6 fc ff ff       	call   801c7e <syscall>
  801fc8:	83 c4 18             	add    $0x18,%esp
}
  801fcb:	c9                   	leave  
  801fcc:	c3                   	ret    

00801fcd <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801fcd:	55                   	push   %ebp
  801fce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801fd0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	52                   	push   %edx
  801fdd:	50                   	push   %eax
  801fde:	6a 1d                	push   $0x1d
  801fe0:	e8 99 fc ff ff       	call   801c7e <syscall>
  801fe5:	83 c4 18             	add    $0x18,%esp
}
  801fe8:	c9                   	leave  
  801fe9:	c3                   	ret    

00801fea <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801fea:	55                   	push   %ebp
  801feb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801fed:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ff0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff6:	6a 00                	push   $0x0
  801ff8:	6a 00                	push   $0x0
  801ffa:	51                   	push   %ecx
  801ffb:	52                   	push   %edx
  801ffc:	50                   	push   %eax
  801ffd:	6a 1e                	push   $0x1e
  801fff:	e8 7a fc ff ff       	call   801c7e <syscall>
  802004:	83 c4 18             	add    $0x18,%esp
}
  802007:	c9                   	leave  
  802008:	c3                   	ret    

00802009 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802009:	55                   	push   %ebp
  80200a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80200c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80200f:	8b 45 08             	mov    0x8(%ebp),%eax
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	52                   	push   %edx
  802019:	50                   	push   %eax
  80201a:	6a 1f                	push   $0x1f
  80201c:	e8 5d fc ff ff       	call   801c7e <syscall>
  802021:	83 c4 18             	add    $0x18,%esp
}
  802024:	c9                   	leave  
  802025:	c3                   	ret    

00802026 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802026:	55                   	push   %ebp
  802027:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802029:	6a 00                	push   $0x0
  80202b:	6a 00                	push   $0x0
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	6a 20                	push   $0x20
  802035:	e8 44 fc ff ff       	call   801c7e <syscall>
  80203a:	83 c4 18             	add    $0x18,%esp
}
  80203d:	c9                   	leave  
  80203e:	c3                   	ret    

0080203f <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80203f:	55                   	push   %ebp
  802040:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802042:	8b 45 08             	mov    0x8(%ebp),%eax
  802045:	6a 00                	push   $0x0
  802047:	6a 00                	push   $0x0
  802049:	ff 75 10             	pushl  0x10(%ebp)
  80204c:	ff 75 0c             	pushl  0xc(%ebp)
  80204f:	50                   	push   %eax
  802050:	6a 21                	push   $0x21
  802052:	e8 27 fc ff ff       	call   801c7e <syscall>
  802057:	83 c4 18             	add    $0x18,%esp
}
  80205a:	c9                   	leave  
  80205b:	c3                   	ret    

0080205c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80205c:	55                   	push   %ebp
  80205d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80205f:	8b 45 08             	mov    0x8(%ebp),%eax
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	50                   	push   %eax
  80206b:	6a 22                	push   $0x22
  80206d:	e8 0c fc ff ff       	call   801c7e <syscall>
  802072:	83 c4 18             	add    $0x18,%esp
}
  802075:	90                   	nop
  802076:	c9                   	leave  
  802077:	c3                   	ret    

00802078 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802078:	55                   	push   %ebp
  802079:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80207b:	8b 45 08             	mov    0x8(%ebp),%eax
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	50                   	push   %eax
  802087:	6a 23                	push   $0x23
  802089:	e8 f0 fb ff ff       	call   801c7e <syscall>
  80208e:	83 c4 18             	add    $0x18,%esp
}
  802091:	90                   	nop
  802092:	c9                   	leave  
  802093:	c3                   	ret    

00802094 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802094:	55                   	push   %ebp
  802095:	89 e5                	mov    %esp,%ebp
  802097:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80209a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80209d:	8d 50 04             	lea    0x4(%eax),%edx
  8020a0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 00                	push   $0x0
  8020a9:	52                   	push   %edx
  8020aa:	50                   	push   %eax
  8020ab:	6a 24                	push   $0x24
  8020ad:	e8 cc fb ff ff       	call   801c7e <syscall>
  8020b2:	83 c4 18             	add    $0x18,%esp
	return result;
  8020b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020be:	89 01                	mov    %eax,(%ecx)
  8020c0:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8020c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c6:	c9                   	leave  
  8020c7:	c2 04 00             	ret    $0x4

008020ca <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8020ca:	55                   	push   %ebp
  8020cb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	ff 75 10             	pushl  0x10(%ebp)
  8020d4:	ff 75 0c             	pushl  0xc(%ebp)
  8020d7:	ff 75 08             	pushl  0x8(%ebp)
  8020da:	6a 13                	push   $0x13
  8020dc:	e8 9d fb ff ff       	call   801c7e <syscall>
  8020e1:	83 c4 18             	add    $0x18,%esp
	return ;
  8020e4:	90                   	nop
}
  8020e5:	c9                   	leave  
  8020e6:	c3                   	ret    

008020e7 <sys_rcr2>:
uint32 sys_rcr2()
{
  8020e7:	55                   	push   %ebp
  8020e8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8020ea:	6a 00                	push   $0x0
  8020ec:	6a 00                	push   $0x0
  8020ee:	6a 00                	push   $0x0
  8020f0:	6a 00                	push   $0x0
  8020f2:	6a 00                	push   $0x0
  8020f4:	6a 25                	push   $0x25
  8020f6:	e8 83 fb ff ff       	call   801c7e <syscall>
  8020fb:	83 c4 18             	add    $0x18,%esp
}
  8020fe:	c9                   	leave  
  8020ff:	c3                   	ret    

00802100 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802100:	55                   	push   %ebp
  802101:	89 e5                	mov    %esp,%ebp
  802103:	83 ec 04             	sub    $0x4,%esp
  802106:	8b 45 08             	mov    0x8(%ebp),%eax
  802109:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80210c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	50                   	push   %eax
  802119:	6a 26                	push   $0x26
  80211b:	e8 5e fb ff ff       	call   801c7e <syscall>
  802120:	83 c4 18             	add    $0x18,%esp
	return ;
  802123:	90                   	nop
}
  802124:	c9                   	leave  
  802125:	c3                   	ret    

00802126 <rsttst>:
void rsttst()
{
  802126:	55                   	push   %ebp
  802127:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802129:	6a 00                	push   $0x0
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	6a 00                	push   $0x0
  802133:	6a 28                	push   $0x28
  802135:	e8 44 fb ff ff       	call   801c7e <syscall>
  80213a:	83 c4 18             	add    $0x18,%esp
	return ;
  80213d:	90                   	nop
}
  80213e:	c9                   	leave  
  80213f:	c3                   	ret    

00802140 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802140:	55                   	push   %ebp
  802141:	89 e5                	mov    %esp,%ebp
  802143:	83 ec 04             	sub    $0x4,%esp
  802146:	8b 45 14             	mov    0x14(%ebp),%eax
  802149:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80214c:	8b 55 18             	mov    0x18(%ebp),%edx
  80214f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802153:	52                   	push   %edx
  802154:	50                   	push   %eax
  802155:	ff 75 10             	pushl  0x10(%ebp)
  802158:	ff 75 0c             	pushl  0xc(%ebp)
  80215b:	ff 75 08             	pushl  0x8(%ebp)
  80215e:	6a 27                	push   $0x27
  802160:	e8 19 fb ff ff       	call   801c7e <syscall>
  802165:	83 c4 18             	add    $0x18,%esp
	return ;
  802168:	90                   	nop
}
  802169:	c9                   	leave  
  80216a:	c3                   	ret    

0080216b <chktst>:
void chktst(uint32 n)
{
  80216b:	55                   	push   %ebp
  80216c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80216e:	6a 00                	push   $0x0
  802170:	6a 00                	push   $0x0
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	ff 75 08             	pushl  0x8(%ebp)
  802179:	6a 29                	push   $0x29
  80217b:	e8 fe fa ff ff       	call   801c7e <syscall>
  802180:	83 c4 18             	add    $0x18,%esp
	return ;
  802183:	90                   	nop
}
  802184:	c9                   	leave  
  802185:	c3                   	ret    

00802186 <inctst>:

void inctst()
{
  802186:	55                   	push   %ebp
  802187:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802189:	6a 00                	push   $0x0
  80218b:	6a 00                	push   $0x0
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	6a 00                	push   $0x0
  802193:	6a 2a                	push   $0x2a
  802195:	e8 e4 fa ff ff       	call   801c7e <syscall>
  80219a:	83 c4 18             	add    $0x18,%esp
	return ;
  80219d:	90                   	nop
}
  80219e:	c9                   	leave  
  80219f:	c3                   	ret    

008021a0 <gettst>:
uint32 gettst()
{
  8021a0:	55                   	push   %ebp
  8021a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8021a3:	6a 00                	push   $0x0
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 2b                	push   $0x2b
  8021af:	e8 ca fa ff ff       	call   801c7e <syscall>
  8021b4:	83 c4 18             	add    $0x18,%esp
}
  8021b7:	c9                   	leave  
  8021b8:	c3                   	ret    

008021b9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8021b9:	55                   	push   %ebp
  8021ba:	89 e5                	mov    %esp,%ebp
  8021bc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021bf:	6a 00                	push   $0x0
  8021c1:	6a 00                	push   $0x0
  8021c3:	6a 00                	push   $0x0
  8021c5:	6a 00                	push   $0x0
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 2c                	push   $0x2c
  8021cb:	e8 ae fa ff ff       	call   801c7e <syscall>
  8021d0:	83 c4 18             	add    $0x18,%esp
  8021d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8021d6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8021da:	75 07                	jne    8021e3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8021dc:	b8 01 00 00 00       	mov    $0x1,%eax
  8021e1:	eb 05                	jmp    8021e8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8021e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021e8:	c9                   	leave  
  8021e9:	c3                   	ret    

008021ea <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8021ea:	55                   	push   %ebp
  8021eb:	89 e5                	mov    %esp,%ebp
  8021ed:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021f0:	6a 00                	push   $0x0
  8021f2:	6a 00                	push   $0x0
  8021f4:	6a 00                	push   $0x0
  8021f6:	6a 00                	push   $0x0
  8021f8:	6a 00                	push   $0x0
  8021fa:	6a 2c                	push   $0x2c
  8021fc:	e8 7d fa ff ff       	call   801c7e <syscall>
  802201:	83 c4 18             	add    $0x18,%esp
  802204:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802207:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80220b:	75 07                	jne    802214 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80220d:	b8 01 00 00 00       	mov    $0x1,%eax
  802212:	eb 05                	jmp    802219 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802214:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802219:	c9                   	leave  
  80221a:	c3                   	ret    

0080221b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80221b:	55                   	push   %ebp
  80221c:	89 e5                	mov    %esp,%ebp
  80221e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802221:	6a 00                	push   $0x0
  802223:	6a 00                	push   $0x0
  802225:	6a 00                	push   $0x0
  802227:	6a 00                	push   $0x0
  802229:	6a 00                	push   $0x0
  80222b:	6a 2c                	push   $0x2c
  80222d:	e8 4c fa ff ff       	call   801c7e <syscall>
  802232:	83 c4 18             	add    $0x18,%esp
  802235:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802238:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80223c:	75 07                	jne    802245 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80223e:	b8 01 00 00 00       	mov    $0x1,%eax
  802243:	eb 05                	jmp    80224a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802245:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80224a:	c9                   	leave  
  80224b:	c3                   	ret    

0080224c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80224c:	55                   	push   %ebp
  80224d:	89 e5                	mov    %esp,%ebp
  80224f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802252:	6a 00                	push   $0x0
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	6a 00                	push   $0x0
  80225a:	6a 00                	push   $0x0
  80225c:	6a 2c                	push   $0x2c
  80225e:	e8 1b fa ff ff       	call   801c7e <syscall>
  802263:	83 c4 18             	add    $0x18,%esp
  802266:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802269:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80226d:	75 07                	jne    802276 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80226f:	b8 01 00 00 00       	mov    $0x1,%eax
  802274:	eb 05                	jmp    80227b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802276:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80227b:	c9                   	leave  
  80227c:	c3                   	ret    

0080227d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80227d:	55                   	push   %ebp
  80227e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802280:	6a 00                	push   $0x0
  802282:	6a 00                	push   $0x0
  802284:	6a 00                	push   $0x0
  802286:	6a 00                	push   $0x0
  802288:	ff 75 08             	pushl  0x8(%ebp)
  80228b:	6a 2d                	push   $0x2d
  80228d:	e8 ec f9 ff ff       	call   801c7e <syscall>
  802292:	83 c4 18             	add    $0x18,%esp
	return ;
  802295:	90                   	nop
}
  802296:	c9                   	leave  
  802297:	c3                   	ret    

00802298 <__udivdi3>:
  802298:	55                   	push   %ebp
  802299:	57                   	push   %edi
  80229a:	56                   	push   %esi
  80229b:	53                   	push   %ebx
  80229c:	83 ec 1c             	sub    $0x1c,%esp
  80229f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8022a3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8022a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022ab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8022af:	89 ca                	mov    %ecx,%edx
  8022b1:	89 f8                	mov    %edi,%eax
  8022b3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8022b7:	85 f6                	test   %esi,%esi
  8022b9:	75 2d                	jne    8022e8 <__udivdi3+0x50>
  8022bb:	39 cf                	cmp    %ecx,%edi
  8022bd:	77 65                	ja     802324 <__udivdi3+0x8c>
  8022bf:	89 fd                	mov    %edi,%ebp
  8022c1:	85 ff                	test   %edi,%edi
  8022c3:	75 0b                	jne    8022d0 <__udivdi3+0x38>
  8022c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8022ca:	31 d2                	xor    %edx,%edx
  8022cc:	f7 f7                	div    %edi
  8022ce:	89 c5                	mov    %eax,%ebp
  8022d0:	31 d2                	xor    %edx,%edx
  8022d2:	89 c8                	mov    %ecx,%eax
  8022d4:	f7 f5                	div    %ebp
  8022d6:	89 c1                	mov    %eax,%ecx
  8022d8:	89 d8                	mov    %ebx,%eax
  8022da:	f7 f5                	div    %ebp
  8022dc:	89 cf                	mov    %ecx,%edi
  8022de:	89 fa                	mov    %edi,%edx
  8022e0:	83 c4 1c             	add    $0x1c,%esp
  8022e3:	5b                   	pop    %ebx
  8022e4:	5e                   	pop    %esi
  8022e5:	5f                   	pop    %edi
  8022e6:	5d                   	pop    %ebp
  8022e7:	c3                   	ret    
  8022e8:	39 ce                	cmp    %ecx,%esi
  8022ea:	77 28                	ja     802314 <__udivdi3+0x7c>
  8022ec:	0f bd fe             	bsr    %esi,%edi
  8022ef:	83 f7 1f             	xor    $0x1f,%edi
  8022f2:	75 40                	jne    802334 <__udivdi3+0x9c>
  8022f4:	39 ce                	cmp    %ecx,%esi
  8022f6:	72 0a                	jb     802302 <__udivdi3+0x6a>
  8022f8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022fc:	0f 87 9e 00 00 00    	ja     8023a0 <__udivdi3+0x108>
  802302:	b8 01 00 00 00       	mov    $0x1,%eax
  802307:	89 fa                	mov    %edi,%edx
  802309:	83 c4 1c             	add    $0x1c,%esp
  80230c:	5b                   	pop    %ebx
  80230d:	5e                   	pop    %esi
  80230e:	5f                   	pop    %edi
  80230f:	5d                   	pop    %ebp
  802310:	c3                   	ret    
  802311:	8d 76 00             	lea    0x0(%esi),%esi
  802314:	31 ff                	xor    %edi,%edi
  802316:	31 c0                	xor    %eax,%eax
  802318:	89 fa                	mov    %edi,%edx
  80231a:	83 c4 1c             	add    $0x1c,%esp
  80231d:	5b                   	pop    %ebx
  80231e:	5e                   	pop    %esi
  80231f:	5f                   	pop    %edi
  802320:	5d                   	pop    %ebp
  802321:	c3                   	ret    
  802322:	66 90                	xchg   %ax,%ax
  802324:	89 d8                	mov    %ebx,%eax
  802326:	f7 f7                	div    %edi
  802328:	31 ff                	xor    %edi,%edi
  80232a:	89 fa                	mov    %edi,%edx
  80232c:	83 c4 1c             	add    $0x1c,%esp
  80232f:	5b                   	pop    %ebx
  802330:	5e                   	pop    %esi
  802331:	5f                   	pop    %edi
  802332:	5d                   	pop    %ebp
  802333:	c3                   	ret    
  802334:	bd 20 00 00 00       	mov    $0x20,%ebp
  802339:	89 eb                	mov    %ebp,%ebx
  80233b:	29 fb                	sub    %edi,%ebx
  80233d:	89 f9                	mov    %edi,%ecx
  80233f:	d3 e6                	shl    %cl,%esi
  802341:	89 c5                	mov    %eax,%ebp
  802343:	88 d9                	mov    %bl,%cl
  802345:	d3 ed                	shr    %cl,%ebp
  802347:	89 e9                	mov    %ebp,%ecx
  802349:	09 f1                	or     %esi,%ecx
  80234b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80234f:	89 f9                	mov    %edi,%ecx
  802351:	d3 e0                	shl    %cl,%eax
  802353:	89 c5                	mov    %eax,%ebp
  802355:	89 d6                	mov    %edx,%esi
  802357:	88 d9                	mov    %bl,%cl
  802359:	d3 ee                	shr    %cl,%esi
  80235b:	89 f9                	mov    %edi,%ecx
  80235d:	d3 e2                	shl    %cl,%edx
  80235f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802363:	88 d9                	mov    %bl,%cl
  802365:	d3 e8                	shr    %cl,%eax
  802367:	09 c2                	or     %eax,%edx
  802369:	89 d0                	mov    %edx,%eax
  80236b:	89 f2                	mov    %esi,%edx
  80236d:	f7 74 24 0c          	divl   0xc(%esp)
  802371:	89 d6                	mov    %edx,%esi
  802373:	89 c3                	mov    %eax,%ebx
  802375:	f7 e5                	mul    %ebp
  802377:	39 d6                	cmp    %edx,%esi
  802379:	72 19                	jb     802394 <__udivdi3+0xfc>
  80237b:	74 0b                	je     802388 <__udivdi3+0xf0>
  80237d:	89 d8                	mov    %ebx,%eax
  80237f:	31 ff                	xor    %edi,%edi
  802381:	e9 58 ff ff ff       	jmp    8022de <__udivdi3+0x46>
  802386:	66 90                	xchg   %ax,%ax
  802388:	8b 54 24 08          	mov    0x8(%esp),%edx
  80238c:	89 f9                	mov    %edi,%ecx
  80238e:	d3 e2                	shl    %cl,%edx
  802390:	39 c2                	cmp    %eax,%edx
  802392:	73 e9                	jae    80237d <__udivdi3+0xe5>
  802394:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802397:	31 ff                	xor    %edi,%edi
  802399:	e9 40 ff ff ff       	jmp    8022de <__udivdi3+0x46>
  80239e:	66 90                	xchg   %ax,%ax
  8023a0:	31 c0                	xor    %eax,%eax
  8023a2:	e9 37 ff ff ff       	jmp    8022de <__udivdi3+0x46>
  8023a7:	90                   	nop

008023a8 <__umoddi3>:
  8023a8:	55                   	push   %ebp
  8023a9:	57                   	push   %edi
  8023aa:	56                   	push   %esi
  8023ab:	53                   	push   %ebx
  8023ac:	83 ec 1c             	sub    $0x1c,%esp
  8023af:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8023b3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8023b7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023bb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8023bf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023c3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023c7:	89 f3                	mov    %esi,%ebx
  8023c9:	89 fa                	mov    %edi,%edx
  8023cb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023cf:	89 34 24             	mov    %esi,(%esp)
  8023d2:	85 c0                	test   %eax,%eax
  8023d4:	75 1a                	jne    8023f0 <__umoddi3+0x48>
  8023d6:	39 f7                	cmp    %esi,%edi
  8023d8:	0f 86 a2 00 00 00    	jbe    802480 <__umoddi3+0xd8>
  8023de:	89 c8                	mov    %ecx,%eax
  8023e0:	89 f2                	mov    %esi,%edx
  8023e2:	f7 f7                	div    %edi
  8023e4:	89 d0                	mov    %edx,%eax
  8023e6:	31 d2                	xor    %edx,%edx
  8023e8:	83 c4 1c             	add    $0x1c,%esp
  8023eb:	5b                   	pop    %ebx
  8023ec:	5e                   	pop    %esi
  8023ed:	5f                   	pop    %edi
  8023ee:	5d                   	pop    %ebp
  8023ef:	c3                   	ret    
  8023f0:	39 f0                	cmp    %esi,%eax
  8023f2:	0f 87 ac 00 00 00    	ja     8024a4 <__umoddi3+0xfc>
  8023f8:	0f bd e8             	bsr    %eax,%ebp
  8023fb:	83 f5 1f             	xor    $0x1f,%ebp
  8023fe:	0f 84 ac 00 00 00    	je     8024b0 <__umoddi3+0x108>
  802404:	bf 20 00 00 00       	mov    $0x20,%edi
  802409:	29 ef                	sub    %ebp,%edi
  80240b:	89 fe                	mov    %edi,%esi
  80240d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802411:	89 e9                	mov    %ebp,%ecx
  802413:	d3 e0                	shl    %cl,%eax
  802415:	89 d7                	mov    %edx,%edi
  802417:	89 f1                	mov    %esi,%ecx
  802419:	d3 ef                	shr    %cl,%edi
  80241b:	09 c7                	or     %eax,%edi
  80241d:	89 e9                	mov    %ebp,%ecx
  80241f:	d3 e2                	shl    %cl,%edx
  802421:	89 14 24             	mov    %edx,(%esp)
  802424:	89 d8                	mov    %ebx,%eax
  802426:	d3 e0                	shl    %cl,%eax
  802428:	89 c2                	mov    %eax,%edx
  80242a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80242e:	d3 e0                	shl    %cl,%eax
  802430:	89 44 24 04          	mov    %eax,0x4(%esp)
  802434:	8b 44 24 08          	mov    0x8(%esp),%eax
  802438:	89 f1                	mov    %esi,%ecx
  80243a:	d3 e8                	shr    %cl,%eax
  80243c:	09 d0                	or     %edx,%eax
  80243e:	d3 eb                	shr    %cl,%ebx
  802440:	89 da                	mov    %ebx,%edx
  802442:	f7 f7                	div    %edi
  802444:	89 d3                	mov    %edx,%ebx
  802446:	f7 24 24             	mull   (%esp)
  802449:	89 c6                	mov    %eax,%esi
  80244b:	89 d1                	mov    %edx,%ecx
  80244d:	39 d3                	cmp    %edx,%ebx
  80244f:	0f 82 87 00 00 00    	jb     8024dc <__umoddi3+0x134>
  802455:	0f 84 91 00 00 00    	je     8024ec <__umoddi3+0x144>
  80245b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80245f:	29 f2                	sub    %esi,%edx
  802461:	19 cb                	sbb    %ecx,%ebx
  802463:	89 d8                	mov    %ebx,%eax
  802465:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802469:	d3 e0                	shl    %cl,%eax
  80246b:	89 e9                	mov    %ebp,%ecx
  80246d:	d3 ea                	shr    %cl,%edx
  80246f:	09 d0                	or     %edx,%eax
  802471:	89 e9                	mov    %ebp,%ecx
  802473:	d3 eb                	shr    %cl,%ebx
  802475:	89 da                	mov    %ebx,%edx
  802477:	83 c4 1c             	add    $0x1c,%esp
  80247a:	5b                   	pop    %ebx
  80247b:	5e                   	pop    %esi
  80247c:	5f                   	pop    %edi
  80247d:	5d                   	pop    %ebp
  80247e:	c3                   	ret    
  80247f:	90                   	nop
  802480:	89 fd                	mov    %edi,%ebp
  802482:	85 ff                	test   %edi,%edi
  802484:	75 0b                	jne    802491 <__umoddi3+0xe9>
  802486:	b8 01 00 00 00       	mov    $0x1,%eax
  80248b:	31 d2                	xor    %edx,%edx
  80248d:	f7 f7                	div    %edi
  80248f:	89 c5                	mov    %eax,%ebp
  802491:	89 f0                	mov    %esi,%eax
  802493:	31 d2                	xor    %edx,%edx
  802495:	f7 f5                	div    %ebp
  802497:	89 c8                	mov    %ecx,%eax
  802499:	f7 f5                	div    %ebp
  80249b:	89 d0                	mov    %edx,%eax
  80249d:	e9 44 ff ff ff       	jmp    8023e6 <__umoddi3+0x3e>
  8024a2:	66 90                	xchg   %ax,%ax
  8024a4:	89 c8                	mov    %ecx,%eax
  8024a6:	89 f2                	mov    %esi,%edx
  8024a8:	83 c4 1c             	add    $0x1c,%esp
  8024ab:	5b                   	pop    %ebx
  8024ac:	5e                   	pop    %esi
  8024ad:	5f                   	pop    %edi
  8024ae:	5d                   	pop    %ebp
  8024af:	c3                   	ret    
  8024b0:	3b 04 24             	cmp    (%esp),%eax
  8024b3:	72 06                	jb     8024bb <__umoddi3+0x113>
  8024b5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024b9:	77 0f                	ja     8024ca <__umoddi3+0x122>
  8024bb:	89 f2                	mov    %esi,%edx
  8024bd:	29 f9                	sub    %edi,%ecx
  8024bf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024c3:	89 14 24             	mov    %edx,(%esp)
  8024c6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024ca:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024ce:	8b 14 24             	mov    (%esp),%edx
  8024d1:	83 c4 1c             	add    $0x1c,%esp
  8024d4:	5b                   	pop    %ebx
  8024d5:	5e                   	pop    %esi
  8024d6:	5f                   	pop    %edi
  8024d7:	5d                   	pop    %ebp
  8024d8:	c3                   	ret    
  8024d9:	8d 76 00             	lea    0x0(%esi),%esi
  8024dc:	2b 04 24             	sub    (%esp),%eax
  8024df:	19 fa                	sbb    %edi,%edx
  8024e1:	89 d1                	mov    %edx,%ecx
  8024e3:	89 c6                	mov    %eax,%esi
  8024e5:	e9 71 ff ff ff       	jmp    80245b <__umoddi3+0xb3>
  8024ea:	66 90                	xchg   %ax,%ax
  8024ec:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024f0:	72 ea                	jb     8024dc <__umoddi3+0x134>
  8024f2:	89 d9                	mov    %ebx,%ecx
  8024f4:	e9 62 ff ff ff       	jmp    80245b <__umoddi3+0xb3>
