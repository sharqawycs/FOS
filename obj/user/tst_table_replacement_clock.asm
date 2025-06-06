
obj/user/tst_table_replacement_clock:     file format elf32-i386


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
  800031:	e8 8d 02 00 00       	call   8002c3 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:


uint8* ptr = (uint8* )0x0800000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 38 00 00 02    	sub    $0x2000038,%esp

	
	

	{
		if ( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x00000000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800041:	a1 08 30 80 00       	mov    0x803008,%eax
  800046:	8b 40 7c             	mov    0x7c(%eax),%eax
  800049:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80004f:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800054:	85 c0                	test   %eax,%eax
  800056:	74 14                	je     80006c <_main+0x34>
  800058:	83 ec 04             	sub    $0x4,%esp
  80005b:	68 a0 1c 80 00       	push   $0x801ca0
  800060:	6a 16                	push   $0x16
  800062:	68 e8 1c 80 00       	push   $0x801ce8
  800067:	e8 59 03 00 00       	call   8003c5 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80006c:	a1 08 30 80 00       	mov    0x803008,%eax
  800071:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  800077:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80007a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80007d:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800082:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800087:	74 14                	je     80009d <_main+0x65>
  800089:	83 ec 04             	sub    $0x4,%esp
  80008c:	68 a0 1c 80 00       	push   $0x801ca0
  800091:	6a 17                	push   $0x17
  800093:	68 e8 1c 80 00       	push   $0x801ce8
  800098:	e8 28 03 00 00       	call   8003c5 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80009d:	a1 08 30 80 00       	mov    0x803008,%eax
  8000a2:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
  8000a8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000ae:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000b3:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  8000b8:	74 14                	je     8000ce <_main+0x96>
  8000ba:	83 ec 04             	sub    $0x4,%esp
  8000bd:	68 a0 1c 80 00       	push   $0x801ca0
  8000c2:	6a 18                	push   $0x18
  8000c4:	68 e8 1c 80 00       	push   $0x801ce8
  8000c9:	e8 f7 02 00 00       	call   8003c5 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000ce:	a1 08 30 80 00       	mov    0x803008,%eax
  8000d3:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
  8000d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000df:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000e4:	3d 00 00 80 ec       	cmp    $0xec800000,%eax
  8000e9:	74 14                	je     8000ff <_main+0xc7>
  8000eb:	83 ec 04             	sub    $0x4,%esp
  8000ee:	68 a0 1c 80 00       	push   $0x801ca0
  8000f3:	6a 19                	push   $0x19
  8000f5:	68 e8 1c 80 00       	push   $0x801ce8
  8000fa:	e8 c6 02 00 00       	call   8003c5 <_panic>
		if( myEnv->table_last_WS_index !=  4)  											panic("INITIAL TABLE last index checking failed! Review sizes of the two WS's..!!");
  8000ff:	a1 08 30 80 00       	mov    0x803008,%eax
  800104:	8b 80 d8 02 00 00    	mov    0x2d8(%eax),%eax
  80010a:	83 f8 04             	cmp    $0x4,%eax
  80010d:	74 14                	je     800123 <_main+0xeb>
  80010f:	83 ec 04             	sub    $0x4,%esp
  800112:	68 0c 1d 80 00       	push   $0x801d0c
  800117:	6a 1a                	push   $0x1a
  800119:	68 e8 1c 80 00       	push   $0x801ce8
  80011e:	e8 a2 02 00 00       	call   8003c5 <_panic>

	}
	int freeFrames = sys_calculate_free_frames() ;
  800123:	e8 47 14 00 00       	call   80156f <sys_calculate_free_frames>
  800128:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  80012b:	e8 c2 14 00 00       	call   8015f2 <sys_pf_calculate_allocated_pages>
  800130:	89 45 dc             	mov    %eax,-0x24(%ebp)

	{
		arr[0] = -1;
  800133:	c6 85 c8 ff ff fd ff 	movb   $0xff,-0x2000038(%ebp)
		arr[PAGE_SIZE*1024-1] = -1;
  80013a:	c6 85 c7 ff 3f fe ff 	movb   $0xff,-0x1c00039(%ebp)

		int i ;
		for (i = 0 ; i < PAGE_SIZE * 2; i++)
  800141:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800148:	eb 33                	jmp    80017d <_main+0x145>
		{
			arr[PAGE_SIZE*1024*2 - i] = -20;
  80014a:	b8 00 00 80 00       	mov    $0x800000,%eax
  80014f:	2b 45 f4             	sub    -0xc(%ebp),%eax
  800152:	c6 84 05 c8 ff ff fd 	movb   $0xec,-0x2000038(%ebp,%eax,1)
  800159:	ec 
			arr[PAGE_SIZE*1024*3 - i] = -30;
  80015a:	b8 00 00 c0 00       	mov    $0xc00000,%eax
  80015f:	2b 45 f4             	sub    -0xc(%ebp),%eax
  800162:	c6 84 05 c8 ff ff fd 	movb   $0xe2,-0x2000038(%ebp,%eax,1)
  800169:	e2 
			arr[PAGE_SIZE*1024*4 - i] = -40;
  80016a:	b8 00 00 00 01       	mov    $0x1000000,%eax
  80016f:	2b 45 f4             	sub    -0xc(%ebp),%eax
  800172:	c6 84 05 c8 ff ff fd 	movb   $0xd8,-0x2000038(%ebp,%eax,1)
  800179:	d8 
	{
		arr[0] = -1;
		arr[PAGE_SIZE*1024-1] = -1;

		int i ;
		for (i = 0 ; i < PAGE_SIZE * 2; i++)
  80017a:	ff 45 f4             	incl   -0xc(%ebp)
  80017d:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800184:	7e c4                	jle    80014a <_main+0x112>
		{
			arr[PAGE_SIZE*1024*2 - i] = -20;
			arr[PAGE_SIZE*1024*3 - i] = -30;
			arr[PAGE_SIZE*1024*4 - i] = -40;
		}
		arr[PAGE_SIZE*1024*5-1] = -1;
  800186:	c6 85 c7 ff 3f ff ff 	movb   $0xff,-0xc00039(%ebp)
		arr[PAGE_SIZE*1024*6-1] = -1;
  80018d:	c6 85 c7 ff 7f ff ff 	movb   $0xff,-0x800039(%ebp)
		arr[PAGE_SIZE*1024*7-1] = -1;
  800194:	c6 85 c7 ff bf ff ff 	movb   $0xff,-0x400039(%ebp)

	}

	//cprintf("testing ...\n");
	{
		if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0xedc00000)  panic("clock algo failed.. trace it by printing WS before and after table fault");
  80019b:	a1 08 30 80 00       	mov    0x803008,%eax
  8001a0:	8b 40 7c             	mov    0x7c(%eax),%eax
  8001a3:	89 45 d8             	mov    %eax,-0x28(%ebp)
  8001a6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001a9:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8001ae:	3d 00 00 c0 ed       	cmp    $0xedc00000,%eax
  8001b3:	74 14                	je     8001c9 <_main+0x191>
  8001b5:	83 ec 04             	sub    $0x4,%esp
  8001b8:	68 58 1d 80 00       	push   $0x801d58
  8001bd:	6a 33                	push   $0x33
  8001bf:	68 e8 1c 80 00       	push   $0x801ce8
  8001c4:	e8 fc 01 00 00       	call   8003c5 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("clock algo failed.. trace it by printing WS before and after table fault");
  8001c9:	a1 08 30 80 00       	mov    0x803008,%eax
  8001ce:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  8001d4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001d7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001da:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8001df:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001e4:	74 14                	je     8001fa <_main+0x1c2>
  8001e6:	83 ec 04             	sub    $0x4,%esp
  8001e9:	68 58 1d 80 00       	push   $0x801d58
  8001ee:	6a 34                	push   $0x34
  8001f0:	68 e8 1c 80 00       	push   $0x801ce8
  8001f5:	e8 cb 01 00 00       	call   8003c5 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee000000)  panic("clock algo failed.. trace it by printing WS before and after table fault");
  8001fa:	a1 08 30 80 00       	mov    0x803008,%eax
  8001ff:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
  800205:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800208:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80020b:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800210:	3d 00 00 00 ee       	cmp    $0xee000000,%eax
  800215:	74 14                	je     80022b <_main+0x1f3>
  800217:	83 ec 04             	sub    $0x4,%esp
  80021a:	68 58 1d 80 00       	push   $0x801d58
  80021f:	6a 35                	push   $0x35
  800221:	68 e8 1c 80 00       	push   $0x801ce8
  800226:	e8 9a 01 00 00       	call   8003c5 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xee400000)  panic("clock algo failed.. trace it by printing WS before and after table fault");
  80022b:	a1 08 30 80 00       	mov    0x803008,%eax
  800230:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
  800236:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800239:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80023c:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800241:	3d 00 00 40 ee       	cmp    $0xee400000,%eax
  800246:	74 14                	je     80025c <_main+0x224>
  800248:	83 ec 04             	sub    $0x4,%esp
  80024b:	68 58 1d 80 00       	push   $0x801d58
  800250:	6a 36                	push   $0x36
  800252:	68 e8 1c 80 00       	push   $0x801ce8
  800257:	e8 69 01 00 00       	call   8003c5 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[4].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("clock algo failed.. trace it by printing WS before and after table fault");
  80025c:	a1 08 30 80 00       	mov    0x803008,%eax
  800261:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
  800267:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80026a:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80026d:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800272:	3d 00 00 80 ec       	cmp    $0xec800000,%eax
  800277:	74 14                	je     80028d <_main+0x255>
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	68 58 1d 80 00       	push   $0x801d58
  800281:	6a 37                	push   $0x37
  800283:	68 e8 1c 80 00       	push   $0x801ce8
  800288:	e8 38 01 00 00       	call   8003c5 <_panic>

		if(myEnv->table_last_WS_index != 0) panic("wrong TABLE WS pointer location");
  80028d:	a1 08 30 80 00       	mov    0x803008,%eax
  800292:	8b 80 d8 02 00 00    	mov    0x2d8(%eax),%eax
  800298:	85 c0                	test   %eax,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 a4 1d 80 00       	push   $0x801da4
  8002a4:	6a 39                	push   $0x39
  8002a6:	68 e8 1c 80 00       	push   $0x801ce8
  8002ab:	e8 15 01 00 00       	call   8003c5 <_panic>
	}

	cprintf("Congratulations!! test table replacement (CLOCK alg) completed successfully.\n");
  8002b0:	83 ec 0c             	sub    $0xc,%esp
  8002b3:	68 c4 1d 80 00       	push   $0x801dc4
  8002b8:	e8 bc 03 00 00       	call   800679 <cprintf>
  8002bd:	83 c4 10             	add    $0x10,%esp
	return;
  8002c0:	90                   	nop
}
  8002c1:	c9                   	leave  
  8002c2:	c3                   	ret    

008002c3 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8002c3:	55                   	push   %ebp
  8002c4:	89 e5                	mov    %esp,%ebp
  8002c6:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8002c9:	e8 d6 11 00 00       	call   8014a4 <sys_getenvindex>
  8002ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8002d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002d4:	89 d0                	mov    %edx,%eax
  8002d6:	01 c0                	add    %eax,%eax
  8002d8:	01 d0                	add    %edx,%eax
  8002da:	c1 e0 02             	shl    $0x2,%eax
  8002dd:	01 d0                	add    %edx,%eax
  8002df:	c1 e0 06             	shl    $0x6,%eax
  8002e2:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002e7:	a3 08 30 80 00       	mov    %eax,0x803008

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002ec:	a1 08 30 80 00       	mov    0x803008,%eax
  8002f1:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8002f7:	84 c0                	test   %al,%al
  8002f9:	74 0f                	je     80030a <libmain+0x47>
		binaryname = myEnv->prog_name;
  8002fb:	a1 08 30 80 00       	mov    0x803008,%eax
  800300:	05 f4 02 00 00       	add    $0x2f4,%eax
  800305:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80030a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80030e:	7e 0a                	jle    80031a <libmain+0x57>
		binaryname = argv[0];
  800310:	8b 45 0c             	mov    0xc(%ebp),%eax
  800313:	8b 00                	mov    (%eax),%eax
  800315:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  80031a:	83 ec 08             	sub    $0x8,%esp
  80031d:	ff 75 0c             	pushl  0xc(%ebp)
  800320:	ff 75 08             	pushl  0x8(%ebp)
  800323:	e8 10 fd ff ff       	call   800038 <_main>
  800328:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80032b:	e8 0f 13 00 00       	call   80163f <sys_disable_interrupt>
	cprintf("**************************************\n");
  800330:	83 ec 0c             	sub    $0xc,%esp
  800333:	68 2c 1e 80 00       	push   $0x801e2c
  800338:	e8 3c 03 00 00       	call   800679 <cprintf>
  80033d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800340:	a1 08 30 80 00       	mov    0x803008,%eax
  800345:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80034b:	a1 08 30 80 00       	mov    0x803008,%eax
  800350:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800356:	83 ec 04             	sub    $0x4,%esp
  800359:	52                   	push   %edx
  80035a:	50                   	push   %eax
  80035b:	68 54 1e 80 00       	push   $0x801e54
  800360:	e8 14 03 00 00       	call   800679 <cprintf>
  800365:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800368:	a1 08 30 80 00       	mov    0x803008,%eax
  80036d:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800373:	83 ec 08             	sub    $0x8,%esp
  800376:	50                   	push   %eax
  800377:	68 79 1e 80 00       	push   $0x801e79
  80037c:	e8 f8 02 00 00       	call   800679 <cprintf>
  800381:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800384:	83 ec 0c             	sub    $0xc,%esp
  800387:	68 2c 1e 80 00       	push   $0x801e2c
  80038c:	e8 e8 02 00 00       	call   800679 <cprintf>
  800391:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800394:	e8 c0 12 00 00       	call   801659 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800399:	e8 19 00 00 00       	call   8003b7 <exit>
}
  80039e:	90                   	nop
  80039f:	c9                   	leave  
  8003a0:	c3                   	ret    

008003a1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003a1:	55                   	push   %ebp
  8003a2:	89 e5                	mov    %esp,%ebp
  8003a4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8003a7:	83 ec 0c             	sub    $0xc,%esp
  8003aa:	6a 00                	push   $0x0
  8003ac:	e8 bf 10 00 00       	call   801470 <sys_env_destroy>
  8003b1:	83 c4 10             	add    $0x10,%esp
}
  8003b4:	90                   	nop
  8003b5:	c9                   	leave  
  8003b6:	c3                   	ret    

008003b7 <exit>:

void
exit(void)
{
  8003b7:	55                   	push   %ebp
  8003b8:	89 e5                	mov    %esp,%ebp
  8003ba:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8003bd:	e8 14 11 00 00       	call   8014d6 <sys_env_exit>
}
  8003c2:	90                   	nop
  8003c3:	c9                   	leave  
  8003c4:	c3                   	ret    

