
obj/user/ef_mergesort_leakage:     file format elf32-i386


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
  800031:	e8 a8 07 00 00       	call   8007de <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 28 01 00 00    	sub    $0x128,%esp
	char Line[255] ;
	char Chose ;
	int numOfRep = 0;
  800041:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	do
	{
		numOfRep++ ;
  800048:	ff 45 f0             	incl   -0x10(%ebp)
		//2012: lock the interrupt
		sys_disable_interrupt();
  80004b:	e8 9a 1d 00 00       	call   801dea <sys_disable_interrupt>

		cprintf("\n");
  800050:	83 ec 0c             	sub    $0xc,%esp
  800053:	68 40 24 80 00       	push   $0x802440
  800058:	e8 37 0b 00 00       	call   800b94 <cprintf>
  80005d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	68 42 24 80 00       	push   $0x802442
  800068:	e8 27 0b 00 00       	call   800b94 <cprintf>
  80006d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	68 58 24 80 00       	push   $0x802458
  800078:	e8 17 0b 00 00       	call   800b94 <cprintf>
  80007d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 42 24 80 00       	push   $0x802442
  800088:	e8 07 0b 00 00       	call   800b94 <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800090:	83 ec 0c             	sub    $0xc,%esp
  800093:	68 40 24 80 00       	push   $0x802440
  800098:	e8 f7 0a 00 00       	call   800b94 <cprintf>
  80009d:	83 c4 10             	add    $0x10,%esp
		cprintf("Enter the number of elements: ");
  8000a0:	83 ec 0c             	sub    $0xc,%esp
  8000a3:	68 70 24 80 00       	push   $0x802470
  8000a8:	e8 e7 0a 00 00       	call   800b94 <cprintf>
  8000ad:	83 c4 10             	add    $0x10,%esp

		int NumOfElements ;

		if (numOfRep == 1)
  8000b0:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  8000b4:	75 09                	jne    8000bf <_main+0x87>
			NumOfElements = 32;
  8000b6:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%ebp)
  8000bd:	eb 0d                	jmp    8000cc <_main+0x94>
		else if (numOfRep == 2)
  8000bf:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8000c3:	75 07                	jne    8000cc <_main+0x94>
			NumOfElements = 32;
  8000c5:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%ebp)

		cprintf("%d\n", NumOfElements) ;
  8000cc:	83 ec 08             	sub    $0x8,%esp
  8000cf:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d2:	68 8f 24 80 00       	push   $0x80248f
  8000d7:	e8 b8 0a 00 00       	call   800b94 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e2:	c1 e0 02             	shl    $0x2,%eax
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	50                   	push   %eax
  8000e9:	e8 6a 18 00 00       	call   801958 <malloc>
  8000ee:	83 c4 10             	add    $0x10,%esp
  8000f1:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000f4:	83 ec 0c             	sub    $0xc,%esp
  8000f7:	68 94 24 80 00       	push   $0x802494
  8000fc:	e8 93 0a 00 00       	call   800b94 <cprintf>
  800101:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  800104:	83 ec 0c             	sub    $0xc,%esp
  800107:	68 b6 24 80 00       	push   $0x8024b6
  80010c:	e8 83 0a 00 00       	call   800b94 <cprintf>
  800111:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	68 c4 24 80 00       	push   $0x8024c4
  80011c:	e8 73 0a 00 00       	call   800b94 <cprintf>
  800121:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800124:	83 ec 0c             	sub    $0xc,%esp
  800127:	68 d3 24 80 00       	push   $0x8024d3
  80012c:	e8 63 0a 00 00       	call   800b94 <cprintf>
  800131:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	68 e3 24 80 00       	push   $0x8024e3
  80013c:	e8 53 0a 00 00       	call   800b94 <cprintf>
  800141:	83 c4 10             	add    $0x10,%esp
			if (numOfRep == 1)
  800144:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  800148:	75 06                	jne    800150 <_main+0x118>
				Chose = 'a' ;
  80014a:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
  80014e:	eb 0a                	jmp    80015a <_main+0x122>
			else if (numOfRep == 2)
  800150:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  800154:	75 04                	jne    80015a <_main+0x122>
				Chose = 'c' ;
  800156:	c6 45 f7 63          	movb   $0x63,-0x9(%ebp)
			cputchar(Chose);
  80015a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80015e:	83 ec 0c             	sub    $0xc,%esp
  800161:	50                   	push   %eax
  800162:	e8 d7 05 00 00       	call   80073e <cputchar>
  800167:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80016a:	83 ec 0c             	sub    $0xc,%esp
  80016d:	6a 0a                	push   $0xa
  80016f:	e8 ca 05 00 00       	call   80073e <cputchar>
  800174:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800177:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80017b:	74 0c                	je     800189 <_main+0x151>
  80017d:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800181:	74 06                	je     800189 <_main+0x151>
  800183:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800187:	75 ab                	jne    800134 <_main+0xfc>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800189:	e8 76 1c 00 00       	call   801e04 <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  80018e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800192:	83 f8 62             	cmp    $0x62,%eax
  800195:	74 1d                	je     8001b4 <_main+0x17c>
  800197:	83 f8 63             	cmp    $0x63,%eax
  80019a:	74 2b                	je     8001c7 <_main+0x18f>
  80019c:	83 f8 61             	cmp    $0x61,%eax
  80019f:	75 39                	jne    8001da <_main+0x1a2>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  8001a1:	83 ec 08             	sub    $0x8,%esp
  8001a4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001aa:	e8 02 02 00 00       	call   8003b1 <InitializeAscending>
  8001af:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b2:	eb 37                	jmp    8001eb <_main+0x1b3>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  8001b4:	83 ec 08             	sub    $0x8,%esp
  8001b7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001ba:	ff 75 e8             	pushl  -0x18(%ebp)
  8001bd:	e8 20 02 00 00       	call   8003e2 <InitializeDescending>
  8001c2:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c5:	eb 24                	jmp    8001eb <_main+0x1b3>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c7:	83 ec 08             	sub    $0x8,%esp
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	ff 75 e8             	pushl  -0x18(%ebp)
  8001d0:	e8 42 02 00 00       	call   800417 <InitializeSemiRandom>
  8001d5:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d8:	eb 11                	jmp    8001eb <_main+0x1b3>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001da:	83 ec 08             	sub    $0x8,%esp
  8001dd:	ff 75 ec             	pushl  -0x14(%ebp)
  8001e0:	ff 75 e8             	pushl  -0x18(%ebp)
  8001e3:	e8 2f 02 00 00       	call   800417 <InitializeSemiRandom>
  8001e8:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001eb:	83 ec 04             	sub    $0x4,%esp
  8001ee:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f1:	6a 01                	push   $0x1
  8001f3:	ff 75 e8             	pushl  -0x18(%ebp)
  8001f6:	e8 ee 02 00 00       	call   8004e9 <MSort>
  8001fb:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001fe:	e8 e7 1b 00 00       	call   801dea <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  800203:	83 ec 0c             	sub    $0xc,%esp
  800206:	68 ec 24 80 00       	push   $0x8024ec
  80020b:	e8 84 09 00 00       	call   800b94 <cprintf>
  800210:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  800213:	e8 ec 1b 00 00       	call   801e04 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800218:	83 ec 08             	sub    $0x8,%esp
  80021b:	ff 75 ec             	pushl  -0x14(%ebp)
  80021e:	ff 75 e8             	pushl  -0x18(%ebp)
  800221:	e8 e1 00 00 00       	call   800307 <CheckSorted>
  800226:	83 c4 10             	add    $0x10,%esp
  800229:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  80022c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800230:	75 14                	jne    800246 <_main+0x20e>
  800232:	83 ec 04             	sub    $0x4,%esp
  800235:	68 20 25 80 00       	push   $0x802520
  80023a:	6a 58                	push   $0x58
  80023c:	68 42 25 80 00       	push   $0x802542
  800241:	e8 9a 06 00 00       	call   8008e0 <_panic>
		else
		{
			sys_disable_interrupt();
  800246:	e8 9f 1b 00 00       	call   801dea <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  80024b:	83 ec 0c             	sub    $0xc,%esp
  80024e:	68 60 25 80 00       	push   $0x802560
  800253:	e8 3c 09 00 00       	call   800b94 <cprintf>
  800258:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80025b:	83 ec 0c             	sub    $0xc,%esp
  80025e:	68 94 25 80 00       	push   $0x802594
  800263:	e8 2c 09 00 00       	call   800b94 <cprintf>
  800268:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80026b:	83 ec 0c             	sub    $0xc,%esp
  80026e:	68 c8 25 80 00       	push   $0x8025c8
  800273:	e8 1c 09 00 00       	call   800b94 <cprintf>
  800278:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80027b:	e8 84 1b 00 00       	call   801e04 <sys_enable_interrupt>
		}

		free(Elements) ;
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	ff 75 e8             	pushl  -0x18(%ebp)
  800286:	e8 ee 17 00 00       	call   801a79 <free>
  80028b:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  80028e:	e8 57 1b 00 00       	call   801dea <sys_disable_interrupt>
		Chose = 0 ;
  800293:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		while (Chose != 'y' && Chose != 'n')
  800297:	eb 50                	jmp    8002e9 <_main+0x2b1>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	68 fa 25 80 00       	push   $0x8025fa
  8002a1:	e8 ee 08 00 00       	call   800b94 <cprintf>
  8002a6:	83 c4 10             	add    $0x10,%esp
			if (numOfRep == 1)
  8002a9:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  8002ad:	75 06                	jne    8002b5 <_main+0x27d>
				Chose = 'y' ;
  8002af:	c6 45 f7 79          	movb   $0x79,-0x9(%ebp)
  8002b3:	eb 0a                	jmp    8002bf <_main+0x287>
			else if (numOfRep == 2)
  8002b5:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8002b9:	75 04                	jne    8002bf <_main+0x287>
				Chose = 'n' ;
  8002bb:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
			cputchar(Chose);
  8002bf:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8002c3:	83 ec 0c             	sub    $0xc,%esp
  8002c6:	50                   	push   %eax
  8002c7:	e8 72 04 00 00       	call   80073e <cputchar>
  8002cc:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002cf:	83 ec 0c             	sub    $0xc,%esp
  8002d2:	6a 0a                	push   $0xa
  8002d4:	e8 65 04 00 00       	call   80073e <cputchar>
  8002d9:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002dc:	83 ec 0c             	sub    $0xc,%esp
  8002df:	6a 0a                	push   $0xa
  8002e1:	e8 58 04 00 00       	call   80073e <cputchar>
  8002e6:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
		Chose = 0 ;
		while (Chose != 'y' && Chose != 'n')
  8002e9:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002ed:	74 06                	je     8002f5 <_main+0x2bd>
  8002ef:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002f3:	75 a4                	jne    800299 <_main+0x261>
				Chose = 'n' ;
			cputchar(Chose);
			cputchar('\n');
			cputchar('\n');
		}
		sys_enable_interrupt();
  8002f5:	e8 0a 1b 00 00       	call   801e04 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002fa:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002fe:	0f 84 44 fd ff ff    	je     800048 <_main+0x10>
}
  800304:	90                   	nop
  800305:	c9                   	leave  
  800306:	c3                   	ret    

00800307 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800307:	55                   	push   %ebp
  800308:	89 e5                	mov    %esp,%ebp
  80030a:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80030d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800314:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80031b:	eb 33                	jmp    800350 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80031d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800320:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800327:	8b 45 08             	mov    0x8(%ebp),%eax
  80032a:	01 d0                	add    %edx,%eax
  80032c:	8b 10                	mov    (%eax),%edx
  80032e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800331:	40                   	inc    %eax
  800332:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800339:	8b 45 08             	mov    0x8(%ebp),%eax
  80033c:	01 c8                	add    %ecx,%eax
  80033e:	8b 00                	mov    (%eax),%eax
  800340:	39 c2                	cmp    %eax,%edx
  800342:	7e 09                	jle    80034d <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800344:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80034b:	eb 0c                	jmp    800359 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80034d:	ff 45 f8             	incl   -0x8(%ebp)
  800350:	8b 45 0c             	mov    0xc(%ebp),%eax
  800353:	48                   	dec    %eax
  800354:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800357:	7f c4                	jg     80031d <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800359:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80035c:	c9                   	leave  
  80035d:	c3                   	ret    

0080035e <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80035e:	55                   	push   %ebp
  80035f:	89 e5                	mov    %esp,%ebp
  800361:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800364:	8b 45 0c             	mov    0xc(%ebp),%eax
  800367:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036e:	8b 45 08             	mov    0x8(%ebp),%eax
  800371:	01 d0                	add    %edx,%eax
  800373:	8b 00                	mov    (%eax),%eax
  800375:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800378:	8b 45 0c             	mov    0xc(%ebp),%eax
  80037b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800382:	8b 45 08             	mov    0x8(%ebp),%eax
  800385:	01 c2                	add    %eax,%edx
  800387:	8b 45 10             	mov    0x10(%ebp),%eax
  80038a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800391:	8b 45 08             	mov    0x8(%ebp),%eax
  800394:	01 c8                	add    %ecx,%eax
  800396:	8b 00                	mov    (%eax),%eax
  800398:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80039a:	8b 45 10             	mov    0x10(%ebp),%eax
  80039d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a7:	01 c2                	add    %eax,%edx
  8003a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003ac:	89 02                	mov    %eax,(%edx)
}
  8003ae:	90                   	nop
  8003af:	c9                   	leave  
  8003b0:	c3                   	ret    

008003b1 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8003b1:	55                   	push   %ebp
  8003b2:	89 e5                	mov    %esp,%ebp
  8003b4:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003be:	eb 17                	jmp    8003d7 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8003c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cd:	01 c2                	add    %eax,%edx
  8003cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003d2:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003d4:	ff 45 fc             	incl   -0x4(%ebp)
  8003d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003da:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003dd:	7c e1                	jl     8003c0 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8003df:	90                   	nop
  8003e0:	c9                   	leave  
  8003e1:	c3                   	ret    

008003e2 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8003e2:	55                   	push   %ebp
  8003e3:	89 e5                	mov    %esp,%ebp
  8003e5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ef:	eb 1b                	jmp    80040c <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fe:	01 c2                	add    %eax,%edx
  800400:	8b 45 0c             	mov    0xc(%ebp),%eax
  800403:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800406:	48                   	dec    %eax
  800407:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800409:	ff 45 fc             	incl   -0x4(%ebp)
  80040c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800412:	7c dd                	jl     8003f1 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800414:	90                   	nop
  800415:	c9                   	leave  
  800416:	c3                   	ret    

00800417 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800417:	55                   	push   %ebp
  800418:	89 e5                	mov    %esp,%ebp
  80041a:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80041d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800420:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800425:	f7 e9                	imul   %ecx
  800427:	c1 f9 1f             	sar    $0x1f,%ecx
  80042a:	89 d0                	mov    %edx,%eax
  80042c:	29 c8                	sub    %ecx,%eax
  80042e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800431:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800438:	eb 1e                	jmp    800458 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80043a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80043d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800444:	8b 45 08             	mov    0x8(%ebp),%eax
  800447:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80044a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80044d:	99                   	cltd   
  80044e:	f7 7d f8             	idivl  -0x8(%ebp)
  800451:	89 d0                	mov    %edx,%eax
  800453:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800455:	ff 45 fc             	incl   -0x4(%ebp)
  800458:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80045b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80045e:	7c da                	jl     80043a <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  800460:	90                   	nop
  800461:	c9                   	leave  
  800462:	c3                   	ret    

00800463 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800463:	55                   	push   %ebp
  800464:	89 e5                	mov    %esp,%ebp
  800466:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800469:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800470:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800477:	eb 42                	jmp    8004bb <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800479:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80047c:	99                   	cltd   
  80047d:	f7 7d f0             	idivl  -0x10(%ebp)
  800480:	89 d0                	mov    %edx,%eax
  800482:	85 c0                	test   %eax,%eax
  800484:	75 10                	jne    800496 <PrintElements+0x33>
			cprintf("\n");
  800486:	83 ec 0c             	sub    $0xc,%esp
  800489:	68 40 24 80 00       	push   $0x802440
  80048e:	e8 01 07 00 00       	call   800b94 <cprintf>
  800493:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800496:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800499:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a3:	01 d0                	add    %edx,%eax
  8004a5:	8b 00                	mov    (%eax),%eax
  8004a7:	83 ec 08             	sub    $0x8,%esp
  8004aa:	50                   	push   %eax
  8004ab:	68 18 26 80 00       	push   $0x802618
  8004b0:	e8 df 06 00 00       	call   800b94 <cprintf>
  8004b5:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004b8:	ff 45 f4             	incl   -0xc(%ebp)
  8004bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004be:	48                   	dec    %eax
  8004bf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8004c2:	7f b5                	jg     800479 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8004c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d1:	01 d0                	add    %edx,%eax
  8004d3:	8b 00                	mov    (%eax),%eax
  8004d5:	83 ec 08             	sub    $0x8,%esp
  8004d8:	50                   	push   %eax
  8004d9:	68 8f 24 80 00       	push   $0x80248f
  8004de:	e8 b1 06 00 00       	call   800b94 <cprintf>
  8004e3:	83 c4 10             	add    $0x10,%esp

}
  8004e6:	90                   	nop
  8004e7:	c9                   	leave  
  8004e8:	c3                   	ret    

