
obj/user/arrayOperations_quicksort:     file format elf32-i386


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
  800031:	e8 20 03 00 00       	call   800356 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int32 envID = sys_getenvid();
  80003e:	e8 8b 15 00 00       	call   8015ce <sys_getenvid>
  800043:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int32 parentenvID = sys_getparentenvid();
  800046:	e8 b5 15 00 00       	call   801600 <sys_getparentenvid>
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)

	int ret;
	/*[1] GET SHARED VARs*/
	//Get the shared array & its size
	int *numOfElements = NULL;
  80004e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	int *sharedArray = NULL;
  800055:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	sharedArray = sget(parentenvID,"arr") ;
  80005c:	83 ec 08             	sub    $0x8,%esp
  80005f:	68 c0 1f 80 00       	push   $0x801fc0
  800064:	ff 75 ec             	pushl  -0x14(%ebp)
  800067:	e8 6a 12 00 00       	call   8012d6 <sget>
  80006c:	83 c4 10             	add    $0x10,%esp
  80006f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	numOfElements = sget(parentenvID,"arrSize") ;
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 c4 1f 80 00       	push   $0x801fc4
  80007a:	ff 75 ec             	pushl  -0x14(%ebp)
  80007d:	e8 54 12 00 00       	call   8012d6 <sget>
  800082:	83 c4 10             	add    $0x10,%esp
  800085:	89 45 e8             	mov    %eax,-0x18(%ebp)

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800088:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	finishedCount = sget(parentenvID,"finishedCount") ;
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	68 cc 1f 80 00       	push   $0x801fcc
  800097:	ff 75 ec             	pushl  -0x14(%ebp)
  80009a:	e8 37 12 00 00       	call   8012d6 <sget>
  80009f:	83 c4 10             	add    $0x10,%esp
  8000a2:	89 45 e0             	mov    %eax,-0x20(%ebp)

	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("quicksortedArr", sizeof(int) * *numOfElements, 0) ;
  8000a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000a8:	8b 00                	mov    (%eax),%eax
  8000aa:	c1 e0 02             	shl    $0x2,%eax
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 00                	push   $0x0
  8000b2:	50                   	push   %eax
  8000b3:	68 da 1f 80 00       	push   $0x801fda
  8000b8:	e8 f9 11 00 00       	call   8012b6 <smalloc>
  8000bd:	83 c4 10             	add    $0x10,%esp
  8000c0:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000ca:	eb 25                	jmp    8000f1 <_main+0xb9>
	{
		sortedArray[i] = sharedArray[i];
  8000cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000d9:	01 c2                	add    %eax,%edx
  8000db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000de:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000e8:	01 c8                	add    %ecx,%eax
  8000ea:	8b 00                	mov    (%eax),%eax
  8000ec:	89 02                	mov    %eax,(%edx)
	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("quicksortedArr", sizeof(int) * *numOfElements, 0) ;
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000ee:	ff 45 f4             	incl   -0xc(%ebp)
  8000f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000f4:	8b 00                	mov    (%eax),%eax
  8000f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f9:	7f d1                	jg     8000cc <_main+0x94>
	{
		sortedArray[i] = sharedArray[i];
	}
	QuickSort(sortedArray, *numOfElements);
  8000fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000fe:	8b 00                	mov    (%eax),%eax
  800100:	83 ec 08             	sub    $0x8,%esp
  800103:	50                   	push   %eax
  800104:	ff 75 dc             	pushl  -0x24(%ebp)
  800107:	e8 23 00 00 00       	call   80012f <QuickSort>
  80010c:	83 c4 10             	add    $0x10,%esp
	cprintf("Quick sort is Finished!!!!\n") ;
  80010f:	83 ec 0c             	sub    $0xc,%esp
  800112:	68 e9 1f 80 00       	push   $0x801fe9
  800117:	e8 10 04 00 00       	call   80052c <cprintf>
  80011c:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THE RESULTS & DECLARE FINISHING*/
	(*finishedCount)++ ;
  80011f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800122:	8b 00                	mov    (%eax),%eax
  800124:	8d 50 01             	lea    0x1(%eax),%edx
  800127:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80012a:	89 10                	mov    %edx,(%eax)

}
  80012c:	90                   	nop
  80012d:	c9                   	leave  
  80012e:	c3                   	ret    

0080012f <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  80012f:	55                   	push   %ebp
  800130:	89 e5                	mov    %esp,%ebp
  800132:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800135:	8b 45 0c             	mov    0xc(%ebp),%eax
  800138:	48                   	dec    %eax
  800139:	50                   	push   %eax
  80013a:	6a 00                	push   $0x0
  80013c:	ff 75 0c             	pushl  0xc(%ebp)
  80013f:	ff 75 08             	pushl  0x8(%ebp)
  800142:	e8 06 00 00 00       	call   80014d <QSort>
  800147:	83 c4 10             	add    $0x10,%esp
}
  80014a:	90                   	nop
  80014b:	c9                   	leave  
  80014c:	c3                   	ret    

0080014d <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  80014d:	55                   	push   %ebp
  80014e:	89 e5                	mov    %esp,%ebp
  800150:	83 ec 28             	sub    $0x28,%esp
	if (startIndex >= finalIndex) return;
  800153:	8b 45 10             	mov    0x10(%ebp),%eax
  800156:	3b 45 14             	cmp    0x14(%ebp),%eax
  800159:	0f 8d 1b 01 00 00    	jge    80027a <QSort+0x12d>
	int pvtIndex = RAND(startIndex, finalIndex) ;
  80015f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  800162:	83 ec 0c             	sub    $0xc,%esp
  800165:	50                   	push   %eax
  800166:	e8 f1 17 00 00       	call   80195c <sys_get_virtual_time>
  80016b:	83 c4 0c             	add    $0xc,%esp
  80016e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800171:	8b 55 14             	mov    0x14(%ebp),%edx
  800174:	2b 55 10             	sub    0x10(%ebp),%edx
  800177:	89 d1                	mov    %edx,%ecx
  800179:	ba 00 00 00 00       	mov    $0x0,%edx
  80017e:	f7 f1                	div    %ecx
  800180:	8b 45 10             	mov    0x10(%ebp),%eax
  800183:	01 d0                	add    %edx,%eax
  800185:	89 45 ec             	mov    %eax,-0x14(%ebp)
	Swap(Elements, startIndex, pvtIndex);
  800188:	83 ec 04             	sub    $0x4,%esp
  80018b:	ff 75 ec             	pushl  -0x14(%ebp)
  80018e:	ff 75 10             	pushl  0x10(%ebp)
  800191:	ff 75 08             	pushl  0x8(%ebp)
  800194:	e8 e4 00 00 00       	call   80027d <Swap>
  800199:	83 c4 10             	add    $0x10,%esp

	int i = startIndex+1, j = finalIndex;
  80019c:	8b 45 10             	mov    0x10(%ebp),%eax
  80019f:	40                   	inc    %eax
  8001a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8001a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8001a6:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8001a9:	e9 80 00 00 00       	jmp    80022e <QSort+0xe1>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8001ae:	ff 45 f4             	incl   -0xc(%ebp)
  8001b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001b4:	3b 45 14             	cmp    0x14(%ebp),%eax
  8001b7:	7f 2b                	jg     8001e4 <QSort+0x97>
  8001b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8001bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8001c6:	01 d0                	add    %edx,%eax
  8001c8:	8b 10                	mov    (%eax),%edx
  8001ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8001d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8001d7:	01 c8                	add    %ecx,%eax
  8001d9:	8b 00                	mov    (%eax),%eax
  8001db:	39 c2                	cmp    %eax,%edx
  8001dd:	7d cf                	jge    8001ae <QSort+0x61>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8001df:	eb 03                	jmp    8001e4 <QSort+0x97>
  8001e1:	ff 4d f0             	decl   -0x10(%ebp)
  8001e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8001e7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8001ea:	7e 26                	jle    800212 <QSort+0xc5>
  8001ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8001ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8001f9:	01 d0                	add    %edx,%eax
  8001fb:	8b 10                	mov    (%eax),%edx
  8001fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800200:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800207:	8b 45 08             	mov    0x8(%ebp),%eax
  80020a:	01 c8                	add    %ecx,%eax
  80020c:	8b 00                	mov    (%eax),%eax
  80020e:	39 c2                	cmp    %eax,%edx
  800210:	7e cf                	jle    8001e1 <QSort+0x94>

		if (i <= j)
  800212:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800215:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800218:	7f 14                	jg     80022e <QSort+0xe1>
		{
			Swap(Elements, i, j);
  80021a:	83 ec 04             	sub    $0x4,%esp
  80021d:	ff 75 f0             	pushl  -0x10(%ebp)
  800220:	ff 75 f4             	pushl  -0xc(%ebp)
  800223:	ff 75 08             	pushl  0x8(%ebp)
  800226:	e8 52 00 00 00       	call   80027d <Swap>
  80022b:	83 c4 10             	add    $0x10,%esp
	int pvtIndex = RAND(startIndex, finalIndex) ;
	Swap(Elements, startIndex, pvtIndex);

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  80022e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800231:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800234:	0f 8e 77 ff ff ff    	jle    8001b1 <QSort+0x64>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	ff 75 f0             	pushl  -0x10(%ebp)
  800240:	ff 75 10             	pushl  0x10(%ebp)
  800243:	ff 75 08             	pushl  0x8(%ebp)
  800246:	e8 32 00 00 00       	call   80027d <Swap>
  80024b:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80024e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800251:	48                   	dec    %eax
  800252:	50                   	push   %eax
  800253:	ff 75 10             	pushl  0x10(%ebp)
  800256:	ff 75 0c             	pushl  0xc(%ebp)
  800259:	ff 75 08             	pushl  0x8(%ebp)
  80025c:	e8 ec fe ff ff       	call   80014d <QSort>
  800261:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800264:	ff 75 14             	pushl  0x14(%ebp)
  800267:	ff 75 f4             	pushl  -0xc(%ebp)
  80026a:	ff 75 0c             	pushl  0xc(%ebp)
  80026d:	ff 75 08             	pushl  0x8(%ebp)
  800270:	e8 d8 fe ff ff       	call   80014d <QSort>
  800275:	83 c4 10             	add    $0x10,%esp
  800278:	eb 01                	jmp    80027b <QSort+0x12e>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  80027a:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  80027b:	c9                   	leave  
  80027c:	c3                   	ret    

0080027d <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80027d:	55                   	push   %ebp
  80027e:	89 e5                	mov    %esp,%ebp
  800280:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800283:	8b 45 0c             	mov    0xc(%ebp),%eax
  800286:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80028d:	8b 45 08             	mov    0x8(%ebp),%eax
  800290:	01 d0                	add    %edx,%eax
  800292:	8b 00                	mov    (%eax),%eax
  800294:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80029a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a4:	01 c2                	add    %eax,%edx
  8002a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b3:	01 c8                	add    %ecx,%eax
  8002b5:	8b 00                	mov    (%eax),%eax
  8002b7:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8002b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8002bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c6:	01 c2                	add    %eax,%edx
  8002c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8002cb:	89 02                	mov    %eax,(%edx)
}
  8002cd:	90                   	nop
  8002ce:	c9                   	leave  
  8002cf:	c3                   	ret    

008002d0 <PrintElements>:


void PrintElements(int *Elements, int NumOfElements)
{
  8002d0:	55                   	push   %ebp
  8002d1:	89 e5                	mov    %esp,%ebp
  8002d3:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8002d6:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8002dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002e4:	eb 42                	jmp    800328 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8002e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002e9:	99                   	cltd   
  8002ea:	f7 7d f0             	idivl  -0x10(%ebp)
  8002ed:	89 d0                	mov    %edx,%eax
  8002ef:	85 c0                	test   %eax,%eax
  8002f1:	75 10                	jne    800303 <PrintElements+0x33>
			cprintf("\n");
  8002f3:	83 ec 0c             	sub    $0xc,%esp
  8002f6:	68 05 20 80 00       	push   $0x802005
  8002fb:	e8 2c 02 00 00       	call   80052c <cprintf>
  800300:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800303:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800306:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80030d:	8b 45 08             	mov    0x8(%ebp),%eax
  800310:	01 d0                	add    %edx,%eax
  800312:	8b 00                	mov    (%eax),%eax
  800314:	83 ec 08             	sub    $0x8,%esp
  800317:	50                   	push   %eax
  800318:	68 07 20 80 00       	push   $0x802007
  80031d:	e8 0a 02 00 00       	call   80052c <cprintf>
  800322:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800325:	ff 45 f4             	incl   -0xc(%ebp)
  800328:	8b 45 0c             	mov    0xc(%ebp),%eax
  80032b:	48                   	dec    %eax
  80032c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80032f:	7f b5                	jg     8002e6 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800331:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800334:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033b:	8b 45 08             	mov    0x8(%ebp),%eax
  80033e:	01 d0                	add    %edx,%eax
  800340:	8b 00                	mov    (%eax),%eax
  800342:	83 ec 08             	sub    $0x8,%esp
  800345:	50                   	push   %eax
  800346:	68 0c 20 80 00       	push   $0x80200c
  80034b:	e8 dc 01 00 00       	call   80052c <cprintf>
  800350:	83 c4 10             	add    $0x10,%esp

}
  800353:	90                   	nop
  800354:	c9                   	leave  
  800355:	c3                   	ret    

00800356 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800356:	55                   	push   %ebp
  800357:	89 e5                	mov    %esp,%ebp
  800359:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80035c:	e8 86 12 00 00       	call   8015e7 <sys_getenvindex>
  800361:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800364:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800367:	89 d0                	mov    %edx,%eax
  800369:	01 c0                	add    %eax,%eax
  80036b:	01 d0                	add    %edx,%eax
  80036d:	c1 e0 02             	shl    $0x2,%eax
  800370:	01 d0                	add    %edx,%eax
  800372:	c1 e0 06             	shl    $0x6,%eax
  800375:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80037a:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80037f:	a1 20 30 80 00       	mov    0x803020,%eax
  800384:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80038a:	84 c0                	test   %al,%al
  80038c:	74 0f                	je     80039d <libmain+0x47>
		binaryname = myEnv->prog_name;
  80038e:	a1 20 30 80 00       	mov    0x803020,%eax
  800393:	05 f4 02 00 00       	add    $0x2f4,%eax
  800398:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80039d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003a1:	7e 0a                	jle    8003ad <libmain+0x57>
		binaryname = argv[0];
  8003a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8003ad:	83 ec 08             	sub    $0x8,%esp
  8003b0:	ff 75 0c             	pushl  0xc(%ebp)
  8003b3:	ff 75 08             	pushl  0x8(%ebp)
  8003b6:	e8 7d fc ff ff       	call   800038 <_main>
  8003bb:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003be:	e8 bf 13 00 00       	call   801782 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003c3:	83 ec 0c             	sub    $0xc,%esp
  8003c6:	68 28 20 80 00       	push   $0x802028
  8003cb:	e8 5c 01 00 00       	call   80052c <cprintf>
  8003d0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d8:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8003de:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e3:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8003e9:	83 ec 04             	sub    $0x4,%esp
  8003ec:	52                   	push   %edx
  8003ed:	50                   	push   %eax
  8003ee:	68 50 20 80 00       	push   $0x802050
  8003f3:	e8 34 01 00 00       	call   80052c <cprintf>
  8003f8:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8003fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800400:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800406:	83 ec 08             	sub    $0x8,%esp
  800409:	50                   	push   %eax
  80040a:	68 75 20 80 00       	push   $0x802075
  80040f:	e8 18 01 00 00       	call   80052c <cprintf>
  800414:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800417:	83 ec 0c             	sub    $0xc,%esp
  80041a:	68 28 20 80 00       	push   $0x802028
  80041f:	e8 08 01 00 00       	call   80052c <cprintf>
  800424:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800427:	e8 70 13 00 00       	call   80179c <sys_enable_interrupt>

	// exit gracefully
	exit();
  80042c:	e8 19 00 00 00       	call   80044a <exit>
}
  800431:	90                   	nop
  800432:	c9                   	leave  
  800433:	c3                   	ret    

00800434 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800434:	55                   	push   %ebp
  800435:	89 e5                	mov    %esp,%ebp
  800437:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80043a:	83 ec 0c             	sub    $0xc,%esp
  80043d:	6a 00                	push   $0x0
  80043f:	e8 6f 11 00 00       	call   8015b3 <sys_env_destroy>
  800444:	83 c4 10             	add    $0x10,%esp
}
  800447:	90                   	nop
  800448:	c9                   	leave  
  800449:	c3                   	ret    

