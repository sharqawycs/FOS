
obj/user/ef_mergesort_noleakage:     file format elf32-i386


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
  800031:	e8 81 07 00 00       	call   8007b7 <libmain>
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
  800041:	e8 7d 1d 00 00       	call   801dc3 <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 20 24 80 00       	push   $0x802420
  80004e:	e8 1a 0b 00 00       	call   800b6d <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 22 24 80 00       	push   $0x802422
  80005e:	e8 0a 0b 00 00       	call   800b6d <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 38 24 80 00       	push   $0x802438
  80006e:	e8 fa 0a 00 00       	call   800b6d <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 22 24 80 00       	push   $0x802422
  80007e:	e8 ea 0a 00 00       	call   800b6d <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 20 24 80 00       	push   $0x802420
  80008e:	e8 da 0a 00 00       	call   800b6d <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		//readline("Enter the number of elements: ", Line);
		cprintf("Enter the number of elements: ");
  800096:	83 ec 0c             	sub    $0xc,%esp
  800099:	68 50 24 80 00       	push   $0x802450
  80009e:	e8 ca 0a 00 00       	call   800b6d <cprintf>
  8000a3:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = 2000 ;
  8000a6:	c7 45 f0 d0 07 00 00 	movl   $0x7d0,-0x10(%ebp)
		cprintf("%d\n", NumOfElements) ;
  8000ad:	83 ec 08             	sub    $0x8,%esp
  8000b0:	ff 75 f0             	pushl  -0x10(%ebp)
  8000b3:	68 6f 24 80 00       	push   $0x80246f
  8000b8:	e8 b0 0a 00 00       	call   800b6d <cprintf>
  8000bd:	83 c4 10             	add    $0x10,%esp

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c3:	c1 e0 02             	shl    $0x2,%eax
  8000c6:	83 ec 0c             	sub    $0xc,%esp
  8000c9:	50                   	push   %eax
  8000ca:	e8 62 18 00 00       	call   801931 <malloc>
  8000cf:	83 c4 10             	add    $0x10,%esp
  8000d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000d5:	83 ec 0c             	sub    $0xc,%esp
  8000d8:	68 74 24 80 00       	push   $0x802474
  8000dd:	e8 8b 0a 00 00       	call   800b6d <cprintf>
  8000e2:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	68 96 24 80 00       	push   $0x802496
  8000ed:	e8 7b 0a 00 00       	call   800b6d <cprintf>
  8000f2:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000f5:	83 ec 0c             	sub    $0xc,%esp
  8000f8:	68 a4 24 80 00       	push   $0x8024a4
  8000fd:	e8 6b 0a 00 00       	call   800b6d <cprintf>
  800102:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800105:	83 ec 0c             	sub    $0xc,%esp
  800108:	68 b3 24 80 00       	push   $0x8024b3
  80010d:	e8 5b 0a 00 00       	call   800b6d <cprintf>
  800112:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800115:	83 ec 0c             	sub    $0xc,%esp
  800118:	68 c3 24 80 00       	push   $0x8024c3
  80011d:	e8 4b 0a 00 00       	call   800b6d <cprintf>
  800122:	83 c4 10             	add    $0x10,%esp
			//Chose = getchar() ;
			Chose = 'a';
  800125:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
			cputchar(Chose);
  800129:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80012d:	83 ec 0c             	sub    $0xc,%esp
  800130:	50                   	push   %eax
  800131:	e8 e1 05 00 00       	call   800717 <cputchar>
  800136:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800139:	83 ec 0c             	sub    $0xc,%esp
  80013c:	6a 0a                	push   $0xa
  80013e:	e8 d4 05 00 00       	call   800717 <cputchar>
  800143:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800146:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80014a:	74 0c                	je     800158 <_main+0x120>
  80014c:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800150:	74 06                	je     800158 <_main+0x120>
  800152:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800156:	75 bd                	jne    800115 <_main+0xdd>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800158:	e8 80 1c 00 00       	call   801ddd <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  80015d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800161:	83 f8 62             	cmp    $0x62,%eax
  800164:	74 1d                	je     800183 <_main+0x14b>
  800166:	83 f8 63             	cmp    $0x63,%eax
  800169:	74 2b                	je     800196 <_main+0x15e>
  80016b:	83 f8 61             	cmp    $0x61,%eax
  80016e:	75 39                	jne    8001a9 <_main+0x171>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800170:	83 ec 08             	sub    $0x8,%esp
  800173:	ff 75 f0             	pushl  -0x10(%ebp)
  800176:	ff 75 ec             	pushl  -0x14(%ebp)
  800179:	e8 f0 01 00 00       	call   80036e <InitializeAscending>
  80017e:	83 c4 10             	add    $0x10,%esp
			break ;
  800181:	eb 37                	jmp    8001ba <_main+0x182>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  800183:	83 ec 08             	sub    $0x8,%esp
  800186:	ff 75 f0             	pushl  -0x10(%ebp)
  800189:	ff 75 ec             	pushl  -0x14(%ebp)
  80018c:	e8 0e 02 00 00       	call   80039f <InitializeDescending>
  800191:	83 c4 10             	add    $0x10,%esp
			break ;
  800194:	eb 24                	jmp    8001ba <_main+0x182>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800196:	83 ec 08             	sub    $0x8,%esp
  800199:	ff 75 f0             	pushl  -0x10(%ebp)
  80019c:	ff 75 ec             	pushl  -0x14(%ebp)
  80019f:	e8 30 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001a4:	83 c4 10             	add    $0x10,%esp
			break ;
  8001a7:	eb 11                	jmp    8001ba <_main+0x182>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001a9:	83 ec 08             	sub    $0x8,%esp
  8001ac:	ff 75 f0             	pushl  -0x10(%ebp)
  8001af:	ff 75 ec             	pushl  -0x14(%ebp)
  8001b2:	e8 1d 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001b7:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001ba:	83 ec 04             	sub    $0x4,%esp
  8001bd:	ff 75 f0             	pushl  -0x10(%ebp)
  8001c0:	6a 01                	push   $0x1
  8001c2:	ff 75 ec             	pushl  -0x14(%ebp)
  8001c5:	e8 dc 02 00 00       	call   8004a6 <MSort>
  8001ca:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001cd:	e8 f1 1b 00 00       	call   801dc3 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001d2:	83 ec 0c             	sub    $0xc,%esp
  8001d5:	68 cc 24 80 00       	push   $0x8024cc
  8001da:	e8 8e 09 00 00       	call   800b6d <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001e2:	e8 f6 1b 00 00       	call   801ddd <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001e7:	83 ec 08             	sub    $0x8,%esp
  8001ea:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ed:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f0:	e8 cf 00 00 00       	call   8002c4 <CheckSorted>
  8001f5:	83 c4 10             	add    $0x10,%esp
  8001f8:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001fb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8001ff:	75 14                	jne    800215 <_main+0x1dd>
  800201:	83 ec 04             	sub    $0x4,%esp
  800204:	68 00 25 80 00       	push   $0x802500
  800209:	6a 4e                	push   $0x4e
  80020b:	68 22 25 80 00       	push   $0x802522
  800210:	e8 a4 06 00 00       	call   8008b9 <_panic>
		else
		{
			sys_disable_interrupt();
  800215:	e8 a9 1b 00 00       	call   801dc3 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  80021a:	83 ec 0c             	sub    $0xc,%esp
  80021d:	68 40 25 80 00       	push   $0x802540
  800222:	e8 46 09 00 00       	call   800b6d <cprintf>
  800227:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80022a:	83 ec 0c             	sub    $0xc,%esp
  80022d:	68 74 25 80 00       	push   $0x802574
  800232:	e8 36 09 00 00       	call   800b6d <cprintf>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 a8 25 80 00       	push   $0x8025a8
  800242:	e8 26 09 00 00       	call   800b6d <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80024a:	e8 8e 1b 00 00       	call   801ddd <sys_enable_interrupt>
		}

		free(Elements) ;
  80024f:	83 ec 0c             	sub    $0xc,%esp
  800252:	ff 75 ec             	pushl  -0x14(%ebp)
  800255:	e8 f8 17 00 00       	call   801a52 <free>
  80025a:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  80025d:	e8 61 1b 00 00       	call   801dc3 <sys_disable_interrupt>
			Chose = 0 ;
  800262:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800266:	eb 3e                	jmp    8002a6 <_main+0x26e>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800268:	83 ec 0c             	sub    $0xc,%esp
  80026b:	68 da 25 80 00       	push   $0x8025da
  800270:	e8 f8 08 00 00       	call   800b6d <cprintf>
  800275:	83 c4 10             	add    $0x10,%esp
				Chose = 'n' ;
  800278:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
				cputchar(Chose);
  80027c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	50                   	push   %eax
  800284:	e8 8e 04 00 00       	call   800717 <cputchar>
  800289:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	6a 0a                	push   $0xa
  800291:	e8 81 04 00 00       	call   800717 <cputchar>
  800296:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	6a 0a                	push   $0xa
  80029e:	e8 74 04 00 00       	call   800717 <cputchar>
  8002a3:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a6:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002aa:	74 06                	je     8002b2 <_main+0x27a>
  8002ac:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002b0:	75 b6                	jne    800268 <_main+0x230>
				Chose = 'n' ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002b2:	e8 26 1b 00 00       	call   801ddd <sys_enable_interrupt>

	} while (Chose == 'y');
  8002b7:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002bb:	0f 84 80 fd ff ff    	je     800041 <_main+0x9>
}
  8002c1:	90                   	nop
  8002c2:	c9                   	leave  
  8002c3:	c3                   	ret    

008002c4 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002c4:	55                   	push   %ebp
  8002c5:	89 e5                	mov    %esp,%ebp
  8002c7:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002d8:	eb 33                	jmp    80030d <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	01 d0                	add    %edx,%eax
  8002e9:	8b 10                	mov    (%eax),%edx
  8002eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002ee:	40                   	inc    %eax
  8002ef:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 c8                	add    %ecx,%eax
  8002fb:	8b 00                	mov    (%eax),%eax
  8002fd:	39 c2                	cmp    %eax,%edx
  8002ff:	7e 09                	jle    80030a <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800301:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800308:	eb 0c                	jmp    800316 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80030a:	ff 45 f8             	incl   -0x8(%ebp)
  80030d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800310:	48                   	dec    %eax
  800311:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800314:	7f c4                	jg     8002da <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800316:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800319:	c9                   	leave  
  80031a:	c3                   	ret    

0080031b <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80031b:	55                   	push   %ebp
  80031c:	89 e5                	mov    %esp,%ebp
  80031e:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800321:	8b 45 0c             	mov    0xc(%ebp),%eax
  800324:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032b:	8b 45 08             	mov    0x8(%ebp),%eax
  80032e:	01 d0                	add    %edx,%eax
  800330:	8b 00                	mov    (%eax),%eax
  800332:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800335:	8b 45 0c             	mov    0xc(%ebp),%eax
  800338:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033f:	8b 45 08             	mov    0x8(%ebp),%eax
  800342:	01 c2                	add    %eax,%edx
  800344:	8b 45 10             	mov    0x10(%ebp),%eax
  800347:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034e:	8b 45 08             	mov    0x8(%ebp),%eax
  800351:	01 c8                	add    %ecx,%eax
  800353:	8b 00                	mov    (%eax),%eax
  800355:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800357:	8b 45 10             	mov    0x10(%ebp),%eax
  80035a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800361:	8b 45 08             	mov    0x8(%ebp),%eax
  800364:	01 c2                	add    %eax,%edx
  800366:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800369:	89 02                	mov    %eax,(%edx)
}
  80036b:	90                   	nop
  80036c:	c9                   	leave  
  80036d:	c3                   	ret    

0080036e <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80036e:	55                   	push   %ebp
  80036f:	89 e5                	mov    %esp,%ebp
  800371:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800374:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80037b:	eb 17                	jmp    800394 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80037d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800380:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800387:	8b 45 08             	mov    0x8(%ebp),%eax
  80038a:	01 c2                	add    %eax,%edx
  80038c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038f:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800391:	ff 45 fc             	incl   -0x4(%ebp)
  800394:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800397:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80039a:	7c e1                	jl     80037d <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80039c:	90                   	nop
  80039d:	c9                   	leave  
  80039e:	c3                   	ret    

0080039f <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80039f:	55                   	push   %ebp
  8003a0:	89 e5                	mov    %esp,%ebp
  8003a2:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ac:	eb 1b                	jmp    8003c9 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bb:	01 c2                	add    %eax,%edx
  8003bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c0:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003c3:	48                   	dec    %eax
  8003c4:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003c6:	ff 45 fc             	incl   -0x4(%ebp)
  8003c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003cc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003cf:	7c dd                	jl     8003ae <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003d1:	90                   	nop
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
  8003d7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003da:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003dd:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003e2:	f7 e9                	imul   %ecx
  8003e4:	c1 f9 1f             	sar    $0x1f,%ecx
  8003e7:	89 d0                	mov    %edx,%eax
  8003e9:	29 c8                	sub    %ecx,%eax
  8003eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003f5:	eb 1e                	jmp    800415 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8003f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800407:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040a:	99                   	cltd   
  80040b:	f7 7d f8             	idivl  -0x8(%ebp)
  80040e:	89 d0                	mov    %edx,%eax
  800410:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800412:	ff 45 fc             	incl   -0x4(%ebp)
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80041b:	7c da                	jl     8003f7 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80041d:	90                   	nop
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800426:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80042d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800434:	eb 42                	jmp    800478 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800436:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800439:	99                   	cltd   
  80043a:	f7 7d f0             	idivl  -0x10(%ebp)
  80043d:	89 d0                	mov    %edx,%eax
  80043f:	85 c0                	test   %eax,%eax
  800441:	75 10                	jne    800453 <PrintElements+0x33>
			cprintf("\n");
  800443:	83 ec 0c             	sub    $0xc,%esp
  800446:	68 20 24 80 00       	push   $0x802420
  80044b:	e8 1d 07 00 00       	call   800b6d <cprintf>
  800450:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800453:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800456:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 d0                	add    %edx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	83 ec 08             	sub    $0x8,%esp
  800467:	50                   	push   %eax
  800468:	68 f8 25 80 00       	push   $0x8025f8
  80046d:	e8 fb 06 00 00       	call   800b6d <cprintf>
  800472:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800475:	ff 45 f4             	incl   -0xc(%ebp)
  800478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047b:	48                   	dec    %eax
  80047c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80047f:	7f b5                	jg     800436 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800481:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800484:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	01 d0                	add    %edx,%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	83 ec 08             	sub    $0x8,%esp
  800495:	50                   	push   %eax
  800496:	68 6f 24 80 00       	push   $0x80246f
  80049b:	e8 cd 06 00 00       	call   800b6d <cprintf>
  8004a0:	83 c4 10             	add    $0x10,%esp

}
  8004a3:	90                   	nop
  8004a4:	c9                   	leave  
  8004a5:	c3                   	ret    

008004a6 <MSort>:


