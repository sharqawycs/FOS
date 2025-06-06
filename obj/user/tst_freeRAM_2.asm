
obj/user/tst_freeRAM_2:     file format elf32-i386


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
  800031:	e8 8b 05 00 00       	call   8005c1 <libmain>
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
  80003c:	53                   	push   %ebx
  80003d:	81 ec b0 00 00 00    	sub    $0xb0,%esp
	

	
	

	int Mega = 1024*1024;
  800043:	c7 45 f4 00 00 10 00 	movl   $0x100000,-0xc(%ebp)
	int kilo = 1024;
  80004a:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
	char minByte = 1<<7;
  800051:	c6 45 ef 80          	movb   $0x80,-0x11(%ebp)
	char maxByte = 0x7F;
  800055:	c6 45 ee 7f          	movb   $0x7f,-0x12(%ebp)
	short minShort = 1<<15 ;
  800059:	66 c7 45 ec 00 80    	movw   $0x8000,-0x14(%ebp)
	short maxShort = 0x7FFF;
  80005f:	66 c7 45 ea ff 7f    	movw   $0x7fff,-0x16(%ebp)
	int minInt = 1<<31 ;
  800065:	c7 45 e4 00 00 00 80 	movl   $0x80000000,-0x1c(%ebp)
	int maxInt = 0x7FFFFFFF;
  80006c:	c7 45 e0 ff ff ff 7f 	movl   $0x7fffffff,-0x20(%ebp)

	void* ptr_allocations[20] = {0};
  800073:	8d 95 4c ff ff ff    	lea    -0xb4(%ebp),%edx
  800079:	b9 14 00 00 00       	mov    $0x14,%ecx
  80007e:	b8 00 00 00 00       	mov    $0x0,%eax
  800083:	89 d7                	mov    %edx,%edi
  800085:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//Load "fib" & "fos_helloWorld" programs into RAM
		cprintf("Loading Fib & fos_helloWorld programs into RAM...");
  800087:	83 ec 0c             	sub    $0xc,%esp
  80008a:	68 e0 22 80 00       	push   $0x8022e0
  80008f:	e8 e3 08 00 00       	call   800977 <cprintf>
  800094:	83 c4 10             	add    $0x10,%esp
		int32 envIdFib = sys_create_env("fib", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800097:	a1 20 30 80 00       	mov    0x803020,%eax
  80009c:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8000a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a7:	8b 40 74             	mov    0x74(%eax),%eax
  8000aa:	83 ec 04             	sub    $0x4,%esp
  8000ad:	52                   	push   %edx
  8000ae:	50                   	push   %eax
  8000af:	68 12 23 80 00       	push   $0x802312
  8000b4:	e8 99 1c 00 00       	call   801d52 <sys_create_env>
  8000b9:	83 c4 10             	add    $0x10,%esp
  8000bc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		int freeFrames = sys_calculate_free_frames() ;
  8000bf:	e8 39 1a 00 00       	call   801afd <sys_calculate_free_frames>
  8000c4:	89 45 d8             	mov    %eax,-0x28(%ebp)
		int32 envIdHelloWorld = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000cc:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8000d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d7:	8b 40 74             	mov    0x74(%eax),%eax
  8000da:	83 ec 04             	sub    $0x4,%esp
  8000dd:	52                   	push   %edx
  8000de:	50                   	push   %eax
  8000df:	68 16 23 80 00       	push   $0x802316
  8000e4:	e8 69 1c 00 00       	call   801d52 <sys_create_env>
  8000e9:	83 c4 10             	add    $0x10,%esp
  8000ec:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int helloWorldFrames = freeFrames - sys_calculate_free_frames() ;
  8000ef:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  8000f2:	e8 06 1a 00 00       	call   801afd <sys_calculate_free_frames>
  8000f7:	29 c3                	sub    %eax,%ebx
  8000f9:	89 d8                	mov    %ebx,%eax
  8000fb:	89 45 d0             	mov    %eax,-0x30(%ebp)
		env_sleep(2000);
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	68 d0 07 00 00       	push   $0x7d0
  800106:	e8 a0 1e 00 00       	call   801fab <env_sleep>
  80010b:	83 c4 10             	add    $0x10,%esp
		cprintf("[DONE]\n\n");
  80010e:	83 ec 0c             	sub    $0xc,%esp
  800111:	68 25 23 80 00       	push   $0x802325
  800116:	e8 5c 08 00 00       	call   800977 <cprintf>
  80011b:	83 c4 10             	add    $0x10,%esp

		//Load and run "fos_add"
		cprintf("Loading fos_add program into RAM...");
  80011e:	83 ec 0c             	sub    $0xc,%esp
  800121:	68 30 23 80 00       	push   $0x802330
  800126:	e8 4c 08 00 00       	call   800977 <cprintf>
  80012b:	83 c4 10             	add    $0x10,%esp
		int32 envIdFOSAdd= sys_create_env("fos_add", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80012e:	a1 20 30 80 00       	mov    0x803020,%eax
  800133:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800139:	a1 20 30 80 00       	mov    0x803020,%eax
  80013e:	8b 40 74             	mov    0x74(%eax),%eax
  800141:	83 ec 04             	sub    $0x4,%esp
  800144:	52                   	push   %edx
  800145:	50                   	push   %eax
  800146:	68 54 23 80 00       	push   $0x802354
  80014b:	e8 02 1c 00 00       	call   801d52 <sys_create_env>
  800150:	83 c4 10             	add    $0x10,%esp
  800153:	89 45 cc             	mov    %eax,-0x34(%ebp)
		env_sleep(2000);
  800156:	83 ec 0c             	sub    $0xc,%esp
  800159:	68 d0 07 00 00       	push   $0x7d0
  80015e:	e8 48 1e 00 00       	call   801fab <env_sleep>
  800163:	83 c4 10             	add    $0x10,%esp
		cprintf("[DONE]\n\n");
  800166:	83 ec 0c             	sub    $0xc,%esp
  800169:	68 25 23 80 00       	push   $0x802325
  80016e:	e8 04 08 00 00       	call   800977 <cprintf>
  800173:	83 c4 10             	add    $0x10,%esp
		cprintf("running fos_add program...\n\n");
  800176:	83 ec 0c             	sub    $0xc,%esp
  800179:	68 5c 23 80 00       	push   $0x80235c
  80017e:	e8 f4 07 00 00       	call   800977 <cprintf>
  800183:	83 c4 10             	add    $0x10,%esp
		sys_run_env(envIdFOSAdd);
  800186:	83 ec 0c             	sub    $0xc,%esp
  800189:	ff 75 cc             	pushl  -0x34(%ebp)
  80018c:	e8 de 1b 00 00       	call   801d6f <sys_run_env>
  800191:	83 c4 10             	add    $0x10,%esp

		cprintf("please be patient ...\n");
  800194:	83 ec 0c             	sub    $0xc,%esp
  800197:	68 79 23 80 00       	push   $0x802379
  80019c:	e8 d6 07 00 00       	call   800977 <cprintf>
  8001a1:	83 c4 10             	add    $0x10,%esp
		env_sleep(5000);
  8001a4:	83 ec 0c             	sub    $0xc,%esp
  8001a7:	68 88 13 00 00       	push   $0x1388
  8001ac:	e8 fa 1d 00 00       	call   801fab <env_sleep>
  8001b1:	83 c4 10             	add    $0x10,%esp

		//Allocate 2 MB
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8001b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001b7:	01 c0                	add    %eax,%eax
  8001b9:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8001bc:	83 ec 0c             	sub    $0xc,%esp
  8001bf:	50                   	push   %eax
  8001c0:	e8 76 15 00 00       	call   80173b <malloc>
  8001c5:	83 c4 10             	add    $0x10,%esp
  8001c8:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
		char *byteArr = (char *) ptr_allocations[0];
  8001ce:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  8001d4:	89 45 c8             	mov    %eax,-0x38(%ebp)
		int lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  8001d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001da:	01 c0                	add    %eax,%eax
  8001dc:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8001df:	48                   	dec    %eax
  8001e0:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		byteArr[0] = minByte ;
  8001e3:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001e6:	8a 55 ef             	mov    -0x11(%ebp),%dl
  8001e9:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  8001eb:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  8001ee:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001f1:	01 c2                	add    %eax,%edx
  8001f3:	8a 45 ee             	mov    -0x12(%ebp),%al
  8001f6:	88 02                	mov    %al,(%edx)

		//Allocate another 2 MB
		ptr_allocations[1] = malloc(2*Mega-kilo);
  8001f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001fb:	01 c0                	add    %eax,%eax
  8001fd:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800200:	83 ec 0c             	sub    $0xc,%esp
  800203:	50                   	push   %eax
  800204:	e8 32 15 00 00       	call   80173b <malloc>
  800209:	83 c4 10             	add    $0x10,%esp
  80020c:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
		short *shortArr = (short *) ptr_allocations[1];
  800212:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800218:	89 45 c0             	mov    %eax,-0x40(%ebp)
		int lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  80021b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80021e:	01 c0                	add    %eax,%eax
  800220:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800223:	d1 e8                	shr    %eax
  800225:	48                   	dec    %eax
  800226:	89 45 bc             	mov    %eax,-0x44(%ebp)
		shortArr[0] = minShort;
  800229:	8b 55 c0             	mov    -0x40(%ebp),%edx
  80022c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80022f:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800232:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800235:	01 c0                	add    %eax,%eax
  800237:	89 c2                	mov    %eax,%edx
  800239:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80023c:	01 c2                	add    %eax,%edx
  80023e:	66 8b 45 ea          	mov    -0x16(%ebp),%ax
  800242:	66 89 02             	mov    %ax,(%edx)

		//Allocate all remaining RAM (Here: it requires to free some RAM by removing exited program (fos_add))
		freeFrames = sys_calculate_free_frames() ;
  800245:	e8 b3 18 00 00       	call   801afd <sys_calculate_free_frames>
  80024a:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[2] = malloc(freeFrames*PAGE_SIZE);
  80024d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800250:	c1 e0 0c             	shl    $0xc,%eax
  800253:	83 ec 0c             	sub    $0xc,%esp
  800256:	50                   	push   %eax
  800257:	e8 df 14 00 00       	call   80173b <malloc>
  80025c:	83 c4 10             	add    $0x10,%esp
  80025f:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
		int *intArr = (int *) ptr_allocations[2];
  800265:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  80026b:	89 45 b8             	mov    %eax,-0x48(%ebp)
		int lastIndexOfInt = (freeFrames*PAGE_SIZE)/sizeof(int) - 1;
  80026e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800271:	c1 e0 0c             	shl    $0xc,%eax
  800274:	c1 e8 02             	shr    $0x2,%eax
  800277:	48                   	dec    %eax
  800278:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		intArr[0] = minInt;
  80027b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80027e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800281:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  800283:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800286:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80028d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800290:	01 c2                	add    %eax,%edx
  800292:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800295:	89 02                	mov    %eax,(%edx)

		//Allocate 7 KB after freeing some RAM
		ptr_allocations[3] = malloc(7*kilo);
  800297:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80029a:	89 d0                	mov    %edx,%eax
  80029c:	01 c0                	add    %eax,%eax
  80029e:	01 d0                	add    %edx,%eax
  8002a0:	01 c0                	add    %eax,%eax
  8002a2:	01 d0                	add    %edx,%eax
  8002a4:	83 ec 0c             	sub    $0xc,%esp
  8002a7:	50                   	push   %eax
  8002a8:	e8 8e 14 00 00       	call   80173b <malloc>
  8002ad:	83 c4 10             	add    $0x10,%esp
  8002b0:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
		struct MyStruct *structArr = (struct MyStruct *) ptr_allocations[3];
  8002b6:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  8002bc:	89 45 b0             	mov    %eax,-0x50(%ebp)
		int lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  8002bf:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8002c2:	89 d0                	mov    %edx,%eax
  8002c4:	01 c0                	add    %eax,%eax
  8002c6:	01 d0                	add    %edx,%eax
  8002c8:	01 c0                	add    %eax,%eax
  8002ca:	01 d0                	add    %edx,%eax
  8002cc:	c1 e8 03             	shr    $0x3,%eax
  8002cf:	48                   	dec    %eax
  8002d0:	89 45 ac             	mov    %eax,-0x54(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  8002d3:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002d6:	8a 55 ef             	mov    -0x11(%ebp),%dl
  8002d9:	88 10                	mov    %dl,(%eax)
  8002db:	8b 55 b0             	mov    -0x50(%ebp),%edx
  8002de:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002e1:	66 89 42 02          	mov    %ax,0x2(%edx)
  8002e5:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002e8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002eb:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  8002ee:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8002f1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002f8:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002fb:	01 c2                	add    %eax,%edx
  8002fd:	8a 45 ee             	mov    -0x12(%ebp),%al
  800300:	88 02                	mov    %al,(%edx)
  800302:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800305:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80030c:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80030f:	01 c2                	add    %eax,%edx
  800311:	66 8b 45 ea          	mov    -0x16(%ebp),%ax
  800315:	66 89 42 02          	mov    %ax,0x2(%edx)
  800319:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80031c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800323:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800326:	01 c2                	add    %eax,%edx
  800328:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80032b:	89 42 04             	mov    %eax,0x4(%edx)

		cprintf("running fos_helloWorld program...\n\n");
  80032e:	83 ec 0c             	sub    $0xc,%esp
  800331:	68 90 23 80 00       	push   $0x802390
  800336:	e8 3c 06 00 00       	call   800977 <cprintf>
  80033b:	83 c4 10             	add    $0x10,%esp
		sys_run_env(envIdHelloWorld);
  80033e:	83 ec 0c             	sub    $0xc,%esp
  800341:	ff 75 d4             	pushl  -0x2c(%ebp)
  800344:	e8 26 1a 00 00       	call   801d6f <sys_run_env>
  800349:	83 c4 10             	add    $0x10,%esp

		cprintf("please be patient ...\n");
  80034c:	83 ec 0c             	sub    $0xc,%esp
  80034f:	68 79 23 80 00       	push   $0x802379
  800354:	e8 1e 06 00 00       	call   800977 <cprintf>
  800359:	83 c4 10             	add    $0x10,%esp
		env_sleep(5000);
  80035c:	83 ec 0c             	sub    $0xc,%esp
  80035f:	68 88 13 00 00       	push   $0x1388
  800364:	e8 42 1c 00 00       	call   801fab <env_sleep>
  800369:	83 c4 10             	add    $0x10,%esp

		//Allocate the remaining RAM + extra RAM by the size of helloWorld program (Here: it requires to free some RAM by removing exited & loaded program(s) (fos_helloWorld & fib))
		freeFrames = sys_calculate_free_frames() ;
  80036c:	e8 8c 17 00 00       	call   801afd <sys_calculate_free_frames>
  800371:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[4] = malloc((freeFrames + helloWorldFrames)*PAGE_SIZE);
  800374:	8b 55 d8             	mov    -0x28(%ebp),%edx
  800377:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80037a:	01 d0                	add    %edx,%eax
  80037c:	c1 e0 0c             	shl    $0xc,%eax
  80037f:	83 ec 0c             	sub    $0xc,%esp
  800382:	50                   	push   %eax
  800383:	e8 b3 13 00 00       	call   80173b <malloc>
  800388:	83 c4 10             	add    $0x10,%esp
  80038b:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
		int *intArr2 = (int *) ptr_allocations[4];
  800391:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800397:	89 45 a8             	mov    %eax,-0x58(%ebp)
		int lastIndexOfInt2 = ((freeFrames + helloWorldFrames)*PAGE_SIZE)/sizeof(int) - 1;
  80039a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80039d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003a0:	01 d0                	add    %edx,%eax
  8003a2:	c1 e0 0c             	shl    $0xc,%eax
  8003a5:	c1 e8 02             	shr    $0x2,%eax
  8003a8:	48                   	dec    %eax
  8003a9:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		intArr2[0] = minInt;
  8003ac:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003af:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8003b2:	89 10                	mov    %edx,(%eax)
		intArr2[lastIndexOfInt2] = maxInt;
  8003b4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003be:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003c1:	01 c2                	add    %eax,%edx
  8003c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003c6:	89 02                	mov    %eax,(%edx)

		//Allocate 8 B after freeing the RAM
		ptr_allocations[5] = malloc(8);
  8003c8:	83 ec 0c             	sub    $0xc,%esp
  8003cb:	6a 08                	push   $0x8
  8003cd:	e8 69 13 00 00       	call   80173b <malloc>
  8003d2:	83 c4 10             	add    $0x10,%esp
  8003d5:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
		int *intArr3 = (int *) ptr_allocations[5];
  8003db:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  8003e1:	89 45 a0             	mov    %eax,-0x60(%ebp)
		int lastIndexOfInt3 = 8/sizeof(int) - 1;
  8003e4:	c7 45 9c 01 00 00 00 	movl   $0x1,-0x64(%ebp)
		intArr3[0] = minInt;
  8003eb:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003ee:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8003f1:	89 10                	mov    %edx,(%eax)
		intArr3[lastIndexOfInt3] = maxInt;
  8003f3:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8003f6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003fd:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800400:	01 c2                	add    %eax,%edx
  800402:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800405:	89 02                	mov    %eax,(%edx)

		//Check that the values are successfully stored
		if (byteArr[0] 	!= minByte 	|| byteArr[lastIndexOfByte] 	!= maxByte) panic("Wrong allocation: stored values are wrongly changed!");
  800407:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80040a:	8a 00                	mov    (%eax),%al
  80040c:	3a 45 ef             	cmp    -0x11(%ebp),%al
  80040f:	75 0f                	jne    800420 <_main+0x3e8>
  800411:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  800414:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800417:	01 d0                	add    %edx,%eax
  800419:	8a 00                	mov    (%eax),%al
  80041b:	3a 45 ee             	cmp    -0x12(%ebp),%al
  80041e:	74 14                	je     800434 <_main+0x3fc>
  800420:	83 ec 04             	sub    $0x4,%esp
  800423:	68 b4 23 80 00       	push   $0x8023b4
  800428:	6a 62                	push   $0x62
  80042a:	68 e9 23 80 00       	push   $0x8023e9
  80042f:	e8 8f 02 00 00       	call   8006c3 <_panic>
		if (shortArr[0] != minShort || shortArr[lastIndexOfShort] 	!= maxShort) panic("Wrong allocation: stored values are wrongly changed!");
  800434:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800437:	66 8b 00             	mov    (%eax),%ax
  80043a:	66 3b 45 ec          	cmp    -0x14(%ebp),%ax
  80043e:	75 15                	jne    800455 <_main+0x41d>
  800440:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800443:	01 c0                	add    %eax,%eax
  800445:	89 c2                	mov    %eax,%edx
  800447:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80044a:	01 d0                	add    %edx,%eax
  80044c:	66 8b 00             	mov    (%eax),%ax
  80044f:	66 3b 45 ea          	cmp    -0x16(%ebp),%ax
  800453:	74 14                	je     800469 <_main+0x431>
  800455:	83 ec 04             	sub    $0x4,%esp
  800458:	68 b4 23 80 00       	push   $0x8023b4
  80045d:	6a 63                	push   $0x63
  80045f:	68 e9 23 80 00       	push   $0x8023e9
  800464:	e8 5a 02 00 00       	call   8006c3 <_panic>
		if (intArr[0] 	!= minInt 	|| intArr[lastIndexOfInt] 		!= maxInt) panic("Wrong allocation: stored values are wrongly changed!");
  800469:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80046c:	8b 00                	mov    (%eax),%eax
  80046e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800471:	75 16                	jne    800489 <_main+0x451>
  800473:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800476:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80047d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800480:	01 d0                	add    %edx,%eax
  800482:	8b 00                	mov    (%eax),%eax
  800484:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800487:	74 14                	je     80049d <_main+0x465>
  800489:	83 ec 04             	sub    $0x4,%esp
  80048c:	68 b4 23 80 00       	push   $0x8023b4
  800491:	6a 64                	push   $0x64
  800493:	68 e9 23 80 00       	push   $0x8023e9
  800498:	e8 26 02 00 00       	call   8006c3 <_panic>
		if (intArr2[0] 	!= minInt 	|| intArr2[lastIndexOfInt2] 	!= maxInt) panic("Wrong allocation: stored values are wrongly changed!");
  80049d:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8004a0:	8b 00                	mov    (%eax),%eax
  8004a2:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004a5:	75 16                	jne    8004bd <_main+0x485>
  8004a7:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8004aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b1:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8004b4:	01 d0                	add    %edx,%eax
  8004b6:	8b 00                	mov    (%eax),%eax
  8004b8:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8004bb:	74 14                	je     8004d1 <_main+0x499>
  8004bd:	83 ec 04             	sub    $0x4,%esp
  8004c0:	68 b4 23 80 00       	push   $0x8023b4
  8004c5:	6a 65                	push   $0x65
  8004c7:	68 e9 23 80 00       	push   $0x8023e9
  8004cc:	e8 f2 01 00 00       	call   8006c3 <_panic>
		if (intArr3[0] 	!= minInt 	|| intArr3[lastIndexOfInt3] 	!= maxInt) panic("Wrong allocation: stored values are wrongly changed!");
  8004d1:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8004d4:	8b 00                	mov    (%eax),%eax
  8004d6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004d9:	75 16                	jne    8004f1 <_main+0x4b9>
  8004db:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8004de:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004e5:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8004e8:	01 d0                	add    %edx,%eax
  8004ea:	8b 00                	mov    (%eax),%eax
  8004ec:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8004ef:	74 14                	je     800505 <_main+0x4cd>
  8004f1:	83 ec 04             	sub    $0x4,%esp
  8004f4:	68 b4 23 80 00       	push   $0x8023b4
  8004f9:	6a 66                	push   $0x66
  8004fb:	68 e9 23 80 00       	push   $0x8023e9
  800500:	e8 be 01 00 00       	call   8006c3 <_panic>

		if (structArr[0].a != minByte 	|| structArr[lastIndexOfStruct].a != maxByte) 	panic("Wrong allocation: stored values are wrongly changed!");
  800505:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800508:	8a 00                	mov    (%eax),%al
  80050a:	3a 45 ef             	cmp    -0x11(%ebp),%al
  80050d:	75 16                	jne    800525 <_main+0x4ed>
  80050f:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800512:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800519:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80051c:	01 d0                	add    %edx,%eax
  80051e:	8a 00                	mov    (%eax),%al
  800520:	3a 45 ee             	cmp    -0x12(%ebp),%al
  800523:	74 14                	je     800539 <_main+0x501>
  800525:	83 ec 04             	sub    $0x4,%esp
  800528:	68 b4 23 80 00       	push   $0x8023b4
  80052d:	6a 68                	push   $0x68
  80052f:	68 e9 23 80 00       	push   $0x8023e9
  800534:	e8 8a 01 00 00       	call   8006c3 <_panic>
		if (structArr[0].b != minShort 	|| structArr[lastIndexOfStruct].b != maxShort) 	panic("Wrong allocation: stored values are wrongly changed!");
  800539:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80053c:	66 8b 40 02          	mov    0x2(%eax),%ax
  800540:	66 3b 45 ec          	cmp    -0x14(%ebp),%ax
  800544:	75 19                	jne    80055f <_main+0x527>
  800546:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800549:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800550:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800553:	01 d0                	add    %edx,%eax
  800555:	66 8b 40 02          	mov    0x2(%eax),%ax
  800559:	66 3b 45 ea          	cmp    -0x16(%ebp),%ax
  80055d:	74 14                	je     800573 <_main+0x53b>
  80055f:	83 ec 04             	sub    $0x4,%esp
  800562:	68 b4 23 80 00       	push   $0x8023b4
  800567:	6a 69                	push   $0x69
  800569:	68 e9 23 80 00       	push   $0x8023e9
  80056e:	e8 50 01 00 00       	call   8006c3 <_panic>
		if (structArr[0].c != minInt 	|| structArr[lastIndexOfStruct].c != maxInt) 	panic("Wrong allocation: stored values are wrongly changed!");
  800573:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800576:	8b 40 04             	mov    0x4(%eax),%eax
  800579:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80057c:	75 17                	jne    800595 <_main+0x55d>
  80057e:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800581:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800588:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80058b:	01 d0                	add    %edx,%eax
  80058d:	8b 40 04             	mov    0x4(%eax),%eax
  800590:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800593:	74 14                	je     8005a9 <_main+0x571>
  800595:	83 ec 04             	sub    $0x4,%esp
  800598:	68 b4 23 80 00       	push   $0x8023b4
  80059d:	6a 6a                	push   $0x6a
  80059f:	68 e9 23 80 00       	push   $0x8023e9
  8005a4:	e8 1a 01 00 00       	call   8006c3 <_panic>


	}

	cprintf("Congratulations!! test freeRAM (1) completed successfully.\n");
  8005a9:	83 ec 0c             	sub    $0xc,%esp
  8005ac:	68 00 24 80 00       	push   $0x802400
  8005b1:	e8 c1 03 00 00       	call   800977 <cprintf>
  8005b6:	83 c4 10             	add    $0x10,%esp

	return;
  8005b9:	90                   	nop
}
  8005ba:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8005bd:	5b                   	pop    %ebx
  8005be:	5f                   	pop    %edi
  8005bf:	5d                   	pop    %ebp
  8005c0:	c3                   	ret    

008005c1 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005c1:	55                   	push   %ebp
  8005c2:	89 e5                	mov    %esp,%ebp
  8005c4:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005c7:	e8 66 14 00 00       	call   801a32 <sys_getenvindex>
  8005cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005d2:	89 d0                	mov    %edx,%eax
  8005d4:	01 c0                	add    %eax,%eax
  8005d6:	01 d0                	add    %edx,%eax
  8005d8:	c1 e0 02             	shl    $0x2,%eax
  8005db:	01 d0                	add    %edx,%eax
  8005dd:	c1 e0 06             	shl    $0x6,%eax
  8005e0:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005e5:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ef:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8005f5:	84 c0                	test   %al,%al
  8005f7:	74 0f                	je     800608 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8005f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8005fe:	05 f4 02 00 00       	add    $0x2f4,%eax
  800603:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800608:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80060c:	7e 0a                	jle    800618 <libmain+0x57>
		binaryname = argv[0];
  80060e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800611:	8b 00                	mov    (%eax),%eax
  800613:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800618:	83 ec 08             	sub    $0x8,%esp
  80061b:	ff 75 0c             	pushl  0xc(%ebp)
  80061e:	ff 75 08             	pushl  0x8(%ebp)
  800621:	e8 12 fa ff ff       	call   800038 <_main>
  800626:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800629:	e8 9f 15 00 00       	call   801bcd <sys_disable_interrupt>
	cprintf("**************************************\n");
  80062e:	83 ec 0c             	sub    $0xc,%esp
  800631:	68 54 24 80 00       	push   $0x802454
  800636:	e8 3c 03 00 00       	call   800977 <cprintf>
  80063b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80063e:	a1 20 30 80 00       	mov    0x803020,%eax
  800643:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800649:	a1 20 30 80 00       	mov    0x803020,%eax
  80064e:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800654:	83 ec 04             	sub    $0x4,%esp
  800657:	52                   	push   %edx
  800658:	50                   	push   %eax
  800659:	68 7c 24 80 00       	push   $0x80247c
  80065e:	e8 14 03 00 00       	call   800977 <cprintf>
  800663:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800666:	a1 20 30 80 00       	mov    0x803020,%eax
  80066b:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800671:	83 ec 08             	sub    $0x8,%esp
  800674:	50                   	push   %eax
  800675:	68 a1 24 80 00       	push   $0x8024a1
  80067a:	e8 f8 02 00 00       	call   800977 <cprintf>
  80067f:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800682:	83 ec 0c             	sub    $0xc,%esp
  800685:	68 54 24 80 00       	push   $0x802454
  80068a:	e8 e8 02 00 00       	call   800977 <cprintf>
  80068f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800692:	e8 50 15 00 00       	call   801be7 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800697:	e8 19 00 00 00       	call   8006b5 <exit>
}
  80069c:	90                   	nop
  80069d:	c9                   	leave  
  80069e:	c3                   	ret    