008004e9 <MSort>:


void MSort(int* A, int p, int r)
{
  8004e9:	55                   	push   %ebp
  8004ea:	89 e5                	mov    %esp,%ebp
  8004ec:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004f5:	7d 54                	jge    80054b <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8004fd:	01 d0                	add    %edx,%eax
  8004ff:	89 c2                	mov    %eax,%edx
  800501:	c1 ea 1f             	shr    $0x1f,%edx
  800504:	01 d0                	add    %edx,%eax
  800506:	d1 f8                	sar    %eax
  800508:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  80050b:	83 ec 04             	sub    $0x4,%esp
  80050e:	ff 75 f4             	pushl  -0xc(%ebp)
  800511:	ff 75 0c             	pushl  0xc(%ebp)
  800514:	ff 75 08             	pushl  0x8(%ebp)
  800517:	e8 cd ff ff ff       	call   8004e9 <MSort>
  80051c:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  80051f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800522:	40                   	inc    %eax
  800523:	83 ec 04             	sub    $0x4,%esp
  800526:	ff 75 10             	pushl  0x10(%ebp)
  800529:	50                   	push   %eax
  80052a:	ff 75 08             	pushl  0x8(%ebp)
  80052d:	e8 b7 ff ff ff       	call   8004e9 <MSort>
  800532:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800535:	ff 75 10             	pushl  0x10(%ebp)
  800538:	ff 75 f4             	pushl  -0xc(%ebp)
  80053b:	ff 75 0c             	pushl  0xc(%ebp)
  80053e:	ff 75 08             	pushl  0x8(%ebp)
  800541:	e8 08 00 00 00       	call   80054e <Merge>
  800546:	83 c4 10             	add    $0x10,%esp
  800549:	eb 01                	jmp    80054c <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  80054b:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  80054c:	c9                   	leave  
  80054d:	c3                   	ret    

0080054e <Merge>:

void Merge(int* A, int p, int q, int r)
{
  80054e:	55                   	push   %ebp
  80054f:	89 e5                	mov    %esp,%ebp
  800551:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800554:	8b 45 10             	mov    0x10(%ebp),%eax
  800557:	2b 45 0c             	sub    0xc(%ebp),%eax
  80055a:	40                   	inc    %eax
  80055b:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80055e:	8b 45 14             	mov    0x14(%ebp),%eax
  800561:	2b 45 10             	sub    0x10(%ebp),%eax
  800564:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800567:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80056e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800575:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800578:	c1 e0 02             	shl    $0x2,%eax
  80057b:	83 ec 0c             	sub    $0xc,%esp
  80057e:	50                   	push   %eax
  80057f:	e8 d4 13 00 00       	call   801958 <malloc>
  800584:	83 c4 10             	add    $0x10,%esp
  800587:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  80058a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80058d:	c1 e0 02             	shl    $0x2,%eax
  800590:	83 ec 0c             	sub    $0xc,%esp
  800593:	50                   	push   %eax
  800594:	e8 bf 13 00 00       	call   801958 <malloc>
  800599:	83 c4 10             	add    $0x10,%esp
  80059c:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80059f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8005a6:	eb 2f                	jmp    8005d7 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  8005a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005b2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8005b5:	01 c2                	add    %eax,%edx
  8005b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005bd:	01 c8                	add    %ecx,%eax
  8005bf:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8005c4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ce:	01 c8                	add    %ecx,%eax
  8005d0:	8b 00                	mov    (%eax),%eax
  8005d2:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8005d4:	ff 45 ec             	incl   -0x14(%ebp)
  8005d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005da:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005dd:	7c c9                	jl     8005a8 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005df:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005e6:	eb 2a                	jmp    800612 <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005f2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005f5:	01 c2                	add    %eax,%edx
  8005f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005fd:	01 c8                	add    %ecx,%eax
  8005ff:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800606:	8b 45 08             	mov    0x8(%ebp),%eax
  800609:	01 c8                	add    %ecx,%eax
  80060b:	8b 00                	mov    (%eax),%eax
  80060d:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80060f:	ff 45 e8             	incl   -0x18(%ebp)
  800612:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800615:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800618:	7c ce                	jl     8005e8 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  80061a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800620:	e9 0a 01 00 00       	jmp    80072f <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  800625:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800628:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80062b:	0f 8d 95 00 00 00    	jge    8006c6 <Merge+0x178>
  800631:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800634:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800637:	0f 8d 89 00 00 00    	jge    8006c6 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80063d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800640:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800647:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80064a:	01 d0                	add    %edx,%eax
  80064c:	8b 10                	mov    (%eax),%edx
  80064e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800651:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800658:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80065b:	01 c8                	add    %ecx,%eax
  80065d:	8b 00                	mov    (%eax),%eax
  80065f:	39 c2                	cmp    %eax,%edx
  800661:	7d 33                	jge    800696 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800663:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800666:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80066b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800672:	8b 45 08             	mov    0x8(%ebp),%eax
  800675:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800678:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80067b:	8d 50 01             	lea    0x1(%eax),%edx
  80067e:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800681:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800688:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80068b:	01 d0                	add    %edx,%eax
  80068d:	8b 00                	mov    (%eax),%eax
  80068f:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800691:	e9 96 00 00 00       	jmp    80072c <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800696:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800699:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80069e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a8:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ae:	8d 50 01             	lea    0x1(%eax),%edx
  8006b1:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006bb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006be:	01 d0                	add    %edx,%eax
  8006c0:	8b 00                	mov    (%eax),%eax
  8006c2:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8006c4:	eb 66                	jmp    80072c <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  8006c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006c9:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8006cc:	7d 30                	jge    8006fe <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  8006ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006d1:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e0:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006e6:	8d 50 01             	lea    0x1(%eax),%edx
  8006e9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006f3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006f6:	01 d0                	add    %edx,%eax
  8006f8:	8b 00                	mov    (%eax),%eax
  8006fa:	89 01                	mov    %eax,(%ecx)
  8006fc:	eb 2e                	jmp    80072c <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800701:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800706:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80070d:	8b 45 08             	mov    0x8(%ebp),%eax
  800710:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800713:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800716:	8d 50 01             	lea    0x1(%eax),%edx
  800719:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80071c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800723:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800726:	01 d0                	add    %edx,%eax
  800728:	8b 00                	mov    (%eax),%eax
  80072a:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  80072c:	ff 45 e4             	incl   -0x1c(%ebp)
  80072f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800732:	3b 45 14             	cmp    0x14(%ebp),%eax
  800735:	0f 8e ea fe ff ff    	jle    800625 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  80073b:	90                   	nop
  80073c:	c9                   	leave  
  80073d:	c3                   	ret    

0080073e <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80073e:	55                   	push   %ebp
  80073f:	89 e5                	mov    %esp,%ebp
  800741:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800744:	8b 45 08             	mov    0x8(%ebp),%eax
  800747:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80074a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80074e:	83 ec 0c             	sub    $0xc,%esp
  800751:	50                   	push   %eax
  800752:	e8 c7 16 00 00       	call   801e1e <sys_cputc>
  800757:	83 c4 10             	add    $0x10,%esp
}
  80075a:	90                   	nop
  80075b:	c9                   	leave  
  80075c:	c3                   	ret    

0080075d <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80075d:	55                   	push   %ebp
  80075e:	89 e5                	mov    %esp,%ebp
  800760:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800763:	e8 82 16 00 00       	call   801dea <sys_disable_interrupt>
	char c = ch;
  800768:	8b 45 08             	mov    0x8(%ebp),%eax
  80076b:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80076e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800772:	83 ec 0c             	sub    $0xc,%esp
  800775:	50                   	push   %eax
  800776:	e8 a3 16 00 00       	call   801e1e <sys_cputc>
  80077b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80077e:	e8 81 16 00 00       	call   801e04 <sys_enable_interrupt>
}
  800783:	90                   	nop
  800784:	c9                   	leave  
  800785:	c3                   	ret    

00800786 <getchar>:

