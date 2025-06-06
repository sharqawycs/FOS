
obj/user/tst_page_replacement_lru:     file format elf32-i386


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
  800031:	e8 f2 02 00 00       	call   800328 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*12];
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 6c             	sub    $0x6c,%esp
//	cprintf("envID = %d\n",envID);


	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800041:	a1 20 30 80 00       	mov    0x803020,%eax
  800046:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80004c:	8b 00                	mov    (%eax),%eax
  80004e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800051:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800054:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800059:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005e:	74 14                	je     800074 <_main+0x3c>
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	68 00 1d 80 00       	push   $0x801d00
  800068:	6a 13                	push   $0x13
  80006a:	68 44 1d 80 00       	push   $0x801d44
  80006f:	e8 b6 03 00 00       	call   80042a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800074:	a1 20 30 80 00       	mov    0x803020,%eax
  800079:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007f:	83 c0 0c             	add    $0xc,%eax
  800082:	8b 00                	mov    (%eax),%eax
  800084:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800087:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80008a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008f:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800094:	74 14                	je     8000aa <_main+0x72>
  800096:	83 ec 04             	sub    $0x4,%esp
  800099:	68 00 1d 80 00       	push   $0x801d00
  80009e:	6a 14                	push   $0x14
  8000a0:	68 44 1d 80 00       	push   $0x801d44
  8000a5:	e8 80 03 00 00       	call   80042a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8000af:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b5:	83 c0 18             	add    $0x18,%eax
  8000b8:	8b 00                	mov    (%eax),%eax
  8000ba:	89 45 d8             	mov    %eax,-0x28(%ebp)
  8000bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c5:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000ca:	74 14                	je     8000e0 <_main+0xa8>
  8000cc:	83 ec 04             	sub    $0x4,%esp
  8000cf:	68 00 1d 80 00       	push   $0x801d00
  8000d4:	6a 15                	push   $0x15
  8000d6:	68 44 1d 80 00       	push   $0x801d44
  8000db:	e8 4a 03 00 00       	call   80042a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e5:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000eb:	83 c0 24             	add    $0x24,%eax
  8000ee:	8b 00                	mov    (%eax),%eax
  8000f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fb:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800100:	74 14                	je     800116 <_main+0xde>
  800102:	83 ec 04             	sub    $0x4,%esp
  800105:	68 00 1d 80 00       	push   $0x801d00
  80010a:	6a 16                	push   $0x16
  80010c:	68 44 1d 80 00       	push   $0x801d44
  800111:	e8 14 03 00 00       	call   80042a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800116:	a1 20 30 80 00       	mov    0x803020,%eax
  80011b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800121:	83 c0 30             	add    $0x30,%eax
  800124:	8b 00                	mov    (%eax),%eax
  800126:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800129:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80012c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800131:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800136:	74 14                	je     80014c <_main+0x114>
  800138:	83 ec 04             	sub    $0x4,%esp
  80013b:	68 00 1d 80 00       	push   $0x801d00
  800140:	6a 17                	push   $0x17
  800142:	68 44 1d 80 00       	push   $0x801d44
  800147:	e8 de 02 00 00       	call   80042a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014c:	a1 20 30 80 00       	mov    0x803020,%eax
  800151:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800157:	83 c0 3c             	add    $0x3c,%eax
  80015a:	8b 00                	mov    (%eax),%eax
  80015c:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80015f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800162:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800167:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016c:	74 14                	je     800182 <_main+0x14a>
  80016e:	83 ec 04             	sub    $0x4,%esp
  800171:	68 00 1d 80 00       	push   $0x801d00
  800176:	6a 18                	push   $0x18
  800178:	68 44 1d 80 00       	push   $0x801d44
  80017d:	e8 a8 02 00 00       	call   80042a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800182:	a1 20 30 80 00       	mov    0x803020,%eax
  800187:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018d:	83 c0 48             	add    $0x48,%eax
  800190:	8b 00                	mov    (%eax),%eax
  800192:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800195:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800198:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019d:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a2:	74 14                	je     8001b8 <_main+0x180>
  8001a4:	83 ec 04             	sub    $0x4,%esp
  8001a7:	68 00 1d 80 00       	push   $0x801d00
  8001ac:	6a 19                	push   $0x19
  8001ae:	68 44 1d 80 00       	push   $0x801d44
  8001b3:	e8 72 02 00 00       	call   80042a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bd:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c3:	83 c0 54             	add    $0x54,%eax
  8001c6:	8b 00                	mov    (%eax),%eax
  8001c8:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  8001cb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d3:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d8:	74 14                	je     8001ee <_main+0x1b6>
  8001da:	83 ec 04             	sub    $0x4,%esp
  8001dd:	68 00 1d 80 00       	push   $0x801d00
  8001e2:	6a 1a                	push   $0x1a
  8001e4:	68 44 1d 80 00       	push   $0x801d44
  8001e9:	e8 3c 02 00 00       	call   80042a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f9:	83 c0 60             	add    $0x60,%eax
  8001fc:	8b 00                	mov    (%eax),%eax
  8001fe:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800201:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800204:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800209:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020e:	74 14                	je     800224 <_main+0x1ec>
  800210:	83 ec 04             	sub    $0x4,%esp
  800213:	68 00 1d 80 00       	push   $0x801d00
  800218:	6a 1b                	push   $0x1b
  80021a:	68 44 1d 80 00       	push   $0x801d44
  80021f:	e8 06 02 00 00       	call   80042a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800224:	a1 20 30 80 00       	mov    0x803020,%eax
  800229:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022f:	83 c0 6c             	add    $0x6c,%eax
  800232:	8b 00                	mov    (%eax),%eax
  800234:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800237:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80023a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023f:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800244:	74 14                	je     80025a <_main+0x222>
  800246:	83 ec 04             	sub    $0x4,%esp
  800249:	68 00 1d 80 00       	push   $0x801d00
  80024e:	6a 1c                	push   $0x1c
  800250:	68 44 1d 80 00       	push   $0x801d44
  800255:	e8 d0 01 00 00       	call   80042a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025a:	a1 20 30 80 00       	mov    0x803020,%eax
  80025f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800265:	83 c0 78             	add    $0x78,%eax
  800268:	8b 00                	mov    (%eax),%eax
  80026a:	89 45 b8             	mov    %eax,-0x48(%ebp)
  80026d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800270:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800275:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027a:	74 14                	je     800290 <_main+0x258>
  80027c:	83 ec 04             	sub    $0x4,%esp
  80027f:	68 00 1d 80 00       	push   $0x801d00
  800284:	6a 1d                	push   $0x1d
  800286:	68 44 1d 80 00       	push   $0x801d44
  80028b:	e8 9a 01 00 00       	call   80042a <_panic>
		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
	}

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  800290:	a0 3f e0 80 00       	mov    0x80e03f,%al
  800295:	88 45 b7             	mov    %al,-0x49(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  800298:	a0 3f f0 80 00       	mov    0x80f03f,%al
  80029d:	88 45 b6             	mov    %al,-0x4a(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002a0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8002a7:	eb 37                	jmp    8002e0 <_main+0x2a8>
	{
		arr[i] = -1 ;
  8002a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002ac:	05 40 30 80 00       	add    $0x803040,%eax
  8002b1:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8002b4:	a1 04 30 80 00       	mov    0x803004,%eax
  8002b9:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8002bf:	8a 12                	mov    (%edx),%dl
  8002c1:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8002c3:	a1 00 30 80 00       	mov    0x803000,%eax
  8002c8:	40                   	inc    %eax
  8002c9:	a3 00 30 80 00       	mov    %eax,0x803000
  8002ce:	a1 04 30 80 00       	mov    0x803004,%eax
  8002d3:	40                   	inc    %eax
  8002d4:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002d9:	81 45 e4 00 08 00 00 	addl   $0x800,-0x1c(%ebp)
  8002e0:	81 7d e4 ff 9f 00 00 	cmpl   $0x9fff,-0x1c(%ebp)
  8002e7:	7e c0                	jle    8002a9 <_main+0x271>
		ptr++ ; ptr2++ ;
	}

	//===================

	uint32 expectedPages[11] = {0x809000,0x80a000,0x804000,0x80b000,0x80c000,0x800000,0x801000,0x808000,0x803000,0xeebfd000,0};
  8002e9:	8d 45 88             	lea    -0x78(%ebp),%eax
  8002ec:	bb c0 1d 80 00       	mov    $0x801dc0,%ebx
  8002f1:	ba 0b 00 00 00       	mov    $0xb,%edx
  8002f6:	89 c7                	mov    %eax,%edi
  8002f8:	89 de                	mov    %ebx,%esi
  8002fa:	89 d1                	mov    %edx,%ecx
  8002fc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	//cprintf("Checking PAGE LRU algorithm... \n");
	{
		CheckWSWithoutLastIndex(expectedPages, 11);
  8002fe:	83 ec 08             	sub    $0x8,%esp
  800301:	6a 0b                	push   $0xb
  800303:	8d 45 88             	lea    -0x78(%ebp),%eax
  800306:	50                   	push   %eax
  800307:	e8 90 01 00 00       	call   80049c <CheckWSWithoutLastIndex>
  80030c:	83 c4 10             	add    $0x10,%esp
		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if(myEnv->page_last_WS_index != 5) panic("wrong PAGE WS pointer location");

	}

	cprintf("Congratulations!! test PAGE replacement [LRU Alg.] is completed successfully.\n");
  80030f:	83 ec 0c             	sub    $0xc,%esp
  800312:	68 64 1d 80 00       	push   $0x801d64
  800317:	e8 c2 03 00 00       	call   8006de <cprintf>
  80031c:	83 c4 10             	add    $0x10,%esp
	return;
  80031f:	90                   	nop
}
  800320:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800323:	5b                   	pop    %ebx
  800324:	5e                   	pop    %esi
  800325:	5f                   	pop    %edi
  800326:	5d                   	pop    %ebp
  800327:	c3                   	ret    

00800328 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800328:	55                   	push   %ebp
  800329:	89 e5                	mov    %esp,%ebp
  80032b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80032e:	e8 d6 11 00 00       	call   801509 <sys_getenvindex>
  800333:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800336:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800339:	89 d0                	mov    %edx,%eax
  80033b:	01 c0                	add    %eax,%eax
  80033d:	01 d0                	add    %edx,%eax
  80033f:	c1 e0 02             	shl    $0x2,%eax
  800342:	01 d0                	add    %edx,%eax
  800344:	c1 e0 06             	shl    $0x6,%eax
  800347:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80034c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800351:	a1 20 30 80 00       	mov    0x803020,%eax
  800356:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80035c:	84 c0                	test   %al,%al
  80035e:	74 0f                	je     80036f <libmain+0x47>
		binaryname = myEnv->prog_name;
  800360:	a1 20 30 80 00       	mov    0x803020,%eax
  800365:	05 f4 02 00 00       	add    $0x2f4,%eax
  80036a:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80036f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800373:	7e 0a                	jle    80037f <libmain+0x57>
		binaryname = argv[0];
  800375:	8b 45 0c             	mov    0xc(%ebp),%eax
  800378:	8b 00                	mov    (%eax),%eax
  80037a:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  80037f:	83 ec 08             	sub    $0x8,%esp
  800382:	ff 75 0c             	pushl  0xc(%ebp)
  800385:	ff 75 08             	pushl  0x8(%ebp)
  800388:	e8 ab fc ff ff       	call   800038 <_main>
  80038d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800390:	e8 0f 13 00 00       	call   8016a4 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800395:	83 ec 0c             	sub    $0xc,%esp
  800398:	68 04 1e 80 00       	push   $0x801e04
  80039d:	e8 3c 03 00 00       	call   8006de <cprintf>
  8003a2:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003a5:	a1 20 30 80 00       	mov    0x803020,%eax
  8003aa:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8003b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b5:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8003bb:	83 ec 04             	sub    $0x4,%esp
  8003be:	52                   	push   %edx
  8003bf:	50                   	push   %eax
  8003c0:	68 2c 1e 80 00       	push   $0x801e2c
  8003c5:	e8 14 03 00 00       	call   8006de <cprintf>
  8003ca:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8003cd:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d2:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8003d8:	83 ec 08             	sub    $0x8,%esp
  8003db:	50                   	push   %eax
  8003dc:	68 51 1e 80 00       	push   $0x801e51
  8003e1:	e8 f8 02 00 00       	call   8006de <cprintf>
  8003e6:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8003e9:	83 ec 0c             	sub    $0xc,%esp
  8003ec:	68 04 1e 80 00       	push   $0x801e04
  8003f1:	e8 e8 02 00 00       	call   8006de <cprintf>
  8003f6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8003f9:	e8 c0 12 00 00       	call   8016be <sys_enable_interrupt>

	// exit gracefully
	exit();
  8003fe:	e8 19 00 00 00       	call   80041c <exit>
}
  800403:	90                   	nop
  800404:	c9                   	leave  
  800405:	c3                   	ret    

00800406 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800406:	55                   	push   %ebp
  800407:	89 e5                	mov    %esp,%ebp
  800409:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80040c:	83 ec 0c             	sub    $0xc,%esp
  80040f:	6a 00                	push   $0x0
  800411:	e8 bf 10 00 00       	call   8014d5 <sys_env_destroy>
  800416:	83 c4 10             	add    $0x10,%esp
}
  800419:	90                   	nop
  80041a:	c9                   	leave  
  80041b:	c3                   	ret    

0080041c <exit>:

void
exit(void)
{
  80041c:	55                   	push   %ebp
  80041d:	89 e5                	mov    %esp,%ebp
  80041f:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800422:	e8 14 11 00 00       	call   80153b <sys_env_exit>
}
  800427:	90                   	nop
  800428:	c9                   	leave  
  800429:	c3                   	ret    

0080042a <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80042a:	55                   	push   %ebp
  80042b:	89 e5                	mov    %esp,%ebp
  80042d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800430:	8d 45 10             	lea    0x10(%ebp),%eax
  800433:	83 c0 04             	add    $0x4,%eax
  800436:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800439:	a1 48 f0 80 00       	mov    0x80f048,%eax
  80043e:	85 c0                	test   %eax,%eax
  800440:	74 16                	je     800458 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800442:	a1 48 f0 80 00       	mov    0x80f048,%eax
  800447:	83 ec 08             	sub    $0x8,%esp
  80044a:	50                   	push   %eax
  80044b:	68 68 1e 80 00       	push   $0x801e68
  800450:	e8 89 02 00 00       	call   8006de <cprintf>
  800455:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800458:	a1 08 30 80 00       	mov    0x803008,%eax
  80045d:	ff 75 0c             	pushl  0xc(%ebp)
  800460:	ff 75 08             	pushl  0x8(%ebp)
  800463:	50                   	push   %eax
  800464:	68 6d 1e 80 00       	push   $0x801e6d
  800469:	e8 70 02 00 00       	call   8006de <cprintf>
  80046e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800471:	8b 45 10             	mov    0x10(%ebp),%eax
  800474:	83 ec 08             	sub    $0x8,%esp
  800477:	ff 75 f4             	pushl  -0xc(%ebp)
  80047a:	50                   	push   %eax
  80047b:	e8 f3 01 00 00       	call   800673 <vcprintf>
  800480:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800483:	83 ec 08             	sub    $0x8,%esp
  800486:	6a 00                	push   $0x0
  800488:	68 89 1e 80 00       	push   $0x801e89
  80048d:	e8 e1 01 00 00       	call   800673 <vcprintf>
  800492:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800495:	e8 82 ff ff ff       	call   80041c <exit>

	// should not return here
	while (1) ;
  80049a:	eb fe                	jmp    80049a <_panic+0x70>

