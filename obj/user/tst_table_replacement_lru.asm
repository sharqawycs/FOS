
obj/user/tst_table_replacement_lru:     file format elf32-i386


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
  800031:	e8 c3 02 00 00       	call   8002f9 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:


uint8* ptr = (uint8* )0x0800000 ;
int i ;
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 34 00 00 02    	sub    $0x2000034,%esp

	
	

	{
		if ( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x00000000)  panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  800042:	a1 08 30 80 00       	mov    0x803008,%eax
  800047:	8b 40 7c             	mov    0x7c(%eax),%eax
  80004a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80004d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800050:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800055:	85 c0                	test   %eax,%eax
  800057:	74 14                	je     80006d <_main+0x35>
  800059:	83 ec 04             	sub    $0x4,%esp
  80005c:	68 c0 1c 80 00       	push   $0x801cc0
  800061:	6a 16                	push   $0x16
  800063:	68 0c 1d 80 00       	push   $0x801d0c
  800068:	e8 8e 03 00 00       	call   8003fb <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  80006d:	a1 08 30 80 00       	mov    0x803008,%eax
  800072:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  800078:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80007b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007e:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800083:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800088:	74 14                	je     80009e <_main+0x66>
  80008a:	83 ec 04             	sub    $0x4,%esp
  80008d:	68 c0 1c 80 00       	push   $0x801cc0
  800092:	6a 17                	push   $0x17
  800094:	68 0c 1d 80 00       	push   $0x801d0c
  800099:	e8 5d 03 00 00       	call   8003fb <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)  panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  80009e:	a1 08 30 80 00       	mov    0x803008,%eax
  8000a3:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
  8000a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8000ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000af:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000b4:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  8000b9:	74 14                	je     8000cf <_main+0x97>
  8000bb:	83 ec 04             	sub    $0x4,%esp
  8000be:	68 c0 1c 80 00       	push   $0x801cc0
  8000c3:	6a 18                	push   $0x18
  8000c5:	68 0c 1d 80 00       	push   $0x801d0c
  8000ca:	e8 2c 03 00 00       	call   8003fb <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000cf:	a1 08 30 80 00       	mov    0x803008,%eax
  8000d4:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
  8000da:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e0:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000e5:	3d 00 00 80 ec       	cmp    $0xec800000,%eax
  8000ea:	74 14                	je     800100 <_main+0xc8>
  8000ec:	83 ec 04             	sub    $0x4,%esp
  8000ef:	68 c0 1c 80 00       	push   $0x801cc0
  8000f4:	6a 19                	push   $0x19
  8000f6:	68 0c 1d 80 00       	push   $0x801d0c
  8000fb:	e8 fb 02 00 00       	call   8003fb <_panic>
		if( myEnv->table_last_WS_index !=  4)  											panic("INITIAL TABLE last index checking failed! Review sizes of the two WS's..!!");
  800100:	a1 08 30 80 00       	mov    0x803008,%eax
  800105:	8b 80 d8 02 00 00    	mov    0x2d8(%eax),%eax
  80010b:	83 f8 04             	cmp    $0x4,%eax
  80010e:	74 14                	je     800124 <_main+0xec>
  800110:	83 ec 04             	sub    $0x4,%esp
  800113:	68 30 1d 80 00       	push   $0x801d30
  800118:	6a 1a                	push   $0x1a
  80011a:	68 0c 1d 80 00       	push   $0x801d0c
  80011f:	e8 d7 02 00 00       	call   8003fb <_panic>

	}

	{
		arr[0] = -1;
  800124:	c6 85 d4 ff ff fd ff 	movb   $0xff,-0x200002c(%ebp)
		arr[PAGE_SIZE*1024-1] = -1;
  80012b:	c6 85 d3 ff 3f fe ff 	movb   $0xff,-0x1c0002d(%ebp)


		for (i = 0 ; i < PAGE_SIZE / 2 ; i++)
  800132:	c7 05 14 30 80 00 00 	movl   $0x0,0x803014
  800139:	00 00 00 
  80013c:	eb 26                	jmp    800164 <_main+0x12c>
		{
			arr[PAGE_SIZE*1024*2 - i] = i;
  80013e:	a1 14 30 80 00       	mov    0x803014,%eax
  800143:	ba 00 00 80 00       	mov    $0x800000,%edx
  800148:	29 c2                	sub    %eax,%edx
  80014a:	89 d0                	mov    %edx,%eax
  80014c:	8b 15 14 30 80 00    	mov    0x803014,%edx
  800152:	88 94 05 d4 ff ff fd 	mov    %dl,-0x200002c(%ebp,%eax,1)
	{
		arr[0] = -1;
		arr[PAGE_SIZE*1024-1] = -1;


		for (i = 0 ; i < PAGE_SIZE / 2 ; i++)
  800159:	a1 14 30 80 00       	mov    0x803014,%eax
  80015e:	40                   	inc    %eax
  80015f:	a3 14 30 80 00       	mov    %eax,0x803014
  800164:	a1 14 30 80 00       	mov    0x803014,%eax
  800169:	3d ff 07 00 00       	cmp    $0x7ff,%eax
  80016e:	7e ce                	jle    80013e <_main+0x106>
		{
			arr[PAGE_SIZE*1024*2 - i] = i;
		}
		for (i = 0 ; i < PAGE_SIZE / 2; i++)
  800170:	c7 05 14 30 80 00 00 	movl   $0x0,0x803014
  800177:	00 00 00 
  80017a:	eb 30                	jmp    8001ac <_main+0x174>
		{
			arr[PAGE_SIZE*1024*3 - i] = i * i;
  80017c:	a1 14 30 80 00       	mov    0x803014,%eax
  800181:	ba 00 00 c0 00       	mov    $0xc00000,%edx
  800186:	29 c2                	sub    %eax,%edx
  800188:	a1 14 30 80 00       	mov    0x803014,%eax
  80018d:	88 c3                	mov    %al,%bl
  80018f:	a1 14 30 80 00       	mov    0x803014,%eax
  800194:	88 c1                	mov    %al,%cl
  800196:	88 d8                	mov    %bl,%al
  800198:	f6 e1                	mul    %cl
  80019a:	88 84 15 d4 ff ff fd 	mov    %al,-0x200002c(%ebp,%edx,1)

		for (i = 0 ; i < PAGE_SIZE / 2 ; i++)
		{
			arr[PAGE_SIZE*1024*2 - i] = i;
		}
		for (i = 0 ; i < PAGE_SIZE / 2; i++)
  8001a1:	a1 14 30 80 00       	mov    0x803014,%eax
  8001a6:	40                   	inc    %eax
  8001a7:	a3 14 30 80 00       	mov    %eax,0x803014
  8001ac:	a1 14 30 80 00       	mov    0x803014,%eax
  8001b1:	3d ff 07 00 00       	cmp    $0x7ff,%eax
  8001b6:	7e c4                	jle    80017c <_main+0x144>
		{
			arr[PAGE_SIZE*1024*3 - i] = i * i;
		}
		arr[PAGE_SIZE*1024*5-1] = -1;
  8001b8:	c6 85 d3 ff 3f ff ff 	movb   $0xff,-0xc0002d(%ebp)
		arr[PAGE_SIZE*1024*6-1] = -1;
  8001bf:	c6 85 d3 ff 7f ff ff 	movb   $0xff,-0x80002d(%ebp)
		arr[PAGE_SIZE*1024*7-1] = -1;
  8001c6:	c6 85 d3 ff bf ff ff 	movb   $0xff,-0x40002d(%ebp)

	}
	//cprintf("testing ...\n");
	{
		//cprintf("WS[2] = %x\n", ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) );
		if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0xee400000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
  8001cd:	a1 08 30 80 00       	mov    0x803008,%eax
  8001d2:	8b 40 7c             	mov    0x7c(%eax),%eax
  8001d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8001d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001db:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8001e0:	3d 00 00 40 ee       	cmp    $0xee400000,%eax
  8001e5:	74 14                	je     8001fb <_main+0x1c3>
  8001e7:	83 ec 04             	sub    $0x4,%esp
  8001ea:	68 7c 1d 80 00       	push   $0x801d7c
  8001ef:	6a 33                	push   $0x33
  8001f1:	68 0c 1d 80 00       	push   $0x801d0c
  8001f6:	e8 00 02 00 00       	call   8003fb <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
  8001fb:	a1 08 30 80 00       	mov    0x803008,%eax
  800200:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  800206:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800209:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80020c:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800211:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800216:	74 14                	je     80022c <_main+0x1f4>
  800218:	83 ec 04             	sub    $0x4,%esp
  80021b:	68 7c 1d 80 00       	push   $0x801d7c
  800220:	6a 34                	push   $0x34
  800222:	68 0c 1d 80 00       	push   $0x801d0c
  800227:	e8 cf 01 00 00       	call   8003fb <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
  80022c:	a1 08 30 80 00       	mov    0x803008,%eax
  800231:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
  800237:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80023a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80023d:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800242:	3d 00 00 80 ec       	cmp    $0xec800000,%eax
  800247:	74 14                	je     80025d <_main+0x225>
  800249:	83 ec 04             	sub    $0x4,%esp
  80024c:	68 7c 1d 80 00       	push   $0x801d7c
  800251:	6a 35                	push   $0x35
  800253:	68 0c 1d 80 00       	push   $0x801d0c
  800258:	e8 9e 01 00 00       	call   8003fb <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xedc00000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
  80025d:	a1 08 30 80 00       	mov    0x803008,%eax
  800262:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
  800268:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80026b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80026e:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800273:	3d 00 00 c0 ed       	cmp    $0xedc00000,%eax
  800278:	74 14                	je     80028e <_main+0x256>
  80027a:	83 ec 04             	sub    $0x4,%esp
  80027d:	68 7c 1d 80 00       	push   $0x801d7c
  800282:	6a 36                	push   $0x36
  800284:	68 0c 1d 80 00       	push   $0x801d0c
  800289:	e8 6d 01 00 00       	call   8003fb <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[4].virtual_address,1024*PAGE_SIZE) !=  0xee000000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
  80028e:	a1 08 30 80 00       	mov    0x803008,%eax
  800293:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
  800299:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  80029c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80029f:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8002a4:	3d 00 00 00 ee       	cmp    $0xee000000,%eax
  8002a9:	74 14                	je     8002bf <_main+0x287>
  8002ab:	83 ec 04             	sub    $0x4,%esp
  8002ae:	68 7c 1d 80 00       	push   $0x801d7c
  8002b3:	6a 37                	push   $0x37
  8002b5:	68 0c 1d 80 00       	push   $0x801d0c
  8002ba:	e8 3c 01 00 00       	call   8003fb <_panic>

		if(myEnv->table_last_WS_index != 3) panic("wrong TABLE WS pointer location");
  8002bf:	a1 08 30 80 00       	mov    0x803008,%eax
  8002c4:	8b 80 d8 02 00 00    	mov    0x2d8(%eax),%eax
  8002ca:	83 f8 03             	cmp    $0x3,%eax
  8002cd:	74 14                	je     8002e3 <_main+0x2ab>
  8002cf:	83 ec 04             	sub    $0x4,%esp
  8002d2:	68 c4 1d 80 00       	push   $0x801dc4
  8002d7:	6a 39                	push   $0x39
  8002d9:	68 0c 1d 80 00       	push   $0x801d0c
  8002de:	e8 18 01 00 00       	call   8003fb <_panic>
	}

	cprintf("Congratulations!! test table replacement (LRU alg) completed successfully.\n");
  8002e3:	83 ec 0c             	sub    $0xc,%esp
  8002e6:	68 e4 1d 80 00       	push   $0x801de4
  8002eb:	e8 bf 03 00 00       	call   8006af <cprintf>
  8002f0:	83 c4 10             	add    $0x10,%esp
	return;
  8002f3:	90                   	nop
}
  8002f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8002f7:	c9                   	leave  
  8002f8:	c3                   	ret    

008002f9 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8002f9:	55                   	push   %ebp
  8002fa:	89 e5                	mov    %esp,%ebp
  8002fc:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8002ff:	e8 d6 11 00 00       	call   8014da <sys_getenvindex>
  800304:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800307:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80030a:	89 d0                	mov    %edx,%eax
  80030c:	01 c0                	add    %eax,%eax
  80030e:	01 d0                	add    %edx,%eax
  800310:	c1 e0 02             	shl    $0x2,%eax
  800313:	01 d0                	add    %edx,%eax
  800315:	c1 e0 06             	shl    $0x6,%eax
  800318:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80031d:	a3 08 30 80 00       	mov    %eax,0x803008

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800322:	a1 08 30 80 00       	mov    0x803008,%eax
  800327:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80032d:	84 c0                	test   %al,%al
  80032f:	74 0f                	je     800340 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800331:	a1 08 30 80 00       	mov    0x803008,%eax
  800336:	05 f4 02 00 00       	add    $0x2f4,%eax
  80033b:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800340:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800344:	7e 0a                	jle    800350 <libmain+0x57>
		binaryname = argv[0];
  800346:	8b 45 0c             	mov    0xc(%ebp),%eax
  800349:	8b 00                	mov    (%eax),%eax
  80034b:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800350:	83 ec 08             	sub    $0x8,%esp
  800353:	ff 75 0c             	pushl  0xc(%ebp)
  800356:	ff 75 08             	pushl  0x8(%ebp)
  800359:	e8 da fc ff ff       	call   800038 <_main>
  80035e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800361:	e8 0f 13 00 00       	call   801675 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800366:	83 ec 0c             	sub    $0xc,%esp
  800369:	68 48 1e 80 00       	push   $0x801e48
  80036e:	e8 3c 03 00 00       	call   8006af <cprintf>
  800373:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800376:	a1 08 30 80 00       	mov    0x803008,%eax
  80037b:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800381:	a1 08 30 80 00       	mov    0x803008,%eax
  800386:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80038c:	83 ec 04             	sub    $0x4,%esp
  80038f:	52                   	push   %edx
  800390:	50                   	push   %eax
  800391:	68 70 1e 80 00       	push   $0x801e70
  800396:	e8 14 03 00 00       	call   8006af <cprintf>
  80039b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80039e:	a1 08 30 80 00       	mov    0x803008,%eax
  8003a3:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8003a9:	83 ec 08             	sub    $0x8,%esp
  8003ac:	50                   	push   %eax
  8003ad:	68 95 1e 80 00       	push   $0x801e95
  8003b2:	e8 f8 02 00 00       	call   8006af <cprintf>
  8003b7:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8003ba:	83 ec 0c             	sub    $0xc,%esp
  8003bd:	68 48 1e 80 00       	push   $0x801e48
  8003c2:	e8 e8 02 00 00       	call   8006af <cprintf>
  8003c7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8003ca:	e8 c0 12 00 00       	call   80168f <sys_enable_interrupt>

	// exit gracefully
	exit();
  8003cf:	e8 19 00 00 00       	call   8003ed <exit>
}
  8003d4:	90                   	nop
  8003d5:	c9                   	leave  
  8003d6:	c3                   	ret    