void MSort(int* A, int p, int r)
{
  8004a6:	55                   	push   %ebp
  8004a7:	89 e5                	mov    %esp,%ebp
  8004a9:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004af:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004b2:	7d 54                	jge    800508 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ba:	01 d0                	add    %edx,%eax
  8004bc:	89 c2                	mov    %eax,%edx
  8004be:	c1 ea 1f             	shr    $0x1f,%edx
  8004c1:	01 d0                	add    %edx,%eax
  8004c3:	d1 f8                	sar    %eax
  8004c5:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004c8:	83 ec 04             	sub    $0x4,%esp
  8004cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ce:	ff 75 0c             	pushl  0xc(%ebp)
  8004d1:	ff 75 08             	pushl  0x8(%ebp)
  8004d4:	e8 cd ff ff ff       	call   8004a6 <MSort>
  8004d9:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004df:	40                   	inc    %eax
  8004e0:	83 ec 04             	sub    $0x4,%esp
  8004e3:	ff 75 10             	pushl  0x10(%ebp)
  8004e6:	50                   	push   %eax
  8004e7:	ff 75 08             	pushl  0x8(%ebp)
  8004ea:	e8 b7 ff ff ff       	call   8004a6 <MSort>
  8004ef:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  8004f2:	ff 75 10             	pushl  0x10(%ebp)
  8004f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f8:	ff 75 0c             	pushl  0xc(%ebp)
  8004fb:	ff 75 08             	pushl  0x8(%ebp)
  8004fe:	e8 08 00 00 00       	call   80050b <Merge>
  800503:	83 c4 10             	add    $0x10,%esp
  800506:	eb 01                	jmp    800509 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800508:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800509:	c9                   	leave  
  80050a:	c3                   	ret    

0080050b <Merge>:

void Merge(int* A, int p, int q, int r)
{
  80050b:	55                   	push   %ebp
  80050c:	89 e5                	mov    %esp,%ebp
  80050e:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800511:	8b 45 10             	mov    0x10(%ebp),%eax
  800514:	2b 45 0c             	sub    0xc(%ebp),%eax
  800517:	40                   	inc    %eax
  800518:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80051b:	8b 45 14             	mov    0x14(%ebp),%eax
  80051e:	2b 45 10             	sub    0x10(%ebp),%eax
  800521:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800524:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80052b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800532:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800535:	c1 e0 02             	shl    $0x2,%eax
  800538:	83 ec 0c             	sub    $0xc,%esp
  80053b:	50                   	push   %eax
  80053c:	e8 f0 13 00 00       	call   801931 <malloc>
  800541:	83 c4 10             	add    $0x10,%esp
  800544:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800547:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80054a:	c1 e0 02             	shl    $0x2,%eax
  80054d:	83 ec 0c             	sub    $0xc,%esp
  800550:	50                   	push   %eax
  800551:	e8 db 13 00 00       	call   801931 <malloc>
  800556:	83 c4 10             	add    $0x10,%esp
  800559:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80055c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800563:	eb 2f                	jmp    800594 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800565:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800568:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800572:	01 c2                	add    %eax,%edx
  800574:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800577:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80057a:	01 c8                	add    %ecx,%eax
  80057c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800581:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800588:	8b 45 08             	mov    0x8(%ebp),%eax
  80058b:	01 c8                	add    %ecx,%eax
  80058d:	8b 00                	mov    (%eax),%eax
  80058f:	89 02                	mov    %eax,(%edx)
	int* Left = malloc(sizeof(int) * leftCapacity);

	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800591:	ff 45 ec             	incl   -0x14(%ebp)
  800594:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800597:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80059a:	7c c9                	jl     800565 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80059c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005a3:	eb 2a                	jmp    8005cf <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005af:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005b2:	01 c2                	add    %eax,%edx
  8005b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ba:	01 c8                	add    %ecx,%eax
  8005bc:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c6:	01 c8                	add    %ecx,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005cc:	ff 45 e8             	incl   -0x18(%ebp)
  8005cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005d2:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005d5:	7c ce                	jl     8005a5 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005dd:	e9 0a 01 00 00       	jmp    8006ec <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005e8:	0f 8d 95 00 00 00    	jge    800683 <Merge+0x178>
  8005ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f1:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005f4:	0f 8d 89 00 00 00    	jge    800683 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8005fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800604:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800607:	01 d0                	add    %edx,%eax
  800609:	8b 10                	mov    (%eax),%edx
  80060b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80060e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800615:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800618:	01 c8                	add    %ecx,%eax
  80061a:	8b 00                	mov    (%eax),%eax
  80061c:	39 c2                	cmp    %eax,%edx
  80061e:	7d 33                	jge    800653 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800620:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800623:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800628:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80062f:	8b 45 08             	mov    0x8(%ebp),%eax
  800632:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800635:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800638:	8d 50 01             	lea    0x1(%eax),%edx
  80063b:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80063e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800645:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800648:	01 d0                	add    %edx,%eax
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80064e:	e9 96 00 00 00       	jmp    8006e9 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800653:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800656:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80065b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800662:	8b 45 08             	mov    0x8(%ebp),%eax
  800665:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800668:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80066b:	8d 50 01             	lea    0x1(%eax),%edx
  80066e:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800671:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800678:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80067b:	01 d0                	add    %edx,%eax
  80067d:	8b 00                	mov    (%eax),%eax
  80067f:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800681:	eb 66                	jmp    8006e9 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800683:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800686:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800689:	7d 30                	jge    8006bb <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  80068b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80068e:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800693:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80069a:	8b 45 08             	mov    0x8(%ebp),%eax
  80069d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006a3:	8d 50 01             	lea    0x1(%eax),%edx
  8006a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006a9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006b0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006b3:	01 d0                	add    %edx,%eax
  8006b5:	8b 00                	mov    (%eax),%eax
  8006b7:	89 01                	mov    %eax,(%ecx)
  8006b9:	eb 2e                	jmp    8006e9 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006be:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d3:	8d 50 01             	lea    0x1(%eax),%edx
  8006d6:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e3:	01 d0                	add    %edx,%eax
  8006e5:	8b 00                	mov    (%eax),%eax
  8006e7:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006e9:	ff 45 e4             	incl   -0x1c(%ebp)
  8006ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006ef:	3b 45 14             	cmp    0x14(%ebp),%eax
  8006f2:	0f 8e ea fe ff ff    	jle    8005e2 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

	free(Left);
  8006f8:	83 ec 0c             	sub    $0xc,%esp
  8006fb:	ff 75 d8             	pushl  -0x28(%ebp)
  8006fe:	e8 4f 13 00 00       	call   801a52 <free>
  800703:	83 c4 10             	add    $0x10,%esp
	free(Right);
  800706:	83 ec 0c             	sub    $0xc,%esp
  800709:	ff 75 d4             	pushl  -0x2c(%ebp)
  80070c:	e8 41 13 00 00       	call   801a52 <free>
  800711:	83 c4 10             	add    $0x10,%esp

}
  800714:	90                   	nop
  800715:	c9                   	leave  
  800716:	c3                   	ret    

00800717 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800717:	55                   	push   %ebp
  800718:	89 e5                	mov    %esp,%ebp
  80071a:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800723:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800727:	83 ec 0c             	sub    $0xc,%esp
  80072a:	50                   	push   %eax
  80072b:	e8 c7 16 00 00       	call   801df7 <sys_cputc>
  800730:	83 c4 10             	add    $0x10,%esp
}
  800733:	90                   	nop
  800734:	c9                   	leave  
  800735:	c3                   	ret    

00800736 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800736:	55                   	push   %ebp
  800737:	89 e5                	mov    %esp,%ebp
  800739:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80073c:	e8 82 16 00 00       	call   801dc3 <sys_disable_interrupt>
	char c = ch;
  800741:	8b 45 08             	mov    0x8(%ebp),%eax
  800744:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800747:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80074b:	83 ec 0c             	sub    $0xc,%esp
  80074e:	50                   	push   %eax
  80074f:	e8 a3 16 00 00       	call   801df7 <sys_cputc>
  800754:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800757:	e8 81 16 00 00       	call   801ddd <sys_enable_interrupt>
}
  80075c:	90                   	nop
  80075d:	c9                   	leave  
  80075e:	c3                   	ret    

0080075f <getchar>:

int
getchar(void)
{
  80075f:	55                   	push   %ebp
  800760:	89 e5                	mov    %esp,%ebp
  800762:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800765:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80076c:	eb 08                	jmp    800776 <getchar+0x17>
	{
		c = sys_cgetc();
  80076e:	e8 68 14 00 00       	call   801bdb <sys_cgetc>
  800773:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800776:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80077a:	74 f2                	je     80076e <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80077c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80077f:	c9                   	leave  
  800780:	c3                   	ret    

00800781 <atomic_getchar>:

int
atomic_getchar(void)
{
  800781:	55                   	push   %ebp
  800782:	89 e5                	mov    %esp,%ebp
  800784:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800787:	e8 37 16 00 00       	call   801dc3 <sys_disable_interrupt>
	int c=0;
  80078c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800793:	eb 08                	jmp    80079d <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800795:	e8 41 14 00 00       	call   801bdb <sys_cgetc>
  80079a:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80079d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007a1:	74 f2                	je     800795 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007a3:	e8 35 16 00 00       	call   801ddd <sys_enable_interrupt>
	return c;
  8007a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007ab:	c9                   	leave  
  8007ac:	c3                   	ret    

008007ad <iscons>:

int iscons(int fdnum)
{
  8007ad:	55                   	push   %ebp
  8007ae:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007b0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007b5:	5d                   	pop    %ebp
  8007b6:	c3                   	ret    

008007b7 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007b7:	55                   	push   %ebp
  8007b8:	89 e5                	mov    %esp,%ebp
  8007ba:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007bd:	e8 66 14 00 00       	call   801c28 <sys_getenvindex>
  8007c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007c8:	89 d0                	mov    %edx,%eax
  8007ca:	01 c0                	add    %eax,%eax
  8007cc:	01 d0                	add    %edx,%eax
  8007ce:	c1 e0 02             	shl    $0x2,%eax
  8007d1:	01 d0                	add    %edx,%eax
  8007d3:	c1 e0 06             	shl    $0x6,%eax
  8007d6:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007db:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007e0:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e5:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8007eb:	84 c0                	test   %al,%al
  8007ed:	74 0f                	je     8007fe <libmain+0x47>
		binaryname = myEnv->prog_name;
  8007ef:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f4:	05 f4 02 00 00       	add    $0x2f4,%eax
  8007f9:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007fe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800802:	7e 0a                	jle    80080e <libmain+0x57>
		binaryname = argv[0];
  800804:	8b 45 0c             	mov    0xc(%ebp),%eax
  800807:	8b 00                	mov    (%eax),%eax
  800809:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80080e:	83 ec 08             	sub    $0x8,%esp
  800811:	ff 75 0c             	pushl  0xc(%ebp)
  800814:	ff 75 08             	pushl  0x8(%ebp)
  800817:	e8 1c f8 ff ff       	call   800038 <_main>
  80081c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80081f:	e8 9f 15 00 00       	call   801dc3 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800824:	83 ec 0c             	sub    $0xc,%esp
  800827:	68 18 26 80 00       	push   $0x802618
  80082c:	e8 3c 03 00 00       	call   800b6d <cprintf>
  800831:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800834:	a1 24 30 80 00       	mov    0x803024,%eax
  800839:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80083f:	a1 24 30 80 00       	mov    0x803024,%eax
  800844:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80084a:	83 ec 04             	sub    $0x4,%esp
  80084d:	52                   	push   %edx
  80084e:	50                   	push   %eax
  80084f:	68 40 26 80 00       	push   $0x802640
  800854:	e8 14 03 00 00       	call   800b6d <cprintf>
  800859:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80085c:	a1 24 30 80 00       	mov    0x803024,%eax
  800861:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800867:	83 ec 08             	sub    $0x8,%esp
  80086a:	50                   	push   %eax
  80086b:	68 65 26 80 00       	push   $0x802665
  800870:	e8 f8 02 00 00       	call   800b6d <cprintf>
  800875:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800878:	83 ec 0c             	sub    $0xc,%esp
  80087b:	68 18 26 80 00       	push   $0x802618
  800880:	e8 e8 02 00 00       	call   800b6d <cprintf>
  800885:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800888:	e8 50 15 00 00       	call   801ddd <sys_enable_interrupt>

	// exit gracefully
	exit();
  80088d:	e8 19 00 00 00       	call   8008ab <exit>
}
  800892:	90                   	nop
  800893:	c9                   	leave  
  800894:	c3                   	ret    

00800895 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800895:	55                   	push   %ebp
  800896:	89 e5                	mov    %esp,%ebp
  800898:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80089b:	83 ec 0c             	sub    $0xc,%esp
  80089e:	6a 00                	push   $0x0
  8008a0:	e8 4f 13 00 00       	call   801bf4 <sys_env_destroy>
  8008a5:	83 c4 10             	add    $0x10,%esp
}
  8008a8:	90                   	nop
  8008a9:	c9                   	leave  
  8008aa:	c3                   	ret    

008008ab <exit>:

void
exit(void)
{
  8008ab:	55                   	push   %ebp
  8008ac:	89 e5                	mov    %esp,%ebp
  8008ae:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008b1:	e8 a4 13 00 00       	call   801c5a <sys_env_exit>
}
  8008b6:	90                   	nop
  8008b7:	c9                   	leave  
  8008b8:	c3                   	ret    

008008b9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008b9:	55                   	push   %ebp
  8008ba:	89 e5                	mov    %esp,%ebp
  8008bc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008bf:	8d 45 10             	lea    0x10(%ebp),%eax
  8008c2:	83 c0 04             	add    $0x4,%eax
  8008c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008c8:	a1 34 30 80 00       	mov    0x803034,%eax
  8008cd:	85 c0                	test   %eax,%eax
  8008cf:	74 16                	je     8008e7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008d1:	a1 34 30 80 00       	mov    0x803034,%eax
  8008d6:	83 ec 08             	sub    $0x8,%esp
  8008d9:	50                   	push   %eax
  8008da:	68 7c 26 80 00       	push   $0x80267c
  8008df:	e8 89 02 00 00       	call   800b6d <cprintf>
  8008e4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8008e7:	a1 00 30 80 00       	mov    0x803000,%eax
  8008ec:	ff 75 0c             	pushl  0xc(%ebp)
  8008ef:	ff 75 08             	pushl  0x8(%ebp)
  8008f2:	50                   	push   %eax
  8008f3:	68 81 26 80 00       	push   $0x802681
  8008f8:	e8 70 02 00 00       	call   800b6d <cprintf>
  8008fd:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800900:	8b 45 10             	mov    0x10(%ebp),%eax
  800903:	83 ec 08             	sub    $0x8,%esp
  800906:	ff 75 f4             	pushl  -0xc(%ebp)
  800909:	50                   	push   %eax
  80090a:	e8 f3 01 00 00       	call   800b02 <vcprintf>
  80090f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800912:	83 ec 08             	sub    $0x8,%esp
  800915:	6a 00                	push   $0x0
  800917:	68 9d 26 80 00       	push   $0x80269d
  80091c:	e8 e1 01 00 00       	call   800b02 <vcprintf>
  800921:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800924:	e8 82 ff ff ff       	call   8008ab <exit>

	// should not return here
	while (1) ;
  800929:	eb fe                	jmp    800929 <_panic+0x70>

0080092b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80092b:	55                   	push   %ebp
  80092c:	89 e5                	mov    %esp,%ebp
  80092e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800931:	a1 24 30 80 00       	mov    0x803024,%eax
  800936:	8b 50 74             	mov    0x74(%eax),%edx
  800939:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093c:	39 c2                	cmp    %eax,%edx
  80093e:	74 14                	je     800954 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800940:	83 ec 04             	sub    $0x4,%esp
  800943:	68 a0 26 80 00       	push   $0x8026a0
  800948:	6a 26                	push   $0x26
  80094a:	68 ec 26 80 00       	push   $0x8026ec
  80094f:	e8 65 ff ff ff       	call   8008b9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800954:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80095b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800962:	e9 c2 00 00 00       	jmp    800a29 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800967:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80096a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800971:	8b 45 08             	mov    0x8(%ebp),%eax
  800974:	01 d0                	add    %edx,%eax
  800976:	8b 00                	mov    (%eax),%eax
  800978:	85 c0                	test   %eax,%eax
  80097a:	75 08                	jne    800984 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80097c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80097f:	e9 a2 00 00 00       	jmp    800a26 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800984:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80098b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800992:	eb 69                	jmp    8009fd <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800994:	a1 24 30 80 00       	mov    0x803024,%eax
  800999:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80099f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009a2:	89 d0                	mov    %edx,%eax
  8009a4:	01 c0                	add    %eax,%eax
  8009a6:	01 d0                	add    %edx,%eax
  8009a8:	c1 e0 02             	shl    $0x2,%eax
  8009ab:	01 c8                	add    %ecx,%eax
  8009ad:	8a 40 04             	mov    0x4(%eax),%al
  8009b0:	84 c0                	test   %al,%al
  8009b2:	75 46                	jne    8009fa <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009b4:	a1 24 30 80 00       	mov    0x803024,%eax
  8009b9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009bf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009c2:	89 d0                	mov    %edx,%eax
  8009c4:	01 c0                	add    %eax,%eax
  8009c6:	01 d0                	add    %edx,%eax
  8009c8:	c1 e0 02             	shl    $0x2,%eax
  8009cb:	01 c8                	add    %ecx,%eax
  8009cd:	8b 00                	mov    (%eax),%eax
  8009cf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009d2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009da:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009df:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8009e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e9:	01 c8                	add    %ecx,%eax
  8009eb:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009ed:	39 c2                	cmp    %eax,%edx
  8009ef:	75 09                	jne    8009fa <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8009f1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8009f8:	eb 12                	jmp    800a0c <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009fa:	ff 45 e8             	incl   -0x18(%ebp)
  8009fd:	a1 24 30 80 00       	mov    0x803024,%eax
  800a02:	8b 50 74             	mov    0x74(%eax),%edx
  800a05:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a08:	39 c2                	cmp    %eax,%edx
  800a0a:	77 88                	ja     800994 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a0c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a10:	75 14                	jne    800a26 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800a12:	83 ec 04             	sub    $0x4,%esp
  800a15:	68 f8 26 80 00       	push   $0x8026f8
  800a1a:	6a 3a                	push   $0x3a
  800a1c:	68 ec 26 80 00       	push   $0x8026ec
  800a21:	e8 93 fe ff ff       	call   8008b9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a26:	ff 45 f0             	incl   -0x10(%ebp)
  800a29:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a2c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a2f:	0f 8c 32 ff ff ff    	jl     800967 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a35:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a3c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a43:	eb 26                	jmp    800a6b <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a45:	a1 24 30 80 00       	mov    0x803024,%eax
  800a4a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800a50:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a53:	89 d0                	mov    %edx,%eax
  800a55:	01 c0                	add    %eax,%eax
  800a57:	01 d0                	add    %edx,%eax
  800a59:	c1 e0 02             	shl    $0x2,%eax
  800a5c:	01 c8                	add    %ecx,%eax
  800a5e:	8a 40 04             	mov    0x4(%eax),%al
  800a61:	3c 01                	cmp    $0x1,%al
  800a63:	75 03                	jne    800a68 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800a65:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a68:	ff 45 e0             	incl   -0x20(%ebp)
  800a6b:	a1 24 30 80 00       	mov    0x803024,%eax
  800a70:	8b 50 74             	mov    0x74(%eax),%edx
  800a73:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a76:	39 c2                	cmp    %eax,%edx
  800a78:	77 cb                	ja     800a45 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a7d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a80:	74 14                	je     800a96 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800a82:	83 ec 04             	sub    $0x4,%esp
  800a85:	68 4c 27 80 00       	push   $0x80274c
  800a8a:	6a 44                	push   $0x44
  800a8c:	68 ec 26 80 00       	push   $0x8026ec
  800a91:	e8 23 fe ff ff       	call   8008b9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a96:	90                   	nop
  800a97:	c9                   	leave  
  800a98:	c3                   	ret    

00800a99 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800a99:	55                   	push   %ebp
  800a9a:	89 e5                	mov    %esp,%ebp
  800a9c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800a9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa2:	8b 00                	mov    (%eax),%eax
  800aa4:	8d 48 01             	lea    0x1(%eax),%ecx
  800aa7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aaa:	89 0a                	mov    %ecx,(%edx)
  800aac:	8b 55 08             	mov    0x8(%ebp),%edx
  800aaf:	88 d1                	mov    %dl,%cl
  800ab1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ab4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ab8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800abb:	8b 00                	mov    (%eax),%eax
  800abd:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ac2:	75 2c                	jne    800af0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ac4:	a0 28 30 80 00       	mov    0x803028,%al
  800ac9:	0f b6 c0             	movzbl %al,%eax
  800acc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800acf:	8b 12                	mov    (%edx),%edx
  800ad1:	89 d1                	mov    %edx,%ecx
  800ad3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ad6:	83 c2 08             	add    $0x8,%edx
  800ad9:	83 ec 04             	sub    $0x4,%esp
  800adc:	50                   	push   %eax
  800add:	51                   	push   %ecx
  800ade:	52                   	push   %edx
  800adf:	e8 ce 10 00 00       	call   801bb2 <sys_cputs>
  800ae4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800ae7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aea:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800af0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af3:	8b 40 04             	mov    0x4(%eax),%eax
  800af6:	8d 50 01             	lea    0x1(%eax),%edx
  800af9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afc:	89 50 04             	mov    %edx,0x4(%eax)
}
  800aff:	90                   	nop
  800b00:	c9                   	leave  
  800b01:	c3                   	ret    

00800b02 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b02:	55                   	push   %ebp
  800b03:	89 e5                	mov    %esp,%ebp
  800b05:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b0b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b12:	00 00 00 
	b.cnt = 0;
  800b15:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b1c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b1f:	ff 75 0c             	pushl  0xc(%ebp)
  800b22:	ff 75 08             	pushl  0x8(%ebp)
  800b25:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b2b:	50                   	push   %eax
  800b2c:	68 99 0a 80 00       	push   $0x800a99
  800b31:	e8 11 02 00 00       	call   800d47 <vprintfmt>
  800b36:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b39:	a0 28 30 80 00       	mov    0x803028,%al
  800b3e:	0f b6 c0             	movzbl %al,%eax
  800b41:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b47:	83 ec 04             	sub    $0x4,%esp
  800b4a:	50                   	push   %eax
  800b4b:	52                   	push   %edx
  800b4c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b52:	83 c0 08             	add    $0x8,%eax
  800b55:	50                   	push   %eax
  800b56:	e8 57 10 00 00       	call   801bb2 <sys_cputs>
  800b5b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b5e:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b65:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b6b:	c9                   	leave  
  800b6c:	c3                   	ret    

00800b6d <cprintf>:

int cprintf(const char *fmt, ...) {
  800b6d:	55                   	push   %ebp
  800b6e:	89 e5                	mov    %esp,%ebp
  800b70:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b73:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800b7a:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b7d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b80:	8b 45 08             	mov    0x8(%ebp),%eax
  800b83:	83 ec 08             	sub    $0x8,%esp
  800b86:	ff 75 f4             	pushl  -0xc(%ebp)
  800b89:	50                   	push   %eax
  800b8a:	e8 73 ff ff ff       	call   800b02 <vcprintf>
  800b8f:	83 c4 10             	add    $0x10,%esp
  800b92:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b95:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b98:	c9                   	leave  
  800b99:	c3                   	ret    

00800b9a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800b9a:	55                   	push   %ebp
  800b9b:	89 e5                	mov    %esp,%ebp
  800b9d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ba0:	e8 1e 12 00 00       	call   801dc3 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800ba5:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ba8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bab:	8b 45 08             	mov    0x8(%ebp),%eax
  800bae:	83 ec 08             	sub    $0x8,%esp
  800bb1:	ff 75 f4             	pushl  -0xc(%ebp)
  800bb4:	50                   	push   %eax
  800bb5:	e8 48 ff ff ff       	call   800b02 <vcprintf>
  800bba:	83 c4 10             	add    $0x10,%esp
  800bbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bc0:	e8 18 12 00 00       	call   801ddd <sys_enable_interrupt>
	return cnt;
  800bc5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bc8:	c9                   	leave  
  800bc9:	c3                   	ret    

00800bca <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bca:	55                   	push   %ebp
  800bcb:	89 e5                	mov    %esp,%ebp
  800bcd:	53                   	push   %ebx
  800bce:	83 ec 14             	sub    $0x14,%esp
  800bd1:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd7:	8b 45 14             	mov    0x14(%ebp),%eax
  800bda:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bdd:	8b 45 18             	mov    0x18(%ebp),%eax
  800be0:	ba 00 00 00 00       	mov    $0x0,%edx
  800be5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800be8:	77 55                	ja     800c3f <printnum+0x75>
  800bea:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bed:	72 05                	jb     800bf4 <printnum+0x2a>
  800bef:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bf2:	77 4b                	ja     800c3f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800bf4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800bf7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800bfa:	8b 45 18             	mov    0x18(%ebp),%eax
  800bfd:	ba 00 00 00 00       	mov    $0x0,%edx
  800c02:	52                   	push   %edx
  800c03:	50                   	push   %eax
  800c04:	ff 75 f4             	pushl  -0xc(%ebp)
  800c07:	ff 75 f0             	pushl  -0x10(%ebp)
  800c0a:	e8 95 15 00 00       	call   8021a4 <__udivdi3>
  800c0f:	83 c4 10             	add    $0x10,%esp
  800c12:	83 ec 04             	sub    $0x4,%esp
  800c15:	ff 75 20             	pushl  0x20(%ebp)
  800c18:	53                   	push   %ebx
  800c19:	ff 75 18             	pushl  0x18(%ebp)
  800c1c:	52                   	push   %edx
  800c1d:	50                   	push   %eax
  800c1e:	ff 75 0c             	pushl  0xc(%ebp)
  800c21:	ff 75 08             	pushl  0x8(%ebp)
  800c24:	e8 a1 ff ff ff       	call   800bca <printnum>
  800c29:	83 c4 20             	add    $0x20,%esp
  800c2c:	eb 1a                	jmp    800c48 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c2e:	83 ec 08             	sub    $0x8,%esp
  800c31:	ff 75 0c             	pushl  0xc(%ebp)
  800c34:	ff 75 20             	pushl  0x20(%ebp)
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	ff d0                	call   *%eax
  800c3c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c3f:	ff 4d 1c             	decl   0x1c(%ebp)
  800c42:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c46:	7f e6                	jg     800c2e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c48:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c4b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c50:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c53:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c56:	53                   	push   %ebx
  800c57:	51                   	push   %ecx
  800c58:	52                   	push   %edx
  800c59:	50                   	push   %eax
  800c5a:	e8 55 16 00 00       	call   8022b4 <__umoddi3>
  800c5f:	83 c4 10             	add    $0x10,%esp
  800c62:	05 b4 29 80 00       	add    $0x8029b4,%eax
  800c67:	8a 00                	mov    (%eax),%al
  800c69:	0f be c0             	movsbl %al,%eax
  800c6c:	83 ec 08             	sub    $0x8,%esp
  800c6f:	ff 75 0c             	pushl  0xc(%ebp)
  800c72:	50                   	push   %eax
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	ff d0                	call   *%eax
  800c78:	83 c4 10             	add    $0x10,%esp
}
  800c7b:	90                   	nop
  800c7c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c7f:	c9                   	leave  
  800c80:	c3                   	ret    

00800c81 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c81:	55                   	push   %ebp
  800c82:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c84:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c88:	7e 1c                	jle    800ca6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	8b 00                	mov    (%eax),%eax
  800c8f:	8d 50 08             	lea    0x8(%eax),%edx
  800c92:	8b 45 08             	mov    0x8(%ebp),%eax
  800c95:	89 10                	mov    %edx,(%eax)
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	8b 00                	mov    (%eax),%eax
  800c9c:	83 e8 08             	sub    $0x8,%eax
  800c9f:	8b 50 04             	mov    0x4(%eax),%edx
  800ca2:	8b 00                	mov    (%eax),%eax
  800ca4:	eb 40                	jmp    800ce6 <getuint+0x65>
	else if (lflag)
  800ca6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800caa:	74 1e                	je     800cca <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	8b 00                	mov    (%eax),%eax
  800cb1:	8d 50 04             	lea    0x4(%eax),%edx
  800cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb7:	89 10                	mov    %edx,(%eax)
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbc:	8b 00                	mov    (%eax),%eax
  800cbe:	83 e8 04             	sub    $0x4,%eax
  800cc1:	8b 00                	mov    (%eax),%eax
  800cc3:	ba 00 00 00 00       	mov    $0x0,%edx
  800cc8:	eb 1c                	jmp    800ce6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccd:	8b 00                	mov    (%eax),%eax
  800ccf:	8d 50 04             	lea    0x4(%eax),%edx
  800cd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd5:	89 10                	mov    %edx,(%eax)
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	8b 00                	mov    (%eax),%eax
  800cdc:	83 e8 04             	sub    $0x4,%eax
  800cdf:	8b 00                	mov    (%eax),%eax
  800ce1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800ce6:	5d                   	pop    %ebp
  800ce7:	c3                   	ret    

00800ce8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800ce8:	55                   	push   %ebp
  800ce9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ceb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cef:	7e 1c                	jle    800d0d <getint+0x25>
		return va_arg(*ap, long long);
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	8b 00                	mov    (%eax),%eax
  800cf6:	8d 50 08             	lea    0x8(%eax),%edx
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	89 10                	mov    %edx,(%eax)
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	8b 00                	mov    (%eax),%eax
  800d03:	83 e8 08             	sub    $0x8,%eax
  800d06:	8b 50 04             	mov    0x4(%eax),%edx
  800d09:	8b 00                	mov    (%eax),%eax
  800d0b:	eb 38                	jmp    800d45 <getint+0x5d>
	else if (lflag)
  800d0d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d11:	74 1a                	je     800d2d <getint+0x45>
		return va_arg(*ap, long);
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8b 00                	mov    (%eax),%eax
  800d18:	8d 50 04             	lea    0x4(%eax),%edx
  800d1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1e:	89 10                	mov    %edx,(%eax)
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	8b 00                	mov    (%eax),%eax
  800d25:	83 e8 04             	sub    $0x4,%eax
  800d28:	8b 00                	mov    (%eax),%eax
  800d2a:	99                   	cltd   
  800d2b:	eb 18                	jmp    800d45 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	8b 00                	mov    (%eax),%eax
  800d32:	8d 50 04             	lea    0x4(%eax),%edx
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	89 10                	mov    %edx,(%eax)
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	8b 00                	mov    (%eax),%eax
  800d3f:	83 e8 04             	sub    $0x4,%eax
  800d42:	8b 00                	mov    (%eax),%eax
  800d44:	99                   	cltd   
}
  800d45:	5d                   	pop    %ebp
  800d46:	c3                   	ret    