0080049c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80049c:	55                   	push   %ebp
  80049d:	89 e5                	mov    %esp,%ebp
  80049f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8004a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a7:	8b 50 74             	mov    0x74(%eax),%edx
  8004aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ad:	39 c2                	cmp    %eax,%edx
  8004af:	74 14                	je     8004c5 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8004b1:	83 ec 04             	sub    $0x4,%esp
  8004b4:	68 8c 1e 80 00       	push   $0x801e8c
  8004b9:	6a 26                	push   $0x26
  8004bb:	68 d8 1e 80 00       	push   $0x801ed8
  8004c0:	e8 65 ff ff ff       	call   80042a <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8004c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8004cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004d3:	e9 c2 00 00 00       	jmp    80059a <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8004d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004db:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e5:	01 d0                	add    %edx,%eax
  8004e7:	8b 00                	mov    (%eax),%eax
  8004e9:	85 c0                	test   %eax,%eax
  8004eb:	75 08                	jne    8004f5 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8004ed:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8004f0:	e9 a2 00 00 00       	jmp    800597 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8004f5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004fc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800503:	eb 69                	jmp    80056e <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800505:	a1 20 30 80 00       	mov    0x803020,%eax
  80050a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800510:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800513:	89 d0                	mov    %edx,%eax
  800515:	01 c0                	add    %eax,%eax
  800517:	01 d0                	add    %edx,%eax
  800519:	c1 e0 02             	shl    $0x2,%eax
  80051c:	01 c8                	add    %ecx,%eax
  80051e:	8a 40 04             	mov    0x4(%eax),%al
  800521:	84 c0                	test   %al,%al
  800523:	75 46                	jne    80056b <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800525:	a1 20 30 80 00       	mov    0x803020,%eax
  80052a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800530:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800533:	89 d0                	mov    %edx,%eax
  800535:	01 c0                	add    %eax,%eax
  800537:	01 d0                	add    %edx,%eax
  800539:	c1 e0 02             	shl    $0x2,%eax
  80053c:	01 c8                	add    %ecx,%eax
  80053e:	8b 00                	mov    (%eax),%eax
  800540:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800543:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800546:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80054b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80054d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800550:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800557:	8b 45 08             	mov    0x8(%ebp),%eax
  80055a:	01 c8                	add    %ecx,%eax
  80055c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80055e:	39 c2                	cmp    %eax,%edx
  800560:	75 09                	jne    80056b <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800562:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800569:	eb 12                	jmp    80057d <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80056b:	ff 45 e8             	incl   -0x18(%ebp)
  80056e:	a1 20 30 80 00       	mov    0x803020,%eax
  800573:	8b 50 74             	mov    0x74(%eax),%edx
  800576:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800579:	39 c2                	cmp    %eax,%edx
  80057b:	77 88                	ja     800505 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80057d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800581:	75 14                	jne    800597 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800583:	83 ec 04             	sub    $0x4,%esp
  800586:	68 e4 1e 80 00       	push   $0x801ee4
  80058b:	6a 3a                	push   $0x3a
  80058d:	68 d8 1e 80 00       	push   $0x801ed8
  800592:	e8 93 fe ff ff       	call   80042a <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800597:	ff 45 f0             	incl   -0x10(%ebp)
  80059a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80059d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005a0:	0f 8c 32 ff ff ff    	jl     8004d8 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8005a6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005ad:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8005b4:	eb 26                	jmp    8005dc <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8005b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8005bb:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8005c1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005c4:	89 d0                	mov    %edx,%eax
  8005c6:	01 c0                	add    %eax,%eax
  8005c8:	01 d0                	add    %edx,%eax
  8005ca:	c1 e0 02             	shl    $0x2,%eax
  8005cd:	01 c8                	add    %ecx,%eax
  8005cf:	8a 40 04             	mov    0x4(%eax),%al
  8005d2:	3c 01                	cmp    $0x1,%al
  8005d4:	75 03                	jne    8005d9 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8005d6:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005d9:	ff 45 e0             	incl   -0x20(%ebp)
  8005dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e1:	8b 50 74             	mov    0x74(%eax),%edx
  8005e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005e7:	39 c2                	cmp    %eax,%edx
  8005e9:	77 cb                	ja     8005b6 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8005eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005ee:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005f1:	74 14                	je     800607 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8005f3:	83 ec 04             	sub    $0x4,%esp
  8005f6:	68 38 1f 80 00       	push   $0x801f38
  8005fb:	6a 44                	push   $0x44
  8005fd:	68 d8 1e 80 00       	push   $0x801ed8
  800602:	e8 23 fe ff ff       	call   80042a <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800607:	90                   	nop
  800608:	c9                   	leave  
  800609:	c3                   	ret    

0080060a <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80060a:	55                   	push   %ebp
  80060b:	89 e5                	mov    %esp,%ebp
  80060d:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800610:	8b 45 0c             	mov    0xc(%ebp),%eax
  800613:	8b 00                	mov    (%eax),%eax
  800615:	8d 48 01             	lea    0x1(%eax),%ecx
  800618:	8b 55 0c             	mov    0xc(%ebp),%edx
  80061b:	89 0a                	mov    %ecx,(%edx)
  80061d:	8b 55 08             	mov    0x8(%ebp),%edx
  800620:	88 d1                	mov    %dl,%cl
  800622:	8b 55 0c             	mov    0xc(%ebp),%edx
  800625:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800629:	8b 45 0c             	mov    0xc(%ebp),%eax
  80062c:	8b 00                	mov    (%eax),%eax
  80062e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800633:	75 2c                	jne    800661 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800635:	a0 24 30 80 00       	mov    0x803024,%al
  80063a:	0f b6 c0             	movzbl %al,%eax
  80063d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800640:	8b 12                	mov    (%edx),%edx
  800642:	89 d1                	mov    %edx,%ecx
  800644:	8b 55 0c             	mov    0xc(%ebp),%edx
  800647:	83 c2 08             	add    $0x8,%edx
  80064a:	83 ec 04             	sub    $0x4,%esp
  80064d:	50                   	push   %eax
  80064e:	51                   	push   %ecx
  80064f:	52                   	push   %edx
  800650:	e8 3e 0e 00 00       	call   801493 <sys_cputs>
  800655:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800658:	8b 45 0c             	mov    0xc(%ebp),%eax
  80065b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800661:	8b 45 0c             	mov    0xc(%ebp),%eax
  800664:	8b 40 04             	mov    0x4(%eax),%eax
  800667:	8d 50 01             	lea    0x1(%eax),%edx
  80066a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80066d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800670:	90                   	nop
  800671:	c9                   	leave  
  800672:	c3                   	ret    

00800673 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800673:	55                   	push   %ebp
  800674:	89 e5                	mov    %esp,%ebp
  800676:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80067c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800683:	00 00 00 
	b.cnt = 0;
  800686:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80068d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800690:	ff 75 0c             	pushl  0xc(%ebp)
  800693:	ff 75 08             	pushl  0x8(%ebp)
  800696:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80069c:	50                   	push   %eax
  80069d:	68 0a 06 80 00       	push   $0x80060a
  8006a2:	e8 11 02 00 00       	call   8008b8 <vprintfmt>
  8006a7:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006aa:	a0 24 30 80 00       	mov    0x803024,%al
  8006af:	0f b6 c0             	movzbl %al,%eax
  8006b2:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8006b8:	83 ec 04             	sub    $0x4,%esp
  8006bb:	50                   	push   %eax
  8006bc:	52                   	push   %edx
  8006bd:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006c3:	83 c0 08             	add    $0x8,%eax
  8006c6:	50                   	push   %eax
  8006c7:	e8 c7 0d 00 00       	call   801493 <sys_cputs>
  8006cc:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8006cf:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8006d6:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8006dc:	c9                   	leave  
  8006dd:	c3                   	ret    

008006de <cprintf>:

int cprintf(const char *fmt, ...) {
  8006de:	55                   	push   %ebp
  8006df:	89 e5                	mov    %esp,%ebp
  8006e1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006e4:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8006eb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f4:	83 ec 08             	sub    $0x8,%esp
  8006f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8006fa:	50                   	push   %eax
  8006fb:	e8 73 ff ff ff       	call   800673 <vcprintf>
  800700:	83 c4 10             	add    $0x10,%esp
  800703:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800706:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800709:	c9                   	leave  
  80070a:	c3                   	ret    

0080070b <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80070b:	55                   	push   %ebp
  80070c:	89 e5                	mov    %esp,%ebp
  80070e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800711:	e8 8e 0f 00 00       	call   8016a4 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800716:	8d 45 0c             	lea    0xc(%ebp),%eax
  800719:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80071c:	8b 45 08             	mov    0x8(%ebp),%eax
  80071f:	83 ec 08             	sub    $0x8,%esp
  800722:	ff 75 f4             	pushl  -0xc(%ebp)
  800725:	50                   	push   %eax
  800726:	e8 48 ff ff ff       	call   800673 <vcprintf>
  80072b:	83 c4 10             	add    $0x10,%esp
  80072e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800731:	e8 88 0f 00 00       	call   8016be <sys_enable_interrupt>
	return cnt;
  800736:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800739:	c9                   	leave  
  80073a:	c3                   	ret    

0080073b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80073b:	55                   	push   %ebp
  80073c:	89 e5                	mov    %esp,%ebp
  80073e:	53                   	push   %ebx
  80073f:	83 ec 14             	sub    $0x14,%esp
  800742:	8b 45 10             	mov    0x10(%ebp),%eax
  800745:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800748:	8b 45 14             	mov    0x14(%ebp),%eax
  80074b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80074e:	8b 45 18             	mov    0x18(%ebp),%eax
  800751:	ba 00 00 00 00       	mov    $0x0,%edx
  800756:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800759:	77 55                	ja     8007b0 <printnum+0x75>
  80075b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80075e:	72 05                	jb     800765 <printnum+0x2a>
  800760:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800763:	77 4b                	ja     8007b0 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800765:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800768:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80076b:	8b 45 18             	mov    0x18(%ebp),%eax
  80076e:	ba 00 00 00 00       	mov    $0x0,%edx
  800773:	52                   	push   %edx
  800774:	50                   	push   %eax
  800775:	ff 75 f4             	pushl  -0xc(%ebp)
  800778:	ff 75 f0             	pushl  -0x10(%ebp)
  80077b:	e8 04 13 00 00       	call   801a84 <__udivdi3>
  800780:	83 c4 10             	add    $0x10,%esp
  800783:	83 ec 04             	sub    $0x4,%esp
  800786:	ff 75 20             	pushl  0x20(%ebp)
  800789:	53                   	push   %ebx
  80078a:	ff 75 18             	pushl  0x18(%ebp)
  80078d:	52                   	push   %edx
  80078e:	50                   	push   %eax
  80078f:	ff 75 0c             	pushl  0xc(%ebp)
  800792:	ff 75 08             	pushl  0x8(%ebp)
  800795:	e8 a1 ff ff ff       	call   80073b <printnum>
  80079a:	83 c4 20             	add    $0x20,%esp
  80079d:	eb 1a                	jmp    8007b9 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80079f:	83 ec 08             	sub    $0x8,%esp
  8007a2:	ff 75 0c             	pushl  0xc(%ebp)
  8007a5:	ff 75 20             	pushl  0x20(%ebp)
  8007a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ab:	ff d0                	call   *%eax
  8007ad:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007b0:	ff 4d 1c             	decl   0x1c(%ebp)
  8007b3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007b7:	7f e6                	jg     80079f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007b9:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007bc:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007c7:	53                   	push   %ebx
  8007c8:	51                   	push   %ecx
  8007c9:	52                   	push   %edx
  8007ca:	50                   	push   %eax
  8007cb:	e8 c4 13 00 00       	call   801b94 <__umoddi3>
  8007d0:	83 c4 10             	add    $0x10,%esp
  8007d3:	05 b4 21 80 00       	add    $0x8021b4,%eax
  8007d8:	8a 00                	mov    (%eax),%al
  8007da:	0f be c0             	movsbl %al,%eax
  8007dd:	83 ec 08             	sub    $0x8,%esp
  8007e0:	ff 75 0c             	pushl  0xc(%ebp)
  8007e3:	50                   	push   %eax
  8007e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e7:	ff d0                	call   *%eax
  8007e9:	83 c4 10             	add    $0x10,%esp
}
  8007ec:	90                   	nop
  8007ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007f0:	c9                   	leave  
  8007f1:	c3                   	ret    

008007f2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007f2:	55                   	push   %ebp
  8007f3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007f5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007f9:	7e 1c                	jle    800817 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fe:	8b 00                	mov    (%eax),%eax
  800800:	8d 50 08             	lea    0x8(%eax),%edx
  800803:	8b 45 08             	mov    0x8(%ebp),%eax
  800806:	89 10                	mov    %edx,(%eax)
  800808:	8b 45 08             	mov    0x8(%ebp),%eax
  80080b:	8b 00                	mov    (%eax),%eax
  80080d:	83 e8 08             	sub    $0x8,%eax
  800810:	8b 50 04             	mov    0x4(%eax),%edx
  800813:	8b 00                	mov    (%eax),%eax
  800815:	eb 40                	jmp    800857 <getuint+0x65>
	else if (lflag)
  800817:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80081b:	74 1e                	je     80083b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80081d:	8b 45 08             	mov    0x8(%ebp),%eax
  800820:	8b 00                	mov    (%eax),%eax
  800822:	8d 50 04             	lea    0x4(%eax),%edx
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	89 10                	mov    %edx,(%eax)
  80082a:	8b 45 08             	mov    0x8(%ebp),%eax
  80082d:	8b 00                	mov    (%eax),%eax
  80082f:	83 e8 04             	sub    $0x4,%eax
  800832:	8b 00                	mov    (%eax),%eax
  800834:	ba 00 00 00 00       	mov    $0x0,%edx
  800839:	eb 1c                	jmp    800857 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80083b:	8b 45 08             	mov    0x8(%ebp),%eax
  80083e:	8b 00                	mov    (%eax),%eax
  800840:	8d 50 04             	lea    0x4(%eax),%edx
  800843:	8b 45 08             	mov    0x8(%ebp),%eax
  800846:	89 10                	mov    %edx,(%eax)
  800848:	8b 45 08             	mov    0x8(%ebp),%eax
  80084b:	8b 00                	mov    (%eax),%eax
  80084d:	83 e8 04             	sub    $0x4,%eax
  800850:	8b 00                	mov    (%eax),%eax
  800852:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800857:	5d                   	pop    %ebp
  800858:	c3                   	ret    

