
obj/user/quicksort5:     file format elf32-i386


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
  800031:	e8 74 06 00 00       	call   8006aa <libmain>
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
  80003c:	81 ec c4 63 00 00    	sub    $0x63c4,%esp
	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[25500] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int envID = sys_getenvid();
  800049:	e8 ba 1c 00 00       	call   801d08 <sys_getenvid>
  80004e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	sys_createSemaphore("1", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 00 25 80 00       	push   $0x802500
  80005b:	e8 d0 1e 00 00       	call   801f30 <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 84 1d 00 00       	call   801dec <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 96 1d 00 00       	call   801e05 <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();
		sys_waitSemaphore(envID, "1");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 00 25 80 00       	push   $0x802500
  80007f:	ff 75 e8             	pushl  -0x18(%ebp)
  800082:	e8 e2 1e 00 00       	call   801f69 <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 04 25 80 00       	push   $0x802504
  800099:	e8 44 10 00 00       	call   8010e2 <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 94 15 00 00       	call   801648 <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 61 19 00 00       	call   801a2a <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 24 25 80 00       	push   $0x802524
  8000d7:	e8 84 09 00 00       	call   800a60 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 47 25 80 00       	push   $0x802547
  8000e7:	e8 74 09 00 00       	call   800a60 <cprintf>
  8000ec:	83 c4 10             	add    $0x10,%esp
		int ii, j = 0 ;
  8000ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (ii = 0 ; ii < 100000; ii++)
  8000f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000fd:	eb 09                	jmp    800108 <_main+0xd0>
		{
			j+= ii;
  8000ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800102:	01 45 ec             	add    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
		cprintf("a) Ascending\n") ;
		int ii, j = 0 ;
		for (ii = 0 ; ii < 100000; ii++)
  800105:	ff 45 f0             	incl   -0x10(%ebp)
  800108:	81 7d f0 9f 86 01 00 	cmpl   $0x1869f,-0x10(%ebp)
  80010f:	7e ee                	jle    8000ff <_main+0xc7>
		{
			j+= ii;
		}
		cprintf("b) Descending\n") ;
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	68 55 25 80 00       	push   $0x802555
  800119:	e8 42 09 00 00       	call   800a60 <cprintf>
  80011e:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\nSelect: ") ;
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	68 64 25 80 00       	push   $0x802564
  800129:	e8 32 09 00 00       	call   800a60 <cprintf>
  80012e:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  800131:	e8 1c 05 00 00       	call   800652 <getchar>
  800136:	88 45 db             	mov    %al,-0x25(%ebp)
		cputchar(Chose);
  800139:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80013d:	83 ec 0c             	sub    $0xc,%esp
  800140:	50                   	push   %eax
  800141:	e8 c4 04 00 00       	call   80060a <cputchar>
  800146:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800149:	83 ec 0c             	sub    $0xc,%esp
  80014c:	6a 0a                	push   $0xa
  80014e:	e8 b7 04 00 00       	call   80060a <cputchar>
  800153:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID, "1");
  800156:	83 ec 08             	sub    $0x8,%esp
  800159:	68 00 25 80 00       	push   $0x802500
  80015e:	ff 75 e8             	pushl  -0x18(%ebp)
  800161:	e8 21 1e 00 00       	call   801f87 <sys_signalSemaphore>
  800166:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800169:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80016d:	83 f8 62             	cmp    $0x62,%eax
  800170:	74 1d                	je     80018f <_main+0x157>
  800172:	83 f8 63             	cmp    $0x63,%eax
  800175:	74 2b                	je     8001a2 <_main+0x16a>
  800177:	83 f8 61             	cmp    $0x61,%eax
  80017a:	75 39                	jne    8001b5 <_main+0x17d>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017c:	83 ec 08             	sub    $0x8,%esp
  80017f:	ff 75 e0             	pushl  -0x20(%ebp)
  800182:	ff 75 dc             	pushl  -0x24(%ebp)
  800185:	e8 48 03 00 00       	call   8004d2 <InitializeAscending>
  80018a:	83 c4 10             	add    $0x10,%esp
			break ;
  80018d:	eb 37                	jmp    8001c6 <_main+0x18e>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018f:	83 ec 08             	sub    $0x8,%esp
  800192:	ff 75 e0             	pushl  -0x20(%ebp)
  800195:	ff 75 dc             	pushl  -0x24(%ebp)
  800198:	e8 66 03 00 00       	call   800503 <InitializeDescending>
  80019d:	83 c4 10             	add    $0x10,%esp
			break ;
  8001a0:	eb 24                	jmp    8001c6 <_main+0x18e>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a2:	83 ec 08             	sub    $0x8,%esp
  8001a5:	ff 75 e0             	pushl  -0x20(%ebp)
  8001a8:	ff 75 dc             	pushl  -0x24(%ebp)
  8001ab:	e8 88 03 00 00       	call   800538 <InitializeSemiRandom>
  8001b0:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b3:	eb 11                	jmp    8001c6 <_main+0x18e>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b5:	83 ec 08             	sub    $0x8,%esp
  8001b8:	ff 75 e0             	pushl  -0x20(%ebp)
  8001bb:	ff 75 dc             	pushl  -0x24(%ebp)
  8001be:	e8 75 03 00 00       	call   800538 <InitializeSemiRandom>
  8001c3:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c6:	83 ec 08             	sub    $0x8,%esp
  8001c9:	ff 75 e0             	pushl  -0x20(%ebp)
  8001cc:	ff 75 dc             	pushl  -0x24(%ebp)
  8001cf:	e8 43 01 00 00       	call   800317 <QuickSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001d7:	83 ec 08             	sub    $0x8,%esp
  8001da:	ff 75 e0             	pushl  -0x20(%ebp)
  8001dd:	ff 75 dc             	pushl  -0x24(%ebp)
  8001e0:	e8 43 02 00 00       	call   800428 <CheckSorted>
  8001e5:	83 c4 10             	add    $0x10,%esp
  8001e8:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001eb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  8001ef:	75 14                	jne    800205 <_main+0x1cd>
  8001f1:	83 ec 04             	sub    $0x4,%esp
  8001f4:	68 7c 25 80 00       	push   $0x80257c
  8001f9:	6a 4b                	push   $0x4b
  8001fb:	68 9e 25 80 00       	push   $0x80259e
  800200:	e8 a7 05 00 00       	call   8007ac <_panic>
		else
		{
			sys_waitSemaphore(envID, "1");
  800205:	83 ec 08             	sub    $0x8,%esp
  800208:	68 00 25 80 00       	push   $0x802500
  80020d:	ff 75 e8             	pushl  -0x18(%ebp)
  800210:	e8 54 1d 00 00       	call   801f69 <sys_waitSemaphore>
  800215:	83 c4 10             	add    $0x10,%esp
			cprintf("\n===============================================\n") ;
  800218:	83 ec 0c             	sub    $0xc,%esp
  80021b:	68 b0 25 80 00       	push   $0x8025b0
  800220:	e8 3b 08 00 00       	call   800a60 <cprintf>
  800225:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800228:	83 ec 0c             	sub    $0xc,%esp
  80022b:	68 e4 25 80 00       	push   $0x8025e4
  800230:	e8 2b 08 00 00       	call   800a60 <cprintf>
  800235:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800238:	83 ec 0c             	sub    $0xc,%esp
  80023b:	68 18 26 80 00       	push   $0x802618
  800240:	e8 1b 08 00 00       	call   800a60 <cprintf>
  800245:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "1");
  800248:	83 ec 08             	sub    $0x8,%esp
  80024b:	68 00 25 80 00       	push   $0x802500
  800250:	ff 75 e8             	pushl  -0x18(%ebp)
  800253:	e8 2f 1d 00 00       	call   801f87 <sys_signalSemaphore>
  800258:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_waitSemaphore(envID, "1");
  80025b:	83 ec 08             	sub    $0x8,%esp
  80025e:	68 00 25 80 00       	push   $0x802500
  800263:	ff 75 e8             	pushl  -0x18(%ebp)
  800266:	e8 fe 1c 00 00       	call   801f69 <sys_waitSemaphore>
  80026b:	83 c4 10             	add    $0x10,%esp
		cprintf("Freeing the Heap...\n\n") ;
  80026e:	83 ec 0c             	sub    $0xc,%esp
  800271:	68 4a 26 80 00       	push   $0x80264a
  800276:	e8 e5 07 00 00       	call   800a60 <cprintf>
  80027b:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID, "1");
  80027e:	83 ec 08             	sub    $0x8,%esp
  800281:	68 00 25 80 00       	push   $0x802500
  800286:	ff 75 e8             	pushl  -0x18(%ebp)
  800289:	e8 f9 1c 00 00       	call   801f87 <sys_signalSemaphore>
  80028e:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  800291:	83 ec 0c             	sub    $0xc,%esp
  800294:	ff 75 dc             	pushl  -0x24(%ebp)
  800297:	e8 af 18 00 00       	call   801b4b <free>
  80029c:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "1");
  80029f:	83 ec 08             	sub    $0x8,%esp
  8002a2:	68 00 25 80 00       	push   $0x802500
  8002a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8002aa:	e8 ba 1c 00 00       	call   801f69 <sys_waitSemaphore>
  8002af:	83 c4 10             	add    $0x10,%esp
		cprintf("Do you want to repeat (y/n): ") ;
  8002b2:	83 ec 0c             	sub    $0xc,%esp
  8002b5:	68 60 26 80 00       	push   $0x802660
  8002ba:	e8 a1 07 00 00       	call   800a60 <cprintf>
  8002bf:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  8002c2:	e8 8b 03 00 00       	call   800652 <getchar>
  8002c7:	88 45 db             	mov    %al,-0x25(%ebp)
		cputchar(Chose);
  8002ca:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8002ce:	83 ec 0c             	sub    $0xc,%esp
  8002d1:	50                   	push   %eax
  8002d2:	e8 33 03 00 00       	call   80060a <cputchar>
  8002d7:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002da:	83 ec 0c             	sub    $0xc,%esp
  8002dd:	6a 0a                	push   $0xa
  8002df:	e8 26 03 00 00       	call   80060a <cputchar>
  8002e4:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002e7:	83 ec 0c             	sub    $0xc,%esp
  8002ea:	6a 0a                	push   $0xa
  8002ec:	e8 19 03 00 00       	call   80060a <cputchar>
  8002f1:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_signalSemaphore(envID, "1");
  8002f4:	83 ec 08             	sub    $0x8,%esp
  8002f7:	68 00 25 80 00       	push   $0x802500
  8002fc:	ff 75 e8             	pushl  -0x18(%ebp)
  8002ff:	e8 83 1c 00 00       	call   801f87 <sys_signalSemaphore>
  800304:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  800307:	80 7d db 79          	cmpb   $0x79,-0x25(%ebp)
  80030b:	0f 84 52 fd ff ff    	je     800063 <_main+0x2b>

}
  800311:	90                   	nop
  800312:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800315:	c9                   	leave  
  800316:	c3                   	ret    

00800317 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  800317:	55                   	push   %ebp
  800318:	89 e5                	mov    %esp,%ebp
  80031a:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80031d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800320:	48                   	dec    %eax
  800321:	50                   	push   %eax
  800322:	6a 00                	push   $0x0
  800324:	ff 75 0c             	pushl  0xc(%ebp)
  800327:	ff 75 08             	pushl  0x8(%ebp)
  80032a:	e8 06 00 00 00       	call   800335 <QSort>
  80032f:	83 c4 10             	add    $0x10,%esp
}
  800332:	90                   	nop
  800333:	c9                   	leave  
  800334:	c3                   	ret    

00800335 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800335:	55                   	push   %ebp
  800336:	89 e5                	mov    %esp,%ebp
  800338:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80033b:	8b 45 10             	mov    0x10(%ebp),%eax
  80033e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800341:	0f 8d de 00 00 00    	jge    800425 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800347:	8b 45 10             	mov    0x10(%ebp),%eax
  80034a:	40                   	inc    %eax
  80034b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80034e:	8b 45 14             	mov    0x14(%ebp),%eax
  800351:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800354:	e9 80 00 00 00       	jmp    8003d9 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800359:	ff 45 f4             	incl   -0xc(%ebp)
  80035c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80035f:	3b 45 14             	cmp    0x14(%ebp),%eax
  800362:	7f 2b                	jg     80038f <QSort+0x5a>
  800364:	8b 45 10             	mov    0x10(%ebp),%eax
  800367:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036e:	8b 45 08             	mov    0x8(%ebp),%eax
  800371:	01 d0                	add    %edx,%eax
  800373:	8b 10                	mov    (%eax),%edx
  800375:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800378:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80037f:	8b 45 08             	mov    0x8(%ebp),%eax
  800382:	01 c8                	add    %ecx,%eax
  800384:	8b 00                	mov    (%eax),%eax
  800386:	39 c2                	cmp    %eax,%edx
  800388:	7d cf                	jge    800359 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  80038a:	eb 03                	jmp    80038f <QSort+0x5a>
  80038c:	ff 4d f0             	decl   -0x10(%ebp)
  80038f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800392:	3b 45 10             	cmp    0x10(%ebp),%eax
  800395:	7e 26                	jle    8003bd <QSort+0x88>
  800397:	8b 45 10             	mov    0x10(%ebp),%eax
  80039a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	8b 10                	mov    (%eax),%edx
  8003a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003ab:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b5:	01 c8                	add    %ecx,%eax
  8003b7:	8b 00                	mov    (%eax),%eax
  8003b9:	39 c2                	cmp    %eax,%edx
  8003bb:	7e cf                	jle    80038c <QSort+0x57>

		if (i <= j)
  8003bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003c0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003c3:	7f 14                	jg     8003d9 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8003c5:	83 ec 04             	sub    $0x4,%esp
  8003c8:	ff 75 f0             	pushl  -0x10(%ebp)
  8003cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8003ce:	ff 75 08             	pushl  0x8(%ebp)
  8003d1:	e8 a9 00 00 00       	call   80047f <Swap>
  8003d6:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8003d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003dc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003df:	0f 8e 77 ff ff ff    	jle    80035c <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  8003e5:	83 ec 04             	sub    $0x4,%esp
  8003e8:	ff 75 f0             	pushl  -0x10(%ebp)
  8003eb:	ff 75 10             	pushl  0x10(%ebp)
  8003ee:	ff 75 08             	pushl  0x8(%ebp)
  8003f1:	e8 89 00 00 00       	call   80047f <Swap>
  8003f6:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003fc:	48                   	dec    %eax
  8003fd:	50                   	push   %eax
  8003fe:	ff 75 10             	pushl  0x10(%ebp)
  800401:	ff 75 0c             	pushl  0xc(%ebp)
  800404:	ff 75 08             	pushl  0x8(%ebp)
  800407:	e8 29 ff ff ff       	call   800335 <QSort>
  80040c:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80040f:	ff 75 14             	pushl  0x14(%ebp)
  800412:	ff 75 f4             	pushl  -0xc(%ebp)
  800415:	ff 75 0c             	pushl  0xc(%ebp)
  800418:	ff 75 08             	pushl  0x8(%ebp)
  80041b:	e8 15 ff ff ff       	call   800335 <QSort>
  800420:	83 c4 10             	add    $0x10,%esp
  800423:	eb 01                	jmp    800426 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800425:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800426:	c9                   	leave  
  800427:	c3                   	ret    

00800428 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800428:	55                   	push   %ebp
  800429:	89 e5                	mov    %esp,%ebp
  80042b:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80042e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800435:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80043c:	eb 33                	jmp    800471 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80043e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800441:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	01 d0                	add    %edx,%eax
  80044d:	8b 10                	mov    (%eax),%edx
  80044f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800452:	40                   	inc    %eax
  800453:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80045a:	8b 45 08             	mov    0x8(%ebp),%eax
  80045d:	01 c8                	add    %ecx,%eax
  80045f:	8b 00                	mov    (%eax),%eax
  800461:	39 c2                	cmp    %eax,%edx
  800463:	7e 09                	jle    80046e <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800465:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80046c:	eb 0c                	jmp    80047a <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80046e:	ff 45 f8             	incl   -0x8(%ebp)
  800471:	8b 45 0c             	mov    0xc(%ebp),%eax
  800474:	48                   	dec    %eax
  800475:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800478:	7f c4                	jg     80043e <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80047a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80047d:	c9                   	leave  
  80047e:	c3                   	ret    

0080047f <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80047f:	55                   	push   %ebp
  800480:	89 e5                	mov    %esp,%ebp
  800482:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800485:	8b 45 0c             	mov    0xc(%ebp),%eax
  800488:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048f:	8b 45 08             	mov    0x8(%ebp),%eax
  800492:	01 d0                	add    %edx,%eax
  800494:	8b 00                	mov    (%eax),%eax
  800496:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800499:	8b 45 0c             	mov    0xc(%ebp),%eax
  80049c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a6:	01 c2                	add    %eax,%edx
  8004a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ab:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b5:	01 c8                	add    %ecx,%eax
  8004b7:	8b 00                	mov    (%eax),%eax
  8004b9:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8004bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8004be:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c8:	01 c2                	add    %eax,%edx
  8004ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004cd:	89 02                	mov    %eax,(%edx)
}
  8004cf:	90                   	nop
  8004d0:	c9                   	leave  
  8004d1:	c3                   	ret    

008004d2 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8004d2:	55                   	push   %ebp
  8004d3:	89 e5                	mov    %esp,%ebp
  8004d5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004df:	eb 17                	jmp    8004f8 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8004e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ee:	01 c2                	add    %eax,%edx
  8004f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004f3:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004f5:	ff 45 fc             	incl   -0x4(%ebp)
  8004f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004fb:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004fe:	7c e1                	jl     8004e1 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800500:	90                   	nop
  800501:	c9                   	leave  
  800502:	c3                   	ret    

00800503 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800503:	55                   	push   %ebp
  800504:	89 e5                	mov    %esp,%ebp
  800506:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800509:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800510:	eb 1b                	jmp    80052d <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800512:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800515:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80051c:	8b 45 08             	mov    0x8(%ebp),%eax
  80051f:	01 c2                	add    %eax,%edx
  800521:	8b 45 0c             	mov    0xc(%ebp),%eax
  800524:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800527:	48                   	dec    %eax
  800528:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80052a:	ff 45 fc             	incl   -0x4(%ebp)
  80052d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800530:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800533:	7c dd                	jl     800512 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800535:	90                   	nop
  800536:	c9                   	leave  
  800537:	c3                   	ret    

00800538 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800538:	55                   	push   %ebp
  800539:	89 e5                	mov    %esp,%ebp
  80053b:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80053e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800541:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800546:	f7 e9                	imul   %ecx
  800548:	c1 f9 1f             	sar    $0x1f,%ecx
  80054b:	89 d0                	mov    %edx,%eax
  80054d:	29 c8                	sub    %ecx,%eax
  80054f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800552:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800559:	eb 1e                	jmp    800579 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80055b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80055e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800565:	8b 45 08             	mov    0x8(%ebp),%eax
  800568:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80056b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80056e:	99                   	cltd   
  80056f:	f7 7d f8             	idivl  -0x8(%ebp)
  800572:	89 d0                	mov    %edx,%eax
  800574:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800576:	ff 45 fc             	incl   -0x4(%ebp)
  800579:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80057c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80057f:	7c da                	jl     80055b <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  800581:	90                   	nop
  800582:	c9                   	leave  
  800583:	c3                   	ret    