int
getchar(void)
{
  800786:	55                   	push   %ebp
  800787:	89 e5                	mov    %esp,%ebp
  800789:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80078c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800793:	eb 08                	jmp    80079d <getchar+0x17>
	{
		c = sys_cgetc();
  800795:	e8 68 14 00 00       	call   801c02 <sys_cgetc>
  80079a:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80079d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007a1:	74 f2                	je     800795 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8007a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007a6:	c9                   	leave  
  8007a7:	c3                   	ret    

008007a8 <atomic_getchar>:

int
atomic_getchar(void)
{
  8007a8:	55                   	push   %ebp
  8007a9:	89 e5                	mov    %esp,%ebp
  8007ab:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007ae:	e8 37 16 00 00       	call   801dea <sys_disable_interrupt>
	int c=0;
  8007b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8007ba:	eb 08                	jmp    8007c4 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8007bc:	e8 41 14 00 00       	call   801c02 <sys_cgetc>
  8007c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8007c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007c8:	74 f2                	je     8007bc <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007ca:	e8 35 16 00 00       	call   801e04 <sys_enable_interrupt>
	return c;
  8007cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007d2:	c9                   	leave  
  8007d3:	c3                   	ret    

008007d4 <iscons>:

int iscons(int fdnum)
{
  8007d4:	55                   	push   %ebp
  8007d5:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007d7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007dc:	5d                   	pop    %ebp
  8007dd:	c3                   	ret    

008007de <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007de:	55                   	push   %ebp
  8007df:	89 e5                	mov    %esp,%ebp
  8007e1:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007e4:	e8 66 14 00 00       	call   801c4f <sys_getenvindex>
  8007e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ef:	89 d0                	mov    %edx,%eax
  8007f1:	01 c0                	add    %eax,%eax
  8007f3:	01 d0                	add    %edx,%eax
  8007f5:	c1 e0 02             	shl    $0x2,%eax
  8007f8:	01 d0                	add    %edx,%eax
  8007fa:	c1 e0 06             	shl    $0x6,%eax
  8007fd:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800802:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800807:	a1 24 30 80 00       	mov    0x803024,%eax
  80080c:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800812:	84 c0                	test   %al,%al
  800814:	74 0f                	je     800825 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800816:	a1 24 30 80 00       	mov    0x803024,%eax
  80081b:	05 f4 02 00 00       	add    $0x2f4,%eax
  800820:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800825:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800829:	7e 0a                	jle    800835 <libmain+0x57>
		binaryname = argv[0];
  80082b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082e:	8b 00                	mov    (%eax),%eax
  800830:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800835:	83 ec 08             	sub    $0x8,%esp
  800838:	ff 75 0c             	pushl  0xc(%ebp)
  80083b:	ff 75 08             	pushl  0x8(%ebp)
  80083e:	e8 f5 f7 ff ff       	call   800038 <_main>
  800843:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800846:	e8 9f 15 00 00       	call   801dea <sys_disable_interrupt>
	cprintf("**************************************\n");
  80084b:	83 ec 0c             	sub    $0xc,%esp
  80084e:	68 38 26 80 00       	push   $0x802638
  800853:	e8 3c 03 00 00       	call   800b94 <cprintf>
  800858:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80085b:	a1 24 30 80 00       	mov    0x803024,%eax
  800860:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800866:	a1 24 30 80 00       	mov    0x803024,%eax
  80086b:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800871:	83 ec 04             	sub    $0x4,%esp
  800874:	52                   	push   %edx
  800875:	50                   	push   %eax
  800876:	68 60 26 80 00       	push   $0x802660
  80087b:	e8 14 03 00 00       	call   800b94 <cprintf>
  800880:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800883:	a1 24 30 80 00       	mov    0x803024,%eax
  800888:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80088e:	83 ec 08             	sub    $0x8,%esp
  800891:	50                   	push   %eax
  800892:	68 85 26 80 00       	push   $0x802685
  800897:	e8 f8 02 00 00       	call   800b94 <cprintf>
  80089c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80089f:	83 ec 0c             	sub    $0xc,%esp
  8008a2:	68 38 26 80 00       	push   $0x802638
  8008a7:	e8 e8 02 00 00       	call   800b94 <cprintf>
  8008ac:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008af:	e8 50 15 00 00       	call   801e04 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008b4:	e8 19 00 00 00       	call   8008d2 <exit>
}
  8008b9:	90                   	nop
  8008ba:	c9                   	leave  
  8008bb:	c3                   	ret    

008008bc <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008bc:	55                   	push   %ebp
  8008bd:	89 e5                	mov    %esp,%ebp
  8008bf:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008c2:	83 ec 0c             	sub    $0xc,%esp
  8008c5:	6a 00                	push   $0x0
  8008c7:	e8 4f 13 00 00       	call   801c1b <sys_env_destroy>
  8008cc:	83 c4 10             	add    $0x10,%esp
}
  8008cf:	90                   	nop
  8008d0:	c9                   	leave  
  8008d1:	c3                   	ret    

008008d2 <exit>:

void
exit(void)
{
  8008d2:	55                   	push   %ebp
  8008d3:	89 e5                	mov    %esp,%ebp
  8008d5:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008d8:	e8 a4 13 00 00       	call   801c81 <sys_env_exit>
}
  8008dd:	90                   	nop
  8008de:	c9                   	leave  
  8008df:	c3                   	ret    

008008e0 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008e0:	55                   	push   %ebp
  8008e1:	89 e5                	mov    %esp,%ebp
  8008e3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008e6:	8d 45 10             	lea    0x10(%ebp),%eax
  8008e9:	83 c0 04             	add    $0x4,%eax
  8008ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008ef:	a1 34 30 80 00       	mov    0x803034,%eax
  8008f4:	85 c0                	test   %eax,%eax
  8008f6:	74 16                	je     80090e <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008f8:	a1 34 30 80 00       	mov    0x803034,%eax
  8008fd:	83 ec 08             	sub    $0x8,%esp
  800900:	50                   	push   %eax
  800901:	68 9c 26 80 00       	push   $0x80269c
  800906:	e8 89 02 00 00       	call   800b94 <cprintf>
  80090b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80090e:	a1 00 30 80 00       	mov    0x803000,%eax
  800913:	ff 75 0c             	pushl  0xc(%ebp)
  800916:	ff 75 08             	pushl  0x8(%ebp)
  800919:	50                   	push   %eax
  80091a:	68 a1 26 80 00       	push   $0x8026a1
  80091f:	e8 70 02 00 00       	call   800b94 <cprintf>
  800924:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800927:	8b 45 10             	mov    0x10(%ebp),%eax
  80092a:	83 ec 08             	sub    $0x8,%esp
  80092d:	ff 75 f4             	pushl  -0xc(%ebp)
  800930:	50                   	push   %eax
  800931:	e8 f3 01 00 00       	call   800b29 <vcprintf>
  800936:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800939:	83 ec 08             	sub    $0x8,%esp
  80093c:	6a 00                	push   $0x0
  80093e:	68 bd 26 80 00       	push   $0x8026bd
  800943:	e8 e1 01 00 00       	call   800b29 <vcprintf>
  800948:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80094b:	e8 82 ff ff ff       	call   8008d2 <exit>

	// should not return here
	while (1) ;
  800950:	eb fe                	jmp    800950 <_panic+0x70>

00800952 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800952:	55                   	push   %ebp
  800953:	89 e5                	mov    %esp,%ebp
  800955:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800958:	a1 24 30 80 00       	mov    0x803024,%eax
  80095d:	8b 50 74             	mov    0x74(%eax),%edx
  800960:	8b 45 0c             	mov    0xc(%ebp),%eax
  800963:	39 c2                	cmp    %eax,%edx
  800965:	74 14                	je     80097b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800967:	83 ec 04             	sub    $0x4,%esp
  80096a:	68 c0 26 80 00       	push   $0x8026c0
  80096f:	6a 26                	push   $0x26
  800971:	68 0c 27 80 00       	push   $0x80270c
  800976:	e8 65 ff ff ff       	call   8008e0 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80097b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800982:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800989:	e9 c2 00 00 00       	jmp    800a50 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80098e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800991:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800998:	8b 45 08             	mov    0x8(%ebp),%eax
  80099b:	01 d0                	add    %edx,%eax
  80099d:	8b 00                	mov    (%eax),%eax
  80099f:	85 c0                	test   %eax,%eax
  8009a1:	75 08                	jne    8009ab <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009a3:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009a6:	e9 a2 00 00 00       	jmp    800a4d <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8009ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009b2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009b9:	eb 69                	jmp    800a24 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009bb:	a1 24 30 80 00       	mov    0x803024,%eax
  8009c0:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009c6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009c9:	89 d0                	mov    %edx,%eax
  8009cb:	01 c0                	add    %eax,%eax
  8009cd:	01 d0                	add    %edx,%eax
  8009cf:	c1 e0 02             	shl    $0x2,%eax
  8009d2:	01 c8                	add    %ecx,%eax
  8009d4:	8a 40 04             	mov    0x4(%eax),%al
  8009d7:	84 c0                	test   %al,%al
  8009d9:	75 46                	jne    800a21 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009db:	a1 24 30 80 00       	mov    0x803024,%eax
  8009e0:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009e6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009e9:	89 d0                	mov    %edx,%eax
  8009eb:	01 c0                	add    %eax,%eax
  8009ed:	01 d0                	add    %edx,%eax
  8009ef:	c1 e0 02             	shl    $0x2,%eax
  8009f2:	01 c8                	add    %ecx,%eax
  8009f4:	8b 00                	mov    (%eax),%eax
  8009f6:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009f9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009fc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a01:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a03:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a06:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a10:	01 c8                	add    %ecx,%eax
  800a12:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a14:	39 c2                	cmp    %eax,%edx
  800a16:	75 09                	jne    800a21 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800a18:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a1f:	eb 12                	jmp    800a33 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a21:	ff 45 e8             	incl   -0x18(%ebp)
  800a24:	a1 24 30 80 00       	mov    0x803024,%eax
  800a29:	8b 50 74             	mov    0x74(%eax),%edx
  800a2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a2f:	39 c2                	cmp    %eax,%edx
  800a31:	77 88                	ja     8009bb <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a33:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a37:	75 14                	jne    800a4d <CheckWSWithoutLastIndex+0xfb>
			panic(
  800a39:	83 ec 04             	sub    $0x4,%esp
  800a3c:	68 18 27 80 00       	push   $0x802718
  800a41:	6a 3a                	push   $0x3a
  800a43:	68 0c 27 80 00       	push   $0x80270c
  800a48:	e8 93 fe ff ff       	call   8008e0 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a4d:	ff 45 f0             	incl   -0x10(%ebp)
  800a50:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a53:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a56:	0f 8c 32 ff ff ff    	jl     80098e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a5c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a63:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a6a:	eb 26                	jmp    800a92 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a6c:	a1 24 30 80 00       	mov    0x803024,%eax
  800a71:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800a77:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a7a:	89 d0                	mov    %edx,%eax
  800a7c:	01 c0                	add    %eax,%eax
  800a7e:	01 d0                	add    %edx,%eax
  800a80:	c1 e0 02             	shl    $0x2,%eax
  800a83:	01 c8                	add    %ecx,%eax
  800a85:	8a 40 04             	mov    0x4(%eax),%al
  800a88:	3c 01                	cmp    $0x1,%al
  800a8a:	75 03                	jne    800a8f <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800a8c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a8f:	ff 45 e0             	incl   -0x20(%ebp)
  800a92:	a1 24 30 80 00       	mov    0x803024,%eax
  800a97:	8b 50 74             	mov    0x74(%eax),%edx
  800a9a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a9d:	39 c2                	cmp    %eax,%edx
  800a9f:	77 cb                	ja     800a6c <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800aa4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800aa7:	74 14                	je     800abd <CheckWSWithoutLastIndex+0x16b>
		panic(
  800aa9:	83 ec 04             	sub    $0x4,%esp
  800aac:	68 6c 27 80 00       	push   $0x80276c
  800ab1:	6a 44                	push   $0x44
  800ab3:	68 0c 27 80 00       	push   $0x80270c
  800ab8:	e8 23 fe ff ff       	call   8008e0 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800abd:	90                   	nop
  800abe:	c9                   	leave  
  800abf:	c3                   	ret    

00800ac0 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800ac0:	55                   	push   %ebp
  800ac1:	89 e5                	mov    %esp,%ebp
  800ac3:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ac6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac9:	8b 00                	mov    (%eax),%eax
  800acb:	8d 48 01             	lea    0x1(%eax),%ecx
  800ace:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ad1:	89 0a                	mov    %ecx,(%edx)
  800ad3:	8b 55 08             	mov    0x8(%ebp),%edx
  800ad6:	88 d1                	mov    %dl,%cl
  800ad8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800adb:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800adf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae2:	8b 00                	mov    (%eax),%eax
  800ae4:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ae9:	75 2c                	jne    800b17 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800aeb:	a0 28 30 80 00       	mov    0x803028,%al
  800af0:	0f b6 c0             	movzbl %al,%eax
  800af3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af6:	8b 12                	mov    (%edx),%edx
  800af8:	89 d1                	mov    %edx,%ecx
  800afa:	8b 55 0c             	mov    0xc(%ebp),%edx
  800afd:	83 c2 08             	add    $0x8,%edx
  800b00:	83 ec 04             	sub    $0x4,%esp
  800b03:	50                   	push   %eax
  800b04:	51                   	push   %ecx
  800b05:	52                   	push   %edx
  800b06:	e8 ce 10 00 00       	call   801bd9 <sys_cputs>
  800b0b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b11:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1a:	8b 40 04             	mov    0x4(%eax),%eax
  800b1d:	8d 50 01             	lea    0x1(%eax),%edx
  800b20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b23:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b26:	90                   	nop
  800b27:	c9                   	leave  
  800b28:	c3                   	ret    

00800b29 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b29:	55                   	push   %ebp
  800b2a:	89 e5                	mov    %esp,%ebp
  800b2c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b32:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b39:	00 00 00 
	b.cnt = 0;
  800b3c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b43:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b46:	ff 75 0c             	pushl  0xc(%ebp)
  800b49:	ff 75 08             	pushl  0x8(%ebp)
  800b4c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b52:	50                   	push   %eax
  800b53:	68 c0 0a 80 00       	push   $0x800ac0
  800b58:	e8 11 02 00 00       	call   800d6e <vprintfmt>
  800b5d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b60:	a0 28 30 80 00       	mov    0x803028,%al
  800b65:	0f b6 c0             	movzbl %al,%eax
  800b68:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b6e:	83 ec 04             	sub    $0x4,%esp
  800b71:	50                   	push   %eax
  800b72:	52                   	push   %edx
  800b73:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b79:	83 c0 08             	add    $0x8,%eax
  800b7c:	50                   	push   %eax
  800b7d:	e8 57 10 00 00       	call   801bd9 <sys_cputs>
  800b82:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b85:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b8c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b92:	c9                   	leave  
  800b93:	c3                   	ret    

00800b94 <cprintf>:

int cprintf(const char *fmt, ...) {
  800b94:	55                   	push   %ebp
  800b95:	89 e5                	mov    %esp,%ebp
  800b97:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b9a:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800ba1:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ba4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  800baa:	83 ec 08             	sub    $0x8,%esp
  800bad:	ff 75 f4             	pushl  -0xc(%ebp)
  800bb0:	50                   	push   %eax
  800bb1:	e8 73 ff ff ff       	call   800b29 <vcprintf>
  800bb6:	83 c4 10             	add    $0x10,%esp
  800bb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bbf:	c9                   	leave  
  800bc0:	c3                   	ret    

00800bc1 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800bc1:	55                   	push   %ebp
  800bc2:	89 e5                	mov    %esp,%ebp
  800bc4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bc7:	e8 1e 12 00 00       	call   801dea <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bcc:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bcf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd5:	83 ec 08             	sub    $0x8,%esp
  800bd8:	ff 75 f4             	pushl  -0xc(%ebp)
  800bdb:	50                   	push   %eax
  800bdc:	e8 48 ff ff ff       	call   800b29 <vcprintf>
  800be1:	83 c4 10             	add    $0x10,%esp
  800be4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800be7:	e8 18 12 00 00       	call   801e04 <sys_enable_interrupt>
	return cnt;
  800bec:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bef:	c9                   	leave  
  800bf0:	c3                   	ret    

00800bf1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bf1:	55                   	push   %ebp
  800bf2:	89 e5                	mov    %esp,%ebp
  800bf4:	53                   	push   %ebx
  800bf5:	83 ec 14             	sub    $0x14,%esp
  800bf8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bfe:	8b 45 14             	mov    0x14(%ebp),%eax
  800c01:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c04:	8b 45 18             	mov    0x18(%ebp),%eax
  800c07:	ba 00 00 00 00       	mov    $0x0,%edx
  800c0c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c0f:	77 55                	ja     800c66 <printnum+0x75>
  800c11:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c14:	72 05                	jb     800c1b <printnum+0x2a>
  800c16:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c19:	77 4b                	ja     800c66 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c1b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c1e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c21:	8b 45 18             	mov    0x18(%ebp),%eax
  800c24:	ba 00 00 00 00       	mov    $0x0,%edx
  800c29:	52                   	push   %edx
  800c2a:	50                   	push   %eax
  800c2b:	ff 75 f4             	pushl  -0xc(%ebp)
  800c2e:	ff 75 f0             	pushl  -0x10(%ebp)
  800c31:	e8 92 15 00 00       	call   8021c8 <__udivdi3>
  800c36:	83 c4 10             	add    $0x10,%esp
  800c39:	83 ec 04             	sub    $0x4,%esp
  800c3c:	ff 75 20             	pushl  0x20(%ebp)
  800c3f:	53                   	push   %ebx
  800c40:	ff 75 18             	pushl  0x18(%ebp)
  800c43:	52                   	push   %edx
  800c44:	50                   	push   %eax
  800c45:	ff 75 0c             	pushl  0xc(%ebp)
  800c48:	ff 75 08             	pushl  0x8(%ebp)
  800c4b:	e8 a1 ff ff ff       	call   800bf1 <printnum>
  800c50:	83 c4 20             	add    $0x20,%esp
  800c53:	eb 1a                	jmp    800c6f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c55:	83 ec 08             	sub    $0x8,%esp
  800c58:	ff 75 0c             	pushl  0xc(%ebp)
  800c5b:	ff 75 20             	pushl  0x20(%ebp)
  800c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c61:	ff d0                	call   *%eax
  800c63:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c66:	ff 4d 1c             	decl   0x1c(%ebp)
  800c69:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c6d:	7f e6                	jg     800c55 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c6f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c72:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c77:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c7d:	53                   	push   %ebx
  800c7e:	51                   	push   %ecx
  800c7f:	52                   	push   %edx
  800c80:	50                   	push   %eax
  800c81:	e8 52 16 00 00       	call   8022d8 <__umoddi3>
  800c86:	83 c4 10             	add    $0x10,%esp
  800c89:	05 d4 29 80 00       	add    $0x8029d4,%eax
  800c8e:	8a 00                	mov    (%eax),%al
  800c90:	0f be c0             	movsbl %al,%eax
  800c93:	83 ec 08             	sub    $0x8,%esp
  800c96:	ff 75 0c             	pushl  0xc(%ebp)
  800c99:	50                   	push   %eax
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	ff d0                	call   *%eax
  800c9f:	83 c4 10             	add    $0x10,%esp
}
  800ca2:	90                   	nop
  800ca3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ca6:	c9                   	leave  
  800ca7:	c3                   	ret    

00800ca8 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ca8:	55                   	push   %ebp
  800ca9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cab:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800caf:	7e 1c                	jle    800ccd <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb4:	8b 00                	mov    (%eax),%eax
  800cb6:	8d 50 08             	lea    0x8(%eax),%edx
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbc:	89 10                	mov    %edx,(%eax)
  800cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc1:	8b 00                	mov    (%eax),%eax
  800cc3:	83 e8 08             	sub    $0x8,%eax
  800cc6:	8b 50 04             	mov    0x4(%eax),%edx
  800cc9:	8b 00                	mov    (%eax),%eax
  800ccb:	eb 40                	jmp    800d0d <getuint+0x65>
	else if (lflag)
  800ccd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cd1:	74 1e                	je     800cf1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd6:	8b 00                	mov    (%eax),%eax
  800cd8:	8d 50 04             	lea    0x4(%eax),%edx
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	89 10                	mov    %edx,(%eax)
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	8b 00                	mov    (%eax),%eax
  800ce5:	83 e8 04             	sub    $0x4,%eax
  800ce8:	8b 00                	mov    (%eax),%eax
  800cea:	ba 00 00 00 00       	mov    $0x0,%edx
  800cef:	eb 1c                	jmp    800d0d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	8b 00                	mov    (%eax),%eax
  800cf6:	8d 50 04             	lea    0x4(%eax),%edx
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	89 10                	mov    %edx,(%eax)
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	8b 00                	mov    (%eax),%eax
  800d03:	83 e8 04             	sub    $0x4,%eax
  800d06:	8b 00                	mov    (%eax),%eax
  800d08:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d0d:	5d                   	pop    %ebp
  800d0e:	c3                   	ret    

00800d0f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d0f:	55                   	push   %ebp
  800d10:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d12:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d16:	7e 1c                	jle    800d34 <getint+0x25>
		return va_arg(*ap, long long);
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	8b 00                	mov    (%eax),%eax
  800d1d:	8d 50 08             	lea    0x8(%eax),%edx
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	89 10                	mov    %edx,(%eax)
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	8b 00                	mov    (%eax),%eax
  800d2a:	83 e8 08             	sub    $0x8,%eax
  800d2d:	8b 50 04             	mov    0x4(%eax),%edx
  800d30:	8b 00                	mov    (%eax),%eax
  800d32:	eb 38                	jmp    800d6c <getint+0x5d>
	else if (lflag)
  800d34:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d38:	74 1a                	je     800d54 <getint+0x45>
		return va_arg(*ap, long);
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	8b 00                	mov    (%eax),%eax
  800d3f:	8d 50 04             	lea    0x4(%eax),%edx
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	89 10                	mov    %edx,(%eax)
  800d47:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4a:	8b 00                	mov    (%eax),%eax
  800d4c:	83 e8 04             	sub    $0x4,%eax
  800d4f:	8b 00                	mov    (%eax),%eax
  800d51:	99                   	cltd   
  800d52:	eb 18                	jmp    800d6c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	8b 00                	mov    (%eax),%eax
  800d59:	8d 50 04             	lea    0x4(%eax),%edx
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	89 10                	mov    %edx,(%eax)
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	8b 00                	mov    (%eax),%eax
  800d66:	83 e8 04             	sub    $0x4,%eax
  800d69:	8b 00                	mov    (%eax),%eax
  800d6b:	99                   	cltd   
}
  800d6c:	5d                   	pop    %ebp
  800d6d:	c3                   	ret    

00800d6e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d6e:	55                   	push   %ebp
  800d6f:	89 e5                	mov    %esp,%ebp
  800d71:	56                   	push   %esi
  800d72:	53                   	push   %ebx
  800d73:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d76:	eb 17                	jmp    800d8f <vprintfmt+0x21>
			if (ch == '\0')
  800d78:	85 db                	test   %ebx,%ebx
  800d7a:	0f 84 af 03 00 00    	je     80112f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d80:	83 ec 08             	sub    $0x8,%esp
  800d83:	ff 75 0c             	pushl  0xc(%ebp)
  800d86:	53                   	push   %ebx
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	ff d0                	call   *%eax
  800d8c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d92:	8d 50 01             	lea    0x1(%eax),%edx
  800d95:	89 55 10             	mov    %edx,0x10(%ebp)
  800d98:	8a 00                	mov    (%eax),%al
  800d9a:	0f b6 d8             	movzbl %al,%ebx
  800d9d:	83 fb 25             	cmp    $0x25,%ebx
  800da0:	75 d6                	jne    800d78 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800da2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800da6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800dad:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800db4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800dbb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800dc2:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc5:	8d 50 01             	lea    0x1(%eax),%edx
  800dc8:	89 55 10             	mov    %edx,0x10(%ebp)
  800dcb:	8a 00                	mov    (%eax),%al
  800dcd:	0f b6 d8             	movzbl %al,%ebx
  800dd0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dd3:	83 f8 55             	cmp    $0x55,%eax
  800dd6:	0f 87 2b 03 00 00    	ja     801107 <vprintfmt+0x399>
  800ddc:	8b 04 85 f8 29 80 00 	mov    0x8029f8(,%eax,4),%eax
  800de3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800de5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800de9:	eb d7                	jmp    800dc2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800deb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800def:	eb d1                	jmp    800dc2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800df1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800df8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800dfb:	89 d0                	mov    %edx,%eax
  800dfd:	c1 e0 02             	shl    $0x2,%eax
  800e00:	01 d0                	add    %edx,%eax
  800e02:	01 c0                	add    %eax,%eax
  800e04:	01 d8                	add    %ebx,%eax
  800e06:	83 e8 30             	sub    $0x30,%eax
  800e09:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e0c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0f:	8a 00                	mov    (%eax),%al
  800e11:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e14:	83 fb 2f             	cmp    $0x2f,%ebx
  800e17:	7e 3e                	jle    800e57 <vprintfmt+0xe9>
  800e19:	83 fb 39             	cmp    $0x39,%ebx
  800e1c:	7f 39                	jg     800e57 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e1e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e21:	eb d5                	jmp    800df8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e23:	8b 45 14             	mov    0x14(%ebp),%eax
  800e26:	83 c0 04             	add    $0x4,%eax
  800e29:	89 45 14             	mov    %eax,0x14(%ebp)
  800e2c:	8b 45 14             	mov    0x14(%ebp),%eax
  800e2f:	83 e8 04             	sub    $0x4,%eax
  800e32:	8b 00                	mov    (%eax),%eax
  800e34:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e37:	eb 1f                	jmp    800e58 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e39:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e3d:	79 83                	jns    800dc2 <vprintfmt+0x54>
				width = 0;
  800e3f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e46:	e9 77 ff ff ff       	jmp    800dc2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e4b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e52:	e9 6b ff ff ff       	jmp    800dc2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e57:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e58:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e5c:	0f 89 60 ff ff ff    	jns    800dc2 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e62:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e68:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e6f:	e9 4e ff ff ff       	jmp    800dc2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e74:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e77:	e9 46 ff ff ff       	jmp    800dc2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e7c:	8b 45 14             	mov    0x14(%ebp),%eax
  800e7f:	83 c0 04             	add    $0x4,%eax
  800e82:	89 45 14             	mov    %eax,0x14(%ebp)
  800e85:	8b 45 14             	mov    0x14(%ebp),%eax
  800e88:	83 e8 04             	sub    $0x4,%eax
  800e8b:	8b 00                	mov    (%eax),%eax
  800e8d:	83 ec 08             	sub    $0x8,%esp
  800e90:	ff 75 0c             	pushl  0xc(%ebp)
  800e93:	50                   	push   %eax
  800e94:	8b 45 08             	mov    0x8(%ebp),%eax
  800e97:	ff d0                	call   *%eax
  800e99:	83 c4 10             	add    $0x10,%esp
			break;
  800e9c:	e9 89 02 00 00       	jmp    80112a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ea1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea4:	83 c0 04             	add    $0x4,%eax
  800ea7:	89 45 14             	mov    %eax,0x14(%ebp)
  800eaa:	8b 45 14             	mov    0x14(%ebp),%eax
  800ead:	83 e8 04             	sub    $0x4,%eax
  800eb0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800eb2:	85 db                	test   %ebx,%ebx
  800eb4:	79 02                	jns    800eb8 <vprintfmt+0x14a>
				err = -err;
  800eb6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800eb8:	83 fb 64             	cmp    $0x64,%ebx
  800ebb:	7f 0b                	jg     800ec8 <vprintfmt+0x15a>
  800ebd:	8b 34 9d 40 28 80 00 	mov    0x802840(,%ebx,4),%esi
  800ec4:	85 f6                	test   %esi,%esi
  800ec6:	75 19                	jne    800ee1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ec8:	53                   	push   %ebx
  800ec9:	68 e5 29 80 00       	push   $0x8029e5
  800ece:	ff 75 0c             	pushl  0xc(%ebp)
  800ed1:	ff 75 08             	pushl  0x8(%ebp)
  800ed4:	e8 5e 02 00 00       	call   801137 <printfmt>
  800ed9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800edc:	e9 49 02 00 00       	jmp    80112a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ee1:	56                   	push   %esi
  800ee2:	68 ee 29 80 00       	push   $0x8029ee
  800ee7:	ff 75 0c             	pushl  0xc(%ebp)
  800eea:	ff 75 08             	pushl  0x8(%ebp)
  800eed:	e8 45 02 00 00       	call   801137 <printfmt>
  800ef2:	83 c4 10             	add    $0x10,%esp
			break;
  800ef5:	e9 30 02 00 00       	jmp    80112a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800efa:	8b 45 14             	mov    0x14(%ebp),%eax
  800efd:	83 c0 04             	add    $0x4,%eax
  800f00:	89 45 14             	mov    %eax,0x14(%ebp)
  800f03:	8b 45 14             	mov    0x14(%ebp),%eax
  800f06:	83 e8 04             	sub    $0x4,%eax
  800f09:	8b 30                	mov    (%eax),%esi
  800f0b:	85 f6                	test   %esi,%esi
  800f0d:	75 05                	jne    800f14 <vprintfmt+0x1a6>
				p = "(null)";
  800f0f:	be f1 29 80 00       	mov    $0x8029f1,%esi
			if (width > 0 && padc != '-')
  800f14:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f18:	7e 6d                	jle    800f87 <vprintfmt+0x219>
  800f1a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f1e:	74 67                	je     800f87 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f20:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f23:	83 ec 08             	sub    $0x8,%esp
  800f26:	50                   	push   %eax
  800f27:	56                   	push   %esi
  800f28:	e8 0c 03 00 00       	call   801239 <strnlen>
  800f2d:	83 c4 10             	add    $0x10,%esp
  800f30:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f33:	eb 16                	jmp    800f4b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f35:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f39:	83 ec 08             	sub    $0x8,%esp
  800f3c:	ff 75 0c             	pushl  0xc(%ebp)
  800f3f:	50                   	push   %eax
  800f40:	8b 45 08             	mov    0x8(%ebp),%eax
  800f43:	ff d0                	call   *%eax
  800f45:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f48:	ff 4d e4             	decl   -0x1c(%ebp)
  800f4b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f4f:	7f e4                	jg     800f35 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f51:	eb 34                	jmp    800f87 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f53:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f57:	74 1c                	je     800f75 <vprintfmt+0x207>
  800f59:	83 fb 1f             	cmp    $0x1f,%ebx
  800f5c:	7e 05                	jle    800f63 <vprintfmt+0x1f5>
  800f5e:	83 fb 7e             	cmp    $0x7e,%ebx
  800f61:	7e 12                	jle    800f75 <vprintfmt+0x207>
					putch('?', putdat);
  800f63:	83 ec 08             	sub    $0x8,%esp
  800f66:	ff 75 0c             	pushl  0xc(%ebp)
  800f69:	6a 3f                	push   $0x3f
  800f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6e:	ff d0                	call   *%eax
  800f70:	83 c4 10             	add    $0x10,%esp
  800f73:	eb 0f                	jmp    800f84 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f75:	83 ec 08             	sub    $0x8,%esp
  800f78:	ff 75 0c             	pushl  0xc(%ebp)
  800f7b:	53                   	push   %ebx
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	ff d0                	call   *%eax
  800f81:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f84:	ff 4d e4             	decl   -0x1c(%ebp)
  800f87:	89 f0                	mov    %esi,%eax
  800f89:	8d 70 01             	lea    0x1(%eax),%esi
  800f8c:	8a 00                	mov    (%eax),%al
  800f8e:	0f be d8             	movsbl %al,%ebx
  800f91:	85 db                	test   %ebx,%ebx
  800f93:	74 24                	je     800fb9 <vprintfmt+0x24b>
  800f95:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f99:	78 b8                	js     800f53 <vprintfmt+0x1e5>
  800f9b:	ff 4d e0             	decl   -0x20(%ebp)
  800f9e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fa2:	79 af                	jns    800f53 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fa4:	eb 13                	jmp    800fb9 <vprintfmt+0x24b>
				putch(' ', putdat);
  800fa6:	83 ec 08             	sub    $0x8,%esp
  800fa9:	ff 75 0c             	pushl  0xc(%ebp)
  800fac:	6a 20                	push   $0x20
  800fae:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb1:	ff d0                	call   *%eax
  800fb3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fb6:	ff 4d e4             	decl   -0x1c(%ebp)
  800fb9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fbd:	7f e7                	jg     800fa6 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fbf:	e9 66 01 00 00       	jmp    80112a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fc4:	83 ec 08             	sub    $0x8,%esp
  800fc7:	ff 75 e8             	pushl  -0x18(%ebp)
  800fca:	8d 45 14             	lea    0x14(%ebp),%eax
  800fcd:	50                   	push   %eax
  800fce:	e8 3c fd ff ff       	call   800d0f <getint>
  800fd3:	83 c4 10             	add    $0x10,%esp
  800fd6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fd9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fdf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fe2:	85 d2                	test   %edx,%edx
  800fe4:	79 23                	jns    801009 <vprintfmt+0x29b>
				putch('-', putdat);
  800fe6:	83 ec 08             	sub    $0x8,%esp
  800fe9:	ff 75 0c             	pushl  0xc(%ebp)
  800fec:	6a 2d                	push   $0x2d
  800fee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff1:	ff d0                	call   *%eax
  800ff3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ff6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ff9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ffc:	f7 d8                	neg    %eax
  800ffe:	83 d2 00             	adc    $0x0,%edx
  801001:	f7 da                	neg    %edx
  801003:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801006:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801009:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801010:	e9 bc 00 00 00       	jmp    8010d1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801015:	83 ec 08             	sub    $0x8,%esp
  801018:	ff 75 e8             	pushl  -0x18(%ebp)
  80101b:	8d 45 14             	lea    0x14(%ebp),%eax
  80101e:	50                   	push   %eax
  80101f:	e8 84 fc ff ff       	call   800ca8 <getuint>
  801024:	83 c4 10             	add    $0x10,%esp
  801027:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80102a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80102d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801034:	e9 98 00 00 00       	jmp    8010d1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801039:	83 ec 08             	sub    $0x8,%esp
  80103c:	ff 75 0c             	pushl  0xc(%ebp)
  80103f:	6a 58                	push   $0x58
  801041:	8b 45 08             	mov    0x8(%ebp),%eax
  801044:	ff d0                	call   *%eax
  801046:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801049:	83 ec 08             	sub    $0x8,%esp
  80104c:	ff 75 0c             	pushl  0xc(%ebp)
  80104f:	6a 58                	push   $0x58
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	ff d0                	call   *%eax
  801056:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801059:	83 ec 08             	sub    $0x8,%esp
  80105c:	ff 75 0c             	pushl  0xc(%ebp)
  80105f:	6a 58                	push   $0x58
  801061:	8b 45 08             	mov    0x8(%ebp),%eax
  801064:	ff d0                	call   *%eax
  801066:	83 c4 10             	add    $0x10,%esp
			break;
  801069:	e9 bc 00 00 00       	jmp    80112a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80106e:	83 ec 08             	sub    $0x8,%esp
  801071:	ff 75 0c             	pushl  0xc(%ebp)
  801074:	6a 30                	push   $0x30
  801076:	8b 45 08             	mov    0x8(%ebp),%eax
  801079:	ff d0                	call   *%eax
  80107b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80107e:	83 ec 08             	sub    $0x8,%esp
  801081:	ff 75 0c             	pushl  0xc(%ebp)
  801084:	6a 78                	push   $0x78
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	ff d0                	call   *%eax
  80108b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80108e:	8b 45 14             	mov    0x14(%ebp),%eax
  801091:	83 c0 04             	add    $0x4,%eax
  801094:	89 45 14             	mov    %eax,0x14(%ebp)
  801097:	8b 45 14             	mov    0x14(%ebp),%eax
  80109a:	83 e8 04             	sub    $0x4,%eax
  80109d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80109f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010a2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8010a9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010b0:	eb 1f                	jmp    8010d1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010b2:	83 ec 08             	sub    $0x8,%esp
  8010b5:	ff 75 e8             	pushl  -0x18(%ebp)
  8010b8:	8d 45 14             	lea    0x14(%ebp),%eax
  8010bb:	50                   	push   %eax
  8010bc:	e8 e7 fb ff ff       	call   800ca8 <getuint>
  8010c1:	83 c4 10             	add    $0x10,%esp
  8010c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010c7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010ca:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010d1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010d8:	83 ec 04             	sub    $0x4,%esp
  8010db:	52                   	push   %edx
  8010dc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010df:	50                   	push   %eax
  8010e0:	ff 75 f4             	pushl  -0xc(%ebp)
  8010e3:	ff 75 f0             	pushl  -0x10(%ebp)
  8010e6:	ff 75 0c             	pushl  0xc(%ebp)
  8010e9:	ff 75 08             	pushl  0x8(%ebp)
  8010ec:	e8 00 fb ff ff       	call   800bf1 <printnum>
  8010f1:	83 c4 20             	add    $0x20,%esp
			break;
  8010f4:	eb 34                	jmp    80112a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010f6:	83 ec 08             	sub    $0x8,%esp
  8010f9:	ff 75 0c             	pushl  0xc(%ebp)
  8010fc:	53                   	push   %ebx
  8010fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801100:	ff d0                	call   *%eax
  801102:	83 c4 10             	add    $0x10,%esp
			break;
  801105:	eb 23                	jmp    80112a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801107:	83 ec 08             	sub    $0x8,%esp
  80110a:	ff 75 0c             	pushl  0xc(%ebp)
  80110d:	6a 25                	push   $0x25
  80110f:	8b 45 08             	mov    0x8(%ebp),%eax
  801112:	ff d0                	call   *%eax
  801114:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801117:	ff 4d 10             	decl   0x10(%ebp)
  80111a:	eb 03                	jmp    80111f <vprintfmt+0x3b1>
  80111c:	ff 4d 10             	decl   0x10(%ebp)
  80111f:	8b 45 10             	mov    0x10(%ebp),%eax
  801122:	48                   	dec    %eax
  801123:	8a 00                	mov    (%eax),%al
  801125:	3c 25                	cmp    $0x25,%al
  801127:	75 f3                	jne    80111c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801129:	90                   	nop
		}
	}
  80112a:	e9 47 fc ff ff       	jmp    800d76 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80112f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801130:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801133:	5b                   	pop    %ebx
  801134:	5e                   	pop    %esi
  801135:	5d                   	pop    %ebp
  801136:	c3                   	ret    

00801137 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801137:	55                   	push   %ebp
  801138:	89 e5                	mov    %esp,%ebp
  80113a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80113d:	8d 45 10             	lea    0x10(%ebp),%eax
  801140:	83 c0 04             	add    $0x4,%eax
  801143:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801146:	8b 45 10             	mov    0x10(%ebp),%eax
  801149:	ff 75 f4             	pushl  -0xc(%ebp)
  80114c:	50                   	push   %eax
  80114d:	ff 75 0c             	pushl  0xc(%ebp)
  801150:	ff 75 08             	pushl  0x8(%ebp)
  801153:	e8 16 fc ff ff       	call   800d6e <vprintfmt>
  801158:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80115b:	90                   	nop
  80115c:	c9                   	leave  
  80115d:	c3                   	ret    

0080115e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80115e:	55                   	push   %ebp
  80115f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801161:	8b 45 0c             	mov    0xc(%ebp),%eax
  801164:	8b 40 08             	mov    0x8(%eax),%eax
  801167:	8d 50 01             	lea    0x1(%eax),%edx
  80116a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801170:	8b 45 0c             	mov    0xc(%ebp),%eax
  801173:	8b 10                	mov    (%eax),%edx
  801175:	8b 45 0c             	mov    0xc(%ebp),%eax
  801178:	8b 40 04             	mov    0x4(%eax),%eax
  80117b:	39 c2                	cmp    %eax,%edx
  80117d:	73 12                	jae    801191 <sprintputch+0x33>
		*b->buf++ = ch;
  80117f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801182:	8b 00                	mov    (%eax),%eax
  801184:	8d 48 01             	lea    0x1(%eax),%ecx
  801187:	8b 55 0c             	mov    0xc(%ebp),%edx
  80118a:	89 0a                	mov    %ecx,(%edx)
  80118c:	8b 55 08             	mov    0x8(%ebp),%edx
  80118f:	88 10                	mov    %dl,(%eax)
}
  801191:	90                   	nop
  801192:	5d                   	pop    %ebp
  801193:	c3                   	ret    