008003d7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003d7:	55                   	push   %ebp
  8003d8:	89 e5                	mov    %esp,%ebp
  8003da:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8003dd:	83 ec 0c             	sub    $0xc,%esp
  8003e0:	6a 00                	push   $0x0
  8003e2:	e8 bf 10 00 00       	call   8014a6 <sys_env_destroy>
  8003e7:	83 c4 10             	add    $0x10,%esp
}
  8003ea:	90                   	nop
  8003eb:	c9                   	leave  
  8003ec:	c3                   	ret    

008003ed <exit>:

void
exit(void)
{
  8003ed:	55                   	push   %ebp
  8003ee:	89 e5                	mov    %esp,%ebp
  8003f0:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8003f3:	e8 14 11 00 00       	call   80150c <sys_env_exit>
}
  8003f8:	90                   	nop
  8003f9:	c9                   	leave  
  8003fa:	c3                   	ret    

008003fb <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003fb:	55                   	push   %ebp
  8003fc:	89 e5                	mov    %esp,%ebp
  8003fe:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800401:	8d 45 10             	lea    0x10(%ebp),%eax
  800404:	83 c0 04             	add    $0x4,%eax
  800407:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80040a:	a1 1c 30 80 00       	mov    0x80301c,%eax
  80040f:	85 c0                	test   %eax,%eax
  800411:	74 16                	je     800429 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800413:	a1 1c 30 80 00       	mov    0x80301c,%eax
  800418:	83 ec 08             	sub    $0x8,%esp
  80041b:	50                   	push   %eax
  80041c:	68 ac 1e 80 00       	push   $0x801eac
  800421:	e8 89 02 00 00       	call   8006af <cprintf>
  800426:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800429:	a1 04 30 80 00       	mov    0x803004,%eax
  80042e:	ff 75 0c             	pushl  0xc(%ebp)
  800431:	ff 75 08             	pushl  0x8(%ebp)
  800434:	50                   	push   %eax
  800435:	68 b1 1e 80 00       	push   $0x801eb1
  80043a:	e8 70 02 00 00       	call   8006af <cprintf>
  80043f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800442:	8b 45 10             	mov    0x10(%ebp),%eax
  800445:	83 ec 08             	sub    $0x8,%esp
  800448:	ff 75 f4             	pushl  -0xc(%ebp)
  80044b:	50                   	push   %eax
  80044c:	e8 f3 01 00 00       	call   800644 <vcprintf>
  800451:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800454:	83 ec 08             	sub    $0x8,%esp
  800457:	6a 00                	push   $0x0
  800459:	68 cd 1e 80 00       	push   $0x801ecd
  80045e:	e8 e1 01 00 00       	call   800644 <vcprintf>
  800463:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800466:	e8 82 ff ff ff       	call   8003ed <exit>

	// should not return here
	while (1) ;
  80046b:	eb fe                	jmp    80046b <_panic+0x70>

0080046d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80046d:	55                   	push   %ebp
  80046e:	89 e5                	mov    %esp,%ebp
  800470:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800473:	a1 08 30 80 00       	mov    0x803008,%eax
  800478:	8b 50 74             	mov    0x74(%eax),%edx
  80047b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047e:	39 c2                	cmp    %eax,%edx
  800480:	74 14                	je     800496 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800482:	83 ec 04             	sub    $0x4,%esp
  800485:	68 d0 1e 80 00       	push   $0x801ed0
  80048a:	6a 26                	push   $0x26
  80048c:	68 1c 1f 80 00       	push   $0x801f1c
  800491:	e8 65 ff ff ff       	call   8003fb <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800496:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80049d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004a4:	e9 c2 00 00 00       	jmp    80056b <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8004a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b6:	01 d0                	add    %edx,%eax
  8004b8:	8b 00                	mov    (%eax),%eax
  8004ba:	85 c0                	test   %eax,%eax
  8004bc:	75 08                	jne    8004c6 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8004be:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8004c1:	e9 a2 00 00 00       	jmp    800568 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8004c6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004cd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8004d4:	eb 69                	jmp    80053f <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004d6:	a1 08 30 80 00       	mov    0x803008,%eax
  8004db:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004e1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004e4:	89 d0                	mov    %edx,%eax
  8004e6:	01 c0                	add    %eax,%eax
  8004e8:	01 d0                	add    %edx,%eax
  8004ea:	c1 e0 02             	shl    $0x2,%eax
  8004ed:	01 c8                	add    %ecx,%eax
  8004ef:	8a 40 04             	mov    0x4(%eax),%al
  8004f2:	84 c0                	test   %al,%al
  8004f4:	75 46                	jne    80053c <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004f6:	a1 08 30 80 00       	mov    0x803008,%eax
  8004fb:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800501:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800504:	89 d0                	mov    %edx,%eax
  800506:	01 c0                	add    %eax,%eax
  800508:	01 d0                	add    %edx,%eax
  80050a:	c1 e0 02             	shl    $0x2,%eax
  80050d:	01 c8                	add    %ecx,%eax
  80050f:	8b 00                	mov    (%eax),%eax
  800511:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800514:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800517:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80051c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80051e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800521:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800528:	8b 45 08             	mov    0x8(%ebp),%eax
  80052b:	01 c8                	add    %ecx,%eax
  80052d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80052f:	39 c2                	cmp    %eax,%edx
  800531:	75 09                	jne    80053c <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800533:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80053a:	eb 12                	jmp    80054e <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80053c:	ff 45 e8             	incl   -0x18(%ebp)
  80053f:	a1 08 30 80 00       	mov    0x803008,%eax
  800544:	8b 50 74             	mov    0x74(%eax),%edx
  800547:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80054a:	39 c2                	cmp    %eax,%edx
  80054c:	77 88                	ja     8004d6 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80054e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800552:	75 14                	jne    800568 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800554:	83 ec 04             	sub    $0x4,%esp
  800557:	68 28 1f 80 00       	push   $0x801f28
  80055c:	6a 3a                	push   $0x3a
  80055e:	68 1c 1f 80 00       	push   $0x801f1c
  800563:	e8 93 fe ff ff       	call   8003fb <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800568:	ff 45 f0             	incl   -0x10(%ebp)
  80056b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80056e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800571:	0f 8c 32 ff ff ff    	jl     8004a9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800577:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80057e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800585:	eb 26                	jmp    8005ad <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800587:	a1 08 30 80 00       	mov    0x803008,%eax
  80058c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800592:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800595:	89 d0                	mov    %edx,%eax
  800597:	01 c0                	add    %eax,%eax
  800599:	01 d0                	add    %edx,%eax
  80059b:	c1 e0 02             	shl    $0x2,%eax
  80059e:	01 c8                	add    %ecx,%eax
  8005a0:	8a 40 04             	mov    0x4(%eax),%al
  8005a3:	3c 01                	cmp    $0x1,%al
  8005a5:	75 03                	jne    8005aa <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8005a7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005aa:	ff 45 e0             	incl   -0x20(%ebp)
  8005ad:	a1 08 30 80 00       	mov    0x803008,%eax
  8005b2:	8b 50 74             	mov    0x74(%eax),%edx
  8005b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005b8:	39 c2                	cmp    %eax,%edx
  8005ba:	77 cb                	ja     800587 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8005bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005bf:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005c2:	74 14                	je     8005d8 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8005c4:	83 ec 04             	sub    $0x4,%esp
  8005c7:	68 7c 1f 80 00       	push   $0x801f7c
  8005cc:	6a 44                	push   $0x44
  8005ce:	68 1c 1f 80 00       	push   $0x801f1c
  8005d3:	e8 23 fe ff ff       	call   8003fb <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005d8:	90                   	nop
  8005d9:	c9                   	leave  
  8005da:	c3                   	ret    

008005db <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8005db:	55                   	push   %ebp
  8005dc:	89 e5                	mov    %esp,%ebp
  8005de:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e4:	8b 00                	mov    (%eax),%eax
  8005e6:	8d 48 01             	lea    0x1(%eax),%ecx
  8005e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005ec:	89 0a                	mov    %ecx,(%edx)
  8005ee:	8b 55 08             	mov    0x8(%ebp),%edx
  8005f1:	88 d1                	mov    %dl,%cl
  8005f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005f6:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005fd:	8b 00                	mov    (%eax),%eax
  8005ff:	3d ff 00 00 00       	cmp    $0xff,%eax
  800604:	75 2c                	jne    800632 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800606:	a0 0c 30 80 00       	mov    0x80300c,%al
  80060b:	0f b6 c0             	movzbl %al,%eax
  80060e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800611:	8b 12                	mov    (%edx),%edx
  800613:	89 d1                	mov    %edx,%ecx
  800615:	8b 55 0c             	mov    0xc(%ebp),%edx
  800618:	83 c2 08             	add    $0x8,%edx
  80061b:	83 ec 04             	sub    $0x4,%esp
  80061e:	50                   	push   %eax
  80061f:	51                   	push   %ecx
  800620:	52                   	push   %edx
  800621:	e8 3e 0e 00 00       	call   801464 <sys_cputs>
  800626:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800629:	8b 45 0c             	mov    0xc(%ebp),%eax
  80062c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800632:	8b 45 0c             	mov    0xc(%ebp),%eax
  800635:	8b 40 04             	mov    0x4(%eax),%eax
  800638:	8d 50 01             	lea    0x1(%eax),%edx
  80063b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80063e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800641:	90                   	nop
  800642:	c9                   	leave  
  800643:	c3                   	ret    

00800644 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800644:	55                   	push   %ebp
  800645:	89 e5                	mov    %esp,%ebp
  800647:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80064d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800654:	00 00 00 
	b.cnt = 0;
  800657:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80065e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800661:	ff 75 0c             	pushl  0xc(%ebp)
  800664:	ff 75 08             	pushl  0x8(%ebp)
  800667:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80066d:	50                   	push   %eax
  80066e:	68 db 05 80 00       	push   $0x8005db
  800673:	e8 11 02 00 00       	call   800889 <vprintfmt>
  800678:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80067b:	a0 0c 30 80 00       	mov    0x80300c,%al
  800680:	0f b6 c0             	movzbl %al,%eax
  800683:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800689:	83 ec 04             	sub    $0x4,%esp
  80068c:	50                   	push   %eax
  80068d:	52                   	push   %edx
  80068e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800694:	83 c0 08             	add    $0x8,%eax
  800697:	50                   	push   %eax
  800698:	e8 c7 0d 00 00       	call   801464 <sys_cputs>
  80069d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8006a0:	c6 05 0c 30 80 00 00 	movb   $0x0,0x80300c
	return b.cnt;
  8006a7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8006ad:	c9                   	leave  
  8006ae:	c3                   	ret    

008006af <cprintf>:

int cprintf(const char *fmt, ...) {
  8006af:	55                   	push   %ebp
  8006b0:	89 e5                	mov    %esp,%ebp
  8006b2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006b5:	c6 05 0c 30 80 00 01 	movb   $0x1,0x80300c
	va_start(ap, fmt);
  8006bc:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c5:	83 ec 08             	sub    $0x8,%esp
  8006c8:	ff 75 f4             	pushl  -0xc(%ebp)
  8006cb:	50                   	push   %eax
  8006cc:	e8 73 ff ff ff       	call   800644 <vcprintf>
  8006d1:	83 c4 10             	add    $0x10,%esp
  8006d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006da:	c9                   	leave  
  8006db:	c3                   	ret    

008006dc <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8006dc:	55                   	push   %ebp
  8006dd:	89 e5                	mov    %esp,%ebp
  8006df:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006e2:	e8 8e 0f 00 00       	call   801675 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006e7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f0:	83 ec 08             	sub    $0x8,%esp
  8006f3:	ff 75 f4             	pushl  -0xc(%ebp)
  8006f6:	50                   	push   %eax
  8006f7:	e8 48 ff ff ff       	call   800644 <vcprintf>
  8006fc:	83 c4 10             	add    $0x10,%esp
  8006ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800702:	e8 88 0f 00 00       	call   80168f <sys_enable_interrupt>
	return cnt;
  800707:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80070a:	c9                   	leave  
  80070b:	c3                   	ret    

0080070c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80070c:	55                   	push   %ebp
  80070d:	89 e5                	mov    %esp,%ebp
  80070f:	53                   	push   %ebx
  800710:	83 ec 14             	sub    $0x14,%esp
  800713:	8b 45 10             	mov    0x10(%ebp),%eax
  800716:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800719:	8b 45 14             	mov    0x14(%ebp),%eax
  80071c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80071f:	8b 45 18             	mov    0x18(%ebp),%eax
  800722:	ba 00 00 00 00       	mov    $0x0,%edx
  800727:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80072a:	77 55                	ja     800781 <printnum+0x75>
  80072c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80072f:	72 05                	jb     800736 <printnum+0x2a>
  800731:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800734:	77 4b                	ja     800781 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800736:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800739:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80073c:	8b 45 18             	mov    0x18(%ebp),%eax
  80073f:	ba 00 00 00 00       	mov    $0x0,%edx
  800744:	52                   	push   %edx
  800745:	50                   	push   %eax
  800746:	ff 75 f4             	pushl  -0xc(%ebp)
  800749:	ff 75 f0             	pushl  -0x10(%ebp)
  80074c:	e8 03 13 00 00       	call   801a54 <__udivdi3>
  800751:	83 c4 10             	add    $0x10,%esp
  800754:	83 ec 04             	sub    $0x4,%esp
  800757:	ff 75 20             	pushl  0x20(%ebp)
  80075a:	53                   	push   %ebx
  80075b:	ff 75 18             	pushl  0x18(%ebp)
  80075e:	52                   	push   %edx
  80075f:	50                   	push   %eax
  800760:	ff 75 0c             	pushl  0xc(%ebp)
  800763:	ff 75 08             	pushl  0x8(%ebp)
  800766:	e8 a1 ff ff ff       	call   80070c <printnum>
  80076b:	83 c4 20             	add    $0x20,%esp
  80076e:	eb 1a                	jmp    80078a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800770:	83 ec 08             	sub    $0x8,%esp
  800773:	ff 75 0c             	pushl  0xc(%ebp)
  800776:	ff 75 20             	pushl  0x20(%ebp)
  800779:	8b 45 08             	mov    0x8(%ebp),%eax
  80077c:	ff d0                	call   *%eax
  80077e:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800781:	ff 4d 1c             	decl   0x1c(%ebp)
  800784:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800788:	7f e6                	jg     800770 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80078a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80078d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800792:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800795:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800798:	53                   	push   %ebx
  800799:	51                   	push   %ecx
  80079a:	52                   	push   %edx
  80079b:	50                   	push   %eax
  80079c:	e8 c3 13 00 00       	call   801b64 <__umoddi3>
  8007a1:	83 c4 10             	add    $0x10,%esp
  8007a4:	05 f4 21 80 00       	add    $0x8021f4,%eax
  8007a9:	8a 00                	mov    (%eax),%al
  8007ab:	0f be c0             	movsbl %al,%eax
  8007ae:	83 ec 08             	sub    $0x8,%esp
  8007b1:	ff 75 0c             	pushl  0xc(%ebp)
  8007b4:	50                   	push   %eax
  8007b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b8:	ff d0                	call   *%eax
  8007ba:	83 c4 10             	add    $0x10,%esp
}
  8007bd:	90                   	nop
  8007be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007c1:	c9                   	leave  
  8007c2:	c3                   	ret    

