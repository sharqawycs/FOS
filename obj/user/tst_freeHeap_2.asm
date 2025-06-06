
obj/user/tst_freeHeap_2:     file format elf32-i386


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
  800031:	e8 a4 05 00 00       	call   8005da <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

char z[5*1024*1024] ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec cc 00 00 00    	sub    $0xcc,%esp
	
	

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x0)  		panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  800044:	a1 20 30 80 00       	mov    0x803020,%eax
  800049:	8b 40 7c             	mov    0x7c(%eax),%eax
  80004c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  80004f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800052:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800057:	85 c0                	test   %eax,%eax
  800059:	74 14                	je     80006f <_main+0x37>
  80005b:	83 ec 04             	sub    $0x4,%esp
  80005e:	68 40 22 80 00       	push   $0x802240
  800063:	6a 13                	push   $0x13
  800065:	68 89 22 80 00       	push   $0x802289
  80006a:	e8 6d 06 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x800000)  	panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  80006f:	a1 20 30 80 00       	mov    0x803020,%eax
  800074:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  80007a:	89 45 d0             	mov    %eax,-0x30(%ebp)
  80007d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800080:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800085:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80008a:	74 14                	je     8000a0 <_main+0x68>
  80008c:	83 ec 04             	sub    $0x4,%esp
  80008f:	68 40 22 80 00       	push   $0x802240
  800094:	6a 14                	push   $0x14
  800096:	68 89 22 80 00       	push   $0x802289
  80009b:	e8 3c 06 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)	panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a5:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
  8000ab:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8000ae:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000b1:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000b6:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  8000bb:	74 14                	je     8000d1 <_main+0x99>
  8000bd:	83 ec 04             	sub    $0x4,%esp
  8000c0:	68 40 22 80 00       	push   $0x802240
  8000c5:	6a 15                	push   $0x15
  8000c7:	68 89 22 80 00       	push   $0x802289
  8000cc:	e8 0b 06 00 00       	call   8006dc <_panic>
		if( myEnv->__ptr_tws[3].empty !=  1)  											panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d6:	8a 80 a4 00 00 00    	mov    0xa4(%eax),%al
  8000dc:	3c 01                	cmp    $0x1,%al
  8000de:	74 14                	je     8000f4 <_main+0xbc>
  8000e0:	83 ec 04             	sub    $0x4,%esp
  8000e3:	68 40 22 80 00       	push   $0x802240
  8000e8:	6a 16                	push   $0x16
  8000ea:	68 89 22 80 00       	push   $0x802289
  8000ef:	e8 e8 05 00 00       	call   8006dc <_panic>

		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f9:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000ff:	8b 00                	mov    (%eax),%eax
  800101:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800104:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800107:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80010c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800111:	74 14                	je     800127 <_main+0xef>
  800113:	83 ec 04             	sub    $0x4,%esp
  800116:	68 a0 22 80 00       	push   $0x8022a0
  80011b:	6a 18                	push   $0x18
  80011d:	68 89 22 80 00       	push   $0x802289
  800122:	e8 b5 05 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800127:	a1 20 30 80 00       	mov    0x803020,%eax
  80012c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800132:	83 c0 0c             	add    $0xc,%eax
  800135:	8b 00                	mov    (%eax),%eax
  800137:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80013a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80013d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800142:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800147:	74 14                	je     80015d <_main+0x125>
  800149:	83 ec 04             	sub    $0x4,%esp
  80014c:	68 a0 22 80 00       	push   $0x8022a0
  800151:	6a 19                	push   $0x19
  800153:	68 89 22 80 00       	push   $0x802289
  800158:	e8 7f 05 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80015d:	a1 20 30 80 00       	mov    0x803020,%eax
  800162:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800168:	83 c0 18             	add    $0x18,%eax
  80016b:	8b 00                	mov    (%eax),%eax
  80016d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800170:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800173:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800178:	3d 00 20 20 00       	cmp    $0x202000,%eax
  80017d:	74 14                	je     800193 <_main+0x15b>
  80017f:	83 ec 04             	sub    $0x4,%esp
  800182:	68 a0 22 80 00       	push   $0x8022a0
  800187:	6a 1a                	push   $0x1a
  800189:	68 89 22 80 00       	push   $0x802289
  80018e:	e8 49 05 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800193:	a1 20 30 80 00       	mov    0x803020,%eax
  800198:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80019e:	83 c0 24             	add    $0x24,%eax
  8001a1:	8b 00                	mov    (%eax),%eax
  8001a3:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8001a6:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001a9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001ae:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8001b3:	74 14                	je     8001c9 <_main+0x191>
  8001b5:	83 ec 04             	sub    $0x4,%esp
  8001b8:	68 a0 22 80 00       	push   $0x8022a0
  8001bd:	6a 1b                	push   $0x1b
  8001bf:	68 89 22 80 00       	push   $0x802289
  8001c4:	e8 13 05 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ce:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001d4:	83 c0 30             	add    $0x30,%eax
  8001d7:	8b 00                	mov    (%eax),%eax
  8001d9:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001dc:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001df:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001e4:	3d 00 40 20 00       	cmp    $0x204000,%eax
  8001e9:	74 14                	je     8001ff <_main+0x1c7>
  8001eb:	83 ec 04             	sub    $0x4,%esp
  8001ee:	68 a0 22 80 00       	push   $0x8022a0
  8001f3:	6a 1c                	push   $0x1c
  8001f5:	68 89 22 80 00       	push   $0x802289
  8001fa:	e8 dd 04 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001ff:	a1 20 30 80 00       	mov    0x803020,%eax
  800204:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80020a:	83 c0 3c             	add    $0x3c,%eax
  80020d:	8b 00                	mov    (%eax),%eax
  80020f:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800212:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800215:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80021a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80021f:	74 14                	je     800235 <_main+0x1fd>
  800221:	83 ec 04             	sub    $0x4,%esp
  800224:	68 a0 22 80 00       	push   $0x8022a0
  800229:	6a 1d                	push   $0x1d
  80022b:	68 89 22 80 00       	push   $0x802289
  800230:	e8 a7 04 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800235:	a1 20 30 80 00       	mov    0x803020,%eax
  80023a:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800240:	83 c0 48             	add    $0x48,%eax
  800243:	8b 00                	mov    (%eax),%eax
  800245:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800248:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80024b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800250:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800255:	74 14                	je     80026b <_main+0x233>
  800257:	83 ec 04             	sub    $0x4,%esp
  80025a:	68 a0 22 80 00       	push   $0x8022a0
  80025f:	6a 1e                	push   $0x1e
  800261:	68 89 22 80 00       	push   $0x802289
  800266:	e8 71 04 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80026b:	a1 20 30 80 00       	mov    0x803020,%eax
  800270:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800276:	83 c0 54             	add    $0x54,%eax
  800279:	8b 00                	mov    (%eax),%eax
  80027b:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80027e:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800281:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800286:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80028b:	74 14                	je     8002a1 <_main+0x269>
  80028d:	83 ec 04             	sub    $0x4,%esp
  800290:	68 a0 22 80 00       	push   $0x8022a0
  800295:	6a 1f                	push   $0x1f
  800297:	68 89 22 80 00       	push   $0x802289
  80029c:	e8 3b 04 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8002a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a6:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002ac:	83 c0 60             	add    $0x60,%eax
  8002af:	8b 00                	mov    (%eax),%eax
  8002b1:	89 45 a8             	mov    %eax,-0x58(%ebp)
  8002b4:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8002b7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002bc:	3d 00 20 80 00       	cmp    $0x802000,%eax
  8002c1:	74 14                	je     8002d7 <_main+0x29f>
  8002c3:	83 ec 04             	sub    $0x4,%esp
  8002c6:	68 a0 22 80 00       	push   $0x8022a0
  8002cb:	6a 20                	push   $0x20
  8002cd:	68 89 22 80 00       	push   $0x802289
  8002d2:	e8 05 04 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8002d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002dc:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002e2:	83 c0 6c             	add    $0x6c,%eax
  8002e5:	8b 00                	mov    (%eax),%eax
  8002e7:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8002ea:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8002ed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002f2:	3d 00 30 80 00       	cmp    $0x803000,%eax
  8002f7:	74 14                	je     80030d <_main+0x2d5>
  8002f9:	83 ec 04             	sub    $0x4,%esp
  8002fc:	68 a0 22 80 00       	push   $0x8022a0
  800301:	6a 21                	push   $0x21
  800303:	68 89 22 80 00       	push   $0x802289
  800308:	e8 cf 03 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80030d:	a1 20 30 80 00       	mov    0x803020,%eax
  800312:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800318:	83 c0 78             	add    $0x78,%eax
  80031b:	8b 00                	mov    (%eax),%eax
  80031d:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800320:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800323:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800328:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80032d:	74 14                	je     800343 <_main+0x30b>
  80032f:	83 ec 04             	sub    $0x4,%esp
  800332:	68 a0 22 80 00       	push   $0x8022a0
  800337:	6a 22                	push   $0x22
  800339:	68 89 22 80 00       	push   $0x802289
  80033e:	e8 99 03 00 00       	call   8006dc <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  800343:	a1 20 30 80 00       	mov    0x803020,%eax
  800348:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  80034e:	85 c0                	test   %eax,%eax
  800350:	74 14                	je     800366 <_main+0x32e>
  800352:	83 ec 04             	sub    $0x4,%esp
  800355:	68 e8 22 80 00       	push   $0x8022e8
  80035a:	6a 23                	push   $0x23
  80035c:	68 89 22 80 00       	push   $0x802289
  800361:	e8 76 03 00 00       	call   8006dc <_panic>
	}


	int kilo = 1024;
  800366:	c7 45 9c 00 04 00 00 	movl   $0x400,-0x64(%ebp)
	int Mega = 1024*1024;
  80036d:	c7 45 98 00 00 10 00 	movl   $0x100000,-0x68(%ebp)

	/// testing freeHeap()
	{

		uint32 size = 13*Mega;
  800374:	8b 55 98             	mov    -0x68(%ebp),%edx
  800377:	89 d0                	mov    %edx,%eax
  800379:	01 c0                	add    %eax,%eax
  80037b:	01 d0                	add    %edx,%eax
  80037d:	c1 e0 02             	shl    $0x2,%eax
  800380:	01 d0                	add    %edx,%eax
  800382:	89 45 94             	mov    %eax,-0x6c(%ebp)
		char *x = malloc(sizeof( char)*size) ;
  800385:	83 ec 0c             	sub    $0xc,%esp
  800388:	ff 75 94             	pushl  -0x6c(%ebp)
  80038b:	e8 c4 13 00 00       	call   801754 <malloc>
  800390:	83 c4 10             	add    $0x10,%esp
  800393:	89 45 90             	mov    %eax,-0x70(%ebp)

		char *y = malloc(sizeof( char)*size) ;
  800396:	83 ec 0c             	sub    $0xc,%esp
  800399:	ff 75 94             	pushl  -0x6c(%ebp)
  80039c:	e8 b3 13 00 00       	call   801754 <malloc>
  8003a1:	83 c4 10             	add    $0x10,%esp
  8003a4:	89 45 8c             	mov    %eax,-0x74(%ebp)


		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003a7:	e8 ed 17 00 00       	call   801b99 <sys_pf_calculate_allocated_pages>
  8003ac:	89 45 88             	mov    %eax,-0x78(%ebp)

		x[1]=-1;
  8003af:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003b2:	40                   	inc    %eax
  8003b3:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega]=-1;
  8003b6:	8b 55 98             	mov    -0x68(%ebp),%edx
  8003b9:	89 d0                	mov    %edx,%eax
  8003bb:	c1 e0 02             	shl    $0x2,%eax
  8003be:	01 d0                	add    %edx,%eax
  8003c0:	89 c2                	mov    %eax,%edx
  8003c2:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003c5:	01 d0                	add    %edx,%eax
  8003c7:	c6 00 ff             	movb   $0xff,(%eax)

		z[4*Mega] = 'M' ;
  8003ca:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003cd:	c1 e0 02             	shl    $0x2,%eax
  8003d0:	c6 80 60 30 80 00 4d 	movb   $0x4d,0x803060(%eax)

		x[8*Mega] = -1;
  8003d7:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003da:	c1 e0 03             	shl    $0x3,%eax
  8003dd:	89 c2                	mov    %eax,%edx
  8003df:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003e2:	01 d0                	add    %edx,%eax
  8003e4:	c6 00 ff             	movb   $0xff,(%eax)

		x[12*Mega]=-1;
  8003e7:	8b 55 98             	mov    -0x68(%ebp),%edx
  8003ea:	89 d0                	mov    %edx,%eax
  8003ec:	01 c0                	add    %eax,%eax
  8003ee:	01 d0                	add    %edx,%eax
  8003f0:	c1 e0 02             	shl    $0x2,%eax
  8003f3:	89 c2                	mov    %eax,%edx
  8003f5:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003f8:	01 d0                	add    %edx,%eax
  8003fa:	c6 00 ff             	movb   $0xff,(%eax)


		free(x);
  8003fd:	83 ec 0c             	sub    $0xc,%esp
  800400:	ff 75 90             	pushl  -0x70(%ebp)
  800403:	e8 6d 14 00 00       	call   801875 <free>
  800408:	83 c4 10             	add    $0x10,%esp
		free(y);
  80040b:	83 ec 0c             	sub    $0xc,%esp
  80040e:	ff 75 8c             	pushl  -0x74(%ebp)
  800411:	e8 5f 14 00 00       	call   801875 <free>
  800416:	83 c4 10             	add    $0x10,%esp

		int freePages = sys_calculate_free_frames();
  800419:	e8 f8 16 00 00       	call   801b16 <sys_calculate_free_frames>
  80041e:	89 45 84             	mov    %eax,-0x7c(%ebp)

		x = malloc(sizeof(char)*size) ;
  800421:	83 ec 0c             	sub    $0xc,%esp
  800424:	ff 75 94             	pushl  -0x6c(%ebp)
  800427:	e8 28 13 00 00       	call   801754 <malloc>
  80042c:	83 c4 10             	add    $0x10,%esp
  80042f:	89 45 90             	mov    %eax,-0x70(%ebp)

		x[1]=-2;
  800432:	8b 45 90             	mov    -0x70(%ebp),%eax
  800435:	40                   	inc    %eax
  800436:	c6 00 fe             	movb   $0xfe,(%eax)

		x[5*Mega]=-2;
  800439:	8b 55 98             	mov    -0x68(%ebp),%edx
  80043c:	89 d0                	mov    %edx,%eax
  80043e:	c1 e0 02             	shl    $0x2,%eax
  800441:	01 d0                	add    %edx,%eax
  800443:	89 c2                	mov    %eax,%edx
  800445:	8b 45 90             	mov    -0x70(%ebp),%eax
  800448:	01 d0                	add    %edx,%eax
  80044a:	c6 00 fe             	movb   $0xfe,(%eax)

		x[8*Mega] = -2;
  80044d:	8b 45 98             	mov    -0x68(%ebp),%eax
  800450:	c1 e0 03             	shl    $0x3,%eax
  800453:	89 c2                	mov    %eax,%edx
  800455:	8b 45 90             	mov    -0x70(%ebp),%eax
  800458:	01 d0                	add    %edx,%eax
  80045a:	c6 00 fe             	movb   $0xfe,(%eax)

		x[12*Mega]=-2;
  80045d:	8b 55 98             	mov    -0x68(%ebp),%edx
  800460:	89 d0                	mov    %edx,%eax
  800462:	01 c0                	add    %eax,%eax
  800464:	01 d0                	add    %edx,%eax
  800466:	c1 e0 02             	shl    $0x2,%eax
  800469:	89 c2                	mov    %eax,%edx
  80046b:	8b 45 90             	mov    -0x70(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	c6 00 fe             	movb   $0xfe,(%eax)


		uint32 pageWSEntries[11] = {0x800000,0x801000,0x802000,0x803000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0xc03000, 0x205000, 0xeebfd000};
  800473:	8d 85 50 ff ff ff    	lea    -0xb0(%ebp),%eax
  800479:	bb a0 24 80 00       	mov    $0x8024a0,%ebx
  80047e:	ba 0b 00 00 00       	mov    $0xb,%edx
  800483:	89 c7                	mov    %eax,%edi
  800485:	89 de                	mov    %ebx,%esi
  800487:	89 d1                	mov    %edx,%ecx
  800489:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

		int i = 0, j ;
  80048b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (; i < (myEnv->page_WS_max_size); i++)
  800492:	eb 7c                	jmp    800510 <_main+0x4d8>
		{
			int found = 0 ;
  800494:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  80049b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004a2:	eb 40                	jmp    8004e4 <_main+0x4ac>
			{
				if (pageWSEntries[i] == ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address,PAGE_SIZE) )
  8004a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8004a7:	8b 8c 85 50 ff ff ff 	mov    -0xb0(%ebp,%eax,4),%ecx
  8004ae:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b3:	8b 98 34 03 00 00    	mov    0x334(%eax),%ebx
  8004b9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004bc:	89 d0                	mov    %edx,%eax
  8004be:	01 c0                	add    %eax,%eax
  8004c0:	01 d0                	add    %edx,%eax
  8004c2:	c1 e0 02             	shl    $0x2,%eax
  8004c5:	01 d8                	add    %ebx,%eax
  8004c7:	8b 00                	mov    (%eax),%eax
  8004c9:	89 45 80             	mov    %eax,-0x80(%ebp)
  8004cc:	8b 45 80             	mov    -0x80(%ebp),%eax
  8004cf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004d4:	39 c1                	cmp    %eax,%ecx
  8004d6:	75 09                	jne    8004e1 <_main+0x4a9>
				{
					found = 1 ;
  8004d8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
					break;
  8004df:	eb 12                	jmp    8004f3 <_main+0x4bb>

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
		{
			int found = 0 ;
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  8004e1:	ff 45 e0             	incl   -0x20(%ebp)
  8004e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8004e9:	8b 50 74             	mov    0x74(%eax),%edx
  8004ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004ef:	39 c2                	cmp    %eax,%edx
  8004f1:	77 b1                	ja     8004a4 <_main+0x46c>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  8004f3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8004f7:	75 14                	jne    80050d <_main+0x4d5>
				panic("PAGE Placement algorithm failed after applying freeHeap.. make sure you SEARCH for the empty location in the WS before setting it");
  8004f9:	83 ec 04             	sub    $0x4,%esp
  8004fc:	68 38 23 80 00       	push   $0x802338
  800501:	6a 5f                	push   $0x5f
  800503:	68 89 22 80 00       	push   $0x802289
  800508:	e8 cf 01 00 00       	call   8006dc <_panic>


		uint32 pageWSEntries[11] = {0x800000,0x801000,0x802000,0x803000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0xc03000, 0x205000, 0xeebfd000};

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
  80050d:	ff 45 e4             	incl   -0x1c(%ebp)
  800510:	a1 20 30 80 00       	mov    0x803020,%eax
  800515:	8b 50 74             	mov    0x74(%eax),%edx
  800518:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80051b:	39 c2                	cmp    %eax,%edx
  80051d:	0f 87 71 ff ff ff    	ja     800494 <_main+0x45c>
			}
			if (!found)
				panic("PAGE Placement algorithm failed after applying freeHeap.. make sure you SEARCH for the empty location in the WS before setting it");
		}

		uint32 tableWSEntries[8] = {0x0, 0x80400000, 0x80800000, 0x80c00000, 0x80000000, 0x800000,0xc00000, 0xee800000};
  800523:	8d 85 30 ff ff ff    	lea    -0xd0(%ebp),%eax
  800529:	bb e0 24 80 00       	mov    $0x8024e0,%ebx
  80052e:	ba 08 00 00 00       	mov    $0x8,%edx
  800533:	89 c7                	mov    %eax,%edi
  800535:	89 de                	mov    %ebx,%esi
  800537:	89 d1                	mov    %edx,%ecx
  800539:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)


		for (i=0; i < __TWS_MAX_SIZE; i++)
  80053b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800542:	eb 77                	jmp    8005bb <_main+0x583>
		{
			int found = 0 ;
  800544:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for (j=0; j < __TWS_MAX_SIZE; j++)
  80054b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800552:	eb 44                	jmp    800598 <_main+0x560>
			{
				if (tableWSEntries[i] == ROUNDDOWN(myEnv->__ptr_tws[j].virtual_address,1024*PAGE_SIZE) )
  800554:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800557:	8b 8c 85 30 ff ff ff 	mov    -0xd0(%ebp,%eax,4),%ecx
  80055e:	8b 1d 20 30 80 00    	mov    0x803020,%ebx
  800564:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800567:	89 d0                	mov    %edx,%eax
  800569:	01 c0                	add    %eax,%eax
  80056b:	01 d0                	add    %edx,%eax
  80056d:	c1 e0 02             	shl    $0x2,%eax
  800570:	01 d8                	add    %ebx,%eax
  800572:	83 c0 7c             	add    $0x7c,%eax
  800575:	8b 00                	mov    (%eax),%eax
  800577:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80057d:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800583:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800588:	39 c1                	cmp    %eax,%ecx
  80058a:	75 09                	jne    800595 <_main+0x55d>
				{
					found = 1 ;
  80058c:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
					break;
  800593:	eb 09                	jmp    80059e <_main+0x566>


		for (i=0; i < __TWS_MAX_SIZE; i++)
		{
			int found = 0 ;
			for (j=0; j < __TWS_MAX_SIZE; j++)
  800595:	ff 45 e0             	incl   -0x20(%ebp)
  800598:	83 7d e0 31          	cmpl   $0x31,-0x20(%ebp)
  80059c:	7e b6                	jle    800554 <_main+0x51c>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  80059e:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  8005a2:	75 14                	jne    8005b8 <_main+0x580>
				panic("TABLE Placement algorithm failed after applying freeHeap.. make sure you SEARCH for the empty location in the WS before setting it");
  8005a4:	83 ec 04             	sub    $0x4,%esp
  8005a7:	68 bc 23 80 00       	push   $0x8023bc
  8005ac:	6a 71                	push   $0x71
  8005ae:	68 89 22 80 00       	push   $0x802289
  8005b3:	e8 24 01 00 00       	call   8006dc <_panic>
		}

		uint32 tableWSEntries[8] = {0x0, 0x80400000, 0x80800000, 0x80c00000, 0x80000000, 0x800000,0xc00000, 0xee800000};


		for (i=0; i < __TWS_MAX_SIZE; i++)
  8005b8:	ff 45 e4             	incl   -0x1c(%ebp)
  8005bb:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
  8005bf:	7e 83                	jle    800544 <_main+0x50c>


		//if( (freePages - sys_calculate_free_frames() ) != 8 ) panic("Extra/Less memory are wrongly allocated");
	}

	cprintf("Congratulations!! test freeHeap 2 [WITH REPLACEMENT] completed successfully.\n");
  8005c1:	83 ec 0c             	sub    $0xc,%esp
  8005c4:	68 40 24 80 00       	push   $0x802440
  8005c9:	e8 c2 03 00 00       	call   800990 <cprintf>
  8005ce:	83 c4 10             	add    $0x10,%esp


	return;
  8005d1:	90                   	nop
}
  8005d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8005d5:	5b                   	pop    %ebx
  8005d6:	5e                   	pop    %esi
  8005d7:	5f                   	pop    %edi
  8005d8:	5d                   	pop    %ebp
  8005d9:	c3                   	ret    

008005da <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005da:	55                   	push   %ebp
  8005db:	89 e5                	mov    %esp,%ebp
  8005dd:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005e0:	e8 66 14 00 00       	call   801a4b <sys_getenvindex>
  8005e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005eb:	89 d0                	mov    %edx,%eax
  8005ed:	01 c0                	add    %eax,%eax
  8005ef:	01 d0                	add    %edx,%eax
  8005f1:	c1 e0 02             	shl    $0x2,%eax
  8005f4:	01 d0                	add    %edx,%eax
  8005f6:	c1 e0 06             	shl    $0x6,%eax
  8005f9:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005fe:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800603:	a1 20 30 80 00       	mov    0x803020,%eax
  800608:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80060e:	84 c0                	test   %al,%al
  800610:	74 0f                	je     800621 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800612:	a1 20 30 80 00       	mov    0x803020,%eax
  800617:	05 f4 02 00 00       	add    $0x2f4,%eax
  80061c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800621:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800625:	7e 0a                	jle    800631 <libmain+0x57>
		binaryname = argv[0];
  800627:	8b 45 0c             	mov    0xc(%ebp),%eax
  80062a:	8b 00                	mov    (%eax),%eax
  80062c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800631:	83 ec 08             	sub    $0x8,%esp
  800634:	ff 75 0c             	pushl  0xc(%ebp)
  800637:	ff 75 08             	pushl  0x8(%ebp)
  80063a:	e8 f9 f9 ff ff       	call   800038 <_main>
  80063f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800642:	e8 9f 15 00 00       	call   801be6 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800647:	83 ec 0c             	sub    $0xc,%esp
  80064a:	68 18 25 80 00       	push   $0x802518
  80064f:	e8 3c 03 00 00       	call   800990 <cprintf>
  800654:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800657:	a1 20 30 80 00       	mov    0x803020,%eax
  80065c:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800662:	a1 20 30 80 00       	mov    0x803020,%eax
  800667:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80066d:	83 ec 04             	sub    $0x4,%esp
  800670:	52                   	push   %edx
  800671:	50                   	push   %eax
  800672:	68 40 25 80 00       	push   $0x802540
  800677:	e8 14 03 00 00       	call   800990 <cprintf>
  80067c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80067f:	a1 20 30 80 00       	mov    0x803020,%eax
  800684:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80068a:	83 ec 08             	sub    $0x8,%esp
  80068d:	50                   	push   %eax
  80068e:	68 65 25 80 00       	push   $0x802565
  800693:	e8 f8 02 00 00       	call   800990 <cprintf>
  800698:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80069b:	83 ec 0c             	sub    $0xc,%esp
  80069e:	68 18 25 80 00       	push   $0x802518
  8006a3:	e8 e8 02 00 00       	call   800990 <cprintf>
  8006a8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006ab:	e8 50 15 00 00       	call   801c00 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006b0:	e8 19 00 00 00       	call   8006ce <exit>
}
  8006b5:	90                   	nop
  8006b6:	c9                   	leave  
  8006b7:	c3                   	ret    

008006b8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006b8:	55                   	push   %ebp
  8006b9:	89 e5                	mov    %esp,%ebp
  8006bb:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006be:	83 ec 0c             	sub    $0xc,%esp
  8006c1:	6a 00                	push   $0x0
  8006c3:	e8 4f 13 00 00       	call   801a17 <sys_env_destroy>
  8006c8:	83 c4 10             	add    $0x10,%esp
}
  8006cb:	90                   	nop
  8006cc:	c9                   	leave  
  8006cd:	c3                   	ret    

