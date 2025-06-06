
obj/user/tst_page_replacement_alloc:     file format elf32-i386


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
  800031:	e8 45 03 00 00       	call   80037b <libmain>
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
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp

//	cprintf("envID = %d\n",envID);

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003f:	a1 20 30 80 00       	mov    0x803020,%eax
  800044:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80004a:	8b 00                	mov    (%eax),%eax
  80004c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800052:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800057:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005c:	74 14                	je     800072 <_main+0x3a>
  80005e:	83 ec 04             	sub    $0x4,%esp
  800061:	68 40 1d 80 00       	push   $0x801d40
  800066:	6a 12                	push   $0x12
  800068:	68 84 1d 80 00       	push   $0x801d84
  80006d:	e8 0b 04 00 00       	call   80047d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800072:	a1 20 30 80 00       	mov    0x803020,%eax
  800077:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007d:	83 c0 0c             	add    $0xc,%eax
  800080:	8b 00                	mov    (%eax),%eax
  800082:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800085:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800088:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008d:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800092:	74 14                	je     8000a8 <_main+0x70>
  800094:	83 ec 04             	sub    $0x4,%esp
  800097:	68 40 1d 80 00       	push   $0x801d40
  80009c:	6a 13                	push   $0x13
  80009e:	68 84 1d 80 00       	push   $0x801d84
  8000a3:	e8 d5 03 00 00       	call   80047d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ad:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b3:	83 c0 18             	add    $0x18,%eax
  8000b6:	8b 00                	mov    (%eax),%eax
  8000b8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000be:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c3:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c8:	74 14                	je     8000de <_main+0xa6>
  8000ca:	83 ec 04             	sub    $0x4,%esp
  8000cd:	68 40 1d 80 00       	push   $0x801d40
  8000d2:	6a 14                	push   $0x14
  8000d4:	68 84 1d 80 00       	push   $0x801d84
  8000d9:	e8 9f 03 00 00       	call   80047d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000de:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000e9:	83 c0 24             	add    $0x24,%eax
  8000ec:	8b 00                	mov    (%eax),%eax
  8000ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f9:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fe:	74 14                	je     800114 <_main+0xdc>
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	68 40 1d 80 00       	push   $0x801d40
  800108:	6a 15                	push   $0x15
  80010a:	68 84 1d 80 00       	push   $0x801d84
  80010f:	e8 69 03 00 00       	call   80047d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800114:	a1 20 30 80 00       	mov    0x803020,%eax
  800119:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80011f:	83 c0 30             	add    $0x30,%eax
  800122:	8b 00                	mov    (%eax),%eax
  800124:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800127:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80012a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012f:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800134:	74 14                	je     80014a <_main+0x112>
  800136:	83 ec 04             	sub    $0x4,%esp
  800139:	68 40 1d 80 00       	push   $0x801d40
  80013e:	6a 16                	push   $0x16
  800140:	68 84 1d 80 00       	push   $0x801d84
  800145:	e8 33 03 00 00       	call   80047d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014a:	a1 20 30 80 00       	mov    0x803020,%eax
  80014f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800155:	83 c0 3c             	add    $0x3c,%eax
  800158:	8b 00                	mov    (%eax),%eax
  80015a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80015d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800160:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800165:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016a:	74 14                	je     800180 <_main+0x148>
  80016c:	83 ec 04             	sub    $0x4,%esp
  80016f:	68 40 1d 80 00       	push   $0x801d40
  800174:	6a 17                	push   $0x17
  800176:	68 84 1d 80 00       	push   $0x801d84
  80017b:	e8 fd 02 00 00       	call   80047d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800180:	a1 20 30 80 00       	mov    0x803020,%eax
  800185:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018b:	83 c0 48             	add    $0x48,%eax
  80018e:	8b 00                	mov    (%eax),%eax
  800190:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800193:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800196:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019b:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a0:	74 14                	je     8001b6 <_main+0x17e>
  8001a2:	83 ec 04             	sub    $0x4,%esp
  8001a5:	68 40 1d 80 00       	push   $0x801d40
  8001aa:	6a 18                	push   $0x18
  8001ac:	68 84 1d 80 00       	push   $0x801d84
  8001b1:	e8 c7 02 00 00       	call   80047d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c1:	83 c0 54             	add    $0x54,%eax
  8001c4:	8b 00                	mov    (%eax),%eax
  8001c6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001c9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d1:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d6:	74 14                	je     8001ec <_main+0x1b4>
  8001d8:	83 ec 04             	sub    $0x4,%esp
  8001db:	68 40 1d 80 00       	push   $0x801d40
  8001e0:	6a 19                	push   $0x19
  8001e2:	68 84 1d 80 00       	push   $0x801d84
  8001e7:	e8 91 02 00 00       	call   80047d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f1:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f7:	83 c0 60             	add    $0x60,%eax
  8001fa:	8b 00                	mov    (%eax),%eax
  8001fc:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001ff:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800202:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800207:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020c:	74 14                	je     800222 <_main+0x1ea>
  80020e:	83 ec 04             	sub    $0x4,%esp
  800211:	68 40 1d 80 00       	push   $0x801d40
  800216:	6a 1a                	push   $0x1a
  800218:	68 84 1d 80 00       	push   $0x801d84
  80021d:	e8 5b 02 00 00       	call   80047d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800222:	a1 20 30 80 00       	mov    0x803020,%eax
  800227:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022d:	83 c0 6c             	add    $0x6c,%eax
  800230:	8b 00                	mov    (%eax),%eax
  800232:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800235:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800238:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023d:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800242:	74 14                	je     800258 <_main+0x220>
  800244:	83 ec 04             	sub    $0x4,%esp
  800247:	68 40 1d 80 00       	push   $0x801d40
  80024c:	6a 1b                	push   $0x1b
  80024e:	68 84 1d 80 00       	push   $0x801d84
  800253:	e8 25 02 00 00       	call   80047d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800258:	a1 20 30 80 00       	mov    0x803020,%eax
  80025d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800263:	83 c0 78             	add    $0x78,%eax
  800266:	8b 00                	mov    (%eax),%eax
  800268:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80026b:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80026e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800273:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800278:	74 14                	je     80028e <_main+0x256>
  80027a:	83 ec 04             	sub    $0x4,%esp
  80027d:	68 40 1d 80 00       	push   $0x801d40
  800282:	6a 1c                	push   $0x1c
  800284:	68 84 1d 80 00       	push   $0x801d84
  800289:	e8 ef 01 00 00       	call   80047d <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80028e:	a1 20 30 80 00       	mov    0x803020,%eax
  800293:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800299:	85 c0                	test   %eax,%eax
  80029b:	74 14                	je     8002b1 <_main+0x279>
  80029d:	83 ec 04             	sub    $0x4,%esp
  8002a0:	68 a8 1d 80 00       	push   $0x801da8
  8002a5:	6a 1d                	push   $0x1d
  8002a7:	68 84 1d 80 00       	push   $0x801d84
  8002ac:	e8 cc 01 00 00       	call   80047d <_panic>
	}

	int freePages = sys_calculate_free_frames();
  8002b1:	e8 71 13 00 00       	call   801627 <sys_calculate_free_frames>
  8002b6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002b9:	e8 ec 13 00 00       	call   8016aa <sys_pf_calculate_allocated_pages>
  8002be:	89 45 c0             	mov    %eax,-0x40(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8002c1:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002c6:	88 45 bf             	mov    %al,-0x41(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8002c9:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002ce:	88 45 be             	mov    %al,-0x42(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002d8:	eb 37                	jmp    800311 <_main+0x2d9>
	{
		arr[i] = -1 ;
  8002da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002dd:	05 40 30 80 00       	add    $0x803040,%eax
  8002e2:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8002e5:	a1 04 30 80 00       	mov    0x803004,%eax
  8002ea:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8002f0:	8a 12                	mov    (%edx),%dl
  8002f2:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8002f4:	a1 00 30 80 00       	mov    0x803000,%eax
  8002f9:	40                   	inc    %eax
  8002fa:	a3 00 30 80 00       	mov    %eax,0x803000
  8002ff:	a1 04 30 80 00       	mov    0x803004,%eax
  800304:	40                   	inc    %eax
  800305:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  80030a:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800311:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  800318:	7e c0                	jle    8002da <_main+0x2a2>

	//===================

	//cprintf("Checking Allocation in Mem & Page File... \n");
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  80031a:	e8 8b 13 00 00       	call   8016aa <sys_pf_calculate_allocated_pages>
  80031f:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  800322:	74 14                	je     800338 <_main+0x300>
  800324:	83 ec 04             	sub    $0x4,%esp
  800327:	68 f0 1d 80 00       	push   $0x801df0
  80032c:	6a 38                	push   $0x38
  80032e:	68 84 1d 80 00       	push   $0x801d84
  800333:	e8 45 01 00 00       	call   80047d <_panic>

		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  800338:	e8 ea 12 00 00       	call   801627 <sys_calculate_free_frames>
  80033d:	89 c3                	mov    %eax,%ebx
  80033f:	e8 fc 12 00 00       	call   801640 <sys_calculate_modified_frames>
  800344:	01 d8                	add    %ebx,%eax
  800346:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if( (freePages - freePagesAfter) != 0 )
  800349:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80034c:	3b 45 b8             	cmp    -0x48(%ebp),%eax
  80034f:	74 14                	je     800365 <_main+0x32d>
			panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  800351:	83 ec 04             	sub    $0x4,%esp
  800354:	68 5c 1e 80 00       	push   $0x801e5c
  800359:	6a 3c                	push   $0x3c
  80035b:	68 84 1d 80 00       	push   $0x801d84
  800360:	e8 18 01 00 00       	call   80047d <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [ALLOCATION] by REMOVING ONLY ONE PAGE is completed successfully.\n");
  800365:	83 ec 0c             	sub    $0xc,%esp
  800368:	68 c0 1e 80 00       	push   $0x801ec0
  80036d:	e8 bf 03 00 00       	call   800731 <cprintf>
  800372:	83 c4 10             	add    $0x10,%esp
	return;
  800375:	90                   	nop
}
  800376:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800379:	c9                   	leave  
  80037a:	c3                   	ret    

0080037b <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80037b:	55                   	push   %ebp
  80037c:	89 e5                	mov    %esp,%ebp
  80037e:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800381:	e8 d6 11 00 00       	call   80155c <sys_getenvindex>
  800386:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800389:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80038c:	89 d0                	mov    %edx,%eax
  80038e:	01 c0                	add    %eax,%eax
  800390:	01 d0                	add    %edx,%eax
  800392:	c1 e0 02             	shl    $0x2,%eax
  800395:	01 d0                	add    %edx,%eax
  800397:	c1 e0 06             	shl    $0x6,%eax
  80039a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80039f:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8003a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a9:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8003af:	84 c0                	test   %al,%al
  8003b1:	74 0f                	je     8003c2 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8003b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b8:	05 f4 02 00 00       	add    $0x2f4,%eax
  8003bd:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003c2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003c6:	7e 0a                	jle    8003d2 <libmain+0x57>
		binaryname = argv[0];
  8003c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003cb:	8b 00                	mov    (%eax),%eax
  8003cd:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  8003d2:	83 ec 08             	sub    $0x8,%esp
  8003d5:	ff 75 0c             	pushl  0xc(%ebp)
  8003d8:	ff 75 08             	pushl  0x8(%ebp)
  8003db:	e8 58 fc ff ff       	call   800038 <_main>
  8003e0:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003e3:	e8 0f 13 00 00       	call   8016f7 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003e8:	83 ec 0c             	sub    $0xc,%esp
  8003eb:	68 44 1f 80 00       	push   $0x801f44
  8003f0:	e8 3c 03 00 00       	call   800731 <cprintf>
  8003f5:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003fd:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800403:	a1 20 30 80 00       	mov    0x803020,%eax
  800408:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80040e:	83 ec 04             	sub    $0x4,%esp
  800411:	52                   	push   %edx
  800412:	50                   	push   %eax
  800413:	68 6c 1f 80 00       	push   $0x801f6c
  800418:	e8 14 03 00 00       	call   800731 <cprintf>
  80041d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800420:	a1 20 30 80 00       	mov    0x803020,%eax
  800425:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80042b:	83 ec 08             	sub    $0x8,%esp
  80042e:	50                   	push   %eax
  80042f:	68 91 1f 80 00       	push   $0x801f91
  800434:	e8 f8 02 00 00       	call   800731 <cprintf>
  800439:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80043c:	83 ec 0c             	sub    $0xc,%esp
  80043f:	68 44 1f 80 00       	push   $0x801f44
  800444:	e8 e8 02 00 00       	call   800731 <cprintf>
  800449:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80044c:	e8 c0 12 00 00       	call   801711 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800451:	e8 19 00 00 00       	call   80046f <exit>
}
  800456:	90                   	nop
  800457:	c9                   	leave  
  800458:	c3                   	ret    

00800459 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800459:	55                   	push   %ebp
  80045a:	89 e5                	mov    %esp,%ebp
  80045c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80045f:	83 ec 0c             	sub    $0xc,%esp
  800462:	6a 00                	push   $0x0
  800464:	e8 bf 10 00 00       	call   801528 <sys_env_destroy>
  800469:	83 c4 10             	add    $0x10,%esp
}
  80046c:	90                   	nop
  80046d:	c9                   	leave  
  80046e:	c3                   	ret    

0080046f <exit>:

void
exit(void)
{
  80046f:	55                   	push   %ebp
  800470:	89 e5                	mov    %esp,%ebp
  800472:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800475:	e8 14 11 00 00       	call   80158e <sys_env_exit>
}
  80047a:	90                   	nop
  80047b:	c9                   	leave  
  80047c:	c3                   	ret    

0080047d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80047d:	55                   	push   %ebp
  80047e:	89 e5                	mov    %esp,%ebp
  800480:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800483:	8d 45 10             	lea    0x10(%ebp),%eax
  800486:	83 c0 04             	add    $0x4,%eax
  800489:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80048c:	a1 48 f0 80 00       	mov    0x80f048,%eax
  800491:	85 c0                	test   %eax,%eax
  800493:	74 16                	je     8004ab <_panic+0x2e>
		cprintf("%s: ", argv0);
  800495:	a1 48 f0 80 00       	mov    0x80f048,%eax
  80049a:	83 ec 08             	sub    $0x8,%esp
  80049d:	50                   	push   %eax
  80049e:	68 a8 1f 80 00       	push   $0x801fa8
  8004a3:	e8 89 02 00 00       	call   800731 <cprintf>
  8004a8:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004ab:	a1 08 30 80 00       	mov    0x803008,%eax
  8004b0:	ff 75 0c             	pushl  0xc(%ebp)
  8004b3:	ff 75 08             	pushl  0x8(%ebp)
  8004b6:	50                   	push   %eax
  8004b7:	68 ad 1f 80 00       	push   $0x801fad
  8004bc:	e8 70 02 00 00       	call   800731 <cprintf>
  8004c1:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8004c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c7:	83 ec 08             	sub    $0x8,%esp
  8004ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8004cd:	50                   	push   %eax
  8004ce:	e8 f3 01 00 00       	call   8006c6 <vcprintf>
  8004d3:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8004d6:	83 ec 08             	sub    $0x8,%esp
  8004d9:	6a 00                	push   $0x0
  8004db:	68 c9 1f 80 00       	push   $0x801fc9
  8004e0:	e8 e1 01 00 00       	call   8006c6 <vcprintf>
  8004e5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8004e8:	e8 82 ff ff ff       	call   80046f <exit>

	// should not return here
	while (1) ;
  8004ed:	eb fe                	jmp    8004ed <_panic+0x70>

008004ef <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8004ef:	55                   	push   %ebp
  8004f0:	89 e5                	mov    %esp,%ebp
  8004f2:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8004f5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004fa:	8b 50 74             	mov    0x74(%eax),%edx
  8004fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800500:	39 c2                	cmp    %eax,%edx
  800502:	74 14                	je     800518 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800504:	83 ec 04             	sub    $0x4,%esp
  800507:	68 cc 1f 80 00       	push   $0x801fcc
  80050c:	6a 26                	push   $0x26
  80050e:	68 18 20 80 00       	push   $0x802018
  800513:	e8 65 ff ff ff       	call   80047d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800518:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80051f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800526:	e9 c2 00 00 00       	jmp    8005ed <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80052b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80052e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800535:	8b 45 08             	mov    0x8(%ebp),%eax
  800538:	01 d0                	add    %edx,%eax
  80053a:	8b 00                	mov    (%eax),%eax
  80053c:	85 c0                	test   %eax,%eax
  80053e:	75 08                	jne    800548 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800540:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800543:	e9 a2 00 00 00       	jmp    8005ea <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800548:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80054f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800556:	eb 69                	jmp    8005c1 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800558:	a1 20 30 80 00       	mov    0x803020,%eax
  80055d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800563:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800566:	89 d0                	mov    %edx,%eax
  800568:	01 c0                	add    %eax,%eax
  80056a:	01 d0                	add    %edx,%eax
  80056c:	c1 e0 02             	shl    $0x2,%eax
  80056f:	01 c8                	add    %ecx,%eax
  800571:	8a 40 04             	mov    0x4(%eax),%al
  800574:	84 c0                	test   %al,%al
  800576:	75 46                	jne    8005be <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800578:	a1 20 30 80 00       	mov    0x803020,%eax
  80057d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800583:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800586:	89 d0                	mov    %edx,%eax
  800588:	01 c0                	add    %eax,%eax
  80058a:	01 d0                	add    %edx,%eax
  80058c:	c1 e0 02             	shl    $0x2,%eax
  80058f:	01 c8                	add    %ecx,%eax
  800591:	8b 00                	mov    (%eax),%eax
  800593:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800596:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800599:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80059e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005a3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ad:	01 c8                	add    %ecx,%eax
  8005af:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005b1:	39 c2                	cmp    %eax,%edx
  8005b3:	75 09                	jne    8005be <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8005b5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005bc:	eb 12                	jmp    8005d0 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005be:	ff 45 e8             	incl   -0x18(%ebp)
  8005c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8005c6:	8b 50 74             	mov    0x74(%eax),%edx
  8005c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005cc:	39 c2                	cmp    %eax,%edx
  8005ce:	77 88                	ja     800558 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8005d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8005d4:	75 14                	jne    8005ea <CheckWSWithoutLastIndex+0xfb>
			panic(
  8005d6:	83 ec 04             	sub    $0x4,%esp
  8005d9:	68 24 20 80 00       	push   $0x802024
  8005de:	6a 3a                	push   $0x3a
  8005e0:	68 18 20 80 00       	push   $0x802018
  8005e5:	e8 93 fe ff ff       	call   80047d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005ea:	ff 45 f0             	incl   -0x10(%ebp)
  8005ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005f3:	0f 8c 32 ff ff ff    	jl     80052b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8005f9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800600:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800607:	eb 26                	jmp    80062f <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800609:	a1 20 30 80 00       	mov    0x803020,%eax
  80060e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800614:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800617:	89 d0                	mov    %edx,%eax
  800619:	01 c0                	add    %eax,%eax
  80061b:	01 d0                	add    %edx,%eax
  80061d:	c1 e0 02             	shl    $0x2,%eax
  800620:	01 c8                	add    %ecx,%eax
  800622:	8a 40 04             	mov    0x4(%eax),%al
  800625:	3c 01                	cmp    $0x1,%al
  800627:	75 03                	jne    80062c <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800629:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80062c:	ff 45 e0             	incl   -0x20(%ebp)
  80062f:	a1 20 30 80 00       	mov    0x803020,%eax
  800634:	8b 50 74             	mov    0x74(%eax),%edx
  800637:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80063a:	39 c2                	cmp    %eax,%edx
  80063c:	77 cb                	ja     800609 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80063e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800641:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800644:	74 14                	je     80065a <CheckWSWithoutLastIndex+0x16b>
		panic(
  800646:	83 ec 04             	sub    $0x4,%esp
  800649:	68 78 20 80 00       	push   $0x802078
  80064e:	6a 44                	push   $0x44
  800650:	68 18 20 80 00       	push   $0x802018
  800655:	e8 23 fe ff ff       	call   80047d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80065a:	90                   	nop
  80065b:	c9                   	leave  
  80065c:	c3                   	ret    

0080065d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80065d:	55                   	push   %ebp
  80065e:	89 e5                	mov    %esp,%ebp
  800660:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800663:	8b 45 0c             	mov    0xc(%ebp),%eax
  800666:	8b 00                	mov    (%eax),%eax
  800668:	8d 48 01             	lea    0x1(%eax),%ecx
  80066b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80066e:	89 0a                	mov    %ecx,(%edx)
  800670:	8b 55 08             	mov    0x8(%ebp),%edx
  800673:	88 d1                	mov    %dl,%cl
  800675:	8b 55 0c             	mov    0xc(%ebp),%edx
  800678:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80067c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80067f:	8b 00                	mov    (%eax),%eax
  800681:	3d ff 00 00 00       	cmp    $0xff,%eax
  800686:	75 2c                	jne    8006b4 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800688:	a0 24 30 80 00       	mov    0x803024,%al
  80068d:	0f b6 c0             	movzbl %al,%eax
  800690:	8b 55 0c             	mov    0xc(%ebp),%edx
  800693:	8b 12                	mov    (%edx),%edx
  800695:	89 d1                	mov    %edx,%ecx
  800697:	8b 55 0c             	mov    0xc(%ebp),%edx
  80069a:	83 c2 08             	add    $0x8,%edx
  80069d:	83 ec 04             	sub    $0x4,%esp
  8006a0:	50                   	push   %eax
  8006a1:	51                   	push   %ecx
  8006a2:	52                   	push   %edx
  8006a3:	e8 3e 0e 00 00       	call   8014e6 <sys_cputs>
  8006a8:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006b7:	8b 40 04             	mov    0x4(%eax),%eax
  8006ba:	8d 50 01             	lea    0x1(%eax),%edx
  8006bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006c0:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006c3:	90                   	nop
  8006c4:	c9                   	leave  
  8006c5:	c3                   	ret    

008006c6 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006c6:	55                   	push   %ebp
  8006c7:	89 e5                	mov    %esp,%ebp
  8006c9:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006cf:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006d6:	00 00 00 
	b.cnt = 0;
  8006d9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006e0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006e3:	ff 75 0c             	pushl  0xc(%ebp)
  8006e6:	ff 75 08             	pushl  0x8(%ebp)
  8006e9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006ef:	50                   	push   %eax
  8006f0:	68 5d 06 80 00       	push   $0x80065d
  8006f5:	e8 11 02 00 00       	call   80090b <vprintfmt>
  8006fa:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006fd:	a0 24 30 80 00       	mov    0x803024,%al
  800702:	0f b6 c0             	movzbl %al,%eax
  800705:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80070b:	83 ec 04             	sub    $0x4,%esp
  80070e:	50                   	push   %eax
  80070f:	52                   	push   %edx
  800710:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800716:	83 c0 08             	add    $0x8,%eax
  800719:	50                   	push   %eax
  80071a:	e8 c7 0d 00 00       	call   8014e6 <sys_cputs>
  80071f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800722:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800729:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80072f:	c9                   	leave  
  800730:	c3                   	ret    

00800731 <cprintf>:

int cprintf(const char *fmt, ...) {
  800731:	55                   	push   %ebp
  800732:	89 e5                	mov    %esp,%ebp
  800734:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800737:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80073e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800741:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800744:	8b 45 08             	mov    0x8(%ebp),%eax
  800747:	83 ec 08             	sub    $0x8,%esp
  80074a:	ff 75 f4             	pushl  -0xc(%ebp)
  80074d:	50                   	push   %eax
  80074e:	e8 73 ff ff ff       	call   8006c6 <vcprintf>
  800753:	83 c4 10             	add    $0x10,%esp
  800756:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800759:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80075c:	c9                   	leave  
  80075d:	c3                   	ret    

0080075e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80075e:	55                   	push   %ebp
  80075f:	89 e5                	mov    %esp,%ebp
  800761:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800764:	e8 8e 0f 00 00       	call   8016f7 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800769:	8d 45 0c             	lea    0xc(%ebp),%eax
  80076c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80076f:	8b 45 08             	mov    0x8(%ebp),%eax
  800772:	83 ec 08             	sub    $0x8,%esp
  800775:	ff 75 f4             	pushl  -0xc(%ebp)
  800778:	50                   	push   %eax
  800779:	e8 48 ff ff ff       	call   8006c6 <vcprintf>
  80077e:	83 c4 10             	add    $0x10,%esp
  800781:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800784:	e8 88 0f 00 00       	call   801711 <sys_enable_interrupt>
	return cnt;
  800789:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80078c:	c9                   	leave  
  80078d:	c3                   	ret    

0080078e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80078e:	55                   	push   %ebp
  80078f:	89 e5                	mov    %esp,%ebp
  800791:	53                   	push   %ebx
  800792:	83 ec 14             	sub    $0x14,%esp
  800795:	8b 45 10             	mov    0x10(%ebp),%eax
  800798:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80079b:	8b 45 14             	mov    0x14(%ebp),%eax
  80079e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007a1:	8b 45 18             	mov    0x18(%ebp),%eax
  8007a4:	ba 00 00 00 00       	mov    $0x0,%edx
  8007a9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007ac:	77 55                	ja     800803 <printnum+0x75>
  8007ae:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007b1:	72 05                	jb     8007b8 <printnum+0x2a>
  8007b3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007b6:	77 4b                	ja     800803 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007b8:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007bb:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007be:	8b 45 18             	mov    0x18(%ebp),%eax
  8007c1:	ba 00 00 00 00       	mov    $0x0,%edx
  8007c6:	52                   	push   %edx
  8007c7:	50                   	push   %eax
  8007c8:	ff 75 f4             	pushl  -0xc(%ebp)
  8007cb:	ff 75 f0             	pushl  -0x10(%ebp)
  8007ce:	e8 05 13 00 00       	call   801ad8 <__udivdi3>
  8007d3:	83 c4 10             	add    $0x10,%esp
  8007d6:	83 ec 04             	sub    $0x4,%esp
  8007d9:	ff 75 20             	pushl  0x20(%ebp)
  8007dc:	53                   	push   %ebx
  8007dd:	ff 75 18             	pushl  0x18(%ebp)
  8007e0:	52                   	push   %edx
  8007e1:	50                   	push   %eax
  8007e2:	ff 75 0c             	pushl  0xc(%ebp)
  8007e5:	ff 75 08             	pushl  0x8(%ebp)
  8007e8:	e8 a1 ff ff ff       	call   80078e <printnum>
  8007ed:	83 c4 20             	add    $0x20,%esp
  8007f0:	eb 1a                	jmp    80080c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007f2:	83 ec 08             	sub    $0x8,%esp
  8007f5:	ff 75 0c             	pushl  0xc(%ebp)
  8007f8:	ff 75 20             	pushl  0x20(%ebp)
  8007fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fe:	ff d0                	call   *%eax
  800800:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800803:	ff 4d 1c             	decl   0x1c(%ebp)
  800806:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80080a:	7f e6                	jg     8007f2 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80080c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80080f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800814:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800817:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80081a:	53                   	push   %ebx
  80081b:	51                   	push   %ecx
  80081c:	52                   	push   %edx
  80081d:	50                   	push   %eax
  80081e:	e8 c5 13 00 00       	call   801be8 <__umoddi3>
  800823:	83 c4 10             	add    $0x10,%esp
  800826:	05 f4 22 80 00       	add    $0x8022f4,%eax
  80082b:	8a 00                	mov    (%eax),%al
  80082d:	0f be c0             	movsbl %al,%eax
  800830:	83 ec 08             	sub    $0x8,%esp
  800833:	ff 75 0c             	pushl  0xc(%ebp)
  800836:	50                   	push   %eax
  800837:	8b 45 08             	mov    0x8(%ebp),%eax
  80083a:	ff d0                	call   *%eax
  80083c:	83 c4 10             	add    $0x10,%esp
}
  80083f:	90                   	nop
  800840:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800843:	c9                   	leave  
  800844:	c3                   	ret    

00800845 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800845:	55                   	push   %ebp
  800846:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800848:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80084c:	7e 1c                	jle    80086a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80084e:	8b 45 08             	mov    0x8(%ebp),%eax
  800851:	8b 00                	mov    (%eax),%eax
  800853:	8d 50 08             	lea    0x8(%eax),%edx
  800856:	8b 45 08             	mov    0x8(%ebp),%eax
  800859:	89 10                	mov    %edx,(%eax)
  80085b:	8b 45 08             	mov    0x8(%ebp),%eax
  80085e:	8b 00                	mov    (%eax),%eax
  800860:	83 e8 08             	sub    $0x8,%eax
  800863:	8b 50 04             	mov    0x4(%eax),%edx
  800866:	8b 00                	mov    (%eax),%eax
  800868:	eb 40                	jmp    8008aa <getuint+0x65>
	else if (lflag)
  80086a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80086e:	74 1e                	je     80088e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800870:	8b 45 08             	mov    0x8(%ebp),%eax
  800873:	8b 00                	mov    (%eax),%eax
  800875:	8d 50 04             	lea    0x4(%eax),%edx
  800878:	8b 45 08             	mov    0x8(%ebp),%eax
  80087b:	89 10                	mov    %edx,(%eax)
  80087d:	8b 45 08             	mov    0x8(%ebp),%eax
  800880:	8b 00                	mov    (%eax),%eax
  800882:	83 e8 04             	sub    $0x4,%eax
  800885:	8b 00                	mov    (%eax),%eax
  800887:	ba 00 00 00 00       	mov    $0x0,%edx
  80088c:	eb 1c                	jmp    8008aa <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80088e:	8b 45 08             	mov    0x8(%ebp),%eax
  800891:	8b 00                	mov    (%eax),%eax
  800893:	8d 50 04             	lea    0x4(%eax),%edx
  800896:	8b 45 08             	mov    0x8(%ebp),%eax
  800899:	89 10                	mov    %edx,(%eax)
  80089b:	8b 45 08             	mov    0x8(%ebp),%eax
  80089e:	8b 00                	mov    (%eax),%eax
  8008a0:	83 e8 04             	sub    $0x4,%eax
  8008a3:	8b 00                	mov    (%eax),%eax
  8008a5:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008aa:	5d                   	pop    %ebp
  8008ab:	c3                   	ret    

008008ac <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008ac:	55                   	push   %ebp
  8008ad:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008af:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008b3:	7e 1c                	jle    8008d1 <getint+0x25>
		return va_arg(*ap, long long);
  8008b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b8:	8b 00                	mov    (%eax),%eax
  8008ba:	8d 50 08             	lea    0x8(%eax),%edx
  8008bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c0:	89 10                	mov    %edx,(%eax)
  8008c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c5:	8b 00                	mov    (%eax),%eax
  8008c7:	83 e8 08             	sub    $0x8,%eax
  8008ca:	8b 50 04             	mov    0x4(%eax),%edx
  8008cd:	8b 00                	mov    (%eax),%eax
  8008cf:	eb 38                	jmp    800909 <getint+0x5d>
	else if (lflag)
  8008d1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008d5:	74 1a                	je     8008f1 <getint+0x45>
		return va_arg(*ap, long);
  8008d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008da:	8b 00                	mov    (%eax),%eax
  8008dc:	8d 50 04             	lea    0x4(%eax),%edx
  8008df:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e2:	89 10                	mov    %edx,(%eax)
  8008e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e7:	8b 00                	mov    (%eax),%eax
  8008e9:	83 e8 04             	sub    $0x4,%eax
  8008ec:	8b 00                	mov    (%eax),%eax
  8008ee:	99                   	cltd   
  8008ef:	eb 18                	jmp    800909 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f4:	8b 00                	mov    (%eax),%eax
  8008f6:	8d 50 04             	lea    0x4(%eax),%edx
  8008f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fc:	89 10                	mov    %edx,(%eax)
  8008fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800901:	8b 00                	mov    (%eax),%eax
  800903:	83 e8 04             	sub    $0x4,%eax
  800906:	8b 00                	mov    (%eax),%eax
  800908:	99                   	cltd   
}
  800909:	5d                   	pop    %ebp
  80090a:	c3                   	ret    

0080090b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80090b:	55                   	push   %ebp
  80090c:	89 e5                	mov    %esp,%ebp
  80090e:	56                   	push   %esi
  80090f:	53                   	push   %ebx
  800910:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800913:	eb 17                	jmp    80092c <vprintfmt+0x21>
			if (ch == '\0')
  800915:	85 db                	test   %ebx,%ebx
  800917:	0f 84 af 03 00 00    	je     800ccc <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80091d:	83 ec 08             	sub    $0x8,%esp
  800920:	ff 75 0c             	pushl  0xc(%ebp)
  800923:	53                   	push   %ebx
  800924:	8b 45 08             	mov    0x8(%ebp),%eax
  800927:	ff d0                	call   *%eax
  800929:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80092c:	8b 45 10             	mov    0x10(%ebp),%eax
  80092f:	8d 50 01             	lea    0x1(%eax),%edx
  800932:	89 55 10             	mov    %edx,0x10(%ebp)
  800935:	8a 00                	mov    (%eax),%al
  800937:	0f b6 d8             	movzbl %al,%ebx
  80093a:	83 fb 25             	cmp    $0x25,%ebx
  80093d:	75 d6                	jne    800915 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80093f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800943:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80094a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800951:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800958:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80095f:	8b 45 10             	mov    0x10(%ebp),%eax
  800962:	8d 50 01             	lea    0x1(%eax),%edx
  800965:	89 55 10             	mov    %edx,0x10(%ebp)
  800968:	8a 00                	mov    (%eax),%al
  80096a:	0f b6 d8             	movzbl %al,%ebx
  80096d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800970:	83 f8 55             	cmp    $0x55,%eax
  800973:	0f 87 2b 03 00 00    	ja     800ca4 <vprintfmt+0x399>
  800979:	8b 04 85 18 23 80 00 	mov    0x802318(,%eax,4),%eax
  800980:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800982:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800986:	eb d7                	jmp    80095f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800988:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80098c:	eb d1                	jmp    80095f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80098e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800995:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800998:	89 d0                	mov    %edx,%eax
  80099a:	c1 e0 02             	shl    $0x2,%eax
  80099d:	01 d0                	add    %edx,%eax
  80099f:	01 c0                	add    %eax,%eax
  8009a1:	01 d8                	add    %ebx,%eax
  8009a3:	83 e8 30             	sub    $0x30,%eax
  8009a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ac:	8a 00                	mov    (%eax),%al
  8009ae:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009b1:	83 fb 2f             	cmp    $0x2f,%ebx
  8009b4:	7e 3e                	jle    8009f4 <vprintfmt+0xe9>
  8009b6:	83 fb 39             	cmp    $0x39,%ebx
  8009b9:	7f 39                	jg     8009f4 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009bb:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009be:	eb d5                	jmp    800995 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8009c3:	83 c0 04             	add    $0x4,%eax
  8009c6:	89 45 14             	mov    %eax,0x14(%ebp)
  8009c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8009cc:	83 e8 04             	sub    $0x4,%eax
  8009cf:	8b 00                	mov    (%eax),%eax
  8009d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009d4:	eb 1f                	jmp    8009f5 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009d6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009da:	79 83                	jns    80095f <vprintfmt+0x54>
				width = 0;
  8009dc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009e3:	e9 77 ff ff ff       	jmp    80095f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009e8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009ef:	e9 6b ff ff ff       	jmp    80095f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009f4:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009f5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009f9:	0f 89 60 ff ff ff    	jns    80095f <vprintfmt+0x54>
				width = precision, precision = -1;
  8009ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a02:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a05:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a0c:	e9 4e ff ff ff       	jmp    80095f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a11:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a14:	e9 46 ff ff ff       	jmp    80095f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a19:	8b 45 14             	mov    0x14(%ebp),%eax
  800a1c:	83 c0 04             	add    $0x4,%eax
  800a1f:	89 45 14             	mov    %eax,0x14(%ebp)
  800a22:	8b 45 14             	mov    0x14(%ebp),%eax
  800a25:	83 e8 04             	sub    $0x4,%eax
  800a28:	8b 00                	mov    (%eax),%eax
  800a2a:	83 ec 08             	sub    $0x8,%esp
  800a2d:	ff 75 0c             	pushl  0xc(%ebp)
  800a30:	50                   	push   %eax
  800a31:	8b 45 08             	mov    0x8(%ebp),%eax
  800a34:	ff d0                	call   *%eax
  800a36:	83 c4 10             	add    $0x10,%esp
			break;
  800a39:	e9 89 02 00 00       	jmp    800cc7 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a3e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a41:	83 c0 04             	add    $0x4,%eax
  800a44:	89 45 14             	mov    %eax,0x14(%ebp)
  800a47:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4a:	83 e8 04             	sub    $0x4,%eax
  800a4d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a4f:	85 db                	test   %ebx,%ebx
  800a51:	79 02                	jns    800a55 <vprintfmt+0x14a>
				err = -err;
  800a53:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a55:	83 fb 64             	cmp    $0x64,%ebx
  800a58:	7f 0b                	jg     800a65 <vprintfmt+0x15a>
  800a5a:	8b 34 9d 60 21 80 00 	mov    0x802160(,%ebx,4),%esi
  800a61:	85 f6                	test   %esi,%esi
  800a63:	75 19                	jne    800a7e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a65:	53                   	push   %ebx
  800a66:	68 05 23 80 00       	push   $0x802305
  800a6b:	ff 75 0c             	pushl  0xc(%ebp)
  800a6e:	ff 75 08             	pushl  0x8(%ebp)
  800a71:	e8 5e 02 00 00       	call   800cd4 <printfmt>
  800a76:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a79:	e9 49 02 00 00       	jmp    800cc7 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a7e:	56                   	push   %esi
  800a7f:	68 0e 23 80 00       	push   $0x80230e
  800a84:	ff 75 0c             	pushl  0xc(%ebp)
  800a87:	ff 75 08             	pushl  0x8(%ebp)
  800a8a:	e8 45 02 00 00       	call   800cd4 <printfmt>
  800a8f:	83 c4 10             	add    $0x10,%esp
			break;
  800a92:	e9 30 02 00 00       	jmp    800cc7 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a97:	8b 45 14             	mov    0x14(%ebp),%eax
  800a9a:	83 c0 04             	add    $0x4,%eax
  800a9d:	89 45 14             	mov    %eax,0x14(%ebp)
  800aa0:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa3:	83 e8 04             	sub    $0x4,%eax
  800aa6:	8b 30                	mov    (%eax),%esi
  800aa8:	85 f6                	test   %esi,%esi
  800aaa:	75 05                	jne    800ab1 <vprintfmt+0x1a6>
				p = "(null)";
  800aac:	be 11 23 80 00       	mov    $0x802311,%esi
			if (width > 0 && padc != '-')
  800ab1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ab5:	7e 6d                	jle    800b24 <vprintfmt+0x219>
  800ab7:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800abb:	74 67                	je     800b24 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800abd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ac0:	83 ec 08             	sub    $0x8,%esp
  800ac3:	50                   	push   %eax
  800ac4:	56                   	push   %esi
  800ac5:	e8 0c 03 00 00       	call   800dd6 <strnlen>
  800aca:	83 c4 10             	add    $0x10,%esp
  800acd:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800ad0:	eb 16                	jmp    800ae8 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800ad2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ad6:	83 ec 08             	sub    $0x8,%esp
  800ad9:	ff 75 0c             	pushl  0xc(%ebp)
  800adc:	50                   	push   %eax
  800add:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae0:	ff d0                	call   *%eax
  800ae2:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ae5:	ff 4d e4             	decl   -0x1c(%ebp)
  800ae8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aec:	7f e4                	jg     800ad2 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800aee:	eb 34                	jmp    800b24 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800af0:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800af4:	74 1c                	je     800b12 <vprintfmt+0x207>
  800af6:	83 fb 1f             	cmp    $0x1f,%ebx
  800af9:	7e 05                	jle    800b00 <vprintfmt+0x1f5>
  800afb:	83 fb 7e             	cmp    $0x7e,%ebx
  800afe:	7e 12                	jle    800b12 <vprintfmt+0x207>
					putch('?', putdat);
  800b00:	83 ec 08             	sub    $0x8,%esp
  800b03:	ff 75 0c             	pushl  0xc(%ebp)
  800b06:	6a 3f                	push   $0x3f
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	ff d0                	call   *%eax
  800b0d:	83 c4 10             	add    $0x10,%esp
  800b10:	eb 0f                	jmp    800b21 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b12:	83 ec 08             	sub    $0x8,%esp
  800b15:	ff 75 0c             	pushl  0xc(%ebp)
  800b18:	53                   	push   %ebx
  800b19:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1c:	ff d0                	call   *%eax
  800b1e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b21:	ff 4d e4             	decl   -0x1c(%ebp)
  800b24:	89 f0                	mov    %esi,%eax
  800b26:	8d 70 01             	lea    0x1(%eax),%esi
  800b29:	8a 00                	mov    (%eax),%al
  800b2b:	0f be d8             	movsbl %al,%ebx
  800b2e:	85 db                	test   %ebx,%ebx
  800b30:	74 24                	je     800b56 <vprintfmt+0x24b>
  800b32:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b36:	78 b8                	js     800af0 <vprintfmt+0x1e5>
  800b38:	ff 4d e0             	decl   -0x20(%ebp)
  800b3b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b3f:	79 af                	jns    800af0 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b41:	eb 13                	jmp    800b56 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b43:	83 ec 08             	sub    $0x8,%esp
  800b46:	ff 75 0c             	pushl  0xc(%ebp)
  800b49:	6a 20                	push   $0x20
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	ff d0                	call   *%eax
  800b50:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b53:	ff 4d e4             	decl   -0x1c(%ebp)
  800b56:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b5a:	7f e7                	jg     800b43 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b5c:	e9 66 01 00 00       	jmp    800cc7 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b61:	83 ec 08             	sub    $0x8,%esp
  800b64:	ff 75 e8             	pushl  -0x18(%ebp)
  800b67:	8d 45 14             	lea    0x14(%ebp),%eax
  800b6a:	50                   	push   %eax
  800b6b:	e8 3c fd ff ff       	call   8008ac <getint>
  800b70:	83 c4 10             	add    $0x10,%esp
  800b73:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b76:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b79:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b7c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b7f:	85 d2                	test   %edx,%edx
  800b81:	79 23                	jns    800ba6 <vprintfmt+0x29b>
				putch('-', putdat);
  800b83:	83 ec 08             	sub    $0x8,%esp
  800b86:	ff 75 0c             	pushl  0xc(%ebp)
  800b89:	6a 2d                	push   $0x2d
  800b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8e:	ff d0                	call   *%eax
  800b90:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b96:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b99:	f7 d8                	neg    %eax
  800b9b:	83 d2 00             	adc    $0x0,%edx
  800b9e:	f7 da                	neg    %edx
  800ba0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ba6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bad:	e9 bc 00 00 00       	jmp    800c6e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800bb2:	83 ec 08             	sub    $0x8,%esp
  800bb5:	ff 75 e8             	pushl  -0x18(%ebp)
  800bb8:	8d 45 14             	lea    0x14(%ebp),%eax
  800bbb:	50                   	push   %eax
  800bbc:	e8 84 fc ff ff       	call   800845 <getuint>
  800bc1:	83 c4 10             	add    $0x10,%esp
  800bc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bc7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bca:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bd1:	e9 98 00 00 00       	jmp    800c6e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800bd6:	83 ec 08             	sub    $0x8,%esp
  800bd9:	ff 75 0c             	pushl  0xc(%ebp)
  800bdc:	6a 58                	push   $0x58
  800bde:	8b 45 08             	mov    0x8(%ebp),%eax
  800be1:	ff d0                	call   *%eax
  800be3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800be6:	83 ec 08             	sub    $0x8,%esp
  800be9:	ff 75 0c             	pushl  0xc(%ebp)
  800bec:	6a 58                	push   $0x58
  800bee:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf1:	ff d0                	call   *%eax
  800bf3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bf6:	83 ec 08             	sub    $0x8,%esp
  800bf9:	ff 75 0c             	pushl  0xc(%ebp)
  800bfc:	6a 58                	push   $0x58
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	ff d0                	call   *%eax
  800c03:	83 c4 10             	add    $0x10,%esp
			break;
  800c06:	e9 bc 00 00 00       	jmp    800cc7 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c0b:	83 ec 08             	sub    $0x8,%esp
  800c0e:	ff 75 0c             	pushl  0xc(%ebp)
  800c11:	6a 30                	push   $0x30
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	ff d0                	call   *%eax
  800c18:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c1b:	83 ec 08             	sub    $0x8,%esp
  800c1e:	ff 75 0c             	pushl  0xc(%ebp)
  800c21:	6a 78                	push   $0x78
  800c23:	8b 45 08             	mov    0x8(%ebp),%eax
  800c26:	ff d0                	call   *%eax
  800c28:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c2e:	83 c0 04             	add    $0x4,%eax
  800c31:	89 45 14             	mov    %eax,0x14(%ebp)
  800c34:	8b 45 14             	mov    0x14(%ebp),%eax
  800c37:	83 e8 04             	sub    $0x4,%eax
  800c3a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c46:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c4d:	eb 1f                	jmp    800c6e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c4f:	83 ec 08             	sub    $0x8,%esp
  800c52:	ff 75 e8             	pushl  -0x18(%ebp)
  800c55:	8d 45 14             	lea    0x14(%ebp),%eax
  800c58:	50                   	push   %eax
  800c59:	e8 e7 fb ff ff       	call   800845 <getuint>
  800c5e:	83 c4 10             	add    $0x10,%esp
  800c61:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c64:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c67:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c6e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c72:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c75:	83 ec 04             	sub    $0x4,%esp
  800c78:	52                   	push   %edx
  800c79:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c7c:	50                   	push   %eax
  800c7d:	ff 75 f4             	pushl  -0xc(%ebp)
  800c80:	ff 75 f0             	pushl  -0x10(%ebp)
  800c83:	ff 75 0c             	pushl  0xc(%ebp)
  800c86:	ff 75 08             	pushl  0x8(%ebp)
  800c89:	e8 00 fb ff ff       	call   80078e <printnum>
  800c8e:	83 c4 20             	add    $0x20,%esp
			break;
  800c91:	eb 34                	jmp    800cc7 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c93:	83 ec 08             	sub    $0x8,%esp
  800c96:	ff 75 0c             	pushl  0xc(%ebp)
  800c99:	53                   	push   %ebx
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	ff d0                	call   *%eax
  800c9f:	83 c4 10             	add    $0x10,%esp
			break;
  800ca2:	eb 23                	jmp    800cc7 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ca4:	83 ec 08             	sub    $0x8,%esp
  800ca7:	ff 75 0c             	pushl  0xc(%ebp)
  800caa:	6a 25                	push   $0x25
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	ff d0                	call   *%eax
  800cb1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800cb4:	ff 4d 10             	decl   0x10(%ebp)
  800cb7:	eb 03                	jmp    800cbc <vprintfmt+0x3b1>
  800cb9:	ff 4d 10             	decl   0x10(%ebp)
  800cbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800cbf:	48                   	dec    %eax
  800cc0:	8a 00                	mov    (%eax),%al
  800cc2:	3c 25                	cmp    $0x25,%al
  800cc4:	75 f3                	jne    800cb9 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800cc6:	90                   	nop
		}
	}
  800cc7:	e9 47 fc ff ff       	jmp    800913 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ccc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ccd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800cd0:	5b                   	pop    %ebx
  800cd1:	5e                   	pop    %esi
  800cd2:	5d                   	pop    %ebp
  800cd3:	c3                   	ret    