00800859 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800859:	55                   	push   %ebp
  80085a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80085c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800860:	7e 1c                	jle    80087e <getint+0x25>
		return va_arg(*ap, long long);
  800862:	8b 45 08             	mov    0x8(%ebp),%eax
  800865:	8b 00                	mov    (%eax),%eax
  800867:	8d 50 08             	lea    0x8(%eax),%edx
  80086a:	8b 45 08             	mov    0x8(%ebp),%eax
  80086d:	89 10                	mov    %edx,(%eax)
  80086f:	8b 45 08             	mov    0x8(%ebp),%eax
  800872:	8b 00                	mov    (%eax),%eax
  800874:	83 e8 08             	sub    $0x8,%eax
  800877:	8b 50 04             	mov    0x4(%eax),%edx
  80087a:	8b 00                	mov    (%eax),%eax
  80087c:	eb 38                	jmp    8008b6 <getint+0x5d>
	else if (lflag)
  80087e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800882:	74 1a                	je     80089e <getint+0x45>
		return va_arg(*ap, long);
  800884:	8b 45 08             	mov    0x8(%ebp),%eax
  800887:	8b 00                	mov    (%eax),%eax
  800889:	8d 50 04             	lea    0x4(%eax),%edx
  80088c:	8b 45 08             	mov    0x8(%ebp),%eax
  80088f:	89 10                	mov    %edx,(%eax)
  800891:	8b 45 08             	mov    0x8(%ebp),%eax
  800894:	8b 00                	mov    (%eax),%eax
  800896:	83 e8 04             	sub    $0x4,%eax
  800899:	8b 00                	mov    (%eax),%eax
  80089b:	99                   	cltd   
  80089c:	eb 18                	jmp    8008b6 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80089e:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a1:	8b 00                	mov    (%eax),%eax
  8008a3:	8d 50 04             	lea    0x4(%eax),%edx
  8008a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a9:	89 10                	mov    %edx,(%eax)
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	8b 00                	mov    (%eax),%eax
  8008b0:	83 e8 04             	sub    $0x4,%eax
  8008b3:	8b 00                	mov    (%eax),%eax
  8008b5:	99                   	cltd   
}
  8008b6:	5d                   	pop    %ebp
  8008b7:	c3                   	ret    

008008b8 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008b8:	55                   	push   %ebp
  8008b9:	89 e5                	mov    %esp,%ebp
  8008bb:	56                   	push   %esi
  8008bc:	53                   	push   %ebx
  8008bd:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008c0:	eb 17                	jmp    8008d9 <vprintfmt+0x21>
			if (ch == '\0')
  8008c2:	85 db                	test   %ebx,%ebx
  8008c4:	0f 84 af 03 00 00    	je     800c79 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8008ca:	83 ec 08             	sub    $0x8,%esp
  8008cd:	ff 75 0c             	pushl  0xc(%ebp)
  8008d0:	53                   	push   %ebx
  8008d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d4:	ff d0                	call   *%eax
  8008d6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8008dc:	8d 50 01             	lea    0x1(%eax),%edx
  8008df:	89 55 10             	mov    %edx,0x10(%ebp)
  8008e2:	8a 00                	mov    (%eax),%al
  8008e4:	0f b6 d8             	movzbl %al,%ebx
  8008e7:	83 fb 25             	cmp    $0x25,%ebx
  8008ea:	75 d6                	jne    8008c2 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008ec:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008f0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008f7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008fe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800905:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80090c:	8b 45 10             	mov    0x10(%ebp),%eax
  80090f:	8d 50 01             	lea    0x1(%eax),%edx
  800912:	89 55 10             	mov    %edx,0x10(%ebp)
  800915:	8a 00                	mov    (%eax),%al
  800917:	0f b6 d8             	movzbl %al,%ebx
  80091a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80091d:	83 f8 55             	cmp    $0x55,%eax
  800920:	0f 87 2b 03 00 00    	ja     800c51 <vprintfmt+0x399>
  800926:	8b 04 85 d8 21 80 00 	mov    0x8021d8(,%eax,4),%eax
  80092d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80092f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800933:	eb d7                	jmp    80090c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800935:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800939:	eb d1                	jmp    80090c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80093b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800942:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800945:	89 d0                	mov    %edx,%eax
  800947:	c1 e0 02             	shl    $0x2,%eax
  80094a:	01 d0                	add    %edx,%eax
  80094c:	01 c0                	add    %eax,%eax
  80094e:	01 d8                	add    %ebx,%eax
  800950:	83 e8 30             	sub    $0x30,%eax
  800953:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800956:	8b 45 10             	mov    0x10(%ebp),%eax
  800959:	8a 00                	mov    (%eax),%al
  80095b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80095e:	83 fb 2f             	cmp    $0x2f,%ebx
  800961:	7e 3e                	jle    8009a1 <vprintfmt+0xe9>
  800963:	83 fb 39             	cmp    $0x39,%ebx
  800966:	7f 39                	jg     8009a1 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800968:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80096b:	eb d5                	jmp    800942 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80096d:	8b 45 14             	mov    0x14(%ebp),%eax
  800970:	83 c0 04             	add    $0x4,%eax
  800973:	89 45 14             	mov    %eax,0x14(%ebp)
  800976:	8b 45 14             	mov    0x14(%ebp),%eax
  800979:	83 e8 04             	sub    $0x4,%eax
  80097c:	8b 00                	mov    (%eax),%eax
  80097e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800981:	eb 1f                	jmp    8009a2 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800983:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800987:	79 83                	jns    80090c <vprintfmt+0x54>
				width = 0;
  800989:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800990:	e9 77 ff ff ff       	jmp    80090c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800995:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80099c:	e9 6b ff ff ff       	jmp    80090c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009a1:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009a2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009a6:	0f 89 60 ff ff ff    	jns    80090c <vprintfmt+0x54>
				width = precision, precision = -1;
  8009ac:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009af:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009b2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009b9:	e9 4e ff ff ff       	jmp    80090c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009be:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009c1:	e9 46 ff ff ff       	jmp    80090c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009c9:	83 c0 04             	add    $0x4,%eax
  8009cc:	89 45 14             	mov    %eax,0x14(%ebp)
  8009cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d2:	83 e8 04             	sub    $0x4,%eax
  8009d5:	8b 00                	mov    (%eax),%eax
  8009d7:	83 ec 08             	sub    $0x8,%esp
  8009da:	ff 75 0c             	pushl  0xc(%ebp)
  8009dd:	50                   	push   %eax
  8009de:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e1:	ff d0                	call   *%eax
  8009e3:	83 c4 10             	add    $0x10,%esp
			break;
  8009e6:	e9 89 02 00 00       	jmp    800c74 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ee:	83 c0 04             	add    $0x4,%eax
  8009f1:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f7:	83 e8 04             	sub    $0x4,%eax
  8009fa:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009fc:	85 db                	test   %ebx,%ebx
  8009fe:	79 02                	jns    800a02 <vprintfmt+0x14a>
				err = -err;
  800a00:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a02:	83 fb 64             	cmp    $0x64,%ebx
  800a05:	7f 0b                	jg     800a12 <vprintfmt+0x15a>
  800a07:	8b 34 9d 20 20 80 00 	mov    0x802020(,%ebx,4),%esi
  800a0e:	85 f6                	test   %esi,%esi
  800a10:	75 19                	jne    800a2b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a12:	53                   	push   %ebx
  800a13:	68 c5 21 80 00       	push   $0x8021c5
  800a18:	ff 75 0c             	pushl  0xc(%ebp)
  800a1b:	ff 75 08             	pushl  0x8(%ebp)
  800a1e:	e8 5e 02 00 00       	call   800c81 <printfmt>
  800a23:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a26:	e9 49 02 00 00       	jmp    800c74 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a2b:	56                   	push   %esi
  800a2c:	68 ce 21 80 00       	push   $0x8021ce
  800a31:	ff 75 0c             	pushl  0xc(%ebp)
  800a34:	ff 75 08             	pushl  0x8(%ebp)
  800a37:	e8 45 02 00 00       	call   800c81 <printfmt>
  800a3c:	83 c4 10             	add    $0x10,%esp
			break;
  800a3f:	e9 30 02 00 00       	jmp    800c74 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a44:	8b 45 14             	mov    0x14(%ebp),%eax
  800a47:	83 c0 04             	add    $0x4,%eax
  800a4a:	89 45 14             	mov    %eax,0x14(%ebp)
  800a4d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a50:	83 e8 04             	sub    $0x4,%eax
  800a53:	8b 30                	mov    (%eax),%esi
  800a55:	85 f6                	test   %esi,%esi
  800a57:	75 05                	jne    800a5e <vprintfmt+0x1a6>
				p = "(null)";
  800a59:	be d1 21 80 00       	mov    $0x8021d1,%esi
			if (width > 0 && padc != '-')
  800a5e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a62:	7e 6d                	jle    800ad1 <vprintfmt+0x219>
  800a64:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a68:	74 67                	je     800ad1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a6a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a6d:	83 ec 08             	sub    $0x8,%esp
  800a70:	50                   	push   %eax
  800a71:	56                   	push   %esi
  800a72:	e8 0c 03 00 00       	call   800d83 <strnlen>
  800a77:	83 c4 10             	add    $0x10,%esp
  800a7a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a7d:	eb 16                	jmp    800a95 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a7f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a83:	83 ec 08             	sub    $0x8,%esp
  800a86:	ff 75 0c             	pushl  0xc(%ebp)
  800a89:	50                   	push   %eax
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	ff d0                	call   *%eax
  800a8f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a92:	ff 4d e4             	decl   -0x1c(%ebp)
  800a95:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a99:	7f e4                	jg     800a7f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a9b:	eb 34                	jmp    800ad1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a9d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800aa1:	74 1c                	je     800abf <vprintfmt+0x207>
  800aa3:	83 fb 1f             	cmp    $0x1f,%ebx
  800aa6:	7e 05                	jle    800aad <vprintfmt+0x1f5>
  800aa8:	83 fb 7e             	cmp    $0x7e,%ebx
  800aab:	7e 12                	jle    800abf <vprintfmt+0x207>
					putch('?', putdat);
  800aad:	83 ec 08             	sub    $0x8,%esp
  800ab0:	ff 75 0c             	pushl  0xc(%ebp)
  800ab3:	6a 3f                	push   $0x3f
  800ab5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab8:	ff d0                	call   *%eax
  800aba:	83 c4 10             	add    $0x10,%esp
  800abd:	eb 0f                	jmp    800ace <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800abf:	83 ec 08             	sub    $0x8,%esp
  800ac2:	ff 75 0c             	pushl  0xc(%ebp)
  800ac5:	53                   	push   %ebx
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	ff d0                	call   *%eax
  800acb:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ace:	ff 4d e4             	decl   -0x1c(%ebp)
  800ad1:	89 f0                	mov    %esi,%eax
  800ad3:	8d 70 01             	lea    0x1(%eax),%esi
  800ad6:	8a 00                	mov    (%eax),%al
  800ad8:	0f be d8             	movsbl %al,%ebx
  800adb:	85 db                	test   %ebx,%ebx
  800add:	74 24                	je     800b03 <vprintfmt+0x24b>
  800adf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ae3:	78 b8                	js     800a9d <vprintfmt+0x1e5>
  800ae5:	ff 4d e0             	decl   -0x20(%ebp)
  800ae8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800aec:	79 af                	jns    800a9d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800aee:	eb 13                	jmp    800b03 <vprintfmt+0x24b>
				putch(' ', putdat);
  800af0:	83 ec 08             	sub    $0x8,%esp
  800af3:	ff 75 0c             	pushl  0xc(%ebp)
  800af6:	6a 20                	push   $0x20
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	ff d0                	call   *%eax
  800afd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b00:	ff 4d e4             	decl   -0x1c(%ebp)
  800b03:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b07:	7f e7                	jg     800af0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b09:	e9 66 01 00 00       	jmp    800c74 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b0e:	83 ec 08             	sub    $0x8,%esp
  800b11:	ff 75 e8             	pushl  -0x18(%ebp)
  800b14:	8d 45 14             	lea    0x14(%ebp),%eax
  800b17:	50                   	push   %eax
  800b18:	e8 3c fd ff ff       	call   800859 <getint>
  800b1d:	83 c4 10             	add    $0x10,%esp
  800b20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b23:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b26:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b29:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b2c:	85 d2                	test   %edx,%edx
  800b2e:	79 23                	jns    800b53 <vprintfmt+0x29b>
				putch('-', putdat);
  800b30:	83 ec 08             	sub    $0x8,%esp
  800b33:	ff 75 0c             	pushl  0xc(%ebp)
  800b36:	6a 2d                	push   $0x2d
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	ff d0                	call   *%eax
  800b3d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b40:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b43:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b46:	f7 d8                	neg    %eax
  800b48:	83 d2 00             	adc    $0x0,%edx
  800b4b:	f7 da                	neg    %edx
  800b4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b50:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b53:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b5a:	e9 bc 00 00 00       	jmp    800c1b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b5f:	83 ec 08             	sub    $0x8,%esp
  800b62:	ff 75 e8             	pushl  -0x18(%ebp)
  800b65:	8d 45 14             	lea    0x14(%ebp),%eax
  800b68:	50                   	push   %eax
  800b69:	e8 84 fc ff ff       	call   8007f2 <getuint>
  800b6e:	83 c4 10             	add    $0x10,%esp
  800b71:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b74:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b77:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b7e:	e9 98 00 00 00       	jmp    800c1b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b83:	83 ec 08             	sub    $0x8,%esp
  800b86:	ff 75 0c             	pushl  0xc(%ebp)
  800b89:	6a 58                	push   $0x58
  800b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8e:	ff d0                	call   *%eax
  800b90:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b93:	83 ec 08             	sub    $0x8,%esp
  800b96:	ff 75 0c             	pushl  0xc(%ebp)
  800b99:	6a 58                	push   $0x58
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	ff d0                	call   *%eax
  800ba0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ba3:	83 ec 08             	sub    $0x8,%esp
  800ba6:	ff 75 0c             	pushl  0xc(%ebp)
  800ba9:	6a 58                	push   $0x58
  800bab:	8b 45 08             	mov    0x8(%ebp),%eax
  800bae:	ff d0                	call   *%eax
  800bb0:	83 c4 10             	add    $0x10,%esp
			break;
  800bb3:	e9 bc 00 00 00       	jmp    800c74 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800bb8:	83 ec 08             	sub    $0x8,%esp
  800bbb:	ff 75 0c             	pushl  0xc(%ebp)
  800bbe:	6a 30                	push   $0x30
  800bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc3:	ff d0                	call   *%eax
  800bc5:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800bc8:	83 ec 08             	sub    $0x8,%esp
  800bcb:	ff 75 0c             	pushl  0xc(%ebp)
  800bce:	6a 78                	push   $0x78
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	ff d0                	call   *%eax
  800bd5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800bd8:	8b 45 14             	mov    0x14(%ebp),%eax
  800bdb:	83 c0 04             	add    $0x4,%eax
  800bde:	89 45 14             	mov    %eax,0x14(%ebp)
  800be1:	8b 45 14             	mov    0x14(%ebp),%eax
  800be4:	83 e8 04             	sub    $0x4,%eax
  800be7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800be9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800bf3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800bfa:	eb 1f                	jmp    800c1b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800bfc:	83 ec 08             	sub    $0x8,%esp
  800bff:	ff 75 e8             	pushl  -0x18(%ebp)
  800c02:	8d 45 14             	lea    0x14(%ebp),%eax
  800c05:	50                   	push   %eax
  800c06:	e8 e7 fb ff ff       	call   8007f2 <getuint>
  800c0b:	83 c4 10             	add    $0x10,%esp
  800c0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c11:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c14:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c1b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c1f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c22:	83 ec 04             	sub    $0x4,%esp
  800c25:	52                   	push   %edx
  800c26:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c29:	50                   	push   %eax
  800c2a:	ff 75 f4             	pushl  -0xc(%ebp)
  800c2d:	ff 75 f0             	pushl  -0x10(%ebp)
  800c30:	ff 75 0c             	pushl  0xc(%ebp)
  800c33:	ff 75 08             	pushl  0x8(%ebp)
  800c36:	e8 00 fb ff ff       	call   80073b <printnum>
  800c3b:	83 c4 20             	add    $0x20,%esp
			break;
  800c3e:	eb 34                	jmp    800c74 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c40:	83 ec 08             	sub    $0x8,%esp
  800c43:	ff 75 0c             	pushl  0xc(%ebp)
  800c46:	53                   	push   %ebx
  800c47:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4a:	ff d0                	call   *%eax
  800c4c:	83 c4 10             	add    $0x10,%esp
			break;
  800c4f:	eb 23                	jmp    800c74 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c51:	83 ec 08             	sub    $0x8,%esp
  800c54:	ff 75 0c             	pushl  0xc(%ebp)
  800c57:	6a 25                	push   $0x25
  800c59:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5c:	ff d0                	call   *%eax
  800c5e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c61:	ff 4d 10             	decl   0x10(%ebp)
  800c64:	eb 03                	jmp    800c69 <vprintfmt+0x3b1>
  800c66:	ff 4d 10             	decl   0x10(%ebp)
  800c69:	8b 45 10             	mov    0x10(%ebp),%eax
  800c6c:	48                   	dec    %eax
  800c6d:	8a 00                	mov    (%eax),%al
  800c6f:	3c 25                	cmp    $0x25,%al
  800c71:	75 f3                	jne    800c66 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c73:	90                   	nop
		}
	}
  800c74:	e9 47 fc ff ff       	jmp    8008c0 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c79:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c7a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c7d:	5b                   	pop    %ebx
  800c7e:	5e                   	pop    %esi
  800c7f:	5d                   	pop    %ebp
  800c80:	c3                   	ret    

