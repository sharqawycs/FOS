
obj/user/tst_table_replacement_basics:     file format elf32-i386


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
  800031:	e8 a2 02 00 00       	call   8002d8 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:


uint8* ptr = (uint8* )0x0800000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 24 00 00 02    	sub    $0x2000024,%esp
	
	

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if ( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x00000000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800042:	a1 08 30 80 00       	mov    0x803008,%eax
  800047:	8b 40 7c             	mov    0x7c(%eax),%eax
  80004a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80004d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800050:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800055:	85 c0                	test   %eax,%eax
  800057:	74 14                	je     80006d <_main+0x35>
  800059:	83 ec 04             	sub    $0x4,%esp
  80005c:	68 a0 1c 80 00       	push   $0x801ca0
  800061:	6a 17                	push   $0x17
  800063:	68 e8 1c 80 00       	push   $0x801ce8
  800068:	e8 6d 03 00 00       	call   8003da <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80006d:	a1 08 30 80 00       	mov    0x803008,%eax
  800072:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  800078:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80007b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007e:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800083:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800088:	74 14                	je     80009e <_main+0x66>
  80008a:	83 ec 04             	sub    $0x4,%esp
  80008d:	68 a0 1c 80 00       	push   $0x801ca0
  800092:	6a 18                	push   $0x18
  800094:	68 e8 1c 80 00       	push   $0x801ce8
  800099:	e8 3c 03 00 00       	call   8003da <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80009e:	a1 08 30 80 00       	mov    0x803008,%eax
  8000a3:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
  8000a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8000ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000af:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000b4:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  8000b9:	74 14                	je     8000cf <_main+0x97>
  8000bb:	83 ec 04             	sub    $0x4,%esp
  8000be:	68 a0 1c 80 00       	push   $0x801ca0
  8000c3:	6a 19                	push   $0x19
  8000c5:	68 e8 1c 80 00       	push   $0x801ce8
  8000ca:	e8 0b 03 00 00       	call   8003da <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000cf:	a1 08 30 80 00       	mov    0x803008,%eax
  8000d4:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
  8000da:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e0:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000e5:	3d 00 00 80 ec       	cmp    $0xec800000,%eax
  8000ea:	74 14                	je     800100 <_main+0xc8>
  8000ec:	83 ec 04             	sub    $0x4,%esp
  8000ef:	68 a0 1c 80 00       	push   $0x801ca0
  8000f4:	6a 1a                	push   $0x1a
  8000f6:	68 e8 1c 80 00       	push   $0x801ce8
  8000fb:	e8 da 02 00 00       	call   8003da <_panic>
		if( myEnv->table_last_WS_index !=  0)  											panic("INITIAL TABLE last index checking failed! Review sizes of the two WS's..!!");
  800100:	a1 08 30 80 00       	mov    0x803008,%eax
  800105:	8b 80 d8 02 00 00    	mov    0x2d8(%eax),%eax
  80010b:	85 c0                	test   %eax,%eax
  80010d:	74 14                	je     800123 <_main+0xeb>
  80010f:	83 ec 04             	sub    $0x4,%esp
  800112:	68 0c 1d 80 00       	push   $0x801d0c
  800117:	6a 1b                	push   $0x1b
  800119:	68 e8 1c 80 00       	push   $0x801ce8
  80011e:	e8 b7 02 00 00       	call   8003da <_panic>

	}
	int freeFrames = sys_calculate_free_frames() ;
  800123:	e8 5c 14 00 00       	call   801584 <sys_calculate_free_frames>
  800128:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  80012b:	e8 d7 14 00 00       	call   801607 <sys_pf_calculate_allocated_pages>
  800130:	89 45 e0             	mov    %eax,-0x20(%ebp)

	{
		arr[0] = -1;
  800133:	c6 85 e0 ff ff fd ff 	movb   $0xff,-0x2000020(%ebp)
		arr[PAGE_SIZE*1024-1] = -1;
  80013a:	c6 85 df ff 3f fe ff 	movb   $0xff,-0x1c00021(%ebp)
		arr[PAGE_SIZE*1024*2-1] = -1;
  800141:	c6 85 df ff 7f fe ff 	movb   $0xff,-0x1800021(%ebp)
		arr[PAGE_SIZE*1024*3-1] = -1;
  800148:	c6 85 df ff bf fe ff 	movb   $0xff,-0x1400021(%ebp)
		arr[PAGE_SIZE*1024*4-1] = -1;
  80014f:	c6 85 df ff ff fe ff 	movb   $0xff,-0x1000021(%ebp)

		arr[PAGE_SIZE*1024*5-1] = -1;
  800156:	c6 85 df ff 3f ff ff 	movb   $0xff,-0xc00021(%ebp)
		arr[PAGE_SIZE*1024*6-1] = -1;
  80015d:	c6 85 df ff 7f ff ff 	movb   $0xff,-0x800021(%ebp)



		if((freeFrames - sys_calculate_free_frames()) != 6 + 6 + 1)	//1 for disk directory + 6 placement STACK pages + 6 page tables for writing these 6 new stack pages on PF
  800164:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800167:	e8 18 14 00 00       	call   801584 <sys_calculate_free_frames>
  80016c:	29 c3                	sub    %eax,%ebx
  80016e:	89 d8                	mov    %ebx,%eax
  800170:	83 f8 0d             	cmp    $0xd,%eax
  800173:	74 14                	je     800189 <_main+0x151>
			panic("Extra/Less memory are wrongly allocated... Table RE-placement shouldn't allocate extra frames") ;
  800175:	83 ec 04             	sub    $0x4,%esp
  800178:	68 58 1d 80 00       	push   $0x801d58
  80017d:	6a 2e                	push   $0x2e
  80017f:	68 e8 1c 80 00       	push   $0x801ce8
  800184:	e8 51 02 00 00       	call   8003da <_panic>

		cprintf("STEP A passed: Dealing with memory works!\n\n\n");
  800189:	83 ec 0c             	sub    $0xc,%esp
  80018c:	68 b8 1d 80 00       	push   $0x801db8
  800191:	e8 f8 04 00 00       	call   80068e <cprintf>
  800196:	83 c4 10             	add    $0x10,%esp

	}
	//cprintf("STEP B: checking the operations with page file... \n");
	{

		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6)		//6 victim page tables should written back into PF
  800199:	e8 69 14 00 00       	call   801607 <sys_pf_calculate_allocated_pages>
  80019e:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001a1:	83 f8 06             	cmp    $0x6,%eax
  8001a4:	74 14                	je     8001ba <_main+0x182>
			panic("Victim table is not written back into page file") ;
  8001a6:	83 ec 04             	sub    $0x4,%esp
  8001a9:	68 e8 1d 80 00       	push   $0x801de8
  8001ae:	6a 37                	push   $0x37
  8001b0:	68 e8 1c 80 00       	push   $0x801ce8
  8001b5:	e8 20 02 00 00       	call   8003da <_panic>

		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001ba:	e8 48 14 00 00       	call   801607 <sys_pf_calculate_allocated_pages>
  8001bf:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(arr[0] != -1) panic("make sure that you get the existing tables from page file") ;
  8001c2:	8a 85 e0 ff ff fd    	mov    -0x2000020(%ebp),%al
  8001c8:	3c ff                	cmp    $0xff,%al
  8001ca:	74 14                	je     8001e0 <_main+0x1a8>
  8001cc:	83 ec 04             	sub    $0x4,%esp
  8001cf:	68 18 1e 80 00       	push   $0x801e18
  8001d4:	6a 3b                	push   $0x3b
  8001d6:	68 e8 1c 80 00       	push   $0x801ce8
  8001db:	e8 fa 01 00 00       	call   8003da <_panic>
		if(arr[PAGE_SIZE*1024-1] != -1) panic("make sure that you get the existing tables from page file") ;
  8001e0:	8a 85 df ff 3f fe    	mov    -0x1c00021(%ebp),%al
  8001e6:	3c ff                	cmp    $0xff,%al
  8001e8:	74 14                	je     8001fe <_main+0x1c6>
  8001ea:	83 ec 04             	sub    $0x4,%esp
  8001ed:	68 18 1e 80 00       	push   $0x801e18
  8001f2:	6a 3c                	push   $0x3c
  8001f4:	68 e8 1c 80 00       	push   $0x801ce8
  8001f9:	e8 dc 01 00 00       	call   8003da <_panic>
		if(arr[PAGE_SIZE*1024*2-1] != -1) panic("make sure that you get the existing tables from page file") ;
  8001fe:	8a 85 df ff 7f fe    	mov    -0x1800021(%ebp),%al
  800204:	3c ff                	cmp    $0xff,%al
  800206:	74 14                	je     80021c <_main+0x1e4>
  800208:	83 ec 04             	sub    $0x4,%esp
  80020b:	68 18 1e 80 00       	push   $0x801e18
  800210:	6a 3d                	push   $0x3d
  800212:	68 e8 1c 80 00       	push   $0x801ce8
  800217:	e8 be 01 00 00       	call   8003da <_panic>
		if(arr[PAGE_SIZE*1024*3-1] != -1) panic("make sure that you get the existing tables from page file") ;
  80021c:	8a 85 df ff bf fe    	mov    -0x1400021(%ebp),%al
  800222:	3c ff                	cmp    $0xff,%al
  800224:	74 14                	je     80023a <_main+0x202>
  800226:	83 ec 04             	sub    $0x4,%esp
  800229:	68 18 1e 80 00       	push   $0x801e18
  80022e:	6a 3e                	push   $0x3e
  800230:	68 e8 1c 80 00       	push   $0x801ce8
  800235:	e8 a0 01 00 00       	call   8003da <_panic>
		if(arr[PAGE_SIZE*1024*4-1] != -1) panic("make sure that you get the existing tables from page file") ;
  80023a:	8a 85 df ff ff fe    	mov    -0x1000021(%ebp),%al
  800240:	3c ff                	cmp    $0xff,%al
  800242:	74 14                	je     800258 <_main+0x220>
  800244:	83 ec 04             	sub    $0x4,%esp
  800247:	68 18 1e 80 00       	push   $0x801e18
  80024c:	6a 3f                	push   $0x3f
  80024e:	68 e8 1c 80 00       	push   $0x801ce8
  800253:	e8 82 01 00 00       	call   8003da <_panic>

		if(arr[PAGE_SIZE*1024*5-1] != -1) panic("make sure that you get the existing tables from page file") ;
  800258:	8a 85 df ff 3f ff    	mov    -0xc00021(%ebp),%al
  80025e:	3c ff                	cmp    $0xff,%al
  800260:	74 14                	je     800276 <_main+0x23e>
  800262:	83 ec 04             	sub    $0x4,%esp
  800265:	68 18 1e 80 00       	push   $0x801e18
  80026a:	6a 41                	push   $0x41
  80026c:	68 e8 1c 80 00       	push   $0x801ce8
  800271:	e8 64 01 00 00       	call   8003da <_panic>
		if(arr[PAGE_SIZE*1024*6-1] != -1) panic("make sure that you get the existing tables from page file") ;
  800276:	8a 85 df ff 7f ff    	mov    -0x800021(%ebp),%al
  80027c:	3c ff                	cmp    $0xff,%al
  80027e:	74 14                	je     800294 <_main+0x25c>
  800280:	83 ec 04             	sub    $0x4,%esp
  800283:	68 18 1e 80 00       	push   $0x801e18
  800288:	6a 42                	push   $0x42
  80028a:	68 e8 1c 80 00       	push   $0x801ce8
  80028f:	e8 46 01 00 00       	call   8003da <_panic>

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("tables not removed from page file correctly.. make sure you delete table from page file after reading it into memory");
  800294:	e8 6e 13 00 00       	call   801607 <sys_pf_calculate_allocated_pages>
  800299:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80029c:	74 14                	je     8002b2 <_main+0x27a>
  80029e:	83 ec 04             	sub    $0x4,%esp
  8002a1:	68 54 1e 80 00       	push   $0x801e54
  8002a6:	6a 44                	push   $0x44
  8002a8:	68 e8 1c 80 00       	push   $0x801ce8
  8002ad:	e8 28 01 00 00       	call   8003da <_panic>

		cprintf("STEP B passed: Dealing with page file works!\n\n\n");
  8002b2:	83 ec 0c             	sub    $0xc,%esp
  8002b5:	68 cc 1e 80 00       	push   $0x801ecc
  8002ba:	e8 cf 03 00 00       	call   80068e <cprintf>
  8002bf:	83 c4 10             	add    $0x10,%esp

	}
	cprintf("Congratulations!! test table replacement (BASIC Operations) completed successfully.\n");
  8002c2:	83 ec 0c             	sub    $0xc,%esp
  8002c5:	68 fc 1e 80 00       	push   $0x801efc
  8002ca:	e8 bf 03 00 00       	call   80068e <cprintf>
  8002cf:	83 c4 10             	add    $0x10,%esp
	return;
  8002d2:	90                   	nop
}
  8002d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8002d6:	c9                   	leave  
  8002d7:	c3                   	ret    

008002d8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8002d8:	55                   	push   %ebp
  8002d9:	89 e5                	mov    %esp,%ebp
  8002db:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8002de:	e8 d6 11 00 00       	call   8014b9 <sys_getenvindex>
  8002e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8002e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002e9:	89 d0                	mov    %edx,%eax
  8002eb:	01 c0                	add    %eax,%eax
  8002ed:	01 d0                	add    %edx,%eax
  8002ef:	c1 e0 02             	shl    $0x2,%eax
  8002f2:	01 d0                	add    %edx,%eax
  8002f4:	c1 e0 06             	shl    $0x6,%eax
  8002f7:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002fc:	a3 08 30 80 00       	mov    %eax,0x803008

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800301:	a1 08 30 80 00       	mov    0x803008,%eax
  800306:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80030c:	84 c0                	test   %al,%al
  80030e:	74 0f                	je     80031f <libmain+0x47>
		binaryname = myEnv->prog_name;
  800310:	a1 08 30 80 00       	mov    0x803008,%eax
  800315:	05 f4 02 00 00       	add    $0x2f4,%eax
  80031a:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80031f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800323:	7e 0a                	jle    80032f <libmain+0x57>
		binaryname = argv[0];
  800325:	8b 45 0c             	mov    0xc(%ebp),%eax
  800328:	8b 00                	mov    (%eax),%eax
  80032a:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  80032f:	83 ec 08             	sub    $0x8,%esp
  800332:	ff 75 0c             	pushl  0xc(%ebp)
  800335:	ff 75 08             	pushl  0x8(%ebp)
  800338:	e8 fb fc ff ff       	call   800038 <_main>
  80033d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800340:	e8 0f 13 00 00       	call   801654 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800345:	83 ec 0c             	sub    $0xc,%esp
  800348:	68 6c 1f 80 00       	push   $0x801f6c
  80034d:	e8 3c 03 00 00       	call   80068e <cprintf>
  800352:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800355:	a1 08 30 80 00       	mov    0x803008,%eax
  80035a:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800360:	a1 08 30 80 00       	mov    0x803008,%eax
  800365:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80036b:	83 ec 04             	sub    $0x4,%esp
  80036e:	52                   	push   %edx
  80036f:	50                   	push   %eax
  800370:	68 94 1f 80 00       	push   $0x801f94
  800375:	e8 14 03 00 00       	call   80068e <cprintf>
  80037a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80037d:	a1 08 30 80 00       	mov    0x803008,%eax
  800382:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800388:	83 ec 08             	sub    $0x8,%esp
  80038b:	50                   	push   %eax
  80038c:	68 b9 1f 80 00       	push   $0x801fb9
  800391:	e8 f8 02 00 00       	call   80068e <cprintf>
  800396:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800399:	83 ec 0c             	sub    $0xc,%esp
  80039c:	68 6c 1f 80 00       	push   $0x801f6c
  8003a1:	e8 e8 02 00 00       	call   80068e <cprintf>
  8003a6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8003a9:	e8 c0 12 00 00       	call   80166e <sys_enable_interrupt>

	// exit gracefully
	exit();
  8003ae:	e8 19 00 00 00       	call   8003cc <exit>
}
  8003b3:	90                   	nop
  8003b4:	c9                   	leave  
  8003b5:	c3                   	ret    

