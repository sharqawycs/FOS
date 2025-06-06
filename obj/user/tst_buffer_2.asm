
obj/user/tst_buffer_2:     file format elf32-i386


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
  800031:	e8 11 09 00 00       	call   800947 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/*SHOULD be on User DATA not on the STACK*/
char arr[PAGE_SIZE*1024*14 + PAGE_SIZE];
//=========================================

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 6c             	sub    $0x6c,%esp



	/*[1] CHECK INITIAL WORKING SET*/
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800041:	a1 20 30 80 00       	mov    0x803020,%eax
  800046:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80004c:	8b 00                	mov    (%eax),%eax
  80004e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800051:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800054:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800059:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005e:	74 14                	je     800074 <_main+0x3c>
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	68 c0 23 80 00       	push   $0x8023c0
  800068:	6a 17                	push   $0x17
  80006a:	68 08 24 80 00       	push   $0x802408
  80006f:	e8 d5 09 00 00       	call   800a49 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800074:	a1 20 30 80 00       	mov    0x803020,%eax
  800079:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007f:	83 c0 0c             	add    $0xc,%eax
  800082:	8b 00                	mov    (%eax),%eax
  800084:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800087:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80008a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008f:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800094:	74 14                	je     8000aa <_main+0x72>
  800096:	83 ec 04             	sub    $0x4,%esp
  800099:	68 c0 23 80 00       	push   $0x8023c0
  80009e:	6a 18                	push   $0x18
  8000a0:	68 08 24 80 00       	push   $0x802408
  8000a5:	e8 9f 09 00 00       	call   800a49 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8000af:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b5:	83 c0 18             	add    $0x18,%eax
  8000b8:	8b 00                	mov    (%eax),%eax
  8000ba:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000bd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c5:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000ca:	74 14                	je     8000e0 <_main+0xa8>
  8000cc:	83 ec 04             	sub    $0x4,%esp
  8000cf:	68 c0 23 80 00       	push   $0x8023c0
  8000d4:	6a 19                	push   $0x19
  8000d6:	68 08 24 80 00       	push   $0x802408
  8000db:	e8 69 09 00 00       	call   800a49 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e5:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000eb:	83 c0 24             	add    $0x24,%eax
  8000ee:	8b 00                	mov    (%eax),%eax
  8000f0:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000f3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fb:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800100:	74 14                	je     800116 <_main+0xde>
  800102:	83 ec 04             	sub    $0x4,%esp
  800105:	68 c0 23 80 00       	push   $0x8023c0
  80010a:	6a 1a                	push   $0x1a
  80010c:	68 08 24 80 00       	push   $0x802408
  800111:	e8 33 09 00 00       	call   800a49 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800116:	a1 20 30 80 00       	mov    0x803020,%eax
  80011b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800121:	83 c0 30             	add    $0x30,%eax
  800124:	8b 00                	mov    (%eax),%eax
  800126:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800129:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80012c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800131:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800136:	74 14                	je     80014c <_main+0x114>
  800138:	83 ec 04             	sub    $0x4,%esp
  80013b:	68 c0 23 80 00       	push   $0x8023c0
  800140:	6a 1b                	push   $0x1b
  800142:	68 08 24 80 00       	push   $0x802408
  800147:	e8 fd 08 00 00       	call   800a49 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80014c:	a1 20 30 80 00       	mov    0x803020,%eax
  800151:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800157:	83 c0 3c             	add    $0x3c,%eax
  80015a:	8b 00                	mov    (%eax),%eax
  80015c:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80015f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800162:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800167:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016c:	74 14                	je     800182 <_main+0x14a>
  80016e:	83 ec 04             	sub    $0x4,%esp
  800171:	68 c0 23 80 00       	push   $0x8023c0
  800176:	6a 1c                	push   $0x1c
  800178:	68 08 24 80 00       	push   $0x802408
  80017d:	e8 c7 08 00 00       	call   800a49 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800182:	a1 20 30 80 00       	mov    0x803020,%eax
  800187:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018d:	83 c0 48             	add    $0x48,%eax
  800190:	8b 00                	mov    (%eax),%eax
  800192:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800195:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800198:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019d:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a2:	74 14                	je     8001b8 <_main+0x180>
  8001a4:	83 ec 04             	sub    $0x4,%esp
  8001a7:	68 c0 23 80 00       	push   $0x8023c0
  8001ac:	6a 1d                	push   $0x1d
  8001ae:	68 08 24 80 00       	push   $0x802408
  8001b3:	e8 91 08 00 00       	call   800a49 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bd:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c3:	83 c0 54             	add    $0x54,%eax
  8001c6:	8b 00                	mov    (%eax),%eax
  8001c8:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001cb:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d3:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d8:	74 14                	je     8001ee <_main+0x1b6>
  8001da:	83 ec 04             	sub    $0x4,%esp
  8001dd:	68 c0 23 80 00       	push   $0x8023c0
  8001e2:	6a 1e                	push   $0x1e
  8001e4:	68 08 24 80 00       	push   $0x802408
  8001e9:	e8 5b 08 00 00       	call   800a49 <_panic>
		//if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f9:	83 c0 60             	add    $0x60,%eax
  8001fc:	8b 00                	mov    (%eax),%eax
  8001fe:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800201:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800204:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800209:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020e:	74 14                	je     800224 <_main+0x1ec>
  800210:	83 ec 04             	sub    $0x4,%esp
  800213:	68 c0 23 80 00       	push   $0x8023c0
  800218:	6a 20                	push   $0x20
  80021a:	68 08 24 80 00       	push   $0x802408
  80021f:	e8 25 08 00 00       	call   800a49 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800224:	a1 20 30 80 00       	mov    0x803020,%eax
  800229:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022f:	83 c0 6c             	add    $0x6c,%eax
  800232:	8b 00                	mov    (%eax),%eax
  800234:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800237:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80023a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023f:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800244:	74 14                	je     80025a <_main+0x222>
  800246:	83 ec 04             	sub    $0x4,%esp
  800249:	68 c0 23 80 00       	push   $0x8023c0
  80024e:	6a 21                	push   $0x21
  800250:	68 08 24 80 00       	push   $0x802408
  800255:	e8 ef 07 00 00       	call   800a49 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80025a:	a1 20 30 80 00       	mov    0x803020,%eax
  80025f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800265:	83 c0 78             	add    $0x78,%eax
  800268:	8b 00                	mov    (%eax),%eax
  80026a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  80026d:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800270:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800275:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027a:	74 14                	je     800290 <_main+0x258>
  80027c:	83 ec 04             	sub    $0x4,%esp
  80027f:	68 c0 23 80 00       	push   $0x8023c0
  800284:	6a 22                	push   $0x22
  800286:	68 08 24 80 00       	push   $0x802408
  80028b:	e8 b9 07 00 00       	call   800a49 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  800290:	a1 20 30 80 00       	mov    0x803020,%eax
  800295:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  80029b:	85 c0                	test   %eax,%eax
  80029d:	74 14                	je     8002b3 <_main+0x27b>
  80029f:	83 ec 04             	sub    $0x4,%esp
  8002a2:	68 1c 24 80 00       	push   $0x80241c
  8002a7:	6a 23                	push   $0x23
  8002a9:	68 08 24 80 00       	push   $0x802408
  8002ae:	e8 96 07 00 00       	call   800a49 <_panic>

	/*[2] RUN THE SLAVE PROGRAM*/

	//****************************************************************************************************************
	//IMP: program name is placed statically on the stack to avoid PAGE FAULT on it during the sys call inside the Kernel
	char slaveProgName[10] = "tpb2slave";
  8002b3:	8d 45 92             	lea    -0x6e(%ebp),%eax
  8002b6:	bb a3 27 80 00       	mov    $0x8027a3,%ebx
  8002bb:	ba 0a 00 00 00       	mov    $0xa,%edx
  8002c0:	89 c7                	mov    %eax,%edi
  8002c2:	89 de                	mov    %ebx,%esi
  8002c4:	89 d1                	mov    %edx,%ecx
  8002c6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	//****************************************************************************************************************

	int32 envIdSlave = sys_create_env(slaveProgName, (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8002c8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002cd:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8002d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d8:	8b 40 74             	mov    0x74(%eax),%eax
  8002db:	83 ec 04             	sub    $0x4,%esp
  8002de:	52                   	push   %edx
  8002df:	50                   	push   %eax
  8002e0:	8d 45 92             	lea    -0x6e(%ebp),%eax
  8002e3:	50                   	push   %eax
  8002e4:	e8 5f 1b 00 00       	call   801e48 <sys_create_env>
  8002e9:	83 c4 10             	add    $0x10,%esp
  8002ec:	89 45 b0             	mov    %eax,-0x50(%ebp)
	int initModBufCnt = sys_calculate_modified_frames();
  8002ef:	e8 18 19 00 00       	call   801c0c <sys_calculate_modified_frames>
  8002f4:	89 45 ac             	mov    %eax,-0x54(%ebp)
	sys_run_env(envIdSlave);
  8002f7:	83 ec 0c             	sub    $0xc,%esp
  8002fa:	ff 75 b0             	pushl  -0x50(%ebp)
  8002fd:	e8 63 1b 00 00       	call   801e65 <sys_run_env>
  800302:	83 c4 10             	add    $0x10,%esp

	/*[3] BUSY-WAIT FOR A WHILE TILL FINISHING IT*/
	env_sleep(5000);
  800305:	83 ec 0c             	sub    $0xc,%esp
  800308:	68 88 13 00 00       	push   $0x1388
  80030d:	e8 8f 1d 00 00       	call   8020a1 <env_sleep>
  800312:	83 c4 10             	add    $0x10,%esp


	//NOW: modified list contains 7 pages from the slave program
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames of the slave ... WRONG number of buffered pages in MODIFIED frame list");
  800315:	e8 f2 18 00 00       	call   801c0c <sys_calculate_modified_frames>
  80031a:	89 c2                	mov    %eax,%edx
  80031c:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80031f:	29 c2                	sub    %eax,%edx
  800321:	89 d0                	mov    %edx,%eax
  800323:	83 f8 07             	cmp    $0x7,%eax
  800326:	74 14                	je     80033c <_main+0x304>
  800328:	83 ec 04             	sub    $0x4,%esp
  80032b:	68 6c 24 80 00       	push   $0x80246c
  800330:	6a 36                	push   $0x36
  800332:	68 08 24 80 00       	push   $0x802408
  800337:	e8 0d 07 00 00       	call   800a49 <_panic>


	/*START OF TST_BUFFER_2*/
	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80033c:	e8 35 19 00 00       	call   801c76 <sys_pf_calculate_allocated_pages>
  800341:	89 45 a8             	mov    %eax,-0x58(%ebp)
	int freePages = sys_calculate_free_frames();
  800344:	e8 aa 18 00 00       	call   801bf3 <sys_calculate_free_frames>
  800349:	89 45 a4             	mov    %eax,-0x5c(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  80034c:	e8 bb 18 00 00       	call   801c0c <sys_calculate_modified_frames>
  800351:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int initFreeBufCnt = sys_calculate_notmod_frames();
  800354:	e8 cc 18 00 00       	call   801c25 <sys_calculate_notmod_frames>
  800359:	89 45 a0             	mov    %eax,-0x60(%ebp)
	int dummy = 0;
  80035c:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%ebp)
	//Fault #1
	int i=0;
  800363:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for(;i<1;i++)
  80036a:	eb 0e                	jmp    80037a <_main+0x342>
	{
		arr[i] = -1;
  80036c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80036f:	05 40 30 80 00       	add    $0x803040,%eax
  800374:	c6 00 ff             	movb   $0xff,(%eax)
	initModBufCnt = sys_calculate_modified_frames();
	int initFreeBufCnt = sys_calculate_notmod_frames();
	int dummy = 0;
	//Fault #1
	int i=0;
	for(;i<1;i++)
  800377:	ff 45 e4             	incl   -0x1c(%ebp)
  80037a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80037e:	7e ec                	jle    80036c <_main+0x334>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800380:	e8 a0 18 00 00       	call   801c25 <sys_calculate_notmod_frames>
  800385:	89 c2                	mov    %eax,%edx
  800387:	a1 20 30 80 00       	mov    0x803020,%eax
  80038c:	8b 40 4c             	mov    0x4c(%eax),%eax
  80038f:	01 d0                	add    %edx,%eax
  800391:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #2
	i=PAGE_SIZE*1024;
  800394:	c7 45 e4 00 00 40 00 	movl   $0x400000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024+1;i++)
  80039b:	eb 0e                	jmp    8003ab <_main+0x373>
	{
		arr[i] = -1;
  80039d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003a0:	05 40 30 80 00       	add    $0x803040,%eax
  8003a5:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #2
	i=PAGE_SIZE*1024;
	for(;i<PAGE_SIZE*1024+1;i++)
  8003a8:	ff 45 e4             	incl   -0x1c(%ebp)
  8003ab:	81 7d e4 00 00 40 00 	cmpl   $0x400000,-0x1c(%ebp)
  8003b2:	7e e9                	jle    80039d <_main+0x365>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8003b4:	e8 6c 18 00 00       	call   801c25 <sys_calculate_notmod_frames>
  8003b9:	89 c2                	mov    %eax,%edx
  8003bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c0:	8b 40 4c             	mov    0x4c(%eax),%eax
  8003c3:	01 d0                	add    %edx,%eax
  8003c5:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #3
	i=PAGE_SIZE*1024*2;
  8003c8:	c7 45 e4 00 00 80 00 	movl   $0x800000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*2+1;i++)
  8003cf:	eb 0e                	jmp    8003df <_main+0x3a7>
	{
		arr[i] = -1;
  8003d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003d4:	05 40 30 80 00       	add    $0x803040,%eax
  8003d9:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #3
	i=PAGE_SIZE*1024*2;
	for(;i<PAGE_SIZE*1024*2+1;i++)
  8003dc:	ff 45 e4             	incl   -0x1c(%ebp)
  8003df:	81 7d e4 00 00 80 00 	cmpl   $0x800000,-0x1c(%ebp)
  8003e6:	7e e9                	jle    8003d1 <_main+0x399>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8003e8:	e8 38 18 00 00       	call   801c25 <sys_calculate_notmod_frames>
  8003ed:	89 c2                	mov    %eax,%edx
  8003ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f4:	8b 40 4c             	mov    0x4c(%eax),%eax
  8003f7:	01 d0                	add    %edx,%eax
  8003f9:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #4
	i=PAGE_SIZE*1024*3;
  8003fc:	c7 45 e4 00 00 c0 00 	movl   $0xc00000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*3+1;i++)
  800403:	eb 0e                	jmp    800413 <_main+0x3db>
	{
		arr[i] = -1;
  800405:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800408:	05 40 30 80 00       	add    $0x803040,%eax
  80040d:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #4
	i=PAGE_SIZE*1024*3;
	for(;i<PAGE_SIZE*1024*3+1;i++)
  800410:	ff 45 e4             	incl   -0x1c(%ebp)
  800413:	81 7d e4 00 00 c0 00 	cmpl   $0xc00000,-0x1c(%ebp)
  80041a:	7e e9                	jle    800405 <_main+0x3cd>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  80041c:	e8 04 18 00 00       	call   801c25 <sys_calculate_notmod_frames>
  800421:	89 c2                	mov    %eax,%edx
  800423:	a1 20 30 80 00       	mov    0x803020,%eax
  800428:	8b 40 4c             	mov    0x4c(%eax),%eax
  80042b:	01 d0                	add    %edx,%eax
  80042d:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #5
	i=PAGE_SIZE*1024*4;
  800430:	c7 45 e4 00 00 00 01 	movl   $0x1000000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*4+1;i++)
  800437:	eb 0e                	jmp    800447 <_main+0x40f>
	{
		arr[i] = -1;
  800439:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80043c:	05 40 30 80 00       	add    $0x803040,%eax
  800441:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #5
	i=PAGE_SIZE*1024*4;
	for(;i<PAGE_SIZE*1024*4+1;i++)
  800444:	ff 45 e4             	incl   -0x1c(%ebp)
  800447:	81 7d e4 00 00 00 01 	cmpl   $0x1000000,-0x1c(%ebp)
  80044e:	7e e9                	jle    800439 <_main+0x401>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800450:	e8 d0 17 00 00       	call   801c25 <sys_calculate_notmod_frames>
  800455:	89 c2                	mov    %eax,%edx
  800457:	a1 20 30 80 00       	mov    0x803020,%eax
  80045c:	8b 40 4c             	mov    0x4c(%eax),%eax
  80045f:	01 d0                	add    %edx,%eax
  800461:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #6
	i=PAGE_SIZE*1024*5;
  800464:	c7 45 e4 00 00 40 01 	movl   $0x1400000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*5+1;i++)
  80046b:	eb 0e                	jmp    80047b <_main+0x443>
	{
		arr[i] = -1;
  80046d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800470:	05 40 30 80 00       	add    $0x803040,%eax
  800475:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #6
	i=PAGE_SIZE*1024*5;
	for(;i<PAGE_SIZE*1024*5+1;i++)
  800478:	ff 45 e4             	incl   -0x1c(%ebp)
  80047b:	81 7d e4 00 00 40 01 	cmpl   $0x1400000,-0x1c(%ebp)
  800482:	7e e9                	jle    80046d <_main+0x435>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800484:	e8 9c 17 00 00       	call   801c25 <sys_calculate_notmod_frames>
  800489:	89 c2                	mov    %eax,%edx
  80048b:	a1 20 30 80 00       	mov    0x803020,%eax
  800490:	8b 40 4c             	mov    0x4c(%eax),%eax
  800493:	01 d0                	add    %edx,%eax
  800495:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #7
	i=PAGE_SIZE*1024*6;
  800498:	c7 45 e4 00 00 80 01 	movl   $0x1800000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*6+1;i++)
  80049f:	eb 0e                	jmp    8004af <_main+0x477>
	{
		arr[i] = -1;
  8004a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8004a4:	05 40 30 80 00       	add    $0x803040,%eax
  8004a9:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #7
	i=PAGE_SIZE*1024*6;
	for(;i<PAGE_SIZE*1024*6+1;i++)
  8004ac:	ff 45 e4             	incl   -0x1c(%ebp)
  8004af:	81 7d e4 00 00 80 01 	cmpl   $0x1800000,-0x1c(%ebp)
  8004b6:	7e e9                	jle    8004a1 <_main+0x469>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8004b8:	e8 68 17 00 00       	call   801c25 <sys_calculate_notmod_frames>
  8004bd:	89 c2                	mov    %eax,%edx
  8004bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c4:	8b 40 4c             	mov    0x4c(%eax),%eax
  8004c7:	01 d0                	add    %edx,%eax
  8004c9:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #8
	i=PAGE_SIZE*1024*7;
  8004cc:	c7 45 e4 00 00 c0 01 	movl   $0x1c00000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*7+1;i++)
  8004d3:	eb 0e                	jmp    8004e3 <_main+0x4ab>
	{
		arr[i] = -1;
  8004d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8004d8:	05 40 30 80 00       	add    $0x803040,%eax
  8004dd:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #8
	i=PAGE_SIZE*1024*7;
	for(;i<PAGE_SIZE*1024*7+1;i++)
  8004e0:	ff 45 e4             	incl   -0x1c(%ebp)
  8004e3:	81 7d e4 00 00 c0 01 	cmpl   $0x1c00000,-0x1c(%ebp)
  8004ea:	7e e9                	jle    8004d5 <_main+0x49d>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8004ec:	e8 34 17 00 00       	call   801c25 <sys_calculate_notmod_frames>
  8004f1:	89 c2                	mov    %eax,%edx
  8004f3:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f8:	8b 40 4c             	mov    0x4c(%eax),%eax
  8004fb:	01 d0                	add    %edx,%eax
  8004fd:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//TILL NOW: 8 pages were brought into MEM and be modified (7 unmodified should be buffered)
	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)
  800500:	e8 20 17 00 00       	call   801c25 <sys_calculate_notmod_frames>
  800505:	89 c2                	mov    %eax,%edx
  800507:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80050a:	29 c2                	sub    %eax,%edx
  80050c:	89 d0                	mov    %edx,%eax
  80050e:	83 f8 07             	cmp    $0x7,%eax
  800511:	74 31                	je     800544 <_main+0x50c>
	{
		sys_env_destroy(envIdSlave);
  800513:	83 ec 0c             	sub    $0xc,%esp
  800516:	ff 75 b0             	pushl  -0x50(%ebp)
  800519:	e8 d6 15 00 00       	call   801af4 <sys_env_destroy>
  80051e:	83 c4 10             	add    $0x10,%esp
		panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list %d",sys_calculate_notmod_frames()  - initFreeBufCnt);
  800521:	e8 ff 16 00 00       	call   801c25 <sys_calculate_notmod_frames>
  800526:	89 c2                	mov    %eax,%edx
  800528:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80052b:	29 c2                	sub    %eax,%edx
  80052d:	89 d0                	mov    %edx,%eax
  80052f:	50                   	push   %eax
  800530:	68 e4 24 80 00       	push   $0x8024e4
  800535:	68 83 00 00 00       	push   $0x83
  80053a:	68 08 24 80 00       	push   $0x802408
  80053f:	e8 05 05 00 00       	call   800a49 <_panic>
	}
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)
  800544:	e8 c3 16 00 00       	call   801c0c <sys_calculate_modified_frames>
  800549:	89 c2                	mov    %eax,%edx
  80054b:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80054e:	39 c2                	cmp    %eax,%edx
  800550:	74 25                	je     800577 <_main+0x53f>
	{
		sys_env_destroy(envIdSlave);
  800552:	83 ec 0c             	sub    $0xc,%esp
  800555:	ff 75 b0             	pushl  -0x50(%ebp)
  800558:	e8 97 15 00 00       	call   801af4 <sys_env_destroy>
  80055d:	83 c4 10             	add    $0x10,%esp
		panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800560:	83 ec 04             	sub    $0x4,%esp
  800563:	68 48 25 80 00       	push   $0x802548
  800568:	68 88 00 00 00       	push   $0x88
  80056d:	68 08 24 80 00       	push   $0x802408
  800572:	e8 d2 04 00 00       	call   800a49 <_panic>
	}

	initFreeBufCnt = sys_calculate_notmod_frames();
  800577:	e8 a9 16 00 00       	call   801c25 <sys_calculate_notmod_frames>
  80057c:	89 45 a0             	mov    %eax,-0x60(%ebp)

	//The following 7 faults should victimize the 7 previously modified pages
	//(i.e. the modified list should be freed after 3 faults... then, two modified frames will be added to it again)
	//Fault #7
	i=PAGE_SIZE*1024*8;
  80057f:	c7 45 e4 00 00 00 02 	movl   $0x2000000,-0x1c(%ebp)
	int s = 0;
  800586:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(;i<PAGE_SIZE*1024*8+1;i++)
  80058d:	eb 13                	jmp    8005a2 <_main+0x56a>
	{
		s += arr[i] ;
  80058f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800592:	05 40 30 80 00       	add    $0x803040,%eax
  800597:	8a 00                	mov    (%eax),%al
  800599:	0f be c0             	movsbl %al,%eax
  80059c:	01 45 e0             	add    %eax,-0x20(%ebp)
	//The following 7 faults should victimize the 7 previously modified pages
	//(i.e. the modified list should be freed after 3 faults... then, two modified frames will be added to it again)
	//Fault #7
	i=PAGE_SIZE*1024*8;
	int s = 0;
	for(;i<PAGE_SIZE*1024*8+1;i++)
  80059f:	ff 45 e4             	incl   -0x1c(%ebp)
  8005a2:	81 7d e4 00 00 00 02 	cmpl   $0x2000000,-0x1c(%ebp)
  8005a9:	7e e4                	jle    80058f <_main+0x557>
	{
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8005ab:	e8 75 16 00 00       	call   801c25 <sys_calculate_notmod_frames>
  8005b0:	89 c2                	mov    %eax,%edx
  8005b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8005b7:	8b 40 4c             	mov    0x4c(%eax),%eax
  8005ba:	01 d0                	add    %edx,%eax
  8005bc:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #8
	i=PAGE_SIZE*1024*9;
  8005bf:	c7 45 e4 00 00 40 02 	movl   $0x2400000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*9+1;i++)
  8005c6:	eb 13                	jmp    8005db <_main+0x5a3>
	{
		s += arr[i] ;
  8005c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005cb:	05 40 30 80 00       	add    $0x803040,%eax
  8005d0:	8a 00                	mov    (%eax),%al
  8005d2:	0f be c0             	movsbl %al,%eax
  8005d5:	01 45 e0             	add    %eax,-0x20(%ebp)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #8
	i=PAGE_SIZE*1024*9;
	for(;i<PAGE_SIZE*1024*9+1;i++)
  8005d8:	ff 45 e4             	incl   -0x1c(%ebp)
  8005db:	81 7d e4 00 00 40 02 	cmpl   $0x2400000,-0x1c(%ebp)
  8005e2:	7e e4                	jle    8005c8 <_main+0x590>
	{
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8005e4:	e8 3c 16 00 00       	call   801c25 <sys_calculate_notmod_frames>
  8005e9:	89 c2                	mov    %eax,%edx
  8005eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f0:	8b 40 4c             	mov    0x4c(%eax),%eax
  8005f3:	01 d0                	add    %edx,%eax
  8005f5:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #9
	i=PAGE_SIZE*1024*10;
  8005f8:	c7 45 e4 00 00 80 02 	movl   $0x2800000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*10+1;i++)
  8005ff:	eb 13                	jmp    800614 <_main+0x5dc>
	{
		s += arr[i] ;
  800601:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800604:	05 40 30 80 00       	add    $0x803040,%eax
  800609:	8a 00                	mov    (%eax),%al
  80060b:	0f be c0             	movsbl %al,%eax
  80060e:	01 45 e0             	add    %eax,-0x20(%ebp)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #9
	i=PAGE_SIZE*1024*10;
	for(;i<PAGE_SIZE*1024*10+1;i++)
  800611:	ff 45 e4             	incl   -0x1c(%ebp)
  800614:	81 7d e4 00 00 80 02 	cmpl   $0x2800000,-0x1c(%ebp)
  80061b:	7e e4                	jle    800601 <_main+0x5c9>
	{
		s += arr[i] ;
	}

	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  80061d:	e8 03 16 00 00       	call   801c25 <sys_calculate_notmod_frames>
  800622:	89 c2                	mov    %eax,%edx
  800624:	a1 20 30 80 00       	mov    0x803020,%eax
  800629:	8b 40 4c             	mov    0x4c(%eax),%eax
  80062c:	01 d0                	add    %edx,%eax
  80062e:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//HERE: modified list should be freed
	if (sys_calculate_modified_frames() != 0)
  800631:	e8 d6 15 00 00       	call   801c0c <sys_calculate_modified_frames>
  800636:	85 c0                	test   %eax,%eax
  800638:	74 25                	je     80065f <_main+0x627>
	{
		sys_env_destroy(envIdSlave);
  80063a:	83 ec 0c             	sub    $0xc,%esp
  80063d:	ff 75 b0             	pushl  -0x50(%ebp)
  800640:	e8 af 14 00 00       	call   801af4 <sys_env_destroy>
  800645:	83 c4 10             	add    $0x10,%esp
		panic("Modified frames not removed from list (or not updated) correctly when the modified list reaches MAX");
  800648:	83 ec 04             	sub    $0x4,%esp
  80064b:	68 b4 25 80 00       	push   $0x8025b4
  800650:	68 ad 00 00 00       	push   $0xad
  800655:	68 08 24 80 00       	push   $0x802408
  80065a:	e8 ea 03 00 00       	call   800a49 <_panic>
	}
	if ((sys_calculate_notmod_frames() - initFreeBufCnt) != 10)
  80065f:	e8 c1 15 00 00       	call   801c25 <sys_calculate_notmod_frames>
  800664:	89 c2                	mov    %eax,%edx
  800666:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800669:	29 c2                	sub    %eax,%edx
  80066b:	89 d0                	mov    %edx,%eax
  80066d:	83 f8 0a             	cmp    $0xa,%eax
  800670:	74 25                	je     800697 <_main+0x65f>
	{
		sys_env_destroy(envIdSlave);
  800672:	83 ec 0c             	sub    $0xc,%esp
  800675:	ff 75 b0             	pushl  -0x50(%ebp)
  800678:	e8 77 14 00 00       	call   801af4 <sys_env_destroy>
  80067d:	83 c4 10             	add    $0x10,%esp
		panic("Modified frames not added to free frame list as BUFFERED when the modified list reaches MAX");
  800680:	83 ec 04             	sub    $0x4,%esp
  800683:	68 18 26 80 00       	push   $0x802618
  800688:	68 b2 00 00 00       	push   $0xb2
  80068d:	68 08 24 80 00       	push   $0x802408
  800692:	e8 b2 03 00 00       	call   800a49 <_panic>
	}

	//Three additional fault (i.e. three modified page will be added to modified list)
	//Fault #10
	i = PAGE_SIZE * 1024 * 11;
  800697:	c7 45 e4 00 00 c0 02 	movl   $0x2c00000,-0x1c(%ebp)
	for (; i < PAGE_SIZE * 1024*11 + 1; i++) {
  80069e:	eb 13                	jmp    8006b3 <_main+0x67b>
		s += arr[i] ;
  8006a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006a3:	05 40 30 80 00       	add    $0x803040,%eax
  8006a8:	8a 00                	mov    (%eax),%al
  8006aa:	0f be c0             	movsbl %al,%eax
  8006ad:	01 45 e0             	add    %eax,-0x20(%ebp)
	}

	//Three additional fault (i.e. three modified page will be added to modified list)
	//Fault #10
	i = PAGE_SIZE * 1024 * 11;
	for (; i < PAGE_SIZE * 1024*11 + 1; i++) {
  8006b0:	ff 45 e4             	incl   -0x1c(%ebp)
  8006b3:	81 7d e4 00 00 c0 02 	cmpl   $0x2c00000,-0x1c(%ebp)
  8006ba:	7e e4                	jle    8006a0 <_main+0x668>
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8006bc:	e8 64 15 00 00       	call   801c25 <sys_calculate_notmod_frames>
  8006c1:	89 c2                	mov    %eax,%edx
  8006c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8006c8:	8b 40 4c             	mov    0x4c(%eax),%eax
  8006cb:	01 d0                	add    %edx,%eax
  8006cd:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #11
	i = PAGE_SIZE * 1024 * 12;
  8006d0:	c7 45 e4 00 00 00 03 	movl   $0x3000000,-0x1c(%ebp)
	for (; i < PAGE_SIZE * 1024*12 + 1; i++) {
  8006d7:	eb 13                	jmp    8006ec <_main+0x6b4>
		s += arr[i] ;
  8006d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006dc:	05 40 30 80 00       	add    $0x803040,%eax
  8006e1:	8a 00                	mov    (%eax),%al
  8006e3:	0f be c0             	movsbl %al,%eax
  8006e6:	01 45 e0             	add    %eax,-0x20(%ebp)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #11
	i = PAGE_SIZE * 1024 * 12;
	for (; i < PAGE_SIZE * 1024*12 + 1; i++) {
  8006e9:	ff 45 e4             	incl   -0x1c(%ebp)
  8006ec:	81 7d e4 00 00 00 03 	cmpl   $0x3000000,-0x1c(%ebp)
  8006f3:	7e e4                	jle    8006d9 <_main+0x6a1>
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8006f5:	e8 2b 15 00 00       	call   801c25 <sys_calculate_notmod_frames>
  8006fa:	89 c2                	mov    %eax,%edx
  8006fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800701:	8b 40 4c             	mov    0x4c(%eax),%eax
  800704:	01 d0                	add    %edx,%eax
  800706:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #12
	i = PAGE_SIZE * 1024 * 13;
  800709:	c7 45 e4 00 00 40 03 	movl   $0x3400000,-0x1c(%ebp)
	for (; i < PAGE_SIZE * 1024*13 + 1; i++) {
  800710:	eb 13                	jmp    800725 <_main+0x6ed>
		s += arr[i] ;
  800712:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800715:	05 40 30 80 00       	add    $0x803040,%eax
  80071a:	8a 00                	mov    (%eax),%al
  80071c:	0f be c0             	movsbl %al,%eax
  80071f:	01 45 e0             	add    %eax,-0x20(%ebp)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #12
	i = PAGE_SIZE * 1024 * 13;
	for (; i < PAGE_SIZE * 1024*13 + 1; i++) {
  800722:	ff 45 e4             	incl   -0x1c(%ebp)
  800725:	81 7d e4 00 00 40 03 	cmpl   $0x3400000,-0x1c(%ebp)
  80072c:	7e e4                	jle    800712 <_main+0x6da>
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  80072e:	e8 f2 14 00 00       	call   801c25 <sys_calculate_notmod_frames>
  800733:	89 c2                	mov    %eax,%edx
  800735:	a1 20 30 80 00       	mov    0x803020,%eax
  80073a:	8b 40 4c             	mov    0x4c(%eax),%eax
  80073d:	01 d0                	add    %edx,%eax
  80073f:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//cprintf("testing...\n");
	{
		if (sys_calculate_modified_frames() != 3)
  800742:	e8 c5 14 00 00       	call   801c0c <sys_calculate_modified_frames>
  800747:	83 f8 03             	cmp    $0x3,%eax
  80074a:	74 25                	je     800771 <_main+0x739>
		{
			sys_env_destroy(envIdSlave);
  80074c:	83 ec 0c             	sub    $0xc,%esp
  80074f:	ff 75 b0             	pushl  -0x50(%ebp)
  800752:	e8 9d 13 00 00       	call   801af4 <sys_env_destroy>
  800757:	83 c4 10             	add    $0x10,%esp
			panic("Modified frames not removed from list (or not updated) correctly when the modified list reaches MAX");
  80075a:	83 ec 04             	sub    $0x4,%esp
  80075d:	68 b4 25 80 00       	push   $0x8025b4
  800762:	68 d0 00 00 00       	push   $0xd0
  800767:	68 08 24 80 00       	push   $0x802408
  80076c:	e8 d8 02 00 00       	call   800a49 <_panic>
		}

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0)
  800771:	e8 00 15 00 00       	call   801c76 <sys_pf_calculate_allocated_pages>
  800776:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  800779:	74 25                	je     8007a0 <_main+0x768>
		{
			sys_env_destroy(envIdSlave);
  80077b:	83 ec 0c             	sub    $0xc,%esp
  80077e:	ff 75 b0             	pushl  -0x50(%ebp)
  800781:	e8 6e 13 00 00       	call   801af4 <sys_env_destroy>
  800786:	83 c4 10             	add    $0x10,%esp
			panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  800789:	83 ec 04             	sub    $0x4,%esp
  80078c:	68 74 26 80 00       	push   $0x802674
  800791:	68 d6 00 00 00       	push   $0xd6
  800796:	68 08 24 80 00       	push   $0x802408
  80079b:	e8 a9 02 00 00       	call   800a49 <_panic>
		}

		if( arr[0] != -1) 						{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  8007a0:	a0 40 30 80 00       	mov    0x803040,%al
  8007a5:	3c ff                	cmp    $0xff,%al
  8007a7:	74 25                	je     8007ce <_main+0x796>
  8007a9:	83 ec 0c             	sub    $0xc,%esp
  8007ac:	ff 75 b0             	pushl  -0x50(%ebp)
  8007af:	e8 40 13 00 00       	call   801af4 <sys_env_destroy>
  8007b4:	83 c4 10             	add    $0x10,%esp
  8007b7:	83 ec 04             	sub    $0x4,%esp
  8007ba:	68 e0 26 80 00       	push   $0x8026e0
  8007bf:	68 d9 00 00 00       	push   $0xd9
  8007c4:	68 08 24 80 00       	push   $0x802408
  8007c9:	e8 7b 02 00 00       	call   800a49 <_panic>
		if( arr[PAGE_SIZE * 1024 * 1] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  8007ce:	a0 40 30 c0 00       	mov    0xc03040,%al
  8007d3:	3c ff                	cmp    $0xff,%al
  8007d5:	74 25                	je     8007fc <_main+0x7c4>
  8007d7:	83 ec 0c             	sub    $0xc,%esp
  8007da:	ff 75 b0             	pushl  -0x50(%ebp)
  8007dd:	e8 12 13 00 00       	call   801af4 <sys_env_destroy>
  8007e2:	83 c4 10             	add    $0x10,%esp
  8007e5:	83 ec 04             	sub    $0x4,%esp
  8007e8:	68 e0 26 80 00       	push   $0x8026e0
  8007ed:	68 da 00 00 00       	push   $0xda
  8007f2:	68 08 24 80 00       	push   $0x802408
  8007f7:	e8 4d 02 00 00       	call   800a49 <_panic>
		if( arr[PAGE_SIZE * 1024 * 2] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  8007fc:	a0 40 30 00 01       	mov    0x1003040,%al
  800801:	3c ff                	cmp    $0xff,%al
  800803:	74 25                	je     80082a <_main+0x7f2>
  800805:	83 ec 0c             	sub    $0xc,%esp
  800808:	ff 75 b0             	pushl  -0x50(%ebp)
  80080b:	e8 e4 12 00 00       	call   801af4 <sys_env_destroy>
  800810:	83 c4 10             	add    $0x10,%esp
  800813:	83 ec 04             	sub    $0x4,%esp
  800816:	68 e0 26 80 00       	push   $0x8026e0
  80081b:	68 db 00 00 00       	push   $0xdb
  800820:	68 08 24 80 00       	push   $0x802408
  800825:	e8 1f 02 00 00       	call   800a49 <_panic>
		if( arr[PAGE_SIZE * 1024 * 3] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  80082a:	a0 40 30 40 01       	mov    0x1403040,%al
  80082f:	3c ff                	cmp    $0xff,%al
  800831:	74 25                	je     800858 <_main+0x820>
  800833:	83 ec 0c             	sub    $0xc,%esp
  800836:	ff 75 b0             	pushl  -0x50(%ebp)
  800839:	e8 b6 12 00 00       	call   801af4 <sys_env_destroy>
  80083e:	83 c4 10             	add    $0x10,%esp
  800841:	83 ec 04             	sub    $0x4,%esp
  800844:	68 e0 26 80 00       	push   $0x8026e0
  800849:	68 dc 00 00 00       	push   $0xdc
  80084e:	68 08 24 80 00       	push   $0x802408
  800853:	e8 f1 01 00 00       	call   800a49 <_panic>
		if( arr[PAGE_SIZE * 1024 * 4] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  800858:	a0 40 30 80 01       	mov    0x1803040,%al
  80085d:	3c ff                	cmp    $0xff,%al
  80085f:	74 25                	je     800886 <_main+0x84e>
  800861:	83 ec 0c             	sub    $0xc,%esp
  800864:	ff 75 b0             	pushl  -0x50(%ebp)
  800867:	e8 88 12 00 00       	call   801af4 <sys_env_destroy>
  80086c:	83 c4 10             	add    $0x10,%esp
  80086f:	83 ec 04             	sub    $0x4,%esp
  800872:	68 e0 26 80 00       	push   $0x8026e0
  800877:	68 dd 00 00 00       	push   $0xdd
  80087c:	68 08 24 80 00       	push   $0x802408
  800881:	e8 c3 01 00 00       	call   800a49 <_panic>
		if( arr[PAGE_SIZE * 1024 * 5] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  800886:	a0 40 30 c0 01       	mov    0x1c03040,%al
  80088b:	3c ff                	cmp    $0xff,%al
  80088d:	74 25                	je     8008b4 <_main+0x87c>
  80088f:	83 ec 0c             	sub    $0xc,%esp
  800892:	ff 75 b0             	pushl  -0x50(%ebp)
  800895:	e8 5a 12 00 00       	call   801af4 <sys_env_destroy>
  80089a:	83 c4 10             	add    $0x10,%esp
  80089d:	83 ec 04             	sub    $0x4,%esp
  8008a0:	68 e0 26 80 00       	push   $0x8026e0
  8008a5:	68 de 00 00 00       	push   $0xde
  8008aa:	68 08 24 80 00       	push   $0x802408
  8008af:	e8 95 01 00 00       	call   800a49 <_panic>
		if( arr[PAGE_SIZE * 1024 * 6] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  8008b4:	a0 40 30 00 02       	mov    0x2003040,%al
  8008b9:	3c ff                	cmp    $0xff,%al
  8008bb:	74 25                	je     8008e2 <_main+0x8aa>
  8008bd:	83 ec 0c             	sub    $0xc,%esp
  8008c0:	ff 75 b0             	pushl  -0x50(%ebp)
  8008c3:	e8 2c 12 00 00       	call   801af4 <sys_env_destroy>
  8008c8:	83 c4 10             	add    $0x10,%esp
  8008cb:	83 ec 04             	sub    $0x4,%esp
  8008ce:	68 e0 26 80 00       	push   $0x8026e0
  8008d3:	68 df 00 00 00       	push   $0xdf
  8008d8:	68 08 24 80 00       	push   $0x802408
  8008dd:	e8 67 01 00 00       	call   800a49 <_panic>
		if( arr[PAGE_SIZE * 1024 * 7] != -1) 	{sys_env_destroy(envIdSlave);panic("modified page not updated on page file OR not reclaimed correctly");}
  8008e2:	a0 40 30 40 02       	mov    0x2403040,%al
  8008e7:	3c ff                	cmp    $0xff,%al
  8008e9:	74 25                	je     800910 <_main+0x8d8>
  8008eb:	83 ec 0c             	sub    $0xc,%esp
  8008ee:	ff 75 b0             	pushl  -0x50(%ebp)
  8008f1:	e8 fe 11 00 00       	call   801af4 <sys_env_destroy>
  8008f6:	83 c4 10             	add    $0x10,%esp
  8008f9:	83 ec 04             	sub    $0x4,%esp
  8008fc:	68 e0 26 80 00       	push   $0x8026e0
  800901:	68 e0 00 00 00       	push   $0xe0
  800906:	68 08 24 80 00       	push   $0x802408
  80090b:	e8 39 01 00 00       	call   800a49 <_panic>

		if (sys_calculate_modified_frames() != 0) {sys_env_destroy(envIdSlave);panic("Modified frames not removed from list (or isModified/modified bit is not updated) correctly when the modified list reaches MAX");}
  800910:	e8 f7 12 00 00       	call   801c0c <sys_calculate_modified_frames>
  800915:	85 c0                	test   %eax,%eax
  800917:	74 25                	je     80093e <_main+0x906>
  800919:	83 ec 0c             	sub    $0xc,%esp
  80091c:	ff 75 b0             	pushl  -0x50(%ebp)
  80091f:	e8 d0 11 00 00       	call   801af4 <sys_env_destroy>
  800924:	83 c4 10             	add    $0x10,%esp
  800927:	83 ec 04             	sub    $0x4,%esp
  80092a:	68 24 27 80 00       	push   $0x802724
  80092f:	68 e2 00 00 00       	push   $0xe2
  800934:	68 08 24 80 00       	push   $0x802408
  800939:	e8 0b 01 00 00       	call   800a49 <_panic>
	}

	return;
  80093e:	90                   	nop
}
  80093f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800942:	5b                   	pop    %ebx
  800943:	5e                   	pop    %esi
  800944:	5f                   	pop    %edi
  800945:	5d                   	pop    %ebp
  800946:	c3                   	ret    

00800947 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800947:	55                   	push   %ebp
  800948:	89 e5                	mov    %esp,%ebp
  80094a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80094d:	e8 d6 11 00 00       	call   801b28 <sys_getenvindex>
  800952:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800955:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800958:	89 d0                	mov    %edx,%eax
  80095a:	01 c0                	add    %eax,%eax
  80095c:	01 d0                	add    %edx,%eax
  80095e:	c1 e0 02             	shl    $0x2,%eax
  800961:	01 d0                	add    %edx,%eax
  800963:	c1 e0 06             	shl    $0x6,%eax
  800966:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80096b:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800970:	a1 20 30 80 00       	mov    0x803020,%eax
  800975:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80097b:	84 c0                	test   %al,%al
  80097d:	74 0f                	je     80098e <libmain+0x47>
		binaryname = myEnv->prog_name;
  80097f:	a1 20 30 80 00       	mov    0x803020,%eax
  800984:	05 f4 02 00 00       	add    $0x2f4,%eax
  800989:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80098e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800992:	7e 0a                	jle    80099e <libmain+0x57>
		binaryname = argv[0];
  800994:	8b 45 0c             	mov    0xc(%ebp),%eax
  800997:	8b 00                	mov    (%eax),%eax
  800999:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80099e:	83 ec 08             	sub    $0x8,%esp
  8009a1:	ff 75 0c             	pushl  0xc(%ebp)
  8009a4:	ff 75 08             	pushl  0x8(%ebp)
  8009a7:	e8 8c f6 ff ff       	call   800038 <_main>
  8009ac:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8009af:	e8 0f 13 00 00       	call   801cc3 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8009b4:	83 ec 0c             	sub    $0xc,%esp
  8009b7:	68 c8 27 80 00       	push   $0x8027c8
  8009bc:	e8 3c 03 00 00       	call   800cfd <cprintf>
  8009c1:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8009c4:	a1 20 30 80 00       	mov    0x803020,%eax
  8009c9:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8009cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8009d4:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8009da:	83 ec 04             	sub    $0x4,%esp
  8009dd:	52                   	push   %edx
  8009de:	50                   	push   %eax
  8009df:	68 f0 27 80 00       	push   $0x8027f0
  8009e4:	e8 14 03 00 00       	call   800cfd <cprintf>
  8009e9:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8009ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8009f1:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8009f7:	83 ec 08             	sub    $0x8,%esp
  8009fa:	50                   	push   %eax
  8009fb:	68 15 28 80 00       	push   $0x802815
  800a00:	e8 f8 02 00 00       	call   800cfd <cprintf>
  800a05:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800a08:	83 ec 0c             	sub    $0xc,%esp
  800a0b:	68 c8 27 80 00       	push   $0x8027c8
  800a10:	e8 e8 02 00 00       	call   800cfd <cprintf>
  800a15:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800a18:	e8 c0 12 00 00       	call   801cdd <sys_enable_interrupt>

	// exit gracefully
	exit();
  800a1d:	e8 19 00 00 00       	call   800a3b <exit>
}
  800a22:	90                   	nop
  800a23:	c9                   	leave  
  800a24:	c3                   	ret    

00800a25 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800a25:	55                   	push   %ebp
  800a26:	89 e5                	mov    %esp,%ebp
  800a28:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800a2b:	83 ec 0c             	sub    $0xc,%esp
  800a2e:	6a 00                	push   $0x0
  800a30:	e8 bf 10 00 00       	call   801af4 <sys_env_destroy>
  800a35:	83 c4 10             	add    $0x10,%esp
}
  800a38:	90                   	nop
  800a39:	c9                   	leave  
  800a3a:	c3                   	ret    

00800a3b <exit>:

void
exit(void)
{
  800a3b:	55                   	push   %ebp
  800a3c:	89 e5                	mov    %esp,%ebp
  800a3e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800a41:	e8 14 11 00 00       	call   801b5a <sys_env_exit>
}
  800a46:	90                   	nop
  800a47:	c9                   	leave  
  800a48:	c3                   	ret    

00800a49 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800a49:	55                   	push   %ebp
  800a4a:	89 e5                	mov    %esp,%ebp
  800a4c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800a4f:	8d 45 10             	lea    0x10(%ebp),%eax
  800a52:	83 c0 04             	add    $0x4,%eax
  800a55:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800a58:	a1 48 40 00 04       	mov    0x4004048,%eax
  800a5d:	85 c0                	test   %eax,%eax
  800a5f:	74 16                	je     800a77 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800a61:	a1 48 40 00 04       	mov    0x4004048,%eax
  800a66:	83 ec 08             	sub    $0x8,%esp
  800a69:	50                   	push   %eax
  800a6a:	68 2c 28 80 00       	push   $0x80282c
  800a6f:	e8 89 02 00 00       	call   800cfd <cprintf>
  800a74:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800a77:	a1 00 30 80 00       	mov    0x803000,%eax
  800a7c:	ff 75 0c             	pushl  0xc(%ebp)
  800a7f:	ff 75 08             	pushl  0x8(%ebp)
  800a82:	50                   	push   %eax
  800a83:	68 31 28 80 00       	push   $0x802831
  800a88:	e8 70 02 00 00       	call   800cfd <cprintf>
  800a8d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800a90:	8b 45 10             	mov    0x10(%ebp),%eax
  800a93:	83 ec 08             	sub    $0x8,%esp
  800a96:	ff 75 f4             	pushl  -0xc(%ebp)
  800a99:	50                   	push   %eax
  800a9a:	e8 f3 01 00 00       	call   800c92 <vcprintf>
  800a9f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800aa2:	83 ec 08             	sub    $0x8,%esp
  800aa5:	6a 00                	push   $0x0
  800aa7:	68 4d 28 80 00       	push   $0x80284d
  800aac:	e8 e1 01 00 00       	call   800c92 <vcprintf>
  800ab1:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800ab4:	e8 82 ff ff ff       	call   800a3b <exit>

	// should not return here
	while (1) ;
  800ab9:	eb fe                	jmp    800ab9 <_panic+0x70>

00800abb <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800abb:	55                   	push   %ebp
  800abc:	89 e5                	mov    %esp,%ebp
  800abe:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800ac1:	a1 20 30 80 00       	mov    0x803020,%eax
  800ac6:	8b 50 74             	mov    0x74(%eax),%edx
  800ac9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acc:	39 c2                	cmp    %eax,%edx
  800ace:	74 14                	je     800ae4 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800ad0:	83 ec 04             	sub    $0x4,%esp
  800ad3:	68 50 28 80 00       	push   $0x802850
  800ad8:	6a 26                	push   $0x26
  800ada:	68 9c 28 80 00       	push   $0x80289c
  800adf:	e8 65 ff ff ff       	call   800a49 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800ae4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800aeb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800af2:	e9 c2 00 00 00       	jmp    800bb9 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800af7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800afa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800b01:	8b 45 08             	mov    0x8(%ebp),%eax
  800b04:	01 d0                	add    %edx,%eax
  800b06:	8b 00                	mov    (%eax),%eax
  800b08:	85 c0                	test   %eax,%eax
  800b0a:	75 08                	jne    800b14 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800b0c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800b0f:	e9 a2 00 00 00       	jmp    800bb6 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800b14:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b1b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800b22:	eb 69                	jmp    800b8d <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800b24:	a1 20 30 80 00       	mov    0x803020,%eax
  800b29:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b2f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b32:	89 d0                	mov    %edx,%eax
  800b34:	01 c0                	add    %eax,%eax
  800b36:	01 d0                	add    %edx,%eax
  800b38:	c1 e0 02             	shl    $0x2,%eax
  800b3b:	01 c8                	add    %ecx,%eax
  800b3d:	8a 40 04             	mov    0x4(%eax),%al
  800b40:	84 c0                	test   %al,%al
  800b42:	75 46                	jne    800b8a <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b44:	a1 20 30 80 00       	mov    0x803020,%eax
  800b49:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b4f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b52:	89 d0                	mov    %edx,%eax
  800b54:	01 c0                	add    %eax,%eax
  800b56:	01 d0                	add    %edx,%eax
  800b58:	c1 e0 02             	shl    $0x2,%eax
  800b5b:	01 c8                	add    %ecx,%eax
  800b5d:	8b 00                	mov    (%eax),%eax
  800b5f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800b62:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800b65:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b6a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800b6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b6f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800b76:	8b 45 08             	mov    0x8(%ebp),%eax
  800b79:	01 c8                	add    %ecx,%eax
  800b7b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b7d:	39 c2                	cmp    %eax,%edx
  800b7f:	75 09                	jne    800b8a <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800b81:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b88:	eb 12                	jmp    800b9c <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b8a:	ff 45 e8             	incl   -0x18(%ebp)
  800b8d:	a1 20 30 80 00       	mov    0x803020,%eax
  800b92:	8b 50 74             	mov    0x74(%eax),%edx
  800b95:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b98:	39 c2                	cmp    %eax,%edx
  800b9a:	77 88                	ja     800b24 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b9c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800ba0:	75 14                	jne    800bb6 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800ba2:	83 ec 04             	sub    $0x4,%esp
  800ba5:	68 a8 28 80 00       	push   $0x8028a8
  800baa:	6a 3a                	push   $0x3a
  800bac:	68 9c 28 80 00       	push   $0x80289c
  800bb1:	e8 93 fe ff ff       	call   800a49 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800bb6:	ff 45 f0             	incl   -0x10(%ebp)
  800bb9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bbc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800bbf:	0f 8c 32 ff ff ff    	jl     800af7 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800bc5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800bcc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800bd3:	eb 26                	jmp    800bfb <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800bd5:	a1 20 30 80 00       	mov    0x803020,%eax
  800bda:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800be0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800be3:	89 d0                	mov    %edx,%eax
  800be5:	01 c0                	add    %eax,%eax
  800be7:	01 d0                	add    %edx,%eax
  800be9:	c1 e0 02             	shl    $0x2,%eax
  800bec:	01 c8                	add    %ecx,%eax
  800bee:	8a 40 04             	mov    0x4(%eax),%al
  800bf1:	3c 01                	cmp    $0x1,%al
  800bf3:	75 03                	jne    800bf8 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800bf5:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800bf8:	ff 45 e0             	incl   -0x20(%ebp)
  800bfb:	a1 20 30 80 00       	mov    0x803020,%eax
  800c00:	8b 50 74             	mov    0x74(%eax),%edx
  800c03:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c06:	39 c2                	cmp    %eax,%edx
  800c08:	77 cb                	ja     800bd5 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c0d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800c10:	74 14                	je     800c26 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800c12:	83 ec 04             	sub    $0x4,%esp
  800c15:	68 fc 28 80 00       	push   $0x8028fc
  800c1a:	6a 44                	push   $0x44
  800c1c:	68 9c 28 80 00       	push   $0x80289c
  800c21:	e8 23 fe ff ff       	call   800a49 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800c26:	90                   	nop
  800c27:	c9                   	leave  
  800c28:	c3                   	ret    

00800c29 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800c29:	55                   	push   %ebp
  800c2a:	89 e5                	mov    %esp,%ebp
  800c2c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800c2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c32:	8b 00                	mov    (%eax),%eax
  800c34:	8d 48 01             	lea    0x1(%eax),%ecx
  800c37:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c3a:	89 0a                	mov    %ecx,(%edx)
  800c3c:	8b 55 08             	mov    0x8(%ebp),%edx
  800c3f:	88 d1                	mov    %dl,%cl
  800c41:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c44:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800c48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4b:	8b 00                	mov    (%eax),%eax
  800c4d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800c52:	75 2c                	jne    800c80 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800c54:	a0 24 30 80 00       	mov    0x803024,%al
  800c59:	0f b6 c0             	movzbl %al,%eax
  800c5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c5f:	8b 12                	mov    (%edx),%edx
  800c61:	89 d1                	mov    %edx,%ecx
  800c63:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c66:	83 c2 08             	add    $0x8,%edx
  800c69:	83 ec 04             	sub    $0x4,%esp
  800c6c:	50                   	push   %eax
  800c6d:	51                   	push   %ecx
  800c6e:	52                   	push   %edx
  800c6f:	e8 3e 0e 00 00       	call   801ab2 <sys_cputs>
  800c74:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800c77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c83:	8b 40 04             	mov    0x4(%eax),%eax
  800c86:	8d 50 01             	lea    0x1(%eax),%edx
  800c89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8c:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c8f:	90                   	nop
  800c90:	c9                   	leave  
  800c91:	c3                   	ret    

00800c92 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800c92:	55                   	push   %ebp
  800c93:	89 e5                	mov    %esp,%ebp
  800c95:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c9b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ca2:	00 00 00 
	b.cnt = 0;
  800ca5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800cac:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800caf:	ff 75 0c             	pushl  0xc(%ebp)
  800cb2:	ff 75 08             	pushl  0x8(%ebp)
  800cb5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800cbb:	50                   	push   %eax
  800cbc:	68 29 0c 80 00       	push   $0x800c29
  800cc1:	e8 11 02 00 00       	call   800ed7 <vprintfmt>
  800cc6:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800cc9:	a0 24 30 80 00       	mov    0x803024,%al
  800cce:	0f b6 c0             	movzbl %al,%eax
  800cd1:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800cd7:	83 ec 04             	sub    $0x4,%esp
  800cda:	50                   	push   %eax
  800cdb:	52                   	push   %edx
  800cdc:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ce2:	83 c0 08             	add    $0x8,%eax
  800ce5:	50                   	push   %eax
  800ce6:	e8 c7 0d 00 00       	call   801ab2 <sys_cputs>
  800ceb:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800cee:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800cf5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800cfb:	c9                   	leave  
  800cfc:	c3                   	ret    

00800cfd <cprintf>:

int cprintf(const char *fmt, ...) {
  800cfd:	55                   	push   %ebp
  800cfe:	89 e5                	mov    %esp,%ebp
  800d00:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800d03:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800d0a:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	83 ec 08             	sub    $0x8,%esp
  800d16:	ff 75 f4             	pushl  -0xc(%ebp)
  800d19:	50                   	push   %eax
  800d1a:	e8 73 ff ff ff       	call   800c92 <vcprintf>
  800d1f:	83 c4 10             	add    $0x10,%esp
  800d22:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800d25:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d28:	c9                   	leave  
  800d29:	c3                   	ret    

00800d2a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800d2a:	55                   	push   %ebp
  800d2b:	89 e5                	mov    %esp,%ebp
  800d2d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800d30:	e8 8e 0f 00 00       	call   801cc3 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800d35:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d38:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	83 ec 08             	sub    $0x8,%esp
  800d41:	ff 75 f4             	pushl  -0xc(%ebp)
  800d44:	50                   	push   %eax
  800d45:	e8 48 ff ff ff       	call   800c92 <vcprintf>
  800d4a:	83 c4 10             	add    $0x10,%esp
  800d4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800d50:	e8 88 0f 00 00       	call   801cdd <sys_enable_interrupt>
	return cnt;
  800d55:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d58:	c9                   	leave  
  800d59:	c3                   	ret    

00800d5a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d5a:	55                   	push   %ebp
  800d5b:	89 e5                	mov    %esp,%ebp
  800d5d:	53                   	push   %ebx
  800d5e:	83 ec 14             	sub    $0x14,%esp
  800d61:	8b 45 10             	mov    0x10(%ebp),%eax
  800d64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d67:	8b 45 14             	mov    0x14(%ebp),%eax
  800d6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d6d:	8b 45 18             	mov    0x18(%ebp),%eax
  800d70:	ba 00 00 00 00       	mov    $0x0,%edx
  800d75:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d78:	77 55                	ja     800dcf <printnum+0x75>
  800d7a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d7d:	72 05                	jb     800d84 <printnum+0x2a>
  800d7f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d82:	77 4b                	ja     800dcf <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d84:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d87:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d8a:	8b 45 18             	mov    0x18(%ebp),%eax
  800d8d:	ba 00 00 00 00       	mov    $0x0,%edx
  800d92:	52                   	push   %edx
  800d93:	50                   	push   %eax
  800d94:	ff 75 f4             	pushl  -0xc(%ebp)
  800d97:	ff 75 f0             	pushl  -0x10(%ebp)
  800d9a:	e8 b9 13 00 00       	call   802158 <__udivdi3>
  800d9f:	83 c4 10             	add    $0x10,%esp
  800da2:	83 ec 04             	sub    $0x4,%esp
  800da5:	ff 75 20             	pushl  0x20(%ebp)
  800da8:	53                   	push   %ebx
  800da9:	ff 75 18             	pushl  0x18(%ebp)
  800dac:	52                   	push   %edx
  800dad:	50                   	push   %eax
  800dae:	ff 75 0c             	pushl  0xc(%ebp)
  800db1:	ff 75 08             	pushl  0x8(%ebp)
  800db4:	e8 a1 ff ff ff       	call   800d5a <printnum>
  800db9:	83 c4 20             	add    $0x20,%esp
  800dbc:	eb 1a                	jmp    800dd8 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800dbe:	83 ec 08             	sub    $0x8,%esp
  800dc1:	ff 75 0c             	pushl  0xc(%ebp)
  800dc4:	ff 75 20             	pushl  0x20(%ebp)
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	ff d0                	call   *%eax
  800dcc:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800dcf:	ff 4d 1c             	decl   0x1c(%ebp)
  800dd2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800dd6:	7f e6                	jg     800dbe <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800dd8:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ddb:	bb 00 00 00 00       	mov    $0x0,%ebx
  800de0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800de3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800de6:	53                   	push   %ebx
  800de7:	51                   	push   %ecx
  800de8:	52                   	push   %edx
  800de9:	50                   	push   %eax
  800dea:	e8 79 14 00 00       	call   802268 <__umoddi3>
  800def:	83 c4 10             	add    $0x10,%esp
  800df2:	05 74 2b 80 00       	add    $0x802b74,%eax
  800df7:	8a 00                	mov    (%eax),%al
  800df9:	0f be c0             	movsbl %al,%eax
  800dfc:	83 ec 08             	sub    $0x8,%esp
  800dff:	ff 75 0c             	pushl  0xc(%ebp)
  800e02:	50                   	push   %eax
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	ff d0                	call   *%eax
  800e08:	83 c4 10             	add    $0x10,%esp
}
  800e0b:	90                   	nop
  800e0c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800e0f:	c9                   	leave  
  800e10:	c3                   	ret    

00800e11 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800e11:	55                   	push   %ebp
  800e12:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e14:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e18:	7e 1c                	jle    800e36 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800e1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1d:	8b 00                	mov    (%eax),%eax
  800e1f:	8d 50 08             	lea    0x8(%eax),%edx
  800e22:	8b 45 08             	mov    0x8(%ebp),%eax
  800e25:	89 10                	mov    %edx,(%eax)
  800e27:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2a:	8b 00                	mov    (%eax),%eax
  800e2c:	83 e8 08             	sub    $0x8,%eax
  800e2f:	8b 50 04             	mov    0x4(%eax),%edx
  800e32:	8b 00                	mov    (%eax),%eax
  800e34:	eb 40                	jmp    800e76 <getuint+0x65>
	else if (lflag)
  800e36:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e3a:	74 1e                	je     800e5a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3f:	8b 00                	mov    (%eax),%eax
  800e41:	8d 50 04             	lea    0x4(%eax),%edx
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	89 10                	mov    %edx,(%eax)
  800e49:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4c:	8b 00                	mov    (%eax),%eax
  800e4e:	83 e8 04             	sub    $0x4,%eax
  800e51:	8b 00                	mov    (%eax),%eax
  800e53:	ba 00 00 00 00       	mov    $0x0,%edx
  800e58:	eb 1c                	jmp    800e76 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	8b 00                	mov    (%eax),%eax
  800e5f:	8d 50 04             	lea    0x4(%eax),%edx
  800e62:	8b 45 08             	mov    0x8(%ebp),%eax
  800e65:	89 10                	mov    %edx,(%eax)
  800e67:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6a:	8b 00                	mov    (%eax),%eax
  800e6c:	83 e8 04             	sub    $0x4,%eax
  800e6f:	8b 00                	mov    (%eax),%eax
  800e71:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e76:	5d                   	pop    %ebp
  800e77:	c3                   	ret    

00800e78 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e78:	55                   	push   %ebp
  800e79:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e7b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e7f:	7e 1c                	jle    800e9d <getint+0x25>
		return va_arg(*ap, long long);
  800e81:	8b 45 08             	mov    0x8(%ebp),%eax
  800e84:	8b 00                	mov    (%eax),%eax
  800e86:	8d 50 08             	lea    0x8(%eax),%edx
  800e89:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8c:	89 10                	mov    %edx,(%eax)
  800e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e91:	8b 00                	mov    (%eax),%eax
  800e93:	83 e8 08             	sub    $0x8,%eax
  800e96:	8b 50 04             	mov    0x4(%eax),%edx
  800e99:	8b 00                	mov    (%eax),%eax
  800e9b:	eb 38                	jmp    800ed5 <getint+0x5d>
	else if (lflag)
  800e9d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ea1:	74 1a                	je     800ebd <getint+0x45>
		return va_arg(*ap, long);
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	8b 00                	mov    (%eax),%eax
  800ea8:	8d 50 04             	lea    0x4(%eax),%edx
  800eab:	8b 45 08             	mov    0x8(%ebp),%eax
  800eae:	89 10                	mov    %edx,(%eax)
  800eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb3:	8b 00                	mov    (%eax),%eax
  800eb5:	83 e8 04             	sub    $0x4,%eax
  800eb8:	8b 00                	mov    (%eax),%eax
  800eba:	99                   	cltd   
  800ebb:	eb 18                	jmp    800ed5 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800ebd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec0:	8b 00                	mov    (%eax),%eax
  800ec2:	8d 50 04             	lea    0x4(%eax),%edx
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	89 10                	mov    %edx,(%eax)
  800eca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecd:	8b 00                	mov    (%eax),%eax
  800ecf:	83 e8 04             	sub    $0x4,%eax
  800ed2:	8b 00                	mov    (%eax),%eax
  800ed4:	99                   	cltd   
}
  800ed5:	5d                   	pop    %ebp
  800ed6:	c3                   	ret    

00800ed7 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800ed7:	55                   	push   %ebp
  800ed8:	89 e5                	mov    %esp,%ebp
  800eda:	56                   	push   %esi
  800edb:	53                   	push   %ebx
  800edc:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800edf:	eb 17                	jmp    800ef8 <vprintfmt+0x21>
			if (ch == '\0')
  800ee1:	85 db                	test   %ebx,%ebx
  800ee3:	0f 84 af 03 00 00    	je     801298 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ee9:	83 ec 08             	sub    $0x8,%esp
  800eec:	ff 75 0c             	pushl  0xc(%ebp)
  800eef:	53                   	push   %ebx
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	ff d0                	call   *%eax
  800ef5:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ef8:	8b 45 10             	mov    0x10(%ebp),%eax
  800efb:	8d 50 01             	lea    0x1(%eax),%edx
  800efe:	89 55 10             	mov    %edx,0x10(%ebp)
  800f01:	8a 00                	mov    (%eax),%al
  800f03:	0f b6 d8             	movzbl %al,%ebx
  800f06:	83 fb 25             	cmp    $0x25,%ebx
  800f09:	75 d6                	jne    800ee1 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800f0b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800f0f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800f16:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800f1d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800f24:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800f2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2e:	8d 50 01             	lea    0x1(%eax),%edx
  800f31:	89 55 10             	mov    %edx,0x10(%ebp)
  800f34:	8a 00                	mov    (%eax),%al
  800f36:	0f b6 d8             	movzbl %al,%ebx
  800f39:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800f3c:	83 f8 55             	cmp    $0x55,%eax
  800f3f:	0f 87 2b 03 00 00    	ja     801270 <vprintfmt+0x399>
  800f45:	8b 04 85 98 2b 80 00 	mov    0x802b98(,%eax,4),%eax
  800f4c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800f4e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800f52:	eb d7                	jmp    800f2b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800f54:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800f58:	eb d1                	jmp    800f2b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f5a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f61:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f64:	89 d0                	mov    %edx,%eax
  800f66:	c1 e0 02             	shl    $0x2,%eax
  800f69:	01 d0                	add    %edx,%eax
  800f6b:	01 c0                	add    %eax,%eax
  800f6d:	01 d8                	add    %ebx,%eax
  800f6f:	83 e8 30             	sub    $0x30,%eax
  800f72:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f75:	8b 45 10             	mov    0x10(%ebp),%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f7d:	83 fb 2f             	cmp    $0x2f,%ebx
  800f80:	7e 3e                	jle    800fc0 <vprintfmt+0xe9>
  800f82:	83 fb 39             	cmp    $0x39,%ebx
  800f85:	7f 39                	jg     800fc0 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f87:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f8a:	eb d5                	jmp    800f61 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f8c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f8f:	83 c0 04             	add    $0x4,%eax
  800f92:	89 45 14             	mov    %eax,0x14(%ebp)
  800f95:	8b 45 14             	mov    0x14(%ebp),%eax
  800f98:	83 e8 04             	sub    $0x4,%eax
  800f9b:	8b 00                	mov    (%eax),%eax
  800f9d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800fa0:	eb 1f                	jmp    800fc1 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800fa2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fa6:	79 83                	jns    800f2b <vprintfmt+0x54>
				width = 0;
  800fa8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800faf:	e9 77 ff ff ff       	jmp    800f2b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800fb4:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800fbb:	e9 6b ff ff ff       	jmp    800f2b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800fc0:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800fc1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fc5:	0f 89 60 ff ff ff    	jns    800f2b <vprintfmt+0x54>
				width = precision, precision = -1;
  800fcb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800fce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800fd1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800fd8:	e9 4e ff ff ff       	jmp    800f2b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800fdd:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800fe0:	e9 46 ff ff ff       	jmp    800f2b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800fe5:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe8:	83 c0 04             	add    $0x4,%eax
  800feb:	89 45 14             	mov    %eax,0x14(%ebp)
  800fee:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff1:	83 e8 04             	sub    $0x4,%eax
  800ff4:	8b 00                	mov    (%eax),%eax
  800ff6:	83 ec 08             	sub    $0x8,%esp
  800ff9:	ff 75 0c             	pushl  0xc(%ebp)
  800ffc:	50                   	push   %eax
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  801000:	ff d0                	call   *%eax
  801002:	83 c4 10             	add    $0x10,%esp
			break;
  801005:	e9 89 02 00 00       	jmp    801293 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80100a:	8b 45 14             	mov    0x14(%ebp),%eax
  80100d:	83 c0 04             	add    $0x4,%eax
  801010:	89 45 14             	mov    %eax,0x14(%ebp)
  801013:	8b 45 14             	mov    0x14(%ebp),%eax
  801016:	83 e8 04             	sub    $0x4,%eax
  801019:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80101b:	85 db                	test   %ebx,%ebx
  80101d:	79 02                	jns    801021 <vprintfmt+0x14a>
				err = -err;
  80101f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801021:	83 fb 64             	cmp    $0x64,%ebx
  801024:	7f 0b                	jg     801031 <vprintfmt+0x15a>
  801026:	8b 34 9d e0 29 80 00 	mov    0x8029e0(,%ebx,4),%esi
  80102d:	85 f6                	test   %esi,%esi
  80102f:	75 19                	jne    80104a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801031:	53                   	push   %ebx
  801032:	68 85 2b 80 00       	push   $0x802b85
  801037:	ff 75 0c             	pushl  0xc(%ebp)
  80103a:	ff 75 08             	pushl  0x8(%ebp)
  80103d:	e8 5e 02 00 00       	call   8012a0 <printfmt>
  801042:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801045:	e9 49 02 00 00       	jmp    801293 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80104a:	56                   	push   %esi
  80104b:	68 8e 2b 80 00       	push   $0x802b8e
  801050:	ff 75 0c             	pushl  0xc(%ebp)
  801053:	ff 75 08             	pushl  0x8(%ebp)
  801056:	e8 45 02 00 00       	call   8012a0 <printfmt>
  80105b:	83 c4 10             	add    $0x10,%esp
			break;
  80105e:	e9 30 02 00 00       	jmp    801293 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801063:	8b 45 14             	mov    0x14(%ebp),%eax
  801066:	83 c0 04             	add    $0x4,%eax
  801069:	89 45 14             	mov    %eax,0x14(%ebp)
  80106c:	8b 45 14             	mov    0x14(%ebp),%eax
  80106f:	83 e8 04             	sub    $0x4,%eax
  801072:	8b 30                	mov    (%eax),%esi
  801074:	85 f6                	test   %esi,%esi
  801076:	75 05                	jne    80107d <vprintfmt+0x1a6>
				p = "(null)";
  801078:	be 91 2b 80 00       	mov    $0x802b91,%esi
			if (width > 0 && padc != '-')
  80107d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801081:	7e 6d                	jle    8010f0 <vprintfmt+0x219>
  801083:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801087:	74 67                	je     8010f0 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801089:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80108c:	83 ec 08             	sub    $0x8,%esp
  80108f:	50                   	push   %eax
  801090:	56                   	push   %esi
  801091:	e8 0c 03 00 00       	call   8013a2 <strnlen>
  801096:	83 c4 10             	add    $0x10,%esp
  801099:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80109c:	eb 16                	jmp    8010b4 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80109e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8010a2:	83 ec 08             	sub    $0x8,%esp
  8010a5:	ff 75 0c             	pushl  0xc(%ebp)
  8010a8:	50                   	push   %eax
  8010a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ac:	ff d0                	call   *%eax
  8010ae:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8010b1:	ff 4d e4             	decl   -0x1c(%ebp)
  8010b4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010b8:	7f e4                	jg     80109e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010ba:	eb 34                	jmp    8010f0 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8010bc:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8010c0:	74 1c                	je     8010de <vprintfmt+0x207>
  8010c2:	83 fb 1f             	cmp    $0x1f,%ebx
  8010c5:	7e 05                	jle    8010cc <vprintfmt+0x1f5>
  8010c7:	83 fb 7e             	cmp    $0x7e,%ebx
  8010ca:	7e 12                	jle    8010de <vprintfmt+0x207>
					putch('?', putdat);
  8010cc:	83 ec 08             	sub    $0x8,%esp
  8010cf:	ff 75 0c             	pushl  0xc(%ebp)
  8010d2:	6a 3f                	push   $0x3f
  8010d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d7:	ff d0                	call   *%eax
  8010d9:	83 c4 10             	add    $0x10,%esp
  8010dc:	eb 0f                	jmp    8010ed <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8010de:	83 ec 08             	sub    $0x8,%esp
  8010e1:	ff 75 0c             	pushl  0xc(%ebp)
  8010e4:	53                   	push   %ebx
  8010e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e8:	ff d0                	call   *%eax
  8010ea:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010ed:	ff 4d e4             	decl   -0x1c(%ebp)
  8010f0:	89 f0                	mov    %esi,%eax
  8010f2:	8d 70 01             	lea    0x1(%eax),%esi
  8010f5:	8a 00                	mov    (%eax),%al
  8010f7:	0f be d8             	movsbl %al,%ebx
  8010fa:	85 db                	test   %ebx,%ebx
  8010fc:	74 24                	je     801122 <vprintfmt+0x24b>
  8010fe:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801102:	78 b8                	js     8010bc <vprintfmt+0x1e5>
  801104:	ff 4d e0             	decl   -0x20(%ebp)
  801107:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80110b:	79 af                	jns    8010bc <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80110d:	eb 13                	jmp    801122 <vprintfmt+0x24b>
				putch(' ', putdat);
  80110f:	83 ec 08             	sub    $0x8,%esp
  801112:	ff 75 0c             	pushl  0xc(%ebp)
  801115:	6a 20                	push   $0x20
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	ff d0                	call   *%eax
  80111c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80111f:	ff 4d e4             	decl   -0x1c(%ebp)
  801122:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801126:	7f e7                	jg     80110f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801128:	e9 66 01 00 00       	jmp    801293 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80112d:	83 ec 08             	sub    $0x8,%esp
  801130:	ff 75 e8             	pushl  -0x18(%ebp)
  801133:	8d 45 14             	lea    0x14(%ebp),%eax
  801136:	50                   	push   %eax
  801137:	e8 3c fd ff ff       	call   800e78 <getint>
  80113c:	83 c4 10             	add    $0x10,%esp
  80113f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801142:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801145:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801148:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80114b:	85 d2                	test   %edx,%edx
  80114d:	79 23                	jns    801172 <vprintfmt+0x29b>
				putch('-', putdat);
  80114f:	83 ec 08             	sub    $0x8,%esp
  801152:	ff 75 0c             	pushl  0xc(%ebp)
  801155:	6a 2d                	push   $0x2d
  801157:	8b 45 08             	mov    0x8(%ebp),%eax
  80115a:	ff d0                	call   *%eax
  80115c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80115f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801162:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801165:	f7 d8                	neg    %eax
  801167:	83 d2 00             	adc    $0x0,%edx
  80116a:	f7 da                	neg    %edx
  80116c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80116f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801172:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801179:	e9 bc 00 00 00       	jmp    80123a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80117e:	83 ec 08             	sub    $0x8,%esp
  801181:	ff 75 e8             	pushl  -0x18(%ebp)
  801184:	8d 45 14             	lea    0x14(%ebp),%eax
  801187:	50                   	push   %eax
  801188:	e8 84 fc ff ff       	call   800e11 <getuint>
  80118d:	83 c4 10             	add    $0x10,%esp
  801190:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801193:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801196:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80119d:	e9 98 00 00 00       	jmp    80123a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8011a2:	83 ec 08             	sub    $0x8,%esp
  8011a5:	ff 75 0c             	pushl  0xc(%ebp)
  8011a8:	6a 58                	push   $0x58
  8011aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ad:	ff d0                	call   *%eax
  8011af:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8011b2:	83 ec 08             	sub    $0x8,%esp
  8011b5:	ff 75 0c             	pushl  0xc(%ebp)
  8011b8:	6a 58                	push   $0x58
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	ff d0                	call   *%eax
  8011bf:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8011c2:	83 ec 08             	sub    $0x8,%esp
  8011c5:	ff 75 0c             	pushl  0xc(%ebp)
  8011c8:	6a 58                	push   $0x58
  8011ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cd:	ff d0                	call   *%eax
  8011cf:	83 c4 10             	add    $0x10,%esp
			break;
  8011d2:	e9 bc 00 00 00       	jmp    801293 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8011d7:	83 ec 08             	sub    $0x8,%esp
  8011da:	ff 75 0c             	pushl  0xc(%ebp)
  8011dd:	6a 30                	push   $0x30
  8011df:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e2:	ff d0                	call   *%eax
  8011e4:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8011e7:	83 ec 08             	sub    $0x8,%esp
  8011ea:	ff 75 0c             	pushl  0xc(%ebp)
  8011ed:	6a 78                	push   $0x78
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	ff d0                	call   *%eax
  8011f4:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8011f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8011fa:	83 c0 04             	add    $0x4,%eax
  8011fd:	89 45 14             	mov    %eax,0x14(%ebp)
  801200:	8b 45 14             	mov    0x14(%ebp),%eax
  801203:	83 e8 04             	sub    $0x4,%eax
  801206:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801208:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80120b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801212:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801219:	eb 1f                	jmp    80123a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80121b:	83 ec 08             	sub    $0x8,%esp
  80121e:	ff 75 e8             	pushl  -0x18(%ebp)
  801221:	8d 45 14             	lea    0x14(%ebp),%eax
  801224:	50                   	push   %eax
  801225:	e8 e7 fb ff ff       	call   800e11 <getuint>
  80122a:	83 c4 10             	add    $0x10,%esp
  80122d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801230:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801233:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80123a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80123e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801241:	83 ec 04             	sub    $0x4,%esp
  801244:	52                   	push   %edx
  801245:	ff 75 e4             	pushl  -0x1c(%ebp)
  801248:	50                   	push   %eax
  801249:	ff 75 f4             	pushl  -0xc(%ebp)
  80124c:	ff 75 f0             	pushl  -0x10(%ebp)
  80124f:	ff 75 0c             	pushl  0xc(%ebp)
  801252:	ff 75 08             	pushl  0x8(%ebp)
  801255:	e8 00 fb ff ff       	call   800d5a <printnum>
  80125a:	83 c4 20             	add    $0x20,%esp
			break;
  80125d:	eb 34                	jmp    801293 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80125f:	83 ec 08             	sub    $0x8,%esp
  801262:	ff 75 0c             	pushl  0xc(%ebp)
  801265:	53                   	push   %ebx
  801266:	8b 45 08             	mov    0x8(%ebp),%eax
  801269:	ff d0                	call   *%eax
  80126b:	83 c4 10             	add    $0x10,%esp
			break;
  80126e:	eb 23                	jmp    801293 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801270:	83 ec 08             	sub    $0x8,%esp
  801273:	ff 75 0c             	pushl  0xc(%ebp)
  801276:	6a 25                	push   $0x25
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	ff d0                	call   *%eax
  80127d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801280:	ff 4d 10             	decl   0x10(%ebp)
  801283:	eb 03                	jmp    801288 <vprintfmt+0x3b1>
  801285:	ff 4d 10             	decl   0x10(%ebp)
  801288:	8b 45 10             	mov    0x10(%ebp),%eax
  80128b:	48                   	dec    %eax
  80128c:	8a 00                	mov    (%eax),%al
  80128e:	3c 25                	cmp    $0x25,%al
  801290:	75 f3                	jne    801285 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801292:	90                   	nop
		}
	}
  801293:	e9 47 fc ff ff       	jmp    800edf <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801298:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801299:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80129c:	5b                   	pop    %ebx
  80129d:	5e                   	pop    %esi
  80129e:	5d                   	pop    %ebp
  80129f:	c3                   	ret    

008012a0 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
  8012a3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8012a6:	8d 45 10             	lea    0x10(%ebp),%eax
  8012a9:	83 c0 04             	add    $0x4,%eax
  8012ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8012af:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b2:	ff 75 f4             	pushl  -0xc(%ebp)
  8012b5:	50                   	push   %eax
  8012b6:	ff 75 0c             	pushl  0xc(%ebp)
  8012b9:	ff 75 08             	pushl  0x8(%ebp)
  8012bc:	e8 16 fc ff ff       	call   800ed7 <vprintfmt>
  8012c1:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8012c4:	90                   	nop
  8012c5:	c9                   	leave  
  8012c6:	c3                   	ret    

008012c7 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8012c7:	55                   	push   %ebp
  8012c8:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8012ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cd:	8b 40 08             	mov    0x8(%eax),%eax
  8012d0:	8d 50 01             	lea    0x1(%eax),%edx
  8012d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d6:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8012d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012dc:	8b 10                	mov    (%eax),%edx
  8012de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e1:	8b 40 04             	mov    0x4(%eax),%eax
  8012e4:	39 c2                	cmp    %eax,%edx
  8012e6:	73 12                	jae    8012fa <sprintputch+0x33>
		*b->buf++ = ch;
  8012e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012eb:	8b 00                	mov    (%eax),%eax
  8012ed:	8d 48 01             	lea    0x1(%eax),%ecx
  8012f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f3:	89 0a                	mov    %ecx,(%edx)
  8012f5:	8b 55 08             	mov    0x8(%ebp),%edx
  8012f8:	88 10                	mov    %dl,(%eax)
}
  8012fa:	90                   	nop
  8012fb:	5d                   	pop    %ebp
  8012fc:	c3                   	ret    

008012fd <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8012fd:	55                   	push   %ebp
  8012fe:	89 e5                	mov    %esp,%ebp
  801300:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801303:	8b 45 08             	mov    0x8(%ebp),%eax
  801306:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801309:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	01 d0                	add    %edx,%eax
  801314:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801317:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80131e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801322:	74 06                	je     80132a <vsnprintf+0x2d>
  801324:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801328:	7f 07                	jg     801331 <vsnprintf+0x34>
		return -E_INVAL;
  80132a:	b8 03 00 00 00       	mov    $0x3,%eax
  80132f:	eb 20                	jmp    801351 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801331:	ff 75 14             	pushl  0x14(%ebp)
  801334:	ff 75 10             	pushl  0x10(%ebp)
  801337:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80133a:	50                   	push   %eax
  80133b:	68 c7 12 80 00       	push   $0x8012c7
  801340:	e8 92 fb ff ff       	call   800ed7 <vprintfmt>
  801345:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801348:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80134b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80134e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801351:	c9                   	leave  
  801352:	c3                   	ret    

00801353 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801353:	55                   	push   %ebp
  801354:	89 e5                	mov    %esp,%ebp
  801356:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801359:	8d 45 10             	lea    0x10(%ebp),%eax
  80135c:	83 c0 04             	add    $0x4,%eax
  80135f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801362:	8b 45 10             	mov    0x10(%ebp),%eax
  801365:	ff 75 f4             	pushl  -0xc(%ebp)
  801368:	50                   	push   %eax
  801369:	ff 75 0c             	pushl  0xc(%ebp)
  80136c:	ff 75 08             	pushl  0x8(%ebp)
  80136f:	e8 89 ff ff ff       	call   8012fd <vsnprintf>
  801374:	83 c4 10             	add    $0x10,%esp
  801377:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80137a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80137d:	c9                   	leave  
  80137e:	c3                   	ret    

0080137f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
  801382:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801385:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80138c:	eb 06                	jmp    801394 <strlen+0x15>
		n++;
  80138e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801391:	ff 45 08             	incl   0x8(%ebp)
  801394:	8b 45 08             	mov    0x8(%ebp),%eax
  801397:	8a 00                	mov    (%eax),%al
  801399:	84 c0                	test   %al,%al
  80139b:	75 f1                	jne    80138e <strlen+0xf>
		n++;
	return n;
  80139d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013a0:	c9                   	leave  
  8013a1:	c3                   	ret    

008013a2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8013a2:	55                   	push   %ebp
  8013a3:	89 e5                	mov    %esp,%ebp
  8013a5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8013a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013af:	eb 09                	jmp    8013ba <strnlen+0x18>
		n++;
  8013b1:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8013b4:	ff 45 08             	incl   0x8(%ebp)
  8013b7:	ff 4d 0c             	decl   0xc(%ebp)
  8013ba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013be:	74 09                	je     8013c9 <strnlen+0x27>
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	8a 00                	mov    (%eax),%al
  8013c5:	84 c0                	test   %al,%al
  8013c7:	75 e8                	jne    8013b1 <strnlen+0xf>
		n++;
	return n;
  8013c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013cc:	c9                   	leave  
  8013cd:	c3                   	ret    

008013ce <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8013ce:	55                   	push   %ebp
  8013cf:	89 e5                	mov    %esp,%ebp
  8013d1:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8013d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8013da:	90                   	nop
  8013db:	8b 45 08             	mov    0x8(%ebp),%eax
  8013de:	8d 50 01             	lea    0x1(%eax),%edx
  8013e1:	89 55 08             	mov    %edx,0x8(%ebp)
  8013e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013e7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013ea:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013ed:	8a 12                	mov    (%edx),%dl
  8013ef:	88 10                	mov    %dl,(%eax)
  8013f1:	8a 00                	mov    (%eax),%al
  8013f3:	84 c0                	test   %al,%al
  8013f5:	75 e4                	jne    8013db <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013fa:	c9                   	leave  
  8013fb:	c3                   	ret    

008013fc <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013fc:	55                   	push   %ebp
  8013fd:	89 e5                	mov    %esp,%ebp
  8013ff:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801402:	8b 45 08             	mov    0x8(%ebp),%eax
  801405:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801408:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80140f:	eb 1f                	jmp    801430 <strncpy+0x34>
		*dst++ = *src;
  801411:	8b 45 08             	mov    0x8(%ebp),%eax
  801414:	8d 50 01             	lea    0x1(%eax),%edx
  801417:	89 55 08             	mov    %edx,0x8(%ebp)
  80141a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80141d:	8a 12                	mov    (%edx),%dl
  80141f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801421:	8b 45 0c             	mov    0xc(%ebp),%eax
  801424:	8a 00                	mov    (%eax),%al
  801426:	84 c0                	test   %al,%al
  801428:	74 03                	je     80142d <strncpy+0x31>
			src++;
  80142a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80142d:	ff 45 fc             	incl   -0x4(%ebp)
  801430:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801433:	3b 45 10             	cmp    0x10(%ebp),%eax
  801436:	72 d9                	jb     801411 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801438:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80143b:	c9                   	leave  
  80143c:	c3                   	ret    

0080143d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80143d:	55                   	push   %ebp
  80143e:	89 e5                	mov    %esp,%ebp
  801440:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801449:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80144d:	74 30                	je     80147f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80144f:	eb 16                	jmp    801467 <strlcpy+0x2a>
			*dst++ = *src++;
  801451:	8b 45 08             	mov    0x8(%ebp),%eax
  801454:	8d 50 01             	lea    0x1(%eax),%edx
  801457:	89 55 08             	mov    %edx,0x8(%ebp)
  80145a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80145d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801460:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801463:	8a 12                	mov    (%edx),%dl
  801465:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801467:	ff 4d 10             	decl   0x10(%ebp)
  80146a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80146e:	74 09                	je     801479 <strlcpy+0x3c>
  801470:	8b 45 0c             	mov    0xc(%ebp),%eax
  801473:	8a 00                	mov    (%eax),%al
  801475:	84 c0                	test   %al,%al
  801477:	75 d8                	jne    801451 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
  80147c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80147f:	8b 55 08             	mov    0x8(%ebp),%edx
  801482:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801485:	29 c2                	sub    %eax,%edx
  801487:	89 d0                	mov    %edx,%eax
}
  801489:	c9                   	leave  
  80148a:	c3                   	ret    

0080148b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80148b:	55                   	push   %ebp
  80148c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80148e:	eb 06                	jmp    801496 <strcmp+0xb>
		p++, q++;
  801490:	ff 45 08             	incl   0x8(%ebp)
  801493:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801496:	8b 45 08             	mov    0x8(%ebp),%eax
  801499:	8a 00                	mov    (%eax),%al
  80149b:	84 c0                	test   %al,%al
  80149d:	74 0e                	je     8014ad <strcmp+0x22>
  80149f:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a2:	8a 10                	mov    (%eax),%dl
  8014a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a7:	8a 00                	mov    (%eax),%al
  8014a9:	38 c2                	cmp    %al,%dl
  8014ab:	74 e3                	je     801490 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8014ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b0:	8a 00                	mov    (%eax),%al
  8014b2:	0f b6 d0             	movzbl %al,%edx
  8014b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b8:	8a 00                	mov    (%eax),%al
  8014ba:	0f b6 c0             	movzbl %al,%eax
  8014bd:	29 c2                	sub    %eax,%edx
  8014bf:	89 d0                	mov    %edx,%eax
}
  8014c1:	5d                   	pop    %ebp
  8014c2:	c3                   	ret    

008014c3 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8014c3:	55                   	push   %ebp
  8014c4:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8014c6:	eb 09                	jmp    8014d1 <strncmp+0xe>
		n--, p++, q++;
  8014c8:	ff 4d 10             	decl   0x10(%ebp)
  8014cb:	ff 45 08             	incl   0x8(%ebp)
  8014ce:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8014d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014d5:	74 17                	je     8014ee <strncmp+0x2b>
  8014d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014da:	8a 00                	mov    (%eax),%al
  8014dc:	84 c0                	test   %al,%al
  8014de:	74 0e                	je     8014ee <strncmp+0x2b>
  8014e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e3:	8a 10                	mov    (%eax),%dl
  8014e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e8:	8a 00                	mov    (%eax),%al
  8014ea:	38 c2                	cmp    %al,%dl
  8014ec:	74 da                	je     8014c8 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014f2:	75 07                	jne    8014fb <strncmp+0x38>
		return 0;
  8014f4:	b8 00 00 00 00       	mov    $0x0,%eax
  8014f9:	eb 14                	jmp    80150f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fe:	8a 00                	mov    (%eax),%al
  801500:	0f b6 d0             	movzbl %al,%edx
  801503:	8b 45 0c             	mov    0xc(%ebp),%eax
  801506:	8a 00                	mov    (%eax),%al
  801508:	0f b6 c0             	movzbl %al,%eax
  80150b:	29 c2                	sub    %eax,%edx
  80150d:	89 d0                	mov    %edx,%eax
}
  80150f:	5d                   	pop    %ebp
  801510:	c3                   	ret    

00801511 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801511:	55                   	push   %ebp
  801512:	89 e5                	mov    %esp,%ebp
  801514:	83 ec 04             	sub    $0x4,%esp
  801517:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80151d:	eb 12                	jmp    801531 <strchr+0x20>
		if (*s == c)
  80151f:	8b 45 08             	mov    0x8(%ebp),%eax
  801522:	8a 00                	mov    (%eax),%al
  801524:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801527:	75 05                	jne    80152e <strchr+0x1d>
			return (char *) s;
  801529:	8b 45 08             	mov    0x8(%ebp),%eax
  80152c:	eb 11                	jmp    80153f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80152e:	ff 45 08             	incl   0x8(%ebp)
  801531:	8b 45 08             	mov    0x8(%ebp),%eax
  801534:	8a 00                	mov    (%eax),%al
  801536:	84 c0                	test   %al,%al
  801538:	75 e5                	jne    80151f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80153a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80153f:	c9                   	leave  
  801540:	c3                   	ret    

00801541 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801541:	55                   	push   %ebp
  801542:	89 e5                	mov    %esp,%ebp
  801544:	83 ec 04             	sub    $0x4,%esp
  801547:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80154d:	eb 0d                	jmp    80155c <strfind+0x1b>
		if (*s == c)
  80154f:	8b 45 08             	mov    0x8(%ebp),%eax
  801552:	8a 00                	mov    (%eax),%al
  801554:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801557:	74 0e                	je     801567 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801559:	ff 45 08             	incl   0x8(%ebp)
  80155c:	8b 45 08             	mov    0x8(%ebp),%eax
  80155f:	8a 00                	mov    (%eax),%al
  801561:	84 c0                	test   %al,%al
  801563:	75 ea                	jne    80154f <strfind+0xe>
  801565:	eb 01                	jmp    801568 <strfind+0x27>
		if (*s == c)
			break;
  801567:	90                   	nop
	return (char *) s;
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80156b:	c9                   	leave  
  80156c:	c3                   	ret    

0080156d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
  801570:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801573:	8b 45 08             	mov    0x8(%ebp),%eax
  801576:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801579:	8b 45 10             	mov    0x10(%ebp),%eax
  80157c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80157f:	eb 0e                	jmp    80158f <memset+0x22>
		*p++ = c;
  801581:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801584:	8d 50 01             	lea    0x1(%eax),%edx
  801587:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80158a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80158d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80158f:	ff 4d f8             	decl   -0x8(%ebp)
  801592:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801596:	79 e9                	jns    801581 <memset+0x14>
		*p++ = c;

	return v;
  801598:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80159b:	c9                   	leave  
  80159c:	c3                   	ret    

0080159d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
  8015a0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8015a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8015a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8015af:	eb 16                	jmp    8015c7 <memcpy+0x2a>
		*d++ = *s++;
  8015b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015b4:	8d 50 01             	lea    0x1(%eax),%edx
  8015b7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015ba:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015bd:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015c0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015c3:	8a 12                	mov    (%edx),%dl
  8015c5:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8015c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ca:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015cd:	89 55 10             	mov    %edx,0x10(%ebp)
  8015d0:	85 c0                	test   %eax,%eax
  8015d2:	75 dd                	jne    8015b1 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8015d4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015d7:	c9                   	leave  
  8015d8:	c3                   	ret    

008015d9 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8015d9:	55                   	push   %ebp
  8015da:	89 e5                	mov    %esp,%ebp
  8015dc:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8015df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8015e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8015eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015f1:	73 50                	jae    801643 <memmove+0x6a>
  8015f3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f9:	01 d0                	add    %edx,%eax
  8015fb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015fe:	76 43                	jbe    801643 <memmove+0x6a>
		s += n;
  801600:	8b 45 10             	mov    0x10(%ebp),%eax
  801603:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801606:	8b 45 10             	mov    0x10(%ebp),%eax
  801609:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80160c:	eb 10                	jmp    80161e <memmove+0x45>
			*--d = *--s;
  80160e:	ff 4d f8             	decl   -0x8(%ebp)
  801611:	ff 4d fc             	decl   -0x4(%ebp)
  801614:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801617:	8a 10                	mov    (%eax),%dl
  801619:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80161c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80161e:	8b 45 10             	mov    0x10(%ebp),%eax
  801621:	8d 50 ff             	lea    -0x1(%eax),%edx
  801624:	89 55 10             	mov    %edx,0x10(%ebp)
  801627:	85 c0                	test   %eax,%eax
  801629:	75 e3                	jne    80160e <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80162b:	eb 23                	jmp    801650 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80162d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801630:	8d 50 01             	lea    0x1(%eax),%edx
  801633:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801636:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801639:	8d 4a 01             	lea    0x1(%edx),%ecx
  80163c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80163f:	8a 12                	mov    (%edx),%dl
  801641:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801643:	8b 45 10             	mov    0x10(%ebp),%eax
  801646:	8d 50 ff             	lea    -0x1(%eax),%edx
  801649:	89 55 10             	mov    %edx,0x10(%ebp)
  80164c:	85 c0                	test   %eax,%eax
  80164e:	75 dd                	jne    80162d <memmove+0x54>
			*d++ = *s++;

	return dst;
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801653:	c9                   	leave  
  801654:	c3                   	ret    

00801655 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801655:	55                   	push   %ebp
  801656:	89 e5                	mov    %esp,%ebp
  801658:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80165b:	8b 45 08             	mov    0x8(%ebp),%eax
  80165e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801661:	8b 45 0c             	mov    0xc(%ebp),%eax
  801664:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801667:	eb 2a                	jmp    801693 <memcmp+0x3e>
		if (*s1 != *s2)
  801669:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80166c:	8a 10                	mov    (%eax),%dl
  80166e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801671:	8a 00                	mov    (%eax),%al
  801673:	38 c2                	cmp    %al,%dl
  801675:	74 16                	je     80168d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801677:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80167a:	8a 00                	mov    (%eax),%al
  80167c:	0f b6 d0             	movzbl %al,%edx
  80167f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801682:	8a 00                	mov    (%eax),%al
  801684:	0f b6 c0             	movzbl %al,%eax
  801687:	29 c2                	sub    %eax,%edx
  801689:	89 d0                	mov    %edx,%eax
  80168b:	eb 18                	jmp    8016a5 <memcmp+0x50>
		s1++, s2++;
  80168d:	ff 45 fc             	incl   -0x4(%ebp)
  801690:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801693:	8b 45 10             	mov    0x10(%ebp),%eax
  801696:	8d 50 ff             	lea    -0x1(%eax),%edx
  801699:	89 55 10             	mov    %edx,0x10(%ebp)
  80169c:	85 c0                	test   %eax,%eax
  80169e:	75 c9                	jne    801669 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8016a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016a5:	c9                   	leave  
  8016a6:	c3                   	ret    

008016a7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8016a7:	55                   	push   %ebp
  8016a8:	89 e5                	mov    %esp,%ebp
  8016aa:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8016ad:	8b 55 08             	mov    0x8(%ebp),%edx
  8016b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b3:	01 d0                	add    %edx,%eax
  8016b5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8016b8:	eb 15                	jmp    8016cf <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8016ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bd:	8a 00                	mov    (%eax),%al
  8016bf:	0f b6 d0             	movzbl %al,%edx
  8016c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c5:	0f b6 c0             	movzbl %al,%eax
  8016c8:	39 c2                	cmp    %eax,%edx
  8016ca:	74 0d                	je     8016d9 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8016cc:	ff 45 08             	incl   0x8(%ebp)
  8016cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8016d5:	72 e3                	jb     8016ba <memfind+0x13>
  8016d7:	eb 01                	jmp    8016da <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8016d9:	90                   	nop
	return (void *) s;
  8016da:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016dd:	c9                   	leave  
  8016de:	c3                   	ret    

008016df <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8016df:	55                   	push   %ebp
  8016e0:	89 e5                	mov    %esp,%ebp
  8016e2:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8016e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8016ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016f3:	eb 03                	jmp    8016f8 <strtol+0x19>
		s++;
  8016f5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fb:	8a 00                	mov    (%eax),%al
  8016fd:	3c 20                	cmp    $0x20,%al
  8016ff:	74 f4                	je     8016f5 <strtol+0x16>
  801701:	8b 45 08             	mov    0x8(%ebp),%eax
  801704:	8a 00                	mov    (%eax),%al
  801706:	3c 09                	cmp    $0x9,%al
  801708:	74 eb                	je     8016f5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80170a:	8b 45 08             	mov    0x8(%ebp),%eax
  80170d:	8a 00                	mov    (%eax),%al
  80170f:	3c 2b                	cmp    $0x2b,%al
  801711:	75 05                	jne    801718 <strtol+0x39>
		s++;
  801713:	ff 45 08             	incl   0x8(%ebp)
  801716:	eb 13                	jmp    80172b <strtol+0x4c>
	else if (*s == '-')
  801718:	8b 45 08             	mov    0x8(%ebp),%eax
  80171b:	8a 00                	mov    (%eax),%al
  80171d:	3c 2d                	cmp    $0x2d,%al
  80171f:	75 0a                	jne    80172b <strtol+0x4c>
		s++, neg = 1;
  801721:	ff 45 08             	incl   0x8(%ebp)
  801724:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80172b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80172f:	74 06                	je     801737 <strtol+0x58>
  801731:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801735:	75 20                	jne    801757 <strtol+0x78>
  801737:	8b 45 08             	mov    0x8(%ebp),%eax
  80173a:	8a 00                	mov    (%eax),%al
  80173c:	3c 30                	cmp    $0x30,%al
  80173e:	75 17                	jne    801757 <strtol+0x78>
  801740:	8b 45 08             	mov    0x8(%ebp),%eax
  801743:	40                   	inc    %eax
  801744:	8a 00                	mov    (%eax),%al
  801746:	3c 78                	cmp    $0x78,%al
  801748:	75 0d                	jne    801757 <strtol+0x78>
		s += 2, base = 16;
  80174a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80174e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801755:	eb 28                	jmp    80177f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801757:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80175b:	75 15                	jne    801772 <strtol+0x93>
  80175d:	8b 45 08             	mov    0x8(%ebp),%eax
  801760:	8a 00                	mov    (%eax),%al
  801762:	3c 30                	cmp    $0x30,%al
  801764:	75 0c                	jne    801772 <strtol+0x93>
		s++, base = 8;
  801766:	ff 45 08             	incl   0x8(%ebp)
  801769:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801770:	eb 0d                	jmp    80177f <strtol+0xa0>
	else if (base == 0)
  801772:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801776:	75 07                	jne    80177f <strtol+0xa0>
		base = 10;
  801778:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80177f:	8b 45 08             	mov    0x8(%ebp),%eax
  801782:	8a 00                	mov    (%eax),%al
  801784:	3c 2f                	cmp    $0x2f,%al
  801786:	7e 19                	jle    8017a1 <strtol+0xc2>
  801788:	8b 45 08             	mov    0x8(%ebp),%eax
  80178b:	8a 00                	mov    (%eax),%al
  80178d:	3c 39                	cmp    $0x39,%al
  80178f:	7f 10                	jg     8017a1 <strtol+0xc2>
			dig = *s - '0';
  801791:	8b 45 08             	mov    0x8(%ebp),%eax
  801794:	8a 00                	mov    (%eax),%al
  801796:	0f be c0             	movsbl %al,%eax
  801799:	83 e8 30             	sub    $0x30,%eax
  80179c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80179f:	eb 42                	jmp    8017e3 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8017a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a4:	8a 00                	mov    (%eax),%al
  8017a6:	3c 60                	cmp    $0x60,%al
  8017a8:	7e 19                	jle    8017c3 <strtol+0xe4>
  8017aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ad:	8a 00                	mov    (%eax),%al
  8017af:	3c 7a                	cmp    $0x7a,%al
  8017b1:	7f 10                	jg     8017c3 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8017b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b6:	8a 00                	mov    (%eax),%al
  8017b8:	0f be c0             	movsbl %al,%eax
  8017bb:	83 e8 57             	sub    $0x57,%eax
  8017be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8017c1:	eb 20                	jmp    8017e3 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8017c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c6:	8a 00                	mov    (%eax),%al
  8017c8:	3c 40                	cmp    $0x40,%al
  8017ca:	7e 39                	jle    801805 <strtol+0x126>
  8017cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cf:	8a 00                	mov    (%eax),%al
  8017d1:	3c 5a                	cmp    $0x5a,%al
  8017d3:	7f 30                	jg     801805 <strtol+0x126>
			dig = *s - 'A' + 10;
  8017d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d8:	8a 00                	mov    (%eax),%al
  8017da:	0f be c0             	movsbl %al,%eax
  8017dd:	83 e8 37             	sub    $0x37,%eax
  8017e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8017e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017e6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8017e9:	7d 19                	jge    801804 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8017eb:	ff 45 08             	incl   0x8(%ebp)
  8017ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017f1:	0f af 45 10          	imul   0x10(%ebp),%eax
  8017f5:	89 c2                	mov    %eax,%edx
  8017f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017fa:	01 d0                	add    %edx,%eax
  8017fc:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017ff:	e9 7b ff ff ff       	jmp    80177f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801804:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801805:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801809:	74 08                	je     801813 <strtol+0x134>
		*endptr = (char *) s;
  80180b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80180e:	8b 55 08             	mov    0x8(%ebp),%edx
  801811:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801813:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801817:	74 07                	je     801820 <strtol+0x141>
  801819:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80181c:	f7 d8                	neg    %eax
  80181e:	eb 03                	jmp    801823 <strtol+0x144>
  801820:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801823:	c9                   	leave  
  801824:	c3                   	ret    

00801825 <ltostr>:

void
ltostr(long value, char *str)
{
  801825:	55                   	push   %ebp
  801826:	89 e5                	mov    %esp,%ebp
  801828:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80182b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801832:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801839:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80183d:	79 13                	jns    801852 <ltostr+0x2d>
	{
		neg = 1;
  80183f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801846:	8b 45 0c             	mov    0xc(%ebp),%eax
  801849:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80184c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80184f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801852:	8b 45 08             	mov    0x8(%ebp),%eax
  801855:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80185a:	99                   	cltd   
  80185b:	f7 f9                	idiv   %ecx
  80185d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801860:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801863:	8d 50 01             	lea    0x1(%eax),%edx
  801866:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801869:	89 c2                	mov    %eax,%edx
  80186b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80186e:	01 d0                	add    %edx,%eax
  801870:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801873:	83 c2 30             	add    $0x30,%edx
  801876:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801878:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80187b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801880:	f7 e9                	imul   %ecx
  801882:	c1 fa 02             	sar    $0x2,%edx
  801885:	89 c8                	mov    %ecx,%eax
  801887:	c1 f8 1f             	sar    $0x1f,%eax
  80188a:	29 c2                	sub    %eax,%edx
  80188c:	89 d0                	mov    %edx,%eax
  80188e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801891:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801894:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801899:	f7 e9                	imul   %ecx
  80189b:	c1 fa 02             	sar    $0x2,%edx
  80189e:	89 c8                	mov    %ecx,%eax
  8018a0:	c1 f8 1f             	sar    $0x1f,%eax
  8018a3:	29 c2                	sub    %eax,%edx
  8018a5:	89 d0                	mov    %edx,%eax
  8018a7:	c1 e0 02             	shl    $0x2,%eax
  8018aa:	01 d0                	add    %edx,%eax
  8018ac:	01 c0                	add    %eax,%eax
  8018ae:	29 c1                	sub    %eax,%ecx
  8018b0:	89 ca                	mov    %ecx,%edx
  8018b2:	85 d2                	test   %edx,%edx
  8018b4:	75 9c                	jne    801852 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8018b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8018bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018c0:	48                   	dec    %eax
  8018c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8018c4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018c8:	74 3d                	je     801907 <ltostr+0xe2>
		start = 1 ;
  8018ca:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8018d1:	eb 34                	jmp    801907 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8018d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d9:	01 d0                	add    %edx,%eax
  8018db:	8a 00                	mov    (%eax),%al
  8018dd:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8018e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018e6:	01 c2                	add    %eax,%edx
  8018e8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8018eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ee:	01 c8                	add    %ecx,%eax
  8018f0:	8a 00                	mov    (%eax),%al
  8018f2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8018f4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018fa:	01 c2                	add    %eax,%edx
  8018fc:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018ff:	88 02                	mov    %al,(%edx)
		start++ ;
  801901:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801904:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801907:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80190a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80190d:	7c c4                	jl     8018d3 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80190f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801912:	8b 45 0c             	mov    0xc(%ebp),%eax
  801915:	01 d0                	add    %edx,%eax
  801917:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80191a:	90                   	nop
  80191b:	c9                   	leave  
  80191c:	c3                   	ret    

0080191d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80191d:	55                   	push   %ebp
  80191e:	89 e5                	mov    %esp,%ebp
  801920:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801923:	ff 75 08             	pushl  0x8(%ebp)
  801926:	e8 54 fa ff ff       	call   80137f <strlen>
  80192b:	83 c4 04             	add    $0x4,%esp
  80192e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801931:	ff 75 0c             	pushl  0xc(%ebp)
  801934:	e8 46 fa ff ff       	call   80137f <strlen>
  801939:	83 c4 04             	add    $0x4,%esp
  80193c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80193f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801946:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80194d:	eb 17                	jmp    801966 <strcconcat+0x49>
		final[s] = str1[s] ;
  80194f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801952:	8b 45 10             	mov    0x10(%ebp),%eax
  801955:	01 c2                	add    %eax,%edx
  801957:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80195a:	8b 45 08             	mov    0x8(%ebp),%eax
  80195d:	01 c8                	add    %ecx,%eax
  80195f:	8a 00                	mov    (%eax),%al
  801961:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801963:	ff 45 fc             	incl   -0x4(%ebp)
  801966:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801969:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80196c:	7c e1                	jl     80194f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80196e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801975:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80197c:	eb 1f                	jmp    80199d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80197e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801981:	8d 50 01             	lea    0x1(%eax),%edx
  801984:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801987:	89 c2                	mov    %eax,%edx
  801989:	8b 45 10             	mov    0x10(%ebp),%eax
  80198c:	01 c2                	add    %eax,%edx
  80198e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801991:	8b 45 0c             	mov    0xc(%ebp),%eax
  801994:	01 c8                	add    %ecx,%eax
  801996:	8a 00                	mov    (%eax),%al
  801998:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80199a:	ff 45 f8             	incl   -0x8(%ebp)
  80199d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019a0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019a3:	7c d9                	jl     80197e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8019a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ab:	01 d0                	add    %edx,%eax
  8019ad:	c6 00 00             	movb   $0x0,(%eax)
}
  8019b0:	90                   	nop
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8019b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8019b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8019bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8019c2:	8b 00                	mov    (%eax),%eax
  8019c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ce:	01 d0                	add    %edx,%eax
  8019d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8019d6:	eb 0c                	jmp    8019e4 <strsplit+0x31>
			*string++ = 0;
  8019d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019db:	8d 50 01             	lea    0x1(%eax),%edx
  8019de:	89 55 08             	mov    %edx,0x8(%ebp)
  8019e1:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8019e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e7:	8a 00                	mov    (%eax),%al
  8019e9:	84 c0                	test   %al,%al
  8019eb:	74 18                	je     801a05 <strsplit+0x52>
  8019ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f0:	8a 00                	mov    (%eax),%al
  8019f2:	0f be c0             	movsbl %al,%eax
  8019f5:	50                   	push   %eax
  8019f6:	ff 75 0c             	pushl  0xc(%ebp)
  8019f9:	e8 13 fb ff ff       	call   801511 <strchr>
  8019fe:	83 c4 08             	add    $0x8,%esp
  801a01:	85 c0                	test   %eax,%eax
  801a03:	75 d3                	jne    8019d8 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801a05:	8b 45 08             	mov    0x8(%ebp),%eax
  801a08:	8a 00                	mov    (%eax),%al
  801a0a:	84 c0                	test   %al,%al
  801a0c:	74 5a                	je     801a68 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801a0e:	8b 45 14             	mov    0x14(%ebp),%eax
  801a11:	8b 00                	mov    (%eax),%eax
  801a13:	83 f8 0f             	cmp    $0xf,%eax
  801a16:	75 07                	jne    801a1f <strsplit+0x6c>
		{
			return 0;
  801a18:	b8 00 00 00 00       	mov    $0x0,%eax
  801a1d:	eb 66                	jmp    801a85 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801a1f:	8b 45 14             	mov    0x14(%ebp),%eax
  801a22:	8b 00                	mov    (%eax),%eax
  801a24:	8d 48 01             	lea    0x1(%eax),%ecx
  801a27:	8b 55 14             	mov    0x14(%ebp),%edx
  801a2a:	89 0a                	mov    %ecx,(%edx)
  801a2c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a33:	8b 45 10             	mov    0x10(%ebp),%eax
  801a36:	01 c2                	add    %eax,%edx
  801a38:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a3d:	eb 03                	jmp    801a42 <strsplit+0x8f>
			string++;
  801a3f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a42:	8b 45 08             	mov    0x8(%ebp),%eax
  801a45:	8a 00                	mov    (%eax),%al
  801a47:	84 c0                	test   %al,%al
  801a49:	74 8b                	je     8019d6 <strsplit+0x23>
  801a4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4e:	8a 00                	mov    (%eax),%al
  801a50:	0f be c0             	movsbl %al,%eax
  801a53:	50                   	push   %eax
  801a54:	ff 75 0c             	pushl  0xc(%ebp)
  801a57:	e8 b5 fa ff ff       	call   801511 <strchr>
  801a5c:	83 c4 08             	add    $0x8,%esp
  801a5f:	85 c0                	test   %eax,%eax
  801a61:	74 dc                	je     801a3f <strsplit+0x8c>
			string++;
	}
  801a63:	e9 6e ff ff ff       	jmp    8019d6 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a68:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a69:	8b 45 14             	mov    0x14(%ebp),%eax
  801a6c:	8b 00                	mov    (%eax),%eax
  801a6e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a75:	8b 45 10             	mov    0x10(%ebp),%eax
  801a78:	01 d0                	add    %edx,%eax
  801a7a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a80:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a85:	c9                   	leave  
  801a86:	c3                   	ret    

00801a87 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a87:	55                   	push   %ebp
  801a88:	89 e5                	mov    %esp,%ebp
  801a8a:	57                   	push   %edi
  801a8b:	56                   	push   %esi
  801a8c:	53                   	push   %ebx
  801a8d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a90:	8b 45 08             	mov    0x8(%ebp),%eax
  801a93:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a96:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a99:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a9c:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a9f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801aa2:	cd 30                	int    $0x30
  801aa4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801aa7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801aaa:	83 c4 10             	add    $0x10,%esp
  801aad:	5b                   	pop    %ebx
  801aae:	5e                   	pop    %esi
  801aaf:	5f                   	pop    %edi
  801ab0:	5d                   	pop    %ebp
  801ab1:	c3                   	ret    

00801ab2 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801ab2:	55                   	push   %ebp
  801ab3:	89 e5                	mov    %esp,%ebp
  801ab5:	83 ec 04             	sub    $0x4,%esp
  801ab8:	8b 45 10             	mov    0x10(%ebp),%eax
  801abb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801abe:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	52                   	push   %edx
  801aca:	ff 75 0c             	pushl  0xc(%ebp)
  801acd:	50                   	push   %eax
  801ace:	6a 00                	push   $0x0
  801ad0:	e8 b2 ff ff ff       	call   801a87 <syscall>
  801ad5:	83 c4 18             	add    $0x18,%esp
}
  801ad8:	90                   	nop
  801ad9:	c9                   	leave  
  801ada:	c3                   	ret    

00801adb <sys_cgetc>:

int
sys_cgetc(void)
{
  801adb:	55                   	push   %ebp
  801adc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 01                	push   $0x1
  801aea:	e8 98 ff ff ff       	call   801a87 <syscall>
  801aef:	83 c4 18             	add    $0x18,%esp
}
  801af2:	c9                   	leave  
  801af3:	c3                   	ret    

00801af4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801af4:	55                   	push   %ebp
  801af5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801af7:	8b 45 08             	mov    0x8(%ebp),%eax
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	50                   	push   %eax
  801b03:	6a 05                	push   $0x5
  801b05:	e8 7d ff ff ff       	call   801a87 <syscall>
  801b0a:	83 c4 18             	add    $0x18,%esp
}
  801b0d:	c9                   	leave  
  801b0e:	c3                   	ret    

00801b0f <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b0f:	55                   	push   %ebp
  801b10:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 02                	push   $0x2
  801b1e:	e8 64 ff ff ff       	call   801a87 <syscall>
  801b23:	83 c4 18             	add    $0x18,%esp
}
  801b26:	c9                   	leave  
  801b27:	c3                   	ret    

00801b28 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 03                	push   $0x3
  801b37:	e8 4b ff ff ff       	call   801a87 <syscall>
  801b3c:	83 c4 18             	add    $0x18,%esp
}
  801b3f:	c9                   	leave  
  801b40:	c3                   	ret    

00801b41 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 04                	push   $0x4
  801b50:	e8 32 ff ff ff       	call   801a87 <syscall>
  801b55:	83 c4 18             	add    $0x18,%esp
}
  801b58:	c9                   	leave  
  801b59:	c3                   	ret    

00801b5a <sys_env_exit>:


void sys_env_exit(void)
{
  801b5a:	55                   	push   %ebp
  801b5b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 06                	push   $0x6
  801b69:	e8 19 ff ff ff       	call   801a87 <syscall>
  801b6e:	83 c4 18             	add    $0x18,%esp
}
  801b71:	90                   	nop
  801b72:	c9                   	leave  
  801b73:	c3                   	ret    

00801b74 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b74:	55                   	push   %ebp
  801b75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b77:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 00                	push   $0x0
  801b83:	52                   	push   %edx
  801b84:	50                   	push   %eax
  801b85:	6a 07                	push   $0x7
  801b87:	e8 fb fe ff ff       	call   801a87 <syscall>
  801b8c:	83 c4 18             	add    $0x18,%esp
}
  801b8f:	c9                   	leave  
  801b90:	c3                   	ret    

