
obj/user/tst_freeing_stack:     file format elf32-i386


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
  800031:	e8 77 02 00 00       	call   8002ad <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

#include <inc/lib.h>

int RecursiveFn(int numOfRec);
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 38             	sub    $0x38,%esp
	int res, numOfRec, expectedResult, r, i, j, freeFrames, usedDiskPages ;
	uint32 vaOf1stStackPage = USTACKTOP - PAGE_SIZE;
  80003e:	c7 45 dc 00 d0 bf ee 	movl   $0xeebfd000,-0x24(%ebp)

	int initNumOfEmptyWSEntries, curNumOfEmptyWSEntries ;

	/*Different number of recursive calls (each call takes 1 PAGE)*/
	for (r = 1; r <= 10; ++r)
  800045:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  80004c:	e9 c5 01 00 00       	jmp    800216 <_main+0x1de>
	{
		numOfRec = r;
  800051:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800054:	89 45 d8             	mov    %eax,-0x28(%ebp)

		initNumOfEmptyWSEntries = 0;
  800057:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (j = 0; j < myEnv->page_WS_max_size; ++j)
  80005e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800065:	eb 26                	jmp    80008d <_main+0x55>
		{
			if (myEnv->__uptr_pws[j].empty==1)
  800067:	a1 04 30 80 00       	mov    0x803004,%eax
  80006c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800072:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800075:	89 d0                	mov    %edx,%eax
  800077:	01 c0                	add    %eax,%eax
  800079:	01 d0                	add    %edx,%eax
  80007b:	c1 e0 02             	shl    $0x2,%eax
  80007e:	01 c8                	add    %ecx,%eax
  800080:	8a 40 04             	mov    0x4(%eax),%al
  800083:	3c 01                	cmp    $0x1,%al
  800085:	75 03                	jne    80008a <_main+0x52>
				initNumOfEmptyWSEntries++;
  800087:	ff 45 e4             	incl   -0x1c(%ebp)
	for (r = 1; r <= 10; ++r)
	{
		numOfRec = r;

		initNumOfEmptyWSEntries = 0;
		for (j = 0; j < myEnv->page_WS_max_size; ++j)
  80008a:	ff 45 e8             	incl   -0x18(%ebp)
  80008d:	a1 04 30 80 00       	mov    0x803004,%eax
  800092:	8b 50 74             	mov    0x74(%eax),%edx
  800095:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800098:	39 c2                	cmp    %eax,%edx
  80009a:	77 cb                	ja     800067 <_main+0x2f>
		{
			if (myEnv->__uptr_pws[j].empty==1)
				initNumOfEmptyWSEntries++;
		}

		freeFrames = sys_calculate_free_frames() ;
  80009c:	e8 b8 14 00 00       	call   801559 <sys_calculate_free_frames>
  8000a1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000a4:	e8 33 15 00 00       	call   8015dc <sys_pf_calculate_allocated_pages>
  8000a9:	89 45 d0             	mov    %eax,-0x30(%ebp)

		res = RecursiveFn(numOfRec);
  8000ac:	83 ec 0c             	sub    $0xc,%esp
  8000af:	ff 75 d8             	pushl  -0x28(%ebp)
  8000b2:	e8 7c 01 00 00       	call   800233 <RecursiveFn>
  8000b7:	83 c4 10             	add    $0x10,%esp
  8000ba:	89 45 cc             	mov    %eax,-0x34(%ebp)
		env_sleep(1) ;
  8000bd:	83 ec 0c             	sub    $0xc,%esp
  8000c0:	6a 01                	push   $0x1
  8000c2:	e8 40 19 00 00       	call   801a07 <env_sleep>
  8000c7:	83 c4 10             	add    $0x10,%esp
		expectedResult = 0;
  8000ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for (i = 1; i <= numOfRec; ++i) {
  8000d1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
  8000d8:	eb 0c                	jmp    8000e6 <_main+0xae>
			expectedResult += i * 1024;
  8000da:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000dd:	c1 e0 0a             	shl    $0xa,%eax
  8000e0:	01 45 f4             	add    %eax,-0xc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;

		res = RecursiveFn(numOfRec);
		env_sleep(1) ;
		expectedResult = 0;
		for (i = 1; i <= numOfRec; ++i) {
  8000e3:	ff 45 ec             	incl   -0x14(%ebp)
  8000e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e9:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8000ec:	7e ec                	jle    8000da <_main+0xa2>
			expectedResult += i * 1024;
		}
		//check correct answer & page file
		if (res != expectedResult) panic("Wrong result of the recursive function!\n");
  8000ee:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000f1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f4:	74 14                	je     80010a <_main+0xd2>
  8000f6:	83 ec 04             	sub    $0x4,%esp
  8000f9:	68 20 1d 80 00       	push   $0x801d20
  8000fe:	6a 28                	push   $0x28
  800100:	68 49 1d 80 00       	push   $0x801d49
  800105:	e8 a5 02 00 00       	call   8003af <_panic>
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 0) panic("Wrong freeing the stack pages from the page file!\n");
  80010a:	e8 cd 14 00 00       	call   8015dc <sys_pf_calculate_allocated_pages>
  80010f:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  800112:	74 14                	je     800128 <_main+0xf0>
  800114:	83 ec 04             	sub    $0x4,%esp
  800117:	68 64 1d 80 00       	push   $0x801d64
  80011c:	6a 29                	push   $0x29
  80011e:	68 49 1d 80 00       	push   $0x801d49
  800123:	e8 87 02 00 00       	call   8003af <_panic>

		//check WS
		for (i = 1; i <= numOfRec; ++i)
  800128:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
  80012f:	eb 6b                	jmp    80019c <_main+0x164>
		{
			for (j = 0; j < myEnv->page_WS_max_size; ++j)
  800131:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800138:	eb 50                	jmp    80018a <_main+0x152>
			{
				if (ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address, PAGE_SIZE) == vaOf1stStackPage - i*PAGE_SIZE)
  80013a:	a1 04 30 80 00       	mov    0x803004,%eax
  80013f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800145:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800148:	89 d0                	mov    %edx,%eax
  80014a:	01 c0                	add    %eax,%eax
  80014c:	01 d0                	add    %edx,%eax
  80014e:	c1 e0 02             	shl    $0x2,%eax
  800151:	01 c8                	add    %ecx,%eax
  800153:	8b 00                	mov    (%eax),%eax
  800155:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800158:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80015b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800160:	89 c2                	mov    %eax,%edx
  800162:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800165:	c1 e0 0c             	shl    $0xc,%eax
  800168:	89 c1                	mov    %eax,%ecx
  80016a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80016d:	29 c8                	sub    %ecx,%eax
  80016f:	39 c2                	cmp    %eax,%edx
  800171:	75 14                	jne    800187 <_main+0x14f>
					panic("Wrong freeing the stack pages from the working set!\n");
  800173:	83 ec 04             	sub    $0x4,%esp
  800176:	68 98 1d 80 00       	push   $0x801d98
  80017b:	6a 31                	push   $0x31
  80017d:	68 49 1d 80 00       	push   $0x801d49
  800182:	e8 28 02 00 00       	call   8003af <_panic>
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 0) panic("Wrong freeing the stack pages from the page file!\n");

		//check WS
		for (i = 1; i <= numOfRec; ++i)
		{
			for (j = 0; j < myEnv->page_WS_max_size; ++j)
  800187:	ff 45 e8             	incl   -0x18(%ebp)
  80018a:	a1 04 30 80 00       	mov    0x803004,%eax
  80018f:	8b 50 74             	mov    0x74(%eax),%edx
  800192:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800195:	39 c2                	cmp    %eax,%edx
  800197:	77 a1                	ja     80013a <_main+0x102>
		//check correct answer & page file
		if (res != expectedResult) panic("Wrong result of the recursive function!\n");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 0) panic("Wrong freeing the stack pages from the page file!\n");

		//check WS
		for (i = 1; i <= numOfRec; ++i)
  800199:	ff 45 ec             	incl   -0x14(%ebp)
  80019c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80019f:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8001a2:	7e 8d                	jle    800131 <_main+0xf9>
					panic("Wrong freeing the stack pages from the working set!\n");
			}
		}

		//check free frames
		curNumOfEmptyWSEntries = 0;
  8001a4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
		for (j = 0; j < myEnv->page_WS_max_size; ++j)
  8001ab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8001b2:	eb 26                	jmp    8001da <_main+0x1a2>
		{
			if (myEnv->__uptr_pws[j].empty==1)
  8001b4:	a1 04 30 80 00       	mov    0x803004,%eax
  8001b9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8001bf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8001c2:	89 d0                	mov    %edx,%eax
  8001c4:	01 c0                	add    %eax,%eax
  8001c6:	01 d0                	add    %edx,%eax
  8001c8:	c1 e0 02             	shl    $0x2,%eax
  8001cb:	01 c8                	add    %ecx,%eax
  8001cd:	8a 40 04             	mov    0x4(%eax),%al
  8001d0:	3c 01                	cmp    $0x1,%al
  8001d2:	75 03                	jne    8001d7 <_main+0x19f>
				curNumOfEmptyWSEntries++;
  8001d4:	ff 45 e0             	incl   -0x20(%ebp)
			}
		}

		//check free frames
		curNumOfEmptyWSEntries = 0;
		for (j = 0; j < myEnv->page_WS_max_size; ++j)
  8001d7:	ff 45 e8             	incl   -0x18(%ebp)
  8001da:	a1 04 30 80 00       	mov    0x803004,%eax
  8001df:	8b 50 74             	mov    0x74(%eax),%edx
  8001e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001e5:	39 c2                	cmp    %eax,%edx
  8001e7:	77 cb                	ja     8001b4 <_main+0x17c>
			if (myEnv->__uptr_pws[j].empty==1)
				curNumOfEmptyWSEntries++;
		}

		//cprintf("diff in RAM = %d\n", sys_calculate_free_frames() - freeFrames);
		if ((sys_calculate_free_frames() - freeFrames) != curNumOfEmptyWSEntries - initNumOfEmptyWSEntries)
  8001e9:	e8 6b 13 00 00       	call   801559 <sys_calculate_free_frames>
  8001ee:	89 c2                	mov    %eax,%edx
  8001f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001f3:	29 c2                	sub    %eax,%edx
  8001f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001f8:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8001fb:	39 c2                	cmp    %eax,%edx
  8001fd:	74 14                	je     800213 <_main+0x1db>
			panic("Wrong freeing the stack pages from memory!\n");
  8001ff:	83 ec 04             	sub    $0x4,%esp
  800202:	68 d0 1d 80 00       	push   $0x801dd0
  800207:	6a 3f                	push   $0x3f
  800209:	68 49 1d 80 00       	push   $0x801d49
  80020e:	e8 9c 01 00 00       	call   8003af <_panic>
	uint32 vaOf1stStackPage = USTACKTOP - PAGE_SIZE;

	int initNumOfEmptyWSEntries, curNumOfEmptyWSEntries ;

	/*Different number of recursive calls (each call takes 1 PAGE)*/
	for (r = 1; r <= 10; ++r)
  800213:	ff 45 f0             	incl   -0x10(%ebp)
  800216:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  80021a:	0f 8e 31 fe ff ff    	jle    800051 <_main+0x19>
		//cprintf("diff in RAM = %d\n", sys_calculate_free_frames() - freeFrames);
		if ((sys_calculate_free_frames() - freeFrames) != curNumOfEmptyWSEntries - initNumOfEmptyWSEntries)
			panic("Wrong freeing the stack pages from memory!\n");
	}

	cprintf("Congratulations!! test freeing the stack pages is completed successfully.\n");
  800220:	83 ec 0c             	sub    $0xc,%esp
  800223:	68 fc 1d 80 00       	push   $0x801dfc
  800228:	e8 36 04 00 00       	call   800663 <cprintf>
  80022d:	83 c4 10             	add    $0x10,%esp

	return;
  800230:	90                   	nop
}
  800231:	c9                   	leave  
  800232:	c3                   	ret    

00800233 <RecursiveFn>:

int RecursiveFn(int numOfRec)
{
  800233:	55                   	push   %ebp
  800234:	89 e5                	mov    %esp,%ebp
  800236:	81 ec 18 10 00 00    	sub    $0x1018,%esp
	if (numOfRec == 0)
  80023c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800240:	75 07                	jne    800249 <RecursiveFn+0x16>
		return 0;
  800242:	b8 00 00 00 00       	mov    $0x0,%eax
  800247:	eb 62                	jmp    8002ab <RecursiveFn+0x78>

	int A[1024] ;
	int i, sum = 0 ;
  800249:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	for (i = 0; i < 1024; ++i) {
  800250:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800257:	eb 10                	jmp    800269 <RecursiveFn+0x36>
		A[i] = numOfRec;
  800259:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80025c:	8b 55 08             	mov    0x8(%ebp),%edx
  80025f:	89 94 85 f0 ef ff ff 	mov    %edx,-0x1010(%ebp,%eax,4)
	if (numOfRec == 0)
		return 0;

	int A[1024] ;
	int i, sum = 0 ;
	for (i = 0; i < 1024; ++i) {
  800266:	ff 45 f4             	incl   -0xc(%ebp)
  800269:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
  800270:	7e e7                	jle    800259 <RecursiveFn+0x26>
		A[i] = numOfRec;
	}
	for (i = 0; i < 1024; ++i) {
  800272:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800279:	eb 10                	jmp    80028b <RecursiveFn+0x58>
		sum += A[i] ;
  80027b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80027e:	8b 84 85 f0 ef ff ff 	mov    -0x1010(%ebp,%eax,4),%eax
  800285:	01 45 f0             	add    %eax,-0x10(%ebp)
	int A[1024] ;
	int i, sum = 0 ;
	for (i = 0; i < 1024; ++i) {
		A[i] = numOfRec;
	}
	for (i = 0; i < 1024; ++i) {
  800288:	ff 45 f4             	incl   -0xc(%ebp)
  80028b:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
  800292:	7e e7                	jle    80027b <RecursiveFn+0x48>
		sum += A[i] ;
	}
	return sum + RecursiveFn(numOfRec-1);
  800294:	8b 45 08             	mov    0x8(%ebp),%eax
  800297:	48                   	dec    %eax
  800298:	83 ec 0c             	sub    $0xc,%esp
  80029b:	50                   	push   %eax
  80029c:	e8 92 ff ff ff       	call   800233 <RecursiveFn>
  8002a1:	83 c4 10             	add    $0x10,%esp
  8002a4:	89 c2                	mov    %eax,%edx
  8002a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002a9:	01 d0                	add    %edx,%eax
}
  8002ab:	c9                   	leave  
  8002ac:	c3                   	ret    

008002ad <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8002ad:	55                   	push   %ebp
  8002ae:	89 e5                	mov    %esp,%ebp
  8002b0:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8002b3:	e8 d6 11 00 00       	call   80148e <sys_getenvindex>
  8002b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8002bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002be:	89 d0                	mov    %edx,%eax
  8002c0:	01 c0                	add    %eax,%eax
  8002c2:	01 d0                	add    %edx,%eax
  8002c4:	c1 e0 02             	shl    $0x2,%eax
  8002c7:	01 d0                	add    %edx,%eax
  8002c9:	c1 e0 06             	shl    $0x6,%eax
  8002cc:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002d1:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002d6:	a1 04 30 80 00       	mov    0x803004,%eax
  8002db:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8002e1:	84 c0                	test   %al,%al
  8002e3:	74 0f                	je     8002f4 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8002e5:	a1 04 30 80 00       	mov    0x803004,%eax
  8002ea:	05 f4 02 00 00       	add    $0x2f4,%eax
  8002ef:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002f4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8002f8:	7e 0a                	jle    800304 <libmain+0x57>
		binaryname = argv[0];
  8002fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002fd:	8b 00                	mov    (%eax),%eax
  8002ff:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800304:	83 ec 08             	sub    $0x8,%esp
  800307:	ff 75 0c             	pushl  0xc(%ebp)
  80030a:	ff 75 08             	pushl  0x8(%ebp)
  80030d:	e8 26 fd ff ff       	call   800038 <_main>
  800312:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800315:	e8 0f 13 00 00       	call   801629 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80031a:	83 ec 0c             	sub    $0xc,%esp
  80031d:	68 60 1e 80 00       	push   $0x801e60
  800322:	e8 3c 03 00 00       	call   800663 <cprintf>
  800327:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80032a:	a1 04 30 80 00       	mov    0x803004,%eax
  80032f:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800335:	a1 04 30 80 00       	mov    0x803004,%eax
  80033a:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800340:	83 ec 04             	sub    $0x4,%esp
  800343:	52                   	push   %edx
  800344:	50                   	push   %eax
  800345:	68 88 1e 80 00       	push   $0x801e88
  80034a:	e8 14 03 00 00       	call   800663 <cprintf>
  80034f:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800352:	a1 04 30 80 00       	mov    0x803004,%eax
  800357:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80035d:	83 ec 08             	sub    $0x8,%esp
  800360:	50                   	push   %eax
  800361:	68 ad 1e 80 00       	push   $0x801ead
  800366:	e8 f8 02 00 00       	call   800663 <cprintf>
  80036b:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80036e:	83 ec 0c             	sub    $0xc,%esp
  800371:	68 60 1e 80 00       	push   $0x801e60
  800376:	e8 e8 02 00 00       	call   800663 <cprintf>
  80037b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80037e:	e8 c0 12 00 00       	call   801643 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800383:	e8 19 00 00 00       	call   8003a1 <exit>
}
  800388:	90                   	nop
  800389:	c9                   	leave  
  80038a:	c3                   	ret    

0080038b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80038b:	55                   	push   %ebp
  80038c:	89 e5                	mov    %esp,%ebp
  80038e:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800391:	83 ec 0c             	sub    $0xc,%esp
  800394:	6a 00                	push   $0x0
  800396:	e8 bf 10 00 00       	call   80145a <sys_env_destroy>
  80039b:	83 c4 10             	add    $0x10,%esp
}
  80039e:	90                   	nop
  80039f:	c9                   	leave  
  8003a0:	c3                   	ret    

