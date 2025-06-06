
obj/user/mergesort_noleakage:     file format elf32-i386


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
  800031:	e8 8f 07 00 00       	call   8007c5 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

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
  800041:	e8 91 1f 00 00       	call   801fd7 <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 20 26 80 00       	push   $0x802620
  80004e:	e8 28 0b 00 00       	call   800b7b <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 22 26 80 00       	push   $0x802622
  80005e:	e8 18 0b 00 00       	call   800b7b <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 38 26 80 00       	push   $0x802638
  80006e:	e8 08 0b 00 00       	call   800b7b <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 22 26 80 00       	push   $0x802622
  80007e:	e8 f8 0a 00 00       	call   800b7b <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 20 26 80 00       	push   $0x802620
  80008e:	e8 e8 0a 00 00       	call   800b7b <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 50 26 80 00       	push   $0x802650
  8000a5:	e8 53 11 00 00       	call   8011fd <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 a3 16 00 00       	call   801763 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 70 1a 00 00       	call   801b45 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 70 26 80 00       	push   $0x802670
  8000e3:	e8 93 0a 00 00       	call   800b7b <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 92 26 80 00       	push   $0x802692
  8000f3:	e8 83 0a 00 00       	call   800b7b <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 a0 26 80 00       	push   $0x8026a0
  800103:	e8 73 0a 00 00       	call   800b7b <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 af 26 80 00       	push   $0x8026af
  800113:	e8 63 0a 00 00       	call   800b7b <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 bf 26 80 00       	push   $0x8026bf
  800123:	e8 53 0a 00 00       	call   800b7b <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 3d 06 00 00       	call   80076d <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 e5 05 00 00       	call   800725 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 d8 05 00 00       	call   800725 <cputchar>
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
  800162:	e8 8a 1e 00 00       	call   801ff1 <sys_enable_interrupt>

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
  800183:	e8 f4 01 00 00       	call   80037c <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 12 02 00 00       	call   8003ad <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 34 02 00 00       	call   8003e2 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 21 02 00 00       	call   8003e2 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	6a 01                	push   $0x1
  8001cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cf:	e8 e0 02 00 00       	call   8004b4 <MSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d7:	e8 fb 1d 00 00       	call   801fd7 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 c8 26 80 00       	push   $0x8026c8
  8001e4:	e8 92 09 00 00       	call   800b7b <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 00 1e 00 00       	call   801ff1 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f1:	83 ec 08             	sub    $0x8,%esp
  8001f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001fa:	e8 d3 00 00 00       	call   8002d2 <CheckSorted>
  8001ff:	83 c4 10             	add    $0x10,%esp
  800202:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800205:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800209:	75 14                	jne    80021f <_main+0x1e7>
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	68 fc 26 80 00       	push   $0x8026fc
  800213:	6a 4a                	push   $0x4a
  800215:	68 1e 27 80 00       	push   $0x80271e
  80021a:	e8 a8 06 00 00       	call   8008c7 <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 b3 1d 00 00       	call   801fd7 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 3c 27 80 00       	push   $0x80273c
  80022c:	e8 4a 09 00 00       	call   800b7b <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 70 27 80 00       	push   $0x802770
  80023c:	e8 3a 09 00 00       	call   800b7b <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 a4 27 80 00       	push   $0x8027a4
  80024c:	e8 2a 09 00 00       	call   800b7b <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 98 1d 00 00       	call   801ff1 <sys_enable_interrupt>
		}

		free(Elements) ;
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	ff 75 ec             	pushl  -0x14(%ebp)
  80025f:	e8 02 1a 00 00       	call   801c66 <free>
  800264:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800267:	e8 6b 1d 00 00       	call   801fd7 <sys_disable_interrupt>
			Chose = 0 ;
  80026c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800270:	eb 42                	jmp    8002b4 <_main+0x27c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 d6 27 80 00       	push   $0x8027d6
  80027a:	e8 fc 08 00 00       	call   800b7b <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800282:	e8 e6 04 00 00       	call   80076d <getchar>
  800287:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80028a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80028e:	83 ec 0c             	sub    $0xc,%esp
  800291:	50                   	push   %eax
  800292:	e8 8e 04 00 00       	call   800725 <cputchar>
  800297:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	6a 0a                	push   $0xa
  80029f:	e8 81 04 00 00       	call   800725 <cputchar>
  8002a4:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  8002a7:	83 ec 0c             	sub    $0xc,%esp
  8002aa:	6a 0a                	push   $0xa
  8002ac:	e8 74 04 00 00       	call   800725 <cputchar>
  8002b1:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002b4:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002b8:	74 06                	je     8002c0 <_main+0x288>
  8002ba:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002be:	75 b2                	jne    800272 <_main+0x23a>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002c0:	e8 2c 1d 00 00       	call   801ff1 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002c5:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002c9:	0f 84 72 fd ff ff    	je     800041 <_main+0x9>

}
  8002cf:	90                   	nop
  8002d0:	c9                   	leave  
  8002d1:	c3                   	ret    

008002d2 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002d2:	55                   	push   %ebp
  8002d3:	89 e5                	mov    %esp,%ebp
  8002d5:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002d8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002e6:	eb 33                	jmp    80031b <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f5:	01 d0                	add    %edx,%eax
  8002f7:	8b 10                	mov    (%eax),%edx
  8002f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002fc:	40                   	inc    %eax
  8002fd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800304:	8b 45 08             	mov    0x8(%ebp),%eax
  800307:	01 c8                	add    %ecx,%eax
  800309:	8b 00                	mov    (%eax),%eax
  80030b:	39 c2                	cmp    %eax,%edx
  80030d:	7e 09                	jle    800318 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  80030f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800316:	eb 0c                	jmp    800324 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800318:	ff 45 f8             	incl   -0x8(%ebp)
  80031b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80031e:	48                   	dec    %eax
  80031f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800322:	7f c4                	jg     8002e8 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800324:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800327:	c9                   	leave  
  800328:	c3                   	ret    

00800329 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800329:	55                   	push   %ebp
  80032a:	89 e5                	mov    %esp,%ebp
  80032c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80032f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800332:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800339:	8b 45 08             	mov    0x8(%ebp),%eax
  80033c:	01 d0                	add    %edx,%eax
  80033e:	8b 00                	mov    (%eax),%eax
  800340:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800343:	8b 45 0c             	mov    0xc(%ebp),%eax
  800346:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034d:	8b 45 08             	mov    0x8(%ebp),%eax
  800350:	01 c2                	add    %eax,%edx
  800352:	8b 45 10             	mov    0x10(%ebp),%eax
  800355:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035c:	8b 45 08             	mov    0x8(%ebp),%eax
  80035f:	01 c8                	add    %ecx,%eax
  800361:	8b 00                	mov    (%eax),%eax
  800363:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800365:	8b 45 10             	mov    0x10(%ebp),%eax
  800368:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036f:	8b 45 08             	mov    0x8(%ebp),%eax
  800372:	01 c2                	add    %eax,%edx
  800374:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800377:	89 02                	mov    %eax,(%edx)
}
  800379:	90                   	nop
  80037a:	c9                   	leave  
  80037b:	c3                   	ret    

0080037c <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80037c:	55                   	push   %ebp
  80037d:	89 e5                	mov    %esp,%ebp
  80037f:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800382:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800389:	eb 17                	jmp    8003a2 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80038b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800395:	8b 45 08             	mov    0x8(%ebp),%eax
  800398:	01 c2                	add    %eax,%edx
  80039a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80039d:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80039f:	ff 45 fc             	incl   -0x4(%ebp)
  8003a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003a5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003a8:	7c e1                	jl     80038b <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8003aa:	90                   	nop
  8003ab:	c9                   	leave  
  8003ac:	c3                   	ret    

008003ad <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8003ad:	55                   	push   %ebp
  8003ae:	89 e5                	mov    %esp,%ebp
  8003b0:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ba:	eb 1b                	jmp    8003d7 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c9:	01 c2                	add    %eax,%edx
  8003cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ce:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003d1:	48                   	dec    %eax
  8003d2:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003d4:	ff 45 fc             	incl   -0x4(%ebp)
  8003d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003da:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003dd:	7c dd                	jl     8003bc <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003df:	90                   	nop
  8003e0:	c9                   	leave  
  8003e1:	c3                   	ret    

008003e2 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003e2:	55                   	push   %ebp
  8003e3:	89 e5                	mov    %esp,%ebp
  8003e5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003eb:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003f0:	f7 e9                	imul   %ecx
  8003f2:	c1 f9 1f             	sar    $0x1f,%ecx
  8003f5:	89 d0                	mov    %edx,%eax
  8003f7:	29 c8                	sub    %ecx,%eax
  8003f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800403:	eb 1e                	jmp    800423 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800405:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800408:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040f:	8b 45 08             	mov    0x8(%ebp),%eax
  800412:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	99                   	cltd   
  800419:	f7 7d f8             	idivl  -0x8(%ebp)
  80041c:	89 d0                	mov    %edx,%eax
  80041e:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800420:	ff 45 fc             	incl   -0x4(%ebp)
  800423:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800426:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800429:	7c da                	jl     800405 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80042b:	90                   	nop
  80042c:	c9                   	leave  
  80042d:	c3                   	ret    

0080042e <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80042e:	55                   	push   %ebp
  80042f:	89 e5                	mov    %esp,%ebp
  800431:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800434:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80043b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800442:	eb 42                	jmp    800486 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800444:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800447:	99                   	cltd   
  800448:	f7 7d f0             	idivl  -0x10(%ebp)
  80044b:	89 d0                	mov    %edx,%eax
  80044d:	85 c0                	test   %eax,%eax
  80044f:	75 10                	jne    800461 <PrintElements+0x33>
			cprintf("\n");
  800451:	83 ec 0c             	sub    $0xc,%esp
  800454:	68 20 26 80 00       	push   $0x802620
  800459:	e8 1d 07 00 00       	call   800b7b <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800464:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	50                   	push   %eax
  800476:	68 f4 27 80 00       	push   $0x8027f4
  80047b:	e8 fb 06 00 00       	call   800b7b <cprintf>
  800480:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800483:	ff 45 f4             	incl   -0xc(%ebp)
  800486:	8b 45 0c             	mov    0xc(%ebp),%eax
  800489:	48                   	dec    %eax
  80048a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80048d:	7f b5                	jg     800444 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80048f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800492:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800499:	8b 45 08             	mov    0x8(%ebp),%eax
  80049c:	01 d0                	add    %edx,%eax
  80049e:	8b 00                	mov    (%eax),%eax
  8004a0:	83 ec 08             	sub    $0x8,%esp
  8004a3:	50                   	push   %eax
  8004a4:	68 f9 27 80 00       	push   $0x8027f9
  8004a9:	e8 cd 06 00 00       	call   800b7b <cprintf>
  8004ae:	83 c4 10             	add    $0x10,%esp

}
  8004b1:	90                   	nop
  8004b2:	c9                   	leave  
  8004b3:	c3                   	ret    

008004b4 <MSort>:


void MSort(int* A, int p, int r)
{
  8004b4:	55                   	push   %ebp
  8004b5:	89 e5                	mov    %esp,%ebp
  8004b7:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bd:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004c0:	7d 54                	jge    800516 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c8:	01 d0                	add    %edx,%eax
  8004ca:	89 c2                	mov    %eax,%edx
  8004cc:	c1 ea 1f             	shr    $0x1f,%edx
  8004cf:	01 d0                	add    %edx,%eax
  8004d1:	d1 f8                	sar    %eax
  8004d3:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004d6:	83 ec 04             	sub    $0x4,%esp
  8004d9:	ff 75 f4             	pushl  -0xc(%ebp)
  8004dc:	ff 75 0c             	pushl  0xc(%ebp)
  8004df:	ff 75 08             	pushl  0x8(%ebp)
  8004e2:	e8 cd ff ff ff       	call   8004b4 <MSort>
  8004e7:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004ed:	40                   	inc    %eax
  8004ee:	83 ec 04             	sub    $0x4,%esp
  8004f1:	ff 75 10             	pushl  0x10(%ebp)
  8004f4:	50                   	push   %eax
  8004f5:	ff 75 08             	pushl  0x8(%ebp)
  8004f8:	e8 b7 ff ff ff       	call   8004b4 <MSort>
  8004fd:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800500:	ff 75 10             	pushl  0x10(%ebp)
  800503:	ff 75 f4             	pushl  -0xc(%ebp)
  800506:	ff 75 0c             	pushl  0xc(%ebp)
  800509:	ff 75 08             	pushl  0x8(%ebp)
  80050c:	e8 08 00 00 00       	call   800519 <Merge>
  800511:	83 c4 10             	add    $0x10,%esp
  800514:	eb 01                	jmp    800517 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800516:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800517:	c9                   	leave  
  800518:	c3                   	ret    

00800519 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800519:	55                   	push   %ebp
  80051a:	89 e5                	mov    %esp,%ebp
  80051c:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80051f:	8b 45 10             	mov    0x10(%ebp),%eax
  800522:	2b 45 0c             	sub    0xc(%ebp),%eax
  800525:	40                   	inc    %eax
  800526:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800529:	8b 45 14             	mov    0x14(%ebp),%eax
  80052c:	2b 45 10             	sub    0x10(%ebp),%eax
  80052f:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800532:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800539:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	//cprintf("allocate LEFT\n");
	int* Left = malloc(sizeof(int) * leftCapacity);
  800540:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800543:	c1 e0 02             	shl    $0x2,%eax
  800546:	83 ec 0c             	sub    $0xc,%esp
  800549:	50                   	push   %eax
  80054a:	e8 f6 15 00 00       	call   801b45 <malloc>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 d8             	mov    %eax,-0x28(%ebp)

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);
  800555:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800558:	c1 e0 02             	shl    $0x2,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 e1 15 00 00       	call   801b45 <malloc>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80056a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800571:	eb 2f                	jmp    8005a2 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800573:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800576:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80057d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800580:	01 c2                	add    %eax,%edx
  800582:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800585:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800588:	01 c8                	add    %ecx,%eax
  80058a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80058f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	01 c8                	add    %ecx,%eax
  80059b:	8b 00                	mov    (%eax),%eax
  80059d:	89 02                	mov    %eax,(%edx)

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80059f:	ff 45 ec             	incl   -0x14(%ebp)
  8005a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005a5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005a8:	7c c9                	jl     800573 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005aa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005b1:	eb 2a                	jmp    8005dd <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005bd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005c0:	01 c2                	add    %eax,%edx
  8005c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005c8:	01 c8                	add    %ecx,%eax
  8005ca:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d4:	01 c8                	add    %ecx,%eax
  8005d6:	8b 00                	mov    (%eax),%eax
  8005d8:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005da:	ff 45 e8             	incl   -0x18(%ebp)
  8005dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005e0:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005e3:	7c ce                	jl     8005b3 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005eb:	e9 0a 01 00 00       	jmp    8006fa <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005f6:	0f 8d 95 00 00 00    	jge    800691 <Merge+0x178>
  8005fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005ff:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800602:	0f 8d 89 00 00 00    	jge    800691 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800608:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80060b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800612:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800615:	01 d0                	add    %edx,%eax
  800617:	8b 10                	mov    (%eax),%edx
  800619:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80061c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800623:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800626:	01 c8                	add    %ecx,%eax
  800628:	8b 00                	mov    (%eax),%eax
  80062a:	39 c2                	cmp    %eax,%edx
  80062c:	7d 33                	jge    800661 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  80062e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800631:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800636:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80063d:	8b 45 08             	mov    0x8(%ebp),%eax
  800640:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800643:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800646:	8d 50 01             	lea    0x1(%eax),%edx
  800649:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80064c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800653:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800656:	01 d0                	add    %edx,%eax
  800658:	8b 00                	mov    (%eax),%eax
  80065a:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80065c:	e9 96 00 00 00       	jmp    8006f7 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800661:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800664:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800669:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800670:	8b 45 08             	mov    0x8(%ebp),%eax
  800673:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800676:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800679:	8d 50 01             	lea    0x1(%eax),%edx
  80067c:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80067f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800686:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800689:	01 d0                	add    %edx,%eax
  80068b:	8b 00                	mov    (%eax),%eax
  80068d:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80068f:	eb 66                	jmp    8006f7 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800691:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800694:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800697:	7d 30                	jge    8006c9 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  800699:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80069c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006b1:	8d 50 01             	lea    0x1(%eax),%edx
  8006b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006be:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006c1:	01 d0                	add    %edx,%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	89 01                	mov    %eax,(%ecx)
  8006c7:	eb 2e                	jmp    8006f7 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006cc:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e1:	8d 50 01             	lea    0x1(%eax),%edx
  8006e4:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006e7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ee:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006f1:	01 d0                	add    %edx,%eax
  8006f3:	8b 00                	mov    (%eax),%eax
  8006f5:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006f7:	ff 45 e4             	incl   -0x1c(%ebp)
  8006fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006fd:	3b 45 14             	cmp    0x14(%ebp),%eax
  800700:	0f 8e ea fe ff ff    	jle    8005f0 <Merge+0xd7>
			A[k - 1] = Right[rightIndex++];
		}
	}

	//cprintf("free LEFT\n");
	free(Left);
  800706:	83 ec 0c             	sub    $0xc,%esp
  800709:	ff 75 d8             	pushl  -0x28(%ebp)
  80070c:	e8 55 15 00 00       	call   801c66 <free>
  800711:	83 c4 10             	add    $0x10,%esp
	//cprintf("free RIGHT\n");
	free(Right);
  800714:	83 ec 0c             	sub    $0xc,%esp
  800717:	ff 75 d4             	pushl  -0x2c(%ebp)
  80071a:	e8 47 15 00 00       	call   801c66 <free>
  80071f:	83 c4 10             	add    $0x10,%esp

}
  800722:	90                   	nop
  800723:	c9                   	leave  
  800724:	c3                   	ret    

00800725 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800725:	55                   	push   %ebp
  800726:	89 e5                	mov    %esp,%ebp
  800728:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80072b:	8b 45 08             	mov    0x8(%ebp),%eax
  80072e:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800731:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800735:	83 ec 0c             	sub    $0xc,%esp
  800738:	50                   	push   %eax
  800739:	e8 cd 18 00 00       	call   80200b <sys_cputc>
  80073e:	83 c4 10             	add    $0x10,%esp
}
  800741:	90                   	nop
  800742:	c9                   	leave  
  800743:	c3                   	ret    

00800744 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800744:	55                   	push   %ebp
  800745:	89 e5                	mov    %esp,%ebp
  800747:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80074a:	e8 88 18 00 00       	call   801fd7 <sys_disable_interrupt>
	char c = ch;
  80074f:	8b 45 08             	mov    0x8(%ebp),%eax
  800752:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800755:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800759:	83 ec 0c             	sub    $0xc,%esp
  80075c:	50                   	push   %eax
  80075d:	e8 a9 18 00 00       	call   80200b <sys_cputc>
  800762:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800765:	e8 87 18 00 00       	call   801ff1 <sys_enable_interrupt>
}
  80076a:	90                   	nop
  80076b:	c9                   	leave  
  80076c:	c3                   	ret    