008003b6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003b6:	55                   	push   %ebp
  8003b7:	89 e5                	mov    %esp,%ebp
  8003b9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8003bc:	83 ec 0c             	sub    $0xc,%esp
  8003bf:	6a 00                	push   $0x0
  8003c1:	e8 bf 10 00 00       	call   801485 <sys_env_destroy>
  8003c6:	83 c4 10             	add    $0x10,%esp
}
  8003c9:	90                   	nop
  8003ca:	c9                   	leave  
  8003cb:	c3                   	ret    

008003cc <exit>:

void
exit(void)
{
  8003cc:	55                   	push   %ebp
  8003cd:	89 e5                	mov    %esp,%ebp
  8003cf:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8003d2:	e8 14 11 00 00       	call   8014eb <sys_env_exit>
}
  8003d7:	90                   	nop
  8003d8:	c9                   	leave  
  8003d9:	c3                   	ret    

008003da <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003da:	55                   	push   %ebp
  8003db:	89 e5                	mov    %esp,%ebp
  8003dd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8003e0:	8d 45 10             	lea    0x10(%ebp),%eax
  8003e3:	83 c0 04             	add    $0x4,%eax
  8003e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003e9:	a1 18 30 80 00       	mov    0x803018,%eax
  8003ee:	85 c0                	test   %eax,%eax
  8003f0:	74 16                	je     800408 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8003f2:	a1 18 30 80 00       	mov    0x803018,%eax
  8003f7:	83 ec 08             	sub    $0x8,%esp
  8003fa:	50                   	push   %eax
  8003fb:	68 d0 1f 80 00       	push   $0x801fd0
  800400:	e8 89 02 00 00       	call   80068e <cprintf>
  800405:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800408:	a1 04 30 80 00       	mov    0x803004,%eax
  80040d:	ff 75 0c             	pushl  0xc(%ebp)
  800410:	ff 75 08             	pushl  0x8(%ebp)
  800413:	50                   	push   %eax
  800414:	68 d5 1f 80 00       	push   $0x801fd5
  800419:	e8 70 02 00 00       	call   80068e <cprintf>
  80041e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800421:	8b 45 10             	mov    0x10(%ebp),%eax
  800424:	83 ec 08             	sub    $0x8,%esp
  800427:	ff 75 f4             	pushl  -0xc(%ebp)
  80042a:	50                   	push   %eax
  80042b:	e8 f3 01 00 00       	call   800623 <vcprintf>
  800430:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800433:	83 ec 08             	sub    $0x8,%esp
  800436:	6a 00                	push   $0x0
  800438:	68 f1 1f 80 00       	push   $0x801ff1
  80043d:	e8 e1 01 00 00       	call   800623 <vcprintf>
  800442:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800445:	e8 82 ff ff ff       	call   8003cc <exit>

	// should not return here
	while (1) ;
  80044a:	eb fe                	jmp    80044a <_panic+0x70>

0080044c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80044c:	55                   	push   %ebp
  80044d:	89 e5                	mov    %esp,%ebp
  80044f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800452:	a1 08 30 80 00       	mov    0x803008,%eax
  800457:	8b 50 74             	mov    0x74(%eax),%edx
  80045a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80045d:	39 c2                	cmp    %eax,%edx
  80045f:	74 14                	je     800475 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800461:	83 ec 04             	sub    $0x4,%esp
  800464:	68 f4 1f 80 00       	push   $0x801ff4
  800469:	6a 26                	push   $0x26
  80046b:	68 40 20 80 00       	push   $0x802040
  800470:	e8 65 ff ff ff       	call   8003da <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800475:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80047c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800483:	e9 c2 00 00 00       	jmp    80054a <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800488:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80048b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800492:	8b 45 08             	mov    0x8(%ebp),%eax
  800495:	01 d0                	add    %edx,%eax
  800497:	8b 00                	mov    (%eax),%eax
  800499:	85 c0                	test   %eax,%eax
  80049b:	75 08                	jne    8004a5 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80049d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8004a0:	e9 a2 00 00 00       	jmp    800547 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8004a5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004ac:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8004b3:	eb 69                	jmp    80051e <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004b5:	a1 08 30 80 00       	mov    0x803008,%eax
  8004ba:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004c0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004c3:	89 d0                	mov    %edx,%eax
  8004c5:	01 c0                	add    %eax,%eax
  8004c7:	01 d0                	add    %edx,%eax
  8004c9:	c1 e0 02             	shl    $0x2,%eax
  8004cc:	01 c8                	add    %ecx,%eax
  8004ce:	8a 40 04             	mov    0x4(%eax),%al
  8004d1:	84 c0                	test   %al,%al
  8004d3:	75 46                	jne    80051b <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004d5:	a1 08 30 80 00       	mov    0x803008,%eax
  8004da:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004e0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004e3:	89 d0                	mov    %edx,%eax
  8004e5:	01 c0                	add    %eax,%eax
  8004e7:	01 d0                	add    %edx,%eax
  8004e9:	c1 e0 02             	shl    $0x2,%eax
  8004ec:	01 c8                	add    %ecx,%eax
  8004ee:	8b 00                	mov    (%eax),%eax
  8004f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004f3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004fb:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8004fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800500:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800507:	8b 45 08             	mov    0x8(%ebp),%eax
  80050a:	01 c8                	add    %ecx,%eax
  80050c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80050e:	39 c2                	cmp    %eax,%edx
  800510:	75 09                	jne    80051b <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800512:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800519:	eb 12                	jmp    80052d <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80051b:	ff 45 e8             	incl   -0x18(%ebp)
  80051e:	a1 08 30 80 00       	mov    0x803008,%eax
  800523:	8b 50 74             	mov    0x74(%eax),%edx
  800526:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800529:	39 c2                	cmp    %eax,%edx
  80052b:	77 88                	ja     8004b5 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80052d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800531:	75 14                	jne    800547 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800533:	83 ec 04             	sub    $0x4,%esp
  800536:	68 4c 20 80 00       	push   $0x80204c
  80053b:	6a 3a                	push   $0x3a
  80053d:	68 40 20 80 00       	push   $0x802040
  800542:	e8 93 fe ff ff       	call   8003da <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800547:	ff 45 f0             	incl   -0x10(%ebp)
  80054a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80054d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800550:	0f 8c 32 ff ff ff    	jl     800488 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800556:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80055d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800564:	eb 26                	jmp    80058c <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800566:	a1 08 30 80 00       	mov    0x803008,%eax
  80056b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800571:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800574:	89 d0                	mov    %edx,%eax
  800576:	01 c0                	add    %eax,%eax
  800578:	01 d0                	add    %edx,%eax
  80057a:	c1 e0 02             	shl    $0x2,%eax
  80057d:	01 c8                	add    %ecx,%eax
  80057f:	8a 40 04             	mov    0x4(%eax),%al
  800582:	3c 01                	cmp    $0x1,%al
  800584:	75 03                	jne    800589 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800586:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800589:	ff 45 e0             	incl   -0x20(%ebp)
  80058c:	a1 08 30 80 00       	mov    0x803008,%eax
  800591:	8b 50 74             	mov    0x74(%eax),%edx
  800594:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800597:	39 c2                	cmp    %eax,%edx
  800599:	77 cb                	ja     800566 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80059b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80059e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005a1:	74 14                	je     8005b7 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8005a3:	83 ec 04             	sub    $0x4,%esp
  8005a6:	68 a0 20 80 00       	push   $0x8020a0
  8005ab:	6a 44                	push   $0x44
  8005ad:	68 40 20 80 00       	push   $0x802040
  8005b2:	e8 23 fe ff ff       	call   8003da <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005b7:	90                   	nop
  8005b8:	c9                   	leave  
  8005b9:	c3                   	ret    

008005ba <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8005ba:	55                   	push   %ebp
  8005bb:	89 e5                	mov    %esp,%ebp
  8005bd:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005c3:	8b 00                	mov    (%eax),%eax
  8005c5:	8d 48 01             	lea    0x1(%eax),%ecx
  8005c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005cb:	89 0a                	mov    %ecx,(%edx)
  8005cd:	8b 55 08             	mov    0x8(%ebp),%edx
  8005d0:	88 d1                	mov    %dl,%cl
  8005d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005d5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005dc:	8b 00                	mov    (%eax),%eax
  8005de:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005e3:	75 2c                	jne    800611 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005e5:	a0 0c 30 80 00       	mov    0x80300c,%al
  8005ea:	0f b6 c0             	movzbl %al,%eax
  8005ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005f0:	8b 12                	mov    (%edx),%edx
  8005f2:	89 d1                	mov    %edx,%ecx
  8005f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005f7:	83 c2 08             	add    $0x8,%edx
  8005fa:	83 ec 04             	sub    $0x4,%esp
  8005fd:	50                   	push   %eax
  8005fe:	51                   	push   %ecx
  8005ff:	52                   	push   %edx
  800600:	e8 3e 0e 00 00       	call   801443 <sys_cputs>
  800605:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800608:	8b 45 0c             	mov    0xc(%ebp),%eax
  80060b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800611:	8b 45 0c             	mov    0xc(%ebp),%eax
  800614:	8b 40 04             	mov    0x4(%eax),%eax
  800617:	8d 50 01             	lea    0x1(%eax),%edx
  80061a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800620:	90                   	nop
  800621:	c9                   	leave  
  800622:	c3                   	ret    

00800623 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800623:	55                   	push   %ebp
  800624:	89 e5                	mov    %esp,%ebp
  800626:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80062c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800633:	00 00 00 
	b.cnt = 0;
  800636:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80063d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800640:	ff 75 0c             	pushl  0xc(%ebp)
  800643:	ff 75 08             	pushl  0x8(%ebp)
  800646:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80064c:	50                   	push   %eax
  80064d:	68 ba 05 80 00       	push   $0x8005ba
  800652:	e8 11 02 00 00       	call   800868 <vprintfmt>
  800657:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80065a:	a0 0c 30 80 00       	mov    0x80300c,%al
  80065f:	0f b6 c0             	movzbl %al,%eax
  800662:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800668:	83 ec 04             	sub    $0x4,%esp
  80066b:	50                   	push   %eax
  80066c:	52                   	push   %edx
  80066d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800673:	83 c0 08             	add    $0x8,%eax
  800676:	50                   	push   %eax
  800677:	e8 c7 0d 00 00       	call   801443 <sys_cputs>
  80067c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80067f:	c6 05 0c 30 80 00 00 	movb   $0x0,0x80300c
	return b.cnt;
  800686:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80068c:	c9                   	leave  
  80068d:	c3                   	ret    

0080068e <cprintf>:

int cprintf(const char *fmt, ...) {
  80068e:	55                   	push   %ebp
  80068f:	89 e5                	mov    %esp,%ebp
  800691:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800694:	c6 05 0c 30 80 00 01 	movb   $0x1,0x80300c
	va_start(ap, fmt);
  80069b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80069e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a4:	83 ec 08             	sub    $0x8,%esp
  8006a7:	ff 75 f4             	pushl  -0xc(%ebp)
  8006aa:	50                   	push   %eax
  8006ab:	e8 73 ff ff ff       	call   800623 <vcprintf>
  8006b0:	83 c4 10             	add    $0x10,%esp
  8006b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006b9:	c9                   	leave  
  8006ba:	c3                   	ret    

008006bb <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8006bb:	55                   	push   %ebp
  8006bc:	89 e5                	mov    %esp,%ebp
  8006be:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006c1:	e8 8e 0f 00 00       	call   801654 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006c6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cf:	83 ec 08             	sub    $0x8,%esp
  8006d2:	ff 75 f4             	pushl  -0xc(%ebp)
  8006d5:	50                   	push   %eax
  8006d6:	e8 48 ff ff ff       	call   800623 <vcprintf>
  8006db:	83 c4 10             	add    $0x10,%esp
  8006de:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006e1:	e8 88 0f 00 00       	call   80166e <sys_enable_interrupt>
	return cnt;
  8006e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006e9:	c9                   	leave  
  8006ea:	c3                   	ret    

008006eb <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006eb:	55                   	push   %ebp
  8006ec:	89 e5                	mov    %esp,%ebp
  8006ee:	53                   	push   %ebx
  8006ef:	83 ec 14             	sub    $0x14,%esp
  8006f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8006f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8006fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006fe:	8b 45 18             	mov    0x18(%ebp),%eax
  800701:	ba 00 00 00 00       	mov    $0x0,%edx
  800706:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800709:	77 55                	ja     800760 <printnum+0x75>
  80070b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80070e:	72 05                	jb     800715 <printnum+0x2a>
  800710:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800713:	77 4b                	ja     800760 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800715:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800718:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80071b:	8b 45 18             	mov    0x18(%ebp),%eax
  80071e:	ba 00 00 00 00       	mov    $0x0,%edx
  800723:	52                   	push   %edx
  800724:	50                   	push   %eax
  800725:	ff 75 f4             	pushl  -0xc(%ebp)
  800728:	ff 75 f0             	pushl  -0x10(%ebp)
  80072b:	e8 04 13 00 00       	call   801a34 <__udivdi3>
  800730:	83 c4 10             	add    $0x10,%esp
  800733:	83 ec 04             	sub    $0x4,%esp
  800736:	ff 75 20             	pushl  0x20(%ebp)
  800739:	53                   	push   %ebx
  80073a:	ff 75 18             	pushl  0x18(%ebp)
  80073d:	52                   	push   %edx
  80073e:	50                   	push   %eax
  80073f:	ff 75 0c             	pushl  0xc(%ebp)
  800742:	ff 75 08             	pushl  0x8(%ebp)
  800745:	e8 a1 ff ff ff       	call   8006eb <printnum>
  80074a:	83 c4 20             	add    $0x20,%esp
  80074d:	eb 1a                	jmp    800769 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80074f:	83 ec 08             	sub    $0x8,%esp
  800752:	ff 75 0c             	pushl  0xc(%ebp)
  800755:	ff 75 20             	pushl  0x20(%ebp)
  800758:	8b 45 08             	mov    0x8(%ebp),%eax
  80075b:	ff d0                	call   *%eax
  80075d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800760:	ff 4d 1c             	decl   0x1c(%ebp)
  800763:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800767:	7f e6                	jg     80074f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800769:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80076c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800771:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800774:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800777:	53                   	push   %ebx
  800778:	51                   	push   %ecx
  800779:	52                   	push   %edx
  80077a:	50                   	push   %eax
  80077b:	e8 c4 13 00 00       	call   801b44 <__umoddi3>
  800780:	83 c4 10             	add    $0x10,%esp
  800783:	05 14 23 80 00       	add    $0x802314,%eax
  800788:	8a 00                	mov    (%eax),%al
  80078a:	0f be c0             	movsbl %al,%eax
  80078d:	83 ec 08             	sub    $0x8,%esp
  800790:	ff 75 0c             	pushl  0xc(%ebp)
  800793:	50                   	push   %eax
  800794:	8b 45 08             	mov    0x8(%ebp),%eax
  800797:	ff d0                	call   *%eax
  800799:	83 c4 10             	add    $0x10,%esp
}
  80079c:	90                   	nop
  80079d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007a0:	c9                   	leave  
  8007a1:	c3                   	ret    

