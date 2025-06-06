
obj/user/arrayOperations_stats:     file format elf32-i386


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
  800031:	e8 f7 04 00 00       	call   80052d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void ArrayStats(int *Elements, int NumOfElements, int *mean, int *var, int *min, int *max, int *med);
int KthElement(int *Elements, int NumOfElements, int k);
int QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex, int kIndex);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 58             	sub    $0x58,%esp
	int32 envID = sys_getenvid();
  80003e:	e8 62 17 00 00       	call   8017a5 <sys_getenvid>
  800043:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int32 parentenvID = sys_getparentenvid();
  800046:	e8 8c 17 00 00       	call   8017d7 <sys_getparentenvid>
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
  80005f:	68 80 21 80 00       	push   $0x802180
  800064:	ff 75 ec             	pushl  -0x14(%ebp)
  800067:	e8 41 14 00 00       	call   8014ad <sget>
  80006c:	83 c4 10             	add    $0x10,%esp
  80006f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	numOfElements = sget(parentenvID,"arrSize") ;
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 84 21 80 00       	push   $0x802184
  80007a:	ff 75 ec             	pushl  -0x14(%ebp)
  80007d:	e8 2b 14 00 00       	call   8014ad <sget>
  800082:	83 c4 10             	add    $0x10,%esp
  800085:	89 45 e8             	mov    %eax,-0x18(%ebp)

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800088:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	finishedCount = sget(parentenvID,"finishedCount") ;
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	68 8c 21 80 00       	push   $0x80218c
  800097:	ff 75 ec             	pushl  -0x14(%ebp)
  80009a:	e8 0e 14 00 00       	call   8014ad <sget>
  80009f:	83 c4 10             	add    $0x10,%esp
  8000a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int max ;
	int med ;

	//take a copy from the original array
	int *tmpArray;
	tmpArray = smalloc("tmpArr", sizeof(int) * *numOfElements, 0) ;
  8000a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000a8:	8b 00                	mov    (%eax),%eax
  8000aa:	c1 e0 02             	shl    $0x2,%eax
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 00                	push   $0x0
  8000b2:	50                   	push   %eax
  8000b3:	68 9a 21 80 00       	push   $0x80219a
  8000b8:	e8 d0 13 00 00       	call   80148d <smalloc>
  8000bd:	83 c4 10             	add    $0x10,%esp
  8000c0:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000ca:	eb 25                	jmp    8000f1 <_main+0xb9>
	{
		tmpArray[i] = sharedArray[i];
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

	//take a copy from the original array
	int *tmpArray;
	tmpArray = smalloc("tmpArr", sizeof(int) * *numOfElements, 0) ;
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000ee:	ff 45 f4             	incl   -0xc(%ebp)
  8000f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000f4:	8b 00                	mov    (%eax),%eax
  8000f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f9:	7f d1                	jg     8000cc <_main+0x94>
	{
		tmpArray[i] = sharedArray[i];
	}

	ArrayStats(tmpArray ,*numOfElements, &mean, &var, &min, &max, &med);
  8000fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000fe:	8b 00                	mov    (%eax),%eax
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	8d 55 b4             	lea    -0x4c(%ebp),%edx
  800106:	52                   	push   %edx
  800107:	8d 55 b8             	lea    -0x48(%ebp),%edx
  80010a:	52                   	push   %edx
  80010b:	8d 55 bc             	lea    -0x44(%ebp),%edx
  80010e:	52                   	push   %edx
  80010f:	8d 55 c0             	lea    -0x40(%ebp),%edx
  800112:	52                   	push   %edx
  800113:	8d 55 c4             	lea    -0x3c(%ebp),%edx
  800116:	52                   	push   %edx
  800117:	50                   	push   %eax
  800118:	ff 75 dc             	pushl  -0x24(%ebp)
  80011b:	e8 55 02 00 00       	call   800375 <ArrayStats>
  800120:	83 c4 20             	add    $0x20,%esp
	cprintf("Stats Calculations are Finished!!!!\n") ;
  800123:	83 ec 0c             	sub    $0xc,%esp
  800126:	68 a4 21 80 00       	push   $0x8021a4
  80012b:	e8 d3 05 00 00       	call   800703 <cprintf>
  800130:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THE RESULTS & DECLARE FINISHING*/
	int *shMean, *shVar, *shMin, *shMax, *shMed;
	shMean = smalloc("mean", sizeof(int), 0) ; *shMean = mean;
  800133:	83 ec 04             	sub    $0x4,%esp
  800136:	6a 00                	push   $0x0
  800138:	6a 04                	push   $0x4
  80013a:	68 c9 21 80 00       	push   $0x8021c9
  80013f:	e8 49 13 00 00       	call   80148d <smalloc>
  800144:	83 c4 10             	add    $0x10,%esp
  800147:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80014a:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  80014d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800150:	89 10                	mov    %edx,(%eax)
	shVar = smalloc("var", sizeof(int), 0) ; *shVar = var;
  800152:	83 ec 04             	sub    $0x4,%esp
  800155:	6a 00                	push   $0x0
  800157:	6a 04                	push   $0x4
  800159:	68 ce 21 80 00       	push   $0x8021ce
  80015e:	e8 2a 13 00 00       	call   80148d <smalloc>
  800163:	83 c4 10             	add    $0x10,%esp
  800166:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800169:	8b 55 c0             	mov    -0x40(%ebp),%edx
  80016c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80016f:	89 10                	mov    %edx,(%eax)
	shMin = smalloc("min", sizeof(int), 0) ; *shMin = min;
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	6a 00                	push   $0x0
  800176:	6a 04                	push   $0x4
  800178:	68 d2 21 80 00       	push   $0x8021d2
  80017d:	e8 0b 13 00 00       	call   80148d <smalloc>
  800182:	83 c4 10             	add    $0x10,%esp
  800185:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800188:	8b 55 bc             	mov    -0x44(%ebp),%edx
  80018b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80018e:	89 10                	mov    %edx,(%eax)
	shMax = smalloc("max", sizeof(int), 0) ; *shMax = max;
  800190:	83 ec 04             	sub    $0x4,%esp
  800193:	6a 00                	push   $0x0
  800195:	6a 04                	push   $0x4
  800197:	68 d6 21 80 00       	push   $0x8021d6
  80019c:	e8 ec 12 00 00       	call   80148d <smalloc>
  8001a1:	83 c4 10             	add    $0x10,%esp
  8001a4:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001a7:	8b 55 b8             	mov    -0x48(%ebp),%edx
  8001aa:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001ad:	89 10                	mov    %edx,(%eax)
	shMed = smalloc("med", sizeof(int), 0) ; *shMed = med;
  8001af:	83 ec 04             	sub    $0x4,%esp
  8001b2:	6a 00                	push   $0x0
  8001b4:	6a 04                	push   $0x4
  8001b6:	68 da 21 80 00       	push   $0x8021da
  8001bb:	e8 cd 12 00 00       	call   80148d <smalloc>
  8001c0:	83 c4 10             	add    $0x10,%esp
  8001c3:	89 45 c8             	mov    %eax,-0x38(%ebp)
  8001c6:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  8001c9:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001cc:	89 10                	mov    %edx,(%eax)

	(*finishedCount)++ ;
  8001ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001d1:	8b 00                	mov    (%eax),%eax
  8001d3:	8d 50 01             	lea    0x1(%eax),%edx
  8001d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001d9:	89 10                	mov    %edx,(%eax)

}
  8001db:	90                   	nop
  8001dc:	c9                   	leave  
  8001dd:	c3                   	ret    

008001de <KthElement>:



///Kth Element
int KthElement(int *Elements, int NumOfElements, int k)
{
  8001de:	55                   	push   %ebp
  8001df:	89 e5                	mov    %esp,%ebp
  8001e1:	83 ec 08             	sub    $0x8,%esp
	return QSort(Elements, NumOfElements, 0, NumOfElements-1, k-1) ;
  8001e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8001e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8001ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ed:	48                   	dec    %eax
  8001ee:	83 ec 0c             	sub    $0xc,%esp
  8001f1:	52                   	push   %edx
  8001f2:	50                   	push   %eax
  8001f3:	6a 00                	push   $0x0
  8001f5:	ff 75 0c             	pushl  0xc(%ebp)
  8001f8:	ff 75 08             	pushl  0x8(%ebp)
  8001fb:	e8 05 00 00 00       	call   800205 <QSort>
  800200:	83 c4 20             	add    $0x20,%esp
}
  800203:	c9                   	leave  
  800204:	c3                   	ret    

00800205 <QSort>:


int QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex, int kIndex)
{
  800205:	55                   	push   %ebp
  800206:	89 e5                	mov    %esp,%ebp
  800208:	83 ec 28             	sub    $0x28,%esp
	if (startIndex >= finalIndex) return Elements[finalIndex];
  80020b:	8b 45 10             	mov    0x10(%ebp),%eax
  80020e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800211:	7c 16                	jl     800229 <QSort+0x24>
  800213:	8b 45 14             	mov    0x14(%ebp),%eax
  800216:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80021d:	8b 45 08             	mov    0x8(%ebp),%eax
  800220:	01 d0                	add    %edx,%eax
  800222:	8b 00                	mov    (%eax),%eax
  800224:	e9 4a 01 00 00       	jmp    800373 <QSort+0x16e>

	int pvtIndex = RAND(startIndex, finalIndex) ;
  800229:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  80022c:	83 ec 0c             	sub    $0xc,%esp
  80022f:	50                   	push   %eax
  800230:	e8 fe 18 00 00       	call   801b33 <sys_get_virtual_time>
  800235:	83 c4 0c             	add    $0xc,%esp
  800238:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80023b:	8b 55 14             	mov    0x14(%ebp),%edx
  80023e:	2b 55 10             	sub    0x10(%ebp),%edx
  800241:	89 d1                	mov    %edx,%ecx
  800243:	ba 00 00 00 00       	mov    $0x0,%edx
  800248:	f7 f1                	div    %ecx
  80024a:	8b 45 10             	mov    0x10(%ebp),%eax
  80024d:	01 d0                	add    %edx,%eax
  80024f:	89 45 ec             	mov    %eax,-0x14(%ebp)
	Swap(Elements, startIndex, pvtIndex);
  800252:	83 ec 04             	sub    $0x4,%esp
  800255:	ff 75 ec             	pushl  -0x14(%ebp)
  800258:	ff 75 10             	pushl  0x10(%ebp)
  80025b:	ff 75 08             	pushl  0x8(%ebp)
  80025e:	e8 77 02 00 00       	call   8004da <Swap>
  800263:	83 c4 10             	add    $0x10,%esp

	int i = startIndex+1, j = finalIndex;
  800266:	8b 45 10             	mov    0x10(%ebp),%eax
  800269:	40                   	inc    %eax
  80026a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80026d:	8b 45 14             	mov    0x14(%ebp),%eax
  800270:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800273:	e9 80 00 00 00       	jmp    8002f8 <QSort+0xf3>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800278:	ff 45 f4             	incl   -0xc(%ebp)
  80027b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80027e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800281:	7f 2b                	jg     8002ae <QSort+0xa9>
  800283:	8b 45 10             	mov    0x10(%ebp),%eax
  800286:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80028d:	8b 45 08             	mov    0x8(%ebp),%eax
  800290:	01 d0                	add    %edx,%eax
  800292:	8b 10                	mov    (%eax),%edx
  800294:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800297:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80029e:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a1:	01 c8                	add    %ecx,%eax
  8002a3:	8b 00                	mov    (%eax),%eax
  8002a5:	39 c2                	cmp    %eax,%edx
  8002a7:	7d cf                	jge    800278 <QSort+0x73>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002a9:	eb 03                	jmp    8002ae <QSort+0xa9>
  8002ab:	ff 4d f0             	decl   -0x10(%ebp)
  8002ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002b1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002b4:	7e 26                	jle    8002dc <QSort+0xd7>
  8002b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c3:	01 d0                	add    %edx,%eax
  8002c5:	8b 10                	mov    (%eax),%edx
  8002c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002ca:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d4:	01 c8                	add    %ecx,%eax
  8002d6:	8b 00                	mov    (%eax),%eax
  8002d8:	39 c2                	cmp    %eax,%edx
  8002da:	7e cf                	jle    8002ab <QSort+0xa6>

		if (i <= j)
  8002dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002df:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002e2:	7f 14                	jg     8002f8 <QSort+0xf3>
		{
			Swap(Elements, i, j);
  8002e4:	83 ec 04             	sub    $0x4,%esp
  8002e7:	ff 75 f0             	pushl  -0x10(%ebp)
  8002ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ed:	ff 75 08             	pushl  0x8(%ebp)
  8002f0:	e8 e5 01 00 00       	call   8004da <Swap>
  8002f5:	83 c4 10             	add    $0x10,%esp
	int pvtIndex = RAND(startIndex, finalIndex) ;
	Swap(Elements, startIndex, pvtIndex);

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8002f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002fb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002fe:	0f 8e 77 ff ff ff    	jle    80027b <QSort+0x76>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800304:	83 ec 04             	sub    $0x4,%esp
  800307:	ff 75 f0             	pushl  -0x10(%ebp)
  80030a:	ff 75 10             	pushl  0x10(%ebp)
  80030d:	ff 75 08             	pushl  0x8(%ebp)
  800310:	e8 c5 01 00 00       	call   8004da <Swap>
  800315:	83 c4 10             	add    $0x10,%esp

	if (kIndex == j)
  800318:	8b 45 18             	mov    0x18(%ebp),%eax
  80031b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80031e:	75 13                	jne    800333 <QSort+0x12e>
		return Elements[kIndex] ;
  800320:	8b 45 18             	mov    0x18(%ebp),%eax
  800323:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032a:	8b 45 08             	mov    0x8(%ebp),%eax
  80032d:	01 d0                	add    %edx,%eax
  80032f:	8b 00                	mov    (%eax),%eax
  800331:	eb 40                	jmp    800373 <QSort+0x16e>
	else if (kIndex < j)
  800333:	8b 45 18             	mov    0x18(%ebp),%eax
  800336:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800339:	7d 1e                	jge    800359 <QSort+0x154>
		return QSort(Elements, NumOfElements, startIndex, j - 1, kIndex);
  80033b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033e:	48                   	dec    %eax
  80033f:	83 ec 0c             	sub    $0xc,%esp
  800342:	ff 75 18             	pushl  0x18(%ebp)
  800345:	50                   	push   %eax
  800346:	ff 75 10             	pushl  0x10(%ebp)
  800349:	ff 75 0c             	pushl  0xc(%ebp)
  80034c:	ff 75 08             	pushl  0x8(%ebp)
  80034f:	e8 b1 fe ff ff       	call   800205 <QSort>
  800354:	83 c4 20             	add    $0x20,%esp
  800357:	eb 1a                	jmp    800373 <QSort+0x16e>
	else
		return QSort(Elements, NumOfElements, i, finalIndex, kIndex);
  800359:	83 ec 0c             	sub    $0xc,%esp
  80035c:	ff 75 18             	pushl  0x18(%ebp)
  80035f:	ff 75 14             	pushl  0x14(%ebp)
  800362:	ff 75 f4             	pushl  -0xc(%ebp)
  800365:	ff 75 0c             	pushl  0xc(%ebp)
  800368:	ff 75 08             	pushl  0x8(%ebp)
  80036b:	e8 95 fe ff ff       	call   800205 <QSort>
  800370:	83 c4 20             	add    $0x20,%esp
}
  800373:	c9                   	leave  
  800374:	c3                   	ret    

00800375 <ArrayStats>:

void ArrayStats(int *Elements, int NumOfElements, int *mean, int *var, int *min, int *max, int *med)
{
  800375:	55                   	push   %ebp
  800376:	89 e5                	mov    %esp,%ebp
  800378:	53                   	push   %ebx
  800379:	83 ec 14             	sub    $0x14,%esp
	int i ;
	*mean =0 ;
  80037c:	8b 45 10             	mov    0x10(%ebp),%eax
  80037f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	*min = 0x7FFFFFFF ;
  800385:	8b 45 18             	mov    0x18(%ebp),%eax
  800388:	c7 00 ff ff ff 7f    	movl   $0x7fffffff,(%eax)
	*max = 0x80000000 ;
  80038e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800391:	c7 00 00 00 00 80    	movl   $0x80000000,(%eax)
	for (i = 0 ; i < NumOfElements ; i++)
  800397:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80039e:	e9 80 00 00 00       	jmp    800423 <ArrayStats+0xae>
	{
		(*mean) += Elements[i];
  8003a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8003a6:	8b 10                	mov    (%eax),%edx
  8003a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ab:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b5:	01 c8                	add    %ecx,%eax
  8003b7:	8b 00                	mov    (%eax),%eax
  8003b9:	01 c2                	add    %eax,%edx
  8003bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8003be:	89 10                	mov    %edx,(%eax)
		if (Elements[i] < (*min))
  8003c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cd:	01 d0                	add    %edx,%eax
  8003cf:	8b 10                	mov    (%eax),%edx
  8003d1:	8b 45 18             	mov    0x18(%ebp),%eax
  8003d4:	8b 00                	mov    (%eax),%eax
  8003d6:	39 c2                	cmp    %eax,%edx
  8003d8:	7d 16                	jge    8003f0 <ArrayStats+0x7b>
		{
			(*min) = Elements[i];
  8003da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e7:	01 d0                	add    %edx,%eax
  8003e9:	8b 10                	mov    (%eax),%edx
  8003eb:	8b 45 18             	mov    0x18(%ebp),%eax
  8003ee:	89 10                	mov    %edx,(%eax)
		}
		if (Elements[i] > (*max))
  8003f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003f3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fd:	01 d0                	add    %edx,%eax
  8003ff:	8b 10                	mov    (%eax),%edx
  800401:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800404:	8b 00                	mov    (%eax),%eax
  800406:	39 c2                	cmp    %eax,%edx
  800408:	7e 16                	jle    800420 <ArrayStats+0xab>
		{
			(*max) = Elements[i];
  80040a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80040d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800414:	8b 45 08             	mov    0x8(%ebp),%eax
  800417:	01 d0                	add    %edx,%eax
  800419:	8b 10                	mov    (%eax),%edx
  80041b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80041e:	89 10                	mov    %edx,(%eax)
{
	int i ;
	*mean =0 ;
	*min = 0x7FFFFFFF ;
	*max = 0x80000000 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800420:	ff 45 f4             	incl   -0xc(%ebp)
  800423:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800426:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800429:	0f 8c 74 ff ff ff    	jl     8003a3 <ArrayStats+0x2e>
		{
			(*max) = Elements[i];
		}
	}

	(*med) = KthElement(Elements, NumOfElements, NumOfElements/2);
  80042f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800432:	89 c2                	mov    %eax,%edx
  800434:	c1 ea 1f             	shr    $0x1f,%edx
  800437:	01 d0                	add    %edx,%eax
  800439:	d1 f8                	sar    %eax
  80043b:	83 ec 04             	sub    $0x4,%esp
  80043e:	50                   	push   %eax
  80043f:	ff 75 0c             	pushl  0xc(%ebp)
  800442:	ff 75 08             	pushl  0x8(%ebp)
  800445:	e8 94 fd ff ff       	call   8001de <KthElement>
  80044a:	83 c4 10             	add    $0x10,%esp
  80044d:	89 c2                	mov    %eax,%edx
  80044f:	8b 45 20             	mov    0x20(%ebp),%eax
  800452:	89 10                	mov    %edx,(%eax)

	(*mean) /= NumOfElements;
  800454:	8b 45 10             	mov    0x10(%ebp),%eax
  800457:	8b 00                	mov    (%eax),%eax
  800459:	99                   	cltd   
  80045a:	f7 7d 0c             	idivl  0xc(%ebp)
  80045d:	89 c2                	mov    %eax,%edx
  80045f:	8b 45 10             	mov    0x10(%ebp),%eax
  800462:	89 10                	mov    %edx,(%eax)
	(*var) = 0;
  800464:	8b 45 14             	mov    0x14(%ebp),%eax
  800467:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	for (i = 0 ; i < NumOfElements ; i++)
  80046d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800474:	eb 46                	jmp    8004bc <ArrayStats+0x147>
	{
		(*var) += (Elements[i] - (*mean))*(Elements[i] - (*mean));
  800476:	8b 45 14             	mov    0x14(%ebp),%eax
  800479:	8b 10                	mov    (%eax),%edx
  80047b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80047e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800485:	8b 45 08             	mov    0x8(%ebp),%eax
  800488:	01 c8                	add    %ecx,%eax
  80048a:	8b 08                	mov    (%eax),%ecx
  80048c:	8b 45 10             	mov    0x10(%ebp),%eax
  80048f:	8b 00                	mov    (%eax),%eax
  800491:	89 cb                	mov    %ecx,%ebx
  800493:	29 c3                	sub    %eax,%ebx
  800495:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800498:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80049f:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a2:	01 c8                	add    %ecx,%eax
  8004a4:	8b 08                	mov    (%eax),%ecx
  8004a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8004a9:	8b 00                	mov    (%eax),%eax
  8004ab:	29 c1                	sub    %eax,%ecx
  8004ad:	89 c8                	mov    %ecx,%eax
  8004af:	0f af c3             	imul   %ebx,%eax
  8004b2:	01 c2                	add    %eax,%edx
  8004b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8004b7:	89 10                	mov    %edx,(%eax)

	(*med) = KthElement(Elements, NumOfElements, NumOfElements/2);

	(*mean) /= NumOfElements;
	(*var) = 0;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b9:	ff 45 f4             	incl   -0xc(%ebp)
  8004bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004bf:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004c2:	7c b2                	jl     800476 <ArrayStats+0x101>
	{
		(*var) += (Elements[i] - (*mean))*(Elements[i] - (*mean));
	}
	(*var) /= NumOfElements;
  8004c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8004c7:	8b 00                	mov    (%eax),%eax
  8004c9:	99                   	cltd   
  8004ca:	f7 7d 0c             	idivl  0xc(%ebp)
  8004cd:	89 c2                	mov    %eax,%edx
  8004cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8004d2:	89 10                	mov    %edx,(%eax)
}
  8004d4:	90                   	nop
  8004d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004d8:	c9                   	leave  
  8004d9:	c3                   	ret    

008004da <Swap>:

///Private Functions
void Swap(int *Elements, int First, int Second)
{
  8004da:	55                   	push   %ebp
  8004db:	89 e5                	mov    %esp,%ebp
  8004dd:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8004e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ed:	01 d0                	add    %edx,%eax
  8004ef:	8b 00                	mov    (%eax),%eax
  8004f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8004f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800501:	01 c2                	add    %eax,%edx
  800503:	8b 45 10             	mov    0x10(%ebp),%eax
  800506:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	01 c8                	add    %ecx,%eax
  800512:	8b 00                	mov    (%eax),%eax
  800514:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800516:	8b 45 10             	mov    0x10(%ebp),%eax
  800519:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800520:	8b 45 08             	mov    0x8(%ebp),%eax
  800523:	01 c2                	add    %eax,%edx
  800525:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800528:	89 02                	mov    %eax,(%edx)
}
  80052a:	90                   	nop
  80052b:	c9                   	leave  
  80052c:	c3                   	ret    

0080052d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80052d:	55                   	push   %ebp
  80052e:	89 e5                	mov    %esp,%ebp
  800530:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800533:	e8 86 12 00 00       	call   8017be <sys_getenvindex>
  800538:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80053b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80053e:	89 d0                	mov    %edx,%eax
  800540:	01 c0                	add    %eax,%eax
  800542:	01 d0                	add    %edx,%eax
  800544:	c1 e0 02             	shl    $0x2,%eax
  800547:	01 d0                	add    %edx,%eax
  800549:	c1 e0 06             	shl    $0x6,%eax
  80054c:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800551:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800556:	a1 20 30 80 00       	mov    0x803020,%eax
  80055b:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800561:	84 c0                	test   %al,%al
  800563:	74 0f                	je     800574 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800565:	a1 20 30 80 00       	mov    0x803020,%eax
  80056a:	05 f4 02 00 00       	add    $0x2f4,%eax
  80056f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800574:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800578:	7e 0a                	jle    800584 <libmain+0x57>
		binaryname = argv[0];
  80057a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80057d:	8b 00                	mov    (%eax),%eax
  80057f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800584:	83 ec 08             	sub    $0x8,%esp
  800587:	ff 75 0c             	pushl  0xc(%ebp)
  80058a:	ff 75 08             	pushl  0x8(%ebp)
  80058d:	e8 a6 fa ff ff       	call   800038 <_main>
  800592:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800595:	e8 bf 13 00 00       	call   801959 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80059a:	83 ec 0c             	sub    $0xc,%esp
  80059d:	68 f8 21 80 00       	push   $0x8021f8
  8005a2:	e8 5c 01 00 00       	call   800703 <cprintf>
  8005a7:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8005aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8005af:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8005b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ba:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8005c0:	83 ec 04             	sub    $0x4,%esp
  8005c3:	52                   	push   %edx
  8005c4:	50                   	push   %eax
  8005c5:	68 20 22 80 00       	push   $0x802220
  8005ca:	e8 34 01 00 00       	call   800703 <cprintf>
  8005cf:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8005d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8005d7:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8005dd:	83 ec 08             	sub    $0x8,%esp
  8005e0:	50                   	push   %eax
  8005e1:	68 45 22 80 00       	push   $0x802245
  8005e6:	e8 18 01 00 00       	call   800703 <cprintf>
  8005eb:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8005ee:	83 ec 0c             	sub    $0xc,%esp
  8005f1:	68 f8 21 80 00       	push   $0x8021f8
  8005f6:	e8 08 01 00 00       	call   800703 <cprintf>
  8005fb:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005fe:	e8 70 13 00 00       	call   801973 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800603:	e8 19 00 00 00       	call   800621 <exit>
}
  800608:	90                   	nop
  800609:	c9                   	leave  
  80060a:	c3                   	ret    

0080060b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80060b:	55                   	push   %ebp
  80060c:	89 e5                	mov    %esp,%ebp
  80060e:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800611:	83 ec 0c             	sub    $0xc,%esp
  800614:	6a 00                	push   $0x0
  800616:	e8 6f 11 00 00       	call   80178a <sys_env_destroy>
  80061b:	83 c4 10             	add    $0x10,%esp
}
  80061e:	90                   	nop
  80061f:	c9                   	leave  
  800620:	c3                   	ret    

00800621 <exit>:

void
exit(void)
{
  800621:	55                   	push   %ebp
  800622:	89 e5                	mov    %esp,%ebp
  800624:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800627:	e8 c4 11 00 00       	call   8017f0 <sys_env_exit>
}
  80062c:	90                   	nop
  80062d:	c9                   	leave  
  80062e:	c3                   	ret    

0080062f <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80062f:	55                   	push   %ebp
  800630:	89 e5                	mov    %esp,%ebp
  800632:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800635:	8b 45 0c             	mov    0xc(%ebp),%eax
  800638:	8b 00                	mov    (%eax),%eax
  80063a:	8d 48 01             	lea    0x1(%eax),%ecx
  80063d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800640:	89 0a                	mov    %ecx,(%edx)
  800642:	8b 55 08             	mov    0x8(%ebp),%edx
  800645:	88 d1                	mov    %dl,%cl
  800647:	8b 55 0c             	mov    0xc(%ebp),%edx
  80064a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80064e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800651:	8b 00                	mov    (%eax),%eax
  800653:	3d ff 00 00 00       	cmp    $0xff,%eax
  800658:	75 2c                	jne    800686 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80065a:	a0 24 30 80 00       	mov    0x803024,%al
  80065f:	0f b6 c0             	movzbl %al,%eax
  800662:	8b 55 0c             	mov    0xc(%ebp),%edx
  800665:	8b 12                	mov    (%edx),%edx
  800667:	89 d1                	mov    %edx,%ecx
  800669:	8b 55 0c             	mov    0xc(%ebp),%edx
  80066c:	83 c2 08             	add    $0x8,%edx
  80066f:	83 ec 04             	sub    $0x4,%esp
  800672:	50                   	push   %eax
  800673:	51                   	push   %ecx
  800674:	52                   	push   %edx
  800675:	e8 ce 10 00 00       	call   801748 <sys_cputs>
  80067a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80067d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800680:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800686:	8b 45 0c             	mov    0xc(%ebp),%eax
  800689:	8b 40 04             	mov    0x4(%eax),%eax
  80068c:	8d 50 01             	lea    0x1(%eax),%edx
  80068f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800692:	89 50 04             	mov    %edx,0x4(%eax)
}
  800695:	90                   	nop
  800696:	c9                   	leave  
  800697:	c3                   	ret    

00800698 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800698:	55                   	push   %ebp
  800699:	89 e5                	mov    %esp,%ebp
  80069b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006a1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006a8:	00 00 00 
	b.cnt = 0;
  8006ab:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006b2:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006b5:	ff 75 0c             	pushl  0xc(%ebp)
  8006b8:	ff 75 08             	pushl  0x8(%ebp)
  8006bb:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006c1:	50                   	push   %eax
  8006c2:	68 2f 06 80 00       	push   $0x80062f
  8006c7:	e8 11 02 00 00       	call   8008dd <vprintfmt>
  8006cc:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006cf:	a0 24 30 80 00       	mov    0x803024,%al
  8006d4:	0f b6 c0             	movzbl %al,%eax
  8006d7:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8006dd:	83 ec 04             	sub    $0x4,%esp
  8006e0:	50                   	push   %eax
  8006e1:	52                   	push   %edx
  8006e2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006e8:	83 c0 08             	add    $0x8,%eax
  8006eb:	50                   	push   %eax
  8006ec:	e8 57 10 00 00       	call   801748 <sys_cputs>
  8006f1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8006f4:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8006fb:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800701:	c9                   	leave  
  800702:	c3                   	ret    

00800703 <cprintf>:

int cprintf(const char *fmt, ...) {
  800703:	55                   	push   %ebp
  800704:	89 e5                	mov    %esp,%ebp
  800706:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800709:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800710:	8d 45 0c             	lea    0xc(%ebp),%eax
  800713:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800716:	8b 45 08             	mov    0x8(%ebp),%eax
  800719:	83 ec 08             	sub    $0x8,%esp
  80071c:	ff 75 f4             	pushl  -0xc(%ebp)
  80071f:	50                   	push   %eax
  800720:	e8 73 ff ff ff       	call   800698 <vcprintf>
  800725:	83 c4 10             	add    $0x10,%esp
  800728:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80072b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80072e:	c9                   	leave  
  80072f:	c3                   	ret    

00800730 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800730:	55                   	push   %ebp
  800731:	89 e5                	mov    %esp,%ebp
  800733:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800736:	e8 1e 12 00 00       	call   801959 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80073b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80073e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800741:	8b 45 08             	mov    0x8(%ebp),%eax
  800744:	83 ec 08             	sub    $0x8,%esp
  800747:	ff 75 f4             	pushl  -0xc(%ebp)
  80074a:	50                   	push   %eax
  80074b:	e8 48 ff ff ff       	call   800698 <vcprintf>
  800750:	83 c4 10             	add    $0x10,%esp
  800753:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800756:	e8 18 12 00 00       	call   801973 <sys_enable_interrupt>
	return cnt;
  80075b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80075e:	c9                   	leave  
  80075f:	c3                   	ret    

00800760 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800760:	55                   	push   %ebp
  800761:	89 e5                	mov    %esp,%ebp
  800763:	53                   	push   %ebx
  800764:	83 ec 14             	sub    $0x14,%esp
  800767:	8b 45 10             	mov    0x10(%ebp),%eax
  80076a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80076d:	8b 45 14             	mov    0x14(%ebp),%eax
  800770:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800773:	8b 45 18             	mov    0x18(%ebp),%eax
  800776:	ba 00 00 00 00       	mov    $0x0,%edx
  80077b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80077e:	77 55                	ja     8007d5 <printnum+0x75>
  800780:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800783:	72 05                	jb     80078a <printnum+0x2a>
  800785:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800788:	77 4b                	ja     8007d5 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80078a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80078d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800790:	8b 45 18             	mov    0x18(%ebp),%eax
  800793:	ba 00 00 00 00       	mov    $0x0,%edx
  800798:	52                   	push   %edx
  800799:	50                   	push   %eax
  80079a:	ff 75 f4             	pushl  -0xc(%ebp)
  80079d:	ff 75 f0             	pushl  -0x10(%ebp)
  8007a0:	e8 73 17 00 00       	call   801f18 <__udivdi3>
  8007a5:	83 c4 10             	add    $0x10,%esp
  8007a8:	83 ec 04             	sub    $0x4,%esp
  8007ab:	ff 75 20             	pushl  0x20(%ebp)
  8007ae:	53                   	push   %ebx
  8007af:	ff 75 18             	pushl  0x18(%ebp)
  8007b2:	52                   	push   %edx
  8007b3:	50                   	push   %eax
  8007b4:	ff 75 0c             	pushl  0xc(%ebp)
  8007b7:	ff 75 08             	pushl  0x8(%ebp)
  8007ba:	e8 a1 ff ff ff       	call   800760 <printnum>
  8007bf:	83 c4 20             	add    $0x20,%esp
  8007c2:	eb 1a                	jmp    8007de <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007c4:	83 ec 08             	sub    $0x8,%esp
  8007c7:	ff 75 0c             	pushl  0xc(%ebp)
  8007ca:	ff 75 20             	pushl  0x20(%ebp)
  8007cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d0:	ff d0                	call   *%eax
  8007d2:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007d5:	ff 4d 1c             	decl   0x1c(%ebp)
  8007d8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007dc:	7f e6                	jg     8007c4 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007de:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007e1:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ec:	53                   	push   %ebx
  8007ed:	51                   	push   %ecx
  8007ee:	52                   	push   %edx
  8007ef:	50                   	push   %eax
  8007f0:	e8 33 18 00 00       	call   802028 <__umoddi3>
  8007f5:	83 c4 10             	add    $0x10,%esp
  8007f8:	05 74 24 80 00       	add    $0x802474,%eax
  8007fd:	8a 00                	mov    (%eax),%al
  8007ff:	0f be c0             	movsbl %al,%eax
  800802:	83 ec 08             	sub    $0x8,%esp
  800805:	ff 75 0c             	pushl  0xc(%ebp)
  800808:	50                   	push   %eax
  800809:	8b 45 08             	mov    0x8(%ebp),%eax
  80080c:	ff d0                	call   *%eax
  80080e:	83 c4 10             	add    $0x10,%esp
}
  800811:	90                   	nop
  800812:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800815:	c9                   	leave  
  800816:	c3                   	ret    

00800817 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800817:	55                   	push   %ebp
  800818:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80081a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80081e:	7e 1c                	jle    80083c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800820:	8b 45 08             	mov    0x8(%ebp),%eax
  800823:	8b 00                	mov    (%eax),%eax
  800825:	8d 50 08             	lea    0x8(%eax),%edx
  800828:	8b 45 08             	mov    0x8(%ebp),%eax
  80082b:	89 10                	mov    %edx,(%eax)
  80082d:	8b 45 08             	mov    0x8(%ebp),%eax
  800830:	8b 00                	mov    (%eax),%eax
  800832:	83 e8 08             	sub    $0x8,%eax
  800835:	8b 50 04             	mov    0x4(%eax),%edx
  800838:	8b 00                	mov    (%eax),%eax
  80083a:	eb 40                	jmp    80087c <getuint+0x65>
	else if (lflag)
  80083c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800840:	74 1e                	je     800860 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800842:	8b 45 08             	mov    0x8(%ebp),%eax
  800845:	8b 00                	mov    (%eax),%eax
  800847:	8d 50 04             	lea    0x4(%eax),%edx
  80084a:	8b 45 08             	mov    0x8(%ebp),%eax
  80084d:	89 10                	mov    %edx,(%eax)
  80084f:	8b 45 08             	mov    0x8(%ebp),%eax
  800852:	8b 00                	mov    (%eax),%eax
  800854:	83 e8 04             	sub    $0x4,%eax
  800857:	8b 00                	mov    (%eax),%eax
  800859:	ba 00 00 00 00       	mov    $0x0,%edx
  80085e:	eb 1c                	jmp    80087c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800860:	8b 45 08             	mov    0x8(%ebp),%eax
  800863:	8b 00                	mov    (%eax),%eax
  800865:	8d 50 04             	lea    0x4(%eax),%edx
  800868:	8b 45 08             	mov    0x8(%ebp),%eax
  80086b:	89 10                	mov    %edx,(%eax)
  80086d:	8b 45 08             	mov    0x8(%ebp),%eax
  800870:	8b 00                	mov    (%eax),%eax
  800872:	83 e8 04             	sub    $0x4,%eax
  800875:	8b 00                	mov    (%eax),%eax
  800877:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80087c:	5d                   	pop    %ebp
  80087d:	c3                   	ret    

0080087e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80087e:	55                   	push   %ebp
  80087f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800881:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800885:	7e 1c                	jle    8008a3 <getint+0x25>
		return va_arg(*ap, long long);
  800887:	8b 45 08             	mov    0x8(%ebp),%eax
  80088a:	8b 00                	mov    (%eax),%eax
  80088c:	8d 50 08             	lea    0x8(%eax),%edx
  80088f:	8b 45 08             	mov    0x8(%ebp),%eax
  800892:	89 10                	mov    %edx,(%eax)
  800894:	8b 45 08             	mov    0x8(%ebp),%eax
  800897:	8b 00                	mov    (%eax),%eax
  800899:	83 e8 08             	sub    $0x8,%eax
  80089c:	8b 50 04             	mov    0x4(%eax),%edx
  80089f:	8b 00                	mov    (%eax),%eax
  8008a1:	eb 38                	jmp    8008db <getint+0x5d>
	else if (lflag)
  8008a3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008a7:	74 1a                	je     8008c3 <getint+0x45>
		return va_arg(*ap, long);
  8008a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ac:	8b 00                	mov    (%eax),%eax
  8008ae:	8d 50 04             	lea    0x4(%eax),%edx
  8008b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b4:	89 10                	mov    %edx,(%eax)
  8008b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b9:	8b 00                	mov    (%eax),%eax
  8008bb:	83 e8 04             	sub    $0x4,%eax
  8008be:	8b 00                	mov    (%eax),%eax
  8008c0:	99                   	cltd   
  8008c1:	eb 18                	jmp    8008db <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c6:	8b 00                	mov    (%eax),%eax
  8008c8:	8d 50 04             	lea    0x4(%eax),%edx
  8008cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ce:	89 10                	mov    %edx,(%eax)
  8008d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d3:	8b 00                	mov    (%eax),%eax
  8008d5:	83 e8 04             	sub    $0x4,%eax
  8008d8:	8b 00                	mov    (%eax),%eax
  8008da:	99                   	cltd   
}
  8008db:	5d                   	pop    %ebp
  8008dc:	c3                   	ret    

