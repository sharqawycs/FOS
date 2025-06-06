
obj/user/tst_sharing_2master:     file format elf32-i386


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
  800031:	e8 fc 02 00 00       	call   800332 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Master program: create the shared variables, initialize them and run slaves
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 34             	sub    $0x34,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80003f:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800043:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004a:	eb 29                	jmp    800075 <_main+0x3d>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004c:	a1 20 30 80 00       	mov    0x803020,%eax
  800051:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800057:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005a:	89 d0                	mov    %edx,%eax
  80005c:	01 c0                	add    %eax,%eax
  80005e:	01 d0                	add    %edx,%eax
  800060:	c1 e0 02             	shl    $0x2,%eax
  800063:	01 c8                	add    %ecx,%eax
  800065:	8a 40 04             	mov    0x4(%eax),%al
  800068:	84 c0                	test   %al,%al
  80006a:	74 06                	je     800072 <_main+0x3a>
			{
				fullWS = 0;
  80006c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800070:	eb 12                	jmp    800084 <_main+0x4c>
_main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800072:	ff 45 f0             	incl   -0x10(%ebp)
  800075:	a1 20 30 80 00       	mov    0x803020,%eax
  80007a:	8b 50 74             	mov    0x74(%eax),%edx
  80007d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800080:	39 c2                	cmp    %eax,%edx
  800082:	77 c8                	ja     80004c <_main+0x14>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800084:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800088:	74 14                	je     80009e <_main+0x66>
  80008a:	83 ec 04             	sub    $0x4,%esp
  80008d:	68 40 20 80 00       	push   $0x802040
  800092:	6a 13                	push   $0x13
  800094:	68 5c 20 80 00       	push   $0x80205c
  800099:	e8 96 03 00 00       	call   800434 <_panic>
	}
	uint32 *x, *y, *z ;

	//x: Readonly
	int freeFrames = sys_calculate_free_frames() ;
  80009e:	e8 cb 17 00 00       	call   80186e <sys_calculate_free_frames>
  8000a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
	x = smalloc("x", 4, 0);
  8000a6:	83 ec 04             	sub    $0x4,%esp
  8000a9:	6a 00                	push   $0x0
  8000ab:	6a 04                	push   $0x4
  8000ad:	68 77 20 80 00       	push   $0x802077
  8000b2:	e8 bb 13 00 00       	call   801472 <smalloc>
  8000b7:	83 c4 10             	add    $0x10,%esp
  8000ba:	89 45 e8             	mov    %eax,-0x18(%ebp)
	if (x != (uint32*)USER_HEAP_START) panic("Create(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  8000bd:	81 7d e8 00 00 00 80 	cmpl   $0x80000000,-0x18(%ebp)
  8000c4:	74 14                	je     8000da <_main+0xa2>
  8000c6:	83 ec 04             	sub    $0x4,%esp
  8000c9:	68 7c 20 80 00       	push   $0x80207c
  8000ce:	6a 1a                	push   $0x1a
  8000d0:	68 5c 20 80 00       	push   $0x80205c
  8000d5:	e8 5a 03 00 00       	call   800434 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Create(): Wrong allocation- make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  8000da:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8000dd:	e8 8c 17 00 00       	call   80186e <sys_calculate_free_frames>
  8000e2:	29 c3                	sub    %eax,%ebx
  8000e4:	89 d8                	mov    %ebx,%eax
  8000e6:	83 f8 04             	cmp    $0x4,%eax
  8000e9:	74 14                	je     8000ff <_main+0xc7>
  8000eb:	83 ec 04             	sub    $0x4,%esp
  8000ee:	68 e0 20 80 00       	push   $0x8020e0
  8000f3:	6a 1b                	push   $0x1b
  8000f5:	68 5c 20 80 00       	push   $0x80205c
  8000fa:	e8 35 03 00 00       	call   800434 <_panic>

	//y: Readonly
	freeFrames = sys_calculate_free_frames() ;
  8000ff:	e8 6a 17 00 00       	call   80186e <sys_calculate_free_frames>
  800104:	89 45 ec             	mov    %eax,-0x14(%ebp)
	y = smalloc("y", 4, 0);
  800107:	83 ec 04             	sub    $0x4,%esp
  80010a:	6a 00                	push   $0x0
  80010c:	6a 04                	push   $0x4
  80010e:	68 68 21 80 00       	push   $0x802168
  800113:	e8 5a 13 00 00       	call   801472 <smalloc>
  800118:	83 c4 10             	add    $0x10,%esp
  80011b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	if (y != (uint32*)(USER_HEAP_START + 1 * PAGE_SIZE)) panic("Create(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  80011e:	81 7d e4 00 10 00 80 	cmpl   $0x80001000,-0x1c(%ebp)
  800125:	74 14                	je     80013b <_main+0x103>
  800127:	83 ec 04             	sub    $0x4,%esp
  80012a:	68 7c 20 80 00       	push   $0x80207c
  80012f:	6a 20                	push   $0x20
  800131:	68 5c 20 80 00       	push   $0x80205c
  800136:	e8 f9 02 00 00       	call   800434 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1+0+2) panic("Create(): Wrong allocation- make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80013b:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  80013e:	e8 2b 17 00 00       	call   80186e <sys_calculate_free_frames>
  800143:	29 c3                	sub    %eax,%ebx
  800145:	89 d8                	mov    %ebx,%eax
  800147:	83 f8 03             	cmp    $0x3,%eax
  80014a:	74 14                	je     800160 <_main+0x128>
  80014c:	83 ec 04             	sub    $0x4,%esp
  80014f:	68 e0 20 80 00       	push   $0x8020e0
  800154:	6a 21                	push   $0x21
  800156:	68 5c 20 80 00       	push   $0x80205c
  80015b:	e8 d4 02 00 00       	call   800434 <_panic>

	//z: Writable
	freeFrames = sys_calculate_free_frames() ;
  800160:	e8 09 17 00 00       	call   80186e <sys_calculate_free_frames>
  800165:	89 45 ec             	mov    %eax,-0x14(%ebp)
	z = smalloc("z", 4, 1);
  800168:	83 ec 04             	sub    $0x4,%esp
  80016b:	6a 01                	push   $0x1
  80016d:	6a 04                	push   $0x4
  80016f:	68 6a 21 80 00       	push   $0x80216a
  800174:	e8 f9 12 00 00       	call   801472 <smalloc>
  800179:	83 c4 10             	add    $0x10,%esp
  80017c:	89 45 e0             	mov    %eax,-0x20(%ebp)
	if (z != (uint32*)(USER_HEAP_START + 2 * PAGE_SIZE)) panic("Create(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  80017f:	81 7d e0 00 20 00 80 	cmpl   $0x80002000,-0x20(%ebp)
  800186:	74 14                	je     80019c <_main+0x164>
  800188:	83 ec 04             	sub    $0x4,%esp
  80018b:	68 7c 20 80 00       	push   $0x80207c
  800190:	6a 26                	push   $0x26
  800192:	68 5c 20 80 00       	push   $0x80205c
  800197:	e8 98 02 00 00       	call   800434 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1+0+2) panic("Create(): Wrong allocation- make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80019c:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  80019f:	e8 ca 16 00 00       	call   80186e <sys_calculate_free_frames>
  8001a4:	29 c3                	sub    %eax,%ebx
  8001a6:	89 d8                	mov    %ebx,%eax
  8001a8:	83 f8 03             	cmp    $0x3,%eax
  8001ab:	74 14                	je     8001c1 <_main+0x189>
  8001ad:	83 ec 04             	sub    $0x4,%esp
  8001b0:	68 e0 20 80 00       	push   $0x8020e0
  8001b5:	6a 27                	push   $0x27
  8001b7:	68 5c 20 80 00       	push   $0x80205c
  8001bc:	e8 73 02 00 00       	call   800434 <_panic>

	*x = 10 ;
  8001c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001c4:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
	*y = 20 ;
  8001ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001cd:	c7 00 14 00 00 00    	movl   $0x14,(%eax)

	int id1, id2, id3;
	id1 = sys_create_env("shr2Slave1", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8001d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d8:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8001de:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e3:	8b 40 74             	mov    0x74(%eax),%eax
  8001e6:	83 ec 04             	sub    $0x4,%esp
  8001e9:	52                   	push   %edx
  8001ea:	50                   	push   %eax
  8001eb:	68 6c 21 80 00       	push   $0x80216c
  8001f0:	e8 ce 18 00 00       	call   801ac3 <sys_create_env>
  8001f5:	83 c4 10             	add    $0x10,%esp
  8001f8:	89 45 dc             	mov    %eax,-0x24(%ebp)
	id2 = sys_create_env("shr2Slave1", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8001fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800200:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800206:	a1 20 30 80 00       	mov    0x803020,%eax
  80020b:	8b 40 74             	mov    0x74(%eax),%eax
  80020e:	83 ec 04             	sub    $0x4,%esp
  800211:	52                   	push   %edx
  800212:	50                   	push   %eax
  800213:	68 6c 21 80 00       	push   $0x80216c
  800218:	e8 a6 18 00 00       	call   801ac3 <sys_create_env>
  80021d:	83 c4 10             	add    $0x10,%esp
  800220:	89 45 d8             	mov    %eax,-0x28(%ebp)
	id3 = sys_create_env("shr2Slave1", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800223:	a1 20 30 80 00       	mov    0x803020,%eax
  800228:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  80022e:	a1 20 30 80 00       	mov    0x803020,%eax
  800233:	8b 40 74             	mov    0x74(%eax),%eax
  800236:	83 ec 04             	sub    $0x4,%esp
  800239:	52                   	push   %edx
  80023a:	50                   	push   %eax
  80023b:	68 6c 21 80 00       	push   $0x80216c
  800240:	e8 7e 18 00 00       	call   801ac3 <sys_create_env>
  800245:	83 c4 10             	add    $0x10,%esp
  800248:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//to check that the slave environments completed successfully
	rsttst();
  80024b:	e8 5a 19 00 00       	call   801baa <rsttst>

	sys_run_env(id1);
  800250:	83 ec 0c             	sub    $0xc,%esp
  800253:	ff 75 dc             	pushl  -0x24(%ebp)
  800256:	e8 85 18 00 00       	call   801ae0 <sys_run_env>
  80025b:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id2);
  80025e:	83 ec 0c             	sub    $0xc,%esp
  800261:	ff 75 d8             	pushl  -0x28(%ebp)
  800264:	e8 77 18 00 00       	call   801ae0 <sys_run_env>
  800269:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id3);
  80026c:	83 ec 0c             	sub    $0xc,%esp
  80026f:	ff 75 d4             	pushl  -0x2c(%ebp)
  800272:	e8 69 18 00 00       	call   801ae0 <sys_run_env>
  800277:	83 c4 10             	add    $0x10,%esp

	env_sleep(12000) ;
  80027a:	83 ec 0c             	sub    $0xc,%esp
  80027d:	68 e0 2e 00 00       	push   $0x2ee0
  800282:	e8 95 1a 00 00       	call   801d1c <env_sleep>
  800287:	83 c4 10             	add    $0x10,%esp

	//to ensure that the slave environments completed successfully
	if (gettst()!=3) panic("test failed");
  80028a:	e8 95 19 00 00       	call   801c24 <gettst>
  80028f:	83 f8 03             	cmp    $0x3,%eax
  800292:	74 14                	je     8002a8 <_main+0x270>
  800294:	83 ec 04             	sub    $0x4,%esp
  800297:	68 77 21 80 00       	push   $0x802177
  80029c:	6a 3b                	push   $0x3b
  80029e:	68 5c 20 80 00       	push   $0x80205c
  8002a3:	e8 8c 01 00 00       	call   800434 <_panic>


	if (*z != 30)
  8002a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002ab:	8b 00                	mov    (%eax),%eax
  8002ad:	83 f8 1e             	cmp    $0x1e,%eax
  8002b0:	74 14                	je     8002c6 <_main+0x28e>
		panic("Error!! Please check the creation (or the getting) of shared variables!!\n\n\n");
  8002b2:	83 ec 04             	sub    $0x4,%esp
  8002b5:	68 84 21 80 00       	push   $0x802184
  8002ba:	6a 3f                	push   $0x3f
  8002bc:	68 5c 20 80 00       	push   $0x80205c
  8002c1:	e8 6e 01 00 00       	call   800434 <_panic>
	else
		cprintf("Congratulations!! Test of Shared Variables [Create & Get] [2] completed successfully!!\n\n\n");
  8002c6:	83 ec 0c             	sub    $0xc,%esp
  8002c9:	68 d0 21 80 00       	push   $0x8021d0
  8002ce:	e8 15 04 00 00       	call   8006e8 <cprintf>
  8002d3:	83 c4 10             	add    $0x10,%esp

	cprintf("Now, ILLEGAL MEM ACCESS should be occur, due to attempting to write a ReadOnly variable\n\n\n");
  8002d6:	83 ec 0c             	sub    $0xc,%esp
  8002d9:	68 2c 22 80 00       	push   $0x80222c
  8002de:	e8 05 04 00 00       	call   8006e8 <cprintf>
  8002e3:	83 c4 10             	add    $0x10,%esp

	id1 = sys_create_env("shr2Slave2", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8002e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002eb:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8002f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f6:	8b 40 74             	mov    0x74(%eax),%eax
  8002f9:	83 ec 04             	sub    $0x4,%esp
  8002fc:	52                   	push   %edx
  8002fd:	50                   	push   %eax
  8002fe:	68 87 22 80 00       	push   $0x802287
  800303:	e8 bb 17 00 00       	call   801ac3 <sys_create_env>
  800308:	83 c4 10             	add    $0x10,%esp
  80030b:	89 45 dc             	mov    %eax,-0x24(%ebp)

	env_sleep(3000) ;
  80030e:	83 ec 0c             	sub    $0xc,%esp
  800311:	68 b8 0b 00 00       	push   $0xbb8
  800316:	e8 01 1a 00 00       	call   801d1c <env_sleep>
  80031b:	83 c4 10             	add    $0x10,%esp

	sys_run_env(id1);
  80031e:	83 ec 0c             	sub    $0xc,%esp
  800321:	ff 75 dc             	pushl  -0x24(%ebp)
  800324:	e8 b7 17 00 00       	call   801ae0 <sys_run_env>
  800329:	83 c4 10             	add    $0x10,%esp

	return;
  80032c:	90                   	nop
}
  80032d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800330:	c9                   	leave  
  800331:	c3                   	ret    

00800332 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800332:	55                   	push   %ebp
  800333:	89 e5                	mov    %esp,%ebp
  800335:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800338:	e8 66 14 00 00       	call   8017a3 <sys_getenvindex>
  80033d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800340:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800343:	89 d0                	mov    %edx,%eax
  800345:	01 c0                	add    %eax,%eax
  800347:	01 d0                	add    %edx,%eax
  800349:	c1 e0 02             	shl    $0x2,%eax
  80034c:	01 d0                	add    %edx,%eax
  80034e:	c1 e0 06             	shl    $0x6,%eax
  800351:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800356:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80035b:	a1 20 30 80 00       	mov    0x803020,%eax
  800360:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800366:	84 c0                	test   %al,%al
  800368:	74 0f                	je     800379 <libmain+0x47>
		binaryname = myEnv->prog_name;
  80036a:	a1 20 30 80 00       	mov    0x803020,%eax
  80036f:	05 f4 02 00 00       	add    $0x2f4,%eax
  800374:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800379:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80037d:	7e 0a                	jle    800389 <libmain+0x57>
		binaryname = argv[0];
  80037f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800382:	8b 00                	mov    (%eax),%eax
  800384:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800389:	83 ec 08             	sub    $0x8,%esp
  80038c:	ff 75 0c             	pushl  0xc(%ebp)
  80038f:	ff 75 08             	pushl  0x8(%ebp)
  800392:	e8 a1 fc ff ff       	call   800038 <_main>
  800397:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80039a:	e8 9f 15 00 00       	call   80193e <sys_disable_interrupt>
	cprintf("**************************************\n");
  80039f:	83 ec 0c             	sub    $0xc,%esp
  8003a2:	68 ac 22 80 00       	push   $0x8022ac
  8003a7:	e8 3c 03 00 00       	call   8006e8 <cprintf>
  8003ac:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003af:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b4:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8003ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8003bf:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8003c5:	83 ec 04             	sub    $0x4,%esp
  8003c8:	52                   	push   %edx
  8003c9:	50                   	push   %eax
  8003ca:	68 d4 22 80 00       	push   $0x8022d4
  8003cf:	e8 14 03 00 00       	call   8006e8 <cprintf>
  8003d4:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8003d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003dc:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8003e2:	83 ec 08             	sub    $0x8,%esp
  8003e5:	50                   	push   %eax
  8003e6:	68 f9 22 80 00       	push   $0x8022f9
  8003eb:	e8 f8 02 00 00       	call   8006e8 <cprintf>
  8003f0:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8003f3:	83 ec 0c             	sub    $0xc,%esp
  8003f6:	68 ac 22 80 00       	push   $0x8022ac
  8003fb:	e8 e8 02 00 00       	call   8006e8 <cprintf>
  800400:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800403:	e8 50 15 00 00       	call   801958 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800408:	e8 19 00 00 00       	call   800426 <exit>
}
  80040d:	90                   	nop
  80040e:	c9                   	leave  
  80040f:	c3                   	ret    

00800410 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800410:	55                   	push   %ebp
  800411:	89 e5                	mov    %esp,%ebp
  800413:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800416:	83 ec 0c             	sub    $0xc,%esp
  800419:	6a 00                	push   $0x0
  80041b:	e8 4f 13 00 00       	call   80176f <sys_env_destroy>
  800420:	83 c4 10             	add    $0x10,%esp
}
  800423:	90                   	nop
  800424:	c9                   	leave  
  800425:	c3                   	ret    

00800426 <exit>:

void
exit(void)
{
  800426:	55                   	push   %ebp
  800427:	89 e5                	mov    %esp,%ebp
  800429:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80042c:	e8 a4 13 00 00       	call   8017d5 <sys_env_exit>
}
  800431:	90                   	nop
  800432:	c9                   	leave  
  800433:	c3                   	ret    

00800434 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800434:	55                   	push   %ebp
  800435:	89 e5                	mov    %esp,%ebp
  800437:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80043a:	8d 45 10             	lea    0x10(%ebp),%eax
  80043d:	83 c0 04             	add    $0x4,%eax
  800440:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800443:	a1 30 30 80 00       	mov    0x803030,%eax
  800448:	85 c0                	test   %eax,%eax
  80044a:	74 16                	je     800462 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80044c:	a1 30 30 80 00       	mov    0x803030,%eax
  800451:	83 ec 08             	sub    $0x8,%esp
  800454:	50                   	push   %eax
  800455:	68 10 23 80 00       	push   $0x802310
  80045a:	e8 89 02 00 00       	call   8006e8 <cprintf>
  80045f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800462:	a1 00 30 80 00       	mov    0x803000,%eax
  800467:	ff 75 0c             	pushl  0xc(%ebp)
  80046a:	ff 75 08             	pushl  0x8(%ebp)
  80046d:	50                   	push   %eax
  80046e:	68 15 23 80 00       	push   $0x802315
  800473:	e8 70 02 00 00       	call   8006e8 <cprintf>
  800478:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80047b:	8b 45 10             	mov    0x10(%ebp),%eax
  80047e:	83 ec 08             	sub    $0x8,%esp
  800481:	ff 75 f4             	pushl  -0xc(%ebp)
  800484:	50                   	push   %eax
  800485:	e8 f3 01 00 00       	call   80067d <vcprintf>
  80048a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80048d:	83 ec 08             	sub    $0x8,%esp
  800490:	6a 00                	push   $0x0
  800492:	68 31 23 80 00       	push   $0x802331
  800497:	e8 e1 01 00 00       	call   80067d <vcprintf>
  80049c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80049f:	e8 82 ff ff ff       	call   800426 <exit>

	// should not return here
	while (1) ;
  8004a4:	eb fe                	jmp    8004a4 <_panic+0x70>

008004a6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8004a6:	55                   	push   %ebp
  8004a7:	89 e5                	mov    %esp,%ebp
  8004a9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8004ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b1:	8b 50 74             	mov    0x74(%eax),%edx
  8004b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b7:	39 c2                	cmp    %eax,%edx
  8004b9:	74 14                	je     8004cf <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8004bb:	83 ec 04             	sub    $0x4,%esp
  8004be:	68 34 23 80 00       	push   $0x802334
  8004c3:	6a 26                	push   $0x26
  8004c5:	68 80 23 80 00       	push   $0x802380
  8004ca:	e8 65 ff ff ff       	call   800434 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8004cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8004d6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004dd:	e9 c2 00 00 00       	jmp    8005a4 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8004e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ef:	01 d0                	add    %edx,%eax
  8004f1:	8b 00                	mov    (%eax),%eax
  8004f3:	85 c0                	test   %eax,%eax
  8004f5:	75 08                	jne    8004ff <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8004f7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8004fa:	e9 a2 00 00 00       	jmp    8005a1 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8004ff:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800506:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80050d:	eb 69                	jmp    800578 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80050f:	a1 20 30 80 00       	mov    0x803020,%eax
  800514:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80051a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80051d:	89 d0                	mov    %edx,%eax
  80051f:	01 c0                	add    %eax,%eax
  800521:	01 d0                	add    %edx,%eax
  800523:	c1 e0 02             	shl    $0x2,%eax
  800526:	01 c8                	add    %ecx,%eax
  800528:	8a 40 04             	mov    0x4(%eax),%al
  80052b:	84 c0                	test   %al,%al
  80052d:	75 46                	jne    800575 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80052f:	a1 20 30 80 00       	mov    0x803020,%eax
  800534:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80053a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80053d:	89 d0                	mov    %edx,%eax
  80053f:	01 c0                	add    %eax,%eax
  800541:	01 d0                	add    %edx,%eax
  800543:	c1 e0 02             	shl    $0x2,%eax
  800546:	01 c8                	add    %ecx,%eax
  800548:	8b 00                	mov    (%eax),%eax
  80054a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80054d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800550:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800555:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800557:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80055a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800561:	8b 45 08             	mov    0x8(%ebp),%eax
  800564:	01 c8                	add    %ecx,%eax
  800566:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800568:	39 c2                	cmp    %eax,%edx
  80056a:	75 09                	jne    800575 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80056c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800573:	eb 12                	jmp    800587 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800575:	ff 45 e8             	incl   -0x18(%ebp)
  800578:	a1 20 30 80 00       	mov    0x803020,%eax
  80057d:	8b 50 74             	mov    0x74(%eax),%edx
  800580:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800583:	39 c2                	cmp    %eax,%edx
  800585:	77 88                	ja     80050f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800587:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80058b:	75 14                	jne    8005a1 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80058d:	83 ec 04             	sub    $0x4,%esp
  800590:	68 8c 23 80 00       	push   $0x80238c
  800595:	6a 3a                	push   $0x3a
  800597:	68 80 23 80 00       	push   $0x802380
  80059c:	e8 93 fe ff ff       	call   800434 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005a1:	ff 45 f0             	incl   -0x10(%ebp)
  8005a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005a7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005aa:	0f 8c 32 ff ff ff    	jl     8004e2 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8005b0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005b7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8005be:	eb 26                	jmp    8005e6 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8005c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8005c5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8005cb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005ce:	89 d0                	mov    %edx,%eax
  8005d0:	01 c0                	add    %eax,%eax
  8005d2:	01 d0                	add    %edx,%eax
  8005d4:	c1 e0 02             	shl    $0x2,%eax
  8005d7:	01 c8                	add    %ecx,%eax
  8005d9:	8a 40 04             	mov    0x4(%eax),%al
  8005dc:	3c 01                	cmp    $0x1,%al
  8005de:	75 03                	jne    8005e3 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8005e0:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005e3:	ff 45 e0             	incl   -0x20(%ebp)
  8005e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8005eb:	8b 50 74             	mov    0x74(%eax),%edx
  8005ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005f1:	39 c2                	cmp    %eax,%edx
  8005f3:	77 cb                	ja     8005c0 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8005f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005fb:	74 14                	je     800611 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8005fd:	83 ec 04             	sub    $0x4,%esp
  800600:	68 e0 23 80 00       	push   $0x8023e0
  800605:	6a 44                	push   $0x44
  800607:	68 80 23 80 00       	push   $0x802380
  80060c:	e8 23 fe ff ff       	call   800434 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800611:	90                   	nop
  800612:	c9                   	leave  
  800613:	c3                   	ret    

00800614 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800614:	55                   	push   %ebp
  800615:	89 e5                	mov    %esp,%ebp
  800617:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80061a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061d:	8b 00                	mov    (%eax),%eax
  80061f:	8d 48 01             	lea    0x1(%eax),%ecx
  800622:	8b 55 0c             	mov    0xc(%ebp),%edx
  800625:	89 0a                	mov    %ecx,(%edx)
  800627:	8b 55 08             	mov    0x8(%ebp),%edx
  80062a:	88 d1                	mov    %dl,%cl
  80062c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80062f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800633:	8b 45 0c             	mov    0xc(%ebp),%eax
  800636:	8b 00                	mov    (%eax),%eax
  800638:	3d ff 00 00 00       	cmp    $0xff,%eax
  80063d:	75 2c                	jne    80066b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80063f:	a0 24 30 80 00       	mov    0x803024,%al
  800644:	0f b6 c0             	movzbl %al,%eax
  800647:	8b 55 0c             	mov    0xc(%ebp),%edx
  80064a:	8b 12                	mov    (%edx),%edx
  80064c:	89 d1                	mov    %edx,%ecx
  80064e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800651:	83 c2 08             	add    $0x8,%edx
  800654:	83 ec 04             	sub    $0x4,%esp
  800657:	50                   	push   %eax
  800658:	51                   	push   %ecx
  800659:	52                   	push   %edx
  80065a:	e8 ce 10 00 00       	call   80172d <sys_cputs>
  80065f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800662:	8b 45 0c             	mov    0xc(%ebp),%eax
  800665:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80066b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80066e:	8b 40 04             	mov    0x4(%eax),%eax
  800671:	8d 50 01             	lea    0x1(%eax),%edx
  800674:	8b 45 0c             	mov    0xc(%ebp),%eax
  800677:	89 50 04             	mov    %edx,0x4(%eax)
}
  80067a:	90                   	nop
  80067b:	c9                   	leave  
  80067c:	c3                   	ret    

0080067d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80067d:	55                   	push   %ebp
  80067e:	89 e5                	mov    %esp,%ebp
  800680:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800686:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80068d:	00 00 00 
	b.cnt = 0;
  800690:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800697:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80069a:	ff 75 0c             	pushl  0xc(%ebp)
  80069d:	ff 75 08             	pushl  0x8(%ebp)
  8006a0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006a6:	50                   	push   %eax
  8006a7:	68 14 06 80 00       	push   $0x800614
  8006ac:	e8 11 02 00 00       	call   8008c2 <vprintfmt>
  8006b1:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006b4:	a0 24 30 80 00       	mov    0x803024,%al
  8006b9:	0f b6 c0             	movzbl %al,%eax
  8006bc:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8006c2:	83 ec 04             	sub    $0x4,%esp
  8006c5:	50                   	push   %eax
  8006c6:	52                   	push   %edx
  8006c7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006cd:	83 c0 08             	add    $0x8,%eax
  8006d0:	50                   	push   %eax
  8006d1:	e8 57 10 00 00       	call   80172d <sys_cputs>
  8006d6:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8006d9:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8006e0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8006e6:	c9                   	leave  
  8006e7:	c3                   	ret    

008006e8 <cprintf>:

int cprintf(const char *fmt, ...) {
  8006e8:	55                   	push   %ebp
  8006e9:	89 e5                	mov    %esp,%ebp
  8006eb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006ee:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8006f5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fe:	83 ec 08             	sub    $0x8,%esp
  800701:	ff 75 f4             	pushl  -0xc(%ebp)
  800704:	50                   	push   %eax
  800705:	e8 73 ff ff ff       	call   80067d <vcprintf>
  80070a:	83 c4 10             	add    $0x10,%esp
  80070d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800710:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800713:	c9                   	leave  
  800714:	c3                   	ret    

00800715 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800715:	55                   	push   %ebp
  800716:	89 e5                	mov    %esp,%ebp
  800718:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80071b:	e8 1e 12 00 00       	call   80193e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800720:	8d 45 0c             	lea    0xc(%ebp),%eax
  800723:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800726:	8b 45 08             	mov    0x8(%ebp),%eax
  800729:	83 ec 08             	sub    $0x8,%esp
  80072c:	ff 75 f4             	pushl  -0xc(%ebp)
  80072f:	50                   	push   %eax
  800730:	e8 48 ff ff ff       	call   80067d <vcprintf>
  800735:	83 c4 10             	add    $0x10,%esp
  800738:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80073b:	e8 18 12 00 00       	call   801958 <sys_enable_interrupt>
	return cnt;
  800740:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800743:	c9                   	leave  
  800744:	c3                   	ret    

00800745 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800745:	55                   	push   %ebp
  800746:	89 e5                	mov    %esp,%ebp
  800748:	53                   	push   %ebx
  800749:	83 ec 14             	sub    $0x14,%esp
  80074c:	8b 45 10             	mov    0x10(%ebp),%eax
  80074f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800752:	8b 45 14             	mov    0x14(%ebp),%eax
  800755:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800758:	8b 45 18             	mov    0x18(%ebp),%eax
  80075b:	ba 00 00 00 00       	mov    $0x0,%edx
  800760:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800763:	77 55                	ja     8007ba <printnum+0x75>
  800765:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800768:	72 05                	jb     80076f <printnum+0x2a>
  80076a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80076d:	77 4b                	ja     8007ba <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80076f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800772:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800775:	8b 45 18             	mov    0x18(%ebp),%eax
  800778:	ba 00 00 00 00       	mov    $0x0,%edx
  80077d:	52                   	push   %edx
  80077e:	50                   	push   %eax
  80077f:	ff 75 f4             	pushl  -0xc(%ebp)
  800782:	ff 75 f0             	pushl  -0x10(%ebp)
  800785:	e8 46 16 00 00       	call   801dd0 <__udivdi3>
  80078a:	83 c4 10             	add    $0x10,%esp
  80078d:	83 ec 04             	sub    $0x4,%esp
  800790:	ff 75 20             	pushl  0x20(%ebp)
  800793:	53                   	push   %ebx
  800794:	ff 75 18             	pushl  0x18(%ebp)
  800797:	52                   	push   %edx
  800798:	50                   	push   %eax
  800799:	ff 75 0c             	pushl  0xc(%ebp)
  80079c:	ff 75 08             	pushl  0x8(%ebp)
  80079f:	e8 a1 ff ff ff       	call   800745 <printnum>
  8007a4:	83 c4 20             	add    $0x20,%esp
  8007a7:	eb 1a                	jmp    8007c3 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007a9:	83 ec 08             	sub    $0x8,%esp
  8007ac:	ff 75 0c             	pushl  0xc(%ebp)
  8007af:	ff 75 20             	pushl  0x20(%ebp)
  8007b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b5:	ff d0                	call   *%eax
  8007b7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007ba:	ff 4d 1c             	decl   0x1c(%ebp)
  8007bd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007c1:	7f e6                	jg     8007a9 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007c3:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007c6:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007d1:	53                   	push   %ebx
  8007d2:	51                   	push   %ecx
  8007d3:	52                   	push   %edx
  8007d4:	50                   	push   %eax
  8007d5:	e8 06 17 00 00       	call   801ee0 <__umoddi3>
  8007da:	83 c4 10             	add    $0x10,%esp
  8007dd:	05 54 26 80 00       	add    $0x802654,%eax
  8007e2:	8a 00                	mov    (%eax),%al
  8007e4:	0f be c0             	movsbl %al,%eax
  8007e7:	83 ec 08             	sub    $0x8,%esp
  8007ea:	ff 75 0c             	pushl  0xc(%ebp)
  8007ed:	50                   	push   %eax
  8007ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f1:	ff d0                	call   *%eax
  8007f3:	83 c4 10             	add    $0x10,%esp
}
  8007f6:	90                   	nop
  8007f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007fa:	c9                   	leave  
  8007fb:	c3                   	ret    

008007fc <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007fc:	55                   	push   %ebp
  8007fd:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007ff:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800803:	7e 1c                	jle    800821 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800805:	8b 45 08             	mov    0x8(%ebp),%eax
  800808:	8b 00                	mov    (%eax),%eax
  80080a:	8d 50 08             	lea    0x8(%eax),%edx
  80080d:	8b 45 08             	mov    0x8(%ebp),%eax
  800810:	89 10                	mov    %edx,(%eax)
  800812:	8b 45 08             	mov    0x8(%ebp),%eax
  800815:	8b 00                	mov    (%eax),%eax
  800817:	83 e8 08             	sub    $0x8,%eax
  80081a:	8b 50 04             	mov    0x4(%eax),%edx
  80081d:	8b 00                	mov    (%eax),%eax
  80081f:	eb 40                	jmp    800861 <getuint+0x65>
	else if (lflag)
  800821:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800825:	74 1e                	je     800845 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800827:	8b 45 08             	mov    0x8(%ebp),%eax
  80082a:	8b 00                	mov    (%eax),%eax
  80082c:	8d 50 04             	lea    0x4(%eax),%edx
  80082f:	8b 45 08             	mov    0x8(%ebp),%eax
  800832:	89 10                	mov    %edx,(%eax)
  800834:	8b 45 08             	mov    0x8(%ebp),%eax
  800837:	8b 00                	mov    (%eax),%eax
  800839:	83 e8 04             	sub    $0x4,%eax
  80083c:	8b 00                	mov    (%eax),%eax
  80083e:	ba 00 00 00 00       	mov    $0x0,%edx
  800843:	eb 1c                	jmp    800861 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800845:	8b 45 08             	mov    0x8(%ebp),%eax
  800848:	8b 00                	mov    (%eax),%eax
  80084a:	8d 50 04             	lea    0x4(%eax),%edx
  80084d:	8b 45 08             	mov    0x8(%ebp),%eax
  800850:	89 10                	mov    %edx,(%eax)
  800852:	8b 45 08             	mov    0x8(%ebp),%eax
  800855:	8b 00                	mov    (%eax),%eax
  800857:	83 e8 04             	sub    $0x4,%eax
  80085a:	8b 00                	mov    (%eax),%eax
  80085c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800861:	5d                   	pop    %ebp
  800862:	c3                   	ret    

00800863 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800863:	55                   	push   %ebp
  800864:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800866:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80086a:	7e 1c                	jle    800888 <getint+0x25>
		return va_arg(*ap, long long);
  80086c:	8b 45 08             	mov    0x8(%ebp),%eax
  80086f:	8b 00                	mov    (%eax),%eax
  800871:	8d 50 08             	lea    0x8(%eax),%edx
  800874:	8b 45 08             	mov    0x8(%ebp),%eax
  800877:	89 10                	mov    %edx,(%eax)
  800879:	8b 45 08             	mov    0x8(%ebp),%eax
  80087c:	8b 00                	mov    (%eax),%eax
  80087e:	83 e8 08             	sub    $0x8,%eax
  800881:	8b 50 04             	mov    0x4(%eax),%edx
  800884:	8b 00                	mov    (%eax),%eax
  800886:	eb 38                	jmp    8008c0 <getint+0x5d>
	else if (lflag)
  800888:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80088c:	74 1a                	je     8008a8 <getint+0x45>
		return va_arg(*ap, long);
  80088e:	8b 45 08             	mov    0x8(%ebp),%eax
  800891:	8b 00                	mov    (%eax),%eax
  800893:	8d 50 04             	lea    0x4(%eax),%edx
  800896:	8b 45 08             	mov    0x8(%ebp),%eax
  800899:	89 10                	mov    %edx,(%eax)
  80089b:	8b 45 08             	mov    0x8(%ebp),%eax
  80089e:	8b 00                	mov    (%eax),%eax
  8008a0:	83 e8 04             	sub    $0x4,%eax
  8008a3:	8b 00                	mov    (%eax),%eax
  8008a5:	99                   	cltd   
  8008a6:	eb 18                	jmp    8008c0 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ab:	8b 00                	mov    (%eax),%eax
  8008ad:	8d 50 04             	lea    0x4(%eax),%edx
  8008b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b3:	89 10                	mov    %edx,(%eax)
  8008b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b8:	8b 00                	mov    (%eax),%eax
  8008ba:	83 e8 04             	sub    $0x4,%eax
  8008bd:	8b 00                	mov    (%eax),%eax
  8008bf:	99                   	cltd   
}
  8008c0:	5d                   	pop    %ebp
  8008c1:	c3                   	ret    