0080044a <exit>:

void
exit(void)
{
  80044a:	55                   	push   %ebp
  80044b:	89 e5                	mov    %esp,%ebp
  80044d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800450:	e8 c4 11 00 00       	call   801619 <sys_env_exit>
}
  800455:	90                   	nop
  800456:	c9                   	leave  
  800457:	c3                   	ret    

00800458 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800458:	55                   	push   %ebp
  800459:	89 e5                	mov    %esp,%ebp
  80045b:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80045e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800461:	8b 00                	mov    (%eax),%eax
  800463:	8d 48 01             	lea    0x1(%eax),%ecx
  800466:	8b 55 0c             	mov    0xc(%ebp),%edx
  800469:	89 0a                	mov    %ecx,(%edx)
  80046b:	8b 55 08             	mov    0x8(%ebp),%edx
  80046e:	88 d1                	mov    %dl,%cl
  800470:	8b 55 0c             	mov    0xc(%ebp),%edx
  800473:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800477:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047a:	8b 00                	mov    (%eax),%eax
  80047c:	3d ff 00 00 00       	cmp    $0xff,%eax
  800481:	75 2c                	jne    8004af <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800483:	a0 24 30 80 00       	mov    0x803024,%al
  800488:	0f b6 c0             	movzbl %al,%eax
  80048b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80048e:	8b 12                	mov    (%edx),%edx
  800490:	89 d1                	mov    %edx,%ecx
  800492:	8b 55 0c             	mov    0xc(%ebp),%edx
  800495:	83 c2 08             	add    $0x8,%edx
  800498:	83 ec 04             	sub    $0x4,%esp
  80049b:	50                   	push   %eax
  80049c:	51                   	push   %ecx
  80049d:	52                   	push   %edx
  80049e:	e8 ce 10 00 00       	call   801571 <sys_cputs>
  8004a3:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b2:	8b 40 04             	mov    0x4(%eax),%eax
  8004b5:	8d 50 01             	lea    0x1(%eax),%edx
  8004b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bb:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004be:	90                   	nop
  8004bf:	c9                   	leave  
  8004c0:	c3                   	ret    

008004c1 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004c1:	55                   	push   %ebp
  8004c2:	89 e5                	mov    %esp,%ebp
  8004c4:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004ca:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004d1:	00 00 00 
	b.cnt = 0;
  8004d4:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004db:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004de:	ff 75 0c             	pushl  0xc(%ebp)
  8004e1:	ff 75 08             	pushl  0x8(%ebp)
  8004e4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004ea:	50                   	push   %eax
  8004eb:	68 58 04 80 00       	push   $0x800458
  8004f0:	e8 11 02 00 00       	call   800706 <vprintfmt>
  8004f5:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004f8:	a0 24 30 80 00       	mov    0x803024,%al
  8004fd:	0f b6 c0             	movzbl %al,%eax
  800500:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800506:	83 ec 04             	sub    $0x4,%esp
  800509:	50                   	push   %eax
  80050a:	52                   	push   %edx
  80050b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800511:	83 c0 08             	add    $0x8,%eax
  800514:	50                   	push   %eax
  800515:	e8 57 10 00 00       	call   801571 <sys_cputs>
  80051a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80051d:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800524:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80052a:	c9                   	leave  
  80052b:	c3                   	ret    

0080052c <cprintf>:

int cprintf(const char *fmt, ...) {
  80052c:	55                   	push   %ebp
  80052d:	89 e5                	mov    %esp,%ebp
  80052f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800532:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800539:	8d 45 0c             	lea    0xc(%ebp),%eax
  80053c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80053f:	8b 45 08             	mov    0x8(%ebp),%eax
  800542:	83 ec 08             	sub    $0x8,%esp
  800545:	ff 75 f4             	pushl  -0xc(%ebp)
  800548:	50                   	push   %eax
  800549:	e8 73 ff ff ff       	call   8004c1 <vcprintf>
  80054e:	83 c4 10             	add    $0x10,%esp
  800551:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800554:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800557:	c9                   	leave  
  800558:	c3                   	ret    

00800559 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800559:	55                   	push   %ebp
  80055a:	89 e5                	mov    %esp,%ebp
  80055c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80055f:	e8 1e 12 00 00       	call   801782 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800564:	8d 45 0c             	lea    0xc(%ebp),%eax
  800567:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80056a:	8b 45 08             	mov    0x8(%ebp),%eax
  80056d:	83 ec 08             	sub    $0x8,%esp
  800570:	ff 75 f4             	pushl  -0xc(%ebp)
  800573:	50                   	push   %eax
  800574:	e8 48 ff ff ff       	call   8004c1 <vcprintf>
  800579:	83 c4 10             	add    $0x10,%esp
  80057c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80057f:	e8 18 12 00 00       	call   80179c <sys_enable_interrupt>
	return cnt;
  800584:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800587:	c9                   	leave  
  800588:	c3                   	ret    

00800589 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800589:	55                   	push   %ebp
  80058a:	89 e5                	mov    %esp,%ebp
  80058c:	53                   	push   %ebx
  80058d:	83 ec 14             	sub    $0x14,%esp
  800590:	8b 45 10             	mov    0x10(%ebp),%eax
  800593:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800596:	8b 45 14             	mov    0x14(%ebp),%eax
  800599:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80059c:	8b 45 18             	mov    0x18(%ebp),%eax
  80059f:	ba 00 00 00 00       	mov    $0x0,%edx
  8005a4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005a7:	77 55                	ja     8005fe <printnum+0x75>
  8005a9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005ac:	72 05                	jb     8005b3 <printnum+0x2a>
  8005ae:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005b1:	77 4b                	ja     8005fe <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005b3:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005b6:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005b9:	8b 45 18             	mov    0x18(%ebp),%eax
  8005bc:	ba 00 00 00 00       	mov    $0x0,%edx
  8005c1:	52                   	push   %edx
  8005c2:	50                   	push   %eax
  8005c3:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c6:	ff 75 f0             	pushl  -0x10(%ebp)
  8005c9:	e8 72 17 00 00       	call   801d40 <__udivdi3>
  8005ce:	83 c4 10             	add    $0x10,%esp
  8005d1:	83 ec 04             	sub    $0x4,%esp
  8005d4:	ff 75 20             	pushl  0x20(%ebp)
  8005d7:	53                   	push   %ebx
  8005d8:	ff 75 18             	pushl  0x18(%ebp)
  8005db:	52                   	push   %edx
  8005dc:	50                   	push   %eax
  8005dd:	ff 75 0c             	pushl  0xc(%ebp)
  8005e0:	ff 75 08             	pushl  0x8(%ebp)
  8005e3:	e8 a1 ff ff ff       	call   800589 <printnum>
  8005e8:	83 c4 20             	add    $0x20,%esp
  8005eb:	eb 1a                	jmp    800607 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005ed:	83 ec 08             	sub    $0x8,%esp
  8005f0:	ff 75 0c             	pushl  0xc(%ebp)
  8005f3:	ff 75 20             	pushl  0x20(%ebp)
  8005f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f9:	ff d0                	call   *%eax
  8005fb:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005fe:	ff 4d 1c             	decl   0x1c(%ebp)
  800601:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800605:	7f e6                	jg     8005ed <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800607:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80060a:	bb 00 00 00 00       	mov    $0x0,%ebx
  80060f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800612:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800615:	53                   	push   %ebx
  800616:	51                   	push   %ecx
  800617:	52                   	push   %edx
  800618:	50                   	push   %eax
  800619:	e8 32 18 00 00       	call   801e50 <__umoddi3>
  80061e:	83 c4 10             	add    $0x10,%esp
  800621:	05 b4 22 80 00       	add    $0x8022b4,%eax
  800626:	8a 00                	mov    (%eax),%al
  800628:	0f be c0             	movsbl %al,%eax
  80062b:	83 ec 08             	sub    $0x8,%esp
  80062e:	ff 75 0c             	pushl  0xc(%ebp)
  800631:	50                   	push   %eax
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	ff d0                	call   *%eax
  800637:	83 c4 10             	add    $0x10,%esp
}
  80063a:	90                   	nop
  80063b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80063e:	c9                   	leave  
  80063f:	c3                   	ret    

00800640 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800640:	55                   	push   %ebp
  800641:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800643:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800647:	7e 1c                	jle    800665 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800649:	8b 45 08             	mov    0x8(%ebp),%eax
  80064c:	8b 00                	mov    (%eax),%eax
  80064e:	8d 50 08             	lea    0x8(%eax),%edx
  800651:	8b 45 08             	mov    0x8(%ebp),%eax
  800654:	89 10                	mov    %edx,(%eax)
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	8b 00                	mov    (%eax),%eax
  80065b:	83 e8 08             	sub    $0x8,%eax
  80065e:	8b 50 04             	mov    0x4(%eax),%edx
  800661:	8b 00                	mov    (%eax),%eax
  800663:	eb 40                	jmp    8006a5 <getuint+0x65>
	else if (lflag)
  800665:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800669:	74 1e                	je     800689 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80066b:	8b 45 08             	mov    0x8(%ebp),%eax
  80066e:	8b 00                	mov    (%eax),%eax
  800670:	8d 50 04             	lea    0x4(%eax),%edx
  800673:	8b 45 08             	mov    0x8(%ebp),%eax
  800676:	89 10                	mov    %edx,(%eax)
  800678:	8b 45 08             	mov    0x8(%ebp),%eax
  80067b:	8b 00                	mov    (%eax),%eax
  80067d:	83 e8 04             	sub    $0x4,%eax
  800680:	8b 00                	mov    (%eax),%eax
  800682:	ba 00 00 00 00       	mov    $0x0,%edx
  800687:	eb 1c                	jmp    8006a5 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800689:	8b 45 08             	mov    0x8(%ebp),%eax
  80068c:	8b 00                	mov    (%eax),%eax
  80068e:	8d 50 04             	lea    0x4(%eax),%edx
  800691:	8b 45 08             	mov    0x8(%ebp),%eax
  800694:	89 10                	mov    %edx,(%eax)
  800696:	8b 45 08             	mov    0x8(%ebp),%eax
  800699:	8b 00                	mov    (%eax),%eax
  80069b:	83 e8 04             	sub    $0x4,%eax
  80069e:	8b 00                	mov    (%eax),%eax
  8006a0:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006a5:	5d                   	pop    %ebp
  8006a6:	c3                   	ret    

008006a7 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006a7:	55                   	push   %ebp
  8006a8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006aa:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006ae:	7e 1c                	jle    8006cc <getint+0x25>
		return va_arg(*ap, long long);
  8006b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b3:	8b 00                	mov    (%eax),%eax
  8006b5:	8d 50 08             	lea    0x8(%eax),%edx
  8006b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bb:	89 10                	mov    %edx,(%eax)
  8006bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c0:	8b 00                	mov    (%eax),%eax
  8006c2:	83 e8 08             	sub    $0x8,%eax
  8006c5:	8b 50 04             	mov    0x4(%eax),%edx
  8006c8:	8b 00                	mov    (%eax),%eax
  8006ca:	eb 38                	jmp    800704 <getint+0x5d>
	else if (lflag)
  8006cc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006d0:	74 1a                	je     8006ec <getint+0x45>
		return va_arg(*ap, long);
  8006d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d5:	8b 00                	mov    (%eax),%eax
  8006d7:	8d 50 04             	lea    0x4(%eax),%edx
  8006da:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dd:	89 10                	mov    %edx,(%eax)
  8006df:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e2:	8b 00                	mov    (%eax),%eax
  8006e4:	83 e8 04             	sub    $0x4,%eax
  8006e7:	8b 00                	mov    (%eax),%eax
  8006e9:	99                   	cltd   
  8006ea:	eb 18                	jmp    800704 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ef:	8b 00                	mov    (%eax),%eax
  8006f1:	8d 50 04             	lea    0x4(%eax),%edx
  8006f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f7:	89 10                	mov    %edx,(%eax)
  8006f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fc:	8b 00                	mov    (%eax),%eax
  8006fe:	83 e8 04             	sub    $0x4,%eax
  800701:	8b 00                	mov    (%eax),%eax
  800703:	99                   	cltd   
}
  800704:	5d                   	pop    %ebp
  800705:	c3                   	ret    

