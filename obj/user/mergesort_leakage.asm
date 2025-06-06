
obj/user/mergesort_leakage:     file format elf32-i386


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
  800031:	e8 73 07 00 00       	call   8007a9 <libmain>
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
  800041:	e8 75 1f 00 00       	call   801fbb <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 00 26 80 00       	push   $0x802600
  80004e:	e8 0c 0b 00 00       	call   800b5f <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 02 26 80 00       	push   $0x802602
  80005e:	e8 fc 0a 00 00       	call   800b5f <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 18 26 80 00       	push   $0x802618
  80006e:	e8 ec 0a 00 00       	call   800b5f <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 02 26 80 00       	push   $0x802602
  80007e:	e8 dc 0a 00 00       	call   800b5f <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 00 26 80 00       	push   $0x802600
  80008e:	e8 cc 0a 00 00       	call   800b5f <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 30 26 80 00       	push   $0x802630
  8000a5:	e8 37 11 00 00       	call   8011e1 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 87 16 00 00       	call   801747 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 54 1a 00 00       	call   801b29 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 50 26 80 00       	push   $0x802650
  8000e3:	e8 77 0a 00 00       	call   800b5f <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 72 26 80 00       	push   $0x802672
  8000f3:	e8 67 0a 00 00       	call   800b5f <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 80 26 80 00       	push   $0x802680
  800103:	e8 57 0a 00 00       	call   800b5f <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 8f 26 80 00       	push   $0x80268f
  800113:	e8 47 0a 00 00       	call   800b5f <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 9f 26 80 00       	push   $0x80269f
  800123:	e8 37 0a 00 00       	call   800b5f <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 21 06 00 00       	call   800751 <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 c9 05 00 00       	call   800709 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 bc 05 00 00       	call   800709 <cputchar>
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
  800162:	e8 6e 1e 00 00       	call   801fd5 <sys_enable_interrupt>

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
  8001d7:	e8 df 1d 00 00       	call   801fbb <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 a8 26 80 00       	push   $0x8026a8
  8001e4:	e8 76 09 00 00       	call   800b5f <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 e4 1d 00 00       	call   801fd5 <sys_enable_interrupt>

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
  80020e:	68 dc 26 80 00       	push   $0x8026dc
  800213:	6a 4a                	push   $0x4a
  800215:	68 fe 26 80 00       	push   $0x8026fe
  80021a:	e8 8c 06 00 00       	call   8008ab <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 97 1d 00 00       	call   801fbb <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 18 27 80 00       	push   $0x802718
  80022c:	e8 2e 09 00 00       	call   800b5f <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 4c 27 80 00       	push   $0x80274c
  80023c:	e8 1e 09 00 00       	call   800b5f <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 80 27 80 00       	push   $0x802780
  80024c:	e8 0e 09 00 00       	call   800b5f <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 7c 1d 00 00       	call   801fd5 <sys_enable_interrupt>
		}

		free(Elements) ;
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	ff 75 ec             	pushl  -0x14(%ebp)
  80025f:	e8 e6 19 00 00       	call   801c4a <free>
  800264:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800267:	e8 4f 1d 00 00       	call   801fbb <sys_disable_interrupt>
			Chose = 0 ;
  80026c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800270:	eb 42                	jmp    8002b4 <_main+0x27c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 b2 27 80 00       	push   $0x8027b2
  80027a:	e8 e0 08 00 00       	call   800b5f <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800282:	e8 ca 04 00 00       	call   800751 <getchar>
  800287:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80028a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80028e:	83 ec 0c             	sub    $0xc,%esp
  800291:	50                   	push   %eax
  800292:	e8 72 04 00 00       	call   800709 <cputchar>
  800297:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	6a 0a                	push   $0xa
  80029f:	e8 65 04 00 00       	call   800709 <cputchar>
  8002a4:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  8002a7:	83 ec 0c             	sub    $0xc,%esp
  8002aa:	6a 0a                	push   $0xa
  8002ac:	e8 58 04 00 00       	call   800709 <cputchar>
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
  8002c0:	e8 10 1d 00 00       	call   801fd5 <sys_enable_interrupt>

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
  800454:	68 00 26 80 00       	push   $0x802600
  800459:	e8 01 07 00 00       	call   800b5f <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800464:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	50                   	push   %eax
  800476:	68 d0 27 80 00       	push   $0x8027d0
  80047b:	e8 df 06 00 00       	call   800b5f <cprintf>
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
  8004a4:	68 d5 27 80 00       	push   $0x8027d5
  8004a9:	e8 b1 06 00 00       	call   800b5f <cprintf>
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

	int* Left = malloc(sizeof(int) * leftCapacity);
  800540:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800543:	c1 e0 02             	shl    $0x2,%eax
  800546:	83 ec 0c             	sub    $0xc,%esp
  800549:	50                   	push   %eax
  80054a:	e8 da 15 00 00       	call   801b29 <malloc>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800555:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800558:	c1 e0 02             	shl    $0x2,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 c5 15 00 00       	call   801b29 <malloc>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

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

	//	int Left[5000] ;
	//	int Right[5000] ;

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
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  800706:	90                   	nop
  800707:	c9                   	leave  
  800708:	c3                   	ret    

00800709 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800709:	55                   	push   %ebp
  80070a:	89 e5                	mov    %esp,%ebp
  80070c:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80070f:	8b 45 08             	mov    0x8(%ebp),%eax
  800712:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800715:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800719:	83 ec 0c             	sub    $0xc,%esp
  80071c:	50                   	push   %eax
  80071d:	e8 cd 18 00 00       	call   801fef <sys_cputc>
  800722:	83 c4 10             	add    $0x10,%esp
}
  800725:	90                   	nop
  800726:	c9                   	leave  
  800727:	c3                   	ret    

00800728 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800728:	55                   	push   %ebp
  800729:	89 e5                	mov    %esp,%ebp
  80072b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80072e:	e8 88 18 00 00       	call   801fbb <sys_disable_interrupt>
	char c = ch;
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800739:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80073d:	83 ec 0c             	sub    $0xc,%esp
  800740:	50                   	push   %eax
  800741:	e8 a9 18 00 00       	call   801fef <sys_cputc>
  800746:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800749:	e8 87 18 00 00       	call   801fd5 <sys_enable_interrupt>
}
  80074e:	90                   	nop
  80074f:	c9                   	leave  
  800750:	c3                   	ret    

00800751 <getchar>:

int
getchar(void)
{
  800751:	55                   	push   %ebp
  800752:	89 e5                	mov    %esp,%ebp
  800754:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800757:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80075e:	eb 08                	jmp    800768 <getchar+0x17>
	{
		c = sys_cgetc();
  800760:	e8 6e 16 00 00       	call   801dd3 <sys_cgetc>
  800765:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800768:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80076c:	74 f2                	je     800760 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80076e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800771:	c9                   	leave  
  800772:	c3                   	ret    

00800773 <atomic_getchar>:

int
atomic_getchar(void)
{
  800773:	55                   	push   %ebp
  800774:	89 e5                	mov    %esp,%ebp
  800776:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800779:	e8 3d 18 00 00       	call   801fbb <sys_disable_interrupt>
	int c=0;
  80077e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800785:	eb 08                	jmp    80078f <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800787:	e8 47 16 00 00       	call   801dd3 <sys_cgetc>
  80078c:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80078f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800793:	74 f2                	je     800787 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800795:	e8 3b 18 00 00       	call   801fd5 <sys_enable_interrupt>
	return c;
  80079a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80079d:	c9                   	leave  
  80079e:	c3                   	ret    

0080079f <iscons>:

int iscons(int fdnum)
{
  80079f:	55                   	push   %ebp
  8007a0:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007a2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007a7:	5d                   	pop    %ebp
  8007a8:	c3                   	ret    

008007a9 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007a9:	55                   	push   %ebp
  8007aa:	89 e5                	mov    %esp,%ebp
  8007ac:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007af:	e8 6c 16 00 00       	call   801e20 <sys_getenvindex>
  8007b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ba:	89 d0                	mov    %edx,%eax
  8007bc:	01 c0                	add    %eax,%eax
  8007be:	01 d0                	add    %edx,%eax
  8007c0:	c1 e0 02             	shl    $0x2,%eax
  8007c3:	01 d0                	add    %edx,%eax
  8007c5:	c1 e0 06             	shl    $0x6,%eax
  8007c8:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007cd:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007d2:	a1 24 30 80 00       	mov    0x803024,%eax
  8007d7:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8007dd:	84 c0                	test   %al,%al
  8007df:	74 0f                	je     8007f0 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8007e1:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e6:	05 f4 02 00 00       	add    $0x2f4,%eax
  8007eb:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007f0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8007f4:	7e 0a                	jle    800800 <libmain+0x57>
		binaryname = argv[0];
  8007f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007f9:	8b 00                	mov    (%eax),%eax
  8007fb:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800800:	83 ec 08             	sub    $0x8,%esp
  800803:	ff 75 0c             	pushl  0xc(%ebp)
  800806:	ff 75 08             	pushl  0x8(%ebp)
  800809:	e8 2a f8 ff ff       	call   800038 <_main>
  80080e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800811:	e8 a5 17 00 00       	call   801fbb <sys_disable_interrupt>
	cprintf("**************************************\n");
  800816:	83 ec 0c             	sub    $0xc,%esp
  800819:	68 f4 27 80 00       	push   $0x8027f4
  80081e:	e8 3c 03 00 00       	call   800b5f <cprintf>
  800823:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800826:	a1 24 30 80 00       	mov    0x803024,%eax
  80082b:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800831:	a1 24 30 80 00       	mov    0x803024,%eax
  800836:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80083c:	83 ec 04             	sub    $0x4,%esp
  80083f:	52                   	push   %edx
  800840:	50                   	push   %eax
  800841:	68 1c 28 80 00       	push   $0x80281c
  800846:	e8 14 03 00 00       	call   800b5f <cprintf>
  80084b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80084e:	a1 24 30 80 00       	mov    0x803024,%eax
  800853:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800859:	83 ec 08             	sub    $0x8,%esp
  80085c:	50                   	push   %eax
  80085d:	68 41 28 80 00       	push   $0x802841
  800862:	e8 f8 02 00 00       	call   800b5f <cprintf>
  800867:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80086a:	83 ec 0c             	sub    $0xc,%esp
  80086d:	68 f4 27 80 00       	push   $0x8027f4
  800872:	e8 e8 02 00 00       	call   800b5f <cprintf>
  800877:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80087a:	e8 56 17 00 00       	call   801fd5 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80087f:	e8 19 00 00 00       	call   80089d <exit>
}
  800884:	90                   	nop
  800885:	c9                   	leave  
  800886:	c3                   	ret    

00800887 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800887:	55                   	push   %ebp
  800888:	89 e5                	mov    %esp,%ebp
  80088a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80088d:	83 ec 0c             	sub    $0xc,%esp
  800890:	6a 00                	push   $0x0
  800892:	e8 55 15 00 00       	call   801dec <sys_env_destroy>
  800897:	83 c4 10             	add    $0x10,%esp
}
  80089a:	90                   	nop
  80089b:	c9                   	leave  
  80089c:	c3                   	ret    

0080089d <exit>:

void
exit(void)
{
  80089d:	55                   	push   %ebp
  80089e:	89 e5                	mov    %esp,%ebp
  8008a0:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008a3:	e8 aa 15 00 00       	call   801e52 <sys_env_exit>
}
  8008a8:	90                   	nop
  8008a9:	c9                   	leave  
  8008aa:	c3                   	ret    

008008ab <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008ab:	55                   	push   %ebp
  8008ac:	89 e5                	mov    %esp,%ebp
  8008ae:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008b1:	8d 45 10             	lea    0x10(%ebp),%eax
  8008b4:	83 c0 04             	add    $0x4,%eax
  8008b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008ba:	a1 34 30 80 00       	mov    0x803034,%eax
  8008bf:	85 c0                	test   %eax,%eax
  8008c1:	74 16                	je     8008d9 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008c3:	a1 34 30 80 00       	mov    0x803034,%eax
  8008c8:	83 ec 08             	sub    $0x8,%esp
  8008cb:	50                   	push   %eax
  8008cc:	68 58 28 80 00       	push   $0x802858
  8008d1:	e8 89 02 00 00       	call   800b5f <cprintf>
  8008d6:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8008d9:	a1 00 30 80 00       	mov    0x803000,%eax
  8008de:	ff 75 0c             	pushl  0xc(%ebp)
  8008e1:	ff 75 08             	pushl  0x8(%ebp)
  8008e4:	50                   	push   %eax
  8008e5:	68 5d 28 80 00       	push   $0x80285d
  8008ea:	e8 70 02 00 00       	call   800b5f <cprintf>
  8008ef:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8008f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8008f5:	83 ec 08             	sub    $0x8,%esp
  8008f8:	ff 75 f4             	pushl  -0xc(%ebp)
  8008fb:	50                   	push   %eax
  8008fc:	e8 f3 01 00 00       	call   800af4 <vcprintf>
  800901:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800904:	83 ec 08             	sub    $0x8,%esp
  800907:	6a 00                	push   $0x0
  800909:	68 79 28 80 00       	push   $0x802879
  80090e:	e8 e1 01 00 00       	call   800af4 <vcprintf>
  800913:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800916:	e8 82 ff ff ff       	call   80089d <exit>

	// should not return here
	while (1) ;
  80091b:	eb fe                	jmp    80091b <_panic+0x70>

0080091d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80091d:	55                   	push   %ebp
  80091e:	89 e5                	mov    %esp,%ebp
  800920:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800923:	a1 24 30 80 00       	mov    0x803024,%eax
  800928:	8b 50 74             	mov    0x74(%eax),%edx
  80092b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092e:	39 c2                	cmp    %eax,%edx
  800930:	74 14                	je     800946 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800932:	83 ec 04             	sub    $0x4,%esp
  800935:	68 7c 28 80 00       	push   $0x80287c
  80093a:	6a 26                	push   $0x26
  80093c:	68 c8 28 80 00       	push   $0x8028c8
  800941:	e8 65 ff ff ff       	call   8008ab <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800946:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80094d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800954:	e9 c2 00 00 00       	jmp    800a1b <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800959:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80095c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800963:	8b 45 08             	mov    0x8(%ebp),%eax
  800966:	01 d0                	add    %edx,%eax
  800968:	8b 00                	mov    (%eax),%eax
  80096a:	85 c0                	test   %eax,%eax
  80096c:	75 08                	jne    800976 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80096e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800971:	e9 a2 00 00 00       	jmp    800a18 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800976:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80097d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800984:	eb 69                	jmp    8009ef <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800986:	a1 24 30 80 00       	mov    0x803024,%eax
  80098b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800991:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800994:	89 d0                	mov    %edx,%eax
  800996:	01 c0                	add    %eax,%eax
  800998:	01 d0                	add    %edx,%eax
  80099a:	c1 e0 02             	shl    $0x2,%eax
  80099d:	01 c8                	add    %ecx,%eax
  80099f:	8a 40 04             	mov    0x4(%eax),%al
  8009a2:	84 c0                	test   %al,%al
  8009a4:	75 46                	jne    8009ec <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009a6:	a1 24 30 80 00       	mov    0x803024,%eax
  8009ab:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009b1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009b4:	89 d0                	mov    %edx,%eax
  8009b6:	01 c0                	add    %eax,%eax
  8009b8:	01 d0                	add    %edx,%eax
  8009ba:	c1 e0 02             	shl    $0x2,%eax
  8009bd:	01 c8                	add    %ecx,%eax
  8009bf:	8b 00                	mov    (%eax),%eax
  8009c1:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009c7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009cc:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009d1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8009d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009db:	01 c8                	add    %ecx,%eax
  8009dd:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009df:	39 c2                	cmp    %eax,%edx
  8009e1:	75 09                	jne    8009ec <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8009e3:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8009ea:	eb 12                	jmp    8009fe <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009ec:	ff 45 e8             	incl   -0x18(%ebp)
  8009ef:	a1 24 30 80 00       	mov    0x803024,%eax
  8009f4:	8b 50 74             	mov    0x74(%eax),%edx
  8009f7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8009fa:	39 c2                	cmp    %eax,%edx
  8009fc:	77 88                	ja     800986 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8009fe:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a02:	75 14                	jne    800a18 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800a04:	83 ec 04             	sub    $0x4,%esp
  800a07:	68 d4 28 80 00       	push   $0x8028d4
  800a0c:	6a 3a                	push   $0x3a
  800a0e:	68 c8 28 80 00       	push   $0x8028c8
  800a13:	e8 93 fe ff ff       	call   8008ab <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a18:	ff 45 f0             	incl   -0x10(%ebp)
  800a1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a1e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a21:	0f 8c 32 ff ff ff    	jl     800959 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a27:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a2e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a35:	eb 26                	jmp    800a5d <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a37:	a1 24 30 80 00       	mov    0x803024,%eax
  800a3c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800a42:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a45:	89 d0                	mov    %edx,%eax
  800a47:	01 c0                	add    %eax,%eax
  800a49:	01 d0                	add    %edx,%eax
  800a4b:	c1 e0 02             	shl    $0x2,%eax
  800a4e:	01 c8                	add    %ecx,%eax
  800a50:	8a 40 04             	mov    0x4(%eax),%al
  800a53:	3c 01                	cmp    $0x1,%al
  800a55:	75 03                	jne    800a5a <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800a57:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a5a:	ff 45 e0             	incl   -0x20(%ebp)
  800a5d:	a1 24 30 80 00       	mov    0x803024,%eax
  800a62:	8b 50 74             	mov    0x74(%eax),%edx
  800a65:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a68:	39 c2                	cmp    %eax,%edx
  800a6a:	77 cb                	ja     800a37 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a6f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a72:	74 14                	je     800a88 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800a74:	83 ec 04             	sub    $0x4,%esp
  800a77:	68 28 29 80 00       	push   $0x802928
  800a7c:	6a 44                	push   $0x44
  800a7e:	68 c8 28 80 00       	push   $0x8028c8
  800a83:	e8 23 fe ff ff       	call   8008ab <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a88:	90                   	nop
  800a89:	c9                   	leave  
  800a8a:	c3                   	ret    

00800a8b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800a8b:	55                   	push   %ebp
  800a8c:	89 e5                	mov    %esp,%ebp
  800a8e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800a91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a94:	8b 00                	mov    (%eax),%eax
  800a96:	8d 48 01             	lea    0x1(%eax),%ecx
  800a99:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a9c:	89 0a                	mov    %ecx,(%edx)
  800a9e:	8b 55 08             	mov    0x8(%ebp),%edx
  800aa1:	88 d1                	mov    %dl,%cl
  800aa3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aa6:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800aaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aad:	8b 00                	mov    (%eax),%eax
  800aaf:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ab4:	75 2c                	jne    800ae2 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ab6:	a0 28 30 80 00       	mov    0x803028,%al
  800abb:	0f b6 c0             	movzbl %al,%eax
  800abe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac1:	8b 12                	mov    (%edx),%edx
  800ac3:	89 d1                	mov    %edx,%ecx
  800ac5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac8:	83 c2 08             	add    $0x8,%edx
  800acb:	83 ec 04             	sub    $0x4,%esp
  800ace:	50                   	push   %eax
  800acf:	51                   	push   %ecx
  800ad0:	52                   	push   %edx
  800ad1:	e8 d4 12 00 00       	call   801daa <sys_cputs>
  800ad6:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800ae2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae5:	8b 40 04             	mov    0x4(%eax),%eax
  800ae8:	8d 50 01             	lea    0x1(%eax),%edx
  800aeb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aee:	89 50 04             	mov    %edx,0x4(%eax)
}
  800af1:	90                   	nop
  800af2:	c9                   	leave  
  800af3:	c3                   	ret    

00800af4 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800af4:	55                   	push   %ebp
  800af5:	89 e5                	mov    %esp,%ebp
  800af7:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800afd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b04:	00 00 00 
	b.cnt = 0;
  800b07:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b0e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b11:	ff 75 0c             	pushl  0xc(%ebp)
  800b14:	ff 75 08             	pushl  0x8(%ebp)
  800b17:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b1d:	50                   	push   %eax
  800b1e:	68 8b 0a 80 00       	push   $0x800a8b
  800b23:	e8 11 02 00 00       	call   800d39 <vprintfmt>
  800b28:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b2b:	a0 28 30 80 00       	mov    0x803028,%al
  800b30:	0f b6 c0             	movzbl %al,%eax
  800b33:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b39:	83 ec 04             	sub    $0x4,%esp
  800b3c:	50                   	push   %eax
  800b3d:	52                   	push   %edx
  800b3e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b44:	83 c0 08             	add    $0x8,%eax
  800b47:	50                   	push   %eax
  800b48:	e8 5d 12 00 00       	call   801daa <sys_cputs>
  800b4d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b50:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b57:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b5d:	c9                   	leave  
  800b5e:	c3                   	ret    

00800b5f <cprintf>:

int cprintf(const char *fmt, ...) {
  800b5f:	55                   	push   %ebp
  800b60:	89 e5                	mov    %esp,%ebp
  800b62:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b65:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800b6c:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b72:	8b 45 08             	mov    0x8(%ebp),%eax
  800b75:	83 ec 08             	sub    $0x8,%esp
  800b78:	ff 75 f4             	pushl  -0xc(%ebp)
  800b7b:	50                   	push   %eax
  800b7c:	e8 73 ff ff ff       	call   800af4 <vcprintf>
  800b81:	83 c4 10             	add    $0x10,%esp
  800b84:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b87:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b8a:	c9                   	leave  
  800b8b:	c3                   	ret    

00800b8c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800b8c:	55                   	push   %ebp
  800b8d:	89 e5                	mov    %esp,%ebp
  800b8f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800b92:	e8 24 14 00 00       	call   801fbb <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800b97:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba0:	83 ec 08             	sub    $0x8,%esp
  800ba3:	ff 75 f4             	pushl  -0xc(%ebp)
  800ba6:	50                   	push   %eax
  800ba7:	e8 48 ff ff ff       	call   800af4 <vcprintf>
  800bac:	83 c4 10             	add    $0x10,%esp
  800baf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bb2:	e8 1e 14 00 00       	call   801fd5 <sys_enable_interrupt>
	return cnt;
  800bb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bba:	c9                   	leave  
  800bbb:	c3                   	ret    

00800bbc <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bbc:	55                   	push   %ebp
  800bbd:	89 e5                	mov    %esp,%ebp
  800bbf:	53                   	push   %ebx
  800bc0:	83 ec 14             	sub    $0x14,%esp
  800bc3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bc9:	8b 45 14             	mov    0x14(%ebp),%eax
  800bcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bcf:	8b 45 18             	mov    0x18(%ebp),%eax
  800bd2:	ba 00 00 00 00       	mov    $0x0,%edx
  800bd7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bda:	77 55                	ja     800c31 <printnum+0x75>
  800bdc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bdf:	72 05                	jb     800be6 <printnum+0x2a>
  800be1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800be4:	77 4b                	ja     800c31 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800be6:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800be9:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800bec:	8b 45 18             	mov    0x18(%ebp),%eax
  800bef:	ba 00 00 00 00       	mov    $0x0,%edx
  800bf4:	52                   	push   %edx
  800bf5:	50                   	push   %eax
  800bf6:	ff 75 f4             	pushl  -0xc(%ebp)
  800bf9:	ff 75 f0             	pushl  -0x10(%ebp)
  800bfc:	e8 9b 17 00 00       	call   80239c <__udivdi3>
  800c01:	83 c4 10             	add    $0x10,%esp
  800c04:	83 ec 04             	sub    $0x4,%esp
  800c07:	ff 75 20             	pushl  0x20(%ebp)
  800c0a:	53                   	push   %ebx
  800c0b:	ff 75 18             	pushl  0x18(%ebp)
  800c0e:	52                   	push   %edx
  800c0f:	50                   	push   %eax
  800c10:	ff 75 0c             	pushl  0xc(%ebp)
  800c13:	ff 75 08             	pushl  0x8(%ebp)
  800c16:	e8 a1 ff ff ff       	call   800bbc <printnum>
  800c1b:	83 c4 20             	add    $0x20,%esp
  800c1e:	eb 1a                	jmp    800c3a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c20:	83 ec 08             	sub    $0x8,%esp
  800c23:	ff 75 0c             	pushl  0xc(%ebp)
  800c26:	ff 75 20             	pushl  0x20(%ebp)
  800c29:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2c:	ff d0                	call   *%eax
  800c2e:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c31:	ff 4d 1c             	decl   0x1c(%ebp)
  800c34:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c38:	7f e6                	jg     800c20 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c3a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c3d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c42:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c45:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c48:	53                   	push   %ebx
  800c49:	51                   	push   %ecx
  800c4a:	52                   	push   %edx
  800c4b:	50                   	push   %eax
  800c4c:	e8 5b 18 00 00       	call   8024ac <__umoddi3>
  800c51:	83 c4 10             	add    $0x10,%esp
  800c54:	05 94 2b 80 00       	add    $0x802b94,%eax
  800c59:	8a 00                	mov    (%eax),%al
  800c5b:	0f be c0             	movsbl %al,%eax
  800c5e:	83 ec 08             	sub    $0x8,%esp
  800c61:	ff 75 0c             	pushl  0xc(%ebp)
  800c64:	50                   	push   %eax
  800c65:	8b 45 08             	mov    0x8(%ebp),%eax
  800c68:	ff d0                	call   *%eax
  800c6a:	83 c4 10             	add    $0x10,%esp
}
  800c6d:	90                   	nop
  800c6e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c71:	c9                   	leave  
  800c72:	c3                   	ret    

00800c73 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c73:	55                   	push   %ebp
  800c74:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c76:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c7a:	7e 1c                	jle    800c98 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	8b 00                	mov    (%eax),%eax
  800c81:	8d 50 08             	lea    0x8(%eax),%edx
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	89 10                	mov    %edx,(%eax)
  800c89:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8c:	8b 00                	mov    (%eax),%eax
  800c8e:	83 e8 08             	sub    $0x8,%eax
  800c91:	8b 50 04             	mov    0x4(%eax),%edx
  800c94:	8b 00                	mov    (%eax),%eax
  800c96:	eb 40                	jmp    800cd8 <getuint+0x65>
	else if (lflag)
  800c98:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c9c:	74 1e                	je     800cbc <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca1:	8b 00                	mov    (%eax),%eax
  800ca3:	8d 50 04             	lea    0x4(%eax),%edx
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	89 10                	mov    %edx,(%eax)
  800cab:	8b 45 08             	mov    0x8(%ebp),%eax
  800cae:	8b 00                	mov    (%eax),%eax
  800cb0:	83 e8 04             	sub    $0x4,%eax
  800cb3:	8b 00                	mov    (%eax),%eax
  800cb5:	ba 00 00 00 00       	mov    $0x0,%edx
  800cba:	eb 1c                	jmp    800cd8 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbf:	8b 00                	mov    (%eax),%eax
  800cc1:	8d 50 04             	lea    0x4(%eax),%edx
  800cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc7:	89 10                	mov    %edx,(%eax)
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	8b 00                	mov    (%eax),%eax
  800cce:	83 e8 04             	sub    $0x4,%eax
  800cd1:	8b 00                	mov    (%eax),%eax
  800cd3:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cd8:	5d                   	pop    %ebp
  800cd9:	c3                   	ret    

00800cda <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cda:	55                   	push   %ebp
  800cdb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cdd:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ce1:	7e 1c                	jle    800cff <getint+0x25>
		return va_arg(*ap, long long);
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	8b 00                	mov    (%eax),%eax
  800ce8:	8d 50 08             	lea    0x8(%eax),%edx
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	89 10                	mov    %edx,(%eax)
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	8b 00                	mov    (%eax),%eax
  800cf5:	83 e8 08             	sub    $0x8,%eax
  800cf8:	8b 50 04             	mov    0x4(%eax),%edx
  800cfb:	8b 00                	mov    (%eax),%eax
  800cfd:	eb 38                	jmp    800d37 <getint+0x5d>
	else if (lflag)
  800cff:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d03:	74 1a                	je     800d1f <getint+0x45>
		return va_arg(*ap, long);
  800d05:	8b 45 08             	mov    0x8(%ebp),%eax
  800d08:	8b 00                	mov    (%eax),%eax
  800d0a:	8d 50 04             	lea    0x4(%eax),%edx
  800d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d10:	89 10                	mov    %edx,(%eax)
  800d12:	8b 45 08             	mov    0x8(%ebp),%eax
  800d15:	8b 00                	mov    (%eax),%eax
  800d17:	83 e8 04             	sub    $0x4,%eax
  800d1a:	8b 00                	mov    (%eax),%eax
  800d1c:	99                   	cltd   
  800d1d:	eb 18                	jmp    800d37 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	8b 00                	mov    (%eax),%eax
  800d24:	8d 50 04             	lea    0x4(%eax),%edx
  800d27:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2a:	89 10                	mov    %edx,(%eax)
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	8b 00                	mov    (%eax),%eax
  800d31:	83 e8 04             	sub    $0x4,%eax
  800d34:	8b 00                	mov    (%eax),%eax
  800d36:	99                   	cltd   
}
  800d37:	5d                   	pop    %ebp
  800d38:	c3                   	ret    