00800584 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800584:	55                   	push   %ebp
  800585:	89 e5                	mov    %esp,%ebp
  800587:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  80058a:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800591:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800598:	eb 42                	jmp    8005dc <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  80059a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80059d:	99                   	cltd   
  80059e:	f7 7d f0             	idivl  -0x10(%ebp)
  8005a1:	89 d0                	mov    %edx,%eax
  8005a3:	85 c0                	test   %eax,%eax
  8005a5:	75 10                	jne    8005b7 <PrintElements+0x33>
			cprintf("\n");
  8005a7:	83 ec 0c             	sub    $0xc,%esp
  8005aa:	68 7e 26 80 00       	push   $0x80267e
  8005af:	e8 ac 04 00 00       	call   800a60 <cprintf>
  8005b4:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8005b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c4:	01 d0                	add    %edx,%eax
  8005c6:	8b 00                	mov    (%eax),%eax
  8005c8:	83 ec 08             	sub    $0x8,%esp
  8005cb:	50                   	push   %eax
  8005cc:	68 80 26 80 00       	push   $0x802680
  8005d1:	e8 8a 04 00 00       	call   800a60 <cprintf>
  8005d6:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005d9:	ff 45 f4             	incl   -0xc(%ebp)
  8005dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005df:	48                   	dec    %eax
  8005e0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8005e3:	7f b5                	jg     80059a <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8005e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f2:	01 d0                	add    %edx,%eax
  8005f4:	8b 00                	mov    (%eax),%eax
  8005f6:	83 ec 08             	sub    $0x8,%esp
  8005f9:	50                   	push   %eax
  8005fa:	68 85 26 80 00       	push   $0x802685
  8005ff:	e8 5c 04 00 00       	call   800a60 <cprintf>
  800604:	83 c4 10             	add    $0x10,%esp

}
  800607:	90                   	nop
  800608:	c9                   	leave  
  800609:	c3                   	ret    

0080060a <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80060a:	55                   	push   %ebp
  80060b:	89 e5                	mov    %esp,%ebp
  80060d:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800610:	8b 45 08             	mov    0x8(%ebp),%eax
  800613:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800616:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80061a:	83 ec 0c             	sub    $0xc,%esp
  80061d:	50                   	push   %eax
  80061e:	e8 cd 18 00 00       	call   801ef0 <sys_cputc>
  800623:	83 c4 10             	add    $0x10,%esp
}
  800626:	90                   	nop
  800627:	c9                   	leave  
  800628:	c3                   	ret    

00800629 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800629:	55                   	push   %ebp
  80062a:	89 e5                	mov    %esp,%ebp
  80062c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80062f:	e8 88 18 00 00       	call   801ebc <sys_disable_interrupt>
	char c = ch;
  800634:	8b 45 08             	mov    0x8(%ebp),%eax
  800637:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80063a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80063e:	83 ec 0c             	sub    $0xc,%esp
  800641:	50                   	push   %eax
  800642:	e8 a9 18 00 00       	call   801ef0 <sys_cputc>
  800647:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80064a:	e8 87 18 00 00       	call   801ed6 <sys_enable_interrupt>
}
  80064f:	90                   	nop
  800650:	c9                   	leave  
  800651:	c3                   	ret    

00800652 <getchar>:

int
getchar(void)
{
  800652:	55                   	push   %ebp
  800653:	89 e5                	mov    %esp,%ebp
  800655:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800658:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80065f:	eb 08                	jmp    800669 <getchar+0x17>
	{
		c = sys_cgetc();
  800661:	e8 6e 16 00 00       	call   801cd4 <sys_cgetc>
  800666:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800669:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80066d:	74 f2                	je     800661 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80066f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800672:	c9                   	leave  
  800673:	c3                   	ret    

00800674 <atomic_getchar>:

int
atomic_getchar(void)
{
  800674:	55                   	push   %ebp
  800675:	89 e5                	mov    %esp,%ebp
  800677:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80067a:	e8 3d 18 00 00       	call   801ebc <sys_disable_interrupt>
	int c=0;
  80067f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800686:	eb 08                	jmp    800690 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800688:	e8 47 16 00 00       	call   801cd4 <sys_cgetc>
  80068d:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800690:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800694:	74 f2                	je     800688 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800696:	e8 3b 18 00 00       	call   801ed6 <sys_enable_interrupt>
	return c;
  80069b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80069e:	c9                   	leave  
  80069f:	c3                   	ret    

008006a0 <iscons>:

int iscons(int fdnum)
{
  8006a0:	55                   	push   %ebp
  8006a1:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8006a3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8006a8:	5d                   	pop    %ebp
  8006a9:	c3                   	ret    

008006aa <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006aa:	55                   	push   %ebp
  8006ab:	89 e5                	mov    %esp,%ebp
  8006ad:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006b0:	e8 6c 16 00 00       	call   801d21 <sys_getenvindex>
  8006b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006bb:	89 d0                	mov    %edx,%eax
  8006bd:	01 c0                	add    %eax,%eax
  8006bf:	01 d0                	add    %edx,%eax
  8006c1:	c1 e0 02             	shl    $0x2,%eax
  8006c4:	01 d0                	add    %edx,%eax
  8006c6:	c1 e0 06             	shl    $0x6,%eax
  8006c9:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006ce:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006d3:	a1 24 30 80 00       	mov    0x803024,%eax
  8006d8:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8006de:	84 c0                	test   %al,%al
  8006e0:	74 0f                	je     8006f1 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8006e2:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e7:	05 f4 02 00 00       	add    $0x2f4,%eax
  8006ec:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006f1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006f5:	7e 0a                	jle    800701 <libmain+0x57>
		binaryname = argv[0];
  8006f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006fa:	8b 00                	mov    (%eax),%eax
  8006fc:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800701:	83 ec 08             	sub    $0x8,%esp
  800704:	ff 75 0c             	pushl  0xc(%ebp)
  800707:	ff 75 08             	pushl  0x8(%ebp)
  80070a:	e8 29 f9 ff ff       	call   800038 <_main>
  80070f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800712:	e8 a5 17 00 00       	call   801ebc <sys_disable_interrupt>
	cprintf("**************************************\n");
  800717:	83 ec 0c             	sub    $0xc,%esp
  80071a:	68 a4 26 80 00       	push   $0x8026a4
  80071f:	e8 3c 03 00 00       	call   800a60 <cprintf>
  800724:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800727:	a1 24 30 80 00       	mov    0x803024,%eax
  80072c:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800732:	a1 24 30 80 00       	mov    0x803024,%eax
  800737:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80073d:	83 ec 04             	sub    $0x4,%esp
  800740:	52                   	push   %edx
  800741:	50                   	push   %eax
  800742:	68 cc 26 80 00       	push   $0x8026cc
  800747:	e8 14 03 00 00       	call   800a60 <cprintf>
  80074c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80074f:	a1 24 30 80 00       	mov    0x803024,%eax
  800754:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80075a:	83 ec 08             	sub    $0x8,%esp
  80075d:	50                   	push   %eax
  80075e:	68 f1 26 80 00       	push   $0x8026f1
  800763:	e8 f8 02 00 00       	call   800a60 <cprintf>
  800768:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80076b:	83 ec 0c             	sub    $0xc,%esp
  80076e:	68 a4 26 80 00       	push   $0x8026a4
  800773:	e8 e8 02 00 00       	call   800a60 <cprintf>
  800778:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80077b:	e8 56 17 00 00       	call   801ed6 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800780:	e8 19 00 00 00       	call   80079e <exit>
}
  800785:	90                   	nop
  800786:	c9                   	leave  
  800787:	c3                   	ret    

00800788 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800788:	55                   	push   %ebp
  800789:	89 e5                	mov    %esp,%ebp
  80078b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80078e:	83 ec 0c             	sub    $0xc,%esp
  800791:	6a 00                	push   $0x0
  800793:	e8 55 15 00 00       	call   801ced <sys_env_destroy>
  800798:	83 c4 10             	add    $0x10,%esp
}
  80079b:	90                   	nop
  80079c:	c9                   	leave  
  80079d:	c3                   	ret    

0080079e <exit>:

void
exit(void)
{
  80079e:	55                   	push   %ebp
  80079f:	89 e5                	mov    %esp,%ebp
  8007a1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007a4:	e8 aa 15 00 00       	call   801d53 <sys_env_exit>
}
  8007a9:	90                   	nop
  8007aa:	c9                   	leave  
  8007ab:	c3                   	ret    

008007ac <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007ac:	55                   	push   %ebp
  8007ad:	89 e5                	mov    %esp,%ebp
  8007af:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007b2:	8d 45 10             	lea    0x10(%ebp),%eax
  8007b5:	83 c0 04             	add    $0x4,%eax
  8007b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8007bb:	a1 34 30 80 00       	mov    0x803034,%eax
  8007c0:	85 c0                	test   %eax,%eax
  8007c2:	74 16                	je     8007da <_panic+0x2e>
		cprintf("%s: ", argv0);
  8007c4:	a1 34 30 80 00       	mov    0x803034,%eax
  8007c9:	83 ec 08             	sub    $0x8,%esp
  8007cc:	50                   	push   %eax
  8007cd:	68 08 27 80 00       	push   $0x802708
  8007d2:	e8 89 02 00 00       	call   800a60 <cprintf>
  8007d7:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8007da:	a1 00 30 80 00       	mov    0x803000,%eax
  8007df:	ff 75 0c             	pushl  0xc(%ebp)
  8007e2:	ff 75 08             	pushl  0x8(%ebp)
  8007e5:	50                   	push   %eax
  8007e6:	68 0d 27 80 00       	push   $0x80270d
  8007eb:	e8 70 02 00 00       	call   800a60 <cprintf>
  8007f0:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f6:	83 ec 08             	sub    $0x8,%esp
  8007f9:	ff 75 f4             	pushl  -0xc(%ebp)
  8007fc:	50                   	push   %eax
  8007fd:	e8 f3 01 00 00       	call   8009f5 <vcprintf>
  800802:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800805:	83 ec 08             	sub    $0x8,%esp
  800808:	6a 00                	push   $0x0
  80080a:	68 29 27 80 00       	push   $0x802729
  80080f:	e8 e1 01 00 00       	call   8009f5 <vcprintf>
  800814:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800817:	e8 82 ff ff ff       	call   80079e <exit>

	// should not return here
	while (1) ;
  80081c:	eb fe                	jmp    80081c <_panic+0x70>

0080081e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80081e:	55                   	push   %ebp
  80081f:	89 e5                	mov    %esp,%ebp
  800821:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800824:	a1 24 30 80 00       	mov    0x803024,%eax
  800829:	8b 50 74             	mov    0x74(%eax),%edx
  80082c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082f:	39 c2                	cmp    %eax,%edx
  800831:	74 14                	je     800847 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800833:	83 ec 04             	sub    $0x4,%esp
  800836:	68 2c 27 80 00       	push   $0x80272c
  80083b:	6a 26                	push   $0x26
  80083d:	68 78 27 80 00       	push   $0x802778
  800842:	e8 65 ff ff ff       	call   8007ac <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800847:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80084e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800855:	e9 c2 00 00 00       	jmp    80091c <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80085a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80085d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800864:	8b 45 08             	mov    0x8(%ebp),%eax
  800867:	01 d0                	add    %edx,%eax
  800869:	8b 00                	mov    (%eax),%eax
  80086b:	85 c0                	test   %eax,%eax
  80086d:	75 08                	jne    800877 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80086f:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800872:	e9 a2 00 00 00       	jmp    800919 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800877:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80087e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800885:	eb 69                	jmp    8008f0 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800887:	a1 24 30 80 00       	mov    0x803024,%eax
  80088c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800892:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800895:	89 d0                	mov    %edx,%eax
  800897:	01 c0                	add    %eax,%eax
  800899:	01 d0                	add    %edx,%eax
  80089b:	c1 e0 02             	shl    $0x2,%eax
  80089e:	01 c8                	add    %ecx,%eax
  8008a0:	8a 40 04             	mov    0x4(%eax),%al
  8008a3:	84 c0                	test   %al,%al
  8008a5:	75 46                	jne    8008ed <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008a7:	a1 24 30 80 00       	mov    0x803024,%eax
  8008ac:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008b2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008b5:	89 d0                	mov    %edx,%eax
  8008b7:	01 c0                	add    %eax,%eax
  8008b9:	01 d0                	add    %edx,%eax
  8008bb:	c1 e0 02             	shl    $0x2,%eax
  8008be:	01 c8                	add    %ecx,%eax
  8008c0:	8b 00                	mov    (%eax),%eax
  8008c2:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8008c5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008c8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008cd:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8008cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d2:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dc:	01 c8                	add    %ecx,%eax
  8008de:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008e0:	39 c2                	cmp    %eax,%edx
  8008e2:	75 09                	jne    8008ed <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8008e4:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008eb:	eb 12                	jmp    8008ff <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ed:	ff 45 e8             	incl   -0x18(%ebp)
  8008f0:	a1 24 30 80 00       	mov    0x803024,%eax
  8008f5:	8b 50 74             	mov    0x74(%eax),%edx
  8008f8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008fb:	39 c2                	cmp    %eax,%edx
  8008fd:	77 88                	ja     800887 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800903:	75 14                	jne    800919 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800905:	83 ec 04             	sub    $0x4,%esp
  800908:	68 84 27 80 00       	push   $0x802784
  80090d:	6a 3a                	push   $0x3a
  80090f:	68 78 27 80 00       	push   $0x802778
  800914:	e8 93 fe ff ff       	call   8007ac <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800919:	ff 45 f0             	incl   -0x10(%ebp)
  80091c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80091f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800922:	0f 8c 32 ff ff ff    	jl     80085a <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800928:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80092f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800936:	eb 26                	jmp    80095e <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800938:	a1 24 30 80 00       	mov    0x803024,%eax
  80093d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800943:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800946:	89 d0                	mov    %edx,%eax
  800948:	01 c0                	add    %eax,%eax
  80094a:	01 d0                	add    %edx,%eax
  80094c:	c1 e0 02             	shl    $0x2,%eax
  80094f:	01 c8                	add    %ecx,%eax
  800951:	8a 40 04             	mov    0x4(%eax),%al
  800954:	3c 01                	cmp    $0x1,%al
  800956:	75 03                	jne    80095b <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800958:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80095b:	ff 45 e0             	incl   -0x20(%ebp)
  80095e:	a1 24 30 80 00       	mov    0x803024,%eax
  800963:	8b 50 74             	mov    0x74(%eax),%edx
  800966:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800969:	39 c2                	cmp    %eax,%edx
  80096b:	77 cb                	ja     800938 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80096d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800970:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800973:	74 14                	je     800989 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800975:	83 ec 04             	sub    $0x4,%esp
  800978:	68 d8 27 80 00       	push   $0x8027d8
  80097d:	6a 44                	push   $0x44
  80097f:	68 78 27 80 00       	push   $0x802778
  800984:	e8 23 fe ff ff       	call   8007ac <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800989:	90                   	nop
  80098a:	c9                   	leave  
  80098b:	c3                   	ret    

0080098c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80098c:	55                   	push   %ebp
  80098d:	89 e5                	mov    %esp,%ebp
  80098f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800992:	8b 45 0c             	mov    0xc(%ebp),%eax
  800995:	8b 00                	mov    (%eax),%eax
  800997:	8d 48 01             	lea    0x1(%eax),%ecx
  80099a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80099d:	89 0a                	mov    %ecx,(%edx)
  80099f:	8b 55 08             	mov    0x8(%ebp),%edx
  8009a2:	88 d1                	mov    %dl,%cl
  8009a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ae:	8b 00                	mov    (%eax),%eax
  8009b0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009b5:	75 2c                	jne    8009e3 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009b7:	a0 28 30 80 00       	mov    0x803028,%al
  8009bc:	0f b6 c0             	movzbl %al,%eax
  8009bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c2:	8b 12                	mov    (%edx),%edx
  8009c4:	89 d1                	mov    %edx,%ecx
  8009c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c9:	83 c2 08             	add    $0x8,%edx
  8009cc:	83 ec 04             	sub    $0x4,%esp
  8009cf:	50                   	push   %eax
  8009d0:	51                   	push   %ecx
  8009d1:	52                   	push   %edx
  8009d2:	e8 d4 12 00 00       	call   801cab <sys_cputs>
  8009d7:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8009da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e6:	8b 40 04             	mov    0x4(%eax),%eax
  8009e9:	8d 50 01             	lea    0x1(%eax),%edx
  8009ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ef:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009f2:	90                   	nop
  8009f3:	c9                   	leave  
  8009f4:	c3                   	ret    

008009f5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009f5:	55                   	push   %ebp
  8009f6:	89 e5                	mov    %esp,%ebp
  8009f8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009fe:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a05:	00 00 00 
	b.cnt = 0;
  800a08:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a0f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a12:	ff 75 0c             	pushl  0xc(%ebp)
  800a15:	ff 75 08             	pushl  0x8(%ebp)
  800a18:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a1e:	50                   	push   %eax
  800a1f:	68 8c 09 80 00       	push   $0x80098c
  800a24:	e8 11 02 00 00       	call   800c3a <vprintfmt>
  800a29:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a2c:	a0 28 30 80 00       	mov    0x803028,%al
  800a31:	0f b6 c0             	movzbl %al,%eax
  800a34:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a3a:	83 ec 04             	sub    $0x4,%esp
  800a3d:	50                   	push   %eax
  800a3e:	52                   	push   %edx
  800a3f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a45:	83 c0 08             	add    $0x8,%eax
  800a48:	50                   	push   %eax
  800a49:	e8 5d 12 00 00       	call   801cab <sys_cputs>
  800a4e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a51:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a58:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a5e:	c9                   	leave  
  800a5f:	c3                   	ret    

00800a60 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a60:	55                   	push   %ebp
  800a61:	89 e5                	mov    %esp,%ebp
  800a63:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a66:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a6d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a70:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a73:	8b 45 08             	mov    0x8(%ebp),%eax
  800a76:	83 ec 08             	sub    $0x8,%esp
  800a79:	ff 75 f4             	pushl  -0xc(%ebp)
  800a7c:	50                   	push   %eax
  800a7d:	e8 73 ff ff ff       	call   8009f5 <vcprintf>
  800a82:	83 c4 10             	add    $0x10,%esp
  800a85:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a88:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a8b:	c9                   	leave  
  800a8c:	c3                   	ret    

00800a8d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a8d:	55                   	push   %ebp
  800a8e:	89 e5                	mov    %esp,%ebp
  800a90:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a93:	e8 24 14 00 00       	call   801ebc <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a98:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa1:	83 ec 08             	sub    $0x8,%esp
  800aa4:	ff 75 f4             	pushl  -0xc(%ebp)
  800aa7:	50                   	push   %eax
  800aa8:	e8 48 ff ff ff       	call   8009f5 <vcprintf>
  800aad:	83 c4 10             	add    $0x10,%esp
  800ab0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800ab3:	e8 1e 14 00 00       	call   801ed6 <sys_enable_interrupt>
	return cnt;
  800ab8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800abb:	c9                   	leave  
  800abc:	c3                   	ret    

00800abd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800abd:	55                   	push   %ebp
  800abe:	89 e5                	mov    %esp,%ebp
  800ac0:	53                   	push   %ebx
  800ac1:	83 ec 14             	sub    $0x14,%esp
  800ac4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aca:	8b 45 14             	mov    0x14(%ebp),%eax
  800acd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800ad0:	8b 45 18             	mov    0x18(%ebp),%eax
  800ad3:	ba 00 00 00 00       	mov    $0x0,%edx
  800ad8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800adb:	77 55                	ja     800b32 <printnum+0x75>
  800add:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ae0:	72 05                	jb     800ae7 <printnum+0x2a>
  800ae2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ae5:	77 4b                	ja     800b32 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800ae7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800aea:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800aed:	8b 45 18             	mov    0x18(%ebp),%eax
  800af0:	ba 00 00 00 00       	mov    $0x0,%edx
  800af5:	52                   	push   %edx
  800af6:	50                   	push   %eax
  800af7:	ff 75 f4             	pushl  -0xc(%ebp)
  800afa:	ff 75 f0             	pushl  -0x10(%ebp)
  800afd:	e8 9a 17 00 00       	call   80229c <__udivdi3>
  800b02:	83 c4 10             	add    $0x10,%esp
  800b05:	83 ec 04             	sub    $0x4,%esp
  800b08:	ff 75 20             	pushl  0x20(%ebp)
  800b0b:	53                   	push   %ebx
  800b0c:	ff 75 18             	pushl  0x18(%ebp)
  800b0f:	52                   	push   %edx
  800b10:	50                   	push   %eax
  800b11:	ff 75 0c             	pushl  0xc(%ebp)
  800b14:	ff 75 08             	pushl  0x8(%ebp)
  800b17:	e8 a1 ff ff ff       	call   800abd <printnum>
  800b1c:	83 c4 20             	add    $0x20,%esp
  800b1f:	eb 1a                	jmp    800b3b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b21:	83 ec 08             	sub    $0x8,%esp
  800b24:	ff 75 0c             	pushl  0xc(%ebp)
  800b27:	ff 75 20             	pushl  0x20(%ebp)
  800b2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2d:	ff d0                	call   *%eax
  800b2f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b32:	ff 4d 1c             	decl   0x1c(%ebp)
  800b35:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b39:	7f e6                	jg     800b21 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b3b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b3e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b43:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b46:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b49:	53                   	push   %ebx
  800b4a:	51                   	push   %ecx
  800b4b:	52                   	push   %edx
  800b4c:	50                   	push   %eax
  800b4d:	e8 5a 18 00 00       	call   8023ac <__umoddi3>
  800b52:	83 c4 10             	add    $0x10,%esp
  800b55:	05 54 2a 80 00       	add    $0x802a54,%eax
  800b5a:	8a 00                	mov    (%eax),%al
  800b5c:	0f be c0             	movsbl %al,%eax
  800b5f:	83 ec 08             	sub    $0x8,%esp
  800b62:	ff 75 0c             	pushl  0xc(%ebp)
  800b65:	50                   	push   %eax
  800b66:	8b 45 08             	mov    0x8(%ebp),%eax
  800b69:	ff d0                	call   *%eax
  800b6b:	83 c4 10             	add    $0x10,%esp
}
  800b6e:	90                   	nop
  800b6f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b72:	c9                   	leave  
  800b73:	c3                   	ret    

00800b74 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b74:	55                   	push   %ebp
  800b75:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b77:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b7b:	7e 1c                	jle    800b99 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	8b 00                	mov    (%eax),%eax
  800b82:	8d 50 08             	lea    0x8(%eax),%edx
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
  800b88:	89 10                	mov    %edx,(%eax)
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	8b 00                	mov    (%eax),%eax
  800b8f:	83 e8 08             	sub    $0x8,%eax
  800b92:	8b 50 04             	mov    0x4(%eax),%edx
  800b95:	8b 00                	mov    (%eax),%eax
  800b97:	eb 40                	jmp    800bd9 <getuint+0x65>
	else if (lflag)
  800b99:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b9d:	74 1e                	je     800bbd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba2:	8b 00                	mov    (%eax),%eax
  800ba4:	8d 50 04             	lea    0x4(%eax),%edx
  800ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  800baa:	89 10                	mov    %edx,(%eax)
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	8b 00                	mov    (%eax),%eax
  800bb1:	83 e8 04             	sub    $0x4,%eax
  800bb4:	8b 00                	mov    (%eax),%eax
  800bb6:	ba 00 00 00 00       	mov    $0x0,%edx
  800bbb:	eb 1c                	jmp    800bd9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc0:	8b 00                	mov    (%eax),%eax
  800bc2:	8d 50 04             	lea    0x4(%eax),%edx
  800bc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc8:	89 10                	mov    %edx,(%eax)
  800bca:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcd:	8b 00                	mov    (%eax),%eax
  800bcf:	83 e8 04             	sub    $0x4,%eax
  800bd2:	8b 00                	mov    (%eax),%eax
  800bd4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800bd9:	5d                   	pop    %ebp
  800bda:	c3                   	ret    

00800bdb <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800bdb:	55                   	push   %ebp
  800bdc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bde:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800be2:	7e 1c                	jle    800c00 <getint+0x25>
		return va_arg(*ap, long long);
  800be4:	8b 45 08             	mov    0x8(%ebp),%eax
  800be7:	8b 00                	mov    (%eax),%eax
  800be9:	8d 50 08             	lea    0x8(%eax),%edx
  800bec:	8b 45 08             	mov    0x8(%ebp),%eax
  800bef:	89 10                	mov    %edx,(%eax)
  800bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf4:	8b 00                	mov    (%eax),%eax
  800bf6:	83 e8 08             	sub    $0x8,%eax
  800bf9:	8b 50 04             	mov    0x4(%eax),%edx
  800bfc:	8b 00                	mov    (%eax),%eax
  800bfe:	eb 38                	jmp    800c38 <getint+0x5d>
	else if (lflag)
  800c00:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c04:	74 1a                	je     800c20 <getint+0x45>
		return va_arg(*ap, long);
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	8b 00                	mov    (%eax),%eax
  800c0b:	8d 50 04             	lea    0x4(%eax),%edx
  800c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c11:	89 10                	mov    %edx,(%eax)
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	8b 00                	mov    (%eax),%eax
  800c18:	83 e8 04             	sub    $0x4,%eax
  800c1b:	8b 00                	mov    (%eax),%eax
  800c1d:	99                   	cltd   
  800c1e:	eb 18                	jmp    800c38 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
  800c23:	8b 00                	mov    (%eax),%eax
  800c25:	8d 50 04             	lea    0x4(%eax),%edx
  800c28:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2b:	89 10                	mov    %edx,(%eax)
  800c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c30:	8b 00                	mov    (%eax),%eax
  800c32:	83 e8 04             	sub    $0x4,%eax
  800c35:	8b 00                	mov    (%eax),%eax
  800c37:	99                   	cltd   
}
  800c38:	5d                   	pop    %ebp
  800c39:	c3                   	ret    

