
obj/user/tst_sharing_5_master:     file format elf32-i386


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
  800031:	e8 8b 03 00 00       	call   8003c1 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the free of shared variables
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp
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
  80008d:	68 e0 20 80 00       	push   $0x8020e0
  800092:	6a 12                	push   $0x12
  800094:	68 fc 20 80 00       	push   $0x8020fc
  800099:	e8 25 04 00 00       	call   8004c3 <_panic>
	}

	cprintf("************************************************\n");
  80009e:	83 ec 0c             	sub    $0xc,%esp
  8000a1:	68 18 21 80 00       	push   $0x802118
  8000a6:	e8 cc 06 00 00       	call   800777 <cprintf>
  8000ab:	83 c4 10             	add    $0x10,%esp
	cprintf("MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  8000ae:	83 ec 0c             	sub    $0xc,%esp
  8000b1:	68 4c 21 80 00       	push   $0x80214c
  8000b6:	e8 bc 06 00 00       	call   800777 <cprintf>
  8000bb:	83 c4 10             	add    $0x10,%esp
	cprintf("************************************************\n\n\n");
  8000be:	83 ec 0c             	sub    $0xc,%esp
  8000c1:	68 a8 21 80 00       	push   $0x8021a8
  8000c6:	e8 ac 06 00 00       	call   800777 <cprintf>
  8000cb:	83 c4 10             	add    $0x10,%esp

	int envID = sys_getenvid();
  8000ce:	e8 46 17 00 00       	call   801819 <sys_getenvid>
  8000d3:	89 45 ec             	mov    %eax,-0x14(%ebp)

	cprintf("STEP A: checking free of shared object using 2 environments... \n");
  8000d6:	83 ec 0c             	sub    $0xc,%esp
  8000d9:	68 dc 21 80 00       	push   $0x8021dc
  8000de:	e8 94 06 00 00       	call   800777 <cprintf>
  8000e3:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x;
		int32 envIdSlave1 = sys_create_env("tshr5slave", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8000eb:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8000f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f6:	8b 40 74             	mov    0x74(%eax),%eax
  8000f9:	83 ec 04             	sub    $0x4,%esp
  8000fc:	52                   	push   %edx
  8000fd:	50                   	push   %eax
  8000fe:	68 1d 22 80 00       	push   $0x80221d
  800103:	e8 4a 1a 00 00       	call   801b52 <sys_create_env>
  800108:	83 c4 10             	add    $0x10,%esp
  80010b:	89 45 e8             	mov    %eax,-0x18(%ebp)
		int32 envIdSlave2 = sys_create_env("tshr5slave", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80010e:	a1 20 30 80 00       	mov    0x803020,%eax
  800113:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800119:	a1 20 30 80 00       	mov    0x803020,%eax
  80011e:	8b 40 74             	mov    0x74(%eax),%eax
  800121:	83 ec 04             	sub    $0x4,%esp
  800124:	52                   	push   %edx
  800125:	50                   	push   %eax
  800126:	68 1d 22 80 00       	push   $0x80221d
  80012b:	e8 22 1a 00 00       	call   801b52 <sys_create_env>
  800130:	83 c4 10             	add    $0x10,%esp
  800133:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		int freeFrames = sys_calculate_free_frames() ;
  800136:	e8 c2 17 00 00       	call   8018fd <sys_calculate_free_frames>
  80013b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  80013e:	83 ec 04             	sub    $0x4,%esp
  800141:	6a 01                	push   $0x1
  800143:	68 00 10 00 00       	push   $0x1000
  800148:	68 28 22 80 00       	push   $0x802228
  80014d:	e8 af 13 00 00       	call   801501 <smalloc>
  800152:	83 c4 10             	add    $0x10,%esp
  800155:	89 45 dc             	mov    %eax,-0x24(%ebp)
		cprintf("Master env created x (1 page) \n");
  800158:	83 ec 0c             	sub    $0xc,%esp
  80015b:	68 2c 22 80 00       	push   $0x80222c
  800160:	e8 12 06 00 00       	call   800777 <cprintf>
  800165:	83 c4 10             	add    $0x10,%esp
		if (x != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800168:	81 7d dc 00 00 00 80 	cmpl   $0x80000000,-0x24(%ebp)
  80016f:	74 14                	je     800185 <_main+0x14d>
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 4c 22 80 00       	push   $0x80224c
  800179:	6a 24                	push   $0x24
  80017b:	68 fc 20 80 00       	push   $0x8020fc
  800180:	e8 3e 03 00 00       	call   8004c3 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800185:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800188:	e8 70 17 00 00       	call   8018fd <sys_calculate_free_frames>
  80018d:	29 c3                	sub    %eax,%ebx
  80018f:	89 d8                	mov    %ebx,%eax
  800191:	83 f8 04             	cmp    $0x4,%eax
  800194:	74 14                	je     8001aa <_main+0x172>
  800196:	83 ec 04             	sub    $0x4,%esp
  800199:	68 b8 22 80 00       	push   $0x8022b8
  80019e:	6a 25                	push   $0x25
  8001a0:	68 fc 20 80 00       	push   $0x8020fc
  8001a5:	e8 19 03 00 00       	call   8004c3 <_panic>

		//to check that the slave environments completed successfully
		rsttst();
  8001aa:	e8 8a 1a 00 00       	call   801c39 <rsttst>

		sys_run_env(envIdSlave1);
  8001af:	83 ec 0c             	sub    $0xc,%esp
  8001b2:	ff 75 e8             	pushl  -0x18(%ebp)
  8001b5:	e8 b5 19 00 00       	call   801b6f <sys_run_env>
  8001ba:	83 c4 10             	add    $0x10,%esp
		sys_run_env(envIdSlave2);
  8001bd:	83 ec 0c             	sub    $0xc,%esp
  8001c0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001c3:	e8 a7 19 00 00       	call   801b6f <sys_run_env>
  8001c8:	83 c4 10             	add    $0x10,%esp

		cprintf("please be patient ...\n");
  8001cb:	83 ec 0c             	sub    $0xc,%esp
  8001ce:	68 36 23 80 00       	push   $0x802336
  8001d3:	e8 9f 05 00 00       	call   800777 <cprintf>
  8001d8:	83 c4 10             	add    $0x10,%esp
		env_sleep(3000);
  8001db:	83 ec 0c             	sub    $0xc,%esp
  8001de:	68 b8 0b 00 00       	push   $0xbb8
  8001e3:	e8 c3 1b 00 00       	call   801dab <env_sleep>
  8001e8:	83 c4 10             	add    $0x10,%esp

		//to ensure that the slave environments completed successfully
		if (gettst()!=2) panic("test failed");
  8001eb:	e8 c3 1a 00 00       	call   801cb3 <gettst>
  8001f0:	83 f8 02             	cmp    $0x2,%eax
  8001f3:	74 14                	je     800209 <_main+0x1d1>
  8001f5:	83 ec 04             	sub    $0x4,%esp
  8001f8:	68 4d 23 80 00       	push   $0x80234d
  8001fd:	6a 31                	push   $0x31
  8001ff:	68 fc 20 80 00       	push   $0x8020fc
  800204:	e8 ba 02 00 00       	call   8004c3 <_panic>

		sfree(x);
  800209:	83 ec 0c             	sub    $0xc,%esp
  80020c:	ff 75 dc             	pushl  -0x24(%ebp)
  80020f:	e8 43 15 00 00       	call   801757 <sfree>
  800214:	83 c4 10             	add    $0x10,%esp
		cprintf("Master env removed x (1 page) \n");
  800217:	83 ec 0c             	sub    $0xc,%esp
  80021a:	68 5c 23 80 00       	push   $0x80235c
  80021f:	e8 53 05 00 00       	call   800777 <cprintf>
  800224:	83 c4 10             	add    $0x10,%esp
		int diff = (sys_calculate_free_frames() - freeFrames);
  800227:	e8 d1 16 00 00       	call   8018fd <sys_calculate_free_frames>
  80022c:	89 c2                	mov    %eax,%edx
  80022e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800231:	29 c2                	sub    %eax,%edx
  800233:	89 d0                	mov    %edx,%eax
  800235:	89 45 d8             	mov    %eax,-0x28(%ebp)
		if ( diff !=  0) panic("Wrong free: revise your freeSharedObject logic\n");
  800238:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  80023c:	74 14                	je     800252 <_main+0x21a>
  80023e:	83 ec 04             	sub    $0x4,%esp
  800241:	68 7c 23 80 00       	push   $0x80237c
  800246:	6a 36                	push   $0x36
  800248:	68 fc 20 80 00       	push   $0x8020fc
  80024d:	e8 71 02 00 00       	call   8004c3 <_panic>
	}
	cprintf("Step A completed successfully!!\n\n\n");
  800252:	83 ec 0c             	sub    $0xc,%esp
  800255:	68 ac 23 80 00       	push   $0x8023ac
  80025a:	e8 18 05 00 00       	call   800777 <cprintf>
  80025f:	83 c4 10             	add    $0x10,%esp

	cprintf("STEP B: checking free of 2 shared objects ... \n");
  800262:	83 ec 0c             	sub    $0xc,%esp
  800265:	68 d0 23 80 00       	push   $0x8023d0
  80026a:	e8 08 05 00 00       	call   800777 <cprintf>
  80026f:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x, *z ;
		int32 envIdSlaveB1 = sys_create_env("tshr5slaveB1", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800272:	a1 20 30 80 00       	mov    0x803020,%eax
  800277:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  80027d:	a1 20 30 80 00       	mov    0x803020,%eax
  800282:	8b 40 74             	mov    0x74(%eax),%eax
  800285:	83 ec 04             	sub    $0x4,%esp
  800288:	52                   	push   %edx
  800289:	50                   	push   %eax
  80028a:	68 00 24 80 00       	push   $0x802400
  80028f:	e8 be 18 00 00       	call   801b52 <sys_create_env>
  800294:	83 c4 10             	add    $0x10,%esp
  800297:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int32 envIdSlaveB2 = sys_create_env("tshr5slaveB2", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80029a:	a1 20 30 80 00       	mov    0x803020,%eax
  80029f:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8002a5:	a1 20 30 80 00       	mov    0x803020,%eax
  8002aa:	8b 40 74             	mov    0x74(%eax),%eax
  8002ad:	83 ec 04             	sub    $0x4,%esp
  8002b0:	52                   	push   %edx
  8002b1:	50                   	push   %eax
  8002b2:	68 0d 24 80 00       	push   $0x80240d
  8002b7:	e8 96 18 00 00       	call   801b52 <sys_create_env>
  8002bc:	83 c4 10             	add    $0x10,%esp
  8002bf:	89 45 d0             	mov    %eax,-0x30(%ebp)

		z = smalloc("z", PAGE_SIZE, 1);
  8002c2:	83 ec 04             	sub    $0x4,%esp
  8002c5:	6a 01                	push   $0x1
  8002c7:	68 00 10 00 00       	push   $0x1000
  8002cc:	68 1a 24 80 00       	push   $0x80241a
  8002d1:	e8 2b 12 00 00       	call   801501 <smalloc>
  8002d6:	83 c4 10             	add    $0x10,%esp
  8002d9:	89 45 cc             	mov    %eax,-0x34(%ebp)
		cprintf("Master env created z (1 page) \n");
  8002dc:	83 ec 0c             	sub    $0xc,%esp
  8002df:	68 1c 24 80 00       	push   $0x80241c
  8002e4:	e8 8e 04 00 00       	call   800777 <cprintf>
  8002e9:	83 c4 10             	add    $0x10,%esp

		x = smalloc("x", PAGE_SIZE, 1);
  8002ec:	83 ec 04             	sub    $0x4,%esp
  8002ef:	6a 01                	push   $0x1
  8002f1:	68 00 10 00 00       	push   $0x1000
  8002f6:	68 28 22 80 00       	push   $0x802228
  8002fb:	e8 01 12 00 00       	call   801501 <smalloc>
  800300:	83 c4 10             	add    $0x10,%esp
  800303:	89 45 c8             	mov    %eax,-0x38(%ebp)
		cprintf("Master env created x (1 page) \n");
  800306:	83 ec 0c             	sub    $0xc,%esp
  800309:	68 2c 22 80 00       	push   $0x80222c
  80030e:	e8 64 04 00 00       	call   800777 <cprintf>
  800313:	83 c4 10             	add    $0x10,%esp

		rsttst();
  800316:	e8 1e 19 00 00       	call   801c39 <rsttst>

		sys_run_env(envIdSlaveB1);
  80031b:	83 ec 0c             	sub    $0xc,%esp
  80031e:	ff 75 d4             	pushl  -0x2c(%ebp)
  800321:	e8 49 18 00 00       	call   801b6f <sys_run_env>
  800326:	83 c4 10             	add    $0x10,%esp
		sys_run_env(envIdSlaveB2);
  800329:	83 ec 0c             	sub    $0xc,%esp
  80032c:	ff 75 d0             	pushl  -0x30(%ebp)
  80032f:	e8 3b 18 00 00       	call   801b6f <sys_run_env>
  800334:	83 c4 10             	add    $0x10,%esp

		env_sleep(4000); //give slaves time to catch the shared object before removal
  800337:	83 ec 0c             	sub    $0xc,%esp
  80033a:	68 a0 0f 00 00       	push   $0xfa0
  80033f:	e8 67 1a 00 00       	call   801dab <env_sleep>
  800344:	83 c4 10             	add    $0x10,%esp

		int freeFrames = sys_calculate_free_frames() ;
  800347:	e8 b1 15 00 00       	call   8018fd <sys_calculate_free_frames>
  80034c:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		sfree(z);
  80034f:	83 ec 0c             	sub    $0xc,%esp
  800352:	ff 75 cc             	pushl  -0x34(%ebp)
  800355:	e8 fd 13 00 00       	call   801757 <sfree>
  80035a:	83 c4 10             	add    $0x10,%esp
		cprintf("Master env removed z\n");
  80035d:	83 ec 0c             	sub    $0xc,%esp
  800360:	68 3c 24 80 00       	push   $0x80243c
  800365:	e8 0d 04 00 00       	call   800777 <cprintf>
  80036a:	83 c4 10             	add    $0x10,%esp

		sfree(x);
  80036d:	83 ec 0c             	sub    $0xc,%esp
  800370:	ff 75 c8             	pushl  -0x38(%ebp)
  800373:	e8 df 13 00 00       	call   801757 <sfree>
  800378:	83 c4 10             	add    $0x10,%esp
		cprintf("Master env removed x\n");
  80037b:	83 ec 0c             	sub    $0xc,%esp
  80037e:	68 52 24 80 00       	push   $0x802452
  800383:	e8 ef 03 00 00       	call   800777 <cprintf>
  800388:	83 c4 10             	add    $0x10,%esp

		int diff = (sys_calculate_free_frames() - freeFrames);
  80038b:	e8 6d 15 00 00       	call   8018fd <sys_calculate_free_frames>
  800390:	89 c2                	mov    %eax,%edx
  800392:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800395:	29 c2                	sub    %eax,%edx
  800397:	89 d0                	mov    %edx,%eax
  800399:	89 45 c0             	mov    %eax,-0x40(%ebp)

		if (diff !=  1) panic("Wrong free: frames removed not equal 1 !, correct frames to be removed are 1:\nfrom the env: 1 table\nframes_storage of z & x: should NOT cleared yet (still in use!)\n");
  80039c:	83 7d c0 01          	cmpl   $0x1,-0x40(%ebp)
  8003a0:	74 14                	je     8003b6 <_main+0x37e>
  8003a2:	83 ec 04             	sub    $0x4,%esp
  8003a5:	68 68 24 80 00       	push   $0x802468
  8003aa:	6a 57                	push   $0x57
  8003ac:	68 fc 20 80 00       	push   $0x8020fc
  8003b1:	e8 0d 01 00 00       	call   8004c3 <_panic>

		//To indicate that it's completed successfully
		inctst();
  8003b6:	e8 de 18 00 00       	call   801c99 <inctst>


	}


	return;
  8003bb:	90                   	nop
}
  8003bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003bf:	c9                   	leave  
  8003c0:	c3                   	ret    

008003c1 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8003c1:	55                   	push   %ebp
  8003c2:	89 e5                	mov    %esp,%ebp
  8003c4:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8003c7:	e8 66 14 00 00       	call   801832 <sys_getenvindex>
  8003cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8003cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003d2:	89 d0                	mov    %edx,%eax
  8003d4:	01 c0                	add    %eax,%eax
  8003d6:	01 d0                	add    %edx,%eax
  8003d8:	c1 e0 02             	shl    $0x2,%eax
  8003db:	01 d0                	add    %edx,%eax
  8003dd:	c1 e0 06             	shl    $0x6,%eax
  8003e0:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8003e5:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8003ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ef:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8003f5:	84 c0                	test   %al,%al
  8003f7:	74 0f                	je     800408 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8003f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003fe:	05 f4 02 00 00       	add    $0x2f4,%eax
  800403:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800408:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80040c:	7e 0a                	jle    800418 <libmain+0x57>
		binaryname = argv[0];
  80040e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800411:	8b 00                	mov    (%eax),%eax
  800413:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800418:	83 ec 08             	sub    $0x8,%esp
  80041b:	ff 75 0c             	pushl  0xc(%ebp)
  80041e:	ff 75 08             	pushl  0x8(%ebp)
  800421:	e8 12 fc ff ff       	call   800038 <_main>
  800426:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800429:	e8 9f 15 00 00       	call   8019cd <sys_disable_interrupt>
	cprintf("**************************************\n");
  80042e:	83 ec 0c             	sub    $0xc,%esp
  800431:	68 28 25 80 00       	push   $0x802528
  800436:	e8 3c 03 00 00       	call   800777 <cprintf>
  80043b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80043e:	a1 20 30 80 00       	mov    0x803020,%eax
  800443:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800449:	a1 20 30 80 00       	mov    0x803020,%eax
  80044e:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800454:	83 ec 04             	sub    $0x4,%esp
  800457:	52                   	push   %edx
  800458:	50                   	push   %eax
  800459:	68 50 25 80 00       	push   $0x802550
  80045e:	e8 14 03 00 00       	call   800777 <cprintf>
  800463:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800466:	a1 20 30 80 00       	mov    0x803020,%eax
  80046b:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800471:	83 ec 08             	sub    $0x8,%esp
  800474:	50                   	push   %eax
  800475:	68 75 25 80 00       	push   $0x802575
  80047a:	e8 f8 02 00 00       	call   800777 <cprintf>
  80047f:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800482:	83 ec 0c             	sub    $0xc,%esp
  800485:	68 28 25 80 00       	push   $0x802528
  80048a:	e8 e8 02 00 00       	call   800777 <cprintf>
  80048f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800492:	e8 50 15 00 00       	call   8019e7 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800497:	e8 19 00 00 00       	call   8004b5 <exit>
}
  80049c:	90                   	nop
  80049d:	c9                   	leave  
  80049e:	c3                   	ret    

0080049f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80049f:	55                   	push   %ebp
  8004a0:	89 e5                	mov    %esp,%ebp
  8004a2:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8004a5:	83 ec 0c             	sub    $0xc,%esp
  8004a8:	6a 00                	push   $0x0
  8004aa:	e8 4f 13 00 00       	call   8017fe <sys_env_destroy>
  8004af:	83 c4 10             	add    $0x10,%esp
}
  8004b2:	90                   	nop
  8004b3:	c9                   	leave  
  8004b4:	c3                   	ret    

008004b5 <exit>:

void
exit(void)
{
  8004b5:	55                   	push   %ebp
  8004b6:	89 e5                	mov    %esp,%ebp
  8004b8:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8004bb:	e8 a4 13 00 00       	call   801864 <sys_env_exit>
}
  8004c0:	90                   	nop
  8004c1:	c9                   	leave  
  8004c2:	c3                   	ret    

008004c3 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004c3:	55                   	push   %ebp
  8004c4:	89 e5                	mov    %esp,%ebp
  8004c6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004c9:	8d 45 10             	lea    0x10(%ebp),%eax
  8004cc:	83 c0 04             	add    $0x4,%eax
  8004cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004d2:	a1 30 30 80 00       	mov    0x803030,%eax
  8004d7:	85 c0                	test   %eax,%eax
  8004d9:	74 16                	je     8004f1 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004db:	a1 30 30 80 00       	mov    0x803030,%eax
  8004e0:	83 ec 08             	sub    $0x8,%esp
  8004e3:	50                   	push   %eax
  8004e4:	68 8c 25 80 00       	push   $0x80258c
  8004e9:	e8 89 02 00 00       	call   800777 <cprintf>
  8004ee:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004f1:	a1 00 30 80 00       	mov    0x803000,%eax
  8004f6:	ff 75 0c             	pushl  0xc(%ebp)
  8004f9:	ff 75 08             	pushl  0x8(%ebp)
  8004fc:	50                   	push   %eax
  8004fd:	68 91 25 80 00       	push   $0x802591
  800502:	e8 70 02 00 00       	call   800777 <cprintf>
  800507:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80050a:	8b 45 10             	mov    0x10(%ebp),%eax
  80050d:	83 ec 08             	sub    $0x8,%esp
  800510:	ff 75 f4             	pushl  -0xc(%ebp)
  800513:	50                   	push   %eax
  800514:	e8 f3 01 00 00       	call   80070c <vcprintf>
  800519:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80051c:	83 ec 08             	sub    $0x8,%esp
  80051f:	6a 00                	push   $0x0
  800521:	68 ad 25 80 00       	push   $0x8025ad
  800526:	e8 e1 01 00 00       	call   80070c <vcprintf>
  80052b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80052e:	e8 82 ff ff ff       	call   8004b5 <exit>

	// should not return here
	while (1) ;
  800533:	eb fe                	jmp    800533 <_panic+0x70>

00800535 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800535:	55                   	push   %ebp
  800536:	89 e5                	mov    %esp,%ebp
  800538:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80053b:	a1 20 30 80 00       	mov    0x803020,%eax
  800540:	8b 50 74             	mov    0x74(%eax),%edx
  800543:	8b 45 0c             	mov    0xc(%ebp),%eax
  800546:	39 c2                	cmp    %eax,%edx
  800548:	74 14                	je     80055e <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80054a:	83 ec 04             	sub    $0x4,%esp
  80054d:	68 b0 25 80 00       	push   $0x8025b0
  800552:	6a 26                	push   $0x26
  800554:	68 fc 25 80 00       	push   $0x8025fc
  800559:	e8 65 ff ff ff       	call   8004c3 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80055e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800565:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80056c:	e9 c2 00 00 00       	jmp    800633 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800571:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800574:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80057b:	8b 45 08             	mov    0x8(%ebp),%eax
  80057e:	01 d0                	add    %edx,%eax
  800580:	8b 00                	mov    (%eax),%eax
  800582:	85 c0                	test   %eax,%eax
  800584:	75 08                	jne    80058e <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800586:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800589:	e9 a2 00 00 00       	jmp    800630 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80058e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800595:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80059c:	eb 69                	jmp    800607 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80059e:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a3:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8005a9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005ac:	89 d0                	mov    %edx,%eax
  8005ae:	01 c0                	add    %eax,%eax
  8005b0:	01 d0                	add    %edx,%eax
  8005b2:	c1 e0 02             	shl    $0x2,%eax
  8005b5:	01 c8                	add    %ecx,%eax
  8005b7:	8a 40 04             	mov    0x4(%eax),%al
  8005ba:	84 c0                	test   %al,%al
  8005bc:	75 46                	jne    800604 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005be:	a1 20 30 80 00       	mov    0x803020,%eax
  8005c3:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8005c9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005cc:	89 d0                	mov    %edx,%eax
  8005ce:	01 c0                	add    %eax,%eax
  8005d0:	01 d0                	add    %edx,%eax
  8005d2:	c1 e0 02             	shl    $0x2,%eax
  8005d5:	01 c8                	add    %ecx,%eax
  8005d7:	8b 00                	mov    (%eax),%eax
  8005d9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005dc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005df:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005e4:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005e9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f3:	01 c8                	add    %ecx,%eax
  8005f5:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005f7:	39 c2                	cmp    %eax,%edx
  8005f9:	75 09                	jne    800604 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8005fb:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800602:	eb 12                	jmp    800616 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800604:	ff 45 e8             	incl   -0x18(%ebp)
  800607:	a1 20 30 80 00       	mov    0x803020,%eax
  80060c:	8b 50 74             	mov    0x74(%eax),%edx
  80060f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800612:	39 c2                	cmp    %eax,%edx
  800614:	77 88                	ja     80059e <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800616:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80061a:	75 14                	jne    800630 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80061c:	83 ec 04             	sub    $0x4,%esp
  80061f:	68 08 26 80 00       	push   $0x802608
  800624:	6a 3a                	push   $0x3a
  800626:	68 fc 25 80 00       	push   $0x8025fc
  80062b:	e8 93 fe ff ff       	call   8004c3 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800630:	ff 45 f0             	incl   -0x10(%ebp)
  800633:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800636:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800639:	0f 8c 32 ff ff ff    	jl     800571 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80063f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800646:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80064d:	eb 26                	jmp    800675 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80064f:	a1 20 30 80 00       	mov    0x803020,%eax
  800654:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80065a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80065d:	89 d0                	mov    %edx,%eax
  80065f:	01 c0                	add    %eax,%eax
  800661:	01 d0                	add    %edx,%eax
  800663:	c1 e0 02             	shl    $0x2,%eax
  800666:	01 c8                	add    %ecx,%eax
  800668:	8a 40 04             	mov    0x4(%eax),%al
  80066b:	3c 01                	cmp    $0x1,%al
  80066d:	75 03                	jne    800672 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80066f:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800672:	ff 45 e0             	incl   -0x20(%ebp)
  800675:	a1 20 30 80 00       	mov    0x803020,%eax
  80067a:	8b 50 74             	mov    0x74(%eax),%edx
  80067d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800680:	39 c2                	cmp    %eax,%edx
  800682:	77 cb                	ja     80064f <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800684:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800687:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80068a:	74 14                	je     8006a0 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80068c:	83 ec 04             	sub    $0x4,%esp
  80068f:	68 5c 26 80 00       	push   $0x80265c
  800694:	6a 44                	push   $0x44
  800696:	68 fc 25 80 00       	push   $0x8025fc
  80069b:	e8 23 fe ff ff       	call   8004c3 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8006a0:	90                   	nop
  8006a1:	c9                   	leave  
  8006a2:	c3                   	ret    

008006a3 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8006a3:	55                   	push   %ebp
  8006a4:	89 e5                	mov    %esp,%ebp
  8006a6:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8006a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ac:	8b 00                	mov    (%eax),%eax
  8006ae:	8d 48 01             	lea    0x1(%eax),%ecx
  8006b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006b4:	89 0a                	mov    %ecx,(%edx)
  8006b6:	8b 55 08             	mov    0x8(%ebp),%edx
  8006b9:	88 d1                	mov    %dl,%cl
  8006bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006be:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006c5:	8b 00                	mov    (%eax),%eax
  8006c7:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006cc:	75 2c                	jne    8006fa <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8006ce:	a0 24 30 80 00       	mov    0x803024,%al
  8006d3:	0f b6 c0             	movzbl %al,%eax
  8006d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006d9:	8b 12                	mov    (%edx),%edx
  8006db:	89 d1                	mov    %edx,%ecx
  8006dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006e0:	83 c2 08             	add    $0x8,%edx
  8006e3:	83 ec 04             	sub    $0x4,%esp
  8006e6:	50                   	push   %eax
  8006e7:	51                   	push   %ecx
  8006e8:	52                   	push   %edx
  8006e9:	e8 ce 10 00 00       	call   8017bc <sys_cputs>
  8006ee:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006f4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006fd:	8b 40 04             	mov    0x4(%eax),%eax
  800700:	8d 50 01             	lea    0x1(%eax),%edx
  800703:	8b 45 0c             	mov    0xc(%ebp),%eax
  800706:	89 50 04             	mov    %edx,0x4(%eax)
}
  800709:	90                   	nop
  80070a:	c9                   	leave  
  80070b:	c3                   	ret    

