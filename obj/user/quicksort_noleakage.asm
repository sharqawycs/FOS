
obj/user/quicksort_noleakage:     file format elf32-i386


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
  800031:	e8 fc 05 00 00       	call   800632 <libmain>
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
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	char Line[255] ;
	char Chose ;
	do
	{
		//2012: lock the interrupt
		sys_disable_interrupt();
  800041:	e8 fe 1d 00 00       	call   801e44 <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 a0 24 80 00       	push   $0x8024a0
  80004e:	e8 95 09 00 00       	call   8009e8 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 a2 24 80 00       	push   $0x8024a2
  80005e:	e8 85 09 00 00       	call   8009e8 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   QUICK SORT    !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 bb 24 80 00       	push   $0x8024bb
  80006e:	e8 75 09 00 00       	call   8009e8 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 a2 24 80 00       	push   $0x8024a2
  80007e:	e8 65 09 00 00       	call   8009e8 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 a0 24 80 00       	push   $0x8024a0
  80008e:	e8 55 09 00 00       	call   8009e8 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 d4 24 80 00       	push   $0x8024d4
  8000a5:	e8 c0 0f 00 00       	call   80106a <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 10 15 00 00       	call   8015d0 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 dd 18 00 00       	call   8019b2 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 f4 24 80 00       	push   $0x8024f4
  8000e3:	e8 00 09 00 00       	call   8009e8 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 16 25 80 00       	push   $0x802516
  8000f3:	e8 f0 08 00 00       	call   8009e8 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 24 25 80 00       	push   $0x802524
  800103:	e8 e0 08 00 00       	call   8009e8 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 33 25 80 00       	push   $0x802533
  800113:	e8 d0 08 00 00       	call   8009e8 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 43 25 80 00       	push   $0x802543
  800123:	e8 c0 08 00 00       	call   8009e8 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  80012b:	e8 aa 04 00 00       	call   8005da <getchar>
  800130:	88 45 ef             	mov    %al,-0x11(%ebp)
		cputchar(Chose);
  800133:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 52 04 00 00       	call   800592 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 45 04 00 00       	call   800592 <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp

		//2012: lock the interrupt
		sys_enable_interrupt();
  800150:	e8 09 1d 00 00       	call   801e5e <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800155:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  800159:	83 f8 62             	cmp    $0x62,%eax
  80015c:	74 1d                	je     80017b <_main+0x143>
  80015e:	83 f8 63             	cmp    $0x63,%eax
  800161:	74 2b                	je     80018e <_main+0x156>
  800163:	83 f8 61             	cmp    $0x61,%eax
  800166:	75 39                	jne    8001a1 <_main+0x169>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800168:	83 ec 08             	sub    $0x8,%esp
  80016b:	ff 75 f4             	pushl  -0xc(%ebp)
  80016e:	ff 75 f0             	pushl  -0x10(%ebp)
  800171:	e8 e4 02 00 00       	call   80045a <InitializeAscending>
  800176:	83 c4 10             	add    $0x10,%esp
			break ;
  800179:	eb 37                	jmp    8001b2 <_main+0x17a>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80017b:	83 ec 08             	sub    $0x8,%esp
  80017e:	ff 75 f4             	pushl  -0xc(%ebp)
  800181:	ff 75 f0             	pushl  -0x10(%ebp)
  800184:	e8 02 03 00 00       	call   80048b <InitializeDescending>
  800189:	83 c4 10             	add    $0x10,%esp
			break ;
  80018c:	eb 24                	jmp    8001b2 <_main+0x17a>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80018e:	83 ec 08             	sub    $0x8,%esp
  800191:	ff 75 f4             	pushl  -0xc(%ebp)
  800194:	ff 75 f0             	pushl  -0x10(%ebp)
  800197:	e8 24 03 00 00       	call   8004c0 <InitializeSemiRandom>
  80019c:	83 c4 10             	add    $0x10,%esp
			break ;
  80019f:	eb 11                	jmp    8001b2 <_main+0x17a>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001a1:	83 ec 08             	sub    $0x8,%esp
  8001a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8001a7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001aa:	e8 11 03 00 00       	call   8004c0 <InitializeSemiRandom>
  8001af:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001b2:	83 ec 08             	sub    $0x8,%esp
  8001b5:	ff 75 f4             	pushl  -0xc(%ebp)
  8001b8:	ff 75 f0             	pushl  -0x10(%ebp)
  8001bb:	e8 df 00 00 00       	call   80029f <QuickSort>
  8001c0:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001c3:	e8 7c 1c 00 00       	call   801e44 <sys_disable_interrupt>
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001c8:	83 ec 0c             	sub    $0xc,%esp
  8001cb:	68 4c 25 80 00       	push   $0x80254c
  8001d0:	e8 13 08 00 00       	call   8009e8 <cprintf>
  8001d5:	83 c4 10             	add    $0x10,%esp
		//		PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001d8:	e8 81 1c 00 00       	call   801e5e <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001dd:	83 ec 08             	sub    $0x8,%esp
  8001e0:	ff 75 f4             	pushl  -0xc(%ebp)
  8001e3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001e6:	e8 c5 01 00 00       	call   8003b0 <CheckSorted>
  8001eb:	83 c4 10             	add    $0x10,%esp
  8001ee:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001f1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8001f5:	75 14                	jne    80020b <_main+0x1d3>
  8001f7:	83 ec 04             	sub    $0x4,%esp
  8001fa:	68 80 25 80 00       	push   $0x802580
  8001ff:	6a 46                	push   $0x46
  800201:	68 a2 25 80 00       	push   $0x8025a2
  800206:	e8 29 05 00 00       	call   800734 <_panic>
		else
		{
			sys_disable_interrupt();
  80020b:	e8 34 1c 00 00       	call   801e44 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800210:	83 ec 0c             	sub    $0xc,%esp
  800213:	68 c0 25 80 00       	push   $0x8025c0
  800218:	e8 cb 07 00 00       	call   8009e8 <cprintf>
  80021d:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800220:	83 ec 0c             	sub    $0xc,%esp
  800223:	68 f4 25 80 00       	push   $0x8025f4
  800228:	e8 bb 07 00 00       	call   8009e8 <cprintf>
  80022d:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800230:	83 ec 0c             	sub    $0xc,%esp
  800233:	68 28 26 80 00       	push   $0x802628
  800238:	e8 ab 07 00 00       	call   8009e8 <cprintf>
  80023d:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800240:	e8 19 1c 00 00       	call   801e5e <sys_enable_interrupt>

		}

		free(Elements) ;
  800245:	83 ec 0c             	sub    $0xc,%esp
  800248:	ff 75 f0             	pushl  -0x10(%ebp)
  80024b:	e8 83 18 00 00       	call   801ad3 <free>
  800250:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800253:	e8 ec 1b 00 00       	call   801e44 <sys_disable_interrupt>

		cprintf("Do you want to repeat (y/n): ") ;
  800258:	83 ec 0c             	sub    $0xc,%esp
  80025b:	68 5a 26 80 00       	push   $0x80265a
  800260:	e8 83 07 00 00       	call   8009e8 <cprintf>
  800265:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  800268:	e8 6d 03 00 00       	call   8005da <getchar>
  80026d:	88 45 ef             	mov    %al,-0x11(%ebp)
		cputchar(Chose);
  800270:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  800274:	83 ec 0c             	sub    $0xc,%esp
  800277:	50                   	push   %eax
  800278:	e8 15 03 00 00       	call   800592 <cputchar>
  80027d:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	6a 0a                	push   $0xa
  800285:	e8 08 03 00 00       	call   800592 <cputchar>
  80028a:	83 c4 10             	add    $0x10,%esp

		sys_enable_interrupt();
  80028d:	e8 cc 1b 00 00       	call   801e5e <sys_enable_interrupt>

	} while (Chose == 'y');
  800292:	80 7d ef 79          	cmpb   $0x79,-0x11(%ebp)
  800296:	0f 84 a5 fd ff ff    	je     800041 <_main+0x9>

}
  80029c:	90                   	nop
  80029d:	c9                   	leave  
  80029e:	c3                   	ret    

0080029f <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  80029f:	55                   	push   %ebp
  8002a0:	89 e5                	mov    %esp,%ebp
  8002a2:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002a8:	48                   	dec    %eax
  8002a9:	50                   	push   %eax
  8002aa:	6a 00                	push   $0x0
  8002ac:	ff 75 0c             	pushl  0xc(%ebp)
  8002af:	ff 75 08             	pushl  0x8(%ebp)
  8002b2:	e8 06 00 00 00       	call   8002bd <QSort>
  8002b7:	83 c4 10             	add    $0x10,%esp
}
  8002ba:	90                   	nop
  8002bb:	c9                   	leave  
  8002bc:	c3                   	ret    

008002bd <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002bd:	55                   	push   %ebp
  8002be:	89 e5                	mov    %esp,%ebp
  8002c0:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8002c6:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002c9:	0f 8d de 00 00 00    	jge    8003ad <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d2:	40                   	inc    %eax
  8002d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8002d9:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002dc:	e9 80 00 00 00       	jmp    800361 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002e1:	ff 45 f4             	incl   -0xc(%ebp)
  8002e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002e7:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002ea:	7f 2b                	jg     800317 <QSort+0x5a>
  8002ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 d0                	add    %edx,%eax
  8002fb:	8b 10                	mov    (%eax),%edx
  8002fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800300:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800307:	8b 45 08             	mov    0x8(%ebp),%eax
  80030a:	01 c8                	add    %ecx,%eax
  80030c:	8b 00                	mov    (%eax),%eax
  80030e:	39 c2                	cmp    %eax,%edx
  800310:	7d cf                	jge    8002e1 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800312:	eb 03                	jmp    800317 <QSort+0x5a>
  800314:	ff 4d f0             	decl   -0x10(%ebp)
  800317:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80031a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80031d:	7e 26                	jle    800345 <QSort+0x88>
  80031f:	8b 45 10             	mov    0x10(%ebp),%eax
  800322:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800329:	8b 45 08             	mov    0x8(%ebp),%eax
  80032c:	01 d0                	add    %edx,%eax
  80032e:	8b 10                	mov    (%eax),%edx
  800330:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800333:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80033a:	8b 45 08             	mov    0x8(%ebp),%eax
  80033d:	01 c8                	add    %ecx,%eax
  80033f:	8b 00                	mov    (%eax),%eax
  800341:	39 c2                	cmp    %eax,%edx
  800343:	7e cf                	jle    800314 <QSort+0x57>

		if (i <= j)
  800345:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800348:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80034b:	7f 14                	jg     800361 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80034d:	83 ec 04             	sub    $0x4,%esp
  800350:	ff 75 f0             	pushl  -0x10(%ebp)
  800353:	ff 75 f4             	pushl  -0xc(%ebp)
  800356:	ff 75 08             	pushl  0x8(%ebp)
  800359:	e8 a9 00 00 00       	call   800407 <Swap>
  80035e:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800361:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800364:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800367:	0f 8e 77 ff ff ff    	jle    8002e4 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80036d:	83 ec 04             	sub    $0x4,%esp
  800370:	ff 75 f0             	pushl  -0x10(%ebp)
  800373:	ff 75 10             	pushl  0x10(%ebp)
  800376:	ff 75 08             	pushl  0x8(%ebp)
  800379:	e8 89 00 00 00       	call   800407 <Swap>
  80037e:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800381:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800384:	48                   	dec    %eax
  800385:	50                   	push   %eax
  800386:	ff 75 10             	pushl  0x10(%ebp)
  800389:	ff 75 0c             	pushl  0xc(%ebp)
  80038c:	ff 75 08             	pushl  0x8(%ebp)
  80038f:	e8 29 ff ff ff       	call   8002bd <QSort>
  800394:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800397:	ff 75 14             	pushl  0x14(%ebp)
  80039a:	ff 75 f4             	pushl  -0xc(%ebp)
  80039d:	ff 75 0c             	pushl  0xc(%ebp)
  8003a0:	ff 75 08             	pushl  0x8(%ebp)
  8003a3:	e8 15 ff ff ff       	call   8002bd <QSort>
  8003a8:	83 c4 10             	add    $0x10,%esp
  8003ab:	eb 01                	jmp    8003ae <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003ad:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003ae:	c9                   	leave  
  8003af:	c3                   	ret    

008003b0 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003b0:	55                   	push   %ebp
  8003b1:	89 e5                	mov    %esp,%ebp
  8003b3:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003b6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003bd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003c4:	eb 33                	jmp    8003f9 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003c9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d3:	01 d0                	add    %edx,%eax
  8003d5:	8b 10                	mov    (%eax),%edx
  8003d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003da:	40                   	inc    %eax
  8003db:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e5:	01 c8                	add    %ecx,%eax
  8003e7:	8b 00                	mov    (%eax),%eax
  8003e9:	39 c2                	cmp    %eax,%edx
  8003eb:	7e 09                	jle    8003f6 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003f4:	eb 0c                	jmp    800402 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003f6:	ff 45 f8             	incl   -0x8(%ebp)
  8003f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003fc:	48                   	dec    %eax
  8003fd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800400:	7f c4                	jg     8003c6 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800402:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800405:	c9                   	leave  
  800406:	c3                   	ret    

00800407 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800407:	55                   	push   %ebp
  800408:	89 e5                	mov    %esp,%ebp
  80040a:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80040d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800410:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800417:	8b 45 08             	mov    0x8(%ebp),%eax
  80041a:	01 d0                	add    %edx,%eax
  80041c:	8b 00                	mov    (%eax),%eax
  80041e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800421:	8b 45 0c             	mov    0xc(%ebp),%eax
  800424:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80042b:	8b 45 08             	mov    0x8(%ebp),%eax
  80042e:	01 c2                	add    %eax,%edx
  800430:	8b 45 10             	mov    0x10(%ebp),%eax
  800433:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	01 c8                	add    %ecx,%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800443:	8b 45 10             	mov    0x10(%ebp),%eax
  800446:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80044d:	8b 45 08             	mov    0x8(%ebp),%eax
  800450:	01 c2                	add    %eax,%edx
  800452:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800455:	89 02                	mov    %eax,(%edx)
}
  800457:	90                   	nop
  800458:	c9                   	leave  
  800459:	c3                   	ret    

0080045a <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80045a:	55                   	push   %ebp
  80045b:	89 e5                	mov    %esp,%ebp
  80045d:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800460:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800467:	eb 17                	jmp    800480 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800469:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80046c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	01 c2                	add    %eax,%edx
  800478:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80047b:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80047d:	ff 45 fc             	incl   -0x4(%ebp)
  800480:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800483:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800486:	7c e1                	jl     800469 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800488:	90                   	nop
  800489:	c9                   	leave  
  80048a:	c3                   	ret    

0080048b <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80048b:	55                   	push   %ebp
  80048c:	89 e5                	mov    %esp,%ebp
  80048e:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800491:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800498:	eb 1b                	jmp    8004b5 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  80049a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a7:	01 c2                	add    %eax,%edx
  8004a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ac:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004af:	48                   	dec    %eax
  8004b0:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b2:	ff 45 fc             	incl   -0x4(%ebp)
  8004b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004b8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004bb:	7c dd                	jl     80049a <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004bd:	90                   	nop
  8004be:	c9                   	leave  
  8004bf:	c3                   	ret    

008004c0 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004c0:	55                   	push   %ebp
  8004c1:	89 e5                	mov    %esp,%ebp
  8004c3:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004c6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004c9:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004ce:	f7 e9                	imul   %ecx
  8004d0:	c1 f9 1f             	sar    $0x1f,%ecx
  8004d3:	89 d0                	mov    %edx,%eax
  8004d5:	29 c8                	sub    %ecx,%eax
  8004d7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004e1:	eb 1e                	jmp    800501 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f0:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004f6:	99                   	cltd   
  8004f7:	f7 7d f8             	idivl  -0x8(%ebp)
  8004fa:	89 d0                	mov    %edx,%eax
  8004fc:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004fe:	ff 45 fc             	incl   -0x4(%ebp)
  800501:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800504:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800507:	7c da                	jl     8004e3 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  800509:	90                   	nop
  80050a:	c9                   	leave  
  80050b:	c3                   	ret    

0080050c <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80050c:	55                   	push   %ebp
  80050d:	89 e5                	mov    %esp,%ebp
  80050f:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800512:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800519:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800520:	eb 42                	jmp    800564 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800522:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800525:	99                   	cltd   
  800526:	f7 7d f0             	idivl  -0x10(%ebp)
  800529:	89 d0                	mov    %edx,%eax
  80052b:	85 c0                	test   %eax,%eax
  80052d:	75 10                	jne    80053f <PrintElements+0x33>
			cprintf("\n");
  80052f:	83 ec 0c             	sub    $0xc,%esp
  800532:	68 a0 24 80 00       	push   $0x8024a0
  800537:	e8 ac 04 00 00       	call   8009e8 <cprintf>
  80053c:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  80053f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800542:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800549:	8b 45 08             	mov    0x8(%ebp),%eax
  80054c:	01 d0                	add    %edx,%eax
  80054e:	8b 00                	mov    (%eax),%eax
  800550:	83 ec 08             	sub    $0x8,%esp
  800553:	50                   	push   %eax
  800554:	68 78 26 80 00       	push   $0x802678
  800559:	e8 8a 04 00 00       	call   8009e8 <cprintf>
  80055e:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800561:	ff 45 f4             	incl   -0xc(%ebp)
  800564:	8b 45 0c             	mov    0xc(%ebp),%eax
  800567:	48                   	dec    %eax
  800568:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80056b:	7f b5                	jg     800522 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80056d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800570:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800577:	8b 45 08             	mov    0x8(%ebp),%eax
  80057a:	01 d0                	add    %edx,%eax
  80057c:	8b 00                	mov    (%eax),%eax
  80057e:	83 ec 08             	sub    $0x8,%esp
  800581:	50                   	push   %eax
  800582:	68 7d 26 80 00       	push   $0x80267d
  800587:	e8 5c 04 00 00       	call   8009e8 <cprintf>
  80058c:	83 c4 10             	add    $0x10,%esp

}
  80058f:	90                   	nop
  800590:	c9                   	leave  
  800591:	c3                   	ret    

