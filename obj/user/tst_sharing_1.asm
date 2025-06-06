
obj/user/tst_sharing_1:     file format elf32-i386


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
  800031:	e8 03 03 00 00       	call   800339 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the creation of shared variables (create_shared_memory)
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 24             	sub    $0x24,%esp
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
  80008d:	68 a0 1f 80 00       	push   $0x801fa0
  800092:	6a 12                	push   $0x12
  800094:	68 bc 1f 80 00       	push   $0x801fbc
  800099:	e8 9d 03 00 00       	call   80043b <_panic>
	}

	uint32 *x, *y, *z ;
	cprintf("STEP A: checking the creation of shared variables... \n");
  80009e:	83 ec 0c             	sub    $0xc,%esp
  8000a1:	68 d4 1f 80 00       	push   $0x801fd4
  8000a6:	e8 44 06 00 00       	call   8006ef <cprintf>
  8000ab:	83 c4 10             	add    $0x10,%esp
	{
		int freeFrames = sys_calculate_free_frames() ;
  8000ae:	e8 c2 17 00 00       	call   801875 <sys_calculate_free_frames>
  8000b3:	89 45 e8             	mov    %eax,-0x18(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8000b6:	83 ec 04             	sub    $0x4,%esp
  8000b9:	6a 01                	push   $0x1
  8000bb:	68 00 10 00 00       	push   $0x1000
  8000c0:	68 0b 20 80 00       	push   $0x80200b
  8000c5:	e8 af 13 00 00       	call   801479 <smalloc>
  8000ca:	83 c4 10             	add    $0x10,%esp
  8000cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		if (x != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  8000d0:	81 7d e4 00 00 00 80 	cmpl   $0x80000000,-0x1c(%ebp)
  8000d7:	74 14                	je     8000ed <_main+0xb5>
  8000d9:	83 ec 04             	sub    $0x4,%esp
  8000dc:	68 10 20 80 00       	push   $0x802010
  8000e1:	6a 1a                	push   $0x1a
  8000e3:	68 bc 1f 80 00       	push   $0x801fbc
  8000e8:	e8 4e 03 00 00       	call   80043b <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  8000ed:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000f0:	e8 80 17 00 00       	call   801875 <sys_calculate_free_frames>
  8000f5:	29 c3                	sub    %eax,%ebx
  8000f7:	89 d8                	mov    %ebx,%eax
  8000f9:	83 f8 04             	cmp    $0x4,%eax
  8000fc:	74 14                	je     800112 <_main+0xda>
  8000fe:	83 ec 04             	sub    $0x4,%esp
  800101:	68 7c 20 80 00       	push   $0x80207c
  800106:	6a 1b                	push   $0x1b
  800108:	68 bc 1f 80 00       	push   $0x801fbc
  80010d:	e8 29 03 00 00       	call   80043b <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800112:	e8 5e 17 00 00       	call   801875 <sys_calculate_free_frames>
  800117:	89 45 e8             	mov    %eax,-0x18(%ebp)
		z = smalloc("z", PAGE_SIZE + 4, 1);
  80011a:	83 ec 04             	sub    $0x4,%esp
  80011d:	6a 01                	push   $0x1
  80011f:	68 04 10 00 00       	push   $0x1004
  800124:	68 fa 20 80 00       	push   $0x8020fa
  800129:	e8 4b 13 00 00       	call   801479 <smalloc>
  80012e:	83 c4 10             	add    $0x10,%esp
  800131:	89 45 e0             	mov    %eax,-0x20(%ebp)
		if (z != (uint32*)(USER_HEAP_START + 1 * PAGE_SIZE)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800134:	81 7d e0 00 10 00 80 	cmpl   $0x80001000,-0x20(%ebp)
  80013b:	74 14                	je     800151 <_main+0x119>
  80013d:	83 ec 04             	sub    $0x4,%esp
  800140:	68 10 20 80 00       	push   $0x802010
  800145:	6a 1f                	push   $0x1f
  800147:	68 bc 1f 80 00       	push   $0x801fbc
  80014c:	e8 ea 02 00 00       	call   80043b <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  2+0+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800151:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800154:	e8 1c 17 00 00       	call   801875 <sys_calculate_free_frames>
  800159:	29 c3                	sub    %eax,%ebx
  80015b:	89 d8                	mov    %ebx,%eax
  80015d:	83 f8 04             	cmp    $0x4,%eax
  800160:	74 14                	je     800176 <_main+0x13e>
  800162:	83 ec 04             	sub    $0x4,%esp
  800165:	68 7c 20 80 00       	push   $0x80207c
  80016a:	6a 20                	push   $0x20
  80016c:	68 bc 1f 80 00       	push   $0x801fbc
  800171:	e8 c5 02 00 00       	call   80043b <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800176:	e8 fa 16 00 00       	call   801875 <sys_calculate_free_frames>
  80017b:	89 45 e8             	mov    %eax,-0x18(%ebp)
		y = smalloc("y", 4, 1);
  80017e:	83 ec 04             	sub    $0x4,%esp
  800181:	6a 01                	push   $0x1
  800183:	6a 04                	push   $0x4
  800185:	68 fc 20 80 00       	push   $0x8020fc
  80018a:	e8 ea 12 00 00       	call   801479 <smalloc>
  80018f:	83 c4 10             	add    $0x10,%esp
  800192:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if (y != (uint32*)(USER_HEAP_START + 3 * PAGE_SIZE)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800195:	81 7d dc 00 30 00 80 	cmpl   $0x80003000,-0x24(%ebp)
  80019c:	74 14                	je     8001b2 <_main+0x17a>
  80019e:	83 ec 04             	sub    $0x4,%esp
  8001a1:	68 10 20 80 00       	push   $0x802010
  8001a6:	6a 24                	push   $0x24
  8001a8:	68 bc 1f 80 00       	push   $0x801fbc
  8001ad:	e8 89 02 00 00       	call   80043b <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+0+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  8001b2:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8001b5:	e8 bb 16 00 00       	call   801875 <sys_calculate_free_frames>
  8001ba:	29 c3                	sub    %eax,%ebx
  8001bc:	89 d8                	mov    %ebx,%eax
  8001be:	83 f8 03             	cmp    $0x3,%eax
  8001c1:	74 14                	je     8001d7 <_main+0x19f>
  8001c3:	83 ec 04             	sub    $0x4,%esp
  8001c6:	68 7c 20 80 00       	push   $0x80207c
  8001cb:	6a 25                	push   $0x25
  8001cd:	68 bc 1f 80 00       	push   $0x801fbc
  8001d2:	e8 64 02 00 00       	call   80043b <_panic>
	}
	cprintf("Step A is completed successfully!!\n\n\n");
  8001d7:	83 ec 0c             	sub    $0xc,%esp
  8001da:	68 00 21 80 00       	push   $0x802100
  8001df:	e8 0b 05 00 00       	call   8006ef <cprintf>
  8001e4:	83 c4 10             	add    $0x10,%esp


	cprintf("STEP B: checking reading & writing... \n");
  8001e7:	83 ec 0c             	sub    $0xc,%esp
  8001ea:	68 28 21 80 00       	push   $0x802128
  8001ef:	e8 fb 04 00 00       	call   8006ef <cprintf>
  8001f4:	83 c4 10             	add    $0x10,%esp
	{
		int i=0;
  8001f7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(;i<PAGE_SIZE/4;i++)
  8001fe:	eb 2d                	jmp    80022d <_main+0x1f5>
		{
			x[i] = -1;
  800200:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800203:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80020a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80020d:	01 d0                	add    %edx,%eax
  80020f:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
			y[i] = -1;
  800215:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800218:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80021f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800222:	01 d0                	add    %edx,%eax
  800224:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)


	cprintf("STEP B: checking reading & writing... \n");
	{
		int i=0;
		for(;i<PAGE_SIZE/4;i++)
  80022a:	ff 45 ec             	incl   -0x14(%ebp)
  80022d:	81 7d ec ff 03 00 00 	cmpl   $0x3ff,-0x14(%ebp)
  800234:	7e ca                	jle    800200 <_main+0x1c8>
		{
			x[i] = -1;
			y[i] = -1;
		}

		i=0;
  800236:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(;i<2*PAGE_SIZE/4;i++)
  80023d:	eb 18                	jmp    800257 <_main+0x21f>
		{
			z[i] = -1;
  80023f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800242:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800249:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80024c:	01 d0                	add    %edx,%eax
  80024e:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
			x[i] = -1;
			y[i] = -1;
		}

		i=0;
		for(;i<2*PAGE_SIZE/4;i++)
  800254:	ff 45 ec             	incl   -0x14(%ebp)
  800257:	81 7d ec ff 07 00 00 	cmpl   $0x7ff,-0x14(%ebp)
  80025e:	7e df                	jle    80023f <_main+0x207>
		{
			z[i] = -1;
		}

		if( x[0] !=  -1)  					panic("Reading/Writing of shared object is failed");
  800260:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800263:	8b 00                	mov    (%eax),%eax
  800265:	83 f8 ff             	cmp    $0xffffffff,%eax
  800268:	74 14                	je     80027e <_main+0x246>
  80026a:	83 ec 04             	sub    $0x4,%esp
  80026d:	68 50 21 80 00       	push   $0x802150
  800272:	6a 39                	push   $0x39
  800274:	68 bc 1f 80 00       	push   $0x801fbc
  800279:	e8 bd 01 00 00       	call   80043b <_panic>
		if( x[PAGE_SIZE/4 - 1] !=  -1)  	panic("Reading/Writing of shared object is failed");
  80027e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800281:	05 fc 0f 00 00       	add    $0xffc,%eax
  800286:	8b 00                	mov    (%eax),%eax
  800288:	83 f8 ff             	cmp    $0xffffffff,%eax
  80028b:	74 14                	je     8002a1 <_main+0x269>
  80028d:	83 ec 04             	sub    $0x4,%esp
  800290:	68 50 21 80 00       	push   $0x802150
  800295:	6a 3a                	push   $0x3a
  800297:	68 bc 1f 80 00       	push   $0x801fbc
  80029c:	e8 9a 01 00 00       	call   80043b <_panic>

		if( y[0] !=  -1)  					panic("Reading/Writing of shared object is failed");
  8002a1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002a4:	8b 00                	mov    (%eax),%eax
  8002a6:	83 f8 ff             	cmp    $0xffffffff,%eax
  8002a9:	74 14                	je     8002bf <_main+0x287>
  8002ab:	83 ec 04             	sub    $0x4,%esp
  8002ae:	68 50 21 80 00       	push   $0x802150
  8002b3:	6a 3c                	push   $0x3c
  8002b5:	68 bc 1f 80 00       	push   $0x801fbc
  8002ba:	e8 7c 01 00 00       	call   80043b <_panic>
		if( y[PAGE_SIZE/4 - 1] !=  -1)  	panic("Reading/Writing of shared object is failed");
  8002bf:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002c2:	05 fc 0f 00 00       	add    $0xffc,%eax
  8002c7:	8b 00                	mov    (%eax),%eax
  8002c9:	83 f8 ff             	cmp    $0xffffffff,%eax
  8002cc:	74 14                	je     8002e2 <_main+0x2aa>
  8002ce:	83 ec 04             	sub    $0x4,%esp
  8002d1:	68 50 21 80 00       	push   $0x802150
  8002d6:	6a 3d                	push   $0x3d
  8002d8:	68 bc 1f 80 00       	push   $0x801fbc
  8002dd:	e8 59 01 00 00       	call   80043b <_panic>

		if( z[0] !=  -1)  					panic("Reading/Writing of shared object is failed");
  8002e2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002e5:	8b 00                	mov    (%eax),%eax
  8002e7:	83 f8 ff             	cmp    $0xffffffff,%eax
  8002ea:	74 14                	je     800300 <_main+0x2c8>
  8002ec:	83 ec 04             	sub    $0x4,%esp
  8002ef:	68 50 21 80 00       	push   $0x802150
  8002f4:	6a 3f                	push   $0x3f
  8002f6:	68 bc 1f 80 00       	push   $0x801fbc
  8002fb:	e8 3b 01 00 00       	call   80043b <_panic>
		if( z[2*PAGE_SIZE/4 - 1] !=  -1)  	panic("Reading/Writing of shared object is failed");
  800300:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800303:	05 fc 1f 00 00       	add    $0x1ffc,%eax
  800308:	8b 00                	mov    (%eax),%eax
  80030a:	83 f8 ff             	cmp    $0xffffffff,%eax
  80030d:	74 14                	je     800323 <_main+0x2eb>
  80030f:	83 ec 04             	sub    $0x4,%esp
  800312:	68 50 21 80 00       	push   $0x802150
  800317:	6a 40                	push   $0x40
  800319:	68 bc 1f 80 00       	push   $0x801fbc
  80031e:	e8 18 01 00 00       	call   80043b <_panic>
	}

	cprintf("Congratulations!! Test of Shared Variables [Create] [1] completed successfully!!\n\n\n");
  800323:	83 ec 0c             	sub    $0xc,%esp
  800326:	68 7c 21 80 00       	push   $0x80217c
  80032b:	e8 bf 03 00 00       	call   8006ef <cprintf>
  800330:	83 c4 10             	add    $0x10,%esp

	return;
  800333:	90                   	nop
}
  800334:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800337:	c9                   	leave  
  800338:	c3                   	ret    

00800339 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800339:	55                   	push   %ebp
  80033a:	89 e5                	mov    %esp,%ebp
  80033c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80033f:	e8 66 14 00 00       	call   8017aa <sys_getenvindex>
  800344:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800347:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80034a:	89 d0                	mov    %edx,%eax
  80034c:	01 c0                	add    %eax,%eax
  80034e:	01 d0                	add    %edx,%eax
  800350:	c1 e0 02             	shl    $0x2,%eax
  800353:	01 d0                	add    %edx,%eax
  800355:	c1 e0 06             	shl    $0x6,%eax
  800358:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80035d:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800362:	a1 20 30 80 00       	mov    0x803020,%eax
  800367:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80036d:	84 c0                	test   %al,%al
  80036f:	74 0f                	je     800380 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800371:	a1 20 30 80 00       	mov    0x803020,%eax
  800376:	05 f4 02 00 00       	add    $0x2f4,%eax
  80037b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800380:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800384:	7e 0a                	jle    800390 <libmain+0x57>
		binaryname = argv[0];
  800386:	8b 45 0c             	mov    0xc(%ebp),%eax
  800389:	8b 00                	mov    (%eax),%eax
  80038b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800390:	83 ec 08             	sub    $0x8,%esp
  800393:	ff 75 0c             	pushl  0xc(%ebp)
  800396:	ff 75 08             	pushl  0x8(%ebp)
  800399:	e8 9a fc ff ff       	call   800038 <_main>
  80039e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003a1:	e8 9f 15 00 00       	call   801945 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003a6:	83 ec 0c             	sub    $0xc,%esp
  8003a9:	68 e8 21 80 00       	push   $0x8021e8
  8003ae:	e8 3c 03 00 00       	call   8006ef <cprintf>
  8003b3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003bb:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8003c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c6:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8003cc:	83 ec 04             	sub    $0x4,%esp
  8003cf:	52                   	push   %edx
  8003d0:	50                   	push   %eax
  8003d1:	68 10 22 80 00       	push   $0x802210
  8003d6:	e8 14 03 00 00       	call   8006ef <cprintf>
  8003db:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8003de:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e3:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8003e9:	83 ec 08             	sub    $0x8,%esp
  8003ec:	50                   	push   %eax
  8003ed:	68 35 22 80 00       	push   $0x802235
  8003f2:	e8 f8 02 00 00       	call   8006ef <cprintf>
  8003f7:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8003fa:	83 ec 0c             	sub    $0xc,%esp
  8003fd:	68 e8 21 80 00       	push   $0x8021e8
  800402:	e8 e8 02 00 00       	call   8006ef <cprintf>
  800407:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80040a:	e8 50 15 00 00       	call   80195f <sys_enable_interrupt>

	// exit gracefully
	exit();
  80040f:	e8 19 00 00 00       	call   80042d <exit>
}
  800414:	90                   	nop
  800415:	c9                   	leave  
  800416:	c3                   	ret    

00800417 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800417:	55                   	push   %ebp
  800418:	89 e5                	mov    %esp,%ebp
  80041a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80041d:	83 ec 0c             	sub    $0xc,%esp
  800420:	6a 00                	push   $0x0
  800422:	e8 4f 13 00 00       	call   801776 <sys_env_destroy>
  800427:	83 c4 10             	add    $0x10,%esp
}
  80042a:	90                   	nop
  80042b:	c9                   	leave  
  80042c:	c3                   	ret    

0080042d <exit>:

void
exit(void)
{
  80042d:	55                   	push   %ebp
  80042e:	89 e5                	mov    %esp,%ebp
  800430:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800433:	e8 a4 13 00 00       	call   8017dc <sys_env_exit>
}
  800438:	90                   	nop
  800439:	c9                   	leave  
  80043a:	c3                   	ret    

0080043b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80043b:	55                   	push   %ebp
  80043c:	89 e5                	mov    %esp,%ebp
  80043e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800441:	8d 45 10             	lea    0x10(%ebp),%eax
  800444:	83 c0 04             	add    $0x4,%eax
  800447:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80044a:	a1 30 30 80 00       	mov    0x803030,%eax
  80044f:	85 c0                	test   %eax,%eax
  800451:	74 16                	je     800469 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800453:	a1 30 30 80 00       	mov    0x803030,%eax
  800458:	83 ec 08             	sub    $0x8,%esp
  80045b:	50                   	push   %eax
  80045c:	68 4c 22 80 00       	push   $0x80224c
  800461:	e8 89 02 00 00       	call   8006ef <cprintf>
  800466:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800469:	a1 00 30 80 00       	mov    0x803000,%eax
  80046e:	ff 75 0c             	pushl  0xc(%ebp)
  800471:	ff 75 08             	pushl  0x8(%ebp)
  800474:	50                   	push   %eax
  800475:	68 51 22 80 00       	push   $0x802251
  80047a:	e8 70 02 00 00       	call   8006ef <cprintf>
  80047f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800482:	8b 45 10             	mov    0x10(%ebp),%eax
  800485:	83 ec 08             	sub    $0x8,%esp
  800488:	ff 75 f4             	pushl  -0xc(%ebp)
  80048b:	50                   	push   %eax
  80048c:	e8 f3 01 00 00       	call   800684 <vcprintf>
  800491:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800494:	83 ec 08             	sub    $0x8,%esp
  800497:	6a 00                	push   $0x0
  800499:	68 6d 22 80 00       	push   $0x80226d
  80049e:	e8 e1 01 00 00       	call   800684 <vcprintf>
  8004a3:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8004a6:	e8 82 ff ff ff       	call   80042d <exit>

	// should not return here
	while (1) ;
  8004ab:	eb fe                	jmp    8004ab <_panic+0x70>

008004ad <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8004ad:	55                   	push   %ebp
  8004ae:	89 e5                	mov    %esp,%ebp
  8004b0:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8004b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b8:	8b 50 74             	mov    0x74(%eax),%edx
  8004bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004be:	39 c2                	cmp    %eax,%edx
  8004c0:	74 14                	je     8004d6 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8004c2:	83 ec 04             	sub    $0x4,%esp
  8004c5:	68 70 22 80 00       	push   $0x802270
  8004ca:	6a 26                	push   $0x26
  8004cc:	68 bc 22 80 00       	push   $0x8022bc
  8004d1:	e8 65 ff ff ff       	call   80043b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8004d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8004dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004e4:	e9 c2 00 00 00       	jmp    8005ab <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8004e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f6:	01 d0                	add    %edx,%eax
  8004f8:	8b 00                	mov    (%eax),%eax
  8004fa:	85 c0                	test   %eax,%eax
  8004fc:	75 08                	jne    800506 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8004fe:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800501:	e9 a2 00 00 00       	jmp    8005a8 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800506:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80050d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800514:	eb 69                	jmp    80057f <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800516:	a1 20 30 80 00       	mov    0x803020,%eax
  80051b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800521:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800524:	89 d0                	mov    %edx,%eax
  800526:	01 c0                	add    %eax,%eax
  800528:	01 d0                	add    %edx,%eax
  80052a:	c1 e0 02             	shl    $0x2,%eax
  80052d:	01 c8                	add    %ecx,%eax
  80052f:	8a 40 04             	mov    0x4(%eax),%al
  800532:	84 c0                	test   %al,%al
  800534:	75 46                	jne    80057c <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800536:	a1 20 30 80 00       	mov    0x803020,%eax
  80053b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800541:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800544:	89 d0                	mov    %edx,%eax
  800546:	01 c0                	add    %eax,%eax
  800548:	01 d0                	add    %edx,%eax
  80054a:	c1 e0 02             	shl    $0x2,%eax
  80054d:	01 c8                	add    %ecx,%eax
  80054f:	8b 00                	mov    (%eax),%eax
  800551:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800554:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800557:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80055c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80055e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800561:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800568:	8b 45 08             	mov    0x8(%ebp),%eax
  80056b:	01 c8                	add    %ecx,%eax
  80056d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80056f:	39 c2                	cmp    %eax,%edx
  800571:	75 09                	jne    80057c <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800573:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80057a:	eb 12                	jmp    80058e <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80057c:	ff 45 e8             	incl   -0x18(%ebp)
  80057f:	a1 20 30 80 00       	mov    0x803020,%eax
  800584:	8b 50 74             	mov    0x74(%eax),%edx
  800587:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80058a:	39 c2                	cmp    %eax,%edx
  80058c:	77 88                	ja     800516 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80058e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800592:	75 14                	jne    8005a8 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800594:	83 ec 04             	sub    $0x4,%esp
  800597:	68 c8 22 80 00       	push   $0x8022c8
  80059c:	6a 3a                	push   $0x3a
  80059e:	68 bc 22 80 00       	push   $0x8022bc
  8005a3:	e8 93 fe ff ff       	call   80043b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005a8:	ff 45 f0             	incl   -0x10(%ebp)
  8005ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005ae:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005b1:	0f 8c 32 ff ff ff    	jl     8004e9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8005b7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005be:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8005c5:	eb 26                	jmp    8005ed <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8005c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8005cc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8005d2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005d5:	89 d0                	mov    %edx,%eax
  8005d7:	01 c0                	add    %eax,%eax
  8005d9:	01 d0                	add    %edx,%eax
  8005db:	c1 e0 02             	shl    $0x2,%eax
  8005de:	01 c8                	add    %ecx,%eax
  8005e0:	8a 40 04             	mov    0x4(%eax),%al
  8005e3:	3c 01                	cmp    $0x1,%al
  8005e5:	75 03                	jne    8005ea <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8005e7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005ea:	ff 45 e0             	incl   -0x20(%ebp)
  8005ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f2:	8b 50 74             	mov    0x74(%eax),%edx
  8005f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005f8:	39 c2                	cmp    %eax,%edx
  8005fa:	77 cb                	ja     8005c7 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8005fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005ff:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800602:	74 14                	je     800618 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800604:	83 ec 04             	sub    $0x4,%esp
  800607:	68 1c 23 80 00       	push   $0x80231c
  80060c:	6a 44                	push   $0x44
  80060e:	68 bc 22 80 00       	push   $0x8022bc
  800613:	e8 23 fe ff ff       	call   80043b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800618:	90                   	nop
  800619:	c9                   	leave  
  80061a:	c3                   	ret    

0080061b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80061b:	55                   	push   %ebp
  80061c:	89 e5                	mov    %esp,%ebp
  80061e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800621:	8b 45 0c             	mov    0xc(%ebp),%eax
  800624:	8b 00                	mov    (%eax),%eax
  800626:	8d 48 01             	lea    0x1(%eax),%ecx
  800629:	8b 55 0c             	mov    0xc(%ebp),%edx
  80062c:	89 0a                	mov    %ecx,(%edx)
  80062e:	8b 55 08             	mov    0x8(%ebp),%edx
  800631:	88 d1                	mov    %dl,%cl
  800633:	8b 55 0c             	mov    0xc(%ebp),%edx
  800636:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80063a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80063d:	8b 00                	mov    (%eax),%eax
  80063f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800644:	75 2c                	jne    800672 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800646:	a0 24 30 80 00       	mov    0x803024,%al
  80064b:	0f b6 c0             	movzbl %al,%eax
  80064e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800651:	8b 12                	mov    (%edx),%edx
  800653:	89 d1                	mov    %edx,%ecx
  800655:	8b 55 0c             	mov    0xc(%ebp),%edx
  800658:	83 c2 08             	add    $0x8,%edx
  80065b:	83 ec 04             	sub    $0x4,%esp
  80065e:	50                   	push   %eax
  80065f:	51                   	push   %ecx
  800660:	52                   	push   %edx
  800661:	e8 ce 10 00 00       	call   801734 <sys_cputs>
  800666:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800669:	8b 45 0c             	mov    0xc(%ebp),%eax
  80066c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800672:	8b 45 0c             	mov    0xc(%ebp),%eax
  800675:	8b 40 04             	mov    0x4(%eax),%eax
  800678:	8d 50 01             	lea    0x1(%eax),%edx
  80067b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80067e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800681:	90                   	nop
  800682:	c9                   	leave  
  800683:	c3                   	ret    

00800684 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800684:	55                   	push   %ebp
  800685:	89 e5                	mov    %esp,%ebp
  800687:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80068d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800694:	00 00 00 
	b.cnt = 0;
  800697:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80069e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006a1:	ff 75 0c             	pushl  0xc(%ebp)
  8006a4:	ff 75 08             	pushl  0x8(%ebp)
  8006a7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006ad:	50                   	push   %eax
  8006ae:	68 1b 06 80 00       	push   $0x80061b
  8006b3:	e8 11 02 00 00       	call   8008c9 <vprintfmt>
  8006b8:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006bb:	a0 24 30 80 00       	mov    0x803024,%al
  8006c0:	0f b6 c0             	movzbl %al,%eax
  8006c3:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8006c9:	83 ec 04             	sub    $0x4,%esp
  8006cc:	50                   	push   %eax
  8006cd:	52                   	push   %edx
  8006ce:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006d4:	83 c0 08             	add    $0x8,%eax
  8006d7:	50                   	push   %eax
  8006d8:	e8 57 10 00 00       	call   801734 <sys_cputs>
  8006dd:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8006e0:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8006e7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8006ed:	c9                   	leave  
  8006ee:	c3                   	ret    

008006ef <cprintf>:

int cprintf(const char *fmt, ...) {
  8006ef:	55                   	push   %ebp
  8006f0:	89 e5                	mov    %esp,%ebp
  8006f2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006f5:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8006fc:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800702:	8b 45 08             	mov    0x8(%ebp),%eax
  800705:	83 ec 08             	sub    $0x8,%esp
  800708:	ff 75 f4             	pushl  -0xc(%ebp)
  80070b:	50                   	push   %eax
  80070c:	e8 73 ff ff ff       	call   800684 <vcprintf>
  800711:	83 c4 10             	add    $0x10,%esp
  800714:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800717:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80071a:	c9                   	leave  
  80071b:	c3                   	ret    

0080071c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80071c:	55                   	push   %ebp
  80071d:	89 e5                	mov    %esp,%ebp
  80071f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800722:	e8 1e 12 00 00       	call   801945 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800727:	8d 45 0c             	lea    0xc(%ebp),%eax
  80072a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80072d:	8b 45 08             	mov    0x8(%ebp),%eax
  800730:	83 ec 08             	sub    $0x8,%esp
  800733:	ff 75 f4             	pushl  -0xc(%ebp)
  800736:	50                   	push   %eax
  800737:	e8 48 ff ff ff       	call   800684 <vcprintf>
  80073c:	83 c4 10             	add    $0x10,%esp
  80073f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800742:	e8 18 12 00 00       	call   80195f <sys_enable_interrupt>
	return cnt;
  800747:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80074a:	c9                   	leave  
  80074b:	c3                   	ret    

0080074c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80074c:	55                   	push   %ebp
  80074d:	89 e5                	mov    %esp,%ebp
  80074f:	53                   	push   %ebx
  800750:	83 ec 14             	sub    $0x14,%esp
  800753:	8b 45 10             	mov    0x10(%ebp),%eax
  800756:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800759:	8b 45 14             	mov    0x14(%ebp),%eax
  80075c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80075f:	8b 45 18             	mov    0x18(%ebp),%eax
  800762:	ba 00 00 00 00       	mov    $0x0,%edx
  800767:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80076a:	77 55                	ja     8007c1 <printnum+0x75>
  80076c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80076f:	72 05                	jb     800776 <printnum+0x2a>
  800771:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800774:	77 4b                	ja     8007c1 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800776:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800779:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80077c:	8b 45 18             	mov    0x18(%ebp),%eax
  80077f:	ba 00 00 00 00       	mov    $0x0,%edx
  800784:	52                   	push   %edx
  800785:	50                   	push   %eax
  800786:	ff 75 f4             	pushl  -0xc(%ebp)
  800789:	ff 75 f0             	pushl  -0x10(%ebp)
  80078c:	e8 93 15 00 00       	call   801d24 <__udivdi3>
  800791:	83 c4 10             	add    $0x10,%esp
  800794:	83 ec 04             	sub    $0x4,%esp
  800797:	ff 75 20             	pushl  0x20(%ebp)
  80079a:	53                   	push   %ebx
  80079b:	ff 75 18             	pushl  0x18(%ebp)
  80079e:	52                   	push   %edx
  80079f:	50                   	push   %eax
  8007a0:	ff 75 0c             	pushl  0xc(%ebp)
  8007a3:	ff 75 08             	pushl  0x8(%ebp)
  8007a6:	e8 a1 ff ff ff       	call   80074c <printnum>
  8007ab:	83 c4 20             	add    $0x20,%esp
  8007ae:	eb 1a                	jmp    8007ca <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007b0:	83 ec 08             	sub    $0x8,%esp
  8007b3:	ff 75 0c             	pushl  0xc(%ebp)
  8007b6:	ff 75 20             	pushl  0x20(%ebp)
  8007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bc:	ff d0                	call   *%eax
  8007be:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007c1:	ff 4d 1c             	decl   0x1c(%ebp)
  8007c4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007c8:	7f e6                	jg     8007b0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007ca:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007cd:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007d8:	53                   	push   %ebx
  8007d9:	51                   	push   %ecx
  8007da:	52                   	push   %edx
  8007db:	50                   	push   %eax
  8007dc:	e8 53 16 00 00       	call   801e34 <__umoddi3>
  8007e1:	83 c4 10             	add    $0x10,%esp
  8007e4:	05 94 25 80 00       	add    $0x802594,%eax
  8007e9:	8a 00                	mov    (%eax),%al
  8007eb:	0f be c0             	movsbl %al,%eax
  8007ee:	83 ec 08             	sub    $0x8,%esp
  8007f1:	ff 75 0c             	pushl  0xc(%ebp)
  8007f4:	50                   	push   %eax
  8007f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f8:	ff d0                	call   *%eax
  8007fa:	83 c4 10             	add    $0x10,%esp
}
  8007fd:	90                   	nop
  8007fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800801:	c9                   	leave  
  800802:	c3                   	ret    

00800803 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800803:	55                   	push   %ebp
  800804:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800806:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80080a:	7e 1c                	jle    800828 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80080c:	8b 45 08             	mov    0x8(%ebp),%eax
  80080f:	8b 00                	mov    (%eax),%eax
  800811:	8d 50 08             	lea    0x8(%eax),%edx
  800814:	8b 45 08             	mov    0x8(%ebp),%eax
  800817:	89 10                	mov    %edx,(%eax)
  800819:	8b 45 08             	mov    0x8(%ebp),%eax
  80081c:	8b 00                	mov    (%eax),%eax
  80081e:	83 e8 08             	sub    $0x8,%eax
  800821:	8b 50 04             	mov    0x4(%eax),%edx
  800824:	8b 00                	mov    (%eax),%eax
  800826:	eb 40                	jmp    800868 <getuint+0x65>
	else if (lflag)
  800828:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80082c:	74 1e                	je     80084c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80082e:	8b 45 08             	mov    0x8(%ebp),%eax
  800831:	8b 00                	mov    (%eax),%eax
  800833:	8d 50 04             	lea    0x4(%eax),%edx
  800836:	8b 45 08             	mov    0x8(%ebp),%eax
  800839:	89 10                	mov    %edx,(%eax)
  80083b:	8b 45 08             	mov    0x8(%ebp),%eax
  80083e:	8b 00                	mov    (%eax),%eax
  800840:	83 e8 04             	sub    $0x4,%eax
  800843:	8b 00                	mov    (%eax),%eax
  800845:	ba 00 00 00 00       	mov    $0x0,%edx
  80084a:	eb 1c                	jmp    800868 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80084c:	8b 45 08             	mov    0x8(%ebp),%eax
  80084f:	8b 00                	mov    (%eax),%eax
  800851:	8d 50 04             	lea    0x4(%eax),%edx
  800854:	8b 45 08             	mov    0x8(%ebp),%eax
  800857:	89 10                	mov    %edx,(%eax)
  800859:	8b 45 08             	mov    0x8(%ebp),%eax
  80085c:	8b 00                	mov    (%eax),%eax
  80085e:	83 e8 04             	sub    $0x4,%eax
  800861:	8b 00                	mov    (%eax),%eax
  800863:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800868:	5d                   	pop    %ebp
  800869:	c3                   	ret    

0080086a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80086a:	55                   	push   %ebp
  80086b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80086d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800871:	7e 1c                	jle    80088f <getint+0x25>
		return va_arg(*ap, long long);
  800873:	8b 45 08             	mov    0x8(%ebp),%eax
  800876:	8b 00                	mov    (%eax),%eax
  800878:	8d 50 08             	lea    0x8(%eax),%edx
  80087b:	8b 45 08             	mov    0x8(%ebp),%eax
  80087e:	89 10                	mov    %edx,(%eax)
  800880:	8b 45 08             	mov    0x8(%ebp),%eax
  800883:	8b 00                	mov    (%eax),%eax
  800885:	83 e8 08             	sub    $0x8,%eax
  800888:	8b 50 04             	mov    0x4(%eax),%edx
  80088b:	8b 00                	mov    (%eax),%eax
  80088d:	eb 38                	jmp    8008c7 <getint+0x5d>
	else if (lflag)
  80088f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800893:	74 1a                	je     8008af <getint+0x45>
		return va_arg(*ap, long);
  800895:	8b 45 08             	mov    0x8(%ebp),%eax
  800898:	8b 00                	mov    (%eax),%eax
  80089a:	8d 50 04             	lea    0x4(%eax),%edx
  80089d:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a0:	89 10                	mov    %edx,(%eax)
  8008a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a5:	8b 00                	mov    (%eax),%eax
  8008a7:	83 e8 04             	sub    $0x4,%eax
  8008aa:	8b 00                	mov    (%eax),%eax
  8008ac:	99                   	cltd   
  8008ad:	eb 18                	jmp    8008c7 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008af:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b2:	8b 00                	mov    (%eax),%eax
  8008b4:	8d 50 04             	lea    0x4(%eax),%edx
  8008b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ba:	89 10                	mov    %edx,(%eax)
  8008bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bf:	8b 00                	mov    (%eax),%eax
  8008c1:	83 e8 04             	sub    $0x4,%eax
  8008c4:	8b 00                	mov    (%eax),%eax
  8008c6:	99                   	cltd   
}
  8008c7:	5d                   	pop    %ebp
  8008c8:	c3                   	ret    

008008c9 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008c9:	55                   	push   %ebp
  8008ca:	89 e5                	mov    %esp,%ebp
  8008cc:	56                   	push   %esi
  8008cd:	53                   	push   %ebx
  8008ce:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008d1:	eb 17                	jmp    8008ea <vprintfmt+0x21>
			if (ch == '\0')
  8008d3:	85 db                	test   %ebx,%ebx
  8008d5:	0f 84 af 03 00 00    	je     800c8a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8008db:	83 ec 08             	sub    $0x8,%esp
  8008de:	ff 75 0c             	pushl  0xc(%ebp)
  8008e1:	53                   	push   %ebx
  8008e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e5:	ff d0                	call   *%eax
  8008e7:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ed:	8d 50 01             	lea    0x1(%eax),%edx
  8008f0:	89 55 10             	mov    %edx,0x10(%ebp)
  8008f3:	8a 00                	mov    (%eax),%al
  8008f5:	0f b6 d8             	movzbl %al,%ebx
  8008f8:	83 fb 25             	cmp    $0x25,%ebx
  8008fb:	75 d6                	jne    8008d3 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008fd:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800901:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800908:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80090f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800916:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80091d:	8b 45 10             	mov    0x10(%ebp),%eax
  800920:	8d 50 01             	lea    0x1(%eax),%edx
  800923:	89 55 10             	mov    %edx,0x10(%ebp)
  800926:	8a 00                	mov    (%eax),%al
  800928:	0f b6 d8             	movzbl %al,%ebx
  80092b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80092e:	83 f8 55             	cmp    $0x55,%eax
  800931:	0f 87 2b 03 00 00    	ja     800c62 <vprintfmt+0x399>
  800937:	8b 04 85 b8 25 80 00 	mov    0x8025b8(,%eax,4),%eax
  80093e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800940:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800944:	eb d7                	jmp    80091d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800946:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80094a:	eb d1                	jmp    80091d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80094c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800953:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800956:	89 d0                	mov    %edx,%eax
  800958:	c1 e0 02             	shl    $0x2,%eax
  80095b:	01 d0                	add    %edx,%eax
  80095d:	01 c0                	add    %eax,%eax
  80095f:	01 d8                	add    %ebx,%eax
  800961:	83 e8 30             	sub    $0x30,%eax
  800964:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800967:	8b 45 10             	mov    0x10(%ebp),%eax
  80096a:	8a 00                	mov    (%eax),%al
  80096c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80096f:	83 fb 2f             	cmp    $0x2f,%ebx
  800972:	7e 3e                	jle    8009b2 <vprintfmt+0xe9>
  800974:	83 fb 39             	cmp    $0x39,%ebx
  800977:	7f 39                	jg     8009b2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800979:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80097c:	eb d5                	jmp    800953 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80097e:	8b 45 14             	mov    0x14(%ebp),%eax
  800981:	83 c0 04             	add    $0x4,%eax
  800984:	89 45 14             	mov    %eax,0x14(%ebp)
  800987:	8b 45 14             	mov    0x14(%ebp),%eax
  80098a:	83 e8 04             	sub    $0x4,%eax
  80098d:	8b 00                	mov    (%eax),%eax
  80098f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800992:	eb 1f                	jmp    8009b3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800994:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800998:	79 83                	jns    80091d <vprintfmt+0x54>
				width = 0;
  80099a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009a1:	e9 77 ff ff ff       	jmp    80091d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009a6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009ad:	e9 6b ff ff ff       	jmp    80091d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009b2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009b3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009b7:	0f 89 60 ff ff ff    	jns    80091d <vprintfmt+0x54>
				width = precision, precision = -1;
  8009bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009c3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009ca:	e9 4e ff ff ff       	jmp    80091d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009cf:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009d2:	e9 46 ff ff ff       	jmp    80091d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8009da:	83 c0 04             	add    $0x4,%eax
  8009dd:	89 45 14             	mov    %eax,0x14(%ebp)
  8009e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e3:	83 e8 04             	sub    $0x4,%eax
  8009e6:	8b 00                	mov    (%eax),%eax
  8009e8:	83 ec 08             	sub    $0x8,%esp
  8009eb:	ff 75 0c             	pushl  0xc(%ebp)
  8009ee:	50                   	push   %eax
  8009ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f2:	ff d0                	call   *%eax
  8009f4:	83 c4 10             	add    $0x10,%esp
			break;
  8009f7:	e9 89 02 00 00       	jmp    800c85 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ff:	83 c0 04             	add    $0x4,%eax
  800a02:	89 45 14             	mov    %eax,0x14(%ebp)
  800a05:	8b 45 14             	mov    0x14(%ebp),%eax
  800a08:	83 e8 04             	sub    $0x4,%eax
  800a0b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a0d:	85 db                	test   %ebx,%ebx
  800a0f:	79 02                	jns    800a13 <vprintfmt+0x14a>
				err = -err;
  800a11:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a13:	83 fb 64             	cmp    $0x64,%ebx
  800a16:	7f 0b                	jg     800a23 <vprintfmt+0x15a>
  800a18:	8b 34 9d 00 24 80 00 	mov    0x802400(,%ebx,4),%esi
  800a1f:	85 f6                	test   %esi,%esi
  800a21:	75 19                	jne    800a3c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a23:	53                   	push   %ebx
  800a24:	68 a5 25 80 00       	push   $0x8025a5
  800a29:	ff 75 0c             	pushl  0xc(%ebp)
  800a2c:	ff 75 08             	pushl  0x8(%ebp)
  800a2f:	e8 5e 02 00 00       	call   800c92 <printfmt>
  800a34:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a37:	e9 49 02 00 00       	jmp    800c85 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a3c:	56                   	push   %esi
  800a3d:	68 ae 25 80 00       	push   $0x8025ae
  800a42:	ff 75 0c             	pushl  0xc(%ebp)
  800a45:	ff 75 08             	pushl  0x8(%ebp)
  800a48:	e8 45 02 00 00       	call   800c92 <printfmt>
  800a4d:	83 c4 10             	add    $0x10,%esp
			break;
  800a50:	e9 30 02 00 00       	jmp    800c85 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a55:	8b 45 14             	mov    0x14(%ebp),%eax
  800a58:	83 c0 04             	add    $0x4,%eax
  800a5b:	89 45 14             	mov    %eax,0x14(%ebp)
  800a5e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a61:	83 e8 04             	sub    $0x4,%eax
  800a64:	8b 30                	mov    (%eax),%esi
  800a66:	85 f6                	test   %esi,%esi
  800a68:	75 05                	jne    800a6f <vprintfmt+0x1a6>
				p = "(null)";
  800a6a:	be b1 25 80 00       	mov    $0x8025b1,%esi
			if (width > 0 && padc != '-')
  800a6f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a73:	7e 6d                	jle    800ae2 <vprintfmt+0x219>
  800a75:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a79:	74 67                	je     800ae2 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a7b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a7e:	83 ec 08             	sub    $0x8,%esp
  800a81:	50                   	push   %eax
  800a82:	56                   	push   %esi
  800a83:	e8 0c 03 00 00       	call   800d94 <strnlen>
  800a88:	83 c4 10             	add    $0x10,%esp
  800a8b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a8e:	eb 16                	jmp    800aa6 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a90:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a94:	83 ec 08             	sub    $0x8,%esp
  800a97:	ff 75 0c             	pushl  0xc(%ebp)
  800a9a:	50                   	push   %eax
  800a9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9e:	ff d0                	call   *%eax
  800aa0:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800aa3:	ff 4d e4             	decl   -0x1c(%ebp)
  800aa6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aaa:	7f e4                	jg     800a90 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800aac:	eb 34                	jmp    800ae2 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800aae:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ab2:	74 1c                	je     800ad0 <vprintfmt+0x207>
  800ab4:	83 fb 1f             	cmp    $0x1f,%ebx
  800ab7:	7e 05                	jle    800abe <vprintfmt+0x1f5>
  800ab9:	83 fb 7e             	cmp    $0x7e,%ebx
  800abc:	7e 12                	jle    800ad0 <vprintfmt+0x207>
					putch('?', putdat);
  800abe:	83 ec 08             	sub    $0x8,%esp
  800ac1:	ff 75 0c             	pushl  0xc(%ebp)
  800ac4:	6a 3f                	push   $0x3f
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	ff d0                	call   *%eax
  800acb:	83 c4 10             	add    $0x10,%esp
  800ace:	eb 0f                	jmp    800adf <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800ad0:	83 ec 08             	sub    $0x8,%esp
  800ad3:	ff 75 0c             	pushl  0xc(%ebp)
  800ad6:	53                   	push   %ebx
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	ff d0                	call   *%eax
  800adc:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800adf:	ff 4d e4             	decl   -0x1c(%ebp)
  800ae2:	89 f0                	mov    %esi,%eax
  800ae4:	8d 70 01             	lea    0x1(%eax),%esi
  800ae7:	8a 00                	mov    (%eax),%al
  800ae9:	0f be d8             	movsbl %al,%ebx
  800aec:	85 db                	test   %ebx,%ebx
  800aee:	74 24                	je     800b14 <vprintfmt+0x24b>
  800af0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800af4:	78 b8                	js     800aae <vprintfmt+0x1e5>
  800af6:	ff 4d e0             	decl   -0x20(%ebp)
  800af9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800afd:	79 af                	jns    800aae <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800aff:	eb 13                	jmp    800b14 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b01:	83 ec 08             	sub    $0x8,%esp
  800b04:	ff 75 0c             	pushl  0xc(%ebp)
  800b07:	6a 20                	push   $0x20
  800b09:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0c:	ff d0                	call   *%eax
  800b0e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b11:	ff 4d e4             	decl   -0x1c(%ebp)
  800b14:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b18:	7f e7                	jg     800b01 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b1a:	e9 66 01 00 00       	jmp    800c85 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b1f:	83 ec 08             	sub    $0x8,%esp
  800b22:	ff 75 e8             	pushl  -0x18(%ebp)
  800b25:	8d 45 14             	lea    0x14(%ebp),%eax
  800b28:	50                   	push   %eax
  800b29:	e8 3c fd ff ff       	call   80086a <getint>
  800b2e:	83 c4 10             	add    $0x10,%esp
  800b31:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b34:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b37:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b3d:	85 d2                	test   %edx,%edx
  800b3f:	79 23                	jns    800b64 <vprintfmt+0x29b>
				putch('-', putdat);
  800b41:	83 ec 08             	sub    $0x8,%esp
  800b44:	ff 75 0c             	pushl  0xc(%ebp)
  800b47:	6a 2d                	push   $0x2d
  800b49:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4c:	ff d0                	call   *%eax
  800b4e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b51:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b54:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b57:	f7 d8                	neg    %eax
  800b59:	83 d2 00             	adc    $0x0,%edx
  800b5c:	f7 da                	neg    %edx
  800b5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b61:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b64:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b6b:	e9 bc 00 00 00       	jmp    800c2c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b70:	83 ec 08             	sub    $0x8,%esp
  800b73:	ff 75 e8             	pushl  -0x18(%ebp)
  800b76:	8d 45 14             	lea    0x14(%ebp),%eax
  800b79:	50                   	push   %eax
  800b7a:	e8 84 fc ff ff       	call   800803 <getuint>
  800b7f:	83 c4 10             	add    $0x10,%esp
  800b82:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b85:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b88:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b8f:	e9 98 00 00 00       	jmp    800c2c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b94:	83 ec 08             	sub    $0x8,%esp
  800b97:	ff 75 0c             	pushl  0xc(%ebp)
  800b9a:	6a 58                	push   $0x58
  800b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9f:	ff d0                	call   *%eax
  800ba1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ba4:	83 ec 08             	sub    $0x8,%esp
  800ba7:	ff 75 0c             	pushl  0xc(%ebp)
  800baa:	6a 58                	push   $0x58
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	ff d0                	call   *%eax
  800bb1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bb4:	83 ec 08             	sub    $0x8,%esp
  800bb7:	ff 75 0c             	pushl  0xc(%ebp)
  800bba:	6a 58                	push   $0x58
  800bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbf:	ff d0                	call   *%eax
  800bc1:	83 c4 10             	add    $0x10,%esp
			break;
  800bc4:	e9 bc 00 00 00       	jmp    800c85 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800bc9:	83 ec 08             	sub    $0x8,%esp
  800bcc:	ff 75 0c             	pushl  0xc(%ebp)
  800bcf:	6a 30                	push   $0x30
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	ff d0                	call   *%eax
  800bd6:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800bd9:	83 ec 08             	sub    $0x8,%esp
  800bdc:	ff 75 0c             	pushl  0xc(%ebp)
  800bdf:	6a 78                	push   $0x78
  800be1:	8b 45 08             	mov    0x8(%ebp),%eax
  800be4:	ff d0                	call   *%eax
  800be6:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800be9:	8b 45 14             	mov    0x14(%ebp),%eax
  800bec:	83 c0 04             	add    $0x4,%eax
  800bef:	89 45 14             	mov    %eax,0x14(%ebp)
  800bf2:	8b 45 14             	mov    0x14(%ebp),%eax
  800bf5:	83 e8 04             	sub    $0x4,%eax
  800bf8:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800bfa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bfd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c04:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c0b:	eb 1f                	jmp    800c2c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c0d:	83 ec 08             	sub    $0x8,%esp
  800c10:	ff 75 e8             	pushl  -0x18(%ebp)
  800c13:	8d 45 14             	lea    0x14(%ebp),%eax
  800c16:	50                   	push   %eax
  800c17:	e8 e7 fb ff ff       	call   800803 <getuint>
  800c1c:	83 c4 10             	add    $0x10,%esp
  800c1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c22:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c25:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c2c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c30:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c33:	83 ec 04             	sub    $0x4,%esp
  800c36:	52                   	push   %edx
  800c37:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c3a:	50                   	push   %eax
  800c3b:	ff 75 f4             	pushl  -0xc(%ebp)
  800c3e:	ff 75 f0             	pushl  -0x10(%ebp)
  800c41:	ff 75 0c             	pushl  0xc(%ebp)
  800c44:	ff 75 08             	pushl  0x8(%ebp)
  800c47:	e8 00 fb ff ff       	call   80074c <printnum>
  800c4c:	83 c4 20             	add    $0x20,%esp
			break;
  800c4f:	eb 34                	jmp    800c85 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c51:	83 ec 08             	sub    $0x8,%esp
  800c54:	ff 75 0c             	pushl  0xc(%ebp)
  800c57:	53                   	push   %ebx
  800c58:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5b:	ff d0                	call   *%eax
  800c5d:	83 c4 10             	add    $0x10,%esp
			break;
  800c60:	eb 23                	jmp    800c85 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c62:	83 ec 08             	sub    $0x8,%esp
  800c65:	ff 75 0c             	pushl  0xc(%ebp)
  800c68:	6a 25                	push   $0x25
  800c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6d:	ff d0                	call   *%eax
  800c6f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c72:	ff 4d 10             	decl   0x10(%ebp)
  800c75:	eb 03                	jmp    800c7a <vprintfmt+0x3b1>
  800c77:	ff 4d 10             	decl   0x10(%ebp)
  800c7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c7d:	48                   	dec    %eax
  800c7e:	8a 00                	mov    (%eax),%al
  800c80:	3c 25                	cmp    $0x25,%al
  800c82:	75 f3                	jne    800c77 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c84:	90                   	nop
		}
	}
  800c85:	e9 47 fc ff ff       	jmp    8008d1 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c8a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c8b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c8e:	5b                   	pop    %ebx
  800c8f:	5e                   	pop    %esi
  800c90:	5d                   	pop    %ebp
  800c91:	c3                   	ret    

