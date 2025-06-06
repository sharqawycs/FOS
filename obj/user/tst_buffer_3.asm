
obj/user/tst_buffer_3:     file format elf32-i386


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
  800031:	e8 82 02 00 00       	call   8002b8 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp
//		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
//		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x804000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
//		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
//		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
	}
	int kilo = 1024;
  80003f:	c7 45 ec 00 04 00 00 	movl   $0x400,-0x14(%ebp)
	int Mega = 1024*1024;
  800046:	c7 45 e8 00 00 10 00 	movl   $0x100000,-0x18(%ebp)

	{
		int freeFrames = sys_calculate_free_frames() ;
  80004d:	e8 a2 17 00 00       	call   8017f4 <sys_calculate_free_frames>
  800052:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int origFreeFrames = freeFrames ;
  800055:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800058:	89 45 e0             	mov    %eax,-0x20(%ebp)

		uint32 size = 10*Mega;
  80005b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80005e:	89 d0                	mov    %edx,%eax
  800060:	c1 e0 02             	shl    $0x2,%eax
  800063:	01 d0                	add    %edx,%eax
  800065:	01 c0                	add    %eax,%eax
  800067:	89 45 dc             	mov    %eax,-0x24(%ebp)
		unsigned char *x = malloc(sizeof(unsigned char)*size) ;
  80006a:	83 ec 0c             	sub    $0xc,%esp
  80006d:	ff 75 dc             	pushl  -0x24(%ebp)
  800070:	e8 bd 13 00 00       	call   801432 <malloc>
  800075:	83 c4 10             	add    $0x10,%esp
  800078:	89 45 d8             	mov    %eax,-0x28(%ebp)
		freeFrames = sys_calculate_free_frames() ;
  80007b:	e8 74 17 00 00       	call   8017f4 <sys_calculate_free_frames>
  800080:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int modFrames = sys_calculate_modified_frames();
  800083:	e8 85 17 00 00       	call   80180d <sys_calculate_modified_frames>
  800088:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		cprintf("all frames AFTER malloc = %d\n", freeFrames + modFrames);
  80008b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80008e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800091:	01 d0                	add    %edx,%eax
  800093:	83 ec 08             	sub    $0x8,%esp
  800096:	50                   	push   %eax
  800097:	68 20 1f 80 00       	push   $0x801f20
  80009c:	e8 cd 05 00 00       	call   80066e <cprintf>
  8000a1:	83 c4 10             	add    $0x10,%esp
		x[1]=-1;
  8000a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000a7:	40                   	inc    %eax
  8000a8:	c6 00 ff             	movb   $0xff,(%eax)

		x[1*Mega] = -1;
  8000ab:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8000ae:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000b1:	01 d0                	add    %edx,%eax
  8000b3:	c6 00 ff             	movb   $0xff,(%eax)

		int i = x[2*Mega];
  8000b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000b9:	01 c0                	add    %eax,%eax
  8000bb:	89 c2                	mov    %eax,%edx
  8000bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000c0:	01 d0                	add    %edx,%eax
  8000c2:	8a 00                	mov    (%eax),%al
  8000c4:	0f b6 c0             	movzbl %al,%eax
  8000c7:	89 45 f4             	mov    %eax,-0xc(%ebp)

		int j = x[3*Mega];
  8000ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000cd:	89 c2                	mov    %eax,%edx
  8000cf:	01 d2                	add    %edx,%edx
  8000d1:	01 d0                	add    %edx,%eax
  8000d3:	89 c2                	mov    %eax,%edx
  8000d5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000d8:	01 d0                	add    %edx,%eax
  8000da:	8a 00                	mov    (%eax),%al
  8000dc:	0f b6 c0             	movzbl %al,%eax
  8000df:	89 45 d0             	mov    %eax,-0x30(%ebp)

		x[4*Mega] = -1;
  8000e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e5:	c1 e0 02             	shl    $0x2,%eax
  8000e8:	89 c2                	mov    %eax,%edx
  8000ea:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000ed:	01 d0                	add    %edx,%eax
  8000ef:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega] = -1;
  8000f2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8000f5:	89 d0                	mov    %edx,%eax
  8000f7:	c1 e0 02             	shl    $0x2,%eax
  8000fa:	01 d0                	add    %edx,%eax
  8000fc:	89 c2                	mov    %eax,%edx
  8000fe:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800101:	01 d0                	add    %edx,%eax
  800103:	c6 00 ff             	movb   $0xff,(%eax)

		x[6*Mega] = -1;
  800106:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800109:	89 d0                	mov    %edx,%eax
  80010b:	01 c0                	add    %eax,%eax
  80010d:	01 d0                	add    %edx,%eax
  80010f:	01 c0                	add    %eax,%eax
  800111:	89 c2                	mov    %eax,%edx
  800113:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800116:	01 d0                	add    %edx,%eax
  800118:	c6 00 ff             	movb   $0xff,(%eax)

		x[7*Mega] = -1;
  80011b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80011e:	89 d0                	mov    %edx,%eax
  800120:	01 c0                	add    %eax,%eax
  800122:	01 d0                	add    %edx,%eax
  800124:	01 c0                	add    %eax,%eax
  800126:	01 d0                	add    %edx,%eax
  800128:	89 c2                	mov    %eax,%edx
  80012a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80012d:	01 d0                	add    %edx,%eax
  80012f:	c6 00 ff             	movb   $0xff,(%eax)

		x[8*Mega] = -1;
  800132:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800135:	c1 e0 03             	shl    $0x3,%eax
  800138:	89 c2                	mov    %eax,%edx
  80013a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80013d:	01 d0                	add    %edx,%eax
  80013f:	c6 00 ff             	movb   $0xff,(%eax)

		x[9*Mega] = -1;
  800142:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800145:	89 d0                	mov    %edx,%eax
  800147:	c1 e0 03             	shl    $0x3,%eax
  80014a:	01 d0                	add    %edx,%eax
  80014c:	89 c2                	mov    %eax,%edx
  80014e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800151:	01 d0                	add    %edx,%eax
  800153:	c6 00 ff             	movb   $0xff,(%eax)

		free(x);
  800156:	83 ec 0c             	sub    $0xc,%esp
  800159:	ff 75 d8             	pushl  -0x28(%ebp)
  80015c:	e8 f2 13 00 00       	call   801553 <free>
  800161:	83 c4 10             	add    $0x10,%esp

		int numOFEmptyLocInWS = 0;
  800164:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  80016b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800172:	eb 79                	jmp    8001ed <_main+0x1b5>
		{
			if (myEnv->__uptr_pws[i].empty)
  800174:	a1 20 30 80 00       	mov    0x803020,%eax
  800179:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80017f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800182:	89 d0                	mov    %edx,%eax
  800184:	01 c0                	add    %eax,%eax
  800186:	01 d0                	add    %edx,%eax
  800188:	c1 e0 02             	shl    $0x2,%eax
  80018b:	01 c8                	add    %ecx,%eax
  80018d:	8a 40 04             	mov    0x4(%eax),%al
  800190:	84 c0                	test   %al,%al
  800192:	74 05                	je     800199 <_main+0x161>
			{
				numOFEmptyLocInWS++;
  800194:	ff 45 f0             	incl   -0x10(%ebp)
  800197:	eb 51                	jmp    8001ea <_main+0x1b2>
			}
			else
			{
				uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
  800199:	a1 20 30 80 00       	mov    0x803020,%eax
  80019e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8001a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001a7:	89 d0                	mov    %edx,%eax
  8001a9:	01 c0                	add    %eax,%eax
  8001ab:	01 d0                	add    %edx,%eax
  8001ad:	c1 e0 02             	shl    $0x2,%eax
  8001b0:	01 c8                	add    %ecx,%eax
  8001b2:	8b 00                	mov    (%eax),%eax
  8001b4:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001b7:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001ba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001bf:	89 45 c8             	mov    %eax,-0x38(%ebp)
				if (va >= USER_HEAP_START && va < (USER_HEAP_START + size))
  8001c2:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001c5:	85 c0                	test   %eax,%eax
  8001c7:	79 21                	jns    8001ea <_main+0x1b2>
  8001c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8001cc:	05 00 00 00 80       	add    $0x80000000,%eax
  8001d1:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  8001d4:	76 14                	jbe    8001ea <_main+0x1b2>
					panic("freeMem didn't remove its page(s) from the WS");
  8001d6:	83 ec 04             	sub    $0x4,%esp
  8001d9:	68 40 1f 80 00       	push   $0x801f40
  8001de:	6a 4e                	push   $0x4e
  8001e0:	68 6e 1f 80 00       	push   $0x801f6e
  8001e5:	e8 d0 01 00 00       	call   8003ba <_panic>
		x[9*Mega] = -1;

		free(x);

		int numOFEmptyLocInWS = 0;
		for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  8001ea:	ff 45 f4             	incl   -0xc(%ebp)
  8001ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f2:	8b 50 74             	mov    0x74(%eax),%edx
  8001f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001f8:	39 c2                	cmp    %eax,%edx
  8001fa:	0f 87 74 ff ff ff    	ja     800174 <_main+0x13c>
				uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
				if (va >= USER_HEAP_START && va < (USER_HEAP_START + size))
					panic("freeMem didn't remove its page(s) from the WS");
			}
		}
		int free_frames = sys_calculate_free_frames();
  800200:	e8 ef 15 00 00       	call   8017f4 <sys_calculate_free_frames>
  800205:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		int mod_frames = sys_calculate_modified_frames();
  800208:	e8 00 16 00 00       	call   80180d <sys_calculate_modified_frames>
  80020d:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((sys_calculate_modified_frames() + sys_calculate_free_frames() - numOFEmptyLocInWS) - (modFrames + freeFrames) != 0 ) panic("FreeMem didn't remove all modified frames in the given range from the modified list");
  800210:	e8 f8 15 00 00       	call   80180d <sys_calculate_modified_frames>
  800215:	89 c3                	mov    %eax,%ebx
  800217:	e8 d8 15 00 00       	call   8017f4 <sys_calculate_free_frames>
  80021c:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  80021f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800222:	89 d1                	mov    %edx,%ecx
  800224:	29 c1                	sub    %eax,%ecx
  800226:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800229:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80022c:	01 d0                	add    %edx,%eax
  80022e:	39 c1                	cmp    %eax,%ecx
  800230:	74 14                	je     800246 <_main+0x20e>
  800232:	83 ec 04             	sub    $0x4,%esp
  800235:	68 84 1f 80 00       	push   $0x801f84
  80023a:	6a 53                	push   $0x53
  80023c:	68 6e 1f 80 00       	push   $0x801f6e
  800241:	e8 74 01 00 00       	call   8003ba <_panic>
		//if (sys_calculate_modified_frames() != 0 ) panic("FreeMem didn't remove all modified frames in the given range from the modified list");
		//if (sys_calculate_notmod_frames() != 7) panic("FreeMem didn't remove all un-modified frames in the given range from the free frame list");

		//if (sys_calculate_free_frames() - freeFrames != 3) panic("FreeMem didn't UN-BUFFER the removed BUFFERED frames in the given range.. (check updating of isBuffered");

		cprintf("Congratulations!! test of removing BUFFERED pages in freeHeap is completed successfully.\n");
  800246:	83 ec 0c             	sub    $0xc,%esp
  800249:	68 d8 1f 80 00       	push   $0x801fd8
  80024e:	e8 1b 04 00 00       	call   80066e <cprintf>
  800253:	83 c4 10             	add    $0x10,%esp

		//Try to access any of the removed buffered pages in the Heap [It's ILLEGAL ACCESS now]
		{
			cprintf("\nNow, trying to access the removed BUFFERED pages, you should make the kernel PANIC with ILLEGAL MEMORY ACCESS in page_fault_handler() since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK.\n\n\n");
  800256:	83 ec 0c             	sub    $0xc,%esp
  800259:	68 34 20 80 00       	push   $0x802034
  80025e:	e8 0b 04 00 00       	call   80066e <cprintf>
  800263:	83 c4 10             	add    $0x10,%esp

			x[1]=-1;
  800266:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800269:	40                   	inc    %eax
  80026a:	c6 00 ff             	movb   $0xff,(%eax)

			x[1*Mega] = -1;
  80026d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800270:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800273:	01 d0                	add    %edx,%eax
  800275:	c6 00 ff             	movb   $0xff,(%eax)

			int i = x[2*Mega];
  800278:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80027b:	01 c0                	add    %eax,%eax
  80027d:	89 c2                	mov    %eax,%edx
  80027f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800282:	01 d0                	add    %edx,%eax
  800284:	8a 00                	mov    (%eax),%al
  800286:	0f b6 c0             	movzbl %al,%eax
  800289:	89 45 bc             	mov    %eax,-0x44(%ebp)

			int j = x[3*Mega];
  80028c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80028f:	89 c2                	mov    %eax,%edx
  800291:	01 d2                	add    %edx,%edx
  800293:	01 d0                	add    %edx,%eax
  800295:	89 c2                	mov    %eax,%edx
  800297:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80029a:	01 d0                	add    %edx,%eax
  80029c:	8a 00                	mov    (%eax),%al
  80029e:	0f b6 c0             	movzbl %al,%eax
  8002a1:	89 45 b8             	mov    %eax,-0x48(%ebp)
		}
		panic("ERROR: FOS SHOULD NOT panic here, it should panic earlier in page_fault_handler(), since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK. REMEMBER: creating new page in page file shouldn't be allowed except ONLY for stack pages\n");
  8002a4:	83 ec 04             	sub    $0x4,%esp
  8002a7:	68 18 21 80 00       	push   $0x802118
  8002ac:	6a 68                	push   $0x68
  8002ae:	68 6e 1f 80 00       	push   $0x801f6e
  8002b3:	e8 02 01 00 00       	call   8003ba <_panic>

008002b8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8002b8:	55                   	push   %ebp
  8002b9:	89 e5                	mov    %esp,%ebp
  8002bb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8002be:	e8 66 14 00 00       	call   801729 <sys_getenvindex>
  8002c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8002c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002c9:	89 d0                	mov    %edx,%eax
  8002cb:	01 c0                	add    %eax,%eax
  8002cd:	01 d0                	add    %edx,%eax
  8002cf:	c1 e0 02             	shl    $0x2,%eax
  8002d2:	01 d0                	add    %edx,%eax
  8002d4:	c1 e0 06             	shl    $0x6,%eax
  8002d7:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002dc:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e6:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8002ec:	84 c0                	test   %al,%al
  8002ee:	74 0f                	je     8002ff <libmain+0x47>
		binaryname = myEnv->prog_name;
  8002f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f5:	05 f4 02 00 00       	add    $0x2f4,%eax
  8002fa:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002ff:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800303:	7e 0a                	jle    80030f <libmain+0x57>
		binaryname = argv[0];
  800305:	8b 45 0c             	mov    0xc(%ebp),%eax
  800308:	8b 00                	mov    (%eax),%eax
  80030a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80030f:	83 ec 08             	sub    $0x8,%esp
  800312:	ff 75 0c             	pushl  0xc(%ebp)
  800315:	ff 75 08             	pushl  0x8(%ebp)
  800318:	e8 1b fd ff ff       	call   800038 <_main>
  80031d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800320:	e8 9f 15 00 00       	call   8018c4 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800325:	83 ec 0c             	sub    $0xc,%esp
  800328:	68 38 22 80 00       	push   $0x802238
  80032d:	e8 3c 03 00 00       	call   80066e <cprintf>
  800332:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800335:	a1 20 30 80 00       	mov    0x803020,%eax
  80033a:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800340:	a1 20 30 80 00       	mov    0x803020,%eax
  800345:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80034b:	83 ec 04             	sub    $0x4,%esp
  80034e:	52                   	push   %edx
  80034f:	50                   	push   %eax
  800350:	68 60 22 80 00       	push   $0x802260
  800355:	e8 14 03 00 00       	call   80066e <cprintf>
  80035a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80035d:	a1 20 30 80 00       	mov    0x803020,%eax
  800362:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800368:	83 ec 08             	sub    $0x8,%esp
  80036b:	50                   	push   %eax
  80036c:	68 85 22 80 00       	push   $0x802285
  800371:	e8 f8 02 00 00       	call   80066e <cprintf>
  800376:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800379:	83 ec 0c             	sub    $0xc,%esp
  80037c:	68 38 22 80 00       	push   $0x802238
  800381:	e8 e8 02 00 00       	call   80066e <cprintf>
  800386:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800389:	e8 50 15 00 00       	call   8018de <sys_enable_interrupt>

	// exit gracefully
	exit();
  80038e:	e8 19 00 00 00       	call   8003ac <exit>
}
  800393:	90                   	nop
  800394:	c9                   	leave  
  800395:	c3                   	ret    