00800cd4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800cd4:	55                   	push   %ebp
  800cd5:	89 e5                	mov    %esp,%ebp
  800cd7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800cda:	8d 45 10             	lea    0x10(%ebp),%eax
  800cdd:	83 c0 04             	add    $0x4,%eax
  800ce0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ce3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce6:	ff 75 f4             	pushl  -0xc(%ebp)
  800ce9:	50                   	push   %eax
  800cea:	ff 75 0c             	pushl  0xc(%ebp)
  800ced:	ff 75 08             	pushl  0x8(%ebp)
  800cf0:	e8 16 fc ff ff       	call   80090b <vprintfmt>
  800cf5:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cf8:	90                   	nop
  800cf9:	c9                   	leave  
  800cfa:	c3                   	ret    

00800cfb <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800cfb:	55                   	push   %ebp
  800cfc:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800cfe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d01:	8b 40 08             	mov    0x8(%eax),%eax
  800d04:	8d 50 01             	lea    0x1(%eax),%edx
  800d07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d10:	8b 10                	mov    (%eax),%edx
  800d12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d15:	8b 40 04             	mov    0x4(%eax),%eax
  800d18:	39 c2                	cmp    %eax,%edx
  800d1a:	73 12                	jae    800d2e <sprintputch+0x33>
		*b->buf++ = ch;
  800d1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1f:	8b 00                	mov    (%eax),%eax
  800d21:	8d 48 01             	lea    0x1(%eax),%ecx
  800d24:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d27:	89 0a                	mov    %ecx,(%edx)
  800d29:	8b 55 08             	mov    0x8(%ebp),%edx
  800d2c:	88 10                	mov    %dl,(%eax)
}
  800d2e:	90                   	nop
  800d2f:	5d                   	pop    %ebp
  800d30:	c3                   	ret    