00800706 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800706:	55                   	push   %ebp
  800707:	89 e5                	mov    %esp,%ebp
  800709:	56                   	push   %esi
  80070a:	53                   	push   %ebx
  80070b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80070e:	eb 17                	jmp    800727 <vprintfmt+0x21>
			if (ch == '\0')
  800710:	85 db                	test   %ebx,%ebx
  800712:	0f 84 af 03 00 00    	je     800ac7 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800718:	83 ec 08             	sub    $0x8,%esp
  80071b:	ff 75 0c             	pushl  0xc(%ebp)
  80071e:	53                   	push   %ebx
  80071f:	8b 45 08             	mov    0x8(%ebp),%eax
  800722:	ff d0                	call   *%eax
  800724:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800727:	8b 45 10             	mov    0x10(%ebp),%eax
  80072a:	8d 50 01             	lea    0x1(%eax),%edx
  80072d:	89 55 10             	mov    %edx,0x10(%ebp)
  800730:	8a 00                	mov    (%eax),%al
  800732:	0f b6 d8             	movzbl %al,%ebx
  800735:	83 fb 25             	cmp    $0x25,%ebx
  800738:	75 d6                	jne    800710 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80073a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80073e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800745:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80074c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800753:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80075a:	8b 45 10             	mov    0x10(%ebp),%eax
  80075d:	8d 50 01             	lea    0x1(%eax),%edx
  800760:	89 55 10             	mov    %edx,0x10(%ebp)
  800763:	8a 00                	mov    (%eax),%al
  800765:	0f b6 d8             	movzbl %al,%ebx
  800768:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80076b:	83 f8 55             	cmp    $0x55,%eax
  80076e:	0f 87 2b 03 00 00    	ja     800a9f <vprintfmt+0x399>
  800774:	8b 04 85 d8 22 80 00 	mov    0x8022d8(,%eax,4),%eax
  80077b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80077d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800781:	eb d7                	jmp    80075a <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800783:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800787:	eb d1                	jmp    80075a <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800789:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800790:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800793:	89 d0                	mov    %edx,%eax
  800795:	c1 e0 02             	shl    $0x2,%eax
  800798:	01 d0                	add    %edx,%eax
  80079a:	01 c0                	add    %eax,%eax
  80079c:	01 d8                	add    %ebx,%eax
  80079e:	83 e8 30             	sub    $0x30,%eax
  8007a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a7:	8a 00                	mov    (%eax),%al
  8007a9:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007ac:	83 fb 2f             	cmp    $0x2f,%ebx
  8007af:	7e 3e                	jle    8007ef <vprintfmt+0xe9>
  8007b1:	83 fb 39             	cmp    $0x39,%ebx
  8007b4:	7f 39                	jg     8007ef <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007b6:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007b9:	eb d5                	jmp    800790 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8007be:	83 c0 04             	add    $0x4,%eax
  8007c1:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c7:	83 e8 04             	sub    $0x4,%eax
  8007ca:	8b 00                	mov    (%eax),%eax
  8007cc:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007cf:	eb 1f                	jmp    8007f0 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007d1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d5:	79 83                	jns    80075a <vprintfmt+0x54>
				width = 0;
  8007d7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007de:	e9 77 ff ff ff       	jmp    80075a <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007e3:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007ea:	e9 6b ff ff ff       	jmp    80075a <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007ef:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007f0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007f4:	0f 89 60 ff ff ff    	jns    80075a <vprintfmt+0x54>
				width = precision, precision = -1;
  8007fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800800:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800807:	e9 4e ff ff ff       	jmp    80075a <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80080c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80080f:	e9 46 ff ff ff       	jmp    80075a <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800814:	8b 45 14             	mov    0x14(%ebp),%eax
  800817:	83 c0 04             	add    $0x4,%eax
  80081a:	89 45 14             	mov    %eax,0x14(%ebp)
  80081d:	8b 45 14             	mov    0x14(%ebp),%eax
  800820:	83 e8 04             	sub    $0x4,%eax
  800823:	8b 00                	mov    (%eax),%eax
  800825:	83 ec 08             	sub    $0x8,%esp
  800828:	ff 75 0c             	pushl  0xc(%ebp)
  80082b:	50                   	push   %eax
  80082c:	8b 45 08             	mov    0x8(%ebp),%eax
  80082f:	ff d0                	call   *%eax
  800831:	83 c4 10             	add    $0x10,%esp
			break;
  800834:	e9 89 02 00 00       	jmp    800ac2 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800839:	8b 45 14             	mov    0x14(%ebp),%eax
  80083c:	83 c0 04             	add    $0x4,%eax
  80083f:	89 45 14             	mov    %eax,0x14(%ebp)
  800842:	8b 45 14             	mov    0x14(%ebp),%eax
  800845:	83 e8 04             	sub    $0x4,%eax
  800848:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80084a:	85 db                	test   %ebx,%ebx
  80084c:	79 02                	jns    800850 <vprintfmt+0x14a>
				err = -err;
  80084e:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800850:	83 fb 64             	cmp    $0x64,%ebx
  800853:	7f 0b                	jg     800860 <vprintfmt+0x15a>
  800855:	8b 34 9d 20 21 80 00 	mov    0x802120(,%ebx,4),%esi
  80085c:	85 f6                	test   %esi,%esi
  80085e:	75 19                	jne    800879 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800860:	53                   	push   %ebx
  800861:	68 c5 22 80 00       	push   $0x8022c5
  800866:	ff 75 0c             	pushl  0xc(%ebp)
  800869:	ff 75 08             	pushl  0x8(%ebp)
  80086c:	e8 5e 02 00 00       	call   800acf <printfmt>
  800871:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800874:	e9 49 02 00 00       	jmp    800ac2 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800879:	56                   	push   %esi
  80087a:	68 ce 22 80 00       	push   $0x8022ce
  80087f:	ff 75 0c             	pushl  0xc(%ebp)
  800882:	ff 75 08             	pushl  0x8(%ebp)
  800885:	e8 45 02 00 00       	call   800acf <printfmt>
  80088a:	83 c4 10             	add    $0x10,%esp
			break;
  80088d:	e9 30 02 00 00       	jmp    800ac2 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800892:	8b 45 14             	mov    0x14(%ebp),%eax
  800895:	83 c0 04             	add    $0x4,%eax
  800898:	89 45 14             	mov    %eax,0x14(%ebp)
  80089b:	8b 45 14             	mov    0x14(%ebp),%eax
  80089e:	83 e8 04             	sub    $0x4,%eax
  8008a1:	8b 30                	mov    (%eax),%esi
  8008a3:	85 f6                	test   %esi,%esi
  8008a5:	75 05                	jne    8008ac <vprintfmt+0x1a6>
				p = "(null)";
  8008a7:	be d1 22 80 00       	mov    $0x8022d1,%esi
			if (width > 0 && padc != '-')
  8008ac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008b0:	7e 6d                	jle    80091f <vprintfmt+0x219>
  8008b2:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008b6:	74 67                	je     80091f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008bb:	83 ec 08             	sub    $0x8,%esp
  8008be:	50                   	push   %eax
  8008bf:	56                   	push   %esi
  8008c0:	e8 0c 03 00 00       	call   800bd1 <strnlen>
  8008c5:	83 c4 10             	add    $0x10,%esp
  8008c8:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008cb:	eb 16                	jmp    8008e3 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008cd:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008d1:	83 ec 08             	sub    $0x8,%esp
  8008d4:	ff 75 0c             	pushl  0xc(%ebp)
  8008d7:	50                   	push   %eax
  8008d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008db:	ff d0                	call   *%eax
  8008dd:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008e0:	ff 4d e4             	decl   -0x1c(%ebp)
  8008e3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008e7:	7f e4                	jg     8008cd <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008e9:	eb 34                	jmp    80091f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008eb:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008ef:	74 1c                	je     80090d <vprintfmt+0x207>
  8008f1:	83 fb 1f             	cmp    $0x1f,%ebx
  8008f4:	7e 05                	jle    8008fb <vprintfmt+0x1f5>
  8008f6:	83 fb 7e             	cmp    $0x7e,%ebx
  8008f9:	7e 12                	jle    80090d <vprintfmt+0x207>
					putch('?', putdat);
  8008fb:	83 ec 08             	sub    $0x8,%esp
  8008fe:	ff 75 0c             	pushl  0xc(%ebp)
  800901:	6a 3f                	push   $0x3f
  800903:	8b 45 08             	mov    0x8(%ebp),%eax
  800906:	ff d0                	call   *%eax
  800908:	83 c4 10             	add    $0x10,%esp
  80090b:	eb 0f                	jmp    80091c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80090d:	83 ec 08             	sub    $0x8,%esp
  800910:	ff 75 0c             	pushl  0xc(%ebp)
  800913:	53                   	push   %ebx
  800914:	8b 45 08             	mov    0x8(%ebp),%eax
  800917:	ff d0                	call   *%eax
  800919:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80091c:	ff 4d e4             	decl   -0x1c(%ebp)
  80091f:	89 f0                	mov    %esi,%eax
  800921:	8d 70 01             	lea    0x1(%eax),%esi
  800924:	8a 00                	mov    (%eax),%al
  800926:	0f be d8             	movsbl %al,%ebx
  800929:	85 db                	test   %ebx,%ebx
  80092b:	74 24                	je     800951 <vprintfmt+0x24b>
  80092d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800931:	78 b8                	js     8008eb <vprintfmt+0x1e5>
  800933:	ff 4d e0             	decl   -0x20(%ebp)
  800936:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80093a:	79 af                	jns    8008eb <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80093c:	eb 13                	jmp    800951 <vprintfmt+0x24b>
				putch(' ', putdat);
  80093e:	83 ec 08             	sub    $0x8,%esp
  800941:	ff 75 0c             	pushl  0xc(%ebp)
  800944:	6a 20                	push   $0x20
  800946:	8b 45 08             	mov    0x8(%ebp),%eax
  800949:	ff d0                	call   *%eax
  80094b:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80094e:	ff 4d e4             	decl   -0x1c(%ebp)
  800951:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800955:	7f e7                	jg     80093e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800957:	e9 66 01 00 00       	jmp    800ac2 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80095c:	83 ec 08             	sub    $0x8,%esp
  80095f:	ff 75 e8             	pushl  -0x18(%ebp)
  800962:	8d 45 14             	lea    0x14(%ebp),%eax
  800965:	50                   	push   %eax
  800966:	e8 3c fd ff ff       	call   8006a7 <getint>
  80096b:	83 c4 10             	add    $0x10,%esp
  80096e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800971:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800974:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800977:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80097a:	85 d2                	test   %edx,%edx
  80097c:	79 23                	jns    8009a1 <vprintfmt+0x29b>
				putch('-', putdat);
  80097e:	83 ec 08             	sub    $0x8,%esp
  800981:	ff 75 0c             	pushl  0xc(%ebp)
  800984:	6a 2d                	push   $0x2d
  800986:	8b 45 08             	mov    0x8(%ebp),%eax
  800989:	ff d0                	call   *%eax
  80098b:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80098e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800991:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800994:	f7 d8                	neg    %eax
  800996:	83 d2 00             	adc    $0x0,%edx
  800999:	f7 da                	neg    %edx
  80099b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009a1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009a8:	e9 bc 00 00 00       	jmp    800a69 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009ad:	83 ec 08             	sub    $0x8,%esp
  8009b0:	ff 75 e8             	pushl  -0x18(%ebp)
  8009b3:	8d 45 14             	lea    0x14(%ebp),%eax
  8009b6:	50                   	push   %eax
  8009b7:	e8 84 fc ff ff       	call   800640 <getuint>
  8009bc:	83 c4 10             	add    $0x10,%esp
  8009bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009c2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009c5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009cc:	e9 98 00 00 00       	jmp    800a69 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009d1:	83 ec 08             	sub    $0x8,%esp
  8009d4:	ff 75 0c             	pushl  0xc(%ebp)
  8009d7:	6a 58                	push   $0x58
  8009d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dc:	ff d0                	call   *%eax
  8009de:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009e1:	83 ec 08             	sub    $0x8,%esp
  8009e4:	ff 75 0c             	pushl  0xc(%ebp)
  8009e7:	6a 58                	push   $0x58
  8009e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ec:	ff d0                	call   *%eax
  8009ee:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009f1:	83 ec 08             	sub    $0x8,%esp
  8009f4:	ff 75 0c             	pushl  0xc(%ebp)
  8009f7:	6a 58                	push   $0x58
  8009f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fc:	ff d0                	call   *%eax
  8009fe:	83 c4 10             	add    $0x10,%esp
			break;
  800a01:	e9 bc 00 00 00       	jmp    800ac2 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a06:	83 ec 08             	sub    $0x8,%esp
  800a09:	ff 75 0c             	pushl  0xc(%ebp)
  800a0c:	6a 30                	push   $0x30
  800a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a11:	ff d0                	call   *%eax
  800a13:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a16:	83 ec 08             	sub    $0x8,%esp
  800a19:	ff 75 0c             	pushl  0xc(%ebp)
  800a1c:	6a 78                	push   $0x78
  800a1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a21:	ff d0                	call   *%eax
  800a23:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a26:	8b 45 14             	mov    0x14(%ebp),%eax
  800a29:	83 c0 04             	add    $0x4,%eax
  800a2c:	89 45 14             	mov    %eax,0x14(%ebp)
  800a2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a32:	83 e8 04             	sub    $0x4,%eax
  800a35:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a37:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a41:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a48:	eb 1f                	jmp    800a69 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a4a:	83 ec 08             	sub    $0x8,%esp
  800a4d:	ff 75 e8             	pushl  -0x18(%ebp)
  800a50:	8d 45 14             	lea    0x14(%ebp),%eax
  800a53:	50                   	push   %eax
  800a54:	e8 e7 fb ff ff       	call   800640 <getuint>
  800a59:	83 c4 10             	add    $0x10,%esp
  800a5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a5f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a62:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a69:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a6d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a70:	83 ec 04             	sub    $0x4,%esp
  800a73:	52                   	push   %edx
  800a74:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a77:	50                   	push   %eax
  800a78:	ff 75 f4             	pushl  -0xc(%ebp)
  800a7b:	ff 75 f0             	pushl  -0x10(%ebp)
  800a7e:	ff 75 0c             	pushl  0xc(%ebp)
  800a81:	ff 75 08             	pushl  0x8(%ebp)
  800a84:	e8 00 fb ff ff       	call   800589 <printnum>
  800a89:	83 c4 20             	add    $0x20,%esp
			break;
  800a8c:	eb 34                	jmp    800ac2 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a8e:	83 ec 08             	sub    $0x8,%esp
  800a91:	ff 75 0c             	pushl  0xc(%ebp)
  800a94:	53                   	push   %ebx
  800a95:	8b 45 08             	mov    0x8(%ebp),%eax
  800a98:	ff d0                	call   *%eax
  800a9a:	83 c4 10             	add    $0x10,%esp
			break;
  800a9d:	eb 23                	jmp    800ac2 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a9f:	83 ec 08             	sub    $0x8,%esp
  800aa2:	ff 75 0c             	pushl  0xc(%ebp)
  800aa5:	6a 25                	push   $0x25
  800aa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaa:	ff d0                	call   *%eax
  800aac:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800aaf:	ff 4d 10             	decl   0x10(%ebp)
  800ab2:	eb 03                	jmp    800ab7 <vprintfmt+0x3b1>
  800ab4:	ff 4d 10             	decl   0x10(%ebp)
  800ab7:	8b 45 10             	mov    0x10(%ebp),%eax
  800aba:	48                   	dec    %eax
  800abb:	8a 00                	mov    (%eax),%al
  800abd:	3c 25                	cmp    $0x25,%al
  800abf:	75 f3                	jne    800ab4 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ac1:	90                   	nop
		}
	}
  800ac2:	e9 47 fc ff ff       	jmp    80070e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ac7:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ac8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800acb:	5b                   	pop    %ebx
  800acc:	5e                   	pop    %esi
  800acd:	5d                   	pop    %ebp
  800ace:	c3                   	ret    

00800acf <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800acf:	55                   	push   %ebp
  800ad0:	89 e5                	mov    %esp,%ebp
  800ad2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ad5:	8d 45 10             	lea    0x10(%ebp),%eax
  800ad8:	83 c0 04             	add    $0x4,%eax
  800adb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ade:	8b 45 10             	mov    0x10(%ebp),%eax
  800ae1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae4:	50                   	push   %eax
  800ae5:	ff 75 0c             	pushl  0xc(%ebp)
  800ae8:	ff 75 08             	pushl  0x8(%ebp)
  800aeb:	e8 16 fc ff ff       	call   800706 <vprintfmt>
  800af0:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800af3:	90                   	nop
  800af4:	c9                   	leave  
  800af5:	c3                   	ret    

00800af6 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800af6:	55                   	push   %ebp
  800af7:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800af9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afc:	8b 40 08             	mov    0x8(%eax),%eax
  800aff:	8d 50 01             	lea    0x1(%eax),%edx
  800b02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b05:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0b:	8b 10                	mov    (%eax),%edx
  800b0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b10:	8b 40 04             	mov    0x4(%eax),%eax
  800b13:	39 c2                	cmp    %eax,%edx
  800b15:	73 12                	jae    800b29 <sprintputch+0x33>
		*b->buf++ = ch;
  800b17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1a:	8b 00                	mov    (%eax),%eax
  800b1c:	8d 48 01             	lea    0x1(%eax),%ecx
  800b1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b22:	89 0a                	mov    %ecx,(%edx)
  800b24:	8b 55 08             	mov    0x8(%ebp),%edx
  800b27:	88 10                	mov    %dl,(%eax)
}
  800b29:	90                   	nop
  800b2a:	5d                   	pop    %ebp
  800b2b:	c3                   	ret    

00800b2c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b2c:	55                   	push   %ebp
  800b2d:	89 e5                	mov    %esp,%ebp
  800b2f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	01 d0                	add    %edx,%eax
  800b43:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b46:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b4d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b51:	74 06                	je     800b59 <vsnprintf+0x2d>
  800b53:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b57:	7f 07                	jg     800b60 <vsnprintf+0x34>
		return -E_INVAL;
  800b59:	b8 03 00 00 00       	mov    $0x3,%eax
  800b5e:	eb 20                	jmp    800b80 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b60:	ff 75 14             	pushl  0x14(%ebp)
  800b63:	ff 75 10             	pushl  0x10(%ebp)
  800b66:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b69:	50                   	push   %eax
  800b6a:	68 f6 0a 80 00       	push   $0x800af6
  800b6f:	e8 92 fb ff ff       	call   800706 <vprintfmt>
  800b74:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b77:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b7a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b80:	c9                   	leave  
  800b81:	c3                   	ret    

00800b82 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b82:	55                   	push   %ebp
  800b83:	89 e5                	mov    %esp,%ebp
  800b85:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b88:	8d 45 10             	lea    0x10(%ebp),%eax
  800b8b:	83 c0 04             	add    $0x4,%eax
  800b8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b91:	8b 45 10             	mov    0x10(%ebp),%eax
  800b94:	ff 75 f4             	pushl  -0xc(%ebp)
  800b97:	50                   	push   %eax
  800b98:	ff 75 0c             	pushl  0xc(%ebp)
  800b9b:	ff 75 08             	pushl  0x8(%ebp)
  800b9e:	e8 89 ff ff ff       	call   800b2c <vsnprintf>
  800ba3:	83 c4 10             	add    $0x10,%esp
  800ba6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ba9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bac:	c9                   	leave  
  800bad:	c3                   	ret    

00800bae <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bae:	55                   	push   %ebp
  800baf:	89 e5                	mov    %esp,%ebp
  800bb1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bb4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bbb:	eb 06                	jmp    800bc3 <strlen+0x15>
		n++;
  800bbd:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800bc0:	ff 45 08             	incl   0x8(%ebp)
  800bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc6:	8a 00                	mov    (%eax),%al
  800bc8:	84 c0                	test   %al,%al
  800bca:	75 f1                	jne    800bbd <strlen+0xf>
		n++;
	return n;
  800bcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bcf:	c9                   	leave  
  800bd0:	c3                   	ret    

00800bd1 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bd1:	55                   	push   %ebp
  800bd2:	89 e5                	mov    %esp,%ebp
  800bd4:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bd7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bde:	eb 09                	jmp    800be9 <strnlen+0x18>
		n++;
  800be0:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800be3:	ff 45 08             	incl   0x8(%ebp)
  800be6:	ff 4d 0c             	decl   0xc(%ebp)
  800be9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bed:	74 09                	je     800bf8 <strnlen+0x27>
  800bef:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf2:	8a 00                	mov    (%eax),%al
  800bf4:	84 c0                	test   %al,%al
  800bf6:	75 e8                	jne    800be0 <strnlen+0xf>
		n++;
	return n;
  800bf8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bfb:	c9                   	leave  
  800bfc:	c3                   	ret    

