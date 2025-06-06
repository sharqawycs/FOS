#include <inc/lib.h>

void _main(void)
{	
	
	rsttst();
	
	

	int Mega = 1024*1024;
	int kilo = 1024;
	void* ptr_allocations[20] = {0};
	int freeFrames ;
	//[1] Allocate all
	{
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[0] = malloc(1*Mega-kilo);
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 256+1 ,0, 'e', 0);

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[1] = malloc(1*Mega-kilo);
		tst((uint32) ptr_allocations[1], USER_HEAP_START + 1*Mega,USER_HEAP_START + 1*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 256 ,0, 'e', 0);

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[2] = malloc(1*Mega-kilo);
		tst((uint32) ptr_allocations[2], USER_HEAP_START + 2*Mega,USER_HEAP_START + 2*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 256 ,0, 'e', 0);

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[3] = malloc(1*Mega-kilo);
		tst((uint32) ptr_allocations[3], USER_HEAP_START + 3*Mega,USER_HEAP_START + 3*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 256 ,0, 'e', 0);

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[4] = malloc(2*Mega-kilo);
		tst((uint32) ptr_allocations[4], USER_HEAP_START + 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[5] = malloc(2*Mega-kilo);
		tst((uint32) ptr_allocations[5], USER_HEAP_START + 6*Mega,USER_HEAP_START + 6*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[6] = malloc(3*Mega-kilo);
		tst((uint32) ptr_allocations[6], USER_HEAP_START + 8*Mega,USER_HEAP_START + 8*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 768+1 ,0, 'e', 0);

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[7] = malloc(3*Mega-kilo);
		tst((uint32) ptr_allocations[7], USER_HEAP_START + 11*Mega,USER_HEAP_START + 11*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 768+1 ,0, 'e', 0);
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[1]);
		tst((sys_calculate_free_frames() - freeFrames) , 256,0, 'e', 0);

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[4]);
		tst((sys_calculate_free_frames() - freeFrames) , 512,0, 'e', 0);

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[6]);
		tst((sys_calculate_free_frames() - freeFrames) , 768,0, 'e', 0);
	}

	//[3] Allocate again [test first fit]
	{
		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[8] = malloc(512*kilo - kilo);
		tst((uint32) ptr_allocations[8], USER_HEAP_START + 1*Mega,USER_HEAP_START + 1*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 128 ,0, 'e', 0);

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[9] = malloc(1*Mega - kilo);
		tst((uint32) ptr_allocations[9], USER_HEAP_START + 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 256,0, 'e', 0);

		//Allocate 256 KB - should be placed in remaining of 1st hole
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[10] = malloc(256*kilo - kilo);
		tst((uint32) ptr_allocations[10], USER_HEAP_START + 1*Mega + 512*kilo,USER_HEAP_START + 1*Mega + 512*kilo + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 64,0, 'e', 0);

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[11] = malloc(4*Mega - kilo);
		tst((uint32) ptr_allocations[11], USER_HEAP_START + 14*Mega,USER_HEAP_START + 14*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 1024 + 1,0, 'e', 0);
	}

	//[4] Free contiguous allocations
	{
		//1 MB Hole appended to previous 256 KB hole
		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[2]);
		tst((sys_calculate_free_frames() - freeFrames) , 256,0, 'e', 0);

		//Next 1 MB Hole appended also
		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[3]);
		tst((sys_calculate_free_frames() - freeFrames) , 256,0, 'e', 0);
	}

	//[5] Allocate again [test first fit]
	{
		//Allocate 2 MB + 128 KB - should be placed in the contiguous hole (256 KB + 2 MB)
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[12] = malloc(2*Mega + 128*kilo - kilo);
		tst((uint32) ptr_allocations[12], USER_HEAP_START + 1*Mega+ 768*kilo,USER_HEAP_START + 1*Mega+ 768*kilo + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 512+32,0, 'e', 0);
	}

	chktst(31);

	return;
}