0080070c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80070c:	55                   	push   %ebp
  80070d:	89 e5                	mov    %esp,%ebp
  80070f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800715:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80071c:	00 00 00 
	b.cnt = 0;
  80071f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800726:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800729:	ff 75 0c             	pushl  0xc(%ebp)
  80072c:	ff 75 08             	pushl  0x8(%ebp)
  80072f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800735:	50                   	push   %eax
  800736:	68 a3 06 80 00       	push   $0x8006a3
  80073b:	e8 11 02 00 00       	call   800951 <vprintfmt>
  800740:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800743:	a0 24 30 80 00       	mov    0x803024,%al
  800748:	0f b6 c0             	movzbl %al,%eax
  80074b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800751:	83 ec 04             	sub    $0x4,%esp
  800754:	50                   	push   %eax
  800755:	52                   	push   %edx
  800756:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80075c:	83 c0 08             	add    $0x8,%eax
  80075f:	50                   	push   %eax
  800760:	e8 57 10 00 00       	call   8017bc <sys_cputs>
  800765:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800768:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80076f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800775:	c9                   	leave  
  800776:	c3                   	ret    

00800777 <cprintf>:

int cprintf(const char *fmt, ...) {
  800777:	55                   	push   %ebp
  800778:	89 e5                	mov    %esp,%ebp
  80077a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80077d:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800784:	8d 45 0c             	lea    0xc(%ebp),%eax
  800787:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80078a:	8b 45 08             	mov    0x8(%ebp),%eax
  80078d:	83 ec 08             	sub    $0x8,%esp
  800790:	ff 75 f4             	pushl  -0xc(%ebp)
  800793:	50                   	push   %eax
  800794:	e8 73 ff ff ff       	call   80070c <vcprintf>
  800799:	83 c4 10             	add    $0x10,%esp
  80079c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80079f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007a2:	c9                   	leave  
  8007a3:	c3                   	ret    

008007a4 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8007a4:	55                   	push   %ebp
  8007a5:	89 e5                	mov    %esp,%ebp
  8007a7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007aa:	e8 1e 12 00 00       	call   8019cd <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8007af:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b8:	83 ec 08             	sub    $0x8,%esp
  8007bb:	ff 75 f4             	pushl  -0xc(%ebp)
  8007be:	50                   	push   %eax
  8007bf:	e8 48 ff ff ff       	call   80070c <vcprintf>
  8007c4:	83 c4 10             	add    $0x10,%esp
  8007c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8007ca:	e8 18 12 00 00       	call   8019e7 <sys_enable_interrupt>
	return cnt;
  8007cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007d2:	c9                   	leave  
  8007d3:	c3                   	ret    

008007d4 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007d4:	55                   	push   %ebp
  8007d5:	89 e5                	mov    %esp,%ebp
  8007d7:	53                   	push   %ebx
  8007d8:	83 ec 14             	sub    $0x14,%esp
  8007db:	8b 45 10             	mov    0x10(%ebp),%eax
  8007de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007e7:	8b 45 18             	mov    0x18(%ebp),%eax
  8007ea:	ba 00 00 00 00       	mov    $0x0,%edx
  8007ef:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007f2:	77 55                	ja     800849 <printnum+0x75>
  8007f4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007f7:	72 05                	jb     8007fe <printnum+0x2a>
  8007f9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007fc:	77 4b                	ja     800849 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007fe:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800801:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800804:	8b 45 18             	mov    0x18(%ebp),%eax
  800807:	ba 00 00 00 00       	mov    $0x0,%edx
  80080c:	52                   	push   %edx
  80080d:	50                   	push   %eax
  80080e:	ff 75 f4             	pushl  -0xc(%ebp)
  800811:	ff 75 f0             	pushl  -0x10(%ebp)
  800814:	e8 47 16 00 00       	call   801e60 <__udivdi3>
  800819:	83 c4 10             	add    $0x10,%esp
  80081c:	83 ec 04             	sub    $0x4,%esp
  80081f:	ff 75 20             	pushl  0x20(%ebp)
  800822:	53                   	push   %ebx
  800823:	ff 75 18             	pushl  0x18(%ebp)
  800826:	52                   	push   %edx
  800827:	50                   	push   %eax
  800828:	ff 75 0c             	pushl  0xc(%ebp)
  80082b:	ff 75 08             	pushl  0x8(%ebp)
  80082e:	e8 a1 ff ff ff       	call   8007d4 <printnum>
  800833:	83 c4 20             	add    $0x20,%esp
  800836:	eb 1a                	jmp    800852 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800838:	83 ec 08             	sub    $0x8,%esp
  80083b:	ff 75 0c             	pushl  0xc(%ebp)
  80083e:	ff 75 20             	pushl  0x20(%ebp)
  800841:	8b 45 08             	mov    0x8(%ebp),%eax
  800844:	ff d0                	call   *%eax
  800846:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800849:	ff 4d 1c             	decl   0x1c(%ebp)
  80084c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800850:	7f e6                	jg     800838 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800852:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800855:	bb 00 00 00 00       	mov    $0x0,%ebx
  80085a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80085d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800860:	53                   	push   %ebx
  800861:	51                   	push   %ecx
  800862:	52                   	push   %edx
  800863:	50                   	push   %eax
  800864:	e8 07 17 00 00       	call   801f70 <__umoddi3>
  800869:	83 c4 10             	add    $0x10,%esp
  80086c:	05 d4 28 80 00       	add    $0x8028d4,%eax
  800871:	8a 00                	mov    (%eax),%al
  800873:	0f be c0             	movsbl %al,%eax
  800876:	83 ec 08             	sub    $0x8,%esp
  800879:	ff 75 0c             	pushl  0xc(%ebp)
  80087c:	50                   	push   %eax
  80087d:	8b 45 08             	mov    0x8(%ebp),%eax
  800880:	ff d0                	call   *%eax
  800882:	83 c4 10             	add    $0x10,%esp
}
  800885:	90                   	nop
  800886:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800889:	c9                   	leave  
  80088a:	c3                   	ret    