00800bfd <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bfd:	55                   	push   %ebp
  800bfe:	89 e5                	mov    %esp,%ebp
  800c00:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c03:	8b 45 08             	mov    0x8(%ebp),%eax
  800c06:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c09:	90                   	nop
  800c0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0d:	8d 50 01             	lea    0x1(%eax),%edx
  800c10:	89 55 08             	mov    %edx,0x8(%ebp)
  800c13:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c16:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c19:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c1c:	8a 12                	mov    (%edx),%dl
  800c1e:	88 10                	mov    %dl,(%eax)
  800c20:	8a 00                	mov    (%eax),%al
  800c22:	84 c0                	test   %al,%al
  800c24:	75 e4                	jne    800c0a <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c26:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c29:	c9                   	leave  
  800c2a:	c3                   	ret    

00800c2b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c2b:	55                   	push   %ebp
  800c2c:	89 e5                	mov    %esp,%ebp
  800c2e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c31:	8b 45 08             	mov    0x8(%ebp),%eax
  800c34:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c37:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c3e:	eb 1f                	jmp    800c5f <strncpy+0x34>
		*dst++ = *src;
  800c40:	8b 45 08             	mov    0x8(%ebp),%eax
  800c43:	8d 50 01             	lea    0x1(%eax),%edx
  800c46:	89 55 08             	mov    %edx,0x8(%ebp)
  800c49:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c4c:	8a 12                	mov    (%edx),%dl
  800c4e:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c53:	8a 00                	mov    (%eax),%al
  800c55:	84 c0                	test   %al,%al
  800c57:	74 03                	je     800c5c <strncpy+0x31>
			src++;
  800c59:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c5c:	ff 45 fc             	incl   -0x4(%ebp)
  800c5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c62:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c65:	72 d9                	jb     800c40 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c67:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c6a:	c9                   	leave  
  800c6b:	c3                   	ret    

00800c6c <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c6c:	55                   	push   %ebp
  800c6d:	89 e5                	mov    %esp,%ebp
  800c6f:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c72:	8b 45 08             	mov    0x8(%ebp),%eax
  800c75:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c78:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c7c:	74 30                	je     800cae <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c7e:	eb 16                	jmp    800c96 <strlcpy+0x2a>
			*dst++ = *src++;
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	8d 50 01             	lea    0x1(%eax),%edx
  800c86:	89 55 08             	mov    %edx,0x8(%ebp)
  800c89:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c8c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c8f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c92:	8a 12                	mov    (%edx),%dl
  800c94:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c96:	ff 4d 10             	decl   0x10(%ebp)
  800c99:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9d:	74 09                	je     800ca8 <strlcpy+0x3c>
  800c9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca2:	8a 00                	mov    (%eax),%al
  800ca4:	84 c0                	test   %al,%al
  800ca6:	75 d8                	jne    800c80 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cab:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cae:	8b 55 08             	mov    0x8(%ebp),%edx
  800cb1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb4:	29 c2                	sub    %eax,%edx
  800cb6:	89 d0                	mov    %edx,%eax
}
  800cb8:	c9                   	leave  
  800cb9:	c3                   	ret    

00800cba <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cba:	55                   	push   %ebp
  800cbb:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800cbd:	eb 06                	jmp    800cc5 <strcmp+0xb>
		p++, q++;
  800cbf:	ff 45 08             	incl   0x8(%ebp)
  800cc2:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc8:	8a 00                	mov    (%eax),%al
  800cca:	84 c0                	test   %al,%al
  800ccc:	74 0e                	je     800cdc <strcmp+0x22>
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	8a 10                	mov    (%eax),%dl
  800cd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd6:	8a 00                	mov    (%eax),%al
  800cd8:	38 c2                	cmp    %al,%dl
  800cda:	74 e3                	je     800cbf <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	8a 00                	mov    (%eax),%al
  800ce1:	0f b6 d0             	movzbl %al,%edx
  800ce4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce7:	8a 00                	mov    (%eax),%al
  800ce9:	0f b6 c0             	movzbl %al,%eax
  800cec:	29 c2                	sub    %eax,%edx
  800cee:	89 d0                	mov    %edx,%eax
}
  800cf0:	5d                   	pop    %ebp
  800cf1:	c3                   	ret    

00800cf2 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cf2:	55                   	push   %ebp
  800cf3:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cf5:	eb 09                	jmp    800d00 <strncmp+0xe>
		n--, p++, q++;
  800cf7:	ff 4d 10             	decl   0x10(%ebp)
  800cfa:	ff 45 08             	incl   0x8(%ebp)
  800cfd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d00:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d04:	74 17                	je     800d1d <strncmp+0x2b>
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	84 c0                	test   %al,%al
  800d0d:	74 0e                	je     800d1d <strncmp+0x2b>
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	8a 10                	mov    (%eax),%dl
  800d14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d17:	8a 00                	mov    (%eax),%al
  800d19:	38 c2                	cmp    %al,%dl
  800d1b:	74 da                	je     800cf7 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d21:	75 07                	jne    800d2a <strncmp+0x38>
		return 0;
  800d23:	b8 00 00 00 00       	mov    $0x0,%eax
  800d28:	eb 14                	jmp    800d3e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	8a 00                	mov    (%eax),%al
  800d2f:	0f b6 d0             	movzbl %al,%edx
  800d32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d35:	8a 00                	mov    (%eax),%al
  800d37:	0f b6 c0             	movzbl %al,%eax
  800d3a:	29 c2                	sub    %eax,%edx
  800d3c:	89 d0                	mov    %edx,%eax
}
  800d3e:	5d                   	pop    %ebp
  800d3f:	c3                   	ret    

00800d40 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d40:	55                   	push   %ebp
  800d41:	89 e5                	mov    %esp,%ebp
  800d43:	83 ec 04             	sub    $0x4,%esp
  800d46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d49:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d4c:	eb 12                	jmp    800d60 <strchr+0x20>
		if (*s == c)
  800d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d51:	8a 00                	mov    (%eax),%al
  800d53:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d56:	75 05                	jne    800d5d <strchr+0x1d>
			return (char *) s;
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	eb 11                	jmp    800d6e <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d5d:	ff 45 08             	incl   0x8(%ebp)
  800d60:	8b 45 08             	mov    0x8(%ebp),%eax
  800d63:	8a 00                	mov    (%eax),%al
  800d65:	84 c0                	test   %al,%al
  800d67:	75 e5                	jne    800d4e <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d69:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d6e:	c9                   	leave  
  800d6f:	c3                   	ret    

00800d70 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d70:	55                   	push   %ebp
  800d71:	89 e5                	mov    %esp,%ebp
  800d73:	83 ec 04             	sub    $0x4,%esp
  800d76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d79:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d7c:	eb 0d                	jmp    800d8b <strfind+0x1b>
		if (*s == c)
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	8a 00                	mov    (%eax),%al
  800d83:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d86:	74 0e                	je     800d96 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d88:	ff 45 08             	incl   0x8(%ebp)
  800d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8e:	8a 00                	mov    (%eax),%al
  800d90:	84 c0                	test   %al,%al
  800d92:	75 ea                	jne    800d7e <strfind+0xe>
  800d94:	eb 01                	jmp    800d97 <strfind+0x27>
		if (*s == c)
			break;
  800d96:	90                   	nop
	return (char *) s;
  800d97:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d9a:	c9                   	leave  
  800d9b:	c3                   	ret    

00800d9c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d9c:	55                   	push   %ebp
  800d9d:	89 e5                	mov    %esp,%ebp
  800d9f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800da2:	8b 45 08             	mov    0x8(%ebp),%eax
  800da5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800da8:	8b 45 10             	mov    0x10(%ebp),%eax
  800dab:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800dae:	eb 0e                	jmp    800dbe <memset+0x22>
		*p++ = c;
  800db0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db3:	8d 50 01             	lea    0x1(%eax),%edx
  800db6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800db9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dbc:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800dbe:	ff 4d f8             	decl   -0x8(%ebp)
  800dc1:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800dc5:	79 e9                	jns    800db0 <memset+0x14>
		*p++ = c;

	return v;
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dca:	c9                   	leave  
  800dcb:	c3                   	ret    

00800dcc <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800dcc:	55                   	push   %ebp
  800dcd:	89 e5                	mov    %esp,%ebp
  800dcf:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800dde:	eb 16                	jmp    800df6 <memcpy+0x2a>
		*d++ = *s++;
  800de0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de3:	8d 50 01             	lea    0x1(%eax),%edx
  800de6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800de9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dec:	8d 4a 01             	lea    0x1(%edx),%ecx
  800def:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800df2:	8a 12                	mov    (%edx),%dl
  800df4:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800df6:	8b 45 10             	mov    0x10(%ebp),%eax
  800df9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dfc:	89 55 10             	mov    %edx,0x10(%ebp)
  800dff:	85 c0                	test   %eax,%eax
  800e01:	75 dd                	jne    800de0 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e06:	c9                   	leave  
  800e07:	c3                   	ret    

00800e08 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e08:	55                   	push   %ebp
  800e09:	89 e5                	mov    %esp,%ebp
  800e0b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800e0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e11:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e14:	8b 45 08             	mov    0x8(%ebp),%eax
  800e17:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e20:	73 50                	jae    800e72 <memmove+0x6a>
  800e22:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e25:	8b 45 10             	mov    0x10(%ebp),%eax
  800e28:	01 d0                	add    %edx,%eax
  800e2a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e2d:	76 43                	jbe    800e72 <memmove+0x6a>
		s += n;
  800e2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e32:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e35:	8b 45 10             	mov    0x10(%ebp),%eax
  800e38:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e3b:	eb 10                	jmp    800e4d <memmove+0x45>
			*--d = *--s;
  800e3d:	ff 4d f8             	decl   -0x8(%ebp)
  800e40:	ff 4d fc             	decl   -0x4(%ebp)
  800e43:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e46:	8a 10                	mov    (%eax),%dl
  800e48:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e4b:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e50:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e53:	89 55 10             	mov    %edx,0x10(%ebp)
  800e56:	85 c0                	test   %eax,%eax
  800e58:	75 e3                	jne    800e3d <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e5a:	eb 23                	jmp    800e7f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e5c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e5f:	8d 50 01             	lea    0x1(%eax),%edx
  800e62:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e65:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e68:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e6b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e6e:	8a 12                	mov    (%edx),%dl
  800e70:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e72:	8b 45 10             	mov    0x10(%ebp),%eax
  800e75:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e78:	89 55 10             	mov    %edx,0x10(%ebp)
  800e7b:	85 c0                	test   %eax,%eax
  800e7d:	75 dd                	jne    800e5c <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e7f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e82:	c9                   	leave  
  800e83:	c3                   	ret    

00800e84 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e84:	55                   	push   %ebp
  800e85:	89 e5                	mov    %esp,%ebp
  800e87:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e93:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e96:	eb 2a                	jmp    800ec2 <memcmp+0x3e>
		if (*s1 != *s2)
  800e98:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e9b:	8a 10                	mov    (%eax),%dl
  800e9d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea0:	8a 00                	mov    (%eax),%al
  800ea2:	38 c2                	cmp    %al,%dl
  800ea4:	74 16                	je     800ebc <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ea6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea9:	8a 00                	mov    (%eax),%al
  800eab:	0f b6 d0             	movzbl %al,%edx
  800eae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eb1:	8a 00                	mov    (%eax),%al
  800eb3:	0f b6 c0             	movzbl %al,%eax
  800eb6:	29 c2                	sub    %eax,%edx
  800eb8:	89 d0                	mov    %edx,%eax
  800eba:	eb 18                	jmp    800ed4 <memcmp+0x50>
		s1++, s2++;
  800ebc:	ff 45 fc             	incl   -0x4(%ebp)
  800ebf:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ec2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec8:	89 55 10             	mov    %edx,0x10(%ebp)
  800ecb:	85 c0                	test   %eax,%eax
  800ecd:	75 c9                	jne    800e98 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ecf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ed4:	c9                   	leave  
  800ed5:	c3                   	ret    

00800ed6 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ed6:	55                   	push   %ebp
  800ed7:	89 e5                	mov    %esp,%ebp
  800ed9:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800edc:	8b 55 08             	mov    0x8(%ebp),%edx
  800edf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee2:	01 d0                	add    %edx,%eax
  800ee4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ee7:	eb 15                	jmp    800efe <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ee9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eec:	8a 00                	mov    (%eax),%al
  800eee:	0f b6 d0             	movzbl %al,%edx
  800ef1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef4:	0f b6 c0             	movzbl %al,%eax
  800ef7:	39 c2                	cmp    %eax,%edx
  800ef9:	74 0d                	je     800f08 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800efb:	ff 45 08             	incl   0x8(%ebp)
  800efe:	8b 45 08             	mov    0x8(%ebp),%eax
  800f01:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f04:	72 e3                	jb     800ee9 <memfind+0x13>
  800f06:	eb 01                	jmp    800f09 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f08:	90                   	nop
	return (void *) s;
  800f09:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f0c:	c9                   	leave  
  800f0d:	c3                   	ret    

00800f0e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f0e:	55                   	push   %ebp
  800f0f:	89 e5                	mov    %esp,%ebp
  800f11:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f14:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f1b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f22:	eb 03                	jmp    800f27 <strtol+0x19>
		s++;
  800f24:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f27:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2a:	8a 00                	mov    (%eax),%al
  800f2c:	3c 20                	cmp    $0x20,%al
  800f2e:	74 f4                	je     800f24 <strtol+0x16>
  800f30:	8b 45 08             	mov    0x8(%ebp),%eax
  800f33:	8a 00                	mov    (%eax),%al
  800f35:	3c 09                	cmp    $0x9,%al
  800f37:	74 eb                	je     800f24 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f39:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3c:	8a 00                	mov    (%eax),%al
  800f3e:	3c 2b                	cmp    $0x2b,%al
  800f40:	75 05                	jne    800f47 <strtol+0x39>
		s++;
  800f42:	ff 45 08             	incl   0x8(%ebp)
  800f45:	eb 13                	jmp    800f5a <strtol+0x4c>
	else if (*s == '-')
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4a:	8a 00                	mov    (%eax),%al
  800f4c:	3c 2d                	cmp    $0x2d,%al
  800f4e:	75 0a                	jne    800f5a <strtol+0x4c>
		s++, neg = 1;
  800f50:	ff 45 08             	incl   0x8(%ebp)
  800f53:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f5a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5e:	74 06                	je     800f66 <strtol+0x58>
  800f60:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f64:	75 20                	jne    800f86 <strtol+0x78>
  800f66:	8b 45 08             	mov    0x8(%ebp),%eax
  800f69:	8a 00                	mov    (%eax),%al
  800f6b:	3c 30                	cmp    $0x30,%al
  800f6d:	75 17                	jne    800f86 <strtol+0x78>
  800f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f72:	40                   	inc    %eax
  800f73:	8a 00                	mov    (%eax),%al
  800f75:	3c 78                	cmp    $0x78,%al
  800f77:	75 0d                	jne    800f86 <strtol+0x78>
		s += 2, base = 16;
  800f79:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f7d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f84:	eb 28                	jmp    800fae <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f86:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f8a:	75 15                	jne    800fa1 <strtol+0x93>
  800f8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8f:	8a 00                	mov    (%eax),%al
  800f91:	3c 30                	cmp    $0x30,%al
  800f93:	75 0c                	jne    800fa1 <strtol+0x93>
		s++, base = 8;
  800f95:	ff 45 08             	incl   0x8(%ebp)
  800f98:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f9f:	eb 0d                	jmp    800fae <strtol+0xa0>
	else if (base == 0)
  800fa1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa5:	75 07                	jne    800fae <strtol+0xa0>
		base = 10;
  800fa7:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800fae:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb1:	8a 00                	mov    (%eax),%al
  800fb3:	3c 2f                	cmp    $0x2f,%al
  800fb5:	7e 19                	jle    800fd0 <strtol+0xc2>
  800fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fba:	8a 00                	mov    (%eax),%al
  800fbc:	3c 39                	cmp    $0x39,%al
  800fbe:	7f 10                	jg     800fd0 <strtol+0xc2>
			dig = *s - '0';
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	8a 00                	mov    (%eax),%al
  800fc5:	0f be c0             	movsbl %al,%eax
  800fc8:	83 e8 30             	sub    $0x30,%eax
  800fcb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fce:	eb 42                	jmp    801012 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd3:	8a 00                	mov    (%eax),%al
  800fd5:	3c 60                	cmp    $0x60,%al
  800fd7:	7e 19                	jle    800ff2 <strtol+0xe4>
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdc:	8a 00                	mov    (%eax),%al
  800fde:	3c 7a                	cmp    $0x7a,%al
  800fe0:	7f 10                	jg     800ff2 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe5:	8a 00                	mov    (%eax),%al
  800fe7:	0f be c0             	movsbl %al,%eax
  800fea:	83 e8 57             	sub    $0x57,%eax
  800fed:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ff0:	eb 20                	jmp    801012 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff5:	8a 00                	mov    (%eax),%al
  800ff7:	3c 40                	cmp    $0x40,%al
  800ff9:	7e 39                	jle    801034 <strtol+0x126>
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	8a 00                	mov    (%eax),%al
  801000:	3c 5a                	cmp    $0x5a,%al
  801002:	7f 30                	jg     801034 <strtol+0x126>
			dig = *s - 'A' + 10;
  801004:	8b 45 08             	mov    0x8(%ebp),%eax
  801007:	8a 00                	mov    (%eax),%al
  801009:	0f be c0             	movsbl %al,%eax
  80100c:	83 e8 37             	sub    $0x37,%eax
  80100f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801012:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801015:	3b 45 10             	cmp    0x10(%ebp),%eax
  801018:	7d 19                	jge    801033 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80101a:	ff 45 08             	incl   0x8(%ebp)
  80101d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801020:	0f af 45 10          	imul   0x10(%ebp),%eax
  801024:	89 c2                	mov    %eax,%edx
  801026:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801029:	01 d0                	add    %edx,%eax
  80102b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80102e:	e9 7b ff ff ff       	jmp    800fae <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801033:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801034:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801038:	74 08                	je     801042 <strtol+0x134>
		*endptr = (char *) s;
  80103a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103d:	8b 55 08             	mov    0x8(%ebp),%edx
  801040:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801042:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801046:	74 07                	je     80104f <strtol+0x141>
  801048:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80104b:	f7 d8                	neg    %eax
  80104d:	eb 03                	jmp    801052 <strtol+0x144>
  80104f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801052:	c9                   	leave  
  801053:	c3                   	ret    