00800c3a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c3a:	55                   	push   %ebp
  800c3b:	89 e5                	mov    %esp,%ebp
  800c3d:	56                   	push   %esi
  800c3e:	53                   	push   %ebx
  800c3f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c42:	eb 17                	jmp    800c5b <vprintfmt+0x21>
			if (ch == '\0')
  800c44:	85 db                	test   %ebx,%ebx
  800c46:	0f 84 af 03 00 00    	je     800ffb <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c4c:	83 ec 08             	sub    $0x8,%esp
  800c4f:	ff 75 0c             	pushl  0xc(%ebp)
  800c52:	53                   	push   %ebx
  800c53:	8b 45 08             	mov    0x8(%ebp),%eax
  800c56:	ff d0                	call   *%eax
  800c58:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c5b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5e:	8d 50 01             	lea    0x1(%eax),%edx
  800c61:	89 55 10             	mov    %edx,0x10(%ebp)
  800c64:	8a 00                	mov    (%eax),%al
  800c66:	0f b6 d8             	movzbl %al,%ebx
  800c69:	83 fb 25             	cmp    $0x25,%ebx
  800c6c:	75 d6                	jne    800c44 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c6e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c72:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c79:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c80:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c87:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c8e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c91:	8d 50 01             	lea    0x1(%eax),%edx
  800c94:	89 55 10             	mov    %edx,0x10(%ebp)
  800c97:	8a 00                	mov    (%eax),%al
  800c99:	0f b6 d8             	movzbl %al,%ebx
  800c9c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c9f:	83 f8 55             	cmp    $0x55,%eax
  800ca2:	0f 87 2b 03 00 00    	ja     800fd3 <vprintfmt+0x399>
  800ca8:	8b 04 85 78 2a 80 00 	mov    0x802a78(,%eax,4),%eax
  800caf:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800cb1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cb5:	eb d7                	jmp    800c8e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800cb7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800cbb:	eb d1                	jmp    800c8e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cbd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800cc4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cc7:	89 d0                	mov    %edx,%eax
  800cc9:	c1 e0 02             	shl    $0x2,%eax
  800ccc:	01 d0                	add    %edx,%eax
  800cce:	01 c0                	add    %eax,%eax
  800cd0:	01 d8                	add    %ebx,%eax
  800cd2:	83 e8 30             	sub    $0x30,%eax
  800cd5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800cd8:	8b 45 10             	mov    0x10(%ebp),%eax
  800cdb:	8a 00                	mov    (%eax),%al
  800cdd:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ce0:	83 fb 2f             	cmp    $0x2f,%ebx
  800ce3:	7e 3e                	jle    800d23 <vprintfmt+0xe9>
  800ce5:	83 fb 39             	cmp    $0x39,%ebx
  800ce8:	7f 39                	jg     800d23 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cea:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ced:	eb d5                	jmp    800cc4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cef:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf2:	83 c0 04             	add    $0x4,%eax
  800cf5:	89 45 14             	mov    %eax,0x14(%ebp)
  800cf8:	8b 45 14             	mov    0x14(%ebp),%eax
  800cfb:	83 e8 04             	sub    $0x4,%eax
  800cfe:	8b 00                	mov    (%eax),%eax
  800d00:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d03:	eb 1f                	jmp    800d24 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d05:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d09:	79 83                	jns    800c8e <vprintfmt+0x54>
				width = 0;
  800d0b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d12:	e9 77 ff ff ff       	jmp    800c8e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d17:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d1e:	e9 6b ff ff ff       	jmp    800c8e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d23:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d24:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d28:	0f 89 60 ff ff ff    	jns    800c8e <vprintfmt+0x54>
				width = precision, precision = -1;
  800d2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d31:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d34:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d3b:	e9 4e ff ff ff       	jmp    800c8e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d40:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d43:	e9 46 ff ff ff       	jmp    800c8e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d48:	8b 45 14             	mov    0x14(%ebp),%eax
  800d4b:	83 c0 04             	add    $0x4,%eax
  800d4e:	89 45 14             	mov    %eax,0x14(%ebp)
  800d51:	8b 45 14             	mov    0x14(%ebp),%eax
  800d54:	83 e8 04             	sub    $0x4,%eax
  800d57:	8b 00                	mov    (%eax),%eax
  800d59:	83 ec 08             	sub    $0x8,%esp
  800d5c:	ff 75 0c             	pushl  0xc(%ebp)
  800d5f:	50                   	push   %eax
  800d60:	8b 45 08             	mov    0x8(%ebp),%eax
  800d63:	ff d0                	call   *%eax
  800d65:	83 c4 10             	add    $0x10,%esp
			break;
  800d68:	e9 89 02 00 00       	jmp    800ff6 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d6d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d70:	83 c0 04             	add    $0x4,%eax
  800d73:	89 45 14             	mov    %eax,0x14(%ebp)
  800d76:	8b 45 14             	mov    0x14(%ebp),%eax
  800d79:	83 e8 04             	sub    $0x4,%eax
  800d7c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d7e:	85 db                	test   %ebx,%ebx
  800d80:	79 02                	jns    800d84 <vprintfmt+0x14a>
				err = -err;
  800d82:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d84:	83 fb 64             	cmp    $0x64,%ebx
  800d87:	7f 0b                	jg     800d94 <vprintfmt+0x15a>
  800d89:	8b 34 9d c0 28 80 00 	mov    0x8028c0(,%ebx,4),%esi
  800d90:	85 f6                	test   %esi,%esi
  800d92:	75 19                	jne    800dad <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d94:	53                   	push   %ebx
  800d95:	68 65 2a 80 00       	push   $0x802a65
  800d9a:	ff 75 0c             	pushl  0xc(%ebp)
  800d9d:	ff 75 08             	pushl  0x8(%ebp)
  800da0:	e8 5e 02 00 00       	call   801003 <printfmt>
  800da5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800da8:	e9 49 02 00 00       	jmp    800ff6 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800dad:	56                   	push   %esi
  800dae:	68 6e 2a 80 00       	push   $0x802a6e
  800db3:	ff 75 0c             	pushl  0xc(%ebp)
  800db6:	ff 75 08             	pushl  0x8(%ebp)
  800db9:	e8 45 02 00 00       	call   801003 <printfmt>
  800dbe:	83 c4 10             	add    $0x10,%esp
			break;
  800dc1:	e9 30 02 00 00       	jmp    800ff6 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800dc6:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc9:	83 c0 04             	add    $0x4,%eax
  800dcc:	89 45 14             	mov    %eax,0x14(%ebp)
  800dcf:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd2:	83 e8 04             	sub    $0x4,%eax
  800dd5:	8b 30                	mov    (%eax),%esi
  800dd7:	85 f6                	test   %esi,%esi
  800dd9:	75 05                	jne    800de0 <vprintfmt+0x1a6>
				p = "(null)";
  800ddb:	be 71 2a 80 00       	mov    $0x802a71,%esi
			if (width > 0 && padc != '-')
  800de0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de4:	7e 6d                	jle    800e53 <vprintfmt+0x219>
  800de6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800dea:	74 67                	je     800e53 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800dec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800def:	83 ec 08             	sub    $0x8,%esp
  800df2:	50                   	push   %eax
  800df3:	56                   	push   %esi
  800df4:	e8 12 05 00 00       	call   80130b <strnlen>
  800df9:	83 c4 10             	add    $0x10,%esp
  800dfc:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800dff:	eb 16                	jmp    800e17 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e01:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e05:	83 ec 08             	sub    $0x8,%esp
  800e08:	ff 75 0c             	pushl  0xc(%ebp)
  800e0b:	50                   	push   %eax
  800e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0f:	ff d0                	call   *%eax
  800e11:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e14:	ff 4d e4             	decl   -0x1c(%ebp)
  800e17:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e1b:	7f e4                	jg     800e01 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e1d:	eb 34                	jmp    800e53 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e1f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e23:	74 1c                	je     800e41 <vprintfmt+0x207>
  800e25:	83 fb 1f             	cmp    $0x1f,%ebx
  800e28:	7e 05                	jle    800e2f <vprintfmt+0x1f5>
  800e2a:	83 fb 7e             	cmp    $0x7e,%ebx
  800e2d:	7e 12                	jle    800e41 <vprintfmt+0x207>
					putch('?', putdat);
  800e2f:	83 ec 08             	sub    $0x8,%esp
  800e32:	ff 75 0c             	pushl  0xc(%ebp)
  800e35:	6a 3f                	push   $0x3f
  800e37:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3a:	ff d0                	call   *%eax
  800e3c:	83 c4 10             	add    $0x10,%esp
  800e3f:	eb 0f                	jmp    800e50 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e41:	83 ec 08             	sub    $0x8,%esp
  800e44:	ff 75 0c             	pushl  0xc(%ebp)
  800e47:	53                   	push   %ebx
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	ff d0                	call   *%eax
  800e4d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e50:	ff 4d e4             	decl   -0x1c(%ebp)
  800e53:	89 f0                	mov    %esi,%eax
  800e55:	8d 70 01             	lea    0x1(%eax),%esi
  800e58:	8a 00                	mov    (%eax),%al
  800e5a:	0f be d8             	movsbl %al,%ebx
  800e5d:	85 db                	test   %ebx,%ebx
  800e5f:	74 24                	je     800e85 <vprintfmt+0x24b>
  800e61:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e65:	78 b8                	js     800e1f <vprintfmt+0x1e5>
  800e67:	ff 4d e0             	decl   -0x20(%ebp)
  800e6a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e6e:	79 af                	jns    800e1f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e70:	eb 13                	jmp    800e85 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e72:	83 ec 08             	sub    $0x8,%esp
  800e75:	ff 75 0c             	pushl  0xc(%ebp)
  800e78:	6a 20                	push   $0x20
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	ff d0                	call   *%eax
  800e7f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e82:	ff 4d e4             	decl   -0x1c(%ebp)
  800e85:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e89:	7f e7                	jg     800e72 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e8b:	e9 66 01 00 00       	jmp    800ff6 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e90:	83 ec 08             	sub    $0x8,%esp
  800e93:	ff 75 e8             	pushl  -0x18(%ebp)
  800e96:	8d 45 14             	lea    0x14(%ebp),%eax
  800e99:	50                   	push   %eax
  800e9a:	e8 3c fd ff ff       	call   800bdb <getint>
  800e9f:	83 c4 10             	add    $0x10,%esp
  800ea2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ea5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ea8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eae:	85 d2                	test   %edx,%edx
  800eb0:	79 23                	jns    800ed5 <vprintfmt+0x29b>
				putch('-', putdat);
  800eb2:	83 ec 08             	sub    $0x8,%esp
  800eb5:	ff 75 0c             	pushl  0xc(%ebp)
  800eb8:	6a 2d                	push   $0x2d
  800eba:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebd:	ff d0                	call   *%eax
  800ebf:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ec2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ec5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ec8:	f7 d8                	neg    %eax
  800eca:	83 d2 00             	adc    $0x0,%edx
  800ecd:	f7 da                	neg    %edx
  800ecf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ed5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800edc:	e9 bc 00 00 00       	jmp    800f9d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ee1:	83 ec 08             	sub    $0x8,%esp
  800ee4:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee7:	8d 45 14             	lea    0x14(%ebp),%eax
  800eea:	50                   	push   %eax
  800eeb:	e8 84 fc ff ff       	call   800b74 <getuint>
  800ef0:	83 c4 10             	add    $0x10,%esp
  800ef3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ef9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f00:	e9 98 00 00 00       	jmp    800f9d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f05:	83 ec 08             	sub    $0x8,%esp
  800f08:	ff 75 0c             	pushl  0xc(%ebp)
  800f0b:	6a 58                	push   $0x58
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	ff d0                	call   *%eax
  800f12:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f15:	83 ec 08             	sub    $0x8,%esp
  800f18:	ff 75 0c             	pushl  0xc(%ebp)
  800f1b:	6a 58                	push   $0x58
  800f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f20:	ff d0                	call   *%eax
  800f22:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f25:	83 ec 08             	sub    $0x8,%esp
  800f28:	ff 75 0c             	pushl  0xc(%ebp)
  800f2b:	6a 58                	push   $0x58
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f30:	ff d0                	call   *%eax
  800f32:	83 c4 10             	add    $0x10,%esp
			break;
  800f35:	e9 bc 00 00 00       	jmp    800ff6 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f3a:	83 ec 08             	sub    $0x8,%esp
  800f3d:	ff 75 0c             	pushl  0xc(%ebp)
  800f40:	6a 30                	push   $0x30
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	ff d0                	call   *%eax
  800f47:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f4a:	83 ec 08             	sub    $0x8,%esp
  800f4d:	ff 75 0c             	pushl  0xc(%ebp)
  800f50:	6a 78                	push   $0x78
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	ff d0                	call   *%eax
  800f57:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f5a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f5d:	83 c0 04             	add    $0x4,%eax
  800f60:	89 45 14             	mov    %eax,0x14(%ebp)
  800f63:	8b 45 14             	mov    0x14(%ebp),%eax
  800f66:	83 e8 04             	sub    $0x4,%eax
  800f69:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f75:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f7c:	eb 1f                	jmp    800f9d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f7e:	83 ec 08             	sub    $0x8,%esp
  800f81:	ff 75 e8             	pushl  -0x18(%ebp)
  800f84:	8d 45 14             	lea    0x14(%ebp),%eax
  800f87:	50                   	push   %eax
  800f88:	e8 e7 fb ff ff       	call   800b74 <getuint>
  800f8d:	83 c4 10             	add    $0x10,%esp
  800f90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f93:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f96:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f9d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fa1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fa4:	83 ec 04             	sub    $0x4,%esp
  800fa7:	52                   	push   %edx
  800fa8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800fab:	50                   	push   %eax
  800fac:	ff 75 f4             	pushl  -0xc(%ebp)
  800faf:	ff 75 f0             	pushl  -0x10(%ebp)
  800fb2:	ff 75 0c             	pushl  0xc(%ebp)
  800fb5:	ff 75 08             	pushl  0x8(%ebp)
  800fb8:	e8 00 fb ff ff       	call   800abd <printnum>
  800fbd:	83 c4 20             	add    $0x20,%esp
			break;
  800fc0:	eb 34                	jmp    800ff6 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800fc2:	83 ec 08             	sub    $0x8,%esp
  800fc5:	ff 75 0c             	pushl  0xc(%ebp)
  800fc8:	53                   	push   %ebx
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	ff d0                	call   *%eax
  800fce:	83 c4 10             	add    $0x10,%esp
			break;
  800fd1:	eb 23                	jmp    800ff6 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800fd3:	83 ec 08             	sub    $0x8,%esp
  800fd6:	ff 75 0c             	pushl  0xc(%ebp)
  800fd9:	6a 25                	push   $0x25
  800fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fde:	ff d0                	call   *%eax
  800fe0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fe3:	ff 4d 10             	decl   0x10(%ebp)
  800fe6:	eb 03                	jmp    800feb <vprintfmt+0x3b1>
  800fe8:	ff 4d 10             	decl   0x10(%ebp)
  800feb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fee:	48                   	dec    %eax
  800fef:	8a 00                	mov    (%eax),%al
  800ff1:	3c 25                	cmp    $0x25,%al
  800ff3:	75 f3                	jne    800fe8 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ff5:	90                   	nop
		}
	}
  800ff6:	e9 47 fc ff ff       	jmp    800c42 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ffb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ffc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fff:	5b                   	pop    %ebx
  801000:	5e                   	pop    %esi
  801001:	5d                   	pop    %ebp
  801002:	c3                   	ret    

