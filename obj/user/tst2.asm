
obj/user/tst2:     file format elf32-i386


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
  800031:	e8 12 03 00 00       	call   800348 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	char a;
	short b;
	int c;
};
void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	81 ec 94 00 00 00    	sub    $0x94,%esp
	

	rsttst();
  800042:	e8 79 1b 00 00       	call   801bc0 <rsttst>
	
	

	int Mega = 1024*1024;
  800047:	c7 45 f4 00 00 10 00 	movl   $0x100000,-0xc(%ebp)
	int kilo = 1024;
  80004e:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
	char minByte = 1<<7;
  800055:	c6 45 ef 80          	movb   $0x80,-0x11(%ebp)
	char maxByte = 0x7F;
  800059:	c6 45 ee 7f          	movb   $0x7f,-0x12(%ebp)
	short minShort = 1<<15 ;
  80005d:	66 c7 45 ec 00 80    	movw   $0x8000,-0x14(%ebp)
	short maxShort = 0x7FFF;
  800063:	66 c7 45 ea ff 7f    	movw   $0x7fff,-0x16(%ebp)
	int minInt = 1<<31 ;
  800069:	c7 45 e4 00 00 00 80 	movl   $0x80000000,-0x1c(%ebp)
	int maxInt = 0x7FFFFFFF;
  800070:	c7 45 e0 ff ff ff 7f 	movl   $0x7fffffff,-0x20(%ebp)

	void* ptr_allocations[20] = {0};
  800077:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
  80007d:	b9 14 00 00 00       	mov    $0x14,%ecx
  800082:	b8 00 00 00 00       	mov    $0x0,%eax
  800087:	89 d7                	mov    %edx,%edi
  800089:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		ptr_allocations[0] = malloc(2*Mega-kilo);
  80008b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80008e:	01 c0                	add    %eax,%eax
  800090:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 26 14 00 00       	call   8014c2 <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		char *byteArr = (char *) ptr_allocations[0];
  8000a5:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8000ab:	89 45 dc             	mov    %eax,-0x24(%ebp)
		int lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  8000ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b1:	01 c0                	add    %eax,%eax
  8000b3:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8000b6:	48                   	dec    %eax
  8000b7:	89 45 d8             	mov    %eax,-0x28(%ebp)
		byteArr[0] = minByte ;
  8000ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000bd:	8a 55 ef             	mov    -0x11(%ebp),%dl
  8000c0:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  8000c2:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8000c5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000c8:	01 c2                	add    %eax,%edx
  8000ca:	8a 45 ee             	mov    -0x12(%ebp),%al
  8000cd:	88 02                	mov    %al,(%edx)

		ptr_allocations[1] = malloc(2*Mega-kilo);
  8000cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000d2:	01 c0                	add    %eax,%eax
  8000d4:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8000d7:	83 ec 0c             	sub    $0xc,%esp
  8000da:	50                   	push   %eax
  8000db:	e8 e2 13 00 00       	call   8014c2 <malloc>
  8000e0:	83 c4 10             	add    $0x10,%esp
  8000e3:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		short *shortArr = (short *) ptr_allocations[1];
  8000e9:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8000ef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  8000f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000f5:	01 c0                	add    %eax,%eax
  8000f7:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8000fa:	d1 e8                	shr    %eax
  8000fc:	48                   	dec    %eax
  8000fd:	89 45 d0             	mov    %eax,-0x30(%ebp)
		shortArr[0] = minShort;
  800100:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800103:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800106:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800109:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80010c:	01 c0                	add    %eax,%eax
  80010e:	89 c2                	mov    %eax,%edx
  800110:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800113:	01 c2                	add    %eax,%edx
  800115:	66 8b 45 ea          	mov    -0x16(%ebp),%ax
  800119:	66 89 02             	mov    %ax,(%edx)

		ptr_allocations[2] = malloc(2*kilo);
  80011c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80011f:	01 c0                	add    %eax,%eax
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	50                   	push   %eax
  800125:	e8 98 13 00 00       	call   8014c2 <malloc>
  80012a:	83 c4 10             	add    $0x10,%esp
  80012d:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
		int *intArr = (int *) ptr_allocations[2];
  800133:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800139:	89 45 cc             	mov    %eax,-0x34(%ebp)
		int lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  80013c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80013f:	01 c0                	add    %eax,%eax
  800141:	c1 e8 02             	shr    $0x2,%eax
  800144:	48                   	dec    %eax
  800145:	89 45 c8             	mov    %eax,-0x38(%ebp)
		intArr[0] = minInt;
  800148:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80014b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80014e:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  800150:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800153:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80015a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80015d:	01 c2                	add    %eax,%edx
  80015f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800162:	89 02                	mov    %eax,(%edx)

		ptr_allocations[3] = malloc(7*kilo);
  800164:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800167:	89 d0                	mov    %edx,%eax
  800169:	01 c0                	add    %eax,%eax
  80016b:	01 d0                	add    %edx,%eax
  80016d:	01 c0                	add    %eax,%eax
  80016f:	01 d0                	add    %edx,%eax
  800171:	83 ec 0c             	sub    $0xc,%esp
  800174:	50                   	push   %eax
  800175:	e8 48 13 00 00       	call   8014c2 <malloc>
  80017a:	83 c4 10             	add    $0x10,%esp
  80017d:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
		struct MyStruct *structArr = (struct MyStruct *) ptr_allocations[3];
  800183:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800189:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		int lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  80018c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80018f:	89 d0                	mov    %edx,%eax
  800191:	01 c0                	add    %eax,%eax
  800193:	01 d0                	add    %edx,%eax
  800195:	01 c0                	add    %eax,%eax
  800197:	01 d0                	add    %edx,%eax
  800199:	c1 e8 03             	shr    $0x3,%eax
  80019c:	48                   	dec    %eax
  80019d:	89 45 c0             	mov    %eax,-0x40(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  8001a0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001a3:	8a 55 ef             	mov    -0x11(%ebp),%dl
  8001a6:	88 10                	mov    %dl,(%eax)
  8001a8:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  8001ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001ae:	66 89 42 02          	mov    %ax,0x2(%edx)
  8001b2:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001b5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8001b8:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  8001bb:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001be:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8001c5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001c8:	01 c2                	add    %eax,%edx
  8001ca:	8a 45 ee             	mov    -0x12(%ebp),%al
  8001cd:	88 02                	mov    %al,(%edx)
  8001cf:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001d2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8001d9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001dc:	01 c2                	add    %eax,%edx
  8001de:	66 8b 45 ea          	mov    -0x16(%ebp),%ax
  8001e2:	66 89 42 02          	mov    %ax,0x2(%edx)
  8001e6:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001e9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8001f0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001f3:	01 c2                	add    %eax,%edx
  8001f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001f8:	89 42 04             	mov    %eax,0x4(%edx)

		//Check that the values are successfully stored
		if (byteArr[0] 	!= minByte 	|| byteArr[lastIndexOfByte] 	!= maxByte) panic("Wrong allocation: stored values are wrongly changed!");
  8001fb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8001fe:	8a 00                	mov    (%eax),%al
  800200:	3a 45 ef             	cmp    -0x11(%ebp),%al
  800203:	75 0f                	jne    800214 <_main+0x1dc>
  800205:	8b 55 d8             	mov    -0x28(%ebp),%edx
  800208:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80020b:	01 d0                	add    %edx,%eax
  80020d:	8a 00                	mov    (%eax),%al
  80020f:	3a 45 ee             	cmp    -0x12(%ebp),%al
  800212:	74 14                	je     800228 <_main+0x1f0>
  800214:	83 ec 04             	sub    $0x4,%esp
  800217:	68 a0 1f 80 00       	push   $0x801fa0
  80021c:	6a 35                	push   $0x35
  80021e:	68 d5 1f 80 00       	push   $0x801fd5
  800223:	e8 22 02 00 00       	call   80044a <_panic>
		if (shortArr[0] != minShort || shortArr[lastIndexOfShort] 	!= maxShort) panic("Wrong allocation: stored values are wrongly changed!");
  800228:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80022b:	66 8b 00             	mov    (%eax),%ax
  80022e:	66 3b 45 ec          	cmp    -0x14(%ebp),%ax
  800232:	75 15                	jne    800249 <_main+0x211>
  800234:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800237:	01 c0                	add    %eax,%eax
  800239:	89 c2                	mov    %eax,%edx
  80023b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80023e:	01 d0                	add    %edx,%eax
  800240:	66 8b 00             	mov    (%eax),%ax
  800243:	66 3b 45 ea          	cmp    -0x16(%ebp),%ax
  800247:	74 14                	je     80025d <_main+0x225>
  800249:	83 ec 04             	sub    $0x4,%esp
  80024c:	68 a0 1f 80 00       	push   $0x801fa0
  800251:	6a 36                	push   $0x36
  800253:	68 d5 1f 80 00       	push   $0x801fd5
  800258:	e8 ed 01 00 00       	call   80044a <_panic>
		if (intArr[0] 	!= minInt 	|| intArr[lastIndexOfInt] 		!= maxInt) panic("Wrong allocation: stored values are wrongly changed!");
  80025d:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800260:	8b 00                	mov    (%eax),%eax
  800262:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800265:	75 16                	jne    80027d <_main+0x245>
  800267:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80026a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800271:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800274:	01 d0                	add    %edx,%eax
  800276:	8b 00                	mov    (%eax),%eax
  800278:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80027b:	74 14                	je     800291 <_main+0x259>
  80027d:	83 ec 04             	sub    $0x4,%esp
  800280:	68 a0 1f 80 00       	push   $0x801fa0
  800285:	6a 37                	push   $0x37
  800287:	68 d5 1f 80 00       	push   $0x801fd5
  80028c:	e8 b9 01 00 00       	call   80044a <_panic>

		if (structArr[0].a != minByte 	|| structArr[lastIndexOfStruct].a != maxByte) 	panic("Wrong allocation: stored values are wrongly changed!");
  800291:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800294:	8a 00                	mov    (%eax),%al
  800296:	3a 45 ef             	cmp    -0x11(%ebp),%al
  800299:	75 16                	jne    8002b1 <_main+0x279>
  80029b:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80029e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002a5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8002a8:	01 d0                	add    %edx,%eax
  8002aa:	8a 00                	mov    (%eax),%al
  8002ac:	3a 45 ee             	cmp    -0x12(%ebp),%al
  8002af:	74 14                	je     8002c5 <_main+0x28d>
  8002b1:	83 ec 04             	sub    $0x4,%esp
  8002b4:	68 a0 1f 80 00       	push   $0x801fa0
  8002b9:	6a 39                	push   $0x39
  8002bb:	68 d5 1f 80 00       	push   $0x801fd5
  8002c0:	e8 85 01 00 00       	call   80044a <_panic>
		if (structArr[0].b != minShort 	|| structArr[lastIndexOfStruct].b != maxShort) 	panic("Wrong allocation: stored values are wrongly changed!");
  8002c5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8002c8:	66 8b 40 02          	mov    0x2(%eax),%ax
  8002cc:	66 3b 45 ec          	cmp    -0x14(%ebp),%ax
  8002d0:	75 19                	jne    8002eb <_main+0x2b3>
  8002d2:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8002d5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002dc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8002df:	01 d0                	add    %edx,%eax
  8002e1:	66 8b 40 02          	mov    0x2(%eax),%ax
  8002e5:	66 3b 45 ea          	cmp    -0x16(%ebp),%ax
  8002e9:	74 14                	je     8002ff <_main+0x2c7>
  8002eb:	83 ec 04             	sub    $0x4,%esp
  8002ee:	68 a0 1f 80 00       	push   $0x801fa0
  8002f3:	6a 3a                	push   $0x3a
  8002f5:	68 d5 1f 80 00       	push   $0x801fd5
  8002fa:	e8 4b 01 00 00       	call   80044a <_panic>
		if (structArr[0].c != minInt 	|| structArr[lastIndexOfStruct].c != maxInt) 	panic("Wrong allocation: stored values are wrongly changed!");
  8002ff:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800302:	8b 40 04             	mov    0x4(%eax),%eax
  800305:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800308:	75 17                	jne    800321 <_main+0x2e9>
  80030a:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80030d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800314:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800317:	01 d0                	add    %edx,%eax
  800319:	8b 40 04             	mov    0x4(%eax),%eax
  80031c:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80031f:	74 14                	je     800335 <_main+0x2fd>
  800321:	83 ec 04             	sub    $0x4,%esp
  800324:	68 a0 1f 80 00       	push   $0x801fa0
  800329:	6a 3b                	push   $0x3b
  80032b:	68 d5 1f 80 00       	push   $0x801fd5
  800330:	e8 15 01 00 00       	call   80044a <_panic>


	}

	chktst(0);
  800335:	83 ec 0c             	sub    $0xc,%esp
  800338:	6a 00                	push   $0x0
  80033a:	e8 c6 18 00 00       	call   801c05 <chktst>
  80033f:	83 c4 10             	add    $0x10,%esp
	return;
  800342:	90                   	nop
}
  800343:	8b 7d fc             	mov    -0x4(%ebp),%edi
  800346:	c9                   	leave  
  800347:	c3                   	ret    

00800348 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800348:	55                   	push   %ebp
  800349:	89 e5                	mov    %esp,%ebp
  80034b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80034e:	e8 66 14 00 00       	call   8017b9 <sys_getenvindex>
  800353:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800356:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800359:	89 d0                	mov    %edx,%eax
  80035b:	01 c0                	add    %eax,%eax
  80035d:	01 d0                	add    %edx,%eax
  80035f:	c1 e0 02             	shl    $0x2,%eax
  800362:	01 d0                	add    %edx,%eax
  800364:	c1 e0 06             	shl    $0x6,%eax
  800367:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80036c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800371:	a1 20 30 80 00       	mov    0x803020,%eax
  800376:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80037c:	84 c0                	test   %al,%al
  80037e:	74 0f                	je     80038f <libmain+0x47>
		binaryname = myEnv->prog_name;
  800380:	a1 20 30 80 00       	mov    0x803020,%eax
  800385:	05 f4 02 00 00       	add    $0x2f4,%eax
  80038a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80038f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800393:	7e 0a                	jle    80039f <libmain+0x57>
		binaryname = argv[0];
  800395:	8b 45 0c             	mov    0xc(%ebp),%eax
  800398:	8b 00                	mov    (%eax),%eax
  80039a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80039f:	83 ec 08             	sub    $0x8,%esp
  8003a2:	ff 75 0c             	pushl  0xc(%ebp)
  8003a5:	ff 75 08             	pushl  0x8(%ebp)
  8003a8:	e8 8b fc ff ff       	call   800038 <_main>
  8003ad:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003b0:	e8 9f 15 00 00       	call   801954 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003b5:	83 ec 0c             	sub    $0xc,%esp
  8003b8:	68 fc 1f 80 00       	push   $0x801ffc
  8003bd:	e8 3c 03 00 00       	call   8006fe <cprintf>
  8003c2:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ca:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8003d0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d5:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8003db:	83 ec 04             	sub    $0x4,%esp
  8003de:	52                   	push   %edx
  8003df:	50                   	push   %eax
  8003e0:	68 24 20 80 00       	push   $0x802024
  8003e5:	e8 14 03 00 00       	call   8006fe <cprintf>
  8003ea:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8003ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f2:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8003f8:	83 ec 08             	sub    $0x8,%esp
  8003fb:	50                   	push   %eax
  8003fc:	68 49 20 80 00       	push   $0x802049
  800401:	e8 f8 02 00 00       	call   8006fe <cprintf>
  800406:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800409:	83 ec 0c             	sub    $0xc,%esp
  80040c:	68 fc 1f 80 00       	push   $0x801ffc
  800411:	e8 e8 02 00 00       	call   8006fe <cprintf>
  800416:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800419:	e8 50 15 00 00       	call   80196e <sys_enable_interrupt>

	// exit gracefully
	exit();
  80041e:	e8 19 00 00 00       	call   80043c <exit>
}
  800423:	90                   	nop
  800424:	c9                   	leave  
  800425:	c3                   	ret    

00800426 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800426:	55                   	push   %ebp
  800427:	89 e5                	mov    %esp,%ebp
  800429:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80042c:	83 ec 0c             	sub    $0xc,%esp
  80042f:	6a 00                	push   $0x0
  800431:	e8 4f 13 00 00       	call   801785 <sys_env_destroy>
  800436:	83 c4 10             	add    $0x10,%esp
}
  800439:	90                   	nop
  80043a:	c9                   	leave  
  80043b:	c3                   	ret    