00801b91 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b91:	55                   	push   %ebp
  801b92:	89 e5                	mov    %esp,%ebp
  801b94:	56                   	push   %esi
  801b95:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b96:	8b 75 18             	mov    0x18(%ebp),%esi
  801b99:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b9c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba5:	56                   	push   %esi
  801ba6:	53                   	push   %ebx
  801ba7:	51                   	push   %ecx
  801ba8:	52                   	push   %edx
  801ba9:	50                   	push   %eax
  801baa:	6a 08                	push   $0x8
  801bac:	e8 d6 fe ff ff       	call   801a87 <syscall>
  801bb1:	83 c4 18             	add    $0x18,%esp
}
  801bb4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801bb7:	5b                   	pop    %ebx
  801bb8:	5e                   	pop    %esi
  801bb9:	5d                   	pop    %ebp
  801bba:	c3                   	ret    

00801bbb <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801bbb:	55                   	push   %ebp
  801bbc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801bbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	52                   	push   %edx
  801bcb:	50                   	push   %eax
  801bcc:	6a 09                	push   $0x9
  801bce:	e8 b4 fe ff ff       	call   801a87 <syscall>
  801bd3:	83 c4 18             	add    $0x18,%esp
}
  801bd6:	c9                   	leave  
  801bd7:	c3                   	ret    

