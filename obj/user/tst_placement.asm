
obj/user/tst_placement:     file format elf32-i386


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
  800031:	e8 7a 05 00 00       	call   8005b0 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 9c 00 00 01    	sub    $0x100009c,%esp

	char arr[PAGE_SIZE*1024*4];

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800044:	a1 04 30 80 00       	mov    0x803004,%eax
  800049:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80004f:	8b 00                	mov    (%eax),%eax
  800051:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800054:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800057:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80005c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800061:	74 14                	je     800077 <_main+0x3f>
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	68 80 1f 80 00       	push   $0x801f80
  80006b:	6a 10                	push   $0x10
  80006d:	68 c1 1f 80 00       	push   $0x801fc1
  800072:	e8 3b 06 00 00       	call   8006b2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800077:	a1 04 30 80 00       	mov    0x803004,%eax
  80007c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800082:	83 c0 0c             	add    $0xc,%eax
  800085:	8b 00                	mov    (%eax),%eax
  800087:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80008a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80008d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800092:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800097:	74 14                	je     8000ad <_main+0x75>
  800099:	83 ec 04             	sub    $0x4,%esp
  80009c:	68 80 1f 80 00       	push   $0x801f80
  8000a1:	6a 11                	push   $0x11
  8000a3:	68 c1 1f 80 00       	push   $0x801fc1
  8000a8:	e8 05 06 00 00       	call   8006b2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000ad:	a1 04 30 80 00       	mov    0x803004,%eax
  8000b2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b8:	83 c0 18             	add    $0x18,%eax
  8000bb:	8b 00                	mov    (%eax),%eax
  8000bd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c8:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000cd:	74 14                	je     8000e3 <_main+0xab>
  8000cf:	83 ec 04             	sub    $0x4,%esp
  8000d2:	68 80 1f 80 00       	push   $0x801f80
  8000d7:	6a 12                	push   $0x12
  8000d9:	68 c1 1f 80 00       	push   $0x801fc1
  8000de:	e8 cf 05 00 00       	call   8006b2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e3:	a1 04 30 80 00       	mov    0x803004,%eax
  8000e8:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000ee:	83 c0 24             	add    $0x24,%eax
  8000f1:	8b 00                	mov    (%eax),%eax
  8000f3:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000f6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fe:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 80 1f 80 00       	push   $0x801f80
  80010d:	6a 13                	push   $0x13
  80010f:	68 c1 1f 80 00       	push   $0x801fc1
  800114:	e8 99 05 00 00       	call   8006b2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800119:	a1 04 30 80 00       	mov    0x803004,%eax
  80011e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800124:	83 c0 30             	add    $0x30,%eax
  800127:	8b 00                	mov    (%eax),%eax
  800129:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80012c:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80012f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800134:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800139:	74 14                	je     80014f <_main+0x117>
  80013b:	83 ec 04             	sub    $0x4,%esp
  80013e:	68 80 1f 80 00       	push   $0x801f80
  800143:	6a 14                	push   $0x14
  800145:	68 c1 1f 80 00       	push   $0x801fc1
  80014a:	e8 63 05 00 00       	call   8006b2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014f:	a1 04 30 80 00       	mov    0x803004,%eax
  800154:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80015a:	83 c0 3c             	add    $0x3c,%eax
  80015d:	8b 00                	mov    (%eax),%eax
  80015f:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800162:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800165:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80016a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016f:	74 14                	je     800185 <_main+0x14d>
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 80 1f 80 00       	push   $0x801f80
  800179:	6a 15                	push   $0x15
  80017b:	68 c1 1f 80 00       	push   $0x801fc1
  800180:	e8 2d 05 00 00       	call   8006b2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x206000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800185:	a1 04 30 80 00       	mov    0x803004,%eax
  80018a:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800190:	83 c0 48             	add    $0x48,%eax
  800193:	8b 00                	mov    (%eax),%eax
  800195:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800198:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80019b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001a0:	3d 00 60 20 00       	cmp    $0x206000,%eax
  8001a5:	74 14                	je     8001bb <_main+0x183>
  8001a7:	83 ec 04             	sub    $0x4,%esp
  8001aa:	68 80 1f 80 00       	push   $0x801f80
  8001af:	6a 16                	push   $0x16
  8001b1:	68 c1 1f 80 00       	push   $0x801fc1
  8001b6:	e8 f7 04 00 00       	call   8006b2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001bb:	a1 04 30 80 00       	mov    0x803004,%eax
  8001c0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c6:	83 c0 54             	add    $0x54,%eax
  8001c9:	8b 00                	mov    (%eax),%eax
  8001cb:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001ce:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001d1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d6:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001db:	74 14                	je     8001f1 <_main+0x1b9>
  8001dd:	83 ec 04             	sub    $0x4,%esp
  8001e0:	68 80 1f 80 00       	push   $0x801f80
  8001e5:	6a 17                	push   $0x17
  8001e7:	68 c1 1f 80 00       	push   $0x801fc1
  8001ec:	e8 c1 04 00 00       	call   8006b2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f1:	a1 04 30 80 00       	mov    0x803004,%eax
  8001f6:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001fc:	83 c0 60             	add    $0x60,%eax
  8001ff:	8b 00                	mov    (%eax),%eax
  800201:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800204:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800207:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020c:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800211:	74 14                	je     800227 <_main+0x1ef>
  800213:	83 ec 04             	sub    $0x4,%esp
  800216:	68 80 1f 80 00       	push   $0x801f80
  80021b:	6a 18                	push   $0x18
  80021d:	68 c1 1f 80 00       	push   $0x801fc1
  800222:	e8 8b 04 00 00       	call   8006b2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800227:	a1 04 30 80 00       	mov    0x803004,%eax
  80022c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800232:	83 c0 6c             	add    $0x6c,%eax
  800235:	8b 00                	mov    (%eax),%eax
  800237:	89 45 b8             	mov    %eax,-0x48(%ebp)
  80023a:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80023d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800242:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800247:	74 14                	je     80025d <_main+0x225>
  800249:	83 ec 04             	sub    $0x4,%esp
  80024c:	68 80 1f 80 00       	push   $0x801f80
  800251:	6a 19                	push   $0x19
  800253:	68 c1 1f 80 00       	push   $0x801fc1
  800258:	e8 55 04 00 00       	call   8006b2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025d:	a1 04 30 80 00       	mov    0x803004,%eax
  800262:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800268:	83 c0 78             	add    $0x78,%eax
  80026b:	8b 00                	mov    (%eax),%eax
  80026d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800270:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800273:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800278:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80027d:	74 14                	je     800293 <_main+0x25b>
  80027f:	83 ec 04             	sub    $0x4,%esp
  800282:	68 80 1f 80 00       	push   $0x801f80
  800287:	6a 1a                	push   $0x1a
  800289:	68 c1 1f 80 00       	push   $0x801fc1
  80028e:	e8 1f 04 00 00       	call   8006b2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800293:	a1 04 30 80 00       	mov    0x803004,%eax
  800298:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80029e:	05 84 00 00 00       	add    $0x84,%eax
  8002a3:	8b 00                	mov    (%eax),%eax
  8002a5:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8002a8:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002b0:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8002b5:	74 14                	je     8002cb <_main+0x293>
  8002b7:	83 ec 04             	sub    $0x4,%esp
  8002ba:	68 80 1f 80 00       	push   $0x801f80
  8002bf:	6a 1b                	push   $0x1b
  8002c1:	68 c1 1f 80 00       	push   $0x801fc1
  8002c6:	e8 e7 03 00 00       	call   8006b2 <_panic>

		for (int k = 12; k < 20; k++)
  8002cb:	c7 45 e4 0c 00 00 00 	movl   $0xc,-0x1c(%ebp)
  8002d2:	eb 37                	jmp    80030b <_main+0x2d3>
			if( myEnv->__uptr_pws[k].empty !=  1)
  8002d4:	a1 04 30 80 00       	mov    0x803004,%eax
  8002d9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8002df:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002e2:	89 d0                	mov    %edx,%eax
  8002e4:	01 c0                	add    %eax,%eax
  8002e6:	01 d0                	add    %edx,%eax
  8002e8:	c1 e0 02             	shl    $0x2,%eax
  8002eb:	01 c8                	add    %ecx,%eax
  8002ed:	8a 40 04             	mov    0x4(%eax),%al
  8002f0:	3c 01                	cmp    $0x1,%al
  8002f2:	74 14                	je     800308 <_main+0x2d0>
				panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002f4:	83 ec 04             	sub    $0x4,%esp
  8002f7:	68 80 1f 80 00       	push   $0x801f80
  8002fc:	6a 1f                	push   $0x1f
  8002fe:	68 c1 1f 80 00       	push   $0x801fc1
  800303:	e8 aa 03 00 00       	call   8006b2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");

		for (int k = 12; k < 20; k++)
  800308:	ff 45 e4             	incl   -0x1c(%ebp)
  80030b:	83 7d e4 13          	cmpl   $0x13,-0x1c(%ebp)
  80030f:	7e c3                	jle    8002d4 <_main+0x29c>
		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if( myEnv->page_last_WS_index !=  12)  											panic("INITIAL PAGE last index checking failed! Review size of the WS..!!");
		/*====================================*/
	}

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800311:	e8 c9 15 00 00       	call   8018df <sys_pf_calculate_allocated_pages>
  800316:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int freePages = sys_calculate_free_frames();
  800319:	e8 3e 15 00 00       	call   80185c <sys_calculate_free_frames>
  80031e:	89 45 a8             	mov    %eax,-0x58(%ebp)

	int i=0;
  800321:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(;i<=PAGE_SIZE;i++)
  800328:	eb 11                	jmp    80033b <_main+0x303>
	{
		arr[i] = -1;
  80032a:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  800330:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800333:	01 d0                	add    %edx,%eax
  800335:	c6 00 ff             	movb   $0xff,(%eax)

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
	int freePages = sys_calculate_free_frames();

	int i=0;
	for(;i<=PAGE_SIZE;i++)
  800338:	ff 45 e0             	incl   -0x20(%ebp)
  80033b:	81 7d e0 00 10 00 00 	cmpl   $0x1000,-0x20(%ebp)
  800342:	7e e6                	jle    80032a <_main+0x2f2>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
  800344:	c7 45 e0 00 00 40 00 	movl   $0x400000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  80034b:	eb 11                	jmp    80035e <_main+0x326>
	{
		arr[i] = -1;
  80034d:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  800353:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800356:	01 d0                	add    %edx,%eax
  800358:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  80035b:	ff 45 e0             	incl   -0x20(%ebp)
  80035e:	81 7d e0 00 10 40 00 	cmpl   $0x401000,-0x20(%ebp)
  800365:	7e e6                	jle    80034d <_main+0x315>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
  800367:	c7 45 e0 00 00 80 00 	movl   $0x800000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  80036e:	eb 11                	jmp    800381 <_main+0x349>
	{
		arr[i] = -1;
  800370:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  800376:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800379:	01 d0                	add    %edx,%eax
  80037b:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  80037e:	ff 45 e0             	incl   -0x20(%ebp)
  800381:	81 7d e0 00 10 80 00 	cmpl   $0x801000,-0x20(%ebp)
  800388:	7e e6                	jle    800370 <_main+0x338>
		arr[i] = -1;
	}



	cprintf("STEP A: checking PLACEMENT fault handling ... \n");
  80038a:	83 ec 0c             	sub    $0xc,%esp
  80038d:	68 d8 1f 80 00       	push   $0x801fd8
  800392:	e8 cf 05 00 00       	call   800966 <cprintf>
  800397:	83 c4 10             	add    $0x10,%esp
	{
		if( arr[0] !=  -1)  panic("PLACEMENT of stack page failed");
  80039a:	8a 85 a8 ff ff fe    	mov    -0x1000058(%ebp),%al
  8003a0:	3c ff                	cmp    $0xff,%al
  8003a2:	74 14                	je     8003b8 <_main+0x380>
  8003a4:	83 ec 04             	sub    $0x4,%esp
  8003a7:	68 08 20 80 00       	push   $0x802008
  8003ac:	6a 3f                	push   $0x3f
  8003ae:	68 c1 1f 80 00       	push   $0x801fc1
  8003b3:	e8 fa 02 00 00       	call   8006b2 <_panic>
		if( arr[PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  8003b8:	8a 85 a8 0f 00 ff    	mov    -0xfff058(%ebp),%al
  8003be:	3c ff                	cmp    $0xff,%al
  8003c0:	74 14                	je     8003d6 <_main+0x39e>
  8003c2:	83 ec 04             	sub    $0x4,%esp
  8003c5:	68 08 20 80 00       	push   $0x802008
  8003ca:	6a 40                	push   $0x40
  8003cc:	68 c1 1f 80 00       	push   $0x801fc1
  8003d1:	e8 dc 02 00 00       	call   8006b2 <_panic>

		if( arr[PAGE_SIZE*1024] !=  -1)  panic("PLACEMENT of stack page failed");
  8003d6:	8a 85 a8 ff 3f ff    	mov    -0xc00058(%ebp),%al
  8003dc:	3c ff                	cmp    $0xff,%al
  8003de:	74 14                	je     8003f4 <_main+0x3bc>
  8003e0:	83 ec 04             	sub    $0x4,%esp
  8003e3:	68 08 20 80 00       	push   $0x802008
  8003e8:	6a 42                	push   $0x42
  8003ea:	68 c1 1f 80 00       	push   $0x801fc1
  8003ef:	e8 be 02 00 00       	call   8006b2 <_panic>
		if( arr[PAGE_SIZE*1025] !=  -1)  panic("PLACEMENT of stack page failed");
  8003f4:	8a 85 a8 0f 40 ff    	mov    -0xbff058(%ebp),%al
  8003fa:	3c ff                	cmp    $0xff,%al
  8003fc:	74 14                	je     800412 <_main+0x3da>
  8003fe:	83 ec 04             	sub    $0x4,%esp
  800401:	68 08 20 80 00       	push   $0x802008
  800406:	6a 43                	push   $0x43
  800408:	68 c1 1f 80 00       	push   $0x801fc1
  80040d:	e8 a0 02 00 00       	call   8006b2 <_panic>

		if( arr[PAGE_SIZE*1024*2] !=  -1)  panic("PLACEMENT of stack page failed");
  800412:	8a 85 a8 ff 7f ff    	mov    -0x800058(%ebp),%al
  800418:	3c ff                	cmp    $0xff,%al
  80041a:	74 14                	je     800430 <_main+0x3f8>
  80041c:	83 ec 04             	sub    $0x4,%esp
  80041f:	68 08 20 80 00       	push   $0x802008
  800424:	6a 45                	push   $0x45
  800426:	68 c1 1f 80 00       	push   $0x801fc1
  80042b:	e8 82 02 00 00       	call   8006b2 <_panic>
		if( arr[PAGE_SIZE*1024*2 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  800430:	8a 85 a8 0f 80 ff    	mov    -0x7ff058(%ebp),%al
  800436:	3c ff                	cmp    $0xff,%al
  800438:	74 14                	je     80044e <_main+0x416>
  80043a:	83 ec 04             	sub    $0x4,%esp
  80043d:	68 08 20 80 00       	push   $0x802008
  800442:	6a 46                	push   $0x46
  800444:	68 c1 1f 80 00       	push   $0x801fc1
  800449:	e8 64 02 00 00       	call   8006b2 <_panic>


		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5) panic("new stack pages are not written to Page File");
  80044e:	e8 8c 14 00 00       	call   8018df <sys_pf_calculate_allocated_pages>
  800453:	2b 45 ac             	sub    -0x54(%ebp),%eax
  800456:	83 f8 05             	cmp    $0x5,%eax
  800459:	74 14                	je     80046f <_main+0x437>
  80045b:	83 ec 04             	sub    $0x4,%esp
  80045e:	68 28 20 80 00       	push   $0x802028
  800463:	6a 49                	push   $0x49
  800465:	68 c1 1f 80 00       	push   $0x801fc1
  80046a:	e8 43 02 00 00       	call   8006b2 <_panic>

		if( (freePages - sys_calculate_free_frames() ) != 9 ) panic("allocated memory size incorrect");
  80046f:	8b 5d a8             	mov    -0x58(%ebp),%ebx
  800472:	e8 e5 13 00 00       	call   80185c <sys_calculate_free_frames>
  800477:	29 c3                	sub    %eax,%ebx
  800479:	89 d8                	mov    %ebx,%eax
  80047b:	83 f8 09             	cmp    $0x9,%eax
  80047e:	74 14                	je     800494 <_main+0x45c>
  800480:	83 ec 04             	sub    $0x4,%esp
  800483:	68 58 20 80 00       	push   $0x802058
  800488:	6a 4b                	push   $0x4b
  80048a:	68 c1 1f 80 00       	push   $0x801fc1
  80048f:	e8 1e 02 00 00       	call   8006b2 <_panic>
	}
	cprintf("STEP A passed: PLACEMENT fault handling works!\n\n\n");
  800494:	83 ec 0c             	sub    $0xc,%esp
  800497:	68 78 20 80 00       	push   $0x802078
  80049c:	e8 c5 04 00 00       	call   800966 <cprintf>
  8004a1:	83 c4 10             	add    $0x10,%esp


	uint32 expectedPages[20] = {0x200000,0x201000,0x202000,0x203000,0x204000,0x205000,0x206000,0x800000,0x801000,0x802000,0x803000,0xeebfd000,0xedbfd000,0xedbfe000,0xedffd000,0xedffe000,0xee3fd000,0xee3fe000, 0, 0};
  8004a4:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  8004aa:	bb a0 21 80 00       	mov    $0x8021a0,%ebx
  8004af:	ba 14 00 00 00       	mov    $0x14,%edx
  8004b4:	89 c7                	mov    %eax,%edi
  8004b6:	89 de                	mov    %ebx,%esi
  8004b8:	89 d1                	mov    %edx,%ecx
  8004ba:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	cprintf("STEP B: checking WS entries ...\n");
  8004bc:	83 ec 0c             	sub    $0xc,%esp
  8004bf:	68 ac 20 80 00       	push   $0x8020ac
  8004c4:	e8 9d 04 00 00       	call   800966 <cprintf>
  8004c9:	83 c4 10             	add    $0x10,%esp
	{
		CheckWSWithoutLastIndex(expectedPages, 20);
  8004cc:	83 ec 08             	sub    $0x8,%esp
  8004cf:	6a 14                	push   $0x14
  8004d1:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  8004d7:	50                   	push   %eax
  8004d8:	e8 47 02 00 00       	call   800724 <CheckWSWithoutLastIndex>
  8004dd:	83 c4 10             	add    $0x10,%esp
	//		if( ROUNDDOWN(myEnv->__uptr_pws[14].virtual_address,PAGE_SIZE) !=  0xedffd000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=  0xedffe000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[16].virtual_address,PAGE_SIZE) !=  0xee3fd000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[17].virtual_address,PAGE_SIZE) !=  0xee3fe000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
}
cprintf("STEP B passed: WS entries test are correct\n\n\n");
  8004e0:	83 ec 0c             	sub    $0xc,%esp
  8004e3:	68 d0 20 80 00       	push   $0x8020d0
  8004e8:	e8 79 04 00 00       	call   800966 <cprintf>
  8004ed:	83 c4 10             	add    $0x10,%esp

cprintf("STEP C: checking working sets WHEN BECOMES FULL...\n");
  8004f0:	83 ec 0c             	sub    $0xc,%esp
  8004f3:	68 00 21 80 00       	push   $0x802100
  8004f8:	e8 69 04 00 00       	call   800966 <cprintf>
  8004fd:	83 c4 10             	add    $0x10,%esp
{
	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 18) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

	i=PAGE_SIZE*1024*3;
  800500:	c7 45 e0 00 00 c0 00 	movl   $0xc00000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024*3+PAGE_SIZE);i++)
  800507:	eb 11                	jmp    80051a <_main+0x4e2>
	{
		arr[i] = -1;
  800509:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  80050f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800512:	01 d0                	add    %edx,%eax
  800514:	c6 00 ff             	movb   $0xff,(%eax)
{
	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 18) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

	i=PAGE_SIZE*1024*3;
	for(;i<=(PAGE_SIZE*1024*3+PAGE_SIZE);i++)
  800517:	ff 45 e0             	incl   -0x20(%ebp)
  80051a:	81 7d e0 00 10 c0 00 	cmpl   $0xc01000,-0x20(%ebp)
  800521:	7e e6                	jle    800509 <_main+0x4d1>
	{
		arr[i] = -1;
	}

	if( arr[PAGE_SIZE*1024*3] !=  -1)  panic("PLACEMENT of stack page failed");
  800523:	8a 85 a8 ff bf ff    	mov    -0x400058(%ebp),%al
  800529:	3c ff                	cmp    $0xff,%al
  80052b:	74 14                	je     800541 <_main+0x509>
  80052d:	83 ec 04             	sub    $0x4,%esp
  800530:	68 08 20 80 00       	push   $0x802008
  800535:	6a 74                	push   $0x74
  800537:	68 c1 1f 80 00       	push   $0x801fc1
  80053c:	e8 71 01 00 00       	call   8006b2 <_panic>
	if( arr[PAGE_SIZE*1024*3 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  800541:	8a 85 a8 0f c0 ff    	mov    -0x3ff058(%ebp),%al
  800547:	3c ff                	cmp    $0xff,%al
  800549:	74 14                	je     80055f <_main+0x527>
  80054b:	83 ec 04             	sub    $0x4,%esp
  80054e:	68 08 20 80 00       	push   $0x802008
  800553:	6a 75                	push   $0x75
  800555:	68 c1 1f 80 00       	push   $0x801fc1
  80055a:	e8 53 01 00 00       	call   8006b2 <_panic>

	expectedPages[18] = 0xee7fd000;
  80055f:	c7 85 a0 ff ff fe 00 	movl   $0xee7fd000,-0x1000060(%ebp)
  800566:	d0 7f ee 
	expectedPages[19] = 0xee7fe000;
  800569:	c7 85 a4 ff ff fe 00 	movl   $0xee7fe000,-0x100005c(%ebp)
  800570:	e0 7f ee 

	CheckWSWithoutLastIndex(expectedPages, 20);
  800573:	83 ec 08             	sub    $0x8,%esp
  800576:	6a 14                	push   $0x14
  800578:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  80057e:	50                   	push   %eax
  80057f:	e8 a0 01 00 00       	call   800724 <CheckWSWithoutLastIndex>
  800584:	83 c4 10             	add    $0x10,%esp

	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 0) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

}
cprintf("STEP C passed: WS is FULL now\n\n\n");
  800587:	83 ec 0c             	sub    $0xc,%esp
  80058a:	68 34 21 80 00       	push   $0x802134
  80058f:	e8 d2 03 00 00       	call   800966 <cprintf>
  800594:	83 c4 10             	add    $0x10,%esp

cprintf("Congratulations!! Test of PAGE PLACEMENT completed successfully!!\n\n\n");
  800597:	83 ec 0c             	sub    $0xc,%esp
  80059a:	68 58 21 80 00       	push   $0x802158
  80059f:	e8 c2 03 00 00       	call   800966 <cprintf>
  8005a4:	83 c4 10             	add    $0x10,%esp
return;
  8005a7:	90                   	nop
}
  8005a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8005ab:	5b                   	pop    %ebx
  8005ac:	5e                   	pop    %esi
  8005ad:	5f                   	pop    %edi
  8005ae:	5d                   	pop    %ebp
  8005af:	c3                   	ret    

008005b0 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005b0:	55                   	push   %ebp
  8005b1:	89 e5                	mov    %esp,%ebp
  8005b3:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005b6:	e8 d6 11 00 00       	call   801791 <sys_getenvindex>
  8005bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005be:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005c1:	89 d0                	mov    %edx,%eax
  8005c3:	01 c0                	add    %eax,%eax
  8005c5:	01 d0                	add    %edx,%eax
  8005c7:	c1 e0 02             	shl    $0x2,%eax
  8005ca:	01 d0                	add    %edx,%eax
  8005cc:	c1 e0 06             	shl    $0x6,%eax
  8005cf:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005d4:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005d9:	a1 04 30 80 00       	mov    0x803004,%eax
  8005de:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8005e4:	84 c0                	test   %al,%al
  8005e6:	74 0f                	je     8005f7 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8005e8:	a1 04 30 80 00       	mov    0x803004,%eax
  8005ed:	05 f4 02 00 00       	add    $0x2f4,%eax
  8005f2:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005f7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005fb:	7e 0a                	jle    800607 <libmain+0x57>
		binaryname = argv[0];
  8005fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800600:	8b 00                	mov    (%eax),%eax
  800602:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800607:	83 ec 08             	sub    $0x8,%esp
  80060a:	ff 75 0c             	pushl  0xc(%ebp)
  80060d:	ff 75 08             	pushl  0x8(%ebp)
  800610:	e8 23 fa ff ff       	call   800038 <_main>
  800615:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800618:	e8 0f 13 00 00       	call   80192c <sys_disable_interrupt>
	cprintf("**************************************\n");
  80061d:	83 ec 0c             	sub    $0xc,%esp
  800620:	68 08 22 80 00       	push   $0x802208
  800625:	e8 3c 03 00 00       	call   800966 <cprintf>
  80062a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80062d:	a1 04 30 80 00       	mov    0x803004,%eax
  800632:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800638:	a1 04 30 80 00       	mov    0x803004,%eax
  80063d:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800643:	83 ec 04             	sub    $0x4,%esp
  800646:	52                   	push   %edx
  800647:	50                   	push   %eax
  800648:	68 30 22 80 00       	push   $0x802230
  80064d:	e8 14 03 00 00       	call   800966 <cprintf>
  800652:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800655:	a1 04 30 80 00       	mov    0x803004,%eax
  80065a:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800660:	83 ec 08             	sub    $0x8,%esp
  800663:	50                   	push   %eax
  800664:	68 55 22 80 00       	push   $0x802255
  800669:	e8 f8 02 00 00       	call   800966 <cprintf>
  80066e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800671:	83 ec 0c             	sub    $0xc,%esp
  800674:	68 08 22 80 00       	push   $0x802208
  800679:	e8 e8 02 00 00       	call   800966 <cprintf>
  80067e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800681:	e8 c0 12 00 00       	call   801946 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800686:	e8 19 00 00 00       	call   8006a4 <exit>
}
  80068b:	90                   	nop
  80068c:	c9                   	leave  
  80068d:	c3                   	ret    

0080068e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80068e:	55                   	push   %ebp
  80068f:	89 e5                	mov    %esp,%ebp
  800691:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800694:	83 ec 0c             	sub    $0xc,%esp
  800697:	6a 00                	push   $0x0
  800699:	e8 bf 10 00 00       	call   80175d <sys_env_destroy>
  80069e:	83 c4 10             	add    $0x10,%esp
}
  8006a1:	90                   	nop
  8006a2:	c9                   	leave  
  8006a3:	c3                   	ret    

008006a4 <exit>:

void
exit(void)
{
  8006a4:	55                   	push   %ebp
  8006a5:	89 e5                	mov    %esp,%ebp
  8006a7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006aa:	e8 14 11 00 00       	call   8017c3 <sys_env_exit>
}
  8006af:	90                   	nop
  8006b0:	c9                   	leave  
  8006b1:	c3                   	ret    

008006b2 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006b2:	55                   	push   %ebp
  8006b3:	89 e5                	mov    %esp,%ebp
  8006b5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006b8:	8d 45 10             	lea    0x10(%ebp),%eax
  8006bb:	83 c0 04             	add    $0x4,%eax
  8006be:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006c1:	a1 14 30 80 00       	mov    0x803014,%eax
  8006c6:	85 c0                	test   %eax,%eax
  8006c8:	74 16                	je     8006e0 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006ca:	a1 14 30 80 00       	mov    0x803014,%eax
  8006cf:	83 ec 08             	sub    $0x8,%esp
  8006d2:	50                   	push   %eax
  8006d3:	68 6c 22 80 00       	push   $0x80226c
  8006d8:	e8 89 02 00 00       	call   800966 <cprintf>
  8006dd:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006e0:	a1 00 30 80 00       	mov    0x803000,%eax
  8006e5:	ff 75 0c             	pushl  0xc(%ebp)
  8006e8:	ff 75 08             	pushl  0x8(%ebp)
  8006eb:	50                   	push   %eax
  8006ec:	68 71 22 80 00       	push   $0x802271
  8006f1:	e8 70 02 00 00       	call   800966 <cprintf>
  8006f6:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8006f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8006fc:	83 ec 08             	sub    $0x8,%esp
  8006ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800702:	50                   	push   %eax
  800703:	e8 f3 01 00 00       	call   8008fb <vcprintf>
  800708:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80070b:	83 ec 08             	sub    $0x8,%esp
  80070e:	6a 00                	push   $0x0
  800710:	68 8d 22 80 00       	push   $0x80228d
  800715:	e8 e1 01 00 00       	call   8008fb <vcprintf>
  80071a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80071d:	e8 82 ff ff ff       	call   8006a4 <exit>

	// should not return here
	while (1) ;
  800722:	eb fe                	jmp    800722 <_panic+0x70>

00800724 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800724:	55                   	push   %ebp
  800725:	89 e5                	mov    %esp,%ebp
  800727:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80072a:	a1 04 30 80 00       	mov    0x803004,%eax
  80072f:	8b 50 74             	mov    0x74(%eax),%edx
  800732:	8b 45 0c             	mov    0xc(%ebp),%eax
  800735:	39 c2                	cmp    %eax,%edx
  800737:	74 14                	je     80074d <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800739:	83 ec 04             	sub    $0x4,%esp
  80073c:	68 90 22 80 00       	push   $0x802290
  800741:	6a 26                	push   $0x26
  800743:	68 dc 22 80 00       	push   $0x8022dc
  800748:	e8 65 ff ff ff       	call   8006b2 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80074d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800754:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80075b:	e9 c2 00 00 00       	jmp    800822 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800760:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800763:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80076a:	8b 45 08             	mov    0x8(%ebp),%eax
  80076d:	01 d0                	add    %edx,%eax
  80076f:	8b 00                	mov    (%eax),%eax
  800771:	85 c0                	test   %eax,%eax
  800773:	75 08                	jne    80077d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800775:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800778:	e9 a2 00 00 00       	jmp    80081f <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80077d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800784:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80078b:	eb 69                	jmp    8007f6 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80078d:	a1 04 30 80 00       	mov    0x803004,%eax
  800792:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800798:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80079b:	89 d0                	mov    %edx,%eax
  80079d:	01 c0                	add    %eax,%eax
  80079f:	01 d0                	add    %edx,%eax
  8007a1:	c1 e0 02             	shl    $0x2,%eax
  8007a4:	01 c8                	add    %ecx,%eax
  8007a6:	8a 40 04             	mov    0x4(%eax),%al
  8007a9:	84 c0                	test   %al,%al
  8007ab:	75 46                	jne    8007f3 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007ad:	a1 04 30 80 00       	mov    0x803004,%eax
  8007b2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007b8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007bb:	89 d0                	mov    %edx,%eax
  8007bd:	01 c0                	add    %eax,%eax
  8007bf:	01 d0                	add    %edx,%eax
  8007c1:	c1 e0 02             	shl    $0x2,%eax
  8007c4:	01 c8                	add    %ecx,%eax
  8007c6:	8b 00                	mov    (%eax),%eax
  8007c8:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007cb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007d3:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007d8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007df:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e2:	01 c8                	add    %ecx,%eax
  8007e4:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007e6:	39 c2                	cmp    %eax,%edx
  8007e8:	75 09                	jne    8007f3 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8007ea:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8007f1:	eb 12                	jmp    800805 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007f3:	ff 45 e8             	incl   -0x18(%ebp)
  8007f6:	a1 04 30 80 00       	mov    0x803004,%eax
  8007fb:	8b 50 74             	mov    0x74(%eax),%edx
  8007fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800801:	39 c2                	cmp    %eax,%edx
  800803:	77 88                	ja     80078d <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800805:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800809:	75 14                	jne    80081f <CheckWSWithoutLastIndex+0xfb>
			panic(
  80080b:	83 ec 04             	sub    $0x4,%esp
  80080e:	68 e8 22 80 00       	push   $0x8022e8
  800813:	6a 3a                	push   $0x3a
  800815:	68 dc 22 80 00       	push   $0x8022dc
  80081a:	e8 93 fe ff ff       	call   8006b2 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80081f:	ff 45 f0             	incl   -0x10(%ebp)
  800822:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800825:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800828:	0f 8c 32 ff ff ff    	jl     800760 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80082e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800835:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80083c:	eb 26                	jmp    800864 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80083e:	a1 04 30 80 00       	mov    0x803004,%eax
  800843:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800849:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80084c:	89 d0                	mov    %edx,%eax
  80084e:	01 c0                	add    %eax,%eax
  800850:	01 d0                	add    %edx,%eax
  800852:	c1 e0 02             	shl    $0x2,%eax
  800855:	01 c8                	add    %ecx,%eax
  800857:	8a 40 04             	mov    0x4(%eax),%al
  80085a:	3c 01                	cmp    $0x1,%al
  80085c:	75 03                	jne    800861 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80085e:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800861:	ff 45 e0             	incl   -0x20(%ebp)
  800864:	a1 04 30 80 00       	mov    0x803004,%eax
  800869:	8b 50 74             	mov    0x74(%eax),%edx
  80086c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80086f:	39 c2                	cmp    %eax,%edx
  800871:	77 cb                	ja     80083e <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800873:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800876:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800879:	74 14                	je     80088f <CheckWSWithoutLastIndex+0x16b>
		panic(
  80087b:	83 ec 04             	sub    $0x4,%esp
  80087e:	68 3c 23 80 00       	push   $0x80233c
  800883:	6a 44                	push   $0x44
  800885:	68 dc 22 80 00       	push   $0x8022dc
  80088a:	e8 23 fe ff ff       	call   8006b2 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80088f:	90                   	nop
  800890:	c9                   	leave  
  800891:	c3                   	ret    

00800892 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800892:	55                   	push   %ebp
  800893:	89 e5                	mov    %esp,%ebp
  800895:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800898:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089b:	8b 00                	mov    (%eax),%eax
  80089d:	8d 48 01             	lea    0x1(%eax),%ecx
  8008a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008a3:	89 0a                	mov    %ecx,(%edx)
  8008a5:	8b 55 08             	mov    0x8(%ebp),%edx
  8008a8:	88 d1                	mov    %dl,%cl
  8008aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ad:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b4:	8b 00                	mov    (%eax),%eax
  8008b6:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008bb:	75 2c                	jne    8008e9 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008bd:	a0 08 30 80 00       	mov    0x803008,%al
  8008c2:	0f b6 c0             	movzbl %al,%eax
  8008c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c8:	8b 12                	mov    (%edx),%edx
  8008ca:	89 d1                	mov    %edx,%ecx
  8008cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008cf:	83 c2 08             	add    $0x8,%edx
  8008d2:	83 ec 04             	sub    $0x4,%esp
  8008d5:	50                   	push   %eax
  8008d6:	51                   	push   %ecx
  8008d7:	52                   	push   %edx
  8008d8:	e8 3e 0e 00 00       	call   80171b <sys_cputs>
  8008dd:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ec:	8b 40 04             	mov    0x4(%eax),%eax
  8008ef:	8d 50 01             	lea    0x1(%eax),%edx
  8008f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f5:	89 50 04             	mov    %edx,0x4(%eax)
}
  8008f8:	90                   	nop
  8008f9:	c9                   	leave  
  8008fa:	c3                   	ret    

008008fb <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8008fb:	55                   	push   %ebp
  8008fc:	89 e5                	mov    %esp,%ebp
  8008fe:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800904:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80090b:	00 00 00 
	b.cnt = 0;
  80090e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800915:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800918:	ff 75 0c             	pushl  0xc(%ebp)
  80091b:	ff 75 08             	pushl  0x8(%ebp)
  80091e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800924:	50                   	push   %eax
  800925:	68 92 08 80 00       	push   $0x800892
  80092a:	e8 11 02 00 00       	call   800b40 <vprintfmt>
  80092f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800932:	a0 08 30 80 00       	mov    0x803008,%al
  800937:	0f b6 c0             	movzbl %al,%eax
  80093a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800940:	83 ec 04             	sub    $0x4,%esp
  800943:	50                   	push   %eax
  800944:	52                   	push   %edx
  800945:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80094b:	83 c0 08             	add    $0x8,%eax
  80094e:	50                   	push   %eax
  80094f:	e8 c7 0d 00 00       	call   80171b <sys_cputs>
  800954:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800957:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  80095e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800964:	c9                   	leave  
  800965:	c3                   	ret    

00800966 <cprintf>:

int cprintf(const char *fmt, ...) {
  800966:	55                   	push   %ebp
  800967:	89 e5                	mov    %esp,%ebp
  800969:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80096c:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800973:	8d 45 0c             	lea    0xc(%ebp),%eax
  800976:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800979:	8b 45 08             	mov    0x8(%ebp),%eax
  80097c:	83 ec 08             	sub    $0x8,%esp
  80097f:	ff 75 f4             	pushl  -0xc(%ebp)
  800982:	50                   	push   %eax
  800983:	e8 73 ff ff ff       	call   8008fb <vcprintf>
  800988:	83 c4 10             	add    $0x10,%esp
  80098b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80098e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800991:	c9                   	leave  
  800992:	c3                   	ret    

00800993 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800993:	55                   	push   %ebp
  800994:	89 e5                	mov    %esp,%ebp
  800996:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800999:	e8 8e 0f 00 00       	call   80192c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80099e:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a7:	83 ec 08             	sub    $0x8,%esp
  8009aa:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ad:	50                   	push   %eax
  8009ae:	e8 48 ff ff ff       	call   8008fb <vcprintf>
  8009b3:	83 c4 10             	add    $0x10,%esp
  8009b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009b9:	e8 88 0f 00 00       	call   801946 <sys_enable_interrupt>
	return cnt;
  8009be:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009c1:	c9                   	leave  
  8009c2:	c3                   	ret    

008009c3 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009c3:	55                   	push   %ebp
  8009c4:	89 e5                	mov    %esp,%ebp
  8009c6:	53                   	push   %ebx
  8009c7:	83 ec 14             	sub    $0x14,%esp
  8009ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8009cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009d6:	8b 45 18             	mov    0x18(%ebp),%eax
  8009d9:	ba 00 00 00 00       	mov    $0x0,%edx
  8009de:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009e1:	77 55                	ja     800a38 <printnum+0x75>
  8009e3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009e6:	72 05                	jb     8009ed <printnum+0x2a>
  8009e8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009eb:	77 4b                	ja     800a38 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009ed:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8009f0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8009f3:	8b 45 18             	mov    0x18(%ebp),%eax
  8009f6:	ba 00 00 00 00       	mov    $0x0,%edx
  8009fb:	52                   	push   %edx
  8009fc:	50                   	push   %eax
  8009fd:	ff 75 f4             	pushl  -0xc(%ebp)
  800a00:	ff 75 f0             	pushl  -0x10(%ebp)
  800a03:	e8 04 13 00 00       	call   801d0c <__udivdi3>
  800a08:	83 c4 10             	add    $0x10,%esp
  800a0b:	83 ec 04             	sub    $0x4,%esp
  800a0e:	ff 75 20             	pushl  0x20(%ebp)
  800a11:	53                   	push   %ebx
  800a12:	ff 75 18             	pushl  0x18(%ebp)
  800a15:	52                   	push   %edx
  800a16:	50                   	push   %eax
  800a17:	ff 75 0c             	pushl  0xc(%ebp)
  800a1a:	ff 75 08             	pushl  0x8(%ebp)
  800a1d:	e8 a1 ff ff ff       	call   8009c3 <printnum>
  800a22:	83 c4 20             	add    $0x20,%esp
  800a25:	eb 1a                	jmp    800a41 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a27:	83 ec 08             	sub    $0x8,%esp
  800a2a:	ff 75 0c             	pushl  0xc(%ebp)
  800a2d:	ff 75 20             	pushl  0x20(%ebp)
  800a30:	8b 45 08             	mov    0x8(%ebp),%eax
  800a33:	ff d0                	call   *%eax
  800a35:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a38:	ff 4d 1c             	decl   0x1c(%ebp)
  800a3b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a3f:	7f e6                	jg     800a27 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a41:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a44:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a49:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a4c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a4f:	53                   	push   %ebx
  800a50:	51                   	push   %ecx
  800a51:	52                   	push   %edx
  800a52:	50                   	push   %eax
  800a53:	e8 c4 13 00 00       	call   801e1c <__umoddi3>
  800a58:	83 c4 10             	add    $0x10,%esp
  800a5b:	05 b4 25 80 00       	add    $0x8025b4,%eax
  800a60:	8a 00                	mov    (%eax),%al
  800a62:	0f be c0             	movsbl %al,%eax
  800a65:	83 ec 08             	sub    $0x8,%esp
  800a68:	ff 75 0c             	pushl  0xc(%ebp)
  800a6b:	50                   	push   %eax
  800a6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6f:	ff d0                	call   *%eax
  800a71:	83 c4 10             	add    $0x10,%esp
}
  800a74:	90                   	nop
  800a75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a78:	c9                   	leave  
  800a79:	c3                   	ret    

00800a7a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a7a:	55                   	push   %ebp
  800a7b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a7d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a81:	7e 1c                	jle    800a9f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a83:	8b 45 08             	mov    0x8(%ebp),%eax
  800a86:	8b 00                	mov    (%eax),%eax
  800a88:	8d 50 08             	lea    0x8(%eax),%edx
  800a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8e:	89 10                	mov    %edx,(%eax)
  800a90:	8b 45 08             	mov    0x8(%ebp),%eax
  800a93:	8b 00                	mov    (%eax),%eax
  800a95:	83 e8 08             	sub    $0x8,%eax
  800a98:	8b 50 04             	mov    0x4(%eax),%edx
  800a9b:	8b 00                	mov    (%eax),%eax
  800a9d:	eb 40                	jmp    800adf <getuint+0x65>
	else if (lflag)
  800a9f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aa3:	74 1e                	je     800ac3 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa8:	8b 00                	mov    (%eax),%eax
  800aaa:	8d 50 04             	lea    0x4(%eax),%edx
  800aad:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab0:	89 10                	mov    %edx,(%eax)
  800ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab5:	8b 00                	mov    (%eax),%eax
  800ab7:	83 e8 04             	sub    $0x4,%eax
  800aba:	8b 00                	mov    (%eax),%eax
  800abc:	ba 00 00 00 00       	mov    $0x0,%edx
  800ac1:	eb 1c                	jmp    800adf <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	8b 00                	mov    (%eax),%eax
  800ac8:	8d 50 04             	lea    0x4(%eax),%edx
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	89 10                	mov    %edx,(%eax)
  800ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad3:	8b 00                	mov    (%eax),%eax
  800ad5:	83 e8 04             	sub    $0x4,%eax
  800ad8:	8b 00                	mov    (%eax),%eax
  800ada:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800adf:	5d                   	pop    %ebp
  800ae0:	c3                   	ret    

00800ae1 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800ae1:	55                   	push   %ebp
  800ae2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ae4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ae8:	7e 1c                	jle    800b06 <getint+0x25>
		return va_arg(*ap, long long);
  800aea:	8b 45 08             	mov    0x8(%ebp),%eax
  800aed:	8b 00                	mov    (%eax),%eax
  800aef:	8d 50 08             	lea    0x8(%eax),%edx
  800af2:	8b 45 08             	mov    0x8(%ebp),%eax
  800af5:	89 10                	mov    %edx,(%eax)
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
  800afa:	8b 00                	mov    (%eax),%eax
  800afc:	83 e8 08             	sub    $0x8,%eax
  800aff:	8b 50 04             	mov    0x4(%eax),%edx
  800b02:	8b 00                	mov    (%eax),%eax
  800b04:	eb 38                	jmp    800b3e <getint+0x5d>
	else if (lflag)
  800b06:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b0a:	74 1a                	je     800b26 <getint+0x45>
		return va_arg(*ap, long);
  800b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0f:	8b 00                	mov    (%eax),%eax
  800b11:	8d 50 04             	lea    0x4(%eax),%edx
  800b14:	8b 45 08             	mov    0x8(%ebp),%eax
  800b17:	89 10                	mov    %edx,(%eax)
  800b19:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1c:	8b 00                	mov    (%eax),%eax
  800b1e:	83 e8 04             	sub    $0x4,%eax
  800b21:	8b 00                	mov    (%eax),%eax
  800b23:	99                   	cltd   
  800b24:	eb 18                	jmp    800b3e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	8b 00                	mov    (%eax),%eax
  800b2b:	8d 50 04             	lea    0x4(%eax),%edx
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	89 10                	mov    %edx,(%eax)
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	8b 00                	mov    (%eax),%eax
  800b38:	83 e8 04             	sub    $0x4,%eax
  800b3b:	8b 00                	mov    (%eax),%eax
  800b3d:	99                   	cltd   
}
  800b3e:	5d                   	pop    %ebp
  800b3f:	c3                   	ret    

00800b40 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b40:	55                   	push   %ebp
  800b41:	89 e5                	mov    %esp,%ebp
  800b43:	56                   	push   %esi
  800b44:	53                   	push   %ebx
  800b45:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b48:	eb 17                	jmp    800b61 <vprintfmt+0x21>
			if (ch == '\0')
  800b4a:	85 db                	test   %ebx,%ebx
  800b4c:	0f 84 af 03 00 00    	je     800f01 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b52:	83 ec 08             	sub    $0x8,%esp
  800b55:	ff 75 0c             	pushl  0xc(%ebp)
  800b58:	53                   	push   %ebx
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5c:	ff d0                	call   *%eax
  800b5e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b61:	8b 45 10             	mov    0x10(%ebp),%eax
  800b64:	8d 50 01             	lea    0x1(%eax),%edx
  800b67:	89 55 10             	mov    %edx,0x10(%ebp)
  800b6a:	8a 00                	mov    (%eax),%al
  800b6c:	0f b6 d8             	movzbl %al,%ebx
  800b6f:	83 fb 25             	cmp    $0x25,%ebx
  800b72:	75 d6                	jne    800b4a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b74:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b78:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b7f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b86:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b8d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800b94:	8b 45 10             	mov    0x10(%ebp),%eax
  800b97:	8d 50 01             	lea    0x1(%eax),%edx
  800b9a:	89 55 10             	mov    %edx,0x10(%ebp)
  800b9d:	8a 00                	mov    (%eax),%al
  800b9f:	0f b6 d8             	movzbl %al,%ebx
  800ba2:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ba5:	83 f8 55             	cmp    $0x55,%eax
  800ba8:	0f 87 2b 03 00 00    	ja     800ed9 <vprintfmt+0x399>
  800bae:	8b 04 85 d8 25 80 00 	mov    0x8025d8(,%eax,4),%eax
  800bb5:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bb7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bbb:	eb d7                	jmp    800b94 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bbd:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bc1:	eb d1                	jmp    800b94 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bc3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bca:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bcd:	89 d0                	mov    %edx,%eax
  800bcf:	c1 e0 02             	shl    $0x2,%eax
  800bd2:	01 d0                	add    %edx,%eax
  800bd4:	01 c0                	add    %eax,%eax
  800bd6:	01 d8                	add    %ebx,%eax
  800bd8:	83 e8 30             	sub    $0x30,%eax
  800bdb:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bde:	8b 45 10             	mov    0x10(%ebp),%eax
  800be1:	8a 00                	mov    (%eax),%al
  800be3:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800be6:	83 fb 2f             	cmp    $0x2f,%ebx
  800be9:	7e 3e                	jle    800c29 <vprintfmt+0xe9>
  800beb:	83 fb 39             	cmp    $0x39,%ebx
  800bee:	7f 39                	jg     800c29 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bf0:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800bf3:	eb d5                	jmp    800bca <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800bf5:	8b 45 14             	mov    0x14(%ebp),%eax
  800bf8:	83 c0 04             	add    $0x4,%eax
  800bfb:	89 45 14             	mov    %eax,0x14(%ebp)
  800bfe:	8b 45 14             	mov    0x14(%ebp),%eax
  800c01:	83 e8 04             	sub    $0x4,%eax
  800c04:	8b 00                	mov    (%eax),%eax
  800c06:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c09:	eb 1f                	jmp    800c2a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c0b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c0f:	79 83                	jns    800b94 <vprintfmt+0x54>
				width = 0;
  800c11:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c18:	e9 77 ff ff ff       	jmp    800b94 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c1d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c24:	e9 6b ff ff ff       	jmp    800b94 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c29:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c2a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c2e:	0f 89 60 ff ff ff    	jns    800b94 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c34:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c37:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c3a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c41:	e9 4e ff ff ff       	jmp    800b94 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c46:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c49:	e9 46 ff ff ff       	jmp    800b94 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c4e:	8b 45 14             	mov    0x14(%ebp),%eax
  800c51:	83 c0 04             	add    $0x4,%eax
  800c54:	89 45 14             	mov    %eax,0x14(%ebp)
  800c57:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5a:	83 e8 04             	sub    $0x4,%eax
  800c5d:	8b 00                	mov    (%eax),%eax
  800c5f:	83 ec 08             	sub    $0x8,%esp
  800c62:	ff 75 0c             	pushl  0xc(%ebp)
  800c65:	50                   	push   %eax
  800c66:	8b 45 08             	mov    0x8(%ebp),%eax
  800c69:	ff d0                	call   *%eax
  800c6b:	83 c4 10             	add    $0x10,%esp
			break;
  800c6e:	e9 89 02 00 00       	jmp    800efc <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c73:	8b 45 14             	mov    0x14(%ebp),%eax
  800c76:	83 c0 04             	add    $0x4,%eax
  800c79:	89 45 14             	mov    %eax,0x14(%ebp)
  800c7c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c7f:	83 e8 04             	sub    $0x4,%eax
  800c82:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c84:	85 db                	test   %ebx,%ebx
  800c86:	79 02                	jns    800c8a <vprintfmt+0x14a>
				err = -err;
  800c88:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c8a:	83 fb 64             	cmp    $0x64,%ebx
  800c8d:	7f 0b                	jg     800c9a <vprintfmt+0x15a>
  800c8f:	8b 34 9d 20 24 80 00 	mov    0x802420(,%ebx,4),%esi
  800c96:	85 f6                	test   %esi,%esi
  800c98:	75 19                	jne    800cb3 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800c9a:	53                   	push   %ebx
  800c9b:	68 c5 25 80 00       	push   $0x8025c5
  800ca0:	ff 75 0c             	pushl  0xc(%ebp)
  800ca3:	ff 75 08             	pushl  0x8(%ebp)
  800ca6:	e8 5e 02 00 00       	call   800f09 <printfmt>
  800cab:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cae:	e9 49 02 00 00       	jmp    800efc <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cb3:	56                   	push   %esi
  800cb4:	68 ce 25 80 00       	push   $0x8025ce
  800cb9:	ff 75 0c             	pushl  0xc(%ebp)
  800cbc:	ff 75 08             	pushl  0x8(%ebp)
  800cbf:	e8 45 02 00 00       	call   800f09 <printfmt>
  800cc4:	83 c4 10             	add    $0x10,%esp
			break;
  800cc7:	e9 30 02 00 00       	jmp    800efc <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ccc:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccf:	83 c0 04             	add    $0x4,%eax
  800cd2:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd5:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd8:	83 e8 04             	sub    $0x4,%eax
  800cdb:	8b 30                	mov    (%eax),%esi
  800cdd:	85 f6                	test   %esi,%esi
  800cdf:	75 05                	jne    800ce6 <vprintfmt+0x1a6>
				p = "(null)";
  800ce1:	be d1 25 80 00       	mov    $0x8025d1,%esi
			if (width > 0 && padc != '-')
  800ce6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cea:	7e 6d                	jle    800d59 <vprintfmt+0x219>
  800cec:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800cf0:	74 67                	je     800d59 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800cf2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cf5:	83 ec 08             	sub    $0x8,%esp
  800cf8:	50                   	push   %eax
  800cf9:	56                   	push   %esi
  800cfa:	e8 0c 03 00 00       	call   80100b <strnlen>
  800cff:	83 c4 10             	add    $0x10,%esp
  800d02:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d05:	eb 16                	jmp    800d1d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d07:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d0b:	83 ec 08             	sub    $0x8,%esp
  800d0e:	ff 75 0c             	pushl  0xc(%ebp)
  800d11:	50                   	push   %eax
  800d12:	8b 45 08             	mov    0x8(%ebp),%eax
  800d15:	ff d0                	call   *%eax
  800d17:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d1a:	ff 4d e4             	decl   -0x1c(%ebp)
  800d1d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d21:	7f e4                	jg     800d07 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d23:	eb 34                	jmp    800d59 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d25:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d29:	74 1c                	je     800d47 <vprintfmt+0x207>
  800d2b:	83 fb 1f             	cmp    $0x1f,%ebx
  800d2e:	7e 05                	jle    800d35 <vprintfmt+0x1f5>
  800d30:	83 fb 7e             	cmp    $0x7e,%ebx
  800d33:	7e 12                	jle    800d47 <vprintfmt+0x207>
					putch('?', putdat);
  800d35:	83 ec 08             	sub    $0x8,%esp
  800d38:	ff 75 0c             	pushl  0xc(%ebp)
  800d3b:	6a 3f                	push   $0x3f
  800d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d40:	ff d0                	call   *%eax
  800d42:	83 c4 10             	add    $0x10,%esp
  800d45:	eb 0f                	jmp    800d56 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d47:	83 ec 08             	sub    $0x8,%esp
  800d4a:	ff 75 0c             	pushl  0xc(%ebp)
  800d4d:	53                   	push   %ebx
  800d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d51:	ff d0                	call   *%eax
  800d53:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d56:	ff 4d e4             	decl   -0x1c(%ebp)
  800d59:	89 f0                	mov    %esi,%eax
  800d5b:	8d 70 01             	lea    0x1(%eax),%esi
  800d5e:	8a 00                	mov    (%eax),%al
  800d60:	0f be d8             	movsbl %al,%ebx
  800d63:	85 db                	test   %ebx,%ebx
  800d65:	74 24                	je     800d8b <vprintfmt+0x24b>
  800d67:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d6b:	78 b8                	js     800d25 <vprintfmt+0x1e5>
  800d6d:	ff 4d e0             	decl   -0x20(%ebp)
  800d70:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d74:	79 af                	jns    800d25 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d76:	eb 13                	jmp    800d8b <vprintfmt+0x24b>
				putch(' ', putdat);
  800d78:	83 ec 08             	sub    $0x8,%esp
  800d7b:	ff 75 0c             	pushl  0xc(%ebp)
  800d7e:	6a 20                	push   $0x20
  800d80:	8b 45 08             	mov    0x8(%ebp),%eax
  800d83:	ff d0                	call   *%eax
  800d85:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d88:	ff 4d e4             	decl   -0x1c(%ebp)
  800d8b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d8f:	7f e7                	jg     800d78 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d91:	e9 66 01 00 00       	jmp    800efc <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800d96:	83 ec 08             	sub    $0x8,%esp
  800d99:	ff 75 e8             	pushl  -0x18(%ebp)
  800d9c:	8d 45 14             	lea    0x14(%ebp),%eax
  800d9f:	50                   	push   %eax
  800da0:	e8 3c fd ff ff       	call   800ae1 <getint>
  800da5:	83 c4 10             	add    $0x10,%esp
  800da8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dab:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800db1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800db4:	85 d2                	test   %edx,%edx
  800db6:	79 23                	jns    800ddb <vprintfmt+0x29b>
				putch('-', putdat);
  800db8:	83 ec 08             	sub    $0x8,%esp
  800dbb:	ff 75 0c             	pushl  0xc(%ebp)
  800dbe:	6a 2d                	push   $0x2d
  800dc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc3:	ff d0                	call   *%eax
  800dc5:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dc8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dcb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dce:	f7 d8                	neg    %eax
  800dd0:	83 d2 00             	adc    $0x0,%edx
  800dd3:	f7 da                	neg    %edx
  800dd5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dd8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ddb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800de2:	e9 bc 00 00 00       	jmp    800ea3 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800de7:	83 ec 08             	sub    $0x8,%esp
  800dea:	ff 75 e8             	pushl  -0x18(%ebp)
  800ded:	8d 45 14             	lea    0x14(%ebp),%eax
  800df0:	50                   	push   %eax
  800df1:	e8 84 fc ff ff       	call   800a7a <getuint>
  800df6:	83 c4 10             	add    $0x10,%esp
  800df9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dfc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800dff:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e06:	e9 98 00 00 00       	jmp    800ea3 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e0b:	83 ec 08             	sub    $0x8,%esp
  800e0e:	ff 75 0c             	pushl  0xc(%ebp)
  800e11:	6a 58                	push   $0x58
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	ff d0                	call   *%eax
  800e18:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e1b:	83 ec 08             	sub    $0x8,%esp
  800e1e:	ff 75 0c             	pushl  0xc(%ebp)
  800e21:	6a 58                	push   $0x58
  800e23:	8b 45 08             	mov    0x8(%ebp),%eax
  800e26:	ff d0                	call   *%eax
  800e28:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e2b:	83 ec 08             	sub    $0x8,%esp
  800e2e:	ff 75 0c             	pushl  0xc(%ebp)
  800e31:	6a 58                	push   $0x58
  800e33:	8b 45 08             	mov    0x8(%ebp),%eax
  800e36:	ff d0                	call   *%eax
  800e38:	83 c4 10             	add    $0x10,%esp
			break;
  800e3b:	e9 bc 00 00 00       	jmp    800efc <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e40:	83 ec 08             	sub    $0x8,%esp
  800e43:	ff 75 0c             	pushl  0xc(%ebp)
  800e46:	6a 30                	push   $0x30
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	ff d0                	call   *%eax
  800e4d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e50:	83 ec 08             	sub    $0x8,%esp
  800e53:	ff 75 0c             	pushl  0xc(%ebp)
  800e56:	6a 78                	push   $0x78
  800e58:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5b:	ff d0                	call   *%eax
  800e5d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e60:	8b 45 14             	mov    0x14(%ebp),%eax
  800e63:	83 c0 04             	add    $0x4,%eax
  800e66:	89 45 14             	mov    %eax,0x14(%ebp)
  800e69:	8b 45 14             	mov    0x14(%ebp),%eax
  800e6c:	83 e8 04             	sub    $0x4,%eax
  800e6f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e71:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e7b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e82:	eb 1f                	jmp    800ea3 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e84:	83 ec 08             	sub    $0x8,%esp
  800e87:	ff 75 e8             	pushl  -0x18(%ebp)
  800e8a:	8d 45 14             	lea    0x14(%ebp),%eax
  800e8d:	50                   	push   %eax
  800e8e:	e8 e7 fb ff ff       	call   800a7a <getuint>
  800e93:	83 c4 10             	add    $0x10,%esp
  800e96:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e99:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800e9c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ea3:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ea7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800eaa:	83 ec 04             	sub    $0x4,%esp
  800ead:	52                   	push   %edx
  800eae:	ff 75 e4             	pushl  -0x1c(%ebp)
  800eb1:	50                   	push   %eax
  800eb2:	ff 75 f4             	pushl  -0xc(%ebp)
  800eb5:	ff 75 f0             	pushl  -0x10(%ebp)
  800eb8:	ff 75 0c             	pushl  0xc(%ebp)
  800ebb:	ff 75 08             	pushl  0x8(%ebp)
  800ebe:	e8 00 fb ff ff       	call   8009c3 <printnum>
  800ec3:	83 c4 20             	add    $0x20,%esp
			break;
  800ec6:	eb 34                	jmp    800efc <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ec8:	83 ec 08             	sub    $0x8,%esp
  800ecb:	ff 75 0c             	pushl  0xc(%ebp)
  800ece:	53                   	push   %ebx
  800ecf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed2:	ff d0                	call   *%eax
  800ed4:	83 c4 10             	add    $0x10,%esp
			break;
  800ed7:	eb 23                	jmp    800efc <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ed9:	83 ec 08             	sub    $0x8,%esp
  800edc:	ff 75 0c             	pushl  0xc(%ebp)
  800edf:	6a 25                	push   $0x25
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	ff d0                	call   *%eax
  800ee6:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ee9:	ff 4d 10             	decl   0x10(%ebp)
  800eec:	eb 03                	jmp    800ef1 <vprintfmt+0x3b1>
  800eee:	ff 4d 10             	decl   0x10(%ebp)
  800ef1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef4:	48                   	dec    %eax
  800ef5:	8a 00                	mov    (%eax),%al
  800ef7:	3c 25                	cmp    $0x25,%al
  800ef9:	75 f3                	jne    800eee <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800efb:	90                   	nop
		}
	}
  800efc:	e9 47 fc ff ff       	jmp    800b48 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f01:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f02:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f05:	5b                   	pop    %ebx
  800f06:	5e                   	pop    %esi
  800f07:	5d                   	pop    %ebp
  800f08:	c3                   	ret    