00800396 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800396:	55                   	push   %ebp
  800397:	89 e5                	mov    %esp,%ebp
  800399:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80039c:	83 ec 0c             	sub    $0xc,%esp
  80039f:	6a 00                	push   $0x0
  8003a1:	e8 4f 13 00 00       	call   8016f5 <sys_env_destroy>
  8003a6:	83 c4 10             	add    $0x10,%esp
}
  8003a9:	90                   	nop
  8003aa:	c9                   	leave  
  8003ab:	c3                   	ret    

008003ac <exit>:

void
exit(void)
{
  8003ac:	55                   	push   %ebp
  8003ad:	89 e5                	mov    %esp,%ebp
  8003af:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8003b2:	e8 a4 13 00 00       	call   80175b <sys_env_exit>
}
  8003b7:	90                   	nop
  8003b8:	c9                   	leave  
  8003b9:	c3                   	ret    

008003ba <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003ba:	55                   	push   %ebp
  8003bb:	89 e5                	mov    %esp,%ebp
  8003bd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8003c0:	8d 45 10             	lea    0x10(%ebp),%eax
  8003c3:	83 c0 04             	add    $0x4,%eax
  8003c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003c9:	a1 30 30 80 00       	mov    0x803030,%eax
  8003ce:	85 c0                	test   %eax,%eax
  8003d0:	74 16                	je     8003e8 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8003d2:	a1 30 30 80 00       	mov    0x803030,%eax
  8003d7:	83 ec 08             	sub    $0x8,%esp
  8003da:	50                   	push   %eax
  8003db:	68 9c 22 80 00       	push   $0x80229c
  8003e0:	e8 89 02 00 00       	call   80066e <cprintf>
  8003e5:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8003e8:	a1 00 30 80 00       	mov    0x803000,%eax
  8003ed:	ff 75 0c             	pushl  0xc(%ebp)
  8003f0:	ff 75 08             	pushl  0x8(%ebp)
  8003f3:	50                   	push   %eax
  8003f4:	68 a1 22 80 00       	push   $0x8022a1
  8003f9:	e8 70 02 00 00       	call   80066e <cprintf>
  8003fe:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800401:	8b 45 10             	mov    0x10(%ebp),%eax
  800404:	83 ec 08             	sub    $0x8,%esp
  800407:	ff 75 f4             	pushl  -0xc(%ebp)
  80040a:	50                   	push   %eax
  80040b:	e8 f3 01 00 00       	call   800603 <vcprintf>
  800410:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800413:	83 ec 08             	sub    $0x8,%esp
  800416:	6a 00                	push   $0x0
  800418:	68 bd 22 80 00       	push   $0x8022bd
  80041d:	e8 e1 01 00 00       	call   800603 <vcprintf>
  800422:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800425:	e8 82 ff ff ff       	call   8003ac <exit>

	// should not return here
	while (1) ;
  80042a:	eb fe                	jmp    80042a <_panic+0x70>

0080042c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80042c:	55                   	push   %ebp
  80042d:	89 e5                	mov    %esp,%ebp
  80042f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800432:	a1 20 30 80 00       	mov    0x803020,%eax
  800437:	8b 50 74             	mov    0x74(%eax),%edx
  80043a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80043d:	39 c2                	cmp    %eax,%edx
  80043f:	74 14                	je     800455 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800441:	83 ec 04             	sub    $0x4,%esp
  800444:	68 c0 22 80 00       	push   $0x8022c0
  800449:	6a 26                	push   $0x26
  80044b:	68 0c 23 80 00       	push   $0x80230c
  800450:	e8 65 ff ff ff       	call   8003ba <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800455:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80045c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800463:	e9 c2 00 00 00       	jmp    80052a <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800468:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80046b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800472:	8b 45 08             	mov    0x8(%ebp),%eax
  800475:	01 d0                	add    %edx,%eax
  800477:	8b 00                	mov    (%eax),%eax
  800479:	85 c0                	test   %eax,%eax
  80047b:	75 08                	jne    800485 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80047d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800480:	e9 a2 00 00 00       	jmp    800527 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800485:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80048c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800493:	eb 69                	jmp    8004fe <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800495:	a1 20 30 80 00       	mov    0x803020,%eax
  80049a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004a0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004a3:	89 d0                	mov    %edx,%eax
  8004a5:	01 c0                	add    %eax,%eax
  8004a7:	01 d0                	add    %edx,%eax
  8004a9:	c1 e0 02             	shl    $0x2,%eax
  8004ac:	01 c8                	add    %ecx,%eax
  8004ae:	8a 40 04             	mov    0x4(%eax),%al
  8004b1:	84 c0                	test   %al,%al
  8004b3:	75 46                	jne    8004fb <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ba:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004c0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004c3:	89 d0                	mov    %edx,%eax
  8004c5:	01 c0                	add    %eax,%eax
  8004c7:	01 d0                	add    %edx,%eax
  8004c9:	c1 e0 02             	shl    $0x2,%eax
  8004cc:	01 c8                	add    %ecx,%eax
  8004ce:	8b 00                	mov    (%eax),%eax
  8004d0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004d3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004db:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8004dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004e0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ea:	01 c8                	add    %ecx,%eax
  8004ec:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004ee:	39 c2                	cmp    %eax,%edx
  8004f0:	75 09                	jne    8004fb <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8004f2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8004f9:	eb 12                	jmp    80050d <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004fb:	ff 45 e8             	incl   -0x18(%ebp)
  8004fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800503:	8b 50 74             	mov    0x74(%eax),%edx
  800506:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800509:	39 c2                	cmp    %eax,%edx
  80050b:	77 88                	ja     800495 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80050d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800511:	75 14                	jne    800527 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800513:	83 ec 04             	sub    $0x4,%esp
  800516:	68 18 23 80 00       	push   $0x802318
  80051b:	6a 3a                	push   $0x3a
  80051d:	68 0c 23 80 00       	push   $0x80230c
  800522:	e8 93 fe ff ff       	call   8003ba <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800527:	ff 45 f0             	incl   -0x10(%ebp)
  80052a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80052d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800530:	0f 8c 32 ff ff ff    	jl     800468 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800536:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80053d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800544:	eb 26                	jmp    80056c <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800546:	a1 20 30 80 00       	mov    0x803020,%eax
  80054b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800551:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800554:	89 d0                	mov    %edx,%eax
  800556:	01 c0                	add    %eax,%eax
  800558:	01 d0                	add    %edx,%eax
  80055a:	c1 e0 02             	shl    $0x2,%eax
  80055d:	01 c8                	add    %ecx,%eax
  80055f:	8a 40 04             	mov    0x4(%eax),%al
  800562:	3c 01                	cmp    $0x1,%al
  800564:	75 03                	jne    800569 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800566:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800569:	ff 45 e0             	incl   -0x20(%ebp)
  80056c:	a1 20 30 80 00       	mov    0x803020,%eax
  800571:	8b 50 74             	mov    0x74(%eax),%edx
  800574:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800577:	39 c2                	cmp    %eax,%edx
  800579:	77 cb                	ja     800546 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80057b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80057e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800581:	74 14                	je     800597 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800583:	83 ec 04             	sub    $0x4,%esp
  800586:	68 6c 23 80 00       	push   $0x80236c
  80058b:	6a 44                	push   $0x44
  80058d:	68 0c 23 80 00       	push   $0x80230c
  800592:	e8 23 fe ff ff       	call   8003ba <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800597:	90                   	nop
  800598:	c9                   	leave  
  800599:	c3                   	ret    

0080059a <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80059a:	55                   	push   %ebp
  80059b:	89 e5                	mov    %esp,%ebp
  80059d:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005a3:	8b 00                	mov    (%eax),%eax
  8005a5:	8d 48 01             	lea    0x1(%eax),%ecx
  8005a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005ab:	89 0a                	mov    %ecx,(%edx)
  8005ad:	8b 55 08             	mov    0x8(%ebp),%edx
  8005b0:	88 d1                	mov    %dl,%cl
  8005b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005b5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005bc:	8b 00                	mov    (%eax),%eax
  8005be:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005c3:	75 2c                	jne    8005f1 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005c5:	a0 24 30 80 00       	mov    0x803024,%al
  8005ca:	0f b6 c0             	movzbl %al,%eax
  8005cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005d0:	8b 12                	mov    (%edx),%edx
  8005d2:	89 d1                	mov    %edx,%ecx
  8005d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005d7:	83 c2 08             	add    $0x8,%edx
  8005da:	83 ec 04             	sub    $0x4,%esp
  8005dd:	50                   	push   %eax
  8005de:	51                   	push   %ecx
  8005df:	52                   	push   %edx
  8005e0:	e8 ce 10 00 00       	call   8016b3 <sys_cputs>
  8005e5:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005eb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8005f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005f4:	8b 40 04             	mov    0x4(%eax),%eax
  8005f7:	8d 50 01             	lea    0x1(%eax),%edx
  8005fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005fd:	89 50 04             	mov    %edx,0x4(%eax)
}
  800600:	90                   	nop
  800601:	c9                   	leave  
  800602:	c3                   	ret    

00800603 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800603:	55                   	push   %ebp
  800604:	89 e5                	mov    %esp,%ebp
  800606:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80060c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800613:	00 00 00 
	b.cnt = 0;
  800616:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80061d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800620:	ff 75 0c             	pushl  0xc(%ebp)
  800623:	ff 75 08             	pushl  0x8(%ebp)
  800626:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80062c:	50                   	push   %eax
  80062d:	68 9a 05 80 00       	push   $0x80059a
  800632:	e8 11 02 00 00       	call   800848 <vprintfmt>
  800637:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80063a:	a0 24 30 80 00       	mov    0x803024,%al
  80063f:	0f b6 c0             	movzbl %al,%eax
  800642:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800648:	83 ec 04             	sub    $0x4,%esp
  80064b:	50                   	push   %eax
  80064c:	52                   	push   %edx
  80064d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800653:	83 c0 08             	add    $0x8,%eax
  800656:	50                   	push   %eax
  800657:	e8 57 10 00 00       	call   8016b3 <sys_cputs>
  80065c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80065f:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800666:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80066c:	c9                   	leave  
  80066d:	c3                   	ret    

0080066e <cprintf>:

int cprintf(const char *fmt, ...) {
  80066e:	55                   	push   %ebp
  80066f:	89 e5                	mov    %esp,%ebp
  800671:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800674:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80067b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80067e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800681:	8b 45 08             	mov    0x8(%ebp),%eax
  800684:	83 ec 08             	sub    $0x8,%esp
  800687:	ff 75 f4             	pushl  -0xc(%ebp)
  80068a:	50                   	push   %eax
  80068b:	e8 73 ff ff ff       	call   800603 <vcprintf>
  800690:	83 c4 10             	add    $0x10,%esp
  800693:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800696:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800699:	c9                   	leave  
  80069a:	c3                   	ret    

0080069b <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80069b:	55                   	push   %ebp
  80069c:	89 e5                	mov    %esp,%ebp
  80069e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006a1:	e8 1e 12 00 00       	call   8018c4 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006a6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8006af:	83 ec 08             	sub    $0x8,%esp
  8006b2:	ff 75 f4             	pushl  -0xc(%ebp)
  8006b5:	50                   	push   %eax
  8006b6:	e8 48 ff ff ff       	call   800603 <vcprintf>
  8006bb:	83 c4 10             	add    $0x10,%esp
  8006be:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006c1:	e8 18 12 00 00       	call   8018de <sys_enable_interrupt>
	return cnt;
  8006c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006c9:	c9                   	leave  
  8006ca:	c3                   	ret    

008006cb <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006cb:	55                   	push   %ebp
  8006cc:	89 e5                	mov    %esp,%ebp
  8006ce:	53                   	push   %ebx
  8006cf:	83 ec 14             	sub    $0x14,%esp
  8006d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8006d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8006db:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006de:	8b 45 18             	mov    0x18(%ebp),%eax
  8006e1:	ba 00 00 00 00       	mov    $0x0,%edx
  8006e6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006e9:	77 55                	ja     800740 <printnum+0x75>
  8006eb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006ee:	72 05                	jb     8006f5 <printnum+0x2a>
  8006f0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006f3:	77 4b                	ja     800740 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006f5:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006f8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006fb:	8b 45 18             	mov    0x18(%ebp),%eax
  8006fe:	ba 00 00 00 00       	mov    $0x0,%edx
  800703:	52                   	push   %edx
  800704:	50                   	push   %eax
  800705:	ff 75 f4             	pushl  -0xc(%ebp)
  800708:	ff 75 f0             	pushl  -0x10(%ebp)
  80070b:	e8 94 15 00 00       	call   801ca4 <__udivdi3>
  800710:	83 c4 10             	add    $0x10,%esp
  800713:	83 ec 04             	sub    $0x4,%esp
  800716:	ff 75 20             	pushl  0x20(%ebp)
  800719:	53                   	push   %ebx
  80071a:	ff 75 18             	pushl  0x18(%ebp)
  80071d:	52                   	push   %edx
  80071e:	50                   	push   %eax
  80071f:	ff 75 0c             	pushl  0xc(%ebp)
  800722:	ff 75 08             	pushl  0x8(%ebp)
  800725:	e8 a1 ff ff ff       	call   8006cb <printnum>
  80072a:	83 c4 20             	add    $0x20,%esp
  80072d:	eb 1a                	jmp    800749 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80072f:	83 ec 08             	sub    $0x8,%esp
  800732:	ff 75 0c             	pushl  0xc(%ebp)
  800735:	ff 75 20             	pushl  0x20(%ebp)
  800738:	8b 45 08             	mov    0x8(%ebp),%eax
  80073b:	ff d0                	call   *%eax
  80073d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800740:	ff 4d 1c             	decl   0x1c(%ebp)
  800743:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800747:	7f e6                	jg     80072f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800749:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80074c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800751:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800754:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800757:	53                   	push   %ebx
  800758:	51                   	push   %ecx
  800759:	52                   	push   %edx
  80075a:	50                   	push   %eax
  80075b:	e8 54 16 00 00       	call   801db4 <__umoddi3>
  800760:	83 c4 10             	add    $0x10,%esp
  800763:	05 d4 25 80 00       	add    $0x8025d4,%eax
  800768:	8a 00                	mov    (%eax),%al
  80076a:	0f be c0             	movsbl %al,%eax
  80076d:	83 ec 08             	sub    $0x8,%esp
  800770:	ff 75 0c             	pushl  0xc(%ebp)
  800773:	50                   	push   %eax
  800774:	8b 45 08             	mov    0x8(%ebp),%eax
  800777:	ff d0                	call   *%eax
  800779:	83 c4 10             	add    $0x10,%esp
}
  80077c:	90                   	nop
  80077d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800780:	c9                   	leave  
  800781:	c3                   	ret    

00800782 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800782:	55                   	push   %ebp
  800783:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800785:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800789:	7e 1c                	jle    8007a7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80078b:	8b 45 08             	mov    0x8(%ebp),%eax
  80078e:	8b 00                	mov    (%eax),%eax
  800790:	8d 50 08             	lea    0x8(%eax),%edx
  800793:	8b 45 08             	mov    0x8(%ebp),%eax
  800796:	89 10                	mov    %edx,(%eax)
  800798:	8b 45 08             	mov    0x8(%ebp),%eax
  80079b:	8b 00                	mov    (%eax),%eax
  80079d:	83 e8 08             	sub    $0x8,%eax
  8007a0:	8b 50 04             	mov    0x4(%eax),%edx
  8007a3:	8b 00                	mov    (%eax),%eax
  8007a5:	eb 40                	jmp    8007e7 <getuint+0x65>
	else if (lflag)
  8007a7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007ab:	74 1e                	je     8007cb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b0:	8b 00                	mov    (%eax),%eax
  8007b2:	8d 50 04             	lea    0x4(%eax),%edx
  8007b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b8:	89 10                	mov    %edx,(%eax)
  8007ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bd:	8b 00                	mov    (%eax),%eax
  8007bf:	83 e8 04             	sub    $0x4,%eax
  8007c2:	8b 00                	mov    (%eax),%eax
  8007c4:	ba 00 00 00 00       	mov    $0x0,%edx
  8007c9:	eb 1c                	jmp    8007e7 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ce:	8b 00                	mov    (%eax),%eax
  8007d0:	8d 50 04             	lea    0x4(%eax),%edx
  8007d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d6:	89 10                	mov    %edx,(%eax)
  8007d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007db:	8b 00                	mov    (%eax),%eax
  8007dd:	83 e8 04             	sub    $0x4,%eax
  8007e0:	8b 00                	mov    (%eax),%eax
  8007e2:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007e7:	5d                   	pop    %ebp
  8007e8:	c3                   	ret    

