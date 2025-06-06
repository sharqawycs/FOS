
obj/user/quicksort_heap:     file format elf32-i386


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
  800031:	e8 1f 06 00 00       	call   800655 <libmain>
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
  800041:	e8 21 1e 00 00       	call   801e67 <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 c0 24 80 00       	push   $0x8024c0
  80004e:	e8 b8 09 00 00       	call   800a0b <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 c2 24 80 00       	push   $0x8024c2
  80005e:	e8 a8 09 00 00       	call   800a0b <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   QUICK SORT   !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 db 24 80 00       	push   $0x8024db
  80006e:	e8 98 09 00 00       	call   800a0b <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 c2 24 80 00       	push   $0x8024c2
  80007e:	e8 88 09 00 00       	call   800a0b <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 c0 24 80 00       	push   $0x8024c0
  80008e:	e8 78 09 00 00       	call   800a0b <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 f4 24 80 00       	push   $0x8024f4
  8000a5:	e8 e3 0f 00 00       	call   80108d <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 33 15 00 00       	call   8015f3 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 00 19 00 00       	call   8019d5 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 14 25 80 00       	push   $0x802514
  8000e3:	e8 23 09 00 00       	call   800a0b <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 36 25 80 00       	push   $0x802536
  8000f3:	e8 13 09 00 00       	call   800a0b <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 44 25 80 00       	push   $0x802544
  800103:	e8 03 09 00 00       	call   800a0b <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 53 25 80 00       	push   $0x802553
  800113:	e8 f3 08 00 00       	call   800a0b <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 63 25 80 00       	push   $0x802563
  800123:	e8 e3 08 00 00       	call   800a0b <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 cd 04 00 00       	call   8005fd <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 75 04 00 00       	call   8005b5 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 68 04 00 00       	call   8005b5 <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>
		//2012: lock the interrupt
		sys_enable_interrupt();
  800162:	e8 1a 1d 00 00       	call   801e81 <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800167:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80016b:	83 f8 62             	cmp    $0x62,%eax
  80016e:	74 1d                	je     80018d <_main+0x155>
  800170:	83 f8 63             	cmp    $0x63,%eax
  800173:	74 2b                	je     8001a0 <_main+0x168>
  800175:	83 f8 61             	cmp    $0x61,%eax
  800178:	75 39                	jne    8001b3 <_main+0x17b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017a:	83 ec 08             	sub    $0x8,%esp
  80017d:	ff 75 f0             	pushl  -0x10(%ebp)
  800180:	ff 75 ec             	pushl  -0x14(%ebp)
  800183:	e8 f5 02 00 00       	call   80047d <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 13 03 00 00       	call   8004ae <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 35 03 00 00       	call   8004e3 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 22 03 00 00       	call   8004e3 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	e8 f0 00 00 00       	call   8002c2 <QuickSort>
  8001d2:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d5:	e8 8d 1c 00 00       	call   801e67 <sys_disable_interrupt>
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 6c 25 80 00       	push   $0x80256c
  8001e2:	e8 24 08 00 00       	call   800a0b <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
		//		PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ea:	e8 92 1c 00 00       	call   801e81 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001ef:	83 ec 08             	sub    $0x8,%esp
  8001f2:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f8:	e8 d6 01 00 00       	call   8003d3 <CheckSorted>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800203:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800207:	75 14                	jne    80021d <_main+0x1e5>
  800209:	83 ec 04             	sub    $0x4,%esp
  80020c:	68 a0 25 80 00       	push   $0x8025a0
  800211:	6a 48                	push   $0x48
  800213:	68 c2 25 80 00       	push   $0x8025c2
  800218:	e8 3a 05 00 00       	call   800757 <_panic>
		else
		{
			sys_disable_interrupt();
  80021d:	e8 45 1c 00 00       	call   801e67 <sys_disable_interrupt>
			cprintf("\n===============================================\n") ;
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	68 d8 25 80 00       	push   $0x8025d8
  80022a:	e8 dc 07 00 00       	call   800a0b <cprintf>
  80022f:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800232:	83 ec 0c             	sub    $0xc,%esp
  800235:	68 0c 26 80 00       	push   $0x80260c
  80023a:	e8 cc 07 00 00       	call   800a0b <cprintf>
  80023f:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	68 40 26 80 00       	push   $0x802640
  80024a:	e8 bc 07 00 00       	call   800a0b <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800252:	e8 2a 1c 00 00       	call   801e81 <sys_enable_interrupt>
		}

		sys_disable_interrupt();
  800257:	e8 0b 1c 00 00       	call   801e67 <sys_disable_interrupt>
			Chose = 0 ;
  80025c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800260:	eb 42                	jmp    8002a4 <_main+0x26c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800262:	83 ec 0c             	sub    $0xc,%esp
  800265:	68 72 26 80 00       	push   $0x802672
  80026a:	e8 9c 07 00 00       	call   800a0b <cprintf>
  80026f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800272:	e8 86 03 00 00       	call   8005fd <getchar>
  800277:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80027a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80027e:	83 ec 0c             	sub    $0xc,%esp
  800281:	50                   	push   %eax
  800282:	e8 2e 03 00 00       	call   8005b5 <cputchar>
  800287:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028a:	83 ec 0c             	sub    $0xc,%esp
  80028d:	6a 0a                	push   $0xa
  80028f:	e8 21 03 00 00       	call   8005b5 <cputchar>
  800294:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800297:	83 ec 0c             	sub    $0xc,%esp
  80029a:	6a 0a                	push   $0xa
  80029c:	e8 14 03 00 00       	call   8005b5 <cputchar>
  8002a1:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
		}

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a4:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002a8:	74 06                	je     8002b0 <_main+0x278>
  8002aa:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002ae:	75 b2                	jne    800262 <_main+0x22a>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002b0:	e8 cc 1b 00 00       	call   801e81 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002b5:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002b9:	0f 84 82 fd ff ff    	je     800041 <_main+0x9>

}
  8002bf:	90                   	nop
  8002c0:	c9                   	leave  
  8002c1:	c3                   	ret    

008002c2 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002c2:	55                   	push   %ebp
  8002c3:	89 e5                	mov    %esp,%ebp
  8002c5:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002cb:	48                   	dec    %eax
  8002cc:	50                   	push   %eax
  8002cd:	6a 00                	push   $0x0
  8002cf:	ff 75 0c             	pushl  0xc(%ebp)
  8002d2:	ff 75 08             	pushl  0x8(%ebp)
  8002d5:	e8 06 00 00 00       	call   8002e0 <QSort>
  8002da:	83 c4 10             	add    $0x10,%esp
}
  8002dd:	90                   	nop
  8002de:	c9                   	leave  
  8002df:	c3                   	ret    

008002e0 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002e0:	55                   	push   %ebp
  8002e1:	89 e5                	mov    %esp,%ebp
  8002e3:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e9:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002ec:	0f 8d de 00 00 00    	jge    8003d0 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002f5:	40                   	inc    %eax
  8002f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8002fc:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002ff:	e9 80 00 00 00       	jmp    800384 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800304:	ff 45 f4             	incl   -0xc(%ebp)
  800307:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80030a:	3b 45 14             	cmp    0x14(%ebp),%eax
  80030d:	7f 2b                	jg     80033a <QSort+0x5a>
  80030f:	8b 45 10             	mov    0x10(%ebp),%eax
  800312:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800319:	8b 45 08             	mov    0x8(%ebp),%eax
  80031c:	01 d0                	add    %edx,%eax
  80031e:	8b 10                	mov    (%eax),%edx
  800320:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800323:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80032a:	8b 45 08             	mov    0x8(%ebp),%eax
  80032d:	01 c8                	add    %ecx,%eax
  80032f:	8b 00                	mov    (%eax),%eax
  800331:	39 c2                	cmp    %eax,%edx
  800333:	7d cf                	jge    800304 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800335:	eb 03                	jmp    80033a <QSort+0x5a>
  800337:	ff 4d f0             	decl   -0x10(%ebp)
  80033a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800340:	7e 26                	jle    800368 <QSort+0x88>
  800342:	8b 45 10             	mov    0x10(%ebp),%eax
  800345:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	01 d0                	add    %edx,%eax
  800351:	8b 10                	mov    (%eax),%edx
  800353:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800356:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035d:	8b 45 08             	mov    0x8(%ebp),%eax
  800360:	01 c8                	add    %ecx,%eax
  800362:	8b 00                	mov    (%eax),%eax
  800364:	39 c2                	cmp    %eax,%edx
  800366:	7e cf                	jle    800337 <QSort+0x57>

		if (i <= j)
  800368:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80036b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80036e:	7f 14                	jg     800384 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800370:	83 ec 04             	sub    $0x4,%esp
  800373:	ff 75 f0             	pushl  -0x10(%ebp)
  800376:	ff 75 f4             	pushl  -0xc(%ebp)
  800379:	ff 75 08             	pushl  0x8(%ebp)
  80037c:	e8 a9 00 00 00       	call   80042a <Swap>
  800381:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800384:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800387:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80038a:	0f 8e 77 ff ff ff    	jle    800307 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800390:	83 ec 04             	sub    $0x4,%esp
  800393:	ff 75 f0             	pushl  -0x10(%ebp)
  800396:	ff 75 10             	pushl  0x10(%ebp)
  800399:	ff 75 08             	pushl  0x8(%ebp)
  80039c:	e8 89 00 00 00       	call   80042a <Swap>
  8003a1:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a7:	48                   	dec    %eax
  8003a8:	50                   	push   %eax
  8003a9:	ff 75 10             	pushl  0x10(%ebp)
  8003ac:	ff 75 0c             	pushl  0xc(%ebp)
  8003af:	ff 75 08             	pushl  0x8(%ebp)
  8003b2:	e8 29 ff ff ff       	call   8002e0 <QSort>
  8003b7:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003ba:	ff 75 14             	pushl  0x14(%ebp)
  8003bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8003c0:	ff 75 0c             	pushl  0xc(%ebp)
  8003c3:	ff 75 08             	pushl  0x8(%ebp)
  8003c6:	e8 15 ff ff ff       	call   8002e0 <QSort>
  8003cb:	83 c4 10             	add    $0x10,%esp
  8003ce:	eb 01                	jmp    8003d1 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003d0:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003d1:	c9                   	leave  
  8003d2:	c3                   	ret    

008003d3 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003d3:	55                   	push   %ebp
  8003d4:	89 e5                	mov    %esp,%ebp
  8003d6:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003d9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003e7:	eb 33                	jmp    80041c <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f6:	01 d0                	add    %edx,%eax
  8003f8:	8b 10                	mov    (%eax),%edx
  8003fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003fd:	40                   	inc    %eax
  8003fe:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	01 c8                	add    %ecx,%eax
  80040a:	8b 00                	mov    (%eax),%eax
  80040c:	39 c2                	cmp    %eax,%edx
  80040e:	7e 09                	jle    800419 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800410:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800417:	eb 0c                	jmp    800425 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800419:	ff 45 f8             	incl   -0x8(%ebp)
  80041c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80041f:	48                   	dec    %eax
  800420:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800423:	7f c4                	jg     8003e9 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800425:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800428:	c9                   	leave  
  800429:	c3                   	ret    

0080042a <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80042a:	55                   	push   %ebp
  80042b:	89 e5                	mov    %esp,%ebp
  80042d:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800430:	8b 45 0c             	mov    0xc(%ebp),%eax
  800433:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	01 d0                	add    %edx,%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800444:	8b 45 0c             	mov    0xc(%ebp),%eax
  800447:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80044e:	8b 45 08             	mov    0x8(%ebp),%eax
  800451:	01 c2                	add    %eax,%edx
  800453:	8b 45 10             	mov    0x10(%ebp),%eax
  800456:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 c8                	add    %ecx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800466:	8b 45 10             	mov    0x10(%ebp),%eax
  800469:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800470:	8b 45 08             	mov    0x8(%ebp),%eax
  800473:	01 c2                	add    %eax,%edx
  800475:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800478:	89 02                	mov    %eax,(%edx)
}
  80047a:	90                   	nop
  80047b:	c9                   	leave  
  80047c:	c3                   	ret    

0080047d <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80047d:	55                   	push   %ebp
  80047e:	89 e5                	mov    %esp,%ebp
  800480:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800483:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80048a:	eb 17                	jmp    8004a3 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80048c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800496:	8b 45 08             	mov    0x8(%ebp),%eax
  800499:	01 c2                	add    %eax,%edx
  80049b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049e:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a0:	ff 45 fc             	incl   -0x4(%ebp)
  8004a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004a9:	7c e1                	jl     80048c <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8004ab:	90                   	nop
  8004ac:	c9                   	leave  
  8004ad:	c3                   	ret    

008004ae <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8004ae:	55                   	push   %ebp
  8004af:	89 e5                	mov    %esp,%ebp
  8004b1:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004bb:	eb 1b                	jmp    8004d8 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ca:	01 c2                	add    %eax,%edx
  8004cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004cf:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004d2:	48                   	dec    %eax
  8004d3:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004d5:	ff 45 fc             	incl   -0x4(%ebp)
  8004d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004db:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004de:	7c dd                	jl     8004bd <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004e0:	90                   	nop
  8004e1:	c9                   	leave  
  8004e2:	c3                   	ret    

008004e3 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004e3:	55                   	push   %ebp
  8004e4:	89 e5                	mov    %esp,%ebp
  8004e6:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004ec:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004f1:	f7 e9                	imul   %ecx
  8004f3:	c1 f9 1f             	sar    $0x1f,%ecx
  8004f6:	89 d0                	mov    %edx,%eax
  8004f8:	29 c8                	sub    %ecx,%eax
  8004fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800504:	eb 1e                	jmp    800524 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800506:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800509:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800510:	8b 45 08             	mov    0x8(%ebp),%eax
  800513:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800516:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800519:	99                   	cltd   
  80051a:	f7 7d f8             	idivl  -0x8(%ebp)
  80051d:	89 d0                	mov    %edx,%eax
  80051f:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800521:	ff 45 fc             	incl   -0x4(%ebp)
  800524:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800527:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80052a:	7c da                	jl     800506 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80052c:	90                   	nop
  80052d:	c9                   	leave  
  80052e:	c3                   	ret    

0080052f <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80052f:	55                   	push   %ebp
  800530:	89 e5                	mov    %esp,%ebp
  800532:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800535:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80053c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800543:	eb 42                	jmp    800587 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800545:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800548:	99                   	cltd   
  800549:	f7 7d f0             	idivl  -0x10(%ebp)
  80054c:	89 d0                	mov    %edx,%eax
  80054e:	85 c0                	test   %eax,%eax
  800550:	75 10                	jne    800562 <PrintElements+0x33>
			cprintf("\n");
  800552:	83 ec 0c             	sub    $0xc,%esp
  800555:	68 c0 24 80 00       	push   $0x8024c0
  80055a:	e8 ac 04 00 00       	call   800a0b <cprintf>
  80055f:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800562:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800565:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056c:	8b 45 08             	mov    0x8(%ebp),%eax
  80056f:	01 d0                	add    %edx,%eax
  800571:	8b 00                	mov    (%eax),%eax
  800573:	83 ec 08             	sub    $0x8,%esp
  800576:	50                   	push   %eax
  800577:	68 90 26 80 00       	push   $0x802690
  80057c:	e8 8a 04 00 00       	call   800a0b <cprintf>
  800581:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800584:	ff 45 f4             	incl   -0xc(%ebp)
  800587:	8b 45 0c             	mov    0xc(%ebp),%eax
  80058a:	48                   	dec    %eax
  80058b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80058e:	7f b5                	jg     800545 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800590:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800593:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80059a:	8b 45 08             	mov    0x8(%ebp),%eax
  80059d:	01 d0                	add    %edx,%eax
  80059f:	8b 00                	mov    (%eax),%eax
  8005a1:	83 ec 08             	sub    $0x8,%esp
  8005a4:	50                   	push   %eax
  8005a5:	68 95 26 80 00       	push   $0x802695
  8005aa:	e8 5c 04 00 00       	call   800a0b <cprintf>
  8005af:	83 c4 10             	add    $0x10,%esp

}
  8005b2:	90                   	nop
  8005b3:	c9                   	leave  
  8005b4:	c3                   	ret    

008005b5 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005b5:	55                   	push   %ebp
  8005b6:	89 e5                	mov    %esp,%ebp
  8005b8:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005be:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005c1:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005c5:	83 ec 0c             	sub    $0xc,%esp
  8005c8:	50                   	push   %eax
  8005c9:	e8 cd 18 00 00       	call   801e9b <sys_cputc>
  8005ce:	83 c4 10             	add    $0x10,%esp
}
  8005d1:	90                   	nop
  8005d2:	c9                   	leave  
  8005d3:	c3                   	ret    

008005d4 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8005d4:	55                   	push   %ebp
  8005d5:	89 e5                	mov    %esp,%ebp
  8005d7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005da:	e8 88 18 00 00       	call   801e67 <sys_disable_interrupt>
	char c = ch;
  8005df:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e2:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005e5:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005e9:	83 ec 0c             	sub    $0xc,%esp
  8005ec:	50                   	push   %eax
  8005ed:	e8 a9 18 00 00       	call   801e9b <sys_cputc>
  8005f2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005f5:	e8 87 18 00 00       	call   801e81 <sys_enable_interrupt>
}
  8005fa:	90                   	nop
  8005fb:	c9                   	leave  
  8005fc:	c3                   	ret    

008005fd <getchar>:

int
getchar(void)
{
  8005fd:	55                   	push   %ebp
  8005fe:	89 e5                	mov    %esp,%ebp
  800600:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800603:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80060a:	eb 08                	jmp    800614 <getchar+0x17>
	{
		c = sys_cgetc();
  80060c:	e8 6e 16 00 00       	call   801c7f <sys_cgetc>
  800611:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800614:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800618:	74 f2                	je     80060c <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80061a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80061d:	c9                   	leave  
  80061e:	c3                   	ret    

0080061f <atomic_getchar>:

int
atomic_getchar(void)
{
  80061f:	55                   	push   %ebp
  800620:	89 e5                	mov    %esp,%ebp
  800622:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800625:	e8 3d 18 00 00       	call   801e67 <sys_disable_interrupt>
	int c=0;
  80062a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800631:	eb 08                	jmp    80063b <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800633:	e8 47 16 00 00       	call   801c7f <sys_cgetc>
  800638:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80063b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80063f:	74 f2                	je     800633 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800641:	e8 3b 18 00 00       	call   801e81 <sys_enable_interrupt>
	return c;
  800646:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800649:	c9                   	leave  
  80064a:	c3                   	ret    

0080064b <iscons>:

int iscons(int fdnum)
{
  80064b:	55                   	push   %ebp
  80064c:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80064e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800653:	5d                   	pop    %ebp
  800654:	c3                   	ret    

00800655 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800655:	55                   	push   %ebp
  800656:	89 e5                	mov    %esp,%ebp
  800658:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80065b:	e8 6c 16 00 00       	call   801ccc <sys_getenvindex>
  800660:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800663:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800666:	89 d0                	mov    %edx,%eax
  800668:	01 c0                	add    %eax,%eax
  80066a:	01 d0                	add    %edx,%eax
  80066c:	c1 e0 02             	shl    $0x2,%eax
  80066f:	01 d0                	add    %edx,%eax
  800671:	c1 e0 06             	shl    $0x6,%eax
  800674:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800679:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80067e:	a1 24 30 80 00       	mov    0x803024,%eax
  800683:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800689:	84 c0                	test   %al,%al
  80068b:	74 0f                	je     80069c <libmain+0x47>
		binaryname = myEnv->prog_name;
  80068d:	a1 24 30 80 00       	mov    0x803024,%eax
  800692:	05 f4 02 00 00       	add    $0x2f4,%eax
  800697:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80069c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006a0:	7e 0a                	jle    8006ac <libmain+0x57>
		binaryname = argv[0];
  8006a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a5:	8b 00                	mov    (%eax),%eax
  8006a7:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006ac:	83 ec 08             	sub    $0x8,%esp
  8006af:	ff 75 0c             	pushl  0xc(%ebp)
  8006b2:	ff 75 08             	pushl  0x8(%ebp)
  8006b5:	e8 7e f9 ff ff       	call   800038 <_main>
  8006ba:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006bd:	e8 a5 17 00 00       	call   801e67 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006c2:	83 ec 0c             	sub    $0xc,%esp
  8006c5:	68 b4 26 80 00       	push   $0x8026b4
  8006ca:	e8 3c 03 00 00       	call   800a0b <cprintf>
  8006cf:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006d2:	a1 24 30 80 00       	mov    0x803024,%eax
  8006d7:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8006dd:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e2:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8006e8:	83 ec 04             	sub    $0x4,%esp
  8006eb:	52                   	push   %edx
  8006ec:	50                   	push   %eax
  8006ed:	68 dc 26 80 00       	push   $0x8026dc
  8006f2:	e8 14 03 00 00       	call   800a0b <cprintf>
  8006f7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006fa:	a1 24 30 80 00       	mov    0x803024,%eax
  8006ff:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800705:	83 ec 08             	sub    $0x8,%esp
  800708:	50                   	push   %eax
  800709:	68 01 27 80 00       	push   $0x802701
  80070e:	e8 f8 02 00 00       	call   800a0b <cprintf>
  800713:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800716:	83 ec 0c             	sub    $0xc,%esp
  800719:	68 b4 26 80 00       	push   $0x8026b4
  80071e:	e8 e8 02 00 00       	call   800a0b <cprintf>
  800723:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800726:	e8 56 17 00 00       	call   801e81 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80072b:	e8 19 00 00 00       	call   800749 <exit>
}
  800730:	90                   	nop
  800731:	c9                   	leave  
  800732:	c3                   	ret    

00800733 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800733:	55                   	push   %ebp
  800734:	89 e5                	mov    %esp,%ebp
  800736:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800739:	83 ec 0c             	sub    $0xc,%esp
  80073c:	6a 00                	push   $0x0
  80073e:	e8 55 15 00 00       	call   801c98 <sys_env_destroy>
  800743:	83 c4 10             	add    $0x10,%esp
}
  800746:	90                   	nop
  800747:	c9                   	leave  
  800748:	c3                   	ret    

00800749 <exit>:

void
exit(void)
{
  800749:	55                   	push   %ebp
  80074a:	89 e5                	mov    %esp,%ebp
  80074c:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80074f:	e8 aa 15 00 00       	call   801cfe <sys_env_exit>
}
  800754:	90                   	nop
  800755:	c9                   	leave  
  800756:	c3                   	ret    

00800757 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800757:	55                   	push   %ebp
  800758:	89 e5                	mov    %esp,%ebp
  80075a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80075d:	8d 45 10             	lea    0x10(%ebp),%eax
  800760:	83 c0 04             	add    $0x4,%eax
  800763:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800766:	a1 34 30 80 00       	mov    0x803034,%eax
  80076b:	85 c0                	test   %eax,%eax
  80076d:	74 16                	je     800785 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80076f:	a1 34 30 80 00       	mov    0x803034,%eax
  800774:	83 ec 08             	sub    $0x8,%esp
  800777:	50                   	push   %eax
  800778:	68 18 27 80 00       	push   $0x802718
  80077d:	e8 89 02 00 00       	call   800a0b <cprintf>
  800782:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800785:	a1 00 30 80 00       	mov    0x803000,%eax
  80078a:	ff 75 0c             	pushl  0xc(%ebp)
  80078d:	ff 75 08             	pushl  0x8(%ebp)
  800790:	50                   	push   %eax
  800791:	68 1d 27 80 00       	push   $0x80271d
  800796:	e8 70 02 00 00       	call   800a0b <cprintf>
  80079b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80079e:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a1:	83 ec 08             	sub    $0x8,%esp
  8007a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8007a7:	50                   	push   %eax
  8007a8:	e8 f3 01 00 00       	call   8009a0 <vcprintf>
  8007ad:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007b0:	83 ec 08             	sub    $0x8,%esp
  8007b3:	6a 00                	push   $0x0
  8007b5:	68 39 27 80 00       	push   $0x802739
  8007ba:	e8 e1 01 00 00       	call   8009a0 <vcprintf>
  8007bf:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007c2:	e8 82 ff ff ff       	call   800749 <exit>

	// should not return here
	while (1) ;
  8007c7:	eb fe                	jmp    8007c7 <_panic+0x70>

008007c9 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007c9:	55                   	push   %ebp
  8007ca:	89 e5                	mov    %esp,%ebp
  8007cc:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007cf:	a1 24 30 80 00       	mov    0x803024,%eax
  8007d4:	8b 50 74             	mov    0x74(%eax),%edx
  8007d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007da:	39 c2                	cmp    %eax,%edx
  8007dc:	74 14                	je     8007f2 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007de:	83 ec 04             	sub    $0x4,%esp
  8007e1:	68 3c 27 80 00       	push   $0x80273c
  8007e6:	6a 26                	push   $0x26
  8007e8:	68 88 27 80 00       	push   $0x802788
  8007ed:	e8 65 ff ff ff       	call   800757 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007f9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800800:	e9 c2 00 00 00       	jmp    8008c7 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800805:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800808:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80080f:	8b 45 08             	mov    0x8(%ebp),%eax
  800812:	01 d0                	add    %edx,%eax
  800814:	8b 00                	mov    (%eax),%eax
  800816:	85 c0                	test   %eax,%eax
  800818:	75 08                	jne    800822 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80081a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80081d:	e9 a2 00 00 00       	jmp    8008c4 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800822:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800829:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800830:	eb 69                	jmp    80089b <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800832:	a1 24 30 80 00       	mov    0x803024,%eax
  800837:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80083d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800840:	89 d0                	mov    %edx,%eax
  800842:	01 c0                	add    %eax,%eax
  800844:	01 d0                	add    %edx,%eax
  800846:	c1 e0 02             	shl    $0x2,%eax
  800849:	01 c8                	add    %ecx,%eax
  80084b:	8a 40 04             	mov    0x4(%eax),%al
  80084e:	84 c0                	test   %al,%al
  800850:	75 46                	jne    800898 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800852:	a1 24 30 80 00       	mov    0x803024,%eax
  800857:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80085d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800860:	89 d0                	mov    %edx,%eax
  800862:	01 c0                	add    %eax,%eax
  800864:	01 d0                	add    %edx,%eax
  800866:	c1 e0 02             	shl    $0x2,%eax
  800869:	01 c8                	add    %ecx,%eax
  80086b:	8b 00                	mov    (%eax),%eax
  80086d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800870:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800873:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800878:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80087a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80087d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800884:	8b 45 08             	mov    0x8(%ebp),%eax
  800887:	01 c8                	add    %ecx,%eax
  800889:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80088b:	39 c2                	cmp    %eax,%edx
  80088d:	75 09                	jne    800898 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80088f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800896:	eb 12                	jmp    8008aa <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800898:	ff 45 e8             	incl   -0x18(%ebp)
  80089b:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a0:	8b 50 74             	mov    0x74(%eax),%edx
  8008a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008a6:	39 c2                	cmp    %eax,%edx
  8008a8:	77 88                	ja     800832 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008aa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008ae:	75 14                	jne    8008c4 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8008b0:	83 ec 04             	sub    $0x4,%esp
  8008b3:	68 94 27 80 00       	push   $0x802794
  8008b8:	6a 3a                	push   $0x3a
  8008ba:	68 88 27 80 00       	push   $0x802788
  8008bf:	e8 93 fe ff ff       	call   800757 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008c4:	ff 45 f0             	incl   -0x10(%ebp)
  8008c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008ca:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008cd:	0f 8c 32 ff ff ff    	jl     800805 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008d3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008da:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008e1:	eb 26                	jmp    800909 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008e3:	a1 24 30 80 00       	mov    0x803024,%eax
  8008e8:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008ee:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008f1:	89 d0                	mov    %edx,%eax
  8008f3:	01 c0                	add    %eax,%eax
  8008f5:	01 d0                	add    %edx,%eax
  8008f7:	c1 e0 02             	shl    $0x2,%eax
  8008fa:	01 c8                	add    %ecx,%eax
  8008fc:	8a 40 04             	mov    0x4(%eax),%al
  8008ff:	3c 01                	cmp    $0x1,%al
  800901:	75 03                	jne    800906 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800903:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800906:	ff 45 e0             	incl   -0x20(%ebp)
  800909:	a1 24 30 80 00       	mov    0x803024,%eax
  80090e:	8b 50 74             	mov    0x74(%eax),%edx
  800911:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800914:	39 c2                	cmp    %eax,%edx
  800916:	77 cb                	ja     8008e3 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800918:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80091b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80091e:	74 14                	je     800934 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800920:	83 ec 04             	sub    $0x4,%esp
  800923:	68 e8 27 80 00       	push   $0x8027e8
  800928:	6a 44                	push   $0x44
  80092a:	68 88 27 80 00       	push   $0x802788
  80092f:	e8 23 fe ff ff       	call   800757 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800934:	90                   	nop
  800935:	c9                   	leave  
  800936:	c3                   	ret    

00800937 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800937:	55                   	push   %ebp
  800938:	89 e5                	mov    %esp,%ebp
  80093a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80093d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800940:	8b 00                	mov    (%eax),%eax
  800942:	8d 48 01             	lea    0x1(%eax),%ecx
  800945:	8b 55 0c             	mov    0xc(%ebp),%edx
  800948:	89 0a                	mov    %ecx,(%edx)
  80094a:	8b 55 08             	mov    0x8(%ebp),%edx
  80094d:	88 d1                	mov    %dl,%cl
  80094f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800952:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800956:	8b 45 0c             	mov    0xc(%ebp),%eax
  800959:	8b 00                	mov    (%eax),%eax
  80095b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800960:	75 2c                	jne    80098e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800962:	a0 28 30 80 00       	mov    0x803028,%al
  800967:	0f b6 c0             	movzbl %al,%eax
  80096a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096d:	8b 12                	mov    (%edx),%edx
  80096f:	89 d1                	mov    %edx,%ecx
  800971:	8b 55 0c             	mov    0xc(%ebp),%edx
  800974:	83 c2 08             	add    $0x8,%edx
  800977:	83 ec 04             	sub    $0x4,%esp
  80097a:	50                   	push   %eax
  80097b:	51                   	push   %ecx
  80097c:	52                   	push   %edx
  80097d:	e8 d4 12 00 00       	call   801c56 <sys_cputs>
  800982:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800985:	8b 45 0c             	mov    0xc(%ebp),%eax
  800988:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80098e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800991:	8b 40 04             	mov    0x4(%eax),%eax
  800994:	8d 50 01             	lea    0x1(%eax),%edx
  800997:	8b 45 0c             	mov    0xc(%ebp),%eax
  80099a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80099d:	90                   	nop
  80099e:	c9                   	leave  
  80099f:	c3                   	ret    

008009a0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009a0:	55                   	push   %ebp
  8009a1:	89 e5                	mov    %esp,%ebp
  8009a3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009a9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009b0:	00 00 00 
	b.cnt = 0;
  8009b3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009ba:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009bd:	ff 75 0c             	pushl  0xc(%ebp)
  8009c0:	ff 75 08             	pushl  0x8(%ebp)
  8009c3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009c9:	50                   	push   %eax
  8009ca:	68 37 09 80 00       	push   $0x800937
  8009cf:	e8 11 02 00 00       	call   800be5 <vprintfmt>
  8009d4:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009d7:	a0 28 30 80 00       	mov    0x803028,%al
  8009dc:	0f b6 c0             	movzbl %al,%eax
  8009df:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009e5:	83 ec 04             	sub    $0x4,%esp
  8009e8:	50                   	push   %eax
  8009e9:	52                   	push   %edx
  8009ea:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009f0:	83 c0 08             	add    $0x8,%eax
  8009f3:	50                   	push   %eax
  8009f4:	e8 5d 12 00 00       	call   801c56 <sys_cputs>
  8009f9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009fc:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a03:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a09:	c9                   	leave  
  800a0a:	c3                   	ret    

00800a0b <cprintf>:

int cprintf(const char *fmt, ...) {
  800a0b:	55                   	push   %ebp
  800a0c:	89 e5                	mov    %esp,%ebp
  800a0e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a11:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a18:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a21:	83 ec 08             	sub    $0x8,%esp
  800a24:	ff 75 f4             	pushl  -0xc(%ebp)
  800a27:	50                   	push   %eax
  800a28:	e8 73 ff ff ff       	call   8009a0 <vcprintf>
  800a2d:	83 c4 10             	add    $0x10,%esp
  800a30:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a33:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a36:	c9                   	leave  
  800a37:	c3                   	ret    

00800a38 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a38:	55                   	push   %ebp
  800a39:	89 e5                	mov    %esp,%ebp
  800a3b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a3e:	e8 24 14 00 00       	call   801e67 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a43:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a46:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a49:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4c:	83 ec 08             	sub    $0x8,%esp
  800a4f:	ff 75 f4             	pushl  -0xc(%ebp)
  800a52:	50                   	push   %eax
  800a53:	e8 48 ff ff ff       	call   8009a0 <vcprintf>
  800a58:	83 c4 10             	add    $0x10,%esp
  800a5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a5e:	e8 1e 14 00 00       	call   801e81 <sys_enable_interrupt>
	return cnt;
  800a63:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a66:	c9                   	leave  
  800a67:	c3                   	ret    

00800a68 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a68:	55                   	push   %ebp
  800a69:	89 e5                	mov    %esp,%ebp
  800a6b:	53                   	push   %ebx
  800a6c:	83 ec 14             	sub    $0x14,%esp
  800a6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800a72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a75:	8b 45 14             	mov    0x14(%ebp),%eax
  800a78:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a7b:	8b 45 18             	mov    0x18(%ebp),%eax
  800a7e:	ba 00 00 00 00       	mov    $0x0,%edx
  800a83:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a86:	77 55                	ja     800add <printnum+0x75>
  800a88:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a8b:	72 05                	jb     800a92 <printnum+0x2a>
  800a8d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a90:	77 4b                	ja     800add <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a92:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a95:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a98:	8b 45 18             	mov    0x18(%ebp),%eax
  800a9b:	ba 00 00 00 00       	mov    $0x0,%edx
  800aa0:	52                   	push   %edx
  800aa1:	50                   	push   %eax
  800aa2:	ff 75 f4             	pushl  -0xc(%ebp)
  800aa5:	ff 75 f0             	pushl  -0x10(%ebp)
  800aa8:	e8 9b 17 00 00       	call   802248 <__udivdi3>
  800aad:	83 c4 10             	add    $0x10,%esp
  800ab0:	83 ec 04             	sub    $0x4,%esp
  800ab3:	ff 75 20             	pushl  0x20(%ebp)
  800ab6:	53                   	push   %ebx
  800ab7:	ff 75 18             	pushl  0x18(%ebp)
  800aba:	52                   	push   %edx
  800abb:	50                   	push   %eax
  800abc:	ff 75 0c             	pushl  0xc(%ebp)
  800abf:	ff 75 08             	pushl  0x8(%ebp)
  800ac2:	e8 a1 ff ff ff       	call   800a68 <printnum>
  800ac7:	83 c4 20             	add    $0x20,%esp
  800aca:	eb 1a                	jmp    800ae6 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800acc:	83 ec 08             	sub    $0x8,%esp
  800acf:	ff 75 0c             	pushl  0xc(%ebp)
  800ad2:	ff 75 20             	pushl  0x20(%ebp)
  800ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad8:	ff d0                	call   *%eax
  800ada:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800add:	ff 4d 1c             	decl   0x1c(%ebp)
  800ae0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800ae4:	7f e6                	jg     800acc <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800ae6:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ae9:	bb 00 00 00 00       	mov    $0x0,%ebx
  800aee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800af1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800af4:	53                   	push   %ebx
  800af5:	51                   	push   %ecx
  800af6:	52                   	push   %edx
  800af7:	50                   	push   %eax
  800af8:	e8 5b 18 00 00       	call   802358 <__umoddi3>
  800afd:	83 c4 10             	add    $0x10,%esp
  800b00:	05 54 2a 80 00       	add    $0x802a54,%eax
  800b05:	8a 00                	mov    (%eax),%al
  800b07:	0f be c0             	movsbl %al,%eax
  800b0a:	83 ec 08             	sub    $0x8,%esp
  800b0d:	ff 75 0c             	pushl  0xc(%ebp)
  800b10:	50                   	push   %eax
  800b11:	8b 45 08             	mov    0x8(%ebp),%eax
  800b14:	ff d0                	call   *%eax
  800b16:	83 c4 10             	add    $0x10,%esp
}
  800b19:	90                   	nop
  800b1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b1d:	c9                   	leave  
  800b1e:	c3                   	ret    

00800b1f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b1f:	55                   	push   %ebp
  800b20:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b22:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b26:	7e 1c                	jle    800b44 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b28:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2b:	8b 00                	mov    (%eax),%eax
  800b2d:	8d 50 08             	lea    0x8(%eax),%edx
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	89 10                	mov    %edx,(%eax)
  800b35:	8b 45 08             	mov    0x8(%ebp),%eax
  800b38:	8b 00                	mov    (%eax),%eax
  800b3a:	83 e8 08             	sub    $0x8,%eax
  800b3d:	8b 50 04             	mov    0x4(%eax),%edx
  800b40:	8b 00                	mov    (%eax),%eax
  800b42:	eb 40                	jmp    800b84 <getuint+0x65>
	else if (lflag)
  800b44:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b48:	74 1e                	je     800b68 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4d:	8b 00                	mov    (%eax),%eax
  800b4f:	8d 50 04             	lea    0x4(%eax),%edx
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	89 10                	mov    %edx,(%eax)
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5a:	8b 00                	mov    (%eax),%eax
  800b5c:	83 e8 04             	sub    $0x4,%eax
  800b5f:	8b 00                	mov    (%eax),%eax
  800b61:	ba 00 00 00 00       	mov    $0x0,%edx
  800b66:	eb 1c                	jmp    800b84 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	8b 00                	mov    (%eax),%eax
  800b6d:	8d 50 04             	lea    0x4(%eax),%edx
  800b70:	8b 45 08             	mov    0x8(%ebp),%eax
  800b73:	89 10                	mov    %edx,(%eax)
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	8b 00                	mov    (%eax),%eax
  800b7a:	83 e8 04             	sub    $0x4,%eax
  800b7d:	8b 00                	mov    (%eax),%eax
  800b7f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b84:	5d                   	pop    %ebp
  800b85:	c3                   	ret    

00800b86 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b86:	55                   	push   %ebp
  800b87:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b89:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b8d:	7e 1c                	jle    800bab <getint+0x25>
		return va_arg(*ap, long long);
  800b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b92:	8b 00                	mov    (%eax),%eax
  800b94:	8d 50 08             	lea    0x8(%eax),%edx
  800b97:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9a:	89 10                	mov    %edx,(%eax)
  800b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9f:	8b 00                	mov    (%eax),%eax
  800ba1:	83 e8 08             	sub    $0x8,%eax
  800ba4:	8b 50 04             	mov    0x4(%eax),%edx
  800ba7:	8b 00                	mov    (%eax),%eax
  800ba9:	eb 38                	jmp    800be3 <getint+0x5d>
	else if (lflag)
  800bab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800baf:	74 1a                	je     800bcb <getint+0x45>
		return va_arg(*ap, long);
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	8b 00                	mov    (%eax),%eax
  800bb6:	8d 50 04             	lea    0x4(%eax),%edx
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	89 10                	mov    %edx,(%eax)
  800bbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc1:	8b 00                	mov    (%eax),%eax
  800bc3:	83 e8 04             	sub    $0x4,%eax
  800bc6:	8b 00                	mov    (%eax),%eax
  800bc8:	99                   	cltd   
  800bc9:	eb 18                	jmp    800be3 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bce:	8b 00                	mov    (%eax),%eax
  800bd0:	8d 50 04             	lea    0x4(%eax),%edx
  800bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd6:	89 10                	mov    %edx,(%eax)
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	8b 00                	mov    (%eax),%eax
  800bdd:	83 e8 04             	sub    $0x4,%eax
  800be0:	8b 00                	mov    (%eax),%eax
  800be2:	99                   	cltd   
}
  800be3:	5d                   	pop    %ebp
  800be4:	c3                   	ret    

00800be5 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800be5:	55                   	push   %ebp
  800be6:	89 e5                	mov    %esp,%ebp
  800be8:	56                   	push   %esi
  800be9:	53                   	push   %ebx
  800bea:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bed:	eb 17                	jmp    800c06 <vprintfmt+0x21>
			if (ch == '\0')
  800bef:	85 db                	test   %ebx,%ebx
  800bf1:	0f 84 af 03 00 00    	je     800fa6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bf7:	83 ec 08             	sub    $0x8,%esp
  800bfa:	ff 75 0c             	pushl  0xc(%ebp)
  800bfd:	53                   	push   %ebx
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	ff d0                	call   *%eax
  800c03:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c06:	8b 45 10             	mov    0x10(%ebp),%eax
  800c09:	8d 50 01             	lea    0x1(%eax),%edx
  800c0c:	89 55 10             	mov    %edx,0x10(%ebp)
  800c0f:	8a 00                	mov    (%eax),%al
  800c11:	0f b6 d8             	movzbl %al,%ebx
  800c14:	83 fb 25             	cmp    $0x25,%ebx
  800c17:	75 d6                	jne    800bef <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c19:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c1d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c24:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c2b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c32:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c39:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3c:	8d 50 01             	lea    0x1(%eax),%edx
  800c3f:	89 55 10             	mov    %edx,0x10(%ebp)
  800c42:	8a 00                	mov    (%eax),%al
  800c44:	0f b6 d8             	movzbl %al,%ebx
  800c47:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c4a:	83 f8 55             	cmp    $0x55,%eax
  800c4d:	0f 87 2b 03 00 00    	ja     800f7e <vprintfmt+0x399>
  800c53:	8b 04 85 78 2a 80 00 	mov    0x802a78(,%eax,4),%eax
  800c5a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c5c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c60:	eb d7                	jmp    800c39 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c62:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c66:	eb d1                	jmp    800c39 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c68:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c6f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c72:	89 d0                	mov    %edx,%eax
  800c74:	c1 e0 02             	shl    $0x2,%eax
  800c77:	01 d0                	add    %edx,%eax
  800c79:	01 c0                	add    %eax,%eax
  800c7b:	01 d8                	add    %ebx,%eax
  800c7d:	83 e8 30             	sub    $0x30,%eax
  800c80:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c83:	8b 45 10             	mov    0x10(%ebp),%eax
  800c86:	8a 00                	mov    (%eax),%al
  800c88:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c8b:	83 fb 2f             	cmp    $0x2f,%ebx
  800c8e:	7e 3e                	jle    800cce <vprintfmt+0xe9>
  800c90:	83 fb 39             	cmp    $0x39,%ebx
  800c93:	7f 39                	jg     800cce <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c95:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c98:	eb d5                	jmp    800c6f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c9a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c9d:	83 c0 04             	add    $0x4,%eax
  800ca0:	89 45 14             	mov    %eax,0x14(%ebp)
  800ca3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca6:	83 e8 04             	sub    $0x4,%eax
  800ca9:	8b 00                	mov    (%eax),%eax
  800cab:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cae:	eb 1f                	jmp    800ccf <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cb0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cb4:	79 83                	jns    800c39 <vprintfmt+0x54>
				width = 0;
  800cb6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cbd:	e9 77 ff ff ff       	jmp    800c39 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800cc2:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800cc9:	e9 6b ff ff ff       	jmp    800c39 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800cce:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ccf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cd3:	0f 89 60 ff ff ff    	jns    800c39 <vprintfmt+0x54>
				width = precision, precision = -1;
  800cd9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cdc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cdf:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ce6:	e9 4e ff ff ff       	jmp    800c39 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ceb:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cee:	e9 46 ff ff ff       	jmp    800c39 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cf3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf6:	83 c0 04             	add    $0x4,%eax
  800cf9:	89 45 14             	mov    %eax,0x14(%ebp)
  800cfc:	8b 45 14             	mov    0x14(%ebp),%eax
  800cff:	83 e8 04             	sub    $0x4,%eax
  800d02:	8b 00                	mov    (%eax),%eax
  800d04:	83 ec 08             	sub    $0x8,%esp
  800d07:	ff 75 0c             	pushl  0xc(%ebp)
  800d0a:	50                   	push   %eax
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	ff d0                	call   *%eax
  800d10:	83 c4 10             	add    $0x10,%esp
			break;
  800d13:	e9 89 02 00 00       	jmp    800fa1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d18:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1b:	83 c0 04             	add    $0x4,%eax
  800d1e:	89 45 14             	mov    %eax,0x14(%ebp)
  800d21:	8b 45 14             	mov    0x14(%ebp),%eax
  800d24:	83 e8 04             	sub    $0x4,%eax
  800d27:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d29:	85 db                	test   %ebx,%ebx
  800d2b:	79 02                	jns    800d2f <vprintfmt+0x14a>
				err = -err;
  800d2d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d2f:	83 fb 64             	cmp    $0x64,%ebx
  800d32:	7f 0b                	jg     800d3f <vprintfmt+0x15a>
  800d34:	8b 34 9d c0 28 80 00 	mov    0x8028c0(,%ebx,4),%esi
  800d3b:	85 f6                	test   %esi,%esi
  800d3d:	75 19                	jne    800d58 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d3f:	53                   	push   %ebx
  800d40:	68 65 2a 80 00       	push   $0x802a65
  800d45:	ff 75 0c             	pushl  0xc(%ebp)
  800d48:	ff 75 08             	pushl  0x8(%ebp)
  800d4b:	e8 5e 02 00 00       	call   800fae <printfmt>
  800d50:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d53:	e9 49 02 00 00       	jmp    800fa1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d58:	56                   	push   %esi
  800d59:	68 6e 2a 80 00       	push   $0x802a6e
  800d5e:	ff 75 0c             	pushl  0xc(%ebp)
  800d61:	ff 75 08             	pushl  0x8(%ebp)
  800d64:	e8 45 02 00 00       	call   800fae <printfmt>
  800d69:	83 c4 10             	add    $0x10,%esp
			break;
  800d6c:	e9 30 02 00 00       	jmp    800fa1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d71:	8b 45 14             	mov    0x14(%ebp),%eax
  800d74:	83 c0 04             	add    $0x4,%eax
  800d77:	89 45 14             	mov    %eax,0x14(%ebp)
  800d7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d7d:	83 e8 04             	sub    $0x4,%eax
  800d80:	8b 30                	mov    (%eax),%esi
  800d82:	85 f6                	test   %esi,%esi
  800d84:	75 05                	jne    800d8b <vprintfmt+0x1a6>
				p = "(null)";
  800d86:	be 71 2a 80 00       	mov    $0x802a71,%esi
			if (width > 0 && padc != '-')
  800d8b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d8f:	7e 6d                	jle    800dfe <vprintfmt+0x219>
  800d91:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d95:	74 67                	je     800dfe <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d97:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d9a:	83 ec 08             	sub    $0x8,%esp
  800d9d:	50                   	push   %eax
  800d9e:	56                   	push   %esi
  800d9f:	e8 12 05 00 00       	call   8012b6 <strnlen>
  800da4:	83 c4 10             	add    $0x10,%esp
  800da7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800daa:	eb 16                	jmp    800dc2 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800dac:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800db0:	83 ec 08             	sub    $0x8,%esp
  800db3:	ff 75 0c             	pushl  0xc(%ebp)
  800db6:	50                   	push   %eax
  800db7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dba:	ff d0                	call   *%eax
  800dbc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800dbf:	ff 4d e4             	decl   -0x1c(%ebp)
  800dc2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dc6:	7f e4                	jg     800dac <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dc8:	eb 34                	jmp    800dfe <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800dca:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800dce:	74 1c                	je     800dec <vprintfmt+0x207>
  800dd0:	83 fb 1f             	cmp    $0x1f,%ebx
  800dd3:	7e 05                	jle    800dda <vprintfmt+0x1f5>
  800dd5:	83 fb 7e             	cmp    $0x7e,%ebx
  800dd8:	7e 12                	jle    800dec <vprintfmt+0x207>
					putch('?', putdat);
  800dda:	83 ec 08             	sub    $0x8,%esp
  800ddd:	ff 75 0c             	pushl  0xc(%ebp)
  800de0:	6a 3f                	push   $0x3f
  800de2:	8b 45 08             	mov    0x8(%ebp),%eax
  800de5:	ff d0                	call   *%eax
  800de7:	83 c4 10             	add    $0x10,%esp
  800dea:	eb 0f                	jmp    800dfb <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800dec:	83 ec 08             	sub    $0x8,%esp
  800def:	ff 75 0c             	pushl  0xc(%ebp)
  800df2:	53                   	push   %ebx
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	ff d0                	call   *%eax
  800df8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dfb:	ff 4d e4             	decl   -0x1c(%ebp)
  800dfe:	89 f0                	mov    %esi,%eax
  800e00:	8d 70 01             	lea    0x1(%eax),%esi
  800e03:	8a 00                	mov    (%eax),%al
  800e05:	0f be d8             	movsbl %al,%ebx
  800e08:	85 db                	test   %ebx,%ebx
  800e0a:	74 24                	je     800e30 <vprintfmt+0x24b>
  800e0c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e10:	78 b8                	js     800dca <vprintfmt+0x1e5>
  800e12:	ff 4d e0             	decl   -0x20(%ebp)
  800e15:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e19:	79 af                	jns    800dca <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e1b:	eb 13                	jmp    800e30 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e1d:	83 ec 08             	sub    $0x8,%esp
  800e20:	ff 75 0c             	pushl  0xc(%ebp)
  800e23:	6a 20                	push   $0x20
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	ff d0                	call   *%eax
  800e2a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e2d:	ff 4d e4             	decl   -0x1c(%ebp)
  800e30:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e34:	7f e7                	jg     800e1d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e36:	e9 66 01 00 00       	jmp    800fa1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e3b:	83 ec 08             	sub    $0x8,%esp
  800e3e:	ff 75 e8             	pushl  -0x18(%ebp)
  800e41:	8d 45 14             	lea    0x14(%ebp),%eax
  800e44:	50                   	push   %eax
  800e45:	e8 3c fd ff ff       	call   800b86 <getint>
  800e4a:	83 c4 10             	add    $0x10,%esp
  800e4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e50:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e53:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e56:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e59:	85 d2                	test   %edx,%edx
  800e5b:	79 23                	jns    800e80 <vprintfmt+0x29b>
				putch('-', putdat);
  800e5d:	83 ec 08             	sub    $0x8,%esp
  800e60:	ff 75 0c             	pushl  0xc(%ebp)
  800e63:	6a 2d                	push   $0x2d
  800e65:	8b 45 08             	mov    0x8(%ebp),%eax
  800e68:	ff d0                	call   *%eax
  800e6a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e70:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e73:	f7 d8                	neg    %eax
  800e75:	83 d2 00             	adc    $0x0,%edx
  800e78:	f7 da                	neg    %edx
  800e7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e7d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e80:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e87:	e9 bc 00 00 00       	jmp    800f48 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e8c:	83 ec 08             	sub    $0x8,%esp
  800e8f:	ff 75 e8             	pushl  -0x18(%ebp)
  800e92:	8d 45 14             	lea    0x14(%ebp),%eax
  800e95:	50                   	push   %eax
  800e96:	e8 84 fc ff ff       	call   800b1f <getuint>
  800e9b:	83 c4 10             	add    $0x10,%esp
  800e9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ea1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ea4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800eab:	e9 98 00 00 00       	jmp    800f48 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800eb0:	83 ec 08             	sub    $0x8,%esp
  800eb3:	ff 75 0c             	pushl  0xc(%ebp)
  800eb6:	6a 58                	push   $0x58
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	ff d0                	call   *%eax
  800ebd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ec0:	83 ec 08             	sub    $0x8,%esp
  800ec3:	ff 75 0c             	pushl  0xc(%ebp)
  800ec6:	6a 58                	push   $0x58
  800ec8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecb:	ff d0                	call   *%eax
  800ecd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ed0:	83 ec 08             	sub    $0x8,%esp
  800ed3:	ff 75 0c             	pushl  0xc(%ebp)
  800ed6:	6a 58                	push   $0x58
  800ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  800edb:	ff d0                	call   *%eax
  800edd:	83 c4 10             	add    $0x10,%esp
			break;
  800ee0:	e9 bc 00 00 00       	jmp    800fa1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ee5:	83 ec 08             	sub    $0x8,%esp
  800ee8:	ff 75 0c             	pushl  0xc(%ebp)
  800eeb:	6a 30                	push   $0x30
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef0:	ff d0                	call   *%eax
  800ef2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ef5:	83 ec 08             	sub    $0x8,%esp
  800ef8:	ff 75 0c             	pushl  0xc(%ebp)
  800efb:	6a 78                	push   $0x78
  800efd:	8b 45 08             	mov    0x8(%ebp),%eax
  800f00:	ff d0                	call   *%eax
  800f02:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f05:	8b 45 14             	mov    0x14(%ebp),%eax
  800f08:	83 c0 04             	add    $0x4,%eax
  800f0b:	89 45 14             	mov    %eax,0x14(%ebp)
  800f0e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f11:	83 e8 04             	sub    $0x4,%eax
  800f14:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f19:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f20:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f27:	eb 1f                	jmp    800f48 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f29:	83 ec 08             	sub    $0x8,%esp
  800f2c:	ff 75 e8             	pushl  -0x18(%ebp)
  800f2f:	8d 45 14             	lea    0x14(%ebp),%eax
  800f32:	50                   	push   %eax
  800f33:	e8 e7 fb ff ff       	call   800b1f <getuint>
  800f38:	83 c4 10             	add    $0x10,%esp
  800f3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f3e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f41:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f48:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f4f:	83 ec 04             	sub    $0x4,%esp
  800f52:	52                   	push   %edx
  800f53:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f56:	50                   	push   %eax
  800f57:	ff 75 f4             	pushl  -0xc(%ebp)
  800f5a:	ff 75 f0             	pushl  -0x10(%ebp)
  800f5d:	ff 75 0c             	pushl  0xc(%ebp)
  800f60:	ff 75 08             	pushl  0x8(%ebp)
  800f63:	e8 00 fb ff ff       	call   800a68 <printnum>
  800f68:	83 c4 20             	add    $0x20,%esp
			break;
  800f6b:	eb 34                	jmp    800fa1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f6d:	83 ec 08             	sub    $0x8,%esp
  800f70:	ff 75 0c             	pushl  0xc(%ebp)
  800f73:	53                   	push   %ebx
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	ff d0                	call   *%eax
  800f79:	83 c4 10             	add    $0x10,%esp
			break;
  800f7c:	eb 23                	jmp    800fa1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f7e:	83 ec 08             	sub    $0x8,%esp
  800f81:	ff 75 0c             	pushl  0xc(%ebp)
  800f84:	6a 25                	push   $0x25
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	ff d0                	call   *%eax
  800f8b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f8e:	ff 4d 10             	decl   0x10(%ebp)
  800f91:	eb 03                	jmp    800f96 <vprintfmt+0x3b1>
  800f93:	ff 4d 10             	decl   0x10(%ebp)
  800f96:	8b 45 10             	mov    0x10(%ebp),%eax
  800f99:	48                   	dec    %eax
  800f9a:	8a 00                	mov    (%eax),%al
  800f9c:	3c 25                	cmp    $0x25,%al
  800f9e:	75 f3                	jne    800f93 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800fa0:	90                   	nop
		}
	}
  800fa1:	e9 47 fc ff ff       	jmp    800bed <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800fa6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fa7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800faa:	5b                   	pop    %ebx
  800fab:	5e                   	pop    %esi
  800fac:	5d                   	pop    %ebp
  800fad:	c3                   	ret    