008003c5 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003c5:	55                   	push   %ebp
  8003c6:	89 e5                	mov    %esp,%ebp
  8003c8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8003cb:	8d 45 10             	lea    0x10(%ebp),%eax
  8003ce:	83 c0 04             	add    $0x4,%eax
  8003d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003d4:	a1 18 30 80 00       	mov    0x803018,%eax
  8003d9:	85 c0                	test   %eax,%eax
  8003db:	74 16                	je     8003f3 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8003dd:	a1 18 30 80 00       	mov    0x803018,%eax
  8003e2:	83 ec 08             	sub    $0x8,%esp
  8003e5:	50                   	push   %eax
  8003e6:	68 90 1e 80 00       	push   $0x801e90
  8003eb:	e8 89 02 00 00       	call   800679 <cprintf>
  8003f0:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8003f3:	a1 04 30 80 00       	mov    0x803004,%eax
  8003f8:	ff 75 0c             	pushl  0xc(%ebp)
  8003fb:	ff 75 08             	pushl  0x8(%ebp)
  8003fe:	50                   	push   %eax
  8003ff:	68 95 1e 80 00       	push   $0x801e95
  800404:	e8 70 02 00 00       	call   800679 <cprintf>
  800409:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80040c:	8b 45 10             	mov    0x10(%ebp),%eax
  80040f:	83 ec 08             	sub    $0x8,%esp
  800412:	ff 75 f4             	pushl  -0xc(%ebp)
  800415:	50                   	push   %eax
  800416:	e8 f3 01 00 00       	call   80060e <vcprintf>
  80041b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80041e:	83 ec 08             	sub    $0x8,%esp
  800421:	6a 00                	push   $0x0
  800423:	68 b1 1e 80 00       	push   $0x801eb1
  800428:	e8 e1 01 00 00       	call   80060e <vcprintf>
  80042d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800430:	e8 82 ff ff ff       	call   8003b7 <exit>

	// should not return here
	while (1) ;
  800435:	eb fe                	jmp    800435 <_panic+0x70>

00800437 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800437:	55                   	push   %ebp
  800438:	89 e5                	mov    %esp,%ebp
  80043a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80043d:	a1 08 30 80 00       	mov    0x803008,%eax
  800442:	8b 50 74             	mov    0x74(%eax),%edx
  800445:	8b 45 0c             	mov    0xc(%ebp),%eax
  800448:	39 c2                	cmp    %eax,%edx
  80044a:	74 14                	je     800460 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80044c:	83 ec 04             	sub    $0x4,%esp
  80044f:	68 b4 1e 80 00       	push   $0x801eb4
  800454:	6a 26                	push   $0x26
  800456:	68 00 1f 80 00       	push   $0x801f00
  80045b:	e8 65 ff ff ff       	call   8003c5 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800460:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800467:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80046e:	e9 c2 00 00 00       	jmp    800535 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800473:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800476:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80047d:	8b 45 08             	mov    0x8(%ebp),%eax
  800480:	01 d0                	add    %edx,%eax
  800482:	8b 00                	mov    (%eax),%eax
  800484:	85 c0                	test   %eax,%eax
  800486:	75 08                	jne    800490 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800488:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80048b:	e9 a2 00 00 00       	jmp    800532 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800490:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800497:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80049e:	eb 69                	jmp    800509 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004a0:	a1 08 30 80 00       	mov    0x803008,%eax
  8004a5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004ab:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004ae:	89 d0                	mov    %edx,%eax
  8004b0:	01 c0                	add    %eax,%eax
  8004b2:	01 d0                	add    %edx,%eax
  8004b4:	c1 e0 02             	shl    $0x2,%eax
  8004b7:	01 c8                	add    %ecx,%eax
  8004b9:	8a 40 04             	mov    0x4(%eax),%al
  8004bc:	84 c0                	test   %al,%al
  8004be:	75 46                	jne    800506 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004c0:	a1 08 30 80 00       	mov    0x803008,%eax
  8004c5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004cb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004ce:	89 d0                	mov    %edx,%eax
  8004d0:	01 c0                	add    %eax,%eax
  8004d2:	01 d0                	add    %edx,%eax
  8004d4:	c1 e0 02             	shl    $0x2,%eax
  8004d7:	01 c8                	add    %ecx,%eax
  8004d9:	8b 00                	mov    (%eax),%eax
  8004db:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004de:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004e1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004e6:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8004e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004eb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f5:	01 c8                	add    %ecx,%eax
  8004f7:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004f9:	39 c2                	cmp    %eax,%edx
  8004fb:	75 09                	jne    800506 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8004fd:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800504:	eb 12                	jmp    800518 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800506:	ff 45 e8             	incl   -0x18(%ebp)
  800509:	a1 08 30 80 00       	mov    0x803008,%eax
  80050e:	8b 50 74             	mov    0x74(%eax),%edx
  800511:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800514:	39 c2                	cmp    %eax,%edx
  800516:	77 88                	ja     8004a0 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800518:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80051c:	75 14                	jne    800532 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80051e:	83 ec 04             	sub    $0x4,%esp
  800521:	68 0c 1f 80 00       	push   $0x801f0c
  800526:	6a 3a                	push   $0x3a
  800528:	68 00 1f 80 00       	push   $0x801f00
  80052d:	e8 93 fe ff ff       	call   8003c5 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800532:	ff 45 f0             	incl   -0x10(%ebp)
  800535:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800538:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80053b:	0f 8c 32 ff ff ff    	jl     800473 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800541:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800548:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80054f:	eb 26                	jmp    800577 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800551:	a1 08 30 80 00       	mov    0x803008,%eax
  800556:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80055c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80055f:	89 d0                	mov    %edx,%eax
  800561:	01 c0                	add    %eax,%eax
  800563:	01 d0                	add    %edx,%eax
  800565:	c1 e0 02             	shl    $0x2,%eax
  800568:	01 c8                	add    %ecx,%eax
  80056a:	8a 40 04             	mov    0x4(%eax),%al
  80056d:	3c 01                	cmp    $0x1,%al
  80056f:	75 03                	jne    800574 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800571:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800574:	ff 45 e0             	incl   -0x20(%ebp)
  800577:	a1 08 30 80 00       	mov    0x803008,%eax
  80057c:	8b 50 74             	mov    0x74(%eax),%edx
  80057f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800582:	39 c2                	cmp    %eax,%edx
  800584:	77 cb                	ja     800551 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800586:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800589:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80058c:	74 14                	je     8005a2 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80058e:	83 ec 04             	sub    $0x4,%esp
  800591:	68 60 1f 80 00       	push   $0x801f60
  800596:	6a 44                	push   $0x44
  800598:	68 00 1f 80 00       	push   $0x801f00
  80059d:	e8 23 fe ff ff       	call   8003c5 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005a2:	90                   	nop
  8005a3:	c9                   	leave  
  8005a4:	c3                   	ret    

008005a5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8005a5:	55                   	push   %ebp
  8005a6:	89 e5                	mov    %esp,%ebp
  8005a8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ae:	8b 00                	mov    (%eax),%eax
  8005b0:	8d 48 01             	lea    0x1(%eax),%ecx
  8005b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005b6:	89 0a                	mov    %ecx,(%edx)
  8005b8:	8b 55 08             	mov    0x8(%ebp),%edx
  8005bb:	88 d1                	mov    %dl,%cl
  8005bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005c0:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005c7:	8b 00                	mov    (%eax),%eax
  8005c9:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005ce:	75 2c                	jne    8005fc <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005d0:	a0 0c 30 80 00       	mov    0x80300c,%al
  8005d5:	0f b6 c0             	movzbl %al,%eax
  8005d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005db:	8b 12                	mov    (%edx),%edx
  8005dd:	89 d1                	mov    %edx,%ecx
  8005df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005e2:	83 c2 08             	add    $0x8,%edx
  8005e5:	83 ec 04             	sub    $0x4,%esp
  8005e8:	50                   	push   %eax
  8005e9:	51                   	push   %ecx
  8005ea:	52                   	push   %edx
  8005eb:	e8 3e 0e 00 00       	call   80142e <sys_cputs>
  8005f0:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005f6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8005fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ff:	8b 40 04             	mov    0x4(%eax),%eax
  800602:	8d 50 01             	lea    0x1(%eax),%edx
  800605:	8b 45 0c             	mov    0xc(%ebp),%eax
  800608:	89 50 04             	mov    %edx,0x4(%eax)
}
  80060b:	90                   	nop
  80060c:	c9                   	leave  
  80060d:	c3                   	ret    

0080060e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80060e:	55                   	push   %ebp
  80060f:	89 e5                	mov    %esp,%ebp
  800611:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800617:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80061e:	00 00 00 
	b.cnt = 0;
  800621:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800628:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80062b:	ff 75 0c             	pushl  0xc(%ebp)
  80062e:	ff 75 08             	pushl  0x8(%ebp)
  800631:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800637:	50                   	push   %eax
  800638:	68 a5 05 80 00       	push   $0x8005a5
  80063d:	e8 11 02 00 00       	call   800853 <vprintfmt>
  800642:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800645:	a0 0c 30 80 00       	mov    0x80300c,%al
  80064a:	0f b6 c0             	movzbl %al,%eax
  80064d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800653:	83 ec 04             	sub    $0x4,%esp
  800656:	50                   	push   %eax
  800657:	52                   	push   %edx
  800658:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80065e:	83 c0 08             	add    $0x8,%eax
  800661:	50                   	push   %eax
  800662:	e8 c7 0d 00 00       	call   80142e <sys_cputs>
  800667:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80066a:	c6 05 0c 30 80 00 00 	movb   $0x0,0x80300c
	return b.cnt;
  800671:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800677:	c9                   	leave  
  800678:	c3                   	ret    

00800679 <cprintf>:

int cprintf(const char *fmt, ...) {
  800679:	55                   	push   %ebp
  80067a:	89 e5                	mov    %esp,%ebp
  80067c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80067f:	c6 05 0c 30 80 00 01 	movb   $0x1,0x80300c
	va_start(ap, fmt);
  800686:	8d 45 0c             	lea    0xc(%ebp),%eax
  800689:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80068c:	8b 45 08             	mov    0x8(%ebp),%eax
  80068f:	83 ec 08             	sub    $0x8,%esp
  800692:	ff 75 f4             	pushl  -0xc(%ebp)
  800695:	50                   	push   %eax
  800696:	e8 73 ff ff ff       	call   80060e <vcprintf>
  80069b:	83 c4 10             	add    $0x10,%esp
  80069e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006a4:	c9                   	leave  
  8006a5:	c3                   	ret    

008006a6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8006a6:	55                   	push   %ebp
  8006a7:	89 e5                	mov    %esp,%ebp
  8006a9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006ac:	e8 8e 0f 00 00       	call   80163f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006b1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ba:	83 ec 08             	sub    $0x8,%esp
  8006bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8006c0:	50                   	push   %eax
  8006c1:	e8 48 ff ff ff       	call   80060e <vcprintf>
  8006c6:	83 c4 10             	add    $0x10,%esp
  8006c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006cc:	e8 88 0f 00 00       	call   801659 <sys_enable_interrupt>
	return cnt;
  8006d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006d4:	c9                   	leave  
  8006d5:	c3                   	ret    

008006d6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006d6:	55                   	push   %ebp
  8006d7:	89 e5                	mov    %esp,%ebp
  8006d9:	53                   	push   %ebx
  8006da:	83 ec 14             	sub    $0x14,%esp
  8006dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8006e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8006e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006e9:	8b 45 18             	mov    0x18(%ebp),%eax
  8006ec:	ba 00 00 00 00       	mov    $0x0,%edx
  8006f1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006f4:	77 55                	ja     80074b <printnum+0x75>
  8006f6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006f9:	72 05                	jb     800700 <printnum+0x2a>
  8006fb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006fe:	77 4b                	ja     80074b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800700:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800703:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800706:	8b 45 18             	mov    0x18(%ebp),%eax
  800709:	ba 00 00 00 00       	mov    $0x0,%edx
  80070e:	52                   	push   %edx
  80070f:	50                   	push   %eax
  800710:	ff 75 f4             	pushl  -0xc(%ebp)
  800713:	ff 75 f0             	pushl  -0x10(%ebp)
  800716:	e8 05 13 00 00       	call   801a20 <__udivdi3>
  80071b:	83 c4 10             	add    $0x10,%esp
  80071e:	83 ec 04             	sub    $0x4,%esp
  800721:	ff 75 20             	pushl  0x20(%ebp)
  800724:	53                   	push   %ebx
  800725:	ff 75 18             	pushl  0x18(%ebp)
  800728:	52                   	push   %edx
  800729:	50                   	push   %eax
  80072a:	ff 75 0c             	pushl  0xc(%ebp)
  80072d:	ff 75 08             	pushl  0x8(%ebp)
  800730:	e8 a1 ff ff ff       	call   8006d6 <printnum>
  800735:	83 c4 20             	add    $0x20,%esp
  800738:	eb 1a                	jmp    800754 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80073a:	83 ec 08             	sub    $0x8,%esp
  80073d:	ff 75 0c             	pushl  0xc(%ebp)
  800740:	ff 75 20             	pushl  0x20(%ebp)
  800743:	8b 45 08             	mov    0x8(%ebp),%eax
  800746:	ff d0                	call   *%eax
  800748:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80074b:	ff 4d 1c             	decl   0x1c(%ebp)
  80074e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800752:	7f e6                	jg     80073a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800754:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800757:	bb 00 00 00 00       	mov    $0x0,%ebx
  80075c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80075f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800762:	53                   	push   %ebx
  800763:	51                   	push   %ecx
  800764:	52                   	push   %edx
  800765:	50                   	push   %eax
  800766:	e8 c5 13 00 00       	call   801b30 <__umoddi3>
  80076b:	83 c4 10             	add    $0x10,%esp
  80076e:	05 d4 21 80 00       	add    $0x8021d4,%eax
  800773:	8a 00                	mov    (%eax),%al
  800775:	0f be c0             	movsbl %al,%eax
  800778:	83 ec 08             	sub    $0x8,%esp
  80077b:	ff 75 0c             	pushl  0xc(%ebp)
  80077e:	50                   	push   %eax
  80077f:	8b 45 08             	mov    0x8(%ebp),%eax
  800782:	ff d0                	call   *%eax
  800784:	83 c4 10             	add    $0x10,%esp
}
  800787:	90                   	nop
  800788:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80078b:	c9                   	leave  
  80078c:	c3                   	ret    

