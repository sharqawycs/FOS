
obj/user/tst_page_replacement_free_rapid_proc_2:     file format elf32-i386


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
  800031:	e8 2d 05 00 00       	call   800563 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;
char* ptr3 = (char*) 0xeebfe000 - (PAGE_SIZE) -1;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec bc 00 00 00    	sub    $0xbc,%esp

//	cprintf("envID = %d\n",envID);
	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800044:	a1 20 30 80 00       	mov    0x803020,%eax
  800049:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80004f:	8b 00                	mov    (%eax),%eax
  800051:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800054:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800057:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80005c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800061:	74 14                	je     800077 <_main+0x3f>
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	68 40 1f 80 00       	push   $0x801f40
  80006b:	6a 12                	push   $0x12
  80006d:	68 84 1f 80 00       	push   $0x801f84
  800072:	e8 ee 05 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800077:	a1 20 30 80 00       	mov    0x803020,%eax
  80007c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800082:	83 c0 0c             	add    $0xc,%eax
  800085:	8b 00                	mov    (%eax),%eax
  800087:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80008a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80008d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800092:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800097:	74 14                	je     8000ad <_main+0x75>
  800099:	83 ec 04             	sub    $0x4,%esp
  80009c:	68 40 1f 80 00       	push   $0x801f40
  8000a1:	6a 13                	push   $0x13
  8000a3:	68 84 1f 80 00       	push   $0x801f84
  8000a8:	e8 b8 05 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b8:	83 c0 18             	add    $0x18,%eax
  8000bb:	8b 00                	mov    (%eax),%eax
  8000bd:	89 45 d8             	mov    %eax,-0x28(%ebp)
  8000c0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c8:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000cd:	74 14                	je     8000e3 <_main+0xab>
  8000cf:	83 ec 04             	sub    $0x4,%esp
  8000d2:	68 40 1f 80 00       	push   $0x801f40
  8000d7:	6a 14                	push   $0x14
  8000d9:	68 84 1f 80 00       	push   $0x801f84
  8000de:	e8 82 05 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e8:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000ee:	83 c0 24             	add    $0x24,%eax
  8000f1:	8b 00                	mov    (%eax),%eax
  8000f3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000f6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fe:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 40 1f 80 00       	push   $0x801f40
  80010d:	6a 15                	push   $0x15
  80010f:	68 84 1f 80 00       	push   $0x801f84
  800114:	e8 4c 05 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800119:	a1 20 30 80 00       	mov    0x803020,%eax
  80011e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800124:	83 c0 30             	add    $0x30,%eax
  800127:	8b 00                	mov    (%eax),%eax
  800129:	89 45 d0             	mov    %eax,-0x30(%ebp)
  80012c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80012f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800134:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800139:	74 14                	je     80014f <_main+0x117>
  80013b:	83 ec 04             	sub    $0x4,%esp
  80013e:	68 40 1f 80 00       	push   $0x801f40
  800143:	6a 16                	push   $0x16
  800145:	68 84 1f 80 00       	push   $0x801f84
  80014a:	e8 16 05 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014f:	a1 20 30 80 00       	mov    0x803020,%eax
  800154:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80015a:	83 c0 3c             	add    $0x3c,%eax
  80015d:	8b 00                	mov    (%eax),%eax
  80015f:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800162:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800165:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80016a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016f:	74 14                	je     800185 <_main+0x14d>
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 40 1f 80 00       	push   $0x801f40
  800179:	6a 17                	push   $0x17
  80017b:	68 84 1f 80 00       	push   $0x801f84
  800180:	e8 e0 04 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800185:	a1 20 30 80 00       	mov    0x803020,%eax
  80018a:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800190:	83 c0 48             	add    $0x48,%eax
  800193:	8b 00                	mov    (%eax),%eax
  800195:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800198:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80019b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001a0:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a5:	74 14                	je     8001bb <_main+0x183>
  8001a7:	83 ec 04             	sub    $0x4,%esp
  8001aa:	68 40 1f 80 00       	push   $0x801f40
  8001af:	6a 18                	push   $0x18
  8001b1:	68 84 1f 80 00       	push   $0x801f84
  8001b6:	e8 aa 04 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c6:	83 c0 54             	add    $0x54,%eax
  8001c9:	8b 00                	mov    (%eax),%eax
  8001cb:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  8001ce:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001d1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d6:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001db:	74 14                	je     8001f1 <_main+0x1b9>
  8001dd:	83 ec 04             	sub    $0x4,%esp
  8001e0:	68 40 1f 80 00       	push   $0x801f40
  8001e5:	6a 19                	push   $0x19
  8001e7:	68 84 1f 80 00       	push   $0x801f84
  8001ec:	e8 74 04 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f6:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001fc:	83 c0 60             	add    $0x60,%eax
  8001ff:	8b 00                	mov    (%eax),%eax
  800201:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800204:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800207:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020c:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800211:	74 14                	je     800227 <_main+0x1ef>
  800213:	83 ec 04             	sub    $0x4,%esp
  800216:	68 40 1f 80 00       	push   $0x801f40
  80021b:	6a 1a                	push   $0x1a
  80021d:	68 84 1f 80 00       	push   $0x801f84
  800222:	e8 3e 04 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800227:	a1 20 30 80 00       	mov    0x803020,%eax
  80022c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800232:	83 c0 6c             	add    $0x6c,%eax
  800235:	8b 00                	mov    (%eax),%eax
  800237:	89 45 bc             	mov    %eax,-0x44(%ebp)
  80023a:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80023d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800242:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800247:	74 14                	je     80025d <_main+0x225>
  800249:	83 ec 04             	sub    $0x4,%esp
  80024c:	68 40 1f 80 00       	push   $0x801f40
  800251:	6a 1b                	push   $0x1b
  800253:	68 84 1f 80 00       	push   $0x801f84
  800258:	e8 08 04 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x804000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025d:	a1 20 30 80 00       	mov    0x803020,%eax
  800262:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800268:	83 c0 78             	add    $0x78,%eax
  80026b:	8b 00                	mov    (%eax),%eax
  80026d:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800270:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800273:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800278:	3d 00 40 80 00       	cmp    $0x804000,%eax
  80027d:	74 14                	je     800293 <_main+0x25b>
  80027f:	83 ec 04             	sub    $0x4,%esp
  800282:	68 40 1f 80 00       	push   $0x801f40
  800287:	6a 1c                	push   $0x1c
  800289:	68 84 1f 80 00       	push   $0x801f84
  80028e:	e8 d2 03 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0x805000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800293:	a1 20 30 80 00       	mov    0x803020,%eax
  800298:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80029e:	05 84 00 00 00       	add    $0x84,%eax
  8002a3:	8b 00                	mov    (%eax),%eax
  8002a5:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8002a8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8002ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002b0:	3d 00 50 80 00       	cmp    $0x805000,%eax
  8002b5:	74 14                	je     8002cb <_main+0x293>
  8002b7:	83 ec 04             	sub    $0x4,%esp
  8002ba:	68 40 1f 80 00       	push   $0x801f40
  8002bf:	6a 1d                	push   $0x1d
  8002c1:	68 84 1f 80 00       	push   $0x801f84
  8002c6:	e8 9a 03 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[12].virtual_address,PAGE_SIZE) !=   0x806000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002cb:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002d6:	05 90 00 00 00       	add    $0x90,%eax
  8002db:	8b 00                	mov    (%eax),%eax
  8002dd:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8002e0:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002e3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002e8:	3d 00 60 80 00       	cmp    $0x806000,%eax
  8002ed:	74 14                	je     800303 <_main+0x2cb>
  8002ef:	83 ec 04             	sub    $0x4,%esp
  8002f2:	68 40 1f 80 00       	push   $0x801f40
  8002f7:	6a 1e                	push   $0x1e
  8002f9:	68 84 1f 80 00       	push   $0x801f84
  8002fe:	e8 62 03 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[13].virtual_address,PAGE_SIZE) !=   0x807000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800303:	a1 20 30 80 00       	mov    0x803020,%eax
  800308:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80030e:	05 9c 00 00 00       	add    $0x9c,%eax
  800313:	8b 00                	mov    (%eax),%eax
  800315:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800318:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80031b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800320:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800325:	74 14                	je     80033b <_main+0x303>
  800327:	83 ec 04             	sub    $0x4,%esp
  80032a:	68 40 1f 80 00       	push   $0x801f40
  80032f:	6a 1f                	push   $0x1f
  800331:	68 84 1f 80 00       	push   $0x801f84
  800336:	e8 2a 03 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[14].virtual_address,PAGE_SIZE) !=   0x808000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80033b:	a1 20 30 80 00       	mov    0x803020,%eax
  800340:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800346:	05 a8 00 00 00       	add    $0xa8,%eax
  80034b:	8b 00                	mov    (%eax),%eax
  80034d:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800350:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800353:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800358:	3d 00 80 80 00       	cmp    $0x808000,%eax
  80035d:	74 14                	je     800373 <_main+0x33b>
  80035f:	83 ec 04             	sub    $0x4,%esp
  800362:	68 40 1f 80 00       	push   $0x801f40
  800367:	6a 20                	push   $0x20
  800369:	68 84 1f 80 00       	push   $0x801f84
  80036e:	e8 f2 02 00 00       	call   800665 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800373:	a1 20 30 80 00       	mov    0x803020,%eax
  800378:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80037e:	05 b4 00 00 00       	add    $0xb4,%eax
  800383:	8b 00                	mov    (%eax),%eax
  800385:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  800388:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80038b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800390:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800395:	74 14                	je     8003ab <_main+0x373>
  800397:	83 ec 04             	sub    $0x4,%esp
  80039a:	68 40 1f 80 00       	push   $0x801f40
  80039f:	6a 21                	push   $0x21
  8003a1:	68 84 1f 80 00       	push   $0x801f84
  8003a6:	e8 ba 02 00 00       	call   800665 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  8003ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b0:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  8003b6:	85 c0                	test   %eax,%eax
  8003b8:	74 14                	je     8003ce <_main+0x396>
  8003ba:	83 ec 04             	sub    $0x4,%esp
  8003bd:	68 b4 1f 80 00       	push   $0x801fb4
  8003c2:	6a 22                	push   $0x22
  8003c4:	68 84 1f 80 00       	push   $0x801f84
  8003c9:	e8 97 02 00 00       	call   800665 <_panic>
	}

	// Create & run the slave environments
	int IDs[4];
	IDs[0] = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8003ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d3:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8003d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003de:	8b 40 74             	mov    0x74(%eax),%eax
  8003e1:	83 ec 04             	sub    $0x4,%esp
  8003e4:	52                   	push   %edx
  8003e5:	50                   	push   %eax
  8003e6:	68 fa 1f 80 00       	push   $0x801ffa
  8003eb:	e8 74 16 00 00       	call   801a64 <sys_create_env>
  8003f0:	83 c4 10             	add    $0x10,%esp
  8003f3:	89 45 80             	mov    %eax,-0x80(%ebp)
	sys_run_env(IDs[0]);
  8003f6:	8b 45 80             	mov    -0x80(%ebp),%eax
  8003f9:	83 ec 0c             	sub    $0xc,%esp
  8003fc:	50                   	push   %eax
  8003fd:	e8 7f 16 00 00       	call   801a81 <sys_run_env>
  800402:	83 c4 10             	add    $0x10,%esp
	for(int i = 1; i < 4; ++i)
  800405:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  80040c:	eb 44                	jmp    800452 <_main+0x41a>
	{
		IDs[i] = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  80040e:	a1 20 30 80 00       	mov    0x803020,%eax
  800413:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800419:	a1 20 30 80 00       	mov    0x803020,%eax
  80041e:	8b 40 74             	mov    0x74(%eax),%eax
  800421:	83 ec 04             	sub    $0x4,%esp
  800424:	52                   	push   %edx
  800425:	50                   	push   %eax
  800426:	68 09 20 80 00       	push   $0x802009
  80042b:	e8 34 16 00 00       	call   801a64 <sys_create_env>
  800430:	83 c4 10             	add    $0x10,%esp
  800433:	89 c2                	mov    %eax,%edx
  800435:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800438:	89 54 85 80          	mov    %edx,-0x80(%ebp,%eax,4)
		sys_run_env(IDs[i]);
  80043c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80043f:	8b 44 85 80          	mov    -0x80(%ebp,%eax,4),%eax
  800443:	83 ec 0c             	sub    $0xc,%esp
  800446:	50                   	push   %eax
  800447:	e8 35 16 00 00       	call   801a81 <sys_run_env>
  80044c:	83 c4 10             	add    $0x10,%esp

	// Create & run the slave environments
	int IDs[4];
	IDs[0] = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
	sys_run_env(IDs[0]);
	for(int i = 1; i < 4; ++i)
  80044f:	ff 45 e4             	incl   -0x1c(%ebp)
  800452:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800456:	7e b6                	jle    80040e <_main+0x3d6>
	{
		IDs[i] = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(IDs[i]);
	}
	// To check that the slave environments completed successfully
	rsttst();
  800458:	e8 ee 16 00 00       	call   801b4b <rsttst>

	uint32 freePagesBefore = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  80045d:	e8 ad 13 00 00       	call   80180f <sys_calculate_free_frames>
  800462:	89 c3                	mov    %eax,%ebx
  800464:	e8 bf 13 00 00       	call   801828 <sys_calculate_modified_frames>
  800469:	01 d8                	add    %ebx,%eax
  80046b:	89 45 a0             	mov    %eax,-0x60(%ebp)
	uint32 usedDiskPagesBefore = sys_pf_calculate_allocated_pages();
  80046e:	e8 1f 14 00 00       	call   801892 <sys_pf_calculate_allocated_pages>
  800473:	89 45 9c             	mov    %eax,-0x64(%ebp)
	// Check the number of pages shall be deleted with the first fault after freeing the process
	int pagesToBeDeletedCount = sys_calculate_pages_tobe_removed_ready_exit(2);
  800476:	83 ec 0c             	sub    $0xc,%esp
  800479:	6a 02                	push   $0x2
  80047b:	e8 2b 14 00 00       	call   8018ab <sys_calculate_pages_tobe_removed_ready_exit>
  800480:	83 c4 10             	add    $0x10,%esp
  800483:	89 45 98             	mov    %eax,-0x68(%ebp)

	// FAULT with TWO STACK Pages to FREE the rapid running MASTER process
	char x = *ptr3;
  800486:	a1 08 30 80 00       	mov    0x803008,%eax
  80048b:	8a 00                	mov    (%eax),%al
  80048d:	88 45 97             	mov    %al,-0x69(%ebp)

	uint32 expectedPages[16] = {0xeebfc000,0x800000,0x801000,0x802000,0x803000,0xeebfd000,0,0,0,0,0,0,0,0,0,0};
  800490:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
  800496:	bb 80 21 80 00       	mov    $0x802180,%ebx
  80049b:	ba 10 00 00 00       	mov    $0x10,%edx
  8004a0:	89 c7                	mov    %eax,%edi
  8004a2:	89 de                	mov    %ebx,%esi
  8004a4:	89 d1                	mov    %edx,%ecx
  8004a6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	//cprintf("Checking PAGE LRU algorithm... \n");
	{
		CheckWSWithoutLastIndex(expectedPages, 16);
  8004a8:	83 ec 08             	sub    $0x8,%esp
  8004ab:	6a 10                	push   $0x10
  8004ad:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
  8004b3:	50                   	push   %eax
  8004b4:	e8 1e 02 00 00       	call   8006d7 <CheckWSWithoutLastIndex>
  8004b9:	83 c4 10             	add    $0x10,%esp

		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if(myEnv->page_last_WS_index != 2) panic("wrong PAGE WS pointer location");
	}

	x = *(ptr3-PAGE_SIZE);
  8004bc:	a1 08 30 80 00       	mov    0x803008,%eax
  8004c1:	8a 80 00 f0 ff ff    	mov    -0x1000(%eax),%al
  8004c7:	88 45 97             	mov    %al,-0x69(%ebp)

	//cprintf("Checking Allocation in Mem & Page File... \n");
	//AFTER freeing MEMORY
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPagesBefore) !=  2) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  8004ca:	e8 c3 13 00 00       	call   801892 <sys_pf_calculate_allocated_pages>
  8004cf:	2b 45 9c             	sub    -0x64(%ebp),%eax
  8004d2:	83 f8 02             	cmp    $0x2,%eax
  8004d5:	74 14                	je     8004eb <_main+0x4b3>
  8004d7:	83 ec 04             	sub    $0x4,%esp
  8004da:	68 18 20 80 00       	push   $0x802018
  8004df:	6a 59                	push   $0x59
  8004e1:	68 84 1f 80 00       	push   $0x801f84
  8004e6:	e8 7a 01 00 00       	call   800665 <_panic>
		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  8004eb:	e8 1f 13 00 00       	call   80180f <sys_calculate_free_frames>
  8004f0:	89 c3                	mov    %eax,%ebx
  8004f2:	e8 31 13 00 00       	call   801828 <sys_calculate_modified_frames>
  8004f7:	01 d8                	add    %ebx,%eax
  8004f9:	89 45 90             	mov    %eax,-0x70(%ebp)
		if( (freePagesBefore + pagesToBeDeletedCount - 3) != freePagesAfter )	// 3 => 2 STACK PAGES and 1 CODE page started from the fault of the stack page ALLOCATED
  8004fc:	8b 55 98             	mov    -0x68(%ebp),%edx
  8004ff:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800502:	01 d0                	add    %edx,%eax
  800504:	83 e8 03             	sub    $0x3,%eax
  800507:	3b 45 90             	cmp    -0x70(%ebp),%eax
  80050a:	74 20                	je     80052c <_main+0x4f4>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED for the running RAPID process %d %d", freePagesBefore + pagesToBeDeletedCount, freePagesAfter);
  80050c:	8b 55 98             	mov    -0x68(%ebp),%edx
  80050f:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800512:	01 d0                	add    %edx,%eax
  800514:	83 ec 0c             	sub    $0xc,%esp
  800517:	ff 75 90             	pushl  -0x70(%ebp)
  80051a:	50                   	push   %eax
  80051b:	68 84 20 80 00       	push   $0x802084
  800520:	6a 5c                	push   $0x5c
  800522:	68 84 1f 80 00       	push   $0x801f84
  800527:	e8 39 01 00 00       	call   800665 <_panic>
	}

	//cprintf("Checking PAGE LRU algorithm... \n");
	{
		expectedPages[6] =  0xeebfb000;
  80052c:	c7 85 58 ff ff ff 00 	movl   $0xeebfb000,-0xa8(%ebp)
  800533:	b0 bf ee 
		CheckWSWithoutLastIndex(expectedPages, 16);
  800536:	83 ec 08             	sub    $0x8,%esp
  800539:	6a 10                	push   $0x10
  80053b:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
  800541:	50                   	push   %eax
  800542:	e8 90 01 00 00       	call   8006d7 <CheckWSWithoutLastIndex>
  800547:	83 c4 10             	add    $0x10,%esp

		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if(myEnv->page_last_WS_index != 3) panic("wrong PAGE WS pointer location");
	}

	cprintf("Congratulations!! test PAGE replacement [FREEING RAPID PROCESS 2] using LRU is completed successfully.\n");
  80054a:	83 ec 0c             	sub    $0xc,%esp
  80054d:	68 04 21 80 00       	push   $0x802104
  800552:	e8 c2 03 00 00       	call   800919 <cprintf>
  800557:	83 c4 10             	add    $0x10,%esp
	return;
  80055a:	90                   	nop
}
  80055b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80055e:	5b                   	pop    %ebx
  80055f:	5e                   	pop    %esi
  800560:	5f                   	pop    %edi
  800561:	5d                   	pop    %ebp
  800562:	c3                   	ret    

