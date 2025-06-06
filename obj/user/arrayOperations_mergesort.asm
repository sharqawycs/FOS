
obj/user/arrayOperations_mergesort:     file format elf32-i386


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
  800031:	e8 3d 04 00 00       	call   800473 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

//int *Left;
//int *Right;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int32 parentenvID = sys_getparentenvid();
  80003e:	e8 da 16 00 00       	call   80171d <sys_getparentenvid>
  800043:	89 45 f0             	mov    %eax,-0x10(%ebp)

	int ret;
	/*[1] GET SHARED VARs*/
	//Get the shared array & its size
	int *numOfElements = NULL;
  800046:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int *sharedArray = NULL;
  80004d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	sharedArray = sget(parentenvID, "arr") ;
  800054:	83 ec 08             	sub    $0x8,%esp
  800057:	68 e0 20 80 00       	push   $0x8020e0
  80005c:	ff 75 f0             	pushl  -0x10(%ebp)
  80005f:	e8 8f 13 00 00       	call   8013f3 <sget>
  800064:	83 c4 10             	add    $0x10,%esp
  800067:	89 45 e8             	mov    %eax,-0x18(%ebp)
	numOfElements = sget(parentenvID, "arrSize") ;
  80006a:	83 ec 08             	sub    $0x8,%esp
  80006d:	68 e4 20 80 00       	push   $0x8020e4
  800072:	ff 75 f0             	pushl  -0x10(%ebp)
  800075:	e8 79 13 00 00       	call   8013f3 <sget>
  80007a:	83 c4 10             	add    $0x10,%esp
  80007d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	//PrintElements(sharedArray, *numOfElements);

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800080:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	finishedCount = sget(parentenvID, "finishedCount") ;
  800087:	83 ec 08             	sub    $0x8,%esp
  80008a:	68 ec 20 80 00       	push   $0x8020ec
  80008f:	ff 75 f0             	pushl  -0x10(%ebp)
  800092:	e8 5c 13 00 00       	call   8013f3 <sget>
  800097:	83 c4 10             	add    $0x10,%esp
  80009a:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("mergesortedArr", sizeof(int) * *numOfElements, 0) ;
  80009d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000a0:	8b 00                	mov    (%eax),%eax
  8000a2:	c1 e0 02             	shl    $0x2,%eax
  8000a5:	83 ec 04             	sub    $0x4,%esp
  8000a8:	6a 00                	push   $0x0
  8000aa:	50                   	push   %eax
  8000ab:	68 fa 20 80 00       	push   $0x8020fa
  8000b0:	e8 1e 13 00 00       	call   8013d3 <smalloc>
  8000b5:	83 c4 10             	add    $0x10,%esp
  8000b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000c2:	eb 25                	jmp    8000e9 <_main+0xb1>
	{
		sortedArray[i] = sharedArray[i];
  8000c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000d1:	01 c2                	add    %eax,%edx
  8000d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000d6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e0:	01 c8                	add    %ecx,%eax
  8000e2:	8b 00                	mov    (%eax),%eax
  8000e4:	89 02                	mov    %eax,(%edx)
	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("mergesortedArr", sizeof(int) * *numOfElements, 0) ;
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000e6:	ff 45 f4             	incl   -0xc(%ebp)
  8000e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ec:	8b 00                	mov    (%eax),%eax
  8000ee:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f1:	7f d1                	jg     8000c4 <_main+0x8c>
	}
//	//Create two temps array for "left" & "right"
//	Left = smalloc("mergesortLeftArr", sizeof(int) * (*numOfElements), 1) ;
//	Right = smalloc("mergesortRightArr", sizeof(int) * (*numOfElements), 1) ;

	MSort(sortedArray, 1, *numOfElements);
  8000f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000f6:	8b 00                	mov    (%eax),%eax
  8000f8:	83 ec 04             	sub    $0x4,%esp
  8000fb:	50                   	push   %eax
  8000fc:	6a 01                	push   $0x1
  8000fe:	ff 75 e0             	pushl  -0x20(%ebp)
  800101:	e8 fc 00 00 00       	call   800202 <MSort>
  800106:	83 c4 10             	add    $0x10,%esp
	cprintf("Merge sort is Finished!!!!\n") ;
  800109:	83 ec 0c             	sub    $0xc,%esp
  80010c:	68 09 21 80 00       	push   $0x802109
  800111:	e8 33 05 00 00       	call   800649 <cprintf>
  800116:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THE RESULTS & DECLARE FINISHING*/
	(*finishedCount)++ ;
  800119:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80011c:	8b 00                	mov    (%eax),%eax
  80011e:	8d 50 01             	lea    0x1(%eax),%edx
  800121:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800124:	89 10                	mov    %edx,(%eax)

}
  800126:	90                   	nop
  800127:	c9                   	leave  
  800128:	c3                   	ret    

00800129 <Swap>:

void Swap(int *Elements, int First, int Second)
{
  800129:	55                   	push   %ebp
  80012a:	89 e5                	mov    %esp,%ebp
  80012c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80012f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800132:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800139:	8b 45 08             	mov    0x8(%ebp),%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	8b 00                	mov    (%eax),%eax
  800140:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800143:	8b 45 0c             	mov    0xc(%ebp),%eax
  800146:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80014d:	8b 45 08             	mov    0x8(%ebp),%eax
  800150:	01 c2                	add    %eax,%edx
  800152:	8b 45 10             	mov    0x10(%ebp),%eax
  800155:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80015c:	8b 45 08             	mov    0x8(%ebp),%eax
  80015f:	01 c8                	add    %ecx,%eax
  800161:	8b 00                	mov    (%eax),%eax
  800163:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800165:	8b 45 10             	mov    0x10(%ebp),%eax
  800168:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80016f:	8b 45 08             	mov    0x8(%ebp),%eax
  800172:	01 c2                	add    %eax,%edx
  800174:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800177:	89 02                	mov    %eax,(%edx)
}
  800179:	90                   	nop
  80017a:	c9                   	leave  
  80017b:	c3                   	ret    

0080017c <PrintElements>:


void PrintElements(int *Elements, int NumOfElements)
{
  80017c:	55                   	push   %ebp
  80017d:	89 e5                	mov    %esp,%ebp
  80017f:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800182:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800189:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800190:	eb 42                	jmp    8001d4 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800192:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800195:	99                   	cltd   
  800196:	f7 7d f0             	idivl  -0x10(%ebp)
  800199:	89 d0                	mov    %edx,%eax
  80019b:	85 c0                	test   %eax,%eax
  80019d:	75 10                	jne    8001af <PrintElements+0x33>
			cprintf("\n");
  80019f:	83 ec 0c             	sub    $0xc,%esp
  8001a2:	68 25 21 80 00       	push   $0x802125
  8001a7:	e8 9d 04 00 00       	call   800649 <cprintf>
  8001ac:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8001af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001b2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8001bc:	01 d0                	add    %edx,%eax
  8001be:	8b 00                	mov    (%eax),%eax
  8001c0:	83 ec 08             	sub    $0x8,%esp
  8001c3:	50                   	push   %eax
  8001c4:	68 27 21 80 00       	push   $0x802127
  8001c9:	e8 7b 04 00 00       	call   800649 <cprintf>
  8001ce:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8001d1:	ff 45 f4             	incl   -0xc(%ebp)
  8001d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d7:	48                   	dec    %eax
  8001d8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8001db:	7f b5                	jg     800192 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8001dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8001ea:	01 d0                	add    %edx,%eax
  8001ec:	8b 00                	mov    (%eax),%eax
  8001ee:	83 ec 08             	sub    $0x8,%esp
  8001f1:	50                   	push   %eax
  8001f2:	68 2c 21 80 00       	push   $0x80212c
  8001f7:	e8 4d 04 00 00       	call   800649 <cprintf>
  8001fc:	83 c4 10             	add    $0x10,%esp

}
  8001ff:	90                   	nop
  800200:	c9                   	leave  
  800201:	c3                   	ret    

00800202 <MSort>:


void MSort(int* A, int p, int r)
{
  800202:	55                   	push   %ebp
  800203:	89 e5                	mov    %esp,%ebp
  800205:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  800208:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80020e:	7d 54                	jge    800264 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  800210:	8b 55 0c             	mov    0xc(%ebp),%edx
  800213:	8b 45 10             	mov    0x10(%ebp),%eax
  800216:	01 d0                	add    %edx,%eax
  800218:	89 c2                	mov    %eax,%edx
  80021a:	c1 ea 1f             	shr    $0x1f,%edx
  80021d:	01 d0                	add    %edx,%eax
  80021f:	d1 f8                	sar    %eax
  800221:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  800224:	83 ec 04             	sub    $0x4,%esp
  800227:	ff 75 f4             	pushl  -0xc(%ebp)
  80022a:	ff 75 0c             	pushl  0xc(%ebp)
  80022d:	ff 75 08             	pushl  0x8(%ebp)
  800230:	e8 cd ff ff ff       	call   800202 <MSort>
  800235:	83 c4 10             	add    $0x10,%esp
//	cprintf("LEFT is sorted: from %d to %d\n", p, q);

	MSort(A, q + 1, r);
  800238:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80023b:	40                   	inc    %eax
  80023c:	83 ec 04             	sub    $0x4,%esp
  80023f:	ff 75 10             	pushl  0x10(%ebp)
  800242:	50                   	push   %eax
  800243:	ff 75 08             	pushl  0x8(%ebp)
  800246:	e8 b7 ff ff ff       	call   800202 <MSort>
  80024b:	83 c4 10             	add    $0x10,%esp
//	cprintf("RIGHT is sorted: from %d to %d\n", q+1, r);

	Merge(A, p, q, r);
  80024e:	ff 75 10             	pushl  0x10(%ebp)
  800251:	ff 75 f4             	pushl  -0xc(%ebp)
  800254:	ff 75 0c             	pushl  0xc(%ebp)
  800257:	ff 75 08             	pushl  0x8(%ebp)
  80025a:	e8 08 00 00 00       	call   800267 <Merge>
  80025f:	83 c4 10             	add    $0x10,%esp
  800262:	eb 01                	jmp    800265 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800264:	90                   	nop
//	cprintf("RIGHT is sorted: from %d to %d\n", q+1, r);

	Merge(A, p, q, r);
	//cprintf("[%d %d] + [%d %d] = [%d %d]\n", p, q, q+1, r, p, r);

}
  800265:	c9                   	leave  
  800266:	c3                   	ret    

00800267 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800267:	55                   	push   %ebp
  800268:	89 e5                	mov    %esp,%ebp
  80026a:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80026d:	8b 45 10             	mov    0x10(%ebp),%eax
  800270:	2b 45 0c             	sub    0xc(%ebp),%eax
  800273:	40                   	inc    %eax
  800274:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800277:	8b 45 14             	mov    0x14(%ebp),%eax
  80027a:	2b 45 10             	sub    0x10(%ebp),%eax
  80027d:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800280:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800287:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  80028e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800291:	c1 e0 02             	shl    $0x2,%eax
  800294:	83 ec 0c             	sub    $0xc,%esp
  800297:	50                   	push   %eax
  800298:	e8 70 11 00 00       	call   80140d <malloc>
  80029d:	83 c4 10             	add    $0x10,%esp
  8002a0:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  8002a3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002a6:	c1 e0 02             	shl    $0x2,%eax
  8002a9:	83 ec 0c             	sub    $0xc,%esp
  8002ac:	50                   	push   %eax
  8002ad:	e8 5b 11 00 00       	call   80140d <malloc>
  8002b2:	83 c4 10             	add    $0x10,%esp
  8002b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8002b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8002bf:	eb 2f                	jmp    8002f0 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  8002c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002cb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002ce:	01 c2                	add    %eax,%edx
  8002d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8002d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002d6:	01 c8                	add    %ecx,%eax
  8002d8:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8002dd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	01 c8                	add    %ecx,%eax
  8002e9:	8b 00                	mov    (%eax),%eax
  8002eb:	89 02                	mov    %eax,(%edx)
	int* Left = malloc(sizeof(int) * leftCapacity);

	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8002ed:	ff 45 ec             	incl   -0x14(%ebp)
  8002f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002f3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8002f6:	7c c9                	jl     8002c1 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8002f8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8002ff:	eb 2a                	jmp    80032b <Merge+0xc4>
	{
		Right[j] = A[q + j];
  800301:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800304:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80030b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80030e:	01 c2                	add    %eax,%edx
  800310:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800313:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800316:	01 c8                	add    %ecx,%eax
  800318:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80031f:	8b 45 08             	mov    0x8(%ebp),%eax
  800322:	01 c8                	add    %ecx,%eax
  800324:	8b 00                	mov    (%eax),%eax
  800326:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  800328:	ff 45 e8             	incl   -0x18(%ebp)
  80032b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80032e:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800331:	7c ce                	jl     800301 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800333:	8b 45 0c             	mov    0xc(%ebp),%eax
  800336:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800339:	e9 0a 01 00 00       	jmp    800448 <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  80033e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800341:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800344:	0f 8d 95 00 00 00    	jge    8003df <Merge+0x178>
  80034a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80034d:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800350:	0f 8d 89 00 00 00    	jge    8003df <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800356:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800359:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800360:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800363:	01 d0                	add    %edx,%eax
  800365:	8b 10                	mov    (%eax),%edx
  800367:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80036a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800371:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800374:	01 c8                	add    %ecx,%eax
  800376:	8b 00                	mov    (%eax),%eax
  800378:	39 c2                	cmp    %eax,%edx
  80037a:	7d 33                	jge    8003af <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  80037c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80037f:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800384:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80038b:	8b 45 08             	mov    0x8(%ebp),%eax
  80038e:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800391:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800394:	8d 50 01             	lea    0x1(%eax),%edx
  800397:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80039a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8003aa:	e9 96 00 00 00       	jmp    800445 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  8003af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003b2:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8003b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003be:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c1:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8003c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c7:	8d 50 01             	lea    0x1(%eax),%edx
  8003ca:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8003cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003d7:	01 d0                	add    %edx,%eax
  8003d9:	8b 00                	mov    (%eax),%eax
  8003db:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8003dd:	eb 66                	jmp    800445 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  8003df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003e2:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8003e5:	7d 30                	jge    800417 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  8003e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003ea:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8003ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8003fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ff:	8d 50 01             	lea    0x1(%eax),%edx
  800402:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800405:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80040f:	01 d0                	add    %edx,%eax
  800411:	8b 00                	mov    (%eax),%eax
  800413:	89 01                	mov    %eax,(%ecx)
  800415:	eb 2e                	jmp    800445 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  800417:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80041a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80041f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800426:	8b 45 08             	mov    0x8(%ebp),%eax
  800429:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80042c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80042f:	8d 50 01             	lea    0x1(%eax),%edx
  800432:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800435:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80043f:	01 d0                	add    %edx,%eax
  800441:	8b 00                	mov    (%eax),%eax
  800443:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800445:	ff 45 e4             	incl   -0x1c(%ebp)
  800448:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80044b:	3b 45 14             	cmp    0x14(%ebp),%eax
  80044e:	0f 8e ea fe ff ff    	jle    80033e <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

	free(Left);
  800454:	83 ec 0c             	sub    $0xc,%esp
  800457:	ff 75 d8             	pushl  -0x28(%ebp)
  80045a:	e8 cf 10 00 00       	call   80152e <free>
  80045f:	83 c4 10             	add    $0x10,%esp
	free(Right);
  800462:	83 ec 0c             	sub    $0xc,%esp
  800465:	ff 75 d4             	pushl  -0x2c(%ebp)
  800468:	e8 c1 10 00 00       	call   80152e <free>
  80046d:	83 c4 10             	add    $0x10,%esp

}
  800470:	90                   	nop
  800471:	c9                   	leave  
  800472:	c3                   	ret    