00800592 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800592:	55                   	push   %ebp
  800593:	89 e5                	mov    %esp,%ebp
  800595:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800598:	8b 45 08             	mov    0x8(%ebp),%eax
  80059b:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80059e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005a2:	83 ec 0c             	sub    $0xc,%esp
  8005a5:	50                   	push   %eax
  8005a6:	e8 cd 18 00 00       	call   801e78 <sys_cputc>
  8005ab:	83 c4 10             	add    $0x10,%esp
}
  8005ae:	90                   	nop
  8005af:	c9                   	leave  
  8005b0:	c3                   	ret    

008005b1 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8005b1:	55                   	push   %ebp
  8005b2:	89 e5                	mov    %esp,%ebp
  8005b4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005b7:	e8 88 18 00 00       	call   801e44 <sys_disable_interrupt>
	char c = ch;
  8005bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bf:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005c2:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005c6:	83 ec 0c             	sub    $0xc,%esp
  8005c9:	50                   	push   %eax
  8005ca:	e8 a9 18 00 00       	call   801e78 <sys_cputc>
  8005cf:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005d2:	e8 87 18 00 00       	call   801e5e <sys_enable_interrupt>
}
  8005d7:	90                   	nop
  8005d8:	c9                   	leave  
  8005d9:	c3                   	ret    

008005da <getchar>:

int
getchar(void)
{
  8005da:	55                   	push   %ebp
  8005db:	89 e5                	mov    %esp,%ebp
  8005dd:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005e7:	eb 08                	jmp    8005f1 <getchar+0x17>
	{
		c = sys_cgetc();
  8005e9:	e8 6e 16 00 00       	call   801c5c <sys_cgetc>
  8005ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005f5:	74 f2                	je     8005e9 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005fa:	c9                   	leave  
  8005fb:	c3                   	ret    

008005fc <atomic_getchar>:

int
atomic_getchar(void)
{
  8005fc:	55                   	push   %ebp
  8005fd:	89 e5                	mov    %esp,%ebp
  8005ff:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800602:	e8 3d 18 00 00       	call   801e44 <sys_disable_interrupt>
	int c=0;
  800607:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80060e:	eb 08                	jmp    800618 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800610:	e8 47 16 00 00       	call   801c5c <sys_cgetc>
  800615:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800618:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80061c:	74 f2                	je     800610 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  80061e:	e8 3b 18 00 00       	call   801e5e <sys_enable_interrupt>
	return c;
  800623:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800626:	c9                   	leave  
  800627:	c3                   	ret    

00800628 <iscons>:

int iscons(int fdnum)
{
  800628:	55                   	push   %ebp
  800629:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80062b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800630:	5d                   	pop    %ebp
  800631:	c3                   	ret    

00800632 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800632:	55                   	push   %ebp
  800633:	89 e5                	mov    %esp,%ebp
  800635:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800638:	e8 6c 16 00 00       	call   801ca9 <sys_getenvindex>
  80063d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800640:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800643:	89 d0                	mov    %edx,%eax
  800645:	01 c0                	add    %eax,%eax
  800647:	01 d0                	add    %edx,%eax
  800649:	c1 e0 02             	shl    $0x2,%eax
  80064c:	01 d0                	add    %edx,%eax
  80064e:	c1 e0 06             	shl    $0x6,%eax
  800651:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800656:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80065b:	a1 24 30 80 00       	mov    0x803024,%eax
  800660:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800666:	84 c0                	test   %al,%al
  800668:	74 0f                	je     800679 <libmain+0x47>
		binaryname = myEnv->prog_name;
  80066a:	a1 24 30 80 00       	mov    0x803024,%eax
  80066f:	05 f4 02 00 00       	add    $0x2f4,%eax
  800674:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800679:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80067d:	7e 0a                	jle    800689 <libmain+0x57>
		binaryname = argv[0];
  80067f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800682:	8b 00                	mov    (%eax),%eax
  800684:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800689:	83 ec 08             	sub    $0x8,%esp
  80068c:	ff 75 0c             	pushl  0xc(%ebp)
  80068f:	ff 75 08             	pushl  0x8(%ebp)
  800692:	e8 a1 f9 ff ff       	call   800038 <_main>
  800697:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80069a:	e8 a5 17 00 00       	call   801e44 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80069f:	83 ec 0c             	sub    $0xc,%esp
  8006a2:	68 9c 26 80 00       	push   $0x80269c
  8006a7:	e8 3c 03 00 00       	call   8009e8 <cprintf>
  8006ac:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006af:	a1 24 30 80 00       	mov    0x803024,%eax
  8006b4:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8006ba:	a1 24 30 80 00       	mov    0x803024,%eax
  8006bf:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8006c5:	83 ec 04             	sub    $0x4,%esp
  8006c8:	52                   	push   %edx
  8006c9:	50                   	push   %eax
  8006ca:	68 c4 26 80 00       	push   $0x8026c4
  8006cf:	e8 14 03 00 00       	call   8009e8 <cprintf>
  8006d4:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006d7:	a1 24 30 80 00       	mov    0x803024,%eax
  8006dc:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8006e2:	83 ec 08             	sub    $0x8,%esp
  8006e5:	50                   	push   %eax
  8006e6:	68 e9 26 80 00       	push   $0x8026e9
  8006eb:	e8 f8 02 00 00       	call   8009e8 <cprintf>
  8006f0:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006f3:	83 ec 0c             	sub    $0xc,%esp
  8006f6:	68 9c 26 80 00       	push   $0x80269c
  8006fb:	e8 e8 02 00 00       	call   8009e8 <cprintf>
  800700:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800703:	e8 56 17 00 00       	call   801e5e <sys_enable_interrupt>

	// exit gracefully
	exit();
  800708:	e8 19 00 00 00       	call   800726 <exit>
}
  80070d:	90                   	nop
  80070e:	c9                   	leave  
  80070f:	c3                   	ret    

00800710 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800710:	55                   	push   %ebp
  800711:	89 e5                	mov    %esp,%ebp
  800713:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800716:	83 ec 0c             	sub    $0xc,%esp
  800719:	6a 00                	push   $0x0
  80071b:	e8 55 15 00 00       	call   801c75 <sys_env_destroy>
  800720:	83 c4 10             	add    $0x10,%esp
}
  800723:	90                   	nop
  800724:	c9                   	leave  
  800725:	c3                   	ret    

00800726 <exit>:

void
exit(void)
{
  800726:	55                   	push   %ebp
  800727:	89 e5                	mov    %esp,%ebp
  800729:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80072c:	e8 aa 15 00 00       	call   801cdb <sys_env_exit>
}
  800731:	90                   	nop
  800732:	c9                   	leave  
  800733:	c3                   	ret    

00800734 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800734:	55                   	push   %ebp
  800735:	89 e5                	mov    %esp,%ebp
  800737:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80073a:	8d 45 10             	lea    0x10(%ebp),%eax
  80073d:	83 c0 04             	add    $0x4,%eax
  800740:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800743:	a1 34 30 80 00       	mov    0x803034,%eax
  800748:	85 c0                	test   %eax,%eax
  80074a:	74 16                	je     800762 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80074c:	a1 34 30 80 00       	mov    0x803034,%eax
  800751:	83 ec 08             	sub    $0x8,%esp
  800754:	50                   	push   %eax
  800755:	68 00 27 80 00       	push   $0x802700
  80075a:	e8 89 02 00 00       	call   8009e8 <cprintf>
  80075f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800762:	a1 00 30 80 00       	mov    0x803000,%eax
  800767:	ff 75 0c             	pushl  0xc(%ebp)
  80076a:	ff 75 08             	pushl  0x8(%ebp)
  80076d:	50                   	push   %eax
  80076e:	68 05 27 80 00       	push   $0x802705
  800773:	e8 70 02 00 00       	call   8009e8 <cprintf>
  800778:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80077b:	8b 45 10             	mov    0x10(%ebp),%eax
  80077e:	83 ec 08             	sub    $0x8,%esp
  800781:	ff 75 f4             	pushl  -0xc(%ebp)
  800784:	50                   	push   %eax
  800785:	e8 f3 01 00 00       	call   80097d <vcprintf>
  80078a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80078d:	83 ec 08             	sub    $0x8,%esp
  800790:	6a 00                	push   $0x0
  800792:	68 21 27 80 00       	push   $0x802721
  800797:	e8 e1 01 00 00       	call   80097d <vcprintf>
  80079c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80079f:	e8 82 ff ff ff       	call   800726 <exit>

	// should not return here
	while (1) ;
  8007a4:	eb fe                	jmp    8007a4 <_panic+0x70>

008007a6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007a6:	55                   	push   %ebp
  8007a7:	89 e5                	mov    %esp,%ebp
  8007a9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007ac:	a1 24 30 80 00       	mov    0x803024,%eax
  8007b1:	8b 50 74             	mov    0x74(%eax),%edx
  8007b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007b7:	39 c2                	cmp    %eax,%edx
  8007b9:	74 14                	je     8007cf <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007bb:	83 ec 04             	sub    $0x4,%esp
  8007be:	68 24 27 80 00       	push   $0x802724
  8007c3:	6a 26                	push   $0x26
  8007c5:	68 70 27 80 00       	push   $0x802770
  8007ca:	e8 65 ff ff ff       	call   800734 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007d6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007dd:	e9 c2 00 00 00       	jmp    8008a4 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8007e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ef:	01 d0                	add    %edx,%eax
  8007f1:	8b 00                	mov    (%eax),%eax
  8007f3:	85 c0                	test   %eax,%eax
  8007f5:	75 08                	jne    8007ff <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007f7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007fa:	e9 a2 00 00 00       	jmp    8008a1 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007ff:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800806:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80080d:	eb 69                	jmp    800878 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80080f:	a1 24 30 80 00       	mov    0x803024,%eax
  800814:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80081a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80081d:	89 d0                	mov    %edx,%eax
  80081f:	01 c0                	add    %eax,%eax
  800821:	01 d0                	add    %edx,%eax
  800823:	c1 e0 02             	shl    $0x2,%eax
  800826:	01 c8                	add    %ecx,%eax
  800828:	8a 40 04             	mov    0x4(%eax),%al
  80082b:	84 c0                	test   %al,%al
  80082d:	75 46                	jne    800875 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80082f:	a1 24 30 80 00       	mov    0x803024,%eax
  800834:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80083a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80083d:	89 d0                	mov    %edx,%eax
  80083f:	01 c0                	add    %eax,%eax
  800841:	01 d0                	add    %edx,%eax
  800843:	c1 e0 02             	shl    $0x2,%eax
  800846:	01 c8                	add    %ecx,%eax
  800848:	8b 00                	mov    (%eax),%eax
  80084a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80084d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800850:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800855:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800857:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80085a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800861:	8b 45 08             	mov    0x8(%ebp),%eax
  800864:	01 c8                	add    %ecx,%eax
  800866:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800868:	39 c2                	cmp    %eax,%edx
  80086a:	75 09                	jne    800875 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80086c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800873:	eb 12                	jmp    800887 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800875:	ff 45 e8             	incl   -0x18(%ebp)
  800878:	a1 24 30 80 00       	mov    0x803024,%eax
  80087d:	8b 50 74             	mov    0x74(%eax),%edx
  800880:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800883:	39 c2                	cmp    %eax,%edx
  800885:	77 88                	ja     80080f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800887:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80088b:	75 14                	jne    8008a1 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80088d:	83 ec 04             	sub    $0x4,%esp
  800890:	68 7c 27 80 00       	push   $0x80277c
  800895:	6a 3a                	push   $0x3a
  800897:	68 70 27 80 00       	push   $0x802770
  80089c:	e8 93 fe ff ff       	call   800734 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008a1:	ff 45 f0             	incl   -0x10(%ebp)
  8008a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008a7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008aa:	0f 8c 32 ff ff ff    	jl     8007e2 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008b0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008b7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008be:	eb 26                	jmp    8008e6 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008c0:	a1 24 30 80 00       	mov    0x803024,%eax
  8008c5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008cb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008ce:	89 d0                	mov    %edx,%eax
  8008d0:	01 c0                	add    %eax,%eax
  8008d2:	01 d0                	add    %edx,%eax
  8008d4:	c1 e0 02             	shl    $0x2,%eax
  8008d7:	01 c8                	add    %ecx,%eax
  8008d9:	8a 40 04             	mov    0x4(%eax),%al
  8008dc:	3c 01                	cmp    $0x1,%al
  8008de:	75 03                	jne    8008e3 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8008e0:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008e3:	ff 45 e0             	incl   -0x20(%ebp)
  8008e6:	a1 24 30 80 00       	mov    0x803024,%eax
  8008eb:	8b 50 74             	mov    0x74(%eax),%edx
  8008ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008f1:	39 c2                	cmp    %eax,%edx
  8008f3:	77 cb                	ja     8008c0 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008f8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008fb:	74 14                	je     800911 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008fd:	83 ec 04             	sub    $0x4,%esp
  800900:	68 d0 27 80 00       	push   $0x8027d0
  800905:	6a 44                	push   $0x44
  800907:	68 70 27 80 00       	push   $0x802770
  80090c:	e8 23 fe ff ff       	call   800734 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800911:	90                   	nop
  800912:	c9                   	leave  
  800913:	c3                   	ret    

00800914 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800914:	55                   	push   %ebp
  800915:	89 e5                	mov    %esp,%ebp
  800917:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80091a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091d:	8b 00                	mov    (%eax),%eax
  80091f:	8d 48 01             	lea    0x1(%eax),%ecx
  800922:	8b 55 0c             	mov    0xc(%ebp),%edx
  800925:	89 0a                	mov    %ecx,(%edx)
  800927:	8b 55 08             	mov    0x8(%ebp),%edx
  80092a:	88 d1                	mov    %dl,%cl
  80092c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800933:	8b 45 0c             	mov    0xc(%ebp),%eax
  800936:	8b 00                	mov    (%eax),%eax
  800938:	3d ff 00 00 00       	cmp    $0xff,%eax
  80093d:	75 2c                	jne    80096b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80093f:	a0 28 30 80 00       	mov    0x803028,%al
  800944:	0f b6 c0             	movzbl %al,%eax
  800947:	8b 55 0c             	mov    0xc(%ebp),%edx
  80094a:	8b 12                	mov    (%edx),%edx
  80094c:	89 d1                	mov    %edx,%ecx
  80094e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800951:	83 c2 08             	add    $0x8,%edx
  800954:	83 ec 04             	sub    $0x4,%esp
  800957:	50                   	push   %eax
  800958:	51                   	push   %ecx
  800959:	52                   	push   %edx
  80095a:	e8 d4 12 00 00       	call   801c33 <sys_cputs>
  80095f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800962:	8b 45 0c             	mov    0xc(%ebp),%eax
  800965:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80096b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80096e:	8b 40 04             	mov    0x4(%eax),%eax
  800971:	8d 50 01             	lea    0x1(%eax),%edx
  800974:	8b 45 0c             	mov    0xc(%ebp),%eax
  800977:	89 50 04             	mov    %edx,0x4(%eax)
}
  80097a:	90                   	nop
  80097b:	c9                   	leave  
  80097c:	c3                   	ret    

0080097d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80097d:	55                   	push   %ebp
  80097e:	89 e5                	mov    %esp,%ebp
  800980:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800986:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80098d:	00 00 00 
	b.cnt = 0;
  800990:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800997:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80099a:	ff 75 0c             	pushl  0xc(%ebp)
  80099d:	ff 75 08             	pushl  0x8(%ebp)
  8009a0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009a6:	50                   	push   %eax
  8009a7:	68 14 09 80 00       	push   $0x800914
  8009ac:	e8 11 02 00 00       	call   800bc2 <vprintfmt>
  8009b1:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009b4:	a0 28 30 80 00       	mov    0x803028,%al
  8009b9:	0f b6 c0             	movzbl %al,%eax
  8009bc:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009c2:	83 ec 04             	sub    $0x4,%esp
  8009c5:	50                   	push   %eax
  8009c6:	52                   	push   %edx
  8009c7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009cd:	83 c0 08             	add    $0x8,%eax
  8009d0:	50                   	push   %eax
  8009d1:	e8 5d 12 00 00       	call   801c33 <sys_cputs>
  8009d6:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009d9:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009e0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009e6:	c9                   	leave  
  8009e7:	c3                   	ret    

008009e8 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009e8:	55                   	push   %ebp
  8009e9:	89 e5                	mov    %esp,%ebp
  8009eb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009ee:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009f5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fe:	83 ec 08             	sub    $0x8,%esp
  800a01:	ff 75 f4             	pushl  -0xc(%ebp)
  800a04:	50                   	push   %eax
  800a05:	e8 73 ff ff ff       	call   80097d <vcprintf>
  800a0a:	83 c4 10             	add    $0x10,%esp
  800a0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a10:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a13:	c9                   	leave  
  800a14:	c3                   	ret    

00800a15 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a15:	55                   	push   %ebp
  800a16:	89 e5                	mov    %esp,%ebp
  800a18:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a1b:	e8 24 14 00 00       	call   801e44 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a20:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a23:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a26:	8b 45 08             	mov    0x8(%ebp),%eax
  800a29:	83 ec 08             	sub    $0x8,%esp
  800a2c:	ff 75 f4             	pushl  -0xc(%ebp)
  800a2f:	50                   	push   %eax
  800a30:	e8 48 ff ff ff       	call   80097d <vcprintf>
  800a35:	83 c4 10             	add    $0x10,%esp
  800a38:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a3b:	e8 1e 14 00 00       	call   801e5e <sys_enable_interrupt>
	return cnt;
  800a40:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a43:	c9                   	leave  
  800a44:	c3                   	ret    

00800a45 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a45:	55                   	push   %ebp
  800a46:	89 e5                	mov    %esp,%ebp
  800a48:	53                   	push   %ebx
  800a49:	83 ec 14             	sub    $0x14,%esp
  800a4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800a4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a52:	8b 45 14             	mov    0x14(%ebp),%eax
  800a55:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a58:	8b 45 18             	mov    0x18(%ebp),%eax
  800a5b:	ba 00 00 00 00       	mov    $0x0,%edx
  800a60:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a63:	77 55                	ja     800aba <printnum+0x75>
  800a65:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a68:	72 05                	jb     800a6f <printnum+0x2a>
  800a6a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a6d:	77 4b                	ja     800aba <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a6f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a72:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a75:	8b 45 18             	mov    0x18(%ebp),%eax
  800a78:	ba 00 00 00 00       	mov    $0x0,%edx
  800a7d:	52                   	push   %edx
  800a7e:	50                   	push   %eax
  800a7f:	ff 75 f4             	pushl  -0xc(%ebp)
  800a82:	ff 75 f0             	pushl  -0x10(%ebp)
  800a85:	e8 9a 17 00 00       	call   802224 <__udivdi3>
  800a8a:	83 c4 10             	add    $0x10,%esp
  800a8d:	83 ec 04             	sub    $0x4,%esp
  800a90:	ff 75 20             	pushl  0x20(%ebp)
  800a93:	53                   	push   %ebx
  800a94:	ff 75 18             	pushl  0x18(%ebp)
  800a97:	52                   	push   %edx
  800a98:	50                   	push   %eax
  800a99:	ff 75 0c             	pushl  0xc(%ebp)
  800a9c:	ff 75 08             	pushl  0x8(%ebp)
  800a9f:	e8 a1 ff ff ff       	call   800a45 <printnum>
  800aa4:	83 c4 20             	add    $0x20,%esp
  800aa7:	eb 1a                	jmp    800ac3 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800aa9:	83 ec 08             	sub    $0x8,%esp
  800aac:	ff 75 0c             	pushl  0xc(%ebp)
  800aaf:	ff 75 20             	pushl  0x20(%ebp)
  800ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab5:	ff d0                	call   *%eax
  800ab7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800aba:	ff 4d 1c             	decl   0x1c(%ebp)
  800abd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800ac1:	7f e6                	jg     800aa9 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800ac3:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ac6:	bb 00 00 00 00       	mov    $0x0,%ebx
  800acb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ace:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ad1:	53                   	push   %ebx
  800ad2:	51                   	push   %ecx
  800ad3:	52                   	push   %edx
  800ad4:	50                   	push   %eax
  800ad5:	e8 5a 18 00 00       	call   802334 <__umoddi3>
  800ada:	83 c4 10             	add    $0x10,%esp
  800add:	05 34 2a 80 00       	add    $0x802a34,%eax
  800ae2:	8a 00                	mov    (%eax),%al
  800ae4:	0f be c0             	movsbl %al,%eax
  800ae7:	83 ec 08             	sub    $0x8,%esp
  800aea:	ff 75 0c             	pushl  0xc(%ebp)
  800aed:	50                   	push   %eax
  800aee:	8b 45 08             	mov    0x8(%ebp),%eax
  800af1:	ff d0                	call   *%eax
  800af3:	83 c4 10             	add    $0x10,%esp
}
  800af6:	90                   	nop
  800af7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800afa:	c9                   	leave  
  800afb:	c3                   	ret    