008008c2 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008c2:	55                   	push   %ebp
  8008c3:	89 e5                	mov    %esp,%ebp
  8008c5:	56                   	push   %esi
  8008c6:	53                   	push   %ebx
  8008c7:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008ca:	eb 17                	jmp    8008e3 <vprintfmt+0x21>
			if (ch == '\0')
  8008cc:	85 db                	test   %ebx,%ebx
  8008ce:	0f 84 af 03 00 00    	je     800c83 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8008d4:	83 ec 08             	sub    $0x8,%esp
  8008d7:	ff 75 0c             	pushl  0xc(%ebp)
  8008da:	53                   	push   %ebx
  8008db:	8b 45 08             	mov    0x8(%ebp),%eax
  8008de:	ff d0                	call   *%eax
  8008e0:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e6:	8d 50 01             	lea    0x1(%eax),%edx
  8008e9:	89 55 10             	mov    %edx,0x10(%ebp)
  8008ec:	8a 00                	mov    (%eax),%al
  8008ee:	0f b6 d8             	movzbl %al,%ebx
  8008f1:	83 fb 25             	cmp    $0x25,%ebx
  8008f4:	75 d6                	jne    8008cc <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008f6:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008fa:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800901:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800908:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80090f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800916:	8b 45 10             	mov    0x10(%ebp),%eax
  800919:	8d 50 01             	lea    0x1(%eax),%edx
  80091c:	89 55 10             	mov    %edx,0x10(%ebp)
  80091f:	8a 00                	mov    (%eax),%al
  800921:	0f b6 d8             	movzbl %al,%ebx
  800924:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800927:	83 f8 55             	cmp    $0x55,%eax
  80092a:	0f 87 2b 03 00 00    	ja     800c5b <vprintfmt+0x399>
  800930:	8b 04 85 78 26 80 00 	mov    0x802678(,%eax,4),%eax
  800937:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800939:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80093d:	eb d7                	jmp    800916 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80093f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800943:	eb d1                	jmp    800916 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800945:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80094c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80094f:	89 d0                	mov    %edx,%eax
  800951:	c1 e0 02             	shl    $0x2,%eax
  800954:	01 d0                	add    %edx,%eax
  800956:	01 c0                	add    %eax,%eax
  800958:	01 d8                	add    %ebx,%eax
  80095a:	83 e8 30             	sub    $0x30,%eax
  80095d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800960:	8b 45 10             	mov    0x10(%ebp),%eax
  800963:	8a 00                	mov    (%eax),%al
  800965:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800968:	83 fb 2f             	cmp    $0x2f,%ebx
  80096b:	7e 3e                	jle    8009ab <vprintfmt+0xe9>
  80096d:	83 fb 39             	cmp    $0x39,%ebx
  800970:	7f 39                	jg     8009ab <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800972:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800975:	eb d5                	jmp    80094c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800977:	8b 45 14             	mov    0x14(%ebp),%eax
  80097a:	83 c0 04             	add    $0x4,%eax
  80097d:	89 45 14             	mov    %eax,0x14(%ebp)
  800980:	8b 45 14             	mov    0x14(%ebp),%eax
  800983:	83 e8 04             	sub    $0x4,%eax
  800986:	8b 00                	mov    (%eax),%eax
  800988:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80098b:	eb 1f                	jmp    8009ac <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80098d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800991:	79 83                	jns    800916 <vprintfmt+0x54>
				width = 0;
  800993:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80099a:	e9 77 ff ff ff       	jmp    800916 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80099f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009a6:	e9 6b ff ff ff       	jmp    800916 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009ab:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009ac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009b0:	0f 89 60 ff ff ff    	jns    800916 <vprintfmt+0x54>
				width = precision, precision = -1;
  8009b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009bc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009c3:	e9 4e ff ff ff       	jmp    800916 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009c8:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009cb:	e9 46 ff ff ff       	jmp    800916 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d3:	83 c0 04             	add    $0x4,%eax
  8009d6:	89 45 14             	mov    %eax,0x14(%ebp)
  8009d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8009dc:	83 e8 04             	sub    $0x4,%eax
  8009df:	8b 00                	mov    (%eax),%eax
  8009e1:	83 ec 08             	sub    $0x8,%esp
  8009e4:	ff 75 0c             	pushl  0xc(%ebp)
  8009e7:	50                   	push   %eax
  8009e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009eb:	ff d0                	call   *%eax
  8009ed:	83 c4 10             	add    $0x10,%esp
			break;
  8009f0:	e9 89 02 00 00       	jmp    800c7e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f8:	83 c0 04             	add    $0x4,%eax
  8009fb:	89 45 14             	mov    %eax,0x14(%ebp)
  8009fe:	8b 45 14             	mov    0x14(%ebp),%eax
  800a01:	83 e8 04             	sub    $0x4,%eax
  800a04:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a06:	85 db                	test   %ebx,%ebx
  800a08:	79 02                	jns    800a0c <vprintfmt+0x14a>
				err = -err;
  800a0a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a0c:	83 fb 64             	cmp    $0x64,%ebx
  800a0f:	7f 0b                	jg     800a1c <vprintfmt+0x15a>
  800a11:	8b 34 9d c0 24 80 00 	mov    0x8024c0(,%ebx,4),%esi
  800a18:	85 f6                	test   %esi,%esi
  800a1a:	75 19                	jne    800a35 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a1c:	53                   	push   %ebx
  800a1d:	68 65 26 80 00       	push   $0x802665
  800a22:	ff 75 0c             	pushl  0xc(%ebp)
  800a25:	ff 75 08             	pushl  0x8(%ebp)
  800a28:	e8 5e 02 00 00       	call   800c8b <printfmt>
  800a2d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a30:	e9 49 02 00 00       	jmp    800c7e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a35:	56                   	push   %esi
  800a36:	68 6e 26 80 00       	push   $0x80266e
  800a3b:	ff 75 0c             	pushl  0xc(%ebp)
  800a3e:	ff 75 08             	pushl  0x8(%ebp)
  800a41:	e8 45 02 00 00       	call   800c8b <printfmt>
  800a46:	83 c4 10             	add    $0x10,%esp
			break;
  800a49:	e9 30 02 00 00       	jmp    800c7e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a4e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a51:	83 c0 04             	add    $0x4,%eax
  800a54:	89 45 14             	mov    %eax,0x14(%ebp)
  800a57:	8b 45 14             	mov    0x14(%ebp),%eax
  800a5a:	83 e8 04             	sub    $0x4,%eax
  800a5d:	8b 30                	mov    (%eax),%esi
  800a5f:	85 f6                	test   %esi,%esi
  800a61:	75 05                	jne    800a68 <vprintfmt+0x1a6>
				p = "(null)";
  800a63:	be 71 26 80 00       	mov    $0x802671,%esi
			if (width > 0 && padc != '-')
  800a68:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a6c:	7e 6d                	jle    800adb <vprintfmt+0x219>
  800a6e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a72:	74 67                	je     800adb <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a74:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a77:	83 ec 08             	sub    $0x8,%esp
  800a7a:	50                   	push   %eax
  800a7b:	56                   	push   %esi
  800a7c:	e8 0c 03 00 00       	call   800d8d <strnlen>
  800a81:	83 c4 10             	add    $0x10,%esp
  800a84:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a87:	eb 16                	jmp    800a9f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a89:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a8d:	83 ec 08             	sub    $0x8,%esp
  800a90:	ff 75 0c             	pushl  0xc(%ebp)
  800a93:	50                   	push   %eax
  800a94:	8b 45 08             	mov    0x8(%ebp),%eax
  800a97:	ff d0                	call   *%eax
  800a99:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a9c:	ff 4d e4             	decl   -0x1c(%ebp)
  800a9f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aa3:	7f e4                	jg     800a89 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800aa5:	eb 34                	jmp    800adb <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800aa7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800aab:	74 1c                	je     800ac9 <vprintfmt+0x207>
  800aad:	83 fb 1f             	cmp    $0x1f,%ebx
  800ab0:	7e 05                	jle    800ab7 <vprintfmt+0x1f5>
  800ab2:	83 fb 7e             	cmp    $0x7e,%ebx
  800ab5:	7e 12                	jle    800ac9 <vprintfmt+0x207>
					putch('?', putdat);
  800ab7:	83 ec 08             	sub    $0x8,%esp
  800aba:	ff 75 0c             	pushl  0xc(%ebp)
  800abd:	6a 3f                	push   $0x3f
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	ff d0                	call   *%eax
  800ac4:	83 c4 10             	add    $0x10,%esp
  800ac7:	eb 0f                	jmp    800ad8 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800ac9:	83 ec 08             	sub    $0x8,%esp
  800acc:	ff 75 0c             	pushl  0xc(%ebp)
  800acf:	53                   	push   %ebx
  800ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad3:	ff d0                	call   *%eax
  800ad5:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ad8:	ff 4d e4             	decl   -0x1c(%ebp)
  800adb:	89 f0                	mov    %esi,%eax
  800add:	8d 70 01             	lea    0x1(%eax),%esi
  800ae0:	8a 00                	mov    (%eax),%al
  800ae2:	0f be d8             	movsbl %al,%ebx
  800ae5:	85 db                	test   %ebx,%ebx
  800ae7:	74 24                	je     800b0d <vprintfmt+0x24b>
  800ae9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800aed:	78 b8                	js     800aa7 <vprintfmt+0x1e5>
  800aef:	ff 4d e0             	decl   -0x20(%ebp)
  800af2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800af6:	79 af                	jns    800aa7 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800af8:	eb 13                	jmp    800b0d <vprintfmt+0x24b>
				putch(' ', putdat);
  800afa:	83 ec 08             	sub    $0x8,%esp
  800afd:	ff 75 0c             	pushl  0xc(%ebp)
  800b00:	6a 20                	push   $0x20
  800b02:	8b 45 08             	mov    0x8(%ebp),%eax
  800b05:	ff d0                	call   *%eax
  800b07:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b0a:	ff 4d e4             	decl   -0x1c(%ebp)
  800b0d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b11:	7f e7                	jg     800afa <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b13:	e9 66 01 00 00       	jmp    800c7e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b18:	83 ec 08             	sub    $0x8,%esp
  800b1b:	ff 75 e8             	pushl  -0x18(%ebp)
  800b1e:	8d 45 14             	lea    0x14(%ebp),%eax
  800b21:	50                   	push   %eax
  800b22:	e8 3c fd ff ff       	call   800863 <getint>
  800b27:	83 c4 10             	add    $0x10,%esp
  800b2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b2d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b30:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b33:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b36:	85 d2                	test   %edx,%edx
  800b38:	79 23                	jns    800b5d <vprintfmt+0x29b>
				putch('-', putdat);
  800b3a:	83 ec 08             	sub    $0x8,%esp
  800b3d:	ff 75 0c             	pushl  0xc(%ebp)
  800b40:	6a 2d                	push   $0x2d
  800b42:	8b 45 08             	mov    0x8(%ebp),%eax
  800b45:	ff d0                	call   *%eax
  800b47:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b50:	f7 d8                	neg    %eax
  800b52:	83 d2 00             	adc    $0x0,%edx
  800b55:	f7 da                	neg    %edx
  800b57:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b5a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b5d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b64:	e9 bc 00 00 00       	jmp    800c25 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b69:	83 ec 08             	sub    $0x8,%esp
  800b6c:	ff 75 e8             	pushl  -0x18(%ebp)
  800b6f:	8d 45 14             	lea    0x14(%ebp),%eax
  800b72:	50                   	push   %eax
  800b73:	e8 84 fc ff ff       	call   8007fc <getuint>
  800b78:	83 c4 10             	add    $0x10,%esp
  800b7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b7e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b81:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b88:	e9 98 00 00 00       	jmp    800c25 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b8d:	83 ec 08             	sub    $0x8,%esp
  800b90:	ff 75 0c             	pushl  0xc(%ebp)
  800b93:	6a 58                	push   $0x58
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	ff d0                	call   *%eax
  800b9a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b9d:	83 ec 08             	sub    $0x8,%esp
  800ba0:	ff 75 0c             	pushl  0xc(%ebp)
  800ba3:	6a 58                	push   $0x58
  800ba5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba8:	ff d0                	call   *%eax
  800baa:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bad:	83 ec 08             	sub    $0x8,%esp
  800bb0:	ff 75 0c             	pushl  0xc(%ebp)
  800bb3:	6a 58                	push   $0x58
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	ff d0                	call   *%eax
  800bba:	83 c4 10             	add    $0x10,%esp
			break;
  800bbd:	e9 bc 00 00 00       	jmp    800c7e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800bc2:	83 ec 08             	sub    $0x8,%esp
  800bc5:	ff 75 0c             	pushl  0xc(%ebp)
  800bc8:	6a 30                	push   $0x30
  800bca:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcd:	ff d0                	call   *%eax
  800bcf:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800bd2:	83 ec 08             	sub    $0x8,%esp
  800bd5:	ff 75 0c             	pushl  0xc(%ebp)
  800bd8:	6a 78                	push   $0x78
  800bda:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdd:	ff d0                	call   *%eax
  800bdf:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800be2:	8b 45 14             	mov    0x14(%ebp),%eax
  800be5:	83 c0 04             	add    $0x4,%eax
  800be8:	89 45 14             	mov    %eax,0x14(%ebp)
  800beb:	8b 45 14             	mov    0x14(%ebp),%eax
  800bee:	83 e8 04             	sub    $0x4,%eax
  800bf1:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800bf3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800bfd:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c04:	eb 1f                	jmp    800c25 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c06:	83 ec 08             	sub    $0x8,%esp
  800c09:	ff 75 e8             	pushl  -0x18(%ebp)
  800c0c:	8d 45 14             	lea    0x14(%ebp),%eax
  800c0f:	50                   	push   %eax
  800c10:	e8 e7 fb ff ff       	call   8007fc <getuint>
  800c15:	83 c4 10             	add    $0x10,%esp
  800c18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c1b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c1e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c25:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c29:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c2c:	83 ec 04             	sub    $0x4,%esp
  800c2f:	52                   	push   %edx
  800c30:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c33:	50                   	push   %eax
  800c34:	ff 75 f4             	pushl  -0xc(%ebp)
  800c37:	ff 75 f0             	pushl  -0x10(%ebp)
  800c3a:	ff 75 0c             	pushl  0xc(%ebp)
  800c3d:	ff 75 08             	pushl  0x8(%ebp)
  800c40:	e8 00 fb ff ff       	call   800745 <printnum>
  800c45:	83 c4 20             	add    $0x20,%esp
			break;
  800c48:	eb 34                	jmp    800c7e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c4a:	83 ec 08             	sub    $0x8,%esp
  800c4d:	ff 75 0c             	pushl  0xc(%ebp)
  800c50:	53                   	push   %ebx
  800c51:	8b 45 08             	mov    0x8(%ebp),%eax
  800c54:	ff d0                	call   *%eax
  800c56:	83 c4 10             	add    $0x10,%esp
			break;
  800c59:	eb 23                	jmp    800c7e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c5b:	83 ec 08             	sub    $0x8,%esp
  800c5e:	ff 75 0c             	pushl  0xc(%ebp)
  800c61:	6a 25                	push   $0x25
  800c63:	8b 45 08             	mov    0x8(%ebp),%eax
  800c66:	ff d0                	call   *%eax
  800c68:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c6b:	ff 4d 10             	decl   0x10(%ebp)
  800c6e:	eb 03                	jmp    800c73 <vprintfmt+0x3b1>
  800c70:	ff 4d 10             	decl   0x10(%ebp)
  800c73:	8b 45 10             	mov    0x10(%ebp),%eax
  800c76:	48                   	dec    %eax
  800c77:	8a 00                	mov    (%eax),%al
  800c79:	3c 25                	cmp    $0x25,%al
  800c7b:	75 f3                	jne    800c70 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c7d:	90                   	nop
		}
	}
  800c7e:	e9 47 fc ff ff       	jmp    8008ca <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c83:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c84:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c87:	5b                   	pop    %ebx
  800c88:	5e                   	pop    %esi
  800c89:	5d                   	pop    %ebp
  800c8a:	c3                   	ret    

