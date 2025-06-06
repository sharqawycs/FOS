
obj/user/tst_sharing_4:     file format elf32-i386


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
  800031:	e8 24 05 00 00       	call   80055a <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the free of shared variables (create_shared_memory)
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
  80008d:	68 c0 21 80 00       	push   $0x8021c0
  800092:	6a 12                	push   $0x12
  800094:	68 dc 21 80 00       	push   $0x8021dc
  800099:	e8 be 05 00 00       	call   80065c <_panic>
	}

	cprintf("************************************************\n");
  80009e:	83 ec 0c             	sub    $0xc,%esp
  8000a1:	68 f4 21 80 00       	push   $0x8021f4
  8000a6:	e8 65 08 00 00       	call   800910 <cprintf>
  8000ab:	83 c4 10             	add    $0x10,%esp
	cprintf("MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  8000ae:	83 ec 0c             	sub    $0xc,%esp
  8000b1:	68 28 22 80 00       	push   $0x802228
  8000b6:	e8 55 08 00 00       	call   800910 <cprintf>
  8000bb:	83 c4 10             	add    $0x10,%esp
	cprintf("************************************************\n\n\n");
  8000be:	83 ec 0c             	sub    $0xc,%esp
  8000c1:	68 84 22 80 00       	push   $0x802284
  8000c6:	e8 45 08 00 00       	call   800910 <cprintf>
  8000cb:	83 c4 10             	add    $0x10,%esp

	int Mega = 1024*1024;
  8000ce:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000d5:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	int envID = sys_getenvid();
  8000dc:	e8 d1 18 00 00       	call   8019b2 <sys_getenvid>
  8000e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	cprintf("STEP A: checking free of a shared object ... \n");
  8000e4:	83 ec 0c             	sub    $0xc,%esp
  8000e7:	68 b8 22 80 00       	push   $0x8022b8
  8000ec:	e8 1f 08 00 00       	call   800910 <cprintf>
  8000f1:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x;
		int freeFrames = sys_calculate_free_frames() ;
  8000f4:	e8 9d 19 00 00       	call   801a96 <sys_calculate_free_frames>
  8000f9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8000fc:	83 ec 04             	sub    $0x4,%esp
  8000ff:	6a 01                	push   $0x1
  800101:	68 00 10 00 00       	push   $0x1000
  800106:	68 e7 22 80 00       	push   $0x8022e7
  80010b:	e8 8a 15 00 00       	call   80169a <smalloc>
  800110:	83 c4 10             	add    $0x10,%esp
  800113:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if (x != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800116:	81 7d dc 00 00 00 80 	cmpl   $0x80000000,-0x24(%ebp)
  80011d:	74 14                	je     800133 <_main+0xfb>
  80011f:	83 ec 04             	sub    $0x4,%esp
  800122:	68 ec 22 80 00       	push   $0x8022ec
  800127:	6a 21                	push   $0x21
  800129:	68 dc 21 80 00       	push   $0x8021dc
  80012e:	e8 29 05 00 00       	call   80065c <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800133:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800136:	e8 5b 19 00 00       	call   801a96 <sys_calculate_free_frames>
  80013b:	29 c3                	sub    %eax,%ebx
  80013d:	89 d8                	mov    %ebx,%eax
  80013f:	83 f8 04             	cmp    $0x4,%eax
  800142:	74 14                	je     800158 <_main+0x120>
  800144:	83 ec 04             	sub    $0x4,%esp
  800147:	68 58 23 80 00       	push   $0x802358
  80014c:	6a 22                	push   $0x22
  80014e:	68 dc 21 80 00       	push   $0x8021dc
  800153:	e8 04 05 00 00       	call   80065c <_panic>

		sfree(x);
  800158:	83 ec 0c             	sub    $0xc,%esp
  80015b:	ff 75 dc             	pushl  -0x24(%ebp)
  80015e:	e8 8d 17 00 00       	call   8018f0 <sfree>
  800163:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) ==  0+0+2) panic("Wrong free: make sure that you free the shared object by calling free_share_object()");
  800166:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800169:	e8 28 19 00 00       	call   801a96 <sys_calculate_free_frames>
  80016e:	29 c3                	sub    %eax,%ebx
  800170:	89 d8                	mov    %ebx,%eax
  800172:	83 f8 02             	cmp    $0x2,%eax
  800175:	75 14                	jne    80018b <_main+0x153>
  800177:	83 ec 04             	sub    $0x4,%esp
  80017a:	68 d8 23 80 00       	push   $0x8023d8
  80017f:	6a 25                	push   $0x25
  800181:	68 dc 21 80 00       	push   $0x8021dc
  800186:	e8 d1 04 00 00       	call   80065c <_panic>
		else if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: revise your freeSharedObject logic");
  80018b:	e8 06 19 00 00       	call   801a96 <sys_calculate_free_frames>
  800190:	89 c2                	mov    %eax,%edx
  800192:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800195:	39 c2                	cmp    %eax,%edx
  800197:	74 14                	je     8001ad <_main+0x175>
  800199:	83 ec 04             	sub    $0x4,%esp
  80019c:	68 30 24 80 00       	push   $0x802430
  8001a1:	6a 26                	push   $0x26
  8001a3:	68 dc 21 80 00       	push   $0x8021dc
  8001a8:	e8 af 04 00 00       	call   80065c <_panic>
	}
	cprintf("Step A completed successfully!!\n\n\n");
  8001ad:	83 ec 0c             	sub    $0xc,%esp
  8001b0:	68 60 24 80 00       	push   $0x802460
  8001b5:	e8 56 07 00 00       	call   800910 <cprintf>
  8001ba:	83 c4 10             	add    $0x10,%esp


	cprintf("STEP B: checking free of 2 shared objects ... \n");
  8001bd:	83 ec 0c             	sub    $0xc,%esp
  8001c0:	68 84 24 80 00       	push   $0x802484
  8001c5:	e8 46 07 00 00       	call   800910 <cprintf>
  8001ca:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x, *z ;
		int freeFrames = sys_calculate_free_frames() ;
  8001cd:	e8 c4 18 00 00       	call   801a96 <sys_calculate_free_frames>
  8001d2:	89 45 d8             	mov    %eax,-0x28(%ebp)
		z = smalloc("z", PAGE_SIZE, 1);
  8001d5:	83 ec 04             	sub    $0x4,%esp
  8001d8:	6a 01                	push   $0x1
  8001da:	68 00 10 00 00       	push   $0x1000
  8001df:	68 b4 24 80 00       	push   $0x8024b4
  8001e4:	e8 b1 14 00 00       	call   80169a <smalloc>
  8001e9:	83 c4 10             	add    $0x10,%esp
  8001ec:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8001ef:	83 ec 04             	sub    $0x4,%esp
  8001f2:	6a 01                	push   $0x1
  8001f4:	68 00 10 00 00       	push   $0x1000
  8001f9:	68 e7 22 80 00       	push   $0x8022e7
  8001fe:	e8 97 14 00 00       	call   80169a <smalloc>
  800203:	83 c4 10             	add    $0x10,%esp
  800206:	89 45 d0             	mov    %eax,-0x30(%ebp)

		if(x == NULL) panic("Wrong free: make sure that you free the shared object by calling free_share_object()");
  800209:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
  80020d:	75 14                	jne    800223 <_main+0x1eb>
  80020f:	83 ec 04             	sub    $0x4,%esp
  800212:	68 d8 23 80 00       	push   $0x8023d8
  800217:	6a 32                	push   $0x32
  800219:	68 dc 21 80 00       	push   $0x8021dc
  80021e:	e8 39 04 00 00       	call   80065c <_panic>

		if ((freeFrames - sys_calculate_free_frames()) !=  2+1+4) panic("Wrong previous free: make sure that you correctly free shared object before (Step A)");
  800223:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800226:	e8 6b 18 00 00       	call   801a96 <sys_calculate_free_frames>
  80022b:	29 c3                	sub    %eax,%ebx
  80022d:	89 d8                	mov    %ebx,%eax
  80022f:	83 f8 07             	cmp    $0x7,%eax
  800232:	74 14                	je     800248 <_main+0x210>
  800234:	83 ec 04             	sub    $0x4,%esp
  800237:	68 b8 24 80 00       	push   $0x8024b8
  80023c:	6a 34                	push   $0x34
  80023e:	68 dc 21 80 00       	push   $0x8021dc
  800243:	e8 14 04 00 00       	call   80065c <_panic>

		sfree(z);
  800248:	83 ec 0c             	sub    $0xc,%esp
  80024b:	ff 75 d4             	pushl  -0x2c(%ebp)
  80024e:	e8 9d 16 00 00       	call   8018f0 <sfree>
  800253:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong free: check your logic");
  800256:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800259:	e8 38 18 00 00       	call   801a96 <sys_calculate_free_frames>
  80025e:	29 c3                	sub    %eax,%ebx
  800260:	89 d8                	mov    %ebx,%eax
  800262:	83 f8 04             	cmp    $0x4,%eax
  800265:	74 14                	je     80027b <_main+0x243>
  800267:	83 ec 04             	sub    $0x4,%esp
  80026a:	68 0d 25 80 00       	push   $0x80250d
  80026f:	6a 37                	push   $0x37
  800271:	68 dc 21 80 00       	push   $0x8021dc
  800276:	e8 e1 03 00 00       	call   80065c <_panic>

		sfree(x);
  80027b:	83 ec 0c             	sub    $0xc,%esp
  80027e:	ff 75 d0             	pushl  -0x30(%ebp)
  800281:	e8 6a 16 00 00       	call   8018f0 <sfree>
  800286:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: check your logic");
  800289:	e8 08 18 00 00       	call   801a96 <sys_calculate_free_frames>
  80028e:	89 c2                	mov    %eax,%edx
  800290:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800293:	39 c2                	cmp    %eax,%edx
  800295:	74 14                	je     8002ab <_main+0x273>
  800297:	83 ec 04             	sub    $0x4,%esp
  80029a:	68 0d 25 80 00       	push   $0x80250d
  80029f:	6a 3a                	push   $0x3a
  8002a1:	68 dc 21 80 00       	push   $0x8021dc
  8002a6:	e8 b1 03 00 00       	call   80065c <_panic>

	}
	cprintf("Step B completed successfully!!\n\n\n");
  8002ab:	83 ec 0c             	sub    $0xc,%esp
  8002ae:	68 2c 25 80 00       	push   $0x80252c
  8002b3:	e8 58 06 00 00       	call   800910 <cprintf>
  8002b8:	83 c4 10             	add    $0x10,%esp

	cprintf("STEP C: checking range of loop during free... \n");
  8002bb:	83 ec 0c             	sub    $0xc,%esp
  8002be:	68 50 25 80 00       	push   $0x802550
  8002c3:	e8 48 06 00 00       	call   800910 <cprintf>
  8002c8:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *w, *u;
		int freeFrames = sys_calculate_free_frames() ;
  8002cb:	e8 c6 17 00 00       	call   801a96 <sys_calculate_free_frames>
  8002d0:	89 45 cc             	mov    %eax,-0x34(%ebp)
		w = smalloc("w", 3 * PAGE_SIZE+1, 1);
  8002d3:	83 ec 04             	sub    $0x4,%esp
  8002d6:	6a 01                	push   $0x1
  8002d8:	68 01 30 00 00       	push   $0x3001
  8002dd:	68 80 25 80 00       	push   $0x802580
  8002e2:	e8 b3 13 00 00       	call   80169a <smalloc>
  8002e7:	83 c4 10             	add    $0x10,%esp
  8002ea:	89 45 c8             	mov    %eax,-0x38(%ebp)
		u = smalloc("u", PAGE_SIZE, 1);
  8002ed:	83 ec 04             	sub    $0x4,%esp
  8002f0:	6a 01                	push   $0x1
  8002f2:	68 00 10 00 00       	push   $0x1000
  8002f7:	68 82 25 80 00       	push   $0x802582
  8002fc:	e8 99 13 00 00       	call   80169a <smalloc>
  800301:	83 c4 10             	add    $0x10,%esp
  800304:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		if ((freeFrames - sys_calculate_free_frames()) != 5+1+4) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800307:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  80030a:	e8 87 17 00 00       	call   801a96 <sys_calculate_free_frames>
  80030f:	29 c3                	sub    %eax,%ebx
  800311:	89 d8                	mov    %ebx,%eax
  800313:	83 f8 0a             	cmp    $0xa,%eax
  800316:	74 14                	je     80032c <_main+0x2f4>
  800318:	83 ec 04             	sub    $0x4,%esp
  80031b:	68 58 23 80 00       	push   $0x802358
  800320:	6a 46                	push   $0x46
  800322:	68 dc 21 80 00       	push   $0x8021dc
  800327:	e8 30 03 00 00       	call   80065c <_panic>

		sfree(w);
  80032c:	83 ec 0c             	sub    $0xc,%esp
  80032f:	ff 75 c8             	pushl  -0x38(%ebp)
  800332:	e8 b9 15 00 00       	call   8018f0 <sfree>
  800337:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong free: check your logic");
  80033a:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  80033d:	e8 54 17 00 00       	call   801a96 <sys_calculate_free_frames>
  800342:	29 c3                	sub    %eax,%ebx
  800344:	89 d8                	mov    %ebx,%eax
  800346:	83 f8 04             	cmp    $0x4,%eax
  800349:	74 14                	je     80035f <_main+0x327>
  80034b:	83 ec 04             	sub    $0x4,%esp
  80034e:	68 0d 25 80 00       	push   $0x80250d
  800353:	6a 49                	push   $0x49
  800355:	68 dc 21 80 00       	push   $0x8021dc
  80035a:	e8 fd 02 00 00       	call   80065c <_panic>

		uint32 *o;
		o = smalloc("o", 2 * PAGE_SIZE-1,1);
  80035f:	83 ec 04             	sub    $0x4,%esp
  800362:	6a 01                	push   $0x1
  800364:	68 ff 1f 00 00       	push   $0x1fff
  800369:	68 84 25 80 00       	push   $0x802584
  80036e:	e8 27 13 00 00       	call   80169a <smalloc>
  800373:	83 c4 10             	add    $0x10,%esp
  800376:	89 45 c0             	mov    %eax,-0x40(%ebp)

		if ((freeFrames - sys_calculate_free_frames()) != 3+1+4) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800379:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  80037c:	e8 15 17 00 00       	call   801a96 <sys_calculate_free_frames>
  800381:	29 c3                	sub    %eax,%ebx
  800383:	89 d8                	mov    %ebx,%eax
  800385:	83 f8 08             	cmp    $0x8,%eax
  800388:	74 14                	je     80039e <_main+0x366>
  80038a:	83 ec 04             	sub    $0x4,%esp
  80038d:	68 58 23 80 00       	push   $0x802358
  800392:	6a 4e                	push   $0x4e
  800394:	68 dc 21 80 00       	push   $0x8021dc
  800399:	e8 be 02 00 00       	call   80065c <_panic>

		sfree(o);
  80039e:	83 ec 0c             	sub    $0xc,%esp
  8003a1:	ff 75 c0             	pushl  -0x40(%ebp)
  8003a4:	e8 47 15 00 00       	call   8018f0 <sfree>
  8003a9:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong free: check your logic");
  8003ac:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  8003af:	e8 e2 16 00 00       	call   801a96 <sys_calculate_free_frames>
  8003b4:	29 c3                	sub    %eax,%ebx
  8003b6:	89 d8                	mov    %ebx,%eax
  8003b8:	83 f8 04             	cmp    $0x4,%eax
  8003bb:	74 14                	je     8003d1 <_main+0x399>
  8003bd:	83 ec 04             	sub    $0x4,%esp
  8003c0:	68 0d 25 80 00       	push   $0x80250d
  8003c5:	6a 51                	push   $0x51
  8003c7:	68 dc 21 80 00       	push   $0x8021dc
  8003cc:	e8 8b 02 00 00       	call   80065c <_panic>

		sfree(u);
  8003d1:	83 ec 0c             	sub    $0xc,%esp
  8003d4:	ff 75 c4             	pushl  -0x3c(%ebp)
  8003d7:	e8 14 15 00 00       	call   8018f0 <sfree>
  8003dc:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: check your logic");
  8003df:	e8 b2 16 00 00       	call   801a96 <sys_calculate_free_frames>
  8003e4:	89 c2                	mov    %eax,%edx
  8003e6:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8003e9:	39 c2                	cmp    %eax,%edx
  8003eb:	74 14                	je     800401 <_main+0x3c9>
  8003ed:	83 ec 04             	sub    $0x4,%esp
  8003f0:	68 0d 25 80 00       	push   $0x80250d
  8003f5:	6a 54                	push   $0x54
  8003f7:	68 dc 21 80 00       	push   $0x8021dc
  8003fc:	e8 5b 02 00 00       	call   80065c <_panic>


		//Checking boundaries of page tables
		freeFrames = sys_calculate_free_frames() ;
  800401:	e8 90 16 00 00       	call   801a96 <sys_calculate_free_frames>
  800406:	89 45 cc             	mov    %eax,-0x34(%ebp)
		w = smalloc("w", 3 * Mega - 1*kilo, 1);
  800409:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80040c:	89 c2                	mov    %eax,%edx
  80040e:	01 d2                	add    %edx,%edx
  800410:	01 d0                	add    %edx,%eax
  800412:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800415:	83 ec 04             	sub    $0x4,%esp
  800418:	6a 01                	push   $0x1
  80041a:	50                   	push   %eax
  80041b:	68 80 25 80 00       	push   $0x802580
  800420:	e8 75 12 00 00       	call   80169a <smalloc>
  800425:	83 c4 10             	add    $0x10,%esp
  800428:	89 45 c8             	mov    %eax,-0x38(%ebp)
		u = smalloc("u", 7 * Mega - 1*kilo, 1);
  80042b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80042e:	89 d0                	mov    %edx,%eax
  800430:	01 c0                	add    %eax,%eax
  800432:	01 d0                	add    %edx,%eax
  800434:	01 c0                	add    %eax,%eax
  800436:	01 d0                	add    %edx,%eax
  800438:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80043b:	83 ec 04             	sub    $0x4,%esp
  80043e:	6a 01                	push   $0x1
  800440:	50                   	push   %eax
  800441:	68 82 25 80 00       	push   $0x802582
  800446:	e8 4f 12 00 00       	call   80169a <smalloc>
  80044b:	83 c4 10             	add    $0x10,%esp
  80044e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		o = smalloc("o", 2 * Mega + 1*kilo, 1);
  800451:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800454:	01 c0                	add    %eax,%eax
  800456:	89 c2                	mov    %eax,%edx
  800458:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80045b:	01 d0                	add    %edx,%eax
  80045d:	83 ec 04             	sub    $0x4,%esp
  800460:	6a 01                	push   $0x1
  800462:	50                   	push   %eax
  800463:	68 84 25 80 00       	push   $0x802584
  800468:	e8 2d 12 00 00       	call   80169a <smalloc>
  80046d:	83 c4 10             	add    $0x10,%esp
  800470:	89 45 c0             	mov    %eax,-0x40(%ebp)

		if ((freeFrames - sys_calculate_free_frames()) != 3073+4+7) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800473:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800476:	e8 1b 16 00 00       	call   801a96 <sys_calculate_free_frames>
  80047b:	29 c3                	sub    %eax,%ebx
  80047d:	89 d8                	mov    %ebx,%eax
  80047f:	3d 0c 0c 00 00       	cmp    $0xc0c,%eax
  800484:	74 14                	je     80049a <_main+0x462>
  800486:	83 ec 04             	sub    $0x4,%esp
  800489:	68 58 23 80 00       	push   $0x802358
  80048e:	6a 5d                	push   $0x5d
  800490:	68 dc 21 80 00       	push   $0x8021dc
  800495:	e8 c2 01 00 00       	call   80065c <_panic>

		sfree(o);
  80049a:	83 ec 0c             	sub    $0xc,%esp
  80049d:	ff 75 c0             	pushl  -0x40(%ebp)
  8004a0:	e8 4b 14 00 00       	call   8018f0 <sfree>
  8004a5:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  2560+3+5) panic("Wrong free: check your logic");
  8004a8:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  8004ab:	e8 e6 15 00 00       	call   801a96 <sys_calculate_free_frames>
  8004b0:	29 c3                	sub    %eax,%ebx
  8004b2:	89 d8                	mov    %ebx,%eax
  8004b4:	3d 08 0a 00 00       	cmp    $0xa08,%eax
  8004b9:	74 14                	je     8004cf <_main+0x497>
  8004bb:	83 ec 04             	sub    $0x4,%esp
  8004be:	68 0d 25 80 00       	push   $0x80250d
  8004c3:	6a 60                	push   $0x60
  8004c5:	68 dc 21 80 00       	push   $0x8021dc
  8004ca:	e8 8d 01 00 00       	call   80065c <_panic>

		sfree(w);
  8004cf:	83 ec 0c             	sub    $0xc,%esp
  8004d2:	ff 75 c8             	pushl  -0x38(%ebp)
  8004d5:	e8 16 14 00 00       	call   8018f0 <sfree>
  8004da:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1792+3+3) panic("Wrong free: check your logic");
  8004dd:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  8004e0:	e8 b1 15 00 00       	call   801a96 <sys_calculate_free_frames>
  8004e5:	29 c3                	sub    %eax,%ebx
  8004e7:	89 d8                	mov    %ebx,%eax
  8004e9:	3d 06 07 00 00       	cmp    $0x706,%eax
  8004ee:	74 14                	je     800504 <_main+0x4cc>
  8004f0:	83 ec 04             	sub    $0x4,%esp
  8004f3:	68 0d 25 80 00       	push   $0x80250d
  8004f8:	6a 63                	push   $0x63
  8004fa:	68 dc 21 80 00       	push   $0x8021dc
  8004ff:	e8 58 01 00 00       	call   80065c <_panic>

		sfree(u);
  800504:	83 ec 0c             	sub    $0xc,%esp
  800507:	ff 75 c4             	pushl  -0x3c(%ebp)
  80050a:	e8 e1 13 00 00       	call   8018f0 <sfree>
  80050f:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: check your logic");
  800512:	e8 7f 15 00 00       	call   801a96 <sys_calculate_free_frames>
  800517:	89 c2                	mov    %eax,%edx
  800519:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80051c:	39 c2                	cmp    %eax,%edx
  80051e:	74 14                	je     800534 <_main+0x4fc>
  800520:	83 ec 04             	sub    $0x4,%esp
  800523:	68 0d 25 80 00       	push   $0x80250d
  800528:	6a 66                	push   $0x66
  80052a:	68 dc 21 80 00       	push   $0x8021dc
  80052f:	e8 28 01 00 00       	call   80065c <_panic>
	}
	cprintf("Step C completed successfully!!\n\n\n");
  800534:	83 ec 0c             	sub    $0xc,%esp
  800537:	68 88 25 80 00       	push   $0x802588
  80053c:	e8 cf 03 00 00       	call   800910 <cprintf>
  800541:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! Test of freeSharedObjects [4] completed successfully!!\n\n\n");
  800544:	83 ec 0c             	sub    $0xc,%esp
  800547:	68 ac 25 80 00       	push   $0x8025ac
  80054c:	e8 bf 03 00 00       	call   800910 <cprintf>
  800551:	83 c4 10             	add    $0x10,%esp

	return;
  800554:	90                   	nop
}
  800555:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800558:	c9                   	leave  
  800559:	c3                   	ret    