00800d39 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d39:	55                   	push   %ebp
  800d3a:	89 e5                	mov    %esp,%ebp
  800d3c:	56                   	push   %esi
  800d3d:	53                   	push   %ebx
  800d3e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d41:	eb 17                	jmp    800d5a <vprintfmt+0x21>
			if (ch == '\0')
  800d43:	85 db                	test   %ebx,%ebx
  800d45:	0f 84 af 03 00 00    	je     8010fa <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d4b:	83 ec 08             	sub    $0x8,%esp
  800d4e:	ff 75 0c             	pushl  0xc(%ebp)
  800d51:	53                   	push   %ebx
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	ff d0                	call   *%eax
  800d57:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d5d:	8d 50 01             	lea    0x1(%eax),%edx
  800d60:	89 55 10             	mov    %edx,0x10(%ebp)
  800d63:	8a 00                	mov    (%eax),%al
  800d65:	0f b6 d8             	movzbl %al,%ebx
  800d68:	83 fb 25             	cmp    $0x25,%ebx
  800d6b:	75 d6                	jne    800d43 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d6d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d71:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d78:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d7f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800d86:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800d8d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d90:	8d 50 01             	lea    0x1(%eax),%edx
  800d93:	89 55 10             	mov    %edx,0x10(%ebp)
  800d96:	8a 00                	mov    (%eax),%al
  800d98:	0f b6 d8             	movzbl %al,%ebx
  800d9b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800d9e:	83 f8 55             	cmp    $0x55,%eax
  800da1:	0f 87 2b 03 00 00    	ja     8010d2 <vprintfmt+0x399>
  800da7:	8b 04 85 b8 2b 80 00 	mov    0x802bb8(,%eax,4),%eax
  800dae:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800db0:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800db4:	eb d7                	jmp    800d8d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800db6:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800dba:	eb d1                	jmp    800d8d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dbc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800dc3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800dc6:	89 d0                	mov    %edx,%eax
  800dc8:	c1 e0 02             	shl    $0x2,%eax
  800dcb:	01 d0                	add    %edx,%eax
  800dcd:	01 c0                	add    %eax,%eax
  800dcf:	01 d8                	add    %ebx,%eax
  800dd1:	83 e8 30             	sub    $0x30,%eax
  800dd4:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800dd7:	8b 45 10             	mov    0x10(%ebp),%eax
  800dda:	8a 00                	mov    (%eax),%al
  800ddc:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ddf:	83 fb 2f             	cmp    $0x2f,%ebx
  800de2:	7e 3e                	jle    800e22 <vprintfmt+0xe9>
  800de4:	83 fb 39             	cmp    $0x39,%ebx
  800de7:	7f 39                	jg     800e22 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800de9:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800dec:	eb d5                	jmp    800dc3 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800dee:	8b 45 14             	mov    0x14(%ebp),%eax
  800df1:	83 c0 04             	add    $0x4,%eax
  800df4:	89 45 14             	mov    %eax,0x14(%ebp)
  800df7:	8b 45 14             	mov    0x14(%ebp),%eax
  800dfa:	83 e8 04             	sub    $0x4,%eax
  800dfd:	8b 00                	mov    (%eax),%eax
  800dff:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e02:	eb 1f                	jmp    800e23 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e04:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e08:	79 83                	jns    800d8d <vprintfmt+0x54>
				width = 0;
  800e0a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e11:	e9 77 ff ff ff       	jmp    800d8d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e16:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e1d:	e9 6b ff ff ff       	jmp    800d8d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e22:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e23:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e27:	0f 89 60 ff ff ff    	jns    800d8d <vprintfmt+0x54>
				width = precision, precision = -1;
  800e2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e30:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e33:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e3a:	e9 4e ff ff ff       	jmp    800d8d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e3f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e42:	e9 46 ff ff ff       	jmp    800d8d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e47:	8b 45 14             	mov    0x14(%ebp),%eax
  800e4a:	83 c0 04             	add    $0x4,%eax
  800e4d:	89 45 14             	mov    %eax,0x14(%ebp)
  800e50:	8b 45 14             	mov    0x14(%ebp),%eax
  800e53:	83 e8 04             	sub    $0x4,%eax
  800e56:	8b 00                	mov    (%eax),%eax
  800e58:	83 ec 08             	sub    $0x8,%esp
  800e5b:	ff 75 0c             	pushl  0xc(%ebp)
  800e5e:	50                   	push   %eax
  800e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e62:	ff d0                	call   *%eax
  800e64:	83 c4 10             	add    $0x10,%esp
			break;
  800e67:	e9 89 02 00 00       	jmp    8010f5 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e6c:	8b 45 14             	mov    0x14(%ebp),%eax
  800e6f:	83 c0 04             	add    $0x4,%eax
  800e72:	89 45 14             	mov    %eax,0x14(%ebp)
  800e75:	8b 45 14             	mov    0x14(%ebp),%eax
  800e78:	83 e8 04             	sub    $0x4,%eax
  800e7b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e7d:	85 db                	test   %ebx,%ebx
  800e7f:	79 02                	jns    800e83 <vprintfmt+0x14a>
				err = -err;
  800e81:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e83:	83 fb 64             	cmp    $0x64,%ebx
  800e86:	7f 0b                	jg     800e93 <vprintfmt+0x15a>
  800e88:	8b 34 9d 00 2a 80 00 	mov    0x802a00(,%ebx,4),%esi
  800e8f:	85 f6                	test   %esi,%esi
  800e91:	75 19                	jne    800eac <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800e93:	53                   	push   %ebx
  800e94:	68 a5 2b 80 00       	push   $0x802ba5
  800e99:	ff 75 0c             	pushl  0xc(%ebp)
  800e9c:	ff 75 08             	pushl  0x8(%ebp)
  800e9f:	e8 5e 02 00 00       	call   801102 <printfmt>
  800ea4:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ea7:	e9 49 02 00 00       	jmp    8010f5 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800eac:	56                   	push   %esi
  800ead:	68 ae 2b 80 00       	push   $0x802bae
  800eb2:	ff 75 0c             	pushl  0xc(%ebp)
  800eb5:	ff 75 08             	pushl  0x8(%ebp)
  800eb8:	e8 45 02 00 00       	call   801102 <printfmt>
  800ebd:	83 c4 10             	add    $0x10,%esp
			break;
  800ec0:	e9 30 02 00 00       	jmp    8010f5 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ec5:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec8:	83 c0 04             	add    $0x4,%eax
  800ecb:	89 45 14             	mov    %eax,0x14(%ebp)
  800ece:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed1:	83 e8 04             	sub    $0x4,%eax
  800ed4:	8b 30                	mov    (%eax),%esi
  800ed6:	85 f6                	test   %esi,%esi
  800ed8:	75 05                	jne    800edf <vprintfmt+0x1a6>
				p = "(null)";
  800eda:	be b1 2b 80 00       	mov    $0x802bb1,%esi
			if (width > 0 && padc != '-')
  800edf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ee3:	7e 6d                	jle    800f52 <vprintfmt+0x219>
  800ee5:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ee9:	74 67                	je     800f52 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800eeb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800eee:	83 ec 08             	sub    $0x8,%esp
  800ef1:	50                   	push   %eax
  800ef2:	56                   	push   %esi
  800ef3:	e8 12 05 00 00       	call   80140a <strnlen>
  800ef8:	83 c4 10             	add    $0x10,%esp
  800efb:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800efe:	eb 16                	jmp    800f16 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f00:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f04:	83 ec 08             	sub    $0x8,%esp
  800f07:	ff 75 0c             	pushl  0xc(%ebp)
  800f0a:	50                   	push   %eax
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0e:	ff d0                	call   *%eax
  800f10:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f13:	ff 4d e4             	decl   -0x1c(%ebp)
  800f16:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f1a:	7f e4                	jg     800f00 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f1c:	eb 34                	jmp    800f52 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f1e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f22:	74 1c                	je     800f40 <vprintfmt+0x207>
  800f24:	83 fb 1f             	cmp    $0x1f,%ebx
  800f27:	7e 05                	jle    800f2e <vprintfmt+0x1f5>
  800f29:	83 fb 7e             	cmp    $0x7e,%ebx
  800f2c:	7e 12                	jle    800f40 <vprintfmt+0x207>
					putch('?', putdat);
  800f2e:	83 ec 08             	sub    $0x8,%esp
  800f31:	ff 75 0c             	pushl  0xc(%ebp)
  800f34:	6a 3f                	push   $0x3f
  800f36:	8b 45 08             	mov    0x8(%ebp),%eax
  800f39:	ff d0                	call   *%eax
  800f3b:	83 c4 10             	add    $0x10,%esp
  800f3e:	eb 0f                	jmp    800f4f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f40:	83 ec 08             	sub    $0x8,%esp
  800f43:	ff 75 0c             	pushl  0xc(%ebp)
  800f46:	53                   	push   %ebx
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4a:	ff d0                	call   *%eax
  800f4c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f4f:	ff 4d e4             	decl   -0x1c(%ebp)
  800f52:	89 f0                	mov    %esi,%eax
  800f54:	8d 70 01             	lea    0x1(%eax),%esi
  800f57:	8a 00                	mov    (%eax),%al
  800f59:	0f be d8             	movsbl %al,%ebx
  800f5c:	85 db                	test   %ebx,%ebx
  800f5e:	74 24                	je     800f84 <vprintfmt+0x24b>
  800f60:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f64:	78 b8                	js     800f1e <vprintfmt+0x1e5>
  800f66:	ff 4d e0             	decl   -0x20(%ebp)
  800f69:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f6d:	79 af                	jns    800f1e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f6f:	eb 13                	jmp    800f84 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f71:	83 ec 08             	sub    $0x8,%esp
  800f74:	ff 75 0c             	pushl  0xc(%ebp)
  800f77:	6a 20                	push   $0x20
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	ff d0                	call   *%eax
  800f7e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f81:	ff 4d e4             	decl   -0x1c(%ebp)
  800f84:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f88:	7f e7                	jg     800f71 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800f8a:	e9 66 01 00 00       	jmp    8010f5 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f8f:	83 ec 08             	sub    $0x8,%esp
  800f92:	ff 75 e8             	pushl  -0x18(%ebp)
  800f95:	8d 45 14             	lea    0x14(%ebp),%eax
  800f98:	50                   	push   %eax
  800f99:	e8 3c fd ff ff       	call   800cda <getint>
  800f9e:	83 c4 10             	add    $0x10,%esp
  800fa1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fa4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fa7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800faa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fad:	85 d2                	test   %edx,%edx
  800faf:	79 23                	jns    800fd4 <vprintfmt+0x29b>
				putch('-', putdat);
  800fb1:	83 ec 08             	sub    $0x8,%esp
  800fb4:	ff 75 0c             	pushl  0xc(%ebp)
  800fb7:	6a 2d                	push   $0x2d
  800fb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbc:	ff d0                	call   *%eax
  800fbe:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fc4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc7:	f7 d8                	neg    %eax
  800fc9:	83 d2 00             	adc    $0x0,%edx
  800fcc:	f7 da                	neg    %edx
  800fce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fd1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800fd4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fdb:	e9 bc 00 00 00       	jmp    80109c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800fe0:	83 ec 08             	sub    $0x8,%esp
  800fe3:	ff 75 e8             	pushl  -0x18(%ebp)
  800fe6:	8d 45 14             	lea    0x14(%ebp),%eax
  800fe9:	50                   	push   %eax
  800fea:	e8 84 fc ff ff       	call   800c73 <getuint>
  800fef:	83 c4 10             	add    $0x10,%esp
  800ff2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ff5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ff8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fff:	e9 98 00 00 00       	jmp    80109c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801004:	83 ec 08             	sub    $0x8,%esp
  801007:	ff 75 0c             	pushl  0xc(%ebp)
  80100a:	6a 58                	push   $0x58
  80100c:	8b 45 08             	mov    0x8(%ebp),%eax
  80100f:	ff d0                	call   *%eax
  801011:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801014:	83 ec 08             	sub    $0x8,%esp
  801017:	ff 75 0c             	pushl  0xc(%ebp)
  80101a:	6a 58                	push   $0x58
  80101c:	8b 45 08             	mov    0x8(%ebp),%eax
  80101f:	ff d0                	call   *%eax
  801021:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801024:	83 ec 08             	sub    $0x8,%esp
  801027:	ff 75 0c             	pushl  0xc(%ebp)
  80102a:	6a 58                	push   $0x58
  80102c:	8b 45 08             	mov    0x8(%ebp),%eax
  80102f:	ff d0                	call   *%eax
  801031:	83 c4 10             	add    $0x10,%esp
			break;
  801034:	e9 bc 00 00 00       	jmp    8010f5 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801039:	83 ec 08             	sub    $0x8,%esp
  80103c:	ff 75 0c             	pushl  0xc(%ebp)
  80103f:	6a 30                	push   $0x30
  801041:	8b 45 08             	mov    0x8(%ebp),%eax
  801044:	ff d0                	call   *%eax
  801046:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801049:	83 ec 08             	sub    $0x8,%esp
  80104c:	ff 75 0c             	pushl  0xc(%ebp)
  80104f:	6a 78                	push   $0x78
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	ff d0                	call   *%eax
  801056:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801059:	8b 45 14             	mov    0x14(%ebp),%eax
  80105c:	83 c0 04             	add    $0x4,%eax
  80105f:	89 45 14             	mov    %eax,0x14(%ebp)
  801062:	8b 45 14             	mov    0x14(%ebp),%eax
  801065:	83 e8 04             	sub    $0x4,%eax
  801068:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80106a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80106d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801074:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80107b:	eb 1f                	jmp    80109c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80107d:	83 ec 08             	sub    $0x8,%esp
  801080:	ff 75 e8             	pushl  -0x18(%ebp)
  801083:	8d 45 14             	lea    0x14(%ebp),%eax
  801086:	50                   	push   %eax
  801087:	e8 e7 fb ff ff       	call   800c73 <getuint>
  80108c:	83 c4 10             	add    $0x10,%esp
  80108f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801092:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801095:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80109c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010a3:	83 ec 04             	sub    $0x4,%esp
  8010a6:	52                   	push   %edx
  8010a7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010aa:	50                   	push   %eax
  8010ab:	ff 75 f4             	pushl  -0xc(%ebp)
  8010ae:	ff 75 f0             	pushl  -0x10(%ebp)
  8010b1:	ff 75 0c             	pushl  0xc(%ebp)
  8010b4:	ff 75 08             	pushl  0x8(%ebp)
  8010b7:	e8 00 fb ff ff       	call   800bbc <printnum>
  8010bc:	83 c4 20             	add    $0x20,%esp
			break;
  8010bf:	eb 34                	jmp    8010f5 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010c1:	83 ec 08             	sub    $0x8,%esp
  8010c4:	ff 75 0c             	pushl  0xc(%ebp)
  8010c7:	53                   	push   %ebx
  8010c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cb:	ff d0                	call   *%eax
  8010cd:	83 c4 10             	add    $0x10,%esp
			break;
  8010d0:	eb 23                	jmp    8010f5 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010d2:	83 ec 08             	sub    $0x8,%esp
  8010d5:	ff 75 0c             	pushl  0xc(%ebp)
  8010d8:	6a 25                	push   $0x25
  8010da:	8b 45 08             	mov    0x8(%ebp),%eax
  8010dd:	ff d0                	call   *%eax
  8010df:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8010e2:	ff 4d 10             	decl   0x10(%ebp)
  8010e5:	eb 03                	jmp    8010ea <vprintfmt+0x3b1>
  8010e7:	ff 4d 10             	decl   0x10(%ebp)
  8010ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ed:	48                   	dec    %eax
  8010ee:	8a 00                	mov    (%eax),%al
  8010f0:	3c 25                	cmp    $0x25,%al
  8010f2:	75 f3                	jne    8010e7 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8010f4:	90                   	nop
		}
	}
  8010f5:	e9 47 fc ff ff       	jmp    800d41 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8010fa:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8010fb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010fe:	5b                   	pop    %ebx
  8010ff:	5e                   	pop    %esi
  801100:	5d                   	pop    %ebp
  801101:	c3                   	ret    

00801102 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801102:	55                   	push   %ebp
  801103:	89 e5                	mov    %esp,%ebp
  801105:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801108:	8d 45 10             	lea    0x10(%ebp),%eax
  80110b:	83 c0 04             	add    $0x4,%eax
  80110e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801111:	8b 45 10             	mov    0x10(%ebp),%eax
  801114:	ff 75 f4             	pushl  -0xc(%ebp)
  801117:	50                   	push   %eax
  801118:	ff 75 0c             	pushl  0xc(%ebp)
  80111b:	ff 75 08             	pushl  0x8(%ebp)
  80111e:	e8 16 fc ff ff       	call   800d39 <vprintfmt>
  801123:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801126:	90                   	nop
  801127:	c9                   	leave  
  801128:	c3                   	ret    

00801129 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801129:	55                   	push   %ebp
  80112a:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80112c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112f:	8b 40 08             	mov    0x8(%eax),%eax
  801132:	8d 50 01             	lea    0x1(%eax),%edx
  801135:	8b 45 0c             	mov    0xc(%ebp),%eax
  801138:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80113b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113e:	8b 10                	mov    (%eax),%edx
  801140:	8b 45 0c             	mov    0xc(%ebp),%eax
  801143:	8b 40 04             	mov    0x4(%eax),%eax
  801146:	39 c2                	cmp    %eax,%edx
  801148:	73 12                	jae    80115c <sprintputch+0x33>
		*b->buf++ = ch;
  80114a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114d:	8b 00                	mov    (%eax),%eax
  80114f:	8d 48 01             	lea    0x1(%eax),%ecx
  801152:	8b 55 0c             	mov    0xc(%ebp),%edx
  801155:	89 0a                	mov    %ecx,(%edx)
  801157:	8b 55 08             	mov    0x8(%ebp),%edx
  80115a:	88 10                	mov    %dl,(%eax)
}
  80115c:	90                   	nop
  80115d:	5d                   	pop    %ebp
  80115e:	c3                   	ret    

0080115f <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80115f:	55                   	push   %ebp
  801160:	89 e5                	mov    %esp,%ebp
  801162:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801165:	8b 45 08             	mov    0x8(%ebp),%eax
  801168:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80116b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	01 d0                	add    %edx,%eax
  801176:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801179:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801180:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801184:	74 06                	je     80118c <vsnprintf+0x2d>
  801186:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80118a:	7f 07                	jg     801193 <vsnprintf+0x34>
		return -E_INVAL;
  80118c:	b8 03 00 00 00       	mov    $0x3,%eax
  801191:	eb 20                	jmp    8011b3 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801193:	ff 75 14             	pushl  0x14(%ebp)
  801196:	ff 75 10             	pushl  0x10(%ebp)
  801199:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80119c:	50                   	push   %eax
  80119d:	68 29 11 80 00       	push   $0x801129
  8011a2:	e8 92 fb ff ff       	call   800d39 <vprintfmt>
  8011a7:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011ad:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011b3:	c9                   	leave  
  8011b4:	c3                   	ret    

008011b5 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011b5:	55                   	push   %ebp
  8011b6:	89 e5                	mov    %esp,%ebp
  8011b8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011bb:	8d 45 10             	lea    0x10(%ebp),%eax
  8011be:	83 c0 04             	add    $0x4,%eax
  8011c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8011ca:	50                   	push   %eax
  8011cb:	ff 75 0c             	pushl  0xc(%ebp)
  8011ce:	ff 75 08             	pushl  0x8(%ebp)
  8011d1:	e8 89 ff ff ff       	call   80115f <vsnprintf>
  8011d6:	83 c4 10             	add    $0x10,%esp
  8011d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011df:	c9                   	leave  
  8011e0:	c3                   	ret    

008011e1 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8011e1:	55                   	push   %ebp
  8011e2:	89 e5                	mov    %esp,%ebp
  8011e4:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8011e7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011eb:	74 13                	je     801200 <readline+0x1f>
		cprintf("%s", prompt);
  8011ed:	83 ec 08             	sub    $0x8,%esp
  8011f0:	ff 75 08             	pushl  0x8(%ebp)
  8011f3:	68 10 2d 80 00       	push   $0x802d10
  8011f8:	e8 62 f9 ff ff       	call   800b5f <cprintf>
  8011fd:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801200:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801207:	83 ec 0c             	sub    $0xc,%esp
  80120a:	6a 00                	push   $0x0
  80120c:	e8 8e f5 ff ff       	call   80079f <iscons>
  801211:	83 c4 10             	add    $0x10,%esp
  801214:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801217:	e8 35 f5 ff ff       	call   800751 <getchar>
  80121c:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80121f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801223:	79 22                	jns    801247 <readline+0x66>
			if (c != -E_EOF)
  801225:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801229:	0f 84 ad 00 00 00    	je     8012dc <readline+0xfb>
				cprintf("read error: %e\n", c);
  80122f:	83 ec 08             	sub    $0x8,%esp
  801232:	ff 75 ec             	pushl  -0x14(%ebp)
  801235:	68 13 2d 80 00       	push   $0x802d13
  80123a:	e8 20 f9 ff ff       	call   800b5f <cprintf>
  80123f:	83 c4 10             	add    $0x10,%esp
			return;
  801242:	e9 95 00 00 00       	jmp    8012dc <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801247:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80124b:	7e 34                	jle    801281 <readline+0xa0>
  80124d:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801254:	7f 2b                	jg     801281 <readline+0xa0>
			if (echoing)
  801256:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80125a:	74 0e                	je     80126a <readline+0x89>
				cputchar(c);
  80125c:	83 ec 0c             	sub    $0xc,%esp
  80125f:	ff 75 ec             	pushl  -0x14(%ebp)
  801262:	e8 a2 f4 ff ff       	call   800709 <cputchar>
  801267:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80126a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80126d:	8d 50 01             	lea    0x1(%eax),%edx
  801270:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801273:	89 c2                	mov    %eax,%edx
  801275:	8b 45 0c             	mov    0xc(%ebp),%eax
  801278:	01 d0                	add    %edx,%eax
  80127a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80127d:	88 10                	mov    %dl,(%eax)
  80127f:	eb 56                	jmp    8012d7 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801281:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801285:	75 1f                	jne    8012a6 <readline+0xc5>
  801287:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80128b:	7e 19                	jle    8012a6 <readline+0xc5>
			if (echoing)
  80128d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801291:	74 0e                	je     8012a1 <readline+0xc0>
				cputchar(c);
  801293:	83 ec 0c             	sub    $0xc,%esp
  801296:	ff 75 ec             	pushl  -0x14(%ebp)
  801299:	e8 6b f4 ff ff       	call   800709 <cputchar>
  80129e:	83 c4 10             	add    $0x10,%esp

			i--;
  8012a1:	ff 4d f4             	decl   -0xc(%ebp)
  8012a4:	eb 31                	jmp    8012d7 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012a6:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012aa:	74 0a                	je     8012b6 <readline+0xd5>
  8012ac:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012b0:	0f 85 61 ff ff ff    	jne    801217 <readline+0x36>
			if (echoing)
  8012b6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012ba:	74 0e                	je     8012ca <readline+0xe9>
				cputchar(c);
  8012bc:	83 ec 0c             	sub    $0xc,%esp
  8012bf:	ff 75 ec             	pushl  -0x14(%ebp)
  8012c2:	e8 42 f4 ff ff       	call   800709 <cputchar>
  8012c7:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8012ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d0:	01 d0                	add    %edx,%eax
  8012d2:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8012d5:	eb 06                	jmp    8012dd <readline+0xfc>
		}
	}
  8012d7:	e9 3b ff ff ff       	jmp    801217 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8012dc:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8012dd:	c9                   	leave  
  8012de:	c3                   	ret    