008008dd <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008dd:	55                   	push   %ebp
  8008de:	89 e5                	mov    %esp,%ebp
  8008e0:	56                   	push   %esi
  8008e1:	53                   	push   %ebx
  8008e2:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008e5:	eb 17                	jmp    8008fe <vprintfmt+0x21>
			if (ch == '\0')
  8008e7:	85 db                	test   %ebx,%ebx
  8008e9:	0f 84 af 03 00 00    	je     800c9e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8008ef:	83 ec 08             	sub    $0x8,%esp
  8008f2:	ff 75 0c             	pushl  0xc(%ebp)
  8008f5:	53                   	push   %ebx
  8008f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f9:	ff d0                	call   *%eax
  8008fb:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800901:	8d 50 01             	lea    0x1(%eax),%edx
  800904:	89 55 10             	mov    %edx,0x10(%ebp)
  800907:	8a 00                	mov    (%eax),%al
  800909:	0f b6 d8             	movzbl %al,%ebx
  80090c:	83 fb 25             	cmp    $0x25,%ebx
  80090f:	75 d6                	jne    8008e7 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800911:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800915:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80091c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800923:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80092a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800931:	8b 45 10             	mov    0x10(%ebp),%eax
  800934:	8d 50 01             	lea    0x1(%eax),%edx
  800937:	89 55 10             	mov    %edx,0x10(%ebp)
  80093a:	8a 00                	mov    (%eax),%al
  80093c:	0f b6 d8             	movzbl %al,%ebx
  80093f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800942:	83 f8 55             	cmp    $0x55,%eax
  800945:	0f 87 2b 03 00 00    	ja     800c76 <vprintfmt+0x399>
  80094b:	8b 04 85 98 24 80 00 	mov    0x802498(,%eax,4),%eax
  800952:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800954:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800958:	eb d7                	jmp    800931 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80095a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80095e:	eb d1                	jmp    800931 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800960:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800967:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80096a:	89 d0                	mov    %edx,%eax
  80096c:	c1 e0 02             	shl    $0x2,%eax
  80096f:	01 d0                	add    %edx,%eax
  800971:	01 c0                	add    %eax,%eax
  800973:	01 d8                	add    %ebx,%eax
  800975:	83 e8 30             	sub    $0x30,%eax
  800978:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80097b:	8b 45 10             	mov    0x10(%ebp),%eax
  80097e:	8a 00                	mov    (%eax),%al
  800980:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800983:	83 fb 2f             	cmp    $0x2f,%ebx
  800986:	7e 3e                	jle    8009c6 <vprintfmt+0xe9>
  800988:	83 fb 39             	cmp    $0x39,%ebx
  80098b:	7f 39                	jg     8009c6 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80098d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800990:	eb d5                	jmp    800967 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800992:	8b 45 14             	mov    0x14(%ebp),%eax
  800995:	83 c0 04             	add    $0x4,%eax
  800998:	89 45 14             	mov    %eax,0x14(%ebp)
  80099b:	8b 45 14             	mov    0x14(%ebp),%eax
  80099e:	83 e8 04             	sub    $0x4,%eax
  8009a1:	8b 00                	mov    (%eax),%eax
  8009a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009a6:	eb 1f                	jmp    8009c7 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009a8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009ac:	79 83                	jns    800931 <vprintfmt+0x54>
				width = 0;
  8009ae:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009b5:	e9 77 ff ff ff       	jmp    800931 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009ba:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009c1:	e9 6b ff ff ff       	jmp    800931 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009c6:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009c7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009cb:	0f 89 60 ff ff ff    	jns    800931 <vprintfmt+0x54>
				width = precision, precision = -1;
  8009d1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009d7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009de:	e9 4e ff ff ff       	jmp    800931 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009e3:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009e6:	e9 46 ff ff ff       	jmp    800931 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ee:	83 c0 04             	add    $0x4,%eax
  8009f1:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f7:	83 e8 04             	sub    $0x4,%eax
  8009fa:	8b 00                	mov    (%eax),%eax
  8009fc:	83 ec 08             	sub    $0x8,%esp
  8009ff:	ff 75 0c             	pushl  0xc(%ebp)
  800a02:	50                   	push   %eax
  800a03:	8b 45 08             	mov    0x8(%ebp),%eax
  800a06:	ff d0                	call   *%eax
  800a08:	83 c4 10             	add    $0x10,%esp
			break;
  800a0b:	e9 89 02 00 00       	jmp    800c99 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a10:	8b 45 14             	mov    0x14(%ebp),%eax
  800a13:	83 c0 04             	add    $0x4,%eax
  800a16:	89 45 14             	mov    %eax,0x14(%ebp)
  800a19:	8b 45 14             	mov    0x14(%ebp),%eax
  800a1c:	83 e8 04             	sub    $0x4,%eax
  800a1f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a21:	85 db                	test   %ebx,%ebx
  800a23:	79 02                	jns    800a27 <vprintfmt+0x14a>
				err = -err;
  800a25:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a27:	83 fb 64             	cmp    $0x64,%ebx
  800a2a:	7f 0b                	jg     800a37 <vprintfmt+0x15a>
  800a2c:	8b 34 9d e0 22 80 00 	mov    0x8022e0(,%ebx,4),%esi
  800a33:	85 f6                	test   %esi,%esi
  800a35:	75 19                	jne    800a50 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a37:	53                   	push   %ebx
  800a38:	68 85 24 80 00       	push   $0x802485
  800a3d:	ff 75 0c             	pushl  0xc(%ebp)
  800a40:	ff 75 08             	pushl  0x8(%ebp)
  800a43:	e8 5e 02 00 00       	call   800ca6 <printfmt>
  800a48:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a4b:	e9 49 02 00 00       	jmp    800c99 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a50:	56                   	push   %esi
  800a51:	68 8e 24 80 00       	push   $0x80248e
  800a56:	ff 75 0c             	pushl  0xc(%ebp)
  800a59:	ff 75 08             	pushl  0x8(%ebp)
  800a5c:	e8 45 02 00 00       	call   800ca6 <printfmt>
  800a61:	83 c4 10             	add    $0x10,%esp
			break;
  800a64:	e9 30 02 00 00       	jmp    800c99 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a69:	8b 45 14             	mov    0x14(%ebp),%eax
  800a6c:	83 c0 04             	add    $0x4,%eax
  800a6f:	89 45 14             	mov    %eax,0x14(%ebp)
  800a72:	8b 45 14             	mov    0x14(%ebp),%eax
  800a75:	83 e8 04             	sub    $0x4,%eax
  800a78:	8b 30                	mov    (%eax),%esi
  800a7a:	85 f6                	test   %esi,%esi
  800a7c:	75 05                	jne    800a83 <vprintfmt+0x1a6>
				p = "(null)";
  800a7e:	be 91 24 80 00       	mov    $0x802491,%esi
			if (width > 0 && padc != '-')
  800a83:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a87:	7e 6d                	jle    800af6 <vprintfmt+0x219>
  800a89:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a8d:	74 67                	je     800af6 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a8f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a92:	83 ec 08             	sub    $0x8,%esp
  800a95:	50                   	push   %eax
  800a96:	56                   	push   %esi
  800a97:	e8 0c 03 00 00       	call   800da8 <strnlen>
  800a9c:	83 c4 10             	add    $0x10,%esp
  800a9f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800aa2:	eb 16                	jmp    800aba <vprintfmt+0x1dd>
					putch(padc, putdat);
  800aa4:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800aa8:	83 ec 08             	sub    $0x8,%esp
  800aab:	ff 75 0c             	pushl  0xc(%ebp)
  800aae:	50                   	push   %eax
  800aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab2:	ff d0                	call   *%eax
  800ab4:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ab7:	ff 4d e4             	decl   -0x1c(%ebp)
  800aba:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800abe:	7f e4                	jg     800aa4 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ac0:	eb 34                	jmp    800af6 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ac2:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ac6:	74 1c                	je     800ae4 <vprintfmt+0x207>
  800ac8:	83 fb 1f             	cmp    $0x1f,%ebx
  800acb:	7e 05                	jle    800ad2 <vprintfmt+0x1f5>
  800acd:	83 fb 7e             	cmp    $0x7e,%ebx
  800ad0:	7e 12                	jle    800ae4 <vprintfmt+0x207>
					putch('?', putdat);
  800ad2:	83 ec 08             	sub    $0x8,%esp
  800ad5:	ff 75 0c             	pushl  0xc(%ebp)
  800ad8:	6a 3f                	push   $0x3f
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	ff d0                	call   *%eax
  800adf:	83 c4 10             	add    $0x10,%esp
  800ae2:	eb 0f                	jmp    800af3 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800ae4:	83 ec 08             	sub    $0x8,%esp
  800ae7:	ff 75 0c             	pushl  0xc(%ebp)
  800aea:	53                   	push   %ebx
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	ff d0                	call   *%eax
  800af0:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800af3:	ff 4d e4             	decl   -0x1c(%ebp)
  800af6:	89 f0                	mov    %esi,%eax
  800af8:	8d 70 01             	lea    0x1(%eax),%esi
  800afb:	8a 00                	mov    (%eax),%al
  800afd:	0f be d8             	movsbl %al,%ebx
  800b00:	85 db                	test   %ebx,%ebx
  800b02:	74 24                	je     800b28 <vprintfmt+0x24b>
  800b04:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b08:	78 b8                	js     800ac2 <vprintfmt+0x1e5>
  800b0a:	ff 4d e0             	decl   -0x20(%ebp)
  800b0d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b11:	79 af                	jns    800ac2 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b13:	eb 13                	jmp    800b28 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b15:	83 ec 08             	sub    $0x8,%esp
  800b18:	ff 75 0c             	pushl  0xc(%ebp)
  800b1b:	6a 20                	push   $0x20
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	ff d0                	call   *%eax
  800b22:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b25:	ff 4d e4             	decl   -0x1c(%ebp)
  800b28:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b2c:	7f e7                	jg     800b15 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b2e:	e9 66 01 00 00       	jmp    800c99 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b33:	83 ec 08             	sub    $0x8,%esp
  800b36:	ff 75 e8             	pushl  -0x18(%ebp)
  800b39:	8d 45 14             	lea    0x14(%ebp),%eax
  800b3c:	50                   	push   %eax
  800b3d:	e8 3c fd ff ff       	call   80087e <getint>
  800b42:	83 c4 10             	add    $0x10,%esp
  800b45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b48:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b51:	85 d2                	test   %edx,%edx
  800b53:	79 23                	jns    800b78 <vprintfmt+0x29b>
				putch('-', putdat);
  800b55:	83 ec 08             	sub    $0x8,%esp
  800b58:	ff 75 0c             	pushl  0xc(%ebp)
  800b5b:	6a 2d                	push   $0x2d
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	ff d0                	call   *%eax
  800b62:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b65:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b6b:	f7 d8                	neg    %eax
  800b6d:	83 d2 00             	adc    $0x0,%edx
  800b70:	f7 da                	neg    %edx
  800b72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b75:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b78:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b7f:	e9 bc 00 00 00       	jmp    800c40 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b84:	83 ec 08             	sub    $0x8,%esp
  800b87:	ff 75 e8             	pushl  -0x18(%ebp)
  800b8a:	8d 45 14             	lea    0x14(%ebp),%eax
  800b8d:	50                   	push   %eax
  800b8e:	e8 84 fc ff ff       	call   800817 <getuint>
  800b93:	83 c4 10             	add    $0x10,%esp
  800b96:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b99:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b9c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ba3:	e9 98 00 00 00       	jmp    800c40 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ba8:	83 ec 08             	sub    $0x8,%esp
  800bab:	ff 75 0c             	pushl  0xc(%ebp)
  800bae:	6a 58                	push   $0x58
  800bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb3:	ff d0                	call   *%eax
  800bb5:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bb8:	83 ec 08             	sub    $0x8,%esp
  800bbb:	ff 75 0c             	pushl  0xc(%ebp)
  800bbe:	6a 58                	push   $0x58
  800bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc3:	ff d0                	call   *%eax
  800bc5:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bc8:	83 ec 08             	sub    $0x8,%esp
  800bcb:	ff 75 0c             	pushl  0xc(%ebp)
  800bce:	6a 58                	push   $0x58
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	ff d0                	call   *%eax
  800bd5:	83 c4 10             	add    $0x10,%esp
			break;
  800bd8:	e9 bc 00 00 00       	jmp    800c99 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800bdd:	83 ec 08             	sub    $0x8,%esp
  800be0:	ff 75 0c             	pushl  0xc(%ebp)
  800be3:	6a 30                	push   $0x30
  800be5:	8b 45 08             	mov    0x8(%ebp),%eax
  800be8:	ff d0                	call   *%eax
  800bea:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800bed:	83 ec 08             	sub    $0x8,%esp
  800bf0:	ff 75 0c             	pushl  0xc(%ebp)
  800bf3:	6a 78                	push   $0x78
  800bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf8:	ff d0                	call   *%eax
  800bfa:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800bfd:	8b 45 14             	mov    0x14(%ebp),%eax
  800c00:	83 c0 04             	add    $0x4,%eax
  800c03:	89 45 14             	mov    %eax,0x14(%ebp)
  800c06:	8b 45 14             	mov    0x14(%ebp),%eax
  800c09:	83 e8 04             	sub    $0x4,%eax
  800c0c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c11:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c18:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c1f:	eb 1f                	jmp    800c40 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c21:	83 ec 08             	sub    $0x8,%esp
  800c24:	ff 75 e8             	pushl  -0x18(%ebp)
  800c27:	8d 45 14             	lea    0x14(%ebp),%eax
  800c2a:	50                   	push   %eax
  800c2b:	e8 e7 fb ff ff       	call   800817 <getuint>
  800c30:	83 c4 10             	add    $0x10,%esp
  800c33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c36:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c39:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c40:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c44:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c47:	83 ec 04             	sub    $0x4,%esp
  800c4a:	52                   	push   %edx
  800c4b:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c4e:	50                   	push   %eax
  800c4f:	ff 75 f4             	pushl  -0xc(%ebp)
  800c52:	ff 75 f0             	pushl  -0x10(%ebp)
  800c55:	ff 75 0c             	pushl  0xc(%ebp)
  800c58:	ff 75 08             	pushl  0x8(%ebp)
  800c5b:	e8 00 fb ff ff       	call   800760 <printnum>
  800c60:	83 c4 20             	add    $0x20,%esp
			break;
  800c63:	eb 34                	jmp    800c99 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c65:	83 ec 08             	sub    $0x8,%esp
  800c68:	ff 75 0c             	pushl  0xc(%ebp)
  800c6b:	53                   	push   %ebx
  800c6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6f:	ff d0                	call   *%eax
  800c71:	83 c4 10             	add    $0x10,%esp
			break;
  800c74:	eb 23                	jmp    800c99 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c76:	83 ec 08             	sub    $0x8,%esp
  800c79:	ff 75 0c             	pushl  0xc(%ebp)
  800c7c:	6a 25                	push   $0x25
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	ff d0                	call   *%eax
  800c83:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c86:	ff 4d 10             	decl   0x10(%ebp)
  800c89:	eb 03                	jmp    800c8e <vprintfmt+0x3b1>
  800c8b:	ff 4d 10             	decl   0x10(%ebp)
  800c8e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c91:	48                   	dec    %eax
  800c92:	8a 00                	mov    (%eax),%al
  800c94:	3c 25                	cmp    $0x25,%al
  800c96:	75 f3                	jne    800c8b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c98:	90                   	nop
		}
	}
  800c99:	e9 47 fc ff ff       	jmp    8008e5 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c9e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c9f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ca2:	5b                   	pop    %ebx
  800ca3:	5e                   	pop    %esi
  800ca4:	5d                   	pop    %ebp
  800ca5:	c3                   	ret    