00800fae <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fae:	55                   	push   %ebp
  800faf:	89 e5                	mov    %esp,%ebp
  800fb1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fb4:	8d 45 10             	lea    0x10(%ebp),%eax
  800fb7:	83 c0 04             	add    $0x4,%eax
  800fba:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fbd:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc0:	ff 75 f4             	pushl  -0xc(%ebp)
  800fc3:	50                   	push   %eax
  800fc4:	ff 75 0c             	pushl  0xc(%ebp)
  800fc7:	ff 75 08             	pushl  0x8(%ebp)
  800fca:	e8 16 fc ff ff       	call   800be5 <vprintfmt>
  800fcf:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fd2:	90                   	nop
  800fd3:	c9                   	leave  
  800fd4:	c3                   	ret    

00800fd5 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fd5:	55                   	push   %ebp
  800fd6:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fdb:	8b 40 08             	mov    0x8(%eax),%eax
  800fde:	8d 50 01             	lea    0x1(%eax),%edx
  800fe1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe4:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fe7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fea:	8b 10                	mov    (%eax),%edx
  800fec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fef:	8b 40 04             	mov    0x4(%eax),%eax
  800ff2:	39 c2                	cmp    %eax,%edx
  800ff4:	73 12                	jae    801008 <sprintputch+0x33>
		*b->buf++ = ch;
  800ff6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff9:	8b 00                	mov    (%eax),%eax
  800ffb:	8d 48 01             	lea    0x1(%eax),%ecx
  800ffe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801001:	89 0a                	mov    %ecx,(%edx)
  801003:	8b 55 08             	mov    0x8(%ebp),%edx
  801006:	88 10                	mov    %dl,(%eax)
}
  801008:	90                   	nop
  801009:	5d                   	pop    %ebp
  80100a:	c3                   	ret    