00800f09 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f09:	55                   	push   %ebp
  800f0a:	89 e5                	mov    %esp,%ebp
  800f0c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f0f:	8d 45 10             	lea    0x10(%ebp),%eax
  800f12:	83 c0 04             	add    $0x4,%eax
  800f15:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f18:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1b:	ff 75 f4             	pushl  -0xc(%ebp)
  800f1e:	50                   	push   %eax
  800f1f:	ff 75 0c             	pushl  0xc(%ebp)
  800f22:	ff 75 08             	pushl  0x8(%ebp)
  800f25:	e8 16 fc ff ff       	call   800b40 <vprintfmt>
  800f2a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f2d:	90                   	nop
  800f2e:	c9                   	leave  
  800f2f:	c3                   	ret    

00800f30 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f30:	55                   	push   %ebp
  800f31:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f36:	8b 40 08             	mov    0x8(%eax),%eax
  800f39:	8d 50 01             	lea    0x1(%eax),%edx
  800f3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f45:	8b 10                	mov    (%eax),%edx
  800f47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4a:	8b 40 04             	mov    0x4(%eax),%eax
  800f4d:	39 c2                	cmp    %eax,%edx
  800f4f:	73 12                	jae    800f63 <sprintputch+0x33>
		*b->buf++ = ch;
  800f51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f54:	8b 00                	mov    (%eax),%eax
  800f56:	8d 48 01             	lea    0x1(%eax),%ecx
  800f59:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f5c:	89 0a                	mov    %ecx,(%edx)
  800f5e:	8b 55 08             	mov    0x8(%ebp),%edx
  800f61:	88 10                	mov    %dl,(%eax)
}
  800f63:	90                   	nop
  800f64:	5d                   	pop    %ebp
  800f65:	c3                   	ret    