00800c92 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c92:	55                   	push   %ebp
  800c93:	89 e5                	mov    %esp,%ebp
  800c95:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c98:	8d 45 10             	lea    0x10(%ebp),%eax
  800c9b:	83 c0 04             	add    $0x4,%eax
  800c9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ca1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ca7:	50                   	push   %eax
  800ca8:	ff 75 0c             	pushl  0xc(%ebp)
  800cab:	ff 75 08             	pushl  0x8(%ebp)
  800cae:	e8 16 fc ff ff       	call   8008c9 <vprintfmt>
  800cb3:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cb6:	90                   	nop
  800cb7:	c9                   	leave  
  800cb8:	c3                   	ret    

00800cb9 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800cb9:	55                   	push   %ebp
  800cba:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800cbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbf:	8b 40 08             	mov    0x8(%eax),%eax
  800cc2:	8d 50 01             	lea    0x1(%eax),%edx
  800cc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc8:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ccb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cce:	8b 10                	mov    (%eax),%edx
  800cd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd3:	8b 40 04             	mov    0x4(%eax),%eax
  800cd6:	39 c2                	cmp    %eax,%edx
  800cd8:	73 12                	jae    800cec <sprintputch+0x33>
		*b->buf++ = ch;
  800cda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cdd:	8b 00                	mov    (%eax),%eax
  800cdf:	8d 48 01             	lea    0x1(%eax),%ecx
  800ce2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ce5:	89 0a                	mov    %ecx,(%edx)
  800ce7:	8b 55 08             	mov    0x8(%ebp),%edx
  800cea:	88 10                	mov    %dl,(%eax)
}
  800cec:	90                   	nop
  800ced:	5d                   	pop    %ebp
  800cee:	c3                   	ret    