008007a2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007a2:	55                   	push   %ebp
  8007a3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007a5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007a9:	7e 1c                	jle    8007c7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ae:	8b 00                	mov    (%eax),%eax
  8007b0:	8d 50 08             	lea    0x8(%eax),%edx
  8007b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b6:	89 10                	mov    %edx,(%eax)
  8007b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bb:	8b 00                	mov    (%eax),%eax
  8007bd:	83 e8 08             	sub    $0x8,%eax
  8007c0:	8b 50 04             	mov    0x4(%eax),%edx
  8007c3:	8b 00                	mov    (%eax),%eax
  8007c5:	eb 40                	jmp    800807 <getuint+0x65>
	else if (lflag)
  8007c7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007cb:	74 1e                	je     8007eb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d0:	8b 00                	mov    (%eax),%eax
  8007d2:	8d 50 04             	lea    0x4(%eax),%edx
  8007d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d8:	89 10                	mov    %edx,(%eax)
  8007da:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dd:	8b 00                	mov    (%eax),%eax
  8007df:	83 e8 04             	sub    $0x4,%eax
  8007e2:	8b 00                	mov    (%eax),%eax
  8007e4:	ba 00 00 00 00       	mov    $0x0,%edx
  8007e9:	eb 1c                	jmp    800807 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ee:	8b 00                	mov    (%eax),%eax
  8007f0:	8d 50 04             	lea    0x4(%eax),%edx
  8007f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f6:	89 10                	mov    %edx,(%eax)
  8007f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fb:	8b 00                	mov    (%eax),%eax
  8007fd:	83 e8 04             	sub    $0x4,%eax
  800800:	8b 00                	mov    (%eax),%eax
  800802:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800807:	5d                   	pop    %ebp
  800808:	c3                   	ret    

00800809 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800809:	55                   	push   %ebp
  80080a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80080c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800810:	7e 1c                	jle    80082e <getint+0x25>
		return va_arg(*ap, long long);
  800812:	8b 45 08             	mov    0x8(%ebp),%eax
  800815:	8b 00                	mov    (%eax),%eax
  800817:	8d 50 08             	lea    0x8(%eax),%edx
  80081a:	8b 45 08             	mov    0x8(%ebp),%eax
  80081d:	89 10                	mov    %edx,(%eax)
  80081f:	8b 45 08             	mov    0x8(%ebp),%eax
  800822:	8b 00                	mov    (%eax),%eax
  800824:	83 e8 08             	sub    $0x8,%eax
  800827:	8b 50 04             	mov    0x4(%eax),%edx
  80082a:	8b 00                	mov    (%eax),%eax
  80082c:	eb 38                	jmp    800866 <getint+0x5d>
	else if (lflag)
  80082e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800832:	74 1a                	je     80084e <getint+0x45>
		return va_arg(*ap, long);
  800834:	8b 45 08             	mov    0x8(%ebp),%eax
  800837:	8b 00                	mov    (%eax),%eax
  800839:	8d 50 04             	lea    0x4(%eax),%edx
  80083c:	8b 45 08             	mov    0x8(%ebp),%eax
  80083f:	89 10                	mov    %edx,(%eax)
  800841:	8b 45 08             	mov    0x8(%ebp),%eax
  800844:	8b 00                	mov    (%eax),%eax
  800846:	83 e8 04             	sub    $0x4,%eax
  800849:	8b 00                	mov    (%eax),%eax
  80084b:	99                   	cltd   
  80084c:	eb 18                	jmp    800866 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80084e:	8b 45 08             	mov    0x8(%ebp),%eax
  800851:	8b 00                	mov    (%eax),%eax
  800853:	8d 50 04             	lea    0x4(%eax),%edx
  800856:	8b 45 08             	mov    0x8(%ebp),%eax
  800859:	89 10                	mov    %edx,(%eax)
  80085b:	8b 45 08             	mov    0x8(%ebp),%eax
  80085e:	8b 00                	mov    (%eax),%eax
  800860:	83 e8 04             	sub    $0x4,%eax
  800863:	8b 00                	mov    (%eax),%eax
  800865:	99                   	cltd   
}
  800866:	5d                   	pop    %ebp
  800867:	c3                   	ret    

00800868 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800868:	55                   	push   %ebp
  800869:	89 e5                	mov    %esp,%ebp
  80086b:	56                   	push   %esi
  80086c:	53                   	push   %ebx
  80086d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800870:	eb 17                	jmp    800889 <vprintfmt+0x21>
			if (ch == '\0')
  800872:	85 db                	test   %ebx,%ebx
  800874:	0f 84 af 03 00 00    	je     800c29 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80087a:	83 ec 08             	sub    $0x8,%esp
  80087d:	ff 75 0c             	pushl  0xc(%ebp)
  800880:	53                   	push   %ebx
  800881:	8b 45 08             	mov    0x8(%ebp),%eax
  800884:	ff d0                	call   *%eax
  800886:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800889:	8b 45 10             	mov    0x10(%ebp),%eax
  80088c:	8d 50 01             	lea    0x1(%eax),%edx
  80088f:	89 55 10             	mov    %edx,0x10(%ebp)
  800892:	8a 00                	mov    (%eax),%al
  800894:	0f b6 d8             	movzbl %al,%ebx
  800897:	83 fb 25             	cmp    $0x25,%ebx
  80089a:	75 d6                	jne    800872 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80089c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008a0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008a7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008ae:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008b5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8008bf:	8d 50 01             	lea    0x1(%eax),%edx
  8008c2:	89 55 10             	mov    %edx,0x10(%ebp)
  8008c5:	8a 00                	mov    (%eax),%al
  8008c7:	0f b6 d8             	movzbl %al,%ebx
  8008ca:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008cd:	83 f8 55             	cmp    $0x55,%eax
  8008d0:	0f 87 2b 03 00 00    	ja     800c01 <vprintfmt+0x399>
  8008d6:	8b 04 85 38 23 80 00 	mov    0x802338(,%eax,4),%eax
  8008dd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008df:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008e3:	eb d7                	jmp    8008bc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008e5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008e9:	eb d1                	jmp    8008bc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008eb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008f2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008f5:	89 d0                	mov    %edx,%eax
  8008f7:	c1 e0 02             	shl    $0x2,%eax
  8008fa:	01 d0                	add    %edx,%eax
  8008fc:	01 c0                	add    %eax,%eax
  8008fe:	01 d8                	add    %ebx,%eax
  800900:	83 e8 30             	sub    $0x30,%eax
  800903:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800906:	8b 45 10             	mov    0x10(%ebp),%eax
  800909:	8a 00                	mov    (%eax),%al
  80090b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80090e:	83 fb 2f             	cmp    $0x2f,%ebx
  800911:	7e 3e                	jle    800951 <vprintfmt+0xe9>
  800913:	83 fb 39             	cmp    $0x39,%ebx
  800916:	7f 39                	jg     800951 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800918:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80091b:	eb d5                	jmp    8008f2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80091d:	8b 45 14             	mov    0x14(%ebp),%eax
  800920:	83 c0 04             	add    $0x4,%eax
  800923:	89 45 14             	mov    %eax,0x14(%ebp)
  800926:	8b 45 14             	mov    0x14(%ebp),%eax
  800929:	83 e8 04             	sub    $0x4,%eax
  80092c:	8b 00                	mov    (%eax),%eax
  80092e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800931:	eb 1f                	jmp    800952 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800933:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800937:	79 83                	jns    8008bc <vprintfmt+0x54>
				width = 0;
  800939:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800940:	e9 77 ff ff ff       	jmp    8008bc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800945:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80094c:	e9 6b ff ff ff       	jmp    8008bc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800951:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800952:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800956:	0f 89 60 ff ff ff    	jns    8008bc <vprintfmt+0x54>
				width = precision, precision = -1;
  80095c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80095f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800962:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800969:	e9 4e ff ff ff       	jmp    8008bc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80096e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800971:	e9 46 ff ff ff       	jmp    8008bc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800976:	8b 45 14             	mov    0x14(%ebp),%eax
  800979:	83 c0 04             	add    $0x4,%eax
  80097c:	89 45 14             	mov    %eax,0x14(%ebp)
  80097f:	8b 45 14             	mov    0x14(%ebp),%eax
  800982:	83 e8 04             	sub    $0x4,%eax
  800985:	8b 00                	mov    (%eax),%eax
  800987:	83 ec 08             	sub    $0x8,%esp
  80098a:	ff 75 0c             	pushl  0xc(%ebp)
  80098d:	50                   	push   %eax
  80098e:	8b 45 08             	mov    0x8(%ebp),%eax
  800991:	ff d0                	call   *%eax
  800993:	83 c4 10             	add    $0x10,%esp
			break;
  800996:	e9 89 02 00 00       	jmp    800c24 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80099b:	8b 45 14             	mov    0x14(%ebp),%eax
  80099e:	83 c0 04             	add    $0x4,%eax
  8009a1:	89 45 14             	mov    %eax,0x14(%ebp)
  8009a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a7:	83 e8 04             	sub    $0x4,%eax
  8009aa:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009ac:	85 db                	test   %ebx,%ebx
  8009ae:	79 02                	jns    8009b2 <vprintfmt+0x14a>
				err = -err;
  8009b0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8009b2:	83 fb 64             	cmp    $0x64,%ebx
  8009b5:	7f 0b                	jg     8009c2 <vprintfmt+0x15a>
  8009b7:	8b 34 9d 80 21 80 00 	mov    0x802180(,%ebx,4),%esi
  8009be:	85 f6                	test   %esi,%esi
  8009c0:	75 19                	jne    8009db <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009c2:	53                   	push   %ebx
  8009c3:	68 25 23 80 00       	push   $0x802325
  8009c8:	ff 75 0c             	pushl  0xc(%ebp)
  8009cb:	ff 75 08             	pushl  0x8(%ebp)
  8009ce:	e8 5e 02 00 00       	call   800c31 <printfmt>
  8009d3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009d6:	e9 49 02 00 00       	jmp    800c24 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009db:	56                   	push   %esi
  8009dc:	68 2e 23 80 00       	push   $0x80232e
  8009e1:	ff 75 0c             	pushl  0xc(%ebp)
  8009e4:	ff 75 08             	pushl  0x8(%ebp)
  8009e7:	e8 45 02 00 00       	call   800c31 <printfmt>
  8009ec:	83 c4 10             	add    $0x10,%esp
			break;
  8009ef:	e9 30 02 00 00       	jmp    800c24 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f7:	83 c0 04             	add    $0x4,%eax
  8009fa:	89 45 14             	mov    %eax,0x14(%ebp)
  8009fd:	8b 45 14             	mov    0x14(%ebp),%eax
  800a00:	83 e8 04             	sub    $0x4,%eax
  800a03:	8b 30                	mov    (%eax),%esi
  800a05:	85 f6                	test   %esi,%esi
  800a07:	75 05                	jne    800a0e <vprintfmt+0x1a6>
				p = "(null)";
  800a09:	be 31 23 80 00       	mov    $0x802331,%esi
			if (width > 0 && padc != '-')
  800a0e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a12:	7e 6d                	jle    800a81 <vprintfmt+0x219>
  800a14:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a18:	74 67                	je     800a81 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a1d:	83 ec 08             	sub    $0x8,%esp
  800a20:	50                   	push   %eax
  800a21:	56                   	push   %esi
  800a22:	e8 0c 03 00 00       	call   800d33 <strnlen>
  800a27:	83 c4 10             	add    $0x10,%esp
  800a2a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a2d:	eb 16                	jmp    800a45 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a2f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a33:	83 ec 08             	sub    $0x8,%esp
  800a36:	ff 75 0c             	pushl  0xc(%ebp)
  800a39:	50                   	push   %eax
  800a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3d:	ff d0                	call   *%eax
  800a3f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a42:	ff 4d e4             	decl   -0x1c(%ebp)
  800a45:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a49:	7f e4                	jg     800a2f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a4b:	eb 34                	jmp    800a81 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a4d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a51:	74 1c                	je     800a6f <vprintfmt+0x207>
  800a53:	83 fb 1f             	cmp    $0x1f,%ebx
  800a56:	7e 05                	jle    800a5d <vprintfmt+0x1f5>
  800a58:	83 fb 7e             	cmp    $0x7e,%ebx
  800a5b:	7e 12                	jle    800a6f <vprintfmt+0x207>
					putch('?', putdat);
  800a5d:	83 ec 08             	sub    $0x8,%esp
  800a60:	ff 75 0c             	pushl  0xc(%ebp)
  800a63:	6a 3f                	push   $0x3f
  800a65:	8b 45 08             	mov    0x8(%ebp),%eax
  800a68:	ff d0                	call   *%eax
  800a6a:	83 c4 10             	add    $0x10,%esp
  800a6d:	eb 0f                	jmp    800a7e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a6f:	83 ec 08             	sub    $0x8,%esp
  800a72:	ff 75 0c             	pushl  0xc(%ebp)
  800a75:	53                   	push   %ebx
  800a76:	8b 45 08             	mov    0x8(%ebp),%eax
  800a79:	ff d0                	call   *%eax
  800a7b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a7e:	ff 4d e4             	decl   -0x1c(%ebp)
  800a81:	89 f0                	mov    %esi,%eax
  800a83:	8d 70 01             	lea    0x1(%eax),%esi
  800a86:	8a 00                	mov    (%eax),%al
  800a88:	0f be d8             	movsbl %al,%ebx
  800a8b:	85 db                	test   %ebx,%ebx
  800a8d:	74 24                	je     800ab3 <vprintfmt+0x24b>
  800a8f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a93:	78 b8                	js     800a4d <vprintfmt+0x1e5>
  800a95:	ff 4d e0             	decl   -0x20(%ebp)
  800a98:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a9c:	79 af                	jns    800a4d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a9e:	eb 13                	jmp    800ab3 <vprintfmt+0x24b>
				putch(' ', putdat);
  800aa0:	83 ec 08             	sub    $0x8,%esp
  800aa3:	ff 75 0c             	pushl  0xc(%ebp)
  800aa6:	6a 20                	push   $0x20
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aab:	ff d0                	call   *%eax
  800aad:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ab0:	ff 4d e4             	decl   -0x1c(%ebp)
  800ab3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ab7:	7f e7                	jg     800aa0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ab9:	e9 66 01 00 00       	jmp    800c24 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800abe:	83 ec 08             	sub    $0x8,%esp
  800ac1:	ff 75 e8             	pushl  -0x18(%ebp)
  800ac4:	8d 45 14             	lea    0x14(%ebp),%eax
  800ac7:	50                   	push   %eax
  800ac8:	e8 3c fd ff ff       	call   800809 <getint>
  800acd:	83 c4 10             	add    $0x10,%esp
  800ad0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ad6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ad9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800adc:	85 d2                	test   %edx,%edx
  800ade:	79 23                	jns    800b03 <vprintfmt+0x29b>
				putch('-', putdat);
  800ae0:	83 ec 08             	sub    $0x8,%esp
  800ae3:	ff 75 0c             	pushl  0xc(%ebp)
  800ae6:	6a 2d                	push   $0x2d
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	ff d0                	call   *%eax
  800aed:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800af0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800af3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800af6:	f7 d8                	neg    %eax
  800af8:	83 d2 00             	adc    $0x0,%edx
  800afb:	f7 da                	neg    %edx
  800afd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b00:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b03:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b0a:	e9 bc 00 00 00       	jmp    800bcb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b0f:	83 ec 08             	sub    $0x8,%esp
  800b12:	ff 75 e8             	pushl  -0x18(%ebp)
  800b15:	8d 45 14             	lea    0x14(%ebp),%eax
  800b18:	50                   	push   %eax
  800b19:	e8 84 fc ff ff       	call   8007a2 <getuint>
  800b1e:	83 c4 10             	add    $0x10,%esp
  800b21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b24:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b27:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b2e:	e9 98 00 00 00       	jmp    800bcb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b33:	83 ec 08             	sub    $0x8,%esp
  800b36:	ff 75 0c             	pushl  0xc(%ebp)
  800b39:	6a 58                	push   $0x58
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	ff d0                	call   *%eax
  800b40:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b43:	83 ec 08             	sub    $0x8,%esp
  800b46:	ff 75 0c             	pushl  0xc(%ebp)
  800b49:	6a 58                	push   $0x58
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	ff d0                	call   *%eax
  800b50:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b53:	83 ec 08             	sub    $0x8,%esp
  800b56:	ff 75 0c             	pushl  0xc(%ebp)
  800b59:	6a 58                	push   $0x58
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	ff d0                	call   *%eax
  800b60:	83 c4 10             	add    $0x10,%esp
			break;
  800b63:	e9 bc 00 00 00       	jmp    800c24 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b68:	83 ec 08             	sub    $0x8,%esp
  800b6b:	ff 75 0c             	pushl  0xc(%ebp)
  800b6e:	6a 30                	push   $0x30
  800b70:	8b 45 08             	mov    0x8(%ebp),%eax
  800b73:	ff d0                	call   *%eax
  800b75:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b78:	83 ec 08             	sub    $0x8,%esp
  800b7b:	ff 75 0c             	pushl  0xc(%ebp)
  800b7e:	6a 78                	push   $0x78
  800b80:	8b 45 08             	mov    0x8(%ebp),%eax
  800b83:	ff d0                	call   *%eax
  800b85:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b88:	8b 45 14             	mov    0x14(%ebp),%eax
  800b8b:	83 c0 04             	add    $0x4,%eax
  800b8e:	89 45 14             	mov    %eax,0x14(%ebp)
  800b91:	8b 45 14             	mov    0x14(%ebp),%eax
  800b94:	83 e8 04             	sub    $0x4,%eax
  800b97:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b99:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b9c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ba3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800baa:	eb 1f                	jmp    800bcb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800bac:	83 ec 08             	sub    $0x8,%esp
  800baf:	ff 75 e8             	pushl  -0x18(%ebp)
  800bb2:	8d 45 14             	lea    0x14(%ebp),%eax
  800bb5:	50                   	push   %eax
  800bb6:	e8 e7 fb ff ff       	call   8007a2 <getuint>
  800bbb:	83 c4 10             	add    $0x10,%esp
  800bbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bc1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800bc4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bcb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800bcf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bd2:	83 ec 04             	sub    $0x4,%esp
  800bd5:	52                   	push   %edx
  800bd6:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bd9:	50                   	push   %eax
  800bda:	ff 75 f4             	pushl  -0xc(%ebp)
  800bdd:	ff 75 f0             	pushl  -0x10(%ebp)
  800be0:	ff 75 0c             	pushl  0xc(%ebp)
  800be3:	ff 75 08             	pushl  0x8(%ebp)
  800be6:	e8 00 fb ff ff       	call   8006eb <printnum>
  800beb:	83 c4 20             	add    $0x20,%esp
			break;
  800bee:	eb 34                	jmp    800c24 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bf0:	83 ec 08             	sub    $0x8,%esp
  800bf3:	ff 75 0c             	pushl  0xc(%ebp)
  800bf6:	53                   	push   %ebx
  800bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfa:	ff d0                	call   *%eax
  800bfc:	83 c4 10             	add    $0x10,%esp
			break;
  800bff:	eb 23                	jmp    800c24 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c01:	83 ec 08             	sub    $0x8,%esp
  800c04:	ff 75 0c             	pushl  0xc(%ebp)
  800c07:	6a 25                	push   $0x25
  800c09:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0c:	ff d0                	call   *%eax
  800c0e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c11:	ff 4d 10             	decl   0x10(%ebp)
  800c14:	eb 03                	jmp    800c19 <vprintfmt+0x3b1>
  800c16:	ff 4d 10             	decl   0x10(%ebp)
  800c19:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1c:	48                   	dec    %eax
  800c1d:	8a 00                	mov    (%eax),%al
  800c1f:	3c 25                	cmp    $0x25,%al
  800c21:	75 f3                	jne    800c16 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c23:	90                   	nop
		}
	}
  800c24:	e9 47 fc ff ff       	jmp    800870 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c29:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c2a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c2d:	5b                   	pop    %ebx
  800c2e:	5e                   	pop    %esi
  800c2f:	5d                   	pop    %ebp
  800c30:	c3                   	ret    