008003a1 <exit>:

void
exit(void)
{
  8003a1:	55                   	push   %ebp
  8003a2:	89 e5                	mov    %esp,%ebp
  8003a4:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8003a7:	e8 14 11 00 00       	call   8014c0 <sys_env_exit>
}
  8003ac:	90                   	nop
  8003ad:	c9                   	leave  
  8003ae:	c3                   	ret    

008003af <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003af:	55                   	push   %ebp
  8003b0:	89 e5                	mov    %esp,%ebp
  8003b2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8003b5:	8d 45 10             	lea    0x10(%ebp),%eax
  8003b8:	83 c0 04             	add    $0x4,%eax
  8003bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003be:	a1 14 30 80 00       	mov    0x803014,%eax
  8003c3:	85 c0                	test   %eax,%eax
  8003c5:	74 16                	je     8003dd <_panic+0x2e>
		cprintf("%s: ", argv0);
  8003c7:	a1 14 30 80 00       	mov    0x803014,%eax
  8003cc:	83 ec 08             	sub    $0x8,%esp
  8003cf:	50                   	push   %eax
  8003d0:	68 c4 1e 80 00       	push   $0x801ec4
  8003d5:	e8 89 02 00 00       	call   800663 <cprintf>
  8003da:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8003dd:	a1 00 30 80 00       	mov    0x803000,%eax
  8003e2:	ff 75 0c             	pushl  0xc(%ebp)
  8003e5:	ff 75 08             	pushl  0x8(%ebp)
  8003e8:	50                   	push   %eax
  8003e9:	68 c9 1e 80 00       	push   $0x801ec9
  8003ee:	e8 70 02 00 00       	call   800663 <cprintf>
  8003f3:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8003f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8003f9:	83 ec 08             	sub    $0x8,%esp
  8003fc:	ff 75 f4             	pushl  -0xc(%ebp)
  8003ff:	50                   	push   %eax
  800400:	e8 f3 01 00 00       	call   8005f8 <vcprintf>
  800405:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800408:	83 ec 08             	sub    $0x8,%esp
  80040b:	6a 00                	push   $0x0
  80040d:	68 e5 1e 80 00       	push   $0x801ee5
  800412:	e8 e1 01 00 00       	call   8005f8 <vcprintf>
  800417:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80041a:	e8 82 ff ff ff       	call   8003a1 <exit>

	// should not return here
	while (1) ;
  80041f:	eb fe                	jmp    80041f <_panic+0x70>

00800421 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800421:	55                   	push   %ebp
  800422:	89 e5                	mov    %esp,%ebp
  800424:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800427:	a1 04 30 80 00       	mov    0x803004,%eax
  80042c:	8b 50 74             	mov    0x74(%eax),%edx
  80042f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800432:	39 c2                	cmp    %eax,%edx
  800434:	74 14                	je     80044a <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800436:	83 ec 04             	sub    $0x4,%esp
  800439:	68 e8 1e 80 00       	push   $0x801ee8
  80043e:	6a 26                	push   $0x26
  800440:	68 34 1f 80 00       	push   $0x801f34
  800445:	e8 65 ff ff ff       	call   8003af <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80044a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800451:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800458:	e9 c2 00 00 00       	jmp    80051f <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80045d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800460:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800467:	8b 45 08             	mov    0x8(%ebp),%eax
  80046a:	01 d0                	add    %edx,%eax
  80046c:	8b 00                	mov    (%eax),%eax
  80046e:	85 c0                	test   %eax,%eax
  800470:	75 08                	jne    80047a <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800472:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800475:	e9 a2 00 00 00       	jmp    80051c <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80047a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800481:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800488:	eb 69                	jmp    8004f3 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80048a:	a1 04 30 80 00       	mov    0x803004,%eax
  80048f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800495:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800498:	89 d0                	mov    %edx,%eax
  80049a:	01 c0                	add    %eax,%eax
  80049c:	01 d0                	add    %edx,%eax
  80049e:	c1 e0 02             	shl    $0x2,%eax
  8004a1:	01 c8                	add    %ecx,%eax
  8004a3:	8a 40 04             	mov    0x4(%eax),%al
  8004a6:	84 c0                	test   %al,%al
  8004a8:	75 46                	jne    8004f0 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004aa:	a1 04 30 80 00       	mov    0x803004,%eax
  8004af:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004b5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004b8:	89 d0                	mov    %edx,%eax
  8004ba:	01 c0                	add    %eax,%eax
  8004bc:	01 d0                	add    %edx,%eax
  8004be:	c1 e0 02             	shl    $0x2,%eax
  8004c1:	01 c8                	add    %ecx,%eax
  8004c3:	8b 00                	mov    (%eax),%eax
  8004c5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004c8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004d0:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8004d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004d5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004df:	01 c8                	add    %ecx,%eax
  8004e1:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004e3:	39 c2                	cmp    %eax,%edx
  8004e5:	75 09                	jne    8004f0 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8004e7:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8004ee:	eb 12                	jmp    800502 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004f0:	ff 45 e8             	incl   -0x18(%ebp)
  8004f3:	a1 04 30 80 00       	mov    0x803004,%eax
  8004f8:	8b 50 74             	mov    0x74(%eax),%edx
  8004fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8004fe:	39 c2                	cmp    %eax,%edx
  800500:	77 88                	ja     80048a <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800502:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800506:	75 14                	jne    80051c <CheckWSWithoutLastIndex+0xfb>
			panic(
  800508:	83 ec 04             	sub    $0x4,%esp
  80050b:	68 40 1f 80 00       	push   $0x801f40
  800510:	6a 3a                	push   $0x3a
  800512:	68 34 1f 80 00       	push   $0x801f34
  800517:	e8 93 fe ff ff       	call   8003af <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80051c:	ff 45 f0             	incl   -0x10(%ebp)
  80051f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800522:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800525:	0f 8c 32 ff ff ff    	jl     80045d <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80052b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800532:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800539:	eb 26                	jmp    800561 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80053b:	a1 04 30 80 00       	mov    0x803004,%eax
  800540:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800546:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800549:	89 d0                	mov    %edx,%eax
  80054b:	01 c0                	add    %eax,%eax
  80054d:	01 d0                	add    %edx,%eax
  80054f:	c1 e0 02             	shl    $0x2,%eax
  800552:	01 c8                	add    %ecx,%eax
  800554:	8a 40 04             	mov    0x4(%eax),%al
  800557:	3c 01                	cmp    $0x1,%al
  800559:	75 03                	jne    80055e <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80055b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80055e:	ff 45 e0             	incl   -0x20(%ebp)
  800561:	a1 04 30 80 00       	mov    0x803004,%eax
  800566:	8b 50 74             	mov    0x74(%eax),%edx
  800569:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80056c:	39 c2                	cmp    %eax,%edx
  80056e:	77 cb                	ja     80053b <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800570:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800573:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800576:	74 14                	je     80058c <CheckWSWithoutLastIndex+0x16b>
		panic(
  800578:	83 ec 04             	sub    $0x4,%esp
  80057b:	68 94 1f 80 00       	push   $0x801f94
  800580:	6a 44                	push   $0x44
  800582:	68 34 1f 80 00       	push   $0x801f34
  800587:	e8 23 fe ff ff       	call   8003af <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80058c:	90                   	nop
  80058d:	c9                   	leave  
  80058e:	c3                   	ret    

0080058f <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80058f:	55                   	push   %ebp
  800590:	89 e5                	mov    %esp,%ebp
  800592:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800595:	8b 45 0c             	mov    0xc(%ebp),%eax
  800598:	8b 00                	mov    (%eax),%eax
  80059a:	8d 48 01             	lea    0x1(%eax),%ecx
  80059d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005a0:	89 0a                	mov    %ecx,(%edx)
  8005a2:	8b 55 08             	mov    0x8(%ebp),%edx
  8005a5:	88 d1                	mov    %dl,%cl
  8005a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005aa:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005b1:	8b 00                	mov    (%eax),%eax
  8005b3:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005b8:	75 2c                	jne    8005e6 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005ba:	a0 08 30 80 00       	mov    0x803008,%al
  8005bf:	0f b6 c0             	movzbl %al,%eax
  8005c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005c5:	8b 12                	mov    (%edx),%edx
  8005c7:	89 d1                	mov    %edx,%ecx
  8005c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005cc:	83 c2 08             	add    $0x8,%edx
  8005cf:	83 ec 04             	sub    $0x4,%esp
  8005d2:	50                   	push   %eax
  8005d3:	51                   	push   %ecx
  8005d4:	52                   	push   %edx
  8005d5:	e8 3e 0e 00 00       	call   801418 <sys_cputs>
  8005da:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8005e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e9:	8b 40 04             	mov    0x4(%eax),%eax
  8005ec:	8d 50 01             	lea    0x1(%eax),%edx
  8005ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005f2:	89 50 04             	mov    %edx,0x4(%eax)
}
  8005f5:	90                   	nop
  8005f6:	c9                   	leave  
  8005f7:	c3                   	ret    

008005f8 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8005f8:	55                   	push   %ebp
  8005f9:	89 e5                	mov    %esp,%ebp
  8005fb:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800601:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800608:	00 00 00 
	b.cnt = 0;
  80060b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800612:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800615:	ff 75 0c             	pushl  0xc(%ebp)
  800618:	ff 75 08             	pushl  0x8(%ebp)
  80061b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800621:	50                   	push   %eax
  800622:	68 8f 05 80 00       	push   $0x80058f
  800627:	e8 11 02 00 00       	call   80083d <vprintfmt>
  80062c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80062f:	a0 08 30 80 00       	mov    0x803008,%al
  800634:	0f b6 c0             	movzbl %al,%eax
  800637:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80063d:	83 ec 04             	sub    $0x4,%esp
  800640:	50                   	push   %eax
  800641:	52                   	push   %edx
  800642:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800648:	83 c0 08             	add    $0x8,%eax
  80064b:	50                   	push   %eax
  80064c:	e8 c7 0d 00 00       	call   801418 <sys_cputs>
  800651:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800654:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  80065b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800661:	c9                   	leave  
  800662:	c3                   	ret    

00800663 <cprintf>:

int cprintf(const char *fmt, ...) {
  800663:	55                   	push   %ebp
  800664:	89 e5                	mov    %esp,%ebp
  800666:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800669:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800670:	8d 45 0c             	lea    0xc(%ebp),%eax
  800673:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800676:	8b 45 08             	mov    0x8(%ebp),%eax
  800679:	83 ec 08             	sub    $0x8,%esp
  80067c:	ff 75 f4             	pushl  -0xc(%ebp)
  80067f:	50                   	push   %eax
  800680:	e8 73 ff ff ff       	call   8005f8 <vcprintf>
  800685:	83 c4 10             	add    $0x10,%esp
  800688:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80068b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80068e:	c9                   	leave  
  80068f:	c3                   	ret    

00800690 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800690:	55                   	push   %ebp
  800691:	89 e5                	mov    %esp,%ebp
  800693:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800696:	e8 8e 0f 00 00       	call   801629 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80069b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80069e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a4:	83 ec 08             	sub    $0x8,%esp
  8006a7:	ff 75 f4             	pushl  -0xc(%ebp)
  8006aa:	50                   	push   %eax
  8006ab:	e8 48 ff ff ff       	call   8005f8 <vcprintf>
  8006b0:	83 c4 10             	add    $0x10,%esp
  8006b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006b6:	e8 88 0f 00 00       	call   801643 <sys_enable_interrupt>
	return cnt;
  8006bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006be:	c9                   	leave  
  8006bf:	c3                   	ret    

008006c0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006c0:	55                   	push   %ebp
  8006c1:	89 e5                	mov    %esp,%ebp
  8006c3:	53                   	push   %ebx
  8006c4:	83 ec 14             	sub    $0x14,%esp
  8006c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8006ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8006d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006d3:	8b 45 18             	mov    0x18(%ebp),%eax
  8006d6:	ba 00 00 00 00       	mov    $0x0,%edx
  8006db:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006de:	77 55                	ja     800735 <printnum+0x75>
  8006e0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006e3:	72 05                	jb     8006ea <printnum+0x2a>
  8006e5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006e8:	77 4b                	ja     800735 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006ea:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006ed:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006f0:	8b 45 18             	mov    0x18(%ebp),%eax
  8006f3:	ba 00 00 00 00       	mov    $0x0,%edx
  8006f8:	52                   	push   %edx
  8006f9:	50                   	push   %eax
  8006fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8006fd:	ff 75 f0             	pushl  -0x10(%ebp)
  800700:	e8 b7 13 00 00       	call   801abc <__udivdi3>
  800705:	83 c4 10             	add    $0x10,%esp
  800708:	83 ec 04             	sub    $0x4,%esp
  80070b:	ff 75 20             	pushl  0x20(%ebp)
  80070e:	53                   	push   %ebx
  80070f:	ff 75 18             	pushl  0x18(%ebp)
  800712:	52                   	push   %edx
  800713:	50                   	push   %eax
  800714:	ff 75 0c             	pushl  0xc(%ebp)
  800717:	ff 75 08             	pushl  0x8(%ebp)
  80071a:	e8 a1 ff ff ff       	call   8006c0 <printnum>
  80071f:	83 c4 20             	add    $0x20,%esp
  800722:	eb 1a                	jmp    80073e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800724:	83 ec 08             	sub    $0x8,%esp
  800727:	ff 75 0c             	pushl  0xc(%ebp)
  80072a:	ff 75 20             	pushl  0x20(%ebp)
  80072d:	8b 45 08             	mov    0x8(%ebp),%eax
  800730:	ff d0                	call   *%eax
  800732:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800735:	ff 4d 1c             	decl   0x1c(%ebp)
  800738:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80073c:	7f e6                	jg     800724 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80073e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800741:	bb 00 00 00 00       	mov    $0x0,%ebx
  800746:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800749:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80074c:	53                   	push   %ebx
  80074d:	51                   	push   %ecx
  80074e:	52                   	push   %edx
  80074f:	50                   	push   %eax
  800750:	e8 77 14 00 00       	call   801bcc <__umoddi3>
  800755:	83 c4 10             	add    $0x10,%esp
  800758:	05 f4 21 80 00       	add    $0x8021f4,%eax
  80075d:	8a 00                	mov    (%eax),%al
  80075f:	0f be c0             	movsbl %al,%eax
  800762:	83 ec 08             	sub    $0x8,%esp
  800765:	ff 75 0c             	pushl  0xc(%ebp)
  800768:	50                   	push   %eax
  800769:	8b 45 08             	mov    0x8(%ebp),%eax
  80076c:	ff d0                	call   *%eax
  80076e:	83 c4 10             	add    $0x10,%esp
}
  800771:	90                   	nop
  800772:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800775:	c9                   	leave  
  800776:	c3                   	ret    

00800777 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800777:	55                   	push   %ebp
  800778:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80077a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80077e:	7e 1c                	jle    80079c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800780:	8b 45 08             	mov    0x8(%ebp),%eax
  800783:	8b 00                	mov    (%eax),%eax
  800785:	8d 50 08             	lea    0x8(%eax),%edx
  800788:	8b 45 08             	mov    0x8(%ebp),%eax
  80078b:	89 10                	mov    %edx,(%eax)
  80078d:	8b 45 08             	mov    0x8(%ebp),%eax
  800790:	8b 00                	mov    (%eax),%eax
  800792:	83 e8 08             	sub    $0x8,%eax
  800795:	8b 50 04             	mov    0x4(%eax),%edx
  800798:	8b 00                	mov    (%eax),%eax
  80079a:	eb 40                	jmp    8007dc <getuint+0x65>
	else if (lflag)
  80079c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007a0:	74 1e                	je     8007c0 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a5:	8b 00                	mov    (%eax),%eax
  8007a7:	8d 50 04             	lea    0x4(%eax),%edx
  8007aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ad:	89 10                	mov    %edx,(%eax)
  8007af:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b2:	8b 00                	mov    (%eax),%eax
  8007b4:	83 e8 04             	sub    $0x4,%eax
  8007b7:	8b 00                	mov    (%eax),%eax
  8007b9:	ba 00 00 00 00       	mov    $0x0,%edx
  8007be:	eb 1c                	jmp    8007dc <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c3:	8b 00                	mov    (%eax),%eax
  8007c5:	8d 50 04             	lea    0x4(%eax),%edx
  8007c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cb:	89 10                	mov    %edx,(%eax)
  8007cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d0:	8b 00                	mov    (%eax),%eax
  8007d2:	83 e8 04             	sub    $0x4,%eax
  8007d5:	8b 00                	mov    (%eax),%eax
  8007d7:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007dc:	5d                   	pop    %ebp
  8007dd:	c3                   	ret    

008007de <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007de:	55                   	push   %ebp
  8007df:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007e1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007e5:	7e 1c                	jle    800803 <getint+0x25>
		return va_arg(*ap, long long);
  8007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ea:	8b 00                	mov    (%eax),%eax
  8007ec:	8d 50 08             	lea    0x8(%eax),%edx
  8007ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f2:	89 10                	mov    %edx,(%eax)
  8007f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f7:	8b 00                	mov    (%eax),%eax
  8007f9:	83 e8 08             	sub    $0x8,%eax
  8007fc:	8b 50 04             	mov    0x4(%eax),%edx
  8007ff:	8b 00                	mov    (%eax),%eax
  800801:	eb 38                	jmp    80083b <getint+0x5d>
	else if (lflag)
  800803:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800807:	74 1a                	je     800823 <getint+0x45>
		return va_arg(*ap, long);
  800809:	8b 45 08             	mov    0x8(%ebp),%eax
  80080c:	8b 00                	mov    (%eax),%eax
  80080e:	8d 50 04             	lea    0x4(%eax),%edx
  800811:	8b 45 08             	mov    0x8(%ebp),%eax
  800814:	89 10                	mov    %edx,(%eax)
  800816:	8b 45 08             	mov    0x8(%ebp),%eax
  800819:	8b 00                	mov    (%eax),%eax
  80081b:	83 e8 04             	sub    $0x4,%eax
  80081e:	8b 00                	mov    (%eax),%eax
  800820:	99                   	cltd   
  800821:	eb 18                	jmp    80083b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800823:	8b 45 08             	mov    0x8(%ebp),%eax
  800826:	8b 00                	mov    (%eax),%eax
  800828:	8d 50 04             	lea    0x4(%eax),%edx
  80082b:	8b 45 08             	mov    0x8(%ebp),%eax
  80082e:	89 10                	mov    %edx,(%eax)
  800830:	8b 45 08             	mov    0x8(%ebp),%eax
  800833:	8b 00                	mov    (%eax),%eax
  800835:	83 e8 04             	sub    $0x4,%eax
  800838:	8b 00                	mov    (%eax),%eax
  80083a:	99                   	cltd   
}
  80083b:	5d                   	pop    %ebp
  80083c:	c3                   	ret    

