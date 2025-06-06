
obj/user/tst_freeHeap_1:     file format elf32-i386


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
  800031:	e8 cf 08 00 00       	call   800905 <libmain>
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
  80003c:	81 ec 94 00 00 00    	sub    $0x94,%esp
	
	//	cprintf("envID = %d\n",envID);

	
	
	int kilo = 1024;
  800042:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
	int Mega = 1024*1024;
  800049:	c7 45 f0 00 00 10 00 	movl   $0x100000,-0x10(%ebp)

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x0)  		panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  800050:	a1 20 30 80 00       	mov    0x803020,%eax
  800055:	8b 40 7c             	mov    0x7c(%eax),%eax
  800058:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80005b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80005e:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800063:	85 c0                	test   %eax,%eax
  800065:	74 14                	je     80007b <_main+0x43>
  800067:	83 ec 04             	sub    $0x4,%esp
  80006a:	68 60 25 80 00       	push   $0x802560
  80006f:	6a 14                	push   $0x14
  800071:	68 a9 25 80 00       	push   $0x8025a9
  800076:	e8 8c 09 00 00       	call   800a07 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x800000)  	panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  80007b:	a1 20 30 80 00       	mov    0x803020,%eax
  800080:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  800086:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800089:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80008c:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800091:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800096:	74 14                	je     8000ac <_main+0x74>
  800098:	83 ec 04             	sub    $0x4,%esp
  80009b:	68 60 25 80 00       	push   $0x802560
  8000a0:	6a 15                	push   $0x15
  8000a2:	68 a9 25 80 00       	push   $0x8025a9
  8000a7:	e8 5b 09 00 00       	call   800a07 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)	panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b1:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
  8000b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000bd:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000c2:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 60 25 80 00       	push   $0x802560
  8000d1:	6a 16                	push   $0x16
  8000d3:	68 a9 25 80 00       	push   $0x8025a9
  8000d8:	e8 2a 09 00 00       	call   800a07 <_panic>
		if( myEnv->__ptr_tws[3].empty !=  1)  											panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8a 80 a4 00 00 00    	mov    0xa4(%eax),%al
  8000e8:	3c 01                	cmp    $0x1,%al
  8000ea:	74 14                	je     800100 <_main+0xc8>
  8000ec:	83 ec 04             	sub    $0x4,%esp
  8000ef:	68 60 25 80 00       	push   $0x802560
  8000f4:	6a 17                	push   $0x17
  8000f6:	68 a9 25 80 00       	push   $0x8025a9
  8000fb:	e8 07 09 00 00       	call   800a07 <_panic>

		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800100:	a1 20 30 80 00       	mov    0x803020,%eax
  800105:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80010b:	83 c0 0c             	add    $0xc,%eax
  80010e:	8b 00                	mov    (%eax),%eax
  800110:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800113:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800116:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80011b:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800120:	74 14                	je     800136 <_main+0xfe>
  800122:	83 ec 04             	sub    $0x4,%esp
  800125:	68 c0 25 80 00       	push   $0x8025c0
  80012a:	6a 19                	push   $0x19
  80012c:	68 a9 25 80 00       	push   $0x8025a9
  800131:	e8 d1 08 00 00       	call   800a07 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800136:	a1 20 30 80 00       	mov    0x803020,%eax
  80013b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800141:	83 c0 18             	add    $0x18,%eax
  800144:	8b 00                	mov    (%eax),%eax
  800146:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800149:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80014c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800151:	3d 00 20 20 00       	cmp    $0x202000,%eax
  800156:	74 14                	je     80016c <_main+0x134>
  800158:	83 ec 04             	sub    $0x4,%esp
  80015b:	68 c0 25 80 00       	push   $0x8025c0
  800160:	6a 1a                	push   $0x1a
  800162:	68 a9 25 80 00       	push   $0x8025a9
  800167:	e8 9b 08 00 00       	call   800a07 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80016c:	a1 20 30 80 00       	mov    0x803020,%eax
  800171:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800177:	83 c0 24             	add    $0x24,%eax
  80017a:	8b 00                	mov    (%eax),%eax
  80017c:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80017f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800182:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800187:	3d 00 30 20 00       	cmp    $0x203000,%eax
  80018c:	74 14                	je     8001a2 <_main+0x16a>
  80018e:	83 ec 04             	sub    $0x4,%esp
  800191:	68 c0 25 80 00       	push   $0x8025c0
  800196:	6a 1b                	push   $0x1b
  800198:	68 a9 25 80 00       	push   $0x8025a9
  80019d:	e8 65 08 00 00       	call   800a07 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a7:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001ad:	83 c0 30             	add    $0x30,%eax
  8001b0:	8b 00                	mov    (%eax),%eax
  8001b2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001b5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001b8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001bd:	3d 00 40 20 00       	cmp    $0x204000,%eax
  8001c2:	74 14                	je     8001d8 <_main+0x1a0>
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	68 c0 25 80 00       	push   $0x8025c0
  8001cc:	6a 1c                	push   $0x1c
  8001ce:	68 a9 25 80 00       	push   $0x8025a9
  8001d3:	e8 2f 08 00 00       	call   800a07 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001dd:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001e3:	83 c0 3c             	add    $0x3c,%eax
  8001e6:	8b 00                	mov    (%eax),%eax
  8001e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001eb:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8001ee:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001f3:	3d 00 50 20 00       	cmp    $0x205000,%eax
  8001f8:	74 14                	je     80020e <_main+0x1d6>
  8001fa:	83 ec 04             	sub    $0x4,%esp
  8001fd:	68 c0 25 80 00       	push   $0x8025c0
  800202:	6a 1d                	push   $0x1d
  800204:	68 a9 25 80 00       	push   $0x8025a9
  800209:	e8 f9 07 00 00       	call   800a07 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80020e:	a1 20 30 80 00       	mov    0x803020,%eax
  800213:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800219:	83 c0 48             	add    $0x48,%eax
  80021c:	8b 00                	mov    (%eax),%eax
  80021e:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800221:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800224:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800229:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80022e:	74 14                	je     800244 <_main+0x20c>
  800230:	83 ec 04             	sub    $0x4,%esp
  800233:	68 c0 25 80 00       	push   $0x8025c0
  800238:	6a 1e                	push   $0x1e
  80023a:	68 a9 25 80 00       	push   $0x8025a9
  80023f:	e8 c3 07 00 00       	call   800a07 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800244:	a1 20 30 80 00       	mov    0x803020,%eax
  800249:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80024f:	83 c0 54             	add    $0x54,%eax
  800252:	8b 00                	mov    (%eax),%eax
  800254:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800257:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80025a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80025f:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800264:	74 14                	je     80027a <_main+0x242>
  800266:	83 ec 04             	sub    $0x4,%esp
  800269:	68 c0 25 80 00       	push   $0x8025c0
  80026e:	6a 1f                	push   $0x1f
  800270:	68 a9 25 80 00       	push   $0x8025a9
  800275:	e8 8d 07 00 00       	call   800a07 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80027a:	a1 20 30 80 00       	mov    0x803020,%eax
  80027f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800285:	83 c0 60             	add    $0x60,%eax
  800288:	8b 00                	mov    (%eax),%eax
  80028a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80028d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800290:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800295:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 c0 25 80 00       	push   $0x8025c0
  8002a4:	6a 20                	push   $0x20
  8002a6:	68 a9 25 80 00       	push   $0x8025a9
  8002ab:	e8 57 07 00 00       	call   800a07 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8002b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b5:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002bb:	83 c0 6c             	add    $0x6c,%eax
  8002be:	8b 00                	mov    (%eax),%eax
  8002c0:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8002c3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8002c6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002cb:	3d 00 30 80 00       	cmp    $0x803000,%eax
  8002d0:	74 14                	je     8002e6 <_main+0x2ae>
  8002d2:	83 ec 04             	sub    $0x4,%esp
  8002d5:	68 c0 25 80 00       	push   $0x8025c0
  8002da:	6a 21                	push   $0x21
  8002dc:	68 a9 25 80 00       	push   $0x8025a9
  8002e1:	e8 21 07 00 00       	call   800a07 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8002e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002eb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002f1:	83 c0 78             	add    $0x78,%eax
  8002f4:	8b 00                	mov    (%eax),%eax
  8002f6:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8002f9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8002fc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800301:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800306:	74 14                	je     80031c <_main+0x2e4>
  800308:	83 ec 04             	sub    $0x4,%esp
  80030b:	68 c0 25 80 00       	push   $0x8025c0
  800310:	6a 22                	push   $0x22
  800312:	68 a9 25 80 00       	push   $0x8025a9
  800317:	e8 eb 06 00 00       	call   800a07 <_panic>

		if( myEnv->page_last_WS_index !=  11)  										panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80031c:	a1 20 30 80 00       	mov    0x803020,%eax
  800321:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800327:	83 f8 0b             	cmp    $0xb,%eax
  80032a:	74 14                	je     800340 <_main+0x308>
  80032c:	83 ec 04             	sub    $0x4,%esp
  80032f:	68 c0 25 80 00       	push   $0x8025c0
  800334:	6a 24                	push   $0x24
  800336:	68 a9 25 80 00       	push   $0x8025a9
  80033b:	e8 c7 06 00 00       	call   800a07 <_panic>
	}


	/// testing freeHeap()
	{
		int freeFrames = sys_calculate_free_frames() ;
  800340:	e8 fc 1a 00 00       	call   801e41 <sys_calculate_free_frames>
  800345:	89 45 b8             	mov    %eax,-0x48(%ebp)
		int origFreeFrames = freeFrames ;
  800348:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80034b:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80034e:	e8 71 1b 00 00       	call   801ec4 <sys_pf_calculate_allocated_pages>
  800353:	89 45 b0             	mov    %eax,-0x50(%ebp)

		uint32 size = 12*Mega;
  800356:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800359:	89 d0                	mov    %edx,%eax
  80035b:	01 c0                	add    %eax,%eax
  80035d:	01 d0                	add    %edx,%eax
  80035f:	c1 e0 02             	shl    $0x2,%eax
  800362:	89 45 ac             	mov    %eax,-0x54(%ebp)
		unsigned char *x = malloc(sizeof(unsigned char)*size) ;
  800365:	83 ec 0c             	sub    $0xc,%esp
  800368:	ff 75 ac             	pushl  -0x54(%ebp)
  80036b:	e8 0f 17 00 00       	call   801a7f <malloc>
  800370:	83 c4 10             	add    $0x10,%esp
  800373:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if(!(((uint32)x == USER_HEAP_START) && (freeFrames - sys_calculate_free_frames()) == 3))
  800376:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800379:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  80037e:	75 11                	jne    800391 <_main+0x359>
  800380:	8b 5d b8             	mov    -0x48(%ebp),%ebx
  800383:	e8 b9 1a 00 00       	call   801e41 <sys_calculate_free_frames>
  800388:	29 c3                	sub    %eax,%ebx
  80038a:	89 d8                	mov    %ebx,%eax
  80038c:	83 f8 03             	cmp    $0x3,%eax
  80038f:	74 14                	je     8003a5 <_main+0x36d>
			panic("malloc() does not work correctly... check it before checking freeHeap") ;
  800391:	83 ec 04             	sub    $0x4,%esp
  800394:	68 08 26 80 00       	push   $0x802608
  800399:	6a 31                	push   $0x31
  80039b:	68 a9 25 80 00       	push   $0x8025a9
  8003a0:	e8 62 06 00 00       	call   800a07 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8003a5:	e8 97 1a 00 00       	call   801e41 <sys_calculate_free_frames>
  8003aa:	89 45 b8             	mov    %eax,-0x48(%ebp)
		size = 2*kilo;
  8003ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003b0:	01 c0                	add    %eax,%eax
  8003b2:	89 45 ac             	mov    %eax,-0x54(%ebp)
		unsigned char *y = malloc(sizeof(unsigned char)*size) ;
  8003b5:	83 ec 0c             	sub    $0xc,%esp
  8003b8:	ff 75 ac             	pushl  -0x54(%ebp)
  8003bb:	e8 bf 16 00 00       	call   801a7f <malloc>
  8003c0:	83 c4 10             	add    $0x10,%esp
  8003c3:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if(!(((uint32)y == USER_HEAP_START + 12*Mega) && (freeFrames - sys_calculate_free_frames()) == 1))
  8003c6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8003c9:	89 d0                	mov    %edx,%eax
  8003cb:	01 c0                	add    %eax,%eax
  8003cd:	01 d0                	add    %edx,%eax
  8003cf:	c1 e0 02             	shl    $0x2,%eax
  8003d2:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8003d8:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003db:	39 c2                	cmp    %eax,%edx
  8003dd:	75 11                	jne    8003f0 <_main+0x3b8>
  8003df:	8b 5d b8             	mov    -0x48(%ebp),%ebx
  8003e2:	e8 5a 1a 00 00       	call   801e41 <sys_calculate_free_frames>
  8003e7:	29 c3                	sub    %eax,%ebx
  8003e9:	89 d8                	mov    %ebx,%eax
  8003eb:	83 f8 01             	cmp    $0x1,%eax
  8003ee:	74 14                	je     800404 <_main+0x3cc>
			panic("malloc() does not work correctly... check it before checking freeHeap") ;
  8003f0:	83 ec 04             	sub    $0x4,%esp
  8003f3:	68 08 26 80 00       	push   $0x802608
  8003f8:	6a 37                	push   $0x37
  8003fa:	68 a9 25 80 00       	push   $0x8025a9
  8003ff:	e8 03 06 00 00       	call   800a07 <_panic>


		x[1]=-1;
  800404:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800407:	40                   	inc    %eax
  800408:	c6 00 ff             	movb   $0xff,(%eax)

		x[8*Mega] = -1;
  80040b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80040e:	c1 e0 03             	shl    $0x3,%eax
  800411:	89 c2                	mov    %eax,%edx
  800413:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800416:	01 d0                	add    %edx,%eax
  800418:	c6 00 ff             	movb   $0xff,(%eax)

		x[512*kilo]=-1;
  80041b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80041e:	c1 e0 09             	shl    $0x9,%eax
  800421:	89 c2                	mov    %eax,%edx
  800423:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800426:	01 d0                	add    %edx,%eax
  800428:	c6 00 ff             	movb   $0xff,(%eax)

		free(x);
  80042b:	83 ec 0c             	sub    $0xc,%esp
  80042e:	ff 75 a8             	pushl  -0x58(%ebp)
  800431:	e8 6a 17 00 00       	call   801ba0 <free>
  800436:	83 c4 10             	add    $0x10,%esp
		free(y);
  800439:	83 ec 0c             	sub    $0xc,%esp
  80043c:	ff 75 a4             	pushl  -0x5c(%ebp)
  80043f:	e8 5c 17 00 00       	call   801ba0 <free>
  800444:	83 c4 10             	add    $0x10,%esp

		if((origFreeFrames - sys_calculate_free_frames()) != 4 ) panic("FreeHeap didn't correctly free the allocated memory (pages and/or tables)");
  800447:	8b 5d b4             	mov    -0x4c(%ebp),%ebx
  80044a:	e8 f2 19 00 00       	call   801e41 <sys_calculate_free_frames>
  80044f:	29 c3                	sub    %eax,%ebx
  800451:	89 d8                	mov    %ebx,%eax
  800453:	83 f8 04             	cmp    $0x4,%eax
  800456:	74 14                	je     80046c <_main+0x434>
  800458:	83 ec 04             	sub    $0x4,%esp
  80045b:	68 50 26 80 00       	push   $0x802650
  800460:	6a 43                	push   $0x43
  800462:	68 a9 25 80 00       	push   $0x8025a9
  800467:	e8 9b 05 00 00       	call   800a07 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0 ) panic("FreeHeap didn't correctly free the allocated space (pages and/or tables) in PageFile");
  80046c:	e8 53 1a 00 00       	call   801ec4 <sys_pf_calculate_allocated_pages>
  800471:	3b 45 b0             	cmp    -0x50(%ebp),%eax
  800474:	74 14                	je     80048a <_main+0x452>
  800476:	83 ec 04             	sub    $0x4,%esp
  800479:	68 9c 26 80 00       	push   $0x80269c
  80047e:	6a 44                	push   $0x44
  800480:	68 a9 25 80 00       	push   $0x8025a9
  800485:	e8 7d 05 00 00       	call   800a07 <_panic>

		{
			if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x0)  panic("TABLE WS entry checking failed");
  80048a:	a1 20 30 80 00       	mov    0x803020,%eax
  80048f:	8b 40 7c             	mov    0x7c(%eax),%eax
  800492:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800495:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800498:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  80049d:	85 c0                	test   %eax,%eax
  80049f:	74 14                	je     8004b5 <_main+0x47d>
  8004a1:	83 ec 04             	sub    $0x4,%esp
  8004a4:	68 f4 26 80 00       	push   $0x8026f4
  8004a9:	6a 47                	push   $0x47
  8004ab:	68 a9 25 80 00       	push   $0x8025a9
  8004b0:	e8 52 05 00 00       	call   800a07 <_panic>
			if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x800000)  panic("TABLE WS entry checking failed");
  8004b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ba:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  8004c0:	89 45 9c             	mov    %eax,-0x64(%ebp)
  8004c3:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8004c6:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8004cb:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8004d0:	74 14                	je     8004e6 <_main+0x4ae>
  8004d2:	83 ec 04             	sub    $0x4,%esp
  8004d5:	68 f4 26 80 00       	push   $0x8026f4
  8004da:	6a 48                	push   $0x48
  8004dc:	68 a9 25 80 00       	push   $0x8025a9
  8004e1:	e8 21 05 00 00       	call   800a07 <_panic>
			if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)  panic("TABLE WS entry checking failed");
  8004e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8004eb:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
  8004f1:	89 45 98             	mov    %eax,-0x68(%ebp)
  8004f4:	8b 45 98             	mov    -0x68(%ebp),%eax
  8004f7:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8004fc:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  800501:	74 14                	je     800517 <_main+0x4df>
  800503:	83 ec 04             	sub    $0x4,%esp
  800506:	68 f4 26 80 00       	push   $0x8026f4
  80050b:	6a 49                	push   $0x49
  80050d:	68 a9 25 80 00       	push   $0x8025a9
  800512:	e8 f0 04 00 00       	call   800a07 <_panic>
			if( myEnv->__ptr_tws[3].empty != 1 )  panic("TABLE WS entry checking failed.. Expected to be EMPTY after FreeHeap");
  800517:	a1 20 30 80 00       	mov    0x803020,%eax
  80051c:	8a 80 a4 00 00 00    	mov    0xa4(%eax),%al
  800522:	3c 01                	cmp    $0x1,%al
  800524:	74 14                	je     80053a <_main+0x502>
  800526:	83 ec 04             	sub    $0x4,%esp
  800529:	68 14 27 80 00       	push   $0x802714
  80052e:	6a 4a                	push   $0x4a
  800530:	68 a9 25 80 00       	push   $0x8025a9
  800535:	e8 cd 04 00 00       	call   800a07 <_panic>
			if( myEnv->__ptr_tws[4].empty != 1 )  panic("TABLE WS entry checking failed.. Expected to be EMPTY after FreeHeap");
  80053a:	a1 20 30 80 00       	mov    0x803020,%eax
  80053f:	8a 80 b0 00 00 00    	mov    0xb0(%eax),%al
  800545:	3c 01                	cmp    $0x1,%al
  800547:	74 14                	je     80055d <_main+0x525>
  800549:	83 ec 04             	sub    $0x4,%esp
  80054c:	68 14 27 80 00       	push   $0x802714
  800551:	6a 4b                	push   $0x4b
  800553:	68 a9 25 80 00       	push   $0x8025a9
  800558:	e8 aa 04 00 00       	call   800a07 <_panic>

			if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  panic("PAGE WS entry checking failed");
  80055d:	a1 20 30 80 00       	mov    0x803020,%eax
  800562:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800568:	8b 00                	mov    (%eax),%eax
  80056a:	89 45 94             	mov    %eax,-0x6c(%ebp)
  80056d:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800570:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800575:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80057a:	74 14                	je     800590 <_main+0x558>
  80057c:	83 ec 04             	sub    $0x4,%esp
  80057f:	68 59 27 80 00       	push   $0x802759
  800584:	6a 4d                	push   $0x4d
  800586:	68 a9 25 80 00       	push   $0x8025a9
  80058b:	e8 77 04 00 00       	call   800a07 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("PAGE WS entry checking failed");
  800590:	a1 20 30 80 00       	mov    0x803020,%eax
  800595:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80059b:	83 c0 0c             	add    $0xc,%eax
  80059e:	8b 00                	mov    (%eax),%eax
  8005a0:	89 45 90             	mov    %eax,-0x70(%ebp)
  8005a3:	8b 45 90             	mov    -0x70(%ebp),%eax
  8005a6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005ab:	3d 00 10 20 00       	cmp    $0x201000,%eax
  8005b0:	74 14                	je     8005c6 <_main+0x58e>
  8005b2:	83 ec 04             	sub    $0x4,%esp
  8005b5:	68 59 27 80 00       	push   $0x802759
  8005ba:	6a 4e                	push   $0x4e
  8005bc:	68 a9 25 80 00       	push   $0x8025a9
  8005c1:	e8 41 04 00 00       	call   800a07 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("PAGE WS entry checking failed");
  8005c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8005cb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8005d1:	83 c0 18             	add    $0x18,%eax
  8005d4:	8b 00                	mov    (%eax),%eax
  8005d6:	89 45 8c             	mov    %eax,-0x74(%ebp)
  8005d9:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8005dc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005e1:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8005e6:	74 14                	je     8005fc <_main+0x5c4>
  8005e8:	83 ec 04             	sub    $0x4,%esp
  8005eb:	68 59 27 80 00       	push   $0x802759
  8005f0:	6a 4f                	push   $0x4f
  8005f2:	68 a9 25 80 00       	push   $0x8025a9
  8005f7:	e8 0b 04 00 00       	call   800a07 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("PAGE WS entry checking failed");
  8005fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800601:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800607:	83 c0 24             	add    $0x24,%eax
  80060a:	8b 00                	mov    (%eax),%eax
  80060c:	89 45 88             	mov    %eax,-0x78(%ebp)
  80060f:	8b 45 88             	mov    -0x78(%ebp),%eax
  800612:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800617:	3d 00 30 20 00       	cmp    $0x203000,%eax
  80061c:	74 14                	je     800632 <_main+0x5fa>
  80061e:	83 ec 04             	sub    $0x4,%esp
  800621:	68 59 27 80 00       	push   $0x802759
  800626:	6a 50                	push   $0x50
  800628:	68 a9 25 80 00       	push   $0x8025a9
  80062d:	e8 d5 03 00 00       	call   800a07 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("PAGE WS entry checking failed");
  800632:	a1 20 30 80 00       	mov    0x803020,%eax
  800637:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80063d:	83 c0 30             	add    $0x30,%eax
  800640:	8b 00                	mov    (%eax),%eax
  800642:	89 45 84             	mov    %eax,-0x7c(%ebp)
  800645:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800648:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80064d:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800652:	74 14                	je     800668 <_main+0x630>
  800654:	83 ec 04             	sub    $0x4,%esp
  800657:	68 59 27 80 00       	push   $0x802759
  80065c:	6a 51                	push   $0x51
  80065e:	68 a9 25 80 00       	push   $0x8025a9
  800663:	e8 9f 03 00 00       	call   800a07 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("PAGE WS entry checking failed");
  800668:	a1 20 30 80 00       	mov    0x803020,%eax
  80066d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800673:	83 c0 3c             	add    $0x3c,%eax
  800676:	8b 00                	mov    (%eax),%eax
  800678:	89 45 80             	mov    %eax,-0x80(%ebp)
  80067b:	8b 45 80             	mov    -0x80(%ebp),%eax
  80067e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800683:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800688:	74 14                	je     80069e <_main+0x666>
  80068a:	83 ec 04             	sub    $0x4,%esp
  80068d:	68 59 27 80 00       	push   $0x802759
  800692:	6a 52                	push   $0x52
  800694:	68 a9 25 80 00       	push   $0x8025a9
  800699:	e8 69 03 00 00       	call   800a07 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("PAGE WS entry checking failed");
  80069e:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8006a9:	83 c0 48             	add    $0x48,%eax
  8006ac:	8b 00                	mov    (%eax),%eax
  8006ae:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  8006b4:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8006ba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006bf:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8006c4:	74 14                	je     8006da <_main+0x6a2>
  8006c6:	83 ec 04             	sub    $0x4,%esp
  8006c9:	68 59 27 80 00       	push   $0x802759
  8006ce:	6a 53                	push   $0x53
  8006d0:	68 a9 25 80 00       	push   $0x8025a9
  8006d5:	e8 2d 03 00 00       	call   800a07 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("PAGE WS entry checking failed");
  8006da:	a1 20 30 80 00       	mov    0x803020,%eax
  8006df:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8006e5:	83 c0 54             	add    $0x54,%eax
  8006e8:	8b 00                	mov    (%eax),%eax
  8006ea:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  8006f0:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8006f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006fb:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800700:	74 14                	je     800716 <_main+0x6de>
  800702:	83 ec 04             	sub    $0x4,%esp
  800705:	68 59 27 80 00       	push   $0x802759
  80070a:	6a 54                	push   $0x54
  80070c:	68 a9 25 80 00       	push   $0x8025a9
  800711:	e8 f1 02 00 00       	call   800a07 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("PAGE WS entry checking failed");
  800716:	a1 20 30 80 00       	mov    0x803020,%eax
  80071b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800721:	83 c0 60             	add    $0x60,%eax
  800724:	8b 00                	mov    (%eax),%eax
  800726:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  80072c:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800732:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800737:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80073c:	74 14                	je     800752 <_main+0x71a>
  80073e:	83 ec 04             	sub    $0x4,%esp
  800741:	68 59 27 80 00       	push   $0x802759
  800746:	6a 55                	push   $0x55
  800748:	68 a9 25 80 00       	push   $0x8025a9
  80074d:	e8 b5 02 00 00       	call   800a07 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("PAGE WS entry checking failed");
  800752:	a1 20 30 80 00       	mov    0x803020,%eax
  800757:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80075d:	83 c0 6c             	add    $0x6c,%eax
  800760:	8b 00                	mov    (%eax),%eax
  800762:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  800768:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80076e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800773:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800778:	74 14                	je     80078e <_main+0x756>
  80077a:	83 ec 04             	sub    $0x4,%esp
  80077d:	68 59 27 80 00       	push   $0x802759
  800782:	6a 56                	push   $0x56
  800784:	68 a9 25 80 00       	push   $0x8025a9
  800789:	e8 79 02 00 00       	call   800a07 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("PAGE WS entry checking failed");
  80078e:	a1 20 30 80 00       	mov    0x803020,%eax
  800793:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800799:	83 c0 78             	add    $0x78,%eax
  80079c:	8b 00                	mov    (%eax),%eax
  80079e:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  8007a4:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8007aa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007af:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8007b4:	74 14                	je     8007ca <_main+0x792>
  8007b6:	83 ec 04             	sub    $0x4,%esp
  8007b9:	68 59 27 80 00       	push   $0x802759
  8007be:	6a 57                	push   $0x57
  8007c0:	68 a9 25 80 00       	push   $0x8025a9
  8007c5:	e8 3d 02 00 00       	call   800a07 <_panic>
			if( myEnv->__uptr_pws[11].empty != 1)  panic("PAGE WS entry checking failed.. Expected to be EMPTY after FreeHeap");
  8007ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8007cf:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8007d5:	05 84 00 00 00       	add    $0x84,%eax
  8007da:	8a 40 04             	mov    0x4(%eax),%al
  8007dd:	3c 01                	cmp    $0x1,%al
  8007df:	74 14                	je     8007f5 <_main+0x7bd>
  8007e1:	83 ec 04             	sub    $0x4,%esp
  8007e4:	68 78 27 80 00       	push   $0x802778
  8007e9:	6a 58                	push   $0x58
  8007eb:	68 a9 25 80 00       	push   $0x8025a9
  8007f0:	e8 12 02 00 00       	call   800a07 <_panic>
			if( myEnv->__uptr_pws[12].empty != 1)  panic("PAGE WS entry checking failed.. Expected to be EMPTY after FreeHeap");
  8007f5:	a1 20 30 80 00       	mov    0x803020,%eax
  8007fa:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800800:	05 90 00 00 00       	add    $0x90,%eax
  800805:	8a 40 04             	mov    0x4(%eax),%al
  800808:	3c 01                	cmp    $0x1,%al
  80080a:	74 14                	je     800820 <_main+0x7e8>
  80080c:	83 ec 04             	sub    $0x4,%esp
  80080f:	68 78 27 80 00       	push   $0x802778
  800814:	6a 59                	push   $0x59
  800816:	68 a9 25 80 00       	push   $0x8025a9
  80081b:	e8 e7 01 00 00       	call   800a07 <_panic>
			if( myEnv->__uptr_pws[13].empty != 1)  panic("PAGE WS entry checking failed.. Expected to be EMPTY after FreeHeap");
  800820:	a1 20 30 80 00       	mov    0x803020,%eax
  800825:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80082b:	05 9c 00 00 00       	add    $0x9c,%eax
  800830:	8a 40 04             	mov    0x4(%eax),%al
  800833:	3c 01                	cmp    $0x1,%al
  800835:	74 14                	je     80084b <_main+0x813>
  800837:	83 ec 04             	sub    $0x4,%esp
  80083a:	68 78 27 80 00       	push   $0x802778
  80083f:	6a 5a                	push   $0x5a
  800841:	68 a9 25 80 00       	push   $0x8025a9
  800846:	e8 bc 01 00 00       	call   800a07 <_panic>
			if( myEnv->__uptr_pws[14].empty != 1)  panic("PAGE WS entry checking failed.. Expected to be EMPTY after FreeHeap");
  80084b:	a1 20 30 80 00       	mov    0x803020,%eax
  800850:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800856:	05 a8 00 00 00       	add    $0xa8,%eax
  80085b:	8a 40 04             	mov    0x4(%eax),%al
  80085e:	3c 01                	cmp    $0x1,%al
  800860:	74 14                	je     800876 <_main+0x83e>
  800862:	83 ec 04             	sub    $0x4,%esp
  800865:	68 78 27 80 00       	push   $0x802778
  80086a:	6a 5b                	push   $0x5b
  80086c:	68 a9 25 80 00       	push   $0x8025a9
  800871:	e8 91 01 00 00       	call   800a07 <_panic>
		}

		//Checking if freeHeap RESET the HEAP POINTER or not
		{
			unsigned char *z = malloc(sizeof(unsigned char)*1) ;
  800876:	83 ec 0c             	sub    $0xc,%esp
  800879:	6a 01                	push   $0x1
  80087b:	e8 ff 11 00 00       	call   801a7f <malloc>
  800880:	83 c4 10             	add    $0x10,%esp
  800883:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)

			if(!((uint32)z == USER_HEAP_START) )
  800889:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  80088f:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800894:	74 14                	je     8008aa <_main+0x872>
				panic("ERROR: freeHeap didn't reset the HEAP POINTER after finishing... Kindly reset it!!") ;
  800896:	83 ec 04             	sub    $0x4,%esp
  800899:	68 bc 27 80 00       	push   $0x8027bc
  80089e:	6a 63                	push   $0x63
  8008a0:	68 a9 25 80 00       	push   $0x8025a9
  8008a5:	e8 5d 01 00 00       	call   800a07 <_panic>
		}
		cprintf("Congratulations!! test freeHeap completed successfully.\n");
  8008aa:	83 ec 0c             	sub    $0xc,%esp
  8008ad:	68 10 28 80 00       	push   $0x802810
  8008b2:	e8 04 04 00 00       	call   800cbb <cprintf>
  8008b7:	83 c4 10             	add    $0x10,%esp

		//Try to access any of the removed buffered pages in the Heap [It's ILLEGAL ACCESS now]
		{
			cprintf("\nNow, trying to access the removed pages in the HEAP, you should make the kernel PANIC with ILLEGAL MEMORY ACCESS in page_fault_handler() since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK.\n\n\n");
  8008ba:	83 ec 0c             	sub    $0xc,%esp
  8008bd:	68 4c 28 80 00       	push   $0x80284c
  8008c2:	e8 f4 03 00 00       	call   800cbb <cprintf>
  8008c7:	83 c4 10             	add    $0x10,%esp

			x[1]=-1;
  8008ca:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8008cd:	40                   	inc    %eax
  8008ce:	c6 00 ff             	movb   $0xff,(%eax)

			x[8*Mega] = -1;
  8008d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d4:	c1 e0 03             	shl    $0x3,%eax
  8008d7:	89 c2                	mov    %eax,%edx
  8008d9:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8008dc:	01 d0                	add    %edx,%eax
  8008de:	c6 00 ff             	movb   $0xff,(%eax)

			x[512*kilo]=-1;
  8008e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008e4:	c1 e0 09             	shl    $0x9,%eax
  8008e7:	89 c2                	mov    %eax,%edx
  8008e9:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8008ec:	01 d0                	add    %edx,%eax
  8008ee:	c6 00 ff             	movb   $0xff,(%eax)

		}
		panic("ERROR: FOS SHOULD NOT panic here, it should panic earlier in page_fault_handler(), since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK. REMEMBER: creating new page in page file shouldn't be allowed except ONLY for stack pages\n");
  8008f1:	83 ec 04             	sub    $0x4,%esp
  8008f4:	68 30 29 80 00       	push   $0x802930
  8008f9:	6a 72                	push   $0x72
  8008fb:	68 a9 25 80 00       	push   $0x8025a9
  800900:	e8 02 01 00 00       	call   800a07 <_panic>