00800c8b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c8b:	55                   	push   %ebp
  800c8c:	89 e5                	mov    %esp,%ebp
  800c8e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c91:	8d 45 10             	lea    0x10(%ebp),%eax
  800c94:	83 c0 04             	add    $0x4,%eax
  800c97:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9d:	ff 75 f4             	pushl  -0xc(%ebp)
  800ca0:	50                   	push   %eax
  800ca1:	ff 75 0c             	pushl  0xc(%ebp)
  800ca4:	ff 75 08             	pushl  0x8(%ebp)
  800ca7:	e8 16 fc ff ff       	call   8008c2 <vprintfmt>
  800cac:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800caf:	90                   	nop
  800cb0:	c9                   	leave  
  800cb1:	c3                   	ret    

00800cb2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800cb2:	55                   	push   %ebp
  800cb3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800cb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb8:	8b 40 08             	mov    0x8(%eax),%eax
  800cbb:	8d 50 01             	lea    0x1(%eax),%edx
  800cbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800cc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc7:	8b 10                	mov    (%eax),%edx
  800cc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ccc:	8b 40 04             	mov    0x4(%eax),%eax
  800ccf:	39 c2                	cmp    %eax,%edx
  800cd1:	73 12                	jae    800ce5 <sprintputch+0x33>
		*b->buf++ = ch;
  800cd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd6:	8b 00                	mov    (%eax),%eax
  800cd8:	8d 48 01             	lea    0x1(%eax),%ecx
  800cdb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cde:	89 0a                	mov    %ecx,(%edx)
  800ce0:	8b 55 08             	mov    0x8(%ebp),%edx
  800ce3:	88 10                	mov    %dl,(%eax)
}
  800ce5:	90                   	nop
  800ce6:	5d                   	pop    %ebp
  800ce7:	c3                   	ret    