00800f66 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f66:	55                   	push   %ebp
  800f67:	89 e5                	mov    %esp,%ebp
  800f69:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f75:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	01 d0                	add    %edx,%eax
  800f7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f80:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f87:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f8b:	74 06                	je     800f93 <vsnprintf+0x2d>
  800f8d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f91:	7f 07                	jg     800f9a <vsnprintf+0x34>
		return -E_INVAL;
  800f93:	b8 03 00 00 00       	mov    $0x3,%eax
  800f98:	eb 20                	jmp    800fba <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800f9a:	ff 75 14             	pushl  0x14(%ebp)
  800f9d:	ff 75 10             	pushl  0x10(%ebp)
  800fa0:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fa3:	50                   	push   %eax
  800fa4:	68 30 0f 80 00       	push   $0x800f30
  800fa9:	e8 92 fb ff ff       	call   800b40 <vprintfmt>
  800fae:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fb1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fb4:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fba:	c9                   	leave  
  800fbb:	c3                   	ret    

00800fbc <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fbc:	55                   	push   %ebp
  800fbd:	89 e5                	mov    %esp,%ebp
  800fbf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fc2:	8d 45 10             	lea    0x10(%ebp),%eax
  800fc5:	83 c0 04             	add    $0x4,%eax
  800fc8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fcb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fce:	ff 75 f4             	pushl  -0xc(%ebp)
  800fd1:	50                   	push   %eax
  800fd2:	ff 75 0c             	pushl  0xc(%ebp)
  800fd5:	ff 75 08             	pushl  0x8(%ebp)
  800fd8:	e8 89 ff ff ff       	call   800f66 <vsnprintf>
  800fdd:	83 c4 10             	add    $0x10,%esp
  800fe0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800fe3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fe6:	c9                   	leave  
  800fe7:	c3                   	ret    