00800c81 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c81:	55                   	push   %ebp
  800c82:	89 e5                	mov    %esp,%ebp
  800c84:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c87:	8d 45 10             	lea    0x10(%ebp),%eax
  800c8a:	83 c0 04             	add    $0x4,%eax
  800c8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c90:	8b 45 10             	mov    0x10(%ebp),%eax
  800c93:	ff 75 f4             	pushl  -0xc(%ebp)
  800c96:	50                   	push   %eax
  800c97:	ff 75 0c             	pushl  0xc(%ebp)
  800c9a:	ff 75 08             	pushl  0x8(%ebp)
  800c9d:	e8 16 fc ff ff       	call   8008b8 <vprintfmt>
  800ca2:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ca5:	90                   	nop
  800ca6:	c9                   	leave  
  800ca7:	c3                   	ret    

00800ca8 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ca8:	55                   	push   %ebp
  800ca9:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800cab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cae:	8b 40 08             	mov    0x8(%eax),%eax
  800cb1:	8d 50 01             	lea    0x1(%eax),%edx
  800cb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb7:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800cba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbd:	8b 10                	mov    (%eax),%edx
  800cbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc2:	8b 40 04             	mov    0x4(%eax),%eax
  800cc5:	39 c2                	cmp    %eax,%edx
  800cc7:	73 12                	jae    800cdb <sprintputch+0x33>
		*b->buf++ = ch;
  800cc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ccc:	8b 00                	mov    (%eax),%eax
  800cce:	8d 48 01             	lea    0x1(%eax),%ecx
  800cd1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cd4:	89 0a                	mov    %ecx,(%edx)
  800cd6:	8b 55 08             	mov    0x8(%ebp),%edx
  800cd9:	88 10                	mov    %dl,(%eax)
}
  800cdb:	90                   	nop
  800cdc:	5d                   	pop    %ebp
  800cdd:	c3                   	ret    

00800cde <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800cde:	55                   	push   %ebp
  800cdf:	89 e5                	mov    %esp,%ebp
  800ce1:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800cea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ced:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	01 d0                	add    %edx,%eax
  800cf5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cf8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800cff:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d03:	74 06                	je     800d0b <vsnprintf+0x2d>
  800d05:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d09:	7f 07                	jg     800d12 <vsnprintf+0x34>
		return -E_INVAL;
  800d0b:	b8 03 00 00 00       	mov    $0x3,%eax
  800d10:	eb 20                	jmp    800d32 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d12:	ff 75 14             	pushl  0x14(%ebp)
  800d15:	ff 75 10             	pushl  0x10(%ebp)
  800d18:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d1b:	50                   	push   %eax
  800d1c:	68 a8 0c 80 00       	push   $0x800ca8
  800d21:	e8 92 fb ff ff       	call   8008b8 <vprintfmt>
  800d26:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d29:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d2c:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d32:	c9                   	leave  
  800d33:	c3                   	ret    

00800d34 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d34:	55                   	push   %ebp
  800d35:	89 e5                	mov    %esp,%ebp
  800d37:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d3a:	8d 45 10             	lea    0x10(%ebp),%eax
  800d3d:	83 c0 04             	add    $0x4,%eax
  800d40:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d43:	8b 45 10             	mov    0x10(%ebp),%eax
  800d46:	ff 75 f4             	pushl  -0xc(%ebp)
  800d49:	50                   	push   %eax
  800d4a:	ff 75 0c             	pushl  0xc(%ebp)
  800d4d:	ff 75 08             	pushl  0x8(%ebp)
  800d50:	e8 89 ff ff ff       	call   800cde <vsnprintf>
  800d55:	83 c4 10             	add    $0x10,%esp
  800d58:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d5e:	c9                   	leave  
  800d5f:	c3                   	ret    

00800d60 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d60:	55                   	push   %ebp
  800d61:	89 e5                	mov    %esp,%ebp
  800d63:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d66:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d6d:	eb 06                	jmp    800d75 <strlen+0x15>
		n++;
  800d6f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d72:	ff 45 08             	incl   0x8(%ebp)
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	8a 00                	mov    (%eax),%al
  800d7a:	84 c0                	test   %al,%al
  800d7c:	75 f1                	jne    800d6f <strlen+0xf>
		n++;
	return n;
  800d7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d81:	c9                   	leave  
  800d82:	c3                   	ret    

00800d83 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d83:	55                   	push   %ebp
  800d84:	89 e5                	mov    %esp,%ebp
  800d86:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d89:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d90:	eb 09                	jmp    800d9b <strnlen+0x18>
		n++;
  800d92:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d95:	ff 45 08             	incl   0x8(%ebp)
  800d98:	ff 4d 0c             	decl   0xc(%ebp)
  800d9b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d9f:	74 09                	je     800daa <strnlen+0x27>
  800da1:	8b 45 08             	mov    0x8(%ebp),%eax
  800da4:	8a 00                	mov    (%eax),%al
  800da6:	84 c0                	test   %al,%al
  800da8:	75 e8                	jne    800d92 <strnlen+0xf>
		n++;
	return n;
  800daa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dad:	c9                   	leave  
  800dae:	c3                   	ret    

00800daf <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800daf:	55                   	push   %ebp
  800db0:	89 e5                	mov    %esp,%ebp
  800db2:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800db5:	8b 45 08             	mov    0x8(%ebp),%eax
  800db8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800dbb:	90                   	nop
  800dbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbf:	8d 50 01             	lea    0x1(%eax),%edx
  800dc2:	89 55 08             	mov    %edx,0x8(%ebp)
  800dc5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dc8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dcb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800dce:	8a 12                	mov    (%edx),%dl
  800dd0:	88 10                	mov    %dl,(%eax)
  800dd2:	8a 00                	mov    (%eax),%al
  800dd4:	84 c0                	test   %al,%al
  800dd6:	75 e4                	jne    800dbc <strcpy+0xd>
		/* do nothing */;
	return ret;
  800dd8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ddb:	c9                   	leave  
  800ddc:	c3                   	ret    

00800ddd <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ddd:	55                   	push   %ebp
  800dde:	89 e5                	mov    %esp,%ebp
  800de0:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800de9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800df0:	eb 1f                	jmp    800e11 <strncpy+0x34>
		*dst++ = *src;
  800df2:	8b 45 08             	mov    0x8(%ebp),%eax
  800df5:	8d 50 01             	lea    0x1(%eax),%edx
  800df8:	89 55 08             	mov    %edx,0x8(%ebp)
  800dfb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dfe:	8a 12                	mov    (%edx),%dl
  800e00:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e05:	8a 00                	mov    (%eax),%al
  800e07:	84 c0                	test   %al,%al
  800e09:	74 03                	je     800e0e <strncpy+0x31>
			src++;
  800e0b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e0e:	ff 45 fc             	incl   -0x4(%ebp)
  800e11:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e14:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e17:	72 d9                	jb     800df2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e19:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e1c:	c9                   	leave  
  800e1d:	c3                   	ret    

00800e1e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e1e:	55                   	push   %ebp
  800e1f:	89 e5                	mov    %esp,%ebp
  800e21:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e24:	8b 45 08             	mov    0x8(%ebp),%eax
  800e27:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e2a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e2e:	74 30                	je     800e60 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e30:	eb 16                	jmp    800e48 <strlcpy+0x2a>
			*dst++ = *src++;
  800e32:	8b 45 08             	mov    0x8(%ebp),%eax
  800e35:	8d 50 01             	lea    0x1(%eax),%edx
  800e38:	89 55 08             	mov    %edx,0x8(%ebp)
  800e3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e3e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e41:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e44:	8a 12                	mov    (%edx),%dl
  800e46:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e48:	ff 4d 10             	decl   0x10(%ebp)
  800e4b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e4f:	74 09                	je     800e5a <strlcpy+0x3c>
  800e51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e54:	8a 00                	mov    (%eax),%al
  800e56:	84 c0                	test   %al,%al
  800e58:	75 d8                	jne    800e32 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e60:	8b 55 08             	mov    0x8(%ebp),%edx
  800e63:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e66:	29 c2                	sub    %eax,%edx
  800e68:	89 d0                	mov    %edx,%eax
}
  800e6a:	c9                   	leave  
  800e6b:	c3                   	ret    

00800e6c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e6c:	55                   	push   %ebp
  800e6d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e6f:	eb 06                	jmp    800e77 <strcmp+0xb>
		p++, q++;
  800e71:	ff 45 08             	incl   0x8(%ebp)
  800e74:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e77:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7a:	8a 00                	mov    (%eax),%al
  800e7c:	84 c0                	test   %al,%al
  800e7e:	74 0e                	je     800e8e <strcmp+0x22>
  800e80:	8b 45 08             	mov    0x8(%ebp),%eax
  800e83:	8a 10                	mov    (%eax),%dl
  800e85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e88:	8a 00                	mov    (%eax),%al
  800e8a:	38 c2                	cmp    %al,%dl
  800e8c:	74 e3                	je     800e71 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e91:	8a 00                	mov    (%eax),%al
  800e93:	0f b6 d0             	movzbl %al,%edx
  800e96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e99:	8a 00                	mov    (%eax),%al
  800e9b:	0f b6 c0             	movzbl %al,%eax
  800e9e:	29 c2                	sub    %eax,%edx
  800ea0:	89 d0                	mov    %edx,%eax
}
  800ea2:	5d                   	pop    %ebp
  800ea3:	c3                   	ret    

00800ea4 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ea4:	55                   	push   %ebp
  800ea5:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ea7:	eb 09                	jmp    800eb2 <strncmp+0xe>
		n--, p++, q++;
  800ea9:	ff 4d 10             	decl   0x10(%ebp)
  800eac:	ff 45 08             	incl   0x8(%ebp)
  800eaf:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800eb2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eb6:	74 17                	je     800ecf <strncmp+0x2b>
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	8a 00                	mov    (%eax),%al
  800ebd:	84 c0                	test   %al,%al
  800ebf:	74 0e                	je     800ecf <strncmp+0x2b>
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	8a 10                	mov    (%eax),%dl
  800ec6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec9:	8a 00                	mov    (%eax),%al
  800ecb:	38 c2                	cmp    %al,%dl
  800ecd:	74 da                	je     800ea9 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ecf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed3:	75 07                	jne    800edc <strncmp+0x38>
		return 0;
  800ed5:	b8 00 00 00 00       	mov    $0x0,%eax
  800eda:	eb 14                	jmp    800ef0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800edc:	8b 45 08             	mov    0x8(%ebp),%eax
  800edf:	8a 00                	mov    (%eax),%al
  800ee1:	0f b6 d0             	movzbl %al,%edx
  800ee4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee7:	8a 00                	mov    (%eax),%al
  800ee9:	0f b6 c0             	movzbl %al,%eax
  800eec:	29 c2                	sub    %eax,%edx
  800eee:	89 d0                	mov    %edx,%eax
}
  800ef0:	5d                   	pop    %ebp
  800ef1:	c3                   	ret    

00800ef2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ef2:	55                   	push   %ebp
  800ef3:	89 e5                	mov    %esp,%ebp
  800ef5:	83 ec 04             	sub    $0x4,%esp
  800ef8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800efe:	eb 12                	jmp    800f12 <strchr+0x20>
		if (*s == c)
  800f00:	8b 45 08             	mov    0x8(%ebp),%eax
  800f03:	8a 00                	mov    (%eax),%al
  800f05:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f08:	75 05                	jne    800f0f <strchr+0x1d>
			return (char *) s;
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	eb 11                	jmp    800f20 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f0f:	ff 45 08             	incl   0x8(%ebp)
  800f12:	8b 45 08             	mov    0x8(%ebp),%eax
  800f15:	8a 00                	mov    (%eax),%al
  800f17:	84 c0                	test   %al,%al
  800f19:	75 e5                	jne    800f00 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f1b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f20:	c9                   	leave  
  800f21:	c3                   	ret    