008006ce <exit>:

void
exit(void)
{
  8006ce:	55                   	push   %ebp
  8006cf:	89 e5                	mov    %esp,%ebp
  8006d1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006d4:	e8 a4 13 00 00       	call   801a7d <sys_env_exit>
}
  8006d9:	90                   	nop
  8006da:	c9                   	leave  
  8006db:	c3                   	ret    

008006dc <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006dc:	55                   	push   %ebp
  8006dd:	89 e5                	mov    %esp,%ebp
  8006df:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006e2:	8d 45 10             	lea    0x10(%ebp),%eax
  8006e5:	83 c0 04             	add    $0x4,%eax
  8006e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006eb:	a1 64 30 d0 00       	mov    0xd03064,%eax
  8006f0:	85 c0                	test   %eax,%eax
  8006f2:	74 16                	je     80070a <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006f4:	a1 64 30 d0 00       	mov    0xd03064,%eax
  8006f9:	83 ec 08             	sub    $0x8,%esp
  8006fc:	50                   	push   %eax
  8006fd:	68 7c 25 80 00       	push   $0x80257c
  800702:	e8 89 02 00 00       	call   800990 <cprintf>
  800707:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80070a:	a1 00 30 80 00       	mov    0x803000,%eax
  80070f:	ff 75 0c             	pushl  0xc(%ebp)
  800712:	ff 75 08             	pushl  0x8(%ebp)
  800715:	50                   	push   %eax
  800716:	68 81 25 80 00       	push   $0x802581
  80071b:	e8 70 02 00 00       	call   800990 <cprintf>
  800720:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800723:	8b 45 10             	mov    0x10(%ebp),%eax
  800726:	83 ec 08             	sub    $0x8,%esp
  800729:	ff 75 f4             	pushl  -0xc(%ebp)
  80072c:	50                   	push   %eax
  80072d:	e8 f3 01 00 00       	call   800925 <vcprintf>
  800732:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800735:	83 ec 08             	sub    $0x8,%esp
  800738:	6a 00                	push   $0x0
  80073a:	68 9d 25 80 00       	push   $0x80259d
  80073f:	e8 e1 01 00 00       	call   800925 <vcprintf>
  800744:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800747:	e8 82 ff ff ff       	call   8006ce <exit>

	// should not return here
	while (1) ;
  80074c:	eb fe                	jmp    80074c <_panic+0x70>

0080074e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80074e:	55                   	push   %ebp
  80074f:	89 e5                	mov    %esp,%ebp
  800751:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800754:	a1 20 30 80 00       	mov    0x803020,%eax
  800759:	8b 50 74             	mov    0x74(%eax),%edx
  80075c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80075f:	39 c2                	cmp    %eax,%edx
  800761:	74 14                	je     800777 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800763:	83 ec 04             	sub    $0x4,%esp
  800766:	68 a0 25 80 00       	push   $0x8025a0
  80076b:	6a 26                	push   $0x26
  80076d:	68 ec 25 80 00       	push   $0x8025ec
  800772:	e8 65 ff ff ff       	call   8006dc <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800777:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80077e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800785:	e9 c2 00 00 00       	jmp    80084c <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80078a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80078d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800794:	8b 45 08             	mov    0x8(%ebp),%eax
  800797:	01 d0                	add    %edx,%eax
  800799:	8b 00                	mov    (%eax),%eax
  80079b:	85 c0                	test   %eax,%eax
  80079d:	75 08                	jne    8007a7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80079f:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007a2:	e9 a2 00 00 00       	jmp    800849 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007ae:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007b5:	eb 69                	jmp    800820 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8007bc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007c2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007c5:	89 d0                	mov    %edx,%eax
  8007c7:	01 c0                	add    %eax,%eax
  8007c9:	01 d0                	add    %edx,%eax
  8007cb:	c1 e0 02             	shl    $0x2,%eax
  8007ce:	01 c8                	add    %ecx,%eax
  8007d0:	8a 40 04             	mov    0x4(%eax),%al
  8007d3:	84 c0                	test   %al,%al
  8007d5:	75 46                	jne    80081d <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8007dc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007e2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007e5:	89 d0                	mov    %edx,%eax
  8007e7:	01 c0                	add    %eax,%eax
  8007e9:	01 d0                	add    %edx,%eax
  8007eb:	c1 e0 02             	shl    $0x2,%eax
  8007ee:	01 c8                	add    %ecx,%eax
  8007f0:	8b 00                	mov    (%eax),%eax
  8007f2:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007f5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007f8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007fd:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800802:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800809:	8b 45 08             	mov    0x8(%ebp),%eax
  80080c:	01 c8                	add    %ecx,%eax
  80080e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800810:	39 c2                	cmp    %eax,%edx
  800812:	75 09                	jne    80081d <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800814:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80081b:	eb 12                	jmp    80082f <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80081d:	ff 45 e8             	incl   -0x18(%ebp)
  800820:	a1 20 30 80 00       	mov    0x803020,%eax
  800825:	8b 50 74             	mov    0x74(%eax),%edx
  800828:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80082b:	39 c2                	cmp    %eax,%edx
  80082d:	77 88                	ja     8007b7 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80082f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800833:	75 14                	jne    800849 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800835:	83 ec 04             	sub    $0x4,%esp
  800838:	68 f8 25 80 00       	push   $0x8025f8
  80083d:	6a 3a                	push   $0x3a
  80083f:	68 ec 25 80 00       	push   $0x8025ec
  800844:	e8 93 fe ff ff       	call   8006dc <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800849:	ff 45 f0             	incl   -0x10(%ebp)
  80084c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80084f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800852:	0f 8c 32 ff ff ff    	jl     80078a <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800858:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80085f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800866:	eb 26                	jmp    80088e <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800868:	a1 20 30 80 00       	mov    0x803020,%eax
  80086d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800873:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800876:	89 d0                	mov    %edx,%eax
  800878:	01 c0                	add    %eax,%eax
  80087a:	01 d0                	add    %edx,%eax
  80087c:	c1 e0 02             	shl    $0x2,%eax
  80087f:	01 c8                	add    %ecx,%eax
  800881:	8a 40 04             	mov    0x4(%eax),%al
  800884:	3c 01                	cmp    $0x1,%al
  800886:	75 03                	jne    80088b <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800888:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80088b:	ff 45 e0             	incl   -0x20(%ebp)
  80088e:	a1 20 30 80 00       	mov    0x803020,%eax
  800893:	8b 50 74             	mov    0x74(%eax),%edx
  800896:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800899:	39 c2                	cmp    %eax,%edx
  80089b:	77 cb                	ja     800868 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80089d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008a0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008a3:	74 14                	je     8008b9 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008a5:	83 ec 04             	sub    $0x4,%esp
  8008a8:	68 4c 26 80 00       	push   $0x80264c
  8008ad:	6a 44                	push   $0x44
  8008af:	68 ec 25 80 00       	push   $0x8025ec
  8008b4:	e8 23 fe ff ff       	call   8006dc <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008b9:	90                   	nop
  8008ba:	c9                   	leave  
  8008bb:	c3                   	ret    

008008bc <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008bc:	55                   	push   %ebp
  8008bd:	89 e5                	mov    %esp,%ebp
  8008bf:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c5:	8b 00                	mov    (%eax),%eax
  8008c7:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008cd:	89 0a                	mov    %ecx,(%edx)
  8008cf:	8b 55 08             	mov    0x8(%ebp),%edx
  8008d2:	88 d1                	mov    %dl,%cl
  8008d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008de:	8b 00                	mov    (%eax),%eax
  8008e0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008e5:	75 2c                	jne    800913 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008e7:	a0 24 30 80 00       	mov    0x803024,%al
  8008ec:	0f b6 c0             	movzbl %al,%eax
  8008ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f2:	8b 12                	mov    (%edx),%edx
  8008f4:	89 d1                	mov    %edx,%ecx
  8008f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f9:	83 c2 08             	add    $0x8,%edx
  8008fc:	83 ec 04             	sub    $0x4,%esp
  8008ff:	50                   	push   %eax
  800900:	51                   	push   %ecx
  800901:	52                   	push   %edx
  800902:	e8 ce 10 00 00       	call   8019d5 <sys_cputs>
  800907:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80090a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800913:	8b 45 0c             	mov    0xc(%ebp),%eax
  800916:	8b 40 04             	mov    0x4(%eax),%eax
  800919:	8d 50 01             	lea    0x1(%eax),%edx
  80091c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800922:	90                   	nop
  800923:	c9                   	leave  
  800924:	c3                   	ret    