0080055a <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80055a:	55                   	push   %ebp
  80055b:	89 e5                	mov    %esp,%ebp
  80055d:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800560:	e8 66 14 00 00       	call   8019cb <sys_getenvindex>
  800565:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800568:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80056b:	89 d0                	mov    %edx,%eax
  80056d:	01 c0                	add    %eax,%eax
  80056f:	01 d0                	add    %edx,%eax
  800571:	c1 e0 02             	shl    $0x2,%eax
  800574:	01 d0                	add    %edx,%eax
  800576:	c1 e0 06             	shl    $0x6,%eax
  800579:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80057e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800583:	a1 20 30 80 00       	mov    0x803020,%eax
  800588:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80058e:	84 c0                	test   %al,%al
  800590:	74 0f                	je     8005a1 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800592:	a1 20 30 80 00       	mov    0x803020,%eax
  800597:	05 f4 02 00 00       	add    $0x2f4,%eax
  80059c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005a1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005a5:	7e 0a                	jle    8005b1 <libmain+0x57>
		binaryname = argv[0];
  8005a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005aa:	8b 00                	mov    (%eax),%eax
  8005ac:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8005b1:	83 ec 08             	sub    $0x8,%esp
  8005b4:	ff 75 0c             	pushl  0xc(%ebp)
  8005b7:	ff 75 08             	pushl  0x8(%ebp)
  8005ba:	e8 79 fa ff ff       	call   800038 <_main>
  8005bf:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8005c2:	e8 9f 15 00 00       	call   801b66 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8005c7:	83 ec 0c             	sub    $0xc,%esp
  8005ca:	68 10 26 80 00       	push   $0x802610
  8005cf:	e8 3c 03 00 00       	call   800910 <cprintf>
  8005d4:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8005d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8005dc:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8005e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e7:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8005ed:	83 ec 04             	sub    $0x4,%esp
  8005f0:	52                   	push   %edx
  8005f1:	50                   	push   %eax
  8005f2:	68 38 26 80 00       	push   $0x802638
  8005f7:	e8 14 03 00 00       	call   800910 <cprintf>
  8005fc:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8005ff:	a1 20 30 80 00       	mov    0x803020,%eax
  800604:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80060a:	83 ec 08             	sub    $0x8,%esp
  80060d:	50                   	push   %eax
  80060e:	68 5d 26 80 00       	push   $0x80265d
  800613:	e8 f8 02 00 00       	call   800910 <cprintf>
  800618:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80061b:	83 ec 0c             	sub    $0xc,%esp
  80061e:	68 10 26 80 00       	push   $0x802610
  800623:	e8 e8 02 00 00       	call   800910 <cprintf>
  800628:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80062b:	e8 50 15 00 00       	call   801b80 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800630:	e8 19 00 00 00       	call   80064e <exit>
}
  800635:	90                   	nop
  800636:	c9                   	leave  
  800637:	c3                   	ret    

00800638 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800638:	55                   	push   %ebp
  800639:	89 e5                	mov    %esp,%ebp
  80063b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80063e:	83 ec 0c             	sub    $0xc,%esp
  800641:	6a 00                	push   $0x0
  800643:	e8 4f 13 00 00       	call   801997 <sys_env_destroy>
  800648:	83 c4 10             	add    $0x10,%esp
}
  80064b:	90                   	nop
  80064c:	c9                   	leave  
  80064d:	c3                   	ret    

0080064e <exit>:

void
exit(void)
{
  80064e:	55                   	push   %ebp
  80064f:	89 e5                	mov    %esp,%ebp
  800651:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800654:	e8 a4 13 00 00       	call   8019fd <sys_env_exit>
}
  800659:	90                   	nop
  80065a:	c9                   	leave  
  80065b:	c3                   	ret    

0080065c <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80065c:	55                   	push   %ebp
  80065d:	89 e5                	mov    %esp,%ebp
  80065f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800662:	8d 45 10             	lea    0x10(%ebp),%eax
  800665:	83 c0 04             	add    $0x4,%eax
  800668:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80066b:	a1 30 30 80 00       	mov    0x803030,%eax
  800670:	85 c0                	test   %eax,%eax
  800672:	74 16                	je     80068a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800674:	a1 30 30 80 00       	mov    0x803030,%eax
  800679:	83 ec 08             	sub    $0x8,%esp
  80067c:	50                   	push   %eax
  80067d:	68 74 26 80 00       	push   $0x802674
  800682:	e8 89 02 00 00       	call   800910 <cprintf>
  800687:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80068a:	a1 00 30 80 00       	mov    0x803000,%eax
  80068f:	ff 75 0c             	pushl  0xc(%ebp)
  800692:	ff 75 08             	pushl  0x8(%ebp)
  800695:	50                   	push   %eax
  800696:	68 79 26 80 00       	push   $0x802679
  80069b:	e8 70 02 00 00       	call   800910 <cprintf>
  8006a0:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8006a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8006a6:	83 ec 08             	sub    $0x8,%esp
  8006a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8006ac:	50                   	push   %eax
  8006ad:	e8 f3 01 00 00       	call   8008a5 <vcprintf>
  8006b2:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8006b5:	83 ec 08             	sub    $0x8,%esp
  8006b8:	6a 00                	push   $0x0
  8006ba:	68 95 26 80 00       	push   $0x802695
  8006bf:	e8 e1 01 00 00       	call   8008a5 <vcprintf>
  8006c4:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8006c7:	e8 82 ff ff ff       	call   80064e <exit>

	// should not return here
	while (1) ;
  8006cc:	eb fe                	jmp    8006cc <_panic+0x70>

008006ce <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8006ce:	55                   	push   %ebp
  8006cf:	89 e5                	mov    %esp,%ebp
  8006d1:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8006d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8006d9:	8b 50 74             	mov    0x74(%eax),%edx
  8006dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006df:	39 c2                	cmp    %eax,%edx
  8006e1:	74 14                	je     8006f7 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8006e3:	83 ec 04             	sub    $0x4,%esp
  8006e6:	68 98 26 80 00       	push   $0x802698
  8006eb:	6a 26                	push   $0x26
  8006ed:	68 e4 26 80 00       	push   $0x8026e4
  8006f2:	e8 65 ff ff ff       	call   80065c <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8006f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8006fe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800705:	e9 c2 00 00 00       	jmp    8007cc <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80070a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80070d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800714:	8b 45 08             	mov    0x8(%ebp),%eax
  800717:	01 d0                	add    %edx,%eax
  800719:	8b 00                	mov    (%eax),%eax
  80071b:	85 c0                	test   %eax,%eax
  80071d:	75 08                	jne    800727 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80071f:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800722:	e9 a2 00 00 00       	jmp    8007c9 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800727:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80072e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800735:	eb 69                	jmp    8007a0 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800737:	a1 20 30 80 00       	mov    0x803020,%eax
  80073c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800742:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800745:	89 d0                	mov    %edx,%eax
  800747:	01 c0                	add    %eax,%eax
  800749:	01 d0                	add    %edx,%eax
  80074b:	c1 e0 02             	shl    $0x2,%eax
  80074e:	01 c8                	add    %ecx,%eax
  800750:	8a 40 04             	mov    0x4(%eax),%al
  800753:	84 c0                	test   %al,%al
  800755:	75 46                	jne    80079d <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800757:	a1 20 30 80 00       	mov    0x803020,%eax
  80075c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800762:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800765:	89 d0                	mov    %edx,%eax
  800767:	01 c0                	add    %eax,%eax
  800769:	01 d0                	add    %edx,%eax
  80076b:	c1 e0 02             	shl    $0x2,%eax
  80076e:	01 c8                	add    %ecx,%eax
  800770:	8b 00                	mov    (%eax),%eax
  800772:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800775:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800778:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80077d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80077f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800782:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800789:	8b 45 08             	mov    0x8(%ebp),%eax
  80078c:	01 c8                	add    %ecx,%eax
  80078e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800790:	39 c2                	cmp    %eax,%edx
  800792:	75 09                	jne    80079d <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800794:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80079b:	eb 12                	jmp    8007af <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80079d:	ff 45 e8             	incl   -0x18(%ebp)
  8007a0:	a1 20 30 80 00       	mov    0x803020,%eax
  8007a5:	8b 50 74             	mov    0x74(%eax),%edx
  8007a8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007ab:	39 c2                	cmp    %eax,%edx
  8007ad:	77 88                	ja     800737 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8007af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8007b3:	75 14                	jne    8007c9 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8007b5:	83 ec 04             	sub    $0x4,%esp
  8007b8:	68 f0 26 80 00       	push   $0x8026f0
  8007bd:	6a 3a                	push   $0x3a
  8007bf:	68 e4 26 80 00       	push   $0x8026e4
  8007c4:	e8 93 fe ff ff       	call   80065c <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8007c9:	ff 45 f0             	incl   -0x10(%ebp)
  8007cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007cf:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8007d2:	0f 8c 32 ff ff ff    	jl     80070a <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8007d8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007df:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8007e6:	eb 26                	jmp    80080e <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8007e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8007ed:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007f3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007f6:	89 d0                	mov    %edx,%eax
  8007f8:	01 c0                	add    %eax,%eax
  8007fa:	01 d0                	add    %edx,%eax
  8007fc:	c1 e0 02             	shl    $0x2,%eax
  8007ff:	01 c8                	add    %ecx,%eax
  800801:	8a 40 04             	mov    0x4(%eax),%al
  800804:	3c 01                	cmp    $0x1,%al
  800806:	75 03                	jne    80080b <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800808:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80080b:	ff 45 e0             	incl   -0x20(%ebp)
  80080e:	a1 20 30 80 00       	mov    0x803020,%eax
  800813:	8b 50 74             	mov    0x74(%eax),%edx
  800816:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800819:	39 c2                	cmp    %eax,%edx
  80081b:	77 cb                	ja     8007e8 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80081d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800820:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800823:	74 14                	je     800839 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800825:	83 ec 04             	sub    $0x4,%esp
  800828:	68 44 27 80 00       	push   $0x802744
  80082d:	6a 44                	push   $0x44
  80082f:	68 e4 26 80 00       	push   $0x8026e4
  800834:	e8 23 fe ff ff       	call   80065c <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800839:	90                   	nop
  80083a:	c9                   	leave  
  80083b:	c3                   	ret    

0080083c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80083c:	55                   	push   %ebp
  80083d:	89 e5                	mov    %esp,%ebp
  80083f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800842:	8b 45 0c             	mov    0xc(%ebp),%eax
  800845:	8b 00                	mov    (%eax),%eax
  800847:	8d 48 01             	lea    0x1(%eax),%ecx
  80084a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80084d:	89 0a                	mov    %ecx,(%edx)
  80084f:	8b 55 08             	mov    0x8(%ebp),%edx
  800852:	88 d1                	mov    %dl,%cl
  800854:	8b 55 0c             	mov    0xc(%ebp),%edx
  800857:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80085b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085e:	8b 00                	mov    (%eax),%eax
  800860:	3d ff 00 00 00       	cmp    $0xff,%eax
  800865:	75 2c                	jne    800893 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800867:	a0 24 30 80 00       	mov    0x803024,%al
  80086c:	0f b6 c0             	movzbl %al,%eax
  80086f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800872:	8b 12                	mov    (%edx),%edx
  800874:	89 d1                	mov    %edx,%ecx
  800876:	8b 55 0c             	mov    0xc(%ebp),%edx
  800879:	83 c2 08             	add    $0x8,%edx
  80087c:	83 ec 04             	sub    $0x4,%esp
  80087f:	50                   	push   %eax
  800880:	51                   	push   %ecx
  800881:	52                   	push   %edx
  800882:	e8 ce 10 00 00       	call   801955 <sys_cputs>
  800887:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80088a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800893:	8b 45 0c             	mov    0xc(%ebp),%eax
  800896:	8b 40 04             	mov    0x4(%eax),%eax
  800899:	8d 50 01             	lea    0x1(%eax),%edx
  80089c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089f:	89 50 04             	mov    %edx,0x4(%eax)
}
  8008a2:	90                   	nop
  8008a3:	c9                   	leave  
  8008a4:	c3                   	ret    