00800d47 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d47:	55                   	push   %ebp
  800d48:	89 e5                	mov    %esp,%ebp
  800d4a:	56                   	push   %esi
  800d4b:	53                   	push   %ebx
  800d4c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d4f:	eb 17                	jmp    800d68 <vprintfmt+0x21>
			if (ch == '\0')
  800d51:	85 db                	test   %ebx,%ebx
  800d53:	0f 84 af 03 00 00    	je     801108 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d59:	83 ec 08             	sub    $0x8,%esp
  800d5c:	ff 75 0c             	pushl  0xc(%ebp)
  800d5f:	53                   	push   %ebx
  800d60:	8b 45 08             	mov    0x8(%ebp),%eax
  800d63:	ff d0                	call   *%eax
  800d65:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d68:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6b:	8d 50 01             	lea    0x1(%eax),%edx
  800d6e:	89 55 10             	mov    %edx,0x10(%ebp)
  800d71:	8a 00                	mov    (%eax),%al
  800d73:	0f b6 d8             	movzbl %al,%ebx
  800d76:	83 fb 25             	cmp    $0x25,%ebx
  800d79:	75 d6                	jne    800d51 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d7b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d7f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d86:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d8d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800d94:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800d9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d9e:	8d 50 01             	lea    0x1(%eax),%edx
  800da1:	89 55 10             	mov    %edx,0x10(%ebp)
  800da4:	8a 00                	mov    (%eax),%al
  800da6:	0f b6 d8             	movzbl %al,%ebx
  800da9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dac:	83 f8 55             	cmp    $0x55,%eax
  800daf:	0f 87 2b 03 00 00    	ja     8010e0 <vprintfmt+0x399>
  800db5:	8b 04 85 d8 29 80 00 	mov    0x8029d8(,%eax,4),%eax
  800dbc:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dbe:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dc2:	eb d7                	jmp    800d9b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800dc4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800dc8:	eb d1                	jmp    800d9b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dca:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800dd1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800dd4:	89 d0                	mov    %edx,%eax
  800dd6:	c1 e0 02             	shl    $0x2,%eax
  800dd9:	01 d0                	add    %edx,%eax
  800ddb:	01 c0                	add    %eax,%eax
  800ddd:	01 d8                	add    %ebx,%eax
  800ddf:	83 e8 30             	sub    $0x30,%eax
  800de2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800de5:	8b 45 10             	mov    0x10(%ebp),%eax
  800de8:	8a 00                	mov    (%eax),%al
  800dea:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ded:	83 fb 2f             	cmp    $0x2f,%ebx
  800df0:	7e 3e                	jle    800e30 <vprintfmt+0xe9>
  800df2:	83 fb 39             	cmp    $0x39,%ebx
  800df5:	7f 39                	jg     800e30 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800df7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800dfa:	eb d5                	jmp    800dd1 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800dfc:	8b 45 14             	mov    0x14(%ebp),%eax
  800dff:	83 c0 04             	add    $0x4,%eax
  800e02:	89 45 14             	mov    %eax,0x14(%ebp)
  800e05:	8b 45 14             	mov    0x14(%ebp),%eax
  800e08:	83 e8 04             	sub    $0x4,%eax
  800e0b:	8b 00                	mov    (%eax),%eax
  800e0d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e10:	eb 1f                	jmp    800e31 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e12:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e16:	79 83                	jns    800d9b <vprintfmt+0x54>
				width = 0;
  800e18:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e1f:	e9 77 ff ff ff       	jmp    800d9b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e24:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e2b:	e9 6b ff ff ff       	jmp    800d9b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e30:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e31:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e35:	0f 89 60 ff ff ff    	jns    800d9b <vprintfmt+0x54>
				width = precision, precision = -1;
  800e3b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e3e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e41:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e48:	e9 4e ff ff ff       	jmp    800d9b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e4d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e50:	e9 46 ff ff ff       	jmp    800d9b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e55:	8b 45 14             	mov    0x14(%ebp),%eax
  800e58:	83 c0 04             	add    $0x4,%eax
  800e5b:	89 45 14             	mov    %eax,0x14(%ebp)
  800e5e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e61:	83 e8 04             	sub    $0x4,%eax
  800e64:	8b 00                	mov    (%eax),%eax
  800e66:	83 ec 08             	sub    $0x8,%esp
  800e69:	ff 75 0c             	pushl  0xc(%ebp)
  800e6c:	50                   	push   %eax
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	ff d0                	call   *%eax
  800e72:	83 c4 10             	add    $0x10,%esp
			break;
  800e75:	e9 89 02 00 00       	jmp    801103 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e7d:	83 c0 04             	add    $0x4,%eax
  800e80:	89 45 14             	mov    %eax,0x14(%ebp)
  800e83:	8b 45 14             	mov    0x14(%ebp),%eax
  800e86:	83 e8 04             	sub    $0x4,%eax
  800e89:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e8b:	85 db                	test   %ebx,%ebx
  800e8d:	79 02                	jns    800e91 <vprintfmt+0x14a>
				err = -err;
  800e8f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e91:	83 fb 64             	cmp    $0x64,%ebx
  800e94:	7f 0b                	jg     800ea1 <vprintfmt+0x15a>
  800e96:	8b 34 9d 20 28 80 00 	mov    0x802820(,%ebx,4),%esi
  800e9d:	85 f6                	test   %esi,%esi
  800e9f:	75 19                	jne    800eba <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ea1:	53                   	push   %ebx
  800ea2:	68 c5 29 80 00       	push   $0x8029c5
  800ea7:	ff 75 0c             	pushl  0xc(%ebp)
  800eaa:	ff 75 08             	pushl  0x8(%ebp)
  800ead:	e8 5e 02 00 00       	call   801110 <printfmt>
  800eb2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800eb5:	e9 49 02 00 00       	jmp    801103 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800eba:	56                   	push   %esi
  800ebb:	68 ce 29 80 00       	push   $0x8029ce
  800ec0:	ff 75 0c             	pushl  0xc(%ebp)
  800ec3:	ff 75 08             	pushl  0x8(%ebp)
  800ec6:	e8 45 02 00 00       	call   801110 <printfmt>
  800ecb:	83 c4 10             	add    $0x10,%esp
			break;
  800ece:	e9 30 02 00 00       	jmp    801103 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ed3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed6:	83 c0 04             	add    $0x4,%eax
  800ed9:	89 45 14             	mov    %eax,0x14(%ebp)
  800edc:	8b 45 14             	mov    0x14(%ebp),%eax
  800edf:	83 e8 04             	sub    $0x4,%eax
  800ee2:	8b 30                	mov    (%eax),%esi
  800ee4:	85 f6                	test   %esi,%esi
  800ee6:	75 05                	jne    800eed <vprintfmt+0x1a6>
				p = "(null)";
  800ee8:	be d1 29 80 00       	mov    $0x8029d1,%esi
			if (width > 0 && padc != '-')
  800eed:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ef1:	7e 6d                	jle    800f60 <vprintfmt+0x219>
  800ef3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ef7:	74 67                	je     800f60 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800ef9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800efc:	83 ec 08             	sub    $0x8,%esp
  800eff:	50                   	push   %eax
  800f00:	56                   	push   %esi
  800f01:	e8 0c 03 00 00       	call   801212 <strnlen>
  800f06:	83 c4 10             	add    $0x10,%esp
  800f09:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f0c:	eb 16                	jmp    800f24 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f0e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f12:	83 ec 08             	sub    $0x8,%esp
  800f15:	ff 75 0c             	pushl  0xc(%ebp)
  800f18:	50                   	push   %eax
  800f19:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1c:	ff d0                	call   *%eax
  800f1e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f21:	ff 4d e4             	decl   -0x1c(%ebp)
  800f24:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f28:	7f e4                	jg     800f0e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f2a:	eb 34                	jmp    800f60 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f2c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f30:	74 1c                	je     800f4e <vprintfmt+0x207>
  800f32:	83 fb 1f             	cmp    $0x1f,%ebx
  800f35:	7e 05                	jle    800f3c <vprintfmt+0x1f5>
  800f37:	83 fb 7e             	cmp    $0x7e,%ebx
  800f3a:	7e 12                	jle    800f4e <vprintfmt+0x207>
					putch('?', putdat);
  800f3c:	83 ec 08             	sub    $0x8,%esp
  800f3f:	ff 75 0c             	pushl  0xc(%ebp)
  800f42:	6a 3f                	push   $0x3f
  800f44:	8b 45 08             	mov    0x8(%ebp),%eax
  800f47:	ff d0                	call   *%eax
  800f49:	83 c4 10             	add    $0x10,%esp
  800f4c:	eb 0f                	jmp    800f5d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f4e:	83 ec 08             	sub    $0x8,%esp
  800f51:	ff 75 0c             	pushl  0xc(%ebp)
  800f54:	53                   	push   %ebx
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	ff d0                	call   *%eax
  800f5a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f5d:	ff 4d e4             	decl   -0x1c(%ebp)
  800f60:	89 f0                	mov    %esi,%eax
  800f62:	8d 70 01             	lea    0x1(%eax),%esi
  800f65:	8a 00                	mov    (%eax),%al
  800f67:	0f be d8             	movsbl %al,%ebx
  800f6a:	85 db                	test   %ebx,%ebx
  800f6c:	74 24                	je     800f92 <vprintfmt+0x24b>
  800f6e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f72:	78 b8                	js     800f2c <vprintfmt+0x1e5>
  800f74:	ff 4d e0             	decl   -0x20(%ebp)
  800f77:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f7b:	79 af                	jns    800f2c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f7d:	eb 13                	jmp    800f92 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f7f:	83 ec 08             	sub    $0x8,%esp
  800f82:	ff 75 0c             	pushl  0xc(%ebp)
  800f85:	6a 20                	push   $0x20
  800f87:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8a:	ff d0                	call   *%eax
  800f8c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f8f:	ff 4d e4             	decl   -0x1c(%ebp)
  800f92:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f96:	7f e7                	jg     800f7f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800f98:	e9 66 01 00 00       	jmp    801103 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f9d:	83 ec 08             	sub    $0x8,%esp
  800fa0:	ff 75 e8             	pushl  -0x18(%ebp)
  800fa3:	8d 45 14             	lea    0x14(%ebp),%eax
  800fa6:	50                   	push   %eax
  800fa7:	e8 3c fd ff ff       	call   800ce8 <getint>
  800fac:	83 c4 10             	add    $0x10,%esp
  800faf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fb2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fbb:	85 d2                	test   %edx,%edx
  800fbd:	79 23                	jns    800fe2 <vprintfmt+0x29b>
				putch('-', putdat);
  800fbf:	83 ec 08             	sub    $0x8,%esp
  800fc2:	ff 75 0c             	pushl  0xc(%ebp)
  800fc5:	6a 2d                	push   $0x2d
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	ff d0                	call   *%eax
  800fcc:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fcf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fd2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fd5:	f7 d8                	neg    %eax
  800fd7:	83 d2 00             	adc    $0x0,%edx
  800fda:	f7 da                	neg    %edx
  800fdc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fdf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800fe2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fe9:	e9 bc 00 00 00       	jmp    8010aa <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800fee:	83 ec 08             	sub    $0x8,%esp
  800ff1:	ff 75 e8             	pushl  -0x18(%ebp)
  800ff4:	8d 45 14             	lea    0x14(%ebp),%eax
  800ff7:	50                   	push   %eax
  800ff8:	e8 84 fc ff ff       	call   800c81 <getuint>
  800ffd:	83 c4 10             	add    $0x10,%esp
  801000:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801003:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801006:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80100d:	e9 98 00 00 00       	jmp    8010aa <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801012:	83 ec 08             	sub    $0x8,%esp
  801015:	ff 75 0c             	pushl  0xc(%ebp)
  801018:	6a 58                	push   $0x58
  80101a:	8b 45 08             	mov    0x8(%ebp),%eax
  80101d:	ff d0                	call   *%eax
  80101f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801022:	83 ec 08             	sub    $0x8,%esp
  801025:	ff 75 0c             	pushl  0xc(%ebp)
  801028:	6a 58                	push   $0x58
  80102a:	8b 45 08             	mov    0x8(%ebp),%eax
  80102d:	ff d0                	call   *%eax
  80102f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801032:	83 ec 08             	sub    $0x8,%esp
  801035:	ff 75 0c             	pushl  0xc(%ebp)
  801038:	6a 58                	push   $0x58
  80103a:	8b 45 08             	mov    0x8(%ebp),%eax
  80103d:	ff d0                	call   *%eax
  80103f:	83 c4 10             	add    $0x10,%esp
			break;
  801042:	e9 bc 00 00 00       	jmp    801103 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801047:	83 ec 08             	sub    $0x8,%esp
  80104a:	ff 75 0c             	pushl  0xc(%ebp)
  80104d:	6a 30                	push   $0x30
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
  801052:	ff d0                	call   *%eax
  801054:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801057:	83 ec 08             	sub    $0x8,%esp
  80105a:	ff 75 0c             	pushl  0xc(%ebp)
  80105d:	6a 78                	push   $0x78
  80105f:	8b 45 08             	mov    0x8(%ebp),%eax
  801062:	ff d0                	call   *%eax
  801064:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801067:	8b 45 14             	mov    0x14(%ebp),%eax
  80106a:	83 c0 04             	add    $0x4,%eax
  80106d:	89 45 14             	mov    %eax,0x14(%ebp)
  801070:	8b 45 14             	mov    0x14(%ebp),%eax
  801073:	83 e8 04             	sub    $0x4,%eax
  801076:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801078:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80107b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801082:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801089:	eb 1f                	jmp    8010aa <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80108b:	83 ec 08             	sub    $0x8,%esp
  80108e:	ff 75 e8             	pushl  -0x18(%ebp)
  801091:	8d 45 14             	lea    0x14(%ebp),%eax
  801094:	50                   	push   %eax
  801095:	e8 e7 fb ff ff       	call   800c81 <getuint>
  80109a:	83 c4 10             	add    $0x10,%esp
  80109d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010a0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010a3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010aa:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010b1:	83 ec 04             	sub    $0x4,%esp
  8010b4:	52                   	push   %edx
  8010b5:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010b8:	50                   	push   %eax
  8010b9:	ff 75 f4             	pushl  -0xc(%ebp)
  8010bc:	ff 75 f0             	pushl  -0x10(%ebp)
  8010bf:	ff 75 0c             	pushl  0xc(%ebp)
  8010c2:	ff 75 08             	pushl  0x8(%ebp)
  8010c5:	e8 00 fb ff ff       	call   800bca <printnum>
  8010ca:	83 c4 20             	add    $0x20,%esp
			break;
  8010cd:	eb 34                	jmp    801103 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010cf:	83 ec 08             	sub    $0x8,%esp
  8010d2:	ff 75 0c             	pushl  0xc(%ebp)
  8010d5:	53                   	push   %ebx
  8010d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d9:	ff d0                	call   *%eax
  8010db:	83 c4 10             	add    $0x10,%esp
			break;
  8010de:	eb 23                	jmp    801103 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010e0:	83 ec 08             	sub    $0x8,%esp
  8010e3:	ff 75 0c             	pushl  0xc(%ebp)
  8010e6:	6a 25                	push   $0x25
  8010e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010eb:	ff d0                	call   *%eax
  8010ed:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8010f0:	ff 4d 10             	decl   0x10(%ebp)
  8010f3:	eb 03                	jmp    8010f8 <vprintfmt+0x3b1>
  8010f5:	ff 4d 10             	decl   0x10(%ebp)
  8010f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8010fb:	48                   	dec    %eax
  8010fc:	8a 00                	mov    (%eax),%al
  8010fe:	3c 25                	cmp    $0x25,%al
  801100:	75 f3                	jne    8010f5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801102:	90                   	nop
		}
	}
  801103:	e9 47 fc ff ff       	jmp    800d4f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801108:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801109:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80110c:	5b                   	pop    %ebx
  80110d:	5e                   	pop    %esi
  80110e:	5d                   	pop    %ebp
  80110f:	c3                   	ret    