00800473 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800473:	55                   	push   %ebp
  800474:	89 e5                	mov    %esp,%ebp
  800476:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800479:	e8 86 12 00 00       	call   801704 <sys_getenvindex>
  80047e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800481:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800484:	89 d0                	mov    %edx,%eax
  800486:	01 c0                	add    %eax,%eax
  800488:	01 d0                	add    %edx,%eax
  80048a:	c1 e0 02             	shl    $0x2,%eax
  80048d:	01 d0                	add    %edx,%eax
  80048f:	c1 e0 06             	shl    $0x6,%eax
  800492:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800497:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80049c:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a1:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8004a7:	84 c0                	test   %al,%al
  8004a9:	74 0f                	je     8004ba <libmain+0x47>
		binaryname = myEnv->prog_name;
  8004ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b0:	05 f4 02 00 00       	add    $0x2f4,%eax
  8004b5:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8004ba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8004be:	7e 0a                	jle    8004ca <libmain+0x57>
		binaryname = argv[0];
  8004c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c3:	8b 00                	mov    (%eax),%eax
  8004c5:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8004ca:	83 ec 08             	sub    $0x8,%esp
  8004cd:	ff 75 0c             	pushl  0xc(%ebp)
  8004d0:	ff 75 08             	pushl  0x8(%ebp)
  8004d3:	e8 60 fb ff ff       	call   800038 <_main>
  8004d8:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8004db:	e8 bf 13 00 00       	call   80189f <sys_disable_interrupt>
	cprintf("**************************************\n");
  8004e0:	83 ec 0c             	sub    $0xc,%esp
  8004e3:	68 48 21 80 00       	push   $0x802148
  8004e8:	e8 5c 01 00 00       	call   800649 <cprintf>
  8004ed:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8004f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f5:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8004fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800500:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800506:	83 ec 04             	sub    $0x4,%esp
  800509:	52                   	push   %edx
  80050a:	50                   	push   %eax
  80050b:	68 70 21 80 00       	push   $0x802170
  800510:	e8 34 01 00 00       	call   800649 <cprintf>
  800515:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800518:	a1 20 30 80 00       	mov    0x803020,%eax
  80051d:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800523:	83 ec 08             	sub    $0x8,%esp
  800526:	50                   	push   %eax
  800527:	68 95 21 80 00       	push   $0x802195
  80052c:	e8 18 01 00 00       	call   800649 <cprintf>
  800531:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800534:	83 ec 0c             	sub    $0xc,%esp
  800537:	68 48 21 80 00       	push   $0x802148
  80053c:	e8 08 01 00 00       	call   800649 <cprintf>
  800541:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800544:	e8 70 13 00 00       	call   8018b9 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800549:	e8 19 00 00 00       	call   800567 <exit>
}
  80054e:	90                   	nop
  80054f:	c9                   	leave  
  800550:	c3                   	ret    

00800551 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800551:	55                   	push   %ebp
  800552:	89 e5                	mov    %esp,%ebp
  800554:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800557:	83 ec 0c             	sub    $0xc,%esp
  80055a:	6a 00                	push   $0x0
  80055c:	e8 6f 11 00 00       	call   8016d0 <sys_env_destroy>
  800561:	83 c4 10             	add    $0x10,%esp
}
  800564:	90                   	nop
  800565:	c9                   	leave  
  800566:	c3                   	ret    

00800567 <exit>:

void
exit(void)
{
  800567:	55                   	push   %ebp
  800568:	89 e5                	mov    %esp,%ebp
  80056a:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80056d:	e8 c4 11 00 00       	call   801736 <sys_env_exit>
}
  800572:	90                   	nop
  800573:	c9                   	leave  
  800574:	c3                   	ret    

00800575 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800575:	55                   	push   %ebp
  800576:	89 e5                	mov    %esp,%ebp
  800578:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80057b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80057e:	8b 00                	mov    (%eax),%eax
  800580:	8d 48 01             	lea    0x1(%eax),%ecx
  800583:	8b 55 0c             	mov    0xc(%ebp),%edx
  800586:	89 0a                	mov    %ecx,(%edx)
  800588:	8b 55 08             	mov    0x8(%ebp),%edx
  80058b:	88 d1                	mov    %dl,%cl
  80058d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800590:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800594:	8b 45 0c             	mov    0xc(%ebp),%eax
  800597:	8b 00                	mov    (%eax),%eax
  800599:	3d ff 00 00 00       	cmp    $0xff,%eax
  80059e:	75 2c                	jne    8005cc <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005a0:	a0 24 30 80 00       	mov    0x803024,%al
  8005a5:	0f b6 c0             	movzbl %al,%eax
  8005a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005ab:	8b 12                	mov    (%edx),%edx
  8005ad:	89 d1                	mov    %edx,%ecx
  8005af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005b2:	83 c2 08             	add    $0x8,%edx
  8005b5:	83 ec 04             	sub    $0x4,%esp
  8005b8:	50                   	push   %eax
  8005b9:	51                   	push   %ecx
  8005ba:	52                   	push   %edx
  8005bb:	e8 ce 10 00 00       	call   80168e <sys_cputs>
  8005c0:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005c6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8005cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005cf:	8b 40 04             	mov    0x4(%eax),%eax
  8005d2:	8d 50 01             	lea    0x1(%eax),%edx
  8005d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005d8:	89 50 04             	mov    %edx,0x4(%eax)
}
  8005db:	90                   	nop
  8005dc:	c9                   	leave  
  8005dd:	c3                   	ret    

008005de <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8005de:	55                   	push   %ebp
  8005df:	89 e5                	mov    %esp,%ebp
  8005e1:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8005e7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8005ee:	00 00 00 
	b.cnt = 0;
  8005f1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8005f8:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8005fb:	ff 75 0c             	pushl  0xc(%ebp)
  8005fe:	ff 75 08             	pushl  0x8(%ebp)
  800601:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800607:	50                   	push   %eax
  800608:	68 75 05 80 00       	push   $0x800575
  80060d:	e8 11 02 00 00       	call   800823 <vprintfmt>
  800612:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800615:	a0 24 30 80 00       	mov    0x803024,%al
  80061a:	0f b6 c0             	movzbl %al,%eax
  80061d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800623:	83 ec 04             	sub    $0x4,%esp
  800626:	50                   	push   %eax
  800627:	52                   	push   %edx
  800628:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80062e:	83 c0 08             	add    $0x8,%eax
  800631:	50                   	push   %eax
  800632:	e8 57 10 00 00       	call   80168e <sys_cputs>
  800637:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80063a:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800641:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800647:	c9                   	leave  
  800648:	c3                   	ret    

00800649 <cprintf>:

int cprintf(const char *fmt, ...) {
  800649:	55                   	push   %ebp
  80064a:	89 e5                	mov    %esp,%ebp
  80064c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80064f:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800656:	8d 45 0c             	lea    0xc(%ebp),%eax
  800659:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80065c:	8b 45 08             	mov    0x8(%ebp),%eax
  80065f:	83 ec 08             	sub    $0x8,%esp
  800662:	ff 75 f4             	pushl  -0xc(%ebp)
  800665:	50                   	push   %eax
  800666:	e8 73 ff ff ff       	call   8005de <vcprintf>
  80066b:	83 c4 10             	add    $0x10,%esp
  80066e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800671:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800674:	c9                   	leave  
  800675:	c3                   	ret    

00800676 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800676:	55                   	push   %ebp
  800677:	89 e5                	mov    %esp,%ebp
  800679:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80067c:	e8 1e 12 00 00       	call   80189f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800681:	8d 45 0c             	lea    0xc(%ebp),%eax
  800684:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800687:	8b 45 08             	mov    0x8(%ebp),%eax
  80068a:	83 ec 08             	sub    $0x8,%esp
  80068d:	ff 75 f4             	pushl  -0xc(%ebp)
  800690:	50                   	push   %eax
  800691:	e8 48 ff ff ff       	call   8005de <vcprintf>
  800696:	83 c4 10             	add    $0x10,%esp
  800699:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80069c:	e8 18 12 00 00       	call   8018b9 <sys_enable_interrupt>
	return cnt;
  8006a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006a4:	c9                   	leave  
  8006a5:	c3                   	ret    

008006a6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006a6:	55                   	push   %ebp
  8006a7:	89 e5                	mov    %esp,%ebp
  8006a9:	53                   	push   %ebx
  8006aa:	83 ec 14             	sub    $0x14,%esp
  8006ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8006b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8006b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006b9:	8b 45 18             	mov    0x18(%ebp),%eax
  8006bc:	ba 00 00 00 00       	mov    $0x0,%edx
  8006c1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006c4:	77 55                	ja     80071b <printnum+0x75>
  8006c6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006c9:	72 05                	jb     8006d0 <printnum+0x2a>
  8006cb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006ce:	77 4b                	ja     80071b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006d0:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006d3:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006d6:	8b 45 18             	mov    0x18(%ebp),%eax
  8006d9:	ba 00 00 00 00       	mov    $0x0,%edx
  8006de:	52                   	push   %edx
  8006df:	50                   	push   %eax
  8006e0:	ff 75 f4             	pushl  -0xc(%ebp)
  8006e3:	ff 75 f0             	pushl  -0x10(%ebp)
  8006e6:	e8 75 17 00 00       	call   801e60 <__udivdi3>
  8006eb:	83 c4 10             	add    $0x10,%esp
  8006ee:	83 ec 04             	sub    $0x4,%esp
  8006f1:	ff 75 20             	pushl  0x20(%ebp)
  8006f4:	53                   	push   %ebx
  8006f5:	ff 75 18             	pushl  0x18(%ebp)
  8006f8:	52                   	push   %edx
  8006f9:	50                   	push   %eax
  8006fa:	ff 75 0c             	pushl  0xc(%ebp)
  8006fd:	ff 75 08             	pushl  0x8(%ebp)
  800700:	e8 a1 ff ff ff       	call   8006a6 <printnum>
  800705:	83 c4 20             	add    $0x20,%esp
  800708:	eb 1a                	jmp    800724 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80070a:	83 ec 08             	sub    $0x8,%esp
  80070d:	ff 75 0c             	pushl  0xc(%ebp)
  800710:	ff 75 20             	pushl  0x20(%ebp)
  800713:	8b 45 08             	mov    0x8(%ebp),%eax
  800716:	ff d0                	call   *%eax
  800718:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80071b:	ff 4d 1c             	decl   0x1c(%ebp)
  80071e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800722:	7f e6                	jg     80070a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800724:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800727:	bb 00 00 00 00       	mov    $0x0,%ebx
  80072c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80072f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800732:	53                   	push   %ebx
  800733:	51                   	push   %ecx
  800734:	52                   	push   %edx
  800735:	50                   	push   %eax
  800736:	e8 35 18 00 00       	call   801f70 <__umoddi3>
  80073b:	83 c4 10             	add    $0x10,%esp
  80073e:	05 d4 23 80 00       	add    $0x8023d4,%eax
  800743:	8a 00                	mov    (%eax),%al
  800745:	0f be c0             	movsbl %al,%eax
  800748:	83 ec 08             	sub    $0x8,%esp
  80074b:	ff 75 0c             	pushl  0xc(%ebp)
  80074e:	50                   	push   %eax
  80074f:	8b 45 08             	mov    0x8(%ebp),%eax
  800752:	ff d0                	call   *%eax
  800754:	83 c4 10             	add    $0x10,%esp
}
  800757:	90                   	nop
  800758:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80075b:	c9                   	leave  
  80075c:	c3                   	ret    

0080075d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80075d:	55                   	push   %ebp
  80075e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800760:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800764:	7e 1c                	jle    800782 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800766:	8b 45 08             	mov    0x8(%ebp),%eax
  800769:	8b 00                	mov    (%eax),%eax
  80076b:	8d 50 08             	lea    0x8(%eax),%edx
  80076e:	8b 45 08             	mov    0x8(%ebp),%eax
  800771:	89 10                	mov    %edx,(%eax)
  800773:	8b 45 08             	mov    0x8(%ebp),%eax
  800776:	8b 00                	mov    (%eax),%eax
  800778:	83 e8 08             	sub    $0x8,%eax
  80077b:	8b 50 04             	mov    0x4(%eax),%edx
  80077e:	8b 00                	mov    (%eax),%eax
  800780:	eb 40                	jmp    8007c2 <getuint+0x65>
	else if (lflag)
  800782:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800786:	74 1e                	je     8007a6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800788:	8b 45 08             	mov    0x8(%ebp),%eax
  80078b:	8b 00                	mov    (%eax),%eax
  80078d:	8d 50 04             	lea    0x4(%eax),%edx
  800790:	8b 45 08             	mov    0x8(%ebp),%eax
  800793:	89 10                	mov    %edx,(%eax)
  800795:	8b 45 08             	mov    0x8(%ebp),%eax
  800798:	8b 00                	mov    (%eax),%eax
  80079a:	83 e8 04             	sub    $0x4,%eax
  80079d:	8b 00                	mov    (%eax),%eax
  80079f:	ba 00 00 00 00       	mov    $0x0,%edx
  8007a4:	eb 1c                	jmp    8007c2 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a9:	8b 00                	mov    (%eax),%eax
  8007ab:	8d 50 04             	lea    0x4(%eax),%edx
  8007ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b1:	89 10                	mov    %edx,(%eax)
  8007b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b6:	8b 00                	mov    (%eax),%eax
  8007b8:	83 e8 04             	sub    $0x4,%eax
  8007bb:	8b 00                	mov    (%eax),%eax
  8007bd:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007c2:	5d                   	pop    %ebp
  8007c3:	c3                   	ret    

008007c4 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007c4:	55                   	push   %ebp
  8007c5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007c7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007cb:	7e 1c                	jle    8007e9 <getint+0x25>
		return va_arg(*ap, long long);
  8007cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d0:	8b 00                	mov    (%eax),%eax
  8007d2:	8d 50 08             	lea    0x8(%eax),%edx
  8007d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d8:	89 10                	mov    %edx,(%eax)
  8007da:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dd:	8b 00                	mov    (%eax),%eax
  8007df:	83 e8 08             	sub    $0x8,%eax
  8007e2:	8b 50 04             	mov    0x4(%eax),%edx
  8007e5:	8b 00                	mov    (%eax),%eax
  8007e7:	eb 38                	jmp    800821 <getint+0x5d>
	else if (lflag)
  8007e9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007ed:	74 1a                	je     800809 <getint+0x45>
		return va_arg(*ap, long);
  8007ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f2:	8b 00                	mov    (%eax),%eax
  8007f4:	8d 50 04             	lea    0x4(%eax),%edx
  8007f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fa:	89 10                	mov    %edx,(%eax)
  8007fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ff:	8b 00                	mov    (%eax),%eax
  800801:	83 e8 04             	sub    $0x4,%eax
  800804:	8b 00                	mov    (%eax),%eax
  800806:	99                   	cltd   
  800807:	eb 18                	jmp    800821 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800809:	8b 45 08             	mov    0x8(%ebp),%eax
  80080c:	8b 00                	mov    (%eax),%eax
  80080e:	8d 50 04             	lea    0x4(%eax),%edx
  800811:	8b 45 08             	mov    0x8(%ebp),%eax
  800814:	89 10                	mov    %edx,(%eax)
  800816:	8b 45 08             	mov    0x8(%ebp),%eax
  800819:	8b 00                	mov    (%eax),%eax
  80081b:	83 e8 04             	sub    $0x4,%eax
  80081e:	8b 00                	mov    (%eax),%eax
  800820:	99                   	cltd   
}
  800821:	5d                   	pop    %ebp
  800822:	c3                   	ret    