0080088b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80088b:	55                   	push   %ebp
  80088c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80088e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800892:	7e 1c                	jle    8008b0 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800894:	8b 45 08             	mov    0x8(%ebp),%eax
  800897:	8b 00                	mov    (%eax),%eax
  800899:	8d 50 08             	lea    0x8(%eax),%edx
  80089c:	8b 45 08             	mov    0x8(%ebp),%eax
  80089f:	89 10                	mov    %edx,(%eax)
  8008a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a4:	8b 00                	mov    (%eax),%eax
  8008a6:	83 e8 08             	sub    $0x8,%eax
  8008a9:	8b 50 04             	mov    0x4(%eax),%edx
  8008ac:	8b 00                	mov    (%eax),%eax
  8008ae:	eb 40                	jmp    8008f0 <getuint+0x65>
	else if (lflag)
  8008b0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008b4:	74 1e                	je     8008d4 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8008b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b9:	8b 00                	mov    (%eax),%eax
  8008bb:	8d 50 04             	lea    0x4(%eax),%edx
  8008be:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c1:	89 10                	mov    %edx,(%eax)
  8008c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c6:	8b 00                	mov    (%eax),%eax
  8008c8:	83 e8 04             	sub    $0x4,%eax
  8008cb:	8b 00                	mov    (%eax),%eax
  8008cd:	ba 00 00 00 00       	mov    $0x0,%edx
  8008d2:	eb 1c                	jmp    8008f0 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d7:	8b 00                	mov    (%eax),%eax
  8008d9:	8d 50 04             	lea    0x4(%eax),%edx
  8008dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008df:	89 10                	mov    %edx,(%eax)
  8008e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e4:	8b 00                	mov    (%eax),%eax
  8008e6:	83 e8 04             	sub    $0x4,%eax
  8008e9:	8b 00                	mov    (%eax),%eax
  8008eb:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008f0:	5d                   	pop    %ebp
  8008f1:	c3                   	ret    

008008f2 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008f2:	55                   	push   %ebp
  8008f3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008f5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008f9:	7e 1c                	jle    800917 <getint+0x25>
		return va_arg(*ap, long long);
  8008fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fe:	8b 00                	mov    (%eax),%eax
  800900:	8d 50 08             	lea    0x8(%eax),%edx
  800903:	8b 45 08             	mov    0x8(%ebp),%eax
  800906:	89 10                	mov    %edx,(%eax)
  800908:	8b 45 08             	mov    0x8(%ebp),%eax
  80090b:	8b 00                	mov    (%eax),%eax
  80090d:	83 e8 08             	sub    $0x8,%eax
  800910:	8b 50 04             	mov    0x4(%eax),%edx
  800913:	8b 00                	mov    (%eax),%eax
  800915:	eb 38                	jmp    80094f <getint+0x5d>
	else if (lflag)
  800917:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80091b:	74 1a                	je     800937 <getint+0x45>
		return va_arg(*ap, long);
  80091d:	8b 45 08             	mov    0x8(%ebp),%eax
  800920:	8b 00                	mov    (%eax),%eax
  800922:	8d 50 04             	lea    0x4(%eax),%edx
  800925:	8b 45 08             	mov    0x8(%ebp),%eax
  800928:	89 10                	mov    %edx,(%eax)
  80092a:	8b 45 08             	mov    0x8(%ebp),%eax
  80092d:	8b 00                	mov    (%eax),%eax
  80092f:	83 e8 04             	sub    $0x4,%eax
  800932:	8b 00                	mov    (%eax),%eax
  800934:	99                   	cltd   
  800935:	eb 18                	jmp    80094f <getint+0x5d>
	else
		return va_arg(*ap, int);
  800937:	8b 45 08             	mov    0x8(%ebp),%eax
  80093a:	8b 00                	mov    (%eax),%eax
  80093c:	8d 50 04             	lea    0x4(%eax),%edx
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	89 10                	mov    %edx,(%eax)
  800944:	8b 45 08             	mov    0x8(%ebp),%eax
  800947:	8b 00                	mov    (%eax),%eax
  800949:	83 e8 04             	sub    $0x4,%eax
  80094c:	8b 00                	mov    (%eax),%eax
  80094e:	99                   	cltd   
}
  80094f:	5d                   	pop    %ebp
  800950:	c3                   	ret    

00800951 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800951:	55                   	push   %ebp
  800952:	89 e5                	mov    %esp,%ebp
  800954:	56                   	push   %esi
  800955:	53                   	push   %ebx
  800956:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800959:	eb 17                	jmp    800972 <vprintfmt+0x21>
			if (ch == '\0')
  80095b:	85 db                	test   %ebx,%ebx
  80095d:	0f 84 af 03 00 00    	je     800d12 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800963:	83 ec 08             	sub    $0x8,%esp
  800966:	ff 75 0c             	pushl  0xc(%ebp)
  800969:	53                   	push   %ebx
  80096a:	8b 45 08             	mov    0x8(%ebp),%eax
  80096d:	ff d0                	call   *%eax
  80096f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800972:	8b 45 10             	mov    0x10(%ebp),%eax
  800975:	8d 50 01             	lea    0x1(%eax),%edx
  800978:	89 55 10             	mov    %edx,0x10(%ebp)
  80097b:	8a 00                	mov    (%eax),%al
  80097d:	0f b6 d8             	movzbl %al,%ebx
  800980:	83 fb 25             	cmp    $0x25,%ebx
  800983:	75 d6                	jne    80095b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800985:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800989:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800990:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800997:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80099e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8009a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8009a8:	8d 50 01             	lea    0x1(%eax),%edx
  8009ab:	89 55 10             	mov    %edx,0x10(%ebp)
  8009ae:	8a 00                	mov    (%eax),%al
  8009b0:	0f b6 d8             	movzbl %al,%ebx
  8009b3:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8009b6:	83 f8 55             	cmp    $0x55,%eax
  8009b9:	0f 87 2b 03 00 00    	ja     800cea <vprintfmt+0x399>
  8009bf:	8b 04 85 f8 28 80 00 	mov    0x8028f8(,%eax,4),%eax
  8009c6:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009c8:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8009cc:	eb d7                	jmp    8009a5 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8009ce:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009d2:	eb d1                	jmp    8009a5 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009d4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009db:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009de:	89 d0                	mov    %edx,%eax
  8009e0:	c1 e0 02             	shl    $0x2,%eax
  8009e3:	01 d0                	add    %edx,%eax
  8009e5:	01 c0                	add    %eax,%eax
  8009e7:	01 d8                	add    %ebx,%eax
  8009e9:	83 e8 30             	sub    $0x30,%eax
  8009ec:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f2:	8a 00                	mov    (%eax),%al
  8009f4:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009f7:	83 fb 2f             	cmp    $0x2f,%ebx
  8009fa:	7e 3e                	jle    800a3a <vprintfmt+0xe9>
  8009fc:	83 fb 39             	cmp    $0x39,%ebx
  8009ff:	7f 39                	jg     800a3a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a01:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a04:	eb d5                	jmp    8009db <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a06:	8b 45 14             	mov    0x14(%ebp),%eax
  800a09:	83 c0 04             	add    $0x4,%eax
  800a0c:	89 45 14             	mov    %eax,0x14(%ebp)
  800a0f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a12:	83 e8 04             	sub    $0x4,%eax
  800a15:	8b 00                	mov    (%eax),%eax
  800a17:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a1a:	eb 1f                	jmp    800a3b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a1c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a20:	79 83                	jns    8009a5 <vprintfmt+0x54>
				width = 0;
  800a22:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a29:	e9 77 ff ff ff       	jmp    8009a5 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a2e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a35:	e9 6b ff ff ff       	jmp    8009a5 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a3a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a3b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a3f:	0f 89 60 ff ff ff    	jns    8009a5 <vprintfmt+0x54>
				width = precision, precision = -1;
  800a45:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a48:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a4b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a52:	e9 4e ff ff ff       	jmp    8009a5 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a57:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a5a:	e9 46 ff ff ff       	jmp    8009a5 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a5f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a62:	83 c0 04             	add    $0x4,%eax
  800a65:	89 45 14             	mov    %eax,0x14(%ebp)
  800a68:	8b 45 14             	mov    0x14(%ebp),%eax
  800a6b:	83 e8 04             	sub    $0x4,%eax
  800a6e:	8b 00                	mov    (%eax),%eax
  800a70:	83 ec 08             	sub    $0x8,%esp
  800a73:	ff 75 0c             	pushl  0xc(%ebp)
  800a76:	50                   	push   %eax
  800a77:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7a:	ff d0                	call   *%eax
  800a7c:	83 c4 10             	add    $0x10,%esp
			break;
  800a7f:	e9 89 02 00 00       	jmp    800d0d <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a84:	8b 45 14             	mov    0x14(%ebp),%eax
  800a87:	83 c0 04             	add    $0x4,%eax
  800a8a:	89 45 14             	mov    %eax,0x14(%ebp)
  800a8d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a90:	83 e8 04             	sub    $0x4,%eax
  800a93:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a95:	85 db                	test   %ebx,%ebx
  800a97:	79 02                	jns    800a9b <vprintfmt+0x14a>
				err = -err;
  800a99:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a9b:	83 fb 64             	cmp    $0x64,%ebx
  800a9e:	7f 0b                	jg     800aab <vprintfmt+0x15a>
  800aa0:	8b 34 9d 40 27 80 00 	mov    0x802740(,%ebx,4),%esi
  800aa7:	85 f6                	test   %esi,%esi
  800aa9:	75 19                	jne    800ac4 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800aab:	53                   	push   %ebx
  800aac:	68 e5 28 80 00       	push   $0x8028e5
  800ab1:	ff 75 0c             	pushl  0xc(%ebp)
  800ab4:	ff 75 08             	pushl  0x8(%ebp)
  800ab7:	e8 5e 02 00 00       	call   800d1a <printfmt>
  800abc:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800abf:	e9 49 02 00 00       	jmp    800d0d <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ac4:	56                   	push   %esi
  800ac5:	68 ee 28 80 00       	push   $0x8028ee
  800aca:	ff 75 0c             	pushl  0xc(%ebp)
  800acd:	ff 75 08             	pushl  0x8(%ebp)
  800ad0:	e8 45 02 00 00       	call   800d1a <printfmt>
  800ad5:	83 c4 10             	add    $0x10,%esp
			break;
  800ad8:	e9 30 02 00 00       	jmp    800d0d <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800add:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae0:	83 c0 04             	add    $0x4,%eax
  800ae3:	89 45 14             	mov    %eax,0x14(%ebp)
  800ae6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae9:	83 e8 04             	sub    $0x4,%eax
  800aec:	8b 30                	mov    (%eax),%esi
  800aee:	85 f6                	test   %esi,%esi
  800af0:	75 05                	jne    800af7 <vprintfmt+0x1a6>
				p = "(null)";
  800af2:	be f1 28 80 00       	mov    $0x8028f1,%esi
			if (width > 0 && padc != '-')
  800af7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800afb:	7e 6d                	jle    800b6a <vprintfmt+0x219>
  800afd:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b01:	74 67                	je     800b6a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b03:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b06:	83 ec 08             	sub    $0x8,%esp
  800b09:	50                   	push   %eax
  800b0a:	56                   	push   %esi
  800b0b:	e8 0c 03 00 00       	call   800e1c <strnlen>
  800b10:	83 c4 10             	add    $0x10,%esp
  800b13:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b16:	eb 16                	jmp    800b2e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b18:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b1c:	83 ec 08             	sub    $0x8,%esp
  800b1f:	ff 75 0c             	pushl  0xc(%ebp)
  800b22:	50                   	push   %eax
  800b23:	8b 45 08             	mov    0x8(%ebp),%eax
  800b26:	ff d0                	call   *%eax
  800b28:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b2b:	ff 4d e4             	decl   -0x1c(%ebp)
  800b2e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b32:	7f e4                	jg     800b18 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b34:	eb 34                	jmp    800b6a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b36:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b3a:	74 1c                	je     800b58 <vprintfmt+0x207>
  800b3c:	83 fb 1f             	cmp    $0x1f,%ebx
  800b3f:	7e 05                	jle    800b46 <vprintfmt+0x1f5>
  800b41:	83 fb 7e             	cmp    $0x7e,%ebx
  800b44:	7e 12                	jle    800b58 <vprintfmt+0x207>
					putch('?', putdat);
  800b46:	83 ec 08             	sub    $0x8,%esp
  800b49:	ff 75 0c             	pushl  0xc(%ebp)
  800b4c:	6a 3f                	push   $0x3f
  800b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b51:	ff d0                	call   *%eax
  800b53:	83 c4 10             	add    $0x10,%esp
  800b56:	eb 0f                	jmp    800b67 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b58:	83 ec 08             	sub    $0x8,%esp
  800b5b:	ff 75 0c             	pushl  0xc(%ebp)
  800b5e:	53                   	push   %ebx
  800b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b62:	ff d0                	call   *%eax
  800b64:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b67:	ff 4d e4             	decl   -0x1c(%ebp)
  800b6a:	89 f0                	mov    %esi,%eax
  800b6c:	8d 70 01             	lea    0x1(%eax),%esi
  800b6f:	8a 00                	mov    (%eax),%al
  800b71:	0f be d8             	movsbl %al,%ebx
  800b74:	85 db                	test   %ebx,%ebx
  800b76:	74 24                	je     800b9c <vprintfmt+0x24b>
  800b78:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b7c:	78 b8                	js     800b36 <vprintfmt+0x1e5>
  800b7e:	ff 4d e0             	decl   -0x20(%ebp)
  800b81:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b85:	79 af                	jns    800b36 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b87:	eb 13                	jmp    800b9c <vprintfmt+0x24b>
				putch(' ', putdat);
  800b89:	83 ec 08             	sub    $0x8,%esp
  800b8c:	ff 75 0c             	pushl  0xc(%ebp)
  800b8f:	6a 20                	push   $0x20
  800b91:	8b 45 08             	mov    0x8(%ebp),%eax
  800b94:	ff d0                	call   *%eax
  800b96:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b99:	ff 4d e4             	decl   -0x1c(%ebp)
  800b9c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ba0:	7f e7                	jg     800b89 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ba2:	e9 66 01 00 00       	jmp    800d0d <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ba7:	83 ec 08             	sub    $0x8,%esp
  800baa:	ff 75 e8             	pushl  -0x18(%ebp)
  800bad:	8d 45 14             	lea    0x14(%ebp),%eax
  800bb0:	50                   	push   %eax
  800bb1:	e8 3c fd ff ff       	call   8008f2 <getint>
  800bb6:	83 c4 10             	add    $0x10,%esp
  800bb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bbc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800bbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bc2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bc5:	85 d2                	test   %edx,%edx
  800bc7:	79 23                	jns    800bec <vprintfmt+0x29b>
				putch('-', putdat);
  800bc9:	83 ec 08             	sub    $0x8,%esp
  800bcc:	ff 75 0c             	pushl  0xc(%ebp)
  800bcf:	6a 2d                	push   $0x2d
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	ff d0                	call   *%eax
  800bd6:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800bd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bdc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bdf:	f7 d8                	neg    %eax
  800be1:	83 d2 00             	adc    $0x0,%edx
  800be4:	f7 da                	neg    %edx
  800be6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800be9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bec:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bf3:	e9 bc 00 00 00       	jmp    800cb4 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800bf8:	83 ec 08             	sub    $0x8,%esp
  800bfb:	ff 75 e8             	pushl  -0x18(%ebp)
  800bfe:	8d 45 14             	lea    0x14(%ebp),%eax
  800c01:	50                   	push   %eax
  800c02:	e8 84 fc ff ff       	call   80088b <getuint>
  800c07:	83 c4 10             	add    $0x10,%esp
  800c0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c0d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c10:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c17:	e9 98 00 00 00       	jmp    800cb4 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c1c:	83 ec 08             	sub    $0x8,%esp
  800c1f:	ff 75 0c             	pushl  0xc(%ebp)
  800c22:	6a 58                	push   $0x58
  800c24:	8b 45 08             	mov    0x8(%ebp),%eax
  800c27:	ff d0                	call   *%eax
  800c29:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c2c:	83 ec 08             	sub    $0x8,%esp
  800c2f:	ff 75 0c             	pushl  0xc(%ebp)
  800c32:	6a 58                	push   $0x58
  800c34:	8b 45 08             	mov    0x8(%ebp),%eax
  800c37:	ff d0                	call   *%eax
  800c39:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c3c:	83 ec 08             	sub    $0x8,%esp
  800c3f:	ff 75 0c             	pushl  0xc(%ebp)
  800c42:	6a 58                	push   $0x58
  800c44:	8b 45 08             	mov    0x8(%ebp),%eax
  800c47:	ff d0                	call   *%eax
  800c49:	83 c4 10             	add    $0x10,%esp
			break;
  800c4c:	e9 bc 00 00 00       	jmp    800d0d <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c51:	83 ec 08             	sub    $0x8,%esp
  800c54:	ff 75 0c             	pushl  0xc(%ebp)
  800c57:	6a 30                	push   $0x30
  800c59:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5c:	ff d0                	call   *%eax
  800c5e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c61:	83 ec 08             	sub    $0x8,%esp
  800c64:	ff 75 0c             	pushl  0xc(%ebp)
  800c67:	6a 78                	push   $0x78
  800c69:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6c:	ff d0                	call   *%eax
  800c6e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c71:	8b 45 14             	mov    0x14(%ebp),%eax
  800c74:	83 c0 04             	add    $0x4,%eax
  800c77:	89 45 14             	mov    %eax,0x14(%ebp)
  800c7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c7d:	83 e8 04             	sub    $0x4,%eax
  800c80:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c82:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c85:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c8c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c93:	eb 1f                	jmp    800cb4 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c95:	83 ec 08             	sub    $0x8,%esp
  800c98:	ff 75 e8             	pushl  -0x18(%ebp)
  800c9b:	8d 45 14             	lea    0x14(%ebp),%eax
  800c9e:	50                   	push   %eax
  800c9f:	e8 e7 fb ff ff       	call   80088b <getuint>
  800ca4:	83 c4 10             	add    $0x10,%esp
  800ca7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800caa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800cad:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800cb4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800cb8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cbb:	83 ec 04             	sub    $0x4,%esp
  800cbe:	52                   	push   %edx
  800cbf:	ff 75 e4             	pushl  -0x1c(%ebp)
  800cc2:	50                   	push   %eax
  800cc3:	ff 75 f4             	pushl  -0xc(%ebp)
  800cc6:	ff 75 f0             	pushl  -0x10(%ebp)
  800cc9:	ff 75 0c             	pushl  0xc(%ebp)
  800ccc:	ff 75 08             	pushl  0x8(%ebp)
  800ccf:	e8 00 fb ff ff       	call   8007d4 <printnum>
  800cd4:	83 c4 20             	add    $0x20,%esp
			break;
  800cd7:	eb 34                	jmp    800d0d <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800cd9:	83 ec 08             	sub    $0x8,%esp
  800cdc:	ff 75 0c             	pushl  0xc(%ebp)
  800cdf:	53                   	push   %ebx
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	ff d0                	call   *%eax
  800ce5:	83 c4 10             	add    $0x10,%esp
			break;
  800ce8:	eb 23                	jmp    800d0d <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cea:	83 ec 08             	sub    $0x8,%esp
  800ced:	ff 75 0c             	pushl  0xc(%ebp)
  800cf0:	6a 25                	push   $0x25
  800cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf5:	ff d0                	call   *%eax
  800cf7:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800cfa:	ff 4d 10             	decl   0x10(%ebp)
  800cfd:	eb 03                	jmp    800d02 <vprintfmt+0x3b1>
  800cff:	ff 4d 10             	decl   0x10(%ebp)
  800d02:	8b 45 10             	mov    0x10(%ebp),%eax
  800d05:	48                   	dec    %eax
  800d06:	8a 00                	mov    (%eax),%al
  800d08:	3c 25                	cmp    $0x25,%al
  800d0a:	75 f3                	jne    800cff <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800d0c:	90                   	nop
		}
	}
  800d0d:	e9 47 fc ff ff       	jmp    800959 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d12:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d13:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d16:	5b                   	pop    %ebx
  800d17:	5e                   	pop    %esi
  800d18:	5d                   	pop    %ebp
  800d19:	c3                   	ret    