00800afc <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800afc:	55                   	push   %ebp
  800afd:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800aff:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b03:	7e 1c                	jle    800b21 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	8b 00                	mov    (%eax),%eax
  800b0a:	8d 50 08             	lea    0x8(%eax),%edx
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b10:	89 10                	mov    %edx,(%eax)
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	8b 00                	mov    (%eax),%eax
  800b17:	83 e8 08             	sub    $0x8,%eax
  800b1a:	8b 50 04             	mov    0x4(%eax),%edx
  800b1d:	8b 00                	mov    (%eax),%eax
  800b1f:	eb 40                	jmp    800b61 <getuint+0x65>
	else if (lflag)
  800b21:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b25:	74 1e                	je     800b45 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2a:	8b 00                	mov    (%eax),%eax
  800b2c:	8d 50 04             	lea    0x4(%eax),%edx
  800b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b32:	89 10                	mov    %edx,(%eax)
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	8b 00                	mov    (%eax),%eax
  800b39:	83 e8 04             	sub    $0x4,%eax
  800b3c:	8b 00                	mov    (%eax),%eax
  800b3e:	ba 00 00 00 00       	mov    $0x0,%edx
  800b43:	eb 1c                	jmp    800b61 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b45:	8b 45 08             	mov    0x8(%ebp),%eax
  800b48:	8b 00                	mov    (%eax),%eax
  800b4a:	8d 50 04             	lea    0x4(%eax),%edx
  800b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b50:	89 10                	mov    %edx,(%eax)
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	8b 00                	mov    (%eax),%eax
  800b57:	83 e8 04             	sub    $0x4,%eax
  800b5a:	8b 00                	mov    (%eax),%eax
  800b5c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b61:	5d                   	pop    %ebp
  800b62:	c3                   	ret    

00800b63 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b63:	55                   	push   %ebp
  800b64:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b66:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b6a:	7e 1c                	jle    800b88 <getint+0x25>
		return va_arg(*ap, long long);
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6f:	8b 00                	mov    (%eax),%eax
  800b71:	8d 50 08             	lea    0x8(%eax),%edx
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	89 10                	mov    %edx,(%eax)
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7c:	8b 00                	mov    (%eax),%eax
  800b7e:	83 e8 08             	sub    $0x8,%eax
  800b81:	8b 50 04             	mov    0x4(%eax),%edx
  800b84:	8b 00                	mov    (%eax),%eax
  800b86:	eb 38                	jmp    800bc0 <getint+0x5d>
	else if (lflag)
  800b88:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b8c:	74 1a                	je     800ba8 <getint+0x45>
		return va_arg(*ap, long);
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	8b 00                	mov    (%eax),%eax
  800b93:	8d 50 04             	lea    0x4(%eax),%edx
  800b96:	8b 45 08             	mov    0x8(%ebp),%eax
  800b99:	89 10                	mov    %edx,(%eax)
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	8b 00                	mov    (%eax),%eax
  800ba0:	83 e8 04             	sub    $0x4,%eax
  800ba3:	8b 00                	mov    (%eax),%eax
  800ba5:	99                   	cltd   
  800ba6:	eb 18                	jmp    800bc0 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	8b 00                	mov    (%eax),%eax
  800bad:	8d 50 04             	lea    0x4(%eax),%edx
  800bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb3:	89 10                	mov    %edx,(%eax)
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	8b 00                	mov    (%eax),%eax
  800bba:	83 e8 04             	sub    $0x4,%eax
  800bbd:	8b 00                	mov    (%eax),%eax
  800bbf:	99                   	cltd   
}
  800bc0:	5d                   	pop    %ebp
  800bc1:	c3                   	ret    

00800bc2 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bc2:	55                   	push   %ebp
  800bc3:	89 e5                	mov    %esp,%ebp
  800bc5:	56                   	push   %esi
  800bc6:	53                   	push   %ebx
  800bc7:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bca:	eb 17                	jmp    800be3 <vprintfmt+0x21>
			if (ch == '\0')
  800bcc:	85 db                	test   %ebx,%ebx
  800bce:	0f 84 af 03 00 00    	je     800f83 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bd4:	83 ec 08             	sub    $0x8,%esp
  800bd7:	ff 75 0c             	pushl  0xc(%ebp)
  800bda:	53                   	push   %ebx
  800bdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bde:	ff d0                	call   *%eax
  800be0:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800be3:	8b 45 10             	mov    0x10(%ebp),%eax
  800be6:	8d 50 01             	lea    0x1(%eax),%edx
  800be9:	89 55 10             	mov    %edx,0x10(%ebp)
  800bec:	8a 00                	mov    (%eax),%al
  800bee:	0f b6 d8             	movzbl %al,%ebx
  800bf1:	83 fb 25             	cmp    $0x25,%ebx
  800bf4:	75 d6                	jne    800bcc <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bf6:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bfa:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c01:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c08:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c0f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c16:	8b 45 10             	mov    0x10(%ebp),%eax
  800c19:	8d 50 01             	lea    0x1(%eax),%edx
  800c1c:	89 55 10             	mov    %edx,0x10(%ebp)
  800c1f:	8a 00                	mov    (%eax),%al
  800c21:	0f b6 d8             	movzbl %al,%ebx
  800c24:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c27:	83 f8 55             	cmp    $0x55,%eax
  800c2a:	0f 87 2b 03 00 00    	ja     800f5b <vprintfmt+0x399>
  800c30:	8b 04 85 58 2a 80 00 	mov    0x802a58(,%eax,4),%eax
  800c37:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c39:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c3d:	eb d7                	jmp    800c16 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c3f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c43:	eb d1                	jmp    800c16 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c45:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c4c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c4f:	89 d0                	mov    %edx,%eax
  800c51:	c1 e0 02             	shl    $0x2,%eax
  800c54:	01 d0                	add    %edx,%eax
  800c56:	01 c0                	add    %eax,%eax
  800c58:	01 d8                	add    %ebx,%eax
  800c5a:	83 e8 30             	sub    $0x30,%eax
  800c5d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c60:	8b 45 10             	mov    0x10(%ebp),%eax
  800c63:	8a 00                	mov    (%eax),%al
  800c65:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c68:	83 fb 2f             	cmp    $0x2f,%ebx
  800c6b:	7e 3e                	jle    800cab <vprintfmt+0xe9>
  800c6d:	83 fb 39             	cmp    $0x39,%ebx
  800c70:	7f 39                	jg     800cab <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c72:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c75:	eb d5                	jmp    800c4c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c77:	8b 45 14             	mov    0x14(%ebp),%eax
  800c7a:	83 c0 04             	add    $0x4,%eax
  800c7d:	89 45 14             	mov    %eax,0x14(%ebp)
  800c80:	8b 45 14             	mov    0x14(%ebp),%eax
  800c83:	83 e8 04             	sub    $0x4,%eax
  800c86:	8b 00                	mov    (%eax),%eax
  800c88:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c8b:	eb 1f                	jmp    800cac <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c8d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c91:	79 83                	jns    800c16 <vprintfmt+0x54>
				width = 0;
  800c93:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c9a:	e9 77 ff ff ff       	jmp    800c16 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c9f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ca6:	e9 6b ff ff ff       	jmp    800c16 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800cab:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800cac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cb0:	0f 89 60 ff ff ff    	jns    800c16 <vprintfmt+0x54>
				width = precision, precision = -1;
  800cb6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cb9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cbc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cc3:	e9 4e ff ff ff       	jmp    800c16 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cc8:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ccb:	e9 46 ff ff ff       	jmp    800c16 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cd0:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd3:	83 c0 04             	add    $0x4,%eax
  800cd6:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd9:	8b 45 14             	mov    0x14(%ebp),%eax
  800cdc:	83 e8 04             	sub    $0x4,%eax
  800cdf:	8b 00                	mov    (%eax),%eax
  800ce1:	83 ec 08             	sub    $0x8,%esp
  800ce4:	ff 75 0c             	pushl  0xc(%ebp)
  800ce7:	50                   	push   %eax
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ceb:	ff d0                	call   *%eax
  800ced:	83 c4 10             	add    $0x10,%esp
			break;
  800cf0:	e9 89 02 00 00       	jmp    800f7e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cf5:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf8:	83 c0 04             	add    $0x4,%eax
  800cfb:	89 45 14             	mov    %eax,0x14(%ebp)
  800cfe:	8b 45 14             	mov    0x14(%ebp),%eax
  800d01:	83 e8 04             	sub    $0x4,%eax
  800d04:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d06:	85 db                	test   %ebx,%ebx
  800d08:	79 02                	jns    800d0c <vprintfmt+0x14a>
				err = -err;
  800d0a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d0c:	83 fb 64             	cmp    $0x64,%ebx
  800d0f:	7f 0b                	jg     800d1c <vprintfmt+0x15a>
  800d11:	8b 34 9d a0 28 80 00 	mov    0x8028a0(,%ebx,4),%esi
  800d18:	85 f6                	test   %esi,%esi
  800d1a:	75 19                	jne    800d35 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d1c:	53                   	push   %ebx
  800d1d:	68 45 2a 80 00       	push   $0x802a45
  800d22:	ff 75 0c             	pushl  0xc(%ebp)
  800d25:	ff 75 08             	pushl  0x8(%ebp)
  800d28:	e8 5e 02 00 00       	call   800f8b <printfmt>
  800d2d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d30:	e9 49 02 00 00       	jmp    800f7e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d35:	56                   	push   %esi
  800d36:	68 4e 2a 80 00       	push   $0x802a4e
  800d3b:	ff 75 0c             	pushl  0xc(%ebp)
  800d3e:	ff 75 08             	pushl  0x8(%ebp)
  800d41:	e8 45 02 00 00       	call   800f8b <printfmt>
  800d46:	83 c4 10             	add    $0x10,%esp
			break;
  800d49:	e9 30 02 00 00       	jmp    800f7e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d4e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d51:	83 c0 04             	add    $0x4,%eax
  800d54:	89 45 14             	mov    %eax,0x14(%ebp)
  800d57:	8b 45 14             	mov    0x14(%ebp),%eax
  800d5a:	83 e8 04             	sub    $0x4,%eax
  800d5d:	8b 30                	mov    (%eax),%esi
  800d5f:	85 f6                	test   %esi,%esi
  800d61:	75 05                	jne    800d68 <vprintfmt+0x1a6>
				p = "(null)";
  800d63:	be 51 2a 80 00       	mov    $0x802a51,%esi
			if (width > 0 && padc != '-')
  800d68:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d6c:	7e 6d                	jle    800ddb <vprintfmt+0x219>
  800d6e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d72:	74 67                	je     800ddb <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d74:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d77:	83 ec 08             	sub    $0x8,%esp
  800d7a:	50                   	push   %eax
  800d7b:	56                   	push   %esi
  800d7c:	e8 12 05 00 00       	call   801293 <strnlen>
  800d81:	83 c4 10             	add    $0x10,%esp
  800d84:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d87:	eb 16                	jmp    800d9f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d89:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d8d:	83 ec 08             	sub    $0x8,%esp
  800d90:	ff 75 0c             	pushl  0xc(%ebp)
  800d93:	50                   	push   %eax
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	ff d0                	call   *%eax
  800d99:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d9c:	ff 4d e4             	decl   -0x1c(%ebp)
  800d9f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da3:	7f e4                	jg     800d89 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800da5:	eb 34                	jmp    800ddb <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800da7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800dab:	74 1c                	je     800dc9 <vprintfmt+0x207>
  800dad:	83 fb 1f             	cmp    $0x1f,%ebx
  800db0:	7e 05                	jle    800db7 <vprintfmt+0x1f5>
  800db2:	83 fb 7e             	cmp    $0x7e,%ebx
  800db5:	7e 12                	jle    800dc9 <vprintfmt+0x207>
					putch('?', putdat);
  800db7:	83 ec 08             	sub    $0x8,%esp
  800dba:	ff 75 0c             	pushl  0xc(%ebp)
  800dbd:	6a 3f                	push   $0x3f
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	ff d0                	call   *%eax
  800dc4:	83 c4 10             	add    $0x10,%esp
  800dc7:	eb 0f                	jmp    800dd8 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800dc9:	83 ec 08             	sub    $0x8,%esp
  800dcc:	ff 75 0c             	pushl  0xc(%ebp)
  800dcf:	53                   	push   %ebx
  800dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd3:	ff d0                	call   *%eax
  800dd5:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dd8:	ff 4d e4             	decl   -0x1c(%ebp)
  800ddb:	89 f0                	mov    %esi,%eax
  800ddd:	8d 70 01             	lea    0x1(%eax),%esi
  800de0:	8a 00                	mov    (%eax),%al
  800de2:	0f be d8             	movsbl %al,%ebx
  800de5:	85 db                	test   %ebx,%ebx
  800de7:	74 24                	je     800e0d <vprintfmt+0x24b>
  800de9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ded:	78 b8                	js     800da7 <vprintfmt+0x1e5>
  800def:	ff 4d e0             	decl   -0x20(%ebp)
  800df2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800df6:	79 af                	jns    800da7 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800df8:	eb 13                	jmp    800e0d <vprintfmt+0x24b>
				putch(' ', putdat);
  800dfa:	83 ec 08             	sub    $0x8,%esp
  800dfd:	ff 75 0c             	pushl  0xc(%ebp)
  800e00:	6a 20                	push   $0x20
  800e02:	8b 45 08             	mov    0x8(%ebp),%eax
  800e05:	ff d0                	call   *%eax
  800e07:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e0a:	ff 4d e4             	decl   -0x1c(%ebp)
  800e0d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e11:	7f e7                	jg     800dfa <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e13:	e9 66 01 00 00       	jmp    800f7e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e18:	83 ec 08             	sub    $0x8,%esp
  800e1b:	ff 75 e8             	pushl  -0x18(%ebp)
  800e1e:	8d 45 14             	lea    0x14(%ebp),%eax
  800e21:	50                   	push   %eax
  800e22:	e8 3c fd ff ff       	call   800b63 <getint>
  800e27:	83 c4 10             	add    $0x10,%esp
  800e2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e30:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e33:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e36:	85 d2                	test   %edx,%edx
  800e38:	79 23                	jns    800e5d <vprintfmt+0x29b>
				putch('-', putdat);
  800e3a:	83 ec 08             	sub    $0x8,%esp
  800e3d:	ff 75 0c             	pushl  0xc(%ebp)
  800e40:	6a 2d                	push   $0x2d
  800e42:	8b 45 08             	mov    0x8(%ebp),%eax
  800e45:	ff d0                	call   *%eax
  800e47:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e50:	f7 d8                	neg    %eax
  800e52:	83 d2 00             	adc    $0x0,%edx
  800e55:	f7 da                	neg    %edx
  800e57:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e5a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e5d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e64:	e9 bc 00 00 00       	jmp    800f25 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e69:	83 ec 08             	sub    $0x8,%esp
  800e6c:	ff 75 e8             	pushl  -0x18(%ebp)
  800e6f:	8d 45 14             	lea    0x14(%ebp),%eax
  800e72:	50                   	push   %eax
  800e73:	e8 84 fc ff ff       	call   800afc <getuint>
  800e78:	83 c4 10             	add    $0x10,%esp
  800e7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e7e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e81:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e88:	e9 98 00 00 00       	jmp    800f25 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e8d:	83 ec 08             	sub    $0x8,%esp
  800e90:	ff 75 0c             	pushl  0xc(%ebp)
  800e93:	6a 58                	push   $0x58
  800e95:	8b 45 08             	mov    0x8(%ebp),%eax
  800e98:	ff d0                	call   *%eax
  800e9a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e9d:	83 ec 08             	sub    $0x8,%esp
  800ea0:	ff 75 0c             	pushl  0xc(%ebp)
  800ea3:	6a 58                	push   $0x58
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea8:	ff d0                	call   *%eax
  800eaa:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ead:	83 ec 08             	sub    $0x8,%esp
  800eb0:	ff 75 0c             	pushl  0xc(%ebp)
  800eb3:	6a 58                	push   $0x58
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	ff d0                	call   *%eax
  800eba:	83 c4 10             	add    $0x10,%esp
			break;
  800ebd:	e9 bc 00 00 00       	jmp    800f7e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ec2:	83 ec 08             	sub    $0x8,%esp
  800ec5:	ff 75 0c             	pushl  0xc(%ebp)
  800ec8:	6a 30                	push   $0x30
  800eca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecd:	ff d0                	call   *%eax
  800ecf:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ed2:	83 ec 08             	sub    $0x8,%esp
  800ed5:	ff 75 0c             	pushl  0xc(%ebp)
  800ed8:	6a 78                	push   $0x78
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	ff d0                	call   *%eax
  800edf:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ee2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee5:	83 c0 04             	add    $0x4,%eax
  800ee8:	89 45 14             	mov    %eax,0x14(%ebp)
  800eeb:	8b 45 14             	mov    0x14(%ebp),%eax
  800eee:	83 e8 04             	sub    $0x4,%eax
  800ef1:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ef3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800efd:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f04:	eb 1f                	jmp    800f25 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f06:	83 ec 08             	sub    $0x8,%esp
  800f09:	ff 75 e8             	pushl  -0x18(%ebp)
  800f0c:	8d 45 14             	lea    0x14(%ebp),%eax
  800f0f:	50                   	push   %eax
  800f10:	e8 e7 fb ff ff       	call   800afc <getuint>
  800f15:	83 c4 10             	add    $0x10,%esp
  800f18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f1b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f1e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f25:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f29:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f2c:	83 ec 04             	sub    $0x4,%esp
  800f2f:	52                   	push   %edx
  800f30:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f33:	50                   	push   %eax
  800f34:	ff 75 f4             	pushl  -0xc(%ebp)
  800f37:	ff 75 f0             	pushl  -0x10(%ebp)
  800f3a:	ff 75 0c             	pushl  0xc(%ebp)
  800f3d:	ff 75 08             	pushl  0x8(%ebp)
  800f40:	e8 00 fb ff ff       	call   800a45 <printnum>
  800f45:	83 c4 20             	add    $0x20,%esp
			break;
  800f48:	eb 34                	jmp    800f7e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f4a:	83 ec 08             	sub    $0x8,%esp
  800f4d:	ff 75 0c             	pushl  0xc(%ebp)
  800f50:	53                   	push   %ebx
  800f51:	8b 45 08             	mov    0x8(%ebp),%eax
  800f54:	ff d0                	call   *%eax
  800f56:	83 c4 10             	add    $0x10,%esp
			break;
  800f59:	eb 23                	jmp    800f7e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f5b:	83 ec 08             	sub    $0x8,%esp
  800f5e:	ff 75 0c             	pushl  0xc(%ebp)
  800f61:	6a 25                	push   $0x25
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
  800f66:	ff d0                	call   *%eax
  800f68:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f6b:	ff 4d 10             	decl   0x10(%ebp)
  800f6e:	eb 03                	jmp    800f73 <vprintfmt+0x3b1>
  800f70:	ff 4d 10             	decl   0x10(%ebp)
  800f73:	8b 45 10             	mov    0x10(%ebp),%eax
  800f76:	48                   	dec    %eax
  800f77:	8a 00                	mov    (%eax),%al
  800f79:	3c 25                	cmp    $0x25,%al
  800f7b:	75 f3                	jne    800f70 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f7d:	90                   	nop
		}
	}
  800f7e:	e9 47 fc ff ff       	jmp    800bca <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f83:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f84:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f87:	5b                   	pop    %ebx
  800f88:	5e                   	pop    %esi
  800f89:	5d                   	pop    %ebp
  800f8a:	c3                   	ret    