0080083d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80083d:	55                   	push   %ebp
  80083e:	89 e5                	mov    %esp,%ebp
  800840:	56                   	push   %esi
  800841:	53                   	push   %ebx
  800842:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800845:	eb 17                	jmp    80085e <vprintfmt+0x21>
			if (ch == '\0')
  800847:	85 db                	test   %ebx,%ebx
  800849:	0f 84 af 03 00 00    	je     800bfe <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80084f:	83 ec 08             	sub    $0x8,%esp
  800852:	ff 75 0c             	pushl  0xc(%ebp)
  800855:	53                   	push   %ebx
  800856:	8b 45 08             	mov    0x8(%ebp),%eax
  800859:	ff d0                	call   *%eax
  80085b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80085e:	8b 45 10             	mov    0x10(%ebp),%eax
  800861:	8d 50 01             	lea    0x1(%eax),%edx
  800864:	89 55 10             	mov    %edx,0x10(%ebp)
  800867:	8a 00                	mov    (%eax),%al
  800869:	0f b6 d8             	movzbl %al,%ebx
  80086c:	83 fb 25             	cmp    $0x25,%ebx
  80086f:	75 d6                	jne    800847 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800871:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800875:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80087c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800883:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80088a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800891:	8b 45 10             	mov    0x10(%ebp),%eax
  800894:	8d 50 01             	lea    0x1(%eax),%edx
  800897:	89 55 10             	mov    %edx,0x10(%ebp)
  80089a:	8a 00                	mov    (%eax),%al
  80089c:	0f b6 d8             	movzbl %al,%ebx
  80089f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008a2:	83 f8 55             	cmp    $0x55,%eax
  8008a5:	0f 87 2b 03 00 00    	ja     800bd6 <vprintfmt+0x399>
  8008ab:	8b 04 85 18 22 80 00 	mov    0x802218(,%eax,4),%eax
  8008b2:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008b4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008b8:	eb d7                	jmp    800891 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008ba:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008be:	eb d1                	jmp    800891 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008c0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008c7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008ca:	89 d0                	mov    %edx,%eax
  8008cc:	c1 e0 02             	shl    $0x2,%eax
  8008cf:	01 d0                	add    %edx,%eax
  8008d1:	01 c0                	add    %eax,%eax
  8008d3:	01 d8                	add    %ebx,%eax
  8008d5:	83 e8 30             	sub    $0x30,%eax
  8008d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008db:	8b 45 10             	mov    0x10(%ebp),%eax
  8008de:	8a 00                	mov    (%eax),%al
  8008e0:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008e3:	83 fb 2f             	cmp    $0x2f,%ebx
  8008e6:	7e 3e                	jle    800926 <vprintfmt+0xe9>
  8008e8:	83 fb 39             	cmp    $0x39,%ebx
  8008eb:	7f 39                	jg     800926 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008ed:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008f0:	eb d5                	jmp    8008c7 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f5:	83 c0 04             	add    $0x4,%eax
  8008f8:	89 45 14             	mov    %eax,0x14(%ebp)
  8008fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8008fe:	83 e8 04             	sub    $0x4,%eax
  800901:	8b 00                	mov    (%eax),%eax
  800903:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800906:	eb 1f                	jmp    800927 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800908:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80090c:	79 83                	jns    800891 <vprintfmt+0x54>
				width = 0;
  80090e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800915:	e9 77 ff ff ff       	jmp    800891 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80091a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800921:	e9 6b ff ff ff       	jmp    800891 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800926:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800927:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80092b:	0f 89 60 ff ff ff    	jns    800891 <vprintfmt+0x54>
				width = precision, precision = -1;
  800931:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800934:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800937:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80093e:	e9 4e ff ff ff       	jmp    800891 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800943:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800946:	e9 46 ff ff ff       	jmp    800891 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80094b:	8b 45 14             	mov    0x14(%ebp),%eax
  80094e:	83 c0 04             	add    $0x4,%eax
  800951:	89 45 14             	mov    %eax,0x14(%ebp)
  800954:	8b 45 14             	mov    0x14(%ebp),%eax
  800957:	83 e8 04             	sub    $0x4,%eax
  80095a:	8b 00                	mov    (%eax),%eax
  80095c:	83 ec 08             	sub    $0x8,%esp
  80095f:	ff 75 0c             	pushl  0xc(%ebp)
  800962:	50                   	push   %eax
  800963:	8b 45 08             	mov    0x8(%ebp),%eax
  800966:	ff d0                	call   *%eax
  800968:	83 c4 10             	add    $0x10,%esp
			break;
  80096b:	e9 89 02 00 00       	jmp    800bf9 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800970:	8b 45 14             	mov    0x14(%ebp),%eax
  800973:	83 c0 04             	add    $0x4,%eax
  800976:	89 45 14             	mov    %eax,0x14(%ebp)
  800979:	8b 45 14             	mov    0x14(%ebp),%eax
  80097c:	83 e8 04             	sub    $0x4,%eax
  80097f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800981:	85 db                	test   %ebx,%ebx
  800983:	79 02                	jns    800987 <vprintfmt+0x14a>
				err = -err;
  800985:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800987:	83 fb 64             	cmp    $0x64,%ebx
  80098a:	7f 0b                	jg     800997 <vprintfmt+0x15a>
  80098c:	8b 34 9d 60 20 80 00 	mov    0x802060(,%ebx,4),%esi
  800993:	85 f6                	test   %esi,%esi
  800995:	75 19                	jne    8009b0 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800997:	53                   	push   %ebx
  800998:	68 05 22 80 00       	push   $0x802205
  80099d:	ff 75 0c             	pushl  0xc(%ebp)
  8009a0:	ff 75 08             	pushl  0x8(%ebp)
  8009a3:	e8 5e 02 00 00       	call   800c06 <printfmt>
  8009a8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009ab:	e9 49 02 00 00       	jmp    800bf9 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009b0:	56                   	push   %esi
  8009b1:	68 0e 22 80 00       	push   $0x80220e
  8009b6:	ff 75 0c             	pushl  0xc(%ebp)
  8009b9:	ff 75 08             	pushl  0x8(%ebp)
  8009bc:	e8 45 02 00 00       	call   800c06 <printfmt>
  8009c1:	83 c4 10             	add    $0x10,%esp
			break;
  8009c4:	e9 30 02 00 00       	jmp    800bf9 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8009cc:	83 c0 04             	add    $0x4,%eax
  8009cf:	89 45 14             	mov    %eax,0x14(%ebp)
  8009d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d5:	83 e8 04             	sub    $0x4,%eax
  8009d8:	8b 30                	mov    (%eax),%esi
  8009da:	85 f6                	test   %esi,%esi
  8009dc:	75 05                	jne    8009e3 <vprintfmt+0x1a6>
				p = "(null)";
  8009de:	be 11 22 80 00       	mov    $0x802211,%esi
			if (width > 0 && padc != '-')
  8009e3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e7:	7e 6d                	jle    800a56 <vprintfmt+0x219>
  8009e9:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009ed:	74 67                	je     800a56 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009f2:	83 ec 08             	sub    $0x8,%esp
  8009f5:	50                   	push   %eax
  8009f6:	56                   	push   %esi
  8009f7:	e8 0c 03 00 00       	call   800d08 <strnlen>
  8009fc:	83 c4 10             	add    $0x10,%esp
  8009ff:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a02:	eb 16                	jmp    800a1a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a04:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a08:	83 ec 08             	sub    $0x8,%esp
  800a0b:	ff 75 0c             	pushl  0xc(%ebp)
  800a0e:	50                   	push   %eax
  800a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a12:	ff d0                	call   *%eax
  800a14:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a17:	ff 4d e4             	decl   -0x1c(%ebp)
  800a1a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a1e:	7f e4                	jg     800a04 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a20:	eb 34                	jmp    800a56 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a22:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a26:	74 1c                	je     800a44 <vprintfmt+0x207>
  800a28:	83 fb 1f             	cmp    $0x1f,%ebx
  800a2b:	7e 05                	jle    800a32 <vprintfmt+0x1f5>
  800a2d:	83 fb 7e             	cmp    $0x7e,%ebx
  800a30:	7e 12                	jle    800a44 <vprintfmt+0x207>
					putch('?', putdat);
  800a32:	83 ec 08             	sub    $0x8,%esp
  800a35:	ff 75 0c             	pushl  0xc(%ebp)
  800a38:	6a 3f                	push   $0x3f
  800a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3d:	ff d0                	call   *%eax
  800a3f:	83 c4 10             	add    $0x10,%esp
  800a42:	eb 0f                	jmp    800a53 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a44:	83 ec 08             	sub    $0x8,%esp
  800a47:	ff 75 0c             	pushl  0xc(%ebp)
  800a4a:	53                   	push   %ebx
  800a4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4e:	ff d0                	call   *%eax
  800a50:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a53:	ff 4d e4             	decl   -0x1c(%ebp)
  800a56:	89 f0                	mov    %esi,%eax
  800a58:	8d 70 01             	lea    0x1(%eax),%esi
  800a5b:	8a 00                	mov    (%eax),%al
  800a5d:	0f be d8             	movsbl %al,%ebx
  800a60:	85 db                	test   %ebx,%ebx
  800a62:	74 24                	je     800a88 <vprintfmt+0x24b>
  800a64:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a68:	78 b8                	js     800a22 <vprintfmt+0x1e5>
  800a6a:	ff 4d e0             	decl   -0x20(%ebp)
  800a6d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a71:	79 af                	jns    800a22 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a73:	eb 13                	jmp    800a88 <vprintfmt+0x24b>
				putch(' ', putdat);
  800a75:	83 ec 08             	sub    $0x8,%esp
  800a78:	ff 75 0c             	pushl  0xc(%ebp)
  800a7b:	6a 20                	push   $0x20
  800a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a80:	ff d0                	call   *%eax
  800a82:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a85:	ff 4d e4             	decl   -0x1c(%ebp)
  800a88:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a8c:	7f e7                	jg     800a75 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a8e:	e9 66 01 00 00       	jmp    800bf9 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a93:	83 ec 08             	sub    $0x8,%esp
  800a96:	ff 75 e8             	pushl  -0x18(%ebp)
  800a99:	8d 45 14             	lea    0x14(%ebp),%eax
  800a9c:	50                   	push   %eax
  800a9d:	e8 3c fd ff ff       	call   8007de <getint>
  800aa2:	83 c4 10             	add    $0x10,%esp
  800aa5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aa8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800aab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ab1:	85 d2                	test   %edx,%edx
  800ab3:	79 23                	jns    800ad8 <vprintfmt+0x29b>
				putch('-', putdat);
  800ab5:	83 ec 08             	sub    $0x8,%esp
  800ab8:	ff 75 0c             	pushl  0xc(%ebp)
  800abb:	6a 2d                	push   $0x2d
  800abd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac0:	ff d0                	call   *%eax
  800ac2:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ac5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ac8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800acb:	f7 d8                	neg    %eax
  800acd:	83 d2 00             	adc    $0x0,%edx
  800ad0:	f7 da                	neg    %edx
  800ad2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ad8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800adf:	e9 bc 00 00 00       	jmp    800ba0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ae4:	83 ec 08             	sub    $0x8,%esp
  800ae7:	ff 75 e8             	pushl  -0x18(%ebp)
  800aea:	8d 45 14             	lea    0x14(%ebp),%eax
  800aed:	50                   	push   %eax
  800aee:	e8 84 fc ff ff       	call   800777 <getuint>
  800af3:	83 c4 10             	add    $0x10,%esp
  800af6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800af9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800afc:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b03:	e9 98 00 00 00       	jmp    800ba0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b08:	83 ec 08             	sub    $0x8,%esp
  800b0b:	ff 75 0c             	pushl  0xc(%ebp)
  800b0e:	6a 58                	push   $0x58
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	ff d0                	call   *%eax
  800b15:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b18:	83 ec 08             	sub    $0x8,%esp
  800b1b:	ff 75 0c             	pushl  0xc(%ebp)
  800b1e:	6a 58                	push   $0x58
  800b20:	8b 45 08             	mov    0x8(%ebp),%eax
  800b23:	ff d0                	call   *%eax
  800b25:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b28:	83 ec 08             	sub    $0x8,%esp
  800b2b:	ff 75 0c             	pushl  0xc(%ebp)
  800b2e:	6a 58                	push   $0x58
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	ff d0                	call   *%eax
  800b35:	83 c4 10             	add    $0x10,%esp
			break;
  800b38:	e9 bc 00 00 00       	jmp    800bf9 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b3d:	83 ec 08             	sub    $0x8,%esp
  800b40:	ff 75 0c             	pushl  0xc(%ebp)
  800b43:	6a 30                	push   $0x30
  800b45:	8b 45 08             	mov    0x8(%ebp),%eax
  800b48:	ff d0                	call   *%eax
  800b4a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b4d:	83 ec 08             	sub    $0x8,%esp
  800b50:	ff 75 0c             	pushl  0xc(%ebp)
  800b53:	6a 78                	push   $0x78
  800b55:	8b 45 08             	mov    0x8(%ebp),%eax
  800b58:	ff d0                	call   *%eax
  800b5a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b5d:	8b 45 14             	mov    0x14(%ebp),%eax
  800b60:	83 c0 04             	add    $0x4,%eax
  800b63:	89 45 14             	mov    %eax,0x14(%ebp)
  800b66:	8b 45 14             	mov    0x14(%ebp),%eax
  800b69:	83 e8 04             	sub    $0x4,%eax
  800b6c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b71:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b78:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b7f:	eb 1f                	jmp    800ba0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b81:	83 ec 08             	sub    $0x8,%esp
  800b84:	ff 75 e8             	pushl  -0x18(%ebp)
  800b87:	8d 45 14             	lea    0x14(%ebp),%eax
  800b8a:	50                   	push   %eax
  800b8b:	e8 e7 fb ff ff       	call   800777 <getuint>
  800b90:	83 c4 10             	add    $0x10,%esp
  800b93:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b96:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b99:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ba0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ba4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ba7:	83 ec 04             	sub    $0x4,%esp
  800baa:	52                   	push   %edx
  800bab:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bae:	50                   	push   %eax
  800baf:	ff 75 f4             	pushl  -0xc(%ebp)
  800bb2:	ff 75 f0             	pushl  -0x10(%ebp)
  800bb5:	ff 75 0c             	pushl  0xc(%ebp)
  800bb8:	ff 75 08             	pushl  0x8(%ebp)
  800bbb:	e8 00 fb ff ff       	call   8006c0 <printnum>
  800bc0:	83 c4 20             	add    $0x20,%esp
			break;
  800bc3:	eb 34                	jmp    800bf9 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bc5:	83 ec 08             	sub    $0x8,%esp
  800bc8:	ff 75 0c             	pushl  0xc(%ebp)
  800bcb:	53                   	push   %ebx
  800bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcf:	ff d0                	call   *%eax
  800bd1:	83 c4 10             	add    $0x10,%esp
			break;
  800bd4:	eb 23                	jmp    800bf9 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bd6:	83 ec 08             	sub    $0x8,%esp
  800bd9:	ff 75 0c             	pushl  0xc(%ebp)
  800bdc:	6a 25                	push   $0x25
  800bde:	8b 45 08             	mov    0x8(%ebp),%eax
  800be1:	ff d0                	call   *%eax
  800be3:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800be6:	ff 4d 10             	decl   0x10(%ebp)
  800be9:	eb 03                	jmp    800bee <vprintfmt+0x3b1>
  800beb:	ff 4d 10             	decl   0x10(%ebp)
  800bee:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf1:	48                   	dec    %eax
  800bf2:	8a 00                	mov    (%eax),%al
  800bf4:	3c 25                	cmp    $0x25,%al
  800bf6:	75 f3                	jne    800beb <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800bf8:	90                   	nop
		}
	}
  800bf9:	e9 47 fc ff ff       	jmp    800845 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800bfe:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800bff:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c02:	5b                   	pop    %ebx
  800c03:	5e                   	pop    %esi
  800c04:	5d                   	pop    %ebp
  800c05:	c3                   	ret    