0080069f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80069f:	55                   	push   %ebp
  8006a0:	89 e5                	mov    %esp,%ebp
  8006a2:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006a5:	83 ec 0c             	sub    $0xc,%esp
  8006a8:	6a 00                	push   $0x0
  8006aa:	e8 4f 13 00 00       	call   8019fe <sys_env_destroy>
  8006af:	83 c4 10             	add    $0x10,%esp
}
  8006b2:	90                   	nop
  8006b3:	c9                   	leave  
  8006b4:	c3                   	ret    

008006b5 <exit>:

void
exit(void)
{
  8006b5:	55                   	push   %ebp
  8006b6:	89 e5                	mov    %esp,%ebp
  8006b8:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006bb:	e8 a4 13 00 00       	call   801a64 <sys_env_exit>
}
  8006c0:	90                   	nop
  8006c1:	c9                   	leave  
  8006c2:	c3                   	ret    

008006c3 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006c3:	55                   	push   %ebp
  8006c4:	89 e5                	mov    %esp,%ebp
  8006c6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006c9:	8d 45 10             	lea    0x10(%ebp),%eax
  8006cc:	83 c0 04             	add    $0x4,%eax
  8006cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006d2:	a1 30 30 80 00       	mov    0x803030,%eax
  8006d7:	85 c0                	test   %eax,%eax
  8006d9:	74 16                	je     8006f1 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006db:	a1 30 30 80 00       	mov    0x803030,%eax
  8006e0:	83 ec 08             	sub    $0x8,%esp
  8006e3:	50                   	push   %eax
  8006e4:	68 b8 24 80 00       	push   $0x8024b8
  8006e9:	e8 89 02 00 00       	call   800977 <cprintf>
  8006ee:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006f1:	a1 00 30 80 00       	mov    0x803000,%eax
  8006f6:	ff 75 0c             	pushl  0xc(%ebp)
  8006f9:	ff 75 08             	pushl  0x8(%ebp)
  8006fc:	50                   	push   %eax
  8006fd:	68 bd 24 80 00       	push   $0x8024bd
  800702:	e8 70 02 00 00       	call   800977 <cprintf>
  800707:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80070a:	8b 45 10             	mov    0x10(%ebp),%eax
  80070d:	83 ec 08             	sub    $0x8,%esp
  800710:	ff 75 f4             	pushl  -0xc(%ebp)
  800713:	50                   	push   %eax
  800714:	e8 f3 01 00 00       	call   80090c <vcprintf>
  800719:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80071c:	83 ec 08             	sub    $0x8,%esp
  80071f:	6a 00                	push   $0x0
  800721:	68 d9 24 80 00       	push   $0x8024d9
  800726:	e8 e1 01 00 00       	call   80090c <vcprintf>
  80072b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80072e:	e8 82 ff ff ff       	call   8006b5 <exit>

	// should not return here
	while (1) ;
  800733:	eb fe                	jmp    800733 <_panic+0x70>

00800735 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800735:	55                   	push   %ebp
  800736:	89 e5                	mov    %esp,%ebp
  800738:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80073b:	a1 20 30 80 00       	mov    0x803020,%eax
  800740:	8b 50 74             	mov    0x74(%eax),%edx
  800743:	8b 45 0c             	mov    0xc(%ebp),%eax
  800746:	39 c2                	cmp    %eax,%edx
  800748:	74 14                	je     80075e <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80074a:	83 ec 04             	sub    $0x4,%esp
  80074d:	68 dc 24 80 00       	push   $0x8024dc
  800752:	6a 26                	push   $0x26
  800754:	68 28 25 80 00       	push   $0x802528
  800759:	e8 65 ff ff ff       	call   8006c3 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80075e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800765:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80076c:	e9 c2 00 00 00       	jmp    800833 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800771:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800774:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80077b:	8b 45 08             	mov    0x8(%ebp),%eax
  80077e:	01 d0                	add    %edx,%eax
  800780:	8b 00                	mov    (%eax),%eax
  800782:	85 c0                	test   %eax,%eax
  800784:	75 08                	jne    80078e <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800786:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800789:	e9 a2 00 00 00       	jmp    800830 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80078e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800795:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80079c:	eb 69                	jmp    800807 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80079e:	a1 20 30 80 00       	mov    0x803020,%eax
  8007a3:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007a9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ac:	89 d0                	mov    %edx,%eax
  8007ae:	01 c0                	add    %eax,%eax
  8007b0:	01 d0                	add    %edx,%eax
  8007b2:	c1 e0 02             	shl    $0x2,%eax
  8007b5:	01 c8                	add    %ecx,%eax
  8007b7:	8a 40 04             	mov    0x4(%eax),%al
  8007ba:	84 c0                	test   %al,%al
  8007bc:	75 46                	jne    800804 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007be:	a1 20 30 80 00       	mov    0x803020,%eax
  8007c3:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007c9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007cc:	89 d0                	mov    %edx,%eax
  8007ce:	01 c0                	add    %eax,%eax
  8007d0:	01 d0                	add    %edx,%eax
  8007d2:	c1 e0 02             	shl    $0x2,%eax
  8007d5:	01 c8                	add    %ecx,%eax
  8007d7:	8b 00                	mov    (%eax),%eax
  8007d9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007dc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007df:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007e4:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007e9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f3:	01 c8                	add    %ecx,%eax
  8007f5:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007f7:	39 c2                	cmp    %eax,%edx
  8007f9:	75 09                	jne    800804 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8007fb:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800802:	eb 12                	jmp    800816 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800804:	ff 45 e8             	incl   -0x18(%ebp)
  800807:	a1 20 30 80 00       	mov    0x803020,%eax
  80080c:	8b 50 74             	mov    0x74(%eax),%edx
  80080f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800812:	39 c2                	cmp    %eax,%edx
  800814:	77 88                	ja     80079e <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800816:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80081a:	75 14                	jne    800830 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80081c:	83 ec 04             	sub    $0x4,%esp
  80081f:	68 34 25 80 00       	push   $0x802534
  800824:	6a 3a                	push   $0x3a
  800826:	68 28 25 80 00       	push   $0x802528
  80082b:	e8 93 fe ff ff       	call   8006c3 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800830:	ff 45 f0             	incl   -0x10(%ebp)
  800833:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800836:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800839:	0f 8c 32 ff ff ff    	jl     800771 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80083f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800846:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80084d:	eb 26                	jmp    800875 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80084f:	a1 20 30 80 00       	mov    0x803020,%eax
  800854:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80085a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80085d:	89 d0                	mov    %edx,%eax
  80085f:	01 c0                	add    %eax,%eax
  800861:	01 d0                	add    %edx,%eax
  800863:	c1 e0 02             	shl    $0x2,%eax
  800866:	01 c8                	add    %ecx,%eax
  800868:	8a 40 04             	mov    0x4(%eax),%al
  80086b:	3c 01                	cmp    $0x1,%al
  80086d:	75 03                	jne    800872 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80086f:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800872:	ff 45 e0             	incl   -0x20(%ebp)
  800875:	a1 20 30 80 00       	mov    0x803020,%eax
  80087a:	8b 50 74             	mov    0x74(%eax),%edx
  80087d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800880:	39 c2                	cmp    %eax,%edx
  800882:	77 cb                	ja     80084f <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800884:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800887:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80088a:	74 14                	je     8008a0 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80088c:	83 ec 04             	sub    $0x4,%esp
  80088f:	68 88 25 80 00       	push   $0x802588
  800894:	6a 44                	push   $0x44
  800896:	68 28 25 80 00       	push   $0x802528
  80089b:	e8 23 fe ff ff       	call   8006c3 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008a0:	90                   	nop
  8008a1:	c9                   	leave  
  8008a2:	c3                   	ret    

008008a3 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008a3:	55                   	push   %ebp
  8008a4:	89 e5                	mov    %esp,%ebp
  8008a6:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ac:	8b 00                	mov    (%eax),%eax
  8008ae:	8d 48 01             	lea    0x1(%eax),%ecx
  8008b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b4:	89 0a                	mov    %ecx,(%edx)
  8008b6:	8b 55 08             	mov    0x8(%ebp),%edx
  8008b9:	88 d1                	mov    %dl,%cl
  8008bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008be:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c5:	8b 00                	mov    (%eax),%eax
  8008c7:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008cc:	75 2c                	jne    8008fa <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008ce:	a0 24 30 80 00       	mov    0x803024,%al
  8008d3:	0f b6 c0             	movzbl %al,%eax
  8008d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d9:	8b 12                	mov    (%edx),%edx
  8008db:	89 d1                	mov    %edx,%ecx
  8008dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e0:	83 c2 08             	add    $0x8,%edx
  8008e3:	83 ec 04             	sub    $0x4,%esp
  8008e6:	50                   	push   %eax
  8008e7:	51                   	push   %ecx
  8008e8:	52                   	push   %edx
  8008e9:	e8 ce 10 00 00       	call   8019bc <sys_cputs>
  8008ee:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fd:	8b 40 04             	mov    0x4(%eax),%eax
  800900:	8d 50 01             	lea    0x1(%eax),%edx
  800903:	8b 45 0c             	mov    0xc(%ebp),%eax
  800906:	89 50 04             	mov    %edx,0x4(%eax)
}
  800909:	90                   	nop
  80090a:	c9                   	leave  
  80090b:	c3                   	ret    