0080043c <exit>:

void
exit(void)
{
  80043c:	55                   	push   %ebp
  80043d:	89 e5                	mov    %esp,%ebp
  80043f:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800442:	e8 a4 13 00 00       	call   8017eb <sys_env_exit>
}
  800447:	90                   	nop
  800448:	c9                   	leave  
  800449:	c3                   	ret    

0080044a <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80044a:	55                   	push   %ebp
  80044b:	89 e5                	mov    %esp,%ebp
  80044d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800450:	8d 45 10             	lea    0x10(%ebp),%eax
  800453:	83 c0 04             	add    $0x4,%eax
  800456:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800459:	a1 30 30 80 00       	mov    0x803030,%eax
  80045e:	85 c0                	test   %eax,%eax
  800460:	74 16                	je     800478 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800462:	a1 30 30 80 00       	mov    0x803030,%eax
  800467:	83 ec 08             	sub    $0x8,%esp
  80046a:	50                   	push   %eax
  80046b:	68 60 20 80 00       	push   $0x802060
  800470:	e8 89 02 00 00       	call   8006fe <cprintf>
  800475:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800478:	a1 00 30 80 00       	mov    0x803000,%eax
  80047d:	ff 75 0c             	pushl  0xc(%ebp)
  800480:	ff 75 08             	pushl  0x8(%ebp)
  800483:	50                   	push   %eax
  800484:	68 65 20 80 00       	push   $0x802065
  800489:	e8 70 02 00 00       	call   8006fe <cprintf>
  80048e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800491:	8b 45 10             	mov    0x10(%ebp),%eax
  800494:	83 ec 08             	sub    $0x8,%esp
  800497:	ff 75 f4             	pushl  -0xc(%ebp)
  80049a:	50                   	push   %eax
  80049b:	e8 f3 01 00 00       	call   800693 <vcprintf>
  8004a0:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8004a3:	83 ec 08             	sub    $0x8,%esp
  8004a6:	6a 00                	push   $0x0
  8004a8:	68 81 20 80 00       	push   $0x802081
  8004ad:	e8 e1 01 00 00       	call   800693 <vcprintf>
  8004b2:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8004b5:	e8 82 ff ff ff       	call   80043c <exit>

	// should not return here
	while (1) ;
  8004ba:	eb fe                	jmp    8004ba <_panic+0x70>

008004bc <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8004bc:	55                   	push   %ebp
  8004bd:	89 e5                	mov    %esp,%ebp
  8004bf:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8004c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c7:	8b 50 74             	mov    0x74(%eax),%edx
  8004ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004cd:	39 c2                	cmp    %eax,%edx
  8004cf:	74 14                	je     8004e5 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8004d1:	83 ec 04             	sub    $0x4,%esp
  8004d4:	68 84 20 80 00       	push   $0x802084
  8004d9:	6a 26                	push   $0x26
  8004db:	68 d0 20 80 00       	push   $0x8020d0
  8004e0:	e8 65 ff ff ff       	call   80044a <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8004e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8004ec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004f3:	e9 c2 00 00 00       	jmp    8005ba <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8004f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004fb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800502:	8b 45 08             	mov    0x8(%ebp),%eax
  800505:	01 d0                	add    %edx,%eax
  800507:	8b 00                	mov    (%eax),%eax
  800509:	85 c0                	test   %eax,%eax
  80050b:	75 08                	jne    800515 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80050d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800510:	e9 a2 00 00 00       	jmp    8005b7 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800515:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80051c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800523:	eb 69                	jmp    80058e <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800525:	a1 20 30 80 00       	mov    0x803020,%eax
  80052a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800530:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800533:	89 d0                	mov    %edx,%eax
  800535:	01 c0                	add    %eax,%eax
  800537:	01 d0                	add    %edx,%eax
  800539:	c1 e0 02             	shl    $0x2,%eax
  80053c:	01 c8                	add    %ecx,%eax
  80053e:	8a 40 04             	mov    0x4(%eax),%al
  800541:	84 c0                	test   %al,%al
  800543:	75 46                	jne    80058b <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800545:	a1 20 30 80 00       	mov    0x803020,%eax
  80054a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800550:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800553:	89 d0                	mov    %edx,%eax
  800555:	01 c0                	add    %eax,%eax
  800557:	01 d0                	add    %edx,%eax
  800559:	c1 e0 02             	shl    $0x2,%eax
  80055c:	01 c8                	add    %ecx,%eax
  80055e:	8b 00                	mov    (%eax),%eax
  800560:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800563:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800566:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80056b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80056d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800570:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800577:	8b 45 08             	mov    0x8(%ebp),%eax
  80057a:	01 c8                	add    %ecx,%eax
  80057c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80057e:	39 c2                	cmp    %eax,%edx
  800580:	75 09                	jne    80058b <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800582:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800589:	eb 12                	jmp    80059d <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80058b:	ff 45 e8             	incl   -0x18(%ebp)
  80058e:	a1 20 30 80 00       	mov    0x803020,%eax
  800593:	8b 50 74             	mov    0x74(%eax),%edx
  800596:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800599:	39 c2                	cmp    %eax,%edx
  80059b:	77 88                	ja     800525 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80059d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8005a1:	75 14                	jne    8005b7 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8005a3:	83 ec 04             	sub    $0x4,%esp
  8005a6:	68 dc 20 80 00       	push   $0x8020dc
  8005ab:	6a 3a                	push   $0x3a
  8005ad:	68 d0 20 80 00       	push   $0x8020d0
  8005b2:	e8 93 fe ff ff       	call   80044a <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005b7:	ff 45 f0             	incl   -0x10(%ebp)
  8005ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005bd:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005c0:	0f 8c 32 ff ff ff    	jl     8004f8 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8005c6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005cd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8005d4:	eb 26                	jmp    8005fc <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8005d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8005db:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8005e1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005e4:	89 d0                	mov    %edx,%eax
  8005e6:	01 c0                	add    %eax,%eax
  8005e8:	01 d0                	add    %edx,%eax
  8005ea:	c1 e0 02             	shl    $0x2,%eax
  8005ed:	01 c8                	add    %ecx,%eax
  8005ef:	8a 40 04             	mov    0x4(%eax),%al
  8005f2:	3c 01                	cmp    $0x1,%al
  8005f4:	75 03                	jne    8005f9 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8005f6:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005f9:	ff 45 e0             	incl   -0x20(%ebp)
  8005fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800601:	8b 50 74             	mov    0x74(%eax),%edx
  800604:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800607:	39 c2                	cmp    %eax,%edx
  800609:	77 cb                	ja     8005d6 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80060b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80060e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800611:	74 14                	je     800627 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800613:	83 ec 04             	sub    $0x4,%esp
  800616:	68 30 21 80 00       	push   $0x802130
  80061b:	6a 44                	push   $0x44
  80061d:	68 d0 20 80 00       	push   $0x8020d0
  800622:	e8 23 fe ff ff       	call   80044a <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800627:	90                   	nop
  800628:	c9                   	leave  
  800629:	c3                   	ret    

0080062a <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80062a:	55                   	push   %ebp
  80062b:	89 e5                	mov    %esp,%ebp
  80062d:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800630:	8b 45 0c             	mov    0xc(%ebp),%eax
  800633:	8b 00                	mov    (%eax),%eax
  800635:	8d 48 01             	lea    0x1(%eax),%ecx
  800638:	8b 55 0c             	mov    0xc(%ebp),%edx
  80063b:	89 0a                	mov    %ecx,(%edx)
  80063d:	8b 55 08             	mov    0x8(%ebp),%edx
  800640:	88 d1                	mov    %dl,%cl
  800642:	8b 55 0c             	mov    0xc(%ebp),%edx
  800645:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800649:	8b 45 0c             	mov    0xc(%ebp),%eax
  80064c:	8b 00                	mov    (%eax),%eax
  80064e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800653:	75 2c                	jne    800681 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800655:	a0 24 30 80 00       	mov    0x803024,%al
  80065a:	0f b6 c0             	movzbl %al,%eax
  80065d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800660:	8b 12                	mov    (%edx),%edx
  800662:	89 d1                	mov    %edx,%ecx
  800664:	8b 55 0c             	mov    0xc(%ebp),%edx
  800667:	83 c2 08             	add    $0x8,%edx
  80066a:	83 ec 04             	sub    $0x4,%esp
  80066d:	50                   	push   %eax
  80066e:	51                   	push   %ecx
  80066f:	52                   	push   %edx
  800670:	e8 ce 10 00 00       	call   801743 <sys_cputs>
  800675:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800678:	8b 45 0c             	mov    0xc(%ebp),%eax
  80067b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800681:	8b 45 0c             	mov    0xc(%ebp),%eax
  800684:	8b 40 04             	mov    0x4(%eax),%eax
  800687:	8d 50 01             	lea    0x1(%eax),%edx
  80068a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80068d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800690:	90                   	nop
  800691:	c9                   	leave  
  800692:	c3                   	ret    

00800693 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800693:	55                   	push   %ebp
  800694:	89 e5                	mov    %esp,%ebp
  800696:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80069c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006a3:	00 00 00 
	b.cnt = 0;
  8006a6:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006ad:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006b0:	ff 75 0c             	pushl  0xc(%ebp)
  8006b3:	ff 75 08             	pushl  0x8(%ebp)
  8006b6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006bc:	50                   	push   %eax
  8006bd:	68 2a 06 80 00       	push   $0x80062a
  8006c2:	e8 11 02 00 00       	call   8008d8 <vprintfmt>
  8006c7:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006ca:	a0 24 30 80 00       	mov    0x803024,%al
  8006cf:	0f b6 c0             	movzbl %al,%eax
  8006d2:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8006d8:	83 ec 04             	sub    $0x4,%esp
  8006db:	50                   	push   %eax
  8006dc:	52                   	push   %edx
  8006dd:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006e3:	83 c0 08             	add    $0x8,%eax
  8006e6:	50                   	push   %eax
  8006e7:	e8 57 10 00 00       	call   801743 <sys_cputs>
  8006ec:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8006ef:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8006f6:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8006fc:	c9                   	leave  
  8006fd:	c3                   	ret    

008006fe <cprintf>:

int cprintf(const char *fmt, ...) {
  8006fe:	55                   	push   %ebp
  8006ff:	89 e5                	mov    %esp,%ebp
  800701:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800704:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80070b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80070e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800711:	8b 45 08             	mov    0x8(%ebp),%eax
  800714:	83 ec 08             	sub    $0x8,%esp
  800717:	ff 75 f4             	pushl  -0xc(%ebp)
  80071a:	50                   	push   %eax
  80071b:	e8 73 ff ff ff       	call   800693 <vcprintf>
  800720:	83 c4 10             	add    $0x10,%esp
  800723:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800726:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800729:	c9                   	leave  
  80072a:	c3                   	ret    

0080072b <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80072b:	55                   	push   %ebp
  80072c:	89 e5                	mov    %esp,%ebp
  80072e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800731:	e8 1e 12 00 00       	call   801954 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800736:	8d 45 0c             	lea    0xc(%ebp),%eax
  800739:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80073c:	8b 45 08             	mov    0x8(%ebp),%eax
  80073f:	83 ec 08             	sub    $0x8,%esp
  800742:	ff 75 f4             	pushl  -0xc(%ebp)
  800745:	50                   	push   %eax
  800746:	e8 48 ff ff ff       	call   800693 <vcprintf>
  80074b:	83 c4 10             	add    $0x10,%esp
  80074e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800751:	e8 18 12 00 00       	call   80196e <sys_enable_interrupt>
	return cnt;
  800756:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800759:	c9                   	leave  
  80075a:	c3                   	ret    

0080075b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80075b:	55                   	push   %ebp
  80075c:	89 e5                	mov    %esp,%ebp
  80075e:	53                   	push   %ebx
  80075f:	83 ec 14             	sub    $0x14,%esp
  800762:	8b 45 10             	mov    0x10(%ebp),%eax
  800765:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800768:	8b 45 14             	mov    0x14(%ebp),%eax
  80076b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80076e:	8b 45 18             	mov    0x18(%ebp),%eax
  800771:	ba 00 00 00 00       	mov    $0x0,%edx
  800776:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800779:	77 55                	ja     8007d0 <printnum+0x75>
  80077b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80077e:	72 05                	jb     800785 <printnum+0x2a>
  800780:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800783:	77 4b                	ja     8007d0 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800785:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800788:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80078b:	8b 45 18             	mov    0x18(%ebp),%eax
  80078e:	ba 00 00 00 00       	mov    $0x0,%edx
  800793:	52                   	push   %edx
  800794:	50                   	push   %eax
  800795:	ff 75 f4             	pushl  -0xc(%ebp)
  800798:	ff 75 f0             	pushl  -0x10(%ebp)
  80079b:	e8 94 15 00 00       	call   801d34 <__udivdi3>
  8007a0:	83 c4 10             	add    $0x10,%esp
  8007a3:	83 ec 04             	sub    $0x4,%esp
  8007a6:	ff 75 20             	pushl  0x20(%ebp)
  8007a9:	53                   	push   %ebx
  8007aa:	ff 75 18             	pushl  0x18(%ebp)
  8007ad:	52                   	push   %edx
  8007ae:	50                   	push   %eax
  8007af:	ff 75 0c             	pushl  0xc(%ebp)
  8007b2:	ff 75 08             	pushl  0x8(%ebp)
  8007b5:	e8 a1 ff ff ff       	call   80075b <printnum>
  8007ba:	83 c4 20             	add    $0x20,%esp
  8007bd:	eb 1a                	jmp    8007d9 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007bf:	83 ec 08             	sub    $0x8,%esp
  8007c2:	ff 75 0c             	pushl  0xc(%ebp)
  8007c5:	ff 75 20             	pushl  0x20(%ebp)
  8007c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cb:	ff d0                	call   *%eax
  8007cd:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007d0:	ff 4d 1c             	decl   0x1c(%ebp)
  8007d3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007d7:	7f e6                	jg     8007bf <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007d9:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007dc:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007e7:	53                   	push   %ebx
  8007e8:	51                   	push   %ecx
  8007e9:	52                   	push   %edx
  8007ea:	50                   	push   %eax
  8007eb:	e8 54 16 00 00       	call   801e44 <__umoddi3>
  8007f0:	83 c4 10             	add    $0x10,%esp
  8007f3:	05 94 23 80 00       	add    $0x802394,%eax
  8007f8:	8a 00                	mov    (%eax),%al
  8007fa:	0f be c0             	movsbl %al,%eax
  8007fd:	83 ec 08             	sub    $0x8,%esp
  800800:	ff 75 0c             	pushl  0xc(%ebp)
  800803:	50                   	push   %eax
  800804:	8b 45 08             	mov    0x8(%ebp),%eax
  800807:	ff d0                	call   *%eax
  800809:	83 c4 10             	add    $0x10,%esp
}
  80080c:	90                   	nop
  80080d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800810:	c9                   	leave  
  800811:	c3                   	ret    

00800812 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800812:	55                   	push   %ebp
  800813:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800815:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800819:	7e 1c                	jle    800837 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80081b:	8b 45 08             	mov    0x8(%ebp),%eax
  80081e:	8b 00                	mov    (%eax),%eax
  800820:	8d 50 08             	lea    0x8(%eax),%edx
  800823:	8b 45 08             	mov    0x8(%ebp),%eax
  800826:	89 10                	mov    %edx,(%eax)
  800828:	8b 45 08             	mov    0x8(%ebp),%eax
  80082b:	8b 00                	mov    (%eax),%eax
  80082d:	83 e8 08             	sub    $0x8,%eax
  800830:	8b 50 04             	mov    0x4(%eax),%edx
  800833:	8b 00                	mov    (%eax),%eax
  800835:	eb 40                	jmp    800877 <getuint+0x65>
	else if (lflag)
  800837:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80083b:	74 1e                	je     80085b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80083d:	8b 45 08             	mov    0x8(%ebp),%eax
  800840:	8b 00                	mov    (%eax),%eax
  800842:	8d 50 04             	lea    0x4(%eax),%edx
  800845:	8b 45 08             	mov    0x8(%ebp),%eax
  800848:	89 10                	mov    %edx,(%eax)
  80084a:	8b 45 08             	mov    0x8(%ebp),%eax
  80084d:	8b 00                	mov    (%eax),%eax
  80084f:	83 e8 04             	sub    $0x4,%eax
  800852:	8b 00                	mov    (%eax),%eax
  800854:	ba 00 00 00 00       	mov    $0x0,%edx
  800859:	eb 1c                	jmp    800877 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80085b:	8b 45 08             	mov    0x8(%ebp),%eax
  80085e:	8b 00                	mov    (%eax),%eax
  800860:	8d 50 04             	lea    0x4(%eax),%edx
  800863:	8b 45 08             	mov    0x8(%ebp),%eax
  800866:	89 10                	mov    %edx,(%eax)
  800868:	8b 45 08             	mov    0x8(%ebp),%eax
  80086b:	8b 00                	mov    (%eax),%eax
  80086d:	83 e8 04             	sub    $0x4,%eax
  800870:	8b 00                	mov    (%eax),%eax
  800872:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800877:	5d                   	pop    %ebp
  800878:	c3                   	ret    