008007c3 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007c3:	55                   	push   %ebp
  8007c4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007c6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007ca:	7e 1c                	jle    8007e8 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cf:	8b 00                	mov    (%eax),%eax
  8007d1:	8d 50 08             	lea    0x8(%eax),%edx
  8007d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d7:	89 10                	mov    %edx,(%eax)
  8007d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dc:	8b 00                	mov    (%eax),%eax
  8007de:	83 e8 08             	sub    $0x8,%eax
  8007e1:	8b 50 04             	mov    0x4(%eax),%edx
  8007e4:	8b 00                	mov    (%eax),%eax
  8007e6:	eb 40                	jmp    800828 <getuint+0x65>
	else if (lflag)
  8007e8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007ec:	74 1e                	je     80080c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f1:	8b 00                	mov    (%eax),%eax
  8007f3:	8d 50 04             	lea    0x4(%eax),%edx
  8007f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f9:	89 10                	mov    %edx,(%eax)
  8007fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fe:	8b 00                	mov    (%eax),%eax
  800800:	83 e8 04             	sub    $0x4,%eax
  800803:	8b 00                	mov    (%eax),%eax
  800805:	ba 00 00 00 00       	mov    $0x0,%edx
  80080a:	eb 1c                	jmp    800828 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80080c:	8b 45 08             	mov    0x8(%ebp),%eax
  80080f:	8b 00                	mov    (%eax),%eax
  800811:	8d 50 04             	lea    0x4(%eax),%edx
  800814:	8b 45 08             	mov    0x8(%ebp),%eax
  800817:	89 10                	mov    %edx,(%eax)
  800819:	8b 45 08             	mov    0x8(%ebp),%eax
  80081c:	8b 00                	mov    (%eax),%eax
  80081e:	83 e8 04             	sub    $0x4,%eax
  800821:	8b 00                	mov    (%eax),%eax
  800823:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800828:	5d                   	pop    %ebp
  800829:	c3                   	ret    

0080082a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80082a:	55                   	push   %ebp
  80082b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80082d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800831:	7e 1c                	jle    80084f <getint+0x25>
		return va_arg(*ap, long long);
  800833:	8b 45 08             	mov    0x8(%ebp),%eax
  800836:	8b 00                	mov    (%eax),%eax
  800838:	8d 50 08             	lea    0x8(%eax),%edx
  80083b:	8b 45 08             	mov    0x8(%ebp),%eax
  80083e:	89 10                	mov    %edx,(%eax)
  800840:	8b 45 08             	mov    0x8(%ebp),%eax
  800843:	8b 00                	mov    (%eax),%eax
  800845:	83 e8 08             	sub    $0x8,%eax
  800848:	8b 50 04             	mov    0x4(%eax),%edx
  80084b:	8b 00                	mov    (%eax),%eax
  80084d:	eb 38                	jmp    800887 <getint+0x5d>
	else if (lflag)
  80084f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800853:	74 1a                	je     80086f <getint+0x45>
		return va_arg(*ap, long);
  800855:	8b 45 08             	mov    0x8(%ebp),%eax
  800858:	8b 00                	mov    (%eax),%eax
  80085a:	8d 50 04             	lea    0x4(%eax),%edx
  80085d:	8b 45 08             	mov    0x8(%ebp),%eax
  800860:	89 10                	mov    %edx,(%eax)
  800862:	8b 45 08             	mov    0x8(%ebp),%eax
  800865:	8b 00                	mov    (%eax),%eax
  800867:	83 e8 04             	sub    $0x4,%eax
  80086a:	8b 00                	mov    (%eax),%eax
  80086c:	99                   	cltd   
  80086d:	eb 18                	jmp    800887 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80086f:	8b 45 08             	mov    0x8(%ebp),%eax
  800872:	8b 00                	mov    (%eax),%eax
  800874:	8d 50 04             	lea    0x4(%eax),%edx
  800877:	8b 45 08             	mov    0x8(%ebp),%eax
  80087a:	89 10                	mov    %edx,(%eax)
  80087c:	8b 45 08             	mov    0x8(%ebp),%eax
  80087f:	8b 00                	mov    (%eax),%eax
  800881:	83 e8 04             	sub    $0x4,%eax
  800884:	8b 00                	mov    (%eax),%eax
  800886:	99                   	cltd   
}
  800887:	5d                   	pop    %ebp
  800888:	c3                   	ret    

00800889 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800889:	55                   	push   %ebp
  80088a:	89 e5                	mov    %esp,%ebp
  80088c:	56                   	push   %esi
  80088d:	53                   	push   %ebx
  80088e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800891:	eb 17                	jmp    8008aa <vprintfmt+0x21>
			if (ch == '\0')
  800893:	85 db                	test   %ebx,%ebx
  800895:	0f 84 af 03 00 00    	je     800c4a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80089b:	83 ec 08             	sub    $0x8,%esp
  80089e:	ff 75 0c             	pushl  0xc(%ebp)
  8008a1:	53                   	push   %ebx
  8008a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a5:	ff d0                	call   *%eax
  8008a7:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ad:	8d 50 01             	lea    0x1(%eax),%edx
  8008b0:	89 55 10             	mov    %edx,0x10(%ebp)
  8008b3:	8a 00                	mov    (%eax),%al
  8008b5:	0f b6 d8             	movzbl %al,%ebx
  8008b8:	83 fb 25             	cmp    $0x25,%ebx
  8008bb:	75 d6                	jne    800893 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008bd:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008c1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008c8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008cf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008d6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e0:	8d 50 01             	lea    0x1(%eax),%edx
  8008e3:	89 55 10             	mov    %edx,0x10(%ebp)
  8008e6:	8a 00                	mov    (%eax),%al
  8008e8:	0f b6 d8             	movzbl %al,%ebx
  8008eb:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008ee:	83 f8 55             	cmp    $0x55,%eax
  8008f1:	0f 87 2b 03 00 00    	ja     800c22 <vprintfmt+0x399>
  8008f7:	8b 04 85 18 22 80 00 	mov    0x802218(,%eax,4),%eax
  8008fe:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800900:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800904:	eb d7                	jmp    8008dd <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800906:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80090a:	eb d1                	jmp    8008dd <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80090c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800913:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800916:	89 d0                	mov    %edx,%eax
  800918:	c1 e0 02             	shl    $0x2,%eax
  80091b:	01 d0                	add    %edx,%eax
  80091d:	01 c0                	add    %eax,%eax
  80091f:	01 d8                	add    %ebx,%eax
  800921:	83 e8 30             	sub    $0x30,%eax
  800924:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800927:	8b 45 10             	mov    0x10(%ebp),%eax
  80092a:	8a 00                	mov    (%eax),%al
  80092c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80092f:	83 fb 2f             	cmp    $0x2f,%ebx
  800932:	7e 3e                	jle    800972 <vprintfmt+0xe9>
  800934:	83 fb 39             	cmp    $0x39,%ebx
  800937:	7f 39                	jg     800972 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800939:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80093c:	eb d5                	jmp    800913 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80093e:	8b 45 14             	mov    0x14(%ebp),%eax
  800941:	83 c0 04             	add    $0x4,%eax
  800944:	89 45 14             	mov    %eax,0x14(%ebp)
  800947:	8b 45 14             	mov    0x14(%ebp),%eax
  80094a:	83 e8 04             	sub    $0x4,%eax
  80094d:	8b 00                	mov    (%eax),%eax
  80094f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800952:	eb 1f                	jmp    800973 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800954:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800958:	79 83                	jns    8008dd <vprintfmt+0x54>
				width = 0;
  80095a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800961:	e9 77 ff ff ff       	jmp    8008dd <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800966:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80096d:	e9 6b ff ff ff       	jmp    8008dd <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800972:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800973:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800977:	0f 89 60 ff ff ff    	jns    8008dd <vprintfmt+0x54>
				width = precision, precision = -1;
  80097d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800980:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800983:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80098a:	e9 4e ff ff ff       	jmp    8008dd <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80098f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800992:	e9 46 ff ff ff       	jmp    8008dd <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800997:	8b 45 14             	mov    0x14(%ebp),%eax
  80099a:	83 c0 04             	add    $0x4,%eax
  80099d:	89 45 14             	mov    %eax,0x14(%ebp)
  8009a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a3:	83 e8 04             	sub    $0x4,%eax
  8009a6:	8b 00                	mov    (%eax),%eax
  8009a8:	83 ec 08             	sub    $0x8,%esp
  8009ab:	ff 75 0c             	pushl  0xc(%ebp)
  8009ae:	50                   	push   %eax
  8009af:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b2:	ff d0                	call   *%eax
  8009b4:	83 c4 10             	add    $0x10,%esp
			break;
  8009b7:	e9 89 02 00 00       	jmp    800c45 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8009bf:	83 c0 04             	add    $0x4,%eax
  8009c2:	89 45 14             	mov    %eax,0x14(%ebp)
  8009c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009c8:	83 e8 04             	sub    $0x4,%eax
  8009cb:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009cd:	85 db                	test   %ebx,%ebx
  8009cf:	79 02                	jns    8009d3 <vprintfmt+0x14a>
				err = -err;
  8009d1:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8009d3:	83 fb 64             	cmp    $0x64,%ebx
  8009d6:	7f 0b                	jg     8009e3 <vprintfmt+0x15a>
  8009d8:	8b 34 9d 60 20 80 00 	mov    0x802060(,%ebx,4),%esi
  8009df:	85 f6                	test   %esi,%esi
  8009e1:	75 19                	jne    8009fc <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009e3:	53                   	push   %ebx
  8009e4:	68 05 22 80 00       	push   $0x802205
  8009e9:	ff 75 0c             	pushl  0xc(%ebp)
  8009ec:	ff 75 08             	pushl  0x8(%ebp)
  8009ef:	e8 5e 02 00 00       	call   800c52 <printfmt>
  8009f4:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009f7:	e9 49 02 00 00       	jmp    800c45 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009fc:	56                   	push   %esi
  8009fd:	68 0e 22 80 00       	push   $0x80220e
  800a02:	ff 75 0c             	pushl  0xc(%ebp)
  800a05:	ff 75 08             	pushl  0x8(%ebp)
  800a08:	e8 45 02 00 00       	call   800c52 <printfmt>
  800a0d:	83 c4 10             	add    $0x10,%esp
			break;
  800a10:	e9 30 02 00 00       	jmp    800c45 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a15:	8b 45 14             	mov    0x14(%ebp),%eax
  800a18:	83 c0 04             	add    $0x4,%eax
  800a1b:	89 45 14             	mov    %eax,0x14(%ebp)
  800a1e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a21:	83 e8 04             	sub    $0x4,%eax
  800a24:	8b 30                	mov    (%eax),%esi
  800a26:	85 f6                	test   %esi,%esi
  800a28:	75 05                	jne    800a2f <vprintfmt+0x1a6>
				p = "(null)";
  800a2a:	be 11 22 80 00       	mov    $0x802211,%esi
			if (width > 0 && padc != '-')
  800a2f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a33:	7e 6d                	jle    800aa2 <vprintfmt+0x219>
  800a35:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a39:	74 67                	je     800aa2 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a3b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a3e:	83 ec 08             	sub    $0x8,%esp
  800a41:	50                   	push   %eax
  800a42:	56                   	push   %esi
  800a43:	e8 0c 03 00 00       	call   800d54 <strnlen>
  800a48:	83 c4 10             	add    $0x10,%esp
  800a4b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a4e:	eb 16                	jmp    800a66 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a50:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a54:	83 ec 08             	sub    $0x8,%esp
  800a57:	ff 75 0c             	pushl  0xc(%ebp)
  800a5a:	50                   	push   %eax
  800a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5e:	ff d0                	call   *%eax
  800a60:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a63:	ff 4d e4             	decl   -0x1c(%ebp)
  800a66:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a6a:	7f e4                	jg     800a50 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a6c:	eb 34                	jmp    800aa2 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a6e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a72:	74 1c                	je     800a90 <vprintfmt+0x207>
  800a74:	83 fb 1f             	cmp    $0x1f,%ebx
  800a77:	7e 05                	jle    800a7e <vprintfmt+0x1f5>
  800a79:	83 fb 7e             	cmp    $0x7e,%ebx
  800a7c:	7e 12                	jle    800a90 <vprintfmt+0x207>
					putch('?', putdat);
  800a7e:	83 ec 08             	sub    $0x8,%esp
  800a81:	ff 75 0c             	pushl  0xc(%ebp)
  800a84:	6a 3f                	push   $0x3f
  800a86:	8b 45 08             	mov    0x8(%ebp),%eax
  800a89:	ff d0                	call   *%eax
  800a8b:	83 c4 10             	add    $0x10,%esp
  800a8e:	eb 0f                	jmp    800a9f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a90:	83 ec 08             	sub    $0x8,%esp
  800a93:	ff 75 0c             	pushl  0xc(%ebp)
  800a96:	53                   	push   %ebx
  800a97:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9a:	ff d0                	call   *%eax
  800a9c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a9f:	ff 4d e4             	decl   -0x1c(%ebp)
  800aa2:	89 f0                	mov    %esi,%eax
  800aa4:	8d 70 01             	lea    0x1(%eax),%esi
  800aa7:	8a 00                	mov    (%eax),%al
  800aa9:	0f be d8             	movsbl %al,%ebx
  800aac:	85 db                	test   %ebx,%ebx
  800aae:	74 24                	je     800ad4 <vprintfmt+0x24b>
  800ab0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ab4:	78 b8                	js     800a6e <vprintfmt+0x1e5>
  800ab6:	ff 4d e0             	decl   -0x20(%ebp)
  800ab9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800abd:	79 af                	jns    800a6e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800abf:	eb 13                	jmp    800ad4 <vprintfmt+0x24b>
				putch(' ', putdat);
  800ac1:	83 ec 08             	sub    $0x8,%esp
  800ac4:	ff 75 0c             	pushl  0xc(%ebp)
  800ac7:	6a 20                	push   $0x20
  800ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  800acc:	ff d0                	call   *%eax
  800ace:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ad1:	ff 4d e4             	decl   -0x1c(%ebp)
  800ad4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ad8:	7f e7                	jg     800ac1 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ada:	e9 66 01 00 00       	jmp    800c45 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800adf:	83 ec 08             	sub    $0x8,%esp
  800ae2:	ff 75 e8             	pushl  -0x18(%ebp)
  800ae5:	8d 45 14             	lea    0x14(%ebp),%eax
  800ae8:	50                   	push   %eax
  800ae9:	e8 3c fd ff ff       	call   80082a <getint>
  800aee:	83 c4 10             	add    $0x10,%esp
  800af1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800af4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800af7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800afa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800afd:	85 d2                	test   %edx,%edx
  800aff:	79 23                	jns    800b24 <vprintfmt+0x29b>
				putch('-', putdat);
  800b01:	83 ec 08             	sub    $0x8,%esp
  800b04:	ff 75 0c             	pushl  0xc(%ebp)
  800b07:	6a 2d                	push   $0x2d
  800b09:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0c:	ff d0                	call   *%eax
  800b0e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b11:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b14:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b17:	f7 d8                	neg    %eax
  800b19:	83 d2 00             	adc    $0x0,%edx
  800b1c:	f7 da                	neg    %edx
  800b1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b21:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b24:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b2b:	e9 bc 00 00 00       	jmp    800bec <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b30:	83 ec 08             	sub    $0x8,%esp
  800b33:	ff 75 e8             	pushl  -0x18(%ebp)
  800b36:	8d 45 14             	lea    0x14(%ebp),%eax
  800b39:	50                   	push   %eax
  800b3a:	e8 84 fc ff ff       	call   8007c3 <getuint>
  800b3f:	83 c4 10             	add    $0x10,%esp
  800b42:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b45:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b48:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b4f:	e9 98 00 00 00       	jmp    800bec <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b54:	83 ec 08             	sub    $0x8,%esp
  800b57:	ff 75 0c             	pushl  0xc(%ebp)
  800b5a:	6a 58                	push   $0x58
  800b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5f:	ff d0                	call   *%eax
  800b61:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b64:	83 ec 08             	sub    $0x8,%esp
  800b67:	ff 75 0c             	pushl  0xc(%ebp)
  800b6a:	6a 58                	push   $0x58
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6f:	ff d0                	call   *%eax
  800b71:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b74:	83 ec 08             	sub    $0x8,%esp
  800b77:	ff 75 0c             	pushl  0xc(%ebp)
  800b7a:	6a 58                	push   $0x58
  800b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7f:	ff d0                	call   *%eax
  800b81:	83 c4 10             	add    $0x10,%esp
			break;
  800b84:	e9 bc 00 00 00       	jmp    800c45 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b89:	83 ec 08             	sub    $0x8,%esp
  800b8c:	ff 75 0c             	pushl  0xc(%ebp)
  800b8f:	6a 30                	push   $0x30
  800b91:	8b 45 08             	mov    0x8(%ebp),%eax
  800b94:	ff d0                	call   *%eax
  800b96:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b99:	83 ec 08             	sub    $0x8,%esp
  800b9c:	ff 75 0c             	pushl  0xc(%ebp)
  800b9f:	6a 78                	push   $0x78
  800ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba4:	ff d0                	call   *%eax
  800ba6:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ba9:	8b 45 14             	mov    0x14(%ebp),%eax
  800bac:	83 c0 04             	add    $0x4,%eax
  800baf:	89 45 14             	mov    %eax,0x14(%ebp)
  800bb2:	8b 45 14             	mov    0x14(%ebp),%eax
  800bb5:	83 e8 04             	sub    $0x4,%eax
  800bb8:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800bba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bbd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800bc4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800bcb:	eb 1f                	jmp    800bec <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800bcd:	83 ec 08             	sub    $0x8,%esp
  800bd0:	ff 75 e8             	pushl  -0x18(%ebp)
  800bd3:	8d 45 14             	lea    0x14(%ebp),%eax
  800bd6:	50                   	push   %eax
  800bd7:	e8 e7 fb ff ff       	call   8007c3 <getuint>
  800bdc:	83 c4 10             	add    $0x10,%esp
  800bdf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800be2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800be5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bec:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800bf0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bf3:	83 ec 04             	sub    $0x4,%esp
  800bf6:	52                   	push   %edx
  800bf7:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bfa:	50                   	push   %eax
  800bfb:	ff 75 f4             	pushl  -0xc(%ebp)
  800bfe:	ff 75 f0             	pushl  -0x10(%ebp)
  800c01:	ff 75 0c             	pushl  0xc(%ebp)
  800c04:	ff 75 08             	pushl  0x8(%ebp)
  800c07:	e8 00 fb ff ff       	call   80070c <printnum>
  800c0c:	83 c4 20             	add    $0x20,%esp
			break;
  800c0f:	eb 34                	jmp    800c45 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c11:	83 ec 08             	sub    $0x8,%esp
  800c14:	ff 75 0c             	pushl  0xc(%ebp)
  800c17:	53                   	push   %ebx
  800c18:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1b:	ff d0                	call   *%eax
  800c1d:	83 c4 10             	add    $0x10,%esp
			break;
  800c20:	eb 23                	jmp    800c45 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c22:	83 ec 08             	sub    $0x8,%esp
  800c25:	ff 75 0c             	pushl  0xc(%ebp)
  800c28:	6a 25                	push   $0x25
  800c2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2d:	ff d0                	call   *%eax
  800c2f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c32:	ff 4d 10             	decl   0x10(%ebp)
  800c35:	eb 03                	jmp    800c3a <vprintfmt+0x3b1>
  800c37:	ff 4d 10             	decl   0x10(%ebp)
  800c3a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3d:	48                   	dec    %eax
  800c3e:	8a 00                	mov    (%eax),%al
  800c40:	3c 25                	cmp    $0x25,%al
  800c42:	75 f3                	jne    800c37 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c44:	90                   	nop
		}
	}
  800c45:	e9 47 fc ff ff       	jmp    800891 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c4a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c4b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c4e:	5b                   	pop    %ebx
  800c4f:	5e                   	pop    %esi
  800c50:	5d                   	pop    %ebp
  800c51:	c3                   	ret    