00800823 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800823:	55                   	push   %ebp
  800824:	89 e5                	mov    %esp,%ebp
  800826:	56                   	push   %esi
  800827:	53                   	push   %ebx
  800828:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80082b:	eb 17                	jmp    800844 <vprintfmt+0x21>
			if (ch == '\0')
  80082d:	85 db                	test   %ebx,%ebx
  80082f:	0f 84 af 03 00 00    	je     800be4 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800835:	83 ec 08             	sub    $0x8,%esp
  800838:	ff 75 0c             	pushl  0xc(%ebp)
  80083b:	53                   	push   %ebx
  80083c:	8b 45 08             	mov    0x8(%ebp),%eax
  80083f:	ff d0                	call   *%eax
  800841:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800844:	8b 45 10             	mov    0x10(%ebp),%eax
  800847:	8d 50 01             	lea    0x1(%eax),%edx
  80084a:	89 55 10             	mov    %edx,0x10(%ebp)
  80084d:	8a 00                	mov    (%eax),%al
  80084f:	0f b6 d8             	movzbl %al,%ebx
  800852:	83 fb 25             	cmp    $0x25,%ebx
  800855:	75 d6                	jne    80082d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800857:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80085b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800862:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800869:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800870:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800877:	8b 45 10             	mov    0x10(%ebp),%eax
  80087a:	8d 50 01             	lea    0x1(%eax),%edx
  80087d:	89 55 10             	mov    %edx,0x10(%ebp)
  800880:	8a 00                	mov    (%eax),%al
  800882:	0f b6 d8             	movzbl %al,%ebx
  800885:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800888:	83 f8 55             	cmp    $0x55,%eax
  80088b:	0f 87 2b 03 00 00    	ja     800bbc <vprintfmt+0x399>
  800891:	8b 04 85 f8 23 80 00 	mov    0x8023f8(,%eax,4),%eax
  800898:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80089a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80089e:	eb d7                	jmp    800877 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008a0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008a4:	eb d1                	jmp    800877 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008a6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008ad:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008b0:	89 d0                	mov    %edx,%eax
  8008b2:	c1 e0 02             	shl    $0x2,%eax
  8008b5:	01 d0                	add    %edx,%eax
  8008b7:	01 c0                	add    %eax,%eax
  8008b9:	01 d8                	add    %ebx,%eax
  8008bb:	83 e8 30             	sub    $0x30,%eax
  8008be:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c4:	8a 00                	mov    (%eax),%al
  8008c6:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008c9:	83 fb 2f             	cmp    $0x2f,%ebx
  8008cc:	7e 3e                	jle    80090c <vprintfmt+0xe9>
  8008ce:	83 fb 39             	cmp    $0x39,%ebx
  8008d1:	7f 39                	jg     80090c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008d3:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008d6:	eb d5                	jmp    8008ad <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8008db:	83 c0 04             	add    $0x4,%eax
  8008de:	89 45 14             	mov    %eax,0x14(%ebp)
  8008e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e4:	83 e8 04             	sub    $0x4,%eax
  8008e7:	8b 00                	mov    (%eax),%eax
  8008e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8008ec:	eb 1f                	jmp    80090d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8008ee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008f2:	79 83                	jns    800877 <vprintfmt+0x54>
				width = 0;
  8008f4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008fb:	e9 77 ff ff ff       	jmp    800877 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800900:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800907:	e9 6b ff ff ff       	jmp    800877 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80090c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80090d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800911:	0f 89 60 ff ff ff    	jns    800877 <vprintfmt+0x54>
				width = precision, precision = -1;
  800917:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80091a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80091d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800924:	e9 4e ff ff ff       	jmp    800877 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800929:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80092c:	e9 46 ff ff ff       	jmp    800877 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800931:	8b 45 14             	mov    0x14(%ebp),%eax
  800934:	83 c0 04             	add    $0x4,%eax
  800937:	89 45 14             	mov    %eax,0x14(%ebp)
  80093a:	8b 45 14             	mov    0x14(%ebp),%eax
  80093d:	83 e8 04             	sub    $0x4,%eax
  800940:	8b 00                	mov    (%eax),%eax
  800942:	83 ec 08             	sub    $0x8,%esp
  800945:	ff 75 0c             	pushl  0xc(%ebp)
  800948:	50                   	push   %eax
  800949:	8b 45 08             	mov    0x8(%ebp),%eax
  80094c:	ff d0                	call   *%eax
  80094e:	83 c4 10             	add    $0x10,%esp
			break;
  800951:	e9 89 02 00 00       	jmp    800bdf <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800956:	8b 45 14             	mov    0x14(%ebp),%eax
  800959:	83 c0 04             	add    $0x4,%eax
  80095c:	89 45 14             	mov    %eax,0x14(%ebp)
  80095f:	8b 45 14             	mov    0x14(%ebp),%eax
  800962:	83 e8 04             	sub    $0x4,%eax
  800965:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800967:	85 db                	test   %ebx,%ebx
  800969:	79 02                	jns    80096d <vprintfmt+0x14a>
				err = -err;
  80096b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80096d:	83 fb 64             	cmp    $0x64,%ebx
  800970:	7f 0b                	jg     80097d <vprintfmt+0x15a>
  800972:	8b 34 9d 40 22 80 00 	mov    0x802240(,%ebx,4),%esi
  800979:	85 f6                	test   %esi,%esi
  80097b:	75 19                	jne    800996 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80097d:	53                   	push   %ebx
  80097e:	68 e5 23 80 00       	push   $0x8023e5
  800983:	ff 75 0c             	pushl  0xc(%ebp)
  800986:	ff 75 08             	pushl  0x8(%ebp)
  800989:	e8 5e 02 00 00       	call   800bec <printfmt>
  80098e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800991:	e9 49 02 00 00       	jmp    800bdf <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800996:	56                   	push   %esi
  800997:	68 ee 23 80 00       	push   $0x8023ee
  80099c:	ff 75 0c             	pushl  0xc(%ebp)
  80099f:	ff 75 08             	pushl  0x8(%ebp)
  8009a2:	e8 45 02 00 00       	call   800bec <printfmt>
  8009a7:	83 c4 10             	add    $0x10,%esp
			break;
  8009aa:	e9 30 02 00 00       	jmp    800bdf <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009af:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b2:	83 c0 04             	add    $0x4,%eax
  8009b5:	89 45 14             	mov    %eax,0x14(%ebp)
  8009b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009bb:	83 e8 04             	sub    $0x4,%eax
  8009be:	8b 30                	mov    (%eax),%esi
  8009c0:	85 f6                	test   %esi,%esi
  8009c2:	75 05                	jne    8009c9 <vprintfmt+0x1a6>
				p = "(null)";
  8009c4:	be f1 23 80 00       	mov    $0x8023f1,%esi
			if (width > 0 && padc != '-')
  8009c9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009cd:	7e 6d                	jle    800a3c <vprintfmt+0x219>
  8009cf:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009d3:	74 67                	je     800a3c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009d8:	83 ec 08             	sub    $0x8,%esp
  8009db:	50                   	push   %eax
  8009dc:	56                   	push   %esi
  8009dd:	e8 0c 03 00 00       	call   800cee <strnlen>
  8009e2:	83 c4 10             	add    $0x10,%esp
  8009e5:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009e8:	eb 16                	jmp    800a00 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8009ea:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8009ee:	83 ec 08             	sub    $0x8,%esp
  8009f1:	ff 75 0c             	pushl  0xc(%ebp)
  8009f4:	50                   	push   %eax
  8009f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f8:	ff d0                	call   *%eax
  8009fa:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009fd:	ff 4d e4             	decl   -0x1c(%ebp)
  800a00:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a04:	7f e4                	jg     8009ea <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a06:	eb 34                	jmp    800a3c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a08:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a0c:	74 1c                	je     800a2a <vprintfmt+0x207>
  800a0e:	83 fb 1f             	cmp    $0x1f,%ebx
  800a11:	7e 05                	jle    800a18 <vprintfmt+0x1f5>
  800a13:	83 fb 7e             	cmp    $0x7e,%ebx
  800a16:	7e 12                	jle    800a2a <vprintfmt+0x207>
					putch('?', putdat);
  800a18:	83 ec 08             	sub    $0x8,%esp
  800a1b:	ff 75 0c             	pushl  0xc(%ebp)
  800a1e:	6a 3f                	push   $0x3f
  800a20:	8b 45 08             	mov    0x8(%ebp),%eax
  800a23:	ff d0                	call   *%eax
  800a25:	83 c4 10             	add    $0x10,%esp
  800a28:	eb 0f                	jmp    800a39 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a2a:	83 ec 08             	sub    $0x8,%esp
  800a2d:	ff 75 0c             	pushl  0xc(%ebp)
  800a30:	53                   	push   %ebx
  800a31:	8b 45 08             	mov    0x8(%ebp),%eax
  800a34:	ff d0                	call   *%eax
  800a36:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a39:	ff 4d e4             	decl   -0x1c(%ebp)
  800a3c:	89 f0                	mov    %esi,%eax
  800a3e:	8d 70 01             	lea    0x1(%eax),%esi
  800a41:	8a 00                	mov    (%eax),%al
  800a43:	0f be d8             	movsbl %al,%ebx
  800a46:	85 db                	test   %ebx,%ebx
  800a48:	74 24                	je     800a6e <vprintfmt+0x24b>
  800a4a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a4e:	78 b8                	js     800a08 <vprintfmt+0x1e5>
  800a50:	ff 4d e0             	decl   -0x20(%ebp)
  800a53:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a57:	79 af                	jns    800a08 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a59:	eb 13                	jmp    800a6e <vprintfmt+0x24b>
				putch(' ', putdat);
  800a5b:	83 ec 08             	sub    $0x8,%esp
  800a5e:	ff 75 0c             	pushl  0xc(%ebp)
  800a61:	6a 20                	push   $0x20
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	ff d0                	call   *%eax
  800a68:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a6b:	ff 4d e4             	decl   -0x1c(%ebp)
  800a6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a72:	7f e7                	jg     800a5b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a74:	e9 66 01 00 00       	jmp    800bdf <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a79:	83 ec 08             	sub    $0x8,%esp
  800a7c:	ff 75 e8             	pushl  -0x18(%ebp)
  800a7f:	8d 45 14             	lea    0x14(%ebp),%eax
  800a82:	50                   	push   %eax
  800a83:	e8 3c fd ff ff       	call   8007c4 <getint>
  800a88:	83 c4 10             	add    $0x10,%esp
  800a8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a8e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a91:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a94:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a97:	85 d2                	test   %edx,%edx
  800a99:	79 23                	jns    800abe <vprintfmt+0x29b>
				putch('-', putdat);
  800a9b:	83 ec 08             	sub    $0x8,%esp
  800a9e:	ff 75 0c             	pushl  0xc(%ebp)
  800aa1:	6a 2d                	push   $0x2d
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	ff d0                	call   *%eax
  800aa8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800aab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ab1:	f7 d8                	neg    %eax
  800ab3:	83 d2 00             	adc    $0x0,%edx
  800ab6:	f7 da                	neg    %edx
  800ab8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800abb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800abe:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ac5:	e9 bc 00 00 00       	jmp    800b86 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800aca:	83 ec 08             	sub    $0x8,%esp
  800acd:	ff 75 e8             	pushl  -0x18(%ebp)
  800ad0:	8d 45 14             	lea    0x14(%ebp),%eax
  800ad3:	50                   	push   %eax
  800ad4:	e8 84 fc ff ff       	call   80075d <getuint>
  800ad9:	83 c4 10             	add    $0x10,%esp
  800adc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800adf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ae2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ae9:	e9 98 00 00 00       	jmp    800b86 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800aee:	83 ec 08             	sub    $0x8,%esp
  800af1:	ff 75 0c             	pushl  0xc(%ebp)
  800af4:	6a 58                	push   $0x58
  800af6:	8b 45 08             	mov    0x8(%ebp),%eax
  800af9:	ff d0                	call   *%eax
  800afb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800afe:	83 ec 08             	sub    $0x8,%esp
  800b01:	ff 75 0c             	pushl  0xc(%ebp)
  800b04:	6a 58                	push   $0x58
  800b06:	8b 45 08             	mov    0x8(%ebp),%eax
  800b09:	ff d0                	call   *%eax
  800b0b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b0e:	83 ec 08             	sub    $0x8,%esp
  800b11:	ff 75 0c             	pushl  0xc(%ebp)
  800b14:	6a 58                	push   $0x58
  800b16:	8b 45 08             	mov    0x8(%ebp),%eax
  800b19:	ff d0                	call   *%eax
  800b1b:	83 c4 10             	add    $0x10,%esp
			break;
  800b1e:	e9 bc 00 00 00       	jmp    800bdf <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b23:	83 ec 08             	sub    $0x8,%esp
  800b26:	ff 75 0c             	pushl  0xc(%ebp)
  800b29:	6a 30                	push   $0x30
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	ff d0                	call   *%eax
  800b30:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b33:	83 ec 08             	sub    $0x8,%esp
  800b36:	ff 75 0c             	pushl  0xc(%ebp)
  800b39:	6a 78                	push   $0x78
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	ff d0                	call   *%eax
  800b40:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b43:	8b 45 14             	mov    0x14(%ebp),%eax
  800b46:	83 c0 04             	add    $0x4,%eax
  800b49:	89 45 14             	mov    %eax,0x14(%ebp)
  800b4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800b4f:	83 e8 04             	sub    $0x4,%eax
  800b52:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b54:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b5e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b65:	eb 1f                	jmp    800b86 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b67:	83 ec 08             	sub    $0x8,%esp
  800b6a:	ff 75 e8             	pushl  -0x18(%ebp)
  800b6d:	8d 45 14             	lea    0x14(%ebp),%eax
  800b70:	50                   	push   %eax
  800b71:	e8 e7 fb ff ff       	call   80075d <getuint>
  800b76:	83 c4 10             	add    $0x10,%esp
  800b79:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b7c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b7f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b86:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b8a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b8d:	83 ec 04             	sub    $0x4,%esp
  800b90:	52                   	push   %edx
  800b91:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b94:	50                   	push   %eax
  800b95:	ff 75 f4             	pushl  -0xc(%ebp)
  800b98:	ff 75 f0             	pushl  -0x10(%ebp)
  800b9b:	ff 75 0c             	pushl  0xc(%ebp)
  800b9e:	ff 75 08             	pushl  0x8(%ebp)
  800ba1:	e8 00 fb ff ff       	call   8006a6 <printnum>
  800ba6:	83 c4 20             	add    $0x20,%esp
			break;
  800ba9:	eb 34                	jmp    800bdf <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bab:	83 ec 08             	sub    $0x8,%esp
  800bae:	ff 75 0c             	pushl  0xc(%ebp)
  800bb1:	53                   	push   %ebx
  800bb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb5:	ff d0                	call   *%eax
  800bb7:	83 c4 10             	add    $0x10,%esp
			break;
  800bba:	eb 23                	jmp    800bdf <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bbc:	83 ec 08             	sub    $0x8,%esp
  800bbf:	ff 75 0c             	pushl  0xc(%ebp)
  800bc2:	6a 25                	push   $0x25
  800bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc7:	ff d0                	call   *%eax
  800bc9:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800bcc:	ff 4d 10             	decl   0x10(%ebp)
  800bcf:	eb 03                	jmp    800bd4 <vprintfmt+0x3b1>
  800bd1:	ff 4d 10             	decl   0x10(%ebp)
  800bd4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd7:	48                   	dec    %eax
  800bd8:	8a 00                	mov    (%eax),%al
  800bda:	3c 25                	cmp    $0x25,%al
  800bdc:	75 f3                	jne    800bd1 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800bde:	90                   	nop
		}
	}
  800bdf:	e9 47 fc ff ff       	jmp    80082b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800be4:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800be5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800be8:	5b                   	pop    %ebx
  800be9:	5e                   	pop    %esi
  800bea:	5d                   	pop    %ebp
  800beb:	c3                   	ret    

00800bec <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800bec:	55                   	push   %ebp
  800bed:	89 e5                	mov    %esp,%ebp
  800bef:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800bf2:	8d 45 10             	lea    0x10(%ebp),%eax
  800bf5:	83 c0 04             	add    $0x4,%eax
  800bf8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800bfb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfe:	ff 75 f4             	pushl  -0xc(%ebp)
  800c01:	50                   	push   %eax
  800c02:	ff 75 0c             	pushl  0xc(%ebp)
  800c05:	ff 75 08             	pushl  0x8(%ebp)
  800c08:	e8 16 fc ff ff       	call   800823 <vprintfmt>
  800c0d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c10:	90                   	nop
  800c11:	c9                   	leave  
  800c12:	c3                   	ret    

00800c13 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c13:	55                   	push   %ebp
  800c14:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c19:	8b 40 08             	mov    0x8(%eax),%eax
  800c1c:	8d 50 01             	lea    0x1(%eax),%edx
  800c1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c22:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c28:	8b 10                	mov    (%eax),%edx
  800c2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2d:	8b 40 04             	mov    0x4(%eax),%eax
  800c30:	39 c2                	cmp    %eax,%edx
  800c32:	73 12                	jae    800c46 <sprintputch+0x33>
		*b->buf++ = ch;
  800c34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c37:	8b 00                	mov    (%eax),%eax
  800c39:	8d 48 01             	lea    0x1(%eax),%ecx
  800c3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c3f:	89 0a                	mov    %ecx,(%edx)
  800c41:	8b 55 08             	mov    0x8(%ebp),%edx
  800c44:	88 10                	mov    %dl,(%eax)
}
  800c46:	90                   	nop
  800c47:	5d                   	pop    %ebp
  800c48:	c3                   	ret    

00800c49 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c49:	55                   	push   %ebp
  800c4a:	89 e5                	mov    %esp,%ebp
  800c4c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c52:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c58:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5e:	01 d0                	add    %edx,%eax
  800c60:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c63:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c6a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c6e:	74 06                	je     800c76 <vsnprintf+0x2d>
  800c70:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c74:	7f 07                	jg     800c7d <vsnprintf+0x34>
		return -E_INVAL;
  800c76:	b8 03 00 00 00       	mov    $0x3,%eax
  800c7b:	eb 20                	jmp    800c9d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c7d:	ff 75 14             	pushl  0x14(%ebp)
  800c80:	ff 75 10             	pushl  0x10(%ebp)
  800c83:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c86:	50                   	push   %eax
  800c87:	68 13 0c 80 00       	push   $0x800c13
  800c8c:	e8 92 fb ff ff       	call   800823 <vprintfmt>
  800c91:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c94:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c97:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c9d:	c9                   	leave  
  800c9e:	c3                   	ret    