0080078d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80078d:	55                   	push   %ebp
  80078e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800790:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800794:	7e 1c                	jle    8007b2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800796:	8b 45 08             	mov    0x8(%ebp),%eax
  800799:	8b 00                	mov    (%eax),%eax
  80079b:	8d 50 08             	lea    0x8(%eax),%edx
  80079e:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a1:	89 10                	mov    %edx,(%eax)
  8007a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a6:	8b 00                	mov    (%eax),%eax
  8007a8:	83 e8 08             	sub    $0x8,%eax
  8007ab:	8b 50 04             	mov    0x4(%eax),%edx
  8007ae:	8b 00                	mov    (%eax),%eax
  8007b0:	eb 40                	jmp    8007f2 <getuint+0x65>
	else if (lflag)
  8007b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007b6:	74 1e                	je     8007d6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bb:	8b 00                	mov    (%eax),%eax
  8007bd:	8d 50 04             	lea    0x4(%eax),%edx
  8007c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c3:	89 10                	mov    %edx,(%eax)
  8007c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c8:	8b 00                	mov    (%eax),%eax
  8007ca:	83 e8 04             	sub    $0x4,%eax
  8007cd:	8b 00                	mov    (%eax),%eax
  8007cf:	ba 00 00 00 00       	mov    $0x0,%edx
  8007d4:	eb 1c                	jmp    8007f2 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d9:	8b 00                	mov    (%eax),%eax
  8007db:	8d 50 04             	lea    0x4(%eax),%edx
  8007de:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e1:	89 10                	mov    %edx,(%eax)
  8007e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e6:	8b 00                	mov    (%eax),%eax
  8007e8:	83 e8 04             	sub    $0x4,%eax
  8007eb:	8b 00                	mov    (%eax),%eax
  8007ed:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007f2:	5d                   	pop    %ebp
  8007f3:	c3                   	ret    

008007f4 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007f4:	55                   	push   %ebp
  8007f5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007f7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007fb:	7e 1c                	jle    800819 <getint+0x25>
		return va_arg(*ap, long long);
  8007fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800800:	8b 00                	mov    (%eax),%eax
  800802:	8d 50 08             	lea    0x8(%eax),%edx
  800805:	8b 45 08             	mov    0x8(%ebp),%eax
  800808:	89 10                	mov    %edx,(%eax)
  80080a:	8b 45 08             	mov    0x8(%ebp),%eax
  80080d:	8b 00                	mov    (%eax),%eax
  80080f:	83 e8 08             	sub    $0x8,%eax
  800812:	8b 50 04             	mov    0x4(%eax),%edx
  800815:	8b 00                	mov    (%eax),%eax
  800817:	eb 38                	jmp    800851 <getint+0x5d>
	else if (lflag)
  800819:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80081d:	74 1a                	je     800839 <getint+0x45>
		return va_arg(*ap, long);
  80081f:	8b 45 08             	mov    0x8(%ebp),%eax
  800822:	8b 00                	mov    (%eax),%eax
  800824:	8d 50 04             	lea    0x4(%eax),%edx
  800827:	8b 45 08             	mov    0x8(%ebp),%eax
  80082a:	89 10                	mov    %edx,(%eax)
  80082c:	8b 45 08             	mov    0x8(%ebp),%eax
  80082f:	8b 00                	mov    (%eax),%eax
  800831:	83 e8 04             	sub    $0x4,%eax
  800834:	8b 00                	mov    (%eax),%eax
  800836:	99                   	cltd   
  800837:	eb 18                	jmp    800851 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800839:	8b 45 08             	mov    0x8(%ebp),%eax
  80083c:	8b 00                	mov    (%eax),%eax
  80083e:	8d 50 04             	lea    0x4(%eax),%edx
  800841:	8b 45 08             	mov    0x8(%ebp),%eax
  800844:	89 10                	mov    %edx,(%eax)
  800846:	8b 45 08             	mov    0x8(%ebp),%eax
  800849:	8b 00                	mov    (%eax),%eax
  80084b:	83 e8 04             	sub    $0x4,%eax
  80084e:	8b 00                	mov    (%eax),%eax
  800850:	99                   	cltd   
}
  800851:	5d                   	pop    %ebp
  800852:	c3                   	ret    

00800853 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800853:	55                   	push   %ebp
  800854:	89 e5                	mov    %esp,%ebp
  800856:	56                   	push   %esi
  800857:	53                   	push   %ebx
  800858:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80085b:	eb 17                	jmp    800874 <vprintfmt+0x21>
			if (ch == '\0')
  80085d:	85 db                	test   %ebx,%ebx
  80085f:	0f 84 af 03 00 00    	je     800c14 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800865:	83 ec 08             	sub    $0x8,%esp
  800868:	ff 75 0c             	pushl  0xc(%ebp)
  80086b:	53                   	push   %ebx
  80086c:	8b 45 08             	mov    0x8(%ebp),%eax
  80086f:	ff d0                	call   *%eax
  800871:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800874:	8b 45 10             	mov    0x10(%ebp),%eax
  800877:	8d 50 01             	lea    0x1(%eax),%edx
  80087a:	89 55 10             	mov    %edx,0x10(%ebp)
  80087d:	8a 00                	mov    (%eax),%al
  80087f:	0f b6 d8             	movzbl %al,%ebx
  800882:	83 fb 25             	cmp    $0x25,%ebx
  800885:	75 d6                	jne    80085d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800887:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80088b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800892:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800899:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008a0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8008aa:	8d 50 01             	lea    0x1(%eax),%edx
  8008ad:	89 55 10             	mov    %edx,0x10(%ebp)
  8008b0:	8a 00                	mov    (%eax),%al
  8008b2:	0f b6 d8             	movzbl %al,%ebx
  8008b5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008b8:	83 f8 55             	cmp    $0x55,%eax
  8008bb:	0f 87 2b 03 00 00    	ja     800bec <vprintfmt+0x399>
  8008c1:	8b 04 85 f8 21 80 00 	mov    0x8021f8(,%eax,4),%eax
  8008c8:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008ca:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008ce:	eb d7                	jmp    8008a7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008d0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008d4:	eb d1                	jmp    8008a7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008d6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008dd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008e0:	89 d0                	mov    %edx,%eax
  8008e2:	c1 e0 02             	shl    $0x2,%eax
  8008e5:	01 d0                	add    %edx,%eax
  8008e7:	01 c0                	add    %eax,%eax
  8008e9:	01 d8                	add    %ebx,%eax
  8008eb:	83 e8 30             	sub    $0x30,%eax
  8008ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8008f4:	8a 00                	mov    (%eax),%al
  8008f6:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008f9:	83 fb 2f             	cmp    $0x2f,%ebx
  8008fc:	7e 3e                	jle    80093c <vprintfmt+0xe9>
  8008fe:	83 fb 39             	cmp    $0x39,%ebx
  800901:	7f 39                	jg     80093c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800903:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800906:	eb d5                	jmp    8008dd <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800908:	8b 45 14             	mov    0x14(%ebp),%eax
  80090b:	83 c0 04             	add    $0x4,%eax
  80090e:	89 45 14             	mov    %eax,0x14(%ebp)
  800911:	8b 45 14             	mov    0x14(%ebp),%eax
  800914:	83 e8 04             	sub    $0x4,%eax
  800917:	8b 00                	mov    (%eax),%eax
  800919:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80091c:	eb 1f                	jmp    80093d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80091e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800922:	79 83                	jns    8008a7 <vprintfmt+0x54>
				width = 0;
  800924:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80092b:	e9 77 ff ff ff       	jmp    8008a7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800930:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800937:	e9 6b ff ff ff       	jmp    8008a7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80093c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80093d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800941:	0f 89 60 ff ff ff    	jns    8008a7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800947:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80094a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80094d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800954:	e9 4e ff ff ff       	jmp    8008a7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800959:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80095c:	e9 46 ff ff ff       	jmp    8008a7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800961:	8b 45 14             	mov    0x14(%ebp),%eax
  800964:	83 c0 04             	add    $0x4,%eax
  800967:	89 45 14             	mov    %eax,0x14(%ebp)
  80096a:	8b 45 14             	mov    0x14(%ebp),%eax
  80096d:	83 e8 04             	sub    $0x4,%eax
  800970:	8b 00                	mov    (%eax),%eax
  800972:	83 ec 08             	sub    $0x8,%esp
  800975:	ff 75 0c             	pushl  0xc(%ebp)
  800978:	50                   	push   %eax
  800979:	8b 45 08             	mov    0x8(%ebp),%eax
  80097c:	ff d0                	call   *%eax
  80097e:	83 c4 10             	add    $0x10,%esp
			break;
  800981:	e9 89 02 00 00       	jmp    800c0f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800986:	8b 45 14             	mov    0x14(%ebp),%eax
  800989:	83 c0 04             	add    $0x4,%eax
  80098c:	89 45 14             	mov    %eax,0x14(%ebp)
  80098f:	8b 45 14             	mov    0x14(%ebp),%eax
  800992:	83 e8 04             	sub    $0x4,%eax
  800995:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800997:	85 db                	test   %ebx,%ebx
  800999:	79 02                	jns    80099d <vprintfmt+0x14a>
				err = -err;
  80099b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80099d:	83 fb 64             	cmp    $0x64,%ebx
  8009a0:	7f 0b                	jg     8009ad <vprintfmt+0x15a>
  8009a2:	8b 34 9d 40 20 80 00 	mov    0x802040(,%ebx,4),%esi
  8009a9:	85 f6                	test   %esi,%esi
  8009ab:	75 19                	jne    8009c6 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009ad:	53                   	push   %ebx
  8009ae:	68 e5 21 80 00       	push   $0x8021e5
  8009b3:	ff 75 0c             	pushl  0xc(%ebp)
  8009b6:	ff 75 08             	pushl  0x8(%ebp)
  8009b9:	e8 5e 02 00 00       	call   800c1c <printfmt>
  8009be:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009c1:	e9 49 02 00 00       	jmp    800c0f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009c6:	56                   	push   %esi
  8009c7:	68 ee 21 80 00       	push   $0x8021ee
  8009cc:	ff 75 0c             	pushl  0xc(%ebp)
  8009cf:	ff 75 08             	pushl  0x8(%ebp)
  8009d2:	e8 45 02 00 00       	call   800c1c <printfmt>
  8009d7:	83 c4 10             	add    $0x10,%esp
			break;
  8009da:	e9 30 02 00 00       	jmp    800c0f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009df:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e2:	83 c0 04             	add    $0x4,%eax
  8009e5:	89 45 14             	mov    %eax,0x14(%ebp)
  8009e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009eb:	83 e8 04             	sub    $0x4,%eax
  8009ee:	8b 30                	mov    (%eax),%esi
  8009f0:	85 f6                	test   %esi,%esi
  8009f2:	75 05                	jne    8009f9 <vprintfmt+0x1a6>
				p = "(null)";
  8009f4:	be f1 21 80 00       	mov    $0x8021f1,%esi
			if (width > 0 && padc != '-')
  8009f9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009fd:	7e 6d                	jle    800a6c <vprintfmt+0x219>
  8009ff:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a03:	74 67                	je     800a6c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a05:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a08:	83 ec 08             	sub    $0x8,%esp
  800a0b:	50                   	push   %eax
  800a0c:	56                   	push   %esi
  800a0d:	e8 0c 03 00 00       	call   800d1e <strnlen>
  800a12:	83 c4 10             	add    $0x10,%esp
  800a15:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a18:	eb 16                	jmp    800a30 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a1a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a1e:	83 ec 08             	sub    $0x8,%esp
  800a21:	ff 75 0c             	pushl  0xc(%ebp)
  800a24:	50                   	push   %eax
  800a25:	8b 45 08             	mov    0x8(%ebp),%eax
  800a28:	ff d0                	call   *%eax
  800a2a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a2d:	ff 4d e4             	decl   -0x1c(%ebp)
  800a30:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a34:	7f e4                	jg     800a1a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a36:	eb 34                	jmp    800a6c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a38:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a3c:	74 1c                	je     800a5a <vprintfmt+0x207>
  800a3e:	83 fb 1f             	cmp    $0x1f,%ebx
  800a41:	7e 05                	jle    800a48 <vprintfmt+0x1f5>
  800a43:	83 fb 7e             	cmp    $0x7e,%ebx
  800a46:	7e 12                	jle    800a5a <vprintfmt+0x207>
					putch('?', putdat);
  800a48:	83 ec 08             	sub    $0x8,%esp
  800a4b:	ff 75 0c             	pushl  0xc(%ebp)
  800a4e:	6a 3f                	push   $0x3f
  800a50:	8b 45 08             	mov    0x8(%ebp),%eax
  800a53:	ff d0                	call   *%eax
  800a55:	83 c4 10             	add    $0x10,%esp
  800a58:	eb 0f                	jmp    800a69 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a5a:	83 ec 08             	sub    $0x8,%esp
  800a5d:	ff 75 0c             	pushl  0xc(%ebp)
  800a60:	53                   	push   %ebx
  800a61:	8b 45 08             	mov    0x8(%ebp),%eax
  800a64:	ff d0                	call   *%eax
  800a66:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a69:	ff 4d e4             	decl   -0x1c(%ebp)
  800a6c:	89 f0                	mov    %esi,%eax
  800a6e:	8d 70 01             	lea    0x1(%eax),%esi
  800a71:	8a 00                	mov    (%eax),%al
  800a73:	0f be d8             	movsbl %al,%ebx
  800a76:	85 db                	test   %ebx,%ebx
  800a78:	74 24                	je     800a9e <vprintfmt+0x24b>
  800a7a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a7e:	78 b8                	js     800a38 <vprintfmt+0x1e5>
  800a80:	ff 4d e0             	decl   -0x20(%ebp)
  800a83:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a87:	79 af                	jns    800a38 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a89:	eb 13                	jmp    800a9e <vprintfmt+0x24b>
				putch(' ', putdat);
  800a8b:	83 ec 08             	sub    $0x8,%esp
  800a8e:	ff 75 0c             	pushl  0xc(%ebp)
  800a91:	6a 20                	push   $0x20
  800a93:	8b 45 08             	mov    0x8(%ebp),%eax
  800a96:	ff d0                	call   *%eax
  800a98:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a9b:	ff 4d e4             	decl   -0x1c(%ebp)
  800a9e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aa2:	7f e7                	jg     800a8b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800aa4:	e9 66 01 00 00       	jmp    800c0f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800aa9:	83 ec 08             	sub    $0x8,%esp
  800aac:	ff 75 e8             	pushl  -0x18(%ebp)
  800aaf:	8d 45 14             	lea    0x14(%ebp),%eax
  800ab2:	50                   	push   %eax
  800ab3:	e8 3c fd ff ff       	call   8007f4 <getint>
  800ab8:	83 c4 10             	add    $0x10,%esp
  800abb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800abe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ac1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ac4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ac7:	85 d2                	test   %edx,%edx
  800ac9:	79 23                	jns    800aee <vprintfmt+0x29b>
				putch('-', putdat);
  800acb:	83 ec 08             	sub    $0x8,%esp
  800ace:	ff 75 0c             	pushl  0xc(%ebp)
  800ad1:	6a 2d                	push   $0x2d
  800ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad6:	ff d0                	call   *%eax
  800ad8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800adb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ade:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ae1:	f7 d8                	neg    %eax
  800ae3:	83 d2 00             	adc    $0x0,%edx
  800ae6:	f7 da                	neg    %edx
  800ae8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aeb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800aee:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800af5:	e9 bc 00 00 00       	jmp    800bb6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800afa:	83 ec 08             	sub    $0x8,%esp
  800afd:	ff 75 e8             	pushl  -0x18(%ebp)
  800b00:	8d 45 14             	lea    0x14(%ebp),%eax
  800b03:	50                   	push   %eax
  800b04:	e8 84 fc ff ff       	call   80078d <getuint>
  800b09:	83 c4 10             	add    $0x10,%esp
  800b0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b0f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b12:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b19:	e9 98 00 00 00       	jmp    800bb6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b1e:	83 ec 08             	sub    $0x8,%esp
  800b21:	ff 75 0c             	pushl  0xc(%ebp)
  800b24:	6a 58                	push   $0x58
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	ff d0                	call   *%eax
  800b2b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b2e:	83 ec 08             	sub    $0x8,%esp
  800b31:	ff 75 0c             	pushl  0xc(%ebp)
  800b34:	6a 58                	push   $0x58
  800b36:	8b 45 08             	mov    0x8(%ebp),%eax
  800b39:	ff d0                	call   *%eax
  800b3b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b3e:	83 ec 08             	sub    $0x8,%esp
  800b41:	ff 75 0c             	pushl  0xc(%ebp)
  800b44:	6a 58                	push   $0x58
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
  800b49:	ff d0                	call   *%eax
  800b4b:	83 c4 10             	add    $0x10,%esp
			break;
  800b4e:	e9 bc 00 00 00       	jmp    800c0f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b53:	83 ec 08             	sub    $0x8,%esp
  800b56:	ff 75 0c             	pushl  0xc(%ebp)
  800b59:	6a 30                	push   $0x30
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	ff d0                	call   *%eax
  800b60:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b63:	83 ec 08             	sub    $0x8,%esp
  800b66:	ff 75 0c             	pushl  0xc(%ebp)
  800b69:	6a 78                	push   $0x78
  800b6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6e:	ff d0                	call   *%eax
  800b70:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b73:	8b 45 14             	mov    0x14(%ebp),%eax
  800b76:	83 c0 04             	add    $0x4,%eax
  800b79:	89 45 14             	mov    %eax,0x14(%ebp)
  800b7c:	8b 45 14             	mov    0x14(%ebp),%eax
  800b7f:	83 e8 04             	sub    $0x4,%eax
  800b82:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b84:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b8e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b95:	eb 1f                	jmp    800bb6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b97:	83 ec 08             	sub    $0x8,%esp
  800b9a:	ff 75 e8             	pushl  -0x18(%ebp)
  800b9d:	8d 45 14             	lea    0x14(%ebp),%eax
  800ba0:	50                   	push   %eax
  800ba1:	e8 e7 fb ff ff       	call   80078d <getuint>
  800ba6:	83 c4 10             	add    $0x10,%esp
  800ba9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bac:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800baf:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bb6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800bba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bbd:	83 ec 04             	sub    $0x4,%esp
  800bc0:	52                   	push   %edx
  800bc1:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bc4:	50                   	push   %eax
  800bc5:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc8:	ff 75 f0             	pushl  -0x10(%ebp)
  800bcb:	ff 75 0c             	pushl  0xc(%ebp)
  800bce:	ff 75 08             	pushl  0x8(%ebp)
  800bd1:	e8 00 fb ff ff       	call   8006d6 <printnum>
  800bd6:	83 c4 20             	add    $0x20,%esp
			break;
  800bd9:	eb 34                	jmp    800c0f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bdb:	83 ec 08             	sub    $0x8,%esp
  800bde:	ff 75 0c             	pushl  0xc(%ebp)
  800be1:	53                   	push   %ebx
  800be2:	8b 45 08             	mov    0x8(%ebp),%eax
  800be5:	ff d0                	call   *%eax
  800be7:	83 c4 10             	add    $0x10,%esp
			break;
  800bea:	eb 23                	jmp    800c0f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bec:	83 ec 08             	sub    $0x8,%esp
  800bef:	ff 75 0c             	pushl  0xc(%ebp)
  800bf2:	6a 25                	push   $0x25
  800bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf7:	ff d0                	call   *%eax
  800bf9:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800bfc:	ff 4d 10             	decl   0x10(%ebp)
  800bff:	eb 03                	jmp    800c04 <vprintfmt+0x3b1>
  800c01:	ff 4d 10             	decl   0x10(%ebp)
  800c04:	8b 45 10             	mov    0x10(%ebp),%eax
  800c07:	48                   	dec    %eax
  800c08:	8a 00                	mov    (%eax),%al
  800c0a:	3c 25                	cmp    $0x25,%al
  800c0c:	75 f3                	jne    800c01 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c0e:	90                   	nop
		}
	}
  800c0f:	e9 47 fc ff ff       	jmp    80085b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c14:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c15:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c18:	5b                   	pop    %ebx
  800c19:	5e                   	pop    %esi
  800c1a:	5d                   	pop    %ebp
  800c1b:	c3                   	ret    