0080076d <getchar>:

int
getchar(void)
{
  80076d:	55                   	push   %ebp
  80076e:	89 e5                	mov    %esp,%ebp
  800770:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800773:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80077a:	eb 08                	jmp    800784 <getchar+0x17>
	{
		c = sys_cgetc();
  80077c:	e8 6e 16 00 00       	call   801def <sys_cgetc>
  800781:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800784:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800788:	74 f2                	je     80077c <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80078a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80078d:	c9                   	leave  
  80078e:	c3                   	ret    

0080078f <atomic_getchar>:

int
atomic_getchar(void)
{
  80078f:	55                   	push   %ebp
  800790:	89 e5                	mov    %esp,%ebp
  800792:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800795:	e8 3d 18 00 00       	call   801fd7 <sys_disable_interrupt>
	int c=0;
  80079a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8007a1:	eb 08                	jmp    8007ab <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8007a3:	e8 47 16 00 00       	call   801def <sys_cgetc>
  8007a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8007ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007af:	74 f2                	je     8007a3 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007b1:	e8 3b 18 00 00       	call   801ff1 <sys_enable_interrupt>
	return c;
  8007b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007b9:	c9                   	leave  
  8007ba:	c3                   	ret    

008007bb <iscons>:

int iscons(int fdnum)
{
  8007bb:	55                   	push   %ebp
  8007bc:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007be:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007c3:	5d                   	pop    %ebp
  8007c4:	c3                   	ret    

008007c5 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007c5:	55                   	push   %ebp
  8007c6:	89 e5                	mov    %esp,%ebp
  8007c8:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007cb:	e8 6c 16 00 00       	call   801e3c <sys_getenvindex>
  8007d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007d6:	89 d0                	mov    %edx,%eax
  8007d8:	01 c0                	add    %eax,%eax
  8007da:	01 d0                	add    %edx,%eax
  8007dc:	c1 e0 02             	shl    $0x2,%eax
  8007df:	01 d0                	add    %edx,%eax
  8007e1:	c1 e0 06             	shl    $0x6,%eax
  8007e4:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007e9:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007ee:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f3:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8007f9:	84 c0                	test   %al,%al
  8007fb:	74 0f                	je     80080c <libmain+0x47>
		binaryname = myEnv->prog_name;
  8007fd:	a1 24 30 80 00       	mov    0x803024,%eax
  800802:	05 f4 02 00 00       	add    $0x2f4,%eax
  800807:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80080c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800810:	7e 0a                	jle    80081c <libmain+0x57>
		binaryname = argv[0];
  800812:	8b 45 0c             	mov    0xc(%ebp),%eax
  800815:	8b 00                	mov    (%eax),%eax
  800817:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80081c:	83 ec 08             	sub    $0x8,%esp
  80081f:	ff 75 0c             	pushl  0xc(%ebp)
  800822:	ff 75 08             	pushl  0x8(%ebp)
  800825:	e8 0e f8 ff ff       	call   800038 <_main>
  80082a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80082d:	e8 a5 17 00 00       	call   801fd7 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800832:	83 ec 0c             	sub    $0xc,%esp
  800835:	68 18 28 80 00       	push   $0x802818
  80083a:	e8 3c 03 00 00       	call   800b7b <cprintf>
  80083f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800842:	a1 24 30 80 00       	mov    0x803024,%eax
  800847:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80084d:	a1 24 30 80 00       	mov    0x803024,%eax
  800852:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800858:	83 ec 04             	sub    $0x4,%esp
  80085b:	52                   	push   %edx
  80085c:	50                   	push   %eax
  80085d:	68 40 28 80 00       	push   $0x802840
  800862:	e8 14 03 00 00       	call   800b7b <cprintf>
  800867:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80086a:	a1 24 30 80 00       	mov    0x803024,%eax
  80086f:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800875:	83 ec 08             	sub    $0x8,%esp
  800878:	50                   	push   %eax
  800879:	68 65 28 80 00       	push   $0x802865
  80087e:	e8 f8 02 00 00       	call   800b7b <cprintf>
  800883:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800886:	83 ec 0c             	sub    $0xc,%esp
  800889:	68 18 28 80 00       	push   $0x802818
  80088e:	e8 e8 02 00 00       	call   800b7b <cprintf>
  800893:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800896:	e8 56 17 00 00       	call   801ff1 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80089b:	e8 19 00 00 00       	call   8008b9 <exit>
}
  8008a0:	90                   	nop
  8008a1:	c9                   	leave  
  8008a2:	c3                   	ret    

008008a3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008a3:	55                   	push   %ebp
  8008a4:	89 e5                	mov    %esp,%ebp
  8008a6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008a9:	83 ec 0c             	sub    $0xc,%esp
  8008ac:	6a 00                	push   $0x0
  8008ae:	e8 55 15 00 00       	call   801e08 <sys_env_destroy>
  8008b3:	83 c4 10             	add    $0x10,%esp
}
  8008b6:	90                   	nop
  8008b7:	c9                   	leave  
  8008b8:	c3                   	ret    

008008b9 <exit>:

void
exit(void)
{
  8008b9:	55                   	push   %ebp
  8008ba:	89 e5                	mov    %esp,%ebp
  8008bc:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008bf:	e8 aa 15 00 00       	call   801e6e <sys_env_exit>
}
  8008c4:	90                   	nop
  8008c5:	c9                   	leave  
  8008c6:	c3                   	ret    

008008c7 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008c7:	55                   	push   %ebp
  8008c8:	89 e5                	mov    %esp,%ebp
  8008ca:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008cd:	8d 45 10             	lea    0x10(%ebp),%eax
  8008d0:	83 c0 04             	add    $0x4,%eax
  8008d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008d6:	a1 34 30 80 00       	mov    0x803034,%eax
  8008db:	85 c0                	test   %eax,%eax
  8008dd:	74 16                	je     8008f5 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008df:	a1 34 30 80 00       	mov    0x803034,%eax
  8008e4:	83 ec 08             	sub    $0x8,%esp
  8008e7:	50                   	push   %eax
  8008e8:	68 7c 28 80 00       	push   $0x80287c
  8008ed:	e8 89 02 00 00       	call   800b7b <cprintf>
  8008f2:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8008f5:	a1 00 30 80 00       	mov    0x803000,%eax
  8008fa:	ff 75 0c             	pushl  0xc(%ebp)
  8008fd:	ff 75 08             	pushl  0x8(%ebp)
  800900:	50                   	push   %eax
  800901:	68 81 28 80 00       	push   $0x802881
  800906:	e8 70 02 00 00       	call   800b7b <cprintf>
  80090b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80090e:	8b 45 10             	mov    0x10(%ebp),%eax
  800911:	83 ec 08             	sub    $0x8,%esp
  800914:	ff 75 f4             	pushl  -0xc(%ebp)
  800917:	50                   	push   %eax
  800918:	e8 f3 01 00 00       	call   800b10 <vcprintf>
  80091d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800920:	83 ec 08             	sub    $0x8,%esp
  800923:	6a 00                	push   $0x0
  800925:	68 9d 28 80 00       	push   $0x80289d
  80092a:	e8 e1 01 00 00       	call   800b10 <vcprintf>
  80092f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800932:	e8 82 ff ff ff       	call   8008b9 <exit>

	// should not return here
	while (1) ;
  800937:	eb fe                	jmp    800937 <_panic+0x70>

00800939 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800939:	55                   	push   %ebp
  80093a:	89 e5                	mov    %esp,%ebp
  80093c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80093f:	a1 24 30 80 00       	mov    0x803024,%eax
  800944:	8b 50 74             	mov    0x74(%eax),%edx
  800947:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094a:	39 c2                	cmp    %eax,%edx
  80094c:	74 14                	je     800962 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80094e:	83 ec 04             	sub    $0x4,%esp
  800951:	68 a0 28 80 00       	push   $0x8028a0
  800956:	6a 26                	push   $0x26
  800958:	68 ec 28 80 00       	push   $0x8028ec
  80095d:	e8 65 ff ff ff       	call   8008c7 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800962:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800969:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800970:	e9 c2 00 00 00       	jmp    800a37 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800975:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800978:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80097f:	8b 45 08             	mov    0x8(%ebp),%eax
  800982:	01 d0                	add    %edx,%eax
  800984:	8b 00                	mov    (%eax),%eax
  800986:	85 c0                	test   %eax,%eax
  800988:	75 08                	jne    800992 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80098a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80098d:	e9 a2 00 00 00       	jmp    800a34 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800992:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800999:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009a0:	eb 69                	jmp    800a0b <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009a2:	a1 24 30 80 00       	mov    0x803024,%eax
  8009a7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009ad:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009b0:	89 d0                	mov    %edx,%eax
  8009b2:	01 c0                	add    %eax,%eax
  8009b4:	01 d0                	add    %edx,%eax
  8009b6:	c1 e0 02             	shl    $0x2,%eax
  8009b9:	01 c8                	add    %ecx,%eax
  8009bb:	8a 40 04             	mov    0x4(%eax),%al
  8009be:	84 c0                	test   %al,%al
  8009c0:	75 46                	jne    800a08 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009c2:	a1 24 30 80 00       	mov    0x803024,%eax
  8009c7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009cd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009d0:	89 d0                	mov    %edx,%eax
  8009d2:	01 c0                	add    %eax,%eax
  8009d4:	01 d0                	add    %edx,%eax
  8009d6:	c1 e0 02             	shl    $0x2,%eax
  8009d9:	01 c8                	add    %ecx,%eax
  8009db:	8b 00                	mov    (%eax),%eax
  8009dd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009e3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009e8:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ed:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8009f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f7:	01 c8                	add    %ecx,%eax
  8009f9:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009fb:	39 c2                	cmp    %eax,%edx
  8009fd:	75 09                	jne    800a08 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8009ff:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a06:	eb 12                	jmp    800a1a <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a08:	ff 45 e8             	incl   -0x18(%ebp)
  800a0b:	a1 24 30 80 00       	mov    0x803024,%eax
  800a10:	8b 50 74             	mov    0x74(%eax),%edx
  800a13:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a16:	39 c2                	cmp    %eax,%edx
  800a18:	77 88                	ja     8009a2 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a1a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a1e:	75 14                	jne    800a34 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800a20:	83 ec 04             	sub    $0x4,%esp
  800a23:	68 f8 28 80 00       	push   $0x8028f8
  800a28:	6a 3a                	push   $0x3a
  800a2a:	68 ec 28 80 00       	push   $0x8028ec
  800a2f:	e8 93 fe ff ff       	call   8008c7 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a34:	ff 45 f0             	incl   -0x10(%ebp)
  800a37:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a3a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a3d:	0f 8c 32 ff ff ff    	jl     800975 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a43:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a4a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a51:	eb 26                	jmp    800a79 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a53:	a1 24 30 80 00       	mov    0x803024,%eax
  800a58:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800a5e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a61:	89 d0                	mov    %edx,%eax
  800a63:	01 c0                	add    %eax,%eax
  800a65:	01 d0                	add    %edx,%eax
  800a67:	c1 e0 02             	shl    $0x2,%eax
  800a6a:	01 c8                	add    %ecx,%eax
  800a6c:	8a 40 04             	mov    0x4(%eax),%al
  800a6f:	3c 01                	cmp    $0x1,%al
  800a71:	75 03                	jne    800a76 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800a73:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a76:	ff 45 e0             	incl   -0x20(%ebp)
  800a79:	a1 24 30 80 00       	mov    0x803024,%eax
  800a7e:	8b 50 74             	mov    0x74(%eax),%edx
  800a81:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a84:	39 c2                	cmp    %eax,%edx
  800a86:	77 cb                	ja     800a53 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a88:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a8b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a8e:	74 14                	je     800aa4 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800a90:	83 ec 04             	sub    $0x4,%esp
  800a93:	68 4c 29 80 00       	push   $0x80294c
  800a98:	6a 44                	push   $0x44
  800a9a:	68 ec 28 80 00       	push   $0x8028ec
  800a9f:	e8 23 fe ff ff       	call   8008c7 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800aa4:	90                   	nop
  800aa5:	c9                   	leave  
  800aa6:	c3                   	ret    

00800aa7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800aa7:	55                   	push   %ebp
  800aa8:	89 e5                	mov    %esp,%ebp
  800aaa:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800aad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab0:	8b 00                	mov    (%eax),%eax
  800ab2:	8d 48 01             	lea    0x1(%eax),%ecx
  800ab5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ab8:	89 0a                	mov    %ecx,(%edx)
  800aba:	8b 55 08             	mov    0x8(%ebp),%edx
  800abd:	88 d1                	mov    %dl,%cl
  800abf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ac6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac9:	8b 00                	mov    (%eax),%eax
  800acb:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ad0:	75 2c                	jne    800afe <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ad2:	a0 28 30 80 00       	mov    0x803028,%al
  800ad7:	0f b6 c0             	movzbl %al,%eax
  800ada:	8b 55 0c             	mov    0xc(%ebp),%edx
  800add:	8b 12                	mov    (%edx),%edx
  800adf:	89 d1                	mov    %edx,%ecx
  800ae1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae4:	83 c2 08             	add    $0x8,%edx
  800ae7:	83 ec 04             	sub    $0x4,%esp
  800aea:	50                   	push   %eax
  800aeb:	51                   	push   %ecx
  800aec:	52                   	push   %edx
  800aed:	e8 d4 12 00 00       	call   801dc6 <sys_cputs>
  800af2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800af5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800afe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b01:	8b 40 04             	mov    0x4(%eax),%eax
  800b04:	8d 50 01             	lea    0x1(%eax),%edx
  800b07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0a:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b0d:	90                   	nop
  800b0e:	c9                   	leave  
  800b0f:	c3                   	ret    

00800b10 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b10:	55                   	push   %ebp
  800b11:	89 e5                	mov    %esp,%ebp
  800b13:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b19:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b20:	00 00 00 
	b.cnt = 0;
  800b23:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b2a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b2d:	ff 75 0c             	pushl  0xc(%ebp)
  800b30:	ff 75 08             	pushl  0x8(%ebp)
  800b33:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b39:	50                   	push   %eax
  800b3a:	68 a7 0a 80 00       	push   $0x800aa7
  800b3f:	e8 11 02 00 00       	call   800d55 <vprintfmt>
  800b44:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b47:	a0 28 30 80 00       	mov    0x803028,%al
  800b4c:	0f b6 c0             	movzbl %al,%eax
  800b4f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b55:	83 ec 04             	sub    $0x4,%esp
  800b58:	50                   	push   %eax
  800b59:	52                   	push   %edx
  800b5a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b60:	83 c0 08             	add    $0x8,%eax
  800b63:	50                   	push   %eax
  800b64:	e8 5d 12 00 00       	call   801dc6 <sys_cputs>
  800b69:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b6c:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b73:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b79:	c9                   	leave  
  800b7a:	c3                   	ret    

00800b7b <cprintf>:

int cprintf(const char *fmt, ...) {
  800b7b:	55                   	push   %ebp
  800b7c:	89 e5                	mov    %esp,%ebp
  800b7e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b81:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800b88:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	83 ec 08             	sub    $0x8,%esp
  800b94:	ff 75 f4             	pushl  -0xc(%ebp)
  800b97:	50                   	push   %eax
  800b98:	e8 73 ff ff ff       	call   800b10 <vcprintf>
  800b9d:	83 c4 10             	add    $0x10,%esp
  800ba0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ba3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ba6:	c9                   	leave  
  800ba7:	c3                   	ret    

00800ba8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ba8:	55                   	push   %ebp
  800ba9:	89 e5                	mov    %esp,%ebp
  800bab:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bae:	e8 24 14 00 00       	call   801fd7 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bb3:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	83 ec 08             	sub    $0x8,%esp
  800bbf:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc2:	50                   	push   %eax
  800bc3:	e8 48 ff ff ff       	call   800b10 <vcprintf>
  800bc8:	83 c4 10             	add    $0x10,%esp
  800bcb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bce:	e8 1e 14 00 00       	call   801ff1 <sys_enable_interrupt>
	return cnt;
  800bd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bd6:	c9                   	leave  
  800bd7:	c3                   	ret    

00800bd8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bd8:	55                   	push   %ebp
  800bd9:	89 e5                	mov    %esp,%ebp
  800bdb:	53                   	push   %ebx
  800bdc:	83 ec 14             	sub    $0x14,%esp
  800bdf:	8b 45 10             	mov    0x10(%ebp),%eax
  800be2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800be5:	8b 45 14             	mov    0x14(%ebp),%eax
  800be8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800beb:	8b 45 18             	mov    0x18(%ebp),%eax
  800bee:	ba 00 00 00 00       	mov    $0x0,%edx
  800bf3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bf6:	77 55                	ja     800c4d <printnum+0x75>
  800bf8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bfb:	72 05                	jb     800c02 <printnum+0x2a>
  800bfd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c00:	77 4b                	ja     800c4d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c02:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c05:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c08:	8b 45 18             	mov    0x18(%ebp),%eax
  800c0b:	ba 00 00 00 00       	mov    $0x0,%edx
  800c10:	52                   	push   %edx
  800c11:	50                   	push   %eax
  800c12:	ff 75 f4             	pushl  -0xc(%ebp)
  800c15:	ff 75 f0             	pushl  -0x10(%ebp)
  800c18:	e8 9b 17 00 00       	call   8023b8 <__udivdi3>
  800c1d:	83 c4 10             	add    $0x10,%esp
  800c20:	83 ec 04             	sub    $0x4,%esp
  800c23:	ff 75 20             	pushl  0x20(%ebp)
  800c26:	53                   	push   %ebx
  800c27:	ff 75 18             	pushl  0x18(%ebp)
  800c2a:	52                   	push   %edx
  800c2b:	50                   	push   %eax
  800c2c:	ff 75 0c             	pushl  0xc(%ebp)
  800c2f:	ff 75 08             	pushl  0x8(%ebp)
  800c32:	e8 a1 ff ff ff       	call   800bd8 <printnum>
  800c37:	83 c4 20             	add    $0x20,%esp
  800c3a:	eb 1a                	jmp    800c56 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c3c:	83 ec 08             	sub    $0x8,%esp
  800c3f:	ff 75 0c             	pushl  0xc(%ebp)
  800c42:	ff 75 20             	pushl  0x20(%ebp)
  800c45:	8b 45 08             	mov    0x8(%ebp),%eax
  800c48:	ff d0                	call   *%eax
  800c4a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c4d:	ff 4d 1c             	decl   0x1c(%ebp)
  800c50:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c54:	7f e6                	jg     800c3c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c56:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c59:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c61:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c64:	53                   	push   %ebx
  800c65:	51                   	push   %ecx
  800c66:	52                   	push   %edx
  800c67:	50                   	push   %eax
  800c68:	e8 5b 18 00 00       	call   8024c8 <__umoddi3>
  800c6d:	83 c4 10             	add    $0x10,%esp
  800c70:	05 b4 2b 80 00       	add    $0x802bb4,%eax
  800c75:	8a 00                	mov    (%eax),%al
  800c77:	0f be c0             	movsbl %al,%eax
  800c7a:	83 ec 08             	sub    $0x8,%esp
  800c7d:	ff 75 0c             	pushl  0xc(%ebp)
  800c80:	50                   	push   %eax
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	ff d0                	call   *%eax
  800c86:	83 c4 10             	add    $0x10,%esp
}
  800c89:	90                   	nop
  800c8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c8d:	c9                   	leave  
  800c8e:	c3                   	ret    

00800c8f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c8f:	55                   	push   %ebp
  800c90:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c92:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c96:	7e 1c                	jle    800cb4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c98:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9b:	8b 00                	mov    (%eax),%eax
  800c9d:	8d 50 08             	lea    0x8(%eax),%edx
  800ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca3:	89 10                	mov    %edx,(%eax)
  800ca5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca8:	8b 00                	mov    (%eax),%eax
  800caa:	83 e8 08             	sub    $0x8,%eax
  800cad:	8b 50 04             	mov    0x4(%eax),%edx
  800cb0:	8b 00                	mov    (%eax),%eax
  800cb2:	eb 40                	jmp    800cf4 <getuint+0x65>
	else if (lflag)
  800cb4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cb8:	74 1e                	je     800cd8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cba:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbd:	8b 00                	mov    (%eax),%eax
  800cbf:	8d 50 04             	lea    0x4(%eax),%edx
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	89 10                	mov    %edx,(%eax)
  800cc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cca:	8b 00                	mov    (%eax),%eax
  800ccc:	83 e8 04             	sub    $0x4,%eax
  800ccf:	8b 00                	mov    (%eax),%eax
  800cd1:	ba 00 00 00 00       	mov    $0x0,%edx
  800cd6:	eb 1c                	jmp    800cf4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	8b 00                	mov    (%eax),%eax
  800cdd:	8d 50 04             	lea    0x4(%eax),%edx
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	89 10                	mov    %edx,(%eax)
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	8b 00                	mov    (%eax),%eax
  800cea:	83 e8 04             	sub    $0x4,%eax
  800ced:	8b 00                	mov    (%eax),%eax
  800cef:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cf4:	5d                   	pop    %ebp
  800cf5:	c3                   	ret    

00800cf6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cf6:	55                   	push   %ebp
  800cf7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cf9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cfd:	7e 1c                	jle    800d1b <getint+0x25>
		return va_arg(*ap, long long);
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	8b 00                	mov    (%eax),%eax
  800d04:	8d 50 08             	lea    0x8(%eax),%edx
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	89 10                	mov    %edx,(%eax)
  800d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0f:	8b 00                	mov    (%eax),%eax
  800d11:	83 e8 08             	sub    $0x8,%eax
  800d14:	8b 50 04             	mov    0x4(%eax),%edx
  800d17:	8b 00                	mov    (%eax),%eax
  800d19:	eb 38                	jmp    800d53 <getint+0x5d>
	else if (lflag)
  800d1b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d1f:	74 1a                	je     800d3b <getint+0x45>
		return va_arg(*ap, long);
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	8b 00                	mov    (%eax),%eax
  800d26:	8d 50 04             	lea    0x4(%eax),%edx
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	89 10                	mov    %edx,(%eax)
  800d2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d31:	8b 00                	mov    (%eax),%eax
  800d33:	83 e8 04             	sub    $0x4,%eax
  800d36:	8b 00                	mov    (%eax),%eax
  800d38:	99                   	cltd   
  800d39:	eb 18                	jmp    800d53 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	8b 00                	mov    (%eax),%eax
  800d40:	8d 50 04             	lea    0x4(%eax),%edx
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	89 10                	mov    %edx,(%eax)
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	8b 00                	mov    (%eax),%eax
  800d4d:	83 e8 04             	sub    $0x4,%eax
  800d50:	8b 00                	mov    (%eax),%eax
  800d52:	99                   	cltd   
}
  800d53:	5d                   	pop    %ebp
  800d54:	c3                   	ret    

00800d55 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d55:	55                   	push   %ebp
  800d56:	89 e5                	mov    %esp,%ebp
  800d58:	56                   	push   %esi
  800d59:	53                   	push   %ebx
  800d5a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d5d:	eb 17                	jmp    800d76 <vprintfmt+0x21>
			if (ch == '\0')
  800d5f:	85 db                	test   %ebx,%ebx
  800d61:	0f 84 af 03 00 00    	je     801116 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d67:	83 ec 08             	sub    $0x8,%esp
  800d6a:	ff 75 0c             	pushl  0xc(%ebp)
  800d6d:	53                   	push   %ebx
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	ff d0                	call   *%eax
  800d73:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d76:	8b 45 10             	mov    0x10(%ebp),%eax
  800d79:	8d 50 01             	lea    0x1(%eax),%edx
  800d7c:	89 55 10             	mov    %edx,0x10(%ebp)
  800d7f:	8a 00                	mov    (%eax),%al
  800d81:	0f b6 d8             	movzbl %al,%ebx
  800d84:	83 fb 25             	cmp    $0x25,%ebx
  800d87:	75 d6                	jne    800d5f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d89:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d8d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d94:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d9b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800da2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800da9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dac:	8d 50 01             	lea    0x1(%eax),%edx
  800daf:	89 55 10             	mov    %edx,0x10(%ebp)
  800db2:	8a 00                	mov    (%eax),%al
  800db4:	0f b6 d8             	movzbl %al,%ebx
  800db7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dba:	83 f8 55             	cmp    $0x55,%eax
  800dbd:	0f 87 2b 03 00 00    	ja     8010ee <vprintfmt+0x399>
  800dc3:	8b 04 85 d8 2b 80 00 	mov    0x802bd8(,%eax,4),%eax
  800dca:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dcc:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dd0:	eb d7                	jmp    800da9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800dd2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800dd6:	eb d1                	jmp    800da9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dd8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ddf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800de2:	89 d0                	mov    %edx,%eax
  800de4:	c1 e0 02             	shl    $0x2,%eax
  800de7:	01 d0                	add    %edx,%eax
  800de9:	01 c0                	add    %eax,%eax
  800deb:	01 d8                	add    %ebx,%eax
  800ded:	83 e8 30             	sub    $0x30,%eax
  800df0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800df3:	8b 45 10             	mov    0x10(%ebp),%eax
  800df6:	8a 00                	mov    (%eax),%al
  800df8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800dfb:	83 fb 2f             	cmp    $0x2f,%ebx
  800dfe:	7e 3e                	jle    800e3e <vprintfmt+0xe9>
  800e00:	83 fb 39             	cmp    $0x39,%ebx
  800e03:	7f 39                	jg     800e3e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e05:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e08:	eb d5                	jmp    800ddf <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e0a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e0d:	83 c0 04             	add    $0x4,%eax
  800e10:	89 45 14             	mov    %eax,0x14(%ebp)
  800e13:	8b 45 14             	mov    0x14(%ebp),%eax
  800e16:	83 e8 04             	sub    $0x4,%eax
  800e19:	8b 00                	mov    (%eax),%eax
  800e1b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e1e:	eb 1f                	jmp    800e3f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e20:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e24:	79 83                	jns    800da9 <vprintfmt+0x54>
				width = 0;
  800e26:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e2d:	e9 77 ff ff ff       	jmp    800da9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e32:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e39:	e9 6b ff ff ff       	jmp    800da9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e3e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e3f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e43:	0f 89 60 ff ff ff    	jns    800da9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e49:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e4c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e4f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e56:	e9 4e ff ff ff       	jmp    800da9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e5b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e5e:	e9 46 ff ff ff       	jmp    800da9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e63:	8b 45 14             	mov    0x14(%ebp),%eax
  800e66:	83 c0 04             	add    $0x4,%eax
  800e69:	89 45 14             	mov    %eax,0x14(%ebp)
  800e6c:	8b 45 14             	mov    0x14(%ebp),%eax
  800e6f:	83 e8 04             	sub    $0x4,%eax
  800e72:	8b 00                	mov    (%eax),%eax
  800e74:	83 ec 08             	sub    $0x8,%esp
  800e77:	ff 75 0c             	pushl  0xc(%ebp)
  800e7a:	50                   	push   %eax
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7e:	ff d0                	call   *%eax
  800e80:	83 c4 10             	add    $0x10,%esp
			break;
  800e83:	e9 89 02 00 00       	jmp    801111 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e88:	8b 45 14             	mov    0x14(%ebp),%eax
  800e8b:	83 c0 04             	add    $0x4,%eax
  800e8e:	89 45 14             	mov    %eax,0x14(%ebp)
  800e91:	8b 45 14             	mov    0x14(%ebp),%eax
  800e94:	83 e8 04             	sub    $0x4,%eax
  800e97:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e99:	85 db                	test   %ebx,%ebx
  800e9b:	79 02                	jns    800e9f <vprintfmt+0x14a>
				err = -err;
  800e9d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e9f:	83 fb 64             	cmp    $0x64,%ebx
  800ea2:	7f 0b                	jg     800eaf <vprintfmt+0x15a>
  800ea4:	8b 34 9d 20 2a 80 00 	mov    0x802a20(,%ebx,4),%esi
  800eab:	85 f6                	test   %esi,%esi
  800ead:	75 19                	jne    800ec8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800eaf:	53                   	push   %ebx
  800eb0:	68 c5 2b 80 00       	push   $0x802bc5
  800eb5:	ff 75 0c             	pushl  0xc(%ebp)
  800eb8:	ff 75 08             	pushl  0x8(%ebp)
  800ebb:	e8 5e 02 00 00       	call   80111e <printfmt>
  800ec0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ec3:	e9 49 02 00 00       	jmp    801111 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ec8:	56                   	push   %esi
  800ec9:	68 ce 2b 80 00       	push   $0x802bce
  800ece:	ff 75 0c             	pushl  0xc(%ebp)
  800ed1:	ff 75 08             	pushl  0x8(%ebp)
  800ed4:	e8 45 02 00 00       	call   80111e <printfmt>
  800ed9:	83 c4 10             	add    $0x10,%esp
			break;
  800edc:	e9 30 02 00 00       	jmp    801111 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ee1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee4:	83 c0 04             	add    $0x4,%eax
  800ee7:	89 45 14             	mov    %eax,0x14(%ebp)
  800eea:	8b 45 14             	mov    0x14(%ebp),%eax
  800eed:	83 e8 04             	sub    $0x4,%eax
  800ef0:	8b 30                	mov    (%eax),%esi
  800ef2:	85 f6                	test   %esi,%esi
  800ef4:	75 05                	jne    800efb <vprintfmt+0x1a6>
				p = "(null)";
  800ef6:	be d1 2b 80 00       	mov    $0x802bd1,%esi
			if (width > 0 && padc != '-')
  800efb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800eff:	7e 6d                	jle    800f6e <vprintfmt+0x219>
  800f01:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f05:	74 67                	je     800f6e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f07:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f0a:	83 ec 08             	sub    $0x8,%esp
  800f0d:	50                   	push   %eax
  800f0e:	56                   	push   %esi
  800f0f:	e8 12 05 00 00       	call   801426 <strnlen>
  800f14:	83 c4 10             	add    $0x10,%esp
  800f17:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f1a:	eb 16                	jmp    800f32 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f1c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f20:	83 ec 08             	sub    $0x8,%esp
  800f23:	ff 75 0c             	pushl  0xc(%ebp)
  800f26:	50                   	push   %eax
  800f27:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2a:	ff d0                	call   *%eax
  800f2c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f2f:	ff 4d e4             	decl   -0x1c(%ebp)
  800f32:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f36:	7f e4                	jg     800f1c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f38:	eb 34                	jmp    800f6e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f3a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f3e:	74 1c                	je     800f5c <vprintfmt+0x207>
  800f40:	83 fb 1f             	cmp    $0x1f,%ebx
  800f43:	7e 05                	jle    800f4a <vprintfmt+0x1f5>
  800f45:	83 fb 7e             	cmp    $0x7e,%ebx
  800f48:	7e 12                	jle    800f5c <vprintfmt+0x207>
					putch('?', putdat);
  800f4a:	83 ec 08             	sub    $0x8,%esp
  800f4d:	ff 75 0c             	pushl  0xc(%ebp)
  800f50:	6a 3f                	push   $0x3f
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	ff d0                	call   *%eax
  800f57:	83 c4 10             	add    $0x10,%esp
  800f5a:	eb 0f                	jmp    800f6b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f5c:	83 ec 08             	sub    $0x8,%esp
  800f5f:	ff 75 0c             	pushl  0xc(%ebp)
  800f62:	53                   	push   %ebx
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
  800f66:	ff d0                	call   *%eax
  800f68:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f6b:	ff 4d e4             	decl   -0x1c(%ebp)
  800f6e:	89 f0                	mov    %esi,%eax
  800f70:	8d 70 01             	lea    0x1(%eax),%esi
  800f73:	8a 00                	mov    (%eax),%al
  800f75:	0f be d8             	movsbl %al,%ebx
  800f78:	85 db                	test   %ebx,%ebx
  800f7a:	74 24                	je     800fa0 <vprintfmt+0x24b>
  800f7c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f80:	78 b8                	js     800f3a <vprintfmt+0x1e5>
  800f82:	ff 4d e0             	decl   -0x20(%ebp)
  800f85:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f89:	79 af                	jns    800f3a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f8b:	eb 13                	jmp    800fa0 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f8d:	83 ec 08             	sub    $0x8,%esp
  800f90:	ff 75 0c             	pushl  0xc(%ebp)
  800f93:	6a 20                	push   $0x20
  800f95:	8b 45 08             	mov    0x8(%ebp),%eax
  800f98:	ff d0                	call   *%eax
  800f9a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f9d:	ff 4d e4             	decl   -0x1c(%ebp)
  800fa0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fa4:	7f e7                	jg     800f8d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fa6:	e9 66 01 00 00       	jmp    801111 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fab:	83 ec 08             	sub    $0x8,%esp
  800fae:	ff 75 e8             	pushl  -0x18(%ebp)
  800fb1:	8d 45 14             	lea    0x14(%ebp),%eax
  800fb4:	50                   	push   %eax
  800fb5:	e8 3c fd ff ff       	call   800cf6 <getint>
  800fba:	83 c4 10             	add    $0x10,%esp
  800fbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fc6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc9:	85 d2                	test   %edx,%edx
  800fcb:	79 23                	jns    800ff0 <vprintfmt+0x29b>
				putch('-', putdat);
  800fcd:	83 ec 08             	sub    $0x8,%esp
  800fd0:	ff 75 0c             	pushl  0xc(%ebp)
  800fd3:	6a 2d                	push   $0x2d
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd8:	ff d0                	call   *%eax
  800fda:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fdd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fe0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fe3:	f7 d8                	neg    %eax
  800fe5:	83 d2 00             	adc    $0x0,%edx
  800fe8:	f7 da                	neg    %edx
  800fea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fed:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ff0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ff7:	e9 bc 00 00 00       	jmp    8010b8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ffc:	83 ec 08             	sub    $0x8,%esp
  800fff:	ff 75 e8             	pushl  -0x18(%ebp)
  801002:	8d 45 14             	lea    0x14(%ebp),%eax
  801005:	50                   	push   %eax
  801006:	e8 84 fc ff ff       	call   800c8f <getuint>
  80100b:	83 c4 10             	add    $0x10,%esp
  80100e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801011:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801014:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80101b:	e9 98 00 00 00       	jmp    8010b8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801020:	83 ec 08             	sub    $0x8,%esp
  801023:	ff 75 0c             	pushl  0xc(%ebp)
  801026:	6a 58                	push   $0x58
  801028:	8b 45 08             	mov    0x8(%ebp),%eax
  80102b:	ff d0                	call   *%eax
  80102d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801030:	83 ec 08             	sub    $0x8,%esp
  801033:	ff 75 0c             	pushl  0xc(%ebp)
  801036:	6a 58                	push   $0x58
  801038:	8b 45 08             	mov    0x8(%ebp),%eax
  80103b:	ff d0                	call   *%eax
  80103d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801040:	83 ec 08             	sub    $0x8,%esp
  801043:	ff 75 0c             	pushl  0xc(%ebp)
  801046:	6a 58                	push   $0x58
  801048:	8b 45 08             	mov    0x8(%ebp),%eax
  80104b:	ff d0                	call   *%eax
  80104d:	83 c4 10             	add    $0x10,%esp
			break;
  801050:	e9 bc 00 00 00       	jmp    801111 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801055:	83 ec 08             	sub    $0x8,%esp
  801058:	ff 75 0c             	pushl  0xc(%ebp)
  80105b:	6a 30                	push   $0x30
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	ff d0                	call   *%eax
  801062:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801065:	83 ec 08             	sub    $0x8,%esp
  801068:	ff 75 0c             	pushl  0xc(%ebp)
  80106b:	6a 78                	push   $0x78
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	ff d0                	call   *%eax
  801072:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801075:	8b 45 14             	mov    0x14(%ebp),%eax
  801078:	83 c0 04             	add    $0x4,%eax
  80107b:	89 45 14             	mov    %eax,0x14(%ebp)
  80107e:	8b 45 14             	mov    0x14(%ebp),%eax
  801081:	83 e8 04             	sub    $0x4,%eax
  801084:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801086:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801089:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801090:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801097:	eb 1f                	jmp    8010b8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801099:	83 ec 08             	sub    $0x8,%esp
  80109c:	ff 75 e8             	pushl  -0x18(%ebp)
  80109f:	8d 45 14             	lea    0x14(%ebp),%eax
  8010a2:	50                   	push   %eax
  8010a3:	e8 e7 fb ff ff       	call   800c8f <getuint>
  8010a8:	83 c4 10             	add    $0x10,%esp
  8010ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010b1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010b8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010bc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010bf:	83 ec 04             	sub    $0x4,%esp
  8010c2:	52                   	push   %edx
  8010c3:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010c6:	50                   	push   %eax
  8010c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8010ca:	ff 75 f0             	pushl  -0x10(%ebp)
  8010cd:	ff 75 0c             	pushl  0xc(%ebp)
  8010d0:	ff 75 08             	pushl  0x8(%ebp)
  8010d3:	e8 00 fb ff ff       	call   800bd8 <printnum>
  8010d8:	83 c4 20             	add    $0x20,%esp
			break;
  8010db:	eb 34                	jmp    801111 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010dd:	83 ec 08             	sub    $0x8,%esp
  8010e0:	ff 75 0c             	pushl  0xc(%ebp)
  8010e3:	53                   	push   %ebx
  8010e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e7:	ff d0                	call   *%eax
  8010e9:	83 c4 10             	add    $0x10,%esp
			break;
  8010ec:	eb 23                	jmp    801111 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010ee:	83 ec 08             	sub    $0x8,%esp
  8010f1:	ff 75 0c             	pushl  0xc(%ebp)
  8010f4:	6a 25                	push   $0x25
  8010f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f9:	ff d0                	call   *%eax
  8010fb:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8010fe:	ff 4d 10             	decl   0x10(%ebp)
  801101:	eb 03                	jmp    801106 <vprintfmt+0x3b1>
  801103:	ff 4d 10             	decl   0x10(%ebp)
  801106:	8b 45 10             	mov    0x10(%ebp),%eax
  801109:	48                   	dec    %eax
  80110a:	8a 00                	mov    (%eax),%al
  80110c:	3c 25                	cmp    $0x25,%al
  80110e:	75 f3                	jne    801103 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801110:	90                   	nop
		}
	}
  801111:	e9 47 fc ff ff       	jmp    800d5d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801116:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801117:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80111a:	5b                   	pop    %ebx
  80111b:	5e                   	pop    %esi
  80111c:	5d                   	pop    %ebp
  80111d:	c3                   	ret    