00800d31 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d31:	55                   	push   %ebp
  800d32:	89 e5                	mov    %esp,%ebp
  800d34:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d40:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	01 d0                	add    %edx,%eax
  800d48:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d52:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d56:	74 06                	je     800d5e <vsnprintf+0x2d>
  800d58:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d5c:	7f 07                	jg     800d65 <vsnprintf+0x34>
		return -E_INVAL;
  800d5e:	b8 03 00 00 00       	mov    $0x3,%eax
  800d63:	eb 20                	jmp    800d85 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d65:	ff 75 14             	pushl  0x14(%ebp)
  800d68:	ff 75 10             	pushl  0x10(%ebp)
  800d6b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d6e:	50                   	push   %eax
  800d6f:	68 fb 0c 80 00       	push   $0x800cfb
  800d74:	e8 92 fb ff ff       	call   80090b <vprintfmt>
  800d79:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d7f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d82:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d85:	c9                   	leave  
  800d86:	c3                   	ret    

00800d87 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d87:	55                   	push   %ebp
  800d88:	89 e5                	mov    %esp,%ebp
  800d8a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d8d:	8d 45 10             	lea    0x10(%ebp),%eax
  800d90:	83 c0 04             	add    $0x4,%eax
  800d93:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d96:	8b 45 10             	mov    0x10(%ebp),%eax
  800d99:	ff 75 f4             	pushl  -0xc(%ebp)
  800d9c:	50                   	push   %eax
  800d9d:	ff 75 0c             	pushl  0xc(%ebp)
  800da0:	ff 75 08             	pushl  0x8(%ebp)
  800da3:	e8 89 ff ff ff       	call   800d31 <vsnprintf>
  800da8:	83 c4 10             	add    $0x10,%esp
  800dab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800dae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800db1:	c9                   	leave  
  800db2:	c3                   	ret    