00800925 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800925:	55                   	push   %ebp
  800926:	89 e5                	mov    %esp,%ebp
  800928:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80092e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800935:	00 00 00 
	b.cnt = 0;
  800938:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80093f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800942:	ff 75 0c             	pushl  0xc(%ebp)
  800945:	ff 75 08             	pushl  0x8(%ebp)
  800948:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80094e:	50                   	push   %eax
  80094f:	68 bc 08 80 00       	push   $0x8008bc
  800954:	e8 11 02 00 00       	call   800b6a <vprintfmt>
  800959:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80095c:	a0 24 30 80 00       	mov    0x803024,%al
  800961:	0f b6 c0             	movzbl %al,%eax
  800964:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80096a:	83 ec 04             	sub    $0x4,%esp
  80096d:	50                   	push   %eax
  80096e:	52                   	push   %edx
  80096f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800975:	83 c0 08             	add    $0x8,%eax
  800978:	50                   	push   %eax
  800979:	e8 57 10 00 00       	call   8019d5 <sys_cputs>
  80097e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800981:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800988:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80098e:	c9                   	leave  
  80098f:	c3                   	ret    

00800990 <cprintf>:

int cprintf(const char *fmt, ...) {
  800990:	55                   	push   %ebp
  800991:	89 e5                	mov    %esp,%ebp
  800993:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800996:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80099d:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a6:	83 ec 08             	sub    $0x8,%esp
  8009a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ac:	50                   	push   %eax
  8009ad:	e8 73 ff ff ff       	call   800925 <vcprintf>
  8009b2:	83 c4 10             	add    $0x10,%esp
  8009b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009bb:	c9                   	leave  
  8009bc:	c3                   	ret    

008009bd <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009bd:	55                   	push   %ebp
  8009be:	89 e5                	mov    %esp,%ebp
  8009c0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009c3:	e8 1e 12 00 00       	call   801be6 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009c8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d1:	83 ec 08             	sub    $0x8,%esp
  8009d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d7:	50                   	push   %eax
  8009d8:	e8 48 ff ff ff       	call   800925 <vcprintf>
  8009dd:	83 c4 10             	add    $0x10,%esp
  8009e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009e3:	e8 18 12 00 00       	call   801c00 <sys_enable_interrupt>
	return cnt;
  8009e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009eb:	c9                   	leave  
  8009ec:	c3                   	ret    

008009ed <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009ed:	55                   	push   %ebp
  8009ee:	89 e5                	mov    %esp,%ebp
  8009f0:	53                   	push   %ebx
  8009f1:	83 ec 14             	sub    $0x14,%esp
  8009f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009fa:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a00:	8b 45 18             	mov    0x18(%ebp),%eax
  800a03:	ba 00 00 00 00       	mov    $0x0,%edx
  800a08:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a0b:	77 55                	ja     800a62 <printnum+0x75>
  800a0d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a10:	72 05                	jb     800a17 <printnum+0x2a>
  800a12:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a15:	77 4b                	ja     800a62 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a17:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a1a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a1d:	8b 45 18             	mov    0x18(%ebp),%eax
  800a20:	ba 00 00 00 00       	mov    $0x0,%edx
  800a25:	52                   	push   %edx
  800a26:	50                   	push   %eax
  800a27:	ff 75 f4             	pushl  -0xc(%ebp)
  800a2a:	ff 75 f0             	pushl  -0x10(%ebp)
  800a2d:	e8 92 15 00 00       	call   801fc4 <__udivdi3>
  800a32:	83 c4 10             	add    $0x10,%esp
  800a35:	83 ec 04             	sub    $0x4,%esp
  800a38:	ff 75 20             	pushl  0x20(%ebp)
  800a3b:	53                   	push   %ebx
  800a3c:	ff 75 18             	pushl  0x18(%ebp)
  800a3f:	52                   	push   %edx
  800a40:	50                   	push   %eax
  800a41:	ff 75 0c             	pushl  0xc(%ebp)
  800a44:	ff 75 08             	pushl  0x8(%ebp)
  800a47:	e8 a1 ff ff ff       	call   8009ed <printnum>
  800a4c:	83 c4 20             	add    $0x20,%esp
  800a4f:	eb 1a                	jmp    800a6b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a51:	83 ec 08             	sub    $0x8,%esp
  800a54:	ff 75 0c             	pushl  0xc(%ebp)
  800a57:	ff 75 20             	pushl  0x20(%ebp)
  800a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5d:	ff d0                	call   *%eax
  800a5f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a62:	ff 4d 1c             	decl   0x1c(%ebp)
  800a65:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a69:	7f e6                	jg     800a51 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a6b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a6e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a73:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a76:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a79:	53                   	push   %ebx
  800a7a:	51                   	push   %ecx
  800a7b:	52                   	push   %edx
  800a7c:	50                   	push   %eax
  800a7d:	e8 52 16 00 00       	call   8020d4 <__umoddi3>
  800a82:	83 c4 10             	add    $0x10,%esp
  800a85:	05 b4 28 80 00       	add    $0x8028b4,%eax
  800a8a:	8a 00                	mov    (%eax),%al
  800a8c:	0f be c0             	movsbl %al,%eax
  800a8f:	83 ec 08             	sub    $0x8,%esp
  800a92:	ff 75 0c             	pushl  0xc(%ebp)
  800a95:	50                   	push   %eax
  800a96:	8b 45 08             	mov    0x8(%ebp),%eax
  800a99:	ff d0                	call   *%eax
  800a9b:	83 c4 10             	add    $0x10,%esp
}
  800a9e:	90                   	nop
  800a9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800aa2:	c9                   	leave  
  800aa3:	c3                   	ret    

00800aa4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800aa4:	55                   	push   %ebp
  800aa5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800aa7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800aab:	7e 1c                	jle    800ac9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800aad:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab0:	8b 00                	mov    (%eax),%eax
  800ab2:	8d 50 08             	lea    0x8(%eax),%edx
  800ab5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab8:	89 10                	mov    %edx,(%eax)
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	8b 00                	mov    (%eax),%eax
  800abf:	83 e8 08             	sub    $0x8,%eax
  800ac2:	8b 50 04             	mov    0x4(%eax),%edx
  800ac5:	8b 00                	mov    (%eax),%eax
  800ac7:	eb 40                	jmp    800b09 <getuint+0x65>
	else if (lflag)
  800ac9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800acd:	74 1e                	je     800aed <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad2:	8b 00                	mov    (%eax),%eax
  800ad4:	8d 50 04             	lea    0x4(%eax),%edx
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	89 10                	mov    %edx,(%eax)
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	8b 00                	mov    (%eax),%eax
  800ae1:	83 e8 04             	sub    $0x4,%eax
  800ae4:	8b 00                	mov    (%eax),%eax
  800ae6:	ba 00 00 00 00       	mov    $0x0,%edx
  800aeb:	eb 1c                	jmp    800b09 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
  800af0:	8b 00                	mov    (%eax),%eax
  800af2:	8d 50 04             	lea    0x4(%eax),%edx
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	89 10                	mov    %edx,(%eax)
  800afa:	8b 45 08             	mov    0x8(%ebp),%eax
  800afd:	8b 00                	mov    (%eax),%eax
  800aff:	83 e8 04             	sub    $0x4,%eax
  800b02:	8b 00                	mov    (%eax),%eax
  800b04:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b09:	5d                   	pop    %ebp
  800b0a:	c3                   	ret    

00800b0b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b0b:	55                   	push   %ebp
  800b0c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b0e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b12:	7e 1c                	jle    800b30 <getint+0x25>
		return va_arg(*ap, long long);
  800b14:	8b 45 08             	mov    0x8(%ebp),%eax
  800b17:	8b 00                	mov    (%eax),%eax
  800b19:	8d 50 08             	lea    0x8(%eax),%edx
  800b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1f:	89 10                	mov    %edx,(%eax)
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
  800b24:	8b 00                	mov    (%eax),%eax
  800b26:	83 e8 08             	sub    $0x8,%eax
  800b29:	8b 50 04             	mov    0x4(%eax),%edx
  800b2c:	8b 00                	mov    (%eax),%eax
  800b2e:	eb 38                	jmp    800b68 <getint+0x5d>
	else if (lflag)
  800b30:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b34:	74 1a                	je     800b50 <getint+0x45>
		return va_arg(*ap, long);
  800b36:	8b 45 08             	mov    0x8(%ebp),%eax
  800b39:	8b 00                	mov    (%eax),%eax
  800b3b:	8d 50 04             	lea    0x4(%eax),%edx
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	89 10                	mov    %edx,(%eax)
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
  800b46:	8b 00                	mov    (%eax),%eax
  800b48:	83 e8 04             	sub    $0x4,%eax
  800b4b:	8b 00                	mov    (%eax),%eax
  800b4d:	99                   	cltd   
  800b4e:	eb 18                	jmp    800b68 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b50:	8b 45 08             	mov    0x8(%ebp),%eax
  800b53:	8b 00                	mov    (%eax),%eax
  800b55:	8d 50 04             	lea    0x4(%eax),%edx
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	89 10                	mov    %edx,(%eax)
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	8b 00                	mov    (%eax),%eax
  800b62:	83 e8 04             	sub    $0x4,%eax
  800b65:	8b 00                	mov    (%eax),%eax
  800b67:	99                   	cltd   
}
  800b68:	5d                   	pop    %ebp
  800b69:	c3                   	ret    

00800b6a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b6a:	55                   	push   %ebp
  800b6b:	89 e5                	mov    %esp,%ebp
  800b6d:	56                   	push   %esi
  800b6e:	53                   	push   %ebx
  800b6f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b72:	eb 17                	jmp    800b8b <vprintfmt+0x21>
			if (ch == '\0')
  800b74:	85 db                	test   %ebx,%ebx
  800b76:	0f 84 af 03 00 00    	je     800f2b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b7c:	83 ec 08             	sub    $0x8,%esp
  800b7f:	ff 75 0c             	pushl  0xc(%ebp)
  800b82:	53                   	push   %ebx
  800b83:	8b 45 08             	mov    0x8(%ebp),%eax
  800b86:	ff d0                	call   *%eax
  800b88:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8e:	8d 50 01             	lea    0x1(%eax),%edx
  800b91:	89 55 10             	mov    %edx,0x10(%ebp)
  800b94:	8a 00                	mov    (%eax),%al
  800b96:	0f b6 d8             	movzbl %al,%ebx
  800b99:	83 fb 25             	cmp    $0x25,%ebx
  800b9c:	75 d6                	jne    800b74 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b9e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ba2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ba9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bb0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bb7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc1:	8d 50 01             	lea    0x1(%eax),%edx
  800bc4:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc7:	8a 00                	mov    (%eax),%al
  800bc9:	0f b6 d8             	movzbl %al,%ebx
  800bcc:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bcf:	83 f8 55             	cmp    $0x55,%eax
  800bd2:	0f 87 2b 03 00 00    	ja     800f03 <vprintfmt+0x399>
  800bd8:	8b 04 85 d8 28 80 00 	mov    0x8028d8(,%eax,4),%eax
  800bdf:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800be1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800be5:	eb d7                	jmp    800bbe <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800be7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800beb:	eb d1                	jmp    800bbe <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bed:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bf4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bf7:	89 d0                	mov    %edx,%eax
  800bf9:	c1 e0 02             	shl    $0x2,%eax
  800bfc:	01 d0                	add    %edx,%eax
  800bfe:	01 c0                	add    %eax,%eax
  800c00:	01 d8                	add    %ebx,%eax
  800c02:	83 e8 30             	sub    $0x30,%eax
  800c05:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c08:	8b 45 10             	mov    0x10(%ebp),%eax
  800c0b:	8a 00                	mov    (%eax),%al
  800c0d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c10:	83 fb 2f             	cmp    $0x2f,%ebx
  800c13:	7e 3e                	jle    800c53 <vprintfmt+0xe9>
  800c15:	83 fb 39             	cmp    $0x39,%ebx
  800c18:	7f 39                	jg     800c53 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c1a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c1d:	eb d5                	jmp    800bf4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c1f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c22:	83 c0 04             	add    $0x4,%eax
  800c25:	89 45 14             	mov    %eax,0x14(%ebp)
  800c28:	8b 45 14             	mov    0x14(%ebp),%eax
  800c2b:	83 e8 04             	sub    $0x4,%eax
  800c2e:	8b 00                	mov    (%eax),%eax
  800c30:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c33:	eb 1f                	jmp    800c54 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c35:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c39:	79 83                	jns    800bbe <vprintfmt+0x54>
				width = 0;
  800c3b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c42:	e9 77 ff ff ff       	jmp    800bbe <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c47:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c4e:	e9 6b ff ff ff       	jmp    800bbe <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c53:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c54:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c58:	0f 89 60 ff ff ff    	jns    800bbe <vprintfmt+0x54>
				width = precision, precision = -1;
  800c5e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c61:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c64:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c6b:	e9 4e ff ff ff       	jmp    800bbe <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c70:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c73:	e9 46 ff ff ff       	jmp    800bbe <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c78:	8b 45 14             	mov    0x14(%ebp),%eax
  800c7b:	83 c0 04             	add    $0x4,%eax
  800c7e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c81:	8b 45 14             	mov    0x14(%ebp),%eax
  800c84:	83 e8 04             	sub    $0x4,%eax
  800c87:	8b 00                	mov    (%eax),%eax
  800c89:	83 ec 08             	sub    $0x8,%esp
  800c8c:	ff 75 0c             	pushl  0xc(%ebp)
  800c8f:	50                   	push   %eax
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
  800c93:	ff d0                	call   *%eax
  800c95:	83 c4 10             	add    $0x10,%esp
			break;
  800c98:	e9 89 02 00 00       	jmp    800f26 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c9d:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca0:	83 c0 04             	add    $0x4,%eax
  800ca3:	89 45 14             	mov    %eax,0x14(%ebp)
  800ca6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca9:	83 e8 04             	sub    $0x4,%eax
  800cac:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cae:	85 db                	test   %ebx,%ebx
  800cb0:	79 02                	jns    800cb4 <vprintfmt+0x14a>
				err = -err;
  800cb2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cb4:	83 fb 64             	cmp    $0x64,%ebx
  800cb7:	7f 0b                	jg     800cc4 <vprintfmt+0x15a>
  800cb9:	8b 34 9d 20 27 80 00 	mov    0x802720(,%ebx,4),%esi
  800cc0:	85 f6                	test   %esi,%esi
  800cc2:	75 19                	jne    800cdd <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cc4:	53                   	push   %ebx
  800cc5:	68 c5 28 80 00       	push   $0x8028c5
  800cca:	ff 75 0c             	pushl  0xc(%ebp)
  800ccd:	ff 75 08             	pushl  0x8(%ebp)
  800cd0:	e8 5e 02 00 00       	call   800f33 <printfmt>
  800cd5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cd8:	e9 49 02 00 00       	jmp    800f26 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cdd:	56                   	push   %esi
  800cde:	68 ce 28 80 00       	push   $0x8028ce
  800ce3:	ff 75 0c             	pushl  0xc(%ebp)
  800ce6:	ff 75 08             	pushl  0x8(%ebp)
  800ce9:	e8 45 02 00 00       	call   800f33 <printfmt>
  800cee:	83 c4 10             	add    $0x10,%esp
			break;
  800cf1:	e9 30 02 00 00       	jmp    800f26 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cf6:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf9:	83 c0 04             	add    $0x4,%eax
  800cfc:	89 45 14             	mov    %eax,0x14(%ebp)
  800cff:	8b 45 14             	mov    0x14(%ebp),%eax
  800d02:	83 e8 04             	sub    $0x4,%eax
  800d05:	8b 30                	mov    (%eax),%esi
  800d07:	85 f6                	test   %esi,%esi
  800d09:	75 05                	jne    800d10 <vprintfmt+0x1a6>
				p = "(null)";
  800d0b:	be d1 28 80 00       	mov    $0x8028d1,%esi
			if (width > 0 && padc != '-')
  800d10:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d14:	7e 6d                	jle    800d83 <vprintfmt+0x219>
  800d16:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d1a:	74 67                	je     800d83 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d1c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d1f:	83 ec 08             	sub    $0x8,%esp
  800d22:	50                   	push   %eax
  800d23:	56                   	push   %esi
  800d24:	e8 0c 03 00 00       	call   801035 <strnlen>
  800d29:	83 c4 10             	add    $0x10,%esp
  800d2c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d2f:	eb 16                	jmp    800d47 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d31:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d35:	83 ec 08             	sub    $0x8,%esp
  800d38:	ff 75 0c             	pushl  0xc(%ebp)
  800d3b:	50                   	push   %eax
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	ff d0                	call   *%eax
  800d41:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d44:	ff 4d e4             	decl   -0x1c(%ebp)
  800d47:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d4b:	7f e4                	jg     800d31 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d4d:	eb 34                	jmp    800d83 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d4f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d53:	74 1c                	je     800d71 <vprintfmt+0x207>
  800d55:	83 fb 1f             	cmp    $0x1f,%ebx
  800d58:	7e 05                	jle    800d5f <vprintfmt+0x1f5>
  800d5a:	83 fb 7e             	cmp    $0x7e,%ebx
  800d5d:	7e 12                	jle    800d71 <vprintfmt+0x207>
					putch('?', putdat);
  800d5f:	83 ec 08             	sub    $0x8,%esp
  800d62:	ff 75 0c             	pushl  0xc(%ebp)
  800d65:	6a 3f                	push   $0x3f
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6a:	ff d0                	call   *%eax
  800d6c:	83 c4 10             	add    $0x10,%esp
  800d6f:	eb 0f                	jmp    800d80 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d71:	83 ec 08             	sub    $0x8,%esp
  800d74:	ff 75 0c             	pushl  0xc(%ebp)
  800d77:	53                   	push   %ebx
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	ff d0                	call   *%eax
  800d7d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d80:	ff 4d e4             	decl   -0x1c(%ebp)
  800d83:	89 f0                	mov    %esi,%eax
  800d85:	8d 70 01             	lea    0x1(%eax),%esi
  800d88:	8a 00                	mov    (%eax),%al
  800d8a:	0f be d8             	movsbl %al,%ebx
  800d8d:	85 db                	test   %ebx,%ebx
  800d8f:	74 24                	je     800db5 <vprintfmt+0x24b>
  800d91:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d95:	78 b8                	js     800d4f <vprintfmt+0x1e5>
  800d97:	ff 4d e0             	decl   -0x20(%ebp)
  800d9a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d9e:	79 af                	jns    800d4f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800da0:	eb 13                	jmp    800db5 <vprintfmt+0x24b>
				putch(' ', putdat);
  800da2:	83 ec 08             	sub    $0x8,%esp
  800da5:	ff 75 0c             	pushl  0xc(%ebp)
  800da8:	6a 20                	push   $0x20
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dad:	ff d0                	call   *%eax
  800daf:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800db2:	ff 4d e4             	decl   -0x1c(%ebp)
  800db5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800db9:	7f e7                	jg     800da2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dbb:	e9 66 01 00 00       	jmp    800f26 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dc0:	83 ec 08             	sub    $0x8,%esp
  800dc3:	ff 75 e8             	pushl  -0x18(%ebp)
  800dc6:	8d 45 14             	lea    0x14(%ebp),%eax
  800dc9:	50                   	push   %eax
  800dca:	e8 3c fd ff ff       	call   800b0b <getint>
  800dcf:	83 c4 10             	add    $0x10,%esp
  800dd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dd5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ddb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dde:	85 d2                	test   %edx,%edx
  800de0:	79 23                	jns    800e05 <vprintfmt+0x29b>
				putch('-', putdat);
  800de2:	83 ec 08             	sub    $0x8,%esp
  800de5:	ff 75 0c             	pushl  0xc(%ebp)
  800de8:	6a 2d                	push   $0x2d
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	ff d0                	call   *%eax
  800def:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800df2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800df5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800df8:	f7 d8                	neg    %eax
  800dfa:	83 d2 00             	adc    $0x0,%edx
  800dfd:	f7 da                	neg    %edx
  800dff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e02:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e05:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e0c:	e9 bc 00 00 00       	jmp    800ecd <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e11:	83 ec 08             	sub    $0x8,%esp
  800e14:	ff 75 e8             	pushl  -0x18(%ebp)
  800e17:	8d 45 14             	lea    0x14(%ebp),%eax
  800e1a:	50                   	push   %eax
  800e1b:	e8 84 fc ff ff       	call   800aa4 <getuint>
  800e20:	83 c4 10             	add    $0x10,%esp
  800e23:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e26:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e29:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e30:	e9 98 00 00 00       	jmp    800ecd <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e35:	83 ec 08             	sub    $0x8,%esp
  800e38:	ff 75 0c             	pushl  0xc(%ebp)
  800e3b:	6a 58                	push   $0x58
  800e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e40:	ff d0                	call   *%eax
  800e42:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e45:	83 ec 08             	sub    $0x8,%esp
  800e48:	ff 75 0c             	pushl  0xc(%ebp)
  800e4b:	6a 58                	push   $0x58
  800e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e50:	ff d0                	call   *%eax
  800e52:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e55:	83 ec 08             	sub    $0x8,%esp
  800e58:	ff 75 0c             	pushl  0xc(%ebp)
  800e5b:	6a 58                	push   $0x58
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	ff d0                	call   *%eax
  800e62:	83 c4 10             	add    $0x10,%esp
			break;
  800e65:	e9 bc 00 00 00       	jmp    800f26 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e6a:	83 ec 08             	sub    $0x8,%esp
  800e6d:	ff 75 0c             	pushl  0xc(%ebp)
  800e70:	6a 30                	push   $0x30
  800e72:	8b 45 08             	mov    0x8(%ebp),%eax
  800e75:	ff d0                	call   *%eax
  800e77:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e7a:	83 ec 08             	sub    $0x8,%esp
  800e7d:	ff 75 0c             	pushl  0xc(%ebp)
  800e80:	6a 78                	push   $0x78
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	ff d0                	call   *%eax
  800e87:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e8a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e8d:	83 c0 04             	add    $0x4,%eax
  800e90:	89 45 14             	mov    %eax,0x14(%ebp)
  800e93:	8b 45 14             	mov    0x14(%ebp),%eax
  800e96:	83 e8 04             	sub    $0x4,%eax
  800e99:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e9e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ea5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800eac:	eb 1f                	jmp    800ecd <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800eae:	83 ec 08             	sub    $0x8,%esp
  800eb1:	ff 75 e8             	pushl  -0x18(%ebp)
  800eb4:	8d 45 14             	lea    0x14(%ebp),%eax
  800eb7:	50                   	push   %eax
  800eb8:	e8 e7 fb ff ff       	call   800aa4 <getuint>
  800ebd:	83 c4 10             	add    $0x10,%esp
  800ec0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ec3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ec6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ecd:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ed1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ed4:	83 ec 04             	sub    $0x4,%esp
  800ed7:	52                   	push   %edx
  800ed8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800edb:	50                   	push   %eax
  800edc:	ff 75 f4             	pushl  -0xc(%ebp)
  800edf:	ff 75 f0             	pushl  -0x10(%ebp)
  800ee2:	ff 75 0c             	pushl  0xc(%ebp)
  800ee5:	ff 75 08             	pushl  0x8(%ebp)
  800ee8:	e8 00 fb ff ff       	call   8009ed <printnum>
  800eed:	83 c4 20             	add    $0x20,%esp
			break;
  800ef0:	eb 34                	jmp    800f26 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ef2:	83 ec 08             	sub    $0x8,%esp
  800ef5:	ff 75 0c             	pushl  0xc(%ebp)
  800ef8:	53                   	push   %ebx
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	ff d0                	call   *%eax
  800efe:	83 c4 10             	add    $0x10,%esp
			break;
  800f01:	eb 23                	jmp    800f26 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f03:	83 ec 08             	sub    $0x8,%esp
  800f06:	ff 75 0c             	pushl  0xc(%ebp)
  800f09:	6a 25                	push   $0x25
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0e:	ff d0                	call   *%eax
  800f10:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f13:	ff 4d 10             	decl   0x10(%ebp)
  800f16:	eb 03                	jmp    800f1b <vprintfmt+0x3b1>
  800f18:	ff 4d 10             	decl   0x10(%ebp)
  800f1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1e:	48                   	dec    %eax
  800f1f:	8a 00                	mov    (%eax),%al
  800f21:	3c 25                	cmp    $0x25,%al
  800f23:	75 f3                	jne    800f18 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f25:	90                   	nop
		}
	}
  800f26:	e9 47 fc ff ff       	jmp    800b72 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f2b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f2c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f2f:	5b                   	pop    %ebx
  800f30:	5e                   	pop    %esi
  800f31:	5d                   	pop    %ebp
  800f32:	c3                   	ret    