00800c31 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c31:	55                   	push   %ebp
  800c32:	89 e5                	mov    %esp,%ebp
  800c34:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c37:	8d 45 10             	lea    0x10(%ebp),%eax
  800c3a:	83 c0 04             	add    $0x4,%eax
  800c3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c40:	8b 45 10             	mov    0x10(%ebp),%eax
  800c43:	ff 75 f4             	pushl  -0xc(%ebp)
  800c46:	50                   	push   %eax
  800c47:	ff 75 0c             	pushl  0xc(%ebp)
  800c4a:	ff 75 08             	pushl  0x8(%ebp)
  800c4d:	e8 16 fc ff ff       	call   800868 <vprintfmt>
  800c52:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c55:	90                   	nop
  800c56:	c9                   	leave  
  800c57:	c3                   	ret    

00800c58 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c58:	55                   	push   %ebp
  800c59:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5e:	8b 40 08             	mov    0x8(%eax),%eax
  800c61:	8d 50 01             	lea    0x1(%eax),%edx
  800c64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c67:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6d:	8b 10                	mov    (%eax),%edx
  800c6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c72:	8b 40 04             	mov    0x4(%eax),%eax
  800c75:	39 c2                	cmp    %eax,%edx
  800c77:	73 12                	jae    800c8b <sprintputch+0x33>
		*b->buf++ = ch;
  800c79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7c:	8b 00                	mov    (%eax),%eax
  800c7e:	8d 48 01             	lea    0x1(%eax),%ecx
  800c81:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c84:	89 0a                	mov    %ecx,(%edx)
  800c86:	8b 55 08             	mov    0x8(%ebp),%edx
  800c89:	88 10                	mov    %dl,(%eax)
}
  800c8b:	90                   	nop
  800c8c:	5d                   	pop    %ebp
  800c8d:	c3                   	ret    

00800c8e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c8e:	55                   	push   %ebp
  800c8f:	89 e5                	mov    %esp,%ebp
  800c91:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c94:	8b 45 08             	mov    0x8(%ebp),%eax
  800c97:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca3:	01 d0                	add    %edx,%eax
  800ca5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ca8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800caf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800cb3:	74 06                	je     800cbb <vsnprintf+0x2d>
  800cb5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cb9:	7f 07                	jg     800cc2 <vsnprintf+0x34>
		return -E_INVAL;
  800cbb:	b8 03 00 00 00       	mov    $0x3,%eax
  800cc0:	eb 20                	jmp    800ce2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800cc2:	ff 75 14             	pushl  0x14(%ebp)
  800cc5:	ff 75 10             	pushl  0x10(%ebp)
  800cc8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ccb:	50                   	push   %eax
  800ccc:	68 58 0c 80 00       	push   $0x800c58
  800cd1:	e8 92 fb ff ff       	call   800868 <vprintfmt>
  800cd6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cd9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cdc:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800cdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ce2:	c9                   	leave  
  800ce3:	c3                   	ret    

00800ce4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ce4:	55                   	push   %ebp
  800ce5:	89 e5                	mov    %esp,%ebp
  800ce7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800cea:	8d 45 10             	lea    0x10(%ebp),%eax
  800ced:	83 c0 04             	add    $0x4,%eax
  800cf0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800cf3:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf6:	ff 75 f4             	pushl  -0xc(%ebp)
  800cf9:	50                   	push   %eax
  800cfa:	ff 75 0c             	pushl  0xc(%ebp)
  800cfd:	ff 75 08             	pushl  0x8(%ebp)
  800d00:	e8 89 ff ff ff       	call   800c8e <vsnprintf>
  800d05:	83 c4 10             	add    $0x10,%esp
  800d08:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d0e:	c9                   	leave  
  800d0f:	c3                   	ret    

00800d10 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d10:	55                   	push   %ebp
  800d11:	89 e5                	mov    %esp,%ebp
  800d13:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d16:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d1d:	eb 06                	jmp    800d25 <strlen+0x15>
		n++;
  800d1f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d22:	ff 45 08             	incl   0x8(%ebp)
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	8a 00                	mov    (%eax),%al
  800d2a:	84 c0                	test   %al,%al
  800d2c:	75 f1                	jne    800d1f <strlen+0xf>
		n++;
	return n;
  800d2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d31:	c9                   	leave  
  800d32:	c3                   	ret    

00800d33 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d33:	55                   	push   %ebp
  800d34:	89 e5                	mov    %esp,%ebp
  800d36:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d39:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d40:	eb 09                	jmp    800d4b <strnlen+0x18>
		n++;
  800d42:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d45:	ff 45 08             	incl   0x8(%ebp)
  800d48:	ff 4d 0c             	decl   0xc(%ebp)
  800d4b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d4f:	74 09                	je     800d5a <strnlen+0x27>
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	8a 00                	mov    (%eax),%al
  800d56:	84 c0                	test   %al,%al
  800d58:	75 e8                	jne    800d42 <strnlen+0xf>
		n++;
	return n;
  800d5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d5d:	c9                   	leave  
  800d5e:	c3                   	ret    

00800d5f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d5f:	55                   	push   %ebp
  800d60:	89 e5                	mov    %esp,%ebp
  800d62:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d6b:	90                   	nop
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6f:	8d 50 01             	lea    0x1(%eax),%edx
  800d72:	89 55 08             	mov    %edx,0x8(%ebp)
  800d75:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d78:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d7b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d7e:	8a 12                	mov    (%edx),%dl
  800d80:	88 10                	mov    %dl,(%eax)
  800d82:	8a 00                	mov    (%eax),%al
  800d84:	84 c0                	test   %al,%al
  800d86:	75 e4                	jne    800d6c <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d88:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d8b:	c9                   	leave  
  800d8c:	c3                   	ret    

00800d8d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d8d:	55                   	push   %ebp
  800d8e:	89 e5                	mov    %esp,%ebp
  800d90:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d93:	8b 45 08             	mov    0x8(%ebp),%eax
  800d96:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d99:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800da0:	eb 1f                	jmp    800dc1 <strncpy+0x34>
		*dst++ = *src;
  800da2:	8b 45 08             	mov    0x8(%ebp),%eax
  800da5:	8d 50 01             	lea    0x1(%eax),%edx
  800da8:	89 55 08             	mov    %edx,0x8(%ebp)
  800dab:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dae:	8a 12                	mov    (%edx),%dl
  800db0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800db2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	84 c0                	test   %al,%al
  800db9:	74 03                	je     800dbe <strncpy+0x31>
			src++;
  800dbb:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800dbe:	ff 45 fc             	incl   -0x4(%ebp)
  800dc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc4:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dc7:	72 d9                	jb     800da2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800dc9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dcc:	c9                   	leave  
  800dcd:	c3                   	ret    

00800dce <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800dce:	55                   	push   %ebp
  800dcf:	89 e5                	mov    %esp,%ebp
  800dd1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dda:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dde:	74 30                	je     800e10 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800de0:	eb 16                	jmp    800df8 <strlcpy+0x2a>
			*dst++ = *src++;
  800de2:	8b 45 08             	mov    0x8(%ebp),%eax
  800de5:	8d 50 01             	lea    0x1(%eax),%edx
  800de8:	89 55 08             	mov    %edx,0x8(%ebp)
  800deb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dee:	8d 4a 01             	lea    0x1(%edx),%ecx
  800df1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800df4:	8a 12                	mov    (%edx),%dl
  800df6:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800df8:	ff 4d 10             	decl   0x10(%ebp)
  800dfb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dff:	74 09                	je     800e0a <strlcpy+0x3c>
  800e01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e04:	8a 00                	mov    (%eax),%al
  800e06:	84 c0                	test   %al,%al
  800e08:	75 d8                	jne    800de2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e10:	8b 55 08             	mov    0x8(%ebp),%edx
  800e13:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e16:	29 c2                	sub    %eax,%edx
  800e18:	89 d0                	mov    %edx,%eax
}
  800e1a:	c9                   	leave  
  800e1b:	c3                   	ret    