00800563 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800563:	55                   	push   %ebp
  800564:	89 e5                	mov    %esp,%ebp
  800566:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800569:	e8 d6 11 00 00       	call   801744 <sys_getenvindex>
  80056e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800571:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800574:	89 d0                	mov    %edx,%eax
  800576:	01 c0                	add    %eax,%eax
  800578:	01 d0                	add    %edx,%eax
  80057a:	c1 e0 02             	shl    $0x2,%eax
  80057d:	01 d0                	add    %edx,%eax
  80057f:	c1 e0 06             	shl    $0x6,%eax
  800582:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800587:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80058c:	a1 20 30 80 00       	mov    0x803020,%eax
  800591:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800597:	84 c0                	test   %al,%al
  800599:	74 0f                	je     8005aa <libmain+0x47>
		binaryname = myEnv->prog_name;
  80059b:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a0:	05 f4 02 00 00       	add    $0x2f4,%eax
  8005a5:	a3 0c 30 80 00       	mov    %eax,0x80300c

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005aa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005ae:	7e 0a                	jle    8005ba <libmain+0x57>
		binaryname = argv[0];
  8005b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005b3:	8b 00                	mov    (%eax),%eax
  8005b5:	a3 0c 30 80 00       	mov    %eax,0x80300c

	// call user main routine
	_main(argc, argv);
  8005ba:	83 ec 08             	sub    $0x8,%esp
  8005bd:	ff 75 0c             	pushl  0xc(%ebp)
  8005c0:	ff 75 08             	pushl  0x8(%ebp)
  8005c3:	e8 70 fa ff ff       	call   800038 <_main>
  8005c8:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8005cb:	e8 0f 13 00 00       	call   8018df <sys_disable_interrupt>
	cprintf("**************************************\n");
  8005d0:	83 ec 0c             	sub    $0xc,%esp
  8005d3:	68 d8 21 80 00       	push   $0x8021d8
  8005d8:	e8 3c 03 00 00       	call   800919 <cprintf>
  8005dd:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8005e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e5:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8005eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f0:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8005f6:	83 ec 04             	sub    $0x4,%esp
  8005f9:	52                   	push   %edx
  8005fa:	50                   	push   %eax
  8005fb:	68 00 22 80 00       	push   $0x802200
  800600:	e8 14 03 00 00       	call   800919 <cprintf>
  800605:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800608:	a1 20 30 80 00       	mov    0x803020,%eax
  80060d:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800613:	83 ec 08             	sub    $0x8,%esp
  800616:	50                   	push   %eax
  800617:	68 25 22 80 00       	push   $0x802225
  80061c:	e8 f8 02 00 00       	call   800919 <cprintf>
  800621:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800624:	83 ec 0c             	sub    $0xc,%esp
  800627:	68 d8 21 80 00       	push   $0x8021d8
  80062c:	e8 e8 02 00 00       	call   800919 <cprintf>
  800631:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800634:	e8 c0 12 00 00       	call   8018f9 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800639:	e8 19 00 00 00       	call   800657 <exit>
}
  80063e:	90                   	nop
  80063f:	c9                   	leave  
  800640:	c3                   	ret    

00800641 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800641:	55                   	push   %ebp
  800642:	89 e5                	mov    %esp,%ebp
  800644:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800647:	83 ec 0c             	sub    $0xc,%esp
  80064a:	6a 00                	push   $0x0
  80064c:	e8 bf 10 00 00       	call   801710 <sys_env_destroy>
  800651:	83 c4 10             	add    $0x10,%esp
}
  800654:	90                   	nop
  800655:	c9                   	leave  
  800656:	c3                   	ret    

00800657 <exit>:

void
exit(void)
{
  800657:	55                   	push   %ebp
  800658:	89 e5                	mov    %esp,%ebp
  80065a:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80065d:	e8 14 11 00 00       	call   801776 <sys_env_exit>
}
  800662:	90                   	nop
  800663:	c9                   	leave  
  800664:	c3                   	ret    

00800665 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800665:	55                   	push   %ebp
  800666:	89 e5                	mov    %esp,%ebp
  800668:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80066b:	8d 45 10             	lea    0x10(%ebp),%eax
  80066e:	83 c0 04             	add    $0x4,%eax
  800671:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800674:	a1 48 c0 80 00       	mov    0x80c048,%eax
  800679:	85 c0                	test   %eax,%eax
  80067b:	74 16                	je     800693 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80067d:	a1 48 c0 80 00       	mov    0x80c048,%eax
  800682:	83 ec 08             	sub    $0x8,%esp
  800685:	50                   	push   %eax
  800686:	68 3c 22 80 00       	push   $0x80223c
  80068b:	e8 89 02 00 00       	call   800919 <cprintf>
  800690:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800693:	a1 0c 30 80 00       	mov    0x80300c,%eax
  800698:	ff 75 0c             	pushl  0xc(%ebp)
  80069b:	ff 75 08             	pushl  0x8(%ebp)
  80069e:	50                   	push   %eax
  80069f:	68 41 22 80 00       	push   $0x802241
  8006a4:	e8 70 02 00 00       	call   800919 <cprintf>
  8006a9:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8006ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8006af:	83 ec 08             	sub    $0x8,%esp
  8006b2:	ff 75 f4             	pushl  -0xc(%ebp)
  8006b5:	50                   	push   %eax
  8006b6:	e8 f3 01 00 00       	call   8008ae <vcprintf>
  8006bb:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8006be:	83 ec 08             	sub    $0x8,%esp
  8006c1:	6a 00                	push   $0x0
  8006c3:	68 5d 22 80 00       	push   $0x80225d
  8006c8:	e8 e1 01 00 00       	call   8008ae <vcprintf>
  8006cd:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8006d0:	e8 82 ff ff ff       	call   800657 <exit>

	// should not return here
	while (1) ;
  8006d5:	eb fe                	jmp    8006d5 <_panic+0x70>

008006d7 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8006d7:	55                   	push   %ebp
  8006d8:	89 e5                	mov    %esp,%ebp
  8006da:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8006dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8006e2:	8b 50 74             	mov    0x74(%eax),%edx
  8006e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e8:	39 c2                	cmp    %eax,%edx
  8006ea:	74 14                	je     800700 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8006ec:	83 ec 04             	sub    $0x4,%esp
  8006ef:	68 60 22 80 00       	push   $0x802260
  8006f4:	6a 26                	push   $0x26
  8006f6:	68 ac 22 80 00       	push   $0x8022ac
  8006fb:	e8 65 ff ff ff       	call   800665 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800700:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800707:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80070e:	e9 c2 00 00 00       	jmp    8007d5 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800713:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800716:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	01 d0                	add    %edx,%eax
  800722:	8b 00                	mov    (%eax),%eax
  800724:	85 c0                	test   %eax,%eax
  800726:	75 08                	jne    800730 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800728:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80072b:	e9 a2 00 00 00       	jmp    8007d2 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800730:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800737:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80073e:	eb 69                	jmp    8007a9 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800740:	a1 20 30 80 00       	mov    0x803020,%eax
  800745:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80074b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80074e:	89 d0                	mov    %edx,%eax
  800750:	01 c0                	add    %eax,%eax
  800752:	01 d0                	add    %edx,%eax
  800754:	c1 e0 02             	shl    $0x2,%eax
  800757:	01 c8                	add    %ecx,%eax
  800759:	8a 40 04             	mov    0x4(%eax),%al
  80075c:	84 c0                	test   %al,%al
  80075e:	75 46                	jne    8007a6 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800760:	a1 20 30 80 00       	mov    0x803020,%eax
  800765:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80076b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80076e:	89 d0                	mov    %edx,%eax
  800770:	01 c0                	add    %eax,%eax
  800772:	01 d0                	add    %edx,%eax
  800774:	c1 e0 02             	shl    $0x2,%eax
  800777:	01 c8                	add    %ecx,%eax
  800779:	8b 00                	mov    (%eax),%eax
  80077b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80077e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800781:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800786:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800788:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80078b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800792:	8b 45 08             	mov    0x8(%ebp),%eax
  800795:	01 c8                	add    %ecx,%eax
  800797:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800799:	39 c2                	cmp    %eax,%edx
  80079b:	75 09                	jne    8007a6 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80079d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8007a4:	eb 12                	jmp    8007b8 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007a6:	ff 45 e8             	incl   -0x18(%ebp)
  8007a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8007ae:	8b 50 74             	mov    0x74(%eax),%edx
  8007b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007b4:	39 c2                	cmp    %eax,%edx
  8007b6:	77 88                	ja     800740 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8007b8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8007bc:	75 14                	jne    8007d2 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8007be:	83 ec 04             	sub    $0x4,%esp
  8007c1:	68 b8 22 80 00       	push   $0x8022b8
  8007c6:	6a 3a                	push   $0x3a
  8007c8:	68 ac 22 80 00       	push   $0x8022ac
  8007cd:	e8 93 fe ff ff       	call   800665 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8007d2:	ff 45 f0             	incl   -0x10(%ebp)
  8007d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007d8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8007db:	0f 8c 32 ff ff ff    	jl     800713 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8007e1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007e8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8007ef:	eb 26                	jmp    800817 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8007f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8007f6:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007fc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007ff:	89 d0                	mov    %edx,%eax
  800801:	01 c0                	add    %eax,%eax
  800803:	01 d0                	add    %edx,%eax
  800805:	c1 e0 02             	shl    $0x2,%eax
  800808:	01 c8                	add    %ecx,%eax
  80080a:	8a 40 04             	mov    0x4(%eax),%al
  80080d:	3c 01                	cmp    $0x1,%al
  80080f:	75 03                	jne    800814 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800811:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800814:	ff 45 e0             	incl   -0x20(%ebp)
  800817:	a1 20 30 80 00       	mov    0x803020,%eax
  80081c:	8b 50 74             	mov    0x74(%eax),%edx
  80081f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800822:	39 c2                	cmp    %eax,%edx
  800824:	77 cb                	ja     8007f1 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800826:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800829:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80082c:	74 14                	je     800842 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80082e:	83 ec 04             	sub    $0x4,%esp
  800831:	68 0c 23 80 00       	push   $0x80230c
  800836:	6a 44                	push   $0x44
  800838:	68 ac 22 80 00       	push   $0x8022ac
  80083d:	e8 23 fe ff ff       	call   800665 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800842:	90                   	nop
  800843:	c9                   	leave  
  800844:	c3                   	ret    

00800845 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800845:	55                   	push   %ebp
  800846:	89 e5                	mov    %esp,%ebp
  800848:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80084b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80084e:	8b 00                	mov    (%eax),%eax
  800850:	8d 48 01             	lea    0x1(%eax),%ecx
  800853:	8b 55 0c             	mov    0xc(%ebp),%edx
  800856:	89 0a                	mov    %ecx,(%edx)
  800858:	8b 55 08             	mov    0x8(%ebp),%edx
  80085b:	88 d1                	mov    %dl,%cl
  80085d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800860:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800864:	8b 45 0c             	mov    0xc(%ebp),%eax
  800867:	8b 00                	mov    (%eax),%eax
  800869:	3d ff 00 00 00       	cmp    $0xff,%eax
  80086e:	75 2c                	jne    80089c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800870:	a0 24 30 80 00       	mov    0x803024,%al
  800875:	0f b6 c0             	movzbl %al,%eax
  800878:	8b 55 0c             	mov    0xc(%ebp),%edx
  80087b:	8b 12                	mov    (%edx),%edx
  80087d:	89 d1                	mov    %edx,%ecx
  80087f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800882:	83 c2 08             	add    $0x8,%edx
  800885:	83 ec 04             	sub    $0x4,%esp
  800888:	50                   	push   %eax
  800889:	51                   	push   %ecx
  80088a:	52                   	push   %edx
  80088b:	e8 3e 0e 00 00       	call   8016ce <sys_cputs>
  800890:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800893:	8b 45 0c             	mov    0xc(%ebp),%eax
  800896:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80089c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089f:	8b 40 04             	mov    0x4(%eax),%eax
  8008a2:	8d 50 01             	lea    0x1(%eax),%edx
  8008a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a8:	89 50 04             	mov    %edx,0x4(%eax)
}
  8008ab:	90                   	nop
  8008ac:	c9                   	leave  
  8008ad:	c3                   	ret    