00800db3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800db3:	55                   	push   %ebp
  800db4:	89 e5                	mov    %esp,%ebp
  800db6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800db9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dc0:	eb 06                	jmp    800dc8 <strlen+0x15>
		n++;
  800dc2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800dc5:	ff 45 08             	incl   0x8(%ebp)
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	8a 00                	mov    (%eax),%al
  800dcd:	84 c0                	test   %al,%al
  800dcf:	75 f1                	jne    800dc2 <strlen+0xf>
		n++;
	return n;
  800dd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dd4:	c9                   	leave  
  800dd5:	c3                   	ret    

00800dd6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800dd6:	55                   	push   %ebp
  800dd7:	89 e5                	mov    %esp,%ebp
  800dd9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ddc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800de3:	eb 09                	jmp    800dee <strnlen+0x18>
		n++;
  800de5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800de8:	ff 45 08             	incl   0x8(%ebp)
  800deb:	ff 4d 0c             	decl   0xc(%ebp)
  800dee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800df2:	74 09                	je     800dfd <strnlen+0x27>
  800df4:	8b 45 08             	mov    0x8(%ebp),%eax
  800df7:	8a 00                	mov    (%eax),%al
  800df9:	84 c0                	test   %al,%al
  800dfb:	75 e8                	jne    800de5 <strnlen+0xf>
		n++;
	return n;
  800dfd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e00:	c9                   	leave  
  800e01:	c3                   	ret    

00800e02 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e02:	55                   	push   %ebp
  800e03:	89 e5                	mov    %esp,%ebp
  800e05:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e0e:	90                   	nop
  800e0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e12:	8d 50 01             	lea    0x1(%eax),%edx
  800e15:	89 55 08             	mov    %edx,0x8(%ebp)
  800e18:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e1b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e1e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e21:	8a 12                	mov    (%edx),%dl
  800e23:	88 10                	mov    %dl,(%eax)
  800e25:	8a 00                	mov    (%eax),%al
  800e27:	84 c0                	test   %al,%al
  800e29:	75 e4                	jne    800e0f <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e2e:	c9                   	leave  
  800e2f:	c3                   	ret    

00800e30 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e30:	55                   	push   %ebp
  800e31:	89 e5                	mov    %esp,%ebp
  800e33:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e36:	8b 45 08             	mov    0x8(%ebp),%eax
  800e39:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e3c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e43:	eb 1f                	jmp    800e64 <strncpy+0x34>
		*dst++ = *src;
  800e45:	8b 45 08             	mov    0x8(%ebp),%eax
  800e48:	8d 50 01             	lea    0x1(%eax),%edx
  800e4b:	89 55 08             	mov    %edx,0x8(%ebp)
  800e4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e51:	8a 12                	mov    (%edx),%dl
  800e53:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e58:	8a 00                	mov    (%eax),%al
  800e5a:	84 c0                	test   %al,%al
  800e5c:	74 03                	je     800e61 <strncpy+0x31>
			src++;
  800e5e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e61:	ff 45 fc             	incl   -0x4(%ebp)
  800e64:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e67:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e6a:	72 d9                	jb     800e45 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e6c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e6f:	c9                   	leave  
  800e70:	c3                   	ret    

00800e71 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e71:	55                   	push   %ebp
  800e72:	89 e5                	mov    %esp,%ebp
  800e74:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e77:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e7d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e81:	74 30                	je     800eb3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e83:	eb 16                	jmp    800e9b <strlcpy+0x2a>
			*dst++ = *src++;
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
  800e88:	8d 50 01             	lea    0x1(%eax),%edx
  800e8b:	89 55 08             	mov    %edx,0x8(%ebp)
  800e8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e91:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e94:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e97:	8a 12                	mov    (%edx),%dl
  800e99:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e9b:	ff 4d 10             	decl   0x10(%ebp)
  800e9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ea2:	74 09                	je     800ead <strlcpy+0x3c>
  800ea4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea7:	8a 00                	mov    (%eax),%al
  800ea9:	84 c0                	test   %al,%al
  800eab:	75 d8                	jne    800e85 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ead:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800eb3:	8b 55 08             	mov    0x8(%ebp),%edx
  800eb6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb9:	29 c2                	sub    %eax,%edx
  800ebb:	89 d0                	mov    %edx,%eax
}
  800ebd:	c9                   	leave  
  800ebe:	c3                   	ret    

00800ebf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ebf:	55                   	push   %ebp
  800ec0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ec2:	eb 06                	jmp    800eca <strcmp+0xb>
		p++, q++;
  800ec4:	ff 45 08             	incl   0x8(%ebp)
  800ec7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800eca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecd:	8a 00                	mov    (%eax),%al
  800ecf:	84 c0                	test   %al,%al
  800ed1:	74 0e                	je     800ee1 <strcmp+0x22>
  800ed3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed6:	8a 10                	mov    (%eax),%dl
  800ed8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800edb:	8a 00                	mov    (%eax),%al
  800edd:	38 c2                	cmp    %al,%dl
  800edf:	74 e3                	je     800ec4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	8a 00                	mov    (%eax),%al
  800ee6:	0f b6 d0             	movzbl %al,%edx
  800ee9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eec:	8a 00                	mov    (%eax),%al
  800eee:	0f b6 c0             	movzbl %al,%eax
  800ef1:	29 c2                	sub    %eax,%edx
  800ef3:	89 d0                	mov    %edx,%eax
}
  800ef5:	5d                   	pop    %ebp
  800ef6:	c3                   	ret    

00800ef7 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ef7:	55                   	push   %ebp
  800ef8:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800efa:	eb 09                	jmp    800f05 <strncmp+0xe>
		n--, p++, q++;
  800efc:	ff 4d 10             	decl   0x10(%ebp)
  800eff:	ff 45 08             	incl   0x8(%ebp)
  800f02:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f05:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f09:	74 17                	je     800f22 <strncmp+0x2b>
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0e:	8a 00                	mov    (%eax),%al
  800f10:	84 c0                	test   %al,%al
  800f12:	74 0e                	je     800f22 <strncmp+0x2b>
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	8a 10                	mov    (%eax),%dl
  800f19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1c:	8a 00                	mov    (%eax),%al
  800f1e:	38 c2                	cmp    %al,%dl
  800f20:	74 da                	je     800efc <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f22:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f26:	75 07                	jne    800f2f <strncmp+0x38>
		return 0;
  800f28:	b8 00 00 00 00       	mov    $0x0,%eax
  800f2d:	eb 14                	jmp    800f43 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f32:	8a 00                	mov    (%eax),%al
  800f34:	0f b6 d0             	movzbl %al,%edx
  800f37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3a:	8a 00                	mov    (%eax),%al
  800f3c:	0f b6 c0             	movzbl %al,%eax
  800f3f:	29 c2                	sub    %eax,%edx
  800f41:	89 d0                	mov    %edx,%eax
}
  800f43:	5d                   	pop    %ebp
  800f44:	c3                   	ret    

00800f45 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f45:	55                   	push   %ebp
  800f46:	89 e5                	mov    %esp,%ebp
  800f48:	83 ec 04             	sub    $0x4,%esp
  800f4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f51:	eb 12                	jmp    800f65 <strchr+0x20>
		if (*s == c)
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
  800f56:	8a 00                	mov    (%eax),%al
  800f58:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f5b:	75 05                	jne    800f62 <strchr+0x1d>
			return (char *) s;
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f60:	eb 11                	jmp    800f73 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f62:	ff 45 08             	incl   0x8(%ebp)
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	8a 00                	mov    (%eax),%al
  800f6a:	84 c0                	test   %al,%al
  800f6c:	75 e5                	jne    800f53 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f6e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f73:	c9                   	leave  
  800f74:	c3                   	ret    