00800fe8 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800fe8:	55                   	push   %ebp
  800fe9:	89 e5                	mov    %esp,%ebp
  800feb:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800fee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ff5:	eb 06                	jmp    800ffd <strlen+0x15>
		n++;
  800ff7:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ffa:	ff 45 08             	incl   0x8(%ebp)
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  801000:	8a 00                	mov    (%eax),%al
  801002:	84 c0                	test   %al,%al
  801004:	75 f1                	jne    800ff7 <strlen+0xf>
		n++;
	return n;
  801006:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801009:	c9                   	leave  
  80100a:	c3                   	ret    

0080100b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80100b:	55                   	push   %ebp
  80100c:	89 e5                	mov    %esp,%ebp
  80100e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801011:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801018:	eb 09                	jmp    801023 <strnlen+0x18>
		n++;
  80101a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80101d:	ff 45 08             	incl   0x8(%ebp)
  801020:	ff 4d 0c             	decl   0xc(%ebp)
  801023:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801027:	74 09                	je     801032 <strnlen+0x27>
  801029:	8b 45 08             	mov    0x8(%ebp),%eax
  80102c:	8a 00                	mov    (%eax),%al
  80102e:	84 c0                	test   %al,%al
  801030:	75 e8                	jne    80101a <strnlen+0xf>
		n++;
	return n;
  801032:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801035:	c9                   	leave  
  801036:	c3                   	ret    