00800ce8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ce8:	55                   	push   %ebp
  800ce9:	89 e5                	mov    %esp,%ebp
  800ceb:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800cf4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	01 d0                	add    %edx,%eax
  800cff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d09:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d0d:	74 06                	je     800d15 <vsnprintf+0x2d>
  800d0f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d13:	7f 07                	jg     800d1c <vsnprintf+0x34>
		return -E_INVAL;
  800d15:	b8 03 00 00 00       	mov    $0x3,%eax
  800d1a:	eb 20                	jmp    800d3c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d1c:	ff 75 14             	pushl  0x14(%ebp)
  800d1f:	ff 75 10             	pushl  0x10(%ebp)
  800d22:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d25:	50                   	push   %eax
  800d26:	68 b2 0c 80 00       	push   $0x800cb2
  800d2b:	e8 92 fb ff ff       	call   8008c2 <vprintfmt>
  800d30:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d33:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d36:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d39:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d3c:	c9                   	leave  
  800d3d:	c3                   	ret    

00800d3e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d3e:	55                   	push   %ebp
  800d3f:	89 e5                	mov    %esp,%ebp
  800d41:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d44:	8d 45 10             	lea    0x10(%ebp),%eax
  800d47:	83 c0 04             	add    $0x4,%eax
  800d4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d50:	ff 75 f4             	pushl  -0xc(%ebp)
  800d53:	50                   	push   %eax
  800d54:	ff 75 0c             	pushl  0xc(%ebp)
  800d57:	ff 75 08             	pushl  0x8(%ebp)
  800d5a:	e8 89 ff ff ff       	call   800ce8 <vsnprintf>
  800d5f:	83 c4 10             	add    $0x10,%esp
  800d62:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d65:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d68:	c9                   	leave  
  800d69:	c3                   	ret    

00800d6a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d6a:	55                   	push   %ebp
  800d6b:	89 e5                	mov    %esp,%ebp
  800d6d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d70:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d77:	eb 06                	jmp    800d7f <strlen+0x15>
		n++;
  800d79:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d7c:	ff 45 08             	incl   0x8(%ebp)
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	8a 00                	mov    (%eax),%al
  800d84:	84 c0                	test   %al,%al
  800d86:	75 f1                	jne    800d79 <strlen+0xf>
		n++;
	return n;
  800d88:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d8b:	c9                   	leave  
  800d8c:	c3                   	ret    

00800d8d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d8d:	55                   	push   %ebp
  800d8e:	89 e5                	mov    %esp,%ebp
  800d90:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d93:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d9a:	eb 09                	jmp    800da5 <strnlen+0x18>
		n++;
  800d9c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d9f:	ff 45 08             	incl   0x8(%ebp)
  800da2:	ff 4d 0c             	decl   0xc(%ebp)
  800da5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800da9:	74 09                	je     800db4 <strnlen+0x27>
  800dab:	8b 45 08             	mov    0x8(%ebp),%eax
  800dae:	8a 00                	mov    (%eax),%al
  800db0:	84 c0                	test   %al,%al
  800db2:	75 e8                	jne    800d9c <strnlen+0xf>
		n++;
	return n;
  800db4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800db7:	c9                   	leave  
  800db8:	c3                   	ret    

00800db9 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800db9:	55                   	push   %ebp
  800dba:	89 e5                	mov    %esp,%ebp
  800dbc:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800dc5:	90                   	nop
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc9:	8d 50 01             	lea    0x1(%eax),%edx
  800dcc:	89 55 08             	mov    %edx,0x8(%ebp)
  800dcf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dd2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dd5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800dd8:	8a 12                	mov    (%edx),%dl
  800dda:	88 10                	mov    %dl,(%eax)
  800ddc:	8a 00                	mov    (%eax),%al
  800dde:	84 c0                	test   %al,%al
  800de0:	75 e4                	jne    800dc6 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800de2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800de5:	c9                   	leave  
  800de6:	c3                   	ret    

00800de7 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800de7:	55                   	push   %ebp
  800de8:	89 e5                	mov    %esp,%ebp
  800dea:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
  800df0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800df3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dfa:	eb 1f                	jmp    800e1b <strncpy+0x34>
		*dst++ = *src;
  800dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dff:	8d 50 01             	lea    0x1(%eax),%edx
  800e02:	89 55 08             	mov    %edx,0x8(%ebp)
  800e05:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e08:	8a 12                	mov    (%edx),%dl
  800e0a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0f:	8a 00                	mov    (%eax),%al
  800e11:	84 c0                	test   %al,%al
  800e13:	74 03                	je     800e18 <strncpy+0x31>
			src++;
  800e15:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e18:	ff 45 fc             	incl   -0x4(%ebp)
  800e1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e21:	72 d9                	jb     800dfc <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e23:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e26:	c9                   	leave  
  800e27:	c3                   	ret    

00800e28 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e28:	55                   	push   %ebp
  800e29:	89 e5                	mov    %esp,%ebp
  800e2b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e38:	74 30                	je     800e6a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e3a:	eb 16                	jmp    800e52 <strlcpy+0x2a>
			*dst++ = *src++;
  800e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3f:	8d 50 01             	lea    0x1(%eax),%edx
  800e42:	89 55 08             	mov    %edx,0x8(%ebp)
  800e45:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e48:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e4b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e4e:	8a 12                	mov    (%edx),%dl
  800e50:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e52:	ff 4d 10             	decl   0x10(%ebp)
  800e55:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e59:	74 09                	je     800e64 <strlcpy+0x3c>
  800e5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5e:	8a 00                	mov    (%eax),%al
  800e60:	84 c0                	test   %al,%al
  800e62:	75 d8                	jne    800e3c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e6a:	8b 55 08             	mov    0x8(%ebp),%edx
  800e6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e70:	29 c2                	sub    %eax,%edx
  800e72:	89 d0                	mov    %edx,%eax
}
  800e74:	c9                   	leave  
  800e75:	c3                   	ret    

00800e76 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e76:	55                   	push   %ebp
  800e77:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e79:	eb 06                	jmp    800e81 <strcmp+0xb>
		p++, q++;
  800e7b:	ff 45 08             	incl   0x8(%ebp)
  800e7e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e81:	8b 45 08             	mov    0x8(%ebp),%eax
  800e84:	8a 00                	mov    (%eax),%al
  800e86:	84 c0                	test   %al,%al
  800e88:	74 0e                	je     800e98 <strcmp+0x22>
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	8a 10                	mov    (%eax),%dl
  800e8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e92:	8a 00                	mov    (%eax),%al
  800e94:	38 c2                	cmp    %al,%dl
  800e96:	74 e3                	je     800e7b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e98:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9b:	8a 00                	mov    (%eax),%al
  800e9d:	0f b6 d0             	movzbl %al,%edx
  800ea0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea3:	8a 00                	mov    (%eax),%al
  800ea5:	0f b6 c0             	movzbl %al,%eax
  800ea8:	29 c2                	sub    %eax,%edx
  800eaa:	89 d0                	mov    %edx,%eax
}
  800eac:	5d                   	pop    %ebp
  800ead:	c3                   	ret    

00800eae <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800eae:	55                   	push   %ebp
  800eaf:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800eb1:	eb 09                	jmp    800ebc <strncmp+0xe>
		n--, p++, q++;
  800eb3:	ff 4d 10             	decl   0x10(%ebp)
  800eb6:	ff 45 08             	incl   0x8(%ebp)
  800eb9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ebc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ec0:	74 17                	je     800ed9 <strncmp+0x2b>
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	8a 00                	mov    (%eax),%al
  800ec7:	84 c0                	test   %al,%al
  800ec9:	74 0e                	je     800ed9 <strncmp+0x2b>
  800ecb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ece:	8a 10                	mov    (%eax),%dl
  800ed0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed3:	8a 00                	mov    (%eax),%al
  800ed5:	38 c2                	cmp    %al,%dl
  800ed7:	74 da                	je     800eb3 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ed9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800edd:	75 07                	jne    800ee6 <strncmp+0x38>
		return 0;
  800edf:	b8 00 00 00 00       	mov    $0x0,%eax
  800ee4:	eb 14                	jmp    800efa <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ee6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee9:	8a 00                	mov    (%eax),%al
  800eeb:	0f b6 d0             	movzbl %al,%edx
  800eee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef1:	8a 00                	mov    (%eax),%al
  800ef3:	0f b6 c0             	movzbl %al,%eax
  800ef6:	29 c2                	sub    %eax,%edx
  800ef8:	89 d0                	mov    %edx,%eax
}
  800efa:	5d                   	pop    %ebp
  800efb:	c3                   	ret    

00800efc <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800efc:	55                   	push   %ebp
  800efd:	89 e5                	mov    %esp,%ebp
  800eff:	83 ec 04             	sub    $0x4,%esp
  800f02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f05:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f08:	eb 12                	jmp    800f1c <strchr+0x20>
		if (*s == c)
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	8a 00                	mov    (%eax),%al
  800f0f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f12:	75 05                	jne    800f19 <strchr+0x1d>
			return (char *) s;
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	eb 11                	jmp    800f2a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f19:	ff 45 08             	incl   0x8(%ebp)
  800f1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1f:	8a 00                	mov    (%eax),%al
  800f21:	84 c0                	test   %al,%al
  800f23:	75 e5                	jne    800f0a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f25:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f2a:	c9                   	leave  
  800f2b:	c3                   	ret    

00800f2c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f2c:	55                   	push   %ebp
  800f2d:	89 e5                	mov    %esp,%ebp
  800f2f:	83 ec 04             	sub    $0x4,%esp
  800f32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f35:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f38:	eb 0d                	jmp    800f47 <strfind+0x1b>
		if (*s == c)
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	8a 00                	mov    (%eax),%al
  800f3f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f42:	74 0e                	je     800f52 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f44:	ff 45 08             	incl   0x8(%ebp)
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4a:	8a 00                	mov    (%eax),%al
  800f4c:	84 c0                	test   %al,%al
  800f4e:	75 ea                	jne    800f3a <strfind+0xe>
  800f50:	eb 01                	jmp    800f53 <strfind+0x27>
		if (*s == c)
			break;
  800f52:	90                   	nop
	return (char *) s;
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f56:	c9                   	leave  
  800f57:	c3                   	ret    

00800f58 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f58:	55                   	push   %ebp
  800f59:	89 e5                	mov    %esp,%ebp
  800f5b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f61:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f64:	8b 45 10             	mov    0x10(%ebp),%eax
  800f67:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f6a:	eb 0e                	jmp    800f7a <memset+0x22>
		*p++ = c;
  800f6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f6f:	8d 50 01             	lea    0x1(%eax),%edx
  800f72:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f75:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f78:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f7a:	ff 4d f8             	decl   -0x8(%ebp)
  800f7d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f81:	79 e9                	jns    800f6c <memset+0x14>
		*p++ = c;

	return v;
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f86:	c9                   	leave  
  800f87:	c3                   	ret    

00800f88 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f88:	55                   	push   %ebp
  800f89:	89 e5                	mov    %esp,%ebp
  800f8b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f91:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f9a:	eb 16                	jmp    800fb2 <memcpy+0x2a>
		*d++ = *s++;
  800f9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f9f:	8d 50 01             	lea    0x1(%eax),%edx
  800fa2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fa5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fa8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fab:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fae:	8a 12                	mov    (%edx),%dl
  800fb0:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800fb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fb8:	89 55 10             	mov    %edx,0x10(%ebp)
  800fbb:	85 c0                	test   %eax,%eax
  800fbd:	75 dd                	jne    800f9c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800fbf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fc2:	c9                   	leave  
  800fc3:	c3                   	ret    