0080100b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80100b:	55                   	push   %ebp
  80100c:	89 e5                	mov    %esp,%ebp
  80100e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801011:	8b 45 08             	mov    0x8(%ebp),%eax
  801014:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801017:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80101d:	8b 45 08             	mov    0x8(%ebp),%eax
  801020:	01 d0                	add    %edx,%eax
  801022:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801025:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80102c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801030:	74 06                	je     801038 <vsnprintf+0x2d>
  801032:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801036:	7f 07                	jg     80103f <vsnprintf+0x34>
		return -E_INVAL;
  801038:	b8 03 00 00 00       	mov    $0x3,%eax
  80103d:	eb 20                	jmp    80105f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80103f:	ff 75 14             	pushl  0x14(%ebp)
  801042:	ff 75 10             	pushl  0x10(%ebp)
  801045:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801048:	50                   	push   %eax
  801049:	68 d5 0f 80 00       	push   $0x800fd5
  80104e:	e8 92 fb ff ff       	call   800be5 <vprintfmt>
  801053:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801056:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801059:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80105c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80105f:	c9                   	leave  
  801060:	c3                   	ret    

00801061 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801061:	55                   	push   %ebp
  801062:	89 e5                	mov    %esp,%ebp
  801064:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801067:	8d 45 10             	lea    0x10(%ebp),%eax
  80106a:	83 c0 04             	add    $0x4,%eax
  80106d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801070:	8b 45 10             	mov    0x10(%ebp),%eax
  801073:	ff 75 f4             	pushl  -0xc(%ebp)
  801076:	50                   	push   %eax
  801077:	ff 75 0c             	pushl  0xc(%ebp)
  80107a:	ff 75 08             	pushl  0x8(%ebp)
  80107d:	e8 89 ff ff ff       	call   80100b <vsnprintf>
  801082:	83 c4 10             	add    $0x10,%esp
  801085:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801088:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80108b:	c9                   	leave  
  80108c:	c3                   	ret    

0080108d <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80108d:	55                   	push   %ebp
  80108e:	89 e5                	mov    %esp,%ebp
  801090:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801093:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801097:	74 13                	je     8010ac <readline+0x1f>
		cprintf("%s", prompt);
  801099:	83 ec 08             	sub    $0x8,%esp
  80109c:	ff 75 08             	pushl  0x8(%ebp)
  80109f:	68 d0 2b 80 00       	push   $0x802bd0
  8010a4:	e8 62 f9 ff ff       	call   800a0b <cprintf>
  8010a9:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8010b3:	83 ec 0c             	sub    $0xc,%esp
  8010b6:	6a 00                	push   $0x0
  8010b8:	e8 8e f5 ff ff       	call   80064b <iscons>
  8010bd:	83 c4 10             	add    $0x10,%esp
  8010c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8010c3:	e8 35 f5 ff ff       	call   8005fd <getchar>
  8010c8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010cb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010cf:	79 22                	jns    8010f3 <readline+0x66>
			if (c != -E_EOF)
  8010d1:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010d5:	0f 84 ad 00 00 00    	je     801188 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010db:	83 ec 08             	sub    $0x8,%esp
  8010de:	ff 75 ec             	pushl  -0x14(%ebp)
  8010e1:	68 d3 2b 80 00       	push   $0x802bd3
  8010e6:	e8 20 f9 ff ff       	call   800a0b <cprintf>
  8010eb:	83 c4 10             	add    $0x10,%esp
			return;
  8010ee:	e9 95 00 00 00       	jmp    801188 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010f3:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010f7:	7e 34                	jle    80112d <readline+0xa0>
  8010f9:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801100:	7f 2b                	jg     80112d <readline+0xa0>
			if (echoing)
  801102:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801106:	74 0e                	je     801116 <readline+0x89>
				cputchar(c);
  801108:	83 ec 0c             	sub    $0xc,%esp
  80110b:	ff 75 ec             	pushl  -0x14(%ebp)
  80110e:	e8 a2 f4 ff ff       	call   8005b5 <cputchar>
  801113:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801116:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801119:	8d 50 01             	lea    0x1(%eax),%edx
  80111c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80111f:	89 c2                	mov    %eax,%edx
  801121:	8b 45 0c             	mov    0xc(%ebp),%eax
  801124:	01 d0                	add    %edx,%eax
  801126:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801129:	88 10                	mov    %dl,(%eax)
  80112b:	eb 56                	jmp    801183 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80112d:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801131:	75 1f                	jne    801152 <readline+0xc5>
  801133:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801137:	7e 19                	jle    801152 <readline+0xc5>
			if (echoing)
  801139:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80113d:	74 0e                	je     80114d <readline+0xc0>
				cputchar(c);
  80113f:	83 ec 0c             	sub    $0xc,%esp
  801142:	ff 75 ec             	pushl  -0x14(%ebp)
  801145:	e8 6b f4 ff ff       	call   8005b5 <cputchar>
  80114a:	83 c4 10             	add    $0x10,%esp

			i--;
  80114d:	ff 4d f4             	decl   -0xc(%ebp)
  801150:	eb 31                	jmp    801183 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801152:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801156:	74 0a                	je     801162 <readline+0xd5>
  801158:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80115c:	0f 85 61 ff ff ff    	jne    8010c3 <readline+0x36>
			if (echoing)
  801162:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801166:	74 0e                	je     801176 <readline+0xe9>
				cputchar(c);
  801168:	83 ec 0c             	sub    $0xc,%esp
  80116b:	ff 75 ec             	pushl  -0x14(%ebp)
  80116e:	e8 42 f4 ff ff       	call   8005b5 <cputchar>
  801173:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801176:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801179:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117c:	01 d0                	add    %edx,%eax
  80117e:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801181:	eb 06                	jmp    801189 <readline+0xfc>
		}
	}
  801183:	e9 3b ff ff ff       	jmp    8010c3 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801188:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801189:	c9                   	leave  
  80118a:	c3                   	ret    

0080118b <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  80118b:	55                   	push   %ebp
  80118c:	89 e5                	mov    %esp,%ebp
  80118e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801191:	e8 d1 0c 00 00       	call   801e67 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801196:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80119a:	74 13                	je     8011af <atomic_readline+0x24>
		cprintf("%s", prompt);
  80119c:	83 ec 08             	sub    $0x8,%esp
  80119f:	ff 75 08             	pushl  0x8(%ebp)
  8011a2:	68 d0 2b 80 00       	push   $0x802bd0
  8011a7:	e8 5f f8 ff ff       	call   800a0b <cprintf>
  8011ac:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011b6:	83 ec 0c             	sub    $0xc,%esp
  8011b9:	6a 00                	push   $0x0
  8011bb:	e8 8b f4 ff ff       	call   80064b <iscons>
  8011c0:	83 c4 10             	add    $0x10,%esp
  8011c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011c6:	e8 32 f4 ff ff       	call   8005fd <getchar>
  8011cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011ce:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011d2:	79 23                	jns    8011f7 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011d4:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011d8:	74 13                	je     8011ed <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011da:	83 ec 08             	sub    $0x8,%esp
  8011dd:	ff 75 ec             	pushl  -0x14(%ebp)
  8011e0:	68 d3 2b 80 00       	push   $0x802bd3
  8011e5:	e8 21 f8 ff ff       	call   800a0b <cprintf>
  8011ea:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011ed:	e8 8f 0c 00 00       	call   801e81 <sys_enable_interrupt>
			return;
  8011f2:	e9 9a 00 00 00       	jmp    801291 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011f7:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011fb:	7e 34                	jle    801231 <atomic_readline+0xa6>
  8011fd:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801204:	7f 2b                	jg     801231 <atomic_readline+0xa6>
			if (echoing)
  801206:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80120a:	74 0e                	je     80121a <atomic_readline+0x8f>
				cputchar(c);
  80120c:	83 ec 0c             	sub    $0xc,%esp
  80120f:	ff 75 ec             	pushl  -0x14(%ebp)
  801212:	e8 9e f3 ff ff       	call   8005b5 <cputchar>
  801217:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80121a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80121d:	8d 50 01             	lea    0x1(%eax),%edx
  801220:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801223:	89 c2                	mov    %eax,%edx
  801225:	8b 45 0c             	mov    0xc(%ebp),%eax
  801228:	01 d0                	add    %edx,%eax
  80122a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80122d:	88 10                	mov    %dl,(%eax)
  80122f:	eb 5b                	jmp    80128c <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801231:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801235:	75 1f                	jne    801256 <atomic_readline+0xcb>
  801237:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80123b:	7e 19                	jle    801256 <atomic_readline+0xcb>
			if (echoing)
  80123d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801241:	74 0e                	je     801251 <atomic_readline+0xc6>
				cputchar(c);
  801243:	83 ec 0c             	sub    $0xc,%esp
  801246:	ff 75 ec             	pushl  -0x14(%ebp)
  801249:	e8 67 f3 ff ff       	call   8005b5 <cputchar>
  80124e:	83 c4 10             	add    $0x10,%esp
			i--;
  801251:	ff 4d f4             	decl   -0xc(%ebp)
  801254:	eb 36                	jmp    80128c <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801256:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80125a:	74 0a                	je     801266 <atomic_readline+0xdb>
  80125c:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801260:	0f 85 60 ff ff ff    	jne    8011c6 <atomic_readline+0x3b>
			if (echoing)
  801266:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80126a:	74 0e                	je     80127a <atomic_readline+0xef>
				cputchar(c);
  80126c:	83 ec 0c             	sub    $0xc,%esp
  80126f:	ff 75 ec             	pushl  -0x14(%ebp)
  801272:	e8 3e f3 ff ff       	call   8005b5 <cputchar>
  801277:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  80127a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80127d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801280:	01 d0                	add    %edx,%eax
  801282:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801285:	e8 f7 0b 00 00       	call   801e81 <sys_enable_interrupt>
			return;
  80128a:	eb 05                	jmp    801291 <atomic_readline+0x106>
		}
	}
  80128c:	e9 35 ff ff ff       	jmp    8011c6 <atomic_readline+0x3b>
}
  801291:	c9                   	leave  
  801292:	c3                   	ret    

00801293 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801293:	55                   	push   %ebp
  801294:	89 e5                	mov    %esp,%ebp
  801296:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801299:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012a0:	eb 06                	jmp    8012a8 <strlen+0x15>
		n++;
  8012a2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012a5:	ff 45 08             	incl   0x8(%ebp)
  8012a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ab:	8a 00                	mov    (%eax),%al
  8012ad:	84 c0                	test   %al,%al
  8012af:	75 f1                	jne    8012a2 <strlen+0xf>
		n++;
	return n;
  8012b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012b4:	c9                   	leave  
  8012b5:	c3                   	ret    

008012b6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8012b6:	55                   	push   %ebp
  8012b7:	89 e5                	mov    %esp,%ebp
  8012b9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012c3:	eb 09                	jmp    8012ce <strnlen+0x18>
		n++;
  8012c5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012c8:	ff 45 08             	incl   0x8(%ebp)
  8012cb:	ff 4d 0c             	decl   0xc(%ebp)
  8012ce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012d2:	74 09                	je     8012dd <strnlen+0x27>
  8012d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d7:	8a 00                	mov    (%eax),%al
  8012d9:	84 c0                	test   %al,%al
  8012db:	75 e8                	jne    8012c5 <strnlen+0xf>
		n++;
	return n;
  8012dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012e0:	c9                   	leave  
  8012e1:	c3                   	ret    

008012e2 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012e2:	55                   	push   %ebp
  8012e3:	89 e5                	mov    %esp,%ebp
  8012e5:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012ee:	90                   	nop
  8012ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f2:	8d 50 01             	lea    0x1(%eax),%edx
  8012f5:	89 55 08             	mov    %edx,0x8(%ebp)
  8012f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012fb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012fe:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801301:	8a 12                	mov    (%edx),%dl
  801303:	88 10                	mov    %dl,(%eax)
  801305:	8a 00                	mov    (%eax),%al
  801307:	84 c0                	test   %al,%al
  801309:	75 e4                	jne    8012ef <strcpy+0xd>
		/* do nothing */;
	return ret;
  80130b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80130e:	c9                   	leave  
  80130f:	c3                   	ret    

00801310 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801310:	55                   	push   %ebp
  801311:	89 e5                	mov    %esp,%ebp
  801313:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801316:	8b 45 08             	mov    0x8(%ebp),%eax
  801319:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80131c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801323:	eb 1f                	jmp    801344 <strncpy+0x34>
		*dst++ = *src;
  801325:	8b 45 08             	mov    0x8(%ebp),%eax
  801328:	8d 50 01             	lea    0x1(%eax),%edx
  80132b:	89 55 08             	mov    %edx,0x8(%ebp)
  80132e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801331:	8a 12                	mov    (%edx),%dl
  801333:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801335:	8b 45 0c             	mov    0xc(%ebp),%eax
  801338:	8a 00                	mov    (%eax),%al
  80133a:	84 c0                	test   %al,%al
  80133c:	74 03                	je     801341 <strncpy+0x31>
			src++;
  80133e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801341:	ff 45 fc             	incl   -0x4(%ebp)
  801344:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801347:	3b 45 10             	cmp    0x10(%ebp),%eax
  80134a:	72 d9                	jb     801325 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80134c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80134f:	c9                   	leave  
  801350:	c3                   	ret    

00801351 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
  801354:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80135d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801361:	74 30                	je     801393 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801363:	eb 16                	jmp    80137b <strlcpy+0x2a>
			*dst++ = *src++;
  801365:	8b 45 08             	mov    0x8(%ebp),%eax
  801368:	8d 50 01             	lea    0x1(%eax),%edx
  80136b:	89 55 08             	mov    %edx,0x8(%ebp)
  80136e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801371:	8d 4a 01             	lea    0x1(%edx),%ecx
  801374:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801377:	8a 12                	mov    (%edx),%dl
  801379:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80137b:	ff 4d 10             	decl   0x10(%ebp)
  80137e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801382:	74 09                	je     80138d <strlcpy+0x3c>
  801384:	8b 45 0c             	mov    0xc(%ebp),%eax
  801387:	8a 00                	mov    (%eax),%al
  801389:	84 c0                	test   %al,%al
  80138b:	75 d8                	jne    801365 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80138d:	8b 45 08             	mov    0x8(%ebp),%eax
  801390:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801393:	8b 55 08             	mov    0x8(%ebp),%edx
  801396:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801399:	29 c2                	sub    %eax,%edx
  80139b:	89 d0                	mov    %edx,%eax
}
  80139d:	c9                   	leave  
  80139e:	c3                   	ret    

0080139f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80139f:	55                   	push   %ebp
  8013a0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013a2:	eb 06                	jmp    8013aa <strcmp+0xb>
		p++, q++;
  8013a4:	ff 45 08             	incl   0x8(%ebp)
  8013a7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ad:	8a 00                	mov    (%eax),%al
  8013af:	84 c0                	test   %al,%al
  8013b1:	74 0e                	je     8013c1 <strcmp+0x22>
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	8a 10                	mov    (%eax),%dl
  8013b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013bb:	8a 00                	mov    (%eax),%al
  8013bd:	38 c2                	cmp    %al,%dl
  8013bf:	74 e3                	je     8013a4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	8a 00                	mov    (%eax),%al
  8013c6:	0f b6 d0             	movzbl %al,%edx
  8013c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013cc:	8a 00                	mov    (%eax),%al
  8013ce:	0f b6 c0             	movzbl %al,%eax
  8013d1:	29 c2                	sub    %eax,%edx
  8013d3:	89 d0                	mov    %edx,%eax
}
  8013d5:	5d                   	pop    %ebp
  8013d6:	c3                   	ret    