00800879 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800879:	55                   	push   %ebp
  80087a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80087c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800880:	7e 1c                	jle    80089e <getint+0x25>
		return va_arg(*ap, long long);
  800882:	8b 45 08             	mov    0x8(%ebp),%eax
  800885:	8b 00                	mov    (%eax),%eax
  800887:	8d 50 08             	lea    0x8(%eax),%edx
  80088a:	8b 45 08             	mov    0x8(%ebp),%eax
  80088d:	89 10                	mov    %edx,(%eax)
  80088f:	8b 45 08             	mov    0x8(%ebp),%eax
  800892:	8b 00                	mov    (%eax),%eax
  800894:	83 e8 08             	sub    $0x8,%eax
  800897:	8b 50 04             	mov    0x4(%eax),%edx
  80089a:	8b 00                	mov    (%eax),%eax
  80089c:	eb 38                	jmp    8008d6 <getint+0x5d>
	else if (lflag)
  80089e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008a2:	74 1a                	je     8008be <getint+0x45>
		return va_arg(*ap, long);
  8008a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a7:	8b 00                	mov    (%eax),%eax
  8008a9:	8d 50 04             	lea    0x4(%eax),%edx
  8008ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8008af:	89 10                	mov    %edx,(%eax)
  8008b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b4:	8b 00                	mov    (%eax),%eax
  8008b6:	83 e8 04             	sub    $0x4,%eax
  8008b9:	8b 00                	mov    (%eax),%eax
  8008bb:	99                   	cltd   
  8008bc:	eb 18                	jmp    8008d6 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008be:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c1:	8b 00                	mov    (%eax),%eax
  8008c3:	8d 50 04             	lea    0x4(%eax),%edx
  8008c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c9:	89 10                	mov    %edx,(%eax)
  8008cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ce:	8b 00                	mov    (%eax),%eax
  8008d0:	83 e8 04             	sub    $0x4,%eax
  8008d3:	8b 00                	mov    (%eax),%eax
  8008d5:	99                   	cltd   
}
  8008d6:	5d                   	pop    %ebp
  8008d7:	c3                   	ret    

008008d8 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008d8:	55                   	push   %ebp
  8008d9:	89 e5                	mov    %esp,%ebp
  8008db:	56                   	push   %esi
  8008dc:	53                   	push   %ebx
  8008dd:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008e0:	eb 17                	jmp    8008f9 <vprintfmt+0x21>
			if (ch == '\0')
  8008e2:	85 db                	test   %ebx,%ebx
  8008e4:	0f 84 af 03 00 00    	je     800c99 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8008ea:	83 ec 08             	sub    $0x8,%esp
  8008ed:	ff 75 0c             	pushl  0xc(%ebp)
  8008f0:	53                   	push   %ebx
  8008f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f4:	ff d0                	call   *%eax
  8008f6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8008fc:	8d 50 01             	lea    0x1(%eax),%edx
  8008ff:	89 55 10             	mov    %edx,0x10(%ebp)
  800902:	8a 00                	mov    (%eax),%al
  800904:	0f b6 d8             	movzbl %al,%ebx
  800907:	83 fb 25             	cmp    $0x25,%ebx
  80090a:	75 d6                	jne    8008e2 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80090c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800910:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800917:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80091e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800925:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80092c:	8b 45 10             	mov    0x10(%ebp),%eax
  80092f:	8d 50 01             	lea    0x1(%eax),%edx
  800932:	89 55 10             	mov    %edx,0x10(%ebp)
  800935:	8a 00                	mov    (%eax),%al
  800937:	0f b6 d8             	movzbl %al,%ebx
  80093a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80093d:	83 f8 55             	cmp    $0x55,%eax
  800940:	0f 87 2b 03 00 00    	ja     800c71 <vprintfmt+0x399>
  800946:	8b 04 85 b8 23 80 00 	mov    0x8023b8(,%eax,4),%eax
  80094d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80094f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800953:	eb d7                	jmp    80092c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800955:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800959:	eb d1                	jmp    80092c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80095b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800962:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800965:	89 d0                	mov    %edx,%eax
  800967:	c1 e0 02             	shl    $0x2,%eax
  80096a:	01 d0                	add    %edx,%eax
  80096c:	01 c0                	add    %eax,%eax
  80096e:	01 d8                	add    %ebx,%eax
  800970:	83 e8 30             	sub    $0x30,%eax
  800973:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800976:	8b 45 10             	mov    0x10(%ebp),%eax
  800979:	8a 00                	mov    (%eax),%al
  80097b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80097e:	83 fb 2f             	cmp    $0x2f,%ebx
  800981:	7e 3e                	jle    8009c1 <vprintfmt+0xe9>
  800983:	83 fb 39             	cmp    $0x39,%ebx
  800986:	7f 39                	jg     8009c1 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800988:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80098b:	eb d5                	jmp    800962 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80098d:	8b 45 14             	mov    0x14(%ebp),%eax
  800990:	83 c0 04             	add    $0x4,%eax
  800993:	89 45 14             	mov    %eax,0x14(%ebp)
  800996:	8b 45 14             	mov    0x14(%ebp),%eax
  800999:	83 e8 04             	sub    $0x4,%eax
  80099c:	8b 00                	mov    (%eax),%eax
  80099e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009a1:	eb 1f                	jmp    8009c2 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009a3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009a7:	79 83                	jns    80092c <vprintfmt+0x54>
				width = 0;
  8009a9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009b0:	e9 77 ff ff ff       	jmp    80092c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009b5:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009bc:	e9 6b ff ff ff       	jmp    80092c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009c1:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009c2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009c6:	0f 89 60 ff ff ff    	jns    80092c <vprintfmt+0x54>
				width = precision, precision = -1;
  8009cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009d2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009d9:	e9 4e ff ff ff       	jmp    80092c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009de:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009e1:	e9 46 ff ff ff       	jmp    80092c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e9:	83 c0 04             	add    $0x4,%eax
  8009ec:	89 45 14             	mov    %eax,0x14(%ebp)
  8009ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f2:	83 e8 04             	sub    $0x4,%eax
  8009f5:	8b 00                	mov    (%eax),%eax
  8009f7:	83 ec 08             	sub    $0x8,%esp
  8009fa:	ff 75 0c             	pushl  0xc(%ebp)
  8009fd:	50                   	push   %eax
  8009fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800a01:	ff d0                	call   *%eax
  800a03:	83 c4 10             	add    $0x10,%esp
			break;
  800a06:	e9 89 02 00 00       	jmp    800c94 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a0e:	83 c0 04             	add    $0x4,%eax
  800a11:	89 45 14             	mov    %eax,0x14(%ebp)
  800a14:	8b 45 14             	mov    0x14(%ebp),%eax
  800a17:	83 e8 04             	sub    $0x4,%eax
  800a1a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a1c:	85 db                	test   %ebx,%ebx
  800a1e:	79 02                	jns    800a22 <vprintfmt+0x14a>
				err = -err;
  800a20:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a22:	83 fb 64             	cmp    $0x64,%ebx
  800a25:	7f 0b                	jg     800a32 <vprintfmt+0x15a>
  800a27:	8b 34 9d 00 22 80 00 	mov    0x802200(,%ebx,4),%esi
  800a2e:	85 f6                	test   %esi,%esi
  800a30:	75 19                	jne    800a4b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a32:	53                   	push   %ebx
  800a33:	68 a5 23 80 00       	push   $0x8023a5
  800a38:	ff 75 0c             	pushl  0xc(%ebp)
  800a3b:	ff 75 08             	pushl  0x8(%ebp)
  800a3e:	e8 5e 02 00 00       	call   800ca1 <printfmt>
  800a43:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a46:	e9 49 02 00 00       	jmp    800c94 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a4b:	56                   	push   %esi
  800a4c:	68 ae 23 80 00       	push   $0x8023ae
  800a51:	ff 75 0c             	pushl  0xc(%ebp)
  800a54:	ff 75 08             	pushl  0x8(%ebp)
  800a57:	e8 45 02 00 00       	call   800ca1 <printfmt>
  800a5c:	83 c4 10             	add    $0x10,%esp
			break;
  800a5f:	e9 30 02 00 00       	jmp    800c94 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a64:	8b 45 14             	mov    0x14(%ebp),%eax
  800a67:	83 c0 04             	add    $0x4,%eax
  800a6a:	89 45 14             	mov    %eax,0x14(%ebp)
  800a6d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a70:	83 e8 04             	sub    $0x4,%eax
  800a73:	8b 30                	mov    (%eax),%esi
  800a75:	85 f6                	test   %esi,%esi
  800a77:	75 05                	jne    800a7e <vprintfmt+0x1a6>
				p = "(null)";
  800a79:	be b1 23 80 00       	mov    $0x8023b1,%esi
			if (width > 0 && padc != '-')
  800a7e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a82:	7e 6d                	jle    800af1 <vprintfmt+0x219>
  800a84:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a88:	74 67                	je     800af1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a8a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a8d:	83 ec 08             	sub    $0x8,%esp
  800a90:	50                   	push   %eax
  800a91:	56                   	push   %esi
  800a92:	e8 0c 03 00 00       	call   800da3 <strnlen>
  800a97:	83 c4 10             	add    $0x10,%esp
  800a9a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a9d:	eb 16                	jmp    800ab5 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a9f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800aa3:	83 ec 08             	sub    $0x8,%esp
  800aa6:	ff 75 0c             	pushl  0xc(%ebp)
  800aa9:	50                   	push   %eax
  800aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800aad:	ff d0                	call   *%eax
  800aaf:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ab2:	ff 4d e4             	decl   -0x1c(%ebp)
  800ab5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ab9:	7f e4                	jg     800a9f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800abb:	eb 34                	jmp    800af1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800abd:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ac1:	74 1c                	je     800adf <vprintfmt+0x207>
  800ac3:	83 fb 1f             	cmp    $0x1f,%ebx
  800ac6:	7e 05                	jle    800acd <vprintfmt+0x1f5>
  800ac8:	83 fb 7e             	cmp    $0x7e,%ebx
  800acb:	7e 12                	jle    800adf <vprintfmt+0x207>
					putch('?', putdat);
  800acd:	83 ec 08             	sub    $0x8,%esp
  800ad0:	ff 75 0c             	pushl  0xc(%ebp)
  800ad3:	6a 3f                	push   $0x3f
  800ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad8:	ff d0                	call   *%eax
  800ada:	83 c4 10             	add    $0x10,%esp
  800add:	eb 0f                	jmp    800aee <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800adf:	83 ec 08             	sub    $0x8,%esp
  800ae2:	ff 75 0c             	pushl  0xc(%ebp)
  800ae5:	53                   	push   %ebx
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	ff d0                	call   *%eax
  800aeb:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800aee:	ff 4d e4             	decl   -0x1c(%ebp)
  800af1:	89 f0                	mov    %esi,%eax
  800af3:	8d 70 01             	lea    0x1(%eax),%esi
  800af6:	8a 00                	mov    (%eax),%al
  800af8:	0f be d8             	movsbl %al,%ebx
  800afb:	85 db                	test   %ebx,%ebx
  800afd:	74 24                	je     800b23 <vprintfmt+0x24b>
  800aff:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b03:	78 b8                	js     800abd <vprintfmt+0x1e5>
  800b05:	ff 4d e0             	decl   -0x20(%ebp)
  800b08:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b0c:	79 af                	jns    800abd <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b0e:	eb 13                	jmp    800b23 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b10:	83 ec 08             	sub    $0x8,%esp
  800b13:	ff 75 0c             	pushl  0xc(%ebp)
  800b16:	6a 20                	push   $0x20
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	ff d0                	call   *%eax
  800b1d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b20:	ff 4d e4             	decl   -0x1c(%ebp)
  800b23:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b27:	7f e7                	jg     800b10 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b29:	e9 66 01 00 00       	jmp    800c94 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b2e:	83 ec 08             	sub    $0x8,%esp
  800b31:	ff 75 e8             	pushl  -0x18(%ebp)
  800b34:	8d 45 14             	lea    0x14(%ebp),%eax
  800b37:	50                   	push   %eax
  800b38:	e8 3c fd ff ff       	call   800879 <getint>
  800b3d:	83 c4 10             	add    $0x10,%esp
  800b40:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b43:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b46:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b49:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b4c:	85 d2                	test   %edx,%edx
  800b4e:	79 23                	jns    800b73 <vprintfmt+0x29b>
				putch('-', putdat);
  800b50:	83 ec 08             	sub    $0x8,%esp
  800b53:	ff 75 0c             	pushl  0xc(%ebp)
  800b56:	6a 2d                	push   $0x2d
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	ff d0                	call   *%eax
  800b5d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b60:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b63:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b66:	f7 d8                	neg    %eax
  800b68:	83 d2 00             	adc    $0x0,%edx
  800b6b:	f7 da                	neg    %edx
  800b6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b70:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b73:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b7a:	e9 bc 00 00 00       	jmp    800c3b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b7f:	83 ec 08             	sub    $0x8,%esp
  800b82:	ff 75 e8             	pushl  -0x18(%ebp)
  800b85:	8d 45 14             	lea    0x14(%ebp),%eax
  800b88:	50                   	push   %eax
  800b89:	e8 84 fc ff ff       	call   800812 <getuint>
  800b8e:	83 c4 10             	add    $0x10,%esp
  800b91:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b94:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b97:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b9e:	e9 98 00 00 00       	jmp    800c3b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ba3:	83 ec 08             	sub    $0x8,%esp
  800ba6:	ff 75 0c             	pushl  0xc(%ebp)
  800ba9:	6a 58                	push   $0x58
  800bab:	8b 45 08             	mov    0x8(%ebp),%eax
  800bae:	ff d0                	call   *%eax
  800bb0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bb3:	83 ec 08             	sub    $0x8,%esp
  800bb6:	ff 75 0c             	pushl  0xc(%ebp)
  800bb9:	6a 58                	push   $0x58
  800bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbe:	ff d0                	call   *%eax
  800bc0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bc3:	83 ec 08             	sub    $0x8,%esp
  800bc6:	ff 75 0c             	pushl  0xc(%ebp)
  800bc9:	6a 58                	push   $0x58
  800bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bce:	ff d0                	call   *%eax
  800bd0:	83 c4 10             	add    $0x10,%esp
			break;
  800bd3:	e9 bc 00 00 00       	jmp    800c94 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800bd8:	83 ec 08             	sub    $0x8,%esp
  800bdb:	ff 75 0c             	pushl  0xc(%ebp)
  800bde:	6a 30                	push   $0x30
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	ff d0                	call   *%eax
  800be5:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800be8:	83 ec 08             	sub    $0x8,%esp
  800beb:	ff 75 0c             	pushl  0xc(%ebp)
  800bee:	6a 78                	push   $0x78
  800bf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf3:	ff d0                	call   *%eax
  800bf5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800bf8:	8b 45 14             	mov    0x14(%ebp),%eax
  800bfb:	83 c0 04             	add    $0x4,%eax
  800bfe:	89 45 14             	mov    %eax,0x14(%ebp)
  800c01:	8b 45 14             	mov    0x14(%ebp),%eax
  800c04:	83 e8 04             	sub    $0x4,%eax
  800c07:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c09:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c0c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c13:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c1a:	eb 1f                	jmp    800c3b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c1c:	83 ec 08             	sub    $0x8,%esp
  800c1f:	ff 75 e8             	pushl  -0x18(%ebp)
  800c22:	8d 45 14             	lea    0x14(%ebp),%eax
  800c25:	50                   	push   %eax
  800c26:	e8 e7 fb ff ff       	call   800812 <getuint>
  800c2b:	83 c4 10             	add    $0x10,%esp
  800c2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c31:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c34:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c3b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c3f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c42:	83 ec 04             	sub    $0x4,%esp
  800c45:	52                   	push   %edx
  800c46:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c49:	50                   	push   %eax
  800c4a:	ff 75 f4             	pushl  -0xc(%ebp)
  800c4d:	ff 75 f0             	pushl  -0x10(%ebp)
  800c50:	ff 75 0c             	pushl  0xc(%ebp)
  800c53:	ff 75 08             	pushl  0x8(%ebp)
  800c56:	e8 00 fb ff ff       	call   80075b <printnum>
  800c5b:	83 c4 20             	add    $0x20,%esp
			break;
  800c5e:	eb 34                	jmp    800c94 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c60:	83 ec 08             	sub    $0x8,%esp
  800c63:	ff 75 0c             	pushl  0xc(%ebp)
  800c66:	53                   	push   %ebx
  800c67:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6a:	ff d0                	call   *%eax
  800c6c:	83 c4 10             	add    $0x10,%esp
			break;
  800c6f:	eb 23                	jmp    800c94 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c71:	83 ec 08             	sub    $0x8,%esp
  800c74:	ff 75 0c             	pushl  0xc(%ebp)
  800c77:	6a 25                	push   $0x25
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	ff d0                	call   *%eax
  800c7e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c81:	ff 4d 10             	decl   0x10(%ebp)
  800c84:	eb 03                	jmp    800c89 <vprintfmt+0x3b1>
  800c86:	ff 4d 10             	decl   0x10(%ebp)
  800c89:	8b 45 10             	mov    0x10(%ebp),%eax
  800c8c:	48                   	dec    %eax
  800c8d:	8a 00                	mov    (%eax),%al
  800c8f:	3c 25                	cmp    $0x25,%al
  800c91:	75 f3                	jne    800c86 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c93:	90                   	nop
		}
	}
  800c94:	e9 47 fc ff ff       	jmp    8008e0 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c99:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c9a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c9d:	5b                   	pop    %ebx
  800c9e:	5e                   	pop    %esi
  800c9f:	5d                   	pop    %ebp
  800ca0:	c3                   	ret    