0080111e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80111e:	55                   	push   %ebp
  80111f:	89 e5                	mov    %esp,%ebp
  801121:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801124:	8d 45 10             	lea    0x10(%ebp),%eax
  801127:	83 c0 04             	add    $0x4,%eax
  80112a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80112d:	8b 45 10             	mov    0x10(%ebp),%eax
  801130:	ff 75 f4             	pushl  -0xc(%ebp)
  801133:	50                   	push   %eax
  801134:	ff 75 0c             	pushl  0xc(%ebp)
  801137:	ff 75 08             	pushl  0x8(%ebp)
  80113a:	e8 16 fc ff ff       	call   800d55 <vprintfmt>
  80113f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801142:	90                   	nop
  801143:	c9                   	leave  
  801144:	c3                   	ret    

00801145 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801145:	55                   	push   %ebp
  801146:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801148:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114b:	8b 40 08             	mov    0x8(%eax),%eax
  80114e:	8d 50 01             	lea    0x1(%eax),%edx
  801151:	8b 45 0c             	mov    0xc(%ebp),%eax
  801154:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801157:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115a:	8b 10                	mov    (%eax),%edx
  80115c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115f:	8b 40 04             	mov    0x4(%eax),%eax
  801162:	39 c2                	cmp    %eax,%edx
  801164:	73 12                	jae    801178 <sprintputch+0x33>
		*b->buf++ = ch;
  801166:	8b 45 0c             	mov    0xc(%ebp),%eax
  801169:	8b 00                	mov    (%eax),%eax
  80116b:	8d 48 01             	lea    0x1(%eax),%ecx
  80116e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801171:	89 0a                	mov    %ecx,(%edx)
  801173:	8b 55 08             	mov    0x8(%ebp),%edx
  801176:	88 10                	mov    %dl,(%eax)
}
  801178:	90                   	nop
  801179:	5d                   	pop    %ebp
  80117a:	c3                   	ret    