0080090c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80090c:	55                   	push   %ebp
  80090d:	89 e5                	mov    %esp,%ebp
  80090f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800915:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80091c:	00 00 00 
	b.cnt = 0;
  80091f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800926:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800929:	ff 75 0c             	pushl  0xc(%ebp)
  80092c:	ff 75 08             	pushl  0x8(%ebp)
  80092f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800935:	50                   	push   %eax
  800936:	68 a3 08 80 00       	push   $0x8008a3
  80093b:	e8 11 02 00 00       	call   800b51 <vprintfmt>
  800940:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800943:	a0 24 30 80 00       	mov    0x803024,%al
  800948:	0f b6 c0             	movzbl %al,%eax
  80094b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800951:	83 ec 04             	sub    $0x4,%esp
  800954:	50                   	push   %eax
  800955:	52                   	push   %edx
  800956:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80095c:	83 c0 08             	add    $0x8,%eax
  80095f:	50                   	push   %eax
  800960:	e8 57 10 00 00       	call   8019bc <sys_cputs>
  800965:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800968:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80096f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800975:	c9                   	leave  
  800976:	c3                   	ret    

00800977 <cprintf>:

int cprintf(const char *fmt, ...) {
  800977:	55                   	push   %ebp
  800978:	89 e5                	mov    %esp,%ebp
  80097a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80097d:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800984:	8d 45 0c             	lea    0xc(%ebp),%eax
  800987:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80098a:	8b 45 08             	mov    0x8(%ebp),%eax
  80098d:	83 ec 08             	sub    $0x8,%esp
  800990:	ff 75 f4             	pushl  -0xc(%ebp)
  800993:	50                   	push   %eax
  800994:	e8 73 ff ff ff       	call   80090c <vcprintf>
  800999:	83 c4 10             	add    $0x10,%esp
  80099c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80099f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009a2:	c9                   	leave  
  8009a3:	c3                   	ret    

008009a4 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009a4:	55                   	push   %ebp
  8009a5:	89 e5                	mov    %esp,%ebp
  8009a7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009aa:	e8 1e 12 00 00       	call   801bcd <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009af:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b8:	83 ec 08             	sub    $0x8,%esp
  8009bb:	ff 75 f4             	pushl  -0xc(%ebp)
  8009be:	50                   	push   %eax
  8009bf:	e8 48 ff ff ff       	call   80090c <vcprintf>
  8009c4:	83 c4 10             	add    $0x10,%esp
  8009c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009ca:	e8 18 12 00 00       	call   801be7 <sys_enable_interrupt>
	return cnt;
  8009cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009d2:	c9                   	leave  
  8009d3:	c3                   	ret    

008009d4 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009d4:	55                   	push   %ebp
  8009d5:	89 e5                	mov    %esp,%ebp
  8009d7:	53                   	push   %ebx
  8009d8:	83 ec 14             	sub    $0x14,%esp
  8009db:	8b 45 10             	mov    0x10(%ebp),%eax
  8009de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009e7:	8b 45 18             	mov    0x18(%ebp),%eax
  8009ea:	ba 00 00 00 00       	mov    $0x0,%edx
  8009ef:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009f2:	77 55                	ja     800a49 <printnum+0x75>
  8009f4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009f7:	72 05                	jb     8009fe <printnum+0x2a>
  8009f9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009fc:	77 4b                	ja     800a49 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009fe:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a01:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a04:	8b 45 18             	mov    0x18(%ebp),%eax
  800a07:	ba 00 00 00 00       	mov    $0x0,%edx
  800a0c:	52                   	push   %edx
  800a0d:	50                   	push   %eax
  800a0e:	ff 75 f4             	pushl  -0xc(%ebp)
  800a11:	ff 75 f0             	pushl  -0x10(%ebp)
  800a14:	e8 47 16 00 00       	call   802060 <__udivdi3>
  800a19:	83 c4 10             	add    $0x10,%esp
  800a1c:	83 ec 04             	sub    $0x4,%esp
  800a1f:	ff 75 20             	pushl  0x20(%ebp)
  800a22:	53                   	push   %ebx
  800a23:	ff 75 18             	pushl  0x18(%ebp)
  800a26:	52                   	push   %edx
  800a27:	50                   	push   %eax
  800a28:	ff 75 0c             	pushl  0xc(%ebp)
  800a2b:	ff 75 08             	pushl  0x8(%ebp)
  800a2e:	e8 a1 ff ff ff       	call   8009d4 <printnum>
  800a33:	83 c4 20             	add    $0x20,%esp
  800a36:	eb 1a                	jmp    800a52 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a38:	83 ec 08             	sub    $0x8,%esp
  800a3b:	ff 75 0c             	pushl  0xc(%ebp)
  800a3e:	ff 75 20             	pushl  0x20(%ebp)
  800a41:	8b 45 08             	mov    0x8(%ebp),%eax
  800a44:	ff d0                	call   *%eax
  800a46:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a49:	ff 4d 1c             	decl   0x1c(%ebp)
  800a4c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a50:	7f e6                	jg     800a38 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a52:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a55:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a5d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a60:	53                   	push   %ebx
  800a61:	51                   	push   %ecx
  800a62:	52                   	push   %edx
  800a63:	50                   	push   %eax
  800a64:	e8 07 17 00 00       	call   802170 <__umoddi3>
  800a69:	83 c4 10             	add    $0x10,%esp
  800a6c:	05 f4 27 80 00       	add    $0x8027f4,%eax
  800a71:	8a 00                	mov    (%eax),%al
  800a73:	0f be c0             	movsbl %al,%eax
  800a76:	83 ec 08             	sub    $0x8,%esp
  800a79:	ff 75 0c             	pushl  0xc(%ebp)
  800a7c:	50                   	push   %eax
  800a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a80:	ff d0                	call   *%eax
  800a82:	83 c4 10             	add    $0x10,%esp
}
  800a85:	90                   	nop
  800a86:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a89:	c9                   	leave  
  800a8a:	c3                   	ret    

00800a8b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a8b:	55                   	push   %ebp
  800a8c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a8e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a92:	7e 1c                	jle    800ab0 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a94:	8b 45 08             	mov    0x8(%ebp),%eax
  800a97:	8b 00                	mov    (%eax),%eax
  800a99:	8d 50 08             	lea    0x8(%eax),%edx
  800a9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9f:	89 10                	mov    %edx,(%eax)
  800aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa4:	8b 00                	mov    (%eax),%eax
  800aa6:	83 e8 08             	sub    $0x8,%eax
  800aa9:	8b 50 04             	mov    0x4(%eax),%edx
  800aac:	8b 00                	mov    (%eax),%eax
  800aae:	eb 40                	jmp    800af0 <getuint+0x65>
	else if (lflag)
  800ab0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ab4:	74 1e                	je     800ad4 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	8b 00                	mov    (%eax),%eax
  800abb:	8d 50 04             	lea    0x4(%eax),%edx
  800abe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac1:	89 10                	mov    %edx,(%eax)
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	8b 00                	mov    (%eax),%eax
  800ac8:	83 e8 04             	sub    $0x4,%eax
  800acb:	8b 00                	mov    (%eax),%eax
  800acd:	ba 00 00 00 00       	mov    $0x0,%edx
  800ad2:	eb 1c                	jmp    800af0 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ad4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad7:	8b 00                	mov    (%eax),%eax
  800ad9:	8d 50 04             	lea    0x4(%eax),%edx
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	89 10                	mov    %edx,(%eax)
  800ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae4:	8b 00                	mov    (%eax),%eax
  800ae6:	83 e8 04             	sub    $0x4,%eax
  800ae9:	8b 00                	mov    (%eax),%eax
  800aeb:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800af0:	5d                   	pop    %ebp
  800af1:	c3                   	ret    

00800af2 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800af2:	55                   	push   %ebp
  800af3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800af5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800af9:	7e 1c                	jle    800b17 <getint+0x25>
		return va_arg(*ap, long long);
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
  800afe:	8b 00                	mov    (%eax),%eax
  800b00:	8d 50 08             	lea    0x8(%eax),%edx
  800b03:	8b 45 08             	mov    0x8(%ebp),%eax
  800b06:	89 10                	mov    %edx,(%eax)
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	8b 00                	mov    (%eax),%eax
  800b0d:	83 e8 08             	sub    $0x8,%eax
  800b10:	8b 50 04             	mov    0x4(%eax),%edx
  800b13:	8b 00                	mov    (%eax),%eax
  800b15:	eb 38                	jmp    800b4f <getint+0x5d>
	else if (lflag)
  800b17:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b1b:	74 1a                	je     800b37 <getint+0x45>
		return va_arg(*ap, long);
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	8b 00                	mov    (%eax),%eax
  800b22:	8d 50 04             	lea    0x4(%eax),%edx
  800b25:	8b 45 08             	mov    0x8(%ebp),%eax
  800b28:	89 10                	mov    %edx,(%eax)
  800b2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2d:	8b 00                	mov    (%eax),%eax
  800b2f:	83 e8 04             	sub    $0x4,%eax
  800b32:	8b 00                	mov    (%eax),%eax
  800b34:	99                   	cltd   
  800b35:	eb 18                	jmp    800b4f <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	8b 00                	mov    (%eax),%eax
  800b3c:	8d 50 04             	lea    0x4(%eax),%edx
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	89 10                	mov    %edx,(%eax)
  800b44:	8b 45 08             	mov    0x8(%ebp),%eax
  800b47:	8b 00                	mov    (%eax),%eax
  800b49:	83 e8 04             	sub    $0x4,%eax
  800b4c:	8b 00                	mov    (%eax),%eax
  800b4e:	99                   	cltd   
}
  800b4f:	5d                   	pop    %ebp
  800b50:	c3                   	ret    

00800b51 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b51:	55                   	push   %ebp
  800b52:	89 e5                	mov    %esp,%ebp
  800b54:	56                   	push   %esi
  800b55:	53                   	push   %ebx
  800b56:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b59:	eb 17                	jmp    800b72 <vprintfmt+0x21>
			if (ch == '\0')
  800b5b:	85 db                	test   %ebx,%ebx
  800b5d:	0f 84 af 03 00 00    	je     800f12 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b63:	83 ec 08             	sub    $0x8,%esp
  800b66:	ff 75 0c             	pushl  0xc(%ebp)
  800b69:	53                   	push   %ebx
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	ff d0                	call   *%eax
  800b6f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b72:	8b 45 10             	mov    0x10(%ebp),%eax
  800b75:	8d 50 01             	lea    0x1(%eax),%edx
  800b78:	89 55 10             	mov    %edx,0x10(%ebp)
  800b7b:	8a 00                	mov    (%eax),%al
  800b7d:	0f b6 d8             	movzbl %al,%ebx
  800b80:	83 fb 25             	cmp    $0x25,%ebx
  800b83:	75 d6                	jne    800b5b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b85:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b89:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b90:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b97:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b9e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ba5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba8:	8d 50 01             	lea    0x1(%eax),%edx
  800bab:	89 55 10             	mov    %edx,0x10(%ebp)
  800bae:	8a 00                	mov    (%eax),%al
  800bb0:	0f b6 d8             	movzbl %al,%ebx
  800bb3:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bb6:	83 f8 55             	cmp    $0x55,%eax
  800bb9:	0f 87 2b 03 00 00    	ja     800eea <vprintfmt+0x399>
  800bbf:	8b 04 85 18 28 80 00 	mov    0x802818(,%eax,4),%eax
  800bc6:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bc8:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bcc:	eb d7                	jmp    800ba5 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bce:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bd2:	eb d1                	jmp    800ba5 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bd4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bdb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bde:	89 d0                	mov    %edx,%eax
  800be0:	c1 e0 02             	shl    $0x2,%eax
  800be3:	01 d0                	add    %edx,%eax
  800be5:	01 c0                	add    %eax,%eax
  800be7:	01 d8                	add    %ebx,%eax
  800be9:	83 e8 30             	sub    $0x30,%eax
  800bec:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bef:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf2:	8a 00                	mov    (%eax),%al
  800bf4:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bf7:	83 fb 2f             	cmp    $0x2f,%ebx
  800bfa:	7e 3e                	jle    800c3a <vprintfmt+0xe9>
  800bfc:	83 fb 39             	cmp    $0x39,%ebx
  800bff:	7f 39                	jg     800c3a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c01:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c04:	eb d5                	jmp    800bdb <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c06:	8b 45 14             	mov    0x14(%ebp),%eax
  800c09:	83 c0 04             	add    $0x4,%eax
  800c0c:	89 45 14             	mov    %eax,0x14(%ebp)
  800c0f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c12:	83 e8 04             	sub    $0x4,%eax
  800c15:	8b 00                	mov    (%eax),%eax
  800c17:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c1a:	eb 1f                	jmp    800c3b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c1c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c20:	79 83                	jns    800ba5 <vprintfmt+0x54>
				width = 0;
  800c22:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c29:	e9 77 ff ff ff       	jmp    800ba5 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c2e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c35:	e9 6b ff ff ff       	jmp    800ba5 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c3a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c3b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c3f:	0f 89 60 ff ff ff    	jns    800ba5 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c45:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c48:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c4b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c52:	e9 4e ff ff ff       	jmp    800ba5 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c57:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c5a:	e9 46 ff ff ff       	jmp    800ba5 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c5f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c62:	83 c0 04             	add    $0x4,%eax
  800c65:	89 45 14             	mov    %eax,0x14(%ebp)
  800c68:	8b 45 14             	mov    0x14(%ebp),%eax
  800c6b:	83 e8 04             	sub    $0x4,%eax
  800c6e:	8b 00                	mov    (%eax),%eax
  800c70:	83 ec 08             	sub    $0x8,%esp
  800c73:	ff 75 0c             	pushl  0xc(%ebp)
  800c76:	50                   	push   %eax
  800c77:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7a:	ff d0                	call   *%eax
  800c7c:	83 c4 10             	add    $0x10,%esp
			break;
  800c7f:	e9 89 02 00 00       	jmp    800f0d <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c84:	8b 45 14             	mov    0x14(%ebp),%eax
  800c87:	83 c0 04             	add    $0x4,%eax
  800c8a:	89 45 14             	mov    %eax,0x14(%ebp)
  800c8d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c90:	83 e8 04             	sub    $0x4,%eax
  800c93:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c95:	85 db                	test   %ebx,%ebx
  800c97:	79 02                	jns    800c9b <vprintfmt+0x14a>
				err = -err;
  800c99:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c9b:	83 fb 64             	cmp    $0x64,%ebx
  800c9e:	7f 0b                	jg     800cab <vprintfmt+0x15a>
  800ca0:	8b 34 9d 60 26 80 00 	mov    0x802660(,%ebx,4),%esi
  800ca7:	85 f6                	test   %esi,%esi
  800ca9:	75 19                	jne    800cc4 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cab:	53                   	push   %ebx
  800cac:	68 05 28 80 00       	push   $0x802805
  800cb1:	ff 75 0c             	pushl  0xc(%ebp)
  800cb4:	ff 75 08             	pushl  0x8(%ebp)
  800cb7:	e8 5e 02 00 00       	call   800f1a <printfmt>
  800cbc:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cbf:	e9 49 02 00 00       	jmp    800f0d <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cc4:	56                   	push   %esi
  800cc5:	68 0e 28 80 00       	push   $0x80280e
  800cca:	ff 75 0c             	pushl  0xc(%ebp)
  800ccd:	ff 75 08             	pushl  0x8(%ebp)
  800cd0:	e8 45 02 00 00       	call   800f1a <printfmt>
  800cd5:	83 c4 10             	add    $0x10,%esp
			break;
  800cd8:	e9 30 02 00 00       	jmp    800f0d <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cdd:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce0:	83 c0 04             	add    $0x4,%eax
  800ce3:	89 45 14             	mov    %eax,0x14(%ebp)
  800ce6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce9:	83 e8 04             	sub    $0x4,%eax
  800cec:	8b 30                	mov    (%eax),%esi
  800cee:	85 f6                	test   %esi,%esi
  800cf0:	75 05                	jne    800cf7 <vprintfmt+0x1a6>
				p = "(null)";
  800cf2:	be 11 28 80 00       	mov    $0x802811,%esi
			if (width > 0 && padc != '-')
  800cf7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cfb:	7e 6d                	jle    800d6a <vprintfmt+0x219>
  800cfd:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d01:	74 67                	je     800d6a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d03:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d06:	83 ec 08             	sub    $0x8,%esp
  800d09:	50                   	push   %eax
  800d0a:	56                   	push   %esi
  800d0b:	e8 0c 03 00 00       	call   80101c <strnlen>
  800d10:	83 c4 10             	add    $0x10,%esp
  800d13:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d16:	eb 16                	jmp    800d2e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d18:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d1c:	83 ec 08             	sub    $0x8,%esp
  800d1f:	ff 75 0c             	pushl  0xc(%ebp)
  800d22:	50                   	push   %eax
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	ff d0                	call   *%eax
  800d28:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d2b:	ff 4d e4             	decl   -0x1c(%ebp)
  800d2e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d32:	7f e4                	jg     800d18 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d34:	eb 34                	jmp    800d6a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d36:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d3a:	74 1c                	je     800d58 <vprintfmt+0x207>
  800d3c:	83 fb 1f             	cmp    $0x1f,%ebx
  800d3f:	7e 05                	jle    800d46 <vprintfmt+0x1f5>
  800d41:	83 fb 7e             	cmp    $0x7e,%ebx
  800d44:	7e 12                	jle    800d58 <vprintfmt+0x207>
					putch('?', putdat);
  800d46:	83 ec 08             	sub    $0x8,%esp
  800d49:	ff 75 0c             	pushl  0xc(%ebp)
  800d4c:	6a 3f                	push   $0x3f
  800d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d51:	ff d0                	call   *%eax
  800d53:	83 c4 10             	add    $0x10,%esp
  800d56:	eb 0f                	jmp    800d67 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d58:	83 ec 08             	sub    $0x8,%esp
  800d5b:	ff 75 0c             	pushl  0xc(%ebp)
  800d5e:	53                   	push   %ebx
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	ff d0                	call   *%eax
  800d64:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d67:	ff 4d e4             	decl   -0x1c(%ebp)
  800d6a:	89 f0                	mov    %esi,%eax
  800d6c:	8d 70 01             	lea    0x1(%eax),%esi
  800d6f:	8a 00                	mov    (%eax),%al
  800d71:	0f be d8             	movsbl %al,%ebx
  800d74:	85 db                	test   %ebx,%ebx
  800d76:	74 24                	je     800d9c <vprintfmt+0x24b>
  800d78:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d7c:	78 b8                	js     800d36 <vprintfmt+0x1e5>
  800d7e:	ff 4d e0             	decl   -0x20(%ebp)
  800d81:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d85:	79 af                	jns    800d36 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d87:	eb 13                	jmp    800d9c <vprintfmt+0x24b>
				putch(' ', putdat);
  800d89:	83 ec 08             	sub    $0x8,%esp
  800d8c:	ff 75 0c             	pushl  0xc(%ebp)
  800d8f:	6a 20                	push   $0x20
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	ff d0                	call   *%eax
  800d96:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d99:	ff 4d e4             	decl   -0x1c(%ebp)
  800d9c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da0:	7f e7                	jg     800d89 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800da2:	e9 66 01 00 00       	jmp    800f0d <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800da7:	83 ec 08             	sub    $0x8,%esp
  800daa:	ff 75 e8             	pushl  -0x18(%ebp)
  800dad:	8d 45 14             	lea    0x14(%ebp),%eax
  800db0:	50                   	push   %eax
  800db1:	e8 3c fd ff ff       	call   800af2 <getint>
  800db6:	83 c4 10             	add    $0x10,%esp
  800db9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dbc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dc5:	85 d2                	test   %edx,%edx
  800dc7:	79 23                	jns    800dec <vprintfmt+0x29b>
				putch('-', putdat);
  800dc9:	83 ec 08             	sub    $0x8,%esp
  800dcc:	ff 75 0c             	pushl  0xc(%ebp)
  800dcf:	6a 2d                	push   $0x2d
  800dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd4:	ff d0                	call   *%eax
  800dd6:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ddc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ddf:	f7 d8                	neg    %eax
  800de1:	83 d2 00             	adc    $0x0,%edx
  800de4:	f7 da                	neg    %edx
  800de6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800de9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800dec:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800df3:	e9 bc 00 00 00       	jmp    800eb4 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800df8:	83 ec 08             	sub    $0x8,%esp
  800dfb:	ff 75 e8             	pushl  -0x18(%ebp)
  800dfe:	8d 45 14             	lea    0x14(%ebp),%eax
  800e01:	50                   	push   %eax
  800e02:	e8 84 fc ff ff       	call   800a8b <getuint>
  800e07:	83 c4 10             	add    $0x10,%esp
  800e0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e0d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e10:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e17:	e9 98 00 00 00       	jmp    800eb4 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e1c:	83 ec 08             	sub    $0x8,%esp
  800e1f:	ff 75 0c             	pushl  0xc(%ebp)
  800e22:	6a 58                	push   $0x58
  800e24:	8b 45 08             	mov    0x8(%ebp),%eax
  800e27:	ff d0                	call   *%eax
  800e29:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e2c:	83 ec 08             	sub    $0x8,%esp
  800e2f:	ff 75 0c             	pushl  0xc(%ebp)
  800e32:	6a 58                	push   $0x58
  800e34:	8b 45 08             	mov    0x8(%ebp),%eax
  800e37:	ff d0                	call   *%eax
  800e39:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e3c:	83 ec 08             	sub    $0x8,%esp
  800e3f:	ff 75 0c             	pushl  0xc(%ebp)
  800e42:	6a 58                	push   $0x58
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	ff d0                	call   *%eax
  800e49:	83 c4 10             	add    $0x10,%esp
			break;
  800e4c:	e9 bc 00 00 00       	jmp    800f0d <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e51:	83 ec 08             	sub    $0x8,%esp
  800e54:	ff 75 0c             	pushl  0xc(%ebp)
  800e57:	6a 30                	push   $0x30
  800e59:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5c:	ff d0                	call   *%eax
  800e5e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e61:	83 ec 08             	sub    $0x8,%esp
  800e64:	ff 75 0c             	pushl  0xc(%ebp)
  800e67:	6a 78                	push   $0x78
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6c:	ff d0                	call   *%eax
  800e6e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e71:	8b 45 14             	mov    0x14(%ebp),%eax
  800e74:	83 c0 04             	add    $0x4,%eax
  800e77:	89 45 14             	mov    %eax,0x14(%ebp)
  800e7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e7d:	83 e8 04             	sub    $0x4,%eax
  800e80:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e82:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e85:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e8c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e93:	eb 1f                	jmp    800eb4 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e95:	83 ec 08             	sub    $0x8,%esp
  800e98:	ff 75 e8             	pushl  -0x18(%ebp)
  800e9b:	8d 45 14             	lea    0x14(%ebp),%eax
  800e9e:	50                   	push   %eax
  800e9f:	e8 e7 fb ff ff       	call   800a8b <getuint>
  800ea4:	83 c4 10             	add    $0x10,%esp
  800ea7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eaa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ead:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800eb4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800eb8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ebb:	83 ec 04             	sub    $0x4,%esp
  800ebe:	52                   	push   %edx
  800ebf:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ec2:	50                   	push   %eax
  800ec3:	ff 75 f4             	pushl  -0xc(%ebp)
  800ec6:	ff 75 f0             	pushl  -0x10(%ebp)
  800ec9:	ff 75 0c             	pushl  0xc(%ebp)
  800ecc:	ff 75 08             	pushl  0x8(%ebp)
  800ecf:	e8 00 fb ff ff       	call   8009d4 <printnum>
  800ed4:	83 c4 20             	add    $0x20,%esp
			break;
  800ed7:	eb 34                	jmp    800f0d <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ed9:	83 ec 08             	sub    $0x8,%esp
  800edc:	ff 75 0c             	pushl  0xc(%ebp)
  800edf:	53                   	push   %ebx
  800ee0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee3:	ff d0                	call   *%eax
  800ee5:	83 c4 10             	add    $0x10,%esp
			break;
  800ee8:	eb 23                	jmp    800f0d <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800eea:	83 ec 08             	sub    $0x8,%esp
  800eed:	ff 75 0c             	pushl  0xc(%ebp)
  800ef0:	6a 25                	push   $0x25
  800ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef5:	ff d0                	call   *%eax
  800ef7:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800efa:	ff 4d 10             	decl   0x10(%ebp)
  800efd:	eb 03                	jmp    800f02 <vprintfmt+0x3b1>
  800eff:	ff 4d 10             	decl   0x10(%ebp)
  800f02:	8b 45 10             	mov    0x10(%ebp),%eax
  800f05:	48                   	dec    %eax
  800f06:	8a 00                	mov    (%eax),%al
  800f08:	3c 25                	cmp    $0x25,%al
  800f0a:	75 f3                	jne    800eff <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f0c:	90                   	nop
		}
	}
  800f0d:	e9 47 fc ff ff       	jmp    800b59 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f12:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f13:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f16:	5b                   	pop    %ebx
  800f17:	5e                   	pop    %esi
  800f18:	5d                   	pop    %ebp
  800f19:	c3                   	ret    