00800f75 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f75:	55                   	push   %ebp
  800f76:	89 e5                	mov    %esp,%ebp
  800f78:	83 ec 04             	sub    $0x4,%esp
  800f7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f81:	eb 0d                	jmp    800f90 <strfind+0x1b>
		if (*s == c)
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	8a 00                	mov    (%eax),%al
  800f88:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f8b:	74 0e                	je     800f9b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f8d:	ff 45 08             	incl   0x8(%ebp)
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
  800f93:	8a 00                	mov    (%eax),%al
  800f95:	84 c0                	test   %al,%al
  800f97:	75 ea                	jne    800f83 <strfind+0xe>
  800f99:	eb 01                	jmp    800f9c <strfind+0x27>
		if (*s == c)
			break;
  800f9b:	90                   	nop
	return (char *) s;
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f9f:	c9                   	leave  
  800fa0:	c3                   	ret    

00800fa1 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800fa1:	55                   	push   %ebp
  800fa2:	89 e5                	mov    %esp,%ebp
  800fa4:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800fad:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800fb3:	eb 0e                	jmp    800fc3 <memset+0x22>
		*p++ = c;
  800fb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fb8:	8d 50 01             	lea    0x1(%eax),%edx
  800fbb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fc1:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800fc3:	ff 4d f8             	decl   -0x8(%ebp)
  800fc6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800fca:	79 e9                	jns    800fb5 <memset+0x14>
		*p++ = c;

	return v;
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fcf:	c9                   	leave  
  800fd0:	c3                   	ret    

00800fd1 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fd1:	55                   	push   %ebp
  800fd2:	89 e5                	mov    %esp,%ebp
  800fd4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fda:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800fe3:	eb 16                	jmp    800ffb <memcpy+0x2a>
		*d++ = *s++;
  800fe5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe8:	8d 50 01             	lea    0x1(%eax),%edx
  800feb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ff1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ff4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ff7:	8a 12                	mov    (%edx),%dl
  800ff9:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ffb:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffe:	8d 50 ff             	lea    -0x1(%eax),%edx
  801001:	89 55 10             	mov    %edx,0x10(%ebp)
  801004:	85 c0                	test   %eax,%eax
  801006:	75 dd                	jne    800fe5 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801008:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80100b:	c9                   	leave  
  80100c:	c3                   	ret    

0080100d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80100d:	55                   	push   %ebp
  80100e:	89 e5                	mov    %esp,%ebp
  801010:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801013:	8b 45 0c             	mov    0xc(%ebp),%eax
  801016:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801019:	8b 45 08             	mov    0x8(%ebp),%eax
  80101c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80101f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801022:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801025:	73 50                	jae    801077 <memmove+0x6a>
  801027:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80102a:	8b 45 10             	mov    0x10(%ebp),%eax
  80102d:	01 d0                	add    %edx,%eax
  80102f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801032:	76 43                	jbe    801077 <memmove+0x6a>
		s += n;
  801034:	8b 45 10             	mov    0x10(%ebp),%eax
  801037:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80103a:	8b 45 10             	mov    0x10(%ebp),%eax
  80103d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801040:	eb 10                	jmp    801052 <memmove+0x45>
			*--d = *--s;
  801042:	ff 4d f8             	decl   -0x8(%ebp)
  801045:	ff 4d fc             	decl   -0x4(%ebp)
  801048:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80104b:	8a 10                	mov    (%eax),%dl
  80104d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801050:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801052:	8b 45 10             	mov    0x10(%ebp),%eax
  801055:	8d 50 ff             	lea    -0x1(%eax),%edx
  801058:	89 55 10             	mov    %edx,0x10(%ebp)
  80105b:	85 c0                	test   %eax,%eax
  80105d:	75 e3                	jne    801042 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80105f:	eb 23                	jmp    801084 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801061:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801064:	8d 50 01             	lea    0x1(%eax),%edx
  801067:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80106a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80106d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801070:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801073:	8a 12                	mov    (%edx),%dl
  801075:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801077:	8b 45 10             	mov    0x10(%ebp),%eax
  80107a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80107d:	89 55 10             	mov    %edx,0x10(%ebp)
  801080:	85 c0                	test   %eax,%eax
  801082:	75 dd                	jne    801061 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801084:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801087:	c9                   	leave  
  801088:	c3                   	ret    

00801089 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801089:	55                   	push   %ebp
  80108a:	89 e5                	mov    %esp,%ebp
  80108c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80108f:	8b 45 08             	mov    0x8(%ebp),%eax
  801092:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801095:	8b 45 0c             	mov    0xc(%ebp),%eax
  801098:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80109b:	eb 2a                	jmp    8010c7 <memcmp+0x3e>
		if (*s1 != *s2)
  80109d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010a0:	8a 10                	mov    (%eax),%dl
  8010a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010a5:	8a 00                	mov    (%eax),%al
  8010a7:	38 c2                	cmp    %al,%dl
  8010a9:	74 16                	je     8010c1 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ae:	8a 00                	mov    (%eax),%al
  8010b0:	0f b6 d0             	movzbl %al,%edx
  8010b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b6:	8a 00                	mov    (%eax),%al
  8010b8:	0f b6 c0             	movzbl %al,%eax
  8010bb:	29 c2                	sub    %eax,%edx
  8010bd:	89 d0                	mov    %edx,%eax
  8010bf:	eb 18                	jmp    8010d9 <memcmp+0x50>
		s1++, s2++;
  8010c1:	ff 45 fc             	incl   -0x4(%ebp)
  8010c4:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ca:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010cd:	89 55 10             	mov    %edx,0x10(%ebp)
  8010d0:	85 c0                	test   %eax,%eax
  8010d2:	75 c9                	jne    80109d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010d9:	c9                   	leave  
  8010da:	c3                   	ret    

008010db <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010db:	55                   	push   %ebp
  8010dc:	89 e5                	mov    %esp,%ebp
  8010de:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010e1:	8b 55 08             	mov    0x8(%ebp),%edx
  8010e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e7:	01 d0                	add    %edx,%eax
  8010e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010ec:	eb 15                	jmp    801103 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f1:	8a 00                	mov    (%eax),%al
  8010f3:	0f b6 d0             	movzbl %al,%edx
  8010f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f9:	0f b6 c0             	movzbl %al,%eax
  8010fc:	39 c2                	cmp    %eax,%edx
  8010fe:	74 0d                	je     80110d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801100:	ff 45 08             	incl   0x8(%ebp)
  801103:	8b 45 08             	mov    0x8(%ebp),%eax
  801106:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801109:	72 e3                	jb     8010ee <memfind+0x13>
  80110b:	eb 01                	jmp    80110e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80110d:	90                   	nop
	return (void *) s;
  80110e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801111:	c9                   	leave  
  801112:	c3                   	ret    

00801113 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801113:	55                   	push   %ebp
  801114:	89 e5                	mov    %esp,%ebp
  801116:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801119:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801120:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801127:	eb 03                	jmp    80112c <strtol+0x19>
		s++;
  801129:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80112c:	8b 45 08             	mov    0x8(%ebp),%eax
  80112f:	8a 00                	mov    (%eax),%al
  801131:	3c 20                	cmp    $0x20,%al
  801133:	74 f4                	je     801129 <strtol+0x16>
  801135:	8b 45 08             	mov    0x8(%ebp),%eax
  801138:	8a 00                	mov    (%eax),%al
  80113a:	3c 09                	cmp    $0x9,%al
  80113c:	74 eb                	je     801129 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	8a 00                	mov    (%eax),%al
  801143:	3c 2b                	cmp    $0x2b,%al
  801145:	75 05                	jne    80114c <strtol+0x39>
		s++;
  801147:	ff 45 08             	incl   0x8(%ebp)
  80114a:	eb 13                	jmp    80115f <strtol+0x4c>
	else if (*s == '-')
  80114c:	8b 45 08             	mov    0x8(%ebp),%eax
  80114f:	8a 00                	mov    (%eax),%al
  801151:	3c 2d                	cmp    $0x2d,%al
  801153:	75 0a                	jne    80115f <strtol+0x4c>
		s++, neg = 1;
  801155:	ff 45 08             	incl   0x8(%ebp)
  801158:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80115f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801163:	74 06                	je     80116b <strtol+0x58>
  801165:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801169:	75 20                	jne    80118b <strtol+0x78>
  80116b:	8b 45 08             	mov    0x8(%ebp),%eax
  80116e:	8a 00                	mov    (%eax),%al
  801170:	3c 30                	cmp    $0x30,%al
  801172:	75 17                	jne    80118b <strtol+0x78>
  801174:	8b 45 08             	mov    0x8(%ebp),%eax
  801177:	40                   	inc    %eax
  801178:	8a 00                	mov    (%eax),%al
  80117a:	3c 78                	cmp    $0x78,%al
  80117c:	75 0d                	jne    80118b <strtol+0x78>
		s += 2, base = 16;
  80117e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801182:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801189:	eb 28                	jmp    8011b3 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80118b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80118f:	75 15                	jne    8011a6 <strtol+0x93>
  801191:	8b 45 08             	mov    0x8(%ebp),%eax
  801194:	8a 00                	mov    (%eax),%al
  801196:	3c 30                	cmp    $0x30,%al
  801198:	75 0c                	jne    8011a6 <strtol+0x93>
		s++, base = 8;
  80119a:	ff 45 08             	incl   0x8(%ebp)
  80119d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011a4:	eb 0d                	jmp    8011b3 <strtol+0xa0>
	else if (base == 0)
  8011a6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011aa:	75 07                	jne    8011b3 <strtol+0xa0>
		base = 10;
  8011ac:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b6:	8a 00                	mov    (%eax),%al
  8011b8:	3c 2f                	cmp    $0x2f,%al
  8011ba:	7e 19                	jle    8011d5 <strtol+0xc2>
  8011bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bf:	8a 00                	mov    (%eax),%al
  8011c1:	3c 39                	cmp    $0x39,%al
  8011c3:	7f 10                	jg     8011d5 <strtol+0xc2>
			dig = *s - '0';
  8011c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c8:	8a 00                	mov    (%eax),%al
  8011ca:	0f be c0             	movsbl %al,%eax
  8011cd:	83 e8 30             	sub    $0x30,%eax
  8011d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011d3:	eb 42                	jmp    801217 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d8:	8a 00                	mov    (%eax),%al
  8011da:	3c 60                	cmp    $0x60,%al
  8011dc:	7e 19                	jle    8011f7 <strtol+0xe4>
  8011de:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e1:	8a 00                	mov    (%eax),%al
  8011e3:	3c 7a                	cmp    $0x7a,%al
  8011e5:	7f 10                	jg     8011f7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ea:	8a 00                	mov    (%eax),%al
  8011ec:	0f be c0             	movsbl %al,%eax
  8011ef:	83 e8 57             	sub    $0x57,%eax
  8011f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011f5:	eb 20                	jmp    801217 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fa:	8a 00                	mov    (%eax),%al
  8011fc:	3c 40                	cmp    $0x40,%al
  8011fe:	7e 39                	jle    801239 <strtol+0x126>
  801200:	8b 45 08             	mov    0x8(%ebp),%eax
  801203:	8a 00                	mov    (%eax),%al
  801205:	3c 5a                	cmp    $0x5a,%al
  801207:	7f 30                	jg     801239 <strtol+0x126>
			dig = *s - 'A' + 10;
  801209:	8b 45 08             	mov    0x8(%ebp),%eax
  80120c:	8a 00                	mov    (%eax),%al
  80120e:	0f be c0             	movsbl %al,%eax
  801211:	83 e8 37             	sub    $0x37,%eax
  801214:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801217:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80121a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80121d:	7d 19                	jge    801238 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80121f:	ff 45 08             	incl   0x8(%ebp)
  801222:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801225:	0f af 45 10          	imul   0x10(%ebp),%eax
  801229:	89 c2                	mov    %eax,%edx
  80122b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80122e:	01 d0                	add    %edx,%eax
  801230:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801233:	e9 7b ff ff ff       	jmp    8011b3 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801238:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801239:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80123d:	74 08                	je     801247 <strtol+0x134>
		*endptr = (char *) s;
  80123f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801242:	8b 55 08             	mov    0x8(%ebp),%edx
  801245:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801247:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80124b:	74 07                	je     801254 <strtol+0x141>
  80124d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801250:	f7 d8                	neg    %eax
  801252:	eb 03                	jmp    801257 <strtol+0x144>
  801254:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801257:	c9                   	leave  
  801258:	c3                   	ret    

00801259 <ltostr>:

void
ltostr(long value, char *str)
{
  801259:	55                   	push   %ebp
  80125a:	89 e5                	mov    %esp,%ebp
  80125c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80125f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801266:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80126d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801271:	79 13                	jns    801286 <ltostr+0x2d>
	{
		neg = 1;
  801273:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80127a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801280:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801283:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801286:	8b 45 08             	mov    0x8(%ebp),%eax
  801289:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80128e:	99                   	cltd   
  80128f:	f7 f9                	idiv   %ecx
  801291:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801294:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801297:	8d 50 01             	lea    0x1(%eax),%edx
  80129a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80129d:	89 c2                	mov    %eax,%edx
  80129f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a2:	01 d0                	add    %edx,%eax
  8012a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012a7:	83 c2 30             	add    $0x30,%edx
  8012aa:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012ac:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012af:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012b4:	f7 e9                	imul   %ecx
  8012b6:	c1 fa 02             	sar    $0x2,%edx
  8012b9:	89 c8                	mov    %ecx,%eax
  8012bb:	c1 f8 1f             	sar    $0x1f,%eax
  8012be:	29 c2                	sub    %eax,%edx
  8012c0:	89 d0                	mov    %edx,%eax
  8012c2:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012c8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012cd:	f7 e9                	imul   %ecx
  8012cf:	c1 fa 02             	sar    $0x2,%edx
  8012d2:	89 c8                	mov    %ecx,%eax
  8012d4:	c1 f8 1f             	sar    $0x1f,%eax
  8012d7:	29 c2                	sub    %eax,%edx
  8012d9:	89 d0                	mov    %edx,%eax
  8012db:	c1 e0 02             	shl    $0x2,%eax
  8012de:	01 d0                	add    %edx,%eax
  8012e0:	01 c0                	add    %eax,%eax
  8012e2:	29 c1                	sub    %eax,%ecx
  8012e4:	89 ca                	mov    %ecx,%edx
  8012e6:	85 d2                	test   %edx,%edx
  8012e8:	75 9c                	jne    801286 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f4:	48                   	dec    %eax
  8012f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012f8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012fc:	74 3d                	je     80133b <ltostr+0xe2>
		start = 1 ;
  8012fe:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801305:	eb 34                	jmp    80133b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801307:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80130a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130d:	01 d0                	add    %edx,%eax
  80130f:	8a 00                	mov    (%eax),%al
  801311:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801314:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801317:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131a:	01 c2                	add    %eax,%edx
  80131c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80131f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801322:	01 c8                	add    %ecx,%eax
  801324:	8a 00                	mov    (%eax),%al
  801326:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801328:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80132b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132e:	01 c2                	add    %eax,%edx
  801330:	8a 45 eb             	mov    -0x15(%ebp),%al
  801333:	88 02                	mov    %al,(%edx)
		start++ ;
  801335:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801338:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80133b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80133e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801341:	7c c4                	jl     801307 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801343:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801346:	8b 45 0c             	mov    0xc(%ebp),%eax
  801349:	01 d0                	add    %edx,%eax
  80134b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80134e:	90                   	nop
  80134f:	c9                   	leave  
  801350:	c3                   	ret    

00801351 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
  801354:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801357:	ff 75 08             	pushl  0x8(%ebp)
  80135a:	e8 54 fa ff ff       	call   800db3 <strlen>
  80135f:	83 c4 04             	add    $0x4,%esp
  801362:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801365:	ff 75 0c             	pushl  0xc(%ebp)
  801368:	e8 46 fa ff ff       	call   800db3 <strlen>
  80136d:	83 c4 04             	add    $0x4,%esp
  801370:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801373:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80137a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801381:	eb 17                	jmp    80139a <strcconcat+0x49>
		final[s] = str1[s] ;
  801383:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801386:	8b 45 10             	mov    0x10(%ebp),%eax
  801389:	01 c2                	add    %eax,%edx
  80138b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	01 c8                	add    %ecx,%eax
  801393:	8a 00                	mov    (%eax),%al
  801395:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801397:	ff 45 fc             	incl   -0x4(%ebp)
  80139a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80139d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013a0:	7c e1                	jl     801383 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013a2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013a9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013b0:	eb 1f                	jmp    8013d1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013b5:	8d 50 01             	lea    0x1(%eax),%edx
  8013b8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013bb:	89 c2                	mov    %eax,%edx
  8013bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c0:	01 c2                	add    %eax,%edx
  8013c2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c8:	01 c8                	add    %ecx,%eax
  8013ca:	8a 00                	mov    (%eax),%al
  8013cc:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013ce:	ff 45 f8             	incl   -0x8(%ebp)
  8013d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013d4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013d7:	7c d9                	jl     8013b2 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8013df:	01 d0                	add    %edx,%eax
  8013e1:	c6 00 00             	movb   $0x0,(%eax)
}
  8013e4:	90                   	nop
  8013e5:	c9                   	leave  
  8013e6:	c3                   	ret    

008013e7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013e7:	55                   	push   %ebp
  8013e8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8013ed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8013f6:	8b 00                	mov    (%eax),%eax
  8013f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801402:	01 d0                	add    %edx,%eax
  801404:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80140a:	eb 0c                	jmp    801418 <strsplit+0x31>
			*string++ = 0;
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	8d 50 01             	lea    0x1(%eax),%edx
  801412:	89 55 08             	mov    %edx,0x8(%ebp)
  801415:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	8a 00                	mov    (%eax),%al
  80141d:	84 c0                	test   %al,%al
  80141f:	74 18                	je     801439 <strsplit+0x52>
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	8a 00                	mov    (%eax),%al
  801426:	0f be c0             	movsbl %al,%eax
  801429:	50                   	push   %eax
  80142a:	ff 75 0c             	pushl  0xc(%ebp)
  80142d:	e8 13 fb ff ff       	call   800f45 <strchr>
  801432:	83 c4 08             	add    $0x8,%esp
  801435:	85 c0                	test   %eax,%eax
  801437:	75 d3                	jne    80140c <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	8a 00                	mov    (%eax),%al
  80143e:	84 c0                	test   %al,%al
  801440:	74 5a                	je     80149c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801442:	8b 45 14             	mov    0x14(%ebp),%eax
  801445:	8b 00                	mov    (%eax),%eax
  801447:	83 f8 0f             	cmp    $0xf,%eax
  80144a:	75 07                	jne    801453 <strsplit+0x6c>
		{
			return 0;
  80144c:	b8 00 00 00 00       	mov    $0x0,%eax
  801451:	eb 66                	jmp    8014b9 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801453:	8b 45 14             	mov    0x14(%ebp),%eax
  801456:	8b 00                	mov    (%eax),%eax
  801458:	8d 48 01             	lea    0x1(%eax),%ecx
  80145b:	8b 55 14             	mov    0x14(%ebp),%edx
  80145e:	89 0a                	mov    %ecx,(%edx)
  801460:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801467:	8b 45 10             	mov    0x10(%ebp),%eax
  80146a:	01 c2                	add    %eax,%edx
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801471:	eb 03                	jmp    801476 <strsplit+0x8f>
			string++;
  801473:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801476:	8b 45 08             	mov    0x8(%ebp),%eax
  801479:	8a 00                	mov    (%eax),%al
  80147b:	84 c0                	test   %al,%al
  80147d:	74 8b                	je     80140a <strsplit+0x23>
  80147f:	8b 45 08             	mov    0x8(%ebp),%eax
  801482:	8a 00                	mov    (%eax),%al
  801484:	0f be c0             	movsbl %al,%eax
  801487:	50                   	push   %eax
  801488:	ff 75 0c             	pushl  0xc(%ebp)
  80148b:	e8 b5 fa ff ff       	call   800f45 <strchr>
  801490:	83 c4 08             	add    $0x8,%esp
  801493:	85 c0                	test   %eax,%eax
  801495:	74 dc                	je     801473 <strsplit+0x8c>
			string++;
	}
  801497:	e9 6e ff ff ff       	jmp    80140a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80149c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80149d:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a0:	8b 00                	mov    (%eax),%eax
  8014a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ac:	01 d0                	add    %edx,%eax
  8014ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014b4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014b9:	c9                   	leave  
  8014ba:	c3                   	ret    

008014bb <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014bb:	55                   	push   %ebp
  8014bc:	89 e5                	mov    %esp,%ebp
  8014be:	57                   	push   %edi
  8014bf:	56                   	push   %esi
  8014c0:	53                   	push   %ebx
  8014c1:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014cd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014d0:	8b 7d 18             	mov    0x18(%ebp),%edi
  8014d3:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8014d6:	cd 30                	int    $0x30
  8014d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014db:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8014de:	83 c4 10             	add    $0x10,%esp
  8014e1:	5b                   	pop    %ebx
  8014e2:	5e                   	pop    %esi
  8014e3:	5f                   	pop    %edi
  8014e4:	5d                   	pop    %ebp
  8014e5:	c3                   	ret    

008014e6 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8014e6:	55                   	push   %ebp
  8014e7:	89 e5                	mov    %esp,%ebp
  8014e9:	83 ec 04             	sub    $0x4,%esp
  8014ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ef:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8014f2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	52                   	push   %edx
  8014fe:	ff 75 0c             	pushl  0xc(%ebp)
  801501:	50                   	push   %eax
  801502:	6a 00                	push   $0x0
  801504:	e8 b2 ff ff ff       	call   8014bb <syscall>
  801509:	83 c4 18             	add    $0x18,%esp
}
  80150c:	90                   	nop
  80150d:	c9                   	leave  
  80150e:	c3                   	ret    

0080150f <sys_cgetc>:

int
sys_cgetc(void)
{
  80150f:	55                   	push   %ebp
  801510:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	6a 01                	push   $0x1
  80151e:	e8 98 ff ff ff       	call   8014bb <syscall>
  801523:	83 c4 18             	add    $0x18,%esp
}
  801526:	c9                   	leave  
  801527:	c3                   	ret    

00801528 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801528:	55                   	push   %ebp
  801529:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80152b:	8b 45 08             	mov    0x8(%ebp),%eax
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	50                   	push   %eax
  801537:	6a 05                	push   $0x5
  801539:	e8 7d ff ff ff       	call   8014bb <syscall>
  80153e:	83 c4 18             	add    $0x18,%esp
}
  801541:	c9                   	leave  
  801542:	c3                   	ret    

00801543 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801543:	55                   	push   %ebp
  801544:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 02                	push   $0x2
  801552:	e8 64 ff ff ff       	call   8014bb <syscall>
  801557:	83 c4 18             	add    $0x18,%esp
}
  80155a:	c9                   	leave  
  80155b:	c3                   	ret    

0080155c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80155c:	55                   	push   %ebp
  80155d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80155f:	6a 00                	push   $0x0
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	6a 00                	push   $0x0
  801569:	6a 03                	push   $0x3
  80156b:	e8 4b ff ff ff       	call   8014bb <syscall>
  801570:	83 c4 18             	add    $0x18,%esp
}
  801573:	c9                   	leave  
  801574:	c3                   	ret    

00801575 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801575:	55                   	push   %ebp
  801576:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 04                	push   $0x4
  801584:	e8 32 ff ff ff       	call   8014bb <syscall>
  801589:	83 c4 18             	add    $0x18,%esp
}
  80158c:	c9                   	leave  
  80158d:	c3                   	ret    

0080158e <sys_env_exit>:


void sys_env_exit(void)
{
  80158e:	55                   	push   %ebp
  80158f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801591:	6a 00                	push   $0x0
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 06                	push   $0x6
  80159d:	e8 19 ff ff ff       	call   8014bb <syscall>
  8015a2:	83 c4 18             	add    $0x18,%esp
}
  8015a5:	90                   	nop
  8015a6:	c9                   	leave  
  8015a7:	c3                   	ret    

008015a8 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8015a8:	55                   	push   %ebp
  8015a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	52                   	push   %edx
  8015b8:	50                   	push   %eax
  8015b9:	6a 07                	push   $0x7
  8015bb:	e8 fb fe ff ff       	call   8014bb <syscall>
  8015c0:	83 c4 18             	add    $0x18,%esp
}
  8015c3:	c9                   	leave  
  8015c4:	c3                   	ret    

008015c5 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
  8015c8:	56                   	push   %esi
  8015c9:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015ca:	8b 75 18             	mov    0x18(%ebp),%esi
  8015cd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015d0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d9:	56                   	push   %esi
  8015da:	53                   	push   %ebx
  8015db:	51                   	push   %ecx
  8015dc:	52                   	push   %edx
  8015dd:	50                   	push   %eax
  8015de:	6a 08                	push   $0x8
  8015e0:	e8 d6 fe ff ff       	call   8014bb <syscall>
  8015e5:	83 c4 18             	add    $0x18,%esp
}
  8015e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015eb:	5b                   	pop    %ebx
  8015ec:	5e                   	pop    %esi
  8015ed:	5d                   	pop    %ebp
  8015ee:	c3                   	ret    

008015ef <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8015f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	52                   	push   %edx
  8015ff:	50                   	push   %eax
  801600:	6a 09                	push   $0x9
  801602:	e8 b4 fe ff ff       	call   8014bb <syscall>
  801607:	83 c4 18             	add    $0x18,%esp
}
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	ff 75 0c             	pushl  0xc(%ebp)
  801618:	ff 75 08             	pushl  0x8(%ebp)
  80161b:	6a 0a                	push   $0xa
  80161d:	e8 99 fe ff ff       	call   8014bb <syscall>
  801622:	83 c4 18             	add    $0x18,%esp
}
  801625:	c9                   	leave  
  801626:	c3                   	ret    

00801627 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801627:	55                   	push   %ebp
  801628:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	6a 0b                	push   $0xb
  801636:	e8 80 fe ff ff       	call   8014bb <syscall>
  80163b:	83 c4 18             	add    $0x18,%esp
}
  80163e:	c9                   	leave  
  80163f:	c3                   	ret    

00801640 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801640:	55                   	push   %ebp
  801641:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 0c                	push   $0xc
  80164f:	e8 67 fe ff ff       	call   8014bb <syscall>
  801654:	83 c4 18             	add    $0x18,%esp
}
  801657:	c9                   	leave  
  801658:	c3                   	ret    

00801659 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801659:	55                   	push   %ebp
  80165a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 0d                	push   $0xd
  801668:	e8 4e fe ff ff       	call   8014bb <syscall>
  80166d:	83 c4 18             	add    $0x18,%esp
}
  801670:	c9                   	leave  
  801671:	c3                   	ret    

00801672 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801672:	55                   	push   %ebp
  801673:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	ff 75 0c             	pushl  0xc(%ebp)
  80167e:	ff 75 08             	pushl  0x8(%ebp)
  801681:	6a 11                	push   $0x11
  801683:	e8 33 fe ff ff       	call   8014bb <syscall>
  801688:	83 c4 18             	add    $0x18,%esp
	return;
  80168b:	90                   	nop
}
  80168c:	c9                   	leave  
  80168d:	c3                   	ret    

0080168e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80168e:	55                   	push   %ebp
  80168f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	ff 75 0c             	pushl  0xc(%ebp)
  80169a:	ff 75 08             	pushl  0x8(%ebp)
  80169d:	6a 12                	push   $0x12
  80169f:	e8 17 fe ff ff       	call   8014bb <syscall>
  8016a4:	83 c4 18             	add    $0x18,%esp
	return ;
  8016a7:	90                   	nop
}
  8016a8:	c9                   	leave  
  8016a9:	c3                   	ret    

008016aa <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016aa:	55                   	push   %ebp
  8016ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 0e                	push   $0xe
  8016b9:	e8 fd fd ff ff       	call   8014bb <syscall>
  8016be:	83 c4 18             	add    $0x18,%esp
}
  8016c1:	c9                   	leave  
  8016c2:	c3                   	ret    

008016c3 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016c3:	55                   	push   %ebp
  8016c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	ff 75 08             	pushl  0x8(%ebp)
  8016d1:	6a 0f                	push   $0xf
  8016d3:	e8 e3 fd ff ff       	call   8014bb <syscall>
  8016d8:	83 c4 18             	add    $0x18,%esp
}
  8016db:	c9                   	leave  
  8016dc:	c3                   	ret    

008016dd <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016dd:	55                   	push   %ebp
  8016de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 10                	push   $0x10
  8016ec:	e8 ca fd ff ff       	call   8014bb <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
}
  8016f4:	90                   	nop
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 14                	push   $0x14
  801706:	e8 b0 fd ff ff       	call   8014bb <syscall>
  80170b:	83 c4 18             	add    $0x18,%esp
}
  80170e:	90                   	nop
  80170f:	c9                   	leave  
  801710:	c3                   	ret    