00800905 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800905:	55                   	push   %ebp
  800906:	89 e5                	mov    %esp,%ebp
  800908:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80090b:	e8 66 14 00 00       	call   801d76 <sys_getenvindex>
  800910:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800913:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800916:	89 d0                	mov    %edx,%eax
  800918:	01 c0                	add    %eax,%eax
  80091a:	01 d0                	add    %edx,%eax
  80091c:	c1 e0 02             	shl    $0x2,%eax
  80091f:	01 d0                	add    %edx,%eax
  800921:	c1 e0 06             	shl    $0x6,%eax
  800924:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800929:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80092e:	a1 20 30 80 00       	mov    0x803020,%eax
  800933:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800939:	84 c0                	test   %al,%al
  80093b:	74 0f                	je     80094c <libmain+0x47>
		binaryname = myEnv->prog_name;
  80093d:	a1 20 30 80 00       	mov    0x803020,%eax
  800942:	05 f4 02 00 00       	add    $0x2f4,%eax
  800947:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80094c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800950:	7e 0a                	jle    80095c <libmain+0x57>
		binaryname = argv[0];
  800952:	8b 45 0c             	mov    0xc(%ebp),%eax
  800955:	8b 00                	mov    (%eax),%eax
  800957:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80095c:	83 ec 08             	sub    $0x8,%esp
  80095f:	ff 75 0c             	pushl  0xc(%ebp)
  800962:	ff 75 08             	pushl  0x8(%ebp)
  800965:	e8 ce f6 ff ff       	call   800038 <_main>
  80096a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80096d:	e8 9f 15 00 00       	call   801f11 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800972:	83 ec 0c             	sub    $0xc,%esp
  800975:	68 50 2a 80 00       	push   $0x802a50
  80097a:	e8 3c 03 00 00       	call   800cbb <cprintf>
  80097f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800982:	a1 20 30 80 00       	mov    0x803020,%eax
  800987:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80098d:	a1 20 30 80 00       	mov    0x803020,%eax
  800992:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800998:	83 ec 04             	sub    $0x4,%esp
  80099b:	52                   	push   %edx
  80099c:	50                   	push   %eax
  80099d:	68 78 2a 80 00       	push   $0x802a78
  8009a2:	e8 14 03 00 00       	call   800cbb <cprintf>
  8009a7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8009aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8009af:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8009b5:	83 ec 08             	sub    $0x8,%esp
  8009b8:	50                   	push   %eax
  8009b9:	68 9d 2a 80 00       	push   $0x802a9d
  8009be:	e8 f8 02 00 00       	call   800cbb <cprintf>
  8009c3:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8009c6:	83 ec 0c             	sub    $0xc,%esp
  8009c9:	68 50 2a 80 00       	push   $0x802a50
  8009ce:	e8 e8 02 00 00       	call   800cbb <cprintf>
  8009d3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8009d6:	e8 50 15 00 00       	call   801f2b <sys_enable_interrupt>

	// exit gracefully
	exit();
  8009db:	e8 19 00 00 00       	call   8009f9 <exit>
}
  8009e0:	90                   	nop
  8009e1:	c9                   	leave  
  8009e2:	c3                   	ret    

008009e3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8009e3:	55                   	push   %ebp
  8009e4:	89 e5                	mov    %esp,%ebp
  8009e6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8009e9:	83 ec 0c             	sub    $0xc,%esp
  8009ec:	6a 00                	push   $0x0
  8009ee:	e8 4f 13 00 00       	call   801d42 <sys_env_destroy>
  8009f3:	83 c4 10             	add    $0x10,%esp
}
  8009f6:	90                   	nop
  8009f7:	c9                   	leave  
  8009f8:	c3                   	ret    

008009f9 <exit>:

void
exit(void)
{
  8009f9:	55                   	push   %ebp
  8009fa:	89 e5                	mov    %esp,%ebp
  8009fc:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8009ff:	e8 a4 13 00 00       	call   801da8 <sys_env_exit>
}
  800a04:	90                   	nop
  800a05:	c9                   	leave  
  800a06:	c3                   	ret    

00800a07 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800a07:	55                   	push   %ebp
  800a08:	89 e5                	mov    %esp,%ebp
  800a0a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800a0d:	8d 45 10             	lea    0x10(%ebp),%eax
  800a10:	83 c0 04             	add    $0x4,%eax
  800a13:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800a16:	a1 30 30 80 00       	mov    0x803030,%eax
  800a1b:	85 c0                	test   %eax,%eax
  800a1d:	74 16                	je     800a35 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800a1f:	a1 30 30 80 00       	mov    0x803030,%eax
  800a24:	83 ec 08             	sub    $0x8,%esp
  800a27:	50                   	push   %eax
  800a28:	68 b4 2a 80 00       	push   $0x802ab4
  800a2d:	e8 89 02 00 00       	call   800cbb <cprintf>
  800a32:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800a35:	a1 00 30 80 00       	mov    0x803000,%eax
  800a3a:	ff 75 0c             	pushl  0xc(%ebp)
  800a3d:	ff 75 08             	pushl  0x8(%ebp)
  800a40:	50                   	push   %eax
  800a41:	68 b9 2a 80 00       	push   $0x802ab9
  800a46:	e8 70 02 00 00       	call   800cbb <cprintf>
  800a4b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800a4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800a51:	83 ec 08             	sub    $0x8,%esp
  800a54:	ff 75 f4             	pushl  -0xc(%ebp)
  800a57:	50                   	push   %eax
  800a58:	e8 f3 01 00 00       	call   800c50 <vcprintf>
  800a5d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a60:	83 ec 08             	sub    $0x8,%esp
  800a63:	6a 00                	push   $0x0
  800a65:	68 d5 2a 80 00       	push   $0x802ad5
  800a6a:	e8 e1 01 00 00       	call   800c50 <vcprintf>
  800a6f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a72:	e8 82 ff ff ff       	call   8009f9 <exit>

	// should not return here
	while (1) ;
  800a77:	eb fe                	jmp    800a77 <_panic+0x70>