00801194 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801194:	55                   	push   %ebp
  801195:	89 e5                	mov    %esp,%ebp
  801197:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80119a:	8b 45 08             	mov    0x8(%ebp),%eax
  80119d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a9:	01 d0                	add    %edx,%eax
  8011ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011b5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011b9:	74 06                	je     8011c1 <vsnprintf+0x2d>
  8011bb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011bf:	7f 07                	jg     8011c8 <vsnprintf+0x34>
		return -E_INVAL;
  8011c1:	b8 03 00 00 00       	mov    $0x3,%eax
  8011c6:	eb 20                	jmp    8011e8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011c8:	ff 75 14             	pushl  0x14(%ebp)
  8011cb:	ff 75 10             	pushl  0x10(%ebp)
  8011ce:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011d1:	50                   	push   %eax
  8011d2:	68 5e 11 80 00       	push   $0x80115e
  8011d7:	e8 92 fb ff ff       	call   800d6e <vprintfmt>
  8011dc:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011e2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011e8:	c9                   	leave  
  8011e9:	c3                   	ret    

008011ea <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011ea:	55                   	push   %ebp
  8011eb:	89 e5                	mov    %esp,%ebp
  8011ed:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011f0:	8d 45 10             	lea    0x10(%ebp),%eax
  8011f3:	83 c0 04             	add    $0x4,%eax
  8011f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fc:	ff 75 f4             	pushl  -0xc(%ebp)
  8011ff:	50                   	push   %eax
  801200:	ff 75 0c             	pushl  0xc(%ebp)
  801203:	ff 75 08             	pushl  0x8(%ebp)
  801206:	e8 89 ff ff ff       	call   801194 <vsnprintf>
  80120b:	83 c4 10             	add    $0x10,%esp
  80120e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801211:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801214:	c9                   	leave  
  801215:	c3                   	ret    