00800c1c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c1c:	55                   	push   %ebp
  800c1d:	89 e5                	mov    %esp,%ebp
  800c1f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c22:	8d 45 10             	lea    0x10(%ebp),%eax
  800c25:	83 c0 04             	add    $0x4,%eax
  800c28:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2e:	ff 75 f4             	pushl  -0xc(%ebp)
  800c31:	50                   	push   %eax
  800c32:	ff 75 0c             	pushl  0xc(%ebp)
  800c35:	ff 75 08             	pushl  0x8(%ebp)
  800c38:	e8 16 fc ff ff       	call   800853 <vprintfmt>
  800c3d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c40:	90                   	nop
  800c41:	c9                   	leave  
  800c42:	c3                   	ret    

00800c43 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c43:	55                   	push   %ebp
  800c44:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c49:	8b 40 08             	mov    0x8(%eax),%eax
  800c4c:	8d 50 01             	lea    0x1(%eax),%edx
  800c4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c52:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c58:	8b 10                	mov    (%eax),%edx
  800c5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5d:	8b 40 04             	mov    0x4(%eax),%eax
  800c60:	39 c2                	cmp    %eax,%edx
  800c62:	73 12                	jae    800c76 <sprintputch+0x33>
		*b->buf++ = ch;
  800c64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c67:	8b 00                	mov    (%eax),%eax
  800c69:	8d 48 01             	lea    0x1(%eax),%ecx
  800c6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c6f:	89 0a                	mov    %ecx,(%edx)
  800c71:	8b 55 08             	mov    0x8(%ebp),%edx
  800c74:	88 10                	mov    %dl,(%eax)
}
  800c76:	90                   	nop
  800c77:	5d                   	pop    %ebp
  800c78:	c3                   	ret    

00800c79 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c79:	55                   	push   %ebp
  800c7a:	89 e5                	mov    %esp,%ebp
  800c7c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c88:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8e:	01 d0                	add    %edx,%eax
  800c90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c9a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c9e:	74 06                	je     800ca6 <vsnprintf+0x2d>
  800ca0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ca4:	7f 07                	jg     800cad <vsnprintf+0x34>
		return -E_INVAL;
  800ca6:	b8 03 00 00 00       	mov    $0x3,%eax
  800cab:	eb 20                	jmp    800ccd <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800cad:	ff 75 14             	pushl  0x14(%ebp)
  800cb0:	ff 75 10             	pushl  0x10(%ebp)
  800cb3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800cb6:	50                   	push   %eax
  800cb7:	68 43 0c 80 00       	push   $0x800c43
  800cbc:	e8 92 fb ff ff       	call   800853 <vprintfmt>
  800cc1:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cc4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cc7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800cca:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ccd:	c9                   	leave  
  800cce:	c3                   	ret    

00800ccf <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ccf:	55                   	push   %ebp
  800cd0:	89 e5                	mov    %esp,%ebp
  800cd2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800cd5:	8d 45 10             	lea    0x10(%ebp),%eax
  800cd8:	83 c0 04             	add    $0x4,%eax
  800cdb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800cde:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ce4:	50                   	push   %eax
  800ce5:	ff 75 0c             	pushl  0xc(%ebp)
  800ce8:	ff 75 08             	pushl  0x8(%ebp)
  800ceb:	e8 89 ff ff ff       	call   800c79 <vsnprintf>
  800cf0:	83 c4 10             	add    $0x10,%esp
  800cf3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800cf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cf9:	c9                   	leave  
  800cfa:	c3                   	ret    

00800cfb <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800cfb:	55                   	push   %ebp
  800cfc:	89 e5                	mov    %esp,%ebp
  800cfe:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d01:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d08:	eb 06                	jmp    800d10 <strlen+0x15>
		n++;
  800d0a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d0d:	ff 45 08             	incl   0x8(%ebp)
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	84 c0                	test   %al,%al
  800d17:	75 f1                	jne    800d0a <strlen+0xf>
		n++;
	return n;
  800d19:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d1c:	c9                   	leave  
  800d1d:	c3                   	ret    

00800d1e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d1e:	55                   	push   %ebp
  800d1f:	89 e5                	mov    %esp,%ebp
  800d21:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d24:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d2b:	eb 09                	jmp    800d36 <strnlen+0x18>
		n++;
  800d2d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d30:	ff 45 08             	incl   0x8(%ebp)
  800d33:	ff 4d 0c             	decl   0xc(%ebp)
  800d36:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d3a:	74 09                	je     800d45 <strnlen+0x27>
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	8a 00                	mov    (%eax),%al
  800d41:	84 c0                	test   %al,%al
  800d43:	75 e8                	jne    800d2d <strnlen+0xf>
		n++;
	return n;
  800d45:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d48:	c9                   	leave  
  800d49:	c3                   	ret    

00800d4a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d4a:	55                   	push   %ebp
  800d4b:	89 e5                	mov    %esp,%ebp
  800d4d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d56:	90                   	nop
  800d57:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5a:	8d 50 01             	lea    0x1(%eax),%edx
  800d5d:	89 55 08             	mov    %edx,0x8(%ebp)
  800d60:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d63:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d66:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d69:	8a 12                	mov    (%edx),%dl
  800d6b:	88 10                	mov    %dl,(%eax)
  800d6d:	8a 00                	mov    (%eax),%al
  800d6f:	84 c0                	test   %al,%al
  800d71:	75 e4                	jne    800d57 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d73:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d76:	c9                   	leave  
  800d77:	c3                   	ret    

00800d78 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d78:	55                   	push   %ebp
  800d79:	89 e5                	mov    %esp,%ebp
  800d7b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d84:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d8b:	eb 1f                	jmp    800dac <strncpy+0x34>
		*dst++ = *src;
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	8d 50 01             	lea    0x1(%eax),%edx
  800d93:	89 55 08             	mov    %edx,0x8(%ebp)
  800d96:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d99:	8a 12                	mov    (%edx),%dl
  800d9b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da0:	8a 00                	mov    (%eax),%al
  800da2:	84 c0                	test   %al,%al
  800da4:	74 03                	je     800da9 <strncpy+0x31>
			src++;
  800da6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800da9:	ff 45 fc             	incl   -0x4(%ebp)
  800dac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800daf:	3b 45 10             	cmp    0x10(%ebp),%eax
  800db2:	72 d9                	jb     800d8d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800db4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800db7:	c9                   	leave  
  800db8:	c3                   	ret    

00800db9 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800db9:	55                   	push   %ebp
  800dba:	89 e5                	mov    %esp,%ebp
  800dbc:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dc5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dc9:	74 30                	je     800dfb <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800dcb:	eb 16                	jmp    800de3 <strlcpy+0x2a>
			*dst++ = *src++;
  800dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd0:	8d 50 01             	lea    0x1(%eax),%edx
  800dd3:	89 55 08             	mov    %edx,0x8(%ebp)
  800dd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dd9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ddc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ddf:	8a 12                	mov    (%edx),%dl
  800de1:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800de3:	ff 4d 10             	decl   0x10(%ebp)
  800de6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dea:	74 09                	je     800df5 <strlcpy+0x3c>
  800dec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800def:	8a 00                	mov    (%eax),%al
  800df1:	84 c0                	test   %al,%al
  800df3:	75 d8                	jne    800dcd <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800df5:	8b 45 08             	mov    0x8(%ebp),%eax
  800df8:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800dfb:	8b 55 08             	mov    0x8(%ebp),%edx
  800dfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e01:	29 c2                	sub    %eax,%edx
  800e03:	89 d0                	mov    %edx,%eax
}
  800e05:	c9                   	leave  
  800e06:	c3                   	ret    

00800e07 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e07:	55                   	push   %ebp
  800e08:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e0a:	eb 06                	jmp    800e12 <strcmp+0xb>
		p++, q++;
  800e0c:	ff 45 08             	incl   0x8(%ebp)
  800e0f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	8a 00                	mov    (%eax),%al
  800e17:	84 c0                	test   %al,%al
  800e19:	74 0e                	je     800e29 <strcmp+0x22>
  800e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1e:	8a 10                	mov    (%eax),%dl
  800e20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e23:	8a 00                	mov    (%eax),%al
  800e25:	38 c2                	cmp    %al,%dl
  800e27:	74 e3                	je     800e0c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e29:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2c:	8a 00                	mov    (%eax),%al
  800e2e:	0f b6 d0             	movzbl %al,%edx
  800e31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e34:	8a 00                	mov    (%eax),%al
  800e36:	0f b6 c0             	movzbl %al,%eax
  800e39:	29 c2                	sub    %eax,%edx
  800e3b:	89 d0                	mov    %edx,%eax
}
  800e3d:	5d                   	pop    %ebp
  800e3e:	c3                   	ret    

00800e3f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e3f:	55                   	push   %ebp
  800e40:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e42:	eb 09                	jmp    800e4d <strncmp+0xe>
		n--, p++, q++;
  800e44:	ff 4d 10             	decl   0x10(%ebp)
  800e47:	ff 45 08             	incl   0x8(%ebp)
  800e4a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e4d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e51:	74 17                	je     800e6a <strncmp+0x2b>
  800e53:	8b 45 08             	mov    0x8(%ebp),%eax
  800e56:	8a 00                	mov    (%eax),%al
  800e58:	84 c0                	test   %al,%al
  800e5a:	74 0e                	je     800e6a <strncmp+0x2b>
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	8a 10                	mov    (%eax),%dl
  800e61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e64:	8a 00                	mov    (%eax),%al
  800e66:	38 c2                	cmp    %al,%dl
  800e68:	74 da                	je     800e44 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e6a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e6e:	75 07                	jne    800e77 <strncmp+0x38>
		return 0;
  800e70:	b8 00 00 00 00       	mov    $0x0,%eax
  800e75:	eb 14                	jmp    800e8b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e77:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7a:	8a 00                	mov    (%eax),%al
  800e7c:	0f b6 d0             	movzbl %al,%edx
  800e7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e82:	8a 00                	mov    (%eax),%al
  800e84:	0f b6 c0             	movzbl %al,%eax
  800e87:	29 c2                	sub    %eax,%edx
  800e89:	89 d0                	mov    %edx,%eax
}
  800e8b:	5d                   	pop    %ebp
  800e8c:	c3                   	ret    