00800d1a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d1a:	55                   	push   %ebp
  800d1b:	89 e5                	mov    %esp,%ebp
  800d1d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d20:	8d 45 10             	lea    0x10(%ebp),%eax
  800d23:	83 c0 04             	add    $0x4,%eax
  800d26:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d29:	8b 45 10             	mov    0x10(%ebp),%eax
  800d2c:	ff 75 f4             	pushl  -0xc(%ebp)
  800d2f:	50                   	push   %eax
  800d30:	ff 75 0c             	pushl  0xc(%ebp)
  800d33:	ff 75 08             	pushl  0x8(%ebp)
  800d36:	e8 16 fc ff ff       	call   800951 <vprintfmt>
  800d3b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d3e:	90                   	nop
  800d3f:	c9                   	leave  
  800d40:	c3                   	ret    

00800d41 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d41:	55                   	push   %ebp
  800d42:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d47:	8b 40 08             	mov    0x8(%eax),%eax
  800d4a:	8d 50 01             	lea    0x1(%eax),%edx
  800d4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d50:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d56:	8b 10                	mov    (%eax),%edx
  800d58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5b:	8b 40 04             	mov    0x4(%eax),%eax
  800d5e:	39 c2                	cmp    %eax,%edx
  800d60:	73 12                	jae    800d74 <sprintputch+0x33>
		*b->buf++ = ch;
  800d62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d65:	8b 00                	mov    (%eax),%eax
  800d67:	8d 48 01             	lea    0x1(%eax),%ecx
  800d6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d6d:	89 0a                	mov    %ecx,(%edx)
  800d6f:	8b 55 08             	mov    0x8(%ebp),%edx
  800d72:	88 10                	mov    %dl,(%eax)
}
  800d74:	90                   	nop
  800d75:	5d                   	pop    %ebp
  800d76:	c3                   	ret    

00800d77 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d77:	55                   	push   %ebp
  800d78:	89 e5                	mov    %esp,%ebp
  800d7a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d80:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d86:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8c:	01 d0                	add    %edx,%eax
  800d8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d91:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d98:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d9c:	74 06                	je     800da4 <vsnprintf+0x2d>
  800d9e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800da2:	7f 07                	jg     800dab <vsnprintf+0x34>
		return -E_INVAL;
  800da4:	b8 03 00 00 00       	mov    $0x3,%eax
  800da9:	eb 20                	jmp    800dcb <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800dab:	ff 75 14             	pushl  0x14(%ebp)
  800dae:	ff 75 10             	pushl  0x10(%ebp)
  800db1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800db4:	50                   	push   %eax
  800db5:	68 41 0d 80 00       	push   $0x800d41
  800dba:	e8 92 fb ff ff       	call   800951 <vprintfmt>
  800dbf:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800dc2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800dc5:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800dc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800dcb:	c9                   	leave  
  800dcc:	c3                   	ret    

00800dcd <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800dcd:	55                   	push   %ebp
  800dce:	89 e5                	mov    %esp,%ebp
  800dd0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800dd3:	8d 45 10             	lea    0x10(%ebp),%eax
  800dd6:	83 c0 04             	add    $0x4,%eax
  800dd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ddc:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddf:	ff 75 f4             	pushl  -0xc(%ebp)
  800de2:	50                   	push   %eax
  800de3:	ff 75 0c             	pushl  0xc(%ebp)
  800de6:	ff 75 08             	pushl  0x8(%ebp)
  800de9:	e8 89 ff ff ff       	call   800d77 <vsnprintf>
  800dee:	83 c4 10             	add    $0x10,%esp
  800df1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800df4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800df7:	c9                   	leave  
  800df8:	c3                   	ret    

00800df9 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800df9:	55                   	push   %ebp
  800dfa:	89 e5                	mov    %esp,%ebp
  800dfc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800dff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e06:	eb 06                	jmp    800e0e <strlen+0x15>
		n++;
  800e08:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e0b:	ff 45 08             	incl   0x8(%ebp)
  800e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e11:	8a 00                	mov    (%eax),%al
  800e13:	84 c0                	test   %al,%al
  800e15:	75 f1                	jne    800e08 <strlen+0xf>
		n++;
	return n;
  800e17:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e1a:	c9                   	leave  
  800e1b:	c3                   	ret    

00800e1c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e1c:	55                   	push   %ebp
  800e1d:	89 e5                	mov    %esp,%ebp
  800e1f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e22:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e29:	eb 09                	jmp    800e34 <strnlen+0x18>
		n++;
  800e2b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e2e:	ff 45 08             	incl   0x8(%ebp)
  800e31:	ff 4d 0c             	decl   0xc(%ebp)
  800e34:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e38:	74 09                	je     800e43 <strnlen+0x27>
  800e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3d:	8a 00                	mov    (%eax),%al
  800e3f:	84 c0                	test   %al,%al
  800e41:	75 e8                	jne    800e2b <strnlen+0xf>
		n++;
	return n;
  800e43:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e46:	c9                   	leave  
  800e47:	c3                   	ret    

00800e48 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e48:	55                   	push   %ebp
  800e49:	89 e5                	mov    %esp,%ebp
  800e4b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e51:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e54:	90                   	nop
  800e55:	8b 45 08             	mov    0x8(%ebp),%eax
  800e58:	8d 50 01             	lea    0x1(%eax),%edx
  800e5b:	89 55 08             	mov    %edx,0x8(%ebp)
  800e5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e61:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e64:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e67:	8a 12                	mov    (%edx),%dl
  800e69:	88 10                	mov    %dl,(%eax)
  800e6b:	8a 00                	mov    (%eax),%al
  800e6d:	84 c0                	test   %al,%al
  800e6f:	75 e4                	jne    800e55 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e71:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e74:	c9                   	leave  
  800e75:	c3                   	ret    

00800e76 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e76:	55                   	push   %ebp
  800e77:	89 e5                	mov    %esp,%ebp
  800e79:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e82:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e89:	eb 1f                	jmp    800eaa <strncpy+0x34>
		*dst++ = *src;
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	8d 50 01             	lea    0x1(%eax),%edx
  800e91:	89 55 08             	mov    %edx,0x8(%ebp)
  800e94:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e97:	8a 12                	mov    (%edx),%dl
  800e99:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9e:	8a 00                	mov    (%eax),%al
  800ea0:	84 c0                	test   %al,%al
  800ea2:	74 03                	je     800ea7 <strncpy+0x31>
			src++;
  800ea4:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ea7:	ff 45 fc             	incl   -0x4(%ebp)
  800eaa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ead:	3b 45 10             	cmp    0x10(%ebp),%eax
  800eb0:	72 d9                	jb     800e8b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800eb2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800eb5:	c9                   	leave  
  800eb6:	c3                   	ret    

00800eb7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800eb7:	55                   	push   %ebp
  800eb8:	89 e5                	mov    %esp,%ebp
  800eba:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ebd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ec3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ec7:	74 30                	je     800ef9 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ec9:	eb 16                	jmp    800ee1 <strlcpy+0x2a>
			*dst++ = *src++;
  800ecb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ece:	8d 50 01             	lea    0x1(%eax),%edx
  800ed1:	89 55 08             	mov    %edx,0x8(%ebp)
  800ed4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ed7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eda:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800edd:	8a 12                	mov    (%edx),%dl
  800edf:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ee1:	ff 4d 10             	decl   0x10(%ebp)
  800ee4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ee8:	74 09                	je     800ef3 <strlcpy+0x3c>
  800eea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eed:	8a 00                	mov    (%eax),%al
  800eef:	84 c0                	test   %al,%al
  800ef1:	75 d8                	jne    800ecb <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef6:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ef9:	8b 55 08             	mov    0x8(%ebp),%edx
  800efc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eff:	29 c2                	sub    %eax,%edx
  800f01:	89 d0                	mov    %edx,%eax
}
  800f03:	c9                   	leave  
  800f04:	c3                   	ret    

00800f05 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f05:	55                   	push   %ebp
  800f06:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f08:	eb 06                	jmp    800f10 <strcmp+0xb>
		p++, q++;
  800f0a:	ff 45 08             	incl   0x8(%ebp)
  800f0d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f10:	8b 45 08             	mov    0x8(%ebp),%eax
  800f13:	8a 00                	mov    (%eax),%al
  800f15:	84 c0                	test   %al,%al
  800f17:	74 0e                	je     800f27 <strcmp+0x22>
  800f19:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1c:	8a 10                	mov    (%eax),%dl
  800f1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f21:	8a 00                	mov    (%eax),%al
  800f23:	38 c2                	cmp    %al,%dl
  800f25:	74 e3                	je     800f0a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f27:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2a:	8a 00                	mov    (%eax),%al
  800f2c:	0f b6 d0             	movzbl %al,%edx
  800f2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f32:	8a 00                	mov    (%eax),%al
  800f34:	0f b6 c0             	movzbl %al,%eax
  800f37:	29 c2                	sub    %eax,%edx
  800f39:	89 d0                	mov    %edx,%eax
}
  800f3b:	5d                   	pop    %ebp
  800f3c:	c3                   	ret    

00800f3d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f3d:	55                   	push   %ebp
  800f3e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f40:	eb 09                	jmp    800f4b <strncmp+0xe>
		n--, p++, q++;
  800f42:	ff 4d 10             	decl   0x10(%ebp)
  800f45:	ff 45 08             	incl   0x8(%ebp)
  800f48:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f4b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f4f:	74 17                	je     800f68 <strncmp+0x2b>
  800f51:	8b 45 08             	mov    0x8(%ebp),%eax
  800f54:	8a 00                	mov    (%eax),%al
  800f56:	84 c0                	test   %al,%al
  800f58:	74 0e                	je     800f68 <strncmp+0x2b>
  800f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5d:	8a 10                	mov    (%eax),%dl
  800f5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f62:	8a 00                	mov    (%eax),%al
  800f64:	38 c2                	cmp    %al,%dl
  800f66:	74 da                	je     800f42 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f68:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f6c:	75 07                	jne    800f75 <strncmp+0x38>
		return 0;
  800f6e:	b8 00 00 00 00       	mov    $0x0,%eax
  800f73:	eb 14                	jmp    800f89 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	0f b6 d0             	movzbl %al,%edx
  800f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f80:	8a 00                	mov    (%eax),%al
  800f82:	0f b6 c0             	movzbl %al,%eax
  800f85:	29 c2                	sub    %eax,%edx
  800f87:	89 d0                	mov    %edx,%eax
}
  800f89:	5d                   	pop    %ebp
  800f8a:	c3                   	ret    

00800f8b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f8b:	55                   	push   %ebp
  800f8c:	89 e5                	mov    %esp,%ebp
  800f8e:	83 ec 04             	sub    $0x4,%esp
  800f91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f94:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f97:	eb 12                	jmp    800fab <strchr+0x20>
		if (*s == c)
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9c:	8a 00                	mov    (%eax),%al
  800f9e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fa1:	75 05                	jne    800fa8 <strchr+0x1d>
			return (char *) s;
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	eb 11                	jmp    800fb9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800fa8:	ff 45 08             	incl   0x8(%ebp)
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	8a 00                	mov    (%eax),%al
  800fb0:	84 c0                	test   %al,%al
  800fb2:	75 e5                	jne    800f99 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800fb4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fb9:	c9                   	leave  
  800fba:	c3                   	ret    

00800fbb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800fbb:	55                   	push   %ebp
  800fbc:	89 e5                	mov    %esp,%ebp
  800fbe:	83 ec 04             	sub    $0x4,%esp
  800fc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fc7:	eb 0d                	jmp    800fd6 <strfind+0x1b>
		if (*s == c)
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	8a 00                	mov    (%eax),%al
  800fce:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fd1:	74 0e                	je     800fe1 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fd3:	ff 45 08             	incl   0x8(%ebp)
  800fd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd9:	8a 00                	mov    (%eax),%al
  800fdb:	84 c0                	test   %al,%al
  800fdd:	75 ea                	jne    800fc9 <strfind+0xe>
  800fdf:	eb 01                	jmp    800fe2 <strfind+0x27>
		if (*s == c)
			break;
  800fe1:	90                   	nop
	return (char *) s;
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fe5:	c9                   	leave  
  800fe6:	c3                   	ret    

00800fe7 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800fe7:	55                   	push   %ebp
  800fe8:	89 e5                	mov    %esp,%ebp
  800fea:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800fed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ff3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ff9:	eb 0e                	jmp    801009 <memset+0x22>
		*p++ = c;
  800ffb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ffe:	8d 50 01             	lea    0x1(%eax),%edx
  801001:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801004:	8b 55 0c             	mov    0xc(%ebp),%edx
  801007:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801009:	ff 4d f8             	decl   -0x8(%ebp)
  80100c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801010:	79 e9                	jns    800ffb <memset+0x14>
		*p++ = c;

	return v;
  801012:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801015:	c9                   	leave  
  801016:	c3                   	ret    

00801017 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801017:	55                   	push   %ebp
  801018:	89 e5                	mov    %esp,%ebp
  80101a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80101d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801020:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801023:	8b 45 08             	mov    0x8(%ebp),%eax
  801026:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801029:	eb 16                	jmp    801041 <memcpy+0x2a>
		*d++ = *s++;
  80102b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80102e:	8d 50 01             	lea    0x1(%eax),%edx
  801031:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801034:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801037:	8d 4a 01             	lea    0x1(%edx),%ecx
  80103a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80103d:	8a 12                	mov    (%edx),%dl
  80103f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801041:	8b 45 10             	mov    0x10(%ebp),%eax
  801044:	8d 50 ff             	lea    -0x1(%eax),%edx
  801047:	89 55 10             	mov    %edx,0x10(%ebp)
  80104a:	85 c0                	test   %eax,%eax
  80104c:	75 dd                	jne    80102b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80104e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801051:	c9                   	leave  
  801052:	c3                   	ret    