00800c06 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c06:	55                   	push   %ebp
  800c07:	89 e5                	mov    %esp,%ebp
  800c09:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c0c:	8d 45 10             	lea    0x10(%ebp),%eax
  800c0f:	83 c0 04             	add    $0x4,%eax
  800c12:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c15:	8b 45 10             	mov    0x10(%ebp),%eax
  800c18:	ff 75 f4             	pushl  -0xc(%ebp)
  800c1b:	50                   	push   %eax
  800c1c:	ff 75 0c             	pushl  0xc(%ebp)
  800c1f:	ff 75 08             	pushl  0x8(%ebp)
  800c22:	e8 16 fc ff ff       	call   80083d <vprintfmt>
  800c27:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c2a:	90                   	nop
  800c2b:	c9                   	leave  
  800c2c:	c3                   	ret    

00800c2d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c2d:	55                   	push   %ebp
  800c2e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c33:	8b 40 08             	mov    0x8(%eax),%eax
  800c36:	8d 50 01             	lea    0x1(%eax),%edx
  800c39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c42:	8b 10                	mov    (%eax),%edx
  800c44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c47:	8b 40 04             	mov    0x4(%eax),%eax
  800c4a:	39 c2                	cmp    %eax,%edx
  800c4c:	73 12                	jae    800c60 <sprintputch+0x33>
		*b->buf++ = ch;
  800c4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c51:	8b 00                	mov    (%eax),%eax
  800c53:	8d 48 01             	lea    0x1(%eax),%ecx
  800c56:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c59:	89 0a                	mov    %ecx,(%edx)
  800c5b:	8b 55 08             	mov    0x8(%ebp),%edx
  800c5e:	88 10                	mov    %dl,(%eax)
}
  800c60:	90                   	nop
  800c61:	5d                   	pop    %ebp
  800c62:	c3                   	ret    

00800c63 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c63:	55                   	push   %ebp
  800c64:	89 e5                	mov    %esp,%ebp
  800c66:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c69:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c72:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c75:	8b 45 08             	mov    0x8(%ebp),%eax
  800c78:	01 d0                	add    %edx,%eax
  800c7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c7d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c84:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c88:	74 06                	je     800c90 <vsnprintf+0x2d>
  800c8a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c8e:	7f 07                	jg     800c97 <vsnprintf+0x34>
		return -E_INVAL;
  800c90:	b8 03 00 00 00       	mov    $0x3,%eax
  800c95:	eb 20                	jmp    800cb7 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c97:	ff 75 14             	pushl  0x14(%ebp)
  800c9a:	ff 75 10             	pushl  0x10(%ebp)
  800c9d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ca0:	50                   	push   %eax
  800ca1:	68 2d 0c 80 00       	push   $0x800c2d
  800ca6:	e8 92 fb ff ff       	call   80083d <vprintfmt>
  800cab:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cb1:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800cb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800cb7:	c9                   	leave  
  800cb8:	c3                   	ret    

00800cb9 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800cb9:	55                   	push   %ebp
  800cba:	89 e5                	mov    %esp,%ebp
  800cbc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800cbf:	8d 45 10             	lea    0x10(%ebp),%eax
  800cc2:	83 c0 04             	add    $0x4,%eax
  800cc5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800cc8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccb:	ff 75 f4             	pushl  -0xc(%ebp)
  800cce:	50                   	push   %eax
  800ccf:	ff 75 0c             	pushl  0xc(%ebp)
  800cd2:	ff 75 08             	pushl  0x8(%ebp)
  800cd5:	e8 89 ff ff ff       	call   800c63 <vsnprintf>
  800cda:	83 c4 10             	add    $0x10,%esp
  800cdd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ce0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ce3:	c9                   	leave  
  800ce4:	c3                   	ret    

00800ce5 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ce5:	55                   	push   %ebp
  800ce6:	89 e5                	mov    %esp,%ebp
  800ce8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ceb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cf2:	eb 06                	jmp    800cfa <strlen+0x15>
		n++;
  800cf4:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800cf7:	ff 45 08             	incl   0x8(%ebp)
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	8a 00                	mov    (%eax),%al
  800cff:	84 c0                	test   %al,%al
  800d01:	75 f1                	jne    800cf4 <strlen+0xf>
		n++;
	return n;
  800d03:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d06:	c9                   	leave  
  800d07:	c3                   	ret    

00800d08 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d08:	55                   	push   %ebp
  800d09:	89 e5                	mov    %esp,%ebp
  800d0b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d0e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d15:	eb 09                	jmp    800d20 <strnlen+0x18>
		n++;
  800d17:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d1a:	ff 45 08             	incl   0x8(%ebp)
  800d1d:	ff 4d 0c             	decl   0xc(%ebp)
  800d20:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d24:	74 09                	je     800d2f <strnlen+0x27>
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	84 c0                	test   %al,%al
  800d2d:	75 e8                	jne    800d17 <strnlen+0xf>
		n++;
	return n;
  800d2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d32:	c9                   	leave  
  800d33:	c3                   	ret    

00800d34 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d34:	55                   	push   %ebp
  800d35:	89 e5                	mov    %esp,%ebp
  800d37:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d40:	90                   	nop
  800d41:	8b 45 08             	mov    0x8(%ebp),%eax
  800d44:	8d 50 01             	lea    0x1(%eax),%edx
  800d47:	89 55 08             	mov    %edx,0x8(%ebp)
  800d4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d4d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d50:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d53:	8a 12                	mov    (%edx),%dl
  800d55:	88 10                	mov    %dl,(%eax)
  800d57:	8a 00                	mov    (%eax),%al
  800d59:	84 c0                	test   %al,%al
  800d5b:	75 e4                	jne    800d41 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d60:	c9                   	leave  
  800d61:	c3                   	ret    

00800d62 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d62:	55                   	push   %ebp
  800d63:	89 e5                	mov    %esp,%ebp
  800d65:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d6e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d75:	eb 1f                	jmp    800d96 <strncpy+0x34>
		*dst++ = *src;
  800d77:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7a:	8d 50 01             	lea    0x1(%eax),%edx
  800d7d:	89 55 08             	mov    %edx,0x8(%ebp)
  800d80:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d83:	8a 12                	mov    (%edx),%dl
  800d85:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8a:	8a 00                	mov    (%eax),%al
  800d8c:	84 c0                	test   %al,%al
  800d8e:	74 03                	je     800d93 <strncpy+0x31>
			src++;
  800d90:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d93:	ff 45 fc             	incl   -0x4(%ebp)
  800d96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d99:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d9c:	72 d9                	jb     800d77 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800da1:	c9                   	leave  
  800da2:	c3                   	ret    

00800da3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800da3:	55                   	push   %ebp
  800da4:	89 e5                	mov    %esp,%ebp
  800da6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800da9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800daf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800db3:	74 30                	je     800de5 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800db5:	eb 16                	jmp    800dcd <strlcpy+0x2a>
			*dst++ = *src++;
  800db7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dba:	8d 50 01             	lea    0x1(%eax),%edx
  800dbd:	89 55 08             	mov    %edx,0x8(%ebp)
  800dc0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dc3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dc6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800dc9:	8a 12                	mov    (%edx),%dl
  800dcb:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800dcd:	ff 4d 10             	decl   0x10(%ebp)
  800dd0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dd4:	74 09                	je     800ddf <strlcpy+0x3c>
  800dd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd9:	8a 00                	mov    (%eax),%al
  800ddb:	84 c0                	test   %al,%al
  800ddd:	75 d8                	jne    800db7 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ddf:	8b 45 08             	mov    0x8(%ebp),%eax
  800de2:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800de5:	8b 55 08             	mov    0x8(%ebp),%edx
  800de8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800deb:	29 c2                	sub    %eax,%edx
  800ded:	89 d0                	mov    %edx,%eax
}
  800def:	c9                   	leave  
  800df0:	c3                   	ret    

00800df1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800df1:	55                   	push   %ebp
  800df2:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800df4:	eb 06                	jmp    800dfc <strcmp+0xb>
		p++, q++;
  800df6:	ff 45 08             	incl   0x8(%ebp)
  800df9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dff:	8a 00                	mov    (%eax),%al
  800e01:	84 c0                	test   %al,%al
  800e03:	74 0e                	je     800e13 <strcmp+0x22>
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
  800e08:	8a 10                	mov    (%eax),%dl
  800e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0d:	8a 00                	mov    (%eax),%al
  800e0f:	38 c2                	cmp    %al,%dl
  800e11:	74 e3                	je     800df6 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	8a 00                	mov    (%eax),%al
  800e18:	0f b6 d0             	movzbl %al,%edx
  800e1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1e:	8a 00                	mov    (%eax),%al
  800e20:	0f b6 c0             	movzbl %al,%eax
  800e23:	29 c2                	sub    %eax,%edx
  800e25:	89 d0                	mov    %edx,%eax
}
  800e27:	5d                   	pop    %ebp
  800e28:	c3                   	ret    