00800c52 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c52:	55                   	push   %ebp
  800c53:	89 e5                	mov    %esp,%ebp
  800c55:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c58:	8d 45 10             	lea    0x10(%ebp),%eax
  800c5b:	83 c0 04             	add    $0x4,%eax
  800c5e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c61:	8b 45 10             	mov    0x10(%ebp),%eax
  800c64:	ff 75 f4             	pushl  -0xc(%ebp)
  800c67:	50                   	push   %eax
  800c68:	ff 75 0c             	pushl  0xc(%ebp)
  800c6b:	ff 75 08             	pushl  0x8(%ebp)
  800c6e:	e8 16 fc ff ff       	call   800889 <vprintfmt>
  800c73:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c76:	90                   	nop
  800c77:	c9                   	leave  
  800c78:	c3                   	ret    

00800c79 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c79:	55                   	push   %ebp
  800c7a:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7f:	8b 40 08             	mov    0x8(%eax),%eax
  800c82:	8d 50 01             	lea    0x1(%eax),%edx
  800c85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c88:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8e:	8b 10                	mov    (%eax),%edx
  800c90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c93:	8b 40 04             	mov    0x4(%eax),%eax
  800c96:	39 c2                	cmp    %eax,%edx
  800c98:	73 12                	jae    800cac <sprintputch+0x33>
		*b->buf++ = ch;
  800c9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9d:	8b 00                	mov    (%eax),%eax
  800c9f:	8d 48 01             	lea    0x1(%eax),%ecx
  800ca2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ca5:	89 0a                	mov    %ecx,(%edx)
  800ca7:	8b 55 08             	mov    0x8(%ebp),%edx
  800caa:	88 10                	mov    %dl,(%eax)
}
  800cac:	90                   	nop
  800cad:	5d                   	pop    %ebp
  800cae:	c3                   	ret    

00800caf <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800caf:	55                   	push   %ebp
  800cb0:	89 e5                	mov    %esp,%ebp
  800cb2:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800cbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbe:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	01 d0                	add    %edx,%eax
  800cc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cc9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800cd0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800cd4:	74 06                	je     800cdc <vsnprintf+0x2d>
  800cd6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cda:	7f 07                	jg     800ce3 <vsnprintf+0x34>
		return -E_INVAL;
  800cdc:	b8 03 00 00 00       	mov    $0x3,%eax
  800ce1:	eb 20                	jmp    800d03 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ce3:	ff 75 14             	pushl  0x14(%ebp)
  800ce6:	ff 75 10             	pushl  0x10(%ebp)
  800ce9:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800cec:	50                   	push   %eax
  800ced:	68 79 0c 80 00       	push   $0x800c79
  800cf2:	e8 92 fb ff ff       	call   800889 <vprintfmt>
  800cf7:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cfa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cfd:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d00:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d03:	c9                   	leave  
  800d04:	c3                   	ret    

00800d05 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d05:	55                   	push   %ebp
  800d06:	89 e5                	mov    %esp,%ebp
  800d08:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d0b:	8d 45 10             	lea    0x10(%ebp),%eax
  800d0e:	83 c0 04             	add    $0x4,%eax
  800d11:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d14:	8b 45 10             	mov    0x10(%ebp),%eax
  800d17:	ff 75 f4             	pushl  -0xc(%ebp)
  800d1a:	50                   	push   %eax
  800d1b:	ff 75 0c             	pushl  0xc(%ebp)
  800d1e:	ff 75 08             	pushl  0x8(%ebp)
  800d21:	e8 89 ff ff ff       	call   800caf <vsnprintf>
  800d26:	83 c4 10             	add    $0x10,%esp
  800d29:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d2f:	c9                   	leave  
  800d30:	c3                   	ret    

00800d31 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d31:	55                   	push   %ebp
  800d32:	89 e5                	mov    %esp,%ebp
  800d34:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d37:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d3e:	eb 06                	jmp    800d46 <strlen+0x15>
		n++;
  800d40:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d43:	ff 45 08             	incl   0x8(%ebp)
  800d46:	8b 45 08             	mov    0x8(%ebp),%eax
  800d49:	8a 00                	mov    (%eax),%al
  800d4b:	84 c0                	test   %al,%al
  800d4d:	75 f1                	jne    800d40 <strlen+0xf>
		n++;
	return n;
  800d4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d52:	c9                   	leave  
  800d53:	c3                   	ret    

00800d54 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d54:	55                   	push   %ebp
  800d55:	89 e5                	mov    %esp,%ebp
  800d57:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d5a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d61:	eb 09                	jmp    800d6c <strnlen+0x18>
		n++;
  800d63:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d66:	ff 45 08             	incl   0x8(%ebp)
  800d69:	ff 4d 0c             	decl   0xc(%ebp)
  800d6c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d70:	74 09                	je     800d7b <strnlen+0x27>
  800d72:	8b 45 08             	mov    0x8(%ebp),%eax
  800d75:	8a 00                	mov    (%eax),%al
  800d77:	84 c0                	test   %al,%al
  800d79:	75 e8                	jne    800d63 <strnlen+0xf>
		n++;
	return n;
  800d7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d7e:	c9                   	leave  
  800d7f:	c3                   	ret    

00800d80 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d80:	55                   	push   %ebp
  800d81:	89 e5                	mov    %esp,%ebp
  800d83:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d86:	8b 45 08             	mov    0x8(%ebp),%eax
  800d89:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d8c:	90                   	nop
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	8d 50 01             	lea    0x1(%eax),%edx
  800d93:	89 55 08             	mov    %edx,0x8(%ebp)
  800d96:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d99:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d9c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d9f:	8a 12                	mov    (%edx),%dl
  800da1:	88 10                	mov    %dl,(%eax)
  800da3:	8a 00                	mov    (%eax),%al
  800da5:	84 c0                	test   %al,%al
  800da7:	75 e4                	jne    800d8d <strcpy+0xd>
		/* do nothing */;
	return ret;
  800da9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dac:	c9                   	leave  
  800dad:	c3                   	ret    

00800dae <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800dae:	55                   	push   %ebp
  800daf:	89 e5                	mov    %esp,%ebp
  800db1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800dba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dc1:	eb 1f                	jmp    800de2 <strncpy+0x34>
		*dst++ = *src;
  800dc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc6:	8d 50 01             	lea    0x1(%eax),%edx
  800dc9:	89 55 08             	mov    %edx,0x8(%ebp)
  800dcc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dcf:	8a 12                	mov    (%edx),%dl
  800dd1:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800dd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd6:	8a 00                	mov    (%eax),%al
  800dd8:	84 c0                	test   %al,%al
  800dda:	74 03                	je     800ddf <strncpy+0x31>
			src++;
  800ddc:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ddf:	ff 45 fc             	incl   -0x4(%ebp)
  800de2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de5:	3b 45 10             	cmp    0x10(%ebp),%eax
  800de8:	72 d9                	jb     800dc3 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800dea:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ded:	c9                   	leave  
  800dee:	c3                   	ret    

00800def <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800def:	55                   	push   %ebp
  800df0:	89 e5                	mov    %esp,%ebp
  800df2:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800df5:	8b 45 08             	mov    0x8(%ebp),%eax
  800df8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dfb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dff:	74 30                	je     800e31 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e01:	eb 16                	jmp    800e19 <strlcpy+0x2a>
			*dst++ = *src++;
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	8d 50 01             	lea    0x1(%eax),%edx
  800e09:	89 55 08             	mov    %edx,0x8(%ebp)
  800e0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e0f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e12:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e15:	8a 12                	mov    (%edx),%dl
  800e17:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e19:	ff 4d 10             	decl   0x10(%ebp)
  800e1c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e20:	74 09                	je     800e2b <strlcpy+0x3c>
  800e22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e25:	8a 00                	mov    (%eax),%al
  800e27:	84 c0                	test   %al,%al
  800e29:	75 d8                	jne    800e03 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e31:	8b 55 08             	mov    0x8(%ebp),%edx
  800e34:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e37:	29 c2                	sub    %eax,%edx
  800e39:	89 d0                	mov    %edx,%eax
}
  800e3b:	c9                   	leave  
  800e3c:	c3                   	ret    

00800e3d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e3d:	55                   	push   %ebp
  800e3e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e40:	eb 06                	jmp    800e48 <strcmp+0xb>
		p++, q++;
  800e42:	ff 45 08             	incl   0x8(%ebp)
  800e45:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	8a 00                	mov    (%eax),%al
  800e4d:	84 c0                	test   %al,%al
  800e4f:	74 0e                	je     800e5f <strcmp+0x22>
  800e51:	8b 45 08             	mov    0x8(%ebp),%eax
  800e54:	8a 10                	mov    (%eax),%dl
  800e56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e59:	8a 00                	mov    (%eax),%al
  800e5b:	38 c2                	cmp    %al,%dl
  800e5d:	74 e3                	je     800e42 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e62:	8a 00                	mov    (%eax),%al
  800e64:	0f b6 d0             	movzbl %al,%edx
  800e67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6a:	8a 00                	mov    (%eax),%al
  800e6c:	0f b6 c0             	movzbl %al,%eax
  800e6f:	29 c2                	sub    %eax,%edx
  800e71:	89 d0                	mov    %edx,%eax
}
  800e73:	5d                   	pop    %ebp
  800e74:	c3                   	ret    

00800e75 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e75:	55                   	push   %ebp
  800e76:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e78:	eb 09                	jmp    800e83 <strncmp+0xe>
		n--, p++, q++;
  800e7a:	ff 4d 10             	decl   0x10(%ebp)
  800e7d:	ff 45 08             	incl   0x8(%ebp)
  800e80:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e83:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e87:	74 17                	je     800ea0 <strncmp+0x2b>
  800e89:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8c:	8a 00                	mov    (%eax),%al
  800e8e:	84 c0                	test   %al,%al
  800e90:	74 0e                	je     800ea0 <strncmp+0x2b>
  800e92:	8b 45 08             	mov    0x8(%ebp),%eax
  800e95:	8a 10                	mov    (%eax),%dl
  800e97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9a:	8a 00                	mov    (%eax),%al
  800e9c:	38 c2                	cmp    %al,%dl
  800e9e:	74 da                	je     800e7a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ea0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ea4:	75 07                	jne    800ead <strncmp+0x38>
		return 0;
  800ea6:	b8 00 00 00 00       	mov    $0x0,%eax
  800eab:	eb 14                	jmp    800ec1 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ead:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb0:	8a 00                	mov    (%eax),%al
  800eb2:	0f b6 d0             	movzbl %al,%edx
  800eb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb8:	8a 00                	mov    (%eax),%al
  800eba:	0f b6 c0             	movzbl %al,%eax
  800ebd:	29 c2                	sub    %eax,%edx
  800ebf:	89 d0                	mov    %edx,%eax
}
  800ec1:	5d                   	pop    %ebp
  800ec2:	c3                   	ret    