008008a5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8008a5:	55                   	push   %ebp
  8008a6:	89 e5                	mov    %esp,%ebp
  8008a8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8008ae:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8008b5:	00 00 00 
	b.cnt = 0;
  8008b8:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8008bf:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8008c2:	ff 75 0c             	pushl  0xc(%ebp)
  8008c5:	ff 75 08             	pushl  0x8(%ebp)
  8008c8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8008ce:	50                   	push   %eax
  8008cf:	68 3c 08 80 00       	push   $0x80083c
  8008d4:	e8 11 02 00 00       	call   800aea <vprintfmt>
  8008d9:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8008dc:	a0 24 30 80 00       	mov    0x803024,%al
  8008e1:	0f b6 c0             	movzbl %al,%eax
  8008e4:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8008ea:	83 ec 04             	sub    $0x4,%esp
  8008ed:	50                   	push   %eax
  8008ee:	52                   	push   %edx
  8008ef:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8008f5:	83 c0 08             	add    $0x8,%eax
  8008f8:	50                   	push   %eax
  8008f9:	e8 57 10 00 00       	call   801955 <sys_cputs>
  8008fe:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800901:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800908:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80090e:	c9                   	leave  
  80090f:	c3                   	ret    

00800910 <cprintf>:

int cprintf(const char *fmt, ...) {
  800910:	55                   	push   %ebp
  800911:	89 e5                	mov    %esp,%ebp
  800913:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800916:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80091d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800920:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800923:	8b 45 08             	mov    0x8(%ebp),%eax
  800926:	83 ec 08             	sub    $0x8,%esp
  800929:	ff 75 f4             	pushl  -0xc(%ebp)
  80092c:	50                   	push   %eax
  80092d:	e8 73 ff ff ff       	call   8008a5 <vcprintf>
  800932:	83 c4 10             	add    $0x10,%esp
  800935:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800938:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80093b:	c9                   	leave  
  80093c:	c3                   	ret    

0080093d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80093d:	55                   	push   %ebp
  80093e:	89 e5                	mov    %esp,%ebp
  800940:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800943:	e8 1e 12 00 00       	call   801b66 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800948:	8d 45 0c             	lea    0xc(%ebp),%eax
  80094b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80094e:	8b 45 08             	mov    0x8(%ebp),%eax
  800951:	83 ec 08             	sub    $0x8,%esp
  800954:	ff 75 f4             	pushl  -0xc(%ebp)
  800957:	50                   	push   %eax
  800958:	e8 48 ff ff ff       	call   8008a5 <vcprintf>
  80095d:	83 c4 10             	add    $0x10,%esp
  800960:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800963:	e8 18 12 00 00       	call   801b80 <sys_enable_interrupt>
	return cnt;
  800968:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80096b:	c9                   	leave  
  80096c:	c3                   	ret    

0080096d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80096d:	55                   	push   %ebp
  80096e:	89 e5                	mov    %esp,%ebp
  800970:	53                   	push   %ebx
  800971:	83 ec 14             	sub    $0x14,%esp
  800974:	8b 45 10             	mov    0x10(%ebp),%eax
  800977:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80097a:	8b 45 14             	mov    0x14(%ebp),%eax
  80097d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800980:	8b 45 18             	mov    0x18(%ebp),%eax
  800983:	ba 00 00 00 00       	mov    $0x0,%edx
  800988:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80098b:	77 55                	ja     8009e2 <printnum+0x75>
  80098d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800990:	72 05                	jb     800997 <printnum+0x2a>
  800992:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800995:	77 4b                	ja     8009e2 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800997:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80099a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80099d:	8b 45 18             	mov    0x18(%ebp),%eax
  8009a0:	ba 00 00 00 00       	mov    $0x0,%edx
  8009a5:	52                   	push   %edx
  8009a6:	50                   	push   %eax
  8009a7:	ff 75 f4             	pushl  -0xc(%ebp)
  8009aa:	ff 75 f0             	pushl  -0x10(%ebp)
  8009ad:	e8 92 15 00 00       	call   801f44 <__udivdi3>
  8009b2:	83 c4 10             	add    $0x10,%esp
  8009b5:	83 ec 04             	sub    $0x4,%esp
  8009b8:	ff 75 20             	pushl  0x20(%ebp)
  8009bb:	53                   	push   %ebx
  8009bc:	ff 75 18             	pushl  0x18(%ebp)
  8009bf:	52                   	push   %edx
  8009c0:	50                   	push   %eax
  8009c1:	ff 75 0c             	pushl  0xc(%ebp)
  8009c4:	ff 75 08             	pushl  0x8(%ebp)
  8009c7:	e8 a1 ff ff ff       	call   80096d <printnum>
  8009cc:	83 c4 20             	add    $0x20,%esp
  8009cf:	eb 1a                	jmp    8009eb <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8009d1:	83 ec 08             	sub    $0x8,%esp
  8009d4:	ff 75 0c             	pushl  0xc(%ebp)
  8009d7:	ff 75 20             	pushl  0x20(%ebp)
  8009da:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dd:	ff d0                	call   *%eax
  8009df:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8009e2:	ff 4d 1c             	decl   0x1c(%ebp)
  8009e5:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8009e9:	7f e6                	jg     8009d1 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8009eb:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8009ee:	bb 00 00 00 00       	mov    $0x0,%ebx
  8009f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009f9:	53                   	push   %ebx
  8009fa:	51                   	push   %ecx
  8009fb:	52                   	push   %edx
  8009fc:	50                   	push   %eax
  8009fd:	e8 52 16 00 00       	call   802054 <__umoddi3>
  800a02:	83 c4 10             	add    $0x10,%esp
  800a05:	05 b4 29 80 00       	add    $0x8029b4,%eax
  800a0a:	8a 00                	mov    (%eax),%al
  800a0c:	0f be c0             	movsbl %al,%eax
  800a0f:	83 ec 08             	sub    $0x8,%esp
  800a12:	ff 75 0c             	pushl  0xc(%ebp)
  800a15:	50                   	push   %eax
  800a16:	8b 45 08             	mov    0x8(%ebp),%eax
  800a19:	ff d0                	call   *%eax
  800a1b:	83 c4 10             	add    $0x10,%esp
}
  800a1e:	90                   	nop
  800a1f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a22:	c9                   	leave  
  800a23:	c3                   	ret    

00800a24 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a24:	55                   	push   %ebp
  800a25:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a27:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a2b:	7e 1c                	jle    800a49 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a30:	8b 00                	mov    (%eax),%eax
  800a32:	8d 50 08             	lea    0x8(%eax),%edx
  800a35:	8b 45 08             	mov    0x8(%ebp),%eax
  800a38:	89 10                	mov    %edx,(%eax)
  800a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3d:	8b 00                	mov    (%eax),%eax
  800a3f:	83 e8 08             	sub    $0x8,%eax
  800a42:	8b 50 04             	mov    0x4(%eax),%edx
  800a45:	8b 00                	mov    (%eax),%eax
  800a47:	eb 40                	jmp    800a89 <getuint+0x65>
	else if (lflag)
  800a49:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a4d:	74 1e                	je     800a6d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800a4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a52:	8b 00                	mov    (%eax),%eax
  800a54:	8d 50 04             	lea    0x4(%eax),%edx
  800a57:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5a:	89 10                	mov    %edx,(%eax)
  800a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5f:	8b 00                	mov    (%eax),%eax
  800a61:	83 e8 04             	sub    $0x4,%eax
  800a64:	8b 00                	mov    (%eax),%eax
  800a66:	ba 00 00 00 00       	mov    $0x0,%edx
  800a6b:	eb 1c                	jmp    800a89 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a70:	8b 00                	mov    (%eax),%eax
  800a72:	8d 50 04             	lea    0x4(%eax),%edx
  800a75:	8b 45 08             	mov    0x8(%ebp),%eax
  800a78:	89 10                	mov    %edx,(%eax)
  800a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7d:	8b 00                	mov    (%eax),%eax
  800a7f:	83 e8 04             	sub    $0x4,%eax
  800a82:	8b 00                	mov    (%eax),%eax
  800a84:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800a89:	5d                   	pop    %ebp
  800a8a:	c3                   	ret    

00800a8b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800a8b:	55                   	push   %ebp
  800a8c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a8e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a92:	7e 1c                	jle    800ab0 <getint+0x25>
		return va_arg(*ap, long long);
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
  800aae:	eb 38                	jmp    800ae8 <getint+0x5d>
	else if (lflag)
  800ab0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ab4:	74 1a                	je     800ad0 <getint+0x45>
		return va_arg(*ap, long);
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	8b 00                	mov    (%eax),%eax
  800abb:	8d 50 04             	lea    0x4(%eax),%edx
  800abe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac1:	89 10                	mov    %edx,(%eax)
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	8b 00                	mov    (%eax),%eax
  800ac8:	83 e8 04             	sub    $0x4,%eax
  800acb:	8b 00                	mov    (%eax),%eax
  800acd:	99                   	cltd   
  800ace:	eb 18                	jmp    800ae8 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad3:	8b 00                	mov    (%eax),%eax
  800ad5:	8d 50 04             	lea    0x4(%eax),%edx
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	89 10                	mov    %edx,(%eax)
  800add:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae0:	8b 00                	mov    (%eax),%eax
  800ae2:	83 e8 04             	sub    $0x4,%eax
  800ae5:	8b 00                	mov    (%eax),%eax
  800ae7:	99                   	cltd   
}
  800ae8:	5d                   	pop    %ebp
  800ae9:	c3                   	ret    

00800aea <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800aea:	55                   	push   %ebp
  800aeb:	89 e5                	mov    %esp,%ebp
  800aed:	56                   	push   %esi
  800aee:	53                   	push   %ebx
  800aef:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800af2:	eb 17                	jmp    800b0b <vprintfmt+0x21>
			if (ch == '\0')
  800af4:	85 db                	test   %ebx,%ebx
  800af6:	0f 84 af 03 00 00    	je     800eab <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800afc:	83 ec 08             	sub    $0x8,%esp
  800aff:	ff 75 0c             	pushl  0xc(%ebp)
  800b02:	53                   	push   %ebx
  800b03:	8b 45 08             	mov    0x8(%ebp),%eax
  800b06:	ff d0                	call   *%eax
  800b08:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b0e:	8d 50 01             	lea    0x1(%eax),%edx
  800b11:	89 55 10             	mov    %edx,0x10(%ebp)
  800b14:	8a 00                	mov    (%eax),%al
  800b16:	0f b6 d8             	movzbl %al,%ebx
  800b19:	83 fb 25             	cmp    $0x25,%ebx
  800b1c:	75 d6                	jne    800af4 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b1e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b22:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b29:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b30:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b37:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800b3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b41:	8d 50 01             	lea    0x1(%eax),%edx
  800b44:	89 55 10             	mov    %edx,0x10(%ebp)
  800b47:	8a 00                	mov    (%eax),%al
  800b49:	0f b6 d8             	movzbl %al,%ebx
  800b4c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800b4f:	83 f8 55             	cmp    $0x55,%eax
  800b52:	0f 87 2b 03 00 00    	ja     800e83 <vprintfmt+0x399>
  800b58:	8b 04 85 d8 29 80 00 	mov    0x8029d8(,%eax,4),%eax
  800b5f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800b61:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800b65:	eb d7                	jmp    800b3e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800b67:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800b6b:	eb d1                	jmp    800b3e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800b6d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800b74:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b77:	89 d0                	mov    %edx,%eax
  800b79:	c1 e0 02             	shl    $0x2,%eax
  800b7c:	01 d0                	add    %edx,%eax
  800b7e:	01 c0                	add    %eax,%eax
  800b80:	01 d8                	add    %ebx,%eax
  800b82:	83 e8 30             	sub    $0x30,%eax
  800b85:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800b88:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8b:	8a 00                	mov    (%eax),%al
  800b8d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800b90:	83 fb 2f             	cmp    $0x2f,%ebx
  800b93:	7e 3e                	jle    800bd3 <vprintfmt+0xe9>
  800b95:	83 fb 39             	cmp    $0x39,%ebx
  800b98:	7f 39                	jg     800bd3 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800b9a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800b9d:	eb d5                	jmp    800b74 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800b9f:	8b 45 14             	mov    0x14(%ebp),%eax
  800ba2:	83 c0 04             	add    $0x4,%eax
  800ba5:	89 45 14             	mov    %eax,0x14(%ebp)
  800ba8:	8b 45 14             	mov    0x14(%ebp),%eax
  800bab:	83 e8 04             	sub    $0x4,%eax
  800bae:	8b 00                	mov    (%eax),%eax
  800bb0:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800bb3:	eb 1f                	jmp    800bd4 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800bb5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bb9:	79 83                	jns    800b3e <vprintfmt+0x54>
				width = 0;
  800bbb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800bc2:	e9 77 ff ff ff       	jmp    800b3e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800bc7:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800bce:	e9 6b ff ff ff       	jmp    800b3e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800bd3:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800bd4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bd8:	0f 89 60 ff ff ff    	jns    800b3e <vprintfmt+0x54>
				width = precision, precision = -1;
  800bde:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800be1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800be4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800beb:	e9 4e ff ff ff       	jmp    800b3e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800bf0:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800bf3:	e9 46 ff ff ff       	jmp    800b3e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800bf8:	8b 45 14             	mov    0x14(%ebp),%eax
  800bfb:	83 c0 04             	add    $0x4,%eax
  800bfe:	89 45 14             	mov    %eax,0x14(%ebp)
  800c01:	8b 45 14             	mov    0x14(%ebp),%eax
  800c04:	83 e8 04             	sub    $0x4,%eax
  800c07:	8b 00                	mov    (%eax),%eax
  800c09:	83 ec 08             	sub    $0x8,%esp
  800c0c:	ff 75 0c             	pushl  0xc(%ebp)
  800c0f:	50                   	push   %eax
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	ff d0                	call   *%eax
  800c15:	83 c4 10             	add    $0x10,%esp
			break;
  800c18:	e9 89 02 00 00       	jmp    800ea6 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c20:	83 c0 04             	add    $0x4,%eax
  800c23:	89 45 14             	mov    %eax,0x14(%ebp)
  800c26:	8b 45 14             	mov    0x14(%ebp),%eax
  800c29:	83 e8 04             	sub    $0x4,%eax
  800c2c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c2e:	85 db                	test   %ebx,%ebx
  800c30:	79 02                	jns    800c34 <vprintfmt+0x14a>
				err = -err;
  800c32:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c34:	83 fb 64             	cmp    $0x64,%ebx
  800c37:	7f 0b                	jg     800c44 <vprintfmt+0x15a>
  800c39:	8b 34 9d 20 28 80 00 	mov    0x802820(,%ebx,4),%esi
  800c40:	85 f6                	test   %esi,%esi
  800c42:	75 19                	jne    800c5d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800c44:	53                   	push   %ebx
  800c45:	68 c5 29 80 00       	push   $0x8029c5
  800c4a:	ff 75 0c             	pushl  0xc(%ebp)
  800c4d:	ff 75 08             	pushl  0x8(%ebp)
  800c50:	e8 5e 02 00 00       	call   800eb3 <printfmt>
  800c55:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800c58:	e9 49 02 00 00       	jmp    800ea6 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800c5d:	56                   	push   %esi
  800c5e:	68 ce 29 80 00       	push   $0x8029ce
  800c63:	ff 75 0c             	pushl  0xc(%ebp)
  800c66:	ff 75 08             	pushl  0x8(%ebp)
  800c69:	e8 45 02 00 00       	call   800eb3 <printfmt>
  800c6e:	83 c4 10             	add    $0x10,%esp
			break;
  800c71:	e9 30 02 00 00       	jmp    800ea6 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800c76:	8b 45 14             	mov    0x14(%ebp),%eax
  800c79:	83 c0 04             	add    $0x4,%eax
  800c7c:	89 45 14             	mov    %eax,0x14(%ebp)
  800c7f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c82:	83 e8 04             	sub    $0x4,%eax
  800c85:	8b 30                	mov    (%eax),%esi
  800c87:	85 f6                	test   %esi,%esi
  800c89:	75 05                	jne    800c90 <vprintfmt+0x1a6>
				p = "(null)";
  800c8b:	be d1 29 80 00       	mov    $0x8029d1,%esi
			if (width > 0 && padc != '-')
  800c90:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c94:	7e 6d                	jle    800d03 <vprintfmt+0x219>
  800c96:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800c9a:	74 67                	je     800d03 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800c9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c9f:	83 ec 08             	sub    $0x8,%esp
  800ca2:	50                   	push   %eax
  800ca3:	56                   	push   %esi
  800ca4:	e8 0c 03 00 00       	call   800fb5 <strnlen>
  800ca9:	83 c4 10             	add    $0x10,%esp
  800cac:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800caf:	eb 16                	jmp    800cc7 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800cb1:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800cb5:	83 ec 08             	sub    $0x8,%esp
  800cb8:	ff 75 0c             	pushl  0xc(%ebp)
  800cbb:	50                   	push   %eax
  800cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbf:	ff d0                	call   *%eax
  800cc1:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800cc4:	ff 4d e4             	decl   -0x1c(%ebp)
  800cc7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ccb:	7f e4                	jg     800cb1 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ccd:	eb 34                	jmp    800d03 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ccf:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800cd3:	74 1c                	je     800cf1 <vprintfmt+0x207>
  800cd5:	83 fb 1f             	cmp    $0x1f,%ebx
  800cd8:	7e 05                	jle    800cdf <vprintfmt+0x1f5>
  800cda:	83 fb 7e             	cmp    $0x7e,%ebx
  800cdd:	7e 12                	jle    800cf1 <vprintfmt+0x207>
					putch('?', putdat);
  800cdf:	83 ec 08             	sub    $0x8,%esp
  800ce2:	ff 75 0c             	pushl  0xc(%ebp)
  800ce5:	6a 3f                	push   $0x3f
  800ce7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cea:	ff d0                	call   *%eax
  800cec:	83 c4 10             	add    $0x10,%esp
  800cef:	eb 0f                	jmp    800d00 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800cf1:	83 ec 08             	sub    $0x8,%esp
  800cf4:	ff 75 0c             	pushl  0xc(%ebp)
  800cf7:	53                   	push   %ebx
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfb:	ff d0                	call   *%eax
  800cfd:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d00:	ff 4d e4             	decl   -0x1c(%ebp)
  800d03:	89 f0                	mov    %esi,%eax
  800d05:	8d 70 01             	lea    0x1(%eax),%esi
  800d08:	8a 00                	mov    (%eax),%al
  800d0a:	0f be d8             	movsbl %al,%ebx
  800d0d:	85 db                	test   %ebx,%ebx
  800d0f:	74 24                	je     800d35 <vprintfmt+0x24b>
  800d11:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d15:	78 b8                	js     800ccf <vprintfmt+0x1e5>
  800d17:	ff 4d e0             	decl   -0x20(%ebp)
  800d1a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d1e:	79 af                	jns    800ccf <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d20:	eb 13                	jmp    800d35 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d22:	83 ec 08             	sub    $0x8,%esp
  800d25:	ff 75 0c             	pushl  0xc(%ebp)
  800d28:	6a 20                	push   $0x20
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	ff d0                	call   *%eax
  800d2f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d32:	ff 4d e4             	decl   -0x1c(%ebp)
  800d35:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d39:	7f e7                	jg     800d22 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d3b:	e9 66 01 00 00       	jmp    800ea6 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800d40:	83 ec 08             	sub    $0x8,%esp
  800d43:	ff 75 e8             	pushl  -0x18(%ebp)
  800d46:	8d 45 14             	lea    0x14(%ebp),%eax
  800d49:	50                   	push   %eax
  800d4a:	e8 3c fd ff ff       	call   800a8b <getint>
  800d4f:	83 c4 10             	add    $0x10,%esp
  800d52:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d55:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800d58:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d5b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d5e:	85 d2                	test   %edx,%edx
  800d60:	79 23                	jns    800d85 <vprintfmt+0x29b>
				putch('-', putdat);
  800d62:	83 ec 08             	sub    $0x8,%esp
  800d65:	ff 75 0c             	pushl  0xc(%ebp)
  800d68:	6a 2d                	push   $0x2d
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	ff d0                	call   *%eax
  800d6f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800d72:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d75:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d78:	f7 d8                	neg    %eax
  800d7a:	83 d2 00             	adc    $0x0,%edx
  800d7d:	f7 da                	neg    %edx
  800d7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d82:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800d85:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800d8c:	e9 bc 00 00 00       	jmp    800e4d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800d91:	83 ec 08             	sub    $0x8,%esp
  800d94:	ff 75 e8             	pushl  -0x18(%ebp)
  800d97:	8d 45 14             	lea    0x14(%ebp),%eax
  800d9a:	50                   	push   %eax
  800d9b:	e8 84 fc ff ff       	call   800a24 <getuint>
  800da0:	83 c4 10             	add    $0x10,%esp
  800da3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800da6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800da9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800db0:	e9 98 00 00 00       	jmp    800e4d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800db5:	83 ec 08             	sub    $0x8,%esp
  800db8:	ff 75 0c             	pushl  0xc(%ebp)
  800dbb:	6a 58                	push   $0x58
  800dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc0:	ff d0                	call   *%eax
  800dc2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800dc5:	83 ec 08             	sub    $0x8,%esp
  800dc8:	ff 75 0c             	pushl  0xc(%ebp)
  800dcb:	6a 58                	push   $0x58
  800dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd0:	ff d0                	call   *%eax
  800dd2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800dd5:	83 ec 08             	sub    $0x8,%esp
  800dd8:	ff 75 0c             	pushl  0xc(%ebp)
  800ddb:	6a 58                	push   $0x58
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  800de0:	ff d0                	call   *%eax
  800de2:	83 c4 10             	add    $0x10,%esp
			break;
  800de5:	e9 bc 00 00 00       	jmp    800ea6 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800dea:	83 ec 08             	sub    $0x8,%esp
  800ded:	ff 75 0c             	pushl  0xc(%ebp)
  800df0:	6a 30                	push   $0x30
  800df2:	8b 45 08             	mov    0x8(%ebp),%eax
  800df5:	ff d0                	call   *%eax
  800df7:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800dfa:	83 ec 08             	sub    $0x8,%esp
  800dfd:	ff 75 0c             	pushl  0xc(%ebp)
  800e00:	6a 78                	push   $0x78
  800e02:	8b 45 08             	mov    0x8(%ebp),%eax
  800e05:	ff d0                	call   *%eax
  800e07:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e0a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e0d:	83 c0 04             	add    $0x4,%eax
  800e10:	89 45 14             	mov    %eax,0x14(%ebp)
  800e13:	8b 45 14             	mov    0x14(%ebp),%eax
  800e16:	83 e8 04             	sub    $0x4,%eax
  800e19:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e1e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e25:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e2c:	eb 1f                	jmp    800e4d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e2e:	83 ec 08             	sub    $0x8,%esp
  800e31:	ff 75 e8             	pushl  -0x18(%ebp)
  800e34:	8d 45 14             	lea    0x14(%ebp),%eax
  800e37:	50                   	push   %eax
  800e38:	e8 e7 fb ff ff       	call   800a24 <getuint>
  800e3d:	83 c4 10             	add    $0x10,%esp
  800e40:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e43:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800e46:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800e4d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800e51:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e54:	83 ec 04             	sub    $0x4,%esp
  800e57:	52                   	push   %edx
  800e58:	ff 75 e4             	pushl  -0x1c(%ebp)
  800e5b:	50                   	push   %eax
  800e5c:	ff 75 f4             	pushl  -0xc(%ebp)
  800e5f:	ff 75 f0             	pushl  -0x10(%ebp)
  800e62:	ff 75 0c             	pushl  0xc(%ebp)
  800e65:	ff 75 08             	pushl  0x8(%ebp)
  800e68:	e8 00 fb ff ff       	call   80096d <printnum>
  800e6d:	83 c4 20             	add    $0x20,%esp
			break;
  800e70:	eb 34                	jmp    800ea6 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800e72:	83 ec 08             	sub    $0x8,%esp
  800e75:	ff 75 0c             	pushl  0xc(%ebp)
  800e78:	53                   	push   %ebx
  800e79:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7c:	ff d0                	call   *%eax
  800e7e:	83 c4 10             	add    $0x10,%esp
			break;
  800e81:	eb 23                	jmp    800ea6 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800e83:	83 ec 08             	sub    $0x8,%esp
  800e86:	ff 75 0c             	pushl  0xc(%ebp)
  800e89:	6a 25                	push   $0x25
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	ff d0                	call   *%eax
  800e90:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800e93:	ff 4d 10             	decl   0x10(%ebp)
  800e96:	eb 03                	jmp    800e9b <vprintfmt+0x3b1>
  800e98:	ff 4d 10             	decl   0x10(%ebp)
  800e9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9e:	48                   	dec    %eax
  800e9f:	8a 00                	mov    (%eax),%al
  800ea1:	3c 25                	cmp    $0x25,%al
  800ea3:	75 f3                	jne    800e98 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ea5:	90                   	nop
		}
	}
  800ea6:	e9 47 fc ff ff       	jmp    800af2 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800eab:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800eac:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800eaf:	5b                   	pop    %ebx
  800eb0:	5e                   	pop    %esi
  800eb1:	5d                   	pop    %ebp
  800eb2:	c3                   	ret    