00800e29 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e29:	55                   	push   %ebp
  800e2a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e2c:	eb 09                	jmp    800e37 <strncmp+0xe>
		n--, p++, q++;
  800e2e:	ff 4d 10             	decl   0x10(%ebp)
  800e31:	ff 45 08             	incl   0x8(%ebp)
  800e34:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e37:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e3b:	74 17                	je     800e54 <strncmp+0x2b>
  800e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e40:	8a 00                	mov    (%eax),%al
  800e42:	84 c0                	test   %al,%al
  800e44:	74 0e                	je     800e54 <strncmp+0x2b>
  800e46:	8b 45 08             	mov    0x8(%ebp),%eax
  800e49:	8a 10                	mov    (%eax),%dl
  800e4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4e:	8a 00                	mov    (%eax),%al
  800e50:	38 c2                	cmp    %al,%dl
  800e52:	74 da                	je     800e2e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e54:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e58:	75 07                	jne    800e61 <strncmp+0x38>
		return 0;
  800e5a:	b8 00 00 00 00       	mov    $0x0,%eax
  800e5f:	eb 14                	jmp    800e75 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e61:	8b 45 08             	mov    0x8(%ebp),%eax
  800e64:	8a 00                	mov    (%eax),%al
  800e66:	0f b6 d0             	movzbl %al,%edx
  800e69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6c:	8a 00                	mov    (%eax),%al
  800e6e:	0f b6 c0             	movzbl %al,%eax
  800e71:	29 c2                	sub    %eax,%edx
  800e73:	89 d0                	mov    %edx,%eax
}
  800e75:	5d                   	pop    %ebp
  800e76:	c3                   	ret    

00800e77 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e77:	55                   	push   %ebp
  800e78:	89 e5                	mov    %esp,%ebp
  800e7a:	83 ec 04             	sub    $0x4,%esp
  800e7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e80:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e83:	eb 12                	jmp    800e97 <strchr+0x20>
		if (*s == c)
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
  800e88:	8a 00                	mov    (%eax),%al
  800e8a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e8d:	75 05                	jne    800e94 <strchr+0x1d>
			return (char *) s;
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	eb 11                	jmp    800ea5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e94:	ff 45 08             	incl   0x8(%ebp)
  800e97:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9a:	8a 00                	mov    (%eax),%al
  800e9c:	84 c0                	test   %al,%al
  800e9e:	75 e5                	jne    800e85 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ea0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ea5:	c9                   	leave  
  800ea6:	c3                   	ret    

00800ea7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ea7:	55                   	push   %ebp
  800ea8:	89 e5                	mov    %esp,%ebp
  800eaa:	83 ec 04             	sub    $0x4,%esp
  800ead:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800eb3:	eb 0d                	jmp    800ec2 <strfind+0x1b>
		if (*s == c)
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	8a 00                	mov    (%eax),%al
  800eba:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ebd:	74 0e                	je     800ecd <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ebf:	ff 45 08             	incl   0x8(%ebp)
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	8a 00                	mov    (%eax),%al
  800ec7:	84 c0                	test   %al,%al
  800ec9:	75 ea                	jne    800eb5 <strfind+0xe>
  800ecb:	eb 01                	jmp    800ece <strfind+0x27>
		if (*s == c)
			break;
  800ecd:	90                   	nop
	return (char *) s;
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ed1:	c9                   	leave  
  800ed2:	c3                   	ret    

00800ed3 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ed3:	55                   	push   %ebp
  800ed4:	89 e5                	mov    %esp,%ebp
  800ed6:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  800edc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800edf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ee5:	eb 0e                	jmp    800ef5 <memset+0x22>
		*p++ = c;
  800ee7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eea:	8d 50 01             	lea    0x1(%eax),%edx
  800eed:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ef0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ef3:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ef5:	ff 4d f8             	decl   -0x8(%ebp)
  800ef8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800efc:	79 e9                	jns    800ee7 <memset+0x14>
		*p++ = c;

	return v;
  800efe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f01:	c9                   	leave  
  800f02:	c3                   	ret    

00800f03 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f03:	55                   	push   %ebp
  800f04:	89 e5                	mov    %esp,%ebp
  800f06:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f15:	eb 16                	jmp    800f2d <memcpy+0x2a>
		*d++ = *s++;
  800f17:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f1a:	8d 50 01             	lea    0x1(%eax),%edx
  800f1d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f20:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f23:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f26:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f29:	8a 12                	mov    (%edx),%dl
  800f2b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f30:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f33:	89 55 10             	mov    %edx,0x10(%ebp)
  800f36:	85 c0                	test   %eax,%eax
  800f38:	75 dd                	jne    800f17 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f3d:	c9                   	leave  
  800f3e:	c3                   	ret    

00800f3f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f3f:	55                   	push   %ebp
  800f40:	89 e5                	mov    %esp,%ebp
  800f42:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800f45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f48:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f51:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f54:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f57:	73 50                	jae    800fa9 <memmove+0x6a>
  800f59:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5f:	01 d0                	add    %edx,%eax
  800f61:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f64:	76 43                	jbe    800fa9 <memmove+0x6a>
		s += n;
  800f66:	8b 45 10             	mov    0x10(%ebp),%eax
  800f69:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f72:	eb 10                	jmp    800f84 <memmove+0x45>
			*--d = *--s;
  800f74:	ff 4d f8             	decl   -0x8(%ebp)
  800f77:	ff 4d fc             	decl   -0x4(%ebp)
  800f7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f7d:	8a 10                	mov    (%eax),%dl
  800f7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f82:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f84:	8b 45 10             	mov    0x10(%ebp),%eax
  800f87:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f8a:	89 55 10             	mov    %edx,0x10(%ebp)
  800f8d:	85 c0                	test   %eax,%eax
  800f8f:	75 e3                	jne    800f74 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f91:	eb 23                	jmp    800fb6 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f93:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f96:	8d 50 01             	lea    0x1(%eax),%edx
  800f99:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f9c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f9f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fa2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fa5:	8a 12                	mov    (%edx),%dl
  800fa7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fa9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fac:	8d 50 ff             	lea    -0x1(%eax),%edx
  800faf:	89 55 10             	mov    %edx,0x10(%ebp)
  800fb2:	85 c0                	test   %eax,%eax
  800fb4:	75 dd                	jne    800f93 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fb6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fb9:	c9                   	leave  
  800fba:	c3                   	ret    

00800fbb <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fbb:	55                   	push   %ebp
  800fbc:	89 e5                	mov    %esp,%ebp
  800fbe:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800fc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fca:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800fcd:	eb 2a                	jmp    800ff9 <memcmp+0x3e>
		if (*s1 != *s2)
  800fcf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fd2:	8a 10                	mov    (%eax),%dl
  800fd4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd7:	8a 00                	mov    (%eax),%al
  800fd9:	38 c2                	cmp    %al,%dl
  800fdb:	74 16                	je     800ff3 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800fdd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe0:	8a 00                	mov    (%eax),%al
  800fe2:	0f b6 d0             	movzbl %al,%edx
  800fe5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe8:	8a 00                	mov    (%eax),%al
  800fea:	0f b6 c0             	movzbl %al,%eax
  800fed:	29 c2                	sub    %eax,%edx
  800fef:	89 d0                	mov    %edx,%eax
  800ff1:	eb 18                	jmp    80100b <memcmp+0x50>
		s1++, s2++;
  800ff3:	ff 45 fc             	incl   -0x4(%ebp)
  800ff6:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ff9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fff:	89 55 10             	mov    %edx,0x10(%ebp)
  801002:	85 c0                	test   %eax,%eax
  801004:	75 c9                	jne    800fcf <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801006:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80100b:	c9                   	leave  
  80100c:	c3                   	ret    

0080100d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80100d:	55                   	push   %ebp
  80100e:	89 e5                	mov    %esp,%ebp
  801010:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801013:	8b 55 08             	mov    0x8(%ebp),%edx
  801016:	8b 45 10             	mov    0x10(%ebp),%eax
  801019:	01 d0                	add    %edx,%eax
  80101b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80101e:	eb 15                	jmp    801035 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801020:	8b 45 08             	mov    0x8(%ebp),%eax
  801023:	8a 00                	mov    (%eax),%al
  801025:	0f b6 d0             	movzbl %al,%edx
  801028:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102b:	0f b6 c0             	movzbl %al,%eax
  80102e:	39 c2                	cmp    %eax,%edx
  801030:	74 0d                	je     80103f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801032:	ff 45 08             	incl   0x8(%ebp)
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80103b:	72 e3                	jb     801020 <memfind+0x13>
  80103d:	eb 01                	jmp    801040 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80103f:	90                   	nop
	return (void *) s;
  801040:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801043:	c9                   	leave  
  801044:	c3                   	ret    

00801045 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801045:	55                   	push   %ebp
  801046:	89 e5                	mov    %esp,%ebp
  801048:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80104b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801052:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801059:	eb 03                	jmp    80105e <strtol+0x19>
		s++;
  80105b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80105e:	8b 45 08             	mov    0x8(%ebp),%eax
  801061:	8a 00                	mov    (%eax),%al
  801063:	3c 20                	cmp    $0x20,%al
  801065:	74 f4                	je     80105b <strtol+0x16>
  801067:	8b 45 08             	mov    0x8(%ebp),%eax
  80106a:	8a 00                	mov    (%eax),%al
  80106c:	3c 09                	cmp    $0x9,%al
  80106e:	74 eb                	je     80105b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801070:	8b 45 08             	mov    0x8(%ebp),%eax
  801073:	8a 00                	mov    (%eax),%al
  801075:	3c 2b                	cmp    $0x2b,%al
  801077:	75 05                	jne    80107e <strtol+0x39>
		s++;
  801079:	ff 45 08             	incl   0x8(%ebp)
  80107c:	eb 13                	jmp    801091 <strtol+0x4c>
	else if (*s == '-')
  80107e:	8b 45 08             	mov    0x8(%ebp),%eax
  801081:	8a 00                	mov    (%eax),%al
  801083:	3c 2d                	cmp    $0x2d,%al
  801085:	75 0a                	jne    801091 <strtol+0x4c>
		s++, neg = 1;
  801087:	ff 45 08             	incl   0x8(%ebp)
  80108a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801091:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801095:	74 06                	je     80109d <strtol+0x58>
  801097:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80109b:	75 20                	jne    8010bd <strtol+0x78>
  80109d:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a0:	8a 00                	mov    (%eax),%al
  8010a2:	3c 30                	cmp    $0x30,%al
  8010a4:	75 17                	jne    8010bd <strtol+0x78>
  8010a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a9:	40                   	inc    %eax
  8010aa:	8a 00                	mov    (%eax),%al
  8010ac:	3c 78                	cmp    $0x78,%al
  8010ae:	75 0d                	jne    8010bd <strtol+0x78>
		s += 2, base = 16;
  8010b0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010b4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010bb:	eb 28                	jmp    8010e5 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010c1:	75 15                	jne    8010d8 <strtol+0x93>
  8010c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c6:	8a 00                	mov    (%eax),%al
  8010c8:	3c 30                	cmp    $0x30,%al
  8010ca:	75 0c                	jne    8010d8 <strtol+0x93>
		s++, base = 8;
  8010cc:	ff 45 08             	incl   0x8(%ebp)
  8010cf:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010d6:	eb 0d                	jmp    8010e5 <strtol+0xa0>
	else if (base == 0)
  8010d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010dc:	75 07                	jne    8010e5 <strtol+0xa0>
		base = 10;
  8010de:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8010e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e8:	8a 00                	mov    (%eax),%al
  8010ea:	3c 2f                	cmp    $0x2f,%al
  8010ec:	7e 19                	jle    801107 <strtol+0xc2>
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f1:	8a 00                	mov    (%eax),%al
  8010f3:	3c 39                	cmp    $0x39,%al
  8010f5:	7f 10                	jg     801107 <strtol+0xc2>
			dig = *s - '0';
  8010f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fa:	8a 00                	mov    (%eax),%al
  8010fc:	0f be c0             	movsbl %al,%eax
  8010ff:	83 e8 30             	sub    $0x30,%eax
  801102:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801105:	eb 42                	jmp    801149 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801107:	8b 45 08             	mov    0x8(%ebp),%eax
  80110a:	8a 00                	mov    (%eax),%al
  80110c:	3c 60                	cmp    $0x60,%al
  80110e:	7e 19                	jle    801129 <strtol+0xe4>
  801110:	8b 45 08             	mov    0x8(%ebp),%eax
  801113:	8a 00                	mov    (%eax),%al
  801115:	3c 7a                	cmp    $0x7a,%al
  801117:	7f 10                	jg     801129 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801119:	8b 45 08             	mov    0x8(%ebp),%eax
  80111c:	8a 00                	mov    (%eax),%al
  80111e:	0f be c0             	movsbl %al,%eax
  801121:	83 e8 57             	sub    $0x57,%eax
  801124:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801127:	eb 20                	jmp    801149 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	8a 00                	mov    (%eax),%al
  80112e:	3c 40                	cmp    $0x40,%al
  801130:	7e 39                	jle    80116b <strtol+0x126>
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	8a 00                	mov    (%eax),%al
  801137:	3c 5a                	cmp    $0x5a,%al
  801139:	7f 30                	jg     80116b <strtol+0x126>
			dig = *s - 'A' + 10;
  80113b:	8b 45 08             	mov    0x8(%ebp),%eax
  80113e:	8a 00                	mov    (%eax),%al
  801140:	0f be c0             	movsbl %al,%eax
  801143:	83 e8 37             	sub    $0x37,%eax
  801146:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801149:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80114c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80114f:	7d 19                	jge    80116a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801151:	ff 45 08             	incl   0x8(%ebp)
  801154:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801157:	0f af 45 10          	imul   0x10(%ebp),%eax
  80115b:	89 c2                	mov    %eax,%edx
  80115d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801160:	01 d0                	add    %edx,%eax
  801162:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801165:	e9 7b ff ff ff       	jmp    8010e5 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80116a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80116b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80116f:	74 08                	je     801179 <strtol+0x134>
		*endptr = (char *) s;
  801171:	8b 45 0c             	mov    0xc(%ebp),%eax
  801174:	8b 55 08             	mov    0x8(%ebp),%edx
  801177:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801179:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80117d:	74 07                	je     801186 <strtol+0x141>
  80117f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801182:	f7 d8                	neg    %eax
  801184:	eb 03                	jmp    801189 <strtol+0x144>
  801186:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801189:	c9                   	leave  
  80118a:	c3                   	ret    

0080118b <ltostr>:

void
ltostr(long value, char *str)
{
  80118b:	55                   	push   %ebp
  80118c:	89 e5                	mov    %esp,%ebp
  80118e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801191:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801198:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80119f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011a3:	79 13                	jns    8011b8 <ltostr+0x2d>
	{
		neg = 1;
  8011a5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011af:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011b2:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011b5:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011c0:	99                   	cltd   
  8011c1:	f7 f9                	idiv   %ecx
  8011c3:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011c9:	8d 50 01             	lea    0x1(%eax),%edx
  8011cc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011cf:	89 c2                	mov    %eax,%edx
  8011d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d4:	01 d0                	add    %edx,%eax
  8011d6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011d9:	83 c2 30             	add    $0x30,%edx
  8011dc:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8011de:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011e1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011e6:	f7 e9                	imul   %ecx
  8011e8:	c1 fa 02             	sar    $0x2,%edx
  8011eb:	89 c8                	mov    %ecx,%eax
  8011ed:	c1 f8 1f             	sar    $0x1f,%eax
  8011f0:	29 c2                	sub    %eax,%edx
  8011f2:	89 d0                	mov    %edx,%eax
  8011f4:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8011f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011fa:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011ff:	f7 e9                	imul   %ecx
  801201:	c1 fa 02             	sar    $0x2,%edx
  801204:	89 c8                	mov    %ecx,%eax
  801206:	c1 f8 1f             	sar    $0x1f,%eax
  801209:	29 c2                	sub    %eax,%edx
  80120b:	89 d0                	mov    %edx,%eax
  80120d:	c1 e0 02             	shl    $0x2,%eax
  801210:	01 d0                	add    %edx,%eax
  801212:	01 c0                	add    %eax,%eax
  801214:	29 c1                	sub    %eax,%ecx
  801216:	89 ca                	mov    %ecx,%edx
  801218:	85 d2                	test   %edx,%edx
  80121a:	75 9c                	jne    8011b8 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80121c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801223:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801226:	48                   	dec    %eax
  801227:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80122a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80122e:	74 3d                	je     80126d <ltostr+0xe2>
		start = 1 ;
  801230:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801237:	eb 34                	jmp    80126d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801239:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80123c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123f:	01 d0                	add    %edx,%eax
  801241:	8a 00                	mov    (%eax),%al
  801243:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801246:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801249:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124c:	01 c2                	add    %eax,%edx
  80124e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801251:	8b 45 0c             	mov    0xc(%ebp),%eax
  801254:	01 c8                	add    %ecx,%eax
  801256:	8a 00                	mov    (%eax),%al
  801258:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80125a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80125d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801260:	01 c2                	add    %eax,%edx
  801262:	8a 45 eb             	mov    -0x15(%ebp),%al
  801265:	88 02                	mov    %al,(%edx)
		start++ ;
  801267:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80126a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80126d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801270:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801273:	7c c4                	jl     801239 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801275:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801278:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127b:	01 d0                	add    %edx,%eax
  80127d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801280:	90                   	nop
  801281:	c9                   	leave  
  801282:	c3                   	ret    

00801283 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801283:	55                   	push   %ebp
  801284:	89 e5                	mov    %esp,%ebp
  801286:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801289:	ff 75 08             	pushl  0x8(%ebp)
  80128c:	e8 54 fa ff ff       	call   800ce5 <strlen>
  801291:	83 c4 04             	add    $0x4,%esp
  801294:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801297:	ff 75 0c             	pushl  0xc(%ebp)
  80129a:	e8 46 fa ff ff       	call   800ce5 <strlen>
  80129f:	83 c4 04             	add    $0x4,%esp
  8012a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012b3:	eb 17                	jmp    8012cc <strcconcat+0x49>
		final[s] = str1[s] ;
  8012b5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bb:	01 c2                	add    %eax,%edx
  8012bd:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	01 c8                	add    %ecx,%eax
  8012c5:	8a 00                	mov    (%eax),%al
  8012c7:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012c9:	ff 45 fc             	incl   -0x4(%ebp)
  8012cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012cf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012d2:	7c e1                	jl     8012b5 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012d4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012db:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012e2:	eb 1f                	jmp    801303 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e7:	8d 50 01             	lea    0x1(%eax),%edx
  8012ea:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012ed:	89 c2                	mov    %eax,%edx
  8012ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f2:	01 c2                	add    %eax,%edx
  8012f4:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8012f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fa:	01 c8                	add    %ecx,%eax
  8012fc:	8a 00                	mov    (%eax),%al
  8012fe:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801300:	ff 45 f8             	incl   -0x8(%ebp)
  801303:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801306:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801309:	7c d9                	jl     8012e4 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80130b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80130e:	8b 45 10             	mov    0x10(%ebp),%eax
  801311:	01 d0                	add    %edx,%eax
  801313:	c6 00 00             	movb   $0x0,(%eax)
}
  801316:	90                   	nop
  801317:	c9                   	leave  
  801318:	c3                   	ret    

00801319 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801319:	55                   	push   %ebp
  80131a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80131c:	8b 45 14             	mov    0x14(%ebp),%eax
  80131f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801325:	8b 45 14             	mov    0x14(%ebp),%eax
  801328:	8b 00                	mov    (%eax),%eax
  80132a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801331:	8b 45 10             	mov    0x10(%ebp),%eax
  801334:	01 d0                	add    %edx,%eax
  801336:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80133c:	eb 0c                	jmp    80134a <strsplit+0x31>
			*string++ = 0;
  80133e:	8b 45 08             	mov    0x8(%ebp),%eax
  801341:	8d 50 01             	lea    0x1(%eax),%edx
  801344:	89 55 08             	mov    %edx,0x8(%ebp)
  801347:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80134a:	8b 45 08             	mov    0x8(%ebp),%eax
  80134d:	8a 00                	mov    (%eax),%al
  80134f:	84 c0                	test   %al,%al
  801351:	74 18                	je     80136b <strsplit+0x52>
  801353:	8b 45 08             	mov    0x8(%ebp),%eax
  801356:	8a 00                	mov    (%eax),%al
  801358:	0f be c0             	movsbl %al,%eax
  80135b:	50                   	push   %eax
  80135c:	ff 75 0c             	pushl  0xc(%ebp)
  80135f:	e8 13 fb ff ff       	call   800e77 <strchr>
  801364:	83 c4 08             	add    $0x8,%esp
  801367:	85 c0                	test   %eax,%eax
  801369:	75 d3                	jne    80133e <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	8a 00                	mov    (%eax),%al
  801370:	84 c0                	test   %al,%al
  801372:	74 5a                	je     8013ce <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801374:	8b 45 14             	mov    0x14(%ebp),%eax
  801377:	8b 00                	mov    (%eax),%eax
  801379:	83 f8 0f             	cmp    $0xf,%eax
  80137c:	75 07                	jne    801385 <strsplit+0x6c>
		{
			return 0;
  80137e:	b8 00 00 00 00       	mov    $0x0,%eax
  801383:	eb 66                	jmp    8013eb <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801385:	8b 45 14             	mov    0x14(%ebp),%eax
  801388:	8b 00                	mov    (%eax),%eax
  80138a:	8d 48 01             	lea    0x1(%eax),%ecx
  80138d:	8b 55 14             	mov    0x14(%ebp),%edx
  801390:	89 0a                	mov    %ecx,(%edx)
  801392:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801399:	8b 45 10             	mov    0x10(%ebp),%eax
  80139c:	01 c2                	add    %eax,%edx
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013a3:	eb 03                	jmp    8013a8 <strsplit+0x8f>
			string++;
  8013a5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ab:	8a 00                	mov    (%eax),%al
  8013ad:	84 c0                	test   %al,%al
  8013af:	74 8b                	je     80133c <strsplit+0x23>
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	8a 00                	mov    (%eax),%al
  8013b6:	0f be c0             	movsbl %al,%eax
  8013b9:	50                   	push   %eax
  8013ba:	ff 75 0c             	pushl  0xc(%ebp)
  8013bd:	e8 b5 fa ff ff       	call   800e77 <strchr>
  8013c2:	83 c4 08             	add    $0x8,%esp
  8013c5:	85 c0                	test   %eax,%eax
  8013c7:	74 dc                	je     8013a5 <strsplit+0x8c>
			string++;
	}
  8013c9:	e9 6e ff ff ff       	jmp    80133c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013ce:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d2:	8b 00                	mov    (%eax),%eax
  8013d4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013db:	8b 45 10             	mov    0x10(%ebp),%eax
  8013de:	01 d0                	add    %edx,%eax
  8013e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013e6:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8013eb:	c9                   	leave  
  8013ec:	c3                   	ret    

008013ed <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8013ed:	55                   	push   %ebp
  8013ee:	89 e5                	mov    %esp,%ebp
  8013f0:	57                   	push   %edi
  8013f1:	56                   	push   %esi
  8013f2:	53                   	push   %ebx
  8013f3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8013f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013fc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013ff:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801402:	8b 7d 18             	mov    0x18(%ebp),%edi
  801405:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801408:	cd 30                	int    $0x30
  80140a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80140d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801410:	83 c4 10             	add    $0x10,%esp
  801413:	5b                   	pop    %ebx
  801414:	5e                   	pop    %esi
  801415:	5f                   	pop    %edi
  801416:	5d                   	pop    %ebp
  801417:	c3                   	ret    

00801418 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
  80141b:	83 ec 04             	sub    $0x4,%esp
  80141e:	8b 45 10             	mov    0x10(%ebp),%eax
  801421:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801424:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801428:	8b 45 08             	mov    0x8(%ebp),%eax
  80142b:	6a 00                	push   $0x0
  80142d:	6a 00                	push   $0x0
  80142f:	52                   	push   %edx
  801430:	ff 75 0c             	pushl  0xc(%ebp)
  801433:	50                   	push   %eax
  801434:	6a 00                	push   $0x0
  801436:	e8 b2 ff ff ff       	call   8013ed <syscall>
  80143b:	83 c4 18             	add    $0x18,%esp
}
  80143e:	90                   	nop
  80143f:	c9                   	leave  
  801440:	c3                   	ret    

00801441 <sys_cgetc>:

int
sys_cgetc(void)
{
  801441:	55                   	push   %ebp
  801442:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	6a 01                	push   $0x1
  801450:	e8 98 ff ff ff       	call   8013ed <syscall>
  801455:	83 c4 18             	add    $0x18,%esp
}
  801458:	c9                   	leave  
  801459:	c3                   	ret    

0080145a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80145a:	55                   	push   %ebp
  80145b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	50                   	push   %eax
  801469:	6a 05                	push   $0x5
  80146b:	e8 7d ff ff ff       	call   8013ed <syscall>
  801470:	83 c4 18             	add    $0x18,%esp
}
  801473:	c9                   	leave  
  801474:	c3                   	ret    

00801475 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801475:	55                   	push   %ebp
  801476:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	6a 02                	push   $0x2
  801484:	e8 64 ff ff ff       	call   8013ed <syscall>
  801489:	83 c4 18             	add    $0x18,%esp
}
  80148c:	c9                   	leave  
  80148d:	c3                   	ret    

0080148e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 03                	push   $0x3
  80149d:	e8 4b ff ff ff       	call   8013ed <syscall>
  8014a2:	83 c4 18             	add    $0x18,%esp
}
  8014a5:	c9                   	leave  
  8014a6:	c3                   	ret    

008014a7 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8014a7:	55                   	push   %ebp
  8014a8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 04                	push   $0x4
  8014b6:	e8 32 ff ff ff       	call   8013ed <syscall>
  8014bb:	83 c4 18             	add    $0x18,%esp
}
  8014be:	c9                   	leave  
  8014bf:	c3                   	ret    

008014c0 <sys_env_exit>:


void sys_env_exit(void)
{
  8014c0:	55                   	push   %ebp
  8014c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 06                	push   $0x6
  8014cf:	e8 19 ff ff ff       	call   8013ed <syscall>
  8014d4:	83 c4 18             	add    $0x18,%esp
}
  8014d7:	90                   	nop
  8014d8:	c9                   	leave  
  8014d9:	c3                   	ret    

008014da <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8014da:	55                   	push   %ebp
  8014db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8014dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	52                   	push   %edx
  8014ea:	50                   	push   %eax
  8014eb:	6a 07                	push   $0x7
  8014ed:	e8 fb fe ff ff       	call   8013ed <syscall>
  8014f2:	83 c4 18             	add    $0x18,%esp
}
  8014f5:	c9                   	leave  
  8014f6:	c3                   	ret    

008014f7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8014f7:	55                   	push   %ebp
  8014f8:	89 e5                	mov    %esp,%ebp
  8014fa:	56                   	push   %esi
  8014fb:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8014fc:	8b 75 18             	mov    0x18(%ebp),%esi
  8014ff:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801502:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801505:	8b 55 0c             	mov    0xc(%ebp),%edx
  801508:	8b 45 08             	mov    0x8(%ebp),%eax
  80150b:	56                   	push   %esi
  80150c:	53                   	push   %ebx
  80150d:	51                   	push   %ecx
  80150e:	52                   	push   %edx
  80150f:	50                   	push   %eax
  801510:	6a 08                	push   $0x8
  801512:	e8 d6 fe ff ff       	call   8013ed <syscall>
  801517:	83 c4 18             	add    $0x18,%esp
}
  80151a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80151d:	5b                   	pop    %ebx
  80151e:	5e                   	pop    %esi
  80151f:	5d                   	pop    %ebp
  801520:	c3                   	ret    

00801521 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801521:	55                   	push   %ebp
  801522:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801524:	8b 55 0c             	mov    0xc(%ebp),%edx
  801527:	8b 45 08             	mov    0x8(%ebp),%eax
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	52                   	push   %edx
  801531:	50                   	push   %eax
  801532:	6a 09                	push   $0x9
  801534:	e8 b4 fe ff ff       	call   8013ed <syscall>
  801539:	83 c4 18             	add    $0x18,%esp
}
  80153c:	c9                   	leave  
  80153d:	c3                   	ret    

0080153e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80153e:	55                   	push   %ebp
  80153f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	ff 75 0c             	pushl  0xc(%ebp)
  80154a:	ff 75 08             	pushl  0x8(%ebp)
  80154d:	6a 0a                	push   $0xa
  80154f:	e8 99 fe ff ff       	call   8013ed <syscall>
  801554:	83 c4 18             	add    $0x18,%esp
}
  801557:	c9                   	leave  
  801558:	c3                   	ret    

00801559 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801559:	55                   	push   %ebp
  80155a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 0b                	push   $0xb
  801568:	e8 80 fe ff ff       	call   8013ed <syscall>
  80156d:	83 c4 18             	add    $0x18,%esp
}
  801570:	c9                   	leave  
  801571:	c3                   	ret    

00801572 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801572:	55                   	push   %ebp
  801573:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 0c                	push   $0xc
  801581:	e8 67 fe ff ff       	call   8013ed <syscall>
  801586:	83 c4 18             	add    $0x18,%esp
}
  801589:	c9                   	leave  
  80158a:	c3                   	ret    

0080158b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80158b:	55                   	push   %ebp
  80158c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 0d                	push   $0xd
  80159a:	e8 4e fe ff ff       	call   8013ed <syscall>
  80159f:	83 c4 18             	add    $0x18,%esp
}
  8015a2:	c9                   	leave  
  8015a3:	c3                   	ret    

008015a4 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015a4:	55                   	push   %ebp
  8015a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	ff 75 0c             	pushl  0xc(%ebp)
  8015b0:	ff 75 08             	pushl  0x8(%ebp)
  8015b3:	6a 11                	push   $0x11
  8015b5:	e8 33 fe ff ff       	call   8013ed <syscall>
  8015ba:	83 c4 18             	add    $0x18,%esp
	return;
  8015bd:	90                   	nop
}
  8015be:	c9                   	leave  
  8015bf:	c3                   	ret    

008015c0 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	ff 75 0c             	pushl  0xc(%ebp)
  8015cc:	ff 75 08             	pushl  0x8(%ebp)
  8015cf:	6a 12                	push   $0x12
  8015d1:	e8 17 fe ff ff       	call   8013ed <syscall>
  8015d6:	83 c4 18             	add    $0x18,%esp
	return ;
  8015d9:	90                   	nop
}
  8015da:	c9                   	leave  
  8015db:	c3                   	ret    

008015dc <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8015dc:	55                   	push   %ebp
  8015dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 0e                	push   $0xe
  8015eb:	e8 fd fd ff ff       	call   8013ed <syscall>
  8015f0:	83 c4 18             	add    $0x18,%esp
}
  8015f3:	c9                   	leave  
  8015f4:	c3                   	ret    

008015f5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8015f5:	55                   	push   %ebp
  8015f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	ff 75 08             	pushl  0x8(%ebp)
  801603:	6a 0f                	push   $0xf
  801605:	e8 e3 fd ff ff       	call   8013ed <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
}
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <sys_scarce_memory>:

void sys_scarce_memory()
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 10                	push   $0x10
  80161e:	e8 ca fd ff ff       	call   8013ed <syscall>
  801623:	83 c4 18             	add    $0x18,%esp
}
  801626:	90                   	nop
  801627:	c9                   	leave  
  801628:	c3                   	ret    

00801629 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801629:	55                   	push   %ebp
  80162a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 14                	push   $0x14
  801638:	e8 b0 fd ff ff       	call   8013ed <syscall>
  80163d:	83 c4 18             	add    $0x18,%esp
}
  801640:	90                   	nop
  801641:	c9                   	leave  
  801642:	c3                   	ret    

00801643 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801643:	55                   	push   %ebp
  801644:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 15                	push   $0x15
  801652:	e8 96 fd ff ff       	call   8013ed <syscall>
  801657:	83 c4 18             	add    $0x18,%esp
}
  80165a:	90                   	nop
  80165b:	c9                   	leave  
  80165c:	c3                   	ret    

0080165d <sys_cputc>:


void
sys_cputc(const char c)
{
  80165d:	55                   	push   %ebp
  80165e:	89 e5                	mov    %esp,%ebp
  801660:	83 ec 04             	sub    $0x4,%esp
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801669:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	50                   	push   %eax
  801676:	6a 16                	push   $0x16
  801678:	e8 70 fd ff ff       	call   8013ed <syscall>
  80167d:	83 c4 18             	add    $0x18,%esp
}
  801680:	90                   	nop
  801681:	c9                   	leave  
  801682:	c3                   	ret    

00801683 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801683:	55                   	push   %ebp
  801684:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	6a 17                	push   $0x17
  801692:	e8 56 fd ff ff       	call   8013ed <syscall>
  801697:	83 c4 18             	add    $0x18,%esp
}
  80169a:	90                   	nop
  80169b:	c9                   	leave  
  80169c:	c3                   	ret    

0080169d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80169d:	55                   	push   %ebp
  80169e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	ff 75 0c             	pushl  0xc(%ebp)
  8016ac:	50                   	push   %eax
  8016ad:	6a 18                	push   $0x18
  8016af:	e8 39 fd ff ff       	call   8013ed <syscall>
  8016b4:	83 c4 18             	add    $0x18,%esp
}
  8016b7:	c9                   	leave  
  8016b8:	c3                   	ret    

008016b9 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8016b9:	55                   	push   %ebp
  8016ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	52                   	push   %edx
  8016c9:	50                   	push   %eax
  8016ca:	6a 1b                	push   $0x1b
  8016cc:	e8 1c fd ff ff       	call   8013ed <syscall>
  8016d1:	83 c4 18             	add    $0x18,%esp
}
  8016d4:	c9                   	leave  
  8016d5:	c3                   	ret    

008016d6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8016d6:	55                   	push   %ebp
  8016d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	52                   	push   %edx
  8016e6:	50                   	push   %eax
  8016e7:	6a 19                	push   $0x19
  8016e9:	e8 ff fc ff ff       	call   8013ed <syscall>
  8016ee:	83 c4 18             	add    $0x18,%esp
}
  8016f1:	90                   	nop
  8016f2:	c9                   	leave  
  8016f3:	c3                   	ret    

008016f4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8016f4:	55                   	push   %ebp
  8016f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	52                   	push   %edx
  801704:	50                   	push   %eax
  801705:	6a 1a                	push   $0x1a
  801707:	e8 e1 fc ff ff       	call   8013ed <syscall>
  80170c:	83 c4 18             	add    $0x18,%esp
}
  80170f:	90                   	nop
  801710:	c9                   	leave  
  801711:	c3                   	ret    

00801712 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801712:	55                   	push   %ebp
  801713:	89 e5                	mov    %esp,%ebp
  801715:	83 ec 04             	sub    $0x4,%esp
  801718:	8b 45 10             	mov    0x10(%ebp),%eax
  80171b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80171e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801721:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	6a 00                	push   $0x0
  80172a:	51                   	push   %ecx
  80172b:	52                   	push   %edx
  80172c:	ff 75 0c             	pushl  0xc(%ebp)
  80172f:	50                   	push   %eax
  801730:	6a 1c                	push   $0x1c
  801732:	e8 b6 fc ff ff       	call   8013ed <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	c9                   	leave  
  80173b:	c3                   	ret    

0080173c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80173c:	55                   	push   %ebp
  80173d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80173f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	52                   	push   %edx
  80174c:	50                   	push   %eax
  80174d:	6a 1d                	push   $0x1d
  80174f:	e8 99 fc ff ff       	call   8013ed <syscall>
  801754:	83 c4 18             	add    $0x18,%esp
}
  801757:	c9                   	leave  
  801758:	c3                   	ret    

00801759 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801759:	55                   	push   %ebp
  80175a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80175c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80175f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801762:	8b 45 08             	mov    0x8(%ebp),%eax
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	51                   	push   %ecx
  80176a:	52                   	push   %edx
  80176b:	50                   	push   %eax
  80176c:	6a 1e                	push   $0x1e
  80176e:	e8 7a fc ff ff       	call   8013ed <syscall>
  801773:	83 c4 18             	add    $0x18,%esp
}
  801776:	c9                   	leave  
  801777:	c3                   	ret    

00801778 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80177b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177e:	8b 45 08             	mov    0x8(%ebp),%eax
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	52                   	push   %edx
  801788:	50                   	push   %eax
  801789:	6a 1f                	push   $0x1f
  80178b:	e8 5d fc ff ff       	call   8013ed <syscall>
  801790:	83 c4 18             	add    $0x18,%esp
}
  801793:	c9                   	leave  
  801794:	c3                   	ret    

00801795 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801795:	55                   	push   %ebp
  801796:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 20                	push   $0x20
  8017a4:	e8 44 fc ff ff       	call   8013ed <syscall>
  8017a9:	83 c4 18             	add    $0x18,%esp
}
  8017ac:	c9                   	leave  
  8017ad:	c3                   	ret    

008017ae <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8017ae:	55                   	push   %ebp
  8017af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8017b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	ff 75 10             	pushl  0x10(%ebp)
  8017bb:	ff 75 0c             	pushl  0xc(%ebp)
  8017be:	50                   	push   %eax
  8017bf:	6a 21                	push   $0x21
  8017c1:	e8 27 fc ff ff       	call   8013ed <syscall>
  8017c6:	83 c4 18             	add    $0x18,%esp
}
  8017c9:	c9                   	leave  
  8017ca:	c3                   	ret    

008017cb <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8017cb:	55                   	push   %ebp
  8017cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8017ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	50                   	push   %eax
  8017da:	6a 22                	push   $0x22
  8017dc:	e8 0c fc ff ff       	call   8013ed <syscall>
  8017e1:	83 c4 18             	add    $0x18,%esp
}
  8017e4:	90                   	nop
  8017e5:	c9                   	leave  
  8017e6:	c3                   	ret    

008017e7 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8017e7:	55                   	push   %ebp
  8017e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8017ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	50                   	push   %eax
  8017f6:	6a 23                	push   $0x23
  8017f8:	e8 f0 fb ff ff       	call   8013ed <syscall>
  8017fd:	83 c4 18             	add    $0x18,%esp
}
  801800:	90                   	nop
  801801:	c9                   	leave  
  801802:	c3                   	ret    

00801803 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801803:	55                   	push   %ebp
  801804:	89 e5                	mov    %esp,%ebp
  801806:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801809:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80180c:	8d 50 04             	lea    0x4(%eax),%edx
  80180f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	52                   	push   %edx
  801819:	50                   	push   %eax
  80181a:	6a 24                	push   $0x24
  80181c:	e8 cc fb ff ff       	call   8013ed <syscall>
  801821:	83 c4 18             	add    $0x18,%esp
	return result;
  801824:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801827:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80182a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80182d:	89 01                	mov    %eax,(%ecx)
  80182f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801832:	8b 45 08             	mov    0x8(%ebp),%eax
  801835:	c9                   	leave  
  801836:	c2 04 00             	ret    $0x4

00801839 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801839:	55                   	push   %ebp
  80183a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	ff 75 10             	pushl  0x10(%ebp)
  801843:	ff 75 0c             	pushl  0xc(%ebp)
  801846:	ff 75 08             	pushl  0x8(%ebp)
  801849:	6a 13                	push   $0x13
  80184b:	e8 9d fb ff ff       	call   8013ed <syscall>
  801850:	83 c4 18             	add    $0x18,%esp
	return ;
  801853:	90                   	nop
}
  801854:	c9                   	leave  
  801855:	c3                   	ret    

00801856 <sys_rcr2>:
uint32 sys_rcr2()
{
  801856:	55                   	push   %ebp
  801857:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 25                	push   $0x25
  801865:	e8 83 fb ff ff       	call   8013ed <syscall>
  80186a:	83 c4 18             	add    $0x18,%esp
}
  80186d:	c9                   	leave  
  80186e:	c3                   	ret    

0080186f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80186f:	55                   	push   %ebp
  801870:	89 e5                	mov    %esp,%ebp
  801872:	83 ec 04             	sub    $0x4,%esp
  801875:	8b 45 08             	mov    0x8(%ebp),%eax
  801878:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80187b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	50                   	push   %eax
  801888:	6a 26                	push   $0x26
  80188a:	e8 5e fb ff ff       	call   8013ed <syscall>
  80188f:	83 c4 18             	add    $0x18,%esp
	return ;
  801892:	90                   	nop
}
  801893:	c9                   	leave  
  801894:	c3                   	ret    

00801895 <rsttst>:
void rsttst()
{
  801895:	55                   	push   %ebp
  801896:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 28                	push   $0x28
  8018a4:	e8 44 fb ff ff       	call   8013ed <syscall>
  8018a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ac:	90                   	nop
}
  8018ad:	c9                   	leave  
  8018ae:	c3                   	ret    

008018af <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018af:	55                   	push   %ebp
  8018b0:	89 e5                	mov    %esp,%ebp
  8018b2:	83 ec 04             	sub    $0x4,%esp
  8018b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018bb:	8b 55 18             	mov    0x18(%ebp),%edx
  8018be:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018c2:	52                   	push   %edx
  8018c3:	50                   	push   %eax
  8018c4:	ff 75 10             	pushl  0x10(%ebp)
  8018c7:	ff 75 0c             	pushl  0xc(%ebp)
  8018ca:	ff 75 08             	pushl  0x8(%ebp)
  8018cd:	6a 27                	push   $0x27
  8018cf:	e8 19 fb ff ff       	call   8013ed <syscall>
  8018d4:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d7:	90                   	nop
}
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <chktst>:
void chktst(uint32 n)
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	ff 75 08             	pushl  0x8(%ebp)
  8018e8:	6a 29                	push   $0x29
  8018ea:	e8 fe fa ff ff       	call   8013ed <syscall>
  8018ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8018f2:	90                   	nop
}
  8018f3:	c9                   	leave  
  8018f4:	c3                   	ret    

008018f5 <inctst>:

void inctst()
{
  8018f5:	55                   	push   %ebp
  8018f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 2a                	push   $0x2a
  801904:	e8 e4 fa ff ff       	call   8013ed <syscall>
  801909:	83 c4 18             	add    $0x18,%esp
	return ;
  80190c:	90                   	nop
}
  80190d:	c9                   	leave  
  80190e:	c3                   	ret    

0080190f <gettst>:
uint32 gettst()
{
  80190f:	55                   	push   %ebp
  801910:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	6a 2b                	push   $0x2b
  80191e:	e8 ca fa ff ff       	call   8013ed <syscall>
  801923:	83 c4 18             	add    $0x18,%esp
}
  801926:	c9                   	leave  
  801927:	c3                   	ret    

00801928 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801928:	55                   	push   %ebp
  801929:	89 e5                	mov    %esp,%ebp
  80192b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 2c                	push   $0x2c
  80193a:	e8 ae fa ff ff       	call   8013ed <syscall>
  80193f:	83 c4 18             	add    $0x18,%esp
  801942:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801945:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801949:	75 07                	jne    801952 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80194b:	b8 01 00 00 00       	mov    $0x1,%eax
  801950:	eb 05                	jmp    801957 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801952:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801957:	c9                   	leave  
  801958:	c3                   	ret    

00801959 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801959:	55                   	push   %ebp
  80195a:	89 e5                	mov    %esp,%ebp
  80195c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 2c                	push   $0x2c
  80196b:	e8 7d fa ff ff       	call   8013ed <syscall>
  801970:	83 c4 18             	add    $0x18,%esp
  801973:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801976:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80197a:	75 07                	jne    801983 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80197c:	b8 01 00 00 00       	mov    $0x1,%eax
  801981:	eb 05                	jmp    801988 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801983:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801988:	c9                   	leave  
  801989:	c3                   	ret    

0080198a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80198a:	55                   	push   %ebp
  80198b:	89 e5                	mov    %esp,%ebp
  80198d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	6a 2c                	push   $0x2c
  80199c:	e8 4c fa ff ff       	call   8013ed <syscall>
  8019a1:	83 c4 18             	add    $0x18,%esp
  8019a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8019a7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8019ab:	75 07                	jne    8019b4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8019ad:	b8 01 00 00 00       	mov    $0x1,%eax
  8019b2:	eb 05                	jmp    8019b9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8019b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019b9:	c9                   	leave  
  8019ba:	c3                   	ret    

008019bb <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8019bb:	55                   	push   %ebp
  8019bc:	89 e5                	mov    %esp,%ebp
  8019be:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 2c                	push   $0x2c
  8019cd:	e8 1b fa ff ff       	call   8013ed <syscall>
  8019d2:	83 c4 18             	add    $0x18,%esp
  8019d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8019d8:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8019dc:	75 07                	jne    8019e5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8019de:	b8 01 00 00 00       	mov    $0x1,%eax
  8019e3:	eb 05                	jmp    8019ea <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8019e5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019ea:	c9                   	leave  
  8019eb:	c3                   	ret    

008019ec <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	ff 75 08             	pushl  0x8(%ebp)
  8019fa:	6a 2d                	push   $0x2d
  8019fc:	e8 ec f9 ff ff       	call   8013ed <syscall>
  801a01:	83 c4 18             	add    $0x18,%esp
	return ;
  801a04:	90                   	nop
}
  801a05:	c9                   	leave  
  801a06:	c3                   	ret    

00801a07 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801a07:	55                   	push   %ebp
  801a08:	89 e5                	mov    %esp,%ebp
  801a0a:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801a0d:	8b 55 08             	mov    0x8(%ebp),%edx
  801a10:	89 d0                	mov    %edx,%eax
  801a12:	c1 e0 02             	shl    $0x2,%eax
  801a15:	01 d0                	add    %edx,%eax
  801a17:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a1e:	01 d0                	add    %edx,%eax
  801a20:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a27:	01 d0                	add    %edx,%eax
  801a29:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a30:	01 d0                	add    %edx,%eax
  801a32:	c1 e0 04             	shl    $0x4,%eax
  801a35:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801a38:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801a3f:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801a42:	83 ec 0c             	sub    $0xc,%esp
  801a45:	50                   	push   %eax
  801a46:	e8 b8 fd ff ff       	call   801803 <sys_get_virtual_time>
  801a4b:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801a4e:	eb 41                	jmp    801a91 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801a50:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801a53:	83 ec 0c             	sub    $0xc,%esp
  801a56:	50                   	push   %eax
  801a57:	e8 a7 fd ff ff       	call   801803 <sys_get_virtual_time>
  801a5c:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801a5f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a62:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a65:	29 c2                	sub    %eax,%edx
  801a67:	89 d0                	mov    %edx,%eax
  801a69:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801a6c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a6f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a72:	89 d1                	mov    %edx,%ecx
  801a74:	29 c1                	sub    %eax,%ecx
  801a76:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801a79:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a7c:	39 c2                	cmp    %eax,%edx
  801a7e:	0f 97 c0             	seta   %al
  801a81:	0f b6 c0             	movzbl %al,%eax
  801a84:	29 c1                	sub    %eax,%ecx
  801a86:	89 c8                	mov    %ecx,%eax
  801a88:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801a8b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a94:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a97:	72 b7                	jb     801a50 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801a99:	90                   	nop
  801a9a:	c9                   	leave  
  801a9b:	c3                   	ret    