00801003 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801003:	55                   	push   %ebp
  801004:	89 e5                	mov    %esp,%ebp
  801006:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801009:	8d 45 10             	lea    0x10(%ebp),%eax
  80100c:	83 c0 04             	add    $0x4,%eax
  80100f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801012:	8b 45 10             	mov    0x10(%ebp),%eax
  801015:	ff 75 f4             	pushl  -0xc(%ebp)
  801018:	50                   	push   %eax
  801019:	ff 75 0c             	pushl  0xc(%ebp)
  80101c:	ff 75 08             	pushl  0x8(%ebp)
  80101f:	e8 16 fc ff ff       	call   800c3a <vprintfmt>
  801024:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801027:	90                   	nop
  801028:	c9                   	leave  
  801029:	c3                   	ret    

0080102a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80102a:	55                   	push   %ebp
  80102b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80102d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801030:	8b 40 08             	mov    0x8(%eax),%eax
  801033:	8d 50 01             	lea    0x1(%eax),%edx
  801036:	8b 45 0c             	mov    0xc(%ebp),%eax
  801039:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80103c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103f:	8b 10                	mov    (%eax),%edx
  801041:	8b 45 0c             	mov    0xc(%ebp),%eax
  801044:	8b 40 04             	mov    0x4(%eax),%eax
  801047:	39 c2                	cmp    %eax,%edx
  801049:	73 12                	jae    80105d <sprintputch+0x33>
		*b->buf++ = ch;
  80104b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104e:	8b 00                	mov    (%eax),%eax
  801050:	8d 48 01             	lea    0x1(%eax),%ecx
  801053:	8b 55 0c             	mov    0xc(%ebp),%edx
  801056:	89 0a                	mov    %ecx,(%edx)
  801058:	8b 55 08             	mov    0x8(%ebp),%edx
  80105b:	88 10                	mov    %dl,(%eax)
}
  80105d:	90                   	nop
  80105e:	5d                   	pop    %ebp
  80105f:	c3                   	ret    

00801060 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801060:	55                   	push   %ebp
  801061:	89 e5                	mov    %esp,%ebp
  801063:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801066:	8b 45 08             	mov    0x8(%ebp),%eax
  801069:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80106c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801072:	8b 45 08             	mov    0x8(%ebp),%eax
  801075:	01 d0                	add    %edx,%eax
  801077:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80107a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801081:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801085:	74 06                	je     80108d <vsnprintf+0x2d>
  801087:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80108b:	7f 07                	jg     801094 <vsnprintf+0x34>
		return -E_INVAL;
  80108d:	b8 03 00 00 00       	mov    $0x3,%eax
  801092:	eb 20                	jmp    8010b4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801094:	ff 75 14             	pushl  0x14(%ebp)
  801097:	ff 75 10             	pushl  0x10(%ebp)
  80109a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80109d:	50                   	push   %eax
  80109e:	68 2a 10 80 00       	push   $0x80102a
  8010a3:	e8 92 fb ff ff       	call   800c3a <vprintfmt>
  8010a8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010ae:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010b4:	c9                   	leave  
  8010b5:	c3                   	ret    

008010b6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010b6:	55                   	push   %ebp
  8010b7:	89 e5                	mov    %esp,%ebp
  8010b9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010bc:	8d 45 10             	lea    0x10(%ebp),%eax
  8010bf:	83 c0 04             	add    $0x4,%eax
  8010c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8010c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c8:	ff 75 f4             	pushl  -0xc(%ebp)
  8010cb:	50                   	push   %eax
  8010cc:	ff 75 0c             	pushl  0xc(%ebp)
  8010cf:	ff 75 08             	pushl  0x8(%ebp)
  8010d2:	e8 89 ff ff ff       	call   801060 <vsnprintf>
  8010d7:	83 c4 10             	add    $0x10,%esp
  8010da:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010e0:	c9                   	leave  
  8010e1:	c3                   	ret    

008010e2 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010e2:	55                   	push   %ebp
  8010e3:	89 e5                	mov    %esp,%ebp
  8010e5:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010e8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010ec:	74 13                	je     801101 <readline+0x1f>
		cprintf("%s", prompt);
  8010ee:	83 ec 08             	sub    $0x8,%esp
  8010f1:	ff 75 08             	pushl  0x8(%ebp)
  8010f4:	68 d0 2b 80 00       	push   $0x802bd0
  8010f9:	e8 62 f9 ff ff       	call   800a60 <cprintf>
  8010fe:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801101:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801108:	83 ec 0c             	sub    $0xc,%esp
  80110b:	6a 00                	push   $0x0
  80110d:	e8 8e f5 ff ff       	call   8006a0 <iscons>
  801112:	83 c4 10             	add    $0x10,%esp
  801115:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801118:	e8 35 f5 ff ff       	call   800652 <getchar>
  80111d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801120:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801124:	79 22                	jns    801148 <readline+0x66>
			if (c != -E_EOF)
  801126:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80112a:	0f 84 ad 00 00 00    	je     8011dd <readline+0xfb>
				cprintf("read error: %e\n", c);
  801130:	83 ec 08             	sub    $0x8,%esp
  801133:	ff 75 ec             	pushl  -0x14(%ebp)
  801136:	68 d3 2b 80 00       	push   $0x802bd3
  80113b:	e8 20 f9 ff ff       	call   800a60 <cprintf>
  801140:	83 c4 10             	add    $0x10,%esp
			return;
  801143:	e9 95 00 00 00       	jmp    8011dd <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801148:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80114c:	7e 34                	jle    801182 <readline+0xa0>
  80114e:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801155:	7f 2b                	jg     801182 <readline+0xa0>
			if (echoing)
  801157:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80115b:	74 0e                	je     80116b <readline+0x89>
				cputchar(c);
  80115d:	83 ec 0c             	sub    $0xc,%esp
  801160:	ff 75 ec             	pushl  -0x14(%ebp)
  801163:	e8 a2 f4 ff ff       	call   80060a <cputchar>
  801168:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80116b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80116e:	8d 50 01             	lea    0x1(%eax),%edx
  801171:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801174:	89 c2                	mov    %eax,%edx
  801176:	8b 45 0c             	mov    0xc(%ebp),%eax
  801179:	01 d0                	add    %edx,%eax
  80117b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80117e:	88 10                	mov    %dl,(%eax)
  801180:	eb 56                	jmp    8011d8 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801182:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801186:	75 1f                	jne    8011a7 <readline+0xc5>
  801188:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80118c:	7e 19                	jle    8011a7 <readline+0xc5>
			if (echoing)
  80118e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801192:	74 0e                	je     8011a2 <readline+0xc0>
				cputchar(c);
  801194:	83 ec 0c             	sub    $0xc,%esp
  801197:	ff 75 ec             	pushl  -0x14(%ebp)
  80119a:	e8 6b f4 ff ff       	call   80060a <cputchar>
  80119f:	83 c4 10             	add    $0x10,%esp

			i--;
  8011a2:	ff 4d f4             	decl   -0xc(%ebp)
  8011a5:	eb 31                	jmp    8011d8 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8011a7:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011ab:	74 0a                	je     8011b7 <readline+0xd5>
  8011ad:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011b1:	0f 85 61 ff ff ff    	jne    801118 <readline+0x36>
			if (echoing)
  8011b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011bb:	74 0e                	je     8011cb <readline+0xe9>
				cputchar(c);
  8011bd:	83 ec 0c             	sub    $0xc,%esp
  8011c0:	ff 75 ec             	pushl  -0x14(%ebp)
  8011c3:	e8 42 f4 ff ff       	call   80060a <cputchar>
  8011c8:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8011cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d1:	01 d0                	add    %edx,%eax
  8011d3:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8011d6:	eb 06                	jmp    8011de <readline+0xfc>
		}
	}
  8011d8:	e9 3b ff ff ff       	jmp    801118 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8011dd:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8011de:	c9                   	leave  
  8011df:	c3                   	ret    

008011e0 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011e0:	55                   	push   %ebp
  8011e1:	89 e5                	mov    %esp,%ebp
  8011e3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011e6:	e8 d1 0c 00 00       	call   801ebc <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011eb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011ef:	74 13                	je     801204 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011f1:	83 ec 08             	sub    $0x8,%esp
  8011f4:	ff 75 08             	pushl  0x8(%ebp)
  8011f7:	68 d0 2b 80 00       	push   $0x802bd0
  8011fc:	e8 5f f8 ff ff       	call   800a60 <cprintf>
  801201:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801204:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80120b:	83 ec 0c             	sub    $0xc,%esp
  80120e:	6a 00                	push   $0x0
  801210:	e8 8b f4 ff ff       	call   8006a0 <iscons>
  801215:	83 c4 10             	add    $0x10,%esp
  801218:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80121b:	e8 32 f4 ff ff       	call   800652 <getchar>
  801220:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801223:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801227:	79 23                	jns    80124c <atomic_readline+0x6c>
			if (c != -E_EOF)
  801229:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80122d:	74 13                	je     801242 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80122f:	83 ec 08             	sub    $0x8,%esp
  801232:	ff 75 ec             	pushl  -0x14(%ebp)
  801235:	68 d3 2b 80 00       	push   $0x802bd3
  80123a:	e8 21 f8 ff ff       	call   800a60 <cprintf>
  80123f:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801242:	e8 8f 0c 00 00       	call   801ed6 <sys_enable_interrupt>
			return;
  801247:	e9 9a 00 00 00       	jmp    8012e6 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80124c:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801250:	7e 34                	jle    801286 <atomic_readline+0xa6>
  801252:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801259:	7f 2b                	jg     801286 <atomic_readline+0xa6>
			if (echoing)
  80125b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80125f:	74 0e                	je     80126f <atomic_readline+0x8f>
				cputchar(c);
  801261:	83 ec 0c             	sub    $0xc,%esp
  801264:	ff 75 ec             	pushl  -0x14(%ebp)
  801267:	e8 9e f3 ff ff       	call   80060a <cputchar>
  80126c:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80126f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801272:	8d 50 01             	lea    0x1(%eax),%edx
  801275:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801278:	89 c2                	mov    %eax,%edx
  80127a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127d:	01 d0                	add    %edx,%eax
  80127f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801282:	88 10                	mov    %dl,(%eax)
  801284:	eb 5b                	jmp    8012e1 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801286:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80128a:	75 1f                	jne    8012ab <atomic_readline+0xcb>
  80128c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801290:	7e 19                	jle    8012ab <atomic_readline+0xcb>
			if (echoing)
  801292:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801296:	74 0e                	je     8012a6 <atomic_readline+0xc6>
				cputchar(c);
  801298:	83 ec 0c             	sub    $0xc,%esp
  80129b:	ff 75 ec             	pushl  -0x14(%ebp)
  80129e:	e8 67 f3 ff ff       	call   80060a <cputchar>
  8012a3:	83 c4 10             	add    $0x10,%esp
			i--;
  8012a6:	ff 4d f4             	decl   -0xc(%ebp)
  8012a9:	eb 36                	jmp    8012e1 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012ab:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012af:	74 0a                	je     8012bb <atomic_readline+0xdb>
  8012b1:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012b5:	0f 85 60 ff ff ff    	jne    80121b <atomic_readline+0x3b>
			if (echoing)
  8012bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012bf:	74 0e                	je     8012cf <atomic_readline+0xef>
				cputchar(c);
  8012c1:	83 ec 0c             	sub    $0xc,%esp
  8012c4:	ff 75 ec             	pushl  -0x14(%ebp)
  8012c7:	e8 3e f3 ff ff       	call   80060a <cputchar>
  8012cc:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8012cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d5:	01 d0                	add    %edx,%eax
  8012d7:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8012da:	e8 f7 0b 00 00       	call   801ed6 <sys_enable_interrupt>
			return;
  8012df:	eb 05                	jmp    8012e6 <atomic_readline+0x106>
		}
	}
  8012e1:	e9 35 ff ff ff       	jmp    80121b <atomic_readline+0x3b>
}
  8012e6:	c9                   	leave  
  8012e7:	c3                   	ret    

008012e8 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012e8:	55                   	push   %ebp
  8012e9:	89 e5                	mov    %esp,%ebp
  8012eb:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012f5:	eb 06                	jmp    8012fd <strlen+0x15>
		n++;
  8012f7:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012fa:	ff 45 08             	incl   0x8(%ebp)
  8012fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801300:	8a 00                	mov    (%eax),%al
  801302:	84 c0                	test   %al,%al
  801304:	75 f1                	jne    8012f7 <strlen+0xf>
		n++;
	return n;
  801306:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801309:	c9                   	leave  
  80130a:	c3                   	ret    

0080130b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80130b:	55                   	push   %ebp
  80130c:	89 e5                	mov    %esp,%ebp
  80130e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801311:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801318:	eb 09                	jmp    801323 <strnlen+0x18>
		n++;
  80131a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80131d:	ff 45 08             	incl   0x8(%ebp)
  801320:	ff 4d 0c             	decl   0xc(%ebp)
  801323:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801327:	74 09                	je     801332 <strnlen+0x27>
  801329:	8b 45 08             	mov    0x8(%ebp),%eax
  80132c:	8a 00                	mov    (%eax),%al
  80132e:	84 c0                	test   %al,%al
  801330:	75 e8                	jne    80131a <strnlen+0xf>
		n++;
	return n;
  801332:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801335:	c9                   	leave  
  801336:	c3                   	ret    

00801337 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801337:	55                   	push   %ebp
  801338:	89 e5                	mov    %esp,%ebp
  80133a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80133d:	8b 45 08             	mov    0x8(%ebp),%eax
  801340:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801343:	90                   	nop
  801344:	8b 45 08             	mov    0x8(%ebp),%eax
  801347:	8d 50 01             	lea    0x1(%eax),%edx
  80134a:	89 55 08             	mov    %edx,0x8(%ebp)
  80134d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801350:	8d 4a 01             	lea    0x1(%edx),%ecx
  801353:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801356:	8a 12                	mov    (%edx),%dl
  801358:	88 10                	mov    %dl,(%eax)
  80135a:	8a 00                	mov    (%eax),%al
  80135c:	84 c0                	test   %al,%al
  80135e:	75 e4                	jne    801344 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801360:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801363:	c9                   	leave  
  801364:	c3                   	ret    

00801365 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801365:	55                   	push   %ebp
  801366:	89 e5                	mov    %esp,%ebp
  801368:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801371:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801378:	eb 1f                	jmp    801399 <strncpy+0x34>
		*dst++ = *src;
  80137a:	8b 45 08             	mov    0x8(%ebp),%eax
  80137d:	8d 50 01             	lea    0x1(%eax),%edx
  801380:	89 55 08             	mov    %edx,0x8(%ebp)
  801383:	8b 55 0c             	mov    0xc(%ebp),%edx
  801386:	8a 12                	mov    (%edx),%dl
  801388:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80138a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138d:	8a 00                	mov    (%eax),%al
  80138f:	84 c0                	test   %al,%al
  801391:	74 03                	je     801396 <strncpy+0x31>
			src++;
  801393:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801396:	ff 45 fc             	incl   -0x4(%ebp)
  801399:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80139c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80139f:	72 d9                	jb     80137a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013a4:	c9                   	leave  
  8013a5:	c3                   	ret    