008007e9 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007e9:	55                   	push   %ebp
  8007ea:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007ec:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007f0:	7e 1c                	jle    80080e <getint+0x25>
		return va_arg(*ap, long long);
  8007f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f5:	8b 00                	mov    (%eax),%eax
  8007f7:	8d 50 08             	lea    0x8(%eax),%edx
  8007fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fd:	89 10                	mov    %edx,(%eax)
  8007ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800802:	8b 00                	mov    (%eax),%eax
  800804:	83 e8 08             	sub    $0x8,%eax
  800807:	8b 50 04             	mov    0x4(%eax),%edx
  80080a:	8b 00                	mov    (%eax),%eax
  80080c:	eb 38                	jmp    800846 <getint+0x5d>
	else if (lflag)
  80080e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800812:	74 1a                	je     80082e <getint+0x45>
		return va_arg(*ap, long);
  800814:	8b 45 08             	mov    0x8(%ebp),%eax
  800817:	8b 00                	mov    (%eax),%eax
  800819:	8d 50 04             	lea    0x4(%eax),%edx
  80081c:	8b 45 08             	mov    0x8(%ebp),%eax
  80081f:	89 10                	mov    %edx,(%eax)
  800821:	8b 45 08             	mov    0x8(%ebp),%eax
  800824:	8b 00                	mov    (%eax),%eax
  800826:	83 e8 04             	sub    $0x4,%eax
  800829:	8b 00                	mov    (%eax),%eax
  80082b:	99                   	cltd   
  80082c:	eb 18                	jmp    800846 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80082e:	8b 45 08             	mov    0x8(%ebp),%eax
  800831:	8b 00                	mov    (%eax),%eax
  800833:	8d 50 04             	lea    0x4(%eax),%edx
  800836:	8b 45 08             	mov    0x8(%ebp),%eax
  800839:	89 10                	mov    %edx,(%eax)
  80083b:	8b 45 08             	mov    0x8(%ebp),%eax
  80083e:	8b 00                	mov    (%eax),%eax
  800840:	83 e8 04             	sub    $0x4,%eax
  800843:	8b 00                	mov    (%eax),%eax
  800845:	99                   	cltd   
}
  800846:	5d                   	pop    %ebp
  800847:	c3                   	ret    

00800848 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800848:	55                   	push   %ebp
  800849:	89 e5                	mov    %esp,%ebp
  80084b:	56                   	push   %esi
  80084c:	53                   	push   %ebx
  80084d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800850:	eb 17                	jmp    800869 <vprintfmt+0x21>
			if (ch == '\0')
  800852:	85 db                	test   %ebx,%ebx
  800854:	0f 84 af 03 00 00    	je     800c09 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80085a:	83 ec 08             	sub    $0x8,%esp
  80085d:	ff 75 0c             	pushl  0xc(%ebp)
  800860:	53                   	push   %ebx
  800861:	8b 45 08             	mov    0x8(%ebp),%eax
  800864:	ff d0                	call   *%eax
  800866:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800869:	8b 45 10             	mov    0x10(%ebp),%eax
  80086c:	8d 50 01             	lea    0x1(%eax),%edx
  80086f:	89 55 10             	mov    %edx,0x10(%ebp)
  800872:	8a 00                	mov    (%eax),%al
  800874:	0f b6 d8             	movzbl %al,%ebx
  800877:	83 fb 25             	cmp    $0x25,%ebx
  80087a:	75 d6                	jne    800852 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80087c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800880:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800887:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80088e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800895:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80089c:	8b 45 10             	mov    0x10(%ebp),%eax
  80089f:	8d 50 01             	lea    0x1(%eax),%edx
  8008a2:	89 55 10             	mov    %edx,0x10(%ebp)
  8008a5:	8a 00                	mov    (%eax),%al
  8008a7:	0f b6 d8             	movzbl %al,%ebx
  8008aa:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008ad:	83 f8 55             	cmp    $0x55,%eax
  8008b0:	0f 87 2b 03 00 00    	ja     800be1 <vprintfmt+0x399>
  8008b6:	8b 04 85 f8 25 80 00 	mov    0x8025f8(,%eax,4),%eax
  8008bd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008bf:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008c3:	eb d7                	jmp    80089c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008c5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008c9:	eb d1                	jmp    80089c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008cb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008d2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008d5:	89 d0                	mov    %edx,%eax
  8008d7:	c1 e0 02             	shl    $0x2,%eax
  8008da:	01 d0                	add    %edx,%eax
  8008dc:	01 c0                	add    %eax,%eax
  8008de:	01 d8                	add    %ebx,%eax
  8008e0:	83 e8 30             	sub    $0x30,%eax
  8008e3:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e9:	8a 00                	mov    (%eax),%al
  8008eb:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008ee:	83 fb 2f             	cmp    $0x2f,%ebx
  8008f1:	7e 3e                	jle    800931 <vprintfmt+0xe9>
  8008f3:	83 fb 39             	cmp    $0x39,%ebx
  8008f6:	7f 39                	jg     800931 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008f8:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008fb:	eb d5                	jmp    8008d2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008fd:	8b 45 14             	mov    0x14(%ebp),%eax
  800900:	83 c0 04             	add    $0x4,%eax
  800903:	89 45 14             	mov    %eax,0x14(%ebp)
  800906:	8b 45 14             	mov    0x14(%ebp),%eax
  800909:	83 e8 04             	sub    $0x4,%eax
  80090c:	8b 00                	mov    (%eax),%eax
  80090e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800911:	eb 1f                	jmp    800932 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800913:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800917:	79 83                	jns    80089c <vprintfmt+0x54>
				width = 0;
  800919:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800920:	e9 77 ff ff ff       	jmp    80089c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800925:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80092c:	e9 6b ff ff ff       	jmp    80089c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800931:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800932:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800936:	0f 89 60 ff ff ff    	jns    80089c <vprintfmt+0x54>
				width = precision, precision = -1;
  80093c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80093f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800942:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800949:	e9 4e ff ff ff       	jmp    80089c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80094e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800951:	e9 46 ff ff ff       	jmp    80089c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800956:	8b 45 14             	mov    0x14(%ebp),%eax
  800959:	83 c0 04             	add    $0x4,%eax
  80095c:	89 45 14             	mov    %eax,0x14(%ebp)
  80095f:	8b 45 14             	mov    0x14(%ebp),%eax
  800962:	83 e8 04             	sub    $0x4,%eax
  800965:	8b 00                	mov    (%eax),%eax
  800967:	83 ec 08             	sub    $0x8,%esp
  80096a:	ff 75 0c             	pushl  0xc(%ebp)
  80096d:	50                   	push   %eax
  80096e:	8b 45 08             	mov    0x8(%ebp),%eax
  800971:	ff d0                	call   *%eax
  800973:	83 c4 10             	add    $0x10,%esp
			break;
  800976:	e9 89 02 00 00       	jmp    800c04 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80097b:	8b 45 14             	mov    0x14(%ebp),%eax
  80097e:	83 c0 04             	add    $0x4,%eax
  800981:	89 45 14             	mov    %eax,0x14(%ebp)
  800984:	8b 45 14             	mov    0x14(%ebp),%eax
  800987:	83 e8 04             	sub    $0x4,%eax
  80098a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80098c:	85 db                	test   %ebx,%ebx
  80098e:	79 02                	jns    800992 <vprintfmt+0x14a>
				err = -err;
  800990:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800992:	83 fb 64             	cmp    $0x64,%ebx
  800995:	7f 0b                	jg     8009a2 <vprintfmt+0x15a>
  800997:	8b 34 9d 40 24 80 00 	mov    0x802440(,%ebx,4),%esi
  80099e:	85 f6                	test   %esi,%esi
  8009a0:	75 19                	jne    8009bb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009a2:	53                   	push   %ebx
  8009a3:	68 e5 25 80 00       	push   $0x8025e5
  8009a8:	ff 75 0c             	pushl  0xc(%ebp)
  8009ab:	ff 75 08             	pushl  0x8(%ebp)
  8009ae:	e8 5e 02 00 00       	call   800c11 <printfmt>
  8009b3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009b6:	e9 49 02 00 00       	jmp    800c04 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009bb:	56                   	push   %esi
  8009bc:	68 ee 25 80 00       	push   $0x8025ee
  8009c1:	ff 75 0c             	pushl  0xc(%ebp)
  8009c4:	ff 75 08             	pushl  0x8(%ebp)
  8009c7:	e8 45 02 00 00       	call   800c11 <printfmt>
  8009cc:	83 c4 10             	add    $0x10,%esp
			break;
  8009cf:	e9 30 02 00 00       	jmp    800c04 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d7:	83 c0 04             	add    $0x4,%eax
  8009da:	89 45 14             	mov    %eax,0x14(%ebp)
  8009dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e0:	83 e8 04             	sub    $0x4,%eax
  8009e3:	8b 30                	mov    (%eax),%esi
  8009e5:	85 f6                	test   %esi,%esi
  8009e7:	75 05                	jne    8009ee <vprintfmt+0x1a6>
				p = "(null)";
  8009e9:	be f1 25 80 00       	mov    $0x8025f1,%esi
			if (width > 0 && padc != '-')
  8009ee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009f2:	7e 6d                	jle    800a61 <vprintfmt+0x219>
  8009f4:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009f8:	74 67                	je     800a61 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009fd:	83 ec 08             	sub    $0x8,%esp
  800a00:	50                   	push   %eax
  800a01:	56                   	push   %esi
  800a02:	e8 0c 03 00 00       	call   800d13 <strnlen>
  800a07:	83 c4 10             	add    $0x10,%esp
  800a0a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a0d:	eb 16                	jmp    800a25 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a0f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a13:	83 ec 08             	sub    $0x8,%esp
  800a16:	ff 75 0c             	pushl  0xc(%ebp)
  800a19:	50                   	push   %eax
  800a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1d:	ff d0                	call   *%eax
  800a1f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a22:	ff 4d e4             	decl   -0x1c(%ebp)
  800a25:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a29:	7f e4                	jg     800a0f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a2b:	eb 34                	jmp    800a61 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a2d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a31:	74 1c                	je     800a4f <vprintfmt+0x207>
  800a33:	83 fb 1f             	cmp    $0x1f,%ebx
  800a36:	7e 05                	jle    800a3d <vprintfmt+0x1f5>
  800a38:	83 fb 7e             	cmp    $0x7e,%ebx
  800a3b:	7e 12                	jle    800a4f <vprintfmt+0x207>
					putch('?', putdat);
  800a3d:	83 ec 08             	sub    $0x8,%esp
  800a40:	ff 75 0c             	pushl  0xc(%ebp)
  800a43:	6a 3f                	push   $0x3f
  800a45:	8b 45 08             	mov    0x8(%ebp),%eax
  800a48:	ff d0                	call   *%eax
  800a4a:	83 c4 10             	add    $0x10,%esp
  800a4d:	eb 0f                	jmp    800a5e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a4f:	83 ec 08             	sub    $0x8,%esp
  800a52:	ff 75 0c             	pushl  0xc(%ebp)
  800a55:	53                   	push   %ebx
  800a56:	8b 45 08             	mov    0x8(%ebp),%eax
  800a59:	ff d0                	call   *%eax
  800a5b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a5e:	ff 4d e4             	decl   -0x1c(%ebp)
  800a61:	89 f0                	mov    %esi,%eax
  800a63:	8d 70 01             	lea    0x1(%eax),%esi
  800a66:	8a 00                	mov    (%eax),%al
  800a68:	0f be d8             	movsbl %al,%ebx
  800a6b:	85 db                	test   %ebx,%ebx
  800a6d:	74 24                	je     800a93 <vprintfmt+0x24b>
  800a6f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a73:	78 b8                	js     800a2d <vprintfmt+0x1e5>
  800a75:	ff 4d e0             	decl   -0x20(%ebp)
  800a78:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a7c:	79 af                	jns    800a2d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a7e:	eb 13                	jmp    800a93 <vprintfmt+0x24b>
				putch(' ', putdat);
  800a80:	83 ec 08             	sub    $0x8,%esp
  800a83:	ff 75 0c             	pushl  0xc(%ebp)
  800a86:	6a 20                	push   $0x20
  800a88:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8b:	ff d0                	call   *%eax
  800a8d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a90:	ff 4d e4             	decl   -0x1c(%ebp)
  800a93:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a97:	7f e7                	jg     800a80 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a99:	e9 66 01 00 00       	jmp    800c04 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a9e:	83 ec 08             	sub    $0x8,%esp
  800aa1:	ff 75 e8             	pushl  -0x18(%ebp)
  800aa4:	8d 45 14             	lea    0x14(%ebp),%eax
  800aa7:	50                   	push   %eax
  800aa8:	e8 3c fd ff ff       	call   8007e9 <getint>
  800aad:	83 c4 10             	add    $0x10,%esp
  800ab0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ab3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ab6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ab9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800abc:	85 d2                	test   %edx,%edx
  800abe:	79 23                	jns    800ae3 <vprintfmt+0x29b>
				putch('-', putdat);
  800ac0:	83 ec 08             	sub    $0x8,%esp
  800ac3:	ff 75 0c             	pushl  0xc(%ebp)
  800ac6:	6a 2d                	push   $0x2d
  800ac8:	8b 45 08             	mov    0x8(%ebp),%eax
  800acb:	ff d0                	call   *%eax
  800acd:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ad0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ad3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ad6:	f7 d8                	neg    %eax
  800ad8:	83 d2 00             	adc    $0x0,%edx
  800adb:	f7 da                	neg    %edx
  800add:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ae0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ae3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800aea:	e9 bc 00 00 00       	jmp    800bab <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800aef:	83 ec 08             	sub    $0x8,%esp
  800af2:	ff 75 e8             	pushl  -0x18(%ebp)
  800af5:	8d 45 14             	lea    0x14(%ebp),%eax
  800af8:	50                   	push   %eax
  800af9:	e8 84 fc ff ff       	call   800782 <getuint>
  800afe:	83 c4 10             	add    $0x10,%esp
  800b01:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b04:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b07:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b0e:	e9 98 00 00 00       	jmp    800bab <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b13:	83 ec 08             	sub    $0x8,%esp
  800b16:	ff 75 0c             	pushl  0xc(%ebp)
  800b19:	6a 58                	push   $0x58
  800b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1e:	ff d0                	call   *%eax
  800b20:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b23:	83 ec 08             	sub    $0x8,%esp
  800b26:	ff 75 0c             	pushl  0xc(%ebp)
  800b29:	6a 58                	push   $0x58
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	ff d0                	call   *%eax
  800b30:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b33:	83 ec 08             	sub    $0x8,%esp
  800b36:	ff 75 0c             	pushl  0xc(%ebp)
  800b39:	6a 58                	push   $0x58
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	ff d0                	call   *%eax
  800b40:	83 c4 10             	add    $0x10,%esp
			break;
  800b43:	e9 bc 00 00 00       	jmp    800c04 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b48:	83 ec 08             	sub    $0x8,%esp
  800b4b:	ff 75 0c             	pushl  0xc(%ebp)
  800b4e:	6a 30                	push   $0x30
  800b50:	8b 45 08             	mov    0x8(%ebp),%eax
  800b53:	ff d0                	call   *%eax
  800b55:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b58:	83 ec 08             	sub    $0x8,%esp
  800b5b:	ff 75 0c             	pushl  0xc(%ebp)
  800b5e:	6a 78                	push   $0x78
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	ff d0                	call   *%eax
  800b65:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b68:	8b 45 14             	mov    0x14(%ebp),%eax
  800b6b:	83 c0 04             	add    $0x4,%eax
  800b6e:	89 45 14             	mov    %eax,0x14(%ebp)
  800b71:	8b 45 14             	mov    0x14(%ebp),%eax
  800b74:	83 e8 04             	sub    $0x4,%eax
  800b77:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b79:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b7c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b83:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b8a:	eb 1f                	jmp    800bab <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b8c:	83 ec 08             	sub    $0x8,%esp
  800b8f:	ff 75 e8             	pushl  -0x18(%ebp)
  800b92:	8d 45 14             	lea    0x14(%ebp),%eax
  800b95:	50                   	push   %eax
  800b96:	e8 e7 fb ff ff       	call   800782 <getuint>
  800b9b:	83 c4 10             	add    $0x10,%esp
  800b9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ba4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bab:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800baf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bb2:	83 ec 04             	sub    $0x4,%esp
  800bb5:	52                   	push   %edx
  800bb6:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bb9:	50                   	push   %eax
  800bba:	ff 75 f4             	pushl  -0xc(%ebp)
  800bbd:	ff 75 f0             	pushl  -0x10(%ebp)
  800bc0:	ff 75 0c             	pushl  0xc(%ebp)
  800bc3:	ff 75 08             	pushl  0x8(%ebp)
  800bc6:	e8 00 fb ff ff       	call   8006cb <printnum>
  800bcb:	83 c4 20             	add    $0x20,%esp
			break;
  800bce:	eb 34                	jmp    800c04 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bd0:	83 ec 08             	sub    $0x8,%esp
  800bd3:	ff 75 0c             	pushl  0xc(%ebp)
  800bd6:	53                   	push   %ebx
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	ff d0                	call   *%eax
  800bdc:	83 c4 10             	add    $0x10,%esp
			break;
  800bdf:	eb 23                	jmp    800c04 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800be1:	83 ec 08             	sub    $0x8,%esp
  800be4:	ff 75 0c             	pushl  0xc(%ebp)
  800be7:	6a 25                	push   $0x25
  800be9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bec:	ff d0                	call   *%eax
  800bee:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800bf1:	ff 4d 10             	decl   0x10(%ebp)
  800bf4:	eb 03                	jmp    800bf9 <vprintfmt+0x3b1>
  800bf6:	ff 4d 10             	decl   0x10(%ebp)
  800bf9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfc:	48                   	dec    %eax
  800bfd:	8a 00                	mov    (%eax),%al
  800bff:	3c 25                	cmp    $0x25,%al
  800c01:	75 f3                	jne    800bf6 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c03:	90                   	nop
		}
	}
  800c04:	e9 47 fc ff ff       	jmp    800850 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c09:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c0a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c0d:	5b                   	pop    %ebx
  800c0e:	5e                   	pop    %esi
  800c0f:	5d                   	pop    %ebp
  800c10:	c3                   	ret    