00801a9c <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801a9c:	55                   	push   %ebp
  801a9d:	89 e5                	mov    %esp,%ebp
  801a9f:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801aa2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801aa9:	eb 03                	jmp    801aae <busy_wait+0x12>
  801aab:	ff 45 fc             	incl   -0x4(%ebp)
  801aae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ab1:	3b 45 08             	cmp    0x8(%ebp),%eax
  801ab4:	72 f5                	jb     801aab <busy_wait+0xf>
	return i;
  801ab6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ab9:	c9                   	leave  
  801aba:	c3                   	ret    
  801abb:	90                   	nop

00801abc <__udivdi3>:
  801abc:	55                   	push   %ebp
  801abd:	57                   	push   %edi
  801abe:	56                   	push   %esi
  801abf:	53                   	push   %ebx
  801ac0:	83 ec 1c             	sub    $0x1c,%esp
  801ac3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ac7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801acb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801acf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ad3:	89 ca                	mov    %ecx,%edx
  801ad5:	89 f8                	mov    %edi,%eax
  801ad7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801adb:	85 f6                	test   %esi,%esi
  801add:	75 2d                	jne    801b0c <__udivdi3+0x50>
  801adf:	39 cf                	cmp    %ecx,%edi
  801ae1:	77 65                	ja     801b48 <__udivdi3+0x8c>
  801ae3:	89 fd                	mov    %edi,%ebp
  801ae5:	85 ff                	test   %edi,%edi
  801ae7:	75 0b                	jne    801af4 <__udivdi3+0x38>
  801ae9:	b8 01 00 00 00       	mov    $0x1,%eax
  801aee:	31 d2                	xor    %edx,%edx
  801af0:	f7 f7                	div    %edi
  801af2:	89 c5                	mov    %eax,%ebp
  801af4:	31 d2                	xor    %edx,%edx
  801af6:	89 c8                	mov    %ecx,%eax
  801af8:	f7 f5                	div    %ebp
  801afa:	89 c1                	mov    %eax,%ecx
  801afc:	89 d8                	mov    %ebx,%eax
  801afe:	f7 f5                	div    %ebp
  801b00:	89 cf                	mov    %ecx,%edi
  801b02:	89 fa                	mov    %edi,%edx
  801b04:	83 c4 1c             	add    $0x1c,%esp
  801b07:	5b                   	pop    %ebx
  801b08:	5e                   	pop    %esi
  801b09:	5f                   	pop    %edi
  801b0a:	5d                   	pop    %ebp
  801b0b:	c3                   	ret    
  801b0c:	39 ce                	cmp    %ecx,%esi
  801b0e:	77 28                	ja     801b38 <__udivdi3+0x7c>
  801b10:	0f bd fe             	bsr    %esi,%edi
  801b13:	83 f7 1f             	xor    $0x1f,%edi
  801b16:	75 40                	jne    801b58 <__udivdi3+0x9c>
  801b18:	39 ce                	cmp    %ecx,%esi
  801b1a:	72 0a                	jb     801b26 <__udivdi3+0x6a>
  801b1c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b20:	0f 87 9e 00 00 00    	ja     801bc4 <__udivdi3+0x108>
  801b26:	b8 01 00 00 00       	mov    $0x1,%eax
  801b2b:	89 fa                	mov    %edi,%edx
  801b2d:	83 c4 1c             	add    $0x1c,%esp
  801b30:	5b                   	pop    %ebx
  801b31:	5e                   	pop    %esi
  801b32:	5f                   	pop    %edi
  801b33:	5d                   	pop    %ebp
  801b34:	c3                   	ret    
  801b35:	8d 76 00             	lea    0x0(%esi),%esi
  801b38:	31 ff                	xor    %edi,%edi
  801b3a:	31 c0                	xor    %eax,%eax
  801b3c:	89 fa                	mov    %edi,%edx
  801b3e:	83 c4 1c             	add    $0x1c,%esp
  801b41:	5b                   	pop    %ebx
  801b42:	5e                   	pop    %esi
  801b43:	5f                   	pop    %edi
  801b44:	5d                   	pop    %ebp
  801b45:	c3                   	ret    
  801b46:	66 90                	xchg   %ax,%ax
  801b48:	89 d8                	mov    %ebx,%eax
  801b4a:	f7 f7                	div    %edi
  801b4c:	31 ff                	xor    %edi,%edi
  801b4e:	89 fa                	mov    %edi,%edx
  801b50:	83 c4 1c             	add    $0x1c,%esp
  801b53:	5b                   	pop    %ebx
  801b54:	5e                   	pop    %esi
  801b55:	5f                   	pop    %edi
  801b56:	5d                   	pop    %ebp
  801b57:	c3                   	ret    
  801b58:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b5d:	89 eb                	mov    %ebp,%ebx
  801b5f:	29 fb                	sub    %edi,%ebx
  801b61:	89 f9                	mov    %edi,%ecx
  801b63:	d3 e6                	shl    %cl,%esi
  801b65:	89 c5                	mov    %eax,%ebp
  801b67:	88 d9                	mov    %bl,%cl
  801b69:	d3 ed                	shr    %cl,%ebp
  801b6b:	89 e9                	mov    %ebp,%ecx
  801b6d:	09 f1                	or     %esi,%ecx
  801b6f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b73:	89 f9                	mov    %edi,%ecx
  801b75:	d3 e0                	shl    %cl,%eax
  801b77:	89 c5                	mov    %eax,%ebp
  801b79:	89 d6                	mov    %edx,%esi
  801b7b:	88 d9                	mov    %bl,%cl
  801b7d:	d3 ee                	shr    %cl,%esi
  801b7f:	89 f9                	mov    %edi,%ecx
  801b81:	d3 e2                	shl    %cl,%edx
  801b83:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b87:	88 d9                	mov    %bl,%cl
  801b89:	d3 e8                	shr    %cl,%eax
  801b8b:	09 c2                	or     %eax,%edx
  801b8d:	89 d0                	mov    %edx,%eax
  801b8f:	89 f2                	mov    %esi,%edx
  801b91:	f7 74 24 0c          	divl   0xc(%esp)
  801b95:	89 d6                	mov    %edx,%esi
  801b97:	89 c3                	mov    %eax,%ebx
  801b99:	f7 e5                	mul    %ebp
  801b9b:	39 d6                	cmp    %edx,%esi
  801b9d:	72 19                	jb     801bb8 <__udivdi3+0xfc>
  801b9f:	74 0b                	je     801bac <__udivdi3+0xf0>
  801ba1:	89 d8                	mov    %ebx,%eax
  801ba3:	31 ff                	xor    %edi,%edi
  801ba5:	e9 58 ff ff ff       	jmp    801b02 <__udivdi3+0x46>
  801baa:	66 90                	xchg   %ax,%ax
  801bac:	8b 54 24 08          	mov    0x8(%esp),%edx
  801bb0:	89 f9                	mov    %edi,%ecx
  801bb2:	d3 e2                	shl    %cl,%edx
  801bb4:	39 c2                	cmp    %eax,%edx
  801bb6:	73 e9                	jae    801ba1 <__udivdi3+0xe5>
  801bb8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801bbb:	31 ff                	xor    %edi,%edi
  801bbd:	e9 40 ff ff ff       	jmp    801b02 <__udivdi3+0x46>
  801bc2:	66 90                	xchg   %ax,%ax
  801bc4:	31 c0                	xor    %eax,%eax
  801bc6:	e9 37 ff ff ff       	jmp    801b02 <__udivdi3+0x46>
  801bcb:	90                   	nop

00801bcc <__umoddi3>:
  801bcc:	55                   	push   %ebp
  801bcd:	57                   	push   %edi
  801bce:	56                   	push   %esi
  801bcf:	53                   	push   %ebx
  801bd0:	83 ec 1c             	sub    $0x1c,%esp
  801bd3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801bd7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801bdb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801bdf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801be3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801be7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801beb:	89 f3                	mov    %esi,%ebx
  801bed:	89 fa                	mov    %edi,%edx
  801bef:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bf3:	89 34 24             	mov    %esi,(%esp)
  801bf6:	85 c0                	test   %eax,%eax
  801bf8:	75 1a                	jne    801c14 <__umoddi3+0x48>
  801bfa:	39 f7                	cmp    %esi,%edi
  801bfc:	0f 86 a2 00 00 00    	jbe    801ca4 <__umoddi3+0xd8>
  801c02:	89 c8                	mov    %ecx,%eax
  801c04:	89 f2                	mov    %esi,%edx
  801c06:	f7 f7                	div    %edi
  801c08:	89 d0                	mov    %edx,%eax
  801c0a:	31 d2                	xor    %edx,%edx
  801c0c:	83 c4 1c             	add    $0x1c,%esp
  801c0f:	5b                   	pop    %ebx
  801c10:	5e                   	pop    %esi
  801c11:	5f                   	pop    %edi
  801c12:	5d                   	pop    %ebp
  801c13:	c3                   	ret    
  801c14:	39 f0                	cmp    %esi,%eax
  801c16:	0f 87 ac 00 00 00    	ja     801cc8 <__umoddi3+0xfc>
  801c1c:	0f bd e8             	bsr    %eax,%ebp
  801c1f:	83 f5 1f             	xor    $0x1f,%ebp
  801c22:	0f 84 ac 00 00 00    	je     801cd4 <__umoddi3+0x108>
  801c28:	bf 20 00 00 00       	mov    $0x20,%edi
  801c2d:	29 ef                	sub    %ebp,%edi
  801c2f:	89 fe                	mov    %edi,%esi
  801c31:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c35:	89 e9                	mov    %ebp,%ecx
  801c37:	d3 e0                	shl    %cl,%eax
  801c39:	89 d7                	mov    %edx,%edi
  801c3b:	89 f1                	mov    %esi,%ecx
  801c3d:	d3 ef                	shr    %cl,%edi
  801c3f:	09 c7                	or     %eax,%edi
  801c41:	89 e9                	mov    %ebp,%ecx
  801c43:	d3 e2                	shl    %cl,%edx
  801c45:	89 14 24             	mov    %edx,(%esp)
  801c48:	89 d8                	mov    %ebx,%eax
  801c4a:	d3 e0                	shl    %cl,%eax
  801c4c:	89 c2                	mov    %eax,%edx
  801c4e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c52:	d3 e0                	shl    %cl,%eax
  801c54:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c58:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c5c:	89 f1                	mov    %esi,%ecx
  801c5e:	d3 e8                	shr    %cl,%eax
  801c60:	09 d0                	or     %edx,%eax
  801c62:	d3 eb                	shr    %cl,%ebx
  801c64:	89 da                	mov    %ebx,%edx
  801c66:	f7 f7                	div    %edi
  801c68:	89 d3                	mov    %edx,%ebx
  801c6a:	f7 24 24             	mull   (%esp)
  801c6d:	89 c6                	mov    %eax,%esi
  801c6f:	89 d1                	mov    %edx,%ecx
  801c71:	39 d3                	cmp    %edx,%ebx
  801c73:	0f 82 87 00 00 00    	jb     801d00 <__umoddi3+0x134>
  801c79:	0f 84 91 00 00 00    	je     801d10 <__umoddi3+0x144>
  801c7f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c83:	29 f2                	sub    %esi,%edx
  801c85:	19 cb                	sbb    %ecx,%ebx
  801c87:	89 d8                	mov    %ebx,%eax
  801c89:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c8d:	d3 e0                	shl    %cl,%eax
  801c8f:	89 e9                	mov    %ebp,%ecx
  801c91:	d3 ea                	shr    %cl,%edx
  801c93:	09 d0                	or     %edx,%eax
  801c95:	89 e9                	mov    %ebp,%ecx
  801c97:	d3 eb                	shr    %cl,%ebx
  801c99:	89 da                	mov    %ebx,%edx
  801c9b:	83 c4 1c             	add    $0x1c,%esp
  801c9e:	5b                   	pop    %ebx
  801c9f:	5e                   	pop    %esi
  801ca0:	5f                   	pop    %edi
  801ca1:	5d                   	pop    %ebp
  801ca2:	c3                   	ret    
  801ca3:	90                   	nop
  801ca4:	89 fd                	mov    %edi,%ebp
  801ca6:	85 ff                	test   %edi,%edi
  801ca8:	75 0b                	jne    801cb5 <__umoddi3+0xe9>
  801caa:	b8 01 00 00 00       	mov    $0x1,%eax
  801caf:	31 d2                	xor    %edx,%edx
  801cb1:	f7 f7                	div    %edi
  801cb3:	89 c5                	mov    %eax,%ebp
  801cb5:	89 f0                	mov    %esi,%eax
  801cb7:	31 d2                	xor    %edx,%edx
  801cb9:	f7 f5                	div    %ebp
  801cbb:	89 c8                	mov    %ecx,%eax
  801cbd:	f7 f5                	div    %ebp
  801cbf:	89 d0                	mov    %edx,%eax
  801cc1:	e9 44 ff ff ff       	jmp    801c0a <__umoddi3+0x3e>
  801cc6:	66 90                	xchg   %ax,%ax
  801cc8:	89 c8                	mov    %ecx,%eax
  801cca:	89 f2                	mov    %esi,%edx
  801ccc:	83 c4 1c             	add    $0x1c,%esp
  801ccf:	5b                   	pop    %ebx
  801cd0:	5e                   	pop    %esi
  801cd1:	5f                   	pop    %edi
  801cd2:	5d                   	pop    %ebp
  801cd3:	c3                   	ret    
  801cd4:	3b 04 24             	cmp    (%esp),%eax
  801cd7:	72 06                	jb     801cdf <__umoddi3+0x113>
  801cd9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801cdd:	77 0f                	ja     801cee <__umoddi3+0x122>
  801cdf:	89 f2                	mov    %esi,%edx
  801ce1:	29 f9                	sub    %edi,%ecx
  801ce3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ce7:	89 14 24             	mov    %edx,(%esp)
  801cea:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cee:	8b 44 24 04          	mov    0x4(%esp),%eax
  801cf2:	8b 14 24             	mov    (%esp),%edx
  801cf5:	83 c4 1c             	add    $0x1c,%esp
  801cf8:	5b                   	pop    %ebx
  801cf9:	5e                   	pop    %esi
  801cfa:	5f                   	pop    %edi
  801cfb:	5d                   	pop    %ebp
  801cfc:	c3                   	ret    
  801cfd:	8d 76 00             	lea    0x0(%esi),%esi
  801d00:	2b 04 24             	sub    (%esp),%eax
  801d03:	19 fa                	sbb    %edi,%edx
  801d05:	89 d1                	mov    %edx,%ecx
  801d07:	89 c6                	mov    %eax,%esi
  801d09:	e9 71 ff ff ff       	jmp    801c7f <__umoddi3+0xb3>
  801d0e:	66 90                	xchg   %ax,%ax
  801d10:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d14:	72 ea                	jb     801d00 <__umoddi3+0x134>
  801d16:	89 d9                	mov    %ebx,%ecx
  801d18:	e9 62 ff ff ff       	jmp    801c7f <__umoddi3+0xb3>