00801053 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801053:	55                   	push   %ebp
  801054:	89 e5                	mov    %esp,%ebp
  801056:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801059:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80105f:	8b 45 08             	mov    0x8(%ebp),%eax
  801062:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801065:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801068:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80106b:	73 50                	jae    8010bd <memmove+0x6a>
  80106d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801070:	8b 45 10             	mov    0x10(%ebp),%eax
  801073:	01 d0                	add    %edx,%eax
  801075:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801078:	76 43                	jbe    8010bd <memmove+0x6a>
		s += n;
  80107a:	8b 45 10             	mov    0x10(%ebp),%eax
  80107d:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801080:	8b 45 10             	mov    0x10(%ebp),%eax
  801083:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801086:	eb 10                	jmp    801098 <memmove+0x45>
			*--d = *--s;
  801088:	ff 4d f8             	decl   -0x8(%ebp)
  80108b:	ff 4d fc             	decl   -0x4(%ebp)
  80108e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801091:	8a 10                	mov    (%eax),%dl
  801093:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801096:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801098:	8b 45 10             	mov    0x10(%ebp),%eax
  80109b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80109e:	89 55 10             	mov    %edx,0x10(%ebp)
  8010a1:	85 c0                	test   %eax,%eax
  8010a3:	75 e3                	jne    801088 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010a5:	eb 23                	jmp    8010ca <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010aa:	8d 50 01             	lea    0x1(%eax),%edx
  8010ad:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010b0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010b3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010b6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010b9:	8a 12                	mov    (%edx),%dl
  8010bb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010c3:	89 55 10             	mov    %edx,0x10(%ebp)
  8010c6:	85 c0                	test   %eax,%eax
  8010c8:	75 dd                	jne    8010a7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010cd:	c9                   	leave  
  8010ce:	c3                   	ret    

008010cf <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010cf:	55                   	push   %ebp
  8010d0:	89 e5                	mov    %esp,%ebp
  8010d2:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010de:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010e1:	eb 2a                	jmp    80110d <memcmp+0x3e>
		if (*s1 != *s2)
  8010e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e6:	8a 10                	mov    (%eax),%dl
  8010e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010eb:	8a 00                	mov    (%eax),%al
  8010ed:	38 c2                	cmp    %al,%dl
  8010ef:	74 16                	je     801107 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f4:	8a 00                	mov    (%eax),%al
  8010f6:	0f b6 d0             	movzbl %al,%edx
  8010f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010fc:	8a 00                	mov    (%eax),%al
  8010fe:	0f b6 c0             	movzbl %al,%eax
  801101:	29 c2                	sub    %eax,%edx
  801103:	89 d0                	mov    %edx,%eax
  801105:	eb 18                	jmp    80111f <memcmp+0x50>
		s1++, s2++;
  801107:	ff 45 fc             	incl   -0x4(%ebp)
  80110a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80110d:	8b 45 10             	mov    0x10(%ebp),%eax
  801110:	8d 50 ff             	lea    -0x1(%eax),%edx
  801113:	89 55 10             	mov    %edx,0x10(%ebp)
  801116:	85 c0                	test   %eax,%eax
  801118:	75 c9                	jne    8010e3 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80111a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80111f:	c9                   	leave  
  801120:	c3                   	ret    

00801121 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801121:	55                   	push   %ebp
  801122:	89 e5                	mov    %esp,%ebp
  801124:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801127:	8b 55 08             	mov    0x8(%ebp),%edx
  80112a:	8b 45 10             	mov    0x10(%ebp),%eax
  80112d:	01 d0                	add    %edx,%eax
  80112f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801132:	eb 15                	jmp    801149 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801134:	8b 45 08             	mov    0x8(%ebp),%eax
  801137:	8a 00                	mov    (%eax),%al
  801139:	0f b6 d0             	movzbl %al,%edx
  80113c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113f:	0f b6 c0             	movzbl %al,%eax
  801142:	39 c2                	cmp    %eax,%edx
  801144:	74 0d                	je     801153 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801146:	ff 45 08             	incl   0x8(%ebp)
  801149:	8b 45 08             	mov    0x8(%ebp),%eax
  80114c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80114f:	72 e3                	jb     801134 <memfind+0x13>
  801151:	eb 01                	jmp    801154 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801153:	90                   	nop
	return (void *) s;
  801154:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801157:	c9                   	leave  
  801158:	c3                   	ret    

00801159 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801159:	55                   	push   %ebp
  80115a:	89 e5                	mov    %esp,%ebp
  80115c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80115f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801166:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80116d:	eb 03                	jmp    801172 <strtol+0x19>
		s++;
  80116f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801172:	8b 45 08             	mov    0x8(%ebp),%eax
  801175:	8a 00                	mov    (%eax),%al
  801177:	3c 20                	cmp    $0x20,%al
  801179:	74 f4                	je     80116f <strtol+0x16>
  80117b:	8b 45 08             	mov    0x8(%ebp),%eax
  80117e:	8a 00                	mov    (%eax),%al
  801180:	3c 09                	cmp    $0x9,%al
  801182:	74 eb                	je     80116f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801184:	8b 45 08             	mov    0x8(%ebp),%eax
  801187:	8a 00                	mov    (%eax),%al
  801189:	3c 2b                	cmp    $0x2b,%al
  80118b:	75 05                	jne    801192 <strtol+0x39>
		s++;
  80118d:	ff 45 08             	incl   0x8(%ebp)
  801190:	eb 13                	jmp    8011a5 <strtol+0x4c>
	else if (*s == '-')
  801192:	8b 45 08             	mov    0x8(%ebp),%eax
  801195:	8a 00                	mov    (%eax),%al
  801197:	3c 2d                	cmp    $0x2d,%al
  801199:	75 0a                	jne    8011a5 <strtol+0x4c>
		s++, neg = 1;
  80119b:	ff 45 08             	incl   0x8(%ebp)
  80119e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011a5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011a9:	74 06                	je     8011b1 <strtol+0x58>
  8011ab:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011af:	75 20                	jne    8011d1 <strtol+0x78>
  8011b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b4:	8a 00                	mov    (%eax),%al
  8011b6:	3c 30                	cmp    $0x30,%al
  8011b8:	75 17                	jne    8011d1 <strtol+0x78>
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	40                   	inc    %eax
  8011be:	8a 00                	mov    (%eax),%al
  8011c0:	3c 78                	cmp    $0x78,%al
  8011c2:	75 0d                	jne    8011d1 <strtol+0x78>
		s += 2, base = 16;
  8011c4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011c8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011cf:	eb 28                	jmp    8011f9 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011d5:	75 15                	jne    8011ec <strtol+0x93>
  8011d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011da:	8a 00                	mov    (%eax),%al
  8011dc:	3c 30                	cmp    $0x30,%al
  8011de:	75 0c                	jne    8011ec <strtol+0x93>
		s++, base = 8;
  8011e0:	ff 45 08             	incl   0x8(%ebp)
  8011e3:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011ea:	eb 0d                	jmp    8011f9 <strtol+0xa0>
	else if (base == 0)
  8011ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011f0:	75 07                	jne    8011f9 <strtol+0xa0>
		base = 10;
  8011f2:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fc:	8a 00                	mov    (%eax),%al
  8011fe:	3c 2f                	cmp    $0x2f,%al
  801200:	7e 19                	jle    80121b <strtol+0xc2>
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	8a 00                	mov    (%eax),%al
  801207:	3c 39                	cmp    $0x39,%al
  801209:	7f 10                	jg     80121b <strtol+0xc2>
			dig = *s - '0';
  80120b:	8b 45 08             	mov    0x8(%ebp),%eax
  80120e:	8a 00                	mov    (%eax),%al
  801210:	0f be c0             	movsbl %al,%eax
  801213:	83 e8 30             	sub    $0x30,%eax
  801216:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801219:	eb 42                	jmp    80125d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80121b:	8b 45 08             	mov    0x8(%ebp),%eax
  80121e:	8a 00                	mov    (%eax),%al
  801220:	3c 60                	cmp    $0x60,%al
  801222:	7e 19                	jle    80123d <strtol+0xe4>
  801224:	8b 45 08             	mov    0x8(%ebp),%eax
  801227:	8a 00                	mov    (%eax),%al
  801229:	3c 7a                	cmp    $0x7a,%al
  80122b:	7f 10                	jg     80123d <strtol+0xe4>
			dig = *s - 'a' + 10;
  80122d:	8b 45 08             	mov    0x8(%ebp),%eax
  801230:	8a 00                	mov    (%eax),%al
  801232:	0f be c0             	movsbl %al,%eax
  801235:	83 e8 57             	sub    $0x57,%eax
  801238:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80123b:	eb 20                	jmp    80125d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	8a 00                	mov    (%eax),%al
  801242:	3c 40                	cmp    $0x40,%al
  801244:	7e 39                	jle    80127f <strtol+0x126>
  801246:	8b 45 08             	mov    0x8(%ebp),%eax
  801249:	8a 00                	mov    (%eax),%al
  80124b:	3c 5a                	cmp    $0x5a,%al
  80124d:	7f 30                	jg     80127f <strtol+0x126>
			dig = *s - 'A' + 10;
  80124f:	8b 45 08             	mov    0x8(%ebp),%eax
  801252:	8a 00                	mov    (%eax),%al
  801254:	0f be c0             	movsbl %al,%eax
  801257:	83 e8 37             	sub    $0x37,%eax
  80125a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80125d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801260:	3b 45 10             	cmp    0x10(%ebp),%eax
  801263:	7d 19                	jge    80127e <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801265:	ff 45 08             	incl   0x8(%ebp)
  801268:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80126b:	0f af 45 10          	imul   0x10(%ebp),%eax
  80126f:	89 c2                	mov    %eax,%edx
  801271:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801274:	01 d0                	add    %edx,%eax
  801276:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801279:	e9 7b ff ff ff       	jmp    8011f9 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80127e:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80127f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801283:	74 08                	je     80128d <strtol+0x134>
		*endptr = (char *) s;
  801285:	8b 45 0c             	mov    0xc(%ebp),%eax
  801288:	8b 55 08             	mov    0x8(%ebp),%edx
  80128b:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80128d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801291:	74 07                	je     80129a <strtol+0x141>
  801293:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801296:	f7 d8                	neg    %eax
  801298:	eb 03                	jmp    80129d <strtol+0x144>
  80129a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80129d:	c9                   	leave  
  80129e:	c3                   	ret    

0080129f <ltostr>:

void
ltostr(long value, char *str)
{
  80129f:	55                   	push   %ebp
  8012a0:	89 e5                	mov    %esp,%ebp
  8012a2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012ac:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012b3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012b7:	79 13                	jns    8012cc <ltostr+0x2d>
	{
		neg = 1;
  8012b9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012c6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012c9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cf:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012d4:	99                   	cltd   
  8012d5:	f7 f9                	idiv   %ecx
  8012d7:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012dd:	8d 50 01             	lea    0x1(%eax),%edx
  8012e0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012e3:	89 c2                	mov    %eax,%edx
  8012e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e8:	01 d0                	add    %edx,%eax
  8012ea:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012ed:	83 c2 30             	add    $0x30,%edx
  8012f0:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012f2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012f5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012fa:	f7 e9                	imul   %ecx
  8012fc:	c1 fa 02             	sar    $0x2,%edx
  8012ff:	89 c8                	mov    %ecx,%eax
  801301:	c1 f8 1f             	sar    $0x1f,%eax
  801304:	29 c2                	sub    %eax,%edx
  801306:	89 d0                	mov    %edx,%eax
  801308:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80130b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80130e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801313:	f7 e9                	imul   %ecx
  801315:	c1 fa 02             	sar    $0x2,%edx
  801318:	89 c8                	mov    %ecx,%eax
  80131a:	c1 f8 1f             	sar    $0x1f,%eax
  80131d:	29 c2                	sub    %eax,%edx
  80131f:	89 d0                	mov    %edx,%eax
  801321:	c1 e0 02             	shl    $0x2,%eax
  801324:	01 d0                	add    %edx,%eax
  801326:	01 c0                	add    %eax,%eax
  801328:	29 c1                	sub    %eax,%ecx
  80132a:	89 ca                	mov    %ecx,%edx
  80132c:	85 d2                	test   %edx,%edx
  80132e:	75 9c                	jne    8012cc <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801330:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801337:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80133a:	48                   	dec    %eax
  80133b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80133e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801342:	74 3d                	je     801381 <ltostr+0xe2>
		start = 1 ;
  801344:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80134b:	eb 34                	jmp    801381 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80134d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801350:	8b 45 0c             	mov    0xc(%ebp),%eax
  801353:	01 d0                	add    %edx,%eax
  801355:	8a 00                	mov    (%eax),%al
  801357:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80135a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80135d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801360:	01 c2                	add    %eax,%edx
  801362:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801365:	8b 45 0c             	mov    0xc(%ebp),%eax
  801368:	01 c8                	add    %ecx,%eax
  80136a:	8a 00                	mov    (%eax),%al
  80136c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80136e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801371:	8b 45 0c             	mov    0xc(%ebp),%eax
  801374:	01 c2                	add    %eax,%edx
  801376:	8a 45 eb             	mov    -0x15(%ebp),%al
  801379:	88 02                	mov    %al,(%edx)
		start++ ;
  80137b:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80137e:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801381:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801384:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801387:	7c c4                	jl     80134d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801389:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80138c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138f:	01 d0                	add    %edx,%eax
  801391:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801394:	90                   	nop
  801395:	c9                   	leave  
  801396:	c3                   	ret    

00801397 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801397:	55                   	push   %ebp
  801398:	89 e5                	mov    %esp,%ebp
  80139a:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80139d:	ff 75 08             	pushl  0x8(%ebp)
  8013a0:	e8 54 fa ff ff       	call   800df9 <strlen>
  8013a5:	83 c4 04             	add    $0x4,%esp
  8013a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013ab:	ff 75 0c             	pushl  0xc(%ebp)
  8013ae:	e8 46 fa ff ff       	call   800df9 <strlen>
  8013b3:	83 c4 04             	add    $0x4,%esp
  8013b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013c7:	eb 17                	jmp    8013e0 <strcconcat+0x49>
		final[s] = str1[s] ;
  8013c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8013cf:	01 c2                	add    %eax,%edx
  8013d1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d7:	01 c8                	add    %ecx,%eax
  8013d9:	8a 00                	mov    (%eax),%al
  8013db:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013dd:	ff 45 fc             	incl   -0x4(%ebp)
  8013e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013e3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013e6:	7c e1                	jl     8013c9 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013e8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013ef:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013f6:	eb 1f                	jmp    801417 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013fb:	8d 50 01             	lea    0x1(%eax),%edx
  8013fe:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801401:	89 c2                	mov    %eax,%edx
  801403:	8b 45 10             	mov    0x10(%ebp),%eax
  801406:	01 c2                	add    %eax,%edx
  801408:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80140b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140e:	01 c8                	add    %ecx,%eax
  801410:	8a 00                	mov    (%eax),%al
  801412:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801414:	ff 45 f8             	incl   -0x8(%ebp)
  801417:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80141a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80141d:	7c d9                	jl     8013f8 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80141f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801422:	8b 45 10             	mov    0x10(%ebp),%eax
  801425:	01 d0                	add    %edx,%eax
  801427:	c6 00 00             	movb   $0x0,(%eax)
}
  80142a:	90                   	nop
  80142b:	c9                   	leave  
  80142c:	c3                   	ret    

0080142d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80142d:	55                   	push   %ebp
  80142e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801430:	8b 45 14             	mov    0x14(%ebp),%eax
  801433:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801439:	8b 45 14             	mov    0x14(%ebp),%eax
  80143c:	8b 00                	mov    (%eax),%eax
  80143e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801445:	8b 45 10             	mov    0x10(%ebp),%eax
  801448:	01 d0                	add    %edx,%eax
  80144a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801450:	eb 0c                	jmp    80145e <strsplit+0x31>
			*string++ = 0;
  801452:	8b 45 08             	mov    0x8(%ebp),%eax
  801455:	8d 50 01             	lea    0x1(%eax),%edx
  801458:	89 55 08             	mov    %edx,0x8(%ebp)
  80145b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	8a 00                	mov    (%eax),%al
  801463:	84 c0                	test   %al,%al
  801465:	74 18                	je     80147f <strsplit+0x52>
  801467:	8b 45 08             	mov    0x8(%ebp),%eax
  80146a:	8a 00                	mov    (%eax),%al
  80146c:	0f be c0             	movsbl %al,%eax
  80146f:	50                   	push   %eax
  801470:	ff 75 0c             	pushl  0xc(%ebp)
  801473:	e8 13 fb ff ff       	call   800f8b <strchr>
  801478:	83 c4 08             	add    $0x8,%esp
  80147b:	85 c0                	test   %eax,%eax
  80147d:	75 d3                	jne    801452 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80147f:	8b 45 08             	mov    0x8(%ebp),%eax
  801482:	8a 00                	mov    (%eax),%al
  801484:	84 c0                	test   %al,%al
  801486:	74 5a                	je     8014e2 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801488:	8b 45 14             	mov    0x14(%ebp),%eax
  80148b:	8b 00                	mov    (%eax),%eax
  80148d:	83 f8 0f             	cmp    $0xf,%eax
  801490:	75 07                	jne    801499 <strsplit+0x6c>
		{
			return 0;
  801492:	b8 00 00 00 00       	mov    $0x0,%eax
  801497:	eb 66                	jmp    8014ff <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801499:	8b 45 14             	mov    0x14(%ebp),%eax
  80149c:	8b 00                	mov    (%eax),%eax
  80149e:	8d 48 01             	lea    0x1(%eax),%ecx
  8014a1:	8b 55 14             	mov    0x14(%ebp),%edx
  8014a4:	89 0a                	mov    %ecx,(%edx)
  8014a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b0:	01 c2                	add    %eax,%edx
  8014b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014b7:	eb 03                	jmp    8014bc <strsplit+0x8f>
			string++;
  8014b9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bf:	8a 00                	mov    (%eax),%al
  8014c1:	84 c0                	test   %al,%al
  8014c3:	74 8b                	je     801450 <strsplit+0x23>
  8014c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c8:	8a 00                	mov    (%eax),%al
  8014ca:	0f be c0             	movsbl %al,%eax
  8014cd:	50                   	push   %eax
  8014ce:	ff 75 0c             	pushl  0xc(%ebp)
  8014d1:	e8 b5 fa ff ff       	call   800f8b <strchr>
  8014d6:	83 c4 08             	add    $0x8,%esp
  8014d9:	85 c0                	test   %eax,%eax
  8014db:	74 dc                	je     8014b9 <strsplit+0x8c>
			string++;
	}
  8014dd:	e9 6e ff ff ff       	jmp    801450 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014e2:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8014e6:	8b 00                	mov    (%eax),%eax
  8014e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f2:	01 d0                	add    %edx,%eax
  8014f4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014fa:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014ff:	c9                   	leave  
  801500:	c3                   	ret    

00801501 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801501:	55                   	push   %ebp
  801502:	89 e5                	mov    %esp,%ebp
  801504:	83 ec 18             	sub    $0x18,%esp
  801507:	8b 45 10             	mov    0x10(%ebp),%eax
  80150a:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80150d:	83 ec 04             	sub    $0x4,%esp
  801510:	68 50 2a 80 00       	push   $0x802a50
  801515:	6a 17                	push   $0x17
  801517:	68 6f 2a 80 00       	push   $0x802a6f
  80151c:	e8 a2 ef ff ff       	call   8004c3 <_panic>

00801521 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801521:	55                   	push   %ebp
  801522:	89 e5                	mov    %esp,%ebp
  801524:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801527:	83 ec 04             	sub    $0x4,%esp
  80152a:	68 7b 2a 80 00       	push   $0x802a7b
  80152f:	6a 2f                	push   $0x2f
  801531:	68 6f 2a 80 00       	push   $0x802a6f
  801536:	e8 88 ef ff ff       	call   8004c3 <_panic>

0080153b <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  80153b:	55                   	push   %ebp
  80153c:	89 e5                	mov    %esp,%ebp
  80153e:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801541:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801548:	8b 55 08             	mov    0x8(%ebp),%edx
  80154b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80154e:	01 d0                	add    %edx,%eax
  801550:	48                   	dec    %eax
  801551:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801554:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801557:	ba 00 00 00 00       	mov    $0x0,%edx
  80155c:	f7 75 ec             	divl   -0x14(%ebp)
  80155f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801562:	29 d0                	sub    %edx,%eax
  801564:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801567:	8b 45 08             	mov    0x8(%ebp),%eax
  80156a:	c1 e8 0c             	shr    $0xc,%eax
  80156d:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801570:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801577:	e9 c8 00 00 00       	jmp    801644 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  80157c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801583:	eb 27                	jmp    8015ac <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801585:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801588:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80158b:	01 c2                	add    %eax,%edx
  80158d:	89 d0                	mov    %edx,%eax
  80158f:	01 c0                	add    %eax,%eax
  801591:	01 d0                	add    %edx,%eax
  801593:	c1 e0 02             	shl    $0x2,%eax
  801596:	05 48 30 80 00       	add    $0x803048,%eax
  80159b:	8b 00                	mov    (%eax),%eax
  80159d:	85 c0                	test   %eax,%eax
  80159f:	74 08                	je     8015a9 <malloc+0x6e>
            	i += j;
  8015a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015a4:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8015a7:	eb 0b                	jmp    8015b4 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8015a9:	ff 45 f0             	incl   -0x10(%ebp)
  8015ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015af:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8015b2:	72 d1                	jb     801585 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8015b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015b7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8015ba:	0f 85 81 00 00 00    	jne    801641 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8015c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015c3:	05 00 00 08 00       	add    $0x80000,%eax
  8015c8:	c1 e0 0c             	shl    $0xc,%eax
  8015cb:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8015ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8015d5:	eb 1f                	jmp    8015f6 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8015d7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015dd:	01 c2                	add    %eax,%edx
  8015df:	89 d0                	mov    %edx,%eax
  8015e1:	01 c0                	add    %eax,%eax
  8015e3:	01 d0                	add    %edx,%eax
  8015e5:	c1 e0 02             	shl    $0x2,%eax
  8015e8:	05 48 30 80 00       	add    $0x803048,%eax
  8015ed:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8015f3:	ff 45 f0             	incl   -0x10(%ebp)
  8015f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015f9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8015fc:	72 d9                	jb     8015d7 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  8015fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801601:	89 d0                	mov    %edx,%eax
  801603:	01 c0                	add    %eax,%eax
  801605:	01 d0                	add    %edx,%eax
  801607:	c1 e0 02             	shl    $0x2,%eax
  80160a:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801610:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801613:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801615:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801618:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  80161b:	89 c8                	mov    %ecx,%eax
  80161d:	01 c0                	add    %eax,%eax
  80161f:	01 c8                	add    %ecx,%eax
  801621:	c1 e0 02             	shl    $0x2,%eax
  801624:	05 44 30 80 00       	add    $0x803044,%eax
  801629:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  80162b:	83 ec 08             	sub    $0x8,%esp
  80162e:	ff 75 08             	pushl  0x8(%ebp)
  801631:	ff 75 e0             	pushl  -0x20(%ebp)
  801634:	e8 2b 03 00 00       	call   801964 <sys_allocateMem>
  801639:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  80163c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80163f:	eb 19                	jmp    80165a <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801641:	ff 45 f4             	incl   -0xc(%ebp)
  801644:	a1 04 30 80 00       	mov    0x803004,%eax
  801649:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80164c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80164f:	0f 83 27 ff ff ff    	jae    80157c <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801655:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80165a:	c9                   	leave  
  80165b:	c3                   	ret    

0080165c <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80165c:	55                   	push   %ebp
  80165d:	89 e5                	mov    %esp,%ebp
  80165f:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801662:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801666:	0f 84 e5 00 00 00    	je     801751 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801672:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801675:	05 00 00 00 80       	add    $0x80000000,%eax
  80167a:	c1 e8 0c             	shr    $0xc,%eax
  80167d:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801680:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801683:	89 d0                	mov    %edx,%eax
  801685:	01 c0                	add    %eax,%eax
  801687:	01 d0                	add    %edx,%eax
  801689:	c1 e0 02             	shl    $0x2,%eax
  80168c:	05 40 30 80 00       	add    $0x803040,%eax
  801691:	8b 00                	mov    (%eax),%eax
  801693:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801696:	0f 85 b8 00 00 00    	jne    801754 <free+0xf8>
  80169c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80169f:	89 d0                	mov    %edx,%eax
  8016a1:	01 c0                	add    %eax,%eax
  8016a3:	01 d0                	add    %edx,%eax
  8016a5:	c1 e0 02             	shl    $0x2,%eax
  8016a8:	05 48 30 80 00       	add    $0x803048,%eax
  8016ad:	8b 00                	mov    (%eax),%eax
  8016af:	85 c0                	test   %eax,%eax
  8016b1:	0f 84 9d 00 00 00    	je     801754 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8016b7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016ba:	89 d0                	mov    %edx,%eax
  8016bc:	01 c0                	add    %eax,%eax
  8016be:	01 d0                	add    %edx,%eax
  8016c0:	c1 e0 02             	shl    $0x2,%eax
  8016c3:	05 44 30 80 00       	add    $0x803044,%eax
  8016c8:	8b 00                	mov    (%eax),%eax
  8016ca:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  8016cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016d0:	c1 e0 0c             	shl    $0xc,%eax
  8016d3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  8016d6:	83 ec 08             	sub    $0x8,%esp
  8016d9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8016dc:	ff 75 f0             	pushl  -0x10(%ebp)
  8016df:	e8 64 02 00 00       	call   801948 <sys_freeMem>
  8016e4:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8016e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8016ee:	eb 57                	jmp    801747 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8016f0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016f6:	01 c2                	add    %eax,%edx
  8016f8:	89 d0                	mov    %edx,%eax
  8016fa:	01 c0                	add    %eax,%eax
  8016fc:	01 d0                	add    %edx,%eax
  8016fe:	c1 e0 02             	shl    $0x2,%eax
  801701:	05 48 30 80 00       	add    $0x803048,%eax
  801706:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  80170c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80170f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801712:	01 c2                	add    %eax,%edx
  801714:	89 d0                	mov    %edx,%eax
  801716:	01 c0                	add    %eax,%eax
  801718:	01 d0                	add    %edx,%eax
  80171a:	c1 e0 02             	shl    $0x2,%eax
  80171d:	05 40 30 80 00       	add    $0x803040,%eax
  801722:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801728:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80172b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80172e:	01 c2                	add    %eax,%edx
  801730:	89 d0                	mov    %edx,%eax
  801732:	01 c0                	add    %eax,%eax
  801734:	01 d0                	add    %edx,%eax
  801736:	c1 e0 02             	shl    $0x2,%eax
  801739:	05 44 30 80 00       	add    $0x803044,%eax
  80173e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801744:	ff 45 f4             	incl   -0xc(%ebp)
  801747:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80174a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80174d:	7c a1                	jl     8016f0 <free+0x94>
  80174f:	eb 04                	jmp    801755 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801751:	90                   	nop
  801752:	eb 01                	jmp    801755 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801754:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801755:	c9                   	leave  
  801756:	c3                   	ret    

00801757 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801757:	55                   	push   %ebp
  801758:	89 e5                	mov    %esp,%ebp
  80175a:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  80175d:	83 ec 04             	sub    $0x4,%esp
  801760:	68 98 2a 80 00       	push   $0x802a98
  801765:	68 ae 00 00 00       	push   $0xae
  80176a:	68 6f 2a 80 00       	push   $0x802a6f
  80176f:	e8 4f ed ff ff       	call   8004c3 <_panic>

00801774 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801774:	55                   	push   %ebp
  801775:	89 e5                	mov    %esp,%ebp
  801777:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  80177a:	83 ec 04             	sub    $0x4,%esp
  80177d:	68 b8 2a 80 00       	push   $0x802ab8
  801782:	68 ca 00 00 00       	push   $0xca
  801787:	68 6f 2a 80 00       	push   $0x802a6f
  80178c:	e8 32 ed ff ff       	call   8004c3 <_panic>

00801791 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
  801794:	57                   	push   %edi
  801795:	56                   	push   %esi
  801796:	53                   	push   %ebx
  801797:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80179a:	8b 45 08             	mov    0x8(%ebp),%eax
  80179d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017a3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017a6:	8b 7d 18             	mov    0x18(%ebp),%edi
  8017a9:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8017ac:	cd 30                	int    $0x30
  8017ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8017b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8017b4:	83 c4 10             	add    $0x10,%esp
  8017b7:	5b                   	pop    %ebx
  8017b8:	5e                   	pop    %esi
  8017b9:	5f                   	pop    %edi
  8017ba:	5d                   	pop    %ebp
  8017bb:	c3                   	ret    

008017bc <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
  8017bf:	83 ec 04             	sub    $0x4,%esp
  8017c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8017c5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8017c8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	52                   	push   %edx
  8017d4:	ff 75 0c             	pushl  0xc(%ebp)
  8017d7:	50                   	push   %eax
  8017d8:	6a 00                	push   $0x0
  8017da:	e8 b2 ff ff ff       	call   801791 <syscall>
  8017df:	83 c4 18             	add    $0x18,%esp
}
  8017e2:	90                   	nop
  8017e3:	c9                   	leave  
  8017e4:	c3                   	ret    

008017e5 <sys_cgetc>:

int
sys_cgetc(void)
{
  8017e5:	55                   	push   %ebp
  8017e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 01                	push   $0x1
  8017f4:	e8 98 ff ff ff       	call   801791 <syscall>
  8017f9:	83 c4 18             	add    $0x18,%esp
}
  8017fc:	c9                   	leave  
  8017fd:	c3                   	ret    

008017fe <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8017fe:	55                   	push   %ebp
  8017ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801801:	8b 45 08             	mov    0x8(%ebp),%eax
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	50                   	push   %eax
  80180d:	6a 05                	push   $0x5
  80180f:	e8 7d ff ff ff       	call   801791 <syscall>
  801814:	83 c4 18             	add    $0x18,%esp
}
  801817:	c9                   	leave  
  801818:	c3                   	ret    

00801819 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801819:	55                   	push   %ebp
  80181a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 02                	push   $0x2
  801828:	e8 64 ff ff ff       	call   801791 <syscall>
  80182d:	83 c4 18             	add    $0x18,%esp
}
  801830:	c9                   	leave  
  801831:	c3                   	ret    

00801832 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801832:	55                   	push   %ebp
  801833:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 03                	push   $0x3
  801841:	e8 4b ff ff ff       	call   801791 <syscall>
  801846:	83 c4 18             	add    $0x18,%esp
}
  801849:	c9                   	leave  
  80184a:	c3                   	ret    

0080184b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80184b:	55                   	push   %ebp
  80184c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 04                	push   $0x4
  80185a:	e8 32 ff ff ff       	call   801791 <syscall>
  80185f:	83 c4 18             	add    $0x18,%esp
}
  801862:	c9                   	leave  
  801863:	c3                   	ret    

00801864 <sys_env_exit>:


void sys_env_exit(void)
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 06                	push   $0x6
  801873:	e8 19 ff ff ff       	call   801791 <syscall>
  801878:	83 c4 18             	add    $0x18,%esp
}
  80187b:	90                   	nop
  80187c:	c9                   	leave  
  80187d:	c3                   	ret    

0080187e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80187e:	55                   	push   %ebp
  80187f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801881:	8b 55 0c             	mov    0xc(%ebp),%edx
  801884:	8b 45 08             	mov    0x8(%ebp),%eax
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	52                   	push   %edx
  80188e:	50                   	push   %eax
  80188f:	6a 07                	push   $0x7
  801891:	e8 fb fe ff ff       	call   801791 <syscall>
  801896:	83 c4 18             	add    $0x18,%esp
}
  801899:	c9                   	leave  
  80189a:	c3                   	ret    

0080189b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80189b:	55                   	push   %ebp
  80189c:	89 e5                	mov    %esp,%ebp
  80189e:	56                   	push   %esi
  80189f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8018a0:	8b 75 18             	mov    0x18(%ebp),%esi
  8018a3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8018af:	56                   	push   %esi
  8018b0:	53                   	push   %ebx
  8018b1:	51                   	push   %ecx
  8018b2:	52                   	push   %edx
  8018b3:	50                   	push   %eax
  8018b4:	6a 08                	push   $0x8
  8018b6:	e8 d6 fe ff ff       	call   801791 <syscall>
  8018bb:	83 c4 18             	add    $0x18,%esp
}
  8018be:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8018c1:	5b                   	pop    %ebx
  8018c2:	5e                   	pop    %esi
  8018c3:	5d                   	pop    %ebp
  8018c4:	c3                   	ret    

008018c5 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8018c5:	55                   	push   %ebp
  8018c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8018c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	52                   	push   %edx
  8018d5:	50                   	push   %eax
  8018d6:	6a 09                	push   $0x9
  8018d8:	e8 b4 fe ff ff       	call   801791 <syscall>
  8018dd:	83 c4 18             	add    $0x18,%esp
}
  8018e0:	c9                   	leave  
  8018e1:	c3                   	ret    

008018e2 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8018e2:	55                   	push   %ebp
  8018e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8018e5:	6a 00                	push   $0x0
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	ff 75 0c             	pushl  0xc(%ebp)
  8018ee:	ff 75 08             	pushl  0x8(%ebp)
  8018f1:	6a 0a                	push   $0xa
  8018f3:	e8 99 fe ff ff       	call   801791 <syscall>
  8018f8:	83 c4 18             	add    $0x18,%esp
}
  8018fb:	c9                   	leave  
  8018fc:	c3                   	ret    

008018fd <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8018fd:	55                   	push   %ebp
  8018fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	6a 00                	push   $0x0
  801908:	6a 00                	push   $0x0
  80190a:	6a 0b                	push   $0xb
  80190c:	e8 80 fe ff ff       	call   801791 <syscall>
  801911:	83 c4 18             	add    $0x18,%esp
}
  801914:	c9                   	leave  
  801915:	c3                   	ret    

00801916 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801916:	55                   	push   %ebp
  801917:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	6a 00                	push   $0x0
  801921:	6a 00                	push   $0x0
  801923:	6a 0c                	push   $0xc
  801925:	e8 67 fe ff ff       	call   801791 <syscall>
  80192a:	83 c4 18             	add    $0x18,%esp
}
  80192d:	c9                   	leave  
  80192e:	c3                   	ret    

0080192f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 0d                	push   $0xd
  80193e:	e8 4e fe ff ff       	call   801791 <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
}
  801946:	c9                   	leave  
  801947:	c3                   	ret    