00801110 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801110:	55                   	push   %ebp
  801111:	89 e5                	mov    %esp,%ebp
  801113:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801116:	8d 45 10             	lea    0x10(%ebp),%eax
  801119:	83 c0 04             	add    $0x4,%eax
  80111c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80111f:	8b 45 10             	mov    0x10(%ebp),%eax
  801122:	ff 75 f4             	pushl  -0xc(%ebp)
  801125:	50                   	push   %eax
  801126:	ff 75 0c             	pushl  0xc(%ebp)
  801129:	ff 75 08             	pushl  0x8(%ebp)
  80112c:	e8 16 fc ff ff       	call   800d47 <vprintfmt>
  801131:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801134:	90                   	nop
  801135:	c9                   	leave  
  801136:	c3                   	ret    

00801137 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801137:	55                   	push   %ebp
  801138:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80113a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113d:	8b 40 08             	mov    0x8(%eax),%eax
  801140:	8d 50 01             	lea    0x1(%eax),%edx
  801143:	8b 45 0c             	mov    0xc(%ebp),%eax
  801146:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801149:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114c:	8b 10                	mov    (%eax),%edx
  80114e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801151:	8b 40 04             	mov    0x4(%eax),%eax
  801154:	39 c2                	cmp    %eax,%edx
  801156:	73 12                	jae    80116a <sprintputch+0x33>
		*b->buf++ = ch;
  801158:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115b:	8b 00                	mov    (%eax),%eax
  80115d:	8d 48 01             	lea    0x1(%eax),%ecx
  801160:	8b 55 0c             	mov    0xc(%ebp),%edx
  801163:	89 0a                	mov    %ecx,(%edx)
  801165:	8b 55 08             	mov    0x8(%ebp),%edx
  801168:	88 10                	mov    %dl,(%eax)
}
  80116a:	90                   	nop
  80116b:	5d                   	pop    %ebp
  80116c:	c3                   	ret    

0080116d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80116d:	55                   	push   %ebp
  80116e:	89 e5                	mov    %esp,%ebp
  801170:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801179:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80117f:	8b 45 08             	mov    0x8(%ebp),%eax
  801182:	01 d0                	add    %edx,%eax
  801184:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801187:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80118e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801192:	74 06                	je     80119a <vsnprintf+0x2d>
  801194:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801198:	7f 07                	jg     8011a1 <vsnprintf+0x34>
		return -E_INVAL;
  80119a:	b8 03 00 00 00       	mov    $0x3,%eax
  80119f:	eb 20                	jmp    8011c1 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011a1:	ff 75 14             	pushl  0x14(%ebp)
  8011a4:	ff 75 10             	pushl  0x10(%ebp)
  8011a7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011aa:	50                   	push   %eax
  8011ab:	68 37 11 80 00       	push   $0x801137
  8011b0:	e8 92 fb ff ff       	call   800d47 <vprintfmt>
  8011b5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011bb:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011be:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011c1:	c9                   	leave  
  8011c2:	c3                   	ret    

008011c3 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011c3:	55                   	push   %ebp
  8011c4:	89 e5                	mov    %esp,%ebp
  8011c6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011c9:	8d 45 10             	lea    0x10(%ebp),%eax
  8011cc:	83 c0 04             	add    $0x4,%eax
  8011cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d5:	ff 75 f4             	pushl  -0xc(%ebp)
  8011d8:	50                   	push   %eax
  8011d9:	ff 75 0c             	pushl  0xc(%ebp)
  8011dc:	ff 75 08             	pushl  0x8(%ebp)
  8011df:	e8 89 ff ff ff       	call   80116d <vsnprintf>
  8011e4:	83 c4 10             	add    $0x10,%esp
  8011e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011ed:	c9                   	leave  
  8011ee:	c3                   	ret    

008011ef <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8011ef:	55                   	push   %ebp
  8011f0:	89 e5                	mov    %esp,%ebp
  8011f2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8011f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011fc:	eb 06                	jmp    801204 <strlen+0x15>
		n++;
  8011fe:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801201:	ff 45 08             	incl   0x8(%ebp)
  801204:	8b 45 08             	mov    0x8(%ebp),%eax
  801207:	8a 00                	mov    (%eax),%al
  801209:	84 c0                	test   %al,%al
  80120b:	75 f1                	jne    8011fe <strlen+0xf>
		n++;
	return n;
  80120d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801210:	c9                   	leave  
  801211:	c3                   	ret    

00801212 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801212:	55                   	push   %ebp
  801213:	89 e5                	mov    %esp,%ebp
  801215:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801218:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80121f:	eb 09                	jmp    80122a <strnlen+0x18>
		n++;
  801221:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801224:	ff 45 08             	incl   0x8(%ebp)
  801227:	ff 4d 0c             	decl   0xc(%ebp)
  80122a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80122e:	74 09                	je     801239 <strnlen+0x27>
  801230:	8b 45 08             	mov    0x8(%ebp),%eax
  801233:	8a 00                	mov    (%eax),%al
  801235:	84 c0                	test   %al,%al
  801237:	75 e8                	jne    801221 <strnlen+0xf>
		n++;
	return n;
  801239:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80123c:	c9                   	leave  
  80123d:	c3                   	ret    

0080123e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80123e:	55                   	push   %ebp
  80123f:	89 e5                	mov    %esp,%ebp
  801241:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801244:	8b 45 08             	mov    0x8(%ebp),%eax
  801247:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80124a:	90                   	nop
  80124b:	8b 45 08             	mov    0x8(%ebp),%eax
  80124e:	8d 50 01             	lea    0x1(%eax),%edx
  801251:	89 55 08             	mov    %edx,0x8(%ebp)
  801254:	8b 55 0c             	mov    0xc(%ebp),%edx
  801257:	8d 4a 01             	lea    0x1(%edx),%ecx
  80125a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80125d:	8a 12                	mov    (%edx),%dl
  80125f:	88 10                	mov    %dl,(%eax)
  801261:	8a 00                	mov    (%eax),%al
  801263:	84 c0                	test   %al,%al
  801265:	75 e4                	jne    80124b <strcpy+0xd>
		/* do nothing */;
	return ret;
  801267:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80126a:	c9                   	leave  
  80126b:	c3                   	ret    

0080126c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80126c:	55                   	push   %ebp
  80126d:	89 e5                	mov    %esp,%ebp
  80126f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801272:	8b 45 08             	mov    0x8(%ebp),%eax
  801275:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801278:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80127f:	eb 1f                	jmp    8012a0 <strncpy+0x34>
		*dst++ = *src;
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	8d 50 01             	lea    0x1(%eax),%edx
  801287:	89 55 08             	mov    %edx,0x8(%ebp)
  80128a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80128d:	8a 12                	mov    (%edx),%dl
  80128f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801291:	8b 45 0c             	mov    0xc(%ebp),%eax
  801294:	8a 00                	mov    (%eax),%al
  801296:	84 c0                	test   %al,%al
  801298:	74 03                	je     80129d <strncpy+0x31>
			src++;
  80129a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80129d:	ff 45 fc             	incl   -0x4(%ebp)
  8012a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012a3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012a6:	72 d9                	jb     801281 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012ab:	c9                   	leave  
  8012ac:	c3                   	ret    

008012ad <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012ad:	55                   	push   %ebp
  8012ae:	89 e5                	mov    %esp,%ebp
  8012b0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012b9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012bd:	74 30                	je     8012ef <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012bf:	eb 16                	jmp    8012d7 <strlcpy+0x2a>
			*dst++ = *src++;
  8012c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c4:	8d 50 01             	lea    0x1(%eax),%edx
  8012c7:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012cd:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012d0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012d3:	8a 12                	mov    (%edx),%dl
  8012d5:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8012d7:	ff 4d 10             	decl   0x10(%ebp)
  8012da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012de:	74 09                	je     8012e9 <strlcpy+0x3c>
  8012e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e3:	8a 00                	mov    (%eax),%al
  8012e5:	84 c0                	test   %al,%al
  8012e7:	75 d8                	jne    8012c1 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8012ef:	8b 55 08             	mov    0x8(%ebp),%edx
  8012f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f5:	29 c2                	sub    %eax,%edx
  8012f7:	89 d0                	mov    %edx,%eax
}
  8012f9:	c9                   	leave  
  8012fa:	c3                   	ret    

008012fb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8012fb:	55                   	push   %ebp
  8012fc:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8012fe:	eb 06                	jmp    801306 <strcmp+0xb>
		p++, q++;
  801300:	ff 45 08             	incl   0x8(%ebp)
  801303:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	8a 00                	mov    (%eax),%al
  80130b:	84 c0                	test   %al,%al
  80130d:	74 0e                	je     80131d <strcmp+0x22>
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	8a 10                	mov    (%eax),%dl
  801314:	8b 45 0c             	mov    0xc(%ebp),%eax
  801317:	8a 00                	mov    (%eax),%al
  801319:	38 c2                	cmp    %al,%dl
  80131b:	74 e3                	je     801300 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	8a 00                	mov    (%eax),%al
  801322:	0f b6 d0             	movzbl %al,%edx
  801325:	8b 45 0c             	mov    0xc(%ebp),%eax
  801328:	8a 00                	mov    (%eax),%al
  80132a:	0f b6 c0             	movzbl %al,%eax
  80132d:	29 c2                	sub    %eax,%edx
  80132f:	89 d0                	mov    %edx,%eax
}
  801331:	5d                   	pop    %ebp
  801332:	c3                   	ret    

00801333 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801333:	55                   	push   %ebp
  801334:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801336:	eb 09                	jmp    801341 <strncmp+0xe>
		n--, p++, q++;
  801338:	ff 4d 10             	decl   0x10(%ebp)
  80133b:	ff 45 08             	incl   0x8(%ebp)
  80133e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801341:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801345:	74 17                	je     80135e <strncmp+0x2b>
  801347:	8b 45 08             	mov    0x8(%ebp),%eax
  80134a:	8a 00                	mov    (%eax),%al
  80134c:	84 c0                	test   %al,%al
  80134e:	74 0e                	je     80135e <strncmp+0x2b>
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
  801353:	8a 10                	mov    (%eax),%dl
  801355:	8b 45 0c             	mov    0xc(%ebp),%eax
  801358:	8a 00                	mov    (%eax),%al
  80135a:	38 c2                	cmp    %al,%dl
  80135c:	74 da                	je     801338 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80135e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801362:	75 07                	jne    80136b <strncmp+0x38>
		return 0;
  801364:	b8 00 00 00 00       	mov    $0x0,%eax
  801369:	eb 14                	jmp    80137f <strncmp+0x4c>
	else
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