008013a6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013a6:	55                   	push   %ebp
  8013a7:	89 e5                	mov    %esp,%ebp
  8013a9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8013af:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013b6:	74 30                	je     8013e8 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013b8:	eb 16                	jmp    8013d0 <strlcpy+0x2a>
			*dst++ = *src++;
  8013ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bd:	8d 50 01             	lea    0x1(%eax),%edx
  8013c0:	89 55 08             	mov    %edx,0x8(%ebp)
  8013c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013c9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013cc:	8a 12                	mov    (%edx),%dl
  8013ce:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013d0:	ff 4d 10             	decl   0x10(%ebp)
  8013d3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d7:	74 09                	je     8013e2 <strlcpy+0x3c>
  8013d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013dc:	8a 00                	mov    (%eax),%al
  8013de:	84 c0                	test   %al,%al
  8013e0:	75 d8                	jne    8013ba <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e5:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013e8:	8b 55 08             	mov    0x8(%ebp),%edx
  8013eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ee:	29 c2                	sub    %eax,%edx
  8013f0:	89 d0                	mov    %edx,%eax
}
  8013f2:	c9                   	leave  
  8013f3:	c3                   	ret    

008013f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013f4:	55                   	push   %ebp
  8013f5:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013f7:	eb 06                	jmp    8013ff <strcmp+0xb>
		p++, q++;
  8013f9:	ff 45 08             	incl   0x8(%ebp)
  8013fc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	8a 00                	mov    (%eax),%al
  801404:	84 c0                	test   %al,%al
  801406:	74 0e                	je     801416 <strcmp+0x22>
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
  80140b:	8a 10                	mov    (%eax),%dl
  80140d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801410:	8a 00                	mov    (%eax),%al
  801412:	38 c2                	cmp    %al,%dl
  801414:	74 e3                	je     8013f9 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801416:	8b 45 08             	mov    0x8(%ebp),%eax
  801419:	8a 00                	mov    (%eax),%al
  80141b:	0f b6 d0             	movzbl %al,%edx
  80141e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801421:	8a 00                	mov    (%eax),%al
  801423:	0f b6 c0             	movzbl %al,%eax
  801426:	29 c2                	sub    %eax,%edx
  801428:	89 d0                	mov    %edx,%eax
}
  80142a:	5d                   	pop    %ebp
  80142b:	c3                   	ret    

0080142c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80142c:	55                   	push   %ebp
  80142d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80142f:	eb 09                	jmp    80143a <strncmp+0xe>
		n--, p++, q++;
  801431:	ff 4d 10             	decl   0x10(%ebp)
  801434:	ff 45 08             	incl   0x8(%ebp)
  801437:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80143a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80143e:	74 17                	je     801457 <strncmp+0x2b>
  801440:	8b 45 08             	mov    0x8(%ebp),%eax
  801443:	8a 00                	mov    (%eax),%al
  801445:	84 c0                	test   %al,%al
  801447:	74 0e                	je     801457 <strncmp+0x2b>
  801449:	8b 45 08             	mov    0x8(%ebp),%eax
  80144c:	8a 10                	mov    (%eax),%dl
  80144e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801451:	8a 00                	mov    (%eax),%al
  801453:	38 c2                	cmp    %al,%dl
  801455:	74 da                	je     801431 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801457:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80145b:	75 07                	jne    801464 <strncmp+0x38>
		return 0;
  80145d:	b8 00 00 00 00       	mov    $0x0,%eax
  801462:	eb 14                	jmp    801478 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801464:	8b 45 08             	mov    0x8(%ebp),%eax
  801467:	8a 00                	mov    (%eax),%al
  801469:	0f b6 d0             	movzbl %al,%edx
  80146c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146f:	8a 00                	mov    (%eax),%al
  801471:	0f b6 c0             	movzbl %al,%eax
  801474:	29 c2                	sub    %eax,%edx
  801476:	89 d0                	mov    %edx,%eax
}
  801478:	5d                   	pop    %ebp
  801479:	c3                   	ret    

0080147a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80147a:	55                   	push   %ebp
  80147b:	89 e5                	mov    %esp,%ebp
  80147d:	83 ec 04             	sub    $0x4,%esp
  801480:	8b 45 0c             	mov    0xc(%ebp),%eax
  801483:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801486:	eb 12                	jmp    80149a <strchr+0x20>
		if (*s == c)
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	8a 00                	mov    (%eax),%al
  80148d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801490:	75 05                	jne    801497 <strchr+0x1d>
			return (char *) s;
  801492:	8b 45 08             	mov    0x8(%ebp),%eax
  801495:	eb 11                	jmp    8014a8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801497:	ff 45 08             	incl   0x8(%ebp)
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	8a 00                	mov    (%eax),%al
  80149f:	84 c0                	test   %al,%al
  8014a1:	75 e5                	jne    801488 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014a8:	c9                   	leave  
  8014a9:	c3                   	ret    

008014aa <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014aa:	55                   	push   %ebp
  8014ab:	89 e5                	mov    %esp,%ebp
  8014ad:	83 ec 04             	sub    $0x4,%esp
  8014b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014b6:	eb 0d                	jmp    8014c5 <strfind+0x1b>
		if (*s == c)
  8014b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bb:	8a 00                	mov    (%eax),%al
  8014bd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014c0:	74 0e                	je     8014d0 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014c2:	ff 45 08             	incl   0x8(%ebp)
  8014c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c8:	8a 00                	mov    (%eax),%al
  8014ca:	84 c0                	test   %al,%al
  8014cc:	75 ea                	jne    8014b8 <strfind+0xe>
  8014ce:	eb 01                	jmp    8014d1 <strfind+0x27>
		if (*s == c)
			break;
  8014d0:	90                   	nop
	return (char *) s;
  8014d1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014d4:	c9                   	leave  
  8014d5:	c3                   	ret    

008014d6 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014d6:	55                   	push   %ebp
  8014d7:	89 e5                	mov    %esp,%ebp
  8014d9:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014e8:	eb 0e                	jmp    8014f8 <memset+0x22>
		*p++ = c;
  8014ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ed:	8d 50 01             	lea    0x1(%eax),%edx
  8014f0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f6:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014f8:	ff 4d f8             	decl   -0x8(%ebp)
  8014fb:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014ff:	79 e9                	jns    8014ea <memset+0x14>
		*p++ = c;

	return v;
  801501:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801504:	c9                   	leave  
  801505:	c3                   	ret    

00801506 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801506:	55                   	push   %ebp
  801507:	89 e5                	mov    %esp,%ebp
  801509:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80150c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801512:	8b 45 08             	mov    0x8(%ebp),%eax
  801515:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801518:	eb 16                	jmp    801530 <memcpy+0x2a>
		*d++ = *s++;
  80151a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80151d:	8d 50 01             	lea    0x1(%eax),%edx
  801520:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801523:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801526:	8d 4a 01             	lea    0x1(%edx),%ecx
  801529:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80152c:	8a 12                	mov    (%edx),%dl
  80152e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801530:	8b 45 10             	mov    0x10(%ebp),%eax
  801533:	8d 50 ff             	lea    -0x1(%eax),%edx
  801536:	89 55 10             	mov    %edx,0x10(%ebp)
  801539:	85 c0                	test   %eax,%eax
  80153b:	75 dd                	jne    80151a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80153d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801540:	c9                   	leave  
  801541:	c3                   	ret    

00801542 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801542:	55                   	push   %ebp
  801543:	89 e5                	mov    %esp,%ebp
  801545:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801548:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80154e:	8b 45 08             	mov    0x8(%ebp),%eax
  801551:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801554:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801557:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80155a:	73 50                	jae    8015ac <memmove+0x6a>
  80155c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80155f:	8b 45 10             	mov    0x10(%ebp),%eax
  801562:	01 d0                	add    %edx,%eax
  801564:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801567:	76 43                	jbe    8015ac <memmove+0x6a>
		s += n;
  801569:	8b 45 10             	mov    0x10(%ebp),%eax
  80156c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80156f:	8b 45 10             	mov    0x10(%ebp),%eax
  801572:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801575:	eb 10                	jmp    801587 <memmove+0x45>
			*--d = *--s;
  801577:	ff 4d f8             	decl   -0x8(%ebp)
  80157a:	ff 4d fc             	decl   -0x4(%ebp)
  80157d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801580:	8a 10                	mov    (%eax),%dl
  801582:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801585:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801587:	8b 45 10             	mov    0x10(%ebp),%eax
  80158a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80158d:	89 55 10             	mov    %edx,0x10(%ebp)
  801590:	85 c0                	test   %eax,%eax
  801592:	75 e3                	jne    801577 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801594:	eb 23                	jmp    8015b9 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801596:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801599:	8d 50 01             	lea    0x1(%eax),%edx
  80159c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80159f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015a2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015a5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015a8:	8a 12                	mov    (%edx),%dl
  8015aa:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8015af:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015b2:	89 55 10             	mov    %edx,0x10(%ebp)
  8015b5:	85 c0                	test   %eax,%eax
  8015b7:	75 dd                	jne    801596 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015b9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015bc:	c9                   	leave  
  8015bd:	c3                   	ret    

008015be <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015be:	55                   	push   %ebp
  8015bf:	89 e5                	mov    %esp,%ebp
  8015c1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015cd:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015d0:	eb 2a                	jmp    8015fc <memcmp+0x3e>
		if (*s1 != *s2)
  8015d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d5:	8a 10                	mov    (%eax),%dl
  8015d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015da:	8a 00                	mov    (%eax),%al
  8015dc:	38 c2                	cmp    %al,%dl
  8015de:	74 16                	je     8015f6 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e3:	8a 00                	mov    (%eax),%al
  8015e5:	0f b6 d0             	movzbl %al,%edx
  8015e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015eb:	8a 00                	mov    (%eax),%al
  8015ed:	0f b6 c0             	movzbl %al,%eax
  8015f0:	29 c2                	sub    %eax,%edx
  8015f2:	89 d0                	mov    %edx,%eax
  8015f4:	eb 18                	jmp    80160e <memcmp+0x50>
		s1++, s2++;
  8015f6:	ff 45 fc             	incl   -0x4(%ebp)
  8015f9:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ff:	8d 50 ff             	lea    -0x1(%eax),%edx
  801602:	89 55 10             	mov    %edx,0x10(%ebp)
  801605:	85 c0                	test   %eax,%eax
  801607:	75 c9                	jne    8015d2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801609:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80160e:	c9                   	leave  
  80160f:	c3                   	ret    

00801610 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801610:	55                   	push   %ebp
  801611:	89 e5                	mov    %esp,%ebp
  801613:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801616:	8b 55 08             	mov    0x8(%ebp),%edx
  801619:	8b 45 10             	mov    0x10(%ebp),%eax
  80161c:	01 d0                	add    %edx,%eax
  80161e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801621:	eb 15                	jmp    801638 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801623:	8b 45 08             	mov    0x8(%ebp),%eax
  801626:	8a 00                	mov    (%eax),%al
  801628:	0f b6 d0             	movzbl %al,%edx
  80162b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80162e:	0f b6 c0             	movzbl %al,%eax
  801631:	39 c2                	cmp    %eax,%edx
  801633:	74 0d                	je     801642 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801635:	ff 45 08             	incl   0x8(%ebp)
  801638:	8b 45 08             	mov    0x8(%ebp),%eax
  80163b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80163e:	72 e3                	jb     801623 <memfind+0x13>
  801640:	eb 01                	jmp    801643 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801642:	90                   	nop
	return (void *) s;
  801643:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801646:	c9                   	leave  
  801647:	c3                   	ret    

00801648 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801648:	55                   	push   %ebp
  801649:	89 e5                	mov    %esp,%ebp
  80164b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80164e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801655:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80165c:	eb 03                	jmp    801661 <strtol+0x19>
		s++;
  80165e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801661:	8b 45 08             	mov    0x8(%ebp),%eax
  801664:	8a 00                	mov    (%eax),%al
  801666:	3c 20                	cmp    $0x20,%al
  801668:	74 f4                	je     80165e <strtol+0x16>
  80166a:	8b 45 08             	mov    0x8(%ebp),%eax
  80166d:	8a 00                	mov    (%eax),%al
  80166f:	3c 09                	cmp    $0x9,%al
  801671:	74 eb                	je     80165e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801673:	8b 45 08             	mov    0x8(%ebp),%eax
  801676:	8a 00                	mov    (%eax),%al
  801678:	3c 2b                	cmp    $0x2b,%al
  80167a:	75 05                	jne    801681 <strtol+0x39>
		s++;
  80167c:	ff 45 08             	incl   0x8(%ebp)
  80167f:	eb 13                	jmp    801694 <strtol+0x4c>
	else if (*s == '-')
  801681:	8b 45 08             	mov    0x8(%ebp),%eax
  801684:	8a 00                	mov    (%eax),%al
  801686:	3c 2d                	cmp    $0x2d,%al
  801688:	75 0a                	jne    801694 <strtol+0x4c>
		s++, neg = 1;
  80168a:	ff 45 08             	incl   0x8(%ebp)
  80168d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801694:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801698:	74 06                	je     8016a0 <strtol+0x58>
  80169a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80169e:	75 20                	jne    8016c0 <strtol+0x78>
  8016a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a3:	8a 00                	mov    (%eax),%al
  8016a5:	3c 30                	cmp    $0x30,%al
  8016a7:	75 17                	jne    8016c0 <strtol+0x78>
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	40                   	inc    %eax
  8016ad:	8a 00                	mov    (%eax),%al
  8016af:	3c 78                	cmp    $0x78,%al
  8016b1:	75 0d                	jne    8016c0 <strtol+0x78>
		s += 2, base = 16;
  8016b3:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016b7:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016be:	eb 28                	jmp    8016e8 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016c4:	75 15                	jne    8016db <strtol+0x93>
  8016c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c9:	8a 00                	mov    (%eax),%al
  8016cb:	3c 30                	cmp    $0x30,%al
  8016cd:	75 0c                	jne    8016db <strtol+0x93>
		s++, base = 8;
  8016cf:	ff 45 08             	incl   0x8(%ebp)
  8016d2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016d9:	eb 0d                	jmp    8016e8 <strtol+0xa0>
	else if (base == 0)
  8016db:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016df:	75 07                	jne    8016e8 <strtol+0xa0>
		base = 10;
  8016e1:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016eb:	8a 00                	mov    (%eax),%al
  8016ed:	3c 2f                	cmp    $0x2f,%al
  8016ef:	7e 19                	jle    80170a <strtol+0xc2>
  8016f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f4:	8a 00                	mov    (%eax),%al
  8016f6:	3c 39                	cmp    $0x39,%al
  8016f8:	7f 10                	jg     80170a <strtol+0xc2>
			dig = *s - '0';
  8016fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fd:	8a 00                	mov    (%eax),%al
  8016ff:	0f be c0             	movsbl %al,%eax
  801702:	83 e8 30             	sub    $0x30,%eax
  801705:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801708:	eb 42                	jmp    80174c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80170a:	8b 45 08             	mov    0x8(%ebp),%eax
  80170d:	8a 00                	mov    (%eax),%al
  80170f:	3c 60                	cmp    $0x60,%al
  801711:	7e 19                	jle    80172c <strtol+0xe4>
  801713:	8b 45 08             	mov    0x8(%ebp),%eax
  801716:	8a 00                	mov    (%eax),%al
  801718:	3c 7a                	cmp    $0x7a,%al
  80171a:	7f 10                	jg     80172c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80171c:	8b 45 08             	mov    0x8(%ebp),%eax
  80171f:	8a 00                	mov    (%eax),%al
  801721:	0f be c0             	movsbl %al,%eax
  801724:	83 e8 57             	sub    $0x57,%eax
  801727:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80172a:	eb 20                	jmp    80174c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80172c:	8b 45 08             	mov    0x8(%ebp),%eax
  80172f:	8a 00                	mov    (%eax),%al
  801731:	3c 40                	cmp    $0x40,%al
  801733:	7e 39                	jle    80176e <strtol+0x126>
  801735:	8b 45 08             	mov    0x8(%ebp),%eax
  801738:	8a 00                	mov    (%eax),%al
  80173a:	3c 5a                	cmp    $0x5a,%al
  80173c:	7f 30                	jg     80176e <strtol+0x126>
			dig = *s - 'A' + 10;
  80173e:	8b 45 08             	mov    0x8(%ebp),%eax
  801741:	8a 00                	mov    (%eax),%al
  801743:	0f be c0             	movsbl %al,%eax
  801746:	83 e8 37             	sub    $0x37,%eax
  801749:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80174c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80174f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801752:	7d 19                	jge    80176d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801754:	ff 45 08             	incl   0x8(%ebp)
  801757:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80175a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80175e:	89 c2                	mov    %eax,%edx
  801760:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801763:	01 d0                	add    %edx,%eax
  801765:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801768:	e9 7b ff ff ff       	jmp    8016e8 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80176d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80176e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801772:	74 08                	je     80177c <strtol+0x134>
		*endptr = (char *) s;
  801774:	8b 45 0c             	mov    0xc(%ebp),%eax
  801777:	8b 55 08             	mov    0x8(%ebp),%edx
  80177a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80177c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801780:	74 07                	je     801789 <strtol+0x141>
  801782:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801785:	f7 d8                	neg    %eax
  801787:	eb 03                	jmp    80178c <strtol+0x144>
  801789:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80178c:	c9                   	leave  
  80178d:	c3                   	ret    

0080178e <ltostr>:

void
ltostr(long value, char *str)
{
  80178e:	55                   	push   %ebp
  80178f:	89 e5                	mov    %esp,%ebp
  801791:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801794:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80179b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017a2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017a6:	79 13                	jns    8017bb <ltostr+0x2d>
	{
		neg = 1;
  8017a8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b2:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017b5:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017b8:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017be:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017c3:	99                   	cltd   
  8017c4:	f7 f9                	idiv   %ecx
  8017c6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017cc:	8d 50 01             	lea    0x1(%eax),%edx
  8017cf:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017d2:	89 c2                	mov    %eax,%edx
  8017d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d7:	01 d0                	add    %edx,%eax
  8017d9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017dc:	83 c2 30             	add    $0x30,%edx
  8017df:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017e1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017e4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017e9:	f7 e9                	imul   %ecx
  8017eb:	c1 fa 02             	sar    $0x2,%edx
  8017ee:	89 c8                	mov    %ecx,%eax
  8017f0:	c1 f8 1f             	sar    $0x1f,%eax
  8017f3:	29 c2                	sub    %eax,%edx
  8017f5:	89 d0                	mov    %edx,%eax
  8017f7:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017fa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017fd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801802:	f7 e9                	imul   %ecx
  801804:	c1 fa 02             	sar    $0x2,%edx
  801807:	89 c8                	mov    %ecx,%eax
  801809:	c1 f8 1f             	sar    $0x1f,%eax
  80180c:	29 c2                	sub    %eax,%edx
  80180e:	89 d0                	mov    %edx,%eax
  801810:	c1 e0 02             	shl    $0x2,%eax
  801813:	01 d0                	add    %edx,%eax
  801815:	01 c0                	add    %eax,%eax
  801817:	29 c1                	sub    %eax,%ecx
  801819:	89 ca                	mov    %ecx,%edx
  80181b:	85 d2                	test   %edx,%edx
  80181d:	75 9c                	jne    8017bb <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80181f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801826:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801829:	48                   	dec    %eax
  80182a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80182d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801831:	74 3d                	je     801870 <ltostr+0xe2>
		start = 1 ;
  801833:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80183a:	eb 34                	jmp    801870 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80183c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80183f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801842:	01 d0                	add    %edx,%eax
  801844:	8a 00                	mov    (%eax),%al
  801846:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801849:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80184c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184f:	01 c2                	add    %eax,%edx
  801851:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801854:	8b 45 0c             	mov    0xc(%ebp),%eax
  801857:	01 c8                	add    %ecx,%eax
  801859:	8a 00                	mov    (%eax),%al
  80185b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80185d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801860:	8b 45 0c             	mov    0xc(%ebp),%eax
  801863:	01 c2                	add    %eax,%edx
  801865:	8a 45 eb             	mov    -0x15(%ebp),%al
  801868:	88 02                	mov    %al,(%edx)
		start++ ;
  80186a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80186d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801870:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801873:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801876:	7c c4                	jl     80183c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801878:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80187b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80187e:	01 d0                	add    %edx,%eax
  801880:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801883:	90                   	nop
  801884:	c9                   	leave  
  801885:	c3                   	ret    

00801886 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801886:	55                   	push   %ebp
  801887:	89 e5                	mov    %esp,%ebp
  801889:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80188c:	ff 75 08             	pushl  0x8(%ebp)
  80188f:	e8 54 fa ff ff       	call   8012e8 <strlen>
  801894:	83 c4 04             	add    $0x4,%esp
  801897:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80189a:	ff 75 0c             	pushl  0xc(%ebp)
  80189d:	e8 46 fa ff ff       	call   8012e8 <strlen>
  8018a2:	83 c4 04             	add    $0x4,%esp
  8018a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018b6:	eb 17                	jmp    8018cf <strcconcat+0x49>
		final[s] = str1[s] ;
  8018b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8018be:	01 c2                	add    %eax,%edx
  8018c0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c6:	01 c8                	add    %ecx,%eax
  8018c8:	8a 00                	mov    (%eax),%al
  8018ca:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8018cc:	ff 45 fc             	incl   -0x4(%ebp)
  8018cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018d2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018d5:	7c e1                	jl     8018b8 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018d7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018de:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018e5:	eb 1f                	jmp    801906 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018ea:	8d 50 01             	lea    0x1(%eax),%edx
  8018ed:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018f0:	89 c2                	mov    %eax,%edx
  8018f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f5:	01 c2                	add    %eax,%edx
  8018f7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018fd:	01 c8                	add    %ecx,%eax
  8018ff:	8a 00                	mov    (%eax),%al
  801901:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801903:	ff 45 f8             	incl   -0x8(%ebp)
  801906:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801909:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80190c:	7c d9                	jl     8018e7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80190e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801911:	8b 45 10             	mov    0x10(%ebp),%eax
  801914:	01 d0                	add    %edx,%eax
  801916:	c6 00 00             	movb   $0x0,(%eax)
}
  801919:	90                   	nop
  80191a:	c9                   	leave  
  80191b:	c3                   	ret    

0080191c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80191c:	55                   	push   %ebp
  80191d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80191f:	8b 45 14             	mov    0x14(%ebp),%eax
  801922:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801928:	8b 45 14             	mov    0x14(%ebp),%eax
  80192b:	8b 00                	mov    (%eax),%eax
  80192d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801934:	8b 45 10             	mov    0x10(%ebp),%eax
  801937:	01 d0                	add    %edx,%eax
  801939:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80193f:	eb 0c                	jmp    80194d <strsplit+0x31>
			*string++ = 0;
  801941:	8b 45 08             	mov    0x8(%ebp),%eax
  801944:	8d 50 01             	lea    0x1(%eax),%edx
  801947:	89 55 08             	mov    %edx,0x8(%ebp)
  80194a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80194d:	8b 45 08             	mov    0x8(%ebp),%eax
  801950:	8a 00                	mov    (%eax),%al
  801952:	84 c0                	test   %al,%al
  801954:	74 18                	je     80196e <strsplit+0x52>
  801956:	8b 45 08             	mov    0x8(%ebp),%eax
  801959:	8a 00                	mov    (%eax),%al
  80195b:	0f be c0             	movsbl %al,%eax
  80195e:	50                   	push   %eax
  80195f:	ff 75 0c             	pushl  0xc(%ebp)
  801962:	e8 13 fb ff ff       	call   80147a <strchr>
  801967:	83 c4 08             	add    $0x8,%esp
  80196a:	85 c0                	test   %eax,%eax
  80196c:	75 d3                	jne    801941 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80196e:	8b 45 08             	mov    0x8(%ebp),%eax
  801971:	8a 00                	mov    (%eax),%al
  801973:	84 c0                	test   %al,%al
  801975:	74 5a                	je     8019d1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801977:	8b 45 14             	mov    0x14(%ebp),%eax
  80197a:	8b 00                	mov    (%eax),%eax
  80197c:	83 f8 0f             	cmp    $0xf,%eax
  80197f:	75 07                	jne    801988 <strsplit+0x6c>
		{
			return 0;
  801981:	b8 00 00 00 00       	mov    $0x0,%eax
  801986:	eb 66                	jmp    8019ee <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801988:	8b 45 14             	mov    0x14(%ebp),%eax
  80198b:	8b 00                	mov    (%eax),%eax
  80198d:	8d 48 01             	lea    0x1(%eax),%ecx
  801990:	8b 55 14             	mov    0x14(%ebp),%edx
  801993:	89 0a                	mov    %ecx,(%edx)
  801995:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80199c:	8b 45 10             	mov    0x10(%ebp),%eax
  80199f:	01 c2                	add    %eax,%edx
  8019a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019a6:	eb 03                	jmp    8019ab <strsplit+0x8f>
			string++;
  8019a8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ae:	8a 00                	mov    (%eax),%al
  8019b0:	84 c0                	test   %al,%al
  8019b2:	74 8b                	je     80193f <strsplit+0x23>
  8019b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b7:	8a 00                	mov    (%eax),%al
  8019b9:	0f be c0             	movsbl %al,%eax
  8019bc:	50                   	push   %eax
  8019bd:	ff 75 0c             	pushl  0xc(%ebp)
  8019c0:	e8 b5 fa ff ff       	call   80147a <strchr>
  8019c5:	83 c4 08             	add    $0x8,%esp
  8019c8:	85 c0                	test   %eax,%eax
  8019ca:	74 dc                	je     8019a8 <strsplit+0x8c>
			string++;
	}
  8019cc:	e9 6e ff ff ff       	jmp    80193f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019d1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8019d5:	8b 00                	mov    (%eax),%eax
  8019d7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019de:	8b 45 10             	mov    0x10(%ebp),%eax
  8019e1:	01 d0                	add    %edx,%eax
  8019e3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019e9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019ee:	c9                   	leave  
  8019ef:	c3                   	ret    

008019f0 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8019f0:	55                   	push   %ebp
  8019f1:	89 e5                	mov    %esp,%ebp
  8019f3:	83 ec 18             	sub    $0x18,%esp
  8019f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f9:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8019fc:	83 ec 04             	sub    $0x4,%esp
  8019ff:	68 e4 2b 80 00       	push   $0x802be4
  801a04:	6a 17                	push   $0x17
  801a06:	68 03 2c 80 00       	push   $0x802c03
  801a0b:	e8 9c ed ff ff       	call   8007ac <_panic>

00801a10 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a10:	55                   	push   %ebp
  801a11:	89 e5                	mov    %esp,%ebp
  801a13:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801a16:	83 ec 04             	sub    $0x4,%esp
  801a19:	68 0f 2c 80 00       	push   $0x802c0f
  801a1e:	6a 2f                	push   $0x2f
  801a20:	68 03 2c 80 00       	push   $0x802c03
  801a25:	e8 82 ed ff ff       	call   8007ac <_panic>

00801a2a <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
  801a2d:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801a30:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801a37:	8b 55 08             	mov    0x8(%ebp),%edx
  801a3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a3d:	01 d0                	add    %edx,%eax
  801a3f:	48                   	dec    %eax
  801a40:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801a43:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a46:	ba 00 00 00 00       	mov    $0x0,%edx
  801a4b:	f7 75 ec             	divl   -0x14(%ebp)
  801a4e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a51:	29 d0                	sub    %edx,%eax
  801a53:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801a56:	8b 45 08             	mov    0x8(%ebp),%eax
  801a59:	c1 e8 0c             	shr    $0xc,%eax
  801a5c:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801a5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801a66:	e9 c8 00 00 00       	jmp    801b33 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801a6b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a72:	eb 27                	jmp    801a9b <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801a74:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a7a:	01 c2                	add    %eax,%edx
  801a7c:	89 d0                	mov    %edx,%eax
  801a7e:	01 c0                	add    %eax,%eax
  801a80:	01 d0                	add    %edx,%eax
  801a82:	c1 e0 02             	shl    $0x2,%eax
  801a85:	05 48 30 80 00       	add    $0x803048,%eax
  801a8a:	8b 00                	mov    (%eax),%eax
  801a8c:	85 c0                	test   %eax,%eax
  801a8e:	74 08                	je     801a98 <malloc+0x6e>
            	i += j;
  801a90:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a93:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801a96:	eb 0b                	jmp    801aa3 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801a98:	ff 45 f0             	incl   -0x10(%ebp)
  801a9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a9e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801aa1:	72 d1                	jb     801a74 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801aa3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801aa6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801aa9:	0f 85 81 00 00 00    	jne    801b30 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801aaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ab2:	05 00 00 08 00       	add    $0x80000,%eax
  801ab7:	c1 e0 0c             	shl    $0xc,%eax
  801aba:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801abd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ac4:	eb 1f                	jmp    801ae5 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801ac6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801acc:	01 c2                	add    %eax,%edx
  801ace:	89 d0                	mov    %edx,%eax
  801ad0:	01 c0                	add    %eax,%eax
  801ad2:	01 d0                	add    %edx,%eax
  801ad4:	c1 e0 02             	shl    $0x2,%eax
  801ad7:	05 48 30 80 00       	add    $0x803048,%eax
  801adc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801ae2:	ff 45 f0             	incl   -0x10(%ebp)
  801ae5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ae8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801aeb:	72 d9                	jb     801ac6 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801aed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801af0:	89 d0                	mov    %edx,%eax
  801af2:	01 c0                	add    %eax,%eax
  801af4:	01 d0                	add    %edx,%eax
  801af6:	c1 e0 02             	shl    $0x2,%eax
  801af9:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801aff:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b02:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801b04:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801b07:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801b0a:	89 c8                	mov    %ecx,%eax
  801b0c:	01 c0                	add    %eax,%eax
  801b0e:	01 c8                	add    %ecx,%eax
  801b10:	c1 e0 02             	shl    $0x2,%eax
  801b13:	05 44 30 80 00       	add    $0x803044,%eax
  801b18:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801b1a:	83 ec 08             	sub    $0x8,%esp
  801b1d:	ff 75 08             	pushl  0x8(%ebp)
  801b20:	ff 75 e0             	pushl  -0x20(%ebp)
  801b23:	e8 2b 03 00 00       	call   801e53 <sys_allocateMem>
  801b28:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801b2b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b2e:	eb 19                	jmp    801b49 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801b30:	ff 45 f4             	incl   -0xc(%ebp)
  801b33:	a1 04 30 80 00       	mov    0x803004,%eax
  801b38:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801b3b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b3e:	0f 83 27 ff ff ff    	jae    801a6b <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801b44:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b49:	c9                   	leave  
  801b4a:	c3                   	ret    

00801b4b <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801b4b:	55                   	push   %ebp
  801b4c:	89 e5                	mov    %esp,%ebp
  801b4e:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801b51:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801b55:	0f 84 e5 00 00 00    	je     801c40 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801b61:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b64:	05 00 00 00 80       	add    $0x80000000,%eax
  801b69:	c1 e8 0c             	shr    $0xc,%eax
  801b6c:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801b6f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b72:	89 d0                	mov    %edx,%eax
  801b74:	01 c0                	add    %eax,%eax
  801b76:	01 d0                	add    %edx,%eax
  801b78:	c1 e0 02             	shl    $0x2,%eax
  801b7b:	05 40 30 80 00       	add    $0x803040,%eax
  801b80:	8b 00                	mov    (%eax),%eax
  801b82:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b85:	0f 85 b8 00 00 00    	jne    801c43 <free+0xf8>
  801b8b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b8e:	89 d0                	mov    %edx,%eax
  801b90:	01 c0                	add    %eax,%eax
  801b92:	01 d0                	add    %edx,%eax
  801b94:	c1 e0 02             	shl    $0x2,%eax
  801b97:	05 48 30 80 00       	add    $0x803048,%eax
  801b9c:	8b 00                	mov    (%eax),%eax
  801b9e:	85 c0                	test   %eax,%eax
  801ba0:	0f 84 9d 00 00 00    	je     801c43 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801ba6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ba9:	89 d0                	mov    %edx,%eax
  801bab:	01 c0                	add    %eax,%eax
  801bad:	01 d0                	add    %edx,%eax
  801baf:	c1 e0 02             	shl    $0x2,%eax
  801bb2:	05 44 30 80 00       	add    $0x803044,%eax
  801bb7:	8b 00                	mov    (%eax),%eax
  801bb9:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801bbc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801bbf:	c1 e0 0c             	shl    $0xc,%eax
  801bc2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801bc5:	83 ec 08             	sub    $0x8,%esp
  801bc8:	ff 75 e4             	pushl  -0x1c(%ebp)
  801bcb:	ff 75 f0             	pushl  -0x10(%ebp)
  801bce:	e8 64 02 00 00       	call   801e37 <sys_freeMem>
  801bd3:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801bd6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801bdd:	eb 57                	jmp    801c36 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801bdf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801be2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801be5:	01 c2                	add    %eax,%edx
  801be7:	89 d0                	mov    %edx,%eax
  801be9:	01 c0                	add    %eax,%eax
  801beb:	01 d0                	add    %edx,%eax
  801bed:	c1 e0 02             	shl    $0x2,%eax
  801bf0:	05 48 30 80 00       	add    $0x803048,%eax
  801bf5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801bfb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801bfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c01:	01 c2                	add    %eax,%edx
  801c03:	89 d0                	mov    %edx,%eax
  801c05:	01 c0                	add    %eax,%eax
  801c07:	01 d0                	add    %edx,%eax
  801c09:	c1 e0 02             	shl    $0x2,%eax
  801c0c:	05 40 30 80 00       	add    $0x803040,%eax
  801c11:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801c17:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c1d:	01 c2                	add    %eax,%edx
  801c1f:	89 d0                	mov    %edx,%eax
  801c21:	01 c0                	add    %eax,%eax
  801c23:	01 d0                	add    %edx,%eax
  801c25:	c1 e0 02             	shl    $0x2,%eax
  801c28:	05 44 30 80 00       	add    $0x803044,%eax
  801c2d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801c33:	ff 45 f4             	incl   -0xc(%ebp)
  801c36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c39:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c3c:	7c a1                	jl     801bdf <free+0x94>
  801c3e:	eb 04                	jmp    801c44 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801c40:	90                   	nop
  801c41:	eb 01                	jmp    801c44 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801c43:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801c44:	c9                   	leave  
  801c45:	c3                   	ret    

00801c46 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801c46:	55                   	push   %ebp
  801c47:	89 e5                	mov    %esp,%ebp
  801c49:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801c4c:	83 ec 04             	sub    $0x4,%esp
  801c4f:	68 2c 2c 80 00       	push   $0x802c2c
  801c54:	68 ae 00 00 00       	push   $0xae
  801c59:	68 03 2c 80 00       	push   $0x802c03
  801c5e:	e8 49 eb ff ff       	call   8007ac <_panic>

00801c63 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801c63:	55                   	push   %ebp
  801c64:	89 e5                	mov    %esp,%ebp
  801c66:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801c69:	83 ec 04             	sub    $0x4,%esp
  801c6c:	68 4c 2c 80 00       	push   $0x802c4c
  801c71:	68 ca 00 00 00       	push   $0xca
  801c76:	68 03 2c 80 00       	push   $0x802c03
  801c7b:	e8 2c eb ff ff       	call   8007ac <_panic>

00801c80 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c80:	55                   	push   %ebp
  801c81:	89 e5                	mov    %esp,%ebp
  801c83:	57                   	push   %edi
  801c84:	56                   	push   %esi
  801c85:	53                   	push   %ebx
  801c86:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c89:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c8f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c92:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c95:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c98:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c9b:	cd 30                	int    $0x30
  801c9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ca0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ca3:	83 c4 10             	add    $0x10,%esp
  801ca6:	5b                   	pop    %ebx
  801ca7:	5e                   	pop    %esi
  801ca8:	5f                   	pop    %edi
  801ca9:	5d                   	pop    %ebp
  801caa:	c3                   	ret    

00801cab <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801cab:	55                   	push   %ebp
  801cac:	89 e5                	mov    %esp,%ebp
  801cae:	83 ec 04             	sub    $0x4,%esp
  801cb1:	8b 45 10             	mov    0x10(%ebp),%eax
  801cb4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801cb7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	52                   	push   %edx
  801cc3:	ff 75 0c             	pushl  0xc(%ebp)
  801cc6:	50                   	push   %eax
  801cc7:	6a 00                	push   $0x0
  801cc9:	e8 b2 ff ff ff       	call   801c80 <syscall>
  801cce:	83 c4 18             	add    $0x18,%esp
}
  801cd1:	90                   	nop
  801cd2:	c9                   	leave  
  801cd3:	c3                   	ret    

00801cd4 <sys_cgetc>:

int
sys_cgetc(void)
{
  801cd4:	55                   	push   %ebp
  801cd5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 01                	push   $0x1
  801ce3:	e8 98 ff ff ff       	call   801c80 <syscall>
  801ce8:	83 c4 18             	add    $0x18,%esp
}
  801ceb:	c9                   	leave  
  801cec:	c3                   	ret    

00801ced <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ced:	55                   	push   %ebp
  801cee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	50                   	push   %eax
  801cfc:	6a 05                	push   $0x5
  801cfe:	e8 7d ff ff ff       	call   801c80 <syscall>
  801d03:	83 c4 18             	add    $0x18,%esp
}
  801d06:	c9                   	leave  
  801d07:	c3                   	ret    

00801d08 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801d08:	55                   	push   %ebp
  801d09:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	6a 02                	push   $0x2
  801d17:	e8 64 ff ff ff       	call   801c80 <syscall>
  801d1c:	83 c4 18             	add    $0x18,%esp
}
  801d1f:	c9                   	leave  
  801d20:	c3                   	ret    