00800a79 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a79:	55                   	push   %ebp
  800a7a:	89 e5                	mov    %esp,%ebp
  800a7c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a7f:	a1 20 30 80 00       	mov    0x803020,%eax
  800a84:	8b 50 74             	mov    0x74(%eax),%edx
  800a87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8a:	39 c2                	cmp    %eax,%edx
  800a8c:	74 14                	je     800aa2 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a8e:	83 ec 04             	sub    $0x4,%esp
  800a91:	68 d8 2a 80 00       	push   $0x802ad8
  800a96:	6a 26                	push   $0x26
  800a98:	68 24 2b 80 00       	push   $0x802b24
  800a9d:	e8 65 ff ff ff       	call   800a07 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800aa2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800aa9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800ab0:	e9 c2 00 00 00       	jmp    800b77 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800ab5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ab8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	01 d0                	add    %edx,%eax
  800ac4:	8b 00                	mov    (%eax),%eax
  800ac6:	85 c0                	test   %eax,%eax
  800ac8:	75 08                	jne    800ad2 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800aca:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800acd:	e9 a2 00 00 00       	jmp    800b74 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800ad2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ad9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800ae0:	eb 69                	jmp    800b4b <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800ae2:	a1 20 30 80 00       	mov    0x803020,%eax
  800ae7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800aed:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800af0:	89 d0                	mov    %edx,%eax
  800af2:	01 c0                	add    %eax,%eax
  800af4:	01 d0                	add    %edx,%eax
  800af6:	c1 e0 02             	shl    $0x2,%eax
  800af9:	01 c8                	add    %ecx,%eax
  800afb:	8a 40 04             	mov    0x4(%eax),%al
  800afe:	84 c0                	test   %al,%al
  800b00:	75 46                	jne    800b48 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b02:	a1 20 30 80 00       	mov    0x803020,%eax
  800b07:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b0d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b10:	89 d0                	mov    %edx,%eax
  800b12:	01 c0                	add    %eax,%eax
  800b14:	01 d0                	add    %edx,%eax
  800b16:	c1 e0 02             	shl    $0x2,%eax
  800b19:	01 c8                	add    %ecx,%eax
  800b1b:	8b 00                	mov    (%eax),%eax
  800b1d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800b20:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800b23:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b28:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800b2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b2d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	01 c8                	add    %ecx,%eax
  800b39:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b3b:	39 c2                	cmp    %eax,%edx
  800b3d:	75 09                	jne    800b48 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800b3f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b46:	eb 12                	jmp    800b5a <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b48:	ff 45 e8             	incl   -0x18(%ebp)
  800b4b:	a1 20 30 80 00       	mov    0x803020,%eax
  800b50:	8b 50 74             	mov    0x74(%eax),%edx
  800b53:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b56:	39 c2                	cmp    %eax,%edx
  800b58:	77 88                	ja     800ae2 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b5a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b5e:	75 14                	jne    800b74 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800b60:	83 ec 04             	sub    $0x4,%esp
  800b63:	68 30 2b 80 00       	push   $0x802b30
  800b68:	6a 3a                	push   $0x3a
  800b6a:	68 24 2b 80 00       	push   $0x802b24
  800b6f:	e8 93 fe ff ff       	call   800a07 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b74:	ff 45 f0             	incl   -0x10(%ebp)
  800b77:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b7a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b7d:	0f 8c 32 ff ff ff    	jl     800ab5 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b83:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b8a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b91:	eb 26                	jmp    800bb9 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b93:	a1 20 30 80 00       	mov    0x803020,%eax
  800b98:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b9e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ba1:	89 d0                	mov    %edx,%eax
  800ba3:	01 c0                	add    %eax,%eax
  800ba5:	01 d0                	add    %edx,%eax
  800ba7:	c1 e0 02             	shl    $0x2,%eax
  800baa:	01 c8                	add    %ecx,%eax
  800bac:	8a 40 04             	mov    0x4(%eax),%al
  800baf:	3c 01                	cmp    $0x1,%al
  800bb1:	75 03                	jne    800bb6 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800bb3:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800bb6:	ff 45 e0             	incl   -0x20(%ebp)
  800bb9:	a1 20 30 80 00       	mov    0x803020,%eax
  800bbe:	8b 50 74             	mov    0x74(%eax),%edx
  800bc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bc4:	39 c2                	cmp    %eax,%edx
  800bc6:	77 cb                	ja     800b93 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800bcb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800bce:	74 14                	je     800be4 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800bd0:	83 ec 04             	sub    $0x4,%esp
  800bd3:	68 84 2b 80 00       	push   $0x802b84
  800bd8:	6a 44                	push   $0x44
  800bda:	68 24 2b 80 00       	push   $0x802b24
  800bdf:	e8 23 fe ff ff       	call   800a07 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800be4:	90                   	nop
  800be5:	c9                   	leave  
  800be6:	c3                   	ret    

00800be7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800be7:	55                   	push   %ebp
  800be8:	89 e5                	mov    %esp,%ebp
  800bea:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800bed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf0:	8b 00                	mov    (%eax),%eax
  800bf2:	8d 48 01             	lea    0x1(%eax),%ecx
  800bf5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf8:	89 0a                	mov    %ecx,(%edx)
  800bfa:	8b 55 08             	mov    0x8(%ebp),%edx
  800bfd:	88 d1                	mov    %dl,%cl
  800bff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c02:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800c06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c09:	8b 00                	mov    (%eax),%eax
  800c0b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800c10:	75 2c                	jne    800c3e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800c12:	a0 24 30 80 00       	mov    0x803024,%al
  800c17:	0f b6 c0             	movzbl %al,%eax
  800c1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c1d:	8b 12                	mov    (%edx),%edx
  800c1f:	89 d1                	mov    %edx,%ecx
  800c21:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c24:	83 c2 08             	add    $0x8,%edx
  800c27:	83 ec 04             	sub    $0x4,%esp
  800c2a:	50                   	push   %eax
  800c2b:	51                   	push   %ecx
  800c2c:	52                   	push   %edx
  800c2d:	e8 ce 10 00 00       	call   801d00 <sys_cputs>
  800c32:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800c35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c38:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c41:	8b 40 04             	mov    0x4(%eax),%eax
  800c44:	8d 50 01             	lea    0x1(%eax),%edx
  800c47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4a:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c4d:	90                   	nop
  800c4e:	c9                   	leave  
  800c4f:	c3                   	ret    

00800c50 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800c50:	55                   	push   %ebp
  800c51:	89 e5                	mov    %esp,%ebp
  800c53:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c59:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c60:	00 00 00 
	b.cnt = 0;
  800c63:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c6a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c6d:	ff 75 0c             	pushl  0xc(%ebp)
  800c70:	ff 75 08             	pushl  0x8(%ebp)
  800c73:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c79:	50                   	push   %eax
  800c7a:	68 e7 0b 80 00       	push   $0x800be7
  800c7f:	e8 11 02 00 00       	call   800e95 <vprintfmt>
  800c84:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800c87:	a0 24 30 80 00       	mov    0x803024,%al
  800c8c:	0f b6 c0             	movzbl %al,%eax
  800c8f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c95:	83 ec 04             	sub    $0x4,%esp
  800c98:	50                   	push   %eax
  800c99:	52                   	push   %edx
  800c9a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ca0:	83 c0 08             	add    $0x8,%eax
  800ca3:	50                   	push   %eax
  800ca4:	e8 57 10 00 00       	call   801d00 <sys_cputs>
  800ca9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800cac:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800cb3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800cb9:	c9                   	leave  
  800cba:	c3                   	ret    

00800cbb <cprintf>:

int cprintf(const char *fmt, ...) {
  800cbb:	55                   	push   %ebp
  800cbc:	89 e5                	mov    %esp,%ebp
  800cbe:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800cc1:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800cc8:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ccb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	83 ec 08             	sub    $0x8,%esp
  800cd4:	ff 75 f4             	pushl  -0xc(%ebp)
  800cd7:	50                   	push   %eax
  800cd8:	e8 73 ff ff ff       	call   800c50 <vcprintf>
  800cdd:	83 c4 10             	add    $0x10,%esp
  800ce0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ce3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ce6:	c9                   	leave  
  800ce7:	c3                   	ret    

00800ce8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ce8:	55                   	push   %ebp
  800ce9:	89 e5                	mov    %esp,%ebp
  800ceb:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800cee:	e8 1e 12 00 00       	call   801f11 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800cf3:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cf6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	83 ec 08             	sub    $0x8,%esp
  800cff:	ff 75 f4             	pushl  -0xc(%ebp)
  800d02:	50                   	push   %eax
  800d03:	e8 48 ff ff ff       	call   800c50 <vcprintf>
  800d08:	83 c4 10             	add    $0x10,%esp
  800d0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800d0e:	e8 18 12 00 00       	call   801f2b <sys_enable_interrupt>
	return cnt;
  800d13:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d16:	c9                   	leave  
  800d17:	c3                   	ret    

00800d18 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d18:	55                   	push   %ebp
  800d19:	89 e5                	mov    %esp,%ebp
  800d1b:	53                   	push   %ebx
  800d1c:	83 ec 14             	sub    $0x14,%esp
  800d1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d25:	8b 45 14             	mov    0x14(%ebp),%eax
  800d28:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d2b:	8b 45 18             	mov    0x18(%ebp),%eax
  800d2e:	ba 00 00 00 00       	mov    $0x0,%edx
  800d33:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d36:	77 55                	ja     800d8d <printnum+0x75>
  800d38:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d3b:	72 05                	jb     800d42 <printnum+0x2a>
  800d3d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d40:	77 4b                	ja     800d8d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d42:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d45:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d48:	8b 45 18             	mov    0x18(%ebp),%eax
  800d4b:	ba 00 00 00 00       	mov    $0x0,%edx
  800d50:	52                   	push   %edx
  800d51:	50                   	push   %eax
  800d52:	ff 75 f4             	pushl  -0xc(%ebp)
  800d55:	ff 75 f0             	pushl  -0x10(%ebp)
  800d58:	e8 93 15 00 00       	call   8022f0 <__udivdi3>
  800d5d:	83 c4 10             	add    $0x10,%esp
  800d60:	83 ec 04             	sub    $0x4,%esp
  800d63:	ff 75 20             	pushl  0x20(%ebp)
  800d66:	53                   	push   %ebx
  800d67:	ff 75 18             	pushl  0x18(%ebp)
  800d6a:	52                   	push   %edx
  800d6b:	50                   	push   %eax
  800d6c:	ff 75 0c             	pushl  0xc(%ebp)
  800d6f:	ff 75 08             	pushl  0x8(%ebp)
  800d72:	e8 a1 ff ff ff       	call   800d18 <printnum>
  800d77:	83 c4 20             	add    $0x20,%esp
  800d7a:	eb 1a                	jmp    800d96 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d7c:	83 ec 08             	sub    $0x8,%esp
  800d7f:	ff 75 0c             	pushl  0xc(%ebp)
  800d82:	ff 75 20             	pushl  0x20(%ebp)
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	ff d0                	call   *%eax
  800d8a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d8d:	ff 4d 1c             	decl   0x1c(%ebp)
  800d90:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d94:	7f e6                	jg     800d7c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d96:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d99:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800da1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800da4:	53                   	push   %ebx
  800da5:	51                   	push   %ecx
  800da6:	52                   	push   %edx
  800da7:	50                   	push   %eax
  800da8:	e8 53 16 00 00       	call   802400 <__umoddi3>
  800dad:	83 c4 10             	add    $0x10,%esp
  800db0:	05 f4 2d 80 00       	add    $0x802df4,%eax
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	0f be c0             	movsbl %al,%eax
  800dba:	83 ec 08             	sub    $0x8,%esp
  800dbd:	ff 75 0c             	pushl  0xc(%ebp)
  800dc0:	50                   	push   %eax
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	ff d0                	call   *%eax
  800dc6:	83 c4 10             	add    $0x10,%esp
}
  800dc9:	90                   	nop
  800dca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800dcd:	c9                   	leave  
  800dce:	c3                   	ret    

00800dcf <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800dcf:	55                   	push   %ebp
  800dd0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800dd2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800dd6:	7e 1c                	jle    800df4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddb:	8b 00                	mov    (%eax),%eax
  800ddd:	8d 50 08             	lea    0x8(%eax),%edx
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	89 10                	mov    %edx,(%eax)
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	8b 00                	mov    (%eax),%eax
  800dea:	83 e8 08             	sub    $0x8,%eax
  800ded:	8b 50 04             	mov    0x4(%eax),%edx
  800df0:	8b 00                	mov    (%eax),%eax
  800df2:	eb 40                	jmp    800e34 <getuint+0x65>
	else if (lflag)
  800df4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800df8:	74 1e                	je     800e18 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfd:	8b 00                	mov    (%eax),%eax
  800dff:	8d 50 04             	lea    0x4(%eax),%edx
  800e02:	8b 45 08             	mov    0x8(%ebp),%eax
  800e05:	89 10                	mov    %edx,(%eax)
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0a:	8b 00                	mov    (%eax),%eax
  800e0c:	83 e8 04             	sub    $0x4,%eax
  800e0f:	8b 00                	mov    (%eax),%eax
  800e11:	ba 00 00 00 00       	mov    $0x0,%edx
  800e16:	eb 1c                	jmp    800e34 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	8b 00                	mov    (%eax),%eax
  800e1d:	8d 50 04             	lea    0x4(%eax),%edx
  800e20:	8b 45 08             	mov    0x8(%ebp),%eax
  800e23:	89 10                	mov    %edx,(%eax)
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	8b 00                	mov    (%eax),%eax
  800e2a:	83 e8 04             	sub    $0x4,%eax
  800e2d:	8b 00                	mov    (%eax),%eax
  800e2f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e34:	5d                   	pop    %ebp
  800e35:	c3                   	ret    

00800e36 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e36:	55                   	push   %ebp
  800e37:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e39:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e3d:	7e 1c                	jle    800e5b <getint+0x25>
		return va_arg(*ap, long long);
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e42:	8b 00                	mov    (%eax),%eax
  800e44:	8d 50 08             	lea    0x8(%eax),%edx
  800e47:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4a:	89 10                	mov    %edx,(%eax)
  800e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4f:	8b 00                	mov    (%eax),%eax
  800e51:	83 e8 08             	sub    $0x8,%eax
  800e54:	8b 50 04             	mov    0x4(%eax),%edx
  800e57:	8b 00                	mov    (%eax),%eax
  800e59:	eb 38                	jmp    800e93 <getint+0x5d>
	else if (lflag)
  800e5b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e5f:	74 1a                	je     800e7b <getint+0x45>
		return va_arg(*ap, long);
  800e61:	8b 45 08             	mov    0x8(%ebp),%eax
  800e64:	8b 00                	mov    (%eax),%eax
  800e66:	8d 50 04             	lea    0x4(%eax),%edx
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6c:	89 10                	mov    %edx,(%eax)
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	8b 00                	mov    (%eax),%eax
  800e73:	83 e8 04             	sub    $0x4,%eax
  800e76:	8b 00                	mov    (%eax),%eax
  800e78:	99                   	cltd   
  800e79:	eb 18                	jmp    800e93 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7e:	8b 00                	mov    (%eax),%eax
  800e80:	8d 50 04             	lea    0x4(%eax),%edx
  800e83:	8b 45 08             	mov    0x8(%ebp),%eax
  800e86:	89 10                	mov    %edx,(%eax)
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	8b 00                	mov    (%eax),%eax
  800e8d:	83 e8 04             	sub    $0x4,%eax
  800e90:	8b 00                	mov    (%eax),%eax
  800e92:	99                   	cltd   
}
  800e93:	5d                   	pop    %ebp
  800e94:	c3                   	ret    