00800c11 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c11:	55                   	push   %ebp
  800c12:	89 e5                	mov    %esp,%ebp
  800c14:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c17:	8d 45 10             	lea    0x10(%ebp),%eax
  800c1a:	83 c0 04             	add    $0x4,%eax
  800c1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c20:	8b 45 10             	mov    0x10(%ebp),%eax
  800c23:	ff 75 f4             	pushl  -0xc(%ebp)
  800c26:	50                   	push   %eax
  800c27:	ff 75 0c             	pushl  0xc(%ebp)
  800c2a:	ff 75 08             	pushl  0x8(%ebp)
  800c2d:	e8 16 fc ff ff       	call   800848 <vprintfmt>
  800c32:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c35:	90                   	nop
  800c36:	c9                   	leave  
  800c37:	c3                   	ret    

00800c38 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c38:	55                   	push   %ebp
  800c39:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3e:	8b 40 08             	mov    0x8(%eax),%eax
  800c41:	8d 50 01             	lea    0x1(%eax),%edx
  800c44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c47:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4d:	8b 10                	mov    (%eax),%edx
  800c4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c52:	8b 40 04             	mov    0x4(%eax),%eax
  800c55:	39 c2                	cmp    %eax,%edx
  800c57:	73 12                	jae    800c6b <sprintputch+0x33>
		*b->buf++ = ch;
  800c59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5c:	8b 00                	mov    (%eax),%eax
  800c5e:	8d 48 01             	lea    0x1(%eax),%ecx
  800c61:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c64:	89 0a                	mov    %ecx,(%edx)
  800c66:	8b 55 08             	mov    0x8(%ebp),%edx
  800c69:	88 10                	mov    %dl,(%eax)
}
  800c6b:	90                   	nop
  800c6c:	5d                   	pop    %ebp
  800c6d:	c3                   	ret    

00800c6e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c6e:	55                   	push   %ebp
  800c6f:	89 e5                	mov    %esp,%ebp
  800c71:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c74:	8b 45 08             	mov    0x8(%ebp),%eax
  800c77:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	01 d0                	add    %edx,%eax
  800c85:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c88:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c8f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c93:	74 06                	je     800c9b <vsnprintf+0x2d>
  800c95:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c99:	7f 07                	jg     800ca2 <vsnprintf+0x34>
		return -E_INVAL;
  800c9b:	b8 03 00 00 00       	mov    $0x3,%eax
  800ca0:	eb 20                	jmp    800cc2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ca2:	ff 75 14             	pushl  0x14(%ebp)
  800ca5:	ff 75 10             	pushl  0x10(%ebp)
  800ca8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800cab:	50                   	push   %eax
  800cac:	68 38 0c 80 00       	push   $0x800c38
  800cb1:	e8 92 fb ff ff       	call   800848 <vprintfmt>
  800cb6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cb9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cbc:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800cbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800cc2:	c9                   	leave  
  800cc3:	c3                   	ret    

00800cc4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800cc4:	55                   	push   %ebp
  800cc5:	89 e5                	mov    %esp,%ebp
  800cc7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800cca:	8d 45 10             	lea    0x10(%ebp),%eax
  800ccd:	83 c0 04             	add    $0x4,%eax
  800cd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800cd3:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd6:	ff 75 f4             	pushl  -0xc(%ebp)
  800cd9:	50                   	push   %eax
  800cda:	ff 75 0c             	pushl  0xc(%ebp)
  800cdd:	ff 75 08             	pushl  0x8(%ebp)
  800ce0:	e8 89 ff ff ff       	call   800c6e <vsnprintf>
  800ce5:	83 c4 10             	add    $0x10,%esp
  800ce8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ceb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cee:	c9                   	leave  
  800cef:	c3                   	ret    

00800cf0 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800cf0:	55                   	push   %ebp
  800cf1:	89 e5                	mov    %esp,%ebp
  800cf3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800cf6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cfd:	eb 06                	jmp    800d05 <strlen+0x15>
		n++;
  800cff:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d02:	ff 45 08             	incl   0x8(%ebp)
  800d05:	8b 45 08             	mov    0x8(%ebp),%eax
  800d08:	8a 00                	mov    (%eax),%al
  800d0a:	84 c0                	test   %al,%al
  800d0c:	75 f1                	jne    800cff <strlen+0xf>
		n++;
	return n;
  800d0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d11:	c9                   	leave  
  800d12:	c3                   	ret    

00800d13 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d13:	55                   	push   %ebp
  800d14:	89 e5                	mov    %esp,%ebp
  800d16:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d19:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d20:	eb 09                	jmp    800d2b <strnlen+0x18>
		n++;
  800d22:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d25:	ff 45 08             	incl   0x8(%ebp)
  800d28:	ff 4d 0c             	decl   0xc(%ebp)
  800d2b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d2f:	74 09                	je     800d3a <strnlen+0x27>
  800d31:	8b 45 08             	mov    0x8(%ebp),%eax
  800d34:	8a 00                	mov    (%eax),%al
  800d36:	84 c0                	test   %al,%al
  800d38:	75 e8                	jne    800d22 <strnlen+0xf>
		n++;
	return n;
  800d3a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d3d:	c9                   	leave  
  800d3e:	c3                   	ret    

00800d3f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d3f:	55                   	push   %ebp
  800d40:	89 e5                	mov    %esp,%ebp
  800d42:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d4b:	90                   	nop
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	8d 50 01             	lea    0x1(%eax),%edx
  800d52:	89 55 08             	mov    %edx,0x8(%ebp)
  800d55:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d58:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d5b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d5e:	8a 12                	mov    (%edx),%dl
  800d60:	88 10                	mov    %dl,(%eax)
  800d62:	8a 00                	mov    (%eax),%al
  800d64:	84 c0                	test   %al,%al
  800d66:	75 e4                	jne    800d4c <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d68:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d6b:	c9                   	leave  
  800d6c:	c3                   	ret    

00800d6d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d6d:	55                   	push   %ebp
  800d6e:	89 e5                	mov    %esp,%ebp
  800d70:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
  800d76:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d79:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d80:	eb 1f                	jmp    800da1 <strncpy+0x34>
		*dst++ = *src;
  800d82:	8b 45 08             	mov    0x8(%ebp),%eax
  800d85:	8d 50 01             	lea    0x1(%eax),%edx
  800d88:	89 55 08             	mov    %edx,0x8(%ebp)
  800d8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d8e:	8a 12                	mov    (%edx),%dl
  800d90:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d95:	8a 00                	mov    (%eax),%al
  800d97:	84 c0                	test   %al,%al
  800d99:	74 03                	je     800d9e <strncpy+0x31>
			src++;
  800d9b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d9e:	ff 45 fc             	incl   -0x4(%ebp)
  800da1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800da4:	3b 45 10             	cmp    0x10(%ebp),%eax
  800da7:	72 d9                	jb     800d82 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800da9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dac:	c9                   	leave  
  800dad:	c3                   	ret    

00800dae <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800dae:	55                   	push   %ebp
  800daf:	89 e5                	mov    %esp,%ebp
  800db1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dbe:	74 30                	je     800df0 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800dc0:	eb 16                	jmp    800dd8 <strlcpy+0x2a>
			*dst++ = *src++;
  800dc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc5:	8d 50 01             	lea    0x1(%eax),%edx
  800dc8:	89 55 08             	mov    %edx,0x8(%ebp)
  800dcb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dce:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dd1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800dd4:	8a 12                	mov    (%edx),%dl
  800dd6:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800dd8:	ff 4d 10             	decl   0x10(%ebp)
  800ddb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ddf:	74 09                	je     800dea <strlcpy+0x3c>
  800de1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de4:	8a 00                	mov    (%eax),%al
  800de6:	84 c0                	test   %al,%al
  800de8:	75 d8                	jne    800dc2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800df0:	8b 55 08             	mov    0x8(%ebp),%edx
  800df3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df6:	29 c2                	sub    %eax,%edx
  800df8:	89 d0                	mov    %edx,%eax
}
  800dfa:	c9                   	leave  
  800dfb:	c3                   	ret    

00800dfc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800dfc:	55                   	push   %ebp
  800dfd:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800dff:	eb 06                	jmp    800e07 <strcmp+0xb>
		p++, q++;
  800e01:	ff 45 08             	incl   0x8(%ebp)
  800e04:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0a:	8a 00                	mov    (%eax),%al
  800e0c:	84 c0                	test   %al,%al
  800e0e:	74 0e                	je     800e1e <strcmp+0x22>
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
  800e13:	8a 10                	mov    (%eax),%dl
  800e15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e18:	8a 00                	mov    (%eax),%al
  800e1a:	38 c2                	cmp    %al,%dl
  800e1c:	74 e3                	je     800e01 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e21:	8a 00                	mov    (%eax),%al
  800e23:	0f b6 d0             	movzbl %al,%edx
  800e26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e29:	8a 00                	mov    (%eax),%al
  800e2b:	0f b6 c0             	movzbl %al,%eax
  800e2e:	29 c2                	sub    %eax,%edx
  800e30:	89 d0                	mov    %edx,%eax
}
  800e32:	5d                   	pop    %ebp
  800e33:	c3                   	ret    

00800e34 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e34:	55                   	push   %ebp
  800e35:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e37:	eb 09                	jmp    800e42 <strncmp+0xe>
		n--, p++, q++;
  800e39:	ff 4d 10             	decl   0x10(%ebp)
  800e3c:	ff 45 08             	incl   0x8(%ebp)
  800e3f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e42:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e46:	74 17                	je     800e5f <strncmp+0x2b>
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	8a 00                	mov    (%eax),%al
  800e4d:	84 c0                	test   %al,%al
  800e4f:	74 0e                	je     800e5f <strncmp+0x2b>
  800e51:	8b 45 08             	mov    0x8(%ebp),%eax
  800e54:	8a 10                	mov    (%eax),%dl
  800e56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e59:	8a 00                	mov    (%eax),%al
  800e5b:	38 c2                	cmp    %al,%dl
  800e5d:	74 da                	je     800e39 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e5f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e63:	75 07                	jne    800e6c <strncmp+0x38>
		return 0;
  800e65:	b8 00 00 00 00       	mov    $0x0,%eax
  800e6a:	eb 14                	jmp    800e80 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6f:	8a 00                	mov    (%eax),%al
  800e71:	0f b6 d0             	movzbl %al,%edx
  800e74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e77:	8a 00                	mov    (%eax),%al
  800e79:	0f b6 c0             	movzbl %al,%eax
  800e7c:	29 c2                	sub    %eax,%edx
  800e7e:	89 d0                	mov    %edx,%eax
}
  800e80:	5d                   	pop    %ebp
  800e81:	c3                   	ret    

00800e82 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e82:	55                   	push   %ebp
  800e83:	89 e5                	mov    %esp,%ebp
  800e85:	83 ec 04             	sub    $0x4,%esp
  800e88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e8e:	eb 12                	jmp    800ea2 <strchr+0x20>
		if (*s == c)
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
  800e93:	8a 00                	mov    (%eax),%al
  800e95:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e98:	75 05                	jne    800e9f <strchr+0x1d>
			return (char *) s;
  800e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9d:	eb 11                	jmp    800eb0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e9f:	ff 45 08             	incl   0x8(%ebp)
  800ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea5:	8a 00                	mov    (%eax),%al
  800ea7:	84 c0                	test   %al,%al
  800ea9:	75 e5                	jne    800e90 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800eab:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800eb0:	c9                   	leave  
  800eb1:	c3                   	ret    

00800eb2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800eb2:	55                   	push   %ebp
  800eb3:	89 e5                	mov    %esp,%ebp
  800eb5:	83 ec 04             	sub    $0x4,%esp
  800eb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ebe:	eb 0d                	jmp    800ecd <strfind+0x1b>
		if (*s == c)
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	8a 00                	mov    (%eax),%al
  800ec5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ec8:	74 0e                	je     800ed8 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800eca:	ff 45 08             	incl   0x8(%ebp)
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	8a 00                	mov    (%eax),%al
  800ed2:	84 c0                	test   %al,%al
  800ed4:	75 ea                	jne    800ec0 <strfind+0xe>
  800ed6:	eb 01                	jmp    800ed9 <strfind+0x27>
		if (*s == c)
			break;
  800ed8:	90                   	nop
	return (char *) s;
  800ed9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800edc:	c9                   	leave  
  800edd:	c3                   	ret    

00800ede <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ede:	55                   	push   %ebp
  800edf:	89 e5                	mov    %esp,%ebp
  800ee1:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800eea:	8b 45 10             	mov    0x10(%ebp),%eax
  800eed:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ef0:	eb 0e                	jmp    800f00 <memset+0x22>
		*p++ = c;
  800ef2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef5:	8d 50 01             	lea    0x1(%eax),%edx
  800ef8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800efb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800efe:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f00:	ff 4d f8             	decl   -0x8(%ebp)
  800f03:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f07:	79 e9                	jns    800ef2 <memset+0x14>
		*p++ = c;

	return v;
  800f09:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f0c:	c9                   	leave  
  800f0d:	c3                   	ret    

00800f0e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f0e:	55                   	push   %ebp
  800f0f:	89 e5                	mov    %esp,%ebp
  800f11:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f17:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f20:	eb 16                	jmp    800f38 <memcpy+0x2a>
		*d++ = *s++;
  800f22:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f25:	8d 50 01             	lea    0x1(%eax),%edx
  800f28:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f2b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f2e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f31:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f34:	8a 12                	mov    (%edx),%dl
  800f36:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f38:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f3e:	89 55 10             	mov    %edx,0x10(%ebp)
  800f41:	85 c0                	test   %eax,%eax
  800f43:	75 dd                	jne    800f22 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f48:	c9                   	leave  
  800f49:	c3                   	ret    