00800cef <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800cef:	55                   	push   %ebp
  800cf0:	89 e5                	mov    %esp,%ebp
  800cf2:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800cfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfe:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d01:	8b 45 08             	mov    0x8(%ebp),%eax
  800d04:	01 d0                	add    %edx,%eax
  800d06:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d09:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d10:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d14:	74 06                	je     800d1c <vsnprintf+0x2d>
  800d16:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d1a:	7f 07                	jg     800d23 <vsnprintf+0x34>
		return -E_INVAL;
  800d1c:	b8 03 00 00 00       	mov    $0x3,%eax
  800d21:	eb 20                	jmp    800d43 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d23:	ff 75 14             	pushl  0x14(%ebp)
  800d26:	ff 75 10             	pushl  0x10(%ebp)
  800d29:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d2c:	50                   	push   %eax
  800d2d:	68 b9 0c 80 00       	push   $0x800cb9
  800d32:	e8 92 fb ff ff       	call   8008c9 <vprintfmt>
  800d37:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d3d:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d40:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d43:	c9                   	leave  
  800d44:	c3                   	ret    

00800d45 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d45:	55                   	push   %ebp
  800d46:	89 e5                	mov    %esp,%ebp
  800d48:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d4b:	8d 45 10             	lea    0x10(%ebp),%eax
  800d4e:	83 c0 04             	add    $0x4,%eax
  800d51:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d54:	8b 45 10             	mov    0x10(%ebp),%eax
  800d57:	ff 75 f4             	pushl  -0xc(%ebp)
  800d5a:	50                   	push   %eax
  800d5b:	ff 75 0c             	pushl  0xc(%ebp)
  800d5e:	ff 75 08             	pushl  0x8(%ebp)
  800d61:	e8 89 ff ff ff       	call   800cef <vsnprintf>
  800d66:	83 c4 10             	add    $0x10,%esp
  800d69:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d6f:	c9                   	leave  
  800d70:	c3                   	ret    