00801216 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801216:	55                   	push   %ebp
  801217:	89 e5                	mov    %esp,%ebp
  801219:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80121c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801223:	eb 06                	jmp    80122b <strlen+0x15>
		n++;
  801225:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801228:	ff 45 08             	incl   0x8(%ebp)
  80122b:	8b 45 08             	mov    0x8(%ebp),%eax
  80122e:	8a 00                	mov    (%eax),%al
  801230:	84 c0                	test   %al,%al
  801232:	75 f1                	jne    801225 <strlen+0xf>
		n++;
	return n;
  801234:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801237:	c9                   	leave  
  801238:	c3                   	ret    

00801239 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801239:	55                   	push   %ebp
  80123a:	89 e5                	mov    %esp,%ebp
  80123c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80123f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801246:	eb 09                	jmp    801251 <strnlen+0x18>
		n++;
  801248:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80124b:	ff 45 08             	incl   0x8(%ebp)
  80124e:	ff 4d 0c             	decl   0xc(%ebp)
  801251:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801255:	74 09                	je     801260 <strnlen+0x27>
  801257:	8b 45 08             	mov    0x8(%ebp),%eax
  80125a:	8a 00                	mov    (%eax),%al
  80125c:	84 c0                	test   %al,%al
  80125e:	75 e8                	jne    801248 <strnlen+0xf>
		n++;
	return n;
  801260:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801263:	c9                   	leave  
  801264:	c3                   	ret    

00801265 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801265:	55                   	push   %ebp
  801266:	89 e5                	mov    %esp,%ebp
  801268:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80126b:	8b 45 08             	mov    0x8(%ebp),%eax
  80126e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801271:	90                   	nop
  801272:	8b 45 08             	mov    0x8(%ebp),%eax
  801275:	8d 50 01             	lea    0x1(%eax),%edx
  801278:	89 55 08             	mov    %edx,0x8(%ebp)
  80127b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80127e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801281:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801284:	8a 12                	mov    (%edx),%dl
  801286:	88 10                	mov    %dl,(%eax)
  801288:	8a 00                	mov    (%eax),%al
  80128a:	84 c0                	test   %al,%al
  80128c:	75 e4                	jne    801272 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80128e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801291:	c9                   	leave  
  801292:	c3                   	ret    

00801293 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801293:	55                   	push   %ebp
  801294:	89 e5                	mov    %esp,%ebp
  801296:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801299:	8b 45 08             	mov    0x8(%ebp),%eax
  80129c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80129f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012a6:	eb 1f                	jmp    8012c7 <strncpy+0x34>
		*dst++ = *src;
  8012a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ab:	8d 50 01             	lea    0x1(%eax),%edx
  8012ae:	89 55 08             	mov    %edx,0x8(%ebp)
  8012b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b4:	8a 12                	mov    (%edx),%dl
  8012b6:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012bb:	8a 00                	mov    (%eax),%al
  8012bd:	84 c0                	test   %al,%al
  8012bf:	74 03                	je     8012c4 <strncpy+0x31>
			src++;
  8012c1:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012c4:	ff 45 fc             	incl   -0x4(%ebp)
  8012c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ca:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012cd:	72 d9                	jb     8012a8 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012d2:	c9                   	leave  
  8012d3:	c3                   	ret    

008012d4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012d4:	55                   	push   %ebp
  8012d5:	89 e5                	mov    %esp,%ebp
  8012d7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012da:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012e4:	74 30                	je     801316 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012e6:	eb 16                	jmp    8012fe <strlcpy+0x2a>
			*dst++ = *src++;
  8012e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012eb:	8d 50 01             	lea    0x1(%eax),%edx
  8012ee:	89 55 08             	mov    %edx,0x8(%ebp)
  8012f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012f7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012fa:	8a 12                	mov    (%edx),%dl
  8012fc:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8012fe:	ff 4d 10             	decl   0x10(%ebp)
  801301:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801305:	74 09                	je     801310 <strlcpy+0x3c>
  801307:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130a:	8a 00                	mov    (%eax),%al
  80130c:	84 c0                	test   %al,%al
  80130e:	75 d8                	jne    8012e8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801310:	8b 45 08             	mov    0x8(%ebp),%eax
  801313:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801316:	8b 55 08             	mov    0x8(%ebp),%edx
  801319:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80131c:	29 c2                	sub    %eax,%edx
  80131e:	89 d0                	mov    %edx,%eax
}
  801320:	c9                   	leave  
  801321:	c3                   	ret    

00801322 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801322:	55                   	push   %ebp
  801323:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801325:	eb 06                	jmp    80132d <strcmp+0xb>
		p++, q++;
  801327:	ff 45 08             	incl   0x8(%ebp)
  80132a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80132d:	8b 45 08             	mov    0x8(%ebp),%eax
  801330:	8a 00                	mov    (%eax),%al
  801332:	84 c0                	test   %al,%al
  801334:	74 0e                	je     801344 <strcmp+0x22>
  801336:	8b 45 08             	mov    0x8(%ebp),%eax
  801339:	8a 10                	mov    (%eax),%dl
  80133b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133e:	8a 00                	mov    (%eax),%al
  801340:	38 c2                	cmp    %al,%dl
  801342:	74 e3                	je     801327 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801344:	8b 45 08             	mov    0x8(%ebp),%eax
  801347:	8a 00                	mov    (%eax),%al
  801349:	0f b6 d0             	movzbl %al,%edx
  80134c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134f:	8a 00                	mov    (%eax),%al
  801351:	0f b6 c0             	movzbl %al,%eax
  801354:	29 c2                	sub    %eax,%edx
  801356:	89 d0                	mov    %edx,%eax
}
  801358:	5d                   	pop    %ebp
  801359:	c3                   	ret    

0080135a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80135a:	55                   	push   %ebp
  80135b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80135d:	eb 09                	jmp    801368 <strncmp+0xe>
		n--, p++, q++;
  80135f:	ff 4d 10             	decl   0x10(%ebp)
  801362:	ff 45 08             	incl   0x8(%ebp)
  801365:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801368:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80136c:	74 17                	je     801385 <strncmp+0x2b>
  80136e:	8b 45 08             	mov    0x8(%ebp),%eax
  801371:	8a 00                	mov    (%eax),%al
  801373:	84 c0                	test   %al,%al
  801375:	74 0e                	je     801385 <strncmp+0x2b>
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	8a 10                	mov    (%eax),%dl
  80137c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137f:	8a 00                	mov    (%eax),%al
  801381:	38 c2                	cmp    %al,%dl
  801383:	74 da                	je     80135f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801385:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801389:	75 07                	jne    801392 <strncmp+0x38>
		return 0;
  80138b:	b8 00 00 00 00       	mov    $0x0,%eax
  801390:	eb 14                	jmp    8013a6 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	8a 00                	mov    (%eax),%al
  801397:	0f b6 d0             	movzbl %al,%edx
  80139a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139d:	8a 00                	mov    (%eax),%al
  80139f:	0f b6 c0             	movzbl %al,%eax
  8013a2:	29 c2                	sub    %eax,%edx
  8013a4:	89 d0                	mov    %edx,%eax
}
  8013a6:	5d                   	pop    %ebp
  8013a7:	c3                   	ret    

008013a8 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013a8:	55                   	push   %ebp
  8013a9:	89 e5                	mov    %esp,%ebp
  8013ab:	83 ec 04             	sub    $0x4,%esp
  8013ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013b4:	eb 12                	jmp    8013c8 <strchr+0x20>
		if (*s == c)
  8013b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b9:	8a 00                	mov    (%eax),%al
  8013bb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013be:	75 05                	jne    8013c5 <strchr+0x1d>
			return (char *) s;
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	eb 11                	jmp    8013d6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013c5:	ff 45 08             	incl   0x8(%ebp)
  8013c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cb:	8a 00                	mov    (%eax),%al
  8013cd:	84 c0                	test   %al,%al
  8013cf:	75 e5                	jne    8013b6 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013d1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013d6:	c9                   	leave  
  8013d7:	c3                   	ret    

008013d8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013d8:	55                   	push   %ebp
  8013d9:	89 e5                	mov    %esp,%ebp
  8013db:	83 ec 04             	sub    $0x4,%esp
  8013de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013e4:	eb 0d                	jmp    8013f3 <strfind+0x1b>
		if (*s == c)
  8013e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e9:	8a 00                	mov    (%eax),%al
  8013eb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013ee:	74 0e                	je     8013fe <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013f0:	ff 45 08             	incl   0x8(%ebp)
  8013f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f6:	8a 00                	mov    (%eax),%al
  8013f8:	84 c0                	test   %al,%al
  8013fa:	75 ea                	jne    8013e6 <strfind+0xe>
  8013fc:	eb 01                	jmp    8013ff <strfind+0x27>
		if (*s == c)
			break;
  8013fe:	90                   	nop
	return (char *) s;
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801402:	c9                   	leave  
  801403:	c3                   	ret    

00801404 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801404:	55                   	push   %ebp
  801405:	89 e5                	mov    %esp,%ebp
  801407:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801410:	8b 45 10             	mov    0x10(%ebp),%eax
  801413:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801416:	eb 0e                	jmp    801426 <memset+0x22>
		*p++ = c;
  801418:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80141b:	8d 50 01             	lea    0x1(%eax),%edx
  80141e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801421:	8b 55 0c             	mov    0xc(%ebp),%edx
  801424:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801426:	ff 4d f8             	decl   -0x8(%ebp)
  801429:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80142d:	79 e9                	jns    801418 <memset+0x14>
		*p++ = c;

	return v;
  80142f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801432:	c9                   	leave  
  801433:	c3                   	ret    

00801434 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801434:	55                   	push   %ebp
  801435:	89 e5                	mov    %esp,%ebp
  801437:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80143a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801440:	8b 45 08             	mov    0x8(%ebp),%eax
  801443:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801446:	eb 16                	jmp    80145e <memcpy+0x2a>
		*d++ = *s++;
  801448:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80144b:	8d 50 01             	lea    0x1(%eax),%edx
  80144e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801451:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801454:	8d 4a 01             	lea    0x1(%edx),%ecx
  801457:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80145a:	8a 12                	mov    (%edx),%dl
  80145c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80145e:	8b 45 10             	mov    0x10(%ebp),%eax
  801461:	8d 50 ff             	lea    -0x1(%eax),%edx
  801464:	89 55 10             	mov    %edx,0x10(%ebp)
  801467:	85 c0                	test   %eax,%eax
  801469:	75 dd                	jne    801448 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80146e:	c9                   	leave  
  80146f:	c3                   	ret    

00801470 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801470:	55                   	push   %ebp
  801471:	89 e5                	mov    %esp,%ebp
  801473:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801476:	8b 45 0c             	mov    0xc(%ebp),%eax
  801479:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80147c:	8b 45 08             	mov    0x8(%ebp),%eax
  80147f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801482:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801485:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801488:	73 50                	jae    8014da <memmove+0x6a>
  80148a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80148d:	8b 45 10             	mov    0x10(%ebp),%eax
  801490:	01 d0                	add    %edx,%eax
  801492:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801495:	76 43                	jbe    8014da <memmove+0x6a>
		s += n;
  801497:	8b 45 10             	mov    0x10(%ebp),%eax
  80149a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80149d:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a0:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014a3:	eb 10                	jmp    8014b5 <memmove+0x45>
			*--d = *--s;
  8014a5:	ff 4d f8             	decl   -0x8(%ebp)
  8014a8:	ff 4d fc             	decl   -0x4(%ebp)
  8014ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ae:	8a 10                	mov    (%eax),%dl
  8014b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b3:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014bb:	89 55 10             	mov    %edx,0x10(%ebp)
  8014be:	85 c0                	test   %eax,%eax
  8014c0:	75 e3                	jne    8014a5 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014c2:	eb 23                	jmp    8014e7 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014c7:	8d 50 01             	lea    0x1(%eax),%edx
  8014ca:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014d0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014d3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014d6:	8a 12                	mov    (%edx),%dl
  8014d8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8014da:	8b 45 10             	mov    0x10(%ebp),%eax
  8014dd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014e0:	89 55 10             	mov    %edx,0x10(%ebp)
  8014e3:	85 c0                	test   %eax,%eax
  8014e5:	75 dd                	jne    8014c4 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8014e7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014ea:	c9                   	leave  
  8014eb:	c3                   	ret    

008014ec <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8014ec:	55                   	push   %ebp
  8014ed:	89 e5                	mov    %esp,%ebp
  8014ef:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8014f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8014f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014fb:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8014fe:	eb 2a                	jmp    80152a <memcmp+0x3e>
		if (*s1 != *s2)
  801500:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801503:	8a 10                	mov    (%eax),%dl
  801505:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801508:	8a 00                	mov    (%eax),%al
  80150a:	38 c2                	cmp    %al,%dl
  80150c:	74 16                	je     801524 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80150e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801511:	8a 00                	mov    (%eax),%al
  801513:	0f b6 d0             	movzbl %al,%edx
  801516:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801519:	8a 00                	mov    (%eax),%al
  80151b:	0f b6 c0             	movzbl %al,%eax
  80151e:	29 c2                	sub    %eax,%edx
  801520:	89 d0                	mov    %edx,%eax
  801522:	eb 18                	jmp    80153c <memcmp+0x50>
		s1++, s2++;
  801524:	ff 45 fc             	incl   -0x4(%ebp)
  801527:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80152a:	8b 45 10             	mov    0x10(%ebp),%eax
  80152d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801530:	89 55 10             	mov    %edx,0x10(%ebp)
  801533:	85 c0                	test   %eax,%eax
  801535:	75 c9                	jne    801500 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801537:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80153c:	c9                   	leave  
  80153d:	c3                   	ret    

0080153e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80153e:	55                   	push   %ebp
  80153f:	89 e5                	mov    %esp,%ebp
  801541:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801544:	8b 55 08             	mov    0x8(%ebp),%edx
  801547:	8b 45 10             	mov    0x10(%ebp),%eax
  80154a:	01 d0                	add    %edx,%eax
  80154c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80154f:	eb 15                	jmp    801566 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801551:	8b 45 08             	mov    0x8(%ebp),%eax
  801554:	8a 00                	mov    (%eax),%al
  801556:	0f b6 d0             	movzbl %al,%edx
  801559:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155c:	0f b6 c0             	movzbl %al,%eax
  80155f:	39 c2                	cmp    %eax,%edx
  801561:	74 0d                	je     801570 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801563:	ff 45 08             	incl   0x8(%ebp)
  801566:	8b 45 08             	mov    0x8(%ebp),%eax
  801569:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80156c:	72 e3                	jb     801551 <memfind+0x13>
  80156e:	eb 01                	jmp    801571 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801570:	90                   	nop
	return (void *) s;
  801571:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801574:	c9                   	leave  
  801575:	c3                   	ret    