00800c9f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c9f:	55                   	push   %ebp
  800ca0:	89 e5                	mov    %esp,%ebp
  800ca2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ca5:	8d 45 10             	lea    0x10(%ebp),%eax
  800ca8:	83 c0 04             	add    $0x4,%eax
  800cab:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800cae:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb1:	ff 75 f4             	pushl  -0xc(%ebp)
  800cb4:	50                   	push   %eax
  800cb5:	ff 75 0c             	pushl  0xc(%ebp)
  800cb8:	ff 75 08             	pushl  0x8(%ebp)
  800cbb:	e8 89 ff ff ff       	call   800c49 <vsnprintf>
  800cc0:	83 c4 10             	add    $0x10,%esp
  800cc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800cc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cc9:	c9                   	leave  
  800cca:	c3                   	ret    

00800ccb <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ccb:	55                   	push   %ebp
  800ccc:	89 e5                	mov    %esp,%ebp
  800cce:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800cd1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cd8:	eb 06                	jmp    800ce0 <strlen+0x15>
		n++;
  800cda:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800cdd:	ff 45 08             	incl   0x8(%ebp)
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	8a 00                	mov    (%eax),%al
  800ce5:	84 c0                	test   %al,%al
  800ce7:	75 f1                	jne    800cda <strlen+0xf>
		n++;
	return n;
  800ce9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cec:	c9                   	leave  
  800ced:	c3                   	ret    

00800cee <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800cee:	55                   	push   %ebp
  800cef:	89 e5                	mov    %esp,%ebp
  800cf1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cf4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cfb:	eb 09                	jmp    800d06 <strnlen+0x18>
		n++;
  800cfd:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d00:	ff 45 08             	incl   0x8(%ebp)
  800d03:	ff 4d 0c             	decl   0xc(%ebp)
  800d06:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d0a:	74 09                	je     800d15 <strnlen+0x27>
  800d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0f:	8a 00                	mov    (%eax),%al
  800d11:	84 c0                	test   %al,%al
  800d13:	75 e8                	jne    800cfd <strnlen+0xf>
		n++;
	return n;
  800d15:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d18:	c9                   	leave  
  800d19:	c3                   	ret    

00800d1a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d1a:	55                   	push   %ebp
  800d1b:	89 e5                	mov    %esp,%ebp
  800d1d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d26:	90                   	nop
  800d27:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2a:	8d 50 01             	lea    0x1(%eax),%edx
  800d2d:	89 55 08             	mov    %edx,0x8(%ebp)
  800d30:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d33:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d36:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d39:	8a 12                	mov    (%edx),%dl
  800d3b:	88 10                	mov    %dl,(%eax)
  800d3d:	8a 00                	mov    (%eax),%al
  800d3f:	84 c0                	test   %al,%al
  800d41:	75 e4                	jne    800d27 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d43:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d46:	c9                   	leave  
  800d47:	c3                   	ret    

00800d48 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d48:	55                   	push   %ebp
  800d49:	89 e5                	mov    %esp,%ebp
  800d4b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d51:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d54:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d5b:	eb 1f                	jmp    800d7c <strncpy+0x34>
		*dst++ = *src;
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d60:	8d 50 01             	lea    0x1(%eax),%edx
  800d63:	89 55 08             	mov    %edx,0x8(%ebp)
  800d66:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d69:	8a 12                	mov    (%edx),%dl
  800d6b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d70:	8a 00                	mov    (%eax),%al
  800d72:	84 c0                	test   %al,%al
  800d74:	74 03                	je     800d79 <strncpy+0x31>
			src++;
  800d76:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d79:	ff 45 fc             	incl   -0x4(%ebp)
  800d7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d7f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d82:	72 d9                	jb     800d5d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d84:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d87:	c9                   	leave  
  800d88:	c3                   	ret    

00800d89 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d89:	55                   	push   %ebp
  800d8a:	89 e5                	mov    %esp,%ebp
  800d8c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d92:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d95:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d99:	74 30                	je     800dcb <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d9b:	eb 16                	jmp    800db3 <strlcpy+0x2a>
			*dst++ = *src++;
  800d9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800da0:	8d 50 01             	lea    0x1(%eax),%edx
  800da3:	89 55 08             	mov    %edx,0x8(%ebp)
  800da6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800da9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dac:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800daf:	8a 12                	mov    (%edx),%dl
  800db1:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800db3:	ff 4d 10             	decl   0x10(%ebp)
  800db6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dba:	74 09                	je     800dc5 <strlcpy+0x3c>
  800dbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbf:	8a 00                	mov    (%eax),%al
  800dc1:	84 c0                	test   %al,%al
  800dc3:	75 d8                	jne    800d9d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800dc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc8:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800dcb:	8b 55 08             	mov    0x8(%ebp),%edx
  800dce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dd1:	29 c2                	sub    %eax,%edx
  800dd3:	89 d0                	mov    %edx,%eax
}
  800dd5:	c9                   	leave  
  800dd6:	c3                   	ret    

00800dd7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800dd7:	55                   	push   %ebp
  800dd8:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800dda:	eb 06                	jmp    800de2 <strcmp+0xb>
		p++, q++;
  800ddc:	ff 45 08             	incl   0x8(%ebp)
  800ddf:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800de2:	8b 45 08             	mov    0x8(%ebp),%eax
  800de5:	8a 00                	mov    (%eax),%al
  800de7:	84 c0                	test   %al,%al
  800de9:	74 0e                	je     800df9 <strcmp+0x22>
  800deb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dee:	8a 10                	mov    (%eax),%dl
  800df0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df3:	8a 00                	mov    (%eax),%al
  800df5:	38 c2                	cmp    %al,%dl
  800df7:	74 e3                	je     800ddc <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800df9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfc:	8a 00                	mov    (%eax),%al
  800dfe:	0f b6 d0             	movzbl %al,%edx
  800e01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e04:	8a 00                	mov    (%eax),%al
  800e06:	0f b6 c0             	movzbl %al,%eax
  800e09:	29 c2                	sub    %eax,%edx
  800e0b:	89 d0                	mov    %edx,%eax
}
  800e0d:	5d                   	pop    %ebp
  800e0e:	c3                   	ret    

00800e0f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e0f:	55                   	push   %ebp
  800e10:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e12:	eb 09                	jmp    800e1d <strncmp+0xe>
		n--, p++, q++;
  800e14:	ff 4d 10             	decl   0x10(%ebp)
  800e17:	ff 45 08             	incl   0x8(%ebp)
  800e1a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e21:	74 17                	je     800e3a <strncmp+0x2b>
  800e23:	8b 45 08             	mov    0x8(%ebp),%eax
  800e26:	8a 00                	mov    (%eax),%al
  800e28:	84 c0                	test   %al,%al
  800e2a:	74 0e                	je     800e3a <strncmp+0x2b>
  800e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2f:	8a 10                	mov    (%eax),%dl
  800e31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e34:	8a 00                	mov    (%eax),%al
  800e36:	38 c2                	cmp    %al,%dl
  800e38:	74 da                	je     800e14 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e3e:	75 07                	jne    800e47 <strncmp+0x38>
		return 0;
  800e40:	b8 00 00 00 00       	mov    $0x0,%eax
  800e45:	eb 14                	jmp    800e5b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e47:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	0f b6 d0             	movzbl %al,%edx
  800e4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e52:	8a 00                	mov    (%eax),%al
  800e54:	0f b6 c0             	movzbl %al,%eax
  800e57:	29 c2                	sub    %eax,%edx
  800e59:	89 d0                	mov    %edx,%eax
}
  800e5b:	5d                   	pop    %ebp
  800e5c:	c3                   	ret    

00800e5d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e5d:	55                   	push   %ebp
  800e5e:	89 e5                	mov    %esp,%ebp
  800e60:	83 ec 04             	sub    $0x4,%esp
  800e63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e66:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e69:	eb 12                	jmp    800e7d <strchr+0x20>
		if (*s == c)
  800e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6e:	8a 00                	mov    (%eax),%al
  800e70:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e73:	75 05                	jne    800e7a <strchr+0x1d>
			return (char *) s;
  800e75:	8b 45 08             	mov    0x8(%ebp),%eax
  800e78:	eb 11                	jmp    800e8b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e7a:	ff 45 08             	incl   0x8(%ebp)
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e80:	8a 00                	mov    (%eax),%al
  800e82:	84 c0                	test   %al,%al
  800e84:	75 e5                	jne    800e6b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e86:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e8b:	c9                   	leave  
  800e8c:	c3                   	ret    

00800e8d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e8d:	55                   	push   %ebp
  800e8e:	89 e5                	mov    %esp,%ebp
  800e90:	83 ec 04             	sub    $0x4,%esp
  800e93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e96:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e99:	eb 0d                	jmp    800ea8 <strfind+0x1b>
		if (*s == c)
  800e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9e:	8a 00                	mov    (%eax),%al
  800ea0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ea3:	74 0e                	je     800eb3 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ea5:	ff 45 08             	incl   0x8(%ebp)
  800ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eab:	8a 00                	mov    (%eax),%al
  800ead:	84 c0                	test   %al,%al
  800eaf:	75 ea                	jne    800e9b <strfind+0xe>
  800eb1:	eb 01                	jmp    800eb4 <strfind+0x27>
		if (*s == c)
			break;
  800eb3:	90                   	nop
	return (char *) s;
  800eb4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eb7:	c9                   	leave  
  800eb8:	c3                   	ret    

00800eb9 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800eb9:	55                   	push   %ebp
  800eba:	89 e5                	mov    %esp,%ebp
  800ebc:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ec5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ecb:	eb 0e                	jmp    800edb <memset+0x22>
		*p++ = c;
  800ecd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ed0:	8d 50 01             	lea    0x1(%eax),%edx
  800ed3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ed6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ed9:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800edb:	ff 4d f8             	decl   -0x8(%ebp)
  800ede:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ee2:	79 e9                	jns    800ecd <memset+0x14>
		*p++ = c;

	return v;
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee7:	c9                   	leave  
  800ee8:	c3                   	ret    

00800ee9 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ee9:	55                   	push   %ebp
  800eea:	89 e5                	mov    %esp,%ebp
  800eec:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800eef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800efb:	eb 16                	jmp    800f13 <memcpy+0x2a>
		*d++ = *s++;
  800efd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f00:	8d 50 01             	lea    0x1(%eax),%edx
  800f03:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f06:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f09:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f0c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f0f:	8a 12                	mov    (%edx),%dl
  800f11:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f13:	8b 45 10             	mov    0x10(%ebp),%eax
  800f16:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f19:	89 55 10             	mov    %edx,0x10(%ebp)
  800f1c:	85 c0                	test   %eax,%eax
  800f1e:	75 dd                	jne    800efd <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f20:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f23:	c9                   	leave  
  800f24:	c3                   	ret    

00800f25 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f25:	55                   	push   %ebp
  800f26:	89 e5                	mov    %esp,%ebp
  800f28:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800f2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f37:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f3a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f3d:	73 50                	jae    800f8f <memmove+0x6a>
  800f3f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f42:	8b 45 10             	mov    0x10(%ebp),%eax
  800f45:	01 d0                	add    %edx,%eax
  800f47:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f4a:	76 43                	jbe    800f8f <memmove+0x6a>
		s += n;
  800f4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f52:	8b 45 10             	mov    0x10(%ebp),%eax
  800f55:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f58:	eb 10                	jmp    800f6a <memmove+0x45>
			*--d = *--s;
  800f5a:	ff 4d f8             	decl   -0x8(%ebp)
  800f5d:	ff 4d fc             	decl   -0x4(%ebp)
  800f60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f63:	8a 10                	mov    (%eax),%dl
  800f65:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f68:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f6a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f70:	89 55 10             	mov    %edx,0x10(%ebp)
  800f73:	85 c0                	test   %eax,%eax
  800f75:	75 e3                	jne    800f5a <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f77:	eb 23                	jmp    800f9c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f79:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f7c:	8d 50 01             	lea    0x1(%eax),%edx
  800f7f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f82:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f85:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f88:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f8b:	8a 12                	mov    (%edx),%dl
  800f8d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f92:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f95:	89 55 10             	mov    %edx,0x10(%ebp)
  800f98:	85 c0                	test   %eax,%eax
  800f9a:	75 dd                	jne    800f79 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f9f:	c9                   	leave  
  800fa0:	c3                   	ret    

00800fa1 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fa1:	55                   	push   %ebp
  800fa2:	89 e5                	mov    %esp,%ebp
  800fa4:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800fad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb0:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800fb3:	eb 2a                	jmp    800fdf <memcmp+0x3e>
		if (*s1 != *s2)
  800fb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fb8:	8a 10                	mov    (%eax),%dl
  800fba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fbd:	8a 00                	mov    (%eax),%al
  800fbf:	38 c2                	cmp    %al,%dl
  800fc1:	74 16                	je     800fd9 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800fc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fc6:	8a 00                	mov    (%eax),%al
  800fc8:	0f b6 d0             	movzbl %al,%edx
  800fcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fce:	8a 00                	mov    (%eax),%al
  800fd0:	0f b6 c0             	movzbl %al,%eax
  800fd3:	29 c2                	sub    %eax,%edx
  800fd5:	89 d0                	mov    %edx,%eax
  800fd7:	eb 18                	jmp    800ff1 <memcmp+0x50>
		s1++, s2++;
  800fd9:	ff 45 fc             	incl   -0x4(%ebp)
  800fdc:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800fdf:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fe5:	89 55 10             	mov    %edx,0x10(%ebp)
  800fe8:	85 c0                	test   %eax,%eax
  800fea:	75 c9                	jne    800fb5 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800fec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ff1:	c9                   	leave  
  800ff2:	c3                   	ret    

00800ff3 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ff3:	55                   	push   %ebp
  800ff4:	89 e5                	mov    %esp,%ebp
  800ff6:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ff9:	8b 55 08             	mov    0x8(%ebp),%edx
  800ffc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fff:	01 d0                	add    %edx,%eax
  801001:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801004:	eb 15                	jmp    80101b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801006:	8b 45 08             	mov    0x8(%ebp),%eax
  801009:	8a 00                	mov    (%eax),%al
  80100b:	0f b6 d0             	movzbl %al,%edx
  80100e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801011:	0f b6 c0             	movzbl %al,%eax
  801014:	39 c2                	cmp    %eax,%edx
  801016:	74 0d                	je     801025 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801018:	ff 45 08             	incl   0x8(%ebp)
  80101b:	8b 45 08             	mov    0x8(%ebp),%eax
  80101e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801021:	72 e3                	jb     801006 <memfind+0x13>
  801023:	eb 01                	jmp    801026 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801025:	90                   	nop
	return (void *) s;
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801029:	c9                   	leave  
  80102a:	c3                   	ret    