00800eb3 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800eb3:	55                   	push   %ebp
  800eb4:	89 e5                	mov    %esp,%ebp
  800eb6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800eb9:	8d 45 10             	lea    0x10(%ebp),%eax
  800ebc:	83 c0 04             	add    $0x4,%eax
  800ebf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ec2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec5:	ff 75 f4             	pushl  -0xc(%ebp)
  800ec8:	50                   	push   %eax
  800ec9:	ff 75 0c             	pushl  0xc(%ebp)
  800ecc:	ff 75 08             	pushl  0x8(%ebp)
  800ecf:	e8 16 fc ff ff       	call   800aea <vprintfmt>
  800ed4:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ed7:	90                   	nop
  800ed8:	c9                   	leave  
  800ed9:	c3                   	ret    

00800eda <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800eda:	55                   	push   %ebp
  800edb:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800edd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee0:	8b 40 08             	mov    0x8(%eax),%eax
  800ee3:	8d 50 01             	lea    0x1(%eax),%edx
  800ee6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee9:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800eec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eef:	8b 10                	mov    (%eax),%edx
  800ef1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef4:	8b 40 04             	mov    0x4(%eax),%eax
  800ef7:	39 c2                	cmp    %eax,%edx
  800ef9:	73 12                	jae    800f0d <sprintputch+0x33>
		*b->buf++ = ch;
  800efb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efe:	8b 00                	mov    (%eax),%eax
  800f00:	8d 48 01             	lea    0x1(%eax),%ecx
  800f03:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f06:	89 0a                	mov    %ecx,(%edx)
  800f08:	8b 55 08             	mov    0x8(%ebp),%edx
  800f0b:	88 10                	mov    %dl,(%eax)
}
  800f0d:	90                   	nop
  800f0e:	5d                   	pop    %ebp
  800f0f:	c3                   	ret    

00800f10 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f10:	55                   	push   %ebp
  800f11:	89 e5                	mov    %esp,%ebp
  800f13:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
  800f19:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f22:	8b 45 08             	mov    0x8(%ebp),%eax
  800f25:	01 d0                	add    %edx,%eax
  800f27:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f2a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f31:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f35:	74 06                	je     800f3d <vsnprintf+0x2d>
  800f37:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f3b:	7f 07                	jg     800f44 <vsnprintf+0x34>
		return -E_INVAL;
  800f3d:	b8 03 00 00 00       	mov    $0x3,%eax
  800f42:	eb 20                	jmp    800f64 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800f44:	ff 75 14             	pushl  0x14(%ebp)
  800f47:	ff 75 10             	pushl  0x10(%ebp)
  800f4a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800f4d:	50                   	push   %eax
  800f4e:	68 da 0e 80 00       	push   $0x800eda
  800f53:	e8 92 fb ff ff       	call   800aea <vprintfmt>
  800f58:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800f5b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f5e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800f61:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800f64:	c9                   	leave  
  800f65:	c3                   	ret    

00800f66 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800f66:	55                   	push   %ebp
  800f67:	89 e5                	mov    %esp,%ebp
  800f69:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800f6c:	8d 45 10             	lea    0x10(%ebp),%eax
  800f6f:	83 c0 04             	add    $0x4,%eax
  800f72:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800f75:	8b 45 10             	mov    0x10(%ebp),%eax
  800f78:	ff 75 f4             	pushl  -0xc(%ebp)
  800f7b:	50                   	push   %eax
  800f7c:	ff 75 0c             	pushl  0xc(%ebp)
  800f7f:	ff 75 08             	pushl  0x8(%ebp)
  800f82:	e8 89 ff ff ff       	call   800f10 <vsnprintf>
  800f87:	83 c4 10             	add    $0x10,%esp
  800f8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800f8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f90:	c9                   	leave  
  800f91:	c3                   	ret    

00800f92 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800f92:	55                   	push   %ebp
  800f93:	89 e5                	mov    %esp,%ebp
  800f95:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800f98:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f9f:	eb 06                	jmp    800fa7 <strlen+0x15>
		n++;
  800fa1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800fa4:	ff 45 08             	incl   0x8(%ebp)
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	8a 00                	mov    (%eax),%al
  800fac:	84 c0                	test   %al,%al
  800fae:	75 f1                	jne    800fa1 <strlen+0xf>
		n++;
	return n;
  800fb0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800fb3:	c9                   	leave  
  800fb4:	c3                   	ret    

00800fb5 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800fb5:	55                   	push   %ebp
  800fb6:	89 e5                	mov    %esp,%ebp
  800fb8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800fbb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fc2:	eb 09                	jmp    800fcd <strnlen+0x18>
		n++;
  800fc4:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800fc7:	ff 45 08             	incl   0x8(%ebp)
  800fca:	ff 4d 0c             	decl   0xc(%ebp)
  800fcd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fd1:	74 09                	je     800fdc <strnlen+0x27>
  800fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd6:	8a 00                	mov    (%eax),%al
  800fd8:	84 c0                	test   %al,%al
  800fda:	75 e8                	jne    800fc4 <strnlen+0xf>
		n++;
	return n;
  800fdc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800fdf:	c9                   	leave  
  800fe0:	c3                   	ret    

00800fe1 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800fe1:	55                   	push   %ebp
  800fe2:	89 e5                	mov    %esp,%ebp
  800fe4:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800fe7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800fed:	90                   	nop
  800fee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff1:	8d 50 01             	lea    0x1(%eax),%edx
  800ff4:	89 55 08             	mov    %edx,0x8(%ebp)
  800ff7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ffa:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ffd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801000:	8a 12                	mov    (%edx),%dl
  801002:	88 10                	mov    %dl,(%eax)
  801004:	8a 00                	mov    (%eax),%al
  801006:	84 c0                	test   %al,%al
  801008:	75 e4                	jne    800fee <strcpy+0xd>
		/* do nothing */;
	return ret;
  80100a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80100d:	c9                   	leave  
  80100e:	c3                   	ret    

0080100f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80100f:	55                   	push   %ebp
  801010:	89 e5                	mov    %esp,%ebp
  801012:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
  801018:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80101b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801022:	eb 1f                	jmp    801043 <strncpy+0x34>
		*dst++ = *src;
  801024:	8b 45 08             	mov    0x8(%ebp),%eax
  801027:	8d 50 01             	lea    0x1(%eax),%edx
  80102a:	89 55 08             	mov    %edx,0x8(%ebp)
  80102d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801030:	8a 12                	mov    (%edx),%dl
  801032:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801034:	8b 45 0c             	mov    0xc(%ebp),%eax
  801037:	8a 00                	mov    (%eax),%al
  801039:	84 c0                	test   %al,%al
  80103b:	74 03                	je     801040 <strncpy+0x31>
			src++;
  80103d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801040:	ff 45 fc             	incl   -0x4(%ebp)
  801043:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801046:	3b 45 10             	cmp    0x10(%ebp),%eax
  801049:	72 d9                	jb     801024 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80104b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80104e:	c9                   	leave  
  80104f:	c3                   	ret    

00801050 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801050:	55                   	push   %ebp
  801051:	89 e5                	mov    %esp,%ebp
  801053:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801056:	8b 45 08             	mov    0x8(%ebp),%eax
  801059:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80105c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801060:	74 30                	je     801092 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801062:	eb 16                	jmp    80107a <strlcpy+0x2a>
			*dst++ = *src++;
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	8d 50 01             	lea    0x1(%eax),%edx
  80106a:	89 55 08             	mov    %edx,0x8(%ebp)
  80106d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801070:	8d 4a 01             	lea    0x1(%edx),%ecx
  801073:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801076:	8a 12                	mov    (%edx),%dl
  801078:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80107a:	ff 4d 10             	decl   0x10(%ebp)
  80107d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801081:	74 09                	je     80108c <strlcpy+0x3c>
  801083:	8b 45 0c             	mov    0xc(%ebp),%eax
  801086:	8a 00                	mov    (%eax),%al
  801088:	84 c0                	test   %al,%al
  80108a:	75 d8                	jne    801064 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801092:	8b 55 08             	mov    0x8(%ebp),%edx
  801095:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801098:	29 c2                	sub    %eax,%edx
  80109a:	89 d0                	mov    %edx,%eax
}
  80109c:	c9                   	leave  
  80109d:	c3                   	ret    

0080109e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80109e:	55                   	push   %ebp
  80109f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8010a1:	eb 06                	jmp    8010a9 <strcmp+0xb>
		p++, q++;
  8010a3:	ff 45 08             	incl   0x8(%ebp)
  8010a6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8010a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ac:	8a 00                	mov    (%eax),%al
  8010ae:	84 c0                	test   %al,%al
  8010b0:	74 0e                	je     8010c0 <strcmp+0x22>
  8010b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b5:	8a 10                	mov    (%eax),%dl
  8010b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ba:	8a 00                	mov    (%eax),%al
  8010bc:	38 c2                	cmp    %al,%dl
  8010be:	74 e3                	je     8010a3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8010c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c3:	8a 00                	mov    (%eax),%al
  8010c5:	0f b6 d0             	movzbl %al,%edx
  8010c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cb:	8a 00                	mov    (%eax),%al
  8010cd:	0f b6 c0             	movzbl %al,%eax
  8010d0:	29 c2                	sub    %eax,%edx
  8010d2:	89 d0                	mov    %edx,%eax
}
  8010d4:	5d                   	pop    %ebp
  8010d5:	c3                   	ret    