00800ec3 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ec3:	55                   	push   %ebp
  800ec4:	89 e5                	mov    %esp,%ebp
  800ec6:	83 ec 04             	sub    $0x4,%esp
  800ec9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ecf:	eb 12                	jmp    800ee3 <strchr+0x20>
		if (*s == c)
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed4:	8a 00                	mov    (%eax),%al
  800ed6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ed9:	75 05                	jne    800ee0 <strchr+0x1d>
			return (char *) s;
  800edb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ede:	eb 11                	jmp    800ef1 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ee0:	ff 45 08             	incl   0x8(%ebp)
  800ee3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee6:	8a 00                	mov    (%eax),%al
  800ee8:	84 c0                	test   %al,%al
  800eea:	75 e5                	jne    800ed1 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800eec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ef1:	c9                   	leave  
  800ef2:	c3                   	ret    

00800ef3 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ef3:	55                   	push   %ebp
  800ef4:	89 e5                	mov    %esp,%ebp
  800ef6:	83 ec 04             	sub    $0x4,%esp
  800ef9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800eff:	eb 0d                	jmp    800f0e <strfind+0x1b>
		if (*s == c)
  800f01:	8b 45 08             	mov    0x8(%ebp),%eax
  800f04:	8a 00                	mov    (%eax),%al
  800f06:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f09:	74 0e                	je     800f19 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f0b:	ff 45 08             	incl   0x8(%ebp)
  800f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f11:	8a 00                	mov    (%eax),%al
  800f13:	84 c0                	test   %al,%al
  800f15:	75 ea                	jne    800f01 <strfind+0xe>
  800f17:	eb 01                	jmp    800f1a <strfind+0x27>
		if (*s == c)
			break;
  800f19:	90                   	nop
	return (char *) s;
  800f1a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f1d:	c9                   	leave  
  800f1e:	c3                   	ret    

00800f1f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f1f:	55                   	push   %ebp
  800f20:	89 e5                	mov    %esp,%ebp
  800f22:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
  800f28:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f31:	eb 0e                	jmp    800f41 <memset+0x22>
		*p++ = c;
  800f33:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f36:	8d 50 01             	lea    0x1(%eax),%edx
  800f39:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f3f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f41:	ff 4d f8             	decl   -0x8(%ebp)
  800f44:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f48:	79 e9                	jns    800f33 <memset+0x14>
		*p++ = c;

	return v;
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f4d:	c9                   	leave  
  800f4e:	c3                   	ret    

00800f4f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f4f:	55                   	push   %ebp
  800f50:	89 e5                	mov    %esp,%ebp
  800f52:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f58:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f61:	eb 16                	jmp    800f79 <memcpy+0x2a>
		*d++ = *s++;
  800f63:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f66:	8d 50 01             	lea    0x1(%eax),%edx
  800f69:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f6c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f6f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f72:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f75:	8a 12                	mov    (%edx),%dl
  800f77:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f79:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f7f:	89 55 10             	mov    %edx,0x10(%ebp)
  800f82:	85 c0                	test   %eax,%eax
  800f84:	75 dd                	jne    800f63 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f89:	c9                   	leave  
  800f8a:	c3                   	ret    

00800f8b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f8b:	55                   	push   %ebp
  800f8c:	89 e5                	mov    %esp,%ebp
  800f8e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800f91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f94:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fa3:	73 50                	jae    800ff5 <memmove+0x6a>
  800fa5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fa8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fab:	01 d0                	add    %edx,%eax
  800fad:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fb0:	76 43                	jbe    800ff5 <memmove+0x6a>
		s += n;
  800fb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800fb8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbb:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800fbe:	eb 10                	jmp    800fd0 <memmove+0x45>
			*--d = *--s;
  800fc0:	ff 4d f8             	decl   -0x8(%ebp)
  800fc3:	ff 4d fc             	decl   -0x4(%ebp)
  800fc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fc9:	8a 10                	mov    (%eax),%dl
  800fcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fce:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fd0:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fd6:	89 55 10             	mov    %edx,0x10(%ebp)
  800fd9:	85 c0                	test   %eax,%eax
  800fdb:	75 e3                	jne    800fc0 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fdd:	eb 23                	jmp    801002 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fdf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe2:	8d 50 01             	lea    0x1(%eax),%edx
  800fe5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fe8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800feb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fee:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ff1:	8a 12                	mov    (%edx),%dl
  800ff3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ff5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ffb:	89 55 10             	mov    %edx,0x10(%ebp)
  800ffe:	85 c0                	test   %eax,%eax
  801000:	75 dd                	jne    800fdf <memmove+0x54>
			*d++ = *s++;

	return dst;
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801005:	c9                   	leave  
  801006:	c3                   	ret    

00801007 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801007:	55                   	push   %ebp
  801008:	89 e5                	mov    %esp,%ebp
  80100a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80100d:	8b 45 08             	mov    0x8(%ebp),%eax
  801010:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801013:	8b 45 0c             	mov    0xc(%ebp),%eax
  801016:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801019:	eb 2a                	jmp    801045 <memcmp+0x3e>
		if (*s1 != *s2)
  80101b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80101e:	8a 10                	mov    (%eax),%dl
  801020:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801023:	8a 00                	mov    (%eax),%al
  801025:	38 c2                	cmp    %al,%dl
  801027:	74 16                	je     80103f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801029:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80102c:	8a 00                	mov    (%eax),%al
  80102e:	0f b6 d0             	movzbl %al,%edx
  801031:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801034:	8a 00                	mov    (%eax),%al
  801036:	0f b6 c0             	movzbl %al,%eax
  801039:	29 c2                	sub    %eax,%edx
  80103b:	89 d0                	mov    %edx,%eax
  80103d:	eb 18                	jmp    801057 <memcmp+0x50>
		s1++, s2++;
  80103f:	ff 45 fc             	incl   -0x4(%ebp)
  801042:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801045:	8b 45 10             	mov    0x10(%ebp),%eax
  801048:	8d 50 ff             	lea    -0x1(%eax),%edx
  80104b:	89 55 10             	mov    %edx,0x10(%ebp)
  80104e:	85 c0                	test   %eax,%eax
  801050:	75 c9                	jne    80101b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801052:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801057:	c9                   	leave  
  801058:	c3                   	ret    

00801059 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801059:	55                   	push   %ebp
  80105a:	89 e5                	mov    %esp,%ebp
  80105c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80105f:	8b 55 08             	mov    0x8(%ebp),%edx
  801062:	8b 45 10             	mov    0x10(%ebp),%eax
  801065:	01 d0                	add    %edx,%eax
  801067:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80106a:	eb 15                	jmp    801081 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80106c:	8b 45 08             	mov    0x8(%ebp),%eax
  80106f:	8a 00                	mov    (%eax),%al
  801071:	0f b6 d0             	movzbl %al,%edx
  801074:	8b 45 0c             	mov    0xc(%ebp),%eax
  801077:	0f b6 c0             	movzbl %al,%eax
  80107a:	39 c2                	cmp    %eax,%edx
  80107c:	74 0d                	je     80108b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80107e:	ff 45 08             	incl   0x8(%ebp)
  801081:	8b 45 08             	mov    0x8(%ebp),%eax
  801084:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801087:	72 e3                	jb     80106c <memfind+0x13>
  801089:	eb 01                	jmp    80108c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80108b:	90                   	nop
	return (void *) s;
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80108f:	c9                   	leave  
  801090:	c3                   	ret    

00801091 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801091:	55                   	push   %ebp
  801092:	89 e5                	mov    %esp,%ebp
  801094:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801097:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80109e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010a5:	eb 03                	jmp    8010aa <strtol+0x19>
		s++;
  8010a7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ad:	8a 00                	mov    (%eax),%al
  8010af:	3c 20                	cmp    $0x20,%al
  8010b1:	74 f4                	je     8010a7 <strtol+0x16>
  8010b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b6:	8a 00                	mov    (%eax),%al
  8010b8:	3c 09                	cmp    $0x9,%al
  8010ba:	74 eb                	je     8010a7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bf:	8a 00                	mov    (%eax),%al
  8010c1:	3c 2b                	cmp    $0x2b,%al
  8010c3:	75 05                	jne    8010ca <strtol+0x39>
		s++;
  8010c5:	ff 45 08             	incl   0x8(%ebp)
  8010c8:	eb 13                	jmp    8010dd <strtol+0x4c>
	else if (*s == '-')
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	8a 00                	mov    (%eax),%al
  8010cf:	3c 2d                	cmp    $0x2d,%al
  8010d1:	75 0a                	jne    8010dd <strtol+0x4c>
		s++, neg = 1;
  8010d3:	ff 45 08             	incl   0x8(%ebp)
  8010d6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e1:	74 06                	je     8010e9 <strtol+0x58>
  8010e3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010e7:	75 20                	jne    801109 <strtol+0x78>
  8010e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ec:	8a 00                	mov    (%eax),%al
  8010ee:	3c 30                	cmp    $0x30,%al
  8010f0:	75 17                	jne    801109 <strtol+0x78>
  8010f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f5:	40                   	inc    %eax
  8010f6:	8a 00                	mov    (%eax),%al
  8010f8:	3c 78                	cmp    $0x78,%al
  8010fa:	75 0d                	jne    801109 <strtol+0x78>
		s += 2, base = 16;
  8010fc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801100:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801107:	eb 28                	jmp    801131 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801109:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80110d:	75 15                	jne    801124 <strtol+0x93>
  80110f:	8b 45 08             	mov    0x8(%ebp),%eax
  801112:	8a 00                	mov    (%eax),%al
  801114:	3c 30                	cmp    $0x30,%al
  801116:	75 0c                	jne    801124 <strtol+0x93>
		s++, base = 8;
  801118:	ff 45 08             	incl   0x8(%ebp)
  80111b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801122:	eb 0d                	jmp    801131 <strtol+0xa0>
	else if (base == 0)
  801124:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801128:	75 07                	jne    801131 <strtol+0xa0>
		base = 10;
  80112a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801131:	8b 45 08             	mov    0x8(%ebp),%eax
  801134:	8a 00                	mov    (%eax),%al
  801136:	3c 2f                	cmp    $0x2f,%al
  801138:	7e 19                	jle    801153 <strtol+0xc2>
  80113a:	8b 45 08             	mov    0x8(%ebp),%eax
  80113d:	8a 00                	mov    (%eax),%al
  80113f:	3c 39                	cmp    $0x39,%al
  801141:	7f 10                	jg     801153 <strtol+0xc2>
			dig = *s - '0';
  801143:	8b 45 08             	mov    0x8(%ebp),%eax
  801146:	8a 00                	mov    (%eax),%al
  801148:	0f be c0             	movsbl %al,%eax
  80114b:	83 e8 30             	sub    $0x30,%eax
  80114e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801151:	eb 42                	jmp    801195 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801153:	8b 45 08             	mov    0x8(%ebp),%eax
  801156:	8a 00                	mov    (%eax),%al
  801158:	3c 60                	cmp    $0x60,%al
  80115a:	7e 19                	jle    801175 <strtol+0xe4>
  80115c:	8b 45 08             	mov    0x8(%ebp),%eax
  80115f:	8a 00                	mov    (%eax),%al
  801161:	3c 7a                	cmp    $0x7a,%al
  801163:	7f 10                	jg     801175 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801165:	8b 45 08             	mov    0x8(%ebp),%eax
  801168:	8a 00                	mov    (%eax),%al
  80116a:	0f be c0             	movsbl %al,%eax
  80116d:	83 e8 57             	sub    $0x57,%eax
  801170:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801173:	eb 20                	jmp    801195 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801175:	8b 45 08             	mov    0x8(%ebp),%eax
  801178:	8a 00                	mov    (%eax),%al
  80117a:	3c 40                	cmp    $0x40,%al
  80117c:	7e 39                	jle    8011b7 <strtol+0x126>
  80117e:	8b 45 08             	mov    0x8(%ebp),%eax
  801181:	8a 00                	mov    (%eax),%al
  801183:	3c 5a                	cmp    $0x5a,%al
  801185:	7f 30                	jg     8011b7 <strtol+0x126>
			dig = *s - 'A' + 10;
  801187:	8b 45 08             	mov    0x8(%ebp),%eax
  80118a:	8a 00                	mov    (%eax),%al
  80118c:	0f be c0             	movsbl %al,%eax
  80118f:	83 e8 37             	sub    $0x37,%eax
  801192:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801195:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801198:	3b 45 10             	cmp    0x10(%ebp),%eax
  80119b:	7d 19                	jge    8011b6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80119d:	ff 45 08             	incl   0x8(%ebp)
  8011a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a3:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011a7:	89 c2                	mov    %eax,%edx
  8011a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011ac:	01 d0                	add    %edx,%eax
  8011ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011b1:	e9 7b ff ff ff       	jmp    801131 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011b6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011b7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011bb:	74 08                	je     8011c5 <strtol+0x134>
		*endptr = (char *) s;
  8011bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c0:	8b 55 08             	mov    0x8(%ebp),%edx
  8011c3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011c5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011c9:	74 07                	je     8011d2 <strtol+0x141>
  8011cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ce:	f7 d8                	neg    %eax
  8011d0:	eb 03                	jmp    8011d5 <strtol+0x144>
  8011d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011d5:	c9                   	leave  
  8011d6:	c3                   	ret    

008011d7 <ltostr>:

void
ltostr(long value, char *str)
{
  8011d7:	55                   	push   %ebp
  8011d8:	89 e5                	mov    %esp,%ebp
  8011da:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011e4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011eb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011ef:	79 13                	jns    801204 <ltostr+0x2d>
	{
		neg = 1;
  8011f1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011fe:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801201:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801204:	8b 45 08             	mov    0x8(%ebp),%eax
  801207:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80120c:	99                   	cltd   
  80120d:	f7 f9                	idiv   %ecx
  80120f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801212:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801215:	8d 50 01             	lea    0x1(%eax),%edx
  801218:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80121b:	89 c2                	mov    %eax,%edx
  80121d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801220:	01 d0                	add    %edx,%eax
  801222:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801225:	83 c2 30             	add    $0x30,%edx
  801228:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80122a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80122d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801232:	f7 e9                	imul   %ecx
  801234:	c1 fa 02             	sar    $0x2,%edx
  801237:	89 c8                	mov    %ecx,%eax
  801239:	c1 f8 1f             	sar    $0x1f,%eax
  80123c:	29 c2                	sub    %eax,%edx
  80123e:	89 d0                	mov    %edx,%eax
  801240:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801243:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801246:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80124b:	f7 e9                	imul   %ecx
  80124d:	c1 fa 02             	sar    $0x2,%edx
  801250:	89 c8                	mov    %ecx,%eax
  801252:	c1 f8 1f             	sar    $0x1f,%eax
  801255:	29 c2                	sub    %eax,%edx
  801257:	89 d0                	mov    %edx,%eax
  801259:	c1 e0 02             	shl    $0x2,%eax
  80125c:	01 d0                	add    %edx,%eax
  80125e:	01 c0                	add    %eax,%eax
  801260:	29 c1                	sub    %eax,%ecx
  801262:	89 ca                	mov    %ecx,%edx
  801264:	85 d2                	test   %edx,%edx
  801266:	75 9c                	jne    801204 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801268:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80126f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801272:	48                   	dec    %eax
  801273:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801276:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80127a:	74 3d                	je     8012b9 <ltostr+0xe2>
		start = 1 ;
  80127c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801283:	eb 34                	jmp    8012b9 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801285:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801288:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128b:	01 d0                	add    %edx,%eax
  80128d:	8a 00                	mov    (%eax),%al
  80128f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801292:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801295:	8b 45 0c             	mov    0xc(%ebp),%eax
  801298:	01 c2                	add    %eax,%edx
  80129a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80129d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a0:	01 c8                	add    %ecx,%eax
  8012a2:	8a 00                	mov    (%eax),%al
  8012a4:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012a6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ac:	01 c2                	add    %eax,%edx
  8012ae:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012b1:	88 02                	mov    %al,(%edx)
		start++ ;
  8012b3:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012b6:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012bc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012bf:	7c c4                	jl     801285 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012c1:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c7:	01 d0                	add    %edx,%eax
  8012c9:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012cc:	90                   	nop
  8012cd:	c9                   	leave  
  8012ce:	c3                   	ret    

008012cf <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012cf:	55                   	push   %ebp
  8012d0:	89 e5                	mov    %esp,%ebp
  8012d2:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012d5:	ff 75 08             	pushl  0x8(%ebp)
  8012d8:	e8 54 fa ff ff       	call   800d31 <strlen>
  8012dd:	83 c4 04             	add    $0x4,%esp
  8012e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012e3:	ff 75 0c             	pushl  0xc(%ebp)
  8012e6:	e8 46 fa ff ff       	call   800d31 <strlen>
  8012eb:	83 c4 04             	add    $0x4,%esp
  8012ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012f1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012ff:	eb 17                	jmp    801318 <strcconcat+0x49>
		final[s] = str1[s] ;
  801301:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801304:	8b 45 10             	mov    0x10(%ebp),%eax
  801307:	01 c2                	add    %eax,%edx
  801309:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80130c:	8b 45 08             	mov    0x8(%ebp),%eax
  80130f:	01 c8                	add    %ecx,%eax
  801311:	8a 00                	mov    (%eax),%al
  801313:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801315:	ff 45 fc             	incl   -0x4(%ebp)
  801318:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80131b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80131e:	7c e1                	jl     801301 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801320:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801327:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80132e:	eb 1f                	jmp    80134f <strcconcat+0x80>
		final[s++] = str2[i] ;
  801330:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801333:	8d 50 01             	lea    0x1(%eax),%edx
  801336:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801339:	89 c2                	mov    %eax,%edx
  80133b:	8b 45 10             	mov    0x10(%ebp),%eax
  80133e:	01 c2                	add    %eax,%edx
  801340:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801343:	8b 45 0c             	mov    0xc(%ebp),%eax
  801346:	01 c8                	add    %ecx,%eax
  801348:	8a 00                	mov    (%eax),%al
  80134a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80134c:	ff 45 f8             	incl   -0x8(%ebp)
  80134f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801352:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801355:	7c d9                	jl     801330 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801357:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80135a:	8b 45 10             	mov    0x10(%ebp),%eax
  80135d:	01 d0                	add    %edx,%eax
  80135f:	c6 00 00             	movb   $0x0,(%eax)
}
  801362:	90                   	nop
  801363:	c9                   	leave  
  801364:	c3                   	ret    

00801365 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801365:	55                   	push   %ebp
  801366:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801368:	8b 45 14             	mov    0x14(%ebp),%eax
  80136b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801371:	8b 45 14             	mov    0x14(%ebp),%eax
  801374:	8b 00                	mov    (%eax),%eax
  801376:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80137d:	8b 45 10             	mov    0x10(%ebp),%eax
  801380:	01 d0                	add    %edx,%eax
  801382:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801388:	eb 0c                	jmp    801396 <strsplit+0x31>
			*string++ = 0;
  80138a:	8b 45 08             	mov    0x8(%ebp),%eax
  80138d:	8d 50 01             	lea    0x1(%eax),%edx
  801390:	89 55 08             	mov    %edx,0x8(%ebp)
  801393:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
  801399:	8a 00                	mov    (%eax),%al
  80139b:	84 c0                	test   %al,%al
  80139d:	74 18                	je     8013b7 <strsplit+0x52>
  80139f:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a2:	8a 00                	mov    (%eax),%al
  8013a4:	0f be c0             	movsbl %al,%eax
  8013a7:	50                   	push   %eax
  8013a8:	ff 75 0c             	pushl  0xc(%ebp)
  8013ab:	e8 13 fb ff ff       	call   800ec3 <strchr>
  8013b0:	83 c4 08             	add    $0x8,%esp
  8013b3:	85 c0                	test   %eax,%eax
  8013b5:	75 d3                	jne    80138a <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8013b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ba:	8a 00                	mov    (%eax),%al
  8013bc:	84 c0                	test   %al,%al
  8013be:	74 5a                	je     80141a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8013c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8013c3:	8b 00                	mov    (%eax),%eax
  8013c5:	83 f8 0f             	cmp    $0xf,%eax
  8013c8:	75 07                	jne    8013d1 <strsplit+0x6c>
		{
			return 0;
  8013ca:	b8 00 00 00 00       	mov    $0x0,%eax
  8013cf:	eb 66                	jmp    801437 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d4:	8b 00                	mov    (%eax),%eax
  8013d6:	8d 48 01             	lea    0x1(%eax),%ecx
  8013d9:	8b 55 14             	mov    0x14(%ebp),%edx
  8013dc:	89 0a                	mov    %ecx,(%edx)
  8013de:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e8:	01 c2                	add    %eax,%edx
  8013ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ed:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013ef:	eb 03                	jmp    8013f4 <strsplit+0x8f>
			string++;
  8013f1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	8a 00                	mov    (%eax),%al
  8013f9:	84 c0                	test   %al,%al
  8013fb:	74 8b                	je     801388 <strsplit+0x23>
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	8a 00                	mov    (%eax),%al
  801402:	0f be c0             	movsbl %al,%eax
  801405:	50                   	push   %eax
  801406:	ff 75 0c             	pushl  0xc(%ebp)
  801409:	e8 b5 fa ff ff       	call   800ec3 <strchr>
  80140e:	83 c4 08             	add    $0x8,%esp
  801411:	85 c0                	test   %eax,%eax
  801413:	74 dc                	je     8013f1 <strsplit+0x8c>
			string++;
	}
  801415:	e9 6e ff ff ff       	jmp    801388 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80141a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80141b:	8b 45 14             	mov    0x14(%ebp),%eax
  80141e:	8b 00                	mov    (%eax),%eax
  801420:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801427:	8b 45 10             	mov    0x10(%ebp),%eax
  80142a:	01 d0                	add    %edx,%eax
  80142c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801432:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801437:	c9                   	leave  
  801438:	c3                   	ret    

00801439 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801439:	55                   	push   %ebp
  80143a:	89 e5                	mov    %esp,%ebp
  80143c:	57                   	push   %edi
  80143d:	56                   	push   %esi
  80143e:	53                   	push   %ebx
  80143f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
  801445:	8b 55 0c             	mov    0xc(%ebp),%edx
  801448:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80144b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80144e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801451:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801454:	cd 30                	int    $0x30
  801456:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801459:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80145c:	83 c4 10             	add    $0x10,%esp
  80145f:	5b                   	pop    %ebx
  801460:	5e                   	pop    %esi
  801461:	5f                   	pop    %edi
  801462:	5d                   	pop    %ebp
  801463:	c3                   	ret    

00801464 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801464:	55                   	push   %ebp
  801465:	89 e5                	mov    %esp,%ebp
  801467:	83 ec 04             	sub    $0x4,%esp
  80146a:	8b 45 10             	mov    0x10(%ebp),%eax
  80146d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801470:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801474:	8b 45 08             	mov    0x8(%ebp),%eax
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	52                   	push   %edx
  80147c:	ff 75 0c             	pushl  0xc(%ebp)
  80147f:	50                   	push   %eax
  801480:	6a 00                	push   $0x0
  801482:	e8 b2 ff ff ff       	call   801439 <syscall>
  801487:	83 c4 18             	add    $0x18,%esp
}
  80148a:	90                   	nop
  80148b:	c9                   	leave  
  80148c:	c3                   	ret    

0080148d <sys_cgetc>:

int
sys_cgetc(void)
{
  80148d:	55                   	push   %ebp
  80148e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 01                	push   $0x1
  80149c:	e8 98 ff ff ff       	call   801439 <syscall>
  8014a1:	83 c4 18             	add    $0x18,%esp
}
  8014a4:	c9                   	leave  
  8014a5:	c3                   	ret    

008014a6 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8014a6:	55                   	push   %ebp
  8014a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8014a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	50                   	push   %eax
  8014b5:	6a 05                	push   $0x5
  8014b7:	e8 7d ff ff ff       	call   801439 <syscall>
  8014bc:	83 c4 18             	add    $0x18,%esp
}
  8014bf:	c9                   	leave  
  8014c0:	c3                   	ret    

008014c1 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8014c1:	55                   	push   %ebp
  8014c2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 02                	push   $0x2
  8014d0:	e8 64 ff ff ff       	call   801439 <syscall>
  8014d5:	83 c4 18             	add    $0x18,%esp
}
  8014d8:	c9                   	leave  
  8014d9:	c3                   	ret    

008014da <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8014da:	55                   	push   %ebp
  8014db:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 03                	push   $0x3
  8014e9:	e8 4b ff ff ff       	call   801439 <syscall>
  8014ee:	83 c4 18             	add    $0x18,%esp
}
  8014f1:	c9                   	leave  
  8014f2:	c3                   	ret    

008014f3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8014f3:	55                   	push   %ebp
  8014f4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 04                	push   $0x4
  801502:	e8 32 ff ff ff       	call   801439 <syscall>
  801507:	83 c4 18             	add    $0x18,%esp
}
  80150a:	c9                   	leave  
  80150b:	c3                   	ret    

0080150c <sys_env_exit>:


void sys_env_exit(void)
{
  80150c:	55                   	push   %ebp
  80150d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 06                	push   $0x6
  80151b:	e8 19 ff ff ff       	call   801439 <syscall>
  801520:	83 c4 18             	add    $0x18,%esp
}
  801523:	90                   	nop
  801524:	c9                   	leave  
  801525:	c3                   	ret    

00801526 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801526:	55                   	push   %ebp
  801527:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801529:	8b 55 0c             	mov    0xc(%ebp),%edx
  80152c:	8b 45 08             	mov    0x8(%ebp),%eax
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	52                   	push   %edx
  801536:	50                   	push   %eax
  801537:	6a 07                	push   $0x7
  801539:	e8 fb fe ff ff       	call   801439 <syscall>
  80153e:	83 c4 18             	add    $0x18,%esp
}
  801541:	c9                   	leave  
  801542:	c3                   	ret    

00801543 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801543:	55                   	push   %ebp
  801544:	89 e5                	mov    %esp,%ebp
  801546:	56                   	push   %esi
  801547:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801548:	8b 75 18             	mov    0x18(%ebp),%esi
  80154b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80154e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801551:	8b 55 0c             	mov    0xc(%ebp),%edx
  801554:	8b 45 08             	mov    0x8(%ebp),%eax
  801557:	56                   	push   %esi
  801558:	53                   	push   %ebx
  801559:	51                   	push   %ecx
  80155a:	52                   	push   %edx
  80155b:	50                   	push   %eax
  80155c:	6a 08                	push   $0x8
  80155e:	e8 d6 fe ff ff       	call   801439 <syscall>
  801563:	83 c4 18             	add    $0x18,%esp
}
  801566:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801569:	5b                   	pop    %ebx
  80156a:	5e                   	pop    %esi
  80156b:	5d                   	pop    %ebp
  80156c:	c3                   	ret    

0080156d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801570:	8b 55 0c             	mov    0xc(%ebp),%edx
  801573:	8b 45 08             	mov    0x8(%ebp),%eax
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	52                   	push   %edx
  80157d:	50                   	push   %eax
  80157e:	6a 09                	push   $0x9
  801580:	e8 b4 fe ff ff       	call   801439 <syscall>
  801585:	83 c4 18             	add    $0x18,%esp
}
  801588:	c9                   	leave  
  801589:	c3                   	ret    

0080158a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80158a:	55                   	push   %ebp
  80158b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	6a 00                	push   $0x0
  801593:	ff 75 0c             	pushl  0xc(%ebp)
  801596:	ff 75 08             	pushl  0x8(%ebp)
  801599:	6a 0a                	push   $0xa
  80159b:	e8 99 fe ff ff       	call   801439 <syscall>
  8015a0:	83 c4 18             	add    $0x18,%esp
}
  8015a3:	c9                   	leave  
  8015a4:	c3                   	ret    

008015a5 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015a5:	55                   	push   %ebp
  8015a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 0b                	push   $0xb
  8015b4:	e8 80 fe ff ff       	call   801439 <syscall>
  8015b9:	83 c4 18             	add    $0x18,%esp
}
  8015bc:	c9                   	leave  
  8015bd:	c3                   	ret    

008015be <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015be:	55                   	push   %ebp
  8015bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 0c                	push   $0xc
  8015cd:	e8 67 fe ff ff       	call   801439 <syscall>
  8015d2:	83 c4 18             	add    $0x18,%esp
}
  8015d5:	c9                   	leave  
  8015d6:	c3                   	ret    

008015d7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015d7:	55                   	push   %ebp
  8015d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 0d                	push   $0xd
  8015e6:	e8 4e fe ff ff       	call   801439 <syscall>
  8015eb:	83 c4 18             	add    $0x18,%esp
}
  8015ee:	c9                   	leave  
  8015ef:	c3                   	ret    

008015f0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015f0:	55                   	push   %ebp
  8015f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	ff 75 0c             	pushl  0xc(%ebp)
  8015fc:	ff 75 08             	pushl  0x8(%ebp)
  8015ff:	6a 11                	push   $0x11
  801601:	e8 33 fe ff ff       	call   801439 <syscall>
  801606:	83 c4 18             	add    $0x18,%esp
	return;
  801609:	90                   	nop
}
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	ff 75 0c             	pushl  0xc(%ebp)
  801618:	ff 75 08             	pushl  0x8(%ebp)
  80161b:	6a 12                	push   $0x12
  80161d:	e8 17 fe ff ff       	call   801439 <syscall>
  801622:	83 c4 18             	add    $0x18,%esp
	return ;
  801625:	90                   	nop
}
  801626:	c9                   	leave  
  801627:	c3                   	ret    