00800ca6 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ca6:	55                   	push   %ebp
  800ca7:	89 e5                	mov    %esp,%ebp
  800ca9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800cac:	8d 45 10             	lea    0x10(%ebp),%eax
  800caf:	83 c0 04             	add    $0x4,%eax
  800cb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800cb5:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb8:	ff 75 f4             	pushl  -0xc(%ebp)
  800cbb:	50                   	push   %eax
  800cbc:	ff 75 0c             	pushl  0xc(%ebp)
  800cbf:	ff 75 08             	pushl  0x8(%ebp)
  800cc2:	e8 16 fc ff ff       	call   8008dd <vprintfmt>
  800cc7:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cca:	90                   	nop
  800ccb:	c9                   	leave  
  800ccc:	c3                   	ret    

00800ccd <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ccd:	55                   	push   %ebp
  800cce:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800cd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd3:	8b 40 08             	mov    0x8(%eax),%eax
  800cd6:	8d 50 01             	lea    0x1(%eax),%edx
  800cd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cdc:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800cdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce2:	8b 10                	mov    (%eax),%edx
  800ce4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce7:	8b 40 04             	mov    0x4(%eax),%eax
  800cea:	39 c2                	cmp    %eax,%edx
  800cec:	73 12                	jae    800d00 <sprintputch+0x33>
		*b->buf++ = ch;
  800cee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf1:	8b 00                	mov    (%eax),%eax
  800cf3:	8d 48 01             	lea    0x1(%eax),%ecx
  800cf6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf9:	89 0a                	mov    %ecx,(%edx)
  800cfb:	8b 55 08             	mov    0x8(%ebp),%edx
  800cfe:	88 10                	mov    %dl,(%eax)
}
  800d00:	90                   	nop
  800d01:	5d                   	pop    %ebp
  800d02:	c3                   	ret    

00800d03 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d03:	55                   	push   %ebp
  800d04:	89 e5                	mov    %esp,%ebp
  800d06:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d12:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d15:	8b 45 08             	mov    0x8(%ebp),%eax
  800d18:	01 d0                	add    %edx,%eax
  800d1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d1d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d24:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d28:	74 06                	je     800d30 <vsnprintf+0x2d>
  800d2a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d2e:	7f 07                	jg     800d37 <vsnprintf+0x34>
		return -E_INVAL;
  800d30:	b8 03 00 00 00       	mov    $0x3,%eax
  800d35:	eb 20                	jmp    800d57 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d37:	ff 75 14             	pushl  0x14(%ebp)
  800d3a:	ff 75 10             	pushl  0x10(%ebp)
  800d3d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d40:	50                   	push   %eax
  800d41:	68 cd 0c 80 00       	push   $0x800ccd
  800d46:	e8 92 fb ff ff       	call   8008dd <vprintfmt>
  800d4b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d51:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d54:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d57:	c9                   	leave  
  800d58:	c3                   	ret    

00800d59 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d59:	55                   	push   %ebp
  800d5a:	89 e5                	mov    %esp,%ebp
  800d5c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d5f:	8d 45 10             	lea    0x10(%ebp),%eax
  800d62:	83 c0 04             	add    $0x4,%eax
  800d65:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d68:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6b:	ff 75 f4             	pushl  -0xc(%ebp)
  800d6e:	50                   	push   %eax
  800d6f:	ff 75 0c             	pushl  0xc(%ebp)
  800d72:	ff 75 08             	pushl  0x8(%ebp)
  800d75:	e8 89 ff ff ff       	call   800d03 <vsnprintf>
  800d7a:	83 c4 10             	add    $0x10,%esp
  800d7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d80:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d83:	c9                   	leave  
  800d84:	c3                   	ret    

00800d85 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d85:	55                   	push   %ebp
  800d86:	89 e5                	mov    %esp,%ebp
  800d88:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d8b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d92:	eb 06                	jmp    800d9a <strlen+0x15>
		n++;
  800d94:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d97:	ff 45 08             	incl   0x8(%ebp)
  800d9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9d:	8a 00                	mov    (%eax),%al
  800d9f:	84 c0                	test   %al,%al
  800da1:	75 f1                	jne    800d94 <strlen+0xf>
		n++;
	return n;
  800da3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800da6:	c9                   	leave  
  800da7:	c3                   	ret    

00800da8 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800da8:	55                   	push   %ebp
  800da9:	89 e5                	mov    %esp,%ebp
  800dab:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800db5:	eb 09                	jmp    800dc0 <strnlen+0x18>
		n++;
  800db7:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dba:	ff 45 08             	incl   0x8(%ebp)
  800dbd:	ff 4d 0c             	decl   0xc(%ebp)
  800dc0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dc4:	74 09                	je     800dcf <strnlen+0x27>
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc9:	8a 00                	mov    (%eax),%al
  800dcb:	84 c0                	test   %al,%al
  800dcd:	75 e8                	jne    800db7 <strnlen+0xf>
		n++;
	return n;
  800dcf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dd2:	c9                   	leave  
  800dd3:	c3                   	ret    

00800dd4 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800dd4:	55                   	push   %ebp
  800dd5:	89 e5                	mov    %esp,%ebp
  800dd7:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800de0:	90                   	nop
  800de1:	8b 45 08             	mov    0x8(%ebp),%eax
  800de4:	8d 50 01             	lea    0x1(%eax),%edx
  800de7:	89 55 08             	mov    %edx,0x8(%ebp)
  800dea:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ded:	8d 4a 01             	lea    0x1(%edx),%ecx
  800df0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800df3:	8a 12                	mov    (%edx),%dl
  800df5:	88 10                	mov    %dl,(%eax)
  800df7:	8a 00                	mov    (%eax),%al
  800df9:	84 c0                	test   %al,%al
  800dfb:	75 e4                	jne    800de1 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800dfd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e00:	c9                   	leave  
  800e01:	c3                   	ret    

00800e02 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e02:	55                   	push   %ebp
  800e03:	89 e5                	mov    %esp,%ebp
  800e05:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e0e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e15:	eb 1f                	jmp    800e36 <strncpy+0x34>
		*dst++ = *src;
  800e17:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1a:	8d 50 01             	lea    0x1(%eax),%edx
  800e1d:	89 55 08             	mov    %edx,0x8(%ebp)
  800e20:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e23:	8a 12                	mov    (%edx),%dl
  800e25:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2a:	8a 00                	mov    (%eax),%al
  800e2c:	84 c0                	test   %al,%al
  800e2e:	74 03                	je     800e33 <strncpy+0x31>
			src++;
  800e30:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e33:	ff 45 fc             	incl   -0x4(%ebp)
  800e36:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e39:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e3c:	72 d9                	jb     800e17 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e41:	c9                   	leave  
  800e42:	c3                   	ret    

00800e43 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e43:	55                   	push   %ebp
  800e44:	89 e5                	mov    %esp,%ebp
  800e46:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e49:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e4f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e53:	74 30                	je     800e85 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e55:	eb 16                	jmp    800e6d <strlcpy+0x2a>
			*dst++ = *src++;
  800e57:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5a:	8d 50 01             	lea    0x1(%eax),%edx
  800e5d:	89 55 08             	mov    %edx,0x8(%ebp)
  800e60:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e63:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e66:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e69:	8a 12                	mov    (%edx),%dl
  800e6b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e6d:	ff 4d 10             	decl   0x10(%ebp)
  800e70:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e74:	74 09                	je     800e7f <strlcpy+0x3c>
  800e76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e79:	8a 00                	mov    (%eax),%al
  800e7b:	84 c0                	test   %al,%al
  800e7d:	75 d8                	jne    800e57 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e82:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e85:	8b 55 08             	mov    0x8(%ebp),%edx
  800e88:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e8b:	29 c2                	sub    %eax,%edx
  800e8d:	89 d0                	mov    %edx,%eax
}
  800e8f:	c9                   	leave  
  800e90:	c3                   	ret    

00800e91 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e91:	55                   	push   %ebp
  800e92:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e94:	eb 06                	jmp    800e9c <strcmp+0xb>
		p++, q++;
  800e96:	ff 45 08             	incl   0x8(%ebp)
  800e99:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9f:	8a 00                	mov    (%eax),%al
  800ea1:	84 c0                	test   %al,%al
  800ea3:	74 0e                	je     800eb3 <strcmp+0x22>
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea8:	8a 10                	mov    (%eax),%dl
  800eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ead:	8a 00                	mov    (%eax),%al
  800eaf:	38 c2                	cmp    %al,%dl
  800eb1:	74 e3                	je     800e96 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb6:	8a 00                	mov    (%eax),%al
  800eb8:	0f b6 d0             	movzbl %al,%edx
  800ebb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebe:	8a 00                	mov    (%eax),%al
  800ec0:	0f b6 c0             	movzbl %al,%eax
  800ec3:	29 c2                	sub    %eax,%edx
  800ec5:	89 d0                	mov    %edx,%eax
}
  800ec7:	5d                   	pop    %ebp
  800ec8:	c3                   	ret    

00800ec9 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ec9:	55                   	push   %ebp
  800eca:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ecc:	eb 09                	jmp    800ed7 <strncmp+0xe>
		n--, p++, q++;
  800ece:	ff 4d 10             	decl   0x10(%ebp)
  800ed1:	ff 45 08             	incl   0x8(%ebp)
  800ed4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ed7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800edb:	74 17                	je     800ef4 <strncmp+0x2b>
  800edd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee0:	8a 00                	mov    (%eax),%al
  800ee2:	84 c0                	test   %al,%al
  800ee4:	74 0e                	je     800ef4 <strncmp+0x2b>
  800ee6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee9:	8a 10                	mov    (%eax),%dl
  800eeb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eee:	8a 00                	mov    (%eax),%al
  800ef0:	38 c2                	cmp    %al,%dl
  800ef2:	74 da                	je     800ece <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ef4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ef8:	75 07                	jne    800f01 <strncmp+0x38>
		return 0;
  800efa:	b8 00 00 00 00       	mov    $0x0,%eax
  800eff:	eb 14                	jmp    800f15 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f01:	8b 45 08             	mov    0x8(%ebp),%eax
  800f04:	8a 00                	mov    (%eax),%al
  800f06:	0f b6 d0             	movzbl %al,%edx
  800f09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0c:	8a 00                	mov    (%eax),%al
  800f0e:	0f b6 c0             	movzbl %al,%eax
  800f11:	29 c2                	sub    %eax,%edx
  800f13:	89 d0                	mov    %edx,%eax
}
  800f15:	5d                   	pop    %ebp
  800f16:	c3                   	ret    

00800f17 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f17:	55                   	push   %ebp
  800f18:	89 e5                	mov    %esp,%ebp
  800f1a:	83 ec 04             	sub    $0x4,%esp
  800f1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f20:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f23:	eb 12                	jmp    800f37 <strchr+0x20>
		if (*s == c)
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
  800f28:	8a 00                	mov    (%eax),%al
  800f2a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f2d:	75 05                	jne    800f34 <strchr+0x1d>
			return (char *) s;
  800f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f32:	eb 11                	jmp    800f45 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f34:	ff 45 08             	incl   0x8(%ebp)
  800f37:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3a:	8a 00                	mov    (%eax),%al
  800f3c:	84 c0                	test   %al,%al
  800f3e:	75 e5                	jne    800f25 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f40:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f45:	c9                   	leave  
  800f46:	c3                   	ret    

00800f47 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f47:	55                   	push   %ebp
  800f48:	89 e5                	mov    %esp,%ebp
  800f4a:	83 ec 04             	sub    $0x4,%esp
  800f4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f50:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f53:	eb 0d                	jmp    800f62 <strfind+0x1b>
		if (*s == c)
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	8a 00                	mov    (%eax),%al
  800f5a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f5d:	74 0e                	je     800f6d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f5f:	ff 45 08             	incl   0x8(%ebp)
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	8a 00                	mov    (%eax),%al
  800f67:	84 c0                	test   %al,%al
  800f69:	75 ea                	jne    800f55 <strfind+0xe>
  800f6b:	eb 01                	jmp    800f6e <strfind+0x27>
		if (*s == c)
			break;
  800f6d:	90                   	nop
	return (char *) s;
  800f6e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f71:	c9                   	leave  
  800f72:	c3                   	ret    

00800f73 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f73:	55                   	push   %ebp
  800f74:	89 e5                	mov    %esp,%ebp
  800f76:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f82:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f85:	eb 0e                	jmp    800f95 <memset+0x22>
		*p++ = c;
  800f87:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f8a:	8d 50 01             	lea    0x1(%eax),%edx
  800f8d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f90:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f93:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f95:	ff 4d f8             	decl   -0x8(%ebp)
  800f98:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f9c:	79 e9                	jns    800f87 <memset+0x14>
		*p++ = c;

	return v;
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fa1:	c9                   	leave  
  800fa2:	c3                   	ret    

00800fa3 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fa3:	55                   	push   %ebp
  800fa4:	89 e5                	mov    %esp,%ebp
  800fa6:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800fb5:	eb 16                	jmp    800fcd <memcpy+0x2a>
		*d++ = *s++;
  800fb7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fba:	8d 50 01             	lea    0x1(%eax),%edx
  800fbd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fc0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fc3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fc6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fc9:	8a 12                	mov    (%edx),%dl
  800fcb:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800fcd:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fd3:	89 55 10             	mov    %edx,0x10(%ebp)
  800fd6:	85 c0                	test   %eax,%eax
  800fd8:	75 dd                	jne    800fb7 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fdd:	c9                   	leave  
  800fde:	c3                   	ret    

00800fdf <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fdf:	55                   	push   %ebp
  800fe0:	89 e5                	mov    %esp,%ebp
  800fe2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800fe5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800feb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fee:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ff1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ff4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ff7:	73 50                	jae    801049 <memmove+0x6a>
  800ff9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ffc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fff:	01 d0                	add    %edx,%eax
  801001:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801004:	76 43                	jbe    801049 <memmove+0x6a>
		s += n;
  801006:	8b 45 10             	mov    0x10(%ebp),%eax
  801009:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80100c:	8b 45 10             	mov    0x10(%ebp),%eax
  80100f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801012:	eb 10                	jmp    801024 <memmove+0x45>
			*--d = *--s;
  801014:	ff 4d f8             	decl   -0x8(%ebp)
  801017:	ff 4d fc             	decl   -0x4(%ebp)
  80101a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80101d:	8a 10                	mov    (%eax),%dl
  80101f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801022:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801024:	8b 45 10             	mov    0x10(%ebp),%eax
  801027:	8d 50 ff             	lea    -0x1(%eax),%edx
  80102a:	89 55 10             	mov    %edx,0x10(%ebp)
  80102d:	85 c0                	test   %eax,%eax
  80102f:	75 e3                	jne    801014 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801031:	eb 23                	jmp    801056 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801033:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801036:	8d 50 01             	lea    0x1(%eax),%edx
  801039:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80103c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80103f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801042:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801045:	8a 12                	mov    (%edx),%dl
  801047:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801049:	8b 45 10             	mov    0x10(%ebp),%eax
  80104c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80104f:	89 55 10             	mov    %edx,0x10(%ebp)
  801052:	85 c0                	test   %eax,%eax
  801054:	75 dd                	jne    801033 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801056:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801059:	c9                   	leave  
  80105a:	c3                   	ret    