0080117b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80117b:	55                   	push   %ebp
  80117c:	89 e5                	mov    %esp,%ebp
  80117e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801181:	8b 45 08             	mov    0x8(%ebp),%eax
  801184:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801187:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80118d:	8b 45 08             	mov    0x8(%ebp),%eax
  801190:	01 d0                	add    %edx,%eax
  801192:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801195:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80119c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011a0:	74 06                	je     8011a8 <vsnprintf+0x2d>
  8011a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011a6:	7f 07                	jg     8011af <vsnprintf+0x34>
		return -E_INVAL;
  8011a8:	b8 03 00 00 00       	mov    $0x3,%eax
  8011ad:	eb 20                	jmp    8011cf <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011af:	ff 75 14             	pushl  0x14(%ebp)
  8011b2:	ff 75 10             	pushl  0x10(%ebp)
  8011b5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011b8:	50                   	push   %eax
  8011b9:	68 45 11 80 00       	push   $0x801145
  8011be:	e8 92 fb ff ff       	call   800d55 <vprintfmt>
  8011c3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011c9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011cf:	c9                   	leave  
  8011d0:	c3                   	ret    

008011d1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011d1:	55                   	push   %ebp
  8011d2:	89 e5                	mov    %esp,%ebp
  8011d4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011d7:	8d 45 10             	lea    0x10(%ebp),%eax
  8011da:	83 c0 04             	add    $0x4,%eax
  8011dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e3:	ff 75 f4             	pushl  -0xc(%ebp)
  8011e6:	50                   	push   %eax
  8011e7:	ff 75 0c             	pushl  0xc(%ebp)
  8011ea:	ff 75 08             	pushl  0x8(%ebp)
  8011ed:	e8 89 ff ff ff       	call   80117b <vsnprintf>
  8011f2:	83 c4 10             	add    $0x10,%esp
  8011f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011fb:	c9                   	leave  
  8011fc:	c3                   	ret    

008011fd <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8011fd:	55                   	push   %ebp
  8011fe:	89 e5                	mov    %esp,%ebp
  801200:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801203:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801207:	74 13                	je     80121c <readline+0x1f>
		cprintf("%s", prompt);
  801209:	83 ec 08             	sub    $0x8,%esp
  80120c:	ff 75 08             	pushl  0x8(%ebp)
  80120f:	68 30 2d 80 00       	push   $0x802d30
  801214:	e8 62 f9 ff ff       	call   800b7b <cprintf>
  801219:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80121c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801223:	83 ec 0c             	sub    $0xc,%esp
  801226:	6a 00                	push   $0x0
  801228:	e8 8e f5 ff ff       	call   8007bb <iscons>
  80122d:	83 c4 10             	add    $0x10,%esp
  801230:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801233:	e8 35 f5 ff ff       	call   80076d <getchar>
  801238:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80123b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80123f:	79 22                	jns    801263 <readline+0x66>
			if (c != -E_EOF)
  801241:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801245:	0f 84 ad 00 00 00    	je     8012f8 <readline+0xfb>
				cprintf("read error: %e\n", c);
  80124b:	83 ec 08             	sub    $0x8,%esp
  80124e:	ff 75 ec             	pushl  -0x14(%ebp)
  801251:	68 33 2d 80 00       	push   $0x802d33
  801256:	e8 20 f9 ff ff       	call   800b7b <cprintf>
  80125b:	83 c4 10             	add    $0x10,%esp
			return;
  80125e:	e9 95 00 00 00       	jmp    8012f8 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801263:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801267:	7e 34                	jle    80129d <readline+0xa0>
  801269:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801270:	7f 2b                	jg     80129d <readline+0xa0>
			if (echoing)
  801272:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801276:	74 0e                	je     801286 <readline+0x89>
				cputchar(c);
  801278:	83 ec 0c             	sub    $0xc,%esp
  80127b:	ff 75 ec             	pushl  -0x14(%ebp)
  80127e:	e8 a2 f4 ff ff       	call   800725 <cputchar>
  801283:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801286:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801289:	8d 50 01             	lea    0x1(%eax),%edx
  80128c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80128f:	89 c2                	mov    %eax,%edx
  801291:	8b 45 0c             	mov    0xc(%ebp),%eax
  801294:	01 d0                	add    %edx,%eax
  801296:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801299:	88 10                	mov    %dl,(%eax)
  80129b:	eb 56                	jmp    8012f3 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80129d:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012a1:	75 1f                	jne    8012c2 <readline+0xc5>
  8012a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012a7:	7e 19                	jle    8012c2 <readline+0xc5>
			if (echoing)
  8012a9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012ad:	74 0e                	je     8012bd <readline+0xc0>
				cputchar(c);
  8012af:	83 ec 0c             	sub    $0xc,%esp
  8012b2:	ff 75 ec             	pushl  -0x14(%ebp)
  8012b5:	e8 6b f4 ff ff       	call   800725 <cputchar>
  8012ba:	83 c4 10             	add    $0x10,%esp

			i--;
  8012bd:	ff 4d f4             	decl   -0xc(%ebp)
  8012c0:	eb 31                	jmp    8012f3 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012c2:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012c6:	74 0a                	je     8012d2 <readline+0xd5>
  8012c8:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012cc:	0f 85 61 ff ff ff    	jne    801233 <readline+0x36>
			if (echoing)
  8012d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012d6:	74 0e                	je     8012e6 <readline+0xe9>
				cputchar(c);
  8012d8:	83 ec 0c             	sub    $0xc,%esp
  8012db:	ff 75 ec             	pushl  -0x14(%ebp)
  8012de:	e8 42 f4 ff ff       	call   800725 <cputchar>
  8012e3:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8012e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ec:	01 d0                	add    %edx,%eax
  8012ee:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8012f1:	eb 06                	jmp    8012f9 <readline+0xfc>
		}
	}
  8012f3:	e9 3b ff ff ff       	jmp    801233 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8012f8:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8012f9:	c9                   	leave  
  8012fa:	c3                   	ret    

008012fb <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8012fb:	55                   	push   %ebp
  8012fc:	89 e5                	mov    %esp,%ebp
  8012fe:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801301:	e8 d1 0c 00 00       	call   801fd7 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801306:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80130a:	74 13                	je     80131f <atomic_readline+0x24>
		cprintf("%s", prompt);
  80130c:	83 ec 08             	sub    $0x8,%esp
  80130f:	ff 75 08             	pushl  0x8(%ebp)
  801312:	68 30 2d 80 00       	push   $0x802d30
  801317:	e8 5f f8 ff ff       	call   800b7b <cprintf>
  80131c:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80131f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801326:	83 ec 0c             	sub    $0xc,%esp
  801329:	6a 00                	push   $0x0
  80132b:	e8 8b f4 ff ff       	call   8007bb <iscons>
  801330:	83 c4 10             	add    $0x10,%esp
  801333:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801336:	e8 32 f4 ff ff       	call   80076d <getchar>
  80133b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80133e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801342:	79 23                	jns    801367 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801344:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801348:	74 13                	je     80135d <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80134a:	83 ec 08             	sub    $0x8,%esp
  80134d:	ff 75 ec             	pushl  -0x14(%ebp)
  801350:	68 33 2d 80 00       	push   $0x802d33
  801355:	e8 21 f8 ff ff       	call   800b7b <cprintf>
  80135a:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80135d:	e8 8f 0c 00 00       	call   801ff1 <sys_enable_interrupt>
			return;
  801362:	e9 9a 00 00 00       	jmp    801401 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801367:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80136b:	7e 34                	jle    8013a1 <atomic_readline+0xa6>
  80136d:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801374:	7f 2b                	jg     8013a1 <atomic_readline+0xa6>
			if (echoing)
  801376:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80137a:	74 0e                	je     80138a <atomic_readline+0x8f>
				cputchar(c);
  80137c:	83 ec 0c             	sub    $0xc,%esp
  80137f:	ff 75 ec             	pushl  -0x14(%ebp)
  801382:	e8 9e f3 ff ff       	call   800725 <cputchar>
  801387:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80138a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80138d:	8d 50 01             	lea    0x1(%eax),%edx
  801390:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801393:	89 c2                	mov    %eax,%edx
  801395:	8b 45 0c             	mov    0xc(%ebp),%eax
  801398:	01 d0                	add    %edx,%eax
  80139a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80139d:	88 10                	mov    %dl,(%eax)
  80139f:	eb 5b                	jmp    8013fc <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8013a1:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013a5:	75 1f                	jne    8013c6 <atomic_readline+0xcb>
  8013a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013ab:	7e 19                	jle    8013c6 <atomic_readline+0xcb>
			if (echoing)
  8013ad:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013b1:	74 0e                	je     8013c1 <atomic_readline+0xc6>
				cputchar(c);
  8013b3:	83 ec 0c             	sub    $0xc,%esp
  8013b6:	ff 75 ec             	pushl  -0x14(%ebp)
  8013b9:	e8 67 f3 ff ff       	call   800725 <cputchar>
  8013be:	83 c4 10             	add    $0x10,%esp
			i--;
  8013c1:	ff 4d f4             	decl   -0xc(%ebp)
  8013c4:	eb 36                	jmp    8013fc <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013c6:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013ca:	74 0a                	je     8013d6 <atomic_readline+0xdb>
  8013cc:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013d0:	0f 85 60 ff ff ff    	jne    801336 <atomic_readline+0x3b>
			if (echoing)
  8013d6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013da:	74 0e                	je     8013ea <atomic_readline+0xef>
				cputchar(c);
  8013dc:	83 ec 0c             	sub    $0xc,%esp
  8013df:	ff 75 ec             	pushl  -0x14(%ebp)
  8013e2:	e8 3e f3 ff ff       	call   800725 <cputchar>
  8013e7:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8013ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f0:	01 d0                	add    %edx,%eax
  8013f2:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8013f5:	e8 f7 0b 00 00       	call   801ff1 <sys_enable_interrupt>
			return;
  8013fa:	eb 05                	jmp    801401 <atomic_readline+0x106>
		}
	}
  8013fc:	e9 35 ff ff ff       	jmp    801336 <atomic_readline+0x3b>
}
  801401:	c9                   	leave  
  801402:	c3                   	ret    

00801403 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801403:	55                   	push   %ebp
  801404:	89 e5                	mov    %esp,%ebp
  801406:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801409:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801410:	eb 06                	jmp    801418 <strlen+0x15>
		n++;
  801412:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801415:	ff 45 08             	incl   0x8(%ebp)
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	8a 00                	mov    (%eax),%al
  80141d:	84 c0                	test   %al,%al
  80141f:	75 f1                	jne    801412 <strlen+0xf>
		n++;
	return n;
  801421:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801424:	c9                   	leave  
  801425:	c3                   	ret    

00801426 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801426:	55                   	push   %ebp
  801427:	89 e5                	mov    %esp,%ebp
  801429:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80142c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801433:	eb 09                	jmp    80143e <strnlen+0x18>
		n++;
  801435:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801438:	ff 45 08             	incl   0x8(%ebp)
  80143b:	ff 4d 0c             	decl   0xc(%ebp)
  80143e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801442:	74 09                	je     80144d <strnlen+0x27>
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	8a 00                	mov    (%eax),%al
  801449:	84 c0                	test   %al,%al
  80144b:	75 e8                	jne    801435 <strnlen+0xf>
		n++;
	return n;
  80144d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801450:	c9                   	leave  
  801451:	c3                   	ret    

00801452 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801452:	55                   	push   %ebp
  801453:	89 e5                	mov    %esp,%ebp
  801455:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801458:	8b 45 08             	mov    0x8(%ebp),%eax
  80145b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80145e:	90                   	nop
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	8d 50 01             	lea    0x1(%eax),%edx
  801465:	89 55 08             	mov    %edx,0x8(%ebp)
  801468:	8b 55 0c             	mov    0xc(%ebp),%edx
  80146b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80146e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801471:	8a 12                	mov    (%edx),%dl
  801473:	88 10                	mov    %dl,(%eax)
  801475:	8a 00                	mov    (%eax),%al
  801477:	84 c0                	test   %al,%al
  801479:	75 e4                	jne    80145f <strcpy+0xd>
		/* do nothing */;
	return ret;
  80147b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80147e:	c9                   	leave  
  80147f:	c3                   	ret    

00801480 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801480:	55                   	push   %ebp
  801481:	89 e5                	mov    %esp,%ebp
  801483:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80148c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801493:	eb 1f                	jmp    8014b4 <strncpy+0x34>
		*dst++ = *src;
  801495:	8b 45 08             	mov    0x8(%ebp),%eax
  801498:	8d 50 01             	lea    0x1(%eax),%edx
  80149b:	89 55 08             	mov    %edx,0x8(%ebp)
  80149e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014a1:	8a 12                	mov    (%edx),%dl
  8014a3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a8:	8a 00                	mov    (%eax),%al
  8014aa:	84 c0                	test   %al,%al
  8014ac:	74 03                	je     8014b1 <strncpy+0x31>
			src++;
  8014ae:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014b1:	ff 45 fc             	incl   -0x4(%ebp)
  8014b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014ba:	72 d9                	jb     801495 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014bf:	c9                   	leave  
  8014c0:	c3                   	ret    

008014c1 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014c1:	55                   	push   %ebp
  8014c2:	89 e5                	mov    %esp,%ebp
  8014c4:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014cd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014d1:	74 30                	je     801503 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014d3:	eb 16                	jmp    8014eb <strlcpy+0x2a>
			*dst++ = *src++;
  8014d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d8:	8d 50 01             	lea    0x1(%eax),%edx
  8014db:	89 55 08             	mov    %edx,0x8(%ebp)
  8014de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014e4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014e7:	8a 12                	mov    (%edx),%dl
  8014e9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8014eb:	ff 4d 10             	decl   0x10(%ebp)
  8014ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014f2:	74 09                	je     8014fd <strlcpy+0x3c>
  8014f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f7:	8a 00                	mov    (%eax),%al
  8014f9:	84 c0                	test   %al,%al
  8014fb:	75 d8                	jne    8014d5 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8014fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801500:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801503:	8b 55 08             	mov    0x8(%ebp),%edx
  801506:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801509:	29 c2                	sub    %eax,%edx
  80150b:	89 d0                	mov    %edx,%eax
}
  80150d:	c9                   	leave  
  80150e:	c3                   	ret    

0080150f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80150f:	55                   	push   %ebp
  801510:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801512:	eb 06                	jmp    80151a <strcmp+0xb>
		p++, q++;
  801514:	ff 45 08             	incl   0x8(%ebp)
  801517:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80151a:	8b 45 08             	mov    0x8(%ebp),%eax
  80151d:	8a 00                	mov    (%eax),%al
  80151f:	84 c0                	test   %al,%al
  801521:	74 0e                	je     801531 <strcmp+0x22>
  801523:	8b 45 08             	mov    0x8(%ebp),%eax
  801526:	8a 10                	mov    (%eax),%dl
  801528:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152b:	8a 00                	mov    (%eax),%al
  80152d:	38 c2                	cmp    %al,%dl
  80152f:	74 e3                	je     801514 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801531:	8b 45 08             	mov    0x8(%ebp),%eax
  801534:	8a 00                	mov    (%eax),%al
  801536:	0f b6 d0             	movzbl %al,%edx
  801539:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153c:	8a 00                	mov    (%eax),%al
  80153e:	0f b6 c0             	movzbl %al,%eax
  801541:	29 c2                	sub    %eax,%edx
  801543:	89 d0                	mov    %edx,%eax
}
  801545:	5d                   	pop    %ebp
  801546:	c3                   	ret    

00801547 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801547:	55                   	push   %ebp
  801548:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80154a:	eb 09                	jmp    801555 <strncmp+0xe>
		n--, p++, q++;
  80154c:	ff 4d 10             	decl   0x10(%ebp)
  80154f:	ff 45 08             	incl   0x8(%ebp)
  801552:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801555:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801559:	74 17                	je     801572 <strncmp+0x2b>
  80155b:	8b 45 08             	mov    0x8(%ebp),%eax
  80155e:	8a 00                	mov    (%eax),%al
  801560:	84 c0                	test   %al,%al
  801562:	74 0e                	je     801572 <strncmp+0x2b>
  801564:	8b 45 08             	mov    0x8(%ebp),%eax
  801567:	8a 10                	mov    (%eax),%dl
  801569:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156c:	8a 00                	mov    (%eax),%al
  80156e:	38 c2                	cmp    %al,%dl
  801570:	74 da                	je     80154c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801572:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801576:	75 07                	jne    80157f <strncmp+0x38>
		return 0;
  801578:	b8 00 00 00 00       	mov    $0x0,%eax
  80157d:	eb 14                	jmp    801593 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80157f:	8b 45 08             	mov    0x8(%ebp),%eax
  801582:	8a 00                	mov    (%eax),%al
  801584:	0f b6 d0             	movzbl %al,%edx
  801587:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158a:	8a 00                	mov    (%eax),%al
  80158c:	0f b6 c0             	movzbl %al,%eax
  80158f:	29 c2                	sub    %eax,%edx
  801591:	89 d0                	mov    %edx,%eax
}
  801593:	5d                   	pop    %ebp
  801594:	c3                   	ret    