008012df <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8012df:	55                   	push   %ebp
  8012e0:	89 e5                	mov    %esp,%ebp
  8012e2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8012e5:	e8 d1 0c 00 00       	call   801fbb <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8012ea:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012ee:	74 13                	je     801303 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8012f0:	83 ec 08             	sub    $0x8,%esp
  8012f3:	ff 75 08             	pushl  0x8(%ebp)
  8012f6:	68 10 2d 80 00       	push   $0x802d10
  8012fb:	e8 5f f8 ff ff       	call   800b5f <cprintf>
  801300:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801303:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80130a:	83 ec 0c             	sub    $0xc,%esp
  80130d:	6a 00                	push   $0x0
  80130f:	e8 8b f4 ff ff       	call   80079f <iscons>
  801314:	83 c4 10             	add    $0x10,%esp
  801317:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80131a:	e8 32 f4 ff ff       	call   800751 <getchar>
  80131f:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801322:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801326:	79 23                	jns    80134b <atomic_readline+0x6c>
			if (c != -E_EOF)
  801328:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80132c:	74 13                	je     801341 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80132e:	83 ec 08             	sub    $0x8,%esp
  801331:	ff 75 ec             	pushl  -0x14(%ebp)
  801334:	68 13 2d 80 00       	push   $0x802d13
  801339:	e8 21 f8 ff ff       	call   800b5f <cprintf>
  80133e:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801341:	e8 8f 0c 00 00       	call   801fd5 <sys_enable_interrupt>
			return;
  801346:	e9 9a 00 00 00       	jmp    8013e5 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80134b:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80134f:	7e 34                	jle    801385 <atomic_readline+0xa6>
  801351:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801358:	7f 2b                	jg     801385 <atomic_readline+0xa6>
			if (echoing)
  80135a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80135e:	74 0e                	je     80136e <atomic_readline+0x8f>
				cputchar(c);
  801360:	83 ec 0c             	sub    $0xc,%esp
  801363:	ff 75 ec             	pushl  -0x14(%ebp)
  801366:	e8 9e f3 ff ff       	call   800709 <cputchar>
  80136b:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80136e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801371:	8d 50 01             	lea    0x1(%eax),%edx
  801374:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801377:	89 c2                	mov    %eax,%edx
  801379:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137c:	01 d0                	add    %edx,%eax
  80137e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801381:	88 10                	mov    %dl,(%eax)
  801383:	eb 5b                	jmp    8013e0 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801385:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801389:	75 1f                	jne    8013aa <atomic_readline+0xcb>
  80138b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80138f:	7e 19                	jle    8013aa <atomic_readline+0xcb>
			if (echoing)
  801391:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801395:	74 0e                	je     8013a5 <atomic_readline+0xc6>
				cputchar(c);
  801397:	83 ec 0c             	sub    $0xc,%esp
  80139a:	ff 75 ec             	pushl  -0x14(%ebp)
  80139d:	e8 67 f3 ff ff       	call   800709 <cputchar>
  8013a2:	83 c4 10             	add    $0x10,%esp
			i--;
  8013a5:	ff 4d f4             	decl   -0xc(%ebp)
  8013a8:	eb 36                	jmp    8013e0 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013aa:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013ae:	74 0a                	je     8013ba <atomic_readline+0xdb>
  8013b0:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013b4:	0f 85 60 ff ff ff    	jne    80131a <atomic_readline+0x3b>
			if (echoing)
  8013ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013be:	74 0e                	je     8013ce <atomic_readline+0xef>
				cputchar(c);
  8013c0:	83 ec 0c             	sub    $0xc,%esp
  8013c3:	ff 75 ec             	pushl  -0x14(%ebp)
  8013c6:	e8 3e f3 ff ff       	call   800709 <cputchar>
  8013cb:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8013ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d4:	01 d0                	add    %edx,%eax
  8013d6:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8013d9:	e8 f7 0b 00 00       	call   801fd5 <sys_enable_interrupt>
			return;
  8013de:	eb 05                	jmp    8013e5 <atomic_readline+0x106>
		}
	}
  8013e0:	e9 35 ff ff ff       	jmp    80131a <atomic_readline+0x3b>
}
  8013e5:	c9                   	leave  
  8013e6:	c3                   	ret    

008013e7 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8013e7:	55                   	push   %ebp
  8013e8:	89 e5                	mov    %esp,%ebp
  8013ea:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8013ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013f4:	eb 06                	jmp    8013fc <strlen+0x15>
		n++;
  8013f6:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8013f9:	ff 45 08             	incl   0x8(%ebp)
  8013fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ff:	8a 00                	mov    (%eax),%al
  801401:	84 c0                	test   %al,%al
  801403:	75 f1                	jne    8013f6 <strlen+0xf>
		n++;
	return n;
  801405:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801408:	c9                   	leave  
  801409:	c3                   	ret    

0080140a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80140a:	55                   	push   %ebp
  80140b:	89 e5                	mov    %esp,%ebp
  80140d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801410:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801417:	eb 09                	jmp    801422 <strnlen+0x18>
		n++;
  801419:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80141c:	ff 45 08             	incl   0x8(%ebp)
  80141f:	ff 4d 0c             	decl   0xc(%ebp)
  801422:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801426:	74 09                	je     801431 <strnlen+0x27>
  801428:	8b 45 08             	mov    0x8(%ebp),%eax
  80142b:	8a 00                	mov    (%eax),%al
  80142d:	84 c0                	test   %al,%al
  80142f:	75 e8                	jne    801419 <strnlen+0xf>
		n++;
	return n;
  801431:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801434:	c9                   	leave  
  801435:	c3                   	ret    

00801436 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801436:	55                   	push   %ebp
  801437:	89 e5                	mov    %esp,%ebp
  801439:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
  80143f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801442:	90                   	nop
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	8d 50 01             	lea    0x1(%eax),%edx
  801449:	89 55 08             	mov    %edx,0x8(%ebp)
  80144c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80144f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801452:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801455:	8a 12                	mov    (%edx),%dl
  801457:	88 10                	mov    %dl,(%eax)
  801459:	8a 00                	mov    (%eax),%al
  80145b:	84 c0                	test   %al,%al
  80145d:	75 e4                	jne    801443 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80145f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801462:	c9                   	leave  
  801463:	c3                   	ret    

00801464 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801464:	55                   	push   %ebp
  801465:	89 e5                	mov    %esp,%ebp
  801467:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80146a:	8b 45 08             	mov    0x8(%ebp),%eax
  80146d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801470:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801477:	eb 1f                	jmp    801498 <strncpy+0x34>
		*dst++ = *src;
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
  80147c:	8d 50 01             	lea    0x1(%eax),%edx
  80147f:	89 55 08             	mov    %edx,0x8(%ebp)
  801482:	8b 55 0c             	mov    0xc(%ebp),%edx
  801485:	8a 12                	mov    (%edx),%dl
  801487:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801489:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148c:	8a 00                	mov    (%eax),%al
  80148e:	84 c0                	test   %al,%al
  801490:	74 03                	je     801495 <strncpy+0x31>
			src++;
  801492:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801495:	ff 45 fc             	incl   -0x4(%ebp)
  801498:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80149b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80149e:	72 d9                	jb     801479 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014a3:	c9                   	leave  
  8014a4:	c3                   	ret    

008014a5 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014a5:	55                   	push   %ebp
  8014a6:	89 e5                	mov    %esp,%ebp
  8014a8:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014b5:	74 30                	je     8014e7 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014b7:	eb 16                	jmp    8014cf <strlcpy+0x2a>
			*dst++ = *src++;
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	8d 50 01             	lea    0x1(%eax),%edx
  8014bf:	89 55 08             	mov    %edx,0x8(%ebp)
  8014c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014c5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014c8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014cb:	8a 12                	mov    (%edx),%dl
  8014cd:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8014cf:	ff 4d 10             	decl   0x10(%ebp)
  8014d2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014d6:	74 09                	je     8014e1 <strlcpy+0x3c>
  8014d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014db:	8a 00                	mov    (%eax),%al
  8014dd:	84 c0                	test   %al,%al
  8014df:	75 d8                	jne    8014b9 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8014e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e4:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8014e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8014ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ed:	29 c2                	sub    %eax,%edx
  8014ef:	89 d0                	mov    %edx,%eax
}
  8014f1:	c9                   	leave  
  8014f2:	c3                   	ret    

008014f3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8014f3:	55                   	push   %ebp
  8014f4:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8014f6:	eb 06                	jmp    8014fe <strcmp+0xb>
		p++, q++;
  8014f8:	ff 45 08             	incl   0x8(%ebp)
  8014fb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8014fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801501:	8a 00                	mov    (%eax),%al
  801503:	84 c0                	test   %al,%al
  801505:	74 0e                	je     801515 <strcmp+0x22>
  801507:	8b 45 08             	mov    0x8(%ebp),%eax
  80150a:	8a 10                	mov    (%eax),%dl
  80150c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150f:	8a 00                	mov    (%eax),%al
  801511:	38 c2                	cmp    %al,%dl
  801513:	74 e3                	je     8014f8 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801515:	8b 45 08             	mov    0x8(%ebp),%eax
  801518:	8a 00                	mov    (%eax),%al
  80151a:	0f b6 d0             	movzbl %al,%edx
  80151d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801520:	8a 00                	mov    (%eax),%al
  801522:	0f b6 c0             	movzbl %al,%eax
  801525:	29 c2                	sub    %eax,%edx
  801527:	89 d0                	mov    %edx,%eax
}
  801529:	5d                   	pop    %ebp
  80152a:	c3                   	ret    

0080152b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80152b:	55                   	push   %ebp
  80152c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80152e:	eb 09                	jmp    801539 <strncmp+0xe>
		n--, p++, q++;
  801530:	ff 4d 10             	decl   0x10(%ebp)
  801533:	ff 45 08             	incl   0x8(%ebp)
  801536:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801539:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80153d:	74 17                	je     801556 <strncmp+0x2b>
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	8a 00                	mov    (%eax),%al
  801544:	84 c0                	test   %al,%al
  801546:	74 0e                	je     801556 <strncmp+0x2b>
  801548:	8b 45 08             	mov    0x8(%ebp),%eax
  80154b:	8a 10                	mov    (%eax),%dl
  80154d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801550:	8a 00                	mov    (%eax),%al
  801552:	38 c2                	cmp    %al,%dl
  801554:	74 da                	je     801530 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801556:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80155a:	75 07                	jne    801563 <strncmp+0x38>
		return 0;
  80155c:	b8 00 00 00 00       	mov    $0x0,%eax
  801561:	eb 14                	jmp    801577 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801563:	8b 45 08             	mov    0x8(%ebp),%eax
  801566:	8a 00                	mov    (%eax),%al
  801568:	0f b6 d0             	movzbl %al,%edx
  80156b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156e:	8a 00                	mov    (%eax),%al
  801570:	0f b6 c0             	movzbl %al,%eax
  801573:	29 c2                	sub    %eax,%edx
  801575:	89 d0                	mov    %edx,%eax
}
  801577:	5d                   	pop    %ebp
  801578:	c3                   	ret    

00801579 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801579:	55                   	push   %ebp
  80157a:	89 e5                	mov    %esp,%ebp
  80157c:	83 ec 04             	sub    $0x4,%esp
  80157f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801582:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801585:	eb 12                	jmp    801599 <strchr+0x20>
		if (*s == c)
  801587:	8b 45 08             	mov    0x8(%ebp),%eax
  80158a:	8a 00                	mov    (%eax),%al
  80158c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80158f:	75 05                	jne    801596 <strchr+0x1d>
			return (char *) s;
  801591:	8b 45 08             	mov    0x8(%ebp),%eax
  801594:	eb 11                	jmp    8015a7 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801596:	ff 45 08             	incl   0x8(%ebp)
  801599:	8b 45 08             	mov    0x8(%ebp),%eax
  80159c:	8a 00                	mov    (%eax),%al
  80159e:	84 c0                	test   %al,%al
  8015a0:	75 e5                	jne    801587 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
  8015ac:	83 ec 04             	sub    $0x4,%esp
  8015af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015b5:	eb 0d                	jmp    8015c4 <strfind+0x1b>
		if (*s == c)
  8015b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ba:	8a 00                	mov    (%eax),%al
  8015bc:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015bf:	74 0e                	je     8015cf <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015c1:	ff 45 08             	incl   0x8(%ebp)
  8015c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c7:	8a 00                	mov    (%eax),%al
  8015c9:	84 c0                	test   %al,%al
  8015cb:	75 ea                	jne    8015b7 <strfind+0xe>
  8015cd:	eb 01                	jmp    8015d0 <strfind+0x27>
		if (*s == c)
			break;
  8015cf:	90                   	nop
	return (char *) s;
  8015d0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015d3:	c9                   	leave  
  8015d4:	c3                   	ret    

008015d5 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8015d5:	55                   	push   %ebp
  8015d6:	89 e5                	mov    %esp,%ebp
  8015d8:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8015e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8015e7:	eb 0e                	jmp    8015f7 <memset+0x22>
		*p++ = c;
  8015e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ec:	8d 50 01             	lea    0x1(%eax),%edx
  8015ef:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f5:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8015f7:	ff 4d f8             	decl   -0x8(%ebp)
  8015fa:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8015fe:	79 e9                	jns    8015e9 <memset+0x14>
		*p++ = c;

	return v;
  801600:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801603:	c9                   	leave  
  801604:	c3                   	ret    

00801605 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801605:	55                   	push   %ebp
  801606:	89 e5                	mov    %esp,%ebp
  801608:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80160b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80160e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801611:	8b 45 08             	mov    0x8(%ebp),%eax
  801614:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801617:	eb 16                	jmp    80162f <memcpy+0x2a>
		*d++ = *s++;
  801619:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80161c:	8d 50 01             	lea    0x1(%eax),%edx
  80161f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801622:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801625:	8d 4a 01             	lea    0x1(%edx),%ecx
  801628:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80162b:	8a 12                	mov    (%edx),%dl
  80162d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80162f:	8b 45 10             	mov    0x10(%ebp),%eax
  801632:	8d 50 ff             	lea    -0x1(%eax),%edx
  801635:	89 55 10             	mov    %edx,0x10(%ebp)
  801638:	85 c0                	test   %eax,%eax
  80163a:	75 dd                	jne    801619 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80163c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80163f:	c9                   	leave  
  801640:	c3                   	ret    

00801641 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801641:	55                   	push   %ebp
  801642:	89 e5                	mov    %esp,%ebp
  801644:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801647:	8b 45 0c             	mov    0xc(%ebp),%eax
  80164a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80164d:	8b 45 08             	mov    0x8(%ebp),%eax
  801650:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801653:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801656:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801659:	73 50                	jae    8016ab <memmove+0x6a>
  80165b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80165e:	8b 45 10             	mov    0x10(%ebp),%eax
  801661:	01 d0                	add    %edx,%eax
  801663:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801666:	76 43                	jbe    8016ab <memmove+0x6a>
		s += n;
  801668:	8b 45 10             	mov    0x10(%ebp),%eax
  80166b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80166e:	8b 45 10             	mov    0x10(%ebp),%eax
  801671:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801674:	eb 10                	jmp    801686 <memmove+0x45>
			*--d = *--s;
  801676:	ff 4d f8             	decl   -0x8(%ebp)
  801679:	ff 4d fc             	decl   -0x4(%ebp)
  80167c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80167f:	8a 10                	mov    (%eax),%dl
  801681:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801684:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801686:	8b 45 10             	mov    0x10(%ebp),%eax
  801689:	8d 50 ff             	lea    -0x1(%eax),%edx
  80168c:	89 55 10             	mov    %edx,0x10(%ebp)
  80168f:	85 c0                	test   %eax,%eax
  801691:	75 e3                	jne    801676 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801693:	eb 23                	jmp    8016b8 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801695:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801698:	8d 50 01             	lea    0x1(%eax),%edx
  80169b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80169e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016a1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016a4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016a7:	8a 12                	mov    (%edx),%dl
  8016a9:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ae:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016b1:	89 55 10             	mov    %edx,0x10(%ebp)
  8016b4:	85 c0                	test   %eax,%eax
  8016b6:	75 dd                	jne    801695 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016b8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016bb:	c9                   	leave  
  8016bc:	c3                   	ret    