00801037 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801037:	55                   	push   %ebp
  801038:	89 e5                	mov    %esp,%ebp
  80103a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80103d:	8b 45 08             	mov    0x8(%ebp),%eax
  801040:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801043:	90                   	nop
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	8d 50 01             	lea    0x1(%eax),%edx
  80104a:	89 55 08             	mov    %edx,0x8(%ebp)
  80104d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801050:	8d 4a 01             	lea    0x1(%edx),%ecx
  801053:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801056:	8a 12                	mov    (%edx),%dl
  801058:	88 10                	mov    %dl,(%eax)
  80105a:	8a 00                	mov    (%eax),%al
  80105c:	84 c0                	test   %al,%al
  80105e:	75 e4                	jne    801044 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801060:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801063:	c9                   	leave  
  801064:	c3                   	ret    

00801065 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801065:	55                   	push   %ebp
  801066:	89 e5                	mov    %esp,%ebp
  801068:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
  80106e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801071:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801078:	eb 1f                	jmp    801099 <strncpy+0x34>
		*dst++ = *src;
  80107a:	8b 45 08             	mov    0x8(%ebp),%eax
  80107d:	8d 50 01             	lea    0x1(%eax),%edx
  801080:	89 55 08             	mov    %edx,0x8(%ebp)
  801083:	8b 55 0c             	mov    0xc(%ebp),%edx
  801086:	8a 12                	mov    (%edx),%dl
  801088:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80108a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108d:	8a 00                	mov    (%eax),%al
  80108f:	84 c0                	test   %al,%al
  801091:	74 03                	je     801096 <strncpy+0x31>
			src++;
  801093:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801096:	ff 45 fc             	incl   -0x4(%ebp)
  801099:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80109c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80109f:	72 d9                	jb     80107a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010a4:	c9                   	leave  
  8010a5:	c3                   	ret    

008010a6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010a6:	55                   	push   %ebp
  8010a7:	89 e5                	mov    %esp,%ebp
  8010a9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8010af:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010b6:	74 30                	je     8010e8 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010b8:	eb 16                	jmp    8010d0 <strlcpy+0x2a>
			*dst++ = *src++;
  8010ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bd:	8d 50 01             	lea    0x1(%eax),%edx
  8010c0:	89 55 08             	mov    %edx,0x8(%ebp)
  8010c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010c9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010cc:	8a 12                	mov    (%edx),%dl
  8010ce:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010d0:	ff 4d 10             	decl   0x10(%ebp)
  8010d3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010d7:	74 09                	je     8010e2 <strlcpy+0x3c>
  8010d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010dc:	8a 00                	mov    (%eax),%al
  8010de:	84 c0                	test   %al,%al
  8010e0:	75 d8                	jne    8010ba <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010e8:	8b 55 08             	mov    0x8(%ebp),%edx
  8010eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ee:	29 c2                	sub    %eax,%edx
  8010f0:	89 d0                	mov    %edx,%eax
}
  8010f2:	c9                   	leave  
  8010f3:	c3                   	ret    

008010f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8010f4:	55                   	push   %ebp
  8010f5:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8010f7:	eb 06                	jmp    8010ff <strcmp+0xb>
		p++, q++;
  8010f9:	ff 45 08             	incl   0x8(%ebp)
  8010fc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8010ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801102:	8a 00                	mov    (%eax),%al
  801104:	84 c0                	test   %al,%al
  801106:	74 0e                	je     801116 <strcmp+0x22>
  801108:	8b 45 08             	mov    0x8(%ebp),%eax
  80110b:	8a 10                	mov    (%eax),%dl
  80110d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801110:	8a 00                	mov    (%eax),%al
  801112:	38 c2                	cmp    %al,%dl
  801114:	74 e3                	je     8010f9 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801116:	8b 45 08             	mov    0x8(%ebp),%eax
  801119:	8a 00                	mov    (%eax),%al
  80111b:	0f b6 d0             	movzbl %al,%edx
  80111e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801121:	8a 00                	mov    (%eax),%al
  801123:	0f b6 c0             	movzbl %al,%eax
  801126:	29 c2                	sub    %eax,%edx
  801128:	89 d0                	mov    %edx,%eax
}
  80112a:	5d                   	pop    %ebp
  80112b:	c3                   	ret    

0080112c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80112c:	55                   	push   %ebp
  80112d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80112f:	eb 09                	jmp    80113a <strncmp+0xe>
		n--, p++, q++;
  801131:	ff 4d 10             	decl   0x10(%ebp)
  801134:	ff 45 08             	incl   0x8(%ebp)
  801137:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80113a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80113e:	74 17                	je     801157 <strncmp+0x2b>
  801140:	8b 45 08             	mov    0x8(%ebp),%eax
  801143:	8a 00                	mov    (%eax),%al
  801145:	84 c0                	test   %al,%al
  801147:	74 0e                	je     801157 <strncmp+0x2b>
  801149:	8b 45 08             	mov    0x8(%ebp),%eax
  80114c:	8a 10                	mov    (%eax),%dl
  80114e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801151:	8a 00                	mov    (%eax),%al
  801153:	38 c2                	cmp    %al,%dl
  801155:	74 da                	je     801131 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801157:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80115b:	75 07                	jne    801164 <strncmp+0x38>
		return 0;
  80115d:	b8 00 00 00 00       	mov    $0x0,%eax
  801162:	eb 14                	jmp    801178 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801164:	8b 45 08             	mov    0x8(%ebp),%eax
  801167:	8a 00                	mov    (%eax),%al
  801169:	0f b6 d0             	movzbl %al,%edx
  80116c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116f:	8a 00                	mov    (%eax),%al
  801171:	0f b6 c0             	movzbl %al,%eax
  801174:	29 c2                	sub    %eax,%edx
  801176:	89 d0                	mov    %edx,%eax
}
  801178:	5d                   	pop    %ebp
  801179:	c3                   	ret    

0080117a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80117a:	55                   	push   %ebp
  80117b:	89 e5                	mov    %esp,%ebp
  80117d:	83 ec 04             	sub    $0x4,%esp
  801180:	8b 45 0c             	mov    0xc(%ebp),%eax
  801183:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801186:	eb 12                	jmp    80119a <strchr+0x20>
		if (*s == c)
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	8a 00                	mov    (%eax),%al
  80118d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801190:	75 05                	jne    801197 <strchr+0x1d>
			return (char *) s;
  801192:	8b 45 08             	mov    0x8(%ebp),%eax
  801195:	eb 11                	jmp    8011a8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801197:	ff 45 08             	incl   0x8(%ebp)
  80119a:	8b 45 08             	mov    0x8(%ebp),%eax
  80119d:	8a 00                	mov    (%eax),%al
  80119f:	84 c0                	test   %al,%al
  8011a1:	75 e5                	jne    801188 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011a8:	c9                   	leave  
  8011a9:	c3                   	ret    

008011aa <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011aa:	55                   	push   %ebp
  8011ab:	89 e5                	mov    %esp,%ebp
  8011ad:	83 ec 04             	sub    $0x4,%esp
  8011b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011b6:	eb 0d                	jmp    8011c5 <strfind+0x1b>
		if (*s == c)
  8011b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bb:	8a 00                	mov    (%eax),%al
  8011bd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011c0:	74 0e                	je     8011d0 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011c2:	ff 45 08             	incl   0x8(%ebp)
  8011c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c8:	8a 00                	mov    (%eax),%al
  8011ca:	84 c0                	test   %al,%al
  8011cc:	75 ea                	jne    8011b8 <strfind+0xe>
  8011ce:	eb 01                	jmp    8011d1 <strfind+0x27>
		if (*s == c)
			break;
  8011d0:	90                   	nop
	return (char *) s;
  8011d1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011d4:	c9                   	leave  
  8011d5:	c3                   	ret    

008011d6 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011d6:	55                   	push   %ebp
  8011d7:	89 e5                	mov    %esp,%ebp
  8011d9:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011e8:	eb 0e                	jmp    8011f8 <memset+0x22>
		*p++ = c;
  8011ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011ed:	8d 50 01             	lea    0x1(%eax),%edx
  8011f0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011f6:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8011f8:	ff 4d f8             	decl   -0x8(%ebp)
  8011fb:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8011ff:	79 e9                	jns    8011ea <memset+0x14>
		*p++ = c;

	return v;
  801201:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801204:	c9                   	leave  
  801205:	c3                   	ret    

00801206 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801206:	55                   	push   %ebp
  801207:	89 e5                	mov    %esp,%ebp
  801209:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80120c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801212:	8b 45 08             	mov    0x8(%ebp),%eax
  801215:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801218:	eb 16                	jmp    801230 <memcpy+0x2a>
		*d++ = *s++;
  80121a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80121d:	8d 50 01             	lea    0x1(%eax),%edx
  801220:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801223:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801226:	8d 4a 01             	lea    0x1(%edx),%ecx
  801229:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80122c:	8a 12                	mov    (%edx),%dl
  80122e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801230:	8b 45 10             	mov    0x10(%ebp),%eax
  801233:	8d 50 ff             	lea    -0x1(%eax),%edx
  801236:	89 55 10             	mov    %edx,0x10(%ebp)
  801239:	85 c0                	test   %eax,%eax
  80123b:	75 dd                	jne    80121a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801240:	c9                   	leave  
  801241:	c3                   	ret    

00801242 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801242:	55                   	push   %ebp
  801243:	89 e5                	mov    %esp,%ebp
  801245:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801248:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80124e:	8b 45 08             	mov    0x8(%ebp),%eax
  801251:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801254:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801257:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80125a:	73 50                	jae    8012ac <memmove+0x6a>
  80125c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80125f:	8b 45 10             	mov    0x10(%ebp),%eax
  801262:	01 d0                	add    %edx,%eax
  801264:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801267:	76 43                	jbe    8012ac <memmove+0x6a>
		s += n;
  801269:	8b 45 10             	mov    0x10(%ebp),%eax
  80126c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80126f:	8b 45 10             	mov    0x10(%ebp),%eax
  801272:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801275:	eb 10                	jmp    801287 <memmove+0x45>
			*--d = *--s;
  801277:	ff 4d f8             	decl   -0x8(%ebp)
  80127a:	ff 4d fc             	decl   -0x4(%ebp)
  80127d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801280:	8a 10                	mov    (%eax),%dl
  801282:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801285:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801287:	8b 45 10             	mov    0x10(%ebp),%eax
  80128a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80128d:	89 55 10             	mov    %edx,0x10(%ebp)
  801290:	85 c0                	test   %eax,%eax
  801292:	75 e3                	jne    801277 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801294:	eb 23                	jmp    8012b9 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801296:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801299:	8d 50 01             	lea    0x1(%eax),%edx
  80129c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80129f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012a5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012a8:	8a 12                	mov    (%edx),%dl
  8012aa:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8012af:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012b2:	89 55 10             	mov    %edx,0x10(%ebp)
  8012b5:	85 c0                	test   %eax,%eax
  8012b7:	75 dd                	jne    801296 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012b9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012bc:	c9                   	leave  
  8012bd:	c3                   	ret    

008012be <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012be:	55                   	push   %ebp
  8012bf:	89 e5                	mov    %esp,%ebp
  8012c1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cd:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012d0:	eb 2a                	jmp    8012fc <memcmp+0x3e>
		if (*s1 != *s2)
  8012d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d5:	8a 10                	mov    (%eax),%dl
  8012d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012da:	8a 00                	mov    (%eax),%al
  8012dc:	38 c2                	cmp    %al,%dl
  8012de:	74 16                	je     8012f6 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e3:	8a 00                	mov    (%eax),%al
  8012e5:	0f b6 d0             	movzbl %al,%edx
  8012e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012eb:	8a 00                	mov    (%eax),%al
  8012ed:	0f b6 c0             	movzbl %al,%eax
  8012f0:	29 c2                	sub    %eax,%edx
  8012f2:	89 d0                	mov    %edx,%eax
  8012f4:	eb 18                	jmp    80130e <memcmp+0x50>
		s1++, s2++;
  8012f6:	ff 45 fc             	incl   -0x4(%ebp)
  8012f9:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8012fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ff:	8d 50 ff             	lea    -0x1(%eax),%edx
  801302:	89 55 10             	mov    %edx,0x10(%ebp)
  801305:	85 c0                	test   %eax,%eax
  801307:	75 c9                	jne    8012d2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801309:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80130e:	c9                   	leave  
  80130f:	c3                   	ret    

00801310 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801310:	55                   	push   %ebp
  801311:	89 e5                	mov    %esp,%ebp
  801313:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801316:	8b 55 08             	mov    0x8(%ebp),%edx
  801319:	8b 45 10             	mov    0x10(%ebp),%eax
  80131c:	01 d0                	add    %edx,%eax
  80131e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801321:	eb 15                	jmp    801338 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801323:	8b 45 08             	mov    0x8(%ebp),%eax
  801326:	8a 00                	mov    (%eax),%al
  801328:	0f b6 d0             	movzbl %al,%edx
  80132b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132e:	0f b6 c0             	movzbl %al,%eax
  801331:	39 c2                	cmp    %eax,%edx
  801333:	74 0d                	je     801342 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801335:	ff 45 08             	incl   0x8(%ebp)
  801338:	8b 45 08             	mov    0x8(%ebp),%eax
  80133b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80133e:	72 e3                	jb     801323 <memfind+0x13>
  801340:	eb 01                	jmp    801343 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801342:	90                   	nop
	return (void *) s;
  801343:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801346:	c9                   	leave  
  801347:	c3                   	ret    