00801948 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801948:	55                   	push   %ebp
  801949:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	ff 75 0c             	pushl  0xc(%ebp)
  801954:	ff 75 08             	pushl  0x8(%ebp)
  801957:	6a 11                	push   $0x11
  801959:	e8 33 fe ff ff       	call   801791 <syscall>
  80195e:	83 c4 18             	add    $0x18,%esp
	return;
  801961:	90                   	nop
}
  801962:	c9                   	leave  
  801963:	c3                   	ret    

00801964 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801964:	55                   	push   %ebp
  801965:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	ff 75 0c             	pushl  0xc(%ebp)
  801970:	ff 75 08             	pushl  0x8(%ebp)
  801973:	6a 12                	push   $0x12
  801975:	e8 17 fe ff ff       	call   801791 <syscall>
  80197a:	83 c4 18             	add    $0x18,%esp
	return ;
  80197d:	90                   	nop
}
  80197e:	c9                   	leave  
  80197f:	c3                   	ret    

00801980 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801980:	55                   	push   %ebp
  801981:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 0e                	push   $0xe
  80198f:	e8 fd fd ff ff       	call   801791 <syscall>
  801994:	83 c4 18             	add    $0x18,%esp
}
  801997:	c9                   	leave  
  801998:	c3                   	ret    

00801999 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801999:	55                   	push   %ebp
  80199a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	ff 75 08             	pushl  0x8(%ebp)
  8019a7:	6a 0f                	push   $0xf
  8019a9:	e8 e3 fd ff ff       	call   801791 <syscall>
  8019ae:	83 c4 18             	add    $0x18,%esp
}
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 10                	push   $0x10
  8019c2:	e8 ca fd ff ff       	call   801791 <syscall>
  8019c7:	83 c4 18             	add    $0x18,%esp
}
  8019ca:	90                   	nop
  8019cb:	c9                   	leave  
  8019cc:	c3                   	ret    

008019cd <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8019cd:	55                   	push   %ebp
  8019ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 14                	push   $0x14
  8019dc:	e8 b0 fd ff ff       	call   801791 <syscall>
  8019e1:	83 c4 18             	add    $0x18,%esp
}
  8019e4:	90                   	nop
  8019e5:	c9                   	leave  
  8019e6:	c3                   	ret    

008019e7 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8019e7:	55                   	push   %ebp
  8019e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 15                	push   $0x15
  8019f6:	e8 96 fd ff ff       	call   801791 <syscall>
  8019fb:	83 c4 18             	add    $0x18,%esp
}
  8019fe:	90                   	nop
  8019ff:	c9                   	leave  
  801a00:	c3                   	ret    

00801a01 <sys_cputc>:


void
sys_cputc(const char c)
{
  801a01:	55                   	push   %ebp
  801a02:	89 e5                	mov    %esp,%ebp
  801a04:	83 ec 04             	sub    $0x4,%esp
  801a07:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a0d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	50                   	push   %eax
  801a1a:	6a 16                	push   $0x16
  801a1c:	e8 70 fd ff ff       	call   801791 <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
}
  801a24:	90                   	nop
  801a25:	c9                   	leave  
  801a26:	c3                   	ret    

00801a27 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a27:	55                   	push   %ebp
  801a28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 17                	push   $0x17
  801a36:	e8 56 fd ff ff       	call   801791 <syscall>
  801a3b:	83 c4 18             	add    $0x18,%esp
}
  801a3e:	90                   	nop
  801a3f:	c9                   	leave  
  801a40:	c3                   	ret    

00801a41 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801a41:	55                   	push   %ebp
  801a42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801a44:	8b 45 08             	mov    0x8(%ebp),%eax
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	ff 75 0c             	pushl  0xc(%ebp)
  801a50:	50                   	push   %eax
  801a51:	6a 18                	push   $0x18
  801a53:	e8 39 fd ff ff       	call   801791 <syscall>
  801a58:	83 c4 18             	add    $0x18,%esp
}
  801a5b:	c9                   	leave  
  801a5c:	c3                   	ret    

00801a5d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a5d:	55                   	push   %ebp
  801a5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a63:	8b 45 08             	mov    0x8(%ebp),%eax
  801a66:	6a 00                	push   $0x0
  801a68:	6a 00                	push   $0x0
  801a6a:	6a 00                	push   $0x0
  801a6c:	52                   	push   %edx
  801a6d:	50                   	push   %eax
  801a6e:	6a 1b                	push   $0x1b
  801a70:	e8 1c fd ff ff       	call   801791 <syscall>
  801a75:	83 c4 18             	add    $0x18,%esp
}
  801a78:	c9                   	leave  
  801a79:	c3                   	ret    

00801a7a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a7a:	55                   	push   %ebp
  801a7b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a80:	8b 45 08             	mov    0x8(%ebp),%eax
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	52                   	push   %edx
  801a8a:	50                   	push   %eax
  801a8b:	6a 19                	push   $0x19
  801a8d:	e8 ff fc ff ff       	call   801791 <syscall>
  801a92:	83 c4 18             	add    $0x18,%esp
}
  801a95:	90                   	nop
  801a96:	c9                   	leave  
  801a97:	c3                   	ret    

00801a98 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a98:	55                   	push   %ebp
  801a99:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	52                   	push   %edx
  801aa8:	50                   	push   %eax
  801aa9:	6a 1a                	push   $0x1a
  801aab:	e8 e1 fc ff ff       	call   801791 <syscall>
  801ab0:	83 c4 18             	add    $0x18,%esp
}
  801ab3:	90                   	nop
  801ab4:	c9                   	leave  
  801ab5:	c3                   	ret    

00801ab6 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ab6:	55                   	push   %ebp
  801ab7:	89 e5                	mov    %esp,%ebp
  801ab9:	83 ec 04             	sub    $0x4,%esp
  801abc:	8b 45 10             	mov    0x10(%ebp),%eax
  801abf:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801ac2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ac5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  801acc:	6a 00                	push   $0x0
  801ace:	51                   	push   %ecx
  801acf:	52                   	push   %edx
  801ad0:	ff 75 0c             	pushl  0xc(%ebp)
  801ad3:	50                   	push   %eax
  801ad4:	6a 1c                	push   $0x1c
  801ad6:	e8 b6 fc ff ff       	call   801791 <syscall>
  801adb:	83 c4 18             	add    $0x18,%esp
}
  801ade:	c9                   	leave  
  801adf:	c3                   	ret    

00801ae0 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801ae0:	55                   	push   %ebp
  801ae1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ae3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	52                   	push   %edx
  801af0:	50                   	push   %eax
  801af1:	6a 1d                	push   $0x1d
  801af3:	e8 99 fc ff ff       	call   801791 <syscall>
  801af8:	83 c4 18             	add    $0x18,%esp
}
  801afb:	c9                   	leave  
  801afc:	c3                   	ret    

00801afd <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801afd:	55                   	push   %ebp
  801afe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b00:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b03:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b06:	8b 45 08             	mov    0x8(%ebp),%eax
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	51                   	push   %ecx
  801b0e:	52                   	push   %edx
  801b0f:	50                   	push   %eax
  801b10:	6a 1e                	push   $0x1e
  801b12:	e8 7a fc ff ff       	call   801791 <syscall>
  801b17:	83 c4 18             	add    $0x18,%esp
}
  801b1a:	c9                   	leave  
  801b1b:	c3                   	ret    

00801b1c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b1c:	55                   	push   %ebp
  801b1d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b22:	8b 45 08             	mov    0x8(%ebp),%eax
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	6a 00                	push   $0x0
  801b2b:	52                   	push   %edx
  801b2c:	50                   	push   %eax
  801b2d:	6a 1f                	push   $0x1f
  801b2f:	e8 5d fc ff ff       	call   801791 <syscall>
  801b34:	83 c4 18             	add    $0x18,%esp
}
  801b37:	c9                   	leave  
  801b38:	c3                   	ret    

00801b39 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b39:	55                   	push   %ebp
  801b3a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801b3c:	6a 00                	push   $0x0
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	6a 20                	push   $0x20
  801b48:	e8 44 fc ff ff       	call   801791 <syscall>
  801b4d:	83 c4 18             	add    $0x18,%esp
}
  801b50:	c9                   	leave  
  801b51:	c3                   	ret    

00801b52 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801b52:	55                   	push   %ebp
  801b53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801b55:	8b 45 08             	mov    0x8(%ebp),%eax
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	ff 75 10             	pushl  0x10(%ebp)
  801b5f:	ff 75 0c             	pushl  0xc(%ebp)
  801b62:	50                   	push   %eax
  801b63:	6a 21                	push   $0x21
  801b65:	e8 27 fc ff ff       	call   801791 <syscall>
  801b6a:	83 c4 18             	add    $0x18,%esp
}
  801b6d:	c9                   	leave  
  801b6e:	c3                   	ret    

00801b6f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801b6f:	55                   	push   %ebp
  801b70:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b72:	8b 45 08             	mov    0x8(%ebp),%eax
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	50                   	push   %eax
  801b7e:	6a 22                	push   $0x22
  801b80:	e8 0c fc ff ff       	call   801791 <syscall>
  801b85:	83 c4 18             	add    $0x18,%esp
}
  801b88:	90                   	nop
  801b89:	c9                   	leave  
  801b8a:	c3                   	ret    

00801b8b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b8b:	55                   	push   %ebp
  801b8c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	50                   	push   %eax
  801b9a:	6a 23                	push   $0x23
  801b9c:	e8 f0 fb ff ff       	call   801791 <syscall>
  801ba1:	83 c4 18             	add    $0x18,%esp
}
  801ba4:	90                   	nop
  801ba5:	c9                   	leave  
  801ba6:	c3                   	ret    

00801ba7 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ba7:	55                   	push   %ebp
  801ba8:	89 e5                	mov    %esp,%ebp
  801baa:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801bad:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801bb0:	8d 50 04             	lea    0x4(%eax),%edx
  801bb3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	52                   	push   %edx
  801bbd:	50                   	push   %eax
  801bbe:	6a 24                	push   $0x24
  801bc0:	e8 cc fb ff ff       	call   801791 <syscall>
  801bc5:	83 c4 18             	add    $0x18,%esp
	return result;
  801bc8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801bcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bce:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bd1:	89 01                	mov    %eax,(%ecx)
  801bd3:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd9:	c9                   	leave  
  801bda:	c2 04 00             	ret    $0x4

00801bdd <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801bdd:	55                   	push   %ebp
  801bde:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	ff 75 10             	pushl  0x10(%ebp)
  801be7:	ff 75 0c             	pushl  0xc(%ebp)
  801bea:	ff 75 08             	pushl  0x8(%ebp)
  801bed:	6a 13                	push   $0x13
  801bef:	e8 9d fb ff ff       	call   801791 <syscall>
  801bf4:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf7:	90                   	nop
}
  801bf8:	c9                   	leave  
  801bf9:	c3                   	ret    

00801bfa <sys_rcr2>:
uint32 sys_rcr2()
{
  801bfa:	55                   	push   %ebp
  801bfb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 25                	push   $0x25
  801c09:	e8 83 fb ff ff       	call   801791 <syscall>
  801c0e:	83 c4 18             	add    $0x18,%esp
}
  801c11:	c9                   	leave  
  801c12:	c3                   	ret    

00801c13 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c13:	55                   	push   %ebp
  801c14:	89 e5                	mov    %esp,%ebp
  801c16:	83 ec 04             	sub    $0x4,%esp
  801c19:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c1f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	50                   	push   %eax
  801c2c:	6a 26                	push   $0x26
  801c2e:	e8 5e fb ff ff       	call   801791 <syscall>
  801c33:	83 c4 18             	add    $0x18,%esp
	return ;
  801c36:	90                   	nop
}
  801c37:	c9                   	leave  
  801c38:	c3                   	ret    

00801c39 <rsttst>:
void rsttst()
{
  801c39:	55                   	push   %ebp
  801c3a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 28                	push   $0x28
  801c48:	e8 44 fb ff ff       	call   801791 <syscall>
  801c4d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c50:	90                   	nop
}
  801c51:	c9                   	leave  
  801c52:	c3                   	ret    

00801c53 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c53:	55                   	push   %ebp
  801c54:	89 e5                	mov    %esp,%ebp
  801c56:	83 ec 04             	sub    $0x4,%esp
  801c59:	8b 45 14             	mov    0x14(%ebp),%eax
  801c5c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c5f:	8b 55 18             	mov    0x18(%ebp),%edx
  801c62:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c66:	52                   	push   %edx
  801c67:	50                   	push   %eax
  801c68:	ff 75 10             	pushl  0x10(%ebp)
  801c6b:	ff 75 0c             	pushl  0xc(%ebp)
  801c6e:	ff 75 08             	pushl  0x8(%ebp)
  801c71:	6a 27                	push   $0x27
  801c73:	e8 19 fb ff ff       	call   801791 <syscall>
  801c78:	83 c4 18             	add    $0x18,%esp
	return ;
  801c7b:	90                   	nop
}
  801c7c:	c9                   	leave  
  801c7d:	c3                   	ret    

00801c7e <chktst>:
void chktst(uint32 n)
{
  801c7e:	55                   	push   %ebp
  801c7f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c81:	6a 00                	push   $0x0
  801c83:	6a 00                	push   $0x0
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	ff 75 08             	pushl  0x8(%ebp)
  801c8c:	6a 29                	push   $0x29
  801c8e:	e8 fe fa ff ff       	call   801791 <syscall>
  801c93:	83 c4 18             	add    $0x18,%esp
	return ;
  801c96:	90                   	nop
}
  801c97:	c9                   	leave  
  801c98:	c3                   	ret    

00801c99 <inctst>:

void inctst()
{
  801c99:	55                   	push   %ebp
  801c9a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c9c:	6a 00                	push   $0x0
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 2a                	push   $0x2a
  801ca8:	e8 e4 fa ff ff       	call   801791 <syscall>
  801cad:	83 c4 18             	add    $0x18,%esp
	return ;
  801cb0:	90                   	nop
}
  801cb1:	c9                   	leave  
  801cb2:	c3                   	ret    

00801cb3 <gettst>:
uint32 gettst()
{
  801cb3:	55                   	push   %ebp
  801cb4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 2b                	push   $0x2b
  801cc2:	e8 ca fa ff ff       	call   801791 <syscall>
  801cc7:	83 c4 18             	add    $0x18,%esp
}
  801cca:	c9                   	leave  
  801ccb:	c3                   	ret    

00801ccc <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ccc:	55                   	push   %ebp
  801ccd:	89 e5                	mov    %esp,%ebp
  801ccf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 2c                	push   $0x2c
  801cde:	e8 ae fa ff ff       	call   801791 <syscall>
  801ce3:	83 c4 18             	add    $0x18,%esp
  801ce6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801ce9:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801ced:	75 07                	jne    801cf6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801cef:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf4:	eb 05                	jmp    801cfb <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801cf6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cfb:	c9                   	leave  
  801cfc:	c3                   	ret    

00801cfd <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801cfd:	55                   	push   %ebp
  801cfe:	89 e5                	mov    %esp,%ebp
  801d00:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 2c                	push   $0x2c
  801d0f:	e8 7d fa ff ff       	call   801791 <syscall>
  801d14:	83 c4 18             	add    $0x18,%esp
  801d17:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d1a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d1e:	75 07                	jne    801d27 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d20:	b8 01 00 00 00       	mov    $0x1,%eax
  801d25:	eb 05                	jmp    801d2c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d27:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d2c:	c9                   	leave  
  801d2d:	c3                   	ret    

00801d2e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d2e:	55                   	push   %ebp
  801d2f:	89 e5                	mov    %esp,%ebp
  801d31:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d34:	6a 00                	push   $0x0
  801d36:	6a 00                	push   $0x0
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 2c                	push   $0x2c
  801d40:	e8 4c fa ff ff       	call   801791 <syscall>
  801d45:	83 c4 18             	add    $0x18,%esp
  801d48:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d4b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d4f:	75 07                	jne    801d58 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d51:	b8 01 00 00 00       	mov    $0x1,%eax
  801d56:	eb 05                	jmp    801d5d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d58:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d5d:	c9                   	leave  
  801d5e:	c3                   	ret    

00801d5f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d5f:	55                   	push   %ebp
  801d60:	89 e5                	mov    %esp,%ebp
  801d62:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 00                	push   $0x0
  801d6d:	6a 00                	push   $0x0
  801d6f:	6a 2c                	push   $0x2c
  801d71:	e8 1b fa ff ff       	call   801791 <syscall>
  801d76:	83 c4 18             	add    $0x18,%esp
  801d79:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d7c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d80:	75 07                	jne    801d89 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d82:	b8 01 00 00 00       	mov    $0x1,%eax
  801d87:	eb 05                	jmp    801d8e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d89:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d8e:	c9                   	leave  
  801d8f:	c3                   	ret    