00800f1a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f1a:	55                   	push   %ebp
  800f1b:	89 e5                	mov    %esp,%ebp
  800f1d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f20:	8d 45 10             	lea    0x10(%ebp),%eax
  800f23:	83 c0 04             	add    $0x4,%eax
  800f26:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f29:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2c:	ff 75 f4             	pushl  -0xc(%ebp)
  800f2f:	50                   	push   %eax
  800f30:	ff 75 0c             	pushl  0xc(%ebp)
  800f33:	ff 75 08             	pushl  0x8(%ebp)
  800f36:	e8 16 fc ff ff       	call   800b51 <vprintfmt>
  800f3b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f3e:	90                   	nop
  800f3f:	c9                   	leave  
  800f40:	c3                   	ret    

00800f41 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f41:	55                   	push   %ebp
  800f42:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f47:	8b 40 08             	mov    0x8(%eax),%eax
  800f4a:	8d 50 01             	lea    0x1(%eax),%edx
  800f4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f50:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f56:	8b 10                	mov    (%eax),%edx
  800f58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5b:	8b 40 04             	mov    0x4(%eax),%eax
  800f5e:	39 c2                	cmp    %eax,%edx
  800f60:	73 12                	jae    800f74 <sprintputch+0x33>
		*b->buf++ = ch;
  800f62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f65:	8b 00                	mov    (%eax),%eax
  800f67:	8d 48 01             	lea    0x1(%eax),%ecx
  800f6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f6d:	89 0a                	mov    %ecx,(%edx)
  800f6f:	8b 55 08             	mov    0x8(%ebp),%edx
  800f72:	88 10                	mov    %dl,(%eax)
}
  800f74:	90                   	nop
  800f75:	5d                   	pop    %ebp
  800f76:	c3                   	ret    

00800f77 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f77:	55                   	push   %ebp
  800f78:	89 e5                	mov    %esp,%ebp
  800f7a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f80:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f86:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	01 d0                	add    %edx,%eax
  800f8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f91:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f98:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f9c:	74 06                	je     800fa4 <vsnprintf+0x2d>
  800f9e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fa2:	7f 07                	jg     800fab <vsnprintf+0x34>
		return -E_INVAL;
  800fa4:	b8 03 00 00 00       	mov    $0x3,%eax
  800fa9:	eb 20                	jmp    800fcb <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fab:	ff 75 14             	pushl  0x14(%ebp)
  800fae:	ff 75 10             	pushl  0x10(%ebp)
  800fb1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fb4:	50                   	push   %eax
  800fb5:	68 41 0f 80 00       	push   $0x800f41
  800fba:	e8 92 fb ff ff       	call   800b51 <vprintfmt>
  800fbf:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fc2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fc5:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fcb:	c9                   	leave  
  800fcc:	c3                   	ret    

00800fcd <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fcd:	55                   	push   %ebp
  800fce:	89 e5                	mov    %esp,%ebp
  800fd0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fd3:	8d 45 10             	lea    0x10(%ebp),%eax
  800fd6:	83 c0 04             	add    $0x4,%eax
  800fd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdf:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe2:	50                   	push   %eax
  800fe3:	ff 75 0c             	pushl  0xc(%ebp)
  800fe6:	ff 75 08             	pushl  0x8(%ebp)
  800fe9:	e8 89 ff ff ff       	call   800f77 <vsnprintf>
  800fee:	83 c4 10             	add    $0x10,%esp
  800ff1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ff4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ff7:	c9                   	leave  
  800ff8:	c3                   	ret    

00800ff9 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ff9:	55                   	push   %ebp
  800ffa:	89 e5                	mov    %esp,%ebp
  800ffc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800fff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801006:	eb 06                	jmp    80100e <strlen+0x15>
		n++;
  801008:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80100b:	ff 45 08             	incl   0x8(%ebp)
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	8a 00                	mov    (%eax),%al
  801013:	84 c0                	test   %al,%al
  801015:	75 f1                	jne    801008 <strlen+0xf>
		n++;
	return n;
  801017:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80101a:	c9                   	leave  
  80101b:	c3                   	ret    

0080101c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80101c:	55                   	push   %ebp
  80101d:	89 e5                	mov    %esp,%ebp
  80101f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801022:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801029:	eb 09                	jmp    801034 <strnlen+0x18>
		n++;
  80102b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80102e:	ff 45 08             	incl   0x8(%ebp)
  801031:	ff 4d 0c             	decl   0xc(%ebp)
  801034:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801038:	74 09                	je     801043 <strnlen+0x27>
  80103a:	8b 45 08             	mov    0x8(%ebp),%eax
  80103d:	8a 00                	mov    (%eax),%al
  80103f:	84 c0                	test   %al,%al
  801041:	75 e8                	jne    80102b <strnlen+0xf>
		n++;
	return n;
  801043:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801046:	c9                   	leave  
  801047:	c3                   	ret    

00801048 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801048:	55                   	push   %ebp
  801049:	89 e5                	mov    %esp,%ebp
  80104b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80104e:	8b 45 08             	mov    0x8(%ebp),%eax
  801051:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801054:	90                   	nop
  801055:	8b 45 08             	mov    0x8(%ebp),%eax
  801058:	8d 50 01             	lea    0x1(%eax),%edx
  80105b:	89 55 08             	mov    %edx,0x8(%ebp)
  80105e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801061:	8d 4a 01             	lea    0x1(%edx),%ecx
  801064:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801067:	8a 12                	mov    (%edx),%dl
  801069:	88 10                	mov    %dl,(%eax)
  80106b:	8a 00                	mov    (%eax),%al
  80106d:	84 c0                	test   %al,%al
  80106f:	75 e4                	jne    801055 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801071:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801074:	c9                   	leave  
  801075:	c3                   	ret    

00801076 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801076:	55                   	push   %ebp
  801077:	89 e5                	mov    %esp,%ebp
  801079:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80107c:	8b 45 08             	mov    0x8(%ebp),%eax
  80107f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801082:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801089:	eb 1f                	jmp    8010aa <strncpy+0x34>
		*dst++ = *src;
  80108b:	8b 45 08             	mov    0x8(%ebp),%eax
  80108e:	8d 50 01             	lea    0x1(%eax),%edx
  801091:	89 55 08             	mov    %edx,0x8(%ebp)
  801094:	8b 55 0c             	mov    0xc(%ebp),%edx
  801097:	8a 12                	mov    (%edx),%dl
  801099:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80109b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109e:	8a 00                	mov    (%eax),%al
  8010a0:	84 c0                	test   %al,%al
  8010a2:	74 03                	je     8010a7 <strncpy+0x31>
			src++;
  8010a4:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010a7:	ff 45 fc             	incl   -0x4(%ebp)
  8010aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ad:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010b0:	72 d9                	jb     80108b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010b5:	c9                   	leave  
  8010b6:	c3                   	ret    

008010b7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010b7:	55                   	push   %ebp
  8010b8:	89 e5                	mov    %esp,%ebp
  8010ba:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010c3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010c7:	74 30                	je     8010f9 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010c9:	eb 16                	jmp    8010e1 <strlcpy+0x2a>
			*dst++ = *src++;
  8010cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ce:	8d 50 01             	lea    0x1(%eax),%edx
  8010d1:	89 55 08             	mov    %edx,0x8(%ebp)
  8010d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010d7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010da:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010dd:	8a 12                	mov    (%edx),%dl
  8010df:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010e1:	ff 4d 10             	decl   0x10(%ebp)
  8010e4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e8:	74 09                	je     8010f3 <strlcpy+0x3c>
  8010ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ed:	8a 00                	mov    (%eax),%al
  8010ef:	84 c0                	test   %al,%al
  8010f1:	75 d8                	jne    8010cb <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f6:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010f9:	8b 55 08             	mov    0x8(%ebp),%edx
  8010fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ff:	29 c2                	sub    %eax,%edx
  801101:	89 d0                	mov    %edx,%eax
}
  801103:	c9                   	leave  
  801104:	c3                   	ret    

00801105 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801105:	55                   	push   %ebp
  801106:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801108:	eb 06                	jmp    801110 <strcmp+0xb>
		p++, q++;
  80110a:	ff 45 08             	incl   0x8(%ebp)
  80110d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801110:	8b 45 08             	mov    0x8(%ebp),%eax
  801113:	8a 00                	mov    (%eax),%al
  801115:	84 c0                	test   %al,%al
  801117:	74 0e                	je     801127 <strcmp+0x22>
  801119:	8b 45 08             	mov    0x8(%ebp),%eax
  80111c:	8a 10                	mov    (%eax),%dl
  80111e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801121:	8a 00                	mov    (%eax),%al
  801123:	38 c2                	cmp    %al,%dl
  801125:	74 e3                	je     80110a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	8a 00                	mov    (%eax),%al
  80112c:	0f b6 d0             	movzbl %al,%edx
  80112f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801132:	8a 00                	mov    (%eax),%al
  801134:	0f b6 c0             	movzbl %al,%eax
  801137:	29 c2                	sub    %eax,%edx
  801139:	89 d0                	mov    %edx,%eax
}
  80113b:	5d                   	pop    %ebp
  80113c:	c3                   	ret    

0080113d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80113d:	55                   	push   %ebp
  80113e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801140:	eb 09                	jmp    80114b <strncmp+0xe>
		n--, p++, q++;
  801142:	ff 4d 10             	decl   0x10(%ebp)
  801145:	ff 45 08             	incl   0x8(%ebp)
  801148:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80114b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80114f:	74 17                	je     801168 <strncmp+0x2b>
  801151:	8b 45 08             	mov    0x8(%ebp),%eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	84 c0                	test   %al,%al
  801158:	74 0e                	je     801168 <strncmp+0x2b>
  80115a:	8b 45 08             	mov    0x8(%ebp),%eax
  80115d:	8a 10                	mov    (%eax),%dl
  80115f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801162:	8a 00                	mov    (%eax),%al
  801164:	38 c2                	cmp    %al,%dl
  801166:	74 da                	je     801142 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801168:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80116c:	75 07                	jne    801175 <strncmp+0x38>
		return 0;
  80116e:	b8 00 00 00 00       	mov    $0x0,%eax
  801173:	eb 14                	jmp    801189 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801175:	8b 45 08             	mov    0x8(%ebp),%eax
  801178:	8a 00                	mov    (%eax),%al
  80117a:	0f b6 d0             	movzbl %al,%edx
  80117d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801180:	8a 00                	mov    (%eax),%al
  801182:	0f b6 c0             	movzbl %al,%eax
  801185:	29 c2                	sub    %eax,%edx
  801187:	89 d0                	mov    %edx,%eax
}
  801189:	5d                   	pop    %ebp
  80118a:	c3                   	ret    