00800f4a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f4a:	55                   	push   %ebp
  800f4b:	89 e5                	mov    %esp,%ebp
  800f4d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800f50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f56:	8b 45 08             	mov    0x8(%ebp),%eax
  800f59:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f5f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f62:	73 50                	jae    800fb4 <memmove+0x6a>
  800f64:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f67:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6a:	01 d0                	add    %edx,%eax
  800f6c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f6f:	76 43                	jbe    800fb4 <memmove+0x6a>
		s += n;
  800f71:	8b 45 10             	mov    0x10(%ebp),%eax
  800f74:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f77:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f7d:	eb 10                	jmp    800f8f <memmove+0x45>
			*--d = *--s;
  800f7f:	ff 4d f8             	decl   -0x8(%ebp)
  800f82:	ff 4d fc             	decl   -0x4(%ebp)
  800f85:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f88:	8a 10                	mov    (%eax),%dl
  800f8a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f8d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f92:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f95:	89 55 10             	mov    %edx,0x10(%ebp)
  800f98:	85 c0                	test   %eax,%eax
  800f9a:	75 e3                	jne    800f7f <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f9c:	eb 23                	jmp    800fc1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fa1:	8d 50 01             	lea    0x1(%eax),%edx
  800fa4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fa7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800faa:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fad:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fb0:	8a 12                	mov    (%edx),%dl
  800fb2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fb4:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fba:	89 55 10             	mov    %edx,0x10(%ebp)
  800fbd:	85 c0                	test   %eax,%eax
  800fbf:	75 dd                	jne    800f9e <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fc4:	c9                   	leave  
  800fc5:	c3                   	ret    

00800fc6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fc6:	55                   	push   %ebp
  800fc7:	89 e5                	mov    %esp,%ebp
  800fc9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800fd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800fd8:	eb 2a                	jmp    801004 <memcmp+0x3e>
		if (*s1 != *s2)
  800fda:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fdd:	8a 10                	mov    (%eax),%dl
  800fdf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe2:	8a 00                	mov    (%eax),%al
  800fe4:	38 c2                	cmp    %al,%dl
  800fe6:	74 16                	je     800ffe <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800fe8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800feb:	8a 00                	mov    (%eax),%al
  800fed:	0f b6 d0             	movzbl %al,%edx
  800ff0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff3:	8a 00                	mov    (%eax),%al
  800ff5:	0f b6 c0             	movzbl %al,%eax
  800ff8:	29 c2                	sub    %eax,%edx
  800ffa:	89 d0                	mov    %edx,%eax
  800ffc:	eb 18                	jmp    801016 <memcmp+0x50>
		s1++, s2++;
  800ffe:	ff 45 fc             	incl   -0x4(%ebp)
  801001:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801004:	8b 45 10             	mov    0x10(%ebp),%eax
  801007:	8d 50 ff             	lea    -0x1(%eax),%edx
  80100a:	89 55 10             	mov    %edx,0x10(%ebp)
  80100d:	85 c0                	test   %eax,%eax
  80100f:	75 c9                	jne    800fda <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801011:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801016:	c9                   	leave  
  801017:	c3                   	ret    

00801018 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801018:	55                   	push   %ebp
  801019:	89 e5                	mov    %esp,%ebp
  80101b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80101e:	8b 55 08             	mov    0x8(%ebp),%edx
  801021:	8b 45 10             	mov    0x10(%ebp),%eax
  801024:	01 d0                	add    %edx,%eax
  801026:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801029:	eb 15                	jmp    801040 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80102b:	8b 45 08             	mov    0x8(%ebp),%eax
  80102e:	8a 00                	mov    (%eax),%al
  801030:	0f b6 d0             	movzbl %al,%edx
  801033:	8b 45 0c             	mov    0xc(%ebp),%eax
  801036:	0f b6 c0             	movzbl %al,%eax
  801039:	39 c2                	cmp    %eax,%edx
  80103b:	74 0d                	je     80104a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80103d:	ff 45 08             	incl   0x8(%ebp)
  801040:	8b 45 08             	mov    0x8(%ebp),%eax
  801043:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801046:	72 e3                	jb     80102b <memfind+0x13>
  801048:	eb 01                	jmp    80104b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80104a:	90                   	nop
	return (void *) s;
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80104e:	c9                   	leave  
  80104f:	c3                   	ret    

00801050 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801050:	55                   	push   %ebp
  801051:	89 e5                	mov    %esp,%ebp
  801053:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801056:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80105d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801064:	eb 03                	jmp    801069 <strtol+0x19>
		s++;
  801066:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	8a 00                	mov    (%eax),%al
  80106e:	3c 20                	cmp    $0x20,%al
  801070:	74 f4                	je     801066 <strtol+0x16>
  801072:	8b 45 08             	mov    0x8(%ebp),%eax
  801075:	8a 00                	mov    (%eax),%al
  801077:	3c 09                	cmp    $0x9,%al
  801079:	74 eb                	je     801066 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80107b:	8b 45 08             	mov    0x8(%ebp),%eax
  80107e:	8a 00                	mov    (%eax),%al
  801080:	3c 2b                	cmp    $0x2b,%al
  801082:	75 05                	jne    801089 <strtol+0x39>
		s++;
  801084:	ff 45 08             	incl   0x8(%ebp)
  801087:	eb 13                	jmp    80109c <strtol+0x4c>
	else if (*s == '-')
  801089:	8b 45 08             	mov    0x8(%ebp),%eax
  80108c:	8a 00                	mov    (%eax),%al
  80108e:	3c 2d                	cmp    $0x2d,%al
  801090:	75 0a                	jne    80109c <strtol+0x4c>
		s++, neg = 1;
  801092:	ff 45 08             	incl   0x8(%ebp)
  801095:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80109c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010a0:	74 06                	je     8010a8 <strtol+0x58>
  8010a2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010a6:	75 20                	jne    8010c8 <strtol+0x78>
  8010a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ab:	8a 00                	mov    (%eax),%al
  8010ad:	3c 30                	cmp    $0x30,%al
  8010af:	75 17                	jne    8010c8 <strtol+0x78>
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b4:	40                   	inc    %eax
  8010b5:	8a 00                	mov    (%eax),%al
  8010b7:	3c 78                	cmp    $0x78,%al
  8010b9:	75 0d                	jne    8010c8 <strtol+0x78>
		s += 2, base = 16;
  8010bb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010bf:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010c6:	eb 28                	jmp    8010f0 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010c8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010cc:	75 15                	jne    8010e3 <strtol+0x93>
  8010ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d1:	8a 00                	mov    (%eax),%al
  8010d3:	3c 30                	cmp    $0x30,%al
  8010d5:	75 0c                	jne    8010e3 <strtol+0x93>
		s++, base = 8;
  8010d7:	ff 45 08             	incl   0x8(%ebp)
  8010da:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010e1:	eb 0d                	jmp    8010f0 <strtol+0xa0>
	else if (base == 0)
  8010e3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e7:	75 07                	jne    8010f0 <strtol+0xa0>
		base = 10;
  8010e9:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8010f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f3:	8a 00                	mov    (%eax),%al
  8010f5:	3c 2f                	cmp    $0x2f,%al
  8010f7:	7e 19                	jle    801112 <strtol+0xc2>
  8010f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fc:	8a 00                	mov    (%eax),%al
  8010fe:	3c 39                	cmp    $0x39,%al
  801100:	7f 10                	jg     801112 <strtol+0xc2>
			dig = *s - '0';
  801102:	8b 45 08             	mov    0x8(%ebp),%eax
  801105:	8a 00                	mov    (%eax),%al
  801107:	0f be c0             	movsbl %al,%eax
  80110a:	83 e8 30             	sub    $0x30,%eax
  80110d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801110:	eb 42                	jmp    801154 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801112:	8b 45 08             	mov    0x8(%ebp),%eax
  801115:	8a 00                	mov    (%eax),%al
  801117:	3c 60                	cmp    $0x60,%al
  801119:	7e 19                	jle    801134 <strtol+0xe4>
  80111b:	8b 45 08             	mov    0x8(%ebp),%eax
  80111e:	8a 00                	mov    (%eax),%al
  801120:	3c 7a                	cmp    $0x7a,%al
  801122:	7f 10                	jg     801134 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801124:	8b 45 08             	mov    0x8(%ebp),%eax
  801127:	8a 00                	mov    (%eax),%al
  801129:	0f be c0             	movsbl %al,%eax
  80112c:	83 e8 57             	sub    $0x57,%eax
  80112f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801132:	eb 20                	jmp    801154 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801134:	8b 45 08             	mov    0x8(%ebp),%eax
  801137:	8a 00                	mov    (%eax),%al
  801139:	3c 40                	cmp    $0x40,%al
  80113b:	7e 39                	jle    801176 <strtol+0x126>
  80113d:	8b 45 08             	mov    0x8(%ebp),%eax
  801140:	8a 00                	mov    (%eax),%al
  801142:	3c 5a                	cmp    $0x5a,%al
  801144:	7f 30                	jg     801176 <strtol+0x126>
			dig = *s - 'A' + 10;
  801146:	8b 45 08             	mov    0x8(%ebp),%eax
  801149:	8a 00                	mov    (%eax),%al
  80114b:	0f be c0             	movsbl %al,%eax
  80114e:	83 e8 37             	sub    $0x37,%eax
  801151:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801154:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801157:	3b 45 10             	cmp    0x10(%ebp),%eax
  80115a:	7d 19                	jge    801175 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80115c:	ff 45 08             	incl   0x8(%ebp)
  80115f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801162:	0f af 45 10          	imul   0x10(%ebp),%eax
  801166:	89 c2                	mov    %eax,%edx
  801168:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80116b:	01 d0                	add    %edx,%eax
  80116d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801170:	e9 7b ff ff ff       	jmp    8010f0 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801175:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801176:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80117a:	74 08                	je     801184 <strtol+0x134>
		*endptr = (char *) s;
  80117c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117f:	8b 55 08             	mov    0x8(%ebp),%edx
  801182:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801184:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801188:	74 07                	je     801191 <strtol+0x141>
  80118a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80118d:	f7 d8                	neg    %eax
  80118f:	eb 03                	jmp    801194 <strtol+0x144>
  801191:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801194:	c9                   	leave  
  801195:	c3                   	ret    

00801196 <ltostr>:

void
ltostr(long value, char *str)
{
  801196:	55                   	push   %ebp
  801197:	89 e5                	mov    %esp,%ebp
  801199:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80119c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011a3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011aa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011ae:	79 13                	jns    8011c3 <ltostr+0x2d>
	{
		neg = 1;
  8011b0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ba:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011bd:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011c0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011cb:	99                   	cltd   
  8011cc:	f7 f9                	idiv   %ecx
  8011ce:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011d4:	8d 50 01             	lea    0x1(%eax),%edx
  8011d7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011da:	89 c2                	mov    %eax,%edx
  8011dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011df:	01 d0                	add    %edx,%eax
  8011e1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011e4:	83 c2 30             	add    $0x30,%edx
  8011e7:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8011e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011ec:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011f1:	f7 e9                	imul   %ecx
  8011f3:	c1 fa 02             	sar    $0x2,%edx
  8011f6:	89 c8                	mov    %ecx,%eax
  8011f8:	c1 f8 1f             	sar    $0x1f,%eax
  8011fb:	29 c2                	sub    %eax,%edx
  8011fd:	89 d0                	mov    %edx,%eax
  8011ff:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801202:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801205:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80120a:	f7 e9                	imul   %ecx
  80120c:	c1 fa 02             	sar    $0x2,%edx
  80120f:	89 c8                	mov    %ecx,%eax
  801211:	c1 f8 1f             	sar    $0x1f,%eax
  801214:	29 c2                	sub    %eax,%edx
  801216:	89 d0                	mov    %edx,%eax
  801218:	c1 e0 02             	shl    $0x2,%eax
  80121b:	01 d0                	add    %edx,%eax
  80121d:	01 c0                	add    %eax,%eax
  80121f:	29 c1                	sub    %eax,%ecx
  801221:	89 ca                	mov    %ecx,%edx
  801223:	85 d2                	test   %edx,%edx
  801225:	75 9c                	jne    8011c3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801227:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80122e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801231:	48                   	dec    %eax
  801232:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801235:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801239:	74 3d                	je     801278 <ltostr+0xe2>
		start = 1 ;
  80123b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801242:	eb 34                	jmp    801278 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801244:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801247:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124a:	01 d0                	add    %edx,%eax
  80124c:	8a 00                	mov    (%eax),%al
  80124e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801251:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801254:	8b 45 0c             	mov    0xc(%ebp),%eax
  801257:	01 c2                	add    %eax,%edx
  801259:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80125c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125f:	01 c8                	add    %ecx,%eax
  801261:	8a 00                	mov    (%eax),%al
  801263:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801265:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801268:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126b:	01 c2                	add    %eax,%edx
  80126d:	8a 45 eb             	mov    -0x15(%ebp),%al
  801270:	88 02                	mov    %al,(%edx)
		start++ ;
  801272:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801275:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801278:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80127b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80127e:	7c c4                	jl     801244 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801280:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801283:	8b 45 0c             	mov    0xc(%ebp),%eax
  801286:	01 d0                	add    %edx,%eax
  801288:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80128b:	90                   	nop
  80128c:	c9                   	leave  
  80128d:	c3                   	ret    

0080128e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80128e:	55                   	push   %ebp
  80128f:	89 e5                	mov    %esp,%ebp
  801291:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801294:	ff 75 08             	pushl  0x8(%ebp)
  801297:	e8 54 fa ff ff       	call   800cf0 <strlen>
  80129c:	83 c4 04             	add    $0x4,%esp
  80129f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012a2:	ff 75 0c             	pushl  0xc(%ebp)
  8012a5:	e8 46 fa ff ff       	call   800cf0 <strlen>
  8012aa:	83 c4 04             	add    $0x4,%esp
  8012ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012be:	eb 17                	jmp    8012d7 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012c0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c6:	01 c2                	add    %eax,%edx
  8012c8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ce:	01 c8                	add    %ecx,%eax
  8012d0:	8a 00                	mov    (%eax),%al
  8012d2:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012d4:	ff 45 fc             	incl   -0x4(%ebp)
  8012d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012da:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012dd:	7c e1                	jl     8012c0 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012e6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012ed:	eb 1f                	jmp    80130e <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f2:	8d 50 01             	lea    0x1(%eax),%edx
  8012f5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012f8:	89 c2                	mov    %eax,%edx
  8012fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8012fd:	01 c2                	add    %eax,%edx
  8012ff:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801302:	8b 45 0c             	mov    0xc(%ebp),%eax
  801305:	01 c8                	add    %ecx,%eax
  801307:	8a 00                	mov    (%eax),%al
  801309:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80130b:	ff 45 f8             	incl   -0x8(%ebp)
  80130e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801311:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801314:	7c d9                	jl     8012ef <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801316:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801319:	8b 45 10             	mov    0x10(%ebp),%eax
  80131c:	01 d0                	add    %edx,%eax
  80131e:	c6 00 00             	movb   $0x0,(%eax)
}
  801321:	90                   	nop
  801322:	c9                   	leave  
  801323:	c3                   	ret    

00801324 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801324:	55                   	push   %ebp
  801325:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801327:	8b 45 14             	mov    0x14(%ebp),%eax
  80132a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801330:	8b 45 14             	mov    0x14(%ebp),%eax
  801333:	8b 00                	mov    (%eax),%eax
  801335:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80133c:	8b 45 10             	mov    0x10(%ebp),%eax
  80133f:	01 d0                	add    %edx,%eax
  801341:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801347:	eb 0c                	jmp    801355 <strsplit+0x31>
			*string++ = 0;
  801349:	8b 45 08             	mov    0x8(%ebp),%eax
  80134c:	8d 50 01             	lea    0x1(%eax),%edx
  80134f:	89 55 08             	mov    %edx,0x8(%ebp)
  801352:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801355:	8b 45 08             	mov    0x8(%ebp),%eax
  801358:	8a 00                	mov    (%eax),%al
  80135a:	84 c0                	test   %al,%al
  80135c:	74 18                	je     801376 <strsplit+0x52>
  80135e:	8b 45 08             	mov    0x8(%ebp),%eax
  801361:	8a 00                	mov    (%eax),%al
  801363:	0f be c0             	movsbl %al,%eax
  801366:	50                   	push   %eax
  801367:	ff 75 0c             	pushl  0xc(%ebp)
  80136a:	e8 13 fb ff ff       	call   800e82 <strchr>
  80136f:	83 c4 08             	add    $0x8,%esp
  801372:	85 c0                	test   %eax,%eax
  801374:	75 d3                	jne    801349 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
  801379:	8a 00                	mov    (%eax),%al
  80137b:	84 c0                	test   %al,%al
  80137d:	74 5a                	je     8013d9 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80137f:	8b 45 14             	mov    0x14(%ebp),%eax
  801382:	8b 00                	mov    (%eax),%eax
  801384:	83 f8 0f             	cmp    $0xf,%eax
  801387:	75 07                	jne    801390 <strsplit+0x6c>
		{
			return 0;
  801389:	b8 00 00 00 00       	mov    $0x0,%eax
  80138e:	eb 66                	jmp    8013f6 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801390:	8b 45 14             	mov    0x14(%ebp),%eax
  801393:	8b 00                	mov    (%eax),%eax
  801395:	8d 48 01             	lea    0x1(%eax),%ecx
  801398:	8b 55 14             	mov    0x14(%ebp),%edx
  80139b:	89 0a                	mov    %ecx,(%edx)
  80139d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a7:	01 c2                	add    %eax,%edx
  8013a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ac:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013ae:	eb 03                	jmp    8013b3 <strsplit+0x8f>
			string++;
  8013b0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	8a 00                	mov    (%eax),%al
  8013b8:	84 c0                	test   %al,%al
  8013ba:	74 8b                	je     801347 <strsplit+0x23>
  8013bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bf:	8a 00                	mov    (%eax),%al
  8013c1:	0f be c0             	movsbl %al,%eax
  8013c4:	50                   	push   %eax
  8013c5:	ff 75 0c             	pushl  0xc(%ebp)
  8013c8:	e8 b5 fa ff ff       	call   800e82 <strchr>
  8013cd:	83 c4 08             	add    $0x8,%esp
  8013d0:	85 c0                	test   %eax,%eax
  8013d2:	74 dc                	je     8013b0 <strsplit+0x8c>
			string++;
	}
  8013d4:	e9 6e ff ff ff       	jmp    801347 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013d9:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013da:	8b 45 14             	mov    0x14(%ebp),%eax
  8013dd:	8b 00                	mov    (%eax),%eax
  8013df:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e9:	01 d0                	add    %edx,%eax
  8013eb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013f1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8013f6:	c9                   	leave  
  8013f7:	c3                   	ret    

008013f8 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8013f8:	55                   	push   %ebp
  8013f9:	89 e5                	mov    %esp,%ebp
  8013fb:	83 ec 18             	sub    $0x18,%esp
  8013fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801401:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801404:	83 ec 04             	sub    $0x4,%esp
  801407:	68 50 27 80 00       	push   $0x802750
  80140c:	6a 17                	push   $0x17
  80140e:	68 6f 27 80 00       	push   $0x80276f
  801413:	e8 a2 ef ff ff       	call   8003ba <_panic>

00801418 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
  80141b:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  80141e:	83 ec 04             	sub    $0x4,%esp
  801421:	68 7b 27 80 00       	push   $0x80277b
  801426:	6a 2f                	push   $0x2f
  801428:	68 6f 27 80 00       	push   $0x80276f
  80142d:	e8 88 ef ff ff       	call   8003ba <_panic>

00801432 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801432:	55                   	push   %ebp
  801433:	89 e5                	mov    %esp,%ebp
  801435:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801438:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  80143f:	8b 55 08             	mov    0x8(%ebp),%edx
  801442:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801445:	01 d0                	add    %edx,%eax
  801447:	48                   	dec    %eax
  801448:	89 45 e8             	mov    %eax,-0x18(%ebp)
  80144b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80144e:	ba 00 00 00 00       	mov    $0x0,%edx
  801453:	f7 75 ec             	divl   -0x14(%ebp)
  801456:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801459:	29 d0                	sub    %edx,%eax
  80145b:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	c1 e8 0c             	shr    $0xc,%eax
  801464:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801467:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80146e:	e9 c8 00 00 00       	jmp    80153b <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801473:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80147a:	eb 27                	jmp    8014a3 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  80147c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80147f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801482:	01 c2                	add    %eax,%edx
  801484:	89 d0                	mov    %edx,%eax
  801486:	01 c0                	add    %eax,%eax
  801488:	01 d0                	add    %edx,%eax
  80148a:	c1 e0 02             	shl    $0x2,%eax
  80148d:	05 48 30 80 00       	add    $0x803048,%eax
  801492:	8b 00                	mov    (%eax),%eax
  801494:	85 c0                	test   %eax,%eax
  801496:	74 08                	je     8014a0 <malloc+0x6e>
            	i += j;
  801498:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80149b:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  80149e:	eb 0b                	jmp    8014ab <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8014a0:	ff 45 f0             	incl   -0x10(%ebp)
  8014a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014a6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8014a9:	72 d1                	jb     80147c <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8014ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014ae:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8014b1:	0f 85 81 00 00 00    	jne    801538 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8014b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014ba:	05 00 00 08 00       	add    $0x80000,%eax
  8014bf:	c1 e0 0c             	shl    $0xc,%eax
  8014c2:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8014c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8014cc:	eb 1f                	jmp    8014ed <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8014ce:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8014d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014d4:	01 c2                	add    %eax,%edx
  8014d6:	89 d0                	mov    %edx,%eax
  8014d8:	01 c0                	add    %eax,%eax
  8014da:	01 d0                	add    %edx,%eax
  8014dc:	c1 e0 02             	shl    $0x2,%eax
  8014df:	05 48 30 80 00       	add    $0x803048,%eax
  8014e4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8014ea:	ff 45 f0             	incl   -0x10(%ebp)
  8014ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014f0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8014f3:	72 d9                	jb     8014ce <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  8014f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014f8:	89 d0                	mov    %edx,%eax
  8014fa:	01 c0                	add    %eax,%eax
  8014fc:	01 d0                	add    %edx,%eax
  8014fe:	c1 e0 02             	shl    $0x2,%eax
  801501:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801507:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80150a:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  80150c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80150f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801512:	89 c8                	mov    %ecx,%eax
  801514:	01 c0                	add    %eax,%eax
  801516:	01 c8                	add    %ecx,%eax
  801518:	c1 e0 02             	shl    $0x2,%eax
  80151b:	05 44 30 80 00       	add    $0x803044,%eax
  801520:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801522:	83 ec 08             	sub    $0x8,%esp
  801525:	ff 75 08             	pushl  0x8(%ebp)
  801528:	ff 75 e0             	pushl  -0x20(%ebp)
  80152b:	e8 2b 03 00 00       	call   80185b <sys_allocateMem>
  801530:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801533:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801536:	eb 19                	jmp    801551 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801538:	ff 45 f4             	incl   -0xc(%ebp)
  80153b:	a1 04 30 80 00       	mov    0x803004,%eax
  801540:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801543:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801546:	0f 83 27 ff ff ff    	jae    801473 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  80154c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
  801556:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801559:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80155d:	0f 84 e5 00 00 00    	je     801648 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801563:	8b 45 08             	mov    0x8(%ebp),%eax
  801566:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801569:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80156c:	05 00 00 00 80       	add    $0x80000000,%eax
  801571:	c1 e8 0c             	shr    $0xc,%eax
  801574:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801577:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80157a:	89 d0                	mov    %edx,%eax
  80157c:	01 c0                	add    %eax,%eax
  80157e:	01 d0                	add    %edx,%eax
  801580:	c1 e0 02             	shl    $0x2,%eax
  801583:	05 40 30 80 00       	add    $0x803040,%eax
  801588:	8b 00                	mov    (%eax),%eax
  80158a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80158d:	0f 85 b8 00 00 00    	jne    80164b <free+0xf8>
  801593:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801596:	89 d0                	mov    %edx,%eax
  801598:	01 c0                	add    %eax,%eax
  80159a:	01 d0                	add    %edx,%eax
  80159c:	c1 e0 02             	shl    $0x2,%eax
  80159f:	05 48 30 80 00       	add    $0x803048,%eax
  8015a4:	8b 00                	mov    (%eax),%eax
  8015a6:	85 c0                	test   %eax,%eax
  8015a8:	0f 84 9d 00 00 00    	je     80164b <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8015ae:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8015b1:	89 d0                	mov    %edx,%eax
  8015b3:	01 c0                	add    %eax,%eax
  8015b5:	01 d0                	add    %edx,%eax
  8015b7:	c1 e0 02             	shl    $0x2,%eax
  8015ba:	05 44 30 80 00       	add    $0x803044,%eax
  8015bf:	8b 00                	mov    (%eax),%eax
  8015c1:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  8015c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8015c7:	c1 e0 0c             	shl    $0xc,%eax
  8015ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  8015cd:	83 ec 08             	sub    $0x8,%esp
  8015d0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8015d3:	ff 75 f0             	pushl  -0x10(%ebp)
  8015d6:	e8 64 02 00 00       	call   80183f <sys_freeMem>
  8015db:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8015de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8015e5:	eb 57                	jmp    80163e <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8015e7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8015ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015ed:	01 c2                	add    %eax,%edx
  8015ef:	89 d0                	mov    %edx,%eax
  8015f1:	01 c0                	add    %eax,%eax
  8015f3:	01 d0                	add    %edx,%eax
  8015f5:	c1 e0 02             	shl    $0x2,%eax
  8015f8:	05 48 30 80 00       	add    $0x803048,%eax
  8015fd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801603:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801606:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801609:	01 c2                	add    %eax,%edx
  80160b:	89 d0                	mov    %edx,%eax
  80160d:	01 c0                	add    %eax,%eax
  80160f:	01 d0                	add    %edx,%eax
  801611:	c1 e0 02             	shl    $0x2,%eax
  801614:	05 40 30 80 00       	add    $0x803040,%eax
  801619:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  80161f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801622:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801625:	01 c2                	add    %eax,%edx
  801627:	89 d0                	mov    %edx,%eax
  801629:	01 c0                	add    %eax,%eax
  80162b:	01 d0                	add    %edx,%eax
  80162d:	c1 e0 02             	shl    $0x2,%eax
  801630:	05 44 30 80 00       	add    $0x803044,%eax
  801635:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80163b:	ff 45 f4             	incl   -0xc(%ebp)
  80163e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801641:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801644:	7c a1                	jl     8015e7 <free+0x94>
  801646:	eb 04                	jmp    80164c <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801648:	90                   	nop
  801649:	eb 01                	jmp    80164c <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  80164b:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  80164c:	c9                   	leave  
  80164d:	c3                   	ret    

0080164e <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  80164e:	55                   	push   %ebp
  80164f:	89 e5                	mov    %esp,%ebp
  801651:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801654:	83 ec 04             	sub    $0x4,%esp
  801657:	68 98 27 80 00       	push   $0x802798
  80165c:	68 ae 00 00 00       	push   $0xae
  801661:	68 6f 27 80 00       	push   $0x80276f
  801666:	e8 4f ed ff ff       	call   8003ba <_panic>

0080166b <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80166b:	55                   	push   %ebp
  80166c:	89 e5                	mov    %esp,%ebp
  80166e:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801671:	83 ec 04             	sub    $0x4,%esp
  801674:	68 b8 27 80 00       	push   $0x8027b8
  801679:	68 ca 00 00 00       	push   $0xca
  80167e:	68 6f 27 80 00       	push   $0x80276f
  801683:	e8 32 ed ff ff       	call   8003ba <_panic>

00801688 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801688:	55                   	push   %ebp
  801689:	89 e5                	mov    %esp,%ebp
  80168b:	57                   	push   %edi
  80168c:	56                   	push   %esi
  80168d:	53                   	push   %ebx
  80168e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801691:	8b 45 08             	mov    0x8(%ebp),%eax
  801694:	8b 55 0c             	mov    0xc(%ebp),%edx
  801697:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80169a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80169d:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016a0:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016a3:	cd 30                	int    $0x30
  8016a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016ab:	83 c4 10             	add    $0x10,%esp
  8016ae:	5b                   	pop    %ebx
  8016af:	5e                   	pop    %esi
  8016b0:	5f                   	pop    %edi
  8016b1:	5d                   	pop    %ebp
  8016b2:	c3                   	ret    

008016b3 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8016b3:	55                   	push   %ebp
  8016b4:	89 e5                	mov    %esp,%ebp
  8016b6:	83 ec 04             	sub    $0x4,%esp
  8016b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8016bc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8016bf:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	52                   	push   %edx
  8016cb:	ff 75 0c             	pushl  0xc(%ebp)
  8016ce:	50                   	push   %eax
  8016cf:	6a 00                	push   $0x0
  8016d1:	e8 b2 ff ff ff       	call   801688 <syscall>
  8016d6:	83 c4 18             	add    $0x18,%esp
}
  8016d9:	90                   	nop
  8016da:	c9                   	leave  
  8016db:	c3                   	ret    

008016dc <sys_cgetc>:

int
sys_cgetc(void)
{
  8016dc:	55                   	push   %ebp
  8016dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 01                	push   $0x1
  8016eb:	e8 98 ff ff ff       	call   801688 <syscall>
  8016f0:	83 c4 18             	add    $0x18,%esp
}
  8016f3:	c9                   	leave  
  8016f4:	c3                   	ret    

008016f5 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8016f5:	55                   	push   %ebp
  8016f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8016f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	50                   	push   %eax
  801704:	6a 05                	push   $0x5
  801706:	e8 7d ff ff ff       	call   801688 <syscall>
  80170b:	83 c4 18             	add    $0x18,%esp
}
  80170e:	c9                   	leave  
  80170f:	c3                   	ret    

00801710 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801710:	55                   	push   %ebp
  801711:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 00                	push   $0x0
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	6a 02                	push   $0x2
  80171f:	e8 64 ff ff ff       	call   801688 <syscall>
  801724:	83 c4 18             	add    $0x18,%esp
}
  801727:	c9                   	leave  
  801728:	c3                   	ret    

00801729 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801729:	55                   	push   %ebp
  80172a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 03                	push   $0x3
  801738:	e8 4b ff ff ff       	call   801688 <syscall>
  80173d:	83 c4 18             	add    $0x18,%esp
}
  801740:	c9                   	leave  
  801741:	c3                   	ret    

00801742 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801742:	55                   	push   %ebp
  801743:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 04                	push   $0x4
  801751:	e8 32 ff ff ff       	call   801688 <syscall>
  801756:	83 c4 18             	add    $0x18,%esp
}
  801759:	c9                   	leave  
  80175a:	c3                   	ret    

0080175b <sys_env_exit>:


void sys_env_exit(void)
{
  80175b:	55                   	push   %ebp
  80175c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	6a 06                	push   $0x6
  80176a:	e8 19 ff ff ff       	call   801688 <syscall>
  80176f:	83 c4 18             	add    $0x18,%esp
}
  801772:	90                   	nop
  801773:	c9                   	leave  
  801774:	c3                   	ret    

00801775 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801775:	55                   	push   %ebp
  801776:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801778:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177b:	8b 45 08             	mov    0x8(%ebp),%eax
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	52                   	push   %edx
  801785:	50                   	push   %eax
  801786:	6a 07                	push   $0x7
  801788:	e8 fb fe ff ff       	call   801688 <syscall>
  80178d:	83 c4 18             	add    $0x18,%esp
}
  801790:	c9                   	leave  
  801791:	c3                   	ret    

00801792 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801792:	55                   	push   %ebp
  801793:	89 e5                	mov    %esp,%ebp
  801795:	56                   	push   %esi
  801796:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801797:	8b 75 18             	mov    0x18(%ebp),%esi
  80179a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80179d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a6:	56                   	push   %esi
  8017a7:	53                   	push   %ebx
  8017a8:	51                   	push   %ecx
  8017a9:	52                   	push   %edx
  8017aa:	50                   	push   %eax
  8017ab:	6a 08                	push   $0x8
  8017ad:	e8 d6 fe ff ff       	call   801688 <syscall>
  8017b2:	83 c4 18             	add    $0x18,%esp
}
  8017b5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017b8:	5b                   	pop    %ebx
  8017b9:	5e                   	pop    %esi
  8017ba:	5d                   	pop    %ebp
  8017bb:	c3                   	ret    

008017bc <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8017bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	52                   	push   %edx
  8017cc:	50                   	push   %eax
  8017cd:	6a 09                	push   $0x9
  8017cf:	e8 b4 fe ff ff       	call   801688 <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
}
  8017d7:	c9                   	leave  
  8017d8:	c3                   	ret    

008017d9 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	ff 75 0c             	pushl  0xc(%ebp)
  8017e5:	ff 75 08             	pushl  0x8(%ebp)
  8017e8:	6a 0a                	push   $0xa
  8017ea:	e8 99 fe ff ff       	call   801688 <syscall>
  8017ef:	83 c4 18             	add    $0x18,%esp
}
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 0b                	push   $0xb
  801803:	e8 80 fe ff ff       	call   801688 <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
}
  80180b:	c9                   	leave  
  80180c:	c3                   	ret    