00800f22 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f22:	55                   	push   %ebp
  800f23:	89 e5                	mov    %esp,%ebp
  800f25:	83 ec 04             	sub    $0x4,%esp
  800f28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f2e:	eb 0d                	jmp    800f3d <strfind+0x1b>
		if (*s == c)
  800f30:	8b 45 08             	mov    0x8(%ebp),%eax
  800f33:	8a 00                	mov    (%eax),%al
  800f35:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f38:	74 0e                	je     800f48 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f3a:	ff 45 08             	incl   0x8(%ebp)
  800f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f40:	8a 00                	mov    (%eax),%al
  800f42:	84 c0                	test   %al,%al
  800f44:	75 ea                	jne    800f30 <strfind+0xe>
  800f46:	eb 01                	jmp    800f49 <strfind+0x27>
		if (*s == c)
			break;
  800f48:	90                   	nop
	return (char *) s;
  800f49:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f4c:	c9                   	leave  
  800f4d:	c3                   	ret    

00800f4e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f4e:	55                   	push   %ebp
  800f4f:	89 e5                	mov    %esp,%ebp
  800f51:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f54:	8b 45 08             	mov    0x8(%ebp),%eax
  800f57:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f60:	eb 0e                	jmp    800f70 <memset+0x22>
		*p++ = c;
  800f62:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f65:	8d 50 01             	lea    0x1(%eax),%edx
  800f68:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f6e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f70:	ff 4d f8             	decl   -0x8(%ebp)
  800f73:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f77:	79 e9                	jns    800f62 <memset+0x14>
		*p++ = c;

	return v;
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f7c:	c9                   	leave  
  800f7d:	c3                   	ret    

00800f7e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f7e:	55                   	push   %ebp
  800f7f:	89 e5                	mov    %esp,%ebp
  800f81:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f87:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f90:	eb 16                	jmp    800fa8 <memcpy+0x2a>
		*d++ = *s++;
  800f92:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f95:	8d 50 01             	lea    0x1(%eax),%edx
  800f98:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f9b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f9e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fa1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fa4:	8a 12                	mov    (%edx),%dl
  800fa6:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800fa8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fab:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fae:	89 55 10             	mov    %edx,0x10(%ebp)
  800fb1:	85 c0                	test   %eax,%eax
  800fb3:	75 dd                	jne    800f92 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fb8:	c9                   	leave  
  800fb9:	c3                   	ret    

00800fba <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fba:	55                   	push   %ebp
  800fbb:	89 e5                	mov    %esp,%ebp
  800fbd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800fcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fcf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fd2:	73 50                	jae    801024 <memmove+0x6a>
  800fd4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fd7:	8b 45 10             	mov    0x10(%ebp),%eax
  800fda:	01 d0                	add    %edx,%eax
  800fdc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fdf:	76 43                	jbe    801024 <memmove+0x6a>
		s += n;
  800fe1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800fe7:	8b 45 10             	mov    0x10(%ebp),%eax
  800fea:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800fed:	eb 10                	jmp    800fff <memmove+0x45>
			*--d = *--s;
  800fef:	ff 4d f8             	decl   -0x8(%ebp)
  800ff2:	ff 4d fc             	decl   -0x4(%ebp)
  800ff5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ff8:	8a 10                	mov    (%eax),%dl
  800ffa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ffd:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fff:	8b 45 10             	mov    0x10(%ebp),%eax
  801002:	8d 50 ff             	lea    -0x1(%eax),%edx
  801005:	89 55 10             	mov    %edx,0x10(%ebp)
  801008:	85 c0                	test   %eax,%eax
  80100a:	75 e3                	jne    800fef <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80100c:	eb 23                	jmp    801031 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80100e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801011:	8d 50 01             	lea    0x1(%eax),%edx
  801014:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801017:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80101a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80101d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801020:	8a 12                	mov    (%edx),%dl
  801022:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801024:	8b 45 10             	mov    0x10(%ebp),%eax
  801027:	8d 50 ff             	lea    -0x1(%eax),%edx
  80102a:	89 55 10             	mov    %edx,0x10(%ebp)
  80102d:	85 c0                	test   %eax,%eax
  80102f:	75 dd                	jne    80100e <memmove+0x54>
			*d++ = *s++;

	return dst;
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801034:	c9                   	leave  
  801035:	c3                   	ret    

00801036 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801036:	55                   	push   %ebp
  801037:	89 e5                	mov    %esp,%ebp
  801039:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80103c:	8b 45 08             	mov    0x8(%ebp),%eax
  80103f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801042:	8b 45 0c             	mov    0xc(%ebp),%eax
  801045:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801048:	eb 2a                	jmp    801074 <memcmp+0x3e>
		if (*s1 != *s2)
  80104a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80104d:	8a 10                	mov    (%eax),%dl
  80104f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801052:	8a 00                	mov    (%eax),%al
  801054:	38 c2                	cmp    %al,%dl
  801056:	74 16                	je     80106e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801058:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80105b:	8a 00                	mov    (%eax),%al
  80105d:	0f b6 d0             	movzbl %al,%edx
  801060:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801063:	8a 00                	mov    (%eax),%al
  801065:	0f b6 c0             	movzbl %al,%eax
  801068:	29 c2                	sub    %eax,%edx
  80106a:	89 d0                	mov    %edx,%eax
  80106c:	eb 18                	jmp    801086 <memcmp+0x50>
		s1++, s2++;
  80106e:	ff 45 fc             	incl   -0x4(%ebp)
  801071:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801074:	8b 45 10             	mov    0x10(%ebp),%eax
  801077:	8d 50 ff             	lea    -0x1(%eax),%edx
  80107a:	89 55 10             	mov    %edx,0x10(%ebp)
  80107d:	85 c0                	test   %eax,%eax
  80107f:	75 c9                	jne    80104a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801081:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801086:	c9                   	leave  
  801087:	c3                   	ret    

00801088 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801088:	55                   	push   %ebp
  801089:	89 e5                	mov    %esp,%ebp
  80108b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80108e:	8b 55 08             	mov    0x8(%ebp),%edx
  801091:	8b 45 10             	mov    0x10(%ebp),%eax
  801094:	01 d0                	add    %edx,%eax
  801096:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801099:	eb 15                	jmp    8010b0 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80109b:	8b 45 08             	mov    0x8(%ebp),%eax
  80109e:	8a 00                	mov    (%eax),%al
  8010a0:	0f b6 d0             	movzbl %al,%edx
  8010a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a6:	0f b6 c0             	movzbl %al,%eax
  8010a9:	39 c2                	cmp    %eax,%edx
  8010ab:	74 0d                	je     8010ba <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010ad:	ff 45 08             	incl   0x8(%ebp)
  8010b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010b6:	72 e3                	jb     80109b <memfind+0x13>
  8010b8:	eb 01                	jmp    8010bb <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010ba:	90                   	nop
	return (void *) s;
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010be:	c9                   	leave  
  8010bf:	c3                   	ret    

008010c0 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010c0:	55                   	push   %ebp
  8010c1:	89 e5                	mov    %esp,%ebp
  8010c3:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010cd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010d4:	eb 03                	jmp    8010d9 <strtol+0x19>
		s++;
  8010d6:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010dc:	8a 00                	mov    (%eax),%al
  8010de:	3c 20                	cmp    $0x20,%al
  8010e0:	74 f4                	je     8010d6 <strtol+0x16>
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	8a 00                	mov    (%eax),%al
  8010e7:	3c 09                	cmp    $0x9,%al
  8010e9:	74 eb                	je     8010d6 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	8a 00                	mov    (%eax),%al
  8010f0:	3c 2b                	cmp    $0x2b,%al
  8010f2:	75 05                	jne    8010f9 <strtol+0x39>
		s++;
  8010f4:	ff 45 08             	incl   0x8(%ebp)
  8010f7:	eb 13                	jmp    80110c <strtol+0x4c>
	else if (*s == '-')
  8010f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fc:	8a 00                	mov    (%eax),%al
  8010fe:	3c 2d                	cmp    $0x2d,%al
  801100:	75 0a                	jne    80110c <strtol+0x4c>
		s++, neg = 1;
  801102:	ff 45 08             	incl   0x8(%ebp)
  801105:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80110c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801110:	74 06                	je     801118 <strtol+0x58>
  801112:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801116:	75 20                	jne    801138 <strtol+0x78>
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
  80111b:	8a 00                	mov    (%eax),%al
  80111d:	3c 30                	cmp    $0x30,%al
  80111f:	75 17                	jne    801138 <strtol+0x78>
  801121:	8b 45 08             	mov    0x8(%ebp),%eax
  801124:	40                   	inc    %eax
  801125:	8a 00                	mov    (%eax),%al
  801127:	3c 78                	cmp    $0x78,%al
  801129:	75 0d                	jne    801138 <strtol+0x78>
		s += 2, base = 16;
  80112b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80112f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801136:	eb 28                	jmp    801160 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801138:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80113c:	75 15                	jne    801153 <strtol+0x93>
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	8a 00                	mov    (%eax),%al
  801143:	3c 30                	cmp    $0x30,%al
  801145:	75 0c                	jne    801153 <strtol+0x93>
		s++, base = 8;
  801147:	ff 45 08             	incl   0x8(%ebp)
  80114a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801151:	eb 0d                	jmp    801160 <strtol+0xa0>
	else if (base == 0)
  801153:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801157:	75 07                	jne    801160 <strtol+0xa0>
		base = 10;
  801159:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801160:	8b 45 08             	mov    0x8(%ebp),%eax
  801163:	8a 00                	mov    (%eax),%al
  801165:	3c 2f                	cmp    $0x2f,%al
  801167:	7e 19                	jle    801182 <strtol+0xc2>
  801169:	8b 45 08             	mov    0x8(%ebp),%eax
  80116c:	8a 00                	mov    (%eax),%al
  80116e:	3c 39                	cmp    $0x39,%al
  801170:	7f 10                	jg     801182 <strtol+0xc2>
			dig = *s - '0';
  801172:	8b 45 08             	mov    0x8(%ebp),%eax
  801175:	8a 00                	mov    (%eax),%al
  801177:	0f be c0             	movsbl %al,%eax
  80117a:	83 e8 30             	sub    $0x30,%eax
  80117d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801180:	eb 42                	jmp    8011c4 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801182:	8b 45 08             	mov    0x8(%ebp),%eax
  801185:	8a 00                	mov    (%eax),%al
  801187:	3c 60                	cmp    $0x60,%al
  801189:	7e 19                	jle    8011a4 <strtol+0xe4>
  80118b:	8b 45 08             	mov    0x8(%ebp),%eax
  80118e:	8a 00                	mov    (%eax),%al
  801190:	3c 7a                	cmp    $0x7a,%al
  801192:	7f 10                	jg     8011a4 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801194:	8b 45 08             	mov    0x8(%ebp),%eax
  801197:	8a 00                	mov    (%eax),%al
  801199:	0f be c0             	movsbl %al,%eax
  80119c:	83 e8 57             	sub    $0x57,%eax
  80119f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011a2:	eb 20                	jmp    8011c4 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	8a 00                	mov    (%eax),%al
  8011a9:	3c 40                	cmp    $0x40,%al
  8011ab:	7e 39                	jle    8011e6 <strtol+0x126>
  8011ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b0:	8a 00                	mov    (%eax),%al
  8011b2:	3c 5a                	cmp    $0x5a,%al
  8011b4:	7f 30                	jg     8011e6 <strtol+0x126>
			dig = *s - 'A' + 10;
  8011b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b9:	8a 00                	mov    (%eax),%al
  8011bb:	0f be c0             	movsbl %al,%eax
  8011be:	83 e8 37             	sub    $0x37,%eax
  8011c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011c7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011ca:	7d 19                	jge    8011e5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011cc:	ff 45 08             	incl   0x8(%ebp)
  8011cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011d2:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011d6:	89 c2                	mov    %eax,%edx
  8011d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011db:	01 d0                	add    %edx,%eax
  8011dd:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011e0:	e9 7b ff ff ff       	jmp    801160 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011e5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011ea:	74 08                	je     8011f4 <strtol+0x134>
		*endptr = (char *) s;
  8011ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ef:	8b 55 08             	mov    0x8(%ebp),%edx
  8011f2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011f4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011f8:	74 07                	je     801201 <strtol+0x141>
  8011fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011fd:	f7 d8                	neg    %eax
  8011ff:	eb 03                	jmp    801204 <strtol+0x144>
  801201:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801204:	c9                   	leave  
  801205:	c3                   	ret    

00801206 <ltostr>:

void
ltostr(long value, char *str)
{
  801206:	55                   	push   %ebp
  801207:	89 e5                	mov    %esp,%ebp
  801209:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80120c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801213:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80121a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80121e:	79 13                	jns    801233 <ltostr+0x2d>
	{
		neg = 1;
  801220:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801227:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122a:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80122d:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801230:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801233:	8b 45 08             	mov    0x8(%ebp),%eax
  801236:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80123b:	99                   	cltd   
  80123c:	f7 f9                	idiv   %ecx
  80123e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801241:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801244:	8d 50 01             	lea    0x1(%eax),%edx
  801247:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80124a:	89 c2                	mov    %eax,%edx
  80124c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124f:	01 d0                	add    %edx,%eax
  801251:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801254:	83 c2 30             	add    $0x30,%edx
  801257:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801259:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80125c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801261:	f7 e9                	imul   %ecx
  801263:	c1 fa 02             	sar    $0x2,%edx
  801266:	89 c8                	mov    %ecx,%eax
  801268:	c1 f8 1f             	sar    $0x1f,%eax
  80126b:	29 c2                	sub    %eax,%edx
  80126d:	89 d0                	mov    %edx,%eax
  80126f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801272:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801275:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80127a:	f7 e9                	imul   %ecx
  80127c:	c1 fa 02             	sar    $0x2,%edx
  80127f:	89 c8                	mov    %ecx,%eax
  801281:	c1 f8 1f             	sar    $0x1f,%eax
  801284:	29 c2                	sub    %eax,%edx
  801286:	89 d0                	mov    %edx,%eax
  801288:	c1 e0 02             	shl    $0x2,%eax
  80128b:	01 d0                	add    %edx,%eax
  80128d:	01 c0                	add    %eax,%eax
  80128f:	29 c1                	sub    %eax,%ecx
  801291:	89 ca                	mov    %ecx,%edx
  801293:	85 d2                	test   %edx,%edx
  801295:	75 9c                	jne    801233 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801297:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80129e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a1:	48                   	dec    %eax
  8012a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012a5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012a9:	74 3d                	je     8012e8 <ltostr+0xe2>
		start = 1 ;
  8012ab:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012b2:	eb 34                	jmp    8012e8 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8012b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ba:	01 d0                	add    %edx,%eax
  8012bc:	8a 00                	mov    (%eax),%al
  8012be:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c7:	01 c2                	add    %eax,%edx
  8012c9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cf:	01 c8                	add    %ecx,%eax
  8012d1:	8a 00                	mov    (%eax),%al
  8012d3:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012d5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012db:	01 c2                	add    %eax,%edx
  8012dd:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012e0:	88 02                	mov    %al,(%edx)
		start++ ;
  8012e2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012e5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012eb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012ee:	7c c4                	jl     8012b4 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012f0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f6:	01 d0                	add    %edx,%eax
  8012f8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012fb:	90                   	nop
  8012fc:	c9                   	leave  
  8012fd:	c3                   	ret    

008012fe <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012fe:	55                   	push   %ebp
  8012ff:	89 e5                	mov    %esp,%ebp
  801301:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801304:	ff 75 08             	pushl  0x8(%ebp)
  801307:	e8 54 fa ff ff       	call   800d60 <strlen>
  80130c:	83 c4 04             	add    $0x4,%esp
  80130f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801312:	ff 75 0c             	pushl  0xc(%ebp)
  801315:	e8 46 fa ff ff       	call   800d60 <strlen>
  80131a:	83 c4 04             	add    $0x4,%esp
  80131d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801320:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801327:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80132e:	eb 17                	jmp    801347 <strcconcat+0x49>
		final[s] = str1[s] ;
  801330:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801333:	8b 45 10             	mov    0x10(%ebp),%eax
  801336:	01 c2                	add    %eax,%edx
  801338:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80133b:	8b 45 08             	mov    0x8(%ebp),%eax
  80133e:	01 c8                	add    %ecx,%eax
  801340:	8a 00                	mov    (%eax),%al
  801342:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801344:	ff 45 fc             	incl   -0x4(%ebp)
  801347:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80134a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80134d:	7c e1                	jl     801330 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80134f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801356:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80135d:	eb 1f                	jmp    80137e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80135f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801362:	8d 50 01             	lea    0x1(%eax),%edx
  801365:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801368:	89 c2                	mov    %eax,%edx
  80136a:	8b 45 10             	mov    0x10(%ebp),%eax
  80136d:	01 c2                	add    %eax,%edx
  80136f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801372:	8b 45 0c             	mov    0xc(%ebp),%eax
  801375:	01 c8                	add    %ecx,%eax
  801377:	8a 00                	mov    (%eax),%al
  801379:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80137b:	ff 45 f8             	incl   -0x8(%ebp)
  80137e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801381:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801384:	7c d9                	jl     80135f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801386:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801389:	8b 45 10             	mov    0x10(%ebp),%eax
  80138c:	01 d0                	add    %edx,%eax
  80138e:	c6 00 00             	movb   $0x0,(%eax)
}
  801391:	90                   	nop
  801392:	c9                   	leave  
  801393:	c3                   	ret    

00801394 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801394:	55                   	push   %ebp
  801395:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801397:	8b 45 14             	mov    0x14(%ebp),%eax
  80139a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8013a3:	8b 00                	mov    (%eax),%eax
  8013a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8013af:	01 d0                	add    %edx,%eax
  8013b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013b7:	eb 0c                	jmp    8013c5 <strsplit+0x31>
			*string++ = 0;
  8013b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bc:	8d 50 01             	lea    0x1(%eax),%edx
  8013bf:	89 55 08             	mov    %edx,0x8(%ebp)
  8013c2:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c8:	8a 00                	mov    (%eax),%al
  8013ca:	84 c0                	test   %al,%al
  8013cc:	74 18                	je     8013e6 <strsplit+0x52>
  8013ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d1:	8a 00                	mov    (%eax),%al
  8013d3:	0f be c0             	movsbl %al,%eax
  8013d6:	50                   	push   %eax
  8013d7:	ff 75 0c             	pushl  0xc(%ebp)
  8013da:	e8 13 fb ff ff       	call   800ef2 <strchr>
  8013df:	83 c4 08             	add    $0x8,%esp
  8013e2:	85 c0                	test   %eax,%eax
  8013e4:	75 d3                	jne    8013b9 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8013e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e9:	8a 00                	mov    (%eax),%al
  8013eb:	84 c0                	test   %al,%al
  8013ed:	74 5a                	je     801449 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8013ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8013f2:	8b 00                	mov    (%eax),%eax
  8013f4:	83 f8 0f             	cmp    $0xf,%eax
  8013f7:	75 07                	jne    801400 <strsplit+0x6c>
		{
			return 0;
  8013f9:	b8 00 00 00 00       	mov    $0x0,%eax
  8013fe:	eb 66                	jmp    801466 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801400:	8b 45 14             	mov    0x14(%ebp),%eax
  801403:	8b 00                	mov    (%eax),%eax
  801405:	8d 48 01             	lea    0x1(%eax),%ecx
  801408:	8b 55 14             	mov    0x14(%ebp),%edx
  80140b:	89 0a                	mov    %ecx,(%edx)
  80140d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801414:	8b 45 10             	mov    0x10(%ebp),%eax
  801417:	01 c2                	add    %eax,%edx
  801419:	8b 45 08             	mov    0x8(%ebp),%eax
  80141c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80141e:	eb 03                	jmp    801423 <strsplit+0x8f>
			string++;
  801420:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801423:	8b 45 08             	mov    0x8(%ebp),%eax
  801426:	8a 00                	mov    (%eax),%al
  801428:	84 c0                	test   %al,%al
  80142a:	74 8b                	je     8013b7 <strsplit+0x23>
  80142c:	8b 45 08             	mov    0x8(%ebp),%eax
  80142f:	8a 00                	mov    (%eax),%al
  801431:	0f be c0             	movsbl %al,%eax
  801434:	50                   	push   %eax
  801435:	ff 75 0c             	pushl  0xc(%ebp)
  801438:	e8 b5 fa ff ff       	call   800ef2 <strchr>
  80143d:	83 c4 08             	add    $0x8,%esp
  801440:	85 c0                	test   %eax,%eax
  801442:	74 dc                	je     801420 <strsplit+0x8c>
			string++;
	}
  801444:	e9 6e ff ff ff       	jmp    8013b7 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801449:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80144a:	8b 45 14             	mov    0x14(%ebp),%eax
  80144d:	8b 00                	mov    (%eax),%eax
  80144f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801456:	8b 45 10             	mov    0x10(%ebp),%eax
  801459:	01 d0                	add    %edx,%eax
  80145b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801461:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801466:	c9                   	leave  
  801467:	c3                   	ret    

00801468 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801468:	55                   	push   %ebp
  801469:	89 e5                	mov    %esp,%ebp
  80146b:	57                   	push   %edi
  80146c:	56                   	push   %esi
  80146d:	53                   	push   %ebx
  80146e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801471:	8b 45 08             	mov    0x8(%ebp),%eax
  801474:	8b 55 0c             	mov    0xc(%ebp),%edx
  801477:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80147a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80147d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801480:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801483:	cd 30                	int    $0x30
  801485:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801488:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80148b:	83 c4 10             	add    $0x10,%esp
  80148e:	5b                   	pop    %ebx
  80148f:	5e                   	pop    %esi
  801490:	5f                   	pop    %edi
  801491:	5d                   	pop    %ebp
  801492:	c3                   	ret    

00801493 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801493:	55                   	push   %ebp
  801494:	89 e5                	mov    %esp,%ebp
  801496:	83 ec 04             	sub    $0x4,%esp
  801499:	8b 45 10             	mov    0x10(%ebp),%eax
  80149c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80149f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	52                   	push   %edx
  8014ab:	ff 75 0c             	pushl  0xc(%ebp)
  8014ae:	50                   	push   %eax
  8014af:	6a 00                	push   $0x0
  8014b1:	e8 b2 ff ff ff       	call   801468 <syscall>
  8014b6:	83 c4 18             	add    $0x18,%esp
}
  8014b9:	90                   	nop
  8014ba:	c9                   	leave  
  8014bb:	c3                   	ret    

008014bc <sys_cgetc>:

int
sys_cgetc(void)
{
  8014bc:	55                   	push   %ebp
  8014bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 01                	push   $0x1
  8014cb:	e8 98 ff ff ff       	call   801468 <syscall>
  8014d0:	83 c4 18             	add    $0x18,%esp
}
  8014d3:	c9                   	leave  
  8014d4:	c3                   	ret    

008014d5 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8014d5:	55                   	push   %ebp
  8014d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	50                   	push   %eax
  8014e4:	6a 05                	push   $0x5
  8014e6:	e8 7d ff ff ff       	call   801468 <syscall>
  8014eb:	83 c4 18             	add    $0x18,%esp
}
  8014ee:	c9                   	leave  
  8014ef:	c3                   	ret    

008014f0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8014f0:	55                   	push   %ebp
  8014f1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 02                	push   $0x2
  8014ff:	e8 64 ff ff ff       	call   801468 <syscall>
  801504:	83 c4 18             	add    $0x18,%esp
}
  801507:	c9                   	leave  
  801508:	c3                   	ret    

00801509 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801509:	55                   	push   %ebp
  80150a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80150c:	6a 00                	push   $0x0
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 03                	push   $0x3
  801518:	e8 4b ff ff ff       	call   801468 <syscall>
  80151d:	83 c4 18             	add    $0x18,%esp
}
  801520:	c9                   	leave  
  801521:	c3                   	ret    

00801522 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801522:	55                   	push   %ebp
  801523:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	6a 04                	push   $0x4
  801531:	e8 32 ff ff ff       	call   801468 <syscall>
  801536:	83 c4 18             	add    $0x18,%esp
}
  801539:	c9                   	leave  
  80153a:	c3                   	ret    

0080153b <sys_env_exit>:


void sys_env_exit(void)
{
  80153b:	55                   	push   %ebp
  80153c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80153e:	6a 00                	push   $0x0
  801540:	6a 00                	push   $0x0
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	6a 06                	push   $0x6
  80154a:	e8 19 ff ff ff       	call   801468 <syscall>
  80154f:	83 c4 18             	add    $0x18,%esp
}
  801552:	90                   	nop
  801553:	c9                   	leave  
  801554:	c3                   	ret    

00801555 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801555:	55                   	push   %ebp
  801556:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801558:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155b:	8b 45 08             	mov    0x8(%ebp),%eax
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	52                   	push   %edx
  801565:	50                   	push   %eax
  801566:	6a 07                	push   $0x7
  801568:	e8 fb fe ff ff       	call   801468 <syscall>
  80156d:	83 c4 18             	add    $0x18,%esp
}
  801570:	c9                   	leave  
  801571:	c3                   	ret    

00801572 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801572:	55                   	push   %ebp
  801573:	89 e5                	mov    %esp,%ebp
  801575:	56                   	push   %esi
  801576:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801577:	8b 75 18             	mov    0x18(%ebp),%esi
  80157a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80157d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801580:	8b 55 0c             	mov    0xc(%ebp),%edx
  801583:	8b 45 08             	mov    0x8(%ebp),%eax
  801586:	56                   	push   %esi
  801587:	53                   	push   %ebx
  801588:	51                   	push   %ecx
  801589:	52                   	push   %edx
  80158a:	50                   	push   %eax
  80158b:	6a 08                	push   $0x8
  80158d:	e8 d6 fe ff ff       	call   801468 <syscall>
  801592:	83 c4 18             	add    $0x18,%esp
}
  801595:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801598:	5b                   	pop    %ebx
  801599:	5e                   	pop    %esi
  80159a:	5d                   	pop    %ebp
  80159b:	c3                   	ret    

0080159c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80159c:	55                   	push   %ebp
  80159d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80159f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	52                   	push   %edx
  8015ac:	50                   	push   %eax
  8015ad:	6a 09                	push   $0x9
  8015af:	e8 b4 fe ff ff       	call   801468 <syscall>
  8015b4:	83 c4 18             	add    $0x18,%esp
}
  8015b7:	c9                   	leave  
  8015b8:	c3                   	ret    

008015b9 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	ff 75 0c             	pushl  0xc(%ebp)
  8015c5:	ff 75 08             	pushl  0x8(%ebp)
  8015c8:	6a 0a                	push   $0xa
  8015ca:	e8 99 fe ff ff       	call   801468 <syscall>
  8015cf:	83 c4 18             	add    $0x18,%esp
}
  8015d2:	c9                   	leave  
  8015d3:	c3                   	ret    

008015d4 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015d4:	55                   	push   %ebp
  8015d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 0b                	push   $0xb
  8015e3:	e8 80 fe ff ff       	call   801468 <syscall>
  8015e8:	83 c4 18             	add    $0x18,%esp
}
  8015eb:	c9                   	leave  
  8015ec:	c3                   	ret    

008015ed <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015ed:	55                   	push   %ebp
  8015ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 0c                	push   $0xc
  8015fc:	e8 67 fe ff ff       	call   801468 <syscall>
  801601:	83 c4 18             	add    $0x18,%esp
}
  801604:	c9                   	leave  
  801605:	c3                   	ret    

00801606 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801606:	55                   	push   %ebp
  801607:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 0d                	push   $0xd
  801615:	e8 4e fe ff ff       	call   801468 <syscall>
  80161a:	83 c4 18             	add    $0x18,%esp
}
  80161d:	c9                   	leave  
  80161e:	c3                   	ret    

0080161f <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80161f:	55                   	push   %ebp
  801620:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801622:	6a 00                	push   $0x0
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	ff 75 0c             	pushl  0xc(%ebp)
  80162b:	ff 75 08             	pushl  0x8(%ebp)
  80162e:	6a 11                	push   $0x11
  801630:	e8 33 fe ff ff       	call   801468 <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
	return;
  801638:	90                   	nop
}
  801639:	c9                   	leave  
  80163a:	c3                   	ret    

0080163b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80163b:	55                   	push   %ebp
  80163c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	ff 75 0c             	pushl  0xc(%ebp)
  801647:	ff 75 08             	pushl  0x8(%ebp)
  80164a:	6a 12                	push   $0x12
  80164c:	e8 17 fe ff ff       	call   801468 <syscall>
  801651:	83 c4 18             	add    $0x18,%esp
	return ;
  801654:	90                   	nop
}
  801655:	c9                   	leave  
  801656:	c3                   	ret    

00801657 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801657:	55                   	push   %ebp
  801658:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 0e                	push   $0xe
  801666:	e8 fd fd ff ff       	call   801468 <syscall>
  80166b:	83 c4 18             	add    $0x18,%esp
}
  80166e:	c9                   	leave  
  80166f:	c3                   	ret    