00800ca1 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ca1:	55                   	push   %ebp
  800ca2:	89 e5                	mov    %esp,%ebp
  800ca4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ca7:	8d 45 10             	lea    0x10(%ebp),%eax
  800caa:	83 c0 04             	add    $0x4,%eax
  800cad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800cb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb3:	ff 75 f4             	pushl  -0xc(%ebp)
  800cb6:	50                   	push   %eax
  800cb7:	ff 75 0c             	pushl  0xc(%ebp)
  800cba:	ff 75 08             	pushl  0x8(%ebp)
  800cbd:	e8 16 fc ff ff       	call   8008d8 <vprintfmt>
  800cc2:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cc5:	90                   	nop
  800cc6:	c9                   	leave  
  800cc7:	c3                   	ret    

00800cc8 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800cc8:	55                   	push   %ebp
  800cc9:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ccb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cce:	8b 40 08             	mov    0x8(%eax),%eax
  800cd1:	8d 50 01             	lea    0x1(%eax),%edx
  800cd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd7:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800cda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cdd:	8b 10                	mov    (%eax),%edx
  800cdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce2:	8b 40 04             	mov    0x4(%eax),%eax
  800ce5:	39 c2                	cmp    %eax,%edx
  800ce7:	73 12                	jae    800cfb <sprintputch+0x33>
		*b->buf++ = ch;
  800ce9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cec:	8b 00                	mov    (%eax),%eax
  800cee:	8d 48 01             	lea    0x1(%eax),%ecx
  800cf1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf4:	89 0a                	mov    %ecx,(%edx)
  800cf6:	8b 55 08             	mov    0x8(%ebp),%edx
  800cf9:	88 10                	mov    %dl,(%eax)
}
  800cfb:	90                   	nop
  800cfc:	5d                   	pop    %ebp
  800cfd:	c3                   	ret    

00800cfe <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800cfe:	55                   	push   %ebp
  800cff:	89 e5                	mov    %esp,%ebp
  800d01:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	01 d0                	add    %edx,%eax
  800d15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d18:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d1f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d23:	74 06                	je     800d2b <vsnprintf+0x2d>
  800d25:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d29:	7f 07                	jg     800d32 <vsnprintf+0x34>
		return -E_INVAL;
  800d2b:	b8 03 00 00 00       	mov    $0x3,%eax
  800d30:	eb 20                	jmp    800d52 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d32:	ff 75 14             	pushl  0x14(%ebp)
  800d35:	ff 75 10             	pushl  0x10(%ebp)
  800d38:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d3b:	50                   	push   %eax
  800d3c:	68 c8 0c 80 00       	push   $0x800cc8
  800d41:	e8 92 fb ff ff       	call   8008d8 <vprintfmt>
  800d46:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d49:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d4c:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d52:	c9                   	leave  
  800d53:	c3                   	ret    

00800d54 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d54:	55                   	push   %ebp
  800d55:	89 e5                	mov    %esp,%ebp
  800d57:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d5a:	8d 45 10             	lea    0x10(%ebp),%eax
  800d5d:	83 c0 04             	add    $0x4,%eax
  800d60:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d63:	8b 45 10             	mov    0x10(%ebp),%eax
  800d66:	ff 75 f4             	pushl  -0xc(%ebp)
  800d69:	50                   	push   %eax
  800d6a:	ff 75 0c             	pushl  0xc(%ebp)
  800d6d:	ff 75 08             	pushl  0x8(%ebp)
  800d70:	e8 89 ff ff ff       	call   800cfe <vsnprintf>
  800d75:	83 c4 10             	add    $0x10,%esp
  800d78:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d7e:	c9                   	leave  
  800d7f:	c3                   	ret    

00800d80 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d80:	55                   	push   %ebp
  800d81:	89 e5                	mov    %esp,%ebp
  800d83:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d86:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d8d:	eb 06                	jmp    800d95 <strlen+0x15>
		n++;
  800d8f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d92:	ff 45 08             	incl   0x8(%ebp)
  800d95:	8b 45 08             	mov    0x8(%ebp),%eax
  800d98:	8a 00                	mov    (%eax),%al
  800d9a:	84 c0                	test   %al,%al
  800d9c:	75 f1                	jne    800d8f <strlen+0xf>
		n++;
	return n;
  800d9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800da1:	c9                   	leave  
  800da2:	c3                   	ret    

00800da3 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800da3:	55                   	push   %ebp
  800da4:	89 e5                	mov    %esp,%ebp
  800da6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800da9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800db0:	eb 09                	jmp    800dbb <strnlen+0x18>
		n++;
  800db2:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800db5:	ff 45 08             	incl   0x8(%ebp)
  800db8:	ff 4d 0c             	decl   0xc(%ebp)
  800dbb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dbf:	74 09                	je     800dca <strnlen+0x27>
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	8a 00                	mov    (%eax),%al
  800dc6:	84 c0                	test   %al,%al
  800dc8:	75 e8                	jne    800db2 <strnlen+0xf>
		n++;
	return n;
  800dca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dcd:	c9                   	leave  
  800dce:	c3                   	ret    

00800dcf <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800dcf:	55                   	push   %ebp
  800dd0:	89 e5                	mov    %esp,%ebp
  800dd2:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ddb:	90                   	nop
  800ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddf:	8d 50 01             	lea    0x1(%eax),%edx
  800de2:	89 55 08             	mov    %edx,0x8(%ebp)
  800de5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800de8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800deb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800dee:	8a 12                	mov    (%edx),%dl
  800df0:	88 10                	mov    %dl,(%eax)
  800df2:	8a 00                	mov    (%eax),%al
  800df4:	84 c0                	test   %al,%al
  800df6:	75 e4                	jne    800ddc <strcpy+0xd>
		/* do nothing */;
	return ret;
  800df8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dfb:	c9                   	leave  
  800dfc:	c3                   	ret    

00800dfd <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800dfd:	55                   	push   %ebp
  800dfe:	89 e5                	mov    %esp,%ebp
  800e00:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e09:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e10:	eb 1f                	jmp    800e31 <strncpy+0x34>
		*dst++ = *src;
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	8d 50 01             	lea    0x1(%eax),%edx
  800e18:	89 55 08             	mov    %edx,0x8(%ebp)
  800e1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e1e:	8a 12                	mov    (%edx),%dl
  800e20:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e25:	8a 00                	mov    (%eax),%al
  800e27:	84 c0                	test   %al,%al
  800e29:	74 03                	je     800e2e <strncpy+0x31>
			src++;
  800e2b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e2e:	ff 45 fc             	incl   -0x4(%ebp)
  800e31:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e34:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e37:	72 d9                	jb     800e12 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e39:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e3c:	c9                   	leave  
  800e3d:	c3                   	ret    

00800e3e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e3e:	55                   	push   %ebp
  800e3f:	89 e5                	mov    %esp,%ebp
  800e41:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e4a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e4e:	74 30                	je     800e80 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e50:	eb 16                	jmp    800e68 <strlcpy+0x2a>
			*dst++ = *src++;
  800e52:	8b 45 08             	mov    0x8(%ebp),%eax
  800e55:	8d 50 01             	lea    0x1(%eax),%edx
  800e58:	89 55 08             	mov    %edx,0x8(%ebp)
  800e5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e5e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e61:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e64:	8a 12                	mov    (%edx),%dl
  800e66:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e68:	ff 4d 10             	decl   0x10(%ebp)
  800e6b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e6f:	74 09                	je     800e7a <strlcpy+0x3c>
  800e71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e74:	8a 00                	mov    (%eax),%al
  800e76:	84 c0                	test   %al,%al
  800e78:	75 d8                	jne    800e52 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e80:	8b 55 08             	mov    0x8(%ebp),%edx
  800e83:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e86:	29 c2                	sub    %eax,%edx
  800e88:	89 d0                	mov    %edx,%eax
}
  800e8a:	c9                   	leave  
  800e8b:	c3                   	ret    

00800e8c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e8c:	55                   	push   %ebp
  800e8d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e8f:	eb 06                	jmp    800e97 <strcmp+0xb>
		p++, q++;
  800e91:	ff 45 08             	incl   0x8(%ebp)
  800e94:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e97:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9a:	8a 00                	mov    (%eax),%al
  800e9c:	84 c0                	test   %al,%al
  800e9e:	74 0e                	je     800eae <strcmp+0x22>
  800ea0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea3:	8a 10                	mov    (%eax),%dl
  800ea5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea8:	8a 00                	mov    (%eax),%al
  800eaa:	38 c2                	cmp    %al,%dl
  800eac:	74 e3                	je     800e91 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	8a 00                	mov    (%eax),%al
  800eb3:	0f b6 d0             	movzbl %al,%edx
  800eb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb9:	8a 00                	mov    (%eax),%al
  800ebb:	0f b6 c0             	movzbl %al,%eax
  800ebe:	29 c2                	sub    %eax,%edx
  800ec0:	89 d0                	mov    %edx,%eax
}
  800ec2:	5d                   	pop    %ebp
  800ec3:	c3                   	ret    

00800ec4 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ec4:	55                   	push   %ebp
  800ec5:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ec7:	eb 09                	jmp    800ed2 <strncmp+0xe>
		n--, p++, q++;
  800ec9:	ff 4d 10             	decl   0x10(%ebp)
  800ecc:	ff 45 08             	incl   0x8(%ebp)
  800ecf:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ed2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed6:	74 17                	je     800eef <strncmp+0x2b>
  800ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  800edb:	8a 00                	mov    (%eax),%al
  800edd:	84 c0                	test   %al,%al
  800edf:	74 0e                	je     800eef <strncmp+0x2b>
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	8a 10                	mov    (%eax),%dl
  800ee6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee9:	8a 00                	mov    (%eax),%al
  800eeb:	38 c2                	cmp    %al,%dl
  800eed:	74 da                	je     800ec9 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800eef:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ef3:	75 07                	jne    800efc <strncmp+0x38>
		return 0;
  800ef5:	b8 00 00 00 00       	mov    $0x0,%eax
  800efa:	eb 14                	jmp    800f10 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800efc:	8b 45 08             	mov    0x8(%ebp),%eax
  800eff:	8a 00                	mov    (%eax),%al
  800f01:	0f b6 d0             	movzbl %al,%edx
  800f04:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f07:	8a 00                	mov    (%eax),%al
  800f09:	0f b6 c0             	movzbl %al,%eax
  800f0c:	29 c2                	sub    %eax,%edx
  800f0e:	89 d0                	mov    %edx,%eax
}
  800f10:	5d                   	pop    %ebp
  800f11:	c3                   	ret    

00800f12 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f12:	55                   	push   %ebp
  800f13:	89 e5                	mov    %esp,%ebp
  800f15:	83 ec 04             	sub    $0x4,%esp
  800f18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f1e:	eb 12                	jmp    800f32 <strchr+0x20>
		if (*s == c)
  800f20:	8b 45 08             	mov    0x8(%ebp),%eax
  800f23:	8a 00                	mov    (%eax),%al
  800f25:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f28:	75 05                	jne    800f2f <strchr+0x1d>
			return (char *) s;
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	eb 11                	jmp    800f40 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f2f:	ff 45 08             	incl   0x8(%ebp)
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
  800f35:	8a 00                	mov    (%eax),%al
  800f37:	84 c0                	test   %al,%al
  800f39:	75 e5                	jne    800f20 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f3b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f40:	c9                   	leave  
  800f41:	c3                   	ret    

00800f42 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f42:	55                   	push   %ebp
  800f43:	89 e5                	mov    %esp,%ebp
  800f45:	83 ec 04             	sub    $0x4,%esp
  800f48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f4e:	eb 0d                	jmp    800f5d <strfind+0x1b>
		if (*s == c)
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	8a 00                	mov    (%eax),%al
  800f55:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f58:	74 0e                	je     800f68 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f5a:	ff 45 08             	incl   0x8(%ebp)
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f60:	8a 00                	mov    (%eax),%al
  800f62:	84 c0                	test   %al,%al
  800f64:	75 ea                	jne    800f50 <strfind+0xe>
  800f66:	eb 01                	jmp    800f69 <strfind+0x27>
		if (*s == c)
			break;
  800f68:	90                   	nop
	return (char *) s;
  800f69:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f6c:	c9                   	leave  
  800f6d:	c3                   	ret    

00800f6e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f6e:	55                   	push   %ebp
  800f6f:	89 e5                	mov    %esp,%ebp
  800f71:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f80:	eb 0e                	jmp    800f90 <memset+0x22>
		*p++ = c;
  800f82:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f85:	8d 50 01             	lea    0x1(%eax),%edx
  800f88:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f8e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f90:	ff 4d f8             	decl   -0x8(%ebp)
  800f93:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f97:	79 e9                	jns    800f82 <memset+0x14>
		*p++ = c;

	return v;
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f9c:	c9                   	leave  
  800f9d:	c3                   	ret    

00800f9e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f9e:	55                   	push   %ebp
  800f9f:	89 e5                	mov    %esp,%ebp
  800fa1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fa4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800faa:	8b 45 08             	mov    0x8(%ebp),%eax
  800fad:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800fb0:	eb 16                	jmp    800fc8 <memcpy+0x2a>
		*d++ = *s++;
  800fb2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb5:	8d 50 01             	lea    0x1(%eax),%edx
  800fb8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fbb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fbe:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fc1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fc4:	8a 12                	mov    (%edx),%dl
  800fc6:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800fc8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fce:	89 55 10             	mov    %edx,0x10(%ebp)
  800fd1:	85 c0                	test   %eax,%eax
  800fd3:	75 dd                	jne    800fb2 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fd8:	c9                   	leave  
  800fd9:	c3                   	ret    