00801381 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801381:	55                   	push   %ebp
  801382:	89 e5                	mov    %esp,%ebp
  801384:	83 ec 04             	sub    $0x4,%esp
  801387:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80138d:	eb 12                	jmp    8013a1 <strchr+0x20>
		if (*s == c)
  80138f:	8b 45 08             	mov    0x8(%ebp),%eax
  801392:	8a 00                	mov    (%eax),%al
  801394:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801397:	75 05                	jne    80139e <strchr+0x1d>
			return (char *) s;
  801399:	8b 45 08             	mov    0x8(%ebp),%eax
  80139c:	eb 11                	jmp    8013af <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80139e:	ff 45 08             	incl   0x8(%ebp)
  8013a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a4:	8a 00                	mov    (%eax),%al
  8013a6:	84 c0                	test   %al,%al
  8013a8:	75 e5                	jne    80138f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013af:	c9                   	leave  
  8013b0:	c3                   	ret    

008013b1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013b1:	55                   	push   %ebp
  8013b2:	89 e5                	mov    %esp,%ebp
  8013b4:	83 ec 04             	sub    $0x4,%esp
  8013b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013bd:	eb 0d                	jmp    8013cc <strfind+0x1b>
		if (*s == c)
  8013bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013c7:	74 0e                	je     8013d7 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013c9:	ff 45 08             	incl   0x8(%ebp)
  8013cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cf:	8a 00                	mov    (%eax),%al
  8013d1:	84 c0                	test   %al,%al
  8013d3:	75 ea                	jne    8013bf <strfind+0xe>
  8013d5:	eb 01                	jmp    8013d8 <strfind+0x27>
		if (*s == c)
			break;
  8013d7:	90                   	nop
	return (char *) s;
  8013d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013db:	c9                   	leave  
  8013dc:	c3                   	ret    

008013dd <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8013dd:	55                   	push   %ebp
  8013de:	89 e5                	mov    %esp,%ebp
  8013e0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8013e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8013e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8013ef:	eb 0e                	jmp    8013ff <memset+0x22>
		*p++ = c;
  8013f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f4:	8d 50 01             	lea    0x1(%eax),%edx
  8013f7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013fd:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8013ff:	ff 4d f8             	decl   -0x8(%ebp)
  801402:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801406:	79 e9                	jns    8013f1 <memset+0x14>
		*p++ = c;

	return v;
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80140b:	c9                   	leave  
  80140c:	c3                   	ret    

0080140d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80140d:	55                   	push   %ebp
  80140e:	89 e5                	mov    %esp,%ebp
  801410:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801413:	8b 45 0c             	mov    0xc(%ebp),%eax
  801416:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801419:	8b 45 08             	mov    0x8(%ebp),%eax
  80141c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80141f:	eb 16                	jmp    801437 <memcpy+0x2a>
		*d++ = *s++;
  801421:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801424:	8d 50 01             	lea    0x1(%eax),%edx
  801427:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80142a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80142d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801430:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801433:	8a 12                	mov    (%edx),%dl
  801435:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801437:	8b 45 10             	mov    0x10(%ebp),%eax
  80143a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80143d:	89 55 10             	mov    %edx,0x10(%ebp)
  801440:	85 c0                	test   %eax,%eax
  801442:	75 dd                	jne    801421 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801447:	c9                   	leave  
  801448:	c3                   	ret    

00801449 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
  80144c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80144f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801452:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80145b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80145e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801461:	73 50                	jae    8014b3 <memmove+0x6a>
  801463:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801466:	8b 45 10             	mov    0x10(%ebp),%eax
  801469:	01 d0                	add    %edx,%eax
  80146b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80146e:	76 43                	jbe    8014b3 <memmove+0x6a>
		s += n;
  801470:	8b 45 10             	mov    0x10(%ebp),%eax
  801473:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801476:	8b 45 10             	mov    0x10(%ebp),%eax
  801479:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80147c:	eb 10                	jmp    80148e <memmove+0x45>
			*--d = *--s;
  80147e:	ff 4d f8             	decl   -0x8(%ebp)
  801481:	ff 4d fc             	decl   -0x4(%ebp)
  801484:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801487:	8a 10                	mov    (%eax),%dl
  801489:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80148c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80148e:	8b 45 10             	mov    0x10(%ebp),%eax
  801491:	8d 50 ff             	lea    -0x1(%eax),%edx
  801494:	89 55 10             	mov    %edx,0x10(%ebp)
  801497:	85 c0                	test   %eax,%eax
  801499:	75 e3                	jne    80147e <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80149b:	eb 23                	jmp    8014c0 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80149d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a0:	8d 50 01             	lea    0x1(%eax),%edx
  8014a3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014a6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014a9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014ac:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014af:	8a 12                	mov    (%edx),%dl
  8014b1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8014b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014b9:	89 55 10             	mov    %edx,0x10(%ebp)
  8014bc:	85 c0                	test   %eax,%eax
  8014be:	75 dd                	jne    80149d <memmove+0x54>
			*d++ = *s++;

	return dst;
  8014c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014c3:	c9                   	leave  
  8014c4:	c3                   	ret    

008014c5 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
  8014c8:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8014cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8014d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d4:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8014d7:	eb 2a                	jmp    801503 <memcmp+0x3e>
		if (*s1 != *s2)
  8014d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014dc:	8a 10                	mov    (%eax),%dl
  8014de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e1:	8a 00                	mov    (%eax),%al
  8014e3:	38 c2                	cmp    %al,%dl
  8014e5:	74 16                	je     8014fd <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8014e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ea:	8a 00                	mov    (%eax),%al
  8014ec:	0f b6 d0             	movzbl %al,%edx
  8014ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f2:	8a 00                	mov    (%eax),%al
  8014f4:	0f b6 c0             	movzbl %al,%eax
  8014f7:	29 c2                	sub    %eax,%edx
  8014f9:	89 d0                	mov    %edx,%eax
  8014fb:	eb 18                	jmp    801515 <memcmp+0x50>
		s1++, s2++;
  8014fd:	ff 45 fc             	incl   -0x4(%ebp)
  801500:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801503:	8b 45 10             	mov    0x10(%ebp),%eax
  801506:	8d 50 ff             	lea    -0x1(%eax),%edx
  801509:	89 55 10             	mov    %edx,0x10(%ebp)
  80150c:	85 c0                	test   %eax,%eax
  80150e:	75 c9                	jne    8014d9 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801510:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801515:	c9                   	leave  
  801516:	c3                   	ret    

00801517 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801517:	55                   	push   %ebp
  801518:	89 e5                	mov    %esp,%ebp
  80151a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80151d:	8b 55 08             	mov    0x8(%ebp),%edx
  801520:	8b 45 10             	mov    0x10(%ebp),%eax
  801523:	01 d0                	add    %edx,%eax
  801525:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801528:	eb 15                	jmp    80153f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80152a:	8b 45 08             	mov    0x8(%ebp),%eax
  80152d:	8a 00                	mov    (%eax),%al
  80152f:	0f b6 d0             	movzbl %al,%edx
  801532:	8b 45 0c             	mov    0xc(%ebp),%eax
  801535:	0f b6 c0             	movzbl %al,%eax
  801538:	39 c2                	cmp    %eax,%edx
  80153a:	74 0d                	je     801549 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80153c:	ff 45 08             	incl   0x8(%ebp)
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801545:	72 e3                	jb     80152a <memfind+0x13>
  801547:	eb 01                	jmp    80154a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801549:	90                   	nop
	return (void *) s;
  80154a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80154d:	c9                   	leave  
  80154e:	c3                   	ret    

0080154f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80154f:	55                   	push   %ebp
  801550:	89 e5                	mov    %esp,%ebp
  801552:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801555:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80155c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801563:	eb 03                	jmp    801568 <strtol+0x19>
		s++;
  801565:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
  80156b:	8a 00                	mov    (%eax),%al
  80156d:	3c 20                	cmp    $0x20,%al
  80156f:	74 f4                	je     801565 <strtol+0x16>
  801571:	8b 45 08             	mov    0x8(%ebp),%eax
  801574:	8a 00                	mov    (%eax),%al
  801576:	3c 09                	cmp    $0x9,%al
  801578:	74 eb                	je     801565 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80157a:	8b 45 08             	mov    0x8(%ebp),%eax
  80157d:	8a 00                	mov    (%eax),%al
  80157f:	3c 2b                	cmp    $0x2b,%al
  801581:	75 05                	jne    801588 <strtol+0x39>
		s++;
  801583:	ff 45 08             	incl   0x8(%ebp)
  801586:	eb 13                	jmp    80159b <strtol+0x4c>
	else if (*s == '-')
  801588:	8b 45 08             	mov    0x8(%ebp),%eax
  80158b:	8a 00                	mov    (%eax),%al
  80158d:	3c 2d                	cmp    $0x2d,%al
  80158f:	75 0a                	jne    80159b <strtol+0x4c>
		s++, neg = 1;
  801591:	ff 45 08             	incl   0x8(%ebp)
  801594:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80159b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80159f:	74 06                	je     8015a7 <strtol+0x58>
  8015a1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015a5:	75 20                	jne    8015c7 <strtol+0x78>
  8015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015aa:	8a 00                	mov    (%eax),%al
  8015ac:	3c 30                	cmp    $0x30,%al
  8015ae:	75 17                	jne    8015c7 <strtol+0x78>
  8015b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b3:	40                   	inc    %eax
  8015b4:	8a 00                	mov    (%eax),%al
  8015b6:	3c 78                	cmp    $0x78,%al
  8015b8:	75 0d                	jne    8015c7 <strtol+0x78>
		s += 2, base = 16;
  8015ba:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8015be:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8015c5:	eb 28                	jmp    8015ef <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8015c7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015cb:	75 15                	jne    8015e2 <strtol+0x93>
  8015cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d0:	8a 00                	mov    (%eax),%al
  8015d2:	3c 30                	cmp    $0x30,%al
  8015d4:	75 0c                	jne    8015e2 <strtol+0x93>
		s++, base = 8;
  8015d6:	ff 45 08             	incl   0x8(%ebp)
  8015d9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8015e0:	eb 0d                	jmp    8015ef <strtol+0xa0>
	else if (base == 0)
  8015e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015e6:	75 07                	jne    8015ef <strtol+0xa0>
		base = 10;
  8015e8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8015ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f2:	8a 00                	mov    (%eax),%al
  8015f4:	3c 2f                	cmp    $0x2f,%al
  8015f6:	7e 19                	jle    801611 <strtol+0xc2>
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fb:	8a 00                	mov    (%eax),%al
  8015fd:	3c 39                	cmp    $0x39,%al
  8015ff:	7f 10                	jg     801611 <strtol+0xc2>
			dig = *s - '0';
  801601:	8b 45 08             	mov    0x8(%ebp),%eax
  801604:	8a 00                	mov    (%eax),%al
  801606:	0f be c0             	movsbl %al,%eax
  801609:	83 e8 30             	sub    $0x30,%eax
  80160c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80160f:	eb 42                	jmp    801653 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801611:	8b 45 08             	mov    0x8(%ebp),%eax
  801614:	8a 00                	mov    (%eax),%al
  801616:	3c 60                	cmp    $0x60,%al
  801618:	7e 19                	jle    801633 <strtol+0xe4>
  80161a:	8b 45 08             	mov    0x8(%ebp),%eax
  80161d:	8a 00                	mov    (%eax),%al
  80161f:	3c 7a                	cmp    $0x7a,%al
  801621:	7f 10                	jg     801633 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801623:	8b 45 08             	mov    0x8(%ebp),%eax
  801626:	8a 00                	mov    (%eax),%al
  801628:	0f be c0             	movsbl %al,%eax
  80162b:	83 e8 57             	sub    $0x57,%eax
  80162e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801631:	eb 20                	jmp    801653 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801633:	8b 45 08             	mov    0x8(%ebp),%eax
  801636:	8a 00                	mov    (%eax),%al
  801638:	3c 40                	cmp    $0x40,%al
  80163a:	7e 39                	jle    801675 <strtol+0x126>
  80163c:	8b 45 08             	mov    0x8(%ebp),%eax
  80163f:	8a 00                	mov    (%eax),%al
  801641:	3c 5a                	cmp    $0x5a,%al
  801643:	7f 30                	jg     801675 <strtol+0x126>
			dig = *s - 'A' + 10;
  801645:	8b 45 08             	mov    0x8(%ebp),%eax
  801648:	8a 00                	mov    (%eax),%al
  80164a:	0f be c0             	movsbl %al,%eax
  80164d:	83 e8 37             	sub    $0x37,%eax
  801650:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801653:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801656:	3b 45 10             	cmp    0x10(%ebp),%eax
  801659:	7d 19                	jge    801674 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80165b:	ff 45 08             	incl   0x8(%ebp)
  80165e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801661:	0f af 45 10          	imul   0x10(%ebp),%eax
  801665:	89 c2                	mov    %eax,%edx
  801667:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80166a:	01 d0                	add    %edx,%eax
  80166c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80166f:	e9 7b ff ff ff       	jmp    8015ef <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801674:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801675:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801679:	74 08                	je     801683 <strtol+0x134>
		*endptr = (char *) s;
  80167b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80167e:	8b 55 08             	mov    0x8(%ebp),%edx
  801681:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801683:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801687:	74 07                	je     801690 <strtol+0x141>
  801689:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80168c:	f7 d8                	neg    %eax
  80168e:	eb 03                	jmp    801693 <strtol+0x144>
  801690:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801693:	c9                   	leave  
  801694:	c3                   	ret    

00801695 <ltostr>:

void
ltostr(long value, char *str)
{
  801695:	55                   	push   %ebp
  801696:	89 e5                	mov    %esp,%ebp
  801698:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80169b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016a2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016a9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016ad:	79 13                	jns    8016c2 <ltostr+0x2d>
	{
		neg = 1;
  8016af:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8016b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016b9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8016bc:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8016bf:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8016c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c5:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8016ca:	99                   	cltd   
  8016cb:	f7 f9                	idiv   %ecx
  8016cd:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8016d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d3:	8d 50 01             	lea    0x1(%eax),%edx
  8016d6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016d9:	89 c2                	mov    %eax,%edx
  8016db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016de:	01 d0                	add    %edx,%eax
  8016e0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016e3:	83 c2 30             	add    $0x30,%edx
  8016e6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8016e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016eb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8016f0:	f7 e9                	imul   %ecx
  8016f2:	c1 fa 02             	sar    $0x2,%edx
  8016f5:	89 c8                	mov    %ecx,%eax
  8016f7:	c1 f8 1f             	sar    $0x1f,%eax
  8016fa:	29 c2                	sub    %eax,%edx
  8016fc:	89 d0                	mov    %edx,%eax
  8016fe:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801701:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801704:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801709:	f7 e9                	imul   %ecx
  80170b:	c1 fa 02             	sar    $0x2,%edx
  80170e:	89 c8                	mov    %ecx,%eax
  801710:	c1 f8 1f             	sar    $0x1f,%eax
  801713:	29 c2                	sub    %eax,%edx
  801715:	89 d0                	mov    %edx,%eax
  801717:	c1 e0 02             	shl    $0x2,%eax
  80171a:	01 d0                	add    %edx,%eax
  80171c:	01 c0                	add    %eax,%eax
  80171e:	29 c1                	sub    %eax,%ecx
  801720:	89 ca                	mov    %ecx,%edx
  801722:	85 d2                	test   %edx,%edx
  801724:	75 9c                	jne    8016c2 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801726:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80172d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801730:	48                   	dec    %eax
  801731:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801734:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801738:	74 3d                	je     801777 <ltostr+0xe2>
		start = 1 ;
  80173a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801741:	eb 34                	jmp    801777 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801743:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801746:	8b 45 0c             	mov    0xc(%ebp),%eax
  801749:	01 d0                	add    %edx,%eax
  80174b:	8a 00                	mov    (%eax),%al
  80174d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801750:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801753:	8b 45 0c             	mov    0xc(%ebp),%eax
  801756:	01 c2                	add    %eax,%edx
  801758:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80175b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175e:	01 c8                	add    %ecx,%eax
  801760:	8a 00                	mov    (%eax),%al
  801762:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801764:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801767:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176a:	01 c2                	add    %eax,%edx
  80176c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80176f:	88 02                	mov    %al,(%edx)
		start++ ;
  801771:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801774:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801777:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80177a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80177d:	7c c4                	jl     801743 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80177f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801782:	8b 45 0c             	mov    0xc(%ebp),%eax
  801785:	01 d0                	add    %edx,%eax
  801787:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80178a:	90                   	nop
  80178b:	c9                   	leave  
  80178c:	c3                   	ret    

0080178d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80178d:	55                   	push   %ebp
  80178e:	89 e5                	mov    %esp,%ebp
  801790:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801793:	ff 75 08             	pushl  0x8(%ebp)
  801796:	e8 54 fa ff ff       	call   8011ef <strlen>
  80179b:	83 c4 04             	add    $0x4,%esp
  80179e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017a1:	ff 75 0c             	pushl  0xc(%ebp)
  8017a4:	e8 46 fa ff ff       	call   8011ef <strlen>
  8017a9:	83 c4 04             	add    $0x4,%esp
  8017ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8017b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8017bd:	eb 17                	jmp    8017d6 <strcconcat+0x49>
		final[s] = str1[s] ;
  8017bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8017c5:	01 c2                	add    %eax,%edx
  8017c7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8017ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cd:	01 c8                	add    %ecx,%eax
  8017cf:	8a 00                	mov    (%eax),%al
  8017d1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8017d3:	ff 45 fc             	incl   -0x4(%ebp)
  8017d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017d9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8017dc:	7c e1                	jl     8017bf <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8017de:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8017e5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8017ec:	eb 1f                	jmp    80180d <strcconcat+0x80>
		final[s++] = str2[i] ;
  8017ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017f1:	8d 50 01             	lea    0x1(%eax),%edx
  8017f4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8017f7:	89 c2                	mov    %eax,%edx
  8017f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8017fc:	01 c2                	add    %eax,%edx
  8017fe:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801801:	8b 45 0c             	mov    0xc(%ebp),%eax
  801804:	01 c8                	add    %ecx,%eax
  801806:	8a 00                	mov    (%eax),%al
  801808:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80180a:	ff 45 f8             	incl   -0x8(%ebp)
  80180d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801810:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801813:	7c d9                	jl     8017ee <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801815:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801818:	8b 45 10             	mov    0x10(%ebp),%eax
  80181b:	01 d0                	add    %edx,%eax
  80181d:	c6 00 00             	movb   $0x0,(%eax)
}
  801820:	90                   	nop
  801821:	c9                   	leave  
  801822:	c3                   	ret    

00801823 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801823:	55                   	push   %ebp
  801824:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801826:	8b 45 14             	mov    0x14(%ebp),%eax
  801829:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80182f:	8b 45 14             	mov    0x14(%ebp),%eax
  801832:	8b 00                	mov    (%eax),%eax
  801834:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80183b:	8b 45 10             	mov    0x10(%ebp),%eax
  80183e:	01 d0                	add    %edx,%eax
  801840:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801846:	eb 0c                	jmp    801854 <strsplit+0x31>
			*string++ = 0;
  801848:	8b 45 08             	mov    0x8(%ebp),%eax
  80184b:	8d 50 01             	lea    0x1(%eax),%edx
  80184e:	89 55 08             	mov    %edx,0x8(%ebp)
  801851:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801854:	8b 45 08             	mov    0x8(%ebp),%eax
  801857:	8a 00                	mov    (%eax),%al
  801859:	84 c0                	test   %al,%al
  80185b:	74 18                	je     801875 <strsplit+0x52>
  80185d:	8b 45 08             	mov    0x8(%ebp),%eax
  801860:	8a 00                	mov    (%eax),%al
  801862:	0f be c0             	movsbl %al,%eax
  801865:	50                   	push   %eax
  801866:	ff 75 0c             	pushl  0xc(%ebp)
  801869:	e8 13 fb ff ff       	call   801381 <strchr>
  80186e:	83 c4 08             	add    $0x8,%esp
  801871:	85 c0                	test   %eax,%eax
  801873:	75 d3                	jne    801848 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801875:	8b 45 08             	mov    0x8(%ebp),%eax
  801878:	8a 00                	mov    (%eax),%al
  80187a:	84 c0                	test   %al,%al
  80187c:	74 5a                	je     8018d8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80187e:	8b 45 14             	mov    0x14(%ebp),%eax
  801881:	8b 00                	mov    (%eax),%eax
  801883:	83 f8 0f             	cmp    $0xf,%eax
  801886:	75 07                	jne    80188f <strsplit+0x6c>
		{
			return 0;
  801888:	b8 00 00 00 00       	mov    $0x0,%eax
  80188d:	eb 66                	jmp    8018f5 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80188f:	8b 45 14             	mov    0x14(%ebp),%eax
  801892:	8b 00                	mov    (%eax),%eax
  801894:	8d 48 01             	lea    0x1(%eax),%ecx
  801897:	8b 55 14             	mov    0x14(%ebp),%edx
  80189a:	89 0a                	mov    %ecx,(%edx)
  80189c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a6:	01 c2                	add    %eax,%edx
  8018a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ab:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018ad:	eb 03                	jmp    8018b2 <strsplit+0x8f>
			string++;
  8018af:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b5:	8a 00                	mov    (%eax),%al
  8018b7:	84 c0                	test   %al,%al
  8018b9:	74 8b                	je     801846 <strsplit+0x23>
  8018bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018be:	8a 00                	mov    (%eax),%al
  8018c0:	0f be c0             	movsbl %al,%eax
  8018c3:	50                   	push   %eax
  8018c4:	ff 75 0c             	pushl  0xc(%ebp)
  8018c7:	e8 b5 fa ff ff       	call   801381 <strchr>
  8018cc:	83 c4 08             	add    $0x8,%esp
  8018cf:	85 c0                	test   %eax,%eax
  8018d1:	74 dc                	je     8018af <strsplit+0x8c>
			string++;
	}
  8018d3:	e9 6e ff ff ff       	jmp    801846 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8018d8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8018d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8018dc:	8b 00                	mov    (%eax),%eax
  8018de:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8018e8:	01 d0                	add    %edx,%eax
  8018ea:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8018f0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8018f5:	c9                   	leave  
  8018f6:	c3                   	ret    

008018f7 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8018f7:	55                   	push   %ebp
  8018f8:	89 e5                	mov    %esp,%ebp
  8018fa:	83 ec 18             	sub    $0x18,%esp
  8018fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801900:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801903:	83 ec 04             	sub    $0x4,%esp
  801906:	68 30 2b 80 00       	push   $0x802b30
  80190b:	6a 17                	push   $0x17
  80190d:	68 4f 2b 80 00       	push   $0x802b4f
  801912:	e8 a2 ef ff ff       	call   8008b9 <_panic>

00801917 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801917:	55                   	push   %ebp
  801918:	89 e5                	mov    %esp,%ebp
  80191a:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  80191d:	83 ec 04             	sub    $0x4,%esp
  801920:	68 5b 2b 80 00       	push   $0x802b5b
  801925:	6a 2f                	push   $0x2f
  801927:	68 4f 2b 80 00       	push   $0x802b4f
  80192c:	e8 88 ef ff ff       	call   8008b9 <_panic>

00801931 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801931:	55                   	push   %ebp
  801932:	89 e5                	mov    %esp,%ebp
  801934:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801937:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  80193e:	8b 55 08             	mov    0x8(%ebp),%edx
  801941:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801944:	01 d0                	add    %edx,%eax
  801946:	48                   	dec    %eax
  801947:	89 45 e8             	mov    %eax,-0x18(%ebp)
  80194a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80194d:	ba 00 00 00 00       	mov    $0x0,%edx
  801952:	f7 75 ec             	divl   -0x14(%ebp)
  801955:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801958:	29 d0                	sub    %edx,%eax
  80195a:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  80195d:	8b 45 08             	mov    0x8(%ebp),%eax
  801960:	c1 e8 0c             	shr    $0xc,%eax
  801963:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801966:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80196d:	e9 c8 00 00 00       	jmp    801a3a <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801972:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801979:	eb 27                	jmp    8019a2 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  80197b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80197e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801981:	01 c2                	add    %eax,%edx
  801983:	89 d0                	mov    %edx,%eax
  801985:	01 c0                	add    %eax,%eax
  801987:	01 d0                	add    %edx,%eax
  801989:	c1 e0 02             	shl    $0x2,%eax
  80198c:	05 48 30 80 00       	add    $0x803048,%eax
  801991:	8b 00                	mov    (%eax),%eax
  801993:	85 c0                	test   %eax,%eax
  801995:	74 08                	je     80199f <malloc+0x6e>
            	i += j;
  801997:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80199a:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  80199d:	eb 0b                	jmp    8019aa <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  80199f:	ff 45 f0             	incl   -0x10(%ebp)
  8019a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019a5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019a8:	72 d1                	jb     80197b <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8019aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019ad:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019b0:	0f 85 81 00 00 00    	jne    801a37 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8019b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019b9:	05 00 00 08 00       	add    $0x80000,%eax
  8019be:	c1 e0 0c             	shl    $0xc,%eax
  8019c1:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8019c4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019cb:	eb 1f                	jmp    8019ec <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8019cd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019d3:	01 c2                	add    %eax,%edx
  8019d5:	89 d0                	mov    %edx,%eax
  8019d7:	01 c0                	add    %eax,%eax
  8019d9:	01 d0                	add    %edx,%eax
  8019db:	c1 e0 02             	shl    $0x2,%eax
  8019de:	05 48 30 80 00       	add    $0x803048,%eax
  8019e3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8019e9:	ff 45 f0             	incl   -0x10(%ebp)
  8019ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019ef:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019f2:	72 d9                	jb     8019cd <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  8019f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019f7:	89 d0                	mov    %edx,%eax
  8019f9:	01 c0                	add    %eax,%eax
  8019fb:	01 d0                	add    %edx,%eax
  8019fd:	c1 e0 02             	shl    $0x2,%eax
  801a00:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801a06:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a09:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801a0b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a0e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801a11:	89 c8                	mov    %ecx,%eax
  801a13:	01 c0                	add    %eax,%eax
  801a15:	01 c8                	add    %ecx,%eax
  801a17:	c1 e0 02             	shl    $0x2,%eax
  801a1a:	05 44 30 80 00       	add    $0x803044,%eax
  801a1f:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801a21:	83 ec 08             	sub    $0x8,%esp
  801a24:	ff 75 08             	pushl  0x8(%ebp)
  801a27:	ff 75 e0             	pushl  -0x20(%ebp)
  801a2a:	e8 2b 03 00 00       	call   801d5a <sys_allocateMem>
  801a2f:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801a32:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a35:	eb 19                	jmp    801a50 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801a37:	ff 45 f4             	incl   -0xc(%ebp)
  801a3a:	a1 04 30 80 00       	mov    0x803004,%eax
  801a3f:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801a42:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a45:	0f 83 27 ff ff ff    	jae    801972 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801a4b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a50:	c9                   	leave  
  801a51:	c3                   	ret    

00801a52 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
  801a55:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801a58:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801a5c:	0f 84 e5 00 00 00    	je     801b47 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801a62:	8b 45 08             	mov    0x8(%ebp),%eax
  801a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801a68:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a6b:	05 00 00 00 80       	add    $0x80000000,%eax
  801a70:	c1 e8 0c             	shr    $0xc,%eax
  801a73:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801a76:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a79:	89 d0                	mov    %edx,%eax
  801a7b:	01 c0                	add    %eax,%eax
  801a7d:	01 d0                	add    %edx,%eax
  801a7f:	c1 e0 02             	shl    $0x2,%eax
  801a82:	05 40 30 80 00       	add    $0x803040,%eax
  801a87:	8b 00                	mov    (%eax),%eax
  801a89:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a8c:	0f 85 b8 00 00 00    	jne    801b4a <free+0xf8>
  801a92:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a95:	89 d0                	mov    %edx,%eax
  801a97:	01 c0                	add    %eax,%eax
  801a99:	01 d0                	add    %edx,%eax
  801a9b:	c1 e0 02             	shl    $0x2,%eax
  801a9e:	05 48 30 80 00       	add    $0x803048,%eax
  801aa3:	8b 00                	mov    (%eax),%eax
  801aa5:	85 c0                	test   %eax,%eax
  801aa7:	0f 84 9d 00 00 00    	je     801b4a <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801aad:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ab0:	89 d0                	mov    %edx,%eax
  801ab2:	01 c0                	add    %eax,%eax
  801ab4:	01 d0                	add    %edx,%eax
  801ab6:	c1 e0 02             	shl    $0x2,%eax
  801ab9:	05 44 30 80 00       	add    $0x803044,%eax
  801abe:	8b 00                	mov    (%eax),%eax
  801ac0:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801ac3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ac6:	c1 e0 0c             	shl    $0xc,%eax
  801ac9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801acc:	83 ec 08             	sub    $0x8,%esp
  801acf:	ff 75 e4             	pushl  -0x1c(%ebp)
  801ad2:	ff 75 f0             	pushl  -0x10(%ebp)
  801ad5:	e8 64 02 00 00       	call   801d3e <sys_freeMem>
  801ada:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801add:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801ae4:	eb 57                	jmp    801b3d <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801ae6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ae9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801aec:	01 c2                	add    %eax,%edx
  801aee:	89 d0                	mov    %edx,%eax
  801af0:	01 c0                	add    %eax,%eax
  801af2:	01 d0                	add    %edx,%eax
  801af4:	c1 e0 02             	shl    $0x2,%eax
  801af7:	05 48 30 80 00       	add    $0x803048,%eax
  801afc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801b02:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b05:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b08:	01 c2                	add    %eax,%edx
  801b0a:	89 d0                	mov    %edx,%eax
  801b0c:	01 c0                	add    %eax,%eax
  801b0e:	01 d0                	add    %edx,%eax
  801b10:	c1 e0 02             	shl    $0x2,%eax
  801b13:	05 40 30 80 00       	add    $0x803040,%eax
  801b18:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801b1e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b21:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b24:	01 c2                	add    %eax,%edx
  801b26:	89 d0                	mov    %edx,%eax
  801b28:	01 c0                	add    %eax,%eax
  801b2a:	01 d0                	add    %edx,%eax
  801b2c:	c1 e0 02             	shl    $0x2,%eax
  801b2f:	05 44 30 80 00       	add    $0x803044,%eax
  801b34:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801b3a:	ff 45 f4             	incl   -0xc(%ebp)
  801b3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b40:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b43:	7c a1                	jl     801ae6 <free+0x94>
  801b45:	eb 04                	jmp    801b4b <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801b47:	90                   	nop
  801b48:	eb 01                	jmp    801b4b <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801b4a:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801b4b:	c9                   	leave  
  801b4c:	c3                   	ret    

00801b4d <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801b4d:	55                   	push   %ebp
  801b4e:	89 e5                	mov    %esp,%ebp
  801b50:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801b53:	83 ec 04             	sub    $0x4,%esp
  801b56:	68 78 2b 80 00       	push   $0x802b78
  801b5b:	68 ae 00 00 00       	push   $0xae
  801b60:	68 4f 2b 80 00       	push   $0x802b4f
  801b65:	e8 4f ed ff ff       	call   8008b9 <_panic>

00801b6a <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801b6a:	55                   	push   %ebp
  801b6b:	89 e5                	mov    %esp,%ebp
  801b6d:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801b70:	83 ec 04             	sub    $0x4,%esp
  801b73:	68 98 2b 80 00       	push   $0x802b98
  801b78:	68 ca 00 00 00       	push   $0xca
  801b7d:	68 4f 2b 80 00       	push   $0x802b4f
  801b82:	e8 32 ed ff ff       	call   8008b9 <_panic>

00801b87 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b87:	55                   	push   %ebp
  801b88:	89 e5                	mov    %esp,%ebp
  801b8a:	57                   	push   %edi
  801b8b:	56                   	push   %esi
  801b8c:	53                   	push   %ebx
  801b8d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b90:	8b 45 08             	mov    0x8(%ebp),%eax
  801b93:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b96:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b99:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b9c:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b9f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801ba2:	cd 30                	int    $0x30
  801ba4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ba7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801baa:	83 c4 10             	add    $0x10,%esp
  801bad:	5b                   	pop    %ebx
  801bae:	5e                   	pop    %esi
  801baf:	5f                   	pop    %edi
  801bb0:	5d                   	pop    %ebp
  801bb1:	c3                   	ret    

00801bb2 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801bb2:	55                   	push   %ebp
  801bb3:	89 e5                	mov    %esp,%ebp
  801bb5:	83 ec 04             	sub    $0x4,%esp
  801bb8:	8b 45 10             	mov    0x10(%ebp),%eax
  801bbb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801bbe:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	52                   	push   %edx
  801bca:	ff 75 0c             	pushl  0xc(%ebp)
  801bcd:	50                   	push   %eax
  801bce:	6a 00                	push   $0x0
  801bd0:	e8 b2 ff ff ff       	call   801b87 <syscall>
  801bd5:	83 c4 18             	add    $0x18,%esp
}
  801bd8:	90                   	nop
  801bd9:	c9                   	leave  
  801bda:	c3                   	ret    

00801bdb <sys_cgetc>:

int
sys_cgetc(void)
{
  801bdb:	55                   	push   %ebp
  801bdc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 01                	push   $0x1
  801bea:	e8 98 ff ff ff       	call   801b87 <syscall>
  801bef:	83 c4 18             	add    $0x18,%esp
}
  801bf2:	c9                   	leave  
  801bf3:	c3                   	ret    

00801bf4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801bf4:	55                   	push   %ebp
  801bf5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	50                   	push   %eax
  801c03:	6a 05                	push   $0x5
  801c05:	e8 7d ff ff ff       	call   801b87 <syscall>
  801c0a:	83 c4 18             	add    $0x18,%esp
}
  801c0d:	c9                   	leave  
  801c0e:	c3                   	ret    

00801c0f <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c0f:	55                   	push   %ebp
  801c10:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 02                	push   $0x2
  801c1e:	e8 64 ff ff ff       	call   801b87 <syscall>
  801c23:	83 c4 18             	add    $0x18,%esp
}
  801c26:	c9                   	leave  
  801c27:	c3                   	ret    

00801c28 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c28:	55                   	push   %ebp
  801c29:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 03                	push   $0x3
  801c37:	e8 4b ff ff ff       	call   801b87 <syscall>
  801c3c:	83 c4 18             	add    $0x18,%esp
}
  801c3f:	c9                   	leave  
  801c40:	c3                   	ret    

00801c41 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c41:	55                   	push   %ebp
  801c42:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 04                	push   $0x4
  801c50:	e8 32 ff ff ff       	call   801b87 <syscall>
  801c55:	83 c4 18             	add    $0x18,%esp
}
  801c58:	c9                   	leave  
  801c59:	c3                   	ret    

00801c5a <sys_env_exit>:


void sys_env_exit(void)
{
  801c5a:	55                   	push   %ebp
  801c5b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	6a 06                	push   $0x6
  801c69:	e8 19 ff ff ff       	call   801b87 <syscall>
  801c6e:	83 c4 18             	add    $0x18,%esp
}
  801c71:	90                   	nop
  801c72:	c9                   	leave  
  801c73:	c3                   	ret    

00801c74 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c74:	55                   	push   %ebp
  801c75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c77:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	52                   	push   %edx
  801c84:	50                   	push   %eax
  801c85:	6a 07                	push   $0x7
  801c87:	e8 fb fe ff ff       	call   801b87 <syscall>
  801c8c:	83 c4 18             	add    $0x18,%esp
}
  801c8f:	c9                   	leave  
  801c90:	c3                   	ret    