00801348 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801348:	55                   	push   %ebp
  801349:	89 e5                	mov    %esp,%ebp
  80134b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80134e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801355:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80135c:	eb 03                	jmp    801361 <strtol+0x19>
		s++;
  80135e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	8a 00                	mov    (%eax),%al
  801366:	3c 20                	cmp    $0x20,%al
  801368:	74 f4                	je     80135e <strtol+0x16>
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	8a 00                	mov    (%eax),%al
  80136f:	3c 09                	cmp    $0x9,%al
  801371:	74 eb                	je     80135e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	8a 00                	mov    (%eax),%al
  801378:	3c 2b                	cmp    $0x2b,%al
  80137a:	75 05                	jne    801381 <strtol+0x39>
		s++;
  80137c:	ff 45 08             	incl   0x8(%ebp)
  80137f:	eb 13                	jmp    801394 <strtol+0x4c>
	else if (*s == '-')
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	8a 00                	mov    (%eax),%al
  801386:	3c 2d                	cmp    $0x2d,%al
  801388:	75 0a                	jne    801394 <strtol+0x4c>
		s++, neg = 1;
  80138a:	ff 45 08             	incl   0x8(%ebp)
  80138d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801394:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801398:	74 06                	je     8013a0 <strtol+0x58>
  80139a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80139e:	75 20                	jne    8013c0 <strtol+0x78>
  8013a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a3:	8a 00                	mov    (%eax),%al
  8013a5:	3c 30                	cmp    $0x30,%al
  8013a7:	75 17                	jne    8013c0 <strtol+0x78>
  8013a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ac:	40                   	inc    %eax
  8013ad:	8a 00                	mov    (%eax),%al
  8013af:	3c 78                	cmp    $0x78,%al
  8013b1:	75 0d                	jne    8013c0 <strtol+0x78>
		s += 2, base = 16;
  8013b3:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013b7:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013be:	eb 28                	jmp    8013e8 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c4:	75 15                	jne    8013db <strtol+0x93>
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	8a 00                	mov    (%eax),%al
  8013cb:	3c 30                	cmp    $0x30,%al
  8013cd:	75 0c                	jne    8013db <strtol+0x93>
		s++, base = 8;
  8013cf:	ff 45 08             	incl   0x8(%ebp)
  8013d2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013d9:	eb 0d                	jmp    8013e8 <strtol+0xa0>
	else if (base == 0)
  8013db:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013df:	75 07                	jne    8013e8 <strtol+0xa0>
		base = 10;
  8013e1:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013eb:	8a 00                	mov    (%eax),%al
  8013ed:	3c 2f                	cmp    $0x2f,%al
  8013ef:	7e 19                	jle    80140a <strtol+0xc2>
  8013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f4:	8a 00                	mov    (%eax),%al
  8013f6:	3c 39                	cmp    $0x39,%al
  8013f8:	7f 10                	jg     80140a <strtol+0xc2>
			dig = *s - '0';
  8013fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fd:	8a 00                	mov    (%eax),%al
  8013ff:	0f be c0             	movsbl %al,%eax
  801402:	83 e8 30             	sub    $0x30,%eax
  801405:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801408:	eb 42                	jmp    80144c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	8a 00                	mov    (%eax),%al
  80140f:	3c 60                	cmp    $0x60,%al
  801411:	7e 19                	jle    80142c <strtol+0xe4>
  801413:	8b 45 08             	mov    0x8(%ebp),%eax
  801416:	8a 00                	mov    (%eax),%al
  801418:	3c 7a                	cmp    $0x7a,%al
  80141a:	7f 10                	jg     80142c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80141c:	8b 45 08             	mov    0x8(%ebp),%eax
  80141f:	8a 00                	mov    (%eax),%al
  801421:	0f be c0             	movsbl %al,%eax
  801424:	83 e8 57             	sub    $0x57,%eax
  801427:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80142a:	eb 20                	jmp    80144c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80142c:	8b 45 08             	mov    0x8(%ebp),%eax
  80142f:	8a 00                	mov    (%eax),%al
  801431:	3c 40                	cmp    $0x40,%al
  801433:	7e 39                	jle    80146e <strtol+0x126>
  801435:	8b 45 08             	mov    0x8(%ebp),%eax
  801438:	8a 00                	mov    (%eax),%al
  80143a:	3c 5a                	cmp    $0x5a,%al
  80143c:	7f 30                	jg     80146e <strtol+0x126>
			dig = *s - 'A' + 10;
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	8a 00                	mov    (%eax),%al
  801443:	0f be c0             	movsbl %al,%eax
  801446:	83 e8 37             	sub    $0x37,%eax
  801449:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80144c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80144f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801452:	7d 19                	jge    80146d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801454:	ff 45 08             	incl   0x8(%ebp)
  801457:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80145a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80145e:	89 c2                	mov    %eax,%edx
  801460:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801463:	01 d0                	add    %edx,%eax
  801465:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801468:	e9 7b ff ff ff       	jmp    8013e8 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80146d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80146e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801472:	74 08                	je     80147c <strtol+0x134>
		*endptr = (char *) s;
  801474:	8b 45 0c             	mov    0xc(%ebp),%eax
  801477:	8b 55 08             	mov    0x8(%ebp),%edx
  80147a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80147c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801480:	74 07                	je     801489 <strtol+0x141>
  801482:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801485:	f7 d8                	neg    %eax
  801487:	eb 03                	jmp    80148c <strtol+0x144>
  801489:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80148c:	c9                   	leave  
  80148d:	c3                   	ret    

0080148e <ltostr>:

void
ltostr(long value, char *str)
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
  801491:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801494:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80149b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014a2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014a6:	79 13                	jns    8014bb <ltostr+0x2d>
	{
		neg = 1;
  8014a8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b2:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014b5:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014b8:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014be:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014c3:	99                   	cltd   
  8014c4:	f7 f9                	idiv   %ecx
  8014c6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014cc:	8d 50 01             	lea    0x1(%eax),%edx
  8014cf:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014d2:	89 c2                	mov    %eax,%edx
  8014d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d7:	01 d0                	add    %edx,%eax
  8014d9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014dc:	83 c2 30             	add    $0x30,%edx
  8014df:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014e1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014e4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014e9:	f7 e9                	imul   %ecx
  8014eb:	c1 fa 02             	sar    $0x2,%edx
  8014ee:	89 c8                	mov    %ecx,%eax
  8014f0:	c1 f8 1f             	sar    $0x1f,%eax
  8014f3:	29 c2                	sub    %eax,%edx
  8014f5:	89 d0                	mov    %edx,%eax
  8014f7:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8014fa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014fd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801502:	f7 e9                	imul   %ecx
  801504:	c1 fa 02             	sar    $0x2,%edx
  801507:	89 c8                	mov    %ecx,%eax
  801509:	c1 f8 1f             	sar    $0x1f,%eax
  80150c:	29 c2                	sub    %eax,%edx
  80150e:	89 d0                	mov    %edx,%eax
  801510:	c1 e0 02             	shl    $0x2,%eax
  801513:	01 d0                	add    %edx,%eax
  801515:	01 c0                	add    %eax,%eax
  801517:	29 c1                	sub    %eax,%ecx
  801519:	89 ca                	mov    %ecx,%edx
  80151b:	85 d2                	test   %edx,%edx
  80151d:	75 9c                	jne    8014bb <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80151f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801526:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801529:	48                   	dec    %eax
  80152a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80152d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801531:	74 3d                	je     801570 <ltostr+0xe2>
		start = 1 ;
  801533:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80153a:	eb 34                	jmp    801570 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80153c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80153f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801542:	01 d0                	add    %edx,%eax
  801544:	8a 00                	mov    (%eax),%al
  801546:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801549:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80154c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154f:	01 c2                	add    %eax,%edx
  801551:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801554:	8b 45 0c             	mov    0xc(%ebp),%eax
  801557:	01 c8                	add    %ecx,%eax
  801559:	8a 00                	mov    (%eax),%al
  80155b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80155d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801560:	8b 45 0c             	mov    0xc(%ebp),%eax
  801563:	01 c2                	add    %eax,%edx
  801565:	8a 45 eb             	mov    -0x15(%ebp),%al
  801568:	88 02                	mov    %al,(%edx)
		start++ ;
  80156a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80156d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801570:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801573:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801576:	7c c4                	jl     80153c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801578:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80157b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157e:	01 d0                	add    %edx,%eax
  801580:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801583:	90                   	nop
  801584:	c9                   	leave  
  801585:	c3                   	ret    

00801586 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801586:	55                   	push   %ebp
  801587:	89 e5                	mov    %esp,%ebp
  801589:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80158c:	ff 75 08             	pushl  0x8(%ebp)
  80158f:	e8 54 fa ff ff       	call   800fe8 <strlen>
  801594:	83 c4 04             	add    $0x4,%esp
  801597:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80159a:	ff 75 0c             	pushl  0xc(%ebp)
  80159d:	e8 46 fa ff ff       	call   800fe8 <strlen>
  8015a2:	83 c4 04             	add    $0x4,%esp
  8015a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015b6:	eb 17                	jmp    8015cf <strcconcat+0x49>
		final[s] = str1[s] ;
  8015b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8015be:	01 c2                	add    %eax,%edx
  8015c0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c6:	01 c8                	add    %ecx,%eax
  8015c8:	8a 00                	mov    (%eax),%al
  8015ca:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015cc:	ff 45 fc             	incl   -0x4(%ebp)
  8015cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015d5:	7c e1                	jl     8015b8 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015d7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015de:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015e5:	eb 1f                	jmp    801606 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ea:	8d 50 01             	lea    0x1(%eax),%edx
  8015ed:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015f0:	89 c2                	mov    %eax,%edx
  8015f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f5:	01 c2                	add    %eax,%edx
  8015f7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015fd:	01 c8                	add    %ecx,%eax
  8015ff:	8a 00                	mov    (%eax),%al
  801601:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801603:	ff 45 f8             	incl   -0x8(%ebp)
  801606:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801609:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80160c:	7c d9                	jl     8015e7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80160e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801611:	8b 45 10             	mov    0x10(%ebp),%eax
  801614:	01 d0                	add    %edx,%eax
  801616:	c6 00 00             	movb   $0x0,(%eax)
}
  801619:	90                   	nop
  80161a:	c9                   	leave  
  80161b:	c3                   	ret    

0080161c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80161c:	55                   	push   %ebp
  80161d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80161f:	8b 45 14             	mov    0x14(%ebp),%eax
  801622:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801628:	8b 45 14             	mov    0x14(%ebp),%eax
  80162b:	8b 00                	mov    (%eax),%eax
  80162d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801634:	8b 45 10             	mov    0x10(%ebp),%eax
  801637:	01 d0                	add    %edx,%eax
  801639:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80163f:	eb 0c                	jmp    80164d <strsplit+0x31>
			*string++ = 0;
  801641:	8b 45 08             	mov    0x8(%ebp),%eax
  801644:	8d 50 01             	lea    0x1(%eax),%edx
  801647:	89 55 08             	mov    %edx,0x8(%ebp)
  80164a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80164d:	8b 45 08             	mov    0x8(%ebp),%eax
  801650:	8a 00                	mov    (%eax),%al
  801652:	84 c0                	test   %al,%al
  801654:	74 18                	je     80166e <strsplit+0x52>
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
  801659:	8a 00                	mov    (%eax),%al
  80165b:	0f be c0             	movsbl %al,%eax
  80165e:	50                   	push   %eax
  80165f:	ff 75 0c             	pushl  0xc(%ebp)
  801662:	e8 13 fb ff ff       	call   80117a <strchr>
  801667:	83 c4 08             	add    $0x8,%esp
  80166a:	85 c0                	test   %eax,%eax
  80166c:	75 d3                	jne    801641 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	8a 00                	mov    (%eax),%al
  801673:	84 c0                	test   %al,%al
  801675:	74 5a                	je     8016d1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801677:	8b 45 14             	mov    0x14(%ebp),%eax
  80167a:	8b 00                	mov    (%eax),%eax
  80167c:	83 f8 0f             	cmp    $0xf,%eax
  80167f:	75 07                	jne    801688 <strsplit+0x6c>
		{
			return 0;
  801681:	b8 00 00 00 00       	mov    $0x0,%eax
  801686:	eb 66                	jmp    8016ee <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801688:	8b 45 14             	mov    0x14(%ebp),%eax
  80168b:	8b 00                	mov    (%eax),%eax
  80168d:	8d 48 01             	lea    0x1(%eax),%ecx
  801690:	8b 55 14             	mov    0x14(%ebp),%edx
  801693:	89 0a                	mov    %ecx,(%edx)
  801695:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80169c:	8b 45 10             	mov    0x10(%ebp),%eax
  80169f:	01 c2                	add    %eax,%edx
  8016a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016a6:	eb 03                	jmp    8016ab <strsplit+0x8f>
			string++;
  8016a8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ae:	8a 00                	mov    (%eax),%al
  8016b0:	84 c0                	test   %al,%al
  8016b2:	74 8b                	je     80163f <strsplit+0x23>
  8016b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b7:	8a 00                	mov    (%eax),%al
  8016b9:	0f be c0             	movsbl %al,%eax
  8016bc:	50                   	push   %eax
  8016bd:	ff 75 0c             	pushl  0xc(%ebp)
  8016c0:	e8 b5 fa ff ff       	call   80117a <strchr>
  8016c5:	83 c4 08             	add    $0x8,%esp
  8016c8:	85 c0                	test   %eax,%eax
  8016ca:	74 dc                	je     8016a8 <strsplit+0x8c>
			string++;
	}
  8016cc:	e9 6e ff ff ff       	jmp    80163f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016d1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8016d5:	8b 00                	mov    (%eax),%eax
  8016d7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016de:	8b 45 10             	mov    0x10(%ebp),%eax
  8016e1:	01 d0                	add    %edx,%eax
  8016e3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016e9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016ee:	c9                   	leave  
  8016ef:	c3                   	ret    

008016f0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
  8016f3:	57                   	push   %edi
  8016f4:	56                   	push   %esi
  8016f5:	53                   	push   %ebx
  8016f6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ff:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801702:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801705:	8b 7d 18             	mov    0x18(%ebp),%edi
  801708:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80170b:	cd 30                	int    $0x30
  80170d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801710:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801713:	83 c4 10             	add    $0x10,%esp
  801716:	5b                   	pop    %ebx
  801717:	5e                   	pop    %esi
  801718:	5f                   	pop    %edi
  801719:	5d                   	pop    %ebp
  80171a:	c3                   	ret    

0080171b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80171b:	55                   	push   %ebp
  80171c:	89 e5                	mov    %esp,%ebp
  80171e:	83 ec 04             	sub    $0x4,%esp
  801721:	8b 45 10             	mov    0x10(%ebp),%eax
  801724:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801727:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80172b:	8b 45 08             	mov    0x8(%ebp),%eax
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	52                   	push   %edx
  801733:	ff 75 0c             	pushl  0xc(%ebp)
  801736:	50                   	push   %eax
  801737:	6a 00                	push   $0x0
  801739:	e8 b2 ff ff ff       	call   8016f0 <syscall>
  80173e:	83 c4 18             	add    $0x18,%esp
}
  801741:	90                   	nop
  801742:	c9                   	leave  
  801743:	c3                   	ret    

00801744 <sys_cgetc>:

int
sys_cgetc(void)
{
  801744:	55                   	push   %ebp
  801745:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 01                	push   $0x1
  801753:	e8 98 ff ff ff       	call   8016f0 <syscall>
  801758:	83 c4 18             	add    $0x18,%esp
}
  80175b:	c9                   	leave  
  80175c:	c3                   	ret    

0080175d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80175d:	55                   	push   %ebp
  80175e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801760:	8b 45 08             	mov    0x8(%ebp),%eax
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	50                   	push   %eax
  80176c:	6a 05                	push   $0x5
  80176e:	e8 7d ff ff ff       	call   8016f0 <syscall>
  801773:	83 c4 18             	add    $0x18,%esp
}
  801776:	c9                   	leave  
  801777:	c3                   	ret    

00801778 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 02                	push   $0x2
  801787:	e8 64 ff ff ff       	call   8016f0 <syscall>
  80178c:	83 c4 18             	add    $0x18,%esp
}
  80178f:	c9                   	leave  
  801790:	c3                   	ret    

00801791 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 03                	push   $0x3
  8017a0:	e8 4b ff ff ff       	call   8016f0 <syscall>
  8017a5:	83 c4 18             	add    $0x18,%esp
}
  8017a8:	c9                   	leave  
  8017a9:	c3                   	ret    

008017aa <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017aa:	55                   	push   %ebp
  8017ab:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 04                	push   $0x4
  8017b9:	e8 32 ff ff ff       	call   8016f0 <syscall>
  8017be:	83 c4 18             	add    $0x18,%esp
}
  8017c1:	c9                   	leave  
  8017c2:	c3                   	ret    

008017c3 <sys_env_exit>:


void sys_env_exit(void)
{
  8017c3:	55                   	push   %ebp
  8017c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 06                	push   $0x6
  8017d2:	e8 19 ff ff ff       	call   8016f0 <syscall>
  8017d7:	83 c4 18             	add    $0x18,%esp
}
  8017da:	90                   	nop
  8017db:	c9                   	leave  
  8017dc:	c3                   	ret    

008017dd <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017dd:	55                   	push   %ebp
  8017de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	52                   	push   %edx
  8017ed:	50                   	push   %eax
  8017ee:	6a 07                	push   $0x7
  8017f0:	e8 fb fe ff ff       	call   8016f0 <syscall>
  8017f5:	83 c4 18             	add    $0x18,%esp
}
  8017f8:	c9                   	leave  
  8017f9:	c3                   	ret    

008017fa <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017fa:	55                   	push   %ebp
  8017fb:	89 e5                	mov    %esp,%ebp
  8017fd:	56                   	push   %esi
  8017fe:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017ff:	8b 75 18             	mov    0x18(%ebp),%esi
  801802:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801805:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801808:	8b 55 0c             	mov    0xc(%ebp),%edx
  80180b:	8b 45 08             	mov    0x8(%ebp),%eax
  80180e:	56                   	push   %esi
  80180f:	53                   	push   %ebx
  801810:	51                   	push   %ecx
  801811:	52                   	push   %edx
  801812:	50                   	push   %eax
  801813:	6a 08                	push   $0x8
  801815:	e8 d6 fe ff ff       	call   8016f0 <syscall>
  80181a:	83 c4 18             	add    $0x18,%esp
}
  80181d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801820:	5b                   	pop    %ebx
  801821:	5e                   	pop    %esi
  801822:	5d                   	pop    %ebp
  801823:	c3                   	ret    

00801824 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801824:	55                   	push   %ebp
  801825:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801827:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182a:	8b 45 08             	mov    0x8(%ebp),%eax
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	52                   	push   %edx
  801834:	50                   	push   %eax
  801835:	6a 09                	push   $0x9
  801837:	e8 b4 fe ff ff       	call   8016f0 <syscall>
  80183c:	83 c4 18             	add    $0x18,%esp
}
  80183f:	c9                   	leave  
  801840:	c3                   	ret    