0080118b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80118b:	55                   	push   %ebp
  80118c:	89 e5                	mov    %esp,%ebp
  80118e:	83 ec 04             	sub    $0x4,%esp
  801191:	8b 45 0c             	mov    0xc(%ebp),%eax
  801194:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801197:	eb 12                	jmp    8011ab <strchr+0x20>
		if (*s == c)
  801199:	8b 45 08             	mov    0x8(%ebp),%eax
  80119c:	8a 00                	mov    (%eax),%al
  80119e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011a1:	75 05                	jne    8011a8 <strchr+0x1d>
			return (char *) s;
  8011a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a6:	eb 11                	jmp    8011b9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011a8:	ff 45 08             	incl   0x8(%ebp)
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ae:	8a 00                	mov    (%eax),%al
  8011b0:	84 c0                	test   %al,%al
  8011b2:	75 e5                	jne    801199 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011b9:	c9                   	leave  
  8011ba:	c3                   	ret    

008011bb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011bb:	55                   	push   %ebp
  8011bc:	89 e5                	mov    %esp,%ebp
  8011be:	83 ec 04             	sub    $0x4,%esp
  8011c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011c7:	eb 0d                	jmp    8011d6 <strfind+0x1b>
		if (*s == c)
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	8a 00                	mov    (%eax),%al
  8011ce:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011d1:	74 0e                	je     8011e1 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011d3:	ff 45 08             	incl   0x8(%ebp)
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	8a 00                	mov    (%eax),%al
  8011db:	84 c0                	test   %al,%al
  8011dd:	75 ea                	jne    8011c9 <strfind+0xe>
  8011df:	eb 01                	jmp    8011e2 <strfind+0x27>
		if (*s == c)
			break;
  8011e1:	90                   	nop
	return (char *) s;
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011e5:	c9                   	leave  
  8011e6:	c3                   	ret    

008011e7 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011e7:	55                   	push   %ebp
  8011e8:	89 e5                	mov    %esp,%ebp
  8011ea:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011f9:	eb 0e                	jmp    801209 <memset+0x22>
		*p++ = c;
  8011fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011fe:	8d 50 01             	lea    0x1(%eax),%edx
  801201:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801204:	8b 55 0c             	mov    0xc(%ebp),%edx
  801207:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801209:	ff 4d f8             	decl   -0x8(%ebp)
  80120c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801210:	79 e9                	jns    8011fb <memset+0x14>
		*p++ = c;

	return v;
  801212:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801215:	c9                   	leave  
  801216:	c3                   	ret    

00801217 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801217:	55                   	push   %ebp
  801218:	89 e5                	mov    %esp,%ebp
  80121a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80121d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801220:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801223:	8b 45 08             	mov    0x8(%ebp),%eax
  801226:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801229:	eb 16                	jmp    801241 <memcpy+0x2a>
		*d++ = *s++;
  80122b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80122e:	8d 50 01             	lea    0x1(%eax),%edx
  801231:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801234:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801237:	8d 4a 01             	lea    0x1(%edx),%ecx
  80123a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80123d:	8a 12                	mov    (%edx),%dl
  80123f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801241:	8b 45 10             	mov    0x10(%ebp),%eax
  801244:	8d 50 ff             	lea    -0x1(%eax),%edx
  801247:	89 55 10             	mov    %edx,0x10(%ebp)
  80124a:	85 c0                	test   %eax,%eax
  80124c:	75 dd                	jne    80122b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80124e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801251:	c9                   	leave  
  801252:	c3                   	ret    

00801253 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801253:	55                   	push   %ebp
  801254:	89 e5                	mov    %esp,%ebp
  801256:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801259:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80125f:	8b 45 08             	mov    0x8(%ebp),%eax
  801262:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801265:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801268:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80126b:	73 50                	jae    8012bd <memmove+0x6a>
  80126d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801270:	8b 45 10             	mov    0x10(%ebp),%eax
  801273:	01 d0                	add    %edx,%eax
  801275:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801278:	76 43                	jbe    8012bd <memmove+0x6a>
		s += n;
  80127a:	8b 45 10             	mov    0x10(%ebp),%eax
  80127d:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801280:	8b 45 10             	mov    0x10(%ebp),%eax
  801283:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801286:	eb 10                	jmp    801298 <memmove+0x45>
			*--d = *--s;
  801288:	ff 4d f8             	decl   -0x8(%ebp)
  80128b:	ff 4d fc             	decl   -0x4(%ebp)
  80128e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801291:	8a 10                	mov    (%eax),%dl
  801293:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801296:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801298:	8b 45 10             	mov    0x10(%ebp),%eax
  80129b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80129e:	89 55 10             	mov    %edx,0x10(%ebp)
  8012a1:	85 c0                	test   %eax,%eax
  8012a3:	75 e3                	jne    801288 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012a5:	eb 23                	jmp    8012ca <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012aa:	8d 50 01             	lea    0x1(%eax),%edx
  8012ad:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012b0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012b6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012b9:	8a 12                	mov    (%edx),%dl
  8012bb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012c3:	89 55 10             	mov    %edx,0x10(%ebp)
  8012c6:	85 c0                	test   %eax,%eax
  8012c8:	75 dd                	jne    8012a7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012ca:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012cd:	c9                   	leave  
  8012ce:	c3                   	ret    

008012cf <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012cf:	55                   	push   %ebp
  8012d0:	89 e5                	mov    %esp,%ebp
  8012d2:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012de:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012e1:	eb 2a                	jmp    80130d <memcmp+0x3e>
		if (*s1 != *s2)
  8012e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e6:	8a 10                	mov    (%eax),%dl
  8012e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012eb:	8a 00                	mov    (%eax),%al
  8012ed:	38 c2                	cmp    %al,%dl
  8012ef:	74 16                	je     801307 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f4:	8a 00                	mov    (%eax),%al
  8012f6:	0f b6 d0             	movzbl %al,%edx
  8012f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012fc:	8a 00                	mov    (%eax),%al
  8012fe:	0f b6 c0             	movzbl %al,%eax
  801301:	29 c2                	sub    %eax,%edx
  801303:	89 d0                	mov    %edx,%eax
  801305:	eb 18                	jmp    80131f <memcmp+0x50>
		s1++, s2++;
  801307:	ff 45 fc             	incl   -0x4(%ebp)
  80130a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80130d:	8b 45 10             	mov    0x10(%ebp),%eax
  801310:	8d 50 ff             	lea    -0x1(%eax),%edx
  801313:	89 55 10             	mov    %edx,0x10(%ebp)
  801316:	85 c0                	test   %eax,%eax
  801318:	75 c9                	jne    8012e3 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80131a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80131f:	c9                   	leave  
  801320:	c3                   	ret    

00801321 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801321:	55                   	push   %ebp
  801322:	89 e5                	mov    %esp,%ebp
  801324:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801327:	8b 55 08             	mov    0x8(%ebp),%edx
  80132a:	8b 45 10             	mov    0x10(%ebp),%eax
  80132d:	01 d0                	add    %edx,%eax
  80132f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801332:	eb 15                	jmp    801349 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	8a 00                	mov    (%eax),%al
  801339:	0f b6 d0             	movzbl %al,%edx
  80133c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133f:	0f b6 c0             	movzbl %al,%eax
  801342:	39 c2                	cmp    %eax,%edx
  801344:	74 0d                	je     801353 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801346:	ff 45 08             	incl   0x8(%ebp)
  801349:	8b 45 08             	mov    0x8(%ebp),%eax
  80134c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80134f:	72 e3                	jb     801334 <memfind+0x13>
  801351:	eb 01                	jmp    801354 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801353:	90                   	nop
	return (void *) s;
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801357:	c9                   	leave  
  801358:	c3                   	ret    

00801359 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801359:	55                   	push   %ebp
  80135a:	89 e5                	mov    %esp,%ebp
  80135c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80135f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801366:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80136d:	eb 03                	jmp    801372 <strtol+0x19>
		s++;
  80136f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	8a 00                	mov    (%eax),%al
  801377:	3c 20                	cmp    $0x20,%al
  801379:	74 f4                	je     80136f <strtol+0x16>
  80137b:	8b 45 08             	mov    0x8(%ebp),%eax
  80137e:	8a 00                	mov    (%eax),%al
  801380:	3c 09                	cmp    $0x9,%al
  801382:	74 eb                	je     80136f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801384:	8b 45 08             	mov    0x8(%ebp),%eax
  801387:	8a 00                	mov    (%eax),%al
  801389:	3c 2b                	cmp    $0x2b,%al
  80138b:	75 05                	jne    801392 <strtol+0x39>
		s++;
  80138d:	ff 45 08             	incl   0x8(%ebp)
  801390:	eb 13                	jmp    8013a5 <strtol+0x4c>
	else if (*s == '-')
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	8a 00                	mov    (%eax),%al
  801397:	3c 2d                	cmp    $0x2d,%al
  801399:	75 0a                	jne    8013a5 <strtol+0x4c>
		s++, neg = 1;
  80139b:	ff 45 08             	incl   0x8(%ebp)
  80139e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013a5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a9:	74 06                	je     8013b1 <strtol+0x58>
  8013ab:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013af:	75 20                	jne    8013d1 <strtol+0x78>
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	8a 00                	mov    (%eax),%al
  8013b6:	3c 30                	cmp    $0x30,%al
  8013b8:	75 17                	jne    8013d1 <strtol+0x78>
  8013ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bd:	40                   	inc    %eax
  8013be:	8a 00                	mov    (%eax),%al
  8013c0:	3c 78                	cmp    $0x78,%al
  8013c2:	75 0d                	jne    8013d1 <strtol+0x78>
		s += 2, base = 16;
  8013c4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013c8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013cf:	eb 28                	jmp    8013f9 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d5:	75 15                	jne    8013ec <strtol+0x93>
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013da:	8a 00                	mov    (%eax),%al
  8013dc:	3c 30                	cmp    $0x30,%al
  8013de:	75 0c                	jne    8013ec <strtol+0x93>
		s++, base = 8;
  8013e0:	ff 45 08             	incl   0x8(%ebp)
  8013e3:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013ea:	eb 0d                	jmp    8013f9 <strtol+0xa0>
	else if (base == 0)
  8013ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f0:	75 07                	jne    8013f9 <strtol+0xa0>
		base = 10;
  8013f2:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	8a 00                	mov    (%eax),%al
  8013fe:	3c 2f                	cmp    $0x2f,%al
  801400:	7e 19                	jle    80141b <strtol+0xc2>
  801402:	8b 45 08             	mov    0x8(%ebp),%eax
  801405:	8a 00                	mov    (%eax),%al
  801407:	3c 39                	cmp    $0x39,%al
  801409:	7f 10                	jg     80141b <strtol+0xc2>
			dig = *s - '0';
  80140b:	8b 45 08             	mov    0x8(%ebp),%eax
  80140e:	8a 00                	mov    (%eax),%al
  801410:	0f be c0             	movsbl %al,%eax
  801413:	83 e8 30             	sub    $0x30,%eax
  801416:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801419:	eb 42                	jmp    80145d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80141b:	8b 45 08             	mov    0x8(%ebp),%eax
  80141e:	8a 00                	mov    (%eax),%al
  801420:	3c 60                	cmp    $0x60,%al
  801422:	7e 19                	jle    80143d <strtol+0xe4>
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	8a 00                	mov    (%eax),%al
  801429:	3c 7a                	cmp    $0x7a,%al
  80142b:	7f 10                	jg     80143d <strtol+0xe4>
			dig = *s - 'a' + 10;
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
  801430:	8a 00                	mov    (%eax),%al
  801432:	0f be c0             	movsbl %al,%eax
  801435:	83 e8 57             	sub    $0x57,%eax
  801438:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80143b:	eb 20                	jmp    80145d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	8a 00                	mov    (%eax),%al
  801442:	3c 40                	cmp    $0x40,%al
  801444:	7e 39                	jle    80147f <strtol+0x126>
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	8a 00                	mov    (%eax),%al
  80144b:	3c 5a                	cmp    $0x5a,%al
  80144d:	7f 30                	jg     80147f <strtol+0x126>
			dig = *s - 'A' + 10;
  80144f:	8b 45 08             	mov    0x8(%ebp),%eax
  801452:	8a 00                	mov    (%eax),%al
  801454:	0f be c0             	movsbl %al,%eax
  801457:	83 e8 37             	sub    $0x37,%eax
  80145a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80145d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801460:	3b 45 10             	cmp    0x10(%ebp),%eax
  801463:	7d 19                	jge    80147e <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801465:	ff 45 08             	incl   0x8(%ebp)
  801468:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80146b:	0f af 45 10          	imul   0x10(%ebp),%eax
  80146f:	89 c2                	mov    %eax,%edx
  801471:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801474:	01 d0                	add    %edx,%eax
  801476:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801479:	e9 7b ff ff ff       	jmp    8013f9 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80147e:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80147f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801483:	74 08                	je     80148d <strtol+0x134>
		*endptr = (char *) s;
  801485:	8b 45 0c             	mov    0xc(%ebp),%eax
  801488:	8b 55 08             	mov    0x8(%ebp),%edx
  80148b:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80148d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801491:	74 07                	je     80149a <strtol+0x141>
  801493:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801496:	f7 d8                	neg    %eax
  801498:	eb 03                	jmp    80149d <strtol+0x144>
  80149a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80149d:	c9                   	leave  
  80149e:	c3                   	ret    

0080149f <ltostr>:

void
ltostr(long value, char *str)
{
  80149f:	55                   	push   %ebp
  8014a0:	89 e5                	mov    %esp,%ebp
  8014a2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014ac:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014b3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014b7:	79 13                	jns    8014cc <ltostr+0x2d>
	{
		neg = 1;
  8014b9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014c6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014c9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cf:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014d4:	99                   	cltd   
  8014d5:	f7 f9                	idiv   %ecx
  8014d7:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014dd:	8d 50 01             	lea    0x1(%eax),%edx
  8014e0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014e3:	89 c2                	mov    %eax,%edx
  8014e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e8:	01 d0                	add    %edx,%eax
  8014ea:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014ed:	83 c2 30             	add    $0x30,%edx
  8014f0:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014f2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014f5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014fa:	f7 e9                	imul   %ecx
  8014fc:	c1 fa 02             	sar    $0x2,%edx
  8014ff:	89 c8                	mov    %ecx,%eax
  801501:	c1 f8 1f             	sar    $0x1f,%eax
  801504:	29 c2                	sub    %eax,%edx
  801506:	89 d0                	mov    %edx,%eax
  801508:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80150b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80150e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801513:	f7 e9                	imul   %ecx
  801515:	c1 fa 02             	sar    $0x2,%edx
  801518:	89 c8                	mov    %ecx,%eax
  80151a:	c1 f8 1f             	sar    $0x1f,%eax
  80151d:	29 c2                	sub    %eax,%edx
  80151f:	89 d0                	mov    %edx,%eax
  801521:	c1 e0 02             	shl    $0x2,%eax
  801524:	01 d0                	add    %edx,%eax
  801526:	01 c0                	add    %eax,%eax
  801528:	29 c1                	sub    %eax,%ecx
  80152a:	89 ca                	mov    %ecx,%edx
  80152c:	85 d2                	test   %edx,%edx
  80152e:	75 9c                	jne    8014cc <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801530:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801537:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153a:	48                   	dec    %eax
  80153b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80153e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801542:	74 3d                	je     801581 <ltostr+0xe2>
		start = 1 ;
  801544:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80154b:	eb 34                	jmp    801581 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80154d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801550:	8b 45 0c             	mov    0xc(%ebp),%eax
  801553:	01 d0                	add    %edx,%eax
  801555:	8a 00                	mov    (%eax),%al
  801557:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80155a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80155d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801560:	01 c2                	add    %eax,%edx
  801562:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801565:	8b 45 0c             	mov    0xc(%ebp),%eax
  801568:	01 c8                	add    %ecx,%eax
  80156a:	8a 00                	mov    (%eax),%al
  80156c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80156e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801571:	8b 45 0c             	mov    0xc(%ebp),%eax
  801574:	01 c2                	add    %eax,%edx
  801576:	8a 45 eb             	mov    -0x15(%ebp),%al
  801579:	88 02                	mov    %al,(%edx)
		start++ ;
  80157b:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80157e:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801581:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801584:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801587:	7c c4                	jl     80154d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801589:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80158c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158f:	01 d0                	add    %edx,%eax
  801591:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801594:	90                   	nop
  801595:	c9                   	leave  
  801596:	c3                   	ret    

00801597 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801597:	55                   	push   %ebp
  801598:	89 e5                	mov    %esp,%ebp
  80159a:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80159d:	ff 75 08             	pushl  0x8(%ebp)
  8015a0:	e8 54 fa ff ff       	call   800ff9 <strlen>
  8015a5:	83 c4 04             	add    $0x4,%esp
  8015a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015ab:	ff 75 0c             	pushl  0xc(%ebp)
  8015ae:	e8 46 fa ff ff       	call   800ff9 <strlen>
  8015b3:	83 c4 04             	add    $0x4,%esp
  8015b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015c7:	eb 17                	jmp    8015e0 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015cf:	01 c2                	add    %eax,%edx
  8015d1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d7:	01 c8                	add    %ecx,%eax
  8015d9:	8a 00                	mov    (%eax),%al
  8015db:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015dd:	ff 45 fc             	incl   -0x4(%ebp)
  8015e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015e6:	7c e1                	jl     8015c9 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015e8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015ef:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015f6:	eb 1f                	jmp    801617 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015fb:	8d 50 01             	lea    0x1(%eax),%edx
  8015fe:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801601:	89 c2                	mov    %eax,%edx
  801603:	8b 45 10             	mov    0x10(%ebp),%eax
  801606:	01 c2                	add    %eax,%edx
  801608:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80160b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80160e:	01 c8                	add    %ecx,%eax
  801610:	8a 00                	mov    (%eax),%al
  801612:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801614:	ff 45 f8             	incl   -0x8(%ebp)
  801617:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80161a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80161d:	7c d9                	jl     8015f8 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80161f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801622:	8b 45 10             	mov    0x10(%ebp),%eax
  801625:	01 d0                	add    %edx,%eax
  801627:	c6 00 00             	movb   $0x0,(%eax)
}
  80162a:	90                   	nop
  80162b:	c9                   	leave  
  80162c:	c3                   	ret    

0080162d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80162d:	55                   	push   %ebp
  80162e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801630:	8b 45 14             	mov    0x14(%ebp),%eax
  801633:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801639:	8b 45 14             	mov    0x14(%ebp),%eax
  80163c:	8b 00                	mov    (%eax),%eax
  80163e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801645:	8b 45 10             	mov    0x10(%ebp),%eax
  801648:	01 d0                	add    %edx,%eax
  80164a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801650:	eb 0c                	jmp    80165e <strsplit+0x31>
			*string++ = 0;
  801652:	8b 45 08             	mov    0x8(%ebp),%eax
  801655:	8d 50 01             	lea    0x1(%eax),%edx
  801658:	89 55 08             	mov    %edx,0x8(%ebp)
  80165b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	8a 00                	mov    (%eax),%al
  801663:	84 c0                	test   %al,%al
  801665:	74 18                	je     80167f <strsplit+0x52>
  801667:	8b 45 08             	mov    0x8(%ebp),%eax
  80166a:	8a 00                	mov    (%eax),%al
  80166c:	0f be c0             	movsbl %al,%eax
  80166f:	50                   	push   %eax
  801670:	ff 75 0c             	pushl  0xc(%ebp)
  801673:	e8 13 fb ff ff       	call   80118b <strchr>
  801678:	83 c4 08             	add    $0x8,%esp
  80167b:	85 c0                	test   %eax,%eax
  80167d:	75 d3                	jne    801652 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80167f:	8b 45 08             	mov    0x8(%ebp),%eax
  801682:	8a 00                	mov    (%eax),%al
  801684:	84 c0                	test   %al,%al
  801686:	74 5a                	je     8016e2 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801688:	8b 45 14             	mov    0x14(%ebp),%eax
  80168b:	8b 00                	mov    (%eax),%eax
  80168d:	83 f8 0f             	cmp    $0xf,%eax
  801690:	75 07                	jne    801699 <strsplit+0x6c>
		{
			return 0;
  801692:	b8 00 00 00 00       	mov    $0x0,%eax
  801697:	eb 66                	jmp    8016ff <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801699:	8b 45 14             	mov    0x14(%ebp),%eax
  80169c:	8b 00                	mov    (%eax),%eax
  80169e:	8d 48 01             	lea    0x1(%eax),%ecx
  8016a1:	8b 55 14             	mov    0x14(%ebp),%edx
  8016a4:	89 0a                	mov    %ecx,(%edx)
  8016a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b0:	01 c2                	add    %eax,%edx
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016b7:	eb 03                	jmp    8016bc <strsplit+0x8f>
			string++;
  8016b9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bf:	8a 00                	mov    (%eax),%al
  8016c1:	84 c0                	test   %al,%al
  8016c3:	74 8b                	je     801650 <strsplit+0x23>
  8016c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c8:	8a 00                	mov    (%eax),%al
  8016ca:	0f be c0             	movsbl %al,%eax
  8016cd:	50                   	push   %eax
  8016ce:	ff 75 0c             	pushl  0xc(%ebp)
  8016d1:	e8 b5 fa ff ff       	call   80118b <strchr>
  8016d6:	83 c4 08             	add    $0x8,%esp
  8016d9:	85 c0                	test   %eax,%eax
  8016db:	74 dc                	je     8016b9 <strsplit+0x8c>
			string++;
	}
  8016dd:	e9 6e ff ff ff       	jmp    801650 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016e2:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8016e6:	8b 00                	mov    (%eax),%eax
  8016e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f2:	01 d0                	add    %edx,%eax
  8016f4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016fa:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    

00801701 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
  801704:	83 ec 18             	sub    $0x18,%esp
  801707:	8b 45 10             	mov    0x10(%ebp),%eax
  80170a:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80170d:	83 ec 04             	sub    $0x4,%esp
  801710:	68 70 29 80 00       	push   $0x802970
  801715:	6a 17                	push   $0x17
  801717:	68 8f 29 80 00       	push   $0x80298f
  80171c:	e8 a2 ef ff ff       	call   8006c3 <_panic>

00801721 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801721:	55                   	push   %ebp
  801722:	89 e5                	mov    %esp,%ebp
  801724:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801727:	83 ec 04             	sub    $0x4,%esp
  80172a:	68 9b 29 80 00       	push   $0x80299b
  80172f:	6a 2f                	push   $0x2f
  801731:	68 8f 29 80 00       	push   $0x80298f
  801736:	e8 88 ef ff ff       	call   8006c3 <_panic>

0080173b <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
  80173e:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801741:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801748:	8b 55 08             	mov    0x8(%ebp),%edx
  80174b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80174e:	01 d0                	add    %edx,%eax
  801750:	48                   	dec    %eax
  801751:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801754:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801757:	ba 00 00 00 00       	mov    $0x0,%edx
  80175c:	f7 75 ec             	divl   -0x14(%ebp)
  80175f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801762:	29 d0                	sub    %edx,%eax
  801764:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801767:	8b 45 08             	mov    0x8(%ebp),%eax
  80176a:	c1 e8 0c             	shr    $0xc,%eax
  80176d:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801770:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801777:	e9 c8 00 00 00       	jmp    801844 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  80177c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801783:	eb 27                	jmp    8017ac <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801785:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801788:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80178b:	01 c2                	add    %eax,%edx
  80178d:	89 d0                	mov    %edx,%eax
  80178f:	01 c0                	add    %eax,%eax
  801791:	01 d0                	add    %edx,%eax
  801793:	c1 e0 02             	shl    $0x2,%eax
  801796:	05 48 30 80 00       	add    $0x803048,%eax
  80179b:	8b 00                	mov    (%eax),%eax
  80179d:	85 c0                	test   %eax,%eax
  80179f:	74 08                	je     8017a9 <malloc+0x6e>
            	i += j;
  8017a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017a4:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8017a7:	eb 0b                	jmp    8017b4 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8017a9:	ff 45 f0             	incl   -0x10(%ebp)
  8017ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017af:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8017b2:	72 d1                	jb     801785 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8017b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017b7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8017ba:	0f 85 81 00 00 00    	jne    801841 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8017c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017c3:	05 00 00 08 00       	add    $0x80000,%eax
  8017c8:	c1 e0 0c             	shl    $0xc,%eax
  8017cb:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8017ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8017d5:	eb 1f                	jmp    8017f6 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8017d7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017dd:	01 c2                	add    %eax,%edx
  8017df:	89 d0                	mov    %edx,%eax
  8017e1:	01 c0                	add    %eax,%eax
  8017e3:	01 d0                	add    %edx,%eax
  8017e5:	c1 e0 02             	shl    $0x2,%eax
  8017e8:	05 48 30 80 00       	add    $0x803048,%eax
  8017ed:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8017f3:	ff 45 f0             	incl   -0x10(%ebp)
  8017f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017f9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8017fc:	72 d9                	jb     8017d7 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  8017fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801801:	89 d0                	mov    %edx,%eax
  801803:	01 c0                	add    %eax,%eax
  801805:	01 d0                	add    %edx,%eax
  801807:	c1 e0 02             	shl    $0x2,%eax
  80180a:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801810:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801813:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801815:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801818:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  80181b:	89 c8                	mov    %ecx,%eax
  80181d:	01 c0                	add    %eax,%eax
  80181f:	01 c8                	add    %ecx,%eax
  801821:	c1 e0 02             	shl    $0x2,%eax
  801824:	05 44 30 80 00       	add    $0x803044,%eax
  801829:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  80182b:	83 ec 08             	sub    $0x8,%esp
  80182e:	ff 75 08             	pushl  0x8(%ebp)
  801831:	ff 75 e0             	pushl  -0x20(%ebp)
  801834:	e8 2b 03 00 00       	call   801b64 <sys_allocateMem>
  801839:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  80183c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80183f:	eb 19                	jmp    80185a <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801841:	ff 45 f4             	incl   -0xc(%ebp)
  801844:	a1 04 30 80 00       	mov    0x803004,%eax
  801849:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80184c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80184f:	0f 83 27 ff ff ff    	jae    80177c <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801855:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80185a:	c9                   	leave  
  80185b:	c3                   	ret    

0080185c <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80185c:	55                   	push   %ebp
  80185d:	89 e5                	mov    %esp,%ebp
  80185f:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801862:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801866:	0f 84 e5 00 00 00    	je     801951 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  80186c:	8b 45 08             	mov    0x8(%ebp),%eax
  80186f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801872:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801875:	05 00 00 00 80       	add    $0x80000000,%eax
  80187a:	c1 e8 0c             	shr    $0xc,%eax
  80187d:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801880:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801883:	89 d0                	mov    %edx,%eax
  801885:	01 c0                	add    %eax,%eax
  801887:	01 d0                	add    %edx,%eax
  801889:	c1 e0 02             	shl    $0x2,%eax
  80188c:	05 40 30 80 00       	add    $0x803040,%eax
  801891:	8b 00                	mov    (%eax),%eax
  801893:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801896:	0f 85 b8 00 00 00    	jne    801954 <free+0xf8>
  80189c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80189f:	89 d0                	mov    %edx,%eax
  8018a1:	01 c0                	add    %eax,%eax
  8018a3:	01 d0                	add    %edx,%eax
  8018a5:	c1 e0 02             	shl    $0x2,%eax
  8018a8:	05 48 30 80 00       	add    $0x803048,%eax
  8018ad:	8b 00                	mov    (%eax),%eax
  8018af:	85 c0                	test   %eax,%eax
  8018b1:	0f 84 9d 00 00 00    	je     801954 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8018b7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018ba:	89 d0                	mov    %edx,%eax
  8018bc:	01 c0                	add    %eax,%eax
  8018be:	01 d0                	add    %edx,%eax
  8018c0:	c1 e0 02             	shl    $0x2,%eax
  8018c3:	05 44 30 80 00       	add    $0x803044,%eax
  8018c8:	8b 00                	mov    (%eax),%eax
  8018ca:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  8018cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018d0:	c1 e0 0c             	shl    $0xc,%eax
  8018d3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  8018d6:	83 ec 08             	sub    $0x8,%esp
  8018d9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8018dc:	ff 75 f0             	pushl  -0x10(%ebp)
  8018df:	e8 64 02 00 00       	call   801b48 <sys_freeMem>
  8018e4:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8018e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8018ee:	eb 57                	jmp    801947 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8018f0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018f6:	01 c2                	add    %eax,%edx
  8018f8:	89 d0                	mov    %edx,%eax
  8018fa:	01 c0                	add    %eax,%eax
  8018fc:	01 d0                	add    %edx,%eax
  8018fe:	c1 e0 02             	shl    $0x2,%eax
  801901:	05 48 30 80 00       	add    $0x803048,%eax
  801906:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  80190c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80190f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801912:	01 c2                	add    %eax,%edx
  801914:	89 d0                	mov    %edx,%eax
  801916:	01 c0                	add    %eax,%eax
  801918:	01 d0                	add    %edx,%eax
  80191a:	c1 e0 02             	shl    $0x2,%eax
  80191d:	05 40 30 80 00       	add    $0x803040,%eax
  801922:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801928:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80192b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80192e:	01 c2                	add    %eax,%edx
  801930:	89 d0                	mov    %edx,%eax
  801932:	01 c0                	add    %eax,%eax
  801934:	01 d0                	add    %edx,%eax
  801936:	c1 e0 02             	shl    $0x2,%eax
  801939:	05 44 30 80 00       	add    $0x803044,%eax
  80193e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801944:	ff 45 f4             	incl   -0xc(%ebp)
  801947:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80194a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80194d:	7c a1                	jl     8018f0 <free+0x94>
  80194f:	eb 04                	jmp    801955 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801951:	90                   	nop
  801952:	eb 01                	jmp    801955 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801954:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801955:	c9                   	leave  
  801956:	c3                   	ret    

00801957 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801957:	55                   	push   %ebp
  801958:	89 e5                	mov    %esp,%ebp
  80195a:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  80195d:	83 ec 04             	sub    $0x4,%esp
  801960:	68 b8 29 80 00       	push   $0x8029b8
  801965:	68 ae 00 00 00       	push   $0xae
  80196a:	68 8f 29 80 00       	push   $0x80298f
  80196f:	e8 4f ed ff ff       	call   8006c3 <_panic>

00801974 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801974:	55                   	push   %ebp
  801975:	89 e5                	mov    %esp,%ebp
  801977:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  80197a:	83 ec 04             	sub    $0x4,%esp
  80197d:	68 d8 29 80 00       	push   $0x8029d8
  801982:	68 ca 00 00 00       	push   $0xca
  801987:	68 8f 29 80 00       	push   $0x80298f
  80198c:	e8 32 ed ff ff       	call   8006c3 <_panic>

00801991 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801991:	55                   	push   %ebp
  801992:	89 e5                	mov    %esp,%ebp
  801994:	57                   	push   %edi
  801995:	56                   	push   %esi
  801996:	53                   	push   %ebx
  801997:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80199a:	8b 45 08             	mov    0x8(%ebp),%eax
  80199d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019a0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019a3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019a6:	8b 7d 18             	mov    0x18(%ebp),%edi
  8019a9:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8019ac:	cd 30                	int    $0x30
  8019ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8019b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8019b4:	83 c4 10             	add    $0x10,%esp
  8019b7:	5b                   	pop    %ebx
  8019b8:	5e                   	pop    %esi
  8019b9:	5f                   	pop    %edi
  8019ba:	5d                   	pop    %ebp
  8019bb:	c3                   	ret    

008019bc <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8019bc:	55                   	push   %ebp
  8019bd:	89 e5                	mov    %esp,%ebp
  8019bf:	83 ec 04             	sub    $0x4,%esp
  8019c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8019c5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8019c8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8019cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 00                	push   $0x0
  8019d3:	52                   	push   %edx
  8019d4:	ff 75 0c             	pushl  0xc(%ebp)
  8019d7:	50                   	push   %eax
  8019d8:	6a 00                	push   $0x0
  8019da:	e8 b2 ff ff ff       	call   801991 <syscall>
  8019df:	83 c4 18             	add    $0x18,%esp
}
  8019e2:	90                   	nop
  8019e3:	c9                   	leave  
  8019e4:	c3                   	ret    

008019e5 <sys_cgetc>:

int
sys_cgetc(void)
{
  8019e5:	55                   	push   %ebp
  8019e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 01                	push   $0x1
  8019f4:	e8 98 ff ff ff       	call   801991 <syscall>
  8019f9:	83 c4 18             	add    $0x18,%esp
}
  8019fc:	c9                   	leave  
  8019fd:	c3                   	ret    

008019fe <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8019fe:	55                   	push   %ebp
  8019ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a01:	8b 45 08             	mov    0x8(%ebp),%eax
  801a04:	6a 00                	push   $0x0
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	6a 00                	push   $0x0
  801a0c:	50                   	push   %eax
  801a0d:	6a 05                	push   $0x5
  801a0f:	e8 7d ff ff ff       	call   801991 <syscall>
  801a14:	83 c4 18             	add    $0x18,%esp
}
  801a17:	c9                   	leave  
  801a18:	c3                   	ret    

00801a19 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a19:	55                   	push   %ebp
  801a1a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 02                	push   $0x2
  801a28:	e8 64 ff ff ff       	call   801991 <syscall>
  801a2d:	83 c4 18             	add    $0x18,%esp
}
  801a30:	c9                   	leave  
  801a31:	c3                   	ret    

00801a32 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801a32:	55                   	push   %ebp
  801a33:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801a35:	6a 00                	push   $0x0
  801a37:	6a 00                	push   $0x0
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 03                	push   $0x3
  801a41:	e8 4b ff ff ff       	call   801991 <syscall>
  801a46:	83 c4 18             	add    $0x18,%esp
}
  801a49:	c9                   	leave  
  801a4a:	c3                   	ret    

00801a4b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801a4b:	55                   	push   %ebp
  801a4c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 04                	push   $0x4
  801a5a:	e8 32 ff ff ff       	call   801991 <syscall>
  801a5f:	83 c4 18             	add    $0x18,%esp
}
  801a62:	c9                   	leave  
  801a63:	c3                   	ret    

00801a64 <sys_env_exit>:


void sys_env_exit(void)
{
  801a64:	55                   	push   %ebp
  801a65:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 06                	push   $0x6
  801a73:	e8 19 ff ff ff       	call   801991 <syscall>
  801a78:	83 c4 18             	add    $0x18,%esp
}
  801a7b:	90                   	nop
  801a7c:	c9                   	leave  
  801a7d:	c3                   	ret    

00801a7e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801a7e:	55                   	push   %ebp
  801a7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801a81:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a84:	8b 45 08             	mov    0x8(%ebp),%eax
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	52                   	push   %edx
  801a8e:	50                   	push   %eax
  801a8f:	6a 07                	push   $0x7
  801a91:	e8 fb fe ff ff       	call   801991 <syscall>
  801a96:	83 c4 18             	add    $0x18,%esp
}
  801a99:	c9                   	leave  
  801a9a:	c3                   	ret    

00801a9b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801a9b:	55                   	push   %ebp
  801a9c:	89 e5                	mov    %esp,%ebp
  801a9e:	56                   	push   %esi
  801a9f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801aa0:	8b 75 18             	mov    0x18(%ebp),%esi
  801aa3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801aa6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801aa9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aac:	8b 45 08             	mov    0x8(%ebp),%eax
  801aaf:	56                   	push   %esi
  801ab0:	53                   	push   %ebx
  801ab1:	51                   	push   %ecx
  801ab2:	52                   	push   %edx
  801ab3:	50                   	push   %eax
  801ab4:	6a 08                	push   $0x8
  801ab6:	e8 d6 fe ff ff       	call   801991 <syscall>
  801abb:	83 c4 18             	add    $0x18,%esp
}
  801abe:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ac1:	5b                   	pop    %ebx
  801ac2:	5e                   	pop    %esi
  801ac3:	5d                   	pop    %ebp
  801ac4:	c3                   	ret    

00801ac5 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ac5:	55                   	push   %ebp
  801ac6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801ac8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801acb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	52                   	push   %edx
  801ad5:	50                   	push   %eax
  801ad6:	6a 09                	push   $0x9
  801ad8:	e8 b4 fe ff ff       	call   801991 <syscall>
  801add:	83 c4 18             	add    $0x18,%esp
}
  801ae0:	c9                   	leave  
  801ae1:	c3                   	ret    

00801ae2 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801ae2:	55                   	push   %ebp
  801ae3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	ff 75 0c             	pushl  0xc(%ebp)
  801aee:	ff 75 08             	pushl  0x8(%ebp)
  801af1:	6a 0a                	push   $0xa
  801af3:	e8 99 fe ff ff       	call   801991 <syscall>
  801af8:	83 c4 18             	add    $0x18,%esp
}
  801afb:	c9                   	leave  
  801afc:	c3                   	ret    