0080105b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80105b:	55                   	push   %ebp
  80105c:	89 e5                	mov    %esp,%ebp
  80105e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801061:	8b 45 08             	mov    0x8(%ebp),%eax
  801064:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801067:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80106d:	eb 2a                	jmp    801099 <memcmp+0x3e>
		if (*s1 != *s2)
  80106f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801072:	8a 10                	mov    (%eax),%dl
  801074:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801077:	8a 00                	mov    (%eax),%al
  801079:	38 c2                	cmp    %al,%dl
  80107b:	74 16                	je     801093 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80107d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801080:	8a 00                	mov    (%eax),%al
  801082:	0f b6 d0             	movzbl %al,%edx
  801085:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801088:	8a 00                	mov    (%eax),%al
  80108a:	0f b6 c0             	movzbl %al,%eax
  80108d:	29 c2                	sub    %eax,%edx
  80108f:	89 d0                	mov    %edx,%eax
  801091:	eb 18                	jmp    8010ab <memcmp+0x50>
		s1++, s2++;
  801093:	ff 45 fc             	incl   -0x4(%ebp)
  801096:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801099:	8b 45 10             	mov    0x10(%ebp),%eax
  80109c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80109f:	89 55 10             	mov    %edx,0x10(%ebp)
  8010a2:	85 c0                	test   %eax,%eax
  8010a4:	75 c9                	jne    80106f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010ab:	c9                   	leave  
  8010ac:	c3                   	ret    

008010ad <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010ad:	55                   	push   %ebp
  8010ae:	89 e5                	mov    %esp,%ebp
  8010b0:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8010b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b9:	01 d0                	add    %edx,%eax
  8010bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010be:	eb 15                	jmp    8010d5 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c3:	8a 00                	mov    (%eax),%al
  8010c5:	0f b6 d0             	movzbl %al,%edx
  8010c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cb:	0f b6 c0             	movzbl %al,%eax
  8010ce:	39 c2                	cmp    %eax,%edx
  8010d0:	74 0d                	je     8010df <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010d2:	ff 45 08             	incl   0x8(%ebp)
  8010d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010db:	72 e3                	jb     8010c0 <memfind+0x13>
  8010dd:	eb 01                	jmp    8010e0 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010df:	90                   	nop
	return (void *) s;
  8010e0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010e3:	c9                   	leave  
  8010e4:	c3                   	ret    

008010e5 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010e5:	55                   	push   %ebp
  8010e6:	89 e5                	mov    %esp,%ebp
  8010e8:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010f2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010f9:	eb 03                	jmp    8010fe <strtol+0x19>
		s++;
  8010fb:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801101:	8a 00                	mov    (%eax),%al
  801103:	3c 20                	cmp    $0x20,%al
  801105:	74 f4                	je     8010fb <strtol+0x16>
  801107:	8b 45 08             	mov    0x8(%ebp),%eax
  80110a:	8a 00                	mov    (%eax),%al
  80110c:	3c 09                	cmp    $0x9,%al
  80110e:	74 eb                	je     8010fb <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801110:	8b 45 08             	mov    0x8(%ebp),%eax
  801113:	8a 00                	mov    (%eax),%al
  801115:	3c 2b                	cmp    $0x2b,%al
  801117:	75 05                	jne    80111e <strtol+0x39>
		s++;
  801119:	ff 45 08             	incl   0x8(%ebp)
  80111c:	eb 13                	jmp    801131 <strtol+0x4c>
	else if (*s == '-')
  80111e:	8b 45 08             	mov    0x8(%ebp),%eax
  801121:	8a 00                	mov    (%eax),%al
  801123:	3c 2d                	cmp    $0x2d,%al
  801125:	75 0a                	jne    801131 <strtol+0x4c>
		s++, neg = 1;
  801127:	ff 45 08             	incl   0x8(%ebp)
  80112a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801131:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801135:	74 06                	je     80113d <strtol+0x58>
  801137:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80113b:	75 20                	jne    80115d <strtol+0x78>
  80113d:	8b 45 08             	mov    0x8(%ebp),%eax
  801140:	8a 00                	mov    (%eax),%al
  801142:	3c 30                	cmp    $0x30,%al
  801144:	75 17                	jne    80115d <strtol+0x78>
  801146:	8b 45 08             	mov    0x8(%ebp),%eax
  801149:	40                   	inc    %eax
  80114a:	8a 00                	mov    (%eax),%al
  80114c:	3c 78                	cmp    $0x78,%al
  80114e:	75 0d                	jne    80115d <strtol+0x78>
		s += 2, base = 16;
  801150:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801154:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80115b:	eb 28                	jmp    801185 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80115d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801161:	75 15                	jne    801178 <strtol+0x93>
  801163:	8b 45 08             	mov    0x8(%ebp),%eax
  801166:	8a 00                	mov    (%eax),%al
  801168:	3c 30                	cmp    $0x30,%al
  80116a:	75 0c                	jne    801178 <strtol+0x93>
		s++, base = 8;
  80116c:	ff 45 08             	incl   0x8(%ebp)
  80116f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801176:	eb 0d                	jmp    801185 <strtol+0xa0>
	else if (base == 0)
  801178:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80117c:	75 07                	jne    801185 <strtol+0xa0>
		base = 10;
  80117e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801185:	8b 45 08             	mov    0x8(%ebp),%eax
  801188:	8a 00                	mov    (%eax),%al
  80118a:	3c 2f                	cmp    $0x2f,%al
  80118c:	7e 19                	jle    8011a7 <strtol+0xc2>
  80118e:	8b 45 08             	mov    0x8(%ebp),%eax
  801191:	8a 00                	mov    (%eax),%al
  801193:	3c 39                	cmp    $0x39,%al
  801195:	7f 10                	jg     8011a7 <strtol+0xc2>
			dig = *s - '0';
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	8a 00                	mov    (%eax),%al
  80119c:	0f be c0             	movsbl %al,%eax
  80119f:	83 e8 30             	sub    $0x30,%eax
  8011a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011a5:	eb 42                	jmp    8011e9 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	8a 00                	mov    (%eax),%al
  8011ac:	3c 60                	cmp    $0x60,%al
  8011ae:	7e 19                	jle    8011c9 <strtol+0xe4>
  8011b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b3:	8a 00                	mov    (%eax),%al
  8011b5:	3c 7a                	cmp    $0x7a,%al
  8011b7:	7f 10                	jg     8011c9 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bc:	8a 00                	mov    (%eax),%al
  8011be:	0f be c0             	movsbl %al,%eax
  8011c1:	83 e8 57             	sub    $0x57,%eax
  8011c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011c7:	eb 20                	jmp    8011e9 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	8a 00                	mov    (%eax),%al
  8011ce:	3c 40                	cmp    $0x40,%al
  8011d0:	7e 39                	jle    80120b <strtol+0x126>
  8011d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d5:	8a 00                	mov    (%eax),%al
  8011d7:	3c 5a                	cmp    $0x5a,%al
  8011d9:	7f 30                	jg     80120b <strtol+0x126>
			dig = *s - 'A' + 10;
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	8a 00                	mov    (%eax),%al
  8011e0:	0f be c0             	movsbl %al,%eax
  8011e3:	83 e8 37             	sub    $0x37,%eax
  8011e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011ec:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011ef:	7d 19                	jge    80120a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011f1:	ff 45 08             	incl   0x8(%ebp)
  8011f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f7:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011fb:	89 c2                	mov    %eax,%edx
  8011fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801200:	01 d0                	add    %edx,%eax
  801202:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801205:	e9 7b ff ff ff       	jmp    801185 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80120a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80120b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80120f:	74 08                	je     801219 <strtol+0x134>
		*endptr = (char *) s;
  801211:	8b 45 0c             	mov    0xc(%ebp),%eax
  801214:	8b 55 08             	mov    0x8(%ebp),%edx
  801217:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801219:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80121d:	74 07                	je     801226 <strtol+0x141>
  80121f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801222:	f7 d8                	neg    %eax
  801224:	eb 03                	jmp    801229 <strtol+0x144>
  801226:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801229:	c9                   	leave  
  80122a:	c3                   	ret    

0080122b <ltostr>:

void
ltostr(long value, char *str)
{
  80122b:	55                   	push   %ebp
  80122c:	89 e5                	mov    %esp,%ebp
  80122e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801231:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801238:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80123f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801243:	79 13                	jns    801258 <ltostr+0x2d>
	{
		neg = 1;
  801245:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80124c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124f:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801252:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801255:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801258:	8b 45 08             	mov    0x8(%ebp),%eax
  80125b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801260:	99                   	cltd   
  801261:	f7 f9                	idiv   %ecx
  801263:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801266:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801269:	8d 50 01             	lea    0x1(%eax),%edx
  80126c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80126f:	89 c2                	mov    %eax,%edx
  801271:	8b 45 0c             	mov    0xc(%ebp),%eax
  801274:	01 d0                	add    %edx,%eax
  801276:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801279:	83 c2 30             	add    $0x30,%edx
  80127c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80127e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801281:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801286:	f7 e9                	imul   %ecx
  801288:	c1 fa 02             	sar    $0x2,%edx
  80128b:	89 c8                	mov    %ecx,%eax
  80128d:	c1 f8 1f             	sar    $0x1f,%eax
  801290:	29 c2                	sub    %eax,%edx
  801292:	89 d0                	mov    %edx,%eax
  801294:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801297:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80129a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80129f:	f7 e9                	imul   %ecx
  8012a1:	c1 fa 02             	sar    $0x2,%edx
  8012a4:	89 c8                	mov    %ecx,%eax
  8012a6:	c1 f8 1f             	sar    $0x1f,%eax
  8012a9:	29 c2                	sub    %eax,%edx
  8012ab:	89 d0                	mov    %edx,%eax
  8012ad:	c1 e0 02             	shl    $0x2,%eax
  8012b0:	01 d0                	add    %edx,%eax
  8012b2:	01 c0                	add    %eax,%eax
  8012b4:	29 c1                	sub    %eax,%ecx
  8012b6:	89 ca                	mov    %ecx,%edx
  8012b8:	85 d2                	test   %edx,%edx
  8012ba:	75 9c                	jne    801258 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c6:	48                   	dec    %eax
  8012c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012ca:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012ce:	74 3d                	je     80130d <ltostr+0xe2>
		start = 1 ;
  8012d0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012d7:	eb 34                	jmp    80130d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8012d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012df:	01 d0                	add    %edx,%eax
  8012e1:	8a 00                	mov    (%eax),%al
  8012e3:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ec:	01 c2                	add    %eax,%edx
  8012ee:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f4:	01 c8                	add    %ecx,%eax
  8012f6:	8a 00                	mov    (%eax),%al
  8012f8:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012fa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801300:	01 c2                	add    %eax,%edx
  801302:	8a 45 eb             	mov    -0x15(%ebp),%al
  801305:	88 02                	mov    %al,(%edx)
		start++ ;
  801307:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80130a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80130d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801310:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801313:	7c c4                	jl     8012d9 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801315:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801318:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131b:	01 d0                	add    %edx,%eax
  80131d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801320:	90                   	nop
  801321:	c9                   	leave  
  801322:	c3                   	ret    

00801323 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801323:	55                   	push   %ebp
  801324:	89 e5                	mov    %esp,%ebp
  801326:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801329:	ff 75 08             	pushl  0x8(%ebp)
  80132c:	e8 54 fa ff ff       	call   800d85 <strlen>
  801331:	83 c4 04             	add    $0x4,%esp
  801334:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801337:	ff 75 0c             	pushl  0xc(%ebp)
  80133a:	e8 46 fa ff ff       	call   800d85 <strlen>
  80133f:	83 c4 04             	add    $0x4,%esp
  801342:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801345:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80134c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801353:	eb 17                	jmp    80136c <strcconcat+0x49>
		final[s] = str1[s] ;
  801355:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801358:	8b 45 10             	mov    0x10(%ebp),%eax
  80135b:	01 c2                	add    %eax,%edx
  80135d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801360:	8b 45 08             	mov    0x8(%ebp),%eax
  801363:	01 c8                	add    %ecx,%eax
  801365:	8a 00                	mov    (%eax),%al
  801367:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801369:	ff 45 fc             	incl   -0x4(%ebp)
  80136c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80136f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801372:	7c e1                	jl     801355 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801374:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80137b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801382:	eb 1f                	jmp    8013a3 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801384:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801387:	8d 50 01             	lea    0x1(%eax),%edx
  80138a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80138d:	89 c2                	mov    %eax,%edx
  80138f:	8b 45 10             	mov    0x10(%ebp),%eax
  801392:	01 c2                	add    %eax,%edx
  801394:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801397:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139a:	01 c8                	add    %ecx,%eax
  80139c:	8a 00                	mov    (%eax),%al
  80139e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013a0:	ff 45 f8             	incl   -0x8(%ebp)
  8013a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013a6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013a9:	7c d9                	jl     801384 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013ab:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b1:	01 d0                	add    %edx,%eax
  8013b3:	c6 00 00             	movb   $0x0,(%eax)
}
  8013b6:	90                   	nop
  8013b7:	c9                   	leave  
  8013b8:	c3                   	ret    

008013b9 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013b9:	55                   	push   %ebp
  8013ba:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8013bf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8013c8:	8b 00                	mov    (%eax),%eax
  8013ca:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d4:	01 d0                	add    %edx,%eax
  8013d6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013dc:	eb 0c                	jmp    8013ea <strsplit+0x31>
			*string++ = 0;
  8013de:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e1:	8d 50 01             	lea    0x1(%eax),%edx
  8013e4:	89 55 08             	mov    %edx,0x8(%ebp)
  8013e7:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ed:	8a 00                	mov    (%eax),%al
  8013ef:	84 c0                	test   %al,%al
  8013f1:	74 18                	je     80140b <strsplit+0x52>
  8013f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f6:	8a 00                	mov    (%eax),%al
  8013f8:	0f be c0             	movsbl %al,%eax
  8013fb:	50                   	push   %eax
  8013fc:	ff 75 0c             	pushl  0xc(%ebp)
  8013ff:	e8 13 fb ff ff       	call   800f17 <strchr>
  801404:	83 c4 08             	add    $0x8,%esp
  801407:	85 c0                	test   %eax,%eax
  801409:	75 d3                	jne    8013de <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80140b:	8b 45 08             	mov    0x8(%ebp),%eax
  80140e:	8a 00                	mov    (%eax),%al
  801410:	84 c0                	test   %al,%al
  801412:	74 5a                	je     80146e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801414:	8b 45 14             	mov    0x14(%ebp),%eax
  801417:	8b 00                	mov    (%eax),%eax
  801419:	83 f8 0f             	cmp    $0xf,%eax
  80141c:	75 07                	jne    801425 <strsplit+0x6c>
		{
			return 0;
  80141e:	b8 00 00 00 00       	mov    $0x0,%eax
  801423:	eb 66                	jmp    80148b <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801425:	8b 45 14             	mov    0x14(%ebp),%eax
  801428:	8b 00                	mov    (%eax),%eax
  80142a:	8d 48 01             	lea    0x1(%eax),%ecx
  80142d:	8b 55 14             	mov    0x14(%ebp),%edx
  801430:	89 0a                	mov    %ecx,(%edx)
  801432:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801439:	8b 45 10             	mov    0x10(%ebp),%eax
  80143c:	01 c2                	add    %eax,%edx
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801443:	eb 03                	jmp    801448 <strsplit+0x8f>
			string++;
  801445:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801448:	8b 45 08             	mov    0x8(%ebp),%eax
  80144b:	8a 00                	mov    (%eax),%al
  80144d:	84 c0                	test   %al,%al
  80144f:	74 8b                	je     8013dc <strsplit+0x23>
  801451:	8b 45 08             	mov    0x8(%ebp),%eax
  801454:	8a 00                	mov    (%eax),%al
  801456:	0f be c0             	movsbl %al,%eax
  801459:	50                   	push   %eax
  80145a:	ff 75 0c             	pushl  0xc(%ebp)
  80145d:	e8 b5 fa ff ff       	call   800f17 <strchr>
  801462:	83 c4 08             	add    $0x8,%esp
  801465:	85 c0                	test   %eax,%eax
  801467:	74 dc                	je     801445 <strsplit+0x8c>
			string++;
	}
  801469:	e9 6e ff ff ff       	jmp    8013dc <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80146e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80146f:	8b 45 14             	mov    0x14(%ebp),%eax
  801472:	8b 00                	mov    (%eax),%eax
  801474:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80147b:	8b 45 10             	mov    0x10(%ebp),%eax
  80147e:	01 d0                	add    %edx,%eax
  801480:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801486:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80148b:	c9                   	leave  
  80148c:	c3                   	ret    

0080148d <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80148d:	55                   	push   %ebp
  80148e:	89 e5                	mov    %esp,%ebp
  801490:	83 ec 18             	sub    $0x18,%esp
  801493:	8b 45 10             	mov    0x10(%ebp),%eax
  801496:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801499:	83 ec 04             	sub    $0x4,%esp
  80149c:	68 f0 25 80 00       	push   $0x8025f0
  8014a1:	6a 17                	push   $0x17
  8014a3:	68 0f 26 80 00       	push   $0x80260f
  8014a8:	e8 8a 08 00 00       	call   801d37 <_panic>

008014ad <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8014ad:	55                   	push   %ebp
  8014ae:	89 e5                	mov    %esp,%ebp
  8014b0:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8014b3:	83 ec 04             	sub    $0x4,%esp
  8014b6:	68 1b 26 80 00       	push   $0x80261b
  8014bb:	6a 2f                	push   $0x2f
  8014bd:	68 0f 26 80 00       	push   $0x80260f
  8014c2:	e8 70 08 00 00       	call   801d37 <_panic>

008014c7 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8014c7:	55                   	push   %ebp
  8014c8:	89 e5                	mov    %esp,%ebp
  8014ca:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8014cd:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8014d4:	8b 55 08             	mov    0x8(%ebp),%edx
  8014d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014da:	01 d0                	add    %edx,%eax
  8014dc:	48                   	dec    %eax
  8014dd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8014e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014e3:	ba 00 00 00 00       	mov    $0x0,%edx
  8014e8:	f7 75 ec             	divl   -0x14(%ebp)
  8014eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014ee:	29 d0                	sub    %edx,%eax
  8014f0:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8014f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f6:	c1 e8 0c             	shr    $0xc,%eax
  8014f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8014fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801503:	e9 c8 00 00 00       	jmp    8015d0 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801508:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80150f:	eb 27                	jmp    801538 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801511:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801514:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801517:	01 c2                	add    %eax,%edx
  801519:	89 d0                	mov    %edx,%eax
  80151b:	01 c0                	add    %eax,%eax
  80151d:	01 d0                	add    %edx,%eax
  80151f:	c1 e0 02             	shl    $0x2,%eax
  801522:	05 48 30 80 00       	add    $0x803048,%eax
  801527:	8b 00                	mov    (%eax),%eax
  801529:	85 c0                	test   %eax,%eax
  80152b:	74 08                	je     801535 <malloc+0x6e>
            	i += j;
  80152d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801530:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801533:	eb 0b                	jmp    801540 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801535:	ff 45 f0             	incl   -0x10(%ebp)
  801538:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80153b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80153e:	72 d1                	jb     801511 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801540:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801543:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801546:	0f 85 81 00 00 00    	jne    8015cd <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  80154c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80154f:	05 00 00 08 00       	add    $0x80000,%eax
  801554:	c1 e0 0c             	shl    $0xc,%eax
  801557:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  80155a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801561:	eb 1f                	jmp    801582 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801563:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801566:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801569:	01 c2                	add    %eax,%edx
  80156b:	89 d0                	mov    %edx,%eax
  80156d:	01 c0                	add    %eax,%eax
  80156f:	01 d0                	add    %edx,%eax
  801571:	c1 e0 02             	shl    $0x2,%eax
  801574:	05 48 30 80 00       	add    $0x803048,%eax
  801579:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80157f:	ff 45 f0             	incl   -0x10(%ebp)
  801582:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801585:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801588:	72 d9                	jb     801563 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80158a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80158d:	89 d0                	mov    %edx,%eax
  80158f:	01 c0                	add    %eax,%eax
  801591:	01 d0                	add    %edx,%eax
  801593:	c1 e0 02             	shl    $0x2,%eax
  801596:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  80159c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80159f:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8015a1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8015a4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8015a7:	89 c8                	mov    %ecx,%eax
  8015a9:	01 c0                	add    %eax,%eax
  8015ab:	01 c8                	add    %ecx,%eax
  8015ad:	c1 e0 02             	shl    $0x2,%eax
  8015b0:	05 44 30 80 00       	add    $0x803044,%eax
  8015b5:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8015b7:	83 ec 08             	sub    $0x8,%esp
  8015ba:	ff 75 08             	pushl  0x8(%ebp)
  8015bd:	ff 75 e0             	pushl  -0x20(%ebp)
  8015c0:	e8 2b 03 00 00       	call   8018f0 <sys_allocateMem>
  8015c5:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8015c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015cb:	eb 19                	jmp    8015e6 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8015cd:	ff 45 f4             	incl   -0xc(%ebp)
  8015d0:	a1 04 30 80 00       	mov    0x803004,%eax
  8015d5:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8015d8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015db:	0f 83 27 ff ff ff    	jae    801508 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8015e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e6:	c9                   	leave  
  8015e7:	c3                   	ret    

008015e8 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8015e8:	55                   	push   %ebp
  8015e9:	89 e5                	mov    %esp,%ebp
  8015eb:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8015ee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015f2:	0f 84 e5 00 00 00    	je     8016dd <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8015fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801601:	05 00 00 00 80       	add    $0x80000000,%eax
  801606:	c1 e8 0c             	shr    $0xc,%eax
  801609:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  80160c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80160f:	89 d0                	mov    %edx,%eax
  801611:	01 c0                	add    %eax,%eax
  801613:	01 d0                	add    %edx,%eax
  801615:	c1 e0 02             	shl    $0x2,%eax
  801618:	05 40 30 80 00       	add    $0x803040,%eax
  80161d:	8b 00                	mov    (%eax),%eax
  80161f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801622:	0f 85 b8 00 00 00    	jne    8016e0 <free+0xf8>
  801628:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80162b:	89 d0                	mov    %edx,%eax
  80162d:	01 c0                	add    %eax,%eax
  80162f:	01 d0                	add    %edx,%eax
  801631:	c1 e0 02             	shl    $0x2,%eax
  801634:	05 48 30 80 00       	add    $0x803048,%eax
  801639:	8b 00                	mov    (%eax),%eax
  80163b:	85 c0                	test   %eax,%eax
  80163d:	0f 84 9d 00 00 00    	je     8016e0 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801643:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801646:	89 d0                	mov    %edx,%eax
  801648:	01 c0                	add    %eax,%eax
  80164a:	01 d0                	add    %edx,%eax
  80164c:	c1 e0 02             	shl    $0x2,%eax
  80164f:	05 44 30 80 00       	add    $0x803044,%eax
  801654:	8b 00                	mov    (%eax),%eax
  801656:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801659:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80165c:	c1 e0 0c             	shl    $0xc,%eax
  80165f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801662:	83 ec 08             	sub    $0x8,%esp
  801665:	ff 75 e4             	pushl  -0x1c(%ebp)
  801668:	ff 75 f0             	pushl  -0x10(%ebp)
  80166b:	e8 64 02 00 00       	call   8018d4 <sys_freeMem>
  801670:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801673:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80167a:	eb 57                	jmp    8016d3 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  80167c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80167f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801682:	01 c2                	add    %eax,%edx
  801684:	89 d0                	mov    %edx,%eax
  801686:	01 c0                	add    %eax,%eax
  801688:	01 d0                	add    %edx,%eax
  80168a:	c1 e0 02             	shl    $0x2,%eax
  80168d:	05 48 30 80 00       	add    $0x803048,%eax
  801692:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801698:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80169b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80169e:	01 c2                	add    %eax,%edx
  8016a0:	89 d0                	mov    %edx,%eax
  8016a2:	01 c0                	add    %eax,%eax
  8016a4:	01 d0                	add    %edx,%eax
  8016a6:	c1 e0 02             	shl    $0x2,%eax
  8016a9:	05 40 30 80 00       	add    $0x803040,%eax
  8016ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8016b4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016ba:	01 c2                	add    %eax,%edx
  8016bc:	89 d0                	mov    %edx,%eax
  8016be:	01 c0                	add    %eax,%eax
  8016c0:	01 d0                	add    %edx,%eax
  8016c2:	c1 e0 02             	shl    $0x2,%eax
  8016c5:	05 44 30 80 00       	add    $0x803044,%eax
  8016ca:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8016d0:	ff 45 f4             	incl   -0xc(%ebp)
  8016d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016d6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8016d9:	7c a1                	jl     80167c <free+0x94>
  8016db:	eb 04                	jmp    8016e1 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8016dd:	90                   	nop
  8016de:	eb 01                	jmp    8016e1 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8016e0:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8016e1:	c9                   	leave  
  8016e2:	c3                   	ret    

008016e3 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8016e3:	55                   	push   %ebp
  8016e4:	89 e5                	mov    %esp,%ebp
  8016e6:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8016e9:	83 ec 04             	sub    $0x4,%esp
  8016ec:	68 38 26 80 00       	push   $0x802638
  8016f1:	68 ae 00 00 00       	push   $0xae
  8016f6:	68 0f 26 80 00       	push   $0x80260f
  8016fb:	e8 37 06 00 00       	call   801d37 <_panic>

00801700 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801700:	55                   	push   %ebp
  801701:	89 e5                	mov    %esp,%ebp
  801703:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801706:	83 ec 04             	sub    $0x4,%esp
  801709:	68 58 26 80 00       	push   $0x802658
  80170e:	68 ca 00 00 00       	push   $0xca
  801713:	68 0f 26 80 00       	push   $0x80260f
  801718:	e8 1a 06 00 00       	call   801d37 <_panic>

0080171d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80171d:	55                   	push   %ebp
  80171e:	89 e5                	mov    %esp,%ebp
  801720:	57                   	push   %edi
  801721:	56                   	push   %esi
  801722:	53                   	push   %ebx
  801723:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801726:	8b 45 08             	mov    0x8(%ebp),%eax
  801729:	8b 55 0c             	mov    0xc(%ebp),%edx
  80172c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80172f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801732:	8b 7d 18             	mov    0x18(%ebp),%edi
  801735:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801738:	cd 30                	int    $0x30
  80173a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80173d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801740:	83 c4 10             	add    $0x10,%esp
  801743:	5b                   	pop    %ebx
  801744:	5e                   	pop    %esi
  801745:	5f                   	pop    %edi
  801746:	5d                   	pop    %ebp
  801747:	c3                   	ret    

00801748 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
  80174b:	83 ec 04             	sub    $0x4,%esp
  80174e:	8b 45 10             	mov    0x10(%ebp),%eax
  801751:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801754:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801758:	8b 45 08             	mov    0x8(%ebp),%eax
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	52                   	push   %edx
  801760:	ff 75 0c             	pushl  0xc(%ebp)
  801763:	50                   	push   %eax
  801764:	6a 00                	push   $0x0
  801766:	e8 b2 ff ff ff       	call   80171d <syscall>
  80176b:	83 c4 18             	add    $0x18,%esp
}
  80176e:	90                   	nop
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <sys_cgetc>:

int
sys_cgetc(void)
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 01                	push   $0x1
  801780:	e8 98 ff ff ff       	call   80171d <syscall>
  801785:	83 c4 18             	add    $0x18,%esp
}
  801788:	c9                   	leave  
  801789:	c3                   	ret    

0080178a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80178a:	55                   	push   %ebp
  80178b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80178d:	8b 45 08             	mov    0x8(%ebp),%eax
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	50                   	push   %eax
  801799:	6a 05                	push   $0x5
  80179b:	e8 7d ff ff ff       	call   80171d <syscall>
  8017a0:	83 c4 18             	add    $0x18,%esp
}
  8017a3:	c9                   	leave  
  8017a4:	c3                   	ret    

008017a5 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017a5:	55                   	push   %ebp
  8017a6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 02                	push   $0x2
  8017b4:	e8 64 ff ff ff       	call   80171d <syscall>
  8017b9:	83 c4 18             	add    $0x18,%esp
}
  8017bc:	c9                   	leave  
  8017bd:	c3                   	ret    

008017be <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017be:	55                   	push   %ebp
  8017bf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 03                	push   $0x3
  8017cd:	e8 4b ff ff ff       	call   80171d <syscall>
  8017d2:	83 c4 18             	add    $0x18,%esp
}
  8017d5:	c9                   	leave  
  8017d6:	c3                   	ret    

008017d7 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 04                	push   $0x4
  8017e6:	e8 32 ff ff ff       	call   80171d <syscall>
  8017eb:	83 c4 18             	add    $0x18,%esp
}
  8017ee:	c9                   	leave  
  8017ef:	c3                   	ret    

008017f0 <sys_env_exit>:


void sys_env_exit(void)
{
  8017f0:	55                   	push   %ebp
  8017f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 06                	push   $0x6
  8017ff:	e8 19 ff ff ff       	call   80171d <syscall>
  801804:	83 c4 18             	add    $0x18,%esp
}
  801807:	90                   	nop
  801808:	c9                   	leave  
  801809:	c3                   	ret    

0080180a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80180a:	55                   	push   %ebp
  80180b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80180d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801810:	8b 45 08             	mov    0x8(%ebp),%eax
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	52                   	push   %edx
  80181a:	50                   	push   %eax
  80181b:	6a 07                	push   $0x7
  80181d:	e8 fb fe ff ff       	call   80171d <syscall>
  801822:	83 c4 18             	add    $0x18,%esp
}
  801825:	c9                   	leave  
  801826:	c3                   	ret    

00801827 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801827:	55                   	push   %ebp
  801828:	89 e5                	mov    %esp,%ebp
  80182a:	56                   	push   %esi
  80182b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80182c:	8b 75 18             	mov    0x18(%ebp),%esi
  80182f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801832:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801835:	8b 55 0c             	mov    0xc(%ebp),%edx
  801838:	8b 45 08             	mov    0x8(%ebp),%eax
  80183b:	56                   	push   %esi
  80183c:	53                   	push   %ebx
  80183d:	51                   	push   %ecx
  80183e:	52                   	push   %edx
  80183f:	50                   	push   %eax
  801840:	6a 08                	push   $0x8
  801842:	e8 d6 fe ff ff       	call   80171d <syscall>
  801847:	83 c4 18             	add    $0x18,%esp
}
  80184a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80184d:	5b                   	pop    %ebx
  80184e:	5e                   	pop    %esi
  80184f:	5d                   	pop    %ebp
  801850:	c3                   	ret    

00801851 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801851:	55                   	push   %ebp
  801852:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801854:	8b 55 0c             	mov    0xc(%ebp),%edx
  801857:	8b 45 08             	mov    0x8(%ebp),%eax
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	52                   	push   %edx
  801861:	50                   	push   %eax
  801862:	6a 09                	push   $0x9
  801864:	e8 b4 fe ff ff       	call   80171d <syscall>
  801869:	83 c4 18             	add    $0x18,%esp
}
  80186c:	c9                   	leave  
  80186d:	c3                   	ret    

0080186e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80186e:	55                   	push   %ebp
  80186f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	ff 75 0c             	pushl  0xc(%ebp)
  80187a:	ff 75 08             	pushl  0x8(%ebp)
  80187d:	6a 0a                	push   $0xa
  80187f:	e8 99 fe ff ff       	call   80171d <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
}
  801887:	c9                   	leave  
  801888:	c3                   	ret    

00801889 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801889:	55                   	push   %ebp
  80188a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	6a 0b                	push   $0xb
  801898:	e8 80 fe ff ff       	call   80171d <syscall>
  80189d:	83 c4 18             	add    $0x18,%esp
}
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 0c                	push   $0xc
  8018b1:	e8 67 fe ff ff       	call   80171d <syscall>
  8018b6:	83 c4 18             	add    $0x18,%esp
}
  8018b9:	c9                   	leave  
  8018ba:	c3                   	ret    

008018bb <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018bb:	55                   	push   %ebp
  8018bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 0d                	push   $0xd
  8018ca:	e8 4e fe ff ff       	call   80171d <syscall>
  8018cf:	83 c4 18             	add    $0x18,%esp
}
  8018d2:	c9                   	leave  
  8018d3:	c3                   	ret    

008018d4 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018d4:	55                   	push   %ebp
  8018d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	ff 75 0c             	pushl  0xc(%ebp)
  8018e0:	ff 75 08             	pushl  0x8(%ebp)
  8018e3:	6a 11                	push   $0x11
  8018e5:	e8 33 fe ff ff       	call   80171d <syscall>
  8018ea:	83 c4 18             	add    $0x18,%esp
	return;
  8018ed:	90                   	nop
}
  8018ee:	c9                   	leave  
  8018ef:	c3                   	ret    

008018f0 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018f0:	55                   	push   %ebp
  8018f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	ff 75 0c             	pushl  0xc(%ebp)
  8018fc:	ff 75 08             	pushl  0x8(%ebp)
  8018ff:	6a 12                	push   $0x12
  801901:	e8 17 fe ff ff       	call   80171d <syscall>
  801906:	83 c4 18             	add    $0x18,%esp
	return ;
  801909:	90                   	nop
}
  80190a:	c9                   	leave  
  80190b:	c3                   	ret    

0080190c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80190c:	55                   	push   %ebp
  80190d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 0e                	push   $0xe
  80191b:	e8 fd fd ff ff       	call   80171d <syscall>
  801920:	83 c4 18             	add    $0x18,%esp
}
  801923:	c9                   	leave  
  801924:	c3                   	ret    

00801925 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801925:	55                   	push   %ebp
  801926:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	ff 75 08             	pushl  0x8(%ebp)
  801933:	6a 0f                	push   $0xf
  801935:	e8 e3 fd ff ff       	call   80171d <syscall>
  80193a:	83 c4 18             	add    $0x18,%esp
}
  80193d:	c9                   	leave  
  80193e:	c3                   	ret    

0080193f <sys_scarce_memory>:

void sys_scarce_memory()
{
  80193f:	55                   	push   %ebp
  801940:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801942:	6a 00                	push   $0x0
  801944:	6a 00                	push   $0x0
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 10                	push   $0x10
  80194e:	e8 ca fd ff ff       	call   80171d <syscall>
  801953:	83 c4 18             	add    $0x18,%esp
}
  801956:	90                   	nop
  801957:	c9                   	leave  
  801958:	c3                   	ret    

00801959 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801959:	55                   	push   %ebp
  80195a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 14                	push   $0x14
  801968:	e8 b0 fd ff ff       	call   80171d <syscall>
  80196d:	83 c4 18             	add    $0x18,%esp
}
  801970:	90                   	nop
  801971:	c9                   	leave  
  801972:	c3                   	ret    

00801973 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801973:	55                   	push   %ebp
  801974:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801976:	6a 00                	push   $0x0
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 15                	push   $0x15
  801982:	e8 96 fd ff ff       	call   80171d <syscall>
  801987:	83 c4 18             	add    $0x18,%esp
}
  80198a:	90                   	nop
  80198b:	c9                   	leave  
  80198c:	c3                   	ret    

0080198d <sys_cputc>:


void
sys_cputc(const char c)
{
  80198d:	55                   	push   %ebp
  80198e:	89 e5                	mov    %esp,%ebp
  801990:	83 ec 04             	sub    $0x4,%esp
  801993:	8b 45 08             	mov    0x8(%ebp),%eax
  801996:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801999:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	50                   	push   %eax
  8019a6:	6a 16                	push   $0x16
  8019a8:	e8 70 fd ff ff       	call   80171d <syscall>
  8019ad:	83 c4 18             	add    $0x18,%esp
}
  8019b0:	90                   	nop
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 17                	push   $0x17
  8019c2:	e8 56 fd ff ff       	call   80171d <syscall>
  8019c7:	83 c4 18             	add    $0x18,%esp
}
  8019ca:	90                   	nop
  8019cb:	c9                   	leave  
  8019cc:	c3                   	ret    

008019cd <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019cd:	55                   	push   %ebp
  8019ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	ff 75 0c             	pushl  0xc(%ebp)
  8019dc:	50                   	push   %eax
  8019dd:	6a 18                	push   $0x18
  8019df:	e8 39 fd ff ff       	call   80171d <syscall>
  8019e4:	83 c4 18             	add    $0x18,%esp
}
  8019e7:	c9                   	leave  
  8019e8:	c3                   	ret    

008019e9 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019e9:	55                   	push   %ebp
  8019ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	52                   	push   %edx
  8019f9:	50                   	push   %eax
  8019fa:	6a 1b                	push   $0x1b
  8019fc:	e8 1c fd ff ff       	call   80171d <syscall>
  801a01:	83 c4 18             	add    $0x18,%esp
}
  801a04:	c9                   	leave  
  801a05:	c3                   	ret    

00801a06 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a06:	55                   	push   %ebp
  801a07:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a09:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	52                   	push   %edx
  801a16:	50                   	push   %eax
  801a17:	6a 19                	push   $0x19
  801a19:	e8 ff fc ff ff       	call   80171d <syscall>
  801a1e:	83 c4 18             	add    $0x18,%esp
}
  801a21:	90                   	nop
  801a22:	c9                   	leave  
  801a23:	c3                   	ret    

00801a24 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a24:	55                   	push   %ebp
  801a25:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a27:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	52                   	push   %edx
  801a34:	50                   	push   %eax
  801a35:	6a 1a                	push   $0x1a
  801a37:	e8 e1 fc ff ff       	call   80171d <syscall>
  801a3c:	83 c4 18             	add    $0x18,%esp
}
  801a3f:	90                   	nop
  801a40:	c9                   	leave  
  801a41:	c3                   	ret    

00801a42 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a42:	55                   	push   %ebp
  801a43:	89 e5                	mov    %esp,%ebp
  801a45:	83 ec 04             	sub    $0x4,%esp
  801a48:	8b 45 10             	mov    0x10(%ebp),%eax
  801a4b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a4e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a51:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a55:	8b 45 08             	mov    0x8(%ebp),%eax
  801a58:	6a 00                	push   $0x0
  801a5a:	51                   	push   %ecx
  801a5b:	52                   	push   %edx
  801a5c:	ff 75 0c             	pushl  0xc(%ebp)
  801a5f:	50                   	push   %eax
  801a60:	6a 1c                	push   $0x1c
  801a62:	e8 b6 fc ff ff       	call   80171d <syscall>
  801a67:	83 c4 18             	add    $0x18,%esp
}
  801a6a:	c9                   	leave  
  801a6b:	c3                   	ret    

00801a6c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a6c:	55                   	push   %ebp
  801a6d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a72:	8b 45 08             	mov    0x8(%ebp),%eax
  801a75:	6a 00                	push   $0x0
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	52                   	push   %edx
  801a7c:	50                   	push   %eax
  801a7d:	6a 1d                	push   $0x1d
  801a7f:	e8 99 fc ff ff       	call   80171d <syscall>
  801a84:	83 c4 18             	add    $0x18,%esp
}
  801a87:	c9                   	leave  
  801a88:	c3                   	ret    

00801a89 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a89:	55                   	push   %ebp
  801a8a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a8c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a92:	8b 45 08             	mov    0x8(%ebp),%eax
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	51                   	push   %ecx
  801a9a:	52                   	push   %edx
  801a9b:	50                   	push   %eax
  801a9c:	6a 1e                	push   $0x1e
  801a9e:	e8 7a fc ff ff       	call   80171d <syscall>
  801aa3:	83 c4 18             	add    $0x18,%esp
}
  801aa6:	c9                   	leave  
  801aa7:	c3                   	ret    

00801aa8 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801aa8:	55                   	push   %ebp
  801aa9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801aab:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aae:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	52                   	push   %edx
  801ab8:	50                   	push   %eax
  801ab9:	6a 1f                	push   $0x1f
  801abb:	e8 5d fc ff ff       	call   80171d <syscall>
  801ac0:	83 c4 18             	add    $0x18,%esp
}
  801ac3:	c9                   	leave  
  801ac4:	c3                   	ret    

00801ac5 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ac5:	55                   	push   %ebp
  801ac6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 20                	push   $0x20
  801ad4:	e8 44 fc ff ff       	call   80171d <syscall>
  801ad9:	83 c4 18             	add    $0x18,%esp
}
  801adc:	c9                   	leave  
  801add:	c3                   	ret    

00801ade <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801ade:	55                   	push   %ebp
  801adf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	ff 75 10             	pushl  0x10(%ebp)
  801aeb:	ff 75 0c             	pushl  0xc(%ebp)
  801aee:	50                   	push   %eax
  801aef:	6a 21                	push   $0x21
  801af1:	e8 27 fc ff ff       	call   80171d <syscall>
  801af6:	83 c4 18             	add    $0x18,%esp
}
  801af9:	c9                   	leave  
  801afa:	c3                   	ret    

00801afb <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801afb:	55                   	push   %ebp
  801afc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801afe:	8b 45 08             	mov    0x8(%ebp),%eax
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	50                   	push   %eax
  801b0a:	6a 22                	push   $0x22
  801b0c:	e8 0c fc ff ff       	call   80171d <syscall>
  801b11:	83 c4 18             	add    $0x18,%esp
}
  801b14:	90                   	nop
  801b15:	c9                   	leave  
  801b16:	c3                   	ret    

00801b17 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b17:	55                   	push   %ebp
  801b18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	50                   	push   %eax
  801b26:	6a 23                	push   $0x23
  801b28:	e8 f0 fb ff ff       	call   80171d <syscall>
  801b2d:	83 c4 18             	add    $0x18,%esp
}
  801b30:	90                   	nop
  801b31:	c9                   	leave  
  801b32:	c3                   	ret    

00801b33 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b33:	55                   	push   %ebp
  801b34:	89 e5                	mov    %esp,%ebp
  801b36:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b39:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b3c:	8d 50 04             	lea    0x4(%eax),%edx
  801b3f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	52                   	push   %edx
  801b49:	50                   	push   %eax
  801b4a:	6a 24                	push   $0x24
  801b4c:	e8 cc fb ff ff       	call   80171d <syscall>
  801b51:	83 c4 18             	add    $0x18,%esp
	return result;
  801b54:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b57:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b5a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b5d:	89 01                	mov    %eax,(%ecx)
  801b5f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b62:	8b 45 08             	mov    0x8(%ebp),%eax
  801b65:	c9                   	leave  
  801b66:	c2 04 00             	ret    $0x4

00801b69 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b69:	55                   	push   %ebp
  801b6a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b6c:	6a 00                	push   $0x0
  801b6e:	6a 00                	push   $0x0
  801b70:	ff 75 10             	pushl  0x10(%ebp)
  801b73:	ff 75 0c             	pushl  0xc(%ebp)
  801b76:	ff 75 08             	pushl  0x8(%ebp)
  801b79:	6a 13                	push   $0x13
  801b7b:	e8 9d fb ff ff       	call   80171d <syscall>
  801b80:	83 c4 18             	add    $0x18,%esp
	return ;
  801b83:	90                   	nop
}
  801b84:	c9                   	leave  
  801b85:	c3                   	ret    

00801b86 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b86:	55                   	push   %ebp
  801b87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 25                	push   $0x25
  801b95:	e8 83 fb ff ff       	call   80171d <syscall>
  801b9a:	83 c4 18             	add    $0x18,%esp
}
  801b9d:	c9                   	leave  
  801b9e:	c3                   	ret    

00801b9f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b9f:	55                   	push   %ebp
  801ba0:	89 e5                	mov    %esp,%ebp
  801ba2:	83 ec 04             	sub    $0x4,%esp
  801ba5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801bab:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	50                   	push   %eax
  801bb8:	6a 26                	push   $0x26
  801bba:	e8 5e fb ff ff       	call   80171d <syscall>
  801bbf:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc2:	90                   	nop
}
  801bc3:	c9                   	leave  
  801bc4:	c3                   	ret    

00801bc5 <rsttst>:
void rsttst()
{
  801bc5:	55                   	push   %ebp
  801bc6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 28                	push   $0x28
  801bd4:	e8 44 fb ff ff       	call   80171d <syscall>
  801bd9:	83 c4 18             	add    $0x18,%esp
	return ;
  801bdc:	90                   	nop
}
  801bdd:	c9                   	leave  
  801bde:	c3                   	ret    

00801bdf <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bdf:	55                   	push   %ebp
  801be0:	89 e5                	mov    %esp,%ebp
  801be2:	83 ec 04             	sub    $0x4,%esp
  801be5:	8b 45 14             	mov    0x14(%ebp),%eax
  801be8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801beb:	8b 55 18             	mov    0x18(%ebp),%edx
  801bee:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bf2:	52                   	push   %edx
  801bf3:	50                   	push   %eax
  801bf4:	ff 75 10             	pushl  0x10(%ebp)
  801bf7:	ff 75 0c             	pushl  0xc(%ebp)
  801bfa:	ff 75 08             	pushl  0x8(%ebp)
  801bfd:	6a 27                	push   $0x27
  801bff:	e8 19 fb ff ff       	call   80171d <syscall>
  801c04:	83 c4 18             	add    $0x18,%esp
	return ;
  801c07:	90                   	nop
}
  801c08:	c9                   	leave  
  801c09:	c3                   	ret    

00801c0a <chktst>:
void chktst(uint32 n)
{
  801c0a:	55                   	push   %ebp
  801c0b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	ff 75 08             	pushl  0x8(%ebp)
  801c18:	6a 29                	push   $0x29
  801c1a:	e8 fe fa ff ff       	call   80171d <syscall>
  801c1f:	83 c4 18             	add    $0x18,%esp
	return ;
  801c22:	90                   	nop
}
  801c23:	c9                   	leave  
  801c24:	c3                   	ret    

00801c25 <inctst>:

void inctst()
{
  801c25:	55                   	push   %ebp
  801c26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c28:	6a 00                	push   $0x0
  801c2a:	6a 00                	push   $0x0
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 2a                	push   $0x2a
  801c34:	e8 e4 fa ff ff       	call   80171d <syscall>
  801c39:	83 c4 18             	add    $0x18,%esp
	return ;
  801c3c:	90                   	nop
}
  801c3d:	c9                   	leave  
  801c3e:	c3                   	ret    

00801c3f <gettst>:
uint32 gettst()
{
  801c3f:	55                   	push   %ebp
  801c40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 2b                	push   $0x2b
  801c4e:	e8 ca fa ff ff       	call   80171d <syscall>
  801c53:	83 c4 18             	add    $0x18,%esp
}
  801c56:	c9                   	leave  
  801c57:	c3                   	ret    

00801c58 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c58:	55                   	push   %ebp
  801c59:	89 e5                	mov    %esp,%ebp
  801c5b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 00                	push   $0x0
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 00                	push   $0x0
  801c68:	6a 2c                	push   $0x2c
  801c6a:	e8 ae fa ff ff       	call   80171d <syscall>
  801c6f:	83 c4 18             	add    $0x18,%esp
  801c72:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c75:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c79:	75 07                	jne    801c82 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c7b:	b8 01 00 00 00       	mov    $0x1,%eax
  801c80:	eb 05                	jmp    801c87 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c82:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c87:	c9                   	leave  
  801c88:	c3                   	ret    

00801c89 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c89:	55                   	push   %ebp
  801c8a:	89 e5                	mov    %esp,%ebp
  801c8c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	6a 2c                	push   $0x2c
  801c9b:	e8 7d fa ff ff       	call   80171d <syscall>
  801ca0:	83 c4 18             	add    $0x18,%esp
  801ca3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801ca6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801caa:	75 07                	jne    801cb3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801cac:	b8 01 00 00 00       	mov    $0x1,%eax
  801cb1:	eb 05                	jmp    801cb8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801cb3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cb8:	c9                   	leave  
  801cb9:	c3                   	ret    

00801cba <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801cba:	55                   	push   %ebp
  801cbb:	89 e5                	mov    %esp,%ebp
  801cbd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 2c                	push   $0x2c
  801ccc:	e8 4c fa ff ff       	call   80171d <syscall>
  801cd1:	83 c4 18             	add    $0x18,%esp
  801cd4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cd7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cdb:	75 07                	jne    801ce4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cdd:	b8 01 00 00 00       	mov    $0x1,%eax
  801ce2:	eb 05                	jmp    801ce9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ce4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ce9:	c9                   	leave  
  801cea:	c3                   	ret    

00801ceb <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ceb:	55                   	push   %ebp
  801cec:	89 e5                	mov    %esp,%ebp
  801cee:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 2c                	push   $0x2c
  801cfd:	e8 1b fa ff ff       	call   80171d <syscall>
  801d02:	83 c4 18             	add    $0x18,%esp
  801d05:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d08:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d0c:	75 07                	jne    801d15 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d0e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d13:	eb 05                	jmp    801d1a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d15:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d1a:	c9                   	leave  
  801d1b:	c3                   	ret    

00801d1c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d1c:	55                   	push   %ebp
  801d1d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	6a 00                	push   $0x0
  801d25:	6a 00                	push   $0x0
  801d27:	ff 75 08             	pushl  0x8(%ebp)
  801d2a:	6a 2d                	push   $0x2d
  801d2c:	e8 ec f9 ff ff       	call   80171d <syscall>
  801d31:	83 c4 18             	add    $0x18,%esp
	return ;
  801d34:	90                   	nop
}
  801d35:	c9                   	leave  
  801d36:	c3                   	ret    

00801d37 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801d37:	55                   	push   %ebp
  801d38:	89 e5                	mov    %esp,%ebp
  801d3a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801d3d:	8d 45 10             	lea    0x10(%ebp),%eax
  801d40:	83 c0 04             	add    $0x4,%eax
  801d43:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801d46:	a1 40 30 98 00       	mov    0x983040,%eax
  801d4b:	85 c0                	test   %eax,%eax
  801d4d:	74 16                	je     801d65 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801d4f:	a1 40 30 98 00       	mov    0x983040,%eax
  801d54:	83 ec 08             	sub    $0x8,%esp
  801d57:	50                   	push   %eax
  801d58:	68 7c 26 80 00       	push   $0x80267c
  801d5d:	e8 a1 e9 ff ff       	call   800703 <cprintf>
  801d62:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801d65:	a1 00 30 80 00       	mov    0x803000,%eax
  801d6a:	ff 75 0c             	pushl  0xc(%ebp)
  801d6d:	ff 75 08             	pushl  0x8(%ebp)
  801d70:	50                   	push   %eax
  801d71:	68 81 26 80 00       	push   $0x802681
  801d76:	e8 88 e9 ff ff       	call   800703 <cprintf>
  801d7b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801d7e:	8b 45 10             	mov    0x10(%ebp),%eax
  801d81:	83 ec 08             	sub    $0x8,%esp
  801d84:	ff 75 f4             	pushl  -0xc(%ebp)
  801d87:	50                   	push   %eax
  801d88:	e8 0b e9 ff ff       	call   800698 <vcprintf>
  801d8d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801d90:	83 ec 08             	sub    $0x8,%esp
  801d93:	6a 00                	push   $0x0
  801d95:	68 9d 26 80 00       	push   $0x80269d
  801d9a:	e8 f9 e8 ff ff       	call   800698 <vcprintf>
  801d9f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801da2:	e8 7a e8 ff ff       	call   800621 <exit>

	// should not return here
	while (1) ;
  801da7:	eb fe                	jmp    801da7 <_panic+0x70>