00801054 <ltostr>:

void
ltostr(long value, char *str)
{
  801054:	55                   	push   %ebp
  801055:	89 e5                	mov    %esp,%ebp
  801057:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80105a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801061:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801068:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80106c:	79 13                	jns    801081 <ltostr+0x2d>
	{
		neg = 1;
  80106e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801075:	8b 45 0c             	mov    0xc(%ebp),%eax
  801078:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80107b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80107e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801081:	8b 45 08             	mov    0x8(%ebp),%eax
  801084:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801089:	99                   	cltd   
  80108a:	f7 f9                	idiv   %ecx
  80108c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80108f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801092:	8d 50 01             	lea    0x1(%eax),%edx
  801095:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801098:	89 c2                	mov    %eax,%edx
  80109a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109d:	01 d0                	add    %edx,%eax
  80109f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010a2:	83 c2 30             	add    $0x30,%edx
  8010a5:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010a7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010aa:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010af:	f7 e9                	imul   %ecx
  8010b1:	c1 fa 02             	sar    $0x2,%edx
  8010b4:	89 c8                	mov    %ecx,%eax
  8010b6:	c1 f8 1f             	sar    $0x1f,%eax
  8010b9:	29 c2                	sub    %eax,%edx
  8010bb:	89 d0                	mov    %edx,%eax
  8010bd:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010c3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010c8:	f7 e9                	imul   %ecx
  8010ca:	c1 fa 02             	sar    $0x2,%edx
  8010cd:	89 c8                	mov    %ecx,%eax
  8010cf:	c1 f8 1f             	sar    $0x1f,%eax
  8010d2:	29 c2                	sub    %eax,%edx
  8010d4:	89 d0                	mov    %edx,%eax
  8010d6:	c1 e0 02             	shl    $0x2,%eax
  8010d9:	01 d0                	add    %edx,%eax
  8010db:	01 c0                	add    %eax,%eax
  8010dd:	29 c1                	sub    %eax,%ecx
  8010df:	89 ca                	mov    %ecx,%edx
  8010e1:	85 d2                	test   %edx,%edx
  8010e3:	75 9c                	jne    801081 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ef:	48                   	dec    %eax
  8010f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010f3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010f7:	74 3d                	je     801136 <ltostr+0xe2>
		start = 1 ;
  8010f9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801100:	eb 34                	jmp    801136 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801102:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801105:	8b 45 0c             	mov    0xc(%ebp),%eax
  801108:	01 d0                	add    %edx,%eax
  80110a:	8a 00                	mov    (%eax),%al
  80110c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80110f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801112:	8b 45 0c             	mov    0xc(%ebp),%eax
  801115:	01 c2                	add    %eax,%edx
  801117:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80111a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111d:	01 c8                	add    %ecx,%eax
  80111f:	8a 00                	mov    (%eax),%al
  801121:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801123:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801126:	8b 45 0c             	mov    0xc(%ebp),%eax
  801129:	01 c2                	add    %eax,%edx
  80112b:	8a 45 eb             	mov    -0x15(%ebp),%al
  80112e:	88 02                	mov    %al,(%edx)
		start++ ;
  801130:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801133:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801136:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801139:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80113c:	7c c4                	jl     801102 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80113e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801141:	8b 45 0c             	mov    0xc(%ebp),%eax
  801144:	01 d0                	add    %edx,%eax
  801146:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801149:	90                   	nop
  80114a:	c9                   	leave  
  80114b:	c3                   	ret    

0080114c <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80114c:	55                   	push   %ebp
  80114d:	89 e5                	mov    %esp,%ebp
  80114f:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801152:	ff 75 08             	pushl  0x8(%ebp)
  801155:	e8 54 fa ff ff       	call   800bae <strlen>
  80115a:	83 c4 04             	add    $0x4,%esp
  80115d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801160:	ff 75 0c             	pushl  0xc(%ebp)
  801163:	e8 46 fa ff ff       	call   800bae <strlen>
  801168:	83 c4 04             	add    $0x4,%esp
  80116b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80116e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801175:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80117c:	eb 17                	jmp    801195 <strcconcat+0x49>
		final[s] = str1[s] ;
  80117e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801181:	8b 45 10             	mov    0x10(%ebp),%eax
  801184:	01 c2                	add    %eax,%edx
  801186:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801189:	8b 45 08             	mov    0x8(%ebp),%eax
  80118c:	01 c8                	add    %ecx,%eax
  80118e:	8a 00                	mov    (%eax),%al
  801190:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801192:	ff 45 fc             	incl   -0x4(%ebp)
  801195:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801198:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80119b:	7c e1                	jl     80117e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80119d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011a4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011ab:	eb 1f                	jmp    8011cc <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011b0:	8d 50 01             	lea    0x1(%eax),%edx
  8011b3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011b6:	89 c2                	mov    %eax,%edx
  8011b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011bb:	01 c2                	add    %eax,%edx
  8011bd:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c3:	01 c8                	add    %ecx,%eax
  8011c5:	8a 00                	mov    (%eax),%al
  8011c7:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011c9:	ff 45 f8             	incl   -0x8(%ebp)
  8011cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011cf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011d2:	7c d9                	jl     8011ad <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011da:	01 d0                	add    %edx,%eax
  8011dc:	c6 00 00             	movb   $0x0,(%eax)
}
  8011df:	90                   	nop
  8011e0:	c9                   	leave  
  8011e1:	c3                   	ret    

008011e2 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011e2:	55                   	push   %ebp
  8011e3:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f1:	8b 00                	mov    (%eax),%eax
  8011f3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fd:	01 d0                	add    %edx,%eax
  8011ff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801205:	eb 0c                	jmp    801213 <strsplit+0x31>
			*string++ = 0;
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	8d 50 01             	lea    0x1(%eax),%edx
  80120d:	89 55 08             	mov    %edx,0x8(%ebp)
  801210:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801213:	8b 45 08             	mov    0x8(%ebp),%eax
  801216:	8a 00                	mov    (%eax),%al
  801218:	84 c0                	test   %al,%al
  80121a:	74 18                	je     801234 <strsplit+0x52>
  80121c:	8b 45 08             	mov    0x8(%ebp),%eax
  80121f:	8a 00                	mov    (%eax),%al
  801221:	0f be c0             	movsbl %al,%eax
  801224:	50                   	push   %eax
  801225:	ff 75 0c             	pushl  0xc(%ebp)
  801228:	e8 13 fb ff ff       	call   800d40 <strchr>
  80122d:	83 c4 08             	add    $0x8,%esp
  801230:	85 c0                	test   %eax,%eax
  801232:	75 d3                	jne    801207 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801234:	8b 45 08             	mov    0x8(%ebp),%eax
  801237:	8a 00                	mov    (%eax),%al
  801239:	84 c0                	test   %al,%al
  80123b:	74 5a                	je     801297 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80123d:	8b 45 14             	mov    0x14(%ebp),%eax
  801240:	8b 00                	mov    (%eax),%eax
  801242:	83 f8 0f             	cmp    $0xf,%eax
  801245:	75 07                	jne    80124e <strsplit+0x6c>
		{
			return 0;
  801247:	b8 00 00 00 00       	mov    $0x0,%eax
  80124c:	eb 66                	jmp    8012b4 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80124e:	8b 45 14             	mov    0x14(%ebp),%eax
  801251:	8b 00                	mov    (%eax),%eax
  801253:	8d 48 01             	lea    0x1(%eax),%ecx
  801256:	8b 55 14             	mov    0x14(%ebp),%edx
  801259:	89 0a                	mov    %ecx,(%edx)
  80125b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801262:	8b 45 10             	mov    0x10(%ebp),%eax
  801265:	01 c2                	add    %eax,%edx
  801267:	8b 45 08             	mov    0x8(%ebp),%eax
  80126a:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80126c:	eb 03                	jmp    801271 <strsplit+0x8f>
			string++;
  80126e:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801271:	8b 45 08             	mov    0x8(%ebp),%eax
  801274:	8a 00                	mov    (%eax),%al
  801276:	84 c0                	test   %al,%al
  801278:	74 8b                	je     801205 <strsplit+0x23>
  80127a:	8b 45 08             	mov    0x8(%ebp),%eax
  80127d:	8a 00                	mov    (%eax),%al
  80127f:	0f be c0             	movsbl %al,%eax
  801282:	50                   	push   %eax
  801283:	ff 75 0c             	pushl  0xc(%ebp)
  801286:	e8 b5 fa ff ff       	call   800d40 <strchr>
  80128b:	83 c4 08             	add    $0x8,%esp
  80128e:	85 c0                	test   %eax,%eax
  801290:	74 dc                	je     80126e <strsplit+0x8c>
			string++;
	}
  801292:	e9 6e ff ff ff       	jmp    801205 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801297:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801298:	8b 45 14             	mov    0x14(%ebp),%eax
  80129b:	8b 00                	mov    (%eax),%eax
  80129d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a7:	01 d0                	add    %edx,%eax
  8012a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012af:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012b4:	c9                   	leave  
  8012b5:	c3                   	ret    

008012b6 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8012b6:	55                   	push   %ebp
  8012b7:	89 e5                	mov    %esp,%ebp
  8012b9:	83 ec 18             	sub    $0x18,%esp
  8012bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bf:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8012c2:	83 ec 04             	sub    $0x4,%esp
  8012c5:	68 30 24 80 00       	push   $0x802430
  8012ca:	6a 17                	push   $0x17
  8012cc:	68 4f 24 80 00       	push   $0x80244f
  8012d1:	e8 8a 08 00 00       	call   801b60 <_panic>

008012d6 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8012d6:	55                   	push   %ebp
  8012d7:	89 e5                	mov    %esp,%ebp
  8012d9:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8012dc:	83 ec 04             	sub    $0x4,%esp
  8012df:	68 5b 24 80 00       	push   $0x80245b
  8012e4:	6a 2f                	push   $0x2f
  8012e6:	68 4f 24 80 00       	push   $0x80244f
  8012eb:	e8 70 08 00 00       	call   801b60 <_panic>

008012f0 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8012f0:	55                   	push   %ebp
  8012f1:	89 e5                	mov    %esp,%ebp
  8012f3:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8012f6:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8012fd:	8b 55 08             	mov    0x8(%ebp),%edx
  801300:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801303:	01 d0                	add    %edx,%eax
  801305:	48                   	dec    %eax
  801306:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801309:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80130c:	ba 00 00 00 00       	mov    $0x0,%edx
  801311:	f7 75 ec             	divl   -0x14(%ebp)
  801314:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801317:	29 d0                	sub    %edx,%eax
  801319:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  80131c:	8b 45 08             	mov    0x8(%ebp),%eax
  80131f:	c1 e8 0c             	shr    $0xc,%eax
  801322:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801325:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80132c:	e9 c8 00 00 00       	jmp    8013f9 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801331:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801338:	eb 27                	jmp    801361 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  80133a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80133d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801340:	01 c2                	add    %eax,%edx
  801342:	89 d0                	mov    %edx,%eax
  801344:	01 c0                	add    %eax,%eax
  801346:	01 d0                	add    %edx,%eax
  801348:	c1 e0 02             	shl    $0x2,%eax
  80134b:	05 48 30 80 00       	add    $0x803048,%eax
  801350:	8b 00                	mov    (%eax),%eax
  801352:	85 c0                	test   %eax,%eax
  801354:	74 08                	je     80135e <malloc+0x6e>
            	i += j;
  801356:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801359:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  80135c:	eb 0b                	jmp    801369 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  80135e:	ff 45 f0             	incl   -0x10(%ebp)
  801361:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801364:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801367:	72 d1                	jb     80133a <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801369:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80136c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80136f:	0f 85 81 00 00 00    	jne    8013f6 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801375:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801378:	05 00 00 08 00       	add    $0x80000,%eax
  80137d:	c1 e0 0c             	shl    $0xc,%eax
  801380:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801383:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80138a:	eb 1f                	jmp    8013ab <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  80138c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80138f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801392:	01 c2                	add    %eax,%edx
  801394:	89 d0                	mov    %edx,%eax
  801396:	01 c0                	add    %eax,%eax
  801398:	01 d0                	add    %edx,%eax
  80139a:	c1 e0 02             	shl    $0x2,%eax
  80139d:	05 48 30 80 00       	add    $0x803048,%eax
  8013a2:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8013a8:	ff 45 f0             	incl   -0x10(%ebp)
  8013ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013ae:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8013b1:	72 d9                	jb     80138c <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  8013b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013b6:	89 d0                	mov    %edx,%eax
  8013b8:	01 c0                	add    %eax,%eax
  8013ba:	01 d0                	add    %edx,%eax
  8013bc:	c1 e0 02             	shl    $0x2,%eax
  8013bf:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  8013c5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8013c8:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8013ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8013cd:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8013d0:	89 c8                	mov    %ecx,%eax
  8013d2:	01 c0                	add    %eax,%eax
  8013d4:	01 c8                	add    %ecx,%eax
  8013d6:	c1 e0 02             	shl    $0x2,%eax
  8013d9:	05 44 30 80 00       	add    $0x803044,%eax
  8013de:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8013e0:	83 ec 08             	sub    $0x8,%esp
  8013e3:	ff 75 08             	pushl  0x8(%ebp)
  8013e6:	ff 75 e0             	pushl  -0x20(%ebp)
  8013e9:	e8 2b 03 00 00       	call   801719 <sys_allocateMem>
  8013ee:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8013f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8013f4:	eb 19                	jmp    80140f <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8013f6:	ff 45 f4             	incl   -0xc(%ebp)
  8013f9:	a1 04 30 80 00       	mov    0x803004,%eax
  8013fe:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801401:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801404:	0f 83 27 ff ff ff    	jae    801331 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  80140a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80140f:	c9                   	leave  
  801410:	c3                   	ret    

00801411 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801411:	55                   	push   %ebp
  801412:	89 e5                	mov    %esp,%ebp
  801414:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801417:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80141b:	0f 84 e5 00 00 00    	je     801506 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801427:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80142a:	05 00 00 00 80       	add    $0x80000000,%eax
  80142f:	c1 e8 0c             	shr    $0xc,%eax
  801432:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801435:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801438:	89 d0                	mov    %edx,%eax
  80143a:	01 c0                	add    %eax,%eax
  80143c:	01 d0                	add    %edx,%eax
  80143e:	c1 e0 02             	shl    $0x2,%eax
  801441:	05 40 30 80 00       	add    $0x803040,%eax
  801446:	8b 00                	mov    (%eax),%eax
  801448:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80144b:	0f 85 b8 00 00 00    	jne    801509 <free+0xf8>
  801451:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801454:	89 d0                	mov    %edx,%eax
  801456:	01 c0                	add    %eax,%eax
  801458:	01 d0                	add    %edx,%eax
  80145a:	c1 e0 02             	shl    $0x2,%eax
  80145d:	05 48 30 80 00       	add    $0x803048,%eax
  801462:	8b 00                	mov    (%eax),%eax
  801464:	85 c0                	test   %eax,%eax
  801466:	0f 84 9d 00 00 00    	je     801509 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  80146c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80146f:	89 d0                	mov    %edx,%eax
  801471:	01 c0                	add    %eax,%eax
  801473:	01 d0                	add    %edx,%eax
  801475:	c1 e0 02             	shl    $0x2,%eax
  801478:	05 44 30 80 00       	add    $0x803044,%eax
  80147d:	8b 00                	mov    (%eax),%eax
  80147f:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801482:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801485:	c1 e0 0c             	shl    $0xc,%eax
  801488:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  80148b:	83 ec 08             	sub    $0x8,%esp
  80148e:	ff 75 e4             	pushl  -0x1c(%ebp)
  801491:	ff 75 f0             	pushl  -0x10(%ebp)
  801494:	e8 64 02 00 00       	call   8016fd <sys_freeMem>
  801499:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80149c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8014a3:	eb 57                	jmp    8014fc <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8014a5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014ab:	01 c2                	add    %eax,%edx
  8014ad:	89 d0                	mov    %edx,%eax
  8014af:	01 c0                	add    %eax,%eax
  8014b1:	01 d0                	add    %edx,%eax
  8014b3:	c1 e0 02             	shl    $0x2,%eax
  8014b6:	05 48 30 80 00       	add    $0x803048,%eax
  8014bb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  8014c1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014c7:	01 c2                	add    %eax,%edx
  8014c9:	89 d0                	mov    %edx,%eax
  8014cb:	01 c0                	add    %eax,%eax
  8014cd:	01 d0                	add    %edx,%eax
  8014cf:	c1 e0 02             	shl    $0x2,%eax
  8014d2:	05 40 30 80 00       	add    $0x803040,%eax
  8014d7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8014dd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014e3:	01 c2                	add    %eax,%edx
  8014e5:	89 d0                	mov    %edx,%eax
  8014e7:	01 c0                	add    %eax,%eax
  8014e9:	01 d0                	add    %edx,%eax
  8014eb:	c1 e0 02             	shl    $0x2,%eax
  8014ee:	05 44 30 80 00       	add    $0x803044,%eax
  8014f3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8014f9:	ff 45 f4             	incl   -0xc(%ebp)
  8014fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014ff:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801502:	7c a1                	jl     8014a5 <free+0x94>
  801504:	eb 04                	jmp    80150a <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801506:	90                   	nop
  801507:	eb 01                	jmp    80150a <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801509:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  80150a:	c9                   	leave  
  80150b:	c3                   	ret    

0080150c <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  80150c:	55                   	push   %ebp
  80150d:	89 e5                	mov    %esp,%ebp
  80150f:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801512:	83 ec 04             	sub    $0x4,%esp
  801515:	68 78 24 80 00       	push   $0x802478
  80151a:	68 ae 00 00 00       	push   $0xae
  80151f:	68 4f 24 80 00       	push   $0x80244f
  801524:	e8 37 06 00 00       	call   801b60 <_panic>

00801529 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
  80152c:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  80152f:	83 ec 04             	sub    $0x4,%esp
  801532:	68 98 24 80 00       	push   $0x802498
  801537:	68 ca 00 00 00       	push   $0xca
  80153c:	68 4f 24 80 00       	push   $0x80244f
  801541:	e8 1a 06 00 00       	call   801b60 <_panic>

00801546 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
  801549:	57                   	push   %edi
  80154a:	56                   	push   %esi
  80154b:	53                   	push   %ebx
  80154c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80154f:	8b 45 08             	mov    0x8(%ebp),%eax
  801552:	8b 55 0c             	mov    0xc(%ebp),%edx
  801555:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801558:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80155b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80155e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801561:	cd 30                	int    $0x30
  801563:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801566:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801569:	83 c4 10             	add    $0x10,%esp
  80156c:	5b                   	pop    %ebx
  80156d:	5e                   	pop    %esi
  80156e:	5f                   	pop    %edi
  80156f:	5d                   	pop    %ebp
  801570:	c3                   	ret    

00801571 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801571:	55                   	push   %ebp
  801572:	89 e5                	mov    %esp,%ebp
  801574:	83 ec 04             	sub    $0x4,%esp
  801577:	8b 45 10             	mov    0x10(%ebp),%eax
  80157a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80157d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801581:	8b 45 08             	mov    0x8(%ebp),%eax
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	52                   	push   %edx
  801589:	ff 75 0c             	pushl  0xc(%ebp)
  80158c:	50                   	push   %eax
  80158d:	6a 00                	push   $0x0
  80158f:	e8 b2 ff ff ff       	call   801546 <syscall>
  801594:	83 c4 18             	add    $0x18,%esp
}
  801597:	90                   	nop
  801598:	c9                   	leave  
  801599:	c3                   	ret    