00801bd8 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801bd8:	55                   	push   %ebp
  801bd9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	ff 75 0c             	pushl  0xc(%ebp)
  801be4:	ff 75 08             	pushl  0x8(%ebp)
  801be7:	6a 0a                	push   $0xa
  801be9:	e8 99 fe ff ff       	call   801a87 <syscall>
  801bee:	83 c4 18             	add    $0x18,%esp
}
  801bf1:	c9                   	leave  
  801bf2:	c3                   	ret    

00801bf3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801bf3:	55                   	push   %ebp
  801bf4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 0b                	push   $0xb
  801c02:	e8 80 fe ff ff       	call   801a87 <syscall>
  801c07:	83 c4 18             	add    $0x18,%esp
}
  801c0a:	c9                   	leave  
  801c0b:	c3                   	ret    

00801c0c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c0c:	55                   	push   %ebp
  801c0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 0c                	push   $0xc
  801c1b:	e8 67 fe ff ff       	call   801a87 <syscall>
  801c20:	83 c4 18             	add    $0x18,%esp
}
  801c23:	c9                   	leave  
  801c24:	c3                   	ret    

00801c25 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c25:	55                   	push   %ebp
  801c26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c28:	6a 00                	push   $0x0
  801c2a:	6a 00                	push   $0x0
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 0d                	push   $0xd
  801c34:	e8 4e fe ff ff       	call   801a87 <syscall>
  801c39:	83 c4 18             	add    $0x18,%esp
}
  801c3c:	c9                   	leave  
  801c3d:	c3                   	ret    