00801711 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801711:	55                   	push   %ebp
  801712:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 15                	push   $0x15
  801720:	e8 96 fd ff ff       	call   8014bb <syscall>
  801725:	83 c4 18             	add    $0x18,%esp
}
  801728:	90                   	nop
  801729:	c9                   	leave  
  80172a:	c3                   	ret    

0080172b <sys_cputc>:


void
sys_cputc(const char c)
{
  80172b:	55                   	push   %ebp
  80172c:	89 e5                	mov    %esp,%ebp
  80172e:	83 ec 04             	sub    $0x4,%esp
  801731:	8b 45 08             	mov    0x8(%ebp),%eax
  801734:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801737:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	50                   	push   %eax
  801744:	6a 16                	push   $0x16
  801746:	e8 70 fd ff ff       	call   8014bb <syscall>
  80174b:	83 c4 18             	add    $0x18,%esp
}
  80174e:	90                   	nop
  80174f:	c9                   	leave  
  801750:	c3                   	ret    

00801751 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801751:	55                   	push   %ebp
  801752:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801754:	6a 00                	push   $0x0
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 17                	push   $0x17
  801760:	e8 56 fd ff ff       	call   8014bb <syscall>
  801765:	83 c4 18             	add    $0x18,%esp
}
  801768:	90                   	nop
  801769:	c9                   	leave  
  80176a:	c3                   	ret    

0080176b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80176b:	55                   	push   %ebp
  80176c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80176e:	8b 45 08             	mov    0x8(%ebp),%eax
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	ff 75 0c             	pushl  0xc(%ebp)
  80177a:	50                   	push   %eax
  80177b:	6a 18                	push   $0x18
  80177d:	e8 39 fd ff ff       	call   8014bb <syscall>
  801782:	83 c4 18             	add    $0x18,%esp
}
  801785:	c9                   	leave  
  801786:	c3                   	ret    

00801787 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801787:	55                   	push   %ebp
  801788:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80178a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80178d:	8b 45 08             	mov    0x8(%ebp),%eax
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	52                   	push   %edx
  801797:	50                   	push   %eax
  801798:	6a 1b                	push   $0x1b
  80179a:	e8 1c fd ff ff       	call   8014bb <syscall>
  80179f:	83 c4 18             	add    $0x18,%esp
}
  8017a2:	c9                   	leave  
  8017a3:	c3                   	ret    

008017a4 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017a4:	55                   	push   %ebp
  8017a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	52                   	push   %edx
  8017b4:	50                   	push   %eax
  8017b5:	6a 19                	push   $0x19
  8017b7:	e8 ff fc ff ff       	call   8014bb <syscall>
  8017bc:	83 c4 18             	add    $0x18,%esp
}
  8017bf:	90                   	nop
  8017c0:	c9                   	leave  
  8017c1:	c3                   	ret    

008017c2 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017c2:	55                   	push   %ebp
  8017c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	52                   	push   %edx
  8017d2:	50                   	push   %eax
  8017d3:	6a 1a                	push   $0x1a
  8017d5:	e8 e1 fc ff ff       	call   8014bb <syscall>
  8017da:	83 c4 18             	add    $0x18,%esp
}
  8017dd:	90                   	nop
  8017de:	c9                   	leave  
  8017df:	c3                   	ret    

008017e0 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8017e0:	55                   	push   %ebp
  8017e1:	89 e5                	mov    %esp,%ebp
  8017e3:	83 ec 04             	sub    $0x4,%esp
  8017e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8017e9:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8017ec:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017ef:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f6:	6a 00                	push   $0x0
  8017f8:	51                   	push   %ecx
  8017f9:	52                   	push   %edx
  8017fa:	ff 75 0c             	pushl  0xc(%ebp)
  8017fd:	50                   	push   %eax
  8017fe:	6a 1c                	push   $0x1c
  801800:	e8 b6 fc ff ff       	call   8014bb <syscall>
  801805:	83 c4 18             	add    $0x18,%esp
}
  801808:	c9                   	leave  
  801809:	c3                   	ret    

0080180a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80180a:	55                   	push   %ebp
  80180b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80180d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801810:	8b 45 08             	mov    0x8(%ebp),%eax
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	52                   	push   %edx
  80181a:	50                   	push   %eax
  80181b:	6a 1d                	push   $0x1d
  80181d:	e8 99 fc ff ff       	call   8014bb <syscall>
  801822:	83 c4 18             	add    $0x18,%esp
}
  801825:	c9                   	leave  
  801826:	c3                   	ret    

00801827 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801827:	55                   	push   %ebp
  801828:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80182a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80182d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801830:	8b 45 08             	mov    0x8(%ebp),%eax
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	51                   	push   %ecx
  801838:	52                   	push   %edx
  801839:	50                   	push   %eax
  80183a:	6a 1e                	push   $0x1e
  80183c:	e8 7a fc ff ff       	call   8014bb <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
}
  801844:	c9                   	leave  
  801845:	c3                   	ret    

00801846 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801846:	55                   	push   %ebp
  801847:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801849:	8b 55 0c             	mov    0xc(%ebp),%edx
  80184c:	8b 45 08             	mov    0x8(%ebp),%eax
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	52                   	push   %edx
  801856:	50                   	push   %eax
  801857:	6a 1f                	push   $0x1f
  801859:	e8 5d fc ff ff       	call   8014bb <syscall>
  80185e:	83 c4 18             	add    $0x18,%esp
}
  801861:	c9                   	leave  
  801862:	c3                   	ret    

00801863 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801863:	55                   	push   %ebp
  801864:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 20                	push   $0x20
  801872:	e8 44 fc ff ff       	call   8014bb <syscall>
  801877:	83 c4 18             	add    $0x18,%esp
}
  80187a:	c9                   	leave  
  80187b:	c3                   	ret    

0080187c <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80187c:	55                   	push   %ebp
  80187d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80187f:	8b 45 08             	mov    0x8(%ebp),%eax
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	ff 75 10             	pushl  0x10(%ebp)
  801889:	ff 75 0c             	pushl  0xc(%ebp)
  80188c:	50                   	push   %eax
  80188d:	6a 21                	push   $0x21
  80188f:	e8 27 fc ff ff       	call   8014bb <syscall>
  801894:	83 c4 18             	add    $0x18,%esp
}
  801897:	c9                   	leave  
  801898:	c3                   	ret    

00801899 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801899:	55                   	push   %ebp
  80189a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80189c:	8b 45 08             	mov    0x8(%ebp),%eax
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	50                   	push   %eax
  8018a8:	6a 22                	push   $0x22
  8018aa:	e8 0c fc ff ff       	call   8014bb <syscall>
  8018af:	83 c4 18             	add    $0x18,%esp
}
  8018b2:	90                   	nop
  8018b3:	c9                   	leave  
  8018b4:	c3                   	ret    

008018b5 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8018b5:	55                   	push   %ebp
  8018b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8018b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	50                   	push   %eax
  8018c4:	6a 23                	push   $0x23
  8018c6:	e8 f0 fb ff ff       	call   8014bb <syscall>
  8018cb:	83 c4 18             	add    $0x18,%esp
}
  8018ce:	90                   	nop
  8018cf:	c9                   	leave  
  8018d0:	c3                   	ret    

008018d1 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8018d1:	55                   	push   %ebp
  8018d2:	89 e5                	mov    %esp,%ebp
  8018d4:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8018d7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018da:	8d 50 04             	lea    0x4(%eax),%edx
  8018dd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	52                   	push   %edx
  8018e7:	50                   	push   %eax
  8018e8:	6a 24                	push   $0x24
  8018ea:	e8 cc fb ff ff       	call   8014bb <syscall>
  8018ef:	83 c4 18             	add    $0x18,%esp
	return result;
  8018f2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018f8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018fb:	89 01                	mov    %eax,(%ecx)
  8018fd:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801900:	8b 45 08             	mov    0x8(%ebp),%eax
  801903:	c9                   	leave  
  801904:	c2 04 00             	ret    $0x4

00801907 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801907:	55                   	push   %ebp
  801908:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	ff 75 10             	pushl  0x10(%ebp)
  801911:	ff 75 0c             	pushl  0xc(%ebp)
  801914:	ff 75 08             	pushl  0x8(%ebp)
  801917:	6a 13                	push   $0x13
  801919:	e8 9d fb ff ff       	call   8014bb <syscall>
  80191e:	83 c4 18             	add    $0x18,%esp
	return ;
  801921:	90                   	nop
}
  801922:	c9                   	leave  
  801923:	c3                   	ret    

00801924 <sys_rcr2>:
uint32 sys_rcr2()
{
  801924:	55                   	push   %ebp
  801925:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	6a 25                	push   $0x25
  801933:	e8 83 fb ff ff       	call   8014bb <syscall>
  801938:	83 c4 18             	add    $0x18,%esp
}
  80193b:	c9                   	leave  
  80193c:	c3                   	ret    

0080193d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80193d:	55                   	push   %ebp
  80193e:	89 e5                	mov    %esp,%ebp
  801940:	83 ec 04             	sub    $0x4,%esp
  801943:	8b 45 08             	mov    0x8(%ebp),%eax
  801946:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801949:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	50                   	push   %eax
  801956:	6a 26                	push   $0x26
  801958:	e8 5e fb ff ff       	call   8014bb <syscall>
  80195d:	83 c4 18             	add    $0x18,%esp
	return ;
  801960:	90                   	nop
}
  801961:	c9                   	leave  
  801962:	c3                   	ret    

00801963 <rsttst>:
void rsttst()
{
  801963:	55                   	push   %ebp
  801964:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 28                	push   $0x28
  801972:	e8 44 fb ff ff       	call   8014bb <syscall>
  801977:	83 c4 18             	add    $0x18,%esp
	return ;
  80197a:	90                   	nop
}
  80197b:	c9                   	leave  
  80197c:	c3                   	ret    

0080197d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80197d:	55                   	push   %ebp
  80197e:	89 e5                	mov    %esp,%ebp
  801980:	83 ec 04             	sub    $0x4,%esp
  801983:	8b 45 14             	mov    0x14(%ebp),%eax
  801986:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801989:	8b 55 18             	mov    0x18(%ebp),%edx
  80198c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801990:	52                   	push   %edx
  801991:	50                   	push   %eax
  801992:	ff 75 10             	pushl  0x10(%ebp)
  801995:	ff 75 0c             	pushl  0xc(%ebp)
  801998:	ff 75 08             	pushl  0x8(%ebp)
  80199b:	6a 27                	push   $0x27
  80199d:	e8 19 fb ff ff       	call   8014bb <syscall>
  8019a2:	83 c4 18             	add    $0x18,%esp
	return ;
  8019a5:	90                   	nop
}
  8019a6:	c9                   	leave  
  8019a7:	c3                   	ret    

008019a8 <chktst>:
void chktst(uint32 n)
{
  8019a8:	55                   	push   %ebp
  8019a9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 00                	push   $0x0
  8019b3:	ff 75 08             	pushl  0x8(%ebp)
  8019b6:	6a 29                	push   $0x29
  8019b8:	e8 fe fa ff ff       	call   8014bb <syscall>
  8019bd:	83 c4 18             	add    $0x18,%esp
	return ;
  8019c0:	90                   	nop
}
  8019c1:	c9                   	leave  
  8019c2:	c3                   	ret    

008019c3 <inctst>:

void inctst()
{
  8019c3:	55                   	push   %ebp
  8019c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 00                	push   $0x0
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 2a                	push   $0x2a
  8019d2:	e8 e4 fa ff ff       	call   8014bb <syscall>
  8019d7:	83 c4 18             	add    $0x18,%esp
	return ;
  8019da:	90                   	nop
}
  8019db:	c9                   	leave  
  8019dc:	c3                   	ret    

008019dd <gettst>:
uint32 gettst()
{
  8019dd:	55                   	push   %ebp
  8019de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 2b                	push   $0x2b
  8019ec:	e8 ca fa ff ff       	call   8014bb <syscall>
  8019f1:	83 c4 18             	add    $0x18,%esp
}
  8019f4:	c9                   	leave  
  8019f5:	c3                   	ret    

008019f6 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8019f6:	55                   	push   %ebp
  8019f7:	89 e5                	mov    %esp,%ebp
  8019f9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	6a 2c                	push   $0x2c
  801a08:	e8 ae fa ff ff       	call   8014bb <syscall>
  801a0d:	83 c4 18             	add    $0x18,%esp
  801a10:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a13:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a17:	75 07                	jne    801a20 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a19:	b8 01 00 00 00       	mov    $0x1,%eax
  801a1e:	eb 05                	jmp    801a25 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a20:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a25:	c9                   	leave  
  801a26:	c3                   	ret    

00801a27 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a27:	55                   	push   %ebp
  801a28:	89 e5                	mov    %esp,%ebp
  801a2a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	6a 00                	push   $0x0
  801a35:	6a 00                	push   $0x0
  801a37:	6a 2c                	push   $0x2c
  801a39:	e8 7d fa ff ff       	call   8014bb <syscall>
  801a3e:	83 c4 18             	add    $0x18,%esp
  801a41:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a44:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a48:	75 07                	jne    801a51 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a4a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a4f:	eb 05                	jmp    801a56 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a51:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a56:	c9                   	leave  
  801a57:	c3                   	ret    

00801a58 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a58:	55                   	push   %ebp
  801a59:	89 e5                	mov    %esp,%ebp
  801a5b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a5e:	6a 00                	push   $0x0
  801a60:	6a 00                	push   $0x0
  801a62:	6a 00                	push   $0x0
  801a64:	6a 00                	push   $0x0
  801a66:	6a 00                	push   $0x0
  801a68:	6a 2c                	push   $0x2c
  801a6a:	e8 4c fa ff ff       	call   8014bb <syscall>
  801a6f:	83 c4 18             	add    $0x18,%esp
  801a72:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a75:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a79:	75 07                	jne    801a82 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a7b:	b8 01 00 00 00       	mov    $0x1,%eax
  801a80:	eb 05                	jmp    801a87 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a82:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a87:	c9                   	leave  
  801a88:	c3                   	ret    

00801a89 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a89:	55                   	push   %ebp
  801a8a:	89 e5                	mov    %esp,%ebp
  801a8c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 2c                	push   $0x2c
  801a9b:	e8 1b fa ff ff       	call   8014bb <syscall>
  801aa0:	83 c4 18             	add    $0x18,%esp
  801aa3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801aa6:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801aaa:	75 07                	jne    801ab3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801aac:	b8 01 00 00 00       	mov    $0x1,%eax
  801ab1:	eb 05                	jmp    801ab8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ab3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ab8:	c9                   	leave  
  801ab9:	c3                   	ret    