00801670 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801670:	55                   	push   %ebp
  801671:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	ff 75 08             	pushl  0x8(%ebp)
  80167e:	6a 0f                	push   $0xf
  801680:	e8 e3 fd ff ff       	call   801468 <syscall>
  801685:	83 c4 18             	add    $0x18,%esp
}
  801688:	c9                   	leave  
  801689:	c3                   	ret    

0080168a <sys_scarce_memory>:

void sys_scarce_memory()
{
  80168a:	55                   	push   %ebp
  80168b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 10                	push   $0x10
  801699:	e8 ca fd ff ff       	call   801468 <syscall>
  80169e:	83 c4 18             	add    $0x18,%esp
}
  8016a1:	90                   	nop
  8016a2:	c9                   	leave  
  8016a3:	c3                   	ret    

008016a4 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8016a4:	55                   	push   %ebp
  8016a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 14                	push   $0x14
  8016b3:	e8 b0 fd ff ff       	call   801468 <syscall>
  8016b8:	83 c4 18             	add    $0x18,%esp
}
  8016bb:	90                   	nop
  8016bc:	c9                   	leave  
  8016bd:	c3                   	ret    

008016be <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8016be:	55                   	push   %ebp
  8016bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 15                	push   $0x15
  8016cd:	e8 96 fd ff ff       	call   801468 <syscall>
  8016d2:	83 c4 18             	add    $0x18,%esp
}
  8016d5:	90                   	nop
  8016d6:	c9                   	leave  
  8016d7:	c3                   	ret    

008016d8 <sys_cputc>:


void
sys_cputc(const char c)
{
  8016d8:	55                   	push   %ebp
  8016d9:	89 e5                	mov    %esp,%ebp
  8016db:	83 ec 04             	sub    $0x4,%esp
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016e4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	50                   	push   %eax
  8016f1:	6a 16                	push   $0x16
  8016f3:	e8 70 fd ff ff       	call   801468 <syscall>
  8016f8:	83 c4 18             	add    $0x18,%esp
}
  8016fb:	90                   	nop
  8016fc:	c9                   	leave  
  8016fd:	c3                   	ret    

008016fe <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016fe:	55                   	push   %ebp
  8016ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	6a 00                	push   $0x0
  80170b:	6a 17                	push   $0x17
  80170d:	e8 56 fd ff ff       	call   801468 <syscall>
  801712:	83 c4 18             	add    $0x18,%esp
}
  801715:	90                   	nop
  801716:	c9                   	leave  
  801717:	c3                   	ret    

00801718 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80171b:	8b 45 08             	mov    0x8(%ebp),%eax
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	ff 75 0c             	pushl  0xc(%ebp)
  801727:	50                   	push   %eax
  801728:	6a 18                	push   $0x18
  80172a:	e8 39 fd ff ff       	call   801468 <syscall>
  80172f:	83 c4 18             	add    $0x18,%esp
}
  801732:	c9                   	leave  
  801733:	c3                   	ret    

00801734 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801734:	55                   	push   %ebp
  801735:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801737:	8b 55 0c             	mov    0xc(%ebp),%edx
  80173a:	8b 45 08             	mov    0x8(%ebp),%eax
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	52                   	push   %edx
  801744:	50                   	push   %eax
  801745:	6a 1b                	push   $0x1b
  801747:	e8 1c fd ff ff       	call   801468 <syscall>
  80174c:	83 c4 18             	add    $0x18,%esp
}
  80174f:	c9                   	leave  
  801750:	c3                   	ret    

00801751 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801751:	55                   	push   %ebp
  801752:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801754:	8b 55 0c             	mov    0xc(%ebp),%edx
  801757:	8b 45 08             	mov    0x8(%ebp),%eax
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	52                   	push   %edx
  801761:	50                   	push   %eax
  801762:	6a 19                	push   $0x19
  801764:	e8 ff fc ff ff       	call   801468 <syscall>
  801769:	83 c4 18             	add    $0x18,%esp
}
  80176c:	90                   	nop
  80176d:	c9                   	leave  
  80176e:	c3                   	ret    

0080176f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801772:	8b 55 0c             	mov    0xc(%ebp),%edx
  801775:	8b 45 08             	mov    0x8(%ebp),%eax
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	52                   	push   %edx
  80177f:	50                   	push   %eax
  801780:	6a 1a                	push   $0x1a
  801782:	e8 e1 fc ff ff       	call   801468 <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
}
  80178a:	90                   	nop
  80178b:	c9                   	leave  
  80178c:	c3                   	ret    

0080178d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80178d:	55                   	push   %ebp
  80178e:	89 e5                	mov    %esp,%ebp
  801790:	83 ec 04             	sub    $0x4,%esp
  801793:	8b 45 10             	mov    0x10(%ebp),%eax
  801796:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801799:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80179c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a3:	6a 00                	push   $0x0
  8017a5:	51                   	push   %ecx
  8017a6:	52                   	push   %edx
  8017a7:	ff 75 0c             	pushl  0xc(%ebp)
  8017aa:	50                   	push   %eax
  8017ab:	6a 1c                	push   $0x1c
  8017ad:	e8 b6 fc ff ff       	call   801468 <syscall>
  8017b2:	83 c4 18             	add    $0x18,%esp
}
  8017b5:	c9                   	leave  
  8017b6:	c3                   	ret    

008017b7 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8017b7:	55                   	push   %ebp
  8017b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8017ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	52                   	push   %edx
  8017c7:	50                   	push   %eax
  8017c8:	6a 1d                	push   $0x1d
  8017ca:	e8 99 fc ff ff       	call   801468 <syscall>
  8017cf:	83 c4 18             	add    $0x18,%esp
}
  8017d2:	c9                   	leave  
  8017d3:	c3                   	ret    

008017d4 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8017d4:	55                   	push   %ebp
  8017d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8017d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	51                   	push   %ecx
  8017e5:	52                   	push   %edx
  8017e6:	50                   	push   %eax
  8017e7:	6a 1e                	push   $0x1e
  8017e9:	e8 7a fc ff ff       	call   801468 <syscall>
  8017ee:	83 c4 18             	add    $0x18,%esp
}
  8017f1:	c9                   	leave  
  8017f2:	c3                   	ret    

008017f3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8017f3:	55                   	push   %ebp
  8017f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8017f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	52                   	push   %edx
  801803:	50                   	push   %eax
  801804:	6a 1f                	push   $0x1f
  801806:	e8 5d fc ff ff       	call   801468 <syscall>
  80180b:	83 c4 18             	add    $0x18,%esp
}
  80180e:	c9                   	leave  
  80180f:	c3                   	ret    

00801810 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801810:	55                   	push   %ebp
  801811:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 20                	push   $0x20
  80181f:	e8 44 fc ff ff       	call   801468 <syscall>
  801824:	83 c4 18             	add    $0x18,%esp
}
  801827:	c9                   	leave  
  801828:	c3                   	ret    

00801829 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801829:	55                   	push   %ebp
  80182a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80182c:	8b 45 08             	mov    0x8(%ebp),%eax
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	ff 75 10             	pushl  0x10(%ebp)
  801836:	ff 75 0c             	pushl  0xc(%ebp)
  801839:	50                   	push   %eax
  80183a:	6a 21                	push   $0x21
  80183c:	e8 27 fc ff ff       	call   801468 <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
}
  801844:	c9                   	leave  
  801845:	c3                   	ret    

00801846 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801846:	55                   	push   %ebp
  801847:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801849:	8b 45 08             	mov    0x8(%ebp),%eax
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	50                   	push   %eax
  801855:	6a 22                	push   $0x22
  801857:	e8 0c fc ff ff       	call   801468 <syscall>
  80185c:	83 c4 18             	add    $0x18,%esp
}
  80185f:	90                   	nop
  801860:	c9                   	leave  
  801861:	c3                   	ret    

00801862 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801862:	55                   	push   %ebp
  801863:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801865:	8b 45 08             	mov    0x8(%ebp),%eax
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	50                   	push   %eax
  801871:	6a 23                	push   $0x23
  801873:	e8 f0 fb ff ff       	call   801468 <syscall>
  801878:	83 c4 18             	add    $0x18,%esp
}
  80187b:	90                   	nop
  80187c:	c9                   	leave  
  80187d:	c3                   	ret    

0080187e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80187e:	55                   	push   %ebp
  80187f:	89 e5                	mov    %esp,%ebp
  801881:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801884:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801887:	8d 50 04             	lea    0x4(%eax),%edx
  80188a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	52                   	push   %edx
  801894:	50                   	push   %eax
  801895:	6a 24                	push   $0x24
  801897:	e8 cc fb ff ff       	call   801468 <syscall>
  80189c:	83 c4 18             	add    $0x18,%esp
	return result;
  80189f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018a8:	89 01                	mov    %eax,(%ecx)
  8018aa:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8018ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b0:	c9                   	leave  
  8018b1:	c2 04 00             	ret    $0x4

008018b4 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8018b4:	55                   	push   %ebp
  8018b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	ff 75 10             	pushl  0x10(%ebp)
  8018be:	ff 75 0c             	pushl  0xc(%ebp)
  8018c1:	ff 75 08             	pushl  0x8(%ebp)
  8018c4:	6a 13                	push   $0x13
  8018c6:	e8 9d fb ff ff       	call   801468 <syscall>
  8018cb:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ce:	90                   	nop
}
  8018cf:	c9                   	leave  
  8018d0:	c3                   	ret    

008018d1 <sys_rcr2>:
uint32 sys_rcr2()
{
  8018d1:	55                   	push   %ebp
  8018d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 25                	push   $0x25
  8018e0:	e8 83 fb ff ff       	call   801468 <syscall>
  8018e5:	83 c4 18             	add    $0x18,%esp
}
  8018e8:	c9                   	leave  
  8018e9:	c3                   	ret    

008018ea <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8018ea:	55                   	push   %ebp
  8018eb:	89 e5                	mov    %esp,%ebp
  8018ed:	83 ec 04             	sub    $0x4,%esp
  8018f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018f6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	50                   	push   %eax
  801903:	6a 26                	push   $0x26
  801905:	e8 5e fb ff ff       	call   801468 <syscall>
  80190a:	83 c4 18             	add    $0x18,%esp
	return ;
  80190d:	90                   	nop
}
  80190e:	c9                   	leave  
  80190f:	c3                   	ret    

00801910 <rsttst>:
void rsttst()
{
  801910:	55                   	push   %ebp
  801911:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801913:	6a 00                	push   $0x0
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	6a 28                	push   $0x28
  80191f:	e8 44 fb ff ff       	call   801468 <syscall>
  801924:	83 c4 18             	add    $0x18,%esp
	return ;
  801927:	90                   	nop
}
  801928:	c9                   	leave  
  801929:	c3                   	ret    

0080192a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80192a:	55                   	push   %ebp
  80192b:	89 e5                	mov    %esp,%ebp
  80192d:	83 ec 04             	sub    $0x4,%esp
  801930:	8b 45 14             	mov    0x14(%ebp),%eax
  801933:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801936:	8b 55 18             	mov    0x18(%ebp),%edx
  801939:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80193d:	52                   	push   %edx
  80193e:	50                   	push   %eax
  80193f:	ff 75 10             	pushl  0x10(%ebp)
  801942:	ff 75 0c             	pushl  0xc(%ebp)
  801945:	ff 75 08             	pushl  0x8(%ebp)
  801948:	6a 27                	push   $0x27
  80194a:	e8 19 fb ff ff       	call   801468 <syscall>
  80194f:	83 c4 18             	add    $0x18,%esp
	return ;
  801952:	90                   	nop
}
  801953:	c9                   	leave  
  801954:	c3                   	ret    

00801955 <chktst>:
void chktst(uint32 n)
{
  801955:	55                   	push   %ebp
  801956:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	ff 75 08             	pushl  0x8(%ebp)
  801963:	6a 29                	push   $0x29
  801965:	e8 fe fa ff ff       	call   801468 <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
	return ;
  80196d:	90                   	nop
}
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <inctst>:

void inctst()
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 2a                	push   $0x2a
  80197f:	e8 e4 fa ff ff       	call   801468 <syscall>
  801984:	83 c4 18             	add    $0x18,%esp
	return ;
  801987:	90                   	nop
}
  801988:	c9                   	leave  
  801989:	c3                   	ret    

0080198a <gettst>:
uint32 gettst()
{
  80198a:	55                   	push   %ebp
  80198b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 2b                	push   $0x2b
  801999:	e8 ca fa ff ff       	call   801468 <syscall>
  80199e:	83 c4 18             	add    $0x18,%esp
}
  8019a1:	c9                   	leave  
  8019a2:	c3                   	ret    

008019a3 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8019a3:	55                   	push   %ebp
  8019a4:	89 e5                	mov    %esp,%ebp
  8019a6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 2c                	push   $0x2c
  8019b5:	e8 ae fa ff ff       	call   801468 <syscall>
  8019ba:	83 c4 18             	add    $0x18,%esp
  8019bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8019c0:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8019c4:	75 07                	jne    8019cd <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8019c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8019cb:	eb 05                	jmp    8019d2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8019cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019d2:	c9                   	leave  
  8019d3:	c3                   	ret    

008019d4 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8019d4:	55                   	push   %ebp
  8019d5:	89 e5                	mov    %esp,%ebp
  8019d7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 2c                	push   $0x2c
  8019e6:	e8 7d fa ff ff       	call   801468 <syscall>
  8019eb:	83 c4 18             	add    $0x18,%esp
  8019ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8019f1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8019f5:	75 07                	jne    8019fe <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8019f7:	b8 01 00 00 00       	mov    $0x1,%eax
  8019fc:	eb 05                	jmp    801a03 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8019fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a03:	c9                   	leave  
  801a04:	c3                   	ret    

00801a05 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a05:	55                   	push   %ebp
  801a06:	89 e5                	mov    %esp,%ebp
  801a08:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 2c                	push   $0x2c
  801a17:	e8 4c fa ff ff       	call   801468 <syscall>
  801a1c:	83 c4 18             	add    $0x18,%esp
  801a1f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a22:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a26:	75 07                	jne    801a2f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a28:	b8 01 00 00 00       	mov    $0x1,%eax
  801a2d:	eb 05                	jmp    801a34 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a2f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a34:	c9                   	leave  
  801a35:	c3                   	ret    

00801a36 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a36:	55                   	push   %ebp
  801a37:	89 e5                	mov    %esp,%ebp
  801a39:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	6a 00                	push   $0x0
  801a46:	6a 2c                	push   $0x2c
  801a48:	e8 1b fa ff ff       	call   801468 <syscall>
  801a4d:	83 c4 18             	add    $0x18,%esp
  801a50:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a53:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a57:	75 07                	jne    801a60 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a59:	b8 01 00 00 00       	mov    $0x1,%eax
  801a5e:	eb 05                	jmp    801a65 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a60:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a65:	c9                   	leave  
  801a66:	c3                   	ret    