008008ae <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8008ae:	55                   	push   %ebp
  8008af:	89 e5                	mov    %esp,%ebp
  8008b1:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8008b7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8008be:	00 00 00 
	b.cnt = 0;
  8008c1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8008c8:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8008cb:	ff 75 0c             	pushl  0xc(%ebp)
  8008ce:	ff 75 08             	pushl  0x8(%ebp)
  8008d1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8008d7:	50                   	push   %eax
  8008d8:	68 45 08 80 00       	push   $0x800845
  8008dd:	e8 11 02 00 00       	call   800af3 <vprintfmt>
  8008e2:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8008e5:	a0 24 30 80 00       	mov    0x803024,%al
  8008ea:	0f b6 c0             	movzbl %al,%eax
  8008ed:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8008f3:	83 ec 04             	sub    $0x4,%esp
  8008f6:	50                   	push   %eax
  8008f7:	52                   	push   %edx
  8008f8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8008fe:	83 c0 08             	add    $0x8,%eax
  800901:	50                   	push   %eax
  800902:	e8 c7 0d 00 00       	call   8016ce <sys_cputs>
  800907:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80090a:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800911:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800917:	c9                   	leave  
  800918:	c3                   	ret    

00800919 <cprintf>:

int cprintf(const char *fmt, ...) {
  800919:	55                   	push   %ebp
  80091a:	89 e5                	mov    %esp,%ebp
  80091c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80091f:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800926:	8d 45 0c             	lea    0xc(%ebp),%eax
  800929:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80092c:	8b 45 08             	mov    0x8(%ebp),%eax
  80092f:	83 ec 08             	sub    $0x8,%esp
  800932:	ff 75 f4             	pushl  -0xc(%ebp)
  800935:	50                   	push   %eax
  800936:	e8 73 ff ff ff       	call   8008ae <vcprintf>
  80093b:	83 c4 10             	add    $0x10,%esp
  80093e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800941:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800944:	c9                   	leave  
  800945:	c3                   	ret    

00800946 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800946:	55                   	push   %ebp
  800947:	89 e5                	mov    %esp,%ebp
  800949:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80094c:	e8 8e 0f 00 00       	call   8018df <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800951:	8d 45 0c             	lea    0xc(%ebp),%eax
  800954:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800957:	8b 45 08             	mov    0x8(%ebp),%eax
  80095a:	83 ec 08             	sub    $0x8,%esp
  80095d:	ff 75 f4             	pushl  -0xc(%ebp)
  800960:	50                   	push   %eax
  800961:	e8 48 ff ff ff       	call   8008ae <vcprintf>
  800966:	83 c4 10             	add    $0x10,%esp
  800969:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80096c:	e8 88 0f 00 00       	call   8018f9 <sys_enable_interrupt>
	return cnt;
  800971:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800974:	c9                   	leave  
  800975:	c3                   	ret    

00800976 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800976:	55                   	push   %ebp
  800977:	89 e5                	mov    %esp,%ebp
  800979:	53                   	push   %ebx
  80097a:	83 ec 14             	sub    $0x14,%esp
  80097d:	8b 45 10             	mov    0x10(%ebp),%eax
  800980:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800983:	8b 45 14             	mov    0x14(%ebp),%eax
  800986:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800989:	8b 45 18             	mov    0x18(%ebp),%eax
  80098c:	ba 00 00 00 00       	mov    $0x0,%edx
  800991:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800994:	77 55                	ja     8009eb <printnum+0x75>
  800996:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800999:	72 05                	jb     8009a0 <printnum+0x2a>
  80099b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80099e:	77 4b                	ja     8009eb <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009a0:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8009a3:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8009a6:	8b 45 18             	mov    0x18(%ebp),%eax
  8009a9:	ba 00 00 00 00       	mov    $0x0,%edx
  8009ae:	52                   	push   %edx
  8009af:	50                   	push   %eax
  8009b0:	ff 75 f4             	pushl  -0xc(%ebp)
  8009b3:	ff 75 f0             	pushl  -0x10(%ebp)
  8009b6:	e8 05 13 00 00       	call   801cc0 <__udivdi3>
  8009bb:	83 c4 10             	add    $0x10,%esp
  8009be:	83 ec 04             	sub    $0x4,%esp
  8009c1:	ff 75 20             	pushl  0x20(%ebp)
  8009c4:	53                   	push   %ebx
  8009c5:	ff 75 18             	pushl  0x18(%ebp)
  8009c8:	52                   	push   %edx
  8009c9:	50                   	push   %eax
  8009ca:	ff 75 0c             	pushl  0xc(%ebp)
  8009cd:	ff 75 08             	pushl  0x8(%ebp)
  8009d0:	e8 a1 ff ff ff       	call   800976 <printnum>
  8009d5:	83 c4 20             	add    $0x20,%esp
  8009d8:	eb 1a                	jmp    8009f4 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8009da:	83 ec 08             	sub    $0x8,%esp
  8009dd:	ff 75 0c             	pushl  0xc(%ebp)
  8009e0:	ff 75 20             	pushl  0x20(%ebp)
  8009e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e6:	ff d0                	call   *%eax
  8009e8:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8009eb:	ff 4d 1c             	decl   0x1c(%ebp)
  8009ee:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8009f2:	7f e6                	jg     8009da <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8009f4:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8009f7:	bb 00 00 00 00       	mov    $0x0,%ebx
  8009fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a02:	53                   	push   %ebx
  800a03:	51                   	push   %ecx
  800a04:	52                   	push   %edx
  800a05:	50                   	push   %eax
  800a06:	e8 c5 13 00 00       	call   801dd0 <__umoddi3>
  800a0b:	83 c4 10             	add    $0x10,%esp
  800a0e:	05 74 25 80 00       	add    $0x802574,%eax
  800a13:	8a 00                	mov    (%eax),%al
  800a15:	0f be c0             	movsbl %al,%eax
  800a18:	83 ec 08             	sub    $0x8,%esp
  800a1b:	ff 75 0c             	pushl  0xc(%ebp)
  800a1e:	50                   	push   %eax
  800a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a22:	ff d0                	call   *%eax
  800a24:	83 c4 10             	add    $0x10,%esp
}
  800a27:	90                   	nop
  800a28:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a2b:	c9                   	leave  
  800a2c:	c3                   	ret    

00800a2d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a2d:	55                   	push   %ebp
  800a2e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a30:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a34:	7e 1c                	jle    800a52 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a36:	8b 45 08             	mov    0x8(%ebp),%eax
  800a39:	8b 00                	mov    (%eax),%eax
  800a3b:	8d 50 08             	lea    0x8(%eax),%edx
  800a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a41:	89 10                	mov    %edx,(%eax)
  800a43:	8b 45 08             	mov    0x8(%ebp),%eax
  800a46:	8b 00                	mov    (%eax),%eax
  800a48:	83 e8 08             	sub    $0x8,%eax
  800a4b:	8b 50 04             	mov    0x4(%eax),%edx
  800a4e:	8b 00                	mov    (%eax),%eax
  800a50:	eb 40                	jmp    800a92 <getuint+0x65>
	else if (lflag)
  800a52:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a56:	74 1e                	je     800a76 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800a58:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5b:	8b 00                	mov    (%eax),%eax
  800a5d:	8d 50 04             	lea    0x4(%eax),%edx
  800a60:	8b 45 08             	mov    0x8(%ebp),%eax
  800a63:	89 10                	mov    %edx,(%eax)
  800a65:	8b 45 08             	mov    0x8(%ebp),%eax
  800a68:	8b 00                	mov    (%eax),%eax
  800a6a:	83 e8 04             	sub    $0x4,%eax
  800a6d:	8b 00                	mov    (%eax),%eax
  800a6f:	ba 00 00 00 00       	mov    $0x0,%edx
  800a74:	eb 1c                	jmp    800a92 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800a76:	8b 45 08             	mov    0x8(%ebp),%eax
  800a79:	8b 00                	mov    (%eax),%eax
  800a7b:	8d 50 04             	lea    0x4(%eax),%edx
  800a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a81:	89 10                	mov    %edx,(%eax)
  800a83:	8b 45 08             	mov    0x8(%ebp),%eax
  800a86:	8b 00                	mov    (%eax),%eax
  800a88:	83 e8 04             	sub    $0x4,%eax
  800a8b:	8b 00                	mov    (%eax),%eax
  800a8d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800a92:	5d                   	pop    %ebp
  800a93:	c3                   	ret    

00800a94 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800a94:	55                   	push   %ebp
  800a95:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a97:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a9b:	7e 1c                	jle    800ab9 <getint+0x25>
		return va_arg(*ap, long long);
  800a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa0:	8b 00                	mov    (%eax),%eax
  800aa2:	8d 50 08             	lea    0x8(%eax),%edx
  800aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa8:	89 10                	mov    %edx,(%eax)
  800aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800aad:	8b 00                	mov    (%eax),%eax
  800aaf:	83 e8 08             	sub    $0x8,%eax
  800ab2:	8b 50 04             	mov    0x4(%eax),%edx
  800ab5:	8b 00                	mov    (%eax),%eax
  800ab7:	eb 38                	jmp    800af1 <getint+0x5d>
	else if (lflag)
  800ab9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800abd:	74 1a                	je     800ad9 <getint+0x45>
		return va_arg(*ap, long);
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	8b 00                	mov    (%eax),%eax
  800ac4:	8d 50 04             	lea    0x4(%eax),%edx
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	89 10                	mov    %edx,(%eax)
  800acc:	8b 45 08             	mov    0x8(%ebp),%eax
  800acf:	8b 00                	mov    (%eax),%eax
  800ad1:	83 e8 04             	sub    $0x4,%eax
  800ad4:	8b 00                	mov    (%eax),%eax
  800ad6:	99                   	cltd   
  800ad7:	eb 18                	jmp    800af1 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  800adc:	8b 00                	mov    (%eax),%eax
  800ade:	8d 50 04             	lea    0x4(%eax),%edx
  800ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae4:	89 10                	mov    %edx,(%eax)
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	8b 00                	mov    (%eax),%eax
  800aeb:	83 e8 04             	sub    $0x4,%eax
  800aee:	8b 00                	mov    (%eax),%eax
  800af0:	99                   	cltd   
}
  800af1:	5d                   	pop    %ebp
  800af2:	c3                   	ret    