00801c3e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c3e:	55                   	push   %ebp
  801c3f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c41:	6a 00                	push   $0x0
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	ff 75 0c             	pushl  0xc(%ebp)
  801c4a:	ff 75 08             	pushl  0x8(%ebp)
  801c4d:	6a 11                	push   $0x11
  801c4f:	e8 33 fe ff ff       	call   801a87 <syscall>
  801c54:	83 c4 18             	add    $0x18,%esp
	return;
  801c57:	90                   	nop
}
  801c58:	c9                   	leave  
  801c59:	c3                   	ret    

00801c5a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c5a:	55                   	push   %ebp
  801c5b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	ff 75 0c             	pushl  0xc(%ebp)
  801c66:	ff 75 08             	pushl  0x8(%ebp)
  801c69:	6a 12                	push   $0x12
  801c6b:	e8 17 fe ff ff       	call   801a87 <syscall>
  801c70:	83 c4 18             	add    $0x18,%esp
	return ;
  801c73:	90                   	nop
}
  801c74:	c9                   	leave  
  801c75:	c3                   	ret    

00801c76 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c76:	55                   	push   %ebp
  801c77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	6a 0e                	push   $0xe
  801c85:	e8 fd fd ff ff       	call   801a87 <syscall>
  801c8a:	83 c4 18             	add    $0x18,%esp
}
  801c8d:	c9                   	leave  
  801c8e:	c3                   	ret    