00800e95 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e95:	55                   	push   %ebp
  800e96:	89 e5                	mov    %esp,%ebp
  800e98:	56                   	push   %esi
  800e99:	53                   	push   %ebx
  800e9a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e9d:	eb 17                	jmp    800eb6 <vprintfmt+0x21>
			if (ch == '\0')
  800e9f:	85 db                	test   %ebx,%ebx
  800ea1:	0f 84 af 03 00 00    	je     801256 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ea7:	83 ec 08             	sub    $0x8,%esp
  800eaa:	ff 75 0c             	pushl  0xc(%ebp)
  800ead:	53                   	push   %ebx
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	ff d0                	call   *%eax
  800eb3:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800eb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb9:	8d 50 01             	lea    0x1(%eax),%edx
  800ebc:	89 55 10             	mov    %edx,0x10(%ebp)
  800ebf:	8a 00                	mov    (%eax),%al
  800ec1:	0f b6 d8             	movzbl %al,%ebx
  800ec4:	83 fb 25             	cmp    $0x25,%ebx
  800ec7:	75 d6                	jne    800e9f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800ec9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ecd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ed4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800edb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ee2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ee9:	8b 45 10             	mov    0x10(%ebp),%eax
  800eec:	8d 50 01             	lea    0x1(%eax),%edx
  800eef:	89 55 10             	mov    %edx,0x10(%ebp)
  800ef2:	8a 00                	mov    (%eax),%al
  800ef4:	0f b6 d8             	movzbl %al,%ebx
  800ef7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800efa:	83 f8 55             	cmp    $0x55,%eax
  800efd:	0f 87 2b 03 00 00    	ja     80122e <vprintfmt+0x399>
  800f03:	8b 04 85 18 2e 80 00 	mov    0x802e18(,%eax,4),%eax
  800f0a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800f0c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800f10:	eb d7                	jmp    800ee9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800f12:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800f16:	eb d1                	jmp    800ee9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f18:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f1f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f22:	89 d0                	mov    %edx,%eax
  800f24:	c1 e0 02             	shl    $0x2,%eax
  800f27:	01 d0                	add    %edx,%eax
  800f29:	01 c0                	add    %eax,%eax
  800f2b:	01 d8                	add    %ebx,%eax
  800f2d:	83 e8 30             	sub    $0x30,%eax
  800f30:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f33:	8b 45 10             	mov    0x10(%ebp),%eax
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f3b:	83 fb 2f             	cmp    $0x2f,%ebx
  800f3e:	7e 3e                	jle    800f7e <vprintfmt+0xe9>
  800f40:	83 fb 39             	cmp    $0x39,%ebx
  800f43:	7f 39                	jg     800f7e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f45:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f48:	eb d5                	jmp    800f1f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f4a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4d:	83 c0 04             	add    $0x4,%eax
  800f50:	89 45 14             	mov    %eax,0x14(%ebp)
  800f53:	8b 45 14             	mov    0x14(%ebp),%eax
  800f56:	83 e8 04             	sub    $0x4,%eax
  800f59:	8b 00                	mov    (%eax),%eax
  800f5b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f5e:	eb 1f                	jmp    800f7f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f60:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f64:	79 83                	jns    800ee9 <vprintfmt+0x54>
				width = 0;
  800f66:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f6d:	e9 77 ff ff ff       	jmp    800ee9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f72:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f79:	e9 6b ff ff ff       	jmp    800ee9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f7e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f7f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f83:	0f 89 60 ff ff ff    	jns    800ee9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800f89:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f8c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f8f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f96:	e9 4e ff ff ff       	jmp    800ee9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f9b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f9e:	e9 46 ff ff ff       	jmp    800ee9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800fa3:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa6:	83 c0 04             	add    $0x4,%eax
  800fa9:	89 45 14             	mov    %eax,0x14(%ebp)
  800fac:	8b 45 14             	mov    0x14(%ebp),%eax
  800faf:	83 e8 04             	sub    $0x4,%eax
  800fb2:	8b 00                	mov    (%eax),%eax
  800fb4:	83 ec 08             	sub    $0x8,%esp
  800fb7:	ff 75 0c             	pushl  0xc(%ebp)
  800fba:	50                   	push   %eax
  800fbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbe:	ff d0                	call   *%eax
  800fc0:	83 c4 10             	add    $0x10,%esp
			break;
  800fc3:	e9 89 02 00 00       	jmp    801251 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800fc8:	8b 45 14             	mov    0x14(%ebp),%eax
  800fcb:	83 c0 04             	add    $0x4,%eax
  800fce:	89 45 14             	mov    %eax,0x14(%ebp)
  800fd1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd4:	83 e8 04             	sub    $0x4,%eax
  800fd7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800fd9:	85 db                	test   %ebx,%ebx
  800fdb:	79 02                	jns    800fdf <vprintfmt+0x14a>
				err = -err;
  800fdd:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800fdf:	83 fb 64             	cmp    $0x64,%ebx
  800fe2:	7f 0b                	jg     800fef <vprintfmt+0x15a>
  800fe4:	8b 34 9d 60 2c 80 00 	mov    0x802c60(,%ebx,4),%esi
  800feb:	85 f6                	test   %esi,%esi
  800fed:	75 19                	jne    801008 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800fef:	53                   	push   %ebx
  800ff0:	68 05 2e 80 00       	push   $0x802e05
  800ff5:	ff 75 0c             	pushl  0xc(%ebp)
  800ff8:	ff 75 08             	pushl  0x8(%ebp)
  800ffb:	e8 5e 02 00 00       	call   80125e <printfmt>
  801000:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801003:	e9 49 02 00 00       	jmp    801251 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801008:	56                   	push   %esi
  801009:	68 0e 2e 80 00       	push   $0x802e0e
  80100e:	ff 75 0c             	pushl  0xc(%ebp)
  801011:	ff 75 08             	pushl  0x8(%ebp)
  801014:	e8 45 02 00 00       	call   80125e <printfmt>
  801019:	83 c4 10             	add    $0x10,%esp
			break;
  80101c:	e9 30 02 00 00       	jmp    801251 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801021:	8b 45 14             	mov    0x14(%ebp),%eax
  801024:	83 c0 04             	add    $0x4,%eax
  801027:	89 45 14             	mov    %eax,0x14(%ebp)
  80102a:	8b 45 14             	mov    0x14(%ebp),%eax
  80102d:	83 e8 04             	sub    $0x4,%eax
  801030:	8b 30                	mov    (%eax),%esi
  801032:	85 f6                	test   %esi,%esi
  801034:	75 05                	jne    80103b <vprintfmt+0x1a6>
				p = "(null)";
  801036:	be 11 2e 80 00       	mov    $0x802e11,%esi
			if (width > 0 && padc != '-')
  80103b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80103f:	7e 6d                	jle    8010ae <vprintfmt+0x219>
  801041:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801045:	74 67                	je     8010ae <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801047:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80104a:	83 ec 08             	sub    $0x8,%esp
  80104d:	50                   	push   %eax
  80104e:	56                   	push   %esi
  80104f:	e8 0c 03 00 00       	call   801360 <strnlen>
  801054:	83 c4 10             	add    $0x10,%esp
  801057:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80105a:	eb 16                	jmp    801072 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80105c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801060:	83 ec 08             	sub    $0x8,%esp
  801063:	ff 75 0c             	pushl  0xc(%ebp)
  801066:	50                   	push   %eax
  801067:	8b 45 08             	mov    0x8(%ebp),%eax
  80106a:	ff d0                	call   *%eax
  80106c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80106f:	ff 4d e4             	decl   -0x1c(%ebp)
  801072:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801076:	7f e4                	jg     80105c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801078:	eb 34                	jmp    8010ae <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80107a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80107e:	74 1c                	je     80109c <vprintfmt+0x207>
  801080:	83 fb 1f             	cmp    $0x1f,%ebx
  801083:	7e 05                	jle    80108a <vprintfmt+0x1f5>
  801085:	83 fb 7e             	cmp    $0x7e,%ebx
  801088:	7e 12                	jle    80109c <vprintfmt+0x207>
					putch('?', putdat);
  80108a:	83 ec 08             	sub    $0x8,%esp
  80108d:	ff 75 0c             	pushl  0xc(%ebp)
  801090:	6a 3f                	push   $0x3f
  801092:	8b 45 08             	mov    0x8(%ebp),%eax
  801095:	ff d0                	call   *%eax
  801097:	83 c4 10             	add    $0x10,%esp
  80109a:	eb 0f                	jmp    8010ab <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80109c:	83 ec 08             	sub    $0x8,%esp
  80109f:	ff 75 0c             	pushl  0xc(%ebp)
  8010a2:	53                   	push   %ebx
  8010a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a6:	ff d0                	call   *%eax
  8010a8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010ab:	ff 4d e4             	decl   -0x1c(%ebp)
  8010ae:	89 f0                	mov    %esi,%eax
  8010b0:	8d 70 01             	lea    0x1(%eax),%esi
  8010b3:	8a 00                	mov    (%eax),%al
  8010b5:	0f be d8             	movsbl %al,%ebx
  8010b8:	85 db                	test   %ebx,%ebx
  8010ba:	74 24                	je     8010e0 <vprintfmt+0x24b>
  8010bc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010c0:	78 b8                	js     80107a <vprintfmt+0x1e5>
  8010c2:	ff 4d e0             	decl   -0x20(%ebp)
  8010c5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010c9:	79 af                	jns    80107a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010cb:	eb 13                	jmp    8010e0 <vprintfmt+0x24b>
				putch(' ', putdat);
  8010cd:	83 ec 08             	sub    $0x8,%esp
  8010d0:	ff 75 0c             	pushl  0xc(%ebp)
  8010d3:	6a 20                	push   $0x20
  8010d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d8:	ff d0                	call   *%eax
  8010da:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010dd:	ff 4d e4             	decl   -0x1c(%ebp)
  8010e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010e4:	7f e7                	jg     8010cd <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010e6:	e9 66 01 00 00       	jmp    801251 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010eb:	83 ec 08             	sub    $0x8,%esp
  8010ee:	ff 75 e8             	pushl  -0x18(%ebp)
  8010f1:	8d 45 14             	lea    0x14(%ebp),%eax
  8010f4:	50                   	push   %eax
  8010f5:	e8 3c fd ff ff       	call   800e36 <getint>
  8010fa:	83 c4 10             	add    $0x10,%esp
  8010fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801100:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801103:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801106:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801109:	85 d2                	test   %edx,%edx
  80110b:	79 23                	jns    801130 <vprintfmt+0x29b>
				putch('-', putdat);
  80110d:	83 ec 08             	sub    $0x8,%esp
  801110:	ff 75 0c             	pushl  0xc(%ebp)
  801113:	6a 2d                	push   $0x2d
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	ff d0                	call   *%eax
  80111a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80111d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801120:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801123:	f7 d8                	neg    %eax
  801125:	83 d2 00             	adc    $0x0,%edx
  801128:	f7 da                	neg    %edx
  80112a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80112d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801130:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801137:	e9 bc 00 00 00       	jmp    8011f8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80113c:	83 ec 08             	sub    $0x8,%esp
  80113f:	ff 75 e8             	pushl  -0x18(%ebp)
  801142:	8d 45 14             	lea    0x14(%ebp),%eax
  801145:	50                   	push   %eax
  801146:	e8 84 fc ff ff       	call   800dcf <getuint>
  80114b:	83 c4 10             	add    $0x10,%esp
  80114e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801151:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801154:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80115b:	e9 98 00 00 00       	jmp    8011f8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801160:	83 ec 08             	sub    $0x8,%esp
  801163:	ff 75 0c             	pushl  0xc(%ebp)
  801166:	6a 58                	push   $0x58
  801168:	8b 45 08             	mov    0x8(%ebp),%eax
  80116b:	ff d0                	call   *%eax
  80116d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801170:	83 ec 08             	sub    $0x8,%esp
  801173:	ff 75 0c             	pushl  0xc(%ebp)
  801176:	6a 58                	push   $0x58
  801178:	8b 45 08             	mov    0x8(%ebp),%eax
  80117b:	ff d0                	call   *%eax
  80117d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801180:	83 ec 08             	sub    $0x8,%esp
  801183:	ff 75 0c             	pushl  0xc(%ebp)
  801186:	6a 58                	push   $0x58
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	ff d0                	call   *%eax
  80118d:	83 c4 10             	add    $0x10,%esp
			break;
  801190:	e9 bc 00 00 00       	jmp    801251 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801195:	83 ec 08             	sub    $0x8,%esp
  801198:	ff 75 0c             	pushl  0xc(%ebp)
  80119b:	6a 30                	push   $0x30
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	ff d0                	call   *%eax
  8011a2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8011a5:	83 ec 08             	sub    $0x8,%esp
  8011a8:	ff 75 0c             	pushl  0xc(%ebp)
  8011ab:	6a 78                	push   $0x78
  8011ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b0:	ff d0                	call   *%eax
  8011b2:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8011b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b8:	83 c0 04             	add    $0x4,%eax
  8011bb:	89 45 14             	mov    %eax,0x14(%ebp)
  8011be:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c1:	83 e8 04             	sub    $0x4,%eax
  8011c4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8011c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8011d0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011d7:	eb 1f                	jmp    8011f8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011d9:	83 ec 08             	sub    $0x8,%esp
  8011dc:	ff 75 e8             	pushl  -0x18(%ebp)
  8011df:	8d 45 14             	lea    0x14(%ebp),%eax
  8011e2:	50                   	push   %eax
  8011e3:	e8 e7 fb ff ff       	call   800dcf <getuint>
  8011e8:	83 c4 10             	add    $0x10,%esp
  8011eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011ee:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8011f1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8011f8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8011fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011ff:	83 ec 04             	sub    $0x4,%esp
  801202:	52                   	push   %edx
  801203:	ff 75 e4             	pushl  -0x1c(%ebp)
  801206:	50                   	push   %eax
  801207:	ff 75 f4             	pushl  -0xc(%ebp)
  80120a:	ff 75 f0             	pushl  -0x10(%ebp)
  80120d:	ff 75 0c             	pushl  0xc(%ebp)
  801210:	ff 75 08             	pushl  0x8(%ebp)
  801213:	e8 00 fb ff ff       	call   800d18 <printnum>
  801218:	83 c4 20             	add    $0x20,%esp
			break;
  80121b:	eb 34                	jmp    801251 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80121d:	83 ec 08             	sub    $0x8,%esp
  801220:	ff 75 0c             	pushl  0xc(%ebp)
  801223:	53                   	push   %ebx
  801224:	8b 45 08             	mov    0x8(%ebp),%eax
  801227:	ff d0                	call   *%eax
  801229:	83 c4 10             	add    $0x10,%esp
			break;
  80122c:	eb 23                	jmp    801251 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80122e:	83 ec 08             	sub    $0x8,%esp
  801231:	ff 75 0c             	pushl  0xc(%ebp)
  801234:	6a 25                	push   $0x25
  801236:	8b 45 08             	mov    0x8(%ebp),%eax
  801239:	ff d0                	call   *%eax
  80123b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80123e:	ff 4d 10             	decl   0x10(%ebp)
  801241:	eb 03                	jmp    801246 <vprintfmt+0x3b1>
  801243:	ff 4d 10             	decl   0x10(%ebp)
  801246:	8b 45 10             	mov    0x10(%ebp),%eax
  801249:	48                   	dec    %eax
  80124a:	8a 00                	mov    (%eax),%al
  80124c:	3c 25                	cmp    $0x25,%al
  80124e:	75 f3                	jne    801243 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801250:	90                   	nop
		}
	}
  801251:	e9 47 fc ff ff       	jmp    800e9d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801256:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801257:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80125a:	5b                   	pop    %ebx
  80125b:	5e                   	pop    %esi
  80125c:	5d                   	pop    %ebp
  80125d:	c3                   	ret    

0080125e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80125e:	55                   	push   %ebp
  80125f:	89 e5                	mov    %esp,%ebp
  801261:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801264:	8d 45 10             	lea    0x10(%ebp),%eax
  801267:	83 c0 04             	add    $0x4,%eax
  80126a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80126d:	8b 45 10             	mov    0x10(%ebp),%eax
  801270:	ff 75 f4             	pushl  -0xc(%ebp)
  801273:	50                   	push   %eax
  801274:	ff 75 0c             	pushl  0xc(%ebp)
  801277:	ff 75 08             	pushl  0x8(%ebp)
  80127a:	e8 16 fc ff ff       	call   800e95 <vprintfmt>
  80127f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801282:	90                   	nop
  801283:	c9                   	leave  
  801284:	c3                   	ret    

00801285 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801285:	55                   	push   %ebp
  801286:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801288:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128b:	8b 40 08             	mov    0x8(%eax),%eax
  80128e:	8d 50 01             	lea    0x1(%eax),%edx
  801291:	8b 45 0c             	mov    0xc(%ebp),%eax
  801294:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129a:	8b 10                	mov    (%eax),%edx
  80129c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129f:	8b 40 04             	mov    0x4(%eax),%eax
  8012a2:	39 c2                	cmp    %eax,%edx
  8012a4:	73 12                	jae    8012b8 <sprintputch+0x33>
		*b->buf++ = ch;
  8012a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a9:	8b 00                	mov    (%eax),%eax
  8012ab:	8d 48 01             	lea    0x1(%eax),%ecx
  8012ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b1:	89 0a                	mov    %ecx,(%edx)
  8012b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8012b6:	88 10                	mov    %dl,(%eax)
}
  8012b8:	90                   	nop
  8012b9:	5d                   	pop    %ebp
  8012ba:	c3                   	ret    

008012bb <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8012bb:	55                   	push   %ebp
  8012bc:	89 e5                	mov    %esp,%ebp
  8012be:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8012c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ca:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	01 d0                	add    %edx,%eax
  8012d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8012dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012e0:	74 06                	je     8012e8 <vsnprintf+0x2d>
  8012e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012e6:	7f 07                	jg     8012ef <vsnprintf+0x34>
		return -E_INVAL;
  8012e8:	b8 03 00 00 00       	mov    $0x3,%eax
  8012ed:	eb 20                	jmp    80130f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8012ef:	ff 75 14             	pushl  0x14(%ebp)
  8012f2:	ff 75 10             	pushl  0x10(%ebp)
  8012f5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8012f8:	50                   	push   %eax
  8012f9:	68 85 12 80 00       	push   $0x801285
  8012fe:	e8 92 fb ff ff       	call   800e95 <vprintfmt>
  801303:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801306:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801309:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80130c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80130f:	c9                   	leave  
  801310:	c3                   	ret    

00801311 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801311:	55                   	push   %ebp
  801312:	89 e5                	mov    %esp,%ebp
  801314:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801317:	8d 45 10             	lea    0x10(%ebp),%eax
  80131a:	83 c0 04             	add    $0x4,%eax
  80131d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801320:	8b 45 10             	mov    0x10(%ebp),%eax
  801323:	ff 75 f4             	pushl  -0xc(%ebp)
  801326:	50                   	push   %eax
  801327:	ff 75 0c             	pushl  0xc(%ebp)
  80132a:	ff 75 08             	pushl  0x8(%ebp)
  80132d:	e8 89 ff ff ff       	call   8012bb <vsnprintf>
  801332:	83 c4 10             	add    $0x10,%esp
  801335:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801338:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80133b:	c9                   	leave  
  80133c:	c3                   	ret    

0080133d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80133d:	55                   	push   %ebp
  80133e:	89 e5                	mov    %esp,%ebp
  801340:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801343:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80134a:	eb 06                	jmp    801352 <strlen+0x15>
		n++;
  80134c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80134f:	ff 45 08             	incl   0x8(%ebp)
  801352:	8b 45 08             	mov    0x8(%ebp),%eax
  801355:	8a 00                	mov    (%eax),%al
  801357:	84 c0                	test   %al,%al
  801359:	75 f1                	jne    80134c <strlen+0xf>
		n++;
	return n;
  80135b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80135e:	c9                   	leave  
  80135f:	c3                   	ret    

00801360 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801360:	55                   	push   %ebp
  801361:	89 e5                	mov    %esp,%ebp
  801363:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801366:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80136d:	eb 09                	jmp    801378 <strnlen+0x18>
		n++;
  80136f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801372:	ff 45 08             	incl   0x8(%ebp)
  801375:	ff 4d 0c             	decl   0xc(%ebp)
  801378:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80137c:	74 09                	je     801387 <strnlen+0x27>
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	8a 00                	mov    (%eax),%al
  801383:	84 c0                	test   %al,%al
  801385:	75 e8                	jne    80136f <strnlen+0xf>
		n++;
	return n;
  801387:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80138a:	c9                   	leave  
  80138b:	c3                   	ret    

0080138c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80138c:	55                   	push   %ebp
  80138d:	89 e5                	mov    %esp,%ebp
  80138f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801398:	90                   	nop
  801399:	8b 45 08             	mov    0x8(%ebp),%eax
  80139c:	8d 50 01             	lea    0x1(%eax),%edx
  80139f:	89 55 08             	mov    %edx,0x8(%ebp)
  8013a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013a8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013ab:	8a 12                	mov    (%edx),%dl
  8013ad:	88 10                	mov    %dl,(%eax)
  8013af:	8a 00                	mov    (%eax),%al
  8013b1:	84 c0                	test   %al,%al
  8013b3:	75 e4                	jne    801399 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013b8:	c9                   	leave  
  8013b9:	c3                   	ret    