00800e8d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e8d:	55                   	push   %ebp
  800e8e:	89 e5                	mov    %esp,%ebp
  800e90:	83 ec 04             	sub    $0x4,%esp
  800e93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e96:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e99:	eb 12                	jmp    800ead <strchr+0x20>
		if (*s == c)
  800e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9e:	8a 00                	mov    (%eax),%al
  800ea0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ea3:	75 05                	jne    800eaa <strchr+0x1d>
			return (char *) s;
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea8:	eb 11                	jmp    800ebb <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800eaa:	ff 45 08             	incl   0x8(%ebp)
  800ead:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb0:	8a 00                	mov    (%eax),%al
  800eb2:	84 c0                	test   %al,%al
  800eb4:	75 e5                	jne    800e9b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800eb6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ebb:	c9                   	leave  
  800ebc:	c3                   	ret    

00800ebd <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ebd:	55                   	push   %ebp
  800ebe:	89 e5                	mov    %esp,%ebp
  800ec0:	83 ec 04             	sub    $0x4,%esp
  800ec3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ec9:	eb 0d                	jmp    800ed8 <strfind+0x1b>
		if (*s == c)
  800ecb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ece:	8a 00                	mov    (%eax),%al
  800ed0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ed3:	74 0e                	je     800ee3 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ed5:	ff 45 08             	incl   0x8(%ebp)
  800ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  800edb:	8a 00                	mov    (%eax),%al
  800edd:	84 c0                	test   %al,%al
  800edf:	75 ea                	jne    800ecb <strfind+0xe>
  800ee1:	eb 01                	jmp    800ee4 <strfind+0x27>
		if (*s == c)
			break;
  800ee3:	90                   	nop
	return (char *) s;
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee7:	c9                   	leave  
  800ee8:	c3                   	ret    

00800ee9 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ee9:	55                   	push   %ebp
  800eea:	89 e5                	mov    %esp,%ebp
  800eec:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800eef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ef5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800efb:	eb 0e                	jmp    800f0b <memset+0x22>
		*p++ = c;
  800efd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f00:	8d 50 01             	lea    0x1(%eax),%edx
  800f03:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f06:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f09:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f0b:	ff 4d f8             	decl   -0x8(%ebp)
  800f0e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f12:	79 e9                	jns    800efd <memset+0x14>
		*p++ = c;

	return v;
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f17:	c9                   	leave  
  800f18:	c3                   	ret    

00800f19 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f19:	55                   	push   %ebp
  800f1a:	89 e5                	mov    %esp,%ebp
  800f1c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f22:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
  800f28:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f2b:	eb 16                	jmp    800f43 <memcpy+0x2a>
		*d++ = *s++;
  800f2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f30:	8d 50 01             	lea    0x1(%eax),%edx
  800f33:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f36:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f39:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f3c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f3f:	8a 12                	mov    (%edx),%dl
  800f41:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f43:	8b 45 10             	mov    0x10(%ebp),%eax
  800f46:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f49:	89 55 10             	mov    %edx,0x10(%ebp)
  800f4c:	85 c0                	test   %eax,%eax
  800f4e:	75 dd                	jne    800f2d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f53:	c9                   	leave  
  800f54:	c3                   	ret    

00800f55 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f55:	55                   	push   %ebp
  800f56:	89 e5                	mov    %esp,%ebp
  800f58:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800f5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f67:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f6a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f6d:	73 50                	jae    800fbf <memmove+0x6a>
  800f6f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f72:	8b 45 10             	mov    0x10(%ebp),%eax
  800f75:	01 d0                	add    %edx,%eax
  800f77:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f7a:	76 43                	jbe    800fbf <memmove+0x6a>
		s += n;
  800f7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f82:	8b 45 10             	mov    0x10(%ebp),%eax
  800f85:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f88:	eb 10                	jmp    800f9a <memmove+0x45>
			*--d = *--s;
  800f8a:	ff 4d f8             	decl   -0x8(%ebp)
  800f8d:	ff 4d fc             	decl   -0x4(%ebp)
  800f90:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f93:	8a 10                	mov    (%eax),%dl
  800f95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f98:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fa0:	89 55 10             	mov    %edx,0x10(%ebp)
  800fa3:	85 c0                	test   %eax,%eax
  800fa5:	75 e3                	jne    800f8a <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fa7:	eb 23                	jmp    800fcc <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fa9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fac:	8d 50 01             	lea    0x1(%eax),%edx
  800faf:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fb2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fb5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fb8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fbb:	8a 12                	mov    (%edx),%dl
  800fbd:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fbf:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fc5:	89 55 10             	mov    %edx,0x10(%ebp)
  800fc8:	85 c0                	test   %eax,%eax
  800fca:	75 dd                	jne    800fa9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fcf:	c9                   	leave  
  800fd0:	c3                   	ret    

00800fd1 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fd1:	55                   	push   %ebp
  800fd2:	89 e5                	mov    %esp,%ebp
  800fd4:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800fdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe0:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800fe3:	eb 2a                	jmp    80100f <memcmp+0x3e>
		if (*s1 != *s2)
  800fe5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe8:	8a 10                	mov    (%eax),%dl
  800fea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fed:	8a 00                	mov    (%eax),%al
  800fef:	38 c2                	cmp    %al,%dl
  800ff1:	74 16                	je     801009 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ff3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ff6:	8a 00                	mov    (%eax),%al
  800ff8:	0f b6 d0             	movzbl %al,%edx
  800ffb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ffe:	8a 00                	mov    (%eax),%al
  801000:	0f b6 c0             	movzbl %al,%eax
  801003:	29 c2                	sub    %eax,%edx
  801005:	89 d0                	mov    %edx,%eax
  801007:	eb 18                	jmp    801021 <memcmp+0x50>
		s1++, s2++;
  801009:	ff 45 fc             	incl   -0x4(%ebp)
  80100c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80100f:	8b 45 10             	mov    0x10(%ebp),%eax
  801012:	8d 50 ff             	lea    -0x1(%eax),%edx
  801015:	89 55 10             	mov    %edx,0x10(%ebp)
  801018:	85 c0                	test   %eax,%eax
  80101a:	75 c9                	jne    800fe5 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80101c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801021:	c9                   	leave  
  801022:	c3                   	ret    

00801023 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801023:	55                   	push   %ebp
  801024:	89 e5                	mov    %esp,%ebp
  801026:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801029:	8b 55 08             	mov    0x8(%ebp),%edx
  80102c:	8b 45 10             	mov    0x10(%ebp),%eax
  80102f:	01 d0                	add    %edx,%eax
  801031:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801034:	eb 15                	jmp    80104b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801036:	8b 45 08             	mov    0x8(%ebp),%eax
  801039:	8a 00                	mov    (%eax),%al
  80103b:	0f b6 d0             	movzbl %al,%edx
  80103e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801041:	0f b6 c0             	movzbl %al,%eax
  801044:	39 c2                	cmp    %eax,%edx
  801046:	74 0d                	je     801055 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801048:	ff 45 08             	incl   0x8(%ebp)
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
  80104e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801051:	72 e3                	jb     801036 <memfind+0x13>
  801053:	eb 01                	jmp    801056 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801055:	90                   	nop
	return (void *) s;
  801056:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801059:	c9                   	leave  
  80105a:	c3                   	ret    

0080105b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80105b:	55                   	push   %ebp
  80105c:	89 e5                	mov    %esp,%ebp
  80105e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801061:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801068:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80106f:	eb 03                	jmp    801074 <strtol+0x19>
		s++;
  801071:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801074:	8b 45 08             	mov    0x8(%ebp),%eax
  801077:	8a 00                	mov    (%eax),%al
  801079:	3c 20                	cmp    $0x20,%al
  80107b:	74 f4                	je     801071 <strtol+0x16>
  80107d:	8b 45 08             	mov    0x8(%ebp),%eax
  801080:	8a 00                	mov    (%eax),%al
  801082:	3c 09                	cmp    $0x9,%al
  801084:	74 eb                	je     801071 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	8a 00                	mov    (%eax),%al
  80108b:	3c 2b                	cmp    $0x2b,%al
  80108d:	75 05                	jne    801094 <strtol+0x39>
		s++;
  80108f:	ff 45 08             	incl   0x8(%ebp)
  801092:	eb 13                	jmp    8010a7 <strtol+0x4c>
	else if (*s == '-')
  801094:	8b 45 08             	mov    0x8(%ebp),%eax
  801097:	8a 00                	mov    (%eax),%al
  801099:	3c 2d                	cmp    $0x2d,%al
  80109b:	75 0a                	jne    8010a7 <strtol+0x4c>
		s++, neg = 1;
  80109d:	ff 45 08             	incl   0x8(%ebp)
  8010a0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ab:	74 06                	je     8010b3 <strtol+0x58>
  8010ad:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010b1:	75 20                	jne    8010d3 <strtol+0x78>
  8010b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b6:	8a 00                	mov    (%eax),%al
  8010b8:	3c 30                	cmp    $0x30,%al
  8010ba:	75 17                	jne    8010d3 <strtol+0x78>
  8010bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bf:	40                   	inc    %eax
  8010c0:	8a 00                	mov    (%eax),%al
  8010c2:	3c 78                	cmp    $0x78,%al
  8010c4:	75 0d                	jne    8010d3 <strtol+0x78>
		s += 2, base = 16;
  8010c6:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010ca:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010d1:	eb 28                	jmp    8010fb <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010d3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010d7:	75 15                	jne    8010ee <strtol+0x93>
  8010d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010dc:	8a 00                	mov    (%eax),%al
  8010de:	3c 30                	cmp    $0x30,%al
  8010e0:	75 0c                	jne    8010ee <strtol+0x93>
		s++, base = 8;
  8010e2:	ff 45 08             	incl   0x8(%ebp)
  8010e5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010ec:	eb 0d                	jmp    8010fb <strtol+0xa0>
	else if (base == 0)
  8010ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010f2:	75 07                	jne    8010fb <strtol+0xa0>
		base = 10;
  8010f4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	8a 00                	mov    (%eax),%al
  801100:	3c 2f                	cmp    $0x2f,%al
  801102:	7e 19                	jle    80111d <strtol+0xc2>
  801104:	8b 45 08             	mov    0x8(%ebp),%eax
  801107:	8a 00                	mov    (%eax),%al
  801109:	3c 39                	cmp    $0x39,%al
  80110b:	7f 10                	jg     80111d <strtol+0xc2>
			dig = *s - '0';
  80110d:	8b 45 08             	mov    0x8(%ebp),%eax
  801110:	8a 00                	mov    (%eax),%al
  801112:	0f be c0             	movsbl %al,%eax
  801115:	83 e8 30             	sub    $0x30,%eax
  801118:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80111b:	eb 42                	jmp    80115f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80111d:	8b 45 08             	mov    0x8(%ebp),%eax
  801120:	8a 00                	mov    (%eax),%al
  801122:	3c 60                	cmp    $0x60,%al
  801124:	7e 19                	jle    80113f <strtol+0xe4>
  801126:	8b 45 08             	mov    0x8(%ebp),%eax
  801129:	8a 00                	mov    (%eax),%al
  80112b:	3c 7a                	cmp    $0x7a,%al
  80112d:	7f 10                	jg     80113f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80112f:	8b 45 08             	mov    0x8(%ebp),%eax
  801132:	8a 00                	mov    (%eax),%al
  801134:	0f be c0             	movsbl %al,%eax
  801137:	83 e8 57             	sub    $0x57,%eax
  80113a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80113d:	eb 20                	jmp    80115f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80113f:	8b 45 08             	mov    0x8(%ebp),%eax
  801142:	8a 00                	mov    (%eax),%al
  801144:	3c 40                	cmp    $0x40,%al
  801146:	7e 39                	jle    801181 <strtol+0x126>
  801148:	8b 45 08             	mov    0x8(%ebp),%eax
  80114b:	8a 00                	mov    (%eax),%al
  80114d:	3c 5a                	cmp    $0x5a,%al
  80114f:	7f 30                	jg     801181 <strtol+0x126>
			dig = *s - 'A' + 10;
  801151:	8b 45 08             	mov    0x8(%ebp),%eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	0f be c0             	movsbl %al,%eax
  801159:	83 e8 37             	sub    $0x37,%eax
  80115c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80115f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801162:	3b 45 10             	cmp    0x10(%ebp),%eax
  801165:	7d 19                	jge    801180 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801167:	ff 45 08             	incl   0x8(%ebp)
  80116a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80116d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801171:	89 c2                	mov    %eax,%edx
  801173:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801176:	01 d0                	add    %edx,%eax
  801178:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80117b:	e9 7b ff ff ff       	jmp    8010fb <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801180:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801181:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801185:	74 08                	je     80118f <strtol+0x134>
		*endptr = (char *) s;
  801187:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118a:	8b 55 08             	mov    0x8(%ebp),%edx
  80118d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80118f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801193:	74 07                	je     80119c <strtol+0x141>
  801195:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801198:	f7 d8                	neg    %eax
  80119a:	eb 03                	jmp    80119f <strtol+0x144>
  80119c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80119f:	c9                   	leave  
  8011a0:	c3                   	ret    

008011a1 <ltostr>:

void
ltostr(long value, char *str)
{
  8011a1:	55                   	push   %ebp
  8011a2:	89 e5                	mov    %esp,%ebp
  8011a4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011ae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011b5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011b9:	79 13                	jns    8011ce <ltostr+0x2d>
	{
		neg = 1;
  8011bb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c5:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011c8:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011cb:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d1:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011d6:	99                   	cltd   
  8011d7:	f7 f9                	idiv   %ecx
  8011d9:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011df:	8d 50 01             	lea    0x1(%eax),%edx
  8011e2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011e5:	89 c2                	mov    %eax,%edx
  8011e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ea:	01 d0                	add    %edx,%eax
  8011ec:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011ef:	83 c2 30             	add    $0x30,%edx
  8011f2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8011f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011f7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011fc:	f7 e9                	imul   %ecx
  8011fe:	c1 fa 02             	sar    $0x2,%edx
  801201:	89 c8                	mov    %ecx,%eax
  801203:	c1 f8 1f             	sar    $0x1f,%eax
  801206:	29 c2                	sub    %eax,%edx
  801208:	89 d0                	mov    %edx,%eax
  80120a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80120d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801210:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801215:	f7 e9                	imul   %ecx
  801217:	c1 fa 02             	sar    $0x2,%edx
  80121a:	89 c8                	mov    %ecx,%eax
  80121c:	c1 f8 1f             	sar    $0x1f,%eax
  80121f:	29 c2                	sub    %eax,%edx
  801221:	89 d0                	mov    %edx,%eax
  801223:	c1 e0 02             	shl    $0x2,%eax
  801226:	01 d0                	add    %edx,%eax
  801228:	01 c0                	add    %eax,%eax
  80122a:	29 c1                	sub    %eax,%ecx
  80122c:	89 ca                	mov    %ecx,%edx
  80122e:	85 d2                	test   %edx,%edx
  801230:	75 9c                	jne    8011ce <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801232:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801239:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80123c:	48                   	dec    %eax
  80123d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801240:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801244:	74 3d                	je     801283 <ltostr+0xe2>
		start = 1 ;
  801246:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80124d:	eb 34                	jmp    801283 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80124f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801252:	8b 45 0c             	mov    0xc(%ebp),%eax
  801255:	01 d0                	add    %edx,%eax
  801257:	8a 00                	mov    (%eax),%al
  801259:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80125c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80125f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801262:	01 c2                	add    %eax,%edx
  801264:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801267:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126a:	01 c8                	add    %ecx,%eax
  80126c:	8a 00                	mov    (%eax),%al
  80126e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801270:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801273:	8b 45 0c             	mov    0xc(%ebp),%eax
  801276:	01 c2                	add    %eax,%edx
  801278:	8a 45 eb             	mov    -0x15(%ebp),%al
  80127b:	88 02                	mov    %al,(%edx)
		start++ ;
  80127d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801280:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801283:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801286:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801289:	7c c4                	jl     80124f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80128b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80128e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801291:	01 d0                	add    %edx,%eax
  801293:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801296:	90                   	nop
  801297:	c9                   	leave  
  801298:	c3                   	ret    

00801299 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801299:	55                   	push   %ebp
  80129a:	89 e5                	mov    %esp,%ebp
  80129c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80129f:	ff 75 08             	pushl  0x8(%ebp)
  8012a2:	e8 54 fa ff ff       	call   800cfb <strlen>
  8012a7:	83 c4 04             	add    $0x4,%esp
  8012aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012ad:	ff 75 0c             	pushl  0xc(%ebp)
  8012b0:	e8 46 fa ff ff       	call   800cfb <strlen>
  8012b5:	83 c4 04             	add    $0x4,%esp
  8012b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012c9:	eb 17                	jmp    8012e2 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d1:	01 c2                	add    %eax,%edx
  8012d3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d9:	01 c8                	add    %ecx,%eax
  8012db:	8a 00                	mov    (%eax),%al
  8012dd:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012df:	ff 45 fc             	incl   -0x4(%ebp)
  8012e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012e8:	7c e1                	jl     8012cb <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012ea:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012f1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012f8:	eb 1f                	jmp    801319 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012fd:	8d 50 01             	lea    0x1(%eax),%edx
  801300:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801303:	89 c2                	mov    %eax,%edx
  801305:	8b 45 10             	mov    0x10(%ebp),%eax
  801308:	01 c2                	add    %eax,%edx
  80130a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80130d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801310:	01 c8                	add    %ecx,%eax
  801312:	8a 00                	mov    (%eax),%al
  801314:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801316:	ff 45 f8             	incl   -0x8(%ebp)
  801319:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80131c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80131f:	7c d9                	jl     8012fa <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801321:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801324:	8b 45 10             	mov    0x10(%ebp),%eax
  801327:	01 d0                	add    %edx,%eax
  801329:	c6 00 00             	movb   $0x0,(%eax)
}
  80132c:	90                   	nop
  80132d:	c9                   	leave  
  80132e:	c3                   	ret    

0080132f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80132f:	55                   	push   %ebp
  801330:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801332:	8b 45 14             	mov    0x14(%ebp),%eax
  801335:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80133b:	8b 45 14             	mov    0x14(%ebp),%eax
  80133e:	8b 00                	mov    (%eax),%eax
  801340:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801347:	8b 45 10             	mov    0x10(%ebp),%eax
  80134a:	01 d0                	add    %edx,%eax
  80134c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801352:	eb 0c                	jmp    801360 <strsplit+0x31>
			*string++ = 0;
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
  801357:	8d 50 01             	lea    0x1(%eax),%edx
  80135a:	89 55 08             	mov    %edx,0x8(%ebp)
  80135d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801360:	8b 45 08             	mov    0x8(%ebp),%eax
  801363:	8a 00                	mov    (%eax),%al
  801365:	84 c0                	test   %al,%al
  801367:	74 18                	je     801381 <strsplit+0x52>
  801369:	8b 45 08             	mov    0x8(%ebp),%eax
  80136c:	8a 00                	mov    (%eax),%al
  80136e:	0f be c0             	movsbl %al,%eax
  801371:	50                   	push   %eax
  801372:	ff 75 0c             	pushl  0xc(%ebp)
  801375:	e8 13 fb ff ff       	call   800e8d <strchr>
  80137a:	83 c4 08             	add    $0x8,%esp
  80137d:	85 c0                	test   %eax,%eax
  80137f:	75 d3                	jne    801354 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	8a 00                	mov    (%eax),%al
  801386:	84 c0                	test   %al,%al
  801388:	74 5a                	je     8013e4 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80138a:	8b 45 14             	mov    0x14(%ebp),%eax
  80138d:	8b 00                	mov    (%eax),%eax
  80138f:	83 f8 0f             	cmp    $0xf,%eax
  801392:	75 07                	jne    80139b <strsplit+0x6c>
		{
			return 0;
  801394:	b8 00 00 00 00       	mov    $0x0,%eax
  801399:	eb 66                	jmp    801401 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80139b:	8b 45 14             	mov    0x14(%ebp),%eax
  80139e:	8b 00                	mov    (%eax),%eax
  8013a0:	8d 48 01             	lea    0x1(%eax),%ecx
  8013a3:	8b 55 14             	mov    0x14(%ebp),%edx
  8013a6:	89 0a                	mov    %ecx,(%edx)
  8013a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013af:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b2:	01 c2                	add    %eax,%edx
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013b9:	eb 03                	jmp    8013be <strsplit+0x8f>
			string++;
  8013bb:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	8a 00                	mov    (%eax),%al
  8013c3:	84 c0                	test   %al,%al
  8013c5:	74 8b                	je     801352 <strsplit+0x23>
  8013c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ca:	8a 00                	mov    (%eax),%al
  8013cc:	0f be c0             	movsbl %al,%eax
  8013cf:	50                   	push   %eax
  8013d0:	ff 75 0c             	pushl  0xc(%ebp)
  8013d3:	e8 b5 fa ff ff       	call   800e8d <strchr>
  8013d8:	83 c4 08             	add    $0x8,%esp
  8013db:	85 c0                	test   %eax,%eax
  8013dd:	74 dc                	je     8013bb <strsplit+0x8c>
			string++;
	}
  8013df:	e9 6e ff ff ff       	jmp    801352 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013e4:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8013e8:	8b 00                	mov    (%eax),%eax
  8013ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f4:	01 d0                	add    %edx,%eax
  8013f6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013fc:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801401:	c9                   	leave  
  801402:	c3                   	ret    

00801403 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801403:	55                   	push   %ebp
  801404:	89 e5                	mov    %esp,%ebp
  801406:	57                   	push   %edi
  801407:	56                   	push   %esi
  801408:	53                   	push   %ebx
  801409:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801412:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801415:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801418:	8b 7d 18             	mov    0x18(%ebp),%edi
  80141b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80141e:	cd 30                	int    $0x30
  801420:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801423:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801426:	83 c4 10             	add    $0x10,%esp
  801429:	5b                   	pop    %ebx
  80142a:	5e                   	pop    %esi
  80142b:	5f                   	pop    %edi
  80142c:	5d                   	pop    %ebp
  80142d:	c3                   	ret    

0080142e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80142e:	55                   	push   %ebp
  80142f:	89 e5                	mov    %esp,%ebp
  801431:	83 ec 04             	sub    $0x4,%esp
  801434:	8b 45 10             	mov    0x10(%ebp),%eax
  801437:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80143a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	52                   	push   %edx
  801446:	ff 75 0c             	pushl  0xc(%ebp)
  801449:	50                   	push   %eax
  80144a:	6a 00                	push   $0x0
  80144c:	e8 b2 ff ff ff       	call   801403 <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
}
  801454:	90                   	nop
  801455:	c9                   	leave  
  801456:	c3                   	ret    

00801457 <sys_cgetc>:

int
sys_cgetc(void)
{
  801457:	55                   	push   %ebp
  801458:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 01                	push   $0x1
  801466:	e8 98 ff ff ff       	call   801403 <syscall>
  80146b:	83 c4 18             	add    $0x18,%esp
}
  80146e:	c9                   	leave  
  80146f:	c3                   	ret    

00801470 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801470:	55                   	push   %ebp
  801471:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801473:	8b 45 08             	mov    0x8(%ebp),%eax
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	50                   	push   %eax
  80147f:	6a 05                	push   $0x5
  801481:	e8 7d ff ff ff       	call   801403 <syscall>
  801486:	83 c4 18             	add    $0x18,%esp
}
  801489:	c9                   	leave  
  80148a:	c3                   	ret    

0080148b <sys_getenvid>:

int32 sys_getenvid(void)
{
  80148b:	55                   	push   %ebp
  80148c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80148e:	6a 00                	push   $0x0
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 02                	push   $0x2
  80149a:	e8 64 ff ff ff       	call   801403 <syscall>
  80149f:	83 c4 18             	add    $0x18,%esp
}
  8014a2:	c9                   	leave  
  8014a3:	c3                   	ret    

008014a4 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 03                	push   $0x3
  8014b3:	e8 4b ff ff ff       	call   801403 <syscall>
  8014b8:	83 c4 18             	add    $0x18,%esp
}
  8014bb:	c9                   	leave  
  8014bc:	c3                   	ret    

008014bd <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8014bd:	55                   	push   %ebp
  8014be:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 04                	push   $0x4
  8014cc:	e8 32 ff ff ff       	call   801403 <syscall>
  8014d1:	83 c4 18             	add    $0x18,%esp
}
  8014d4:	c9                   	leave  
  8014d5:	c3                   	ret    

008014d6 <sys_env_exit>:


void sys_env_exit(void)
{
  8014d6:	55                   	push   %ebp
  8014d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 06                	push   $0x6
  8014e5:	e8 19 ff ff ff       	call   801403 <syscall>
  8014ea:	83 c4 18             	add    $0x18,%esp
}
  8014ed:	90                   	nop
  8014ee:	c9                   	leave  
  8014ef:	c3                   	ret    

008014f0 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8014f0:	55                   	push   %ebp
  8014f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8014f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	52                   	push   %edx
  801500:	50                   	push   %eax
  801501:	6a 07                	push   $0x7
  801503:	e8 fb fe ff ff       	call   801403 <syscall>
  801508:	83 c4 18             	add    $0x18,%esp
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
  801510:	56                   	push   %esi
  801511:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801512:	8b 75 18             	mov    0x18(%ebp),%esi
  801515:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801518:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80151b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80151e:	8b 45 08             	mov    0x8(%ebp),%eax
  801521:	56                   	push   %esi
  801522:	53                   	push   %ebx
  801523:	51                   	push   %ecx
  801524:	52                   	push   %edx
  801525:	50                   	push   %eax
  801526:	6a 08                	push   $0x8
  801528:	e8 d6 fe ff ff       	call   801403 <syscall>
  80152d:	83 c4 18             	add    $0x18,%esp
}
  801530:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801533:	5b                   	pop    %ebx
  801534:	5e                   	pop    %esi
  801535:	5d                   	pop    %ebp
  801536:	c3                   	ret    

00801537 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801537:	55                   	push   %ebp
  801538:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80153a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153d:	8b 45 08             	mov    0x8(%ebp),%eax
  801540:	6a 00                	push   $0x0
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	52                   	push   %edx
  801547:	50                   	push   %eax
  801548:	6a 09                	push   $0x9
  80154a:	e8 b4 fe ff ff       	call   801403 <syscall>
  80154f:	83 c4 18             	add    $0x18,%esp
}
  801552:	c9                   	leave  
  801553:	c3                   	ret    

00801554 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801554:	55                   	push   %ebp
  801555:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	6a 00                	push   $0x0
  80155d:	ff 75 0c             	pushl  0xc(%ebp)
  801560:	ff 75 08             	pushl  0x8(%ebp)
  801563:	6a 0a                	push   $0xa
  801565:	e8 99 fe ff ff       	call   801403 <syscall>
  80156a:	83 c4 18             	add    $0x18,%esp
}
  80156d:	c9                   	leave  
  80156e:	c3                   	ret    

0080156f <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80156f:	55                   	push   %ebp
  801570:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 0b                	push   $0xb
  80157e:	e8 80 fe ff ff       	call   801403 <syscall>
  801583:	83 c4 18             	add    $0x18,%esp
}
  801586:	c9                   	leave  
  801587:	c3                   	ret    

00801588 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801588:	55                   	push   %ebp
  801589:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	6a 00                	push   $0x0
  801593:	6a 00                	push   $0x0
  801595:	6a 0c                	push   $0xc
  801597:	e8 67 fe ff ff       	call   801403 <syscall>
  80159c:	83 c4 18             	add    $0x18,%esp
}
  80159f:	c9                   	leave  
  8015a0:	c3                   	ret    

008015a1 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015a1:	55                   	push   %ebp
  8015a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 0d                	push   $0xd
  8015b0:	e8 4e fe ff ff       	call   801403 <syscall>
  8015b5:	83 c4 18             	add    $0x18,%esp
}
  8015b8:	c9                   	leave  
  8015b9:	c3                   	ret    

008015ba <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015ba:	55                   	push   %ebp
  8015bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	ff 75 0c             	pushl  0xc(%ebp)
  8015c6:	ff 75 08             	pushl  0x8(%ebp)
  8015c9:	6a 11                	push   $0x11
  8015cb:	e8 33 fe ff ff       	call   801403 <syscall>
  8015d0:	83 c4 18             	add    $0x18,%esp
	return;
  8015d3:	90                   	nop
}
  8015d4:	c9                   	leave  
  8015d5:	c3                   	ret    

008015d6 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8015d6:	55                   	push   %ebp
  8015d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	ff 75 0c             	pushl  0xc(%ebp)
  8015e2:	ff 75 08             	pushl  0x8(%ebp)
  8015e5:	6a 12                	push   $0x12
  8015e7:	e8 17 fe ff ff       	call   801403 <syscall>
  8015ec:	83 c4 18             	add    $0x18,%esp
	return ;
  8015ef:	90                   	nop
}
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 0e                	push   $0xe
  801601:	e8 fd fd ff ff       	call   801403 <syscall>
  801606:	83 c4 18             	add    $0x18,%esp
}
  801609:	c9                   	leave  
  80160a:	c3                   	ret    