00801841 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801841:	55                   	push   %ebp
  801842:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	ff 75 0c             	pushl  0xc(%ebp)
  80184d:	ff 75 08             	pushl  0x8(%ebp)
  801850:	6a 0a                	push   $0xa
  801852:	e8 99 fe ff ff       	call   8016f0 <syscall>
  801857:	83 c4 18             	add    $0x18,%esp
}
  80185a:	c9                   	leave  
  80185b:	c3                   	ret    

0080185c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80185c:	55                   	push   %ebp
  80185d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	6a 0b                	push   $0xb
  80186b:	e8 80 fe ff ff       	call   8016f0 <syscall>
  801870:	83 c4 18             	add    $0x18,%esp
}
  801873:	c9                   	leave  
  801874:	c3                   	ret    

00801875 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801875:	55                   	push   %ebp
  801876:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801878:	6a 00                	push   $0x0
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 0c                	push   $0xc
  801884:	e8 67 fe ff ff       	call   8016f0 <syscall>
  801889:	83 c4 18             	add    $0x18,%esp
}
  80188c:	c9                   	leave  
  80188d:	c3                   	ret    

0080188e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80188e:	55                   	push   %ebp
  80188f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 0d                	push   $0xd
  80189d:	e8 4e fe ff ff       	call   8016f0 <syscall>
  8018a2:	83 c4 18             	add    $0x18,%esp
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	ff 75 0c             	pushl  0xc(%ebp)
  8018b3:	ff 75 08             	pushl  0x8(%ebp)
  8018b6:	6a 11                	push   $0x11
  8018b8:	e8 33 fe ff ff       	call   8016f0 <syscall>
  8018bd:	83 c4 18             	add    $0x18,%esp
	return;
  8018c0:	90                   	nop
}
  8018c1:	c9                   	leave  
  8018c2:	c3                   	ret    

008018c3 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018c3:	55                   	push   %ebp
  8018c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	ff 75 0c             	pushl  0xc(%ebp)
  8018cf:	ff 75 08             	pushl  0x8(%ebp)
  8018d2:	6a 12                	push   $0x12
  8018d4:	e8 17 fe ff ff       	call   8016f0 <syscall>
  8018d9:	83 c4 18             	add    $0x18,%esp
	return ;
  8018dc:	90                   	nop
}
  8018dd:	c9                   	leave  
  8018de:	c3                   	ret    

008018df <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018df:	55                   	push   %ebp
  8018e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 0e                	push   $0xe
  8018ee:	e8 fd fd ff ff       	call   8016f0 <syscall>
  8018f3:	83 c4 18             	add    $0x18,%esp
}
  8018f6:	c9                   	leave  
  8018f7:	c3                   	ret    

008018f8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018f8:	55                   	push   %ebp
  8018f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	ff 75 08             	pushl  0x8(%ebp)
  801906:	6a 0f                	push   $0xf
  801908:	e8 e3 fd ff ff       	call   8016f0 <syscall>
  80190d:	83 c4 18             	add    $0x18,%esp
}
  801910:	c9                   	leave  
  801911:	c3                   	ret    

00801912 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801912:	55                   	push   %ebp
  801913:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	6a 10                	push   $0x10
  801921:	e8 ca fd ff ff       	call   8016f0 <syscall>
  801926:	83 c4 18             	add    $0x18,%esp
}
  801929:	90                   	nop
  80192a:	c9                   	leave  
  80192b:	c3                   	ret    

0080192c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80192c:	55                   	push   %ebp
  80192d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 14                	push   $0x14
  80193b:	e8 b0 fd ff ff       	call   8016f0 <syscall>
  801940:	83 c4 18             	add    $0x18,%esp
}
  801943:	90                   	nop
  801944:	c9                   	leave  
  801945:	c3                   	ret    

00801946 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801946:	55                   	push   %ebp
  801947:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 15                	push   $0x15
  801955:	e8 96 fd ff ff       	call   8016f0 <syscall>
  80195a:	83 c4 18             	add    $0x18,%esp
}
  80195d:	90                   	nop
  80195e:	c9                   	leave  
  80195f:	c3                   	ret    

00801960 <sys_cputc>:


void
sys_cputc(const char c)
{
  801960:	55                   	push   %ebp
  801961:	89 e5                	mov    %esp,%ebp
  801963:	83 ec 04             	sub    $0x4,%esp
  801966:	8b 45 08             	mov    0x8(%ebp),%eax
  801969:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80196c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	50                   	push   %eax
  801979:	6a 16                	push   $0x16
  80197b:	e8 70 fd ff ff       	call   8016f0 <syscall>
  801980:	83 c4 18             	add    $0x18,%esp
}
  801983:	90                   	nop
  801984:	c9                   	leave  
  801985:	c3                   	ret    

00801986 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801986:	55                   	push   %ebp
  801987:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 17                	push   $0x17
  801995:	e8 56 fd ff ff       	call   8016f0 <syscall>
  80199a:	83 c4 18             	add    $0x18,%esp
}
  80199d:	90                   	nop
  80199e:	c9                   	leave  
  80199f:	c3                   	ret    

008019a0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019a0:	55                   	push   %ebp
  8019a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 00                	push   $0x0
  8019ac:	ff 75 0c             	pushl  0xc(%ebp)
  8019af:	50                   	push   %eax
  8019b0:	6a 18                	push   $0x18
  8019b2:	e8 39 fd ff ff       	call   8016f0 <syscall>
  8019b7:	83 c4 18             	add    $0x18,%esp
}
  8019ba:	c9                   	leave  
  8019bb:	c3                   	ret    

008019bc <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019bc:	55                   	push   %ebp
  8019bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	52                   	push   %edx
  8019cc:	50                   	push   %eax
  8019cd:	6a 1b                	push   $0x1b
  8019cf:	e8 1c fd ff ff       	call   8016f0 <syscall>
  8019d4:	83 c4 18             	add    $0x18,%esp
}
  8019d7:	c9                   	leave  
  8019d8:	c3                   	ret    

008019d9 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019d9:	55                   	push   %ebp
  8019da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019df:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 00                	push   $0x0
  8019e8:	52                   	push   %edx
  8019e9:	50                   	push   %eax
  8019ea:	6a 19                	push   $0x19
  8019ec:	e8 ff fc ff ff       	call   8016f0 <syscall>
  8019f1:	83 c4 18             	add    $0x18,%esp
}
  8019f4:	90                   	nop
  8019f5:	c9                   	leave  
  8019f6:	c3                   	ret    

008019f7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019f7:	55                   	push   %ebp
  8019f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	52                   	push   %edx
  801a07:	50                   	push   %eax
  801a08:	6a 1a                	push   $0x1a
  801a0a:	e8 e1 fc ff ff       	call   8016f0 <syscall>
  801a0f:	83 c4 18             	add    $0x18,%esp
}
  801a12:	90                   	nop
  801a13:	c9                   	leave  
  801a14:	c3                   	ret    

00801a15 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a15:	55                   	push   %ebp
  801a16:	89 e5                	mov    %esp,%ebp
  801a18:	83 ec 04             	sub    $0x4,%esp
  801a1b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a1e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a21:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a24:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a28:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2b:	6a 00                	push   $0x0
  801a2d:	51                   	push   %ecx
  801a2e:	52                   	push   %edx
  801a2f:	ff 75 0c             	pushl  0xc(%ebp)
  801a32:	50                   	push   %eax
  801a33:	6a 1c                	push   $0x1c
  801a35:	e8 b6 fc ff ff       	call   8016f0 <syscall>
  801a3a:	83 c4 18             	add    $0x18,%esp
}
  801a3d:	c9                   	leave  
  801a3e:	c3                   	ret    

00801a3f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a3f:	55                   	push   %ebp
  801a40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a42:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a45:	8b 45 08             	mov    0x8(%ebp),%eax
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	52                   	push   %edx
  801a4f:	50                   	push   %eax
  801a50:	6a 1d                	push   $0x1d
  801a52:	e8 99 fc ff ff       	call   8016f0 <syscall>
  801a57:	83 c4 18             	add    $0x18,%esp
}
  801a5a:	c9                   	leave  
  801a5b:	c3                   	ret    

00801a5c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a5c:	55                   	push   %ebp
  801a5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a5f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a62:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a65:	8b 45 08             	mov    0x8(%ebp),%eax
  801a68:	6a 00                	push   $0x0
  801a6a:	6a 00                	push   $0x0
  801a6c:	51                   	push   %ecx
  801a6d:	52                   	push   %edx
  801a6e:	50                   	push   %eax
  801a6f:	6a 1e                	push   $0x1e
  801a71:	e8 7a fc ff ff       	call   8016f0 <syscall>
  801a76:	83 c4 18             	add    $0x18,%esp
}
  801a79:	c9                   	leave  
  801a7a:	c3                   	ret    

00801a7b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a7b:	55                   	push   %ebp
  801a7c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a7e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a81:	8b 45 08             	mov    0x8(%ebp),%eax
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	52                   	push   %edx
  801a8b:	50                   	push   %eax
  801a8c:	6a 1f                	push   $0x1f
  801a8e:	e8 5d fc ff ff       	call   8016f0 <syscall>
  801a93:	83 c4 18             	add    $0x18,%esp
}
  801a96:	c9                   	leave  
  801a97:	c3                   	ret    

00801a98 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a98:	55                   	push   %ebp
  801a99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 20                	push   $0x20
  801aa7:	e8 44 fc ff ff       	call   8016f0 <syscall>
  801aac:	83 c4 18             	add    $0x18,%esp
}
  801aaf:	c9                   	leave  
  801ab0:	c3                   	ret    

00801ab1 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801ab1:	55                   	push   %ebp
  801ab2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	ff 75 10             	pushl  0x10(%ebp)
  801abe:	ff 75 0c             	pushl  0xc(%ebp)
  801ac1:	50                   	push   %eax
  801ac2:	6a 21                	push   $0x21
  801ac4:	e8 27 fc ff ff       	call   8016f0 <syscall>
  801ac9:	83 c4 18             	add    $0x18,%esp
}
  801acc:	c9                   	leave  
  801acd:	c3                   	ret    

00801ace <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ace:	55                   	push   %ebp
  801acf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad4:	6a 00                	push   $0x0
  801ad6:	6a 00                	push   $0x0
  801ad8:	6a 00                	push   $0x0
  801ada:	6a 00                	push   $0x0
  801adc:	50                   	push   %eax
  801add:	6a 22                	push   $0x22
  801adf:	e8 0c fc ff ff       	call   8016f0 <syscall>
  801ae4:	83 c4 18             	add    $0x18,%esp
}
  801ae7:	90                   	nop
  801ae8:	c9                   	leave  
  801ae9:	c3                   	ret    

00801aea <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801aea:	55                   	push   %ebp
  801aeb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801aed:	8b 45 08             	mov    0x8(%ebp),%eax
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	50                   	push   %eax
  801af9:	6a 23                	push   $0x23
  801afb:	e8 f0 fb ff ff       	call   8016f0 <syscall>
  801b00:	83 c4 18             	add    $0x18,%esp
}
  801b03:	90                   	nop
  801b04:	c9                   	leave  
  801b05:	c3                   	ret    

00801b06 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b06:	55                   	push   %ebp
  801b07:	89 e5                	mov    %esp,%ebp
  801b09:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b0c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b0f:	8d 50 04             	lea    0x4(%eax),%edx
  801b12:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	52                   	push   %edx
  801b1c:	50                   	push   %eax
  801b1d:	6a 24                	push   $0x24
  801b1f:	e8 cc fb ff ff       	call   8016f0 <syscall>
  801b24:	83 c4 18             	add    $0x18,%esp
	return result;
  801b27:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b2d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b30:	89 01                	mov    %eax,(%ecx)
  801b32:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b35:	8b 45 08             	mov    0x8(%ebp),%eax
  801b38:	c9                   	leave  
  801b39:	c2 04 00             	ret    $0x4

00801b3c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b3c:	55                   	push   %ebp
  801b3d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	ff 75 10             	pushl  0x10(%ebp)
  801b46:	ff 75 0c             	pushl  0xc(%ebp)
  801b49:	ff 75 08             	pushl  0x8(%ebp)
  801b4c:	6a 13                	push   $0x13
  801b4e:	e8 9d fb ff ff       	call   8016f0 <syscall>
  801b53:	83 c4 18             	add    $0x18,%esp
	return ;
  801b56:	90                   	nop
}
  801b57:	c9                   	leave  
  801b58:	c3                   	ret    

00801b59 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b59:	55                   	push   %ebp
  801b5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	6a 25                	push   $0x25
  801b68:	e8 83 fb ff ff       	call   8016f0 <syscall>
  801b6d:	83 c4 18             	add    $0x18,%esp
}
  801b70:	c9                   	leave  
  801b71:	c3                   	ret    

00801b72 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
  801b75:	83 ec 04             	sub    $0x4,%esp
  801b78:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b7e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	50                   	push   %eax
  801b8b:	6a 26                	push   $0x26
  801b8d:	e8 5e fb ff ff       	call   8016f0 <syscall>
  801b92:	83 c4 18             	add    $0x18,%esp
	return ;
  801b95:	90                   	nop
}
  801b96:	c9                   	leave  
  801b97:	c3                   	ret    

00801b98 <rsttst>:
void rsttst()
{
  801b98:	55                   	push   %ebp
  801b99:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 00                	push   $0x0
  801ba3:	6a 00                	push   $0x0
  801ba5:	6a 28                	push   $0x28
  801ba7:	e8 44 fb ff ff       	call   8016f0 <syscall>
  801bac:	83 c4 18             	add    $0x18,%esp
	return ;
  801baf:	90                   	nop
}
  801bb0:	c9                   	leave  
  801bb1:	c3                   	ret    

00801bb2 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bb2:	55                   	push   %ebp
  801bb3:	89 e5                	mov    %esp,%ebp
  801bb5:	83 ec 04             	sub    $0x4,%esp
  801bb8:	8b 45 14             	mov    0x14(%ebp),%eax
  801bbb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bbe:	8b 55 18             	mov    0x18(%ebp),%edx
  801bc1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bc5:	52                   	push   %edx
  801bc6:	50                   	push   %eax
  801bc7:	ff 75 10             	pushl  0x10(%ebp)
  801bca:	ff 75 0c             	pushl  0xc(%ebp)
  801bcd:	ff 75 08             	pushl  0x8(%ebp)
  801bd0:	6a 27                	push   $0x27
  801bd2:	e8 19 fb ff ff       	call   8016f0 <syscall>
  801bd7:	83 c4 18             	add    $0x18,%esp
	return ;
  801bda:	90                   	nop
}
  801bdb:	c9                   	leave  
  801bdc:	c3                   	ret    

00801bdd <chktst>:
void chktst(uint32 n)
{
  801bdd:	55                   	push   %ebp
  801bde:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	ff 75 08             	pushl  0x8(%ebp)
  801beb:	6a 29                	push   $0x29
  801bed:	e8 fe fa ff ff       	call   8016f0 <syscall>
  801bf2:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf5:	90                   	nop
}
  801bf6:	c9                   	leave  
  801bf7:	c3                   	ret    

00801bf8 <inctst>:

void inctst()
{
  801bf8:	55                   	push   %ebp
  801bf9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	6a 2a                	push   $0x2a
  801c07:	e8 e4 fa ff ff       	call   8016f0 <syscall>
  801c0c:	83 c4 18             	add    $0x18,%esp
	return ;
  801c0f:	90                   	nop
}
  801c10:	c9                   	leave  
  801c11:	c3                   	ret    

00801c12 <gettst>:
uint32 gettst()
{
  801c12:	55                   	push   %ebp
  801c13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 2b                	push   $0x2b
  801c21:	e8 ca fa ff ff       	call   8016f0 <syscall>
  801c26:	83 c4 18             	add    $0x18,%esp
}
  801c29:	c9                   	leave  
  801c2a:	c3                   	ret    

00801c2b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c2b:	55                   	push   %ebp
  801c2c:	89 e5                	mov    %esp,%ebp
  801c2e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 2c                	push   $0x2c
  801c3d:	e8 ae fa ff ff       	call   8016f0 <syscall>
  801c42:	83 c4 18             	add    $0x18,%esp
  801c45:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c48:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c4c:	75 07                	jne    801c55 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c4e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c53:	eb 05                	jmp    801c5a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c55:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c5a:	c9                   	leave  
  801c5b:	c3                   	ret    