0080102b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80102b:	55                   	push   %ebp
  80102c:	89 e5                	mov    %esp,%ebp
  80102e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801031:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801038:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80103f:	eb 03                	jmp    801044 <strtol+0x19>
		s++;
  801041:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	8a 00                	mov    (%eax),%al
  801049:	3c 20                	cmp    $0x20,%al
  80104b:	74 f4                	je     801041 <strtol+0x16>
  80104d:	8b 45 08             	mov    0x8(%ebp),%eax
  801050:	8a 00                	mov    (%eax),%al
  801052:	3c 09                	cmp    $0x9,%al
  801054:	74 eb                	je     801041 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801056:	8b 45 08             	mov    0x8(%ebp),%eax
  801059:	8a 00                	mov    (%eax),%al
  80105b:	3c 2b                	cmp    $0x2b,%al
  80105d:	75 05                	jne    801064 <strtol+0x39>
		s++;
  80105f:	ff 45 08             	incl   0x8(%ebp)
  801062:	eb 13                	jmp    801077 <strtol+0x4c>
	else if (*s == '-')
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	8a 00                	mov    (%eax),%al
  801069:	3c 2d                	cmp    $0x2d,%al
  80106b:	75 0a                	jne    801077 <strtol+0x4c>
		s++, neg = 1;
  80106d:	ff 45 08             	incl   0x8(%ebp)
  801070:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801077:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80107b:	74 06                	je     801083 <strtol+0x58>
  80107d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801081:	75 20                	jne    8010a3 <strtol+0x78>
  801083:	8b 45 08             	mov    0x8(%ebp),%eax
  801086:	8a 00                	mov    (%eax),%al
  801088:	3c 30                	cmp    $0x30,%al
  80108a:	75 17                	jne    8010a3 <strtol+0x78>
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	40                   	inc    %eax
  801090:	8a 00                	mov    (%eax),%al
  801092:	3c 78                	cmp    $0x78,%al
  801094:	75 0d                	jne    8010a3 <strtol+0x78>
		s += 2, base = 16;
  801096:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80109a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010a1:	eb 28                	jmp    8010cb <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010a3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010a7:	75 15                	jne    8010be <strtol+0x93>
  8010a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ac:	8a 00                	mov    (%eax),%al
  8010ae:	3c 30                	cmp    $0x30,%al
  8010b0:	75 0c                	jne    8010be <strtol+0x93>
		s++, base = 8;
  8010b2:	ff 45 08             	incl   0x8(%ebp)
  8010b5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010bc:	eb 0d                	jmp    8010cb <strtol+0xa0>
	else if (base == 0)
  8010be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010c2:	75 07                	jne    8010cb <strtol+0xa0>
		base = 10;
  8010c4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8010cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ce:	8a 00                	mov    (%eax),%al
  8010d0:	3c 2f                	cmp    $0x2f,%al
  8010d2:	7e 19                	jle    8010ed <strtol+0xc2>
  8010d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d7:	8a 00                	mov    (%eax),%al
  8010d9:	3c 39                	cmp    $0x39,%al
  8010db:	7f 10                	jg     8010ed <strtol+0xc2>
			dig = *s - '0';
  8010dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e0:	8a 00                	mov    (%eax),%al
  8010e2:	0f be c0             	movsbl %al,%eax
  8010e5:	83 e8 30             	sub    $0x30,%eax
  8010e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010eb:	eb 42                	jmp    80112f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8010ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f0:	8a 00                	mov    (%eax),%al
  8010f2:	3c 60                	cmp    $0x60,%al
  8010f4:	7e 19                	jle    80110f <strtol+0xe4>
  8010f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f9:	8a 00                	mov    (%eax),%al
  8010fb:	3c 7a                	cmp    $0x7a,%al
  8010fd:	7f 10                	jg     80110f <strtol+0xe4>
			dig = *s - 'a' + 10;
  8010ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801102:	8a 00                	mov    (%eax),%al
  801104:	0f be c0             	movsbl %al,%eax
  801107:	83 e8 57             	sub    $0x57,%eax
  80110a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80110d:	eb 20                	jmp    80112f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80110f:	8b 45 08             	mov    0x8(%ebp),%eax
  801112:	8a 00                	mov    (%eax),%al
  801114:	3c 40                	cmp    $0x40,%al
  801116:	7e 39                	jle    801151 <strtol+0x126>
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
  80111b:	8a 00                	mov    (%eax),%al
  80111d:	3c 5a                	cmp    $0x5a,%al
  80111f:	7f 30                	jg     801151 <strtol+0x126>
			dig = *s - 'A' + 10;
  801121:	8b 45 08             	mov    0x8(%ebp),%eax
  801124:	8a 00                	mov    (%eax),%al
  801126:	0f be c0             	movsbl %al,%eax
  801129:	83 e8 37             	sub    $0x37,%eax
  80112c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80112f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801132:	3b 45 10             	cmp    0x10(%ebp),%eax
  801135:	7d 19                	jge    801150 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801137:	ff 45 08             	incl   0x8(%ebp)
  80113a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80113d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801141:	89 c2                	mov    %eax,%edx
  801143:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801146:	01 d0                	add    %edx,%eax
  801148:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80114b:	e9 7b ff ff ff       	jmp    8010cb <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801150:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801151:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801155:	74 08                	je     80115f <strtol+0x134>
		*endptr = (char *) s;
  801157:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115a:	8b 55 08             	mov    0x8(%ebp),%edx
  80115d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80115f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801163:	74 07                	je     80116c <strtol+0x141>
  801165:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801168:	f7 d8                	neg    %eax
  80116a:	eb 03                	jmp    80116f <strtol+0x144>
  80116c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80116f:	c9                   	leave  
  801170:	c3                   	ret    

00801171 <ltostr>:

void
ltostr(long value, char *str)
{
  801171:	55                   	push   %ebp
  801172:	89 e5                	mov    %esp,%ebp
  801174:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801177:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80117e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801185:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801189:	79 13                	jns    80119e <ltostr+0x2d>
	{
		neg = 1;
  80118b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801192:	8b 45 0c             	mov    0xc(%ebp),%eax
  801195:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801198:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80119b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011a6:	99                   	cltd   
  8011a7:	f7 f9                	idiv   %ecx
  8011a9:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011af:	8d 50 01             	lea    0x1(%eax),%edx
  8011b2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011b5:	89 c2                	mov    %eax,%edx
  8011b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ba:	01 d0                	add    %edx,%eax
  8011bc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011bf:	83 c2 30             	add    $0x30,%edx
  8011c2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8011c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011c7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011cc:	f7 e9                	imul   %ecx
  8011ce:	c1 fa 02             	sar    $0x2,%edx
  8011d1:	89 c8                	mov    %ecx,%eax
  8011d3:	c1 f8 1f             	sar    $0x1f,%eax
  8011d6:	29 c2                	sub    %eax,%edx
  8011d8:	89 d0                	mov    %edx,%eax
  8011da:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8011dd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011e0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011e5:	f7 e9                	imul   %ecx
  8011e7:	c1 fa 02             	sar    $0x2,%edx
  8011ea:	89 c8                	mov    %ecx,%eax
  8011ec:	c1 f8 1f             	sar    $0x1f,%eax
  8011ef:	29 c2                	sub    %eax,%edx
  8011f1:	89 d0                	mov    %edx,%eax
  8011f3:	c1 e0 02             	shl    $0x2,%eax
  8011f6:	01 d0                	add    %edx,%eax
  8011f8:	01 c0                	add    %eax,%eax
  8011fa:	29 c1                	sub    %eax,%ecx
  8011fc:	89 ca                	mov    %ecx,%edx
  8011fe:	85 d2                	test   %edx,%edx
  801200:	75 9c                	jne    80119e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801202:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801209:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80120c:	48                   	dec    %eax
  80120d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801210:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801214:	74 3d                	je     801253 <ltostr+0xe2>
		start = 1 ;
  801216:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80121d:	eb 34                	jmp    801253 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80121f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801222:	8b 45 0c             	mov    0xc(%ebp),%eax
  801225:	01 d0                	add    %edx,%eax
  801227:	8a 00                	mov    (%eax),%al
  801229:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80122c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80122f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801232:	01 c2                	add    %eax,%edx
  801234:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801237:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123a:	01 c8                	add    %ecx,%eax
  80123c:	8a 00                	mov    (%eax),%al
  80123e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801240:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801243:	8b 45 0c             	mov    0xc(%ebp),%eax
  801246:	01 c2                	add    %eax,%edx
  801248:	8a 45 eb             	mov    -0x15(%ebp),%al
  80124b:	88 02                	mov    %al,(%edx)
		start++ ;
  80124d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801250:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801253:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801256:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801259:	7c c4                	jl     80121f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80125b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80125e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801261:	01 d0                	add    %edx,%eax
  801263:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801266:	90                   	nop
  801267:	c9                   	leave  
  801268:	c3                   	ret    

00801269 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801269:	55                   	push   %ebp
  80126a:	89 e5                	mov    %esp,%ebp
  80126c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80126f:	ff 75 08             	pushl  0x8(%ebp)
  801272:	e8 54 fa ff ff       	call   800ccb <strlen>
  801277:	83 c4 04             	add    $0x4,%esp
  80127a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80127d:	ff 75 0c             	pushl  0xc(%ebp)
  801280:	e8 46 fa ff ff       	call   800ccb <strlen>
  801285:	83 c4 04             	add    $0x4,%esp
  801288:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80128b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801292:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801299:	eb 17                	jmp    8012b2 <strcconcat+0x49>
		final[s] = str1[s] ;
  80129b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80129e:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a1:	01 c2                	add    %eax,%edx
  8012a3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a9:	01 c8                	add    %ecx,%eax
  8012ab:	8a 00                	mov    (%eax),%al
  8012ad:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012af:	ff 45 fc             	incl   -0x4(%ebp)
  8012b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012b5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012b8:	7c e1                	jl     80129b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012ba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012c1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012c8:	eb 1f                	jmp    8012e9 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012cd:	8d 50 01             	lea    0x1(%eax),%edx
  8012d0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012d3:	89 c2                	mov    %eax,%edx
  8012d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d8:	01 c2                	add    %eax,%edx
  8012da:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8012dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e0:	01 c8                	add    %ecx,%eax
  8012e2:	8a 00                	mov    (%eax),%al
  8012e4:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8012e6:	ff 45 f8             	incl   -0x8(%ebp)
  8012e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ec:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012ef:	7c d9                	jl     8012ca <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8012f1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f7:	01 d0                	add    %edx,%eax
  8012f9:	c6 00 00             	movb   $0x0,(%eax)
}
  8012fc:	90                   	nop
  8012fd:	c9                   	leave  
  8012fe:	c3                   	ret    

008012ff <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8012ff:	55                   	push   %ebp
  801300:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801302:	8b 45 14             	mov    0x14(%ebp),%eax
  801305:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80130b:	8b 45 14             	mov    0x14(%ebp),%eax
  80130e:	8b 00                	mov    (%eax),%eax
  801310:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801317:	8b 45 10             	mov    0x10(%ebp),%eax
  80131a:	01 d0                	add    %edx,%eax
  80131c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801322:	eb 0c                	jmp    801330 <strsplit+0x31>
			*string++ = 0;
  801324:	8b 45 08             	mov    0x8(%ebp),%eax
  801327:	8d 50 01             	lea    0x1(%eax),%edx
  80132a:	89 55 08             	mov    %edx,0x8(%ebp)
  80132d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	8a 00                	mov    (%eax),%al
  801335:	84 c0                	test   %al,%al
  801337:	74 18                	je     801351 <strsplit+0x52>
  801339:	8b 45 08             	mov    0x8(%ebp),%eax
  80133c:	8a 00                	mov    (%eax),%al
  80133e:	0f be c0             	movsbl %al,%eax
  801341:	50                   	push   %eax
  801342:	ff 75 0c             	pushl  0xc(%ebp)
  801345:	e8 13 fb ff ff       	call   800e5d <strchr>
  80134a:	83 c4 08             	add    $0x8,%esp
  80134d:	85 c0                	test   %eax,%eax
  80134f:	75 d3                	jne    801324 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801351:	8b 45 08             	mov    0x8(%ebp),%eax
  801354:	8a 00                	mov    (%eax),%al
  801356:	84 c0                	test   %al,%al
  801358:	74 5a                	je     8013b4 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80135a:	8b 45 14             	mov    0x14(%ebp),%eax
  80135d:	8b 00                	mov    (%eax),%eax
  80135f:	83 f8 0f             	cmp    $0xf,%eax
  801362:	75 07                	jne    80136b <strsplit+0x6c>
		{
			return 0;
  801364:	b8 00 00 00 00       	mov    $0x0,%eax
  801369:	eb 66                	jmp    8013d1 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80136b:	8b 45 14             	mov    0x14(%ebp),%eax
  80136e:	8b 00                	mov    (%eax),%eax
  801370:	8d 48 01             	lea    0x1(%eax),%ecx
  801373:	8b 55 14             	mov    0x14(%ebp),%edx
  801376:	89 0a                	mov    %ecx,(%edx)
  801378:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80137f:	8b 45 10             	mov    0x10(%ebp),%eax
  801382:	01 c2                	add    %eax,%edx
  801384:	8b 45 08             	mov    0x8(%ebp),%eax
  801387:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801389:	eb 03                	jmp    80138e <strsplit+0x8f>
			string++;
  80138b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	8a 00                	mov    (%eax),%al
  801393:	84 c0                	test   %al,%al
  801395:	74 8b                	je     801322 <strsplit+0x23>
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	8a 00                	mov    (%eax),%al
  80139c:	0f be c0             	movsbl %al,%eax
  80139f:	50                   	push   %eax
  8013a0:	ff 75 0c             	pushl  0xc(%ebp)
  8013a3:	e8 b5 fa ff ff       	call   800e5d <strchr>
  8013a8:	83 c4 08             	add    $0x8,%esp
  8013ab:	85 c0                	test   %eax,%eax
  8013ad:	74 dc                	je     80138b <strsplit+0x8c>
			string++;
	}
  8013af:	e9 6e ff ff ff       	jmp    801322 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013b4:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8013b8:	8b 00                	mov    (%eax),%eax
  8013ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c4:	01 d0                	add    %edx,%eax
  8013c6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013cc:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8013d1:	c9                   	leave  
  8013d2:	c3                   	ret    

008013d3 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8013d3:	55                   	push   %ebp
  8013d4:	89 e5                	mov    %esp,%ebp
  8013d6:	83 ec 18             	sub    $0x18,%esp
  8013d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8013dc:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8013df:	83 ec 04             	sub    $0x4,%esp
  8013e2:	68 50 25 80 00       	push   $0x802550
  8013e7:	6a 17                	push   $0x17
  8013e9:	68 6f 25 80 00       	push   $0x80256f
  8013ee:	e8 8a 08 00 00       	call   801c7d <_panic>

008013f3 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8013f3:	55                   	push   %ebp
  8013f4:	89 e5                	mov    %esp,%ebp
  8013f6:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8013f9:	83 ec 04             	sub    $0x4,%esp
  8013fc:	68 7b 25 80 00       	push   $0x80257b
  801401:	6a 2f                	push   $0x2f
  801403:	68 6f 25 80 00       	push   $0x80256f
  801408:	e8 70 08 00 00       	call   801c7d <_panic>

0080140d <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  80140d:	55                   	push   %ebp
  80140e:	89 e5                	mov    %esp,%ebp
  801410:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801413:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  80141a:	8b 55 08             	mov    0x8(%ebp),%edx
  80141d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801420:	01 d0                	add    %edx,%eax
  801422:	48                   	dec    %eax
  801423:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801426:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801429:	ba 00 00 00 00       	mov    $0x0,%edx
  80142e:	f7 75 ec             	divl   -0x14(%ebp)
  801431:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801434:	29 d0                	sub    %edx,%eax
  801436:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	c1 e8 0c             	shr    $0xc,%eax
  80143f:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801442:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801449:	e9 c8 00 00 00       	jmp    801516 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  80144e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801455:	eb 27                	jmp    80147e <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801457:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80145a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80145d:	01 c2                	add    %eax,%edx
  80145f:	89 d0                	mov    %edx,%eax
  801461:	01 c0                	add    %eax,%eax
  801463:	01 d0                	add    %edx,%eax
  801465:	c1 e0 02             	shl    $0x2,%eax
  801468:	05 48 30 80 00       	add    $0x803048,%eax
  80146d:	8b 00                	mov    (%eax),%eax
  80146f:	85 c0                	test   %eax,%eax
  801471:	74 08                	je     80147b <malloc+0x6e>
            	i += j;
  801473:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801476:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801479:	eb 0b                	jmp    801486 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  80147b:	ff 45 f0             	incl   -0x10(%ebp)
  80147e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801481:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801484:	72 d1                	jb     801457 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801486:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801489:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80148c:	0f 85 81 00 00 00    	jne    801513 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801492:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801495:	05 00 00 08 00       	add    $0x80000,%eax
  80149a:	c1 e0 0c             	shl    $0xc,%eax
  80149d:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8014a0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8014a7:	eb 1f                	jmp    8014c8 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8014a9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8014ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014af:	01 c2                	add    %eax,%edx
  8014b1:	89 d0                	mov    %edx,%eax
  8014b3:	01 c0                	add    %eax,%eax
  8014b5:	01 d0                	add    %edx,%eax
  8014b7:	c1 e0 02             	shl    $0x2,%eax
  8014ba:	05 48 30 80 00       	add    $0x803048,%eax
  8014bf:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8014c5:	ff 45 f0             	incl   -0x10(%ebp)
  8014c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014cb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8014ce:	72 d9                	jb     8014a9 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  8014d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014d3:	89 d0                	mov    %edx,%eax
  8014d5:	01 c0                	add    %eax,%eax
  8014d7:	01 d0                	add    %edx,%eax
  8014d9:	c1 e0 02             	shl    $0x2,%eax
  8014dc:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  8014e2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8014e5:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8014e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8014ea:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8014ed:	89 c8                	mov    %ecx,%eax
  8014ef:	01 c0                	add    %eax,%eax
  8014f1:	01 c8                	add    %ecx,%eax
  8014f3:	c1 e0 02             	shl    $0x2,%eax
  8014f6:	05 44 30 80 00       	add    $0x803044,%eax
  8014fb:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8014fd:	83 ec 08             	sub    $0x8,%esp
  801500:	ff 75 08             	pushl  0x8(%ebp)
  801503:	ff 75 e0             	pushl  -0x20(%ebp)
  801506:	e8 2b 03 00 00       	call   801836 <sys_allocateMem>
  80150b:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  80150e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801511:	eb 19                	jmp    80152c <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801513:	ff 45 f4             	incl   -0xc(%ebp)
  801516:	a1 04 30 80 00       	mov    0x803004,%eax
  80151b:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80151e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801521:	0f 83 27 ff ff ff    	jae    80144e <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801527:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80152c:	c9                   	leave  
  80152d:	c3                   	ret    

0080152e <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80152e:	55                   	push   %ebp
  80152f:	89 e5                	mov    %esp,%ebp
  801531:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801534:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801538:	0f 84 e5 00 00 00    	je     801623 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  80153e:	8b 45 08             	mov    0x8(%ebp),%eax
  801541:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801544:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801547:	05 00 00 00 80       	add    $0x80000000,%eax
  80154c:	c1 e8 0c             	shr    $0xc,%eax
  80154f:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801552:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801555:	89 d0                	mov    %edx,%eax
  801557:	01 c0                	add    %eax,%eax
  801559:	01 d0                	add    %edx,%eax
  80155b:	c1 e0 02             	shl    $0x2,%eax
  80155e:	05 40 30 80 00       	add    $0x803040,%eax
  801563:	8b 00                	mov    (%eax),%eax
  801565:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801568:	0f 85 b8 00 00 00    	jne    801626 <free+0xf8>
  80156e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801571:	89 d0                	mov    %edx,%eax
  801573:	01 c0                	add    %eax,%eax
  801575:	01 d0                	add    %edx,%eax
  801577:	c1 e0 02             	shl    $0x2,%eax
  80157a:	05 48 30 80 00       	add    $0x803048,%eax
  80157f:	8b 00                	mov    (%eax),%eax
  801581:	85 c0                	test   %eax,%eax
  801583:	0f 84 9d 00 00 00    	je     801626 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801589:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80158c:	89 d0                	mov    %edx,%eax
  80158e:	01 c0                	add    %eax,%eax
  801590:	01 d0                	add    %edx,%eax
  801592:	c1 e0 02             	shl    $0x2,%eax
  801595:	05 44 30 80 00       	add    $0x803044,%eax
  80159a:	8b 00                	mov    (%eax),%eax
  80159c:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  80159f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8015a2:	c1 e0 0c             	shl    $0xc,%eax
  8015a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  8015a8:	83 ec 08             	sub    $0x8,%esp
  8015ab:	ff 75 e4             	pushl  -0x1c(%ebp)
  8015ae:	ff 75 f0             	pushl  -0x10(%ebp)
  8015b1:	e8 64 02 00 00       	call   80181a <sys_freeMem>
  8015b6:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8015b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8015c0:	eb 57                	jmp    801619 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8015c2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8015c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015c8:	01 c2                	add    %eax,%edx
  8015ca:	89 d0                	mov    %edx,%eax
  8015cc:	01 c0                	add    %eax,%eax
  8015ce:	01 d0                	add    %edx,%eax
  8015d0:	c1 e0 02             	shl    $0x2,%eax
  8015d3:	05 48 30 80 00       	add    $0x803048,%eax
  8015d8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  8015de:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8015e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015e4:	01 c2                	add    %eax,%edx
  8015e6:	89 d0                	mov    %edx,%eax
  8015e8:	01 c0                	add    %eax,%eax
  8015ea:	01 d0                	add    %edx,%eax
  8015ec:	c1 e0 02             	shl    $0x2,%eax
  8015ef:	05 40 30 80 00       	add    $0x803040,%eax
  8015f4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8015fa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8015fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801600:	01 c2                	add    %eax,%edx
  801602:	89 d0                	mov    %edx,%eax
  801604:	01 c0                	add    %eax,%eax
  801606:	01 d0                	add    %edx,%eax
  801608:	c1 e0 02             	shl    $0x2,%eax
  80160b:	05 44 30 80 00       	add    $0x803044,%eax
  801610:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801616:	ff 45 f4             	incl   -0xc(%ebp)
  801619:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80161c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80161f:	7c a1                	jl     8015c2 <free+0x94>
  801621:	eb 04                	jmp    801627 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801623:	90                   	nop
  801624:	eb 01                	jmp    801627 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801626:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801627:	c9                   	leave  
  801628:	c3                   	ret    

00801629 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801629:	55                   	push   %ebp
  80162a:	89 e5                	mov    %esp,%ebp
  80162c:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  80162f:	83 ec 04             	sub    $0x4,%esp
  801632:	68 98 25 80 00       	push   $0x802598
  801637:	68 ae 00 00 00       	push   $0xae
  80163c:	68 6f 25 80 00       	push   $0x80256f
  801641:	e8 37 06 00 00       	call   801c7d <_panic>

00801646 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
  801649:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  80164c:	83 ec 04             	sub    $0x4,%esp
  80164f:	68 b8 25 80 00       	push   $0x8025b8
  801654:	68 ca 00 00 00       	push   $0xca
  801659:	68 6f 25 80 00       	push   $0x80256f
  80165e:	e8 1a 06 00 00       	call   801c7d <_panic>

00801663 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801663:	55                   	push   %ebp
  801664:	89 e5                	mov    %esp,%ebp
  801666:	57                   	push   %edi
  801667:	56                   	push   %esi
  801668:	53                   	push   %ebx
  801669:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801672:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801675:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801678:	8b 7d 18             	mov    0x18(%ebp),%edi
  80167b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80167e:	cd 30                	int    $0x30
  801680:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801683:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801686:	83 c4 10             	add    $0x10,%esp
  801689:	5b                   	pop    %ebx
  80168a:	5e                   	pop    %esi
  80168b:	5f                   	pop    %edi
  80168c:	5d                   	pop    %ebp
  80168d:	c3                   	ret    

0080168e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80168e:	55                   	push   %ebp
  80168f:	89 e5                	mov    %esp,%ebp
  801691:	83 ec 04             	sub    $0x4,%esp
  801694:	8b 45 10             	mov    0x10(%ebp),%eax
  801697:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80169a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	52                   	push   %edx
  8016a6:	ff 75 0c             	pushl  0xc(%ebp)
  8016a9:	50                   	push   %eax
  8016aa:	6a 00                	push   $0x0
  8016ac:	e8 b2 ff ff ff       	call   801663 <syscall>
  8016b1:	83 c4 18             	add    $0x18,%esp
}
  8016b4:	90                   	nop
  8016b5:	c9                   	leave  
  8016b6:	c3                   	ret    