00800d71 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d71:	55                   	push   %ebp
  800d72:	89 e5                	mov    %esp,%ebp
  800d74:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d7e:	eb 06                	jmp    800d86 <strlen+0x15>
		n++;
  800d80:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d83:	ff 45 08             	incl   0x8(%ebp)
  800d86:	8b 45 08             	mov    0x8(%ebp),%eax
  800d89:	8a 00                	mov    (%eax),%al
  800d8b:	84 c0                	test   %al,%al
  800d8d:	75 f1                	jne    800d80 <strlen+0xf>
		n++;
	return n;
  800d8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d92:	c9                   	leave  
  800d93:	c3                   	ret    

00800d94 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d94:	55                   	push   %ebp
  800d95:	89 e5                	mov    %esp,%ebp
  800d97:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d9a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800da1:	eb 09                	jmp    800dac <strnlen+0x18>
		n++;
  800da3:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800da6:	ff 45 08             	incl   0x8(%ebp)
  800da9:	ff 4d 0c             	decl   0xc(%ebp)
  800dac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800db0:	74 09                	je     800dbb <strnlen+0x27>
  800db2:	8b 45 08             	mov    0x8(%ebp),%eax
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	84 c0                	test   %al,%al
  800db9:	75 e8                	jne    800da3 <strnlen+0xf>
		n++;
	return n;
  800dbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dbe:	c9                   	leave  
  800dbf:	c3                   	ret    

00800dc0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800dc0:	55                   	push   %ebp
  800dc1:	89 e5                	mov    %esp,%ebp
  800dc3:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800dcc:	90                   	nop
  800dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd0:	8d 50 01             	lea    0x1(%eax),%edx
  800dd3:	89 55 08             	mov    %edx,0x8(%ebp)
  800dd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dd9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ddc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ddf:	8a 12                	mov    (%edx),%dl
  800de1:	88 10                	mov    %dl,(%eax)
  800de3:	8a 00                	mov    (%eax),%al
  800de5:	84 c0                	test   %al,%al
  800de7:	75 e4                	jne    800dcd <strcpy+0xd>
		/* do nothing */;
	return ret;
  800de9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dec:	c9                   	leave  
  800ded:	c3                   	ret    

00800dee <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800dee:	55                   	push   %ebp
  800def:	89 e5                	mov    %esp,%ebp
  800df1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800df4:	8b 45 08             	mov    0x8(%ebp),%eax
  800df7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800dfa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e01:	eb 1f                	jmp    800e22 <strncpy+0x34>
		*dst++ = *src;
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	8d 50 01             	lea    0x1(%eax),%edx
  800e09:	89 55 08             	mov    %edx,0x8(%ebp)
  800e0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e0f:	8a 12                	mov    (%edx),%dl
  800e11:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e16:	8a 00                	mov    (%eax),%al
  800e18:	84 c0                	test   %al,%al
  800e1a:	74 03                	je     800e1f <strncpy+0x31>
			src++;
  800e1c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e1f:	ff 45 fc             	incl   -0x4(%ebp)
  800e22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e25:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e28:	72 d9                	jb     800e03 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e2d:	c9                   	leave  
  800e2e:	c3                   	ret    

00800e2f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e2f:	55                   	push   %ebp
  800e30:	89 e5                	mov    %esp,%ebp
  800e32:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e3b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e3f:	74 30                	je     800e71 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e41:	eb 16                	jmp    800e59 <strlcpy+0x2a>
			*dst++ = *src++;
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	8d 50 01             	lea    0x1(%eax),%edx
  800e49:	89 55 08             	mov    %edx,0x8(%ebp)
  800e4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e4f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e52:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e55:	8a 12                	mov    (%edx),%dl
  800e57:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e59:	ff 4d 10             	decl   0x10(%ebp)
  800e5c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e60:	74 09                	je     800e6b <strlcpy+0x3c>
  800e62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e65:	8a 00                	mov    (%eax),%al
  800e67:	84 c0                	test   %al,%al
  800e69:	75 d8                	jne    800e43 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e71:	8b 55 08             	mov    0x8(%ebp),%edx
  800e74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e77:	29 c2                	sub    %eax,%edx
  800e79:	89 d0                	mov    %edx,%eax
}
  800e7b:	c9                   	leave  
  800e7c:	c3                   	ret    

00800e7d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e7d:	55                   	push   %ebp
  800e7e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e80:	eb 06                	jmp    800e88 <strcmp+0xb>
		p++, q++;
  800e82:	ff 45 08             	incl   0x8(%ebp)
  800e85:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	8a 00                	mov    (%eax),%al
  800e8d:	84 c0                	test   %al,%al
  800e8f:	74 0e                	je     800e9f <strcmp+0x22>
  800e91:	8b 45 08             	mov    0x8(%ebp),%eax
  800e94:	8a 10                	mov    (%eax),%dl
  800e96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e99:	8a 00                	mov    (%eax),%al
  800e9b:	38 c2                	cmp    %al,%dl
  800e9d:	74 e3                	je     800e82 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea2:	8a 00                	mov    (%eax),%al
  800ea4:	0f b6 d0             	movzbl %al,%edx
  800ea7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eaa:	8a 00                	mov    (%eax),%al
  800eac:	0f b6 c0             	movzbl %al,%eax
  800eaf:	29 c2                	sub    %eax,%edx
  800eb1:	89 d0                	mov    %edx,%eax
}
  800eb3:	5d                   	pop    %ebp
  800eb4:	c3                   	ret    

00800eb5 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800eb5:	55                   	push   %ebp
  800eb6:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800eb8:	eb 09                	jmp    800ec3 <strncmp+0xe>
		n--, p++, q++;
  800eba:	ff 4d 10             	decl   0x10(%ebp)
  800ebd:	ff 45 08             	incl   0x8(%ebp)
  800ec0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ec3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ec7:	74 17                	je     800ee0 <strncmp+0x2b>
  800ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecc:	8a 00                	mov    (%eax),%al
  800ece:	84 c0                	test   %al,%al
  800ed0:	74 0e                	je     800ee0 <strncmp+0x2b>
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	8a 10                	mov    (%eax),%dl
  800ed7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	38 c2                	cmp    %al,%dl
  800ede:	74 da                	je     800eba <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ee0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ee4:	75 07                	jne    800eed <strncmp+0x38>
		return 0;
  800ee6:	b8 00 00 00 00       	mov    $0x0,%eax
  800eeb:	eb 14                	jmp    800f01 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef0:	8a 00                	mov    (%eax),%al
  800ef2:	0f b6 d0             	movzbl %al,%edx
  800ef5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef8:	8a 00                	mov    (%eax),%al
  800efa:	0f b6 c0             	movzbl %al,%eax
  800efd:	29 c2                	sub    %eax,%edx
  800eff:	89 d0                	mov    %edx,%eax
}
  800f01:	5d                   	pop    %ebp
  800f02:	c3                   	ret    

00800f03 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f03:	55                   	push   %ebp
  800f04:	89 e5                	mov    %esp,%ebp
  800f06:	83 ec 04             	sub    $0x4,%esp
  800f09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f0f:	eb 12                	jmp    800f23 <strchr+0x20>
		if (*s == c)
  800f11:	8b 45 08             	mov    0x8(%ebp),%eax
  800f14:	8a 00                	mov    (%eax),%al
  800f16:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f19:	75 05                	jne    800f20 <strchr+0x1d>
			return (char *) s;
  800f1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1e:	eb 11                	jmp    800f31 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f20:	ff 45 08             	incl   0x8(%ebp)
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	8a 00                	mov    (%eax),%al
  800f28:	84 c0                	test   %al,%al
  800f2a:	75 e5                	jne    800f11 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f2c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f31:	c9                   	leave  
  800f32:	c3                   	ret    

00800f33 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f33:	55                   	push   %ebp
  800f34:	89 e5                	mov    %esp,%ebp
  800f36:	83 ec 04             	sub    $0x4,%esp
  800f39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f3f:	eb 0d                	jmp    800f4e <strfind+0x1b>
		if (*s == c)
  800f41:	8b 45 08             	mov    0x8(%ebp),%eax
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f49:	74 0e                	je     800f59 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f4b:	ff 45 08             	incl   0x8(%ebp)
  800f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f51:	8a 00                	mov    (%eax),%al
  800f53:	84 c0                	test   %al,%al
  800f55:	75 ea                	jne    800f41 <strfind+0xe>
  800f57:	eb 01                	jmp    800f5a <strfind+0x27>
		if (*s == c)
			break;
  800f59:	90                   	nop
	return (char *) s;
  800f5a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f5d:	c9                   	leave  
  800f5e:	c3                   	ret    

00800f5f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f5f:	55                   	push   %ebp
  800f60:	89 e5                	mov    %esp,%ebp
  800f62:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f71:	eb 0e                	jmp    800f81 <memset+0x22>
		*p++ = c;
  800f73:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f76:	8d 50 01             	lea    0x1(%eax),%edx
  800f79:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f7f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f81:	ff 4d f8             	decl   -0x8(%ebp)
  800f84:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f88:	79 e9                	jns    800f73 <memset+0x14>
		*p++ = c;

	return v;
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f8d:	c9                   	leave  
  800f8e:	c3                   	ret    

00800f8f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f8f:	55                   	push   %ebp
  800f90:	89 e5                	mov    %esp,%ebp
  800f92:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f98:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800fa1:	eb 16                	jmp    800fb9 <memcpy+0x2a>
		*d++ = *s++;
  800fa3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fa6:	8d 50 01             	lea    0x1(%eax),%edx
  800fa9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fac:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800faf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fb2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fb5:	8a 12                	mov    (%edx),%dl
  800fb7:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800fb9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fbf:	89 55 10             	mov    %edx,0x10(%ebp)
  800fc2:	85 c0                	test   %eax,%eax
  800fc4:	75 dd                	jne    800fa3 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fc9:	c9                   	leave  
  800fca:	c3                   	ret    