00801c8f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c8f:	55                   	push   %ebp
  801c90:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 00                	push   $0x0
  801c9a:	ff 75 08             	pushl  0x8(%ebp)
  801c9d:	6a 0f                	push   $0xf
  801c9f:	e8 e3 fd ff ff       	call   801a87 <syscall>
  801ca4:	83 c4 18             	add    $0x18,%esp
}
  801ca7:	c9                   	leave  
  801ca8:	c3                   	ret    

00801ca9 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ca9:	55                   	push   %ebp
  801caa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 10                	push   $0x10
  801cb8:	e8 ca fd ff ff       	call   801a87 <syscall>
  801cbd:	83 c4 18             	add    $0x18,%esp
}
  801cc0:	90                   	nop
  801cc1:	c9                   	leave  
  801cc2:	c3                   	ret    

00801cc3 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801cc3:	55                   	push   %ebp
  801cc4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 14                	push   $0x14
  801cd2:	e8 b0 fd ff ff       	call   801a87 <syscall>
  801cd7:	83 c4 18             	add    $0x18,%esp
}
  801cda:	90                   	nop
  801cdb:	c9                   	leave  
  801cdc:	c3                   	ret    

00801cdd <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801cdd:	55                   	push   %ebp
  801cde:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 15                	push   $0x15
  801cec:	e8 96 fd ff ff       	call   801a87 <syscall>
  801cf1:	83 c4 18             	add    $0x18,%esp
}
  801cf4:	90                   	nop
  801cf5:	c9                   	leave  
  801cf6:	c3                   	ret    