008016bd <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016bd:	55                   	push   %ebp
  8016be:	89 e5                	mov    %esp,%ebp
  8016c0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016cc:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016cf:	eb 2a                	jmp    8016fb <memcmp+0x3e>
		if (*s1 != *s2)
  8016d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016d4:	8a 10                	mov    (%eax),%dl
  8016d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d9:	8a 00                	mov    (%eax),%al
  8016db:	38 c2                	cmp    %al,%dl
  8016dd:	74 16                	je     8016f5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8016df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016e2:	8a 00                	mov    (%eax),%al
  8016e4:	0f b6 d0             	movzbl %al,%edx
  8016e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ea:	8a 00                	mov    (%eax),%al
  8016ec:	0f b6 c0             	movzbl %al,%eax
  8016ef:	29 c2                	sub    %eax,%edx
  8016f1:	89 d0                	mov    %edx,%eax
  8016f3:	eb 18                	jmp    80170d <memcmp+0x50>
		s1++, s2++;
  8016f5:	ff 45 fc             	incl   -0x4(%ebp)
  8016f8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8016fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8016fe:	8d 50 ff             	lea    -0x1(%eax),%edx
  801701:	89 55 10             	mov    %edx,0x10(%ebp)
  801704:	85 c0                	test   %eax,%eax
  801706:	75 c9                	jne    8016d1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801708:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80170d:	c9                   	leave  
  80170e:	c3                   	ret    

0080170f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80170f:	55                   	push   %ebp
  801710:	89 e5                	mov    %esp,%ebp
  801712:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801715:	8b 55 08             	mov    0x8(%ebp),%edx
  801718:	8b 45 10             	mov    0x10(%ebp),%eax
  80171b:	01 d0                	add    %edx,%eax
  80171d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801720:	eb 15                	jmp    801737 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801722:	8b 45 08             	mov    0x8(%ebp),%eax
  801725:	8a 00                	mov    (%eax),%al
  801727:	0f b6 d0             	movzbl %al,%edx
  80172a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172d:	0f b6 c0             	movzbl %al,%eax
  801730:	39 c2                	cmp    %eax,%edx
  801732:	74 0d                	je     801741 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801734:	ff 45 08             	incl   0x8(%ebp)
  801737:	8b 45 08             	mov    0x8(%ebp),%eax
  80173a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80173d:	72 e3                	jb     801722 <memfind+0x13>
  80173f:	eb 01                	jmp    801742 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801741:	90                   	nop
	return (void *) s;
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801745:	c9                   	leave  
  801746:	c3                   	ret    

00801747 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801747:	55                   	push   %ebp
  801748:	89 e5                	mov    %esp,%ebp
  80174a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80174d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801754:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80175b:	eb 03                	jmp    801760 <strtol+0x19>
		s++;
  80175d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801760:	8b 45 08             	mov    0x8(%ebp),%eax
  801763:	8a 00                	mov    (%eax),%al
  801765:	3c 20                	cmp    $0x20,%al
  801767:	74 f4                	je     80175d <strtol+0x16>
  801769:	8b 45 08             	mov    0x8(%ebp),%eax
  80176c:	8a 00                	mov    (%eax),%al
  80176e:	3c 09                	cmp    $0x9,%al
  801770:	74 eb                	je     80175d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801772:	8b 45 08             	mov    0x8(%ebp),%eax
  801775:	8a 00                	mov    (%eax),%al
  801777:	3c 2b                	cmp    $0x2b,%al
  801779:	75 05                	jne    801780 <strtol+0x39>
		s++;
  80177b:	ff 45 08             	incl   0x8(%ebp)
  80177e:	eb 13                	jmp    801793 <strtol+0x4c>
	else if (*s == '-')
  801780:	8b 45 08             	mov    0x8(%ebp),%eax
  801783:	8a 00                	mov    (%eax),%al
  801785:	3c 2d                	cmp    $0x2d,%al
  801787:	75 0a                	jne    801793 <strtol+0x4c>
		s++, neg = 1;
  801789:	ff 45 08             	incl   0x8(%ebp)
  80178c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801793:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801797:	74 06                	je     80179f <strtol+0x58>
  801799:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80179d:	75 20                	jne    8017bf <strtol+0x78>
  80179f:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a2:	8a 00                	mov    (%eax),%al
  8017a4:	3c 30                	cmp    $0x30,%al
  8017a6:	75 17                	jne    8017bf <strtol+0x78>
  8017a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ab:	40                   	inc    %eax
  8017ac:	8a 00                	mov    (%eax),%al
  8017ae:	3c 78                	cmp    $0x78,%al
  8017b0:	75 0d                	jne    8017bf <strtol+0x78>
		s += 2, base = 16;
  8017b2:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017b6:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017bd:	eb 28                	jmp    8017e7 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017c3:	75 15                	jne    8017da <strtol+0x93>
  8017c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c8:	8a 00                	mov    (%eax),%al
  8017ca:	3c 30                	cmp    $0x30,%al
  8017cc:	75 0c                	jne    8017da <strtol+0x93>
		s++, base = 8;
  8017ce:	ff 45 08             	incl   0x8(%ebp)
  8017d1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8017d8:	eb 0d                	jmp    8017e7 <strtol+0xa0>
	else if (base == 0)
  8017da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017de:	75 07                	jne    8017e7 <strtol+0xa0>
		base = 10;
  8017e0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8017e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ea:	8a 00                	mov    (%eax),%al
  8017ec:	3c 2f                	cmp    $0x2f,%al
  8017ee:	7e 19                	jle    801809 <strtol+0xc2>
  8017f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f3:	8a 00                	mov    (%eax),%al
  8017f5:	3c 39                	cmp    $0x39,%al
  8017f7:	7f 10                	jg     801809 <strtol+0xc2>
			dig = *s - '0';
  8017f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fc:	8a 00                	mov    (%eax),%al
  8017fe:	0f be c0             	movsbl %al,%eax
  801801:	83 e8 30             	sub    $0x30,%eax
  801804:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801807:	eb 42                	jmp    80184b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801809:	8b 45 08             	mov    0x8(%ebp),%eax
  80180c:	8a 00                	mov    (%eax),%al
  80180e:	3c 60                	cmp    $0x60,%al
  801810:	7e 19                	jle    80182b <strtol+0xe4>
  801812:	8b 45 08             	mov    0x8(%ebp),%eax
  801815:	8a 00                	mov    (%eax),%al
  801817:	3c 7a                	cmp    $0x7a,%al
  801819:	7f 10                	jg     80182b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80181b:	8b 45 08             	mov    0x8(%ebp),%eax
  80181e:	8a 00                	mov    (%eax),%al
  801820:	0f be c0             	movsbl %al,%eax
  801823:	83 e8 57             	sub    $0x57,%eax
  801826:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801829:	eb 20                	jmp    80184b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80182b:	8b 45 08             	mov    0x8(%ebp),%eax
  80182e:	8a 00                	mov    (%eax),%al
  801830:	3c 40                	cmp    $0x40,%al
  801832:	7e 39                	jle    80186d <strtol+0x126>
  801834:	8b 45 08             	mov    0x8(%ebp),%eax
  801837:	8a 00                	mov    (%eax),%al
  801839:	3c 5a                	cmp    $0x5a,%al
  80183b:	7f 30                	jg     80186d <strtol+0x126>
			dig = *s - 'A' + 10;
  80183d:	8b 45 08             	mov    0x8(%ebp),%eax
  801840:	8a 00                	mov    (%eax),%al
  801842:	0f be c0             	movsbl %al,%eax
  801845:	83 e8 37             	sub    $0x37,%eax
  801848:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80184b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80184e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801851:	7d 19                	jge    80186c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801853:	ff 45 08             	incl   0x8(%ebp)
  801856:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801859:	0f af 45 10          	imul   0x10(%ebp),%eax
  80185d:	89 c2                	mov    %eax,%edx
  80185f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801862:	01 d0                	add    %edx,%eax
  801864:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801867:	e9 7b ff ff ff       	jmp    8017e7 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80186c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80186d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801871:	74 08                	je     80187b <strtol+0x134>
		*endptr = (char *) s;
  801873:	8b 45 0c             	mov    0xc(%ebp),%eax
  801876:	8b 55 08             	mov    0x8(%ebp),%edx
  801879:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80187b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80187f:	74 07                	je     801888 <strtol+0x141>
  801881:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801884:	f7 d8                	neg    %eax
  801886:	eb 03                	jmp    80188b <strtol+0x144>
  801888:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <ltostr>:

void
ltostr(long value, char *str)
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
  801890:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801893:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80189a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018a1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018a5:	79 13                	jns    8018ba <ltostr+0x2d>
	{
		neg = 1;
  8018a7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b1:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018b4:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018b7:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bd:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018c2:	99                   	cltd   
  8018c3:	f7 f9                	idiv   %ecx
  8018c5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018cb:	8d 50 01             	lea    0x1(%eax),%edx
  8018ce:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018d1:	89 c2                	mov    %eax,%edx
  8018d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d6:	01 d0                	add    %edx,%eax
  8018d8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018db:	83 c2 30             	add    $0x30,%edx
  8018de:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8018e0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018e3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8018e8:	f7 e9                	imul   %ecx
  8018ea:	c1 fa 02             	sar    $0x2,%edx
  8018ed:	89 c8                	mov    %ecx,%eax
  8018ef:	c1 f8 1f             	sar    $0x1f,%eax
  8018f2:	29 c2                	sub    %eax,%edx
  8018f4:	89 d0                	mov    %edx,%eax
  8018f6:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8018f9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018fc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801901:	f7 e9                	imul   %ecx
  801903:	c1 fa 02             	sar    $0x2,%edx
  801906:	89 c8                	mov    %ecx,%eax
  801908:	c1 f8 1f             	sar    $0x1f,%eax
  80190b:	29 c2                	sub    %eax,%edx
  80190d:	89 d0                	mov    %edx,%eax
  80190f:	c1 e0 02             	shl    $0x2,%eax
  801912:	01 d0                	add    %edx,%eax
  801914:	01 c0                	add    %eax,%eax
  801916:	29 c1                	sub    %eax,%ecx
  801918:	89 ca                	mov    %ecx,%edx
  80191a:	85 d2                	test   %edx,%edx
  80191c:	75 9c                	jne    8018ba <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80191e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801925:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801928:	48                   	dec    %eax
  801929:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80192c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801930:	74 3d                	je     80196f <ltostr+0xe2>
		start = 1 ;
  801932:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801939:	eb 34                	jmp    80196f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80193b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80193e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801941:	01 d0                	add    %edx,%eax
  801943:	8a 00                	mov    (%eax),%al
  801945:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801948:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80194b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194e:	01 c2                	add    %eax,%edx
  801950:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801953:	8b 45 0c             	mov    0xc(%ebp),%eax
  801956:	01 c8                	add    %ecx,%eax
  801958:	8a 00                	mov    (%eax),%al
  80195a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80195c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80195f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801962:	01 c2                	add    %eax,%edx
  801964:	8a 45 eb             	mov    -0x15(%ebp),%al
  801967:	88 02                	mov    %al,(%edx)
		start++ ;
  801969:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80196c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80196f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801972:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801975:	7c c4                	jl     80193b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801977:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80197a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80197d:	01 d0                	add    %edx,%eax
  80197f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801982:	90                   	nop
  801983:	c9                   	leave  
  801984:	c3                   	ret    

00801985 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801985:	55                   	push   %ebp
  801986:	89 e5                	mov    %esp,%ebp
  801988:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80198b:	ff 75 08             	pushl  0x8(%ebp)
  80198e:	e8 54 fa ff ff       	call   8013e7 <strlen>
  801993:	83 c4 04             	add    $0x4,%esp
  801996:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801999:	ff 75 0c             	pushl  0xc(%ebp)
  80199c:	e8 46 fa ff ff       	call   8013e7 <strlen>
  8019a1:	83 c4 04             	add    $0x4,%esp
  8019a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019b5:	eb 17                	jmp    8019ce <strcconcat+0x49>
		final[s] = str1[s] ;
  8019b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8019bd:	01 c2                	add    %eax,%edx
  8019bf:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c5:	01 c8                	add    %ecx,%eax
  8019c7:	8a 00                	mov    (%eax),%al
  8019c9:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019cb:	ff 45 fc             	incl   -0x4(%ebp)
  8019ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019d1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019d4:	7c e1                	jl     8019b7 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019d6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8019dd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8019e4:	eb 1f                	jmp    801a05 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8019e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019e9:	8d 50 01             	lea    0x1(%eax),%edx
  8019ec:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8019ef:	89 c2                	mov    %eax,%edx
  8019f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f4:	01 c2                	add    %eax,%edx
  8019f6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8019f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019fc:	01 c8                	add    %ecx,%eax
  8019fe:	8a 00                	mov    (%eax),%al
  801a00:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a02:	ff 45 f8             	incl   -0x8(%ebp)
  801a05:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a08:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a0b:	7c d9                	jl     8019e6 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a0d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a10:	8b 45 10             	mov    0x10(%ebp),%eax
  801a13:	01 d0                	add    %edx,%eax
  801a15:	c6 00 00             	movb   $0x0,(%eax)
}
  801a18:	90                   	nop
  801a19:	c9                   	leave  
  801a1a:	c3                   	ret    

00801a1b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a1b:	55                   	push   %ebp
  801a1c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a1e:	8b 45 14             	mov    0x14(%ebp),%eax
  801a21:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a27:	8b 45 14             	mov    0x14(%ebp),%eax
  801a2a:	8b 00                	mov    (%eax),%eax
  801a2c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a33:	8b 45 10             	mov    0x10(%ebp),%eax
  801a36:	01 d0                	add    %edx,%eax
  801a38:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a3e:	eb 0c                	jmp    801a4c <strsplit+0x31>
			*string++ = 0;
  801a40:	8b 45 08             	mov    0x8(%ebp),%eax
  801a43:	8d 50 01             	lea    0x1(%eax),%edx
  801a46:	89 55 08             	mov    %edx,0x8(%ebp)
  801a49:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4f:	8a 00                	mov    (%eax),%al
  801a51:	84 c0                	test   %al,%al
  801a53:	74 18                	je     801a6d <strsplit+0x52>
  801a55:	8b 45 08             	mov    0x8(%ebp),%eax
  801a58:	8a 00                	mov    (%eax),%al
  801a5a:	0f be c0             	movsbl %al,%eax
  801a5d:	50                   	push   %eax
  801a5e:	ff 75 0c             	pushl  0xc(%ebp)
  801a61:	e8 13 fb ff ff       	call   801579 <strchr>
  801a66:	83 c4 08             	add    $0x8,%esp
  801a69:	85 c0                	test   %eax,%eax
  801a6b:	75 d3                	jne    801a40 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a70:	8a 00                	mov    (%eax),%al
  801a72:	84 c0                	test   %al,%al
  801a74:	74 5a                	je     801ad0 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801a76:	8b 45 14             	mov    0x14(%ebp),%eax
  801a79:	8b 00                	mov    (%eax),%eax
  801a7b:	83 f8 0f             	cmp    $0xf,%eax
  801a7e:	75 07                	jne    801a87 <strsplit+0x6c>
		{
			return 0;
  801a80:	b8 00 00 00 00       	mov    $0x0,%eax
  801a85:	eb 66                	jmp    801aed <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801a87:	8b 45 14             	mov    0x14(%ebp),%eax
  801a8a:	8b 00                	mov    (%eax),%eax
  801a8c:	8d 48 01             	lea    0x1(%eax),%ecx
  801a8f:	8b 55 14             	mov    0x14(%ebp),%edx
  801a92:	89 0a                	mov    %ecx,(%edx)
  801a94:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a9b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a9e:	01 c2                	add    %eax,%edx
  801aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa3:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801aa5:	eb 03                	jmp    801aaa <strsplit+0x8f>
			string++;
  801aa7:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  801aad:	8a 00                	mov    (%eax),%al
  801aaf:	84 c0                	test   %al,%al
  801ab1:	74 8b                	je     801a3e <strsplit+0x23>
  801ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab6:	8a 00                	mov    (%eax),%al
  801ab8:	0f be c0             	movsbl %al,%eax
  801abb:	50                   	push   %eax
  801abc:	ff 75 0c             	pushl  0xc(%ebp)
  801abf:	e8 b5 fa ff ff       	call   801579 <strchr>
  801ac4:	83 c4 08             	add    $0x8,%esp
  801ac7:	85 c0                	test   %eax,%eax
  801ac9:	74 dc                	je     801aa7 <strsplit+0x8c>
			string++;
	}
  801acb:	e9 6e ff ff ff       	jmp    801a3e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801ad0:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801ad1:	8b 45 14             	mov    0x14(%ebp),%eax
  801ad4:	8b 00                	mov    (%eax),%eax
  801ad6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801add:	8b 45 10             	mov    0x10(%ebp),%eax
  801ae0:	01 d0                	add    %edx,%eax
  801ae2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801ae8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801aed:	c9                   	leave  
  801aee:	c3                   	ret    

00801aef <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801aef:	55                   	push   %ebp
  801af0:	89 e5                	mov    %esp,%ebp
  801af2:	83 ec 18             	sub    $0x18,%esp
  801af5:	8b 45 10             	mov    0x10(%ebp),%eax
  801af8:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801afb:	83 ec 04             	sub    $0x4,%esp
  801afe:	68 24 2d 80 00       	push   $0x802d24
  801b03:	6a 17                	push   $0x17
  801b05:	68 43 2d 80 00       	push   $0x802d43
  801b0a:	e8 9c ed ff ff       	call   8008ab <_panic>