0080180d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 0c                	push   $0xc
  80181c:	e8 67 fe ff ff       	call   801688 <syscall>
  801821:	83 c4 18             	add    $0x18,%esp
}
  801824:	c9                   	leave  
  801825:	c3                   	ret    

00801826 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801826:	55                   	push   %ebp
  801827:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801829:	6a 00                	push   $0x0
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 0d                	push   $0xd
  801835:	e8 4e fe ff ff       	call   801688 <syscall>
  80183a:	83 c4 18             	add    $0x18,%esp
}
  80183d:	c9                   	leave  
  80183e:	c3                   	ret    

0080183f <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80183f:	55                   	push   %ebp
  801840:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	ff 75 0c             	pushl  0xc(%ebp)
  80184b:	ff 75 08             	pushl  0x8(%ebp)
  80184e:	6a 11                	push   $0x11
  801850:	e8 33 fe ff ff       	call   801688 <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
	return;
  801858:	90                   	nop
}
  801859:	c9                   	leave  
  80185a:	c3                   	ret    

0080185b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80185b:	55                   	push   %ebp
  80185c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	ff 75 0c             	pushl  0xc(%ebp)
  801867:	ff 75 08             	pushl  0x8(%ebp)
  80186a:	6a 12                	push   $0x12
  80186c:	e8 17 fe ff ff       	call   801688 <syscall>
  801871:	83 c4 18             	add    $0x18,%esp
	return ;
  801874:	90                   	nop
}
  801875:	c9                   	leave  
  801876:	c3                   	ret    

00801877 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801877:	55                   	push   %ebp
  801878:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	6a 0e                	push   $0xe
  801886:	e8 fd fd ff ff       	call   801688 <syscall>
  80188b:	83 c4 18             	add    $0x18,%esp
}
  80188e:	c9                   	leave  
  80188f:	c3                   	ret    

00801890 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801890:	55                   	push   %ebp
  801891:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	ff 75 08             	pushl  0x8(%ebp)
  80189e:	6a 0f                	push   $0xf
  8018a0:	e8 e3 fd ff ff       	call   801688 <syscall>
  8018a5:	83 c4 18             	add    $0x18,%esp
}
  8018a8:	c9                   	leave  
  8018a9:	c3                   	ret    

008018aa <sys_scarce_memory>:

void sys_scarce_memory()
{
  8018aa:	55                   	push   %ebp
  8018ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 10                	push   $0x10
  8018b9:	e8 ca fd ff ff       	call   801688 <syscall>
  8018be:	83 c4 18             	add    $0x18,%esp
}
  8018c1:	90                   	nop
  8018c2:	c9                   	leave  
  8018c3:	c3                   	ret    

008018c4 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8018c4:	55                   	push   %ebp
  8018c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 14                	push   $0x14
  8018d3:	e8 b0 fd ff ff       	call   801688 <syscall>
  8018d8:	83 c4 18             	add    $0x18,%esp
}
  8018db:	90                   	nop
  8018dc:	c9                   	leave  
  8018dd:	c3                   	ret    

008018de <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8018de:	55                   	push   %ebp
  8018df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 00                	push   $0x0
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 15                	push   $0x15
  8018ed:	e8 96 fd ff ff       	call   801688 <syscall>
  8018f2:	83 c4 18             	add    $0x18,%esp
}
  8018f5:	90                   	nop
  8018f6:	c9                   	leave  
  8018f7:	c3                   	ret    

008018f8 <sys_cputc>:


void
sys_cputc(const char c)
{
  8018f8:	55                   	push   %ebp
  8018f9:	89 e5                	mov    %esp,%ebp
  8018fb:	83 ec 04             	sub    $0x4,%esp
  8018fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801901:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801904:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	50                   	push   %eax
  801911:	6a 16                	push   $0x16
  801913:	e8 70 fd ff ff       	call   801688 <syscall>
  801918:	83 c4 18             	add    $0x18,%esp
}
  80191b:	90                   	nop
  80191c:	c9                   	leave  
  80191d:	c3                   	ret    

0080191e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80191e:	55                   	push   %ebp
  80191f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 17                	push   $0x17
  80192d:	e8 56 fd ff ff       	call   801688 <syscall>
  801932:	83 c4 18             	add    $0x18,%esp
}
  801935:	90                   	nop
  801936:	c9                   	leave  
  801937:	c3                   	ret    

00801938 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801938:	55                   	push   %ebp
  801939:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80193b:	8b 45 08             	mov    0x8(%ebp),%eax
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	ff 75 0c             	pushl  0xc(%ebp)
  801947:	50                   	push   %eax
  801948:	6a 18                	push   $0x18
  80194a:	e8 39 fd ff ff       	call   801688 <syscall>
  80194f:	83 c4 18             	add    $0x18,%esp
}
  801952:	c9                   	leave  
  801953:	c3                   	ret    

00801954 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801954:	55                   	push   %ebp
  801955:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801957:	8b 55 0c             	mov    0xc(%ebp),%edx
  80195a:	8b 45 08             	mov    0x8(%ebp),%eax
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	52                   	push   %edx
  801964:	50                   	push   %eax
  801965:	6a 1b                	push   $0x1b
  801967:	e8 1c fd ff ff       	call   801688 <syscall>
  80196c:	83 c4 18             	add    $0x18,%esp
}
  80196f:	c9                   	leave  
  801970:	c3                   	ret    

00801971 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801971:	55                   	push   %ebp
  801972:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801974:	8b 55 0c             	mov    0xc(%ebp),%edx
  801977:	8b 45 08             	mov    0x8(%ebp),%eax
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	52                   	push   %edx
  801981:	50                   	push   %eax
  801982:	6a 19                	push   $0x19
  801984:	e8 ff fc ff ff       	call   801688 <syscall>
  801989:	83 c4 18             	add    $0x18,%esp
}
  80198c:	90                   	nop
  80198d:	c9                   	leave  
  80198e:	c3                   	ret    

0080198f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80198f:	55                   	push   %ebp
  801990:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801992:	8b 55 0c             	mov    0xc(%ebp),%edx
  801995:	8b 45 08             	mov    0x8(%ebp),%eax
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	52                   	push   %edx
  80199f:	50                   	push   %eax
  8019a0:	6a 1a                	push   $0x1a
  8019a2:	e8 e1 fc ff ff       	call   801688 <syscall>
  8019a7:	83 c4 18             	add    $0x18,%esp
}
  8019aa:	90                   	nop
  8019ab:	c9                   	leave  
  8019ac:	c3                   	ret    

008019ad <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8019ad:	55                   	push   %ebp
  8019ae:	89 e5                	mov    %esp,%ebp
  8019b0:	83 ec 04             	sub    $0x4,%esp
  8019b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8019b6:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8019b9:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8019bc:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8019c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c3:	6a 00                	push   $0x0
  8019c5:	51                   	push   %ecx
  8019c6:	52                   	push   %edx
  8019c7:	ff 75 0c             	pushl  0xc(%ebp)
  8019ca:	50                   	push   %eax
  8019cb:	6a 1c                	push   $0x1c
  8019cd:	e8 b6 fc ff ff       	call   801688 <syscall>
  8019d2:	83 c4 18             	add    $0x18,%esp
}
  8019d5:	c9                   	leave  
  8019d6:	c3                   	ret    

008019d7 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8019d7:	55                   	push   %ebp
  8019d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8019da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	52                   	push   %edx
  8019e7:	50                   	push   %eax
  8019e8:	6a 1d                	push   $0x1d
  8019ea:	e8 99 fc ff ff       	call   801688 <syscall>
  8019ef:	83 c4 18             	add    $0x18,%esp
}
  8019f2:	c9                   	leave  
  8019f3:	c3                   	ret    

008019f4 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8019f4:	55                   	push   %ebp
  8019f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8019f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	51                   	push   %ecx
  801a05:	52                   	push   %edx
  801a06:	50                   	push   %eax
  801a07:	6a 1e                	push   $0x1e
  801a09:	e8 7a fc ff ff       	call   801688 <syscall>
  801a0e:	83 c4 18             	add    $0x18,%esp
}
  801a11:	c9                   	leave  
  801a12:	c3                   	ret    

00801a13 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a13:	55                   	push   %ebp
  801a14:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a16:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a19:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	52                   	push   %edx
  801a23:	50                   	push   %eax
  801a24:	6a 1f                	push   $0x1f
  801a26:	e8 5d fc ff ff       	call   801688 <syscall>
  801a2b:	83 c4 18             	add    $0x18,%esp
}
  801a2e:	c9                   	leave  
  801a2f:	c3                   	ret    

00801a30 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a30:	55                   	push   %ebp
  801a31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a33:	6a 00                	push   $0x0
  801a35:	6a 00                	push   $0x0
  801a37:	6a 00                	push   $0x0
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 20                	push   $0x20
  801a3f:	e8 44 fc ff ff       	call   801688 <syscall>
  801a44:	83 c4 18             	add    $0x18,%esp
}
  801a47:	c9                   	leave  
  801a48:	c3                   	ret    

00801a49 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801a49:	55                   	push   %ebp
  801a4a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 00                	push   $0x0
  801a53:	ff 75 10             	pushl  0x10(%ebp)
  801a56:	ff 75 0c             	pushl  0xc(%ebp)
  801a59:	50                   	push   %eax
  801a5a:	6a 21                	push   $0x21
  801a5c:	e8 27 fc ff ff       	call   801688 <syscall>
  801a61:	83 c4 18             	add    $0x18,%esp
}
  801a64:	c9                   	leave  
  801a65:	c3                   	ret    

00801a66 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801a66:	55                   	push   %ebp
  801a67:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801a69:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6c:	6a 00                	push   $0x0
  801a6e:	6a 00                	push   $0x0
  801a70:	6a 00                	push   $0x0
  801a72:	6a 00                	push   $0x0
  801a74:	50                   	push   %eax
  801a75:	6a 22                	push   $0x22
  801a77:	e8 0c fc ff ff       	call   801688 <syscall>
  801a7c:	83 c4 18             	add    $0x18,%esp
}
  801a7f:	90                   	nop
  801a80:	c9                   	leave  
  801a81:	c3                   	ret    

00801a82 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801a82:	55                   	push   %ebp
  801a83:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801a85:	8b 45 08             	mov    0x8(%ebp),%eax
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 00                	push   $0x0
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	50                   	push   %eax
  801a91:	6a 23                	push   $0x23
  801a93:	e8 f0 fb ff ff       	call   801688 <syscall>
  801a98:	83 c4 18             	add    $0x18,%esp
}
  801a9b:	90                   	nop
  801a9c:	c9                   	leave  
  801a9d:	c3                   	ret    

00801a9e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801a9e:	55                   	push   %ebp
  801a9f:	89 e5                	mov    %esp,%ebp
  801aa1:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801aa4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801aa7:	8d 50 04             	lea    0x4(%eax),%edx
  801aaa:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	52                   	push   %edx
  801ab4:	50                   	push   %eax
  801ab5:	6a 24                	push   $0x24
  801ab7:	e8 cc fb ff ff       	call   801688 <syscall>
  801abc:	83 c4 18             	add    $0x18,%esp
	return result;
  801abf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ac2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ac5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ac8:	89 01                	mov    %eax,(%ecx)
  801aca:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801acd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad0:	c9                   	leave  
  801ad1:	c2 04 00             	ret    $0x4

00801ad4 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ad4:	55                   	push   %ebp
  801ad5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	ff 75 10             	pushl  0x10(%ebp)
  801ade:	ff 75 0c             	pushl  0xc(%ebp)
  801ae1:	ff 75 08             	pushl  0x8(%ebp)
  801ae4:	6a 13                	push   $0x13
  801ae6:	e8 9d fb ff ff       	call   801688 <syscall>
  801aeb:	83 c4 18             	add    $0x18,%esp
	return ;
  801aee:	90                   	nop
}
  801aef:	c9                   	leave  
  801af0:	c3                   	ret    

00801af1 <sys_rcr2>:
uint32 sys_rcr2()
{
  801af1:	55                   	push   %ebp
  801af2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	6a 25                	push   $0x25
  801b00:	e8 83 fb ff ff       	call   801688 <syscall>
  801b05:	83 c4 18             	add    $0x18,%esp
}
  801b08:	c9                   	leave  
  801b09:	c3                   	ret    

00801b0a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b0a:	55                   	push   %ebp
  801b0b:	89 e5                	mov    %esp,%ebp
  801b0d:	83 ec 04             	sub    $0x4,%esp
  801b10:	8b 45 08             	mov    0x8(%ebp),%eax
  801b13:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b16:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	50                   	push   %eax
  801b23:	6a 26                	push   $0x26
  801b25:	e8 5e fb ff ff       	call   801688 <syscall>
  801b2a:	83 c4 18             	add    $0x18,%esp
	return ;
  801b2d:	90                   	nop
}
  801b2e:	c9                   	leave  
  801b2f:	c3                   	ret    

00801b30 <rsttst>:
void rsttst()
{
  801b30:	55                   	push   %ebp
  801b31:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	6a 00                	push   $0x0
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 28                	push   $0x28
  801b3f:	e8 44 fb ff ff       	call   801688 <syscall>
  801b44:	83 c4 18             	add    $0x18,%esp
	return ;
  801b47:	90                   	nop
}
  801b48:	c9                   	leave  
  801b49:	c3                   	ret    

00801b4a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801b4a:	55                   	push   %ebp
  801b4b:	89 e5                	mov    %esp,%ebp
  801b4d:	83 ec 04             	sub    $0x4,%esp
  801b50:	8b 45 14             	mov    0x14(%ebp),%eax
  801b53:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801b56:	8b 55 18             	mov    0x18(%ebp),%edx
  801b59:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b5d:	52                   	push   %edx
  801b5e:	50                   	push   %eax
  801b5f:	ff 75 10             	pushl  0x10(%ebp)
  801b62:	ff 75 0c             	pushl  0xc(%ebp)
  801b65:	ff 75 08             	pushl  0x8(%ebp)
  801b68:	6a 27                	push   $0x27
  801b6a:	e8 19 fb ff ff       	call   801688 <syscall>
  801b6f:	83 c4 18             	add    $0x18,%esp
	return ;
  801b72:	90                   	nop
}
  801b73:	c9                   	leave  
  801b74:	c3                   	ret    

00801b75 <chktst>:
void chktst(uint32 n)
{
  801b75:	55                   	push   %ebp
  801b76:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	ff 75 08             	pushl  0x8(%ebp)
  801b83:	6a 29                	push   $0x29
  801b85:	e8 fe fa ff ff       	call   801688 <syscall>
  801b8a:	83 c4 18             	add    $0x18,%esp
	return ;
  801b8d:	90                   	nop
}
  801b8e:	c9                   	leave  
  801b8f:	c3                   	ret    

00801b90 <inctst>:

void inctst()
{
  801b90:	55                   	push   %ebp
  801b91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 2a                	push   $0x2a
  801b9f:	e8 e4 fa ff ff       	call   801688 <syscall>
  801ba4:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba7:	90                   	nop
}
  801ba8:	c9                   	leave  
  801ba9:	c3                   	ret    

00801baa <gettst>:
uint32 gettst()
{
  801baa:	55                   	push   %ebp
  801bab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 2b                	push   $0x2b
  801bb9:	e8 ca fa ff ff       	call   801688 <syscall>
  801bbe:	83 c4 18             	add    $0x18,%esp
}
  801bc1:	c9                   	leave  
  801bc2:	c3                   	ret    

00801bc3 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801bc3:	55                   	push   %ebp
  801bc4:	89 e5                	mov    %esp,%ebp
  801bc6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 2c                	push   $0x2c
  801bd5:	e8 ae fa ff ff       	call   801688 <syscall>
  801bda:	83 c4 18             	add    $0x18,%esp
  801bdd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801be0:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801be4:	75 07                	jne    801bed <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801be6:	b8 01 00 00 00       	mov    $0x1,%eax
  801beb:	eb 05                	jmp    801bf2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801bed:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bf2:	c9                   	leave  
  801bf3:	c3                   	ret    