00800fc4 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fc4:	55                   	push   %ebp
  800fc5:	89 e5                	mov    %esp,%ebp
  800fc7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800fca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800fd6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fd9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fdc:	73 50                	jae    80102e <memmove+0x6a>
  800fde:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fe1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe4:	01 d0                	add    %edx,%eax
  800fe6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fe9:	76 43                	jbe    80102e <memmove+0x6a>
		s += n;
  800feb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fee:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ff1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff4:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ff7:	eb 10                	jmp    801009 <memmove+0x45>
			*--d = *--s;
  800ff9:	ff 4d f8             	decl   -0x8(%ebp)
  800ffc:	ff 4d fc             	decl   -0x4(%ebp)
  800fff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801002:	8a 10                	mov    (%eax),%dl
  801004:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801007:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801009:	8b 45 10             	mov    0x10(%ebp),%eax
  80100c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80100f:	89 55 10             	mov    %edx,0x10(%ebp)
  801012:	85 c0                	test   %eax,%eax
  801014:	75 e3                	jne    800ff9 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801016:	eb 23                	jmp    80103b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801018:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101b:	8d 50 01             	lea    0x1(%eax),%edx
  80101e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801021:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801024:	8d 4a 01             	lea    0x1(%edx),%ecx
  801027:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80102a:	8a 12                	mov    (%edx),%dl
  80102c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80102e:	8b 45 10             	mov    0x10(%ebp),%eax
  801031:	8d 50 ff             	lea    -0x1(%eax),%edx
  801034:	89 55 10             	mov    %edx,0x10(%ebp)
  801037:	85 c0                	test   %eax,%eax
  801039:	75 dd                	jne    801018 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80103b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80103e:	c9                   	leave  
  80103f:	c3                   	ret    

00801040 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801040:	55                   	push   %ebp
  801041:	89 e5                	mov    %esp,%ebp
  801043:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80104c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801052:	eb 2a                	jmp    80107e <memcmp+0x3e>
		if (*s1 != *s2)
  801054:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801057:	8a 10                	mov    (%eax),%dl
  801059:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80105c:	8a 00                	mov    (%eax),%al
  80105e:	38 c2                	cmp    %al,%dl
  801060:	74 16                	je     801078 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801062:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801065:	8a 00                	mov    (%eax),%al
  801067:	0f b6 d0             	movzbl %al,%edx
  80106a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106d:	8a 00                	mov    (%eax),%al
  80106f:	0f b6 c0             	movzbl %al,%eax
  801072:	29 c2                	sub    %eax,%edx
  801074:	89 d0                	mov    %edx,%eax
  801076:	eb 18                	jmp    801090 <memcmp+0x50>
		s1++, s2++;
  801078:	ff 45 fc             	incl   -0x4(%ebp)
  80107b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80107e:	8b 45 10             	mov    0x10(%ebp),%eax
  801081:	8d 50 ff             	lea    -0x1(%eax),%edx
  801084:	89 55 10             	mov    %edx,0x10(%ebp)
  801087:	85 c0                	test   %eax,%eax
  801089:	75 c9                	jne    801054 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80108b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801090:	c9                   	leave  
  801091:	c3                   	ret    

00801092 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801092:	55                   	push   %ebp
  801093:	89 e5                	mov    %esp,%ebp
  801095:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801098:	8b 55 08             	mov    0x8(%ebp),%edx
  80109b:	8b 45 10             	mov    0x10(%ebp),%eax
  80109e:	01 d0                	add    %edx,%eax
  8010a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010a3:	eb 15                	jmp    8010ba <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a8:	8a 00                	mov    (%eax),%al
  8010aa:	0f b6 d0             	movzbl %al,%edx
  8010ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b0:	0f b6 c0             	movzbl %al,%eax
  8010b3:	39 c2                	cmp    %eax,%edx
  8010b5:	74 0d                	je     8010c4 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010b7:	ff 45 08             	incl   0x8(%ebp)
  8010ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010c0:	72 e3                	jb     8010a5 <memfind+0x13>
  8010c2:	eb 01                	jmp    8010c5 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010c4:	90                   	nop
	return (void *) s;
  8010c5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010c8:	c9                   	leave  
  8010c9:	c3                   	ret    

008010ca <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010ca:	55                   	push   %ebp
  8010cb:	89 e5                	mov    %esp,%ebp
  8010cd:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010d7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010de:	eb 03                	jmp    8010e3 <strtol+0x19>
		s++;
  8010e0:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e6:	8a 00                	mov    (%eax),%al
  8010e8:	3c 20                	cmp    $0x20,%al
  8010ea:	74 f4                	je     8010e0 <strtol+0x16>
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	8a 00                	mov    (%eax),%al
  8010f1:	3c 09                	cmp    $0x9,%al
  8010f3:	74 eb                	je     8010e0 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f8:	8a 00                	mov    (%eax),%al
  8010fa:	3c 2b                	cmp    $0x2b,%al
  8010fc:	75 05                	jne    801103 <strtol+0x39>
		s++;
  8010fe:	ff 45 08             	incl   0x8(%ebp)
  801101:	eb 13                	jmp    801116 <strtol+0x4c>
	else if (*s == '-')
  801103:	8b 45 08             	mov    0x8(%ebp),%eax
  801106:	8a 00                	mov    (%eax),%al
  801108:	3c 2d                	cmp    $0x2d,%al
  80110a:	75 0a                	jne    801116 <strtol+0x4c>
		s++, neg = 1;
  80110c:	ff 45 08             	incl   0x8(%ebp)
  80110f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801116:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80111a:	74 06                	je     801122 <strtol+0x58>
  80111c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801120:	75 20                	jne    801142 <strtol+0x78>
  801122:	8b 45 08             	mov    0x8(%ebp),%eax
  801125:	8a 00                	mov    (%eax),%al
  801127:	3c 30                	cmp    $0x30,%al
  801129:	75 17                	jne    801142 <strtol+0x78>
  80112b:	8b 45 08             	mov    0x8(%ebp),%eax
  80112e:	40                   	inc    %eax
  80112f:	8a 00                	mov    (%eax),%al
  801131:	3c 78                	cmp    $0x78,%al
  801133:	75 0d                	jne    801142 <strtol+0x78>
		s += 2, base = 16;
  801135:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801139:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801140:	eb 28                	jmp    80116a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801142:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801146:	75 15                	jne    80115d <strtol+0x93>
  801148:	8b 45 08             	mov    0x8(%ebp),%eax
  80114b:	8a 00                	mov    (%eax),%al
  80114d:	3c 30                	cmp    $0x30,%al
  80114f:	75 0c                	jne    80115d <strtol+0x93>
		s++, base = 8;
  801151:	ff 45 08             	incl   0x8(%ebp)
  801154:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80115b:	eb 0d                	jmp    80116a <strtol+0xa0>
	else if (base == 0)
  80115d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801161:	75 07                	jne    80116a <strtol+0xa0>
		base = 10;
  801163:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	3c 2f                	cmp    $0x2f,%al
  801171:	7e 19                	jle    80118c <strtol+0xc2>
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	8a 00                	mov    (%eax),%al
  801178:	3c 39                	cmp    $0x39,%al
  80117a:	7f 10                	jg     80118c <strtol+0xc2>
			dig = *s - '0';
  80117c:	8b 45 08             	mov    0x8(%ebp),%eax
  80117f:	8a 00                	mov    (%eax),%al
  801181:	0f be c0             	movsbl %al,%eax
  801184:	83 e8 30             	sub    $0x30,%eax
  801187:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80118a:	eb 42                	jmp    8011ce <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80118c:	8b 45 08             	mov    0x8(%ebp),%eax
  80118f:	8a 00                	mov    (%eax),%al
  801191:	3c 60                	cmp    $0x60,%al
  801193:	7e 19                	jle    8011ae <strtol+0xe4>
  801195:	8b 45 08             	mov    0x8(%ebp),%eax
  801198:	8a 00                	mov    (%eax),%al
  80119a:	3c 7a                	cmp    $0x7a,%al
  80119c:	7f 10                	jg     8011ae <strtol+0xe4>
			dig = *s - 'a' + 10;
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	0f be c0             	movsbl %al,%eax
  8011a6:	83 e8 57             	sub    $0x57,%eax
  8011a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011ac:	eb 20                	jmp    8011ce <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	8a 00                	mov    (%eax),%al
  8011b3:	3c 40                	cmp    $0x40,%al
  8011b5:	7e 39                	jle    8011f0 <strtol+0x126>
  8011b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ba:	8a 00                	mov    (%eax),%al
  8011bc:	3c 5a                	cmp    $0x5a,%al
  8011be:	7f 30                	jg     8011f0 <strtol+0x126>
			dig = *s - 'A' + 10;
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	0f be c0             	movsbl %al,%eax
  8011c8:	83 e8 37             	sub    $0x37,%eax
  8011cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011d1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011d4:	7d 19                	jge    8011ef <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011d6:	ff 45 08             	incl   0x8(%ebp)
  8011d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011dc:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011e0:	89 c2                	mov    %eax,%edx
  8011e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011e5:	01 d0                	add    %edx,%eax
  8011e7:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011ea:	e9 7b ff ff ff       	jmp    80116a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011ef:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011f0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011f4:	74 08                	je     8011fe <strtol+0x134>
		*endptr = (char *) s;
  8011f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f9:	8b 55 08             	mov    0x8(%ebp),%edx
  8011fc:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011fe:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801202:	74 07                	je     80120b <strtol+0x141>
  801204:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801207:	f7 d8                	neg    %eax
  801209:	eb 03                	jmp    80120e <strtol+0x144>
  80120b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80120e:	c9                   	leave  
  80120f:	c3                   	ret    

00801210 <ltostr>:

void
ltostr(long value, char *str)
{
  801210:	55                   	push   %ebp
  801211:	89 e5                	mov    %esp,%ebp
  801213:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801216:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80121d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801224:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801228:	79 13                	jns    80123d <ltostr+0x2d>
	{
		neg = 1;
  80122a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801231:	8b 45 0c             	mov    0xc(%ebp),%eax
  801234:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801237:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80123a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801245:	99                   	cltd   
  801246:	f7 f9                	idiv   %ecx
  801248:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80124b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80124e:	8d 50 01             	lea    0x1(%eax),%edx
  801251:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801254:	89 c2                	mov    %eax,%edx
  801256:	8b 45 0c             	mov    0xc(%ebp),%eax
  801259:	01 d0                	add    %edx,%eax
  80125b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80125e:	83 c2 30             	add    $0x30,%edx
  801261:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801263:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801266:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80126b:	f7 e9                	imul   %ecx
  80126d:	c1 fa 02             	sar    $0x2,%edx
  801270:	89 c8                	mov    %ecx,%eax
  801272:	c1 f8 1f             	sar    $0x1f,%eax
  801275:	29 c2                	sub    %eax,%edx
  801277:	89 d0                	mov    %edx,%eax
  801279:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80127c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80127f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801284:	f7 e9                	imul   %ecx
  801286:	c1 fa 02             	sar    $0x2,%edx
  801289:	89 c8                	mov    %ecx,%eax
  80128b:	c1 f8 1f             	sar    $0x1f,%eax
  80128e:	29 c2                	sub    %eax,%edx
  801290:	89 d0                	mov    %edx,%eax
  801292:	c1 e0 02             	shl    $0x2,%eax
  801295:	01 d0                	add    %edx,%eax
  801297:	01 c0                	add    %eax,%eax
  801299:	29 c1                	sub    %eax,%ecx
  80129b:	89 ca                	mov    %ecx,%edx
  80129d:	85 d2                	test   %edx,%edx
  80129f:	75 9c                	jne    80123d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ab:	48                   	dec    %eax
  8012ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012af:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012b3:	74 3d                	je     8012f2 <ltostr+0xe2>
		start = 1 ;
  8012b5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012bc:	eb 34                	jmp    8012f2 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8012be:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c4:	01 d0                	add    %edx,%eax
  8012c6:	8a 00                	mov    (%eax),%al
  8012c8:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d1:	01 c2                	add    %eax,%edx
  8012d3:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d9:	01 c8                	add    %ecx,%eax
  8012db:	8a 00                	mov    (%eax),%al
  8012dd:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012df:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e5:	01 c2                	add    %eax,%edx
  8012e7:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012ea:	88 02                	mov    %al,(%edx)
		start++ ;
  8012ec:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012ef:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012f5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012f8:	7c c4                	jl     8012be <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012fa:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801300:	01 d0                	add    %edx,%eax
  801302:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801305:	90                   	nop
  801306:	c9                   	leave  
  801307:	c3                   	ret    

00801308 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
  80130b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80130e:	ff 75 08             	pushl  0x8(%ebp)
  801311:	e8 54 fa ff ff       	call   800d6a <strlen>
  801316:	83 c4 04             	add    $0x4,%esp
  801319:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80131c:	ff 75 0c             	pushl  0xc(%ebp)
  80131f:	e8 46 fa ff ff       	call   800d6a <strlen>
  801324:	83 c4 04             	add    $0x4,%esp
  801327:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80132a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801331:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801338:	eb 17                	jmp    801351 <strcconcat+0x49>
		final[s] = str1[s] ;
  80133a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80133d:	8b 45 10             	mov    0x10(%ebp),%eax
  801340:	01 c2                	add    %eax,%edx
  801342:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801345:	8b 45 08             	mov    0x8(%ebp),%eax
  801348:	01 c8                	add    %ecx,%eax
  80134a:	8a 00                	mov    (%eax),%al
  80134c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80134e:	ff 45 fc             	incl   -0x4(%ebp)
  801351:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801354:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801357:	7c e1                	jl     80133a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801359:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801360:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801367:	eb 1f                	jmp    801388 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801369:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80136c:	8d 50 01             	lea    0x1(%eax),%edx
  80136f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801372:	89 c2                	mov    %eax,%edx
  801374:	8b 45 10             	mov    0x10(%ebp),%eax
  801377:	01 c2                	add    %eax,%edx
  801379:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80137c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137f:	01 c8                	add    %ecx,%eax
  801381:	8a 00                	mov    (%eax),%al
  801383:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801385:	ff 45 f8             	incl   -0x8(%ebp)
  801388:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80138b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80138e:	7c d9                	jl     801369 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801390:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801393:	8b 45 10             	mov    0x10(%ebp),%eax
  801396:	01 d0                	add    %edx,%eax
  801398:	c6 00 00             	movb   $0x0,(%eax)
}
  80139b:	90                   	nop
  80139c:	c9                   	leave  
  80139d:	c3                   	ret    

0080139e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80139e:	55                   	push   %ebp
  80139f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8013a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8013ad:	8b 00                	mov    (%eax),%eax
  8013af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b9:	01 d0                	add    %edx,%eax
  8013bb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013c1:	eb 0c                	jmp    8013cf <strsplit+0x31>
			*string++ = 0;
  8013c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c6:	8d 50 01             	lea    0x1(%eax),%edx
  8013c9:	89 55 08             	mov    %edx,0x8(%ebp)
  8013cc:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d2:	8a 00                	mov    (%eax),%al
  8013d4:	84 c0                	test   %al,%al
  8013d6:	74 18                	je     8013f0 <strsplit+0x52>
  8013d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013db:	8a 00                	mov    (%eax),%al
  8013dd:	0f be c0             	movsbl %al,%eax
  8013e0:	50                   	push   %eax
  8013e1:	ff 75 0c             	pushl  0xc(%ebp)
  8013e4:	e8 13 fb ff ff       	call   800efc <strchr>
  8013e9:	83 c4 08             	add    $0x8,%esp
  8013ec:	85 c0                	test   %eax,%eax
  8013ee:	75 d3                	jne    8013c3 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8013f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f3:	8a 00                	mov    (%eax),%al
  8013f5:	84 c0                	test   %al,%al
  8013f7:	74 5a                	je     801453 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8013f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8013fc:	8b 00                	mov    (%eax),%eax
  8013fe:	83 f8 0f             	cmp    $0xf,%eax
  801401:	75 07                	jne    80140a <strsplit+0x6c>
		{
			return 0;
  801403:	b8 00 00 00 00       	mov    $0x0,%eax
  801408:	eb 66                	jmp    801470 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80140a:	8b 45 14             	mov    0x14(%ebp),%eax
  80140d:	8b 00                	mov    (%eax),%eax
  80140f:	8d 48 01             	lea    0x1(%eax),%ecx
  801412:	8b 55 14             	mov    0x14(%ebp),%edx
  801415:	89 0a                	mov    %ecx,(%edx)
  801417:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80141e:	8b 45 10             	mov    0x10(%ebp),%eax
  801421:	01 c2                	add    %eax,%edx
  801423:	8b 45 08             	mov    0x8(%ebp),%eax
  801426:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801428:	eb 03                	jmp    80142d <strsplit+0x8f>
			string++;
  80142a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
  801430:	8a 00                	mov    (%eax),%al
  801432:	84 c0                	test   %al,%al
  801434:	74 8b                	je     8013c1 <strsplit+0x23>
  801436:	8b 45 08             	mov    0x8(%ebp),%eax
  801439:	8a 00                	mov    (%eax),%al
  80143b:	0f be c0             	movsbl %al,%eax
  80143e:	50                   	push   %eax
  80143f:	ff 75 0c             	pushl  0xc(%ebp)
  801442:	e8 b5 fa ff ff       	call   800efc <strchr>
  801447:	83 c4 08             	add    $0x8,%esp
  80144a:	85 c0                	test   %eax,%eax
  80144c:	74 dc                	je     80142a <strsplit+0x8c>
			string++;
	}
  80144e:	e9 6e ff ff ff       	jmp    8013c1 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801453:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801454:	8b 45 14             	mov    0x14(%ebp),%eax
  801457:	8b 00                	mov    (%eax),%eax
  801459:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801460:	8b 45 10             	mov    0x10(%ebp),%eax
  801463:	01 d0                	add    %edx,%eax
  801465:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80146b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801470:	c9                   	leave  
  801471:	c3                   	ret    

00801472 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801472:	55                   	push   %ebp
  801473:	89 e5                	mov    %esp,%ebp
  801475:	83 ec 18             	sub    $0x18,%esp
  801478:	8b 45 10             	mov    0x10(%ebp),%eax
  80147b:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80147e:	83 ec 04             	sub    $0x4,%esp
  801481:	68 d0 27 80 00       	push   $0x8027d0
  801486:	6a 17                	push   $0x17
  801488:	68 ef 27 80 00       	push   $0x8027ef
  80148d:	e8 a2 ef ff ff       	call   800434 <_panic>

00801492 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801492:	55                   	push   %ebp
  801493:	89 e5                	mov    %esp,%ebp
  801495:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801498:	83 ec 04             	sub    $0x4,%esp
  80149b:	68 fb 27 80 00       	push   $0x8027fb
  8014a0:	6a 2f                	push   $0x2f
  8014a2:	68 ef 27 80 00       	push   $0x8027ef
  8014a7:	e8 88 ef ff ff       	call   800434 <_panic>

008014ac <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8014ac:	55                   	push   %ebp
  8014ad:	89 e5                	mov    %esp,%ebp
  8014af:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8014b2:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8014b9:	8b 55 08             	mov    0x8(%ebp),%edx
  8014bc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014bf:	01 d0                	add    %edx,%eax
  8014c1:	48                   	dec    %eax
  8014c2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8014c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014c8:	ba 00 00 00 00       	mov    $0x0,%edx
  8014cd:	f7 75 ec             	divl   -0x14(%ebp)
  8014d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014d3:	29 d0                	sub    %edx,%eax
  8014d5:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	c1 e8 0c             	shr    $0xc,%eax
  8014de:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8014e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8014e8:	e9 c8 00 00 00       	jmp    8015b5 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8014ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8014f4:	eb 27                	jmp    80151d <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8014f6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8014f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014fc:	01 c2                	add    %eax,%edx
  8014fe:	89 d0                	mov    %edx,%eax
  801500:	01 c0                	add    %eax,%eax
  801502:	01 d0                	add    %edx,%eax
  801504:	c1 e0 02             	shl    $0x2,%eax
  801507:	05 48 30 80 00       	add    $0x803048,%eax
  80150c:	8b 00                	mov    (%eax),%eax
  80150e:	85 c0                	test   %eax,%eax
  801510:	74 08                	je     80151a <malloc+0x6e>
            	i += j;
  801512:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801515:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801518:	eb 0b                	jmp    801525 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  80151a:	ff 45 f0             	incl   -0x10(%ebp)
  80151d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801520:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801523:	72 d1                	jb     8014f6 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801525:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801528:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80152b:	0f 85 81 00 00 00    	jne    8015b2 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801531:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801534:	05 00 00 08 00       	add    $0x80000,%eax
  801539:	c1 e0 0c             	shl    $0xc,%eax
  80153c:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  80153f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801546:	eb 1f                	jmp    801567 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801548:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80154b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80154e:	01 c2                	add    %eax,%edx
  801550:	89 d0                	mov    %edx,%eax
  801552:	01 c0                	add    %eax,%eax
  801554:	01 d0                	add    %edx,%eax
  801556:	c1 e0 02             	shl    $0x2,%eax
  801559:	05 48 30 80 00       	add    $0x803048,%eax
  80155e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801564:	ff 45 f0             	incl   -0x10(%ebp)
  801567:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80156a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80156d:	72 d9                	jb     801548 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80156f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801572:	89 d0                	mov    %edx,%eax
  801574:	01 c0                	add    %eax,%eax
  801576:	01 d0                	add    %edx,%eax
  801578:	c1 e0 02             	shl    $0x2,%eax
  80157b:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801581:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801584:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801586:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801589:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  80158c:	89 c8                	mov    %ecx,%eax
  80158e:	01 c0                	add    %eax,%eax
  801590:	01 c8                	add    %ecx,%eax
  801592:	c1 e0 02             	shl    $0x2,%eax
  801595:	05 44 30 80 00       	add    $0x803044,%eax
  80159a:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  80159c:	83 ec 08             	sub    $0x8,%esp
  80159f:	ff 75 08             	pushl  0x8(%ebp)
  8015a2:	ff 75 e0             	pushl  -0x20(%ebp)
  8015a5:	e8 2b 03 00 00       	call   8018d5 <sys_allocateMem>
  8015aa:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8015ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015b0:	eb 19                	jmp    8015cb <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8015b2:	ff 45 f4             	incl   -0xc(%ebp)
  8015b5:	a1 04 30 80 00       	mov    0x803004,%eax
  8015ba:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8015bd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015c0:	0f 83 27 ff ff ff    	jae    8014ed <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8015c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015cb:	c9                   	leave  
  8015cc:	c3                   	ret    

008015cd <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8015cd:	55                   	push   %ebp
  8015ce:	89 e5                	mov    %esp,%ebp
  8015d0:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8015d3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015d7:	0f 84 e5 00 00 00    	je     8016c2 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8015dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8015e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015e6:	05 00 00 00 80       	add    $0x80000000,%eax
  8015eb:	c1 e8 0c             	shr    $0xc,%eax
  8015ee:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8015f1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8015f4:	89 d0                	mov    %edx,%eax
  8015f6:	01 c0                	add    %eax,%eax
  8015f8:	01 d0                	add    %edx,%eax
  8015fa:	c1 e0 02             	shl    $0x2,%eax
  8015fd:	05 40 30 80 00       	add    $0x803040,%eax
  801602:	8b 00                	mov    (%eax),%eax
  801604:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801607:	0f 85 b8 00 00 00    	jne    8016c5 <free+0xf8>
  80160d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801610:	89 d0                	mov    %edx,%eax
  801612:	01 c0                	add    %eax,%eax
  801614:	01 d0                	add    %edx,%eax
  801616:	c1 e0 02             	shl    $0x2,%eax
  801619:	05 48 30 80 00       	add    $0x803048,%eax
  80161e:	8b 00                	mov    (%eax),%eax
  801620:	85 c0                	test   %eax,%eax
  801622:	0f 84 9d 00 00 00    	je     8016c5 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801628:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80162b:	89 d0                	mov    %edx,%eax
  80162d:	01 c0                	add    %eax,%eax
  80162f:	01 d0                	add    %edx,%eax
  801631:	c1 e0 02             	shl    $0x2,%eax
  801634:	05 44 30 80 00       	add    $0x803044,%eax
  801639:	8b 00                	mov    (%eax),%eax
  80163b:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  80163e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801641:	c1 e0 0c             	shl    $0xc,%eax
  801644:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801647:	83 ec 08             	sub    $0x8,%esp
  80164a:	ff 75 e4             	pushl  -0x1c(%ebp)
  80164d:	ff 75 f0             	pushl  -0x10(%ebp)
  801650:	e8 64 02 00 00       	call   8018b9 <sys_freeMem>
  801655:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801658:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80165f:	eb 57                	jmp    8016b8 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801661:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801664:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801667:	01 c2                	add    %eax,%edx
  801669:	89 d0                	mov    %edx,%eax
  80166b:	01 c0                	add    %eax,%eax
  80166d:	01 d0                	add    %edx,%eax
  80166f:	c1 e0 02             	shl    $0x2,%eax
  801672:	05 48 30 80 00       	add    $0x803048,%eax
  801677:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  80167d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801680:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801683:	01 c2                	add    %eax,%edx
  801685:	89 d0                	mov    %edx,%eax
  801687:	01 c0                	add    %eax,%eax
  801689:	01 d0                	add    %edx,%eax
  80168b:	c1 e0 02             	shl    $0x2,%eax
  80168e:	05 40 30 80 00       	add    $0x803040,%eax
  801693:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801699:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80169c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80169f:	01 c2                	add    %eax,%edx
  8016a1:	89 d0                	mov    %edx,%eax
  8016a3:	01 c0                	add    %eax,%eax
  8016a5:	01 d0                	add    %edx,%eax
  8016a7:	c1 e0 02             	shl    $0x2,%eax
  8016aa:	05 44 30 80 00       	add    $0x803044,%eax
  8016af:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8016b5:	ff 45 f4             	incl   -0xc(%ebp)
  8016b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016bb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8016be:	7c a1                	jl     801661 <free+0x94>
  8016c0:	eb 04                	jmp    8016c6 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8016c2:	90                   	nop
  8016c3:	eb 01                	jmp    8016c6 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8016c5:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8016c6:	c9                   	leave  
  8016c7:	c3                   	ret    

008016c8 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8016c8:	55                   	push   %ebp
  8016c9:	89 e5                	mov    %esp,%ebp
  8016cb:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8016ce:	83 ec 04             	sub    $0x4,%esp
  8016d1:	68 18 28 80 00       	push   $0x802818
  8016d6:	68 ae 00 00 00       	push   $0xae
  8016db:	68 ef 27 80 00       	push   $0x8027ef
  8016e0:	e8 4f ed ff ff       	call   800434 <_panic>

008016e5 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8016e5:	55                   	push   %ebp
  8016e6:	89 e5                	mov    %esp,%ebp
  8016e8:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8016eb:	83 ec 04             	sub    $0x4,%esp
  8016ee:	68 38 28 80 00       	push   $0x802838
  8016f3:	68 ca 00 00 00       	push   $0xca
  8016f8:	68 ef 27 80 00       	push   $0x8027ef
  8016fd:	e8 32 ed ff ff       	call   800434 <_panic>

00801702 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801702:	55                   	push   %ebp
  801703:	89 e5                	mov    %esp,%ebp
  801705:	57                   	push   %edi
  801706:	56                   	push   %esi
  801707:	53                   	push   %ebx
  801708:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80170b:	8b 45 08             	mov    0x8(%ebp),%eax
  80170e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801711:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801714:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801717:	8b 7d 18             	mov    0x18(%ebp),%edi
  80171a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80171d:	cd 30                	int    $0x30
  80171f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801722:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801725:	83 c4 10             	add    $0x10,%esp
  801728:	5b                   	pop    %ebx
  801729:	5e                   	pop    %esi
  80172a:	5f                   	pop    %edi
  80172b:	5d                   	pop    %ebp
  80172c:	c3                   	ret    

0080172d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80172d:	55                   	push   %ebp
  80172e:	89 e5                	mov    %esp,%ebp
  801730:	83 ec 04             	sub    $0x4,%esp
  801733:	8b 45 10             	mov    0x10(%ebp),%eax
  801736:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801739:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80173d:	8b 45 08             	mov    0x8(%ebp),%eax
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	52                   	push   %edx
  801745:	ff 75 0c             	pushl  0xc(%ebp)
  801748:	50                   	push   %eax
  801749:	6a 00                	push   $0x0
  80174b:	e8 b2 ff ff ff       	call   801702 <syscall>
  801750:	83 c4 18             	add    $0x18,%esp
}
  801753:	90                   	nop
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <sys_cgetc>:

int
sys_cgetc(void)
{
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 01                	push   $0x1
  801765:	e8 98 ff ff ff       	call   801702 <syscall>
  80176a:	83 c4 18             	add    $0x18,%esp
}
  80176d:	c9                   	leave  
  80176e:	c3                   	ret    

0080176f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801772:	8b 45 08             	mov    0x8(%ebp),%eax
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	50                   	push   %eax
  80177e:	6a 05                	push   $0x5
  801780:	e8 7d ff ff ff       	call   801702 <syscall>
  801785:	83 c4 18             	add    $0x18,%esp
}
  801788:	c9                   	leave  
  801789:	c3                   	ret    

0080178a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80178a:	55                   	push   %ebp
  80178b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 02                	push   $0x2
  801799:	e8 64 ff ff ff       	call   801702 <syscall>
  80179e:	83 c4 18             	add    $0x18,%esp
}
  8017a1:	c9                   	leave  
  8017a2:	c3                   	ret    

008017a3 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017a3:	55                   	push   %ebp
  8017a4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 03                	push   $0x3
  8017b2:	e8 4b ff ff ff       	call   801702 <syscall>
  8017b7:	83 c4 18             	add    $0x18,%esp
}
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 04                	push   $0x4
  8017cb:	e8 32 ff ff ff       	call   801702 <syscall>
  8017d0:	83 c4 18             	add    $0x18,%esp
}
  8017d3:	c9                   	leave  
  8017d4:	c3                   	ret    

008017d5 <sys_env_exit>:


void sys_env_exit(void)
{
  8017d5:	55                   	push   %ebp
  8017d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 06                	push   $0x6
  8017e4:	e8 19 ff ff ff       	call   801702 <syscall>
  8017e9:	83 c4 18             	add    $0x18,%esp
}
  8017ec:	90                   	nop
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	52                   	push   %edx
  8017ff:	50                   	push   %eax
  801800:	6a 07                	push   $0x7
  801802:	e8 fb fe ff ff       	call   801702 <syscall>
  801807:	83 c4 18             	add    $0x18,%esp
}
  80180a:	c9                   	leave  
  80180b:	c3                   	ret    

0080180c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80180c:	55                   	push   %ebp
  80180d:	89 e5                	mov    %esp,%ebp
  80180f:	56                   	push   %esi
  801810:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801811:	8b 75 18             	mov    0x18(%ebp),%esi
  801814:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801817:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80181a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	56                   	push   %esi
  801821:	53                   	push   %ebx
  801822:	51                   	push   %ecx
  801823:	52                   	push   %edx
  801824:	50                   	push   %eax
  801825:	6a 08                	push   $0x8
  801827:	e8 d6 fe ff ff       	call   801702 <syscall>
  80182c:	83 c4 18             	add    $0x18,%esp
}
  80182f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801832:	5b                   	pop    %ebx
  801833:	5e                   	pop    %esi
  801834:	5d                   	pop    %ebp
  801835:	c3                   	ret    

00801836 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801839:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183c:	8b 45 08             	mov    0x8(%ebp),%eax
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	52                   	push   %edx
  801846:	50                   	push   %eax
  801847:	6a 09                	push   $0x9
  801849:	e8 b4 fe ff ff       	call   801702 <syscall>
  80184e:	83 c4 18             	add    $0x18,%esp
}
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801853:	55                   	push   %ebp
  801854:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	ff 75 0c             	pushl  0xc(%ebp)
  80185f:	ff 75 08             	pushl  0x8(%ebp)
  801862:	6a 0a                	push   $0xa
  801864:	e8 99 fe ff ff       	call   801702 <syscall>
  801869:	83 c4 18             	add    $0x18,%esp
}
  80186c:	c9                   	leave  
  80186d:	c3                   	ret    

0080186e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80186e:	55                   	push   %ebp
  80186f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 0b                	push   $0xb
  80187d:	e8 80 fe ff ff       	call   801702 <syscall>
  801882:	83 c4 18             	add    $0x18,%esp
}
  801885:	c9                   	leave  
  801886:	c3                   	ret    

00801887 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801887:	55                   	push   %ebp
  801888:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 0c                	push   $0xc
  801896:	e8 67 fe ff ff       	call   801702 <syscall>
  80189b:	83 c4 18             	add    $0x18,%esp
}
  80189e:	c9                   	leave  
  80189f:	c3                   	ret    

008018a0 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018a0:	55                   	push   %ebp
  8018a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 0d                	push   $0xd
  8018af:	e8 4e fe ff ff       	call   801702 <syscall>
  8018b4:	83 c4 18             	add    $0x18,%esp
}
  8018b7:	c9                   	leave  
  8018b8:	c3                   	ret    

008018b9 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018b9:	55                   	push   %ebp
  8018ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	ff 75 0c             	pushl  0xc(%ebp)
  8018c5:	ff 75 08             	pushl  0x8(%ebp)
  8018c8:	6a 11                	push   $0x11
  8018ca:	e8 33 fe ff ff       	call   801702 <syscall>
  8018cf:	83 c4 18             	add    $0x18,%esp
	return;
  8018d2:	90                   	nop
}
  8018d3:	c9                   	leave  
  8018d4:	c3                   	ret    