00801576 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801576:	55                   	push   %ebp
  801577:	89 e5                	mov    %esp,%ebp
  801579:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80157c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801583:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80158a:	eb 03                	jmp    80158f <strtol+0x19>
		s++;
  80158c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80158f:	8b 45 08             	mov    0x8(%ebp),%eax
  801592:	8a 00                	mov    (%eax),%al
  801594:	3c 20                	cmp    $0x20,%al
  801596:	74 f4                	je     80158c <strtol+0x16>
  801598:	8b 45 08             	mov    0x8(%ebp),%eax
  80159b:	8a 00                	mov    (%eax),%al
  80159d:	3c 09                	cmp    $0x9,%al
  80159f:	74 eb                	je     80158c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a4:	8a 00                	mov    (%eax),%al
  8015a6:	3c 2b                	cmp    $0x2b,%al
  8015a8:	75 05                	jne    8015af <strtol+0x39>
		s++;
  8015aa:	ff 45 08             	incl   0x8(%ebp)
  8015ad:	eb 13                	jmp    8015c2 <strtol+0x4c>
	else if (*s == '-')
  8015af:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b2:	8a 00                	mov    (%eax),%al
  8015b4:	3c 2d                	cmp    $0x2d,%al
  8015b6:	75 0a                	jne    8015c2 <strtol+0x4c>
		s++, neg = 1;
  8015b8:	ff 45 08             	incl   0x8(%ebp)
  8015bb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015c2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015c6:	74 06                	je     8015ce <strtol+0x58>
  8015c8:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015cc:	75 20                	jne    8015ee <strtol+0x78>
  8015ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d1:	8a 00                	mov    (%eax),%al
  8015d3:	3c 30                	cmp    $0x30,%al
  8015d5:	75 17                	jne    8015ee <strtol+0x78>
  8015d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015da:	40                   	inc    %eax
  8015db:	8a 00                	mov    (%eax),%al
  8015dd:	3c 78                	cmp    $0x78,%al
  8015df:	75 0d                	jne    8015ee <strtol+0x78>
		s += 2, base = 16;
  8015e1:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8015e5:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8015ec:	eb 28                	jmp    801616 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8015ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015f2:	75 15                	jne    801609 <strtol+0x93>
  8015f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f7:	8a 00                	mov    (%eax),%al
  8015f9:	3c 30                	cmp    $0x30,%al
  8015fb:	75 0c                	jne    801609 <strtol+0x93>
		s++, base = 8;
  8015fd:	ff 45 08             	incl   0x8(%ebp)
  801600:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801607:	eb 0d                	jmp    801616 <strtol+0xa0>
	else if (base == 0)
  801609:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80160d:	75 07                	jne    801616 <strtol+0xa0>
		base = 10;
  80160f:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	8a 00                	mov    (%eax),%al
  80161b:	3c 2f                	cmp    $0x2f,%al
  80161d:	7e 19                	jle    801638 <strtol+0xc2>
  80161f:	8b 45 08             	mov    0x8(%ebp),%eax
  801622:	8a 00                	mov    (%eax),%al
  801624:	3c 39                	cmp    $0x39,%al
  801626:	7f 10                	jg     801638 <strtol+0xc2>
			dig = *s - '0';
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	8a 00                	mov    (%eax),%al
  80162d:	0f be c0             	movsbl %al,%eax
  801630:	83 e8 30             	sub    $0x30,%eax
  801633:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801636:	eb 42                	jmp    80167a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801638:	8b 45 08             	mov    0x8(%ebp),%eax
  80163b:	8a 00                	mov    (%eax),%al
  80163d:	3c 60                	cmp    $0x60,%al
  80163f:	7e 19                	jle    80165a <strtol+0xe4>
  801641:	8b 45 08             	mov    0x8(%ebp),%eax
  801644:	8a 00                	mov    (%eax),%al
  801646:	3c 7a                	cmp    $0x7a,%al
  801648:	7f 10                	jg     80165a <strtol+0xe4>
			dig = *s - 'a' + 10;
  80164a:	8b 45 08             	mov    0x8(%ebp),%eax
  80164d:	8a 00                	mov    (%eax),%al
  80164f:	0f be c0             	movsbl %al,%eax
  801652:	83 e8 57             	sub    $0x57,%eax
  801655:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801658:	eb 20                	jmp    80167a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	8a 00                	mov    (%eax),%al
  80165f:	3c 40                	cmp    $0x40,%al
  801661:	7e 39                	jle    80169c <strtol+0x126>
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	8a 00                	mov    (%eax),%al
  801668:	3c 5a                	cmp    $0x5a,%al
  80166a:	7f 30                	jg     80169c <strtol+0x126>
			dig = *s - 'A' + 10;
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	8a 00                	mov    (%eax),%al
  801671:	0f be c0             	movsbl %al,%eax
  801674:	83 e8 37             	sub    $0x37,%eax
  801677:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80167a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80167d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801680:	7d 19                	jge    80169b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801682:	ff 45 08             	incl   0x8(%ebp)
  801685:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801688:	0f af 45 10          	imul   0x10(%ebp),%eax
  80168c:	89 c2                	mov    %eax,%edx
  80168e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801691:	01 d0                	add    %edx,%eax
  801693:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801696:	e9 7b ff ff ff       	jmp    801616 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80169b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80169c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016a0:	74 08                	je     8016aa <strtol+0x134>
		*endptr = (char *) s;
  8016a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a5:	8b 55 08             	mov    0x8(%ebp),%edx
  8016a8:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016aa:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016ae:	74 07                	je     8016b7 <strtol+0x141>
  8016b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b3:	f7 d8                	neg    %eax
  8016b5:	eb 03                	jmp    8016ba <strtol+0x144>
  8016b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016ba:	c9                   	leave  
  8016bb:	c3                   	ret    

008016bc <ltostr>:

void
ltostr(long value, char *str)
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
  8016bf:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016c9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016d0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016d4:	79 13                	jns    8016e9 <ltostr+0x2d>
	{
		neg = 1;
  8016d6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8016dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e0:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8016e3:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8016e6:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8016f1:	99                   	cltd   
  8016f2:	f7 f9                	idiv   %ecx
  8016f4:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8016f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016fa:	8d 50 01             	lea    0x1(%eax),%edx
  8016fd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801700:	89 c2                	mov    %eax,%edx
  801702:	8b 45 0c             	mov    0xc(%ebp),%eax
  801705:	01 d0                	add    %edx,%eax
  801707:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80170a:	83 c2 30             	add    $0x30,%edx
  80170d:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80170f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801712:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801717:	f7 e9                	imul   %ecx
  801719:	c1 fa 02             	sar    $0x2,%edx
  80171c:	89 c8                	mov    %ecx,%eax
  80171e:	c1 f8 1f             	sar    $0x1f,%eax
  801721:	29 c2                	sub    %eax,%edx
  801723:	89 d0                	mov    %edx,%eax
  801725:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801728:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80172b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801730:	f7 e9                	imul   %ecx
  801732:	c1 fa 02             	sar    $0x2,%edx
  801735:	89 c8                	mov    %ecx,%eax
  801737:	c1 f8 1f             	sar    $0x1f,%eax
  80173a:	29 c2                	sub    %eax,%edx
  80173c:	89 d0                	mov    %edx,%eax
  80173e:	c1 e0 02             	shl    $0x2,%eax
  801741:	01 d0                	add    %edx,%eax
  801743:	01 c0                	add    %eax,%eax
  801745:	29 c1                	sub    %eax,%ecx
  801747:	89 ca                	mov    %ecx,%edx
  801749:	85 d2                	test   %edx,%edx
  80174b:	75 9c                	jne    8016e9 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80174d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801754:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801757:	48                   	dec    %eax
  801758:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80175b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80175f:	74 3d                	je     80179e <ltostr+0xe2>
		start = 1 ;
  801761:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801768:	eb 34                	jmp    80179e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80176a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80176d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801770:	01 d0                	add    %edx,%eax
  801772:	8a 00                	mov    (%eax),%al
  801774:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801777:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80177a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177d:	01 c2                	add    %eax,%edx
  80177f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801782:	8b 45 0c             	mov    0xc(%ebp),%eax
  801785:	01 c8                	add    %ecx,%eax
  801787:	8a 00                	mov    (%eax),%al
  801789:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80178b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80178e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801791:	01 c2                	add    %eax,%edx
  801793:	8a 45 eb             	mov    -0x15(%ebp),%al
  801796:	88 02                	mov    %al,(%edx)
		start++ ;
  801798:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80179b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80179e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017a1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017a4:	7c c4                	jl     80176a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017a6:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ac:	01 d0                	add    %edx,%eax
  8017ae:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017b1:	90                   	nop
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
  8017b7:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017ba:	ff 75 08             	pushl  0x8(%ebp)
  8017bd:	e8 54 fa ff ff       	call   801216 <strlen>
  8017c2:	83 c4 04             	add    $0x4,%esp
  8017c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017c8:	ff 75 0c             	pushl  0xc(%ebp)
  8017cb:	e8 46 fa ff ff       	call   801216 <strlen>
  8017d0:	83 c4 04             	add    $0x4,%esp
  8017d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8017dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8017e4:	eb 17                	jmp    8017fd <strcconcat+0x49>
		final[s] = str1[s] ;
  8017e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ec:	01 c2                	add    %eax,%edx
  8017ee:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8017f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f4:	01 c8                	add    %ecx,%eax
  8017f6:	8a 00                	mov    (%eax),%al
  8017f8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8017fa:	ff 45 fc             	incl   -0x4(%ebp)
  8017fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801800:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801803:	7c e1                	jl     8017e6 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801805:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80180c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801813:	eb 1f                	jmp    801834 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801815:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801818:	8d 50 01             	lea    0x1(%eax),%edx
  80181b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80181e:	89 c2                	mov    %eax,%edx
  801820:	8b 45 10             	mov    0x10(%ebp),%eax
  801823:	01 c2                	add    %eax,%edx
  801825:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801828:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182b:	01 c8                	add    %ecx,%eax
  80182d:	8a 00                	mov    (%eax),%al
  80182f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801831:	ff 45 f8             	incl   -0x8(%ebp)
  801834:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801837:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80183a:	7c d9                	jl     801815 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80183c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80183f:	8b 45 10             	mov    0x10(%ebp),%eax
  801842:	01 d0                	add    %edx,%eax
  801844:	c6 00 00             	movb   $0x0,(%eax)
}
  801847:	90                   	nop
  801848:	c9                   	leave  
  801849:	c3                   	ret    

0080184a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80184a:	55                   	push   %ebp
  80184b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80184d:	8b 45 14             	mov    0x14(%ebp),%eax
  801850:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801856:	8b 45 14             	mov    0x14(%ebp),%eax
  801859:	8b 00                	mov    (%eax),%eax
  80185b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801862:	8b 45 10             	mov    0x10(%ebp),%eax
  801865:	01 d0                	add    %edx,%eax
  801867:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80186d:	eb 0c                	jmp    80187b <strsplit+0x31>
			*string++ = 0;
  80186f:	8b 45 08             	mov    0x8(%ebp),%eax
  801872:	8d 50 01             	lea    0x1(%eax),%edx
  801875:	89 55 08             	mov    %edx,0x8(%ebp)
  801878:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80187b:	8b 45 08             	mov    0x8(%ebp),%eax
  80187e:	8a 00                	mov    (%eax),%al
  801880:	84 c0                	test   %al,%al
  801882:	74 18                	je     80189c <strsplit+0x52>
  801884:	8b 45 08             	mov    0x8(%ebp),%eax
  801887:	8a 00                	mov    (%eax),%al
  801889:	0f be c0             	movsbl %al,%eax
  80188c:	50                   	push   %eax
  80188d:	ff 75 0c             	pushl  0xc(%ebp)
  801890:	e8 13 fb ff ff       	call   8013a8 <strchr>
  801895:	83 c4 08             	add    $0x8,%esp
  801898:	85 c0                	test   %eax,%eax
  80189a:	75 d3                	jne    80186f <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80189c:	8b 45 08             	mov    0x8(%ebp),%eax
  80189f:	8a 00                	mov    (%eax),%al
  8018a1:	84 c0                	test   %al,%al
  8018a3:	74 5a                	je     8018ff <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8018a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8018a8:	8b 00                	mov    (%eax),%eax
  8018aa:	83 f8 0f             	cmp    $0xf,%eax
  8018ad:	75 07                	jne    8018b6 <strsplit+0x6c>
		{
			return 0;
  8018af:	b8 00 00 00 00       	mov    $0x0,%eax
  8018b4:	eb 66                	jmp    80191c <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b9:	8b 00                	mov    (%eax),%eax
  8018bb:	8d 48 01             	lea    0x1(%eax),%ecx
  8018be:	8b 55 14             	mov    0x14(%ebp),%edx
  8018c1:	89 0a                	mov    %ecx,(%edx)
  8018c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8018cd:	01 c2                	add    %eax,%edx
  8018cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018d4:	eb 03                	jmp    8018d9 <strsplit+0x8f>
			string++;
  8018d6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dc:	8a 00                	mov    (%eax),%al
  8018de:	84 c0                	test   %al,%al
  8018e0:	74 8b                	je     80186d <strsplit+0x23>
  8018e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e5:	8a 00                	mov    (%eax),%al
  8018e7:	0f be c0             	movsbl %al,%eax
  8018ea:	50                   	push   %eax
  8018eb:	ff 75 0c             	pushl  0xc(%ebp)
  8018ee:	e8 b5 fa ff ff       	call   8013a8 <strchr>
  8018f3:	83 c4 08             	add    $0x8,%esp
  8018f6:	85 c0                	test   %eax,%eax
  8018f8:	74 dc                	je     8018d6 <strsplit+0x8c>
			string++;
	}
  8018fa:	e9 6e ff ff ff       	jmp    80186d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8018ff:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801900:	8b 45 14             	mov    0x14(%ebp),%eax
  801903:	8b 00                	mov    (%eax),%eax
  801905:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80190c:	8b 45 10             	mov    0x10(%ebp),%eax
  80190f:	01 d0                	add    %edx,%eax
  801911:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801917:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80191c:	c9                   	leave  
  80191d:	c3                   	ret    

0080191e <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80191e:	55                   	push   %ebp
  80191f:	89 e5                	mov    %esp,%ebp
  801921:	83 ec 18             	sub    $0x18,%esp
  801924:	8b 45 10             	mov    0x10(%ebp),%eax
  801927:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80192a:	83 ec 04             	sub    $0x4,%esp
  80192d:	68 50 2b 80 00       	push   $0x802b50
  801932:	6a 17                	push   $0x17
  801934:	68 6f 2b 80 00       	push   $0x802b6f
  801939:	e8 a2 ef ff ff       	call   8008e0 <_panic>

0080193e <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80193e:	55                   	push   %ebp
  80193f:	89 e5                	mov    %esp,%ebp
  801941:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801944:	83 ec 04             	sub    $0x4,%esp
  801947:	68 7b 2b 80 00       	push   $0x802b7b
  80194c:	6a 2f                	push   $0x2f
  80194e:	68 6f 2b 80 00       	push   $0x802b6f
  801953:	e8 88 ef ff ff       	call   8008e0 <_panic>