00800e1c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e1c:	55                   	push   %ebp
  800e1d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e1f:	eb 06                	jmp    800e27 <strcmp+0xb>
		p++, q++;
  800e21:	ff 45 08             	incl   0x8(%ebp)
  800e24:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e27:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2a:	8a 00                	mov    (%eax),%al
  800e2c:	84 c0                	test   %al,%al
  800e2e:	74 0e                	je     800e3e <strcmp+0x22>
  800e30:	8b 45 08             	mov    0x8(%ebp),%eax
  800e33:	8a 10                	mov    (%eax),%dl
  800e35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e38:	8a 00                	mov    (%eax),%al
  800e3a:	38 c2                	cmp    %al,%dl
  800e3c:	74 e3                	je     800e21 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	0f b6 d0             	movzbl %al,%edx
  800e46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e49:	8a 00                	mov    (%eax),%al
  800e4b:	0f b6 c0             	movzbl %al,%eax
  800e4e:	29 c2                	sub    %eax,%edx
  800e50:	89 d0                	mov    %edx,%eax
}
  800e52:	5d                   	pop    %ebp
  800e53:	c3                   	ret    

00800e54 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e54:	55                   	push   %ebp
  800e55:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e57:	eb 09                	jmp    800e62 <strncmp+0xe>
		n--, p++, q++;
  800e59:	ff 4d 10             	decl   0x10(%ebp)
  800e5c:	ff 45 08             	incl   0x8(%ebp)
  800e5f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e62:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e66:	74 17                	je     800e7f <strncmp+0x2b>
  800e68:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6b:	8a 00                	mov    (%eax),%al
  800e6d:	84 c0                	test   %al,%al
  800e6f:	74 0e                	je     800e7f <strncmp+0x2b>
  800e71:	8b 45 08             	mov    0x8(%ebp),%eax
  800e74:	8a 10                	mov    (%eax),%dl
  800e76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e79:	8a 00                	mov    (%eax),%al
  800e7b:	38 c2                	cmp    %al,%dl
  800e7d:	74 da                	je     800e59 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e7f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e83:	75 07                	jne    800e8c <strncmp+0x38>
		return 0;
  800e85:	b8 00 00 00 00       	mov    $0x0,%eax
  800e8a:	eb 14                	jmp    800ea0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8f:	8a 00                	mov    (%eax),%al
  800e91:	0f b6 d0             	movzbl %al,%edx
  800e94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e97:	8a 00                	mov    (%eax),%al
  800e99:	0f b6 c0             	movzbl %al,%eax
  800e9c:	29 c2                	sub    %eax,%edx
  800e9e:	89 d0                	mov    %edx,%eax
}
  800ea0:	5d                   	pop    %ebp
  800ea1:	c3                   	ret    

00800ea2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ea2:	55                   	push   %ebp
  800ea3:	89 e5                	mov    %esp,%ebp
  800ea5:	83 ec 04             	sub    $0x4,%esp
  800ea8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eab:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800eae:	eb 12                	jmp    800ec2 <strchr+0x20>
		if (*s == c)
  800eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb3:	8a 00                	mov    (%eax),%al
  800eb5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eb8:	75 05                	jne    800ebf <strchr+0x1d>
			return (char *) s;
  800eba:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebd:	eb 11                	jmp    800ed0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ebf:	ff 45 08             	incl   0x8(%ebp)
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	8a 00                	mov    (%eax),%al
  800ec7:	84 c0                	test   %al,%al
  800ec9:	75 e5                	jne    800eb0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ecb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ed0:	c9                   	leave  
  800ed1:	c3                   	ret    

00800ed2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ed2:	55                   	push   %ebp
  800ed3:	89 e5                	mov    %esp,%ebp
  800ed5:	83 ec 04             	sub    $0x4,%esp
  800ed8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800edb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ede:	eb 0d                	jmp    800eed <strfind+0x1b>
		if (*s == c)
  800ee0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee3:	8a 00                	mov    (%eax),%al
  800ee5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ee8:	74 0e                	je     800ef8 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800eea:	ff 45 08             	incl   0x8(%ebp)
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef0:	8a 00                	mov    (%eax),%al
  800ef2:	84 c0                	test   %al,%al
  800ef4:	75 ea                	jne    800ee0 <strfind+0xe>
  800ef6:	eb 01                	jmp    800ef9 <strfind+0x27>
		if (*s == c)
			break;
  800ef8:	90                   	nop
	return (char *) s;
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800efc:	c9                   	leave  
  800efd:	c3                   	ret    

00800efe <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800efe:	55                   	push   %ebp
  800eff:	89 e5                	mov    %esp,%ebp
  800f01:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f04:	8b 45 08             	mov    0x8(%ebp),%eax
  800f07:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f0a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f10:	eb 0e                	jmp    800f20 <memset+0x22>
		*p++ = c;
  800f12:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f15:	8d 50 01             	lea    0x1(%eax),%edx
  800f18:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f1e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f20:	ff 4d f8             	decl   -0x8(%ebp)
  800f23:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f27:	79 e9                	jns    800f12 <memset+0x14>
		*p++ = c;

	return v;
  800f29:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f2c:	c9                   	leave  
  800f2d:	c3                   	ret    

00800f2e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f2e:	55                   	push   %ebp
  800f2f:	89 e5                	mov    %esp,%ebp
  800f31:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f37:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f40:	eb 16                	jmp    800f58 <memcpy+0x2a>
		*d++ = *s++;
  800f42:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f45:	8d 50 01             	lea    0x1(%eax),%edx
  800f48:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f4b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f4e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f51:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f54:	8a 12                	mov    (%edx),%dl
  800f56:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f58:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f5e:	89 55 10             	mov    %edx,0x10(%ebp)
  800f61:	85 c0                	test   %eax,%eax
  800f63:	75 dd                	jne    800f42 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f68:	c9                   	leave  
  800f69:	c3                   	ret    

00800f6a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f6a:	55                   	push   %ebp
  800f6b:	89 e5                	mov    %esp,%ebp
  800f6d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800f70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f73:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f7f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f82:	73 50                	jae    800fd4 <memmove+0x6a>
  800f84:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f87:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8a:	01 d0                	add    %edx,%eax
  800f8c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f8f:	76 43                	jbe    800fd4 <memmove+0x6a>
		s += n;
  800f91:	8b 45 10             	mov    0x10(%ebp),%eax
  800f94:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f97:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f9d:	eb 10                	jmp    800faf <memmove+0x45>
			*--d = *--s;
  800f9f:	ff 4d f8             	decl   -0x8(%ebp)
  800fa2:	ff 4d fc             	decl   -0x4(%ebp)
  800fa5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa8:	8a 10                	mov    (%eax),%dl
  800faa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fad:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800faf:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fb5:	89 55 10             	mov    %edx,0x10(%ebp)
  800fb8:	85 c0                	test   %eax,%eax
  800fba:	75 e3                	jne    800f9f <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fbc:	eb 23                	jmp    800fe1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fbe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc1:	8d 50 01             	lea    0x1(%eax),%edx
  800fc4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fc7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fca:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fcd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fd0:	8a 12                	mov    (%edx),%dl
  800fd2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fd4:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fda:	89 55 10             	mov    %edx,0x10(%ebp)
  800fdd:	85 c0                	test   %eax,%eax
  800fdf:	75 dd                	jne    800fbe <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fe1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fe4:	c9                   	leave  
  800fe5:	c3                   	ret    

00800fe6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fe6:	55                   	push   %ebp
  800fe7:	89 e5                	mov    %esp,%ebp
  800fe9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ff2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ff8:	eb 2a                	jmp    801024 <memcmp+0x3e>
		if (*s1 != *s2)
  800ffa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ffd:	8a 10                	mov    (%eax),%dl
  800fff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801002:	8a 00                	mov    (%eax),%al
  801004:	38 c2                	cmp    %al,%dl
  801006:	74 16                	je     80101e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801008:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80100b:	8a 00                	mov    (%eax),%al
  80100d:	0f b6 d0             	movzbl %al,%edx
  801010:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801013:	8a 00                	mov    (%eax),%al
  801015:	0f b6 c0             	movzbl %al,%eax
  801018:	29 c2                	sub    %eax,%edx
  80101a:	89 d0                	mov    %edx,%eax
  80101c:	eb 18                	jmp    801036 <memcmp+0x50>
		s1++, s2++;
  80101e:	ff 45 fc             	incl   -0x4(%ebp)
  801021:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801024:	8b 45 10             	mov    0x10(%ebp),%eax
  801027:	8d 50 ff             	lea    -0x1(%eax),%edx
  80102a:	89 55 10             	mov    %edx,0x10(%ebp)
  80102d:	85 c0                	test   %eax,%eax
  80102f:	75 c9                	jne    800ffa <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801031:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801036:	c9                   	leave  
  801037:	c3                   	ret    

00801038 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801038:	55                   	push   %ebp
  801039:	89 e5                	mov    %esp,%ebp
  80103b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80103e:	8b 55 08             	mov    0x8(%ebp),%edx
  801041:	8b 45 10             	mov    0x10(%ebp),%eax
  801044:	01 d0                	add    %edx,%eax
  801046:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801049:	eb 15                	jmp    801060 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
  80104e:	8a 00                	mov    (%eax),%al
  801050:	0f b6 d0             	movzbl %al,%edx
  801053:	8b 45 0c             	mov    0xc(%ebp),%eax
  801056:	0f b6 c0             	movzbl %al,%eax
  801059:	39 c2                	cmp    %eax,%edx
  80105b:	74 0d                	je     80106a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80105d:	ff 45 08             	incl   0x8(%ebp)
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801066:	72 e3                	jb     80104b <memfind+0x13>
  801068:	eb 01                	jmp    80106b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80106a:	90                   	nop
	return (void *) s;
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80106e:	c9                   	leave  
  80106f:	c3                   	ret    

00801070 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801070:	55                   	push   %ebp
  801071:	89 e5                	mov    %esp,%ebp
  801073:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801076:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80107d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801084:	eb 03                	jmp    801089 <strtol+0x19>
		s++;
  801086:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801089:	8b 45 08             	mov    0x8(%ebp),%eax
  80108c:	8a 00                	mov    (%eax),%al
  80108e:	3c 20                	cmp    $0x20,%al
  801090:	74 f4                	je     801086 <strtol+0x16>
  801092:	8b 45 08             	mov    0x8(%ebp),%eax
  801095:	8a 00                	mov    (%eax),%al
  801097:	3c 09                	cmp    $0x9,%al
  801099:	74 eb                	je     801086 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80109b:	8b 45 08             	mov    0x8(%ebp),%eax
  80109e:	8a 00                	mov    (%eax),%al
  8010a0:	3c 2b                	cmp    $0x2b,%al
  8010a2:	75 05                	jne    8010a9 <strtol+0x39>
		s++;
  8010a4:	ff 45 08             	incl   0x8(%ebp)
  8010a7:	eb 13                	jmp    8010bc <strtol+0x4c>
	else if (*s == '-')
  8010a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ac:	8a 00                	mov    (%eax),%al
  8010ae:	3c 2d                	cmp    $0x2d,%al
  8010b0:	75 0a                	jne    8010bc <strtol+0x4c>
		s++, neg = 1;
  8010b2:	ff 45 08             	incl   0x8(%ebp)
  8010b5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010bc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010c0:	74 06                	je     8010c8 <strtol+0x58>
  8010c2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010c6:	75 20                	jne    8010e8 <strtol+0x78>
  8010c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cb:	8a 00                	mov    (%eax),%al
  8010cd:	3c 30                	cmp    $0x30,%al
  8010cf:	75 17                	jne    8010e8 <strtol+0x78>
  8010d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d4:	40                   	inc    %eax
  8010d5:	8a 00                	mov    (%eax),%al
  8010d7:	3c 78                	cmp    $0x78,%al
  8010d9:	75 0d                	jne    8010e8 <strtol+0x78>
		s += 2, base = 16;
  8010db:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010df:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010e6:	eb 28                	jmp    801110 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010e8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ec:	75 15                	jne    801103 <strtol+0x93>
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f1:	8a 00                	mov    (%eax),%al
  8010f3:	3c 30                	cmp    $0x30,%al
  8010f5:	75 0c                	jne    801103 <strtol+0x93>
		s++, base = 8;
  8010f7:	ff 45 08             	incl   0x8(%ebp)
  8010fa:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801101:	eb 0d                	jmp    801110 <strtol+0xa0>
	else if (base == 0)
  801103:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801107:	75 07                	jne    801110 <strtol+0xa0>
		base = 10;
  801109:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801110:	8b 45 08             	mov    0x8(%ebp),%eax
  801113:	8a 00                	mov    (%eax),%al
  801115:	3c 2f                	cmp    $0x2f,%al
  801117:	7e 19                	jle    801132 <strtol+0xc2>
  801119:	8b 45 08             	mov    0x8(%ebp),%eax
  80111c:	8a 00                	mov    (%eax),%al
  80111e:	3c 39                	cmp    $0x39,%al
  801120:	7f 10                	jg     801132 <strtol+0xc2>
			dig = *s - '0';
  801122:	8b 45 08             	mov    0x8(%ebp),%eax
  801125:	8a 00                	mov    (%eax),%al
  801127:	0f be c0             	movsbl %al,%eax
  80112a:	83 e8 30             	sub    $0x30,%eax
  80112d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801130:	eb 42                	jmp    801174 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	8a 00                	mov    (%eax),%al
  801137:	3c 60                	cmp    $0x60,%al
  801139:	7e 19                	jle    801154 <strtol+0xe4>
  80113b:	8b 45 08             	mov    0x8(%ebp),%eax
  80113e:	8a 00                	mov    (%eax),%al
  801140:	3c 7a                	cmp    $0x7a,%al
  801142:	7f 10                	jg     801154 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	8a 00                	mov    (%eax),%al
  801149:	0f be c0             	movsbl %al,%eax
  80114c:	83 e8 57             	sub    $0x57,%eax
  80114f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801152:	eb 20                	jmp    801174 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801154:	8b 45 08             	mov    0x8(%ebp),%eax
  801157:	8a 00                	mov    (%eax),%al
  801159:	3c 40                	cmp    $0x40,%al
  80115b:	7e 39                	jle    801196 <strtol+0x126>
  80115d:	8b 45 08             	mov    0x8(%ebp),%eax
  801160:	8a 00                	mov    (%eax),%al
  801162:	3c 5a                	cmp    $0x5a,%al
  801164:	7f 30                	jg     801196 <strtol+0x126>
			dig = *s - 'A' + 10;
  801166:	8b 45 08             	mov    0x8(%ebp),%eax
  801169:	8a 00                	mov    (%eax),%al
  80116b:	0f be c0             	movsbl %al,%eax
  80116e:	83 e8 37             	sub    $0x37,%eax
  801171:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801174:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801177:	3b 45 10             	cmp    0x10(%ebp),%eax
  80117a:	7d 19                	jge    801195 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80117c:	ff 45 08             	incl   0x8(%ebp)
  80117f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801182:	0f af 45 10          	imul   0x10(%ebp),%eax
  801186:	89 c2                	mov    %eax,%edx
  801188:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80118b:	01 d0                	add    %edx,%eax
  80118d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801190:	e9 7b ff ff ff       	jmp    801110 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801195:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801196:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80119a:	74 08                	je     8011a4 <strtol+0x134>
		*endptr = (char *) s;
  80119c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119f:	8b 55 08             	mov    0x8(%ebp),%edx
  8011a2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011a4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011a8:	74 07                	je     8011b1 <strtol+0x141>
  8011aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ad:	f7 d8                	neg    %eax
  8011af:	eb 03                	jmp    8011b4 <strtol+0x144>
  8011b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011b4:	c9                   	leave  
  8011b5:	c3                   	ret    