008018d5 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018d5:	55                   	push   %ebp
  8018d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	ff 75 0c             	pushl  0xc(%ebp)
  8018e1:	ff 75 08             	pushl  0x8(%ebp)
  8018e4:	6a 12                	push   $0x12
  8018e6:	e8 17 fe ff ff       	call   801702 <syscall>
  8018eb:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ee:	90                   	nop
}
  8018ef:	c9                   	leave  
  8018f0:	c3                   	ret    

008018f1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018f1:	55                   	push   %ebp
  8018f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 0e                	push   $0xe
  801900:	e8 fd fd ff ff       	call   801702 <syscall>
  801905:	83 c4 18             	add    $0x18,%esp
}
  801908:	c9                   	leave  
  801909:	c3                   	ret    

0080190a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80190a:	55                   	push   %ebp
  80190b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	ff 75 08             	pushl  0x8(%ebp)
  801918:	6a 0f                	push   $0xf
  80191a:	e8 e3 fd ff ff       	call   801702 <syscall>
  80191f:	83 c4 18             	add    $0x18,%esp
}
  801922:	c9                   	leave  
  801923:	c3                   	ret    

00801924 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801924:	55                   	push   %ebp
  801925:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	6a 10                	push   $0x10
  801933:	e8 ca fd ff ff       	call   801702 <syscall>
  801938:	83 c4 18             	add    $0x18,%esp
}
  80193b:	90                   	nop
  80193c:	c9                   	leave  
  80193d:	c3                   	ret    

0080193e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80193e:	55                   	push   %ebp
  80193f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 14                	push   $0x14
  80194d:	e8 b0 fd ff ff       	call   801702 <syscall>
  801952:	83 c4 18             	add    $0x18,%esp
}
  801955:	90                   	nop
  801956:	c9                   	leave  
  801957:	c3                   	ret    

00801958 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801958:	55                   	push   %ebp
  801959:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 15                	push   $0x15
  801967:	e8 96 fd ff ff       	call   801702 <syscall>
  80196c:	83 c4 18             	add    $0x18,%esp
}
  80196f:	90                   	nop
  801970:	c9                   	leave  
  801971:	c3                   	ret    

00801972 <sys_cputc>:


void
sys_cputc(const char c)
{
  801972:	55                   	push   %ebp
  801973:	89 e5                	mov    %esp,%ebp
  801975:	83 ec 04             	sub    $0x4,%esp
  801978:	8b 45 08             	mov    0x8(%ebp),%eax
  80197b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80197e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	50                   	push   %eax
  80198b:	6a 16                	push   $0x16
  80198d:	e8 70 fd ff ff       	call   801702 <syscall>
  801992:	83 c4 18             	add    $0x18,%esp
}
  801995:	90                   	nop
  801996:	c9                   	leave  
  801997:	c3                   	ret    

00801998 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801998:	55                   	push   %ebp
  801999:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 17                	push   $0x17
  8019a7:	e8 56 fd ff ff       	call   801702 <syscall>
  8019ac:	83 c4 18             	add    $0x18,%esp
}
  8019af:	90                   	nop
  8019b0:	c9                   	leave  
  8019b1:	c3                   	ret    

008019b2 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	ff 75 0c             	pushl  0xc(%ebp)
  8019c1:	50                   	push   %eax
  8019c2:	6a 18                	push   $0x18
  8019c4:	e8 39 fd ff ff       	call   801702 <syscall>
  8019c9:	83 c4 18             	add    $0x18,%esp
}
  8019cc:	c9                   	leave  
  8019cd:	c3                   	ret    

008019ce <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019ce:	55                   	push   %ebp
  8019cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	52                   	push   %edx
  8019de:	50                   	push   %eax
  8019df:	6a 1b                	push   $0x1b
  8019e1:	e8 1c fd ff ff       	call   801702 <syscall>
  8019e6:	83 c4 18             	add    $0x18,%esp
}
  8019e9:	c9                   	leave  
  8019ea:	c3                   	ret    

008019eb <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019eb:	55                   	push   %ebp
  8019ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	52                   	push   %edx
  8019fb:	50                   	push   %eax
  8019fc:	6a 19                	push   $0x19
  8019fe:	e8 ff fc ff ff       	call   801702 <syscall>
  801a03:	83 c4 18             	add    $0x18,%esp
}
  801a06:	90                   	nop
  801a07:	c9                   	leave  
  801a08:	c3                   	ret    

00801a09 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a09:	55                   	push   %ebp
  801a0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	52                   	push   %edx
  801a19:	50                   	push   %eax
  801a1a:	6a 1a                	push   $0x1a
  801a1c:	e8 e1 fc ff ff       	call   801702 <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
}
  801a24:	90                   	nop
  801a25:	c9                   	leave  
  801a26:	c3                   	ret    

00801a27 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a27:	55                   	push   %ebp
  801a28:	89 e5                	mov    %esp,%ebp
  801a2a:	83 ec 04             	sub    $0x4,%esp
  801a2d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a30:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a33:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a36:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3d:	6a 00                	push   $0x0
  801a3f:	51                   	push   %ecx
  801a40:	52                   	push   %edx
  801a41:	ff 75 0c             	pushl  0xc(%ebp)
  801a44:	50                   	push   %eax
  801a45:	6a 1c                	push   $0x1c
  801a47:	e8 b6 fc ff ff       	call   801702 <syscall>
  801a4c:	83 c4 18             	add    $0x18,%esp
}
  801a4f:	c9                   	leave  
  801a50:	c3                   	ret    

00801a51 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a51:	55                   	push   %ebp
  801a52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a54:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a57:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 00                	push   $0x0
  801a5e:	6a 00                	push   $0x0
  801a60:	52                   	push   %edx
  801a61:	50                   	push   %eax
  801a62:	6a 1d                	push   $0x1d
  801a64:	e8 99 fc ff ff       	call   801702 <syscall>
  801a69:	83 c4 18             	add    $0x18,%esp
}
  801a6c:	c9                   	leave  
  801a6d:	c3                   	ret    

00801a6e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a6e:	55                   	push   %ebp
  801a6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a71:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a74:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a77:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	51                   	push   %ecx
  801a7f:	52                   	push   %edx
  801a80:	50                   	push   %eax
  801a81:	6a 1e                	push   $0x1e
  801a83:	e8 7a fc ff ff       	call   801702 <syscall>
  801a88:	83 c4 18             	add    $0x18,%esp
}
  801a8b:	c9                   	leave  
  801a8c:	c3                   	ret    

00801a8d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a8d:	55                   	push   %ebp
  801a8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a90:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a93:	8b 45 08             	mov    0x8(%ebp),%eax
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	52                   	push   %edx
  801a9d:	50                   	push   %eax
  801a9e:	6a 1f                	push   $0x1f
  801aa0:	e8 5d fc ff ff       	call   801702 <syscall>
  801aa5:	83 c4 18             	add    $0x18,%esp
}
  801aa8:	c9                   	leave  
  801aa9:	c3                   	ret    

00801aaa <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801aaa:	55                   	push   %ebp
  801aab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 20                	push   $0x20
  801ab9:	e8 44 fc ff ff       	call   801702 <syscall>
  801abe:	83 c4 18             	add    $0x18,%esp
}
  801ac1:	c9                   	leave  
  801ac2:	c3                   	ret    

00801ac3 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801ac3:	55                   	push   %ebp
  801ac4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	ff 75 10             	pushl  0x10(%ebp)
  801ad0:	ff 75 0c             	pushl  0xc(%ebp)
  801ad3:	50                   	push   %eax
  801ad4:	6a 21                	push   $0x21
  801ad6:	e8 27 fc ff ff       	call   801702 <syscall>
  801adb:	83 c4 18             	add    $0x18,%esp
}
  801ade:	c9                   	leave  
  801adf:	c3                   	ret    

00801ae0 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ae0:	55                   	push   %ebp
  801ae1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	50                   	push   %eax
  801aef:	6a 22                	push   $0x22
  801af1:	e8 0c fc ff ff       	call   801702 <syscall>
  801af6:	83 c4 18             	add    $0x18,%esp
}
  801af9:	90                   	nop
  801afa:	c9                   	leave  
  801afb:	c3                   	ret    

00801afc <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801afc:	55                   	push   %ebp
  801afd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801aff:	8b 45 08             	mov    0x8(%ebp),%eax
  801b02:	6a 00                	push   $0x0
  801b04:	6a 00                	push   $0x0
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	50                   	push   %eax
  801b0b:	6a 23                	push   $0x23
  801b0d:	e8 f0 fb ff ff       	call   801702 <syscall>
  801b12:	83 c4 18             	add    $0x18,%esp
}
  801b15:	90                   	nop
  801b16:	c9                   	leave  
  801b17:	c3                   	ret    

00801b18 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b18:	55                   	push   %ebp
  801b19:	89 e5                	mov    %esp,%ebp
  801b1b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b1e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b21:	8d 50 04             	lea    0x4(%eax),%edx
  801b24:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b27:	6a 00                	push   $0x0
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 00                	push   $0x0
  801b2d:	52                   	push   %edx
  801b2e:	50                   	push   %eax
  801b2f:	6a 24                	push   $0x24
  801b31:	e8 cc fb ff ff       	call   801702 <syscall>
  801b36:	83 c4 18             	add    $0x18,%esp
	return result;
  801b39:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b3f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b42:	89 01                	mov    %eax,(%ecx)
  801b44:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b47:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4a:	c9                   	leave  
  801b4b:	c2 04 00             	ret    $0x4

00801b4e <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b4e:	55                   	push   %ebp
  801b4f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	ff 75 10             	pushl  0x10(%ebp)
  801b58:	ff 75 0c             	pushl  0xc(%ebp)
  801b5b:	ff 75 08             	pushl  0x8(%ebp)
  801b5e:	6a 13                	push   $0x13
  801b60:	e8 9d fb ff ff       	call   801702 <syscall>
  801b65:	83 c4 18             	add    $0x18,%esp
	return ;
  801b68:	90                   	nop
}
  801b69:	c9                   	leave  
  801b6a:	c3                   	ret    

00801b6b <sys_rcr2>:
uint32 sys_rcr2()
{
  801b6b:	55                   	push   %ebp
  801b6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b6e:	6a 00                	push   $0x0
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 25                	push   $0x25
  801b7a:	e8 83 fb ff ff       	call   801702 <syscall>
  801b7f:	83 c4 18             	add    $0x18,%esp
}
  801b82:	c9                   	leave  
  801b83:	c3                   	ret    

00801b84 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b84:	55                   	push   %ebp
  801b85:	89 e5                	mov    %esp,%ebp
  801b87:	83 ec 04             	sub    $0x4,%esp
  801b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b90:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 00                	push   $0x0
  801b9c:	50                   	push   %eax
  801b9d:	6a 26                	push   $0x26
  801b9f:	e8 5e fb ff ff       	call   801702 <syscall>
  801ba4:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba7:	90                   	nop
}
  801ba8:	c9                   	leave  
  801ba9:	c3                   	ret    

00801baa <rsttst>:
void rsttst()
{
  801baa:	55                   	push   %ebp
  801bab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 28                	push   $0x28
  801bb9:	e8 44 fb ff ff       	call   801702 <syscall>
  801bbe:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc1:	90                   	nop
}
  801bc2:	c9                   	leave  
  801bc3:	c3                   	ret    

00801bc4 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bc4:	55                   	push   %ebp
  801bc5:	89 e5                	mov    %esp,%ebp
  801bc7:	83 ec 04             	sub    $0x4,%esp
  801bca:	8b 45 14             	mov    0x14(%ebp),%eax
  801bcd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bd0:	8b 55 18             	mov    0x18(%ebp),%edx
  801bd3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bd7:	52                   	push   %edx
  801bd8:	50                   	push   %eax
  801bd9:	ff 75 10             	pushl  0x10(%ebp)
  801bdc:	ff 75 0c             	pushl  0xc(%ebp)
  801bdf:	ff 75 08             	pushl  0x8(%ebp)
  801be2:	6a 27                	push   $0x27
  801be4:	e8 19 fb ff ff       	call   801702 <syscall>
  801be9:	83 c4 18             	add    $0x18,%esp
	return ;
  801bec:	90                   	nop
}
  801bed:	c9                   	leave  
  801bee:	c3                   	ret    

00801bef <chktst>:
void chktst(uint32 n)
{
  801bef:	55                   	push   %ebp
  801bf0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bf2:	6a 00                	push   $0x0
  801bf4:	6a 00                	push   $0x0
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	ff 75 08             	pushl  0x8(%ebp)
  801bfd:	6a 29                	push   $0x29
  801bff:	e8 fe fa ff ff       	call   801702 <syscall>
  801c04:	83 c4 18             	add    $0x18,%esp
	return ;
  801c07:	90                   	nop
}
  801c08:	c9                   	leave  
  801c09:	c3                   	ret    

00801c0a <inctst>:

void inctst()
{
  801c0a:	55                   	push   %ebp
  801c0b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 2a                	push   $0x2a
  801c19:	e8 e4 fa ff ff       	call   801702 <syscall>
  801c1e:	83 c4 18             	add    $0x18,%esp
	return ;
  801c21:	90                   	nop
}
  801c22:	c9                   	leave  
  801c23:	c3                   	ret    

00801c24 <gettst>:
uint32 gettst()
{
  801c24:	55                   	push   %ebp
  801c25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 2b                	push   $0x2b
  801c33:	e8 ca fa ff ff       	call   801702 <syscall>
  801c38:	83 c4 18             	add    $0x18,%esp
}
  801c3b:	c9                   	leave  
  801c3c:	c3                   	ret    

00801c3d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c3d:	55                   	push   %ebp
  801c3e:	89 e5                	mov    %esp,%ebp
  801c40:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 2c                	push   $0x2c
  801c4f:	e8 ae fa ff ff       	call   801702 <syscall>
  801c54:	83 c4 18             	add    $0x18,%esp
  801c57:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c5a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c5e:	75 07                	jne    801c67 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c60:	b8 01 00 00 00       	mov    $0x1,%eax
  801c65:	eb 05                	jmp    801c6c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c67:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c6c:	c9                   	leave  
  801c6d:	c3                   	ret    

00801c6e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c6e:	55                   	push   %ebp
  801c6f:	89 e5                	mov    %esp,%ebp
  801c71:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 2c                	push   $0x2c
  801c80:	e8 7d fa ff ff       	call   801702 <syscall>
  801c85:	83 c4 18             	add    $0x18,%esp
  801c88:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c8b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c8f:	75 07                	jne    801c98 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c91:	b8 01 00 00 00       	mov    $0x1,%eax
  801c96:	eb 05                	jmp    801c9d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c98:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c9d:	c9                   	leave  
  801c9e:	c3                   	ret    

00801c9f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c9f:	55                   	push   %ebp
  801ca0:	89 e5                	mov    %esp,%ebp
  801ca2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 2c                	push   $0x2c
  801cb1:	e8 4c fa ff ff       	call   801702 <syscall>
  801cb6:	83 c4 18             	add    $0x18,%esp
  801cb9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cbc:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cc0:	75 07                	jne    801cc9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cc2:	b8 01 00 00 00       	mov    $0x1,%eax
  801cc7:	eb 05                	jmp    801cce <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cc9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cce:	c9                   	leave  
  801ccf:	c3                   	ret    

00801cd0 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cd0:	55                   	push   %ebp
  801cd1:	89 e5                	mov    %esp,%ebp
  801cd3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 00                	push   $0x0
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 2c                	push   $0x2c
  801ce2:	e8 1b fa ff ff       	call   801702 <syscall>
  801ce7:	83 c4 18             	add    $0x18,%esp
  801cea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ced:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cf1:	75 07                	jne    801cfa <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cf3:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf8:	eb 05                	jmp    801cff <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801cfa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cff:	c9                   	leave  
  801d00:	c3                   	ret    

00801d01 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d01:	55                   	push   %ebp
  801d02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	ff 75 08             	pushl  0x8(%ebp)
  801d0f:	6a 2d                	push   $0x2d
  801d11:	e8 ec f9 ff ff       	call   801702 <syscall>
  801d16:	83 c4 18             	add    $0x18,%esp
	return ;
  801d19:	90                   	nop
}
  801d1a:	c9                   	leave  
  801d1b:	c3                   	ret    