00800fda <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fda:	55                   	push   %ebp
  800fdb:	89 e5                	mov    %esp,%ebp
  800fdd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800fe0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fe6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800fec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fef:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ff2:	73 50                	jae    801044 <memmove+0x6a>
  800ff4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ff7:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffa:	01 d0                	add    %edx,%eax
  800ffc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fff:	76 43                	jbe    801044 <memmove+0x6a>
		s += n;
  801001:	8b 45 10             	mov    0x10(%ebp),%eax
  801004:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801007:	8b 45 10             	mov    0x10(%ebp),%eax
  80100a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80100d:	eb 10                	jmp    80101f <memmove+0x45>
			*--d = *--s;
  80100f:	ff 4d f8             	decl   -0x8(%ebp)
  801012:	ff 4d fc             	decl   -0x4(%ebp)
  801015:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801018:	8a 10                	mov    (%eax),%dl
  80101a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80101f:	8b 45 10             	mov    0x10(%ebp),%eax
  801022:	8d 50 ff             	lea    -0x1(%eax),%edx
  801025:	89 55 10             	mov    %edx,0x10(%ebp)
  801028:	85 c0                	test   %eax,%eax
  80102a:	75 e3                	jne    80100f <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80102c:	eb 23                	jmp    801051 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80102e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801031:	8d 50 01             	lea    0x1(%eax),%edx
  801034:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801037:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80103a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80103d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801040:	8a 12                	mov    (%edx),%dl
  801042:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801044:	8b 45 10             	mov    0x10(%ebp),%eax
  801047:	8d 50 ff             	lea    -0x1(%eax),%edx
  80104a:	89 55 10             	mov    %edx,0x10(%ebp)
  80104d:	85 c0                	test   %eax,%eax
  80104f:	75 dd                	jne    80102e <memmove+0x54>
			*d++ = *s++;

	return dst;
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801054:	c9                   	leave  
  801055:	c3                   	ret    

00801056 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801056:	55                   	push   %ebp
  801057:	89 e5                	mov    %esp,%ebp
  801059:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801062:	8b 45 0c             	mov    0xc(%ebp),%eax
  801065:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801068:	eb 2a                	jmp    801094 <memcmp+0x3e>
		if (*s1 != *s2)
  80106a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80106d:	8a 10                	mov    (%eax),%dl
  80106f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801072:	8a 00                	mov    (%eax),%al
  801074:	38 c2                	cmp    %al,%dl
  801076:	74 16                	je     80108e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801078:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80107b:	8a 00                	mov    (%eax),%al
  80107d:	0f b6 d0             	movzbl %al,%edx
  801080:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801083:	8a 00                	mov    (%eax),%al
  801085:	0f b6 c0             	movzbl %al,%eax
  801088:	29 c2                	sub    %eax,%edx
  80108a:	89 d0                	mov    %edx,%eax
  80108c:	eb 18                	jmp    8010a6 <memcmp+0x50>
		s1++, s2++;
  80108e:	ff 45 fc             	incl   -0x4(%ebp)
  801091:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801094:	8b 45 10             	mov    0x10(%ebp),%eax
  801097:	8d 50 ff             	lea    -0x1(%eax),%edx
  80109a:	89 55 10             	mov    %edx,0x10(%ebp)
  80109d:	85 c0                	test   %eax,%eax
  80109f:	75 c9                	jne    80106a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010a6:	c9                   	leave  
  8010a7:	c3                   	ret    

008010a8 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010a8:	55                   	push   %ebp
  8010a9:	89 e5                	mov    %esp,%ebp
  8010ab:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010ae:	8b 55 08             	mov    0x8(%ebp),%edx
  8010b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b4:	01 d0                	add    %edx,%eax
  8010b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010b9:	eb 15                	jmp    8010d0 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	8a 00                	mov    (%eax),%al
  8010c0:	0f b6 d0             	movzbl %al,%edx
  8010c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c6:	0f b6 c0             	movzbl %al,%eax
  8010c9:	39 c2                	cmp    %eax,%edx
  8010cb:	74 0d                	je     8010da <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010cd:	ff 45 08             	incl   0x8(%ebp)
  8010d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010d6:	72 e3                	jb     8010bb <memfind+0x13>
  8010d8:	eb 01                	jmp    8010db <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010da:	90                   	nop
	return (void *) s;
  8010db:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010de:	c9                   	leave  
  8010df:	c3                   	ret    

008010e0 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010e0:	55                   	push   %ebp
  8010e1:	89 e5                	mov    %esp,%ebp
  8010e3:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010ed:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010f4:	eb 03                	jmp    8010f9 <strtol+0x19>
		s++;
  8010f6:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fc:	8a 00                	mov    (%eax),%al
  8010fe:	3c 20                	cmp    $0x20,%al
  801100:	74 f4                	je     8010f6 <strtol+0x16>
  801102:	8b 45 08             	mov    0x8(%ebp),%eax
  801105:	8a 00                	mov    (%eax),%al
  801107:	3c 09                	cmp    $0x9,%al
  801109:	74 eb                	je     8010f6 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80110b:	8b 45 08             	mov    0x8(%ebp),%eax
  80110e:	8a 00                	mov    (%eax),%al
  801110:	3c 2b                	cmp    $0x2b,%al
  801112:	75 05                	jne    801119 <strtol+0x39>
		s++;
  801114:	ff 45 08             	incl   0x8(%ebp)
  801117:	eb 13                	jmp    80112c <strtol+0x4c>
	else if (*s == '-')
  801119:	8b 45 08             	mov    0x8(%ebp),%eax
  80111c:	8a 00                	mov    (%eax),%al
  80111e:	3c 2d                	cmp    $0x2d,%al
  801120:	75 0a                	jne    80112c <strtol+0x4c>
		s++, neg = 1;
  801122:	ff 45 08             	incl   0x8(%ebp)
  801125:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80112c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801130:	74 06                	je     801138 <strtol+0x58>
  801132:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801136:	75 20                	jne    801158 <strtol+0x78>
  801138:	8b 45 08             	mov    0x8(%ebp),%eax
  80113b:	8a 00                	mov    (%eax),%al
  80113d:	3c 30                	cmp    $0x30,%al
  80113f:	75 17                	jne    801158 <strtol+0x78>
  801141:	8b 45 08             	mov    0x8(%ebp),%eax
  801144:	40                   	inc    %eax
  801145:	8a 00                	mov    (%eax),%al
  801147:	3c 78                	cmp    $0x78,%al
  801149:	75 0d                	jne    801158 <strtol+0x78>
		s += 2, base = 16;
  80114b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80114f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801156:	eb 28                	jmp    801180 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801158:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80115c:	75 15                	jne    801173 <strtol+0x93>
  80115e:	8b 45 08             	mov    0x8(%ebp),%eax
  801161:	8a 00                	mov    (%eax),%al
  801163:	3c 30                	cmp    $0x30,%al
  801165:	75 0c                	jne    801173 <strtol+0x93>
		s++, base = 8;
  801167:	ff 45 08             	incl   0x8(%ebp)
  80116a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801171:	eb 0d                	jmp    801180 <strtol+0xa0>
	else if (base == 0)
  801173:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801177:	75 07                	jne    801180 <strtol+0xa0>
		base = 10;
  801179:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801180:	8b 45 08             	mov    0x8(%ebp),%eax
  801183:	8a 00                	mov    (%eax),%al
  801185:	3c 2f                	cmp    $0x2f,%al
  801187:	7e 19                	jle    8011a2 <strtol+0xc2>
  801189:	8b 45 08             	mov    0x8(%ebp),%eax
  80118c:	8a 00                	mov    (%eax),%al
  80118e:	3c 39                	cmp    $0x39,%al
  801190:	7f 10                	jg     8011a2 <strtol+0xc2>
			dig = *s - '0';
  801192:	8b 45 08             	mov    0x8(%ebp),%eax
  801195:	8a 00                	mov    (%eax),%al
  801197:	0f be c0             	movsbl %al,%eax
  80119a:	83 e8 30             	sub    $0x30,%eax
  80119d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011a0:	eb 42                	jmp    8011e4 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a5:	8a 00                	mov    (%eax),%al
  8011a7:	3c 60                	cmp    $0x60,%al
  8011a9:	7e 19                	jle    8011c4 <strtol+0xe4>
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ae:	8a 00                	mov    (%eax),%al
  8011b0:	3c 7a                	cmp    $0x7a,%al
  8011b2:	7f 10                	jg     8011c4 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b7:	8a 00                	mov    (%eax),%al
  8011b9:	0f be c0             	movsbl %al,%eax
  8011bc:	83 e8 57             	sub    $0x57,%eax
  8011bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011c2:	eb 20                	jmp    8011e4 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c7:	8a 00                	mov    (%eax),%al
  8011c9:	3c 40                	cmp    $0x40,%al
  8011cb:	7e 39                	jle    801206 <strtol+0x126>
  8011cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d0:	8a 00                	mov    (%eax),%al
  8011d2:	3c 5a                	cmp    $0x5a,%al
  8011d4:	7f 30                	jg     801206 <strtol+0x126>
			dig = *s - 'A' + 10;
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	8a 00                	mov    (%eax),%al
  8011db:	0f be c0             	movsbl %al,%eax
  8011de:	83 e8 37             	sub    $0x37,%eax
  8011e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011e7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011ea:	7d 19                	jge    801205 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011ec:	ff 45 08             	incl   0x8(%ebp)
  8011ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f2:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011f6:	89 c2                	mov    %eax,%edx
  8011f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011fb:	01 d0                	add    %edx,%eax
  8011fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801200:	e9 7b ff ff ff       	jmp    801180 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801205:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801206:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80120a:	74 08                	je     801214 <strtol+0x134>
		*endptr = (char *) s;
  80120c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120f:	8b 55 08             	mov    0x8(%ebp),%edx
  801212:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801214:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801218:	74 07                	je     801221 <strtol+0x141>
  80121a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80121d:	f7 d8                	neg    %eax
  80121f:	eb 03                	jmp    801224 <strtol+0x144>
  801221:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801224:	c9                   	leave  
  801225:	c3                   	ret    

00801226 <ltostr>:

void
ltostr(long value, char *str)
{
  801226:	55                   	push   %ebp
  801227:	89 e5                	mov    %esp,%ebp
  801229:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80122c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801233:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80123a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80123e:	79 13                	jns    801253 <ltostr+0x2d>
	{
		neg = 1;
  801240:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801247:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124a:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80124d:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801250:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801253:	8b 45 08             	mov    0x8(%ebp),%eax
  801256:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80125b:	99                   	cltd   
  80125c:	f7 f9                	idiv   %ecx
  80125e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801261:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801264:	8d 50 01             	lea    0x1(%eax),%edx
  801267:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80126a:	89 c2                	mov    %eax,%edx
  80126c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126f:	01 d0                	add    %edx,%eax
  801271:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801274:	83 c2 30             	add    $0x30,%edx
  801277:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801279:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80127c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801281:	f7 e9                	imul   %ecx
  801283:	c1 fa 02             	sar    $0x2,%edx
  801286:	89 c8                	mov    %ecx,%eax
  801288:	c1 f8 1f             	sar    $0x1f,%eax
  80128b:	29 c2                	sub    %eax,%edx
  80128d:	89 d0                	mov    %edx,%eax
  80128f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801292:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801295:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80129a:	f7 e9                	imul   %ecx
  80129c:	c1 fa 02             	sar    $0x2,%edx
  80129f:	89 c8                	mov    %ecx,%eax
  8012a1:	c1 f8 1f             	sar    $0x1f,%eax
  8012a4:	29 c2                	sub    %eax,%edx
  8012a6:	89 d0                	mov    %edx,%eax
  8012a8:	c1 e0 02             	shl    $0x2,%eax
  8012ab:	01 d0                	add    %edx,%eax
  8012ad:	01 c0                	add    %eax,%eax
  8012af:	29 c1                	sub    %eax,%ecx
  8012b1:	89 ca                	mov    %ecx,%edx
  8012b3:	85 d2                	test   %edx,%edx
  8012b5:	75 9c                	jne    801253 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012b7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c1:	48                   	dec    %eax
  8012c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012c5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012c9:	74 3d                	je     801308 <ltostr+0xe2>
		start = 1 ;
  8012cb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012d2:	eb 34                	jmp    801308 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8012d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012da:	01 d0                	add    %edx,%eax
  8012dc:	8a 00                	mov    (%eax),%al
  8012de:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e7:	01 c2                	add    %eax,%edx
  8012e9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ef:	01 c8                	add    %ecx,%eax
  8012f1:	8a 00                	mov    (%eax),%al
  8012f3:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012f5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fb:	01 c2                	add    %eax,%edx
  8012fd:	8a 45 eb             	mov    -0x15(%ebp),%al
  801300:	88 02                	mov    %al,(%edx)
		start++ ;
  801302:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801305:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801308:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80130b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80130e:	7c c4                	jl     8012d4 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801310:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801313:	8b 45 0c             	mov    0xc(%ebp),%eax
  801316:	01 d0                	add    %edx,%eax
  801318:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80131b:	90                   	nop
  80131c:	c9                   	leave  
  80131d:	c3                   	ret    

0080131e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
  801321:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801324:	ff 75 08             	pushl  0x8(%ebp)
  801327:	e8 54 fa ff ff       	call   800d80 <strlen>
  80132c:	83 c4 04             	add    $0x4,%esp
  80132f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801332:	ff 75 0c             	pushl  0xc(%ebp)
  801335:	e8 46 fa ff ff       	call   800d80 <strlen>
  80133a:	83 c4 04             	add    $0x4,%esp
  80133d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801340:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801347:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80134e:	eb 17                	jmp    801367 <strcconcat+0x49>
		final[s] = str1[s] ;
  801350:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801353:	8b 45 10             	mov    0x10(%ebp),%eax
  801356:	01 c2                	add    %eax,%edx
  801358:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80135b:	8b 45 08             	mov    0x8(%ebp),%eax
  80135e:	01 c8                	add    %ecx,%eax
  801360:	8a 00                	mov    (%eax),%al
  801362:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801364:	ff 45 fc             	incl   -0x4(%ebp)
  801367:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80136a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80136d:	7c e1                	jl     801350 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80136f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801376:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80137d:	eb 1f                	jmp    80139e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80137f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801382:	8d 50 01             	lea    0x1(%eax),%edx
  801385:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801388:	89 c2                	mov    %eax,%edx
  80138a:	8b 45 10             	mov    0x10(%ebp),%eax
  80138d:	01 c2                	add    %eax,%edx
  80138f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801392:	8b 45 0c             	mov    0xc(%ebp),%eax
  801395:	01 c8                	add    %ecx,%eax
  801397:	8a 00                	mov    (%eax),%al
  801399:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80139b:	ff 45 f8             	incl   -0x8(%ebp)
  80139e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013a1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013a4:	7c d9                	jl     80137f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013a6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ac:	01 d0                	add    %edx,%eax
  8013ae:	c6 00 00             	movb   $0x0,(%eax)
}
  8013b1:	90                   	nop
  8013b2:	c9                   	leave  
  8013b3:	c3                   	ret    

008013b4 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013b4:	55                   	push   %ebp
  8013b5:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8013ba:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8013c3:	8b 00                	mov    (%eax),%eax
  8013c5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8013cf:	01 d0                	add    %edx,%eax
  8013d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013d7:	eb 0c                	jmp    8013e5 <strsplit+0x31>
			*string++ = 0;
  8013d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dc:	8d 50 01             	lea    0x1(%eax),%edx
  8013df:	89 55 08             	mov    %edx,0x8(%ebp)
  8013e2:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e8:	8a 00                	mov    (%eax),%al
  8013ea:	84 c0                	test   %al,%al
  8013ec:	74 18                	je     801406 <strsplit+0x52>
  8013ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f1:	8a 00                	mov    (%eax),%al
  8013f3:	0f be c0             	movsbl %al,%eax
  8013f6:	50                   	push   %eax
  8013f7:	ff 75 0c             	pushl  0xc(%ebp)
  8013fa:	e8 13 fb ff ff       	call   800f12 <strchr>
  8013ff:	83 c4 08             	add    $0x8,%esp
  801402:	85 c0                	test   %eax,%eax
  801404:	75 d3                	jne    8013d9 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	8a 00                	mov    (%eax),%al
  80140b:	84 c0                	test   %al,%al
  80140d:	74 5a                	je     801469 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80140f:	8b 45 14             	mov    0x14(%ebp),%eax
  801412:	8b 00                	mov    (%eax),%eax
  801414:	83 f8 0f             	cmp    $0xf,%eax
  801417:	75 07                	jne    801420 <strsplit+0x6c>
		{
			return 0;
  801419:	b8 00 00 00 00       	mov    $0x0,%eax
  80141e:	eb 66                	jmp    801486 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801420:	8b 45 14             	mov    0x14(%ebp),%eax
  801423:	8b 00                	mov    (%eax),%eax
  801425:	8d 48 01             	lea    0x1(%eax),%ecx
  801428:	8b 55 14             	mov    0x14(%ebp),%edx
  80142b:	89 0a                	mov    %ecx,(%edx)
  80142d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801434:	8b 45 10             	mov    0x10(%ebp),%eax
  801437:	01 c2                	add    %eax,%edx
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80143e:	eb 03                	jmp    801443 <strsplit+0x8f>
			string++;
  801440:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	8a 00                	mov    (%eax),%al
  801448:	84 c0                	test   %al,%al
  80144a:	74 8b                	je     8013d7 <strsplit+0x23>
  80144c:	8b 45 08             	mov    0x8(%ebp),%eax
  80144f:	8a 00                	mov    (%eax),%al
  801451:	0f be c0             	movsbl %al,%eax
  801454:	50                   	push   %eax
  801455:	ff 75 0c             	pushl  0xc(%ebp)
  801458:	e8 b5 fa ff ff       	call   800f12 <strchr>
  80145d:	83 c4 08             	add    $0x8,%esp
  801460:	85 c0                	test   %eax,%eax
  801462:	74 dc                	je     801440 <strsplit+0x8c>
			string++;
	}
  801464:	e9 6e ff ff ff       	jmp    8013d7 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801469:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80146a:	8b 45 14             	mov    0x14(%ebp),%eax
  80146d:	8b 00                	mov    (%eax),%eax
  80146f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801476:	8b 45 10             	mov    0x10(%ebp),%eax
  801479:	01 d0                	add    %edx,%eax
  80147b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801481:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801486:	c9                   	leave  
  801487:	c3                   	ret    

00801488 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801488:	55                   	push   %ebp
  801489:	89 e5                	mov    %esp,%ebp
  80148b:	83 ec 18             	sub    $0x18,%esp
  80148e:	8b 45 10             	mov    0x10(%ebp),%eax
  801491:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801494:	83 ec 04             	sub    $0x4,%esp
  801497:	68 10 25 80 00       	push   $0x802510
  80149c:	6a 17                	push   $0x17
  80149e:	68 2f 25 80 00       	push   $0x80252f
  8014a3:	e8 a2 ef ff ff       	call   80044a <_panic>

008014a8 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8014a8:	55                   	push   %ebp
  8014a9:	89 e5                	mov    %esp,%ebp
  8014ab:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8014ae:	83 ec 04             	sub    $0x4,%esp
  8014b1:	68 3b 25 80 00       	push   $0x80253b
  8014b6:	6a 2f                	push   $0x2f
  8014b8:	68 2f 25 80 00       	push   $0x80252f
  8014bd:	e8 88 ef ff ff       	call   80044a <_panic>

008014c2 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8014c2:	55                   	push   %ebp
  8014c3:	89 e5                	mov    %esp,%ebp
  8014c5:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8014c8:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8014cf:	8b 55 08             	mov    0x8(%ebp),%edx
  8014d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014d5:	01 d0                	add    %edx,%eax
  8014d7:	48                   	dec    %eax
  8014d8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8014db:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014de:	ba 00 00 00 00       	mov    $0x0,%edx
  8014e3:	f7 75 ec             	divl   -0x14(%ebp)
  8014e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014e9:	29 d0                	sub    %edx,%eax
  8014eb:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8014ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f1:	c1 e8 0c             	shr    $0xc,%eax
  8014f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8014f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8014fe:	e9 c8 00 00 00       	jmp    8015cb <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801503:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80150a:	eb 27                	jmp    801533 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  80150c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80150f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801512:	01 c2                	add    %eax,%edx
  801514:	89 d0                	mov    %edx,%eax
  801516:	01 c0                	add    %eax,%eax
  801518:	01 d0                	add    %edx,%eax
  80151a:	c1 e0 02             	shl    $0x2,%eax
  80151d:	05 48 30 80 00       	add    $0x803048,%eax
  801522:	8b 00                	mov    (%eax),%eax
  801524:	85 c0                	test   %eax,%eax
  801526:	74 08                	je     801530 <malloc+0x6e>
            	i += j;
  801528:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80152b:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  80152e:	eb 0b                	jmp    80153b <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801530:	ff 45 f0             	incl   -0x10(%ebp)
  801533:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801536:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801539:	72 d1                	jb     80150c <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  80153b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80153e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801541:	0f 85 81 00 00 00    	jne    8015c8 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801547:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80154a:	05 00 00 08 00       	add    $0x80000,%eax
  80154f:	c1 e0 0c             	shl    $0xc,%eax
  801552:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801555:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80155c:	eb 1f                	jmp    80157d <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  80155e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801561:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801564:	01 c2                	add    %eax,%edx
  801566:	89 d0                	mov    %edx,%eax
  801568:	01 c0                	add    %eax,%eax
  80156a:	01 d0                	add    %edx,%eax
  80156c:	c1 e0 02             	shl    $0x2,%eax
  80156f:	05 48 30 80 00       	add    $0x803048,%eax
  801574:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80157a:	ff 45 f0             	incl   -0x10(%ebp)
  80157d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801580:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801583:	72 d9                	jb     80155e <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801585:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801588:	89 d0                	mov    %edx,%eax
  80158a:	01 c0                	add    %eax,%eax
  80158c:	01 d0                	add    %edx,%eax
  80158e:	c1 e0 02             	shl    $0x2,%eax
  801591:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801597:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80159a:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  80159c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80159f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8015a2:	89 c8                	mov    %ecx,%eax
  8015a4:	01 c0                	add    %eax,%eax
  8015a6:	01 c8                	add    %ecx,%eax
  8015a8:	c1 e0 02             	shl    $0x2,%eax
  8015ab:	05 44 30 80 00       	add    $0x803044,%eax
  8015b0:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8015b2:	83 ec 08             	sub    $0x8,%esp
  8015b5:	ff 75 08             	pushl  0x8(%ebp)
  8015b8:	ff 75 e0             	pushl  -0x20(%ebp)
  8015bb:	e8 2b 03 00 00       	call   8018eb <sys_allocateMem>
  8015c0:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8015c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015c6:	eb 19                	jmp    8015e1 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8015c8:	ff 45 f4             	incl   -0xc(%ebp)
  8015cb:	a1 04 30 80 00       	mov    0x803004,%eax
  8015d0:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8015d3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015d6:	0f 83 27 ff ff ff    	jae    801503 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8015dc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e1:	c9                   	leave  
  8015e2:	c3                   	ret    

008015e3 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8015e3:	55                   	push   %ebp
  8015e4:	89 e5                	mov    %esp,%ebp
  8015e6:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8015e9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015ed:	0f 84 e5 00 00 00    	je     8016d8 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8015f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8015f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015fc:	05 00 00 00 80       	add    $0x80000000,%eax
  801601:	c1 e8 0c             	shr    $0xc,%eax
  801604:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801607:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80160a:	89 d0                	mov    %edx,%eax
  80160c:	01 c0                	add    %eax,%eax
  80160e:	01 d0                	add    %edx,%eax
  801610:	c1 e0 02             	shl    $0x2,%eax
  801613:	05 40 30 80 00       	add    $0x803040,%eax
  801618:	8b 00                	mov    (%eax),%eax
  80161a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80161d:	0f 85 b8 00 00 00    	jne    8016db <free+0xf8>
  801623:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801626:	89 d0                	mov    %edx,%eax
  801628:	01 c0                	add    %eax,%eax
  80162a:	01 d0                	add    %edx,%eax
  80162c:	c1 e0 02             	shl    $0x2,%eax
  80162f:	05 48 30 80 00       	add    $0x803048,%eax
  801634:	8b 00                	mov    (%eax),%eax
  801636:	85 c0                	test   %eax,%eax
  801638:	0f 84 9d 00 00 00    	je     8016db <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  80163e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801641:	89 d0                	mov    %edx,%eax
  801643:	01 c0                	add    %eax,%eax
  801645:	01 d0                	add    %edx,%eax
  801647:	c1 e0 02             	shl    $0x2,%eax
  80164a:	05 44 30 80 00       	add    $0x803044,%eax
  80164f:	8b 00                	mov    (%eax),%eax
  801651:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801654:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801657:	c1 e0 0c             	shl    $0xc,%eax
  80165a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  80165d:	83 ec 08             	sub    $0x8,%esp
  801660:	ff 75 e4             	pushl  -0x1c(%ebp)
  801663:	ff 75 f0             	pushl  -0x10(%ebp)
  801666:	e8 64 02 00 00       	call   8018cf <sys_freeMem>
  80166b:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80166e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801675:	eb 57                	jmp    8016ce <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801677:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80167a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80167d:	01 c2                	add    %eax,%edx
  80167f:	89 d0                	mov    %edx,%eax
  801681:	01 c0                	add    %eax,%eax
  801683:	01 d0                	add    %edx,%eax
  801685:	c1 e0 02             	shl    $0x2,%eax
  801688:	05 48 30 80 00       	add    $0x803048,%eax
  80168d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801693:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801696:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801699:	01 c2                	add    %eax,%edx
  80169b:	89 d0                	mov    %edx,%eax
  80169d:	01 c0                	add    %eax,%eax
  80169f:	01 d0                	add    %edx,%eax
  8016a1:	c1 e0 02             	shl    $0x2,%eax
  8016a4:	05 40 30 80 00       	add    $0x803040,%eax
  8016a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8016af:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b5:	01 c2                	add    %eax,%edx
  8016b7:	89 d0                	mov    %edx,%eax
  8016b9:	01 c0                	add    %eax,%eax
  8016bb:	01 d0                	add    %edx,%eax
  8016bd:	c1 e0 02             	shl    $0x2,%eax
  8016c0:	05 44 30 80 00       	add    $0x803044,%eax
  8016c5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8016cb:	ff 45 f4             	incl   -0xc(%ebp)
  8016ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016d1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8016d4:	7c a1                	jl     801677 <free+0x94>
  8016d6:	eb 04                	jmp    8016dc <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8016d8:	90                   	nop
  8016d9:	eb 01                	jmp    8016dc <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8016db:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
  8016e1:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8016e4:	83 ec 04             	sub    $0x4,%esp
  8016e7:	68 58 25 80 00       	push   $0x802558
  8016ec:	68 ae 00 00 00       	push   $0xae
  8016f1:	68 2f 25 80 00       	push   $0x80252f
  8016f6:	e8 4f ed ff ff       	call   80044a <_panic>

008016fb <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8016fb:	55                   	push   %ebp
  8016fc:	89 e5                	mov    %esp,%ebp
  8016fe:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801701:	83 ec 04             	sub    $0x4,%esp
  801704:	68 78 25 80 00       	push   $0x802578
  801709:	68 ca 00 00 00       	push   $0xca
  80170e:	68 2f 25 80 00       	push   $0x80252f
  801713:	e8 32 ed ff ff       	call   80044a <_panic>

00801718 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
  80171b:	57                   	push   %edi
  80171c:	56                   	push   %esi
  80171d:	53                   	push   %ebx
  80171e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801721:	8b 45 08             	mov    0x8(%ebp),%eax
  801724:	8b 55 0c             	mov    0xc(%ebp),%edx
  801727:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80172a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80172d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801730:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801733:	cd 30                	int    $0x30
  801735:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801738:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80173b:	83 c4 10             	add    $0x10,%esp
  80173e:	5b                   	pop    %ebx
  80173f:	5e                   	pop    %esi
  801740:	5f                   	pop    %edi
  801741:	5d                   	pop    %ebp
  801742:	c3                   	ret    

00801743 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801743:	55                   	push   %ebp
  801744:	89 e5                	mov    %esp,%ebp
  801746:	83 ec 04             	sub    $0x4,%esp
  801749:	8b 45 10             	mov    0x10(%ebp),%eax
  80174c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80174f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801753:	8b 45 08             	mov    0x8(%ebp),%eax
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	52                   	push   %edx
  80175b:	ff 75 0c             	pushl  0xc(%ebp)
  80175e:	50                   	push   %eax
  80175f:	6a 00                	push   $0x0
  801761:	e8 b2 ff ff ff       	call   801718 <syscall>
  801766:	83 c4 18             	add    $0x18,%esp
}
  801769:	90                   	nop
  80176a:	c9                   	leave  
  80176b:	c3                   	ret    

0080176c <sys_cgetc>:

int
sys_cgetc(void)
{
  80176c:	55                   	push   %ebp
  80176d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 01                	push   $0x1
  80177b:	e8 98 ff ff ff       	call   801718 <syscall>
  801780:	83 c4 18             	add    $0x18,%esp
}
  801783:	c9                   	leave  
  801784:	c3                   	ret    

00801785 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801785:	55                   	push   %ebp
  801786:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801788:	8b 45 08             	mov    0x8(%ebp),%eax
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	50                   	push   %eax
  801794:	6a 05                	push   $0x5
  801796:	e8 7d ff ff ff       	call   801718 <syscall>
  80179b:	83 c4 18             	add    $0x18,%esp
}
  80179e:	c9                   	leave  
  80179f:	c3                   	ret    

008017a0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017a0:	55                   	push   %ebp
  8017a1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 02                	push   $0x2
  8017af:	e8 64 ff ff ff       	call   801718 <syscall>
  8017b4:	83 c4 18             	add    $0x18,%esp
}
  8017b7:	c9                   	leave  
  8017b8:	c3                   	ret    

008017b9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017b9:	55                   	push   %ebp
  8017ba:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 03                	push   $0x3
  8017c8:	e8 4b ff ff ff       	call   801718 <syscall>
  8017cd:	83 c4 18             	add    $0x18,%esp
}
  8017d0:	c9                   	leave  
  8017d1:	c3                   	ret    

008017d2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017d2:	55                   	push   %ebp
  8017d3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 04                	push   $0x4
  8017e1:	e8 32 ff ff ff       	call   801718 <syscall>
  8017e6:	83 c4 18             	add    $0x18,%esp
}
  8017e9:	c9                   	leave  
  8017ea:	c3                   	ret    

008017eb <sys_env_exit>:


void sys_env_exit(void)
{
  8017eb:	55                   	push   %ebp
  8017ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 06                	push   $0x6
  8017fa:	e8 19 ff ff ff       	call   801718 <syscall>
  8017ff:	83 c4 18             	add    $0x18,%esp
}
  801802:	90                   	nop
  801803:	c9                   	leave  
  801804:	c3                   	ret    

00801805 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801805:	55                   	push   %ebp
  801806:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801808:	8b 55 0c             	mov    0xc(%ebp),%edx
  80180b:	8b 45 08             	mov    0x8(%ebp),%eax
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	52                   	push   %edx
  801815:	50                   	push   %eax
  801816:	6a 07                	push   $0x7
  801818:	e8 fb fe ff ff       	call   801718 <syscall>
  80181d:	83 c4 18             	add    $0x18,%esp
}
  801820:	c9                   	leave  
  801821:	c3                   	ret    

00801822 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801822:	55                   	push   %ebp
  801823:	89 e5                	mov    %esp,%ebp
  801825:	56                   	push   %esi
  801826:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801827:	8b 75 18             	mov    0x18(%ebp),%esi
  80182a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80182d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801830:	8b 55 0c             	mov    0xc(%ebp),%edx
  801833:	8b 45 08             	mov    0x8(%ebp),%eax
  801836:	56                   	push   %esi
  801837:	53                   	push   %ebx
  801838:	51                   	push   %ecx
  801839:	52                   	push   %edx
  80183a:	50                   	push   %eax
  80183b:	6a 08                	push   $0x8
  80183d:	e8 d6 fe ff ff       	call   801718 <syscall>
  801842:	83 c4 18             	add    $0x18,%esp
}
  801845:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801848:	5b                   	pop    %ebx
  801849:	5e                   	pop    %esi
  80184a:	5d                   	pop    %ebp
  80184b:	c3                   	ret    

0080184c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80184c:	55                   	push   %ebp
  80184d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80184f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801852:	8b 45 08             	mov    0x8(%ebp),%eax
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	52                   	push   %edx
  80185c:	50                   	push   %eax
  80185d:	6a 09                	push   $0x9
  80185f:	e8 b4 fe ff ff       	call   801718 <syscall>
  801864:	83 c4 18             	add    $0x18,%esp
}
  801867:	c9                   	leave  
  801868:	c3                   	ret    