00800f33 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f33:	55                   	push   %ebp
  800f34:	89 e5                	mov    %esp,%ebp
  800f36:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f39:	8d 45 10             	lea    0x10(%ebp),%eax
  800f3c:	83 c0 04             	add    $0x4,%eax
  800f3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f42:	8b 45 10             	mov    0x10(%ebp),%eax
  800f45:	ff 75 f4             	pushl  -0xc(%ebp)
  800f48:	50                   	push   %eax
  800f49:	ff 75 0c             	pushl  0xc(%ebp)
  800f4c:	ff 75 08             	pushl  0x8(%ebp)
  800f4f:	e8 16 fc ff ff       	call   800b6a <vprintfmt>
  800f54:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f57:	90                   	nop
  800f58:	c9                   	leave  
  800f59:	c3                   	ret    

00800f5a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f5a:	55                   	push   %ebp
  800f5b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f60:	8b 40 08             	mov    0x8(%eax),%eax
  800f63:	8d 50 01             	lea    0x1(%eax),%edx
  800f66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f69:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6f:	8b 10                	mov    (%eax),%edx
  800f71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f74:	8b 40 04             	mov    0x4(%eax),%eax
  800f77:	39 c2                	cmp    %eax,%edx
  800f79:	73 12                	jae    800f8d <sprintputch+0x33>
		*b->buf++ = ch;
  800f7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7e:	8b 00                	mov    (%eax),%eax
  800f80:	8d 48 01             	lea    0x1(%eax),%ecx
  800f83:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f86:	89 0a                	mov    %ecx,(%edx)
  800f88:	8b 55 08             	mov    0x8(%ebp),%edx
  800f8b:	88 10                	mov    %dl,(%eax)
}
  800f8d:	90                   	nop
  800f8e:	5d                   	pop    %ebp
  800f8f:	c3                   	ret    

00800f90 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f90:	55                   	push   %ebp
  800f91:	89 e5                	mov    %esp,%ebp
  800f93:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa5:	01 d0                	add    %edx,%eax
  800fa7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800faa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fb1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fb5:	74 06                	je     800fbd <vsnprintf+0x2d>
  800fb7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fbb:	7f 07                	jg     800fc4 <vsnprintf+0x34>
		return -E_INVAL;
  800fbd:	b8 03 00 00 00       	mov    $0x3,%eax
  800fc2:	eb 20                	jmp    800fe4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fc4:	ff 75 14             	pushl  0x14(%ebp)
  800fc7:	ff 75 10             	pushl  0x10(%ebp)
  800fca:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fcd:	50                   	push   %eax
  800fce:	68 5a 0f 80 00       	push   $0x800f5a
  800fd3:	e8 92 fb ff ff       	call   800b6a <vprintfmt>
  800fd8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fdb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fde:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fe1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fe4:	c9                   	leave  
  800fe5:	c3                   	ret    

00800fe6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fe6:	55                   	push   %ebp
  800fe7:	89 e5                	mov    %esp,%ebp
  800fe9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fec:	8d 45 10             	lea    0x10(%ebp),%eax
  800fef:	83 c0 04             	add    $0x4,%eax
  800ff2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ff5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff8:	ff 75 f4             	pushl  -0xc(%ebp)
  800ffb:	50                   	push   %eax
  800ffc:	ff 75 0c             	pushl  0xc(%ebp)
  800fff:	ff 75 08             	pushl  0x8(%ebp)
  801002:	e8 89 ff ff ff       	call   800f90 <vsnprintf>
  801007:	83 c4 10             	add    $0x10,%esp
  80100a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80100d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801010:	c9                   	leave  
  801011:	c3                   	ret    

00801012 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801012:	55                   	push   %ebp
  801013:	89 e5                	mov    %esp,%ebp
  801015:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801018:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80101f:	eb 06                	jmp    801027 <strlen+0x15>
		n++;
  801021:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801024:	ff 45 08             	incl   0x8(%ebp)
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	8a 00                	mov    (%eax),%al
  80102c:	84 c0                	test   %al,%al
  80102e:	75 f1                	jne    801021 <strlen+0xf>
		n++;
	return n;
  801030:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801033:	c9                   	leave  
  801034:	c3                   	ret    

00801035 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801035:	55                   	push   %ebp
  801036:	89 e5                	mov    %esp,%ebp
  801038:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80103b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801042:	eb 09                	jmp    80104d <strnlen+0x18>
		n++;
  801044:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801047:	ff 45 08             	incl   0x8(%ebp)
  80104a:	ff 4d 0c             	decl   0xc(%ebp)
  80104d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801051:	74 09                	je     80105c <strnlen+0x27>
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	8a 00                	mov    (%eax),%al
  801058:	84 c0                	test   %al,%al
  80105a:	75 e8                	jne    801044 <strnlen+0xf>
		n++;
	return n;
  80105c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80105f:	c9                   	leave  
  801060:	c3                   	ret    

00801061 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801061:	55                   	push   %ebp
  801062:	89 e5                	mov    %esp,%ebp
  801064:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801067:	8b 45 08             	mov    0x8(%ebp),%eax
  80106a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80106d:	90                   	nop
  80106e:	8b 45 08             	mov    0x8(%ebp),%eax
  801071:	8d 50 01             	lea    0x1(%eax),%edx
  801074:	89 55 08             	mov    %edx,0x8(%ebp)
  801077:	8b 55 0c             	mov    0xc(%ebp),%edx
  80107a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80107d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801080:	8a 12                	mov    (%edx),%dl
  801082:	88 10                	mov    %dl,(%eax)
  801084:	8a 00                	mov    (%eax),%al
  801086:	84 c0                	test   %al,%al
  801088:	75 e4                	jne    80106e <strcpy+0xd>
		/* do nothing */;
	return ret;
  80108a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80108d:	c9                   	leave  
  80108e:	c3                   	ret    

0080108f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80108f:	55                   	push   %ebp
  801090:	89 e5                	mov    %esp,%ebp
  801092:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801095:	8b 45 08             	mov    0x8(%ebp),%eax
  801098:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80109b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010a2:	eb 1f                	jmp    8010c3 <strncpy+0x34>
		*dst++ = *src;
  8010a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a7:	8d 50 01             	lea    0x1(%eax),%edx
  8010aa:	89 55 08             	mov    %edx,0x8(%ebp)
  8010ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010b0:	8a 12                	mov    (%edx),%dl
  8010b2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b7:	8a 00                	mov    (%eax),%al
  8010b9:	84 c0                	test   %al,%al
  8010bb:	74 03                	je     8010c0 <strncpy+0x31>
			src++;
  8010bd:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010c0:	ff 45 fc             	incl   -0x4(%ebp)
  8010c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010c6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010c9:	72 d9                	jb     8010a4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010ce:	c9                   	leave  
  8010cf:	c3                   	ret    

008010d0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010d0:	55                   	push   %ebp
  8010d1:	89 e5                	mov    %esp,%ebp
  8010d3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e0:	74 30                	je     801112 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010e2:	eb 16                	jmp    8010fa <strlcpy+0x2a>
			*dst++ = *src++;
  8010e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e7:	8d 50 01             	lea    0x1(%eax),%edx
  8010ea:	89 55 08             	mov    %edx,0x8(%ebp)
  8010ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010f3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010f6:	8a 12                	mov    (%edx),%dl
  8010f8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010fa:	ff 4d 10             	decl   0x10(%ebp)
  8010fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801101:	74 09                	je     80110c <strlcpy+0x3c>
  801103:	8b 45 0c             	mov    0xc(%ebp),%eax
  801106:	8a 00                	mov    (%eax),%al
  801108:	84 c0                	test   %al,%al
  80110a:	75 d8                	jne    8010e4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80110c:	8b 45 08             	mov    0x8(%ebp),%eax
  80110f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801112:	8b 55 08             	mov    0x8(%ebp),%edx
  801115:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801118:	29 c2                	sub    %eax,%edx
  80111a:	89 d0                	mov    %edx,%eax
}
  80111c:	c9                   	leave  
  80111d:	c3                   	ret    

0080111e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80111e:	55                   	push   %ebp
  80111f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801121:	eb 06                	jmp    801129 <strcmp+0xb>
		p++, q++;
  801123:	ff 45 08             	incl   0x8(%ebp)
  801126:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	8a 00                	mov    (%eax),%al
  80112e:	84 c0                	test   %al,%al
  801130:	74 0e                	je     801140 <strcmp+0x22>
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	8a 10                	mov    (%eax),%dl
  801137:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113a:	8a 00                	mov    (%eax),%al
  80113c:	38 c2                	cmp    %al,%dl
  80113e:	74 e3                	je     801123 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801140:	8b 45 08             	mov    0x8(%ebp),%eax
  801143:	8a 00                	mov    (%eax),%al
  801145:	0f b6 d0             	movzbl %al,%edx
  801148:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114b:	8a 00                	mov    (%eax),%al
  80114d:	0f b6 c0             	movzbl %al,%eax
  801150:	29 c2                	sub    %eax,%edx
  801152:	89 d0                	mov    %edx,%eax
}
  801154:	5d                   	pop    %ebp
  801155:	c3                   	ret    

00801156 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801156:	55                   	push   %ebp
  801157:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801159:	eb 09                	jmp    801164 <strncmp+0xe>
		n--, p++, q++;
  80115b:	ff 4d 10             	decl   0x10(%ebp)
  80115e:	ff 45 08             	incl   0x8(%ebp)
  801161:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801164:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801168:	74 17                	je     801181 <strncmp+0x2b>
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	84 c0                	test   %al,%al
  801171:	74 0e                	je     801181 <strncmp+0x2b>
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	8a 10                	mov    (%eax),%dl
  801178:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117b:	8a 00                	mov    (%eax),%al
  80117d:	38 c2                	cmp    %al,%dl
  80117f:	74 da                	je     80115b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801181:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801185:	75 07                	jne    80118e <strncmp+0x38>
		return 0;
  801187:	b8 00 00 00 00       	mov    $0x0,%eax
  80118c:	eb 14                	jmp    8011a2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80118e:	8b 45 08             	mov    0x8(%ebp),%eax
  801191:	8a 00                	mov    (%eax),%al
  801193:	0f b6 d0             	movzbl %al,%edx
  801196:	8b 45 0c             	mov    0xc(%ebp),%eax
  801199:	8a 00                	mov    (%eax),%al
  80119b:	0f b6 c0             	movzbl %al,%eax
  80119e:	29 c2                	sub    %eax,%edx
  8011a0:	89 d0                	mov    %edx,%eax
}
  8011a2:	5d                   	pop    %ebp
  8011a3:	c3                   	ret    