00800af3 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800af3:	55                   	push   %ebp
  800af4:	89 e5                	mov    %esp,%ebp
  800af6:	56                   	push   %esi
  800af7:	53                   	push   %ebx
  800af8:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800afb:	eb 17                	jmp    800b14 <vprintfmt+0x21>
			if (ch == '\0')
  800afd:	85 db                	test   %ebx,%ebx
  800aff:	0f 84 af 03 00 00    	je     800eb4 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b05:	83 ec 08             	sub    $0x8,%esp
  800b08:	ff 75 0c             	pushl  0xc(%ebp)
  800b0b:	53                   	push   %ebx
  800b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0f:	ff d0                	call   *%eax
  800b11:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b14:	8b 45 10             	mov    0x10(%ebp),%eax
  800b17:	8d 50 01             	lea    0x1(%eax),%edx
  800b1a:	89 55 10             	mov    %edx,0x10(%ebp)
  800b1d:	8a 00                	mov    (%eax),%al
  800b1f:	0f b6 d8             	movzbl %al,%ebx
  800b22:	83 fb 25             	cmp    $0x25,%ebx
  800b25:	75 d6                	jne    800afd <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b27:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b2b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b32:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b39:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b40:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800b47:	8b 45 10             	mov    0x10(%ebp),%eax
  800b4a:	8d 50 01             	lea    0x1(%eax),%edx
  800b4d:	89 55 10             	mov    %edx,0x10(%ebp)
  800b50:	8a 00                	mov    (%eax),%al
  800b52:	0f b6 d8             	movzbl %al,%ebx
  800b55:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800b58:	83 f8 55             	cmp    $0x55,%eax
  800b5b:	0f 87 2b 03 00 00    	ja     800e8c <vprintfmt+0x399>
  800b61:	8b 04 85 98 25 80 00 	mov    0x802598(,%eax,4),%eax
  800b68:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800b6a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800b6e:	eb d7                	jmp    800b47 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800b70:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800b74:	eb d1                	jmp    800b47 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800b76:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800b7d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b80:	89 d0                	mov    %edx,%eax
  800b82:	c1 e0 02             	shl    $0x2,%eax
  800b85:	01 d0                	add    %edx,%eax
  800b87:	01 c0                	add    %eax,%eax
  800b89:	01 d8                	add    %ebx,%eax
  800b8b:	83 e8 30             	sub    $0x30,%eax
  800b8e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800b91:	8b 45 10             	mov    0x10(%ebp),%eax
  800b94:	8a 00                	mov    (%eax),%al
  800b96:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800b99:	83 fb 2f             	cmp    $0x2f,%ebx
  800b9c:	7e 3e                	jle    800bdc <vprintfmt+0xe9>
  800b9e:	83 fb 39             	cmp    $0x39,%ebx
  800ba1:	7f 39                	jg     800bdc <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ba3:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ba6:	eb d5                	jmp    800b7d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ba8:	8b 45 14             	mov    0x14(%ebp),%eax
  800bab:	83 c0 04             	add    $0x4,%eax
  800bae:	89 45 14             	mov    %eax,0x14(%ebp)
  800bb1:	8b 45 14             	mov    0x14(%ebp),%eax
  800bb4:	83 e8 04             	sub    $0x4,%eax
  800bb7:	8b 00                	mov    (%eax),%eax
  800bb9:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800bbc:	eb 1f                	jmp    800bdd <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800bbe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bc2:	79 83                	jns    800b47 <vprintfmt+0x54>
				width = 0;
  800bc4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800bcb:	e9 77 ff ff ff       	jmp    800b47 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800bd0:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800bd7:	e9 6b ff ff ff       	jmp    800b47 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800bdc:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800bdd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800be1:	0f 89 60 ff ff ff    	jns    800b47 <vprintfmt+0x54>
				width = precision, precision = -1;
  800be7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800bed:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800bf4:	e9 4e ff ff ff       	jmp    800b47 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800bf9:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800bfc:	e9 46 ff ff ff       	jmp    800b47 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c01:	8b 45 14             	mov    0x14(%ebp),%eax
  800c04:	83 c0 04             	add    $0x4,%eax
  800c07:	89 45 14             	mov    %eax,0x14(%ebp)
  800c0a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c0d:	83 e8 04             	sub    $0x4,%eax
  800c10:	8b 00                	mov    (%eax),%eax
  800c12:	83 ec 08             	sub    $0x8,%esp
  800c15:	ff 75 0c             	pushl  0xc(%ebp)
  800c18:	50                   	push   %eax
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1c:	ff d0                	call   *%eax
  800c1e:	83 c4 10             	add    $0x10,%esp
			break;
  800c21:	e9 89 02 00 00       	jmp    800eaf <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c26:	8b 45 14             	mov    0x14(%ebp),%eax
  800c29:	83 c0 04             	add    $0x4,%eax
  800c2c:	89 45 14             	mov    %eax,0x14(%ebp)
  800c2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c32:	83 e8 04             	sub    $0x4,%eax
  800c35:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c37:	85 db                	test   %ebx,%ebx
  800c39:	79 02                	jns    800c3d <vprintfmt+0x14a>
				err = -err;
  800c3b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c3d:	83 fb 64             	cmp    $0x64,%ebx
  800c40:	7f 0b                	jg     800c4d <vprintfmt+0x15a>
  800c42:	8b 34 9d e0 23 80 00 	mov    0x8023e0(,%ebx,4),%esi
  800c49:	85 f6                	test   %esi,%esi
  800c4b:	75 19                	jne    800c66 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800c4d:	53                   	push   %ebx
  800c4e:	68 85 25 80 00       	push   $0x802585
  800c53:	ff 75 0c             	pushl  0xc(%ebp)
  800c56:	ff 75 08             	pushl  0x8(%ebp)
  800c59:	e8 5e 02 00 00       	call   800ebc <printfmt>
  800c5e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800c61:	e9 49 02 00 00       	jmp    800eaf <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800c66:	56                   	push   %esi
  800c67:	68 8e 25 80 00       	push   $0x80258e
  800c6c:	ff 75 0c             	pushl  0xc(%ebp)
  800c6f:	ff 75 08             	pushl  0x8(%ebp)
  800c72:	e8 45 02 00 00       	call   800ebc <printfmt>
  800c77:	83 c4 10             	add    $0x10,%esp
			break;
  800c7a:	e9 30 02 00 00       	jmp    800eaf <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800c7f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c82:	83 c0 04             	add    $0x4,%eax
  800c85:	89 45 14             	mov    %eax,0x14(%ebp)
  800c88:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8b:	83 e8 04             	sub    $0x4,%eax
  800c8e:	8b 30                	mov    (%eax),%esi
  800c90:	85 f6                	test   %esi,%esi
  800c92:	75 05                	jne    800c99 <vprintfmt+0x1a6>
				p = "(null)";
  800c94:	be 91 25 80 00       	mov    $0x802591,%esi
			if (width > 0 && padc != '-')
  800c99:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c9d:	7e 6d                	jle    800d0c <vprintfmt+0x219>
  800c9f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ca3:	74 67                	je     800d0c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800ca5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ca8:	83 ec 08             	sub    $0x8,%esp
  800cab:	50                   	push   %eax
  800cac:	56                   	push   %esi
  800cad:	e8 0c 03 00 00       	call   800fbe <strnlen>
  800cb2:	83 c4 10             	add    $0x10,%esp
  800cb5:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800cb8:	eb 16                	jmp    800cd0 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800cba:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800cbe:	83 ec 08             	sub    $0x8,%esp
  800cc1:	ff 75 0c             	pushl  0xc(%ebp)
  800cc4:	50                   	push   %eax
  800cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc8:	ff d0                	call   *%eax
  800cca:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ccd:	ff 4d e4             	decl   -0x1c(%ebp)
  800cd0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cd4:	7f e4                	jg     800cba <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800cd6:	eb 34                	jmp    800d0c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800cd8:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800cdc:	74 1c                	je     800cfa <vprintfmt+0x207>
  800cde:	83 fb 1f             	cmp    $0x1f,%ebx
  800ce1:	7e 05                	jle    800ce8 <vprintfmt+0x1f5>
  800ce3:	83 fb 7e             	cmp    $0x7e,%ebx
  800ce6:	7e 12                	jle    800cfa <vprintfmt+0x207>
					putch('?', putdat);
  800ce8:	83 ec 08             	sub    $0x8,%esp
  800ceb:	ff 75 0c             	pushl  0xc(%ebp)
  800cee:	6a 3f                	push   $0x3f
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	ff d0                	call   *%eax
  800cf5:	83 c4 10             	add    $0x10,%esp
  800cf8:	eb 0f                	jmp    800d09 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800cfa:	83 ec 08             	sub    $0x8,%esp
  800cfd:	ff 75 0c             	pushl  0xc(%ebp)
  800d00:	53                   	push   %ebx
  800d01:	8b 45 08             	mov    0x8(%ebp),%eax
  800d04:	ff d0                	call   *%eax
  800d06:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d09:	ff 4d e4             	decl   -0x1c(%ebp)
  800d0c:	89 f0                	mov    %esi,%eax
  800d0e:	8d 70 01             	lea    0x1(%eax),%esi
  800d11:	8a 00                	mov    (%eax),%al
  800d13:	0f be d8             	movsbl %al,%ebx
  800d16:	85 db                	test   %ebx,%ebx
  800d18:	74 24                	je     800d3e <vprintfmt+0x24b>
  800d1a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d1e:	78 b8                	js     800cd8 <vprintfmt+0x1e5>
  800d20:	ff 4d e0             	decl   -0x20(%ebp)
  800d23:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d27:	79 af                	jns    800cd8 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d29:	eb 13                	jmp    800d3e <vprintfmt+0x24b>
				putch(' ', putdat);
  800d2b:	83 ec 08             	sub    $0x8,%esp
  800d2e:	ff 75 0c             	pushl  0xc(%ebp)
  800d31:	6a 20                	push   $0x20
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	ff d0                	call   *%eax
  800d38:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d3b:	ff 4d e4             	decl   -0x1c(%ebp)
  800d3e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d42:	7f e7                	jg     800d2b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d44:	e9 66 01 00 00       	jmp    800eaf <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800d49:	83 ec 08             	sub    $0x8,%esp
  800d4c:	ff 75 e8             	pushl  -0x18(%ebp)
  800d4f:	8d 45 14             	lea    0x14(%ebp),%eax
  800d52:	50                   	push   %eax
  800d53:	e8 3c fd ff ff       	call   800a94 <getint>
  800d58:	83 c4 10             	add    $0x10,%esp
  800d5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d5e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800d61:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d64:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d67:	85 d2                	test   %edx,%edx
  800d69:	79 23                	jns    800d8e <vprintfmt+0x29b>
				putch('-', putdat);
  800d6b:	83 ec 08             	sub    $0x8,%esp
  800d6e:	ff 75 0c             	pushl  0xc(%ebp)
  800d71:	6a 2d                	push   $0x2d
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
  800d76:	ff d0                	call   *%eax
  800d78:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800d7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d81:	f7 d8                	neg    %eax
  800d83:	83 d2 00             	adc    $0x0,%edx
  800d86:	f7 da                	neg    %edx
  800d88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d8b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800d8e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800d95:	e9 bc 00 00 00       	jmp    800e56 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800d9a:	83 ec 08             	sub    $0x8,%esp
  800d9d:	ff 75 e8             	pushl  -0x18(%ebp)
  800da0:	8d 45 14             	lea    0x14(%ebp),%eax
  800da3:	50                   	push   %eax
  800da4:	e8 84 fc ff ff       	call   800a2d <getuint>
  800da9:	83 c4 10             	add    $0x10,%esp
  800dac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800daf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800db2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800db9:	e9 98 00 00 00       	jmp    800e56 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800dbe:	83 ec 08             	sub    $0x8,%esp
  800dc1:	ff 75 0c             	pushl  0xc(%ebp)
  800dc4:	6a 58                	push   $0x58
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc9:	ff d0                	call   *%eax
  800dcb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800dce:	83 ec 08             	sub    $0x8,%esp
  800dd1:	ff 75 0c             	pushl  0xc(%ebp)
  800dd4:	6a 58                	push   $0x58
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	ff d0                	call   *%eax
  800ddb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800dde:	83 ec 08             	sub    $0x8,%esp
  800de1:	ff 75 0c             	pushl  0xc(%ebp)
  800de4:	6a 58                	push   $0x58
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	ff d0                	call   *%eax
  800deb:	83 c4 10             	add    $0x10,%esp
			break;
  800dee:	e9 bc 00 00 00       	jmp    800eaf <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800df3:	83 ec 08             	sub    $0x8,%esp
  800df6:	ff 75 0c             	pushl  0xc(%ebp)
  800df9:	6a 30                	push   $0x30
  800dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfe:	ff d0                	call   *%eax
  800e00:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e03:	83 ec 08             	sub    $0x8,%esp
  800e06:	ff 75 0c             	pushl  0xc(%ebp)
  800e09:	6a 78                	push   $0x78
  800e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0e:	ff d0                	call   *%eax
  800e10:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e13:	8b 45 14             	mov    0x14(%ebp),%eax
  800e16:	83 c0 04             	add    $0x4,%eax
  800e19:	89 45 14             	mov    %eax,0x14(%ebp)
  800e1c:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1f:	83 e8 04             	sub    $0x4,%eax
  800e22:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e24:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e2e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e35:	eb 1f                	jmp    800e56 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e37:	83 ec 08             	sub    $0x8,%esp
  800e3a:	ff 75 e8             	pushl  -0x18(%ebp)
  800e3d:	8d 45 14             	lea    0x14(%ebp),%eax
  800e40:	50                   	push   %eax
  800e41:	e8 e7 fb ff ff       	call   800a2d <getuint>
  800e46:	83 c4 10             	add    $0x10,%esp
  800e49:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e4c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800e4f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800e56:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800e5a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e5d:	83 ec 04             	sub    $0x4,%esp
  800e60:	52                   	push   %edx
  800e61:	ff 75 e4             	pushl  -0x1c(%ebp)
  800e64:	50                   	push   %eax
  800e65:	ff 75 f4             	pushl  -0xc(%ebp)
  800e68:	ff 75 f0             	pushl  -0x10(%ebp)
  800e6b:	ff 75 0c             	pushl  0xc(%ebp)
  800e6e:	ff 75 08             	pushl  0x8(%ebp)
  800e71:	e8 00 fb ff ff       	call   800976 <printnum>
  800e76:	83 c4 20             	add    $0x20,%esp
			break;
  800e79:	eb 34                	jmp    800eaf <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800e7b:	83 ec 08             	sub    $0x8,%esp
  800e7e:	ff 75 0c             	pushl  0xc(%ebp)
  800e81:	53                   	push   %ebx
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	ff d0                	call   *%eax
  800e87:	83 c4 10             	add    $0x10,%esp
			break;
  800e8a:	eb 23                	jmp    800eaf <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800e8c:	83 ec 08             	sub    $0x8,%esp
  800e8f:	ff 75 0c             	pushl  0xc(%ebp)
  800e92:	6a 25                	push   $0x25
  800e94:	8b 45 08             	mov    0x8(%ebp),%eax
  800e97:	ff d0                	call   *%eax
  800e99:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800e9c:	ff 4d 10             	decl   0x10(%ebp)
  800e9f:	eb 03                	jmp    800ea4 <vprintfmt+0x3b1>
  800ea1:	ff 4d 10             	decl   0x10(%ebp)
  800ea4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea7:	48                   	dec    %eax
  800ea8:	8a 00                	mov    (%eax),%al
  800eaa:	3c 25                	cmp    $0x25,%al
  800eac:	75 f3                	jne    800ea1 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800eae:	90                   	nop
		}
	}
  800eaf:	e9 47 fc ff ff       	jmp    800afb <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800eb4:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800eb5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800eb8:	5b                   	pop    %ebx
  800eb9:	5e                   	pop    %esi
  800eba:	5d                   	pop    %ebp
  800ebb:	c3                   	ret    

00800ebc <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ebc:	55                   	push   %ebp
  800ebd:	89 e5                	mov    %esp,%ebp
  800ebf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ec2:	8d 45 10             	lea    0x10(%ebp),%eax
  800ec5:	83 c0 04             	add    $0x4,%eax
  800ec8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ecb:	8b 45 10             	mov    0x10(%ebp),%eax
  800ece:	ff 75 f4             	pushl  -0xc(%ebp)
  800ed1:	50                   	push   %eax
  800ed2:	ff 75 0c             	pushl  0xc(%ebp)
  800ed5:	ff 75 08             	pushl  0x8(%ebp)
  800ed8:	e8 16 fc ff ff       	call   800af3 <vprintfmt>
  800edd:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ee0:	90                   	nop
  800ee1:	c9                   	leave  
  800ee2:	c3                   	ret    

00800ee3 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ee3:	55                   	push   %ebp
  800ee4:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ee6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee9:	8b 40 08             	mov    0x8(%eax),%eax
  800eec:	8d 50 01             	lea    0x1(%eax),%edx
  800eef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef2:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ef5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef8:	8b 10                	mov    (%eax),%edx
  800efa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efd:	8b 40 04             	mov    0x4(%eax),%eax
  800f00:	39 c2                	cmp    %eax,%edx
  800f02:	73 12                	jae    800f16 <sprintputch+0x33>
		*b->buf++ = ch;
  800f04:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f07:	8b 00                	mov    (%eax),%eax
  800f09:	8d 48 01             	lea    0x1(%eax),%ecx
  800f0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f0f:	89 0a                	mov    %ecx,(%edx)
  800f11:	8b 55 08             	mov    0x8(%ebp),%edx
  800f14:	88 10                	mov    %dl,(%eax)
}
  800f16:	90                   	nop
  800f17:	5d                   	pop    %ebp
  800f18:	c3                   	ret    

00800f19 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f19:	55                   	push   %ebp
  800f1a:	89 e5                	mov    %esp,%ebp
  800f1c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f22:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f28:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	01 d0                	add    %edx,%eax
  800f30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f33:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f3a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f3e:	74 06                	je     800f46 <vsnprintf+0x2d>
  800f40:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f44:	7f 07                	jg     800f4d <vsnprintf+0x34>
		return -E_INVAL;
  800f46:	b8 03 00 00 00       	mov    $0x3,%eax
  800f4b:	eb 20                	jmp    800f6d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800f4d:	ff 75 14             	pushl  0x14(%ebp)
  800f50:	ff 75 10             	pushl  0x10(%ebp)
  800f53:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800f56:	50                   	push   %eax
  800f57:	68 e3 0e 80 00       	push   $0x800ee3
  800f5c:	e8 92 fb ff ff       	call   800af3 <vprintfmt>
  800f61:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800f64:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f67:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800f6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800f6d:	c9                   	leave  
  800f6e:	c3                   	ret    

00800f6f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800f6f:	55                   	push   %ebp
  800f70:	89 e5                	mov    %esp,%ebp
  800f72:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800f75:	8d 45 10             	lea    0x10(%ebp),%eax
  800f78:	83 c0 04             	add    $0x4,%eax
  800f7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800f7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f81:	ff 75 f4             	pushl  -0xc(%ebp)
  800f84:	50                   	push   %eax
  800f85:	ff 75 0c             	pushl  0xc(%ebp)
  800f88:	ff 75 08             	pushl  0x8(%ebp)
  800f8b:	e8 89 ff ff ff       	call   800f19 <vsnprintf>
  800f90:	83 c4 10             	add    $0x10,%esp
  800f93:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800f96:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f99:	c9                   	leave  
  800f9a:	c3                   	ret    

00800f9b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800f9b:	55                   	push   %ebp
  800f9c:	89 e5                	mov    %esp,%ebp
  800f9e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800fa1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fa8:	eb 06                	jmp    800fb0 <strlen+0x15>
		n++;
  800faa:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800fad:	ff 45 08             	incl   0x8(%ebp)
  800fb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb3:	8a 00                	mov    (%eax),%al
  800fb5:	84 c0                	test   %al,%al
  800fb7:	75 f1                	jne    800faa <strlen+0xf>
		n++;
	return n;
  800fb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800fbc:	c9                   	leave  
  800fbd:	c3                   	ret    

00800fbe <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800fbe:	55                   	push   %ebp
  800fbf:	89 e5                	mov    %esp,%ebp
  800fc1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800fc4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fcb:	eb 09                	jmp    800fd6 <strnlen+0x18>
		n++;
  800fcd:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800fd0:	ff 45 08             	incl   0x8(%ebp)
  800fd3:	ff 4d 0c             	decl   0xc(%ebp)
  800fd6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fda:	74 09                	je     800fe5 <strnlen+0x27>
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	8a 00                	mov    (%eax),%al
  800fe1:	84 c0                	test   %al,%al
  800fe3:	75 e8                	jne    800fcd <strnlen+0xf>
		n++;
	return n;
  800fe5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800fe8:	c9                   	leave  
  800fe9:	c3                   	ret    

00800fea <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800fea:	55                   	push   %ebp
  800feb:	89 e5                	mov    %esp,%ebp
  800fed:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ff0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ff6:	90                   	nop
  800ff7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffa:	8d 50 01             	lea    0x1(%eax),%edx
  800ffd:	89 55 08             	mov    %edx,0x8(%ebp)
  801000:	8b 55 0c             	mov    0xc(%ebp),%edx
  801003:	8d 4a 01             	lea    0x1(%edx),%ecx
  801006:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801009:	8a 12                	mov    (%edx),%dl
  80100b:	88 10                	mov    %dl,(%eax)
  80100d:	8a 00                	mov    (%eax),%al
  80100f:	84 c0                	test   %al,%al
  801011:	75 e4                	jne    800ff7 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801013:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801016:	c9                   	leave  
  801017:	c3                   	ret    