008016b7 <sys_cgetc>:

int
sys_cgetc(void)
{
  8016b7:	55                   	push   %ebp
  8016b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 01                	push   $0x1
  8016c6:	e8 98 ff ff ff       	call   801663 <syscall>
  8016cb:	83 c4 18             	add    $0x18,%esp
}
  8016ce:	c9                   	leave  
  8016cf:	c3                   	ret    

008016d0 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8016d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	50                   	push   %eax
  8016df:	6a 05                	push   $0x5
  8016e1:	e8 7d ff ff ff       	call   801663 <syscall>
  8016e6:	83 c4 18             	add    $0x18,%esp
}
  8016e9:	c9                   	leave  
  8016ea:	c3                   	ret    

008016eb <sys_getenvid>:

int32 sys_getenvid(void)
{
  8016eb:	55                   	push   %ebp
  8016ec:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 02                	push   $0x2
  8016fa:	e8 64 ff ff ff       	call   801663 <syscall>
  8016ff:	83 c4 18             	add    $0x18,%esp
}
  801702:	c9                   	leave  
  801703:	c3                   	ret    

00801704 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801704:	55                   	push   %ebp
  801705:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801707:	6a 00                	push   $0x0
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 03                	push   $0x3
  801713:	e8 4b ff ff ff       	call   801663 <syscall>
  801718:	83 c4 18             	add    $0x18,%esp
}
  80171b:	c9                   	leave  
  80171c:	c3                   	ret    

0080171d <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80171d:	55                   	push   %ebp
  80171e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 04                	push   $0x4
  80172c:	e8 32 ff ff ff       	call   801663 <syscall>
  801731:	83 c4 18             	add    $0x18,%esp
}
  801734:	c9                   	leave  
  801735:	c3                   	ret    

00801736 <sys_env_exit>:


void sys_env_exit(void)
{
  801736:	55                   	push   %ebp
  801737:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	6a 06                	push   $0x6
  801745:	e8 19 ff ff ff       	call   801663 <syscall>
  80174a:	83 c4 18             	add    $0x18,%esp
}
  80174d:	90                   	nop
  80174e:	c9                   	leave  
  80174f:	c3                   	ret    

00801750 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801750:	55                   	push   %ebp
  801751:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801753:	8b 55 0c             	mov    0xc(%ebp),%edx
  801756:	8b 45 08             	mov    0x8(%ebp),%eax
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	52                   	push   %edx
  801760:	50                   	push   %eax
  801761:	6a 07                	push   $0x7
  801763:	e8 fb fe ff ff       	call   801663 <syscall>
  801768:	83 c4 18             	add    $0x18,%esp
}
  80176b:	c9                   	leave  
  80176c:	c3                   	ret    

0080176d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80176d:	55                   	push   %ebp
  80176e:	89 e5                	mov    %esp,%ebp
  801770:	56                   	push   %esi
  801771:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801772:	8b 75 18             	mov    0x18(%ebp),%esi
  801775:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801778:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80177b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177e:	8b 45 08             	mov    0x8(%ebp),%eax
  801781:	56                   	push   %esi
  801782:	53                   	push   %ebx
  801783:	51                   	push   %ecx
  801784:	52                   	push   %edx
  801785:	50                   	push   %eax
  801786:	6a 08                	push   $0x8
  801788:	e8 d6 fe ff ff       	call   801663 <syscall>
  80178d:	83 c4 18             	add    $0x18,%esp
}
  801790:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801793:	5b                   	pop    %ebx
  801794:	5e                   	pop    %esi
  801795:	5d                   	pop    %ebp
  801796:	c3                   	ret    

00801797 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801797:	55                   	push   %ebp
  801798:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80179a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80179d:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	52                   	push   %edx
  8017a7:	50                   	push   %eax
  8017a8:	6a 09                	push   $0x9
  8017aa:	e8 b4 fe ff ff       	call   801663 <syscall>
  8017af:	83 c4 18             	add    $0x18,%esp
}
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	ff 75 0c             	pushl  0xc(%ebp)
  8017c0:	ff 75 08             	pushl  0x8(%ebp)
  8017c3:	6a 0a                	push   $0xa
  8017c5:	e8 99 fe ff ff       	call   801663 <syscall>
  8017ca:	83 c4 18             	add    $0x18,%esp
}
  8017cd:	c9                   	leave  
  8017ce:	c3                   	ret    

008017cf <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017cf:	55                   	push   %ebp
  8017d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 0b                	push   $0xb
  8017de:	e8 80 fe ff ff       	call   801663 <syscall>
  8017e3:	83 c4 18             	add    $0x18,%esp
}
  8017e6:	c9                   	leave  
  8017e7:	c3                   	ret    

008017e8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8017e8:	55                   	push   %ebp
  8017e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 0c                	push   $0xc
  8017f7:	e8 67 fe ff ff       	call   801663 <syscall>
  8017fc:	83 c4 18             	add    $0x18,%esp
}
  8017ff:	c9                   	leave  
  801800:	c3                   	ret    

00801801 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801801:	55                   	push   %ebp
  801802:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 0d                	push   $0xd
  801810:	e8 4e fe ff ff       	call   801663 <syscall>
  801815:	83 c4 18             	add    $0x18,%esp
}
  801818:	c9                   	leave  
  801819:	c3                   	ret    

0080181a <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80181a:	55                   	push   %ebp
  80181b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	ff 75 0c             	pushl  0xc(%ebp)
  801826:	ff 75 08             	pushl  0x8(%ebp)
  801829:	6a 11                	push   $0x11
  80182b:	e8 33 fe ff ff       	call   801663 <syscall>
  801830:	83 c4 18             	add    $0x18,%esp
	return;
  801833:	90                   	nop
}
  801834:	c9                   	leave  
  801835:	c3                   	ret    

00801836 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	ff 75 0c             	pushl  0xc(%ebp)
  801842:	ff 75 08             	pushl  0x8(%ebp)
  801845:	6a 12                	push   $0x12
  801847:	e8 17 fe ff ff       	call   801663 <syscall>
  80184c:	83 c4 18             	add    $0x18,%esp
	return ;
  80184f:	90                   	nop
}
  801850:	c9                   	leave  
  801851:	c3                   	ret    

00801852 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801852:	55                   	push   %ebp
  801853:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 0e                	push   $0xe
  801861:	e8 fd fd ff ff       	call   801663 <syscall>
  801866:	83 c4 18             	add    $0x18,%esp
}
  801869:	c9                   	leave  
  80186a:	c3                   	ret    

0080186b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80186b:	55                   	push   %ebp
  80186c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	ff 75 08             	pushl  0x8(%ebp)
  801879:	6a 0f                	push   $0xf
  80187b:	e8 e3 fd ff ff       	call   801663 <syscall>
  801880:	83 c4 18             	add    $0x18,%esp
}
  801883:	c9                   	leave  
  801884:	c3                   	ret    

00801885 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 10                	push   $0x10
  801894:	e8 ca fd ff ff       	call   801663 <syscall>
  801899:	83 c4 18             	add    $0x18,%esp
}
  80189c:	90                   	nop
  80189d:	c9                   	leave  
  80189e:	c3                   	ret    

0080189f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80189f:	55                   	push   %ebp
  8018a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 14                	push   $0x14
  8018ae:	e8 b0 fd ff ff       	call   801663 <syscall>
  8018b3:	83 c4 18             	add    $0x18,%esp
}
  8018b6:	90                   	nop
  8018b7:	c9                   	leave  
  8018b8:	c3                   	ret    

008018b9 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8018b9:	55                   	push   %ebp
  8018ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 15                	push   $0x15
  8018c8:	e8 96 fd ff ff       	call   801663 <syscall>
  8018cd:	83 c4 18             	add    $0x18,%esp
}
  8018d0:	90                   	nop
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <sys_cputc>:


void
sys_cputc(const char c)
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
  8018d6:	83 ec 04             	sub    $0x4,%esp
  8018d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8018df:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 00                	push   $0x0
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	50                   	push   %eax
  8018ec:	6a 16                	push   $0x16
  8018ee:	e8 70 fd ff ff       	call   801663 <syscall>
  8018f3:	83 c4 18             	add    $0x18,%esp
}
  8018f6:	90                   	nop
  8018f7:	c9                   	leave  
  8018f8:	c3                   	ret    

008018f9 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8018f9:	55                   	push   %ebp
  8018fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	6a 17                	push   $0x17
  801908:	e8 56 fd ff ff       	call   801663 <syscall>
  80190d:	83 c4 18             	add    $0x18,%esp
}
  801910:	90                   	nop
  801911:	c9                   	leave  
  801912:	c3                   	ret    

00801913 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801913:	55                   	push   %ebp
  801914:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801916:	8b 45 08             	mov    0x8(%ebp),%eax
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	ff 75 0c             	pushl  0xc(%ebp)
  801922:	50                   	push   %eax
  801923:	6a 18                	push   $0x18
  801925:	e8 39 fd ff ff       	call   801663 <syscall>
  80192a:	83 c4 18             	add    $0x18,%esp
}
  80192d:	c9                   	leave  
  80192e:	c3                   	ret    

0080192f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801932:	8b 55 0c             	mov    0xc(%ebp),%edx
  801935:	8b 45 08             	mov    0x8(%ebp),%eax
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	52                   	push   %edx
  80193f:	50                   	push   %eax
  801940:	6a 1b                	push   $0x1b
  801942:	e8 1c fd ff ff       	call   801663 <syscall>
  801947:	83 c4 18             	add    $0x18,%esp
}
  80194a:	c9                   	leave  
  80194b:	c3                   	ret    

0080194c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80194c:	55                   	push   %ebp
  80194d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80194f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801952:	8b 45 08             	mov    0x8(%ebp),%eax
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	52                   	push   %edx
  80195c:	50                   	push   %eax
  80195d:	6a 19                	push   $0x19
  80195f:	e8 ff fc ff ff       	call   801663 <syscall>
  801964:	83 c4 18             	add    $0x18,%esp
}
  801967:	90                   	nop
  801968:	c9                   	leave  
  801969:	c3                   	ret    

0080196a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80196a:	55                   	push   %ebp
  80196b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80196d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801970:	8b 45 08             	mov    0x8(%ebp),%eax
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	52                   	push   %edx
  80197a:	50                   	push   %eax
  80197b:	6a 1a                	push   $0x1a
  80197d:	e8 e1 fc ff ff       	call   801663 <syscall>
  801982:	83 c4 18             	add    $0x18,%esp
}
  801985:	90                   	nop
  801986:	c9                   	leave  
  801987:	c3                   	ret    