008011b6 <ltostr>:

void
ltostr(long value, char *str)
{
  8011b6:	55                   	push   %ebp
  8011b7:	89 e5                	mov    %esp,%ebp
  8011b9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011c3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011ca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011ce:	79 13                	jns    8011e3 <ltostr+0x2d>
	{
		neg = 1;
  8011d0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011da:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011dd:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011e0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011eb:	99                   	cltd   
  8011ec:	f7 f9                	idiv   %ecx
  8011ee:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f4:	8d 50 01             	lea    0x1(%eax),%edx
  8011f7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011fa:	89 c2                	mov    %eax,%edx
  8011fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ff:	01 d0                	add    %edx,%eax
  801201:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801204:	83 c2 30             	add    $0x30,%edx
  801207:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801209:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80120c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801211:	f7 e9                	imul   %ecx
  801213:	c1 fa 02             	sar    $0x2,%edx
  801216:	89 c8                	mov    %ecx,%eax
  801218:	c1 f8 1f             	sar    $0x1f,%eax
  80121b:	29 c2                	sub    %eax,%edx
  80121d:	89 d0                	mov    %edx,%eax
  80121f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801222:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801225:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80122a:	f7 e9                	imul   %ecx
  80122c:	c1 fa 02             	sar    $0x2,%edx
  80122f:	89 c8                	mov    %ecx,%eax
  801231:	c1 f8 1f             	sar    $0x1f,%eax
  801234:	29 c2                	sub    %eax,%edx
  801236:	89 d0                	mov    %edx,%eax
  801238:	c1 e0 02             	shl    $0x2,%eax
  80123b:	01 d0                	add    %edx,%eax
  80123d:	01 c0                	add    %eax,%eax
  80123f:	29 c1                	sub    %eax,%ecx
  801241:	89 ca                	mov    %ecx,%edx
  801243:	85 d2                	test   %edx,%edx
  801245:	75 9c                	jne    8011e3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801247:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80124e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801251:	48                   	dec    %eax
  801252:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801255:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801259:	74 3d                	je     801298 <ltostr+0xe2>
		start = 1 ;
  80125b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801262:	eb 34                	jmp    801298 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801264:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801267:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126a:	01 d0                	add    %edx,%eax
  80126c:	8a 00                	mov    (%eax),%al
  80126e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801271:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801274:	8b 45 0c             	mov    0xc(%ebp),%eax
  801277:	01 c2                	add    %eax,%edx
  801279:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80127c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127f:	01 c8                	add    %ecx,%eax
  801281:	8a 00                	mov    (%eax),%al
  801283:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801285:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801288:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128b:	01 c2                	add    %eax,%edx
  80128d:	8a 45 eb             	mov    -0x15(%ebp),%al
  801290:	88 02                	mov    %al,(%edx)
		start++ ;
  801292:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801295:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801298:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80129b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80129e:	7c c4                	jl     801264 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012a0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a6:	01 d0                	add    %edx,%eax
  8012a8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012ab:	90                   	nop
  8012ac:	c9                   	leave  
  8012ad:	c3                   	ret    

008012ae <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012ae:	55                   	push   %ebp
  8012af:	89 e5                	mov    %esp,%ebp
  8012b1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012b4:	ff 75 08             	pushl  0x8(%ebp)
  8012b7:	e8 54 fa ff ff       	call   800d10 <strlen>
  8012bc:	83 c4 04             	add    $0x4,%esp
  8012bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012c2:	ff 75 0c             	pushl  0xc(%ebp)
  8012c5:	e8 46 fa ff ff       	call   800d10 <strlen>
  8012ca:	83 c4 04             	add    $0x4,%esp
  8012cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012de:	eb 17                	jmp    8012f7 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e6:	01 c2                	add    %eax,%edx
  8012e8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ee:	01 c8                	add    %ecx,%eax
  8012f0:	8a 00                	mov    (%eax),%al
  8012f2:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012f4:	ff 45 fc             	incl   -0x4(%ebp)
  8012f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012fa:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012fd:	7c e1                	jl     8012e0 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012ff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801306:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80130d:	eb 1f                	jmp    80132e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80130f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801312:	8d 50 01             	lea    0x1(%eax),%edx
  801315:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801318:	89 c2                	mov    %eax,%edx
  80131a:	8b 45 10             	mov    0x10(%ebp),%eax
  80131d:	01 c2                	add    %eax,%edx
  80131f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801322:	8b 45 0c             	mov    0xc(%ebp),%eax
  801325:	01 c8                	add    %ecx,%eax
  801327:	8a 00                	mov    (%eax),%al
  801329:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80132b:	ff 45 f8             	incl   -0x8(%ebp)
  80132e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801331:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801334:	7c d9                	jl     80130f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801336:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801339:	8b 45 10             	mov    0x10(%ebp),%eax
  80133c:	01 d0                	add    %edx,%eax
  80133e:	c6 00 00             	movb   $0x0,(%eax)
}
  801341:	90                   	nop
  801342:	c9                   	leave  
  801343:	c3                   	ret    

00801344 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801344:	55                   	push   %ebp
  801345:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801347:	8b 45 14             	mov    0x14(%ebp),%eax
  80134a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801350:	8b 45 14             	mov    0x14(%ebp),%eax
  801353:	8b 00                	mov    (%eax),%eax
  801355:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80135c:	8b 45 10             	mov    0x10(%ebp),%eax
  80135f:	01 d0                	add    %edx,%eax
  801361:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801367:	eb 0c                	jmp    801375 <strsplit+0x31>
			*string++ = 0;
  801369:	8b 45 08             	mov    0x8(%ebp),%eax
  80136c:	8d 50 01             	lea    0x1(%eax),%edx
  80136f:	89 55 08             	mov    %edx,0x8(%ebp)
  801372:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801375:	8b 45 08             	mov    0x8(%ebp),%eax
  801378:	8a 00                	mov    (%eax),%al
  80137a:	84 c0                	test   %al,%al
  80137c:	74 18                	je     801396 <strsplit+0x52>
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	8a 00                	mov    (%eax),%al
  801383:	0f be c0             	movsbl %al,%eax
  801386:	50                   	push   %eax
  801387:	ff 75 0c             	pushl  0xc(%ebp)
  80138a:	e8 13 fb ff ff       	call   800ea2 <strchr>
  80138f:	83 c4 08             	add    $0x8,%esp
  801392:	85 c0                	test   %eax,%eax
  801394:	75 d3                	jne    801369 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
  801399:	8a 00                	mov    (%eax),%al
  80139b:	84 c0                	test   %al,%al
  80139d:	74 5a                	je     8013f9 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80139f:	8b 45 14             	mov    0x14(%ebp),%eax
  8013a2:	8b 00                	mov    (%eax),%eax
  8013a4:	83 f8 0f             	cmp    $0xf,%eax
  8013a7:	75 07                	jne    8013b0 <strsplit+0x6c>
		{
			return 0;
  8013a9:	b8 00 00 00 00       	mov    $0x0,%eax
  8013ae:	eb 66                	jmp    801416 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8013b3:	8b 00                	mov    (%eax),%eax
  8013b5:	8d 48 01             	lea    0x1(%eax),%ecx
  8013b8:	8b 55 14             	mov    0x14(%ebp),%edx
  8013bb:	89 0a                	mov    %ecx,(%edx)
  8013bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c7:	01 c2                	add    %eax,%edx
  8013c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cc:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013ce:	eb 03                	jmp    8013d3 <strsplit+0x8f>
			string++;
  8013d0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d6:	8a 00                	mov    (%eax),%al
  8013d8:	84 c0                	test   %al,%al
  8013da:	74 8b                	je     801367 <strsplit+0x23>
  8013dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013df:	8a 00                	mov    (%eax),%al
  8013e1:	0f be c0             	movsbl %al,%eax
  8013e4:	50                   	push   %eax
  8013e5:	ff 75 0c             	pushl  0xc(%ebp)
  8013e8:	e8 b5 fa ff ff       	call   800ea2 <strchr>
  8013ed:	83 c4 08             	add    $0x8,%esp
  8013f0:	85 c0                	test   %eax,%eax
  8013f2:	74 dc                	je     8013d0 <strsplit+0x8c>
			string++;
	}
  8013f4:	e9 6e ff ff ff       	jmp    801367 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013f9:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013fa:	8b 45 14             	mov    0x14(%ebp),%eax
  8013fd:	8b 00                	mov    (%eax),%eax
  8013ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801406:	8b 45 10             	mov    0x10(%ebp),%eax
  801409:	01 d0                	add    %edx,%eax
  80140b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801411:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801416:	c9                   	leave  
  801417:	c3                   	ret    

00801418 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
  80141b:	57                   	push   %edi
  80141c:	56                   	push   %esi
  80141d:	53                   	push   %ebx
  80141e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	8b 55 0c             	mov    0xc(%ebp),%edx
  801427:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80142a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80142d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801430:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801433:	cd 30                	int    $0x30
  801435:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801438:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80143b:	83 c4 10             	add    $0x10,%esp
  80143e:	5b                   	pop    %ebx
  80143f:	5e                   	pop    %esi
  801440:	5f                   	pop    %edi
  801441:	5d                   	pop    %ebp
  801442:	c3                   	ret    

00801443 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801443:	55                   	push   %ebp
  801444:	89 e5                	mov    %esp,%ebp
  801446:	83 ec 04             	sub    $0x4,%esp
  801449:	8b 45 10             	mov    0x10(%ebp),%eax
  80144c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80144f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801453:	8b 45 08             	mov    0x8(%ebp),%eax
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	52                   	push   %edx
  80145b:	ff 75 0c             	pushl  0xc(%ebp)
  80145e:	50                   	push   %eax
  80145f:	6a 00                	push   $0x0
  801461:	e8 b2 ff ff ff       	call   801418 <syscall>
  801466:	83 c4 18             	add    $0x18,%esp
}
  801469:	90                   	nop
  80146a:	c9                   	leave  
  80146b:	c3                   	ret    

0080146c <sys_cgetc>:

int
sys_cgetc(void)
{
  80146c:	55                   	push   %ebp
  80146d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 01                	push   $0x1
  80147b:	e8 98 ff ff ff       	call   801418 <syscall>
  801480:	83 c4 18             	add    $0x18,%esp
}
  801483:	c9                   	leave  
  801484:	c3                   	ret    

00801485 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801485:	55                   	push   %ebp
  801486:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	50                   	push   %eax
  801494:	6a 05                	push   $0x5
  801496:	e8 7d ff ff ff       	call   801418 <syscall>
  80149b:	83 c4 18             	add    $0x18,%esp
}
  80149e:	c9                   	leave  
  80149f:	c3                   	ret    

008014a0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8014a0:	55                   	push   %ebp
  8014a1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 02                	push   $0x2
  8014af:	e8 64 ff ff ff       	call   801418 <syscall>
  8014b4:	83 c4 18             	add    $0x18,%esp
}
  8014b7:	c9                   	leave  
  8014b8:	c3                   	ret    

008014b9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8014b9:	55                   	push   %ebp
  8014ba:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 03                	push   $0x3
  8014c8:	e8 4b ff ff ff       	call   801418 <syscall>
  8014cd:	83 c4 18             	add    $0x18,%esp
}
  8014d0:	c9                   	leave  
  8014d1:	c3                   	ret    

008014d2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8014d2:	55                   	push   %ebp
  8014d3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 04                	push   $0x4
  8014e1:	e8 32 ff ff ff       	call   801418 <syscall>
  8014e6:	83 c4 18             	add    $0x18,%esp
}
  8014e9:	c9                   	leave  
  8014ea:	c3                   	ret    

008014eb <sys_env_exit>:


void sys_env_exit(void)
{
  8014eb:	55                   	push   %ebp
  8014ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 06                	push   $0x6
  8014fa:	e8 19 ff ff ff       	call   801418 <syscall>
  8014ff:	83 c4 18             	add    $0x18,%esp
}
  801502:	90                   	nop
  801503:	c9                   	leave  
  801504:	c3                   	ret    

00801505 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801505:	55                   	push   %ebp
  801506:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801508:	8b 55 0c             	mov    0xc(%ebp),%edx
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	52                   	push   %edx
  801515:	50                   	push   %eax
  801516:	6a 07                	push   $0x7
  801518:	e8 fb fe ff ff       	call   801418 <syscall>
  80151d:	83 c4 18             	add    $0x18,%esp
}
  801520:	c9                   	leave  
  801521:	c3                   	ret    

00801522 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801522:	55                   	push   %ebp
  801523:	89 e5                	mov    %esp,%ebp
  801525:	56                   	push   %esi
  801526:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801527:	8b 75 18             	mov    0x18(%ebp),%esi
  80152a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80152d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801530:	8b 55 0c             	mov    0xc(%ebp),%edx
  801533:	8b 45 08             	mov    0x8(%ebp),%eax
  801536:	56                   	push   %esi
  801537:	53                   	push   %ebx
  801538:	51                   	push   %ecx
  801539:	52                   	push   %edx
  80153a:	50                   	push   %eax
  80153b:	6a 08                	push   $0x8
  80153d:	e8 d6 fe ff ff       	call   801418 <syscall>
  801542:	83 c4 18             	add    $0x18,%esp
}
  801545:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801548:	5b                   	pop    %ebx
  801549:	5e                   	pop    %esi
  80154a:	5d                   	pop    %ebp
  80154b:	c3                   	ret    

0080154c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80154f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801552:	8b 45 08             	mov    0x8(%ebp),%eax
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	52                   	push   %edx
  80155c:	50                   	push   %eax
  80155d:	6a 09                	push   $0x9
  80155f:	e8 b4 fe ff ff       	call   801418 <syscall>
  801564:	83 c4 18             	add    $0x18,%esp
}
  801567:	c9                   	leave  
  801568:	c3                   	ret    

00801569 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801569:	55                   	push   %ebp
  80156a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	ff 75 0c             	pushl  0xc(%ebp)
  801575:	ff 75 08             	pushl  0x8(%ebp)
  801578:	6a 0a                	push   $0xa
  80157a:	e8 99 fe ff ff       	call   801418 <syscall>
  80157f:	83 c4 18             	add    $0x18,%esp
}
  801582:	c9                   	leave  
  801583:	c3                   	ret    

00801584 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801584:	55                   	push   %ebp
  801585:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	6a 0b                	push   $0xb
  801593:	e8 80 fe ff ff       	call   801418 <syscall>
  801598:	83 c4 18             	add    $0x18,%esp
}
  80159b:	c9                   	leave  
  80159c:	c3                   	ret    