00801018 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801018:	55                   	push   %ebp
  801019:	89 e5                	mov    %esp,%ebp
  80101b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80101e:	8b 45 08             	mov    0x8(%ebp),%eax
  801021:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801024:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80102b:	eb 1f                	jmp    80104c <strncpy+0x34>
		*dst++ = *src;
  80102d:	8b 45 08             	mov    0x8(%ebp),%eax
  801030:	8d 50 01             	lea    0x1(%eax),%edx
  801033:	89 55 08             	mov    %edx,0x8(%ebp)
  801036:	8b 55 0c             	mov    0xc(%ebp),%edx
  801039:	8a 12                	mov    (%edx),%dl
  80103b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80103d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801040:	8a 00                	mov    (%eax),%al
  801042:	84 c0                	test   %al,%al
  801044:	74 03                	je     801049 <strncpy+0x31>
			src++;
  801046:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801049:	ff 45 fc             	incl   -0x4(%ebp)
  80104c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80104f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801052:	72 d9                	jb     80102d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801054:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801057:	c9                   	leave  
  801058:	c3                   	ret    

00801059 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801059:	55                   	push   %ebp
  80105a:	89 e5                	mov    %esp,%ebp
  80105c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80105f:	8b 45 08             	mov    0x8(%ebp),%eax
  801062:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801065:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801069:	74 30                	je     80109b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80106b:	eb 16                	jmp    801083 <strlcpy+0x2a>
			*dst++ = *src++;
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	8d 50 01             	lea    0x1(%eax),%edx
  801073:	89 55 08             	mov    %edx,0x8(%ebp)
  801076:	8b 55 0c             	mov    0xc(%ebp),%edx
  801079:	8d 4a 01             	lea    0x1(%edx),%ecx
  80107c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80107f:	8a 12                	mov    (%edx),%dl
  801081:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801083:	ff 4d 10             	decl   0x10(%ebp)
  801086:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80108a:	74 09                	je     801095 <strlcpy+0x3c>
  80108c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108f:	8a 00                	mov    (%eax),%al
  801091:	84 c0                	test   %al,%al
  801093:	75 d8                	jne    80106d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801095:	8b 45 08             	mov    0x8(%ebp),%eax
  801098:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80109b:	8b 55 08             	mov    0x8(%ebp),%edx
  80109e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010a1:	29 c2                	sub    %eax,%edx
  8010a3:	89 d0                	mov    %edx,%eax
}
  8010a5:	c9                   	leave  
  8010a6:	c3                   	ret    

008010a7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8010a7:	55                   	push   %ebp
  8010a8:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8010aa:	eb 06                	jmp    8010b2 <strcmp+0xb>
		p++, q++;
  8010ac:	ff 45 08             	incl   0x8(%ebp)
  8010af:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8010b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b5:	8a 00                	mov    (%eax),%al
  8010b7:	84 c0                	test   %al,%al
  8010b9:	74 0e                	je     8010c9 <strcmp+0x22>
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	8a 10                	mov    (%eax),%dl
  8010c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c3:	8a 00                	mov    (%eax),%al
  8010c5:	38 c2                	cmp    %al,%dl
  8010c7:	74 e3                	je     8010ac <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8010c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cc:	8a 00                	mov    (%eax),%al
  8010ce:	0f b6 d0             	movzbl %al,%edx
  8010d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d4:	8a 00                	mov    (%eax),%al
  8010d6:	0f b6 c0             	movzbl %al,%eax
  8010d9:	29 c2                	sub    %eax,%edx
  8010db:	89 d0                	mov    %edx,%eax
}
  8010dd:	5d                   	pop    %ebp
  8010de:	c3                   	ret    

008010df <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8010df:	55                   	push   %ebp
  8010e0:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8010e2:	eb 09                	jmp    8010ed <strncmp+0xe>
		n--, p++, q++;
  8010e4:	ff 4d 10             	decl   0x10(%ebp)
  8010e7:	ff 45 08             	incl   0x8(%ebp)
  8010ea:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8010ed:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010f1:	74 17                	je     80110a <strncmp+0x2b>
  8010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f6:	8a 00                	mov    (%eax),%al
  8010f8:	84 c0                	test   %al,%al
  8010fa:	74 0e                	je     80110a <strncmp+0x2b>
  8010fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ff:	8a 10                	mov    (%eax),%dl
  801101:	8b 45 0c             	mov    0xc(%ebp),%eax
  801104:	8a 00                	mov    (%eax),%al
  801106:	38 c2                	cmp    %al,%dl
  801108:	74 da                	je     8010e4 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80110a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80110e:	75 07                	jne    801117 <strncmp+0x38>
		return 0;
  801110:	b8 00 00 00 00       	mov    $0x0,%eax
  801115:	eb 14                	jmp    80112b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	8a 00                	mov    (%eax),%al
  80111c:	0f b6 d0             	movzbl %al,%edx
  80111f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801122:	8a 00                	mov    (%eax),%al
  801124:	0f b6 c0             	movzbl %al,%eax
  801127:	29 c2                	sub    %eax,%edx
  801129:	89 d0                	mov    %edx,%eax
}
  80112b:	5d                   	pop    %ebp
  80112c:	c3                   	ret    

0080112d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80112d:	55                   	push   %ebp
  80112e:	89 e5                	mov    %esp,%ebp
  801130:	83 ec 04             	sub    $0x4,%esp
  801133:	8b 45 0c             	mov    0xc(%ebp),%eax
  801136:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801139:	eb 12                	jmp    80114d <strchr+0x20>
		if (*s == c)
  80113b:	8b 45 08             	mov    0x8(%ebp),%eax
  80113e:	8a 00                	mov    (%eax),%al
  801140:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801143:	75 05                	jne    80114a <strchr+0x1d>
			return (char *) s;
  801145:	8b 45 08             	mov    0x8(%ebp),%eax
  801148:	eb 11                	jmp    80115b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80114a:	ff 45 08             	incl   0x8(%ebp)
  80114d:	8b 45 08             	mov    0x8(%ebp),%eax
  801150:	8a 00                	mov    (%eax),%al
  801152:	84 c0                	test   %al,%al
  801154:	75 e5                	jne    80113b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801156:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80115b:	c9                   	leave  
  80115c:	c3                   	ret    

0080115d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80115d:	55                   	push   %ebp
  80115e:	89 e5                	mov    %esp,%ebp
  801160:	83 ec 04             	sub    $0x4,%esp
  801163:	8b 45 0c             	mov    0xc(%ebp),%eax
  801166:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801169:	eb 0d                	jmp    801178 <strfind+0x1b>
		if (*s == c)
  80116b:	8b 45 08             	mov    0x8(%ebp),%eax
  80116e:	8a 00                	mov    (%eax),%al
  801170:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801173:	74 0e                	je     801183 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801175:	ff 45 08             	incl   0x8(%ebp)
  801178:	8b 45 08             	mov    0x8(%ebp),%eax
  80117b:	8a 00                	mov    (%eax),%al
  80117d:	84 c0                	test   %al,%al
  80117f:	75 ea                	jne    80116b <strfind+0xe>
  801181:	eb 01                	jmp    801184 <strfind+0x27>
		if (*s == c)
			break;
  801183:	90                   	nop
	return (char *) s;
  801184:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801187:	c9                   	leave  
  801188:	c3                   	ret    

00801189 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801189:	55                   	push   %ebp
  80118a:	89 e5                	mov    %esp,%ebp
  80118c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80118f:	8b 45 08             	mov    0x8(%ebp),%eax
  801192:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801195:	8b 45 10             	mov    0x10(%ebp),%eax
  801198:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80119b:	eb 0e                	jmp    8011ab <memset+0x22>
		*p++ = c;
  80119d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011a0:	8d 50 01             	lea    0x1(%eax),%edx
  8011a3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011a9:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8011ab:	ff 4d f8             	decl   -0x8(%ebp)
  8011ae:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8011b2:	79 e9                	jns    80119d <memset+0x14>
		*p++ = c;

	return v;
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011b7:	c9                   	leave  
  8011b8:	c3                   	ret    

008011b9 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8011b9:	55                   	push   %ebp
  8011ba:	89 e5                	mov    %esp,%ebp
  8011bc:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8011cb:	eb 16                	jmp    8011e3 <memcpy+0x2a>
		*d++ = *s++;
  8011cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011d0:	8d 50 01             	lea    0x1(%eax),%edx
  8011d3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011d6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011d9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011dc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8011df:	8a 12                	mov    (%edx),%dl
  8011e1:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8011e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011e9:	89 55 10             	mov    %edx,0x10(%ebp)
  8011ec:	85 c0                	test   %eax,%eax
  8011ee:	75 dd                	jne    8011cd <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8011f0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011f3:	c9                   	leave  
  8011f4:	c3                   	ret    

008011f5 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8011f5:	55                   	push   %ebp
  8011f6:	89 e5                	mov    %esp,%ebp
  8011f8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8011fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801201:	8b 45 08             	mov    0x8(%ebp),%eax
  801204:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801207:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80120a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80120d:	73 50                	jae    80125f <memmove+0x6a>
  80120f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801212:	8b 45 10             	mov    0x10(%ebp),%eax
  801215:	01 d0                	add    %edx,%eax
  801217:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80121a:	76 43                	jbe    80125f <memmove+0x6a>
		s += n;
  80121c:	8b 45 10             	mov    0x10(%ebp),%eax
  80121f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801222:	8b 45 10             	mov    0x10(%ebp),%eax
  801225:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801228:	eb 10                	jmp    80123a <memmove+0x45>
			*--d = *--s;
  80122a:	ff 4d f8             	decl   -0x8(%ebp)
  80122d:	ff 4d fc             	decl   -0x4(%ebp)
  801230:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801233:	8a 10                	mov    (%eax),%dl
  801235:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801238:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80123a:	8b 45 10             	mov    0x10(%ebp),%eax
  80123d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801240:	89 55 10             	mov    %edx,0x10(%ebp)
  801243:	85 c0                	test   %eax,%eax
  801245:	75 e3                	jne    80122a <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801247:	eb 23                	jmp    80126c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801249:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80124c:	8d 50 01             	lea    0x1(%eax),%edx
  80124f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801252:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801255:	8d 4a 01             	lea    0x1(%edx),%ecx
  801258:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80125b:	8a 12                	mov    (%edx),%dl
  80125d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80125f:	8b 45 10             	mov    0x10(%ebp),%eax
  801262:	8d 50 ff             	lea    -0x1(%eax),%edx
  801265:	89 55 10             	mov    %edx,0x10(%ebp)
  801268:	85 c0                	test   %eax,%eax
  80126a:	75 dd                	jne    801249 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80126c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80126f:	c9                   	leave  
  801270:	c3                   	ret    

00801271 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801271:	55                   	push   %ebp
  801272:	89 e5                	mov    %esp,%ebp
  801274:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801277:	8b 45 08             	mov    0x8(%ebp),%eax
  80127a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80127d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801280:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801283:	eb 2a                	jmp    8012af <memcmp+0x3e>
		if (*s1 != *s2)
  801285:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801288:	8a 10                	mov    (%eax),%dl
  80128a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80128d:	8a 00                	mov    (%eax),%al
  80128f:	38 c2                	cmp    %al,%dl
  801291:	74 16                	je     8012a9 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801293:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801296:	8a 00                	mov    (%eax),%al
  801298:	0f b6 d0             	movzbl %al,%edx
  80129b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80129e:	8a 00                	mov    (%eax),%al
  8012a0:	0f b6 c0             	movzbl %al,%eax
  8012a3:	29 c2                	sub    %eax,%edx
  8012a5:	89 d0                	mov    %edx,%eax
  8012a7:	eb 18                	jmp    8012c1 <memcmp+0x50>
		s1++, s2++;
  8012a9:	ff 45 fc             	incl   -0x4(%ebp)
  8012ac:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8012af:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012b5:	89 55 10             	mov    %edx,0x10(%ebp)
  8012b8:	85 c0                	test   %eax,%eax
  8012ba:	75 c9                	jne    801285 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8012bc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012c1:	c9                   	leave  
  8012c2:	c3                   	ret    

008012c3 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8012c3:	55                   	push   %ebp
  8012c4:	89 e5                	mov    %esp,%ebp
  8012c6:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8012c9:	8b 55 08             	mov    0x8(%ebp),%edx
  8012cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cf:	01 d0                	add    %edx,%eax
  8012d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8012d4:	eb 15                	jmp    8012eb <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8012d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d9:	8a 00                	mov    (%eax),%al
  8012db:	0f b6 d0             	movzbl %al,%edx
  8012de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e1:	0f b6 c0             	movzbl %al,%eax
  8012e4:	39 c2                	cmp    %eax,%edx
  8012e6:	74 0d                	je     8012f5 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8012e8:	ff 45 08             	incl   0x8(%ebp)
  8012eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ee:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012f1:	72 e3                	jb     8012d6 <memfind+0x13>
  8012f3:	eb 01                	jmp    8012f6 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8012f5:	90                   	nop
	return (void *) s;
  8012f6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012f9:	c9                   	leave  
  8012fa:	c3                   	ret    

008012fb <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8012fb:	55                   	push   %ebp
  8012fc:	89 e5                	mov    %esp,%ebp
  8012fe:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801301:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801308:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80130f:	eb 03                	jmp    801314 <strtol+0x19>
		s++;
  801311:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801314:	8b 45 08             	mov    0x8(%ebp),%eax
  801317:	8a 00                	mov    (%eax),%al
  801319:	3c 20                	cmp    $0x20,%al
  80131b:	74 f4                	je     801311 <strtol+0x16>
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	8a 00                	mov    (%eax),%al
  801322:	3c 09                	cmp    $0x9,%al
  801324:	74 eb                	je     801311 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801326:	8b 45 08             	mov    0x8(%ebp),%eax
  801329:	8a 00                	mov    (%eax),%al
  80132b:	3c 2b                	cmp    $0x2b,%al
  80132d:	75 05                	jne    801334 <strtol+0x39>
		s++;
  80132f:	ff 45 08             	incl   0x8(%ebp)
  801332:	eb 13                	jmp    801347 <strtol+0x4c>
	else if (*s == '-')
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	8a 00                	mov    (%eax),%al
  801339:	3c 2d                	cmp    $0x2d,%al
  80133b:	75 0a                	jne    801347 <strtol+0x4c>
		s++, neg = 1;
  80133d:	ff 45 08             	incl   0x8(%ebp)
  801340:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801347:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80134b:	74 06                	je     801353 <strtol+0x58>
  80134d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801351:	75 20                	jne    801373 <strtol+0x78>
  801353:	8b 45 08             	mov    0x8(%ebp),%eax
  801356:	8a 00                	mov    (%eax),%al
  801358:	3c 30                	cmp    $0x30,%al
  80135a:	75 17                	jne    801373 <strtol+0x78>
  80135c:	8b 45 08             	mov    0x8(%ebp),%eax
  80135f:	40                   	inc    %eax
  801360:	8a 00                	mov    (%eax),%al
  801362:	3c 78                	cmp    $0x78,%al
  801364:	75 0d                	jne    801373 <strtol+0x78>
		s += 2, base = 16;
  801366:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80136a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801371:	eb 28                	jmp    80139b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801373:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801377:	75 15                	jne    80138e <strtol+0x93>
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	8a 00                	mov    (%eax),%al
  80137e:	3c 30                	cmp    $0x30,%al
  801380:	75 0c                	jne    80138e <strtol+0x93>
		s++, base = 8;
  801382:	ff 45 08             	incl   0x8(%ebp)
  801385:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80138c:	eb 0d                	jmp    80139b <strtol+0xa0>
	else if (base == 0)
  80138e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801392:	75 07                	jne    80139b <strtol+0xa0>
		base = 10;
  801394:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	8a 00                	mov    (%eax),%al
  8013a0:	3c 2f                	cmp    $0x2f,%al
  8013a2:	7e 19                	jle    8013bd <strtol+0xc2>
  8013a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a7:	8a 00                	mov    (%eax),%al
  8013a9:	3c 39                	cmp    $0x39,%al
  8013ab:	7f 10                	jg     8013bd <strtol+0xc2>
			dig = *s - '0';
  8013ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b0:	8a 00                	mov    (%eax),%al
  8013b2:	0f be c0             	movsbl %al,%eax
  8013b5:	83 e8 30             	sub    $0x30,%eax
  8013b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013bb:	eb 42                	jmp    8013ff <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8013bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c0:	8a 00                	mov    (%eax),%al
  8013c2:	3c 60                	cmp    $0x60,%al
  8013c4:	7e 19                	jle    8013df <strtol+0xe4>
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	8a 00                	mov    (%eax),%al
  8013cb:	3c 7a                	cmp    $0x7a,%al
  8013cd:	7f 10                	jg     8013df <strtol+0xe4>
			dig = *s - 'a' + 10;
  8013cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d2:	8a 00                	mov    (%eax),%al
  8013d4:	0f be c0             	movsbl %al,%eax
  8013d7:	83 e8 57             	sub    $0x57,%eax
  8013da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013dd:	eb 20                	jmp    8013ff <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8013df:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e2:	8a 00                	mov    (%eax),%al
  8013e4:	3c 40                	cmp    $0x40,%al
  8013e6:	7e 39                	jle    801421 <strtol+0x126>
  8013e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013eb:	8a 00                	mov    (%eax),%al
  8013ed:	3c 5a                	cmp    $0x5a,%al
  8013ef:	7f 30                	jg     801421 <strtol+0x126>
			dig = *s - 'A' + 10;
  8013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f4:	8a 00                	mov    (%eax),%al
  8013f6:	0f be c0             	movsbl %al,%eax
  8013f9:	83 e8 37             	sub    $0x37,%eax
  8013fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8013ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801402:	3b 45 10             	cmp    0x10(%ebp),%eax
  801405:	7d 19                	jge    801420 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801407:	ff 45 08             	incl   0x8(%ebp)
  80140a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80140d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801411:	89 c2                	mov    %eax,%edx
  801413:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801416:	01 d0                	add    %edx,%eax
  801418:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80141b:	e9 7b ff ff ff       	jmp    80139b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801420:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801421:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801425:	74 08                	je     80142f <strtol+0x134>
		*endptr = (char *) s;
  801427:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142a:	8b 55 08             	mov    0x8(%ebp),%edx
  80142d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80142f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801433:	74 07                	je     80143c <strtol+0x141>
  801435:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801438:	f7 d8                	neg    %eax
  80143a:	eb 03                	jmp    80143f <strtol+0x144>
  80143c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80143f:	c9                   	leave  
  801440:	c3                   	ret    