008013d7 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013d7:	55                   	push   %ebp
  8013d8:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013da:	eb 09                	jmp    8013e5 <strncmp+0xe>
		n--, p++, q++;
  8013dc:	ff 4d 10             	decl   0x10(%ebp)
  8013df:	ff 45 08             	incl   0x8(%ebp)
  8013e2:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e9:	74 17                	je     801402 <strncmp+0x2b>
  8013eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ee:	8a 00                	mov    (%eax),%al
  8013f0:	84 c0                	test   %al,%al
  8013f2:	74 0e                	je     801402 <strncmp+0x2b>
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	8a 10                	mov    (%eax),%dl
  8013f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fc:	8a 00                	mov    (%eax),%al
  8013fe:	38 c2                	cmp    %al,%dl
  801400:	74 da                	je     8013dc <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801402:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801406:	75 07                	jne    80140f <strncmp+0x38>
		return 0;
  801408:	b8 00 00 00 00       	mov    $0x0,%eax
  80140d:	eb 14                	jmp    801423 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	8a 00                	mov    (%eax),%al
  801414:	0f b6 d0             	movzbl %al,%edx
  801417:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141a:	8a 00                	mov    (%eax),%al
  80141c:	0f b6 c0             	movzbl %al,%eax
  80141f:	29 c2                	sub    %eax,%edx
  801421:	89 d0                	mov    %edx,%eax
}
  801423:	5d                   	pop    %ebp
  801424:	c3                   	ret    

00801425 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801425:	55                   	push   %ebp
  801426:	89 e5                	mov    %esp,%ebp
  801428:	83 ec 04             	sub    $0x4,%esp
  80142b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801431:	eb 12                	jmp    801445 <strchr+0x20>
		if (*s == c)
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
  801436:	8a 00                	mov    (%eax),%al
  801438:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80143b:	75 05                	jne    801442 <strchr+0x1d>
			return (char *) s;
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	eb 11                	jmp    801453 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801442:	ff 45 08             	incl   0x8(%ebp)
  801445:	8b 45 08             	mov    0x8(%ebp),%eax
  801448:	8a 00                	mov    (%eax),%al
  80144a:	84 c0                	test   %al,%al
  80144c:	75 e5                	jne    801433 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80144e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801453:	c9                   	leave  
  801454:	c3                   	ret    

00801455 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801455:	55                   	push   %ebp
  801456:	89 e5                	mov    %esp,%ebp
  801458:	83 ec 04             	sub    $0x4,%esp
  80145b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801461:	eb 0d                	jmp    801470 <strfind+0x1b>
		if (*s == c)
  801463:	8b 45 08             	mov    0x8(%ebp),%eax
  801466:	8a 00                	mov    (%eax),%al
  801468:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80146b:	74 0e                	je     80147b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80146d:	ff 45 08             	incl   0x8(%ebp)
  801470:	8b 45 08             	mov    0x8(%ebp),%eax
  801473:	8a 00                	mov    (%eax),%al
  801475:	84 c0                	test   %al,%al
  801477:	75 ea                	jne    801463 <strfind+0xe>
  801479:	eb 01                	jmp    80147c <strfind+0x27>
		if (*s == c)
			break;
  80147b:	90                   	nop
	return (char *) s;
  80147c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80147f:	c9                   	leave  
  801480:	c3                   	ret    

00801481 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
  801484:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801487:	8b 45 08             	mov    0x8(%ebp),%eax
  80148a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80148d:	8b 45 10             	mov    0x10(%ebp),%eax
  801490:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801493:	eb 0e                	jmp    8014a3 <memset+0x22>
		*p++ = c;
  801495:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801498:	8d 50 01             	lea    0x1(%eax),%edx
  80149b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80149e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014a1:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014a3:	ff 4d f8             	decl   -0x8(%ebp)
  8014a6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014aa:	79 e9                	jns    801495 <memset+0x14>
		*p++ = c;

	return v;
  8014ac:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014af:	c9                   	leave  
  8014b0:	c3                   	ret    

008014b1 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014b1:	55                   	push   %ebp
  8014b2:	89 e5                	mov    %esp,%ebp
  8014b4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8014c3:	eb 16                	jmp    8014db <memcpy+0x2a>
		*d++ = *s++;
  8014c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014c8:	8d 50 01             	lea    0x1(%eax),%edx
  8014cb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014ce:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014d1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014d4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014d7:	8a 12                	mov    (%edx),%dl
  8014d9:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014db:	8b 45 10             	mov    0x10(%ebp),%eax
  8014de:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014e1:	89 55 10             	mov    %edx,0x10(%ebp)
  8014e4:	85 c0                	test   %eax,%eax
  8014e6:	75 dd                	jne    8014c5 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014e8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014eb:	c9                   	leave  
  8014ec:	c3                   	ret    

008014ed <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014ed:	55                   	push   %ebp
  8014ee:	89 e5                	mov    %esp,%ebp
  8014f0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8014f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801502:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801505:	73 50                	jae    801557 <memmove+0x6a>
  801507:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80150a:	8b 45 10             	mov    0x10(%ebp),%eax
  80150d:	01 d0                	add    %edx,%eax
  80150f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801512:	76 43                	jbe    801557 <memmove+0x6a>
		s += n;
  801514:	8b 45 10             	mov    0x10(%ebp),%eax
  801517:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80151a:	8b 45 10             	mov    0x10(%ebp),%eax
  80151d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801520:	eb 10                	jmp    801532 <memmove+0x45>
			*--d = *--s;
  801522:	ff 4d f8             	decl   -0x8(%ebp)
  801525:	ff 4d fc             	decl   -0x4(%ebp)
  801528:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80152b:	8a 10                	mov    (%eax),%dl
  80152d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801530:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801532:	8b 45 10             	mov    0x10(%ebp),%eax
  801535:	8d 50 ff             	lea    -0x1(%eax),%edx
  801538:	89 55 10             	mov    %edx,0x10(%ebp)
  80153b:	85 c0                	test   %eax,%eax
  80153d:	75 e3                	jne    801522 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80153f:	eb 23                	jmp    801564 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801541:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801544:	8d 50 01             	lea    0x1(%eax),%edx
  801547:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80154a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80154d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801550:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801553:	8a 12                	mov    (%edx),%dl
  801555:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801557:	8b 45 10             	mov    0x10(%ebp),%eax
  80155a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80155d:	89 55 10             	mov    %edx,0x10(%ebp)
  801560:	85 c0                	test   %eax,%eax
  801562:	75 dd                	jne    801541 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801564:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801567:	c9                   	leave  
  801568:	c3                   	ret    

00801569 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801569:	55                   	push   %ebp
  80156a:	89 e5                	mov    %esp,%ebp
  80156c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80156f:	8b 45 08             	mov    0x8(%ebp),%eax
  801572:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801575:	8b 45 0c             	mov    0xc(%ebp),%eax
  801578:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80157b:	eb 2a                	jmp    8015a7 <memcmp+0x3e>
		if (*s1 != *s2)
  80157d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801580:	8a 10                	mov    (%eax),%dl
  801582:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801585:	8a 00                	mov    (%eax),%al
  801587:	38 c2                	cmp    %al,%dl
  801589:	74 16                	je     8015a1 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80158b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80158e:	8a 00                	mov    (%eax),%al
  801590:	0f b6 d0             	movzbl %al,%edx
  801593:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801596:	8a 00                	mov    (%eax),%al
  801598:	0f b6 c0             	movzbl %al,%eax
  80159b:	29 c2                	sub    %eax,%edx
  80159d:	89 d0                	mov    %edx,%eax
  80159f:	eb 18                	jmp    8015b9 <memcmp+0x50>
		s1++, s2++;
  8015a1:	ff 45 fc             	incl   -0x4(%ebp)
  8015a4:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015aa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015ad:	89 55 10             	mov    %edx,0x10(%ebp)
  8015b0:	85 c0                	test   %eax,%eax
  8015b2:	75 c9                	jne    80157d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b9:	c9                   	leave  
  8015ba:	c3                   	ret    

008015bb <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015bb:	55                   	push   %ebp
  8015bc:	89 e5                	mov    %esp,%ebp
  8015be:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015c1:	8b 55 08             	mov    0x8(%ebp),%edx
  8015c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c7:	01 d0                	add    %edx,%eax
  8015c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015cc:	eb 15                	jmp    8015e3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d1:	8a 00                	mov    (%eax),%al
  8015d3:	0f b6 d0             	movzbl %al,%edx
  8015d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d9:	0f b6 c0             	movzbl %al,%eax
  8015dc:	39 c2                	cmp    %eax,%edx
  8015de:	74 0d                	je     8015ed <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015e0:	ff 45 08             	incl   0x8(%ebp)
  8015e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015e9:	72 e3                	jb     8015ce <memfind+0x13>
  8015eb:	eb 01                	jmp    8015ee <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015ed:	90                   	nop
	return (void *) s;
  8015ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
  8015f6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801600:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801607:	eb 03                	jmp    80160c <strtol+0x19>
		s++;
  801609:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80160c:	8b 45 08             	mov    0x8(%ebp),%eax
  80160f:	8a 00                	mov    (%eax),%al
  801611:	3c 20                	cmp    $0x20,%al
  801613:	74 f4                	je     801609 <strtol+0x16>
  801615:	8b 45 08             	mov    0x8(%ebp),%eax
  801618:	8a 00                	mov    (%eax),%al
  80161a:	3c 09                	cmp    $0x9,%al
  80161c:	74 eb                	je     801609 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80161e:	8b 45 08             	mov    0x8(%ebp),%eax
  801621:	8a 00                	mov    (%eax),%al
  801623:	3c 2b                	cmp    $0x2b,%al
  801625:	75 05                	jne    80162c <strtol+0x39>
		s++;
  801627:	ff 45 08             	incl   0x8(%ebp)
  80162a:	eb 13                	jmp    80163f <strtol+0x4c>
	else if (*s == '-')
  80162c:	8b 45 08             	mov    0x8(%ebp),%eax
  80162f:	8a 00                	mov    (%eax),%al
  801631:	3c 2d                	cmp    $0x2d,%al
  801633:	75 0a                	jne    80163f <strtol+0x4c>
		s++, neg = 1;
  801635:	ff 45 08             	incl   0x8(%ebp)
  801638:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80163f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801643:	74 06                	je     80164b <strtol+0x58>
  801645:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801649:	75 20                	jne    80166b <strtol+0x78>
  80164b:	8b 45 08             	mov    0x8(%ebp),%eax
  80164e:	8a 00                	mov    (%eax),%al
  801650:	3c 30                	cmp    $0x30,%al
  801652:	75 17                	jne    80166b <strtol+0x78>
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	40                   	inc    %eax
  801658:	8a 00                	mov    (%eax),%al
  80165a:	3c 78                	cmp    $0x78,%al
  80165c:	75 0d                	jne    80166b <strtol+0x78>
		s += 2, base = 16;
  80165e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801662:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801669:	eb 28                	jmp    801693 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80166b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80166f:	75 15                	jne    801686 <strtol+0x93>
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	3c 30                	cmp    $0x30,%al
  801678:	75 0c                	jne    801686 <strtol+0x93>
		s++, base = 8;
  80167a:	ff 45 08             	incl   0x8(%ebp)
  80167d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801684:	eb 0d                	jmp    801693 <strtol+0xa0>
	else if (base == 0)
  801686:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80168a:	75 07                	jne    801693 <strtol+0xa0>
		base = 10;
  80168c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	8a 00                	mov    (%eax),%al
  801698:	3c 2f                	cmp    $0x2f,%al
  80169a:	7e 19                	jle    8016b5 <strtol+0xc2>
  80169c:	8b 45 08             	mov    0x8(%ebp),%eax
  80169f:	8a 00                	mov    (%eax),%al
  8016a1:	3c 39                	cmp    $0x39,%al
  8016a3:	7f 10                	jg     8016b5 <strtol+0xc2>
			dig = *s - '0';
  8016a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a8:	8a 00                	mov    (%eax),%al
  8016aa:	0f be c0             	movsbl %al,%eax
  8016ad:	83 e8 30             	sub    $0x30,%eax
  8016b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016b3:	eb 42                	jmp    8016f7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b8:	8a 00                	mov    (%eax),%al
  8016ba:	3c 60                	cmp    $0x60,%al
  8016bc:	7e 19                	jle    8016d7 <strtol+0xe4>
  8016be:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c1:	8a 00                	mov    (%eax),%al
  8016c3:	3c 7a                	cmp    $0x7a,%al
  8016c5:	7f 10                	jg     8016d7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ca:	8a 00                	mov    (%eax),%al
  8016cc:	0f be c0             	movsbl %al,%eax
  8016cf:	83 e8 57             	sub    $0x57,%eax
  8016d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016d5:	eb 20                	jmp    8016f7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016da:	8a 00                	mov    (%eax),%al
  8016dc:	3c 40                	cmp    $0x40,%al
  8016de:	7e 39                	jle    801719 <strtol+0x126>
  8016e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e3:	8a 00                	mov    (%eax),%al
  8016e5:	3c 5a                	cmp    $0x5a,%al
  8016e7:	7f 30                	jg     801719 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	8a 00                	mov    (%eax),%al
  8016ee:	0f be c0             	movsbl %al,%eax
  8016f1:	83 e8 37             	sub    $0x37,%eax
  8016f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016fa:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016fd:	7d 19                	jge    801718 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016ff:	ff 45 08             	incl   0x8(%ebp)
  801702:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801705:	0f af 45 10          	imul   0x10(%ebp),%eax
  801709:	89 c2                	mov    %eax,%edx
  80170b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80170e:	01 d0                	add    %edx,%eax
  801710:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801713:	e9 7b ff ff ff       	jmp    801693 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801718:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801719:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80171d:	74 08                	je     801727 <strtol+0x134>
		*endptr = (char *) s;
  80171f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801722:	8b 55 08             	mov    0x8(%ebp),%edx
  801725:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801727:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80172b:	74 07                	je     801734 <strtol+0x141>
  80172d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801730:	f7 d8                	neg    %eax
  801732:	eb 03                	jmp    801737 <strtol+0x144>
  801734:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801737:	c9                   	leave  
  801738:	c3                   	ret    

00801739 <ltostr>:

void
ltostr(long value, char *str)
{
  801739:	55                   	push   %ebp
  80173a:	89 e5                	mov    %esp,%ebp
  80173c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80173f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801746:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80174d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801751:	79 13                	jns    801766 <ltostr+0x2d>
	{
		neg = 1;
  801753:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80175a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801760:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801763:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801766:	8b 45 08             	mov    0x8(%ebp),%eax
  801769:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80176e:	99                   	cltd   
  80176f:	f7 f9                	idiv   %ecx
  801771:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801774:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801777:	8d 50 01             	lea    0x1(%eax),%edx
  80177a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80177d:	89 c2                	mov    %eax,%edx
  80177f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801782:	01 d0                	add    %edx,%eax
  801784:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801787:	83 c2 30             	add    $0x30,%edx
  80178a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80178c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80178f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801794:	f7 e9                	imul   %ecx
  801796:	c1 fa 02             	sar    $0x2,%edx
  801799:	89 c8                	mov    %ecx,%eax
  80179b:	c1 f8 1f             	sar    $0x1f,%eax
  80179e:	29 c2                	sub    %eax,%edx
  8017a0:	89 d0                	mov    %edx,%eax
  8017a2:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017a8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017ad:	f7 e9                	imul   %ecx
  8017af:	c1 fa 02             	sar    $0x2,%edx
  8017b2:	89 c8                	mov    %ecx,%eax
  8017b4:	c1 f8 1f             	sar    $0x1f,%eax
  8017b7:	29 c2                	sub    %eax,%edx
  8017b9:	89 d0                	mov    %edx,%eax
  8017bb:	c1 e0 02             	shl    $0x2,%eax
  8017be:	01 d0                	add    %edx,%eax
  8017c0:	01 c0                	add    %eax,%eax
  8017c2:	29 c1                	sub    %eax,%ecx
  8017c4:	89 ca                	mov    %ecx,%edx
  8017c6:	85 d2                	test   %edx,%edx
  8017c8:	75 9c                	jne    801766 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d4:	48                   	dec    %eax
  8017d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017d8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017dc:	74 3d                	je     80181b <ltostr+0xe2>
		start = 1 ;
  8017de:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017e5:	eb 34                	jmp    80181b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ed:	01 d0                	add    %edx,%eax
  8017ef:	8a 00                	mov    (%eax),%al
  8017f1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017fa:	01 c2                	add    %eax,%edx
  8017fc:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801802:	01 c8                	add    %ecx,%eax
  801804:	8a 00                	mov    (%eax),%al
  801806:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801808:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80180b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80180e:	01 c2                	add    %eax,%edx
  801810:	8a 45 eb             	mov    -0x15(%ebp),%al
  801813:	88 02                	mov    %al,(%edx)
		start++ ;
  801815:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801818:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80181b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80181e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801821:	7c c4                	jl     8017e7 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801823:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801826:	8b 45 0c             	mov    0xc(%ebp),%eax
  801829:	01 d0                	add    %edx,%eax
  80182b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80182e:	90                   	nop
  80182f:	c9                   	leave  
  801830:	c3                   	ret    

00801831 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801831:	55                   	push   %ebp
  801832:	89 e5                	mov    %esp,%ebp
  801834:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801837:	ff 75 08             	pushl  0x8(%ebp)
  80183a:	e8 54 fa ff ff       	call   801293 <strlen>
  80183f:	83 c4 04             	add    $0x4,%esp
  801842:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801845:	ff 75 0c             	pushl  0xc(%ebp)
  801848:	e8 46 fa ff ff       	call   801293 <strlen>
  80184d:	83 c4 04             	add    $0x4,%esp
  801850:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801853:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80185a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801861:	eb 17                	jmp    80187a <strcconcat+0x49>
		final[s] = str1[s] ;
  801863:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801866:	8b 45 10             	mov    0x10(%ebp),%eax
  801869:	01 c2                	add    %eax,%edx
  80186b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80186e:	8b 45 08             	mov    0x8(%ebp),%eax
  801871:	01 c8                	add    %ecx,%eax
  801873:	8a 00                	mov    (%eax),%al
  801875:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801877:	ff 45 fc             	incl   -0x4(%ebp)
  80187a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80187d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801880:	7c e1                	jl     801863 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801882:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801889:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801890:	eb 1f                	jmp    8018b1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801892:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801895:	8d 50 01             	lea    0x1(%eax),%edx
  801898:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80189b:	89 c2                	mov    %eax,%edx
  80189d:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a0:	01 c2                	add    %eax,%edx
  8018a2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a8:	01 c8                	add    %ecx,%eax
  8018aa:	8a 00                	mov    (%eax),%al
  8018ac:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018ae:	ff 45 f8             	incl   -0x8(%ebp)
  8018b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018b4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018b7:	7c d9                	jl     801892 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018b9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8018bf:	01 d0                	add    %edx,%eax
  8018c1:	c6 00 00             	movb   $0x0,(%eax)
}
  8018c4:	90                   	nop
  8018c5:	c9                   	leave  
  8018c6:	c3                   	ret    

008018c7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018c7:	55                   	push   %ebp
  8018c8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8018cd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8018d6:	8b 00                	mov    (%eax),%eax
  8018d8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018df:	8b 45 10             	mov    0x10(%ebp),%eax
  8018e2:	01 d0                	add    %edx,%eax
  8018e4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018ea:	eb 0c                	jmp    8018f8 <strsplit+0x31>
			*string++ = 0;
  8018ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ef:	8d 50 01             	lea    0x1(%eax),%edx
  8018f2:	89 55 08             	mov    %edx,0x8(%ebp)
  8018f5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fb:	8a 00                	mov    (%eax),%al
  8018fd:	84 c0                	test   %al,%al
  8018ff:	74 18                	je     801919 <strsplit+0x52>
  801901:	8b 45 08             	mov    0x8(%ebp),%eax
  801904:	8a 00                	mov    (%eax),%al
  801906:	0f be c0             	movsbl %al,%eax
  801909:	50                   	push   %eax
  80190a:	ff 75 0c             	pushl  0xc(%ebp)
  80190d:	e8 13 fb ff ff       	call   801425 <strchr>
  801912:	83 c4 08             	add    $0x8,%esp
  801915:	85 c0                	test   %eax,%eax
  801917:	75 d3                	jne    8018ec <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801919:	8b 45 08             	mov    0x8(%ebp),%eax
  80191c:	8a 00                	mov    (%eax),%al
  80191e:	84 c0                	test   %al,%al
  801920:	74 5a                	je     80197c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801922:	8b 45 14             	mov    0x14(%ebp),%eax
  801925:	8b 00                	mov    (%eax),%eax
  801927:	83 f8 0f             	cmp    $0xf,%eax
  80192a:	75 07                	jne    801933 <strsplit+0x6c>
		{
			return 0;
  80192c:	b8 00 00 00 00       	mov    $0x0,%eax
  801931:	eb 66                	jmp    801999 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801933:	8b 45 14             	mov    0x14(%ebp),%eax
  801936:	8b 00                	mov    (%eax),%eax
  801938:	8d 48 01             	lea    0x1(%eax),%ecx
  80193b:	8b 55 14             	mov    0x14(%ebp),%edx
  80193e:	89 0a                	mov    %ecx,(%edx)
  801940:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801947:	8b 45 10             	mov    0x10(%ebp),%eax
  80194a:	01 c2                	add    %eax,%edx
  80194c:	8b 45 08             	mov    0x8(%ebp),%eax
  80194f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801951:	eb 03                	jmp    801956 <strsplit+0x8f>
			string++;
  801953:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801956:	8b 45 08             	mov    0x8(%ebp),%eax
  801959:	8a 00                	mov    (%eax),%al
  80195b:	84 c0                	test   %al,%al
  80195d:	74 8b                	je     8018ea <strsplit+0x23>
  80195f:	8b 45 08             	mov    0x8(%ebp),%eax
  801962:	8a 00                	mov    (%eax),%al
  801964:	0f be c0             	movsbl %al,%eax
  801967:	50                   	push   %eax
  801968:	ff 75 0c             	pushl  0xc(%ebp)
  80196b:	e8 b5 fa ff ff       	call   801425 <strchr>
  801970:	83 c4 08             	add    $0x8,%esp
  801973:	85 c0                	test   %eax,%eax
  801975:	74 dc                	je     801953 <strsplit+0x8c>
			string++;
	}
  801977:	e9 6e ff ff ff       	jmp    8018ea <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80197c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80197d:	8b 45 14             	mov    0x14(%ebp),%eax
  801980:	8b 00                	mov    (%eax),%eax
  801982:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801989:	8b 45 10             	mov    0x10(%ebp),%eax
  80198c:	01 d0                	add    %edx,%eax
  80198e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801994:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801999:	c9                   	leave  
  80199a:	c3                   	ret    

0080199b <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80199b:	55                   	push   %ebp
  80199c:	89 e5                	mov    %esp,%ebp
  80199e:	83 ec 18             	sub    $0x18,%esp
  8019a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a4:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8019a7:	83 ec 04             	sub    $0x4,%esp
  8019aa:	68 e4 2b 80 00       	push   $0x802be4
  8019af:	6a 17                	push   $0x17
  8019b1:	68 03 2c 80 00       	push   $0x802c03
  8019b6:	e8 9c ed ff ff       	call   800757 <_panic>

008019bb <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8019bb:	55                   	push   %ebp
  8019bc:	89 e5                	mov    %esp,%ebp
  8019be:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8019c1:	83 ec 04             	sub    $0x4,%esp
  8019c4:	68 0f 2c 80 00       	push   $0x802c0f
  8019c9:	6a 2f                	push   $0x2f
  8019cb:	68 03 2c 80 00       	push   $0x802c03
  8019d0:	e8 82 ed ff ff       	call   800757 <_panic>

008019d5 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8019d5:	55                   	push   %ebp
  8019d6:	89 e5                	mov    %esp,%ebp
  8019d8:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8019db:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8019e2:	8b 55 08             	mov    0x8(%ebp),%edx
  8019e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019e8:	01 d0                	add    %edx,%eax
  8019ea:	48                   	dec    %eax
  8019eb:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8019ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019f1:	ba 00 00 00 00       	mov    $0x0,%edx
  8019f6:	f7 75 ec             	divl   -0x14(%ebp)
  8019f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019fc:	29 d0                	sub    %edx,%eax
  8019fe:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801a01:	8b 45 08             	mov    0x8(%ebp),%eax
  801a04:	c1 e8 0c             	shr    $0xc,%eax
  801a07:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801a0a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801a11:	e9 c8 00 00 00       	jmp    801ade <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801a16:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a1d:	eb 27                	jmp    801a46 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801a1f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a25:	01 c2                	add    %eax,%edx
  801a27:	89 d0                	mov    %edx,%eax
  801a29:	01 c0                	add    %eax,%eax
  801a2b:	01 d0                	add    %edx,%eax
  801a2d:	c1 e0 02             	shl    $0x2,%eax
  801a30:	05 48 30 80 00       	add    $0x803048,%eax
  801a35:	8b 00                	mov    (%eax),%eax
  801a37:	85 c0                	test   %eax,%eax
  801a39:	74 08                	je     801a43 <malloc+0x6e>
            	i += j;
  801a3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a3e:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801a41:	eb 0b                	jmp    801a4e <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801a43:	ff 45 f0             	incl   -0x10(%ebp)
  801a46:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a49:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a4c:	72 d1                	jb     801a1f <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801a4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a51:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a54:	0f 85 81 00 00 00    	jne    801adb <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801a5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a5d:	05 00 00 08 00       	add    $0x80000,%eax
  801a62:	c1 e0 0c             	shl    $0xc,%eax
  801a65:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801a68:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a6f:	eb 1f                	jmp    801a90 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801a71:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a74:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a77:	01 c2                	add    %eax,%edx
  801a79:	89 d0                	mov    %edx,%eax
  801a7b:	01 c0                	add    %eax,%eax
  801a7d:	01 d0                	add    %edx,%eax
  801a7f:	c1 e0 02             	shl    $0x2,%eax
  801a82:	05 48 30 80 00       	add    $0x803048,%eax
  801a87:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801a8d:	ff 45 f0             	incl   -0x10(%ebp)
  801a90:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a93:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a96:	72 d9                	jb     801a71 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801a98:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a9b:	89 d0                	mov    %edx,%eax
  801a9d:	01 c0                	add    %eax,%eax
  801a9f:	01 d0                	add    %edx,%eax
  801aa1:	c1 e0 02             	shl    $0x2,%eax
  801aa4:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801aaa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801aad:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801aaf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801ab2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801ab5:	89 c8                	mov    %ecx,%eax
  801ab7:	01 c0                	add    %eax,%eax
  801ab9:	01 c8                	add    %ecx,%eax
  801abb:	c1 e0 02             	shl    $0x2,%eax
  801abe:	05 44 30 80 00       	add    $0x803044,%eax
  801ac3:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801ac5:	83 ec 08             	sub    $0x8,%esp
  801ac8:	ff 75 08             	pushl  0x8(%ebp)
  801acb:	ff 75 e0             	pushl  -0x20(%ebp)
  801ace:	e8 2b 03 00 00       	call   801dfe <sys_allocateMem>
  801ad3:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801ad6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ad9:	eb 19                	jmp    801af4 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801adb:	ff 45 f4             	incl   -0xc(%ebp)
  801ade:	a1 04 30 80 00       	mov    0x803004,%eax
  801ae3:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801ae6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801ae9:	0f 83 27 ff ff ff    	jae    801a16 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801aef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801af4:	c9                   	leave  
  801af5:	c3                   	ret    

00801af6 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801af6:	55                   	push   %ebp
  801af7:	89 e5                	mov    %esp,%ebp
  801af9:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801afc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801b00:	0f 84 e5 00 00 00    	je     801beb <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801b06:	8b 45 08             	mov    0x8(%ebp),%eax
  801b09:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801b0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b0f:	05 00 00 00 80       	add    $0x80000000,%eax
  801b14:	c1 e8 0c             	shr    $0xc,%eax
  801b17:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801b1a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b1d:	89 d0                	mov    %edx,%eax
  801b1f:	01 c0                	add    %eax,%eax
  801b21:	01 d0                	add    %edx,%eax
  801b23:	c1 e0 02             	shl    $0x2,%eax
  801b26:	05 40 30 80 00       	add    $0x803040,%eax
  801b2b:	8b 00                	mov    (%eax),%eax
  801b2d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b30:	0f 85 b8 00 00 00    	jne    801bee <free+0xf8>
  801b36:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b39:	89 d0                	mov    %edx,%eax
  801b3b:	01 c0                	add    %eax,%eax
  801b3d:	01 d0                	add    %edx,%eax
  801b3f:	c1 e0 02             	shl    $0x2,%eax
  801b42:	05 48 30 80 00       	add    $0x803048,%eax
  801b47:	8b 00                	mov    (%eax),%eax
  801b49:	85 c0                	test   %eax,%eax
  801b4b:	0f 84 9d 00 00 00    	je     801bee <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801b51:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b54:	89 d0                	mov    %edx,%eax
  801b56:	01 c0                	add    %eax,%eax
  801b58:	01 d0                	add    %edx,%eax
  801b5a:	c1 e0 02             	shl    $0x2,%eax
  801b5d:	05 44 30 80 00       	add    $0x803044,%eax
  801b62:	8b 00                	mov    (%eax),%eax
  801b64:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801b67:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b6a:	c1 e0 0c             	shl    $0xc,%eax
  801b6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801b70:	83 ec 08             	sub    $0x8,%esp
  801b73:	ff 75 e4             	pushl  -0x1c(%ebp)
  801b76:	ff 75 f0             	pushl  -0x10(%ebp)
  801b79:	e8 64 02 00 00       	call   801de2 <sys_freeMem>
  801b7e:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801b81:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b88:	eb 57                	jmp    801be1 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801b8a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b90:	01 c2                	add    %eax,%edx
  801b92:	89 d0                	mov    %edx,%eax
  801b94:	01 c0                	add    %eax,%eax
  801b96:	01 d0                	add    %edx,%eax
  801b98:	c1 e0 02             	shl    $0x2,%eax
  801b9b:	05 48 30 80 00       	add    $0x803048,%eax
  801ba0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801ba6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ba9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bac:	01 c2                	add    %eax,%edx
  801bae:	89 d0                	mov    %edx,%eax
  801bb0:	01 c0                	add    %eax,%eax
  801bb2:	01 d0                	add    %edx,%eax
  801bb4:	c1 e0 02             	shl    $0x2,%eax
  801bb7:	05 40 30 80 00       	add    $0x803040,%eax
  801bbc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801bc2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801bc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bc8:	01 c2                	add    %eax,%edx
  801bca:	89 d0                	mov    %edx,%eax
  801bcc:	01 c0                	add    %eax,%eax
  801bce:	01 d0                	add    %edx,%eax
  801bd0:	c1 e0 02             	shl    $0x2,%eax
  801bd3:	05 44 30 80 00       	add    $0x803044,%eax
  801bd8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801bde:	ff 45 f4             	incl   -0xc(%ebp)
  801be1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801be4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801be7:	7c a1                	jl     801b8a <free+0x94>
  801be9:	eb 04                	jmp    801bef <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801beb:	90                   	nop
  801bec:	eb 01                	jmp    801bef <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801bee:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801bef:	c9                   	leave  
  801bf0:	c3                   	ret    

00801bf1 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801bf1:	55                   	push   %ebp
  801bf2:	89 e5                	mov    %esp,%ebp
  801bf4:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801bf7:	83 ec 04             	sub    $0x4,%esp
  801bfa:	68 2c 2c 80 00       	push   $0x802c2c
  801bff:	68 ae 00 00 00       	push   $0xae
  801c04:	68 03 2c 80 00       	push   $0x802c03
  801c09:	e8 49 eb ff ff       	call   800757 <_panic>

00801c0e <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801c0e:	55                   	push   %ebp
  801c0f:	89 e5                	mov    %esp,%ebp
  801c11:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801c14:	83 ec 04             	sub    $0x4,%esp
  801c17:	68 4c 2c 80 00       	push   $0x802c4c
  801c1c:	68 ca 00 00 00       	push   $0xca
  801c21:	68 03 2c 80 00       	push   $0x802c03
  801c26:	e8 2c eb ff ff       	call   800757 <_panic>

00801c2b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c2b:	55                   	push   %ebp
  801c2c:	89 e5                	mov    %esp,%ebp
  801c2e:	57                   	push   %edi
  801c2f:	56                   	push   %esi
  801c30:	53                   	push   %ebx
  801c31:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c34:	8b 45 08             	mov    0x8(%ebp),%eax
  801c37:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c3a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c3d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c40:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c43:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c46:	cd 30                	int    $0x30
  801c48:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c4e:	83 c4 10             	add    $0x10,%esp
  801c51:	5b                   	pop    %ebx
  801c52:	5e                   	pop    %esi
  801c53:	5f                   	pop    %edi
  801c54:	5d                   	pop    %ebp
  801c55:	c3                   	ret    

00801c56 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c56:	55                   	push   %ebp
  801c57:	89 e5                	mov    %esp,%ebp
  801c59:	83 ec 04             	sub    $0x4,%esp
  801c5c:	8b 45 10             	mov    0x10(%ebp),%eax
  801c5f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c62:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c66:	8b 45 08             	mov    0x8(%ebp),%eax
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	52                   	push   %edx
  801c6e:	ff 75 0c             	pushl  0xc(%ebp)
  801c71:	50                   	push   %eax
  801c72:	6a 00                	push   $0x0
  801c74:	e8 b2 ff ff ff       	call   801c2b <syscall>
  801c79:	83 c4 18             	add    $0x18,%esp
}
  801c7c:	90                   	nop
  801c7d:	c9                   	leave  
  801c7e:	c3                   	ret    

00801c7f <sys_cgetc>:

int
sys_cgetc(void)
{
  801c7f:	55                   	push   %ebp
  801c80:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c82:	6a 00                	push   $0x0
  801c84:	6a 00                	push   $0x0
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 01                	push   $0x1
  801c8e:	e8 98 ff ff ff       	call   801c2b <syscall>
  801c93:	83 c4 18             	add    $0x18,%esp
}
  801c96:	c9                   	leave  
  801c97:	c3                   	ret    

00801c98 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c98:	55                   	push   %ebp
  801c99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	50                   	push   %eax
  801ca7:	6a 05                	push   $0x5
  801ca9:	e8 7d ff ff ff       	call   801c2b <syscall>
  801cae:	83 c4 18             	add    $0x18,%esp
}
  801cb1:	c9                   	leave  
  801cb2:	c3                   	ret    

00801cb3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801cb3:	55                   	push   %ebp
  801cb4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 02                	push   $0x2
  801cc2:	e8 64 ff ff ff       	call   801c2b <syscall>
  801cc7:	83 c4 18             	add    $0x18,%esp
}
  801cca:	c9                   	leave  
  801ccb:	c3                   	ret    

00801ccc <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ccc:	55                   	push   %ebp
  801ccd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 03                	push   $0x3
  801cdb:	e8 4b ff ff ff       	call   801c2b <syscall>
  801ce0:	83 c4 18             	add    $0x18,%esp
}
  801ce3:	c9                   	leave  
  801ce4:	c3                   	ret    

00801ce5 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ce5:	55                   	push   %ebp
  801ce6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 04                	push   $0x4
  801cf4:	e8 32 ff ff ff       	call   801c2b <syscall>
  801cf9:	83 c4 18             	add    $0x18,%esp
}
  801cfc:	c9                   	leave  
  801cfd:	c3                   	ret    

00801cfe <sys_env_exit>:


void sys_env_exit(void)
{
  801cfe:	55                   	push   %ebp
  801cff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 06                	push   $0x6
  801d0d:	e8 19 ff ff ff       	call   801c2b <syscall>
  801d12:	83 c4 18             	add    $0x18,%esp
}
  801d15:	90                   	nop
  801d16:	c9                   	leave  
  801d17:	c3                   	ret    

00801d18 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d18:	55                   	push   %ebp
  801d19:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d21:	6a 00                	push   $0x0
  801d23:	6a 00                	push   $0x0
  801d25:	6a 00                	push   $0x0
  801d27:	52                   	push   %edx
  801d28:	50                   	push   %eax
  801d29:	6a 07                	push   $0x7
  801d2b:	e8 fb fe ff ff       	call   801c2b <syscall>
  801d30:	83 c4 18             	add    $0x18,%esp
}
  801d33:	c9                   	leave  
  801d34:	c3                   	ret    