00801b0f <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b0f:	55                   	push   %ebp
  801b10:	89 e5                	mov    %esp,%ebp
  801b12:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801b15:	83 ec 04             	sub    $0x4,%esp
  801b18:	68 4f 2d 80 00       	push   $0x802d4f
  801b1d:	6a 2f                	push   $0x2f
  801b1f:	68 43 2d 80 00       	push   $0x802d43
  801b24:	e8 82 ed ff ff       	call   8008ab <_panic>

00801b29 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801b29:	55                   	push   %ebp
  801b2a:	89 e5                	mov    %esp,%ebp
  801b2c:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801b2f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801b36:	8b 55 08             	mov    0x8(%ebp),%edx
  801b39:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b3c:	01 d0                	add    %edx,%eax
  801b3e:	48                   	dec    %eax
  801b3f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801b42:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b45:	ba 00 00 00 00       	mov    $0x0,%edx
  801b4a:	f7 75 ec             	divl   -0x14(%ebp)
  801b4d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b50:	29 d0                	sub    %edx,%eax
  801b52:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801b55:	8b 45 08             	mov    0x8(%ebp),%eax
  801b58:	c1 e8 0c             	shr    $0xc,%eax
  801b5b:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801b5e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b65:	e9 c8 00 00 00       	jmp    801c32 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801b6a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801b71:	eb 27                	jmp    801b9a <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801b73:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b76:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b79:	01 c2                	add    %eax,%edx
  801b7b:	89 d0                	mov    %edx,%eax
  801b7d:	01 c0                	add    %eax,%eax
  801b7f:	01 d0                	add    %edx,%eax
  801b81:	c1 e0 02             	shl    $0x2,%eax
  801b84:	05 48 30 80 00       	add    $0x803048,%eax
  801b89:	8b 00                	mov    (%eax),%eax
  801b8b:	85 c0                	test   %eax,%eax
  801b8d:	74 08                	je     801b97 <malloc+0x6e>
            	i += j;
  801b8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b92:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801b95:	eb 0b                	jmp    801ba2 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801b97:	ff 45 f0             	incl   -0x10(%ebp)
  801b9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b9d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801ba0:	72 d1                	jb     801b73 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801ba2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ba5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801ba8:	0f 85 81 00 00 00    	jne    801c2f <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801bae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bb1:	05 00 00 08 00       	add    $0x80000,%eax
  801bb6:	c1 e0 0c             	shl    $0xc,%eax
  801bb9:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801bbc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801bc3:	eb 1f                	jmp    801be4 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801bc5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bcb:	01 c2                	add    %eax,%edx
  801bcd:	89 d0                	mov    %edx,%eax
  801bcf:	01 c0                	add    %eax,%eax
  801bd1:	01 d0                	add    %edx,%eax
  801bd3:	c1 e0 02             	shl    $0x2,%eax
  801bd6:	05 48 30 80 00       	add    $0x803048,%eax
  801bdb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801be1:	ff 45 f0             	incl   -0x10(%ebp)
  801be4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801be7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801bea:	72 d9                	jb     801bc5 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801bec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801bef:	89 d0                	mov    %edx,%eax
  801bf1:	01 c0                	add    %eax,%eax
  801bf3:	01 d0                	add    %edx,%eax
  801bf5:	c1 e0 02             	shl    $0x2,%eax
  801bf8:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801bfe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c01:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801c03:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801c06:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801c09:	89 c8                	mov    %ecx,%eax
  801c0b:	01 c0                	add    %eax,%eax
  801c0d:	01 c8                	add    %ecx,%eax
  801c0f:	c1 e0 02             	shl    $0x2,%eax
  801c12:	05 44 30 80 00       	add    $0x803044,%eax
  801c17:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801c19:	83 ec 08             	sub    $0x8,%esp
  801c1c:	ff 75 08             	pushl  0x8(%ebp)
  801c1f:	ff 75 e0             	pushl  -0x20(%ebp)
  801c22:	e8 2b 03 00 00       	call   801f52 <sys_allocateMem>
  801c27:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801c2a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c2d:	eb 19                	jmp    801c48 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801c2f:	ff 45 f4             	incl   -0xc(%ebp)
  801c32:	a1 04 30 80 00       	mov    0x803004,%eax
  801c37:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801c3a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801c3d:	0f 83 27 ff ff ff    	jae    801b6a <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801c43:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c48:	c9                   	leave  
  801c49:	c3                   	ret    

00801c4a <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801c4a:	55                   	push   %ebp
  801c4b:	89 e5                	mov    %esp,%ebp
  801c4d:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801c50:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801c54:	0f 84 e5 00 00 00    	je     801d3f <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801c60:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c63:	05 00 00 00 80       	add    $0x80000000,%eax
  801c68:	c1 e8 0c             	shr    $0xc,%eax
  801c6b:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801c6e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c71:	89 d0                	mov    %edx,%eax
  801c73:	01 c0                	add    %eax,%eax
  801c75:	01 d0                	add    %edx,%eax
  801c77:	c1 e0 02             	shl    $0x2,%eax
  801c7a:	05 40 30 80 00       	add    $0x803040,%eax
  801c7f:	8b 00                	mov    (%eax),%eax
  801c81:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c84:	0f 85 b8 00 00 00    	jne    801d42 <free+0xf8>
  801c8a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c8d:	89 d0                	mov    %edx,%eax
  801c8f:	01 c0                	add    %eax,%eax
  801c91:	01 d0                	add    %edx,%eax
  801c93:	c1 e0 02             	shl    $0x2,%eax
  801c96:	05 48 30 80 00       	add    $0x803048,%eax
  801c9b:	8b 00                	mov    (%eax),%eax
  801c9d:	85 c0                	test   %eax,%eax
  801c9f:	0f 84 9d 00 00 00    	je     801d42 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801ca5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ca8:	89 d0                	mov    %edx,%eax
  801caa:	01 c0                	add    %eax,%eax
  801cac:	01 d0                	add    %edx,%eax
  801cae:	c1 e0 02             	shl    $0x2,%eax
  801cb1:	05 44 30 80 00       	add    $0x803044,%eax
  801cb6:	8b 00                	mov    (%eax),%eax
  801cb8:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801cbb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801cbe:	c1 e0 0c             	shl    $0xc,%eax
  801cc1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801cc4:	83 ec 08             	sub    $0x8,%esp
  801cc7:	ff 75 e4             	pushl  -0x1c(%ebp)
  801cca:	ff 75 f0             	pushl  -0x10(%ebp)
  801ccd:	e8 64 02 00 00       	call   801f36 <sys_freeMem>
  801cd2:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801cd5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801cdc:	eb 57                	jmp    801d35 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801cde:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ce1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ce4:	01 c2                	add    %eax,%edx
  801ce6:	89 d0                	mov    %edx,%eax
  801ce8:	01 c0                	add    %eax,%eax
  801cea:	01 d0                	add    %edx,%eax
  801cec:	c1 e0 02             	shl    $0x2,%eax
  801cef:	05 48 30 80 00       	add    $0x803048,%eax
  801cf4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801cfa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801cfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d00:	01 c2                	add    %eax,%edx
  801d02:	89 d0                	mov    %edx,%eax
  801d04:	01 c0                	add    %eax,%eax
  801d06:	01 d0                	add    %edx,%eax
  801d08:	c1 e0 02             	shl    $0x2,%eax
  801d0b:	05 40 30 80 00       	add    $0x803040,%eax
  801d10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801d16:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d1c:	01 c2                	add    %eax,%edx
  801d1e:	89 d0                	mov    %edx,%eax
  801d20:	01 c0                	add    %eax,%eax
  801d22:	01 d0                	add    %edx,%eax
  801d24:	c1 e0 02             	shl    $0x2,%eax
  801d27:	05 44 30 80 00       	add    $0x803044,%eax
  801d2c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801d32:	ff 45 f4             	incl   -0xc(%ebp)
  801d35:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d38:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801d3b:	7c a1                	jl     801cde <free+0x94>
  801d3d:	eb 04                	jmp    801d43 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801d3f:	90                   	nop
  801d40:	eb 01                	jmp    801d43 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801d42:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801d43:	c9                   	leave  
  801d44:	c3                   	ret    

00801d45 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801d45:	55                   	push   %ebp
  801d46:	89 e5                	mov    %esp,%ebp
  801d48:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801d4b:	83 ec 04             	sub    $0x4,%esp
  801d4e:	68 6c 2d 80 00       	push   $0x802d6c
  801d53:	68 ae 00 00 00       	push   $0xae
  801d58:	68 43 2d 80 00       	push   $0x802d43
  801d5d:	e8 49 eb ff ff       	call   8008ab <_panic>

00801d62 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801d62:	55                   	push   %ebp
  801d63:	89 e5                	mov    %esp,%ebp
  801d65:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801d68:	83 ec 04             	sub    $0x4,%esp
  801d6b:	68 8c 2d 80 00       	push   $0x802d8c
  801d70:	68 ca 00 00 00       	push   $0xca
  801d75:	68 43 2d 80 00       	push   $0x802d43
  801d7a:	e8 2c eb ff ff       	call   8008ab <_panic>

00801d7f <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d7f:	55                   	push   %ebp
  801d80:	89 e5                	mov    %esp,%ebp
  801d82:	57                   	push   %edi
  801d83:	56                   	push   %esi
  801d84:	53                   	push   %ebx
  801d85:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d88:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d8e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d91:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d94:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d97:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d9a:	cd 30                	int    $0x30
  801d9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801da2:	83 c4 10             	add    $0x10,%esp
  801da5:	5b                   	pop    %ebx
  801da6:	5e                   	pop    %esi
  801da7:	5f                   	pop    %edi
  801da8:	5d                   	pop    %ebp
  801da9:	c3                   	ret    

00801daa <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801daa:	55                   	push   %ebp
  801dab:	89 e5                	mov    %esp,%ebp
  801dad:	83 ec 04             	sub    $0x4,%esp
  801db0:	8b 45 10             	mov    0x10(%ebp),%eax
  801db3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801db6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801dba:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	52                   	push   %edx
  801dc2:	ff 75 0c             	pushl  0xc(%ebp)
  801dc5:	50                   	push   %eax
  801dc6:	6a 00                	push   $0x0
  801dc8:	e8 b2 ff ff ff       	call   801d7f <syscall>
  801dcd:	83 c4 18             	add    $0x18,%esp
}
  801dd0:	90                   	nop
  801dd1:	c9                   	leave  
  801dd2:	c3                   	ret    

00801dd3 <sys_cgetc>:

int
sys_cgetc(void)
{
  801dd3:	55                   	push   %ebp
  801dd4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	6a 01                	push   $0x1
  801de2:	e8 98 ff ff ff       	call   801d7f <syscall>
  801de7:	83 c4 18             	add    $0x18,%esp
}
  801dea:	c9                   	leave  
  801deb:	c3                   	ret    

00801dec <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801dec:	55                   	push   %ebp
  801ded:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801def:	8b 45 08             	mov    0x8(%ebp),%eax
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	6a 00                	push   $0x0
  801dfa:	50                   	push   %eax
  801dfb:	6a 05                	push   $0x5
  801dfd:	e8 7d ff ff ff       	call   801d7f <syscall>
  801e02:	83 c4 18             	add    $0x18,%esp
}
  801e05:	c9                   	leave  
  801e06:	c3                   	ret    

00801e07 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801e07:	55                   	push   %ebp
  801e08:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801e0a:	6a 00                	push   $0x0
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	6a 02                	push   $0x2
  801e16:	e8 64 ff ff ff       	call   801d7f <syscall>
  801e1b:	83 c4 18             	add    $0x18,%esp
}
  801e1e:	c9                   	leave  
  801e1f:	c3                   	ret    

00801e20 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e20:	55                   	push   %ebp
  801e21:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 03                	push   $0x3
  801e2f:	e8 4b ff ff ff       	call   801d7f <syscall>
  801e34:	83 c4 18             	add    $0x18,%esp
}
  801e37:	c9                   	leave  
  801e38:	c3                   	ret    

00801e39 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e39:	55                   	push   %ebp
  801e3a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	6a 00                	push   $0x0
  801e44:	6a 00                	push   $0x0
  801e46:	6a 04                	push   $0x4
  801e48:	e8 32 ff ff ff       	call   801d7f <syscall>
  801e4d:	83 c4 18             	add    $0x18,%esp
}
  801e50:	c9                   	leave  
  801e51:	c3                   	ret    

00801e52 <sys_env_exit>:


void sys_env_exit(void)
{
  801e52:	55                   	push   %ebp
  801e53:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 06                	push   $0x6
  801e61:	e8 19 ff ff ff       	call   801d7f <syscall>
  801e66:	83 c4 18             	add    $0x18,%esp
}
  801e69:	90                   	nop
  801e6a:	c9                   	leave  
  801e6b:	c3                   	ret    

00801e6c <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e6c:	55                   	push   %ebp
  801e6d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e72:	8b 45 08             	mov    0x8(%ebp),%eax
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	52                   	push   %edx
  801e7c:	50                   	push   %eax
  801e7d:	6a 07                	push   $0x7
  801e7f:	e8 fb fe ff ff       	call   801d7f <syscall>
  801e84:	83 c4 18             	add    $0x18,%esp
}
  801e87:	c9                   	leave  
  801e88:	c3                   	ret    

00801e89 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e89:	55                   	push   %ebp
  801e8a:	89 e5                	mov    %esp,%ebp
  801e8c:	56                   	push   %esi
  801e8d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e8e:	8b 75 18             	mov    0x18(%ebp),%esi
  801e91:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e94:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e97:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9d:	56                   	push   %esi
  801e9e:	53                   	push   %ebx
  801e9f:	51                   	push   %ecx
  801ea0:	52                   	push   %edx
  801ea1:	50                   	push   %eax
  801ea2:	6a 08                	push   $0x8
  801ea4:	e8 d6 fe ff ff       	call   801d7f <syscall>
  801ea9:	83 c4 18             	add    $0x18,%esp
}
  801eac:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801eaf:	5b                   	pop    %ebx
  801eb0:	5e                   	pop    %esi
  801eb1:	5d                   	pop    %ebp
  801eb2:	c3                   	ret    

00801eb3 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801eb3:	55                   	push   %ebp
  801eb4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801eb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	52                   	push   %edx
  801ec3:	50                   	push   %eax
  801ec4:	6a 09                	push   $0x9
  801ec6:	e8 b4 fe ff ff       	call   801d7f <syscall>
  801ecb:	83 c4 18             	add    $0x18,%esp
}
  801ece:	c9                   	leave  
  801ecf:	c3                   	ret    

00801ed0 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801ed0:	55                   	push   %ebp
  801ed1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 00                	push   $0x0
  801ed7:	6a 00                	push   $0x0
  801ed9:	ff 75 0c             	pushl  0xc(%ebp)
  801edc:	ff 75 08             	pushl  0x8(%ebp)
  801edf:	6a 0a                	push   $0xa
  801ee1:	e8 99 fe ff ff       	call   801d7f <syscall>
  801ee6:	83 c4 18             	add    $0x18,%esp
}
  801ee9:	c9                   	leave  
  801eea:	c3                   	ret    

00801eeb <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801eeb:	55                   	push   %ebp
  801eec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 0b                	push   $0xb
  801efa:	e8 80 fe ff ff       	call   801d7f <syscall>
  801eff:	83 c4 18             	add    $0x18,%esp
}
  801f02:	c9                   	leave  
  801f03:	c3                   	ret    

00801f04 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801f04:	55                   	push   %ebp
  801f05:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801f07:	6a 00                	push   $0x0
  801f09:	6a 00                	push   $0x0
  801f0b:	6a 00                	push   $0x0
  801f0d:	6a 00                	push   $0x0
  801f0f:	6a 00                	push   $0x0
  801f11:	6a 0c                	push   $0xc
  801f13:	e8 67 fe ff ff       	call   801d7f <syscall>
  801f18:	83 c4 18             	add    $0x18,%esp
}
  801f1b:	c9                   	leave  
  801f1c:	c3                   	ret    

00801f1d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f1d:	55                   	push   %ebp
  801f1e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f20:	6a 00                	push   $0x0
  801f22:	6a 00                	push   $0x0
  801f24:	6a 00                	push   $0x0
  801f26:	6a 00                	push   $0x0
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 0d                	push   $0xd
  801f2c:	e8 4e fe ff ff       	call   801d7f <syscall>
  801f31:	83 c4 18             	add    $0x18,%esp
}
  801f34:	c9                   	leave  
  801f35:	c3                   	ret    

00801f36 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f36:	55                   	push   %ebp
  801f37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f39:	6a 00                	push   $0x0
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	ff 75 0c             	pushl  0xc(%ebp)
  801f42:	ff 75 08             	pushl  0x8(%ebp)
  801f45:	6a 11                	push   $0x11
  801f47:	e8 33 fe ff ff       	call   801d7f <syscall>
  801f4c:	83 c4 18             	add    $0x18,%esp
	return;
  801f4f:	90                   	nop
}
  801f50:	c9                   	leave  
  801f51:	c3                   	ret    

00801f52 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f52:	55                   	push   %ebp
  801f53:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	ff 75 0c             	pushl  0xc(%ebp)
  801f5e:	ff 75 08             	pushl  0x8(%ebp)
  801f61:	6a 12                	push   $0x12
  801f63:	e8 17 fe ff ff       	call   801d7f <syscall>
  801f68:	83 c4 18             	add    $0x18,%esp
	return ;
  801f6b:	90                   	nop
}
  801f6c:	c9                   	leave  
  801f6d:	c3                   	ret    