0080159d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 0c                	push   $0xc
  8015ac:	e8 67 fe ff ff       	call   801418 <syscall>
  8015b1:	83 c4 18             	add    $0x18,%esp
}
  8015b4:	c9                   	leave  
  8015b5:	c3                   	ret    

008015b6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015b6:	55                   	push   %ebp
  8015b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 0d                	push   $0xd
  8015c5:	e8 4e fe ff ff       	call   801418 <syscall>
  8015ca:	83 c4 18             	add    $0x18,%esp
}
  8015cd:	c9                   	leave  
  8015ce:	c3                   	ret    

008015cf <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015cf:	55                   	push   %ebp
  8015d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	ff 75 0c             	pushl  0xc(%ebp)
  8015db:	ff 75 08             	pushl  0x8(%ebp)
  8015de:	6a 11                	push   $0x11
  8015e0:	e8 33 fe ff ff       	call   801418 <syscall>
  8015e5:	83 c4 18             	add    $0x18,%esp
	return;
  8015e8:	90                   	nop
}
  8015e9:	c9                   	leave  
  8015ea:	c3                   	ret    

008015eb <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8015eb:	55                   	push   %ebp
  8015ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	ff 75 0c             	pushl  0xc(%ebp)
  8015f7:	ff 75 08             	pushl  0x8(%ebp)
  8015fa:	6a 12                	push   $0x12
  8015fc:	e8 17 fe ff ff       	call   801418 <syscall>
  801601:	83 c4 18             	add    $0x18,%esp
	return ;
  801604:	90                   	nop
}
  801605:	c9                   	leave  
  801606:	c3                   	ret    

00801607 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801607:	55                   	push   %ebp
  801608:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 0e                	push   $0xe
  801616:	e8 fd fd ff ff       	call   801418 <syscall>
  80161b:	83 c4 18             	add    $0x18,%esp
}
  80161e:	c9                   	leave  
  80161f:	c3                   	ret    

00801620 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801620:	55                   	push   %ebp
  801621:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	ff 75 08             	pushl  0x8(%ebp)
  80162e:	6a 0f                	push   $0xf
  801630:	e8 e3 fd ff ff       	call   801418 <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
}
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <sys_scarce_memory>:

void sys_scarce_memory()
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 10                	push   $0x10
  801649:	e8 ca fd ff ff       	call   801418 <syscall>
  80164e:	83 c4 18             	add    $0x18,%esp
}
  801651:	90                   	nop
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 14                	push   $0x14
  801663:	e8 b0 fd ff ff       	call   801418 <syscall>
  801668:	83 c4 18             	add    $0x18,%esp
}
  80166b:	90                   	nop
  80166c:	c9                   	leave  
  80166d:	c3                   	ret    

0080166e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80166e:	55                   	push   %ebp
  80166f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 15                	push   $0x15
  80167d:	e8 96 fd ff ff       	call   801418 <syscall>
  801682:	83 c4 18             	add    $0x18,%esp
}
  801685:	90                   	nop
  801686:	c9                   	leave  
  801687:	c3                   	ret    

00801688 <sys_cputc>:


void
sys_cputc(const char c)
{
  801688:	55                   	push   %ebp
  801689:	89 e5                	mov    %esp,%ebp
  80168b:	83 ec 04             	sub    $0x4,%esp
  80168e:	8b 45 08             	mov    0x8(%ebp),%eax
  801691:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801694:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	50                   	push   %eax
  8016a1:	6a 16                	push   $0x16
  8016a3:	e8 70 fd ff ff       	call   801418 <syscall>
  8016a8:	83 c4 18             	add    $0x18,%esp
}
  8016ab:	90                   	nop
  8016ac:	c9                   	leave  
  8016ad:	c3                   	ret    

008016ae <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016ae:	55                   	push   %ebp
  8016af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 17                	push   $0x17
  8016bd:	e8 56 fd ff ff       	call   801418 <syscall>
  8016c2:	83 c4 18             	add    $0x18,%esp
}
  8016c5:	90                   	nop
  8016c6:	c9                   	leave  
  8016c7:	c3                   	ret    

008016c8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8016c8:	55                   	push   %ebp
  8016c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	ff 75 0c             	pushl  0xc(%ebp)
  8016d7:	50                   	push   %eax
  8016d8:	6a 18                	push   $0x18
  8016da:	e8 39 fd ff ff       	call   801418 <syscall>
  8016df:	83 c4 18             	add    $0x18,%esp
}
  8016e2:	c9                   	leave  
  8016e3:	c3                   	ret    

008016e4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8016e4:	55                   	push   %ebp
  8016e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	52                   	push   %edx
  8016f4:	50                   	push   %eax
  8016f5:	6a 1b                	push   $0x1b
  8016f7:	e8 1c fd ff ff       	call   801418 <syscall>
  8016fc:	83 c4 18             	add    $0x18,%esp
}
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    

00801701 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801704:	8b 55 0c             	mov    0xc(%ebp),%edx
  801707:	8b 45 08             	mov    0x8(%ebp),%eax
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	52                   	push   %edx
  801711:	50                   	push   %eax
  801712:	6a 19                	push   $0x19
  801714:	e8 ff fc ff ff       	call   801418 <syscall>
  801719:	83 c4 18             	add    $0x18,%esp
}
  80171c:	90                   	nop
  80171d:	c9                   	leave  
  80171e:	c3                   	ret    

0080171f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80171f:	55                   	push   %ebp
  801720:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801722:	8b 55 0c             	mov    0xc(%ebp),%edx
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	52                   	push   %edx
  80172f:	50                   	push   %eax
  801730:	6a 1a                	push   $0x1a
  801732:	e8 e1 fc ff ff       	call   801418 <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	90                   	nop
  80173b:	c9                   	leave  
  80173c:	c3                   	ret    

0080173d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80173d:	55                   	push   %ebp
  80173e:	89 e5                	mov    %esp,%ebp
  801740:	83 ec 04             	sub    $0x4,%esp
  801743:	8b 45 10             	mov    0x10(%ebp),%eax
  801746:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801749:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80174c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
  801753:	6a 00                	push   $0x0
  801755:	51                   	push   %ecx
  801756:	52                   	push   %edx
  801757:	ff 75 0c             	pushl  0xc(%ebp)
  80175a:	50                   	push   %eax
  80175b:	6a 1c                	push   $0x1c
  80175d:	e8 b6 fc ff ff       	call   801418 <syscall>
  801762:	83 c4 18             	add    $0x18,%esp
}
  801765:	c9                   	leave  
  801766:	c3                   	ret    

00801767 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801767:	55                   	push   %ebp
  801768:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80176a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	52                   	push   %edx
  801777:	50                   	push   %eax
  801778:	6a 1d                	push   $0x1d
  80177a:	e8 99 fc ff ff       	call   801418 <syscall>
  80177f:	83 c4 18             	add    $0x18,%esp
}
  801782:	c9                   	leave  
  801783:	c3                   	ret    

00801784 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801784:	55                   	push   %ebp
  801785:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801787:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80178a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80178d:	8b 45 08             	mov    0x8(%ebp),%eax
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	51                   	push   %ecx
  801795:	52                   	push   %edx
  801796:	50                   	push   %eax
  801797:	6a 1e                	push   $0x1e
  801799:	e8 7a fc ff ff       	call   801418 <syscall>
  80179e:	83 c4 18             	add    $0x18,%esp
}
  8017a1:	c9                   	leave  
  8017a2:	c3                   	ret    

008017a3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8017a3:	55                   	push   %ebp
  8017a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8017a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	52                   	push   %edx
  8017b3:	50                   	push   %eax
  8017b4:	6a 1f                	push   $0x1f
  8017b6:	e8 5d fc ff ff       	call   801418 <syscall>
  8017bb:	83 c4 18             	add    $0x18,%esp
}
  8017be:	c9                   	leave  
  8017bf:	c3                   	ret    

008017c0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8017c0:	55                   	push   %ebp
  8017c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 20                	push   $0x20
  8017cf:	e8 44 fc ff ff       	call   801418 <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
}
  8017d7:	c9                   	leave  
  8017d8:	c3                   	ret    

008017d9 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8017dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	ff 75 10             	pushl  0x10(%ebp)
  8017e6:	ff 75 0c             	pushl  0xc(%ebp)
  8017e9:	50                   	push   %eax
  8017ea:	6a 21                	push   $0x21
  8017ec:	e8 27 fc ff ff       	call   801418 <syscall>
  8017f1:	83 c4 18             	add    $0x18,%esp
}
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8017f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	50                   	push   %eax
  801805:	6a 22                	push   $0x22
  801807:	e8 0c fc ff ff       	call   801418 <syscall>
  80180c:	83 c4 18             	add    $0x18,%esp
}
  80180f:	90                   	nop
  801810:	c9                   	leave  
  801811:	c3                   	ret    

00801812 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801812:	55                   	push   %ebp
  801813:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801815:	8b 45 08             	mov    0x8(%ebp),%eax
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	50                   	push   %eax
  801821:	6a 23                	push   $0x23
  801823:	e8 f0 fb ff ff       	call   801418 <syscall>
  801828:	83 c4 18             	add    $0x18,%esp
}
  80182b:	90                   	nop
  80182c:	c9                   	leave  
  80182d:	c3                   	ret    

0080182e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80182e:	55                   	push   %ebp
  80182f:	89 e5                	mov    %esp,%ebp
  801831:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801834:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801837:	8d 50 04             	lea    0x4(%eax),%edx
  80183a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	52                   	push   %edx
  801844:	50                   	push   %eax
  801845:	6a 24                	push   $0x24
  801847:	e8 cc fb ff ff       	call   801418 <syscall>
  80184c:	83 c4 18             	add    $0x18,%esp
	return result;
  80184f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801852:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801855:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801858:	89 01                	mov    %eax,(%ecx)
  80185a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80185d:	8b 45 08             	mov    0x8(%ebp),%eax
  801860:	c9                   	leave  
  801861:	c2 04 00             	ret    $0x4

00801864 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	ff 75 10             	pushl  0x10(%ebp)
  80186e:	ff 75 0c             	pushl  0xc(%ebp)
  801871:	ff 75 08             	pushl  0x8(%ebp)
  801874:	6a 13                	push   $0x13
  801876:	e8 9d fb ff ff       	call   801418 <syscall>
  80187b:	83 c4 18             	add    $0x18,%esp
	return ;
  80187e:	90                   	nop
}
  80187f:	c9                   	leave  
  801880:	c3                   	ret    

00801881 <sys_rcr2>:
uint32 sys_rcr2()
{
  801881:	55                   	push   %ebp
  801882:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 25                	push   $0x25
  801890:	e8 83 fb ff ff       	call   801418 <syscall>
  801895:	83 c4 18             	add    $0x18,%esp
}
  801898:	c9                   	leave  
  801899:	c3                   	ret    

0080189a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80189a:	55                   	push   %ebp
  80189b:	89 e5                	mov    %esp,%ebp
  80189d:	83 ec 04             	sub    $0x4,%esp
  8018a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018a6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	50                   	push   %eax
  8018b3:	6a 26                	push   $0x26
  8018b5:	e8 5e fb ff ff       	call   801418 <syscall>
  8018ba:	83 c4 18             	add    $0x18,%esp
	return ;
  8018bd:	90                   	nop
}
  8018be:	c9                   	leave  
  8018bf:	c3                   	ret    

008018c0 <rsttst>:
void rsttst()
{
  8018c0:	55                   	push   %ebp
  8018c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 28                	push   $0x28
  8018cf:	e8 44 fb ff ff       	call   801418 <syscall>
  8018d4:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d7:	90                   	nop
}
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
  8018dd:	83 ec 04             	sub    $0x4,%esp
  8018e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018e6:	8b 55 18             	mov    0x18(%ebp),%edx
  8018e9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018ed:	52                   	push   %edx
  8018ee:	50                   	push   %eax
  8018ef:	ff 75 10             	pushl  0x10(%ebp)
  8018f2:	ff 75 0c             	pushl  0xc(%ebp)
  8018f5:	ff 75 08             	pushl  0x8(%ebp)
  8018f8:	6a 27                	push   $0x27
  8018fa:	e8 19 fb ff ff       	call   801418 <syscall>
  8018ff:	83 c4 18             	add    $0x18,%esp
	return ;
  801902:	90                   	nop
}
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <chktst>:
void chktst(uint32 n)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	ff 75 08             	pushl  0x8(%ebp)
  801913:	6a 29                	push   $0x29
  801915:	e8 fe fa ff ff       	call   801418 <syscall>
  80191a:	83 c4 18             	add    $0x18,%esp
	return ;
  80191d:	90                   	nop
}
  80191e:	c9                   	leave  
  80191f:	c3                   	ret    

00801920 <inctst>:

void inctst()
{
  801920:	55                   	push   %ebp
  801921:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 2a                	push   $0x2a
  80192f:	e8 e4 fa ff ff       	call   801418 <syscall>
  801934:	83 c4 18             	add    $0x18,%esp
	return ;
  801937:	90                   	nop
}
  801938:	c9                   	leave  
  801939:	c3                   	ret    

0080193a <gettst>:
uint32 gettst()
{
  80193a:	55                   	push   %ebp
  80193b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 2b                	push   $0x2b
  801949:	e8 ca fa ff ff       	call   801418 <syscall>
  80194e:	83 c4 18             	add    $0x18,%esp
}
  801951:	c9                   	leave  
  801952:	c3                   	ret    

00801953 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801953:	55                   	push   %ebp
  801954:	89 e5                	mov    %esp,%ebp
  801956:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 2c                	push   $0x2c
  801965:	e8 ae fa ff ff       	call   801418 <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
  80196d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801970:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801974:	75 07                	jne    80197d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801976:	b8 01 00 00 00       	mov    $0x1,%eax
  80197b:	eb 05                	jmp    801982 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80197d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801982:	c9                   	leave  
  801983:	c3                   	ret    

00801984 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801984:	55                   	push   %ebp
  801985:	89 e5                	mov    %esp,%ebp
  801987:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 2c                	push   $0x2c
  801996:	e8 7d fa ff ff       	call   801418 <syscall>
  80199b:	83 c4 18             	add    $0x18,%esp
  80199e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8019a1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8019a5:	75 07                	jne    8019ae <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8019a7:	b8 01 00 00 00       	mov    $0x1,%eax
  8019ac:	eb 05                	jmp    8019b3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8019ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
  8019b8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 2c                	push   $0x2c
  8019c7:	e8 4c fa ff ff       	call   801418 <syscall>
  8019cc:	83 c4 18             	add    $0x18,%esp
  8019cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8019d2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8019d6:	75 07                	jne    8019df <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8019d8:	b8 01 00 00 00       	mov    $0x1,%eax
  8019dd:	eb 05                	jmp    8019e4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8019df:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019e4:	c9                   	leave  
  8019e5:	c3                   	ret    