00801628 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801628:	55                   	push   %ebp
  801629:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	6a 0e                	push   $0xe
  801637:	e8 fd fd ff ff       	call   801439 <syscall>
  80163c:	83 c4 18             	add    $0x18,%esp
}
  80163f:	c9                   	leave  
  801640:	c3                   	ret    

00801641 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801641:	55                   	push   %ebp
  801642:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	ff 75 08             	pushl  0x8(%ebp)
  80164f:	6a 0f                	push   $0xf
  801651:	e8 e3 fd ff ff       	call   801439 <syscall>
  801656:	83 c4 18             	add    $0x18,%esp
}
  801659:	c9                   	leave  
  80165a:	c3                   	ret    

0080165b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80165b:	55                   	push   %ebp
  80165c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 10                	push   $0x10
  80166a:	e8 ca fd ff ff       	call   801439 <syscall>
  80166f:	83 c4 18             	add    $0x18,%esp
}
  801672:	90                   	nop
  801673:	c9                   	leave  
  801674:	c3                   	ret    

00801675 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801675:	55                   	push   %ebp
  801676:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 14                	push   $0x14
  801684:	e8 b0 fd ff ff       	call   801439 <syscall>
  801689:	83 c4 18             	add    $0x18,%esp
}
  80168c:	90                   	nop
  80168d:	c9                   	leave  
  80168e:	c3                   	ret    

0080168f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80168f:	55                   	push   %ebp
  801690:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 15                	push   $0x15
  80169e:	e8 96 fd ff ff       	call   801439 <syscall>
  8016a3:	83 c4 18             	add    $0x18,%esp
}
  8016a6:	90                   	nop
  8016a7:	c9                   	leave  
  8016a8:	c3                   	ret    

008016a9 <sys_cputc>:


void
sys_cputc(const char c)
{
  8016a9:	55                   	push   %ebp
  8016aa:	89 e5                	mov    %esp,%ebp
  8016ac:	83 ec 04             	sub    $0x4,%esp
  8016af:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016b5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	50                   	push   %eax
  8016c2:	6a 16                	push   $0x16
  8016c4:	e8 70 fd ff ff       	call   801439 <syscall>
  8016c9:	83 c4 18             	add    $0x18,%esp
}
  8016cc:	90                   	nop
  8016cd:	c9                   	leave  
  8016ce:	c3                   	ret    

008016cf <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016cf:	55                   	push   %ebp
  8016d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 17                	push   $0x17
  8016de:	e8 56 fd ff ff       	call   801439 <syscall>
  8016e3:	83 c4 18             	add    $0x18,%esp
}
  8016e6:	90                   	nop
  8016e7:	c9                   	leave  
  8016e8:	c3                   	ret    

008016e9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8016e9:	55                   	push   %ebp
  8016ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	ff 75 0c             	pushl  0xc(%ebp)
  8016f8:	50                   	push   %eax
  8016f9:	6a 18                	push   $0x18
  8016fb:	e8 39 fd ff ff       	call   801439 <syscall>
  801700:	83 c4 18             	add    $0x18,%esp
}
  801703:	c9                   	leave  
  801704:	c3                   	ret    

00801705 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801705:	55                   	push   %ebp
  801706:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801708:	8b 55 0c             	mov    0xc(%ebp),%edx
  80170b:	8b 45 08             	mov    0x8(%ebp),%eax
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	52                   	push   %edx
  801715:	50                   	push   %eax
  801716:	6a 1b                	push   $0x1b
  801718:	e8 1c fd ff ff       	call   801439 <syscall>
  80171d:	83 c4 18             	add    $0x18,%esp
}
  801720:	c9                   	leave  
  801721:	c3                   	ret    

00801722 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801722:	55                   	push   %ebp
  801723:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801725:	8b 55 0c             	mov    0xc(%ebp),%edx
  801728:	8b 45 08             	mov    0x8(%ebp),%eax
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	52                   	push   %edx
  801732:	50                   	push   %eax
  801733:	6a 19                	push   $0x19
  801735:	e8 ff fc ff ff       	call   801439 <syscall>
  80173a:	83 c4 18             	add    $0x18,%esp
}
  80173d:	90                   	nop
  80173e:	c9                   	leave  
  80173f:	c3                   	ret    

00801740 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801740:	55                   	push   %ebp
  801741:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801743:	8b 55 0c             	mov    0xc(%ebp),%edx
  801746:	8b 45 08             	mov    0x8(%ebp),%eax
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	52                   	push   %edx
  801750:	50                   	push   %eax
  801751:	6a 1a                	push   $0x1a
  801753:	e8 e1 fc ff ff       	call   801439 <syscall>
  801758:	83 c4 18             	add    $0x18,%esp
}
  80175b:	90                   	nop
  80175c:	c9                   	leave  
  80175d:	c3                   	ret    

0080175e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80175e:	55                   	push   %ebp
  80175f:	89 e5                	mov    %esp,%ebp
  801761:	83 ec 04             	sub    $0x4,%esp
  801764:	8b 45 10             	mov    0x10(%ebp),%eax
  801767:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80176a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80176d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801771:	8b 45 08             	mov    0x8(%ebp),%eax
  801774:	6a 00                	push   $0x0
  801776:	51                   	push   %ecx
  801777:	52                   	push   %edx
  801778:	ff 75 0c             	pushl  0xc(%ebp)
  80177b:	50                   	push   %eax
  80177c:	6a 1c                	push   $0x1c
  80177e:	e8 b6 fc ff ff       	call   801439 <syscall>
  801783:	83 c4 18             	add    $0x18,%esp
}
  801786:	c9                   	leave  
  801787:	c3                   	ret    

00801788 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801788:	55                   	push   %ebp
  801789:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80178b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80178e:	8b 45 08             	mov    0x8(%ebp),%eax
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	52                   	push   %edx
  801798:	50                   	push   %eax
  801799:	6a 1d                	push   $0x1d
  80179b:	e8 99 fc ff ff       	call   801439 <syscall>
  8017a0:	83 c4 18             	add    $0x18,%esp
}
  8017a3:	c9                   	leave  
  8017a4:	c3                   	ret    

008017a5 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8017a5:	55                   	push   %ebp
  8017a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8017a8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	51                   	push   %ecx
  8017b6:	52                   	push   %edx
  8017b7:	50                   	push   %eax
  8017b8:	6a 1e                	push   $0x1e
  8017ba:	e8 7a fc ff ff       	call   801439 <syscall>
  8017bf:	83 c4 18             	add    $0x18,%esp
}
  8017c2:	c9                   	leave  
  8017c3:	c3                   	ret    

008017c4 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8017c4:	55                   	push   %ebp
  8017c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8017c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	52                   	push   %edx
  8017d4:	50                   	push   %eax
  8017d5:	6a 1f                	push   $0x1f
  8017d7:	e8 5d fc ff ff       	call   801439 <syscall>
  8017dc:	83 c4 18             	add    $0x18,%esp
}
  8017df:	c9                   	leave  
  8017e0:	c3                   	ret    

008017e1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8017e1:	55                   	push   %ebp
  8017e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 20                	push   $0x20
  8017f0:	e8 44 fc ff ff       	call   801439 <syscall>
  8017f5:	83 c4 18             	add    $0x18,%esp
}
  8017f8:	c9                   	leave  
  8017f9:	c3                   	ret    

008017fa <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8017fa:	55                   	push   %ebp
  8017fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8017fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	ff 75 10             	pushl  0x10(%ebp)
  801807:	ff 75 0c             	pushl  0xc(%ebp)
  80180a:	50                   	push   %eax
  80180b:	6a 21                	push   $0x21
  80180d:	e8 27 fc ff ff       	call   801439 <syscall>
  801812:	83 c4 18             	add    $0x18,%esp
}
  801815:	c9                   	leave  
  801816:	c3                   	ret    

00801817 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801817:	55                   	push   %ebp
  801818:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80181a:	8b 45 08             	mov    0x8(%ebp),%eax
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	50                   	push   %eax
  801826:	6a 22                	push   $0x22
  801828:	e8 0c fc ff ff       	call   801439 <syscall>
  80182d:	83 c4 18             	add    $0x18,%esp
}
  801830:	90                   	nop
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801836:	8b 45 08             	mov    0x8(%ebp),%eax
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	50                   	push   %eax
  801842:	6a 23                	push   $0x23
  801844:	e8 f0 fb ff ff       	call   801439 <syscall>
  801849:	83 c4 18             	add    $0x18,%esp
}
  80184c:	90                   	nop
  80184d:	c9                   	leave  
  80184e:	c3                   	ret    

0080184f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80184f:	55                   	push   %ebp
  801850:	89 e5                	mov    %esp,%ebp
  801852:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801855:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801858:	8d 50 04             	lea    0x4(%eax),%edx
  80185b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	52                   	push   %edx
  801865:	50                   	push   %eax
  801866:	6a 24                	push   $0x24
  801868:	e8 cc fb ff ff       	call   801439 <syscall>
  80186d:	83 c4 18             	add    $0x18,%esp
	return result;
  801870:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801873:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801876:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801879:	89 01                	mov    %eax,(%ecx)
  80187b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80187e:	8b 45 08             	mov    0x8(%ebp),%eax
  801881:	c9                   	leave  
  801882:	c2 04 00             	ret    $0x4

00801885 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	ff 75 10             	pushl  0x10(%ebp)
  80188f:	ff 75 0c             	pushl  0xc(%ebp)
  801892:	ff 75 08             	pushl  0x8(%ebp)
  801895:	6a 13                	push   $0x13
  801897:	e8 9d fb ff ff       	call   801439 <syscall>
  80189c:	83 c4 18             	add    $0x18,%esp
	return ;
  80189f:	90                   	nop
}
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <sys_rcr2>:
uint32 sys_rcr2()
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 25                	push   $0x25
  8018b1:	e8 83 fb ff ff       	call   801439 <syscall>
  8018b6:	83 c4 18             	add    $0x18,%esp
}
  8018b9:	c9                   	leave  
  8018ba:	c3                   	ret    

008018bb <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8018bb:	55                   	push   %ebp
  8018bc:	89 e5                	mov    %esp,%ebp
  8018be:	83 ec 04             	sub    $0x4,%esp
  8018c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018c7:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	50                   	push   %eax
  8018d4:	6a 26                	push   $0x26
  8018d6:	e8 5e fb ff ff       	call   801439 <syscall>
  8018db:	83 c4 18             	add    $0x18,%esp
	return ;
  8018de:	90                   	nop
}
  8018df:	c9                   	leave  
  8018e0:	c3                   	ret    

008018e1 <rsttst>:
void rsttst()
{
  8018e1:	55                   	push   %ebp
  8018e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 28                	push   $0x28
  8018f0:	e8 44 fb ff ff       	call   801439 <syscall>
  8018f5:	83 c4 18             	add    $0x18,%esp
	return ;
  8018f8:	90                   	nop
}
  8018f9:	c9                   	leave  
  8018fa:	c3                   	ret    

008018fb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018fb:	55                   	push   %ebp
  8018fc:	89 e5                	mov    %esp,%ebp
  8018fe:	83 ec 04             	sub    $0x4,%esp
  801901:	8b 45 14             	mov    0x14(%ebp),%eax
  801904:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801907:	8b 55 18             	mov    0x18(%ebp),%edx
  80190a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80190e:	52                   	push   %edx
  80190f:	50                   	push   %eax
  801910:	ff 75 10             	pushl  0x10(%ebp)
  801913:	ff 75 0c             	pushl  0xc(%ebp)
  801916:	ff 75 08             	pushl  0x8(%ebp)
  801919:	6a 27                	push   $0x27
  80191b:	e8 19 fb ff ff       	call   801439 <syscall>
  801920:	83 c4 18             	add    $0x18,%esp
	return ;
  801923:	90                   	nop
}
  801924:	c9                   	leave  
  801925:	c3                   	ret    

00801926 <chktst>:
void chktst(uint32 n)
{
  801926:	55                   	push   %ebp
  801927:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	ff 75 08             	pushl  0x8(%ebp)
  801934:	6a 29                	push   $0x29
  801936:	e8 fe fa ff ff       	call   801439 <syscall>
  80193b:	83 c4 18             	add    $0x18,%esp
	return ;
  80193e:	90                   	nop
}
  80193f:	c9                   	leave  
  801940:	c3                   	ret    

00801941 <inctst>:

void inctst()
{
  801941:	55                   	push   %ebp
  801942:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801944:	6a 00                	push   $0x0
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	6a 2a                	push   $0x2a
  801950:	e8 e4 fa ff ff       	call   801439 <syscall>
  801955:	83 c4 18             	add    $0x18,%esp
	return ;
  801958:	90                   	nop
}
  801959:	c9                   	leave  
  80195a:	c3                   	ret    

0080195b <gettst>:
uint32 gettst()
{
  80195b:	55                   	push   %ebp
  80195c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 2b                	push   $0x2b
  80196a:	e8 ca fa ff ff       	call   801439 <syscall>
  80196f:	83 c4 18             	add    $0x18,%esp
}
  801972:	c9                   	leave  
  801973:	c3                   	ret    

00801974 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801974:	55                   	push   %ebp
  801975:	89 e5                	mov    %esp,%ebp
  801977:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 2c                	push   $0x2c
  801986:	e8 ae fa ff ff       	call   801439 <syscall>
  80198b:	83 c4 18             	add    $0x18,%esp
  80198e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801991:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801995:	75 07                	jne    80199e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801997:	b8 01 00 00 00       	mov    $0x1,%eax
  80199c:	eb 05                	jmp    8019a3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80199e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019a3:	c9                   	leave  
  8019a4:	c3                   	ret    

008019a5 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8019a5:	55                   	push   %ebp
  8019a6:	89 e5                	mov    %esp,%ebp
  8019a8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 2c                	push   $0x2c
  8019b7:	e8 7d fa ff ff       	call   801439 <syscall>
  8019bc:	83 c4 18             	add    $0x18,%esp
  8019bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8019c2:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8019c6:	75 07                	jne    8019cf <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8019c8:	b8 01 00 00 00       	mov    $0x1,%eax
  8019cd:	eb 05                	jmp    8019d4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8019cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019d4:	c9                   	leave  
  8019d5:	c3                   	ret    

008019d6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8019d6:	55                   	push   %ebp
  8019d7:	89 e5                	mov    %esp,%ebp
  8019d9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 2c                	push   $0x2c
  8019e8:	e8 4c fa ff ff       	call   801439 <syscall>
  8019ed:	83 c4 18             	add    $0x18,%esp
  8019f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8019f3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8019f7:	75 07                	jne    801a00 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8019f9:	b8 01 00 00 00       	mov    $0x1,%eax
  8019fe:	eb 05                	jmp    801a05 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a00:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a05:	c9                   	leave  
  801a06:	c3                   	ret    