00801441 <ltostr>:

void
ltostr(long value, char *str)
{
  801441:	55                   	push   %ebp
  801442:	89 e5                	mov    %esp,%ebp
  801444:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801447:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80144e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801455:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801459:	79 13                	jns    80146e <ltostr+0x2d>
	{
		neg = 1;
  80145b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801462:	8b 45 0c             	mov    0xc(%ebp),%eax
  801465:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801468:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80146b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80146e:	8b 45 08             	mov    0x8(%ebp),%eax
  801471:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801476:	99                   	cltd   
  801477:	f7 f9                	idiv   %ecx
  801479:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80147c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80147f:	8d 50 01             	lea    0x1(%eax),%edx
  801482:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801485:	89 c2                	mov    %eax,%edx
  801487:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148a:	01 d0                	add    %edx,%eax
  80148c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80148f:	83 c2 30             	add    $0x30,%edx
  801492:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801494:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801497:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80149c:	f7 e9                	imul   %ecx
  80149e:	c1 fa 02             	sar    $0x2,%edx
  8014a1:	89 c8                	mov    %ecx,%eax
  8014a3:	c1 f8 1f             	sar    $0x1f,%eax
  8014a6:	29 c2                	sub    %eax,%edx
  8014a8:	89 d0                	mov    %edx,%eax
  8014aa:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8014ad:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014b0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014b5:	f7 e9                	imul   %ecx
  8014b7:	c1 fa 02             	sar    $0x2,%edx
  8014ba:	89 c8                	mov    %ecx,%eax
  8014bc:	c1 f8 1f             	sar    $0x1f,%eax
  8014bf:	29 c2                	sub    %eax,%edx
  8014c1:	89 d0                	mov    %edx,%eax
  8014c3:	c1 e0 02             	shl    $0x2,%eax
  8014c6:	01 d0                	add    %edx,%eax
  8014c8:	01 c0                	add    %eax,%eax
  8014ca:	29 c1                	sub    %eax,%ecx
  8014cc:	89 ca                	mov    %ecx,%edx
  8014ce:	85 d2                	test   %edx,%edx
  8014d0:	75 9c                	jne    80146e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8014d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8014d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014dc:	48                   	dec    %eax
  8014dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8014e0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014e4:	74 3d                	je     801523 <ltostr+0xe2>
		start = 1 ;
  8014e6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8014ed:	eb 34                	jmp    801523 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8014ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f5:	01 d0                	add    %edx,%eax
  8014f7:	8a 00                	mov    (%eax),%al
  8014f9:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8014fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801502:	01 c2                	add    %eax,%edx
  801504:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801507:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150a:	01 c8                	add    %ecx,%eax
  80150c:	8a 00                	mov    (%eax),%al
  80150e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801510:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801513:	8b 45 0c             	mov    0xc(%ebp),%eax
  801516:	01 c2                	add    %eax,%edx
  801518:	8a 45 eb             	mov    -0x15(%ebp),%al
  80151b:	88 02                	mov    %al,(%edx)
		start++ ;
  80151d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801520:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801523:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801526:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801529:	7c c4                	jl     8014ef <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80152b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80152e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801531:	01 d0                	add    %edx,%eax
  801533:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801536:	90                   	nop
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
  80153c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80153f:	ff 75 08             	pushl  0x8(%ebp)
  801542:	e8 54 fa ff ff       	call   800f9b <strlen>
  801547:	83 c4 04             	add    $0x4,%esp
  80154a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80154d:	ff 75 0c             	pushl  0xc(%ebp)
  801550:	e8 46 fa ff ff       	call   800f9b <strlen>
  801555:	83 c4 04             	add    $0x4,%esp
  801558:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80155b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801562:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801569:	eb 17                	jmp    801582 <strcconcat+0x49>
		final[s] = str1[s] ;
  80156b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80156e:	8b 45 10             	mov    0x10(%ebp),%eax
  801571:	01 c2                	add    %eax,%edx
  801573:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801576:	8b 45 08             	mov    0x8(%ebp),%eax
  801579:	01 c8                	add    %ecx,%eax
  80157b:	8a 00                	mov    (%eax),%al
  80157d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80157f:	ff 45 fc             	incl   -0x4(%ebp)
  801582:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801585:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801588:	7c e1                	jl     80156b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80158a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801591:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801598:	eb 1f                	jmp    8015b9 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80159a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80159d:	8d 50 01             	lea    0x1(%eax),%edx
  8015a0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015a3:	89 c2                	mov    %eax,%edx
  8015a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a8:	01 c2                	add    %eax,%edx
  8015aa:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b0:	01 c8                	add    %ecx,%eax
  8015b2:	8a 00                	mov    (%eax),%al
  8015b4:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8015b6:	ff 45 f8             	incl   -0x8(%ebp)
  8015b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015bc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015bf:	7c d9                	jl     80159a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8015c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c7:	01 d0                	add    %edx,%eax
  8015c9:	c6 00 00             	movb   $0x0,(%eax)
}
  8015cc:	90                   	nop
  8015cd:	c9                   	leave  
  8015ce:	c3                   	ret    

008015cf <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8015cf:	55                   	push   %ebp
  8015d0:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8015d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8015d5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8015db:	8b 45 14             	mov    0x14(%ebp),%eax
  8015de:	8b 00                	mov    (%eax),%eax
  8015e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ea:	01 d0                	add    %edx,%eax
  8015ec:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8015f2:	eb 0c                	jmp    801600 <strsplit+0x31>
			*string++ = 0;
  8015f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f7:	8d 50 01             	lea    0x1(%eax),%edx
  8015fa:	89 55 08             	mov    %edx,0x8(%ebp)
  8015fd:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801600:	8b 45 08             	mov    0x8(%ebp),%eax
  801603:	8a 00                	mov    (%eax),%al
  801605:	84 c0                	test   %al,%al
  801607:	74 18                	je     801621 <strsplit+0x52>
  801609:	8b 45 08             	mov    0x8(%ebp),%eax
  80160c:	8a 00                	mov    (%eax),%al
  80160e:	0f be c0             	movsbl %al,%eax
  801611:	50                   	push   %eax
  801612:	ff 75 0c             	pushl  0xc(%ebp)
  801615:	e8 13 fb ff ff       	call   80112d <strchr>
  80161a:	83 c4 08             	add    $0x8,%esp
  80161d:	85 c0                	test   %eax,%eax
  80161f:	75 d3                	jne    8015f4 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801621:	8b 45 08             	mov    0x8(%ebp),%eax
  801624:	8a 00                	mov    (%eax),%al
  801626:	84 c0                	test   %al,%al
  801628:	74 5a                	je     801684 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80162a:	8b 45 14             	mov    0x14(%ebp),%eax
  80162d:	8b 00                	mov    (%eax),%eax
  80162f:	83 f8 0f             	cmp    $0xf,%eax
  801632:	75 07                	jne    80163b <strsplit+0x6c>
		{
			return 0;
  801634:	b8 00 00 00 00       	mov    $0x0,%eax
  801639:	eb 66                	jmp    8016a1 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80163b:	8b 45 14             	mov    0x14(%ebp),%eax
  80163e:	8b 00                	mov    (%eax),%eax
  801640:	8d 48 01             	lea    0x1(%eax),%ecx
  801643:	8b 55 14             	mov    0x14(%ebp),%edx
  801646:	89 0a                	mov    %ecx,(%edx)
  801648:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80164f:	8b 45 10             	mov    0x10(%ebp),%eax
  801652:	01 c2                	add    %eax,%edx
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801659:	eb 03                	jmp    80165e <strsplit+0x8f>
			string++;
  80165b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	8a 00                	mov    (%eax),%al
  801663:	84 c0                	test   %al,%al
  801665:	74 8b                	je     8015f2 <strsplit+0x23>
  801667:	8b 45 08             	mov    0x8(%ebp),%eax
  80166a:	8a 00                	mov    (%eax),%al
  80166c:	0f be c0             	movsbl %al,%eax
  80166f:	50                   	push   %eax
  801670:	ff 75 0c             	pushl  0xc(%ebp)
  801673:	e8 b5 fa ff ff       	call   80112d <strchr>
  801678:	83 c4 08             	add    $0x8,%esp
  80167b:	85 c0                	test   %eax,%eax
  80167d:	74 dc                	je     80165b <strsplit+0x8c>
			string++;
	}
  80167f:	e9 6e ff ff ff       	jmp    8015f2 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801684:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801685:	8b 45 14             	mov    0x14(%ebp),%eax
  801688:	8b 00                	mov    (%eax),%eax
  80168a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801691:	8b 45 10             	mov    0x10(%ebp),%eax
  801694:	01 d0                	add    %edx,%eax
  801696:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80169c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016a1:	c9                   	leave  
  8016a2:	c3                   	ret    

008016a3 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016a3:	55                   	push   %ebp
  8016a4:	89 e5                	mov    %esp,%ebp
  8016a6:	57                   	push   %edi
  8016a7:	56                   	push   %esi
  8016a8:	53                   	push   %ebx
  8016a9:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8016af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016b5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016b8:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016bb:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016be:	cd 30                	int    $0x30
  8016c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016c6:	83 c4 10             	add    $0x10,%esp
  8016c9:	5b                   	pop    %ebx
  8016ca:	5e                   	pop    %esi
  8016cb:	5f                   	pop    %edi
  8016cc:	5d                   	pop    %ebp
  8016cd:	c3                   	ret    

008016ce <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8016ce:	55                   	push   %ebp
  8016cf:	89 e5                	mov    %esp,%ebp
  8016d1:	83 ec 04             	sub    $0x4,%esp
  8016d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8016da:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	52                   	push   %edx
  8016e6:	ff 75 0c             	pushl  0xc(%ebp)
  8016e9:	50                   	push   %eax
  8016ea:	6a 00                	push   $0x0
  8016ec:	e8 b2 ff ff ff       	call   8016a3 <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
}
  8016f4:	90                   	nop
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <sys_cgetc>:

int
sys_cgetc(void)
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 01                	push   $0x1
  801706:	e8 98 ff ff ff       	call   8016a3 <syscall>
  80170b:	83 c4 18             	add    $0x18,%esp
}
  80170e:	c9                   	leave  
  80170f:	c3                   	ret    

00801710 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801710:	55                   	push   %ebp
  801711:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801713:	8b 45 08             	mov    0x8(%ebp),%eax
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	50                   	push   %eax
  80171f:	6a 05                	push   $0x5
  801721:	e8 7d ff ff ff       	call   8016a3 <syscall>
  801726:	83 c4 18             	add    $0x18,%esp
}
  801729:	c9                   	leave  
  80172a:	c3                   	ret    

0080172b <sys_getenvid>:

int32 sys_getenvid(void)
{
  80172b:	55                   	push   %ebp
  80172c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	6a 02                	push   $0x2
  80173a:	e8 64 ff ff ff       	call   8016a3 <syscall>
  80173f:	83 c4 18             	add    $0x18,%esp
}
  801742:	c9                   	leave  
  801743:	c3                   	ret    

00801744 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801744:	55                   	push   %ebp
  801745:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 03                	push   $0x3
  801753:	e8 4b ff ff ff       	call   8016a3 <syscall>
  801758:	83 c4 18             	add    $0x18,%esp
}
  80175b:	c9                   	leave  
  80175c:	c3                   	ret    

0080175d <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80175d:	55                   	push   %ebp
  80175e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	6a 00                	push   $0x0
  80176a:	6a 04                	push   $0x4
  80176c:	e8 32 ff ff ff       	call   8016a3 <syscall>
  801771:	83 c4 18             	add    $0x18,%esp
}
  801774:	c9                   	leave  
  801775:	c3                   	ret    

00801776 <sys_env_exit>:


void sys_env_exit(void)
{
  801776:	55                   	push   %ebp
  801777:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 06                	push   $0x6
  801785:	e8 19 ff ff ff       	call   8016a3 <syscall>
  80178a:	83 c4 18             	add    $0x18,%esp
}
  80178d:	90                   	nop
  80178e:	c9                   	leave  
  80178f:	c3                   	ret    

00801790 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801793:	8b 55 0c             	mov    0xc(%ebp),%edx
  801796:	8b 45 08             	mov    0x8(%ebp),%eax
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	52                   	push   %edx
  8017a0:	50                   	push   %eax
  8017a1:	6a 07                	push   $0x7
  8017a3:	e8 fb fe ff ff       	call   8016a3 <syscall>
  8017a8:	83 c4 18             	add    $0x18,%esp
}
  8017ab:	c9                   	leave  
  8017ac:	c3                   	ret    

008017ad <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
  8017b0:	56                   	push   %esi
  8017b1:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017b2:	8b 75 18             	mov    0x18(%ebp),%esi
  8017b5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017b8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017be:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c1:	56                   	push   %esi
  8017c2:	53                   	push   %ebx
  8017c3:	51                   	push   %ecx
  8017c4:	52                   	push   %edx
  8017c5:	50                   	push   %eax
  8017c6:	6a 08                	push   $0x8
  8017c8:	e8 d6 fe ff ff       	call   8016a3 <syscall>
  8017cd:	83 c4 18             	add    $0x18,%esp
}
  8017d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017d3:	5b                   	pop    %ebx
  8017d4:	5e                   	pop    %esi
  8017d5:	5d                   	pop    %ebp
  8017d6:	c3                   	ret    

008017d7 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8017da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	52                   	push   %edx
  8017e7:	50                   	push   %eax
  8017e8:	6a 09                	push   $0x9
  8017ea:	e8 b4 fe ff ff       	call   8016a3 <syscall>
  8017ef:	83 c4 18             	add    $0x18,%esp
}
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	ff 75 0c             	pushl  0xc(%ebp)
  801800:	ff 75 08             	pushl  0x8(%ebp)
  801803:	6a 0a                	push   $0xa
  801805:	e8 99 fe ff ff       	call   8016a3 <syscall>
  80180a:	83 c4 18             	add    $0x18,%esp
}
  80180d:	c9                   	leave  
  80180e:	c3                   	ret    

0080180f <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80180f:	55                   	push   %ebp
  801810:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 0b                	push   $0xb
  80181e:	e8 80 fe ff ff       	call   8016a3 <syscall>
  801823:	83 c4 18             	add    $0x18,%esp
}
  801826:	c9                   	leave  
  801827:	c3                   	ret    