00800fcb <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fcb:	55                   	push   %ebp
  800fcc:	89 e5                	mov    %esp,%ebp
  800fce:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800fd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800fdd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fe3:	73 50                	jae    801035 <memmove+0x6a>
  800fe5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fe8:	8b 45 10             	mov    0x10(%ebp),%eax
  800feb:	01 d0                	add    %edx,%eax
  800fed:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ff0:	76 43                	jbe    801035 <memmove+0x6a>
		s += n;
  800ff2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ff8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffb:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ffe:	eb 10                	jmp    801010 <memmove+0x45>
			*--d = *--s;
  801000:	ff 4d f8             	decl   -0x8(%ebp)
  801003:	ff 4d fc             	decl   -0x4(%ebp)
  801006:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801009:	8a 10                	mov    (%eax),%dl
  80100b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80100e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801010:	8b 45 10             	mov    0x10(%ebp),%eax
  801013:	8d 50 ff             	lea    -0x1(%eax),%edx
  801016:	89 55 10             	mov    %edx,0x10(%ebp)
  801019:	85 c0                	test   %eax,%eax
  80101b:	75 e3                	jne    801000 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80101d:	eb 23                	jmp    801042 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80101f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801022:	8d 50 01             	lea    0x1(%eax),%edx
  801025:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801028:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80102b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80102e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801031:	8a 12                	mov    (%edx),%dl
  801033:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801035:	8b 45 10             	mov    0x10(%ebp),%eax
  801038:	8d 50 ff             	lea    -0x1(%eax),%edx
  80103b:	89 55 10             	mov    %edx,0x10(%ebp)
  80103e:	85 c0                	test   %eax,%eax
  801040:	75 dd                	jne    80101f <memmove+0x54>
			*d++ = *s++;

	return dst;
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801045:	c9                   	leave  
  801046:	c3                   	ret    

00801047 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801047:	55                   	push   %ebp
  801048:	89 e5                	mov    %esp,%ebp
  80104a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80104d:	8b 45 08             	mov    0x8(%ebp),%eax
  801050:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801053:	8b 45 0c             	mov    0xc(%ebp),%eax
  801056:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801059:	eb 2a                	jmp    801085 <memcmp+0x3e>
		if (*s1 != *s2)
  80105b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80105e:	8a 10                	mov    (%eax),%dl
  801060:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801063:	8a 00                	mov    (%eax),%al
  801065:	38 c2                	cmp    %al,%dl
  801067:	74 16                	je     80107f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801069:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80106c:	8a 00                	mov    (%eax),%al
  80106e:	0f b6 d0             	movzbl %al,%edx
  801071:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801074:	8a 00                	mov    (%eax),%al
  801076:	0f b6 c0             	movzbl %al,%eax
  801079:	29 c2                	sub    %eax,%edx
  80107b:	89 d0                	mov    %edx,%eax
  80107d:	eb 18                	jmp    801097 <memcmp+0x50>
		s1++, s2++;
  80107f:	ff 45 fc             	incl   -0x4(%ebp)
  801082:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801085:	8b 45 10             	mov    0x10(%ebp),%eax
  801088:	8d 50 ff             	lea    -0x1(%eax),%edx
  80108b:	89 55 10             	mov    %edx,0x10(%ebp)
  80108e:	85 c0                	test   %eax,%eax
  801090:	75 c9                	jne    80105b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801092:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801097:	c9                   	leave  
  801098:	c3                   	ret    

00801099 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801099:	55                   	push   %ebp
  80109a:	89 e5                	mov    %esp,%ebp
  80109c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80109f:	8b 55 08             	mov    0x8(%ebp),%edx
  8010a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a5:	01 d0                	add    %edx,%eax
  8010a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010aa:	eb 15                	jmp    8010c1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8010af:	8a 00                	mov    (%eax),%al
  8010b1:	0f b6 d0             	movzbl %al,%edx
  8010b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b7:	0f b6 c0             	movzbl %al,%eax
  8010ba:	39 c2                	cmp    %eax,%edx
  8010bc:	74 0d                	je     8010cb <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010be:	ff 45 08             	incl   0x8(%ebp)
  8010c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010c7:	72 e3                	jb     8010ac <memfind+0x13>
  8010c9:	eb 01                	jmp    8010cc <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010cb:	90                   	nop
	return (void *) s;
  8010cc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010cf:	c9                   	leave  
  8010d0:	c3                   	ret    

008010d1 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010d1:	55                   	push   %ebp
  8010d2:	89 e5                	mov    %esp,%ebp
  8010d4:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010de:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010e5:	eb 03                	jmp    8010ea <strtol+0x19>
		s++;
  8010e7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ed:	8a 00                	mov    (%eax),%al
  8010ef:	3c 20                	cmp    $0x20,%al
  8010f1:	74 f4                	je     8010e7 <strtol+0x16>
  8010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f6:	8a 00                	mov    (%eax),%al
  8010f8:	3c 09                	cmp    $0x9,%al
  8010fa:	74 eb                	je     8010e7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ff:	8a 00                	mov    (%eax),%al
  801101:	3c 2b                	cmp    $0x2b,%al
  801103:	75 05                	jne    80110a <strtol+0x39>
		s++;
  801105:	ff 45 08             	incl   0x8(%ebp)
  801108:	eb 13                	jmp    80111d <strtol+0x4c>
	else if (*s == '-')
  80110a:	8b 45 08             	mov    0x8(%ebp),%eax
  80110d:	8a 00                	mov    (%eax),%al
  80110f:	3c 2d                	cmp    $0x2d,%al
  801111:	75 0a                	jne    80111d <strtol+0x4c>
		s++, neg = 1;
  801113:	ff 45 08             	incl   0x8(%ebp)
  801116:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80111d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801121:	74 06                	je     801129 <strtol+0x58>
  801123:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801127:	75 20                	jne    801149 <strtol+0x78>
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	8a 00                	mov    (%eax),%al
  80112e:	3c 30                	cmp    $0x30,%al
  801130:	75 17                	jne    801149 <strtol+0x78>
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	40                   	inc    %eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	3c 78                	cmp    $0x78,%al
  80113a:	75 0d                	jne    801149 <strtol+0x78>
		s += 2, base = 16;
  80113c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801140:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801147:	eb 28                	jmp    801171 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801149:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80114d:	75 15                	jne    801164 <strtol+0x93>
  80114f:	8b 45 08             	mov    0x8(%ebp),%eax
  801152:	8a 00                	mov    (%eax),%al
  801154:	3c 30                	cmp    $0x30,%al
  801156:	75 0c                	jne    801164 <strtol+0x93>
		s++, base = 8;
  801158:	ff 45 08             	incl   0x8(%ebp)
  80115b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801162:	eb 0d                	jmp    801171 <strtol+0xa0>
	else if (base == 0)
  801164:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801168:	75 07                	jne    801171 <strtol+0xa0>
		base = 10;
  80116a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	8a 00                	mov    (%eax),%al
  801176:	3c 2f                	cmp    $0x2f,%al
  801178:	7e 19                	jle    801193 <strtol+0xc2>
  80117a:	8b 45 08             	mov    0x8(%ebp),%eax
  80117d:	8a 00                	mov    (%eax),%al
  80117f:	3c 39                	cmp    $0x39,%al
  801181:	7f 10                	jg     801193 <strtol+0xc2>
			dig = *s - '0';
  801183:	8b 45 08             	mov    0x8(%ebp),%eax
  801186:	8a 00                	mov    (%eax),%al
  801188:	0f be c0             	movsbl %al,%eax
  80118b:	83 e8 30             	sub    $0x30,%eax
  80118e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801191:	eb 42                	jmp    8011d5 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801193:	8b 45 08             	mov    0x8(%ebp),%eax
  801196:	8a 00                	mov    (%eax),%al
  801198:	3c 60                	cmp    $0x60,%al
  80119a:	7e 19                	jle    8011b5 <strtol+0xe4>
  80119c:	8b 45 08             	mov    0x8(%ebp),%eax
  80119f:	8a 00                	mov    (%eax),%al
  8011a1:	3c 7a                	cmp    $0x7a,%al
  8011a3:	7f 10                	jg     8011b5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a8:	8a 00                	mov    (%eax),%al
  8011aa:	0f be c0             	movsbl %al,%eax
  8011ad:	83 e8 57             	sub    $0x57,%eax
  8011b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011b3:	eb 20                	jmp    8011d5 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b8:	8a 00                	mov    (%eax),%al
  8011ba:	3c 40                	cmp    $0x40,%al
  8011bc:	7e 39                	jle    8011f7 <strtol+0x126>
  8011be:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c1:	8a 00                	mov    (%eax),%al
  8011c3:	3c 5a                	cmp    $0x5a,%al
  8011c5:	7f 30                	jg     8011f7 <strtol+0x126>
			dig = *s - 'A' + 10;
  8011c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ca:	8a 00                	mov    (%eax),%al
  8011cc:	0f be c0             	movsbl %al,%eax
  8011cf:	83 e8 37             	sub    $0x37,%eax
  8011d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011d8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011db:	7d 19                	jge    8011f6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011dd:	ff 45 08             	incl   0x8(%ebp)
  8011e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011e3:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011e7:	89 c2                	mov    %eax,%edx
  8011e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011ec:	01 d0                	add    %edx,%eax
  8011ee:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011f1:	e9 7b ff ff ff       	jmp    801171 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011f6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011f7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011fb:	74 08                	je     801205 <strtol+0x134>
		*endptr = (char *) s;
  8011fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801200:	8b 55 08             	mov    0x8(%ebp),%edx
  801203:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801205:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801209:	74 07                	je     801212 <strtol+0x141>
  80120b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80120e:	f7 d8                	neg    %eax
  801210:	eb 03                	jmp    801215 <strtol+0x144>
  801212:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801215:	c9                   	leave  
  801216:	c3                   	ret    

00801217 <ltostr>:

void
ltostr(long value, char *str)
{
  801217:	55                   	push   %ebp
  801218:	89 e5                	mov    %esp,%ebp
  80121a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80121d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801224:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80122b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80122f:	79 13                	jns    801244 <ltostr+0x2d>
	{
		neg = 1;
  801231:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801238:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80123e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801241:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801244:	8b 45 08             	mov    0x8(%ebp),%eax
  801247:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80124c:	99                   	cltd   
  80124d:	f7 f9                	idiv   %ecx
  80124f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801252:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801255:	8d 50 01             	lea    0x1(%eax),%edx
  801258:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80125b:	89 c2                	mov    %eax,%edx
  80125d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801260:	01 d0                	add    %edx,%eax
  801262:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801265:	83 c2 30             	add    $0x30,%edx
  801268:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80126a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80126d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801272:	f7 e9                	imul   %ecx
  801274:	c1 fa 02             	sar    $0x2,%edx
  801277:	89 c8                	mov    %ecx,%eax
  801279:	c1 f8 1f             	sar    $0x1f,%eax
  80127c:	29 c2                	sub    %eax,%edx
  80127e:	89 d0                	mov    %edx,%eax
  801280:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801283:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801286:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80128b:	f7 e9                	imul   %ecx
  80128d:	c1 fa 02             	sar    $0x2,%edx
  801290:	89 c8                	mov    %ecx,%eax
  801292:	c1 f8 1f             	sar    $0x1f,%eax
  801295:	29 c2                	sub    %eax,%edx
  801297:	89 d0                	mov    %edx,%eax
  801299:	c1 e0 02             	shl    $0x2,%eax
  80129c:	01 d0                	add    %edx,%eax
  80129e:	01 c0                	add    %eax,%eax
  8012a0:	29 c1                	sub    %eax,%ecx
  8012a2:	89 ca                	mov    %ecx,%edx
  8012a4:	85 d2                	test   %edx,%edx
  8012a6:	75 9c                	jne    801244 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012af:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012b2:	48                   	dec    %eax
  8012b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012b6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012ba:	74 3d                	je     8012f9 <ltostr+0xe2>
		start = 1 ;
  8012bc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012c3:	eb 34                	jmp    8012f9 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8012c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cb:	01 d0                	add    %edx,%eax
  8012cd:	8a 00                	mov    (%eax),%al
  8012cf:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d8:	01 c2                	add    %eax,%edx
  8012da:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e0:	01 c8                	add    %ecx,%eax
  8012e2:	8a 00                	mov    (%eax),%al
  8012e4:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012e6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ec:	01 c2                	add    %eax,%edx
  8012ee:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012f1:	88 02                	mov    %al,(%edx)
		start++ ;
  8012f3:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012f6:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012fc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012ff:	7c c4                	jl     8012c5 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801301:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801304:	8b 45 0c             	mov    0xc(%ebp),%eax
  801307:	01 d0                	add    %edx,%eax
  801309:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80130c:	90                   	nop
  80130d:	c9                   	leave  
  80130e:	c3                   	ret    

0080130f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80130f:	55                   	push   %ebp
  801310:	89 e5                	mov    %esp,%ebp
  801312:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801315:	ff 75 08             	pushl  0x8(%ebp)
  801318:	e8 54 fa ff ff       	call   800d71 <strlen>
  80131d:	83 c4 04             	add    $0x4,%esp
  801320:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801323:	ff 75 0c             	pushl  0xc(%ebp)
  801326:	e8 46 fa ff ff       	call   800d71 <strlen>
  80132b:	83 c4 04             	add    $0x4,%esp
  80132e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801331:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801338:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80133f:	eb 17                	jmp    801358 <strcconcat+0x49>
		final[s] = str1[s] ;
  801341:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801344:	8b 45 10             	mov    0x10(%ebp),%eax
  801347:	01 c2                	add    %eax,%edx
  801349:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80134c:	8b 45 08             	mov    0x8(%ebp),%eax
  80134f:	01 c8                	add    %ecx,%eax
  801351:	8a 00                	mov    (%eax),%al
  801353:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801355:	ff 45 fc             	incl   -0x4(%ebp)
  801358:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80135b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80135e:	7c e1                	jl     801341 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801360:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801367:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80136e:	eb 1f                	jmp    80138f <strcconcat+0x80>
		final[s++] = str2[i] ;
  801370:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801373:	8d 50 01             	lea    0x1(%eax),%edx
  801376:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801379:	89 c2                	mov    %eax,%edx
  80137b:	8b 45 10             	mov    0x10(%ebp),%eax
  80137e:	01 c2                	add    %eax,%edx
  801380:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801383:	8b 45 0c             	mov    0xc(%ebp),%eax
  801386:	01 c8                	add    %ecx,%eax
  801388:	8a 00                	mov    (%eax),%al
  80138a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80138c:	ff 45 f8             	incl   -0x8(%ebp)
  80138f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801392:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801395:	7c d9                	jl     801370 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801397:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80139a:	8b 45 10             	mov    0x10(%ebp),%eax
  80139d:	01 d0                	add    %edx,%eax
  80139f:	c6 00 00             	movb   $0x0,(%eax)
}
  8013a2:	90                   	nop
  8013a3:	c9                   	leave  
  8013a4:	c3                   	ret    

008013a5 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013a5:	55                   	push   %ebp
  8013a6:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8013ab:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8013b4:	8b 00                	mov    (%eax),%eax
  8013b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c0:	01 d0                	add    %edx,%eax
  8013c2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013c8:	eb 0c                	jmp    8013d6 <strsplit+0x31>
			*string++ = 0;
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	8d 50 01             	lea    0x1(%eax),%edx
  8013d0:	89 55 08             	mov    %edx,0x8(%ebp)
  8013d3:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d9:	8a 00                	mov    (%eax),%al
  8013db:	84 c0                	test   %al,%al
  8013dd:	74 18                	je     8013f7 <strsplit+0x52>
  8013df:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e2:	8a 00                	mov    (%eax),%al
  8013e4:	0f be c0             	movsbl %al,%eax
  8013e7:	50                   	push   %eax
  8013e8:	ff 75 0c             	pushl  0xc(%ebp)
  8013eb:	e8 13 fb ff ff       	call   800f03 <strchr>
  8013f0:	83 c4 08             	add    $0x8,%esp
  8013f3:	85 c0                	test   %eax,%eax
  8013f5:	75 d3                	jne    8013ca <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8013f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fa:	8a 00                	mov    (%eax),%al
  8013fc:	84 c0                	test   %al,%al
  8013fe:	74 5a                	je     80145a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801400:	8b 45 14             	mov    0x14(%ebp),%eax
  801403:	8b 00                	mov    (%eax),%eax
  801405:	83 f8 0f             	cmp    $0xf,%eax
  801408:	75 07                	jne    801411 <strsplit+0x6c>
		{
			return 0;
  80140a:	b8 00 00 00 00       	mov    $0x0,%eax
  80140f:	eb 66                	jmp    801477 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801411:	8b 45 14             	mov    0x14(%ebp),%eax
  801414:	8b 00                	mov    (%eax),%eax
  801416:	8d 48 01             	lea    0x1(%eax),%ecx
  801419:	8b 55 14             	mov    0x14(%ebp),%edx
  80141c:	89 0a                	mov    %ecx,(%edx)
  80141e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801425:	8b 45 10             	mov    0x10(%ebp),%eax
  801428:	01 c2                	add    %eax,%edx
  80142a:	8b 45 08             	mov    0x8(%ebp),%eax
  80142d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80142f:	eb 03                	jmp    801434 <strsplit+0x8f>
			string++;
  801431:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801434:	8b 45 08             	mov    0x8(%ebp),%eax
  801437:	8a 00                	mov    (%eax),%al
  801439:	84 c0                	test   %al,%al
  80143b:	74 8b                	je     8013c8 <strsplit+0x23>
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	8a 00                	mov    (%eax),%al
  801442:	0f be c0             	movsbl %al,%eax
  801445:	50                   	push   %eax
  801446:	ff 75 0c             	pushl  0xc(%ebp)
  801449:	e8 b5 fa ff ff       	call   800f03 <strchr>
  80144e:	83 c4 08             	add    $0x8,%esp
  801451:	85 c0                	test   %eax,%eax
  801453:	74 dc                	je     801431 <strsplit+0x8c>
			string++;
	}
  801455:	e9 6e ff ff ff       	jmp    8013c8 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80145a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80145b:	8b 45 14             	mov    0x14(%ebp),%eax
  80145e:	8b 00                	mov    (%eax),%eax
  801460:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801467:	8b 45 10             	mov    0x10(%ebp),%eax
  80146a:	01 d0                	add    %edx,%eax
  80146c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801472:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801477:	c9                   	leave  
  801478:	c3                   	ret    

00801479 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801479:	55                   	push   %ebp
  80147a:	89 e5                	mov    %esp,%ebp
  80147c:	83 ec 18             	sub    $0x18,%esp
  80147f:	8b 45 10             	mov    0x10(%ebp),%eax
  801482:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801485:	83 ec 04             	sub    $0x4,%esp
  801488:	68 10 27 80 00       	push   $0x802710
  80148d:	6a 17                	push   $0x17
  80148f:	68 2f 27 80 00       	push   $0x80272f
  801494:	e8 a2 ef ff ff       	call   80043b <_panic>

00801499 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801499:	55                   	push   %ebp
  80149a:	89 e5                	mov    %esp,%ebp
  80149c:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  80149f:	83 ec 04             	sub    $0x4,%esp
  8014a2:	68 3b 27 80 00       	push   $0x80273b
  8014a7:	6a 2f                	push   $0x2f
  8014a9:	68 2f 27 80 00       	push   $0x80272f
  8014ae:	e8 88 ef ff ff       	call   80043b <_panic>

008014b3 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8014b3:	55                   	push   %ebp
  8014b4:	89 e5                	mov    %esp,%ebp
  8014b6:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8014b9:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8014c0:	8b 55 08             	mov    0x8(%ebp),%edx
  8014c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014c6:	01 d0                	add    %edx,%eax
  8014c8:	48                   	dec    %eax
  8014c9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8014cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014cf:	ba 00 00 00 00       	mov    $0x0,%edx
  8014d4:	f7 75 ec             	divl   -0x14(%ebp)
  8014d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014da:	29 d0                	sub    %edx,%eax
  8014dc:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8014df:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e2:	c1 e8 0c             	shr    $0xc,%eax
  8014e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8014e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8014ef:	e9 c8 00 00 00       	jmp    8015bc <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8014f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8014fb:	eb 27                	jmp    801524 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8014fd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801500:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801503:	01 c2                	add    %eax,%edx
  801505:	89 d0                	mov    %edx,%eax
  801507:	01 c0                	add    %eax,%eax
  801509:	01 d0                	add    %edx,%eax
  80150b:	c1 e0 02             	shl    $0x2,%eax
  80150e:	05 48 30 80 00       	add    $0x803048,%eax
  801513:	8b 00                	mov    (%eax),%eax
  801515:	85 c0                	test   %eax,%eax
  801517:	74 08                	je     801521 <malloc+0x6e>
            	i += j;
  801519:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80151c:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  80151f:	eb 0b                	jmp    80152c <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801521:	ff 45 f0             	incl   -0x10(%ebp)
  801524:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801527:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80152a:	72 d1                	jb     8014fd <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  80152c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80152f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801532:	0f 85 81 00 00 00    	jne    8015b9 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801538:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80153b:	05 00 00 08 00       	add    $0x80000,%eax
  801540:	c1 e0 0c             	shl    $0xc,%eax
  801543:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801546:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80154d:	eb 1f                	jmp    80156e <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  80154f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801552:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801555:	01 c2                	add    %eax,%edx
  801557:	89 d0                	mov    %edx,%eax
  801559:	01 c0                	add    %eax,%eax
  80155b:	01 d0                	add    %edx,%eax
  80155d:	c1 e0 02             	shl    $0x2,%eax
  801560:	05 48 30 80 00       	add    $0x803048,%eax
  801565:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80156b:	ff 45 f0             	incl   -0x10(%ebp)
  80156e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801571:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801574:	72 d9                	jb     80154f <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801576:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801579:	89 d0                	mov    %edx,%eax
  80157b:	01 c0                	add    %eax,%eax
  80157d:	01 d0                	add    %edx,%eax
  80157f:	c1 e0 02             	shl    $0x2,%eax
  801582:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801588:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80158b:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  80158d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801590:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801593:	89 c8                	mov    %ecx,%eax
  801595:	01 c0                	add    %eax,%eax
  801597:	01 c8                	add    %ecx,%eax
  801599:	c1 e0 02             	shl    $0x2,%eax
  80159c:	05 44 30 80 00       	add    $0x803044,%eax
  8015a1:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8015a3:	83 ec 08             	sub    $0x8,%esp
  8015a6:	ff 75 08             	pushl  0x8(%ebp)
  8015a9:	ff 75 e0             	pushl  -0x20(%ebp)
  8015ac:	e8 2b 03 00 00       	call   8018dc <sys_allocateMem>
  8015b1:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8015b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015b7:	eb 19                	jmp    8015d2 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8015b9:	ff 45 f4             	incl   -0xc(%ebp)
  8015bc:	a1 04 30 80 00       	mov    0x803004,%eax
  8015c1:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8015c4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015c7:	0f 83 27 ff ff ff    	jae    8014f4 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8015cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d2:	c9                   	leave  
  8015d3:	c3                   	ret    

008015d4 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8015d4:	55                   	push   %ebp
  8015d5:	89 e5                	mov    %esp,%ebp
  8015d7:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8015da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015de:	0f 84 e5 00 00 00    	je     8016c9 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8015e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8015ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015ed:	05 00 00 00 80       	add    $0x80000000,%eax
  8015f2:	c1 e8 0c             	shr    $0xc,%eax
  8015f5:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8015f8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8015fb:	89 d0                	mov    %edx,%eax
  8015fd:	01 c0                	add    %eax,%eax
  8015ff:	01 d0                	add    %edx,%eax
  801601:	c1 e0 02             	shl    $0x2,%eax
  801604:	05 40 30 80 00       	add    $0x803040,%eax
  801609:	8b 00                	mov    (%eax),%eax
  80160b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80160e:	0f 85 b8 00 00 00    	jne    8016cc <free+0xf8>
  801614:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801617:	89 d0                	mov    %edx,%eax
  801619:	01 c0                	add    %eax,%eax
  80161b:	01 d0                	add    %edx,%eax
  80161d:	c1 e0 02             	shl    $0x2,%eax
  801620:	05 48 30 80 00       	add    $0x803048,%eax
  801625:	8b 00                	mov    (%eax),%eax
  801627:	85 c0                	test   %eax,%eax
  801629:	0f 84 9d 00 00 00    	je     8016cc <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  80162f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801632:	89 d0                	mov    %edx,%eax
  801634:	01 c0                	add    %eax,%eax
  801636:	01 d0                	add    %edx,%eax
  801638:	c1 e0 02             	shl    $0x2,%eax
  80163b:	05 44 30 80 00       	add    $0x803044,%eax
  801640:	8b 00                	mov    (%eax),%eax
  801642:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801645:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801648:	c1 e0 0c             	shl    $0xc,%eax
  80164b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  80164e:	83 ec 08             	sub    $0x8,%esp
  801651:	ff 75 e4             	pushl  -0x1c(%ebp)
  801654:	ff 75 f0             	pushl  -0x10(%ebp)
  801657:	e8 64 02 00 00       	call   8018c0 <sys_freeMem>
  80165c:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80165f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801666:	eb 57                	jmp    8016bf <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801668:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80166b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80166e:	01 c2                	add    %eax,%edx
  801670:	89 d0                	mov    %edx,%eax
  801672:	01 c0                	add    %eax,%eax
  801674:	01 d0                	add    %edx,%eax
  801676:	c1 e0 02             	shl    $0x2,%eax
  801679:	05 48 30 80 00       	add    $0x803048,%eax
  80167e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801684:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801687:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80168a:	01 c2                	add    %eax,%edx
  80168c:	89 d0                	mov    %edx,%eax
  80168e:	01 c0                	add    %eax,%eax
  801690:	01 d0                	add    %edx,%eax
  801692:	c1 e0 02             	shl    $0x2,%eax
  801695:	05 40 30 80 00       	add    $0x803040,%eax
  80169a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8016a0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016a6:	01 c2                	add    %eax,%edx
  8016a8:	89 d0                	mov    %edx,%eax
  8016aa:	01 c0                	add    %eax,%eax
  8016ac:	01 d0                	add    %edx,%eax
  8016ae:	c1 e0 02             	shl    $0x2,%eax
  8016b1:	05 44 30 80 00       	add    $0x803044,%eax
  8016b6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8016bc:	ff 45 f4             	incl   -0xc(%ebp)
  8016bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016c2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8016c5:	7c a1                	jl     801668 <free+0x94>
  8016c7:	eb 04                	jmp    8016cd <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8016c9:	90                   	nop
  8016ca:	eb 01                	jmp    8016cd <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8016cc:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8016cd:	c9                   	leave  
  8016ce:	c3                   	ret    

008016cf <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8016cf:	55                   	push   %ebp
  8016d0:	89 e5                	mov    %esp,%ebp
  8016d2:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8016d5:	83 ec 04             	sub    $0x4,%esp
  8016d8:	68 58 27 80 00       	push   $0x802758
  8016dd:	68 ae 00 00 00       	push   $0xae
  8016e2:	68 2f 27 80 00       	push   $0x80272f
  8016e7:	e8 4f ed ff ff       	call   80043b <_panic>

008016ec <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8016ec:	55                   	push   %ebp
  8016ed:	89 e5                	mov    %esp,%ebp
  8016ef:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8016f2:	83 ec 04             	sub    $0x4,%esp
  8016f5:	68 78 27 80 00       	push   $0x802778
  8016fa:	68 ca 00 00 00       	push   $0xca
  8016ff:	68 2f 27 80 00       	push   $0x80272f
  801704:	e8 32 ed ff ff       	call   80043b <_panic>

00801709 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801709:	55                   	push   %ebp
  80170a:	89 e5                	mov    %esp,%ebp
  80170c:	57                   	push   %edi
  80170d:	56                   	push   %esi
  80170e:	53                   	push   %ebx
  80170f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801712:	8b 45 08             	mov    0x8(%ebp),%eax
  801715:	8b 55 0c             	mov    0xc(%ebp),%edx
  801718:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80171b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80171e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801721:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801724:	cd 30                	int    $0x30
  801726:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801729:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80172c:	83 c4 10             	add    $0x10,%esp
  80172f:	5b                   	pop    %ebx
  801730:	5e                   	pop    %esi
  801731:	5f                   	pop    %edi
  801732:	5d                   	pop    %ebp
  801733:	c3                   	ret    

00801734 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801734:	55                   	push   %ebp
  801735:	89 e5                	mov    %esp,%ebp
  801737:	83 ec 04             	sub    $0x4,%esp
  80173a:	8b 45 10             	mov    0x10(%ebp),%eax
  80173d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801740:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801744:	8b 45 08             	mov    0x8(%ebp),%eax
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	52                   	push   %edx
  80174c:	ff 75 0c             	pushl  0xc(%ebp)
  80174f:	50                   	push   %eax
  801750:	6a 00                	push   $0x0
  801752:	e8 b2 ff ff ff       	call   801709 <syscall>
  801757:	83 c4 18             	add    $0x18,%esp
}
  80175a:	90                   	nop
  80175b:	c9                   	leave  
  80175c:	c3                   	ret    

0080175d <sys_cgetc>:

int
sys_cgetc(void)
{
  80175d:	55                   	push   %ebp
  80175e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	6a 00                	push   $0x0
  80176a:	6a 01                	push   $0x1
  80176c:	e8 98 ff ff ff       	call   801709 <syscall>
  801771:	83 c4 18             	add    $0x18,%esp
}
  801774:	c9                   	leave  
  801775:	c3                   	ret    

00801776 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801776:	55                   	push   %ebp
  801777:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801779:	8b 45 08             	mov    0x8(%ebp),%eax
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	50                   	push   %eax
  801785:	6a 05                	push   $0x5
  801787:	e8 7d ff ff ff       	call   801709 <syscall>
  80178c:	83 c4 18             	add    $0x18,%esp
}
  80178f:	c9                   	leave  
  801790:	c3                   	ret    

00801791 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 02                	push   $0x2
  8017a0:	e8 64 ff ff ff       	call   801709 <syscall>
  8017a5:	83 c4 18             	add    $0x18,%esp
}
  8017a8:	c9                   	leave  
  8017a9:	c3                   	ret    

008017aa <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017aa:	55                   	push   %ebp
  8017ab:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 03                	push   $0x3
  8017b9:	e8 4b ff ff ff       	call   801709 <syscall>
  8017be:	83 c4 18             	add    $0x18,%esp
}
  8017c1:	c9                   	leave  
  8017c2:	c3                   	ret    

008017c3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017c3:	55                   	push   %ebp
  8017c4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 04                	push   $0x4
  8017d2:	e8 32 ff ff ff       	call   801709 <syscall>
  8017d7:	83 c4 18             	add    $0x18,%esp
}
  8017da:	c9                   	leave  
  8017db:	c3                   	ret    

008017dc <sys_env_exit>:


void sys_env_exit(void)
{
  8017dc:	55                   	push   %ebp
  8017dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 06                	push   $0x6
  8017eb:	e8 19 ff ff ff       	call   801709 <syscall>
  8017f0:	83 c4 18             	add    $0x18,%esp
}
  8017f3:	90                   	nop
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	52                   	push   %edx
  801806:	50                   	push   %eax
  801807:	6a 07                	push   $0x7
  801809:	e8 fb fe ff ff       	call   801709 <syscall>
  80180e:	83 c4 18             	add    $0x18,%esp
}
  801811:	c9                   	leave  
  801812:	c3                   	ret    

00801813 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801813:	55                   	push   %ebp
  801814:	89 e5                	mov    %esp,%ebp
  801816:	56                   	push   %esi
  801817:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801818:	8b 75 18             	mov    0x18(%ebp),%esi
  80181b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80181e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801821:	8b 55 0c             	mov    0xc(%ebp),%edx
  801824:	8b 45 08             	mov    0x8(%ebp),%eax
  801827:	56                   	push   %esi
  801828:	53                   	push   %ebx
  801829:	51                   	push   %ecx
  80182a:	52                   	push   %edx
  80182b:	50                   	push   %eax
  80182c:	6a 08                	push   $0x8
  80182e:	e8 d6 fe ff ff       	call   801709 <syscall>
  801833:	83 c4 18             	add    $0x18,%esp
}
  801836:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801839:	5b                   	pop    %ebx
  80183a:	5e                   	pop    %esi
  80183b:	5d                   	pop    %ebp
  80183c:	c3                   	ret    

0080183d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80183d:	55                   	push   %ebp
  80183e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801840:	8b 55 0c             	mov    0xc(%ebp),%edx
  801843:	8b 45 08             	mov    0x8(%ebp),%eax
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	52                   	push   %edx
  80184d:	50                   	push   %eax
  80184e:	6a 09                	push   $0x9
  801850:	e8 b4 fe ff ff       	call   801709 <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
}
  801858:	c9                   	leave  
  801859:	c3                   	ret    