00801aba <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801aba:	55                   	push   %ebp
  801abb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	ff 75 08             	pushl  0x8(%ebp)
  801ac8:	6a 2d                	push   $0x2d
  801aca:	e8 ec f9 ff ff       	call   8014bb <syscall>
  801acf:	83 c4 18             	add    $0x18,%esp
	return ;
  801ad2:	90                   	nop
}
  801ad3:	c9                   	leave  
  801ad4:	c3                   	ret    
  801ad5:	66 90                	xchg   %ax,%ax
  801ad7:	90                   	nop

00801ad8 <__udivdi3>:
  801ad8:	55                   	push   %ebp
  801ad9:	57                   	push   %edi
  801ada:	56                   	push   %esi
  801adb:	53                   	push   %ebx
  801adc:	83 ec 1c             	sub    $0x1c,%esp
  801adf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ae3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ae7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801aeb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801aef:	89 ca                	mov    %ecx,%edx
  801af1:	89 f8                	mov    %edi,%eax
  801af3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801af7:	85 f6                	test   %esi,%esi
  801af9:	75 2d                	jne    801b28 <__udivdi3+0x50>
  801afb:	39 cf                	cmp    %ecx,%edi
  801afd:	77 65                	ja     801b64 <__udivdi3+0x8c>
  801aff:	89 fd                	mov    %edi,%ebp
  801b01:	85 ff                	test   %edi,%edi
  801b03:	75 0b                	jne    801b10 <__udivdi3+0x38>
  801b05:	b8 01 00 00 00       	mov    $0x1,%eax
  801b0a:	31 d2                	xor    %edx,%edx
  801b0c:	f7 f7                	div    %edi
  801b0e:	89 c5                	mov    %eax,%ebp
  801b10:	31 d2                	xor    %edx,%edx
  801b12:	89 c8                	mov    %ecx,%eax
  801b14:	f7 f5                	div    %ebp
  801b16:	89 c1                	mov    %eax,%ecx
  801b18:	89 d8                	mov    %ebx,%eax
  801b1a:	f7 f5                	div    %ebp
  801b1c:	89 cf                	mov    %ecx,%edi
  801b1e:	89 fa                	mov    %edi,%edx
  801b20:	83 c4 1c             	add    $0x1c,%esp
  801b23:	5b                   	pop    %ebx
  801b24:	5e                   	pop    %esi
  801b25:	5f                   	pop    %edi
  801b26:	5d                   	pop    %ebp
  801b27:	c3                   	ret    
  801b28:	39 ce                	cmp    %ecx,%esi
  801b2a:	77 28                	ja     801b54 <__udivdi3+0x7c>
  801b2c:	0f bd fe             	bsr    %esi,%edi
  801b2f:	83 f7 1f             	xor    $0x1f,%edi
  801b32:	75 40                	jne    801b74 <__udivdi3+0x9c>
  801b34:	39 ce                	cmp    %ecx,%esi
  801b36:	72 0a                	jb     801b42 <__udivdi3+0x6a>
  801b38:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b3c:	0f 87 9e 00 00 00    	ja     801be0 <__udivdi3+0x108>
  801b42:	b8 01 00 00 00       	mov    $0x1,%eax
  801b47:	89 fa                	mov    %edi,%edx
  801b49:	83 c4 1c             	add    $0x1c,%esp
  801b4c:	5b                   	pop    %ebx
  801b4d:	5e                   	pop    %esi
  801b4e:	5f                   	pop    %edi
  801b4f:	5d                   	pop    %ebp
  801b50:	c3                   	ret    
  801b51:	8d 76 00             	lea    0x0(%esi),%esi
  801b54:	31 ff                	xor    %edi,%edi
  801b56:	31 c0                	xor    %eax,%eax
  801b58:	89 fa                	mov    %edi,%edx
  801b5a:	83 c4 1c             	add    $0x1c,%esp
  801b5d:	5b                   	pop    %ebx
  801b5e:	5e                   	pop    %esi
  801b5f:	5f                   	pop    %edi
  801b60:	5d                   	pop    %ebp
  801b61:	c3                   	ret    
  801b62:	66 90                	xchg   %ax,%ax
  801b64:	89 d8                	mov    %ebx,%eax
  801b66:	f7 f7                	div    %edi
  801b68:	31 ff                	xor    %edi,%edi
  801b6a:	89 fa                	mov    %edi,%edx
  801b6c:	83 c4 1c             	add    $0x1c,%esp
  801b6f:	5b                   	pop    %ebx
  801b70:	5e                   	pop    %esi
  801b71:	5f                   	pop    %edi
  801b72:	5d                   	pop    %ebp
  801b73:	c3                   	ret    
  801b74:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b79:	89 eb                	mov    %ebp,%ebx
  801b7b:	29 fb                	sub    %edi,%ebx
  801b7d:	89 f9                	mov    %edi,%ecx
  801b7f:	d3 e6                	shl    %cl,%esi
  801b81:	89 c5                	mov    %eax,%ebp
  801b83:	88 d9                	mov    %bl,%cl
  801b85:	d3 ed                	shr    %cl,%ebp
  801b87:	89 e9                	mov    %ebp,%ecx
  801b89:	09 f1                	or     %esi,%ecx
  801b8b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b8f:	89 f9                	mov    %edi,%ecx
  801b91:	d3 e0                	shl    %cl,%eax
  801b93:	89 c5                	mov    %eax,%ebp
  801b95:	89 d6                	mov    %edx,%esi
  801b97:	88 d9                	mov    %bl,%cl
  801b99:	d3 ee                	shr    %cl,%esi
  801b9b:	89 f9                	mov    %edi,%ecx
  801b9d:	d3 e2                	shl    %cl,%edx
  801b9f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ba3:	88 d9                	mov    %bl,%cl
  801ba5:	d3 e8                	shr    %cl,%eax
  801ba7:	09 c2                	or     %eax,%edx
  801ba9:	89 d0                	mov    %edx,%eax
  801bab:	89 f2                	mov    %esi,%edx
  801bad:	f7 74 24 0c          	divl   0xc(%esp)
  801bb1:	89 d6                	mov    %edx,%esi
  801bb3:	89 c3                	mov    %eax,%ebx
  801bb5:	f7 e5                	mul    %ebp
  801bb7:	39 d6                	cmp    %edx,%esi
  801bb9:	72 19                	jb     801bd4 <__udivdi3+0xfc>
  801bbb:	74 0b                	je     801bc8 <__udivdi3+0xf0>
  801bbd:	89 d8                	mov    %ebx,%eax
  801bbf:	31 ff                	xor    %edi,%edi
  801bc1:	e9 58 ff ff ff       	jmp    801b1e <__udivdi3+0x46>
  801bc6:	66 90                	xchg   %ax,%ax
  801bc8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801bcc:	89 f9                	mov    %edi,%ecx
  801bce:	d3 e2                	shl    %cl,%edx
  801bd0:	39 c2                	cmp    %eax,%edx
  801bd2:	73 e9                	jae    801bbd <__udivdi3+0xe5>
  801bd4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801bd7:	31 ff                	xor    %edi,%edi
  801bd9:	e9 40 ff ff ff       	jmp    801b1e <__udivdi3+0x46>
  801bde:	66 90                	xchg   %ax,%ax
  801be0:	31 c0                	xor    %eax,%eax
  801be2:	e9 37 ff ff ff       	jmp    801b1e <__udivdi3+0x46>
  801be7:	90                   	nop

00801be8 <__umoddi3>:
  801be8:	55                   	push   %ebp
  801be9:	57                   	push   %edi
  801bea:	56                   	push   %esi
  801beb:	53                   	push   %ebx
  801bec:	83 ec 1c             	sub    $0x1c,%esp
  801bef:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801bf3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801bf7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801bfb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801bff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c03:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c07:	89 f3                	mov    %esi,%ebx
  801c09:	89 fa                	mov    %edi,%edx
  801c0b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c0f:	89 34 24             	mov    %esi,(%esp)
  801c12:	85 c0                	test   %eax,%eax
  801c14:	75 1a                	jne    801c30 <__umoddi3+0x48>
  801c16:	39 f7                	cmp    %esi,%edi
  801c18:	0f 86 a2 00 00 00    	jbe    801cc0 <__umoddi3+0xd8>
  801c1e:	89 c8                	mov    %ecx,%eax
  801c20:	89 f2                	mov    %esi,%edx
  801c22:	f7 f7                	div    %edi
  801c24:	89 d0                	mov    %edx,%eax
  801c26:	31 d2                	xor    %edx,%edx
  801c28:	83 c4 1c             	add    $0x1c,%esp
  801c2b:	5b                   	pop    %ebx
  801c2c:	5e                   	pop    %esi
  801c2d:	5f                   	pop    %edi
  801c2e:	5d                   	pop    %ebp
  801c2f:	c3                   	ret    
  801c30:	39 f0                	cmp    %esi,%eax
  801c32:	0f 87 ac 00 00 00    	ja     801ce4 <__umoddi3+0xfc>
  801c38:	0f bd e8             	bsr    %eax,%ebp
  801c3b:	83 f5 1f             	xor    $0x1f,%ebp
  801c3e:	0f 84 ac 00 00 00    	je     801cf0 <__umoddi3+0x108>
  801c44:	bf 20 00 00 00       	mov    $0x20,%edi
  801c49:	29 ef                	sub    %ebp,%edi
  801c4b:	89 fe                	mov    %edi,%esi
  801c4d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c51:	89 e9                	mov    %ebp,%ecx
  801c53:	d3 e0                	shl    %cl,%eax
  801c55:	89 d7                	mov    %edx,%edi
  801c57:	89 f1                	mov    %esi,%ecx
  801c59:	d3 ef                	shr    %cl,%edi
  801c5b:	09 c7                	or     %eax,%edi
  801c5d:	89 e9                	mov    %ebp,%ecx
  801c5f:	d3 e2                	shl    %cl,%edx
  801c61:	89 14 24             	mov    %edx,(%esp)
  801c64:	89 d8                	mov    %ebx,%eax
  801c66:	d3 e0                	shl    %cl,%eax
  801c68:	89 c2                	mov    %eax,%edx
  801c6a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c6e:	d3 e0                	shl    %cl,%eax
  801c70:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c74:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c78:	89 f1                	mov    %esi,%ecx
  801c7a:	d3 e8                	shr    %cl,%eax
  801c7c:	09 d0                	or     %edx,%eax
  801c7e:	d3 eb                	shr    %cl,%ebx
  801c80:	89 da                	mov    %ebx,%edx
  801c82:	f7 f7                	div    %edi
  801c84:	89 d3                	mov    %edx,%ebx
  801c86:	f7 24 24             	mull   (%esp)
  801c89:	89 c6                	mov    %eax,%esi
  801c8b:	89 d1                	mov    %edx,%ecx
  801c8d:	39 d3                	cmp    %edx,%ebx
  801c8f:	0f 82 87 00 00 00    	jb     801d1c <__umoddi3+0x134>
  801c95:	0f 84 91 00 00 00    	je     801d2c <__umoddi3+0x144>
  801c9b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c9f:	29 f2                	sub    %esi,%edx
  801ca1:	19 cb                	sbb    %ecx,%ebx
  801ca3:	89 d8                	mov    %ebx,%eax
  801ca5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ca9:	d3 e0                	shl    %cl,%eax
  801cab:	89 e9                	mov    %ebp,%ecx
  801cad:	d3 ea                	shr    %cl,%edx
  801caf:	09 d0                	or     %edx,%eax
  801cb1:	89 e9                	mov    %ebp,%ecx
  801cb3:	d3 eb                	shr    %cl,%ebx
  801cb5:	89 da                	mov    %ebx,%edx
  801cb7:	83 c4 1c             	add    $0x1c,%esp
  801cba:	5b                   	pop    %ebx
  801cbb:	5e                   	pop    %esi
  801cbc:	5f                   	pop    %edi
  801cbd:	5d                   	pop    %ebp
  801cbe:	c3                   	ret    
  801cbf:	90                   	nop
  801cc0:	89 fd                	mov    %edi,%ebp
  801cc2:	85 ff                	test   %edi,%edi
  801cc4:	75 0b                	jne    801cd1 <__umoddi3+0xe9>
  801cc6:	b8 01 00 00 00       	mov    $0x1,%eax
  801ccb:	31 d2                	xor    %edx,%edx
  801ccd:	f7 f7                	div    %edi
  801ccf:	89 c5                	mov    %eax,%ebp
  801cd1:	89 f0                	mov    %esi,%eax
  801cd3:	31 d2                	xor    %edx,%edx
  801cd5:	f7 f5                	div    %ebp
  801cd7:	89 c8                	mov    %ecx,%eax
  801cd9:	f7 f5                	div    %ebp
  801cdb:	89 d0                	mov    %edx,%eax
  801cdd:	e9 44 ff ff ff       	jmp    801c26 <__umoddi3+0x3e>
  801ce2:	66 90                	xchg   %ax,%ax
  801ce4:	89 c8                	mov    %ecx,%eax
  801ce6:	89 f2                	mov    %esi,%edx
  801ce8:	83 c4 1c             	add    $0x1c,%esp
  801ceb:	5b                   	pop    %ebx
  801cec:	5e                   	pop    %esi
  801ced:	5f                   	pop    %edi
  801cee:	5d                   	pop    %ebp
  801cef:	c3                   	ret    
  801cf0:	3b 04 24             	cmp    (%esp),%eax
  801cf3:	72 06                	jb     801cfb <__umoddi3+0x113>
  801cf5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801cf9:	77 0f                	ja     801d0a <__umoddi3+0x122>
  801cfb:	89 f2                	mov    %esi,%edx
  801cfd:	29 f9                	sub    %edi,%ecx
  801cff:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d03:	89 14 24             	mov    %edx,(%esp)
  801d06:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d0a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d0e:	8b 14 24             	mov    (%esp),%edx
  801d11:	83 c4 1c             	add    $0x1c,%esp
  801d14:	5b                   	pop    %ebx
  801d15:	5e                   	pop    %esi
  801d16:	5f                   	pop    %edi
  801d17:	5d                   	pop    %ebp
  801d18:	c3                   	ret    
  801d19:	8d 76 00             	lea    0x0(%esi),%esi
  801d1c:	2b 04 24             	sub    (%esp),%eax
  801d1f:	19 fa                	sbb    %edi,%edx
  801d21:	89 d1                	mov    %edx,%ecx
  801d23:	89 c6                	mov    %eax,%esi
  801d25:	e9 71 ff ff ff       	jmp    801c9b <__umoddi3+0xb3>
  801d2a:	66 90                	xchg   %ax,%ax
  801d2c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d30:	72 ea                	jb     801d1c <__umoddi3+0x134>
  801d32:	89 d9                	mov    %ebx,%ecx
  801d34:	e9 62 ff ff ff       	jmp    801c9b <__umoddi3+0xb3>