008019e6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8019e6:	55                   	push   %ebp
  8019e7:	89 e5                	mov    %esp,%ebp
  8019e9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 2c                	push   $0x2c
  8019f8:	e8 1b fa ff ff       	call   801418 <syscall>
  8019fd:	83 c4 18             	add    $0x18,%esp
  801a00:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a03:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a07:	75 07                	jne    801a10 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a09:	b8 01 00 00 00       	mov    $0x1,%eax
  801a0e:	eb 05                	jmp    801a15 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a10:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a15:	c9                   	leave  
  801a16:	c3                   	ret    

00801a17 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a17:	55                   	push   %ebp
  801a18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	ff 75 08             	pushl  0x8(%ebp)
  801a25:	6a 2d                	push   $0x2d
  801a27:	e8 ec f9 ff ff       	call   801418 <syscall>
  801a2c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a2f:	90                   	nop
}
  801a30:	c9                   	leave  
  801a31:	c3                   	ret    
  801a32:	66 90                	xchg   %ax,%ax

00801a34 <__udivdi3>:
  801a34:	55                   	push   %ebp
  801a35:	57                   	push   %edi
  801a36:	56                   	push   %esi
  801a37:	53                   	push   %ebx
  801a38:	83 ec 1c             	sub    $0x1c,%esp
  801a3b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a3f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a47:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a4b:	89 ca                	mov    %ecx,%edx
  801a4d:	89 f8                	mov    %edi,%eax
  801a4f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a53:	85 f6                	test   %esi,%esi
  801a55:	75 2d                	jne    801a84 <__udivdi3+0x50>
  801a57:	39 cf                	cmp    %ecx,%edi
  801a59:	77 65                	ja     801ac0 <__udivdi3+0x8c>
  801a5b:	89 fd                	mov    %edi,%ebp
  801a5d:	85 ff                	test   %edi,%edi
  801a5f:	75 0b                	jne    801a6c <__udivdi3+0x38>
  801a61:	b8 01 00 00 00       	mov    $0x1,%eax
  801a66:	31 d2                	xor    %edx,%edx
  801a68:	f7 f7                	div    %edi
  801a6a:	89 c5                	mov    %eax,%ebp
  801a6c:	31 d2                	xor    %edx,%edx
  801a6e:	89 c8                	mov    %ecx,%eax
  801a70:	f7 f5                	div    %ebp
  801a72:	89 c1                	mov    %eax,%ecx
  801a74:	89 d8                	mov    %ebx,%eax
  801a76:	f7 f5                	div    %ebp
  801a78:	89 cf                	mov    %ecx,%edi
  801a7a:	89 fa                	mov    %edi,%edx
  801a7c:	83 c4 1c             	add    $0x1c,%esp
  801a7f:	5b                   	pop    %ebx
  801a80:	5e                   	pop    %esi
  801a81:	5f                   	pop    %edi
  801a82:	5d                   	pop    %ebp
  801a83:	c3                   	ret    
  801a84:	39 ce                	cmp    %ecx,%esi
  801a86:	77 28                	ja     801ab0 <__udivdi3+0x7c>
  801a88:	0f bd fe             	bsr    %esi,%edi
  801a8b:	83 f7 1f             	xor    $0x1f,%edi
  801a8e:	75 40                	jne    801ad0 <__udivdi3+0x9c>
  801a90:	39 ce                	cmp    %ecx,%esi
  801a92:	72 0a                	jb     801a9e <__udivdi3+0x6a>
  801a94:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a98:	0f 87 9e 00 00 00    	ja     801b3c <__udivdi3+0x108>
  801a9e:	b8 01 00 00 00       	mov    $0x1,%eax
  801aa3:	89 fa                	mov    %edi,%edx
  801aa5:	83 c4 1c             	add    $0x1c,%esp
  801aa8:	5b                   	pop    %ebx
  801aa9:	5e                   	pop    %esi
  801aaa:	5f                   	pop    %edi
  801aab:	5d                   	pop    %ebp
  801aac:	c3                   	ret    
  801aad:	8d 76 00             	lea    0x0(%esi),%esi
  801ab0:	31 ff                	xor    %edi,%edi
  801ab2:	31 c0                	xor    %eax,%eax
  801ab4:	89 fa                	mov    %edi,%edx
  801ab6:	83 c4 1c             	add    $0x1c,%esp
  801ab9:	5b                   	pop    %ebx
  801aba:	5e                   	pop    %esi
  801abb:	5f                   	pop    %edi
  801abc:	5d                   	pop    %ebp
  801abd:	c3                   	ret    
  801abe:	66 90                	xchg   %ax,%ax
  801ac0:	89 d8                	mov    %ebx,%eax
  801ac2:	f7 f7                	div    %edi
  801ac4:	31 ff                	xor    %edi,%edi
  801ac6:	89 fa                	mov    %edi,%edx
  801ac8:	83 c4 1c             	add    $0x1c,%esp
  801acb:	5b                   	pop    %ebx
  801acc:	5e                   	pop    %esi
  801acd:	5f                   	pop    %edi
  801ace:	5d                   	pop    %ebp
  801acf:	c3                   	ret    
  801ad0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ad5:	89 eb                	mov    %ebp,%ebx
  801ad7:	29 fb                	sub    %edi,%ebx
  801ad9:	89 f9                	mov    %edi,%ecx
  801adb:	d3 e6                	shl    %cl,%esi
  801add:	89 c5                	mov    %eax,%ebp
  801adf:	88 d9                	mov    %bl,%cl
  801ae1:	d3 ed                	shr    %cl,%ebp
  801ae3:	89 e9                	mov    %ebp,%ecx
  801ae5:	09 f1                	or     %esi,%ecx
  801ae7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801aeb:	89 f9                	mov    %edi,%ecx
  801aed:	d3 e0                	shl    %cl,%eax
  801aef:	89 c5                	mov    %eax,%ebp
  801af1:	89 d6                	mov    %edx,%esi
  801af3:	88 d9                	mov    %bl,%cl
  801af5:	d3 ee                	shr    %cl,%esi
  801af7:	89 f9                	mov    %edi,%ecx
  801af9:	d3 e2                	shl    %cl,%edx
  801afb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aff:	88 d9                	mov    %bl,%cl
  801b01:	d3 e8                	shr    %cl,%eax
  801b03:	09 c2                	or     %eax,%edx
  801b05:	89 d0                	mov    %edx,%eax
  801b07:	89 f2                	mov    %esi,%edx
  801b09:	f7 74 24 0c          	divl   0xc(%esp)
  801b0d:	89 d6                	mov    %edx,%esi
  801b0f:	89 c3                	mov    %eax,%ebx
  801b11:	f7 e5                	mul    %ebp
  801b13:	39 d6                	cmp    %edx,%esi
  801b15:	72 19                	jb     801b30 <__udivdi3+0xfc>
  801b17:	74 0b                	je     801b24 <__udivdi3+0xf0>
  801b19:	89 d8                	mov    %ebx,%eax
  801b1b:	31 ff                	xor    %edi,%edi
  801b1d:	e9 58 ff ff ff       	jmp    801a7a <__udivdi3+0x46>
  801b22:	66 90                	xchg   %ax,%ax
  801b24:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b28:	89 f9                	mov    %edi,%ecx
  801b2a:	d3 e2                	shl    %cl,%edx
  801b2c:	39 c2                	cmp    %eax,%edx
  801b2e:	73 e9                	jae    801b19 <__udivdi3+0xe5>
  801b30:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b33:	31 ff                	xor    %edi,%edi
  801b35:	e9 40 ff ff ff       	jmp    801a7a <__udivdi3+0x46>
  801b3a:	66 90                	xchg   %ax,%ax
  801b3c:	31 c0                	xor    %eax,%eax
  801b3e:	e9 37 ff ff ff       	jmp    801a7a <__udivdi3+0x46>
  801b43:	90                   	nop

00801b44 <__umoddi3>:
  801b44:	55                   	push   %ebp
  801b45:	57                   	push   %edi
  801b46:	56                   	push   %esi
  801b47:	53                   	push   %ebx
  801b48:	83 ec 1c             	sub    $0x1c,%esp
  801b4b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b4f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b53:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b57:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b5b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b5f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b63:	89 f3                	mov    %esi,%ebx
  801b65:	89 fa                	mov    %edi,%edx
  801b67:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b6b:	89 34 24             	mov    %esi,(%esp)
  801b6e:	85 c0                	test   %eax,%eax
  801b70:	75 1a                	jne    801b8c <__umoddi3+0x48>
  801b72:	39 f7                	cmp    %esi,%edi
  801b74:	0f 86 a2 00 00 00    	jbe    801c1c <__umoddi3+0xd8>
  801b7a:	89 c8                	mov    %ecx,%eax
  801b7c:	89 f2                	mov    %esi,%edx
  801b7e:	f7 f7                	div    %edi
  801b80:	89 d0                	mov    %edx,%eax
  801b82:	31 d2                	xor    %edx,%edx
  801b84:	83 c4 1c             	add    $0x1c,%esp
  801b87:	5b                   	pop    %ebx
  801b88:	5e                   	pop    %esi
  801b89:	5f                   	pop    %edi
  801b8a:	5d                   	pop    %ebp
  801b8b:	c3                   	ret    
  801b8c:	39 f0                	cmp    %esi,%eax
  801b8e:	0f 87 ac 00 00 00    	ja     801c40 <__umoddi3+0xfc>
  801b94:	0f bd e8             	bsr    %eax,%ebp
  801b97:	83 f5 1f             	xor    $0x1f,%ebp
  801b9a:	0f 84 ac 00 00 00    	je     801c4c <__umoddi3+0x108>
  801ba0:	bf 20 00 00 00       	mov    $0x20,%edi
  801ba5:	29 ef                	sub    %ebp,%edi
  801ba7:	89 fe                	mov    %edi,%esi
  801ba9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bad:	89 e9                	mov    %ebp,%ecx
  801baf:	d3 e0                	shl    %cl,%eax
  801bb1:	89 d7                	mov    %edx,%edi
  801bb3:	89 f1                	mov    %esi,%ecx
  801bb5:	d3 ef                	shr    %cl,%edi
  801bb7:	09 c7                	or     %eax,%edi
  801bb9:	89 e9                	mov    %ebp,%ecx
  801bbb:	d3 e2                	shl    %cl,%edx
  801bbd:	89 14 24             	mov    %edx,(%esp)
  801bc0:	89 d8                	mov    %ebx,%eax
  801bc2:	d3 e0                	shl    %cl,%eax
  801bc4:	89 c2                	mov    %eax,%edx
  801bc6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bca:	d3 e0                	shl    %cl,%eax
  801bcc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bd0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bd4:	89 f1                	mov    %esi,%ecx
  801bd6:	d3 e8                	shr    %cl,%eax
  801bd8:	09 d0                	or     %edx,%eax
  801bda:	d3 eb                	shr    %cl,%ebx
  801bdc:	89 da                	mov    %ebx,%edx
  801bde:	f7 f7                	div    %edi
  801be0:	89 d3                	mov    %edx,%ebx
  801be2:	f7 24 24             	mull   (%esp)
  801be5:	89 c6                	mov    %eax,%esi
  801be7:	89 d1                	mov    %edx,%ecx
  801be9:	39 d3                	cmp    %edx,%ebx
  801beb:	0f 82 87 00 00 00    	jb     801c78 <__umoddi3+0x134>
  801bf1:	0f 84 91 00 00 00    	je     801c88 <__umoddi3+0x144>
  801bf7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bfb:	29 f2                	sub    %esi,%edx
  801bfd:	19 cb                	sbb    %ecx,%ebx
  801bff:	89 d8                	mov    %ebx,%eax
  801c01:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c05:	d3 e0                	shl    %cl,%eax
  801c07:	89 e9                	mov    %ebp,%ecx
  801c09:	d3 ea                	shr    %cl,%edx
  801c0b:	09 d0                	or     %edx,%eax
  801c0d:	89 e9                	mov    %ebp,%ecx
  801c0f:	d3 eb                	shr    %cl,%ebx
  801c11:	89 da                	mov    %ebx,%edx
  801c13:	83 c4 1c             	add    $0x1c,%esp
  801c16:	5b                   	pop    %ebx
  801c17:	5e                   	pop    %esi
  801c18:	5f                   	pop    %edi
  801c19:	5d                   	pop    %ebp
  801c1a:	c3                   	ret    
  801c1b:	90                   	nop
  801c1c:	89 fd                	mov    %edi,%ebp
  801c1e:	85 ff                	test   %edi,%edi
  801c20:	75 0b                	jne    801c2d <__umoddi3+0xe9>
  801c22:	b8 01 00 00 00       	mov    $0x1,%eax
  801c27:	31 d2                	xor    %edx,%edx
  801c29:	f7 f7                	div    %edi
  801c2b:	89 c5                	mov    %eax,%ebp
  801c2d:	89 f0                	mov    %esi,%eax
  801c2f:	31 d2                	xor    %edx,%edx
  801c31:	f7 f5                	div    %ebp
  801c33:	89 c8                	mov    %ecx,%eax
  801c35:	f7 f5                	div    %ebp
  801c37:	89 d0                	mov    %edx,%eax
  801c39:	e9 44 ff ff ff       	jmp    801b82 <__umoddi3+0x3e>
  801c3e:	66 90                	xchg   %ax,%ax
  801c40:	89 c8                	mov    %ecx,%eax
  801c42:	89 f2                	mov    %esi,%edx
  801c44:	83 c4 1c             	add    $0x1c,%esp
  801c47:	5b                   	pop    %ebx
  801c48:	5e                   	pop    %esi
  801c49:	5f                   	pop    %edi
  801c4a:	5d                   	pop    %ebp
  801c4b:	c3                   	ret    
  801c4c:	3b 04 24             	cmp    (%esp),%eax
  801c4f:	72 06                	jb     801c57 <__umoddi3+0x113>
  801c51:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c55:	77 0f                	ja     801c66 <__umoddi3+0x122>
  801c57:	89 f2                	mov    %esi,%edx
  801c59:	29 f9                	sub    %edi,%ecx
  801c5b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c5f:	89 14 24             	mov    %edx,(%esp)
  801c62:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c66:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c6a:	8b 14 24             	mov    (%esp),%edx
  801c6d:	83 c4 1c             	add    $0x1c,%esp
  801c70:	5b                   	pop    %ebx
  801c71:	5e                   	pop    %esi
  801c72:	5f                   	pop    %edi
  801c73:	5d                   	pop    %ebp
  801c74:	c3                   	ret    
  801c75:	8d 76 00             	lea    0x0(%esi),%esi
  801c78:	2b 04 24             	sub    (%esp),%eax
  801c7b:	19 fa                	sbb    %edi,%edx
  801c7d:	89 d1                	mov    %edx,%ecx
  801c7f:	89 c6                	mov    %eax,%esi
  801c81:	e9 71 ff ff ff       	jmp    801bf7 <__umoddi3+0xb3>
  801c86:	66 90                	xchg   %ax,%ax
  801c88:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c8c:	72 ea                	jb     801c78 <__umoddi3+0x134>
  801c8e:	89 d9                	mov    %ebx,%ecx
  801c90:	e9 62 ff ff ff       	jmp    801bf7 <__umoddi3+0xb3>