00801988 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801988:	55                   	push   %ebp
  801989:	89 e5                	mov    %esp,%ebp
  80198b:	83 ec 04             	sub    $0x4,%esp
  80198e:	8b 45 10             	mov    0x10(%ebp),%eax
  801991:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801994:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801997:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80199b:	8b 45 08             	mov    0x8(%ebp),%eax
  80199e:	6a 00                	push   $0x0
  8019a0:	51                   	push   %ecx
  8019a1:	52                   	push   %edx
  8019a2:	ff 75 0c             	pushl  0xc(%ebp)
  8019a5:	50                   	push   %eax
  8019a6:	6a 1c                	push   $0x1c
  8019a8:	e8 b6 fc ff ff       	call   801663 <syscall>
  8019ad:	83 c4 18             	add    $0x18,%esp
}
  8019b0:	c9                   	leave  
  8019b1:	c3                   	ret    

008019b2 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8019b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	52                   	push   %edx
  8019c2:	50                   	push   %eax
  8019c3:	6a 1d                	push   $0x1d
  8019c5:	e8 99 fc ff ff       	call   801663 <syscall>
  8019ca:	83 c4 18             	add    $0x18,%esp
}
  8019cd:	c9                   	leave  
  8019ce:	c3                   	ret    

008019cf <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8019cf:	55                   	push   %ebp
  8019d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8019d2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	51                   	push   %ecx
  8019e0:	52                   	push   %edx
  8019e1:	50                   	push   %eax
  8019e2:	6a 1e                	push   $0x1e
  8019e4:	e8 7a fc ff ff       	call   801663 <syscall>
  8019e9:	83 c4 18             	add    $0x18,%esp
}
  8019ec:	c9                   	leave  
  8019ed:	c3                   	ret    

008019ee <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8019ee:	55                   	push   %ebp
  8019ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8019f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	52                   	push   %edx
  8019fe:	50                   	push   %eax
  8019ff:	6a 1f                	push   $0x1f
  801a01:	e8 5d fc ff ff       	call   801663 <syscall>
  801a06:	83 c4 18             	add    $0x18,%esp
}
  801a09:	c9                   	leave  
  801a0a:	c3                   	ret    

00801a0b <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a0b:	55                   	push   %ebp
  801a0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a0e:	6a 00                	push   $0x0
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 20                	push   $0x20
  801a1a:	e8 44 fc ff ff       	call   801663 <syscall>
  801a1f:	83 c4 18             	add    $0x18,%esp
}
  801a22:	c9                   	leave  
  801a23:	c3                   	ret    

00801a24 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801a24:	55                   	push   %ebp
  801a25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801a27:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	ff 75 10             	pushl  0x10(%ebp)
  801a31:	ff 75 0c             	pushl  0xc(%ebp)
  801a34:	50                   	push   %eax
  801a35:	6a 21                	push   $0x21
  801a37:	e8 27 fc ff ff       	call   801663 <syscall>
  801a3c:	83 c4 18             	add    $0x18,%esp
}
  801a3f:	c9                   	leave  
  801a40:	c3                   	ret    

00801a41 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801a41:	55                   	push   %ebp
  801a42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801a44:	8b 45 08             	mov    0x8(%ebp),%eax
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 00                	push   $0x0
  801a4f:	50                   	push   %eax
  801a50:	6a 22                	push   $0x22
  801a52:	e8 0c fc ff ff       	call   801663 <syscall>
  801a57:	83 c4 18             	add    $0x18,%esp
}
  801a5a:	90                   	nop
  801a5b:	c9                   	leave  
  801a5c:	c3                   	ret    

00801a5d <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801a5d:	55                   	push   %ebp
  801a5e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801a60:	8b 45 08             	mov    0x8(%ebp),%eax
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	50                   	push   %eax
  801a6c:	6a 23                	push   $0x23
  801a6e:	e8 f0 fb ff ff       	call   801663 <syscall>
  801a73:	83 c4 18             	add    $0x18,%esp
}
  801a76:	90                   	nop
  801a77:	c9                   	leave  
  801a78:	c3                   	ret    

00801a79 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801a79:	55                   	push   %ebp
  801a7a:	89 e5                	mov    %esp,%ebp
  801a7c:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801a7f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a82:	8d 50 04             	lea    0x4(%eax),%edx
  801a85:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 00                	push   $0x0
  801a8c:	6a 00                	push   $0x0
  801a8e:	52                   	push   %edx
  801a8f:	50                   	push   %eax
  801a90:	6a 24                	push   $0x24
  801a92:	e8 cc fb ff ff       	call   801663 <syscall>
  801a97:	83 c4 18             	add    $0x18,%esp
	return result;
  801a9a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a9d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801aa0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801aa3:	89 01                	mov    %eax,(%ecx)
  801aa5:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  801aab:	c9                   	leave  
  801aac:	c2 04 00             	ret    $0x4

00801aaf <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801aaf:	55                   	push   %ebp
  801ab0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	ff 75 10             	pushl  0x10(%ebp)
  801ab9:	ff 75 0c             	pushl  0xc(%ebp)
  801abc:	ff 75 08             	pushl  0x8(%ebp)
  801abf:	6a 13                	push   $0x13
  801ac1:	e8 9d fb ff ff       	call   801663 <syscall>
  801ac6:	83 c4 18             	add    $0x18,%esp
	return ;
  801ac9:	90                   	nop
}
  801aca:	c9                   	leave  
  801acb:	c3                   	ret    

00801acc <sys_rcr2>:
uint32 sys_rcr2()
{
  801acc:	55                   	push   %ebp
  801acd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 25                	push   $0x25
  801adb:	e8 83 fb ff ff       	call   801663 <syscall>
  801ae0:	83 c4 18             	add    $0x18,%esp
}
  801ae3:	c9                   	leave  
  801ae4:	c3                   	ret    

00801ae5 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ae5:	55                   	push   %ebp
  801ae6:	89 e5                	mov    %esp,%ebp
  801ae8:	83 ec 04             	sub    $0x4,%esp
  801aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  801aee:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801af1:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801af5:	6a 00                	push   $0x0
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	50                   	push   %eax
  801afe:	6a 26                	push   $0x26
  801b00:	e8 5e fb ff ff       	call   801663 <syscall>
  801b05:	83 c4 18             	add    $0x18,%esp
	return ;
  801b08:	90                   	nop
}
  801b09:	c9                   	leave  
  801b0a:	c3                   	ret    

00801b0b <rsttst>:
void rsttst()
{
  801b0b:	55                   	push   %ebp
  801b0c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 28                	push   $0x28
  801b1a:	e8 44 fb ff ff       	call   801663 <syscall>
  801b1f:	83 c4 18             	add    $0x18,%esp
	return ;
  801b22:	90                   	nop
}
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
  801b28:	83 ec 04             	sub    $0x4,%esp
  801b2b:	8b 45 14             	mov    0x14(%ebp),%eax
  801b2e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801b31:	8b 55 18             	mov    0x18(%ebp),%edx
  801b34:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b38:	52                   	push   %edx
  801b39:	50                   	push   %eax
  801b3a:	ff 75 10             	pushl  0x10(%ebp)
  801b3d:	ff 75 0c             	pushl  0xc(%ebp)
  801b40:	ff 75 08             	pushl  0x8(%ebp)
  801b43:	6a 27                	push   $0x27
  801b45:	e8 19 fb ff ff       	call   801663 <syscall>
  801b4a:	83 c4 18             	add    $0x18,%esp
	return ;
  801b4d:	90                   	nop
}
  801b4e:	c9                   	leave  
  801b4f:	c3                   	ret    

00801b50 <chktst>:
void chktst(uint32 n)
{
  801b50:	55                   	push   %ebp
  801b51:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801b53:	6a 00                	push   $0x0
  801b55:	6a 00                	push   $0x0
  801b57:	6a 00                	push   $0x0
  801b59:	6a 00                	push   $0x0
  801b5b:	ff 75 08             	pushl  0x8(%ebp)
  801b5e:	6a 29                	push   $0x29
  801b60:	e8 fe fa ff ff       	call   801663 <syscall>
  801b65:	83 c4 18             	add    $0x18,%esp
	return ;
  801b68:	90                   	nop
}
  801b69:	c9                   	leave  
  801b6a:	c3                   	ret    

00801b6b <inctst>:

void inctst()
{
  801b6b:	55                   	push   %ebp
  801b6c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801b6e:	6a 00                	push   $0x0
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 2a                	push   $0x2a
  801b7a:	e8 e4 fa ff ff       	call   801663 <syscall>
  801b7f:	83 c4 18             	add    $0x18,%esp
	return ;
  801b82:	90                   	nop
}
  801b83:	c9                   	leave  
  801b84:	c3                   	ret    

00801b85 <gettst>:
uint32 gettst()
{
  801b85:	55                   	push   %ebp
  801b86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 00                	push   $0x0
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 00                	push   $0x0
  801b92:	6a 2b                	push   $0x2b
  801b94:	e8 ca fa ff ff       	call   801663 <syscall>
  801b99:	83 c4 18             	add    $0x18,%esp
}
  801b9c:	c9                   	leave  
  801b9d:	c3                   	ret    

00801b9e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b9e:	55                   	push   %ebp
  801b9f:	89 e5                	mov    %esp,%ebp
  801ba1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	6a 2c                	push   $0x2c
  801bb0:	e8 ae fa ff ff       	call   801663 <syscall>
  801bb5:	83 c4 18             	add    $0x18,%esp
  801bb8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801bbb:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801bbf:	75 07                	jne    801bc8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801bc1:	b8 01 00 00 00       	mov    $0x1,%eax
  801bc6:	eb 05                	jmp    801bcd <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801bc8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bcd:	c9                   	leave  
  801bce:	c3                   	ret    

00801bcf <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801bcf:	55                   	push   %ebp
  801bd0:	89 e5                	mov    %esp,%ebp
  801bd2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bd5:	6a 00                	push   $0x0
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 2c                	push   $0x2c
  801be1:	e8 7d fa ff ff       	call   801663 <syscall>
  801be6:	83 c4 18             	add    $0x18,%esp
  801be9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801bec:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801bf0:	75 07                	jne    801bf9 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801bf2:	b8 01 00 00 00       	mov    $0x1,%eax
  801bf7:	eb 05                	jmp    801bfe <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801bf9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bfe:	c9                   	leave  
  801bff:	c3                   	ret    

00801c00 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c00:	55                   	push   %ebp
  801c01:	89 e5                	mov    %esp,%ebp
  801c03:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c06:	6a 00                	push   $0x0
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 2c                	push   $0x2c
  801c12:	e8 4c fa ff ff       	call   801663 <syscall>
  801c17:	83 c4 18             	add    $0x18,%esp
  801c1a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801c1d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801c21:	75 07                	jne    801c2a <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801c23:	b8 01 00 00 00       	mov    $0x1,%eax
  801c28:	eb 05                	jmp    801c2f <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801c2a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c2f:	c9                   	leave  
  801c30:	c3                   	ret    

00801c31 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801c31:	55                   	push   %ebp
  801c32:	89 e5                	mov    %esp,%ebp
  801c34:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 2c                	push   $0x2c
  801c43:	e8 1b fa ff ff       	call   801663 <syscall>
  801c48:	83 c4 18             	add    $0x18,%esp
  801c4b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801c4e:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801c52:	75 07                	jne    801c5b <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801c54:	b8 01 00 00 00       	mov    $0x1,%eax
  801c59:	eb 05                	jmp    801c60 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801c5b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c60:	c9                   	leave  
  801c61:	c3                   	ret    

00801c62 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801c62:	55                   	push   %ebp
  801c63:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	ff 75 08             	pushl  0x8(%ebp)
  801c70:	6a 2d                	push   $0x2d
  801c72:	e8 ec f9 ff ff       	call   801663 <syscall>
  801c77:	83 c4 18             	add    $0x18,%esp
	return ;
  801c7a:	90                   	nop
}
  801c7b:	c9                   	leave  
  801c7c:	c3                   	ret    

00801c7d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801c7d:	55                   	push   %ebp
  801c7e:	89 e5                	mov    %esp,%ebp
  801c80:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801c83:	8d 45 10             	lea    0x10(%ebp),%eax
  801c86:	83 c0 04             	add    $0x4,%eax
  801c89:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801c8c:	a1 40 30 98 00       	mov    0x983040,%eax
  801c91:	85 c0                	test   %eax,%eax
  801c93:	74 16                	je     801cab <_panic+0x2e>
		cprintf("%s: ", argv0);
  801c95:	a1 40 30 98 00       	mov    0x983040,%eax
  801c9a:	83 ec 08             	sub    $0x8,%esp
  801c9d:	50                   	push   %eax
  801c9e:	68 dc 25 80 00       	push   $0x8025dc
  801ca3:	e8 a1 e9 ff ff       	call   800649 <cprintf>
  801ca8:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801cab:	a1 00 30 80 00       	mov    0x803000,%eax
  801cb0:	ff 75 0c             	pushl  0xc(%ebp)
  801cb3:	ff 75 08             	pushl  0x8(%ebp)
  801cb6:	50                   	push   %eax
  801cb7:	68 e1 25 80 00       	push   $0x8025e1
  801cbc:	e8 88 e9 ff ff       	call   800649 <cprintf>
  801cc1:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801cc4:	8b 45 10             	mov    0x10(%ebp),%eax
  801cc7:	83 ec 08             	sub    $0x8,%esp
  801cca:	ff 75 f4             	pushl  -0xc(%ebp)
  801ccd:	50                   	push   %eax
  801cce:	e8 0b e9 ff ff       	call   8005de <vcprintf>
  801cd3:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801cd6:	83 ec 08             	sub    $0x8,%esp
  801cd9:	6a 00                	push   $0x0
  801cdb:	68 fd 25 80 00       	push   $0x8025fd
  801ce0:	e8 f9 e8 ff ff       	call   8005de <vcprintf>
  801ce5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801ce8:	e8 7a e8 ff ff       	call   800567 <exit>

	// should not return here
	while (1) ;
  801ced:	eb fe                	jmp    801ced <_panic+0x70>