00800f8b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f8b:	55                   	push   %ebp
  800f8c:	89 e5                	mov    %esp,%ebp
  800f8e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f91:	8d 45 10             	lea    0x10(%ebp),%eax
  800f94:	83 c0 04             	add    $0x4,%eax
  800f97:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9d:	ff 75 f4             	pushl  -0xc(%ebp)
  800fa0:	50                   	push   %eax
  800fa1:	ff 75 0c             	pushl  0xc(%ebp)
  800fa4:	ff 75 08             	pushl  0x8(%ebp)
  800fa7:	e8 16 fc ff ff       	call   800bc2 <vprintfmt>
  800fac:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800faf:	90                   	nop
  800fb0:	c9                   	leave  
  800fb1:	c3                   	ret    

00800fb2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fb2:	55                   	push   %ebp
  800fb3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb8:	8b 40 08             	mov    0x8(%eax),%eax
  800fbb:	8d 50 01             	lea    0x1(%eax),%edx
  800fbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc7:	8b 10                	mov    (%eax),%edx
  800fc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcc:	8b 40 04             	mov    0x4(%eax),%eax
  800fcf:	39 c2                	cmp    %eax,%edx
  800fd1:	73 12                	jae    800fe5 <sprintputch+0x33>
		*b->buf++ = ch;
  800fd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd6:	8b 00                	mov    (%eax),%eax
  800fd8:	8d 48 01             	lea    0x1(%eax),%ecx
  800fdb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fde:	89 0a                	mov    %ecx,(%edx)
  800fe0:	8b 55 08             	mov    0x8(%ebp),%edx
  800fe3:	88 10                	mov    %dl,(%eax)
}
  800fe5:	90                   	nop
  800fe6:	5d                   	pop    %ebp
  800fe7:	c3                   	ret    

00800fe8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fe8:	55                   	push   %ebp
  800fe9:	89 e5                	mov    %esp,%ebp
  800feb:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800ff4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ffa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffd:	01 d0                	add    %edx,%eax
  800fff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801002:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801009:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80100d:	74 06                	je     801015 <vsnprintf+0x2d>
  80100f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801013:	7f 07                	jg     80101c <vsnprintf+0x34>
		return -E_INVAL;
  801015:	b8 03 00 00 00       	mov    $0x3,%eax
  80101a:	eb 20                	jmp    80103c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80101c:	ff 75 14             	pushl  0x14(%ebp)
  80101f:	ff 75 10             	pushl  0x10(%ebp)
  801022:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801025:	50                   	push   %eax
  801026:	68 b2 0f 80 00       	push   $0x800fb2
  80102b:	e8 92 fb ff ff       	call   800bc2 <vprintfmt>
  801030:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801033:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801036:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801039:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80103c:	c9                   	leave  
  80103d:	c3                   	ret    

0080103e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80103e:	55                   	push   %ebp
  80103f:	89 e5                	mov    %esp,%ebp
  801041:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801044:	8d 45 10             	lea    0x10(%ebp),%eax
  801047:	83 c0 04             	add    $0x4,%eax
  80104a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80104d:	8b 45 10             	mov    0x10(%ebp),%eax
  801050:	ff 75 f4             	pushl  -0xc(%ebp)
  801053:	50                   	push   %eax
  801054:	ff 75 0c             	pushl  0xc(%ebp)
  801057:	ff 75 08             	pushl  0x8(%ebp)
  80105a:	e8 89 ff ff ff       	call   800fe8 <vsnprintf>
  80105f:	83 c4 10             	add    $0x10,%esp
  801062:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801065:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801068:	c9                   	leave  
  801069:	c3                   	ret    

0080106a <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80106a:	55                   	push   %ebp
  80106b:	89 e5                	mov    %esp,%ebp
  80106d:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801070:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801074:	74 13                	je     801089 <readline+0x1f>
		cprintf("%s", prompt);
  801076:	83 ec 08             	sub    $0x8,%esp
  801079:	ff 75 08             	pushl  0x8(%ebp)
  80107c:	68 b0 2b 80 00       	push   $0x802bb0
  801081:	e8 62 f9 ff ff       	call   8009e8 <cprintf>
  801086:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801089:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801090:	83 ec 0c             	sub    $0xc,%esp
  801093:	6a 00                	push   $0x0
  801095:	e8 8e f5 ff ff       	call   800628 <iscons>
  80109a:	83 c4 10             	add    $0x10,%esp
  80109d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8010a0:	e8 35 f5 ff ff       	call   8005da <getchar>
  8010a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010ac:	79 22                	jns    8010d0 <readline+0x66>
			if (c != -E_EOF)
  8010ae:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010b2:	0f 84 ad 00 00 00    	je     801165 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010b8:	83 ec 08             	sub    $0x8,%esp
  8010bb:	ff 75 ec             	pushl  -0x14(%ebp)
  8010be:	68 b3 2b 80 00       	push   $0x802bb3
  8010c3:	e8 20 f9 ff ff       	call   8009e8 <cprintf>
  8010c8:	83 c4 10             	add    $0x10,%esp
			return;
  8010cb:	e9 95 00 00 00       	jmp    801165 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010d0:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010d4:	7e 34                	jle    80110a <readline+0xa0>
  8010d6:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010dd:	7f 2b                	jg     80110a <readline+0xa0>
			if (echoing)
  8010df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010e3:	74 0e                	je     8010f3 <readline+0x89>
				cputchar(c);
  8010e5:	83 ec 0c             	sub    $0xc,%esp
  8010e8:	ff 75 ec             	pushl  -0x14(%ebp)
  8010eb:	e8 a2 f4 ff ff       	call   800592 <cputchar>
  8010f0:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010f6:	8d 50 01             	lea    0x1(%eax),%edx
  8010f9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010fc:	89 c2                	mov    %eax,%edx
  8010fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801101:	01 d0                	add    %edx,%eax
  801103:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801106:	88 10                	mov    %dl,(%eax)
  801108:	eb 56                	jmp    801160 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80110a:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80110e:	75 1f                	jne    80112f <readline+0xc5>
  801110:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801114:	7e 19                	jle    80112f <readline+0xc5>
			if (echoing)
  801116:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80111a:	74 0e                	je     80112a <readline+0xc0>
				cputchar(c);
  80111c:	83 ec 0c             	sub    $0xc,%esp
  80111f:	ff 75 ec             	pushl  -0x14(%ebp)
  801122:	e8 6b f4 ff ff       	call   800592 <cputchar>
  801127:	83 c4 10             	add    $0x10,%esp

			i--;
  80112a:	ff 4d f4             	decl   -0xc(%ebp)
  80112d:	eb 31                	jmp    801160 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80112f:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801133:	74 0a                	je     80113f <readline+0xd5>
  801135:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801139:	0f 85 61 ff ff ff    	jne    8010a0 <readline+0x36>
			if (echoing)
  80113f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801143:	74 0e                	je     801153 <readline+0xe9>
				cputchar(c);
  801145:	83 ec 0c             	sub    $0xc,%esp
  801148:	ff 75 ec             	pushl  -0x14(%ebp)
  80114b:	e8 42 f4 ff ff       	call   800592 <cputchar>
  801150:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801153:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801156:	8b 45 0c             	mov    0xc(%ebp),%eax
  801159:	01 d0                	add    %edx,%eax
  80115b:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80115e:	eb 06                	jmp    801166 <readline+0xfc>
		}
	}
  801160:	e9 3b ff ff ff       	jmp    8010a0 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801165:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801166:	c9                   	leave  
  801167:	c3                   	ret    

00801168 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801168:	55                   	push   %ebp
  801169:	89 e5                	mov    %esp,%ebp
  80116b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80116e:	e8 d1 0c 00 00       	call   801e44 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801173:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801177:	74 13                	je     80118c <atomic_readline+0x24>
		cprintf("%s", prompt);
  801179:	83 ec 08             	sub    $0x8,%esp
  80117c:	ff 75 08             	pushl  0x8(%ebp)
  80117f:	68 b0 2b 80 00       	push   $0x802bb0
  801184:	e8 5f f8 ff ff       	call   8009e8 <cprintf>
  801189:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80118c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801193:	83 ec 0c             	sub    $0xc,%esp
  801196:	6a 00                	push   $0x0
  801198:	e8 8b f4 ff ff       	call   800628 <iscons>
  80119d:	83 c4 10             	add    $0x10,%esp
  8011a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011a3:	e8 32 f4 ff ff       	call   8005da <getchar>
  8011a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011ab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011af:	79 23                	jns    8011d4 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011b1:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011b5:	74 13                	je     8011ca <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011b7:	83 ec 08             	sub    $0x8,%esp
  8011ba:	ff 75 ec             	pushl  -0x14(%ebp)
  8011bd:	68 b3 2b 80 00       	push   $0x802bb3
  8011c2:	e8 21 f8 ff ff       	call   8009e8 <cprintf>
  8011c7:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011ca:	e8 8f 0c 00 00       	call   801e5e <sys_enable_interrupt>
			return;
  8011cf:	e9 9a 00 00 00       	jmp    80126e <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011d4:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011d8:	7e 34                	jle    80120e <atomic_readline+0xa6>
  8011da:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011e1:	7f 2b                	jg     80120e <atomic_readline+0xa6>
			if (echoing)
  8011e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011e7:	74 0e                	je     8011f7 <atomic_readline+0x8f>
				cputchar(c);
  8011e9:	83 ec 0c             	sub    $0xc,%esp
  8011ec:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ef:	e8 9e f3 ff ff       	call   800592 <cputchar>
  8011f4:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011fa:	8d 50 01             	lea    0x1(%eax),%edx
  8011fd:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801200:	89 c2                	mov    %eax,%edx
  801202:	8b 45 0c             	mov    0xc(%ebp),%eax
  801205:	01 d0                	add    %edx,%eax
  801207:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80120a:	88 10                	mov    %dl,(%eax)
  80120c:	eb 5b                	jmp    801269 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80120e:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801212:	75 1f                	jne    801233 <atomic_readline+0xcb>
  801214:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801218:	7e 19                	jle    801233 <atomic_readline+0xcb>
			if (echoing)
  80121a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80121e:	74 0e                	je     80122e <atomic_readline+0xc6>
				cputchar(c);
  801220:	83 ec 0c             	sub    $0xc,%esp
  801223:	ff 75 ec             	pushl  -0x14(%ebp)
  801226:	e8 67 f3 ff ff       	call   800592 <cputchar>
  80122b:	83 c4 10             	add    $0x10,%esp
			i--;
  80122e:	ff 4d f4             	decl   -0xc(%ebp)
  801231:	eb 36                	jmp    801269 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801233:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801237:	74 0a                	je     801243 <atomic_readline+0xdb>
  801239:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80123d:	0f 85 60 ff ff ff    	jne    8011a3 <atomic_readline+0x3b>
			if (echoing)
  801243:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801247:	74 0e                	je     801257 <atomic_readline+0xef>
				cputchar(c);
  801249:	83 ec 0c             	sub    $0xc,%esp
  80124c:	ff 75 ec             	pushl  -0x14(%ebp)
  80124f:	e8 3e f3 ff ff       	call   800592 <cputchar>
  801254:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801257:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80125a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125d:	01 d0                	add    %edx,%eax
  80125f:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801262:	e8 f7 0b 00 00       	call   801e5e <sys_enable_interrupt>
			return;
  801267:	eb 05                	jmp    80126e <atomic_readline+0x106>
		}
	}
  801269:	e9 35 ff ff ff       	jmp    8011a3 <atomic_readline+0x3b>
}
  80126e:	c9                   	leave  
  80126f:	c3                   	ret    

00801270 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801270:	55                   	push   %ebp
  801271:	89 e5                	mov    %esp,%ebp
  801273:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801276:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80127d:	eb 06                	jmp    801285 <strlen+0x15>
		n++;
  80127f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801282:	ff 45 08             	incl   0x8(%ebp)
  801285:	8b 45 08             	mov    0x8(%ebp),%eax
  801288:	8a 00                	mov    (%eax),%al
  80128a:	84 c0                	test   %al,%al
  80128c:	75 f1                	jne    80127f <strlen+0xf>
		n++;
	return n;
  80128e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801291:	c9                   	leave  
  801292:	c3                   	ret    

00801293 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801293:	55                   	push   %ebp
  801294:	89 e5                	mov    %esp,%ebp
  801296:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801299:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012a0:	eb 09                	jmp    8012ab <strnlen+0x18>
		n++;
  8012a2:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012a5:	ff 45 08             	incl   0x8(%ebp)
  8012a8:	ff 4d 0c             	decl   0xc(%ebp)
  8012ab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012af:	74 09                	je     8012ba <strnlen+0x27>
  8012b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b4:	8a 00                	mov    (%eax),%al
  8012b6:	84 c0                	test   %al,%al
  8012b8:	75 e8                	jne    8012a2 <strnlen+0xf>
		n++;
	return n;
  8012ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012bd:	c9                   	leave  
  8012be:	c3                   	ret    

008012bf <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012bf:	55                   	push   %ebp
  8012c0:	89 e5                	mov    %esp,%ebp
  8012c2:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012cb:	90                   	nop
  8012cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cf:	8d 50 01             	lea    0x1(%eax),%edx
  8012d2:	89 55 08             	mov    %edx,0x8(%ebp)
  8012d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012d8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012db:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012de:	8a 12                	mov    (%edx),%dl
  8012e0:	88 10                	mov    %dl,(%eax)
  8012e2:	8a 00                	mov    (%eax),%al
  8012e4:	84 c0                	test   %al,%al
  8012e6:	75 e4                	jne    8012cc <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012eb:	c9                   	leave  
  8012ec:	c3                   	ret    

008012ed <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012ed:	55                   	push   %ebp
  8012ee:	89 e5                	mov    %esp,%ebp
  8012f0:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801300:	eb 1f                	jmp    801321 <strncpy+0x34>
		*dst++ = *src;
  801302:	8b 45 08             	mov    0x8(%ebp),%eax
  801305:	8d 50 01             	lea    0x1(%eax),%edx
  801308:	89 55 08             	mov    %edx,0x8(%ebp)
  80130b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80130e:	8a 12                	mov    (%edx),%dl
  801310:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801312:	8b 45 0c             	mov    0xc(%ebp),%eax
  801315:	8a 00                	mov    (%eax),%al
  801317:	84 c0                	test   %al,%al
  801319:	74 03                	je     80131e <strncpy+0x31>
			src++;
  80131b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80131e:	ff 45 fc             	incl   -0x4(%ebp)
  801321:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801324:	3b 45 10             	cmp    0x10(%ebp),%eax
  801327:	72 d9                	jb     801302 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801329:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80132c:	c9                   	leave  
  80132d:	c3                   	ret    