0080160b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	ff 75 08             	pushl  0x8(%ebp)
  801619:	6a 0f                	push   $0xf
  80161b:	e8 e3 fd ff ff       	call   801403 <syscall>
  801620:	83 c4 18             	add    $0x18,%esp
}
  801623:	c9                   	leave  
  801624:	c3                   	ret    

00801625 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801625:	55                   	push   %ebp
  801626:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 10                	push   $0x10
  801634:	e8 ca fd ff ff       	call   801403 <syscall>
  801639:	83 c4 18             	add    $0x18,%esp
}
  80163c:	90                   	nop
  80163d:	c9                   	leave  
  80163e:	c3                   	ret    

0080163f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80163f:	55                   	push   %ebp
  801640:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 14                	push   $0x14
  80164e:	e8 b0 fd ff ff       	call   801403 <syscall>
  801653:	83 c4 18             	add    $0x18,%esp
}
  801656:	90                   	nop
  801657:	c9                   	leave  
  801658:	c3                   	ret    

00801659 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801659:	55                   	push   %ebp
  80165a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 15                	push   $0x15
  801668:	e8 96 fd ff ff       	call   801403 <syscall>
  80166d:	83 c4 18             	add    $0x18,%esp
}
  801670:	90                   	nop
  801671:	c9                   	leave  
  801672:	c3                   	ret    

00801673 <sys_cputc>:


void
sys_cputc(const char c)
{
  801673:	55                   	push   %ebp
  801674:	89 e5                	mov    %esp,%ebp
  801676:	83 ec 04             	sub    $0x4,%esp
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80167f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	50                   	push   %eax
  80168c:	6a 16                	push   $0x16
  80168e:	e8 70 fd ff ff       	call   801403 <syscall>
  801693:	83 c4 18             	add    $0x18,%esp
}
  801696:	90                   	nop
  801697:	c9                   	leave  
  801698:	c3                   	ret    

00801699 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801699:	55                   	push   %ebp
  80169a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 17                	push   $0x17
  8016a8:	e8 56 fd ff ff       	call   801403 <syscall>
  8016ad:	83 c4 18             	add    $0x18,%esp
}
  8016b0:	90                   	nop
  8016b1:	c9                   	leave  
  8016b2:	c3                   	ret    

008016b3 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8016b3:	55                   	push   %ebp
  8016b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	ff 75 0c             	pushl  0xc(%ebp)
  8016c2:	50                   	push   %eax
  8016c3:	6a 18                	push   $0x18
  8016c5:	e8 39 fd ff ff       	call   801403 <syscall>
  8016ca:	83 c4 18             	add    $0x18,%esp
}
  8016cd:	c9                   	leave  
  8016ce:	c3                   	ret    

008016cf <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8016cf:	55                   	push   %ebp
  8016d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	52                   	push   %edx
  8016df:	50                   	push   %eax
  8016e0:	6a 1b                	push   $0x1b
  8016e2:	e8 1c fd ff ff       	call   801403 <syscall>
  8016e7:	83 c4 18             	add    $0x18,%esp
}
  8016ea:	c9                   	leave  
  8016eb:	c3                   	ret    

008016ec <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8016ec:	55                   	push   %ebp
  8016ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	52                   	push   %edx
  8016fc:	50                   	push   %eax
  8016fd:	6a 19                	push   $0x19
  8016ff:	e8 ff fc ff ff       	call   801403 <syscall>
  801704:	83 c4 18             	add    $0x18,%esp
}
  801707:	90                   	nop
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80170d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801710:	8b 45 08             	mov    0x8(%ebp),%eax
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 00                	push   $0x0
  801719:	52                   	push   %edx
  80171a:	50                   	push   %eax
  80171b:	6a 1a                	push   $0x1a
  80171d:	e8 e1 fc ff ff       	call   801403 <syscall>
  801722:	83 c4 18             	add    $0x18,%esp
}
  801725:	90                   	nop
  801726:	c9                   	leave  
  801727:	c3                   	ret    

00801728 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
  80172b:	83 ec 04             	sub    $0x4,%esp
  80172e:	8b 45 10             	mov    0x10(%ebp),%eax
  801731:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801734:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801737:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80173b:	8b 45 08             	mov    0x8(%ebp),%eax
  80173e:	6a 00                	push   $0x0
  801740:	51                   	push   %ecx
  801741:	52                   	push   %edx
  801742:	ff 75 0c             	pushl  0xc(%ebp)
  801745:	50                   	push   %eax
  801746:	6a 1c                	push   $0x1c
  801748:	e8 b6 fc ff ff       	call   801403 <syscall>
  80174d:	83 c4 18             	add    $0x18,%esp
}
  801750:	c9                   	leave  
  801751:	c3                   	ret    

00801752 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801752:	55                   	push   %ebp
  801753:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801755:	8b 55 0c             	mov    0xc(%ebp),%edx
  801758:	8b 45 08             	mov    0x8(%ebp),%eax
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	52                   	push   %edx
  801762:	50                   	push   %eax
  801763:	6a 1d                	push   $0x1d
  801765:	e8 99 fc ff ff       	call   801403 <syscall>
  80176a:	83 c4 18             	add    $0x18,%esp
}
  80176d:	c9                   	leave  
  80176e:	c3                   	ret    

0080176f <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801772:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801775:	8b 55 0c             	mov    0xc(%ebp),%edx
  801778:	8b 45 08             	mov    0x8(%ebp),%eax
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	51                   	push   %ecx
  801780:	52                   	push   %edx
  801781:	50                   	push   %eax
  801782:	6a 1e                	push   $0x1e
  801784:	e8 7a fc ff ff       	call   801403 <syscall>
  801789:	83 c4 18             	add    $0x18,%esp
}
  80178c:	c9                   	leave  
  80178d:	c3                   	ret    

0080178e <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80178e:	55                   	push   %ebp
  80178f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801791:	8b 55 0c             	mov    0xc(%ebp),%edx
  801794:	8b 45 08             	mov    0x8(%ebp),%eax
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	52                   	push   %edx
  80179e:	50                   	push   %eax
  80179f:	6a 1f                	push   $0x1f
  8017a1:	e8 5d fc ff ff       	call   801403 <syscall>
  8017a6:	83 c4 18             	add    $0x18,%esp
}
  8017a9:	c9                   	leave  
  8017aa:	c3                   	ret    

008017ab <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8017ab:	55                   	push   %ebp
  8017ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 20                	push   $0x20
  8017ba:	e8 44 fc ff ff       	call   801403 <syscall>
  8017bf:	83 c4 18             	add    $0x18,%esp
}
  8017c2:	c9                   	leave  
  8017c3:	c3                   	ret    

008017c4 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8017c4:	55                   	push   %ebp
  8017c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8017c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	ff 75 10             	pushl  0x10(%ebp)
  8017d1:	ff 75 0c             	pushl  0xc(%ebp)
  8017d4:	50                   	push   %eax
  8017d5:	6a 21                	push   $0x21
  8017d7:	e8 27 fc ff ff       	call   801403 <syscall>
  8017dc:	83 c4 18             	add    $0x18,%esp
}
  8017df:	c9                   	leave  
  8017e0:	c3                   	ret    

008017e1 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8017e1:	55                   	push   %ebp
  8017e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8017e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	50                   	push   %eax
  8017f0:	6a 22                	push   $0x22
  8017f2:	e8 0c fc ff ff       	call   801403 <syscall>
  8017f7:	83 c4 18             	add    $0x18,%esp
}
  8017fa:	90                   	nop
  8017fb:	c9                   	leave  
  8017fc:	c3                   	ret    

008017fd <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8017fd:	55                   	push   %ebp
  8017fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801800:	8b 45 08             	mov    0x8(%ebp),%eax
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	50                   	push   %eax
  80180c:	6a 23                	push   $0x23
  80180e:	e8 f0 fb ff ff       	call   801403 <syscall>
  801813:	83 c4 18             	add    $0x18,%esp
}
  801816:	90                   	nop
  801817:	c9                   	leave  
  801818:	c3                   	ret    

00801819 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801819:	55                   	push   %ebp
  80181a:	89 e5                	mov    %esp,%ebp
  80181c:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80181f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801822:	8d 50 04             	lea    0x4(%eax),%edx
  801825:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	52                   	push   %edx
  80182f:	50                   	push   %eax
  801830:	6a 24                	push   $0x24
  801832:	e8 cc fb ff ff       	call   801403 <syscall>
  801837:	83 c4 18             	add    $0x18,%esp
	return result;
  80183a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80183d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801840:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801843:	89 01                	mov    %eax,(%ecx)
  801845:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801848:	8b 45 08             	mov    0x8(%ebp),%eax
  80184b:	c9                   	leave  
  80184c:	c2 04 00             	ret    $0x4

0080184f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80184f:	55                   	push   %ebp
  801850:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	ff 75 10             	pushl  0x10(%ebp)
  801859:	ff 75 0c             	pushl  0xc(%ebp)
  80185c:	ff 75 08             	pushl  0x8(%ebp)
  80185f:	6a 13                	push   $0x13
  801861:	e8 9d fb ff ff       	call   801403 <syscall>
  801866:	83 c4 18             	add    $0x18,%esp
	return ;
  801869:	90                   	nop
}
  80186a:	c9                   	leave  
  80186b:	c3                   	ret    

0080186c <sys_rcr2>:
uint32 sys_rcr2()
{
  80186c:	55                   	push   %ebp
  80186d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 25                	push   $0x25
  80187b:	e8 83 fb ff ff       	call   801403 <syscall>
  801880:	83 c4 18             	add    $0x18,%esp
}
  801883:	c9                   	leave  
  801884:	c3                   	ret    

00801885 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
  801888:	83 ec 04             	sub    $0x4,%esp
  80188b:	8b 45 08             	mov    0x8(%ebp),%eax
  80188e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801891:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	50                   	push   %eax
  80189e:	6a 26                	push   $0x26
  8018a0:	e8 5e fb ff ff       	call   801403 <syscall>
  8018a5:	83 c4 18             	add    $0x18,%esp
	return ;
  8018a8:	90                   	nop
}
  8018a9:	c9                   	leave  
  8018aa:	c3                   	ret    

008018ab <rsttst>:
void rsttst()
{
  8018ab:	55                   	push   %ebp
  8018ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 28                	push   $0x28
  8018ba:	e8 44 fb ff ff       	call   801403 <syscall>
  8018bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8018c2:	90                   	nop
}
  8018c3:	c9                   	leave  
  8018c4:	c3                   	ret    

008018c5 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018c5:	55                   	push   %ebp
  8018c6:	89 e5                	mov    %esp,%ebp
  8018c8:	83 ec 04             	sub    $0x4,%esp
  8018cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ce:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018d1:	8b 55 18             	mov    0x18(%ebp),%edx
  8018d4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018d8:	52                   	push   %edx
  8018d9:	50                   	push   %eax
  8018da:	ff 75 10             	pushl  0x10(%ebp)
  8018dd:	ff 75 0c             	pushl  0xc(%ebp)
  8018e0:	ff 75 08             	pushl  0x8(%ebp)
  8018e3:	6a 27                	push   $0x27
  8018e5:	e8 19 fb ff ff       	call   801403 <syscall>
  8018ea:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ed:	90                   	nop
}
  8018ee:	c9                   	leave  
  8018ef:	c3                   	ret    

008018f0 <chktst>:
void chktst(uint32 n)
{
  8018f0:	55                   	push   %ebp
  8018f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	ff 75 08             	pushl  0x8(%ebp)
  8018fe:	6a 29                	push   $0x29
  801900:	e8 fe fa ff ff       	call   801403 <syscall>
  801905:	83 c4 18             	add    $0x18,%esp
	return ;
  801908:	90                   	nop
}
  801909:	c9                   	leave  
  80190a:	c3                   	ret    

0080190b <inctst>:

void inctst()
{
  80190b:	55                   	push   %ebp
  80190c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 2a                	push   $0x2a
  80191a:	e8 e4 fa ff ff       	call   801403 <syscall>
  80191f:	83 c4 18             	add    $0x18,%esp
	return ;
  801922:	90                   	nop
}
  801923:	c9                   	leave  
  801924:	c3                   	ret    

00801925 <gettst>:
uint32 gettst()
{
  801925:	55                   	push   %ebp
  801926:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 2b                	push   $0x2b
  801934:	e8 ca fa ff ff       	call   801403 <syscall>
  801939:	83 c4 18             	add    $0x18,%esp
}
  80193c:	c9                   	leave  
  80193d:	c3                   	ret    

0080193e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80193e:	55                   	push   %ebp
  80193f:	89 e5                	mov    %esp,%ebp
  801941:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801944:	6a 00                	push   $0x0
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	6a 2c                	push   $0x2c
  801950:	e8 ae fa ff ff       	call   801403 <syscall>
  801955:	83 c4 18             	add    $0x18,%esp
  801958:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80195b:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80195f:	75 07                	jne    801968 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801961:	b8 01 00 00 00       	mov    $0x1,%eax
  801966:	eb 05                	jmp    80196d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801968:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80196d:	c9                   	leave  
  80196e:	c3                   	ret    

0080196f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
  801972:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 2c                	push   $0x2c
  801981:	e8 7d fa ff ff       	call   801403 <syscall>
  801986:	83 c4 18             	add    $0x18,%esp
  801989:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80198c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801990:	75 07                	jne    801999 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801992:	b8 01 00 00 00       	mov    $0x1,%eax
  801997:	eb 05                	jmp    80199e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801999:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80199e:	c9                   	leave  
  80199f:	c3                   	ret    

008019a0 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8019a0:	55                   	push   %ebp
  8019a1:	89 e5                	mov    %esp,%ebp
  8019a3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 2c                	push   $0x2c
  8019b2:	e8 4c fa ff ff       	call   801403 <syscall>
  8019b7:	83 c4 18             	add    $0x18,%esp
  8019ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8019bd:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8019c1:	75 07                	jne    8019ca <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8019c3:	b8 01 00 00 00       	mov    $0x1,%eax
  8019c8:	eb 05                	jmp    8019cf <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8019ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019cf:	c9                   	leave  
  8019d0:	c3                   	ret    

008019d1 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8019d1:	55                   	push   %ebp
  8019d2:	89 e5                	mov    %esp,%ebp
  8019d4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 2c                	push   $0x2c
  8019e3:	e8 1b fa ff ff       	call   801403 <syscall>
  8019e8:	83 c4 18             	add    $0x18,%esp
  8019eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8019ee:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8019f2:	75 07                	jne    8019fb <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8019f4:	b8 01 00 00 00       	mov    $0x1,%eax
  8019f9:	eb 05                	jmp    801a00 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8019fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a00:	c9                   	leave  
  801a01:	c3                   	ret    