0080185a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80185a:	55                   	push   %ebp
  80185b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	ff 75 0c             	pushl  0xc(%ebp)
  801866:	ff 75 08             	pushl  0x8(%ebp)
  801869:	6a 0a                	push   $0xa
  80186b:	e8 99 fe ff ff       	call   801709 <syscall>
  801870:	83 c4 18             	add    $0x18,%esp
}
  801873:	c9                   	leave  
  801874:	c3                   	ret    

00801875 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801875:	55                   	push   %ebp
  801876:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801878:	6a 00                	push   $0x0
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 0b                	push   $0xb
  801884:	e8 80 fe ff ff       	call   801709 <syscall>
  801889:	83 c4 18             	add    $0x18,%esp
}
  80188c:	c9                   	leave  
  80188d:	c3                   	ret    

0080188e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80188e:	55                   	push   %ebp
  80188f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 0c                	push   $0xc
  80189d:	e8 67 fe ff ff       	call   801709 <syscall>
  8018a2:	83 c4 18             	add    $0x18,%esp
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 0d                	push   $0xd
  8018b6:	e8 4e fe ff ff       	call   801709 <syscall>
  8018bb:	83 c4 18             	add    $0x18,%esp
}
  8018be:	c9                   	leave  
  8018bf:	c3                   	ret    

008018c0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018c0:	55                   	push   %ebp
  8018c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	ff 75 0c             	pushl  0xc(%ebp)
  8018cc:	ff 75 08             	pushl  0x8(%ebp)
  8018cf:	6a 11                	push   $0x11
  8018d1:	e8 33 fe ff ff       	call   801709 <syscall>
  8018d6:	83 c4 18             	add    $0x18,%esp
	return;
  8018d9:	90                   	nop
}
  8018da:	c9                   	leave  
  8018db:	c3                   	ret    

008018dc <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018dc:	55                   	push   %ebp
  8018dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	ff 75 0c             	pushl  0xc(%ebp)
  8018e8:	ff 75 08             	pushl  0x8(%ebp)
  8018eb:	6a 12                	push   $0x12
  8018ed:	e8 17 fe ff ff       	call   801709 <syscall>
  8018f2:	83 c4 18             	add    $0x18,%esp
	return ;
  8018f5:	90                   	nop
}
  8018f6:	c9                   	leave  
  8018f7:	c3                   	ret    

008018f8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018f8:	55                   	push   %ebp
  8018f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	6a 00                	push   $0x0
  801905:	6a 0e                	push   $0xe
  801907:	e8 fd fd ff ff       	call   801709 <syscall>
  80190c:	83 c4 18             	add    $0x18,%esp
}
  80190f:	c9                   	leave  
  801910:	c3                   	ret    

00801911 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801911:	55                   	push   %ebp
  801912:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	ff 75 08             	pushl  0x8(%ebp)
  80191f:	6a 0f                	push   $0xf
  801921:	e8 e3 fd ff ff       	call   801709 <syscall>
  801926:	83 c4 18             	add    $0x18,%esp
}
  801929:	c9                   	leave  
  80192a:	c3                   	ret    

0080192b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80192b:	55                   	push   %ebp
  80192c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 10                	push   $0x10
  80193a:	e8 ca fd ff ff       	call   801709 <syscall>
  80193f:	83 c4 18             	add    $0x18,%esp
}
  801942:	90                   	nop
  801943:	c9                   	leave  
  801944:	c3                   	ret    

00801945 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801945:	55                   	push   %ebp
  801946:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	6a 14                	push   $0x14
  801954:	e8 b0 fd ff ff       	call   801709 <syscall>
  801959:	83 c4 18             	add    $0x18,%esp
}
  80195c:	90                   	nop
  80195d:	c9                   	leave  
  80195e:	c3                   	ret    

0080195f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80195f:	55                   	push   %ebp
  801960:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 15                	push   $0x15
  80196e:	e8 96 fd ff ff       	call   801709 <syscall>
  801973:	83 c4 18             	add    $0x18,%esp
}
  801976:	90                   	nop
  801977:	c9                   	leave  
  801978:	c3                   	ret    

00801979 <sys_cputc>:


void
sys_cputc(const char c)
{
  801979:	55                   	push   %ebp
  80197a:	89 e5                	mov    %esp,%ebp
  80197c:	83 ec 04             	sub    $0x4,%esp
  80197f:	8b 45 08             	mov    0x8(%ebp),%eax
  801982:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801985:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	50                   	push   %eax
  801992:	6a 16                	push   $0x16
  801994:	e8 70 fd ff ff       	call   801709 <syscall>
  801999:	83 c4 18             	add    $0x18,%esp
}
  80199c:	90                   	nop
  80199d:	c9                   	leave  
  80199e:	c3                   	ret    

0080199f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80199f:	55                   	push   %ebp
  8019a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 17                	push   $0x17
  8019ae:	e8 56 fd ff ff       	call   801709 <syscall>
  8019b3:	83 c4 18             	add    $0x18,%esp
}
  8019b6:	90                   	nop
  8019b7:	c9                   	leave  
  8019b8:	c3                   	ret    

008019b9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019b9:	55                   	push   %ebp
  8019ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	ff 75 0c             	pushl  0xc(%ebp)
  8019c8:	50                   	push   %eax
  8019c9:	6a 18                	push   $0x18
  8019cb:	e8 39 fd ff ff       	call   801709 <syscall>
  8019d0:	83 c4 18             	add    $0x18,%esp
}
  8019d3:	c9                   	leave  
  8019d4:	c3                   	ret    

008019d5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019d5:	55                   	push   %ebp
  8019d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019db:	8b 45 08             	mov    0x8(%ebp),%eax
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	52                   	push   %edx
  8019e5:	50                   	push   %eax
  8019e6:	6a 1b                	push   $0x1b
  8019e8:	e8 1c fd ff ff       	call   801709 <syscall>
  8019ed:	83 c4 18             	add    $0x18,%esp
}
  8019f0:	c9                   	leave  
  8019f1:	c3                   	ret    

008019f2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019f2:	55                   	push   %ebp
  8019f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	52                   	push   %edx
  801a02:	50                   	push   %eax
  801a03:	6a 19                	push   $0x19
  801a05:	e8 ff fc ff ff       	call   801709 <syscall>
  801a0a:	83 c4 18             	add    $0x18,%esp
}
  801a0d:	90                   	nop
  801a0e:	c9                   	leave  
  801a0f:	c3                   	ret    

00801a10 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a10:	55                   	push   %ebp
  801a11:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a13:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a16:	8b 45 08             	mov    0x8(%ebp),%eax
  801a19:	6a 00                	push   $0x0
  801a1b:	6a 00                	push   $0x0
  801a1d:	6a 00                	push   $0x0
  801a1f:	52                   	push   %edx
  801a20:	50                   	push   %eax
  801a21:	6a 1a                	push   $0x1a
  801a23:	e8 e1 fc ff ff       	call   801709 <syscall>
  801a28:	83 c4 18             	add    $0x18,%esp
}
  801a2b:	90                   	nop
  801a2c:	c9                   	leave  
  801a2d:	c3                   	ret    

00801a2e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a2e:	55                   	push   %ebp
  801a2f:	89 e5                	mov    %esp,%ebp
  801a31:	83 ec 04             	sub    $0x4,%esp
  801a34:	8b 45 10             	mov    0x10(%ebp),%eax
  801a37:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a3a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a3d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a41:	8b 45 08             	mov    0x8(%ebp),%eax
  801a44:	6a 00                	push   $0x0
  801a46:	51                   	push   %ecx
  801a47:	52                   	push   %edx
  801a48:	ff 75 0c             	pushl  0xc(%ebp)
  801a4b:	50                   	push   %eax
  801a4c:	6a 1c                	push   $0x1c
  801a4e:	e8 b6 fc ff ff       	call   801709 <syscall>
  801a53:	83 c4 18             	add    $0x18,%esp
}
  801a56:	c9                   	leave  
  801a57:	c3                   	ret    

00801a58 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a58:	55                   	push   %ebp
  801a59:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	52                   	push   %edx
  801a68:	50                   	push   %eax
  801a69:	6a 1d                	push   $0x1d
  801a6b:	e8 99 fc ff ff       	call   801709 <syscall>
  801a70:	83 c4 18             	add    $0x18,%esp
}
  801a73:	c9                   	leave  
  801a74:	c3                   	ret    

00801a75 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a75:	55                   	push   %ebp
  801a76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a78:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a81:	6a 00                	push   $0x0
  801a83:	6a 00                	push   $0x0
  801a85:	51                   	push   %ecx
  801a86:	52                   	push   %edx
  801a87:	50                   	push   %eax
  801a88:	6a 1e                	push   $0x1e
  801a8a:	e8 7a fc ff ff       	call   801709 <syscall>
  801a8f:	83 c4 18             	add    $0x18,%esp
}
  801a92:	c9                   	leave  
  801a93:	c3                   	ret    

00801a94 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a94:	55                   	push   %ebp
  801a95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a97:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	52                   	push   %edx
  801aa4:	50                   	push   %eax
  801aa5:	6a 1f                	push   $0x1f
  801aa7:	e8 5d fc ff ff       	call   801709 <syscall>
  801aac:	83 c4 18             	add    $0x18,%esp
}
  801aaf:	c9                   	leave  
  801ab0:	c3                   	ret    

00801ab1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ab1:	55                   	push   %ebp
  801ab2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 20                	push   $0x20
  801ac0:	e8 44 fc ff ff       	call   801709 <syscall>
  801ac5:	83 c4 18             	add    $0x18,%esp
}
  801ac8:	c9                   	leave  
  801ac9:	c3                   	ret    

00801aca <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801aca:	55                   	push   %ebp
  801acb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801acd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	ff 75 10             	pushl  0x10(%ebp)
  801ad7:	ff 75 0c             	pushl  0xc(%ebp)
  801ada:	50                   	push   %eax
  801adb:	6a 21                	push   $0x21
  801add:	e8 27 fc ff ff       	call   801709 <syscall>
  801ae2:	83 c4 18             	add    $0x18,%esp
}
  801ae5:	c9                   	leave  
  801ae6:	c3                   	ret    

00801ae7 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ae7:	55                   	push   %ebp
  801ae8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801aea:	8b 45 08             	mov    0x8(%ebp),%eax
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	6a 00                	push   $0x0
  801af5:	50                   	push   %eax
  801af6:	6a 22                	push   $0x22
  801af8:	e8 0c fc ff ff       	call   801709 <syscall>
  801afd:	83 c4 18             	add    $0x18,%esp
}
  801b00:	90                   	nop
  801b01:	c9                   	leave  
  801b02:	c3                   	ret    

00801b03 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b03:	55                   	push   %ebp
  801b04:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b06:	8b 45 08             	mov    0x8(%ebp),%eax
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	50                   	push   %eax
  801b12:	6a 23                	push   $0x23
  801b14:	e8 f0 fb ff ff       	call   801709 <syscall>
  801b19:	83 c4 18             	add    $0x18,%esp
}
  801b1c:	90                   	nop
  801b1d:	c9                   	leave  
  801b1e:	c3                   	ret    

00801b1f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b1f:	55                   	push   %ebp
  801b20:	89 e5                	mov    %esp,%ebp
  801b22:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b25:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b28:	8d 50 04             	lea    0x4(%eax),%edx
  801b2b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	52                   	push   %edx
  801b35:	50                   	push   %eax
  801b36:	6a 24                	push   $0x24
  801b38:	e8 cc fb ff ff       	call   801709 <syscall>
  801b3d:	83 c4 18             	add    $0x18,%esp
	return result;
  801b40:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b43:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b46:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b49:	89 01                	mov    %eax,(%ecx)
  801b4b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b51:	c9                   	leave  
  801b52:	c2 04 00             	ret    $0x4

00801b55 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b55:	55                   	push   %ebp
  801b56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	ff 75 10             	pushl  0x10(%ebp)
  801b5f:	ff 75 0c             	pushl  0xc(%ebp)
  801b62:	ff 75 08             	pushl  0x8(%ebp)
  801b65:	6a 13                	push   $0x13
  801b67:	e8 9d fb ff ff       	call   801709 <syscall>
  801b6c:	83 c4 18             	add    $0x18,%esp
	return ;
  801b6f:	90                   	nop
}
  801b70:	c9                   	leave  
  801b71:	c3                   	ret    

00801b72 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 25                	push   $0x25
  801b81:	e8 83 fb ff ff       	call   801709 <syscall>
  801b86:	83 c4 18             	add    $0x18,%esp
}
  801b89:	c9                   	leave  
  801b8a:	c3                   	ret    

00801b8b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b8b:	55                   	push   %ebp
  801b8c:	89 e5                	mov    %esp,%ebp
  801b8e:	83 ec 04             	sub    $0x4,%esp
  801b91:	8b 45 08             	mov    0x8(%ebp),%eax
  801b94:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b97:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 00                	push   $0x0
  801ba3:	50                   	push   %eax
  801ba4:	6a 26                	push   $0x26
  801ba6:	e8 5e fb ff ff       	call   801709 <syscall>
  801bab:	83 c4 18             	add    $0x18,%esp
	return ;
  801bae:	90                   	nop
}
  801baf:	c9                   	leave  
  801bb0:	c3                   	ret    

00801bb1 <rsttst>:
void rsttst()
{
  801bb1:	55                   	push   %ebp
  801bb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 00                	push   $0x0
  801bbe:	6a 28                	push   $0x28
  801bc0:	e8 44 fb ff ff       	call   801709 <syscall>
  801bc5:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc8:	90                   	nop
}
  801bc9:	c9                   	leave  
  801bca:	c3                   	ret    

00801bcb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bcb:	55                   	push   %ebp
  801bcc:	89 e5                	mov    %esp,%ebp
  801bce:	83 ec 04             	sub    $0x4,%esp
  801bd1:	8b 45 14             	mov    0x14(%ebp),%eax
  801bd4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bd7:	8b 55 18             	mov    0x18(%ebp),%edx
  801bda:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bde:	52                   	push   %edx
  801bdf:	50                   	push   %eax
  801be0:	ff 75 10             	pushl  0x10(%ebp)
  801be3:	ff 75 0c             	pushl  0xc(%ebp)
  801be6:	ff 75 08             	pushl  0x8(%ebp)
  801be9:	6a 27                	push   $0x27
  801beb:	e8 19 fb ff ff       	call   801709 <syscall>
  801bf0:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf3:	90                   	nop
}
  801bf4:	c9                   	leave  
  801bf5:	c3                   	ret    

00801bf6 <chktst>:
void chktst(uint32 n)
{
  801bf6:	55                   	push   %ebp
  801bf7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	ff 75 08             	pushl  0x8(%ebp)
  801c04:	6a 29                	push   $0x29
  801c06:	e8 fe fa ff ff       	call   801709 <syscall>
  801c0b:	83 c4 18             	add    $0x18,%esp
	return ;
  801c0e:	90                   	nop
}
  801c0f:	c9                   	leave  
  801c10:	c3                   	ret    

00801c11 <inctst>:

void inctst()
{
  801c11:	55                   	push   %ebp
  801c12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 2a                	push   $0x2a
  801c20:	e8 e4 fa ff ff       	call   801709 <syscall>
  801c25:	83 c4 18             	add    $0x18,%esp
	return ;
  801c28:	90                   	nop
}
  801c29:	c9                   	leave  
  801c2a:	c3                   	ret    

00801c2b <gettst>:
uint32 gettst()
{
  801c2b:	55                   	push   %ebp
  801c2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 2b                	push   $0x2b
  801c3a:	e8 ca fa ff ff       	call   801709 <syscall>
  801c3f:	83 c4 18             	add    $0x18,%esp
}
  801c42:	c9                   	leave  
  801c43:	c3                   	ret    

00801c44 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c44:	55                   	push   %ebp
  801c45:	89 e5                	mov    %esp,%ebp
  801c47:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	6a 2c                	push   $0x2c
  801c56:	e8 ae fa ff ff       	call   801709 <syscall>
  801c5b:	83 c4 18             	add    $0x18,%esp
  801c5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c61:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c65:	75 07                	jne    801c6e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c67:	b8 01 00 00 00       	mov    $0x1,%eax
  801c6c:	eb 05                	jmp    801c73 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c6e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c73:	c9                   	leave  
  801c74:	c3                   	ret    