008013ba <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013ba:	55                   	push   %ebp
  8013bb:	89 e5                	mov    %esp,%ebp
  8013bd:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013cd:	eb 1f                	jmp    8013ee <strncpy+0x34>
		*dst++ = *src;
  8013cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d2:	8d 50 01             	lea    0x1(%eax),%edx
  8013d5:	89 55 08             	mov    %edx,0x8(%ebp)
  8013d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013db:	8a 12                	mov    (%edx),%dl
  8013dd:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e2:	8a 00                	mov    (%eax),%al
  8013e4:	84 c0                	test   %al,%al
  8013e6:	74 03                	je     8013eb <strncpy+0x31>
			src++;
  8013e8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013eb:	ff 45 fc             	incl   -0x4(%ebp)
  8013ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013f4:	72 d9                	jb     8013cf <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
  8013fe:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801401:	8b 45 08             	mov    0x8(%ebp),%eax
  801404:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801407:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80140b:	74 30                	je     80143d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80140d:	eb 16                	jmp    801425 <strlcpy+0x2a>
			*dst++ = *src++;
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	8d 50 01             	lea    0x1(%eax),%edx
  801415:	89 55 08             	mov    %edx,0x8(%ebp)
  801418:	8b 55 0c             	mov    0xc(%ebp),%edx
  80141b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80141e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801421:	8a 12                	mov    (%edx),%dl
  801423:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801425:	ff 4d 10             	decl   0x10(%ebp)
  801428:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80142c:	74 09                	je     801437 <strlcpy+0x3c>
  80142e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801431:	8a 00                	mov    (%eax),%al
  801433:	84 c0                	test   %al,%al
  801435:	75 d8                	jne    80140f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801437:	8b 45 08             	mov    0x8(%ebp),%eax
  80143a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80143d:	8b 55 08             	mov    0x8(%ebp),%edx
  801440:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801443:	29 c2                	sub    %eax,%edx
  801445:	89 d0                	mov    %edx,%eax
}
  801447:	c9                   	leave  
  801448:	c3                   	ret    

00801449 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80144c:	eb 06                	jmp    801454 <strcmp+0xb>
		p++, q++;
  80144e:	ff 45 08             	incl   0x8(%ebp)
  801451:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801454:	8b 45 08             	mov    0x8(%ebp),%eax
  801457:	8a 00                	mov    (%eax),%al
  801459:	84 c0                	test   %al,%al
  80145b:	74 0e                	je     80146b <strcmp+0x22>
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	8a 10                	mov    (%eax),%dl
  801462:	8b 45 0c             	mov    0xc(%ebp),%eax
  801465:	8a 00                	mov    (%eax),%al
  801467:	38 c2                	cmp    %al,%dl
  801469:	74 e3                	je     80144e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
  80146e:	8a 00                	mov    (%eax),%al
  801470:	0f b6 d0             	movzbl %al,%edx
  801473:	8b 45 0c             	mov    0xc(%ebp),%eax
  801476:	8a 00                	mov    (%eax),%al
  801478:	0f b6 c0             	movzbl %al,%eax
  80147b:	29 c2                	sub    %eax,%edx
  80147d:	89 d0                	mov    %edx,%eax
}
  80147f:	5d                   	pop    %ebp
  801480:	c3                   	ret    

00801481 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801484:	eb 09                	jmp    80148f <strncmp+0xe>
		n--, p++, q++;
  801486:	ff 4d 10             	decl   0x10(%ebp)
  801489:	ff 45 08             	incl   0x8(%ebp)
  80148c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80148f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801493:	74 17                	je     8014ac <strncmp+0x2b>
  801495:	8b 45 08             	mov    0x8(%ebp),%eax
  801498:	8a 00                	mov    (%eax),%al
  80149a:	84 c0                	test   %al,%al
  80149c:	74 0e                	je     8014ac <strncmp+0x2b>
  80149e:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a1:	8a 10                	mov    (%eax),%dl
  8014a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a6:	8a 00                	mov    (%eax),%al
  8014a8:	38 c2                	cmp    %al,%dl
  8014aa:	74 da                	je     801486 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014b0:	75 07                	jne    8014b9 <strncmp+0x38>
		return 0;
  8014b2:	b8 00 00 00 00       	mov    $0x0,%eax
  8014b7:	eb 14                	jmp    8014cd <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	8a 00                	mov    (%eax),%al
  8014be:	0f b6 d0             	movzbl %al,%edx
  8014c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c4:	8a 00                	mov    (%eax),%al
  8014c6:	0f b6 c0             	movzbl %al,%eax
  8014c9:	29 c2                	sub    %eax,%edx
  8014cb:	89 d0                	mov    %edx,%eax
}
  8014cd:	5d                   	pop    %ebp
  8014ce:	c3                   	ret    

008014cf <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014cf:	55                   	push   %ebp
  8014d0:	89 e5                	mov    %esp,%ebp
  8014d2:	83 ec 04             	sub    $0x4,%esp
  8014d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014db:	eb 12                	jmp    8014ef <strchr+0x20>
		if (*s == c)
  8014dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e0:	8a 00                	mov    (%eax),%al
  8014e2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014e5:	75 05                	jne    8014ec <strchr+0x1d>
			return (char *) s;
  8014e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ea:	eb 11                	jmp    8014fd <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014ec:	ff 45 08             	incl   0x8(%ebp)
  8014ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f2:	8a 00                	mov    (%eax),%al
  8014f4:	84 c0                	test   %al,%al
  8014f6:	75 e5                	jne    8014dd <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014fd:	c9                   	leave  
  8014fe:	c3                   	ret    

008014ff <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014ff:	55                   	push   %ebp
  801500:	89 e5                	mov    %esp,%ebp
  801502:	83 ec 04             	sub    $0x4,%esp
  801505:	8b 45 0c             	mov    0xc(%ebp),%eax
  801508:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80150b:	eb 0d                	jmp    80151a <strfind+0x1b>
		if (*s == c)
  80150d:	8b 45 08             	mov    0x8(%ebp),%eax
  801510:	8a 00                	mov    (%eax),%al
  801512:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801515:	74 0e                	je     801525 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801517:	ff 45 08             	incl   0x8(%ebp)
  80151a:	8b 45 08             	mov    0x8(%ebp),%eax
  80151d:	8a 00                	mov    (%eax),%al
  80151f:	84 c0                	test   %al,%al
  801521:	75 ea                	jne    80150d <strfind+0xe>
  801523:	eb 01                	jmp    801526 <strfind+0x27>
		if (*s == c)
			break;
  801525:	90                   	nop
	return (char *) s;
  801526:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801529:	c9                   	leave  
  80152a:	c3                   	ret    

0080152b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80152b:	55                   	push   %ebp
  80152c:	89 e5                	mov    %esp,%ebp
  80152e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801531:	8b 45 08             	mov    0x8(%ebp),%eax
  801534:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801537:	8b 45 10             	mov    0x10(%ebp),%eax
  80153a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80153d:	eb 0e                	jmp    80154d <memset+0x22>
		*p++ = c;
  80153f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801542:	8d 50 01             	lea    0x1(%eax),%edx
  801545:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801548:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80154d:	ff 4d f8             	decl   -0x8(%ebp)
  801550:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801554:	79 e9                	jns    80153f <memset+0x14>
		*p++ = c;

	return v;
  801556:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801559:	c9                   	leave  
  80155a:	c3                   	ret    

0080155b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80155b:	55                   	push   %ebp
  80155c:	89 e5                	mov    %esp,%ebp
  80155e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801561:	8b 45 0c             	mov    0xc(%ebp),%eax
  801564:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801567:	8b 45 08             	mov    0x8(%ebp),%eax
  80156a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80156d:	eb 16                	jmp    801585 <memcpy+0x2a>
		*d++ = *s++;
  80156f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801572:	8d 50 01             	lea    0x1(%eax),%edx
  801575:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801578:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80157b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80157e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801581:	8a 12                	mov    (%edx),%dl
  801583:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801585:	8b 45 10             	mov    0x10(%ebp),%eax
  801588:	8d 50 ff             	lea    -0x1(%eax),%edx
  80158b:	89 55 10             	mov    %edx,0x10(%ebp)
  80158e:	85 c0                	test   %eax,%eax
  801590:	75 dd                	jne    80156f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801592:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801595:	c9                   	leave  
  801596:	c3                   	ret    

00801597 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801597:	55                   	push   %ebp
  801598:	89 e5                	mov    %esp,%ebp
  80159a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80159d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8015a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8015a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015af:	73 50                	jae    801601 <memmove+0x6a>
  8015b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b7:	01 d0                	add    %edx,%eax
  8015b9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015bc:	76 43                	jbe    801601 <memmove+0x6a>
		s += n;
  8015be:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c1:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c7:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015ca:	eb 10                	jmp    8015dc <memmove+0x45>
			*--d = *--s;
  8015cc:	ff 4d f8             	decl   -0x8(%ebp)
  8015cf:	ff 4d fc             	decl   -0x4(%ebp)
  8015d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d5:	8a 10                	mov    (%eax),%dl
  8015d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015da:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015df:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015e2:	89 55 10             	mov    %edx,0x10(%ebp)
  8015e5:	85 c0                	test   %eax,%eax
  8015e7:	75 e3                	jne    8015cc <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015e9:	eb 23                	jmp    80160e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ee:	8d 50 01             	lea    0x1(%eax),%edx
  8015f1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015fa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015fd:	8a 12                	mov    (%edx),%dl
  8015ff:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801601:	8b 45 10             	mov    0x10(%ebp),%eax
  801604:	8d 50 ff             	lea    -0x1(%eax),%edx
  801607:	89 55 10             	mov    %edx,0x10(%ebp)
  80160a:	85 c0                	test   %eax,%eax
  80160c:	75 dd                	jne    8015eb <memmove+0x54>
			*d++ = *s++;

	return dst;
  80160e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801611:	c9                   	leave  
  801612:	c3                   	ret    

00801613 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801613:	55                   	push   %ebp
  801614:	89 e5                	mov    %esp,%ebp
  801616:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801619:	8b 45 08             	mov    0x8(%ebp),%eax
  80161c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80161f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801622:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801625:	eb 2a                	jmp    801651 <memcmp+0x3e>
		if (*s1 != *s2)
  801627:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80162a:	8a 10                	mov    (%eax),%dl
  80162c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80162f:	8a 00                	mov    (%eax),%al
  801631:	38 c2                	cmp    %al,%dl
  801633:	74 16                	je     80164b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801635:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801638:	8a 00                	mov    (%eax),%al
  80163a:	0f b6 d0             	movzbl %al,%edx
  80163d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801640:	8a 00                	mov    (%eax),%al
  801642:	0f b6 c0             	movzbl %al,%eax
  801645:	29 c2                	sub    %eax,%edx
  801647:	89 d0                	mov    %edx,%eax
  801649:	eb 18                	jmp    801663 <memcmp+0x50>
		s1++, s2++;
  80164b:	ff 45 fc             	incl   -0x4(%ebp)
  80164e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801651:	8b 45 10             	mov    0x10(%ebp),%eax
  801654:	8d 50 ff             	lea    -0x1(%eax),%edx
  801657:	89 55 10             	mov    %edx,0x10(%ebp)
  80165a:	85 c0                	test   %eax,%eax
  80165c:	75 c9                	jne    801627 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80165e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801663:	c9                   	leave  
  801664:	c3                   	ret    

00801665 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801665:	55                   	push   %ebp
  801666:	89 e5                	mov    %esp,%ebp
  801668:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80166b:	8b 55 08             	mov    0x8(%ebp),%edx
  80166e:	8b 45 10             	mov    0x10(%ebp),%eax
  801671:	01 d0                	add    %edx,%eax
  801673:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801676:	eb 15                	jmp    80168d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801678:	8b 45 08             	mov    0x8(%ebp),%eax
  80167b:	8a 00                	mov    (%eax),%al
  80167d:	0f b6 d0             	movzbl %al,%edx
  801680:	8b 45 0c             	mov    0xc(%ebp),%eax
  801683:	0f b6 c0             	movzbl %al,%eax
  801686:	39 c2                	cmp    %eax,%edx
  801688:	74 0d                	je     801697 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80168a:	ff 45 08             	incl   0x8(%ebp)
  80168d:	8b 45 08             	mov    0x8(%ebp),%eax
  801690:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801693:	72 e3                	jb     801678 <memfind+0x13>
  801695:	eb 01                	jmp    801698 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801697:	90                   	nop
	return (void *) s;
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80169b:	c9                   	leave  
  80169c:	c3                   	ret    

0080169d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80169d:	55                   	push   %ebp
  80169e:	89 e5                	mov    %esp,%ebp
  8016a0:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8016a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8016aa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016b1:	eb 03                	jmp    8016b6 <strtol+0x19>
		s++;
  8016b3:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	8a 00                	mov    (%eax),%al
  8016bb:	3c 20                	cmp    $0x20,%al
  8016bd:	74 f4                	je     8016b3 <strtol+0x16>
  8016bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c2:	8a 00                	mov    (%eax),%al
  8016c4:	3c 09                	cmp    $0x9,%al
  8016c6:	74 eb                	je     8016b3 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cb:	8a 00                	mov    (%eax),%al
  8016cd:	3c 2b                	cmp    $0x2b,%al
  8016cf:	75 05                	jne    8016d6 <strtol+0x39>
		s++;
  8016d1:	ff 45 08             	incl   0x8(%ebp)
  8016d4:	eb 13                	jmp    8016e9 <strtol+0x4c>
	else if (*s == '-')
  8016d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d9:	8a 00                	mov    (%eax),%al
  8016db:	3c 2d                	cmp    $0x2d,%al
  8016dd:	75 0a                	jne    8016e9 <strtol+0x4c>
		s++, neg = 1;
  8016df:	ff 45 08             	incl   0x8(%ebp)
  8016e2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016ed:	74 06                	je     8016f5 <strtol+0x58>
  8016ef:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016f3:	75 20                	jne    801715 <strtol+0x78>
  8016f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f8:	8a 00                	mov    (%eax),%al
  8016fa:	3c 30                	cmp    $0x30,%al
  8016fc:	75 17                	jne    801715 <strtol+0x78>
  8016fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801701:	40                   	inc    %eax
  801702:	8a 00                	mov    (%eax),%al
  801704:	3c 78                	cmp    $0x78,%al
  801706:	75 0d                	jne    801715 <strtol+0x78>
		s += 2, base = 16;
  801708:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80170c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801713:	eb 28                	jmp    80173d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801715:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801719:	75 15                	jne    801730 <strtol+0x93>
  80171b:	8b 45 08             	mov    0x8(%ebp),%eax
  80171e:	8a 00                	mov    (%eax),%al
  801720:	3c 30                	cmp    $0x30,%al
  801722:	75 0c                	jne    801730 <strtol+0x93>
		s++, base = 8;
  801724:	ff 45 08             	incl   0x8(%ebp)
  801727:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80172e:	eb 0d                	jmp    80173d <strtol+0xa0>
	else if (base == 0)
  801730:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801734:	75 07                	jne    80173d <strtol+0xa0>
		base = 10;
  801736:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80173d:	8b 45 08             	mov    0x8(%ebp),%eax
  801740:	8a 00                	mov    (%eax),%al
  801742:	3c 2f                	cmp    $0x2f,%al
  801744:	7e 19                	jle    80175f <strtol+0xc2>
  801746:	8b 45 08             	mov    0x8(%ebp),%eax
  801749:	8a 00                	mov    (%eax),%al
  80174b:	3c 39                	cmp    $0x39,%al
  80174d:	7f 10                	jg     80175f <strtol+0xc2>
			dig = *s - '0';
  80174f:	8b 45 08             	mov    0x8(%ebp),%eax
  801752:	8a 00                	mov    (%eax),%al
  801754:	0f be c0             	movsbl %al,%eax
  801757:	83 e8 30             	sub    $0x30,%eax
  80175a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80175d:	eb 42                	jmp    8017a1 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80175f:	8b 45 08             	mov    0x8(%ebp),%eax
  801762:	8a 00                	mov    (%eax),%al
  801764:	3c 60                	cmp    $0x60,%al
  801766:	7e 19                	jle    801781 <strtol+0xe4>
  801768:	8b 45 08             	mov    0x8(%ebp),%eax
  80176b:	8a 00                	mov    (%eax),%al
  80176d:	3c 7a                	cmp    $0x7a,%al
  80176f:	7f 10                	jg     801781 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801771:	8b 45 08             	mov    0x8(%ebp),%eax
  801774:	8a 00                	mov    (%eax),%al
  801776:	0f be c0             	movsbl %al,%eax
  801779:	83 e8 57             	sub    $0x57,%eax
  80177c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80177f:	eb 20                	jmp    8017a1 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801781:	8b 45 08             	mov    0x8(%ebp),%eax
  801784:	8a 00                	mov    (%eax),%al
  801786:	3c 40                	cmp    $0x40,%al
  801788:	7e 39                	jle    8017c3 <strtol+0x126>
  80178a:	8b 45 08             	mov    0x8(%ebp),%eax
  80178d:	8a 00                	mov    (%eax),%al
  80178f:	3c 5a                	cmp    $0x5a,%al
  801791:	7f 30                	jg     8017c3 <strtol+0x126>
			dig = *s - 'A' + 10;
  801793:	8b 45 08             	mov    0x8(%ebp),%eax
  801796:	8a 00                	mov    (%eax),%al
  801798:	0f be c0             	movsbl %al,%eax
  80179b:	83 e8 37             	sub    $0x37,%eax
  80179e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8017a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017a4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8017a7:	7d 19                	jge    8017c2 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8017a9:	ff 45 08             	incl   0x8(%ebp)
  8017ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017af:	0f af 45 10          	imul   0x10(%ebp),%eax
  8017b3:	89 c2                	mov    %eax,%edx
  8017b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017b8:	01 d0                	add    %edx,%eax
  8017ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017bd:	e9 7b ff ff ff       	jmp    80173d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017c2:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017c3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017c7:	74 08                	je     8017d1 <strtol+0x134>
		*endptr = (char *) s;
  8017c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017cc:	8b 55 08             	mov    0x8(%ebp),%edx
  8017cf:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017d5:	74 07                	je     8017de <strtol+0x141>
  8017d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017da:	f7 d8                	neg    %eax
  8017dc:	eb 03                	jmp    8017e1 <strtol+0x144>
  8017de:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017e1:	c9                   	leave  
  8017e2:	c3                   	ret    

008017e3 <ltostr>:

void
ltostr(long value, char *str)
{
  8017e3:	55                   	push   %ebp
  8017e4:	89 e5                	mov    %esp,%ebp
  8017e6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017f0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017f7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017fb:	79 13                	jns    801810 <ltostr+0x2d>
	{
		neg = 1;
  8017fd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801804:	8b 45 0c             	mov    0xc(%ebp),%eax
  801807:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80180a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80180d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801810:	8b 45 08             	mov    0x8(%ebp),%eax
  801813:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801818:	99                   	cltd   
  801819:	f7 f9                	idiv   %ecx
  80181b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80181e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801821:	8d 50 01             	lea    0x1(%eax),%edx
  801824:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801827:	89 c2                	mov    %eax,%edx
  801829:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182c:	01 d0                	add    %edx,%eax
  80182e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801831:	83 c2 30             	add    $0x30,%edx
  801834:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801836:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801839:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80183e:	f7 e9                	imul   %ecx
  801840:	c1 fa 02             	sar    $0x2,%edx
  801843:	89 c8                	mov    %ecx,%eax
  801845:	c1 f8 1f             	sar    $0x1f,%eax
  801848:	29 c2                	sub    %eax,%edx
  80184a:	89 d0                	mov    %edx,%eax
  80184c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80184f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801852:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801857:	f7 e9                	imul   %ecx
  801859:	c1 fa 02             	sar    $0x2,%edx
  80185c:	89 c8                	mov    %ecx,%eax
  80185e:	c1 f8 1f             	sar    $0x1f,%eax
  801861:	29 c2                	sub    %eax,%edx
  801863:	89 d0                	mov    %edx,%eax
  801865:	c1 e0 02             	shl    $0x2,%eax
  801868:	01 d0                	add    %edx,%eax
  80186a:	01 c0                	add    %eax,%eax
  80186c:	29 c1                	sub    %eax,%ecx
  80186e:	89 ca                	mov    %ecx,%edx
  801870:	85 d2                	test   %edx,%edx
  801872:	75 9c                	jne    801810 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801874:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80187b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187e:	48                   	dec    %eax
  80187f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801882:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801886:	74 3d                	je     8018c5 <ltostr+0xe2>
		start = 1 ;
  801888:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80188f:	eb 34                	jmp    8018c5 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801891:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801894:	8b 45 0c             	mov    0xc(%ebp),%eax
  801897:	01 d0                	add    %edx,%eax
  801899:	8a 00                	mov    (%eax),%al
  80189b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80189e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a4:	01 c2                	add    %eax,%edx
  8018a6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8018a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ac:	01 c8                	add    %ecx,%eax
  8018ae:	8a 00                	mov    (%eax),%al
  8018b0:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8018b2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b8:	01 c2                	add    %eax,%edx
  8018ba:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018bd:	88 02                	mov    %al,(%edx)
		start++ ;
  8018bf:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018c2:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018c8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018cb:	7c c4                	jl     801891 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018cd:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d3:	01 d0                	add    %edx,%eax
  8018d5:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018d8:	90                   	nop
  8018d9:	c9                   	leave  
  8018da:	c3                   	ret    

008018db <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018db:	55                   	push   %ebp
  8018dc:	89 e5                	mov    %esp,%ebp
  8018de:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018e1:	ff 75 08             	pushl  0x8(%ebp)
  8018e4:	e8 54 fa ff ff       	call   80133d <strlen>
  8018e9:	83 c4 04             	add    $0x4,%esp
  8018ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018ef:	ff 75 0c             	pushl  0xc(%ebp)
  8018f2:	e8 46 fa ff ff       	call   80133d <strlen>
  8018f7:	83 c4 04             	add    $0x4,%esp
  8018fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801904:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80190b:	eb 17                	jmp    801924 <strcconcat+0x49>
		final[s] = str1[s] ;
  80190d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801910:	8b 45 10             	mov    0x10(%ebp),%eax
  801913:	01 c2                	add    %eax,%edx
  801915:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801918:	8b 45 08             	mov    0x8(%ebp),%eax
  80191b:	01 c8                	add    %ecx,%eax
  80191d:	8a 00                	mov    (%eax),%al
  80191f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801921:	ff 45 fc             	incl   -0x4(%ebp)
  801924:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801927:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80192a:	7c e1                	jl     80190d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80192c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801933:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80193a:	eb 1f                	jmp    80195b <strcconcat+0x80>
		final[s++] = str2[i] ;
  80193c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80193f:	8d 50 01             	lea    0x1(%eax),%edx
  801942:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801945:	89 c2                	mov    %eax,%edx
  801947:	8b 45 10             	mov    0x10(%ebp),%eax
  80194a:	01 c2                	add    %eax,%edx
  80194c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80194f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801952:	01 c8                	add    %ecx,%eax
  801954:	8a 00                	mov    (%eax),%al
  801956:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801958:	ff 45 f8             	incl   -0x8(%ebp)
  80195b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80195e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801961:	7c d9                	jl     80193c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801963:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801966:	8b 45 10             	mov    0x10(%ebp),%eax
  801969:	01 d0                	add    %edx,%eax
  80196b:	c6 00 00             	movb   $0x0,(%eax)
}
  80196e:	90                   	nop
  80196f:	c9                   	leave  
  801970:	c3                   	ret    

00801971 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801971:	55                   	push   %ebp
  801972:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801974:	8b 45 14             	mov    0x14(%ebp),%eax
  801977:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80197d:	8b 45 14             	mov    0x14(%ebp),%eax
  801980:	8b 00                	mov    (%eax),%eax
  801982:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801989:	8b 45 10             	mov    0x10(%ebp),%eax
  80198c:	01 d0                	add    %edx,%eax
  80198e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801994:	eb 0c                	jmp    8019a2 <strsplit+0x31>
			*string++ = 0;
  801996:	8b 45 08             	mov    0x8(%ebp),%eax
  801999:	8d 50 01             	lea    0x1(%eax),%edx
  80199c:	89 55 08             	mov    %edx,0x8(%ebp)
  80199f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8019a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a5:	8a 00                	mov    (%eax),%al
  8019a7:	84 c0                	test   %al,%al
  8019a9:	74 18                	je     8019c3 <strsplit+0x52>
  8019ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ae:	8a 00                	mov    (%eax),%al
  8019b0:	0f be c0             	movsbl %al,%eax
  8019b3:	50                   	push   %eax
  8019b4:	ff 75 0c             	pushl  0xc(%ebp)
  8019b7:	e8 13 fb ff ff       	call   8014cf <strchr>
  8019bc:	83 c4 08             	add    $0x8,%esp
  8019bf:	85 c0                	test   %eax,%eax
  8019c1:	75 d3                	jne    801996 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8019c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c6:	8a 00                	mov    (%eax),%al
  8019c8:	84 c0                	test   %al,%al
  8019ca:	74 5a                	je     801a26 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8019cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8019cf:	8b 00                	mov    (%eax),%eax
  8019d1:	83 f8 0f             	cmp    $0xf,%eax
  8019d4:	75 07                	jne    8019dd <strsplit+0x6c>
		{
			return 0;
  8019d6:	b8 00 00 00 00       	mov    $0x0,%eax
  8019db:	eb 66                	jmp    801a43 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8019e0:	8b 00                	mov    (%eax),%eax
  8019e2:	8d 48 01             	lea    0x1(%eax),%ecx
  8019e5:	8b 55 14             	mov    0x14(%ebp),%edx
  8019e8:	89 0a                	mov    %ecx,(%edx)
  8019ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f4:	01 c2                	add    %eax,%edx
  8019f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019fb:	eb 03                	jmp    801a00 <strsplit+0x8f>
			string++;
  8019fd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a00:	8b 45 08             	mov    0x8(%ebp),%eax
  801a03:	8a 00                	mov    (%eax),%al
  801a05:	84 c0                	test   %al,%al
  801a07:	74 8b                	je     801994 <strsplit+0x23>
  801a09:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0c:	8a 00                	mov    (%eax),%al
  801a0e:	0f be c0             	movsbl %al,%eax
  801a11:	50                   	push   %eax
  801a12:	ff 75 0c             	pushl  0xc(%ebp)
  801a15:	e8 b5 fa ff ff       	call   8014cf <strchr>
  801a1a:	83 c4 08             	add    $0x8,%esp
  801a1d:	85 c0                	test   %eax,%eax
  801a1f:	74 dc                	je     8019fd <strsplit+0x8c>
			string++;
	}
  801a21:	e9 6e ff ff ff       	jmp    801994 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a26:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a27:	8b 45 14             	mov    0x14(%ebp),%eax
  801a2a:	8b 00                	mov    (%eax),%eax
  801a2c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a33:	8b 45 10             	mov    0x10(%ebp),%eax
  801a36:	01 d0                	add    %edx,%eax
  801a38:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a3e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a43:	c9                   	leave  
  801a44:	c3                   	ret    

00801a45 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a45:	55                   	push   %ebp
  801a46:	89 e5                	mov    %esp,%ebp
  801a48:	83 ec 18             	sub    $0x18,%esp
  801a4b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a4e:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801a51:	83 ec 04             	sub    $0x4,%esp
  801a54:	68 70 2f 80 00       	push   $0x802f70
  801a59:	6a 17                	push   $0x17
  801a5b:	68 8f 2f 80 00       	push   $0x802f8f
  801a60:	e8 a2 ef ff ff       	call   800a07 <_panic>

00801a65 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a65:	55                   	push   %ebp
  801a66:	89 e5                	mov    %esp,%ebp
  801a68:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801a6b:	83 ec 04             	sub    $0x4,%esp
  801a6e:	68 9b 2f 80 00       	push   $0x802f9b
  801a73:	6a 2f                	push   $0x2f
  801a75:	68 8f 2f 80 00       	push   $0x802f8f
  801a7a:	e8 88 ef ff ff       	call   800a07 <_panic>

00801a7f <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801a7f:	55                   	push   %ebp
  801a80:	89 e5                	mov    %esp,%ebp
  801a82:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801a85:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801a8c:	8b 55 08             	mov    0x8(%ebp),%edx
  801a8f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a92:	01 d0                	add    %edx,%eax
  801a94:	48                   	dec    %eax
  801a95:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801a98:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a9b:	ba 00 00 00 00       	mov    $0x0,%edx
  801aa0:	f7 75 ec             	divl   -0x14(%ebp)
  801aa3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801aa6:	29 d0                	sub    %edx,%eax
  801aa8:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801aab:	8b 45 08             	mov    0x8(%ebp),%eax
  801aae:	c1 e8 0c             	shr    $0xc,%eax
  801ab1:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801ab4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801abb:	e9 c8 00 00 00       	jmp    801b88 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801ac0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ac7:	eb 27                	jmp    801af0 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801ac9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801acf:	01 c2                	add    %eax,%edx
  801ad1:	89 d0                	mov    %edx,%eax
  801ad3:	01 c0                	add    %eax,%eax
  801ad5:	01 d0                	add    %edx,%eax
  801ad7:	c1 e0 02             	shl    $0x2,%eax
  801ada:	05 48 30 80 00       	add    $0x803048,%eax
  801adf:	8b 00                	mov    (%eax),%eax
  801ae1:	85 c0                	test   %eax,%eax
  801ae3:	74 08                	je     801aed <malloc+0x6e>
            	i += j;
  801ae5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ae8:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801aeb:	eb 0b                	jmp    801af8 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801aed:	ff 45 f0             	incl   -0x10(%ebp)
  801af0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801af3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801af6:	72 d1                	jb     801ac9 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801af8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801afb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801afe:	0f 85 81 00 00 00    	jne    801b85 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801b04:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b07:	05 00 00 08 00       	add    $0x80000,%eax
  801b0c:	c1 e0 0c             	shl    $0xc,%eax
  801b0f:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801b12:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801b19:	eb 1f                	jmp    801b3a <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801b1b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b21:	01 c2                	add    %eax,%edx
  801b23:	89 d0                	mov    %edx,%eax
  801b25:	01 c0                	add    %eax,%eax
  801b27:	01 d0                	add    %edx,%eax
  801b29:	c1 e0 02             	shl    $0x2,%eax
  801b2c:	05 48 30 80 00       	add    $0x803048,%eax
  801b31:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801b37:	ff 45 f0             	incl   -0x10(%ebp)
  801b3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b3d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b40:	72 d9                	jb     801b1b <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801b42:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b45:	89 d0                	mov    %edx,%eax
  801b47:	01 c0                	add    %eax,%eax
  801b49:	01 d0                	add    %edx,%eax
  801b4b:	c1 e0 02             	shl    $0x2,%eax
  801b4e:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801b54:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b57:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801b59:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801b5c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801b5f:	89 c8                	mov    %ecx,%eax
  801b61:	01 c0                	add    %eax,%eax
  801b63:	01 c8                	add    %ecx,%eax
  801b65:	c1 e0 02             	shl    $0x2,%eax
  801b68:	05 44 30 80 00       	add    $0x803044,%eax
  801b6d:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801b6f:	83 ec 08             	sub    $0x8,%esp
  801b72:	ff 75 08             	pushl  0x8(%ebp)
  801b75:	ff 75 e0             	pushl  -0x20(%ebp)
  801b78:	e8 2b 03 00 00       	call   801ea8 <sys_allocateMem>
  801b7d:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801b80:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b83:	eb 19                	jmp    801b9e <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801b85:	ff 45 f4             	incl   -0xc(%ebp)
  801b88:	a1 04 30 80 00       	mov    0x803004,%eax
  801b8d:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801b90:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b93:	0f 83 27 ff ff ff    	jae    801ac0 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801b99:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b9e:	c9                   	leave  
  801b9f:	c3                   	ret    

00801ba0 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801ba0:	55                   	push   %ebp
  801ba1:	89 e5                	mov    %esp,%ebp
  801ba3:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801ba6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801baa:	0f 84 e5 00 00 00    	je     801c95 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801bb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bb9:	05 00 00 00 80       	add    $0x80000000,%eax
  801bbe:	c1 e8 0c             	shr    $0xc,%eax
  801bc1:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801bc4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801bc7:	89 d0                	mov    %edx,%eax
  801bc9:	01 c0                	add    %eax,%eax
  801bcb:	01 d0                	add    %edx,%eax
  801bcd:	c1 e0 02             	shl    $0x2,%eax
  801bd0:	05 40 30 80 00       	add    $0x803040,%eax
  801bd5:	8b 00                	mov    (%eax),%eax
  801bd7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bda:	0f 85 b8 00 00 00    	jne    801c98 <free+0xf8>
  801be0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801be3:	89 d0                	mov    %edx,%eax
  801be5:	01 c0                	add    %eax,%eax
  801be7:	01 d0                	add    %edx,%eax
  801be9:	c1 e0 02             	shl    $0x2,%eax
  801bec:	05 48 30 80 00       	add    $0x803048,%eax
  801bf1:	8b 00                	mov    (%eax),%eax
  801bf3:	85 c0                	test   %eax,%eax
  801bf5:	0f 84 9d 00 00 00    	je     801c98 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801bfb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801bfe:	89 d0                	mov    %edx,%eax
  801c00:	01 c0                	add    %eax,%eax
  801c02:	01 d0                	add    %edx,%eax
  801c04:	c1 e0 02             	shl    $0x2,%eax
  801c07:	05 44 30 80 00       	add    $0x803044,%eax
  801c0c:	8b 00                	mov    (%eax),%eax
  801c0e:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801c11:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c14:	c1 e0 0c             	shl    $0xc,%eax
  801c17:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801c1a:	83 ec 08             	sub    $0x8,%esp
  801c1d:	ff 75 e4             	pushl  -0x1c(%ebp)
  801c20:	ff 75 f0             	pushl  -0x10(%ebp)
  801c23:	e8 64 02 00 00       	call   801e8c <sys_freeMem>
  801c28:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801c2b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801c32:	eb 57                	jmp    801c8b <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801c34:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c37:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c3a:	01 c2                	add    %eax,%edx
  801c3c:	89 d0                	mov    %edx,%eax
  801c3e:	01 c0                	add    %eax,%eax
  801c40:	01 d0                	add    %edx,%eax
  801c42:	c1 e0 02             	shl    $0x2,%eax
  801c45:	05 48 30 80 00       	add    $0x803048,%eax
  801c4a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801c50:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c56:	01 c2                	add    %eax,%edx
  801c58:	89 d0                	mov    %edx,%eax
  801c5a:	01 c0                	add    %eax,%eax
  801c5c:	01 d0                	add    %edx,%eax
  801c5e:	c1 e0 02             	shl    $0x2,%eax
  801c61:	05 40 30 80 00       	add    $0x803040,%eax
  801c66:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801c6c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c72:	01 c2                	add    %eax,%edx
  801c74:	89 d0                	mov    %edx,%eax
  801c76:	01 c0                	add    %eax,%eax
  801c78:	01 d0                	add    %edx,%eax
  801c7a:	c1 e0 02             	shl    $0x2,%eax
  801c7d:	05 44 30 80 00       	add    $0x803044,%eax
  801c82:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801c88:	ff 45 f4             	incl   -0xc(%ebp)
  801c8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c8e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c91:	7c a1                	jl     801c34 <free+0x94>
  801c93:	eb 04                	jmp    801c99 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801c95:	90                   	nop
  801c96:	eb 01                	jmp    801c99 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801c98:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801c99:	c9                   	leave  
  801c9a:	c3                   	ret    

00801c9b <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801c9b:	55                   	push   %ebp
  801c9c:	89 e5                	mov    %esp,%ebp
  801c9e:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801ca1:	83 ec 04             	sub    $0x4,%esp
  801ca4:	68 b8 2f 80 00       	push   $0x802fb8
  801ca9:	68 ae 00 00 00       	push   $0xae
  801cae:	68 8f 2f 80 00       	push   $0x802f8f
  801cb3:	e8 4f ed ff ff       	call   800a07 <_panic>

00801cb8 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801cb8:	55                   	push   %ebp
  801cb9:	89 e5                	mov    %esp,%ebp
  801cbb:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801cbe:	83 ec 04             	sub    $0x4,%esp
  801cc1:	68 d8 2f 80 00       	push   $0x802fd8
  801cc6:	68 ca 00 00 00       	push   $0xca
  801ccb:	68 8f 2f 80 00       	push   $0x802f8f
  801cd0:	e8 32 ed ff ff       	call   800a07 <_panic>

00801cd5 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801cd5:	55                   	push   %ebp
  801cd6:	89 e5                	mov    %esp,%ebp
  801cd8:	57                   	push   %edi
  801cd9:	56                   	push   %esi
  801cda:	53                   	push   %ebx
  801cdb:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801cde:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ce4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ce7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cea:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ced:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801cf0:	cd 30                	int    $0x30
  801cf2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801cf5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801cf8:	83 c4 10             	add    $0x10,%esp
  801cfb:	5b                   	pop    %ebx
  801cfc:	5e                   	pop    %esi
  801cfd:	5f                   	pop    %edi
  801cfe:	5d                   	pop    %ebp
  801cff:	c3                   	ret    

00801d00 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d00:	55                   	push   %ebp
  801d01:	89 e5                	mov    %esp,%ebp
  801d03:	83 ec 04             	sub    $0x4,%esp
  801d06:	8b 45 10             	mov    0x10(%ebp),%eax
  801d09:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d0c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d10:	8b 45 08             	mov    0x8(%ebp),%eax
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	52                   	push   %edx
  801d18:	ff 75 0c             	pushl  0xc(%ebp)
  801d1b:	50                   	push   %eax
  801d1c:	6a 00                	push   $0x0
  801d1e:	e8 b2 ff ff ff       	call   801cd5 <syscall>
  801d23:	83 c4 18             	add    $0x18,%esp
}
  801d26:	90                   	nop
  801d27:	c9                   	leave  
  801d28:	c3                   	ret    

00801d29 <sys_cgetc>:

int
sys_cgetc(void)
{
  801d29:	55                   	push   %ebp
  801d2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	6a 00                	push   $0x0
  801d34:	6a 00                	push   $0x0
  801d36:	6a 01                	push   $0x1
  801d38:	e8 98 ff ff ff       	call   801cd5 <syscall>
  801d3d:	83 c4 18             	add    $0x18,%esp
}
  801d40:	c9                   	leave  
  801d41:	c3                   	ret    

00801d42 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801d42:	55                   	push   %ebp
  801d43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801d45:	8b 45 08             	mov    0x8(%ebp),%eax
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	50                   	push   %eax
  801d51:	6a 05                	push   $0x5
  801d53:	e8 7d ff ff ff       	call   801cd5 <syscall>
  801d58:	83 c4 18             	add    $0x18,%esp
}
  801d5b:	c9                   	leave  
  801d5c:	c3                   	ret    

00801d5d <sys_getenvid>:

int32 sys_getenvid(void)
{
  801d5d:	55                   	push   %ebp
  801d5e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801d60:	6a 00                	push   $0x0
  801d62:	6a 00                	push   $0x0
  801d64:	6a 00                	push   $0x0
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 02                	push   $0x2
  801d6c:	e8 64 ff ff ff       	call   801cd5 <syscall>
  801d71:	83 c4 18             	add    $0x18,%esp
}
  801d74:	c9                   	leave  
  801d75:	c3                   	ret    