00801c91 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c91:	55                   	push   %ebp
  801c92:	89 e5                	mov    %esp,%ebp
  801c94:	56                   	push   %esi
  801c95:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c96:	8b 75 18             	mov    0x18(%ebp),%esi
  801c99:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c9c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca5:	56                   	push   %esi
  801ca6:	53                   	push   %ebx
  801ca7:	51                   	push   %ecx
  801ca8:	52                   	push   %edx
  801ca9:	50                   	push   %eax
  801caa:	6a 08                	push   $0x8
  801cac:	e8 d6 fe ff ff       	call   801b87 <syscall>
  801cb1:	83 c4 18             	add    $0x18,%esp
}
  801cb4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801cb7:	5b                   	pop    %ebx
  801cb8:	5e                   	pop    %esi
  801cb9:	5d                   	pop    %ebp
  801cba:	c3                   	ret    

00801cbb <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801cbb:	55                   	push   %ebp
  801cbc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801cbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	52                   	push   %edx
  801ccb:	50                   	push   %eax
  801ccc:	6a 09                	push   $0x9
  801cce:	e8 b4 fe ff ff       	call   801b87 <syscall>
  801cd3:	83 c4 18             	add    $0x18,%esp
}
  801cd6:	c9                   	leave  
  801cd7:	c3                   	ret    

00801cd8 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801cd8:	55                   	push   %ebp
  801cd9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	ff 75 0c             	pushl  0xc(%ebp)
  801ce4:	ff 75 08             	pushl  0x8(%ebp)
  801ce7:	6a 0a                	push   $0xa
  801ce9:	e8 99 fe ff ff       	call   801b87 <syscall>
  801cee:	83 c4 18             	add    $0x18,%esp
}
  801cf1:	c9                   	leave  
  801cf2:	c3                   	ret    

00801cf3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801cf3:	55                   	push   %ebp
  801cf4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 0b                	push   $0xb
  801d02:	e8 80 fe ff ff       	call   801b87 <syscall>
  801d07:	83 c4 18             	add    $0x18,%esp
}
  801d0a:	c9                   	leave  
  801d0b:	c3                   	ret    

00801d0c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d0c:	55                   	push   %ebp
  801d0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	6a 00                	push   $0x0
  801d19:	6a 0c                	push   $0xc
  801d1b:	e8 67 fe ff ff       	call   801b87 <syscall>
  801d20:	83 c4 18             	add    $0x18,%esp
}
  801d23:	c9                   	leave  
  801d24:	c3                   	ret    

00801d25 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d25:	55                   	push   %ebp
  801d26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	6a 0d                	push   $0xd
  801d34:	e8 4e fe ff ff       	call   801b87 <syscall>
  801d39:	83 c4 18             	add    $0x18,%esp
}
  801d3c:	c9                   	leave  
  801d3d:	c3                   	ret    

00801d3e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d3e:	55                   	push   %ebp
  801d3f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	ff 75 0c             	pushl  0xc(%ebp)
  801d4a:	ff 75 08             	pushl  0x8(%ebp)
  801d4d:	6a 11                	push   $0x11
  801d4f:	e8 33 fe ff ff       	call   801b87 <syscall>
  801d54:	83 c4 18             	add    $0x18,%esp
	return;
  801d57:	90                   	nop
}
  801d58:	c9                   	leave  
  801d59:	c3                   	ret    

00801d5a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d5a:	55                   	push   %ebp
  801d5b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 00                	push   $0x0
  801d63:	ff 75 0c             	pushl  0xc(%ebp)
  801d66:	ff 75 08             	pushl  0x8(%ebp)
  801d69:	6a 12                	push   $0x12
  801d6b:	e8 17 fe ff ff       	call   801b87 <syscall>
  801d70:	83 c4 18             	add    $0x18,%esp
	return ;
  801d73:	90                   	nop
}
  801d74:	c9                   	leave  
  801d75:	c3                   	ret    

00801d76 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d76:	55                   	push   %ebp
  801d77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 0e                	push   $0xe
  801d85:	e8 fd fd ff ff       	call   801b87 <syscall>
  801d8a:	83 c4 18             	add    $0x18,%esp
}
  801d8d:	c9                   	leave  
  801d8e:	c3                   	ret    

00801d8f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d8f:	55                   	push   %ebp
  801d90:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	ff 75 08             	pushl  0x8(%ebp)
  801d9d:	6a 0f                	push   $0xf
  801d9f:	e8 e3 fd ff ff       	call   801b87 <syscall>
  801da4:	83 c4 18             	add    $0x18,%esp
}
  801da7:	c9                   	leave  
  801da8:	c3                   	ret    

00801da9 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801da9:	55                   	push   %ebp
  801daa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	6a 00                	push   $0x0
  801db2:	6a 00                	push   $0x0
  801db4:	6a 00                	push   $0x0
  801db6:	6a 10                	push   $0x10
  801db8:	e8 ca fd ff ff       	call   801b87 <syscall>
  801dbd:	83 c4 18             	add    $0x18,%esp
}
  801dc0:	90                   	nop
  801dc1:	c9                   	leave  
  801dc2:	c3                   	ret    

00801dc3 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801dc3:	55                   	push   %ebp
  801dc4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 14                	push   $0x14
  801dd2:	e8 b0 fd ff ff       	call   801b87 <syscall>
  801dd7:	83 c4 18             	add    $0x18,%esp
}
  801dda:	90                   	nop
  801ddb:	c9                   	leave  
  801ddc:	c3                   	ret    

00801ddd <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ddd:	55                   	push   %ebp
  801dde:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	6a 00                	push   $0x0
  801de6:	6a 00                	push   $0x0
  801de8:	6a 00                	push   $0x0
  801dea:	6a 15                	push   $0x15
  801dec:	e8 96 fd ff ff       	call   801b87 <syscall>
  801df1:	83 c4 18             	add    $0x18,%esp
}
  801df4:	90                   	nop
  801df5:	c9                   	leave  
  801df6:	c3                   	ret    

00801df7 <sys_cputc>:


void
sys_cputc(const char c)
{
  801df7:	55                   	push   %ebp
  801df8:	89 e5                	mov    %esp,%ebp
  801dfa:	83 ec 04             	sub    $0x4,%esp
  801dfd:	8b 45 08             	mov    0x8(%ebp),%eax
  801e00:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e03:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e07:	6a 00                	push   $0x0
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	50                   	push   %eax
  801e10:	6a 16                	push   $0x16
  801e12:	e8 70 fd ff ff       	call   801b87 <syscall>
  801e17:	83 c4 18             	add    $0x18,%esp
}
  801e1a:	90                   	nop
  801e1b:	c9                   	leave  
  801e1c:	c3                   	ret    

00801e1d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e1d:	55                   	push   %ebp
  801e1e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 00                	push   $0x0
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 17                	push   $0x17
  801e2c:	e8 56 fd ff ff       	call   801b87 <syscall>
  801e31:	83 c4 18             	add    $0x18,%esp
}
  801e34:	90                   	nop
  801e35:	c9                   	leave  
  801e36:	c3                   	ret    

00801e37 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e37:	55                   	push   %ebp
  801e38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	ff 75 0c             	pushl  0xc(%ebp)
  801e46:	50                   	push   %eax
  801e47:	6a 18                	push   $0x18
  801e49:	e8 39 fd ff ff       	call   801b87 <syscall>
  801e4e:	83 c4 18             	add    $0x18,%esp
}
  801e51:	c9                   	leave  
  801e52:	c3                   	ret    

00801e53 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e53:	55                   	push   %ebp
  801e54:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e56:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e59:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5c:	6a 00                	push   $0x0
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	52                   	push   %edx
  801e63:	50                   	push   %eax
  801e64:	6a 1b                	push   $0x1b
  801e66:	e8 1c fd ff ff       	call   801b87 <syscall>
  801e6b:	83 c4 18             	add    $0x18,%esp
}
  801e6e:	c9                   	leave  
  801e6f:	c3                   	ret    

00801e70 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e70:	55                   	push   %ebp
  801e71:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e73:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e76:	8b 45 08             	mov    0x8(%ebp),%eax
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 00                	push   $0x0
  801e7f:	52                   	push   %edx
  801e80:	50                   	push   %eax
  801e81:	6a 19                	push   $0x19
  801e83:	e8 ff fc ff ff       	call   801b87 <syscall>
  801e88:	83 c4 18             	add    $0x18,%esp
}
  801e8b:	90                   	nop
  801e8c:	c9                   	leave  
  801e8d:	c3                   	ret    

00801e8e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e8e:	55                   	push   %ebp
  801e8f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e91:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e94:	8b 45 08             	mov    0x8(%ebp),%eax
  801e97:	6a 00                	push   $0x0
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	52                   	push   %edx
  801e9e:	50                   	push   %eax
  801e9f:	6a 1a                	push   $0x1a
  801ea1:	e8 e1 fc ff ff       	call   801b87 <syscall>
  801ea6:	83 c4 18             	add    $0x18,%esp
}
  801ea9:	90                   	nop
  801eaa:	c9                   	leave  
  801eab:	c3                   	ret    

00801eac <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801eac:	55                   	push   %ebp
  801ead:	89 e5                	mov    %esp,%ebp
  801eaf:	83 ec 04             	sub    $0x4,%esp
  801eb2:	8b 45 10             	mov    0x10(%ebp),%eax
  801eb5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801eb8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ebb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec2:	6a 00                	push   $0x0
  801ec4:	51                   	push   %ecx
  801ec5:	52                   	push   %edx
  801ec6:	ff 75 0c             	pushl  0xc(%ebp)
  801ec9:	50                   	push   %eax
  801eca:	6a 1c                	push   $0x1c
  801ecc:	e8 b6 fc ff ff       	call   801b87 <syscall>
  801ed1:	83 c4 18             	add    $0x18,%esp
}
  801ed4:	c9                   	leave  
  801ed5:	c3                   	ret    

00801ed6 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801ed6:	55                   	push   %ebp
  801ed7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ed9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801edc:	8b 45 08             	mov    0x8(%ebp),%eax
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 00                	push   $0x0
  801ee5:	52                   	push   %edx
  801ee6:	50                   	push   %eax
  801ee7:	6a 1d                	push   $0x1d
  801ee9:	e8 99 fc ff ff       	call   801b87 <syscall>
  801eee:	83 c4 18             	add    $0x18,%esp
}
  801ef1:	c9                   	leave  
  801ef2:	c3                   	ret    

00801ef3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ef3:	55                   	push   %ebp
  801ef4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801ef6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ef9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801efc:	8b 45 08             	mov    0x8(%ebp),%eax
  801eff:	6a 00                	push   $0x0
  801f01:	6a 00                	push   $0x0
  801f03:	51                   	push   %ecx
  801f04:	52                   	push   %edx
  801f05:	50                   	push   %eax
  801f06:	6a 1e                	push   $0x1e
  801f08:	e8 7a fc ff ff       	call   801b87 <syscall>
  801f0d:	83 c4 18             	add    $0x18,%esp
}
  801f10:	c9                   	leave  
  801f11:	c3                   	ret    

00801f12 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f12:	55                   	push   %ebp
  801f13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f15:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f18:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	52                   	push   %edx
  801f22:	50                   	push   %eax
  801f23:	6a 1f                	push   $0x1f
  801f25:	e8 5d fc ff ff       	call   801b87 <syscall>
  801f2a:	83 c4 18             	add    $0x18,%esp
}
  801f2d:	c9                   	leave  
  801f2e:	c3                   	ret    

00801f2f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f2f:	55                   	push   %ebp
  801f30:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 20                	push   $0x20
  801f3e:	e8 44 fc ff ff       	call   801b87 <syscall>
  801f43:	83 c4 18             	add    $0x18,%esp
}
  801f46:	c9                   	leave  
  801f47:	c3                   	ret    

00801f48 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801f48:	55                   	push   %ebp
  801f49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	ff 75 10             	pushl  0x10(%ebp)
  801f55:	ff 75 0c             	pushl  0xc(%ebp)
  801f58:	50                   	push   %eax
  801f59:	6a 21                	push   $0x21
  801f5b:	e8 27 fc ff ff       	call   801b87 <syscall>
  801f60:	83 c4 18             	add    $0x18,%esp
}
  801f63:	c9                   	leave  
  801f64:	c3                   	ret    

00801f65 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801f65:	55                   	push   %ebp
  801f66:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f68:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 00                	push   $0x0
  801f71:	6a 00                	push   $0x0
  801f73:	50                   	push   %eax
  801f74:	6a 22                	push   $0x22
  801f76:	e8 0c fc ff ff       	call   801b87 <syscall>
  801f7b:	83 c4 18             	add    $0x18,%esp
}
  801f7e:	90                   	nop
  801f7f:	c9                   	leave  
  801f80:	c3                   	ret    

00801f81 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f81:	55                   	push   %ebp
  801f82:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f84:	8b 45 08             	mov    0x8(%ebp),%eax
  801f87:	6a 00                	push   $0x0
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 00                	push   $0x0
  801f8f:	50                   	push   %eax
  801f90:	6a 23                	push   $0x23
  801f92:	e8 f0 fb ff ff       	call   801b87 <syscall>
  801f97:	83 c4 18             	add    $0x18,%esp
}
  801f9a:	90                   	nop
  801f9b:	c9                   	leave  
  801f9c:	c3                   	ret    

00801f9d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801f9d:	55                   	push   %ebp
  801f9e:	89 e5                	mov    %esp,%ebp
  801fa0:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801fa3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fa6:	8d 50 04             	lea    0x4(%eax),%edx
  801fa9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	52                   	push   %edx
  801fb3:	50                   	push   %eax
  801fb4:	6a 24                	push   $0x24
  801fb6:	e8 cc fb ff ff       	call   801b87 <syscall>
  801fbb:	83 c4 18             	add    $0x18,%esp
	return result;
  801fbe:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801fc1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801fc4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801fc7:	89 01                	mov    %eax,(%ecx)
  801fc9:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  801fcf:	c9                   	leave  
  801fd0:	c2 04 00             	ret    $0x4

00801fd3 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801fd3:	55                   	push   %ebp
  801fd4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	ff 75 10             	pushl  0x10(%ebp)
  801fdd:	ff 75 0c             	pushl  0xc(%ebp)
  801fe0:	ff 75 08             	pushl  0x8(%ebp)
  801fe3:	6a 13                	push   $0x13
  801fe5:	e8 9d fb ff ff       	call   801b87 <syscall>
  801fea:	83 c4 18             	add    $0x18,%esp
	return ;
  801fed:	90                   	nop
}
  801fee:	c9                   	leave  
  801fef:	c3                   	ret    

00801ff0 <sys_rcr2>:
uint32 sys_rcr2()
{
  801ff0:	55                   	push   %ebp
  801ff1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 25                	push   $0x25
  801fff:	e8 83 fb ff ff       	call   801b87 <syscall>
  802004:	83 c4 18             	add    $0x18,%esp
}
  802007:	c9                   	leave  
  802008:	c3                   	ret    

00802009 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802009:	55                   	push   %ebp
  80200a:	89 e5                	mov    %esp,%ebp
  80200c:	83 ec 04             	sub    $0x4,%esp
  80200f:	8b 45 08             	mov    0x8(%ebp),%eax
  802012:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802015:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802019:	6a 00                	push   $0x0
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	50                   	push   %eax
  802022:	6a 26                	push   $0x26
  802024:	e8 5e fb ff ff       	call   801b87 <syscall>
  802029:	83 c4 18             	add    $0x18,%esp
	return ;
  80202c:	90                   	nop
}
  80202d:	c9                   	leave  
  80202e:	c3                   	ret    

0080202f <rsttst>:
void rsttst()
{
  80202f:	55                   	push   %ebp
  802030:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802032:	6a 00                	push   $0x0
  802034:	6a 00                	push   $0x0
  802036:	6a 00                	push   $0x0
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	6a 28                	push   $0x28
  80203e:	e8 44 fb ff ff       	call   801b87 <syscall>
  802043:	83 c4 18             	add    $0x18,%esp
	return ;
  802046:	90                   	nop
}
  802047:	c9                   	leave  
  802048:	c3                   	ret    

00802049 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802049:	55                   	push   %ebp
  80204a:	89 e5                	mov    %esp,%ebp
  80204c:	83 ec 04             	sub    $0x4,%esp
  80204f:	8b 45 14             	mov    0x14(%ebp),%eax
  802052:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802055:	8b 55 18             	mov    0x18(%ebp),%edx
  802058:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80205c:	52                   	push   %edx
  80205d:	50                   	push   %eax
  80205e:	ff 75 10             	pushl  0x10(%ebp)
  802061:	ff 75 0c             	pushl  0xc(%ebp)
  802064:	ff 75 08             	pushl  0x8(%ebp)
  802067:	6a 27                	push   $0x27
  802069:	e8 19 fb ff ff       	call   801b87 <syscall>
  80206e:	83 c4 18             	add    $0x18,%esp
	return ;
  802071:	90                   	nop
}
  802072:	c9                   	leave  
  802073:	c3                   	ret    

00802074 <chktst>:
void chktst(uint32 n)
{
  802074:	55                   	push   %ebp
  802075:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802077:	6a 00                	push   $0x0
  802079:	6a 00                	push   $0x0
  80207b:	6a 00                	push   $0x0
  80207d:	6a 00                	push   $0x0
  80207f:	ff 75 08             	pushl  0x8(%ebp)
  802082:	6a 29                	push   $0x29
  802084:	e8 fe fa ff ff       	call   801b87 <syscall>
  802089:	83 c4 18             	add    $0x18,%esp
	return ;
  80208c:	90                   	nop
}
  80208d:	c9                   	leave  
  80208e:	c3                   	ret    

0080208f <inctst>:

void inctst()
{
  80208f:	55                   	push   %ebp
  802090:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802092:	6a 00                	push   $0x0
  802094:	6a 00                	push   $0x0
  802096:	6a 00                	push   $0x0
  802098:	6a 00                	push   $0x0
  80209a:	6a 00                	push   $0x0
  80209c:	6a 2a                	push   $0x2a
  80209e:	e8 e4 fa ff ff       	call   801b87 <syscall>
  8020a3:	83 c4 18             	add    $0x18,%esp
	return ;
  8020a6:	90                   	nop
}
  8020a7:	c9                   	leave  
  8020a8:	c3                   	ret    

008020a9 <gettst>:
uint32 gettst()
{
  8020a9:	55                   	push   %ebp
  8020aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 00                	push   $0x0
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 2b                	push   $0x2b
  8020b8:	e8 ca fa ff ff       	call   801b87 <syscall>
  8020bd:	83 c4 18             	add    $0x18,%esp
}
  8020c0:	c9                   	leave  
  8020c1:	c3                   	ret    