008010d6 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8010d6:	55                   	push   %ebp
  8010d7:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8010d9:	eb 09                	jmp    8010e4 <strncmp+0xe>
		n--, p++, q++;
  8010db:	ff 4d 10             	decl   0x10(%ebp)
  8010de:	ff 45 08             	incl   0x8(%ebp)
  8010e1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8010e4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e8:	74 17                	je     801101 <strncmp+0x2b>
  8010ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ed:	8a 00                	mov    (%eax),%al
  8010ef:	84 c0                	test   %al,%al
  8010f1:	74 0e                	je     801101 <strncmp+0x2b>
  8010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f6:	8a 10                	mov    (%eax),%dl
  8010f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fb:	8a 00                	mov    (%eax),%al
  8010fd:	38 c2                	cmp    %al,%dl
  8010ff:	74 da                	je     8010db <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801101:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801105:	75 07                	jne    80110e <strncmp+0x38>
		return 0;
  801107:	b8 00 00 00 00       	mov    $0x0,%eax
  80110c:	eb 14                	jmp    801122 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80110e:	8b 45 08             	mov    0x8(%ebp),%eax
  801111:	8a 00                	mov    (%eax),%al
  801113:	0f b6 d0             	movzbl %al,%edx
  801116:	8b 45 0c             	mov    0xc(%ebp),%eax
  801119:	8a 00                	mov    (%eax),%al
  80111b:	0f b6 c0             	movzbl %al,%eax
  80111e:	29 c2                	sub    %eax,%edx
  801120:	89 d0                	mov    %edx,%eax
}
  801122:	5d                   	pop    %ebp
  801123:	c3                   	ret    

00801124 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801124:	55                   	push   %ebp
  801125:	89 e5                	mov    %esp,%ebp
  801127:	83 ec 04             	sub    $0x4,%esp
  80112a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801130:	eb 12                	jmp    801144 <strchr+0x20>
		if (*s == c)
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	8a 00                	mov    (%eax),%al
  801137:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80113a:	75 05                	jne    801141 <strchr+0x1d>
			return (char *) s;
  80113c:	8b 45 08             	mov    0x8(%ebp),%eax
  80113f:	eb 11                	jmp    801152 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801141:	ff 45 08             	incl   0x8(%ebp)
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	8a 00                	mov    (%eax),%al
  801149:	84 c0                	test   %al,%al
  80114b:	75 e5                	jne    801132 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80114d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801152:	c9                   	leave  
  801153:	c3                   	ret    

00801154 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801154:	55                   	push   %ebp
  801155:	89 e5                	mov    %esp,%ebp
  801157:	83 ec 04             	sub    $0x4,%esp
  80115a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801160:	eb 0d                	jmp    80116f <strfind+0x1b>
		if (*s == c)
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
  801165:	8a 00                	mov    (%eax),%al
  801167:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80116a:	74 0e                	je     80117a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80116c:	ff 45 08             	incl   0x8(%ebp)
  80116f:	8b 45 08             	mov    0x8(%ebp),%eax
  801172:	8a 00                	mov    (%eax),%al
  801174:	84 c0                	test   %al,%al
  801176:	75 ea                	jne    801162 <strfind+0xe>
  801178:	eb 01                	jmp    80117b <strfind+0x27>
		if (*s == c)
			break;
  80117a:	90                   	nop
	return (char *) s;
  80117b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80117e:	c9                   	leave  
  80117f:	c3                   	ret    

00801180 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801180:	55                   	push   %ebp
  801181:	89 e5                	mov    %esp,%ebp
  801183:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801186:	8b 45 08             	mov    0x8(%ebp),%eax
  801189:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80118c:	8b 45 10             	mov    0x10(%ebp),%eax
  80118f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801192:	eb 0e                	jmp    8011a2 <memset+0x22>
		*p++ = c;
  801194:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801197:	8d 50 01             	lea    0x1(%eax),%edx
  80119a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80119d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011a0:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8011a2:	ff 4d f8             	decl   -0x8(%ebp)
  8011a5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8011a9:	79 e9                	jns    801194 <memset+0x14>
		*p++ = c;

	return v;
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011ae:	c9                   	leave  
  8011af:	c3                   	ret    

008011b0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8011b0:	55                   	push   %ebp
  8011b1:	89 e5                	mov    %esp,%ebp
  8011b3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8011c2:	eb 16                	jmp    8011da <memcpy+0x2a>
		*d++ = *s++;
  8011c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011c7:	8d 50 01             	lea    0x1(%eax),%edx
  8011ca:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011d0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011d3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8011d6:	8a 12                	mov    (%edx),%dl
  8011d8:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8011da:	8b 45 10             	mov    0x10(%ebp),%eax
  8011dd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011e0:	89 55 10             	mov    %edx,0x10(%ebp)
  8011e3:	85 c0                	test   %eax,%eax
  8011e5:	75 dd                	jne    8011c4 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8011e7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011ea:	c9                   	leave  
  8011eb:	c3                   	ret    

008011ec <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8011ec:	55                   	push   %ebp
  8011ed:	89 e5                	mov    %esp,%ebp
  8011ef:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8011f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8011fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801201:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801204:	73 50                	jae    801256 <memmove+0x6a>
  801206:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801209:	8b 45 10             	mov    0x10(%ebp),%eax
  80120c:	01 d0                	add    %edx,%eax
  80120e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801211:	76 43                	jbe    801256 <memmove+0x6a>
		s += n;
  801213:	8b 45 10             	mov    0x10(%ebp),%eax
  801216:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801219:	8b 45 10             	mov    0x10(%ebp),%eax
  80121c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80121f:	eb 10                	jmp    801231 <memmove+0x45>
			*--d = *--s;
  801221:	ff 4d f8             	decl   -0x8(%ebp)
  801224:	ff 4d fc             	decl   -0x4(%ebp)
  801227:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80122a:	8a 10                	mov    (%eax),%dl
  80122c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80122f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801231:	8b 45 10             	mov    0x10(%ebp),%eax
  801234:	8d 50 ff             	lea    -0x1(%eax),%edx
  801237:	89 55 10             	mov    %edx,0x10(%ebp)
  80123a:	85 c0                	test   %eax,%eax
  80123c:	75 e3                	jne    801221 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80123e:	eb 23                	jmp    801263 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801240:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801243:	8d 50 01             	lea    0x1(%eax),%edx
  801246:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801249:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80124c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80124f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801252:	8a 12                	mov    (%edx),%dl
  801254:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801256:	8b 45 10             	mov    0x10(%ebp),%eax
  801259:	8d 50 ff             	lea    -0x1(%eax),%edx
  80125c:	89 55 10             	mov    %edx,0x10(%ebp)
  80125f:	85 c0                	test   %eax,%eax
  801261:	75 dd                	jne    801240 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801266:	c9                   	leave  
  801267:	c3                   	ret    

00801268 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801268:	55                   	push   %ebp
  801269:	89 e5                	mov    %esp,%ebp
  80126b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80126e:	8b 45 08             	mov    0x8(%ebp),%eax
  801271:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801274:	8b 45 0c             	mov    0xc(%ebp),%eax
  801277:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80127a:	eb 2a                	jmp    8012a6 <memcmp+0x3e>
		if (*s1 != *s2)
  80127c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80127f:	8a 10                	mov    (%eax),%dl
  801281:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801284:	8a 00                	mov    (%eax),%al
  801286:	38 c2                	cmp    %al,%dl
  801288:	74 16                	je     8012a0 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80128a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80128d:	8a 00                	mov    (%eax),%al
  80128f:	0f b6 d0             	movzbl %al,%edx
  801292:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801295:	8a 00                	mov    (%eax),%al
  801297:	0f b6 c0             	movzbl %al,%eax
  80129a:	29 c2                	sub    %eax,%edx
  80129c:	89 d0                	mov    %edx,%eax
  80129e:	eb 18                	jmp    8012b8 <memcmp+0x50>
		s1++, s2++;
  8012a0:	ff 45 fc             	incl   -0x4(%ebp)
  8012a3:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8012a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012ac:	89 55 10             	mov    %edx,0x10(%ebp)
  8012af:	85 c0                	test   %eax,%eax
  8012b1:	75 c9                	jne    80127c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8012b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012b8:	c9                   	leave  
  8012b9:	c3                   	ret    

008012ba <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
  8012bd:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8012c0:	8b 55 08             	mov    0x8(%ebp),%edx
  8012c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c6:	01 d0                	add    %edx,%eax
  8012c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8012cb:	eb 15                	jmp    8012e2 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	8a 00                	mov    (%eax),%al
  8012d2:	0f b6 d0             	movzbl %al,%edx
  8012d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d8:	0f b6 c0             	movzbl %al,%eax
  8012db:	39 c2                	cmp    %eax,%edx
  8012dd:	74 0d                	je     8012ec <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8012df:	ff 45 08             	incl   0x8(%ebp)
  8012e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012e8:	72 e3                	jb     8012cd <memfind+0x13>
  8012ea:	eb 01                	jmp    8012ed <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8012ec:	90                   	nop
	return (void *) s;
  8012ed:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012f0:	c9                   	leave  
  8012f1:	c3                   	ret    

008012f2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8012f2:	55                   	push   %ebp
  8012f3:	89 e5                	mov    %esp,%ebp
  8012f5:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8012f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8012ff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801306:	eb 03                	jmp    80130b <strtol+0x19>
		s++;
  801308:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	8a 00                	mov    (%eax),%al
  801310:	3c 20                	cmp    $0x20,%al
  801312:	74 f4                	je     801308 <strtol+0x16>
  801314:	8b 45 08             	mov    0x8(%ebp),%eax
  801317:	8a 00                	mov    (%eax),%al
  801319:	3c 09                	cmp    $0x9,%al
  80131b:	74 eb                	je     801308 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	8a 00                	mov    (%eax),%al
  801322:	3c 2b                	cmp    $0x2b,%al
  801324:	75 05                	jne    80132b <strtol+0x39>
		s++;
  801326:	ff 45 08             	incl   0x8(%ebp)
  801329:	eb 13                	jmp    80133e <strtol+0x4c>
	else if (*s == '-')
  80132b:	8b 45 08             	mov    0x8(%ebp),%eax
  80132e:	8a 00                	mov    (%eax),%al
  801330:	3c 2d                	cmp    $0x2d,%al
  801332:	75 0a                	jne    80133e <strtol+0x4c>
		s++, neg = 1;
  801334:	ff 45 08             	incl   0x8(%ebp)
  801337:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80133e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801342:	74 06                	je     80134a <strtol+0x58>
  801344:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801348:	75 20                	jne    80136a <strtol+0x78>
  80134a:	8b 45 08             	mov    0x8(%ebp),%eax
  80134d:	8a 00                	mov    (%eax),%al
  80134f:	3c 30                	cmp    $0x30,%al
  801351:	75 17                	jne    80136a <strtol+0x78>
  801353:	8b 45 08             	mov    0x8(%ebp),%eax
  801356:	40                   	inc    %eax
  801357:	8a 00                	mov    (%eax),%al
  801359:	3c 78                	cmp    $0x78,%al
  80135b:	75 0d                	jne    80136a <strtol+0x78>
		s += 2, base = 16;
  80135d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801361:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801368:	eb 28                	jmp    801392 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80136a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80136e:	75 15                	jne    801385 <strtol+0x93>
  801370:	8b 45 08             	mov    0x8(%ebp),%eax
  801373:	8a 00                	mov    (%eax),%al
  801375:	3c 30                	cmp    $0x30,%al
  801377:	75 0c                	jne    801385 <strtol+0x93>
		s++, base = 8;
  801379:	ff 45 08             	incl   0x8(%ebp)
  80137c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801383:	eb 0d                	jmp    801392 <strtol+0xa0>
	else if (base == 0)
  801385:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801389:	75 07                	jne    801392 <strtol+0xa0>
		base = 10;
  80138b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	8a 00                	mov    (%eax),%al
  801397:	3c 2f                	cmp    $0x2f,%al
  801399:	7e 19                	jle    8013b4 <strtol+0xc2>
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	8a 00                	mov    (%eax),%al
  8013a0:	3c 39                	cmp    $0x39,%al
  8013a2:	7f 10                	jg     8013b4 <strtol+0xc2>
			dig = *s - '0';
  8013a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a7:	8a 00                	mov    (%eax),%al
  8013a9:	0f be c0             	movsbl %al,%eax
  8013ac:	83 e8 30             	sub    $0x30,%eax
  8013af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013b2:	eb 42                	jmp    8013f6 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	8a 00                	mov    (%eax),%al
  8013b9:	3c 60                	cmp    $0x60,%al
  8013bb:	7e 19                	jle    8013d6 <strtol+0xe4>
  8013bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c0:	8a 00                	mov    (%eax),%al
  8013c2:	3c 7a                	cmp    $0x7a,%al
  8013c4:	7f 10                	jg     8013d6 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	8a 00                	mov    (%eax),%al
  8013cb:	0f be c0             	movsbl %al,%eax
  8013ce:	83 e8 57             	sub    $0x57,%eax
  8013d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013d4:	eb 20                	jmp    8013f6 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8013d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d9:	8a 00                	mov    (%eax),%al
  8013db:	3c 40                	cmp    $0x40,%al
  8013dd:	7e 39                	jle    801418 <strtol+0x126>
  8013df:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e2:	8a 00                	mov    (%eax),%al
  8013e4:	3c 5a                	cmp    $0x5a,%al
  8013e6:	7f 30                	jg     801418 <strtol+0x126>
			dig = *s - 'A' + 10;
  8013e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013eb:	8a 00                	mov    (%eax),%al
  8013ed:	0f be c0             	movsbl %al,%eax
  8013f0:	83 e8 37             	sub    $0x37,%eax
  8013f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8013f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013f9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013fc:	7d 19                	jge    801417 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8013fe:	ff 45 08             	incl   0x8(%ebp)
  801401:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801404:	0f af 45 10          	imul   0x10(%ebp),%eax
  801408:	89 c2                	mov    %eax,%edx
  80140a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80140d:	01 d0                	add    %edx,%eax
  80140f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801412:	e9 7b ff ff ff       	jmp    801392 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801417:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801418:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80141c:	74 08                	je     801426 <strtol+0x134>
		*endptr = (char *) s;
  80141e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801421:	8b 55 08             	mov    0x8(%ebp),%edx
  801424:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801426:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80142a:	74 07                	je     801433 <strtol+0x141>
  80142c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80142f:	f7 d8                	neg    %eax
  801431:	eb 03                	jmp    801436 <strtol+0x144>
  801433:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801436:	c9                   	leave  
  801437:	c3                   	ret    

00801438 <ltostr>:

void
ltostr(long value, char *str)
{
  801438:	55                   	push   %ebp
  801439:	89 e5                	mov    %esp,%ebp
  80143b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80143e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801445:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80144c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801450:	79 13                	jns    801465 <ltostr+0x2d>
	{
		neg = 1;
  801452:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801459:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80145f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801462:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801465:	8b 45 08             	mov    0x8(%ebp),%eax
  801468:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80146d:	99                   	cltd   
  80146e:	f7 f9                	idiv   %ecx
  801470:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801473:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801476:	8d 50 01             	lea    0x1(%eax),%edx
  801479:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80147c:	89 c2                	mov    %eax,%edx
  80147e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801481:	01 d0                	add    %edx,%eax
  801483:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801486:	83 c2 30             	add    $0x30,%edx
  801489:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80148b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80148e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801493:	f7 e9                	imul   %ecx
  801495:	c1 fa 02             	sar    $0x2,%edx
  801498:	89 c8                	mov    %ecx,%eax
  80149a:	c1 f8 1f             	sar    $0x1f,%eax
  80149d:	29 c2                	sub    %eax,%edx
  80149f:	89 d0                	mov    %edx,%eax
  8014a1:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8014a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014a7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014ac:	f7 e9                	imul   %ecx
  8014ae:	c1 fa 02             	sar    $0x2,%edx
  8014b1:	89 c8                	mov    %ecx,%eax
  8014b3:	c1 f8 1f             	sar    $0x1f,%eax
  8014b6:	29 c2                	sub    %eax,%edx
  8014b8:	89 d0                	mov    %edx,%eax
  8014ba:	c1 e0 02             	shl    $0x2,%eax
  8014bd:	01 d0                	add    %edx,%eax
  8014bf:	01 c0                	add    %eax,%eax
  8014c1:	29 c1                	sub    %eax,%ecx
  8014c3:	89 ca                	mov    %ecx,%edx
  8014c5:	85 d2                	test   %edx,%edx
  8014c7:	75 9c                	jne    801465 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8014c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8014d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d3:	48                   	dec    %eax
  8014d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8014d7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014db:	74 3d                	je     80151a <ltostr+0xe2>
		start = 1 ;
  8014dd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8014e4:	eb 34                	jmp    80151a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8014e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ec:	01 d0                	add    %edx,%eax
  8014ee:	8a 00                	mov    (%eax),%al
  8014f0:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8014f3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f9:	01 c2                	add    %eax,%edx
  8014fb:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8014fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801501:	01 c8                	add    %ecx,%eax
  801503:	8a 00                	mov    (%eax),%al
  801505:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801507:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80150a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150d:	01 c2                	add    %eax,%edx
  80150f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801512:	88 02                	mov    %al,(%edx)
		start++ ;
  801514:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801517:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80151a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80151d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801520:	7c c4                	jl     8014e6 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801522:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801525:	8b 45 0c             	mov    0xc(%ebp),%eax
  801528:	01 d0                	add    %edx,%eax
  80152a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80152d:	90                   	nop
  80152e:	c9                   	leave  
  80152f:	c3                   	ret    

00801530 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801530:	55                   	push   %ebp
  801531:	89 e5                	mov    %esp,%ebp
  801533:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801536:	ff 75 08             	pushl  0x8(%ebp)
  801539:	e8 54 fa ff ff       	call   800f92 <strlen>
  80153e:	83 c4 04             	add    $0x4,%esp
  801541:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801544:	ff 75 0c             	pushl  0xc(%ebp)
  801547:	e8 46 fa ff ff       	call   800f92 <strlen>
  80154c:	83 c4 04             	add    $0x4,%esp
  80154f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801552:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801559:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801560:	eb 17                	jmp    801579 <strcconcat+0x49>
		final[s] = str1[s] ;
  801562:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801565:	8b 45 10             	mov    0x10(%ebp),%eax
  801568:	01 c2                	add    %eax,%edx
  80156a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80156d:	8b 45 08             	mov    0x8(%ebp),%eax
  801570:	01 c8                	add    %ecx,%eax
  801572:	8a 00                	mov    (%eax),%al
  801574:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801576:	ff 45 fc             	incl   -0x4(%ebp)
  801579:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80157c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80157f:	7c e1                	jl     801562 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801581:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801588:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80158f:	eb 1f                	jmp    8015b0 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801591:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801594:	8d 50 01             	lea    0x1(%eax),%edx
  801597:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80159a:	89 c2                	mov    %eax,%edx
  80159c:	8b 45 10             	mov    0x10(%ebp),%eax
  80159f:	01 c2                	add    %eax,%edx
  8015a1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a7:	01 c8                	add    %ecx,%eax
  8015a9:	8a 00                	mov    (%eax),%al
  8015ab:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8015ad:	ff 45 f8             	incl   -0x8(%ebp)
  8015b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015b3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015b6:	7c d9                	jl     801591 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8015b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8015be:	01 d0                	add    %edx,%eax
  8015c0:	c6 00 00             	movb   $0x0,(%eax)
}
  8015c3:	90                   	nop
  8015c4:	c9                   	leave  
  8015c5:	c3                   	ret    

008015c6 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8015c6:	55                   	push   %ebp
  8015c7:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8015c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8015cc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8015d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8015d5:	8b 00                	mov    (%eax),%eax
  8015d7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015de:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e1:	01 d0                	add    %edx,%eax
  8015e3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8015e9:	eb 0c                	jmp    8015f7 <strsplit+0x31>
			*string++ = 0;
  8015eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ee:	8d 50 01             	lea    0x1(%eax),%edx
  8015f1:	89 55 08             	mov    %edx,0x8(%ebp)
  8015f4:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8015f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fa:	8a 00                	mov    (%eax),%al
  8015fc:	84 c0                	test   %al,%al
  8015fe:	74 18                	je     801618 <strsplit+0x52>
  801600:	8b 45 08             	mov    0x8(%ebp),%eax
  801603:	8a 00                	mov    (%eax),%al
  801605:	0f be c0             	movsbl %al,%eax
  801608:	50                   	push   %eax
  801609:	ff 75 0c             	pushl  0xc(%ebp)
  80160c:	e8 13 fb ff ff       	call   801124 <strchr>
  801611:	83 c4 08             	add    $0x8,%esp
  801614:	85 c0                	test   %eax,%eax
  801616:	75 d3                	jne    8015eb <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801618:	8b 45 08             	mov    0x8(%ebp),%eax
  80161b:	8a 00                	mov    (%eax),%al
  80161d:	84 c0                	test   %al,%al
  80161f:	74 5a                	je     80167b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801621:	8b 45 14             	mov    0x14(%ebp),%eax
  801624:	8b 00                	mov    (%eax),%eax
  801626:	83 f8 0f             	cmp    $0xf,%eax
  801629:	75 07                	jne    801632 <strsplit+0x6c>
		{
			return 0;
  80162b:	b8 00 00 00 00       	mov    $0x0,%eax
  801630:	eb 66                	jmp    801698 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801632:	8b 45 14             	mov    0x14(%ebp),%eax
  801635:	8b 00                	mov    (%eax),%eax
  801637:	8d 48 01             	lea    0x1(%eax),%ecx
  80163a:	8b 55 14             	mov    0x14(%ebp),%edx
  80163d:	89 0a                	mov    %ecx,(%edx)
  80163f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801646:	8b 45 10             	mov    0x10(%ebp),%eax
  801649:	01 c2                	add    %eax,%edx
  80164b:	8b 45 08             	mov    0x8(%ebp),%eax
  80164e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801650:	eb 03                	jmp    801655 <strsplit+0x8f>
			string++;
  801652:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801655:	8b 45 08             	mov    0x8(%ebp),%eax
  801658:	8a 00                	mov    (%eax),%al
  80165a:	84 c0                	test   %al,%al
  80165c:	74 8b                	je     8015e9 <strsplit+0x23>
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	8a 00                	mov    (%eax),%al
  801663:	0f be c0             	movsbl %al,%eax
  801666:	50                   	push   %eax
  801667:	ff 75 0c             	pushl  0xc(%ebp)
  80166a:	e8 b5 fa ff ff       	call   801124 <strchr>
  80166f:	83 c4 08             	add    $0x8,%esp
  801672:	85 c0                	test   %eax,%eax
  801674:	74 dc                	je     801652 <strsplit+0x8c>
			string++;
	}
  801676:	e9 6e ff ff ff       	jmp    8015e9 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80167b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80167c:	8b 45 14             	mov    0x14(%ebp),%eax
  80167f:	8b 00                	mov    (%eax),%eax
  801681:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801688:	8b 45 10             	mov    0x10(%ebp),%eax
  80168b:	01 d0                	add    %edx,%eax
  80168d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801693:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801698:	c9                   	leave  
  801699:	c3                   	ret    

0080169a <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80169a:	55                   	push   %ebp
  80169b:	89 e5                	mov    %esp,%ebp
  80169d:	83 ec 18             	sub    $0x18,%esp
  8016a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a3:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8016a6:	83 ec 04             	sub    $0x4,%esp
  8016a9:	68 30 2b 80 00       	push   $0x802b30
  8016ae:	6a 17                	push   $0x17
  8016b0:	68 4f 2b 80 00       	push   $0x802b4f
  8016b5:	e8 a2 ef ff ff       	call   80065c <_panic>

008016ba <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8016ba:	55                   	push   %ebp
  8016bb:	89 e5                	mov    %esp,%ebp
  8016bd:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8016c0:	83 ec 04             	sub    $0x4,%esp
  8016c3:	68 5b 2b 80 00       	push   $0x802b5b
  8016c8:	6a 2f                	push   $0x2f
  8016ca:	68 4f 2b 80 00       	push   $0x802b4f
  8016cf:	e8 88 ef ff ff       	call   80065c <_panic>

008016d4 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8016d4:	55                   	push   %ebp
  8016d5:	89 e5                	mov    %esp,%ebp
  8016d7:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8016da:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8016e1:	8b 55 08             	mov    0x8(%ebp),%edx
  8016e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016e7:	01 d0                	add    %edx,%eax
  8016e9:	48                   	dec    %eax
  8016ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8016ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016f0:	ba 00 00 00 00       	mov    $0x0,%edx
  8016f5:	f7 75 ec             	divl   -0x14(%ebp)
  8016f8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016fb:	29 d0                	sub    %edx,%eax
  8016fd:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801700:	8b 45 08             	mov    0x8(%ebp),%eax
  801703:	c1 e8 0c             	shr    $0xc,%eax
  801706:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801709:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801710:	e9 c8 00 00 00       	jmp    8017dd <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801715:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80171c:	eb 27                	jmp    801745 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  80171e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801721:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801724:	01 c2                	add    %eax,%edx
  801726:	89 d0                	mov    %edx,%eax
  801728:	01 c0                	add    %eax,%eax
  80172a:	01 d0                	add    %edx,%eax
  80172c:	c1 e0 02             	shl    $0x2,%eax
  80172f:	05 48 30 80 00       	add    $0x803048,%eax
  801734:	8b 00                	mov    (%eax),%eax
  801736:	85 c0                	test   %eax,%eax
  801738:	74 08                	je     801742 <malloc+0x6e>
            	i += j;
  80173a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80173d:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801740:	eb 0b                	jmp    80174d <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801742:	ff 45 f0             	incl   -0x10(%ebp)
  801745:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801748:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80174b:	72 d1                	jb     80171e <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  80174d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801750:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801753:	0f 85 81 00 00 00    	jne    8017da <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801759:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80175c:	05 00 00 08 00       	add    $0x80000,%eax
  801761:	c1 e0 0c             	shl    $0xc,%eax
  801764:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801767:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80176e:	eb 1f                	jmp    80178f <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801770:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801773:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801776:	01 c2                	add    %eax,%edx
  801778:	89 d0                	mov    %edx,%eax
  80177a:	01 c0                	add    %eax,%eax
  80177c:	01 d0                	add    %edx,%eax
  80177e:	c1 e0 02             	shl    $0x2,%eax
  801781:	05 48 30 80 00       	add    $0x803048,%eax
  801786:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80178c:	ff 45 f0             	incl   -0x10(%ebp)
  80178f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801792:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801795:	72 d9                	jb     801770 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801797:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80179a:	89 d0                	mov    %edx,%eax
  80179c:	01 c0                	add    %eax,%eax
  80179e:	01 d0                	add    %edx,%eax
  8017a0:	c1 e0 02             	shl    $0x2,%eax
  8017a3:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  8017a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8017ac:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8017ae:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8017b1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8017b4:	89 c8                	mov    %ecx,%eax
  8017b6:	01 c0                	add    %eax,%eax
  8017b8:	01 c8                	add    %ecx,%eax
  8017ba:	c1 e0 02             	shl    $0x2,%eax
  8017bd:	05 44 30 80 00       	add    $0x803044,%eax
  8017c2:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8017c4:	83 ec 08             	sub    $0x8,%esp
  8017c7:	ff 75 08             	pushl  0x8(%ebp)
  8017ca:	ff 75 e0             	pushl  -0x20(%ebp)
  8017cd:	e8 2b 03 00 00       	call   801afd <sys_allocateMem>
  8017d2:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8017d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8017d8:	eb 19                	jmp    8017f3 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8017da:	ff 45 f4             	incl   -0xc(%ebp)
  8017dd:	a1 04 30 80 00       	mov    0x803004,%eax
  8017e2:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8017e5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8017e8:	0f 83 27 ff ff ff    	jae    801715 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8017ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f3:	c9                   	leave  
  8017f4:	c3                   	ret    

008017f5 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8017f5:	55                   	push   %ebp
  8017f6:	89 e5                	mov    %esp,%ebp
  8017f8:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8017fb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017ff:	0f 84 e5 00 00 00    	je     8018ea <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801805:	8b 45 08             	mov    0x8(%ebp),%eax
  801808:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  80180b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80180e:	05 00 00 00 80       	add    $0x80000000,%eax
  801813:	c1 e8 0c             	shr    $0xc,%eax
  801816:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801819:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80181c:	89 d0                	mov    %edx,%eax
  80181e:	01 c0                	add    %eax,%eax
  801820:	01 d0                	add    %edx,%eax
  801822:	c1 e0 02             	shl    $0x2,%eax
  801825:	05 40 30 80 00       	add    $0x803040,%eax
  80182a:	8b 00                	mov    (%eax),%eax
  80182c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80182f:	0f 85 b8 00 00 00    	jne    8018ed <free+0xf8>
  801835:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801838:	89 d0                	mov    %edx,%eax
  80183a:	01 c0                	add    %eax,%eax
  80183c:	01 d0                	add    %edx,%eax
  80183e:	c1 e0 02             	shl    $0x2,%eax
  801841:	05 48 30 80 00       	add    $0x803048,%eax
  801846:	8b 00                	mov    (%eax),%eax
  801848:	85 c0                	test   %eax,%eax
  80184a:	0f 84 9d 00 00 00    	je     8018ed <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801850:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801853:	89 d0                	mov    %edx,%eax
  801855:	01 c0                	add    %eax,%eax
  801857:	01 d0                	add    %edx,%eax
  801859:	c1 e0 02             	shl    $0x2,%eax
  80185c:	05 44 30 80 00       	add    $0x803044,%eax
  801861:	8b 00                	mov    (%eax),%eax
  801863:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801866:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801869:	c1 e0 0c             	shl    $0xc,%eax
  80186c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  80186f:	83 ec 08             	sub    $0x8,%esp
  801872:	ff 75 e4             	pushl  -0x1c(%ebp)
  801875:	ff 75 f0             	pushl  -0x10(%ebp)
  801878:	e8 64 02 00 00       	call   801ae1 <sys_freeMem>
  80187d:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801880:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801887:	eb 57                	jmp    8018e0 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801889:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80188c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80188f:	01 c2                	add    %eax,%edx
  801891:	89 d0                	mov    %edx,%eax
  801893:	01 c0                	add    %eax,%eax
  801895:	01 d0                	add    %edx,%eax
  801897:	c1 e0 02             	shl    $0x2,%eax
  80189a:	05 48 30 80 00       	add    $0x803048,%eax
  80189f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  8018a5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018ab:	01 c2                	add    %eax,%edx
  8018ad:	89 d0                	mov    %edx,%eax
  8018af:	01 c0                	add    %eax,%eax
  8018b1:	01 d0                	add    %edx,%eax
  8018b3:	c1 e0 02             	shl    $0x2,%eax
  8018b6:	05 40 30 80 00       	add    $0x803040,%eax
  8018bb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8018c1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018c7:	01 c2                	add    %eax,%edx
  8018c9:	89 d0                	mov    %edx,%eax
  8018cb:	01 c0                	add    %eax,%eax
  8018cd:	01 d0                	add    %edx,%eax
  8018cf:	c1 e0 02             	shl    $0x2,%eax
  8018d2:	05 44 30 80 00       	add    $0x803044,%eax
  8018d7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8018dd:	ff 45 f4             	incl   -0xc(%ebp)
  8018e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018e3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8018e6:	7c a1                	jl     801889 <free+0x94>
  8018e8:	eb 04                	jmp    8018ee <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8018ea:	90                   	nop
  8018eb:	eb 01                	jmp    8018ee <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8018ed:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8018ee:	c9                   	leave  
  8018ef:	c3                   	ret    

008018f0 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8018f0:	55                   	push   %ebp
  8018f1:	89 e5                	mov    %esp,%ebp
  8018f3:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8018f6:	83 ec 04             	sub    $0x4,%esp
  8018f9:	68 78 2b 80 00       	push   $0x802b78
  8018fe:	68 ae 00 00 00       	push   $0xae
  801903:	68 4f 2b 80 00       	push   $0x802b4f
  801908:	e8 4f ed ff ff       	call   80065c <_panic>

0080190d <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80190d:	55                   	push   %ebp
  80190e:	89 e5                	mov    %esp,%ebp
  801910:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801913:	83 ec 04             	sub    $0x4,%esp
  801916:	68 98 2b 80 00       	push   $0x802b98
  80191b:	68 ca 00 00 00       	push   $0xca
  801920:	68 4f 2b 80 00       	push   $0x802b4f
  801925:	e8 32 ed ff ff       	call   80065c <_panic>

0080192a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80192a:	55                   	push   %ebp
  80192b:	89 e5                	mov    %esp,%ebp
  80192d:	57                   	push   %edi
  80192e:	56                   	push   %esi
  80192f:	53                   	push   %ebx
  801930:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801933:	8b 45 08             	mov    0x8(%ebp),%eax
  801936:	8b 55 0c             	mov    0xc(%ebp),%edx
  801939:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80193c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80193f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801942:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801945:	cd 30                	int    $0x30
  801947:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80194a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80194d:	83 c4 10             	add    $0x10,%esp
  801950:	5b                   	pop    %ebx
  801951:	5e                   	pop    %esi
  801952:	5f                   	pop    %edi
  801953:	5d                   	pop    %ebp
  801954:	c3                   	ret    

00801955 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801955:	55                   	push   %ebp
  801956:	89 e5                	mov    %esp,%ebp
  801958:	83 ec 04             	sub    $0x4,%esp
  80195b:	8b 45 10             	mov    0x10(%ebp),%eax
  80195e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801961:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801965:	8b 45 08             	mov    0x8(%ebp),%eax
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	52                   	push   %edx
  80196d:	ff 75 0c             	pushl  0xc(%ebp)
  801970:	50                   	push   %eax
  801971:	6a 00                	push   $0x0
  801973:	e8 b2 ff ff ff       	call   80192a <syscall>
  801978:	83 c4 18             	add    $0x18,%esp
}
  80197b:	90                   	nop
  80197c:	c9                   	leave  
  80197d:	c3                   	ret    

0080197e <sys_cgetc>:

int
sys_cgetc(void)
{
  80197e:	55                   	push   %ebp
  80197f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 01                	push   $0x1
  80198d:	e8 98 ff ff ff       	call   80192a <syscall>
  801992:	83 c4 18             	add    $0x18,%esp
}
  801995:	c9                   	leave  
  801996:	c3                   	ret    

00801997 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801997:	55                   	push   %ebp
  801998:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80199a:	8b 45 08             	mov    0x8(%ebp),%eax
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	50                   	push   %eax
  8019a6:	6a 05                	push   $0x5
  8019a8:	e8 7d ff ff ff       	call   80192a <syscall>
  8019ad:	83 c4 18             	add    $0x18,%esp
}
  8019b0:	c9                   	leave  
  8019b1:	c3                   	ret    

008019b2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 00                	push   $0x0
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 02                	push   $0x2
  8019c1:	e8 64 ff ff ff       	call   80192a <syscall>
  8019c6:	83 c4 18             	add    $0x18,%esp
}
  8019c9:	c9                   	leave  
  8019ca:	c3                   	ret    

008019cb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8019cb:	55                   	push   %ebp
  8019cc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 03                	push   $0x3
  8019da:	e8 4b ff ff ff       	call   80192a <syscall>
  8019df:	83 c4 18             	add    $0x18,%esp
}
  8019e2:	c9                   	leave  
  8019e3:	c3                   	ret    

008019e4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019e4:	55                   	push   %ebp
  8019e5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 04                	push   $0x4
  8019f3:	e8 32 ff ff ff       	call   80192a <syscall>
  8019f8:	83 c4 18             	add    $0x18,%esp
}
  8019fb:	c9                   	leave  
  8019fc:	c3                   	ret    

008019fd <sys_env_exit>:


void sys_env_exit(void)
{
  8019fd:	55                   	push   %ebp
  8019fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	6a 06                	push   $0x6
  801a0c:	e8 19 ff ff ff       	call   80192a <syscall>
  801a11:	83 c4 18             	add    $0x18,%esp
}
  801a14:	90                   	nop
  801a15:	c9                   	leave  
  801a16:	c3                   	ret    

00801a17 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801a17:	55                   	push   %ebp
  801a18:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801a1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	52                   	push   %edx
  801a27:	50                   	push   %eax
  801a28:	6a 07                	push   $0x7
  801a2a:	e8 fb fe ff ff       	call   80192a <syscall>
  801a2f:	83 c4 18             	add    $0x18,%esp
}
  801a32:	c9                   	leave  
  801a33:	c3                   	ret    

00801a34 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801a34:	55                   	push   %ebp
  801a35:	89 e5                	mov    %esp,%ebp
  801a37:	56                   	push   %esi
  801a38:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801a39:	8b 75 18             	mov    0x18(%ebp),%esi
  801a3c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a3f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a42:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a45:	8b 45 08             	mov    0x8(%ebp),%eax
  801a48:	56                   	push   %esi
  801a49:	53                   	push   %ebx
  801a4a:	51                   	push   %ecx
  801a4b:	52                   	push   %edx
  801a4c:	50                   	push   %eax
  801a4d:	6a 08                	push   $0x8
  801a4f:	e8 d6 fe ff ff       	call   80192a <syscall>
  801a54:	83 c4 18             	add    $0x18,%esp
}
  801a57:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801a5a:	5b                   	pop    %ebx
  801a5b:	5e                   	pop    %esi
  801a5c:	5d                   	pop    %ebp
  801a5d:	c3                   	ret    

00801a5e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801a5e:	55                   	push   %ebp
  801a5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801a61:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a64:	8b 45 08             	mov    0x8(%ebp),%eax
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	52                   	push   %edx
  801a6e:	50                   	push   %eax
  801a6f:	6a 09                	push   $0x9
  801a71:	e8 b4 fe ff ff       	call   80192a <syscall>
  801a76:	83 c4 18             	add    $0x18,%esp
}
  801a79:	c9                   	leave  
  801a7a:	c3                   	ret    

00801a7b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801a7b:	55                   	push   %ebp
  801a7c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	ff 75 0c             	pushl  0xc(%ebp)
  801a87:	ff 75 08             	pushl  0x8(%ebp)
  801a8a:	6a 0a                	push   $0xa
  801a8c:	e8 99 fe ff ff       	call   80192a <syscall>
  801a91:	83 c4 18             	add    $0x18,%esp
}
  801a94:	c9                   	leave  
  801a95:	c3                   	ret    

00801a96 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801a96:	55                   	push   %ebp
  801a97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 0b                	push   $0xb
  801aa5:	e8 80 fe ff ff       	call   80192a <syscall>
  801aaa:	83 c4 18             	add    $0x18,%esp
}
  801aad:	c9                   	leave  
  801aae:	c3                   	ret    

00801aaf <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801aaf:	55                   	push   %ebp
  801ab0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 0c                	push   $0xc
  801abe:	e8 67 fe ff ff       	call   80192a <syscall>
  801ac3:	83 c4 18             	add    $0x18,%esp
}
  801ac6:	c9                   	leave  
  801ac7:	c3                   	ret    

00801ac8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ac8:	55                   	push   %ebp
  801ac9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 0d                	push   $0xd
  801ad7:	e8 4e fe ff ff       	call   80192a <syscall>
  801adc:	83 c4 18             	add    $0x18,%esp
}
  801adf:	c9                   	leave  
  801ae0:	c3                   	ret    

00801ae1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ae1:	55                   	push   %ebp
  801ae2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	ff 75 0c             	pushl  0xc(%ebp)
  801aed:	ff 75 08             	pushl  0x8(%ebp)
  801af0:	6a 11                	push   $0x11
  801af2:	e8 33 fe ff ff       	call   80192a <syscall>
  801af7:	83 c4 18             	add    $0x18,%esp
	return;
  801afa:	90                   	nop
}
  801afb:	c9                   	leave  
  801afc:	c3                   	ret    

00801afd <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801afd:	55                   	push   %ebp
  801afe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	6a 00                	push   $0x0
  801b06:	ff 75 0c             	pushl  0xc(%ebp)
  801b09:	ff 75 08             	pushl  0x8(%ebp)
  801b0c:	6a 12                	push   $0x12
  801b0e:	e8 17 fe ff ff       	call   80192a <syscall>
  801b13:	83 c4 18             	add    $0x18,%esp
	return ;
  801b16:	90                   	nop
}
  801b17:	c9                   	leave  
  801b18:	c3                   	ret    

00801b19 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801b19:	55                   	push   %ebp
  801b1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	6a 0e                	push   $0xe
  801b28:	e8 fd fd ff ff       	call   80192a <syscall>
  801b2d:	83 c4 18             	add    $0x18,%esp
}
  801b30:	c9                   	leave  
  801b31:	c3                   	ret    

00801b32 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801b32:	55                   	push   %ebp
  801b33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801b35:	6a 00                	push   $0x0
  801b37:	6a 00                	push   $0x0
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	ff 75 08             	pushl  0x8(%ebp)
  801b40:	6a 0f                	push   $0xf
  801b42:	e8 e3 fd ff ff       	call   80192a <syscall>
  801b47:	83 c4 18             	add    $0x18,%esp
}
  801b4a:	c9                   	leave  
  801b4b:	c3                   	ret    

00801b4c <sys_scarce_memory>:

void sys_scarce_memory()
{
  801b4c:	55                   	push   %ebp
  801b4d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 00                	push   $0x0
  801b57:	6a 00                	push   $0x0
  801b59:	6a 10                	push   $0x10
  801b5b:	e8 ca fd ff ff       	call   80192a <syscall>
  801b60:	83 c4 18             	add    $0x18,%esp
}
  801b63:	90                   	nop
  801b64:	c9                   	leave  
  801b65:	c3                   	ret    

00801b66 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801b66:	55                   	push   %ebp
  801b67:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	6a 14                	push   $0x14
  801b75:	e8 b0 fd ff ff       	call   80192a <syscall>
  801b7a:	83 c4 18             	add    $0x18,%esp
}
  801b7d:	90                   	nop
  801b7e:	c9                   	leave  
  801b7f:	c3                   	ret    

00801b80 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801b80:	55                   	push   %ebp
  801b81:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 00                	push   $0x0
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 15                	push   $0x15
  801b8f:	e8 96 fd ff ff       	call   80192a <syscall>
  801b94:	83 c4 18             	add    $0x18,%esp
}
  801b97:	90                   	nop
  801b98:	c9                   	leave  
  801b99:	c3                   	ret    

00801b9a <sys_cputc>:


void
sys_cputc(const char c)
{
  801b9a:	55                   	push   %ebp
  801b9b:	89 e5                	mov    %esp,%ebp
  801b9d:	83 ec 04             	sub    $0x4,%esp
  801ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ba6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	50                   	push   %eax
  801bb3:	6a 16                	push   $0x16
  801bb5:	e8 70 fd ff ff       	call   80192a <syscall>
  801bba:	83 c4 18             	add    $0x18,%esp
}
  801bbd:	90                   	nop
  801bbe:	c9                   	leave  
  801bbf:	c3                   	ret    

00801bc0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801bc0:	55                   	push   %ebp
  801bc1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 17                	push   $0x17
  801bcf:	e8 56 fd ff ff       	call   80192a <syscall>
  801bd4:	83 c4 18             	add    $0x18,%esp
}
  801bd7:	90                   	nop
  801bd8:	c9                   	leave  
  801bd9:	c3                   	ret    

00801bda <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801bda:	55                   	push   %ebp
  801bdb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	ff 75 0c             	pushl  0xc(%ebp)
  801be9:	50                   	push   %eax
  801bea:	6a 18                	push   $0x18
  801bec:	e8 39 fd ff ff       	call   80192a <syscall>
  801bf1:	83 c4 18             	add    $0x18,%esp
}
  801bf4:	c9                   	leave  
  801bf5:	c3                   	ret    

00801bf6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801bf6:	55                   	push   %ebp
  801bf7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801bf9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	52                   	push   %edx
  801c06:	50                   	push   %eax
  801c07:	6a 1b                	push   $0x1b
  801c09:	e8 1c fd ff ff       	call   80192a <syscall>
  801c0e:	83 c4 18             	add    $0x18,%esp
}
  801c11:	c9                   	leave  
  801c12:	c3                   	ret    

00801c13 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c13:	55                   	push   %ebp
  801c14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c16:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c19:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	52                   	push   %edx
  801c23:	50                   	push   %eax
  801c24:	6a 19                	push   $0x19
  801c26:	e8 ff fc ff ff       	call   80192a <syscall>
  801c2b:	83 c4 18             	add    $0x18,%esp
}
  801c2e:	90                   	nop
  801c2f:	c9                   	leave  
  801c30:	c3                   	ret    

00801c31 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c31:	55                   	push   %ebp
  801c32:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c37:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	52                   	push   %edx
  801c41:	50                   	push   %eax
  801c42:	6a 1a                	push   $0x1a
  801c44:	e8 e1 fc ff ff       	call   80192a <syscall>
  801c49:	83 c4 18             	add    $0x18,%esp
}
  801c4c:	90                   	nop
  801c4d:	c9                   	leave  
  801c4e:	c3                   	ret    

00801c4f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801c4f:	55                   	push   %ebp
  801c50:	89 e5                	mov    %esp,%ebp
  801c52:	83 ec 04             	sub    $0x4,%esp
  801c55:	8b 45 10             	mov    0x10(%ebp),%eax
  801c58:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801c5b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801c5e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c62:	8b 45 08             	mov    0x8(%ebp),%eax
  801c65:	6a 00                	push   $0x0
  801c67:	51                   	push   %ecx
  801c68:	52                   	push   %edx
  801c69:	ff 75 0c             	pushl  0xc(%ebp)
  801c6c:	50                   	push   %eax
  801c6d:	6a 1c                	push   $0x1c
  801c6f:	e8 b6 fc ff ff       	call   80192a <syscall>
  801c74:	83 c4 18             	add    $0x18,%esp
}
  801c77:	c9                   	leave  
  801c78:	c3                   	ret    

00801c79 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801c79:	55                   	push   %ebp
  801c7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801c7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c82:	6a 00                	push   $0x0
  801c84:	6a 00                	push   $0x0
  801c86:	6a 00                	push   $0x0
  801c88:	52                   	push   %edx
  801c89:	50                   	push   %eax
  801c8a:	6a 1d                	push   $0x1d
  801c8c:	e8 99 fc ff ff       	call   80192a <syscall>
  801c91:	83 c4 18             	add    $0x18,%esp
}
  801c94:	c9                   	leave  
  801c95:	c3                   	ret    

00801c96 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801c96:	55                   	push   %ebp
  801c97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801c99:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	51                   	push   %ecx
  801ca7:	52                   	push   %edx
  801ca8:	50                   	push   %eax
  801ca9:	6a 1e                	push   $0x1e
  801cab:	e8 7a fc ff ff       	call   80192a <syscall>
  801cb0:	83 c4 18             	add    $0x18,%esp
}
  801cb3:	c9                   	leave  
  801cb4:	c3                   	ret    

00801cb5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801cb5:	55                   	push   %ebp
  801cb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801cb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	52                   	push   %edx
  801cc5:	50                   	push   %eax
  801cc6:	6a 1f                	push   $0x1f
  801cc8:	e8 5d fc ff ff       	call   80192a <syscall>
  801ccd:	83 c4 18             	add    $0x18,%esp
}
  801cd0:	c9                   	leave  
  801cd1:	c3                   	ret    

00801cd2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801cd2:	55                   	push   %ebp
  801cd3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 20                	push   $0x20
  801ce1:	e8 44 fc ff ff       	call   80192a <syscall>
  801ce6:	83 c4 18             	add    $0x18,%esp
}
  801ce9:	c9                   	leave  
  801cea:	c3                   	ret    

00801ceb <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801ceb:	55                   	push   %ebp
  801cec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801cee:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	ff 75 10             	pushl  0x10(%ebp)
  801cf8:	ff 75 0c             	pushl  0xc(%ebp)
  801cfb:	50                   	push   %eax
  801cfc:	6a 21                	push   $0x21
  801cfe:	e8 27 fc ff ff       	call   80192a <syscall>
  801d03:	83 c4 18             	add    $0x18,%esp
}
  801d06:	c9                   	leave  
  801d07:	c3                   	ret    

00801d08 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801d08:	55                   	push   %ebp
  801d09:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	50                   	push   %eax
  801d17:	6a 22                	push   $0x22
  801d19:	e8 0c fc ff ff       	call   80192a <syscall>
  801d1e:	83 c4 18             	add    $0x18,%esp
}
  801d21:	90                   	nop
  801d22:	c9                   	leave  
  801d23:	c3                   	ret    

00801d24 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801d24:	55                   	push   %ebp
  801d25:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801d27:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	50                   	push   %eax
  801d33:	6a 23                	push   $0x23
  801d35:	e8 f0 fb ff ff       	call   80192a <syscall>
  801d3a:	83 c4 18             	add    $0x18,%esp
}
  801d3d:	90                   	nop
  801d3e:	c9                   	leave  
  801d3f:	c3                   	ret    

00801d40 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801d40:	55                   	push   %ebp
  801d41:	89 e5                	mov    %esp,%ebp
  801d43:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801d46:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d49:	8d 50 04             	lea    0x4(%eax),%edx
  801d4c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	6a 00                	push   $0x0
  801d55:	52                   	push   %edx
  801d56:	50                   	push   %eax
  801d57:	6a 24                	push   $0x24
  801d59:	e8 cc fb ff ff       	call   80192a <syscall>
  801d5e:	83 c4 18             	add    $0x18,%esp
	return result;
  801d61:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d64:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d67:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d6a:	89 01                	mov    %eax,(%ecx)
  801d6c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801d6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d72:	c9                   	leave  
  801d73:	c2 04 00             	ret    $0x4

00801d76 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801d76:	55                   	push   %ebp
  801d77:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	ff 75 10             	pushl  0x10(%ebp)
  801d80:	ff 75 0c             	pushl  0xc(%ebp)
  801d83:	ff 75 08             	pushl  0x8(%ebp)
  801d86:	6a 13                	push   $0x13
  801d88:	e8 9d fb ff ff       	call   80192a <syscall>
  801d8d:	83 c4 18             	add    $0x18,%esp
	return ;
  801d90:	90                   	nop
}
  801d91:	c9                   	leave  
  801d92:	c3                   	ret    

00801d93 <sys_rcr2>:
uint32 sys_rcr2()
{
  801d93:	55                   	push   %ebp
  801d94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 25                	push   $0x25
  801da2:	e8 83 fb ff ff       	call   80192a <syscall>
  801da7:	83 c4 18             	add    $0x18,%esp
}
  801daa:	c9                   	leave  
  801dab:	c3                   	ret    

00801dac <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801dac:	55                   	push   %ebp
  801dad:	89 e5                	mov    %esp,%ebp
  801daf:	83 ec 04             	sub    $0x4,%esp
  801db2:	8b 45 08             	mov    0x8(%ebp),%eax
  801db5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801db8:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	50                   	push   %eax
  801dc5:	6a 26                	push   $0x26
  801dc7:	e8 5e fb ff ff       	call   80192a <syscall>
  801dcc:	83 c4 18             	add    $0x18,%esp
	return ;
  801dcf:	90                   	nop
}
  801dd0:	c9                   	leave  
  801dd1:	c3                   	ret    

00801dd2 <rsttst>:
void rsttst()
{
  801dd2:	55                   	push   %ebp
  801dd3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 28                	push   $0x28
  801de1:	e8 44 fb ff ff       	call   80192a <syscall>
  801de6:	83 c4 18             	add    $0x18,%esp
	return ;
  801de9:	90                   	nop
}
  801dea:	c9                   	leave  
  801deb:	c3                   	ret    

00801dec <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801dec:	55                   	push   %ebp
  801ded:	89 e5                	mov    %esp,%ebp
  801def:	83 ec 04             	sub    $0x4,%esp
  801df2:	8b 45 14             	mov    0x14(%ebp),%eax
  801df5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801df8:	8b 55 18             	mov    0x18(%ebp),%edx
  801dfb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801dff:	52                   	push   %edx
  801e00:	50                   	push   %eax
  801e01:	ff 75 10             	pushl  0x10(%ebp)
  801e04:	ff 75 0c             	pushl  0xc(%ebp)
  801e07:	ff 75 08             	pushl  0x8(%ebp)
  801e0a:	6a 27                	push   $0x27
  801e0c:	e8 19 fb ff ff       	call   80192a <syscall>
  801e11:	83 c4 18             	add    $0x18,%esp
	return ;
  801e14:	90                   	nop
}
  801e15:	c9                   	leave  
  801e16:	c3                   	ret    

00801e17 <chktst>:
void chktst(uint32 n)
{
  801e17:	55                   	push   %ebp
  801e18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	ff 75 08             	pushl  0x8(%ebp)
  801e25:	6a 29                	push   $0x29
  801e27:	e8 fe fa ff ff       	call   80192a <syscall>
  801e2c:	83 c4 18             	add    $0x18,%esp
	return ;
  801e2f:	90                   	nop
}
  801e30:	c9                   	leave  
  801e31:	c3                   	ret    

00801e32 <inctst>:

void inctst()
{
  801e32:	55                   	push   %ebp
  801e33:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801e35:	6a 00                	push   $0x0
  801e37:	6a 00                	push   $0x0
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 2a                	push   $0x2a
  801e41:	e8 e4 fa ff ff       	call   80192a <syscall>
  801e46:	83 c4 18             	add    $0x18,%esp
	return ;
  801e49:	90                   	nop
}
  801e4a:	c9                   	leave  
  801e4b:	c3                   	ret    

00801e4c <gettst>:
uint32 gettst()
{
  801e4c:	55                   	push   %ebp
  801e4d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 2b                	push   $0x2b
  801e5b:	e8 ca fa ff ff       	call   80192a <syscall>
  801e60:	83 c4 18             	add    $0x18,%esp
}
  801e63:	c9                   	leave  
  801e64:	c3                   	ret    

00801e65 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801e65:	55                   	push   %ebp
  801e66:	89 e5                	mov    %esp,%ebp
  801e68:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 00                	push   $0x0
  801e73:	6a 00                	push   $0x0
  801e75:	6a 2c                	push   $0x2c
  801e77:	e8 ae fa ff ff       	call   80192a <syscall>
  801e7c:	83 c4 18             	add    $0x18,%esp
  801e7f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801e82:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801e86:	75 07                	jne    801e8f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801e88:	b8 01 00 00 00       	mov    $0x1,%eax
  801e8d:	eb 05                	jmp    801e94 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801e8f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e94:	c9                   	leave  
  801e95:	c3                   	ret    

00801e96 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801e96:	55                   	push   %ebp
  801e97:	89 e5                	mov    %esp,%ebp
  801e99:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 00                	push   $0x0
  801ea6:	6a 2c                	push   $0x2c
  801ea8:	e8 7d fa ff ff       	call   80192a <syscall>
  801ead:	83 c4 18             	add    $0x18,%esp
  801eb0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801eb3:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801eb7:	75 07                	jne    801ec0 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801eb9:	b8 01 00 00 00       	mov    $0x1,%eax
  801ebe:	eb 05                	jmp    801ec5 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ec0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ec5:	c9                   	leave  
  801ec6:	c3                   	ret    

00801ec7 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ec7:	55                   	push   %ebp
  801ec8:	89 e5                	mov    %esp,%ebp
  801eca:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 00                	push   $0x0
  801ed7:	6a 2c                	push   $0x2c
  801ed9:	e8 4c fa ff ff       	call   80192a <syscall>
  801ede:	83 c4 18             	add    $0x18,%esp
  801ee1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ee4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ee8:	75 07                	jne    801ef1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801eea:	b8 01 00 00 00       	mov    $0x1,%eax
  801eef:	eb 05                	jmp    801ef6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ef1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ef6:	c9                   	leave  
  801ef7:	c3                   	ret    

00801ef8 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ef8:	55                   	push   %ebp
  801ef9:	89 e5                	mov    %esp,%ebp
  801efb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 2c                	push   $0x2c
  801f0a:	e8 1b fa ff ff       	call   80192a <syscall>
  801f0f:	83 c4 18             	add    $0x18,%esp
  801f12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801f15:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801f19:	75 07                	jne    801f22 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801f1b:	b8 01 00 00 00       	mov    $0x1,%eax
  801f20:	eb 05                	jmp    801f27 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801f22:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f27:	c9                   	leave  
  801f28:	c3                   	ret    

00801f29 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801f29:	55                   	push   %ebp
  801f2a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	ff 75 08             	pushl  0x8(%ebp)
  801f37:	6a 2d                	push   $0x2d
  801f39:	e8 ec f9 ff ff       	call   80192a <syscall>
  801f3e:	83 c4 18             	add    $0x18,%esp
	return ;
  801f41:	90                   	nop
}
  801f42:	c9                   	leave  
  801f43:	c3                   	ret    

00801f44 <__udivdi3>:
  801f44:	55                   	push   %ebp
  801f45:	57                   	push   %edi
  801f46:	56                   	push   %esi
  801f47:	53                   	push   %ebx
  801f48:	83 ec 1c             	sub    $0x1c,%esp
  801f4b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f4f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801f53:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f57:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801f5b:	89 ca                	mov    %ecx,%edx
  801f5d:	89 f8                	mov    %edi,%eax
  801f5f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f63:	85 f6                	test   %esi,%esi
  801f65:	75 2d                	jne    801f94 <__udivdi3+0x50>
  801f67:	39 cf                	cmp    %ecx,%edi
  801f69:	77 65                	ja     801fd0 <__udivdi3+0x8c>
  801f6b:	89 fd                	mov    %edi,%ebp
  801f6d:	85 ff                	test   %edi,%edi
  801f6f:	75 0b                	jne    801f7c <__udivdi3+0x38>
  801f71:	b8 01 00 00 00       	mov    $0x1,%eax
  801f76:	31 d2                	xor    %edx,%edx
  801f78:	f7 f7                	div    %edi
  801f7a:	89 c5                	mov    %eax,%ebp
  801f7c:	31 d2                	xor    %edx,%edx
  801f7e:	89 c8                	mov    %ecx,%eax
  801f80:	f7 f5                	div    %ebp
  801f82:	89 c1                	mov    %eax,%ecx
  801f84:	89 d8                	mov    %ebx,%eax
  801f86:	f7 f5                	div    %ebp
  801f88:	89 cf                	mov    %ecx,%edi
  801f8a:	89 fa                	mov    %edi,%edx
  801f8c:	83 c4 1c             	add    $0x1c,%esp
  801f8f:	5b                   	pop    %ebx
  801f90:	5e                   	pop    %esi
  801f91:	5f                   	pop    %edi
  801f92:	5d                   	pop    %ebp
  801f93:	c3                   	ret    
  801f94:	39 ce                	cmp    %ecx,%esi
  801f96:	77 28                	ja     801fc0 <__udivdi3+0x7c>
  801f98:	0f bd fe             	bsr    %esi,%edi
  801f9b:	83 f7 1f             	xor    $0x1f,%edi
  801f9e:	75 40                	jne    801fe0 <__udivdi3+0x9c>
  801fa0:	39 ce                	cmp    %ecx,%esi
  801fa2:	72 0a                	jb     801fae <__udivdi3+0x6a>
  801fa4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801fa8:	0f 87 9e 00 00 00    	ja     80204c <__udivdi3+0x108>
  801fae:	b8 01 00 00 00       	mov    $0x1,%eax
  801fb3:	89 fa                	mov    %edi,%edx
  801fb5:	83 c4 1c             	add    $0x1c,%esp
  801fb8:	5b                   	pop    %ebx
  801fb9:	5e                   	pop    %esi
  801fba:	5f                   	pop    %edi
  801fbb:	5d                   	pop    %ebp
  801fbc:	c3                   	ret    
  801fbd:	8d 76 00             	lea    0x0(%esi),%esi
  801fc0:	31 ff                	xor    %edi,%edi
  801fc2:	31 c0                	xor    %eax,%eax
  801fc4:	89 fa                	mov    %edi,%edx
  801fc6:	83 c4 1c             	add    $0x1c,%esp
  801fc9:	5b                   	pop    %ebx
  801fca:	5e                   	pop    %esi
  801fcb:	5f                   	pop    %edi
  801fcc:	5d                   	pop    %ebp
  801fcd:	c3                   	ret    
  801fce:	66 90                	xchg   %ax,%ax
  801fd0:	89 d8                	mov    %ebx,%eax
  801fd2:	f7 f7                	div    %edi
  801fd4:	31 ff                	xor    %edi,%edi
  801fd6:	89 fa                	mov    %edi,%edx
  801fd8:	83 c4 1c             	add    $0x1c,%esp
  801fdb:	5b                   	pop    %ebx
  801fdc:	5e                   	pop    %esi
  801fdd:	5f                   	pop    %edi
  801fde:	5d                   	pop    %ebp
  801fdf:	c3                   	ret    
  801fe0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801fe5:	89 eb                	mov    %ebp,%ebx
  801fe7:	29 fb                	sub    %edi,%ebx
  801fe9:	89 f9                	mov    %edi,%ecx
  801feb:	d3 e6                	shl    %cl,%esi
  801fed:	89 c5                	mov    %eax,%ebp
  801fef:	88 d9                	mov    %bl,%cl
  801ff1:	d3 ed                	shr    %cl,%ebp
  801ff3:	89 e9                	mov    %ebp,%ecx
  801ff5:	09 f1                	or     %esi,%ecx
  801ff7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ffb:	89 f9                	mov    %edi,%ecx
  801ffd:	d3 e0                	shl    %cl,%eax
  801fff:	89 c5                	mov    %eax,%ebp
  802001:	89 d6                	mov    %edx,%esi
  802003:	88 d9                	mov    %bl,%cl
  802005:	d3 ee                	shr    %cl,%esi
  802007:	89 f9                	mov    %edi,%ecx
  802009:	d3 e2                	shl    %cl,%edx
  80200b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80200f:	88 d9                	mov    %bl,%cl
  802011:	d3 e8                	shr    %cl,%eax
  802013:	09 c2                	or     %eax,%edx
  802015:	89 d0                	mov    %edx,%eax
  802017:	89 f2                	mov    %esi,%edx
  802019:	f7 74 24 0c          	divl   0xc(%esp)
  80201d:	89 d6                	mov    %edx,%esi
  80201f:	89 c3                	mov    %eax,%ebx
  802021:	f7 e5                	mul    %ebp
  802023:	39 d6                	cmp    %edx,%esi
  802025:	72 19                	jb     802040 <__udivdi3+0xfc>
  802027:	74 0b                	je     802034 <__udivdi3+0xf0>
  802029:	89 d8                	mov    %ebx,%eax
  80202b:	31 ff                	xor    %edi,%edi
  80202d:	e9 58 ff ff ff       	jmp    801f8a <__udivdi3+0x46>
  802032:	66 90                	xchg   %ax,%ax
  802034:	8b 54 24 08          	mov    0x8(%esp),%edx
  802038:	89 f9                	mov    %edi,%ecx
  80203a:	d3 e2                	shl    %cl,%edx
  80203c:	39 c2                	cmp    %eax,%edx
  80203e:	73 e9                	jae    802029 <__udivdi3+0xe5>
  802040:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802043:	31 ff                	xor    %edi,%edi
  802045:	e9 40 ff ff ff       	jmp    801f8a <__udivdi3+0x46>
  80204a:	66 90                	xchg   %ax,%ax
  80204c:	31 c0                	xor    %eax,%eax
  80204e:	e9 37 ff ff ff       	jmp    801f8a <__udivdi3+0x46>
  802053:	90                   	nop

00802054 <__umoddi3>:
  802054:	55                   	push   %ebp
  802055:	57                   	push   %edi
  802056:	56                   	push   %esi
  802057:	53                   	push   %ebx
  802058:	83 ec 1c             	sub    $0x1c,%esp
  80205b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80205f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802063:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802067:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80206b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80206f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802073:	89 f3                	mov    %esi,%ebx
  802075:	89 fa                	mov    %edi,%edx
  802077:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80207b:	89 34 24             	mov    %esi,(%esp)
  80207e:	85 c0                	test   %eax,%eax
  802080:	75 1a                	jne    80209c <__umoddi3+0x48>
  802082:	39 f7                	cmp    %esi,%edi
  802084:	0f 86 a2 00 00 00    	jbe    80212c <__umoddi3+0xd8>
  80208a:	89 c8                	mov    %ecx,%eax
  80208c:	89 f2                	mov    %esi,%edx
  80208e:	f7 f7                	div    %edi
  802090:	89 d0                	mov    %edx,%eax
  802092:	31 d2                	xor    %edx,%edx
  802094:	83 c4 1c             	add    $0x1c,%esp
  802097:	5b                   	pop    %ebx
  802098:	5e                   	pop    %esi
  802099:	5f                   	pop    %edi
  80209a:	5d                   	pop    %ebp
  80209b:	c3                   	ret    
  80209c:	39 f0                	cmp    %esi,%eax
  80209e:	0f 87 ac 00 00 00    	ja     802150 <__umoddi3+0xfc>
  8020a4:	0f bd e8             	bsr    %eax,%ebp
  8020a7:	83 f5 1f             	xor    $0x1f,%ebp
  8020aa:	0f 84 ac 00 00 00    	je     80215c <__umoddi3+0x108>
  8020b0:	bf 20 00 00 00       	mov    $0x20,%edi
  8020b5:	29 ef                	sub    %ebp,%edi
  8020b7:	89 fe                	mov    %edi,%esi
  8020b9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8020bd:	89 e9                	mov    %ebp,%ecx
  8020bf:	d3 e0                	shl    %cl,%eax
  8020c1:	89 d7                	mov    %edx,%edi
  8020c3:	89 f1                	mov    %esi,%ecx
  8020c5:	d3 ef                	shr    %cl,%edi
  8020c7:	09 c7                	or     %eax,%edi
  8020c9:	89 e9                	mov    %ebp,%ecx
  8020cb:	d3 e2                	shl    %cl,%edx
  8020cd:	89 14 24             	mov    %edx,(%esp)
  8020d0:	89 d8                	mov    %ebx,%eax
  8020d2:	d3 e0                	shl    %cl,%eax
  8020d4:	89 c2                	mov    %eax,%edx
  8020d6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020da:	d3 e0                	shl    %cl,%eax
  8020dc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8020e0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020e4:	89 f1                	mov    %esi,%ecx
  8020e6:	d3 e8                	shr    %cl,%eax
  8020e8:	09 d0                	or     %edx,%eax
  8020ea:	d3 eb                	shr    %cl,%ebx
  8020ec:	89 da                	mov    %ebx,%edx
  8020ee:	f7 f7                	div    %edi
  8020f0:	89 d3                	mov    %edx,%ebx
  8020f2:	f7 24 24             	mull   (%esp)
  8020f5:	89 c6                	mov    %eax,%esi
  8020f7:	89 d1                	mov    %edx,%ecx
  8020f9:	39 d3                	cmp    %edx,%ebx
  8020fb:	0f 82 87 00 00 00    	jb     802188 <__umoddi3+0x134>
  802101:	0f 84 91 00 00 00    	je     802198 <__umoddi3+0x144>
  802107:	8b 54 24 04          	mov    0x4(%esp),%edx
  80210b:	29 f2                	sub    %esi,%edx
  80210d:	19 cb                	sbb    %ecx,%ebx
  80210f:	89 d8                	mov    %ebx,%eax
  802111:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802115:	d3 e0                	shl    %cl,%eax
  802117:	89 e9                	mov    %ebp,%ecx
  802119:	d3 ea                	shr    %cl,%edx
  80211b:	09 d0                	or     %edx,%eax
  80211d:	89 e9                	mov    %ebp,%ecx
  80211f:	d3 eb                	shr    %cl,%ebx
  802121:	89 da                	mov    %ebx,%edx
  802123:	83 c4 1c             	add    $0x1c,%esp
  802126:	5b                   	pop    %ebx
  802127:	5e                   	pop    %esi
  802128:	5f                   	pop    %edi
  802129:	5d                   	pop    %ebp
  80212a:	c3                   	ret    
  80212b:	90                   	nop
  80212c:	89 fd                	mov    %edi,%ebp
  80212e:	85 ff                	test   %edi,%edi
  802130:	75 0b                	jne    80213d <__umoddi3+0xe9>
  802132:	b8 01 00 00 00       	mov    $0x1,%eax
  802137:	31 d2                	xor    %edx,%edx
  802139:	f7 f7                	div    %edi
  80213b:	89 c5                	mov    %eax,%ebp
  80213d:	89 f0                	mov    %esi,%eax
  80213f:	31 d2                	xor    %edx,%edx
  802141:	f7 f5                	div    %ebp
  802143:	89 c8                	mov    %ecx,%eax
  802145:	f7 f5                	div    %ebp
  802147:	89 d0                	mov    %edx,%eax
  802149:	e9 44 ff ff ff       	jmp    802092 <__umoddi3+0x3e>
  80214e:	66 90                	xchg   %ax,%ax
  802150:	89 c8                	mov    %ecx,%eax
  802152:	89 f2                	mov    %esi,%edx
  802154:	83 c4 1c             	add    $0x1c,%esp
  802157:	5b                   	pop    %ebx
  802158:	5e                   	pop    %esi
  802159:	5f                   	pop    %edi
  80215a:	5d                   	pop    %ebp
  80215b:	c3                   	ret    
  80215c:	3b 04 24             	cmp    (%esp),%eax
  80215f:	72 06                	jb     802167 <__umoddi3+0x113>
  802161:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802165:	77 0f                	ja     802176 <__umoddi3+0x122>
  802167:	89 f2                	mov    %esi,%edx
  802169:	29 f9                	sub    %edi,%ecx
  80216b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80216f:	89 14 24             	mov    %edx,(%esp)
  802172:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802176:	8b 44 24 04          	mov    0x4(%esp),%eax
  80217a:	8b 14 24             	mov    (%esp),%edx
  80217d:	83 c4 1c             	add    $0x1c,%esp
  802180:	5b                   	pop    %ebx
  802181:	5e                   	pop    %esi
  802182:	5f                   	pop    %edi
  802183:	5d                   	pop    %ebp
  802184:	c3                   	ret    
  802185:	8d 76 00             	lea    0x0(%esi),%esi
  802188:	2b 04 24             	sub    (%esp),%eax
  80218b:	19 fa                	sbb    %edi,%edx
  80218d:	89 d1                	mov    %edx,%ecx
  80218f:	89 c6                	mov    %eax,%esi
  802191:	e9 71 ff ff ff       	jmp    802107 <__umoddi3+0xb3>
  802196:	66 90                	xchg   %ax,%ax
  802198:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80219c:	72 ea                	jb     802188 <__umoddi3+0x134>
  80219e:	89 d9                	mov    %ebx,%ecx
  8021a0:	e9 62 ff ff ff       	jmp    802107 <__umoddi3+0xb3>