00801bf4 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801bf4:	55                   	push   %ebp
  801bf5:	89 e5                	mov    %esp,%ebp
  801bf7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 2c                	push   $0x2c
  801c06:	e8 7d fa ff ff       	call   801688 <syscall>
  801c0b:	83 c4 18             	add    $0x18,%esp
  801c0e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c11:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c15:	75 07                	jne    801c1e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c17:	b8 01 00 00 00       	mov    $0x1,%eax
  801c1c:	eb 05                	jmp    801c23 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c1e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c23:	c9                   	leave  
  801c24:	c3                   	ret    

00801c25 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c25:	55                   	push   %ebp
  801c26:	89 e5                	mov    %esp,%ebp
  801c28:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 2c                	push   $0x2c
  801c37:	e8 4c fa ff ff       	call   801688 <syscall>
  801c3c:	83 c4 18             	add    $0x18,%esp
  801c3f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801c42:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801c46:	75 07                	jne    801c4f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801c48:	b8 01 00 00 00       	mov    $0x1,%eax
  801c4d:	eb 05                	jmp    801c54 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801c4f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c54:	c9                   	leave  
  801c55:	c3                   	ret    

00801c56 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801c56:	55                   	push   %ebp
  801c57:	89 e5                	mov    %esp,%ebp
  801c59:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 00                	push   $0x0
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 2c                	push   $0x2c
  801c68:	e8 1b fa ff ff       	call   801688 <syscall>
  801c6d:	83 c4 18             	add    $0x18,%esp
  801c70:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801c73:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801c77:	75 07                	jne    801c80 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801c79:	b8 01 00 00 00       	mov    $0x1,%eax
  801c7e:	eb 05                	jmp    801c85 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801c80:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c85:	c9                   	leave  
  801c86:	c3                   	ret    

00801c87 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801c87:	55                   	push   %ebp
  801c88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	ff 75 08             	pushl  0x8(%ebp)
  801c95:	6a 2d                	push   $0x2d
  801c97:	e8 ec f9 ff ff       	call   801688 <syscall>
  801c9c:	83 c4 18             	add    $0x18,%esp
	return ;
  801c9f:	90                   	nop
}
  801ca0:	c9                   	leave  
  801ca1:	c3                   	ret    
  801ca2:	66 90                	xchg   %ax,%ax

00801ca4 <__udivdi3>:
  801ca4:	55                   	push   %ebp
  801ca5:	57                   	push   %edi
  801ca6:	56                   	push   %esi
  801ca7:	53                   	push   %ebx
  801ca8:	83 ec 1c             	sub    $0x1c,%esp
  801cab:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801caf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801cb3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cb7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801cbb:	89 ca                	mov    %ecx,%edx
  801cbd:	89 f8                	mov    %edi,%eax
  801cbf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801cc3:	85 f6                	test   %esi,%esi
  801cc5:	75 2d                	jne    801cf4 <__udivdi3+0x50>
  801cc7:	39 cf                	cmp    %ecx,%edi
  801cc9:	77 65                	ja     801d30 <__udivdi3+0x8c>
  801ccb:	89 fd                	mov    %edi,%ebp
  801ccd:	85 ff                	test   %edi,%edi
  801ccf:	75 0b                	jne    801cdc <__udivdi3+0x38>
  801cd1:	b8 01 00 00 00       	mov    $0x1,%eax
  801cd6:	31 d2                	xor    %edx,%edx
  801cd8:	f7 f7                	div    %edi
  801cda:	89 c5                	mov    %eax,%ebp
  801cdc:	31 d2                	xor    %edx,%edx
  801cde:	89 c8                	mov    %ecx,%eax
  801ce0:	f7 f5                	div    %ebp
  801ce2:	89 c1                	mov    %eax,%ecx
  801ce4:	89 d8                	mov    %ebx,%eax
  801ce6:	f7 f5                	div    %ebp
  801ce8:	89 cf                	mov    %ecx,%edi
  801cea:	89 fa                	mov    %edi,%edx
  801cec:	83 c4 1c             	add    $0x1c,%esp
  801cef:	5b                   	pop    %ebx
  801cf0:	5e                   	pop    %esi
  801cf1:	5f                   	pop    %edi
  801cf2:	5d                   	pop    %ebp
  801cf3:	c3                   	ret    
  801cf4:	39 ce                	cmp    %ecx,%esi
  801cf6:	77 28                	ja     801d20 <__udivdi3+0x7c>
  801cf8:	0f bd fe             	bsr    %esi,%edi
  801cfb:	83 f7 1f             	xor    $0x1f,%edi
  801cfe:	75 40                	jne    801d40 <__udivdi3+0x9c>
  801d00:	39 ce                	cmp    %ecx,%esi
  801d02:	72 0a                	jb     801d0e <__udivdi3+0x6a>
  801d04:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d08:	0f 87 9e 00 00 00    	ja     801dac <__udivdi3+0x108>
  801d0e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d13:	89 fa                	mov    %edi,%edx
  801d15:	83 c4 1c             	add    $0x1c,%esp
  801d18:	5b                   	pop    %ebx
  801d19:	5e                   	pop    %esi
  801d1a:	5f                   	pop    %edi
  801d1b:	5d                   	pop    %ebp
  801d1c:	c3                   	ret    
  801d1d:	8d 76 00             	lea    0x0(%esi),%esi
  801d20:	31 ff                	xor    %edi,%edi
  801d22:	31 c0                	xor    %eax,%eax
  801d24:	89 fa                	mov    %edi,%edx
  801d26:	83 c4 1c             	add    $0x1c,%esp
  801d29:	5b                   	pop    %ebx
  801d2a:	5e                   	pop    %esi
  801d2b:	5f                   	pop    %edi
  801d2c:	5d                   	pop    %ebp
  801d2d:	c3                   	ret    
  801d2e:	66 90                	xchg   %ax,%ax
  801d30:	89 d8                	mov    %ebx,%eax
  801d32:	f7 f7                	div    %edi
  801d34:	31 ff                	xor    %edi,%edi
  801d36:	89 fa                	mov    %edi,%edx
  801d38:	83 c4 1c             	add    $0x1c,%esp
  801d3b:	5b                   	pop    %ebx
  801d3c:	5e                   	pop    %esi
  801d3d:	5f                   	pop    %edi
  801d3e:	5d                   	pop    %ebp
  801d3f:	c3                   	ret    
  801d40:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d45:	89 eb                	mov    %ebp,%ebx
  801d47:	29 fb                	sub    %edi,%ebx
  801d49:	89 f9                	mov    %edi,%ecx
  801d4b:	d3 e6                	shl    %cl,%esi
  801d4d:	89 c5                	mov    %eax,%ebp
  801d4f:	88 d9                	mov    %bl,%cl
  801d51:	d3 ed                	shr    %cl,%ebp
  801d53:	89 e9                	mov    %ebp,%ecx
  801d55:	09 f1                	or     %esi,%ecx
  801d57:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d5b:	89 f9                	mov    %edi,%ecx
  801d5d:	d3 e0                	shl    %cl,%eax
  801d5f:	89 c5                	mov    %eax,%ebp
  801d61:	89 d6                	mov    %edx,%esi
  801d63:	88 d9                	mov    %bl,%cl
  801d65:	d3 ee                	shr    %cl,%esi
  801d67:	89 f9                	mov    %edi,%ecx
  801d69:	d3 e2                	shl    %cl,%edx
  801d6b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d6f:	88 d9                	mov    %bl,%cl
  801d71:	d3 e8                	shr    %cl,%eax
  801d73:	09 c2                	or     %eax,%edx
  801d75:	89 d0                	mov    %edx,%eax
  801d77:	89 f2                	mov    %esi,%edx
  801d79:	f7 74 24 0c          	divl   0xc(%esp)
  801d7d:	89 d6                	mov    %edx,%esi
  801d7f:	89 c3                	mov    %eax,%ebx
  801d81:	f7 e5                	mul    %ebp
  801d83:	39 d6                	cmp    %edx,%esi
  801d85:	72 19                	jb     801da0 <__udivdi3+0xfc>
  801d87:	74 0b                	je     801d94 <__udivdi3+0xf0>
  801d89:	89 d8                	mov    %ebx,%eax
  801d8b:	31 ff                	xor    %edi,%edi
  801d8d:	e9 58 ff ff ff       	jmp    801cea <__udivdi3+0x46>
  801d92:	66 90                	xchg   %ax,%ax
  801d94:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d98:	89 f9                	mov    %edi,%ecx
  801d9a:	d3 e2                	shl    %cl,%edx
  801d9c:	39 c2                	cmp    %eax,%edx
  801d9e:	73 e9                	jae    801d89 <__udivdi3+0xe5>
  801da0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801da3:	31 ff                	xor    %edi,%edi
  801da5:	e9 40 ff ff ff       	jmp    801cea <__udivdi3+0x46>
  801daa:	66 90                	xchg   %ax,%ax
  801dac:	31 c0                	xor    %eax,%eax
  801dae:	e9 37 ff ff ff       	jmp    801cea <__udivdi3+0x46>
  801db3:	90                   	nop

00801db4 <__umoddi3>:
  801db4:	55                   	push   %ebp
  801db5:	57                   	push   %edi
  801db6:	56                   	push   %esi
  801db7:	53                   	push   %ebx
  801db8:	83 ec 1c             	sub    $0x1c,%esp
  801dbb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801dbf:	8b 74 24 34          	mov    0x34(%esp),%esi
  801dc3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801dc7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801dcb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801dcf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801dd3:	89 f3                	mov    %esi,%ebx
  801dd5:	89 fa                	mov    %edi,%edx
  801dd7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ddb:	89 34 24             	mov    %esi,(%esp)
  801dde:	85 c0                	test   %eax,%eax
  801de0:	75 1a                	jne    801dfc <__umoddi3+0x48>
  801de2:	39 f7                	cmp    %esi,%edi
  801de4:	0f 86 a2 00 00 00    	jbe    801e8c <__umoddi3+0xd8>
  801dea:	89 c8                	mov    %ecx,%eax
  801dec:	89 f2                	mov    %esi,%edx
  801dee:	f7 f7                	div    %edi
  801df0:	89 d0                	mov    %edx,%eax
  801df2:	31 d2                	xor    %edx,%edx
  801df4:	83 c4 1c             	add    $0x1c,%esp
  801df7:	5b                   	pop    %ebx
  801df8:	5e                   	pop    %esi
  801df9:	5f                   	pop    %edi
  801dfa:	5d                   	pop    %ebp
  801dfb:	c3                   	ret    
  801dfc:	39 f0                	cmp    %esi,%eax
  801dfe:	0f 87 ac 00 00 00    	ja     801eb0 <__umoddi3+0xfc>
  801e04:	0f bd e8             	bsr    %eax,%ebp
  801e07:	83 f5 1f             	xor    $0x1f,%ebp
  801e0a:	0f 84 ac 00 00 00    	je     801ebc <__umoddi3+0x108>
  801e10:	bf 20 00 00 00       	mov    $0x20,%edi
  801e15:	29 ef                	sub    %ebp,%edi
  801e17:	89 fe                	mov    %edi,%esi
  801e19:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e1d:	89 e9                	mov    %ebp,%ecx
  801e1f:	d3 e0                	shl    %cl,%eax
  801e21:	89 d7                	mov    %edx,%edi
  801e23:	89 f1                	mov    %esi,%ecx
  801e25:	d3 ef                	shr    %cl,%edi
  801e27:	09 c7                	or     %eax,%edi
  801e29:	89 e9                	mov    %ebp,%ecx
  801e2b:	d3 e2                	shl    %cl,%edx
  801e2d:	89 14 24             	mov    %edx,(%esp)
  801e30:	89 d8                	mov    %ebx,%eax
  801e32:	d3 e0                	shl    %cl,%eax
  801e34:	89 c2                	mov    %eax,%edx
  801e36:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e3a:	d3 e0                	shl    %cl,%eax
  801e3c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e40:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e44:	89 f1                	mov    %esi,%ecx
  801e46:	d3 e8                	shr    %cl,%eax
  801e48:	09 d0                	or     %edx,%eax
  801e4a:	d3 eb                	shr    %cl,%ebx
  801e4c:	89 da                	mov    %ebx,%edx
  801e4e:	f7 f7                	div    %edi
  801e50:	89 d3                	mov    %edx,%ebx
  801e52:	f7 24 24             	mull   (%esp)
  801e55:	89 c6                	mov    %eax,%esi
  801e57:	89 d1                	mov    %edx,%ecx
  801e59:	39 d3                	cmp    %edx,%ebx
  801e5b:	0f 82 87 00 00 00    	jb     801ee8 <__umoddi3+0x134>
  801e61:	0f 84 91 00 00 00    	je     801ef8 <__umoddi3+0x144>
  801e67:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e6b:	29 f2                	sub    %esi,%edx
  801e6d:	19 cb                	sbb    %ecx,%ebx
  801e6f:	89 d8                	mov    %ebx,%eax
  801e71:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e75:	d3 e0                	shl    %cl,%eax
  801e77:	89 e9                	mov    %ebp,%ecx
  801e79:	d3 ea                	shr    %cl,%edx
  801e7b:	09 d0                	or     %edx,%eax
  801e7d:	89 e9                	mov    %ebp,%ecx
  801e7f:	d3 eb                	shr    %cl,%ebx
  801e81:	89 da                	mov    %ebx,%edx
  801e83:	83 c4 1c             	add    $0x1c,%esp
  801e86:	5b                   	pop    %ebx
  801e87:	5e                   	pop    %esi
  801e88:	5f                   	pop    %edi
  801e89:	5d                   	pop    %ebp
  801e8a:	c3                   	ret    
  801e8b:	90                   	nop
  801e8c:	89 fd                	mov    %edi,%ebp
  801e8e:	85 ff                	test   %edi,%edi
  801e90:	75 0b                	jne    801e9d <__umoddi3+0xe9>
  801e92:	b8 01 00 00 00       	mov    $0x1,%eax
  801e97:	31 d2                	xor    %edx,%edx
  801e99:	f7 f7                	div    %edi
  801e9b:	89 c5                	mov    %eax,%ebp
  801e9d:	89 f0                	mov    %esi,%eax
  801e9f:	31 d2                	xor    %edx,%edx
  801ea1:	f7 f5                	div    %ebp
  801ea3:	89 c8                	mov    %ecx,%eax
  801ea5:	f7 f5                	div    %ebp
  801ea7:	89 d0                	mov    %edx,%eax
  801ea9:	e9 44 ff ff ff       	jmp    801df2 <__umoddi3+0x3e>
  801eae:	66 90                	xchg   %ax,%ax
  801eb0:	89 c8                	mov    %ecx,%eax
  801eb2:	89 f2                	mov    %esi,%edx
  801eb4:	83 c4 1c             	add    $0x1c,%esp
  801eb7:	5b                   	pop    %ebx
  801eb8:	5e                   	pop    %esi
  801eb9:	5f                   	pop    %edi
  801eba:	5d                   	pop    %ebp
  801ebb:	c3                   	ret    
  801ebc:	3b 04 24             	cmp    (%esp),%eax
  801ebf:	72 06                	jb     801ec7 <__umoddi3+0x113>
  801ec1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ec5:	77 0f                	ja     801ed6 <__umoddi3+0x122>
  801ec7:	89 f2                	mov    %esi,%edx
  801ec9:	29 f9                	sub    %edi,%ecx
  801ecb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ecf:	89 14 24             	mov    %edx,(%esp)
  801ed2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ed6:	8b 44 24 04          	mov    0x4(%esp),%eax
  801eda:	8b 14 24             	mov    (%esp),%edx
  801edd:	83 c4 1c             	add    $0x1c,%esp
  801ee0:	5b                   	pop    %ebx
  801ee1:	5e                   	pop    %esi
  801ee2:	5f                   	pop    %edi
  801ee3:	5d                   	pop    %ebp
  801ee4:	c3                   	ret    
  801ee5:	8d 76 00             	lea    0x0(%esi),%esi
  801ee8:	2b 04 24             	sub    (%esp),%eax
  801eeb:	19 fa                	sbb    %edi,%edx
  801eed:	89 d1                	mov    %edx,%ecx
  801eef:	89 c6                	mov    %eax,%esi
  801ef1:	e9 71 ff ff ff       	jmp    801e67 <__umoddi3+0xb3>
  801ef6:	66 90                	xchg   %ax,%ax
  801ef8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801efc:	72 ea                	jb     801ee8 <__umoddi3+0x134>
  801efe:	89 d9                	mov    %ebx,%ecx
  801f00:	e9 62 ff ff ff       	jmp    801e67 <__umoddi3+0xb3>