00801869 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801869:	55                   	push   %ebp
  80186a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	ff 75 0c             	pushl  0xc(%ebp)
  801875:	ff 75 08             	pushl  0x8(%ebp)
  801878:	6a 0a                	push   $0xa
  80187a:	e8 99 fe ff ff       	call   801718 <syscall>
  80187f:	83 c4 18             	add    $0x18,%esp
}
  801882:	c9                   	leave  
  801883:	c3                   	ret    

00801884 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801884:	55                   	push   %ebp
  801885:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 0b                	push   $0xb
  801893:	e8 80 fe ff ff       	call   801718 <syscall>
  801898:	83 c4 18             	add    $0x18,%esp
}
  80189b:	c9                   	leave  
  80189c:	c3                   	ret    

0080189d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80189d:	55                   	push   %ebp
  80189e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 0c                	push   $0xc
  8018ac:	e8 67 fe ff ff       	call   801718 <syscall>
  8018b1:	83 c4 18             	add    $0x18,%esp
}
  8018b4:	c9                   	leave  
  8018b5:	c3                   	ret    

008018b6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018b6:	55                   	push   %ebp
  8018b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 0d                	push   $0xd
  8018c5:	e8 4e fe ff ff       	call   801718 <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
}
  8018cd:	c9                   	leave  
  8018ce:	c3                   	ret    

008018cf <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018cf:	55                   	push   %ebp
  8018d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	ff 75 0c             	pushl  0xc(%ebp)
  8018db:	ff 75 08             	pushl  0x8(%ebp)
  8018de:	6a 11                	push   $0x11
  8018e0:	e8 33 fe ff ff       	call   801718 <syscall>
  8018e5:	83 c4 18             	add    $0x18,%esp
	return;
  8018e8:	90                   	nop
}
  8018e9:	c9                   	leave  
  8018ea:	c3                   	ret    

008018eb <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018eb:	55                   	push   %ebp
  8018ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	ff 75 0c             	pushl  0xc(%ebp)
  8018f7:	ff 75 08             	pushl  0x8(%ebp)
  8018fa:	6a 12                	push   $0x12
  8018fc:	e8 17 fe ff ff       	call   801718 <syscall>
  801901:	83 c4 18             	add    $0x18,%esp
	return ;
  801904:	90                   	nop
}
  801905:	c9                   	leave  
  801906:	c3                   	ret    

00801907 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801907:	55                   	push   %ebp
  801908:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 0e                	push   $0xe
  801916:	e8 fd fd ff ff       	call   801718 <syscall>
  80191b:	83 c4 18             	add    $0x18,%esp
}
  80191e:	c9                   	leave  
  80191f:	c3                   	ret    

00801920 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801920:	55                   	push   %ebp
  801921:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	ff 75 08             	pushl  0x8(%ebp)
  80192e:	6a 0f                	push   $0xf
  801930:	e8 e3 fd ff ff       	call   801718 <syscall>
  801935:	83 c4 18             	add    $0x18,%esp
}
  801938:	c9                   	leave  
  801939:	c3                   	ret    

0080193a <sys_scarce_memory>:

void sys_scarce_memory()
{
  80193a:	55                   	push   %ebp
  80193b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 10                	push   $0x10
  801949:	e8 ca fd ff ff       	call   801718 <syscall>
  80194e:	83 c4 18             	add    $0x18,%esp
}
  801951:	90                   	nop
  801952:	c9                   	leave  
  801953:	c3                   	ret    

00801954 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801954:	55                   	push   %ebp
  801955:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 14                	push   $0x14
  801963:	e8 b0 fd ff ff       	call   801718 <syscall>
  801968:	83 c4 18             	add    $0x18,%esp
}
  80196b:	90                   	nop
  80196c:	c9                   	leave  
  80196d:	c3                   	ret    

0080196e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80196e:	55                   	push   %ebp
  80196f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 15                	push   $0x15
  80197d:	e8 96 fd ff ff       	call   801718 <syscall>
  801982:	83 c4 18             	add    $0x18,%esp
}
  801985:	90                   	nop
  801986:	c9                   	leave  
  801987:	c3                   	ret    

00801988 <sys_cputc>:


void
sys_cputc(const char c)
{
  801988:	55                   	push   %ebp
  801989:	89 e5                	mov    %esp,%ebp
  80198b:	83 ec 04             	sub    $0x4,%esp
  80198e:	8b 45 08             	mov    0x8(%ebp),%eax
  801991:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801994:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	50                   	push   %eax
  8019a1:	6a 16                	push   $0x16
  8019a3:	e8 70 fd ff ff       	call   801718 <syscall>
  8019a8:	83 c4 18             	add    $0x18,%esp
}
  8019ab:	90                   	nop
  8019ac:	c9                   	leave  
  8019ad:	c3                   	ret    

008019ae <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019ae:	55                   	push   %ebp
  8019af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 00                	push   $0x0
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 17                	push   $0x17
  8019bd:	e8 56 fd ff ff       	call   801718 <syscall>
  8019c2:	83 c4 18             	add    $0x18,%esp
}
  8019c5:	90                   	nop
  8019c6:	c9                   	leave  
  8019c7:	c3                   	ret    

008019c8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019c8:	55                   	push   %ebp
  8019c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	ff 75 0c             	pushl  0xc(%ebp)
  8019d7:	50                   	push   %eax
  8019d8:	6a 18                	push   $0x18
  8019da:	e8 39 fd ff ff       	call   801718 <syscall>
  8019df:	83 c4 18             	add    $0x18,%esp
}
  8019e2:	c9                   	leave  
  8019e3:	c3                   	ret    

008019e4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019e4:	55                   	push   %ebp
  8019e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	52                   	push   %edx
  8019f4:	50                   	push   %eax
  8019f5:	6a 1b                	push   $0x1b
  8019f7:	e8 1c fd ff ff       	call   801718 <syscall>
  8019fc:	83 c4 18             	add    $0x18,%esp
}
  8019ff:	c9                   	leave  
  801a00:	c3                   	ret    

00801a01 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a01:	55                   	push   %ebp
  801a02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a04:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a07:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	6a 00                	push   $0x0
  801a10:	52                   	push   %edx
  801a11:	50                   	push   %eax
  801a12:	6a 19                	push   $0x19
  801a14:	e8 ff fc ff ff       	call   801718 <syscall>
  801a19:	83 c4 18             	add    $0x18,%esp
}
  801a1c:	90                   	nop
  801a1d:	c9                   	leave  
  801a1e:	c3                   	ret    

00801a1f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a1f:	55                   	push   %ebp
  801a20:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a22:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a25:	8b 45 08             	mov    0x8(%ebp),%eax
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	52                   	push   %edx
  801a2f:	50                   	push   %eax
  801a30:	6a 1a                	push   $0x1a
  801a32:	e8 e1 fc ff ff       	call   801718 <syscall>
  801a37:	83 c4 18             	add    $0x18,%esp
}
  801a3a:	90                   	nop
  801a3b:	c9                   	leave  
  801a3c:	c3                   	ret    

00801a3d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a3d:	55                   	push   %ebp
  801a3e:	89 e5                	mov    %esp,%ebp
  801a40:	83 ec 04             	sub    $0x4,%esp
  801a43:	8b 45 10             	mov    0x10(%ebp),%eax
  801a46:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a49:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a4c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a50:	8b 45 08             	mov    0x8(%ebp),%eax
  801a53:	6a 00                	push   $0x0
  801a55:	51                   	push   %ecx
  801a56:	52                   	push   %edx
  801a57:	ff 75 0c             	pushl  0xc(%ebp)
  801a5a:	50                   	push   %eax
  801a5b:	6a 1c                	push   $0x1c
  801a5d:	e8 b6 fc ff ff       	call   801718 <syscall>
  801a62:	83 c4 18             	add    $0x18,%esp
}
  801a65:	c9                   	leave  
  801a66:	c3                   	ret    

00801a67 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a67:	55                   	push   %ebp
  801a68:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a70:	6a 00                	push   $0x0
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	52                   	push   %edx
  801a77:	50                   	push   %eax
  801a78:	6a 1d                	push   $0x1d
  801a7a:	e8 99 fc ff ff       	call   801718 <syscall>
  801a7f:	83 c4 18             	add    $0x18,%esp
}
  801a82:	c9                   	leave  
  801a83:	c3                   	ret    

00801a84 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a84:	55                   	push   %ebp
  801a85:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a87:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	51                   	push   %ecx
  801a95:	52                   	push   %edx
  801a96:	50                   	push   %eax
  801a97:	6a 1e                	push   $0x1e
  801a99:	e8 7a fc ff ff       	call   801718 <syscall>
  801a9e:	83 c4 18             	add    $0x18,%esp
}
  801aa1:	c9                   	leave  
  801aa2:	c3                   	ret    

00801aa3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801aa3:	55                   	push   %ebp
  801aa4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801aa6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	52                   	push   %edx
  801ab3:	50                   	push   %eax
  801ab4:	6a 1f                	push   $0x1f
  801ab6:	e8 5d fc ff ff       	call   801718 <syscall>
  801abb:	83 c4 18             	add    $0x18,%esp
}
  801abe:	c9                   	leave  
  801abf:	c3                   	ret    

00801ac0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ac0:	55                   	push   %ebp
  801ac1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 20                	push   $0x20
  801acf:	e8 44 fc ff ff       	call   801718 <syscall>
  801ad4:	83 c4 18             	add    $0x18,%esp
}
  801ad7:	c9                   	leave  
  801ad8:	c3                   	ret    

00801ad9 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801ad9:	55                   	push   %ebp
  801ada:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801adc:	8b 45 08             	mov    0x8(%ebp),%eax
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	ff 75 10             	pushl  0x10(%ebp)
  801ae6:	ff 75 0c             	pushl  0xc(%ebp)
  801ae9:	50                   	push   %eax
  801aea:	6a 21                	push   $0x21
  801aec:	e8 27 fc ff ff       	call   801718 <syscall>
  801af1:	83 c4 18             	add    $0x18,%esp
}
  801af4:	c9                   	leave  
  801af5:	c3                   	ret    

00801af6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801af6:	55                   	push   %ebp
  801af7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801af9:	8b 45 08             	mov    0x8(%ebp),%eax
  801afc:	6a 00                	push   $0x0
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	50                   	push   %eax
  801b05:	6a 22                	push   $0x22
  801b07:	e8 0c fc ff ff       	call   801718 <syscall>
  801b0c:	83 c4 18             	add    $0x18,%esp
}
  801b0f:	90                   	nop
  801b10:	c9                   	leave  
  801b11:	c3                   	ret    

00801b12 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b12:	55                   	push   %ebp
  801b13:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b15:	8b 45 08             	mov    0x8(%ebp),%eax
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	50                   	push   %eax
  801b21:	6a 23                	push   $0x23
  801b23:	e8 f0 fb ff ff       	call   801718 <syscall>
  801b28:	83 c4 18             	add    $0x18,%esp
}
  801b2b:	90                   	nop
  801b2c:	c9                   	leave  
  801b2d:	c3                   	ret    

00801b2e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b2e:	55                   	push   %ebp
  801b2f:	89 e5                	mov    %esp,%ebp
  801b31:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b34:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b37:	8d 50 04             	lea    0x4(%eax),%edx
  801b3a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	52                   	push   %edx
  801b44:	50                   	push   %eax
  801b45:	6a 24                	push   $0x24
  801b47:	e8 cc fb ff ff       	call   801718 <syscall>
  801b4c:	83 c4 18             	add    $0x18,%esp
	return result;
  801b4f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b52:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b55:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b58:	89 01                	mov    %eax,(%ecx)
  801b5a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b60:	c9                   	leave  
  801b61:	c2 04 00             	ret    $0x4

00801b64 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b64:	55                   	push   %ebp
  801b65:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	ff 75 10             	pushl  0x10(%ebp)
  801b6e:	ff 75 0c             	pushl  0xc(%ebp)
  801b71:	ff 75 08             	pushl  0x8(%ebp)
  801b74:	6a 13                	push   $0x13
  801b76:	e8 9d fb ff ff       	call   801718 <syscall>
  801b7b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b7e:	90                   	nop
}
  801b7f:	c9                   	leave  
  801b80:	c3                   	ret    

00801b81 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b81:	55                   	push   %ebp
  801b82:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 00                	push   $0x0
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 25                	push   $0x25
  801b90:	e8 83 fb ff ff       	call   801718 <syscall>
  801b95:	83 c4 18             	add    $0x18,%esp
}
  801b98:	c9                   	leave  
  801b99:	c3                   	ret    

00801b9a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b9a:	55                   	push   %ebp
  801b9b:	89 e5                	mov    %esp,%ebp
  801b9d:	83 ec 04             	sub    $0x4,%esp
  801ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ba6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	50                   	push   %eax
  801bb3:	6a 26                	push   $0x26
  801bb5:	e8 5e fb ff ff       	call   801718 <syscall>
  801bba:	83 c4 18             	add    $0x18,%esp
	return ;
  801bbd:	90                   	nop
}
  801bbe:	c9                   	leave  
  801bbf:	c3                   	ret    

00801bc0 <rsttst>:
void rsttst()
{
  801bc0:	55                   	push   %ebp
  801bc1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 28                	push   $0x28
  801bcf:	e8 44 fb ff ff       	call   801718 <syscall>
  801bd4:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd7:	90                   	nop
}
  801bd8:	c9                   	leave  
  801bd9:	c3                   	ret    

00801bda <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bda:	55                   	push   %ebp
  801bdb:	89 e5                	mov    %esp,%ebp
  801bdd:	83 ec 04             	sub    $0x4,%esp
  801be0:	8b 45 14             	mov    0x14(%ebp),%eax
  801be3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801be6:	8b 55 18             	mov    0x18(%ebp),%edx
  801be9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bed:	52                   	push   %edx
  801bee:	50                   	push   %eax
  801bef:	ff 75 10             	pushl  0x10(%ebp)
  801bf2:	ff 75 0c             	pushl  0xc(%ebp)
  801bf5:	ff 75 08             	pushl  0x8(%ebp)
  801bf8:	6a 27                	push   $0x27
  801bfa:	e8 19 fb ff ff       	call   801718 <syscall>
  801bff:	83 c4 18             	add    $0x18,%esp
	return ;
  801c02:	90                   	nop
}
  801c03:	c9                   	leave  
  801c04:	c3                   	ret    

00801c05 <chktst>:
void chktst(uint32 n)
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	ff 75 08             	pushl  0x8(%ebp)
  801c13:	6a 29                	push   $0x29
  801c15:	e8 fe fa ff ff       	call   801718 <syscall>
  801c1a:	83 c4 18             	add    $0x18,%esp
	return ;
  801c1d:	90                   	nop
}
  801c1e:	c9                   	leave  
  801c1f:	c3                   	ret    

00801c20 <inctst>:

void inctst()
{
  801c20:	55                   	push   %ebp
  801c21:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 2a                	push   $0x2a
  801c2f:	e8 e4 fa ff ff       	call   801718 <syscall>
  801c34:	83 c4 18             	add    $0x18,%esp
	return ;
  801c37:	90                   	nop
}
  801c38:	c9                   	leave  
  801c39:	c3                   	ret    

00801c3a <gettst>:
uint32 gettst()
{
  801c3a:	55                   	push   %ebp
  801c3b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 00                	push   $0x0
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	6a 2b                	push   $0x2b
  801c49:	e8 ca fa ff ff       	call   801718 <syscall>
  801c4e:	83 c4 18             	add    $0x18,%esp
}
  801c51:	c9                   	leave  
  801c52:	c3                   	ret    

00801c53 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c53:	55                   	push   %ebp
  801c54:	89 e5                	mov    %esp,%ebp
  801c56:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	6a 2c                	push   $0x2c
  801c65:	e8 ae fa ff ff       	call   801718 <syscall>
  801c6a:	83 c4 18             	add    $0x18,%esp
  801c6d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c70:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c74:	75 07                	jne    801c7d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c76:	b8 01 00 00 00       	mov    $0x1,%eax
  801c7b:	eb 05                	jmp    801c82 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c7d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c82:	c9                   	leave  
  801c83:	c3                   	ret    