0080159a <sys_cgetc>:

int
sys_cgetc(void)
{
  80159a:	55                   	push   %ebp
  80159b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 01                	push   $0x1
  8015a9:	e8 98 ff ff ff       	call   801546 <syscall>
  8015ae:	83 c4 18             	add    $0x18,%esp
}
  8015b1:	c9                   	leave  
  8015b2:	c3                   	ret    

008015b3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8015b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	50                   	push   %eax
  8015c2:	6a 05                	push   $0x5
  8015c4:	e8 7d ff ff ff       	call   801546 <syscall>
  8015c9:	83 c4 18             	add    $0x18,%esp
}
  8015cc:	c9                   	leave  
  8015cd:	c3                   	ret    

008015ce <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015ce:	55                   	push   %ebp
  8015cf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 02                	push   $0x2
  8015dd:	e8 64 ff ff ff       	call   801546 <syscall>
  8015e2:	83 c4 18             	add    $0x18,%esp
}
  8015e5:	c9                   	leave  
  8015e6:	c3                   	ret    

008015e7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015e7:	55                   	push   %ebp
  8015e8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 03                	push   $0x3
  8015f6:	e8 4b ff ff ff       	call   801546 <syscall>
  8015fb:	83 c4 18             	add    $0x18,%esp
}
  8015fe:	c9                   	leave  
  8015ff:	c3                   	ret    

00801600 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801600:	55                   	push   %ebp
  801601:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801603:	6a 00                	push   $0x0
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 04                	push   $0x4
  80160f:	e8 32 ff ff ff       	call   801546 <syscall>
  801614:	83 c4 18             	add    $0x18,%esp
}
  801617:	c9                   	leave  
  801618:	c3                   	ret    

00801619 <sys_env_exit>:


void sys_env_exit(void)
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	6a 00                	push   $0x0
  801624:	6a 00                	push   $0x0
  801626:	6a 06                	push   $0x6
  801628:	e8 19 ff ff ff       	call   801546 <syscall>
  80162d:	83 c4 18             	add    $0x18,%esp
}
  801630:	90                   	nop
  801631:	c9                   	leave  
  801632:	c3                   	ret    

00801633 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801633:	55                   	push   %ebp
  801634:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801636:	8b 55 0c             	mov    0xc(%ebp),%edx
  801639:	8b 45 08             	mov    0x8(%ebp),%eax
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	52                   	push   %edx
  801643:	50                   	push   %eax
  801644:	6a 07                	push   $0x7
  801646:	e8 fb fe ff ff       	call   801546 <syscall>
  80164b:	83 c4 18             	add    $0x18,%esp
}
  80164e:	c9                   	leave  
  80164f:	c3                   	ret    

00801650 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801650:	55                   	push   %ebp
  801651:	89 e5                	mov    %esp,%ebp
  801653:	56                   	push   %esi
  801654:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801655:	8b 75 18             	mov    0x18(%ebp),%esi
  801658:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80165b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80165e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801661:	8b 45 08             	mov    0x8(%ebp),%eax
  801664:	56                   	push   %esi
  801665:	53                   	push   %ebx
  801666:	51                   	push   %ecx
  801667:	52                   	push   %edx
  801668:	50                   	push   %eax
  801669:	6a 08                	push   $0x8
  80166b:	e8 d6 fe ff ff       	call   801546 <syscall>
  801670:	83 c4 18             	add    $0x18,%esp
}
  801673:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801676:	5b                   	pop    %ebx
  801677:	5e                   	pop    %esi
  801678:	5d                   	pop    %ebp
  801679:	c3                   	ret    

0080167a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80167a:	55                   	push   %ebp
  80167b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80167d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801680:	8b 45 08             	mov    0x8(%ebp),%eax
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	52                   	push   %edx
  80168a:	50                   	push   %eax
  80168b:	6a 09                	push   $0x9
  80168d:	e8 b4 fe ff ff       	call   801546 <syscall>
  801692:	83 c4 18             	add    $0x18,%esp
}
  801695:	c9                   	leave  
  801696:	c3                   	ret    

00801697 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801697:	55                   	push   %ebp
  801698:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	ff 75 0c             	pushl  0xc(%ebp)
  8016a3:	ff 75 08             	pushl  0x8(%ebp)
  8016a6:	6a 0a                	push   $0xa
  8016a8:	e8 99 fe ff ff       	call   801546 <syscall>
  8016ad:	83 c4 18             	add    $0x18,%esp
}
  8016b0:	c9                   	leave  
  8016b1:	c3                   	ret    

008016b2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8016b2:	55                   	push   %ebp
  8016b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 0b                	push   $0xb
  8016c1:	e8 80 fe ff ff       	call   801546 <syscall>
  8016c6:	83 c4 18             	add    $0x18,%esp
}
  8016c9:	c9                   	leave  
  8016ca:	c3                   	ret    

008016cb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8016cb:	55                   	push   %ebp
  8016cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 0c                	push   $0xc
  8016da:	e8 67 fe ff ff       	call   801546 <syscall>
  8016df:	83 c4 18             	add    $0x18,%esp
}
  8016e2:	c9                   	leave  
  8016e3:	c3                   	ret    

008016e4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8016e4:	55                   	push   %ebp
  8016e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 0d                	push   $0xd
  8016f3:	e8 4e fe ff ff       	call   801546 <syscall>
  8016f8:	83 c4 18             	add    $0x18,%esp
}
  8016fb:	c9                   	leave  
  8016fc:	c3                   	ret    

008016fd <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8016fd:	55                   	push   %ebp
  8016fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	ff 75 0c             	pushl  0xc(%ebp)
  801709:	ff 75 08             	pushl  0x8(%ebp)
  80170c:	6a 11                	push   $0x11
  80170e:	e8 33 fe ff ff       	call   801546 <syscall>
  801713:	83 c4 18             	add    $0x18,%esp
	return;
  801716:	90                   	nop
}
  801717:	c9                   	leave  
  801718:	c3                   	ret    

00801719 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801719:	55                   	push   %ebp
  80171a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	ff 75 0c             	pushl  0xc(%ebp)
  801725:	ff 75 08             	pushl  0x8(%ebp)
  801728:	6a 12                	push   $0x12
  80172a:	e8 17 fe ff ff       	call   801546 <syscall>
  80172f:	83 c4 18             	add    $0x18,%esp
	return ;
  801732:	90                   	nop
}
  801733:	c9                   	leave  
  801734:	c3                   	ret    

00801735 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801735:	55                   	push   %ebp
  801736:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 0e                	push   $0xe
  801744:	e8 fd fd ff ff       	call   801546 <syscall>
  801749:	83 c4 18             	add    $0x18,%esp
}
  80174c:	c9                   	leave  
  80174d:	c3                   	ret    

0080174e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80174e:	55                   	push   %ebp
  80174f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	6a 00                	push   $0x0
  801757:	6a 00                	push   $0x0
  801759:	ff 75 08             	pushl  0x8(%ebp)
  80175c:	6a 0f                	push   $0xf
  80175e:	e8 e3 fd ff ff       	call   801546 <syscall>
  801763:	83 c4 18             	add    $0x18,%esp
}
  801766:	c9                   	leave  
  801767:	c3                   	ret    

00801768 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801768:	55                   	push   %ebp
  801769:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 10                	push   $0x10
  801777:	e8 ca fd ff ff       	call   801546 <syscall>
  80177c:	83 c4 18             	add    $0x18,%esp
}
  80177f:	90                   	nop
  801780:	c9                   	leave  
  801781:	c3                   	ret    

00801782 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801782:	55                   	push   %ebp
  801783:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	6a 14                	push   $0x14
  801791:	e8 b0 fd ff ff       	call   801546 <syscall>
  801796:	83 c4 18             	add    $0x18,%esp
}
  801799:	90                   	nop
  80179a:	c9                   	leave  
  80179b:	c3                   	ret    

0080179c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80179c:	55                   	push   %ebp
  80179d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 15                	push   $0x15
  8017ab:	e8 96 fd ff ff       	call   801546 <syscall>
  8017b0:	83 c4 18             	add    $0x18,%esp
}
  8017b3:	90                   	nop
  8017b4:	c9                   	leave  
  8017b5:	c3                   	ret    

008017b6 <sys_cputc>:


void
sys_cputc(const char c)
{
  8017b6:	55                   	push   %ebp
  8017b7:	89 e5                	mov    %esp,%ebp
  8017b9:	83 ec 04             	sub    $0x4,%esp
  8017bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017c2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	50                   	push   %eax
  8017cf:	6a 16                	push   $0x16
  8017d1:	e8 70 fd ff ff       	call   801546 <syscall>
  8017d6:	83 c4 18             	add    $0x18,%esp
}
  8017d9:	90                   	nop
  8017da:	c9                   	leave  
  8017db:	c3                   	ret    

008017dc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017dc:	55                   	push   %ebp
  8017dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 17                	push   $0x17
  8017eb:	e8 56 fd ff ff       	call   801546 <syscall>
  8017f0:	83 c4 18             	add    $0x18,%esp
}
  8017f3:	90                   	nop
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8017f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	ff 75 0c             	pushl  0xc(%ebp)
  801805:	50                   	push   %eax
  801806:	6a 18                	push   $0x18
  801808:	e8 39 fd ff ff       	call   801546 <syscall>
  80180d:	83 c4 18             	add    $0x18,%esp
}
  801810:	c9                   	leave  
  801811:	c3                   	ret    

00801812 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801812:	55                   	push   %ebp
  801813:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801815:	8b 55 0c             	mov    0xc(%ebp),%edx
  801818:	8b 45 08             	mov    0x8(%ebp),%eax
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	52                   	push   %edx
  801822:	50                   	push   %eax
  801823:	6a 1b                	push   $0x1b
  801825:	e8 1c fd ff ff       	call   801546 <syscall>
  80182a:	83 c4 18             	add    $0x18,%esp
}
  80182d:	c9                   	leave  
  80182e:	c3                   	ret    

0080182f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80182f:	55                   	push   %ebp
  801830:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801832:	8b 55 0c             	mov    0xc(%ebp),%edx
  801835:	8b 45 08             	mov    0x8(%ebp),%eax
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	52                   	push   %edx
  80183f:	50                   	push   %eax
  801840:	6a 19                	push   $0x19
  801842:	e8 ff fc ff ff       	call   801546 <syscall>
  801847:	83 c4 18             	add    $0x18,%esp
}
  80184a:	90                   	nop
  80184b:	c9                   	leave  
  80184c:	c3                   	ret    

0080184d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80184d:	55                   	push   %ebp
  80184e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801850:	8b 55 0c             	mov    0xc(%ebp),%edx
  801853:	8b 45 08             	mov    0x8(%ebp),%eax
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	52                   	push   %edx
  80185d:	50                   	push   %eax
  80185e:	6a 1a                	push   $0x1a
  801860:	e8 e1 fc ff ff       	call   801546 <syscall>
  801865:	83 c4 18             	add    $0x18,%esp
}
  801868:	90                   	nop
  801869:	c9                   	leave  
  80186a:	c3                   	ret    