00801d21 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d21:	55                   	push   %ebp
  801d22:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 03                	push   $0x3
  801d30:	e8 4b ff ff ff       	call   801c80 <syscall>
  801d35:	83 c4 18             	add    $0x18,%esp
}
  801d38:	c9                   	leave  
  801d39:	c3                   	ret    

00801d3a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d3a:	55                   	push   %ebp
  801d3b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 04                	push   $0x4
  801d49:	e8 32 ff ff ff       	call   801c80 <syscall>
  801d4e:	83 c4 18             	add    $0x18,%esp
}
  801d51:	c9                   	leave  
  801d52:	c3                   	ret    

00801d53 <sys_env_exit>:


void sys_env_exit(void)
{
  801d53:	55                   	push   %ebp
  801d54:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d56:	6a 00                	push   $0x0
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 06                	push   $0x6
  801d62:	e8 19 ff ff ff       	call   801c80 <syscall>
  801d67:	83 c4 18             	add    $0x18,%esp
}
  801d6a:	90                   	nop
  801d6b:	c9                   	leave  
  801d6c:	c3                   	ret    

00801d6d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d6d:	55                   	push   %ebp
  801d6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d70:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d73:	8b 45 08             	mov    0x8(%ebp),%eax
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 00                	push   $0x0
  801d7c:	52                   	push   %edx
  801d7d:	50                   	push   %eax
  801d7e:	6a 07                	push   $0x7
  801d80:	e8 fb fe ff ff       	call   801c80 <syscall>
  801d85:	83 c4 18             	add    $0x18,%esp
}
  801d88:	c9                   	leave  
  801d89:	c3                   	ret    

00801d8a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d8a:	55                   	push   %ebp
  801d8b:	89 e5                	mov    %esp,%ebp
  801d8d:	56                   	push   %esi
  801d8e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d8f:	8b 75 18             	mov    0x18(%ebp),%esi
  801d92:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d95:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d98:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9e:	56                   	push   %esi
  801d9f:	53                   	push   %ebx
  801da0:	51                   	push   %ecx
  801da1:	52                   	push   %edx
  801da2:	50                   	push   %eax
  801da3:	6a 08                	push   $0x8
  801da5:	e8 d6 fe ff ff       	call   801c80 <syscall>
  801daa:	83 c4 18             	add    $0x18,%esp
}
  801dad:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801db0:	5b                   	pop    %ebx
  801db1:	5e                   	pop    %esi
  801db2:	5d                   	pop    %ebp
  801db3:	c3                   	ret    

00801db4 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801db4:	55                   	push   %ebp
  801db5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801db7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dba:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	52                   	push   %edx
  801dc4:	50                   	push   %eax
  801dc5:	6a 09                	push   $0x9
  801dc7:	e8 b4 fe ff ff       	call   801c80 <syscall>
  801dcc:	83 c4 18             	add    $0x18,%esp
}
  801dcf:	c9                   	leave  
  801dd0:	c3                   	ret    

00801dd1 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801dd1:	55                   	push   %ebp
  801dd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	ff 75 0c             	pushl  0xc(%ebp)
  801ddd:	ff 75 08             	pushl  0x8(%ebp)
  801de0:	6a 0a                	push   $0xa
  801de2:	e8 99 fe ff ff       	call   801c80 <syscall>
  801de7:	83 c4 18             	add    $0x18,%esp
}
  801dea:	c9                   	leave  
  801deb:	c3                   	ret    

00801dec <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801dec:	55                   	push   %ebp
  801ded:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 0b                	push   $0xb
  801dfb:	e8 80 fe ff ff       	call   801c80 <syscall>
  801e00:	83 c4 18             	add    $0x18,%esp
}
  801e03:	c9                   	leave  
  801e04:	c3                   	ret    

00801e05 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e05:	55                   	push   %ebp
  801e06:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e08:	6a 00                	push   $0x0
  801e0a:	6a 00                	push   $0x0
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	6a 0c                	push   $0xc
  801e14:	e8 67 fe ff ff       	call   801c80 <syscall>
  801e19:	83 c4 18             	add    $0x18,%esp
}
  801e1c:	c9                   	leave  
  801e1d:	c3                   	ret    

00801e1e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e1e:	55                   	push   %ebp
  801e1f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 0d                	push   $0xd
  801e2d:	e8 4e fe ff ff       	call   801c80 <syscall>
  801e32:	83 c4 18             	add    $0x18,%esp
}
  801e35:	c9                   	leave  
  801e36:	c3                   	ret    

00801e37 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e37:	55                   	push   %ebp
  801e38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	ff 75 0c             	pushl  0xc(%ebp)
  801e43:	ff 75 08             	pushl  0x8(%ebp)
  801e46:	6a 11                	push   $0x11
  801e48:	e8 33 fe ff ff       	call   801c80 <syscall>
  801e4d:	83 c4 18             	add    $0x18,%esp
	return;
  801e50:	90                   	nop
}
  801e51:	c9                   	leave  
  801e52:	c3                   	ret    

00801e53 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e53:	55                   	push   %ebp
  801e54:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 00                	push   $0x0
  801e5c:	ff 75 0c             	pushl  0xc(%ebp)
  801e5f:	ff 75 08             	pushl  0x8(%ebp)
  801e62:	6a 12                	push   $0x12
  801e64:	e8 17 fe ff ff       	call   801c80 <syscall>
  801e69:	83 c4 18             	add    $0x18,%esp
	return ;
  801e6c:	90                   	nop
}
  801e6d:	c9                   	leave  
  801e6e:	c3                   	ret    

00801e6f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e6f:	55                   	push   %ebp
  801e70:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 0e                	push   $0xe
  801e7e:	e8 fd fd ff ff       	call   801c80 <syscall>
  801e83:	83 c4 18             	add    $0x18,%esp
}
  801e86:	c9                   	leave  
  801e87:	c3                   	ret    

00801e88 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e88:	55                   	push   %ebp
  801e89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e8b:	6a 00                	push   $0x0
  801e8d:	6a 00                	push   $0x0
  801e8f:	6a 00                	push   $0x0
  801e91:	6a 00                	push   $0x0
  801e93:	ff 75 08             	pushl  0x8(%ebp)
  801e96:	6a 0f                	push   $0xf
  801e98:	e8 e3 fd ff ff       	call   801c80 <syscall>
  801e9d:	83 c4 18             	add    $0x18,%esp
}
  801ea0:	c9                   	leave  
  801ea1:	c3                   	ret    

00801ea2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ea2:	55                   	push   %ebp
  801ea3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 10                	push   $0x10
  801eb1:	e8 ca fd ff ff       	call   801c80 <syscall>
  801eb6:	83 c4 18             	add    $0x18,%esp
}
  801eb9:	90                   	nop
  801eba:	c9                   	leave  
  801ebb:	c3                   	ret    

00801ebc <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ebc:	55                   	push   %ebp
  801ebd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ebf:	6a 00                	push   $0x0
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	6a 00                	push   $0x0
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 14                	push   $0x14
  801ecb:	e8 b0 fd ff ff       	call   801c80 <syscall>
  801ed0:	83 c4 18             	add    $0x18,%esp
}
  801ed3:	90                   	nop
  801ed4:	c9                   	leave  
  801ed5:	c3                   	ret    

00801ed6 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ed6:	55                   	push   %ebp
  801ed7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 15                	push   $0x15
  801ee5:	e8 96 fd ff ff       	call   801c80 <syscall>
  801eea:	83 c4 18             	add    $0x18,%esp
}
  801eed:	90                   	nop
  801eee:	c9                   	leave  
  801eef:	c3                   	ret    

00801ef0 <sys_cputc>:


void
sys_cputc(const char c)
{
  801ef0:	55                   	push   %ebp
  801ef1:	89 e5                	mov    %esp,%ebp
  801ef3:	83 ec 04             	sub    $0x4,%esp
  801ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801efc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	50                   	push   %eax
  801f09:	6a 16                	push   $0x16
  801f0b:	e8 70 fd ff ff       	call   801c80 <syscall>
  801f10:	83 c4 18             	add    $0x18,%esp
}
  801f13:	90                   	nop
  801f14:	c9                   	leave  
  801f15:	c3                   	ret    

00801f16 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f16:	55                   	push   %ebp
  801f17:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f19:	6a 00                	push   $0x0
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 00                	push   $0x0
  801f23:	6a 17                	push   $0x17
  801f25:	e8 56 fd ff ff       	call   801c80 <syscall>
  801f2a:	83 c4 18             	add    $0x18,%esp
}
  801f2d:	90                   	nop
  801f2e:	c9                   	leave  
  801f2f:	c3                   	ret    

00801f30 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f30:	55                   	push   %ebp
  801f31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f33:	8b 45 08             	mov    0x8(%ebp),%eax
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	ff 75 0c             	pushl  0xc(%ebp)
  801f3f:	50                   	push   %eax
  801f40:	6a 18                	push   $0x18
  801f42:	e8 39 fd ff ff       	call   801c80 <syscall>
  801f47:	83 c4 18             	add    $0x18,%esp
}
  801f4a:	c9                   	leave  
  801f4b:	c3                   	ret    

00801f4c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f4c:	55                   	push   %ebp
  801f4d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f52:	8b 45 08             	mov    0x8(%ebp),%eax
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	52                   	push   %edx
  801f5c:	50                   	push   %eax
  801f5d:	6a 1b                	push   $0x1b
  801f5f:	e8 1c fd ff ff       	call   801c80 <syscall>
  801f64:	83 c4 18             	add    $0x18,%esp
}
  801f67:	c9                   	leave  
  801f68:	c3                   	ret    

00801f69 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f69:	55                   	push   %ebp
  801f6a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	52                   	push   %edx
  801f79:	50                   	push   %eax
  801f7a:	6a 19                	push   $0x19
  801f7c:	e8 ff fc ff ff       	call   801c80 <syscall>
  801f81:	83 c4 18             	add    $0x18,%esp
}
  801f84:	90                   	nop
  801f85:	c9                   	leave  
  801f86:	c3                   	ret    

00801f87 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f87:	55                   	push   %ebp
  801f88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	52                   	push   %edx
  801f97:	50                   	push   %eax
  801f98:	6a 1a                	push   $0x1a
  801f9a:	e8 e1 fc ff ff       	call   801c80 <syscall>
  801f9f:	83 c4 18             	add    $0x18,%esp
}
  801fa2:	90                   	nop
  801fa3:	c9                   	leave  
  801fa4:	c3                   	ret    

00801fa5 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801fa5:	55                   	push   %ebp
  801fa6:	89 e5                	mov    %esp,%ebp
  801fa8:	83 ec 04             	sub    $0x4,%esp
  801fab:	8b 45 10             	mov    0x10(%ebp),%eax
  801fae:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801fb1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801fb4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbb:	6a 00                	push   $0x0
  801fbd:	51                   	push   %ecx
  801fbe:	52                   	push   %edx
  801fbf:	ff 75 0c             	pushl  0xc(%ebp)
  801fc2:	50                   	push   %eax
  801fc3:	6a 1c                	push   $0x1c
  801fc5:	e8 b6 fc ff ff       	call   801c80 <syscall>
  801fca:	83 c4 18             	add    $0x18,%esp
}
  801fcd:	c9                   	leave  
  801fce:	c3                   	ret    

00801fcf <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801fcf:	55                   	push   %ebp
  801fd0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801fd2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 00                	push   $0x0
  801fde:	52                   	push   %edx
  801fdf:	50                   	push   %eax
  801fe0:	6a 1d                	push   $0x1d
  801fe2:	e8 99 fc ff ff       	call   801c80 <syscall>
  801fe7:	83 c4 18             	add    $0x18,%esp
}
  801fea:	c9                   	leave  
  801feb:	c3                   	ret    

00801fec <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801fec:	55                   	push   %ebp
  801fed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801fef:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ff2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff8:	6a 00                	push   $0x0
  801ffa:	6a 00                	push   $0x0
  801ffc:	51                   	push   %ecx
  801ffd:	52                   	push   %edx
  801ffe:	50                   	push   %eax
  801fff:	6a 1e                	push   $0x1e
  802001:	e8 7a fc ff ff       	call   801c80 <syscall>
  802006:	83 c4 18             	add    $0x18,%esp
}
  802009:	c9                   	leave  
  80200a:	c3                   	ret    

0080200b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80200b:	55                   	push   %ebp
  80200c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80200e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802011:	8b 45 08             	mov    0x8(%ebp),%eax
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	52                   	push   %edx
  80201b:	50                   	push   %eax
  80201c:	6a 1f                	push   $0x1f
  80201e:	e8 5d fc ff ff       	call   801c80 <syscall>
  802023:	83 c4 18             	add    $0x18,%esp
}
  802026:	c9                   	leave  
  802027:	c3                   	ret    

00802028 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802028:	55                   	push   %ebp
  802029:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80202b:	6a 00                	push   $0x0
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	6a 20                	push   $0x20
  802037:	e8 44 fc ff ff       	call   801c80 <syscall>
  80203c:	83 c4 18             	add    $0x18,%esp
}
  80203f:	c9                   	leave  
  802040:	c3                   	ret    

00802041 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802041:	55                   	push   %ebp
  802042:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802044:	8b 45 08             	mov    0x8(%ebp),%eax
  802047:	6a 00                	push   $0x0
  802049:	6a 00                	push   $0x0
  80204b:	ff 75 10             	pushl  0x10(%ebp)
  80204e:	ff 75 0c             	pushl  0xc(%ebp)
  802051:	50                   	push   %eax
  802052:	6a 21                	push   $0x21
  802054:	e8 27 fc ff ff       	call   801c80 <syscall>
  802059:	83 c4 18             	add    $0x18,%esp
}
  80205c:	c9                   	leave  
  80205d:	c3                   	ret    

0080205e <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80205e:	55                   	push   %ebp
  80205f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802061:	8b 45 08             	mov    0x8(%ebp),%eax
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	6a 00                	push   $0x0
  80206c:	50                   	push   %eax
  80206d:	6a 22                	push   $0x22
  80206f:	e8 0c fc ff ff       	call   801c80 <syscall>
  802074:	83 c4 18             	add    $0x18,%esp
}
  802077:	90                   	nop
  802078:	c9                   	leave  
  802079:	c3                   	ret    

0080207a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80207a:	55                   	push   %ebp
  80207b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80207d:	8b 45 08             	mov    0x8(%ebp),%eax
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	50                   	push   %eax
  802089:	6a 23                	push   $0x23
  80208b:	e8 f0 fb ff ff       	call   801c80 <syscall>
  802090:	83 c4 18             	add    $0x18,%esp
}
  802093:	90                   	nop
  802094:	c9                   	leave  
  802095:	c3                   	ret    

00802096 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802096:	55                   	push   %ebp
  802097:	89 e5                	mov    %esp,%ebp
  802099:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80209c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80209f:	8d 50 04             	lea    0x4(%eax),%edx
  8020a2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	52                   	push   %edx
  8020ac:	50                   	push   %eax
  8020ad:	6a 24                	push   $0x24
  8020af:	e8 cc fb ff ff       	call   801c80 <syscall>
  8020b4:	83 c4 18             	add    $0x18,%esp
	return result;
  8020b7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020c0:	89 01                	mov    %eax,(%ecx)
  8020c2:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8020c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c8:	c9                   	leave  
  8020c9:	c2 04 00             	ret    $0x4

008020cc <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8020cc:	55                   	push   %ebp
  8020cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	ff 75 10             	pushl  0x10(%ebp)
  8020d6:	ff 75 0c             	pushl  0xc(%ebp)
  8020d9:	ff 75 08             	pushl  0x8(%ebp)
  8020dc:	6a 13                	push   $0x13
  8020de:	e8 9d fb ff ff       	call   801c80 <syscall>
  8020e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8020e6:	90                   	nop
}
  8020e7:	c9                   	leave  
  8020e8:	c3                   	ret    

008020e9 <sys_rcr2>:
uint32 sys_rcr2()
{
  8020e9:	55                   	push   %ebp
  8020ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8020ec:	6a 00                	push   $0x0
  8020ee:	6a 00                	push   $0x0
  8020f0:	6a 00                	push   $0x0
  8020f2:	6a 00                	push   $0x0
  8020f4:	6a 00                	push   $0x0
  8020f6:	6a 25                	push   $0x25
  8020f8:	e8 83 fb ff ff       	call   801c80 <syscall>
  8020fd:	83 c4 18             	add    $0x18,%esp
}
  802100:	c9                   	leave  
  802101:	c3                   	ret    

00802102 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802102:	55                   	push   %ebp
  802103:	89 e5                	mov    %esp,%ebp
  802105:	83 ec 04             	sub    $0x4,%esp
  802108:	8b 45 08             	mov    0x8(%ebp),%eax
  80210b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80210e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802112:	6a 00                	push   $0x0
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	50                   	push   %eax
  80211b:	6a 26                	push   $0x26
  80211d:	e8 5e fb ff ff       	call   801c80 <syscall>
  802122:	83 c4 18             	add    $0x18,%esp
	return ;
  802125:	90                   	nop
}
  802126:	c9                   	leave  
  802127:	c3                   	ret    

00802128 <rsttst>:
void rsttst()
{
  802128:	55                   	push   %ebp
  802129:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	6a 00                	push   $0x0
  802133:	6a 00                	push   $0x0
  802135:	6a 28                	push   $0x28
  802137:	e8 44 fb ff ff       	call   801c80 <syscall>
  80213c:	83 c4 18             	add    $0x18,%esp
	return ;
  80213f:	90                   	nop
}
  802140:	c9                   	leave  
  802141:	c3                   	ret    

00802142 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802142:	55                   	push   %ebp
  802143:	89 e5                	mov    %esp,%ebp
  802145:	83 ec 04             	sub    $0x4,%esp
  802148:	8b 45 14             	mov    0x14(%ebp),%eax
  80214b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80214e:	8b 55 18             	mov    0x18(%ebp),%edx
  802151:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802155:	52                   	push   %edx
  802156:	50                   	push   %eax
  802157:	ff 75 10             	pushl  0x10(%ebp)
  80215a:	ff 75 0c             	pushl  0xc(%ebp)
  80215d:	ff 75 08             	pushl  0x8(%ebp)
  802160:	6a 27                	push   $0x27
  802162:	e8 19 fb ff ff       	call   801c80 <syscall>
  802167:	83 c4 18             	add    $0x18,%esp
	return ;
  80216a:	90                   	nop
}
  80216b:	c9                   	leave  
  80216c:	c3                   	ret    

0080216d <chktst>:
void chktst(uint32 n)
{
  80216d:	55                   	push   %ebp
  80216e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802170:	6a 00                	push   $0x0
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 00                	push   $0x0
  802178:	ff 75 08             	pushl  0x8(%ebp)
  80217b:	6a 29                	push   $0x29
  80217d:	e8 fe fa ff ff       	call   801c80 <syscall>
  802182:	83 c4 18             	add    $0x18,%esp
	return ;
  802185:	90                   	nop
}
  802186:	c9                   	leave  
  802187:	c3                   	ret    