008011a4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011a4:	55                   	push   %ebp
  8011a5:	89 e5                	mov    %esp,%ebp
  8011a7:	83 ec 04             	sub    $0x4,%esp
  8011aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ad:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011b0:	eb 12                	jmp    8011c4 <strchr+0x20>
		if (*s == c)
  8011b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b5:	8a 00                	mov    (%eax),%al
  8011b7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011ba:	75 05                	jne    8011c1 <strchr+0x1d>
			return (char *) s;
  8011bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bf:	eb 11                	jmp    8011d2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011c1:	ff 45 08             	incl   0x8(%ebp)
  8011c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c7:	8a 00                	mov    (%eax),%al
  8011c9:	84 c0                	test   %al,%al
  8011cb:	75 e5                	jne    8011b2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011d2:	c9                   	leave  
  8011d3:	c3                   	ret    

008011d4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011d4:	55                   	push   %ebp
  8011d5:	89 e5                	mov    %esp,%ebp
  8011d7:	83 ec 04             	sub    $0x4,%esp
  8011da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011e0:	eb 0d                	jmp    8011ef <strfind+0x1b>
		if (*s == c)
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011ea:	74 0e                	je     8011fa <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011ec:	ff 45 08             	incl   0x8(%ebp)
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	8a 00                	mov    (%eax),%al
  8011f4:	84 c0                	test   %al,%al
  8011f6:	75 ea                	jne    8011e2 <strfind+0xe>
  8011f8:	eb 01                	jmp    8011fb <strfind+0x27>
		if (*s == c)
			break;
  8011fa:	90                   	nop
	return (char *) s;
  8011fb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011fe:	c9                   	leave  
  8011ff:	c3                   	ret    

00801200 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801200:	55                   	push   %ebp
  801201:	89 e5                	mov    %esp,%ebp
  801203:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801206:	8b 45 08             	mov    0x8(%ebp),%eax
  801209:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80120c:	8b 45 10             	mov    0x10(%ebp),%eax
  80120f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801212:	eb 0e                	jmp    801222 <memset+0x22>
		*p++ = c;
  801214:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801217:	8d 50 01             	lea    0x1(%eax),%edx
  80121a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80121d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801220:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801222:	ff 4d f8             	decl   -0x8(%ebp)
  801225:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801229:	79 e9                	jns    801214 <memset+0x14>
		*p++ = c;

	return v;
  80122b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80122e:	c9                   	leave  
  80122f:	c3                   	ret    

00801230 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801230:	55                   	push   %ebp
  801231:	89 e5                	mov    %esp,%ebp
  801233:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801236:	8b 45 0c             	mov    0xc(%ebp),%eax
  801239:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80123c:	8b 45 08             	mov    0x8(%ebp),%eax
  80123f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801242:	eb 16                	jmp    80125a <memcpy+0x2a>
		*d++ = *s++;
  801244:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801247:	8d 50 01             	lea    0x1(%eax),%edx
  80124a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80124d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801250:	8d 4a 01             	lea    0x1(%edx),%ecx
  801253:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801256:	8a 12                	mov    (%edx),%dl
  801258:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80125a:	8b 45 10             	mov    0x10(%ebp),%eax
  80125d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801260:	89 55 10             	mov    %edx,0x10(%ebp)
  801263:	85 c0                	test   %eax,%eax
  801265:	75 dd                	jne    801244 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801267:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80126a:	c9                   	leave  
  80126b:	c3                   	ret    

0080126c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80126c:	55                   	push   %ebp
  80126d:	89 e5                	mov    %esp,%ebp
  80126f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801272:	8b 45 0c             	mov    0xc(%ebp),%eax
  801275:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80127e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801281:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801284:	73 50                	jae    8012d6 <memmove+0x6a>
  801286:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801289:	8b 45 10             	mov    0x10(%ebp),%eax
  80128c:	01 d0                	add    %edx,%eax
  80128e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801291:	76 43                	jbe    8012d6 <memmove+0x6a>
		s += n;
  801293:	8b 45 10             	mov    0x10(%ebp),%eax
  801296:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801299:	8b 45 10             	mov    0x10(%ebp),%eax
  80129c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80129f:	eb 10                	jmp    8012b1 <memmove+0x45>
			*--d = *--s;
  8012a1:	ff 4d f8             	decl   -0x8(%ebp)
  8012a4:	ff 4d fc             	decl   -0x4(%ebp)
  8012a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012aa:	8a 10                	mov    (%eax),%dl
  8012ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012af:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012b7:	89 55 10             	mov    %edx,0x10(%ebp)
  8012ba:	85 c0                	test   %eax,%eax
  8012bc:	75 e3                	jne    8012a1 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012be:	eb 23                	jmp    8012e3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c3:	8d 50 01             	lea    0x1(%eax),%edx
  8012c6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012cc:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012cf:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012d2:	8a 12                	mov    (%edx),%dl
  8012d4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012dc:	89 55 10             	mov    %edx,0x10(%ebp)
  8012df:	85 c0                	test   %eax,%eax
  8012e1:	75 dd                	jne    8012c0 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012e3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012e6:	c9                   	leave  
  8012e7:	c3                   	ret    

008012e8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012e8:	55                   	push   %ebp
  8012e9:	89 e5                	mov    %esp,%ebp
  8012eb:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f7:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012fa:	eb 2a                	jmp    801326 <memcmp+0x3e>
		if (*s1 != *s2)
  8012fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ff:	8a 10                	mov    (%eax),%dl
  801301:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801304:	8a 00                	mov    (%eax),%al
  801306:	38 c2                	cmp    %al,%dl
  801308:	74 16                	je     801320 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80130a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80130d:	8a 00                	mov    (%eax),%al
  80130f:	0f b6 d0             	movzbl %al,%edx
  801312:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801315:	8a 00                	mov    (%eax),%al
  801317:	0f b6 c0             	movzbl %al,%eax
  80131a:	29 c2                	sub    %eax,%edx
  80131c:	89 d0                	mov    %edx,%eax
  80131e:	eb 18                	jmp    801338 <memcmp+0x50>
		s1++, s2++;
  801320:	ff 45 fc             	incl   -0x4(%ebp)
  801323:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801326:	8b 45 10             	mov    0x10(%ebp),%eax
  801329:	8d 50 ff             	lea    -0x1(%eax),%edx
  80132c:	89 55 10             	mov    %edx,0x10(%ebp)
  80132f:	85 c0                	test   %eax,%eax
  801331:	75 c9                	jne    8012fc <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801333:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801338:	c9                   	leave  
  801339:	c3                   	ret    

0080133a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80133a:	55                   	push   %ebp
  80133b:	89 e5                	mov    %esp,%ebp
  80133d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801340:	8b 55 08             	mov    0x8(%ebp),%edx
  801343:	8b 45 10             	mov    0x10(%ebp),%eax
  801346:	01 d0                	add    %edx,%eax
  801348:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80134b:	eb 15                	jmp    801362 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80134d:	8b 45 08             	mov    0x8(%ebp),%eax
  801350:	8a 00                	mov    (%eax),%al
  801352:	0f b6 d0             	movzbl %al,%edx
  801355:	8b 45 0c             	mov    0xc(%ebp),%eax
  801358:	0f b6 c0             	movzbl %al,%eax
  80135b:	39 c2                	cmp    %eax,%edx
  80135d:	74 0d                	je     80136c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80135f:	ff 45 08             	incl   0x8(%ebp)
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801368:	72 e3                	jb     80134d <memfind+0x13>
  80136a:	eb 01                	jmp    80136d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80136c:	90                   	nop
	return (void *) s;
  80136d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801370:	c9                   	leave  
  801371:	c3                   	ret    

00801372 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
  801375:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801378:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80137f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801386:	eb 03                	jmp    80138b <strtol+0x19>
		s++;
  801388:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
  80138e:	8a 00                	mov    (%eax),%al
  801390:	3c 20                	cmp    $0x20,%al
  801392:	74 f4                	je     801388 <strtol+0x16>
  801394:	8b 45 08             	mov    0x8(%ebp),%eax
  801397:	8a 00                	mov    (%eax),%al
  801399:	3c 09                	cmp    $0x9,%al
  80139b:	74 eb                	je     801388 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	3c 2b                	cmp    $0x2b,%al
  8013a4:	75 05                	jne    8013ab <strtol+0x39>
		s++;
  8013a6:	ff 45 08             	incl   0x8(%ebp)
  8013a9:	eb 13                	jmp    8013be <strtol+0x4c>
	else if (*s == '-')
  8013ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ae:	8a 00                	mov    (%eax),%al
  8013b0:	3c 2d                	cmp    $0x2d,%al
  8013b2:	75 0a                	jne    8013be <strtol+0x4c>
		s++, neg = 1;
  8013b4:	ff 45 08             	incl   0x8(%ebp)
  8013b7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c2:	74 06                	je     8013ca <strtol+0x58>
  8013c4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013c8:	75 20                	jne    8013ea <strtol+0x78>
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	8a 00                	mov    (%eax),%al
  8013cf:	3c 30                	cmp    $0x30,%al
  8013d1:	75 17                	jne    8013ea <strtol+0x78>
  8013d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d6:	40                   	inc    %eax
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	3c 78                	cmp    $0x78,%al
  8013db:	75 0d                	jne    8013ea <strtol+0x78>
		s += 2, base = 16;
  8013dd:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013e1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013e8:	eb 28                	jmp    801412 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013ea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ee:	75 15                	jne    801405 <strtol+0x93>
  8013f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f3:	8a 00                	mov    (%eax),%al
  8013f5:	3c 30                	cmp    $0x30,%al
  8013f7:	75 0c                	jne    801405 <strtol+0x93>
		s++, base = 8;
  8013f9:	ff 45 08             	incl   0x8(%ebp)
  8013fc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801403:	eb 0d                	jmp    801412 <strtol+0xa0>
	else if (base == 0)
  801405:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801409:	75 07                	jne    801412 <strtol+0xa0>
		base = 10;
  80140b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801412:	8b 45 08             	mov    0x8(%ebp),%eax
  801415:	8a 00                	mov    (%eax),%al
  801417:	3c 2f                	cmp    $0x2f,%al
  801419:	7e 19                	jle    801434 <strtol+0xc2>
  80141b:	8b 45 08             	mov    0x8(%ebp),%eax
  80141e:	8a 00                	mov    (%eax),%al
  801420:	3c 39                	cmp    $0x39,%al
  801422:	7f 10                	jg     801434 <strtol+0xc2>
			dig = *s - '0';
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	8a 00                	mov    (%eax),%al
  801429:	0f be c0             	movsbl %al,%eax
  80142c:	83 e8 30             	sub    $0x30,%eax
  80142f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801432:	eb 42                	jmp    801476 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801434:	8b 45 08             	mov    0x8(%ebp),%eax
  801437:	8a 00                	mov    (%eax),%al
  801439:	3c 60                	cmp    $0x60,%al
  80143b:	7e 19                	jle    801456 <strtol+0xe4>
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	8a 00                	mov    (%eax),%al
  801442:	3c 7a                	cmp    $0x7a,%al
  801444:	7f 10                	jg     801456 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	8a 00                	mov    (%eax),%al
  80144b:	0f be c0             	movsbl %al,%eax
  80144e:	83 e8 57             	sub    $0x57,%eax
  801451:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801454:	eb 20                	jmp    801476 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	8a 00                	mov    (%eax),%al
  80145b:	3c 40                	cmp    $0x40,%al
  80145d:	7e 39                	jle    801498 <strtol+0x126>
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	8a 00                	mov    (%eax),%al
  801464:	3c 5a                	cmp    $0x5a,%al
  801466:	7f 30                	jg     801498 <strtol+0x126>
			dig = *s - 'A' + 10;
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	8a 00                	mov    (%eax),%al
  80146d:	0f be c0             	movsbl %al,%eax
  801470:	83 e8 37             	sub    $0x37,%eax
  801473:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801476:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801479:	3b 45 10             	cmp    0x10(%ebp),%eax
  80147c:	7d 19                	jge    801497 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80147e:	ff 45 08             	incl   0x8(%ebp)
  801481:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801484:	0f af 45 10          	imul   0x10(%ebp),%eax
  801488:	89 c2                	mov    %eax,%edx
  80148a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80148d:	01 d0                	add    %edx,%eax
  80148f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801492:	e9 7b ff ff ff       	jmp    801412 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801497:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801498:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80149c:	74 08                	je     8014a6 <strtol+0x134>
		*endptr = (char *) s;
  80149e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a1:	8b 55 08             	mov    0x8(%ebp),%edx
  8014a4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014a6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014aa:	74 07                	je     8014b3 <strtol+0x141>
  8014ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014af:	f7 d8                	neg    %eax
  8014b1:	eb 03                	jmp    8014b6 <strtol+0x144>
  8014b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014b6:	c9                   	leave  
  8014b7:	c3                   	ret    

008014b8 <ltostr>:

void
ltostr(long value, char *str)
{
  8014b8:	55                   	push   %ebp
  8014b9:	89 e5                	mov    %esp,%ebp
  8014bb:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014c5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014cc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014d0:	79 13                	jns    8014e5 <ltostr+0x2d>
	{
		neg = 1;
  8014d2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014dc:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014df:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014e2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014ed:	99                   	cltd   
  8014ee:	f7 f9                	idiv   %ecx
  8014f0:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f6:	8d 50 01             	lea    0x1(%eax),%edx
  8014f9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014fc:	89 c2                	mov    %eax,%edx
  8014fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801501:	01 d0                	add    %edx,%eax
  801503:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801506:	83 c2 30             	add    $0x30,%edx
  801509:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80150b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80150e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801513:	f7 e9                	imul   %ecx
  801515:	c1 fa 02             	sar    $0x2,%edx
  801518:	89 c8                	mov    %ecx,%eax
  80151a:	c1 f8 1f             	sar    $0x1f,%eax
  80151d:	29 c2                	sub    %eax,%edx
  80151f:	89 d0                	mov    %edx,%eax
  801521:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801524:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801527:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80152c:	f7 e9                	imul   %ecx
  80152e:	c1 fa 02             	sar    $0x2,%edx
  801531:	89 c8                	mov    %ecx,%eax
  801533:	c1 f8 1f             	sar    $0x1f,%eax
  801536:	29 c2                	sub    %eax,%edx
  801538:	89 d0                	mov    %edx,%eax
  80153a:	c1 e0 02             	shl    $0x2,%eax
  80153d:	01 d0                	add    %edx,%eax
  80153f:	01 c0                	add    %eax,%eax
  801541:	29 c1                	sub    %eax,%ecx
  801543:	89 ca                	mov    %ecx,%edx
  801545:	85 d2                	test   %edx,%edx
  801547:	75 9c                	jne    8014e5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801549:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801550:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801553:	48                   	dec    %eax
  801554:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801557:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80155b:	74 3d                	je     80159a <ltostr+0xe2>
		start = 1 ;
  80155d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801564:	eb 34                	jmp    80159a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801566:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801569:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156c:	01 d0                	add    %edx,%eax
  80156e:	8a 00                	mov    (%eax),%al
  801570:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801573:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801576:	8b 45 0c             	mov    0xc(%ebp),%eax
  801579:	01 c2                	add    %eax,%edx
  80157b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80157e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801581:	01 c8                	add    %ecx,%eax
  801583:	8a 00                	mov    (%eax),%al
  801585:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801587:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80158a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158d:	01 c2                	add    %eax,%edx
  80158f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801592:	88 02                	mov    %al,(%edx)
		start++ ;
  801594:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801597:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80159a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80159d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015a0:	7c c4                	jl     801566 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015a2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a8:	01 d0                	add    %edx,%eax
  8015aa:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015ad:	90                   	nop
  8015ae:	c9                   	leave  
  8015af:	c3                   	ret    

008015b0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015b0:	55                   	push   %ebp
  8015b1:	89 e5                	mov    %esp,%ebp
  8015b3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015b6:	ff 75 08             	pushl  0x8(%ebp)
  8015b9:	e8 54 fa ff ff       	call   801012 <strlen>
  8015be:	83 c4 04             	add    $0x4,%esp
  8015c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015c4:	ff 75 0c             	pushl  0xc(%ebp)
  8015c7:	e8 46 fa ff ff       	call   801012 <strlen>
  8015cc:	83 c4 04             	add    $0x4,%esp
  8015cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015e0:	eb 17                	jmp    8015f9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e8:	01 c2                	add    %eax,%edx
  8015ea:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	01 c8                	add    %ecx,%eax
  8015f2:	8a 00                	mov    (%eax),%al
  8015f4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015f6:	ff 45 fc             	incl   -0x4(%ebp)
  8015f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015ff:	7c e1                	jl     8015e2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801601:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801608:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80160f:	eb 1f                	jmp    801630 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801611:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801614:	8d 50 01             	lea    0x1(%eax),%edx
  801617:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80161a:	89 c2                	mov    %eax,%edx
  80161c:	8b 45 10             	mov    0x10(%ebp),%eax
  80161f:	01 c2                	add    %eax,%edx
  801621:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801624:	8b 45 0c             	mov    0xc(%ebp),%eax
  801627:	01 c8                	add    %ecx,%eax
  801629:	8a 00                	mov    (%eax),%al
  80162b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80162d:	ff 45 f8             	incl   -0x8(%ebp)
  801630:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801633:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801636:	7c d9                	jl     801611 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801638:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80163b:	8b 45 10             	mov    0x10(%ebp),%eax
  80163e:	01 d0                	add    %edx,%eax
  801640:	c6 00 00             	movb   $0x0,(%eax)
}
  801643:	90                   	nop
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801649:	8b 45 14             	mov    0x14(%ebp),%eax
  80164c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801652:	8b 45 14             	mov    0x14(%ebp),%eax
  801655:	8b 00                	mov    (%eax),%eax
  801657:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80165e:	8b 45 10             	mov    0x10(%ebp),%eax
  801661:	01 d0                	add    %edx,%eax
  801663:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801669:	eb 0c                	jmp    801677 <strsplit+0x31>
			*string++ = 0;
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	8d 50 01             	lea    0x1(%eax),%edx
  801671:	89 55 08             	mov    %edx,0x8(%ebp)
  801674:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801677:	8b 45 08             	mov    0x8(%ebp),%eax
  80167a:	8a 00                	mov    (%eax),%al
  80167c:	84 c0                	test   %al,%al
  80167e:	74 18                	je     801698 <strsplit+0x52>
  801680:	8b 45 08             	mov    0x8(%ebp),%eax
  801683:	8a 00                	mov    (%eax),%al
  801685:	0f be c0             	movsbl %al,%eax
  801688:	50                   	push   %eax
  801689:	ff 75 0c             	pushl  0xc(%ebp)
  80168c:	e8 13 fb ff ff       	call   8011a4 <strchr>
  801691:	83 c4 08             	add    $0x8,%esp
  801694:	85 c0                	test   %eax,%eax
  801696:	75 d3                	jne    80166b <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
  80169b:	8a 00                	mov    (%eax),%al
  80169d:	84 c0                	test   %al,%al
  80169f:	74 5a                	je     8016fb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8016a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8016a4:	8b 00                	mov    (%eax),%eax
  8016a6:	83 f8 0f             	cmp    $0xf,%eax
  8016a9:	75 07                	jne    8016b2 <strsplit+0x6c>
		{
			return 0;
  8016ab:	b8 00 00 00 00       	mov    $0x0,%eax
  8016b0:	eb 66                	jmp    801718 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8016b5:	8b 00                	mov    (%eax),%eax
  8016b7:	8d 48 01             	lea    0x1(%eax),%ecx
  8016ba:	8b 55 14             	mov    0x14(%ebp),%edx
  8016bd:	89 0a                	mov    %ecx,(%edx)
  8016bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c9:	01 c2                	add    %eax,%edx
  8016cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ce:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016d0:	eb 03                	jmp    8016d5 <strsplit+0x8f>
			string++;
  8016d2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d8:	8a 00                	mov    (%eax),%al
  8016da:	84 c0                	test   %al,%al
  8016dc:	74 8b                	je     801669 <strsplit+0x23>
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	8a 00                	mov    (%eax),%al
  8016e3:	0f be c0             	movsbl %al,%eax
  8016e6:	50                   	push   %eax
  8016e7:	ff 75 0c             	pushl  0xc(%ebp)
  8016ea:	e8 b5 fa ff ff       	call   8011a4 <strchr>
  8016ef:	83 c4 08             	add    $0x8,%esp
  8016f2:	85 c0                	test   %eax,%eax
  8016f4:	74 dc                	je     8016d2 <strsplit+0x8c>
			string++;
	}
  8016f6:	e9 6e ff ff ff       	jmp    801669 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016fb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ff:	8b 00                	mov    (%eax),%eax
  801701:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801708:	8b 45 10             	mov    0x10(%ebp),%eax
  80170b:	01 d0                	add    %edx,%eax
  80170d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801713:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801718:	c9                   	leave  
  801719:	c3                   	ret    

0080171a <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80171a:	55                   	push   %ebp
  80171b:	89 e5                	mov    %esp,%ebp
  80171d:	83 ec 18             	sub    $0x18,%esp
  801720:	8b 45 10             	mov    0x10(%ebp),%eax
  801723:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801726:	83 ec 04             	sub    $0x4,%esp
  801729:	68 30 2a 80 00       	push   $0x802a30
  80172e:	6a 17                	push   $0x17
  801730:	68 4f 2a 80 00       	push   $0x802a4f
  801735:	e8 a2 ef ff ff       	call   8006dc <_panic>

0080173a <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80173a:	55                   	push   %ebp
  80173b:	89 e5                	mov    %esp,%ebp
  80173d:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801740:	83 ec 04             	sub    $0x4,%esp
  801743:	68 5b 2a 80 00       	push   $0x802a5b
  801748:	6a 2f                	push   $0x2f
  80174a:	68 4f 2a 80 00       	push   $0x802a4f
  80174f:	e8 88 ef ff ff       	call   8006dc <_panic>

00801754 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801754:	55                   	push   %ebp
  801755:	89 e5                	mov    %esp,%ebp
  801757:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80175a:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801761:	8b 55 08             	mov    0x8(%ebp),%edx
  801764:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801767:	01 d0                	add    %edx,%eax
  801769:	48                   	dec    %eax
  80176a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  80176d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801770:	ba 00 00 00 00       	mov    $0x0,%edx
  801775:	f7 75 ec             	divl   -0x14(%ebp)
  801778:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80177b:	29 d0                	sub    %edx,%eax
  80177d:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801780:	8b 45 08             	mov    0x8(%ebp),%eax
  801783:	c1 e8 0c             	shr    $0xc,%eax
  801786:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801789:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801790:	e9 c8 00 00 00       	jmp    80185d <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801795:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80179c:	eb 27                	jmp    8017c5 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  80179e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017a4:	01 c2                	add    %eax,%edx
  8017a6:	89 d0                	mov    %edx,%eax
  8017a8:	01 c0                	add    %eax,%eax
  8017aa:	01 d0                	add    %edx,%eax
  8017ac:	c1 e0 02             	shl    $0x2,%eax
  8017af:	05 88 30 d0 00       	add    $0xd03088,%eax
  8017b4:	8b 00                	mov    (%eax),%eax
  8017b6:	85 c0                	test   %eax,%eax
  8017b8:	74 08                	je     8017c2 <malloc+0x6e>
            	i += j;
  8017ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017bd:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8017c0:	eb 0b                	jmp    8017cd <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8017c2:	ff 45 f0             	incl   -0x10(%ebp)
  8017c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017c8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8017cb:	72 d1                	jb     80179e <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8017cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017d0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8017d3:	0f 85 81 00 00 00    	jne    80185a <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8017d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017dc:	05 00 00 08 00       	add    $0x80000,%eax
  8017e1:	c1 e0 0c             	shl    $0xc,%eax
  8017e4:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8017e7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8017ee:	eb 1f                	jmp    80180f <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  8017f0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017f6:	01 c2                	add    %eax,%edx
  8017f8:	89 d0                	mov    %edx,%eax
  8017fa:	01 c0                	add    %eax,%eax
  8017fc:	01 d0                	add    %edx,%eax
  8017fe:	c1 e0 02             	shl    $0x2,%eax
  801801:	05 88 30 d0 00       	add    $0xd03088,%eax
  801806:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80180c:	ff 45 f0             	incl   -0x10(%ebp)
  80180f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801812:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801815:	72 d9                	jb     8017f0 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801817:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80181a:	89 d0                	mov    %edx,%eax
  80181c:	01 c0                	add    %eax,%eax
  80181e:	01 d0                	add    %edx,%eax
  801820:	c1 e0 02             	shl    $0x2,%eax
  801823:	8d 90 80 30 d0 00    	lea    0xd03080(%eax),%edx
  801829:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80182c:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  80182e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801831:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801834:	89 c8                	mov    %ecx,%eax
  801836:	01 c0                	add    %eax,%eax
  801838:	01 c8                	add    %ecx,%eax
  80183a:	c1 e0 02             	shl    $0x2,%eax
  80183d:	05 84 30 d0 00       	add    $0xd03084,%eax
  801842:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801844:	83 ec 08             	sub    $0x8,%esp
  801847:	ff 75 08             	pushl  0x8(%ebp)
  80184a:	ff 75 e0             	pushl  -0x20(%ebp)
  80184d:	e8 2b 03 00 00       	call   801b7d <sys_allocateMem>
  801852:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801855:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801858:	eb 19                	jmp    801873 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80185a:	ff 45 f4             	incl   -0xc(%ebp)
  80185d:	a1 04 30 80 00       	mov    0x803004,%eax
  801862:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801865:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801868:	0f 83 27 ff ff ff    	jae    801795 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  80186e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801873:	c9                   	leave  
  801874:	c3                   	ret    

00801875 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801875:	55                   	push   %ebp
  801876:	89 e5                	mov    %esp,%ebp
  801878:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80187b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80187f:	0f 84 e5 00 00 00    	je     80196a <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801885:	8b 45 08             	mov    0x8(%ebp),%eax
  801888:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  80188b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80188e:	05 00 00 00 80       	add    $0x80000000,%eax
  801893:	c1 e8 0c             	shr    $0xc,%eax
  801896:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801899:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80189c:	89 d0                	mov    %edx,%eax
  80189e:	01 c0                	add    %eax,%eax
  8018a0:	01 d0                	add    %edx,%eax
  8018a2:	c1 e0 02             	shl    $0x2,%eax
  8018a5:	05 80 30 d0 00       	add    $0xd03080,%eax
  8018aa:	8b 00                	mov    (%eax),%eax
  8018ac:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018af:	0f 85 b8 00 00 00    	jne    80196d <free+0xf8>
  8018b5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018b8:	89 d0                	mov    %edx,%eax
  8018ba:	01 c0                	add    %eax,%eax
  8018bc:	01 d0                	add    %edx,%eax
  8018be:	c1 e0 02             	shl    $0x2,%eax
  8018c1:	05 88 30 d0 00       	add    $0xd03088,%eax
  8018c6:	8b 00                	mov    (%eax),%eax
  8018c8:	85 c0                	test   %eax,%eax
  8018ca:	0f 84 9d 00 00 00    	je     80196d <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8018d0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018d3:	89 d0                	mov    %edx,%eax
  8018d5:	01 c0                	add    %eax,%eax
  8018d7:	01 d0                	add    %edx,%eax
  8018d9:	c1 e0 02             	shl    $0x2,%eax
  8018dc:	05 84 30 d0 00       	add    $0xd03084,%eax
  8018e1:	8b 00                	mov    (%eax),%eax
  8018e3:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  8018e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018e9:	c1 e0 0c             	shl    $0xc,%eax
  8018ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  8018ef:	83 ec 08             	sub    $0x8,%esp
  8018f2:	ff 75 e4             	pushl  -0x1c(%ebp)
  8018f5:	ff 75 f0             	pushl  -0x10(%ebp)
  8018f8:	e8 64 02 00 00       	call   801b61 <sys_freeMem>
  8018fd:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801900:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801907:	eb 57                	jmp    801960 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801909:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80190c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80190f:	01 c2                	add    %eax,%edx
  801911:	89 d0                	mov    %edx,%eax
  801913:	01 c0                	add    %eax,%eax
  801915:	01 d0                	add    %edx,%eax
  801917:	c1 e0 02             	shl    $0x2,%eax
  80191a:	05 88 30 d0 00       	add    $0xd03088,%eax
  80191f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801925:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801928:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80192b:	01 c2                	add    %eax,%edx
  80192d:	89 d0                	mov    %edx,%eax
  80192f:	01 c0                	add    %eax,%eax
  801931:	01 d0                	add    %edx,%eax
  801933:	c1 e0 02             	shl    $0x2,%eax
  801936:	05 80 30 d0 00       	add    $0xd03080,%eax
  80193b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801941:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801944:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801947:	01 c2                	add    %eax,%edx
  801949:	89 d0                	mov    %edx,%eax
  80194b:	01 c0                	add    %eax,%eax
  80194d:	01 d0                	add    %edx,%eax
  80194f:	c1 e0 02             	shl    $0x2,%eax
  801952:	05 84 30 d0 00       	add    $0xd03084,%eax
  801957:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80195d:	ff 45 f4             	incl   -0xc(%ebp)
  801960:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801963:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801966:	7c a1                	jl     801909 <free+0x94>
  801968:	eb 04                	jmp    80196e <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80196a:	90                   	nop
  80196b:	eb 01                	jmp    80196e <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  80196d:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
  801973:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801976:	83 ec 04             	sub    $0x4,%esp
  801979:	68 78 2a 80 00       	push   $0x802a78
  80197e:	68 ae 00 00 00       	push   $0xae
  801983:	68 4f 2a 80 00       	push   $0x802a4f
  801988:	e8 4f ed ff ff       	call   8006dc <_panic>

0080198d <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80198d:	55                   	push   %ebp
  80198e:	89 e5                	mov    %esp,%ebp
  801990:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801993:	83 ec 04             	sub    $0x4,%esp
  801996:	68 98 2a 80 00       	push   $0x802a98
  80199b:	68 ca 00 00 00       	push   $0xca
  8019a0:	68 4f 2a 80 00       	push   $0x802a4f
  8019a5:	e8 32 ed ff ff       	call   8006dc <_panic>

008019aa <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8019aa:	55                   	push   %ebp
  8019ab:	89 e5                	mov    %esp,%ebp
  8019ad:	57                   	push   %edi
  8019ae:	56                   	push   %esi
  8019af:	53                   	push   %ebx
  8019b0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8019b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019b9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019bc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019bf:	8b 7d 18             	mov    0x18(%ebp),%edi
  8019c2:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8019c5:	cd 30                	int    $0x30
  8019c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8019ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8019cd:	83 c4 10             	add    $0x10,%esp
  8019d0:	5b                   	pop    %ebx
  8019d1:	5e                   	pop    %esi
  8019d2:	5f                   	pop    %edi
  8019d3:	5d                   	pop    %ebp
  8019d4:	c3                   	ret    

008019d5 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8019d5:	55                   	push   %ebp
  8019d6:	89 e5                	mov    %esp,%ebp
  8019d8:	83 ec 04             	sub    $0x4,%esp
  8019db:	8b 45 10             	mov    0x10(%ebp),%eax
  8019de:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8019e1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8019e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	52                   	push   %edx
  8019ed:	ff 75 0c             	pushl  0xc(%ebp)
  8019f0:	50                   	push   %eax
  8019f1:	6a 00                	push   $0x0
  8019f3:	e8 b2 ff ff ff       	call   8019aa <syscall>
  8019f8:	83 c4 18             	add    $0x18,%esp
}
  8019fb:	90                   	nop
  8019fc:	c9                   	leave  
  8019fd:	c3                   	ret    

008019fe <sys_cgetc>:

int
sys_cgetc(void)
{
  8019fe:	55                   	push   %ebp
  8019ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 01                	push   $0x1
  801a0d:	e8 98 ff ff ff       	call   8019aa <syscall>
  801a12:	83 c4 18             	add    $0x18,%esp
}
  801a15:	c9                   	leave  
  801a16:	c3                   	ret    

00801a17 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a17:	55                   	push   %ebp
  801a18:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	50                   	push   %eax
  801a26:	6a 05                	push   $0x5
  801a28:	e8 7d ff ff ff       	call   8019aa <syscall>
  801a2d:	83 c4 18             	add    $0x18,%esp
}
  801a30:	c9                   	leave  
  801a31:	c3                   	ret    

00801a32 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a32:	55                   	push   %ebp
  801a33:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a35:	6a 00                	push   $0x0
  801a37:	6a 00                	push   $0x0
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 02                	push   $0x2
  801a41:	e8 64 ff ff ff       	call   8019aa <syscall>
  801a46:	83 c4 18             	add    $0x18,%esp
}
  801a49:	c9                   	leave  
  801a4a:	c3                   	ret    

00801a4b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801a4b:	55                   	push   %ebp
  801a4c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 03                	push   $0x3
  801a5a:	e8 4b ff ff ff       	call   8019aa <syscall>
  801a5f:	83 c4 18             	add    $0x18,%esp
}
  801a62:	c9                   	leave  
  801a63:	c3                   	ret    

00801a64 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801a64:	55                   	push   %ebp
  801a65:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 04                	push   $0x4
  801a73:	e8 32 ff ff ff       	call   8019aa <syscall>
  801a78:	83 c4 18             	add    $0x18,%esp
}
  801a7b:	c9                   	leave  
  801a7c:	c3                   	ret    

00801a7d <sys_env_exit>:


void sys_env_exit(void)
{
  801a7d:	55                   	push   %ebp
  801a7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 06                	push   $0x6
  801a8c:	e8 19 ff ff ff       	call   8019aa <syscall>
  801a91:	83 c4 18             	add    $0x18,%esp
}
  801a94:	90                   	nop
  801a95:	c9                   	leave  
  801a96:	c3                   	ret    

00801a97 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801a97:	55                   	push   %ebp
  801a98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801a9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	52                   	push   %edx
  801aa7:	50                   	push   %eax
  801aa8:	6a 07                	push   $0x7
  801aaa:	e8 fb fe ff ff       	call   8019aa <syscall>
  801aaf:	83 c4 18             	add    $0x18,%esp
}
  801ab2:	c9                   	leave  
  801ab3:	c3                   	ret    