0080132e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80132e:	55                   	push   %ebp
  80132f:	89 e5                	mov    %esp,%ebp
  801331:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80133a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80133e:	74 30                	je     801370 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801340:	eb 16                	jmp    801358 <strlcpy+0x2a>
			*dst++ = *src++;
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	8d 50 01             	lea    0x1(%eax),%edx
  801348:	89 55 08             	mov    %edx,0x8(%ebp)
  80134b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801351:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801354:	8a 12                	mov    (%edx),%dl
  801356:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801358:	ff 4d 10             	decl   0x10(%ebp)
  80135b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80135f:	74 09                	je     80136a <strlcpy+0x3c>
  801361:	8b 45 0c             	mov    0xc(%ebp),%eax
  801364:	8a 00                	mov    (%eax),%al
  801366:	84 c0                	test   %al,%al
  801368:	75 d8                	jne    801342 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801370:	8b 55 08             	mov    0x8(%ebp),%edx
  801373:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801376:	29 c2                	sub    %eax,%edx
  801378:	89 d0                	mov    %edx,%eax
}
  80137a:	c9                   	leave  
  80137b:	c3                   	ret    

0080137c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80137c:	55                   	push   %ebp
  80137d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80137f:	eb 06                	jmp    801387 <strcmp+0xb>
		p++, q++;
  801381:	ff 45 08             	incl   0x8(%ebp)
  801384:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801387:	8b 45 08             	mov    0x8(%ebp),%eax
  80138a:	8a 00                	mov    (%eax),%al
  80138c:	84 c0                	test   %al,%al
  80138e:	74 0e                	je     80139e <strcmp+0x22>
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	8a 10                	mov    (%eax),%dl
  801395:	8b 45 0c             	mov    0xc(%ebp),%eax
  801398:	8a 00                	mov    (%eax),%al
  80139a:	38 c2                	cmp    %al,%dl
  80139c:	74 e3                	je     801381 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	8a 00                	mov    (%eax),%al
  8013a3:	0f b6 d0             	movzbl %al,%edx
  8013a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a9:	8a 00                	mov    (%eax),%al
  8013ab:	0f b6 c0             	movzbl %al,%eax
  8013ae:	29 c2                	sub    %eax,%edx
  8013b0:	89 d0                	mov    %edx,%eax
}
  8013b2:	5d                   	pop    %ebp
  8013b3:	c3                   	ret    

008013b4 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013b4:	55                   	push   %ebp
  8013b5:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013b7:	eb 09                	jmp    8013c2 <strncmp+0xe>
		n--, p++, q++;
  8013b9:	ff 4d 10             	decl   0x10(%ebp)
  8013bc:	ff 45 08             	incl   0x8(%ebp)
  8013bf:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013c2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c6:	74 17                	je     8013df <strncmp+0x2b>
  8013c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cb:	8a 00                	mov    (%eax),%al
  8013cd:	84 c0                	test   %al,%al
  8013cf:	74 0e                	je     8013df <strncmp+0x2b>
  8013d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d4:	8a 10                	mov    (%eax),%dl
  8013d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d9:	8a 00                	mov    (%eax),%al
  8013db:	38 c2                	cmp    %al,%dl
  8013dd:	74 da                	je     8013b9 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e3:	75 07                	jne    8013ec <strncmp+0x38>
		return 0;
  8013e5:	b8 00 00 00 00       	mov    $0x0,%eax
  8013ea:	eb 14                	jmp    801400 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	8a 00                	mov    (%eax),%al
  8013f1:	0f b6 d0             	movzbl %al,%edx
  8013f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f7:	8a 00                	mov    (%eax),%al
  8013f9:	0f b6 c0             	movzbl %al,%eax
  8013fc:	29 c2                	sub    %eax,%edx
  8013fe:	89 d0                	mov    %edx,%eax
}
  801400:	5d                   	pop    %ebp
  801401:	c3                   	ret    

00801402 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801402:	55                   	push   %ebp
  801403:	89 e5                	mov    %esp,%ebp
  801405:	83 ec 04             	sub    $0x4,%esp
  801408:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80140e:	eb 12                	jmp    801422 <strchr+0x20>
		if (*s == c)
  801410:	8b 45 08             	mov    0x8(%ebp),%eax
  801413:	8a 00                	mov    (%eax),%al
  801415:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801418:	75 05                	jne    80141f <strchr+0x1d>
			return (char *) s;
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	eb 11                	jmp    801430 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80141f:	ff 45 08             	incl   0x8(%ebp)
  801422:	8b 45 08             	mov    0x8(%ebp),%eax
  801425:	8a 00                	mov    (%eax),%al
  801427:	84 c0                	test   %al,%al
  801429:	75 e5                	jne    801410 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80142b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801430:	c9                   	leave  
  801431:	c3                   	ret    

00801432 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801432:	55                   	push   %ebp
  801433:	89 e5                	mov    %esp,%ebp
  801435:	83 ec 04             	sub    $0x4,%esp
  801438:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80143e:	eb 0d                	jmp    80144d <strfind+0x1b>
		if (*s == c)
  801440:	8b 45 08             	mov    0x8(%ebp),%eax
  801443:	8a 00                	mov    (%eax),%al
  801445:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801448:	74 0e                	je     801458 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80144a:	ff 45 08             	incl   0x8(%ebp)
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	8a 00                	mov    (%eax),%al
  801452:	84 c0                	test   %al,%al
  801454:	75 ea                	jne    801440 <strfind+0xe>
  801456:	eb 01                	jmp    801459 <strfind+0x27>
		if (*s == c)
			break;
  801458:	90                   	nop
	return (char *) s;
  801459:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80145c:	c9                   	leave  
  80145d:	c3                   	ret    

0080145e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80145e:	55                   	push   %ebp
  80145f:	89 e5                	mov    %esp,%ebp
  801461:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801464:	8b 45 08             	mov    0x8(%ebp),%eax
  801467:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80146a:	8b 45 10             	mov    0x10(%ebp),%eax
  80146d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801470:	eb 0e                	jmp    801480 <memset+0x22>
		*p++ = c;
  801472:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801475:	8d 50 01             	lea    0x1(%eax),%edx
  801478:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80147b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80147e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801480:	ff 4d f8             	decl   -0x8(%ebp)
  801483:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801487:	79 e9                	jns    801472 <memset+0x14>
		*p++ = c;

	return v;
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80148c:	c9                   	leave  
  80148d:	c3                   	ret    

0080148e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
  801491:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801494:	8b 45 0c             	mov    0xc(%ebp),%eax
  801497:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8014a0:	eb 16                	jmp    8014b8 <memcpy+0x2a>
		*d++ = *s++;
  8014a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a5:	8d 50 01             	lea    0x1(%eax),%edx
  8014a8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014ab:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ae:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014b1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014b4:	8a 12                	mov    (%edx),%dl
  8014b6:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014bb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014be:	89 55 10             	mov    %edx,0x10(%ebp)
  8014c1:	85 c0                	test   %eax,%eax
  8014c3:	75 dd                	jne    8014a2 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014c5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014c8:	c9                   	leave  
  8014c9:	c3                   	ret    

008014ca <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014ca:	55                   	push   %ebp
  8014cb:	89 e5                	mov    %esp,%ebp
  8014cd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8014d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014df:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014e2:	73 50                	jae    801534 <memmove+0x6a>
  8014e4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ea:	01 d0                	add    %edx,%eax
  8014ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014ef:	76 43                	jbe    801534 <memmove+0x6a>
		s += n;
  8014f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014fa:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014fd:	eb 10                	jmp    80150f <memmove+0x45>
			*--d = *--s;
  8014ff:	ff 4d f8             	decl   -0x8(%ebp)
  801502:	ff 4d fc             	decl   -0x4(%ebp)
  801505:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801508:	8a 10                	mov    (%eax),%dl
  80150a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80150d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80150f:	8b 45 10             	mov    0x10(%ebp),%eax
  801512:	8d 50 ff             	lea    -0x1(%eax),%edx
  801515:	89 55 10             	mov    %edx,0x10(%ebp)
  801518:	85 c0                	test   %eax,%eax
  80151a:	75 e3                	jne    8014ff <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80151c:	eb 23                	jmp    801541 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80151e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801521:	8d 50 01             	lea    0x1(%eax),%edx
  801524:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801527:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80152a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80152d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801530:	8a 12                	mov    (%edx),%dl
  801532:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801534:	8b 45 10             	mov    0x10(%ebp),%eax
  801537:	8d 50 ff             	lea    -0x1(%eax),%edx
  80153a:	89 55 10             	mov    %edx,0x10(%ebp)
  80153d:	85 c0                	test   %eax,%eax
  80153f:	75 dd                	jne    80151e <memmove+0x54>
			*d++ = *s++;

	return dst;
  801541:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
  801549:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
  80154f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801552:	8b 45 0c             	mov    0xc(%ebp),%eax
  801555:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801558:	eb 2a                	jmp    801584 <memcmp+0x3e>
		if (*s1 != *s2)
  80155a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80155d:	8a 10                	mov    (%eax),%dl
  80155f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801562:	8a 00                	mov    (%eax),%al
  801564:	38 c2                	cmp    %al,%dl
  801566:	74 16                	je     80157e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801568:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80156b:	8a 00                	mov    (%eax),%al
  80156d:	0f b6 d0             	movzbl %al,%edx
  801570:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801573:	8a 00                	mov    (%eax),%al
  801575:	0f b6 c0             	movzbl %al,%eax
  801578:	29 c2                	sub    %eax,%edx
  80157a:	89 d0                	mov    %edx,%eax
  80157c:	eb 18                	jmp    801596 <memcmp+0x50>
		s1++, s2++;
  80157e:	ff 45 fc             	incl   -0x4(%ebp)
  801581:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801584:	8b 45 10             	mov    0x10(%ebp),%eax
  801587:	8d 50 ff             	lea    -0x1(%eax),%edx
  80158a:	89 55 10             	mov    %edx,0x10(%ebp)
  80158d:	85 c0                	test   %eax,%eax
  80158f:	75 c9                	jne    80155a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801591:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801596:	c9                   	leave  
  801597:	c3                   	ret    

00801598 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801598:	55                   	push   %ebp
  801599:	89 e5                	mov    %esp,%ebp
  80159b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80159e:	8b 55 08             	mov    0x8(%ebp),%edx
  8015a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a4:	01 d0                	add    %edx,%eax
  8015a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015a9:	eb 15                	jmp    8015c0 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ae:	8a 00                	mov    (%eax),%al
  8015b0:	0f b6 d0             	movzbl %al,%edx
  8015b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b6:	0f b6 c0             	movzbl %al,%eax
  8015b9:	39 c2                	cmp    %eax,%edx
  8015bb:	74 0d                	je     8015ca <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015bd:	ff 45 08             	incl   0x8(%ebp)
  8015c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015c6:	72 e3                	jb     8015ab <memfind+0x13>
  8015c8:	eb 01                	jmp    8015cb <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015ca:	90                   	nop
	return (void *) s;
  8015cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015ce:	c9                   	leave  
  8015cf:	c3                   	ret    

008015d0 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015d0:	55                   	push   %ebp
  8015d1:	89 e5                	mov    %esp,%ebp
  8015d3:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015dd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015e4:	eb 03                	jmp    8015e9 <strtol+0x19>
		s++;
  8015e6:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ec:	8a 00                	mov    (%eax),%al
  8015ee:	3c 20                	cmp    $0x20,%al
  8015f0:	74 f4                	je     8015e6 <strtol+0x16>
  8015f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f5:	8a 00                	mov    (%eax),%al
  8015f7:	3c 09                	cmp    $0x9,%al
  8015f9:	74 eb                	je     8015e6 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fe:	8a 00                	mov    (%eax),%al
  801600:	3c 2b                	cmp    $0x2b,%al
  801602:	75 05                	jne    801609 <strtol+0x39>
		s++;
  801604:	ff 45 08             	incl   0x8(%ebp)
  801607:	eb 13                	jmp    80161c <strtol+0x4c>
	else if (*s == '-')
  801609:	8b 45 08             	mov    0x8(%ebp),%eax
  80160c:	8a 00                	mov    (%eax),%al
  80160e:	3c 2d                	cmp    $0x2d,%al
  801610:	75 0a                	jne    80161c <strtol+0x4c>
		s++, neg = 1;
  801612:	ff 45 08             	incl   0x8(%ebp)
  801615:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80161c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801620:	74 06                	je     801628 <strtol+0x58>
  801622:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801626:	75 20                	jne    801648 <strtol+0x78>
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	8a 00                	mov    (%eax),%al
  80162d:	3c 30                	cmp    $0x30,%al
  80162f:	75 17                	jne    801648 <strtol+0x78>
  801631:	8b 45 08             	mov    0x8(%ebp),%eax
  801634:	40                   	inc    %eax
  801635:	8a 00                	mov    (%eax),%al
  801637:	3c 78                	cmp    $0x78,%al
  801639:	75 0d                	jne    801648 <strtol+0x78>
		s += 2, base = 16;
  80163b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80163f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801646:	eb 28                	jmp    801670 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801648:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80164c:	75 15                	jne    801663 <strtol+0x93>
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
  801651:	8a 00                	mov    (%eax),%al
  801653:	3c 30                	cmp    $0x30,%al
  801655:	75 0c                	jne    801663 <strtol+0x93>
		s++, base = 8;
  801657:	ff 45 08             	incl   0x8(%ebp)
  80165a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801661:	eb 0d                	jmp    801670 <strtol+0xa0>
	else if (base == 0)
  801663:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801667:	75 07                	jne    801670 <strtol+0xa0>
		base = 10;
  801669:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	8a 00                	mov    (%eax),%al
  801675:	3c 2f                	cmp    $0x2f,%al
  801677:	7e 19                	jle    801692 <strtol+0xc2>
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	8a 00                	mov    (%eax),%al
  80167e:	3c 39                	cmp    $0x39,%al
  801680:	7f 10                	jg     801692 <strtol+0xc2>
			dig = *s - '0';
  801682:	8b 45 08             	mov    0x8(%ebp),%eax
  801685:	8a 00                	mov    (%eax),%al
  801687:	0f be c0             	movsbl %al,%eax
  80168a:	83 e8 30             	sub    $0x30,%eax
  80168d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801690:	eb 42                	jmp    8016d4 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801692:	8b 45 08             	mov    0x8(%ebp),%eax
  801695:	8a 00                	mov    (%eax),%al
  801697:	3c 60                	cmp    $0x60,%al
  801699:	7e 19                	jle    8016b4 <strtol+0xe4>
  80169b:	8b 45 08             	mov    0x8(%ebp),%eax
  80169e:	8a 00                	mov    (%eax),%al
  8016a0:	3c 7a                	cmp    $0x7a,%al
  8016a2:	7f 10                	jg     8016b4 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a7:	8a 00                	mov    (%eax),%al
  8016a9:	0f be c0             	movsbl %al,%eax
  8016ac:	83 e8 57             	sub    $0x57,%eax
  8016af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016b2:	eb 20                	jmp    8016d4 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b7:	8a 00                	mov    (%eax),%al
  8016b9:	3c 40                	cmp    $0x40,%al
  8016bb:	7e 39                	jle    8016f6 <strtol+0x126>
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	8a 00                	mov    (%eax),%al
  8016c2:	3c 5a                	cmp    $0x5a,%al
  8016c4:	7f 30                	jg     8016f6 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c9:	8a 00                	mov    (%eax),%al
  8016cb:	0f be c0             	movsbl %al,%eax
  8016ce:	83 e8 37             	sub    $0x37,%eax
  8016d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016d7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016da:	7d 19                	jge    8016f5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016dc:	ff 45 08             	incl   0x8(%ebp)
  8016df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016e2:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016e6:	89 c2                	mov    %eax,%edx
  8016e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016eb:	01 d0                	add    %edx,%eax
  8016ed:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016f0:	e9 7b ff ff ff       	jmp    801670 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016f5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016f6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016fa:	74 08                	je     801704 <strtol+0x134>
		*endptr = (char *) s;
  8016fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ff:	8b 55 08             	mov    0x8(%ebp),%edx
  801702:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801704:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801708:	74 07                	je     801711 <strtol+0x141>
  80170a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80170d:	f7 d8                	neg    %eax
  80170f:	eb 03                	jmp    801714 <strtol+0x144>
  801711:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801714:	c9                   	leave  
  801715:	c3                   	ret    

00801716 <ltostr>:

void
ltostr(long value, char *str)
{
  801716:	55                   	push   %ebp
  801717:	89 e5                	mov    %esp,%ebp
  801719:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80171c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801723:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80172a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80172e:	79 13                	jns    801743 <ltostr+0x2d>
	{
		neg = 1;
  801730:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801737:	8b 45 0c             	mov    0xc(%ebp),%eax
  80173a:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80173d:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801740:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801743:	8b 45 08             	mov    0x8(%ebp),%eax
  801746:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80174b:	99                   	cltd   
  80174c:	f7 f9                	idiv   %ecx
  80174e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801751:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801754:	8d 50 01             	lea    0x1(%eax),%edx
  801757:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80175a:	89 c2                	mov    %eax,%edx
  80175c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175f:	01 d0                	add    %edx,%eax
  801761:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801764:	83 c2 30             	add    $0x30,%edx
  801767:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801769:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80176c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801771:	f7 e9                	imul   %ecx
  801773:	c1 fa 02             	sar    $0x2,%edx
  801776:	89 c8                	mov    %ecx,%eax
  801778:	c1 f8 1f             	sar    $0x1f,%eax
  80177b:	29 c2                	sub    %eax,%edx
  80177d:	89 d0                	mov    %edx,%eax
  80177f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801782:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801785:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80178a:	f7 e9                	imul   %ecx
  80178c:	c1 fa 02             	sar    $0x2,%edx
  80178f:	89 c8                	mov    %ecx,%eax
  801791:	c1 f8 1f             	sar    $0x1f,%eax
  801794:	29 c2                	sub    %eax,%edx
  801796:	89 d0                	mov    %edx,%eax
  801798:	c1 e0 02             	shl    $0x2,%eax
  80179b:	01 d0                	add    %edx,%eax
  80179d:	01 c0                	add    %eax,%eax
  80179f:	29 c1                	sub    %eax,%ecx
  8017a1:	89 ca                	mov    %ecx,%edx
  8017a3:	85 d2                	test   %edx,%edx
  8017a5:	75 9c                	jne    801743 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017b1:	48                   	dec    %eax
  8017b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017b5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017b9:	74 3d                	je     8017f8 <ltostr+0xe2>
		start = 1 ;
  8017bb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017c2:	eb 34                	jmp    8017f8 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ca:	01 d0                	add    %edx,%eax
  8017cc:	8a 00                	mov    (%eax),%al
  8017ce:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d7:	01 c2                	add    %eax,%edx
  8017d9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017df:	01 c8                	add    %ecx,%eax
  8017e1:	8a 00                	mov    (%eax),%al
  8017e3:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017e5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017eb:	01 c2                	add    %eax,%edx
  8017ed:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017f0:	88 02                	mov    %al,(%edx)
		start++ ;
  8017f2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017f5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017fb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017fe:	7c c4                	jl     8017c4 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801800:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801803:	8b 45 0c             	mov    0xc(%ebp),%eax
  801806:	01 d0                	add    %edx,%eax
  801808:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80180b:	90                   	nop
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
  801811:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801814:	ff 75 08             	pushl  0x8(%ebp)
  801817:	e8 54 fa ff ff       	call   801270 <strlen>
  80181c:	83 c4 04             	add    $0x4,%esp
  80181f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801822:	ff 75 0c             	pushl  0xc(%ebp)
  801825:	e8 46 fa ff ff       	call   801270 <strlen>
  80182a:	83 c4 04             	add    $0x4,%esp
  80182d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801830:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801837:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80183e:	eb 17                	jmp    801857 <strcconcat+0x49>
		final[s] = str1[s] ;
  801840:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801843:	8b 45 10             	mov    0x10(%ebp),%eax
  801846:	01 c2                	add    %eax,%edx
  801848:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80184b:	8b 45 08             	mov    0x8(%ebp),%eax
  80184e:	01 c8                	add    %ecx,%eax
  801850:	8a 00                	mov    (%eax),%al
  801852:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801854:	ff 45 fc             	incl   -0x4(%ebp)
  801857:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80185a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80185d:	7c e1                	jl     801840 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80185f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801866:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80186d:	eb 1f                	jmp    80188e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80186f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801872:	8d 50 01             	lea    0x1(%eax),%edx
  801875:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801878:	89 c2                	mov    %eax,%edx
  80187a:	8b 45 10             	mov    0x10(%ebp),%eax
  80187d:	01 c2                	add    %eax,%edx
  80187f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801882:	8b 45 0c             	mov    0xc(%ebp),%eax
  801885:	01 c8                	add    %ecx,%eax
  801887:	8a 00                	mov    (%eax),%al
  801889:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80188b:	ff 45 f8             	incl   -0x8(%ebp)
  80188e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801891:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801894:	7c d9                	jl     80186f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801896:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801899:	8b 45 10             	mov    0x10(%ebp),%eax
  80189c:	01 d0                	add    %edx,%eax
  80189e:	c6 00 00             	movb   $0x0,(%eax)
}
  8018a1:	90                   	nop
  8018a2:	c9                   	leave  
  8018a3:	c3                   	ret    

008018a4 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018a4:	55                   	push   %ebp
  8018a5:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8018aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b3:	8b 00                	mov    (%eax),%eax
  8018b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8018bf:	01 d0                	add    %edx,%eax
  8018c1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018c7:	eb 0c                	jmp    8018d5 <strsplit+0x31>
			*string++ = 0;
  8018c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cc:	8d 50 01             	lea    0x1(%eax),%edx
  8018cf:	89 55 08             	mov    %edx,0x8(%ebp)
  8018d2:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d8:	8a 00                	mov    (%eax),%al
  8018da:	84 c0                	test   %al,%al
  8018dc:	74 18                	je     8018f6 <strsplit+0x52>
  8018de:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e1:	8a 00                	mov    (%eax),%al
  8018e3:	0f be c0             	movsbl %al,%eax
  8018e6:	50                   	push   %eax
  8018e7:	ff 75 0c             	pushl  0xc(%ebp)
  8018ea:	e8 13 fb ff ff       	call   801402 <strchr>
  8018ef:	83 c4 08             	add    $0x8,%esp
  8018f2:	85 c0                	test   %eax,%eax
  8018f4:	75 d3                	jne    8018c9 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8018f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f9:	8a 00                	mov    (%eax),%al
  8018fb:	84 c0                	test   %al,%al
  8018fd:	74 5a                	je     801959 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8018ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801902:	8b 00                	mov    (%eax),%eax
  801904:	83 f8 0f             	cmp    $0xf,%eax
  801907:	75 07                	jne    801910 <strsplit+0x6c>
		{
			return 0;
  801909:	b8 00 00 00 00       	mov    $0x0,%eax
  80190e:	eb 66                	jmp    801976 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801910:	8b 45 14             	mov    0x14(%ebp),%eax
  801913:	8b 00                	mov    (%eax),%eax
  801915:	8d 48 01             	lea    0x1(%eax),%ecx
  801918:	8b 55 14             	mov    0x14(%ebp),%edx
  80191b:	89 0a                	mov    %ecx,(%edx)
  80191d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801924:	8b 45 10             	mov    0x10(%ebp),%eax
  801927:	01 c2                	add    %eax,%edx
  801929:	8b 45 08             	mov    0x8(%ebp),%eax
  80192c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80192e:	eb 03                	jmp    801933 <strsplit+0x8f>
			string++;
  801930:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801933:	8b 45 08             	mov    0x8(%ebp),%eax
  801936:	8a 00                	mov    (%eax),%al
  801938:	84 c0                	test   %al,%al
  80193a:	74 8b                	je     8018c7 <strsplit+0x23>
  80193c:	8b 45 08             	mov    0x8(%ebp),%eax
  80193f:	8a 00                	mov    (%eax),%al
  801941:	0f be c0             	movsbl %al,%eax
  801944:	50                   	push   %eax
  801945:	ff 75 0c             	pushl  0xc(%ebp)
  801948:	e8 b5 fa ff ff       	call   801402 <strchr>
  80194d:	83 c4 08             	add    $0x8,%esp
  801950:	85 c0                	test   %eax,%eax
  801952:	74 dc                	je     801930 <strsplit+0x8c>
			string++;
	}
  801954:	e9 6e ff ff ff       	jmp    8018c7 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801959:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80195a:	8b 45 14             	mov    0x14(%ebp),%eax
  80195d:	8b 00                	mov    (%eax),%eax
  80195f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801966:	8b 45 10             	mov    0x10(%ebp),%eax
  801969:	01 d0                	add    %edx,%eax
  80196b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801971:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801976:	c9                   	leave  
  801977:	c3                   	ret    

00801978 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801978:	55                   	push   %ebp
  801979:	89 e5                	mov    %esp,%ebp
  80197b:	83 ec 18             	sub    $0x18,%esp
  80197e:	8b 45 10             	mov    0x10(%ebp),%eax
  801981:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801984:	83 ec 04             	sub    $0x4,%esp
  801987:	68 c4 2b 80 00       	push   $0x802bc4
  80198c:	6a 17                	push   $0x17
  80198e:	68 e3 2b 80 00       	push   $0x802be3
  801993:	e8 9c ed ff ff       	call   800734 <_panic>

00801998 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801998:	55                   	push   %ebp
  801999:	89 e5                	mov    %esp,%ebp
  80199b:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  80199e:	83 ec 04             	sub    $0x4,%esp
  8019a1:	68 ef 2b 80 00       	push   $0x802bef
  8019a6:	6a 2f                	push   $0x2f
  8019a8:	68 e3 2b 80 00       	push   $0x802be3
  8019ad:	e8 82 ed ff ff       	call   800734 <_panic>

008019b2 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
  8019b5:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8019b8:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8019bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8019c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019c5:	01 d0                	add    %edx,%eax
  8019c7:	48                   	dec    %eax
  8019c8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8019cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019ce:	ba 00 00 00 00       	mov    $0x0,%edx
  8019d3:	f7 75 ec             	divl   -0x14(%ebp)
  8019d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019d9:	29 d0                	sub    %edx,%eax
  8019db:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8019de:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e1:	c1 e8 0c             	shr    $0xc,%eax
  8019e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8019e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8019ee:	e9 c8 00 00 00       	jmp    801abb <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8019f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019fa:	eb 27                	jmp    801a23 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8019fc:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a02:	01 c2                	add    %eax,%edx
  801a04:	89 d0                	mov    %edx,%eax
  801a06:	01 c0                	add    %eax,%eax
  801a08:	01 d0                	add    %edx,%eax
  801a0a:	c1 e0 02             	shl    $0x2,%eax
  801a0d:	05 48 30 80 00       	add    $0x803048,%eax
  801a12:	8b 00                	mov    (%eax),%eax
  801a14:	85 c0                	test   %eax,%eax
  801a16:	74 08                	je     801a20 <malloc+0x6e>
            	i += j;
  801a18:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a1b:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801a1e:	eb 0b                	jmp    801a2b <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801a20:	ff 45 f0             	incl   -0x10(%ebp)
  801a23:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a26:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a29:	72 d1                	jb     8019fc <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801a2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a2e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a31:	0f 85 81 00 00 00    	jne    801ab8 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801a37:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a3a:	05 00 00 08 00       	add    $0x80000,%eax
  801a3f:	c1 e0 0c             	shl    $0xc,%eax
  801a42:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801a45:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a4c:	eb 1f                	jmp    801a6d <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801a4e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a54:	01 c2                	add    %eax,%edx
  801a56:	89 d0                	mov    %edx,%eax
  801a58:	01 c0                	add    %eax,%eax
  801a5a:	01 d0                	add    %edx,%eax
  801a5c:	c1 e0 02             	shl    $0x2,%eax
  801a5f:	05 48 30 80 00       	add    $0x803048,%eax
  801a64:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801a6a:	ff 45 f0             	incl   -0x10(%ebp)
  801a6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a70:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a73:	72 d9                	jb     801a4e <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801a75:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a78:	89 d0                	mov    %edx,%eax
  801a7a:	01 c0                	add    %eax,%eax
  801a7c:	01 d0                	add    %edx,%eax
  801a7e:	c1 e0 02             	shl    $0x2,%eax
  801a81:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801a87:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a8a:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801a8c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a8f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801a92:	89 c8                	mov    %ecx,%eax
  801a94:	01 c0                	add    %eax,%eax
  801a96:	01 c8                	add    %ecx,%eax
  801a98:	c1 e0 02             	shl    $0x2,%eax
  801a9b:	05 44 30 80 00       	add    $0x803044,%eax
  801aa0:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801aa2:	83 ec 08             	sub    $0x8,%esp
  801aa5:	ff 75 08             	pushl  0x8(%ebp)
  801aa8:	ff 75 e0             	pushl  -0x20(%ebp)
  801aab:	e8 2b 03 00 00       	call   801ddb <sys_allocateMem>
  801ab0:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801ab3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ab6:	eb 19                	jmp    801ad1 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801ab8:	ff 45 f4             	incl   -0xc(%ebp)
  801abb:	a1 04 30 80 00       	mov    0x803004,%eax
  801ac0:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801ac3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801ac6:	0f 83 27 ff ff ff    	jae    8019f3 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801acc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ad1:	c9                   	leave  
  801ad2:	c3                   	ret    

00801ad3 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801ad3:	55                   	push   %ebp
  801ad4:	89 e5                	mov    %esp,%ebp
  801ad6:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801ad9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801add:	0f 84 e5 00 00 00    	je     801bc8 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801ae9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801aec:	05 00 00 00 80       	add    $0x80000000,%eax
  801af1:	c1 e8 0c             	shr    $0xc,%eax
  801af4:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801af7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801afa:	89 d0                	mov    %edx,%eax
  801afc:	01 c0                	add    %eax,%eax
  801afe:	01 d0                	add    %edx,%eax
  801b00:	c1 e0 02             	shl    $0x2,%eax
  801b03:	05 40 30 80 00       	add    $0x803040,%eax
  801b08:	8b 00                	mov    (%eax),%eax
  801b0a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b0d:	0f 85 b8 00 00 00    	jne    801bcb <free+0xf8>
  801b13:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b16:	89 d0                	mov    %edx,%eax
  801b18:	01 c0                	add    %eax,%eax
  801b1a:	01 d0                	add    %edx,%eax
  801b1c:	c1 e0 02             	shl    $0x2,%eax
  801b1f:	05 48 30 80 00       	add    $0x803048,%eax
  801b24:	8b 00                	mov    (%eax),%eax
  801b26:	85 c0                	test   %eax,%eax
  801b28:	0f 84 9d 00 00 00    	je     801bcb <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801b2e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b31:	89 d0                	mov    %edx,%eax
  801b33:	01 c0                	add    %eax,%eax
  801b35:	01 d0                	add    %edx,%eax
  801b37:	c1 e0 02             	shl    $0x2,%eax
  801b3a:	05 44 30 80 00       	add    $0x803044,%eax
  801b3f:	8b 00                	mov    (%eax),%eax
  801b41:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801b44:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b47:	c1 e0 0c             	shl    $0xc,%eax
  801b4a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801b4d:	83 ec 08             	sub    $0x8,%esp
  801b50:	ff 75 e4             	pushl  -0x1c(%ebp)
  801b53:	ff 75 f0             	pushl  -0x10(%ebp)
  801b56:	e8 64 02 00 00       	call   801dbf <sys_freeMem>
  801b5b:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801b5e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b65:	eb 57                	jmp    801bbe <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801b67:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b6d:	01 c2                	add    %eax,%edx
  801b6f:	89 d0                	mov    %edx,%eax
  801b71:	01 c0                	add    %eax,%eax
  801b73:	01 d0                	add    %edx,%eax
  801b75:	c1 e0 02             	shl    $0x2,%eax
  801b78:	05 48 30 80 00       	add    $0x803048,%eax
  801b7d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801b83:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b89:	01 c2                	add    %eax,%edx
  801b8b:	89 d0                	mov    %edx,%eax
  801b8d:	01 c0                	add    %eax,%eax
  801b8f:	01 d0                	add    %edx,%eax
  801b91:	c1 e0 02             	shl    $0x2,%eax
  801b94:	05 40 30 80 00       	add    $0x803040,%eax
  801b99:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801b9f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ba2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ba5:	01 c2                	add    %eax,%edx
  801ba7:	89 d0                	mov    %edx,%eax
  801ba9:	01 c0                	add    %eax,%eax
  801bab:	01 d0                	add    %edx,%eax
  801bad:	c1 e0 02             	shl    $0x2,%eax
  801bb0:	05 44 30 80 00       	add    $0x803044,%eax
  801bb5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801bbb:	ff 45 f4             	incl   -0xc(%ebp)
  801bbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bc1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801bc4:	7c a1                	jl     801b67 <free+0x94>
  801bc6:	eb 04                	jmp    801bcc <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801bc8:	90                   	nop
  801bc9:	eb 01                	jmp    801bcc <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801bcb:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801bcc:	c9                   	leave  
  801bcd:	c3                   	ret    

00801bce <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801bce:	55                   	push   %ebp
  801bcf:	89 e5                	mov    %esp,%ebp
  801bd1:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801bd4:	83 ec 04             	sub    $0x4,%esp
  801bd7:	68 0c 2c 80 00       	push   $0x802c0c
  801bdc:	68 ae 00 00 00       	push   $0xae
  801be1:	68 e3 2b 80 00       	push   $0x802be3
  801be6:	e8 49 eb ff ff       	call   800734 <_panic>

00801beb <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801beb:	55                   	push   %ebp
  801bec:	89 e5                	mov    %esp,%ebp
  801bee:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801bf1:	83 ec 04             	sub    $0x4,%esp
  801bf4:	68 2c 2c 80 00       	push   $0x802c2c
  801bf9:	68 ca 00 00 00       	push   $0xca
  801bfe:	68 e3 2b 80 00       	push   $0x802be3
  801c03:	e8 2c eb ff ff       	call   800734 <_panic>

00801c08 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c08:	55                   	push   %ebp
  801c09:	89 e5                	mov    %esp,%ebp
  801c0b:	57                   	push   %edi
  801c0c:	56                   	push   %esi
  801c0d:	53                   	push   %ebx
  801c0e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c11:	8b 45 08             	mov    0x8(%ebp),%eax
  801c14:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c17:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c1a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c1d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c20:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c23:	cd 30                	int    $0x30
  801c25:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c28:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c2b:	83 c4 10             	add    $0x10,%esp
  801c2e:	5b                   	pop    %ebx
  801c2f:	5e                   	pop    %esi
  801c30:	5f                   	pop    %edi
  801c31:	5d                   	pop    %ebp
  801c32:	c3                   	ret    

00801c33 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c33:	55                   	push   %ebp
  801c34:	89 e5                	mov    %esp,%ebp
  801c36:	83 ec 04             	sub    $0x4,%esp
  801c39:	8b 45 10             	mov    0x10(%ebp),%eax
  801c3c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c3f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c43:	8b 45 08             	mov    0x8(%ebp),%eax
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	52                   	push   %edx
  801c4b:	ff 75 0c             	pushl  0xc(%ebp)
  801c4e:	50                   	push   %eax
  801c4f:	6a 00                	push   $0x0
  801c51:	e8 b2 ff ff ff       	call   801c08 <syscall>
  801c56:	83 c4 18             	add    $0x18,%esp
}
  801c59:	90                   	nop
  801c5a:	c9                   	leave  
  801c5b:	c3                   	ret    

00801c5c <sys_cgetc>:

int
sys_cgetc(void)
{
  801c5c:	55                   	push   %ebp
  801c5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 01                	push   $0x1
  801c6b:	e8 98 ff ff ff       	call   801c08 <syscall>
  801c70:	83 c4 18             	add    $0x18,%esp
}
  801c73:	c9                   	leave  
  801c74:	c3                   	ret    

00801c75 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c75:	55                   	push   %ebp
  801c76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c78:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	50                   	push   %eax
  801c84:	6a 05                	push   $0x5
  801c86:	e8 7d ff ff ff       	call   801c08 <syscall>
  801c8b:	83 c4 18             	add    $0x18,%esp
}
  801c8e:	c9                   	leave  
  801c8f:	c3                   	ret    

00801c90 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c90:	55                   	push   %ebp
  801c91:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 02                	push   $0x2
  801c9f:	e8 64 ff ff ff       	call   801c08 <syscall>
  801ca4:	83 c4 18             	add    $0x18,%esp
}
  801ca7:	c9                   	leave  
  801ca8:	c3                   	ret    

00801ca9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ca9:	55                   	push   %ebp
  801caa:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 03                	push   $0x3
  801cb8:	e8 4b ff ff ff       	call   801c08 <syscall>
  801cbd:	83 c4 18             	add    $0x18,%esp
}
  801cc0:	c9                   	leave  
  801cc1:	c3                   	ret    