00801828 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801828:	55                   	push   %ebp
  801829:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 0c                	push   $0xc
  801837:	e8 67 fe ff ff       	call   8016a3 <syscall>
  80183c:	83 c4 18             	add    $0x18,%esp
}
  80183f:	c9                   	leave  
  801840:	c3                   	ret    

00801841 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801841:	55                   	push   %ebp
  801842:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 0d                	push   $0xd
  801850:	e8 4e fe ff ff       	call   8016a3 <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
}
  801858:	c9                   	leave  
  801859:	c3                   	ret    

0080185a <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80185a:	55                   	push   %ebp
  80185b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	ff 75 0c             	pushl  0xc(%ebp)
  801866:	ff 75 08             	pushl  0x8(%ebp)
  801869:	6a 11                	push   $0x11
  80186b:	e8 33 fe ff ff       	call   8016a3 <syscall>
  801870:	83 c4 18             	add    $0x18,%esp
	return;
  801873:	90                   	nop
}
  801874:	c9                   	leave  
  801875:	c3                   	ret    

00801876 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801876:	55                   	push   %ebp
  801877:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	ff 75 0c             	pushl  0xc(%ebp)
  801882:	ff 75 08             	pushl  0x8(%ebp)
  801885:	6a 12                	push   $0x12
  801887:	e8 17 fe ff ff       	call   8016a3 <syscall>
  80188c:	83 c4 18             	add    $0x18,%esp
	return ;
  80188f:	90                   	nop
}
  801890:	c9                   	leave  
  801891:	c3                   	ret    

00801892 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801892:	55                   	push   %ebp
  801893:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 0e                	push   $0xe
  8018a1:	e8 fd fd ff ff       	call   8016a3 <syscall>
  8018a6:	83 c4 18             	add    $0x18,%esp
}
  8018a9:	c9                   	leave  
  8018aa:	c3                   	ret    

008018ab <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018ab:	55                   	push   %ebp
  8018ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	ff 75 08             	pushl  0x8(%ebp)
  8018b9:	6a 0f                	push   $0xf
  8018bb:	e8 e3 fd ff ff       	call   8016a3 <syscall>
  8018c0:	83 c4 18             	add    $0x18,%esp
}
  8018c3:	c9                   	leave  
  8018c4:	c3                   	ret    

008018c5 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8018c5:	55                   	push   %ebp
  8018c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 10                	push   $0x10
  8018d4:	e8 ca fd ff ff       	call   8016a3 <syscall>
  8018d9:	83 c4 18             	add    $0x18,%esp
}
  8018dc:	90                   	nop
  8018dd:	c9                   	leave  
  8018de:	c3                   	ret    

008018df <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8018df:	55                   	push   %ebp
  8018e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 14                	push   $0x14
  8018ee:	e8 b0 fd ff ff       	call   8016a3 <syscall>
  8018f3:	83 c4 18             	add    $0x18,%esp
}
  8018f6:	90                   	nop
  8018f7:	c9                   	leave  
  8018f8:	c3                   	ret    

008018f9 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8018f9:	55                   	push   %ebp
  8018fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	6a 15                	push   $0x15
  801908:	e8 96 fd ff ff       	call   8016a3 <syscall>
  80190d:	83 c4 18             	add    $0x18,%esp
}
  801910:	90                   	nop
  801911:	c9                   	leave  
  801912:	c3                   	ret    

00801913 <sys_cputc>:


void
sys_cputc(const char c)
{
  801913:	55                   	push   %ebp
  801914:	89 e5                	mov    %esp,%ebp
  801916:	83 ec 04             	sub    $0x4,%esp
  801919:	8b 45 08             	mov    0x8(%ebp),%eax
  80191c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80191f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	50                   	push   %eax
  80192c:	6a 16                	push   $0x16
  80192e:	e8 70 fd ff ff       	call   8016a3 <syscall>
  801933:	83 c4 18             	add    $0x18,%esp
}
  801936:	90                   	nop
  801937:	c9                   	leave  
  801938:	c3                   	ret    

00801939 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801939:	55                   	push   %ebp
  80193a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	6a 00                	push   $0x0
  801946:	6a 17                	push   $0x17
  801948:	e8 56 fd ff ff       	call   8016a3 <syscall>
  80194d:	83 c4 18             	add    $0x18,%esp
}
  801950:	90                   	nop
  801951:	c9                   	leave  
  801952:	c3                   	ret    

00801953 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801953:	55                   	push   %ebp
  801954:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801956:	8b 45 08             	mov    0x8(%ebp),%eax
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	ff 75 0c             	pushl  0xc(%ebp)
  801962:	50                   	push   %eax
  801963:	6a 18                	push   $0x18
  801965:	e8 39 fd ff ff       	call   8016a3 <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
}
  80196d:	c9                   	leave  
  80196e:	c3                   	ret    

0080196f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801972:	8b 55 0c             	mov    0xc(%ebp),%edx
  801975:	8b 45 08             	mov    0x8(%ebp),%eax
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	52                   	push   %edx
  80197f:	50                   	push   %eax
  801980:	6a 1b                	push   $0x1b
  801982:	e8 1c fd ff ff       	call   8016a3 <syscall>
  801987:	83 c4 18             	add    $0x18,%esp
}
  80198a:	c9                   	leave  
  80198b:	c3                   	ret    

0080198c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80198f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801992:	8b 45 08             	mov    0x8(%ebp),%eax
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	52                   	push   %edx
  80199c:	50                   	push   %eax
  80199d:	6a 19                	push   $0x19
  80199f:	e8 ff fc ff ff       	call   8016a3 <syscall>
  8019a4:	83 c4 18             	add    $0x18,%esp
}
  8019a7:	90                   	nop
  8019a8:	c9                   	leave  
  8019a9:	c3                   	ret    

008019aa <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019aa:	55                   	push   %ebp
  8019ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 00                	push   $0x0
  8019b9:	52                   	push   %edx
  8019ba:	50                   	push   %eax
  8019bb:	6a 1a                	push   $0x1a
  8019bd:	e8 e1 fc ff ff       	call   8016a3 <syscall>
  8019c2:	83 c4 18             	add    $0x18,%esp
}
  8019c5:	90                   	nop
  8019c6:	c9                   	leave  
  8019c7:	c3                   	ret    

008019c8 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8019c8:	55                   	push   %ebp
  8019c9:	89 e5                	mov    %esp,%ebp
  8019cb:	83 ec 04             	sub    $0x4,%esp
  8019ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8019d1:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8019d4:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8019d7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8019db:	8b 45 08             	mov    0x8(%ebp),%eax
  8019de:	6a 00                	push   $0x0
  8019e0:	51                   	push   %ecx
  8019e1:	52                   	push   %edx
  8019e2:	ff 75 0c             	pushl  0xc(%ebp)
  8019e5:	50                   	push   %eax
  8019e6:	6a 1c                	push   $0x1c
  8019e8:	e8 b6 fc ff ff       	call   8016a3 <syscall>
  8019ed:	83 c4 18             	add    $0x18,%esp
}
  8019f0:	c9                   	leave  
  8019f1:	c3                   	ret    

008019f2 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8019f2:	55                   	push   %ebp
  8019f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8019f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	52                   	push   %edx
  801a02:	50                   	push   %eax
  801a03:	6a 1d                	push   $0x1d
  801a05:	e8 99 fc ff ff       	call   8016a3 <syscall>
  801a0a:	83 c4 18             	add    $0x18,%esp
}
  801a0d:	c9                   	leave  
  801a0e:	c3                   	ret    

00801a0f <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a0f:	55                   	push   %ebp
  801a10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a12:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a15:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a18:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1b:	6a 00                	push   $0x0
  801a1d:	6a 00                	push   $0x0
  801a1f:	51                   	push   %ecx
  801a20:	52                   	push   %edx
  801a21:	50                   	push   %eax
  801a22:	6a 1e                	push   $0x1e
  801a24:	e8 7a fc ff ff       	call   8016a3 <syscall>
  801a29:	83 c4 18             	add    $0x18,%esp
}
  801a2c:	c9                   	leave  
  801a2d:	c3                   	ret    

00801a2e <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a2e:	55                   	push   %ebp
  801a2f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a31:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a34:	8b 45 08             	mov    0x8(%ebp),%eax
  801a37:	6a 00                	push   $0x0
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	52                   	push   %edx
  801a3e:	50                   	push   %eax
  801a3f:	6a 1f                	push   $0x1f
  801a41:	e8 5d fc ff ff       	call   8016a3 <syscall>
  801a46:	83 c4 18             	add    $0x18,%esp
}
  801a49:	c9                   	leave  
  801a4a:	c3                   	ret    

00801a4b <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a4b:	55                   	push   %ebp
  801a4c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 20                	push   $0x20
  801a5a:	e8 44 fc ff ff       	call   8016a3 <syscall>
  801a5f:	83 c4 18             	add    $0x18,%esp
}
  801a62:	c9                   	leave  
  801a63:	c3                   	ret    

00801a64 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801a64:	55                   	push   %ebp
  801a65:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801a67:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6a:	6a 00                	push   $0x0
  801a6c:	6a 00                	push   $0x0
  801a6e:	ff 75 10             	pushl  0x10(%ebp)
  801a71:	ff 75 0c             	pushl  0xc(%ebp)
  801a74:	50                   	push   %eax
  801a75:	6a 21                	push   $0x21
  801a77:	e8 27 fc ff ff       	call   8016a3 <syscall>
  801a7c:	83 c4 18             	add    $0x18,%esp
}
  801a7f:	c9                   	leave  
  801a80:	c3                   	ret    

00801a81 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801a81:	55                   	push   %ebp
  801a82:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801a84:	8b 45 08             	mov    0x8(%ebp),%eax
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	50                   	push   %eax
  801a90:	6a 22                	push   $0x22
  801a92:	e8 0c fc ff ff       	call   8016a3 <syscall>
  801a97:	83 c4 18             	add    $0x18,%esp
}
  801a9a:	90                   	nop
  801a9b:	c9                   	leave  
  801a9c:	c3                   	ret    

00801a9d <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801a9d:	55                   	push   %ebp
  801a9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 00                	push   $0x0
  801aab:	50                   	push   %eax
  801aac:	6a 23                	push   $0x23
  801aae:	e8 f0 fb ff ff       	call   8016a3 <syscall>
  801ab3:	83 c4 18             	add    $0x18,%esp
}
  801ab6:	90                   	nop
  801ab7:	c9                   	leave  
  801ab8:	c3                   	ret    

00801ab9 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ab9:	55                   	push   %ebp
  801aba:	89 e5                	mov    %esp,%ebp
  801abc:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801abf:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ac2:	8d 50 04             	lea    0x4(%eax),%edx
  801ac5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	52                   	push   %edx
  801acf:	50                   	push   %eax
  801ad0:	6a 24                	push   $0x24
  801ad2:	e8 cc fb ff ff       	call   8016a3 <syscall>
  801ad7:	83 c4 18             	add    $0x18,%esp
	return result;
  801ada:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801add:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ae0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ae3:	89 01                	mov    %eax,(%ecx)
  801ae5:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  801aeb:	c9                   	leave  
  801aec:	c2 04 00             	ret    $0x4

00801aef <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801aef:	55                   	push   %ebp
  801af0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	ff 75 10             	pushl  0x10(%ebp)
  801af9:	ff 75 0c             	pushl  0xc(%ebp)
  801afc:	ff 75 08             	pushl  0x8(%ebp)
  801aff:	6a 13                	push   $0x13
  801b01:	e8 9d fb ff ff       	call   8016a3 <syscall>
  801b06:	83 c4 18             	add    $0x18,%esp
	return ;
  801b09:	90                   	nop
}
  801b0a:	c9                   	leave  
  801b0b:	c3                   	ret    

00801b0c <sys_rcr2>:
uint32 sys_rcr2()
{
  801b0c:	55                   	push   %ebp
  801b0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 25                	push   $0x25
  801b1b:	e8 83 fb ff ff       	call   8016a3 <syscall>
  801b20:	83 c4 18             	add    $0x18,%esp
}
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
  801b28:	83 ec 04             	sub    $0x4,%esp
  801b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b31:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b35:	6a 00                	push   $0x0
  801b37:	6a 00                	push   $0x0
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	50                   	push   %eax
  801b3e:	6a 26                	push   $0x26
  801b40:	e8 5e fb ff ff       	call   8016a3 <syscall>
  801b45:	83 c4 18             	add    $0x18,%esp
	return ;
  801b48:	90                   	nop
}
  801b49:	c9                   	leave  
  801b4a:	c3                   	ret    

00801b4b <rsttst>:
void rsttst()
{
  801b4b:	55                   	push   %ebp
  801b4c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	6a 00                	push   $0x0
  801b54:	6a 00                	push   $0x0
  801b56:	6a 00                	push   $0x0
  801b58:	6a 28                	push   $0x28
  801b5a:	e8 44 fb ff ff       	call   8016a3 <syscall>
  801b5f:	83 c4 18             	add    $0x18,%esp
	return ;
  801b62:	90                   	nop
}
  801b63:	c9                   	leave  
  801b64:	c3                   	ret    

00801b65 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801b65:	55                   	push   %ebp
  801b66:	89 e5                	mov    %esp,%ebp
  801b68:	83 ec 04             	sub    $0x4,%esp
  801b6b:	8b 45 14             	mov    0x14(%ebp),%eax
  801b6e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801b71:	8b 55 18             	mov    0x18(%ebp),%edx
  801b74:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b78:	52                   	push   %edx
  801b79:	50                   	push   %eax
  801b7a:	ff 75 10             	pushl  0x10(%ebp)
  801b7d:	ff 75 0c             	pushl  0xc(%ebp)
  801b80:	ff 75 08             	pushl  0x8(%ebp)
  801b83:	6a 27                	push   $0x27
  801b85:	e8 19 fb ff ff       	call   8016a3 <syscall>
  801b8a:	83 c4 18             	add    $0x18,%esp
	return ;
  801b8d:	90                   	nop
}
  801b8e:	c9                   	leave  
  801b8f:	c3                   	ret    

00801b90 <chktst>:
void chktst(uint32 n)
{
  801b90:	55                   	push   %ebp
  801b91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	ff 75 08             	pushl  0x8(%ebp)
  801b9e:	6a 29                	push   $0x29
  801ba0:	e8 fe fa ff ff       	call   8016a3 <syscall>
  801ba5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba8:	90                   	nop
}
  801ba9:	c9                   	leave  
  801baa:	c3                   	ret    

00801bab <inctst>:

void inctst()
{
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 2a                	push   $0x2a
  801bba:	e8 e4 fa ff ff       	call   8016a3 <syscall>
  801bbf:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc2:	90                   	nop
}
  801bc3:	c9                   	leave  
  801bc4:	c3                   	ret    

00801bc5 <gettst>:
uint32 gettst()
{
  801bc5:	55                   	push   %ebp
  801bc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 2b                	push   $0x2b
  801bd4:	e8 ca fa ff ff       	call   8016a3 <syscall>
  801bd9:	83 c4 18             	add    $0x18,%esp
}
  801bdc:	c9                   	leave  
  801bdd:	c3                   	ret    

00801bde <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801bde:	55                   	push   %ebp
  801bdf:	89 e5                	mov    %esp,%ebp
  801be1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	6a 2c                	push   $0x2c
  801bf0:	e8 ae fa ff ff       	call   8016a3 <syscall>
  801bf5:	83 c4 18             	add    $0x18,%esp
  801bf8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801bfb:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801bff:	75 07                	jne    801c08 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c01:	b8 01 00 00 00       	mov    $0x1,%eax
  801c06:	eb 05                	jmp    801c0d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c08:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c0d:	c9                   	leave  
  801c0e:	c3                   	ret    

00801c0f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c0f:	55                   	push   %ebp
  801c10:	89 e5                	mov    %esp,%ebp
  801c12:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 2c                	push   $0x2c
  801c21:	e8 7d fa ff ff       	call   8016a3 <syscall>
  801c26:	83 c4 18             	add    $0x18,%esp
  801c29:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c2c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c30:	75 07                	jne    801c39 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c32:	b8 01 00 00 00       	mov    $0x1,%eax
  801c37:	eb 05                	jmp    801c3e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c39:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c3e:	c9                   	leave  
  801c3f:	c3                   	ret    