00801cf7 <sys_cputc>:


void
sys_cputc(const char c)
{
  801cf7:	55                   	push   %ebp
  801cf8:	89 e5                	mov    %esp,%ebp
  801cfa:	83 ec 04             	sub    $0x4,%esp
  801cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  801d00:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d03:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	50                   	push   %eax
  801d10:	6a 16                	push   $0x16
  801d12:	e8 70 fd ff ff       	call   801a87 <syscall>
  801d17:	83 c4 18             	add    $0x18,%esp
}
  801d1a:	90                   	nop
  801d1b:	c9                   	leave  
  801d1c:	c3                   	ret    

00801d1d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d1d:	55                   	push   %ebp
  801d1e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 17                	push   $0x17
  801d2c:	e8 56 fd ff ff       	call   801a87 <syscall>
  801d31:	83 c4 18             	add    $0x18,%esp
}
  801d34:	90                   	nop
  801d35:	c9                   	leave  
  801d36:	c3                   	ret    

00801d37 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d37:	55                   	push   %ebp
  801d38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	ff 75 0c             	pushl  0xc(%ebp)
  801d46:	50                   	push   %eax
  801d47:	6a 18                	push   $0x18
  801d49:	e8 39 fd ff ff       	call   801a87 <syscall>
  801d4e:	83 c4 18             	add    $0x18,%esp
}
  801d51:	c9                   	leave  
  801d52:	c3                   	ret    