00801c84 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c84:	55                   	push   %ebp
  801c85:	89 e5                	mov    %esp,%ebp
  801c87:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	6a 2c                	push   $0x2c
  801c96:	e8 7d fa ff ff       	call   801718 <syscall>
  801c9b:	83 c4 18             	add    $0x18,%esp
  801c9e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801ca1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ca5:	75 07                	jne    801cae <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ca7:	b8 01 00 00 00       	mov    $0x1,%eax
  801cac:	eb 05                	jmp    801cb3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801cae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cb3:	c9                   	leave  
  801cb4:	c3                   	ret    

00801cb5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801cb5:	55                   	push   %ebp
  801cb6:	89 e5                	mov    %esp,%ebp
  801cb8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 00                	push   $0x0
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 00                	push   $0x0
  801cc5:	6a 2c                	push   $0x2c
  801cc7:	e8 4c fa ff ff       	call   801718 <syscall>
  801ccc:	83 c4 18             	add    $0x18,%esp
  801ccf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cd2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cd6:	75 07                	jne    801cdf <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cd8:	b8 01 00 00 00       	mov    $0x1,%eax
  801cdd:	eb 05                	jmp    801ce4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cdf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ce4:	c9                   	leave  
  801ce5:	c3                   	ret    

00801ce6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ce6:	55                   	push   %ebp
  801ce7:	89 e5                	mov    %esp,%ebp
  801ce9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 2c                	push   $0x2c
  801cf8:	e8 1b fa ff ff       	call   801718 <syscall>
  801cfd:	83 c4 18             	add    $0x18,%esp
  801d00:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d03:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d07:	75 07                	jne    801d10 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d09:	b8 01 00 00 00       	mov    $0x1,%eax
  801d0e:	eb 05                	jmp    801d15 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d10:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d15:	c9                   	leave  
  801d16:	c3                   	ret    

00801d17 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d17:	55                   	push   %ebp
  801d18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	ff 75 08             	pushl  0x8(%ebp)
  801d25:	6a 2d                	push   $0x2d
  801d27:	e8 ec f9 ff ff       	call   801718 <syscall>
  801d2c:	83 c4 18             	add    $0x18,%esp
	return ;
  801d2f:	90                   	nop
}
  801d30:	c9                   	leave  
  801d31:	c3                   	ret    
  801d32:	66 90                	xchg   %ax,%ax

00801d34 <__udivdi3>:
  801d34:	55                   	push   %ebp
  801d35:	57                   	push   %edi
  801d36:	56                   	push   %esi
  801d37:	53                   	push   %ebx
  801d38:	83 ec 1c             	sub    $0x1c,%esp
  801d3b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d3f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d47:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d4b:	89 ca                	mov    %ecx,%edx
  801d4d:	89 f8                	mov    %edi,%eax
  801d4f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d53:	85 f6                	test   %esi,%esi
  801d55:	75 2d                	jne    801d84 <__udivdi3+0x50>
  801d57:	39 cf                	cmp    %ecx,%edi
  801d59:	77 65                	ja     801dc0 <__udivdi3+0x8c>
  801d5b:	89 fd                	mov    %edi,%ebp
  801d5d:	85 ff                	test   %edi,%edi
  801d5f:	75 0b                	jne    801d6c <__udivdi3+0x38>
  801d61:	b8 01 00 00 00       	mov    $0x1,%eax
  801d66:	31 d2                	xor    %edx,%edx
  801d68:	f7 f7                	div    %edi
  801d6a:	89 c5                	mov    %eax,%ebp
  801d6c:	31 d2                	xor    %edx,%edx
  801d6e:	89 c8                	mov    %ecx,%eax
  801d70:	f7 f5                	div    %ebp
  801d72:	89 c1                	mov    %eax,%ecx
  801d74:	89 d8                	mov    %ebx,%eax
  801d76:	f7 f5                	div    %ebp
  801d78:	89 cf                	mov    %ecx,%edi
  801d7a:	89 fa                	mov    %edi,%edx
  801d7c:	83 c4 1c             	add    $0x1c,%esp
  801d7f:	5b                   	pop    %ebx
  801d80:	5e                   	pop    %esi
  801d81:	5f                   	pop    %edi
  801d82:	5d                   	pop    %ebp
  801d83:	c3                   	ret    
  801d84:	39 ce                	cmp    %ecx,%esi
  801d86:	77 28                	ja     801db0 <__udivdi3+0x7c>
  801d88:	0f bd fe             	bsr    %esi,%edi
  801d8b:	83 f7 1f             	xor    $0x1f,%edi
  801d8e:	75 40                	jne    801dd0 <__udivdi3+0x9c>
  801d90:	39 ce                	cmp    %ecx,%esi
  801d92:	72 0a                	jb     801d9e <__udivdi3+0x6a>
  801d94:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d98:	0f 87 9e 00 00 00    	ja     801e3c <__udivdi3+0x108>
  801d9e:	b8 01 00 00 00       	mov    $0x1,%eax
  801da3:	89 fa                	mov    %edi,%edx
  801da5:	83 c4 1c             	add    $0x1c,%esp
  801da8:	5b                   	pop    %ebx
  801da9:	5e                   	pop    %esi
  801daa:	5f                   	pop    %edi
  801dab:	5d                   	pop    %ebp
  801dac:	c3                   	ret    
  801dad:	8d 76 00             	lea    0x0(%esi),%esi
  801db0:	31 ff                	xor    %edi,%edi
  801db2:	31 c0                	xor    %eax,%eax
  801db4:	89 fa                	mov    %edi,%edx
  801db6:	83 c4 1c             	add    $0x1c,%esp
  801db9:	5b                   	pop    %ebx
  801dba:	5e                   	pop    %esi
  801dbb:	5f                   	pop    %edi
  801dbc:	5d                   	pop    %ebp
  801dbd:	c3                   	ret    
  801dbe:	66 90                	xchg   %ax,%ax
  801dc0:	89 d8                	mov    %ebx,%eax
  801dc2:	f7 f7                	div    %edi
  801dc4:	31 ff                	xor    %edi,%edi
  801dc6:	89 fa                	mov    %edi,%edx
  801dc8:	83 c4 1c             	add    $0x1c,%esp
  801dcb:	5b                   	pop    %ebx
  801dcc:	5e                   	pop    %esi
  801dcd:	5f                   	pop    %edi
  801dce:	5d                   	pop    %ebp
  801dcf:	c3                   	ret    
  801dd0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801dd5:	89 eb                	mov    %ebp,%ebx
  801dd7:	29 fb                	sub    %edi,%ebx
  801dd9:	89 f9                	mov    %edi,%ecx
  801ddb:	d3 e6                	shl    %cl,%esi
  801ddd:	89 c5                	mov    %eax,%ebp
  801ddf:	88 d9                	mov    %bl,%cl
  801de1:	d3 ed                	shr    %cl,%ebp
  801de3:	89 e9                	mov    %ebp,%ecx
  801de5:	09 f1                	or     %esi,%ecx
  801de7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801deb:	89 f9                	mov    %edi,%ecx
  801ded:	d3 e0                	shl    %cl,%eax
  801def:	89 c5                	mov    %eax,%ebp
  801df1:	89 d6                	mov    %edx,%esi
  801df3:	88 d9                	mov    %bl,%cl
  801df5:	d3 ee                	shr    %cl,%esi
  801df7:	89 f9                	mov    %edi,%ecx
  801df9:	d3 e2                	shl    %cl,%edx
  801dfb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dff:	88 d9                	mov    %bl,%cl
  801e01:	d3 e8                	shr    %cl,%eax
  801e03:	09 c2                	or     %eax,%edx
  801e05:	89 d0                	mov    %edx,%eax
  801e07:	89 f2                	mov    %esi,%edx
  801e09:	f7 74 24 0c          	divl   0xc(%esp)
  801e0d:	89 d6                	mov    %edx,%esi
  801e0f:	89 c3                	mov    %eax,%ebx
  801e11:	f7 e5                	mul    %ebp
  801e13:	39 d6                	cmp    %edx,%esi
  801e15:	72 19                	jb     801e30 <__udivdi3+0xfc>
  801e17:	74 0b                	je     801e24 <__udivdi3+0xf0>
  801e19:	89 d8                	mov    %ebx,%eax
  801e1b:	31 ff                	xor    %edi,%edi
  801e1d:	e9 58 ff ff ff       	jmp    801d7a <__udivdi3+0x46>
  801e22:	66 90                	xchg   %ax,%ax
  801e24:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e28:	89 f9                	mov    %edi,%ecx
  801e2a:	d3 e2                	shl    %cl,%edx
  801e2c:	39 c2                	cmp    %eax,%edx
  801e2e:	73 e9                	jae    801e19 <__udivdi3+0xe5>
  801e30:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e33:	31 ff                	xor    %edi,%edi
  801e35:	e9 40 ff ff ff       	jmp    801d7a <__udivdi3+0x46>
  801e3a:	66 90                	xchg   %ax,%ax
  801e3c:	31 c0                	xor    %eax,%eax
  801e3e:	e9 37 ff ff ff       	jmp    801d7a <__udivdi3+0x46>
  801e43:	90                   	nop

00801e44 <__umoddi3>:
  801e44:	55                   	push   %ebp
  801e45:	57                   	push   %edi
  801e46:	56                   	push   %esi
  801e47:	53                   	push   %ebx
  801e48:	83 ec 1c             	sub    $0x1c,%esp
  801e4b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e4f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e53:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e57:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e5b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e5f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e63:	89 f3                	mov    %esi,%ebx
  801e65:	89 fa                	mov    %edi,%edx
  801e67:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e6b:	89 34 24             	mov    %esi,(%esp)
  801e6e:	85 c0                	test   %eax,%eax
  801e70:	75 1a                	jne    801e8c <__umoddi3+0x48>
  801e72:	39 f7                	cmp    %esi,%edi
  801e74:	0f 86 a2 00 00 00    	jbe    801f1c <__umoddi3+0xd8>
  801e7a:	89 c8                	mov    %ecx,%eax
  801e7c:	89 f2                	mov    %esi,%edx
  801e7e:	f7 f7                	div    %edi
  801e80:	89 d0                	mov    %edx,%eax
  801e82:	31 d2                	xor    %edx,%edx
  801e84:	83 c4 1c             	add    $0x1c,%esp
  801e87:	5b                   	pop    %ebx
  801e88:	5e                   	pop    %esi
  801e89:	5f                   	pop    %edi
  801e8a:	5d                   	pop    %ebp
  801e8b:	c3                   	ret    
  801e8c:	39 f0                	cmp    %esi,%eax
  801e8e:	0f 87 ac 00 00 00    	ja     801f40 <__umoddi3+0xfc>
  801e94:	0f bd e8             	bsr    %eax,%ebp
  801e97:	83 f5 1f             	xor    $0x1f,%ebp
  801e9a:	0f 84 ac 00 00 00    	je     801f4c <__umoddi3+0x108>
  801ea0:	bf 20 00 00 00       	mov    $0x20,%edi
  801ea5:	29 ef                	sub    %ebp,%edi
  801ea7:	89 fe                	mov    %edi,%esi
  801ea9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ead:	89 e9                	mov    %ebp,%ecx
  801eaf:	d3 e0                	shl    %cl,%eax
  801eb1:	89 d7                	mov    %edx,%edi
  801eb3:	89 f1                	mov    %esi,%ecx
  801eb5:	d3 ef                	shr    %cl,%edi
  801eb7:	09 c7                	or     %eax,%edi
  801eb9:	89 e9                	mov    %ebp,%ecx
  801ebb:	d3 e2                	shl    %cl,%edx
  801ebd:	89 14 24             	mov    %edx,(%esp)
  801ec0:	89 d8                	mov    %ebx,%eax
  801ec2:	d3 e0                	shl    %cl,%eax
  801ec4:	89 c2                	mov    %eax,%edx
  801ec6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eca:	d3 e0                	shl    %cl,%eax
  801ecc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ed0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ed4:	89 f1                	mov    %esi,%ecx
  801ed6:	d3 e8                	shr    %cl,%eax
  801ed8:	09 d0                	or     %edx,%eax
  801eda:	d3 eb                	shr    %cl,%ebx
  801edc:	89 da                	mov    %ebx,%edx
  801ede:	f7 f7                	div    %edi
  801ee0:	89 d3                	mov    %edx,%ebx
  801ee2:	f7 24 24             	mull   (%esp)
  801ee5:	89 c6                	mov    %eax,%esi
  801ee7:	89 d1                	mov    %edx,%ecx
  801ee9:	39 d3                	cmp    %edx,%ebx
  801eeb:	0f 82 87 00 00 00    	jb     801f78 <__umoddi3+0x134>
  801ef1:	0f 84 91 00 00 00    	je     801f88 <__umoddi3+0x144>
  801ef7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801efb:	29 f2                	sub    %esi,%edx
  801efd:	19 cb                	sbb    %ecx,%ebx
  801eff:	89 d8                	mov    %ebx,%eax
  801f01:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f05:	d3 e0                	shl    %cl,%eax
  801f07:	89 e9                	mov    %ebp,%ecx
  801f09:	d3 ea                	shr    %cl,%edx
  801f0b:	09 d0                	or     %edx,%eax
  801f0d:	89 e9                	mov    %ebp,%ecx
  801f0f:	d3 eb                	shr    %cl,%ebx
  801f11:	89 da                	mov    %ebx,%edx
  801f13:	83 c4 1c             	add    $0x1c,%esp
  801f16:	5b                   	pop    %ebx
  801f17:	5e                   	pop    %esi
  801f18:	5f                   	pop    %edi
  801f19:	5d                   	pop    %ebp
  801f1a:	c3                   	ret    
  801f1b:	90                   	nop
  801f1c:	89 fd                	mov    %edi,%ebp
  801f1e:	85 ff                	test   %edi,%edi
  801f20:	75 0b                	jne    801f2d <__umoddi3+0xe9>
  801f22:	b8 01 00 00 00       	mov    $0x1,%eax
  801f27:	31 d2                	xor    %edx,%edx
  801f29:	f7 f7                	div    %edi
  801f2b:	89 c5                	mov    %eax,%ebp
  801f2d:	89 f0                	mov    %esi,%eax
  801f2f:	31 d2                	xor    %edx,%edx
  801f31:	f7 f5                	div    %ebp
  801f33:	89 c8                	mov    %ecx,%eax
  801f35:	f7 f5                	div    %ebp
  801f37:	89 d0                	mov    %edx,%eax
  801f39:	e9 44 ff ff ff       	jmp    801e82 <__umoddi3+0x3e>
  801f3e:	66 90                	xchg   %ax,%ax
  801f40:	89 c8                	mov    %ecx,%eax
  801f42:	89 f2                	mov    %esi,%edx
  801f44:	83 c4 1c             	add    $0x1c,%esp
  801f47:	5b                   	pop    %ebx
  801f48:	5e                   	pop    %esi
  801f49:	5f                   	pop    %edi
  801f4a:	5d                   	pop    %ebp
  801f4b:	c3                   	ret    
  801f4c:	3b 04 24             	cmp    (%esp),%eax
  801f4f:	72 06                	jb     801f57 <__umoddi3+0x113>
  801f51:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f55:	77 0f                	ja     801f66 <__umoddi3+0x122>
  801f57:	89 f2                	mov    %esi,%edx
  801f59:	29 f9                	sub    %edi,%ecx
  801f5b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f5f:	89 14 24             	mov    %edx,(%esp)
  801f62:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f66:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f6a:	8b 14 24             	mov    (%esp),%edx
  801f6d:	83 c4 1c             	add    $0x1c,%esp
  801f70:	5b                   	pop    %ebx
  801f71:	5e                   	pop    %esi
  801f72:	5f                   	pop    %edi
  801f73:	5d                   	pop    %ebp
  801f74:	c3                   	ret    
  801f75:	8d 76 00             	lea    0x0(%esi),%esi
  801f78:	2b 04 24             	sub    (%esp),%eax
  801f7b:	19 fa                	sbb    %edi,%edx
  801f7d:	89 d1                	mov    %edx,%ecx
  801f7f:	89 c6                	mov    %eax,%esi
  801f81:	e9 71 ff ff ff       	jmp    801ef7 <__umoddi3+0xb3>
  801f86:	66 90                	xchg   %ax,%ax
  801f88:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f8c:	72 ea                	jb     801f78 <__umoddi3+0x134>
  801f8e:	89 d9                	mov    %ebx,%ecx
  801f90:	e9 62 ff ff ff       	jmp    801ef7 <__umoddi3+0xb3>