00801d90 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d90:	55                   	push   %ebp
  801d91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	6a 00                	push   $0x0
  801d99:	6a 00                	push   $0x0
  801d9b:	ff 75 08             	pushl  0x8(%ebp)
  801d9e:	6a 2d                	push   $0x2d
  801da0:	e8 ec f9 ff ff       	call   801791 <syscall>
  801da5:	83 c4 18             	add    $0x18,%esp
	return ;
  801da8:	90                   	nop
}
  801da9:	c9                   	leave  
  801daa:	c3                   	ret    

00801dab <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801dab:	55                   	push   %ebp
  801dac:	89 e5                	mov    %esp,%ebp
  801dae:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801db1:	8b 55 08             	mov    0x8(%ebp),%edx
  801db4:	89 d0                	mov    %edx,%eax
  801db6:	c1 e0 02             	shl    $0x2,%eax
  801db9:	01 d0                	add    %edx,%eax
  801dbb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801dc2:	01 d0                	add    %edx,%eax
  801dc4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801dcb:	01 d0                	add    %edx,%eax
  801dcd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801dd4:	01 d0                	add    %edx,%eax
  801dd6:	c1 e0 04             	shl    $0x4,%eax
  801dd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801ddc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801de3:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801de6:	83 ec 0c             	sub    $0xc,%esp
  801de9:	50                   	push   %eax
  801dea:	e8 b8 fd ff ff       	call   801ba7 <sys_get_virtual_time>
  801def:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801df2:	eb 41                	jmp    801e35 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801df4:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801df7:	83 ec 0c             	sub    $0xc,%esp
  801dfa:	50                   	push   %eax
  801dfb:	e8 a7 fd ff ff       	call   801ba7 <sys_get_virtual_time>
  801e00:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801e03:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801e06:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e09:	29 c2                	sub    %eax,%edx
  801e0b:	89 d0                	mov    %edx,%eax
  801e0d:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801e10:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801e13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e16:	89 d1                	mov    %edx,%ecx
  801e18:	29 c1                	sub    %eax,%ecx
  801e1a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801e1d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e20:	39 c2                	cmp    %eax,%edx
  801e22:	0f 97 c0             	seta   %al
  801e25:	0f b6 c0             	movzbl %al,%eax
  801e28:	29 c1                	sub    %eax,%ecx
  801e2a:	89 c8                	mov    %ecx,%eax
  801e2c:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801e2f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801e32:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801e35:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e38:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e3b:	72 b7                	jb     801df4 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801e3d:	90                   	nop
  801e3e:	c9                   	leave  
  801e3f:	c3                   	ret    

00801e40 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801e40:	55                   	push   %ebp
  801e41:	89 e5                	mov    %esp,%ebp
  801e43:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801e46:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801e4d:	eb 03                	jmp    801e52 <busy_wait+0x12>
  801e4f:	ff 45 fc             	incl   -0x4(%ebp)
  801e52:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e55:	3b 45 08             	cmp    0x8(%ebp),%eax
  801e58:	72 f5                	jb     801e4f <busy_wait+0xf>
	return i;
  801e5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801e5d:	c9                   	leave  
  801e5e:	c3                   	ret    
  801e5f:	90                   	nop

00801e60 <__udivdi3>:
  801e60:	55                   	push   %ebp
  801e61:	57                   	push   %edi
  801e62:	56                   	push   %esi
  801e63:	53                   	push   %ebx
  801e64:	83 ec 1c             	sub    $0x1c,%esp
  801e67:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e6b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e6f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e73:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e77:	89 ca                	mov    %ecx,%edx
  801e79:	89 f8                	mov    %edi,%eax
  801e7b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e7f:	85 f6                	test   %esi,%esi
  801e81:	75 2d                	jne    801eb0 <__udivdi3+0x50>
  801e83:	39 cf                	cmp    %ecx,%edi
  801e85:	77 65                	ja     801eec <__udivdi3+0x8c>
  801e87:	89 fd                	mov    %edi,%ebp
  801e89:	85 ff                	test   %edi,%edi
  801e8b:	75 0b                	jne    801e98 <__udivdi3+0x38>
  801e8d:	b8 01 00 00 00       	mov    $0x1,%eax
  801e92:	31 d2                	xor    %edx,%edx
  801e94:	f7 f7                	div    %edi
  801e96:	89 c5                	mov    %eax,%ebp
  801e98:	31 d2                	xor    %edx,%edx
  801e9a:	89 c8                	mov    %ecx,%eax
  801e9c:	f7 f5                	div    %ebp
  801e9e:	89 c1                	mov    %eax,%ecx
  801ea0:	89 d8                	mov    %ebx,%eax
  801ea2:	f7 f5                	div    %ebp
  801ea4:	89 cf                	mov    %ecx,%edi
  801ea6:	89 fa                	mov    %edi,%edx
  801ea8:	83 c4 1c             	add    $0x1c,%esp
  801eab:	5b                   	pop    %ebx
  801eac:	5e                   	pop    %esi
  801ead:	5f                   	pop    %edi
  801eae:	5d                   	pop    %ebp
  801eaf:	c3                   	ret    
  801eb0:	39 ce                	cmp    %ecx,%esi
  801eb2:	77 28                	ja     801edc <__udivdi3+0x7c>
  801eb4:	0f bd fe             	bsr    %esi,%edi
  801eb7:	83 f7 1f             	xor    $0x1f,%edi
  801eba:	75 40                	jne    801efc <__udivdi3+0x9c>
  801ebc:	39 ce                	cmp    %ecx,%esi
  801ebe:	72 0a                	jb     801eca <__udivdi3+0x6a>
  801ec0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ec4:	0f 87 9e 00 00 00    	ja     801f68 <__udivdi3+0x108>
  801eca:	b8 01 00 00 00       	mov    $0x1,%eax
  801ecf:	89 fa                	mov    %edi,%edx
  801ed1:	83 c4 1c             	add    $0x1c,%esp
  801ed4:	5b                   	pop    %ebx
  801ed5:	5e                   	pop    %esi
  801ed6:	5f                   	pop    %edi
  801ed7:	5d                   	pop    %ebp
  801ed8:	c3                   	ret    
  801ed9:	8d 76 00             	lea    0x0(%esi),%esi
  801edc:	31 ff                	xor    %edi,%edi
  801ede:	31 c0                	xor    %eax,%eax
  801ee0:	89 fa                	mov    %edi,%edx
  801ee2:	83 c4 1c             	add    $0x1c,%esp
  801ee5:	5b                   	pop    %ebx
  801ee6:	5e                   	pop    %esi
  801ee7:	5f                   	pop    %edi
  801ee8:	5d                   	pop    %ebp
  801ee9:	c3                   	ret    
  801eea:	66 90                	xchg   %ax,%ax
  801eec:	89 d8                	mov    %ebx,%eax
  801eee:	f7 f7                	div    %edi
  801ef0:	31 ff                	xor    %edi,%edi
  801ef2:	89 fa                	mov    %edi,%edx
  801ef4:	83 c4 1c             	add    $0x1c,%esp
  801ef7:	5b                   	pop    %ebx
  801ef8:	5e                   	pop    %esi
  801ef9:	5f                   	pop    %edi
  801efa:	5d                   	pop    %ebp
  801efb:	c3                   	ret    
  801efc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f01:	89 eb                	mov    %ebp,%ebx
  801f03:	29 fb                	sub    %edi,%ebx
  801f05:	89 f9                	mov    %edi,%ecx
  801f07:	d3 e6                	shl    %cl,%esi
  801f09:	89 c5                	mov    %eax,%ebp
  801f0b:	88 d9                	mov    %bl,%cl
  801f0d:	d3 ed                	shr    %cl,%ebp
  801f0f:	89 e9                	mov    %ebp,%ecx
  801f11:	09 f1                	or     %esi,%ecx
  801f13:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f17:	89 f9                	mov    %edi,%ecx
  801f19:	d3 e0                	shl    %cl,%eax
  801f1b:	89 c5                	mov    %eax,%ebp
  801f1d:	89 d6                	mov    %edx,%esi
  801f1f:	88 d9                	mov    %bl,%cl
  801f21:	d3 ee                	shr    %cl,%esi
  801f23:	89 f9                	mov    %edi,%ecx
  801f25:	d3 e2                	shl    %cl,%edx
  801f27:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f2b:	88 d9                	mov    %bl,%cl
  801f2d:	d3 e8                	shr    %cl,%eax
  801f2f:	09 c2                	or     %eax,%edx
  801f31:	89 d0                	mov    %edx,%eax
  801f33:	89 f2                	mov    %esi,%edx
  801f35:	f7 74 24 0c          	divl   0xc(%esp)
  801f39:	89 d6                	mov    %edx,%esi
  801f3b:	89 c3                	mov    %eax,%ebx
  801f3d:	f7 e5                	mul    %ebp
  801f3f:	39 d6                	cmp    %edx,%esi
  801f41:	72 19                	jb     801f5c <__udivdi3+0xfc>
  801f43:	74 0b                	je     801f50 <__udivdi3+0xf0>
  801f45:	89 d8                	mov    %ebx,%eax
  801f47:	31 ff                	xor    %edi,%edi
  801f49:	e9 58 ff ff ff       	jmp    801ea6 <__udivdi3+0x46>
  801f4e:	66 90                	xchg   %ax,%ax
  801f50:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f54:	89 f9                	mov    %edi,%ecx
  801f56:	d3 e2                	shl    %cl,%edx
  801f58:	39 c2                	cmp    %eax,%edx
  801f5a:	73 e9                	jae    801f45 <__udivdi3+0xe5>
  801f5c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f5f:	31 ff                	xor    %edi,%edi
  801f61:	e9 40 ff ff ff       	jmp    801ea6 <__udivdi3+0x46>
  801f66:	66 90                	xchg   %ax,%ax
  801f68:	31 c0                	xor    %eax,%eax
  801f6a:	e9 37 ff ff ff       	jmp    801ea6 <__udivdi3+0x46>
  801f6f:	90                   	nop

00801f70 <__umoddi3>:
  801f70:	55                   	push   %ebp
  801f71:	57                   	push   %edi
  801f72:	56                   	push   %esi
  801f73:	53                   	push   %ebx
  801f74:	83 ec 1c             	sub    $0x1c,%esp
  801f77:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f7b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f7f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f83:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f87:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f8b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f8f:	89 f3                	mov    %esi,%ebx
  801f91:	89 fa                	mov    %edi,%edx
  801f93:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f97:	89 34 24             	mov    %esi,(%esp)
  801f9a:	85 c0                	test   %eax,%eax
  801f9c:	75 1a                	jne    801fb8 <__umoddi3+0x48>
  801f9e:	39 f7                	cmp    %esi,%edi
  801fa0:	0f 86 a2 00 00 00    	jbe    802048 <__umoddi3+0xd8>
  801fa6:	89 c8                	mov    %ecx,%eax
  801fa8:	89 f2                	mov    %esi,%edx
  801faa:	f7 f7                	div    %edi
  801fac:	89 d0                	mov    %edx,%eax
  801fae:	31 d2                	xor    %edx,%edx
  801fb0:	83 c4 1c             	add    $0x1c,%esp
  801fb3:	5b                   	pop    %ebx
  801fb4:	5e                   	pop    %esi
  801fb5:	5f                   	pop    %edi
  801fb6:	5d                   	pop    %ebp
  801fb7:	c3                   	ret    
  801fb8:	39 f0                	cmp    %esi,%eax
  801fba:	0f 87 ac 00 00 00    	ja     80206c <__umoddi3+0xfc>
  801fc0:	0f bd e8             	bsr    %eax,%ebp
  801fc3:	83 f5 1f             	xor    $0x1f,%ebp
  801fc6:	0f 84 ac 00 00 00    	je     802078 <__umoddi3+0x108>
  801fcc:	bf 20 00 00 00       	mov    $0x20,%edi
  801fd1:	29 ef                	sub    %ebp,%edi
  801fd3:	89 fe                	mov    %edi,%esi
  801fd5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801fd9:	89 e9                	mov    %ebp,%ecx
  801fdb:	d3 e0                	shl    %cl,%eax
  801fdd:	89 d7                	mov    %edx,%edi
  801fdf:	89 f1                	mov    %esi,%ecx
  801fe1:	d3 ef                	shr    %cl,%edi
  801fe3:	09 c7                	or     %eax,%edi
  801fe5:	89 e9                	mov    %ebp,%ecx
  801fe7:	d3 e2                	shl    %cl,%edx
  801fe9:	89 14 24             	mov    %edx,(%esp)
  801fec:	89 d8                	mov    %ebx,%eax
  801fee:	d3 e0                	shl    %cl,%eax
  801ff0:	89 c2                	mov    %eax,%edx
  801ff2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ff6:	d3 e0                	shl    %cl,%eax
  801ff8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ffc:	8b 44 24 08          	mov    0x8(%esp),%eax
  802000:	89 f1                	mov    %esi,%ecx
  802002:	d3 e8                	shr    %cl,%eax
  802004:	09 d0                	or     %edx,%eax
  802006:	d3 eb                	shr    %cl,%ebx
  802008:	89 da                	mov    %ebx,%edx
  80200a:	f7 f7                	div    %edi
  80200c:	89 d3                	mov    %edx,%ebx
  80200e:	f7 24 24             	mull   (%esp)
  802011:	89 c6                	mov    %eax,%esi
  802013:	89 d1                	mov    %edx,%ecx
  802015:	39 d3                	cmp    %edx,%ebx
  802017:	0f 82 87 00 00 00    	jb     8020a4 <__umoddi3+0x134>
  80201d:	0f 84 91 00 00 00    	je     8020b4 <__umoddi3+0x144>
  802023:	8b 54 24 04          	mov    0x4(%esp),%edx
  802027:	29 f2                	sub    %esi,%edx
  802029:	19 cb                	sbb    %ecx,%ebx
  80202b:	89 d8                	mov    %ebx,%eax
  80202d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802031:	d3 e0                	shl    %cl,%eax
  802033:	89 e9                	mov    %ebp,%ecx
  802035:	d3 ea                	shr    %cl,%edx
  802037:	09 d0                	or     %edx,%eax
  802039:	89 e9                	mov    %ebp,%ecx
  80203b:	d3 eb                	shr    %cl,%ebx
  80203d:	89 da                	mov    %ebx,%edx
  80203f:	83 c4 1c             	add    $0x1c,%esp
  802042:	5b                   	pop    %ebx
  802043:	5e                   	pop    %esi
  802044:	5f                   	pop    %edi
  802045:	5d                   	pop    %ebp
  802046:	c3                   	ret    
  802047:	90                   	nop
  802048:	89 fd                	mov    %edi,%ebp
  80204a:	85 ff                	test   %edi,%edi
  80204c:	75 0b                	jne    802059 <__umoddi3+0xe9>
  80204e:	b8 01 00 00 00       	mov    $0x1,%eax
  802053:	31 d2                	xor    %edx,%edx
  802055:	f7 f7                	div    %edi
  802057:	89 c5                	mov    %eax,%ebp
  802059:	89 f0                	mov    %esi,%eax
  80205b:	31 d2                	xor    %edx,%edx
  80205d:	f7 f5                	div    %ebp
  80205f:	89 c8                	mov    %ecx,%eax
  802061:	f7 f5                	div    %ebp
  802063:	89 d0                	mov    %edx,%eax
  802065:	e9 44 ff ff ff       	jmp    801fae <__umoddi3+0x3e>
  80206a:	66 90                	xchg   %ax,%ax
  80206c:	89 c8                	mov    %ecx,%eax
  80206e:	89 f2                	mov    %esi,%edx
  802070:	83 c4 1c             	add    $0x1c,%esp
  802073:	5b                   	pop    %ebx
  802074:	5e                   	pop    %esi
  802075:	5f                   	pop    %edi
  802076:	5d                   	pop    %ebp
  802077:	c3                   	ret    
  802078:	3b 04 24             	cmp    (%esp),%eax
  80207b:	72 06                	jb     802083 <__umoddi3+0x113>
  80207d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802081:	77 0f                	ja     802092 <__umoddi3+0x122>
  802083:	89 f2                	mov    %esi,%edx
  802085:	29 f9                	sub    %edi,%ecx
  802087:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80208b:	89 14 24             	mov    %edx,(%esp)
  80208e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802092:	8b 44 24 04          	mov    0x4(%esp),%eax
  802096:	8b 14 24             	mov    (%esp),%edx
  802099:	83 c4 1c             	add    $0x1c,%esp
  80209c:	5b                   	pop    %ebx
  80209d:	5e                   	pop    %esi
  80209e:	5f                   	pop    %edi
  80209f:	5d                   	pop    %ebp
  8020a0:	c3                   	ret    
  8020a1:	8d 76 00             	lea    0x0(%esi),%esi
  8020a4:	2b 04 24             	sub    (%esp),%eax
  8020a7:	19 fa                	sbb    %edi,%edx
  8020a9:	89 d1                	mov    %edx,%ecx
  8020ab:	89 c6                	mov    %eax,%esi
  8020ad:	e9 71 ff ff ff       	jmp    802023 <__umoddi3+0xb3>
  8020b2:	66 90                	xchg   %ax,%ax
  8020b4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8020b8:	72 ea                	jb     8020a4 <__umoddi3+0x134>
  8020ba:	89 d9                	mov    %ebx,%ecx
  8020bc:	e9 62 ff ff ff       	jmp    802023 <__umoddi3+0xb3>