00802188 <inctst>:

void inctst()
{
  802188:	55                   	push   %ebp
  802189:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80218b:	6a 00                	push   $0x0
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	6a 00                	push   $0x0
  802193:	6a 00                	push   $0x0
  802195:	6a 2a                	push   $0x2a
  802197:	e8 e4 fa ff ff       	call   801c80 <syscall>
  80219c:	83 c4 18             	add    $0x18,%esp
	return ;
  80219f:	90                   	nop
}
  8021a0:	c9                   	leave  
  8021a1:	c3                   	ret    

008021a2 <gettst>:
uint32 gettst()
{
  8021a2:	55                   	push   %ebp
  8021a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 2b                	push   $0x2b
  8021b1:	e8 ca fa ff ff       	call   801c80 <syscall>
  8021b6:	83 c4 18             	add    $0x18,%esp
}
  8021b9:	c9                   	leave  
  8021ba:	c3                   	ret    

008021bb <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8021bb:	55                   	push   %ebp
  8021bc:	89 e5                	mov    %esp,%ebp
  8021be:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021c1:	6a 00                	push   $0x0
  8021c3:	6a 00                	push   $0x0
  8021c5:	6a 00                	push   $0x0
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 2c                	push   $0x2c
  8021cd:	e8 ae fa ff ff       	call   801c80 <syscall>
  8021d2:	83 c4 18             	add    $0x18,%esp
  8021d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8021d8:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8021dc:	75 07                	jne    8021e5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8021de:	b8 01 00 00 00       	mov    $0x1,%eax
  8021e3:	eb 05                	jmp    8021ea <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8021e5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021ea:	c9                   	leave  
  8021eb:	c3                   	ret    

008021ec <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8021ec:	55                   	push   %ebp
  8021ed:	89 e5                	mov    %esp,%ebp
  8021ef:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021f2:	6a 00                	push   $0x0
  8021f4:	6a 00                	push   $0x0
  8021f6:	6a 00                	push   $0x0
  8021f8:	6a 00                	push   $0x0
  8021fa:	6a 00                	push   $0x0
  8021fc:	6a 2c                	push   $0x2c
  8021fe:	e8 7d fa ff ff       	call   801c80 <syscall>
  802203:	83 c4 18             	add    $0x18,%esp
  802206:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802209:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80220d:	75 07                	jne    802216 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80220f:	b8 01 00 00 00       	mov    $0x1,%eax
  802214:	eb 05                	jmp    80221b <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802216:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80221b:	c9                   	leave  
  80221c:	c3                   	ret    

0080221d <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80221d:	55                   	push   %ebp
  80221e:	89 e5                	mov    %esp,%ebp
  802220:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802223:	6a 00                	push   $0x0
  802225:	6a 00                	push   $0x0
  802227:	6a 00                	push   $0x0
  802229:	6a 00                	push   $0x0
  80222b:	6a 00                	push   $0x0
  80222d:	6a 2c                	push   $0x2c
  80222f:	e8 4c fa ff ff       	call   801c80 <syscall>
  802234:	83 c4 18             	add    $0x18,%esp
  802237:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80223a:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80223e:	75 07                	jne    802247 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802240:	b8 01 00 00 00       	mov    $0x1,%eax
  802245:	eb 05                	jmp    80224c <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802247:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80224c:	c9                   	leave  
  80224d:	c3                   	ret    

0080224e <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80224e:	55                   	push   %ebp
  80224f:	89 e5                	mov    %esp,%ebp
  802251:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	6a 00                	push   $0x0
  80225a:	6a 00                	push   $0x0
  80225c:	6a 00                	push   $0x0
  80225e:	6a 2c                	push   $0x2c
  802260:	e8 1b fa ff ff       	call   801c80 <syscall>
  802265:	83 c4 18             	add    $0x18,%esp
  802268:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80226b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80226f:	75 07                	jne    802278 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802271:	b8 01 00 00 00       	mov    $0x1,%eax
  802276:	eb 05                	jmp    80227d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802278:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80227d:	c9                   	leave  
  80227e:	c3                   	ret    

0080227f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80227f:	55                   	push   %ebp
  802280:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802282:	6a 00                	push   $0x0
  802284:	6a 00                	push   $0x0
  802286:	6a 00                	push   $0x0
  802288:	6a 00                	push   $0x0
  80228a:	ff 75 08             	pushl  0x8(%ebp)
  80228d:	6a 2d                	push   $0x2d
  80228f:	e8 ec f9 ff ff       	call   801c80 <syscall>
  802294:	83 c4 18             	add    $0x18,%esp
	return ;
  802297:	90                   	nop
}
  802298:	c9                   	leave  
  802299:	c3                   	ret    
  80229a:	66 90                	xchg   %ax,%ax

0080229c <__udivdi3>:
  80229c:	55                   	push   %ebp
  80229d:	57                   	push   %edi
  80229e:	56                   	push   %esi
  80229f:	53                   	push   %ebx
  8022a0:	83 ec 1c             	sub    $0x1c,%esp
  8022a3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8022a7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8022ab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022af:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8022b3:	89 ca                	mov    %ecx,%edx
  8022b5:	89 f8                	mov    %edi,%eax
  8022b7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8022bb:	85 f6                	test   %esi,%esi
  8022bd:	75 2d                	jne    8022ec <__udivdi3+0x50>
  8022bf:	39 cf                	cmp    %ecx,%edi
  8022c1:	77 65                	ja     802328 <__udivdi3+0x8c>
  8022c3:	89 fd                	mov    %edi,%ebp
  8022c5:	85 ff                	test   %edi,%edi
  8022c7:	75 0b                	jne    8022d4 <__udivdi3+0x38>
  8022c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8022ce:	31 d2                	xor    %edx,%edx
  8022d0:	f7 f7                	div    %edi
  8022d2:	89 c5                	mov    %eax,%ebp
  8022d4:	31 d2                	xor    %edx,%edx
  8022d6:	89 c8                	mov    %ecx,%eax
  8022d8:	f7 f5                	div    %ebp
  8022da:	89 c1                	mov    %eax,%ecx
  8022dc:	89 d8                	mov    %ebx,%eax
  8022de:	f7 f5                	div    %ebp
  8022e0:	89 cf                	mov    %ecx,%edi
  8022e2:	89 fa                	mov    %edi,%edx
  8022e4:	83 c4 1c             	add    $0x1c,%esp
  8022e7:	5b                   	pop    %ebx
  8022e8:	5e                   	pop    %esi
  8022e9:	5f                   	pop    %edi
  8022ea:	5d                   	pop    %ebp
  8022eb:	c3                   	ret    
  8022ec:	39 ce                	cmp    %ecx,%esi
  8022ee:	77 28                	ja     802318 <__udivdi3+0x7c>
  8022f0:	0f bd fe             	bsr    %esi,%edi
  8022f3:	83 f7 1f             	xor    $0x1f,%edi
  8022f6:	75 40                	jne    802338 <__udivdi3+0x9c>
  8022f8:	39 ce                	cmp    %ecx,%esi
  8022fa:	72 0a                	jb     802306 <__udivdi3+0x6a>
  8022fc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802300:	0f 87 9e 00 00 00    	ja     8023a4 <__udivdi3+0x108>
  802306:	b8 01 00 00 00       	mov    $0x1,%eax
  80230b:	89 fa                	mov    %edi,%edx
  80230d:	83 c4 1c             	add    $0x1c,%esp
  802310:	5b                   	pop    %ebx
  802311:	5e                   	pop    %esi
  802312:	5f                   	pop    %edi
  802313:	5d                   	pop    %ebp
  802314:	c3                   	ret    
  802315:	8d 76 00             	lea    0x0(%esi),%esi
  802318:	31 ff                	xor    %edi,%edi
  80231a:	31 c0                	xor    %eax,%eax
  80231c:	89 fa                	mov    %edi,%edx
  80231e:	83 c4 1c             	add    $0x1c,%esp
  802321:	5b                   	pop    %ebx
  802322:	5e                   	pop    %esi
  802323:	5f                   	pop    %edi
  802324:	5d                   	pop    %ebp
  802325:	c3                   	ret    
  802326:	66 90                	xchg   %ax,%ax
  802328:	89 d8                	mov    %ebx,%eax
  80232a:	f7 f7                	div    %edi
  80232c:	31 ff                	xor    %edi,%edi
  80232e:	89 fa                	mov    %edi,%edx
  802330:	83 c4 1c             	add    $0x1c,%esp
  802333:	5b                   	pop    %ebx
  802334:	5e                   	pop    %esi
  802335:	5f                   	pop    %edi
  802336:	5d                   	pop    %ebp
  802337:	c3                   	ret    
  802338:	bd 20 00 00 00       	mov    $0x20,%ebp
  80233d:	89 eb                	mov    %ebp,%ebx
  80233f:	29 fb                	sub    %edi,%ebx
  802341:	89 f9                	mov    %edi,%ecx
  802343:	d3 e6                	shl    %cl,%esi
  802345:	89 c5                	mov    %eax,%ebp
  802347:	88 d9                	mov    %bl,%cl
  802349:	d3 ed                	shr    %cl,%ebp
  80234b:	89 e9                	mov    %ebp,%ecx
  80234d:	09 f1                	or     %esi,%ecx
  80234f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802353:	89 f9                	mov    %edi,%ecx
  802355:	d3 e0                	shl    %cl,%eax
  802357:	89 c5                	mov    %eax,%ebp
  802359:	89 d6                	mov    %edx,%esi
  80235b:	88 d9                	mov    %bl,%cl
  80235d:	d3 ee                	shr    %cl,%esi
  80235f:	89 f9                	mov    %edi,%ecx
  802361:	d3 e2                	shl    %cl,%edx
  802363:	8b 44 24 08          	mov    0x8(%esp),%eax
  802367:	88 d9                	mov    %bl,%cl
  802369:	d3 e8                	shr    %cl,%eax
  80236b:	09 c2                	or     %eax,%edx
  80236d:	89 d0                	mov    %edx,%eax
  80236f:	89 f2                	mov    %esi,%edx
  802371:	f7 74 24 0c          	divl   0xc(%esp)
  802375:	89 d6                	mov    %edx,%esi
  802377:	89 c3                	mov    %eax,%ebx
  802379:	f7 e5                	mul    %ebp
  80237b:	39 d6                	cmp    %edx,%esi
  80237d:	72 19                	jb     802398 <__udivdi3+0xfc>
  80237f:	74 0b                	je     80238c <__udivdi3+0xf0>
  802381:	89 d8                	mov    %ebx,%eax
  802383:	31 ff                	xor    %edi,%edi
  802385:	e9 58 ff ff ff       	jmp    8022e2 <__udivdi3+0x46>
  80238a:	66 90                	xchg   %ax,%ax
  80238c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802390:	89 f9                	mov    %edi,%ecx
  802392:	d3 e2                	shl    %cl,%edx
  802394:	39 c2                	cmp    %eax,%edx
  802396:	73 e9                	jae    802381 <__udivdi3+0xe5>
  802398:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80239b:	31 ff                	xor    %edi,%edi
  80239d:	e9 40 ff ff ff       	jmp    8022e2 <__udivdi3+0x46>
  8023a2:	66 90                	xchg   %ax,%ax
  8023a4:	31 c0                	xor    %eax,%eax
  8023a6:	e9 37 ff ff ff       	jmp    8022e2 <__udivdi3+0x46>
  8023ab:	90                   	nop

008023ac <__umoddi3>:
  8023ac:	55                   	push   %ebp
  8023ad:	57                   	push   %edi
  8023ae:	56                   	push   %esi
  8023af:	53                   	push   %ebx
  8023b0:	83 ec 1c             	sub    $0x1c,%esp
  8023b3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8023b7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8023bb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023bf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8023c3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023c7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023cb:	89 f3                	mov    %esi,%ebx
  8023cd:	89 fa                	mov    %edi,%edx
  8023cf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023d3:	89 34 24             	mov    %esi,(%esp)
  8023d6:	85 c0                	test   %eax,%eax
  8023d8:	75 1a                	jne    8023f4 <__umoddi3+0x48>
  8023da:	39 f7                	cmp    %esi,%edi
  8023dc:	0f 86 a2 00 00 00    	jbe    802484 <__umoddi3+0xd8>
  8023e2:	89 c8                	mov    %ecx,%eax
  8023e4:	89 f2                	mov    %esi,%edx
  8023e6:	f7 f7                	div    %edi
  8023e8:	89 d0                	mov    %edx,%eax
  8023ea:	31 d2                	xor    %edx,%edx
  8023ec:	83 c4 1c             	add    $0x1c,%esp
  8023ef:	5b                   	pop    %ebx
  8023f0:	5e                   	pop    %esi
  8023f1:	5f                   	pop    %edi
  8023f2:	5d                   	pop    %ebp
  8023f3:	c3                   	ret    
  8023f4:	39 f0                	cmp    %esi,%eax
  8023f6:	0f 87 ac 00 00 00    	ja     8024a8 <__umoddi3+0xfc>
  8023fc:	0f bd e8             	bsr    %eax,%ebp
  8023ff:	83 f5 1f             	xor    $0x1f,%ebp
  802402:	0f 84 ac 00 00 00    	je     8024b4 <__umoddi3+0x108>
  802408:	bf 20 00 00 00       	mov    $0x20,%edi
  80240d:	29 ef                	sub    %ebp,%edi
  80240f:	89 fe                	mov    %edi,%esi
  802411:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802415:	89 e9                	mov    %ebp,%ecx
  802417:	d3 e0                	shl    %cl,%eax
  802419:	89 d7                	mov    %edx,%edi
  80241b:	89 f1                	mov    %esi,%ecx
  80241d:	d3 ef                	shr    %cl,%edi
  80241f:	09 c7                	or     %eax,%edi
  802421:	89 e9                	mov    %ebp,%ecx
  802423:	d3 e2                	shl    %cl,%edx
  802425:	89 14 24             	mov    %edx,(%esp)
  802428:	89 d8                	mov    %ebx,%eax
  80242a:	d3 e0                	shl    %cl,%eax
  80242c:	89 c2                	mov    %eax,%edx
  80242e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802432:	d3 e0                	shl    %cl,%eax
  802434:	89 44 24 04          	mov    %eax,0x4(%esp)
  802438:	8b 44 24 08          	mov    0x8(%esp),%eax
  80243c:	89 f1                	mov    %esi,%ecx
  80243e:	d3 e8                	shr    %cl,%eax
  802440:	09 d0                	or     %edx,%eax
  802442:	d3 eb                	shr    %cl,%ebx
  802444:	89 da                	mov    %ebx,%edx
  802446:	f7 f7                	div    %edi
  802448:	89 d3                	mov    %edx,%ebx
  80244a:	f7 24 24             	mull   (%esp)
  80244d:	89 c6                	mov    %eax,%esi
  80244f:	89 d1                	mov    %edx,%ecx
  802451:	39 d3                	cmp    %edx,%ebx
  802453:	0f 82 87 00 00 00    	jb     8024e0 <__umoddi3+0x134>
  802459:	0f 84 91 00 00 00    	je     8024f0 <__umoddi3+0x144>
  80245f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802463:	29 f2                	sub    %esi,%edx
  802465:	19 cb                	sbb    %ecx,%ebx
  802467:	89 d8                	mov    %ebx,%eax
  802469:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80246d:	d3 e0                	shl    %cl,%eax
  80246f:	89 e9                	mov    %ebp,%ecx
  802471:	d3 ea                	shr    %cl,%edx
  802473:	09 d0                	or     %edx,%eax
  802475:	89 e9                	mov    %ebp,%ecx
  802477:	d3 eb                	shr    %cl,%ebx
  802479:	89 da                	mov    %ebx,%edx
  80247b:	83 c4 1c             	add    $0x1c,%esp
  80247e:	5b                   	pop    %ebx
  80247f:	5e                   	pop    %esi
  802480:	5f                   	pop    %edi
  802481:	5d                   	pop    %ebp
  802482:	c3                   	ret    
  802483:	90                   	nop
  802484:	89 fd                	mov    %edi,%ebp
  802486:	85 ff                	test   %edi,%edi
  802488:	75 0b                	jne    802495 <__umoddi3+0xe9>
  80248a:	b8 01 00 00 00       	mov    $0x1,%eax
  80248f:	31 d2                	xor    %edx,%edx
  802491:	f7 f7                	div    %edi
  802493:	89 c5                	mov    %eax,%ebp
  802495:	89 f0                	mov    %esi,%eax
  802497:	31 d2                	xor    %edx,%edx
  802499:	f7 f5                	div    %ebp
  80249b:	89 c8                	mov    %ecx,%eax
  80249d:	f7 f5                	div    %ebp
  80249f:	89 d0                	mov    %edx,%eax
  8024a1:	e9 44 ff ff ff       	jmp    8023ea <__umoddi3+0x3e>
  8024a6:	66 90                	xchg   %ax,%ax
  8024a8:	89 c8                	mov    %ecx,%eax
  8024aa:	89 f2                	mov    %esi,%edx
  8024ac:	83 c4 1c             	add    $0x1c,%esp
  8024af:	5b                   	pop    %ebx
  8024b0:	5e                   	pop    %esi
  8024b1:	5f                   	pop    %edi
  8024b2:	5d                   	pop    %ebp
  8024b3:	c3                   	ret    
  8024b4:	3b 04 24             	cmp    (%esp),%eax
  8024b7:	72 06                	jb     8024bf <__umoddi3+0x113>
  8024b9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024bd:	77 0f                	ja     8024ce <__umoddi3+0x122>
  8024bf:	89 f2                	mov    %esi,%edx
  8024c1:	29 f9                	sub    %edi,%ecx
  8024c3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024c7:	89 14 24             	mov    %edx,(%esp)
  8024ca:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024ce:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024d2:	8b 14 24             	mov    (%esp),%edx
  8024d5:	83 c4 1c             	add    $0x1c,%esp
  8024d8:	5b                   	pop    %ebx
  8024d9:	5e                   	pop    %esi
  8024da:	5f                   	pop    %edi
  8024db:	5d                   	pop    %ebp
  8024dc:	c3                   	ret    
  8024dd:	8d 76 00             	lea    0x0(%esi),%esi
  8024e0:	2b 04 24             	sub    (%esp),%eax
  8024e3:	19 fa                	sbb    %edi,%edx
  8024e5:	89 d1                	mov    %edx,%ecx
  8024e7:	89 c6                	mov    %eax,%esi
  8024e9:	e9 71 ff ff ff       	jmp    80245f <__umoddi3+0xb3>
  8024ee:	66 90                	xchg   %ax,%ax
  8024f0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024f4:	72 ea                	jb     8024e0 <__umoddi3+0x134>
  8024f6:	89 d9                	mov    %ebx,%ecx
  8024f8:	e9 62 ff ff ff       	jmp    80245f <__umoddi3+0xb3>