00801a67 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a67:	55                   	push   %ebp
  801a68:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a6a:	6a 00                	push   $0x0
  801a6c:	6a 00                	push   $0x0
  801a6e:	6a 00                	push   $0x0
  801a70:	6a 00                	push   $0x0
  801a72:	ff 75 08             	pushl  0x8(%ebp)
  801a75:	6a 2d                	push   $0x2d
  801a77:	e8 ec f9 ff ff       	call   801468 <syscall>
  801a7c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a7f:	90                   	nop
}
  801a80:	c9                   	leave  
  801a81:	c3                   	ret    
  801a82:	66 90                	xchg   %ax,%ax

00801a84 <__udivdi3>:
  801a84:	55                   	push   %ebp
  801a85:	57                   	push   %edi
  801a86:	56                   	push   %esi
  801a87:	53                   	push   %ebx
  801a88:	83 ec 1c             	sub    $0x1c,%esp
  801a8b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a8f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a93:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a97:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a9b:	89 ca                	mov    %ecx,%edx
  801a9d:	89 f8                	mov    %edi,%eax
  801a9f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801aa3:	85 f6                	test   %esi,%esi
  801aa5:	75 2d                	jne    801ad4 <__udivdi3+0x50>
  801aa7:	39 cf                	cmp    %ecx,%edi
  801aa9:	77 65                	ja     801b10 <__udivdi3+0x8c>
  801aab:	89 fd                	mov    %edi,%ebp
  801aad:	85 ff                	test   %edi,%edi
  801aaf:	75 0b                	jne    801abc <__udivdi3+0x38>
  801ab1:	b8 01 00 00 00       	mov    $0x1,%eax
  801ab6:	31 d2                	xor    %edx,%edx
  801ab8:	f7 f7                	div    %edi
  801aba:	89 c5                	mov    %eax,%ebp
  801abc:	31 d2                	xor    %edx,%edx
  801abe:	89 c8                	mov    %ecx,%eax
  801ac0:	f7 f5                	div    %ebp
  801ac2:	89 c1                	mov    %eax,%ecx
  801ac4:	89 d8                	mov    %ebx,%eax
  801ac6:	f7 f5                	div    %ebp
  801ac8:	89 cf                	mov    %ecx,%edi
  801aca:	89 fa                	mov    %edi,%edx
  801acc:	83 c4 1c             	add    $0x1c,%esp
  801acf:	5b                   	pop    %ebx
  801ad0:	5e                   	pop    %esi
  801ad1:	5f                   	pop    %edi
  801ad2:	5d                   	pop    %ebp
  801ad3:	c3                   	ret    
  801ad4:	39 ce                	cmp    %ecx,%esi
  801ad6:	77 28                	ja     801b00 <__udivdi3+0x7c>
  801ad8:	0f bd fe             	bsr    %esi,%edi
  801adb:	83 f7 1f             	xor    $0x1f,%edi
  801ade:	75 40                	jne    801b20 <__udivdi3+0x9c>
  801ae0:	39 ce                	cmp    %ecx,%esi
  801ae2:	72 0a                	jb     801aee <__udivdi3+0x6a>
  801ae4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ae8:	0f 87 9e 00 00 00    	ja     801b8c <__udivdi3+0x108>
  801aee:	b8 01 00 00 00       	mov    $0x1,%eax
  801af3:	89 fa                	mov    %edi,%edx
  801af5:	83 c4 1c             	add    $0x1c,%esp
  801af8:	5b                   	pop    %ebx
  801af9:	5e                   	pop    %esi
  801afa:	5f                   	pop    %edi
  801afb:	5d                   	pop    %ebp
  801afc:	c3                   	ret    
  801afd:	8d 76 00             	lea    0x0(%esi),%esi
  801b00:	31 ff                	xor    %edi,%edi
  801b02:	31 c0                	xor    %eax,%eax
  801b04:	89 fa                	mov    %edi,%edx
  801b06:	83 c4 1c             	add    $0x1c,%esp
  801b09:	5b                   	pop    %ebx
  801b0a:	5e                   	pop    %esi
  801b0b:	5f                   	pop    %edi
  801b0c:	5d                   	pop    %ebp
  801b0d:	c3                   	ret    
  801b0e:	66 90                	xchg   %ax,%ax
  801b10:	89 d8                	mov    %ebx,%eax
  801b12:	f7 f7                	div    %edi
  801b14:	31 ff                	xor    %edi,%edi
  801b16:	89 fa                	mov    %edi,%edx
  801b18:	83 c4 1c             	add    $0x1c,%esp
  801b1b:	5b                   	pop    %ebx
  801b1c:	5e                   	pop    %esi
  801b1d:	5f                   	pop    %edi
  801b1e:	5d                   	pop    %ebp
  801b1f:	c3                   	ret    
  801b20:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b25:	89 eb                	mov    %ebp,%ebx
  801b27:	29 fb                	sub    %edi,%ebx
  801b29:	89 f9                	mov    %edi,%ecx
  801b2b:	d3 e6                	shl    %cl,%esi
  801b2d:	89 c5                	mov    %eax,%ebp
  801b2f:	88 d9                	mov    %bl,%cl
  801b31:	d3 ed                	shr    %cl,%ebp
  801b33:	89 e9                	mov    %ebp,%ecx
  801b35:	09 f1                	or     %esi,%ecx
  801b37:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b3b:	89 f9                	mov    %edi,%ecx
  801b3d:	d3 e0                	shl    %cl,%eax
  801b3f:	89 c5                	mov    %eax,%ebp
  801b41:	89 d6                	mov    %edx,%esi
  801b43:	88 d9                	mov    %bl,%cl
  801b45:	d3 ee                	shr    %cl,%esi
  801b47:	89 f9                	mov    %edi,%ecx
  801b49:	d3 e2                	shl    %cl,%edx
  801b4b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b4f:	88 d9                	mov    %bl,%cl
  801b51:	d3 e8                	shr    %cl,%eax
  801b53:	09 c2                	or     %eax,%edx
  801b55:	89 d0                	mov    %edx,%eax
  801b57:	89 f2                	mov    %esi,%edx
  801b59:	f7 74 24 0c          	divl   0xc(%esp)
  801b5d:	89 d6                	mov    %edx,%esi
  801b5f:	89 c3                	mov    %eax,%ebx
  801b61:	f7 e5                	mul    %ebp
  801b63:	39 d6                	cmp    %edx,%esi
  801b65:	72 19                	jb     801b80 <__udivdi3+0xfc>
  801b67:	74 0b                	je     801b74 <__udivdi3+0xf0>
  801b69:	89 d8                	mov    %ebx,%eax
  801b6b:	31 ff                	xor    %edi,%edi
  801b6d:	e9 58 ff ff ff       	jmp    801aca <__udivdi3+0x46>
  801b72:	66 90                	xchg   %ax,%ax
  801b74:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b78:	89 f9                	mov    %edi,%ecx
  801b7a:	d3 e2                	shl    %cl,%edx
  801b7c:	39 c2                	cmp    %eax,%edx
  801b7e:	73 e9                	jae    801b69 <__udivdi3+0xe5>
  801b80:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b83:	31 ff                	xor    %edi,%edi
  801b85:	e9 40 ff ff ff       	jmp    801aca <__udivdi3+0x46>
  801b8a:	66 90                	xchg   %ax,%ax
  801b8c:	31 c0                	xor    %eax,%eax
  801b8e:	e9 37 ff ff ff       	jmp    801aca <__udivdi3+0x46>
  801b93:	90                   	nop

00801b94 <__umoddi3>:
  801b94:	55                   	push   %ebp
  801b95:	57                   	push   %edi
  801b96:	56                   	push   %esi
  801b97:	53                   	push   %ebx
  801b98:	83 ec 1c             	sub    $0x1c,%esp
  801b9b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b9f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ba3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ba7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801bab:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801baf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801bb3:	89 f3                	mov    %esi,%ebx
  801bb5:	89 fa                	mov    %edi,%edx
  801bb7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bbb:	89 34 24             	mov    %esi,(%esp)
  801bbe:	85 c0                	test   %eax,%eax
  801bc0:	75 1a                	jne    801bdc <__umoddi3+0x48>
  801bc2:	39 f7                	cmp    %esi,%edi
  801bc4:	0f 86 a2 00 00 00    	jbe    801c6c <__umoddi3+0xd8>
  801bca:	89 c8                	mov    %ecx,%eax
  801bcc:	89 f2                	mov    %esi,%edx
  801bce:	f7 f7                	div    %edi
  801bd0:	89 d0                	mov    %edx,%eax
  801bd2:	31 d2                	xor    %edx,%edx
  801bd4:	83 c4 1c             	add    $0x1c,%esp
  801bd7:	5b                   	pop    %ebx
  801bd8:	5e                   	pop    %esi
  801bd9:	5f                   	pop    %edi
  801bda:	5d                   	pop    %ebp
  801bdb:	c3                   	ret    
  801bdc:	39 f0                	cmp    %esi,%eax
  801bde:	0f 87 ac 00 00 00    	ja     801c90 <__umoddi3+0xfc>
  801be4:	0f bd e8             	bsr    %eax,%ebp
  801be7:	83 f5 1f             	xor    $0x1f,%ebp
  801bea:	0f 84 ac 00 00 00    	je     801c9c <__umoddi3+0x108>
  801bf0:	bf 20 00 00 00       	mov    $0x20,%edi
  801bf5:	29 ef                	sub    %ebp,%edi
  801bf7:	89 fe                	mov    %edi,%esi
  801bf9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bfd:	89 e9                	mov    %ebp,%ecx
  801bff:	d3 e0                	shl    %cl,%eax
  801c01:	89 d7                	mov    %edx,%edi
  801c03:	89 f1                	mov    %esi,%ecx
  801c05:	d3 ef                	shr    %cl,%edi
  801c07:	09 c7                	or     %eax,%edi
  801c09:	89 e9                	mov    %ebp,%ecx
  801c0b:	d3 e2                	shl    %cl,%edx
  801c0d:	89 14 24             	mov    %edx,(%esp)
  801c10:	89 d8                	mov    %ebx,%eax
  801c12:	d3 e0                	shl    %cl,%eax
  801c14:	89 c2                	mov    %eax,%edx
  801c16:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c1a:	d3 e0                	shl    %cl,%eax
  801c1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c20:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c24:	89 f1                	mov    %esi,%ecx
  801c26:	d3 e8                	shr    %cl,%eax
  801c28:	09 d0                	or     %edx,%eax
  801c2a:	d3 eb                	shr    %cl,%ebx
  801c2c:	89 da                	mov    %ebx,%edx
  801c2e:	f7 f7                	div    %edi
  801c30:	89 d3                	mov    %edx,%ebx
  801c32:	f7 24 24             	mull   (%esp)
  801c35:	89 c6                	mov    %eax,%esi
  801c37:	89 d1                	mov    %edx,%ecx
  801c39:	39 d3                	cmp    %edx,%ebx
  801c3b:	0f 82 87 00 00 00    	jb     801cc8 <__umoddi3+0x134>
  801c41:	0f 84 91 00 00 00    	je     801cd8 <__umoddi3+0x144>
  801c47:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c4b:	29 f2                	sub    %esi,%edx
  801c4d:	19 cb                	sbb    %ecx,%ebx
  801c4f:	89 d8                	mov    %ebx,%eax
  801c51:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c55:	d3 e0                	shl    %cl,%eax
  801c57:	89 e9                	mov    %ebp,%ecx
  801c59:	d3 ea                	shr    %cl,%edx
  801c5b:	09 d0                	or     %edx,%eax
  801c5d:	89 e9                	mov    %ebp,%ecx
  801c5f:	d3 eb                	shr    %cl,%ebx
  801c61:	89 da                	mov    %ebx,%edx
  801c63:	83 c4 1c             	add    $0x1c,%esp
  801c66:	5b                   	pop    %ebx
  801c67:	5e                   	pop    %esi
  801c68:	5f                   	pop    %edi
  801c69:	5d                   	pop    %ebp
  801c6a:	c3                   	ret    
  801c6b:	90                   	nop
  801c6c:	89 fd                	mov    %edi,%ebp
  801c6e:	85 ff                	test   %edi,%edi
  801c70:	75 0b                	jne    801c7d <__umoddi3+0xe9>
  801c72:	b8 01 00 00 00       	mov    $0x1,%eax
  801c77:	31 d2                	xor    %edx,%edx
  801c79:	f7 f7                	div    %edi
  801c7b:	89 c5                	mov    %eax,%ebp
  801c7d:	89 f0                	mov    %esi,%eax
  801c7f:	31 d2                	xor    %edx,%edx
  801c81:	f7 f5                	div    %ebp
  801c83:	89 c8                	mov    %ecx,%eax
  801c85:	f7 f5                	div    %ebp
  801c87:	89 d0                	mov    %edx,%eax
  801c89:	e9 44 ff ff ff       	jmp    801bd2 <__umoddi3+0x3e>
  801c8e:	66 90                	xchg   %ax,%ax
  801c90:	89 c8                	mov    %ecx,%eax
  801c92:	89 f2                	mov    %esi,%edx
  801c94:	83 c4 1c             	add    $0x1c,%esp
  801c97:	5b                   	pop    %ebx
  801c98:	5e                   	pop    %esi
  801c99:	5f                   	pop    %edi
  801c9a:	5d                   	pop    %ebp
  801c9b:	c3                   	ret    
  801c9c:	3b 04 24             	cmp    (%esp),%eax
  801c9f:	72 06                	jb     801ca7 <__umoddi3+0x113>
  801ca1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ca5:	77 0f                	ja     801cb6 <__umoddi3+0x122>
  801ca7:	89 f2                	mov    %esi,%edx
  801ca9:	29 f9                	sub    %edi,%ecx
  801cab:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801caf:	89 14 24             	mov    %edx,(%esp)
  801cb2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cb6:	8b 44 24 04          	mov    0x4(%esp),%eax
  801cba:	8b 14 24             	mov    (%esp),%edx
  801cbd:	83 c4 1c             	add    $0x1c,%esp
  801cc0:	5b                   	pop    %ebx
  801cc1:	5e                   	pop    %esi
  801cc2:	5f                   	pop    %edi
  801cc3:	5d                   	pop    %ebp
  801cc4:	c3                   	ret    
  801cc5:	8d 76 00             	lea    0x0(%esi),%esi
  801cc8:	2b 04 24             	sub    (%esp),%eax
  801ccb:	19 fa                	sbb    %edi,%edx
  801ccd:	89 d1                	mov    %edx,%ecx
  801ccf:	89 c6                	mov    %eax,%esi
  801cd1:	e9 71 ff ff ff       	jmp    801c47 <__umoddi3+0xb3>
  801cd6:	66 90                	xchg   %ax,%ax
  801cd8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801cdc:	72 ea                	jb     801cc8 <__umoddi3+0x134>
  801cde:	89 d9                	mov    %ebx,%ecx
  801ce0:	e9 62 ff ff ff       	jmp    801c47 <__umoddi3+0xb3>