00801958 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801958:	55                   	push   %ebp
  801959:	89 e5                	mov    %esp,%ebp
  80195b:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80195e:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801965:	8b 55 08             	mov    0x8(%ebp),%edx
  801968:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80196b:	01 d0                	add    %edx,%eax
  80196d:	48                   	dec    %eax
  80196e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801971:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801974:	ba 00 00 00 00       	mov    $0x0,%edx
  801979:	f7 75 ec             	divl   -0x14(%ebp)
  80197c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80197f:	29 d0                	sub    %edx,%eax
  801981:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801984:	8b 45 08             	mov    0x8(%ebp),%eax
  801987:	c1 e8 0c             	shr    $0xc,%eax
  80198a:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80198d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801994:	e9 c8 00 00 00       	jmp    801a61 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801999:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019a0:	eb 27                	jmp    8019c9 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8019a2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019a8:	01 c2                	add    %eax,%edx
  8019aa:	89 d0                	mov    %edx,%eax
  8019ac:	01 c0                	add    %eax,%eax
  8019ae:	01 d0                	add    %edx,%eax
  8019b0:	c1 e0 02             	shl    $0x2,%eax
  8019b3:	05 48 30 80 00       	add    $0x803048,%eax
  8019b8:	8b 00                	mov    (%eax),%eax
  8019ba:	85 c0                	test   %eax,%eax
  8019bc:	74 08                	je     8019c6 <malloc+0x6e>
            	i += j;
  8019be:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019c1:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8019c4:	eb 0b                	jmp    8019d1 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8019c6:	ff 45 f0             	incl   -0x10(%ebp)
  8019c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019cc:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019cf:	72 d1                	jb     8019a2 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8019d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019d4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019d7:	0f 85 81 00 00 00    	jne    801a5e <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8019dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019e0:	05 00 00 08 00       	add    $0x80000,%eax
  8019e5:	c1 e0 0c             	shl    $0xc,%eax
  8019e8:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8019eb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019f2:	eb 1f                	jmp    801a13 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8019f4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019fa:	01 c2                	add    %eax,%edx
  8019fc:	89 d0                	mov    %edx,%eax
  8019fe:	01 c0                	add    %eax,%eax
  801a00:	01 d0                	add    %edx,%eax
  801a02:	c1 e0 02             	shl    $0x2,%eax
  801a05:	05 48 30 80 00       	add    $0x803048,%eax
  801a0a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801a10:	ff 45 f0             	incl   -0x10(%ebp)
  801a13:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a16:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a19:	72 d9                	jb     8019f4 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801a1b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a1e:	89 d0                	mov    %edx,%eax
  801a20:	01 c0                	add    %eax,%eax
  801a22:	01 d0                	add    %edx,%eax
  801a24:	c1 e0 02             	shl    $0x2,%eax
  801a27:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801a2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a30:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801a32:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a35:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801a38:	89 c8                	mov    %ecx,%eax
  801a3a:	01 c0                	add    %eax,%eax
  801a3c:	01 c8                	add    %ecx,%eax
  801a3e:	c1 e0 02             	shl    $0x2,%eax
  801a41:	05 44 30 80 00       	add    $0x803044,%eax
  801a46:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801a48:	83 ec 08             	sub    $0x8,%esp
  801a4b:	ff 75 08             	pushl  0x8(%ebp)
  801a4e:	ff 75 e0             	pushl  -0x20(%ebp)
  801a51:	e8 2b 03 00 00       	call   801d81 <sys_allocateMem>
  801a56:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801a59:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a5c:	eb 19                	jmp    801a77 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801a5e:	ff 45 f4             	incl   -0xc(%ebp)
  801a61:	a1 04 30 80 00       	mov    0x803004,%eax
  801a66:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801a69:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a6c:	0f 83 27 ff ff ff    	jae    801999 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801a72:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a77:	c9                   	leave  
  801a78:	c3                   	ret    

00801a79 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801a79:	55                   	push   %ebp
  801a7a:	89 e5                	mov    %esp,%ebp
  801a7c:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801a7f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801a83:	0f 84 e5 00 00 00    	je     801b6e <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801a89:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801a8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a92:	05 00 00 00 80       	add    $0x80000000,%eax
  801a97:	c1 e8 0c             	shr    $0xc,%eax
  801a9a:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801a9d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801aa0:	89 d0                	mov    %edx,%eax
  801aa2:	01 c0                	add    %eax,%eax
  801aa4:	01 d0                	add    %edx,%eax
  801aa6:	c1 e0 02             	shl    $0x2,%eax
  801aa9:	05 40 30 80 00       	add    $0x803040,%eax
  801aae:	8b 00                	mov    (%eax),%eax
  801ab0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ab3:	0f 85 b8 00 00 00    	jne    801b71 <free+0xf8>
  801ab9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801abc:	89 d0                	mov    %edx,%eax
  801abe:	01 c0                	add    %eax,%eax
  801ac0:	01 d0                	add    %edx,%eax
  801ac2:	c1 e0 02             	shl    $0x2,%eax
  801ac5:	05 48 30 80 00       	add    $0x803048,%eax
  801aca:	8b 00                	mov    (%eax),%eax
  801acc:	85 c0                	test   %eax,%eax
  801ace:	0f 84 9d 00 00 00    	je     801b71 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801ad4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ad7:	89 d0                	mov    %edx,%eax
  801ad9:	01 c0                	add    %eax,%eax
  801adb:	01 d0                	add    %edx,%eax
  801add:	c1 e0 02             	shl    $0x2,%eax
  801ae0:	05 44 30 80 00       	add    $0x803044,%eax
  801ae5:	8b 00                	mov    (%eax),%eax
  801ae7:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801aea:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801aed:	c1 e0 0c             	shl    $0xc,%eax
  801af0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801af3:	83 ec 08             	sub    $0x8,%esp
  801af6:	ff 75 e4             	pushl  -0x1c(%ebp)
  801af9:	ff 75 f0             	pushl  -0x10(%ebp)
  801afc:	e8 64 02 00 00       	call   801d65 <sys_freeMem>
  801b01:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801b04:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b0b:	eb 57                	jmp    801b64 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801b0d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b10:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b13:	01 c2                	add    %eax,%edx
  801b15:	89 d0                	mov    %edx,%eax
  801b17:	01 c0                	add    %eax,%eax
  801b19:	01 d0                	add    %edx,%eax
  801b1b:	c1 e0 02             	shl    $0x2,%eax
  801b1e:	05 48 30 80 00       	add    $0x803048,%eax
  801b23:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801b29:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b2f:	01 c2                	add    %eax,%edx
  801b31:	89 d0                	mov    %edx,%eax
  801b33:	01 c0                	add    %eax,%eax
  801b35:	01 d0                	add    %edx,%eax
  801b37:	c1 e0 02             	shl    $0x2,%eax
  801b3a:	05 40 30 80 00       	add    $0x803040,%eax
  801b3f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801b45:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b48:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b4b:	01 c2                	add    %eax,%edx
  801b4d:	89 d0                	mov    %edx,%eax
  801b4f:	01 c0                	add    %eax,%eax
  801b51:	01 d0                	add    %edx,%eax
  801b53:	c1 e0 02             	shl    $0x2,%eax
  801b56:	05 44 30 80 00       	add    $0x803044,%eax
  801b5b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801b61:	ff 45 f4             	incl   -0xc(%ebp)
  801b64:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b67:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b6a:	7c a1                	jl     801b0d <free+0x94>
  801b6c:	eb 04                	jmp    801b72 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801b6e:	90                   	nop
  801b6f:	eb 01                	jmp    801b72 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801b71:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801b72:	c9                   	leave  
  801b73:	c3                   	ret    

00801b74 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801b74:	55                   	push   %ebp
  801b75:	89 e5                	mov    %esp,%ebp
  801b77:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801b7a:	83 ec 04             	sub    $0x4,%esp
  801b7d:	68 98 2b 80 00       	push   $0x802b98
  801b82:	68 ae 00 00 00       	push   $0xae
  801b87:	68 6f 2b 80 00       	push   $0x802b6f
  801b8c:	e8 4f ed ff ff       	call   8008e0 <_panic>

00801b91 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801b91:	55                   	push   %ebp
  801b92:	89 e5                	mov    %esp,%ebp
  801b94:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801b97:	83 ec 04             	sub    $0x4,%esp
  801b9a:	68 b8 2b 80 00       	push   $0x802bb8
  801b9f:	68 ca 00 00 00       	push   $0xca
  801ba4:	68 6f 2b 80 00       	push   $0x802b6f
  801ba9:	e8 32 ed ff ff       	call   8008e0 <_panic>

00801bae <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801bae:	55                   	push   %ebp
  801baf:	89 e5                	mov    %esp,%ebp
  801bb1:	57                   	push   %edi
  801bb2:	56                   	push   %esi
  801bb3:	53                   	push   %ebx
  801bb4:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bba:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bbd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bc0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bc3:	8b 7d 18             	mov    0x18(%ebp),%edi
  801bc6:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801bc9:	cd 30                	int    $0x30
  801bcb:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801bce:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801bd1:	83 c4 10             	add    $0x10,%esp
  801bd4:	5b                   	pop    %ebx
  801bd5:	5e                   	pop    %esi
  801bd6:	5f                   	pop    %edi
  801bd7:	5d                   	pop    %ebp
  801bd8:	c3                   	ret    

00801bd9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801bd9:	55                   	push   %ebp
  801bda:	89 e5                	mov    %esp,%ebp
  801bdc:	83 ec 04             	sub    $0x4,%esp
  801bdf:	8b 45 10             	mov    0x10(%ebp),%eax
  801be2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801be5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801be9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bec:	6a 00                	push   $0x0
  801bee:	6a 00                	push   $0x0
  801bf0:	52                   	push   %edx
  801bf1:	ff 75 0c             	pushl  0xc(%ebp)
  801bf4:	50                   	push   %eax
  801bf5:	6a 00                	push   $0x0
  801bf7:	e8 b2 ff ff ff       	call   801bae <syscall>
  801bfc:	83 c4 18             	add    $0x18,%esp
}
  801bff:	90                   	nop
  801c00:	c9                   	leave  
  801c01:	c3                   	ret    

00801c02 <sys_cgetc>:

int
sys_cgetc(void)
{
  801c02:	55                   	push   %ebp
  801c03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 00                	push   $0x0
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 01                	push   $0x1
  801c11:	e8 98 ff ff ff       	call   801bae <syscall>
  801c16:	83 c4 18             	add    $0x18,%esp
}
  801c19:	c9                   	leave  
  801c1a:	c3                   	ret    

00801c1b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c1b:	55                   	push   %ebp
  801c1c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	50                   	push   %eax
  801c2a:	6a 05                	push   $0x5
  801c2c:	e8 7d ff ff ff       	call   801bae <syscall>
  801c31:	83 c4 18             	add    $0x18,%esp
}
  801c34:	c9                   	leave  
  801c35:	c3                   	ret    

00801c36 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c36:	55                   	push   %ebp
  801c37:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 00                	push   $0x0
  801c43:	6a 02                	push   $0x2
  801c45:	e8 64 ff ff ff       	call   801bae <syscall>
  801c4a:	83 c4 18             	add    $0x18,%esp
}
  801c4d:	c9                   	leave  
  801c4e:	c3                   	ret    

00801c4f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c4f:	55                   	push   %ebp
  801c50:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 03                	push   $0x3
  801c5e:	e8 4b ff ff ff       	call   801bae <syscall>
  801c63:	83 c4 18             	add    $0x18,%esp
}
  801c66:	c9                   	leave  
  801c67:	c3                   	ret    

00801c68 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c68:	55                   	push   %ebp
  801c69:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 04                	push   $0x4
  801c77:	e8 32 ff ff ff       	call   801bae <syscall>
  801c7c:	83 c4 18             	add    $0x18,%esp
}
  801c7f:	c9                   	leave  
  801c80:	c3                   	ret    

00801c81 <sys_env_exit>:


void sys_env_exit(void)
{
  801c81:	55                   	push   %ebp
  801c82:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c84:	6a 00                	push   $0x0
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 06                	push   $0x6
  801c90:	e8 19 ff ff ff       	call   801bae <syscall>
  801c95:	83 c4 18             	add    $0x18,%esp
}
  801c98:	90                   	nop
  801c99:	c9                   	leave  
  801c9a:	c3                   	ret    

00801c9b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c9b:	55                   	push   %ebp
  801c9c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	52                   	push   %edx
  801cab:	50                   	push   %eax
  801cac:	6a 07                	push   $0x7
  801cae:	e8 fb fe ff ff       	call   801bae <syscall>
  801cb3:	83 c4 18             	add    $0x18,%esp
}
  801cb6:	c9                   	leave  
  801cb7:	c3                   	ret    

00801cb8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801cb8:	55                   	push   %ebp
  801cb9:	89 e5                	mov    %esp,%ebp
  801cbb:	56                   	push   %esi
  801cbc:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801cbd:	8b 75 18             	mov    0x18(%ebp),%esi
  801cc0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cc3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cc6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ccc:	56                   	push   %esi
  801ccd:	53                   	push   %ebx
  801cce:	51                   	push   %ecx
  801ccf:	52                   	push   %edx
  801cd0:	50                   	push   %eax
  801cd1:	6a 08                	push   $0x8
  801cd3:	e8 d6 fe ff ff       	call   801bae <syscall>
  801cd8:	83 c4 18             	add    $0x18,%esp
}
  801cdb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801cde:	5b                   	pop    %ebx
  801cdf:	5e                   	pop    %esi
  801ce0:	5d                   	pop    %ebp
  801ce1:	c3                   	ret    

00801ce2 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ce2:	55                   	push   %ebp
  801ce3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801ce5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	52                   	push   %edx
  801cf2:	50                   	push   %eax
  801cf3:	6a 09                	push   $0x9
  801cf5:	e8 b4 fe ff ff       	call   801bae <syscall>
  801cfa:	83 c4 18             	add    $0x18,%esp
}
  801cfd:	c9                   	leave  
  801cfe:	c3                   	ret    

00801cff <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801cff:	55                   	push   %ebp
  801d00:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	ff 75 0c             	pushl  0xc(%ebp)
  801d0b:	ff 75 08             	pushl  0x8(%ebp)
  801d0e:	6a 0a                	push   $0xa
  801d10:	e8 99 fe ff ff       	call   801bae <syscall>
  801d15:	83 c4 18             	add    $0x18,%esp
}
  801d18:	c9                   	leave  
  801d19:	c3                   	ret    

00801d1a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d1a:	55                   	push   %ebp
  801d1b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	6a 00                	push   $0x0
  801d25:	6a 00                	push   $0x0
  801d27:	6a 0b                	push   $0xb
  801d29:	e8 80 fe ff ff       	call   801bae <syscall>
  801d2e:	83 c4 18             	add    $0x18,%esp
}
  801d31:	c9                   	leave  
  801d32:	c3                   	ret    

00801d33 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d33:	55                   	push   %ebp
  801d34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d36:	6a 00                	push   $0x0
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 0c                	push   $0xc
  801d42:	e8 67 fe ff ff       	call   801bae <syscall>
  801d47:	83 c4 18             	add    $0x18,%esp
}
  801d4a:	c9                   	leave  
  801d4b:	c3                   	ret    

00801d4c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d4c:	55                   	push   %ebp
  801d4d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	6a 00                	push   $0x0
  801d59:	6a 0d                	push   $0xd
  801d5b:	e8 4e fe ff ff       	call   801bae <syscall>
  801d60:	83 c4 18             	add    $0x18,%esp
}
  801d63:	c9                   	leave  
  801d64:	c3                   	ret    

00801d65 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d65:	55                   	push   %ebp
  801d66:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	ff 75 0c             	pushl  0xc(%ebp)
  801d71:	ff 75 08             	pushl  0x8(%ebp)
  801d74:	6a 11                	push   $0x11
  801d76:	e8 33 fe ff ff       	call   801bae <syscall>
  801d7b:	83 c4 18             	add    $0x18,%esp
	return;
  801d7e:	90                   	nop
}
  801d7f:	c9                   	leave  
  801d80:	c3                   	ret    

00801d81 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d81:	55                   	push   %ebp
  801d82:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d84:	6a 00                	push   $0x0
  801d86:	6a 00                	push   $0x0
  801d88:	6a 00                	push   $0x0
  801d8a:	ff 75 0c             	pushl  0xc(%ebp)
  801d8d:	ff 75 08             	pushl  0x8(%ebp)
  801d90:	6a 12                	push   $0x12
  801d92:	e8 17 fe ff ff       	call   801bae <syscall>
  801d97:	83 c4 18             	add    $0x18,%esp
	return ;
  801d9a:	90                   	nop
}
  801d9b:	c9                   	leave  
  801d9c:	c3                   	ret    

00801d9d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d9d:	55                   	push   %ebp
  801d9e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 0e                	push   $0xe
  801dac:	e8 fd fd ff ff       	call   801bae <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
}
  801db4:	c9                   	leave  
  801db5:	c3                   	ret    

00801db6 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801db6:	55                   	push   %ebp
  801db7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	ff 75 08             	pushl  0x8(%ebp)
  801dc4:	6a 0f                	push   $0xf
  801dc6:	e8 e3 fd ff ff       	call   801bae <syscall>
  801dcb:	83 c4 18             	add    $0x18,%esp
}
  801dce:	c9                   	leave  
  801dcf:	c3                   	ret    

00801dd0 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801dd0:	55                   	push   %ebp
  801dd1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 10                	push   $0x10
  801ddf:	e8 ca fd ff ff       	call   801bae <syscall>
  801de4:	83 c4 18             	add    $0x18,%esp
}
  801de7:	90                   	nop
  801de8:	c9                   	leave  
  801de9:	c3                   	ret    

00801dea <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801dea:	55                   	push   %ebp
  801deb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 14                	push   $0x14
  801df9:	e8 b0 fd ff ff       	call   801bae <syscall>
  801dfe:	83 c4 18             	add    $0x18,%esp
}
  801e01:	90                   	nop
  801e02:	c9                   	leave  
  801e03:	c3                   	ret    