00801d53 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d53:	55                   	push   %ebp
  801d54:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d56:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d59:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	52                   	push   %edx
  801d63:	50                   	push   %eax
  801d64:	6a 1b                	push   $0x1b
  801d66:	e8 1c fd ff ff       	call   801a87 <syscall>
  801d6b:	83 c4 18             	add    $0x18,%esp
}
  801d6e:	c9                   	leave  
  801d6f:	c3                   	ret    

00801d70 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d70:	55                   	push   %ebp
  801d71:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d73:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d76:	8b 45 08             	mov    0x8(%ebp),%eax
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	52                   	push   %edx
  801d80:	50                   	push   %eax
  801d81:	6a 19                	push   $0x19
  801d83:	e8 ff fc ff ff       	call   801a87 <syscall>
  801d88:	83 c4 18             	add    $0x18,%esp
}
  801d8b:	90                   	nop
  801d8c:	c9                   	leave  
  801d8d:	c3                   	ret    

00801d8e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d8e:	55                   	push   %ebp
  801d8f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d91:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d94:	8b 45 08             	mov    0x8(%ebp),%eax
  801d97:	6a 00                	push   $0x0
  801d99:	6a 00                	push   $0x0
  801d9b:	6a 00                	push   $0x0
  801d9d:	52                   	push   %edx
  801d9e:	50                   	push   %eax
  801d9f:	6a 1a                	push   $0x1a
  801da1:	e8 e1 fc ff ff       	call   801a87 <syscall>
  801da6:	83 c4 18             	add    $0x18,%esp
}
  801da9:	90                   	nop
  801daa:	c9                   	leave  
  801dab:	c3                   	ret    

00801dac <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801dac:	55                   	push   %ebp
  801dad:	89 e5                	mov    %esp,%ebp
  801daf:	83 ec 04             	sub    $0x4,%esp
  801db2:	8b 45 10             	mov    0x10(%ebp),%eax
  801db5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801db8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801dbb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc2:	6a 00                	push   $0x0
  801dc4:	51                   	push   %ecx
  801dc5:	52                   	push   %edx
  801dc6:	ff 75 0c             	pushl  0xc(%ebp)
  801dc9:	50                   	push   %eax
  801dca:	6a 1c                	push   $0x1c
  801dcc:	e8 b6 fc ff ff       	call   801a87 <syscall>
  801dd1:	83 c4 18             	add    $0x18,%esp
}
  801dd4:	c9                   	leave  
  801dd5:	c3                   	ret    

00801dd6 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801dd6:	55                   	push   %ebp
  801dd7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801dd9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	52                   	push   %edx
  801de6:	50                   	push   %eax
  801de7:	6a 1d                	push   $0x1d
  801de9:	e8 99 fc ff ff       	call   801a87 <syscall>
  801dee:	83 c4 18             	add    $0x18,%esp
}
  801df1:	c9                   	leave  
  801df2:	c3                   	ret    

00801df3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801df3:	55                   	push   %ebp
  801df4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801df6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801df9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801dff:	6a 00                	push   $0x0
  801e01:	6a 00                	push   $0x0
  801e03:	51                   	push   %ecx
  801e04:	52                   	push   %edx
  801e05:	50                   	push   %eax
  801e06:	6a 1e                	push   $0x1e
  801e08:	e8 7a fc ff ff       	call   801a87 <syscall>
  801e0d:	83 c4 18             	add    $0x18,%esp
}
  801e10:	c9                   	leave  
  801e11:	c3                   	ret    

00801e12 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e12:	55                   	push   %ebp
  801e13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e15:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e18:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 00                	push   $0x0
  801e21:	52                   	push   %edx
  801e22:	50                   	push   %eax
  801e23:	6a 1f                	push   $0x1f
  801e25:	e8 5d fc ff ff       	call   801a87 <syscall>
  801e2a:	83 c4 18             	add    $0x18,%esp
}
  801e2d:	c9                   	leave  
  801e2e:	c3                   	ret    

00801e2f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e2f:	55                   	push   %ebp
  801e30:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 20                	push   $0x20
  801e3e:	e8 44 fc ff ff       	call   801a87 <syscall>
  801e43:	83 c4 18             	add    $0x18,%esp
}
  801e46:	c9                   	leave  
  801e47:	c3                   	ret    

00801e48 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801e48:	55                   	push   %ebp
  801e49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	ff 75 10             	pushl  0x10(%ebp)
  801e55:	ff 75 0c             	pushl  0xc(%ebp)
  801e58:	50                   	push   %eax
  801e59:	6a 21                	push   $0x21
  801e5b:	e8 27 fc ff ff       	call   801a87 <syscall>
  801e60:	83 c4 18             	add    $0x18,%esp
}
  801e63:	c9                   	leave  
  801e64:	c3                   	ret    

00801e65 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801e65:	55                   	push   %ebp
  801e66:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e68:	8b 45 08             	mov    0x8(%ebp),%eax
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 00                	push   $0x0
  801e73:	50                   	push   %eax
  801e74:	6a 22                	push   $0x22
  801e76:	e8 0c fc ff ff       	call   801a87 <syscall>
  801e7b:	83 c4 18             	add    $0x18,%esp
}
  801e7e:	90                   	nop
  801e7f:	c9                   	leave  
  801e80:	c3                   	ret    

00801e81 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e81:	55                   	push   %ebp
  801e82:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e84:	8b 45 08             	mov    0x8(%ebp),%eax
  801e87:	6a 00                	push   $0x0
  801e89:	6a 00                	push   $0x0
  801e8b:	6a 00                	push   $0x0
  801e8d:	6a 00                	push   $0x0
  801e8f:	50                   	push   %eax
  801e90:	6a 23                	push   $0x23
  801e92:	e8 f0 fb ff ff       	call   801a87 <syscall>
  801e97:	83 c4 18             	add    $0x18,%esp
}
  801e9a:	90                   	nop
  801e9b:	c9                   	leave  
  801e9c:	c3                   	ret    

00801e9d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e9d:	55                   	push   %ebp
  801e9e:	89 e5                	mov    %esp,%ebp
  801ea0:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ea3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ea6:	8d 50 04             	lea    0x4(%eax),%edx
  801ea9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801eac:	6a 00                	push   $0x0
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 00                	push   $0x0
  801eb2:	52                   	push   %edx
  801eb3:	50                   	push   %eax
  801eb4:	6a 24                	push   $0x24
  801eb6:	e8 cc fb ff ff       	call   801a87 <syscall>
  801ebb:	83 c4 18             	add    $0x18,%esp
	return result;
  801ebe:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ec1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ec4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ec7:	89 01                	mov    %eax,(%ecx)
  801ec9:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ecf:	c9                   	leave  
  801ed0:	c2 04 00             	ret    $0x4

00801ed3 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ed3:	55                   	push   %ebp
  801ed4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801ed6:	6a 00                	push   $0x0
  801ed8:	6a 00                	push   $0x0
  801eda:	ff 75 10             	pushl  0x10(%ebp)
  801edd:	ff 75 0c             	pushl  0xc(%ebp)
  801ee0:	ff 75 08             	pushl  0x8(%ebp)
  801ee3:	6a 13                	push   $0x13
  801ee5:	e8 9d fb ff ff       	call   801a87 <syscall>
  801eea:	83 c4 18             	add    $0x18,%esp
	return ;
  801eed:	90                   	nop
}
  801eee:	c9                   	leave  
  801eef:	c3                   	ret    

00801ef0 <sys_rcr2>:
uint32 sys_rcr2()
{
  801ef0:	55                   	push   %ebp
  801ef1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801ef3:	6a 00                	push   $0x0
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	6a 25                	push   $0x25
  801eff:	e8 83 fb ff ff       	call   801a87 <syscall>
  801f04:	83 c4 18             	add    $0x18,%esp
}
  801f07:	c9                   	leave  
  801f08:	c3                   	ret    

00801f09 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f09:	55                   	push   %ebp
  801f0a:	89 e5                	mov    %esp,%ebp
  801f0c:	83 ec 04             	sub    $0x4,%esp
  801f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f12:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f15:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f19:	6a 00                	push   $0x0
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	50                   	push   %eax
  801f22:	6a 26                	push   $0x26
  801f24:	e8 5e fb ff ff       	call   801a87 <syscall>
  801f29:	83 c4 18             	add    $0x18,%esp
	return ;
  801f2c:	90                   	nop
}
  801f2d:	c9                   	leave  
  801f2e:	c3                   	ret    

00801f2f <rsttst>:
void rsttst()
{
  801f2f:	55                   	push   %ebp
  801f30:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 28                	push   $0x28
  801f3e:	e8 44 fb ff ff       	call   801a87 <syscall>
  801f43:	83 c4 18             	add    $0x18,%esp
	return ;
  801f46:	90                   	nop
}
  801f47:	c9                   	leave  
  801f48:	c3                   	ret    

00801f49 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f49:	55                   	push   %ebp
  801f4a:	89 e5                	mov    %esp,%ebp
  801f4c:	83 ec 04             	sub    $0x4,%esp
  801f4f:	8b 45 14             	mov    0x14(%ebp),%eax
  801f52:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f55:	8b 55 18             	mov    0x18(%ebp),%edx
  801f58:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f5c:	52                   	push   %edx
  801f5d:	50                   	push   %eax
  801f5e:	ff 75 10             	pushl  0x10(%ebp)
  801f61:	ff 75 0c             	pushl  0xc(%ebp)
  801f64:	ff 75 08             	pushl  0x8(%ebp)
  801f67:	6a 27                	push   $0x27
  801f69:	e8 19 fb ff ff       	call   801a87 <syscall>
  801f6e:	83 c4 18             	add    $0x18,%esp
	return ;
  801f71:	90                   	nop
}
  801f72:	c9                   	leave  
  801f73:	c3                   	ret    

00801f74 <chktst>:
void chktst(uint32 n)
{
  801f74:	55                   	push   %ebp
  801f75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	ff 75 08             	pushl  0x8(%ebp)
  801f82:	6a 29                	push   $0x29
  801f84:	e8 fe fa ff ff       	call   801a87 <syscall>
  801f89:	83 c4 18             	add    $0x18,%esp
	return ;
  801f8c:	90                   	nop
}
  801f8d:	c9                   	leave  
  801f8e:	c3                   	ret    

00801f8f <inctst>:

void inctst()
{
  801f8f:	55                   	push   %ebp
  801f90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 2a                	push   $0x2a
  801f9e:	e8 e4 fa ff ff       	call   801a87 <syscall>
  801fa3:	83 c4 18             	add    $0x18,%esp
	return ;
  801fa6:	90                   	nop
}
  801fa7:	c9                   	leave  
  801fa8:	c3                   	ret    

00801fa9 <gettst>:
uint32 gettst()
{
  801fa9:	55                   	push   %ebp
  801faa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 2b                	push   $0x2b
  801fb8:	e8 ca fa ff ff       	call   801a87 <syscall>
  801fbd:	83 c4 18             	add    $0x18,%esp
}
  801fc0:	c9                   	leave  
  801fc1:	c3                   	ret    

00801fc2 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801fc2:	55                   	push   %ebp
  801fc3:	89 e5                	mov    %esp,%ebp
  801fc5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fc8:	6a 00                	push   $0x0
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 00                	push   $0x0
  801fd2:	6a 2c                	push   $0x2c
  801fd4:	e8 ae fa ff ff       	call   801a87 <syscall>
  801fd9:	83 c4 18             	add    $0x18,%esp
  801fdc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801fdf:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801fe3:	75 07                	jne    801fec <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801fe5:	b8 01 00 00 00       	mov    $0x1,%eax
  801fea:	eb 05                	jmp    801ff1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801fec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ff1:	c9                   	leave  
  801ff2:	c3                   	ret    

