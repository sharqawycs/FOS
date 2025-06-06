#include <inc/lib.h>

void _main(void)
{	
	

	rsttst();
	//Bypass the PAGE FAULT on <MOVB immediate, reg> instruction by setting its length
	//and continue executing the remaining code
	sys_bypassPageFault(3);


	
	

	int Mega = 1024*1024;
	int kilo = 1024;

	int start_freeFrames = sys_calculate_free_frames() ;

	//ALLOCATE ALL
	void* ptr_allocations[20] = {0};
	int lastIndices[20] = {0};
	{
		int freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[0] = malloc(2*Mega-kilo);
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
		lastIndices[0] = (2*Mega-kilo)/sizeof(char) - 1;

		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[1] = malloc(2*Mega-kilo);
		tst((uint32) ptr_allocations[1], USER_HEAP_START+ 2*Mega,USER_HEAP_START + 2*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);
		lastIndices[1] = (2*Mega-kilo)/sizeof(char) - 1;


		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[2] = malloc(2*kilo);
		tst((uint32) ptr_allocations[2], USER_HEAP_START+ 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 1+1 ,0, 'e', 0);
		lastIndices[2] = (2*kilo)/sizeof(char) - 1;


		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[3] = malloc(2*kilo);
		tst((uint32) ptr_allocations[3], USER_HEAP_START+ 4*Mega + 4*kilo,USER_HEAP_START + 4*Mega + 4*kilo + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 1 ,0, 'e', 0);
		lastIndices[3] = (2*kilo)/sizeof(char) - 1;


		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[4] = malloc(7*kilo);
		tst((uint32) ptr_allocations[4], USER_HEAP_START+ 4*Mega + 8*kilo,USER_HEAP_START + 4*Mega + 8*kilo + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 2 ,0, 'e', 0);
		lastIndices[4] = (7*kilo)/sizeof(char) - 1;


		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[5] = malloc(3*Mega-kilo);
		tst((uint32) ptr_allocations[5], USER_HEAP_START+ 4*Mega + 16*kilo,USER_HEAP_START + 4*Mega + 16*kilo + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 3*Mega/4096 ,0, 'e', 0);
		lastIndices[5] = (3*Mega - kilo)/sizeof(char) - 1;


		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[6] = malloc(2*Mega-kilo);
		tst((uint32) ptr_allocations[6], USER_HEAP_START+ 7*Mega + 16*kilo,USER_HEAP_START + 7*Mega + 16*kilo + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
		lastIndices[6] = (2*Mega - kilo)/sizeof(char) - 1;
	}

	char x ;
	int y;
	char *byteArr ;
	//FREE ALL
	{
		int freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[0]);
		tst((sys_calculate_free_frames() - freeFrames) , 512 ,0, 'e', 0);
		byteArr = (char *) ptr_allocations[0];
		byteArr[0] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
		byteArr[lastIndices[0]] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[0]]) ,0, 'e', 0);

		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[1]);
		tst((sys_calculate_free_frames() - freeFrames) , 512 +1,0, 'e', 0);
		byteArr = (char *) ptr_allocations[1];
		byteArr[0] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
		byteArr[lastIndices[1]] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[1]]) ,0, 'e', 0);

		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[2]);
		tst((sys_calculate_free_frames() - freeFrames) , 1 ,0, 'e', 0);
		byteArr = (char *) ptr_allocations[2];
		byteArr[0] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
		byteArr[lastIndices[2]] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[2]]) ,0, 'e', 0);

		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[3]);
		tst((sys_calculate_free_frames() - freeFrames) , 1 ,0, 'e', 0);
		byteArr = (char *) ptr_allocations[3];
		byteArr[0] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
		byteArr[lastIndices[3]] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[3]]) ,0, 'e', 0);

		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[4]);
		tst((sys_calculate_free_frames() - freeFrames) , 2 ,0, 'e', 0);
		byteArr = (char *) ptr_allocations[4];
		byteArr[0] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
		byteArr[lastIndices[4]] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[4]]) ,0, 'e', 0);

		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[5]);
		tst((sys_calculate_free_frames() - freeFrames) , 3*Mega/4096 ,0, 'e', 0);
		byteArr = (char *) ptr_allocations[5];
		byteArr[0] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
		byteArr[lastIndices[5]] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[5]]) ,0, 'e', 0);

		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[6]);
		tst((sys_calculate_free_frames() - freeFrames) , 512+2,0, 'e', 0);
		byteArr = (char *) ptr_allocations[6];
		byteArr[0] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[0]) ,0, 'e', 0);
		byteArr[lastIndices[6]] = 10;
		tst(sys_rcr2(), (uint32)&(byteArr[lastIndices[6]]) ,0, 'e', 0);

		tst(start_freeFrames, sys_calculate_free_frames() ,0, 'e', 0);
	}

	//set it to 0 again to cancel the bypassing option
	sys_bypassPageFault(0);

	chktst(36);

	return;
}