00801cc2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801cc2:	55                   	push   %ebp
  801cc3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 04                	push   $0x4
  801cd1:	e8 32 ff ff ff       	call   801c08 <syscall>
  801cd6:	83 c4 18             	add    $0x18,%esp
}
  801cd9:	c9                   	leave  
  801cda:	c3                   	ret    

00801cdb <sys_env_exit>:


void sys_env_exit(void)
{
  801cdb:	55                   	push   %ebp
  801cdc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 06                	push   $0x6
  801cea:	e8 19 ff ff ff       	call   801c08 <syscall>
  801cef:	83 c4 18             	add    $0x18,%esp
}
  801cf2:	90                   	nop
  801cf3:	c9                   	leave  
  801cf4:	c3                   	ret    

00801cf5 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801cf5:	55                   	push   %ebp
  801cf6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801cf8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	52                   	push   %edx
  801d05:	50                   	push   %eax
  801d06:	6a 07                	push   $0x7
  801d08:	e8 fb fe ff ff       	call   801c08 <syscall>
  801d0d:	83 c4 18             	add    $0x18,%esp
}
  801d10:	c9                   	leave  
  801d11:	c3                   	ret    

00801d12 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d12:	55                   	push   %ebp
  801d13:	89 e5                	mov    %esp,%ebp
  801d15:	56                   	push   %esi
  801d16:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d17:	8b 75 18             	mov    0x18(%ebp),%esi
  801d1a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d1d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d20:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d23:	8b 45 08             	mov    0x8(%ebp),%eax
  801d26:	56                   	push   %esi
  801d27:	53                   	push   %ebx
  801d28:	51                   	push   %ecx
  801d29:	52                   	push   %edx
  801d2a:	50                   	push   %eax
  801d2b:	6a 08                	push   $0x8
  801d2d:	e8 d6 fe ff ff       	call   801c08 <syscall>
  801d32:	83 c4 18             	add    $0x18,%esp
}
  801d35:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d38:	5b                   	pop    %ebx
  801d39:	5e                   	pop    %esi
  801d3a:	5d                   	pop    %ebp
  801d3b:	c3                   	ret    

00801d3c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d3c:	55                   	push   %ebp
  801d3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d3f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d42:	8b 45 08             	mov    0x8(%ebp),%eax
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 00                	push   $0x0
  801d4b:	52                   	push   %edx
  801d4c:	50                   	push   %eax
  801d4d:	6a 09                	push   $0x9
  801d4f:	e8 b4 fe ff ff       	call   801c08 <syscall>
  801d54:	83 c4 18             	add    $0x18,%esp
}
  801d57:	c9                   	leave  
  801d58:	c3                   	ret    

00801d59 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d59:	55                   	push   %ebp
  801d5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	ff 75 0c             	pushl  0xc(%ebp)
  801d65:	ff 75 08             	pushl  0x8(%ebp)
  801d68:	6a 0a                	push   $0xa
  801d6a:	e8 99 fe ff ff       	call   801c08 <syscall>
  801d6f:	83 c4 18             	add    $0x18,%esp
}
  801d72:	c9                   	leave  
  801d73:	c3                   	ret    

00801d74 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d74:	55                   	push   %ebp
  801d75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 0b                	push   $0xb
  801d83:	e8 80 fe ff ff       	call   801c08 <syscall>
  801d88:	83 c4 18             	add    $0x18,%esp
}
  801d8b:	c9                   	leave  
  801d8c:	c3                   	ret    

00801d8d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d8d:	55                   	push   %ebp
  801d8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 0c                	push   $0xc
  801d9c:	e8 67 fe ff ff       	call   801c08 <syscall>
  801da1:	83 c4 18             	add    $0x18,%esp
}
  801da4:	c9                   	leave  
  801da5:	c3                   	ret    

00801da6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801da6:	55                   	push   %ebp
  801da7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801da9:	6a 00                	push   $0x0
  801dab:	6a 00                	push   $0x0
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	6a 0d                	push   $0xd
  801db5:	e8 4e fe ff ff       	call   801c08 <syscall>
  801dba:	83 c4 18             	add    $0x18,%esp
}
  801dbd:	c9                   	leave  
  801dbe:	c3                   	ret    

00801dbf <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801dbf:	55                   	push   %ebp
  801dc0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	ff 75 0c             	pushl  0xc(%ebp)
  801dcb:	ff 75 08             	pushl  0x8(%ebp)
  801dce:	6a 11                	push   $0x11
  801dd0:	e8 33 fe ff ff       	call   801c08 <syscall>
  801dd5:	83 c4 18             	add    $0x18,%esp
	return;
  801dd8:	90                   	nop
}
  801dd9:	c9                   	leave  
  801dda:	c3                   	ret    

00801ddb <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801ddb:	55                   	push   %ebp
  801ddc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	ff 75 0c             	pushl  0xc(%ebp)
  801de7:	ff 75 08             	pushl  0x8(%ebp)
  801dea:	6a 12                	push   $0x12
  801dec:	e8 17 fe ff ff       	call   801c08 <syscall>
  801df1:	83 c4 18             	add    $0x18,%esp
	return ;
  801df4:	90                   	nop
}
  801df5:	c9                   	leave  
  801df6:	c3                   	ret    

00801df7 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801df7:	55                   	push   %ebp
  801df8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 0e                	push   $0xe
  801e06:	e8 fd fd ff ff       	call   801c08 <syscall>
  801e0b:	83 c4 18             	add    $0x18,%esp
}
  801e0e:	c9                   	leave  
  801e0f:	c3                   	ret    

00801e10 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e10:	55                   	push   %ebp
  801e11:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e13:	6a 00                	push   $0x0
  801e15:	6a 00                	push   $0x0
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	ff 75 08             	pushl  0x8(%ebp)
  801e1e:	6a 0f                	push   $0xf
  801e20:	e8 e3 fd ff ff       	call   801c08 <syscall>
  801e25:	83 c4 18             	add    $0x18,%esp
}
  801e28:	c9                   	leave  
  801e29:	c3                   	ret    

00801e2a <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e2a:	55                   	push   %ebp
  801e2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	6a 10                	push   $0x10
  801e39:	e8 ca fd ff ff       	call   801c08 <syscall>
  801e3e:	83 c4 18             	add    $0x18,%esp
}
  801e41:	90                   	nop
  801e42:	c9                   	leave  
  801e43:	c3                   	ret    

00801e44 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e44:	55                   	push   %ebp
  801e45:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 14                	push   $0x14
  801e53:	e8 b0 fd ff ff       	call   801c08 <syscall>
  801e58:	83 c4 18             	add    $0x18,%esp
}
  801e5b:	90                   	nop
  801e5c:	c9                   	leave  
  801e5d:	c3                   	ret    

00801e5e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e5e:	55                   	push   %ebp
  801e5f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 15                	push   $0x15
  801e6d:	e8 96 fd ff ff       	call   801c08 <syscall>
  801e72:	83 c4 18             	add    $0x18,%esp
}
  801e75:	90                   	nop
  801e76:	c9                   	leave  
  801e77:	c3                   	ret    

00801e78 <sys_cputc>:


void
sys_cputc(const char c)
{
  801e78:	55                   	push   %ebp
  801e79:	89 e5                	mov    %esp,%ebp
  801e7b:	83 ec 04             	sub    $0x4,%esp
  801e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e81:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e84:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	50                   	push   %eax
  801e91:	6a 16                	push   $0x16
  801e93:	e8 70 fd ff ff       	call   801c08 <syscall>
  801e98:	83 c4 18             	add    $0x18,%esp
}
  801e9b:	90                   	nop
  801e9c:	c9                   	leave  
  801e9d:	c3                   	ret    

00801e9e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e9e:	55                   	push   %ebp
  801e9f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 17                	push   $0x17
  801ead:	e8 56 fd ff ff       	call   801c08 <syscall>
  801eb2:	83 c4 18             	add    $0x18,%esp
}
  801eb5:	90                   	nop
  801eb6:	c9                   	leave  
  801eb7:	c3                   	ret    

00801eb8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801eb8:	55                   	push   %ebp
  801eb9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	ff 75 0c             	pushl  0xc(%ebp)
  801ec7:	50                   	push   %eax
  801ec8:	6a 18                	push   $0x18
  801eca:	e8 39 fd ff ff       	call   801c08 <syscall>
  801ecf:	83 c4 18             	add    $0x18,%esp
}
  801ed2:	c9                   	leave  
  801ed3:	c3                   	ret    

00801ed4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ed4:	55                   	push   %ebp
  801ed5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ed7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eda:	8b 45 08             	mov    0x8(%ebp),%eax
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	52                   	push   %edx
  801ee4:	50                   	push   %eax
  801ee5:	6a 1b                	push   $0x1b
  801ee7:	e8 1c fd ff ff       	call   801c08 <syscall>
  801eec:	83 c4 18             	add    $0x18,%esp
}
  801eef:	c9                   	leave  
  801ef0:	c3                   	ret    

00801ef1 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ef1:	55                   	push   %ebp
  801ef2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ef4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	52                   	push   %edx
  801f01:	50                   	push   %eax
  801f02:	6a 19                	push   $0x19
  801f04:	e8 ff fc ff ff       	call   801c08 <syscall>
  801f09:	83 c4 18             	add    $0x18,%esp
}
  801f0c:	90                   	nop
  801f0d:	c9                   	leave  
  801f0e:	c3                   	ret    

00801f0f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f0f:	55                   	push   %ebp
  801f10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f12:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f15:	8b 45 08             	mov    0x8(%ebp),%eax
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	52                   	push   %edx
  801f1f:	50                   	push   %eax
  801f20:	6a 1a                	push   $0x1a
  801f22:	e8 e1 fc ff ff       	call   801c08 <syscall>
  801f27:	83 c4 18             	add    $0x18,%esp
}
  801f2a:	90                   	nop
  801f2b:	c9                   	leave  
  801f2c:	c3                   	ret    

00801f2d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f2d:	55                   	push   %ebp
  801f2e:	89 e5                	mov    %esp,%ebp
  801f30:	83 ec 04             	sub    $0x4,%esp
  801f33:	8b 45 10             	mov    0x10(%ebp),%eax
  801f36:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f39:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f3c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f40:	8b 45 08             	mov    0x8(%ebp),%eax
  801f43:	6a 00                	push   $0x0
  801f45:	51                   	push   %ecx
  801f46:	52                   	push   %edx
  801f47:	ff 75 0c             	pushl  0xc(%ebp)
  801f4a:	50                   	push   %eax
  801f4b:	6a 1c                	push   $0x1c
  801f4d:	e8 b6 fc ff ff       	call   801c08 <syscall>
  801f52:	83 c4 18             	add    $0x18,%esp
}
  801f55:	c9                   	leave  
  801f56:	c3                   	ret    

00801f57 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f57:	55                   	push   %ebp
  801f58:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f5a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	52                   	push   %edx
  801f67:	50                   	push   %eax
  801f68:	6a 1d                	push   $0x1d
  801f6a:	e8 99 fc ff ff       	call   801c08 <syscall>
  801f6f:	83 c4 18             	add    $0x18,%esp
}
  801f72:	c9                   	leave  
  801f73:	c3                   	ret    

00801f74 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f74:	55                   	push   %ebp
  801f75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f77:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	51                   	push   %ecx
  801f85:	52                   	push   %edx
  801f86:	50                   	push   %eax
  801f87:	6a 1e                	push   $0x1e
  801f89:	e8 7a fc ff ff       	call   801c08 <syscall>
  801f8e:	83 c4 18             	add    $0x18,%esp
}
  801f91:	c9                   	leave  
  801f92:	c3                   	ret    

00801f93 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f93:	55                   	push   %ebp
  801f94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f96:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f99:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9c:	6a 00                	push   $0x0
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 00                	push   $0x0
  801fa2:	52                   	push   %edx
  801fa3:	50                   	push   %eax
  801fa4:	6a 1f                	push   $0x1f
  801fa6:	e8 5d fc ff ff       	call   801c08 <syscall>
  801fab:	83 c4 18             	add    $0x18,%esp
}
  801fae:	c9                   	leave  
  801faf:	c3                   	ret    

00801fb0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801fb0:	55                   	push   %ebp
  801fb1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 20                	push   $0x20
  801fbf:	e8 44 fc ff ff       	call   801c08 <syscall>
  801fc4:	83 c4 18             	add    $0x18,%esp
}
  801fc7:	c9                   	leave  
  801fc8:	c3                   	ret    

00801fc9 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801fc9:	55                   	push   %ebp
  801fca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	ff 75 10             	pushl  0x10(%ebp)
  801fd6:	ff 75 0c             	pushl  0xc(%ebp)
  801fd9:	50                   	push   %eax
  801fda:	6a 21                	push   $0x21
  801fdc:	e8 27 fc ff ff       	call   801c08 <syscall>
  801fe1:	83 c4 18             	add    $0x18,%esp
}
  801fe4:	c9                   	leave  
  801fe5:	c3                   	ret    

00801fe6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801fe6:	55                   	push   %ebp
  801fe7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801fe9:	8b 45 08             	mov    0x8(%ebp),%eax
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	50                   	push   %eax
  801ff5:	6a 22                	push   $0x22
  801ff7:	e8 0c fc ff ff       	call   801c08 <syscall>
  801ffc:	83 c4 18             	add    $0x18,%esp
}
  801fff:	90                   	nop
  802000:	c9                   	leave  
  802001:	c3                   	ret    

00802002 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802002:	55                   	push   %ebp
  802003:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802005:	8b 45 08             	mov    0x8(%ebp),%eax
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	50                   	push   %eax
  802011:	6a 23                	push   $0x23
  802013:	e8 f0 fb ff ff       	call   801c08 <syscall>
  802018:	83 c4 18             	add    $0x18,%esp
}
  80201b:	90                   	nop
  80201c:	c9                   	leave  
  80201d:	c3                   	ret    

0080201e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80201e:	55                   	push   %ebp
  80201f:	89 e5                	mov    %esp,%ebp
  802021:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802024:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802027:	8d 50 04             	lea    0x4(%eax),%edx
  80202a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	52                   	push   %edx
  802034:	50                   	push   %eax
  802035:	6a 24                	push   $0x24
  802037:	e8 cc fb ff ff       	call   801c08 <syscall>
  80203c:	83 c4 18             	add    $0x18,%esp
	return result;
  80203f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802042:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802045:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802048:	89 01                	mov    %eax,(%ecx)
  80204a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80204d:	8b 45 08             	mov    0x8(%ebp),%eax
  802050:	c9                   	leave  
  802051:	c2 04 00             	ret    $0x4

00802054 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802054:	55                   	push   %ebp
  802055:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802057:	6a 00                	push   $0x0
  802059:	6a 00                	push   $0x0
  80205b:	ff 75 10             	pushl  0x10(%ebp)
  80205e:	ff 75 0c             	pushl  0xc(%ebp)
  802061:	ff 75 08             	pushl  0x8(%ebp)
  802064:	6a 13                	push   $0x13
  802066:	e8 9d fb ff ff       	call   801c08 <syscall>
  80206b:	83 c4 18             	add    $0x18,%esp
	return ;
  80206e:	90                   	nop
}
  80206f:	c9                   	leave  
  802070:	c3                   	ret    

00802071 <sys_rcr2>:
uint32 sys_rcr2()
{
  802071:	55                   	push   %ebp
  802072:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802074:	6a 00                	push   $0x0
  802076:	6a 00                	push   $0x0
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	6a 00                	push   $0x0
  80207e:	6a 25                	push   $0x25
  802080:	e8 83 fb ff ff       	call   801c08 <syscall>
  802085:	83 c4 18             	add    $0x18,%esp
}
  802088:	c9                   	leave  
  802089:	c3                   	ret    

0080208a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80208a:	55                   	push   %ebp
  80208b:	89 e5                	mov    %esp,%ebp
  80208d:	83 ec 04             	sub    $0x4,%esp
  802090:	8b 45 08             	mov    0x8(%ebp),%eax
  802093:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802096:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	50                   	push   %eax
  8020a3:	6a 26                	push   $0x26
  8020a5:	e8 5e fb ff ff       	call   801c08 <syscall>
  8020aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ad:	90                   	nop
}
  8020ae:	c9                   	leave  
  8020af:	c3                   	ret    

008020b0 <rsttst>:
void rsttst()
{
  8020b0:	55                   	push   %ebp
  8020b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020b3:	6a 00                	push   $0x0
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 28                	push   $0x28
  8020bf:	e8 44 fb ff ff       	call   801c08 <syscall>
  8020c4:	83 c4 18             	add    $0x18,%esp
	return ;
  8020c7:	90                   	nop
}
  8020c8:	c9                   	leave  
  8020c9:	c3                   	ret    

008020ca <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020ca:	55                   	push   %ebp
  8020cb:	89 e5                	mov    %esp,%ebp
  8020cd:	83 ec 04             	sub    $0x4,%esp
  8020d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8020d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8020d6:	8b 55 18             	mov    0x18(%ebp),%edx
  8020d9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020dd:	52                   	push   %edx
  8020de:	50                   	push   %eax
  8020df:	ff 75 10             	pushl  0x10(%ebp)
  8020e2:	ff 75 0c             	pushl  0xc(%ebp)
  8020e5:	ff 75 08             	pushl  0x8(%ebp)
  8020e8:	6a 27                	push   $0x27
  8020ea:	e8 19 fb ff ff       	call   801c08 <syscall>
  8020ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8020f2:	90                   	nop
}
  8020f3:	c9                   	leave  
  8020f4:	c3                   	ret    

008020f5 <chktst>:
void chktst(uint32 n)
{
  8020f5:	55                   	push   %ebp
  8020f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8020f8:	6a 00                	push   $0x0
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	6a 00                	push   $0x0
  802100:	ff 75 08             	pushl  0x8(%ebp)
  802103:	6a 29                	push   $0x29
  802105:	e8 fe fa ff ff       	call   801c08 <syscall>
  80210a:	83 c4 18             	add    $0x18,%esp
	return ;
  80210d:	90                   	nop
}
  80210e:	c9                   	leave  
  80210f:	c3                   	ret    

00802110 <inctst>:

void inctst()
{
  802110:	55                   	push   %ebp
  802111:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	6a 00                	push   $0x0
  802119:	6a 00                	push   $0x0
  80211b:	6a 00                	push   $0x0
  80211d:	6a 2a                	push   $0x2a
  80211f:	e8 e4 fa ff ff       	call   801c08 <syscall>
  802124:	83 c4 18             	add    $0x18,%esp
	return ;
  802127:	90                   	nop
}
  802128:	c9                   	leave  
  802129:	c3                   	ret    

0080212a <gettst>:
uint32 gettst()
{
  80212a:	55                   	push   %ebp
  80212b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	6a 00                	push   $0x0
  802133:	6a 00                	push   $0x0
  802135:	6a 00                	push   $0x0
  802137:	6a 2b                	push   $0x2b
  802139:	e8 ca fa ff ff       	call   801c08 <syscall>
  80213e:	83 c4 18             	add    $0x18,%esp
}
  802141:	c9                   	leave  
  802142:	c3                   	ret    

00802143 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802143:	55                   	push   %ebp
  802144:	89 e5                	mov    %esp,%ebp
  802146:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802149:	6a 00                	push   $0x0
  80214b:	6a 00                	push   $0x0
  80214d:	6a 00                	push   $0x0
  80214f:	6a 00                	push   $0x0
  802151:	6a 00                	push   $0x0
  802153:	6a 2c                	push   $0x2c
  802155:	e8 ae fa ff ff       	call   801c08 <syscall>
  80215a:	83 c4 18             	add    $0x18,%esp
  80215d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802160:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802164:	75 07                	jne    80216d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802166:	b8 01 00 00 00       	mov    $0x1,%eax
  80216b:	eb 05                	jmp    802172 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80216d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802172:	c9                   	leave  
  802173:	c3                   	ret    

00802174 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802174:	55                   	push   %ebp
  802175:	89 e5                	mov    %esp,%ebp
  802177:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80217a:	6a 00                	push   $0x0
  80217c:	6a 00                	push   $0x0
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	6a 2c                	push   $0x2c
  802186:	e8 7d fa ff ff       	call   801c08 <syscall>
  80218b:	83 c4 18             	add    $0x18,%esp
  80218e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802191:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802195:	75 07                	jne    80219e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802197:	b8 01 00 00 00       	mov    $0x1,%eax
  80219c:	eb 05                	jmp    8021a3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80219e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021a3:	c9                   	leave  
  8021a4:	c3                   	ret    

008021a5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8021a5:	55                   	push   %ebp
  8021a6:	89 e5                	mov    %esp,%ebp
  8021a8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 00                	push   $0x0
  8021b1:	6a 00                	push   $0x0
  8021b3:	6a 00                	push   $0x0
  8021b5:	6a 2c                	push   $0x2c
  8021b7:	e8 4c fa ff ff       	call   801c08 <syscall>
  8021bc:	83 c4 18             	add    $0x18,%esp
  8021bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8021c2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8021c6:	75 07                	jne    8021cf <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8021c8:	b8 01 00 00 00       	mov    $0x1,%eax
  8021cd:	eb 05                	jmp    8021d4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8021cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021d4:	c9                   	leave  
  8021d5:	c3                   	ret    

008021d6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8021d6:	55                   	push   %ebp
  8021d7:	89 e5                	mov    %esp,%ebp
  8021d9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021dc:	6a 00                	push   $0x0
  8021de:	6a 00                	push   $0x0
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 00                	push   $0x0
  8021e4:	6a 00                	push   $0x0
  8021e6:	6a 2c                	push   $0x2c
  8021e8:	e8 1b fa ff ff       	call   801c08 <syscall>
  8021ed:	83 c4 18             	add    $0x18,%esp
  8021f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8021f3:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8021f7:	75 07                	jne    802200 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8021f9:	b8 01 00 00 00       	mov    $0x1,%eax
  8021fe:	eb 05                	jmp    802205 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802200:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802205:	c9                   	leave  
  802206:	c3                   	ret    

00802207 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802207:	55                   	push   %ebp
  802208:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80220a:	6a 00                	push   $0x0
  80220c:	6a 00                	push   $0x0
  80220e:	6a 00                	push   $0x0
  802210:	6a 00                	push   $0x0
  802212:	ff 75 08             	pushl  0x8(%ebp)
  802215:	6a 2d                	push   $0x2d
  802217:	e8 ec f9 ff ff       	call   801c08 <syscall>
  80221c:	83 c4 18             	add    $0x18,%esp
	return ;
  80221f:	90                   	nop
}
  802220:	c9                   	leave  
  802221:	c3                   	ret    
  802222:	66 90                	xchg   %ax,%ax

00802224 <__udivdi3>:
  802224:	55                   	push   %ebp
  802225:	57                   	push   %edi
  802226:	56                   	push   %esi
  802227:	53                   	push   %ebx
  802228:	83 ec 1c             	sub    $0x1c,%esp
  80222b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80222f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802233:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802237:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80223b:	89 ca                	mov    %ecx,%edx
  80223d:	89 f8                	mov    %edi,%eax
  80223f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802243:	85 f6                	test   %esi,%esi
  802245:	75 2d                	jne    802274 <__udivdi3+0x50>
  802247:	39 cf                	cmp    %ecx,%edi
  802249:	77 65                	ja     8022b0 <__udivdi3+0x8c>
  80224b:	89 fd                	mov    %edi,%ebp
  80224d:	85 ff                	test   %edi,%edi
  80224f:	75 0b                	jne    80225c <__udivdi3+0x38>
  802251:	b8 01 00 00 00       	mov    $0x1,%eax
  802256:	31 d2                	xor    %edx,%edx
  802258:	f7 f7                	div    %edi
  80225a:	89 c5                	mov    %eax,%ebp
  80225c:	31 d2                	xor    %edx,%edx
  80225e:	89 c8                	mov    %ecx,%eax
  802260:	f7 f5                	div    %ebp
  802262:	89 c1                	mov    %eax,%ecx
  802264:	89 d8                	mov    %ebx,%eax
  802266:	f7 f5                	div    %ebp
  802268:	89 cf                	mov    %ecx,%edi
  80226a:	89 fa                	mov    %edi,%edx
  80226c:	83 c4 1c             	add    $0x1c,%esp
  80226f:	5b                   	pop    %ebx
  802270:	5e                   	pop    %esi
  802271:	5f                   	pop    %edi
  802272:	5d                   	pop    %ebp
  802273:	c3                   	ret    
  802274:	39 ce                	cmp    %ecx,%esi
  802276:	77 28                	ja     8022a0 <__udivdi3+0x7c>
  802278:	0f bd fe             	bsr    %esi,%edi
  80227b:	83 f7 1f             	xor    $0x1f,%edi
  80227e:	75 40                	jne    8022c0 <__udivdi3+0x9c>
  802280:	39 ce                	cmp    %ecx,%esi
  802282:	72 0a                	jb     80228e <__udivdi3+0x6a>
  802284:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802288:	0f 87 9e 00 00 00    	ja     80232c <__udivdi3+0x108>
  80228e:	b8 01 00 00 00       	mov    $0x1,%eax
  802293:	89 fa                	mov    %edi,%edx
  802295:	83 c4 1c             	add    $0x1c,%esp
  802298:	5b                   	pop    %ebx
  802299:	5e                   	pop    %esi
  80229a:	5f                   	pop    %edi
  80229b:	5d                   	pop    %ebp
  80229c:	c3                   	ret    
  80229d:	8d 76 00             	lea    0x0(%esi),%esi
  8022a0:	31 ff                	xor    %edi,%edi
  8022a2:	31 c0                	xor    %eax,%eax
  8022a4:	89 fa                	mov    %edi,%edx
  8022a6:	83 c4 1c             	add    $0x1c,%esp
  8022a9:	5b                   	pop    %ebx
  8022aa:	5e                   	pop    %esi
  8022ab:	5f                   	pop    %edi
  8022ac:	5d                   	pop    %ebp
  8022ad:	c3                   	ret    
  8022ae:	66 90                	xchg   %ax,%ax
  8022b0:	89 d8                	mov    %ebx,%eax
  8022b2:	f7 f7                	div    %edi
  8022b4:	31 ff                	xor    %edi,%edi
  8022b6:	89 fa                	mov    %edi,%edx
  8022b8:	83 c4 1c             	add    $0x1c,%esp
  8022bb:	5b                   	pop    %ebx
  8022bc:	5e                   	pop    %esi
  8022bd:	5f                   	pop    %edi
  8022be:	5d                   	pop    %ebp
  8022bf:	c3                   	ret    
  8022c0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8022c5:	89 eb                	mov    %ebp,%ebx
  8022c7:	29 fb                	sub    %edi,%ebx
  8022c9:	89 f9                	mov    %edi,%ecx
  8022cb:	d3 e6                	shl    %cl,%esi
  8022cd:	89 c5                	mov    %eax,%ebp
  8022cf:	88 d9                	mov    %bl,%cl
  8022d1:	d3 ed                	shr    %cl,%ebp
  8022d3:	89 e9                	mov    %ebp,%ecx
  8022d5:	09 f1                	or     %esi,%ecx
  8022d7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8022db:	89 f9                	mov    %edi,%ecx
  8022dd:	d3 e0                	shl    %cl,%eax
  8022df:	89 c5                	mov    %eax,%ebp
  8022e1:	89 d6                	mov    %edx,%esi
  8022e3:	88 d9                	mov    %bl,%cl
  8022e5:	d3 ee                	shr    %cl,%esi
  8022e7:	89 f9                	mov    %edi,%ecx
  8022e9:	d3 e2                	shl    %cl,%edx
  8022eb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022ef:	88 d9                	mov    %bl,%cl
  8022f1:	d3 e8                	shr    %cl,%eax
  8022f3:	09 c2                	or     %eax,%edx
  8022f5:	89 d0                	mov    %edx,%eax
  8022f7:	89 f2                	mov    %esi,%edx
  8022f9:	f7 74 24 0c          	divl   0xc(%esp)
  8022fd:	89 d6                	mov    %edx,%esi
  8022ff:	89 c3                	mov    %eax,%ebx
  802301:	f7 e5                	mul    %ebp
  802303:	39 d6                	cmp    %edx,%esi
  802305:	72 19                	jb     802320 <__udivdi3+0xfc>
  802307:	74 0b                	je     802314 <__udivdi3+0xf0>
  802309:	89 d8                	mov    %ebx,%eax
  80230b:	31 ff                	xor    %edi,%edi
  80230d:	e9 58 ff ff ff       	jmp    80226a <__udivdi3+0x46>
  802312:	66 90                	xchg   %ax,%ax
  802314:	8b 54 24 08          	mov    0x8(%esp),%edx
  802318:	89 f9                	mov    %edi,%ecx
  80231a:	d3 e2                	shl    %cl,%edx
  80231c:	39 c2                	cmp    %eax,%edx
  80231e:	73 e9                	jae    802309 <__udivdi3+0xe5>
  802320:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802323:	31 ff                	xor    %edi,%edi
  802325:	e9 40 ff ff ff       	jmp    80226a <__udivdi3+0x46>
  80232a:	66 90                	xchg   %ax,%ax
  80232c:	31 c0                	xor    %eax,%eax
  80232e:	e9 37 ff ff ff       	jmp    80226a <__udivdi3+0x46>
  802333:	90                   	nop

00802334 <__umoddi3>:
  802334:	55                   	push   %ebp
  802335:	57                   	push   %edi
  802336:	56                   	push   %esi
  802337:	53                   	push   %ebx
  802338:	83 ec 1c             	sub    $0x1c,%esp
  80233b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80233f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802343:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802347:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80234b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80234f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802353:	89 f3                	mov    %esi,%ebx
  802355:	89 fa                	mov    %edi,%edx
  802357:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80235b:	89 34 24             	mov    %esi,(%esp)
  80235e:	85 c0                	test   %eax,%eax
  802360:	75 1a                	jne    80237c <__umoddi3+0x48>
  802362:	39 f7                	cmp    %esi,%edi
  802364:	0f 86 a2 00 00 00    	jbe    80240c <__umoddi3+0xd8>
  80236a:	89 c8                	mov    %ecx,%eax
  80236c:	89 f2                	mov    %esi,%edx
  80236e:	f7 f7                	div    %edi
  802370:	89 d0                	mov    %edx,%eax
  802372:	31 d2                	xor    %edx,%edx
  802374:	83 c4 1c             	add    $0x1c,%esp
  802377:	5b                   	pop    %ebx
  802378:	5e                   	pop    %esi
  802379:	5f                   	pop    %edi
  80237a:	5d                   	pop    %ebp
  80237b:	c3                   	ret    
  80237c:	39 f0                	cmp    %esi,%eax
  80237e:	0f 87 ac 00 00 00    	ja     802430 <__umoddi3+0xfc>
  802384:	0f bd e8             	bsr    %eax,%ebp
  802387:	83 f5 1f             	xor    $0x1f,%ebp
  80238a:	0f 84 ac 00 00 00    	je     80243c <__umoddi3+0x108>
  802390:	bf 20 00 00 00       	mov    $0x20,%edi
  802395:	29 ef                	sub    %ebp,%edi
  802397:	89 fe                	mov    %edi,%esi
  802399:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80239d:	89 e9                	mov    %ebp,%ecx
  80239f:	d3 e0                	shl    %cl,%eax
  8023a1:	89 d7                	mov    %edx,%edi
  8023a3:	89 f1                	mov    %esi,%ecx
  8023a5:	d3 ef                	shr    %cl,%edi
  8023a7:	09 c7                	or     %eax,%edi
  8023a9:	89 e9                	mov    %ebp,%ecx
  8023ab:	d3 e2                	shl    %cl,%edx
  8023ad:	89 14 24             	mov    %edx,(%esp)
  8023b0:	89 d8                	mov    %ebx,%eax
  8023b2:	d3 e0                	shl    %cl,%eax
  8023b4:	89 c2                	mov    %eax,%edx
  8023b6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023ba:	d3 e0                	shl    %cl,%eax
  8023bc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8023c0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023c4:	89 f1                	mov    %esi,%ecx
  8023c6:	d3 e8                	shr    %cl,%eax
  8023c8:	09 d0                	or     %edx,%eax
  8023ca:	d3 eb                	shr    %cl,%ebx
  8023cc:	89 da                	mov    %ebx,%edx
  8023ce:	f7 f7                	div    %edi
  8023d0:	89 d3                	mov    %edx,%ebx
  8023d2:	f7 24 24             	mull   (%esp)
  8023d5:	89 c6                	mov    %eax,%esi
  8023d7:	89 d1                	mov    %edx,%ecx
  8023d9:	39 d3                	cmp    %edx,%ebx
  8023db:	0f 82 87 00 00 00    	jb     802468 <__umoddi3+0x134>
  8023e1:	0f 84 91 00 00 00    	je     802478 <__umoddi3+0x144>
  8023e7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8023eb:	29 f2                	sub    %esi,%edx
  8023ed:	19 cb                	sbb    %ecx,%ebx
  8023ef:	89 d8                	mov    %ebx,%eax
  8023f1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8023f5:	d3 e0                	shl    %cl,%eax
  8023f7:	89 e9                	mov    %ebp,%ecx
  8023f9:	d3 ea                	shr    %cl,%edx
  8023fb:	09 d0                	or     %edx,%eax
  8023fd:	89 e9                	mov    %ebp,%ecx
  8023ff:	d3 eb                	shr    %cl,%ebx
  802401:	89 da                	mov    %ebx,%edx
  802403:	83 c4 1c             	add    $0x1c,%esp
  802406:	5b                   	pop    %ebx
  802407:	5e                   	pop    %esi
  802408:	5f                   	pop    %edi
  802409:	5d                   	pop    %ebp
  80240a:	c3                   	ret    
  80240b:	90                   	nop
  80240c:	89 fd                	mov    %edi,%ebp
  80240e:	85 ff                	test   %edi,%edi
  802410:	75 0b                	jne    80241d <__umoddi3+0xe9>
  802412:	b8 01 00 00 00       	mov    $0x1,%eax
  802417:	31 d2                	xor    %edx,%edx
  802419:	f7 f7                	div    %edi
  80241b:	89 c5                	mov    %eax,%ebp
  80241d:	89 f0                	mov    %esi,%eax
  80241f:	31 d2                	xor    %edx,%edx
  802421:	f7 f5                	div    %ebp
  802423:	89 c8                	mov    %ecx,%eax
  802425:	f7 f5                	div    %ebp
  802427:	89 d0                	mov    %edx,%eax
  802429:	e9 44 ff ff ff       	jmp    802372 <__umoddi3+0x3e>
  80242e:	66 90                	xchg   %ax,%ax
  802430:	89 c8                	mov    %ecx,%eax
  802432:	89 f2                	mov    %esi,%edx
  802434:	83 c4 1c             	add    $0x1c,%esp
  802437:	5b                   	pop    %ebx
  802438:	5e                   	pop    %esi
  802439:	5f                   	pop    %edi
  80243a:	5d                   	pop    %ebp
  80243b:	c3                   	ret    
  80243c:	3b 04 24             	cmp    (%esp),%eax
  80243f:	72 06                	jb     802447 <__umoddi3+0x113>
  802441:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802445:	77 0f                	ja     802456 <__umoddi3+0x122>
  802447:	89 f2                	mov    %esi,%edx
  802449:	29 f9                	sub    %edi,%ecx
  80244b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80244f:	89 14 24             	mov    %edx,(%esp)
  802452:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802456:	8b 44 24 04          	mov    0x4(%esp),%eax
  80245a:	8b 14 24             	mov    (%esp),%edx
  80245d:	83 c4 1c             	add    $0x1c,%esp
  802460:	5b                   	pop    %ebx
  802461:	5e                   	pop    %esi
  802462:	5f                   	pop    %edi
  802463:	5d                   	pop    %ebp
  802464:	c3                   	ret    
  802465:	8d 76 00             	lea    0x0(%esi),%esi
  802468:	2b 04 24             	sub    (%esp),%eax
  80246b:	19 fa                	sbb    %edi,%edx
  80246d:	89 d1                	mov    %edx,%ecx
  80246f:	89 c6                	mov    %eax,%esi
  802471:	e9 71 ff ff ff       	jmp    8023e7 <__umoddi3+0xb3>
  802476:	66 90                	xchg   %ax,%ax
  802478:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80247c:	72 ea                	jb     802468 <__umoddi3+0x134>
  80247e:	89 d9                	mov    %ebx,%ecx
  802480:	e9 62 ff ff ff       	jmp    8023e7 <__umoddi3+0xb3>