00801d76 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d76:	55                   	push   %ebp
  801d77:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 03                	push   $0x3
  801d85:	e8 4b ff ff ff       	call   801cd5 <syscall>
  801d8a:	83 c4 18             	add    $0x18,%esp
}
  801d8d:	c9                   	leave  
  801d8e:	c3                   	ret    

00801d8f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d8f:	55                   	push   %ebp
  801d90:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 04                	push   $0x4
  801d9e:	e8 32 ff ff ff       	call   801cd5 <syscall>
  801da3:	83 c4 18             	add    $0x18,%esp
}
  801da6:	c9                   	leave  
  801da7:	c3                   	ret    

00801da8 <sys_env_exit>:


void sys_env_exit(void)
{
  801da8:	55                   	push   %ebp
  801da9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801dab:	6a 00                	push   $0x0
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 06                	push   $0x6
  801db7:	e8 19 ff ff ff       	call   801cd5 <syscall>
  801dbc:	83 c4 18             	add    $0x18,%esp
}
  801dbf:	90                   	nop
  801dc0:	c9                   	leave  
  801dc1:	c3                   	ret    

00801dc2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801dc2:	55                   	push   %ebp
  801dc3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801dc5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	52                   	push   %edx
  801dd2:	50                   	push   %eax
  801dd3:	6a 07                	push   $0x7
  801dd5:	e8 fb fe ff ff       	call   801cd5 <syscall>
  801dda:	83 c4 18             	add    $0x18,%esp
}
  801ddd:	c9                   	leave  
  801dde:	c3                   	ret    

00801ddf <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ddf:	55                   	push   %ebp
  801de0:	89 e5                	mov    %esp,%ebp
  801de2:	56                   	push   %esi
  801de3:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801de4:	8b 75 18             	mov    0x18(%ebp),%esi
  801de7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801dea:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ded:	8b 55 0c             	mov    0xc(%ebp),%edx
  801df0:	8b 45 08             	mov    0x8(%ebp),%eax
  801df3:	56                   	push   %esi
  801df4:	53                   	push   %ebx
  801df5:	51                   	push   %ecx
  801df6:	52                   	push   %edx
  801df7:	50                   	push   %eax
  801df8:	6a 08                	push   $0x8
  801dfa:	e8 d6 fe ff ff       	call   801cd5 <syscall>
  801dff:	83 c4 18             	add    $0x18,%esp
}
  801e02:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e05:	5b                   	pop    %ebx
  801e06:	5e                   	pop    %esi
  801e07:	5d                   	pop    %ebp
  801e08:	c3                   	ret    

00801e09 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e09:	55                   	push   %ebp
  801e0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	52                   	push   %edx
  801e19:	50                   	push   %eax
  801e1a:	6a 09                	push   $0x9
  801e1c:	e8 b4 fe ff ff       	call   801cd5 <syscall>
  801e21:	83 c4 18             	add    $0x18,%esp
}
  801e24:	c9                   	leave  
  801e25:	c3                   	ret    

00801e26 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e26:	55                   	push   %ebp
  801e27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	ff 75 0c             	pushl  0xc(%ebp)
  801e32:	ff 75 08             	pushl  0x8(%ebp)
  801e35:	6a 0a                	push   $0xa
  801e37:	e8 99 fe ff ff       	call   801cd5 <syscall>
  801e3c:	83 c4 18             	add    $0x18,%esp
}
  801e3f:	c9                   	leave  
  801e40:	c3                   	ret    

00801e41 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e41:	55                   	push   %ebp
  801e42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e44:	6a 00                	push   $0x0
  801e46:	6a 00                	push   $0x0
  801e48:	6a 00                	push   $0x0
  801e4a:	6a 00                	push   $0x0
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 0b                	push   $0xb
  801e50:	e8 80 fe ff ff       	call   801cd5 <syscall>
  801e55:	83 c4 18             	add    $0x18,%esp
}
  801e58:	c9                   	leave  
  801e59:	c3                   	ret    

00801e5a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e5a:	55                   	push   %ebp
  801e5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	6a 00                	push   $0x0
  801e67:	6a 0c                	push   $0xc
  801e69:	e8 67 fe ff ff       	call   801cd5 <syscall>
  801e6e:	83 c4 18             	add    $0x18,%esp
}
  801e71:	c9                   	leave  
  801e72:	c3                   	ret    

00801e73 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e73:	55                   	push   %ebp
  801e74:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 0d                	push   $0xd
  801e82:	e8 4e fe ff ff       	call   801cd5 <syscall>
  801e87:	83 c4 18             	add    $0x18,%esp
}
  801e8a:	c9                   	leave  
  801e8b:	c3                   	ret    

00801e8c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e8c:	55                   	push   %ebp
  801e8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e8f:	6a 00                	push   $0x0
  801e91:	6a 00                	push   $0x0
  801e93:	6a 00                	push   $0x0
  801e95:	ff 75 0c             	pushl  0xc(%ebp)
  801e98:	ff 75 08             	pushl  0x8(%ebp)
  801e9b:	6a 11                	push   $0x11
  801e9d:	e8 33 fe ff ff       	call   801cd5 <syscall>
  801ea2:	83 c4 18             	add    $0x18,%esp
	return;
  801ea5:	90                   	nop
}
  801ea6:	c9                   	leave  
  801ea7:	c3                   	ret    

00801ea8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801ea8:	55                   	push   %ebp
  801ea9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	ff 75 0c             	pushl  0xc(%ebp)
  801eb4:	ff 75 08             	pushl  0x8(%ebp)
  801eb7:	6a 12                	push   $0x12
  801eb9:	e8 17 fe ff ff       	call   801cd5 <syscall>
  801ebe:	83 c4 18             	add    $0x18,%esp
	return ;
  801ec1:	90                   	nop
}
  801ec2:	c9                   	leave  
  801ec3:	c3                   	ret    

00801ec4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801ec4:	55                   	push   %ebp
  801ec5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 00                	push   $0x0
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 0e                	push   $0xe
  801ed3:	e8 fd fd ff ff       	call   801cd5 <syscall>
  801ed8:	83 c4 18             	add    $0x18,%esp
}
  801edb:	c9                   	leave  
  801edc:	c3                   	ret    

00801edd <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801edd:	55                   	push   %ebp
  801ede:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ee0:	6a 00                	push   $0x0
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 00                	push   $0x0
  801ee6:	6a 00                	push   $0x0
  801ee8:	ff 75 08             	pushl  0x8(%ebp)
  801eeb:	6a 0f                	push   $0xf
  801eed:	e8 e3 fd ff ff       	call   801cd5 <syscall>
  801ef2:	83 c4 18             	add    $0x18,%esp
}
  801ef5:	c9                   	leave  
  801ef6:	c3                   	ret    

00801ef7 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ef7:	55                   	push   %ebp
  801ef8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 10                	push   $0x10
  801f06:	e8 ca fd ff ff       	call   801cd5 <syscall>
  801f0b:	83 c4 18             	add    $0x18,%esp
}
  801f0e:	90                   	nop
  801f0f:	c9                   	leave  
  801f10:	c3                   	ret    

00801f11 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f11:	55                   	push   %ebp
  801f12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 14                	push   $0x14
  801f20:	e8 b0 fd ff ff       	call   801cd5 <syscall>
  801f25:	83 c4 18             	add    $0x18,%esp
}
  801f28:	90                   	nop
  801f29:	c9                   	leave  
  801f2a:	c3                   	ret    

00801f2b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801f2b:	55                   	push   %ebp
  801f2c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 15                	push   $0x15
  801f3a:	e8 96 fd ff ff       	call   801cd5 <syscall>
  801f3f:	83 c4 18             	add    $0x18,%esp
}
  801f42:	90                   	nop
  801f43:	c9                   	leave  
  801f44:	c3                   	ret    

00801f45 <sys_cputc>:


void
sys_cputc(const char c)
{
  801f45:	55                   	push   %ebp
  801f46:	89 e5                	mov    %esp,%ebp
  801f48:	83 ec 04             	sub    $0x4,%esp
  801f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f51:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 00                	push   $0x0
  801f5d:	50                   	push   %eax
  801f5e:	6a 16                	push   $0x16
  801f60:	e8 70 fd ff ff       	call   801cd5 <syscall>
  801f65:	83 c4 18             	add    $0x18,%esp
}
  801f68:	90                   	nop
  801f69:	c9                   	leave  
  801f6a:	c3                   	ret    

00801f6b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f6b:	55                   	push   %ebp
  801f6c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f6e:	6a 00                	push   $0x0
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	6a 17                	push   $0x17
  801f7a:	e8 56 fd ff ff       	call   801cd5 <syscall>
  801f7f:	83 c4 18             	add    $0x18,%esp
}
  801f82:	90                   	nop
  801f83:	c9                   	leave  
  801f84:	c3                   	ret    

00801f85 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f85:	55                   	push   %ebp
  801f86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f88:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 00                	push   $0x0
  801f91:	ff 75 0c             	pushl  0xc(%ebp)
  801f94:	50                   	push   %eax
  801f95:	6a 18                	push   $0x18
  801f97:	e8 39 fd ff ff       	call   801cd5 <syscall>
  801f9c:	83 c4 18             	add    $0x18,%esp
}
  801f9f:	c9                   	leave  
  801fa0:	c3                   	ret    

00801fa1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801fa1:	55                   	push   %ebp
  801fa2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fa4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  801faa:	6a 00                	push   $0x0
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	52                   	push   %edx
  801fb1:	50                   	push   %eax
  801fb2:	6a 1b                	push   $0x1b
  801fb4:	e8 1c fd ff ff       	call   801cd5 <syscall>
  801fb9:	83 c4 18             	add    $0x18,%esp
}
  801fbc:	c9                   	leave  
  801fbd:	c3                   	ret    

00801fbe <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801fbe:	55                   	push   %ebp
  801fbf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fc1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fc4:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	52                   	push   %edx
  801fce:	50                   	push   %eax
  801fcf:	6a 19                	push   $0x19
  801fd1:	e8 ff fc ff ff       	call   801cd5 <syscall>
  801fd6:	83 c4 18             	add    $0x18,%esp
}
  801fd9:	90                   	nop
  801fda:	c9                   	leave  
  801fdb:	c3                   	ret    

00801fdc <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801fdc:	55                   	push   %ebp
  801fdd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fdf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	52                   	push   %edx
  801fec:	50                   	push   %eax
  801fed:	6a 1a                	push   $0x1a
  801fef:	e8 e1 fc ff ff       	call   801cd5 <syscall>
  801ff4:	83 c4 18             	add    $0x18,%esp
}
  801ff7:	90                   	nop
  801ff8:	c9                   	leave  
  801ff9:	c3                   	ret    

00801ffa <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ffa:	55                   	push   %ebp
  801ffb:	89 e5                	mov    %esp,%ebp
  801ffd:	83 ec 04             	sub    $0x4,%esp
  802000:	8b 45 10             	mov    0x10(%ebp),%eax
  802003:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802006:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802009:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80200d:	8b 45 08             	mov    0x8(%ebp),%eax
  802010:	6a 00                	push   $0x0
  802012:	51                   	push   %ecx
  802013:	52                   	push   %edx
  802014:	ff 75 0c             	pushl  0xc(%ebp)
  802017:	50                   	push   %eax
  802018:	6a 1c                	push   $0x1c
  80201a:	e8 b6 fc ff ff       	call   801cd5 <syscall>
  80201f:	83 c4 18             	add    $0x18,%esp
}
  802022:	c9                   	leave  
  802023:	c3                   	ret    

00802024 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802024:	55                   	push   %ebp
  802025:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802027:	8b 55 0c             	mov    0xc(%ebp),%edx
  80202a:	8b 45 08             	mov    0x8(%ebp),%eax
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	52                   	push   %edx
  802034:	50                   	push   %eax
  802035:	6a 1d                	push   $0x1d
  802037:	e8 99 fc ff ff       	call   801cd5 <syscall>
  80203c:	83 c4 18             	add    $0x18,%esp
}
  80203f:	c9                   	leave  
  802040:	c3                   	ret    

00802041 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802041:	55                   	push   %ebp
  802042:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802044:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802047:	8b 55 0c             	mov    0xc(%ebp),%edx
  80204a:	8b 45 08             	mov    0x8(%ebp),%eax
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	51                   	push   %ecx
  802052:	52                   	push   %edx
  802053:	50                   	push   %eax
  802054:	6a 1e                	push   $0x1e
  802056:	e8 7a fc ff ff       	call   801cd5 <syscall>
  80205b:	83 c4 18             	add    $0x18,%esp
}
  80205e:	c9                   	leave  
  80205f:	c3                   	ret    

00802060 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802060:	55                   	push   %ebp
  802061:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802063:	8b 55 0c             	mov    0xc(%ebp),%edx
  802066:	8b 45 08             	mov    0x8(%ebp),%eax
  802069:	6a 00                	push   $0x0
  80206b:	6a 00                	push   $0x0
  80206d:	6a 00                	push   $0x0
  80206f:	52                   	push   %edx
  802070:	50                   	push   %eax
  802071:	6a 1f                	push   $0x1f
  802073:	e8 5d fc ff ff       	call   801cd5 <syscall>
  802078:	83 c4 18             	add    $0x18,%esp
}
  80207b:	c9                   	leave  
  80207c:	c3                   	ret    

0080207d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80207d:	55                   	push   %ebp
  80207e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	6a 20                	push   $0x20
  80208c:	e8 44 fc ff ff       	call   801cd5 <syscall>
  802091:	83 c4 18             	add    $0x18,%esp
}
  802094:	c9                   	leave  
  802095:	c3                   	ret    

00802096 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802096:	55                   	push   %ebp
  802097:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802099:	8b 45 08             	mov    0x8(%ebp),%eax
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	ff 75 10             	pushl  0x10(%ebp)
  8020a3:	ff 75 0c             	pushl  0xc(%ebp)
  8020a6:	50                   	push   %eax
  8020a7:	6a 21                	push   $0x21
  8020a9:	e8 27 fc ff ff       	call   801cd5 <syscall>
  8020ae:	83 c4 18             	add    $0x18,%esp
}
  8020b1:	c9                   	leave  
  8020b2:	c3                   	ret    

008020b3 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8020b3:	55                   	push   %ebp
  8020b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8020b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	50                   	push   %eax
  8020c2:	6a 22                	push   $0x22
  8020c4:	e8 0c fc ff ff       	call   801cd5 <syscall>
  8020c9:	83 c4 18             	add    $0x18,%esp
}
  8020cc:	90                   	nop
  8020cd:	c9                   	leave  
  8020ce:	c3                   	ret    

008020cf <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8020cf:	55                   	push   %ebp
  8020d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8020d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 00                	push   $0x0
  8020db:	6a 00                	push   $0x0
  8020dd:	50                   	push   %eax
  8020de:	6a 23                	push   $0x23
  8020e0:	e8 f0 fb ff ff       	call   801cd5 <syscall>
  8020e5:	83 c4 18             	add    $0x18,%esp
}
  8020e8:	90                   	nop
  8020e9:	c9                   	leave  
  8020ea:	c3                   	ret    

008020eb <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8020eb:	55                   	push   %ebp
  8020ec:	89 e5                	mov    %esp,%ebp
  8020ee:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8020f1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020f4:	8d 50 04             	lea    0x4(%eax),%edx
  8020f7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	6a 00                	push   $0x0
  802100:	52                   	push   %edx
  802101:	50                   	push   %eax
  802102:	6a 24                	push   $0x24
  802104:	e8 cc fb ff ff       	call   801cd5 <syscall>
  802109:	83 c4 18             	add    $0x18,%esp
	return result;
  80210c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80210f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802112:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802115:	89 01                	mov    %eax,(%ecx)
  802117:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80211a:	8b 45 08             	mov    0x8(%ebp),%eax
  80211d:	c9                   	leave  
  80211e:	c2 04 00             	ret    $0x4

00802121 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802121:	55                   	push   %ebp
  802122:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802124:	6a 00                	push   $0x0
  802126:	6a 00                	push   $0x0
  802128:	ff 75 10             	pushl  0x10(%ebp)
  80212b:	ff 75 0c             	pushl  0xc(%ebp)
  80212e:	ff 75 08             	pushl  0x8(%ebp)
  802131:	6a 13                	push   $0x13
  802133:	e8 9d fb ff ff       	call   801cd5 <syscall>
  802138:	83 c4 18             	add    $0x18,%esp
	return ;
  80213b:	90                   	nop
}
  80213c:	c9                   	leave  
  80213d:	c3                   	ret    

0080213e <sys_rcr2>:
uint32 sys_rcr2()
{
  80213e:	55                   	push   %ebp
  80213f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802141:	6a 00                	push   $0x0
  802143:	6a 00                	push   $0x0
  802145:	6a 00                	push   $0x0
  802147:	6a 00                	push   $0x0
  802149:	6a 00                	push   $0x0
  80214b:	6a 25                	push   $0x25
  80214d:	e8 83 fb ff ff       	call   801cd5 <syscall>
  802152:	83 c4 18             	add    $0x18,%esp
}
  802155:	c9                   	leave  
  802156:	c3                   	ret    

00802157 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802157:	55                   	push   %ebp
  802158:	89 e5                	mov    %esp,%ebp
  80215a:	83 ec 04             	sub    $0x4,%esp
  80215d:	8b 45 08             	mov    0x8(%ebp),%eax
  802160:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802163:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802167:	6a 00                	push   $0x0
  802169:	6a 00                	push   $0x0
  80216b:	6a 00                	push   $0x0
  80216d:	6a 00                	push   $0x0
  80216f:	50                   	push   %eax
  802170:	6a 26                	push   $0x26
  802172:	e8 5e fb ff ff       	call   801cd5 <syscall>
  802177:	83 c4 18             	add    $0x18,%esp
	return ;
  80217a:	90                   	nop
}
  80217b:	c9                   	leave  
  80217c:	c3                   	ret    

0080217d <rsttst>:
void rsttst()
{
  80217d:	55                   	push   %ebp
  80217e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	6a 00                	push   $0x0
  802186:	6a 00                	push   $0x0
  802188:	6a 00                	push   $0x0
  80218a:	6a 28                	push   $0x28
  80218c:	e8 44 fb ff ff       	call   801cd5 <syscall>
  802191:	83 c4 18             	add    $0x18,%esp
	return ;
  802194:	90                   	nop
}
  802195:	c9                   	leave  
  802196:	c3                   	ret    

00802197 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802197:	55                   	push   %ebp
  802198:	89 e5                	mov    %esp,%ebp
  80219a:	83 ec 04             	sub    $0x4,%esp
  80219d:	8b 45 14             	mov    0x14(%ebp),%eax
  8021a0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8021a3:	8b 55 18             	mov    0x18(%ebp),%edx
  8021a6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021aa:	52                   	push   %edx
  8021ab:	50                   	push   %eax
  8021ac:	ff 75 10             	pushl  0x10(%ebp)
  8021af:	ff 75 0c             	pushl  0xc(%ebp)
  8021b2:	ff 75 08             	pushl  0x8(%ebp)
  8021b5:	6a 27                	push   $0x27
  8021b7:	e8 19 fb ff ff       	call   801cd5 <syscall>
  8021bc:	83 c4 18             	add    $0x18,%esp
	return ;
  8021bf:	90                   	nop
}
  8021c0:	c9                   	leave  
  8021c1:	c3                   	ret    