00801a07 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a07:	55                   	push   %ebp
  801a08:	89 e5                	mov    %esp,%ebp
  801a0a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 2c                	push   $0x2c
  801a19:	e8 1b fa ff ff       	call   801439 <syscall>
  801a1e:	83 c4 18             	add    $0x18,%esp
  801a21:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a24:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a28:	75 07                	jne    801a31 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a2a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a2f:	eb 05                	jmp    801a36 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a31:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a36:	c9                   	leave  
  801a37:	c3                   	ret    

00801a38 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a38:	55                   	push   %ebp
  801a39:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	ff 75 08             	pushl  0x8(%ebp)
  801a46:	6a 2d                	push   $0x2d
  801a48:	e8 ec f9 ff ff       	call   801439 <syscall>
  801a4d:	83 c4 18             	add    $0x18,%esp
	return ;
  801a50:	90                   	nop
}
  801a51:	c9                   	leave  
  801a52:	c3                   	ret    
  801a53:	90                   	nop

00801a54 <__udivdi3>:
  801a54:	55                   	push   %ebp
  801a55:	57                   	push   %edi
  801a56:	56                   	push   %esi
  801a57:	53                   	push   %ebx
  801a58:	83 ec 1c             	sub    $0x1c,%esp
  801a5b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a5f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a63:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a67:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a6b:	89 ca                	mov    %ecx,%edx
  801a6d:	89 f8                	mov    %edi,%eax
  801a6f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a73:	85 f6                	test   %esi,%esi
  801a75:	75 2d                	jne    801aa4 <__udivdi3+0x50>
  801a77:	39 cf                	cmp    %ecx,%edi
  801a79:	77 65                	ja     801ae0 <__udivdi3+0x8c>
  801a7b:	89 fd                	mov    %edi,%ebp
  801a7d:	85 ff                	test   %edi,%edi
  801a7f:	75 0b                	jne    801a8c <__udivdi3+0x38>
  801a81:	b8 01 00 00 00       	mov    $0x1,%eax
  801a86:	31 d2                	xor    %edx,%edx
  801a88:	f7 f7                	div    %edi
  801a8a:	89 c5                	mov    %eax,%ebp
  801a8c:	31 d2                	xor    %edx,%edx
  801a8e:	89 c8                	mov    %ecx,%eax
  801a90:	f7 f5                	div    %ebp
  801a92:	89 c1                	mov    %eax,%ecx
  801a94:	89 d8                	mov    %ebx,%eax
  801a96:	f7 f5                	div    %ebp
  801a98:	89 cf                	mov    %ecx,%edi
  801a9a:	89 fa                	mov    %edi,%edx
  801a9c:	83 c4 1c             	add    $0x1c,%esp
  801a9f:	5b                   	pop    %ebx
  801aa0:	5e                   	pop    %esi
  801aa1:	5f                   	pop    %edi
  801aa2:	5d                   	pop    %ebp
  801aa3:	c3                   	ret    
  801aa4:	39 ce                	cmp    %ecx,%esi
  801aa6:	77 28                	ja     801ad0 <__udivdi3+0x7c>
  801aa8:	0f bd fe             	bsr    %esi,%edi
  801aab:	83 f7 1f             	xor    $0x1f,%edi
  801aae:	75 40                	jne    801af0 <__udivdi3+0x9c>
  801ab0:	39 ce                	cmp    %ecx,%esi
  801ab2:	72 0a                	jb     801abe <__udivdi3+0x6a>
  801ab4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ab8:	0f 87 9e 00 00 00    	ja     801b5c <__udivdi3+0x108>
  801abe:	b8 01 00 00 00       	mov    $0x1,%eax
  801ac3:	89 fa                	mov    %edi,%edx
  801ac5:	83 c4 1c             	add    $0x1c,%esp
  801ac8:	5b                   	pop    %ebx
  801ac9:	5e                   	pop    %esi
  801aca:	5f                   	pop    %edi
  801acb:	5d                   	pop    %ebp
  801acc:	c3                   	ret    
  801acd:	8d 76 00             	lea    0x0(%esi),%esi
  801ad0:	31 ff                	xor    %edi,%edi
  801ad2:	31 c0                	xor    %eax,%eax
  801ad4:	89 fa                	mov    %edi,%edx
  801ad6:	83 c4 1c             	add    $0x1c,%esp
  801ad9:	5b                   	pop    %ebx
  801ada:	5e                   	pop    %esi
  801adb:	5f                   	pop    %edi
  801adc:	5d                   	pop    %ebp
  801add:	c3                   	ret    
  801ade:	66 90                	xchg   %ax,%ax
  801ae0:	89 d8                	mov    %ebx,%eax
  801ae2:	f7 f7                	div    %edi
  801ae4:	31 ff                	xor    %edi,%edi
  801ae6:	89 fa                	mov    %edi,%edx
  801ae8:	83 c4 1c             	add    $0x1c,%esp
  801aeb:	5b                   	pop    %ebx
  801aec:	5e                   	pop    %esi
  801aed:	5f                   	pop    %edi
  801aee:	5d                   	pop    %ebp
  801aef:	c3                   	ret    
  801af0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801af5:	89 eb                	mov    %ebp,%ebx
  801af7:	29 fb                	sub    %edi,%ebx
  801af9:	89 f9                	mov    %edi,%ecx
  801afb:	d3 e6                	shl    %cl,%esi
  801afd:	89 c5                	mov    %eax,%ebp
  801aff:	88 d9                	mov    %bl,%cl
  801b01:	d3 ed                	shr    %cl,%ebp
  801b03:	89 e9                	mov    %ebp,%ecx
  801b05:	09 f1                	or     %esi,%ecx
  801b07:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b0b:	89 f9                	mov    %edi,%ecx
  801b0d:	d3 e0                	shl    %cl,%eax
  801b0f:	89 c5                	mov    %eax,%ebp
  801b11:	89 d6                	mov    %edx,%esi
  801b13:	88 d9                	mov    %bl,%cl
  801b15:	d3 ee                	shr    %cl,%esi
  801b17:	89 f9                	mov    %edi,%ecx
  801b19:	d3 e2                	shl    %cl,%edx
  801b1b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b1f:	88 d9                	mov    %bl,%cl
  801b21:	d3 e8                	shr    %cl,%eax
  801b23:	09 c2                	or     %eax,%edx
  801b25:	89 d0                	mov    %edx,%eax
  801b27:	89 f2                	mov    %esi,%edx
  801b29:	f7 74 24 0c          	divl   0xc(%esp)
  801b2d:	89 d6                	mov    %edx,%esi
  801b2f:	89 c3                	mov    %eax,%ebx
  801b31:	f7 e5                	mul    %ebp
  801b33:	39 d6                	cmp    %edx,%esi
  801b35:	72 19                	jb     801b50 <__udivdi3+0xfc>
  801b37:	74 0b                	je     801b44 <__udivdi3+0xf0>
  801b39:	89 d8                	mov    %ebx,%eax
  801b3b:	31 ff                	xor    %edi,%edi
  801b3d:	e9 58 ff ff ff       	jmp    801a9a <__udivdi3+0x46>
  801b42:	66 90                	xchg   %ax,%ax
  801b44:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b48:	89 f9                	mov    %edi,%ecx
  801b4a:	d3 e2                	shl    %cl,%edx
  801b4c:	39 c2                	cmp    %eax,%edx
  801b4e:	73 e9                	jae    801b39 <__udivdi3+0xe5>
  801b50:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b53:	31 ff                	xor    %edi,%edi
  801b55:	e9 40 ff ff ff       	jmp    801a9a <__udivdi3+0x46>
  801b5a:	66 90                	xchg   %ax,%ax
  801b5c:	31 c0                	xor    %eax,%eax
  801b5e:	e9 37 ff ff ff       	jmp    801a9a <__udivdi3+0x46>
  801b63:	90                   	nop

00801b64 <__umoddi3>:
  801b64:	55                   	push   %ebp
  801b65:	57                   	push   %edi
  801b66:	56                   	push   %esi
  801b67:	53                   	push   %ebx
  801b68:	83 ec 1c             	sub    $0x1c,%esp
  801b6b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b6f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b73:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b77:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b7b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b7f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b83:	89 f3                	mov    %esi,%ebx
  801b85:	89 fa                	mov    %edi,%edx
  801b87:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b8b:	89 34 24             	mov    %esi,(%esp)
  801b8e:	85 c0                	test   %eax,%eax
  801b90:	75 1a                	jne    801bac <__umoddi3+0x48>
  801b92:	39 f7                	cmp    %esi,%edi
  801b94:	0f 86 a2 00 00 00    	jbe    801c3c <__umoddi3+0xd8>
  801b9a:	89 c8                	mov    %ecx,%eax
  801b9c:	89 f2                	mov    %esi,%edx
  801b9e:	f7 f7                	div    %edi
  801ba0:	89 d0                	mov    %edx,%eax
  801ba2:	31 d2                	xor    %edx,%edx
  801ba4:	83 c4 1c             	add    $0x1c,%esp
  801ba7:	5b                   	pop    %ebx
  801ba8:	5e                   	pop    %esi
  801ba9:	5f                   	pop    %edi
  801baa:	5d                   	pop    %ebp
  801bab:	c3                   	ret    
  801bac:	39 f0                	cmp    %esi,%eax
  801bae:	0f 87 ac 00 00 00    	ja     801c60 <__umoddi3+0xfc>
  801bb4:	0f bd e8             	bsr    %eax,%ebp
  801bb7:	83 f5 1f             	xor    $0x1f,%ebp
  801bba:	0f 84 ac 00 00 00    	je     801c6c <__umoddi3+0x108>
  801bc0:	bf 20 00 00 00       	mov    $0x20,%edi
  801bc5:	29 ef                	sub    %ebp,%edi
  801bc7:	89 fe                	mov    %edi,%esi
  801bc9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bcd:	89 e9                	mov    %ebp,%ecx
  801bcf:	d3 e0                	shl    %cl,%eax
  801bd1:	89 d7                	mov    %edx,%edi
  801bd3:	89 f1                	mov    %esi,%ecx
  801bd5:	d3 ef                	shr    %cl,%edi
  801bd7:	09 c7                	or     %eax,%edi
  801bd9:	89 e9                	mov    %ebp,%ecx
  801bdb:	d3 e2                	shl    %cl,%edx
  801bdd:	89 14 24             	mov    %edx,(%esp)
  801be0:	89 d8                	mov    %ebx,%eax
  801be2:	d3 e0                	shl    %cl,%eax
  801be4:	89 c2                	mov    %eax,%edx
  801be6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bea:	d3 e0                	shl    %cl,%eax
  801bec:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bf0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bf4:	89 f1                	mov    %esi,%ecx
  801bf6:	d3 e8                	shr    %cl,%eax
  801bf8:	09 d0                	or     %edx,%eax
  801bfa:	d3 eb                	shr    %cl,%ebx
  801bfc:	89 da                	mov    %ebx,%edx
  801bfe:	f7 f7                	div    %edi
  801c00:	89 d3                	mov    %edx,%ebx
  801c02:	f7 24 24             	mull   (%esp)
  801c05:	89 c6                	mov    %eax,%esi
  801c07:	89 d1                	mov    %edx,%ecx
  801c09:	39 d3                	cmp    %edx,%ebx
  801c0b:	0f 82 87 00 00 00    	jb     801c98 <__umoddi3+0x134>
  801c11:	0f 84 91 00 00 00    	je     801ca8 <__umoddi3+0x144>
  801c17:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c1b:	29 f2                	sub    %esi,%edx
  801c1d:	19 cb                	sbb    %ecx,%ebx
  801c1f:	89 d8                	mov    %ebx,%eax
  801c21:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c25:	d3 e0                	shl    %cl,%eax
  801c27:	89 e9                	mov    %ebp,%ecx
  801c29:	d3 ea                	shr    %cl,%edx
  801c2b:	09 d0                	or     %edx,%eax
  801c2d:	89 e9                	mov    %ebp,%ecx
  801c2f:	d3 eb                	shr    %cl,%ebx
  801c31:	89 da                	mov    %ebx,%edx
  801c33:	83 c4 1c             	add    $0x1c,%esp
  801c36:	5b                   	pop    %ebx
  801c37:	5e                   	pop    %esi
  801c38:	5f                   	pop    %edi
  801c39:	5d                   	pop    %ebp
  801c3a:	c3                   	ret    
  801c3b:	90                   	nop
  801c3c:	89 fd                	mov    %edi,%ebp
  801c3e:	85 ff                	test   %edi,%edi
  801c40:	75 0b                	jne    801c4d <__umoddi3+0xe9>
  801c42:	b8 01 00 00 00       	mov    $0x1,%eax
  801c47:	31 d2                	xor    %edx,%edx
  801c49:	f7 f7                	div    %edi
  801c4b:	89 c5                	mov    %eax,%ebp
  801c4d:	89 f0                	mov    %esi,%eax
  801c4f:	31 d2                	xor    %edx,%edx
  801c51:	f7 f5                	div    %ebp
  801c53:	89 c8                	mov    %ecx,%eax
  801c55:	f7 f5                	div    %ebp
  801c57:	89 d0                	mov    %edx,%eax
  801c59:	e9 44 ff ff ff       	jmp    801ba2 <__umoddi3+0x3e>
  801c5e:	66 90                	xchg   %ax,%ax
  801c60:	89 c8                	mov    %ecx,%eax
  801c62:	89 f2                	mov    %esi,%edx
  801c64:	83 c4 1c             	add    $0x1c,%esp
  801c67:	5b                   	pop    %ebx
  801c68:	5e                   	pop    %esi
  801c69:	5f                   	pop    %edi
  801c6a:	5d                   	pop    %ebp
  801c6b:	c3                   	ret    
  801c6c:	3b 04 24             	cmp    (%esp),%eax
  801c6f:	72 06                	jb     801c77 <__umoddi3+0x113>
  801c71:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c75:	77 0f                	ja     801c86 <__umoddi3+0x122>
  801c77:	89 f2                	mov    %esi,%edx
  801c79:	29 f9                	sub    %edi,%ecx
  801c7b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c7f:	89 14 24             	mov    %edx,(%esp)
  801c82:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c86:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c8a:	8b 14 24             	mov    (%esp),%edx
  801c8d:	83 c4 1c             	add    $0x1c,%esp
  801c90:	5b                   	pop    %ebx
  801c91:	5e                   	pop    %esi
  801c92:	5f                   	pop    %edi
  801c93:	5d                   	pop    %ebp
  801c94:	c3                   	ret    
  801c95:	8d 76 00             	lea    0x0(%esi),%esi
  801c98:	2b 04 24             	sub    (%esp),%eax
  801c9b:	19 fa                	sbb    %edi,%edx
  801c9d:	89 d1                	mov    %edx,%ecx
  801c9f:	89 c6                	mov    %eax,%esi
  801ca1:	e9 71 ff ff ff       	jmp    801c17 <__umoddi3+0xb3>
  801ca6:	66 90                	xchg   %ax,%ax
  801ca8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801cac:	72 ea                	jb     801c98 <__umoddi3+0x134>
  801cae:	89 d9                	mov    %ebx,%ecx
  801cb0:	e9 62 ff ff ff       	jmp    801c17 <__umoddi3+0xb3>