0080186b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80186b:	55                   	push   %ebp
  80186c:	89 e5                	mov    %esp,%ebp
  80186e:	83 ec 04             	sub    $0x4,%esp
  801871:	8b 45 10             	mov    0x10(%ebp),%eax
  801874:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801877:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80187a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80187e:	8b 45 08             	mov    0x8(%ebp),%eax
  801881:	6a 00                	push   $0x0
  801883:	51                   	push   %ecx
  801884:	52                   	push   %edx
  801885:	ff 75 0c             	pushl  0xc(%ebp)
  801888:	50                   	push   %eax
  801889:	6a 1c                	push   $0x1c
  80188b:	e8 b6 fc ff ff       	call   801546 <syscall>
  801890:	83 c4 18             	add    $0x18,%esp
}
  801893:	c9                   	leave  
  801894:	c3                   	ret    

00801895 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801895:	55                   	push   %ebp
  801896:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801898:	8b 55 0c             	mov    0xc(%ebp),%edx
  80189b:	8b 45 08             	mov    0x8(%ebp),%eax
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	52                   	push   %edx
  8018a5:	50                   	push   %eax
  8018a6:	6a 1d                	push   $0x1d
  8018a8:	e8 99 fc ff ff       	call   801546 <syscall>
  8018ad:	83 c4 18             	add    $0x18,%esp
}
  8018b0:	c9                   	leave  
  8018b1:	c3                   	ret    

008018b2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8018b2:	55                   	push   %ebp
  8018b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8018b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	51                   	push   %ecx
  8018c3:	52                   	push   %edx
  8018c4:	50                   	push   %eax
  8018c5:	6a 1e                	push   $0x1e
  8018c7:	e8 7a fc ff ff       	call   801546 <syscall>
  8018cc:	83 c4 18             	add    $0x18,%esp
}
  8018cf:	c9                   	leave  
  8018d0:	c3                   	ret    

008018d1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8018d1:	55                   	push   %ebp
  8018d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8018d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	52                   	push   %edx
  8018e1:	50                   	push   %eax
  8018e2:	6a 1f                	push   $0x1f
  8018e4:	e8 5d fc ff ff       	call   801546 <syscall>
  8018e9:	83 c4 18             	add    $0x18,%esp
}
  8018ec:	c9                   	leave  
  8018ed:	c3                   	ret    

008018ee <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8018ee:	55                   	push   %ebp
  8018ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 20                	push   $0x20
  8018fd:	e8 44 fc ff ff       	call   801546 <syscall>
  801902:	83 c4 18             	add    $0x18,%esp
}
  801905:	c9                   	leave  
  801906:	c3                   	ret    

00801907 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801907:	55                   	push   %ebp
  801908:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80190a:	8b 45 08             	mov    0x8(%ebp),%eax
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	ff 75 10             	pushl  0x10(%ebp)
  801914:	ff 75 0c             	pushl  0xc(%ebp)
  801917:	50                   	push   %eax
  801918:	6a 21                	push   $0x21
  80191a:	e8 27 fc ff ff       	call   801546 <syscall>
  80191f:	83 c4 18             	add    $0x18,%esp
}
  801922:	c9                   	leave  
  801923:	c3                   	ret    

00801924 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801924:	55                   	push   %ebp
  801925:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801927:	8b 45 08             	mov    0x8(%ebp),%eax
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	50                   	push   %eax
  801933:	6a 22                	push   $0x22
  801935:	e8 0c fc ff ff       	call   801546 <syscall>
  80193a:	83 c4 18             	add    $0x18,%esp
}
  80193d:	90                   	nop
  80193e:	c9                   	leave  
  80193f:	c3                   	ret    

00801940 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801940:	55                   	push   %ebp
  801941:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801943:	8b 45 08             	mov    0x8(%ebp),%eax
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	50                   	push   %eax
  80194f:	6a 23                	push   $0x23
  801951:	e8 f0 fb ff ff       	call   801546 <syscall>
  801956:	83 c4 18             	add    $0x18,%esp
}
  801959:	90                   	nop
  80195a:	c9                   	leave  
  80195b:	c3                   	ret    

0080195c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80195c:	55                   	push   %ebp
  80195d:	89 e5                	mov    %esp,%ebp
  80195f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801962:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801965:	8d 50 04             	lea    0x4(%eax),%edx
  801968:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	52                   	push   %edx
  801972:	50                   	push   %eax
  801973:	6a 24                	push   $0x24
  801975:	e8 cc fb ff ff       	call   801546 <syscall>
  80197a:	83 c4 18             	add    $0x18,%esp
	return result;
  80197d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801980:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801983:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801986:	89 01                	mov    %eax,(%ecx)
  801988:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80198b:	8b 45 08             	mov    0x8(%ebp),%eax
  80198e:	c9                   	leave  
  80198f:	c2 04 00             	ret    $0x4

00801992 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801992:	55                   	push   %ebp
  801993:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	ff 75 10             	pushl  0x10(%ebp)
  80199c:	ff 75 0c             	pushl  0xc(%ebp)
  80199f:	ff 75 08             	pushl  0x8(%ebp)
  8019a2:	6a 13                	push   $0x13
  8019a4:	e8 9d fb ff ff       	call   801546 <syscall>
  8019a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ac:	90                   	nop
}
  8019ad:	c9                   	leave  
  8019ae:	c3                   	ret    

008019af <sys_rcr2>:
uint32 sys_rcr2()
{
  8019af:	55                   	push   %ebp
  8019b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 25                	push   $0x25
  8019be:	e8 83 fb ff ff       	call   801546 <syscall>
  8019c3:	83 c4 18             	add    $0x18,%esp
}
  8019c6:	c9                   	leave  
  8019c7:	c3                   	ret    

008019c8 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8019c8:	55                   	push   %ebp
  8019c9:	89 e5                	mov    %esp,%ebp
  8019cb:	83 ec 04             	sub    $0x4,%esp
  8019ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8019d4:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	50                   	push   %eax
  8019e1:	6a 26                	push   $0x26
  8019e3:	e8 5e fb ff ff       	call   801546 <syscall>
  8019e8:	83 c4 18             	add    $0x18,%esp
	return ;
  8019eb:	90                   	nop
}
  8019ec:	c9                   	leave  
  8019ed:	c3                   	ret    

008019ee <rsttst>:
void rsttst()
{
  8019ee:	55                   	push   %ebp
  8019ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 28                	push   $0x28
  8019fd:	e8 44 fb ff ff       	call   801546 <syscall>
  801a02:	83 c4 18             	add    $0x18,%esp
	return ;
  801a05:	90                   	nop
}
  801a06:	c9                   	leave  
  801a07:	c3                   	ret    

00801a08 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a08:	55                   	push   %ebp
  801a09:	89 e5                	mov    %esp,%ebp
  801a0b:	83 ec 04             	sub    $0x4,%esp
  801a0e:	8b 45 14             	mov    0x14(%ebp),%eax
  801a11:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a14:	8b 55 18             	mov    0x18(%ebp),%edx
  801a17:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a1b:	52                   	push   %edx
  801a1c:	50                   	push   %eax
  801a1d:	ff 75 10             	pushl  0x10(%ebp)
  801a20:	ff 75 0c             	pushl  0xc(%ebp)
  801a23:	ff 75 08             	pushl  0x8(%ebp)
  801a26:	6a 27                	push   $0x27
  801a28:	e8 19 fb ff ff       	call   801546 <syscall>
  801a2d:	83 c4 18             	add    $0x18,%esp
	return ;
  801a30:	90                   	nop
}
  801a31:	c9                   	leave  
  801a32:	c3                   	ret    

00801a33 <chktst>:
void chktst(uint32 n)
{
  801a33:	55                   	push   %ebp
  801a34:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	ff 75 08             	pushl  0x8(%ebp)
  801a41:	6a 29                	push   $0x29
  801a43:	e8 fe fa ff ff       	call   801546 <syscall>
  801a48:	83 c4 18             	add    $0x18,%esp
	return ;
  801a4b:	90                   	nop
}
  801a4c:	c9                   	leave  
  801a4d:	c3                   	ret    

00801a4e <inctst>:

void inctst()
{
  801a4e:	55                   	push   %ebp
  801a4f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a51:	6a 00                	push   $0x0
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	6a 2a                	push   $0x2a
  801a5d:	e8 e4 fa ff ff       	call   801546 <syscall>
  801a62:	83 c4 18             	add    $0x18,%esp
	return ;
  801a65:	90                   	nop
}
  801a66:	c9                   	leave  
  801a67:	c3                   	ret    

00801a68 <gettst>:
uint32 gettst()
{
  801a68:	55                   	push   %ebp
  801a69:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 00                	push   $0x0
  801a75:	6a 2b                	push   $0x2b
  801a77:	e8 ca fa ff ff       	call   801546 <syscall>
  801a7c:	83 c4 18             	add    $0x18,%esp
}
  801a7f:	c9                   	leave  
  801a80:	c3                   	ret    

00801a81 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a81:	55                   	push   %ebp
  801a82:	89 e5                	mov    %esp,%ebp
  801a84:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 2c                	push   $0x2c
  801a93:	e8 ae fa ff ff       	call   801546 <syscall>
  801a98:	83 c4 18             	add    $0x18,%esp
  801a9b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a9e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801aa2:	75 07                	jne    801aab <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801aa4:	b8 01 00 00 00       	mov    $0x1,%eax
  801aa9:	eb 05                	jmp    801ab0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801aab:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ab0:	c9                   	leave  
  801ab1:	c3                   	ret    

00801ab2 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801ab2:	55                   	push   %ebp
  801ab3:	89 e5                	mov    %esp,%ebp
  801ab5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 2c                	push   $0x2c
  801ac4:	e8 7d fa ff ff       	call   801546 <syscall>
  801ac9:	83 c4 18             	add    $0x18,%esp
  801acc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801acf:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ad3:	75 07                	jne    801adc <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ad5:	b8 01 00 00 00       	mov    $0x1,%eax
  801ada:	eb 05                	jmp    801ae1 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801adc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ae1:	c9                   	leave  
  801ae2:	c3                   	ret    

00801ae3 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ae3:	55                   	push   %ebp
  801ae4:	89 e5                	mov    %esp,%ebp
  801ae6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	6a 2c                	push   $0x2c
  801af5:	e8 4c fa ff ff       	call   801546 <syscall>
  801afa:	83 c4 18             	add    $0x18,%esp
  801afd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b00:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b04:	75 07                	jne    801b0d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b06:	b8 01 00 00 00       	mov    $0x1,%eax
  801b0b:	eb 05                	jmp    801b12 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b0d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b12:	c9                   	leave  
  801b13:	c3                   	ret    

00801b14 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b14:	55                   	push   %ebp
  801b15:	89 e5                	mov    %esp,%ebp
  801b17:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	6a 2c                	push   $0x2c
  801b26:	e8 1b fa ff ff       	call   801546 <syscall>
  801b2b:	83 c4 18             	add    $0x18,%esp
  801b2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b31:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b35:	75 07                	jne    801b3e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b37:	b8 01 00 00 00       	mov    $0x1,%eax
  801b3c:	eb 05                	jmp    801b43 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b3e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b43:	c9                   	leave  
  801b44:	c3                   	ret    

00801b45 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b45:	55                   	push   %ebp
  801b46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	ff 75 08             	pushl  0x8(%ebp)
  801b53:	6a 2d                	push   $0x2d
  801b55:	e8 ec f9 ff ff       	call   801546 <syscall>
  801b5a:	83 c4 18             	add    $0x18,%esp
	return ;
  801b5d:	90                   	nop
}
  801b5e:	c9                   	leave  
  801b5f:	c3                   	ret    

00801b60 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801b60:	55                   	push   %ebp
  801b61:	89 e5                	mov    %esp,%ebp
  801b63:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801b66:	8d 45 10             	lea    0x10(%ebp),%eax
  801b69:	83 c0 04             	add    $0x4,%eax
  801b6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801b6f:	a1 40 30 98 00       	mov    0x983040,%eax
  801b74:	85 c0                	test   %eax,%eax
  801b76:	74 16                	je     801b8e <_panic+0x2e>
		cprintf("%s: ", argv0);
  801b78:	a1 40 30 98 00       	mov    0x983040,%eax
  801b7d:	83 ec 08             	sub    $0x8,%esp
  801b80:	50                   	push   %eax
  801b81:	68 bc 24 80 00       	push   $0x8024bc
  801b86:	e8 a1 e9 ff ff       	call   80052c <cprintf>
  801b8b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801b8e:	a1 00 30 80 00       	mov    0x803000,%eax
  801b93:	ff 75 0c             	pushl  0xc(%ebp)
  801b96:	ff 75 08             	pushl  0x8(%ebp)
  801b99:	50                   	push   %eax
  801b9a:	68 c1 24 80 00       	push   $0x8024c1
  801b9f:	e8 88 e9 ff ff       	call   80052c <cprintf>
  801ba4:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801ba7:	8b 45 10             	mov    0x10(%ebp),%eax
  801baa:	83 ec 08             	sub    $0x8,%esp
  801bad:	ff 75 f4             	pushl  -0xc(%ebp)
  801bb0:	50                   	push   %eax
  801bb1:	e8 0b e9 ff ff       	call   8004c1 <vcprintf>
  801bb6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801bb9:	83 ec 08             	sub    $0x8,%esp
  801bbc:	6a 00                	push   $0x0
  801bbe:	68 dd 24 80 00       	push   $0x8024dd
  801bc3:	e8 f9 e8 ff ff       	call   8004c1 <vcprintf>
  801bc8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801bcb:	e8 7a e8 ff ff       	call   80044a <exit>

	// should not return here
	while (1) ;
  801bd0:	eb fe                	jmp    801bd0 <_panic+0x70>