008021c2 <chktst>:
void chktst(uint32 n)
{
  8021c2:	55                   	push   %ebp
  8021c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8021c5:	6a 00                	push   $0x0
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 00                	push   $0x0
  8021cd:	ff 75 08             	pushl  0x8(%ebp)
  8021d0:	6a 29                	push   $0x29
  8021d2:	e8 fe fa ff ff       	call   801cd5 <syscall>
  8021d7:	83 c4 18             	add    $0x18,%esp
	return ;
  8021da:	90                   	nop
}
  8021db:	c9                   	leave  
  8021dc:	c3                   	ret    

008021dd <inctst>:

void inctst()
{
  8021dd:	55                   	push   %ebp
  8021de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 00                	push   $0x0
  8021e4:	6a 00                	push   $0x0
  8021e6:	6a 00                	push   $0x0
  8021e8:	6a 00                	push   $0x0
  8021ea:	6a 2a                	push   $0x2a
  8021ec:	e8 e4 fa ff ff       	call   801cd5 <syscall>
  8021f1:	83 c4 18             	add    $0x18,%esp
	return ;
  8021f4:	90                   	nop
}
  8021f5:	c9                   	leave  
  8021f6:	c3                   	ret    

008021f7 <gettst>:
uint32 gettst()
{
  8021f7:	55                   	push   %ebp
  8021f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8021fa:	6a 00                	push   $0x0
  8021fc:	6a 00                	push   $0x0
  8021fe:	6a 00                	push   $0x0
  802200:	6a 00                	push   $0x0
  802202:	6a 00                	push   $0x0
  802204:	6a 2b                	push   $0x2b
  802206:	e8 ca fa ff ff       	call   801cd5 <syscall>
  80220b:	83 c4 18             	add    $0x18,%esp
}
  80220e:	c9                   	leave  
  80220f:	c3                   	ret    

00802210 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802210:	55                   	push   %ebp
  802211:	89 e5                	mov    %esp,%ebp
  802213:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802216:	6a 00                	push   $0x0
  802218:	6a 00                	push   $0x0
  80221a:	6a 00                	push   $0x0
  80221c:	6a 00                	push   $0x0
  80221e:	6a 00                	push   $0x0
  802220:	6a 2c                	push   $0x2c
  802222:	e8 ae fa ff ff       	call   801cd5 <syscall>
  802227:	83 c4 18             	add    $0x18,%esp
  80222a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80222d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802231:	75 07                	jne    80223a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802233:	b8 01 00 00 00       	mov    $0x1,%eax
  802238:	eb 05                	jmp    80223f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80223a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80223f:	c9                   	leave  
  802240:	c3                   	ret    

00802241 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802241:	55                   	push   %ebp
  802242:	89 e5                	mov    %esp,%ebp
  802244:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802247:	6a 00                	push   $0x0
  802249:	6a 00                	push   $0x0
  80224b:	6a 00                	push   $0x0
  80224d:	6a 00                	push   $0x0
  80224f:	6a 00                	push   $0x0
  802251:	6a 2c                	push   $0x2c
  802253:	e8 7d fa ff ff       	call   801cd5 <syscall>
  802258:	83 c4 18             	add    $0x18,%esp
  80225b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80225e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802262:	75 07                	jne    80226b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802264:	b8 01 00 00 00       	mov    $0x1,%eax
  802269:	eb 05                	jmp    802270 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80226b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802270:	c9                   	leave  
  802271:	c3                   	ret    

00802272 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802272:	55                   	push   %ebp
  802273:	89 e5                	mov    %esp,%ebp
  802275:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802278:	6a 00                	push   $0x0
  80227a:	6a 00                	push   $0x0
  80227c:	6a 00                	push   $0x0
  80227e:	6a 00                	push   $0x0
  802280:	6a 00                	push   $0x0
  802282:	6a 2c                	push   $0x2c
  802284:	e8 4c fa ff ff       	call   801cd5 <syscall>
  802289:	83 c4 18             	add    $0x18,%esp
  80228c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80228f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802293:	75 07                	jne    80229c <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802295:	b8 01 00 00 00       	mov    $0x1,%eax
  80229a:	eb 05                	jmp    8022a1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80229c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022a1:	c9                   	leave  
  8022a2:	c3                   	ret    

008022a3 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8022a3:	55                   	push   %ebp
  8022a4:	89 e5                	mov    %esp,%ebp
  8022a6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022a9:	6a 00                	push   $0x0
  8022ab:	6a 00                	push   $0x0
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	6a 2c                	push   $0x2c
  8022b5:	e8 1b fa ff ff       	call   801cd5 <syscall>
  8022ba:	83 c4 18             	add    $0x18,%esp
  8022bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8022c0:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8022c4:	75 07                	jne    8022cd <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8022c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8022cb:	eb 05                	jmp    8022d2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8022cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022d2:	c9                   	leave  
  8022d3:	c3                   	ret    

008022d4 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8022d4:	55                   	push   %ebp
  8022d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8022d7:	6a 00                	push   $0x0
  8022d9:	6a 00                	push   $0x0
  8022db:	6a 00                	push   $0x0
  8022dd:	6a 00                	push   $0x0
  8022df:	ff 75 08             	pushl  0x8(%ebp)
  8022e2:	6a 2d                	push   $0x2d
  8022e4:	e8 ec f9 ff ff       	call   801cd5 <syscall>
  8022e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8022ec:	90                   	nop
}
  8022ed:	c9                   	leave  
  8022ee:	c3                   	ret    
  8022ef:	90                   	nop

008022f0 <__udivdi3>:
  8022f0:	55                   	push   %ebp
  8022f1:	57                   	push   %edi
  8022f2:	56                   	push   %esi
  8022f3:	53                   	push   %ebx
  8022f4:	83 ec 1c             	sub    $0x1c,%esp
  8022f7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8022fb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8022ff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802303:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802307:	89 ca                	mov    %ecx,%edx
  802309:	89 f8                	mov    %edi,%eax
  80230b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80230f:	85 f6                	test   %esi,%esi
  802311:	75 2d                	jne    802340 <__udivdi3+0x50>
  802313:	39 cf                	cmp    %ecx,%edi
  802315:	77 65                	ja     80237c <__udivdi3+0x8c>
  802317:	89 fd                	mov    %edi,%ebp
  802319:	85 ff                	test   %edi,%edi
  80231b:	75 0b                	jne    802328 <__udivdi3+0x38>
  80231d:	b8 01 00 00 00       	mov    $0x1,%eax
  802322:	31 d2                	xor    %edx,%edx
  802324:	f7 f7                	div    %edi
  802326:	89 c5                	mov    %eax,%ebp
  802328:	31 d2                	xor    %edx,%edx
  80232a:	89 c8                	mov    %ecx,%eax
  80232c:	f7 f5                	div    %ebp
  80232e:	89 c1                	mov    %eax,%ecx
  802330:	89 d8                	mov    %ebx,%eax
  802332:	f7 f5                	div    %ebp
  802334:	89 cf                	mov    %ecx,%edi
  802336:	89 fa                	mov    %edi,%edx
  802338:	83 c4 1c             	add    $0x1c,%esp
  80233b:	5b                   	pop    %ebx
  80233c:	5e                   	pop    %esi
  80233d:	5f                   	pop    %edi
  80233e:	5d                   	pop    %ebp
  80233f:	c3                   	ret    
  802340:	39 ce                	cmp    %ecx,%esi
  802342:	77 28                	ja     80236c <__udivdi3+0x7c>
  802344:	0f bd fe             	bsr    %esi,%edi
  802347:	83 f7 1f             	xor    $0x1f,%edi
  80234a:	75 40                	jne    80238c <__udivdi3+0x9c>
  80234c:	39 ce                	cmp    %ecx,%esi
  80234e:	72 0a                	jb     80235a <__udivdi3+0x6a>
  802350:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802354:	0f 87 9e 00 00 00    	ja     8023f8 <__udivdi3+0x108>
  80235a:	b8 01 00 00 00       	mov    $0x1,%eax
  80235f:	89 fa                	mov    %edi,%edx
  802361:	83 c4 1c             	add    $0x1c,%esp
  802364:	5b                   	pop    %ebx
  802365:	5e                   	pop    %esi
  802366:	5f                   	pop    %edi
  802367:	5d                   	pop    %ebp
  802368:	c3                   	ret    
  802369:	8d 76 00             	lea    0x0(%esi),%esi
  80236c:	31 ff                	xor    %edi,%edi
  80236e:	31 c0                	xor    %eax,%eax
  802370:	89 fa                	mov    %edi,%edx
  802372:	83 c4 1c             	add    $0x1c,%esp
  802375:	5b                   	pop    %ebx
  802376:	5e                   	pop    %esi
  802377:	5f                   	pop    %edi
  802378:	5d                   	pop    %ebp
  802379:	c3                   	ret    
  80237a:	66 90                	xchg   %ax,%ax
  80237c:	89 d8                	mov    %ebx,%eax
  80237e:	f7 f7                	div    %edi
  802380:	31 ff                	xor    %edi,%edi
  802382:	89 fa                	mov    %edi,%edx
  802384:	83 c4 1c             	add    $0x1c,%esp
  802387:	5b                   	pop    %ebx
  802388:	5e                   	pop    %esi
  802389:	5f                   	pop    %edi
  80238a:	5d                   	pop    %ebp
  80238b:	c3                   	ret    
  80238c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802391:	89 eb                	mov    %ebp,%ebx
  802393:	29 fb                	sub    %edi,%ebx
  802395:	89 f9                	mov    %edi,%ecx
  802397:	d3 e6                	shl    %cl,%esi
  802399:	89 c5                	mov    %eax,%ebp
  80239b:	88 d9                	mov    %bl,%cl
  80239d:	d3 ed                	shr    %cl,%ebp
  80239f:	89 e9                	mov    %ebp,%ecx
  8023a1:	09 f1                	or     %esi,%ecx
  8023a3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8023a7:	89 f9                	mov    %edi,%ecx
  8023a9:	d3 e0                	shl    %cl,%eax
  8023ab:	89 c5                	mov    %eax,%ebp
  8023ad:	89 d6                	mov    %edx,%esi
  8023af:	88 d9                	mov    %bl,%cl
  8023b1:	d3 ee                	shr    %cl,%esi
  8023b3:	89 f9                	mov    %edi,%ecx
  8023b5:	d3 e2                	shl    %cl,%edx
  8023b7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023bb:	88 d9                	mov    %bl,%cl
  8023bd:	d3 e8                	shr    %cl,%eax
  8023bf:	09 c2                	or     %eax,%edx
  8023c1:	89 d0                	mov    %edx,%eax
  8023c3:	89 f2                	mov    %esi,%edx
  8023c5:	f7 74 24 0c          	divl   0xc(%esp)
  8023c9:	89 d6                	mov    %edx,%esi
  8023cb:	89 c3                	mov    %eax,%ebx
  8023cd:	f7 e5                	mul    %ebp
  8023cf:	39 d6                	cmp    %edx,%esi
  8023d1:	72 19                	jb     8023ec <__udivdi3+0xfc>
  8023d3:	74 0b                	je     8023e0 <__udivdi3+0xf0>
  8023d5:	89 d8                	mov    %ebx,%eax
  8023d7:	31 ff                	xor    %edi,%edi
  8023d9:	e9 58 ff ff ff       	jmp    802336 <__udivdi3+0x46>
  8023de:	66 90                	xchg   %ax,%ax
  8023e0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8023e4:	89 f9                	mov    %edi,%ecx
  8023e6:	d3 e2                	shl    %cl,%edx
  8023e8:	39 c2                	cmp    %eax,%edx
  8023ea:	73 e9                	jae    8023d5 <__udivdi3+0xe5>
  8023ec:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8023ef:	31 ff                	xor    %edi,%edi
  8023f1:	e9 40 ff ff ff       	jmp    802336 <__udivdi3+0x46>
  8023f6:	66 90                	xchg   %ax,%ax
  8023f8:	31 c0                	xor    %eax,%eax
  8023fa:	e9 37 ff ff ff       	jmp    802336 <__udivdi3+0x46>
  8023ff:	90                   	nop

00802400 <__umoddi3>:
  802400:	55                   	push   %ebp
  802401:	57                   	push   %edi
  802402:	56                   	push   %esi
  802403:	53                   	push   %ebx
  802404:	83 ec 1c             	sub    $0x1c,%esp
  802407:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80240b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80240f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802413:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802417:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80241b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80241f:	89 f3                	mov    %esi,%ebx
  802421:	89 fa                	mov    %edi,%edx
  802423:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802427:	89 34 24             	mov    %esi,(%esp)
  80242a:	85 c0                	test   %eax,%eax
  80242c:	75 1a                	jne    802448 <__umoddi3+0x48>
  80242e:	39 f7                	cmp    %esi,%edi
  802430:	0f 86 a2 00 00 00    	jbe    8024d8 <__umoddi3+0xd8>
  802436:	89 c8                	mov    %ecx,%eax
  802438:	89 f2                	mov    %esi,%edx
  80243a:	f7 f7                	div    %edi
  80243c:	89 d0                	mov    %edx,%eax
  80243e:	31 d2                	xor    %edx,%edx
  802440:	83 c4 1c             	add    $0x1c,%esp
  802443:	5b                   	pop    %ebx
  802444:	5e                   	pop    %esi
  802445:	5f                   	pop    %edi
  802446:	5d                   	pop    %ebp
  802447:	c3                   	ret    
  802448:	39 f0                	cmp    %esi,%eax
  80244a:	0f 87 ac 00 00 00    	ja     8024fc <__umoddi3+0xfc>
  802450:	0f bd e8             	bsr    %eax,%ebp
  802453:	83 f5 1f             	xor    $0x1f,%ebp
  802456:	0f 84 ac 00 00 00    	je     802508 <__umoddi3+0x108>
  80245c:	bf 20 00 00 00       	mov    $0x20,%edi
  802461:	29 ef                	sub    %ebp,%edi
  802463:	89 fe                	mov    %edi,%esi
  802465:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802469:	89 e9                	mov    %ebp,%ecx
  80246b:	d3 e0                	shl    %cl,%eax
  80246d:	89 d7                	mov    %edx,%edi
  80246f:	89 f1                	mov    %esi,%ecx
  802471:	d3 ef                	shr    %cl,%edi
  802473:	09 c7                	or     %eax,%edi
  802475:	89 e9                	mov    %ebp,%ecx
  802477:	d3 e2                	shl    %cl,%edx
  802479:	89 14 24             	mov    %edx,(%esp)
  80247c:	89 d8                	mov    %ebx,%eax
  80247e:	d3 e0                	shl    %cl,%eax
  802480:	89 c2                	mov    %eax,%edx
  802482:	8b 44 24 08          	mov    0x8(%esp),%eax
  802486:	d3 e0                	shl    %cl,%eax
  802488:	89 44 24 04          	mov    %eax,0x4(%esp)
  80248c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802490:	89 f1                	mov    %esi,%ecx
  802492:	d3 e8                	shr    %cl,%eax
  802494:	09 d0                	or     %edx,%eax
  802496:	d3 eb                	shr    %cl,%ebx
  802498:	89 da                	mov    %ebx,%edx
  80249a:	f7 f7                	div    %edi
  80249c:	89 d3                	mov    %edx,%ebx
  80249e:	f7 24 24             	mull   (%esp)
  8024a1:	89 c6                	mov    %eax,%esi
  8024a3:	89 d1                	mov    %edx,%ecx
  8024a5:	39 d3                	cmp    %edx,%ebx
  8024a7:	0f 82 87 00 00 00    	jb     802534 <__umoddi3+0x134>
  8024ad:	0f 84 91 00 00 00    	je     802544 <__umoddi3+0x144>
  8024b3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024b7:	29 f2                	sub    %esi,%edx
  8024b9:	19 cb                	sbb    %ecx,%ebx
  8024bb:	89 d8                	mov    %ebx,%eax
  8024bd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8024c1:	d3 e0                	shl    %cl,%eax
  8024c3:	89 e9                	mov    %ebp,%ecx
  8024c5:	d3 ea                	shr    %cl,%edx
  8024c7:	09 d0                	or     %edx,%eax
  8024c9:	89 e9                	mov    %ebp,%ecx
  8024cb:	d3 eb                	shr    %cl,%ebx
  8024cd:	89 da                	mov    %ebx,%edx
  8024cf:	83 c4 1c             	add    $0x1c,%esp
  8024d2:	5b                   	pop    %ebx
  8024d3:	5e                   	pop    %esi
  8024d4:	5f                   	pop    %edi
  8024d5:	5d                   	pop    %ebp
  8024d6:	c3                   	ret    
  8024d7:	90                   	nop
  8024d8:	89 fd                	mov    %edi,%ebp
  8024da:	85 ff                	test   %edi,%edi
  8024dc:	75 0b                	jne    8024e9 <__umoddi3+0xe9>
  8024de:	b8 01 00 00 00       	mov    $0x1,%eax
  8024e3:	31 d2                	xor    %edx,%edx
  8024e5:	f7 f7                	div    %edi
  8024e7:	89 c5                	mov    %eax,%ebp
  8024e9:	89 f0                	mov    %esi,%eax
  8024eb:	31 d2                	xor    %edx,%edx
  8024ed:	f7 f5                	div    %ebp
  8024ef:	89 c8                	mov    %ecx,%eax
  8024f1:	f7 f5                	div    %ebp
  8024f3:	89 d0                	mov    %edx,%eax
  8024f5:	e9 44 ff ff ff       	jmp    80243e <__umoddi3+0x3e>
  8024fa:	66 90                	xchg   %ax,%ax
  8024fc:	89 c8                	mov    %ecx,%eax
  8024fe:	89 f2                	mov    %esi,%edx
  802500:	83 c4 1c             	add    $0x1c,%esp
  802503:	5b                   	pop    %ebx
  802504:	5e                   	pop    %esi
  802505:	5f                   	pop    %edi
  802506:	5d                   	pop    %ebp
  802507:	c3                   	ret    
  802508:	3b 04 24             	cmp    (%esp),%eax
  80250b:	72 06                	jb     802513 <__umoddi3+0x113>
  80250d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802511:	77 0f                	ja     802522 <__umoddi3+0x122>
  802513:	89 f2                	mov    %esi,%edx
  802515:	29 f9                	sub    %edi,%ecx
  802517:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80251b:	89 14 24             	mov    %edx,(%esp)
  80251e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802522:	8b 44 24 04          	mov    0x4(%esp),%eax
  802526:	8b 14 24             	mov    (%esp),%edx
  802529:	83 c4 1c             	add    $0x1c,%esp
  80252c:	5b                   	pop    %ebx
  80252d:	5e                   	pop    %esi
  80252e:	5f                   	pop    %edi
  80252f:	5d                   	pop    %ebp
  802530:	c3                   	ret    
  802531:	8d 76 00             	lea    0x0(%esi),%esi
  802534:	2b 04 24             	sub    (%esp),%eax
  802537:	19 fa                	sbb    %edi,%edx
  802539:	89 d1                	mov    %edx,%ecx
  80253b:	89 c6                	mov    %eax,%esi
  80253d:	e9 71 ff ff ff       	jmp    8024b3 <__umoddi3+0xb3>
  802542:	66 90                	xchg   %ax,%ax
  802544:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802548:	72 ea                	jb     802534 <__umoddi3+0x134>
  80254a:	89 d9                	mov    %ebx,%ecx
  80254c:	e9 62 ff ff ff       	jmp    8024b3 <__umoddi3+0xb3>