00801c5c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c5c:	55                   	push   %ebp
  801c5d:	89 e5                	mov    %esp,%ebp
  801c5f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 2c                	push   $0x2c
  801c6e:	e8 7d fa ff ff       	call   8016f0 <syscall>
  801c73:	83 c4 18             	add    $0x18,%esp
  801c76:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c79:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c7d:	75 07                	jne    801c86 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c7f:	b8 01 00 00 00       	mov    $0x1,%eax
  801c84:	eb 05                	jmp    801c8b <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c86:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c8b:	c9                   	leave  
  801c8c:	c3                   	ret    

00801c8d <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c8d:	55                   	push   %ebp
  801c8e:	89 e5                	mov    %esp,%ebp
  801c90:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 2c                	push   $0x2c
  801c9f:	e8 4c fa ff ff       	call   8016f0 <syscall>
  801ca4:	83 c4 18             	add    $0x18,%esp
  801ca7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801caa:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cae:	75 07                	jne    801cb7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cb0:	b8 01 00 00 00       	mov    $0x1,%eax
  801cb5:	eb 05                	jmp    801cbc <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cb7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cbc:	c9                   	leave  
  801cbd:	c3                   	ret    

00801cbe <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cbe:	55                   	push   %ebp
  801cbf:	89 e5                	mov    %esp,%ebp
  801cc1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 2c                	push   $0x2c
  801cd0:	e8 1b fa ff ff       	call   8016f0 <syscall>
  801cd5:	83 c4 18             	add    $0x18,%esp
  801cd8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cdb:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cdf:	75 07                	jne    801ce8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ce1:	b8 01 00 00 00       	mov    $0x1,%eax
  801ce6:	eb 05                	jmp    801ced <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ce8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ced:	c9                   	leave  
  801cee:	c3                   	ret    

00801cef <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801cef:	55                   	push   %ebp
  801cf0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	ff 75 08             	pushl  0x8(%ebp)
  801cfd:	6a 2d                	push   $0x2d
  801cff:	e8 ec f9 ff ff       	call   8016f0 <syscall>
  801d04:	83 c4 18             	add    $0x18,%esp
	return ;
  801d07:	90                   	nop
}
  801d08:	c9                   	leave  
  801d09:	c3                   	ret    
  801d0a:	66 90                	xchg   %ax,%ax

00801d0c <__udivdi3>:
  801d0c:	55                   	push   %ebp
  801d0d:	57                   	push   %edi
  801d0e:	56                   	push   %esi
  801d0f:	53                   	push   %ebx
  801d10:	83 ec 1c             	sub    $0x1c,%esp
  801d13:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d17:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d1f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d23:	89 ca                	mov    %ecx,%edx
  801d25:	89 f8                	mov    %edi,%eax
  801d27:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d2b:	85 f6                	test   %esi,%esi
  801d2d:	75 2d                	jne    801d5c <__udivdi3+0x50>
  801d2f:	39 cf                	cmp    %ecx,%edi
  801d31:	77 65                	ja     801d98 <__udivdi3+0x8c>
  801d33:	89 fd                	mov    %edi,%ebp
  801d35:	85 ff                	test   %edi,%edi
  801d37:	75 0b                	jne    801d44 <__udivdi3+0x38>
  801d39:	b8 01 00 00 00       	mov    $0x1,%eax
  801d3e:	31 d2                	xor    %edx,%edx
  801d40:	f7 f7                	div    %edi
  801d42:	89 c5                	mov    %eax,%ebp
  801d44:	31 d2                	xor    %edx,%edx
  801d46:	89 c8                	mov    %ecx,%eax
  801d48:	f7 f5                	div    %ebp
  801d4a:	89 c1                	mov    %eax,%ecx
  801d4c:	89 d8                	mov    %ebx,%eax
  801d4e:	f7 f5                	div    %ebp
  801d50:	89 cf                	mov    %ecx,%edi
  801d52:	89 fa                	mov    %edi,%edx
  801d54:	83 c4 1c             	add    $0x1c,%esp
  801d57:	5b                   	pop    %ebx
  801d58:	5e                   	pop    %esi
  801d59:	5f                   	pop    %edi
  801d5a:	5d                   	pop    %ebp
  801d5b:	c3                   	ret    
  801d5c:	39 ce                	cmp    %ecx,%esi
  801d5e:	77 28                	ja     801d88 <__udivdi3+0x7c>
  801d60:	0f bd fe             	bsr    %esi,%edi
  801d63:	83 f7 1f             	xor    $0x1f,%edi
  801d66:	75 40                	jne    801da8 <__udivdi3+0x9c>
  801d68:	39 ce                	cmp    %ecx,%esi
  801d6a:	72 0a                	jb     801d76 <__udivdi3+0x6a>
  801d6c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d70:	0f 87 9e 00 00 00    	ja     801e14 <__udivdi3+0x108>
  801d76:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7b:	89 fa                	mov    %edi,%edx
  801d7d:	83 c4 1c             	add    $0x1c,%esp
  801d80:	5b                   	pop    %ebx
  801d81:	5e                   	pop    %esi
  801d82:	5f                   	pop    %edi
  801d83:	5d                   	pop    %ebp
  801d84:	c3                   	ret    
  801d85:	8d 76 00             	lea    0x0(%esi),%esi
  801d88:	31 ff                	xor    %edi,%edi
  801d8a:	31 c0                	xor    %eax,%eax
  801d8c:	89 fa                	mov    %edi,%edx
  801d8e:	83 c4 1c             	add    $0x1c,%esp
  801d91:	5b                   	pop    %ebx
  801d92:	5e                   	pop    %esi
  801d93:	5f                   	pop    %edi
  801d94:	5d                   	pop    %ebp
  801d95:	c3                   	ret    
  801d96:	66 90                	xchg   %ax,%ax
  801d98:	89 d8                	mov    %ebx,%eax
  801d9a:	f7 f7                	div    %edi
  801d9c:	31 ff                	xor    %edi,%edi
  801d9e:	89 fa                	mov    %edi,%edx
  801da0:	83 c4 1c             	add    $0x1c,%esp
  801da3:	5b                   	pop    %ebx
  801da4:	5e                   	pop    %esi
  801da5:	5f                   	pop    %edi
  801da6:	5d                   	pop    %ebp
  801da7:	c3                   	ret    
  801da8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801dad:	89 eb                	mov    %ebp,%ebx
  801daf:	29 fb                	sub    %edi,%ebx
  801db1:	89 f9                	mov    %edi,%ecx
  801db3:	d3 e6                	shl    %cl,%esi
  801db5:	89 c5                	mov    %eax,%ebp
  801db7:	88 d9                	mov    %bl,%cl
  801db9:	d3 ed                	shr    %cl,%ebp
  801dbb:	89 e9                	mov    %ebp,%ecx
  801dbd:	09 f1                	or     %esi,%ecx
  801dbf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801dc3:	89 f9                	mov    %edi,%ecx
  801dc5:	d3 e0                	shl    %cl,%eax
  801dc7:	89 c5                	mov    %eax,%ebp
  801dc9:	89 d6                	mov    %edx,%esi
  801dcb:	88 d9                	mov    %bl,%cl
  801dcd:	d3 ee                	shr    %cl,%esi
  801dcf:	89 f9                	mov    %edi,%ecx
  801dd1:	d3 e2                	shl    %cl,%edx
  801dd3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dd7:	88 d9                	mov    %bl,%cl
  801dd9:	d3 e8                	shr    %cl,%eax
  801ddb:	09 c2                	or     %eax,%edx
  801ddd:	89 d0                	mov    %edx,%eax
  801ddf:	89 f2                	mov    %esi,%edx
  801de1:	f7 74 24 0c          	divl   0xc(%esp)
  801de5:	89 d6                	mov    %edx,%esi
  801de7:	89 c3                	mov    %eax,%ebx
  801de9:	f7 e5                	mul    %ebp
  801deb:	39 d6                	cmp    %edx,%esi
  801ded:	72 19                	jb     801e08 <__udivdi3+0xfc>
  801def:	74 0b                	je     801dfc <__udivdi3+0xf0>
  801df1:	89 d8                	mov    %ebx,%eax
  801df3:	31 ff                	xor    %edi,%edi
  801df5:	e9 58 ff ff ff       	jmp    801d52 <__udivdi3+0x46>
  801dfa:	66 90                	xchg   %ax,%ax
  801dfc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e00:	89 f9                	mov    %edi,%ecx
  801e02:	d3 e2                	shl    %cl,%edx
  801e04:	39 c2                	cmp    %eax,%edx
  801e06:	73 e9                	jae    801df1 <__udivdi3+0xe5>
  801e08:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e0b:	31 ff                	xor    %edi,%edi
  801e0d:	e9 40 ff ff ff       	jmp    801d52 <__udivdi3+0x46>
  801e12:	66 90                	xchg   %ax,%ax
  801e14:	31 c0                	xor    %eax,%eax
  801e16:	e9 37 ff ff ff       	jmp    801d52 <__udivdi3+0x46>
  801e1b:	90                   	nop

00801e1c <__umoddi3>:
  801e1c:	55                   	push   %ebp
  801e1d:	57                   	push   %edi
  801e1e:	56                   	push   %esi
  801e1f:	53                   	push   %ebx
  801e20:	83 ec 1c             	sub    $0x1c,%esp
  801e23:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e27:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e2b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e2f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e33:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e37:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e3b:	89 f3                	mov    %esi,%ebx
  801e3d:	89 fa                	mov    %edi,%edx
  801e3f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e43:	89 34 24             	mov    %esi,(%esp)
  801e46:	85 c0                	test   %eax,%eax
  801e48:	75 1a                	jne    801e64 <__umoddi3+0x48>
  801e4a:	39 f7                	cmp    %esi,%edi
  801e4c:	0f 86 a2 00 00 00    	jbe    801ef4 <__umoddi3+0xd8>
  801e52:	89 c8                	mov    %ecx,%eax
  801e54:	89 f2                	mov    %esi,%edx
  801e56:	f7 f7                	div    %edi
  801e58:	89 d0                	mov    %edx,%eax
  801e5a:	31 d2                	xor    %edx,%edx
  801e5c:	83 c4 1c             	add    $0x1c,%esp
  801e5f:	5b                   	pop    %ebx
  801e60:	5e                   	pop    %esi
  801e61:	5f                   	pop    %edi
  801e62:	5d                   	pop    %ebp
  801e63:	c3                   	ret    
  801e64:	39 f0                	cmp    %esi,%eax
  801e66:	0f 87 ac 00 00 00    	ja     801f18 <__umoddi3+0xfc>
  801e6c:	0f bd e8             	bsr    %eax,%ebp
  801e6f:	83 f5 1f             	xor    $0x1f,%ebp
  801e72:	0f 84 ac 00 00 00    	je     801f24 <__umoddi3+0x108>
  801e78:	bf 20 00 00 00       	mov    $0x20,%edi
  801e7d:	29 ef                	sub    %ebp,%edi
  801e7f:	89 fe                	mov    %edi,%esi
  801e81:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e85:	89 e9                	mov    %ebp,%ecx
  801e87:	d3 e0                	shl    %cl,%eax
  801e89:	89 d7                	mov    %edx,%edi
  801e8b:	89 f1                	mov    %esi,%ecx
  801e8d:	d3 ef                	shr    %cl,%edi
  801e8f:	09 c7                	or     %eax,%edi
  801e91:	89 e9                	mov    %ebp,%ecx
  801e93:	d3 e2                	shl    %cl,%edx
  801e95:	89 14 24             	mov    %edx,(%esp)
  801e98:	89 d8                	mov    %ebx,%eax
  801e9a:	d3 e0                	shl    %cl,%eax
  801e9c:	89 c2                	mov    %eax,%edx
  801e9e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ea2:	d3 e0                	shl    %cl,%eax
  801ea4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ea8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eac:	89 f1                	mov    %esi,%ecx
  801eae:	d3 e8                	shr    %cl,%eax
  801eb0:	09 d0                	or     %edx,%eax
  801eb2:	d3 eb                	shr    %cl,%ebx
  801eb4:	89 da                	mov    %ebx,%edx
  801eb6:	f7 f7                	div    %edi
  801eb8:	89 d3                	mov    %edx,%ebx
  801eba:	f7 24 24             	mull   (%esp)
  801ebd:	89 c6                	mov    %eax,%esi
  801ebf:	89 d1                	mov    %edx,%ecx
  801ec1:	39 d3                	cmp    %edx,%ebx
  801ec3:	0f 82 87 00 00 00    	jb     801f50 <__umoddi3+0x134>
  801ec9:	0f 84 91 00 00 00    	je     801f60 <__umoddi3+0x144>
  801ecf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ed3:	29 f2                	sub    %esi,%edx
  801ed5:	19 cb                	sbb    %ecx,%ebx
  801ed7:	89 d8                	mov    %ebx,%eax
  801ed9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801edd:	d3 e0                	shl    %cl,%eax
  801edf:	89 e9                	mov    %ebp,%ecx
  801ee1:	d3 ea                	shr    %cl,%edx
  801ee3:	09 d0                	or     %edx,%eax
  801ee5:	89 e9                	mov    %ebp,%ecx
  801ee7:	d3 eb                	shr    %cl,%ebx
  801ee9:	89 da                	mov    %ebx,%edx
  801eeb:	83 c4 1c             	add    $0x1c,%esp
  801eee:	5b                   	pop    %ebx
  801eef:	5e                   	pop    %esi
  801ef0:	5f                   	pop    %edi
  801ef1:	5d                   	pop    %ebp
  801ef2:	c3                   	ret    
  801ef3:	90                   	nop
  801ef4:	89 fd                	mov    %edi,%ebp
  801ef6:	85 ff                	test   %edi,%edi
  801ef8:	75 0b                	jne    801f05 <__umoddi3+0xe9>
  801efa:	b8 01 00 00 00       	mov    $0x1,%eax
  801eff:	31 d2                	xor    %edx,%edx
  801f01:	f7 f7                	div    %edi
  801f03:	89 c5                	mov    %eax,%ebp
  801f05:	89 f0                	mov    %esi,%eax
  801f07:	31 d2                	xor    %edx,%edx
  801f09:	f7 f5                	div    %ebp
  801f0b:	89 c8                	mov    %ecx,%eax
  801f0d:	f7 f5                	div    %ebp
  801f0f:	89 d0                	mov    %edx,%eax
  801f11:	e9 44 ff ff ff       	jmp    801e5a <__umoddi3+0x3e>
  801f16:	66 90                	xchg   %ax,%ax
  801f18:	89 c8                	mov    %ecx,%eax
  801f1a:	89 f2                	mov    %esi,%edx
  801f1c:	83 c4 1c             	add    $0x1c,%esp
  801f1f:	5b                   	pop    %ebx
  801f20:	5e                   	pop    %esi
  801f21:	5f                   	pop    %edi
  801f22:	5d                   	pop    %ebp
  801f23:	c3                   	ret    
  801f24:	3b 04 24             	cmp    (%esp),%eax
  801f27:	72 06                	jb     801f2f <__umoddi3+0x113>
  801f29:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f2d:	77 0f                	ja     801f3e <__umoddi3+0x122>
  801f2f:	89 f2                	mov    %esi,%edx
  801f31:	29 f9                	sub    %edi,%ecx
  801f33:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f37:	89 14 24             	mov    %edx,(%esp)
  801f3a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f3e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f42:	8b 14 24             	mov    (%esp),%edx
  801f45:	83 c4 1c             	add    $0x1c,%esp
  801f48:	5b                   	pop    %ebx
  801f49:	5e                   	pop    %esi
  801f4a:	5f                   	pop    %edi
  801f4b:	5d                   	pop    %ebp
  801f4c:	c3                   	ret    
  801f4d:	8d 76 00             	lea    0x0(%esi),%esi
  801f50:	2b 04 24             	sub    (%esp),%eax
  801f53:	19 fa                	sbb    %edi,%edx
  801f55:	89 d1                	mov    %edx,%ecx
  801f57:	89 c6                	mov    %eax,%esi
  801f59:	e9 71 ff ff ff       	jmp    801ecf <__umoddi3+0xb3>
  801f5e:	66 90                	xchg   %ax,%ax
  801f60:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f64:	72 ea                	jb     801f50 <__umoddi3+0x134>
  801f66:	89 d9                	mov    %ebx,%ecx
  801f68:	e9 62 ff ff ff       	jmp    801ecf <__umoddi3+0xb3>