00801bd2 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801bd2:	55                   	push   %ebp
  801bd3:	89 e5                	mov    %esp,%ebp
  801bd5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801bd8:	a1 20 30 80 00       	mov    0x803020,%eax
  801bdd:	8b 50 74             	mov    0x74(%eax),%edx
  801be0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801be3:	39 c2                	cmp    %eax,%edx
  801be5:	74 14                	je     801bfb <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801be7:	83 ec 04             	sub    $0x4,%esp
  801bea:	68 e0 24 80 00       	push   $0x8024e0
  801bef:	6a 26                	push   $0x26
  801bf1:	68 2c 25 80 00       	push   $0x80252c
  801bf6:	e8 65 ff ff ff       	call   801b60 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801bfb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801c02:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801c09:	e9 c2 00 00 00       	jmp    801cd0 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801c0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c11:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c18:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1b:	01 d0                	add    %edx,%eax
  801c1d:	8b 00                	mov    (%eax),%eax
  801c1f:	85 c0                	test   %eax,%eax
  801c21:	75 08                	jne    801c2b <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801c23:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801c26:	e9 a2 00 00 00       	jmp    801ccd <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801c2b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c32:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801c39:	eb 69                	jmp    801ca4 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801c3b:	a1 20 30 80 00       	mov    0x803020,%eax
  801c40:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801c46:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801c49:	89 d0                	mov    %edx,%eax
  801c4b:	01 c0                	add    %eax,%eax
  801c4d:	01 d0                	add    %edx,%eax
  801c4f:	c1 e0 02             	shl    $0x2,%eax
  801c52:	01 c8                	add    %ecx,%eax
  801c54:	8a 40 04             	mov    0x4(%eax),%al
  801c57:	84 c0                	test   %al,%al
  801c59:	75 46                	jne    801ca1 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c5b:	a1 20 30 80 00       	mov    0x803020,%eax
  801c60:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801c66:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801c69:	89 d0                	mov    %edx,%eax
  801c6b:	01 c0                	add    %eax,%eax
  801c6d:	01 d0                	add    %edx,%eax
  801c6f:	c1 e0 02             	shl    $0x2,%eax
  801c72:	01 c8                	add    %ecx,%eax
  801c74:	8b 00                	mov    (%eax),%eax
  801c76:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801c79:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c7c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801c81:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801c83:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c86:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c90:	01 c8                	add    %ecx,%eax
  801c92:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c94:	39 c2                	cmp    %eax,%edx
  801c96:	75 09                	jne    801ca1 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801c98:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801c9f:	eb 12                	jmp    801cb3 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ca1:	ff 45 e8             	incl   -0x18(%ebp)
  801ca4:	a1 20 30 80 00       	mov    0x803020,%eax
  801ca9:	8b 50 74             	mov    0x74(%eax),%edx
  801cac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801caf:	39 c2                	cmp    %eax,%edx
  801cb1:	77 88                	ja     801c3b <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801cb3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801cb7:	75 14                	jne    801ccd <CheckWSWithoutLastIndex+0xfb>
			panic(
  801cb9:	83 ec 04             	sub    $0x4,%esp
  801cbc:	68 38 25 80 00       	push   $0x802538
  801cc1:	6a 3a                	push   $0x3a
  801cc3:	68 2c 25 80 00       	push   $0x80252c
  801cc8:	e8 93 fe ff ff       	call   801b60 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801ccd:	ff 45 f0             	incl   -0x10(%ebp)
  801cd0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cd3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801cd6:	0f 8c 32 ff ff ff    	jl     801c0e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801cdc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ce3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801cea:	eb 26                	jmp    801d12 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801cec:	a1 20 30 80 00       	mov    0x803020,%eax
  801cf1:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801cf7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801cfa:	89 d0                	mov    %edx,%eax
  801cfc:	01 c0                	add    %eax,%eax
  801cfe:	01 d0                	add    %edx,%eax
  801d00:	c1 e0 02             	shl    $0x2,%eax
  801d03:	01 c8                	add    %ecx,%eax
  801d05:	8a 40 04             	mov    0x4(%eax),%al
  801d08:	3c 01                	cmp    $0x1,%al
  801d0a:	75 03                	jne    801d0f <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801d0c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d0f:	ff 45 e0             	incl   -0x20(%ebp)
  801d12:	a1 20 30 80 00       	mov    0x803020,%eax
  801d17:	8b 50 74             	mov    0x74(%eax),%edx
  801d1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d1d:	39 c2                	cmp    %eax,%edx
  801d1f:	77 cb                	ja     801cec <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801d21:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d24:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801d27:	74 14                	je     801d3d <CheckWSWithoutLastIndex+0x16b>
		panic(
  801d29:	83 ec 04             	sub    $0x4,%esp
  801d2c:	68 8c 25 80 00       	push   $0x80258c
  801d31:	6a 44                	push   $0x44
  801d33:	68 2c 25 80 00       	push   $0x80252c
  801d38:	e8 23 fe ff ff       	call   801b60 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801d3d:	90                   	nop
  801d3e:	c9                   	leave  
  801d3f:	c3                   	ret    

00801d40 <__udivdi3>:
  801d40:	55                   	push   %ebp
  801d41:	57                   	push   %edi
  801d42:	56                   	push   %esi
  801d43:	53                   	push   %ebx
  801d44:	83 ec 1c             	sub    $0x1c,%esp
  801d47:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d4b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d4f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d53:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d57:	89 ca                	mov    %ecx,%edx
  801d59:	89 f8                	mov    %edi,%eax
  801d5b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d5f:	85 f6                	test   %esi,%esi
  801d61:	75 2d                	jne    801d90 <__udivdi3+0x50>
  801d63:	39 cf                	cmp    %ecx,%edi
  801d65:	77 65                	ja     801dcc <__udivdi3+0x8c>
  801d67:	89 fd                	mov    %edi,%ebp
  801d69:	85 ff                	test   %edi,%edi
  801d6b:	75 0b                	jne    801d78 <__udivdi3+0x38>
  801d6d:	b8 01 00 00 00       	mov    $0x1,%eax
  801d72:	31 d2                	xor    %edx,%edx
  801d74:	f7 f7                	div    %edi
  801d76:	89 c5                	mov    %eax,%ebp
  801d78:	31 d2                	xor    %edx,%edx
  801d7a:	89 c8                	mov    %ecx,%eax
  801d7c:	f7 f5                	div    %ebp
  801d7e:	89 c1                	mov    %eax,%ecx
  801d80:	89 d8                	mov    %ebx,%eax
  801d82:	f7 f5                	div    %ebp
  801d84:	89 cf                	mov    %ecx,%edi
  801d86:	89 fa                	mov    %edi,%edx
  801d88:	83 c4 1c             	add    $0x1c,%esp
  801d8b:	5b                   	pop    %ebx
  801d8c:	5e                   	pop    %esi
  801d8d:	5f                   	pop    %edi
  801d8e:	5d                   	pop    %ebp
  801d8f:	c3                   	ret    
  801d90:	39 ce                	cmp    %ecx,%esi
  801d92:	77 28                	ja     801dbc <__udivdi3+0x7c>
  801d94:	0f bd fe             	bsr    %esi,%edi
  801d97:	83 f7 1f             	xor    $0x1f,%edi
  801d9a:	75 40                	jne    801ddc <__udivdi3+0x9c>
  801d9c:	39 ce                	cmp    %ecx,%esi
  801d9e:	72 0a                	jb     801daa <__udivdi3+0x6a>
  801da0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801da4:	0f 87 9e 00 00 00    	ja     801e48 <__udivdi3+0x108>
  801daa:	b8 01 00 00 00       	mov    $0x1,%eax
  801daf:	89 fa                	mov    %edi,%edx
  801db1:	83 c4 1c             	add    $0x1c,%esp
  801db4:	5b                   	pop    %ebx
  801db5:	5e                   	pop    %esi
  801db6:	5f                   	pop    %edi
  801db7:	5d                   	pop    %ebp
  801db8:	c3                   	ret    
  801db9:	8d 76 00             	lea    0x0(%esi),%esi
  801dbc:	31 ff                	xor    %edi,%edi
  801dbe:	31 c0                	xor    %eax,%eax
  801dc0:	89 fa                	mov    %edi,%edx
  801dc2:	83 c4 1c             	add    $0x1c,%esp
  801dc5:	5b                   	pop    %ebx
  801dc6:	5e                   	pop    %esi
  801dc7:	5f                   	pop    %edi
  801dc8:	5d                   	pop    %ebp
  801dc9:	c3                   	ret    
  801dca:	66 90                	xchg   %ax,%ax
  801dcc:	89 d8                	mov    %ebx,%eax
  801dce:	f7 f7                	div    %edi
  801dd0:	31 ff                	xor    %edi,%edi
  801dd2:	89 fa                	mov    %edi,%edx
  801dd4:	83 c4 1c             	add    $0x1c,%esp
  801dd7:	5b                   	pop    %ebx
  801dd8:	5e                   	pop    %esi
  801dd9:	5f                   	pop    %edi
  801dda:	5d                   	pop    %ebp
  801ddb:	c3                   	ret    
  801ddc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801de1:	89 eb                	mov    %ebp,%ebx
  801de3:	29 fb                	sub    %edi,%ebx
  801de5:	89 f9                	mov    %edi,%ecx
  801de7:	d3 e6                	shl    %cl,%esi
  801de9:	89 c5                	mov    %eax,%ebp
  801deb:	88 d9                	mov    %bl,%cl
  801ded:	d3 ed                	shr    %cl,%ebp
  801def:	89 e9                	mov    %ebp,%ecx
  801df1:	09 f1                	or     %esi,%ecx
  801df3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801df7:	89 f9                	mov    %edi,%ecx
  801df9:	d3 e0                	shl    %cl,%eax
  801dfb:	89 c5                	mov    %eax,%ebp
  801dfd:	89 d6                	mov    %edx,%esi
  801dff:	88 d9                	mov    %bl,%cl
  801e01:	d3 ee                	shr    %cl,%esi
  801e03:	89 f9                	mov    %edi,%ecx
  801e05:	d3 e2                	shl    %cl,%edx
  801e07:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e0b:	88 d9                	mov    %bl,%cl
  801e0d:	d3 e8                	shr    %cl,%eax
  801e0f:	09 c2                	or     %eax,%edx
  801e11:	89 d0                	mov    %edx,%eax
  801e13:	89 f2                	mov    %esi,%edx
  801e15:	f7 74 24 0c          	divl   0xc(%esp)
  801e19:	89 d6                	mov    %edx,%esi
  801e1b:	89 c3                	mov    %eax,%ebx
  801e1d:	f7 e5                	mul    %ebp
  801e1f:	39 d6                	cmp    %edx,%esi
  801e21:	72 19                	jb     801e3c <__udivdi3+0xfc>
  801e23:	74 0b                	je     801e30 <__udivdi3+0xf0>
  801e25:	89 d8                	mov    %ebx,%eax
  801e27:	31 ff                	xor    %edi,%edi
  801e29:	e9 58 ff ff ff       	jmp    801d86 <__udivdi3+0x46>
  801e2e:	66 90                	xchg   %ax,%ax
  801e30:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e34:	89 f9                	mov    %edi,%ecx
  801e36:	d3 e2                	shl    %cl,%edx
  801e38:	39 c2                	cmp    %eax,%edx
  801e3a:	73 e9                	jae    801e25 <__udivdi3+0xe5>
  801e3c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e3f:	31 ff                	xor    %edi,%edi
  801e41:	e9 40 ff ff ff       	jmp    801d86 <__udivdi3+0x46>
  801e46:	66 90                	xchg   %ax,%ax
  801e48:	31 c0                	xor    %eax,%eax
  801e4a:	e9 37 ff ff ff       	jmp    801d86 <__udivdi3+0x46>
  801e4f:	90                   	nop

00801e50 <__umoddi3>:
  801e50:	55                   	push   %ebp
  801e51:	57                   	push   %edi
  801e52:	56                   	push   %esi
  801e53:	53                   	push   %ebx
  801e54:	83 ec 1c             	sub    $0x1c,%esp
  801e57:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e5b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e5f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e63:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e67:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e6b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e6f:	89 f3                	mov    %esi,%ebx
  801e71:	89 fa                	mov    %edi,%edx
  801e73:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e77:	89 34 24             	mov    %esi,(%esp)
  801e7a:	85 c0                	test   %eax,%eax
  801e7c:	75 1a                	jne    801e98 <__umoddi3+0x48>
  801e7e:	39 f7                	cmp    %esi,%edi
  801e80:	0f 86 a2 00 00 00    	jbe    801f28 <__umoddi3+0xd8>
  801e86:	89 c8                	mov    %ecx,%eax
  801e88:	89 f2                	mov    %esi,%edx
  801e8a:	f7 f7                	div    %edi
  801e8c:	89 d0                	mov    %edx,%eax
  801e8e:	31 d2                	xor    %edx,%edx
  801e90:	83 c4 1c             	add    $0x1c,%esp
  801e93:	5b                   	pop    %ebx
  801e94:	5e                   	pop    %esi
  801e95:	5f                   	pop    %edi
  801e96:	5d                   	pop    %ebp
  801e97:	c3                   	ret    
  801e98:	39 f0                	cmp    %esi,%eax
  801e9a:	0f 87 ac 00 00 00    	ja     801f4c <__umoddi3+0xfc>
  801ea0:	0f bd e8             	bsr    %eax,%ebp
  801ea3:	83 f5 1f             	xor    $0x1f,%ebp
  801ea6:	0f 84 ac 00 00 00    	je     801f58 <__umoddi3+0x108>
  801eac:	bf 20 00 00 00       	mov    $0x20,%edi
  801eb1:	29 ef                	sub    %ebp,%edi
  801eb3:	89 fe                	mov    %edi,%esi
  801eb5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801eb9:	89 e9                	mov    %ebp,%ecx
  801ebb:	d3 e0                	shl    %cl,%eax
  801ebd:	89 d7                	mov    %edx,%edi
  801ebf:	89 f1                	mov    %esi,%ecx
  801ec1:	d3 ef                	shr    %cl,%edi
  801ec3:	09 c7                	or     %eax,%edi
  801ec5:	89 e9                	mov    %ebp,%ecx
  801ec7:	d3 e2                	shl    %cl,%edx
  801ec9:	89 14 24             	mov    %edx,(%esp)
  801ecc:	89 d8                	mov    %ebx,%eax
  801ece:	d3 e0                	shl    %cl,%eax
  801ed0:	89 c2                	mov    %eax,%edx
  801ed2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ed6:	d3 e0                	shl    %cl,%eax
  801ed8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801edc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ee0:	89 f1                	mov    %esi,%ecx
  801ee2:	d3 e8                	shr    %cl,%eax
  801ee4:	09 d0                	or     %edx,%eax
  801ee6:	d3 eb                	shr    %cl,%ebx
  801ee8:	89 da                	mov    %ebx,%edx
  801eea:	f7 f7                	div    %edi
  801eec:	89 d3                	mov    %edx,%ebx
  801eee:	f7 24 24             	mull   (%esp)
  801ef1:	89 c6                	mov    %eax,%esi
  801ef3:	89 d1                	mov    %edx,%ecx
  801ef5:	39 d3                	cmp    %edx,%ebx
  801ef7:	0f 82 87 00 00 00    	jb     801f84 <__umoddi3+0x134>
  801efd:	0f 84 91 00 00 00    	je     801f94 <__umoddi3+0x144>
  801f03:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f07:	29 f2                	sub    %esi,%edx
  801f09:	19 cb                	sbb    %ecx,%ebx
  801f0b:	89 d8                	mov    %ebx,%eax
  801f0d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f11:	d3 e0                	shl    %cl,%eax
  801f13:	89 e9                	mov    %ebp,%ecx
  801f15:	d3 ea                	shr    %cl,%edx
  801f17:	09 d0                	or     %edx,%eax
  801f19:	89 e9                	mov    %ebp,%ecx
  801f1b:	d3 eb                	shr    %cl,%ebx
  801f1d:	89 da                	mov    %ebx,%edx
  801f1f:	83 c4 1c             	add    $0x1c,%esp
  801f22:	5b                   	pop    %ebx
  801f23:	5e                   	pop    %esi
  801f24:	5f                   	pop    %edi
  801f25:	5d                   	pop    %ebp
  801f26:	c3                   	ret    
  801f27:	90                   	nop
  801f28:	89 fd                	mov    %edi,%ebp
  801f2a:	85 ff                	test   %edi,%edi
  801f2c:	75 0b                	jne    801f39 <__umoddi3+0xe9>
  801f2e:	b8 01 00 00 00       	mov    $0x1,%eax
  801f33:	31 d2                	xor    %edx,%edx
  801f35:	f7 f7                	div    %edi
  801f37:	89 c5                	mov    %eax,%ebp
  801f39:	89 f0                	mov    %esi,%eax
  801f3b:	31 d2                	xor    %edx,%edx
  801f3d:	f7 f5                	div    %ebp
  801f3f:	89 c8                	mov    %ecx,%eax
  801f41:	f7 f5                	div    %ebp
  801f43:	89 d0                	mov    %edx,%eax
  801f45:	e9 44 ff ff ff       	jmp    801e8e <__umoddi3+0x3e>
  801f4a:	66 90                	xchg   %ax,%ax
  801f4c:	89 c8                	mov    %ecx,%eax
  801f4e:	89 f2                	mov    %esi,%edx
  801f50:	83 c4 1c             	add    $0x1c,%esp
  801f53:	5b                   	pop    %ebx
  801f54:	5e                   	pop    %esi
  801f55:	5f                   	pop    %edi
  801f56:	5d                   	pop    %ebp
  801f57:	c3                   	ret    
  801f58:	3b 04 24             	cmp    (%esp),%eax
  801f5b:	72 06                	jb     801f63 <__umoddi3+0x113>
  801f5d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f61:	77 0f                	ja     801f72 <__umoddi3+0x122>
  801f63:	89 f2                	mov    %esi,%edx
  801f65:	29 f9                	sub    %edi,%ecx
  801f67:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f6b:	89 14 24             	mov    %edx,(%esp)
  801f6e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f72:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f76:	8b 14 24             	mov    (%esp),%edx
  801f79:	83 c4 1c             	add    $0x1c,%esp
  801f7c:	5b                   	pop    %ebx
  801f7d:	5e                   	pop    %esi
  801f7e:	5f                   	pop    %edi
  801f7f:	5d                   	pop    %ebp
  801f80:	c3                   	ret    
  801f81:	8d 76 00             	lea    0x0(%esi),%esi
  801f84:	2b 04 24             	sub    (%esp),%eax
  801f87:	19 fa                	sbb    %edi,%edx
  801f89:	89 d1                	mov    %edx,%ecx
  801f8b:	89 c6                	mov    %eax,%esi
  801f8d:	e9 71 ff ff ff       	jmp    801f03 <__umoddi3+0xb3>
  801f92:	66 90                	xchg   %ax,%ax
  801f94:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f98:	72 ea                	jb     801f84 <__umoddi3+0x134>
  801f9a:	89 d9                	mov    %ebx,%ecx
  801f9c:	e9 62 ff ff ff       	jmp    801f03 <__umoddi3+0xb3>