00801afd <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801afd:	55                   	push   %ebp
  801afe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	6a 00                	push   $0x0
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 0b                	push   $0xb
  801b0c:	e8 80 fe ff ff       	call   801991 <syscall>
  801b11:	83 c4 18             	add    $0x18,%esp
}
  801b14:	c9                   	leave  
  801b15:	c3                   	ret    

00801b16 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b16:	55                   	push   %ebp
  801b17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 0c                	push   $0xc
  801b25:	e8 67 fe ff ff       	call   801991 <syscall>
  801b2a:	83 c4 18             	add    $0x18,%esp
}
  801b2d:	c9                   	leave  
  801b2e:	c3                   	ret    

00801b2f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b2f:	55                   	push   %ebp
  801b30:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 00                	push   $0x0
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 0d                	push   $0xd
  801b3e:	e8 4e fe ff ff       	call   801991 <syscall>
  801b43:	83 c4 18             	add    $0x18,%esp
}
  801b46:	c9                   	leave  
  801b47:	c3                   	ret    

00801b48 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801b48:	55                   	push   %ebp
  801b49:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	6a 00                	push   $0x0
  801b51:	ff 75 0c             	pushl  0xc(%ebp)
  801b54:	ff 75 08             	pushl  0x8(%ebp)
  801b57:	6a 11                	push   $0x11
  801b59:	e8 33 fe ff ff       	call   801991 <syscall>
  801b5e:	83 c4 18             	add    $0x18,%esp
	return;
  801b61:	90                   	nop
}
  801b62:	c9                   	leave  
  801b63:	c3                   	ret    

00801b64 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801b64:	55                   	push   %ebp
  801b65:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	ff 75 0c             	pushl  0xc(%ebp)
  801b70:	ff 75 08             	pushl  0x8(%ebp)
  801b73:	6a 12                	push   $0x12
  801b75:	e8 17 fe ff ff       	call   801991 <syscall>
  801b7a:	83 c4 18             	add    $0x18,%esp
	return ;
  801b7d:	90                   	nop
}
  801b7e:	c9                   	leave  
  801b7f:	c3                   	ret    

00801b80 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801b80:	55                   	push   %ebp
  801b81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 00                	push   $0x0
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 0e                	push   $0xe
  801b8f:	e8 fd fd ff ff       	call   801991 <syscall>
  801b94:	83 c4 18             	add    $0x18,%esp
}
  801b97:	c9                   	leave  
  801b98:	c3                   	ret    

00801b99 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801b99:	55                   	push   %ebp
  801b9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	ff 75 08             	pushl  0x8(%ebp)
  801ba7:	6a 0f                	push   $0xf
  801ba9:	e8 e3 fd ff ff       	call   801991 <syscall>
  801bae:	83 c4 18             	add    $0x18,%esp
}
  801bb1:	c9                   	leave  
  801bb2:	c3                   	ret    

00801bb3 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801bb3:	55                   	push   %ebp
  801bb4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 00                	push   $0x0
  801bbe:	6a 00                	push   $0x0
  801bc0:	6a 10                	push   $0x10
  801bc2:	e8 ca fd ff ff       	call   801991 <syscall>
  801bc7:	83 c4 18             	add    $0x18,%esp
}
  801bca:	90                   	nop
  801bcb:	c9                   	leave  
  801bcc:	c3                   	ret    

00801bcd <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801bcd:	55                   	push   %ebp
  801bce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 14                	push   $0x14
  801bdc:	e8 b0 fd ff ff       	call   801991 <syscall>
  801be1:	83 c4 18             	add    $0x18,%esp
}
  801be4:	90                   	nop
  801be5:	c9                   	leave  
  801be6:	c3                   	ret    

00801be7 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801be7:	55                   	push   %ebp
  801be8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	6a 00                	push   $0x0
  801bf0:	6a 00                	push   $0x0
  801bf2:	6a 00                	push   $0x0
  801bf4:	6a 15                	push   $0x15
  801bf6:	e8 96 fd ff ff       	call   801991 <syscall>
  801bfb:	83 c4 18             	add    $0x18,%esp
}
  801bfe:	90                   	nop
  801bff:	c9                   	leave  
  801c00:	c3                   	ret    

00801c01 <sys_cputc>:


void
sys_cputc(const char c)
{
  801c01:	55                   	push   %ebp
  801c02:	89 e5                	mov    %esp,%ebp
  801c04:	83 ec 04             	sub    $0x4,%esp
  801c07:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801c0d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	50                   	push   %eax
  801c1a:	6a 16                	push   $0x16
  801c1c:	e8 70 fd ff ff       	call   801991 <syscall>
  801c21:	83 c4 18             	add    $0x18,%esp
}
  801c24:	90                   	nop
  801c25:	c9                   	leave  
  801c26:	c3                   	ret    

00801c27 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c27:	55                   	push   %ebp
  801c28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801c2a:	6a 00                	push   $0x0
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 17                	push   $0x17
  801c36:	e8 56 fd ff ff       	call   801991 <syscall>
  801c3b:	83 c4 18             	add    $0x18,%esp
}
  801c3e:	90                   	nop
  801c3f:	c9                   	leave  
  801c40:	c3                   	ret    

00801c41 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801c41:	55                   	push   %ebp
  801c42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801c44:	8b 45 08             	mov    0x8(%ebp),%eax
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	ff 75 0c             	pushl  0xc(%ebp)
  801c50:	50                   	push   %eax
  801c51:	6a 18                	push   $0x18
  801c53:	e8 39 fd ff ff       	call   801991 <syscall>
  801c58:	83 c4 18             	add    $0x18,%esp
}
  801c5b:	c9                   	leave  
  801c5c:	c3                   	ret    

00801c5d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801c5d:	55                   	push   %ebp
  801c5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c63:	8b 45 08             	mov    0x8(%ebp),%eax
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	52                   	push   %edx
  801c6d:	50                   	push   %eax
  801c6e:	6a 1b                	push   $0x1b
  801c70:	e8 1c fd ff ff       	call   801991 <syscall>
  801c75:	83 c4 18             	add    $0x18,%esp
}
  801c78:	c9                   	leave  
  801c79:	c3                   	ret    

00801c7a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c7a:	55                   	push   %ebp
  801c7b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c80:	8b 45 08             	mov    0x8(%ebp),%eax
  801c83:	6a 00                	push   $0x0
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	52                   	push   %edx
  801c8a:	50                   	push   %eax
  801c8b:	6a 19                	push   $0x19
  801c8d:	e8 ff fc ff ff       	call   801991 <syscall>
  801c92:	83 c4 18             	add    $0x18,%esp
}
  801c95:	90                   	nop
  801c96:	c9                   	leave  
  801c97:	c3                   	ret    

00801c98 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c98:	55                   	push   %ebp
  801c99:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca1:	6a 00                	push   $0x0
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	52                   	push   %edx
  801ca8:	50                   	push   %eax
  801ca9:	6a 1a                	push   $0x1a
  801cab:	e8 e1 fc ff ff       	call   801991 <syscall>
  801cb0:	83 c4 18             	add    $0x18,%esp
}
  801cb3:	90                   	nop
  801cb4:	c9                   	leave  
  801cb5:	c3                   	ret    

00801cb6 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801cb6:	55                   	push   %ebp
  801cb7:	89 e5                	mov    %esp,%ebp
  801cb9:	83 ec 04             	sub    $0x4,%esp
  801cbc:	8b 45 10             	mov    0x10(%ebp),%eax
  801cbf:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801cc2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801cc5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ccc:	6a 00                	push   $0x0
  801cce:	51                   	push   %ecx
  801ccf:	52                   	push   %edx
  801cd0:	ff 75 0c             	pushl  0xc(%ebp)
  801cd3:	50                   	push   %eax
  801cd4:	6a 1c                	push   $0x1c
  801cd6:	e8 b6 fc ff ff       	call   801991 <syscall>
  801cdb:	83 c4 18             	add    $0x18,%esp
}
  801cde:	c9                   	leave  
  801cdf:	c3                   	ret    

00801ce0 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801ce0:	55                   	push   %ebp
  801ce1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ce3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ce6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	52                   	push   %edx
  801cf0:	50                   	push   %eax
  801cf1:	6a 1d                	push   $0x1d
  801cf3:	e8 99 fc ff ff       	call   801991 <syscall>
  801cf8:	83 c4 18             	add    $0x18,%esp
}
  801cfb:	c9                   	leave  
  801cfc:	c3                   	ret    

00801cfd <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801cfd:	55                   	push   %ebp
  801cfe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d00:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d03:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d06:	8b 45 08             	mov    0x8(%ebp),%eax
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	51                   	push   %ecx
  801d0e:	52                   	push   %edx
  801d0f:	50                   	push   %eax
  801d10:	6a 1e                	push   $0x1e
  801d12:	e8 7a fc ff ff       	call   801991 <syscall>
  801d17:	83 c4 18             	add    $0x18,%esp
}
  801d1a:	c9                   	leave  
  801d1b:	c3                   	ret    

00801d1c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d1c:	55                   	push   %ebp
  801d1d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d22:	8b 45 08             	mov    0x8(%ebp),%eax
  801d25:	6a 00                	push   $0x0
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	52                   	push   %edx
  801d2c:	50                   	push   %eax
  801d2d:	6a 1f                	push   $0x1f
  801d2f:	e8 5d fc ff ff       	call   801991 <syscall>
  801d34:	83 c4 18             	add    $0x18,%esp
}
  801d37:	c9                   	leave  
  801d38:	c3                   	ret    

00801d39 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801d39:	55                   	push   %ebp
  801d3a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	6a 00                	push   $0x0
  801d44:	6a 00                	push   $0x0
  801d46:	6a 20                	push   $0x20
  801d48:	e8 44 fc ff ff       	call   801991 <syscall>
  801d4d:	83 c4 18             	add    $0x18,%esp
}
  801d50:	c9                   	leave  
  801d51:	c3                   	ret    

00801d52 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801d52:	55                   	push   %ebp
  801d53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801d55:	8b 45 08             	mov    0x8(%ebp),%eax
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	ff 75 10             	pushl  0x10(%ebp)
  801d5f:	ff 75 0c             	pushl  0xc(%ebp)
  801d62:	50                   	push   %eax
  801d63:	6a 21                	push   $0x21
  801d65:	e8 27 fc ff ff       	call   801991 <syscall>
  801d6a:	83 c4 18             	add    $0x18,%esp
}
  801d6d:	c9                   	leave  
  801d6e:	c3                   	ret    

00801d6f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801d6f:	55                   	push   %ebp
  801d70:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801d72:	8b 45 08             	mov    0x8(%ebp),%eax
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	50                   	push   %eax
  801d7e:	6a 22                	push   $0x22
  801d80:	e8 0c fc ff ff       	call   801991 <syscall>
  801d85:	83 c4 18             	add    $0x18,%esp
}
  801d88:	90                   	nop
  801d89:	c9                   	leave  
  801d8a:	c3                   	ret    

00801d8b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801d8b:	55                   	push   %ebp
  801d8c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	6a 00                	push   $0x0
  801d99:	50                   	push   %eax
  801d9a:	6a 23                	push   $0x23
  801d9c:	e8 f0 fb ff ff       	call   801991 <syscall>
  801da1:	83 c4 18             	add    $0x18,%esp
}
  801da4:	90                   	nop
  801da5:	c9                   	leave  
  801da6:	c3                   	ret    

00801da7 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801da7:	55                   	push   %ebp
  801da8:	89 e5                	mov    %esp,%ebp
  801daa:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801dad:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801db0:	8d 50 04             	lea    0x4(%eax),%edx
  801db3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801db6:	6a 00                	push   $0x0
  801db8:	6a 00                	push   $0x0
  801dba:	6a 00                	push   $0x0
  801dbc:	52                   	push   %edx
  801dbd:	50                   	push   %eax
  801dbe:	6a 24                	push   $0x24
  801dc0:	e8 cc fb ff ff       	call   801991 <syscall>
  801dc5:	83 c4 18             	add    $0x18,%esp
	return result;
  801dc8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801dcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801dce:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801dd1:	89 01                	mov    %eax,(%ecx)
  801dd3:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd9:	c9                   	leave  
  801dda:	c2 04 00             	ret    $0x4

00801ddd <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ddd:	55                   	push   %ebp
  801dde:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	ff 75 10             	pushl  0x10(%ebp)
  801de7:	ff 75 0c             	pushl  0xc(%ebp)
  801dea:	ff 75 08             	pushl  0x8(%ebp)
  801ded:	6a 13                	push   $0x13
  801def:	e8 9d fb ff ff       	call   801991 <syscall>
  801df4:	83 c4 18             	add    $0x18,%esp
	return ;
  801df7:	90                   	nop
}
  801df8:	c9                   	leave  
  801df9:	c3                   	ret    

00801dfa <sys_rcr2>:
uint32 sys_rcr2()
{
  801dfa:	55                   	push   %ebp
  801dfb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	6a 00                	push   $0x0
  801e03:	6a 00                	push   $0x0
  801e05:	6a 00                	push   $0x0
  801e07:	6a 25                	push   $0x25
  801e09:	e8 83 fb ff ff       	call   801991 <syscall>
  801e0e:	83 c4 18             	add    $0x18,%esp
}
  801e11:	c9                   	leave  
  801e12:	c3                   	ret    

00801e13 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e13:	55                   	push   %ebp
  801e14:	89 e5                	mov    %esp,%ebp
  801e16:	83 ec 04             	sub    $0x4,%esp
  801e19:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e1f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	50                   	push   %eax
  801e2c:	6a 26                	push   $0x26
  801e2e:	e8 5e fb ff ff       	call   801991 <syscall>
  801e33:	83 c4 18             	add    $0x18,%esp
	return ;
  801e36:	90                   	nop
}
  801e37:	c9                   	leave  
  801e38:	c3                   	ret    

00801e39 <rsttst>:
void rsttst()
{
  801e39:	55                   	push   %ebp
  801e3a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	6a 00                	push   $0x0
  801e44:	6a 00                	push   $0x0
  801e46:	6a 28                	push   $0x28
  801e48:	e8 44 fb ff ff       	call   801991 <syscall>
  801e4d:	83 c4 18             	add    $0x18,%esp
	return ;
  801e50:	90                   	nop
}
  801e51:	c9                   	leave  
  801e52:	c3                   	ret    

00801e53 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801e53:	55                   	push   %ebp
  801e54:	89 e5                	mov    %esp,%ebp
  801e56:	83 ec 04             	sub    $0x4,%esp
  801e59:	8b 45 14             	mov    0x14(%ebp),%eax
  801e5c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801e5f:	8b 55 18             	mov    0x18(%ebp),%edx
  801e62:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e66:	52                   	push   %edx
  801e67:	50                   	push   %eax
  801e68:	ff 75 10             	pushl  0x10(%ebp)
  801e6b:	ff 75 0c             	pushl  0xc(%ebp)
  801e6e:	ff 75 08             	pushl  0x8(%ebp)
  801e71:	6a 27                	push   $0x27
  801e73:	e8 19 fb ff ff       	call   801991 <syscall>
  801e78:	83 c4 18             	add    $0x18,%esp
	return ;
  801e7b:	90                   	nop
}
  801e7c:	c9                   	leave  
  801e7d:	c3                   	ret    

00801e7e <chktst>:
void chktst(uint32 n)
{
  801e7e:	55                   	push   %ebp
  801e7f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801e81:	6a 00                	push   $0x0
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	ff 75 08             	pushl  0x8(%ebp)
  801e8c:	6a 29                	push   $0x29
  801e8e:	e8 fe fa ff ff       	call   801991 <syscall>
  801e93:	83 c4 18             	add    $0x18,%esp
	return ;
  801e96:	90                   	nop
}
  801e97:	c9                   	leave  
  801e98:	c3                   	ret    

00801e99 <inctst>:

void inctst()
{
  801e99:	55                   	push   %ebp
  801e9a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 00                	push   $0x0
  801ea6:	6a 2a                	push   $0x2a
  801ea8:	e8 e4 fa ff ff       	call   801991 <syscall>
  801ead:	83 c4 18             	add    $0x18,%esp
	return ;
  801eb0:	90                   	nop
}
  801eb1:	c9                   	leave  
  801eb2:	c3                   	ret    

00801eb3 <gettst>:
uint32 gettst()
{
  801eb3:	55                   	push   %ebp
  801eb4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 2b                	push   $0x2b
  801ec2:	e8 ca fa ff ff       	call   801991 <syscall>
  801ec7:	83 c4 18             	add    $0x18,%esp
}
  801eca:	c9                   	leave  
  801ecb:	c3                   	ret    

00801ecc <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ecc:	55                   	push   %ebp
  801ecd:	89 e5                	mov    %esp,%ebp
  801ecf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ed2:	6a 00                	push   $0x0
  801ed4:	6a 00                	push   $0x0
  801ed6:	6a 00                	push   $0x0
  801ed8:	6a 00                	push   $0x0
  801eda:	6a 00                	push   $0x0
  801edc:	6a 2c                	push   $0x2c
  801ede:	e8 ae fa ff ff       	call   801991 <syscall>
  801ee3:	83 c4 18             	add    $0x18,%esp
  801ee6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801ee9:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801eed:	75 07                	jne    801ef6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801eef:	b8 01 00 00 00       	mov    $0x1,%eax
  801ef4:	eb 05                	jmp    801efb <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801ef6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801efb:	c9                   	leave  
  801efc:	c3                   	ret    

00801efd <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801efd:	55                   	push   %ebp
  801efe:	89 e5                	mov    %esp,%ebp
  801f00:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f03:	6a 00                	push   $0x0
  801f05:	6a 00                	push   $0x0
  801f07:	6a 00                	push   $0x0
  801f09:	6a 00                	push   $0x0
  801f0b:	6a 00                	push   $0x0
  801f0d:	6a 2c                	push   $0x2c
  801f0f:	e8 7d fa ff ff       	call   801991 <syscall>
  801f14:	83 c4 18             	add    $0x18,%esp
  801f17:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f1a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f1e:	75 07                	jne    801f27 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f20:	b8 01 00 00 00       	mov    $0x1,%eax
  801f25:	eb 05                	jmp    801f2c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801f27:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f2c:	c9                   	leave  
  801f2d:	c3                   	ret    