00801a02 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a02:	55                   	push   %ebp
  801a03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 00                	push   $0x0
  801a0d:	ff 75 08             	pushl  0x8(%ebp)
  801a10:	6a 2d                	push   $0x2d
  801a12:	e8 ec f9 ff ff       	call   801403 <syscall>
  801a17:	83 c4 18             	add    $0x18,%esp
	return ;
  801a1a:	90                   	nop
}
  801a1b:	c9                   	leave  
  801a1c:	c3                   	ret    
  801a1d:	66 90                	xchg   %ax,%ax
  801a1f:	90                   	nop

00801a20 <__udivdi3>:
  801a20:	55                   	push   %ebp
  801a21:	57                   	push   %edi
  801a22:	56                   	push   %esi
  801a23:	53                   	push   %ebx
  801a24:	83 ec 1c             	sub    $0x1c,%esp
  801a27:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a2b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a2f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a33:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a37:	89 ca                	mov    %ecx,%edx
  801a39:	89 f8                	mov    %edi,%eax
  801a3b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a3f:	85 f6                	test   %esi,%esi
  801a41:	75 2d                	jne    801a70 <__udivdi3+0x50>
  801a43:	39 cf                	cmp    %ecx,%edi
  801a45:	77 65                	ja     801aac <__udivdi3+0x8c>
  801a47:	89 fd                	mov    %edi,%ebp
  801a49:	85 ff                	test   %edi,%edi
  801a4b:	75 0b                	jne    801a58 <__udivdi3+0x38>
  801a4d:	b8 01 00 00 00       	mov    $0x1,%eax
  801a52:	31 d2                	xor    %edx,%edx
  801a54:	f7 f7                	div    %edi
  801a56:	89 c5                	mov    %eax,%ebp
  801a58:	31 d2                	xor    %edx,%edx
  801a5a:	89 c8                	mov    %ecx,%eax
  801a5c:	f7 f5                	div    %ebp
  801a5e:	89 c1                	mov    %eax,%ecx
  801a60:	89 d8                	mov    %ebx,%eax
  801a62:	f7 f5                	div    %ebp
  801a64:	89 cf                	mov    %ecx,%edi
  801a66:	89 fa                	mov    %edi,%edx
  801a68:	83 c4 1c             	add    $0x1c,%esp
  801a6b:	5b                   	pop    %ebx
  801a6c:	5e                   	pop    %esi
  801a6d:	5f                   	pop    %edi
  801a6e:	5d                   	pop    %ebp
  801a6f:	c3                   	ret    
  801a70:	39 ce                	cmp    %ecx,%esi
  801a72:	77 28                	ja     801a9c <__udivdi3+0x7c>
  801a74:	0f bd fe             	bsr    %esi,%edi
  801a77:	83 f7 1f             	xor    $0x1f,%edi
  801a7a:	75 40                	jne    801abc <__udivdi3+0x9c>
  801a7c:	39 ce                	cmp    %ecx,%esi
  801a7e:	72 0a                	jb     801a8a <__udivdi3+0x6a>
  801a80:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a84:	0f 87 9e 00 00 00    	ja     801b28 <__udivdi3+0x108>
  801a8a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a8f:	89 fa                	mov    %edi,%edx
  801a91:	83 c4 1c             	add    $0x1c,%esp
  801a94:	5b                   	pop    %ebx
  801a95:	5e                   	pop    %esi
  801a96:	5f                   	pop    %edi
  801a97:	5d                   	pop    %ebp
  801a98:	c3                   	ret    
  801a99:	8d 76 00             	lea    0x0(%esi),%esi
  801a9c:	31 ff                	xor    %edi,%edi
  801a9e:	31 c0                	xor    %eax,%eax
  801aa0:	89 fa                	mov    %edi,%edx
  801aa2:	83 c4 1c             	add    $0x1c,%esp
  801aa5:	5b                   	pop    %ebx
  801aa6:	5e                   	pop    %esi
  801aa7:	5f                   	pop    %edi
  801aa8:	5d                   	pop    %ebp
  801aa9:	c3                   	ret    
  801aaa:	66 90                	xchg   %ax,%ax
  801aac:	89 d8                	mov    %ebx,%eax
  801aae:	f7 f7                	div    %edi
  801ab0:	31 ff                	xor    %edi,%edi
  801ab2:	89 fa                	mov    %edi,%edx
  801ab4:	83 c4 1c             	add    $0x1c,%esp
  801ab7:	5b                   	pop    %ebx
  801ab8:	5e                   	pop    %esi
  801ab9:	5f                   	pop    %edi
  801aba:	5d                   	pop    %ebp
  801abb:	c3                   	ret    
  801abc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ac1:	89 eb                	mov    %ebp,%ebx
  801ac3:	29 fb                	sub    %edi,%ebx
  801ac5:	89 f9                	mov    %edi,%ecx
  801ac7:	d3 e6                	shl    %cl,%esi
  801ac9:	89 c5                	mov    %eax,%ebp
  801acb:	88 d9                	mov    %bl,%cl
  801acd:	d3 ed                	shr    %cl,%ebp
  801acf:	89 e9                	mov    %ebp,%ecx
  801ad1:	09 f1                	or     %esi,%ecx
  801ad3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ad7:	89 f9                	mov    %edi,%ecx
  801ad9:	d3 e0                	shl    %cl,%eax
  801adb:	89 c5                	mov    %eax,%ebp
  801add:	89 d6                	mov    %edx,%esi
  801adf:	88 d9                	mov    %bl,%cl
  801ae1:	d3 ee                	shr    %cl,%esi
  801ae3:	89 f9                	mov    %edi,%ecx
  801ae5:	d3 e2                	shl    %cl,%edx
  801ae7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aeb:	88 d9                	mov    %bl,%cl
  801aed:	d3 e8                	shr    %cl,%eax
  801aef:	09 c2                	or     %eax,%edx
  801af1:	89 d0                	mov    %edx,%eax
  801af3:	89 f2                	mov    %esi,%edx
  801af5:	f7 74 24 0c          	divl   0xc(%esp)
  801af9:	89 d6                	mov    %edx,%esi
  801afb:	89 c3                	mov    %eax,%ebx
  801afd:	f7 e5                	mul    %ebp
  801aff:	39 d6                	cmp    %edx,%esi
  801b01:	72 19                	jb     801b1c <__udivdi3+0xfc>
  801b03:	74 0b                	je     801b10 <__udivdi3+0xf0>
  801b05:	89 d8                	mov    %ebx,%eax
  801b07:	31 ff                	xor    %edi,%edi
  801b09:	e9 58 ff ff ff       	jmp    801a66 <__udivdi3+0x46>
  801b0e:	66 90                	xchg   %ax,%ax
  801b10:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b14:	89 f9                	mov    %edi,%ecx
  801b16:	d3 e2                	shl    %cl,%edx
  801b18:	39 c2                	cmp    %eax,%edx
  801b1a:	73 e9                	jae    801b05 <__udivdi3+0xe5>
  801b1c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b1f:	31 ff                	xor    %edi,%edi
  801b21:	e9 40 ff ff ff       	jmp    801a66 <__udivdi3+0x46>
  801b26:	66 90                	xchg   %ax,%ax
  801b28:	31 c0                	xor    %eax,%eax
  801b2a:	e9 37 ff ff ff       	jmp    801a66 <__udivdi3+0x46>
  801b2f:	90                   	nop

00801b30 <__umoddi3>:
  801b30:	55                   	push   %ebp
  801b31:	57                   	push   %edi
  801b32:	56                   	push   %esi
  801b33:	53                   	push   %ebx
  801b34:	83 ec 1c             	sub    $0x1c,%esp
  801b37:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b3b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b3f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b43:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b47:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b4b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b4f:	89 f3                	mov    %esi,%ebx
  801b51:	89 fa                	mov    %edi,%edx
  801b53:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b57:	89 34 24             	mov    %esi,(%esp)
  801b5a:	85 c0                	test   %eax,%eax
  801b5c:	75 1a                	jne    801b78 <__umoddi3+0x48>
  801b5e:	39 f7                	cmp    %esi,%edi
  801b60:	0f 86 a2 00 00 00    	jbe    801c08 <__umoddi3+0xd8>
  801b66:	89 c8                	mov    %ecx,%eax
  801b68:	89 f2                	mov    %esi,%edx
  801b6a:	f7 f7                	div    %edi
  801b6c:	89 d0                	mov    %edx,%eax
  801b6e:	31 d2                	xor    %edx,%edx
  801b70:	83 c4 1c             	add    $0x1c,%esp
  801b73:	5b                   	pop    %ebx
  801b74:	5e                   	pop    %esi
  801b75:	5f                   	pop    %edi
  801b76:	5d                   	pop    %ebp
  801b77:	c3                   	ret    
  801b78:	39 f0                	cmp    %esi,%eax
  801b7a:	0f 87 ac 00 00 00    	ja     801c2c <__umoddi3+0xfc>
  801b80:	0f bd e8             	bsr    %eax,%ebp
  801b83:	83 f5 1f             	xor    $0x1f,%ebp
  801b86:	0f 84 ac 00 00 00    	je     801c38 <__umoddi3+0x108>
  801b8c:	bf 20 00 00 00       	mov    $0x20,%edi
  801b91:	29 ef                	sub    %ebp,%edi
  801b93:	89 fe                	mov    %edi,%esi
  801b95:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b99:	89 e9                	mov    %ebp,%ecx
  801b9b:	d3 e0                	shl    %cl,%eax
  801b9d:	89 d7                	mov    %edx,%edi
  801b9f:	89 f1                	mov    %esi,%ecx
  801ba1:	d3 ef                	shr    %cl,%edi
  801ba3:	09 c7                	or     %eax,%edi
  801ba5:	89 e9                	mov    %ebp,%ecx
  801ba7:	d3 e2                	shl    %cl,%edx
  801ba9:	89 14 24             	mov    %edx,(%esp)
  801bac:	89 d8                	mov    %ebx,%eax
  801bae:	d3 e0                	shl    %cl,%eax
  801bb0:	89 c2                	mov    %eax,%edx
  801bb2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bb6:	d3 e0                	shl    %cl,%eax
  801bb8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bbc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bc0:	89 f1                	mov    %esi,%ecx
  801bc2:	d3 e8                	shr    %cl,%eax
  801bc4:	09 d0                	or     %edx,%eax
  801bc6:	d3 eb                	shr    %cl,%ebx
  801bc8:	89 da                	mov    %ebx,%edx
  801bca:	f7 f7                	div    %edi
  801bcc:	89 d3                	mov    %edx,%ebx
  801bce:	f7 24 24             	mull   (%esp)
  801bd1:	89 c6                	mov    %eax,%esi
  801bd3:	89 d1                	mov    %edx,%ecx
  801bd5:	39 d3                	cmp    %edx,%ebx
  801bd7:	0f 82 87 00 00 00    	jb     801c64 <__umoddi3+0x134>
  801bdd:	0f 84 91 00 00 00    	je     801c74 <__umoddi3+0x144>
  801be3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801be7:	29 f2                	sub    %esi,%edx
  801be9:	19 cb                	sbb    %ecx,%ebx
  801beb:	89 d8                	mov    %ebx,%eax
  801bed:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801bf1:	d3 e0                	shl    %cl,%eax
  801bf3:	89 e9                	mov    %ebp,%ecx
  801bf5:	d3 ea                	shr    %cl,%edx
  801bf7:	09 d0                	or     %edx,%eax
  801bf9:	89 e9                	mov    %ebp,%ecx
  801bfb:	d3 eb                	shr    %cl,%ebx
  801bfd:	89 da                	mov    %ebx,%edx
  801bff:	83 c4 1c             	add    $0x1c,%esp
  801c02:	5b                   	pop    %ebx
  801c03:	5e                   	pop    %esi
  801c04:	5f                   	pop    %edi
  801c05:	5d                   	pop    %ebp
  801c06:	c3                   	ret    
  801c07:	90                   	nop
  801c08:	89 fd                	mov    %edi,%ebp
  801c0a:	85 ff                	test   %edi,%edi
  801c0c:	75 0b                	jne    801c19 <__umoddi3+0xe9>
  801c0e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c13:	31 d2                	xor    %edx,%edx
  801c15:	f7 f7                	div    %edi
  801c17:	89 c5                	mov    %eax,%ebp
  801c19:	89 f0                	mov    %esi,%eax
  801c1b:	31 d2                	xor    %edx,%edx
  801c1d:	f7 f5                	div    %ebp
  801c1f:	89 c8                	mov    %ecx,%eax
  801c21:	f7 f5                	div    %ebp
  801c23:	89 d0                	mov    %edx,%eax
  801c25:	e9 44 ff ff ff       	jmp    801b6e <__umoddi3+0x3e>
  801c2a:	66 90                	xchg   %ax,%ax
  801c2c:	89 c8                	mov    %ecx,%eax
  801c2e:	89 f2                	mov    %esi,%edx
  801c30:	83 c4 1c             	add    $0x1c,%esp
  801c33:	5b                   	pop    %ebx
  801c34:	5e                   	pop    %esi
  801c35:	5f                   	pop    %edi
  801c36:	5d                   	pop    %ebp
  801c37:	c3                   	ret    
  801c38:	3b 04 24             	cmp    (%esp),%eax
  801c3b:	72 06                	jb     801c43 <__umoddi3+0x113>
  801c3d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c41:	77 0f                	ja     801c52 <__umoddi3+0x122>
  801c43:	89 f2                	mov    %esi,%edx
  801c45:	29 f9                	sub    %edi,%ecx
  801c47:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c4b:	89 14 24             	mov    %edx,(%esp)
  801c4e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c52:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c56:	8b 14 24             	mov    (%esp),%edx
  801c59:	83 c4 1c             	add    $0x1c,%esp
  801c5c:	5b                   	pop    %ebx
  801c5d:	5e                   	pop    %esi
  801c5e:	5f                   	pop    %edi
  801c5f:	5d                   	pop    %ebp
  801c60:	c3                   	ret    
  801c61:	8d 76 00             	lea    0x0(%esi),%esi
  801c64:	2b 04 24             	sub    (%esp),%eax
  801c67:	19 fa                	sbb    %edi,%edx
  801c69:	89 d1                	mov    %edx,%ecx
  801c6b:	89 c6                	mov    %eax,%esi
  801c6d:	e9 71 ff ff ff       	jmp    801be3 <__umoddi3+0xb3>
  801c72:	66 90                	xchg   %ax,%ax
  801c74:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c78:	72 ea                	jb     801c64 <__umoddi3+0x134>
  801c7a:	89 d9                	mov    %ebx,%ecx
  801c7c:	e9 62 ff ff ff       	jmp    801be3 <__umoddi3+0xb3>