00801cef <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801cef:	55                   	push   %ebp
  801cf0:	89 e5                	mov    %esp,%ebp
  801cf2:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801cf5:	a1 20 30 80 00       	mov    0x803020,%eax
  801cfa:	8b 50 74             	mov    0x74(%eax),%edx
  801cfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d00:	39 c2                	cmp    %eax,%edx
  801d02:	74 14                	je     801d18 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801d04:	83 ec 04             	sub    $0x4,%esp
  801d07:	68 00 26 80 00       	push   $0x802600
  801d0c:	6a 26                	push   $0x26
  801d0e:	68 4c 26 80 00       	push   $0x80264c
  801d13:	e8 65 ff ff ff       	call   801c7d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801d18:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801d1f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801d26:	e9 c2 00 00 00       	jmp    801ded <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801d2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d2e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d35:	8b 45 08             	mov    0x8(%ebp),%eax
  801d38:	01 d0                	add    %edx,%eax
  801d3a:	8b 00                	mov    (%eax),%eax
  801d3c:	85 c0                	test   %eax,%eax
  801d3e:	75 08                	jne    801d48 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801d40:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801d43:	e9 a2 00 00 00       	jmp    801dea <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801d48:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d4f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801d56:	eb 69                	jmp    801dc1 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801d58:	a1 20 30 80 00       	mov    0x803020,%eax
  801d5d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801d63:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801d66:	89 d0                	mov    %edx,%eax
  801d68:	01 c0                	add    %eax,%eax
  801d6a:	01 d0                	add    %edx,%eax
  801d6c:	c1 e0 02             	shl    $0x2,%eax
  801d6f:	01 c8                	add    %ecx,%eax
  801d71:	8a 40 04             	mov    0x4(%eax),%al
  801d74:	84 c0                	test   %al,%al
  801d76:	75 46                	jne    801dbe <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801d78:	a1 20 30 80 00       	mov    0x803020,%eax
  801d7d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801d83:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801d86:	89 d0                	mov    %edx,%eax
  801d88:	01 c0                	add    %eax,%eax
  801d8a:	01 d0                	add    %edx,%eax
  801d8c:	c1 e0 02             	shl    $0x2,%eax
  801d8f:	01 c8                	add    %ecx,%eax
  801d91:	8b 00                	mov    (%eax),%eax
  801d93:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801d96:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801d99:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801d9e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801da0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801da3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801daa:	8b 45 08             	mov    0x8(%ebp),%eax
  801dad:	01 c8                	add    %ecx,%eax
  801daf:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801db1:	39 c2                	cmp    %eax,%edx
  801db3:	75 09                	jne    801dbe <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801db5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801dbc:	eb 12                	jmp    801dd0 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801dbe:	ff 45 e8             	incl   -0x18(%ebp)
  801dc1:	a1 20 30 80 00       	mov    0x803020,%eax
  801dc6:	8b 50 74             	mov    0x74(%eax),%edx
  801dc9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801dcc:	39 c2                	cmp    %eax,%edx
  801dce:	77 88                	ja     801d58 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801dd0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801dd4:	75 14                	jne    801dea <CheckWSWithoutLastIndex+0xfb>
			panic(
  801dd6:	83 ec 04             	sub    $0x4,%esp
  801dd9:	68 58 26 80 00       	push   $0x802658
  801dde:	6a 3a                	push   $0x3a
  801de0:	68 4c 26 80 00       	push   $0x80264c
  801de5:	e8 93 fe ff ff       	call   801c7d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801dea:	ff 45 f0             	incl   -0x10(%ebp)
  801ded:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801df0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801df3:	0f 8c 32 ff ff ff    	jl     801d2b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801df9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e00:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801e07:	eb 26                	jmp    801e2f <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801e09:	a1 20 30 80 00       	mov    0x803020,%eax
  801e0e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801e14:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801e17:	89 d0                	mov    %edx,%eax
  801e19:	01 c0                	add    %eax,%eax
  801e1b:	01 d0                	add    %edx,%eax
  801e1d:	c1 e0 02             	shl    $0x2,%eax
  801e20:	01 c8                	add    %ecx,%eax
  801e22:	8a 40 04             	mov    0x4(%eax),%al
  801e25:	3c 01                	cmp    $0x1,%al
  801e27:	75 03                	jne    801e2c <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801e29:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e2c:	ff 45 e0             	incl   -0x20(%ebp)
  801e2f:	a1 20 30 80 00       	mov    0x803020,%eax
  801e34:	8b 50 74             	mov    0x74(%eax),%edx
  801e37:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e3a:	39 c2                	cmp    %eax,%edx
  801e3c:	77 cb                	ja     801e09 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801e3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e41:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801e44:	74 14                	je     801e5a <CheckWSWithoutLastIndex+0x16b>
		panic(
  801e46:	83 ec 04             	sub    $0x4,%esp
  801e49:	68 ac 26 80 00       	push   $0x8026ac
  801e4e:	6a 44                	push   $0x44
  801e50:	68 4c 26 80 00       	push   $0x80264c
  801e55:	e8 23 fe ff ff       	call   801c7d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801e5a:	90                   	nop
  801e5b:	c9                   	leave  
  801e5c:	c3                   	ret    
  801e5d:	66 90                	xchg   %ax,%ax
  801e5f:	90                   	nop

00801e60 <__udivdi3>:
  801e60:	55                   	push   %ebp
  801e61:	57                   	push   %edi
  801e62:	56                   	push   %esi
  801e63:	53                   	push   %ebx
  801e64:	83 ec 1c             	sub    $0x1c,%esp
  801e67:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e6b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e6f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e73:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e77:	89 ca                	mov    %ecx,%edx
  801e79:	89 f8                	mov    %edi,%eax
  801e7b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e7f:	85 f6                	test   %esi,%esi
  801e81:	75 2d                	jne    801eb0 <__udivdi3+0x50>
  801e83:	39 cf                	cmp    %ecx,%edi
  801e85:	77 65                	ja     801eec <__udivdi3+0x8c>
  801e87:	89 fd                	mov    %edi,%ebp
  801e89:	85 ff                	test   %edi,%edi
  801e8b:	75 0b                	jne    801e98 <__udivdi3+0x38>
  801e8d:	b8 01 00 00 00       	mov    $0x1,%eax
  801e92:	31 d2                	xor    %edx,%edx
  801e94:	f7 f7                	div    %edi
  801e96:	89 c5                	mov    %eax,%ebp
  801e98:	31 d2                	xor    %edx,%edx
  801e9a:	89 c8                	mov    %ecx,%eax
  801e9c:	f7 f5                	div    %ebp
  801e9e:	89 c1                	mov    %eax,%ecx
  801ea0:	89 d8                	mov    %ebx,%eax
  801ea2:	f7 f5                	div    %ebp
  801ea4:	89 cf                	mov    %ecx,%edi
  801ea6:	89 fa                	mov    %edi,%edx
  801ea8:	83 c4 1c             	add    $0x1c,%esp
  801eab:	5b                   	pop    %ebx
  801eac:	5e                   	pop    %esi
  801ead:	5f                   	pop    %edi
  801eae:	5d                   	pop    %ebp
  801eaf:	c3                   	ret    
  801eb0:	39 ce                	cmp    %ecx,%esi
  801eb2:	77 28                	ja     801edc <__udivdi3+0x7c>
  801eb4:	0f bd fe             	bsr    %esi,%edi
  801eb7:	83 f7 1f             	xor    $0x1f,%edi
  801eba:	75 40                	jne    801efc <__udivdi3+0x9c>
  801ebc:	39 ce                	cmp    %ecx,%esi
  801ebe:	72 0a                	jb     801eca <__udivdi3+0x6a>
  801ec0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ec4:	0f 87 9e 00 00 00    	ja     801f68 <__udivdi3+0x108>
  801eca:	b8 01 00 00 00       	mov    $0x1,%eax
  801ecf:	89 fa                	mov    %edi,%edx
  801ed1:	83 c4 1c             	add    $0x1c,%esp
  801ed4:	5b                   	pop    %ebx
  801ed5:	5e                   	pop    %esi
  801ed6:	5f                   	pop    %edi
  801ed7:	5d                   	pop    %ebp
  801ed8:	c3                   	ret    
  801ed9:	8d 76 00             	lea    0x0(%esi),%esi
  801edc:	31 ff                	xor    %edi,%edi
  801ede:	31 c0                	xor    %eax,%eax
  801ee0:	89 fa                	mov    %edi,%edx
  801ee2:	83 c4 1c             	add    $0x1c,%esp
  801ee5:	5b                   	pop    %ebx
  801ee6:	5e                   	pop    %esi
  801ee7:	5f                   	pop    %edi
  801ee8:	5d                   	pop    %ebp
  801ee9:	c3                   	ret    
  801eea:	66 90                	xchg   %ax,%ax
  801eec:	89 d8                	mov    %ebx,%eax
  801eee:	f7 f7                	div    %edi
  801ef0:	31 ff                	xor    %edi,%edi
  801ef2:	89 fa                	mov    %edi,%edx
  801ef4:	83 c4 1c             	add    $0x1c,%esp
  801ef7:	5b                   	pop    %ebx
  801ef8:	5e                   	pop    %esi
  801ef9:	5f                   	pop    %edi
  801efa:	5d                   	pop    %ebp
  801efb:	c3                   	ret    
  801efc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f01:	89 eb                	mov    %ebp,%ebx
  801f03:	29 fb                	sub    %edi,%ebx
  801f05:	89 f9                	mov    %edi,%ecx
  801f07:	d3 e6                	shl    %cl,%esi
  801f09:	89 c5                	mov    %eax,%ebp
  801f0b:	88 d9                	mov    %bl,%cl
  801f0d:	d3 ed                	shr    %cl,%ebp
  801f0f:	89 e9                	mov    %ebp,%ecx
  801f11:	09 f1                	or     %esi,%ecx
  801f13:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f17:	89 f9                	mov    %edi,%ecx
  801f19:	d3 e0                	shl    %cl,%eax
  801f1b:	89 c5                	mov    %eax,%ebp
  801f1d:	89 d6                	mov    %edx,%esi
  801f1f:	88 d9                	mov    %bl,%cl
  801f21:	d3 ee                	shr    %cl,%esi
  801f23:	89 f9                	mov    %edi,%ecx
  801f25:	d3 e2                	shl    %cl,%edx
  801f27:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f2b:	88 d9                	mov    %bl,%cl
  801f2d:	d3 e8                	shr    %cl,%eax
  801f2f:	09 c2                	or     %eax,%edx
  801f31:	89 d0                	mov    %edx,%eax
  801f33:	89 f2                	mov    %esi,%edx
  801f35:	f7 74 24 0c          	divl   0xc(%esp)
  801f39:	89 d6                	mov    %edx,%esi
  801f3b:	89 c3                	mov    %eax,%ebx
  801f3d:	f7 e5                	mul    %ebp
  801f3f:	39 d6                	cmp    %edx,%esi
  801f41:	72 19                	jb     801f5c <__udivdi3+0xfc>
  801f43:	74 0b                	je     801f50 <__udivdi3+0xf0>
  801f45:	89 d8                	mov    %ebx,%eax
  801f47:	31 ff                	xor    %edi,%edi
  801f49:	e9 58 ff ff ff       	jmp    801ea6 <__udivdi3+0x46>
  801f4e:	66 90                	xchg   %ax,%ax
  801f50:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f54:	89 f9                	mov    %edi,%ecx
  801f56:	d3 e2                	shl    %cl,%edx
  801f58:	39 c2                	cmp    %eax,%edx
  801f5a:	73 e9                	jae    801f45 <__udivdi3+0xe5>
  801f5c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f5f:	31 ff                	xor    %edi,%edi
  801f61:	e9 40 ff ff ff       	jmp    801ea6 <__udivdi3+0x46>
  801f66:	66 90                	xchg   %ax,%ax
  801f68:	31 c0                	xor    %eax,%eax
  801f6a:	e9 37 ff ff ff       	jmp    801ea6 <__udivdi3+0x46>
  801f6f:	90                   	nop

00801f70 <__umoddi3>:
  801f70:	55                   	push   %ebp
  801f71:	57                   	push   %edi
  801f72:	56                   	push   %esi
  801f73:	53                   	push   %ebx
  801f74:	83 ec 1c             	sub    $0x1c,%esp
  801f77:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f7b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f7f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f83:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f87:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f8b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f8f:	89 f3                	mov    %esi,%ebx
  801f91:	89 fa                	mov    %edi,%edx
  801f93:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f97:	89 34 24             	mov    %esi,(%esp)
  801f9a:	85 c0                	test   %eax,%eax
  801f9c:	75 1a                	jne    801fb8 <__umoddi3+0x48>
  801f9e:	39 f7                	cmp    %esi,%edi
  801fa0:	0f 86 a2 00 00 00    	jbe    802048 <__umoddi3+0xd8>
  801fa6:	89 c8                	mov    %ecx,%eax
  801fa8:	89 f2                	mov    %esi,%edx
  801faa:	f7 f7                	div    %edi
  801fac:	89 d0                	mov    %edx,%eax
  801fae:	31 d2                	xor    %edx,%edx
  801fb0:	83 c4 1c             	add    $0x1c,%esp
  801fb3:	5b                   	pop    %ebx
  801fb4:	5e                   	pop    %esi
  801fb5:	5f                   	pop    %edi
  801fb6:	5d                   	pop    %ebp
  801fb7:	c3                   	ret    
  801fb8:	39 f0                	cmp    %esi,%eax
  801fba:	0f 87 ac 00 00 00    	ja     80206c <__umoddi3+0xfc>
  801fc0:	0f bd e8             	bsr    %eax,%ebp
  801fc3:	83 f5 1f             	xor    $0x1f,%ebp
  801fc6:	0f 84 ac 00 00 00    	je     802078 <__umoddi3+0x108>
  801fcc:	bf 20 00 00 00       	mov    $0x20,%edi
  801fd1:	29 ef                	sub    %ebp,%edi
  801fd3:	89 fe                	mov    %edi,%esi
  801fd5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801fd9:	89 e9                	mov    %ebp,%ecx
  801fdb:	d3 e0                	shl    %cl,%eax
  801fdd:	89 d7                	mov    %edx,%edi
  801fdf:	89 f1                	mov    %esi,%ecx
  801fe1:	d3 ef                	shr    %cl,%edi
  801fe3:	09 c7                	or     %eax,%edi
  801fe5:	89 e9                	mov    %ebp,%ecx
  801fe7:	d3 e2                	shl    %cl,%edx
  801fe9:	89 14 24             	mov    %edx,(%esp)
  801fec:	89 d8                	mov    %ebx,%eax
  801fee:	d3 e0                	shl    %cl,%eax
  801ff0:	89 c2                	mov    %eax,%edx
  801ff2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ff6:	d3 e0                	shl    %cl,%eax
  801ff8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ffc:	8b 44 24 08          	mov    0x8(%esp),%eax
  802000:	89 f1                	mov    %esi,%ecx
  802002:	d3 e8                	shr    %cl,%eax
  802004:	09 d0                	or     %edx,%eax
  802006:	d3 eb                	shr    %cl,%ebx
  802008:	89 da                	mov    %ebx,%edx
  80200a:	f7 f7                	div    %edi
  80200c:	89 d3                	mov    %edx,%ebx
  80200e:	f7 24 24             	mull   (%esp)
  802011:	89 c6                	mov    %eax,%esi
  802013:	89 d1                	mov    %edx,%ecx
  802015:	39 d3                	cmp    %edx,%ebx
  802017:	0f 82 87 00 00 00    	jb     8020a4 <__umoddi3+0x134>
  80201d:	0f 84 91 00 00 00    	je     8020b4 <__umoddi3+0x144>
  802023:	8b 54 24 04          	mov    0x4(%esp),%edx
  802027:	29 f2                	sub    %esi,%edx
  802029:	19 cb                	sbb    %ecx,%ebx
  80202b:	89 d8                	mov    %ebx,%eax
  80202d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802031:	d3 e0                	shl    %cl,%eax
  802033:	89 e9                	mov    %ebp,%ecx
  802035:	d3 ea                	shr    %cl,%edx
  802037:	09 d0                	or     %edx,%eax
  802039:	89 e9                	mov    %ebp,%ecx
  80203b:	d3 eb                	shr    %cl,%ebx
  80203d:	89 da                	mov    %ebx,%edx
  80203f:	83 c4 1c             	add    $0x1c,%esp
  802042:	5b                   	pop    %ebx
  802043:	5e                   	pop    %esi
  802044:	5f                   	pop    %edi
  802045:	5d                   	pop    %ebp
  802046:	c3                   	ret    
  802047:	90                   	nop
  802048:	89 fd                	mov    %edi,%ebp
  80204a:	85 ff                	test   %edi,%edi
  80204c:	75 0b                	jne    802059 <__umoddi3+0xe9>
  80204e:	b8 01 00 00 00       	mov    $0x1,%eax
  802053:	31 d2                	xor    %edx,%edx
  802055:	f7 f7                	div    %edi
  802057:	89 c5                	mov    %eax,%ebp
  802059:	89 f0                	mov    %esi,%eax
  80205b:	31 d2                	xor    %edx,%edx
  80205d:	f7 f5                	div    %ebp
  80205f:	89 c8                	mov    %ecx,%eax
  802061:	f7 f5                	div    %ebp
  802063:	89 d0                	mov    %edx,%eax
  802065:	e9 44 ff ff ff       	jmp    801fae <__umoddi3+0x3e>
  80206a:	66 90                	xchg   %ax,%ax
  80206c:	89 c8                	mov    %ecx,%eax
  80206e:	89 f2                	mov    %esi,%edx
  802070:	83 c4 1c             	add    $0x1c,%esp
  802073:	5b                   	pop    %ebx
  802074:	5e                   	pop    %esi
  802075:	5f                   	pop    %edi
  802076:	5d                   	pop    %ebp
  802077:	c3                   	ret    
  802078:	3b 04 24             	cmp    (%esp),%eax
  80207b:	72 06                	jb     802083 <__umoddi3+0x113>
  80207d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802081:	77 0f                	ja     802092 <__umoddi3+0x122>
  802083:	89 f2                	mov    %esi,%edx
  802085:	29 f9                	sub    %edi,%ecx
  802087:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80208b:	89 14 24             	mov    %edx,(%esp)
  80208e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802092:	8b 44 24 04          	mov    0x4(%esp),%eax
  802096:	8b 14 24             	mov    (%esp),%edx
  802099:	83 c4 1c             	add    $0x1c,%esp
  80209c:	5b                   	pop    %ebx
  80209d:	5e                   	pop    %esi
  80209e:	5f                   	pop    %edi
  80209f:	5d                   	pop    %ebp
  8020a0:	c3                   	ret    
  8020a1:	8d 76 00             	lea    0x0(%esi),%esi
  8020a4:	2b 04 24             	sub    (%esp),%eax
  8020a7:	19 fa                	sbb    %edi,%edx
  8020a9:	89 d1                	mov    %edx,%ecx
  8020ab:	89 c6                	mov    %eax,%esi
  8020ad:	e9 71 ff ff ff       	jmp    802023 <__umoddi3+0xb3>
  8020b2:	66 90                	xchg   %ax,%ax
  8020b4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8020b8:	72 ea                	jb     8020a4 <__umoddi3+0x134>
  8020ba:	89 d9                	mov    %ebx,%ecx
  8020bc:	e9 62 ff ff ff       	jmp    802023 <__umoddi3+0xb3>