00801f2e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801f2e:	55                   	push   %ebp
  801f2f:	89 e5                	mov    %esp,%ebp
  801f31:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 2c                	push   $0x2c
  801f40:	e8 4c fa ff ff       	call   801991 <syscall>
  801f45:	83 c4 18             	add    $0x18,%esp
  801f48:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801f4b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801f4f:	75 07                	jne    801f58 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801f51:	b8 01 00 00 00       	mov    $0x1,%eax
  801f56:	eb 05                	jmp    801f5d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801f58:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f5d:	c9                   	leave  
  801f5e:	c3                   	ret    

00801f5f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801f5f:	55                   	push   %ebp
  801f60:	89 e5                	mov    %esp,%ebp
  801f62:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 2c                	push   $0x2c
  801f71:	e8 1b fa ff ff       	call   801991 <syscall>
  801f76:	83 c4 18             	add    $0x18,%esp
  801f79:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801f7c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801f80:	75 07                	jne    801f89 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801f82:	b8 01 00 00 00       	mov    $0x1,%eax
  801f87:	eb 05                	jmp    801f8e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801f89:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f8e:	c9                   	leave  
  801f8f:	c3                   	ret    

00801f90 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801f90:	55                   	push   %ebp
  801f91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	6a 00                	push   $0x0
  801f99:	6a 00                	push   $0x0
  801f9b:	ff 75 08             	pushl  0x8(%ebp)
  801f9e:	6a 2d                	push   $0x2d
  801fa0:	e8 ec f9 ff ff       	call   801991 <syscall>
  801fa5:	83 c4 18             	add    $0x18,%esp
	return ;
  801fa8:	90                   	nop
}
  801fa9:	c9                   	leave  
  801faa:	c3                   	ret    

00801fab <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801fab:	55                   	push   %ebp
  801fac:	89 e5                	mov    %esp,%ebp
  801fae:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801fb1:	8b 55 08             	mov    0x8(%ebp),%edx
  801fb4:	89 d0                	mov    %edx,%eax
  801fb6:	c1 e0 02             	shl    $0x2,%eax
  801fb9:	01 d0                	add    %edx,%eax
  801fbb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801fc2:	01 d0                	add    %edx,%eax
  801fc4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801fcb:	01 d0                	add    %edx,%eax
  801fcd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801fd4:	01 d0                	add    %edx,%eax
  801fd6:	c1 e0 04             	shl    $0x4,%eax
  801fd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801fdc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801fe3:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801fe6:	83 ec 0c             	sub    $0xc,%esp
  801fe9:	50                   	push   %eax
  801fea:	e8 b8 fd ff ff       	call   801da7 <sys_get_virtual_time>
  801fef:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801ff2:	eb 41                	jmp    802035 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801ff4:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801ff7:	83 ec 0c             	sub    $0xc,%esp
  801ffa:	50                   	push   %eax
  801ffb:	e8 a7 fd ff ff       	call   801da7 <sys_get_virtual_time>
  802000:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  802003:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802006:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802009:	29 c2                	sub    %eax,%edx
  80200b:	89 d0                	mov    %edx,%eax
  80200d:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  802010:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802013:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802016:	89 d1                	mov    %edx,%ecx
  802018:	29 c1                	sub    %eax,%ecx
  80201a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80201d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802020:	39 c2                	cmp    %eax,%edx
  802022:	0f 97 c0             	seta   %al
  802025:	0f b6 c0             	movzbl %al,%eax
  802028:	29 c1                	sub    %eax,%ecx
  80202a:	89 c8                	mov    %ecx,%eax
  80202c:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  80202f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802032:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  802035:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802038:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80203b:	72 b7                	jb     801ff4 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  80203d:	90                   	nop
  80203e:	c9                   	leave  
  80203f:	c3                   	ret    

00802040 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  802040:	55                   	push   %ebp
  802041:	89 e5                	mov    %esp,%ebp
  802043:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  802046:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80204d:	eb 03                	jmp    802052 <busy_wait+0x12>
  80204f:	ff 45 fc             	incl   -0x4(%ebp)
  802052:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802055:	3b 45 08             	cmp    0x8(%ebp),%eax
  802058:	72 f5                	jb     80204f <busy_wait+0xf>
	return i;
  80205a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80205d:	c9                   	leave  
  80205e:	c3                   	ret    
  80205f:	90                   	nop

00802060 <__udivdi3>:
  802060:	55                   	push   %ebp
  802061:	57                   	push   %edi
  802062:	56                   	push   %esi
  802063:	53                   	push   %ebx
  802064:	83 ec 1c             	sub    $0x1c,%esp
  802067:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80206b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80206f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802073:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802077:	89 ca                	mov    %ecx,%edx
  802079:	89 f8                	mov    %edi,%eax
  80207b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80207f:	85 f6                	test   %esi,%esi
  802081:	75 2d                	jne    8020b0 <__udivdi3+0x50>
  802083:	39 cf                	cmp    %ecx,%edi
  802085:	77 65                	ja     8020ec <__udivdi3+0x8c>
  802087:	89 fd                	mov    %edi,%ebp
  802089:	85 ff                	test   %edi,%edi
  80208b:	75 0b                	jne    802098 <__udivdi3+0x38>
  80208d:	b8 01 00 00 00       	mov    $0x1,%eax
  802092:	31 d2                	xor    %edx,%edx
  802094:	f7 f7                	div    %edi
  802096:	89 c5                	mov    %eax,%ebp
  802098:	31 d2                	xor    %edx,%edx
  80209a:	89 c8                	mov    %ecx,%eax
  80209c:	f7 f5                	div    %ebp
  80209e:	89 c1                	mov    %eax,%ecx
  8020a0:	89 d8                	mov    %ebx,%eax
  8020a2:	f7 f5                	div    %ebp
  8020a4:	89 cf                	mov    %ecx,%edi
  8020a6:	89 fa                	mov    %edi,%edx
  8020a8:	83 c4 1c             	add    $0x1c,%esp
  8020ab:	5b                   	pop    %ebx
  8020ac:	5e                   	pop    %esi
  8020ad:	5f                   	pop    %edi
  8020ae:	5d                   	pop    %ebp
  8020af:	c3                   	ret    
  8020b0:	39 ce                	cmp    %ecx,%esi
  8020b2:	77 28                	ja     8020dc <__udivdi3+0x7c>
  8020b4:	0f bd fe             	bsr    %esi,%edi
  8020b7:	83 f7 1f             	xor    $0x1f,%edi
  8020ba:	75 40                	jne    8020fc <__udivdi3+0x9c>
  8020bc:	39 ce                	cmp    %ecx,%esi
  8020be:	72 0a                	jb     8020ca <__udivdi3+0x6a>
  8020c0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8020c4:	0f 87 9e 00 00 00    	ja     802168 <__udivdi3+0x108>
  8020ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8020cf:	89 fa                	mov    %edi,%edx
  8020d1:	83 c4 1c             	add    $0x1c,%esp
  8020d4:	5b                   	pop    %ebx
  8020d5:	5e                   	pop    %esi
  8020d6:	5f                   	pop    %edi
  8020d7:	5d                   	pop    %ebp
  8020d8:	c3                   	ret    
  8020d9:	8d 76 00             	lea    0x0(%esi),%esi
  8020dc:	31 ff                	xor    %edi,%edi
  8020de:	31 c0                	xor    %eax,%eax
  8020e0:	89 fa                	mov    %edi,%edx
  8020e2:	83 c4 1c             	add    $0x1c,%esp
  8020e5:	5b                   	pop    %ebx
  8020e6:	5e                   	pop    %esi
  8020e7:	5f                   	pop    %edi
  8020e8:	5d                   	pop    %ebp
  8020e9:	c3                   	ret    
  8020ea:	66 90                	xchg   %ax,%ax
  8020ec:	89 d8                	mov    %ebx,%eax
  8020ee:	f7 f7                	div    %edi
  8020f0:	31 ff                	xor    %edi,%edi
  8020f2:	89 fa                	mov    %edi,%edx
  8020f4:	83 c4 1c             	add    $0x1c,%esp
  8020f7:	5b                   	pop    %ebx
  8020f8:	5e                   	pop    %esi
  8020f9:	5f                   	pop    %edi
  8020fa:	5d                   	pop    %ebp
  8020fb:	c3                   	ret    
  8020fc:	bd 20 00 00 00       	mov    $0x20,%ebp
  802101:	89 eb                	mov    %ebp,%ebx
  802103:	29 fb                	sub    %edi,%ebx
  802105:	89 f9                	mov    %edi,%ecx
  802107:	d3 e6                	shl    %cl,%esi
  802109:	89 c5                	mov    %eax,%ebp
  80210b:	88 d9                	mov    %bl,%cl
  80210d:	d3 ed                	shr    %cl,%ebp
  80210f:	89 e9                	mov    %ebp,%ecx
  802111:	09 f1                	or     %esi,%ecx
  802113:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802117:	89 f9                	mov    %edi,%ecx
  802119:	d3 e0                	shl    %cl,%eax
  80211b:	89 c5                	mov    %eax,%ebp
  80211d:	89 d6                	mov    %edx,%esi
  80211f:	88 d9                	mov    %bl,%cl
  802121:	d3 ee                	shr    %cl,%esi
  802123:	89 f9                	mov    %edi,%ecx
  802125:	d3 e2                	shl    %cl,%edx
  802127:	8b 44 24 08          	mov    0x8(%esp),%eax
  80212b:	88 d9                	mov    %bl,%cl
  80212d:	d3 e8                	shr    %cl,%eax
  80212f:	09 c2                	or     %eax,%edx
  802131:	89 d0                	mov    %edx,%eax
  802133:	89 f2                	mov    %esi,%edx
  802135:	f7 74 24 0c          	divl   0xc(%esp)
  802139:	89 d6                	mov    %edx,%esi
  80213b:	89 c3                	mov    %eax,%ebx
  80213d:	f7 e5                	mul    %ebp
  80213f:	39 d6                	cmp    %edx,%esi
  802141:	72 19                	jb     80215c <__udivdi3+0xfc>
  802143:	74 0b                	je     802150 <__udivdi3+0xf0>
  802145:	89 d8                	mov    %ebx,%eax
  802147:	31 ff                	xor    %edi,%edi
  802149:	e9 58 ff ff ff       	jmp    8020a6 <__udivdi3+0x46>
  80214e:	66 90                	xchg   %ax,%ax
  802150:	8b 54 24 08          	mov    0x8(%esp),%edx
  802154:	89 f9                	mov    %edi,%ecx
  802156:	d3 e2                	shl    %cl,%edx
  802158:	39 c2                	cmp    %eax,%edx
  80215a:	73 e9                	jae    802145 <__udivdi3+0xe5>
  80215c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80215f:	31 ff                	xor    %edi,%edi
  802161:	e9 40 ff ff ff       	jmp    8020a6 <__udivdi3+0x46>
  802166:	66 90                	xchg   %ax,%ax
  802168:	31 c0                	xor    %eax,%eax
  80216a:	e9 37 ff ff ff       	jmp    8020a6 <__udivdi3+0x46>
  80216f:	90                   	nop

00802170 <__umoddi3>:
  802170:	55                   	push   %ebp
  802171:	57                   	push   %edi
  802172:	56                   	push   %esi
  802173:	53                   	push   %ebx
  802174:	83 ec 1c             	sub    $0x1c,%esp
  802177:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80217b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80217f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802183:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802187:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80218b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80218f:	89 f3                	mov    %esi,%ebx
  802191:	89 fa                	mov    %edi,%edx
  802193:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802197:	89 34 24             	mov    %esi,(%esp)
  80219a:	85 c0                	test   %eax,%eax
  80219c:	75 1a                	jne    8021b8 <__umoddi3+0x48>
  80219e:	39 f7                	cmp    %esi,%edi
  8021a0:	0f 86 a2 00 00 00    	jbe    802248 <__umoddi3+0xd8>
  8021a6:	89 c8                	mov    %ecx,%eax
  8021a8:	89 f2                	mov    %esi,%edx
  8021aa:	f7 f7                	div    %edi
  8021ac:	89 d0                	mov    %edx,%eax
  8021ae:	31 d2                	xor    %edx,%edx
  8021b0:	83 c4 1c             	add    $0x1c,%esp
  8021b3:	5b                   	pop    %ebx
  8021b4:	5e                   	pop    %esi
  8021b5:	5f                   	pop    %edi
  8021b6:	5d                   	pop    %ebp
  8021b7:	c3                   	ret    
  8021b8:	39 f0                	cmp    %esi,%eax
  8021ba:	0f 87 ac 00 00 00    	ja     80226c <__umoddi3+0xfc>
  8021c0:	0f bd e8             	bsr    %eax,%ebp
  8021c3:	83 f5 1f             	xor    $0x1f,%ebp
  8021c6:	0f 84 ac 00 00 00    	je     802278 <__umoddi3+0x108>
  8021cc:	bf 20 00 00 00       	mov    $0x20,%edi
  8021d1:	29 ef                	sub    %ebp,%edi
  8021d3:	89 fe                	mov    %edi,%esi
  8021d5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021d9:	89 e9                	mov    %ebp,%ecx
  8021db:	d3 e0                	shl    %cl,%eax
  8021dd:	89 d7                	mov    %edx,%edi
  8021df:	89 f1                	mov    %esi,%ecx
  8021e1:	d3 ef                	shr    %cl,%edi
  8021e3:	09 c7                	or     %eax,%edi
  8021e5:	89 e9                	mov    %ebp,%ecx
  8021e7:	d3 e2                	shl    %cl,%edx
  8021e9:	89 14 24             	mov    %edx,(%esp)
  8021ec:	89 d8                	mov    %ebx,%eax
  8021ee:	d3 e0                	shl    %cl,%eax
  8021f0:	89 c2                	mov    %eax,%edx
  8021f2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021f6:	d3 e0                	shl    %cl,%eax
  8021f8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8021fc:	8b 44 24 08          	mov    0x8(%esp),%eax
  802200:	89 f1                	mov    %esi,%ecx
  802202:	d3 e8                	shr    %cl,%eax
  802204:	09 d0                	or     %edx,%eax
  802206:	d3 eb                	shr    %cl,%ebx
  802208:	89 da                	mov    %ebx,%edx
  80220a:	f7 f7                	div    %edi
  80220c:	89 d3                	mov    %edx,%ebx
  80220e:	f7 24 24             	mull   (%esp)
  802211:	89 c6                	mov    %eax,%esi
  802213:	89 d1                	mov    %edx,%ecx
  802215:	39 d3                	cmp    %edx,%ebx
  802217:	0f 82 87 00 00 00    	jb     8022a4 <__umoddi3+0x134>
  80221d:	0f 84 91 00 00 00    	je     8022b4 <__umoddi3+0x144>
  802223:	8b 54 24 04          	mov    0x4(%esp),%edx
  802227:	29 f2                	sub    %esi,%edx
  802229:	19 cb                	sbb    %ecx,%ebx
  80222b:	89 d8                	mov    %ebx,%eax
  80222d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802231:	d3 e0                	shl    %cl,%eax
  802233:	89 e9                	mov    %ebp,%ecx
  802235:	d3 ea                	shr    %cl,%edx
  802237:	09 d0                	or     %edx,%eax
  802239:	89 e9                	mov    %ebp,%ecx
  80223b:	d3 eb                	shr    %cl,%ebx
  80223d:	89 da                	mov    %ebx,%edx
  80223f:	83 c4 1c             	add    $0x1c,%esp
  802242:	5b                   	pop    %ebx
  802243:	5e                   	pop    %esi
  802244:	5f                   	pop    %edi
  802245:	5d                   	pop    %ebp
  802246:	c3                   	ret    
  802247:	90                   	nop
  802248:	89 fd                	mov    %edi,%ebp
  80224a:	85 ff                	test   %edi,%edi
  80224c:	75 0b                	jne    802259 <__umoddi3+0xe9>
  80224e:	b8 01 00 00 00       	mov    $0x1,%eax
  802253:	31 d2                	xor    %edx,%edx
  802255:	f7 f7                	div    %edi
  802257:	89 c5                	mov    %eax,%ebp
  802259:	89 f0                	mov    %esi,%eax
  80225b:	31 d2                	xor    %edx,%edx
  80225d:	f7 f5                	div    %ebp
  80225f:	89 c8                	mov    %ecx,%eax
  802261:	f7 f5                	div    %ebp
  802263:	89 d0                	mov    %edx,%eax
  802265:	e9 44 ff ff ff       	jmp    8021ae <__umoddi3+0x3e>
  80226a:	66 90                	xchg   %ax,%ax
  80226c:	89 c8                	mov    %ecx,%eax
  80226e:	89 f2                	mov    %esi,%edx
  802270:	83 c4 1c             	add    $0x1c,%esp
  802273:	5b                   	pop    %ebx
  802274:	5e                   	pop    %esi
  802275:	5f                   	pop    %edi
  802276:	5d                   	pop    %ebp
  802277:	c3                   	ret    
  802278:	3b 04 24             	cmp    (%esp),%eax
  80227b:	72 06                	jb     802283 <__umoddi3+0x113>
  80227d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802281:	77 0f                	ja     802292 <__umoddi3+0x122>
  802283:	89 f2                	mov    %esi,%edx
  802285:	29 f9                	sub    %edi,%ecx
  802287:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80228b:	89 14 24             	mov    %edx,(%esp)
  80228e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802292:	8b 44 24 04          	mov    0x4(%esp),%eax
  802296:	8b 14 24             	mov    (%esp),%edx
  802299:	83 c4 1c             	add    $0x1c,%esp
  80229c:	5b                   	pop    %ebx
  80229d:	5e                   	pop    %esi
  80229e:	5f                   	pop    %edi
  80229f:	5d                   	pop    %ebp
  8022a0:	c3                   	ret    
  8022a1:	8d 76 00             	lea    0x0(%esi),%esi
  8022a4:	2b 04 24             	sub    (%esp),%eax
  8022a7:	19 fa                	sbb    %edi,%edx
  8022a9:	89 d1                	mov    %edx,%ecx
  8022ab:	89 c6                	mov    %eax,%esi
  8022ad:	e9 71 ff ff ff       	jmp    802223 <__umoddi3+0xb3>
  8022b2:	66 90                	xchg   %ax,%ax
  8022b4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8022b8:	72 ea                	jb     8022a4 <__umoddi3+0x134>
  8022ba:	89 d9                	mov    %ebx,%ecx
  8022bc:	e9 62 ff ff ff       	jmp    802223 <__umoddi3+0xb3>