00801d35 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d35:	55                   	push   %ebp
  801d36:	89 e5                	mov    %esp,%ebp
  801d38:	56                   	push   %esi
  801d39:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d3a:	8b 75 18             	mov    0x18(%ebp),%esi
  801d3d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d40:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d43:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d46:	8b 45 08             	mov    0x8(%ebp),%eax
  801d49:	56                   	push   %esi
  801d4a:	53                   	push   %ebx
  801d4b:	51                   	push   %ecx
  801d4c:	52                   	push   %edx
  801d4d:	50                   	push   %eax
  801d4e:	6a 08                	push   $0x8
  801d50:	e8 d6 fe ff ff       	call   801c2b <syscall>
  801d55:	83 c4 18             	add    $0x18,%esp
}
  801d58:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d5b:	5b                   	pop    %ebx
  801d5c:	5e                   	pop    %esi
  801d5d:	5d                   	pop    %ebp
  801d5e:	c3                   	ret    

00801d5f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d5f:	55                   	push   %ebp
  801d60:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d62:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d65:	8b 45 08             	mov    0x8(%ebp),%eax
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	52                   	push   %edx
  801d6f:	50                   	push   %eax
  801d70:	6a 09                	push   $0x9
  801d72:	e8 b4 fe ff ff       	call   801c2b <syscall>
  801d77:	83 c4 18             	add    $0x18,%esp
}
  801d7a:	c9                   	leave  
  801d7b:	c3                   	ret    

00801d7c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d7c:	55                   	push   %ebp
  801d7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	ff 75 0c             	pushl  0xc(%ebp)
  801d88:	ff 75 08             	pushl  0x8(%ebp)
  801d8b:	6a 0a                	push   $0xa
  801d8d:	e8 99 fe ff ff       	call   801c2b <syscall>
  801d92:	83 c4 18             	add    $0x18,%esp
}
  801d95:	c9                   	leave  
  801d96:	c3                   	ret    

00801d97 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d97:	55                   	push   %ebp
  801d98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 0b                	push   $0xb
  801da6:	e8 80 fe ff ff       	call   801c2b <syscall>
  801dab:	83 c4 18             	add    $0x18,%esp
}
  801dae:	c9                   	leave  
  801daf:	c3                   	ret    

00801db0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801db0:	55                   	push   %ebp
  801db1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 0c                	push   $0xc
  801dbf:	e8 67 fe ff ff       	call   801c2b <syscall>
  801dc4:	83 c4 18             	add    $0x18,%esp
}
  801dc7:	c9                   	leave  
  801dc8:	c3                   	ret    

00801dc9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801dc9:	55                   	push   %ebp
  801dca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 0d                	push   $0xd
  801dd8:	e8 4e fe ff ff       	call   801c2b <syscall>
  801ddd:	83 c4 18             	add    $0x18,%esp
}
  801de0:	c9                   	leave  
  801de1:	c3                   	ret    

00801de2 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801de2:	55                   	push   %ebp
  801de3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	ff 75 0c             	pushl  0xc(%ebp)
  801dee:	ff 75 08             	pushl  0x8(%ebp)
  801df1:	6a 11                	push   $0x11
  801df3:	e8 33 fe ff ff       	call   801c2b <syscall>
  801df8:	83 c4 18             	add    $0x18,%esp
	return;
  801dfb:	90                   	nop
}
  801dfc:	c9                   	leave  
  801dfd:	c3                   	ret    

00801dfe <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801dfe:	55                   	push   %ebp
  801dff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e01:	6a 00                	push   $0x0
  801e03:	6a 00                	push   $0x0
  801e05:	6a 00                	push   $0x0
  801e07:	ff 75 0c             	pushl  0xc(%ebp)
  801e0a:	ff 75 08             	pushl  0x8(%ebp)
  801e0d:	6a 12                	push   $0x12
  801e0f:	e8 17 fe ff ff       	call   801c2b <syscall>
  801e14:	83 c4 18             	add    $0x18,%esp
	return ;
  801e17:	90                   	nop
}
  801e18:	c9                   	leave  
  801e19:	c3                   	ret    

00801e1a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e1a:	55                   	push   %ebp
  801e1b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 0e                	push   $0xe
  801e29:	e8 fd fd ff ff       	call   801c2b <syscall>
  801e2e:	83 c4 18             	add    $0x18,%esp
}
  801e31:	c9                   	leave  
  801e32:	c3                   	ret    

00801e33 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e33:	55                   	push   %ebp
  801e34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e36:	6a 00                	push   $0x0
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	ff 75 08             	pushl  0x8(%ebp)
  801e41:	6a 0f                	push   $0xf
  801e43:	e8 e3 fd ff ff       	call   801c2b <syscall>
  801e48:	83 c4 18             	add    $0x18,%esp
}
  801e4b:	c9                   	leave  
  801e4c:	c3                   	ret    

00801e4d <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e4d:	55                   	push   %ebp
  801e4e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 10                	push   $0x10
  801e5c:	e8 ca fd ff ff       	call   801c2b <syscall>
  801e61:	83 c4 18             	add    $0x18,%esp
}
  801e64:	90                   	nop
  801e65:	c9                   	leave  
  801e66:	c3                   	ret    

00801e67 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e67:	55                   	push   %ebp
  801e68:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e6a:	6a 00                	push   $0x0
  801e6c:	6a 00                	push   $0x0
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 14                	push   $0x14
  801e76:	e8 b0 fd ff ff       	call   801c2b <syscall>
  801e7b:	83 c4 18             	add    $0x18,%esp
}
  801e7e:	90                   	nop
  801e7f:	c9                   	leave  
  801e80:	c3                   	ret    

00801e81 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e81:	55                   	push   %ebp
  801e82:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e84:	6a 00                	push   $0x0
  801e86:	6a 00                	push   $0x0
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 15                	push   $0x15
  801e90:	e8 96 fd ff ff       	call   801c2b <syscall>
  801e95:	83 c4 18             	add    $0x18,%esp
}
  801e98:	90                   	nop
  801e99:	c9                   	leave  
  801e9a:	c3                   	ret    

00801e9b <sys_cputc>:


void
sys_cputc(const char c)
{
  801e9b:	55                   	push   %ebp
  801e9c:	89 e5                	mov    %esp,%ebp
  801e9e:	83 ec 04             	sub    $0x4,%esp
  801ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ea7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	50                   	push   %eax
  801eb4:	6a 16                	push   $0x16
  801eb6:	e8 70 fd ff ff       	call   801c2b <syscall>
  801ebb:	83 c4 18             	add    $0x18,%esp
}
  801ebe:	90                   	nop
  801ebf:	c9                   	leave  
  801ec0:	c3                   	ret    

00801ec1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ec1:	55                   	push   %ebp
  801ec2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 00                	push   $0x0
  801ece:	6a 17                	push   $0x17
  801ed0:	e8 56 fd ff ff       	call   801c2b <syscall>
  801ed5:	83 c4 18             	add    $0x18,%esp
}
  801ed8:	90                   	nop
  801ed9:	c9                   	leave  
  801eda:	c3                   	ret    

00801edb <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801edb:	55                   	push   %ebp
  801edc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ede:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 00                	push   $0x0
  801ee5:	6a 00                	push   $0x0
  801ee7:	ff 75 0c             	pushl  0xc(%ebp)
  801eea:	50                   	push   %eax
  801eeb:	6a 18                	push   $0x18
  801eed:	e8 39 fd ff ff       	call   801c2b <syscall>
  801ef2:	83 c4 18             	add    $0x18,%esp
}
  801ef5:	c9                   	leave  
  801ef6:	c3                   	ret    

00801ef7 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ef7:	55                   	push   %ebp
  801ef8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801efa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801efd:	8b 45 08             	mov    0x8(%ebp),%eax
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	52                   	push   %edx
  801f07:	50                   	push   %eax
  801f08:	6a 1b                	push   $0x1b
  801f0a:	e8 1c fd ff ff       	call   801c2b <syscall>
  801f0f:	83 c4 18             	add    $0x18,%esp
}
  801f12:	c9                   	leave  
  801f13:	c3                   	ret    

00801f14 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f14:	55                   	push   %ebp
  801f15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f17:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 00                	push   $0x0
  801f23:	52                   	push   %edx
  801f24:	50                   	push   %eax
  801f25:	6a 19                	push   $0x19
  801f27:	e8 ff fc ff ff       	call   801c2b <syscall>
  801f2c:	83 c4 18             	add    $0x18,%esp
}
  801f2f:	90                   	nop
  801f30:	c9                   	leave  
  801f31:	c3                   	ret    

00801f32 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f32:	55                   	push   %ebp
  801f33:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f35:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f38:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	6a 00                	push   $0x0
  801f41:	52                   	push   %edx
  801f42:	50                   	push   %eax
  801f43:	6a 1a                	push   $0x1a
  801f45:	e8 e1 fc ff ff       	call   801c2b <syscall>
  801f4a:	83 c4 18             	add    $0x18,%esp
}
  801f4d:	90                   	nop
  801f4e:	c9                   	leave  
  801f4f:	c3                   	ret    

00801f50 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f50:	55                   	push   %ebp
  801f51:	89 e5                	mov    %esp,%ebp
  801f53:	83 ec 04             	sub    $0x4,%esp
  801f56:	8b 45 10             	mov    0x10(%ebp),%eax
  801f59:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f5c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f5f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f63:	8b 45 08             	mov    0x8(%ebp),%eax
  801f66:	6a 00                	push   $0x0
  801f68:	51                   	push   %ecx
  801f69:	52                   	push   %edx
  801f6a:	ff 75 0c             	pushl  0xc(%ebp)
  801f6d:	50                   	push   %eax
  801f6e:	6a 1c                	push   $0x1c
  801f70:	e8 b6 fc ff ff       	call   801c2b <syscall>
  801f75:	83 c4 18             	add    $0x18,%esp
}
  801f78:	c9                   	leave  
  801f79:	c3                   	ret    

00801f7a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f7a:	55                   	push   %ebp
  801f7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f80:	8b 45 08             	mov    0x8(%ebp),%eax
  801f83:	6a 00                	push   $0x0
  801f85:	6a 00                	push   $0x0
  801f87:	6a 00                	push   $0x0
  801f89:	52                   	push   %edx
  801f8a:	50                   	push   %eax
  801f8b:	6a 1d                	push   $0x1d
  801f8d:	e8 99 fc ff ff       	call   801c2b <syscall>
  801f92:	83 c4 18             	add    $0x18,%esp
}
  801f95:	c9                   	leave  
  801f96:	c3                   	ret    

00801f97 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f97:	55                   	push   %ebp
  801f98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f9a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f9d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fa0:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa3:	6a 00                	push   $0x0
  801fa5:	6a 00                	push   $0x0
  801fa7:	51                   	push   %ecx
  801fa8:	52                   	push   %edx
  801fa9:	50                   	push   %eax
  801faa:	6a 1e                	push   $0x1e
  801fac:	e8 7a fc ff ff       	call   801c2b <syscall>
  801fb1:	83 c4 18             	add    $0x18,%esp
}
  801fb4:	c9                   	leave  
  801fb5:	c3                   	ret    

00801fb6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801fb6:	55                   	push   %ebp
  801fb7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801fb9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	52                   	push   %edx
  801fc6:	50                   	push   %eax
  801fc7:	6a 1f                	push   $0x1f
  801fc9:	e8 5d fc ff ff       	call   801c2b <syscall>
  801fce:	83 c4 18             	add    $0x18,%esp
}
  801fd1:	c9                   	leave  
  801fd2:	c3                   	ret    

00801fd3 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801fd3:	55                   	push   %ebp
  801fd4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 00                	push   $0x0
  801fe0:	6a 20                	push   $0x20
  801fe2:	e8 44 fc ff ff       	call   801c2b <syscall>
  801fe7:	83 c4 18             	add    $0x18,%esp
}
  801fea:	c9                   	leave  
  801feb:	c3                   	ret    

00801fec <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801fec:	55                   	push   %ebp
  801fed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801fef:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 00                	push   $0x0
  801ff6:	ff 75 10             	pushl  0x10(%ebp)
  801ff9:	ff 75 0c             	pushl  0xc(%ebp)
  801ffc:	50                   	push   %eax
  801ffd:	6a 21                	push   $0x21
  801fff:	e8 27 fc ff ff       	call   801c2b <syscall>
  802004:	83 c4 18             	add    $0x18,%esp
}
  802007:	c9                   	leave  
  802008:	c3                   	ret    

00802009 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802009:	55                   	push   %ebp
  80200a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80200c:	8b 45 08             	mov    0x8(%ebp),%eax
  80200f:	6a 00                	push   $0x0
  802011:	6a 00                	push   $0x0
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	50                   	push   %eax
  802018:	6a 22                	push   $0x22
  80201a:	e8 0c fc ff ff       	call   801c2b <syscall>
  80201f:	83 c4 18             	add    $0x18,%esp
}
  802022:	90                   	nop
  802023:	c9                   	leave  
  802024:	c3                   	ret    

00802025 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802025:	55                   	push   %ebp
  802026:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802028:	8b 45 08             	mov    0x8(%ebp),%eax
  80202b:	6a 00                	push   $0x0
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	50                   	push   %eax
  802034:	6a 23                	push   $0x23
  802036:	e8 f0 fb ff ff       	call   801c2b <syscall>
  80203b:	83 c4 18             	add    $0x18,%esp
}
  80203e:	90                   	nop
  80203f:	c9                   	leave  
  802040:	c3                   	ret    

00802041 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802041:	55                   	push   %ebp
  802042:	89 e5                	mov    %esp,%ebp
  802044:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802047:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80204a:	8d 50 04             	lea    0x4(%eax),%edx
  80204d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802050:	6a 00                	push   $0x0
  802052:	6a 00                	push   $0x0
  802054:	6a 00                	push   $0x0
  802056:	52                   	push   %edx
  802057:	50                   	push   %eax
  802058:	6a 24                	push   $0x24
  80205a:	e8 cc fb ff ff       	call   801c2b <syscall>
  80205f:	83 c4 18             	add    $0x18,%esp
	return result;
  802062:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802065:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802068:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80206b:	89 01                	mov    %eax,(%ecx)
  80206d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802070:	8b 45 08             	mov    0x8(%ebp),%eax
  802073:	c9                   	leave  
  802074:	c2 04 00             	ret    $0x4

00802077 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802077:	55                   	push   %ebp
  802078:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80207a:	6a 00                	push   $0x0
  80207c:	6a 00                	push   $0x0
  80207e:	ff 75 10             	pushl  0x10(%ebp)
  802081:	ff 75 0c             	pushl  0xc(%ebp)
  802084:	ff 75 08             	pushl  0x8(%ebp)
  802087:	6a 13                	push   $0x13
  802089:	e8 9d fb ff ff       	call   801c2b <syscall>
  80208e:	83 c4 18             	add    $0x18,%esp
	return ;
  802091:	90                   	nop
}
  802092:	c9                   	leave  
  802093:	c3                   	ret    

00802094 <sys_rcr2>:
uint32 sys_rcr2()
{
  802094:	55                   	push   %ebp
  802095:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802097:	6a 00                	push   $0x0
  802099:	6a 00                	push   $0x0
  80209b:	6a 00                	push   $0x0
  80209d:	6a 00                	push   $0x0
  80209f:	6a 00                	push   $0x0
  8020a1:	6a 25                	push   $0x25
  8020a3:	e8 83 fb ff ff       	call   801c2b <syscall>
  8020a8:	83 c4 18             	add    $0x18,%esp
}
  8020ab:	c9                   	leave  
  8020ac:	c3                   	ret    

008020ad <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8020ad:	55                   	push   %ebp
  8020ae:	89 e5                	mov    %esp,%ebp
  8020b0:	83 ec 04             	sub    $0x4,%esp
  8020b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020b9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	6a 00                	push   $0x0
  8020c3:	6a 00                	push   $0x0
  8020c5:	50                   	push   %eax
  8020c6:	6a 26                	push   $0x26
  8020c8:	e8 5e fb ff ff       	call   801c2b <syscall>
  8020cd:	83 c4 18             	add    $0x18,%esp
	return ;
  8020d0:	90                   	nop
}
  8020d1:	c9                   	leave  
  8020d2:	c3                   	ret    

008020d3 <rsttst>:
void rsttst()
{
  8020d3:	55                   	push   %ebp
  8020d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020d6:	6a 00                	push   $0x0
  8020d8:	6a 00                	push   $0x0
  8020da:	6a 00                	push   $0x0
  8020dc:	6a 00                	push   $0x0
  8020de:	6a 00                	push   $0x0
  8020e0:	6a 28                	push   $0x28
  8020e2:	e8 44 fb ff ff       	call   801c2b <syscall>
  8020e7:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ea:	90                   	nop
}
  8020eb:	c9                   	leave  
  8020ec:	c3                   	ret    

008020ed <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020ed:	55                   	push   %ebp
  8020ee:	89 e5                	mov    %esp,%ebp
  8020f0:	83 ec 04             	sub    $0x4,%esp
  8020f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8020f6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8020f9:	8b 55 18             	mov    0x18(%ebp),%edx
  8020fc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802100:	52                   	push   %edx
  802101:	50                   	push   %eax
  802102:	ff 75 10             	pushl  0x10(%ebp)
  802105:	ff 75 0c             	pushl  0xc(%ebp)
  802108:	ff 75 08             	pushl  0x8(%ebp)
  80210b:	6a 27                	push   $0x27
  80210d:	e8 19 fb ff ff       	call   801c2b <syscall>
  802112:	83 c4 18             	add    $0x18,%esp
	return ;
  802115:	90                   	nop
}
  802116:	c9                   	leave  
  802117:	c3                   	ret    

00802118 <chktst>:
void chktst(uint32 n)
{
  802118:	55                   	push   %ebp
  802119:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80211b:	6a 00                	push   $0x0
  80211d:	6a 00                	push   $0x0
  80211f:	6a 00                	push   $0x0
  802121:	6a 00                	push   $0x0
  802123:	ff 75 08             	pushl  0x8(%ebp)
  802126:	6a 29                	push   $0x29
  802128:	e8 fe fa ff ff       	call   801c2b <syscall>
  80212d:	83 c4 18             	add    $0x18,%esp
	return ;
  802130:	90                   	nop
}
  802131:	c9                   	leave  
  802132:	c3                   	ret    

00802133 <inctst>:

void inctst()
{
  802133:	55                   	push   %ebp
  802134:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802136:	6a 00                	push   $0x0
  802138:	6a 00                	push   $0x0
  80213a:	6a 00                	push   $0x0
  80213c:	6a 00                	push   $0x0
  80213e:	6a 00                	push   $0x0
  802140:	6a 2a                	push   $0x2a
  802142:	e8 e4 fa ff ff       	call   801c2b <syscall>
  802147:	83 c4 18             	add    $0x18,%esp
	return ;
  80214a:	90                   	nop
}
  80214b:	c9                   	leave  
  80214c:	c3                   	ret    

0080214d <gettst>:
uint32 gettst()
{
  80214d:	55                   	push   %ebp
  80214e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802150:	6a 00                	push   $0x0
  802152:	6a 00                	push   $0x0
  802154:	6a 00                	push   $0x0
  802156:	6a 00                	push   $0x0
  802158:	6a 00                	push   $0x0
  80215a:	6a 2b                	push   $0x2b
  80215c:	e8 ca fa ff ff       	call   801c2b <syscall>
  802161:	83 c4 18             	add    $0x18,%esp
}
  802164:	c9                   	leave  
  802165:	c3                   	ret    

00802166 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802166:	55                   	push   %ebp
  802167:	89 e5                	mov    %esp,%ebp
  802169:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80216c:	6a 00                	push   $0x0
  80216e:	6a 00                	push   $0x0
  802170:	6a 00                	push   $0x0
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 2c                	push   $0x2c
  802178:	e8 ae fa ff ff       	call   801c2b <syscall>
  80217d:	83 c4 18             	add    $0x18,%esp
  802180:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802183:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802187:	75 07                	jne    802190 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802189:	b8 01 00 00 00       	mov    $0x1,%eax
  80218e:	eb 05                	jmp    802195 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802190:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802195:	c9                   	leave  
  802196:	c3                   	ret    

00802197 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802197:	55                   	push   %ebp
  802198:	89 e5                	mov    %esp,%ebp
  80219a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	6a 00                	push   $0x0
  8021a3:	6a 00                	push   $0x0
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 2c                	push   $0x2c
  8021a9:	e8 7d fa ff ff       	call   801c2b <syscall>
  8021ae:	83 c4 18             	add    $0x18,%esp
  8021b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8021b4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8021b8:	75 07                	jne    8021c1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8021ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8021bf:	eb 05                	jmp    8021c6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8021c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021c6:	c9                   	leave  
  8021c7:	c3                   	ret    

008021c8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8021c8:	55                   	push   %ebp
  8021c9:	89 e5                	mov    %esp,%ebp
  8021cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021ce:	6a 00                	push   $0x0
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 00                	push   $0x0
  8021d8:	6a 2c                	push   $0x2c
  8021da:	e8 4c fa ff ff       	call   801c2b <syscall>
  8021df:	83 c4 18             	add    $0x18,%esp
  8021e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8021e5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8021e9:	75 07                	jne    8021f2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8021eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8021f0:	eb 05                	jmp    8021f7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8021f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021f7:	c9                   	leave  
  8021f8:	c3                   	ret    

008021f9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8021f9:	55                   	push   %ebp
  8021fa:	89 e5                	mov    %esp,%ebp
  8021fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021ff:	6a 00                	push   $0x0
  802201:	6a 00                	push   $0x0
  802203:	6a 00                	push   $0x0
  802205:	6a 00                	push   $0x0
  802207:	6a 00                	push   $0x0
  802209:	6a 2c                	push   $0x2c
  80220b:	e8 1b fa ff ff       	call   801c2b <syscall>
  802210:	83 c4 18             	add    $0x18,%esp
  802213:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802216:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80221a:	75 07                	jne    802223 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80221c:	b8 01 00 00 00       	mov    $0x1,%eax
  802221:	eb 05                	jmp    802228 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802223:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802228:	c9                   	leave  
  802229:	c3                   	ret    

0080222a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80222a:	55                   	push   %ebp
  80222b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80222d:	6a 00                	push   $0x0
  80222f:	6a 00                	push   $0x0
  802231:	6a 00                	push   $0x0
  802233:	6a 00                	push   $0x0
  802235:	ff 75 08             	pushl  0x8(%ebp)
  802238:	6a 2d                	push   $0x2d
  80223a:	e8 ec f9 ff ff       	call   801c2b <syscall>
  80223f:	83 c4 18             	add    $0x18,%esp
	return ;
  802242:	90                   	nop
}
  802243:	c9                   	leave  
  802244:	c3                   	ret    
  802245:	66 90                	xchg   %ax,%ax
  802247:	90                   	nop

00802248 <__udivdi3>:
  802248:	55                   	push   %ebp
  802249:	57                   	push   %edi
  80224a:	56                   	push   %esi
  80224b:	53                   	push   %ebx
  80224c:	83 ec 1c             	sub    $0x1c,%esp
  80224f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802253:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802257:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80225b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80225f:	89 ca                	mov    %ecx,%edx
  802261:	89 f8                	mov    %edi,%eax
  802263:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802267:	85 f6                	test   %esi,%esi
  802269:	75 2d                	jne    802298 <__udivdi3+0x50>
  80226b:	39 cf                	cmp    %ecx,%edi
  80226d:	77 65                	ja     8022d4 <__udivdi3+0x8c>
  80226f:	89 fd                	mov    %edi,%ebp
  802271:	85 ff                	test   %edi,%edi
  802273:	75 0b                	jne    802280 <__udivdi3+0x38>
  802275:	b8 01 00 00 00       	mov    $0x1,%eax
  80227a:	31 d2                	xor    %edx,%edx
  80227c:	f7 f7                	div    %edi
  80227e:	89 c5                	mov    %eax,%ebp
  802280:	31 d2                	xor    %edx,%edx
  802282:	89 c8                	mov    %ecx,%eax
  802284:	f7 f5                	div    %ebp
  802286:	89 c1                	mov    %eax,%ecx
  802288:	89 d8                	mov    %ebx,%eax
  80228a:	f7 f5                	div    %ebp
  80228c:	89 cf                	mov    %ecx,%edi
  80228e:	89 fa                	mov    %edi,%edx
  802290:	83 c4 1c             	add    $0x1c,%esp
  802293:	5b                   	pop    %ebx
  802294:	5e                   	pop    %esi
  802295:	5f                   	pop    %edi
  802296:	5d                   	pop    %ebp
  802297:	c3                   	ret    
  802298:	39 ce                	cmp    %ecx,%esi
  80229a:	77 28                	ja     8022c4 <__udivdi3+0x7c>
  80229c:	0f bd fe             	bsr    %esi,%edi
  80229f:	83 f7 1f             	xor    $0x1f,%edi
  8022a2:	75 40                	jne    8022e4 <__udivdi3+0x9c>
  8022a4:	39 ce                	cmp    %ecx,%esi
  8022a6:	72 0a                	jb     8022b2 <__udivdi3+0x6a>
  8022a8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022ac:	0f 87 9e 00 00 00    	ja     802350 <__udivdi3+0x108>
  8022b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8022b7:	89 fa                	mov    %edi,%edx
  8022b9:	83 c4 1c             	add    $0x1c,%esp
  8022bc:	5b                   	pop    %ebx
  8022bd:	5e                   	pop    %esi
  8022be:	5f                   	pop    %edi
  8022bf:	5d                   	pop    %ebp
  8022c0:	c3                   	ret    
  8022c1:	8d 76 00             	lea    0x0(%esi),%esi
  8022c4:	31 ff                	xor    %edi,%edi
  8022c6:	31 c0                	xor    %eax,%eax
  8022c8:	89 fa                	mov    %edi,%edx
  8022ca:	83 c4 1c             	add    $0x1c,%esp
  8022cd:	5b                   	pop    %ebx
  8022ce:	5e                   	pop    %esi
  8022cf:	5f                   	pop    %edi
  8022d0:	5d                   	pop    %ebp
  8022d1:	c3                   	ret    
  8022d2:	66 90                	xchg   %ax,%ax
  8022d4:	89 d8                	mov    %ebx,%eax
  8022d6:	f7 f7                	div    %edi
  8022d8:	31 ff                	xor    %edi,%edi
  8022da:	89 fa                	mov    %edi,%edx
  8022dc:	83 c4 1c             	add    $0x1c,%esp
  8022df:	5b                   	pop    %ebx
  8022e0:	5e                   	pop    %esi
  8022e1:	5f                   	pop    %edi
  8022e2:	5d                   	pop    %ebp
  8022e3:	c3                   	ret    
  8022e4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8022e9:	89 eb                	mov    %ebp,%ebx
  8022eb:	29 fb                	sub    %edi,%ebx
  8022ed:	89 f9                	mov    %edi,%ecx
  8022ef:	d3 e6                	shl    %cl,%esi
  8022f1:	89 c5                	mov    %eax,%ebp
  8022f3:	88 d9                	mov    %bl,%cl
  8022f5:	d3 ed                	shr    %cl,%ebp
  8022f7:	89 e9                	mov    %ebp,%ecx
  8022f9:	09 f1                	or     %esi,%ecx
  8022fb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8022ff:	89 f9                	mov    %edi,%ecx
  802301:	d3 e0                	shl    %cl,%eax
  802303:	89 c5                	mov    %eax,%ebp
  802305:	89 d6                	mov    %edx,%esi
  802307:	88 d9                	mov    %bl,%cl
  802309:	d3 ee                	shr    %cl,%esi
  80230b:	89 f9                	mov    %edi,%ecx
  80230d:	d3 e2                	shl    %cl,%edx
  80230f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802313:	88 d9                	mov    %bl,%cl
  802315:	d3 e8                	shr    %cl,%eax
  802317:	09 c2                	or     %eax,%edx
  802319:	89 d0                	mov    %edx,%eax
  80231b:	89 f2                	mov    %esi,%edx
  80231d:	f7 74 24 0c          	divl   0xc(%esp)
  802321:	89 d6                	mov    %edx,%esi
  802323:	89 c3                	mov    %eax,%ebx
  802325:	f7 e5                	mul    %ebp
  802327:	39 d6                	cmp    %edx,%esi
  802329:	72 19                	jb     802344 <__udivdi3+0xfc>
  80232b:	74 0b                	je     802338 <__udivdi3+0xf0>
  80232d:	89 d8                	mov    %ebx,%eax
  80232f:	31 ff                	xor    %edi,%edi
  802331:	e9 58 ff ff ff       	jmp    80228e <__udivdi3+0x46>
  802336:	66 90                	xchg   %ax,%ax
  802338:	8b 54 24 08          	mov    0x8(%esp),%edx
  80233c:	89 f9                	mov    %edi,%ecx
  80233e:	d3 e2                	shl    %cl,%edx
  802340:	39 c2                	cmp    %eax,%edx
  802342:	73 e9                	jae    80232d <__udivdi3+0xe5>
  802344:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802347:	31 ff                	xor    %edi,%edi
  802349:	e9 40 ff ff ff       	jmp    80228e <__udivdi3+0x46>
  80234e:	66 90                	xchg   %ax,%ax
  802350:	31 c0                	xor    %eax,%eax
  802352:	e9 37 ff ff ff       	jmp    80228e <__udivdi3+0x46>
  802357:	90                   	nop

00802358 <__umoddi3>:
  802358:	55                   	push   %ebp
  802359:	57                   	push   %edi
  80235a:	56                   	push   %esi
  80235b:	53                   	push   %ebx
  80235c:	83 ec 1c             	sub    $0x1c,%esp
  80235f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802363:	8b 74 24 34          	mov    0x34(%esp),%esi
  802367:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80236b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80236f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802373:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802377:	89 f3                	mov    %esi,%ebx
  802379:	89 fa                	mov    %edi,%edx
  80237b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80237f:	89 34 24             	mov    %esi,(%esp)
  802382:	85 c0                	test   %eax,%eax
  802384:	75 1a                	jne    8023a0 <__umoddi3+0x48>
  802386:	39 f7                	cmp    %esi,%edi
  802388:	0f 86 a2 00 00 00    	jbe    802430 <__umoddi3+0xd8>
  80238e:	89 c8                	mov    %ecx,%eax
  802390:	89 f2                	mov    %esi,%edx
  802392:	f7 f7                	div    %edi
  802394:	89 d0                	mov    %edx,%eax
  802396:	31 d2                	xor    %edx,%edx
  802398:	83 c4 1c             	add    $0x1c,%esp
  80239b:	5b                   	pop    %ebx
  80239c:	5e                   	pop    %esi
  80239d:	5f                   	pop    %edi
  80239e:	5d                   	pop    %ebp
  80239f:	c3                   	ret    
  8023a0:	39 f0                	cmp    %esi,%eax
  8023a2:	0f 87 ac 00 00 00    	ja     802454 <__umoddi3+0xfc>
  8023a8:	0f bd e8             	bsr    %eax,%ebp
  8023ab:	83 f5 1f             	xor    $0x1f,%ebp
  8023ae:	0f 84 ac 00 00 00    	je     802460 <__umoddi3+0x108>
  8023b4:	bf 20 00 00 00       	mov    $0x20,%edi
  8023b9:	29 ef                	sub    %ebp,%edi
  8023bb:	89 fe                	mov    %edi,%esi
  8023bd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8023c1:	89 e9                	mov    %ebp,%ecx
  8023c3:	d3 e0                	shl    %cl,%eax
  8023c5:	89 d7                	mov    %edx,%edi
  8023c7:	89 f1                	mov    %esi,%ecx
  8023c9:	d3 ef                	shr    %cl,%edi
  8023cb:	09 c7                	or     %eax,%edi
  8023cd:	89 e9                	mov    %ebp,%ecx
  8023cf:	d3 e2                	shl    %cl,%edx
  8023d1:	89 14 24             	mov    %edx,(%esp)
  8023d4:	89 d8                	mov    %ebx,%eax
  8023d6:	d3 e0                	shl    %cl,%eax
  8023d8:	89 c2                	mov    %eax,%edx
  8023da:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023de:	d3 e0                	shl    %cl,%eax
  8023e0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8023e4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023e8:	89 f1                	mov    %esi,%ecx
  8023ea:	d3 e8                	shr    %cl,%eax
  8023ec:	09 d0                	or     %edx,%eax
  8023ee:	d3 eb                	shr    %cl,%ebx
  8023f0:	89 da                	mov    %ebx,%edx
  8023f2:	f7 f7                	div    %edi
  8023f4:	89 d3                	mov    %edx,%ebx
  8023f6:	f7 24 24             	mull   (%esp)
  8023f9:	89 c6                	mov    %eax,%esi
  8023fb:	89 d1                	mov    %edx,%ecx
  8023fd:	39 d3                	cmp    %edx,%ebx
  8023ff:	0f 82 87 00 00 00    	jb     80248c <__umoddi3+0x134>
  802405:	0f 84 91 00 00 00    	je     80249c <__umoddi3+0x144>
  80240b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80240f:	29 f2                	sub    %esi,%edx
  802411:	19 cb                	sbb    %ecx,%ebx
  802413:	89 d8                	mov    %ebx,%eax
  802415:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802419:	d3 e0                	shl    %cl,%eax
  80241b:	89 e9                	mov    %ebp,%ecx
  80241d:	d3 ea                	shr    %cl,%edx
  80241f:	09 d0                	or     %edx,%eax
  802421:	89 e9                	mov    %ebp,%ecx
  802423:	d3 eb                	shr    %cl,%ebx
  802425:	89 da                	mov    %ebx,%edx
  802427:	83 c4 1c             	add    $0x1c,%esp
  80242a:	5b                   	pop    %ebx
  80242b:	5e                   	pop    %esi
  80242c:	5f                   	pop    %edi
  80242d:	5d                   	pop    %ebp
  80242e:	c3                   	ret    
  80242f:	90                   	nop
  802430:	89 fd                	mov    %edi,%ebp
  802432:	85 ff                	test   %edi,%edi
  802434:	75 0b                	jne    802441 <__umoddi3+0xe9>
  802436:	b8 01 00 00 00       	mov    $0x1,%eax
  80243b:	31 d2                	xor    %edx,%edx
  80243d:	f7 f7                	div    %edi
  80243f:	89 c5                	mov    %eax,%ebp
  802441:	89 f0                	mov    %esi,%eax
  802443:	31 d2                	xor    %edx,%edx
  802445:	f7 f5                	div    %ebp
  802447:	89 c8                	mov    %ecx,%eax
  802449:	f7 f5                	div    %ebp
  80244b:	89 d0                	mov    %edx,%eax
  80244d:	e9 44 ff ff ff       	jmp    802396 <__umoddi3+0x3e>
  802452:	66 90                	xchg   %ax,%ax
  802454:	89 c8                	mov    %ecx,%eax
  802456:	89 f2                	mov    %esi,%edx
  802458:	83 c4 1c             	add    $0x1c,%esp
  80245b:	5b                   	pop    %ebx
  80245c:	5e                   	pop    %esi
  80245d:	5f                   	pop    %edi
  80245e:	5d                   	pop    %ebp
  80245f:	c3                   	ret    
  802460:	3b 04 24             	cmp    (%esp),%eax
  802463:	72 06                	jb     80246b <__umoddi3+0x113>
  802465:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802469:	77 0f                	ja     80247a <__umoddi3+0x122>
  80246b:	89 f2                	mov    %esi,%edx
  80246d:	29 f9                	sub    %edi,%ecx
  80246f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802473:	89 14 24             	mov    %edx,(%esp)
  802476:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80247a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80247e:	8b 14 24             	mov    (%esp),%edx
  802481:	83 c4 1c             	add    $0x1c,%esp
  802484:	5b                   	pop    %ebx
  802485:	5e                   	pop    %esi
  802486:	5f                   	pop    %edi
  802487:	5d                   	pop    %ebp
  802488:	c3                   	ret    
  802489:	8d 76 00             	lea    0x0(%esi),%esi
  80248c:	2b 04 24             	sub    (%esp),%eax
  80248f:	19 fa                	sbb    %edi,%edx
  802491:	89 d1                	mov    %edx,%ecx
  802493:	89 c6                	mov    %eax,%esi
  802495:	e9 71 ff ff ff       	jmp    80240b <__umoddi3+0xb3>
  80249a:	66 90                	xchg   %ax,%ax
  80249c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024a0:	72 ea                	jb     80248c <__umoddi3+0x134>
  8024a2:	89 d9                	mov    %ebx,%ecx
  8024a4:	e9 62 ff ff ff       	jmp    80240b <__umoddi3+0xb3>