00801da9 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801da9:	55                   	push   %ebp
  801daa:	89 e5                	mov    %esp,%ebp
  801dac:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801daf:	a1 20 30 80 00       	mov    0x803020,%eax
  801db4:	8b 50 74             	mov    0x74(%eax),%edx
  801db7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dba:	39 c2                	cmp    %eax,%edx
  801dbc:	74 14                	je     801dd2 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801dbe:	83 ec 04             	sub    $0x4,%esp
  801dc1:	68 a0 26 80 00       	push   $0x8026a0
  801dc6:	6a 26                	push   $0x26
  801dc8:	68 ec 26 80 00       	push   $0x8026ec
  801dcd:	e8 65 ff ff ff       	call   801d37 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801dd2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801dd9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801de0:	e9 c2 00 00 00       	jmp    801ea7 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801de5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801de8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801def:	8b 45 08             	mov    0x8(%ebp),%eax
  801df2:	01 d0                	add    %edx,%eax
  801df4:	8b 00                	mov    (%eax),%eax
  801df6:	85 c0                	test   %eax,%eax
  801df8:	75 08                	jne    801e02 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801dfa:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801dfd:	e9 a2 00 00 00       	jmp    801ea4 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801e02:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e09:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801e10:	eb 69                	jmp    801e7b <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801e12:	a1 20 30 80 00       	mov    0x803020,%eax
  801e17:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801e1d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801e20:	89 d0                	mov    %edx,%eax
  801e22:	01 c0                	add    %eax,%eax
  801e24:	01 d0                	add    %edx,%eax
  801e26:	c1 e0 02             	shl    $0x2,%eax
  801e29:	01 c8                	add    %ecx,%eax
  801e2b:	8a 40 04             	mov    0x4(%eax),%al
  801e2e:	84 c0                	test   %al,%al
  801e30:	75 46                	jne    801e78 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801e32:	a1 20 30 80 00       	mov    0x803020,%eax
  801e37:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801e3d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801e40:	89 d0                	mov    %edx,%eax
  801e42:	01 c0                	add    %eax,%eax
  801e44:	01 d0                	add    %edx,%eax
  801e46:	c1 e0 02             	shl    $0x2,%eax
  801e49:	01 c8                	add    %ecx,%eax
  801e4b:	8b 00                	mov    (%eax),%eax
  801e4d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801e50:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801e53:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801e58:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801e5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e5d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801e64:	8b 45 08             	mov    0x8(%ebp),%eax
  801e67:	01 c8                	add    %ecx,%eax
  801e69:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801e6b:	39 c2                	cmp    %eax,%edx
  801e6d:	75 09                	jne    801e78 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801e6f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801e76:	eb 12                	jmp    801e8a <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e78:	ff 45 e8             	incl   -0x18(%ebp)
  801e7b:	a1 20 30 80 00       	mov    0x803020,%eax
  801e80:	8b 50 74             	mov    0x74(%eax),%edx
  801e83:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e86:	39 c2                	cmp    %eax,%edx
  801e88:	77 88                	ja     801e12 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801e8a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801e8e:	75 14                	jne    801ea4 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801e90:	83 ec 04             	sub    $0x4,%esp
  801e93:	68 f8 26 80 00       	push   $0x8026f8
  801e98:	6a 3a                	push   $0x3a
  801e9a:	68 ec 26 80 00       	push   $0x8026ec
  801e9f:	e8 93 fe ff ff       	call   801d37 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801ea4:	ff 45 f0             	incl   -0x10(%ebp)
  801ea7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801eaa:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801ead:	0f 8c 32 ff ff ff    	jl     801de5 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801eb3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801eba:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801ec1:	eb 26                	jmp    801ee9 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801ec3:	a1 20 30 80 00       	mov    0x803020,%eax
  801ec8:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801ece:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801ed1:	89 d0                	mov    %edx,%eax
  801ed3:	01 c0                	add    %eax,%eax
  801ed5:	01 d0                	add    %edx,%eax
  801ed7:	c1 e0 02             	shl    $0x2,%eax
  801eda:	01 c8                	add    %ecx,%eax
  801edc:	8a 40 04             	mov    0x4(%eax),%al
  801edf:	3c 01                	cmp    $0x1,%al
  801ee1:	75 03                	jne    801ee6 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801ee3:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ee6:	ff 45 e0             	incl   -0x20(%ebp)
  801ee9:	a1 20 30 80 00       	mov    0x803020,%eax
  801eee:	8b 50 74             	mov    0x74(%eax),%edx
  801ef1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ef4:	39 c2                	cmp    %eax,%edx
  801ef6:	77 cb                	ja     801ec3 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801ef8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801efb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801efe:	74 14                	je     801f14 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801f00:	83 ec 04             	sub    $0x4,%esp
  801f03:	68 4c 27 80 00       	push   $0x80274c
  801f08:	6a 44                	push   $0x44
  801f0a:	68 ec 26 80 00       	push   $0x8026ec
  801f0f:	e8 23 fe ff ff       	call   801d37 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801f14:	90                   	nop
  801f15:	c9                   	leave  
  801f16:	c3                   	ret    
  801f17:	90                   	nop

00801f18 <__udivdi3>:
  801f18:	55                   	push   %ebp
  801f19:	57                   	push   %edi
  801f1a:	56                   	push   %esi
  801f1b:	53                   	push   %ebx
  801f1c:	83 ec 1c             	sub    $0x1c,%esp
  801f1f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f23:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801f27:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f2b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801f2f:	89 ca                	mov    %ecx,%edx
  801f31:	89 f8                	mov    %edi,%eax
  801f33:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f37:	85 f6                	test   %esi,%esi
  801f39:	75 2d                	jne    801f68 <__udivdi3+0x50>
  801f3b:	39 cf                	cmp    %ecx,%edi
  801f3d:	77 65                	ja     801fa4 <__udivdi3+0x8c>
  801f3f:	89 fd                	mov    %edi,%ebp
  801f41:	85 ff                	test   %edi,%edi
  801f43:	75 0b                	jne    801f50 <__udivdi3+0x38>
  801f45:	b8 01 00 00 00       	mov    $0x1,%eax
  801f4a:	31 d2                	xor    %edx,%edx
  801f4c:	f7 f7                	div    %edi
  801f4e:	89 c5                	mov    %eax,%ebp
  801f50:	31 d2                	xor    %edx,%edx
  801f52:	89 c8                	mov    %ecx,%eax
  801f54:	f7 f5                	div    %ebp
  801f56:	89 c1                	mov    %eax,%ecx
  801f58:	89 d8                	mov    %ebx,%eax
  801f5a:	f7 f5                	div    %ebp
  801f5c:	89 cf                	mov    %ecx,%edi
  801f5e:	89 fa                	mov    %edi,%edx
  801f60:	83 c4 1c             	add    $0x1c,%esp
  801f63:	5b                   	pop    %ebx
  801f64:	5e                   	pop    %esi
  801f65:	5f                   	pop    %edi
  801f66:	5d                   	pop    %ebp
  801f67:	c3                   	ret    
  801f68:	39 ce                	cmp    %ecx,%esi
  801f6a:	77 28                	ja     801f94 <__udivdi3+0x7c>
  801f6c:	0f bd fe             	bsr    %esi,%edi
  801f6f:	83 f7 1f             	xor    $0x1f,%edi
  801f72:	75 40                	jne    801fb4 <__udivdi3+0x9c>
  801f74:	39 ce                	cmp    %ecx,%esi
  801f76:	72 0a                	jb     801f82 <__udivdi3+0x6a>
  801f78:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f7c:	0f 87 9e 00 00 00    	ja     802020 <__udivdi3+0x108>
  801f82:	b8 01 00 00 00       	mov    $0x1,%eax
  801f87:	89 fa                	mov    %edi,%edx
  801f89:	83 c4 1c             	add    $0x1c,%esp
  801f8c:	5b                   	pop    %ebx
  801f8d:	5e                   	pop    %esi
  801f8e:	5f                   	pop    %edi
  801f8f:	5d                   	pop    %ebp
  801f90:	c3                   	ret    
  801f91:	8d 76 00             	lea    0x0(%esi),%esi
  801f94:	31 ff                	xor    %edi,%edi
  801f96:	31 c0                	xor    %eax,%eax
  801f98:	89 fa                	mov    %edi,%edx
  801f9a:	83 c4 1c             	add    $0x1c,%esp
  801f9d:	5b                   	pop    %ebx
  801f9e:	5e                   	pop    %esi
  801f9f:	5f                   	pop    %edi
  801fa0:	5d                   	pop    %ebp
  801fa1:	c3                   	ret    
  801fa2:	66 90                	xchg   %ax,%ax
  801fa4:	89 d8                	mov    %ebx,%eax
  801fa6:	f7 f7                	div    %edi
  801fa8:	31 ff                	xor    %edi,%edi
  801faa:	89 fa                	mov    %edi,%edx
  801fac:	83 c4 1c             	add    $0x1c,%esp
  801faf:	5b                   	pop    %ebx
  801fb0:	5e                   	pop    %esi
  801fb1:	5f                   	pop    %edi
  801fb2:	5d                   	pop    %ebp
  801fb3:	c3                   	ret    
  801fb4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801fb9:	89 eb                	mov    %ebp,%ebx
  801fbb:	29 fb                	sub    %edi,%ebx
  801fbd:	89 f9                	mov    %edi,%ecx
  801fbf:	d3 e6                	shl    %cl,%esi
  801fc1:	89 c5                	mov    %eax,%ebp
  801fc3:	88 d9                	mov    %bl,%cl
  801fc5:	d3 ed                	shr    %cl,%ebp
  801fc7:	89 e9                	mov    %ebp,%ecx
  801fc9:	09 f1                	or     %esi,%ecx
  801fcb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801fcf:	89 f9                	mov    %edi,%ecx
  801fd1:	d3 e0                	shl    %cl,%eax
  801fd3:	89 c5                	mov    %eax,%ebp
  801fd5:	89 d6                	mov    %edx,%esi
  801fd7:	88 d9                	mov    %bl,%cl
  801fd9:	d3 ee                	shr    %cl,%esi
  801fdb:	89 f9                	mov    %edi,%ecx
  801fdd:	d3 e2                	shl    %cl,%edx
  801fdf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fe3:	88 d9                	mov    %bl,%cl
  801fe5:	d3 e8                	shr    %cl,%eax
  801fe7:	09 c2                	or     %eax,%edx
  801fe9:	89 d0                	mov    %edx,%eax
  801feb:	89 f2                	mov    %esi,%edx
  801fed:	f7 74 24 0c          	divl   0xc(%esp)
  801ff1:	89 d6                	mov    %edx,%esi
  801ff3:	89 c3                	mov    %eax,%ebx
  801ff5:	f7 e5                	mul    %ebp
  801ff7:	39 d6                	cmp    %edx,%esi
  801ff9:	72 19                	jb     802014 <__udivdi3+0xfc>
  801ffb:	74 0b                	je     802008 <__udivdi3+0xf0>
  801ffd:	89 d8                	mov    %ebx,%eax
  801fff:	31 ff                	xor    %edi,%edi
  802001:	e9 58 ff ff ff       	jmp    801f5e <__udivdi3+0x46>
  802006:	66 90                	xchg   %ax,%ax
  802008:	8b 54 24 08          	mov    0x8(%esp),%edx
  80200c:	89 f9                	mov    %edi,%ecx
  80200e:	d3 e2                	shl    %cl,%edx
  802010:	39 c2                	cmp    %eax,%edx
  802012:	73 e9                	jae    801ffd <__udivdi3+0xe5>
  802014:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802017:	31 ff                	xor    %edi,%edi
  802019:	e9 40 ff ff ff       	jmp    801f5e <__udivdi3+0x46>
  80201e:	66 90                	xchg   %ax,%ax
  802020:	31 c0                	xor    %eax,%eax
  802022:	e9 37 ff ff ff       	jmp    801f5e <__udivdi3+0x46>
  802027:	90                   	nop

00802028 <__umoddi3>:
  802028:	55                   	push   %ebp
  802029:	57                   	push   %edi
  80202a:	56                   	push   %esi
  80202b:	53                   	push   %ebx
  80202c:	83 ec 1c             	sub    $0x1c,%esp
  80202f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802033:	8b 74 24 34          	mov    0x34(%esp),%esi
  802037:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80203b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80203f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802043:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802047:	89 f3                	mov    %esi,%ebx
  802049:	89 fa                	mov    %edi,%edx
  80204b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80204f:	89 34 24             	mov    %esi,(%esp)
  802052:	85 c0                	test   %eax,%eax
  802054:	75 1a                	jne    802070 <__umoddi3+0x48>
  802056:	39 f7                	cmp    %esi,%edi
  802058:	0f 86 a2 00 00 00    	jbe    802100 <__umoddi3+0xd8>
  80205e:	89 c8                	mov    %ecx,%eax
  802060:	89 f2                	mov    %esi,%edx
  802062:	f7 f7                	div    %edi
  802064:	89 d0                	mov    %edx,%eax
  802066:	31 d2                	xor    %edx,%edx
  802068:	83 c4 1c             	add    $0x1c,%esp
  80206b:	5b                   	pop    %ebx
  80206c:	5e                   	pop    %esi
  80206d:	5f                   	pop    %edi
  80206e:	5d                   	pop    %ebp
  80206f:	c3                   	ret    
  802070:	39 f0                	cmp    %esi,%eax
  802072:	0f 87 ac 00 00 00    	ja     802124 <__umoddi3+0xfc>
  802078:	0f bd e8             	bsr    %eax,%ebp
  80207b:	83 f5 1f             	xor    $0x1f,%ebp
  80207e:	0f 84 ac 00 00 00    	je     802130 <__umoddi3+0x108>
  802084:	bf 20 00 00 00       	mov    $0x20,%edi
  802089:	29 ef                	sub    %ebp,%edi
  80208b:	89 fe                	mov    %edi,%esi
  80208d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802091:	89 e9                	mov    %ebp,%ecx
  802093:	d3 e0                	shl    %cl,%eax
  802095:	89 d7                	mov    %edx,%edi
  802097:	89 f1                	mov    %esi,%ecx
  802099:	d3 ef                	shr    %cl,%edi
  80209b:	09 c7                	or     %eax,%edi
  80209d:	89 e9                	mov    %ebp,%ecx
  80209f:	d3 e2                	shl    %cl,%edx
  8020a1:	89 14 24             	mov    %edx,(%esp)
  8020a4:	89 d8                	mov    %ebx,%eax
  8020a6:	d3 e0                	shl    %cl,%eax
  8020a8:	89 c2                	mov    %eax,%edx
  8020aa:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020ae:	d3 e0                	shl    %cl,%eax
  8020b0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8020b4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020b8:	89 f1                	mov    %esi,%ecx
  8020ba:	d3 e8                	shr    %cl,%eax
  8020bc:	09 d0                	or     %edx,%eax
  8020be:	d3 eb                	shr    %cl,%ebx
  8020c0:	89 da                	mov    %ebx,%edx
  8020c2:	f7 f7                	div    %edi
  8020c4:	89 d3                	mov    %edx,%ebx
  8020c6:	f7 24 24             	mull   (%esp)
  8020c9:	89 c6                	mov    %eax,%esi
  8020cb:	89 d1                	mov    %edx,%ecx
  8020cd:	39 d3                	cmp    %edx,%ebx
  8020cf:	0f 82 87 00 00 00    	jb     80215c <__umoddi3+0x134>
  8020d5:	0f 84 91 00 00 00    	je     80216c <__umoddi3+0x144>
  8020db:	8b 54 24 04          	mov    0x4(%esp),%edx
  8020df:	29 f2                	sub    %esi,%edx
  8020e1:	19 cb                	sbb    %ecx,%ebx
  8020e3:	89 d8                	mov    %ebx,%eax
  8020e5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8020e9:	d3 e0                	shl    %cl,%eax
  8020eb:	89 e9                	mov    %ebp,%ecx
  8020ed:	d3 ea                	shr    %cl,%edx
  8020ef:	09 d0                	or     %edx,%eax
  8020f1:	89 e9                	mov    %ebp,%ecx
  8020f3:	d3 eb                	shr    %cl,%ebx
  8020f5:	89 da                	mov    %ebx,%edx
  8020f7:	83 c4 1c             	add    $0x1c,%esp
  8020fa:	5b                   	pop    %ebx
  8020fb:	5e                   	pop    %esi
  8020fc:	5f                   	pop    %edi
  8020fd:	5d                   	pop    %ebp
  8020fe:	c3                   	ret    
  8020ff:	90                   	nop
  802100:	89 fd                	mov    %edi,%ebp
  802102:	85 ff                	test   %edi,%edi
  802104:	75 0b                	jne    802111 <__umoddi3+0xe9>
  802106:	b8 01 00 00 00       	mov    $0x1,%eax
  80210b:	31 d2                	xor    %edx,%edx
  80210d:	f7 f7                	div    %edi
  80210f:	89 c5                	mov    %eax,%ebp
  802111:	89 f0                	mov    %esi,%eax
  802113:	31 d2                	xor    %edx,%edx
  802115:	f7 f5                	div    %ebp
  802117:	89 c8                	mov    %ecx,%eax
  802119:	f7 f5                	div    %ebp
  80211b:	89 d0                	mov    %edx,%eax
  80211d:	e9 44 ff ff ff       	jmp    802066 <__umoddi3+0x3e>
  802122:	66 90                	xchg   %ax,%ax
  802124:	89 c8                	mov    %ecx,%eax
  802126:	89 f2                	mov    %esi,%edx
  802128:	83 c4 1c             	add    $0x1c,%esp
  80212b:	5b                   	pop    %ebx
  80212c:	5e                   	pop    %esi
  80212d:	5f                   	pop    %edi
  80212e:	5d                   	pop    %ebp
  80212f:	c3                   	ret    
  802130:	3b 04 24             	cmp    (%esp),%eax
  802133:	72 06                	jb     80213b <__umoddi3+0x113>
  802135:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802139:	77 0f                	ja     80214a <__umoddi3+0x122>
  80213b:	89 f2                	mov    %esi,%edx
  80213d:	29 f9                	sub    %edi,%ecx
  80213f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802143:	89 14 24             	mov    %edx,(%esp)
  802146:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80214a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80214e:	8b 14 24             	mov    (%esp),%edx
  802151:	83 c4 1c             	add    $0x1c,%esp
  802154:	5b                   	pop    %ebx
  802155:	5e                   	pop    %esi
  802156:	5f                   	pop    %edi
  802157:	5d                   	pop    %ebp
  802158:	c3                   	ret    
  802159:	8d 76 00             	lea    0x0(%esi),%esi
  80215c:	2b 04 24             	sub    (%esp),%eax
  80215f:	19 fa                	sbb    %edi,%edx
  802161:	89 d1                	mov    %edx,%ecx
  802163:	89 c6                	mov    %eax,%esi
  802165:	e9 71 ff ff ff       	jmp    8020db <__umoddi3+0xb3>
  80216a:	66 90                	xchg   %ax,%ax
  80216c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802170:	72 ea                	jb     80215c <__umoddi3+0x134>
  802172:	89 d9                	mov    %ebx,%ecx
  802174:	e9 62 ff ff ff       	jmp    8020db <__umoddi3+0xb3>