00801595 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801595:	55                   	push   %ebp
  801596:	89 e5                	mov    %esp,%ebp
  801598:	83 ec 04             	sub    $0x4,%esp
  80159b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015a1:	eb 12                	jmp    8015b5 <strchr+0x20>
		if (*s == c)
  8015a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a6:	8a 00                	mov    (%eax),%al
  8015a8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015ab:	75 05                	jne    8015b2 <strchr+0x1d>
			return (char *) s;
  8015ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b0:	eb 11                	jmp    8015c3 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015b2:	ff 45 08             	incl   0x8(%ebp)
  8015b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b8:	8a 00                	mov    (%eax),%al
  8015ba:	84 c0                	test   %al,%al
  8015bc:	75 e5                	jne    8015a3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015be:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c3:	c9                   	leave  
  8015c4:	c3                   	ret    

008015c5 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
  8015c8:	83 ec 04             	sub    $0x4,%esp
  8015cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ce:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015d1:	eb 0d                	jmp    8015e0 <strfind+0x1b>
		if (*s == c)
  8015d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d6:	8a 00                	mov    (%eax),%al
  8015d8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015db:	74 0e                	je     8015eb <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015dd:	ff 45 08             	incl   0x8(%ebp)
  8015e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e3:	8a 00                	mov    (%eax),%al
  8015e5:	84 c0                	test   %al,%al
  8015e7:	75 ea                	jne    8015d3 <strfind+0xe>
  8015e9:	eb 01                	jmp    8015ec <strfind+0x27>
		if (*s == c)
			break;
  8015eb:	90                   	nop
	return (char *) s;
  8015ec:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015ef:	c9                   	leave  
  8015f0:	c3                   	ret    

008015f1 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8015f1:	55                   	push   %ebp
  8015f2:	89 e5                	mov    %esp,%ebp
  8015f4:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8015f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8015fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801600:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801603:	eb 0e                	jmp    801613 <memset+0x22>
		*p++ = c;
  801605:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801608:	8d 50 01             	lea    0x1(%eax),%edx
  80160b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80160e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801611:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801613:	ff 4d f8             	decl   -0x8(%ebp)
  801616:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80161a:	79 e9                	jns    801605 <memset+0x14>
		*p++ = c;

	return v;
  80161c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
  801624:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801627:	8b 45 0c             	mov    0xc(%ebp),%eax
  80162a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80162d:	8b 45 08             	mov    0x8(%ebp),%eax
  801630:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801633:	eb 16                	jmp    80164b <memcpy+0x2a>
		*d++ = *s++;
  801635:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801638:	8d 50 01             	lea    0x1(%eax),%edx
  80163b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80163e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801641:	8d 4a 01             	lea    0x1(%edx),%ecx
  801644:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801647:	8a 12                	mov    (%edx),%dl
  801649:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80164b:	8b 45 10             	mov    0x10(%ebp),%eax
  80164e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801651:	89 55 10             	mov    %edx,0x10(%ebp)
  801654:	85 c0                	test   %eax,%eax
  801656:	75 dd                	jne    801635 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801658:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80165b:	c9                   	leave  
  80165c:	c3                   	ret    

0080165d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80165d:	55                   	push   %ebp
  80165e:	89 e5                	mov    %esp,%ebp
  801660:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801663:	8b 45 0c             	mov    0xc(%ebp),%eax
  801666:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801669:	8b 45 08             	mov    0x8(%ebp),%eax
  80166c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80166f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801672:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801675:	73 50                	jae    8016c7 <memmove+0x6a>
  801677:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80167a:	8b 45 10             	mov    0x10(%ebp),%eax
  80167d:	01 d0                	add    %edx,%eax
  80167f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801682:	76 43                	jbe    8016c7 <memmove+0x6a>
		s += n;
  801684:	8b 45 10             	mov    0x10(%ebp),%eax
  801687:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80168a:	8b 45 10             	mov    0x10(%ebp),%eax
  80168d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801690:	eb 10                	jmp    8016a2 <memmove+0x45>
			*--d = *--s;
  801692:	ff 4d f8             	decl   -0x8(%ebp)
  801695:	ff 4d fc             	decl   -0x4(%ebp)
  801698:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80169b:	8a 10                	mov    (%eax),%dl
  80169d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016a0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016a8:	89 55 10             	mov    %edx,0x10(%ebp)
  8016ab:	85 c0                	test   %eax,%eax
  8016ad:	75 e3                	jne    801692 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016af:	eb 23                	jmp    8016d4 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b4:	8d 50 01             	lea    0x1(%eax),%edx
  8016b7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016ba:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016bd:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016c0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016c3:	8a 12                	mov    (%edx),%dl
  8016c5:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ca:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016cd:	89 55 10             	mov    %edx,0x10(%ebp)
  8016d0:	85 c0                	test   %eax,%eax
  8016d2:	75 dd                	jne    8016b1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016d7:	c9                   	leave  
  8016d8:	c3                   	ret    

008016d9 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
  8016dc:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016df:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e8:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016eb:	eb 2a                	jmp    801717 <memcmp+0x3e>
		if (*s1 != *s2)
  8016ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016f0:	8a 10                	mov    (%eax),%dl
  8016f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f5:	8a 00                	mov    (%eax),%al
  8016f7:	38 c2                	cmp    %al,%dl
  8016f9:	74 16                	je     801711 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8016fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016fe:	8a 00                	mov    (%eax),%al
  801700:	0f b6 d0             	movzbl %al,%edx
  801703:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801706:	8a 00                	mov    (%eax),%al
  801708:	0f b6 c0             	movzbl %al,%eax
  80170b:	29 c2                	sub    %eax,%edx
  80170d:	89 d0                	mov    %edx,%eax
  80170f:	eb 18                	jmp    801729 <memcmp+0x50>
		s1++, s2++;
  801711:	ff 45 fc             	incl   -0x4(%ebp)
  801714:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801717:	8b 45 10             	mov    0x10(%ebp),%eax
  80171a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80171d:	89 55 10             	mov    %edx,0x10(%ebp)
  801720:	85 c0                	test   %eax,%eax
  801722:	75 c9                	jne    8016ed <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801724:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801729:	c9                   	leave  
  80172a:	c3                   	ret    

0080172b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80172b:	55                   	push   %ebp
  80172c:	89 e5                	mov    %esp,%ebp
  80172e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801731:	8b 55 08             	mov    0x8(%ebp),%edx
  801734:	8b 45 10             	mov    0x10(%ebp),%eax
  801737:	01 d0                	add    %edx,%eax
  801739:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80173c:	eb 15                	jmp    801753 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80173e:	8b 45 08             	mov    0x8(%ebp),%eax
  801741:	8a 00                	mov    (%eax),%al
  801743:	0f b6 d0             	movzbl %al,%edx
  801746:	8b 45 0c             	mov    0xc(%ebp),%eax
  801749:	0f b6 c0             	movzbl %al,%eax
  80174c:	39 c2                	cmp    %eax,%edx
  80174e:	74 0d                	je     80175d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801750:	ff 45 08             	incl   0x8(%ebp)
  801753:	8b 45 08             	mov    0x8(%ebp),%eax
  801756:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801759:	72 e3                	jb     80173e <memfind+0x13>
  80175b:	eb 01                	jmp    80175e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80175d:	90                   	nop
	return (void *) s;
  80175e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801761:	c9                   	leave  
  801762:	c3                   	ret    

00801763 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801763:	55                   	push   %ebp
  801764:	89 e5                	mov    %esp,%ebp
  801766:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801769:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801770:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801777:	eb 03                	jmp    80177c <strtol+0x19>
		s++;
  801779:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80177c:	8b 45 08             	mov    0x8(%ebp),%eax
  80177f:	8a 00                	mov    (%eax),%al
  801781:	3c 20                	cmp    $0x20,%al
  801783:	74 f4                	je     801779 <strtol+0x16>
  801785:	8b 45 08             	mov    0x8(%ebp),%eax
  801788:	8a 00                	mov    (%eax),%al
  80178a:	3c 09                	cmp    $0x9,%al
  80178c:	74 eb                	je     801779 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80178e:	8b 45 08             	mov    0x8(%ebp),%eax
  801791:	8a 00                	mov    (%eax),%al
  801793:	3c 2b                	cmp    $0x2b,%al
  801795:	75 05                	jne    80179c <strtol+0x39>
		s++;
  801797:	ff 45 08             	incl   0x8(%ebp)
  80179a:	eb 13                	jmp    8017af <strtol+0x4c>
	else if (*s == '-')
  80179c:	8b 45 08             	mov    0x8(%ebp),%eax
  80179f:	8a 00                	mov    (%eax),%al
  8017a1:	3c 2d                	cmp    $0x2d,%al
  8017a3:	75 0a                	jne    8017af <strtol+0x4c>
		s++, neg = 1;
  8017a5:	ff 45 08             	incl   0x8(%ebp)
  8017a8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017af:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017b3:	74 06                	je     8017bb <strtol+0x58>
  8017b5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017b9:	75 20                	jne    8017db <strtol+0x78>
  8017bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017be:	8a 00                	mov    (%eax),%al
  8017c0:	3c 30                	cmp    $0x30,%al
  8017c2:	75 17                	jne    8017db <strtol+0x78>
  8017c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c7:	40                   	inc    %eax
  8017c8:	8a 00                	mov    (%eax),%al
  8017ca:	3c 78                	cmp    $0x78,%al
  8017cc:	75 0d                	jne    8017db <strtol+0x78>
		s += 2, base = 16;
  8017ce:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017d2:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017d9:	eb 28                	jmp    801803 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017db:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017df:	75 15                	jne    8017f6 <strtol+0x93>
  8017e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e4:	8a 00                	mov    (%eax),%al
  8017e6:	3c 30                	cmp    $0x30,%al
  8017e8:	75 0c                	jne    8017f6 <strtol+0x93>
		s++, base = 8;
  8017ea:	ff 45 08             	incl   0x8(%ebp)
  8017ed:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8017f4:	eb 0d                	jmp    801803 <strtol+0xa0>
	else if (base == 0)
  8017f6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017fa:	75 07                	jne    801803 <strtol+0xa0>
		base = 10;
  8017fc:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801803:	8b 45 08             	mov    0x8(%ebp),%eax
  801806:	8a 00                	mov    (%eax),%al
  801808:	3c 2f                	cmp    $0x2f,%al
  80180a:	7e 19                	jle    801825 <strtol+0xc2>
  80180c:	8b 45 08             	mov    0x8(%ebp),%eax
  80180f:	8a 00                	mov    (%eax),%al
  801811:	3c 39                	cmp    $0x39,%al
  801813:	7f 10                	jg     801825 <strtol+0xc2>
			dig = *s - '0';
  801815:	8b 45 08             	mov    0x8(%ebp),%eax
  801818:	8a 00                	mov    (%eax),%al
  80181a:	0f be c0             	movsbl %al,%eax
  80181d:	83 e8 30             	sub    $0x30,%eax
  801820:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801823:	eb 42                	jmp    801867 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801825:	8b 45 08             	mov    0x8(%ebp),%eax
  801828:	8a 00                	mov    (%eax),%al
  80182a:	3c 60                	cmp    $0x60,%al
  80182c:	7e 19                	jle    801847 <strtol+0xe4>
  80182e:	8b 45 08             	mov    0x8(%ebp),%eax
  801831:	8a 00                	mov    (%eax),%al
  801833:	3c 7a                	cmp    $0x7a,%al
  801835:	7f 10                	jg     801847 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801837:	8b 45 08             	mov    0x8(%ebp),%eax
  80183a:	8a 00                	mov    (%eax),%al
  80183c:	0f be c0             	movsbl %al,%eax
  80183f:	83 e8 57             	sub    $0x57,%eax
  801842:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801845:	eb 20                	jmp    801867 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801847:	8b 45 08             	mov    0x8(%ebp),%eax
  80184a:	8a 00                	mov    (%eax),%al
  80184c:	3c 40                	cmp    $0x40,%al
  80184e:	7e 39                	jle    801889 <strtol+0x126>
  801850:	8b 45 08             	mov    0x8(%ebp),%eax
  801853:	8a 00                	mov    (%eax),%al
  801855:	3c 5a                	cmp    $0x5a,%al
  801857:	7f 30                	jg     801889 <strtol+0x126>
			dig = *s - 'A' + 10;
  801859:	8b 45 08             	mov    0x8(%ebp),%eax
  80185c:	8a 00                	mov    (%eax),%al
  80185e:	0f be c0             	movsbl %al,%eax
  801861:	83 e8 37             	sub    $0x37,%eax
  801864:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801867:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80186a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80186d:	7d 19                	jge    801888 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80186f:	ff 45 08             	incl   0x8(%ebp)
  801872:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801875:	0f af 45 10          	imul   0x10(%ebp),%eax
  801879:	89 c2                	mov    %eax,%edx
  80187b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80187e:	01 d0                	add    %edx,%eax
  801880:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801883:	e9 7b ff ff ff       	jmp    801803 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801888:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801889:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80188d:	74 08                	je     801897 <strtol+0x134>
		*endptr = (char *) s;
  80188f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801892:	8b 55 08             	mov    0x8(%ebp),%edx
  801895:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801897:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80189b:	74 07                	je     8018a4 <strtol+0x141>
  80189d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018a0:	f7 d8                	neg    %eax
  8018a2:	eb 03                	jmp    8018a7 <strtol+0x144>
  8018a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018a7:	c9                   	leave  
  8018a8:	c3                   	ret    

008018a9 <ltostr>:

void
ltostr(long value, char *str)
{
  8018a9:	55                   	push   %ebp
  8018aa:	89 e5                	mov    %esp,%ebp
  8018ac:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018b6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018bd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018c1:	79 13                	jns    8018d6 <ltostr+0x2d>
	{
		neg = 1;
  8018c3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018cd:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018d0:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018d3:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d9:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018de:	99                   	cltd   
  8018df:	f7 f9                	idiv   %ecx
  8018e1:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018e7:	8d 50 01             	lea    0x1(%eax),%edx
  8018ea:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018ed:	89 c2                	mov    %eax,%edx
  8018ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f2:	01 d0                	add    %edx,%eax
  8018f4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018f7:	83 c2 30             	add    $0x30,%edx
  8018fa:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8018fc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018ff:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801904:	f7 e9                	imul   %ecx
  801906:	c1 fa 02             	sar    $0x2,%edx
  801909:	89 c8                	mov    %ecx,%eax
  80190b:	c1 f8 1f             	sar    $0x1f,%eax
  80190e:	29 c2                	sub    %eax,%edx
  801910:	89 d0                	mov    %edx,%eax
  801912:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801915:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801918:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80191d:	f7 e9                	imul   %ecx
  80191f:	c1 fa 02             	sar    $0x2,%edx
  801922:	89 c8                	mov    %ecx,%eax
  801924:	c1 f8 1f             	sar    $0x1f,%eax
  801927:	29 c2                	sub    %eax,%edx
  801929:	89 d0                	mov    %edx,%eax
  80192b:	c1 e0 02             	shl    $0x2,%eax
  80192e:	01 d0                	add    %edx,%eax
  801930:	01 c0                	add    %eax,%eax
  801932:	29 c1                	sub    %eax,%ecx
  801934:	89 ca                	mov    %ecx,%edx
  801936:	85 d2                	test   %edx,%edx
  801938:	75 9c                	jne    8018d6 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80193a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801941:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801944:	48                   	dec    %eax
  801945:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801948:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80194c:	74 3d                	je     80198b <ltostr+0xe2>
		start = 1 ;
  80194e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801955:	eb 34                	jmp    80198b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801957:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80195a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80195d:	01 d0                	add    %edx,%eax
  80195f:	8a 00                	mov    (%eax),%al
  801961:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801964:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801967:	8b 45 0c             	mov    0xc(%ebp),%eax
  80196a:	01 c2                	add    %eax,%edx
  80196c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80196f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801972:	01 c8                	add    %ecx,%eax
  801974:	8a 00                	mov    (%eax),%al
  801976:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801978:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80197b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80197e:	01 c2                	add    %eax,%edx
  801980:	8a 45 eb             	mov    -0x15(%ebp),%al
  801983:	88 02                	mov    %al,(%edx)
		start++ ;
  801985:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801988:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80198b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80198e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801991:	7c c4                	jl     801957 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801993:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801996:	8b 45 0c             	mov    0xc(%ebp),%eax
  801999:	01 d0                	add    %edx,%eax
  80199b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80199e:	90                   	nop
  80199f:	c9                   	leave  
  8019a0:	c3                   	ret    

008019a1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019a1:	55                   	push   %ebp
  8019a2:	89 e5                	mov    %esp,%ebp
  8019a4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019a7:	ff 75 08             	pushl  0x8(%ebp)
  8019aa:	e8 54 fa ff ff       	call   801403 <strlen>
  8019af:	83 c4 04             	add    $0x4,%esp
  8019b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019b5:	ff 75 0c             	pushl  0xc(%ebp)
  8019b8:	e8 46 fa ff ff       	call   801403 <strlen>
  8019bd:	83 c4 04             	add    $0x4,%esp
  8019c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019d1:	eb 17                	jmp    8019ea <strcconcat+0x49>
		final[s] = str1[s] ;
  8019d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8019d9:	01 c2                	add    %eax,%edx
  8019db:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019de:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e1:	01 c8                	add    %ecx,%eax
  8019e3:	8a 00                	mov    (%eax),%al
  8019e5:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019e7:	ff 45 fc             	incl   -0x4(%ebp)
  8019ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019ed:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019f0:	7c e1                	jl     8019d3 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019f2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8019f9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a00:	eb 1f                	jmp    801a21 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a02:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a05:	8d 50 01             	lea    0x1(%eax),%edx
  801a08:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a0b:	89 c2                	mov    %eax,%edx
  801a0d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a10:	01 c2                	add    %eax,%edx
  801a12:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a15:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a18:	01 c8                	add    %ecx,%eax
  801a1a:	8a 00                	mov    (%eax),%al
  801a1c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a1e:	ff 45 f8             	incl   -0x8(%ebp)
  801a21:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a24:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a27:	7c d9                	jl     801a02 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a29:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a2c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a2f:	01 d0                	add    %edx,%eax
  801a31:	c6 00 00             	movb   $0x0,(%eax)
}
  801a34:	90                   	nop
  801a35:	c9                   	leave  
  801a36:	c3                   	ret    

00801a37 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a37:	55                   	push   %ebp
  801a38:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a3a:	8b 45 14             	mov    0x14(%ebp),%eax
  801a3d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a43:	8b 45 14             	mov    0x14(%ebp),%eax
  801a46:	8b 00                	mov    (%eax),%eax
  801a48:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a4f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a52:	01 d0                	add    %edx,%eax
  801a54:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a5a:	eb 0c                	jmp    801a68 <strsplit+0x31>
			*string++ = 0;
  801a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5f:	8d 50 01             	lea    0x1(%eax),%edx
  801a62:	89 55 08             	mov    %edx,0x8(%ebp)
  801a65:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a68:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6b:	8a 00                	mov    (%eax),%al
  801a6d:	84 c0                	test   %al,%al
  801a6f:	74 18                	je     801a89 <strsplit+0x52>
  801a71:	8b 45 08             	mov    0x8(%ebp),%eax
  801a74:	8a 00                	mov    (%eax),%al
  801a76:	0f be c0             	movsbl %al,%eax
  801a79:	50                   	push   %eax
  801a7a:	ff 75 0c             	pushl  0xc(%ebp)
  801a7d:	e8 13 fb ff ff       	call   801595 <strchr>
  801a82:	83 c4 08             	add    $0x8,%esp
  801a85:	85 c0                	test   %eax,%eax
  801a87:	75 d3                	jne    801a5c <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801a89:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8c:	8a 00                	mov    (%eax),%al
  801a8e:	84 c0                	test   %al,%al
  801a90:	74 5a                	je     801aec <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801a92:	8b 45 14             	mov    0x14(%ebp),%eax
  801a95:	8b 00                	mov    (%eax),%eax
  801a97:	83 f8 0f             	cmp    $0xf,%eax
  801a9a:	75 07                	jne    801aa3 <strsplit+0x6c>
		{
			return 0;
  801a9c:	b8 00 00 00 00       	mov    $0x0,%eax
  801aa1:	eb 66                	jmp    801b09 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801aa3:	8b 45 14             	mov    0x14(%ebp),%eax
  801aa6:	8b 00                	mov    (%eax),%eax
  801aa8:	8d 48 01             	lea    0x1(%eax),%ecx
  801aab:	8b 55 14             	mov    0x14(%ebp),%edx
  801aae:	89 0a                	mov    %ecx,(%edx)
  801ab0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ab7:	8b 45 10             	mov    0x10(%ebp),%eax
  801aba:	01 c2                	add    %eax,%edx
  801abc:	8b 45 08             	mov    0x8(%ebp),%eax
  801abf:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ac1:	eb 03                	jmp    801ac6 <strsplit+0x8f>
			string++;
  801ac3:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac9:	8a 00                	mov    (%eax),%al
  801acb:	84 c0                	test   %al,%al
  801acd:	74 8b                	je     801a5a <strsplit+0x23>
  801acf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad2:	8a 00                	mov    (%eax),%al
  801ad4:	0f be c0             	movsbl %al,%eax
  801ad7:	50                   	push   %eax
  801ad8:	ff 75 0c             	pushl  0xc(%ebp)
  801adb:	e8 b5 fa ff ff       	call   801595 <strchr>
  801ae0:	83 c4 08             	add    $0x8,%esp
  801ae3:	85 c0                	test   %eax,%eax
  801ae5:	74 dc                	je     801ac3 <strsplit+0x8c>
			string++;
	}
  801ae7:	e9 6e ff ff ff       	jmp    801a5a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801aec:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801aed:	8b 45 14             	mov    0x14(%ebp),%eax
  801af0:	8b 00                	mov    (%eax),%eax
  801af2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801af9:	8b 45 10             	mov    0x10(%ebp),%eax
  801afc:	01 d0                	add    %edx,%eax
  801afe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b04:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b09:	c9                   	leave  
  801b0a:	c3                   	ret    

00801b0b <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b0b:	55                   	push   %ebp
  801b0c:	89 e5                	mov    %esp,%ebp
  801b0e:	83 ec 18             	sub    $0x18,%esp
  801b11:	8b 45 10             	mov    0x10(%ebp),%eax
  801b14:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801b17:	83 ec 04             	sub    $0x4,%esp
  801b1a:	68 44 2d 80 00       	push   $0x802d44
  801b1f:	6a 17                	push   $0x17
  801b21:	68 63 2d 80 00       	push   $0x802d63
  801b26:	e8 9c ed ff ff       	call   8008c7 <_panic>

00801b2b <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b2b:	55                   	push   %ebp
  801b2c:	89 e5                	mov    %esp,%ebp
  801b2e:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801b31:	83 ec 04             	sub    $0x4,%esp
  801b34:	68 6f 2d 80 00       	push   $0x802d6f
  801b39:	6a 2f                	push   $0x2f
  801b3b:	68 63 2d 80 00       	push   $0x802d63
  801b40:	e8 82 ed ff ff       	call   8008c7 <_panic>

00801b45 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801b45:	55                   	push   %ebp
  801b46:	89 e5                	mov    %esp,%ebp
  801b48:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801b4b:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801b52:	8b 55 08             	mov    0x8(%ebp),%edx
  801b55:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b58:	01 d0                	add    %edx,%eax
  801b5a:	48                   	dec    %eax
  801b5b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801b5e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b61:	ba 00 00 00 00       	mov    $0x0,%edx
  801b66:	f7 75 ec             	divl   -0x14(%ebp)
  801b69:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b6c:	29 d0                	sub    %edx,%eax
  801b6e:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801b71:	8b 45 08             	mov    0x8(%ebp),%eax
  801b74:	c1 e8 0c             	shr    $0xc,%eax
  801b77:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801b7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b81:	e9 c8 00 00 00       	jmp    801c4e <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801b86:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801b8d:	eb 27                	jmp    801bb6 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801b8f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b95:	01 c2                	add    %eax,%edx
  801b97:	89 d0                	mov    %edx,%eax
  801b99:	01 c0                	add    %eax,%eax
  801b9b:	01 d0                	add    %edx,%eax
  801b9d:	c1 e0 02             	shl    $0x2,%eax
  801ba0:	05 48 30 80 00       	add    $0x803048,%eax
  801ba5:	8b 00                	mov    (%eax),%eax
  801ba7:	85 c0                	test   %eax,%eax
  801ba9:	74 08                	je     801bb3 <malloc+0x6e>
            	i += j;
  801bab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bae:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801bb1:	eb 0b                	jmp    801bbe <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801bb3:	ff 45 f0             	incl   -0x10(%ebp)
  801bb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bb9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801bbc:	72 d1                	jb     801b8f <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801bbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bc1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801bc4:	0f 85 81 00 00 00    	jne    801c4b <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801bca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bcd:	05 00 00 08 00       	add    $0x80000,%eax
  801bd2:	c1 e0 0c             	shl    $0xc,%eax
  801bd5:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801bd8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801bdf:	eb 1f                	jmp    801c00 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801be1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801be7:	01 c2                	add    %eax,%edx
  801be9:	89 d0                	mov    %edx,%eax
  801beb:	01 c0                	add    %eax,%eax
  801bed:	01 d0                	add    %edx,%eax
  801bef:	c1 e0 02             	shl    $0x2,%eax
  801bf2:	05 48 30 80 00       	add    $0x803048,%eax
  801bf7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801bfd:	ff 45 f0             	incl   -0x10(%ebp)
  801c00:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c03:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801c06:	72 d9                	jb     801be1 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801c08:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c0b:	89 d0                	mov    %edx,%eax
  801c0d:	01 c0                	add    %eax,%eax
  801c0f:	01 d0                	add    %edx,%eax
  801c11:	c1 e0 02             	shl    $0x2,%eax
  801c14:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801c1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c1d:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801c1f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801c22:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801c25:	89 c8                	mov    %ecx,%eax
  801c27:	01 c0                	add    %eax,%eax
  801c29:	01 c8                	add    %ecx,%eax
  801c2b:	c1 e0 02             	shl    $0x2,%eax
  801c2e:	05 44 30 80 00       	add    $0x803044,%eax
  801c33:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801c35:	83 ec 08             	sub    $0x8,%esp
  801c38:	ff 75 08             	pushl  0x8(%ebp)
  801c3b:	ff 75 e0             	pushl  -0x20(%ebp)
  801c3e:	e8 2b 03 00 00       	call   801f6e <sys_allocateMem>
  801c43:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801c46:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c49:	eb 19                	jmp    801c64 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801c4b:	ff 45 f4             	incl   -0xc(%ebp)
  801c4e:	a1 04 30 80 00       	mov    0x803004,%eax
  801c53:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801c56:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801c59:	0f 83 27 ff ff ff    	jae    801b86 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801c5f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c64:	c9                   	leave  
  801c65:	c3                   	ret    

00801c66 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801c66:	55                   	push   %ebp
  801c67:	89 e5                	mov    %esp,%ebp
  801c69:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801c6c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801c70:	0f 84 e5 00 00 00    	je     801d5b <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801c76:	8b 45 08             	mov    0x8(%ebp),%eax
  801c79:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801c7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c7f:	05 00 00 00 80       	add    $0x80000000,%eax
  801c84:	c1 e8 0c             	shr    $0xc,%eax
  801c87:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801c8a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c8d:	89 d0                	mov    %edx,%eax
  801c8f:	01 c0                	add    %eax,%eax
  801c91:	01 d0                	add    %edx,%eax
  801c93:	c1 e0 02             	shl    $0x2,%eax
  801c96:	05 40 30 80 00       	add    $0x803040,%eax
  801c9b:	8b 00                	mov    (%eax),%eax
  801c9d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ca0:	0f 85 b8 00 00 00    	jne    801d5e <free+0xf8>
  801ca6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ca9:	89 d0                	mov    %edx,%eax
  801cab:	01 c0                	add    %eax,%eax
  801cad:	01 d0                	add    %edx,%eax
  801caf:	c1 e0 02             	shl    $0x2,%eax
  801cb2:	05 48 30 80 00       	add    $0x803048,%eax
  801cb7:	8b 00                	mov    (%eax),%eax
  801cb9:	85 c0                	test   %eax,%eax
  801cbb:	0f 84 9d 00 00 00    	je     801d5e <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801cc1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801cc4:	89 d0                	mov    %edx,%eax
  801cc6:	01 c0                	add    %eax,%eax
  801cc8:	01 d0                	add    %edx,%eax
  801cca:	c1 e0 02             	shl    $0x2,%eax
  801ccd:	05 44 30 80 00       	add    $0x803044,%eax
  801cd2:	8b 00                	mov    (%eax),%eax
  801cd4:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801cd7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801cda:	c1 e0 0c             	shl    $0xc,%eax
  801cdd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801ce0:	83 ec 08             	sub    $0x8,%esp
  801ce3:	ff 75 e4             	pushl  -0x1c(%ebp)
  801ce6:	ff 75 f0             	pushl  -0x10(%ebp)
  801ce9:	e8 64 02 00 00       	call   801f52 <sys_freeMem>
  801cee:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801cf1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801cf8:	eb 57                	jmp    801d51 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801cfa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801cfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d00:	01 c2                	add    %eax,%edx
  801d02:	89 d0                	mov    %edx,%eax
  801d04:	01 c0                	add    %eax,%eax
  801d06:	01 d0                	add    %edx,%eax
  801d08:	c1 e0 02             	shl    $0x2,%eax
  801d0b:	05 48 30 80 00       	add    $0x803048,%eax
  801d10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801d16:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d1c:	01 c2                	add    %eax,%edx
  801d1e:	89 d0                	mov    %edx,%eax
  801d20:	01 c0                	add    %eax,%eax
  801d22:	01 d0                	add    %edx,%eax
  801d24:	c1 e0 02             	shl    $0x2,%eax
  801d27:	05 40 30 80 00       	add    $0x803040,%eax
  801d2c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801d32:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d35:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d38:	01 c2                	add    %eax,%edx
  801d3a:	89 d0                	mov    %edx,%eax
  801d3c:	01 c0                	add    %eax,%eax
  801d3e:	01 d0                	add    %edx,%eax
  801d40:	c1 e0 02             	shl    $0x2,%eax
  801d43:	05 44 30 80 00       	add    $0x803044,%eax
  801d48:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801d4e:	ff 45 f4             	incl   -0xc(%ebp)
  801d51:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d54:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801d57:	7c a1                	jl     801cfa <free+0x94>
  801d59:	eb 04                	jmp    801d5f <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801d5b:	90                   	nop
  801d5c:	eb 01                	jmp    801d5f <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801d5e:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801d5f:	c9                   	leave  
  801d60:	c3                   	ret    

00801d61 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801d61:	55                   	push   %ebp
  801d62:	89 e5                	mov    %esp,%ebp
  801d64:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801d67:	83 ec 04             	sub    $0x4,%esp
  801d6a:	68 8c 2d 80 00       	push   $0x802d8c
  801d6f:	68 ae 00 00 00       	push   $0xae
  801d74:	68 63 2d 80 00       	push   $0x802d63
  801d79:	e8 49 eb ff ff       	call   8008c7 <_panic>

00801d7e <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801d7e:	55                   	push   %ebp
  801d7f:	89 e5                	mov    %esp,%ebp
  801d81:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801d84:	83 ec 04             	sub    $0x4,%esp
  801d87:	68 ac 2d 80 00       	push   $0x802dac
  801d8c:	68 ca 00 00 00       	push   $0xca
  801d91:	68 63 2d 80 00       	push   $0x802d63
  801d96:	e8 2c eb ff ff       	call   8008c7 <_panic>

00801d9b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d9b:	55                   	push   %ebp
  801d9c:	89 e5                	mov    %esp,%ebp
  801d9e:	57                   	push   %edi
  801d9f:	56                   	push   %esi
  801da0:	53                   	push   %ebx
  801da1:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801da4:	8b 45 08             	mov    0x8(%ebp),%eax
  801da7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801daa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dad:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801db0:	8b 7d 18             	mov    0x18(%ebp),%edi
  801db3:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801db6:	cd 30                	int    $0x30
  801db8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801dbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801dbe:	83 c4 10             	add    $0x10,%esp
  801dc1:	5b                   	pop    %ebx
  801dc2:	5e                   	pop    %esi
  801dc3:	5f                   	pop    %edi
  801dc4:	5d                   	pop    %ebp
  801dc5:	c3                   	ret    

00801dc6 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801dc6:	55                   	push   %ebp
  801dc7:	89 e5                	mov    %esp,%ebp
  801dc9:	83 ec 04             	sub    $0x4,%esp
  801dcc:	8b 45 10             	mov    0x10(%ebp),%eax
  801dcf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801dd2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	52                   	push   %edx
  801dde:	ff 75 0c             	pushl  0xc(%ebp)
  801de1:	50                   	push   %eax
  801de2:	6a 00                	push   $0x0
  801de4:	e8 b2 ff ff ff       	call   801d9b <syscall>
  801de9:	83 c4 18             	add    $0x18,%esp
}
  801dec:	90                   	nop
  801ded:	c9                   	leave  
  801dee:	c3                   	ret    

00801def <sys_cgetc>:

int
sys_cgetc(void)
{
  801def:	55                   	push   %ebp
  801df0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	6a 00                	push   $0x0
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 01                	push   $0x1
  801dfe:	e8 98 ff ff ff       	call   801d9b <syscall>
  801e03:	83 c4 18             	add    $0x18,%esp
}
  801e06:	c9                   	leave  
  801e07:	c3                   	ret    

00801e08 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801e08:	55                   	push   %ebp
  801e09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	50                   	push   %eax
  801e17:	6a 05                	push   $0x5
  801e19:	e8 7d ff ff ff       	call   801d9b <syscall>
  801e1e:	83 c4 18             	add    $0x18,%esp
}
  801e21:	c9                   	leave  
  801e22:	c3                   	ret    

00801e23 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801e23:	55                   	push   %ebp
  801e24:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801e26:	6a 00                	push   $0x0
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 00                	push   $0x0
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 02                	push   $0x2
  801e32:	e8 64 ff ff ff       	call   801d9b <syscall>
  801e37:	83 c4 18             	add    $0x18,%esp
}
  801e3a:	c9                   	leave  
  801e3b:	c3                   	ret    

00801e3c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e3c:	55                   	push   %ebp
  801e3d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 00                	push   $0x0
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	6a 03                	push   $0x3
  801e4b:	e8 4b ff ff ff       	call   801d9b <syscall>
  801e50:	83 c4 18             	add    $0x18,%esp
}
  801e53:	c9                   	leave  
  801e54:	c3                   	ret    

00801e55 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e55:	55                   	push   %ebp
  801e56:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 00                	push   $0x0
  801e5c:	6a 00                	push   $0x0
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	6a 04                	push   $0x4
  801e64:	e8 32 ff ff ff       	call   801d9b <syscall>
  801e69:	83 c4 18             	add    $0x18,%esp
}
  801e6c:	c9                   	leave  
  801e6d:	c3                   	ret    

00801e6e <sys_env_exit>:


void sys_env_exit(void)
{
  801e6e:	55                   	push   %ebp
  801e6f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e71:	6a 00                	push   $0x0
  801e73:	6a 00                	push   $0x0
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 06                	push   $0x6
  801e7d:	e8 19 ff ff ff       	call   801d9b <syscall>
  801e82:	83 c4 18             	add    $0x18,%esp
}
  801e85:	90                   	nop
  801e86:	c9                   	leave  
  801e87:	c3                   	ret    

00801e88 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e88:	55                   	push   %ebp
  801e89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e91:	6a 00                	push   $0x0
  801e93:	6a 00                	push   $0x0
  801e95:	6a 00                	push   $0x0
  801e97:	52                   	push   %edx
  801e98:	50                   	push   %eax
  801e99:	6a 07                	push   $0x7
  801e9b:	e8 fb fe ff ff       	call   801d9b <syscall>
  801ea0:	83 c4 18             	add    $0x18,%esp
}
  801ea3:	c9                   	leave  
  801ea4:	c3                   	ret    

00801ea5 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ea5:	55                   	push   %ebp
  801ea6:	89 e5                	mov    %esp,%ebp
  801ea8:	56                   	push   %esi
  801ea9:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801eaa:	8b 75 18             	mov    0x18(%ebp),%esi
  801ead:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801eb0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801eb3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb9:	56                   	push   %esi
  801eba:	53                   	push   %ebx
  801ebb:	51                   	push   %ecx
  801ebc:	52                   	push   %edx
  801ebd:	50                   	push   %eax
  801ebe:	6a 08                	push   $0x8
  801ec0:	e8 d6 fe ff ff       	call   801d9b <syscall>
  801ec5:	83 c4 18             	add    $0x18,%esp
}
  801ec8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ecb:	5b                   	pop    %ebx
  801ecc:	5e                   	pop    %esi
  801ecd:	5d                   	pop    %ebp
  801ece:	c3                   	ret    

00801ecf <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ecf:	55                   	push   %ebp
  801ed0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801ed2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed8:	6a 00                	push   $0x0
  801eda:	6a 00                	push   $0x0
  801edc:	6a 00                	push   $0x0
  801ede:	52                   	push   %edx
  801edf:	50                   	push   %eax
  801ee0:	6a 09                	push   $0x9
  801ee2:	e8 b4 fe ff ff       	call   801d9b <syscall>
  801ee7:	83 c4 18             	add    $0x18,%esp
}
  801eea:	c9                   	leave  
  801eeb:	c3                   	ret    