00801ab4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ab4:	55                   	push   %ebp
  801ab5:	89 e5                	mov    %esp,%ebp
  801ab7:	56                   	push   %esi
  801ab8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801ab9:	8b 75 18             	mov    0x18(%ebp),%esi
  801abc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801abf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ac2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac8:	56                   	push   %esi
  801ac9:	53                   	push   %ebx
  801aca:	51                   	push   %ecx
  801acb:	52                   	push   %edx
  801acc:	50                   	push   %eax
  801acd:	6a 08                	push   $0x8
  801acf:	e8 d6 fe ff ff       	call   8019aa <syscall>
  801ad4:	83 c4 18             	add    $0x18,%esp
}
  801ad7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ada:	5b                   	pop    %ebx
  801adb:	5e                   	pop    %esi
  801adc:	5d                   	pop    %ebp
  801add:	c3                   	ret    

00801ade <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ade:	55                   	push   %ebp
  801adf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801ae1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	52                   	push   %edx
  801aee:	50                   	push   %eax
  801aef:	6a 09                	push   $0x9
  801af1:	e8 b4 fe ff ff       	call   8019aa <syscall>
  801af6:	83 c4 18             	add    $0x18,%esp
}
  801af9:	c9                   	leave  
  801afa:	c3                   	ret    

00801afb <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801afb:	55                   	push   %ebp
  801afc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	ff 75 0c             	pushl  0xc(%ebp)
  801b07:	ff 75 08             	pushl  0x8(%ebp)
  801b0a:	6a 0a                	push   $0xa
  801b0c:	e8 99 fe ff ff       	call   8019aa <syscall>
  801b11:	83 c4 18             	add    $0x18,%esp
}
  801b14:	c9                   	leave  
  801b15:	c3                   	ret    

00801b16 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b16:	55                   	push   %ebp
  801b17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 0b                	push   $0xb
  801b25:	e8 80 fe ff ff       	call   8019aa <syscall>
  801b2a:	83 c4 18             	add    $0x18,%esp
}
  801b2d:	c9                   	leave  
  801b2e:	c3                   	ret    

00801b2f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b2f:	55                   	push   %ebp
  801b30:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 00                	push   $0x0
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 0c                	push   $0xc
  801b3e:	e8 67 fe ff ff       	call   8019aa <syscall>
  801b43:	83 c4 18             	add    $0x18,%esp
}
  801b46:	c9                   	leave  
  801b47:	c3                   	ret    

00801b48 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b48:	55                   	push   %ebp
  801b49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 0d                	push   $0xd
  801b57:	e8 4e fe ff ff       	call   8019aa <syscall>
  801b5c:	83 c4 18             	add    $0x18,%esp
}
  801b5f:	c9                   	leave  
  801b60:	c3                   	ret    

00801b61 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801b61:	55                   	push   %ebp
  801b62:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801b64:	6a 00                	push   $0x0
  801b66:	6a 00                	push   $0x0
  801b68:	6a 00                	push   $0x0
  801b6a:	ff 75 0c             	pushl  0xc(%ebp)
  801b6d:	ff 75 08             	pushl  0x8(%ebp)
  801b70:	6a 11                	push   $0x11
  801b72:	e8 33 fe ff ff       	call   8019aa <syscall>
  801b77:	83 c4 18             	add    $0x18,%esp
	return;
  801b7a:	90                   	nop
}
  801b7b:	c9                   	leave  
  801b7c:	c3                   	ret    

00801b7d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801b7d:	55                   	push   %ebp
  801b7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	ff 75 0c             	pushl  0xc(%ebp)
  801b89:	ff 75 08             	pushl  0x8(%ebp)
  801b8c:	6a 12                	push   $0x12
  801b8e:	e8 17 fe ff ff       	call   8019aa <syscall>
  801b93:	83 c4 18             	add    $0x18,%esp
	return ;
  801b96:	90                   	nop
}
  801b97:	c9                   	leave  
  801b98:	c3                   	ret    

00801b99 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801b99:	55                   	push   %ebp
  801b9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 0e                	push   $0xe
  801ba8:	e8 fd fd ff ff       	call   8019aa <syscall>
  801bad:	83 c4 18             	add    $0x18,%esp
}
  801bb0:	c9                   	leave  
  801bb1:	c3                   	ret    

00801bb2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801bb2:	55                   	push   %ebp
  801bb3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 00                	push   $0x0
  801bbd:	ff 75 08             	pushl  0x8(%ebp)
  801bc0:	6a 0f                	push   $0xf
  801bc2:	e8 e3 fd ff ff       	call   8019aa <syscall>
  801bc7:	83 c4 18             	add    $0x18,%esp
}
  801bca:	c9                   	leave  
  801bcb:	c3                   	ret    

00801bcc <sys_scarce_memory>:

void sys_scarce_memory()
{
  801bcc:	55                   	push   %ebp
  801bcd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 10                	push   $0x10
  801bdb:	e8 ca fd ff ff       	call   8019aa <syscall>
  801be0:	83 c4 18             	add    $0x18,%esp
}
  801be3:	90                   	nop
  801be4:	c9                   	leave  
  801be5:	c3                   	ret    

00801be6 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801be6:	55                   	push   %ebp
  801be7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 14                	push   $0x14
  801bf5:	e8 b0 fd ff ff       	call   8019aa <syscall>
  801bfa:	83 c4 18             	add    $0x18,%esp
}
  801bfd:	90                   	nop
  801bfe:	c9                   	leave  
  801bff:	c3                   	ret    

00801c00 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c00:	55                   	push   %ebp
  801c01:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 00                	push   $0x0
  801c0d:	6a 15                	push   $0x15
  801c0f:	e8 96 fd ff ff       	call   8019aa <syscall>
  801c14:	83 c4 18             	add    $0x18,%esp
}
  801c17:	90                   	nop
  801c18:	c9                   	leave  
  801c19:	c3                   	ret    

00801c1a <sys_cputc>:


void
sys_cputc(const char c)
{
  801c1a:	55                   	push   %ebp
  801c1b:	89 e5                	mov    %esp,%ebp
  801c1d:	83 ec 04             	sub    $0x4,%esp
  801c20:	8b 45 08             	mov    0x8(%ebp),%eax
  801c23:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801c26:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c2a:	6a 00                	push   $0x0
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	50                   	push   %eax
  801c33:	6a 16                	push   $0x16
  801c35:	e8 70 fd ff ff       	call   8019aa <syscall>
  801c3a:	83 c4 18             	add    $0x18,%esp
}
  801c3d:	90                   	nop
  801c3e:	c9                   	leave  
  801c3f:	c3                   	ret    

00801c40 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c40:	55                   	push   %ebp
  801c41:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 17                	push   $0x17
  801c4f:	e8 56 fd ff ff       	call   8019aa <syscall>
  801c54:	83 c4 18             	add    $0x18,%esp
}
  801c57:	90                   	nop
  801c58:	c9                   	leave  
  801c59:	c3                   	ret    

00801c5a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801c5a:	55                   	push   %ebp
  801c5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801c5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c60:	6a 00                	push   $0x0
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	ff 75 0c             	pushl  0xc(%ebp)
  801c69:	50                   	push   %eax
  801c6a:	6a 18                	push   $0x18
  801c6c:	e8 39 fd ff ff       	call   8019aa <syscall>
  801c71:	83 c4 18             	add    $0x18,%esp
}
  801c74:	c9                   	leave  
  801c75:	c3                   	ret    

00801c76 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801c76:	55                   	push   %ebp
  801c77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c79:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	6a 00                	push   $0x0
  801c85:	52                   	push   %edx
  801c86:	50                   	push   %eax
  801c87:	6a 1b                	push   $0x1b
  801c89:	e8 1c fd ff ff       	call   8019aa <syscall>
  801c8e:	83 c4 18             	add    $0x18,%esp
}
  801c91:	c9                   	leave  
  801c92:	c3                   	ret    

00801c93 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c93:	55                   	push   %ebp
  801c94:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c96:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c99:	8b 45 08             	mov    0x8(%ebp),%eax
  801c9c:	6a 00                	push   $0x0
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	52                   	push   %edx
  801ca3:	50                   	push   %eax
  801ca4:	6a 19                	push   $0x19
  801ca6:	e8 ff fc ff ff       	call   8019aa <syscall>
  801cab:	83 c4 18             	add    $0x18,%esp
}
  801cae:	90                   	nop
  801caf:	c9                   	leave  
  801cb0:	c3                   	ret    

00801cb1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cb1:	55                   	push   %ebp
  801cb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	52                   	push   %edx
  801cc1:	50                   	push   %eax
  801cc2:	6a 1a                	push   $0x1a
  801cc4:	e8 e1 fc ff ff       	call   8019aa <syscall>
  801cc9:	83 c4 18             	add    $0x18,%esp
}
  801ccc:	90                   	nop
  801ccd:	c9                   	leave  
  801cce:	c3                   	ret    

00801ccf <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ccf:	55                   	push   %ebp
  801cd0:	89 e5                	mov    %esp,%ebp
  801cd2:	83 ec 04             	sub    $0x4,%esp
  801cd5:	8b 45 10             	mov    0x10(%ebp),%eax
  801cd8:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801cdb:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801cde:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce5:	6a 00                	push   $0x0
  801ce7:	51                   	push   %ecx
  801ce8:	52                   	push   %edx
  801ce9:	ff 75 0c             	pushl  0xc(%ebp)
  801cec:	50                   	push   %eax
  801ced:	6a 1c                	push   $0x1c
  801cef:	e8 b6 fc ff ff       	call   8019aa <syscall>
  801cf4:	83 c4 18             	add    $0x18,%esp
}
  801cf7:	c9                   	leave  
  801cf8:	c3                   	ret    

00801cf9 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801cf9:	55                   	push   %ebp
  801cfa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801cfc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cff:	8b 45 08             	mov    0x8(%ebp),%eax
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	52                   	push   %edx
  801d09:	50                   	push   %eax
  801d0a:	6a 1d                	push   $0x1d
  801d0c:	e8 99 fc ff ff       	call   8019aa <syscall>
  801d11:	83 c4 18             	add    $0x18,%esp
}
  801d14:	c9                   	leave  
  801d15:	c3                   	ret    

00801d16 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d16:	55                   	push   %ebp
  801d17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d19:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	51                   	push   %ecx
  801d27:	52                   	push   %edx
  801d28:	50                   	push   %eax
  801d29:	6a 1e                	push   $0x1e
  801d2b:	e8 7a fc ff ff       	call   8019aa <syscall>
  801d30:	83 c4 18             	add    $0x18,%esp
}
  801d33:	c9                   	leave  
  801d34:	c3                   	ret    

00801d35 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d35:	55                   	push   %ebp
  801d36:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d38:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	6a 00                	push   $0x0
  801d44:	52                   	push   %edx
  801d45:	50                   	push   %eax
  801d46:	6a 1f                	push   $0x1f
  801d48:	e8 5d fc ff ff       	call   8019aa <syscall>
  801d4d:	83 c4 18             	add    $0x18,%esp
}
  801d50:	c9                   	leave  
  801d51:	c3                   	ret    

00801d52 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801d52:	55                   	push   %ebp
  801d53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801d55:	6a 00                	push   $0x0
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 20                	push   $0x20
  801d61:	e8 44 fc ff ff       	call   8019aa <syscall>
  801d66:	83 c4 18             	add    $0x18,%esp
}
  801d69:	c9                   	leave  
  801d6a:	c3                   	ret    

00801d6b <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801d6b:	55                   	push   %ebp
  801d6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	ff 75 10             	pushl  0x10(%ebp)
  801d78:	ff 75 0c             	pushl  0xc(%ebp)
  801d7b:	50                   	push   %eax
  801d7c:	6a 21                	push   $0x21
  801d7e:	e8 27 fc ff ff       	call   8019aa <syscall>
  801d83:	83 c4 18             	add    $0x18,%esp
}
  801d86:	c9                   	leave  
  801d87:	c3                   	ret    

00801d88 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801d88:	55                   	push   %ebp
  801d89:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	50                   	push   %eax
  801d97:	6a 22                	push   $0x22
  801d99:	e8 0c fc ff ff       	call   8019aa <syscall>
  801d9e:	83 c4 18             	add    $0x18,%esp
}
  801da1:	90                   	nop
  801da2:	c9                   	leave  
  801da3:	c3                   	ret    

00801da4 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801da4:	55                   	push   %ebp
  801da5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801da7:	8b 45 08             	mov    0x8(%ebp),%eax
  801daa:	6a 00                	push   $0x0
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	6a 00                	push   $0x0
  801db2:	50                   	push   %eax
  801db3:	6a 23                	push   $0x23
  801db5:	e8 f0 fb ff ff       	call   8019aa <syscall>
  801dba:	83 c4 18             	add    $0x18,%esp
}
  801dbd:	90                   	nop
  801dbe:	c9                   	leave  
  801dbf:	c3                   	ret    

00801dc0 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801dc0:	55                   	push   %ebp
  801dc1:	89 e5                	mov    %esp,%ebp
  801dc3:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801dc6:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801dc9:	8d 50 04             	lea    0x4(%eax),%edx
  801dcc:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	52                   	push   %edx
  801dd6:	50                   	push   %eax
  801dd7:	6a 24                	push   $0x24
  801dd9:	e8 cc fb ff ff       	call   8019aa <syscall>
  801dde:	83 c4 18             	add    $0x18,%esp
	return result;
  801de1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801de4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801de7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801dea:	89 01                	mov    %eax,(%ecx)
  801dec:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801def:	8b 45 08             	mov    0x8(%ebp),%eax
  801df2:	c9                   	leave  
  801df3:	c2 04 00             	ret    $0x4

00801df6 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801df6:	55                   	push   %ebp
  801df7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	ff 75 10             	pushl  0x10(%ebp)
  801e00:	ff 75 0c             	pushl  0xc(%ebp)
  801e03:	ff 75 08             	pushl  0x8(%ebp)
  801e06:	6a 13                	push   $0x13
  801e08:	e8 9d fb ff ff       	call   8019aa <syscall>
  801e0d:	83 c4 18             	add    $0x18,%esp
	return ;
  801e10:	90                   	nop
}
  801e11:	c9                   	leave  
  801e12:	c3                   	ret    

00801e13 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e13:	55                   	push   %ebp
  801e14:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 25                	push   $0x25
  801e22:	e8 83 fb ff ff       	call   8019aa <syscall>
  801e27:	83 c4 18             	add    $0x18,%esp
}
  801e2a:	c9                   	leave  
  801e2b:	c3                   	ret    

00801e2c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e2c:	55                   	push   %ebp
  801e2d:	89 e5                	mov    %esp,%ebp
  801e2f:	83 ec 04             	sub    $0x4,%esp
  801e32:	8b 45 08             	mov    0x8(%ebp),%eax
  801e35:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e38:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	6a 00                	push   $0x0
  801e44:	50                   	push   %eax
  801e45:	6a 26                	push   $0x26
  801e47:	e8 5e fb ff ff       	call   8019aa <syscall>
  801e4c:	83 c4 18             	add    $0x18,%esp
	return ;
  801e4f:	90                   	nop
}
  801e50:	c9                   	leave  
  801e51:	c3                   	ret    

00801e52 <rsttst>:
void rsttst()
{
  801e52:	55                   	push   %ebp
  801e53:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 28                	push   $0x28
  801e61:	e8 44 fb ff ff       	call   8019aa <syscall>
  801e66:	83 c4 18             	add    $0x18,%esp
	return ;
  801e69:	90                   	nop
}
  801e6a:	c9                   	leave  
  801e6b:	c3                   	ret    

00801e6c <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801e6c:	55                   	push   %ebp
  801e6d:	89 e5                	mov    %esp,%ebp
  801e6f:	83 ec 04             	sub    $0x4,%esp
  801e72:	8b 45 14             	mov    0x14(%ebp),%eax
  801e75:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801e78:	8b 55 18             	mov    0x18(%ebp),%edx
  801e7b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e7f:	52                   	push   %edx
  801e80:	50                   	push   %eax
  801e81:	ff 75 10             	pushl  0x10(%ebp)
  801e84:	ff 75 0c             	pushl  0xc(%ebp)
  801e87:	ff 75 08             	pushl  0x8(%ebp)
  801e8a:	6a 27                	push   $0x27
  801e8c:	e8 19 fb ff ff       	call   8019aa <syscall>
  801e91:	83 c4 18             	add    $0x18,%esp
	return ;
  801e94:	90                   	nop
}
  801e95:	c9                   	leave  
  801e96:	c3                   	ret    

00801e97 <chktst>:
void chktst(uint32 n)
{
  801e97:	55                   	push   %ebp
  801e98:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	ff 75 08             	pushl  0x8(%ebp)
  801ea5:	6a 29                	push   $0x29
  801ea7:	e8 fe fa ff ff       	call   8019aa <syscall>
  801eac:	83 c4 18             	add    $0x18,%esp
	return ;
  801eaf:	90                   	nop
}
  801eb0:	c9                   	leave  
  801eb1:	c3                   	ret    

00801eb2 <inctst>:

void inctst()
{
  801eb2:	55                   	push   %ebp
  801eb3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801eb5:	6a 00                	push   $0x0
  801eb7:	6a 00                	push   $0x0
  801eb9:	6a 00                	push   $0x0
  801ebb:	6a 00                	push   $0x0
  801ebd:	6a 00                	push   $0x0
  801ebf:	6a 2a                	push   $0x2a
  801ec1:	e8 e4 fa ff ff       	call   8019aa <syscall>
  801ec6:	83 c4 18             	add    $0x18,%esp
	return ;
  801ec9:	90                   	nop
}
  801eca:	c9                   	leave  
  801ecb:	c3                   	ret    

00801ecc <gettst>:
uint32 gettst()
{
  801ecc:	55                   	push   %ebp
  801ecd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 00                	push   $0x0
  801ed7:	6a 00                	push   $0x0
  801ed9:	6a 2b                	push   $0x2b
  801edb:	e8 ca fa ff ff       	call   8019aa <syscall>
  801ee0:	83 c4 18             	add    $0x18,%esp
}
  801ee3:	c9                   	leave  
  801ee4:	c3                   	ret    