00801ff3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801ff3:	55                   	push   %ebp
  801ff4:	89 e5                	mov    %esp,%ebp
  801ff6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 2c                	push   $0x2c
  802005:	e8 7d fa ff ff       	call   801a87 <syscall>
  80200a:	83 c4 18             	add    $0x18,%esp
  80200d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802010:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802014:	75 07                	jne    80201d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802016:	b8 01 00 00 00       	mov    $0x1,%eax
  80201b:	eb 05                	jmp    802022 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80201d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802022:	c9                   	leave  
  802023:	c3                   	ret    

00802024 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802024:	55                   	push   %ebp
  802025:	89 e5                	mov    %esp,%ebp
  802027:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80202a:	6a 00                	push   $0x0
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	6a 00                	push   $0x0
  802032:	6a 00                	push   $0x0
  802034:	6a 2c                	push   $0x2c
  802036:	e8 4c fa ff ff       	call   801a87 <syscall>
  80203b:	83 c4 18             	add    $0x18,%esp
  80203e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802041:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802045:	75 07                	jne    80204e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802047:	b8 01 00 00 00       	mov    $0x1,%eax
  80204c:	eb 05                	jmp    802053 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80204e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802053:	c9                   	leave  
  802054:	c3                   	ret    

00802055 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802055:	55                   	push   %ebp
  802056:	89 e5                	mov    %esp,%ebp
  802058:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80205b:	6a 00                	push   $0x0
  80205d:	6a 00                	push   $0x0
  80205f:	6a 00                	push   $0x0
  802061:	6a 00                	push   $0x0
  802063:	6a 00                	push   $0x0
  802065:	6a 2c                	push   $0x2c
  802067:	e8 1b fa ff ff       	call   801a87 <syscall>
  80206c:	83 c4 18             	add    $0x18,%esp
  80206f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802072:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802076:	75 07                	jne    80207f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802078:	b8 01 00 00 00       	mov    $0x1,%eax
  80207d:	eb 05                	jmp    802084 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80207f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802084:	c9                   	leave  
  802085:	c3                   	ret    

00802086 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802086:	55                   	push   %ebp
  802087:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802089:	6a 00                	push   $0x0
  80208b:	6a 00                	push   $0x0
  80208d:	6a 00                	push   $0x0
  80208f:	6a 00                	push   $0x0
  802091:	ff 75 08             	pushl  0x8(%ebp)
  802094:	6a 2d                	push   $0x2d
  802096:	e8 ec f9 ff ff       	call   801a87 <syscall>
  80209b:	83 c4 18             	add    $0x18,%esp
	return ;
  80209e:	90                   	nop
}
  80209f:	c9                   	leave  
  8020a0:	c3                   	ret    

008020a1 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8020a1:	55                   	push   %ebp
  8020a2:	89 e5                	mov    %esp,%ebp
  8020a4:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8020a7:	8b 55 08             	mov    0x8(%ebp),%edx
  8020aa:	89 d0                	mov    %edx,%eax
  8020ac:	c1 e0 02             	shl    $0x2,%eax
  8020af:	01 d0                	add    %edx,%eax
  8020b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8020b8:	01 d0                	add    %edx,%eax
  8020ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8020c1:	01 d0                	add    %edx,%eax
  8020c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8020ca:	01 d0                	add    %edx,%eax
  8020cc:	c1 e0 04             	shl    $0x4,%eax
  8020cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8020d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8020d9:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8020dc:	83 ec 0c             	sub    $0xc,%esp
  8020df:	50                   	push   %eax
  8020e0:	e8 b8 fd ff ff       	call   801e9d <sys_get_virtual_time>
  8020e5:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8020e8:	eb 41                	jmp    80212b <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8020ea:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8020ed:	83 ec 0c             	sub    $0xc,%esp
  8020f0:	50                   	push   %eax
  8020f1:	e8 a7 fd ff ff       	call   801e9d <sys_get_virtual_time>
  8020f6:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8020f9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8020fc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8020ff:	29 c2                	sub    %eax,%edx
  802101:	89 d0                	mov    %edx,%eax
  802103:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  802106:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802109:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80210c:	89 d1                	mov    %edx,%ecx
  80210e:	29 c1                	sub    %eax,%ecx
  802110:	8b 55 d8             	mov    -0x28(%ebp),%edx
  802113:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802116:	39 c2                	cmp    %eax,%edx
  802118:	0f 97 c0             	seta   %al
  80211b:	0f b6 c0             	movzbl %al,%eax
  80211e:	29 c1                	sub    %eax,%ecx
  802120:	89 c8                	mov    %ecx,%eax
  802122:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  802125:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802128:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80212b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80212e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802131:	72 b7                	jb     8020ea <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  802133:	90                   	nop
  802134:	c9                   	leave  
  802135:	c3                   	ret    

00802136 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  802136:	55                   	push   %ebp
  802137:	89 e5                	mov    %esp,%ebp
  802139:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80213c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  802143:	eb 03                	jmp    802148 <busy_wait+0x12>
  802145:	ff 45 fc             	incl   -0x4(%ebp)
  802148:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80214b:	3b 45 08             	cmp    0x8(%ebp),%eax
  80214e:	72 f5                	jb     802145 <busy_wait+0xf>
	return i;
  802150:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802153:	c9                   	leave  
  802154:	c3                   	ret    
  802155:	66 90                	xchg   %ax,%ax
  802157:	90                   	nop

00802158 <__udivdi3>:
  802158:	55                   	push   %ebp
  802159:	57                   	push   %edi
  80215a:	56                   	push   %esi
  80215b:	53                   	push   %ebx
  80215c:	83 ec 1c             	sub    $0x1c,%esp
  80215f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802163:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802167:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80216b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80216f:	89 ca                	mov    %ecx,%edx
  802171:	89 f8                	mov    %edi,%eax
  802173:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802177:	85 f6                	test   %esi,%esi
  802179:	75 2d                	jne    8021a8 <__udivdi3+0x50>
  80217b:	39 cf                	cmp    %ecx,%edi
  80217d:	77 65                	ja     8021e4 <__udivdi3+0x8c>
  80217f:	89 fd                	mov    %edi,%ebp
  802181:	85 ff                	test   %edi,%edi
  802183:	75 0b                	jne    802190 <__udivdi3+0x38>
  802185:	b8 01 00 00 00       	mov    $0x1,%eax
  80218a:	31 d2                	xor    %edx,%edx
  80218c:	f7 f7                	div    %edi
  80218e:	89 c5                	mov    %eax,%ebp
  802190:	31 d2                	xor    %edx,%edx
  802192:	89 c8                	mov    %ecx,%eax
  802194:	f7 f5                	div    %ebp
  802196:	89 c1                	mov    %eax,%ecx
  802198:	89 d8                	mov    %ebx,%eax
  80219a:	f7 f5                	div    %ebp
  80219c:	89 cf                	mov    %ecx,%edi
  80219e:	89 fa                	mov    %edi,%edx
  8021a0:	83 c4 1c             	add    $0x1c,%esp
  8021a3:	5b                   	pop    %ebx
  8021a4:	5e                   	pop    %esi
  8021a5:	5f                   	pop    %edi
  8021a6:	5d                   	pop    %ebp
  8021a7:	c3                   	ret    
  8021a8:	39 ce                	cmp    %ecx,%esi
  8021aa:	77 28                	ja     8021d4 <__udivdi3+0x7c>
  8021ac:	0f bd fe             	bsr    %esi,%edi
  8021af:	83 f7 1f             	xor    $0x1f,%edi
  8021b2:	75 40                	jne    8021f4 <__udivdi3+0x9c>
  8021b4:	39 ce                	cmp    %ecx,%esi
  8021b6:	72 0a                	jb     8021c2 <__udivdi3+0x6a>
  8021b8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8021bc:	0f 87 9e 00 00 00    	ja     802260 <__udivdi3+0x108>
  8021c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8021c7:	89 fa                	mov    %edi,%edx
  8021c9:	83 c4 1c             	add    $0x1c,%esp
  8021cc:	5b                   	pop    %ebx
  8021cd:	5e                   	pop    %esi
  8021ce:	5f                   	pop    %edi
  8021cf:	5d                   	pop    %ebp
  8021d0:	c3                   	ret    
  8021d1:	8d 76 00             	lea    0x0(%esi),%esi
  8021d4:	31 ff                	xor    %edi,%edi
  8021d6:	31 c0                	xor    %eax,%eax
  8021d8:	89 fa                	mov    %edi,%edx
  8021da:	83 c4 1c             	add    $0x1c,%esp
  8021dd:	5b                   	pop    %ebx
  8021de:	5e                   	pop    %esi
  8021df:	5f                   	pop    %edi
  8021e0:	5d                   	pop    %ebp
  8021e1:	c3                   	ret    
  8021e2:	66 90                	xchg   %ax,%ax
  8021e4:	89 d8                	mov    %ebx,%eax
  8021e6:	f7 f7                	div    %edi
  8021e8:	31 ff                	xor    %edi,%edi
  8021ea:	89 fa                	mov    %edi,%edx
  8021ec:	83 c4 1c             	add    $0x1c,%esp
  8021ef:	5b                   	pop    %ebx
  8021f0:	5e                   	pop    %esi
  8021f1:	5f                   	pop    %edi
  8021f2:	5d                   	pop    %ebp
  8021f3:	c3                   	ret    
  8021f4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8021f9:	89 eb                	mov    %ebp,%ebx
  8021fb:	29 fb                	sub    %edi,%ebx
  8021fd:	89 f9                	mov    %edi,%ecx
  8021ff:	d3 e6                	shl    %cl,%esi
  802201:	89 c5                	mov    %eax,%ebp
  802203:	88 d9                	mov    %bl,%cl
  802205:	d3 ed                	shr    %cl,%ebp
  802207:	89 e9                	mov    %ebp,%ecx
  802209:	09 f1                	or     %esi,%ecx
  80220b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80220f:	89 f9                	mov    %edi,%ecx
  802211:	d3 e0                	shl    %cl,%eax
  802213:	89 c5                	mov    %eax,%ebp
  802215:	89 d6                	mov    %edx,%esi
  802217:	88 d9                	mov    %bl,%cl
  802219:	d3 ee                	shr    %cl,%esi
  80221b:	89 f9                	mov    %edi,%ecx
  80221d:	d3 e2                	shl    %cl,%edx
  80221f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802223:	88 d9                	mov    %bl,%cl
  802225:	d3 e8                	shr    %cl,%eax
  802227:	09 c2                	or     %eax,%edx
  802229:	89 d0                	mov    %edx,%eax
  80222b:	89 f2                	mov    %esi,%edx
  80222d:	f7 74 24 0c          	divl   0xc(%esp)
  802231:	89 d6                	mov    %edx,%esi
  802233:	89 c3                	mov    %eax,%ebx
  802235:	f7 e5                	mul    %ebp
  802237:	39 d6                	cmp    %edx,%esi
  802239:	72 19                	jb     802254 <__udivdi3+0xfc>
  80223b:	74 0b                	je     802248 <__udivdi3+0xf0>
  80223d:	89 d8                	mov    %ebx,%eax
  80223f:	31 ff                	xor    %edi,%edi
  802241:	e9 58 ff ff ff       	jmp    80219e <__udivdi3+0x46>
  802246:	66 90                	xchg   %ax,%ax
  802248:	8b 54 24 08          	mov    0x8(%esp),%edx
  80224c:	89 f9                	mov    %edi,%ecx
  80224e:	d3 e2                	shl    %cl,%edx
  802250:	39 c2                	cmp    %eax,%edx
  802252:	73 e9                	jae    80223d <__udivdi3+0xe5>
  802254:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802257:	31 ff                	xor    %edi,%edi
  802259:	e9 40 ff ff ff       	jmp    80219e <__udivdi3+0x46>
  80225e:	66 90                	xchg   %ax,%ax
  802260:	31 c0                	xor    %eax,%eax
  802262:	e9 37 ff ff ff       	jmp    80219e <__udivdi3+0x46>
  802267:	90                   	nop

00802268 <__umoddi3>:
  802268:	55                   	push   %ebp
  802269:	57                   	push   %edi
  80226a:	56                   	push   %esi
  80226b:	53                   	push   %ebx
  80226c:	83 ec 1c             	sub    $0x1c,%esp
  80226f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802273:	8b 74 24 34          	mov    0x34(%esp),%esi
  802277:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80227b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80227f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802283:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802287:	89 f3                	mov    %esi,%ebx
  802289:	89 fa                	mov    %edi,%edx
  80228b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80228f:	89 34 24             	mov    %esi,(%esp)
  802292:	85 c0                	test   %eax,%eax
  802294:	75 1a                	jne    8022b0 <__umoddi3+0x48>
  802296:	39 f7                	cmp    %esi,%edi
  802298:	0f 86 a2 00 00 00    	jbe    802340 <__umoddi3+0xd8>
  80229e:	89 c8                	mov    %ecx,%eax
  8022a0:	89 f2                	mov    %esi,%edx
  8022a2:	f7 f7                	div    %edi
  8022a4:	89 d0                	mov    %edx,%eax
  8022a6:	31 d2                	xor    %edx,%edx
  8022a8:	83 c4 1c             	add    $0x1c,%esp
  8022ab:	5b                   	pop    %ebx
  8022ac:	5e                   	pop    %esi
  8022ad:	5f                   	pop    %edi
  8022ae:	5d                   	pop    %ebp
  8022af:	c3                   	ret    
  8022b0:	39 f0                	cmp    %esi,%eax
  8022b2:	0f 87 ac 00 00 00    	ja     802364 <__umoddi3+0xfc>
  8022b8:	0f bd e8             	bsr    %eax,%ebp
  8022bb:	83 f5 1f             	xor    $0x1f,%ebp
  8022be:	0f 84 ac 00 00 00    	je     802370 <__umoddi3+0x108>
  8022c4:	bf 20 00 00 00       	mov    $0x20,%edi
  8022c9:	29 ef                	sub    %ebp,%edi
  8022cb:	89 fe                	mov    %edi,%esi
  8022cd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8022d1:	89 e9                	mov    %ebp,%ecx
  8022d3:	d3 e0                	shl    %cl,%eax
  8022d5:	89 d7                	mov    %edx,%edi
  8022d7:	89 f1                	mov    %esi,%ecx
  8022d9:	d3 ef                	shr    %cl,%edi
  8022db:	09 c7                	or     %eax,%edi
  8022dd:	89 e9                	mov    %ebp,%ecx
  8022df:	d3 e2                	shl    %cl,%edx
  8022e1:	89 14 24             	mov    %edx,(%esp)
  8022e4:	89 d8                	mov    %ebx,%eax
  8022e6:	d3 e0                	shl    %cl,%eax
  8022e8:	89 c2                	mov    %eax,%edx
  8022ea:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022ee:	d3 e0                	shl    %cl,%eax
  8022f0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8022f4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022f8:	89 f1                	mov    %esi,%ecx
  8022fa:	d3 e8                	shr    %cl,%eax
  8022fc:	09 d0                	or     %edx,%eax
  8022fe:	d3 eb                	shr    %cl,%ebx
  802300:	89 da                	mov    %ebx,%edx
  802302:	f7 f7                	div    %edi
  802304:	89 d3                	mov    %edx,%ebx
  802306:	f7 24 24             	mull   (%esp)
  802309:	89 c6                	mov    %eax,%esi
  80230b:	89 d1                	mov    %edx,%ecx
  80230d:	39 d3                	cmp    %edx,%ebx
  80230f:	0f 82 87 00 00 00    	jb     80239c <__umoddi3+0x134>
  802315:	0f 84 91 00 00 00    	je     8023ac <__umoddi3+0x144>
  80231b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80231f:	29 f2                	sub    %esi,%edx
  802321:	19 cb                	sbb    %ecx,%ebx
  802323:	89 d8                	mov    %ebx,%eax
  802325:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802329:	d3 e0                	shl    %cl,%eax
  80232b:	89 e9                	mov    %ebp,%ecx
  80232d:	d3 ea                	shr    %cl,%edx
  80232f:	09 d0                	or     %edx,%eax
  802331:	89 e9                	mov    %ebp,%ecx
  802333:	d3 eb                	shr    %cl,%ebx
  802335:	89 da                	mov    %ebx,%edx
  802337:	83 c4 1c             	add    $0x1c,%esp
  80233a:	5b                   	pop    %ebx
  80233b:	5e                   	pop    %esi
  80233c:	5f                   	pop    %edi
  80233d:	5d                   	pop    %ebp
  80233e:	c3                   	ret    
  80233f:	90                   	nop
  802340:	89 fd                	mov    %edi,%ebp
  802342:	85 ff                	test   %edi,%edi
  802344:	75 0b                	jne    802351 <__umoddi3+0xe9>
  802346:	b8 01 00 00 00       	mov    $0x1,%eax
  80234b:	31 d2                	xor    %edx,%edx
  80234d:	f7 f7                	div    %edi
  80234f:	89 c5                	mov    %eax,%ebp
  802351:	89 f0                	mov    %esi,%eax
  802353:	31 d2                	xor    %edx,%edx
  802355:	f7 f5                	div    %ebp
  802357:	89 c8                	mov    %ecx,%eax
  802359:	f7 f5                	div    %ebp
  80235b:	89 d0                	mov    %edx,%eax
  80235d:	e9 44 ff ff ff       	jmp    8022a6 <__umoddi3+0x3e>
  802362:	66 90                	xchg   %ax,%ax
  802364:	89 c8                	mov    %ecx,%eax
  802366:	89 f2                	mov    %esi,%edx
  802368:	83 c4 1c             	add    $0x1c,%esp
  80236b:	5b                   	pop    %ebx
  80236c:	5e                   	pop    %esi
  80236d:	5f                   	pop    %edi
  80236e:	5d                   	pop    %ebp
  80236f:	c3                   	ret    
  802370:	3b 04 24             	cmp    (%esp),%eax
  802373:	72 06                	jb     80237b <__umoddi3+0x113>
  802375:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802379:	77 0f                	ja     80238a <__umoddi3+0x122>
  80237b:	89 f2                	mov    %esi,%edx
  80237d:	29 f9                	sub    %edi,%ecx
  80237f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802383:	89 14 24             	mov    %edx,(%esp)
  802386:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80238a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80238e:	8b 14 24             	mov    (%esp),%edx
  802391:	83 c4 1c             	add    $0x1c,%esp
  802394:	5b                   	pop    %ebx
  802395:	5e                   	pop    %esi
  802396:	5f                   	pop    %edi
  802397:	5d                   	pop    %ebp
  802398:	c3                   	ret    
  802399:	8d 76 00             	lea    0x0(%esi),%esi
  80239c:	2b 04 24             	sub    (%esp),%eax
  80239f:	19 fa                	sbb    %edi,%edx
  8023a1:	89 d1                	mov    %edx,%ecx
  8023a3:	89 c6                	mov    %eax,%esi
  8023a5:	e9 71 ff ff ff       	jmp    80231b <__umoddi3+0xb3>
  8023aa:	66 90                	xchg   %ax,%ax
  8023ac:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023b0:	72 ea                	jb     80239c <__umoddi3+0x134>
  8023b2:	89 d9                	mov    %ebx,%ecx
  8023b4:	e9 62 ff ff ff       	jmp    80231b <__umoddi3+0xb3>