00801f6e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f6e:	55                   	push   %ebp
  801f6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f71:	6a 00                	push   $0x0
  801f73:	6a 00                	push   $0x0
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 0e                	push   $0xe
  801f7d:	e8 fd fd ff ff       	call   801d7f <syscall>
  801f82:	83 c4 18             	add    $0x18,%esp
}
  801f85:	c9                   	leave  
  801f86:	c3                   	ret    

00801f87 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f87:	55                   	push   %ebp
  801f88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f8a:	6a 00                	push   $0x0
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	ff 75 08             	pushl  0x8(%ebp)
  801f95:	6a 0f                	push   $0xf
  801f97:	e8 e3 fd ff ff       	call   801d7f <syscall>
  801f9c:	83 c4 18             	add    $0x18,%esp
}
  801f9f:	c9                   	leave  
  801fa0:	c3                   	ret    

00801fa1 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801fa1:	55                   	push   %ebp
  801fa2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801fa4:	6a 00                	push   $0x0
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	6a 00                	push   $0x0
  801fae:	6a 10                	push   $0x10
  801fb0:	e8 ca fd ff ff       	call   801d7f <syscall>
  801fb5:	83 c4 18             	add    $0x18,%esp
}
  801fb8:	90                   	nop
  801fb9:	c9                   	leave  
  801fba:	c3                   	ret    

00801fbb <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801fbb:	55                   	push   %ebp
  801fbc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801fbe:	6a 00                	push   $0x0
  801fc0:	6a 00                	push   $0x0
  801fc2:	6a 00                	push   $0x0
  801fc4:	6a 00                	push   $0x0
  801fc6:	6a 00                	push   $0x0
  801fc8:	6a 14                	push   $0x14
  801fca:	e8 b0 fd ff ff       	call   801d7f <syscall>
  801fcf:	83 c4 18             	add    $0x18,%esp
}
  801fd2:	90                   	nop
  801fd3:	c9                   	leave  
  801fd4:	c3                   	ret    

00801fd5 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801fd5:	55                   	push   %ebp
  801fd6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 00                	push   $0x0
  801fe0:	6a 00                	push   $0x0
  801fe2:	6a 15                	push   $0x15
  801fe4:	e8 96 fd ff ff       	call   801d7f <syscall>
  801fe9:	83 c4 18             	add    $0x18,%esp
}
  801fec:	90                   	nop
  801fed:	c9                   	leave  
  801fee:	c3                   	ret    

00801fef <sys_cputc>:


void
sys_cputc(const char c)
{
  801fef:	55                   	push   %ebp
  801ff0:	89 e5                	mov    %esp,%ebp
  801ff2:	83 ec 04             	sub    $0x4,%esp
  801ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ffb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 00                	push   $0x0
  802005:	6a 00                	push   $0x0
  802007:	50                   	push   %eax
  802008:	6a 16                	push   $0x16
  80200a:	e8 70 fd ff ff       	call   801d7f <syscall>
  80200f:	83 c4 18             	add    $0x18,%esp
}
  802012:	90                   	nop
  802013:	c9                   	leave  
  802014:	c3                   	ret    

00802015 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802015:	55                   	push   %ebp
  802016:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 17                	push   $0x17
  802024:	e8 56 fd ff ff       	call   801d7f <syscall>
  802029:	83 c4 18             	add    $0x18,%esp
}
  80202c:	90                   	nop
  80202d:	c9                   	leave  
  80202e:	c3                   	ret    

0080202f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80202f:	55                   	push   %ebp
  802030:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802032:	8b 45 08             	mov    0x8(%ebp),%eax
  802035:	6a 00                	push   $0x0
  802037:	6a 00                	push   $0x0
  802039:	6a 00                	push   $0x0
  80203b:	ff 75 0c             	pushl  0xc(%ebp)
  80203e:	50                   	push   %eax
  80203f:	6a 18                	push   $0x18
  802041:	e8 39 fd ff ff       	call   801d7f <syscall>
  802046:	83 c4 18             	add    $0x18,%esp
}
  802049:	c9                   	leave  
  80204a:	c3                   	ret    

0080204b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80204b:	55                   	push   %ebp
  80204c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80204e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802051:	8b 45 08             	mov    0x8(%ebp),%eax
  802054:	6a 00                	push   $0x0
  802056:	6a 00                	push   $0x0
  802058:	6a 00                	push   $0x0
  80205a:	52                   	push   %edx
  80205b:	50                   	push   %eax
  80205c:	6a 1b                	push   $0x1b
  80205e:	e8 1c fd ff ff       	call   801d7f <syscall>
  802063:	83 c4 18             	add    $0x18,%esp
}
  802066:	c9                   	leave  
  802067:	c3                   	ret    

00802068 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802068:	55                   	push   %ebp
  802069:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80206b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80206e:	8b 45 08             	mov    0x8(%ebp),%eax
  802071:	6a 00                	push   $0x0
  802073:	6a 00                	push   $0x0
  802075:	6a 00                	push   $0x0
  802077:	52                   	push   %edx
  802078:	50                   	push   %eax
  802079:	6a 19                	push   $0x19
  80207b:	e8 ff fc ff ff       	call   801d7f <syscall>
  802080:	83 c4 18             	add    $0x18,%esp
}
  802083:	90                   	nop
  802084:	c9                   	leave  
  802085:	c3                   	ret    

00802086 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802086:	55                   	push   %ebp
  802087:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802089:	8b 55 0c             	mov    0xc(%ebp),%edx
  80208c:	8b 45 08             	mov    0x8(%ebp),%eax
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	52                   	push   %edx
  802096:	50                   	push   %eax
  802097:	6a 1a                	push   $0x1a
  802099:	e8 e1 fc ff ff       	call   801d7f <syscall>
  80209e:	83 c4 18             	add    $0x18,%esp
}
  8020a1:	90                   	nop
  8020a2:	c9                   	leave  
  8020a3:	c3                   	ret    

008020a4 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8020a4:	55                   	push   %ebp
  8020a5:	89 e5                	mov    %esp,%ebp
  8020a7:	83 ec 04             	sub    $0x4,%esp
  8020aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8020ad:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8020b0:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8020b3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8020b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ba:	6a 00                	push   $0x0
  8020bc:	51                   	push   %ecx
  8020bd:	52                   	push   %edx
  8020be:	ff 75 0c             	pushl  0xc(%ebp)
  8020c1:	50                   	push   %eax
  8020c2:	6a 1c                	push   $0x1c
  8020c4:	e8 b6 fc ff ff       	call   801d7f <syscall>
  8020c9:	83 c4 18             	add    $0x18,%esp
}
  8020cc:	c9                   	leave  
  8020cd:	c3                   	ret    

008020ce <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8020ce:	55                   	push   %ebp
  8020cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8020d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 00                	push   $0x0
  8020db:	6a 00                	push   $0x0
  8020dd:	52                   	push   %edx
  8020de:	50                   	push   %eax
  8020df:	6a 1d                	push   $0x1d
  8020e1:	e8 99 fc ff ff       	call   801d7f <syscall>
  8020e6:	83 c4 18             	add    $0x18,%esp
}
  8020e9:	c9                   	leave  
  8020ea:	c3                   	ret    

008020eb <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8020eb:	55                   	push   %ebp
  8020ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8020ee:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f7:	6a 00                	push   $0x0
  8020f9:	6a 00                	push   $0x0
  8020fb:	51                   	push   %ecx
  8020fc:	52                   	push   %edx
  8020fd:	50                   	push   %eax
  8020fe:	6a 1e                	push   $0x1e
  802100:	e8 7a fc ff ff       	call   801d7f <syscall>
  802105:	83 c4 18             	add    $0x18,%esp
}
  802108:	c9                   	leave  
  802109:	c3                   	ret    

0080210a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80210a:	55                   	push   %ebp
  80210b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80210d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802110:	8b 45 08             	mov    0x8(%ebp),%eax
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	6a 00                	push   $0x0
  802119:	52                   	push   %edx
  80211a:	50                   	push   %eax
  80211b:	6a 1f                	push   $0x1f
  80211d:	e8 5d fc ff ff       	call   801d7f <syscall>
  802122:	83 c4 18             	add    $0x18,%esp
}
  802125:	c9                   	leave  
  802126:	c3                   	ret    

00802127 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802127:	55                   	push   %ebp
  802128:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80212a:	6a 00                	push   $0x0
  80212c:	6a 00                	push   $0x0
  80212e:	6a 00                	push   $0x0
  802130:	6a 00                	push   $0x0
  802132:	6a 00                	push   $0x0
  802134:	6a 20                	push   $0x20
  802136:	e8 44 fc ff ff       	call   801d7f <syscall>
  80213b:	83 c4 18             	add    $0x18,%esp
}
  80213e:	c9                   	leave  
  80213f:	c3                   	ret    

00802140 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802140:	55                   	push   %ebp
  802141:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802143:	8b 45 08             	mov    0x8(%ebp),%eax
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	ff 75 10             	pushl  0x10(%ebp)
  80214d:	ff 75 0c             	pushl  0xc(%ebp)
  802150:	50                   	push   %eax
  802151:	6a 21                	push   $0x21
  802153:	e8 27 fc ff ff       	call   801d7f <syscall>
  802158:	83 c4 18             	add    $0x18,%esp
}
  80215b:	c9                   	leave  
  80215c:	c3                   	ret    

0080215d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80215d:	55                   	push   %ebp
  80215e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802160:	8b 45 08             	mov    0x8(%ebp),%eax
  802163:	6a 00                	push   $0x0
  802165:	6a 00                	push   $0x0
  802167:	6a 00                	push   $0x0
  802169:	6a 00                	push   $0x0
  80216b:	50                   	push   %eax
  80216c:	6a 22                	push   $0x22
  80216e:	e8 0c fc ff ff       	call   801d7f <syscall>
  802173:	83 c4 18             	add    $0x18,%esp
}
  802176:	90                   	nop
  802177:	c9                   	leave  
  802178:	c3                   	ret    

00802179 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802179:	55                   	push   %ebp
  80217a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80217c:	8b 45 08             	mov    0x8(%ebp),%eax
  80217f:	6a 00                	push   $0x0
  802181:	6a 00                	push   $0x0
  802183:	6a 00                	push   $0x0
  802185:	6a 00                	push   $0x0
  802187:	50                   	push   %eax
  802188:	6a 23                	push   $0x23
  80218a:	e8 f0 fb ff ff       	call   801d7f <syscall>
  80218f:	83 c4 18             	add    $0x18,%esp
}
  802192:	90                   	nop
  802193:	c9                   	leave  
  802194:	c3                   	ret    

00802195 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802195:	55                   	push   %ebp
  802196:	89 e5                	mov    %esp,%ebp
  802198:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80219b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80219e:	8d 50 04             	lea    0x4(%eax),%edx
  8021a1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	6a 00                	push   $0x0
  8021aa:	52                   	push   %edx
  8021ab:	50                   	push   %eax
  8021ac:	6a 24                	push   $0x24
  8021ae:	e8 cc fb ff ff       	call   801d7f <syscall>
  8021b3:	83 c4 18             	add    $0x18,%esp
	return result;
  8021b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8021b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021bc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021bf:	89 01                	mov    %eax,(%ecx)
  8021c1:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8021c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c7:	c9                   	leave  
  8021c8:	c2 04 00             	ret    $0x4

008021cb <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8021cb:	55                   	push   %ebp
  8021cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8021ce:	6a 00                	push   $0x0
  8021d0:	6a 00                	push   $0x0
  8021d2:	ff 75 10             	pushl  0x10(%ebp)
  8021d5:	ff 75 0c             	pushl  0xc(%ebp)
  8021d8:	ff 75 08             	pushl  0x8(%ebp)
  8021db:	6a 13                	push   $0x13
  8021dd:	e8 9d fb ff ff       	call   801d7f <syscall>
  8021e2:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e5:	90                   	nop
}
  8021e6:	c9                   	leave  
  8021e7:	c3                   	ret    

008021e8 <sys_rcr2>:
uint32 sys_rcr2()
{
  8021e8:	55                   	push   %ebp
  8021e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 00                	push   $0x0
  8021f1:	6a 00                	push   $0x0
  8021f3:	6a 00                	push   $0x0
  8021f5:	6a 25                	push   $0x25
  8021f7:	e8 83 fb ff ff       	call   801d7f <syscall>
  8021fc:	83 c4 18             	add    $0x18,%esp
}
  8021ff:	c9                   	leave  
  802200:	c3                   	ret    

00802201 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802201:	55                   	push   %ebp
  802202:	89 e5                	mov    %esp,%ebp
  802204:	83 ec 04             	sub    $0x4,%esp
  802207:	8b 45 08             	mov    0x8(%ebp),%eax
  80220a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80220d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802211:	6a 00                	push   $0x0
  802213:	6a 00                	push   $0x0
  802215:	6a 00                	push   $0x0
  802217:	6a 00                	push   $0x0
  802219:	50                   	push   %eax
  80221a:	6a 26                	push   $0x26
  80221c:	e8 5e fb ff ff       	call   801d7f <syscall>
  802221:	83 c4 18             	add    $0x18,%esp
	return ;
  802224:	90                   	nop
}
  802225:	c9                   	leave  
  802226:	c3                   	ret    

00802227 <rsttst>:
void rsttst()
{
  802227:	55                   	push   %ebp
  802228:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80222a:	6a 00                	push   $0x0
  80222c:	6a 00                	push   $0x0
  80222e:	6a 00                	push   $0x0
  802230:	6a 00                	push   $0x0
  802232:	6a 00                	push   $0x0
  802234:	6a 28                	push   $0x28
  802236:	e8 44 fb ff ff       	call   801d7f <syscall>
  80223b:	83 c4 18             	add    $0x18,%esp
	return ;
  80223e:	90                   	nop
}
  80223f:	c9                   	leave  
  802240:	c3                   	ret    

00802241 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802241:	55                   	push   %ebp
  802242:	89 e5                	mov    %esp,%ebp
  802244:	83 ec 04             	sub    $0x4,%esp
  802247:	8b 45 14             	mov    0x14(%ebp),%eax
  80224a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80224d:	8b 55 18             	mov    0x18(%ebp),%edx
  802250:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802254:	52                   	push   %edx
  802255:	50                   	push   %eax
  802256:	ff 75 10             	pushl  0x10(%ebp)
  802259:	ff 75 0c             	pushl  0xc(%ebp)
  80225c:	ff 75 08             	pushl  0x8(%ebp)
  80225f:	6a 27                	push   $0x27
  802261:	e8 19 fb ff ff       	call   801d7f <syscall>
  802266:	83 c4 18             	add    $0x18,%esp
	return ;
  802269:	90                   	nop
}
  80226a:	c9                   	leave  
  80226b:	c3                   	ret    

0080226c <chktst>:
void chktst(uint32 n)
{
  80226c:	55                   	push   %ebp
  80226d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80226f:	6a 00                	push   $0x0
  802271:	6a 00                	push   $0x0
  802273:	6a 00                	push   $0x0
  802275:	6a 00                	push   $0x0
  802277:	ff 75 08             	pushl  0x8(%ebp)
  80227a:	6a 29                	push   $0x29
  80227c:	e8 fe fa ff ff       	call   801d7f <syscall>
  802281:	83 c4 18             	add    $0x18,%esp
	return ;
  802284:	90                   	nop
}
  802285:	c9                   	leave  
  802286:	c3                   	ret    

00802287 <inctst>:

void inctst()
{
  802287:	55                   	push   %ebp
  802288:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80228a:	6a 00                	push   $0x0
  80228c:	6a 00                	push   $0x0
  80228e:	6a 00                	push   $0x0
  802290:	6a 00                	push   $0x0
  802292:	6a 00                	push   $0x0
  802294:	6a 2a                	push   $0x2a
  802296:	e8 e4 fa ff ff       	call   801d7f <syscall>
  80229b:	83 c4 18             	add    $0x18,%esp
	return ;
  80229e:	90                   	nop
}
  80229f:	c9                   	leave  
  8022a0:	c3                   	ret    

008022a1 <gettst>:
uint32 gettst()
{
  8022a1:	55                   	push   %ebp
  8022a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8022a4:	6a 00                	push   $0x0
  8022a6:	6a 00                	push   $0x0
  8022a8:	6a 00                	push   $0x0
  8022aa:	6a 00                	push   $0x0
  8022ac:	6a 00                	push   $0x0
  8022ae:	6a 2b                	push   $0x2b
  8022b0:	e8 ca fa ff ff       	call   801d7f <syscall>
  8022b5:	83 c4 18             	add    $0x18,%esp
}
  8022b8:	c9                   	leave  
  8022b9:	c3                   	ret    

008022ba <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8022ba:	55                   	push   %ebp
  8022bb:	89 e5                	mov    %esp,%ebp
  8022bd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022c0:	6a 00                	push   $0x0
  8022c2:	6a 00                	push   $0x0
  8022c4:	6a 00                	push   $0x0
  8022c6:	6a 00                	push   $0x0
  8022c8:	6a 00                	push   $0x0
  8022ca:	6a 2c                	push   $0x2c
  8022cc:	e8 ae fa ff ff       	call   801d7f <syscall>
  8022d1:	83 c4 18             	add    $0x18,%esp
  8022d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8022d7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8022db:	75 07                	jne    8022e4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8022dd:	b8 01 00 00 00       	mov    $0x1,%eax
  8022e2:	eb 05                	jmp    8022e9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8022e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022e9:	c9                   	leave  
  8022ea:	c3                   	ret    