00801eec <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801eec:	55                   	push   %ebp
  801eed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 00                	push   $0x0
  801ef3:	6a 00                	push   $0x0
  801ef5:	ff 75 0c             	pushl  0xc(%ebp)
  801ef8:	ff 75 08             	pushl  0x8(%ebp)
  801efb:	6a 0a                	push   $0xa
  801efd:	e8 99 fe ff ff       	call   801d9b <syscall>
  801f02:	83 c4 18             	add    $0x18,%esp
}
  801f05:	c9                   	leave  
  801f06:	c3                   	ret    

00801f07 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801f07:	55                   	push   %ebp
  801f08:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801f0a:	6a 00                	push   $0x0
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 00                	push   $0x0
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	6a 0b                	push   $0xb
  801f16:	e8 80 fe ff ff       	call   801d9b <syscall>
  801f1b:	83 c4 18             	add    $0x18,%esp
}
  801f1e:	c9                   	leave  
  801f1f:	c3                   	ret    

00801f20 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801f20:	55                   	push   %ebp
  801f21:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801f23:	6a 00                	push   $0x0
  801f25:	6a 00                	push   $0x0
  801f27:	6a 00                	push   $0x0
  801f29:	6a 00                	push   $0x0
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 0c                	push   $0xc
  801f2f:	e8 67 fe ff ff       	call   801d9b <syscall>
  801f34:	83 c4 18             	add    $0x18,%esp
}
  801f37:	c9                   	leave  
  801f38:	c3                   	ret    

00801f39 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f39:	55                   	push   %ebp
  801f3a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 00                	push   $0x0
  801f40:	6a 00                	push   $0x0
  801f42:	6a 00                	push   $0x0
  801f44:	6a 00                	push   $0x0
  801f46:	6a 0d                	push   $0xd
  801f48:	e8 4e fe ff ff       	call   801d9b <syscall>
  801f4d:	83 c4 18             	add    $0x18,%esp
}
  801f50:	c9                   	leave  
  801f51:	c3                   	ret    

00801f52 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f52:	55                   	push   %ebp
  801f53:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	ff 75 0c             	pushl  0xc(%ebp)
  801f5e:	ff 75 08             	pushl  0x8(%ebp)
  801f61:	6a 11                	push   $0x11
  801f63:	e8 33 fe ff ff       	call   801d9b <syscall>
  801f68:	83 c4 18             	add    $0x18,%esp
	return;
  801f6b:	90                   	nop
}
  801f6c:	c9                   	leave  
  801f6d:	c3                   	ret    

00801f6e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f6e:	55                   	push   %ebp
  801f6f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f71:	6a 00                	push   $0x0
  801f73:	6a 00                	push   $0x0
  801f75:	6a 00                	push   $0x0
  801f77:	ff 75 0c             	pushl  0xc(%ebp)
  801f7a:	ff 75 08             	pushl  0x8(%ebp)
  801f7d:	6a 12                	push   $0x12
  801f7f:	e8 17 fe ff ff       	call   801d9b <syscall>
  801f84:	83 c4 18             	add    $0x18,%esp
	return ;
  801f87:	90                   	nop
}
  801f88:	c9                   	leave  
  801f89:	c3                   	ret    

00801f8a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f8a:	55                   	push   %ebp
  801f8b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 00                	push   $0x0
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	6a 0e                	push   $0xe
  801f99:	e8 fd fd ff ff       	call   801d9b <syscall>
  801f9e:	83 c4 18             	add    $0x18,%esp
}
  801fa1:	c9                   	leave  
  801fa2:	c3                   	ret    

00801fa3 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801fa3:	55                   	push   %ebp
  801fa4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	6a 00                	push   $0x0
  801fae:	ff 75 08             	pushl  0x8(%ebp)
  801fb1:	6a 0f                	push   $0xf
  801fb3:	e8 e3 fd ff ff       	call   801d9b <syscall>
  801fb8:	83 c4 18             	add    $0x18,%esp
}
  801fbb:	c9                   	leave  
  801fbc:	c3                   	ret    

00801fbd <sys_scarce_memory>:

void sys_scarce_memory()
{
  801fbd:	55                   	push   %ebp
  801fbe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801fc0:	6a 00                	push   $0x0
  801fc2:	6a 00                	push   $0x0
  801fc4:	6a 00                	push   $0x0
  801fc6:	6a 00                	push   $0x0
  801fc8:	6a 00                	push   $0x0
  801fca:	6a 10                	push   $0x10
  801fcc:	e8 ca fd ff ff       	call   801d9b <syscall>
  801fd1:	83 c4 18             	add    $0x18,%esp
}
  801fd4:	90                   	nop
  801fd5:	c9                   	leave  
  801fd6:	c3                   	ret    

00801fd7 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801fd7:	55                   	push   %ebp
  801fd8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 00                	push   $0x0
  801fe0:	6a 00                	push   $0x0
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 14                	push   $0x14
  801fe6:	e8 b0 fd ff ff       	call   801d9b <syscall>
  801feb:	83 c4 18             	add    $0x18,%esp
}
  801fee:	90                   	nop
  801fef:	c9                   	leave  
  801ff0:	c3                   	ret    

00801ff1 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ff1:	55                   	push   %ebp
  801ff2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ff4:	6a 00                	push   $0x0
  801ff6:	6a 00                	push   $0x0
  801ff8:	6a 00                	push   $0x0
  801ffa:	6a 00                	push   $0x0
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 15                	push   $0x15
  802000:	e8 96 fd ff ff       	call   801d9b <syscall>
  802005:	83 c4 18             	add    $0x18,%esp
}
  802008:	90                   	nop
  802009:	c9                   	leave  
  80200a:	c3                   	ret    

0080200b <sys_cputc>:


void
sys_cputc(const char c)
{
  80200b:	55                   	push   %ebp
  80200c:	89 e5                	mov    %esp,%ebp
  80200e:	83 ec 04             	sub    $0x4,%esp
  802011:	8b 45 08             	mov    0x8(%ebp),%eax
  802014:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802017:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	6a 00                	push   $0x0
  802023:	50                   	push   %eax
  802024:	6a 16                	push   $0x16
  802026:	e8 70 fd ff ff       	call   801d9b <syscall>
  80202b:	83 c4 18             	add    $0x18,%esp
}
  80202e:	90                   	nop
  80202f:	c9                   	leave  
  802030:	c3                   	ret    

00802031 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802031:	55                   	push   %ebp
  802032:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802034:	6a 00                	push   $0x0
  802036:	6a 00                	push   $0x0
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	6a 17                	push   $0x17
  802040:	e8 56 fd ff ff       	call   801d9b <syscall>
  802045:	83 c4 18             	add    $0x18,%esp
}
  802048:	90                   	nop
  802049:	c9                   	leave  
  80204a:	c3                   	ret    

0080204b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80204b:	55                   	push   %ebp
  80204c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80204e:	8b 45 08             	mov    0x8(%ebp),%eax
  802051:	6a 00                	push   $0x0
  802053:	6a 00                	push   $0x0
  802055:	6a 00                	push   $0x0
  802057:	ff 75 0c             	pushl  0xc(%ebp)
  80205a:	50                   	push   %eax
  80205b:	6a 18                	push   $0x18
  80205d:	e8 39 fd ff ff       	call   801d9b <syscall>
  802062:	83 c4 18             	add    $0x18,%esp
}
  802065:	c9                   	leave  
  802066:	c3                   	ret    

00802067 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802067:	55                   	push   %ebp
  802068:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80206a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80206d:	8b 45 08             	mov    0x8(%ebp),%eax
  802070:	6a 00                	push   $0x0
  802072:	6a 00                	push   $0x0
  802074:	6a 00                	push   $0x0
  802076:	52                   	push   %edx
  802077:	50                   	push   %eax
  802078:	6a 1b                	push   $0x1b
  80207a:	e8 1c fd ff ff       	call   801d9b <syscall>
  80207f:	83 c4 18             	add    $0x18,%esp
}
  802082:	c9                   	leave  
  802083:	c3                   	ret    

00802084 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802084:	55                   	push   %ebp
  802085:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802087:	8b 55 0c             	mov    0xc(%ebp),%edx
  80208a:	8b 45 08             	mov    0x8(%ebp),%eax
  80208d:	6a 00                	push   $0x0
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	52                   	push   %edx
  802094:	50                   	push   %eax
  802095:	6a 19                	push   $0x19
  802097:	e8 ff fc ff ff       	call   801d9b <syscall>
  80209c:	83 c4 18             	add    $0x18,%esp
}
  80209f:	90                   	nop
  8020a0:	c9                   	leave  
  8020a1:	c3                   	ret    

008020a2 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020a2:	55                   	push   %ebp
  8020a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	52                   	push   %edx
  8020b2:	50                   	push   %eax
  8020b3:	6a 1a                	push   $0x1a
  8020b5:	e8 e1 fc ff ff       	call   801d9b <syscall>
  8020ba:	83 c4 18             	add    $0x18,%esp
}
  8020bd:	90                   	nop
  8020be:	c9                   	leave  
  8020bf:	c3                   	ret    

008020c0 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8020c0:	55                   	push   %ebp
  8020c1:	89 e5                	mov    %esp,%ebp
  8020c3:	83 ec 04             	sub    $0x4,%esp
  8020c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8020c9:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8020cc:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8020cf:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8020d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8020d6:	6a 00                	push   $0x0
  8020d8:	51                   	push   %ecx
  8020d9:	52                   	push   %edx
  8020da:	ff 75 0c             	pushl  0xc(%ebp)
  8020dd:	50                   	push   %eax
  8020de:	6a 1c                	push   $0x1c
  8020e0:	e8 b6 fc ff ff       	call   801d9b <syscall>
  8020e5:	83 c4 18             	add    $0x18,%esp
}
  8020e8:	c9                   	leave  
  8020e9:	c3                   	ret    

008020ea <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8020ea:	55                   	push   %ebp
  8020eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8020ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f3:	6a 00                	push   $0x0
  8020f5:	6a 00                	push   $0x0
  8020f7:	6a 00                	push   $0x0
  8020f9:	52                   	push   %edx
  8020fa:	50                   	push   %eax
  8020fb:	6a 1d                	push   $0x1d
  8020fd:	e8 99 fc ff ff       	call   801d9b <syscall>
  802102:	83 c4 18             	add    $0x18,%esp
}
  802105:	c9                   	leave  
  802106:	c3                   	ret    

00802107 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802107:	55                   	push   %ebp
  802108:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80210a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80210d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802110:	8b 45 08             	mov    0x8(%ebp),%eax
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	51                   	push   %ecx
  802118:	52                   	push   %edx
  802119:	50                   	push   %eax
  80211a:	6a 1e                	push   $0x1e
  80211c:	e8 7a fc ff ff       	call   801d9b <syscall>
  802121:	83 c4 18             	add    $0x18,%esp
}
  802124:	c9                   	leave  
  802125:	c3                   	ret    

00802126 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802126:	55                   	push   %ebp
  802127:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802129:	8b 55 0c             	mov    0xc(%ebp),%edx
  80212c:	8b 45 08             	mov    0x8(%ebp),%eax
  80212f:	6a 00                	push   $0x0
  802131:	6a 00                	push   $0x0
  802133:	6a 00                	push   $0x0
  802135:	52                   	push   %edx
  802136:	50                   	push   %eax
  802137:	6a 1f                	push   $0x1f
  802139:	e8 5d fc ff ff       	call   801d9b <syscall>
  80213e:	83 c4 18             	add    $0x18,%esp
}
  802141:	c9                   	leave  
  802142:	c3                   	ret    

00802143 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802143:	55                   	push   %ebp
  802144:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	6a 00                	push   $0x0
  80214c:	6a 00                	push   $0x0
  80214e:	6a 00                	push   $0x0
  802150:	6a 20                	push   $0x20
  802152:	e8 44 fc ff ff       	call   801d9b <syscall>
  802157:	83 c4 18             	add    $0x18,%esp
}
  80215a:	c9                   	leave  
  80215b:	c3                   	ret    

0080215c <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80215c:	55                   	push   %ebp
  80215d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80215f:	8b 45 08             	mov    0x8(%ebp),%eax
  802162:	6a 00                	push   $0x0
  802164:	6a 00                	push   $0x0
  802166:	ff 75 10             	pushl  0x10(%ebp)
  802169:	ff 75 0c             	pushl  0xc(%ebp)
  80216c:	50                   	push   %eax
  80216d:	6a 21                	push   $0x21
  80216f:	e8 27 fc ff ff       	call   801d9b <syscall>
  802174:	83 c4 18             	add    $0x18,%esp
}
  802177:	c9                   	leave  
  802178:	c3                   	ret    

00802179 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802179:	55                   	push   %ebp
  80217a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80217c:	8b 45 08             	mov    0x8(%ebp),%eax
  80217f:	6a 00                	push   $0x0
  802181:	6a 00                	push   $0x0
  802183:	6a 00                	push   $0x0
  802185:	6a 00                	push   $0x0
  802187:	50                   	push   %eax
  802188:	6a 22                	push   $0x22
  80218a:	e8 0c fc ff ff       	call   801d9b <syscall>
  80218f:	83 c4 18             	add    $0x18,%esp
}
  802192:	90                   	nop
  802193:	c9                   	leave  
  802194:	c3                   	ret    

00802195 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802195:	55                   	push   %ebp
  802196:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802198:	8b 45 08             	mov    0x8(%ebp),%eax
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	6a 00                	push   $0x0
  8021a3:	50                   	push   %eax
  8021a4:	6a 23                	push   $0x23
  8021a6:	e8 f0 fb ff ff       	call   801d9b <syscall>
  8021ab:	83 c4 18             	add    $0x18,%esp
}
  8021ae:	90                   	nop
  8021af:	c9                   	leave  
  8021b0:	c3                   	ret    

008021b1 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8021b1:	55                   	push   %ebp
  8021b2:	89 e5                	mov    %esp,%ebp
  8021b4:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8021b7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021ba:	8d 50 04             	lea    0x4(%eax),%edx
  8021bd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021c0:	6a 00                	push   $0x0
  8021c2:	6a 00                	push   $0x0
  8021c4:	6a 00                	push   $0x0
  8021c6:	52                   	push   %edx
  8021c7:	50                   	push   %eax
  8021c8:	6a 24                	push   $0x24
  8021ca:	e8 cc fb ff ff       	call   801d9b <syscall>
  8021cf:	83 c4 18             	add    $0x18,%esp
	return result;
  8021d2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8021d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021d8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021db:	89 01                	mov    %eax,(%ecx)
  8021dd:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8021e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e3:	c9                   	leave  
  8021e4:	c2 04 00             	ret    $0x4

008021e7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8021e7:	55                   	push   %ebp
  8021e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8021ea:	6a 00                	push   $0x0
  8021ec:	6a 00                	push   $0x0
  8021ee:	ff 75 10             	pushl  0x10(%ebp)
  8021f1:	ff 75 0c             	pushl  0xc(%ebp)
  8021f4:	ff 75 08             	pushl  0x8(%ebp)
  8021f7:	6a 13                	push   $0x13
  8021f9:	e8 9d fb ff ff       	call   801d9b <syscall>
  8021fe:	83 c4 18             	add    $0x18,%esp
	return ;
  802201:	90                   	nop
}
  802202:	c9                   	leave  
  802203:	c3                   	ret    

00802204 <sys_rcr2>:
uint32 sys_rcr2()
{
  802204:	55                   	push   %ebp
  802205:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802207:	6a 00                	push   $0x0
  802209:	6a 00                	push   $0x0
  80220b:	6a 00                	push   $0x0
  80220d:	6a 00                	push   $0x0
  80220f:	6a 00                	push   $0x0
  802211:	6a 25                	push   $0x25
  802213:	e8 83 fb ff ff       	call   801d9b <syscall>
  802218:	83 c4 18             	add    $0x18,%esp
}
  80221b:	c9                   	leave  
  80221c:	c3                   	ret    

0080221d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80221d:	55                   	push   %ebp
  80221e:	89 e5                	mov    %esp,%ebp
  802220:	83 ec 04             	sub    $0x4,%esp
  802223:	8b 45 08             	mov    0x8(%ebp),%eax
  802226:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802229:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80222d:	6a 00                	push   $0x0
  80222f:	6a 00                	push   $0x0
  802231:	6a 00                	push   $0x0
  802233:	6a 00                	push   $0x0
  802235:	50                   	push   %eax
  802236:	6a 26                	push   $0x26
  802238:	e8 5e fb ff ff       	call   801d9b <syscall>
  80223d:	83 c4 18             	add    $0x18,%esp
	return ;
  802240:	90                   	nop
}
  802241:	c9                   	leave  
  802242:	c3                   	ret    

00802243 <rsttst>:
void rsttst()
{
  802243:	55                   	push   %ebp
  802244:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	6a 00                	push   $0x0
  80224c:	6a 00                	push   $0x0
  80224e:	6a 00                	push   $0x0
  802250:	6a 28                	push   $0x28
  802252:	e8 44 fb ff ff       	call   801d9b <syscall>
  802257:	83 c4 18             	add    $0x18,%esp
	return ;
  80225a:	90                   	nop
}
  80225b:	c9                   	leave  
  80225c:	c3                   	ret    

0080225d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80225d:	55                   	push   %ebp
  80225e:	89 e5                	mov    %esp,%ebp
  802260:	83 ec 04             	sub    $0x4,%esp
  802263:	8b 45 14             	mov    0x14(%ebp),%eax
  802266:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802269:	8b 55 18             	mov    0x18(%ebp),%edx
  80226c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802270:	52                   	push   %edx
  802271:	50                   	push   %eax
  802272:	ff 75 10             	pushl  0x10(%ebp)
  802275:	ff 75 0c             	pushl  0xc(%ebp)
  802278:	ff 75 08             	pushl  0x8(%ebp)
  80227b:	6a 27                	push   $0x27
  80227d:	e8 19 fb ff ff       	call   801d9b <syscall>
  802282:	83 c4 18             	add    $0x18,%esp
	return ;
  802285:	90                   	nop
}
  802286:	c9                   	leave  
  802287:	c3                   	ret    

00802288 <chktst>:
void chktst(uint32 n)
{
  802288:	55                   	push   %ebp
  802289:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80228b:	6a 00                	push   $0x0
  80228d:	6a 00                	push   $0x0
  80228f:	6a 00                	push   $0x0
  802291:	6a 00                	push   $0x0
  802293:	ff 75 08             	pushl  0x8(%ebp)
  802296:	6a 29                	push   $0x29
  802298:	e8 fe fa ff ff       	call   801d9b <syscall>
  80229d:	83 c4 18             	add    $0x18,%esp
	return ;
  8022a0:	90                   	nop
}
  8022a1:	c9                   	leave  
  8022a2:	c3                   	ret    

008022a3 <inctst>:

void inctst()
{
  8022a3:	55                   	push   %ebp
  8022a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8022a6:	6a 00                	push   $0x0
  8022a8:	6a 00                	push   $0x0
  8022aa:	6a 00                	push   $0x0
  8022ac:	6a 00                	push   $0x0
  8022ae:	6a 00                	push   $0x0
  8022b0:	6a 2a                	push   $0x2a
  8022b2:	e8 e4 fa ff ff       	call   801d9b <syscall>
  8022b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8022ba:	90                   	nop
}
  8022bb:	c9                   	leave  
  8022bc:	c3                   	ret    

008022bd <gettst>:
uint32 gettst()
{
  8022bd:	55                   	push   %ebp
  8022be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8022c0:	6a 00                	push   $0x0
  8022c2:	6a 00                	push   $0x0
  8022c4:	6a 00                	push   $0x0
  8022c6:	6a 00                	push   $0x0
  8022c8:	6a 00                	push   $0x0
  8022ca:	6a 2b                	push   $0x2b
  8022cc:	e8 ca fa ff ff       	call   801d9b <syscall>
  8022d1:	83 c4 18             	add    $0x18,%esp
}
  8022d4:	c9                   	leave  
  8022d5:	c3                   	ret    

008022d6 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8022d6:	55                   	push   %ebp
  8022d7:	89 e5                	mov    %esp,%ebp
  8022d9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022dc:	6a 00                	push   $0x0
  8022de:	6a 00                	push   $0x0
  8022e0:	6a 00                	push   $0x0
  8022e2:	6a 00                	push   $0x0
  8022e4:	6a 00                	push   $0x0
  8022e6:	6a 2c                	push   $0x2c
  8022e8:	e8 ae fa ff ff       	call   801d9b <syscall>
  8022ed:	83 c4 18             	add    $0x18,%esp
  8022f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8022f3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8022f7:	75 07                	jne    802300 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8022f9:	b8 01 00 00 00       	mov    $0x1,%eax
  8022fe:	eb 05                	jmp    802305 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802300:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802305:	c9                   	leave  
  802306:	c3                   	ret    

00802307 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802307:	55                   	push   %ebp
  802308:	89 e5                	mov    %esp,%ebp
  80230a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80230d:	6a 00                	push   $0x0
  80230f:	6a 00                	push   $0x0
  802311:	6a 00                	push   $0x0
  802313:	6a 00                	push   $0x0
  802315:	6a 00                	push   $0x0
  802317:	6a 2c                	push   $0x2c
  802319:	e8 7d fa ff ff       	call   801d9b <syscall>
  80231e:	83 c4 18             	add    $0x18,%esp
  802321:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802324:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802328:	75 07                	jne    802331 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80232a:	b8 01 00 00 00       	mov    $0x1,%eax
  80232f:	eb 05                	jmp    802336 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802331:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802336:	c9                   	leave  
  802337:	c3                   	ret    

00802338 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802338:	55                   	push   %ebp
  802339:	89 e5                	mov    %esp,%ebp
  80233b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80233e:	6a 00                	push   $0x0
  802340:	6a 00                	push   $0x0
  802342:	6a 00                	push   $0x0
  802344:	6a 00                	push   $0x0
  802346:	6a 00                	push   $0x0
  802348:	6a 2c                	push   $0x2c
  80234a:	e8 4c fa ff ff       	call   801d9b <syscall>
  80234f:	83 c4 18             	add    $0x18,%esp
  802352:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802355:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802359:	75 07                	jne    802362 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80235b:	b8 01 00 00 00       	mov    $0x1,%eax
  802360:	eb 05                	jmp    802367 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802362:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802367:	c9                   	leave  
  802368:	c3                   	ret    

00802369 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802369:	55                   	push   %ebp
  80236a:	89 e5                	mov    %esp,%ebp
  80236c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80236f:	6a 00                	push   $0x0
  802371:	6a 00                	push   $0x0
  802373:	6a 00                	push   $0x0
  802375:	6a 00                	push   $0x0
  802377:	6a 00                	push   $0x0
  802379:	6a 2c                	push   $0x2c
  80237b:	e8 1b fa ff ff       	call   801d9b <syscall>
  802380:	83 c4 18             	add    $0x18,%esp
  802383:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802386:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80238a:	75 07                	jne    802393 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80238c:	b8 01 00 00 00       	mov    $0x1,%eax
  802391:	eb 05                	jmp    802398 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802393:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802398:	c9                   	leave  
  802399:	c3                   	ret    

0080239a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80239a:	55                   	push   %ebp
  80239b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80239d:	6a 00                	push   $0x0
  80239f:	6a 00                	push   $0x0
  8023a1:	6a 00                	push   $0x0
  8023a3:	6a 00                	push   $0x0
  8023a5:	ff 75 08             	pushl  0x8(%ebp)
  8023a8:	6a 2d                	push   $0x2d
  8023aa:	e8 ec f9 ff ff       	call   801d9b <syscall>
  8023af:	83 c4 18             	add    $0x18,%esp
	return ;
  8023b2:	90                   	nop
}
  8023b3:	c9                   	leave  
  8023b4:	c3                   	ret    
  8023b5:	66 90                	xchg   %ax,%ax
  8023b7:	90                   	nop

008023b8 <__udivdi3>:
  8023b8:	55                   	push   %ebp
  8023b9:	57                   	push   %edi
  8023ba:	56                   	push   %esi
  8023bb:	53                   	push   %ebx
  8023bc:	83 ec 1c             	sub    $0x1c,%esp
  8023bf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8023c3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8023c7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023cb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8023cf:	89 ca                	mov    %ecx,%edx
  8023d1:	89 f8                	mov    %edi,%eax
  8023d3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8023d7:	85 f6                	test   %esi,%esi
  8023d9:	75 2d                	jne    802408 <__udivdi3+0x50>
  8023db:	39 cf                	cmp    %ecx,%edi
  8023dd:	77 65                	ja     802444 <__udivdi3+0x8c>
  8023df:	89 fd                	mov    %edi,%ebp
  8023e1:	85 ff                	test   %edi,%edi
  8023e3:	75 0b                	jne    8023f0 <__udivdi3+0x38>
  8023e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8023ea:	31 d2                	xor    %edx,%edx
  8023ec:	f7 f7                	div    %edi
  8023ee:	89 c5                	mov    %eax,%ebp
  8023f0:	31 d2                	xor    %edx,%edx
  8023f2:	89 c8                	mov    %ecx,%eax
  8023f4:	f7 f5                	div    %ebp
  8023f6:	89 c1                	mov    %eax,%ecx
  8023f8:	89 d8                	mov    %ebx,%eax
  8023fa:	f7 f5                	div    %ebp
  8023fc:	89 cf                	mov    %ecx,%edi
  8023fe:	89 fa                	mov    %edi,%edx
  802400:	83 c4 1c             	add    $0x1c,%esp
  802403:	5b                   	pop    %ebx
  802404:	5e                   	pop    %esi
  802405:	5f                   	pop    %edi
  802406:	5d                   	pop    %ebp
  802407:	c3                   	ret    
  802408:	39 ce                	cmp    %ecx,%esi
  80240a:	77 28                	ja     802434 <__udivdi3+0x7c>
  80240c:	0f bd fe             	bsr    %esi,%edi
  80240f:	83 f7 1f             	xor    $0x1f,%edi
  802412:	75 40                	jne    802454 <__udivdi3+0x9c>
  802414:	39 ce                	cmp    %ecx,%esi
  802416:	72 0a                	jb     802422 <__udivdi3+0x6a>
  802418:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80241c:	0f 87 9e 00 00 00    	ja     8024c0 <__udivdi3+0x108>
  802422:	b8 01 00 00 00       	mov    $0x1,%eax
  802427:	89 fa                	mov    %edi,%edx
  802429:	83 c4 1c             	add    $0x1c,%esp
  80242c:	5b                   	pop    %ebx
  80242d:	5e                   	pop    %esi
  80242e:	5f                   	pop    %edi
  80242f:	5d                   	pop    %ebp
  802430:	c3                   	ret    
  802431:	8d 76 00             	lea    0x0(%esi),%esi
  802434:	31 ff                	xor    %edi,%edi
  802436:	31 c0                	xor    %eax,%eax
  802438:	89 fa                	mov    %edi,%edx
  80243a:	83 c4 1c             	add    $0x1c,%esp
  80243d:	5b                   	pop    %ebx
  80243e:	5e                   	pop    %esi
  80243f:	5f                   	pop    %edi
  802440:	5d                   	pop    %ebp
  802441:	c3                   	ret    
  802442:	66 90                	xchg   %ax,%ax
  802444:	89 d8                	mov    %ebx,%eax
  802446:	f7 f7                	div    %edi
  802448:	31 ff                	xor    %edi,%edi
  80244a:	89 fa                	mov    %edi,%edx
  80244c:	83 c4 1c             	add    $0x1c,%esp
  80244f:	5b                   	pop    %ebx
  802450:	5e                   	pop    %esi
  802451:	5f                   	pop    %edi
  802452:	5d                   	pop    %ebp
  802453:	c3                   	ret    
  802454:	bd 20 00 00 00       	mov    $0x20,%ebp
  802459:	89 eb                	mov    %ebp,%ebx
  80245b:	29 fb                	sub    %edi,%ebx
  80245d:	89 f9                	mov    %edi,%ecx
  80245f:	d3 e6                	shl    %cl,%esi
  802461:	89 c5                	mov    %eax,%ebp
  802463:	88 d9                	mov    %bl,%cl
  802465:	d3 ed                	shr    %cl,%ebp
  802467:	89 e9                	mov    %ebp,%ecx
  802469:	09 f1                	or     %esi,%ecx
  80246b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80246f:	89 f9                	mov    %edi,%ecx
  802471:	d3 e0                	shl    %cl,%eax
  802473:	89 c5                	mov    %eax,%ebp
  802475:	89 d6                	mov    %edx,%esi
  802477:	88 d9                	mov    %bl,%cl
  802479:	d3 ee                	shr    %cl,%esi
  80247b:	89 f9                	mov    %edi,%ecx
  80247d:	d3 e2                	shl    %cl,%edx
  80247f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802483:	88 d9                	mov    %bl,%cl
  802485:	d3 e8                	shr    %cl,%eax
  802487:	09 c2                	or     %eax,%edx
  802489:	89 d0                	mov    %edx,%eax
  80248b:	89 f2                	mov    %esi,%edx
  80248d:	f7 74 24 0c          	divl   0xc(%esp)
  802491:	89 d6                	mov    %edx,%esi
  802493:	89 c3                	mov    %eax,%ebx
  802495:	f7 e5                	mul    %ebp
  802497:	39 d6                	cmp    %edx,%esi
  802499:	72 19                	jb     8024b4 <__udivdi3+0xfc>
  80249b:	74 0b                	je     8024a8 <__udivdi3+0xf0>
  80249d:	89 d8                	mov    %ebx,%eax
  80249f:	31 ff                	xor    %edi,%edi
  8024a1:	e9 58 ff ff ff       	jmp    8023fe <__udivdi3+0x46>
  8024a6:	66 90                	xchg   %ax,%ax
  8024a8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024ac:	89 f9                	mov    %edi,%ecx
  8024ae:	d3 e2                	shl    %cl,%edx
  8024b0:	39 c2                	cmp    %eax,%edx
  8024b2:	73 e9                	jae    80249d <__udivdi3+0xe5>
  8024b4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8024b7:	31 ff                	xor    %edi,%edi
  8024b9:	e9 40 ff ff ff       	jmp    8023fe <__udivdi3+0x46>
  8024be:	66 90                	xchg   %ax,%ax
  8024c0:	31 c0                	xor    %eax,%eax
  8024c2:	e9 37 ff ff ff       	jmp    8023fe <__udivdi3+0x46>
  8024c7:	90                   	nop

008024c8 <__umoddi3>:
  8024c8:	55                   	push   %ebp
  8024c9:	57                   	push   %edi
  8024ca:	56                   	push   %esi
  8024cb:	53                   	push   %ebx
  8024cc:	83 ec 1c             	sub    $0x1c,%esp
  8024cf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8024d3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8024d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024db:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8024df:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8024e3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8024e7:	89 f3                	mov    %esi,%ebx
  8024e9:	89 fa                	mov    %edi,%edx
  8024eb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024ef:	89 34 24             	mov    %esi,(%esp)
  8024f2:	85 c0                	test   %eax,%eax
  8024f4:	75 1a                	jne    802510 <__umoddi3+0x48>
  8024f6:	39 f7                	cmp    %esi,%edi
  8024f8:	0f 86 a2 00 00 00    	jbe    8025a0 <__umoddi3+0xd8>
  8024fe:	89 c8                	mov    %ecx,%eax
  802500:	89 f2                	mov    %esi,%edx
  802502:	f7 f7                	div    %edi
  802504:	89 d0                	mov    %edx,%eax
  802506:	31 d2                	xor    %edx,%edx
  802508:	83 c4 1c             	add    $0x1c,%esp
  80250b:	5b                   	pop    %ebx
  80250c:	5e                   	pop    %esi
  80250d:	5f                   	pop    %edi
  80250e:	5d                   	pop    %ebp
  80250f:	c3                   	ret    
  802510:	39 f0                	cmp    %esi,%eax
  802512:	0f 87 ac 00 00 00    	ja     8025c4 <__umoddi3+0xfc>
  802518:	0f bd e8             	bsr    %eax,%ebp
  80251b:	83 f5 1f             	xor    $0x1f,%ebp
  80251e:	0f 84 ac 00 00 00    	je     8025d0 <__umoddi3+0x108>
  802524:	bf 20 00 00 00       	mov    $0x20,%edi
  802529:	29 ef                	sub    %ebp,%edi
  80252b:	89 fe                	mov    %edi,%esi
  80252d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802531:	89 e9                	mov    %ebp,%ecx
  802533:	d3 e0                	shl    %cl,%eax
  802535:	89 d7                	mov    %edx,%edi
  802537:	89 f1                	mov    %esi,%ecx
  802539:	d3 ef                	shr    %cl,%edi
  80253b:	09 c7                	or     %eax,%edi
  80253d:	89 e9                	mov    %ebp,%ecx
  80253f:	d3 e2                	shl    %cl,%edx
  802541:	89 14 24             	mov    %edx,(%esp)
  802544:	89 d8                	mov    %ebx,%eax
  802546:	d3 e0                	shl    %cl,%eax
  802548:	89 c2                	mov    %eax,%edx
  80254a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80254e:	d3 e0                	shl    %cl,%eax
  802550:	89 44 24 04          	mov    %eax,0x4(%esp)
  802554:	8b 44 24 08          	mov    0x8(%esp),%eax
  802558:	89 f1                	mov    %esi,%ecx
  80255a:	d3 e8                	shr    %cl,%eax
  80255c:	09 d0                	or     %edx,%eax
  80255e:	d3 eb                	shr    %cl,%ebx
  802560:	89 da                	mov    %ebx,%edx
  802562:	f7 f7                	div    %edi
  802564:	89 d3                	mov    %edx,%ebx
  802566:	f7 24 24             	mull   (%esp)
  802569:	89 c6                	mov    %eax,%esi
  80256b:	89 d1                	mov    %edx,%ecx
  80256d:	39 d3                	cmp    %edx,%ebx
  80256f:	0f 82 87 00 00 00    	jb     8025fc <__umoddi3+0x134>
  802575:	0f 84 91 00 00 00    	je     80260c <__umoddi3+0x144>
  80257b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80257f:	29 f2                	sub    %esi,%edx
  802581:	19 cb                	sbb    %ecx,%ebx
  802583:	89 d8                	mov    %ebx,%eax
  802585:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802589:	d3 e0                	shl    %cl,%eax
  80258b:	89 e9                	mov    %ebp,%ecx
  80258d:	d3 ea                	shr    %cl,%edx
  80258f:	09 d0                	or     %edx,%eax
  802591:	89 e9                	mov    %ebp,%ecx
  802593:	d3 eb                	shr    %cl,%ebx
  802595:	89 da                	mov    %ebx,%edx
  802597:	83 c4 1c             	add    $0x1c,%esp
  80259a:	5b                   	pop    %ebx
  80259b:	5e                   	pop    %esi
  80259c:	5f                   	pop    %edi
  80259d:	5d                   	pop    %ebp
  80259e:	c3                   	ret    
  80259f:	90                   	nop
  8025a0:	89 fd                	mov    %edi,%ebp
  8025a2:	85 ff                	test   %edi,%edi
  8025a4:	75 0b                	jne    8025b1 <__umoddi3+0xe9>
  8025a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8025ab:	31 d2                	xor    %edx,%edx
  8025ad:	f7 f7                	div    %edi
  8025af:	89 c5                	mov    %eax,%ebp
  8025b1:	89 f0                	mov    %esi,%eax
  8025b3:	31 d2                	xor    %edx,%edx
  8025b5:	f7 f5                	div    %ebp
  8025b7:	89 c8                	mov    %ecx,%eax
  8025b9:	f7 f5                	div    %ebp
  8025bb:	89 d0                	mov    %edx,%eax
  8025bd:	e9 44 ff ff ff       	jmp    802506 <__umoddi3+0x3e>
  8025c2:	66 90                	xchg   %ax,%ax
  8025c4:	89 c8                	mov    %ecx,%eax
  8025c6:	89 f2                	mov    %esi,%edx
  8025c8:	83 c4 1c             	add    $0x1c,%esp
  8025cb:	5b                   	pop    %ebx
  8025cc:	5e                   	pop    %esi
  8025cd:	5f                   	pop    %edi
  8025ce:	5d                   	pop    %ebp
  8025cf:	c3                   	ret    
  8025d0:	3b 04 24             	cmp    (%esp),%eax
  8025d3:	72 06                	jb     8025db <__umoddi3+0x113>
  8025d5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8025d9:	77 0f                	ja     8025ea <__umoddi3+0x122>
  8025db:	89 f2                	mov    %esi,%edx
  8025dd:	29 f9                	sub    %edi,%ecx
  8025df:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8025e3:	89 14 24             	mov    %edx,(%esp)
  8025e6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8025ea:	8b 44 24 04          	mov    0x4(%esp),%eax
  8025ee:	8b 14 24             	mov    (%esp),%edx
  8025f1:	83 c4 1c             	add    $0x1c,%esp
  8025f4:	5b                   	pop    %ebx
  8025f5:	5e                   	pop    %esi
  8025f6:	5f                   	pop    %edi
  8025f7:	5d                   	pop    %ebp
  8025f8:	c3                   	ret    
  8025f9:	8d 76 00             	lea    0x0(%esi),%esi
  8025fc:	2b 04 24             	sub    (%esp),%eax
  8025ff:	19 fa                	sbb    %edi,%edx
  802601:	89 d1                	mov    %edx,%ecx
  802603:	89 c6                	mov    %eax,%esi
  802605:	e9 71 ff ff ff       	jmp    80257b <__umoddi3+0xb3>
  80260a:	66 90                	xchg   %ax,%ax
  80260c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802610:	72 ea                	jb     8025fc <__umoddi3+0x134>
  802612:	89 d9                	mov    %ebx,%ecx
  802614:	e9 62 ff ff ff       	jmp    80257b <__umoddi3+0xb3>