00801c75 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c75:	55                   	push   %ebp
  801c76:	89 e5                	mov    %esp,%ebp
  801c78:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	6a 00                	push   $0x0
  801c85:	6a 2c                	push   $0x2c
  801c87:	e8 7d fa ff ff       	call   801709 <syscall>
  801c8c:	83 c4 18             	add    $0x18,%esp
  801c8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c92:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c96:	75 07                	jne    801c9f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c98:	b8 01 00 00 00       	mov    $0x1,%eax
  801c9d:	eb 05                	jmp    801ca4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c9f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ca4:	c9                   	leave  
  801ca5:	c3                   	ret    

00801ca6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ca6:	55                   	push   %ebp
  801ca7:	89 e5                	mov    %esp,%ebp
  801ca9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 2c                	push   $0x2c
  801cb8:	e8 4c fa ff ff       	call   801709 <syscall>
  801cbd:	83 c4 18             	add    $0x18,%esp
  801cc0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cc3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cc7:	75 07                	jne    801cd0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cc9:	b8 01 00 00 00       	mov    $0x1,%eax
  801cce:	eb 05                	jmp    801cd5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cd0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cd5:	c9                   	leave  
  801cd6:	c3                   	ret    

00801cd7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cd7:	55                   	push   %ebp
  801cd8:	89 e5                	mov    %esp,%ebp
  801cda:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 2c                	push   $0x2c
  801ce9:	e8 1b fa ff ff       	call   801709 <syscall>
  801cee:	83 c4 18             	add    $0x18,%esp
  801cf1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cf4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cf8:	75 07                	jne    801d01 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cfa:	b8 01 00 00 00       	mov    $0x1,%eax
  801cff:	eb 05                	jmp    801d06 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d01:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d06:	c9                   	leave  
  801d07:	c3                   	ret    

00801d08 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d08:	55                   	push   %ebp
  801d09:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	ff 75 08             	pushl  0x8(%ebp)
  801d16:	6a 2d                	push   $0x2d
  801d18:	e8 ec f9 ff ff       	call   801709 <syscall>
  801d1d:	83 c4 18             	add    $0x18,%esp
	return ;
  801d20:	90                   	nop
}
  801d21:	c9                   	leave  
  801d22:	c3                   	ret    
  801d23:	90                   	nop

00801d24 <__udivdi3>:
  801d24:	55                   	push   %ebp
  801d25:	57                   	push   %edi
  801d26:	56                   	push   %esi
  801d27:	53                   	push   %ebx
  801d28:	83 ec 1c             	sub    $0x1c,%esp
  801d2b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d2f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d33:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d37:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d3b:	89 ca                	mov    %ecx,%edx
  801d3d:	89 f8                	mov    %edi,%eax
  801d3f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d43:	85 f6                	test   %esi,%esi
  801d45:	75 2d                	jne    801d74 <__udivdi3+0x50>
  801d47:	39 cf                	cmp    %ecx,%edi
  801d49:	77 65                	ja     801db0 <__udivdi3+0x8c>
  801d4b:	89 fd                	mov    %edi,%ebp
  801d4d:	85 ff                	test   %edi,%edi
  801d4f:	75 0b                	jne    801d5c <__udivdi3+0x38>
  801d51:	b8 01 00 00 00       	mov    $0x1,%eax
  801d56:	31 d2                	xor    %edx,%edx
  801d58:	f7 f7                	div    %edi
  801d5a:	89 c5                	mov    %eax,%ebp
  801d5c:	31 d2                	xor    %edx,%edx
  801d5e:	89 c8                	mov    %ecx,%eax
  801d60:	f7 f5                	div    %ebp
  801d62:	89 c1                	mov    %eax,%ecx
  801d64:	89 d8                	mov    %ebx,%eax
  801d66:	f7 f5                	div    %ebp
  801d68:	89 cf                	mov    %ecx,%edi
  801d6a:	89 fa                	mov    %edi,%edx
  801d6c:	83 c4 1c             	add    $0x1c,%esp
  801d6f:	5b                   	pop    %ebx
  801d70:	5e                   	pop    %esi
  801d71:	5f                   	pop    %edi
  801d72:	5d                   	pop    %ebp
  801d73:	c3                   	ret    
  801d74:	39 ce                	cmp    %ecx,%esi
  801d76:	77 28                	ja     801da0 <__udivdi3+0x7c>
  801d78:	0f bd fe             	bsr    %esi,%edi
  801d7b:	83 f7 1f             	xor    $0x1f,%edi
  801d7e:	75 40                	jne    801dc0 <__udivdi3+0x9c>
  801d80:	39 ce                	cmp    %ecx,%esi
  801d82:	72 0a                	jb     801d8e <__udivdi3+0x6a>
  801d84:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d88:	0f 87 9e 00 00 00    	ja     801e2c <__udivdi3+0x108>
  801d8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d93:	89 fa                	mov    %edi,%edx
  801d95:	83 c4 1c             	add    $0x1c,%esp
  801d98:	5b                   	pop    %ebx
  801d99:	5e                   	pop    %esi
  801d9a:	5f                   	pop    %edi
  801d9b:	5d                   	pop    %ebp
  801d9c:	c3                   	ret    
  801d9d:	8d 76 00             	lea    0x0(%esi),%esi
  801da0:	31 ff                	xor    %edi,%edi
  801da2:	31 c0                	xor    %eax,%eax
  801da4:	89 fa                	mov    %edi,%edx
  801da6:	83 c4 1c             	add    $0x1c,%esp
  801da9:	5b                   	pop    %ebx
  801daa:	5e                   	pop    %esi
  801dab:	5f                   	pop    %edi
  801dac:	5d                   	pop    %ebp
  801dad:	c3                   	ret    
  801dae:	66 90                	xchg   %ax,%ax
  801db0:	89 d8                	mov    %ebx,%eax
  801db2:	f7 f7                	div    %edi
  801db4:	31 ff                	xor    %edi,%edi
  801db6:	89 fa                	mov    %edi,%edx
  801db8:	83 c4 1c             	add    $0x1c,%esp
  801dbb:	5b                   	pop    %ebx
  801dbc:	5e                   	pop    %esi
  801dbd:	5f                   	pop    %edi
  801dbe:	5d                   	pop    %ebp
  801dbf:	c3                   	ret    
  801dc0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801dc5:	89 eb                	mov    %ebp,%ebx
  801dc7:	29 fb                	sub    %edi,%ebx
  801dc9:	89 f9                	mov    %edi,%ecx
  801dcb:	d3 e6                	shl    %cl,%esi
  801dcd:	89 c5                	mov    %eax,%ebp
  801dcf:	88 d9                	mov    %bl,%cl
  801dd1:	d3 ed                	shr    %cl,%ebp
  801dd3:	89 e9                	mov    %ebp,%ecx
  801dd5:	09 f1                	or     %esi,%ecx
  801dd7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ddb:	89 f9                	mov    %edi,%ecx
  801ddd:	d3 e0                	shl    %cl,%eax
  801ddf:	89 c5                	mov    %eax,%ebp
  801de1:	89 d6                	mov    %edx,%esi
  801de3:	88 d9                	mov    %bl,%cl
  801de5:	d3 ee                	shr    %cl,%esi
  801de7:	89 f9                	mov    %edi,%ecx
  801de9:	d3 e2                	shl    %cl,%edx
  801deb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801def:	88 d9                	mov    %bl,%cl
  801df1:	d3 e8                	shr    %cl,%eax
  801df3:	09 c2                	or     %eax,%edx
  801df5:	89 d0                	mov    %edx,%eax
  801df7:	89 f2                	mov    %esi,%edx
  801df9:	f7 74 24 0c          	divl   0xc(%esp)
  801dfd:	89 d6                	mov    %edx,%esi
  801dff:	89 c3                	mov    %eax,%ebx
  801e01:	f7 e5                	mul    %ebp
  801e03:	39 d6                	cmp    %edx,%esi
  801e05:	72 19                	jb     801e20 <__udivdi3+0xfc>
  801e07:	74 0b                	je     801e14 <__udivdi3+0xf0>
  801e09:	89 d8                	mov    %ebx,%eax
  801e0b:	31 ff                	xor    %edi,%edi
  801e0d:	e9 58 ff ff ff       	jmp    801d6a <__udivdi3+0x46>
  801e12:	66 90                	xchg   %ax,%ax
  801e14:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e18:	89 f9                	mov    %edi,%ecx
  801e1a:	d3 e2                	shl    %cl,%edx
  801e1c:	39 c2                	cmp    %eax,%edx
  801e1e:	73 e9                	jae    801e09 <__udivdi3+0xe5>
  801e20:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e23:	31 ff                	xor    %edi,%edi
  801e25:	e9 40 ff ff ff       	jmp    801d6a <__udivdi3+0x46>
  801e2a:	66 90                	xchg   %ax,%ax
  801e2c:	31 c0                	xor    %eax,%eax
  801e2e:	e9 37 ff ff ff       	jmp    801d6a <__udivdi3+0x46>
  801e33:	90                   	nop

00801e34 <__umoddi3>:
  801e34:	55                   	push   %ebp
  801e35:	57                   	push   %edi
  801e36:	56                   	push   %esi
  801e37:	53                   	push   %ebx
  801e38:	83 ec 1c             	sub    $0x1c,%esp
  801e3b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e3f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e47:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e4f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e53:	89 f3                	mov    %esi,%ebx
  801e55:	89 fa                	mov    %edi,%edx
  801e57:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e5b:	89 34 24             	mov    %esi,(%esp)
  801e5e:	85 c0                	test   %eax,%eax
  801e60:	75 1a                	jne    801e7c <__umoddi3+0x48>
  801e62:	39 f7                	cmp    %esi,%edi
  801e64:	0f 86 a2 00 00 00    	jbe    801f0c <__umoddi3+0xd8>
  801e6a:	89 c8                	mov    %ecx,%eax
  801e6c:	89 f2                	mov    %esi,%edx
  801e6e:	f7 f7                	div    %edi
  801e70:	89 d0                	mov    %edx,%eax
  801e72:	31 d2                	xor    %edx,%edx
  801e74:	83 c4 1c             	add    $0x1c,%esp
  801e77:	5b                   	pop    %ebx
  801e78:	5e                   	pop    %esi
  801e79:	5f                   	pop    %edi
  801e7a:	5d                   	pop    %ebp
  801e7b:	c3                   	ret    
  801e7c:	39 f0                	cmp    %esi,%eax
  801e7e:	0f 87 ac 00 00 00    	ja     801f30 <__umoddi3+0xfc>
  801e84:	0f bd e8             	bsr    %eax,%ebp
  801e87:	83 f5 1f             	xor    $0x1f,%ebp
  801e8a:	0f 84 ac 00 00 00    	je     801f3c <__umoddi3+0x108>
  801e90:	bf 20 00 00 00       	mov    $0x20,%edi
  801e95:	29 ef                	sub    %ebp,%edi
  801e97:	89 fe                	mov    %edi,%esi
  801e99:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e9d:	89 e9                	mov    %ebp,%ecx
  801e9f:	d3 e0                	shl    %cl,%eax
  801ea1:	89 d7                	mov    %edx,%edi
  801ea3:	89 f1                	mov    %esi,%ecx
  801ea5:	d3 ef                	shr    %cl,%edi
  801ea7:	09 c7                	or     %eax,%edi
  801ea9:	89 e9                	mov    %ebp,%ecx
  801eab:	d3 e2                	shl    %cl,%edx
  801ead:	89 14 24             	mov    %edx,(%esp)
  801eb0:	89 d8                	mov    %ebx,%eax
  801eb2:	d3 e0                	shl    %cl,%eax
  801eb4:	89 c2                	mov    %eax,%edx
  801eb6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eba:	d3 e0                	shl    %cl,%eax
  801ebc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ec0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ec4:	89 f1                	mov    %esi,%ecx
  801ec6:	d3 e8                	shr    %cl,%eax
  801ec8:	09 d0                	or     %edx,%eax
  801eca:	d3 eb                	shr    %cl,%ebx
  801ecc:	89 da                	mov    %ebx,%edx
  801ece:	f7 f7                	div    %edi
  801ed0:	89 d3                	mov    %edx,%ebx
  801ed2:	f7 24 24             	mull   (%esp)
  801ed5:	89 c6                	mov    %eax,%esi
  801ed7:	89 d1                	mov    %edx,%ecx
  801ed9:	39 d3                	cmp    %edx,%ebx
  801edb:	0f 82 87 00 00 00    	jb     801f68 <__umoddi3+0x134>
  801ee1:	0f 84 91 00 00 00    	je     801f78 <__umoddi3+0x144>
  801ee7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801eeb:	29 f2                	sub    %esi,%edx
  801eed:	19 cb                	sbb    %ecx,%ebx
  801eef:	89 d8                	mov    %ebx,%eax
  801ef1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ef5:	d3 e0                	shl    %cl,%eax
  801ef7:	89 e9                	mov    %ebp,%ecx
  801ef9:	d3 ea                	shr    %cl,%edx
  801efb:	09 d0                	or     %edx,%eax
  801efd:	89 e9                	mov    %ebp,%ecx
  801eff:	d3 eb                	shr    %cl,%ebx
  801f01:	89 da                	mov    %ebx,%edx
  801f03:	83 c4 1c             	add    $0x1c,%esp
  801f06:	5b                   	pop    %ebx
  801f07:	5e                   	pop    %esi
  801f08:	5f                   	pop    %edi
  801f09:	5d                   	pop    %ebp
  801f0a:	c3                   	ret    
  801f0b:	90                   	nop
  801f0c:	89 fd                	mov    %edi,%ebp
  801f0e:	85 ff                	test   %edi,%edi
  801f10:	75 0b                	jne    801f1d <__umoddi3+0xe9>
  801f12:	b8 01 00 00 00       	mov    $0x1,%eax
  801f17:	31 d2                	xor    %edx,%edx
  801f19:	f7 f7                	div    %edi
  801f1b:	89 c5                	mov    %eax,%ebp
  801f1d:	89 f0                	mov    %esi,%eax
  801f1f:	31 d2                	xor    %edx,%edx
  801f21:	f7 f5                	div    %ebp
  801f23:	89 c8                	mov    %ecx,%eax
  801f25:	f7 f5                	div    %ebp
  801f27:	89 d0                	mov    %edx,%eax
  801f29:	e9 44 ff ff ff       	jmp    801e72 <__umoddi3+0x3e>
  801f2e:	66 90                	xchg   %ax,%ax
  801f30:	89 c8                	mov    %ecx,%eax
  801f32:	89 f2                	mov    %esi,%edx
  801f34:	83 c4 1c             	add    $0x1c,%esp
  801f37:	5b                   	pop    %ebx
  801f38:	5e                   	pop    %esi
  801f39:	5f                   	pop    %edi
  801f3a:	5d                   	pop    %ebp
  801f3b:	c3                   	ret    
  801f3c:	3b 04 24             	cmp    (%esp),%eax
  801f3f:	72 06                	jb     801f47 <__umoddi3+0x113>
  801f41:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f45:	77 0f                	ja     801f56 <__umoddi3+0x122>
  801f47:	89 f2                	mov    %esi,%edx
  801f49:	29 f9                	sub    %edi,%ecx
  801f4b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f4f:	89 14 24             	mov    %edx,(%esp)
  801f52:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f56:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f5a:	8b 14 24             	mov    (%esp),%edx
  801f5d:	83 c4 1c             	add    $0x1c,%esp
  801f60:	5b                   	pop    %ebx
  801f61:	5e                   	pop    %esi
  801f62:	5f                   	pop    %edi
  801f63:	5d                   	pop    %ebp
  801f64:	c3                   	ret    
  801f65:	8d 76 00             	lea    0x0(%esi),%esi
  801f68:	2b 04 24             	sub    (%esp),%eax
  801f6b:	19 fa                	sbb    %edi,%edx
  801f6d:	89 d1                	mov    %edx,%ecx
  801f6f:	89 c6                	mov    %eax,%esi
  801f71:	e9 71 ff ff ff       	jmp    801ee7 <__umoddi3+0xb3>
  801f76:	66 90                	xchg   %ax,%ax
  801f78:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f7c:	72 ea                	jb     801f68 <__umoddi3+0x134>
  801f7e:	89 d9                	mov    %ebx,%ecx
  801f80:	e9 62 ff ff ff       	jmp    801ee7 <__umoddi3+0xb3>