008020c2 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8020c2:	55                   	push   %ebp
  8020c3:	89 e5                	mov    %esp,%ebp
  8020c5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020c8:	6a 00                	push   $0x0
  8020ca:	6a 00                	push   $0x0
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 2c                	push   $0x2c
  8020d4:	e8 ae fa ff ff       	call   801b87 <syscall>
  8020d9:	83 c4 18             	add    $0x18,%esp
  8020dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8020df:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8020e3:	75 07                	jne    8020ec <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8020e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8020ea:	eb 05                	jmp    8020f1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8020ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020f1:	c9                   	leave  
  8020f2:	c3                   	ret    

008020f3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8020f3:	55                   	push   %ebp
  8020f4:	89 e5                	mov    %esp,%ebp
  8020f6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020f9:	6a 00                	push   $0x0
  8020fb:	6a 00                	push   $0x0
  8020fd:	6a 00                	push   $0x0
  8020ff:	6a 00                	push   $0x0
  802101:	6a 00                	push   $0x0
  802103:	6a 2c                	push   $0x2c
  802105:	e8 7d fa ff ff       	call   801b87 <syscall>
  80210a:	83 c4 18             	add    $0x18,%esp
  80210d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802110:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802114:	75 07                	jne    80211d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802116:	b8 01 00 00 00       	mov    $0x1,%eax
  80211b:	eb 05                	jmp    802122 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80211d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802122:	c9                   	leave  
  802123:	c3                   	ret    

00802124 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802124:	55                   	push   %ebp
  802125:	89 e5                	mov    %esp,%ebp
  802127:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80212a:	6a 00                	push   $0x0
  80212c:	6a 00                	push   $0x0
  80212e:	6a 00                	push   $0x0
  802130:	6a 00                	push   $0x0
  802132:	6a 00                	push   $0x0
  802134:	6a 2c                	push   $0x2c
  802136:	e8 4c fa ff ff       	call   801b87 <syscall>
  80213b:	83 c4 18             	add    $0x18,%esp
  80213e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802141:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802145:	75 07                	jne    80214e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802147:	b8 01 00 00 00       	mov    $0x1,%eax
  80214c:	eb 05                	jmp    802153 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80214e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802153:	c9                   	leave  
  802154:	c3                   	ret    

00802155 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802155:	55                   	push   %ebp
  802156:	89 e5                	mov    %esp,%ebp
  802158:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80215b:	6a 00                	push   $0x0
  80215d:	6a 00                	push   $0x0
  80215f:	6a 00                	push   $0x0
  802161:	6a 00                	push   $0x0
  802163:	6a 00                	push   $0x0
  802165:	6a 2c                	push   $0x2c
  802167:	e8 1b fa ff ff       	call   801b87 <syscall>
  80216c:	83 c4 18             	add    $0x18,%esp
  80216f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802172:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802176:	75 07                	jne    80217f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802178:	b8 01 00 00 00       	mov    $0x1,%eax
  80217d:	eb 05                	jmp    802184 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80217f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802184:	c9                   	leave  
  802185:	c3                   	ret    

00802186 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802186:	55                   	push   %ebp
  802187:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802189:	6a 00                	push   $0x0
  80218b:	6a 00                	push   $0x0
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	ff 75 08             	pushl  0x8(%ebp)
  802194:	6a 2d                	push   $0x2d
  802196:	e8 ec f9 ff ff       	call   801b87 <syscall>
  80219b:	83 c4 18             	add    $0x18,%esp
	return ;
  80219e:	90                   	nop
}
  80219f:	c9                   	leave  
  8021a0:	c3                   	ret    
  8021a1:	66 90                	xchg   %ax,%ax
  8021a3:	90                   	nop

008021a4 <__udivdi3>:
  8021a4:	55                   	push   %ebp
  8021a5:	57                   	push   %edi
  8021a6:	56                   	push   %esi
  8021a7:	53                   	push   %ebx
  8021a8:	83 ec 1c             	sub    $0x1c,%esp
  8021ab:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021af:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021b3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021b7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021bb:	89 ca                	mov    %ecx,%edx
  8021bd:	89 f8                	mov    %edi,%eax
  8021bf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021c3:	85 f6                	test   %esi,%esi
  8021c5:	75 2d                	jne    8021f4 <__udivdi3+0x50>
  8021c7:	39 cf                	cmp    %ecx,%edi
  8021c9:	77 65                	ja     802230 <__udivdi3+0x8c>
  8021cb:	89 fd                	mov    %edi,%ebp
  8021cd:	85 ff                	test   %edi,%edi
  8021cf:	75 0b                	jne    8021dc <__udivdi3+0x38>
  8021d1:	b8 01 00 00 00       	mov    $0x1,%eax
  8021d6:	31 d2                	xor    %edx,%edx
  8021d8:	f7 f7                	div    %edi
  8021da:	89 c5                	mov    %eax,%ebp
  8021dc:	31 d2                	xor    %edx,%edx
  8021de:	89 c8                	mov    %ecx,%eax
  8021e0:	f7 f5                	div    %ebp
  8021e2:	89 c1                	mov    %eax,%ecx
  8021e4:	89 d8                	mov    %ebx,%eax
  8021e6:	f7 f5                	div    %ebp
  8021e8:	89 cf                	mov    %ecx,%edi
  8021ea:	89 fa                	mov    %edi,%edx
  8021ec:	83 c4 1c             	add    $0x1c,%esp
  8021ef:	5b                   	pop    %ebx
  8021f0:	5e                   	pop    %esi
  8021f1:	5f                   	pop    %edi
  8021f2:	5d                   	pop    %ebp
  8021f3:	c3                   	ret    
  8021f4:	39 ce                	cmp    %ecx,%esi
  8021f6:	77 28                	ja     802220 <__udivdi3+0x7c>
  8021f8:	0f bd fe             	bsr    %esi,%edi
  8021fb:	83 f7 1f             	xor    $0x1f,%edi
  8021fe:	75 40                	jne    802240 <__udivdi3+0x9c>
  802200:	39 ce                	cmp    %ecx,%esi
  802202:	72 0a                	jb     80220e <__udivdi3+0x6a>
  802204:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802208:	0f 87 9e 00 00 00    	ja     8022ac <__udivdi3+0x108>
  80220e:	b8 01 00 00 00       	mov    $0x1,%eax
  802213:	89 fa                	mov    %edi,%edx
  802215:	83 c4 1c             	add    $0x1c,%esp
  802218:	5b                   	pop    %ebx
  802219:	5e                   	pop    %esi
  80221a:	5f                   	pop    %edi
  80221b:	5d                   	pop    %ebp
  80221c:	c3                   	ret    
  80221d:	8d 76 00             	lea    0x0(%esi),%esi
  802220:	31 ff                	xor    %edi,%edi
  802222:	31 c0                	xor    %eax,%eax
  802224:	89 fa                	mov    %edi,%edx
  802226:	83 c4 1c             	add    $0x1c,%esp
  802229:	5b                   	pop    %ebx
  80222a:	5e                   	pop    %esi
  80222b:	5f                   	pop    %edi
  80222c:	5d                   	pop    %ebp
  80222d:	c3                   	ret    
  80222e:	66 90                	xchg   %ax,%ax
  802230:	89 d8                	mov    %ebx,%eax
  802232:	f7 f7                	div    %edi
  802234:	31 ff                	xor    %edi,%edi
  802236:	89 fa                	mov    %edi,%edx
  802238:	83 c4 1c             	add    $0x1c,%esp
  80223b:	5b                   	pop    %ebx
  80223c:	5e                   	pop    %esi
  80223d:	5f                   	pop    %edi
  80223e:	5d                   	pop    %ebp
  80223f:	c3                   	ret    
  802240:	bd 20 00 00 00       	mov    $0x20,%ebp
  802245:	89 eb                	mov    %ebp,%ebx
  802247:	29 fb                	sub    %edi,%ebx
  802249:	89 f9                	mov    %edi,%ecx
  80224b:	d3 e6                	shl    %cl,%esi
  80224d:	89 c5                	mov    %eax,%ebp
  80224f:	88 d9                	mov    %bl,%cl
  802251:	d3 ed                	shr    %cl,%ebp
  802253:	89 e9                	mov    %ebp,%ecx
  802255:	09 f1                	or     %esi,%ecx
  802257:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80225b:	89 f9                	mov    %edi,%ecx
  80225d:	d3 e0                	shl    %cl,%eax
  80225f:	89 c5                	mov    %eax,%ebp
  802261:	89 d6                	mov    %edx,%esi
  802263:	88 d9                	mov    %bl,%cl
  802265:	d3 ee                	shr    %cl,%esi
  802267:	89 f9                	mov    %edi,%ecx
  802269:	d3 e2                	shl    %cl,%edx
  80226b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80226f:	88 d9                	mov    %bl,%cl
  802271:	d3 e8                	shr    %cl,%eax
  802273:	09 c2                	or     %eax,%edx
  802275:	89 d0                	mov    %edx,%eax
  802277:	89 f2                	mov    %esi,%edx
  802279:	f7 74 24 0c          	divl   0xc(%esp)
  80227d:	89 d6                	mov    %edx,%esi
  80227f:	89 c3                	mov    %eax,%ebx
  802281:	f7 e5                	mul    %ebp
  802283:	39 d6                	cmp    %edx,%esi
  802285:	72 19                	jb     8022a0 <__udivdi3+0xfc>
  802287:	74 0b                	je     802294 <__udivdi3+0xf0>
  802289:	89 d8                	mov    %ebx,%eax
  80228b:	31 ff                	xor    %edi,%edi
  80228d:	e9 58 ff ff ff       	jmp    8021ea <__udivdi3+0x46>
  802292:	66 90                	xchg   %ax,%ax
  802294:	8b 54 24 08          	mov    0x8(%esp),%edx
  802298:	89 f9                	mov    %edi,%ecx
  80229a:	d3 e2                	shl    %cl,%edx
  80229c:	39 c2                	cmp    %eax,%edx
  80229e:	73 e9                	jae    802289 <__udivdi3+0xe5>
  8022a0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022a3:	31 ff                	xor    %edi,%edi
  8022a5:	e9 40 ff ff ff       	jmp    8021ea <__udivdi3+0x46>
  8022aa:	66 90                	xchg   %ax,%ax
  8022ac:	31 c0                	xor    %eax,%eax
  8022ae:	e9 37 ff ff ff       	jmp    8021ea <__udivdi3+0x46>
  8022b3:	90                   	nop

008022b4 <__umoddi3>:
  8022b4:	55                   	push   %ebp
  8022b5:	57                   	push   %edi
  8022b6:	56                   	push   %esi
  8022b7:	53                   	push   %ebx
  8022b8:	83 ec 1c             	sub    $0x1c,%esp
  8022bb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022bf:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022c3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022c7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022cb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022cf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022d3:	89 f3                	mov    %esi,%ebx
  8022d5:	89 fa                	mov    %edi,%edx
  8022d7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022db:	89 34 24             	mov    %esi,(%esp)
  8022de:	85 c0                	test   %eax,%eax
  8022e0:	75 1a                	jne    8022fc <__umoddi3+0x48>
  8022e2:	39 f7                	cmp    %esi,%edi
  8022e4:	0f 86 a2 00 00 00    	jbe    80238c <__umoddi3+0xd8>
  8022ea:	89 c8                	mov    %ecx,%eax
  8022ec:	89 f2                	mov    %esi,%edx
  8022ee:	f7 f7                	div    %edi
  8022f0:	89 d0                	mov    %edx,%eax
  8022f2:	31 d2                	xor    %edx,%edx
  8022f4:	83 c4 1c             	add    $0x1c,%esp
  8022f7:	5b                   	pop    %ebx
  8022f8:	5e                   	pop    %esi
  8022f9:	5f                   	pop    %edi
  8022fa:	5d                   	pop    %ebp
  8022fb:	c3                   	ret    
  8022fc:	39 f0                	cmp    %esi,%eax
  8022fe:	0f 87 ac 00 00 00    	ja     8023b0 <__umoddi3+0xfc>
  802304:	0f bd e8             	bsr    %eax,%ebp
  802307:	83 f5 1f             	xor    $0x1f,%ebp
  80230a:	0f 84 ac 00 00 00    	je     8023bc <__umoddi3+0x108>
  802310:	bf 20 00 00 00       	mov    $0x20,%edi
  802315:	29 ef                	sub    %ebp,%edi
  802317:	89 fe                	mov    %edi,%esi
  802319:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80231d:	89 e9                	mov    %ebp,%ecx
  80231f:	d3 e0                	shl    %cl,%eax
  802321:	89 d7                	mov    %edx,%edi
  802323:	89 f1                	mov    %esi,%ecx
  802325:	d3 ef                	shr    %cl,%edi
  802327:	09 c7                	or     %eax,%edi
  802329:	89 e9                	mov    %ebp,%ecx
  80232b:	d3 e2                	shl    %cl,%edx
  80232d:	89 14 24             	mov    %edx,(%esp)
  802330:	89 d8                	mov    %ebx,%eax
  802332:	d3 e0                	shl    %cl,%eax
  802334:	89 c2                	mov    %eax,%edx
  802336:	8b 44 24 08          	mov    0x8(%esp),%eax
  80233a:	d3 e0                	shl    %cl,%eax
  80233c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802340:	8b 44 24 08          	mov    0x8(%esp),%eax
  802344:	89 f1                	mov    %esi,%ecx
  802346:	d3 e8                	shr    %cl,%eax
  802348:	09 d0                	or     %edx,%eax
  80234a:	d3 eb                	shr    %cl,%ebx
  80234c:	89 da                	mov    %ebx,%edx
  80234e:	f7 f7                	div    %edi
  802350:	89 d3                	mov    %edx,%ebx
  802352:	f7 24 24             	mull   (%esp)
  802355:	89 c6                	mov    %eax,%esi
  802357:	89 d1                	mov    %edx,%ecx
  802359:	39 d3                	cmp    %edx,%ebx
  80235b:	0f 82 87 00 00 00    	jb     8023e8 <__umoddi3+0x134>
  802361:	0f 84 91 00 00 00    	je     8023f8 <__umoddi3+0x144>
  802367:	8b 54 24 04          	mov    0x4(%esp),%edx
  80236b:	29 f2                	sub    %esi,%edx
  80236d:	19 cb                	sbb    %ecx,%ebx
  80236f:	89 d8                	mov    %ebx,%eax
  802371:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802375:	d3 e0                	shl    %cl,%eax
  802377:	89 e9                	mov    %ebp,%ecx
  802379:	d3 ea                	shr    %cl,%edx
  80237b:	09 d0                	or     %edx,%eax
  80237d:	89 e9                	mov    %ebp,%ecx
  80237f:	d3 eb                	shr    %cl,%ebx
  802381:	89 da                	mov    %ebx,%edx
  802383:	83 c4 1c             	add    $0x1c,%esp
  802386:	5b                   	pop    %ebx
  802387:	5e                   	pop    %esi
  802388:	5f                   	pop    %edi
  802389:	5d                   	pop    %ebp
  80238a:	c3                   	ret    
  80238b:	90                   	nop
  80238c:	89 fd                	mov    %edi,%ebp
  80238e:	85 ff                	test   %edi,%edi
  802390:	75 0b                	jne    80239d <__umoddi3+0xe9>
  802392:	b8 01 00 00 00       	mov    $0x1,%eax
  802397:	31 d2                	xor    %edx,%edx
  802399:	f7 f7                	div    %edi
  80239b:	89 c5                	mov    %eax,%ebp
  80239d:	89 f0                	mov    %esi,%eax
  80239f:	31 d2                	xor    %edx,%edx
  8023a1:	f7 f5                	div    %ebp
  8023a3:	89 c8                	mov    %ecx,%eax
  8023a5:	f7 f5                	div    %ebp
  8023a7:	89 d0                	mov    %edx,%eax
  8023a9:	e9 44 ff ff ff       	jmp    8022f2 <__umoddi3+0x3e>
  8023ae:	66 90                	xchg   %ax,%ax
  8023b0:	89 c8                	mov    %ecx,%eax
  8023b2:	89 f2                	mov    %esi,%edx
  8023b4:	83 c4 1c             	add    $0x1c,%esp
  8023b7:	5b                   	pop    %ebx
  8023b8:	5e                   	pop    %esi
  8023b9:	5f                   	pop    %edi
  8023ba:	5d                   	pop    %ebp
  8023bb:	c3                   	ret    
  8023bc:	3b 04 24             	cmp    (%esp),%eax
  8023bf:	72 06                	jb     8023c7 <__umoddi3+0x113>
  8023c1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023c5:	77 0f                	ja     8023d6 <__umoddi3+0x122>
  8023c7:	89 f2                	mov    %esi,%edx
  8023c9:	29 f9                	sub    %edi,%ecx
  8023cb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023cf:	89 14 24             	mov    %edx,(%esp)
  8023d2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023d6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023da:	8b 14 24             	mov    (%esp),%edx
  8023dd:	83 c4 1c             	add    $0x1c,%esp
  8023e0:	5b                   	pop    %ebx
  8023e1:	5e                   	pop    %esi
  8023e2:	5f                   	pop    %edi
  8023e3:	5d                   	pop    %ebp
  8023e4:	c3                   	ret    
  8023e5:	8d 76 00             	lea    0x0(%esi),%esi
  8023e8:	2b 04 24             	sub    (%esp),%eax
  8023eb:	19 fa                	sbb    %edi,%edx
  8023ed:	89 d1                	mov    %edx,%ecx
  8023ef:	89 c6                	mov    %eax,%esi
  8023f1:	e9 71 ff ff ff       	jmp    802367 <__umoddi3+0xb3>
  8023f6:	66 90                	xchg   %ax,%ax
  8023f8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023fc:	72 ea                	jb     8023e8 <__umoddi3+0x134>
  8023fe:	89 d9                	mov    %ebx,%ecx
  802400:	e9 62 ff ff ff       	jmp    802367 <__umoddi3+0xb3>