00801d1c <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801d1c:	55                   	push   %ebp
  801d1d:	89 e5                	mov    %esp,%ebp
  801d1f:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801d22:	8b 55 08             	mov    0x8(%ebp),%edx
  801d25:	89 d0                	mov    %edx,%eax
  801d27:	c1 e0 02             	shl    $0x2,%eax
  801d2a:	01 d0                	add    %edx,%eax
  801d2c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d33:	01 d0                	add    %edx,%eax
  801d35:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d3c:	01 d0                	add    %edx,%eax
  801d3e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d45:	01 d0                	add    %edx,%eax
  801d47:	c1 e0 04             	shl    $0x4,%eax
  801d4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801d4d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801d54:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801d57:	83 ec 0c             	sub    $0xc,%esp
  801d5a:	50                   	push   %eax
  801d5b:	e8 b8 fd ff ff       	call   801b18 <sys_get_virtual_time>
  801d60:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801d63:	eb 41                	jmp    801da6 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801d65:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801d68:	83 ec 0c             	sub    $0xc,%esp
  801d6b:	50                   	push   %eax
  801d6c:	e8 a7 fd ff ff       	call   801b18 <sys_get_virtual_time>
  801d71:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801d74:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801d77:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d7a:	29 c2                	sub    %eax,%edx
  801d7c:	89 d0                	mov    %edx,%eax
  801d7e:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801d81:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801d84:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d87:	89 d1                	mov    %edx,%ecx
  801d89:	29 c1                	sub    %eax,%ecx
  801d8b:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801d8e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d91:	39 c2                	cmp    %eax,%edx
  801d93:	0f 97 c0             	seta   %al
  801d96:	0f b6 c0             	movzbl %al,%eax
  801d99:	29 c1                	sub    %eax,%ecx
  801d9b:	89 c8                	mov    %ecx,%eax
  801d9d:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801da0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801da3:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801da6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801da9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801dac:	72 b7                	jb     801d65 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801dae:	90                   	nop
  801daf:	c9                   	leave  
  801db0:	c3                   	ret    

00801db1 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801db1:	55                   	push   %ebp
  801db2:	89 e5                	mov    %esp,%ebp
  801db4:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801db7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801dbe:	eb 03                	jmp    801dc3 <busy_wait+0x12>
  801dc0:	ff 45 fc             	incl   -0x4(%ebp)
  801dc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801dc6:	3b 45 08             	cmp    0x8(%ebp),%eax
  801dc9:	72 f5                	jb     801dc0 <busy_wait+0xf>
	return i;
  801dcb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801dce:	c9                   	leave  
  801dcf:	c3                   	ret    

00801dd0 <__udivdi3>:
  801dd0:	55                   	push   %ebp
  801dd1:	57                   	push   %edi
  801dd2:	56                   	push   %esi
  801dd3:	53                   	push   %ebx
  801dd4:	83 ec 1c             	sub    $0x1c,%esp
  801dd7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ddb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ddf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801de3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801de7:	89 ca                	mov    %ecx,%edx
  801de9:	89 f8                	mov    %edi,%eax
  801deb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801def:	85 f6                	test   %esi,%esi
  801df1:	75 2d                	jne    801e20 <__udivdi3+0x50>
  801df3:	39 cf                	cmp    %ecx,%edi
  801df5:	77 65                	ja     801e5c <__udivdi3+0x8c>
  801df7:	89 fd                	mov    %edi,%ebp
  801df9:	85 ff                	test   %edi,%edi
  801dfb:	75 0b                	jne    801e08 <__udivdi3+0x38>
  801dfd:	b8 01 00 00 00       	mov    $0x1,%eax
  801e02:	31 d2                	xor    %edx,%edx
  801e04:	f7 f7                	div    %edi
  801e06:	89 c5                	mov    %eax,%ebp
  801e08:	31 d2                	xor    %edx,%edx
  801e0a:	89 c8                	mov    %ecx,%eax
  801e0c:	f7 f5                	div    %ebp
  801e0e:	89 c1                	mov    %eax,%ecx
  801e10:	89 d8                	mov    %ebx,%eax
  801e12:	f7 f5                	div    %ebp
  801e14:	89 cf                	mov    %ecx,%edi
  801e16:	89 fa                	mov    %edi,%edx
  801e18:	83 c4 1c             	add    $0x1c,%esp
  801e1b:	5b                   	pop    %ebx
  801e1c:	5e                   	pop    %esi
  801e1d:	5f                   	pop    %edi
  801e1e:	5d                   	pop    %ebp
  801e1f:	c3                   	ret    
  801e20:	39 ce                	cmp    %ecx,%esi
  801e22:	77 28                	ja     801e4c <__udivdi3+0x7c>
  801e24:	0f bd fe             	bsr    %esi,%edi
  801e27:	83 f7 1f             	xor    $0x1f,%edi
  801e2a:	75 40                	jne    801e6c <__udivdi3+0x9c>
  801e2c:	39 ce                	cmp    %ecx,%esi
  801e2e:	72 0a                	jb     801e3a <__udivdi3+0x6a>
  801e30:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e34:	0f 87 9e 00 00 00    	ja     801ed8 <__udivdi3+0x108>
  801e3a:	b8 01 00 00 00       	mov    $0x1,%eax
  801e3f:	89 fa                	mov    %edi,%edx
  801e41:	83 c4 1c             	add    $0x1c,%esp
  801e44:	5b                   	pop    %ebx
  801e45:	5e                   	pop    %esi
  801e46:	5f                   	pop    %edi
  801e47:	5d                   	pop    %ebp
  801e48:	c3                   	ret    
  801e49:	8d 76 00             	lea    0x0(%esi),%esi
  801e4c:	31 ff                	xor    %edi,%edi
  801e4e:	31 c0                	xor    %eax,%eax
  801e50:	89 fa                	mov    %edi,%edx
  801e52:	83 c4 1c             	add    $0x1c,%esp
  801e55:	5b                   	pop    %ebx
  801e56:	5e                   	pop    %esi
  801e57:	5f                   	pop    %edi
  801e58:	5d                   	pop    %ebp
  801e59:	c3                   	ret    
  801e5a:	66 90                	xchg   %ax,%ax
  801e5c:	89 d8                	mov    %ebx,%eax
  801e5e:	f7 f7                	div    %edi
  801e60:	31 ff                	xor    %edi,%edi
  801e62:	89 fa                	mov    %edi,%edx
  801e64:	83 c4 1c             	add    $0x1c,%esp
  801e67:	5b                   	pop    %ebx
  801e68:	5e                   	pop    %esi
  801e69:	5f                   	pop    %edi
  801e6a:	5d                   	pop    %ebp
  801e6b:	c3                   	ret    
  801e6c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e71:	89 eb                	mov    %ebp,%ebx
  801e73:	29 fb                	sub    %edi,%ebx
  801e75:	89 f9                	mov    %edi,%ecx
  801e77:	d3 e6                	shl    %cl,%esi
  801e79:	89 c5                	mov    %eax,%ebp
  801e7b:	88 d9                	mov    %bl,%cl
  801e7d:	d3 ed                	shr    %cl,%ebp
  801e7f:	89 e9                	mov    %ebp,%ecx
  801e81:	09 f1                	or     %esi,%ecx
  801e83:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e87:	89 f9                	mov    %edi,%ecx
  801e89:	d3 e0                	shl    %cl,%eax
  801e8b:	89 c5                	mov    %eax,%ebp
  801e8d:	89 d6                	mov    %edx,%esi
  801e8f:	88 d9                	mov    %bl,%cl
  801e91:	d3 ee                	shr    %cl,%esi
  801e93:	89 f9                	mov    %edi,%ecx
  801e95:	d3 e2                	shl    %cl,%edx
  801e97:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e9b:	88 d9                	mov    %bl,%cl
  801e9d:	d3 e8                	shr    %cl,%eax
  801e9f:	09 c2                	or     %eax,%edx
  801ea1:	89 d0                	mov    %edx,%eax
  801ea3:	89 f2                	mov    %esi,%edx
  801ea5:	f7 74 24 0c          	divl   0xc(%esp)
  801ea9:	89 d6                	mov    %edx,%esi
  801eab:	89 c3                	mov    %eax,%ebx
  801ead:	f7 e5                	mul    %ebp
  801eaf:	39 d6                	cmp    %edx,%esi
  801eb1:	72 19                	jb     801ecc <__udivdi3+0xfc>
  801eb3:	74 0b                	je     801ec0 <__udivdi3+0xf0>
  801eb5:	89 d8                	mov    %ebx,%eax
  801eb7:	31 ff                	xor    %edi,%edi
  801eb9:	e9 58 ff ff ff       	jmp    801e16 <__udivdi3+0x46>
  801ebe:	66 90                	xchg   %ax,%ax
  801ec0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ec4:	89 f9                	mov    %edi,%ecx
  801ec6:	d3 e2                	shl    %cl,%edx
  801ec8:	39 c2                	cmp    %eax,%edx
  801eca:	73 e9                	jae    801eb5 <__udivdi3+0xe5>
  801ecc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ecf:	31 ff                	xor    %edi,%edi
  801ed1:	e9 40 ff ff ff       	jmp    801e16 <__udivdi3+0x46>
  801ed6:	66 90                	xchg   %ax,%ax
  801ed8:	31 c0                	xor    %eax,%eax
  801eda:	e9 37 ff ff ff       	jmp    801e16 <__udivdi3+0x46>
  801edf:	90                   	nop

00801ee0 <__umoddi3>:
  801ee0:	55                   	push   %ebp
  801ee1:	57                   	push   %edi
  801ee2:	56                   	push   %esi
  801ee3:	53                   	push   %ebx
  801ee4:	83 ec 1c             	sub    $0x1c,%esp
  801ee7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801eeb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801eef:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ef3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ef7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801efb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801eff:	89 f3                	mov    %esi,%ebx
  801f01:	89 fa                	mov    %edi,%edx
  801f03:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f07:	89 34 24             	mov    %esi,(%esp)
  801f0a:	85 c0                	test   %eax,%eax
  801f0c:	75 1a                	jne    801f28 <__umoddi3+0x48>
  801f0e:	39 f7                	cmp    %esi,%edi
  801f10:	0f 86 a2 00 00 00    	jbe    801fb8 <__umoddi3+0xd8>
  801f16:	89 c8                	mov    %ecx,%eax
  801f18:	89 f2                	mov    %esi,%edx
  801f1a:	f7 f7                	div    %edi
  801f1c:	89 d0                	mov    %edx,%eax
  801f1e:	31 d2                	xor    %edx,%edx
  801f20:	83 c4 1c             	add    $0x1c,%esp
  801f23:	5b                   	pop    %ebx
  801f24:	5e                   	pop    %esi
  801f25:	5f                   	pop    %edi
  801f26:	5d                   	pop    %ebp
  801f27:	c3                   	ret    
  801f28:	39 f0                	cmp    %esi,%eax
  801f2a:	0f 87 ac 00 00 00    	ja     801fdc <__umoddi3+0xfc>
  801f30:	0f bd e8             	bsr    %eax,%ebp
  801f33:	83 f5 1f             	xor    $0x1f,%ebp
  801f36:	0f 84 ac 00 00 00    	je     801fe8 <__umoddi3+0x108>
  801f3c:	bf 20 00 00 00       	mov    $0x20,%edi
  801f41:	29 ef                	sub    %ebp,%edi
  801f43:	89 fe                	mov    %edi,%esi
  801f45:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f49:	89 e9                	mov    %ebp,%ecx
  801f4b:	d3 e0                	shl    %cl,%eax
  801f4d:	89 d7                	mov    %edx,%edi
  801f4f:	89 f1                	mov    %esi,%ecx
  801f51:	d3 ef                	shr    %cl,%edi
  801f53:	09 c7                	or     %eax,%edi
  801f55:	89 e9                	mov    %ebp,%ecx
  801f57:	d3 e2                	shl    %cl,%edx
  801f59:	89 14 24             	mov    %edx,(%esp)
  801f5c:	89 d8                	mov    %ebx,%eax
  801f5e:	d3 e0                	shl    %cl,%eax
  801f60:	89 c2                	mov    %eax,%edx
  801f62:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f66:	d3 e0                	shl    %cl,%eax
  801f68:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f6c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f70:	89 f1                	mov    %esi,%ecx
  801f72:	d3 e8                	shr    %cl,%eax
  801f74:	09 d0                	or     %edx,%eax
  801f76:	d3 eb                	shr    %cl,%ebx
  801f78:	89 da                	mov    %ebx,%edx
  801f7a:	f7 f7                	div    %edi
  801f7c:	89 d3                	mov    %edx,%ebx
  801f7e:	f7 24 24             	mull   (%esp)
  801f81:	89 c6                	mov    %eax,%esi
  801f83:	89 d1                	mov    %edx,%ecx
  801f85:	39 d3                	cmp    %edx,%ebx
  801f87:	0f 82 87 00 00 00    	jb     802014 <__umoddi3+0x134>
  801f8d:	0f 84 91 00 00 00    	je     802024 <__umoddi3+0x144>
  801f93:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f97:	29 f2                	sub    %esi,%edx
  801f99:	19 cb                	sbb    %ecx,%ebx
  801f9b:	89 d8                	mov    %ebx,%eax
  801f9d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801fa1:	d3 e0                	shl    %cl,%eax
  801fa3:	89 e9                	mov    %ebp,%ecx
  801fa5:	d3 ea                	shr    %cl,%edx
  801fa7:	09 d0                	or     %edx,%eax
  801fa9:	89 e9                	mov    %ebp,%ecx
  801fab:	d3 eb                	shr    %cl,%ebx
  801fad:	89 da                	mov    %ebx,%edx
  801faf:	83 c4 1c             	add    $0x1c,%esp
  801fb2:	5b                   	pop    %ebx
  801fb3:	5e                   	pop    %esi
  801fb4:	5f                   	pop    %edi
  801fb5:	5d                   	pop    %ebp
  801fb6:	c3                   	ret    
  801fb7:	90                   	nop
  801fb8:	89 fd                	mov    %edi,%ebp
  801fba:	85 ff                	test   %edi,%edi
  801fbc:	75 0b                	jne    801fc9 <__umoddi3+0xe9>
  801fbe:	b8 01 00 00 00       	mov    $0x1,%eax
  801fc3:	31 d2                	xor    %edx,%edx
  801fc5:	f7 f7                	div    %edi
  801fc7:	89 c5                	mov    %eax,%ebp
  801fc9:	89 f0                	mov    %esi,%eax
  801fcb:	31 d2                	xor    %edx,%edx
  801fcd:	f7 f5                	div    %ebp
  801fcf:	89 c8                	mov    %ecx,%eax
  801fd1:	f7 f5                	div    %ebp
  801fd3:	89 d0                	mov    %edx,%eax
  801fd5:	e9 44 ff ff ff       	jmp    801f1e <__umoddi3+0x3e>
  801fda:	66 90                	xchg   %ax,%ax
  801fdc:	89 c8                	mov    %ecx,%eax
  801fde:	89 f2                	mov    %esi,%edx
  801fe0:	83 c4 1c             	add    $0x1c,%esp
  801fe3:	5b                   	pop    %ebx
  801fe4:	5e                   	pop    %esi
  801fe5:	5f                   	pop    %edi
  801fe6:	5d                   	pop    %ebp
  801fe7:	c3                   	ret    
  801fe8:	3b 04 24             	cmp    (%esp),%eax
  801feb:	72 06                	jb     801ff3 <__umoddi3+0x113>
  801fed:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ff1:	77 0f                	ja     802002 <__umoddi3+0x122>
  801ff3:	89 f2                	mov    %esi,%edx
  801ff5:	29 f9                	sub    %edi,%ecx
  801ff7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ffb:	89 14 24             	mov    %edx,(%esp)
  801ffe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802002:	8b 44 24 04          	mov    0x4(%esp),%eax
  802006:	8b 14 24             	mov    (%esp),%edx
  802009:	83 c4 1c             	add    $0x1c,%esp
  80200c:	5b                   	pop    %ebx
  80200d:	5e                   	pop    %esi
  80200e:	5f                   	pop    %edi
  80200f:	5d                   	pop    %ebp
  802010:	c3                   	ret    
  802011:	8d 76 00             	lea    0x0(%esi),%esi
  802014:	2b 04 24             	sub    (%esp),%eax
  802017:	19 fa                	sbb    %edi,%edx
  802019:	89 d1                	mov    %edx,%ecx
  80201b:	89 c6                	mov    %eax,%esi
  80201d:	e9 71 ff ff ff       	jmp    801f93 <__umoddi3+0xb3>
  802022:	66 90                	xchg   %ax,%ax
  802024:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802028:	72 ea                	jb     802014 <__umoddi3+0x134>
  80202a:	89 d9                	mov    %ebx,%ecx
  80202c:	e9 62 ff ff ff       	jmp    801f93 <__umoddi3+0xb3>