00801ee5 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ee5:	55                   	push   %ebp
  801ee6:	89 e5                	mov    %esp,%ebp
  801ee8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801eeb:	6a 00                	push   $0x0
  801eed:	6a 00                	push   $0x0
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 00                	push   $0x0
  801ef3:	6a 00                	push   $0x0
  801ef5:	6a 2c                	push   $0x2c
  801ef7:	e8 ae fa ff ff       	call   8019aa <syscall>
  801efc:	83 c4 18             	add    $0x18,%esp
  801eff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f02:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f06:	75 07                	jne    801f0f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f08:	b8 01 00 00 00       	mov    $0x1,%eax
  801f0d:	eb 05                	jmp    801f14 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f14:	c9                   	leave  
  801f15:	c3                   	ret    

00801f16 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f16:	55                   	push   %ebp
  801f17:	89 e5                	mov    %esp,%ebp
  801f19:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 00                	push   $0x0
  801f22:	6a 00                	push   $0x0
  801f24:	6a 00                	push   $0x0
  801f26:	6a 2c                	push   $0x2c
  801f28:	e8 7d fa ff ff       	call   8019aa <syscall>
  801f2d:	83 c4 18             	add    $0x18,%esp
  801f30:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f33:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f37:	75 07                	jne    801f40 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f39:	b8 01 00 00 00       	mov    $0x1,%eax
  801f3e:	eb 05                	jmp    801f45 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801f40:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f45:	c9                   	leave  
  801f46:	c3                   	ret    

00801f47 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801f47:	55                   	push   %ebp
  801f48:	89 e5                	mov    %esp,%ebp
  801f4a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	6a 2c                	push   $0x2c
  801f59:	e8 4c fa ff ff       	call   8019aa <syscall>
  801f5e:	83 c4 18             	add    $0x18,%esp
  801f61:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801f64:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801f68:	75 07                	jne    801f71 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801f6a:	b8 01 00 00 00       	mov    $0x1,%eax
  801f6f:	eb 05                	jmp    801f76 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801f71:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f76:	c9                   	leave  
  801f77:	c3                   	ret    

00801f78 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801f78:	55                   	push   %ebp
  801f79:	89 e5                	mov    %esp,%ebp
  801f7b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	6a 00                	push   $0x0
  801f88:	6a 2c                	push   $0x2c
  801f8a:	e8 1b fa ff ff       	call   8019aa <syscall>
  801f8f:	83 c4 18             	add    $0x18,%esp
  801f92:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801f95:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801f99:	75 07                	jne    801fa2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801f9b:	b8 01 00 00 00       	mov    $0x1,%eax
  801fa0:	eb 05                	jmp    801fa7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801fa2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fa7:	c9                   	leave  
  801fa8:	c3                   	ret    

00801fa9 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801fa9:	55                   	push   %ebp
  801faa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	ff 75 08             	pushl  0x8(%ebp)
  801fb7:	6a 2d                	push   $0x2d
  801fb9:	e8 ec f9 ff ff       	call   8019aa <syscall>
  801fbe:	83 c4 18             	add    $0x18,%esp
	return ;
  801fc1:	90                   	nop
}
  801fc2:	c9                   	leave  
  801fc3:	c3                   	ret    

00801fc4 <__udivdi3>:
  801fc4:	55                   	push   %ebp
  801fc5:	57                   	push   %edi
  801fc6:	56                   	push   %esi
  801fc7:	53                   	push   %ebx
  801fc8:	83 ec 1c             	sub    $0x1c,%esp
  801fcb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801fcf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801fd3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801fd7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801fdb:	89 ca                	mov    %ecx,%edx
  801fdd:	89 f8                	mov    %edi,%eax
  801fdf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801fe3:	85 f6                	test   %esi,%esi
  801fe5:	75 2d                	jne    802014 <__udivdi3+0x50>
  801fe7:	39 cf                	cmp    %ecx,%edi
  801fe9:	77 65                	ja     802050 <__udivdi3+0x8c>
  801feb:	89 fd                	mov    %edi,%ebp
  801fed:	85 ff                	test   %edi,%edi
  801fef:	75 0b                	jne    801ffc <__udivdi3+0x38>
  801ff1:	b8 01 00 00 00       	mov    $0x1,%eax
  801ff6:	31 d2                	xor    %edx,%edx
  801ff8:	f7 f7                	div    %edi
  801ffa:	89 c5                	mov    %eax,%ebp
  801ffc:	31 d2                	xor    %edx,%edx
  801ffe:	89 c8                	mov    %ecx,%eax
  802000:	f7 f5                	div    %ebp
  802002:	89 c1                	mov    %eax,%ecx
  802004:	89 d8                	mov    %ebx,%eax
  802006:	f7 f5                	div    %ebp
  802008:	89 cf                	mov    %ecx,%edi
  80200a:	89 fa                	mov    %edi,%edx
  80200c:	83 c4 1c             	add    $0x1c,%esp
  80200f:	5b                   	pop    %ebx
  802010:	5e                   	pop    %esi
  802011:	5f                   	pop    %edi
  802012:	5d                   	pop    %ebp
  802013:	c3                   	ret    
  802014:	39 ce                	cmp    %ecx,%esi
  802016:	77 28                	ja     802040 <__udivdi3+0x7c>
  802018:	0f bd fe             	bsr    %esi,%edi
  80201b:	83 f7 1f             	xor    $0x1f,%edi
  80201e:	75 40                	jne    802060 <__udivdi3+0x9c>
  802020:	39 ce                	cmp    %ecx,%esi
  802022:	72 0a                	jb     80202e <__udivdi3+0x6a>
  802024:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802028:	0f 87 9e 00 00 00    	ja     8020cc <__udivdi3+0x108>
  80202e:	b8 01 00 00 00       	mov    $0x1,%eax
  802033:	89 fa                	mov    %edi,%edx
  802035:	83 c4 1c             	add    $0x1c,%esp
  802038:	5b                   	pop    %ebx
  802039:	5e                   	pop    %esi
  80203a:	5f                   	pop    %edi
  80203b:	5d                   	pop    %ebp
  80203c:	c3                   	ret    
  80203d:	8d 76 00             	lea    0x0(%esi),%esi
  802040:	31 ff                	xor    %edi,%edi
  802042:	31 c0                	xor    %eax,%eax
  802044:	89 fa                	mov    %edi,%edx
  802046:	83 c4 1c             	add    $0x1c,%esp
  802049:	5b                   	pop    %ebx
  80204a:	5e                   	pop    %esi
  80204b:	5f                   	pop    %edi
  80204c:	5d                   	pop    %ebp
  80204d:	c3                   	ret    
  80204e:	66 90                	xchg   %ax,%ax
  802050:	89 d8                	mov    %ebx,%eax
  802052:	f7 f7                	div    %edi
  802054:	31 ff                	xor    %edi,%edi
  802056:	89 fa                	mov    %edi,%edx
  802058:	83 c4 1c             	add    $0x1c,%esp
  80205b:	5b                   	pop    %ebx
  80205c:	5e                   	pop    %esi
  80205d:	5f                   	pop    %edi
  80205e:	5d                   	pop    %ebp
  80205f:	c3                   	ret    
  802060:	bd 20 00 00 00       	mov    $0x20,%ebp
  802065:	89 eb                	mov    %ebp,%ebx
  802067:	29 fb                	sub    %edi,%ebx
  802069:	89 f9                	mov    %edi,%ecx
  80206b:	d3 e6                	shl    %cl,%esi
  80206d:	89 c5                	mov    %eax,%ebp
  80206f:	88 d9                	mov    %bl,%cl
  802071:	d3 ed                	shr    %cl,%ebp
  802073:	89 e9                	mov    %ebp,%ecx
  802075:	09 f1                	or     %esi,%ecx
  802077:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80207b:	89 f9                	mov    %edi,%ecx
  80207d:	d3 e0                	shl    %cl,%eax
  80207f:	89 c5                	mov    %eax,%ebp
  802081:	89 d6                	mov    %edx,%esi
  802083:	88 d9                	mov    %bl,%cl
  802085:	d3 ee                	shr    %cl,%esi
  802087:	89 f9                	mov    %edi,%ecx
  802089:	d3 e2                	shl    %cl,%edx
  80208b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80208f:	88 d9                	mov    %bl,%cl
  802091:	d3 e8                	shr    %cl,%eax
  802093:	09 c2                	or     %eax,%edx
  802095:	89 d0                	mov    %edx,%eax
  802097:	89 f2                	mov    %esi,%edx
  802099:	f7 74 24 0c          	divl   0xc(%esp)
  80209d:	89 d6                	mov    %edx,%esi
  80209f:	89 c3                	mov    %eax,%ebx
  8020a1:	f7 e5                	mul    %ebp
  8020a3:	39 d6                	cmp    %edx,%esi
  8020a5:	72 19                	jb     8020c0 <__udivdi3+0xfc>
  8020a7:	74 0b                	je     8020b4 <__udivdi3+0xf0>
  8020a9:	89 d8                	mov    %ebx,%eax
  8020ab:	31 ff                	xor    %edi,%edi
  8020ad:	e9 58 ff ff ff       	jmp    80200a <__udivdi3+0x46>
  8020b2:	66 90                	xchg   %ax,%ax
  8020b4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8020b8:	89 f9                	mov    %edi,%ecx
  8020ba:	d3 e2                	shl    %cl,%edx
  8020bc:	39 c2                	cmp    %eax,%edx
  8020be:	73 e9                	jae    8020a9 <__udivdi3+0xe5>
  8020c0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8020c3:	31 ff                	xor    %edi,%edi
  8020c5:	e9 40 ff ff ff       	jmp    80200a <__udivdi3+0x46>
  8020ca:	66 90                	xchg   %ax,%ax
  8020cc:	31 c0                	xor    %eax,%eax
  8020ce:	e9 37 ff ff ff       	jmp    80200a <__udivdi3+0x46>
  8020d3:	90                   	nop

008020d4 <__umoddi3>:
  8020d4:	55                   	push   %ebp
  8020d5:	57                   	push   %edi
  8020d6:	56                   	push   %esi
  8020d7:	53                   	push   %ebx
  8020d8:	83 ec 1c             	sub    $0x1c,%esp
  8020db:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8020df:	8b 74 24 34          	mov    0x34(%esp),%esi
  8020e3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020e7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8020eb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8020ef:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8020f3:	89 f3                	mov    %esi,%ebx
  8020f5:	89 fa                	mov    %edi,%edx
  8020f7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020fb:	89 34 24             	mov    %esi,(%esp)
  8020fe:	85 c0                	test   %eax,%eax
  802100:	75 1a                	jne    80211c <__umoddi3+0x48>
  802102:	39 f7                	cmp    %esi,%edi
  802104:	0f 86 a2 00 00 00    	jbe    8021ac <__umoddi3+0xd8>
  80210a:	89 c8                	mov    %ecx,%eax
  80210c:	89 f2                	mov    %esi,%edx
  80210e:	f7 f7                	div    %edi
  802110:	89 d0                	mov    %edx,%eax
  802112:	31 d2                	xor    %edx,%edx
  802114:	83 c4 1c             	add    $0x1c,%esp
  802117:	5b                   	pop    %ebx
  802118:	5e                   	pop    %esi
  802119:	5f                   	pop    %edi
  80211a:	5d                   	pop    %ebp
  80211b:	c3                   	ret    
  80211c:	39 f0                	cmp    %esi,%eax
  80211e:	0f 87 ac 00 00 00    	ja     8021d0 <__umoddi3+0xfc>
  802124:	0f bd e8             	bsr    %eax,%ebp
  802127:	83 f5 1f             	xor    $0x1f,%ebp
  80212a:	0f 84 ac 00 00 00    	je     8021dc <__umoddi3+0x108>
  802130:	bf 20 00 00 00       	mov    $0x20,%edi
  802135:	29 ef                	sub    %ebp,%edi
  802137:	89 fe                	mov    %edi,%esi
  802139:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80213d:	89 e9                	mov    %ebp,%ecx
  80213f:	d3 e0                	shl    %cl,%eax
  802141:	89 d7                	mov    %edx,%edi
  802143:	89 f1                	mov    %esi,%ecx
  802145:	d3 ef                	shr    %cl,%edi
  802147:	09 c7                	or     %eax,%edi
  802149:	89 e9                	mov    %ebp,%ecx
  80214b:	d3 e2                	shl    %cl,%edx
  80214d:	89 14 24             	mov    %edx,(%esp)
  802150:	89 d8                	mov    %ebx,%eax
  802152:	d3 e0                	shl    %cl,%eax
  802154:	89 c2                	mov    %eax,%edx
  802156:	8b 44 24 08          	mov    0x8(%esp),%eax
  80215a:	d3 e0                	shl    %cl,%eax
  80215c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802160:	8b 44 24 08          	mov    0x8(%esp),%eax
  802164:	89 f1                	mov    %esi,%ecx
  802166:	d3 e8                	shr    %cl,%eax
  802168:	09 d0                	or     %edx,%eax
  80216a:	d3 eb                	shr    %cl,%ebx
  80216c:	89 da                	mov    %ebx,%edx
  80216e:	f7 f7                	div    %edi
  802170:	89 d3                	mov    %edx,%ebx
  802172:	f7 24 24             	mull   (%esp)
  802175:	89 c6                	mov    %eax,%esi
  802177:	89 d1                	mov    %edx,%ecx
  802179:	39 d3                	cmp    %edx,%ebx
  80217b:	0f 82 87 00 00 00    	jb     802208 <__umoddi3+0x134>
  802181:	0f 84 91 00 00 00    	je     802218 <__umoddi3+0x144>
  802187:	8b 54 24 04          	mov    0x4(%esp),%edx
  80218b:	29 f2                	sub    %esi,%edx
  80218d:	19 cb                	sbb    %ecx,%ebx
  80218f:	89 d8                	mov    %ebx,%eax
  802191:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802195:	d3 e0                	shl    %cl,%eax
  802197:	89 e9                	mov    %ebp,%ecx
  802199:	d3 ea                	shr    %cl,%edx
  80219b:	09 d0                	or     %edx,%eax
  80219d:	89 e9                	mov    %ebp,%ecx
  80219f:	d3 eb                	shr    %cl,%ebx
  8021a1:	89 da                	mov    %ebx,%edx
  8021a3:	83 c4 1c             	add    $0x1c,%esp
  8021a6:	5b                   	pop    %ebx
  8021a7:	5e                   	pop    %esi
  8021a8:	5f                   	pop    %edi
  8021a9:	5d                   	pop    %ebp
  8021aa:	c3                   	ret    
  8021ab:	90                   	nop
  8021ac:	89 fd                	mov    %edi,%ebp
  8021ae:	85 ff                	test   %edi,%edi
  8021b0:	75 0b                	jne    8021bd <__umoddi3+0xe9>
  8021b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8021b7:	31 d2                	xor    %edx,%edx
  8021b9:	f7 f7                	div    %edi
  8021bb:	89 c5                	mov    %eax,%ebp
  8021bd:	89 f0                	mov    %esi,%eax
  8021bf:	31 d2                	xor    %edx,%edx
  8021c1:	f7 f5                	div    %ebp
  8021c3:	89 c8                	mov    %ecx,%eax
  8021c5:	f7 f5                	div    %ebp
  8021c7:	89 d0                	mov    %edx,%eax
  8021c9:	e9 44 ff ff ff       	jmp    802112 <__umoddi3+0x3e>
  8021ce:	66 90                	xchg   %ax,%ax
  8021d0:	89 c8                	mov    %ecx,%eax
  8021d2:	89 f2                	mov    %esi,%edx
  8021d4:	83 c4 1c             	add    $0x1c,%esp
  8021d7:	5b                   	pop    %ebx
  8021d8:	5e                   	pop    %esi
  8021d9:	5f                   	pop    %edi
  8021da:	5d                   	pop    %ebp
  8021db:	c3                   	ret    
  8021dc:	3b 04 24             	cmp    (%esp),%eax
  8021df:	72 06                	jb     8021e7 <__umoddi3+0x113>
  8021e1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8021e5:	77 0f                	ja     8021f6 <__umoddi3+0x122>
  8021e7:	89 f2                	mov    %esi,%edx
  8021e9:	29 f9                	sub    %edi,%ecx
  8021eb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8021ef:	89 14 24             	mov    %edx,(%esp)
  8021f2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021f6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8021fa:	8b 14 24             	mov    (%esp),%edx
  8021fd:	83 c4 1c             	add    $0x1c,%esp
  802200:	5b                   	pop    %ebx
  802201:	5e                   	pop    %esi
  802202:	5f                   	pop    %edi
  802203:	5d                   	pop    %ebp
  802204:	c3                   	ret    
  802205:	8d 76 00             	lea    0x0(%esi),%esi
  802208:	2b 04 24             	sub    (%esp),%eax
  80220b:	19 fa                	sbb    %edi,%edx
  80220d:	89 d1                	mov    %edx,%ecx
  80220f:	89 c6                	mov    %eax,%esi
  802211:	e9 71 ff ff ff       	jmp    802187 <__umoddi3+0xb3>
  802216:	66 90                	xchg   %ax,%ax
  802218:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80221c:	72 ea                	jb     802208 <__umoddi3+0x134>
  80221e:	89 d9                	mov    %ebx,%ecx
  802220:	e9 62 ff ff ff       	jmp    802187 <__umoddi3+0xb3>