00801c40 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c40:	55                   	push   %ebp
  801c41:	89 e5                	mov    %esp,%ebp
  801c43:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 2c                	push   $0x2c
  801c52:	e8 4c fa ff ff       	call   8016a3 <syscall>
  801c57:	83 c4 18             	add    $0x18,%esp
  801c5a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801c5d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801c61:	75 07                	jne    801c6a <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801c63:	b8 01 00 00 00       	mov    $0x1,%eax
  801c68:	eb 05                	jmp    801c6f <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801c6a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c6f:	c9                   	leave  
  801c70:	c3                   	ret    

00801c71 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801c71:	55                   	push   %ebp
  801c72:	89 e5                	mov    %esp,%ebp
  801c74:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 2c                	push   $0x2c
  801c83:	e8 1b fa ff ff       	call   8016a3 <syscall>
  801c88:	83 c4 18             	add    $0x18,%esp
  801c8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801c8e:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801c92:	75 07                	jne    801c9b <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801c94:	b8 01 00 00 00       	mov    $0x1,%eax
  801c99:	eb 05                	jmp    801ca0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801c9b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ca0:	c9                   	leave  
  801ca1:	c3                   	ret    

00801ca2 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ca2:	55                   	push   %ebp
  801ca3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	ff 75 08             	pushl  0x8(%ebp)
  801cb0:	6a 2d                	push   $0x2d
  801cb2:	e8 ec f9 ff ff       	call   8016a3 <syscall>
  801cb7:	83 c4 18             	add    $0x18,%esp
	return ;
  801cba:	90                   	nop
}
  801cbb:	c9                   	leave  
  801cbc:	c3                   	ret    
  801cbd:	66 90                	xchg   %ax,%ax
  801cbf:	90                   	nop

00801cc0 <__udivdi3>:
  801cc0:	55                   	push   %ebp
  801cc1:	57                   	push   %edi
  801cc2:	56                   	push   %esi
  801cc3:	53                   	push   %ebx
  801cc4:	83 ec 1c             	sub    $0x1c,%esp
  801cc7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ccb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ccf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cd3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801cd7:	89 ca                	mov    %ecx,%edx
  801cd9:	89 f8                	mov    %edi,%eax
  801cdb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801cdf:	85 f6                	test   %esi,%esi
  801ce1:	75 2d                	jne    801d10 <__udivdi3+0x50>
  801ce3:	39 cf                	cmp    %ecx,%edi
  801ce5:	77 65                	ja     801d4c <__udivdi3+0x8c>
  801ce7:	89 fd                	mov    %edi,%ebp
  801ce9:	85 ff                	test   %edi,%edi
  801ceb:	75 0b                	jne    801cf8 <__udivdi3+0x38>
  801ced:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf2:	31 d2                	xor    %edx,%edx
  801cf4:	f7 f7                	div    %edi
  801cf6:	89 c5                	mov    %eax,%ebp
  801cf8:	31 d2                	xor    %edx,%edx
  801cfa:	89 c8                	mov    %ecx,%eax
  801cfc:	f7 f5                	div    %ebp
  801cfe:	89 c1                	mov    %eax,%ecx
  801d00:	89 d8                	mov    %ebx,%eax
  801d02:	f7 f5                	div    %ebp
  801d04:	89 cf                	mov    %ecx,%edi
  801d06:	89 fa                	mov    %edi,%edx
  801d08:	83 c4 1c             	add    $0x1c,%esp
  801d0b:	5b                   	pop    %ebx
  801d0c:	5e                   	pop    %esi
  801d0d:	5f                   	pop    %edi
  801d0e:	5d                   	pop    %ebp
  801d0f:	c3                   	ret    
  801d10:	39 ce                	cmp    %ecx,%esi
  801d12:	77 28                	ja     801d3c <__udivdi3+0x7c>
  801d14:	0f bd fe             	bsr    %esi,%edi
  801d17:	83 f7 1f             	xor    $0x1f,%edi
  801d1a:	75 40                	jne    801d5c <__udivdi3+0x9c>
  801d1c:	39 ce                	cmp    %ecx,%esi
  801d1e:	72 0a                	jb     801d2a <__udivdi3+0x6a>
  801d20:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d24:	0f 87 9e 00 00 00    	ja     801dc8 <__udivdi3+0x108>
  801d2a:	b8 01 00 00 00       	mov    $0x1,%eax
  801d2f:	89 fa                	mov    %edi,%edx
  801d31:	83 c4 1c             	add    $0x1c,%esp
  801d34:	5b                   	pop    %ebx
  801d35:	5e                   	pop    %esi
  801d36:	5f                   	pop    %edi
  801d37:	5d                   	pop    %ebp
  801d38:	c3                   	ret    
  801d39:	8d 76 00             	lea    0x0(%esi),%esi
  801d3c:	31 ff                	xor    %edi,%edi
  801d3e:	31 c0                	xor    %eax,%eax
  801d40:	89 fa                	mov    %edi,%edx
  801d42:	83 c4 1c             	add    $0x1c,%esp
  801d45:	5b                   	pop    %ebx
  801d46:	5e                   	pop    %esi
  801d47:	5f                   	pop    %edi
  801d48:	5d                   	pop    %ebp
  801d49:	c3                   	ret    
  801d4a:	66 90                	xchg   %ax,%ax
  801d4c:	89 d8                	mov    %ebx,%eax
  801d4e:	f7 f7                	div    %edi
  801d50:	31 ff                	xor    %edi,%edi
  801d52:	89 fa                	mov    %edi,%edx
  801d54:	83 c4 1c             	add    $0x1c,%esp
  801d57:	5b                   	pop    %ebx
  801d58:	5e                   	pop    %esi
  801d59:	5f                   	pop    %edi
  801d5a:	5d                   	pop    %ebp
  801d5b:	c3                   	ret    
  801d5c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d61:	89 eb                	mov    %ebp,%ebx
  801d63:	29 fb                	sub    %edi,%ebx
  801d65:	89 f9                	mov    %edi,%ecx
  801d67:	d3 e6                	shl    %cl,%esi
  801d69:	89 c5                	mov    %eax,%ebp
  801d6b:	88 d9                	mov    %bl,%cl
  801d6d:	d3 ed                	shr    %cl,%ebp
  801d6f:	89 e9                	mov    %ebp,%ecx
  801d71:	09 f1                	or     %esi,%ecx
  801d73:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d77:	89 f9                	mov    %edi,%ecx
  801d79:	d3 e0                	shl    %cl,%eax
  801d7b:	89 c5                	mov    %eax,%ebp
  801d7d:	89 d6                	mov    %edx,%esi
  801d7f:	88 d9                	mov    %bl,%cl
  801d81:	d3 ee                	shr    %cl,%esi
  801d83:	89 f9                	mov    %edi,%ecx
  801d85:	d3 e2                	shl    %cl,%edx
  801d87:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d8b:	88 d9                	mov    %bl,%cl
  801d8d:	d3 e8                	shr    %cl,%eax
  801d8f:	09 c2                	or     %eax,%edx
  801d91:	89 d0                	mov    %edx,%eax
  801d93:	89 f2                	mov    %esi,%edx
  801d95:	f7 74 24 0c          	divl   0xc(%esp)
  801d99:	89 d6                	mov    %edx,%esi
  801d9b:	89 c3                	mov    %eax,%ebx
  801d9d:	f7 e5                	mul    %ebp
  801d9f:	39 d6                	cmp    %edx,%esi
  801da1:	72 19                	jb     801dbc <__udivdi3+0xfc>
  801da3:	74 0b                	je     801db0 <__udivdi3+0xf0>
  801da5:	89 d8                	mov    %ebx,%eax
  801da7:	31 ff                	xor    %edi,%edi
  801da9:	e9 58 ff ff ff       	jmp    801d06 <__udivdi3+0x46>
  801dae:	66 90                	xchg   %ax,%ax
  801db0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801db4:	89 f9                	mov    %edi,%ecx
  801db6:	d3 e2                	shl    %cl,%edx
  801db8:	39 c2                	cmp    %eax,%edx
  801dba:	73 e9                	jae    801da5 <__udivdi3+0xe5>
  801dbc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801dbf:	31 ff                	xor    %edi,%edi
  801dc1:	e9 40 ff ff ff       	jmp    801d06 <__udivdi3+0x46>
  801dc6:	66 90                	xchg   %ax,%ax
  801dc8:	31 c0                	xor    %eax,%eax
  801dca:	e9 37 ff ff ff       	jmp    801d06 <__udivdi3+0x46>
  801dcf:	90                   	nop

00801dd0 <__umoddi3>:
  801dd0:	55                   	push   %ebp
  801dd1:	57                   	push   %edi
  801dd2:	56                   	push   %esi
  801dd3:	53                   	push   %ebx
  801dd4:	83 ec 1c             	sub    $0x1c,%esp
  801dd7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ddb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ddf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801de3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801de7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801deb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801def:	89 f3                	mov    %esi,%ebx
  801df1:	89 fa                	mov    %edi,%edx
  801df3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801df7:	89 34 24             	mov    %esi,(%esp)
  801dfa:	85 c0                	test   %eax,%eax
  801dfc:	75 1a                	jne    801e18 <__umoddi3+0x48>
  801dfe:	39 f7                	cmp    %esi,%edi
  801e00:	0f 86 a2 00 00 00    	jbe    801ea8 <__umoddi3+0xd8>
  801e06:	89 c8                	mov    %ecx,%eax
  801e08:	89 f2                	mov    %esi,%edx
  801e0a:	f7 f7                	div    %edi
  801e0c:	89 d0                	mov    %edx,%eax
  801e0e:	31 d2                	xor    %edx,%edx
  801e10:	83 c4 1c             	add    $0x1c,%esp
  801e13:	5b                   	pop    %ebx
  801e14:	5e                   	pop    %esi
  801e15:	5f                   	pop    %edi
  801e16:	5d                   	pop    %ebp
  801e17:	c3                   	ret    
  801e18:	39 f0                	cmp    %esi,%eax
  801e1a:	0f 87 ac 00 00 00    	ja     801ecc <__umoddi3+0xfc>
  801e20:	0f bd e8             	bsr    %eax,%ebp
  801e23:	83 f5 1f             	xor    $0x1f,%ebp
  801e26:	0f 84 ac 00 00 00    	je     801ed8 <__umoddi3+0x108>
  801e2c:	bf 20 00 00 00       	mov    $0x20,%edi
  801e31:	29 ef                	sub    %ebp,%edi
  801e33:	89 fe                	mov    %edi,%esi
  801e35:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e39:	89 e9                	mov    %ebp,%ecx
  801e3b:	d3 e0                	shl    %cl,%eax
  801e3d:	89 d7                	mov    %edx,%edi
  801e3f:	89 f1                	mov    %esi,%ecx
  801e41:	d3 ef                	shr    %cl,%edi
  801e43:	09 c7                	or     %eax,%edi
  801e45:	89 e9                	mov    %ebp,%ecx
  801e47:	d3 e2                	shl    %cl,%edx
  801e49:	89 14 24             	mov    %edx,(%esp)
  801e4c:	89 d8                	mov    %ebx,%eax
  801e4e:	d3 e0                	shl    %cl,%eax
  801e50:	89 c2                	mov    %eax,%edx
  801e52:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e56:	d3 e0                	shl    %cl,%eax
  801e58:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e5c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e60:	89 f1                	mov    %esi,%ecx
  801e62:	d3 e8                	shr    %cl,%eax
  801e64:	09 d0                	or     %edx,%eax
  801e66:	d3 eb                	shr    %cl,%ebx
  801e68:	89 da                	mov    %ebx,%edx
  801e6a:	f7 f7                	div    %edi
  801e6c:	89 d3                	mov    %edx,%ebx
  801e6e:	f7 24 24             	mull   (%esp)
  801e71:	89 c6                	mov    %eax,%esi
  801e73:	89 d1                	mov    %edx,%ecx
  801e75:	39 d3                	cmp    %edx,%ebx
  801e77:	0f 82 87 00 00 00    	jb     801f04 <__umoddi3+0x134>
  801e7d:	0f 84 91 00 00 00    	je     801f14 <__umoddi3+0x144>
  801e83:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e87:	29 f2                	sub    %esi,%edx
  801e89:	19 cb                	sbb    %ecx,%ebx
  801e8b:	89 d8                	mov    %ebx,%eax
  801e8d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e91:	d3 e0                	shl    %cl,%eax
  801e93:	89 e9                	mov    %ebp,%ecx
  801e95:	d3 ea                	shr    %cl,%edx
  801e97:	09 d0                	or     %edx,%eax
  801e99:	89 e9                	mov    %ebp,%ecx
  801e9b:	d3 eb                	shr    %cl,%ebx
  801e9d:	89 da                	mov    %ebx,%edx
  801e9f:	83 c4 1c             	add    $0x1c,%esp
  801ea2:	5b                   	pop    %ebx
  801ea3:	5e                   	pop    %esi
  801ea4:	5f                   	pop    %edi
  801ea5:	5d                   	pop    %ebp
  801ea6:	c3                   	ret    
  801ea7:	90                   	nop
  801ea8:	89 fd                	mov    %edi,%ebp
  801eaa:	85 ff                	test   %edi,%edi
  801eac:	75 0b                	jne    801eb9 <__umoddi3+0xe9>
  801eae:	b8 01 00 00 00       	mov    $0x1,%eax
  801eb3:	31 d2                	xor    %edx,%edx
  801eb5:	f7 f7                	div    %edi
  801eb7:	89 c5                	mov    %eax,%ebp
  801eb9:	89 f0                	mov    %esi,%eax
  801ebb:	31 d2                	xor    %edx,%edx
  801ebd:	f7 f5                	div    %ebp
  801ebf:	89 c8                	mov    %ecx,%eax
  801ec1:	f7 f5                	div    %ebp
  801ec3:	89 d0                	mov    %edx,%eax
  801ec5:	e9 44 ff ff ff       	jmp    801e0e <__umoddi3+0x3e>
  801eca:	66 90                	xchg   %ax,%ax
  801ecc:	89 c8                	mov    %ecx,%eax
  801ece:	89 f2                	mov    %esi,%edx
  801ed0:	83 c4 1c             	add    $0x1c,%esp
  801ed3:	5b                   	pop    %ebx
  801ed4:	5e                   	pop    %esi
  801ed5:	5f                   	pop    %edi
  801ed6:	5d                   	pop    %ebp
  801ed7:	c3                   	ret    
  801ed8:	3b 04 24             	cmp    (%esp),%eax
  801edb:	72 06                	jb     801ee3 <__umoddi3+0x113>
  801edd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ee1:	77 0f                	ja     801ef2 <__umoddi3+0x122>
  801ee3:	89 f2                	mov    %esi,%edx
  801ee5:	29 f9                	sub    %edi,%ecx
  801ee7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801eeb:	89 14 24             	mov    %edx,(%esp)
  801eee:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ef2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ef6:	8b 14 24             	mov    (%esp),%edx
  801ef9:	83 c4 1c             	add    $0x1c,%esp
  801efc:	5b                   	pop    %ebx
  801efd:	5e                   	pop    %esi
  801efe:	5f                   	pop    %edi
  801eff:	5d                   	pop    %ebp
  801f00:	c3                   	ret    
  801f01:	8d 76 00             	lea    0x0(%esi),%esi
  801f04:	2b 04 24             	sub    (%esp),%eax
  801f07:	19 fa                	sbb    %edi,%edx
  801f09:	89 d1                	mov    %edx,%ecx
  801f0b:	89 c6                	mov    %eax,%esi
  801f0d:	e9 71 ff ff ff       	jmp    801e83 <__umoddi3+0xb3>
  801f12:	66 90                	xchg   %ax,%ax
  801f14:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f18:	72 ea                	jb     801f04 <__umoddi3+0x134>
  801f1a:	89 d9                	mov    %ebx,%ecx
  801f1c:	e9 62 ff ff ff       	jmp    801e83 <__umoddi3+0xb3>