00801e04 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e04:	55                   	push   %ebp
  801e05:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e07:	6a 00                	push   $0x0
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 15                	push   $0x15
  801e13:	e8 96 fd ff ff       	call   801bae <syscall>
  801e18:	83 c4 18             	add    $0x18,%esp
}
  801e1b:	90                   	nop
  801e1c:	c9                   	leave  
  801e1d:	c3                   	ret    

00801e1e <sys_cputc>:


void
sys_cputc(const char c)
{
  801e1e:	55                   	push   %ebp
  801e1f:	89 e5                	mov    %esp,%ebp
  801e21:	83 ec 04             	sub    $0x4,%esp
  801e24:	8b 45 08             	mov    0x8(%ebp),%eax
  801e27:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e2a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	50                   	push   %eax
  801e37:	6a 16                	push   $0x16
  801e39:	e8 70 fd ff ff       	call   801bae <syscall>
  801e3e:	83 c4 18             	add    $0x18,%esp
}
  801e41:	90                   	nop
  801e42:	c9                   	leave  
  801e43:	c3                   	ret    

00801e44 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e44:	55                   	push   %ebp
  801e45:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 17                	push   $0x17
  801e53:	e8 56 fd ff ff       	call   801bae <syscall>
  801e58:	83 c4 18             	add    $0x18,%esp
}
  801e5b:	90                   	nop
  801e5c:	c9                   	leave  
  801e5d:	c3                   	ret    

00801e5e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e5e:	55                   	push   %ebp
  801e5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e61:	8b 45 08             	mov    0x8(%ebp),%eax
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 00                	push   $0x0
  801e6a:	ff 75 0c             	pushl  0xc(%ebp)
  801e6d:	50                   	push   %eax
  801e6e:	6a 18                	push   $0x18
  801e70:	e8 39 fd ff ff       	call   801bae <syscall>
  801e75:	83 c4 18             	add    $0x18,%esp
}
  801e78:	c9                   	leave  
  801e79:	c3                   	ret    

00801e7a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e7a:	55                   	push   %ebp
  801e7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e80:	8b 45 08             	mov    0x8(%ebp),%eax
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	52                   	push   %edx
  801e8a:	50                   	push   %eax
  801e8b:	6a 1b                	push   $0x1b
  801e8d:	e8 1c fd ff ff       	call   801bae <syscall>
  801e92:	83 c4 18             	add    $0x18,%esp
}
  801e95:	c9                   	leave  
  801e96:	c3                   	ret    

00801e97 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e97:	55                   	push   %ebp
  801e98:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 00                	push   $0x0
  801ea6:	52                   	push   %edx
  801ea7:	50                   	push   %eax
  801ea8:	6a 19                	push   $0x19
  801eaa:	e8 ff fc ff ff       	call   801bae <syscall>
  801eaf:	83 c4 18             	add    $0x18,%esp
}
  801eb2:	90                   	nop
  801eb3:	c9                   	leave  
  801eb4:	c3                   	ret    

00801eb5 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801eb5:	55                   	push   %ebp
  801eb6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801eb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	52                   	push   %edx
  801ec5:	50                   	push   %eax
  801ec6:	6a 1a                	push   $0x1a
  801ec8:	e8 e1 fc ff ff       	call   801bae <syscall>
  801ecd:	83 c4 18             	add    $0x18,%esp
}
  801ed0:	90                   	nop
  801ed1:	c9                   	leave  
  801ed2:	c3                   	ret    

00801ed3 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ed3:	55                   	push   %ebp
  801ed4:	89 e5                	mov    %esp,%ebp
  801ed6:	83 ec 04             	sub    $0x4,%esp
  801ed9:	8b 45 10             	mov    0x10(%ebp),%eax
  801edc:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801edf:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ee2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ee6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee9:	6a 00                	push   $0x0
  801eeb:	51                   	push   %ecx
  801eec:	52                   	push   %edx
  801eed:	ff 75 0c             	pushl  0xc(%ebp)
  801ef0:	50                   	push   %eax
  801ef1:	6a 1c                	push   $0x1c
  801ef3:	e8 b6 fc ff ff       	call   801bae <syscall>
  801ef8:	83 c4 18             	add    $0x18,%esp
}
  801efb:	c9                   	leave  
  801efc:	c3                   	ret    

00801efd <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801efd:	55                   	push   %ebp
  801efe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f00:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f03:	8b 45 08             	mov    0x8(%ebp),%eax
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 00                	push   $0x0
  801f0c:	52                   	push   %edx
  801f0d:	50                   	push   %eax
  801f0e:	6a 1d                	push   $0x1d
  801f10:	e8 99 fc ff ff       	call   801bae <syscall>
  801f15:	83 c4 18             	add    $0x18,%esp
}
  801f18:	c9                   	leave  
  801f19:	c3                   	ret    

00801f1a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f1a:	55                   	push   %ebp
  801f1b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f1d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f20:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f23:	8b 45 08             	mov    0x8(%ebp),%eax
  801f26:	6a 00                	push   $0x0
  801f28:	6a 00                	push   $0x0
  801f2a:	51                   	push   %ecx
  801f2b:	52                   	push   %edx
  801f2c:	50                   	push   %eax
  801f2d:	6a 1e                	push   $0x1e
  801f2f:	e8 7a fc ff ff       	call   801bae <syscall>
  801f34:	83 c4 18             	add    $0x18,%esp
}
  801f37:	c9                   	leave  
  801f38:	c3                   	ret    

00801f39 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f39:	55                   	push   %ebp
  801f3a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f42:	6a 00                	push   $0x0
  801f44:	6a 00                	push   $0x0
  801f46:	6a 00                	push   $0x0
  801f48:	52                   	push   %edx
  801f49:	50                   	push   %eax
  801f4a:	6a 1f                	push   $0x1f
  801f4c:	e8 5d fc ff ff       	call   801bae <syscall>
  801f51:	83 c4 18             	add    $0x18,%esp
}
  801f54:	c9                   	leave  
  801f55:	c3                   	ret    

00801f56 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f56:	55                   	push   %ebp
  801f57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 00                	push   $0x0
  801f5f:	6a 00                	push   $0x0
  801f61:	6a 00                	push   $0x0
  801f63:	6a 20                	push   $0x20
  801f65:	e8 44 fc ff ff       	call   801bae <syscall>
  801f6a:	83 c4 18             	add    $0x18,%esp
}
  801f6d:	c9                   	leave  
  801f6e:	c3                   	ret    

00801f6f <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801f6f:	55                   	push   %ebp
  801f70:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801f72:	8b 45 08             	mov    0x8(%ebp),%eax
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	ff 75 10             	pushl  0x10(%ebp)
  801f7c:	ff 75 0c             	pushl  0xc(%ebp)
  801f7f:	50                   	push   %eax
  801f80:	6a 21                	push   $0x21
  801f82:	e8 27 fc ff ff       	call   801bae <syscall>
  801f87:	83 c4 18             	add    $0x18,%esp
}
  801f8a:	c9                   	leave  
  801f8b:	c3                   	ret    

00801f8c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801f8c:	55                   	push   %ebp
  801f8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	50                   	push   %eax
  801f9b:	6a 22                	push   $0x22
  801f9d:	e8 0c fc ff ff       	call   801bae <syscall>
  801fa2:	83 c4 18             	add    $0x18,%esp
}
  801fa5:	90                   	nop
  801fa6:	c9                   	leave  
  801fa7:	c3                   	ret    

00801fa8 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801fa8:	55                   	push   %ebp
  801fa9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801fab:	8b 45 08             	mov    0x8(%ebp),%eax
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	50                   	push   %eax
  801fb7:	6a 23                	push   $0x23
  801fb9:	e8 f0 fb ff ff       	call   801bae <syscall>
  801fbe:	83 c4 18             	add    $0x18,%esp
}
  801fc1:	90                   	nop
  801fc2:	c9                   	leave  
  801fc3:	c3                   	ret    

00801fc4 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801fc4:	55                   	push   %ebp
  801fc5:	89 e5                	mov    %esp,%ebp
  801fc7:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801fca:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fcd:	8d 50 04             	lea    0x4(%eax),%edx
  801fd0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	52                   	push   %edx
  801fda:	50                   	push   %eax
  801fdb:	6a 24                	push   $0x24
  801fdd:	e8 cc fb ff ff       	call   801bae <syscall>
  801fe2:	83 c4 18             	add    $0x18,%esp
	return result;
  801fe5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801fe8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801feb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801fee:	89 01                	mov    %eax,(%ecx)
  801ff0:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff6:	c9                   	leave  
  801ff7:	c2 04 00             	ret    $0x4

00801ffa <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ffa:	55                   	push   %ebp
  801ffb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	ff 75 10             	pushl  0x10(%ebp)
  802004:	ff 75 0c             	pushl  0xc(%ebp)
  802007:	ff 75 08             	pushl  0x8(%ebp)
  80200a:	6a 13                	push   $0x13
  80200c:	e8 9d fb ff ff       	call   801bae <syscall>
  802011:	83 c4 18             	add    $0x18,%esp
	return ;
  802014:	90                   	nop
}
  802015:	c9                   	leave  
  802016:	c3                   	ret    

00802017 <sys_rcr2>:
uint32 sys_rcr2()
{
  802017:	55                   	push   %ebp
  802018:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 25                	push   $0x25
  802026:	e8 83 fb ff ff       	call   801bae <syscall>
  80202b:	83 c4 18             	add    $0x18,%esp
}
  80202e:	c9                   	leave  
  80202f:	c3                   	ret    

00802030 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802030:	55                   	push   %ebp
  802031:	89 e5                	mov    %esp,%ebp
  802033:	83 ec 04             	sub    $0x4,%esp
  802036:	8b 45 08             	mov    0x8(%ebp),%eax
  802039:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80203c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802040:	6a 00                	push   $0x0
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	50                   	push   %eax
  802049:	6a 26                	push   $0x26
  80204b:	e8 5e fb ff ff       	call   801bae <syscall>
  802050:	83 c4 18             	add    $0x18,%esp
	return ;
  802053:	90                   	nop
}
  802054:	c9                   	leave  
  802055:	c3                   	ret    

00802056 <rsttst>:
void rsttst()
{
  802056:	55                   	push   %ebp
  802057:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802059:	6a 00                	push   $0x0
  80205b:	6a 00                	push   $0x0
  80205d:	6a 00                	push   $0x0
  80205f:	6a 00                	push   $0x0
  802061:	6a 00                	push   $0x0
  802063:	6a 28                	push   $0x28
  802065:	e8 44 fb ff ff       	call   801bae <syscall>
  80206a:	83 c4 18             	add    $0x18,%esp
	return ;
  80206d:	90                   	nop
}
  80206e:	c9                   	leave  
  80206f:	c3                   	ret    

00802070 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802070:	55                   	push   %ebp
  802071:	89 e5                	mov    %esp,%ebp
  802073:	83 ec 04             	sub    $0x4,%esp
  802076:	8b 45 14             	mov    0x14(%ebp),%eax
  802079:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80207c:	8b 55 18             	mov    0x18(%ebp),%edx
  80207f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802083:	52                   	push   %edx
  802084:	50                   	push   %eax
  802085:	ff 75 10             	pushl  0x10(%ebp)
  802088:	ff 75 0c             	pushl  0xc(%ebp)
  80208b:	ff 75 08             	pushl  0x8(%ebp)
  80208e:	6a 27                	push   $0x27
  802090:	e8 19 fb ff ff       	call   801bae <syscall>
  802095:	83 c4 18             	add    $0x18,%esp
	return ;
  802098:	90                   	nop
}
  802099:	c9                   	leave  
  80209a:	c3                   	ret    

0080209b <chktst>:
void chktst(uint32 n)
{
  80209b:	55                   	push   %ebp
  80209c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 00                	push   $0x0
  8020a6:	ff 75 08             	pushl  0x8(%ebp)
  8020a9:	6a 29                	push   $0x29
  8020ab:	e8 fe fa ff ff       	call   801bae <syscall>
  8020b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8020b3:	90                   	nop
}
  8020b4:	c9                   	leave  
  8020b5:	c3                   	ret    

008020b6 <inctst>:

void inctst()
{
  8020b6:	55                   	push   %ebp
  8020b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	6a 00                	push   $0x0
  8020c3:	6a 2a                	push   $0x2a
  8020c5:	e8 e4 fa ff ff       	call   801bae <syscall>
  8020ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8020cd:	90                   	nop
}
  8020ce:	c9                   	leave  
  8020cf:	c3                   	ret    

008020d0 <gettst>:
uint32 gettst()
{
  8020d0:	55                   	push   %ebp
  8020d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 00                	push   $0x0
  8020db:	6a 00                	push   $0x0
  8020dd:	6a 2b                	push   $0x2b
  8020df:	e8 ca fa ff ff       	call   801bae <syscall>
  8020e4:	83 c4 18             	add    $0x18,%esp
}
  8020e7:	c9                   	leave  
  8020e8:	c3                   	ret    

008020e9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8020e9:	55                   	push   %ebp
  8020ea:	89 e5                	mov    %esp,%ebp
  8020ec:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 00                	push   $0x0
  8020f3:	6a 00                	push   $0x0
  8020f5:	6a 00                	push   $0x0
  8020f7:	6a 00                	push   $0x0
  8020f9:	6a 2c                	push   $0x2c
  8020fb:	e8 ae fa ff ff       	call   801bae <syscall>
  802100:	83 c4 18             	add    $0x18,%esp
  802103:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802106:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80210a:	75 07                	jne    802113 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80210c:	b8 01 00 00 00       	mov    $0x1,%eax
  802111:	eb 05                	jmp    802118 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802113:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802118:	c9                   	leave  
  802119:	c3                   	ret    

0080211a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80211a:	55                   	push   %ebp
  80211b:	89 e5                	mov    %esp,%ebp
  80211d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	6a 00                	push   $0x0
  802126:	6a 00                	push   $0x0
  802128:	6a 00                	push   $0x0
  80212a:	6a 2c                	push   $0x2c
  80212c:	e8 7d fa ff ff       	call   801bae <syscall>
  802131:	83 c4 18             	add    $0x18,%esp
  802134:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802137:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80213b:	75 07                	jne    802144 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80213d:	b8 01 00 00 00       	mov    $0x1,%eax
  802142:	eb 05                	jmp    802149 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802144:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802149:	c9                   	leave  
  80214a:	c3                   	ret    

0080214b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80214b:	55                   	push   %ebp
  80214c:	89 e5                	mov    %esp,%ebp
  80214e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802151:	6a 00                	push   $0x0
  802153:	6a 00                	push   $0x0
  802155:	6a 00                	push   $0x0
  802157:	6a 00                	push   $0x0
  802159:	6a 00                	push   $0x0
  80215b:	6a 2c                	push   $0x2c
  80215d:	e8 4c fa ff ff       	call   801bae <syscall>
  802162:	83 c4 18             	add    $0x18,%esp
  802165:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802168:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80216c:	75 07                	jne    802175 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80216e:	b8 01 00 00 00       	mov    $0x1,%eax
  802173:	eb 05                	jmp    80217a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802175:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80217a:	c9                   	leave  
  80217b:	c3                   	ret    

0080217c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80217c:	55                   	push   %ebp
  80217d:	89 e5                	mov    %esp,%ebp
  80217f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802182:	6a 00                	push   $0x0
  802184:	6a 00                	push   $0x0
  802186:	6a 00                	push   $0x0
  802188:	6a 00                	push   $0x0
  80218a:	6a 00                	push   $0x0
  80218c:	6a 2c                	push   $0x2c
  80218e:	e8 1b fa ff ff       	call   801bae <syscall>
  802193:	83 c4 18             	add    $0x18,%esp
  802196:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802199:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80219d:	75 07                	jne    8021a6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80219f:	b8 01 00 00 00       	mov    $0x1,%eax
  8021a4:	eb 05                	jmp    8021ab <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8021a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021ab:	c9                   	leave  
  8021ac:	c3                   	ret    

008021ad <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8021ad:	55                   	push   %ebp
  8021ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021b0:	6a 00                	push   $0x0
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 00                	push   $0x0
  8021b8:	ff 75 08             	pushl  0x8(%ebp)
  8021bb:	6a 2d                	push   $0x2d
  8021bd:	e8 ec f9 ff ff       	call   801bae <syscall>
  8021c2:	83 c4 18             	add    $0x18,%esp
	return ;
  8021c5:	90                   	nop
}
  8021c6:	c9                   	leave  
  8021c7:	c3                   	ret    

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