008022eb <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8022eb:	55                   	push   %ebp
  8022ec:	89 e5                	mov    %esp,%ebp
  8022ee:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022f1:	6a 00                	push   $0x0
  8022f3:	6a 00                	push   $0x0
  8022f5:	6a 00                	push   $0x0
  8022f7:	6a 00                	push   $0x0
  8022f9:	6a 00                	push   $0x0
  8022fb:	6a 2c                	push   $0x2c
  8022fd:	e8 7d fa ff ff       	call   801d7f <syscall>
  802302:	83 c4 18             	add    $0x18,%esp
  802305:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802308:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80230c:	75 07                	jne    802315 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80230e:	b8 01 00 00 00       	mov    $0x1,%eax
  802313:	eb 05                	jmp    80231a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802315:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80231a:	c9                   	leave  
  80231b:	c3                   	ret    

0080231c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80231c:	55                   	push   %ebp
  80231d:	89 e5                	mov    %esp,%ebp
  80231f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802322:	6a 00                	push   $0x0
  802324:	6a 00                	push   $0x0
  802326:	6a 00                	push   $0x0
  802328:	6a 00                	push   $0x0
  80232a:	6a 00                	push   $0x0
  80232c:	6a 2c                	push   $0x2c
  80232e:	e8 4c fa ff ff       	call   801d7f <syscall>
  802333:	83 c4 18             	add    $0x18,%esp
  802336:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802339:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80233d:	75 07                	jne    802346 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80233f:	b8 01 00 00 00       	mov    $0x1,%eax
  802344:	eb 05                	jmp    80234b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802346:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80234b:	c9                   	leave  
  80234c:	c3                   	ret    

0080234d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80234d:	55                   	push   %ebp
  80234e:	89 e5                	mov    %esp,%ebp
  802350:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802353:	6a 00                	push   $0x0
  802355:	6a 00                	push   $0x0
  802357:	6a 00                	push   $0x0
  802359:	6a 00                	push   $0x0
  80235b:	6a 00                	push   $0x0
  80235d:	6a 2c                	push   $0x2c
  80235f:	e8 1b fa ff ff       	call   801d7f <syscall>
  802364:	83 c4 18             	add    $0x18,%esp
  802367:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80236a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80236e:	75 07                	jne    802377 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802370:	b8 01 00 00 00       	mov    $0x1,%eax
  802375:	eb 05                	jmp    80237c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802377:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80237c:	c9                   	leave  
  80237d:	c3                   	ret    

0080237e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80237e:	55                   	push   %ebp
  80237f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802381:	6a 00                	push   $0x0
  802383:	6a 00                	push   $0x0
  802385:	6a 00                	push   $0x0
  802387:	6a 00                	push   $0x0
  802389:	ff 75 08             	pushl  0x8(%ebp)
  80238c:	6a 2d                	push   $0x2d
  80238e:	e8 ec f9 ff ff       	call   801d7f <syscall>
  802393:	83 c4 18             	add    $0x18,%esp
	return ;
  802396:	90                   	nop
}
  802397:	c9                   	leave  
  802398:	c3                   	ret    
  802399:	66 90                	xchg   %ax,%ax
  80239b:	90                   	nop

0080239c <__udivdi3>:
  80239c:	55                   	push   %ebp
  80239d:	57                   	push   %edi
  80239e:	56                   	push   %esi
  80239f:	53                   	push   %ebx
  8023a0:	83 ec 1c             	sub    $0x1c,%esp
  8023a3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8023a7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8023ab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023af:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8023b3:	89 ca                	mov    %ecx,%edx
  8023b5:	89 f8                	mov    %edi,%eax
  8023b7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8023bb:	85 f6                	test   %esi,%esi
  8023bd:	75 2d                	jne    8023ec <__udivdi3+0x50>
  8023bf:	39 cf                	cmp    %ecx,%edi
  8023c1:	77 65                	ja     802428 <__udivdi3+0x8c>
  8023c3:	89 fd                	mov    %edi,%ebp
  8023c5:	85 ff                	test   %edi,%edi
  8023c7:	75 0b                	jne    8023d4 <__udivdi3+0x38>
  8023c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8023ce:	31 d2                	xor    %edx,%edx
  8023d0:	f7 f7                	div    %edi
  8023d2:	89 c5                	mov    %eax,%ebp
  8023d4:	31 d2                	xor    %edx,%edx
  8023d6:	89 c8                	mov    %ecx,%eax
  8023d8:	f7 f5                	div    %ebp
  8023da:	89 c1                	mov    %eax,%ecx
  8023dc:	89 d8                	mov    %ebx,%eax
  8023de:	f7 f5                	div    %ebp
  8023e0:	89 cf                	mov    %ecx,%edi
  8023e2:	89 fa                	mov    %edi,%edx
  8023e4:	83 c4 1c             	add    $0x1c,%esp
  8023e7:	5b                   	pop    %ebx
  8023e8:	5e                   	pop    %esi
  8023e9:	5f                   	pop    %edi
  8023ea:	5d                   	pop    %ebp
  8023eb:	c3                   	ret    
  8023ec:	39 ce                	cmp    %ecx,%esi
  8023ee:	77 28                	ja     802418 <__udivdi3+0x7c>
  8023f0:	0f bd fe             	bsr    %esi,%edi
  8023f3:	83 f7 1f             	xor    $0x1f,%edi
  8023f6:	75 40                	jne    802438 <__udivdi3+0x9c>
  8023f8:	39 ce                	cmp    %ecx,%esi
  8023fa:	72 0a                	jb     802406 <__udivdi3+0x6a>
  8023fc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802400:	0f 87 9e 00 00 00    	ja     8024a4 <__udivdi3+0x108>
  802406:	b8 01 00 00 00       	mov    $0x1,%eax
  80240b:	89 fa                	mov    %edi,%edx
  80240d:	83 c4 1c             	add    $0x1c,%esp
  802410:	5b                   	pop    %ebx
  802411:	5e                   	pop    %esi
  802412:	5f                   	pop    %edi
  802413:	5d                   	pop    %ebp
  802414:	c3                   	ret    
  802415:	8d 76 00             	lea    0x0(%esi),%esi
  802418:	31 ff                	xor    %edi,%edi
  80241a:	31 c0                	xor    %eax,%eax
  80241c:	89 fa                	mov    %edi,%edx
  80241e:	83 c4 1c             	add    $0x1c,%esp
  802421:	5b                   	pop    %ebx
  802422:	5e                   	pop    %esi
  802423:	5f                   	pop    %edi
  802424:	5d                   	pop    %ebp
  802425:	c3                   	ret    
  802426:	66 90                	xchg   %ax,%ax
  802428:	89 d8                	mov    %ebx,%eax
  80242a:	f7 f7                	div    %edi
  80242c:	31 ff                	xor    %edi,%edi
  80242e:	89 fa                	mov    %edi,%edx
  802430:	83 c4 1c             	add    $0x1c,%esp
  802433:	5b                   	pop    %ebx
  802434:	5e                   	pop    %esi
  802435:	5f                   	pop    %edi
  802436:	5d                   	pop    %ebp
  802437:	c3                   	ret    
  802438:	bd 20 00 00 00       	mov    $0x20,%ebp
  80243d:	89 eb                	mov    %ebp,%ebx
  80243f:	29 fb                	sub    %edi,%ebx
  802441:	89 f9                	mov    %edi,%ecx
  802443:	d3 e6                	shl    %cl,%esi
  802445:	89 c5                	mov    %eax,%ebp
  802447:	88 d9                	mov    %bl,%cl
  802449:	d3 ed                	shr    %cl,%ebp
  80244b:	89 e9                	mov    %ebp,%ecx
  80244d:	09 f1                	or     %esi,%ecx
  80244f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802453:	89 f9                	mov    %edi,%ecx
  802455:	d3 e0                	shl    %cl,%eax
  802457:	89 c5                	mov    %eax,%ebp
  802459:	89 d6                	mov    %edx,%esi
  80245b:	88 d9                	mov    %bl,%cl
  80245d:	d3 ee                	shr    %cl,%esi
  80245f:	89 f9                	mov    %edi,%ecx
  802461:	d3 e2                	shl    %cl,%edx
  802463:	8b 44 24 08          	mov    0x8(%esp),%eax
  802467:	88 d9                	mov    %bl,%cl
  802469:	d3 e8                	shr    %cl,%eax
  80246b:	09 c2                	or     %eax,%edx
  80246d:	89 d0                	mov    %edx,%eax
  80246f:	89 f2                	mov    %esi,%edx
  802471:	f7 74 24 0c          	divl   0xc(%esp)
  802475:	89 d6                	mov    %edx,%esi
  802477:	89 c3                	mov    %eax,%ebx
  802479:	f7 e5                	mul    %ebp
  80247b:	39 d6                	cmp    %edx,%esi
  80247d:	72 19                	jb     802498 <__udivdi3+0xfc>
  80247f:	74 0b                	je     80248c <__udivdi3+0xf0>
  802481:	89 d8                	mov    %ebx,%eax
  802483:	31 ff                	xor    %edi,%edi
  802485:	e9 58 ff ff ff       	jmp    8023e2 <__udivdi3+0x46>
  80248a:	66 90                	xchg   %ax,%ax
  80248c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802490:	89 f9                	mov    %edi,%ecx
  802492:	d3 e2                	shl    %cl,%edx
  802494:	39 c2                	cmp    %eax,%edx
  802496:	73 e9                	jae    802481 <__udivdi3+0xe5>
  802498:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80249b:	31 ff                	xor    %edi,%edi
  80249d:	e9 40 ff ff ff       	jmp    8023e2 <__udivdi3+0x46>
  8024a2:	66 90                	xchg   %ax,%ax
  8024a4:	31 c0                	xor    %eax,%eax
  8024a6:	e9 37 ff ff ff       	jmp    8023e2 <__udivdi3+0x46>
  8024ab:	90                   	nop

008024ac <__umoddi3>:
  8024ac:	55                   	push   %ebp
  8024ad:	57                   	push   %edi
  8024ae:	56                   	push   %esi
  8024af:	53                   	push   %ebx
  8024b0:	83 ec 1c             	sub    $0x1c,%esp
  8024b3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8024b7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8024bb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024bf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8024c3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8024c7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8024cb:	89 f3                	mov    %esi,%ebx
  8024cd:	89 fa                	mov    %edi,%edx
  8024cf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024d3:	89 34 24             	mov    %esi,(%esp)
  8024d6:	85 c0                	test   %eax,%eax
  8024d8:	75 1a                	jne    8024f4 <__umoddi3+0x48>
  8024da:	39 f7                	cmp    %esi,%edi
  8024dc:	0f 86 a2 00 00 00    	jbe    802584 <__umoddi3+0xd8>
  8024e2:	89 c8                	mov    %ecx,%eax
  8024e4:	89 f2                	mov    %esi,%edx
  8024e6:	f7 f7                	div    %edi
  8024e8:	89 d0                	mov    %edx,%eax
  8024ea:	31 d2                	xor    %edx,%edx
  8024ec:	83 c4 1c             	add    $0x1c,%esp
  8024ef:	5b                   	pop    %ebx
  8024f0:	5e                   	pop    %esi
  8024f1:	5f                   	pop    %edi
  8024f2:	5d                   	pop    %ebp
  8024f3:	c3                   	ret    
  8024f4:	39 f0                	cmp    %esi,%eax
  8024f6:	0f 87 ac 00 00 00    	ja     8025a8 <__umoddi3+0xfc>
  8024fc:	0f bd e8             	bsr    %eax,%ebp
  8024ff:	83 f5 1f             	xor    $0x1f,%ebp
  802502:	0f 84 ac 00 00 00    	je     8025b4 <__umoddi3+0x108>
  802508:	bf 20 00 00 00       	mov    $0x20,%edi
  80250d:	29 ef                	sub    %ebp,%edi
  80250f:	89 fe                	mov    %edi,%esi
  802511:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802515:	89 e9                	mov    %ebp,%ecx
  802517:	d3 e0                	shl    %cl,%eax
  802519:	89 d7                	mov    %edx,%edi
  80251b:	89 f1                	mov    %esi,%ecx
  80251d:	d3 ef                	shr    %cl,%edi
  80251f:	09 c7                	or     %eax,%edi
  802521:	89 e9                	mov    %ebp,%ecx
  802523:	d3 e2                	shl    %cl,%edx
  802525:	89 14 24             	mov    %edx,(%esp)
  802528:	89 d8                	mov    %ebx,%eax
  80252a:	d3 e0                	shl    %cl,%eax
  80252c:	89 c2                	mov    %eax,%edx
  80252e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802532:	d3 e0                	shl    %cl,%eax
  802534:	89 44 24 04          	mov    %eax,0x4(%esp)
  802538:	8b 44 24 08          	mov    0x8(%esp),%eax
  80253c:	89 f1                	mov    %esi,%ecx
  80253e:	d3 e8                	shr    %cl,%eax
  802540:	09 d0                	or     %edx,%eax
  802542:	d3 eb                	shr    %cl,%ebx
  802544:	89 da                	mov    %ebx,%edx
  802546:	f7 f7                	div    %edi
  802548:	89 d3                	mov    %edx,%ebx
  80254a:	f7 24 24             	mull   (%esp)
  80254d:	89 c6                	mov    %eax,%esi
  80254f:	89 d1                	mov    %edx,%ecx
  802551:	39 d3                	cmp    %edx,%ebx
  802553:	0f 82 87 00 00 00    	jb     8025e0 <__umoddi3+0x134>
  802559:	0f 84 91 00 00 00    	je     8025f0 <__umoddi3+0x144>
  80255f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802563:	29 f2                	sub    %esi,%edx
  802565:	19 cb                	sbb    %ecx,%ebx
  802567:	89 d8                	mov    %ebx,%eax
  802569:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80256d:	d3 e0                	shl    %cl,%eax
  80256f:	89 e9                	mov    %ebp,%ecx
  802571:	d3 ea                	shr    %cl,%edx
  802573:	09 d0                	or     %edx,%eax
  802575:	89 e9                	mov    %ebp,%ecx
  802577:	d3 eb                	shr    %cl,%ebx
  802579:	89 da                	mov    %ebx,%edx
  80257b:	83 c4 1c             	add    $0x1c,%esp
  80257e:	5b                   	pop    %ebx
  80257f:	5e                   	pop    %esi
  802580:	5f                   	pop    %edi
  802581:	5d                   	pop    %ebp
  802582:	c3                   	ret    
  802583:	90                   	nop
  802584:	89 fd                	mov    %edi,%ebp
  802586:	85 ff                	test   %edi,%edi
  802588:	75 0b                	jne    802595 <__umoddi3+0xe9>
  80258a:	b8 01 00 00 00       	mov    $0x1,%eax
  80258f:	31 d2                	xor    %edx,%edx
  802591:	f7 f7                	div    %edi
  802593:	89 c5                	mov    %eax,%ebp
  802595:	89 f0                	mov    %esi,%eax
  802597:	31 d2                	xor    %edx,%edx
  802599:	f7 f5                	div    %ebp
  80259b:	89 c8                	mov    %ecx,%eax
  80259d:	f7 f5                	div    %ebp
  80259f:	89 d0                	mov    %edx,%eax
  8025a1:	e9 44 ff ff ff       	jmp    8024ea <__umoddi3+0x3e>
  8025a6:	66 90                	xchg   %ax,%ax
  8025a8:	89 c8                	mov    %ecx,%eax
  8025aa:	89 f2                	mov    %esi,%edx
  8025ac:	83 c4 1c             	add    $0x1c,%esp
  8025af:	5b                   	pop    %ebx
  8025b0:	5e                   	pop    %esi
  8025b1:	5f                   	pop    %edi
  8025b2:	5d                   	pop    %ebp
  8025b3:	c3                   	ret    
  8025b4:	3b 04 24             	cmp    (%esp),%eax
  8025b7:	72 06                	jb     8025bf <__umoddi3+0x113>
  8025b9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8025bd:	77 0f                	ja     8025ce <__umoddi3+0x122>
  8025bf:	89 f2                	mov    %esi,%edx
  8025c1:	29 f9                	sub    %edi,%ecx
  8025c3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8025c7:	89 14 24             	mov    %edx,(%esp)
  8025ca:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8025ce:	8b 44 24 04          	mov    0x4(%esp),%eax
  8025d2:	8b 14 24             	mov    (%esp),%edx
  8025d5:	83 c4 1c             	add    $0x1c,%esp
  8025d8:	5b                   	pop    %ebx
  8025d9:	5e                   	pop    %esi
  8025da:	5f                   	pop    %edi
  8025db:	5d                   	pop    %ebp
  8025dc:	c3                   	ret    
  8025dd:	8d 76 00             	lea    0x0(%esi),%esi
  8025e0:	2b 04 24             	sub    (%esp),%eax
  8025e3:	19 fa                	sbb    %edi,%edx
  8025e5:	89 d1                	mov    %edx,%ecx
  8025e7:	89 c6                	mov    %eax,%esi
  8025e9:	e9 71 ff ff ff       	jmp    80255f <__umoddi3+0xb3>
  8025ee:	66 90                	xchg   %ax,%ax
  8025f0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8025f4:	72 ea                	jb     8025e0 <__umoddi3+0x134>
  8025f6:	89 d9                	mov    %ebx,%ecx
  8025f8:	e9 62 ff ff ff       	jmp    80255f <__umoddi3+0xb3>
